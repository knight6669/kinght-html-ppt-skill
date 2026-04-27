---
name: knight-html-ppt-skill
description: HTML PPT Studio — author professional static HTML presentations in many styles, layouts, and animations, all driven by templates. Use when the user asks for a presentation, PPT, slides, keynote, deck, slideshow, "幻灯片", "演讲稿", "做一份 PPT", "做一份 slides", a reveal-style HTML deck, a 小红书 图文, or any kind of multi-slide pitch/report/sharing document that should look tasteful and be usable with keyboard navigation. Triggers include keywords like "presentation", "ppt", "slides", "deck", "keynote", "reveal", "slideshow", "幻灯片", "演讲稿", "分享稿", "小红书图文", "talk slides", "pitch deck", "tech sharing", "technical presentation".
---

# knight-html-ppt-skill — HTML PPT Studio

Author professional HTML presentations as static files. One theme file = one
look. One layout file = one page type. One animation class = one entry effect.
All pages share a token-based design system in `assets/base.css`.

## Install

```bash
npx skills add https://github.com/knight6669/knight-html-ppt-skill
```

One command, no build. Pure static HTML/CSS/JS with only CDN webfonts.

## What the skill gives you

- **36 themes** (`assets/themes/*.css`) — minimal-white, editorial-serif, soft-pastel, sharp-mono, arctic-cool, sunset-warm, catppuccin-latte/mocha, dracula, tokyo-night, nord, solarized-light, gruvbox-dark, rose-pine, neo-brutalism, glassmorphism, bauhaus, swiss-grid, terminal-green, xiaohongshu-white, rainbow-gradient, aurora, blueprint, memphis-pop, cyberpunk-neon, y2k-chrome, retro-tv, japanese-minimal, vaporwave, midcentury, corporate-clean, academic-paper, news-broadcast, pitch-deck-vc, magazine-bold, engineering-whiteprint
- **15 full-deck templates** (`templates/full-decks/<name>/`) — complete multi-slide decks with scoped `.tpl-<name>` CSS. 8 extracted from real-world decks (xhs-white-editorial, graphify-dark-graph, knowledge-arch-blueprint, hermes-cyber-terminal, obsidian-claude-gradient, testing-safety-alert, xhs-pastel-card, dir-key-nav-minimal), 7 scenario scaffolds (pitch-deck, product-launch, tech-sharing, weekly-report, xhs-post 3:4, course-module, **presenter-mode-reveal** — 演讲者模式专用)
- **31 layouts** (`templates/single-page/*.html`) with realistic demo data
- **27 CSS animations** (`assets/animations/animations.css`) via `data-anim`
- **20 canvas FX animations** (`assets/animations/fx/*.js`) via `data-fx` — particle-burst, confetti-cannon, firework, starfield, matrix-rain, knowledge-graph (force-directed), neural-net (pulses), constellation, orbit-ring, galaxy-swirl, word-cascade, letter-explode, chain-react, magnetic-field, data-stream, gradient-blob, sparkle-trail, shockwave, typewriter-multi, counter-explosion
- **Keyboard + wheel runtime** (`assets/runtime.js`) — arrows, mouse wheel, T (theme), A (anim), F/O/E, **S (presenter mode: magnetic-card popup with CURRENT / NEXT / SCRIPT / TIMER cards)**, N (notes drawer), R (reset timer in presenter). The E-key page navigator is compact, token-based, and theme-aware.
- **FX runtime** (`assets/animations/fx-runtime.js`) — auto-inits `[data-fx]` on slide enter, cleans up on leave
- **Showcase decks** for themes / layouts / animations / full-decks gallery
- **Headless Chrome render script** for PNG export

## When to use

Use when the user asks for any kind of slide-based output or wants to turn
text/notes into a presentable deck. Prefer this over building from scratch.

### 🎤 Presenter Mode (演讲者模式 + 逐字稿)

