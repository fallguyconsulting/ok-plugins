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
every agent of one profile starting from one message that differs
only in the task id on its last line, so the project context is one
cached prefix per profile for the whole run. The build task writes
the code, applies the stage's corpus deltas, tests what it built, and
records its calls and forks as items in the run's `divergences`
pool; a defect it meets outside its files it files as a finding
under its stage's key, and nothing runs that finding until the gate.
The session writes the tracker's rendering of the completion report
before every dispatch, keeps the harness checklist one entry per
stage, and edits no file a running task owns. No agent stands across
tasks, nothing is relayed by message, and no agent is retired: a task
is the unit, and its stamped usage is the record of what it cost.

The build task never files an issue. It makes every determined call
and records it as a divergence item. Where it meets a genuine fork —
the sprint and corpus do not determine the fix and reasonable owners
diverge — it records the fork with its options, builds the reading it
judges most plausible, and continues.

Code complete means every stage's build task closed `done`.
`/certify-work` runs immediately after on the same run, stays cold,
and is the only review the work gets. It runs in rounds. A round
opens with one review root on the review profile, which reads the
change once — the diff at the gate's scope, the sprint and its
sidecars, every corpus artifact the change touches, and every file
its judgment forks cover — cuts those files into areas, files each
area into the tracker, and forks one agent per pass in one message:
two enumeration forks over the whole change, where
the heading reduces to listing a population and grepping the tree for
each member; a correctness fork and a test-substance fork per area;
and, with a sprint in scope, the sprint-alignment fork. An area is a
package the change touched with its tests, a changed definition pulls
its changed callers in, a corpus delta rides with the code it
governs, and no file or line budget splits an area or merges two.
Every fork inherits the root's reading as a cached prefix, files its
own findings under the root's task, enumerates its population before
it judges, and reports the population it checked. Each family's
mechanical producers and a suite runner that runs the project's
documented full-suite command and files one finding per failure run
beside the root, each a read-only task. The tracker's triage re-keys
every finding to the gate, in any state, and folds open duplicates
onto the first filing before it matches fingerprints against the
ledger.
A reviewer marks a finding trivial only when its fix touches one
file, changes no runtime behavior, and needs no new test; a round
whose open findings all carry the mark ends there, the session fixes
them inline, and the loop exits. Otherwise the session batches every
open finding by blast radius — a shared definition with its callers,
one defect class across its sites, one surface's files, one failing
suite's cause — and files one fixer task per batch, its one judgment
inside the loop; batches with disjoint files run together. The fixer
fixes the blast radius, never the site alone: it enumerates the
callers of what it changes, the surfaces a restored capability must
reach, and the sibling members of a defect class, and adds the
assertion where a finding said nothing asserts a behavior. A defect a
fixer or architect meets that no finding names is filed and fixed in
the same task; no finding waits for a later round. A defect a
reviewer meets that the change did not introduce is still filed,
marked pre-existing, and fixed in the loop like any other; the mark
only tells the presentation where the run reached beyond the change.
The reviewers' reading stays the change and what it reaches; what
they find there is fixed, whoever made it. The architect rules on
kickbacks, refutations, forks, and reversals. In a round after fixes
the judgment forks cover only the files the previous round's fixer
and architect staged, cut by area, while the enumeration forks and
the suite cover the whole change. A fixed finding is verified at
triage when no open finding names its site, because a fork read the
site on the tree and filed nothing there. The loop ends at the first
round in which neither the fixer nor the architect edited any file
and no finding stands open. The cold reviewers hold no history, and
the root and its code-review forks stay blind to the report, so an
unrecorded divergence surfaces as a fresh finding. The alignment fork
reads the report after it forks, hands each divergence to the veto
test, and routes each claimed fork to the architect. No task leaves a
process of its own running when it closes.

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
contract is judgment. An earlier trial showed the cheaper profile
reporting nothing where the stronger one found four defects in the
same files, and a later run's stronger-profile round filed
load-bearing findings the cheaper rounds after it did not have the
chance to find. The judgment passes ride the cheaper profile anyway,
on cost: that run's review tasks cost about the same whether they
read one file or eight, because each read the sprint, the sidecars,
and the corpus before its diff, and the stronger profile's tasks cost
more than half again. Whether the cheaper profile's first-round
findings on a fresh change match the stronger profile's is
unmeasured; the `correctness` pass is the one row that would move out
of the review root into a task of its own under the stronger profile
if they do not. The review root exists because that fixed cost is the
reading, and one reading forked to every pass is paid once. A
root that reads too much makes every fork start heavy; the areas are
what the judgment forks read, and the root reads the rest once.
Closing on a checked population is what turns "one reviewer's luck"
into coverage: a finding on one force flag becomes a finding on every
force flag.

