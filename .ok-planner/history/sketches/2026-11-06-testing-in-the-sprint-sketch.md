# Testing inside the sprint — Design Sketch

**Date:** 2026-11-06
**Status:** Sketch (not a sprint; not authorization to build)

## Idea

Retire `/plan-tests` and the test sprint, and make testing part of
every sprint. A new verb, `/ok-setup`, turns testing on, freezes it,
or turns it off. `/plan-sprint` re-plans the tests of every tested
story whose behavior the sprint changes, and offers, in groups the
owner takes one at a time, the untested stories, the stories whose
tests are stale, the legacy test folders, the runtime scenarios, and
the slowest tests no reader has examined. Execution writes the planned
tests in build stages after the code stages. Sprint certification runs
the suite as a fifth source of defects, fixes code for failing tests
with no cap, reruns only the tests each fix reaches, and ends on a
passing whole-suite round. Every new or rewritten test gets a speed
reading when written, and acceptances last across sprints, so the suite
gets a little faster with each sprint. The design comes from the 22
open test-related issues in the intake as of 2026-11-06 and the
owner's rulings in a session that day; each ruling below is the
owner's.

## Shape

### Rulings

Every ruling below is the owner's, given 2026-11-06 unless marked.

| Topic | Ruling |
|---|---|
| The fold | `/plan-tests` and the test sprint fold into `/plan-sprint` and a sprint's execution. |
| Execution order | Build stages, then sprint certification. The test process runs inside certification. |
| Test fixes | The test process always fixes code. Certification reads the code; the test process executes it; both fix. |
| The cap | A defect whose source is the suite has no cap on send-backs. Other sources keep `fix.max_kickbacks`. |
| The final round | Certification ends on a passing whole-suite round after the last code change. Only test failures reopen the loop. |
| Each fix verified | Every fix in certification, whatever its source, passes the same verifier, which also reruns the tests the fix reaches. |
| Required re-plans | Planning re-plans every tested story whose behavior the sprint changes, whether or not its text changes. Under `frozen`, only `rewrite` and `retire`. |
| Offers | Stale stories, untested stories (in logical groups), legacy folders, runtime scenarios, and unread slow tests are offered, never forced. Each is doable one part at a time. |
| `/ok-setup` | A family verb sets up, changes, freezes, or stops testing. `testing.enabled` is `on`, `frozen`, or `off`. |
| The schedule | The suite recommends a schedule rule. A project may depart and record the schedule it runs, so nothing raises it again. |
| `reads` | Tests declare the shared resources they read as well as those they change. |
| Coverage | Each result may carry `reaches`, a per-test coverage record. A fix reruns only the tests whose `reaches` names a file it changed. No record means rerun. |
| Recorded answers | `testing.schedule` and `testing.reaches` hold the owner's answer in `said`. True-up writes the former behavior and files one issue while `said` is null. |
| The end speed batch | Ranks only the tests the sprint wrote or modified. Older tests reach later sprints through the unread-slow offer. |
| The seed | Recommended: read-only test data, built on demand entry by entry, grown by the tests that need it. |
| Rewrites and declarations | A rewrite may add or drop entries in `resources` and `reads`; the verifier reads each, and each addition is a call. |
| Testability rules | Four new coding rules: observable outcomes, per-service entry points, removable created state, progress output. A fifth, caller-chosen scope, dropped. |
| Test paths | The lint opens test paths for the sprint's run; `review certified` refuses a test path a code task staged. |
| Already built | Two rulings of 2026-11-02 stand in the source: the setup step with its own silence clock, and the scope that bounds the sort. |

### 1. Setting up testing: `/ok-setup`

`/ok-setup` is a family verb the owner runs. It is not part of `/ok`,
which does suite administration alone and never drives work.

- **Turning testing on.** It asks for the runner keys `/plan-tests`
  step 2 asks for today (`run`, `silence`, `named`, `leftovers`,
  `slowest`, `runners`, `setup`, `setup_silence`), and for
  `testing.schedule` and `testing.reaches` with the owner's answers.
  It plans the test stack's budget with the budget planner. It records
  which standing offers `/plan-sprint` makes: untested story groups,
  legacy folders, the runtime group, and the N unread slow tests.