If the user mentions any of: **演讲 / 分享 / 讲稿 / 逐字稿 / speaker notes / presenter view / 演讲者视图 / 提词器**, or says things like "我要去给团队讲 xxx", "要做一场技术分享", "怕讲不流畅", "想要一份带逐字稿的 PPT" — **use the `presenter-mode-reveal` full-deck template** and write 150–300 words of 逐字稿 in each slide's `<aside class="notes">`. In HTML notes, use `<strong>...</strong>` for emphasis; Markdown `**...**` will not reliably render as bold inside the runtime notes panel.

See [references/presenter-mode.md](references/presenter-mode.md) for the full authoring guide including the 3 rules of speaker script writing:
1. **不是讲稿，是提示信号** — 加粗核心词 + 过渡句独立成段
2. **每页 150–300 字** — 2–3 分钟/页的节奏
3. **用口语，不用书面语** — "因此"→"所以"，"该方案"→"这个方案"

All full-deck templates support the S key presenter mode (it's built into `runtime.js`). **S opens a new popup window with 4 magnetic cards**:
- 🔵 **CURRENT** — pixel-perfect iframe preview of the current slide
- 🟣 **NEXT** — pixel-perfect iframe preview of the next slide
- 🟠 **SPEAKER SCRIPT** — large-font 逐字稿 (scrollable)
- 🟢 **TIMER** — elapsed time + slide counter + prev/next/reset buttons

Each card is **draggable by its header** and **resizable by the bottom-right corner handle**. Card positions/sizes persist to `localStorage` per deck. A "Reset layout" button restores the default arrangement.

**Why the previews are pixel-perfect**: each preview is an `<iframe>` that loads the actual deck HTML with a `?preview=N` query param; `runtime.js` detects this and renders only slide N with no chrome. So the preview uses the **same CSS, theme, fonts, and viewport as the audience view** — colors and layout are guaranteed identical.

**Smooth navigation**: on slide change, the presenter window sends `postMessage({type:'preview-goto', idx:N})` to each iframe. The iframe just toggles `.is-active` between slides — **no reload, no flicker**. The two windows also stay in sync via `BroadcastChannel`.

Only `presenter-mode-reveal` is designed from the ground up around the feature with proper example 逐字稿 on every slide.

Keyboard in presenter window: `← →` navigate (syncs audience) · `R` reset timer · `Esc` close popup.
Keyboard in audience window: `S` open presenter · `T` cycle theme · `← →` navigate (syncs presenter) · `F` fullscreen · `O` overview · `E` left-side thumbnail navigator.

## Before you author anything — ALWAYS ask or recommend

**Do not start writing slides until you understand three things.** Either ask
the user directly, or — if they already handed you rich content — propose a
tasteful default and confirm.

1. **Content & audience.** What's the deck about, how many slides, who's
   watching (engineers / execs / 小红书读者 / 学生 / VC)?
2. **Style / theme.** Which of the 36 themes fits? If unsure, recommend 2-3
   candidates based on tone:
   - Business / investor pitch → `pitch-deck-vc`, `corporate-clean`, `swiss-grid`
   - Tech sharing / engineering → `tokyo-night`, `dracula`, `catppuccin-mocha`,
     `terminal-green`, `blueprint`
   - 小红书图文 → `xiaohongshu-white`, `soft-pastel`, `rainbow-gradient`,
     `magazine-bold`
   - Academic / report → `academic-paper`, `editorial-serif`, `minimal-white`

   For every real deck, pick **exactly 3 themes from the full 36-theme
   catalog** based on content, audience, and setting. Put the best fit first:
   it becomes both `<link id="theme-link" ...>`, `data-theme`, and the first
   item in `data-themes`. Do not reuse a fixed theme pack unless it genuinely
   matches the brief. `soft-pastel` and `aurora` are candidates, not defaults
   for every presentation.
   - Edgy / cyber / launch → `cyberpunk-neon`, `vaporwave`, `y2k-chrome`,
     `neo-brutalism`
3. **Starting point.** One of the 14 full-deck templates, or scratch? Point
   to the closest `templates/full-decks/<name>/` and ask if it fits. If the
   user's content suggests something obvious (e.g. "我要做产品发布会" →
   `product-launch`), propose it confidently instead of asking blindly.

A good opening message looks like:

> 我可以给你做这份 PPT！先确认三件事：
> 1. 大致内容 / 页数 / 观众是谁？
> 2. 风格偏好？如果你不确定，我会按内容和观众从 36 个内置主题里挑 3 个候选，默认用最匹配的那个，并保留 T 键切换。
> 3. 要不要用我现成的 `tech-sharing` 全 deck 模板打底？

Only after those are clear, scaffold the deck and start writing.

## Quick start

1. **Scaffold a new deck.** From the repo root:
   ```bash
   ./scripts/new-deck.sh my-talk
   open examples/my-talk/index.html
   ```
   On Windows PowerShell:
   ```powershell
   .\scripts\new-deck.ps1 my-talk
   Start-Process .\examples\my-talk\index.html
   ```
2. **Pick 3 content-fit themes.** Choose exactly 3 from all 36 themes, based on
   the deck's audience, tone, and topic. Hard-code the first as the default
   theme and list all 3 in `data-themes`:
   ```html
   <html data-theme="corporate-clean" data-themes="corporate-clean,soft-pastel,aurora" data-theme-base="../assets/themes/">
   <link rel="stylesheet" id="theme-link" href="../assets/themes/corporate-clean.css">
   ```
   Catalog in [references/themes.md](references/themes.md).
3. **Pick layouts.** Copy `<section class="slide">...</section>` blocks out of
   files in `templates/single-page/` into your deck. Replace the demo data.
   Catalog in [references/layouts.md](references/layouts.md).
4. **Add animations.** Put `data-anim="fade-up"` (or `class="anim-fade-up"`) on
   title blocks and key elements. On `<ul>`/grids/card groups, use
   `data-anim="stagger-list"` for sequenced reveals. These replay every time a
   slide is entered. For canvas FX, use a positioned background layer such as
   `<div class="slide-fx" data-fx="gradient-blob"></div>` and include
   `<script src="../assets/animations/fx-runtime.js"></script>`. Use FX
   sparingly on high-emphasis pages such as cover, capability, workflow,
   skills, and closing pages.
   Catalog in [references/animations.md](references/animations.md).
5. **Use a full-deck template.** Copy `templates/full-decks/<name>/` into
   `examples/my-talk/` as a starting point. Each folder is self-contained with
   scoped CSS. Catalog in [references/full-decks.md](references/full-decks.md)
   and gallery at `templates/full-decks-index.html`.
   Before delivery, replace any template sample `data-themes` with the 3
   content-fit themes selected for the actual deck.
6. **Render to PNG.**
   ```bash
   ./scripts/render.sh templates/theme-showcase.html       # one shot
   ./scripts/render.sh examples/my-talk/index.html 12      # 12 slides
   ```
   On Windows PowerShell, the renderer auto-detects Chrome or Edge:
   ```powershell
   .\scripts\render.ps1 .\templates\theme-showcase.html
   .\scripts\render.ps1 .\examples\my-talk\index.html all
   ```

## Authoring rules (important)

- **Always start from a template.** Don't author slides from scratch — copy the
  closest layout from `templates/single-page/` first, then replace content.
- **Default deliverable is HTML.** Unless the user explicitly asks for PPTX/PDF,
  deliver a static HTML presentation as the primary artifact, with keyboard
  navigation and presenter/notes support intact.
- **Default aspect ratio is 16:10.** Use a fixed 16:10 slide stage for normal
  presentation decks. Only use another ratio when the user explicitly requests it
  or a template requires it (for example `xhs-post` 3:4).
- **Use tokens, not literal colors.** Every color, radius, shadow should come
  from CSS variables defined in `assets/base.css` and overridden by a theme.
  Good: `color: var(--text-1)`. Bad: `color: #111`.
- **Use `--text-inverse` for inverted elements.** If a pill, badge, or CTA uses
  `background: var(--text-1)`, set its text to
  `color: var(--text-inverse, var(--bg))`; don't use `--surface` as text color
  because glass/dark themes may define it as translucent.
- **Don't invent new layout files.** Prefer composing existing ones. Only add
  a new `templates/single-page/*.html` if none of the 30 fit.
