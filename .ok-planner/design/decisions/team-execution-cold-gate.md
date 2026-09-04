---
decision: team-execution-cold-gate
---

# Sprint execution runs as tracker tasks; certification stays cold

## Choice

The sprint's execution shape names a task run, not a team. The
session plans and never builds: it reads the sprint and the code,
cuts the work into stages — each the smallest change that makes
progress toward the completion contract and leaves the tree
runnable — and files one **build task** and one **review task** per
stage into the task tracker, naming the files each may touch, the
work items and slugs it cites, and the stages it builds on. The
`execute-tasks` loop drains the run: a fresh agent per task under a
vendored profile, every agent of one profile starting from one
identical message, so the project context is one cached prefix per
profile for the whole run. The build task writes the code, applies
the stage's corpus deltas, tests what it built, and records its
calls and forks as items in the run's `divergences` pool. The review
task reads the paths the build staged under the certification gate's
own code-review brief and the gate's alignment questions scoped to
the stage, plus the read-only per-stage producers each family's
ceremony contribution names, and files findings into the stage's
pool. Open findings become fix tasks and a re-review, bounded at
three rounds per stage; remainders become claimed forks for the
gate's architect. The session renders the completion report from the
run file before every dispatch and edits no file a running task
owns. No agent stands across tasks, nothing is relayed by message,
and no agent is retired: a task is the unit, and its stamped usage
is the record of what it cost.

The build task never files an issue. It makes every determined call
and records it as a divergence item. Where it meets a genuine fork —
the sprint and corpus do not determine the fix and reasonable owners
diverge — it records the fork with its options, builds the reading it
judges most plausible, and continues. The certification loop's fixer
role folds into the build's fix task during the build; the architect
exists only at the terminal gate.

Code complete means every stage's findings pool is empty.
`/certify-work` runs immediately after on the same run and stays
cold: it files the suites and the lint as exec tasks, the code review
of the whole diff and the sprint-alignment judge as tasks, and its
fixer batches and architect as tasks, round by round against the
run's `findings` pool. The cold reviewer holds no history and stays
blind to the report, so an unrecorded divergence surfaces as a fresh
finding. The judge hands each divergence to the veto test and each
claimed fork to the architect.

## Rationale

The prior shape stood a builder and a reviewer across the sprint and
fed them stages by message, retiring each inside a band of measured
context. The suite measured one execution and found where the cost
went: every relay rewrote the standing agent's whole context, and a
builder fed stage after stage grew past the band before the session
could stop it, because the session sees an agent's size only after the
stage lands. Project startup context was under one percent of the
cost. A fresh agent per task pays that startup from the cache and
carries only its own stage. The size of the work item, which the
session sets at planning, is the one thing the harness lets the suite
control.

Planning belongs to the session because cutting a sprint into
runnable stages needs the sprint and the code both in view, and the
files each stage may touch are what let independent stages run
together without colliding. The run file replaces the ledger file:
every finding, divergence, and staged path is an item the tracker
wrote, so a replacement session renders the same report and files
the same next task from disk, never from a summary.

The gate stays cold because a reviewer that has watched the code grow
can drift toward the builder's framing. One fresh pass over the whole
diff is the check on that, and it is the pass that discharges the
completion contract.

## Alternatives

- A builder and a standing reviewer the session relays, retired
  inside a token band — the prior shape: relays rewrite context, and
  a stage's cost is unknown until it lands, so the band could not
  stop a builder growing past it.
- The session implements alone and then certifies — every fix cycle
  re-reads the whole change cold.
- A planning agent per work item that files the builds — the
  session already holds the sprint, and a second planner reads the
  code the session must read anyway.
- One build task per work item, unsized — a work item that exceeds
  one agent's reading set repeats the standing builder's failure in
  one task.
- The builder edits the completion report directly — two concurrent
  build tasks collide on one file; items in the run file do not.
- A dedicated test reviewer beside the code reviewer — forks the
  review dialect certification uses; a second instance of the same
  brief scoped to test files is a scaling call, not a role.
- The review task runs the suites and lint — the reviewer stays
  read-only; the build task tests what it built and the gate runs
  the regression.
- An architect standing during the build — forks are rare; the gate's
  architect reads claimed forks from the run.