- **Changing it.** Run again, it changes any of these.
- **`testing.enabled`**, a required key with three states:
  - `on`: every sprint maintains the tests and makes the offers.
  - `frozen`: certification runs the existing suite as a find source,
    and its fixers fix what the suite finds. `/plan-sprint` makes no
    offer, and plans only the `rewrite` and `retire` each changed
    story needs.
  - `off`: certification skips the suite. The tests stay in the tree,
    unmaintained.
- **True-up** writes the former behavior: `on` in a project with a
  `test-state.json` an earlier test sprint wrote, and `off` in any
  other.
- **A project with no `testing` keys.** Certification skips the suite
  as a find source and says so in its return. The completion contract
  does not wait on it.

### 2. Planning: `/plan-sprint`

#### What planning must re-plan

Planning re-plans every tested story whose behavior the sprint changes.
Stories are high level, and a sprint often adds a new way to get a
story's benefit without changing the story's text. Each re-planned
scenario becomes `new`, `rewrite`, `retire`, or `keep`. The re-plan is
required, because certification otherwise runs an old test against
new code, and a fixer that cannot edit a test either undoes the
sprint's feature or files a false promise issue.

Two steps that already run before approval find the stories:

- The code planner already lists "every existing behavior they alter
  with its users". It also lists each tested story whose
  implementation the work items change: from the `@story:` citations
  in the files they touch, and from each recorded test whose `reaches`
  names one of those files.
- The notes review checks that list against the sprint and the code.

A story the sprint's deltas add gets proposed scenarios. The owner may
decline them; the story then joins the untested list.

#### What planning offers

At Frame, `/plan-sprint` offers each of these in groups. The owner
takes any group whole, so a project with many stories takes on tests
one meaningful group at a time.

- **Stale stories.** Each story keeps a test stamp: the commit at
  which a plan last planned its scenarios. A story whose file changed
  after its stamp stays open until a sprint takes it.
- **Untested stories.** A story with no recorded scenario and no
  recorded no-guard answer.
- **Legacy folders.** Test files no scenario claims, grouped by
  folder. A sprint sorts only the folders the owner takes, as adopt,
  port, support, or delete. Every other file stays as it stands.
- **Runtime scenarios.** Failures of parts the product holds or
  depends on, as one group.
- **Unread slow tests.** The N slowest tests, inside what the sprint
  takes, that have no speed acceptance at their current file. A
  planner who finds no waste in one records an acceptance, so the
  next sprint offers the next N. Over time the offer reaches zero,
  because every new and rewritten test gets its reading when written.

#### How planning plans the tests

The planners `/plan-tests` runs today (story, runtime, sort, programs,
budget, the planner review, and the plan-wide review) run inside
`/plan-sprint`, over only the stories and folders the sprint takes or
must re-plan.

- The programs planner's questions about programs no story serves
  join `/plan-sprint`'s Resolve step.
- The budget planner runs only where the sprint's tests or stack
  changes would change the budget.
- A test that waits on a time control the product lacks makes that
  time control an ordinary work item, built by a code stage.
- `/plan-sprint` writes the sprint's `-plan.json`, which names each
  test path and its action. The owner approves the tests with the
  sprint, once.

#### Leaving the tree ready

From `planning-hands-off-a-tree-execution-refuses`, ruled: "the
planning phase (sprint, test, or docs) should leave the repo in a
state where whatever was just planned is ready to execute with no
interruptions". In `/plan-sprint` and `/plan-docs`, after the owner
approves, the session runs `git status --porcelain`. Where it lists a
path outside `.ok-planner/`, the session names those paths, grouped by
the work each belongs to, and in the same message asks once to commit
them, proposing commits staged by name. On the owner's yes it makes
the commits. It hands over the `/goal` line only once no path outside
`.ok-planner/` stands uncommitted. Where the owner declines, the
session names what execution's base step will refuse and hands over
no goal line. Execution keeps its check as a guard.

### 3. Execution: the build stages

- Code stages come first, time controls among them, each certified as
  code.
- Test stages follow the code stages they test: the preflight where
  the budget changed, support tasks, test tasks, legacy tasks, the
  sweep, and verify tasks. They change no product code. Test work that
  touches no code stage's files, such as an untested group, may run
  beside the code stages.