- **Respect chrome slots.** `.deck-header`, `.deck-footer`, `.slide-number`
  and the progress bar are provided by `assets/base.css` + `runtime.js`.
- **Every slide must have footer chrome.** Add an explicit `.deck-footer` to
  every `<section class="slide">`, not only cover/closing pages and not via a
  late runtime patch. The footer must include a short audience-facing footer
  note on the left and a `.slide-number` on the right with accurate
  `data-current` / `data-total`, before the hidden notes block:
  ```html
  <div class="deck-footer">
    <span>Short footer note</span>
    <span class="slide-number" data-current="N" data-total="TOTAL"></span>
  </div>
  ```
  Keep footer text concise and non-meta: it should describe the talk section,
  business topic, or takeaway, not the authoring process.
- **Keyboard-first.** Always include `<script src="../assets/runtime.js"></script>`
  so the deck supports ← →, mouse-wheel navigation, T / A / F / S / O / E, and hash
  deep-links.
- **Use O as a full-screen thumbnail wall.** `O` should open a whole-page
  overview made from real slide thumbnails, automatically fitting rows/columns
  to the slide count so thumbnails fill the viewport. Avoid placeholder title
  cards for overview mode. The overview header must stay compact, and each
  card must keep the slide preview area separate from the title/meta strip:
  scale thumbnails with contain-fit inside the preview-only area, center them
  there, and prevent overflow on all four sides. Page titles in overview cards
  should read as unboxed text below the thumbnail; do not wrap the title row in
  a large capsule/pill container.
- **Include the E-key thumbnail navigator.** `E` must open a left-side page
  navigator with real slide thumbnails, page numbers, a lightly dimmed
  background, click-to-jump behavior, and automatic scrolling for decks with
  many pages. Keep the navigator visually polished and compact enough to show
  several pages at once: a narrow side panel, compact but readable thumbnails,
  page number and page title placed below each thumbnail, restrained active-state
  highlight, hidden or near-invisible scrollbars, and progressive open/close
  motion for the dimmed backdrop, side panel, and thumbnail rows. Thumbnails
  should fill their own card/frame rather than appear inset-centered; make them
  smaller by narrowing the navigator and tightening card spacing. The transition
  between the navigator and the defocused slide should be clean and crisp: prefer
  a very subtle cyan hairline that softly fades into the right-side backdrop,
  with restrained edge shadow over thick glowing bars or broad blue haze.
  The page count and close control in the navigator header should stay quiet:
  use muted text for the count and a small ghost-style circular close button
  that only becomes visually prominent on hover/focus.
  The far-left hover trigger should be very narrow, show an immediate thin glow
  indicator, and open the navigator only after a tiny hover delay so casual
  mouse passes do not trigger it.
  Clicking the dimmed background must close the navigator, while clicks inside
  the side panel must not. `Esc` or pressing `E` again must close it.
- **One `.slide` per logical page.** `runtime.js` makes `.slide.is-active`
  visible; all others are hidden.
- **Supply hidden speaker notes on every slide by default.** Put notes in
  `<aside class="notes">…</aside>` or `<div class="notes">…</div>`. They must be
  invisible during normal projection and visible only through the notes drawer or
  presenter mode.
- **Speaker notes must include emphasis markup.** For decks with 演讲稿 /
  逐字稿 / presenter notes, every slide's notes should include 2–5 concise
  `<strong>核心提示词</strong>` spans. Bold the words the speaker should notice at
  a glance: core claims, transitions, numbers, risk warnings, or action verbs.
  Do not bold whole paragraphs. Keep at least one transition sentence as its own
  paragraph when the slide needs a speaking turn. Example:
  ```html
  <aside class="notes">
    <p>这一页先抛出核心判断：<strong>AI 替代的是任务，不是完整的人</strong>。</p>
    <p><strong>过渡：</strong>所以我们接下来不看岗位名，而是拆任务。</p>
  </aside>
  ```
- **NEVER put presenter-only text on the slide itself.** Descriptive text like
  "这一页展示了……" or "Speaker: 这里可以补充……" or small explanatory captions
  aimed at the presenter MUST go inside `<div class="notes">`, NOT as visible
  `<p>` / `<span>` elements on the slide. The `.notes` class is `display:none`
  by default — it only appears in the S overlay. Slides should contain ONLY
  audience-facing content (titles, bullet points, data, charts, images).
