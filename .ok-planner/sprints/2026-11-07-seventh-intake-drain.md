---
approved: 2026-11-08
---

# Sprint: Seventh intake drain

## Intent

This sprint drains the intake. It has no single theme. It carries the
owner's ruling on suggesting a seed where a project has none, five
judgment issues ruled by silence, four defect issues the owner picked,
and one change the owner asked for in this session: every stop of a
sprint or documentation sprint run ends its goal.

Three of the rulings change only the corpus, because the code already
does what they commit to: a stopped test round files one report, a
plan's test stamp takes a story out of the untested offer, and which
later round clears a round's failure. The ruling on `/ok-setup`'s
budget vetoes changes only the corpus too.

Issues promoted into this sprint:

- seed-suggested-where-no-seed-exists
- ok-setup-budget-veto-timing
- earlier-release-sprints-marked-certified
- stopped-test-round-report-shape
- planned-story-with-no-scenario-offered-as-untested
- which-round-clears-a-round-level-test-entry
- refile-cannot-change-a-tasks-files
- review-snapshot-fails-before-the-first-commit
- review-reads-root-alone-on-one-bad-folder
- doc-sprint-stamps-over-commits-after-its-plan

## Corpus deltas

### Amend decision: sprint-goal-read-from-the-repository

body: in the sidecar

### Amend decision: fixes-rerun-the-tests-they-reach

body: in the sidecar

### Amend decision: scenario-list-decided-once

body: in the sidecar

### Amend decision: test-tasks-own-the-tests

body: in the sidecar

### New decision: ok-setup-takes-vetoes-before-the-budget

body: in the sidecar

### New decision: seed-recommended-never-required

body: in the sidecar

### New decision: stopped-round-files-one-report

body: in the sidecar

### New decision: earlier-release-windows-closed-without-a-verdict

body: in the sidecar

### New decision: every-stop-ends-the-goal

body: in the sidecar

### New decision: round-failure-cleared-by-a-later-round

body: in the sidecar

### New decision: stopped-run-resumes

body: in the sidecar

### Amend decision: tests-spend-time-only-on-their-outcome

body: in the sidecar

### Amend decision: test-support-written-before-tests

body: in the sidecar

## Work items

The suite's source lives under `plugins/ok/families/ok-planner/`. The
copies under `.claude/` and `.ok-planner/` are suite-owned: a work item
changes the source, and the copies follow on the next release and
`/ok`.

