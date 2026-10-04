---
decision: team-execution-cold-gate
---

# Sprint execution runs as tracker build tasks; sprint certification is the one review

## Choice

The sprint's execution shape names a task run, not a team, and the
build runs no review of its own. The session plans and never builds:
it reads the sprint and the code, cuts the work into stages — each
the smallest change that makes progress toward the completion
contract and leaves the tree runnable — and files one **build task**
per stage into the task tracker, naming the files it may touch, the
work items and slugs it cites, and the stages it builds on. Stages
with disjoint files run together; two writers never hold one file at
once, and readers run beside anything. The drain loop, plumbing the
executor reads by path, drains the run: a fresh agent per task under
a vendored profile, every agent of one profile starting from one
identical message that names no task, so the project context is one
cached prefix per profile for the whole run. The build task writes
the code, applies the stage's corpus deltas, and records its calls,
its forks, and the defects it notices outside its files as items in
the run; nothing acts on a noticed defect until certification. The
session writes the tracker's rendering of the completion report
before every dispatch, keeps the harness checklist one entry per
stage, and edits no file a running task owns. No agent stands across
tasks, nothing is relayed by message, and no agent is retired: a task
is the unit, and its stamped usage is the record of what it cost.

The build task never files an issue. It makes every determined call
and records it as a divergence item. Where it meets a genuine fork —
the sprint and corpus do not determine the fix and reasonable owners
diverge — it records the fork with its options, builds the reading it
judges most plausible, and continues.

Code complete means every stage's build task closed `done`. Sprint
certification, `/converge sprint`, runs immediately after in a ledger
of its own, stays cold, and is the only review the work gets. It
reads the change from the sprint's base commit to the working tree,
once. One review root on the review profile reads the sprint whole,
the change, each work item's path from its entry point to its
outcome, and the users of every changed definition — its callers, the
code that reads the same stored data, and what each release boundary
names. That reading fixes the run's scope. The root files one pass
task per pass, forked from its own task, closes its own task, and
forks one agent per pass task in one message: a completion pass per
group of work items that share code, walking each outcome and every
failure path off it; a regression pass per group of changed
definitions that share users, judging each behavior change against
the implementation notes' rulings; and one alignment pass over the
whole sprint, which compares each delta with its applied artifact,
checks the change against the commitments the sprint names, and
alone reads the build's divergences. Every fork inherits the root's
reading as a cached prefix, claims the pass task its prompt names,
enumerates before it judges, and closes the task with what it
checked. A pass task a fork left open is reissued by the drain to a
fresh agent of the profile, which reads cold. Beside the review, the
project's checks run over the files the change added or changed, and
drivers try each story the sprint adds or amends on the running
product.

A merge agent folds the passes' reports, the checks' failures, the
drive's failures, and the build's noticed defects into one defect
list. What lies outside the sprint's scope goes to the intake as a
defect issue, and what needs the owner's judgment, or a fix in a
skill, tooling, or corpus file, goes to the intake as a judgment
issue. Fixers work through the list once, defects grouped by the
files their fixes touch. A verifier reads only the change each fixer
made, against each defect, the accept list, and the release
boundaries. A fix a verifier sends back is fixed again, until none is
sent back or the defect reaches its limit of send-backs; then an
agent backs its change out of the tree and it goes to the intake as a
judgment issue. Nothing re-reviews code a fix changed. The checks run
once more when the fixes end. No task leaves a process of its own
running when it closes.

## Rationale

Reviewing every stage as it lands and the whole diff again at the
end reads the same code twice. One measured execution of that
alternative shows the cost. The stage reviews reported 31 defects. The
final review reported 32 more over the same code. The per-stage loop
turned 63 defects into 40 fix tasks, and most held one defect. The
tasks ran chained one after another, and each was a fresh agent paying
the same startup for a two-minute edit. Several stage reports named
intermediate states a later stage was already going to remove. The one
cross-stage defect was fixed piecemeal across three stages where one
fixer holding the whole diff would have made one fix. Reviewing once,
over the finished work, removes the duplicated reading, and grouping
defects by the files their fixes touch removes the per-defect
dispatch.

Certification fixes each defect once and verifies only each fix,
per `decision:converge-finds-then-fixes`: review rounds that re-read
every file a fix touched found something new in the code the last fix
had added, so they did not end on their own. Every pass rides `opus`,
per `decision:subagent-model-follows-job`, and the review root pays
that cost once per reading, since the forks share it. The review root
exists because the fixed cost of a pass is the reading, and one
reading forked to every pass is paid once.

The passes split by what each needs to read. A completion pass
follows an outcome from its entry point, so its group is the work
items whose paths share code. A regression lands in a user the diff
does not show, so a regression pass reads each changed definition's
users, grouped by the users they share. No file budget splits a group
or merges two: a split costs twice, since a definition split from its
callers leaves the pass that receives the callers paying to learn the
definition. Only the alignment pass reads the executor's account, so
the code passes judge blind to it and a divergence the executor did
not record surfaces as a report.

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
nothing in its own context. Closing on what was checked is what turns
one reviewer's luck into coverage: a report on one force flag
becomes a report on every force flag.

The drive runs beside the review because a pass reads code, and a
story is met only when a user gets what it promises from the running
product.

Certification stays cold because a reviewer that has watched the code
grow can drift toward the builder's framing. A fresh reading of the
whole change is the check on that, and it is what discharges the
completion contract.

## Alternatives

- A build task and a review task per stage, with a per-stage fix
  loop — duplicated reading, reports about
  intermediate states, one fresh agent per defect.
- A builder and a standing reviewer the session relays, retired
  inside a token band — relays rewrite context, and a stage's cost is
  unknown until it lands.
- The session implements alone and then certifies — every fix cycle
  re-reads the whole change cold, and the session's context is the
  most expensive one in the run.
- One code reviewer over the whole diff with the full brief — one
  agent's coverage is the set of files it read times what it
  noticed, and the trial showed it missing a class's siblings.
- Review rounds that re-read every file the last round's fixes
  touched, until a round finds nothing — each re-read found something
  new in the code the last fix had added.
- A file budget on a pass — a budget of about ten files produced
  twelve one-file batches in one round, each paying the fixed reading
  to review one file.
- Strictly serial tasks — one writer per file is the invariant, and
  readers gain nothing from waiting.
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
- One task per pass and no fork — every pass reads the sprint, the
  sidecars, and the corpus again, and the reading is the cost.
- Each pass enumerates the change from git and picks its own files —
  nothing but the pass's closing line records what it read, and a
  pass that under-enumerates closes clean.
- A planning agent per work item that files the builds — the
  session already holds the sprint, and a second planner reads the
  code the session must read anyway.
- The builder edits the completion report directly — two concurrent
  build tasks collide on one file; items in the run file do not.
- An architect standing during the build — forks are rare, and
  certification's alignment pass reads claimed forks from the run.