- **No provenance or production-process text on visible slides.** Do not show
  words such as "来源", "制作", "html-ppt", "markdown", "generated by", "created
  with", tool names, or any description of how the deck was produced. Keep such
  text out of visible slide content, footers, screenshots, and title pages.
- **No deck-version or authoring-strategy wording on visible slides.** Do not
  show meta phrases such as "新版", "这版", "本版", "汇报节奏", "设计思路", "页面设计",
  "制作过程", "生成过程", "本页用于", or "这一页展示". If such guidance is useful,
  move it into hidden speaker notes and rewrite visible copy as audience-facing
  business content.
- **Let main slide headings use the content width.** Do not accidentally cap
  `.h2` / main page titles to a narrow block such as `960px`-`1040px` on a
  16:10 deck when the slide has open horizontal space. A good default for
  landscape decks is `max-width: min(1360px, 100%)` inside the content area,
  with line-height around `1.1`-`1.18`. Short and medium Chinese headings that
  visually fit the slide should stay on one line; if a title wraps, it should be
  an intentional semantic break, not a side effect of a too-small max-width.
  Do not apply global `white-space: nowrap`; for genuinely long titles, reduce
  the title slightly or add a page-specific class after checking it does not
  overflow.
- **Use data motion for data-heavy pages.** Visible data numbers should animate
  from `0` to the target value on slide enter. Bar charts, progress bars, and
  KPI tracks should grow from zero width/height on slide enter. SVG diagrams
  should use restrained path-draw, dash, pulse, scan, or flow animations where
  they clarify process or data movement. Animations should replay when returning
  to a slide.
- **Never leave KPI numbers as static text.** Any prominent metric, percentage,
  money value, count, or benchmark on an audience slide must use
  `.counter data-to="..."` with visible initial text set to `0`. Preserve
  formatting with `data-prefix`, `data-suffix`, and `data-decimals`. Put the
  `.counter` class on the same element that owns the large-number typography,
  such as `<strong class="counter" data-prefix="$" data-to="285.9" data-decimals="1" data-suffix="B">$0.0B</strong>`.
  Do not wrap a counter in a generic `<span>` inside KPI cards if local CSS uses
  selectors like `.data-tile span`; that can accidentally shrink the number.
  In previews and thumbnail navigators the runtime will show the final value;
  in the audience view it must reset to zero and count up whenever the slide is
  entered.
- **Keep report pages optically centered.** Place the main content block as
  centered as possible between header and footer, especially when a page has
  sparse content. Avoid leaving a large empty lower half unless it is an
  intentional hero/quote composition.
- **Minimum visible text size is 14px.** Slide body text, table text, SVG text,
  footers, badges, labels, and captions must not render below 14px. If content
  does not fit, reduce density, split the slide, or redesign the layout instead
  of shrinking text below 14px.
- **Keep deck chrome out of content flow.** Do not let `.deck-footer`,
  `.slide-number`, progress bars, or presenter-only controls get positioned by
  generic slide-child CSS. If you add rules such as `.slide > * { ... }`, always
  exclude chrome and decorative layers, for example:
  ```css
  .deck .slide > :not(.visual-grid):not(.slide-fx):not(.deck-footer):not(.concept-svg) {
    position: relative;
    z-index: 1;
  }
  ```
  Footer summaries should sit at the lower-left; page numbers should be fixed at
  the lower-right. Do not combine them into the main content layout.
- **Never show shortcut cheat sheets on the audience slide.** Runtime shortcuts
  such as `S`, `T`, `E`, `O`, and `F` may exist, but visible shortcut hints,
  help strips, or presenter-control text should not appear on the projected
  slides. Put shortcut guidance in notes, final instructions, or external
  documentation only.