1. **No seed is suggested where a project has none.** Realizes
   decision:seed-recommended-never-required,
   decision:tests-spend-time-only-on-their-outcome, and
   decision:test-support-written-before-tests (ruled issue
   seed-suggested-where-no-seed-exists). Where the project holds no
   seed that `testing.setup` builds, no test-stage prompt or rule
   names a seed: the test writer is offered no `seed` support change,
   the speed reviewer names no seed entry as the cheaper form, and the
   waste rule names no seed data. The test builds or reads its own
   data, such as a fixture. No task closes `blocked` over a seed, and
   no stage stops on one: the support prompt's instruction to close
   `blocked` where the project has no seed goes, and a `seed` support
   item can no longer arise in such a project. The owner's ruling, in
   their words: "is there is no seed available, then it should be a
   no-op, not even suggested. not blocked." Sites named in the issue:
   the `seed` support change in the test-write prompt, the seed as
   "the cheaper form" in the test-speed prompt, `{{TEST-WASTE-RULE}}`
   in the shared sprint file, and the seed bullet in the test-support
   prompt; every other text that offers a seed (the rules text, the
   testing standard, the tests tool's support-change list) follows.
   Each site that enforces the seed rule cites
   `@decision:seed-recommended-never-required`, in place of a citation
   of decision:tests-spend-time-only-on-their-outcome that stood there
   for the seed alone.

2. **True-up's mark for an earlier release's sprint claims no
   verdict.** Realizes
   decision:earlier-release-windows-closed-without-a-verdict (issue
   earlier-release-sprints-marked-certified). True-up still closes the
   test-edit window of each live sprint an earlier release laid out
   whose completion report holds a `# Sprint certification` section,
   but the mark it writes says only that an earlier release ran
   certification and that no record keeps the verdict, and that
   running `review certified` for the sprint again records the real
   one. It no longer reads `SPRINT COMPLETE`. The lint keeps treating
   the mark as closing the window. The true-up step that writes the
   mark cites `@decision:earlier-release-windows-closed-without-a-verdict`.

3. **A refile changes a task's files in the same write.** Fixes
   defect issue refile-cannot-change-a-tasks-files, at
   `plugins/ok/families/ok-planner/scripts/tasks:cmd_refile`. A refile
   that must add a file writes the new file list in the same write
   that files the task, so no close, `exec`, or `next` between two
   writes can issue the task with the old list, and a crash leaves no
   half-written refile. Sprint execution's step 7, which refiles a
   build that closed `partial` with `outside files:`, uses it.

4. **The review tool works, or refuses plainly, before the first
   commit.** Fixes defect issue
   review-snapshot-fails-before-the-first-commit, at
   `plugins/ok/families/ok-planner/scripts/review:listed_changes`.
   `review snapshot`, and `review changed` with no `--base`, in a
   repository with no commit either work or refuse with a message that
   says to commit first. Neither exits on git's bad-revision error.

5. **A bad folder list refuses.** Fixes defect issue
   review-reads-root-alone-on-one-bad-folder, at
   `plugins/ok/families/ok-planner/scripts/review:declared_folders`.
   Where `.ok-planner/config.json`'s `folders` holds a malformed entry,
   or node is not on PATH to check the list, every review and tests
   verb that reads the folders refuses with a message naming the
   problem, as the lint does. No verb reads the project root alone in
   its place, and `review certified` never marks its checks item
   `holds` over a list it could not read. `/converge`'s skill text no
   longer tells the run to quote a note and go on.

6. **A documentation sprint never stamps over a product commit made
   after its plan.** Fixes defect issue
   doc-sprint-stamps-over-commits-after-its-plan, at the documentation
   sprint's step 3 and `plugins/ok/families/ok-planner/scripts/docs:cmd_stamp`.
   A product commit made between the plan's commit and the run's start
   stays in the next `/plan-docs` window for every docspec it bears
   on: either the run stops at its start, before it files a task, and
   says the plan must be made again, under work item 7's stop record,
   or the stamp records each such docspec so the window still finds
   the commit. `docs window` never reports such a docspec current.

7. **Every stop of a run ends its goal.** Realizes
   decision:every-stop-ends-the-goal,
   decision:stopped-run-resumes, and
   decision:sprint-goal-read-from-the-repository. The owner asked for
   it in this session: a stop at a run's start is allowed, a stop
   midway stays where the boilerplate lists it, and every stop must
   end the goal, because runs have stopped while the goal kept
   looping and spending tokens.
   - In the sprint template, every check that can stop the run before
     it starts runs before the base commit is recorded: the approval
     check, the uncommitted-paths check, and the check for the task
     tracker and the profiles.
   - At every stop the template names, before the run, midway (step
     11's genuine blockers), and at the close where certification
     prints `SPRINT NOT COMPLETE`, the session writes a stop record
     beside the sprint that names the reason, then runs `review
     certified`.
   - While the stop record stands, `review certified --sprint <path>`
     prints `SPRINT STOPPED` with the record's reason and checks
     nothing else. An archived sprint with its `closed:` stamp stays
     terminal as it is today.
   - Step 1's stop condition, and the completion contract's goal rule,
     name `SPRINT STOPPED` beside `SPRINT COMPLETE` as a line that
     ends the goal.
   - Step 1 deletes a stop record it finds before the run goes on, so
     a new `/goal` restarts the sprint.
   - A run that stopped resumes. The owner ruled in this session:
     "sprints absolutely need a way to resume". Where the sprint's
     `-base.txt` already stands, step 2 keeps that base and skips the
     uncommitted-paths check, and the run takes up its existing task
     record where it stopped: the tasks that closed `done` stay
     closed, a task that closed `blocked`, `partial`, or `disputed` and
     a task an agent claimed and never closed are issued again, and
     the rest run. The session files no stage twice. The documentation sprint
     resumes the same way from its own base file and task record.
   - The documentation sprint template, its run rules
     (`{{CEREMONY-RUN-RULES}}`), and `docs complete` take the same
     shape, with their own stop record and the line `DOCS STOPPED`.
   - The archive step moves a sprint's stop record with the sprint
     where one stands.
   - True-up brings the changed boilerplate of every live sprint and
     documentation sprint current, as
     decision:live-sprints-brought-current-on-true-up requires of
     every change to their shape.
   - The rules text and the planner's directory guide that describe
     the goal rule and the `SPRINT NOT COMPLETE` stop say the same.

## Implementation notes

Planned against commit `cf980cd2b9782203e48003f8eef67ed835e13dac`.

`F/` below stands for `plugins/ok/families/ok-planner/`. Every change
is in the suite's source there, or in the project's own
`.ok-planner/review/project.md`. No vendored copy under `.claude/` or
`.ok-planner/` is edited.

Files shared across work items chain, for staging:
`F/skills/plan-sprint/sprint-document.md` and
`F/admin/retired-boilerplate.json` (items 3 and 7);
`F/skills/plan-docs/doc-sprint-document.md`,
`F/admin/retired-doc-sprint-boilerplate.json`, and `F/scripts/docs`
(items 6 and 7); `F/skills/_sprint/shared.md` (items 1 and 7);
`F/scripts/review`, `F/skills/converge/SKILL.md`, and
`.ok-planner/review/project.md` (items 4, 5, and 7); `F/scripts/tasks`
(items 3 and 7).

### 1. No seed is suggested where a project has none

**Calls**
- A project has a seed only where `testing.setup` in
  `.ok-planner/config.json` is a command that builds one; where
  `testing.setup` is `null`, the project has no seed. True-up writes
  `null` for every earlier project that declares `run`. Decided by:
  decision:seed-recommended-never-required ("which the project's setup
  step builds") and the administration document's former value for
  `testing.setup`.
- Each prompt keeps its seed text as a clause gated on that fact. No
  tool renders the text away per project, because no tool records a
  seed beyond `testing.setup`, and the decision binds what an agent
  names ("no reader, writer, or support task names a seed"), not the
  prompt template. This is the reading of the work item's "no
  test-stage prompt or rule names a seed". Decided by: the decision's
  Choice.
- The tests tool enforces the rule mechanically where `testing.setup`
  is `null`: it briefs a `seed` support item as a fixture, so the
  stage never refuses it and no support task closes `blocked`. Decided
  by: the work item ("no task closes blocked … no stage stops") and
  the decision ("a test builds or reads its own data").
- `SUPPORT_CHANGES` keeps `seed`, and the template's list of accepted
  changes stays as written. Decided by: the decision, which keeps seed
  entries where a seed exists.
- No code citation of decision:tests-spend-time-only-on-their-outcome
  stands for the seed alone: `F/admin/true-up:213` covers the whole
  testing standard and stays. The new seed-enforcing site,
  `support_brief`, cites `@decision: seed-recommended-never-required`.
- Notes review: `stage_support` takes no root and reads no settings.
  `stage_write`, which has `root`, reads `testing` and passes it
  through `stage_support` to `support_brief`.

**Changes**
- `F/skills/converge/prompts/test-write.md::Read 3, Write (support
  items), Record`: changed. Read 3 also reads `testing.setup`. In
  `change=<missing | changed | fixture | seed>`, `seed` is offered only
  where the project holds a seed that `testing.setup` builds;
  elsewhere, read-only data the test needs goes in as `fixture` or into
  the test's own setup. "a seed file included" applies only where a
  seed exists.
- `F/skills/converge/prompts/test-speed.md::Read, Judge (seed
  paragraph), Record (send back)`: changed. Read also takes
  `testing.setup`. The speed reviewer names a seed entry as the
  cheaper form only where `testing.setup` builds a seed; elsewhere the
  cheaper form is data the test builds or reads itself, such as a
  fixture. The send-back sentence about a seed entry is gated the same
  way.
- `F/skills/converge/prompts/test-support.md::Write (seed bullets)`:
  changed. The `close blocked … the project has no seed` instruction
  goes. A `seed` item where the project holds no seed adds the data as
  a fixture in this file, and the support task marks the item `made`.
  The bullet for a project with a seed stays as it is.
- `F/skills/_sprint/shared.md::{{TEST-WASTE-RULE}}`: changed. The
  repeated-setup bullet names "data the test only reads that the seed
  could hold" only "where the project has a seed `testing.setup`
  builds".
- `F/docs/testing.md::The named wastes, The seed`: changed to the
  decision's text: in a project with no seed, no reader, writer, or
  support task names a seed, and a test builds or reads its own data.
  The support-item and speed sentences become conditional.
- `F/docs/plumbline-cheatsheet.md::Tests (named-wastes bullet, seed
  bullet)`: changed the same way.
- `F/scripts/tests::USAGE` (the `tests tasks` support-change text):
  changed to "or seed, a seed entry, where `testing.setup` builds a
  seed; elsewhere briefed as a fixture".
- `F/scripts/tests::support_brief`: changed; cites `@decision:
  seed-recommended-never-required`. It takes the `testing` settings,
  and where `testing.setup` is `null` it briefs a `seed` item as "a
  fixture (the project holds no seed)". Its caller `stage_support`
  passes the settings it already reads.

**Behavior changes**
- **B1** `F/skills/converge/prompts/test-support.md`. Before: a `seed`
  item in a project with no seed closes the support task `blocked`,
  and the stage can stop. After: the data lands as a fixture, the item
  is `made`, and nothing blocks.
  Users: in the release: sprint execution and `/converge sprint`, which
  register the prompt at run open. Across Trued-up projects: none;
  true-up rewrites the vendored prompt wholesale.
  Ruling: rewrite
- **B2** `F/skills/converge/prompts/test-write.md`. Before: `seed` is
  always offered. After: offered only where `testing.setup` builds a
  seed.
  Users: in the release: test tasks. Across: none, as in B1.
  Ruling: rewrite
- **B3** `F/skills/converge/prompts/test-speed.md`. Before: the speed
  reviewer may always name a seed entry. After: only where a seed
  exists.
  Users: in the release: speed tasks.
  Ruling: rewrite
- **B4** `F/skills/_sprint/shared.md::{{TEST-WASTE-RULE}}`,
  `F/docs/testing.md`, `F/docs/plumbline-cheatsheet.md`. Before: seed
  data is always named as a waste. After: only where a seed exists.
  Users: in the release: the planning prompts `tests.md`,
  `tests-story.md`, `tests-runtime.md`, test-speed, and the
  materialized standard and rules, which true-up rewrites.
  Ruling: rewrite
- **B5** `F/scripts/tests::support_brief`. Before: a `seed` item is
  briefed as "a seed entry". After: where `testing.setup` is `null`,
  it is briefed as a fixture.
  Users: in the release: support tasks. The run log format is
  unchanged.
  Ruling: rewrite

### 2. True-up's mark for an earlier release's sprint claims no verdict

**Calls**
- The mark names its sprint, so it is formatted per sprint:
  "Certification verdict unrecorded: an earlier release ran sprint
  certification for `<path>`, whose completion report carries the `#
  Sprint certification` return block, and no record keeps its verdict.
  True-up wrote this mark to close the sprint's test-edit window. Run
  `.ok-planner/bin/review certified --sprint <path>` again to record
  the verdict." It never reads `SPRINT COMPLETE`. Decided by:
  decision:earlier-release-windows-closed-without-a-verdict.
- No migration for marks already written: the released true-ups
  v30.0.0, v30.1.0, and v30.2.0 hold no `EARLIER_CERTIFIED_MARK`
  (checked with `git show`), so no project holds the old text.
- `review certified` needs no change: `certified_mark` already writes
  `SPRINT COMPLETE` on a pass and removes the mark on a failure, as the
  decision says. The lint tests only that `-certified.txt` exists
  (`openSprintWindow`), so it keeps treating the mark as closing the
  window.

**Changes**
- `F/admin/true-up::EARLIER_CERTIFIED_MARK`: changed to the per-sprint
  text above, a `%s` template. `certified_mark_steps` passes
  `EARLIER_CERTIFIED_MARK % ...` to `write_text`.
- `F/admin/true-up::certified_mark_steps`: changed. It cites
  `@decision: earlier-release-windows-closed-without-a-verdict` beside
  the existing citation. Its `missing:` detail says an earlier release
  ran certification and kept no verdict, and that true-up writes a
  mark that claims none, so the window stays closed.
- `F/admin/ADMINISTRATION.md::conditions table row ("a sprint an
  earlier release certified"), "A sprint an earlier release certified"
  bullet, "Does not write outside the owned set" bullet`: changed to
  describe a mark that claims no verdict and the `review certified`
  rerun that records the verdict.

**Behavior changes**
- **B6** `F/admin/true-up::EARLIER_CERTIFIED_MARK`. Before: the mark
  reads "SPRINT COMPLETE under an earlier release…". After: it claims
  no verdict and names the command.
  Users: in the release: the lint (tests existence only), `review
  certified` (replaces or removes the mark), and true-up's `lexists`.
  Across Trued-up projects: none; no released true-up wrote a mark.
  Ruling: rewrite

### 3. A refile changes a task's files in the same write

**Calls**
- `tasks refile <task> --files F ...` replaces the copied file list
  whole, as `--after` replaces the copied waits. Decided by: the
  cheatsheet's one idiom per job, and `file --files`, which also names
  the whole list.
- The `-run.jsonl` format is unchanged: the refile record carries
  `files` as `file` writes it.
- `--files` on `tasks refile` is internal: no rule of the surface
  intent makes it public. Decided by: `.ok-planner/surface/surface.md`.
- Notes review, same defect class (`.claude/rules/plumbline-coding.md`
  rule 8): `F/scripts/tests::filed_tasks` (its refile branch) refiles,
  then calls `set_files` as a second write. It passes `--files` to
  `tasks refile`, so the file list lands in one write.

**Changes**
- `F/scripts/tasks::build_parser` (refile): new `--files`,
  `action="extend", nargs="+", default=None`.
- `F/scripts/tasks::cmd_refile`: changed. `spec["files"] = args.files`
  where given, else the source's files. The record, its
  `TASKS.TASK.FILED` event, and the waiters' updated `after` lists land
  in the one existing `put_many`.
- `F/scripts/tasks::USAGE` (refile entry): changed to name `--files F
  ...`, which replaces the task's files.
- `F/skills/plan-sprint/sprint-document.md::How to execute, step 7`:
  changed. A `partial` build whose result starts `outside files:` is
  refiled with `tasks refile <task> --files <its files and that
  path>`.
- `F/admin/retired-boilerplate.json`: changed. It adds each released
  template line the new text no longer holds, sorted, as
  `checks/sprint-boilerplate` computes from the `v*` tags. A line never
  released is not added. Run `checks/sprint-boilerplate` to fill the
  list exactly: commit a124cfa, after the v30.2.0 tag, added unreleased
  lines.
- `.ok-planner/review/project.md::Scripts (tasks entry)`: changed to
  name `refile --files`.
- `F/scripts/tests::filed_tasks` (refile branch): changed to refile
  with `--files` in one write; `set_files` goes where nothing else
  calls it.

**Behavior changes**
- **B7** `F/skills/plan-sprint/sprint-document.md::step 7`. Before:
  adding the path took a refile, then a second write (`task set
  --field files=...`), and a close, `exec`, or `next` between the two
  could issue the old list. After: one write.
  Users: in the release: the executing session. Across Trued-up
  projects: each live sprint's boilerplate.
  Ruling: migrate: true-up rewrites step 7 of every live sprint from
  `retired-boilerplate.json` (call, decision:live-sprints-brought-current-on-true-up)

### 4. The review tool works, or refuses plainly, before the first commit

**Calls**
- The tool works rather than refuses. One new helper,
  `default_base(root)`, returns `HEAD` where `git rev-parse --verify
  --quiet HEAD^{commit}` succeeds, and otherwise git's empty tree, from
  `git hash-object -t tree /dev/null`, which also holds in a SHA-256
  repository. Before the first commit, every indexed or untracked file
  lists as `added`. Decided by: the work item allows either, and
  working keeps `/converge`'s fix round running in a fresh project.
- The defect class is "a review verb that defaults to `HEAD` exits on
  git's bad-revision error before the first commit". Its members are
  `cmd_changed`, `round_paths` (the snapshot), and `cmd_rotate`; all
  three are fixed. Decided by: `.claude/rules/plumbline-coding.md` rule
  8. `before_blob` already maps a missing `HEAD` to `new`. `tests plan`
  (`rev-parse HEAD`) is outside the review tool and outside the item.
- `rotate` records `"commit": null` and prints "at no commit".
  `commit` is informational: `area_priority` reads only `hash` and
  `hunted`.
- Confirm in a scratch repository with no commit that `git diff
  --name-status <empty tree> -- .` lists the indexed files as added.

**Changes**
- `F/scripts/review::default_base`: new, as above.
- `F/scripts/review::cmd_changed`: changed to `chosen_base(args, root)
  or default_base(root)`.
- `F/scripts/review::round_paths`: changed to diff from
  `default_base(root)` in place of `"HEAD"`.
- `F/scripts/review::cmd_rotate`: changed to record a null commit
  where `HEAD` names none.
- `F/scripts/review::build_parser` (`--base` help): changed to "else
  HEAD, or every file before the first commit".
- `F/skills/converge/SKILL.md::Fix step 3 (Snapshot)`: changed to say
  that before the first commit the snapshot takes every file.
- `.ok-planner/review/project.md::Scripts (review entry)`: changed to
  state the before-first-commit behavior of `changed`, `snapshot`, and
  `rotate`.

**Behavior changes**
- **B8** `F/scripts/review::cmd_changed`. Before: with no `--base` in a
  repository with no commit, it exits 1 with git's bad-revision error.
  After: it lists every file as added.
  Users: in the release: the `/converge` skill. Across: no outside
  caller; the review tool is internal.
  Ruling: rewrite
- **B9** `F/scripts/review::round_paths` (`review snapshot`). Before:
  exits 1. After: snapshots every file.
  Users: in the release: `/converge`'s fix round.
  Ruling: rewrite
- **B10** `F/scripts/review::cmd_rotate`. Before: exits 1. After:
  stamps the areas with a null commit.
  Users: in the release: `/converge` analysis mode. Across stored
  state: the rotation file gains `"commit": null`, which no reader
  uses.
  Ruling: rewrite

### 5. A bad folder list refuses

**Calls**
- `declared_folders(root)` returns the list or raises `ReviewError`,
  and no longer returns a note. Every review verb (through `main`) and
  every tests verb (through `main`'s `review.ReviewError` catch) then
  exits 1 with `<tool>: <message>`, as the lint refuses. Decided by:
  the work item.
- The messages: `.ok-planner/config.json sets a malformed folders; run
  /ok, which repairs it:` followed by each `config-check` defect; and
  `node is not on PATH to check the folders .ok-planner/config.json
  declares beyond the project root; put node on PATH`.
- Where `folders` is a list of strings that each normalize to `.`,
  the root alone, the function returns `[]` without running node. Node
  is optional (true-up seeds `checks` with the lint only where node is
  on PATH), and a single-folder project without node keeps working.
  Every other list needs node.
- `project_folders` (review), its `tool` and `reader` parameters, and
  `tests::project_folders` collapse into direct calls of
  `review.declared_folders(root)`. Decided by:
  `.claude/rules/plumbline-coding.md` rule 1.4.
- `/converge` treats the refusal as a precondition failure: it says
  the message and stops, with no return block, in place of "quote the
  note and go on". Decided by: the work item and the skill's existing
  precondition shape.

**Changes**
- `F/scripts/review::declared_folders`: changed as above.
- `F/scripts/review::project_folders`: removed. Its callers
  `tree_files` and `changed_files` call `declared_folders`.
- `F/scripts/review::cmd_certified`: changed to drop the `alone` note.
  A list it cannot read raises before any item prints, so item 2 never
  reads `holds` over it.
- `F/scripts/tests::project_folders`: removed. Its callers
  `offer_groups`, `sprint_plan`, `cmd_groups`, and `assembled_plan`
  call `review.declared_folders(root)`.
- `F/skills/converge/SKILL.md::Preconditions (step 1), the slice
  (analysis step 1), return lines (hunt, sprint)`: changed. Every
  "reads the project root alone … quote the note" instruction goes,
  and step 1 says a folders refusal stops the run with its message.
- `.ok-planner/review/project.md::Scripts (review entry, tests entry)`:
  changed to state that each review and tests verb that reads the
  folders refuses a malformed list, or a list beyond the root with node
  off PATH.

**Behavior changes**
- **B11** `F/scripts/review::declared_folders` (`files`, `changed`,
  `checks`, `snapshot`, `areas`). Before: on a malformed list, a stderr
  note and the root alone. After: exit 1 naming the defects.
  Users: in the release: `/converge`. Across stored state: a
  `config.json` that holds a malformed list.
  Ruling: migrate: the refusal names `/ok`, whose `config` question
  repairs the list; only the harm (A9) is removed (call)
- **B12** `F/scripts/review::declared_folders`, node off PATH. Before:
  the root alone for any list. After: unchanged for a root-only list,
  exit 1 for a list beyond the root.
  Users: as B11.
  Ruling: migrate: a root-only project is unchanged, and any other
  gets a refusal naming the fix (call)
- **B13** `F/scripts/tests` verbs that read the folders (`offers`,
  `groups`, `plan`, and `run`, `failures`, `stray`, `tasks`, `settled`
  for a sprint with no `-plan.json`). Before: the root alone with a
  note. After: exit 1.
  Users: in the release: the sprint's test stages, `/plan-sprint`, and
  `review certified`, which runs `tests stray` and `tests settled`.
  Ruling: rewrite
- **B14** `F/scripts/review::cmd_certified`. Before: `item 2 (checks):
  holds … (the project root alone: …)`, possibly ending `SPRINT
  COMPLETE`. After: exit 1 with the folders message, and no verdict.
  Users: in the release: sprint step 13 and goal checkers.
  Ruling: rewrite
- **B15** `F/skills/converge/SKILL.md`. Before: the run quotes the
  note and goes on. After: it stops with the message.
  Users: in the release: `/converge` runs.
  Ruling: rewrite

### 6. A documentation sprint never stamps over a product commit made after its plan

**Calls**
- The primary fix: the run stops at its start (step 3) where a commit
  between the plan's commit and `HEAD` bears on a planned docspec, and
  its stop record (work item 7) says to plan again. Decided by: the
  work item's first branch.
- A new verb, `docs start --sprint <path>`, does the check. It reads
  ``Planned against commit `<sha>`.`` from the Window section, and
  refuses a sprint without that line or with a commit this repository
  does not hold. Where `HEAD` is the planned commit, or no planned
  docspec bears on `git diff --name-only --no-renames <planned> HEAD`,
  it prints `start: …` and exits 0. Otherwise it lists each planned
  docspec with its reasons, says the plan must be made again, and exits
  2. It writes nothing; the session writes the stop record. The verb is
  internal: no rule of the surface intent makes it public.
- "Bears on" reuses the window's own reasons: the docspec file, its
  corpus and code references, declaring files, and documentation
  paths. The reason code moves out of `window_entry` into
  `change_reasons(root, spec, changed, declared)`, which `window_entry`
  and the new check both call. Decided by:
  `.claude/rules/plumbline-coding.md` rule 6.
- A second guard at `cmd_stamp`: where the base file differs from the
  planned commit, `cmd_stamp` stamps each planned docspec that the
  commits between them bear on at the planned commit, with a printed
  line, so `docs window` still finds those commits. Once the start
  check passes, this does nothing. Decided by: the work item, which
  names `docs:cmd_stamp` and the stamp branch.
- The base file is written only after `docs start` passes.
- Notes review: the planning handoff's own commits must not trip
  `docs start`. `/plan-docs` reads the tree as it stands, uncommitted
  work included, and its handoff then offers to commit the paths
  outside `.ok-planner/`; those commits hold only what the window
  already read. So, for a documentation sprint, the handoff rewrites
  the Window's `Planned against commit` line to `git rev-parse HEAD`
  after its commits. A live documentation sprint an earlier release
  planned keeps its line; where commits after it bear on a planned
  docspec, `docs start` stops it at its start, which the owner allows,
  and `/plan-docs` then plans again (next call).
- Notes review: a stop from `docs start` leaves a plan that can never
  run, and `/plan-docs` refuses while an unarchived documentation
  sprint stands. Where the stop record came from `docs start`,
  `/plan-docs` offers, on the owner's yes, to move the stale
  documentation sprint and its stop record to
  `.ok-planner/history/doc-sprints/` with no stamp, then plans again.
  It offers no `/goal` resume for that stop.
- Notes review: the `cmd_stamp` guard reads every commit between the
  planned commit and the parent of `--commit`, not only up to the base,
  so an owner commit made after the base of a resumed run is not
  stamped over.
- Notes review: `docs start` also exits 1, for a sprint with no Window
  line or a planned commit the repository no longer holds, as after a
  rebase. Step 3 treats that refusal as a pre-run stop too: it writes
  the stop record with the refusal, then runs `docs complete`.
- Notes review: where `cmd_stamp` cannot parse an archived
  documentation sprint's `Planned against commit` line, it stamps as
  today and does not refuse after the owner's commit.

**Changes**
- `F/scripts/docs::change_reasons`: new; holds the reason computation
  `window_entry` held, and `window_entry` calls it.
- `F/scripts/docs::planned_commit`: new; parses the Window line.
- `F/scripts/docs::bearing_docspecs`: new; returns `{slug: reasons}`
  for the planned slugs over the diff between two commits.
- `F/scripts/docs::cmd_start` and `build_parser` (`start --sprint`):
  new.
- `F/scripts/docs::cmd_stamp`: changed as above.
- `F/scripts/docs::USAGE`: changed to add `start` and state the stamp
  behavior.
- `F/skills/plan-docs/doc-sprint-document.md::How to execute, step 3`:
  changed. After the required-tools check (work item 7) it runs `docs
  start --sprint <path>`; where that exits 2, the session writes the
  stop record with its output and runs `docs complete`. Then the
  uncommitted-paths check, then the base.
- `F/admin/retired-doc-sprint-boilerplate.json`: changed to add the
  released lines the new steps drop, as `checks/sprint-boilerplate`
  computes.
- `F/skills/_sprint/shared.md::{{PLANNING-HANDOFF}}`: changed. For a
  documentation sprint, after its commits, it rewrites the Window's
  `Planned against commit` line to `git rev-parse HEAD`.
- `F/skills/plan-docs/SKILL.md` (open documentation sprint): changed.
  Where the stop record came from `docs start`, it offers to move the
  stale documentation sprint and its stop record to
  `.ok-planner/history/doc-sprints/` unstamped, on the owner's yes, and
  plans again.

**Behavior changes**
- **B16** `F/skills/plan-docs/doc-sprint-document.md::step 3`. Before:
  the run records the base and goes on over commits made after the
  plan. After: it stops before filing a task where those commits bear
  on a planned docspec.
  Users: in the release: the executing session. Across Trued-up
  projects: live documentation sprints.
  Ruling: migrate: true-up rewrites the boilerplate of every live
  documentation sprint from `retired-doc-sprint-boilerplate.json`
  (call, decision:live-sprints-brought-current-on-true-up)
- **B17** `F/scripts/docs::cmd_stamp`. Before: every planned docspec
  is stamped at the archive commit. After: a docspec that commits
  between the planned commit and the base bear on is stamped at the
  planned commit.
  Users: in the release: `docs window` and `/plan-docs`. Across stored
  state: the `doc-state` format is unchanged.
  Ruling: rewrite

### 7. Every stop of a run ends its goal

**Calls**
- The stop record is `<stem>-stopped.txt` beside the sprint or
  documentation sprint, named like `-base.txt` and `-certified.txt`.
  It holds the reason as plain text, which the session writes. It sits
  under `.ok-planner/`, so the uncommitted-paths check never counts
  it. Decided by: work item 7.
- `review certified` checks, in order: an archived sprint with
  `closed:` is terminal, as today; then the stop record; then
  everything else. While the record stands, it prints `SPRINT STOPPED:
  <path>`, each reason line as `- <line>` (`no reason recorded` where
  the record is empty), and a line saying the goal ends and the owner
  takes up the reason. It exits 3, leaves `-certified.txt` as it
  stands, and checks nothing else. `docs complete` takes the same shape
  with `DOCS STOPPED` and exit 3. Decided by: the work item ("checks
  nothing else", "stays terminal").
- One reader, `review::stop_reason(root, path)`, serves both tools;
  `docs` imports it as it already imports `closed_stamp`. Decided by:
  `.claude/rules/plumbline-coding.md` rule 6.
- Every pre-run stop moves before the base is written. Sprint step 2
  runs, in order: the approval check; the tracker and
  `.claude/agents/` check; the `.ok-planner/bin/tests` check where the
  run opens test stages; then, only where no base stands, the
  uncommitted-paths check and the base. Step 3 drops the checks that
  moved. Documentation-sprint step 3 runs the tools check, `docs start`
  (work item 6), then, only where no base stands, the uncommitted check
  and the base. Decided by: work item 7's first bullet and its resume
  bullet.
- Resume, sprint. Where `<stem>-base.txt` stands, step 2 keeps it and
  skips the uncommitted-paths check. Step 3 then branches: where
  `<stem>-run.jsonl` stands, the session runs `tasks use <it>`, then
  `tasks retry --all`; where the base stands with no run file (a
  session that died between base and init), it runs `tasks init` as
  today. Decided by: the work item's resume bullet and
  decision:stopped-run-resumes.
- The tracker change is `tasks retry --all`, a new form of the
  existing verb. It issues again, in one write, every task the single
  form accepts, except a closed task a refile replaced. It does not
  select the run file; `tasks use` stays the one way to select. Decided
  by: `.claude/rules/plumbline-coding.md` rule 3.1 (one write for a
  change to several records) and rule 6 (the reset logic is shared,
  not copied), and the cheatsheet's one idiom per job.
- A task a refile replaced stays closed: in a chain T (blocked), then
  R (its refile), R alone stands for the stage and is the one issued
  again. Decided by: the work item's "The session files no stage
  twice".
- A task claimed and never closed counts as dead at resume. At a
  genuine blocker the session writes the stop record only after no
  agent it started still runs: the Workflow form already waits for
  every agent in flight before it returns, and the hand form waits for
  each agent's return. So every task still `running` at resume has no
  live agent, and `--all` releases it. Decided by: the drain loop's
  return rule, and `.claude/rules/plumbline-coding.md` rule 3.7.
- A reopened task keeps its brief, files, and `after` list, and runs
  whole; its agent finds the work it already staged in the tree. An
  exec task that closed `failed` is reopened too. Decided by:
  decision:stopped-run-resumes ("every other task runs") and
  `cmd_retry`'s existing reset.
- Resume repeats every registration of step 3: `tasks agent register
  ok-opus`, each prompt rendered again with `review prompt --out` and
  registered again, and each `config set`. Each is an idempotent put,
  so a run that stopped inside step 3 opens whole. Decided by: the
  tracker's record semantics (the latest line wins).
- Stage filing on resume, sprint: the session files no build task for
  a work item some build task's `--cites` already names; only a work
  item no filed task cites gets a stage filed. The test-stage verbs run
  again from `--stage write`, and each files only what the run lacks:
  `stage_write` skips `("test", id) in existing` and the legacy keys,
  and `stage_support` skips `served` paths. Decided by: "the session
  files no stage twice".
- Stage filing on resume, documentation sprint: the session files no
  task whose role and key the run already holds, and the fact loop
  goes on at the round after the highest round the run records.
- The checklist on resume: one entry per stage the run holds, each
  marked done where its latest build task closed `done`.
- A `/goal` after a passing certification: where `-certified.txt`
  stands, the session runs `review certified` first, and where it
  prints `SPRINT COMPLETE`, the goal is met and the session offers the
  archive and the commit as step 13 does, with no new certification.
  Decided by: decision:sprint-goal-read-from-the-repository.
- Certification on resume: where every stage closed `done` and the run
  stopped at step 13 (`SPRINT NOT COMPLETE`), the resumed run goes to
  step 12 and starts a fresh `/converge sprint` run; step 3's `tasks
  use` first moves the pointer back from the `/converge` ledger.
  Decided by: `/converge`'s "Open a fresh ledger"; the decision covers
  sprint and documentation-sprint runs, not `/converge` ledgers.
- `docs start` runs on resume too. It writes nothing, and a product
  commit made while the owner cleared a blocker bears on the plan as
  one made before the start does. Decided by: work item 6.
- The lint's test-edit window stays open while a run is stopped,
  because the base stands, so the resumed test stages may still edit
  tests. Decided by: decision:stopped-run-resumes keeps the base.
- Step 7's write-stage refusals stay "genuine blockers under step 11",
  and step 11 carries the stop-record instruction, so step 7 inherits
  it.
- `F/skills/plan-docs/SKILL.md` (open documentation sprint) names the
  stop record's reason where one stands, beside its existing offer of
  `/goal <path>`, which now resumes, or the archive.
- `F/skills/converge/SKILL.md` (sprint-mode return) names the stop
  record and `SPRINT STOPPED` beside `SPRINT NOT COMPLETE`. Decided by:
  the cheatsheet's one idiom per job.
- `/discover-design` keeps its own resume step (`tasks use` and
  settling each task by hand); decision:stopped-run-resumes covers
  sprints and documentation sprints only.
- `F/scripts/ok-cheatsheet.md` stays as it is: it names neither the
  goal rule nor the stop.
- `@decision: stopped-run-resumes` goes at the `--all` selection
  helper in `tasks`. The stage that lands it runs with or after the
  stage that applies the decision delta, so the citation resolves.
- `retry --all`, the stop records, and the `SPRINT STOPPED` and `DOCS
  STOPPED` lines with exit 3 are internal: no rule of the surface
  intent makes any of them public.
- What the tracker offers today: `tasks use <path>` selects an
  existing run file; `tasks init` refuses an existing run file unless
  given `--force`, which truncates it; `tasks retry <task>` handles
  one task per call, releasing a `running` task or an unclaimed pass
  task and reopening a task that closed `blocked`, `partial`,
  `disputed`, or `failed`. The tracker keeps no record of whether an
  agent is alive. `retry` on a closed task leaves its open waiters
  `issued=1`, because `cmd_close`'s `step` issued them when the task
  closed; improvement I1 fixes that.
- Notes review: on resume, `retry --all` reopens a test task that
  waited on its support task, and the write stage then no longer sees
  it as blocked on support, so it would run before its support exists.
  On resume, `--stage write` treats a reopened, unissued test task that
  has an open support item as blocked on support, and adds the support
  task it files to that test task's `after` in the same filings write.
  The task is still issued again, as the owner ruled. Decided by:
  decision:test-support-written-before-tests ("a support task makes
  the change before the test task runs again").
- Notes review: under B14, `review certified` exits 1 with the folders
  message and prints no verdict. That refusal is a blocker under step
  11: the session writes the stop record and runs `review certified`
  again, which prints `SPRINT STOPPED`, because the stop check runs
  before the folders read.
- Notes review: step 3 decides whether `.ok-planner/bin/tests` is
  required by running `.ok-planner/bin/tests enabled`. Moved ahead of
  the base in step 2, the check requires the tool before it runs it,
  or decides from `-plan.json` alone.

**Changes**
- `F/scripts/review::STOP_RECORD`, `stop_record`, `stop_reason`: new.
  `stop_reason` returns `None` where no record stands, else the
  record's lines (empty where the file is empty).
- `F/scripts/review::cmd_certified`: changed to run the stop check
  after the `closed:` branch; cites `@decision:
  every-stop-ends-the-goal` and `@decision:
  sprint-goal-read-from-the-repository`.
- `F/scripts/review::VERB_HELP["certified"]`: changed to name `SPRINT
  STOPPED`.
- `F/scripts/docs::cmd_complete`: changed. The same stop check runs
  after the archived `closed:` branch, prints `DOCS STOPPED`, and exits
  3, with the same citations.
- `F/scripts/docs::USAGE`: changed to name the stop record and exit 3.
- `F/scripts/tasks::retry_kind`: new, shared by both forms. For a task
  it returns `released` (state `running`, or an open pass task),
  `retried` (closed with an outcome in `RETRYABLE` and no task naming
  it `previous`), or nothing.
- `F/scripts/tasks::reset_task`: new; the reset `cmd_retry` held. It
  pops `fork_of`, sets state `open`, sets `outcome`, `result`,
  `closed`, and `claimed` to none, and sets `issued` to 0.
- `F/scripts/tasks::retry_records`: new; cites `@decision:
  stopped-run-resumes`. For a set of tasks it builds one list: each
  reset task; each open, non-pass, issued task whose `after` list names
  a task the set reopens, set back to `issued=0`; and one
  `TASKS.TASK.RELEASED` or `TASKS.TASK.RETRIED` event per reset task,
  with ids from `next_ids("e", ...)`, in the shape of `add_items`.
- `F/scripts/tasks::cmd_retry`: changed. It takes `<task>` or `--all`,
  and refuses both together or neither, naming the two forms. The
  single form keeps its refusal message and adds a refusal for a
  closed task a refile replaced: "task tN was refiled as tM; retry tM".
  Both forms write through one `put_many` of `retry_records`. The
  single form prints `released tN` or `retrying tN` as today; `--all`
  prints one such line per task in task order, or `retry: no task to
  issue again`. Both exit 0.
- `F/scripts/tasks::build_parser` (retry): `task` becomes `nargs="?"`,
  and `--all` is added as `store_true`.
- `F/scripts/tasks::USAGE` (retry entry): changed to `tasks retry
  <task> | --all`, saying what `--all` issues again, that a task a
  refile replaced stays closed, and that waiters of a reopened task are
  un-issued.
- `F/skills/plan-sprint/sprint-document.md`:
  - Step 1: the stop condition reads "…prints `SPRINT COMPLETE` or
    `SPRINT STOPPED`…"; where `<stem>-stopped.txt` stands, the step
    deletes it before the run goes on.
  - Step 2: reordered as in Calls. Every pre-run stop writes the stop
    record, then runs `review certified`. Where the base stands, the
    step keeps it and skips the uncommitted check; where
    `-certified.txt` also stands, it runs `review certified` and, on
    `SPRINT COMPLETE`, offers the archive.
  - Step 3: the moved checks go. Where the run file stands: `tasks use
    <run file>`, `tasks retry --all`, then every registration and
    config again. Otherwise `tasks init` as today.
  - Step 4: the resume filing rule from Calls, for build stages and
    the test-stage verbs.
  - Step 6: on resume, the checklist is built from the run.
  - Step 11: at a genuine blocker, wait until no agent you started
    still runs, write the stop record naming the blocker, then run
    `review certified` and stop.
  - Step 13: on `SPRINT NOT COMPLETE`, after the veto, write the stop
    record naming each failure, run `review certified`, and stop.
  - Archive step 2: names `-stopped.txt` among the `<name>-*` files.
  - Goal rule: names `SPRINT STOPPED` as a line that ends the goal
    while the contract stays unmet.
- `F/skills/plan-docs/doc-sprint-document.md`, the same shape:
  - Step 1: names `DOCS STOPPED` and deletes the record.
  - Step 3: the tools check, then `docs start`, then base-or-keep.
  - Step 4: where the run file stands, `tasks use` and `retry --all`,
    then prompts written and registered again and config set again;
    otherwise `tasks init`.
  - Steps 5 to 7: file no task whose role and key the run holds; the
    fact loop continues from the highest round the run records.
  - Step 8: a failure the session cannot work writes the record, then
    runs `docs complete`.
  - Goal rule: names `DOCS STOPPED`.
- `F/skills/_sprint/shared.md::{{CEREMONY-RUN-RULES}}`: changed. At a
  genuine blocker, wait for in-flight agents, write `<stem>-stopped.txt`
  naming the blocker, run `docs complete --sprint <path>`, and stop. A
  new `/goal` resumes the run.
- `F/skills/_sprint/shared.md::{{CEREMONY-ARCHIVE}}` step 1: names the
  `-stopped.txt` record among the files moved.
- `F/admin/retired-boilerplate.json` and
  `F/admin/retired-doc-sprint-boilerplate.json`: changed. Each adds
  every released line the new templates drop, exactly as
  `checks/sprint-boilerplate` computes, so true-up's
  `current_boilerplate` brings every live sprint and documentation
  sprint current with no code change.
- `F/scripts/ok-planner-CLAUDE.md` (the documentation-sprint paragraph
  and the "Executing a sprint" close paragraph) and
  `F/scripts/ok-planner-cheatsheet.md` (the `docs complete` paragraph
  and the lifecycle paragraph): changed to name the stop record,
  `SPRINT STOPPED`, and `DOCS STOPPED` beside the COMPLETE lines and
  the `SPRINT NOT COMPLETE` stop, and to say that a new `/goal`
  resumes a stopped run from its base and task record.
- `F/skills/plan-docs/SKILL.md` (open documentation sprint) and
  `F/skills/converge/SKILL.md` (sprint-mode return): changed as in
  Calls.
- `.ok-planner/review/project.md::Scripts`: the review entry names the
  stop record, `SPRINT STOPPED`, and exit 3; the tasks entry names
  `retry <task> | --all`, its refusals, and the un-issuing of waiters.
- `F/scripts/tests::blocked_on_support` and its caller in the write
  stage: changed as in the resume call above.

**Improvements**
- **I1** `F/scripts/tasks::cmd_retry` (single form): A1. Retrying a
  closed task leaves its already-issued open waiters claimable, so a
  waiter whose files overlap can run beside the reopened task, two
  writers on one file; and the task record and its event land in two
  writes. Afterward: through `retry_records`, the reset, the un-issued
  waiters, and the event land in one write, and a waiter is issued
  again only once the reopened task closes.
- **I2** `F/scripts/tasks::cmd_retry` (single form): A1. Retrying a
  closed task a refile replaced runs its stage a second time, beside
  the refile. Afterward: the single form refuses such a task and names
  its refile.

**Behavior changes**
- **B24** `F/skills/plan-sprint/sprint-document.md::steps 2–3`.
  Before: a missing tracker, missing profiles, or a missing tests tool
  stopped the run after `-base.txt` was written, which opened the
  lint's test-edit window. After: those checks stop the run before the
  base is written.
  Users: in the release: the executing session and the lint. Across
  Trued-up projects: live sprints.
  Ruling: migrate: true-up rewrites the boilerplate from
  `retired-boilerplate.json` (call, decision:live-sprints-brought-current-on-true-up)
- **B25** `F/skills/plan-sprint/sprint-document.md::steps 1, 2, 11, 13,
  goal rule`. Before: after a stop, the goal kept looping on `SPRINT
  COMPLETE`. After: each stop writes a stop record, `review certified`
  prints `SPRINT STOPPED`, and the goal ends; step 1 clears the record
  on a new `/goal`.
  Users: in the release: `/goal` checkers and executing sessions.
  Across Trued-up projects: live sprints.
  Ruling: migrate: true-up rewrites the boilerplate from
  `retired-boilerplate.json` (call, decision:live-sprints-brought-current-on-true-up)
- **B26** `F/skills/plan-sprint/sprint-document.md::steps 2, 3, 4, 6`
  (resume). Before: a new `/goal` on a sprint whose base stands stops
  at the uncommitted-paths check, because the tree holds the run's own
  work, and past that check `tasks init` refuses the existing run file.
  After: the session keeps the base and takes up the run; every task
  that did not close `done` (the latest of each refile chain) and every
  abandoned claim is issued again, and no stage is filed twice.
  Users: in the release: executing sessions. Across Trued-up projects:
  live sprints stopped under an earlier release, which hold a base file
  and a run file in the unchanged run-log format.
  Ruling: migrate: true-up rewrites the boilerplate from
  `retired-boilerplate.json`, and the same true-up ships the tracker's
  `retry --all`, which reads an earlier release's run file as it
  stands (call, decision:live-sprints-brought-current-on-true-up)
- **B27** `F/skills/plan-docs/doc-sprint-document.md`. As B24 to B26,
  with `DOCS STOPPED`, the documentation sprint's own base file and run
  file, and `docs start` ahead of the base.
  Users: in the release: the executing session. Across Trued-up
  projects: live documentation sprints.
  Ruling: migrate: true-up rewrites the boilerplate from
  `retired-doc-sprint-boilerplate.json` (call, decision:live-sprints-brought-current-on-true-up)
- **B28** `F/skills/_sprint/shared.md::{{CEREMONY-RUN-RULES}}`. Before:
  at a genuine blocker, surface it and stop. After: wait for in-flight
  agents, write the stop record, run `docs complete`, then stop.
  Users: in the release: documentation-sprint sessions; true-up
  rewrites the vendored file wholesale.
  Ruling: rewrite
- **B29** `F/skills/plan-docs/SKILL.md` (open documentation sprint).
  Before: it names the sprint and offers `/goal <path>` or the archive.
  After: where a stop record stands, it also names the record's
  reason, and the `/goal` it offers resumes the run; after a stop
  from `docs start`, it offers instead to set the stale plan aside
  and plan again (work item 6).
  Users: in the release: `/plan-docs` sessions.
  Ruling: rewrite
- **B30** `F/scripts/ok-planner-CLAUDE.md`,
  `F/scripts/ok-planner-cheatsheet.md`, `F/skills/converge/SKILL.md`
  (goal, stop, and resume wording). Before: they name only the
  COMPLETE and NOT COMPLETE lines. After: they also name the STOPPED
  lines, the stop record, and resume.
  Users: in the release: agents that read the materialized rules and
  guide, which true-up rewrites wholesale.
  Ruling: rewrite
- **B31** `F/scripts/tasks::cmd_retry` (I1). Before: retrying a closed
  task leaves its issued open waiters claimable, and writes the task
  and its event in two writes. After: those waiters wait until the
  reopened task closes, and one write carries the task, the waiters,
  and the event.
  Users: in the release: the drain loop and `/discover-design`, which
  retry only `running` tasks and pass tasks (neither has issued
  waiters), and step 3 of both templates through `--all`. The run-log
  format is unchanged: `issued` is an existing field.
  Ruling: rewrite
- **B32** `F/scripts/tasks::cmd_retry` (I2). Before: `retry <task>`
  reopens a closed task a refile replaced. After: it refuses and names
  the refile.
  Users: in the release: none in the tree retries a closed task.
  Ruling: rewrite

## How to execute this sprint

This sprint is self-sufficient. Every executor — an inline session,
an agent handed this file via `/goal`, an orchestrator with its own
planning — runs the same shape: record the base commit, plan the work
into the task tracker as small build tasks cut from the
implementation notes, drain them, then run sprint certification once.
No review runs during the build.

1. Read the sprint whole first: intent, deltas, work items,
   implementation notes, completion contract. The sprint is the whole
   brief: context from the intake (`.ok-planner/issues.jsonl`) or
   `history/` may disagree with what the owner approved. Raise a gap
   with the owner. Where `/goal` handed you this file, its checker is
   a separate model that reads only the session: it opens no file and
   runs no command. State its stop condition in your first message,
   in these words: "This goal is met when `.ok-planner/bin/review
   certified --sprint <this sprint's path>` prints `SPRINT COMPLETE`
   in this session. Archiving and committing are the owner's acts,
   not goal terms."

2. Check the approval, then record the base. Run
   `.ok-planner/bin/review approved --sprint <this sprint's path>`
   first. Where it refuses, name its message to the owner and stop:
   this file may be a draft the owner never approved, or the review
   estate lacks the `.ok-planner/review/config.json` the command
   reads. Sprint certification reads the change from the base
   commit, so the tree holds nothing but this sprint's work from here
   on. The planning session leaves its own files uncommitted: this
   file, its delta sidecar, `.ok-planner/release-boundaries.md`, the
   intake's two files (`.ok-planner/issues.jsonl` and
   `.ok-planner/history/issues.jsonl`), and the sketches and the
   discovery it archived. Where `git
   status --porcelain` lists a path outside `.ok-planner/`, name those
   paths to the owner and stop, because certification would count
   them as this sprint's work. Otherwise write the output of `git
   rev-parse HEAD` to the file beside this sprint with the same
   filename, `-base` before the extension and `.txt` as the
   extension.

3. Open the run. The task tracker at `.ok-planner/bin/tasks` and the
   profiles under `.claude/agents/` are required; a missing one is
   the front door's administration (`/ok`) to materialize: say so and
   stop. `tasks init <sprint-name> --file
   .ok-planner/sprints/<sprint-name>-run.jsonl`, `tasks agent
   register ok-opus`, and register the `build` prompt: write it with
   `.ok-planner/bin/review prompt --name build --sprint <this sprint's
   path> --out .ok-planner/sprints/<sprint-name>-build.md`, then `tasks prompt
   register build <that path>`. Declare the roles whose close carries
   a sweep: `tasks config set swept_roles '["build", "fix"]'`, so a
   build task closes `done` only with the sites its searches
   returned, each one staged.

4. Plan the work into stages from the implementation notes. Read the
   code each work item's notes name, in the tree as it stands now,
   before you file anything. Where the tree has moved since the
   notes' commit and a named site no longer matches, plan from the
   outcome the notes state and record the difference as a divergence
   call. Cut the sprint into stages, each **the smallest change that
   makes progress toward the completion contract and leaves the tree
   runnable**: it builds, nothing is half-wired, and the work after it
   can build on it. A stage lands one work item or a part of one. A
   work item that needs more than one agent's reading set becomes
   several stages in sequence. A taken improvement lands in the same
   stage as the change to its definition. Per stage, file one build
   task: `tasks file --role build --prompt build --agent ok-opus
   --key <stage> --files <the paths it may edit> --cites <the work
   items and slugs> --after <the build tasks of the stages it builds
   on, omitted where it builds on none> --brief "<the work items it
   lands, the improvements and deltas it applies, the behavior
   changes it carries by id with their rulings, and where the code
   is and what to reuse>"`. Two stages whose files overlap are
   chained with `--after`; a stage that applies a delta reaches its
   collection's catalog TOC too (`.ok-planner/design/concepts.md`,
   `stories.md`, or `decisions.md`, `.ok-planner/subjects.md` or
   `.ok-planner/practices.md`, or the docspec index
   `.ok-planner/docspec.md`, every one of which
   `python3 .ok-planner/bin/catalog-toc` regenerates), so two
   delta-bearing stages overlap. Stages with disjoint files run together. Apply a
   delta no work item implements in a stage of its own.

5. Render the completion report with the staged list before the first
   drain: write the output of `tasks render --title "<this sprint's
   title>" --sprint <this sprint's path>` to the report file (step
   10).

6. Keep the progress checklist. Where the harness task tools are
   available, mirror the stages as a live checklist. Create one entry
   per stage when the build tasks are filed. Mark an entry in progress
   when the drain that runs its build task starts, or when its agent
   claims the task where the session runs the drain by hand, and done
   when that task closes `done`. Add one entry for sprint
   certification when every stage's build task has closed `done`.
   Mark that entry in progress at step 12 and done at step 13.
   The run file is the record and the checklist is display.

7. Drain with the loop at `.claude/skills/_tasks/drain.md`.
   A build that closes `partial` is refiled for its remainder with
   `tasks refile <task>`; one that closes `partial` with a result
   starting `outside files:` is refiled with that path added to its
   files. A build that closes `blocked` is refiled once. The session
   builds nothing and reviews nothing itself, and edits no file a
   running task owns.

8. Every stage applies its corpus deltas as part of the work that
   realizes them, and every new or amended story implemented in code
   carries the `@story:` annotation at the site that realizes it. The
   build prompt carries both rules.

9. Uncommitted work is the only record of the run. Every task stages
   the paths it touched as it closes (`git add <paths>`), and the run
   records them. Never run `git checkout`/`restore`/`reset`/`stash`/
   `clean` on your own initiative. Fix a bad edit forward by editing
   again.

10. The completion report lives beside this sprint file, same
    filename with `-completion` before the extension. The session
    re-renders it whole from the run before every drain: `##
    Stages` from the build tasks and `## Calls` from the run's
    `divergences` pool, one row per call an agent made without the
    owner. Build tasks record calls, forks, what they noticed, and
    the improvements they landed as items; the report is rendered,
    never hand-edited.

11. Work unsupervised to a defensible done. Do not pause for
    approval, confirmation, or progress checks. Execution and sprint
    certification need no owner action: file no task for the owner to
    perform. The archive and the commit after completion stay the
    owner's one act. Stop only on a genuine blocker: a credential or
    access you cannot obtain, a step impossible in the current state,
    a destructive or irreversible action not clearly authorized, a
    task closed `blocked` twice, or sprint certification being
    unrunnable for you. Surface that and stop. Ambiguity is not a blocker: the builder makes the most
    plausible call and records it, or records a fork and builds the
    reading it judges best. Sprint certification reads both.

12. Code complete means every stage's latest build task closed
    `done`. Then mark the checklist's sprint certification entry in
    progress, and run sprint certification immediately after:
    `/converge sprint <this sprint's path>`. It judges the change
    from the commit in the `-base.txt` file to the working tree,
    once, against this sprint: every outcome and taken improvement
    works, a user gets what every story promises when a driver uses
    the running product, every delta landed, every ruling holds, no
    unlisted behavior change breaks a user, and the project's checks
    pass. It fixes each defect in the sprint's scope, a drive failure
    the sprint's change caused among them, and verifies each fix on
    its own diff. A drive failure in code the change did not reach,
    and any other defect outside the sprint's scope, goes to the
    intake as a `category: defect` issue for the next `/converge`,
    and a question only the owner can decide goes to the intake for
    the next `/plan-sprint`.
    It ends by presenting its return block.

13. Re-render the completion report whole with the certification's
    calls: write the output of `tasks --file
    .ok-planner/sprints/<sprint-name>-run.jsonl render --title
    "<this sprint's title>" --sprint <this sprint's path>
    --certification <the /converge run's ledger>` to the report
    file. `--file` names this sprint's run, because `/converge`
    moved the tracker's pointer to its own ledger. Then write the
    return block into the completion report, after its rendered
    sections, under a `# Sprint certification` heading, with the
    `/converge` run's ledger path. Nothing renders the report after
    this. Mark the checklist's sprint certification entry done. Then
    run `.ok-planner/bin/review certified --sprint <this
    sprint's path>` and show its output whole. It checks items 1 to 3
    of the completion contract against the repository, and prints
    `SPRINT COMPLETE`, or `SPRINT NOT COMPLETE` with each failure.
    Whichever it prints, present the completion report's `## Calls`
    table to the owner and follow `{{CEREMONY-VETO}}` in
    `.claude/skills/_sprint/shared.md`, with `<rows>` as the rows of
    the completion report's `## Calls` table and `<problem>` as the
    row. Then, where it printed `SPRINT NOT COMPLETE`, name each
    failure to the owner and stop without offering the archive: it is
    a genuine blocker under step 11. Where it printed `SPRINT
    COMPLETE`, offer the archive and the commit below as one
    owner act. Walk nothing else with the
    owner: every defect the run could not fix and every question it
    raised is already in the intake, for the next `/converge` or
    `/plan-sprint`.

**The archive and the commit.** The owner archives this sprint and
commits the work; offer both as one owner act, and wait. "Finish the
sprint" and "follow the boilerplate" are not a yes; both ask for the
presentation. On the owner's yes:

1. Close each issue this sprint promoted: for each id that
   `.ok-planner/bin/issues list --sprint <this file's name>` prints,
   run `.ok-planner/bin/issues close <id> --as promoted`, which moves
   its record to `.ok-planner/history/issues.jsonl`.
2. Move this file, its completion report, its run file, its
   `-base.txt` file, its `-build.md` prompt, and its delta sidecar to
   `.ok-planner/history/sprints/`: `git mv` for a tracked file, `mv`
   for an untracked one.
3. Stage by name every path the sprint's change touched, every moved
   file at its new path, the `/converge` run's ledger and folder, the
   intake's two files, `.ok-planner/issues.jsonl` and
   `.ok-planner/history/issues.jsonl`, and each sketch and each
   discovery file the planning session archived, at its old path and
   its new one: `git status --porcelain --untracked-files=all --
   .ok-planner/sketches .ok-planner/history/sketches
   .ok-planner/discoveries .ok-planner/history/discoveries` lists
   them: an `R  <old> -> <new>` line names both paths of a file
   `git mv` moved, a ` D <old>` or `D  <old>` line names a removed
   path, and a `?? <new>` line names a new path under
   `.ok-planner/history/`. Commit those paths alone with
   `git commit -- <paths>`, naming each path that exists and each
   removed path the last commit holds, a `git mv` source or a file a
   task removed with `git rm` among them, and no other, so nothing
   else standing in the index rides along.
4. Add `closed: <the commit's sha>` to the archived sprint's YAML
   frontmatter, beside its `approved:` mark, or as new frontmatter
   where the sprint has none, and commit that edit alone. The next
   planning session reads that stamp to detect work done out of band.

The owner publishes; the run never pushes.

## Completion contract

The work is done when all of the following hold, each verifiable
from the repository as it stands:

1. Every corpus matches every delta above, applied verbatim (from
   the sidecar where a heading points there): `.ok-planner/design/`
   for a concept, story, or decision, `.ok-planner/subjects/` or
   `.ok-planner/practices/` for a subject or practice, and
   `.ok-planner/docspec/` for a docspec, each with its catalog TOC
   regenerated, the docspec index `.ok-planner/docspec.md` among
   them; and `.ok-planner/surface/surface.md` for the surface
   intent.
2. The project builds, and the checks `.ok-planner/review/config.json`
   lists under `checks` pass on every file the change touched, or fail
   only where sprint certification's return lists the failure as a
   `stuck` defect.
3. The completion report beside this sprint (same filename with
   `-completion`) carries the return block of sprint certification
   (`/converge sprint`) run on this sprint, under `# Sprint certification`: the run's find
   loop ran once, and every defect stands `verified`, `declined`,
   `duplicate`, or `stuck`, with every `stuck` defect listed for the
   owner. Where the project has a story, the run's drive ran: drive
   commands unfilled or refused, or a stack that failed to start,
   mean it did not.

**The goal rule, for any checker verifying this contract.** The goal
is met when items 1–3 verify against the repository as it stands.
`.ok-planner/bin/review certified --sprint <this sprint's path>`
checks them there and prints `SPRINT COMPLETE` or `SPRINT NOT
COMPLETE`. A checker that reads only the session, as `/goal`'s does,
decides from that command's latest output in the session; a checker
that runs commands runs it. A `stuck` defect listed in the
return, a check that still fails among them, is the owner's to take
up, and holds no term of the contract open.
Presenting the report, archiving, committing, and the
`closed:` stamp all follow completion, and none is a term of the
goal. `sprints/` and
`.ok-planner/history/sprints/` satisfy the rule alike, and a sprint
already archived with a `closed:` stamp is terminal. A missing
completion report, or one without the return block,
means not done. Nothing else counts either way.
