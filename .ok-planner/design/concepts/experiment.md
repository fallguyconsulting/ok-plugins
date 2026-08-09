---
concept: experiment
---

# Experiment

## What it is

An experiment is a small runnable artifact the documentation ceremony
builds to check one assumption or one story-way against the released
product, archived in the documentation corpus together with what it
observed. It is the ceremony's warrant of last resort, reached only
when no existing test covers the behavior and reading cannot settle it
affirmatively.

## Purpose

An experiment exists to produce constructive proof where none exists in
the project's own suites: a passing run demonstrates the behavior
happened, regardless of how well the experiment was crafted. Archiving
the runnable with its observation makes the proof re-takable at the
next release without re-deriving the attempt.

## Boundaries

An experiment is not a test: it lives in the documentation corpus, is
stamped to a release, is not maintained or run by the project's suites,
and is allowed to go stale. Promotion into the maintained suite — as an
ordinary test, or as an expected-fail test encoding a standing trap —
is sprint work through the issue intake, never the ceremony's own act.
See also: `assessment`, `trap`, `documentation-corpus`.

## Invariants

- An experiment proves only in the affirmative: a passing run is
  constructive proof; a failing run is never a finding and only
  dispatches diagnosis.
- Staleness is harmless by construction: a rotted experiment that
  fails mints nothing and re-enters diagnosis at the next run.
- Every archived experiment records what it ran against and what was
  observed.