- **Prevent Grid auto-placement surprises.** Be careful with cards such as
  `.data-tile.wide`: spanning rows or columns can trigger CSS Grid auto-placement
  and make cards uneven or misaligned. Unless a deliberate mosaic layout is
  required, keep metric/card grids uniform with stable tracks and explicit
  dimensions:
  ```css
  .data-board { display: grid; grid-template-columns: repeat(4, 1fr); align-items: stretch; }
  .data-tile { min-height: 240px; }
  .data-tile.wide { grid-row: auto; }
  ```
  If one card must be wider, prefer an explicit `grid-column` plan and inspect
  the rendered PNG for row height and baseline alignment.
- **Use stronger motion, but keep it purposeful.** For polished decks, combine
  CSS entry motion, restrained micro-interactions, and Canvas FX on high-emphasis
  pages such as cover, data/trend pages, agent/workflow pages, and closing.
  Use `data-fx` layers (`neural-net`, `data-stream`, `knowledge-graph`,
  `orbit-ring`, `constellation`, etc.) as background atmosphere with controlled
  opacity, masks, and no pointer events. FX should add energy without reducing
  legibility or making operational/report pages feel decorative.
- **Add content-aware SVG diagrams when they clarify the message.** Use SVG
  motion for concepts such as task flow, risk boundaries, tool selection,
  knowledge assets, loops, and timelines. The graphic should have presence and
  be recognizable, but it must not compete with cards, tables, or body copy.
  Prefer an absolute, non-interactive decorative layer with low z-index,
  restrained opacity, and masks that prevent the graphic from extending into
  text containers:
  ```css
  .concept-svg {
    position: absolute;
    z-index: 0;
    pointer-events: none;
    opacity: .18;
    mask-image: linear-gradient(180deg, black 0%, black 70%, transparent 100%);
  }
  ```
  Place large semantic SVGs in empty corners or gutters; avoid placing them
  behind card grids unless they are very faint and visually separated from the
  card text. Always inspect light and dark themes because translucent cards can
  reveal background graphics differently.

## Final QA before delivery

Before handing off a finished HTML deck:

- Render all slides to PNG at the target ratio and inspect a contact sheet or
  representative screenshots for overflow, overlap, excessive bottom whitespace,
  and weak vertical alignment.
- Verify every slide has a visible footer note and page number. Search for
  `.deck-footer` / `.slide-number` count matching the number of `.slide`
  sections, and spot-check rendered PNGs for the first, middle, and last slides.
- Check visible text for prohibited production-process wording such as "来源",
  "制作", "html-ppt", and "markdown".
- Also search for visible meta/version wording such as "新版", "这版", "本版",
  "汇报节奏", "设计思路", "页面设计", "制作过程", "生成过程", "本页用于", and "这一页展示".
- Verify all visible text is at least 14px, including SVG labels and table text.
- Verify data animations: numeric KPIs count from 0 to target values, bars and
  progress tracks grow on slide enter, and SVG process/data-flow animations run.
- Verify keyboard navigation, fullscreen/overview/E-key thumbnail navigator,
  and hidden notes/presenter
  mode work. Also verify mouse-wheel navigation: wheel down advances one slide,
  wheel up goes back one slide, and repeated wheel events do not skip multiple
  slides while keeping the cooldown short enough to feel responsive.
- Verify main heading fit in a real browser at the target deck viewport,
  typically `1600x1000`. For each `.h2` / main title, check for accidental
  wrapping and horizontal overflow. Medium-length headings should not wrap just
  because a local style set a narrow `max-width`; expand the heading width before
  reducing font size.
- For decks with 逐字稿, verify every slide has hidden notes and that notes use
  `<strong>` emphasis on key speaker cues. If notes are plain paragraphs with no
  emphasis markup, revise them before delivery.
- For data-heavy decks, search rendered HTML for large static KPI text such as
  `%`, `$`, `B`, `M`, or benchmark counts. Prominent visible metrics should be
  `.counter` elements with `data-to`; run the deck in a browser and confirm the
  values visibly reset to `0` and count up when entering the slide.
- In S-key presenter mode, verify `<strong>` cues appear visually emphasized in
  the SPEAKER SCRIPT panel, normally orange and bold via runtime CSS. If a
  previously opened deck still shows plain text, clear or version-bump the
  presenter notes `localStorage` key so stale editable notes do not override the
  updated `<aside class="notes">` HTML.
