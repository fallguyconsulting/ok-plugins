---
decision: code-complete-at-latest-filing
---

# Code complete counts each task by its latest filing

## Choice

Code complete means every task of every build stage, and every task
of every test stage, closed `done` at its latest filing, and no test
stage is left to file a task: a task that
closed `partial` or `blocked` and was filed again counts by its
refile. Sprint certification starts once code complete holds (see
also: team-execution-cold-gate).

## Rationale

A task that stops short runs again as a refile: a build stage that
closed `partial` is filed again for its remainder, and a test task
that closes `blocked` waits on a test support task and runs again. So
a stage's work is done when its latest task is. Counting the latest
filing lets a stage that finished on its second filing count as
finished, and keeps a stage whose latest filing stopped short from
counting as built.

## Alternatives

- Code complete once every filed task has closed, whatever its
  outcome — a stage that stopped short counts as built, and
  certification reviews unfinished work.
- Code complete only where every filing of every task closed `done` —
  a task that closed `blocked` and finished as a refile keeps the run
  from code complete for good.
