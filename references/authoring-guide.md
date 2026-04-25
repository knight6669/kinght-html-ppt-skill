# Authoring Guide

How to turn a user request ("make me a deck about X") into a finished
html-ppt deck. Follow these steps in order.

## 1. Understand The Deck

Before touching files, clarify or infer:

1. **Audience** — engineers, PMs, designers, executives, consumers, students?
2. **Length** — 5 min lightning, 20 min share, 45 min talk?
3. **Language** — Chinese, English, bilingual? Noto Sans SC is preloaded.
4. **Format** — live presentation, PDF export, social-card post?
5. **Tone** — clinical, friendly, editorial, productized, playful, cyber?

Audience and tone determine theme candidates; length determines slide count;
format determines runtime needs such as notes, T-cycle, PNG render, or PDF CSS.

## 2. Pick Exactly 3 Themes

Every deck should get **3 content-fit theme candidates** from the full
36-theme catalog in `assets/themes/`. The first theme is the default. The other
two are alternates the user can preview with **T**.

Do this every time:

1. Read the deck subject, audience, and setting.
2. Choose 3 themes from all 36, not from a fixed pack.
3. Put the best theme first in both `data-themes` and `theme-link`.
4. Verify all 3 with T before delivery.

Example wiring:

```html
<html lang="zh-CN" data-themes="corporate-clean,soft-pastel,aurora" data-theme-base="../assets/themes/">
<link rel="stylesheet" id="theme-link" href="../assets/themes/corporate-clean.css">
```

Fast theme triage:

| Deck type | Good 3-theme set |
|---|---|
| Product / PM / non-technical sharing | `corporate-clean`, `soft-pastel`, `aurora` |
| Executive / business review | `corporate-clean`, `minimal-white`, `pitch-deck-vc` |
| Research / academic / policy | `academic-paper`, `minimal-white`, `editorial-serif` |
| Engineering / developer talk | `tokyo-night`, `catppuccin-mocha`, `engineering-whiteprint` |
| Architecture / systems | `blueprint`, `engineering-whiteprint`, `nord` |
| Consumer / lifestyle / social | `xiaohongshu-white`, `soft-pastel`, `sunset-warm` |
| Brand story / editorial | `magazine-bold`, `editorial-serif`, `japanese-minimal` |
| Launch / reveal / future-facing | `aurora`, `glassmorphism`, `rainbow-gradient` |
| Bold pitch / manifesto | `pitch-deck-vc`, `neo-brutalism`, `sharp-mono` |
| Retro / culture / entertainment | `retro-tv`, `midcentury`, `vaporwave` |
| Cyber / CLI / security | `cyberpunk-neon`, `terminal-green`, `tokyo-night` |

These are starting points, not rules. If the content calls for a different
combination, choose differently.

## 3. Outline The Deck

A solid 20-minute deck usually follows:

```text
cover -> why now -> core idea -> section 1 -> section 2 -> workflow/demo -> risks -> next steps -> close
```

Pick one layout per page from `references/layouts.md`. Avoid repeating the
same layout twice in a row unless the sequence is intentionally rhythmic.

## 4. Scaffold The Deck

```bash
./scripts/new-deck.sh my-talk
```

This copies `templates/deck.html` into `examples/my-talk/index.html` with paths
rewritten. Add or remove `<section class="slide">` blocks to match the outline.

For a talk with speaker notes, prefer:

```text
templates/full-decks/presenter-mode-reveal/
```

## 5. Author Each Slide

For each outline item:

1. Open a matching single-page layout, e.g. `templates/single-page/kpi-grid.html`.
2. Copy the `<section class="slide">...</section>` block.
3. Paste it into your deck.
4. Replace demo data with real content while keeping the structure.
5. Set `data-title="..."` for the overview and E-key page navigator.
6. Add `<aside class="notes">...</aside>` when the deck is for a live talk.

## 6. Add CSS Animations

Use the built-in animation library through `data-anim`. Runtime replays these
animations whenever a slide is entered, so titles, grids, and cards can animate
again when the speaker returns to a page.

Recommended defaults:

- Cover/title: `data-anim="rise-in"` or `data-anim="blur-in"`.
- Body headings: `data-anim="fade-up"`.
- Grids, card groups, steps, and lists: `data-anim="stagger-list"`.
- Stats: `.counter` with `data-to="..."`.
- Section dividers / CTA: `data-anim="perspective-zoom"`.

Pick one main entry rhythm per slide. Let the content breathe.

## 7. Add Canvas FX

Canvas FX should be a subtle background layer, not the main content. Use them
on a few emphasis pages: cover, capability, workflow, skills, closing, or a
major section transition.

Pattern:

```html
<section class="slide" data-title="Workflow">
  <div class="slide-fx" data-fx="chain-react"></div>
  ...
</section>
<script src="../assets/animations/fx-runtime.js"></script>
```

CSS:

```css
.slide > :not(.slide-fx) { position: relative; z-index: 1; }
.slide-fx {
  position: absolute;
  inset: 0;
  pointer-events: none;
  z-index: 0;
  opacity: .08;
}
```

Good pairings:

| Page role | FX candidates |
|---|---|
| Cover / close | `gradient-blob`, `starfield`, `constellation` |
| Capability / system | `knowledge-graph`, `neural-net`, `chain-react` |
| Workflow / process | `data-stream`, `orbit-ring`, `magnetic-field` |
| Skills / library / memory | `word-cascade`, `typewriter-multi`, `sparkle-trail` |
| Celebration / final | `confetti-cannon`, `firework`, `particle-burst` |

Keep the FX opacity low and make it theme-aware by styling only with tokens
where possible.

## 8. Review In Browser

Walk through every slide with arrow keys. Press:

- **T** — cycle the 3 selected themes and verify none breaks layout.
- **E** — open compact page navigation and confirm thumbnails/titles fit.
- **O** — overview grid; catch clipping and overcrowding.
- **S** — speaker view; verify notes exist and presenter controls work.
- **A** — demo animation cycling if the deck uses animation targets.

Also verify mouse-wheel navigation: one wheel gesture should advance or go
back by one slide only.

## 9. Export To PNG

```bash
# single slide
./scripts/render.sh examples/my-talk/index.html

# all slides
./scripts/render.sh examples/my-talk/index.html all

# explicit slide count + output dir
./scripts/render.sh examples/my-talk/index.html 12 out/my-talk-png
```

Output is 1920x1080 by default. Adjust the render script only when the user
explicitly requests another ratio.

## 10. What Not To Do

- Do not hand-author from a blank file when a template can be used.
- Do not use raw hex colors in slide markup; use tokens.
- Do not lock every deck to the same 3 themes.
- Do not load extra animation frameworks; use the shipped CSS/JS.
- Do not add more than one new template file unless a genuinely new layout is needed.
- Do not put presenter-only explanation on visible slides. Put it inside
  `<aside class="notes">` or `<div class="notes">`.

## Troubleshooting

- **T does not switch themes**: check `data-themes` and `data-theme-base`.
- **Only one theme changes**: make sure `theme-link` points to the first item in `data-themes`.
- **Canvas FX does not show**: include `fx-runtime.js`, confirm `[data-fx]` is inside the active slide, and give the layer dimensions.
- **Animations do not replay**: use `data-anim`, not only a static class.
- **Fonts fall back**: link `fonts.css` before the theme.
- **PNG too small**: adjust the render script viewport.
