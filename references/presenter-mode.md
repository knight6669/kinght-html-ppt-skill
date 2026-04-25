# Presenter Mode Guide

Use `templates/full-decks/presenter-mode-reveal/` whenever the user is making a
live talk, team sharing deck, training deck, product walkthrough, or any deck
that needs hidden speaker notes.

## What The Template Provides

- **S** opens a presenter window with current slide, next slide, script, and timer.
- **T** cycles the 3 content-fit themes chosen for this deck.
- **E** opens a compact left-side page navigator with smaller thumbnails.
- **O** opens the overview grid.
- Arrow keys and mouse wheel navigate slides.
- Each slide includes hidden `<aside class="notes">...</aside>`.
- CSS `data-anim` entry animations replay on slide enter.
- Optional Canvas FX layers can be added with `data-fx`.

The template's sample themes are only examples. For every real deck, choose
exactly 3 themes from all 36 built-in themes based on the topic, audience, and
delivery setting.

## Speaker Script Rules

1. **Write cue-rich notes, not essays.** Bold or separate the key transition
   lines so the speaker can recover quickly.
2. **150-300 Chinese characters or words per slide** is a good default for a
   35-45 minute talk. Shorter slides can use less.
3. **Use spoken language.** Prefer simple transitions and conversational rhythm.

Visible slides should contain only audience-facing content. Do not place
speaker-only explanation on the slide canvas.

## Minimal HTML Pattern

```html
<!DOCTYPE html>
<html lang="zh-CN" data-themes="corporate-clean,soft-pastel,aurora" data-theme-base="../../../assets/themes/">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width,initial-scale=1">
  <title>My Talk</title>
  <link rel="stylesheet" href="../../../assets/fonts.css">
  <link rel="stylesheet" href="../../../assets/base.css">
  <link rel="stylesheet" id="theme-link" href="../../../assets/themes/corporate-clean.css">
  <link rel="stylesheet" href="../../../assets/animations/animations.css">
  <link rel="stylesheet" href="style.css">
</head>
<body>
<div class="deck tpl-presenter-mode-reveal">
  <section class="slide" data-title="Cover">
    <div class="slide-fx" data-fx="gradient-blob"></div>
    <p class="kicker">share deck</p>
    <h1 class="h1" data-anim="rise-in">Talk Title</h1>
    <p class="lede" data-anim="fade-up">One clear sentence for the audience.</p>
    <aside class="notes">
      Speaker notes go here. These notes are hidden on the audience screen and
      shown in the S-key presenter window.
    </aside>
  </section>
</div>
<script src="../../../assets/runtime.js"></script>
<script src="../../../assets/animations/fx-runtime.js"></script>
</body>
</html>
```

Replace `corporate-clean,soft-pastel,aurora` with the 3 themes selected for
the actual deck.

## Theme Selection For Talks

Choose exactly 3 themes:

- PM / product / non-technical: `corporate-clean`, `soft-pastel`, `aurora`.
- Engineering: `tokyo-night`, `catppuccin-mocha`, `engineering-whiteprint`.
- Executive review: `corporate-clean`, `minimal-white`, `pitch-deck-vc`.
- Research: `academic-paper`, `minimal-white`, `editorial-serif`.
- Systems / architecture: `blueprint`, `engineering-whiteprint`, `nord`.
- Brand / narrative: `magazine-bold`, `editorial-serif`, `japanese-minimal`.

These are recommended starting points, not mandatory packs. Always adapt to
the user's audience and content.

## Motion Defaults

Use animation as a speaking rhythm:

- Cover title: `data-anim="rise-in"`.
- Page headings: `data-anim="fade-up"`.
- Grids, card groups, steps: `data-anim="stagger-list"`.
- CTA / close: `data-anim="perspective-zoom"` or `rise-in`.

Runtime removes and re-adds the matching `anim-*` class on slide enter, so the
animation replays when returning to a page.

## Canvas FX Defaults

Canvas FX should be subtle and sparse. Add them to a few important pages:

- Cover: `gradient-blob`, `starfield`, `constellation`.
- Capability / concept: `knowledge-graph`, `neural-net`, `chain-react`.
- Workflow: `data-stream`, `orbit-ring`, `magnetic-field`.
- Skills / reusable methods: `word-cascade`, `typewriter-multi`, `sparkle-trail`.
- Closing: `confetti-cannon`, `firework`, `particle-burst`.

Recommended layer:

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

## How Presenter Preview Works

Each presenter preview is an `<iframe>` that loads the same deck with a
`?preview=N` query param. `runtime.js` renders only slide N in that iframe, so
preview colors, fonts, and layout match the audience screen. On slide change,
the presenter window sends a `preview-goto` message instead of reloading the
iframe, which keeps previews smooth.

## QA Checklist

- Press **T** through all 3 chosen themes and check layout, contrast, and overflow.
- Press **E** and confirm the compact navigator shows more pages without bulky cards.
- Press **O** and scan the whole deck for clipping.
- Press **S** and confirm current, next, script, and timer cards work.
- Navigate away and back to animated slides; titles, grids, and cards should replay.
- Confirm `[data-fx]` pages show subtle Canvas backgrounds and do not cover content.
