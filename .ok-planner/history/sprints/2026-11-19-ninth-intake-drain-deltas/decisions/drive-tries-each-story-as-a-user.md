---
decision: drive-tries-each-story-as-a-user
---

# A drive tries each story with a driver of its own and no written plan

## Choice

Every drive gives each story it takes its own driver, once per run,
save a refile of a driver that closed `partial` and a drive again, one
driver at a time, after the shared stack broke.
Which runs drive, and which stories each takes, are decisions of their
own (see also: one-drive-procedure-fixes-nothing,
certification-drives-what-the-sprint-changes). The driver reads the
story's role, capability, and benefit, and works out from the running
product how to get the benefit on every surface the story is offered
through. Nothing about a drive is written down between runs. How a
project with no stack declares it is a decision of its own (see also:
stack-helpers-serve-project-commands), and so is how a merge sorts
each failure (see also: drive-merge-sorts-each-failure).
Certification routes each failure as it routes every defect (see
also: team-execution-cold-gate,
defects-outside-scope-become-defect-issues).

How a driver works is a set of decisions of their own: the variants it
drives (see also: drive-takes-every-named-variant), the order it acts
in (see also: drive-acts-in-a-first-time-users-order), what it may use
(see also: driver-uses-only-the-public-surface), where it writes (see
also: drive-writes-only-in-scratch), a surface that is a skill (see
also: skill-surfaces-reviewed-not-driven), and the drive that confirms
a fix (see also: one-confirm-driver-per-defect).

## Rationale

A written drive plan breaks whenever the product changes, and keeping
one current is work that grows with the product. A driver that works
from the story derives its path again on every run, so a change that
keeps the story met keeps the drive passing. The cost is that every
run that drives pays to drive each story it takes; the drive is where
a run spends its tokens. One driver per story is the least that tries
every story: a second driver of the same story costs as much again,
with no assurance it takes another path.

## Alternatives

- A maintained drive script per story, replayed each run — cheap per
  run and repeatable, and each script breaks on any change that keeps
  the story met, so the run fixes scripts instead of the product.
- Two independent drivers per story — twice the cost, with no
  assurance the second driver takes another path.