- **Test paths.** The lint opens test paths from the sprint's
  `-base.txt` until `review certified` passes, where `testing.enabled`
  is `on` or `frozen`. Only a sprint's test tasks add, edit, or delete
  a test. Each test task's `files` holds only its planned paths.
  `review certified` refuses where a code task (a build stage that is
  no test stage, or a certification fixer) staged a test path, and
  where a test file stands that no planned test claims.

### 4. Certification: `/converge sprint`

Certification keeps its two loops and gains the suite.

1. **Find.** Five sources file reports: the review passes
   (completion, regression, alignment), the build's noticed defects,
   the project's checks, the drive, and now the suite. Each failing
   test and each grown leftover count files a report. The merge folds
   all reports into one defect list.
2. **Fix and verify.**
   - A fix never edits a test to pass. A fix may change code to meet
     what its story promises, to make it testable, or to make tests
     faster. No fix alters what the design corpus commits to.
   - One verifier reads every fix, whatever its source. It runs
     certification's checks: no new accept-list harm, every caller of
     a changed contract brought along, no behavior across a release
     boundary changed without a ruling, and the project's checks pass
     on the changed files. It also runs the test checks: no test
     detection, no hidden failure, no faked effect, no test path
     touched. It reruns the tests the fix reaches, from their
     `reaches`, and sends back a fix that fails a test that passed
     before it.
   - **The cap.** A defect whose source is the suite has no cap and
     never goes stuck. Its one way out is the promise path: a verifier
     agrees that only a change to what the corpus commits to meets the
     test, and files an issue. A new test that never passed cannot loop
     on missing code, because its test task recorded it as a gap. Every
     other defect keeps `fix.max_kickbacks` and its backout.
3. **Confirm.** A confirm driver drives each fixed drive defect's
   story again, and the fixed test runs again for each suite defect.
4. **The final whole-suite round.** Once no defect stands open,
   certification runs the whole suite once. Each failing test files a
   report, the merge adds it as a suite defect, and the fix loop
   resumes. This repeats until a whole-suite round passes after the
   last code change, or each failing test has a held promise issue.
   The review passes, the checks, and the drive do not run again, so
   only test failures reopen the loop.
5. **The end speed batch.** Once the final round passes, one speed
   task reads each of the `testing.slowest` most costly tests among
   those the sprint wrote or modified. A send-back goes to a test task,
   and the rewrite's tests run again under step 4's rule.
6. **`review certified`** requires the passing final round, the test
   path checks of section 3, and the end batch's verdicts.

The sprint's archive step stamps each story's test stamp and writes
the scenario list, the speed acceptances, and the `reaches` lists into
`test-state.json`.

### 5. The schedule

**Issues:** `tests-schedules-resource-groups-itself` (revised
2026-11-06), `slowest-ranking-assumes-held-tests-run-alone`,
`tests-run-only-runs-serially`,
`second-recorded-test-run-refuses-or-waits`,
`tests-results-stream-shared-between-runs`.

The owner's line, from the revised issue: "the project owns the
implemention, but the plugin should prescribe parallelism and test
dependencies to decide what can run when." The owner's comment of
2026-11-06 adds: "Some projects, for whatever reason, may not be able
to follow the recommendation. Such a project needs a way to record
that, so true-up and the skills don't keep raising it."

- **The rule.** The testing standard and the suite command's contract
  recommend one rule: two tests may run at the same time unless one
  changes a resource the other changes or reads. Tests that share a
  changed resource form one group, which runs its tests one after
  another on one worker. The run uses at most the budget's workers.
- **`reads`.** The resources rule adds `reads` beside `resources`. A
  test lists each shared resource it reads and does not change. The
  planners write it, and the planning reviewer checks it. A scenario
  with no `reads` counts as reading every resource.
- **`testing.schedule`**, a required key, records the schedule the
  suite command runs: `{"form": "<schedule>", "said": "<the owner's
  words>"}`. The forms `bin/tests` knows are `recommended`,
  `groups-side-by-side` (held groups run at the same time as each
  other, after the isolated tests), and `groups-one-at-a-time` (held
  groups run one after another, after the isolated tests), which is
  how linescout's `bin/test` runs now. A departure names what the
  project does instead: "A departure is a competing practice, never
  an exemption."
