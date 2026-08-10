---
concept: experiment
---

# Experiment

## What it is

An experiment is a small runnable artifact that checks one assumption
or one story-way by driving the released product through its public
surface, archived together with what it observed. The archive is a
maintained harness: each audit run re-runs it at the stamped commit,
repairs what the surface diff makes suspect, builds new experiments
for new claims, and retires those whose surface elements are gone.

## Purpose

An experiment produces constructive proof from the user's side: a
passing run demonstrates a behavior a user can obtain, regardless of
how well the experiment was crafted — and because an experiment cannot
reach behind the surface, its proof is about the product a user meets,
not about internals a test may shortcut. Maintaining the archive turns
re-warranting into execution plus marginal repair instead of
per-release reconstruction, which is what makes measurement affordable
on a cadence.

## Boundaries

An experiment is not a test: it drives the product only as a user
can — through elements ruled public — where a test may use any
internal entry point. The archive belongs to the audit's machinery,
not to the project's suites, and its runs are the warrant instrument
for user-vantage claims. Promotion of an experiment into the
maintained suite — as an ordinary test, or as an expected-fail test
encoding a standing trap — is sprint work through the issue intake,
never the run's own act. See also: `assessment`, `trap`,
`surface-ruling`, `documentation-corpus`.

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
