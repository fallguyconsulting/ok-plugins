---
decision: runs-lock-what-their-tests-declare
---

# Each run of the tests tool locks what its tests declare

## Choice

Before setup and the suite command start, each run of the tests tool
takes each lock its tests declare, in name order, and holds it until
the run ends. It takes a name exclusive where one of its tests holds
the name exclusive, and shared where every test of the run that holds
the name holds it shared. A whole-suite round takes every lock its
tests declare, and a run of isolated tests takes none. A run that
needs a lock another run holds waits for it, and prints one line
naming that run and the lock it waits on.

## Rationale

The suite command sees only its own run's tests, so two runs at once,
such as a fixer's rerun beside another's, would otherwise run two
tests side by side that hold one lock, one of them exclusive. A run's
lock takes the strongest mode any of its tests holds, so two runs
never run side by side a pair of tests that one run would keep apart. A run of isolated
tests can disturb no other, so it waits on nothing. A line that names
what a run waits on tells its caller why the run has not started.

## Alternatives

- Refuse a run that needs a lock another run holds: a rerun that could
  wait a few minutes fails instead.
- One lock for every run of the suite: a rerun of isolated tests waits
  on a round it cannot disturb.
- No lock across runs: a fixer's rerun runs beside a round whose tests
  hold the same lock exclusive.