- **True-up** writes `{"form": "groups-one-at-a-time", "said": null}`
  into a project that lacks the key, which is the ranking
  `wall_cost` gives today. While `said` is null, `bin/tests` ranks by
  the form and skips the schedule check, because a guessed form must
  fail no round. While `said` is null and no open issue carries it,
  true-up files one intake issue, kind `audit`, which asks which
  schedule the suite command runs, proposes `recommended`, and names
  `/ok-setup` as the fix. Once `said` holds an answer, nothing asks
  again and the schedule check runs. The key has no default in code.
- **The schedule check.** `bin/tests` notes the arrival time of each
  result line; a line's start is its arrival less its seconds. After
  each round, it checks every pair of tests that ran at the same time
  against the schedule the key names. A forbidden pair fails the round
  with `schedule--<test>--<test>`, which a fixer of the suite command
  takes up. This replaces `/plan-tests` step 9's runner check for the
  schedule.
- **The ranking.** `bin/tests` ranks by the schedule the key names.
  Under `recommended`, a round's lower bound on wall time is the
  larger of the longest group's total seconds and all tests' total
  seconds over the workers. Under `groups-one-at-a-time`, it is the
  isolated tests' seconds over the workers plus every group's seconds.
  A test's cost is how much the bound drops when its seconds drop to
  zero.
- **`tests run --only`** runs at the budget's workers, not at one.
  `scripts/tests::tested_round` sets `workers = 1 if args.only or
  args.from_file` today.
- **A second recorded run** of one sprint keeps refusing at once, as
  option A of `second-recorded-test-run-refuses-or-waits` says.
- **`tests-results-stream-shared-between-runs`** closes as answered.
  `scripts/tests::run_suite` already makes a fresh stream for each
  run under `tempfile.mkdtemp`, and linescout's `bin/test` writes to
  the path it is given. The shared file came from how the session
  saved each run's output.

### 6. Reruns and coverage

**Issues:** `test-sprint-reruns-tests-a-change-cannot-reach`,
`tests-run-failing-skips-standing-failures`,
`stopped-round-files-fixers-for-unreached-tests`,
`late-tasks-count-test-only-tasks`.

- **Standing results.** Each live test has a standing result: its
  latest result since the latest closed whole-suite round, with the
  digests of its test file and support files when it ran. Linescout's
  local change builds this as `whole_base` and `latest_results`.
  `--failing` reruns every standing failure.
- **`not run`.** A stopped round records each test it never reached
  as `not run`, not as failed, and no fixer is filed for it.
- **`--changed`** reruns each test whose test file or support files
  changed since it last ran, as linescout's local change does.
- **`late_tasks`** counts a task only where it staged a file outside
  the test paths, as linescout's local change does.
- **`reaches`.** Each result line may carry `reaches`: the product
  files the test ran, from a per-test coverage record, or for a stack
  test the folders of the services it reached, where the suite command
  cannot tie a service's code to one test. A folder covers every file
  under it. `bin/tests` keeps each test's latest list, and every run
  of a test replaces it. The first whole-suite run produces the map,
  and `test-state.json` keeps it across sprints.
- **After a fix,** the verifier reruns the tests whose `reaches` names
  a file the fix changed, or a folder above one. A test with no
  `reaches` reruns after every fix. A changed file no test's `reaches`
  names, such as a configuration file, a template, a migration, or a
  lockfile, reruns every test.
- **`testing.reaches`**, a required key, records what the suite
  command writes: `{"form": "files" | "folders" | "none", "said":
  "<the owner's words>"}`. True-up writes `{"form": "none", "said":
  null}`, the former behavior. True-up never edits the suite command,
  which is the project's file: `decision:whole-file-ownership` has the
  suite own "whole files only". While `said` is null and no open issue
  carries it, true-up files one intake issue, kind `audit`, asking the
  owner to add per-test coverage, naming the suite command, the
  `reaches` forms, the coverage tool the project's runner offers, and
  `/ok-setup` as where the answer is recorded. A change true-up cannot
  make "reaches the owner as an issue rather than as unrecorded work".

