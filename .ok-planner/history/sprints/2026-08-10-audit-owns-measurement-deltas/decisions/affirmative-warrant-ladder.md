---
decision: affirmative-warrant-ladder
---

# Affirmative-only warrants from the maintained experiments

## Choice

A documentation claim is recorded as *held* only on an affirmative
warrant: a passing experiment driven through the ruled public surface
at the stamped commit. Verification runs on the maintained
experiments — an
archived experiment covering the claim is re-run at the stamp, one the
surface diff makes suspect is repaired first, and a claim no archived
experiment covers gets a new one. Reading is investigative and never a
warrant: it locates, diagnoses, and builds evidence sets. The
project's own tests are never warrants for user-vantage claims — a
test may reach behind the surface — though they may steer diagnosis. A
failing run is never a finding — it dispatches diagnosis (stale probe,
wrong probe, or wrong assumption) — and a contradiction is warranted
by an evidence set, with a passing demonstration of the actual
behavior through the surface as its strongest member and any failed
runnable attached as corroboration, never as the warrant itself.

## Rationale

A failing run cannot distinguish "the assumption is false" from "the
probe is stale or wrong," so it proves nothing on its own; a passing
run is constructive proof regardless of the probe's craftsmanship. The
surface constraint is what a test could never give: a passing test
proves the code can do something, while a passing surface experiment
proves a user can obtain it. Executing every claim without a
maintained collection would be priced out; maintaining the
experiments changes the
economics — the marginal cost of a run is execution plus repair of
what the surface diff flagged, not reconstruction — which is what lets
the strongest evidence become the only warrant. Traps rest on evidence
sets rather than reproductions because a no-repro-no-entry rule
excludes real traps non-randomly: the contradictions hardest to
reproduce on demand are often the most valuable, and a runnable
reproduction as the entry fee silently drops exactly those.

## Alternatives

- Tests as the first rung (the prior shape): the cheapest warrant, but
  a test that bypasses the surface warrants a claim no user can reach.
- Reading-only assessment: no runs at all — restores the failure mode
  the whole design responds to, prose positions with nothing re-taking
  them.
- Per-release experiment reconstruction: the same evidence without the
  archive — pays authoring cost every release for what re-execution
  already re-proves.
- Failed runs as trap warrants: treat a failing probe as proof of
  contradiction — mints false traps whenever the probe, not the
  product, is wrong.
