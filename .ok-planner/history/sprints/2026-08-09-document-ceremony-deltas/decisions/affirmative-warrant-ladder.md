---
decision: affirmative-warrant-ladder
---

# Affirmative-only warrant ladder

## Choice

A documentation claim is recorded as *held* only on an affirmative
warrant — a passing run, either a test in the project's own suite
exercised at the release or an archived experiment. Verification climbs
a three-rung ladder and stops at the first rung that settles the item:
an existing passing test; careful reading of what the story's linkages
lead to; a purpose-built experiment. A failing run is never a finding —
it dispatches diagnosis (stale probe, wrong probe, or wrong
assumption) — and a contradiction is warranted only by an evidence set
produced by reading, with any failed runnable attached as
corroboration.

## Rationale

A failing run cannot distinguish "the assumption is false" from "the
probe is stale or wrong," so it proves nothing on its own; a passing
run is constructive proof regardless of the probe's craftsmanship. The
asymmetry sets the whole economy: cheap warrants first (the suite
already runs at every release for free), expensive instruments last,
and positions on contradictions rest on evidence that a reader can
check. The rimsky case study's trap inventory supports resting traps on
evidence rather than reproductions: a strict no-repro-no-entry rule
excluded roughly a quarter of verified traps non-randomly, including
the highest-value find.

## Alternatives

- Execute everything: dispatch an agent per story and assumption to
  drive the release directly — the strongest evidence per item, at a
  per-release agent cost roughly the size of the catalog itself.
- Reading-only assessment: no runs at all — restores the failure mode
  the whole design responds to, prose positions with nothing re-taking
  them.
- Failed runs as trap warrants: treat a failing probe as proof of
  contradiction — mints false traps whenever the probe, not the
  product, is wrong.