### 7. Speed

**Issues:** `test-sprint-speed-reading-waits-for-the-end`,
`speed-walk-ranks-by-one-rounds-time`,
`speed-acceptance-follows-shared-support-digests`,
`speed-send-backs-never-settle`,
`speed-review-has-no-product-slow-verdict-or-seed`, and the ruled
`test-sprints-never-act-on-measured-test-time`.

The owner's words: "in the future, all new tests should be audited
for potential speed reductions, plus an N slowest every sprint to
gradually clean up any that were missed. so don't canonize that." And:
"allow sprints to be scoped, but also have some mechanism where the
test plan gradually improves in speed over time."

- **At write time.** The test verifier reads each new or rewritten
  test for speed. Its brief gives the test's seconds from the test
  task's own run, the budget's workers, and the resources the test
  changes and reads. The speed reviewer's Judge section becomes one
  block, `{{TEST-SPEED-JUDGE}}`, which both the verify prompt and the
  speed prompt include.
- **At the end of certification,** one batch, as section 4 says. The
  batch does not walk on until a batch comes back clean.
- **Across sprints,** the unread-slow offer of section 2.
- **The ranking** uses each test's median seconds across the
  whole-suite rounds that ran it in its current form, the test file's
  digest. Round time moves with machine load: linescout's rounds 41
  and 42 ran about 25% slower than round 43.
- **Acceptances** hold until the test's own file changes, across
  sprints, in `test-state.json`. A support change does not clear one:
  in linescout's run, one support change moved the digests of 1,026
  tests whose files had not changed. An accepted test in the end batch
  is read again only where a support file it lists changed since its
  acceptance.
- **A send-back settles** when the verifier accepts the rewrite, as
  linescout's local `rewrite_verified` and `speed_settled` do.
- **`product-slow`.** The speed reviewer may record a test as slow
  because the product is slow, naming the site, what it does, how its
  cost grows, and the cheaper behavior. The fix loop files a fixer
  and its verifier, as for a failing test. Linescout's local change
  builds this; its device page fix took retire-a-device from 13.4 s to
  5.9 s.
- **The seed** is recommended: read-only test data that slow tests
  read, declared as a list of entries, each with its own digest. A
  project may have none. The setup step builds each entry that is
  missing or whose digest changed and reuses the rest. A test task
  that needs seeded data records a `support` item naming the entry;
  the write stage files a support task, which adds the entry and lists
  it as support on each test that reads it. A speed reviewer may name
  a seed entry as the cheaper form. Each test lists only the entries
  it reads, so `--changed` reruns only a changed entry's readers. Each
  seeded object carries a name only the seed uses, and the test
  support refuses to change or remove one, so a reader declares
  nothing under `reads`.
- **No time line.** The testing standard names no speed floor. The
  ranking chooses which tests a reader reads, and the reader judges
  the waste.

### 8. Test tasks and support

**Issues:** `rewrite-tasks-cannot-change-support-or-plan`,
`write-stage-refuses-after-two-blocked-test-tasks`,
`write-stage-loops-on-a-test-tasks-after-list`.

- **The `support` pool** replaces the `helpers` pool. An item names a
  support file and the change a test needs: a missing helper, a
  changed helper, a fixture, or a seed entry. The write stage files a
  support task for each open item, then refiles the blocked test task
  after it. Two blocked closes refuse only where neither named a
  support item.
- **A rewrite** a verifier or a speed reviewer sent back includes its
  scenario's support files in its task's `files`, and may change them.
  `--changed` then reruns every test that lists a changed support
  file.
- **Declarations.** A rewrite may add or drop entries in `resources`
  and `reads`. The verifier reads each change against the waste "A
  shared resource declared where a cheaper design keeps the test
  isolated", and each addition is a call the owner sees at the veto.
- **Outcomes.** A rewrite never changes the scenario's outcome. A
  change to the outcome stays a promise, which its verifier holds or
  rejects.
- **`after` lists.** The write stage refiles no task whose `after`
  list names a task that closed other than `done`, and names that task
  in a refusal.

### 9. Testability rules

