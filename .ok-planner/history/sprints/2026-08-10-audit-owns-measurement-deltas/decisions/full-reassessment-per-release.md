---
decision: full-reassessment-per-release
---

# Full re-assessment at every audit run

## Choice

Every audit run re-derives and re-verifies every conclusion:
the assumption set is synthesized fresh, every story-way and
assumption is re-warranted at the run's stamped commit, and no conclusion
carries forward on any validity test. Nothing tracks staleness and nothing invalidates
anything. The runnable instruments do carry: the experiments are
maintained in the estate, and re-running an archived experiment at the
new stamp is a fresh warrant, not a carried conclusion. The prior
release's published corpus is an input to synthesis — it is shipped,
user-visible material, so its contents are legitimate user priors —
but its conclusions never carry.

## Rationale

Smart invalidation costs more than paying for the re-run: tracking
which records survive a change is standing machinery, and the audit's
shape is the same terminus — a stamped statement about a named commit,
re-made whole each run, with "is it still current" left as a git
question. The line the decision draws is
between verdicts and instruments: a stale verdict lies, while a stale
instrument merely fails and re-enters diagnosis, so conclusions are
killed at every run and runnables are kept. Feeding the prior
corpus back in as user-visible input preserves the one thing
carry-forward genuinely bought — continuity of attention, so hard-won
traps are re-measured rather than forgotten — without carrying a
single conclusion.

## Alternatives

- Evidence-set carry-forward: keep a record while its citations still
  resolve and its surfaces are unchanged — reintroduces exactly the
  citation-tracking and invalidation machinery the audit deliberately
  deleted.
- Per-story diff invalidation: re-assess only what a release's diff
  touches — cheaper per release, but the diff-to-record mapping is
  itself standing machinery that must be maintained and trusted.
- Discarding the instruments with the conclusions: the prior shape —
  pays per-release reconstruction for evidence that re-execution
  already re-takes.
