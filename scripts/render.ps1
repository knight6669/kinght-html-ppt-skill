# kinght-html-ppt-skill :: render.ps1 - headless Chrome/Edge screenshot(s)
#
# Usage:
#   .\scripts\render.ps1 <html-file>                      # one PNG, slide 1
#   .\scripts\render.ps1 <html-file> 12                   # 12 PNGs, slides 1..12
#   .\scripts\render.ps1 <html-file> all                  # autodetect .slide count
#   .\scripts\render.ps1 <html-file> 12 <out-dir>         # custom output dir
#   .\scripts\render.ps1 <html-file> 1 <out-file.png>     # custom one-shot output
#
# Browser lookup order: -BrowserPath, HTML_PPT_BROWSER, CHROME_PATH, EDGE_PATH,
# common Chrome install paths, common Edge install paths, then PATH.

[CmdletBinding()]
param(
  [Parameter(Mandatory = $true, Position = 0)]
  [string]$HtmlFile,

  [Parameter(Position = 1)]
  [string]$SlideCount = "1",

  [Parameter(Position = 2)]
  [string]$Output,

  [int]$Width = 1920,

  [int]$Height = 1080,

  [string]$BrowserPath
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

function Resolve-Browser {
  param([string]$PreferredPath)

  $candidates = New-Object System.Collections.Generic.List[string]

  if (-not [string]::IsNullOrWhiteSpace($PreferredPath)) {
    $candidates.Add($PreferredPath)
  }

  foreach ($envName in @("HTML_PPT_BROWSER", "CHROME_PATH", "EDGE_PATH")) {
    $value = [Environment]::GetEnvironmentVariable($envName)
    if (-not [string]::IsNullOrWhiteSpace($value)) {
      $candidates.Add($value)
    }
  }

  $programFilesX86 = [Environment]::GetEnvironmentVariable("ProgramFiles(x86)")
  foreach ($path in @(
      (Join-Path $env:ProgramFiles "Google\Chrome\Application\chrome.exe"),
      $(if ($programFilesX86) { Join-Path $programFilesX86 "Google\Chrome\Application\chrome.exe" }),
      (Join-Path $env:LOCALAPPDATA "Google\Chrome\Application\chrome.exe"),
      (Join-Path $env:ProgramFiles "Microsoft\Edge\Application\msedge.exe"),
      $(if ($programFilesX86) { Join-Path $programFilesX86 "Microsoft\Edge\Application\msedge.exe" }),
      (Join-Path $env:LOCALAPPDATA "Microsoft\Edge\Application\msedge.exe")
    )) {
    if (-not [string]::IsNullOrWhiteSpace($path)) {
      $candidates.Add($path)
    }
  }

  foreach ($commandName in @("chrome.exe", "msedge.exe", "chrome", "msedge")) {
    $command = Get-Command $commandName -ErrorAction SilentlyContinue
    if ($command) {
      $candidates.Add($command.Source)
    }
  }

  foreach ($candidate in $candidates) {
    if (Test-Path -LiteralPath $candidate -PathType Leaf) {
      return (Resolve-Path -LiteralPath $candidate).ProviderPath
    }
  }

  throw "Chrome or Edge was not found. Install one of them, set HTML_PPT_BROWSER, or pass -BrowserPath."
}

function Get-SlideTotal {
  param([string]$Path)

  $content = Get-Content -LiteralPath $Path -Raw -Encoding UTF8
  $classPattern = 'class\s*=\s*(["''])(.*?)\1'
  $classMatches = [regex]::Matches($content, $classPattern, [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)
  $count = 0

  foreach ($match in $classMatches) {
    $classes = $match.Groups[2].Value -split '\s+'
    if ($classes -contains "slide") {
      $count += 1
    }
  }

  if ($count -lt 1) {
    return 1
  }
  return $count
}

function Join-ProcessArguments {
  param([string[]]$Arguments)

  $escaped = foreach ($arg in $Arguments) {
    if ($null -eq $arg) {
      '""'
      continue
    }

    if ($arg -notmatch '[\s"]') {
      $arg
      continue
    }

    $result = '"'
    $backslashes = 0

    foreach ($char in $arg.ToCharArray()) {
      if ($char -eq '\') {
        $backslashes += 1
      } elseif ($char -eq '"') {
        if ($backslashes -gt 0) {
          $result += '\' * ($backslashes * 2)
          $backslashes = 0
        }
        $result += '\"'
      } else {
        if ($backslashes -gt 0) {
          $result += '\' * $backslashes
          $backslashes = 0
        }
        $result += $char
      }
    }

    if ($backslashes -gt 0) {
      $result += '\' * ($backslashes * 2)
    }

    $result += '"'
    $result
  }

  return ($escaped -join " ")
}

function Get-OutputFileForSingleSlide {
  param(
    [string]$HtmlPath,
    [string]$OutputPath
  )

  $dir = Split-Path -Parent $HtmlPath
  $stem = [System.IO.Path]::GetFileNameWithoutExtension($HtmlPath)

  if ([string]::IsNullOrWhiteSpace($OutputPath)) {
    return (Join-Path $dir "$stem.png")
  }

  if ((Test-Path -LiteralPath $OutputPath -PathType Container) -or $OutputPath.EndsWith("\") -or $OutputPath.EndsWith("/")) {
    New-Item -ItemType Directory -Path $OutputPath -Force | Out-Null
    return (Join-Path $OutputPath "$stem.png")
  }

  $parent = Split-Path -Parent $OutputPath
  if (-not [string]::IsNullOrWhiteSpace($parent)) {
    New-Item -ItemType Directory -Path $parent -Force | Out-Null
  }
  return $OutputPath
}

function Invoke-RenderOne {
  param(
    [string]$Browser,
    [string]$Url,
    [string]$Target,
    [string]$UserDataDir
  )

  $targetFull = [System.IO.Path]::GetFullPath($Target)
  $targetParent = Split-Path -Parent $targetFull
  if (-not [string]::IsNullOrWhiteSpace($targetParent)) {
    New-Item -ItemType Directory -Path $targetParent -Force | Out-Null
  }

  $args = @(
    "--headless=new",
    "--disable-gpu",
    "--hide-scrollbars",
    "--no-sandbox",
    "--allow-file-access-from-files",
    "--disable-background-networking",
    "--virtual-time-budget=4000",
    "--window-size=$Width,$Height",
    "--user-data-dir=$UserDataDir",
    "--screenshot=$targetFull",
    $Url
  )

  $psi = New-Object System.Diagnostics.ProcessStartInfo
  $psi.FileName = $Browser
  $psi.Arguments = Join-ProcessArguments -Arguments $args
  $psi.UseShellExecute = $false
  $psi.RedirectStandardOutput = $true
  $psi.RedirectStandardError = $true
  $psi.CreateNoWindow = $true

  $process = New-Object System.Diagnostics.Process
  $process.StartInfo = $psi

  [void]$process.Start()
  $stdoutTask = $process.StandardOutput.ReadToEndAsync()
  $stderrTask = $process.StandardError.ReadToEndAsync()
  $process.WaitForExit()
  $stdout = $stdoutTask.Result
  $stderr = $stderrTask.Result

  if ($process.ExitCode -ne 0) {
    throw "Browser render failed for $Url`n$stdout`n$stderr"
  }

  if (-not (Test-Path -LiteralPath $targetFull -PathType Leaf)) {
    throw "Browser finished without creating screenshot: $targetFull`n$stdout`n$stderr"
  }

  Write-Host "rendered $targetFull"
}

if (-not (Test-Path -LiteralPath $HtmlFile -PathType Leaf)) {
  throw "HTML file not found: $HtmlFile"
}

$htmlPath = (Resolve-Path -LiteralPath $HtmlFile).ProviderPath
$browser = Resolve-Browser -PreferredPath $BrowserPath

if ($SlideCount -eq "all") {
  $count = Get-SlideTotal -Path $htmlPath
} else {
  [int]$count = 0
  if (-not [int]::TryParse($SlideCount, [ref]$count) -or $count -lt 1) {
    throw "Slide count must be a positive integer or 'all'."
  }
}

$fileUri = [System.Uri]::new($htmlPath).AbsoluteUri
$stem = [System.IO.Path]::GetFileNameWithoutExtension($htmlPath)
$htmlDir = Split-Path -Parent $htmlPath
$tempProfile = Join-Path ([System.IO.Path]::GetTempPath()) ("html-ppt-render-" + [System.Guid]::NewGuid().ToString("N"))

New-Item -ItemType Directory -Path $tempProfile -Force | Out-Null

try {
  if ($count -eq 1) {
    $outFile = Get-OutputFileForSingleSlide -HtmlPath $htmlPath -OutputPath $Output
    Invoke-RenderOne -Browser $browser -Url $fileUri -Target $outFile -UserDataDir $tempProfile
  } else {
    if ([string]::IsNullOrWhiteSpace($Output)) {
      $outDir = Join-Path $htmlDir "$stem-png"
    } else {
      $outDir = $Output
    }

    New-Item -ItemType Directory -Path $outDir -Force | Out-Null

    for ($i = 1; $i -le $count; $i++) {
      $target = Join-Path $outDir ("{0}_{1:D2}.png" -f $stem, $i)
      Invoke-RenderOne -Browser $browser -Url "$fileUri#/$i" -Target $target -UserDataDir $tempProfile
    }
  }
} finally {
  Remove-Item -LiteralPath $tempProfile -Recurse -Force -ErrorAction SilentlyContinue
}

Write-Host "done: rendered $count slide(s) from $htmlPath"