`plumbline-coding.md` gains four rules. Accept-list entry A8 covers "a
rule in `.claude/rules/plumbline-coding.md`", so certification counts
each missing feature as a defect.

1. Every outcome a story promises is observable through a public entry
   point, an event the product emits, or a state the product leaves.
2. Each service's logic is callable through that service's own entry
   point without the full stack.
3. Every record or resource the product creates on request is
   removable through its public surface.
4. Every long-running command or tool under the project's control
   prints progress as it works.

Coding rules 10 and 11 already cover settings and timers. A fifth
candidate, that state a caller creates carry a scope the caller
chooses, was dropped: most state a test creates hangs off an account
or a name the test controls, and the testing standard's waste covers
the rest.

### 10. Plain defects

- **`task-fields-read-text-by-how-it-looks`.** `tasks item add
  --field` and `tasks item set --field` parse each value by how it
  looks; the digest `104957870728e435` parsed as infinity. Coding rule
  7.3 reads: "Coerce user text by the declared type of the parameter,
  never by what the text looks like." The fix keeps a value as text
  unless it opens with `[`, `{`, or a quote, or the pool declares the
  field's type, so `--field after=t4647` works.
- **`tests-diff-shows-unchanged-file-as-deleted`.** In
  `scripts/tests::cmd_diff`, a closed snapshot sets `gone =
  snap["after"].get(rel) is None`. A file snapshotted before an edit
  and never named in `snapshot --after` has no `after` entry, so the
  diff shows it as deleted. The fix has `snapshot --after` record every
  path the `before` snapshot holds.

### 11. How each issue ends

| Issue | Section | End |
|---|---|---|
| `tests-schedules-resource-groups-itself` | 5 | promoted |
| `slowest-ranking-assumes-held-tests-run-alone` | 5 | promoted; the revised issue replaces it |
| `tests-run-only-runs-serially` | 5 | promoted |
| `second-recorded-test-run-refuses-or-waits` | 5 | promoted, at option A |
| `tests-results-stream-shared-between-runs` | 5 | answered: each run has its own stream |
| `test-sprint-reruns-tests-a-change-cannot-reach` | 6 | promoted |
| `tests-run-failing-skips-standing-failures` | 6 | promoted |
| `stopped-round-files-fixers-for-unreached-tests` | 6 | promoted |
| `late-tasks-count-test-only-tasks` | 6 | promoted |
| `test-sprint-speed-reading-waits-for-the-end` | 7 | promoted |
| `speed-walk-ranks-by-one-rounds-time` | 7 | promoted |
| `speed-acceptance-follows-shared-support-digests` | 7 | promoted |
| `speed-send-backs-never-settle` | 7 | promoted |
| `speed-review-has-no-product-slow-verdict-or-seed` | 7 | promoted |
| `test-sprints-never-act-on-measured-test-time` | 7 | promoted; its decision deltas land here |
| `rewrite-tasks-cannot-change-support-or-plan` | 8 | promoted |
| `write-stage-refuses-after-two-blocked-test-tasks` | 8 | promoted |
| `write-stage-loops-on-a-test-tasks-after-list` | 8, 10 | promoted |
| `planning-hands-off-a-tree-execution-refuses` | 2 | promoted |
| `task-fields-read-text-by-how-it-looks` | 10 | promoted |
| `tests-diff-shows-unchanged-file-as-deleted` | 10 | promoted |
| `test-sort-deletes-legacy-tests-outside-the-plan-scope` | 2 | answered: built, and the fold's folder groups keep it |
| `test-runs-have-no-setup-step-and-silence-ignores-output` | 1 | answered: built |

### 12. What the sprint touches

Under `plugins/ok/families/ok-planner/`:

- `skills/ok-setup/`: the new verb.
- `skills/plan-sprint/`: the offers, the required re-plans, the test
  planners and their prompts (moved from `skills/plan-tests/core.md`),
  the code planner's story list, the notes review's check, the
  `-plan.json`, the commit at approval, and the sprint document's
  execution boilerplate and completion contract.
- `skills/converge/`: the suite as a find source, the one verifier,
  the cap by source, confirm, the final round, and the end speed batch.
- `skills/_sprint/shared.md`: the build prompt's test stages and the
  archive step's stamp.
