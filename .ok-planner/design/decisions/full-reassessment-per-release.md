---
decision: full-reassessment-per-release
---

# Full re-assessment at every release

## Choice

Every documentation run re-derives and re-verifies everything: the
assumption set is synthesized fresh, every story-way and assumption is
re-warranted, and no record carries forward on any validity test.
Nothing tracks staleness and nothing invalidates anything. The prior
release's published corpus is an input to synthesis — it is shipped,
user-visible material, so its contents are legitimate user priors — but
its conclusions never carry.

## Rationale

Smart invalidation is machinery the suite has built and retired before:
tracking which records survive a change costs more than paying for the
re-run, and the audit reached the same terminus — a stamped statement
about a named commit, re-made whole each run, with "is it still
current" left as a git question. Feeding the prior corpus back in as
user-visible input preserves the one thing carry-forward genuinely
bought — continuity of attention, so hard-won traps are re-measured
rather than forgotten — without carrying a single conclusion.

## Alternatives

- Evidence-set carry-forward: keep a record while its citations still
  resolve and its surfaces are unchanged — reintroduces exactly the
  citation-tracking and invalidation machinery the audit deliberately
  deleted.
- Per-story diff invalidation: re-assess only what a release's diff
  touches — cheaper per release, but the diff-to-record mapping is
  itself standing machinery that must be maintained and trusted.
