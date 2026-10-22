# Discover-design as a corpus audit — Design Sketch

**Date:** 2026-10-19
**Status:** Sketch (not a sprint; not authorization to build)

## Idea

`/discover-design` today bootstraps an empty corpus and refuses a
populated one. It writes `.ok-planner/design/` directly and files its
questions as issues. A corpus written under an earlier release is
dated: it breaks rules the suite added later, it misses what the code
now holds, and it disagrees with the code in places. Nothing brings
such a corpus up to date.

This sketch turns `/discover-design` into an audit that runs on any
corpus, empty or not. The audit runs on the task tracker and asks the
owner nothing. It writes one **discovery document**: the deltas the
code settles, and the questions only the owner can answer. The owner
later runs `/plan-sprint` and names the document, as they name a
sketch today. `/plan-sprint` holds the whole design discussion, then
runs its sign-off review, code planning, and one approval. The corpus
then has one path for every change, the bootstrap included: an
approved sprint's deltas.

The owner builds this change inline.

## Shape

### The flow

```
/discover-design  (no questions; task tracker)
   │  audit the code and the corpus
   ▼
.ok-planner/discoveries/YYYY-MM-DD-<slug>.md
   + <name>-deltas/   (drafted artifact bodies)
   │
   │  the owner, when ready
   ▼
/plan-sprint, naming the discovery
   │  walks every question with the owner, one per turn
   │  carries form-only deltas in without discussion
   │  sign-off review, code planning, notes review
   │  approval: lists each promise change for veto
   ▼
approved sprint; the discovery moves to history/discoveries/
```

### What the audit looks for

A corpus is dated in three ways, and the audit looks for all three:

1. **It breaks the current rules.** An artifact fails a test in
   `skills/_shared/artifact-definitions.md` that it was not written
   under: a concept with an `## Invariants` section, a story that
   names a page or a button, a body that names a file path, a
   `## History` section.
2. **It misses things.** The code holds a load-bearing noun, a user
   outcome, or a choice with an alternative that no artifact records.
3. **It disagrees with the code.** An artifact says one thing and the
   code does another.

The audit never assumes which side is wrong. Each finding takes one
of three forms:

- **A form-only delta.** The fix changes no promise: strip a
  `## History` section, remove a path, reword a sentence that
  breaks a rule without changing what it commits to.
- **A promise-change delta the code settles.** The fix changes what
  the corpus commits to, and the code decides the reading. Example: a
  concept fails the existence test. The audit first reads the code
  for the narrowing the body lacks. Where the code narrows the noun,
  the delta adds the narrowing. Where it does not, the delta drops
  the concept. Splitting a story into several, moving a concept's
  rule into a new decision, and a new artifact for a gap are promise
  changes too.
- **A question.** The code and the corpus disagree, and only the
  owner can say which is right. The question names the artifact,
  quotes what it says, says what the code does with its evidence, and
  gives both answers: the corpus is stale (the answer is a delta,
  drafted), or the code is wrong (the answer is a work item,
  drafted).

The audit files no issues.

### Which artifact kinds

- **Concepts, stories, and decisions, in full.** All three ways of
  being dated apply.
- **Subjects, practices, docspecs, and the surface intent, rules
  only.** These are policies the owner declares, so the code shows
  no gap in them, and the cheatsheet forbids writing a practice on
  the owner's behalf. The audit checks each against its current rules
  (`practice-definitions.md`, the docspec and surface intent
  definitions). It drafts a form-only delta where the rules decide the
  fix, and a question where they do not.

### The run on the task tracker

Every agent is a task under the `ok-opus` profile, drained by the
drain loop at `skills/_tasks/drain.md`. Every agent of one role starts
from the same registered prompt, so each role shares one cached
prefix.

1. **Cut the areas.** Group the code into file areas by folder, as
   `review areas` does for `/converge`'s analysis mode, with no lenses
   and no slice: every file once. Cut one flow area per file the
   surface intent names as declaring a class of entry point. Add one
   prose area for the README, `docs/`, and each tracked `CLAUDE.md`.
2. **Survey.** One `survey` task per area. The agent reads its files
   and files candidates into three pools: `nouns` (a noun the code
   narrows), `outcomes` (something a user gets), and `choices` (a
   choice with an alternative). Each item carries a proposed slug, one
   paragraph, and the files that show it.
3. **Check.** One `check` task per existing artifact, or per small
   batch. The agent reads the artifact against its rules and against
   the code that realizes it, found through its `@concept:`,
   `@story:`, or `@decision:` annotations and the survey pools. It
   files into `findings`: each form-only delta, promise-change delta,
   or question, with its evidence.
4. **Merge.** One `merge` task per group of related candidates. The
   agent folds duplicates, matches each candidate to an existing
   artifact or marks it a gap, and drafts the body for each gap and
   for each delta into the deltas folder. It marks every delta
   form-only or promise change.
