---
concept: experiment
---

# Experiment

## What it is

An experiment is a small runnable artifact that checks one assumption
or one story-way by driving the released product through its public
surface, archived together with what it observed. The experiments —
the estate's maintained collection — are audit-owned instruments:
each audit run re-runs them at the stamped commit, repairs what the surface diff makes suspect, builds
new experiments for new claims, and retires those whose surface
elements are gone.

## Purpose

An experiment produces constructive proof from the user's side: a
passing run demonstrates a behavior a user can obtain, regardless of
how well the experiment was crafted — and because an experiment cannot
reach behind the surface, its proof is about the product a user meets,
not about internals a test may shortcut. Maintaining the collection
turns re-warranting into execution plus marginal repair instead of
per-release reconstruction, which is what makes measurement affordable
on a cadence.

## Boundaries

An experiment is not a test: it drives the product only as a user
can — through elements ruled public — where a test may use any
internal entry point. The experiments belong to the audit's
machinery, not to the project's suites, and their runs are the
warrant instrument for user-vantage claims. **Nomination** is the
bridge into the project's own suites: a run nominates an experiment
worth keeping — one it had to build, passing at the stamp — by filing
an intake issue; the owner rules, and a sprint adopts it as an
ordinary test, or as an expected-fail test encoding a standing trap.
Canonizing an experiment is never the run's own act. See also:
`assessment`, `trap`, `surface-ruling`, `documentation-corpus`.

## Invariants

- An experiment exercises the product exclusively through elements the
  surface ruling classifies public.
- An experiment proves only in the affirmative: a passing run is
  constructive proof; a failing run is never a finding and only
  dispatches diagnosis.
- Conclusions never carry: an archived experiment warrants nothing
  until it is re-run at the stamp the claim is made for.
- Every archived experiment records what it ran against and what was
  observed.
- An experiment enters the project's suites only through nomination:
  an intake issue, the owner's ruling, a sprint's work.