Areas replace a file budget because a budget is arbitrary and a split
costs twice: the run that cut twelve one-file batches paid the fixed
reading twelve times over, and a definition split from its callers
leaves the fork that receives the callers paying to learn the
definition. An area is as large as it is, and the fork that reads it
reads it from the cache.

The trivial mark and the hatch exist because a round is the cost
unit: a round whose review returns nits only still pays a full round
of fixers and a full round of review after them. Seventeen of the
measured run's 147 findings met the mark's definition, and no round's
open set was nits alone, so the hatch would have fired zero times
there; it pays for itself the first time a verification round returns
a stale sentence and an unused import.

Triage re-keys and folds in the tracker because the measured run's
orchestrator skipped the prose re-key step once, leaving five build
findings out of the first round, and accepted a `duplicate` state a
reviewer invented on seven of its own findings. A prose step can be
skipped; a verb's first step cannot.

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
can drift toward the builder's framing. A fresh sweep over the whole
diff is the check on that, and the last round's sweep is the one that
discharges the completion contract.

The first round reviews the whole change, and a round after fixes
reads the staged files in its judgment forks and the whole change in
its enumeration forks and its suite. One run under a staged-only
shape closed clean with five orphan symbols in three files no fixer
touched; orphan symbols are what the enumeration forks list, and they
cover the whole change every round. In the measured run, seventeen of
eighteen findings in the second round and seven of eight in the third
fell in files the previous round's fixers staged, and the two
exceptions were a skipped re-key and a sibling site a class sweep
missed, neither a defect in an untouched file. The root cuts the
areas so the tracker, not a fork's own claim, records which files
each judgment fork was given, and every covered file is in exactly
one area each round, the release documents excepted.

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
- The judgment passes on the stronger profile — it filed the deepest
  findings the measured run had, and cost more than half again per
  task on a run whose review cost was mostly fixed reading.
- A review planner task and one task per pass per batch — every task
  read the sprint, the sidecars, and the corpus again before its
  diff, and the run's cost followed its task count.
- A file budget on a batch — a budget of about ten files produced
  twelve one-file batches in one round, each paying the fixed reading
  to review one file.
- The tracker groups fixes by file — it cannot see a shared cause
  across files, and it turned 63 findings into 40 tasks.
- One fixer for every finding — a batch has to fit one agent's
  reading; the session splits by blast radius and by size.
- The suite as an exec task the session runs and parses — the
  session pays for the output at its own context's price and does an
  investigator's job when a run trips a watchdog.
- Strictly serial tasks — one writer per file is the invariant, and
  readers gain nothing from waiting.
- Every round's judgment forks over the whole change — the measured
  run re-read the whole change three times to find that the findings
  after fixes sat in the staged files.
- A verify pass reading the round's edits as hunks against a
  recorded tree, with no whole-change enumeration beside it — a
  defect the first sweep missed in a file no fixer touches is never
  read again, and the loop exits clean over it.
- Every finding through a fixer task, nits included — a round whose
  review returns a stale sentence and an unused import pays a full
  round of fixers and another round of review.
- A prose re-key step before triage — skipped once in the measured
  run, leaving five build findings out of the first round.
- Each pass enumerates the change from git and picks its own files —
  nothing but the pass's closing line records what it read, and a
  pass that under-enumerates closes clean.
- A planning agent per work item that files the builds — the
  session already holds the sprint, and a second planner reads the
  code the session must read anyway.
- File a defect the change did not introduce to the intake instead
  of fixing it — the fixer already holds the code and the finding,
  the issue needs no ruling, and the defect waits for a sprint that
  re-reads what this run has in hand.
- The builder edits the completion report directly — two concurrent
  build tasks collide on one file; items in the run file do not.
- An architect standing during the build — forks are rare; the gate's
  architect reads claimed forks from the run.
