---
decision: skills-read-only-the-current-layout
---

# The skills read only the current estate layout

## Choice

Every skill, script, and hook the suite vendors reads only the estate
layout of the suite version that wrote it. None reads a layout an
earlier release left or carries a fallback for one. True-up brings the
whole estate to the current layout on every run the owner lets proceed
(see also: whole-file-ownership), so the skills meet nothing an
earlier layout left. A record in the archive keeps the form it closed
with.

## Rationale

A reader that understands every earlier layout carries each layout's
reading for good, and every release adds paths each skill must get
right. Bringing the estate current on every true-up keeps one reading
per skill, and the owner's one consent covers the move (see also:
true-up-asks-once-before-destructive-steps). A project whose owner
declines the true-up loses nothing, since its own vendored copies
still read the layout it has (see also: per-project-pinning).

## Alternatives

- Skills read every earlier layout as well as the current one — no
  project must migrate, and every skill carries every retired
  layout's reading.
- True-up brings to the current layout only what the owner accepts
  item by item, and the skills tolerate the rest — an estate partly
  on each layout, which every skill must read both ways.
- Leave retired content in place where no current skill reads it —
  dead files sit beside live ones, and a reader cannot tell which
  layout is live.
