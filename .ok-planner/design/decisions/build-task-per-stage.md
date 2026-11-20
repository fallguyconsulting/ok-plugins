---
decision: build-task-per-stage
---

# Sprint execution runs one tracker build task per stage

## Choice

The sprint's execution shape names a task run, not a team. The
session plans and never builds: it reads the sprint and the code,
cuts the work into stages — each the smallest change that makes
progress toward the completion contract and leaves the tree runnable
— and files one **build task** per code stage into the task tracker,
naming the files it may touch, the work items and slugs it cites, and
the stages it builds on. Where the sprint plans tests, execution plans
them first, ahead of the build, and each time control the plan finds
the product lacks joins the code stages as a stage of its own (see
also: tests-planned-in-execution, planned-tests-name-their-waits).
Code stages come before the test stages, time controls among them.
Test stages follow the code stages they test: their tasks write and
verify the planned tests and change no product code, and test work
that touches no code stage's files may run beside the code stages
(see also: testing-runs-inside-the-sprint, test-tasks-own-the-tests).
The test-support, test, verify, and speed tasks run on the lean test
profile (see also: lean-profiles-carry-their-rules).

Stages with disjoint files run together; two writers never hold one
file at once, and readers run beside anything. When a stage may
start after a short close is a decision of its own (see also:
short-close-holds-named-roles). The
drain loop, plumbing the executor reads by path, drains the run: a
fresh agent per task under a vendored profile, every agent of one
profile starting from one identical message that names no task, so
each profile's starting context is one cached prefix for the whole
run (see also: no-execution-engine). Each time an agent returns, the drain fills every free slot with
a task that waits (see also: drain-fills-every-free-slot), so a stage
that becomes ready while others run starts at once. Which task an
agent's claim takes is a decision of its own (see also:
claim-takes-the-most-waited-on).

The build task writes the code, applies the stage's corpus deltas,
and records its calls, its forks, and the defects it notices outside
its files as items in the run; nothing acts on a noticed defect until
certification (see also: team-execution-cold-gate), save the upstream
issue the next paragraph names. The session writes the tracker's
rendering of the completion report before every drain, keeps the
harness checklist one entry per stage (see also:
task-tools-mirror-the-report), and edits no file a running task owns.
No agent stands across tasks, nothing is relayed by message, and no
agent is retired: a task is the unit, and its stamped usage is the
record of what it cost.

The build task files no issue but one: a harm in a part the project
does not own, which it files as an upstream issue (see also:
foreign-harms-become-upstream-issues). It makes every determined call
and records it as a divergence item. Where it meets a genuine fork —
the sprint and corpus do not determine the fix and reasonable owners
diverge — it records the fork with its options, builds the reading it
judges most plausible, and continues.

## Rationale

A task is the unit because a fresh agent per task starts from its
profile's cached prefix and leaves its result in the run. A standing
builder that the session relays rewrites its context on every relay,
and a stage's cost stays unknown until it lands. The session plans
because it already holds the sprint: a planning agent per work item
would read the code the session must read anyway. The session builds
nothing because its context is the most expensive one in the run.

One writer per file is the invariant that keeps two stages from
colliding, and readers gain nothing from waiting, so stages with
disjoint files run together. A build task records its
calls, its forks, and its noticed defects as items in the run, because
two build tasks writing one report at once would collide on one file.
Forks are rare, and certification's alignment pass reads each claimed
fork from the run, so no architect stands during the build.

Test stages follow the code stages they test, because a test checks
an outcome the code must already give, and test tasks that change no
product code keep code and tests apart.

## Alternatives

- A builder and a standing reviewer the session relays, retired
  inside a token band — relays rewrite context, and a stage's cost is
  unknown until it lands.
- The session implements alone and then certifies — every fix cycle
  re-reads the whole change cold, and the session's context is the
  most expensive one in the run.
- Strictly serial tasks — one writer per file is the invariant, and
  readers gain nothing from waiting.
- A planning agent per work item that files the builds — the
  session already holds the sprint, and a second planner reads the
  code the session must read anyway.
- The builder edits the completion report directly — two concurrent
  build tasks collide on one file; items in the run file do not.
- An architect standing during the build — forks are rare, and
  certification's alignment pass reads claimed forks from the run.
