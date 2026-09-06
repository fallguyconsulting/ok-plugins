---
decision: team-execution-cold-gate
---

# Sprint execution runs as tracker build tasks; the cold gate is the one review

## Choice

The sprint's execution shape names a task run, not a team, and the
build runs no review of its own. The session plans and never builds:
it reads the sprint and the code, cuts the work into stages — each
the smallest change that makes progress toward the completion
contract and leaves the tree runnable — and files one **build task**
per stage into the task tracker, naming the files it may touch, the
work items and slugs it cites, and the stages it builds on. Stages
with disjoint files run together; two writers never hold one file at
once, and readers run beside anything. The `execute-tasks` loop
drains the run: a fresh agent per task under a vendored profile,
every agent of one profile starting from one identical message, so
the project context is one cached prefix per profile for the whole
run. The build task writes the code, applies the stage's corpus
deltas, tests what it built, and records its calls and forks as items
in the run's `divergences` pool; a defect it meets outside its files
it files as a finding under its stage's key, and nothing runs that
finding until the gate. The session writes the tracker's rendering
of the completion report before every dispatch, keeps the harness
checklist one entry per stage, and edits no file a running task
owns. No agent stands across tasks, nothing is relayed by message,
and no agent is retired: a task is the unit, and its stamped usage is
the record of what it cost.

The build task never files an issue. It makes every determined call
and records it as a divergence item. Where it meets a genuine fork —
the sprint and corpus do not determine the fix and reasonable owners
diverge — it records the fork with its options, builds the reading it
judges most plausible, and continues.

Code complete means every stage's build task closed `done`.
`/certify-work` runs immediately after on the same run, stays cold,
and is the only review the work gets. Its first sweep files every
producer together, each a read-only task: the code review as four
passes over the whole diff — two enumeration passes on the cheaper
profile, where the heading reduces to listing a population and
grepping the tree for each member, and two judgment passes on the
stronger profile — the sprint-alignment judge on the stronger
profile, each family's mechanical producers, and a suite runner that
runs the project's documented full-suite command and files one
finding per failure. Every pass enumerates its population before it
judges and closes on the population it checked. The session then
batches every open finding by blast radius — a shared definition with
its callers, one defect class across its sites, one surface's files,
one failing suite's cause — and files one fixer task per batch, its
one judgment inside the loop; batches with disjoint files run
together. The fixer fixes the blast radius, never the site alone: it
enumerates the callers of what it changes, the surfaces a restored
capability must reach, and the sibling members of a defect class, and
adds the assertion where a finding said nothing asserts a behavior.
A defect a reviewer meets that the change did not introduce is still
filed, marked pre-existing; triage checks the mark against the
change's hunks, files the defect to the intake, and dispatches no
fixer for it, so the sprint fixes what it broke and files what it
found. The architect rules on kickbacks, refutations, forks, and
reversals. A verify pass reads the round's edits as hunks against the
round's recorded tree, not whole files. The loop ends at the first round in
which neither the fixer nor the architect edited any file. The cold
reviewers hold no history and stay blind to the report, so an
unrecorded divergence surfaces as a fresh finding. The judge hands
each divergence to the veto test and each claimed fork to the
architect.

## Rationale

The prior shape reviewed every stage as it landed and reviewed the
whole diff again at the gate. The suite measured one execution of it.
The stage reviews filed 31 findings. The gate filed 32 more over the
same code. The per-stage loop turned 63 findings into 40 fix tasks,
and most held one finding. The tasks ran chained one after another,
and each was a fresh agent paying the same startup for a two-minute
edit. Several stage findings named intermediate states a later stage
was already going to remove. The
one cross-stage defect was fixed piecemeal across three stages where
one fixer holding the whole diff would have made one fix. Reviewing
once, over the finished work, removes the duplicated reading, and
batching by blast radius removes the per-finding dispatch.

The passes split by what the heading needs. A heading that lists a
population and greps the tree for each member is enumeration, and a
trial on the same diff showed the cheaper profile does it well:
enumerating 56 deleted names found stale references no whole-file
reviewer had seen in seven rounds. A heading that judges a function's
contract is judgment, and the same trial showed the cheaper profile
reporting nothing where the stronger one found four defects in the
same files. Closing on a checked population is what turns "one
reviewer's luck" into coverage: a finding on one force flag becomes a
finding on every force flag.

The fixer's blast-radius rule answers where fix-introduced defects
came from: every one landed exactly at the site the finding named,
in a property nothing asserted — a caller left passing a flag nothing
read, a capability restored server-side and unreachable from the
CLI, an advice sentence naming a verb that refuses the case at hand
— so the fixer's tests passed and a reader found each one a round
later.

The session batches because cutting findings into fixes needs the
whole pool and the code in view, the same reason it stages the build,
and because the tracker's mechanical grouping by file cannot see that
two findings in two files share one cause. The suite is a task so no
session reads suite output at its own context's price; the measured
run spent ten turns of a half-million-token context diagnosing one
watchdog trip.

The gate stays cold because a reviewer that has watched the code grow
can drift toward the builder's framing. One fresh sweep over the
whole diff is the check on that, and it is the sweep that discharges
the completion contract.

## Alternatives

- A build task and a review task per stage, with a per-stage fix
  loop — the prior shape: duplicated reading, findings about
  intermediate states, one fresh agent per finding.
- A builder and a standing reviewer the session relays, retired
  inside a token band — the shape before that: relays rewrite
  context, and a stage's cost is unknown until it lands.
- The session implements alone and then certifies — every fix cycle
  re-reads the whole change cold, and the session's context is the
  most expensive one in the run.
- One code reviewer over the whole diff with the full brief — one
  agent's coverage is the set of files it read times what it
  noticed, and the trial showed it missing a class's siblings.
- Every pass on the stronger profile — the enumeration headings do
  not need it, and three passes on the cheaper profile together cost
  under half of one pass on the stronger one.
- The tracker groups fixes by file — it cannot see a shared cause
  across files, and it turned 63 findings into 40 tasks.
- One fixer for every finding — a batch has to fit one agent's
  reading; the session splits by blast radius and by size.
- The suite as an exec task the session runs and parses — the
  session pays for the output at its own context's price and does an
  investigator's job when a run trips a watchdog.
- Strictly serial tasks — one writer per file is the invariant, and
  readers gain nothing from waiting.
- The verify pass re-reads every staged file whole — each round
  found new defects in files a fix had touched one function of,
  including defects that predate the sprint.
- A planning agent per work item that files the builds — the
  session already holds the sprint, and a second planner reads the
  code the session must read anyway.
- The builder edits the completion report directly — two concurrent
  build tasks collide on one file; items in the run file do not.
- An architect standing during the build — forks are rare; the gate's
  architect reads claimed forks from the run.