- Use browser automation for DOM/layout/console checks when available. If the
  system Node cannot import Playwright, try the bundled workspace Node modules
  from `load_workspace_dependencies` before declaring browser automation
  unavailable.

## Writing guide

See [references/authoring-guide.md](references/authoring-guide.md) for a
step-by-step walkthrough: file structure, naming, how to transform an outline
into a deck, how to choose layouts and themes per audience, how to do a
Chinese + English deck, and how to export.

## Catalogs (load when needed)

- [references/themes.md](references/themes.md) — all 36 themes with when-to-use.
- [references/layouts.md](references/layouts.md) — all 31 layout types.
- [references/animations.md](references/animations.md) — 27 CSS + 20 canvas FX animations.
- [references/full-decks.md](references/full-decks.md) — all 15 full-deck templates.
- [references/presenter-mode.md](references/presenter-mode.md) — **演讲者模式 + 逐字稿编写指南（技术分享/演讲必看）**.
- [references/authoring-guide.md](references/authoring-guide.md) — full workflow.

## File structure

```
html-ppt/
├── SKILL.md                 (this file)
├── references/              (detailed catalogs, load as needed)
├── assets/
│   ├── base.css             (tokens + primitives — do not edit per deck)
│   ├── fonts.css            (webfont imports)
│   ├── runtime.js           (keyboard + presenter + overview + theme cycle)
│   ├── themes/*.css         (36 token overrides, one per theme)
│   └── animations/
│       ├── animations.css   (27 named CSS entry animations)
│       ├── fx-runtime.js    (auto-init [data-fx] on slide enter)
│       └── fx/*.js          (20 canvas FX modules: particles/graph/fireworks…)
├── templates/
│   ├── deck.html                  (minimal 6-slide starter)
│   ├── theme-showcase.html        (36 slides, iframe-isolated per theme)
│   ├── layout-showcase.html       (iframe tour of all 31 layouts)
│   ├── animation-showcase.html    (20 FX + 27 CSS animation slides)
│   ├── full-decks-index.html      (gallery of all 14 full-deck templates)
│   ├── full-decks/<name>/         (14 scoped multi-slide deck templates)
│   └── single-page/*.html         (31 layout files with demo data)
├── scripts/
│   ├── new-deck.sh                (scaffold a deck from deck.html)
│   ├── new-deck.ps1               (Windows PowerShell scaffold)
│   ├── render.sh                  (headless Chrome → PNG)
│   └── render.ps1                 (Windows PowerShell Chrome/Edge → PNG)
└── examples/demo-deck/            (complete working deck)
```

## Rendering to PNG

`scripts/render.sh` wraps headless Chrome at
`/Applications/Google Chrome.app/Contents/MacOS/Google Chrome`. For multi-slide
capture, runtime.js exposes `#/N` deep-links, and render.sh iterates 1..N.

```bash
./scripts/render.sh templates/single-page/kpi-grid.html        # single page
./scripts/render.sh examples/demo-deck/index.html 8 out-dir    # 8 slides, custom dir
```

Windows PowerShell:

```powershell
.\scripts\render.ps1 .\templates\single-page\kpi-grid.html
.\scripts\render.ps1 .\examples\demo-deck\index.html 8 .\out-dir
```

## Keyboard cheat sheet

```
←  →  Space  PgUp  PgDn  Home  End    navigate
Mouse wheel down/up                    next / previous slide
F                                       fullscreen
S                                       open presenter window (magnetic cards: current/next/script/timer)
N                                       quick notes drawer (bottom overlay)
R                                       reset timer (in presenter window)
?preview=N                              URL param — force preview-only mode (single slide, no chrome)
O                                       full-screen thumbnail wall overview
E                                       left-side thumbnail page navigator
T                                       cycle themes (reads data-themes attr)
A                                       cycle demo animation on current slide
#/N in URL                              deep-link to slide N
Esc                                     close all overlays
```

## License & author

MIT. Copyright (c) 2026 lewis &lt;sudolewis@gmail.com&gt;.