- `skills/plan-docs/SKILL.md`: the commit at approval.
- `skills/plan-tests/`: retired.
- `scripts/tests`: the schedule check, the ranking, `--only` workers,
  standing results, `not run`, `--changed`, `late_tasks`, `reaches`,
  the median, acceptances across sprints, settling, `product-slow`,
  the `support` pool, the `after` refusal, `cmd_snapshot`, and the
  verbs the fold retires.
- `scripts/review`: `review certified`'s test checks.
- `scripts/plumbline`: the `no-tests` window keyed to the sprint.
- `scripts/tasks`: the `--field` parse.
- `docs/testing.md`, `docs/plumbline-coding.md`,
  `docs/plumbline-cheatsheet.md`, `scripts/ok-planner-cheatsheet.md`,
  `scripts/ok-cheatsheet.md`, and the family `CLAUDE.md`.
- `admin/true-up` and `admin/ADMINISTRATION.md`: `testing.enabled`,
  `testing.schedule`, and `testing.reaches` at their former behavior,
  the two issues, and the retirement of `/plan-tests`.

In the design corpus, at least these change: the decisions
`test-loop-fixes-code-never-tests`,
`tests-spend-time-only-on-their-outcome`,
`tests-isolated-unless-declared`, `test-sprints-own-the-tests`,
`scenario-list-decided-once`, `test-support-written-before-tests`,
`test-sprints-build-approved-time-controls`,
`legacy-suites-sorted-automatically`, and
`live-sprints-brought-current-on-true-up`; the story
`retire-a-legacy-suite`; and the concept `sprint`. The fold itself
needs a decision of its own.

## Open questions

- **An open test sprint at upgrade.** A project may hold a test sprint
  under `.ok-planner/test-sprints/` that is not archived when true-up
  retires the test sprint. Nothing here says whether it runs to its
  end under the retired boilerplate, converts to a sprint, or waits
  for the owner to archive it.
- **Retiring the verb and its records.** How true-up retires
  `/plan-tests`, the `tests` tool verbs the fold replaces (`tasks
  --stage`, `complete`, `stamp`), and `.ok-planner/test-sprints/`, and
  where archived test sprints stay.
- **`plan-sprint-admits-steps-that-need-a-person`.** Under the fold,
  test stages and the suite join the steps that must run with no
  person present. That issue stays open.
- **What "logical groups" are.** The sketch assumes untested and stale
  stories group the way `tests groups` groups stories today: stories
  one code file cites join one group, the rest batched in catalog
  order. A grouping by concept or by surface class may read better to
  an owner.
- **N for the unread-slow offer.** The sketch assumes N is
  `testing.slowest`, the same count the end speed batch reads.
- **The rulings' record.** The rulings live in this sketch and in the
  session that made them. None is written to an intake issue, and the
  fold has no issue of its own. `/plan-sprint` would record them as
  corpus deltas, and close or promote the issues section 11 lists.
- **Where `/ok-setup`'s offer choices are stored.** The sketch assumes
  keys under `testing` in `.ok-planner/config.json`; their names are
  not chosen.
- **`frozen` and new stories.** Under `frozen`, a story the sprint's
  deltas add gets no test. The sketch assumes it joins the untested
  list for a later sprint under `on`.

- **The runner check for kinds and setups.** `/plan-tests` step 9
  checks that the suite command, `testing.setup`, and
  `testing.silence` run every planned kind and setup pair of test. The
  schedule check of section 5 replaces it for the schedule alone. The
  sketch assumes the rest of step 9 runs in `/plan-sprint`, for the
  pairs the sprint's planned tests add, and in `/ok-setup` when testing
  is turned on.

## Risks / unknowns

- **Certification grows.** The suite, its fix loop with no cap, and
  the final whole-suite round all join certification. The design
  bounds this: reading sources run once, and only test failures reopen
  the loop. A suite with many flaky failures could still keep
  certification running long.
- **`reads` is only as good as the planners.** The schedule check
  compares a round with what tests declare, not with what they do. A
  missing `reads` entry yields flaky failures no check catches.
- **Coverage for stack tests is coarse.** A stack test that can name
  only service folders reruns on any change to that service, so a
  stack-heavy suite saves less than a unit-heavy one.
