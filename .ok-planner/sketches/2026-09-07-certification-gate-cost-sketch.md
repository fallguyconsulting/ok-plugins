# Certification gate cost — Design Sketch

**Date:** 2026-09-07
**Status:** Sketch (not a sprint; not authorization to build)

## Idea

The certification gate spends most of its tokens on review tasks whose cost
barely depends on what they review. This sketch records the decisions the
owner and the session reached after reading the `2026-09-06-ruled-issues`
run in the linescout platform project: one forking review root per round in
place of a planner task and per-batch review tasks, batches cut by logical
area with no size budget, a round after fixes that re-reviews staged files
only, a reviewer-marked trivial class that ends the loop without a fixer,
fixers and architects that fix what they meet, and tracker changes that turn
four prose steps into mechanics.

## Evidence from the run

The run file `.ok-planner/sprints/2026-09-06-ruled-issues-run.jsonl` in the
linescout platform project records 149 tasks over a build and three rounds,
16.8M stamped tokens, 147 findings.

| Round | Judgment-pass profile | Batches | Review tasks | Review tokens | Findings |
| --- | --- | --- | --- | --- | --- |
| 1 | opus | 11 | 24 | 3.4M | 97 |
| 2 | sonnet | 23 | 48 | 5.6M | 18 |
| 3 | sonnet | 8 | 18 | 2.6M | 8 |

A review task's cost is mostly fixed. A one-file batch cost a median 104K
tokens and an eight-or-more-file batch a median 157K. The fixed part is the
sprint, the delta sidecars, and the corpus files the change touches, which
every review task read in full before its diff. Round 2 cut 12 one-file
batches, so 24 of its tasks paid the floor to review one file each.

Findings in a round after fixes fell almost entirely in files the previous
round's fixers staged: 17 of 18 in round 2, 7 of 8 in round 3. The two
exceptions were a build finding the orchestrator never re-keyed into round 1
and a sibling site a fixer's class sweep missed.

The three producers (suite runner, practice-citation sweep, workspaces
sweep) read nothing the review passes read. The alignment judge read 42 of
the 54 paths the review passes read, plus the completion report.

The orchestrator made two mistakes of its own. It skipped the re-key step
before round 1's triage, so five build findings entered no round until round
2. It accepted a `duplicate` state a review task set on seven of its own
findings, a state the skill never defines, and carried 14 such rows into the
final ledger. `tasks claim` took whichever task was next open, so about seven
review agents closed a task other than the one their dispatch named.

Fixers ran `until grep ... sleep` pollers in the background and left them
running after closing. The orchestrator stopped nine after the build and
found more after round 3.

The opus round filed load-bearing findings: a deny-set race caught by four
passes, a revival that skipped a revived stream's first records, bindings
stuck until a restart. Whether sonnet catches the same on a fresh change is
open; rounds 2 and 3 reviewed an already-fixed change, so the run cannot
separate the model from the round.

## Shape

### Profiles

Judgment passes, the alignment judge, and every reader ride `ok-sonnet` or
the new review profile. The fixer, the architect, and the build ride
`ok-opus`. This part is already in the canonical source, staged.

A new profile `ok-review` under `.claude/agents/`, modeled on `ok-audit`:
model `sonnet`, effort `high`, `Agent` allowed for forks of itself only. A
fork claims nothing, closes nothing, never forks, does its one job, and ends
with one report line. A fork inherits the root's model and context, so the
root's reading is a cached prefix for every fork.

### The review root

One task per round replaces the review planner, the four per-round pass
tasks, and the per-batch judgment tasks. The root:

1. Claims the task. Reads the sprint, its delta sidecars, every corpus
   artifact the change cites or the deltas touch, and the whole diff at
   the gate's scope, deletions included. Reads no completion report.
2. Cuts the change into batches by logical area and files one `batches`
   item per batch, so the tracker keeps the record of what each fork was
   given.
3. Forks, all in one message: one `references` fork and one
   `test-inventory` fork over the whole change; one `correctness` fork and
   one `test-substance` fork per batch; and, with a sprint in scope, one
   alignment fork, which reads the completion report after the fork.
4. Collects each fork's one-line report, closes the task with every fork's
   checked population in the result. Findings are filed by the forks under
   the root's task id. A fork that errors or returns no report line is the
   root's to re-run or diagnose in the same task; the root closes only when
   every fork has reported.

The three producers stay separate tasks. They share no reading with the
root.

### Batching by area

An area is a package the change touched, with its tests. A changed
definition pulls its changed callers into its batch, across packages where
needed. A corpus delta rides with the area it governs, so the fork that
checks the delta landed is the one that read the code. An area is never
split and two areas are never merged. There is no file or line budget: a
budget is arbitrary and a split forces the receiving fork to pay to get up
to speed.

### Rounds

Round 1 reviews the whole change. A round after fixes reviews, in its
judgment forks, only the files the previous round's fixer and architect
staged, cut by area; the enumeration forks and the suite runner still cover
the whole change. The exit test is unchanged: the loop ends at the first
round in which neither the fixer nor the architect edited any file and no
finding stands open.

### The trivial escape hatch

