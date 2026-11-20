---
decision: review-forks-own-pass-tasks
---

# Sprint certification's review is one reading forked to a pass task per fork

## Choice

One review root on the review profile reads the sprint whole, the
change, each work item's path from its entry point to its outcome,
and the users of every changed definition — its callers, the code
that reads the same stored data, and what each release boundary
names. That reading fixes the run's scope. The root files one pass
task per pass, forked from its own task, closes its own task, and
forks one agent per pass task in one message. Every fork inherits the
root's reading as a cached prefix, claims the pass task its prompt
names, and closes that task. The tracker refuses a second claim of any
task, so a fork can claim only the pass task its prompt names. Each
pass enumerates before it judges, and closes its task with what it
checked. A pass task a fork left open is reissued
by the drain to a fresh agent of the profile, which reads cold. How
the passes split is a decision of its own (see also:
review-passes-split-by-reading).

## Rationale

The review root exists because the fixed cost of a pass is the
reading, and one reading forked to every pass is paid once. Every
pass rides `opus`, per `decision:subagent-model-follows-job`, and the
root pays that cost once per reading, since the forks share it. One
reading also fixes what the passes read: a pass that enumerated the
change on its own would record what it read only in its closing line,
and a pass that under-enumerated would close clean.

Each fork owns a pass task because a fork is a copy of the root's
transcript, and the root's own claim and close are in it as the
fork's own memory. Two measured runs recorded a fork acting as the
root in three of seventeen review rounds: forks claimed, closed, or
forked on the root's task, one round held five review-root records,
and the root's recovery reading cost more than the reports it
produced. A profile line telling a fork to claim nothing did not
bind against that memory. With the root's task closed before the
fork and one pass task per fork, the fork's memory and its
instruction agree: the task it remembers claiming is closed, the
only task it can claim is the one its prompt names on its last
line, and the tracker refuses a second claim of any task.
A fork that never closes its pass task is then an ordinary open
task for the drain, which reissues it cold; the root re-runs
nothing in its own context.

Closing on what was checked is what turns one reviewer's luck into
coverage: a report on one force flag becomes a report on every force
flag.

## Alternatives

- One task per pass and no fork — every pass reads the sprint, the
  sidecars, and the corpus again, and the reading is the cost.
- Each pass enumerates the change from git and picks its own files —
  nothing but the pass's closing line records what it read, and a
  pass that under-enumerates closes clean.
- Forks that file reports under the root's open task and return a
  line — the measured shape: a fork that inherits the root's claim
  acts on it, and the root's task is the one it closes.
- Reorder the root's reads so it forks before it claims — the claim
  is the only command that prints the task's prompt, and the claim
  and close instructions a fork misreads are in the profile's
  system prompt, which every fork inherits at any point.
- A claim token printed after the fork point that `close` requires —
  a misread becomes a refused command instead of a corrupted run,
  and the fork still holds an instruction it cannot follow.
- A pass that closes with its findings alone — a report on one site
  stays a report on one site, and nothing records what the pass
  checked.