- **`/plan-sprint` grows.** It takes on the test planners, the
  offers, and the required re-plans. Its prompt and its planning run
  get longer for every sprint in a project with testing on.
- **Upgrade cost.** Every project on v30 with an open or recent test
  sprint meets the retirement at once. The release that ships this is
  a major release.
- **The corpus edit is wide.** At least nine decisions, one story, and
  the sprint concept change, and the fold needs a decision of its own.

## Evidence for the code planner

Facts read in the session, as of v30.2.0, so a planner need not find
them again. Paths are under `plugins/ok/families/ok-planner/` unless
marked.

- **Stale decisions.** The 2026-11-01 ruling on
  `test-sprints-never-act-on-measured-test-time` ordered two decisions
  amended, and the build that adopted the speed stage left them as
  they were. `decision:test-loop-fixes-code-never-tests` still says
  each round "lists its slowest tests; the list decides nothing".
  `decision:tests-spend-time-only-on-their-outcome` still has only the
  next plan read the list.
- **Built rulings still open in the intake.**
  `test-sprints-never-act-on-measured-test-time`,
  `test-sort-deletes-legacy-tests-outside-the-plan-scope`, and
  `test-runs-have-no-setup-step-and-silence-ignores-output` stand as
  `ruled`, and the source builds each.
- **The slow touch's three gaps.** `scripts/tests::window_touches`
  returns no touch where the window's status is `current`.
  `scripts/tests::slowest_recorded` ranks every recorded test, inside
  the plan's scope or not, while the assembly refuses a rewrite
  outside the scope. No record keeps a planner's finding that a slow
  test has no waste.
- **Ranking.** `scripts/tests::wall_cost` charges a test that declares
  resources its whole seconds and an isolated test its seconds over
  the workers.
- **`--only`.** `scripts/tests::tested_round` sets `workers = 1 if
  args.only or args.from_file`.
- **Streams.** `scripts/tests::run_suite` makes each run's results
  stream as a FIFO under `tempfile.mkdtemp`.
- **Blocked test tasks.** `scripts/tests::write_refusals` refuses once
  a scenario's last two test tasks closed `blocked`.
- **`tests diff`.** `scripts/tests::cmd_diff` sets `gone =
  snap["after"].get(rel) is None` for a closed snapshot.
- **The role check today.** `scripts/tests::complete_failures`
  refuses where a fix or control task staged a test path.
- **The lint window.** `scripts/plumbline` keys the `no-tests` window
  to `.ok-planner/test-sprints/`, `-base.txt`, and `-complete.txt`.
- **Certification's verifier** (`skills/converge/prompts/verify.md`)
  checks no new accept-list harm, every caller of a changed contract
  brought along, no change across a release boundary without a
  ruling, and the project's checks on the changed files. The test
  sprint's fix verifier (`{{TEST-VERIFY-PROMPT}}` in
  `skills/plan-tests/core.md`) checks no test detection, no hidden
  failure, no faked effect, no test path, the coding rules and the
  accept list, and that the test passes.
- **The cap.** `fix.max_kickbacks` is 2 in `review/seed/config.json`
  and in this repo's `.ok-planner/review/config.json`.
- **Accept-list entry A8** (`review/catalog/accept.md`) counts as a
  defect any site that breaks "a rule in
  `.claude/rules/plumbline-coding.md`".
- **Linescout's local changes** to `bin/tests` and `docs/testing.md`
  (standing results, `--changed`, `late_tasks`, settled send-backs,
  `product-slow`, held tests first in the walk, and the seed text)
  stand in `/Users/patrick/Documents/projects/research/linescout` at
  commit `5be01c34`: `git diff 31374e58 5be01c34 --
  platform/.ok-planner/bin/tests platform/.ok-planner/docs/testing.md`.
- **The owner's comment** on `tests-schedules-resource-groups-itself`
  (2026-11-06) records the recommend-with-departure ruling in the
  intake.

## What this is not

- No staging, commit plan, or build order. A sprint does that.
- No wording for the corpus deltas or the prompts.
- No rule on the plain defects beyond the fix each needs.
- No change to `/plan-docs` beyond the commit at approval.
