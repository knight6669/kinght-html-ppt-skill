# Themes Catalog

Every theme is a CSS token override in `assets/themes/`. Switch themes by
changing `<link id="theme-link">`, or by pressing **T** when the deck has
`data-themes="a,b,c"` on `<html>` or `<body>`.

All themes share the same variables from `assets/base.css`: `--bg`,
`--bg-soft`, `--surface`, `--surface-2`, `--border`, `--text-1`, `--text-2`,
`--text-3`, `--accent`, `--accent-2`, `--accent-3`, `--good`, `--warn`,
`--bad`, `--grad`, `--grad-soft`, radius, shadow, and font tokens.

## Theme Selection Rule

For each real deck, choose **exactly 3 themes from all 36**:

1. **Default** — the best fit for the audience and delivery setting.
2. **Softer alternate** — calmer, lighter, or more approachable.
3. **Expressive alternate** — more dramatic, visual, or memorable.

The first theme must match both `data-themes` and `theme-link`:

```html
<html lang="zh-CN" data-themes="corporate-clean,soft-pastel,aurora" data-theme-base="../assets/themes/">
<link rel="stylesheet" id="theme-link" href="../assets/themes/corporate-clean.css">
```

Do not hardcode the same three themes for every deck. `soft-pastel` and
`aurora` are useful candidates, not universal defaults.

## Fast Recommendations

| Use case | Pick 3 |
|---|---|
| PM / product / non-technical sharing | `corporate-clean`, `soft-pastel`, `aurora` |
| Executive / business review | `corporate-clean`, `minimal-white`, `pitch-deck-vc` |
| Finance / analysis / board style | `arctic-cool`, `corporate-clean`, `swiss-grid` |
| Research / academic / policy | `academic-paper`, `minimal-white`, `editorial-serif` |
| Developer / technical talk | `tokyo-night`, `catppuccin-mocha`, `engineering-whiteprint` |
| Architecture / systems / API | `blueprint`, `engineering-whiteprint`, `nord` |
| Product launch / future-facing | `aurora`, `glassmorphism`, `rainbow-gradient` |
| Social / lifestyle / creator | `xiaohongshu-white`, `soft-pastel`, `sunset-warm` |
| Brand story / editorial | `magazine-bold`, `editorial-serif`, `japanese-minimal` |
| Design / art / visual culture | `bauhaus`, `midcentury`, `memphis-pop` |
| Bold pitch / manifesto | `pitch-deck-vc`, `neo-brutalism`, `sharp-mono` |
| Cyber / security / CLI | `cyberpunk-neon`, `terminal-green`, `tokyo-night` |
| Retro / entertainment / nostalgia | `retro-tv`, `vaporwave`, `y2k-chrome` |

## All 36 Themes

| Theme | Character | Good For |
|---|---|---|
| `minimal-white` | Very clean white, restrained, low-shadow | Internal reviews, serious strategy, dense text |
| `editorial-serif` | Magazine serif, warm paper feel | Brand stories, narrative talks, text-led decks |
| `soft-pastel` | Gentle pastel gradients | Product education, consumer-friendly topics, light sharing |
| `sharp-mono` | Black/white, hard contrast, mono attitude | Manifestos, bold opinions, punchy launches |
| `arctic-cool` | Cool blue-gray professional style | Finance, analytics, calm business topics |
| `sunset-warm` | Warm orange/coral gradient | Lifestyle, motivation, human-centered narratives |
| `catppuccin-latte` | Soft developer-friendly light palette | Technical content that should stay approachable |
| `catppuccin-mocha` | Dark Catppuccin | Developer talks, long screen viewing, code-heavy decks |
| `dracula` | Classic purple/pink dark theme | Code-heavy engineering and community talks |
| `tokyo-night` | Cool deep technical dark | Infrastructure, AI, developer workflows |
| `nord` | Calm Nordic blue-white | Cloud, infrastructure, systems, enterprise tech |
| `solarized-light` | Low-eye-strain light palette | Teaching, long workshops, documentation reviews |
| `gruvbox-dark` | Warm retro terminal dark | Vim/Linux/*nix communities, terminal culture |
| `rose-pine` | Soft rose dark palette | Design/development crossover, aesthetic tech |
| `neo-brutalism` | Thick outlines, strong shadow, loud accent | Startup pitch, strong claims, youth-facing ideas |
| `glassmorphism` | Frosted glass and luminous surfaces | Product reveals, feature showcases, modern UI stories |
| `bauhaus` | Geometric red/yellow/blue | Design history, visual systems, art/product talks |
| `swiss-grid` | Strict grid and typography | Design reviews, layout critique, precise reports |
| `terminal-green` | Green terminal glow | CLI, security, retro computing, hacker-style talks |
| `xiaohongshu-white` | Bright white social-card aesthetic | Xiaohongshu posts, lifestyle, beauty, creator content |
| `rainbow-gradient` | White base with colorful accent | Celebration, joyful launches, energetic wrap-ups |
| `aurora` | Aurora gradient and soft glow | Covers, closings, future-facing product narratives |
| `blueprint` | Engineering blueprint grid | Architecture, system design, technical plans |
| `memphis-pop` | Playful shapes and pop energy | Youth culture, brand collaborations, playful topics |
| `cyberpunk-neon` | Neon dark, high intensity | Security, sci-fi, edgy technology, game-adjacent talks |
| `y2k-chrome` | Chrome gradient and rounded Y2K feel | Gen-Z, fashion, nostalgia, cultural trend decks |
| `retro-tv` | CRT scanline warmth | Nostalgia, media, entertainment, retro stories |
| `japanese-minimal` | Ivory, red accent, quiet serif | Craft, brand upgrade, calm personal stories |
| `vaporwave` | Purple/pink/teal aesthetic | Music, internet culture, retro-future concepts |
| `midcentury` | Cream base, olive/teal/orange geometry | Design history, home/lifestyle, vintage branding |
| `corporate-clean` | White, navy accent, business restraint | B2B, PM sharing, executive updates, formal reports |
| `academic-paper` | Paper-like serif and ink | Research, papers, conference-style decks |
| `news-broadcast` | Red accent, broadcast headline energy | Announcements, incident summaries, status briefings |
| `pitch-deck-vc` | Startup pitch, generous whitespace | Fundraising, business cases, opportunity framing |
| `magazine-bold` | Editorial serif, large display type | Essays, brand monthlies, narrative/product stories |
| `engineering-whiteprint` | Whiteprint grid and mono details | APIs, architecture, design docs, technical planning |

## How To Extend

Copy an existing theme, rename it, and override only the variables you need.
Keep each theme short and token-driven. Prefer token changes over new selectors
so runtime UI, animations, and layouts remain theme-aware.