5. **Review.** One `review` task checks every drafted body against
   the artifact definitions and every question for both answers and
   evidence. A merge task refiled with the findings fixes them. The
   loop stops when the review is clean, or after three cycles; a
   finding still open at the cap becomes a question in the document.
6. **Assemble.** A script reads the pools and writes the discovery
   document, as `tests plan` writes a test plan. It refuses a delta
   with no form-only or promise-change mark, and a question with one
   answer.

The pools replace the `_discover/` notes folder.

### The discovery document

```markdown
# Discovery: <title>

Audited at commit `<sha>`.

## Counts
<artifacts read per kind; candidates surveyed; deltas per kind and
mark; questions>

## Questions
<one section per question: the artifact, what it says (quoted), what
the code does (with evidence), and both drafted answers>

## Promise changes
<one line per promise-change delta: kind:slug, what changes, why the
code settles it, and its body's path in the deltas folder>

## Form-only changes
<one line per form-only delta, with its body's path>
```

The deltas folder beside it uses the sprint sidecar's layout,
`<name>-deltas/<kind>s/<slug>.md`, so `/plan-sprint` carries each
body into the sprint as it stands.

### Changes to `/plan-sprint`

- **Dialogue** reads a discovery the owner names, in full, as it
  reads a sketch.
- It walks each of the discovery's questions with the owner, one per
  turn, and carries the answer in: a delta, or a work item.
- It carries every form-only delta in without discussion, and every
  promise-change delta into the draft.
- **Resolve** runs as it does today, so the open issues that bear on
  the discovery are walked.
- **Approval** lists each promise-change delta in one line for the
  owner's veto, beside the calls.
- **Terminal** moves the discovery and its deltas folder to
  `.ok-planner/history/discoveries/`, as it moves a sketch.
- A sprint that renames or drops a slug carries a work item that
  repoints the code's annotations; the lint's `citation-resolution`
  check finds any it misses.

### Changes elsewhere

- `/discover-design` stops refusing a populated corpus, and writes
  nothing under `.ok-planner/design/`.
- `/ok` archives a leftover `.ok-planner/design/_discover/` to
  `.ok-planner/history/discover/`.
- Issues with kind `discover` stay in the intake; the kind stays
  valid, and no new run files one.
- Text that describes the old skill changes with it: the family's
  `CLAUDE.md`, `scripts/ok-planner-CLAUDE.md` (the filer list, the
  discovery notes), `admin/ADMINISTRATION.md` ("executed by
  `/discover-design` on an empty corpus"), and the estate layout gains
  `discoveries/` and `history/discoveries/`.
- The release is a minor bump: no command goes away.

## Open questions

- Does area cutting become a verb of `bin/review` with a flag (no
  lenses, no slice, prose included), or a verb of a new
  `bin/discover` tool that imports `file_areas` and `flow_areas`?
  `review files` skips prose today, and the survey needs it.
- How the run groups candidates for the merge: by proposed slug, by
  shared files, or by a first sorting task.
- One discovery at a time? Assumed: `/discover-design` refuses while a
  discovery no sprint has taken up stands, as `/plan-tests` refuses
  while a test sprint is open.
- The window between the audit and planning. Assumed: `/plan-sprint`
  compares the discovery's commit with `HEAD` and says how many files
  changed since, and its Reconcile step covers the rest.
- Whether the assembly notes an open issue that matches a question,
  so `/plan-sprint` walks them together.
- The check task's batch size, and whether one artifact with many
  realizing sites gets a task of its own.
- Whether a large corpus produces a discovery too long for one
  planning session, and whether `/plan-sprint` can take a discovery
  in parts.

## Risks / unknowns

- A bootstrap now leaves the project with no corpus until the owner
  plans a sprint. A project that wants a corpus soon pays for one
  long planning session first.
- A discovery on a large codebase can raise many questions. The walk
  is one per turn, so the planning session grows with them.
- The audit judges "the code settles it" on its own. A promise-change
  delta judged wrongly reaches the owner only as one line at approval.
- Survey agents per area see only their area. A noun that spans areas
  depends on the merge to fold it.
- Existing `@concept:` annotations may be sparse in a dated project,
  so the check agent finds an artifact's realizing code mostly through
  the survey pools.

## What this is not

- It does not make `/discover-design` interactive. The owner's one
  discussion is in `/plan-sprint`.
- It does not chain `/discover-design` into `/plan-sprint`. The family
  `CLAUDE.md` line "Skills do not chain into a pipeline" stays; the
  owner may drop it separately, since this design no longer needs it.
- It proposes no new subjects, practices, docspecs, or surface
  classes.
- It does not fix code. A question answered "the code is wrong"
  becomes a work item the sprint builds.