A reviewer marks a finding `severity=trivial` at filing when the fix touches
one file, changes no runtime behavior, and needs no new test: a doc
sentence, a comment, a name, a stale catalog line, an unused import, a
missing annotation slug, a blank line. A fix that edits a function body, a
test assertion, or a corpus commitment is never trivial. The fixer never
marks.

After triage, if every open finding is trivial, the round ends: the session
fixes them inline, runs the lint and the suite command once, closes each
`fixed` with the paths staged, and the loop exits. If any non-trivial
finding stands, the round runs as now, with the trivial findings batched to
fixers alongside the rest.

A trivial-marked finding whose fix turns out to need a function body, a
test assertion, or a corpus commitment does not restart the rounds. The
session files it as an intake issue for a future sprint, closes the item
`promoted --note <issue file>`, and the loop still exits. The mark's
purpose is to stop the rounds and let the sprint close.

In the reviewed run, 17 of 147 findings met the definition, and no round's
open set was trivial alone, so the hatch would have fired zero times there.
It earns its cost when a verification round returns nits only.

### Fix on sight

A fixer or architect that meets a defect no finding in its batch names
files it and fixes it in the same task under the same rules, closing the
item `fixed`. Already in the canonical source, staged.

### Tracker mechanics

- `tasks close --item` and `tasks item set` reject a state outside the
  defined vocabulary.
- `tasks item triage` re-keys every `findings` item to the gate's key as its
  first step; the prose re-key step in the round disappears.
- Triage folds same-round duplicates: two open findings with one
  fingerprint in one round keep the first open and close the rest as
  repeats of it. A recurrence is only a match against an earlier round's
  row.
- `tasks claim <task>` claims that task only; the drain passes the task id
  into the fixed dispatch message. Forks never claim.
- Build and fixer prompts forbid background pollers: tests run in the
  foreground, and an agent closes with no process of its own still running.

### Where the text changes

- `plugins/ok/families/ok-planner/skills/_shared/certification-core.md`:
  round steps 1 through 6, the review root prompt replacing the planner and
  pass prompts, the alignment prompt as a fork body, the trivial mark in
  the review brief, the hatch in triage and the exit, the poller ban in the
  fixer and build prompts.
- `plugins/ok/families/ok-planner/agents/ok-review.md`: new.
- `plugins/ok/families/ok-planner/scripts/tasks` and
  `plugins/ok/families/ok-planner/test/tasks.py`: the four mechanics.
- `plugins/ok/families/ok-planner/skills/execute-tasks/SKILL.md`: the claim
  id in the dispatch message.
- The restatements: `plugins/ok/CLAUDE.md`, `plugins/ok/rules/ok-cheatsheet.md`,
  `plugins/ok/families/ok-planner/scripts/ok-planner-cheatsheet.md`,
  `plugins/ok/families/ok-planner/scripts/ok-planner-CLAUDE.md`,
  `plugins/ok/families/ok-planner/ceremony/certify-work.md`,
  `plugins/ok/families/ok-planner/skills/_shared/sprint-document.md`.
- Corpus: `decision:subagent-model-follows-job` says review jobs ride opus
  and every fork is refused. Both sentences change: review rides sonnet,
  and a profile that pins a model may fork itself. `decision:team-execution-cold-gate`
  says every round reviews the whole change; the round-after-fixes clause
  changes it.

## Open questions

- Whether the root reads every corpus artifact the change cites, or only
  the ones the deltas touch. The sketch assumes every cited artifact, since
  a judgment fork verifies deltas landed and reads the cited artifact's
  Boundaries.
- Whether an alignment fork that reads the completion report after forking
  keeps enough of the blind-review property. The sketch assumes yes: the
  root and the review forks never see the report.
- Whether the trivial mark needs the architect's check when a fixer
  disputes it. The sketch assumes no: the fixer never marks and never
  unmarks, and a wrongly marked finding becomes an intake issue.
- Whether the root's context, with the whole diff and every cited
  artifact, stays under the point where a fork's own reading gets
  expensive. The reviewed run's largest diff was 75 files.
- How the run file records a fork's findings: under the root's task id
  with a `fork` field naming the pass and batch, or as the root's alone.
  The sketch assumes a field.
- Whether the same-round duplicate fold should prefer the first filing or
  the fuller body. The sketch assumes the first.

## Risks / unknowns

- Sonnet as the round-1 judgment reviewer is unmeasured. The next sprint
  runs it from round 1; if its findings are shallower than the opus round
  here, the decision reverts for the correctness pass alone.
- A round that reviews staged files only misses a defect a fix causes in a
  file it did not touch. The enumeration forks and the full suite are the
  guard; they caught neither exception in the reviewed run, but neither
  exception was of that kind.
- The fork tool inherits the root's whole context. A root that reads too
  much makes every fork start heavy, and the saving inverts.
- The hatch lets the session edit code, which the loop otherwise forbids.
  The tight definition is the whole safety of it.
- The `duplicate` state and the skipped re-key were orchestrator errors the
  prose could not prevent. The tracker changes are the fix; a prose-only
  change would recur.

## What this is not

- Not a change to the build, the audit, or the documentation ceremonies.
- Not a change to the cap, which stays at eight edited rounds.
- Not a per-project model or batching setting; the shape is the suite's.
- Not a migration of runs already recorded under the old shape.
