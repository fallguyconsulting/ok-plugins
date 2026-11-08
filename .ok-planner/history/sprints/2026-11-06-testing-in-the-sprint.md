---
approved: 2026-11-06
closed: a124cfaa244f696dd60255c4cd21d43632fd855f
---
# Sprint: Testing inside the sprint

## Intent

Retire `/plan-tests` and the test sprint, and make testing part of
every sprint. A new verb, `/ok-setup`, turns testing on, freezes it, or
turns it off. `/plan-sprint` plans the tests a sprint's work needs and
offers untested and stale work in groups the owner takes one at a
time. Execution writes the planned tests in build stages after the code
stages, and reads each new or rewritten test for speed as it is written.
Sprint certification runs the suite as a source of defects, fixes the
code for each failing test, reruns only the tests each fix reaches, and
ends on a passing whole-suite round. The suite gets a little faster with
each sprint. The sprint also adopts the fixes one project's test sprint
made by hand to the tools and prompts, and makes the task tracker's
drain cheaper and fairer.

Beside the testing work, the sprint carries two documentation-sprint
fixes, two `/converge` fixes, a change to how planning reconciles work
done outside a sprint, an archive step that splits large run logs, a
list of suggested prohibitions at approval, and a rule that no step of
a sprint waits on a person.

Promoted issues:

- `test-sprints-never-act-on-measured-test-time` (its 2026-11-01
  ruling on the speed walk is superseded by this sprint's speed design,
  owner ruling 2026-11-06)
- `test-sort-deletes-legacy-tests-outside-the-plan-scope`
- `test-runs-have-no-setup-step-and-silence-ignores-output`
- `planning-hands-off-a-tree-execution-refuses`
- `doc-edit-rules-ignore-docspec-notes`
- `whole-file-ownership-records-omit-doc-and-test-sprints`
- `second-recorded-test-run-refuses-or-waits`
- `doc-style-pass-may-undo-docspec-notes`
- `owner-list-leaves-rejected-backlog-issues-open`
- `test-sprint-speed-reading-waits-for-the-end`
- `test-sprint-reruns-tests-a-change-cannot-reach`
- `speed-acceptance-follows-shared-support-digests`
- `speed-walk-ranks-by-one-rounds-time`
- `write-stage-refuses-after-two-blocked-test-tasks`
- `task-fields-read-text-by-how-it-looks`
- `speed-send-backs-never-settle`
- `tests-run-failing-skips-standing-failures`
- `late-tasks-count-test-only-tasks`
- `speed-review-has-no-product-slow-verdict-or-seed`
- `stopped-round-files-fixers-for-unreached-tests`
- `write-stage-loops-on-a-test-tasks-after-list`
- `tests-run-only-runs-serially`
- `rewrite-tasks-cannot-change-support-or-plan`
- `tests-diff-shows-unchanged-file-as-deleted`
- `slowest-ranking-assumes-held-tests-run-alone`
- `tests-schedules-resource-groups-itself`
- `tests-results-stream-shared-between-runs`
- `archive-splits-large-jsonl-files`
- `decisions-and-discovery-write-unrequested-prohibitions`
- `plan-sprint-admits-steps-that-need-a-person`

## Corpus deltas

Every body is in the sidecar folder
`2026-11-06-testing-in-the-sprint-deltas/`.

### New story: grow-test-coverage-a-part-at-a-time

body: in the sidecar

### New story: suite-gets-faster-over-time

body: in the sidecar

### New decision: testing-runs-inside-the-sprint

body: in the sidecar

### New decision: testing-set-up-by-its-own-verb

body: in the sidecar

### New decision: out-of-band-work-reconciled-as-a-batch

body: in the sidecar

### New decision: fixes-rerun-the-tests-they-reach

body: in the sidecar

### New decision: test-tasks-own-the-tests

body: in the sidecar

### Retire decision: test-sprints-own-the-tests

### New decision: planned-tests-name-their-waits

body: in the sidecar

### Retire decision: test-sprints-build-approved-time-controls

### Amend decision: test-loop-fixes-code-never-tests

body: in the sidecar

### Amend decision: tests-spend-time-only-on-their-outcome

body: in the sidecar

### Amend decision: tests-isolated-unless-declared

body: in the sidecar

### Amend decision: scenario-list-decided-once

body: in the sidecar

### Amend decision: test-support-written-before-tests

body: in the sidecar

### Amend decision: legacy-suites-sorted-automatically

body: in the sidecar

### Amend decision: tests-check-scenarios

body: in the sidecar

### Amend decision: live-sprints-brought-current-on-true-up

body: in the sidecar

### Amend decision: records-stay-out-of-context

body: in the sidecar

### Amend decision: whole-file-ownership

body: in the sidecar

### Amend decision: every-timer-has-a-time-control

body: in the sidecar

### Amend decision: gated-elements-stay-internal

body: in the sidecar

### Amend decision: settings-have-no-code-defaults

body: in the sidecar

### Amend decision: documentation-edits-only-where-a-rule-fires

body: in the sidecar

### Amend decision: documentation-style-read-once

body: in the sidecar

### Amend decision: out-of-band-documentation-reconciled

body: in the sidecar

### Amend decision: drain-runs-as-a-workflow-script

body: in the sidecar

### Amend decision: team-execution-cold-gate

body: in the sidecar

### Amend decision: converge-finds-then-fixes

body: in the sidecar

### Amend decision: drive-tries-each-story-as-a-user

body: in the sidecar

### Amend decision: work-items-change-the-product

body: in the sidecar

### Amend decision: sprint-goal-read-from-the-repository

body: in the sidecar

### Amend decision: intake-writers-are-gated

body: in the sidecar

### Amend concept: sprint

body: in the sidecar

## Work items

All paths are under `plugins/ok/families/ok-planner/` unless marked.
"The suite" is that family's source. Every file the family vendors
into a project is changed at its source; the project's own vendored
copy follows at the next true-up.

### 1. Testing folds into the sprint

Realizes `testing-runs-inside-the-sprint`, `test-tasks-own-the-tests`,
`planned-tests-name-their-waits`, `story:catch-broken-promises`.

`/plan-tests` and the test sprint are retired. Testing is part of
every sprint, under `testing.enabled`:

- `on`: every sprint plans, writes, and maintains tests, and
  `/plan-sprint` makes the offers work item 3 describes.
- `frozen`: certification runs the existing suite as a find source, and
  its fixers fix what the suite finds. `/plan-sprint` makes no offer and
  plans only the `rewrite` and `retire` each changed story needs. A
  story the sprint's deltas add gets no tests and joins the untested
  list for a later sprint under `on`.
- `off`: certification skips the suite. The tests stay in the tree,
  unmaintained.
- True-up writes `testing.enabled` into every project (work item 17),
  and a tool that finds it missing refuses and names the key.

The outcome: the vendored skill `skills/plan-tests/` is gone; its
planners, prompts, and test-sprint document move into `/plan-sprint`,
the sprint build prompt, and `/converge`, as work items 3, 6, and 7
say. The `bin/tests` verbs only the test sprint used are retired: `tasks
--stage fix`, the write stage's control tasks, `complete`, `report`, and
`window`. The verbs the test stages, certification, and planning use
stay, `tasks --stage write|verify|sweep|speed` and `stamp` among them. Every rule, cheatsheet, `CLAUDE.md`, and prompt
the family carries that names `/plan-tests`, the test sprint,
`test-sprints/`, or `TESTS COMPLETE` describes the fold instead:
`docs/plumbline-cheatsheet.md`, `docs/plumbline-coding.md`,
`scripts/ok-planner-cheatsheet.md`, `scripts/ok-cheatsheet.md`,
`scripts/ok-planner-CLAUDE.md`, the family `CLAUDE.md`, and every skill
that mentions them. The rule "Only a test sprint adds, edits, or deletes
a test" becomes "Only a sprint's test tasks add, edit, or delete a test",
and agents run tests only inside a sprint's test stages and
certification, or when a person asks in their own words.

`/plan-tests`: rewrite across the public surface: testing folds into
every sprint, so no separate planning verb remains (owner ruling,
2026-11-06). The release that ships this sprint is v31.

Every `@decision:` citation in the suite's code that names
`test-sprints-own-the-tests` or `test-sprints-build-approved-time-controls`
names its replacement instead.

### 2. `/ok-setup` sets up testing

Realizes `testing-set-up-by-its-own-verb`,
`story:grow-test-coverage-a-part-at-a-time`.

A new family verb, `/ok-setup`, the owner runs. It is not part of `/ok`,
which does suite administration alone. Run once, it turns testing on;
run again, it changes any setting below, freezes testing, or turns it
off.

- **Turning testing on.** It asks for the runner keys `/plan-tests`
  asks for today (`run`, `silence`, `named`, `leftovers`, `slowest`,
  `runners`, `setup`, `setup_silence`). It asks which schedule the
  suite command runs and what per-test coverage it writes, and records
  each answer in `testing.schedule` and `testing.reaches` (work items 8
  and 9). It plans the test stack's budget with the budget planner. It
  records which standing offers `/plan-sprint` makes in
  `testing.offers`, a list drawn from `untested`, `stale`, `legacy`, and
  `runtime`. It checks that the suite command, `testing.setup`, and
  `testing.silence` run every kind and setup pair of test the project's
  recorded tests hold.
- **`testing.enabled`** is a required key, `on`, `frozen`, or `off`.
- Every answer is written through `bin/tests declare` or the tool that
  writes `.ok-planner/config.json` today, never by hand.

### 3. `/plan-sprint` plans the tests

Realizes `testing-runs-inside-the-sprint`, `scenario-list-decided-once`,
`legacy-suites-sorted-automatically`,
`story:grow-test-coverage-a-part-at-a-time`,
`story:retire-a-legacy-suite`.

Under `on` or `frozen`, `/plan-sprint` plans every test the sprint's
work needs, and the owner approves the tests with the sprint, once.

- **Required re-plans.** Planning re-plans every tested story whose
  behavior the sprint changes, whether or not the story's text changes:
  stories are high level, and a sprint often adds a new way to get a
  story's benefit. The code planner lists each tested story whose
  implementation the work items change, from the `@story:` citations in
  the files they touch and from each recorded test whose `reaches`
  names one of those files. The notes review checks that list against
  the sprint and the code. Each re-planned scenario becomes `new`,
  `rewrite`, `retire`, or `keep`. A story the sprint's deltas add gets
  proposed scenarios; the owner may decline them, and the story joins
  the untested list.
- **Offers (under `on`, for each kind `testing.offers` lists).** At
  Frame, `/plan-sprint` offers each in groups, and the owner takes any
  group whole:
  - stale stories: each story keeps a test stamp, the git blob id of its
    file as a plan last planned its scenarios, and a story whose file's
    blob id differs from its stamp, or that has recorded scenarios and no
    stamp, stays offered until a sprint stamps it;
  - untested stories: a story with no recorded scenario and no recorded
    no-guard answer;
  - legacy folders: test files no scenario claims, grouped by folder; a
    sprint sorts only the folders the owner takes, as adopt, port,
    support, or delete, and every other file stays as it stands,
    recorded as kept, in every sprint whatever the offers;
  - runtime scenarios: failures of parts the product holds or depends
    on, as one group.

  Untested and stale stories group the way `tests groups` groups
  stories today: stories one code file cites join one group, and the
  rest are batched in catalog order.
- **The planners.** The story, runtime, sort, programs, and budget
  planners, the planner review, and the plan-wide review `/plan-tests`
  runs today run inside `/plan-sprint`, over only the stories and
  folders the sprint takes or must re-plan. The programs planner's
  questions join Resolve. The budget planner runs only where the
  sprint's tests or stack changes change the budget. A test that waits
  on a time control the product lacks makes that time control an
  ordinary work item, built by a code stage.
- **The runner check.** `/plan-sprint` checks that the suite command,
  `testing.setup`, and `testing.silence` run each kind and setup pair
  of test the sprint's planned tests add.
- **The plan.** `/plan-sprint` writes the sprint's `-plan.json`, which
  names each test path and its action. Where the plan is too long to
  read in the session, the session writes the plan's text to a file
  beside the sprint and names the file for the owner to open.

### 4. Planning leaves the tree ready to run

Realizes `planning-hands-off-a-tree-execution-refuses` (owner ruling:
"the planning phase (sprint, test, or docs) should leave the repo in a
state where whatever was just planned is ready to execute with no
interruptions"), `drain-runs-as-a-workflow-script`.

In `/plan-sprint` and `/plan-docs`, after the owner approves, the
session runs `git status --porcelain`. Where it lists a path outside
`.ok-planner/`, the session names those paths, grouped by the work
each belongs to, and in the same message asks once to commit them,
proposing commits staged by name. On the owner's yes it makes the
commits. It hands over the goal line only once no path outside
`.ok-planner/` stands uncommitted. Where the owner declines, the
session names what execution's base step will refuse and hands over no
goal line. Execution keeps its own check as a guard.

The goal line both sessions hand over carries the owner's opt-in to
the Workflow tool in words the owner types:
`/goal .ok-planner/sprints/<name>.md — run each drain as a workflow`
(and the documentation sprint's path for `/plan-docs`).

### 5. Reconcile shows out-of-band changes as one batch

Realizes `out-of-band-work-reconciled-as-a-batch`,
`out-of-band-documentation-reconciled`, `story:plan-a-sprint`.

`/plan-sprint`'s Reconcile step no longer walks each bearing change
with the owner. It drafts every bearing change as "corpus catches up",
and every direct documentation edit as "the edit stands", and shows the
owner one summary of the batch at Reconcile, apart from the sprint's
own work: one line per change with the deltas it drafts. The owner may
pull any change out of the batch and give it "code catches up" or
"record and defer", which then take effect as they do today. A change
that breaks a public contract is still walked with the owner one at a
time, with its three outcomes.

### 6. Execution writes the tests in build stages

Realizes `testing-runs-inside-the-sprint`, `test-tasks-own-the-tests`,
`test-support-written-before-tests`, `tests-spend-time-only-on-their-outcome`,
`story:suite-gets-faster-over-time`.

The sprint build prompt (`skills/_sprint/shared.md`) and the sprint
document's execution boilerplate stage test work after code work:

- Code stages come first, time controls among them.
- Test stages follow the code stages they test: the preflight where the
  budget changed, support tasks, test tasks, legacy tasks, the sweep,
  and verify tasks. They change no product code. Test work that touches
  no code stage's files, such as an untested group, may run beside the
  code stages. Each test task's `files` holds only its planned paths.
- **Speed at write time.** The test verifier reads each new or rewritten
  test for the testing standard's wastes. Its brief gives the test's
  seconds from the test task's own run, the budget's workers, and the
  resources the test changes and reads. The speed reviewer's judging
  text is one block both the verify prompt and the speed prompt
  include.
- **The carried-over slow tests.** Under `on`, a speed task in the
  build stages reads the `testing.slowest` slowest tests from the last
  full run that have no speed acceptance at their current test file.
  `test-state.json` carries that ranking and the acceptances from
  sprint to sprint. Its rewrites land before certification starts.
- **A test at fault found while writing** goes back to its test task as
  today.
- **One support task for many tests.** Where several send-backs share
  one cause in a support file, one support task may fix the cause for
  all of them.

### 7. Certification runs the suite

Realizes `testing-runs-inside-the-sprint`, `test-loop-fixes-code-never-tests`,
`fixes-rerun-the-tests-they-reach`, `story:certify-completion`,
`story:catch-broken-promises`, `story:suite-gets-faster-over-time`.

`/converge sprint` keeps its two loops and gains the suite as a fifth
find source, beside the review passes, the build's noticed defects, the
project's checks, and the drive. Under `off`, it skips the suite
and says so in its return.

- **Find.** The first whole-suite round runs once the build's stages
  close. Each failing test and each grown leftover count files a
  report, and the merge folds every report into one defect list.
- **Rerun before a fixer.** Each failing test runs alone before a fixer
  is filed for it. A failure files the fixer. A pass after a fix whose
  changed files the test's `reaches` names counts as fixed. A pass with
  no change reaching the test since its failing round goes to the
  flaky-test route.
- **A flaky test.** A test that fails in a round and passes alone is
  broken until its cause is found. Its fixer reads the round's window
  and the tests that failed with it in the round's results, reads the
  test stack's logs for that window, reproduces the failure with
  `tests run --only` at the round's worker count, and routes the
  cause: the product failing under load (a product fix), tests sharing
  state or timing (a missing `resources` or `reads` entry, or a test at
  fault), or a test leaving something behind, which `testing.leftovers`
  should count. A fixer never records a flaky test as passing as the
  tree stands.
- **A test at fault.** The fix prompt starts from the test being right
  and follows the evidence. A fixer who finds the test, its support,
  its fixture, or its data at fault changes nothing and records the
  fault, naming every other test that shares it. The verifier runs the
  test and reads the product path; where the product is right, it
  accepts the record and certification files a test task to rewrite
  each named test. A promise the verifier rejects because the test is
  at fault takes the same route, so no fixer is filed again. A promise
  is recorded only where the commitment itself stands in the way.
- **One verifier.** Every fix, whatever its source, passes one
  verifier. It runs certification's checks (no new accept-list harm,
  every caller of a changed contract brought along, no behavior across
  a release boundary changed without a ruling, the project's checks on
  the changed files) and the test checks (no test detection, no hidden
  failure, no faked effect, no test path touched by a fixer). It reruns
  the tests the fix reaches, as `fixes-rerun-the-tests-they-reach`
  says, and sends back a fix that fails a test that passed before it.
- **No fix edits a test.** A fix may change code to meet what its story
  promises, to make it testable, or to make tests faster. No fix alters
  what the design corpus commits to.
- **The cap.** A defect whose source is the suite has no cap on
  send-backs and never goes stuck. Its one way out is the promise path:
  a verifier agrees that only a change to what the corpus commits to
  meets the test, and the run's owner list files an issue. Every other
  defect keeps
  `fix.max_kickbacks` and its backout.
- **Confirm.** A confirm driver drives each fixed drive defect's story
  again, and the fixed test runs again for each suite defect.
- **The final whole-suite round.** Once no defect stands open,
  certification runs the whole suite once. Each failing test files a
  report, and the fix loop resumes. This repeats until a whole-suite
  round passes after the last change, or each failing test carries a
  verifier's recorded agreement on the promise path. The review passes, the checks, and the drive do not
  run again, so only test failures reopen the loop. A sprint whose first
  whole-suite round passes runs the suite once.
- **Speed after a failed round.** When a whole-suite round fails, and
  before the next one runs, a speed task reads the `testing.slowest`
  slowest tests of the failed round that have no speed acceptance at
  their current test file. Their rewrites run in the round that must
  run anyway. A speed rewrite that fails returns to its last passing
  version, its send-back stays open, and the next sprint takes it up,
  so speed work never costs a sprint an extra whole-suite round. The
  speed batch at the end of a passing round, the walk "until a whole
  batch comes back accepted", is gone.
- **`review certified`**, where `testing.enabled` is `on` or `frozen`,
  requires a whole-suite round after the last
  change in which every failing test has a held promise issue, the
  test-path checks of work item 14, and every speed send-back either settled or
  returned to its last passing version.

The sprint's archive step stamps each story the sprint planned whose
every planned scenario has its test written, kept, or retired, clears
the stamp of each other story it planned, and writes the scenario list, the speed acceptances, the ranking, and the `reaches`
lists into `test-state.json`.

### 8. The schedule

Realizes `tests-isolated-unless-declared`.

- **The rule.** The testing standard and the suite command's contract
  recommend one rule: two tests may run at the same time unless one
  changes a resource the other changes or reads. Tests that share a
  changed resource form one group, which runs its tests one after
  another on one worker. The run uses at most the budget's workers.
- **`reads`.** The resources rule adds `reads` beside `resources`: each
  shared resource a test reads and does not change. The planners write
  it, and the planning reviewer checks it. A scenario with no `reads`
  counts as reading every resource.
- **`testing.schedule`**, a required key, records the schedule the suite
  command runs: `{"form": "<schedule>", "said": "<the owner's words>"}`.
  The forms `bin/tests` knows are `recommended`, `groups-side-by-side`
  (held groups run at the same time as each other, after the isolated
  tests), and `groups-one-at-a-time` (held groups run one after
  another, after the isolated tests). A departure names what the
  project does instead: a departure is a competing practice, never an
  exemption. The key has no default in code.
- **The schedule check.** `bin/tests` notes the arrival time of each
  result line; a line's start is its arrival less its seconds. After
  each round, it checks every pair of tests that ran at the same time
  against the schedule the key names. A forbidden pair fails the round
  with `schedule--<test>--<test>`, which a support task of the test
  stages takes up. While `said` is null, `bin/tests` ranks by the form and
  skips the check, because a guessed form must fail no round.
- **The ranking.** `bin/tests` ranks by the schedule the key names.
  Under `recommended`, a round's lower bound on wall time is the larger
  of the longest group's total seconds and all tests' total seconds
  over the workers. Under `groups-one-at-a-time`, it is the isolated
  tests' seconds over the workers plus every group's seconds. A test's
  cost is how much the bound drops when its seconds drop to zero. No
  rule puts held tests first; the ranking charges each for what it
  costs.
- **`tests run --only`** runs at the budget's workers, not at one
  (`scripts/tests::tested_round` sets `workers = 1 if args.only or
  args.from_file` today).
- **Recorded runs.** Every `tests run` that names a sprint is recorded
  in the sprint's results file, `--only` runs included, each as a round
  of kind `rerun` unless it runs the whole suite. Each run already
  writes its results stream to a path of its own. A run prints each
  result line live as today, so the silence clock is unchanged, and
  appends its whole round to the results file once, at its end, under a
  short lock, so runs side by side never mix lines.
- **A second whole-suite round** of one sprint refuses at once while
  another is under way, naming that run and its results file and
  telling the user to wait for it to end and run again.
- **Runs side by side.** Before the suite command starts, a run locks
  each shared resource its tests declare: an exclusive lock for a
  resource a test changes, a shared lock for one a test only reads, held
  until the run ends. A test with no `reads` counts as reading every
  resource. A whole-suite round locks every resource its tests declare.
  A run of isolated tests takes no lock. A run that needs a lock another
  run holds waits for it, printing one line naming the run and the
  resource it waits on.

### 9. Reruns and coverage

Realizes `fixes-rerun-the-tests-they-reach`, `scenario-list-decided-once`.

- **Standing results.** Each live test has a standing result: its
  latest result since the latest closed whole-suite round, with the
  digests of its test file and support files when it ran. `--failing`
  reruns every standing failure, not only the latest round's.
- **`not run`.** A stopped round records each test it never reached as
  `not run`, not as failed, and no fixer is filed for it.
- **`--changed`** reruns each test whose test file or support files
  changed since it last ran. `tests run` refuses more than one of
  `--only`, `--from`, `--failing`, and `--changed`, and refuses
  `--changed` without `--sprint`.
- **`late_tasks`** counts a closed task only where it staged a file
  outside the test paths.
- **`reaches`.** Each result line may carry `reaches`: the product files
  the test ran, from a per-test coverage record, or, for a stack test,
  the folders of the services it reached. A folder covers every file
  under it. `bin/tests` keeps each test's latest list, and every run of
  a test replaces it. The first whole-suite run produces the map, and
  `test-state.json` keeps it across sprints.
- **After a fix,** the verifier reruns the tests whose `reaches` names a
  file the fix changed or a folder above one. A test with no `reaches`
  reruns after every fix. A changed file no test's `reaches` names, such
  as a configuration file, a template, a migration, or a lockfile,
  reruns every test. These rules hold where `testing.reaches` names
  `files` or `folders`. Under `none`, the verifier reruns only the tests
  the fix was for, and the final whole-suite round catches the rest.
- **`testing.reaches`**, a required key, records what the suite command
  writes: `{"form": "files" | "folders" | "none", "said": "<the owner's
  words>"}`.
- **Kept files.** The check that no unclaimed test file stands skips
  every test file a plan recorded as kept (`scripts/tests::stray_paths`
  counts them today).

### 10. Speed records

Realizes `tests-spend-time-only-on-their-outcome`,
`story:suite-gets-faster-over-time`.

- **The ranking** uses each test's median seconds across the whole-suite
  rounds that ran it at its current test file's digest, so machine load
  in one round moves it little.
- **Acceptances** hold until the test's own file changes, across
  sprints, in `test-state.json`. A support change does not clear one.
  An accepted test counts as unreviewed again only where a support
  file it lists changed since its acceptance and its median seconds
  rose.
- **A send-back settles** when the verifier accepts the rewrite.
- **`product-slow`.** The speed reviewer may record a test as slow
  because the product is slow, naming the site as `path::function`,
  what it does, how its cost grows, and the cheaper behavior; where the
  test also wastes time of its own, it records the larger verdict. The
  fix loop files a fixer for the site, keyed `perf:`, and its verifier,
  as for a failing test. The fixer runs the test and notes its seconds,
  changes the product so the site does only the work its answer uses,
  and runs every test that reaches the site. The verifier sends back a
  fix that leaves the slow work, drops a promised outcome, or fails a
  test that reaches the site. A product-slow verdict is never an
  acceptance: it settles once its fix is accepted, and the test gets a
  fresh speed read.
- **The seed** is recommended, not required: read-only test data that
  slow tests read, declared as a list of entries. A project may have
  none. Each entry's digest covers its own definition and the
  stored-data layout files the seed names, and a product code change
  never makes an entry stale. The setup step builds each entry that is
  missing or stale and reuses the rest. A test task that needs seeded
  data records a `support` item naming the entry; the write stage files
  a support task, which adds the entry and lists it as support on each
  test that reads it. A speed reviewer may name a seed entry as the
  cheaper form, with the objects it must hold. Each seeded object
  carries a name only the seed uses, and the test support refuses to
  change or remove one. A test that changes its data builds its own
  copy.
- **No time line.** The testing standard names no speed floor. The
  ranking chooses which tests a reader reads, and the reader judges the
  waste.

### 11. Test tasks and support

Realizes `test-support-written-before-tests`, `test-tasks-own-the-tests`.

- **The `support` pool** replaces the `helpers` pool. An item names a
  support file and the change a test needs: a missing helper, a changed
  helper, a fixture, or a seed entry. The write stage files a support
  task for each open item, then refiles the blocked test task after it.
  Two blocked closes refuse only where neither named a support item.
- **A rewrite** a verifier or a speed reviewer sent back includes its
  scenario's support files in its task's `files`, and may change them.
  `--changed` then reruns every test that lists a changed support file.
- **Declarations.** A rewrite may add or drop entries in `resources`
  and `reads`. The verifier reads each change against the waste "a
  shared resource declared where a cheaper design keeps the test
  isolated", and each addition is a call the owner sees at the veto.
- **Plan text.** A rewrite may change its scenario's plan text, save
  the outcome.
- **Outcomes.** A rewrite never changes the scenario's outcome. A change
  to the outcome stays a promise, which its verifier holds or rejects.
- **`after` lists.** The write stage refiles no task whose `after` list
  names a task that closed other than `done`, and names that task in a
  refusal.
- **`tests diff`.** `snapshot --after` records every path the `before`
  snapshot holds, so `scripts/tests::cmd_diff` no longer shows an
  unchanged file as deleted.

### 12. The task tracker

Realizes `team-execution-cold-gate`, `drain-runs-as-a-workflow-script`.

In `scripts/tasks`:

- **`--field`.** `tasks item add --field` and `tasks item set --field`
  keep a value as text unless it opens with `[`, `{`, or a quote, or
  the pool declares the field's type, so `--field after=t4647` and a
  hex digest such as `104957870728e435` stay text. A list field such as
  `after` accepts a bare task id as a list of one.
- **The claim order.** `tasks claim` with no task id takes the issued
  task of the profile with the most tasks waiting on it, counting
  through `after` lists, and breaks ties by age. A run with no waiting
  chains claims oldest first, as today. Every agent of one profile
  still starts from one identical message.
- **`tasks close`** issues the tasks the close makes ready and prints
  the lines `tasks next` would print, after its `closed` line.
- **`tasks refile`** refuses a refile that would make a task wait on
  itself through a chain, as `tasks task set` does
  (`scripts/tasks::check_dependencies`).

### 13. The drain reads the next work from each close

Realizes `drain-runs-as-a-workflow-script`.

The task agent's last act is `tasks close`, and its final text is that
command's whole output. The drain script (`skills/_tasks/drain.md`)
reads the `closed` line and the `run`, `exec`, `waiting`, and `done`
lines from the task agent's return, and starts that many agents of each
profile. A step agent runs `tasks next` only for the first fill of each
drain and after a return that carries no `closed` line. The hand form
of the loop reads the same lines.

### 14. Test paths during a sprint

Realizes `test-tasks-own-the-tests`.

- **The lint window.** Where `testing.enabled` is `on` or `frozen`,
  `scripts/plumbline`'s `no-tests` check allows an edit at a test path
  from a sprint's `-base.txt` until `review certified` passes for that
  sprint. A sprint abandoned before then keeps it allowed until the
  owner archives or deletes it.
- **`review certified`** refuses where a code task (a build stage that is
  no test stage, or a certification fixer) staged a test path, and where
  a test file stands that no planned test claims and no plan kept.

### 15. Testability coding rules

Realizes `story:catch-broken-promises`.

`docs/plumbline-coding.md` gains four rules, each with the step to
perform and the evidence to leave, in the file's form. Accept-list entry
A8 covers "a rule in `.claude/rules/plumbline-coding.md`", so
certification counts each missing feature as a defect.

1. Every outcome a story promises is observable through a public entry
   point, an event the product emits, or a state the product leaves.
2. Each service's logic is callable through that service's own entry
   point without the full stack.
3. Every record or resource the product creates on request is
   removable through its public surface.
4. Every long-running command or tool under the project's control
   prints progress as it works.

`docs/plumbline-cheatsheet.md` carries one line for each.

### 16. The testing standard

Realizes `tests-spend-time-only-on-their-outcome`,
`tests-isolated-unless-declared`, `fixes-rerun-the-tests-they-reach`.

`docs/testing.md` states the schedule rule and `reads` (work item 8),
`reaches` (work item 9), the seed and its staleness rule, a slow product
and the product-slow verdict (work item 10), a flaky test and a test at
fault (work item 7), and when speed is read (work items 6 and 7). It
names no time line. The waste "setup a test repeats" adds "or data the
test only reads that the project's seed could hold".
`docs/plumbline-cheatsheet.md`'s ambient copy follows.

### 17. True-up

Realizes `testing-runs-inside-the-sprint`, `whole-file-ownership`,
`live-sprints-brought-current-on-true-up`, `settings-have-no-code-defaults`,
`story:true-up-project-estate`.

`admin/true-up` and `admin/ADMINISTRATION.md`:

- Write `testing.enabled` at its former behavior: `on` in a project
  whose `test-state.json` an earlier test sprint wrote, `off` in any
  other.
- Write `testing.schedule` as `{"form": "groups-one-at-a-time", "said":
  null}` and `testing.reaches` as `{"form": "none", "said": null}`
  where absent, and `testing.offers` as every kind where absent in a
  project with testing on.
- While a `said` is null and no open issue carries it, file one intake
  issue, kind `audit`, per key. The schedule issue asks which schedule
  the suite command runs and proposes `recommended`. The coverage
  issue asks the owner to add per-test coverage, naming the suite
  command, the `reaches` forms, and the coverage tool the project's
  runner offers. Each names `/ok-setup` as where the answer is
  recorded. True-up never edits the suite command, which is the
  project's file.
- Retire `/plan-tests`: delete its vendored skill and the retired
  `bin/tests` verbs' callers in the vendored layer, keep
  `.ok-planner/history/test-sprints/` as an archive, and convert
  `test-state.json` to the form work items 7, 9, and 10 read (story
  stamps, acceptances, the ranking, `reaches`, and kept files). Where the
  repository holds the old stamp commit, the conversion stamps each story
  that has recorded scenarios with its file's blob id at that commit;
  where the commit is missing, it writes no stamp.
- A test sprint still open under `.ok-planner/test-sprints/` moves to
  `.ok-planner/history/test-sprints/` as it stands, and true-up files
  one intake issue naming it. The conversion clears the test stamp of
  each story the open test sprint planned, so each returns as untested
  or stale, and planning offers it where `testing.enabled` is `on`
  and `testing.offers` lists that kind.
- Vendor `/ok-setup`.

### 18. Documentation sprints honor a docspec's Notes

Realizes `documentation-edits-only-where-a-rule-fires`,
`documentation-style-read-once`, `story:declare-project-documentation`.

- A documentation writer edits a file that departs from its docspec's
  Notes and rewrites the passage that departs, under a new rule in the
  fixed set that `{{DOC-EDIT-RULES}}` in `skills/plan-docs/core.md`
  carries.
- The style pass (`{{DOC-STYLE-PROMPT}}`) keeps what the docspec's
  Notes orders, so it never rewords a passage Notes says to keep
  verbatim or reorders an outline Notes gives (defect issue
  `doc-style-pass-may-undo-docspec-notes`).

### 19. `/converge` closes the defect issues it rejects

Realizes `story:find-and-fix-defects`.

In `skills/converge/prompts/owner-list.md`, "Close the issues the run
resolved": a backlog report the merge rejects as not real, or as left
standing by the accept list, closes its issue as answered with the
merge's reason, so the issue no longer returns on every run (defect
issue `owner-list-leaves-rejected-backlog-issues-open`).

### 20. The archive step splits large run logs

Realizes `story:certify-completion`.

Before the archive commit, `{{CEREMONY-ARCHIVE}}` in
`skills/_sprint/shared.md` splits each JSON Lines file it archives that
is larger than `archive.part_bytes` in `.ok-planner/config.json` into
numbered parts, `<name>.part<n>.jsonl`, each holding whole lines and at
most that many bytes, and archives the parts in place of the file.
Every tool that reads an archived log (`bin/tasks`, `bin/tests`,
`bin/review`, `bin/docs`) reads its parts in order where the whole file
is absent. `archive.part_bytes` has no default in code; true-up writes
`26214400` (25 MB) where it is absent.

### 21. Suggested prohibitions are explained before approval

Realizes `story:plan-a-sprint`, `story:bootstrap-design-corpus`.

Owner ruling: "we are not prohibiting prohibitions here. We just want
them explained before the decision is canonized."

- The decision definition in `skills/_shared/artifact-definitions.md`
  says a decision states its choice and rationale, and that a
  prohibition the owner did not state is a suggested prohibition: the
  drafter may write one where it guards against a harm, and gives its
  reason.
- `/plan-sprint`'s sign-off compliance review lists each sentence in a
  drafted delta that forbids something the owner did not state, with
  the drafter's reason. The session presents them at Approval as one
  list, each with its reason, and the owner keeps or drops each. A
  dropped prohibition leaves the delta before approval.
- `/discover-design`'s drafts mark each suggested prohibition with its
  reason, so the `/plan-sprint` that takes the discovery up lists it
  the same way.

### 22. A stuck defect's change is restored with care

Realizes `converge-finds-then-fixes`, `story:find-and-fix-defects`.

Owner ruling: a stuck defect cannot be fixed forward, since each sent-back
fix already was an attempt to; its change is not backed out mechanically
but restored with care, "considering any other changes made".

In every `/converge` mode, `skills/converge/prompts/backout.md` becomes a
restoration. Where a defect reaches its limit of send-backs, a restorer
returns the code to the behavior it had before the stuck defect's fixes,
reading every change made since and keeping each one another defect
needs; it works by judgment, not by removing hunks, and the `tangled`
close is gone. A verifier checks that the prior behavior is back, that
every other accepted fix still works, and that the project's checks pass
on the changed files. A restoration sent back gets the run's limit of
send-backs; at that limit, the defect's intake issue names the state the
code was left in. The defect goes to the intake as a judgment issue, as
today.

### 23. No step of a sprint waits on a person

Realizes `story:plan-a-sprint`, `story:certify-completion`,
`decision:work-items-change-the-product`,
`decision:drive-tries-each-story-as-a-user`.

Owner ruling: "A. but those cases are rare and usually only deal with
third party integrations or use scenarios that only a user should
provide. we don't want this to become an escape hatch. everything in a
sketch and then sprint should be product-internal and thus
acheivable."

- `/plan-sprint`'s rule that execution and certification need no owner
  action binds every element of a sprint, not work items alone: each
  work item, each call in the implementation notes, each line the
  notes tell the build to write into the review facts, and the drive
  of each story. Planning refuses an element that needs a person
  during execution or certification.
- The code planner checks each element it writes against the rule,
  and the notes review checks the whole notes and every story the
  sprint adds or amends. A story the drive cannot complete with only
  what the local stack gives is a finding.
- Where a story's benefit passes through a party outside the product,
  such as a third party's sign-in or input only a real user gives,
  the sprint builds a local stand-in for that party, run by the
  project's stack, and the drive and the tests use it. A stand-in
  replaces only that outside party. It never replaces the product's own
  code, and planning never accepts "needs a person" as a reason to
  leave work out of a sprint.
- The sprint document's boilerplate line on owner action names every
  element, and the drive prompt tells a driver to use the stand-in the
  review facts name for an outside party.

## Implementation notes

Planned against commit `301043a8d0bce6c7cf17286a8a24937d19e1e95d`.

### Cross-group dependencies (group 1)

These are the other planners' side; group 1 planned only its own.

- **Item 1.**
  - `tests` `resolved_sprint` must accept `.ok-planner/sprints/` paths.
  - It retires `tasks --stage fix`, the write stage's control tasks, `complete`, `report`, and `window`. It keeps `tasks --stage write|verify|sweep|speed` and `stamp`.
  - `testing.enabled` and `offers` go into `TESTING_KEYS` (in `scripts/tests` and `scripts/plumbline`, which items 8 and 9 also edit for `schedule` and `reaches`).
  - The cheatsheet, CLAUDE, and USAGE text.
- **Item 2.** `/ok-setup` calls `tests declare --schedule`/`--schedule-said` and `--reaches`/`--reaches-said`.
- **Item 3.** The new home of the resources rule and planner prompts, the plan assembly, and the plan's `kept`.
- **Item 6.**
  - The run opener sets `item_states` (`support`, `product-slow`) and `field_types`.
  - The prompt blocks' new home, and the filing of support, test, and speed tasks (using `tests slowest --from state`).
  - The one judging block shared by the verify and speed prompts.
  - The sprint document boilerplate, which item 20 also edits (archive steps).
- **Item 7.**
  - The suite as a find source reads `tests failures` (`schedule--`, `perf:`, standing failures, `not run`).
  - The verifier uses `tests reached`.
  - The speed task after a failed round uses `tests slowest --round <n>`.
  - The fixer for a `perf:` entry.
  - The archive writer writes `ranking`, `acceptances`, and `reaches` into `test-state.json`.
  - `late_tasks`' roles for `build` and `fix`.
  - The whole-round requirement in `review certified`; item 14 adds its refusals and the mark to the same `cmd_certified`.
- **Item 16.** `docs/testing.md` and the cheatsheet's ambient ranking line ("held adds whole, isolated divided") must follow item 8's bound.
- **Item 17.** True-up writes `testing.schedule`, `testing.reaches`, and `testing.enabled`, and converts `test-state.json`. It shares `admin/true-up` and `ADMINISTRATION.md` with item 20.
- **Item 22.** Its restorer role counts as a code task in item 14.

### Cross-group dependencies (group 2)

- **Items 8–11 (the tests tool).** These work items call their mechanisms and do not plan them:
  - `tests run --only` at the budget's workers, with every run that names a sprint recorded as a `rerun` round.
  - Standing results and `--failing` over them.
  - The `reaches` rule, called here as `tests reached --sprint <p> --files <paths>`.
  - Speed acceptances and the carried ranking.
  - The `support` pool.
  - The write stage's refusals for `after` lists and blocked tasks.
  - Both groups change these definitions: `scripts/tests::stage_write`, `stage_verify`, `stage_speed`, `cmd_stamp`, `unsettled_failures`, `live_tests`, `cmd_declare`. Stages that touch them must be chained with `--after`.
- **Item 14.** Its checks also go into `scripts/review::cmd_certified` and `certification_failures`, so chain the stages.
- **Item 17 (true-up).** It owns:
  - removing the vendored `plan-tests` and vendoring `ok-setup` (`admin/true-up::SKILLS`, `UNPREFIXED`, `RETIRED_VENDORED`, `TEST_SPRINT_BOILERPLATE`, `LIVE_SPRINT_KINDS`);
  - converting `test-state.json` to per-story stamps;
  - writing `testing.enabled`, `testing.offers`, `testing.schedule`, and `testing.reaches`;
  - archiving open test sprints;
  - the line-for-line live-sprint migration that reads `admin/retired-boilerplate.json`.
- **Item 13 (the drain).** It also edits `skills/_tasks/drain.md`, so chain it with item 4's stage.
- **Items 15 and 16.** They also edit `docs/plumbline-cheatsheet.md`'s Tests section, so chain it with item 1's stage.

All paths below are under `plugins/ok/families/ok-planner/` unless they start with `checks/`, `docs/`, or `.ok-planner/`.

### Cross-group dependencies (group 3)

- D1 (items 8–14, config-check): `scripts/plumbline config-check` must accept a `testing` object that holds only `{"enabled": "off"}`. It must also validate `enabled`, `schedule`, `reaches`, and `offers`, with `said: null` allowed. True-up writes exactly those shapes.
- D2 (items 9/10, `scripts/tests`): needs a scenario-list conversion verb, which item 10 plans: `tests convert-state [--clear <story>...] [--dry-run]`. It says whether the file is in the earlier form and prints the converted file on `--dry-run`. It derives the story stamps itself: each story with recorded scenarios gets the blob id of `.ok-planner/design/stories/<slug>.md` at the old top-level `stamp` commit, and no stamp where `git cat-file -e` fails or the file is absent at that commit. The work items 7/9/10 planner owns the converted form (story stamps, acceptances, ranking, `reaches`, `kept`). True-up imports the tool's existing `STORY_SOURCE` from the carried copy and does not copy it.
- D3 (item 14): the lint starts reading `testing.enabled`. The ADMINISTRATION edit changes "The lint reads every key but `testing`…" to match. That edit has to land with item 14 or after it.
- D4 (item 1): removing `"plan-tests"` from `SKILLS` must land in the same stage as item 1's deletion of `skills/plan-tests/`. If the folder goes first, `expected()` still writes `.claude/skills/plan-tests/LICENSE` and `carried_boilerplate` asserts on the missing template. Item 1 also owns the stale `checks/token-resolution` entries for `plan-tests/`.
- D5 (item 2): adding `"ok-setup"` to `SKILLS` must land with item 2's `skills/ok-setup/` or after it. Otherwise true-up writes a LICENSE into an empty folder.
- D6 (items 4/6/7/14/20): every boilerplate line those items retire from `skills/plan-sprint/sprint-document.md` or `skills/plan-docs/doc-sprint-document.md` must be appended, sorted, to `admin/retired-boilerplate.json` or `admin/retired-doc-sprint-boilerplate.json`. Otherwise live sprints are not brought current, and `checks/sprint-boilerplate` fails.
- D7 (item 7): an approved sprint planned before this release has no test plan. Certification under `on` must run such a sprint with no `-plan.json`.
- File overlap: `docs/plumbline-cheatsheet.md` is edited by items 1 (Tests block and Tooling), 15, and 16. `scripts/ok-planner-cheatsheet.md` and `scripts/ok-planner-CLAUDE.md` are edited by items 1 and 19. `skills/_shared/artifact-definitions.md` is edited by items 21 and 19. Chain those stages.

### Build notes

- Build note: these shared files take edits from several items, so chain the stages that touch each with `--after`. Decided by: notes review.
  - `scripts/ok-planner-cheatsheet.md` and `scripts/ok-planner-CLAUDE.md`: items 1, 5, 12, 19, 20, and 22.
  - `skills/_sprint/shared.md`: items 1, 4, 6, 7, and 20.
  - `skills/plan-sprint/sprint-document.md`: items 3, 6, 7, 14, and 20.
  - `skills/_converge/coding-rules.md`: items 15 and 22.
  - `skills/converge/SKILL.md`, `skills/converge/prompts/verify.md`, and `skills/converge/prompts/owner-list.md`: items 7, 19, and 22.

### 1. Testing folds into the sprint

**Calls**
- Build note: `checks/sprint-boilerplate::KINDS` is item 1's alone; item 17 does not edit it. Decided by: notes review.
- Build note: the moved rule blocks push `skills/_sprint/shared.md` and `skills/plan-sprint/tests.md` past the ~500-line guideline. Split `skills/plan-sprint/tests.md` into one file per planner where it passes 500 lines. Keep `skills/_sprint/shared.md` whole, since `review::block_sources` resolves blocks only from the files the review config lists. Decided by: notes review.
- Kicked back and settled: item 1 retires these verbs from `bin/tests`: `tasks --stage fix`, the write stage's control tasks (`stage_controls`, `controls_built`, `control_tasks`, `control_brief`), `complete`, `report`, and `window`, with `back_out` and the fix snapshots it reads. It keeps these: `tasks --stage write|verify|sweep|speed`; `stamp`, as the archive step's writer, which item 7 reshapes; `snapshot` and `diff`, which item 11 keeps; and `groups`, `calls`, `plan`, `scenarios`, `declare`, `run`, `failures`, `stray`, `ports`, and `rules`. Decided by: work items 6, 7, and 11.
- The planning-only test blocks move to a new file, `skills/plan-sprint/tests.md`. The session resolves them by hand, as it does `core.md`'s prompts. These blocks are the story, runtime, programs, sort, and budget planners, the planner review, the plan-wide review, and `TEST-REVISION-RULE`. Decided by: item 3 and the ~500-line file guideline; `core.md` is already 472 lines.
- The test rule blocks that converge's and execution's prompts need move into `skills/_sprint/shared.md`. These are `TEST-SCENARIO-DEFINITION`, `TEST-RUNTIME-CLASSES`, `TEST-CALL-RULE`, `TEST-RESOURCES-RULE`, `TEST-WAITS-RULE`, `TEST-SILENCE-RULE`, `TEST-WASTE-RULE`, and the new `TEST-SPEED-JUDGING` (item 6). Decided by: `scripts/review::block_sources` resolves blocks only from the review config's `block_sources`, which already lists `_sprint/shared.md`. A new source file would need true-up to rewrite every project's review config, and `whole-file-ownership` lets true-up change only retired and missing keys there.
- The run prompts become prompt templates under `skills/converge/prompts/`, assembled with `review prompt --name <n> --sprint <path>` as `build.md` is, with `[TEST SPRINT PATH]` read as `[SPRINT PATH]`. The templates are `test-preflight.md`, `test-support.md`, `test-write.md`, `test-legacy.md`, `test-sweep.md`, `test-verify.md`, and `test-speed.md`. Decided by: there is one prompt assembler (DRY), and `review::assembled_lines` already replaces `[SPRINT PATH]`.
- `TEST-CONTROL-PROMPT` and `TEST-FIX-PROMPT` retire. Decided by: `planned-tests-name-their-waits` (time controls are code-stage work items) and item 7 (certification's fixers use `converge/prompts/fix.md` under one verifier).
- `README.md` stays as it stands. Decided by: it lies under docspec `readme`'s `## Where`, and builders write no documentation.

**Changes**
- `skills/plan-tests/` (SKILL.md, core.md, test-sprint-document.md): removed. Its blocks move as the calls above say.
- `scripts/tests::resolved_sprint`: changed. It accepts a sprint under `.ok-planner/sprints/` or `.ok-planner/history/sprints/`, and refuses any other path.
- `scripts/tests::TEST_SPRINTS`, `ARCHIVED_TEST_SPRINTS`: removed.
- `scripts/tests::archived_plans`: changed. It reads the `-plan.json` beside every sprint under `history/sprints/`, and also under `history/test-sprints/`, which is kept as an archive. So `tests calls` and widen still find earlier calls.
- `scripts/tests::cmd_tasks` and its parser: changed. They drop `fix` and the retired verbs.
- `scripts/tests::USAGE`, `EARLIER_TESTING`, and the error texts that name `/plan-tests` or "the test sprint": changed. Each now names `/plan-sprint`, `/ok-setup`, or "the sprint". The sites are lines 29–283, 336, 867, 1128, 1206, 1212, 2314, 2683, 3034, and 3762.
- `scripts/tests` and `scripts/review:437`: citations repointed.
  - `@decision: test-sprints-own-the-tests` becomes `test-tasks-own-the-tests`.
  - `@decision: test-sprints-build-approved-time-controls` at `tests:1233, 1255, 2743, 2780, 3379` becomes `planned-tests-name-their-waits`.
- `scripts/review::declared_checks`: changed. Its refusal text reads "tests run only in a sprint's test stages and sprint certification, or when a person asks".
- `skills/plan-sprint/core.md::{{OUT-OF-BAND-REVIEWER-PROMPT}}`: changed. Its paragraph on archived test sprints stays, now worded as an earlier release's records.
- `skills/_sprint/shared.md`: changed. Its preamble drops `/plan-tests`. `{{CEREMONY-RUN-RULES}}`, `{{CEREMONY-VETO}}`, and `{{CEREMONY-ARCHIVE}}` name the documentation sprint alone.
- `docs/plumbline-cheatsheet.md`: changed in the Tests bullets, the `no-tests` line, and the `/plan-tests` tooling line. The rule reads "Only a sprint's test tasks add, edit, or delete a test". Agents run tests only in test stages, in certification, or when a person asks.
- `scripts/ok-planner-cheatsheet.md`: changed in Lifecycle, Tests, and the records lists, to describe the fold as `testing-runs-inside-the-sprint` and `test-tasks-own-the-tests` state it.
- `scripts/ok-planner-CLAUDE.md`: changed in the config, lint, tests, records, and lifecycle sections, the same way.
- `scripts/ok-cheatsheet.md`: changed. Executing a sprint gains the test stages.
- `CLAUDE.md` (the family's): changed. It updates the nine-verbs sentence, the layout rows, the Tests paragraph, and the chaining paragraph.
- `review/CLAUDE.md:6`: changed to match.
- `docs/plumbline-coding.md`: unchanged for item 1, since `rg` finds no test-sprint text in it.
- `checks/sprint-boilerplate::KINDS`: changed. It drops the test-sprint kind.
- `checks/token-resolution::DEFINITIONS`: changed. It drops the two plan-tests files and adds `plan-sprint/tests.md`.
- `docs/integration-contract.md:489–491`: changed. The vendored-skill list drops `plan-tests` and adds `ok-setup`.
- `.ok-planner/review/project.md` (the `scripts/tests` entry): changed. It lists the new verb set and names `/ok-setup` in place of `/plan-tests`.

**Behavior changes**
- **B100** `skills/plan-tests/SKILL.md` (`/plan-tests [widen ...]`). Before: an owner types it and gets a test sprint. After: the command does not exist.
  Users: in the release: the family's references, all rewritten. Across the public surface: every owner who types `/plan-tests`.
  Ruling: rewrite across public surface: testing folds into every sprint, so no separate planning verb remains (owner, 2026-11-06; released as v31).
- **B101** `skills/plan-tests/` (vendored skill name, `.ok-planner/test-sprints/`). Before: true-up vendors `plan-tests`. After: it does not.
  Users: across Trued-up projects: every project's vendored copy, and every open test sprint.
  Ruling: migrate: true-up deletes the vendored skill, moves an open test sprint to `history/test-sprints/` as it stands, and files one issue (item 17) (call; decided by `live-sprints-brought-current-on-true-up`).
- **B102** `scripts/tests` (the retired verbs). Before: `tasks --stage fix`, `complete`, `report`, `window`, and `--stage write`'s control tasks run. After: each refuses as an unknown verb or stage.
  Users: in the release: the deleted plan-tests files and project.md's entry. Across Trued-up projects: a live test sprint's boilerplate, archived by B101.
  Ruling: rewrite.
- **B103** `scripts/tests::resolved_sprint`. Before: it accepts only paths under `test-sprints/`. After: it accepts only paths under `sprints/` and `history/sprints/`.
  Users: in the release: every `--sprint` caller (plan-sprint, the sprint boilerplate, converge).
  Ruling: rewrite.
- **B104** The rules texts listed under Changes. Before: they say a test sprint owns the tests. After: they say a sprint's test tasks own the tests.
  Users: in the release: every agent that loads them.
  Ruling: rewrite.
- **B105** `scripts/review::declared_checks`. Before: its refusal text names a test sprint. After: it names test stages and certification.
  Users: in the release: the callers of `review checks` and `review certified`.
  Ruling: rewrite.
- **B106** `skills/_sprint/shared.md` (the ceremony blocks). Before: they name a test sprint. After: they name the documentation sprint alone.
  Users: in the release: `plan-docs/doc-sprint-document.md`.
  Ruling: rewrite.
- **B107** `checks/sprint-boilerplate`, `checks/token-resolution`. Before: they read the plan-tests files. After: they no longer do.
  Users: in the release: `checks/run`.
  Ruling: rewrite.

**New surface**
- None.

### 2. `/ok-setup` sets up testing

**Calls**
- `testing.enabled` has one reader, `scripts/review::testing_enabled(root)`. It returns `on`, `frozen`, or `off` through `tasks.setting`, and refuses a missing or other value. Sessions read it through a new verb, `tests enabled`. Decided by: `scripts/tests` imports `review`, so `review` cannot import `tests` without a cycle (plumbline-coding rule 6).
- The budget that `/ok-setup` plans goes into `test-state.json` `budget` through a new verb, `tests budget --from-run <run>`, which reuses `planned_budget` and `budget_failures`. Decided by: the budget is stored state that only `bin/tests` writes, and `/ok-setup` is not a sprint.
- `/ok-setup` runs its budget task on a tracker run at `.ok-planner/tasks/ok-setup-<date>.jsonl`. Decided by: the tracker's default run location.
- The runner check reads `kind` and `setup` from `tests scenarios --json` where a record holds them; item 7's stamp starts recording them. Where a record holds neither, the session reads the test file and names its kind. Decided by: today's scenario records carry no kind or setup.
- The next sprint with test stages runs the preflight where the recorded budget carries no preflight mark, or where the plan changes the budget. Decided by: item 6, "the preflight where the budget changed".
- `testing_config` refuses under `off` only for a run that names `--sprint`, so a run a person asks for still works under `off`. `/ok-setup` writes `--enabled on` before its runner check and its budget task. `tests enabled` reads through `review.testing_enabled`, not through `testing_config`. Decided by: notes review.
- Build note: `cmd_declare`'s `--schedule`, `--schedule-said`, `--reaches`, and `--reaches-said` flags are items 8 and 9's; item 2 adds only `--enabled` and `--offers`. Decided by: notes review.

**Changes**
- `skills/ok-setup/SKILL.md`: new. Its description keeps the load-bearing "ONLY activated by explicit /ok-setup slash command" wording.
  - It reads `testing`, and asks only what is missing or what the owner asks to change.
  - **Turning testing on:**
    - It writes `tests declare --enabled on` first, before the runner check and the budget task.
    - It asks for the runner keys, as `/plan-tests` step 2 does today.
    - It asks the schedule question and the coverage question, recording the owner's words for each.
    - It runs the budget task (`TEST-BUDGET-PROMPT` from `plan-sprint/tests.md`), drains it, and writes the budget with `tests budget`.
    - It records `testing.offers`.
    - It runs the runner check over every kind and setup pair of the recorded tests, as `/plan-tests` step 9 does.
  - **Freezing or turning off:** it writes `testing.enabled` alone.
  - It writes only through `tests declare` and `tests budget`.
- `scripts/tests::cmd_declare` and its parser: new flags.
  - `--enabled on|frozen|off`.
  - `--offers [untested stale legacy runtime ...]`.
- `scripts/tests::testing_config`: changed. It reads `testing.enabled` through `review.testing_enabled` before the runner keys, and refuses a missing value. Under `off` it refuses only a run that names `--sprint`, naming `/ok-setup`; a run with no `--sprint` still runs.
- `scripts/tests::EARLIER_TESTING`, `DECLARE`: changed. Each names `/ok-setup`.
- `scripts/tests::enabled` (the `enabled` verb): new. It prints the state through `review.testing_enabled`, never through `testing_config`, and refuses a missing key.
- `scripts/tests::budget` (the `budget --from-run <run>` verb): new. It writes `budget` into `test-state.json` through `write_json`, an atomic replace.
- `scripts/review::project_runners`: changed. It reads `testing.runners` and `testing.run` only where `testing.run` is present. A `testing` that holds only `enabled` returns the built-in runners.
- `scripts/review::testing_enabled`: new.

**Behavior changes**
- **B108** `scripts/tests::testing_config`. Before: it needs only the runner keys. After: it refuses without `testing.enabled`, and under `off` refuses a run that names `--sprint`.
  Users: in the release: `/plan-sprint`, `/converge`, the boilerplate, `/ok-setup` (which writes `on` before it runs anything), and a run a person asks for with no `--sprint`, which still runs under `off`. Across Trued-up projects: every config an earlier release wrote.
  Ruling: migrate: true-up writes `testing.enabled` at the project's former behavior (item 17) (call; decided by `settings-have-no-code-defaults`).
- **B109** `scripts/review::project_runners`. Before: a `testing` object with no `runners` key refuses. After: one with no `run` key passes, with the built-in runners.
  Users: in the release: `review checks` and `review certified`.
  Ruling: rewrite.
- **B110** `scripts/tests::EARLIER_TESTING`, `DECLARE`. Before: the refusal text names `/plan-tests`. After: it names `/ok-setup`.
  Users: in the release: the agents that read it.
  Ruling: rewrite.

**New surface**
- `/ok-setup`, declared in `skills/ok-setup/SKILL.md`: public by the Slash commands rule.
- `tests enabled`, `tests budget`, and the new `tests declare` flags, declared in `scripts/tests`: internal.
- The configuration keys `testing.enabled` and `testing.offers`, read in `scripts/review` and `scripts/tests`: internal.

### 3. `/plan-sprint` plans the tests

**Calls**
- The test planners run as tracker tasks on a planning run beside the sprint, `<name>-test-planning.jsonl`, as `/plan-tests` ran them. Their prompts are written to `<name>-test-planning-<role>.md`. Decided by: `tests groups` and `tests plan` read the run's item pools.
- The steps run in this order:
  - Frame makes the offers.
  - Resolve asks the programs questions, over the entry points in the files the work items name and in the taken legacy folders.
  - Code planning lists the tested stories to re-plan.
  - A new Test planning step runs the groups, the planners, the owner's test questions, the assembly, the reviews, the budget, and the runner check.
  - Each time control a planner records becomes a work item, drafted as a call, which goes through code planning and the notes review.

  Decided by: item 3 and `planned-tests-name-their-waits`.
- The `/plan-tests` scope question and the `scope` pool retire. The sort covers the taken legacy folders alone, and `tests plan` records every other unclaimed test file as kept. Decided by: `legacy-suites-sorted-automatically`.
- The "claimed test a person edited" detection retires with `tests window`. Decided by: the legacy decision offers unclaimed files alone.
- Under `frozen`, the story planner's brief marks the group `frozen`, and `tests plan --frozen` refuses a `new` scenario. Decided by: `testing-runs-inside-the-sprint`.
- The runtime group is offered on every sprint under `on` where `testing.offers` lists `runtime`. Decided by: item 3.
- Widen stays. The owner may name stories at Frame, or ask for every story an earlier plan's calls left out. Decided by: `scenario-list-decided-once`.
- Planners read a stale story's planned version with `git cat-file -p <stamp blob>` against the current file. They read what the code change does from the sprint's implementation notes, since the code is not yet built. They read a story a delta adds from the sidecar. Decided by: per-story blob stamps (`scenario-list-decided-once`).
- The budget task runs only where one of these holds:
  - the plan holds a `new` or `rewrite` that needs the stack;
  - the plan declares a resource no recorded test declares;
  - a work item changes a file the recorded budget's `files` names.

  Decided by: item 3.
- Where no budget task ran, the plan carries `read_state(root)["budget"]`, `assembled_plan` no longer refuses for want of a budget task, and the stamp keeps the recorded budget. The recorded budget carries a preflight mark, and `stage_preflight` runs only where the mark is absent or the plan changes the budget. Decided by: notes review.
- The sprint gains a `## Tests` section. It records the testing state, the groups taken, the re-plan list, the owner's test answers, the plan's counts, and the plan's path. Where the `tests plan --show` output is too long to read in the session, it is written to `<name>-plan.md`. Decided by: item 3 and the self-sufficiency rule.

**Changes**
- `skills/plan-sprint/tests.md`: new. It holds the moved planner prompts, with `[SPRINT PATH]`.
  - The story planner reads the stamp blob diff and the notes. It plans `frozen` groups without `new` scenarios, and plans new-story slugs from the sidecar.
  - The sort prompt covers the taken folders.
  - The programs prompt is scoped as the order call says.
  - The planner reviews gain `reads` checks; item 8 owns what `reads` means.
- `skills/plan-sprint/SKILL.md`: changed.
  - Frame gains "Offer the test work", using `tests enabled` and `tests offers --json`, and the widen ask.
  - Resolve gains the programs task's questions.
  - A new "Test planning" section follows Code planning. It recasts `/plan-tests` steps 6–11 with these commands:
    - `tests groups --sprint <s> --from-run <r> --replan <slugs> --take <group keys> --new <slugs> [--widen ...]`
    - `tests plan`
    - the runner check
    - the time-control work items
  - The owner's judgments gain the planners' outcome-changed and code-removed questions.
  - The notes review gains the re-plan list.
  - Approval presents the `tests plan --show` summary.
  - Draft's `<!-- lint-check: no-tests -->` line reads "Draft no work item that writes a test; the sprint's test plan names every test".
  - Terminal's list of what the session writes adds the plan files and the planning run.
- `skills/plan-sprint/core.md::{{CODE-PLANNER-PROMPT}}`: changed. It gains a per-work-item output, **Tested stories**: each tested story whose implementation the work item changes, found from the `@story:` citations in the files it touches and from each recorded test whose `reaches` names one of those files.
- `skills/plan-sprint/core.md::{{IMPLEMENTATION-NOTES-FORM}}`: changed in step with the code planner prompt.
- `skills/plan-sprint/core.md::{{IMPLEMENTATION-NOTES-REVIEWER-PROMPT}}`: changed. It checks the tested-stories list against the sprint and the code.
- `skills/plan-sprint/sprint-document.md::{{SPRINT-DOCUMENT-TEMPLATE}}`: changed. It gains a `## Tests` section after `## Work items`.
- `scripts/tests::cmd_groups`, `touched_stories`, `window_touches`: changed.
  - Touches come from `--replan` (reason `behavior`), `--take` (offer group keys from `tests offers`, reason `untested` or `stale`), `--new` (each slug must be a `New story:` delta, checked through `review.sprint_deltas`), `--widen` (as today), and `--frozen`.
  - The runtime planner runs only where the runtime group was taken.
  - The sort covers the files of the taken folders.
- `scripts/tests::offers` (the `offers [--json]` verb): new.
  - It prints stale story groups (the blob id differs from the stamp, or the story has recorded scenarios and no stamp).
  - It prints untested story groups (no scenario and no no-guard answer).
  - It prints legacy folders (unclaimed test files, by folder) and the runtime group.
  - It groups stories as `planning_groups` does, lists only the kinds `testing.offers` names, and refuses unless testing is `on`.
- `scripts/tests::cmd_plan`, `assembled_plan`, `plan_failures`, `planning_scope`: changed.
  - The scope item retires, so no `in_scope` refusals remain.
  - Kept means every unclaimed file outside the taken folders.
  - `--frozen` refuses a `new` scenario.
  - Control items become the plan's `controls` for the sprint's work items.
- `scripts/tests::planned_budget`, `assembled_plan`: changed. Where no budget task closed `done` on the planning run, the plan's `budget` is `read_state(root)["budget"]`, and the plan assembles with no refusal.
- `scripts/tests::cmd_stamp`: changed. It writes the plan's budget, which is the recorded budget where no budget task ran. It sets the budget's `preflight` mark to the id of the sprint's preflight task that closed `done`, and keeps the recorded mark where the plan carries the recorded budget unchanged.
- `scripts/tests::stage_preflight`: changed. It files no preflight where the plan's budget carries the `preflight` mark and equals the recorded budget. A budget a budget task produced carries no mark, so it gets a preflight.
- `scripts/tests::cmd_window`, `window_entry`, `sort_files`: removed, or folded into `offers`.
- `.ok-planner/review/project.md` (the `scripts/tests` entry): changed. It gains the new verbs.

**Behavior changes**
- **B111** `skills/plan-sprint/SKILL.md` (`/plan-sprint`). Before: it plans no tests. After: under `on` or `frozen`, it offers groups, plans tests, and presents them at Approval; under `off`, it plans none.
  Users: across the public surface: owners.
  Ruling: migrate: it accepts every invocation it accepted, and under `off`, which true-up writes for every project with no scenario list, it plans no tests (call; decided by `testing-runs-inside-the-sprint`).
- **B112** `scripts/tests::cmd_groups`. Before: it touches stories by the window since one stamp. After: it touches them by `--replan`, `--take`, `--new`, and `--widen`.
  Users: in the release: plan-sprint.
  Ruling: rewrite.
- **B113** `scripts/tests::cmd_plan`. Before: it refuses a run without one scope item, and refuses entries outside the scope. After: it has no scope, keeps every unclaimed file outside the taken folders, and under `--frozen` refuses a `new` scenario.
  Users: in the release: plan-sprint.
  Ruling: rewrite.
- **B114** `skills/plan-sprint/core.md::{{CODE-PLANNER-PROMPT}}`, `{{IMPLEMENTATION-NOTES-FORM}}`, `{{IMPLEMENTATION-NOTES-REVIEWER-PROMPT}}`. Before: no tested-stories list. After: the planner writes the list, and the reviewer checks it.
  Users: in the release: plan-sprint.
  Ruling: rewrite.
- **B115** `skills/plan-sprint/sprint-document.md::{{SPRINT-DOCUMENT-TEMPLATE}}`. Before: there is no `## Tests` section. After: there is one.
  Users: across Trued-up projects: approved sprints not yet executed.
  Ruling: preserve: execution and certification read a sprint with no `-plan.json` as planning no tests (call).
- **B220** `scripts/tests::planned_budget`, `assembled_plan`. Before: a plan refuses to assemble without a budget task closed `done`. After: it carries the recorded budget.
  Users: in the release: `/plan-sprint`'s Test planning step.
  Ruling: rewrite.
- **B221** `scripts/tests::stage_preflight`. Before: every test sprint that names a stack runs a preflight. After: a preflight runs only where the budget carries no preflight mark or the plan changes the budget.
  Users: in the release: the boilerplate's test stages (item 6). Across stored state: a budget an earlier release recorded carries no mark, so the next sprint runs its preflight once.
  Ruling: rewrite.

**New surface**
- `tests offers` and the new `tests groups` flags, declared in `scripts/tests`: internal.

### 4. Planning leaves the tree ready to run

**Calls**
- The commit step is one block, `{{PLANNING-HANDOFF}}` in `skills/_sprint/shared.md`. Both Terminals cite it with their `<goal path>`. Decided by: DRY, since both skills do the same job.
- The step runs after the promotions and the archive moves, before the goal line. It groups commits by the work each path belongs to, such as "true-up of the vendored layer" or "out-of-band code", and stages them by name with `git commit -- <paths>`. Decided by: item 4.

**Changes**
- `skills/_sprint/shared.md::{{PLANNING-HANDOFF}}`: new.
  - It runs `git status --porcelain` and names the paths outside `.ok-planner/`, by group.
  - It asks once. On a yes it commits, then checks again.
  - On a no, it names what the base step will refuse, and hands over no goal line.
  - Otherwise it hands over `/goal <goal path> — run each drain as a workflow`.
- `skills/plan-sprint/SKILL.md` (§13 Terminal step 4): changed. It follows the block. The list of what the session writes adds "the commits the owner agreed to".
- `skills/plan-docs/SKILL.md` (§7 step 2): changed in the same way.
- `skills/_tasks/drain.md` ("Two forms"): changed. The session runs the Workflow form only where the owner opted in, in the goal line or in their own words; otherwise it runs the drain by hand. Decided by: `drain-runs-as-a-workflow-script`.
- The base checks in the sprint and documentation-sprint boilerplate stay unchanged, as the guard.

**Behavior changes**
- **B116** `skills/plan-sprint/SKILL.md`, `skills/plan-docs/SKILL.md` (Terminal). Before: the goal line is handed over whatever the tree holds. After: the session proposes commits, and hands over the opt-in goal line only once the tree is clean.
  Users: across the public surface: owners.
  Ruling: migrate: the old goal line, naming only the path, still starts execution, which then drains by hand (call; decided by the owner's ruling in item 4).
- **B117** `skills/_tasks/drain.md`. Before: the Workflow form runs wherever the harness offers it. After: it runs only on the owner's opt-in.
  Users: in the release: every caller of the drain.
  Ruling: rewrite.

**New surface**
- None.

### 5. Reconcile shows out-of-band changes as one batch

**Calls**
- The out-of-band reviewer stays as it is, apart from its output. The session drafts each bearing change's deltas and shows one summary. Direct edits to the corpus, a docspec, or the surface intent join the batch as "corpus catches up". Decided by: `out-of-band-work-reconciled-as-a-batch`.

**Changes**
- `skills/plan-sprint/SKILL.md` (§3 Reconcile step 4, and the documentation and direct-edit paragraphs): changed.
  - Each `corpus` change is drafted as corpus catches up.
  - Each `documentation edited` change is drafted as the edit stands, with a docspec delta where the edit changed what the documentation covers.
  - The session shows one summary, apart from the sprint's own work, with one line per change and its deltas.
  - The owner may pull a change out, to code catches up or to record and defer.
  - Each `contract broken` change is walked one at a time, with its three outcomes.
- `skills/plan-sprint/core.md::{{OUT-OF-BAND-REVIEWER-PROMPT}}` (output): changed. Its `corpus` entries name the artifacts each change would amend, for the summary line.
- `scripts/ok-planner-cheatsheet.md:349` and `scripts/ok-planner-CLAUDE.md:229–235`: changed. Each describes the batch.

**Behavior changes**
- **B118** `skills/plan-sprint/SKILL.md` (Reconcile). Before: the session walks each change with the owner. After: it shows one batch summary, with pull-outs, and walks only broken public contracts.
  Users: across the public surface: owners.
  Ruling: migrate: each earlier outcome is still reached by pulling a change out of the batch (call; decided by `out-of-band-work-reconciled-as-a-batch`).

**New surface**
- None.

### 6. Execution writes the tests in build stages

**Calls**
- `tests tasks` files the test stages; they are not build tasks. Execution step 4 runs `tests tasks --sprint <p> --stage write --after <the code-stage build tasks whose files a planned scenario's entry or support reaches>`. Where no code stage overlaps, it runs with no `--after`, beside the code stages. Decided by: item 6, and `stage_write` already files the support, test, and legacy tasks with their chains.
- Code complete also needs every test-stage task closed `done` at its latest filing, with no write, verify, or sweep stage left to file a task. Decided by: `team-execution-cold-gate`.
- `TEST-SPEED-JUDGING` holds the waste list and the verdict rule that `TEST-SPEED-PROMPT` holds today. Both `test-verify.md` and `test-speed.md` include it. Decided by: item 6.
- The carried-over speed task is `--stage speed`, with one batch from the carried ranking, under `on` only. Decided by: item 6, with item 10's data.
- `--stage speed` and `tests slowest` take one of two sources: `--from state`, the carried ranking, or `--round <n>`, the failed whole round certification names. Both refuse neither and both. `speed_refusal` requires no round under `--from state`, and under `--round <n>` requires round `<n>` to be a whole round that failed. `stage_speed` takes its batch from item 10's `speed_candidates`. `speed_brief` has a form with no round number for the state source. Decided by: notes review.
- Build note: product-slow is a verdict in `{{TEST-SPEED-JUDGING}}`, so the write-time verifier may record it as the speed reviewer does. Items 8 and 10 name `{{TEST-SPEED-PROMPT}}`; read each as `skills/converge/prompts/test-speed.md`. Decided by: notes review.

**Changes**
- `skills/_sprint/shared.md::{{SPRINT-BUILD-PROMPT}}`: changed. Its `<!-- lint-check: no-tests -->` bullet reads "A code stage adds, edits, deletes, and runs no test: the sprint's test stages own the tests". The call that bullet records goes to the test stages and certification.
- `skills/_sprint/shared.md::{{TEST-SPEED-JUDGING}}`: new.
- `skills/converge/prompts/test-*.md` (seven files): new, made from the moved run prompts. `test-write` uses the time control a code stage built. `test-verify`'s test brief adds the seconds, workers, `resources`, and `reads`, and includes `TEST-SPEED-JUDGING`.
- `skills/plan-sprint/sprint-document.md` (boilerplate): changed.
  - Step 3: where a `-plan.json` stands, register the seven `test-*` prompts with `review prompt`, and declare the test pools.
  - Step 4: file the test stages as the first call says, then run `--stage verify` until neither stage files a task, then `tests ports`, then `--stage sweep` while `tests stray` lists a file, then, under `on`, `--stage speed` with its write and verify rounds.
  - Step 7: it names the write stage's refusals as genuine blockers.
  - Step 12: code complete covers the test stages.
- `admin/retired-boilerplate.json`: changed. It gains every removed boilerplate line, sorted, as `checks/sprint-boilerplate` requires.
- `scripts/tests::stage_write`: changed. It files no control task, and takes `--after <tasks>` and `--run <run file>`, defaulting to the sprint's `-run.jsonl`. Grouping support work per file is item 11's.
- `scripts/tests::test_verify_brief`: changed. It adds the seconds of the test task's own run, the budget's workers, `resources`, and `reads`.
- `scripts/tests::stage_speed`, `speed_walk`: changed. They file one batch of `testing.slowest` tests that have no speed acceptance at their current file digest, from `speed_candidates` (item 10). In the build stages they read `--from state`, the carried ranking; in certification, `--round <n>` (item 7).
- `scripts/tests::speed_refusal`: changed. Under `--from state` it requires no round. Under `--round <n>` it refuses unless round `<n>` is a whole round with at least one failure.
- `scripts/tests::cmd_tasks` (speed) and its parser: changed. `--stage speed` takes `--from state` or `--round <n>`, and refuses neither and both.
- `scripts/tests::unregistered` (message): changed. It names `review prompt --name test-<role>`.

**Behavior changes**
- **B119** `skills/_sprint/shared.md::{{SPRINT-BUILD-PROMPT}}`. Before: the test bullet says a test sprint owns the tests. After: it says the sprint's test stages do.
  Users: in the release: build tasks.
  Ruling: rewrite.
- **B120** `skills/plan-sprint/sprint-document.md` (boilerplate steps 3, 4, 7, 12). Before: code stages only. After: test stages too.
  Users: across Trued-up projects: approved sprints not yet executed.
  Ruling: migrate: the removed lines go into `admin/retired-boilerplate.json`, so true-up brings each live sprint current line for line (item 17) (call; decided by `live-sprints-brought-current-on-true-up`).
- **B121** `scripts/tests::stage_write`. Before: it files control tasks first, and runs on the test sprint's run. After: it files no control tasks, and takes `--after` and `--run`.
  Users: in the release: the boilerplate and converge.
  Ruling: rewrite.
- **B122** `scripts/tests::test_verify_brief`. Before: the brief gives the reach and the waits. After: it also gives the seconds, the workers, the resources, and the reads.
  Users: in the release: the `test-verify` prompt.
  Ruling: rewrite.
- **B123** `scripts/tests::stage_speed`. Before: it walks a passing round batch by batch until a batch comes back clean. After: it files one batch, from the carried ranking or from a failed round.
  Users: in the release: the boilerplate and converge.
  Ruling: rewrite.
- **B222** `scripts/tests::speed_refusal`. Before: it refuses unless the latest round is a whole round with no failures and no late task. After: under `--from state` it requires no round; under `--round <n>` it requires round `<n>` to be a failed whole round.
  Users: in the release: `stage_speed`, the boilerplate's build-stage speed task, and certification's speed step after a failed round.
  Ruling: rewrite.

**New surface**
- `review prompt --name test-<role>` templates, declared in `skills/converge/prompts/`: internal.

### 7. Certification runs the suite

**Calls**
- Suite reports enter the run through a new verb, `tests reports --sprint <p>`. It adds reports to the selected run (the converge ledger), under area `sprint-suite`: one per failure of the latest whole round, one per grown leftover count, one per `perf:` entry, and one per `schedule--` entry. Each report carries `entry=T1|T2|T3|T4`, `test=<id>`, `round=<n>`, `files` from the test's `reaches`, and, for a failing test, `rerun=failed|passed` from that test's own `--only` rerun that follows the round. It skips a scenario whose record carries an open issue. Decided by: `review` cannot import `tests` without a cycle, and the session adds no report for judgment by hand.
- Four new defect states: `promise` (the fixer's record), `promised` (the verifier agrees; settled), `at-fault` (the fixer's record), and `rewrite` (the verifier accepted the fault and sent each named test back through the `tests` pool). Decided by: `test-loop-fixes-code-never-tests`.
- A `rewrite` defect is confirmed in Confirm step 6. Once each named test's test task closes `done` and its verifier accepts the test, the test runs with `--only`. A pass sets the defect `verified`; a failure sets it `open`. Decided by: item 7, "Confirm".
- Under `frozen`, at-fault rewrites still run, and speed work does not. Decided by: `frozen` keeps the suite as a guard without paying to maintain it, but an at-fault test with no send-back cap would hold certification open for good.
- The completion check is a new verb, `tests settled --sprint <p> --ledger <l>`. `review certified` and Loop 2's end check run it as a subprocess. It checks three things: a whole round ran after the last change (item 9's `late_tasks`), every failure is `promised`, and every speed send-back is either settled or returned to its last passing version. Decided by: item 7, and the same cycle.
- The archive's stamp reads the certification ledger that the completion report's `# Sprint certification` section names, through `review.ledger_path`. Decided by: certification's test tasks, speed items, and promises live in that ledger.
- These notes plan item 7's `review certified` bullet. Item 14's test-path checks go into the same function under the other group.
- Every `read_plan` caller reads an absent `-plan.json` as planning no tests: no scenarios, the project's folders, the recorded budget, and the recorded `kept`. The callers are `budget_workers`, the `tested_round` header, `unsettled_failures`, `stray_paths`, `cmd_tasks`, `live_tests`, and `run_targets`. Decided by: notes review.
- The round header records the closed changing tasks of both the sprint run and the certification ledger. `CHANGING_ROLES` gains `build` and `restore`. `RUN_ROLES`, `CHANGING_ROLES`, and `PRODUCT_ROLES` drop `control` and the retired test-sprint `fix` role. Decided by: notes review.
- `tests reports` adds one report per `perf:` entry and one per `schedule--` entry, and `{{SPRINT-CATALOG}}` gains a class for each: **T3** (a product is slow) and **T4** (a schedule breach). Decided by: notes review.
- The rerun before a fixer is one `tests run --sprint <p> --only <id>` per failing test, filed only where `tests failures --json` lists a failing test. It replaces step 3a's unconditional `--failing` exec. Decided by: notes review.
- The sprint template's fixed Completion contract (`skills/plan-sprint/sprint-document.md`, contract item 3 and the goal rule) gains the suite term, `promised` among the settled defect states, and the test-path and stray refusals, matching `review certified`. Its removed lines go into `admin/retired-boilerplate.json`. Decided by: notes review.
- Build note: `live_tests` and `recorded_tests` merge the certification ledger's `tests` records with the sprint run's, and `cmd_tasks` takes `--run` on every stage. Decided by: notes review.

**Changes**
- `skills/converge/SKILL.md`: changed.
  - The description and the find and fix paragraphs: the loops are capped except for suite defects, and stuck defects are restored (item 22).
  - The `<!-- lint-check: no-tests -->` line reads "Outside sprint certification's suite, nothing here adds, edits, runs, or reads a test".
  - Setup step 4 registers `test-write`, `test-support`, `test-verify`, and `test-speed` in sprint mode wherever `tests enabled` does not print `off`.
  - Setup step 5 declares the new defect states and the `tests`, `support`, and `speed` pools.
  - Sprint mode gains step 3a, "The suite". Under `off`, it says the suite was skipped. Otherwise it runs an `exec` task of `tests run --sprint`, then `tests failures --sprint <p> --json`. Where that lists a failing test, it files one `exec` task of `tests run --sprint <p> --only <id>` per failing test. Then it runs `tests reports`.
  - Loop 2 step 1's stuck rule skips defects with `source=suite`.
  - Loop 2 gains a speed step after a failed round: `tests tasks --stage speed --run <ledger> --round <n>`, then the write and verify stages.
  - Step 2's end check adds the final whole round, through `tests settled`. A failed round reopens Loop 2 through `tests reports`, a merge, and fixes. The review passes, the checks, and the drive do not run again.
  - Step 6 reruns the test of each verified or `rewrite` suite defect.
  - The return gains a `suite` line.
- `skills/converge/prompts/merge.md`: changed. It gains a `sprint-suite` brief. Each report merges as a defect with `source=suite`, in scope, carrying `flaky` from `rerun=passed`. A `T4` report (a `schedule--` entry) merges as a suite defect that gets no fixer: Loop 2 in `skills/converge/SKILL.md` adds a `support` item for it and runs the write stage on the ledger (item 8).
- `skills/converge/prompts/fix.md`: changed.
  - It gains a section, "A failing test". The fixer starts from the test being right and runs it with `--only`. It takes the flaky route where the test passes with no reaching change. It records a test at fault, or records a promise only where the commitment itself stands in the way. It handles a grown leftover count. The section includes `{{TEST-SILENCE-RULE}}`.
  - The lint-check line reads "Add, edit, and delete no test; run and read a test only where your brief names a failing one".
- `skills/converge/prompts/verify.md`: changed. It gains "A fix for a failing test".
  - It checks that the fix detects no test, hides no failure, fakes no effect, and touches no test path.
  - It runs the test, then reruns the tests `tests reached --files <changed>` lists, and sends back a fix that fails a test that passed before it.
  - It accepts a fault (state `rewrite`, sending each named test back), and agrees with or rejects a promise.
- `skills/converge/prompts/owner-list.md`: changed. It files one `product-intent` issue per `promised` defect, and records the issue's id on the defect.
- `skills/_sprint/shared.md::{{SPRINT-CATALOG}}`: changed. It gains **T1** (a test fails), **T2** (a leftover count grew), **T3** (a product is slow, a `perf:` entry), and **T4** (a schedule breach, a `schedule--` entry).
- `scripts/review::SETTLED_DEFECT_STATES`: changed. It adds `promised`.
- `scripts/review::cmd_certified`: changed. Where `testing_enabled` is `on` or `frozen`, it runs `tests settled` and prints an "item 3 (suite)" result.
- `scripts/tests::reports`, `scripts/tests::settled` (verbs): new.
- `scripts/tests::unsettled_failures`: changed. It counts `promised` defects in the ledger as held.
- `scripts/tests::budget_workers`, `tested_round` (the header), `unsettled_failures`, `stray_paths`, `cmd_tasks`, `live_tests`, `run_targets`: changed. Each reads an absent `-plan.json` as a plan of no tests: no scenarios, the project's `folders`, `read_state(root)["budget"]`, and `read_state(root)["kept"]`. `read_plan` keeps its refusal for its other callers.
- `scripts/tests::live_tests`, `recorded_tests`: changed. They merge the certification ledger's `tests` records with the sprint run's.
- `scripts/tests::tested_round` (the header's `tasks_closed`): changed. It lists the closed tasks of the sprint run and of the certification ledger the completion report names, through `review.ledger_path`.
- `scripts/tests::CHANGING_ROLES`: changed. It drops `control` and gains `build` and `restore`. It keeps `fix`, which now names certification's fixer in the ledger, not the retired test-sprint fixer.
- `scripts/tests::RUN_ROLES`, `PRODUCT_ROLES`: changed. They drop `control` and the test-sprint `fix`. Where item 1's retirement of `complete_failures` leaves either with no reader, it is removed.
- `skills/plan-sprint/sprint-document.md` (Completion contract item 3 and the goal rule): changed. Item 3 adds `promised` to the settled defect states, and, where `testing.enabled` is `on` or `frozen`, a whole-suite round after the last change whose every failure is `promised`, every speed send-back settled or returned to its last passing version, no test path staged by a code task, and no stray test file. The goal rule names the same terms `review certified` checks.
- `admin/retired-boilerplate.json`: changed. It gains the contract lines removed above, sorted.
- `scripts/tests::cmd_stamp`: changed.
  - It takes an archived sprint under `history/sprints/`, and the certification ledger.
  - It stamps each story the sprint planned whose every planned scenario was written, kept, or retired, with the blob id of the story's file at `<sha>`. It clears the stamp of each other story the sprint planned.
  - It records each test's `kind` and `setup`, and writes the fields items 9 and 10 define.
  - It writes only `test-state.json`; it no longer writes `closed:`.
- `skills/plan-sprint/sprint-document.md` (archive): changed.
  - Step 2 moves every file beside the sprint that shares its filename.
  - Step 4 runs `tests stamp --sprint .ok-planner/history/sprints/<name> --commit <sha>` where a `-plan.json` stands, then adds `closed:` and commits both together.
  - The removed lines go into `admin/retired-boilerplate.json`.

**Behavior changes**
- **B124** `skills/converge/SKILL.md` (`/converge sprint`). Before: certification runs no suite. After: under `on` or `frozen`, the suite is a find source, with uncapped suite defects, a final round, and a speed step.
  Users: across the public surface: owners.
  Ruling: migrate: under `off`, which true-up writes for every project with no scenario list, the run is as before and says it skipped the suite (call).
- **B125** `scripts/review::cmd_certified`. Before: it checks three items. After: it also checks the suite item under `on` or `frozen`, and counts `promised` as settled.
  Users: in the release: boilerplate step 13 and goal checkers.
  Ruling: rewrite.
- **B126** `scripts/tests::cmd_stamp`. Before: it takes a test sprint, writes one top-level `stamp`, and writes `closed:`. After: it takes a sprint, writes per-story stamps, and writes no `closed:`.
  Users: in the release: the archive step. Across stored state: `test-state.json`.
  Ruling: migrate: true-up converts the earlier layout (item 17) (call; decided by `whole-file-ownership`).
- **B127** `skills/converge/SKILL.md` (description and loop text). Before: "two capped loops", with stuck changes backed out. After: the fix loop is uncapped for suite defects, and stuck changes are restored.
  Users: in the release: owners and agents.
  Ruling: rewrite.
- **B128** `skills/_sprint/shared.md::{{SPRINT-CATALOG}}`. Before: classes C1 to M1. After: T1 to T4 too.
  Users: in the release: the merge and the sprint passes.
  Ruling: rewrite.
- **B129** `skills/converge/SKILL.md` (the `defects` vocabulary). Before: seven states. After: four more.
  Users: in the release: the ledger's readers, `review certified` and the owner list.
  Ruling: rewrite.
- **B223** `scripts/tests::budget_workers`, `tested_round`, `unsettled_failures`, `stray_paths`, `cmd_tasks`, `live_tests`, `run_targets`. Before: each refuses a sprint with no `-plan.json`. After: each reads it as planning no tests.
  Users: in the release: `tests run --sprint`, `tests failures`, `tests stray` (and `review certified`'s stray subprocess), `tests tasks`, and certification's step 3a. Across Trued-up projects: approved sprints planned before this release (D7).
  Ruling: preserve: a sprint with no test plan runs execution and certification as a sprint of no planned tests (call).
- **B224** `scripts/tests::tested_round` (the header's `tasks_closed`). Before: it lists the sprint run's closed tasks. After: it also lists the certification ledger's.
  Users: in the release: `late_tasks`, `speed_refusal`, and `tests settled`. Across stored state: rounds an earlier release wrote keep their header, which `late_tasks` reads as listing no ledger task.
  Ruling: rewrite.
- **B225** `scripts/tests::CHANGING_ROLES`, `RUN_ROLES`, `PRODUCT_ROLES`. Before: they hold the test sprint's `control` and `fix` roles. After: `CHANGING_ROLES` counts `build`, certification's `fix`, and `restore`, and no role holds `control`.
  Users: in the release: `late_tasks`, so `tests settled` and `review certified` count a build or restore task closed after the round as late.
  Ruling: rewrite.
- **B226** `skills/plan-sprint/sprint-document.md` (Completion contract). Before: item 3 settles a defect as `verified`, `declined`, `duplicate`, or `stuck`, and names no suite. After: it adds `promised`, the suite term, and the test-path and stray refusals, under `on` or `frozen`.
  Users: in the release: `review certified` and every goal checker. Across Trued-up projects: approved sprints not yet executed.
  Ruling: migrate: the removed lines go into `admin/retired-boilerplate.json`, so true-up brings each live sprint current line for line (item 17) (call; decided by `live-sprints-brought-current-on-true-up`).

**New surface**
- `tests reports`, `tests settled`, and `tests reached` (item 9's), declared in `scripts/tests`: internal.

### 8. The schedule

**Calls**
- **Who reads what.** A scenario with a non-empty `resources` and no `reads` counts as reading every shared resource. "Every shared resource" means the union of all live tests' `resources` and `reads`. A scenario with no `resources` and no `reads` is isolated and takes no lock. Decided by: decision tests-isolated-unless-declared ("A scenario that declares a resource it changes and no `reads` counts as reading every shared resource… An isolated scenario declares no resource and reads no shared resource"). The work item's looser "a scenario with no `reads`" would lock every resource for every isolated test, which contradicts its own "a run of isolated tests takes no lock".
- **Groups.** A group is a connected component of tests that share a changed resource. The bound uses groups. Under `recommended`, the pair check uses the pairwise rule: two tests may overlap unless one changes a resource the other changes or reads. Decided by: work item 8, "the rule", and the decision.
- **Isolated in the `groups-*` forms.** "Isolated" means a test with no `resources`; a reader-only test runs with the isolated tests and joins no group. Decided by: the decision ("held" means changes).
- **Forbidden pairs, by form.**
  - `recommended`: the pairwise rule.
  - `groups-side-by-side`: a held test overlapping an isolated test, or two tests of one group overlapping.
  - `groups-one-at-a-time`: any held test overlapping an isolated test, or any two held tests overlapping.
  - Decided by: work item 8.
- **Timing for the schedule check.**
  - The tool stamps each result line's arrival as `time.monotonic()` seconds since the suite command started, and takes start = arrival − seconds. One clock, per plumbline-coding rule 3.6.
  - Overlap is strict, with no tolerance: a tolerance would be a setting, and the decision fixes the arithmetic.
  - Rounds an earlier release wrote, with no arrival times, skip the check.
  - Residual risk: a suite command that buffers its result lines shows false pairs. The decision accepts arrival as the measure.
  - Decided by: the decision.
- **Forms.** `bin/tests` refuses a `testing.schedule.form` other than the three it knows, and names them. While `said` is null, it ranks by the form and skips the check. Decided by: work item 8.
- **Resource locks.**
  - One flock per resource at `.ok-planner/.cache/tests-resource-<slug>.lock`: `LOCK_EX` for a resource the run's tests change, `LOCK_SH` for one they only read.
  - Locks are taken in sorted slug order, so two runs cannot deadlock.
  - They are taken before `testing.setup` runs and released in `finally` when the run ends.
  - A run that must wait first tries `LOCK_NB`; on a block it prints one line naming the holder and the resource, then blocks with no deadline.
  - Holders are named from a registry, `.ok-planner/.cache/tests-runs/<pid>.json` (sprint, kind, start, resources with modes). Each run writes its entry by temp-and-rename and removes it in `finally`.
  - Decided by: work item 8, the decision, and plumbline-coding rules 3 and 4.
- **A second whole-suite round** takes `tests-<sprint stem>-whole.lock` with `LOCK_NB` and refuses at once, naming the holding run from the registry and the results file, and saying to wait for it to end and run again. Reruns no longer refuse. Decided by: work item 8.
- **Recording.**
  - A recorded run keeps its round in memory and prints each result line live.
  - At its end, it appends header, results, and close together under `tests-<stem>-results.lock` (blocking `LOCK_EX`).
  - The round number is assigned inside that lock, as the count of rounds plus one. The header's `at` keeps the start time.
  - Decided by: work item 8 and decision scenario-list-decided-once.
- **`--only` with `--sprint` is recorded** as kind `rerun`. `--from` stays unrecorded, since `main` refuses it with `--sprint`. Decided by: work item 8 ("every `tests run` that names a sprint").
- **Leftover growth.** Leftovers are counted around every recorded round, and growth fails any round, reruns included. Decided by: the decision ("compares the counts before and after each round"). Note for the veto: an isolated rerun beside a whole round shares one global count, so either round can be charged with the other's leftovers. Limiting failures to whole rounds would narrow the decision, so it was not taken.
- **The new flag checks** go in `tests::main` beside its existing `SystemExit` checks. Decided by: plumbline-coding rule 2 (copy the sibling's shape).
- A `schedule--` failure goes to a support task in the test stages, never to a code fixer, because test paths belong to test tasks (item 14). Certification files a `support` item for it, naming the suite command's file and the pair, and runs `tests tasks --stage write --run <ledger>`, which files the support task. The defect settles when a later whole round shows no forbidden pair. Decided by: notes review.
- Build note: land improvement I3 (the round appended in `finally`) in item 8's stage, since `tested_round` is item 8's definition. Decided by: notes review.
- Build note: the resource-lock wait has no deadline, and the drain's exec step times out at 600000 ms. A run waiting on a lock prints a line every time it starts waiting. The drain's timeout stands: a waiting exec that times out is reissued. Decided by: notes review.

**Changes**
- `scripts/tests::TESTING_KEYS`, `testing_config`: changed. They require `testing.schedule` as `{"form": <recommended|groups-side-by-side|groups-one-at-a-time>, "said": <string|null>}` and return it.
- `scripts/tests::declared_values`, `cmd_declare`, `build_parser` (declare): changed. New `--schedule <form>` and `--schedule-said <words>`, the writer `/ok-setup` uses (work item 2); `--schedule` without `--schedule-said` is refused.
- `scripts/plumbline::TESTING_KEYS`, `TESTING_SETTINGS`, `testingDefects`: changed. They validate `schedule`.
- `scripts/tests::scenario_of`: changed. Reads `reads` the way it reads `resources`.
- `scripts/tests::plan_failures`: changed. Refuses a `reads` that is not a list of slugs, beside the existing `resources` check.
- `scripts/tests::declared_reads`: new, beside `declared_resources`.
- `scripts/tests::live_tests`, `run_targets`, `failing_targets`, `round_tests`, `scenario_brief`: changed. They carry and print `reads`.
- `scripts/tests::run_suite`: changed. The `{tests}` JSON gains `"reads"` per test. The run uses at most the budget's workers.
- `scripts/tests::take_line`, `read_stream`: changed. Each result records `arrived`.
- `scripts/tests::schedule_failures`: new. From a round's planned declarations and its results' start and end times, it returns one failure record `schedule--<a>--<b>` (scenario ids sorted) per forbidden overlapping pair. Skipped where `said` is null or the round has no arrival times.
- `scripts/tests::wall_cost`: removed. Replaced by `wall_bound`.
- `scripts/tests::wall_bound`: new. Computes the round's lower bound on wall time under the form:
  - `recommended`: max(longest group's total, all tests' total / workers).
  - `groups-side-by-side`: isolated tests' seconds / workers + max(longest group's total, held tests' total / workers).
  - `groups-one-at-a-time`: isolated tests' seconds / workers + the sum of every group's seconds.
- `scripts/tests::ranked_slowest`: changed. A test's cost is the bound minus the bound with that test's seconds set to zero.
- `scripts/tests::round_ranked`, `round_slowest`, `slowest_recorded`: changed. They pass the form.
- `scripts/tests::tested_round`: changed. `workers` is the budget's workers for every run (it was 1 for `--only` and `--from`). The header kind is `rerun` unless the run is whole.
- `scripts/tests::cmd_run`: changed. `recorded = bool(sprint) and not args.from_file`. Whole runs take the whole-round lock; every run takes `resource_locks`.
- `scripts/tests::round_lock`: removed. Replaced by `whole_round_lock` (refuses) and `results_lock` (short, blocking).
- `scripts/tests::resource_locks`: new context manager, with the run registry.
- `scripts/tests::results_file`, `appended_line`: changed. The one end-of-run append goes through them.
- `scripts/tests::unsettled_failures`, `cmd_failures`: changed. They also list the latest round's `schedule--` failures.
- `scripts/tests::speed_brief`: changed. The "whole seconds / divided by workers" sentence becomes the cost under the recorded schedule.
- `scripts/tests::USAGE`: changed (run, declare, failures, and the closing paragraph on resources).
- `skills/plan-tests/core.md::{{TEST-RESOURCES-RULE}}`: changed, wherever work item 3 moves it. It adds `reads` (each shared resource the test reads and does not change) and records `resources=[]` and `reads=[]` for an isolated test. It drops "Declare only what the test changes, never what it reads" and "holding each declared resource alone" in favor of the recommended rule.
- The story and runtime planner prompts' item-add lines: changed. They gain `--field 'reads=[...]'`.
- `{{TEST-PLANNER-REVIEW-PROMPT}}`: changed. It checks `reads` and sends back a declaration a cheaper design avoids.
- `{{TEST-SPEED-PROMPT}}`: changed. The paragraph on "whole seconds / divided by workers" becomes the cost under the schedule.
- The scenario-list writer (`cmd_stamp`, or work item 7's archive writer): changed. It writes `reads`.
- The `schedule--` route in `skills/converge/prompts/merge.md` and `skills/converge/SKILL.md` lands in item 7's stage, which owns both files.

**Improvements**
- **I3** `scripts/tests::tested_round`: A7 and A9. If the after-count of leftovers raises after the suite has run, the whole round is lost under end-of-run append. Afterward: the round is appended in `finally`, its close line records `error`, and the error is re-raised.

**Behavior changes**
- **B1** `scripts/tests::tested_round`.
  Before: `--only` ran with 1 worker.
  After: it runs with the budget's workers.
  Users: in the release: the write, fix, and verify prompts. Across Trued-up projects: each project's suite command, which receives the same JSON shape with a different `workers` value it already accepts.
  Ruling: rewrite.
- **B2** `scripts/tests::cmd_run`.
  Before: `--only --sprint` recorded nothing.
  After: it appends a `rerun` round.
  Users: in the release: the write, fix, and verify prompts' "runs it without recording a round", and every reader that assumed the latest round is whole (`speed_refusal`, which must read the latest closed whole round instead).
  Ruling: rewrite.
- **B3** `scripts/tests::round_lock`.
  Before: any second recorded run of a sprint refused.
  After: only a second whole round refuses; reruns run beside it or wait on resource locks.
  Users: in the release: the fix and verify prompts and certification's reruns (work item 7).
  Ruling: rewrite.
- **B4** `scripts/tests::tested_round` and `results_file`.
  Before: lines were appended to `-results.jsonl` as they landed, so a killed run kept its lines.
  After: the round is appended whole at the end, so a crashed run loses its own lines.
  Users: in the release: `results_rounds` readers.
  Ruling: rewrite.
- **B5** `scripts/tests::ranked_slowest`.
  Before: a held test cost its whole seconds and an isolated test its seconds divided by the workers.
  After: cost is the drop in the schedule's bound.
  Users: in the release: the `tests run` printout, `round_ranked`, `slowest_recorded` (planning's slow touches), `speed_brief`, and the speed prompt.
  Ruling: rewrite.
- **B6** `scripts/tests::run_suite`.
  Before: the `{tests}` JSON held path, name, and resources.
  After: it also holds `reads`.
  Users: across Trued-up projects: each project's suite command; the key is additive.
  Ruling: preserve (call).
- **B7** `scripts/tests::unsettled_failures`.
  Before: no schedule check.
  After: once `testing.schedule.said` holds the owner's words, a forbidden pair fails the round.
  Users: in the release: `tests failures` and certification's find (work item 7). Across Trued-up projects: projects whose `said` is null see no change.
  Ruling: migrate: the check runs only after the owner records words through `/ok-setup` (call).
- **B8** `scripts/tests::cmd_run`.
  Before: an unrecorded run ran beside anything.
  After: a run that declares resources waits for conflicting locks and prints one line naming the holder.
  Users: in the release: every `tests run` caller.
  Ruling: rewrite.
- **B9** `scripts/tests::testing_config`.
  Before: no `testing.schedule` key existed.
  After: it is required, and the tool refuses its absence.
  Users: across Trued-up projects: every project's config.
  Ruling: migrate: true-up writes `{"form": "groups-one-at-a-time", "said": null}` where it is absent, and files the question (work item 17) (call).
- **B10** `scripts/plumbline::testingDefects`.
  Before: `testing.schedule` was an unknown-key defect.
  After: it is validated.
  Users: in the release: the `config-check` callers.
  Ruling: rewrite.
- **B11** `{{TEST-RESOURCES-RULE}}`.
  Before: planners declared only changed resources.
  After: they declare `reads` as well.
  Users: in the release: the planners and the planner review.
  Ruling: rewrite.

**New surface**
- `tests declare --schedule` and `--schedule-said`, the `testing.schedule` key, and the `reads` field: internal.

### 9. Reruns and coverage

**Calls**
- **Standing result.** Per live scenario, the latest result across rounds from the latest closed whole round onward, that round included. Each result carries the blobs of its round's header. Decided by: decision fixes-rerun-the-tests-they-reach.
- **The header** records blobs for the test paths and for every planned test's support files. Before, it recorded test paths only. Decided by: work item 9 ("digests of its test file and support files").
- **`not run`.** A stopped round records each unreached test as `{"passed": false, "not_run": true, "seconds": null}`. A new helper, `failed(result)`, excludes `not_run` from every failure reader.
  - `--failing` skips `not run`.
  - `--changed` reruns a `not run` test, since it has no run at its current files.
  - A round that ran to its end and never reported a planned test still records that test as failed.
  - Decided by: work item 9.
- **`--failing`** reruns standing failures that no held promise and no owner issue settles. It never reruns `leftovers--`, `schedule--`, or `perf:` entries. Decided by: work item 9.
- **`reaches`.**
  - Entries are a list of non-empty paths relative to the project root. An entry ending in `/` is a folder.
  - A `reaches` value of the wrong type is dropped with a printed note, and the result stands.
  - The latest run of a test replaces its list; a run that carries none leaves the test with no record.
  - Across sprints, the map comes from `test-state.json`'s `reaches`, overlaid by this sprint's results.
  - Decided by: work item 9 ("every run of a test replaces it"; "no record means rerun").
- **`testing.reaches.form`.** `files` and `folders` behave alike in the tool; only `none` changes the rerun rule. Decided by: work item 9 ("These rules hold where `testing.reaches` names `files` or `folders`").
- **New read-only verb `tests reached --sprint <path> --files <path> ...`.** It prints the scenario ids a fix reruns:
  - every test whose `reaches` names a changed file or a folder above one;
  - every test with no `reaches`;
  - every test, where a changed file is named by no test's `reaches`;
  - under `none`, nothing, with a line saying to rerun the fix's own tests.
  - It adds no fifth selector to `tests run`. Work item 7's verifier runs `tests run --only` over its output. Decided by: work item 9's four exclusive selectors.
- **`test_paths` moves** from `scripts/tests` to `scripts/review`, which `tests` already loads. That lets `review certified` (work item 14) use it without a cycle. Decided by: plumbline-coding rule 6.

**Changes**
- `scripts/tests::results_rounds`: changed. Keeps `not_run`, `arrived`, and `reaches` on results.
- `scripts/tests::standing_results`, `failed`: new.
- `scripts/tests::unreported`, `round_results`: changed. A stopped round gives `not run`.
- `scripts/tests::unsettled_failures`: changed. It lists:
  - standing failures since the latest closed whole round, not settled;
  - the latest round's `leftovers--` and `schedule--` entries;
  - `perf:` entries (work item 10).
- `scripts/tests::failing_targets`: changed. Standing failures.
- `scripts/tests::changed_targets`: new. Each live test whose test file or support blobs differ from those of its latest result, or that has no result since the latest closed whole round. It refuses when none, naming the whole suite.
- `scripts/tests::main`: changed. Refuses more than one of `--only`, `--from`, `--failing`, `--changed`, and refuses `--changed` without `--sprint`.
- `scripts/tests::build_parser` (run): changed. Adds `--changed`.
- `scripts/tests::take_line`: changed. Parses `reaches`.
- `scripts/tests::test_file_hashes`: changed into `run_blobs(root, folders, targets)`, which covers the support files too.
- `scripts/tests::reaches_map`, `cmd_reached`: new, with a parser entry.
- `scripts/tests::testing_config`, `declared_values`, `cmd_declare`: changed. Require and read `testing.reaches`; declare gains `--reaches <files|folders|none>` and `--reaches-said <words>`.
- `scripts/plumbline::testingDefects`, `TESTING_KEYS`: changed. Validate `reaches`.
- `scripts/tests::late_tasks`: changed to `late_tasks(root, tasks, entry)`. Counts a closed changing task, by item 7's `CHANGING_ROLES` over the sprint run and the certification ledger, only where `set(staged) - review.test_paths(staged)` is non-empty. Callers: `speed_refusal` and `tests settled`.
- `scripts/review::test_paths`: new (moved). `scripts/tests::test_paths` is removed and its call sites repointed: `test_file_hashes` (now `run_blobs`), `stray_paths`, and `late_tasks`. Its other callers, `window_entry` and `complete_failures`, retire with items 3 and 1.
- `scripts/tests::stray_paths`: changed. Skips every path in `plan.get("kept")` and `read_state(root)["kept"]`.
- `scripts/tests::USAGE`: changed.
- The write, fix, and verify prompts, wherever work items 6 and 7 place them: changed. "`--only <id>` runs it without recording a round" becomes "records a rerun round".

**Behavior changes**
- **B12** `scripts/tests::failing_targets`.
  Before: reran the latest round's failures.
  After: reruns every standing failure.
  Users: in the release: the fix loop (work item 7).
  Ruling: rewrite.
- **B13** `scripts/tests::unreported`.
  Before: a stopped round's unreached tests failed, and a fixer was filed for each.
  After: they are `not run`, and no fixer is filed.
  Users: in the release: `unsettled_failures` and work item 7's `tests reports`.
  Ruling: rewrite.
- **B14** `scripts/tests::tested_round` header.
  Before: `test_files` held test paths only.
  After: it also holds support files.
  Users: in the release: `changed_targets`.
  Ruling: rewrite.
- **B15** `scripts/tests::late_tasks`.
  Before: any closed changing task after the round was late.
  After: only one that staged a file outside the test paths.
  Users: in the release: `speed_refusal`, and work item 7's `tests settled` and `review certified`.
  Ruling: rewrite.
- **B16** `scripts/tests::stray_paths`.
  Before: counted kept files as strays, so the sweep could delete a kept legacy file (an A2 harm).
  After: skips them.
  Users: in the release: `tests stray`, `stage_sweep`, and `review certified`'s stray check (item 14).
  Ruling: rewrite.
- **B17** `scripts/tests::testing_config`.
  Before: no `testing.reaches` key existed.
  After: it is required.
  Users: across Trued-up projects: every project's config.
  Ruling: migrate: true-up writes `{"form": "none", "said": null}` and files the coverage question (work item 17) (call).
- **B18** `scripts/tests::take_line`.
  Before: a result line carried path, name, passed, seconds, and output.
  After: it may also carry `reaches`.
  Users: across Trued-up projects: the project's suite commands, which write nothing new and keep working.
  Ruling: preserve (call).

**New surface**
- `tests run --changed`, `tests reached`, `tests declare --reaches` and `--reaches-said`, and the `testing.reaches` key: internal.

### 10. Speed records

**Calls**
- **The speed digest** becomes the git blob of the test file alone, and the speed task key becomes `speed:<sid>:<blob>`. Decided by: work item 10 ("hold until the test's own file changes").
- **An acceptance** records three values: the test blob (`digest`), a support digest (sha256 over the blobs of the support files, the way today's digest is built), and the median seconds at acceptance (`seconds`). The tool computes them and puts them in the brief, and the reviewer copies them, as it copies digest and seconds today. Decided by: work item 10.
- **Unreviewed again.** A test counts as unreviewed where its test blob differs from the acceptance's, or where the support digest differs and the current median exceeds the accepted seconds. Decided by: work item 10.
- **The median** is `statistics.median` over the passing results of closed whole rounds whose header blob for the test path equals the current blob, plus the `test-state.json` values carried at that blob. Failing results are excluded, since they measure a different path. Decided by: work item 10.
- **`test-state.json` layout, for work item 7's archive writer.**
  - `ranking`: a list sorted by cost, each entry `{scenario, blob, seconds: [...], median, cost}`. One structure holds both the ranking and the values the next median needs.
  - `acceptances`: `{sid: {blob, support, seconds}}`.
  - `read_state` defaults both to empty.
  - Decided by: decision scenario-list-decided-once (the list records the ranking and the acceptances) and DRY.
- **`product-slow`.**
  - It is a `speed` pool state, with fields `site` (`path::function`), `does`, `grows`, `cheaper`, and `seconds`.
  - `tests failures` lists the latest product-slow verdict per scenario as `perf:<scenario>:<speed item>`, until a fix item naming it (`perf=<speed item>`) is accepted.
  - The test is then unreviewed again.
  - It is never an acceptance.
  - Decided by: work item 10, and the shape of the hand-made linescout version.
- **A send-back settles** when the latest speed item is `sent-back` and the scenario's latest `tests` item is `accepted` with a later `created`. Decided by: work item 10 ("A send-back settles when the verifier accepts the rewrite").
- **The seed** gets no tool code and no config key. A seed entry is a project file listed as a scenario's support, and the project's `testing.setup` builds and reuses it. Decided by: work item 10 ("recommended, not required… A project may have none").
- **No speed floor.** No code path reads a time threshold, and the selection takes the top `testing.slowest` unsettled tests. Decided by: work item 10.
- `tests convert-state [--clear <story>...] [--dry-run]` converts `test-state.json` from the earlier form, which it detects by a top-level `stamp`. It writes, for each story with recorded scenarios, the blob id of the story's file at that commit as the story's stamp, and no stamp where the commit is gone. It drops the top-level `stamp`, writes empty `ranking`, `acceptances`, and `reaches`, and keeps `kept`. `--clear` writes no stamp for each story it names. It never calls `testing_config`, because true-up runs it before `testing.enabled` exists. Item 17's D2 depends on it. Decided by: notes review.
- Build note: `cmd_scenarios` prints the per-story stamps of the converted form, and `ranking[].seconds` keeps at most the latest `testing.slowest` values per test. Decided by: notes review.

**Changes**
- `scripts/tests::test_digest`: removed. Replaced by `test_blob(root, entry)` and `support_digest(root, entry)`.
- `scripts/tests::median_seconds`: new. `@story: suite-gets-faster-over-time` goes here.
- `scripts/tests::speed_accepted`: removed. Replaced by `speed_settled(items, records, fixes, state, sid, blob, support, median)`, covering acceptance, reopening, product-slow, and settled send-backs.
- `scripts/tests::speed_sent_back`: changed. Includes `product-slow`.
- `scripts/tests::speed_ranking`: new. Medians, charged by the schedule's bound (work item 8).
- `scripts/tests::speed_candidates(root, sprint, source)`: new. The top `testing.slowest` unsettled tests, from either `test-state.json`'s ranking (`--from state`, work item 6's build-stage speed task) or the failed whole round `--round <n>` names (work item 7). It replaces `speed_walk`'s batch walk, which work item 7 retires. `stage_speed` calls it.
- `scripts/tests::cmd_slowest`: new read-only verb, `tests slowest --sprint <path> (--from state | --round <n>) [--json]`. It refuses neither and both. It prints those candidates with the brief fields (blob, support digest, median, cost, rank), so the session and certification can file speed tasks from it.
- `scripts/tests::speed_brief`: changed. Names the blob, the support digest, the median and its round count, and the cost. Under `--from state` it names no round number.
- `scripts/tests::unsettled_failures`, `cmd_failures`: changed. They list `perf:` entries.
- `scripts/tests::read_state`: changed. `setdefault("ranking", [])` and `setdefault("acceptances", {})`.
- `scripts/tests::cmd_convert_state` (the `convert-state [--clear <story>...] [--dry-run]` verb): new, with a parser entry and USAGE text.
  - It reads `test-state.json` with `read_json`, never through `testing_config`, and says whether the file is in the earlier form, by its top-level `stamp`.
  - It finds each story with recorded scenarios from the scenarios' `story:<slug>` sources, through `STORY_SOURCE`, and writes the blob id of `.ok-planner/design/stories/<slug>.md` at the `stamp` commit. It writes no stamp where `git cat-file -e` fails or the file is absent at that commit, and none for a story `--clear` names.
  - It drops the top-level `stamp`, writes empty `ranking`, `acceptances`, and `reaches`, and keeps `kept` and every other field.
  - `--dry-run` prints the converted file and writes nothing. Otherwise it writes through `write_json`, an atomic replace.
- `scripts/tests::cmd_scenarios`: changed. It prints each story's stamp in the converted form.
- `{{TEST-SPEED-PROMPT}}`: changed. It adds:
  - the product-slow verdict, naming the site, what it does, how its cost grows, and the cheaper behavior, with the larger verdict recorded where the test also wastes time of its own;
  - its record line (`--state product-slow --field site=... --field does=... --field grows=... --field cheaper=...`);
  - the seed entry as a cheaper form, with the objects it must hold;
  - recording the support digest and seconds the brief names.
- `{{TEST-SUPPORT-PROMPT}}`: changed. A `seed` support item adds an entry whose objects carry seed-only names, and the support code refuses to change or remove a seeded object.
- The fix and verify prompts for `perf:` (work item 7's): the fixer notes the test's seconds, changes the site so it does only the work its answer uses, and runs `tests reached --files <the site's file>`. The verifier sends back a fix that leaves the slow work, drops a promised outcome, or fails a test that reaches the site.

**Behavior changes**
- **B19** `scripts/tests::speed_accepted` → `speed_settled`.
  Before: any support change cleared every acceptance.
  After: only the test file's change clears one; a support change reopens a test only if its median rose.
  Users: in the release: speed selection, speed task keys, and `speed_failures`.
  Ruling: rewrite.
- **B20** `scripts/tests::round_ranked` → `speed_ranking`.
  Before: one round's seconds.
  After: the median across rounds at the current blob.
  Users: in the release: speed selection.
  Ruling: rewrite.
- **B21** `{{TEST-SPEED-PROMPT}}` and `unsettled_failures`.
  Before: two verdicts.
  After: a third, product-slow, which shows up as a `perf:` failure.
  Users: in the release: work item 7's find.
  Ruling: rewrite.
- **B22** `scripts/tests::speed_settled`.
  Before: a send-back needed a new acceptance at the rewritten digest.
  After: it settles when the verifier accepts the rewrite.
  Users: in the release: speed selection.
  Ruling: rewrite.
- **B227** `scripts/tests::cmd_convert_state` (`tests convert-state`). Before: no verb converts `test-state.json`, and every reader reads the one top-level `stamp`. After: the verb rewrites the earlier form into per-story stamps with empty `ranking`, `acceptances`, and `reaches`.
  Users: in the release: `admin/true-up::rewrite_plan` (item 17, D2). Across stored state: `test-state.json`.
  Ruling: migrate, as B208 (call).

**New surface**
- `tests slowest`, `tests convert-state`, the `product-slow` state, and the `ranking` and `acceptances` fields: internal.

### 11. Test tasks and support

**Calls**
- **The `support` pool.** Fields `path`, `scenario`, and `change` (one of `missing`, `changed`, `fixture`, `seed`). States `open` and `made`; `added` no longer fits a changed helper. The cite prefix is `support-item:`, replacing `helpers:`. Decided by: work item 11.
- **After-list refusal.** Before it files or refiles any task, `stage_write` refuses where the task's `after` names a task that closed other than `done`, naming that task and its outcome. Decided by: work item 11.
- **Declaration changes.** A `tests` item's `resources` and `reads` stand as recorded, additions included. The verify brief names the before and after values. The verifier records each addition as a call in the run's `divergences` pool (`--field kind=call`), which the default calls selector shows at the veto. Decided by: work item 11 and the tracker's `DEFAULT_CALLS`.
- **Plan text.** A `tests` item may carry `reach`, `entry`, `waits`, `kind`, and `setup`, which replace the plan's. It never carries `text`, the outcome; a changed outcome stays a promise. Decided by: work item 11, and `{{TEST-SCENARIO-DEFINITION}}` ("A scenario's text states the outcome").

**Changes**
- `scripts/tests::HELPERS_CITE`, `cited_helpers`, `helper_path`, `support_brief`, `stage_support`, `blocked_on_helpers`: changed. The pool is `support`, with its fields.
- `scripts/tests::write_refusals`: changed.
  - "Closed blocked twice" refuses only where neither of the two blocked tasks filed a `support` item.
  - It adds the after-list refusal.
- `scripts/tests::refiled_tests`: changed. A sent-back rewrite's `files` holds its test file plus `support_of(plan, s)`, `s.support`, and the record's support. Two rewrites that share a file chain through `holders`.
- `scripts/tests::kept_resources`: removed. Replaced by `recorded_declarations`.
- `scripts/tests::live_tests`: changed. It takes `resources`, `reads`, and the plan-text fields from the record.
- `scripts/tests::test_verify_brief`: changed. Lists the declaration and plan-text changes.
- `scripts/tests::cmd_snapshot`: changed. `--after` records every path the `before` snapshot holds.
- `scripts/tests::cmd_diff`: unchanged. It now reads complete after-snapshots.
- `scripts/tests::USAGE`: changed. The sentence "A tests item that lists resources keeps only the planned ones…" is rewritten.
- `{{TEST-WRITE-PROMPT}}`: changed. The `support` pool item replaces the `helpers` item; a rewrite may change the support files it holds; the record may change declarations and plan text, never the outcome.
- `{{TEST-SUPPORT-PROMPT}}`: changed. The four kinds of support item, `made`, and seed entries.
- `{{TEST-VERIFY-PROMPT}}`: changed. Judges each declaration change against the waste "a shared resource declared where a cheaper design keeps the test isolated", records each addition as a call, and holds or rejects a changed outcome as a promise.
- The run's `item_states` line: changed. `"support": ["open", "made"]` replaces `helpers`, and `speed` gains `product-slow` (work item 6 owns the run opener).

**Behavior changes**
- **B23** `scripts/tests::stage_support` and the prompts.
  Before: a `helpers` pool for missing helpers only.
  After: a `support` pool for four kinds of change.
  Users: in the release: the write and support prompts and the run opener.
  Ruling: rewrite.
- **B24** `scripts/tests::write_refusals`.
  Before: two blocked closes always refused.
  After: only where neither named a support item.
  Users: in the release: the write stage's caller.
  Ruling: rewrite.
- **B25** `scripts/tests::refiled_tests`.
  Before: a rewrite held its test file only.
  After: it holds its support files too, and chains with other rewrites that share them.
  Users: in the release: the drain order.
  Ruling: rewrite.
- **B26** `scripts/tests::kept_resources`.
  Before: a recorded declaration that the plan lacked was silently dropped.
  After: additions stand and become calls.
  Users: in the release: `live_tests`, the suite JSON, and the stamp.
  Ruling: rewrite.
- **B27** `scripts/tests::stage_write`.
  Before: it refiled tasks behind a dependency that closed short of `done`, so the stage looped.
  After: it refuses and names that task.
  Users: in the release: the session.
  Ruling: rewrite.
- **B28** `scripts/tests::cmd_snapshot` and `cmd_diff`.
  Before: an unchanged file showed as deleted.
  After: it shows no change.
  Users: in the release: verifiers.
  Ruling: rewrite.

### 12. The task tracker

**Calls**
- **Field types.** A run config key `field_types`, `{"<pool>": {"<field>": "integer|number|boolean|list|object|text"}}`, set with `tasks config set` and validated the way `call_selectors` validates `calls`.
  - A declared type parses the value or fails, naming the field and the type.
  - The tracker declares task fields `after`, `files`, and `cites` as lists, so `task set --field after=t4647` is a list of one.
  - The run openers declare `{"tests": {"silence": "integer"}, "speed": {"seconds": "number", "rank": "integer"}}`. Those are the pools whose code readers need numbers. `review`'s `int()` already reads text counts.
  - Decided by: work item 12 and plumbline-coding rule 7.3.
- **One parser.** `parse_fields` serves `item add`, `item set`, `task set`, and `config set`. Every `config set` value the suite writes opens with `[` or `{`, so it parses as before. Decided by: the cheatsheet's uniformity rule.
- **Claim order.** The count is open tasks that wait on the candidate through `after`, transitively. Ties go to filing order (the store's first-line order, as today). Decided by: work item 12.
- **`tasks close`** writes the close first, then prints `step(run)`'s lines, which issues every ready task, as `next` does. A missing profile file then fails after the `closed` line, exactly as `next` fails. `tasks exec` does the same. Decided by: work items 12 and 13.
- The planning run's opener (item 3) and `/ok-setup`'s run opener (item 2) declare `field_types` `{"budget": {"workers": "integer"}}`. Decided by: notes review.
- Build note: `next_claim` keeps `oldest_issued`'s exclusion of `fork_of` tasks, and `parse_fields` also serves `--where` in `grouped_batch`. Decided by: notes review.

**Changes**
- `scripts/tasks::parse_fields(pairs, types)`: changed. The value is text unless it opens with `[`, `{`, or `"`, or the pool or the task declares the field's type.
- `scripts/tasks::cmd_item` (add and set), `cmd_task`, `cmd_config`: changed. They pass types; `cmd_config` validates `field_types`.
- `scripts/tasks::oldest_issued`: removed. Replaced by `next_claim(run, agent)`.
- `scripts/tasks::cmd_claim`: changed. Uses `next_claim`.
- `scripts/tasks::cmd_close`: changed. Prints step lines after `closed`.
- `scripts/tasks::cmd_exec`: changed. Prints step lines after `closed`.
- `scripts/tasks::cmd_refile`: changed. Before any write, it fails where the refile's `after` closure reaches any open waiter of the source, the cycle `check_dependencies` names.
- `scripts/tasks::USAGE`: changed (claim, close, refile, the `--field` rule, `field_types`).
- `agents/ok-opus.md`, `agents/ok-haiku.md`, `agents/ok-review.md`: changed. "takes the oldest issued task" becomes "takes the issued task of your profile the most tasks wait on".
- `scripts/ok-planner-cheatsheet.md` (around line 407) and `skills/_tasks/drain.md` (lines 5 and 224): changed. The claim order.
- `skills/plan-sprint/SKILL.md` (the planning run's opener) and `skills/ok-setup/SKILL.md` (its run opener): changed. Each runs `tasks config set field_types '{"budget": {"workers": "integer"}}'`.

**Improvements**
- **I1** `scripts/tasks::cmd_refile`: A1. The refile, its event, and each waiter's new `after` list are separate writes today, so a crash between them leaves waiters that can run before the refile. Afterward: one `put_many`.
- **I2** `scripts/tasks::cmd_close`: A1. The settled items, the closed task, and the event are separate writes today. Afterward: one `put_many`.

**Behavior changes**
- **B29** `scripts/tasks::parse_fields`.
  Before: `--field round=3` stored a number, and `digest=104957870728e435` became a float overflow.
  After: plain text, unless the field's type is declared.
  Users: in the release: every prompt that writes numeric or boolean fields; `tests::declared_silence` (covered by the `tests.silence` declaration); the budget planner's `workers` field, read by `planned_budget` and `budget_failures` (covered by the `budget.workers` declaration in the planning run's opener, item 3, and `/ok-setup`'s run opener, item 2); `review`'s `int()` readers (read text); the `docs` and `tests` truthy readers of `"true"` (unchanged). Across Trued-up projects: run logs written earlier keep their stored values, and every reader accepts both.
  Ruling: rewrite.
- **B30** `scripts/tasks::cmd_claim`.
  Before: the oldest issued task.
  After: the task the most tasks wait on.
  Users: in the release: every drain and the three profiles.
  Ruling: rewrite.
- **B31** `scripts/tasks::cmd_close`.
  Before: printed one line.
  After: issues ready tasks and prints the `next` lines.
  Users: in the release: the profiles, the drain script, and the hand loop. No script parses close output.
  Ruling: rewrite.
- **B32** `scripts/tasks::cmd_exec`.
  Before: output and a `closed` line.
  After: the same, plus the `next` lines.
  Users: in the release: the drain script.
  Ruling: rewrite.
- **B33** `scripts/tasks::cmd_refile`.
  Before: wrote a cyclic chain, so `next` waited forever (an A5 harm).
  After: refuses.
  Users: in the release: the session and the `tests` stages.
  Ruling: rewrite.
- **B34** `scripts/tasks::cmd_task`.
  Before: `--field after=t1` was iterated character by character.
  After: a list of one.
  Users: in the release: the session.
  Ruling: rewrite.

**New surface**
- The `field_types` run config key: internal.

### 13. The drain reads the next work from each close

**Calls**
- **The ok-review root.** After its forks return, the review root runs `tasks next`. Its final text is its own `closed` line followed by that output. Its first close printed lines from before the forks ran, and reading those would make the script retry forks that are already closed. Decided by: work item 13 and decision team-execution-cold-gate (the root closes before it forks).
- **Exec returns.** For an exec, the script parses `result.output`, and `CLOSED_LINE` accepts `failed`. Decided by: work item 13 ("reads the closed line and the run, exec, waiting, and done lines").

**Changes**
- `skills/_tasks/drain.md`, the Workflow script: changed.
  - `collect()` returns the parsed lines of a return that carries a `closed` line.
  - `drain()` calls `next()` only for the first fill and after a return with no `closed` line.
  - `parse` and `stuck` are unchanged.
  - The return text describes this.
- `skills/_tasks/drain.md`, "The loop" steps 1–3: changed. The hand form reads the same lines and runs `next` only in those two cases.
- `agents/ok-opus.md`, `agents/ok-haiku.md`: changed. "Your final text is the whole output of `tasks close`."
- `agents/ok-review.md` and `skills/converge/prompts/sprint-review.md` (line 46): changed, per the review-root call above.

**Behavior changes**
- **B35** The profiles.
  Before: the final message was one line.
  After: it is the close output.
  Users: in the release: the drain script and the hand loop. Usage stamping still reads the `closed` line.
  Ruling: rewrite.
- **B36** The drain script.
  Before: a step agent ran `next` after every return.
  After: only on the first fill and after a return with no `closed` line, which costs fewer agents against the lifetime cap.
  Users: in the release: sprint execution, `/converge`, and `/triage-issues`.
  Ruling: rewrite.

### 14. Test paths during a sprint

**Calls**
- **The mark file.** `review certified` writes `<sprint>-certified.txt` on SPRINT COMPLETE and removes it on SPRINT NOT COMPLETE, for sprints under `.ok-planner/sprints/`. The lint's window is a sprint with `-base.txt` and `.md` and no `-certified.txt`. Decided by: the sibling shape, the `-complete.txt` mark `tests complete` writes.
- **Code tasks.** A code task is a sprint-run task with role `build`, or a ledger task with role `fix` or work item 22's restorer role. Decided by: work item 14.
- **The stray check.** `review certified` gets strays from a `bin/tests stray --sprint <path> --json` subprocess, since `tests` loads `review`. Decided by: plumbline-coding rule 6, and `review`'s existing subprocess calls to `bin/tasks` and the lint.
- plumbline's `TESTING_KEYS` and validators gain `enabled` (`on`, `frozen`, or `off`) and `offers` (a list drawn from `untested`, `stale`, `legacy`, and `runtime`), so the config true-up writes passes `plumbline config-check`. Decided by: notes review.
- Every stage that edits the sprint template's execution or contract sections appends the lines it removes, sorted, to `admin/retired-boilerplate.json`. Decided by: notes review.

**Changes**
- `scripts/plumbline::openTestSprint`: changed into `openSprintWindow`. It reads `.ok-planner/sprints/` and only opens where `testing.enabled` is `on` or `frozen`. It no longer reads `test-sprints/`, which work item 17 empties.
- `scripts/plumbline::loadConfig`: changed. The `testSprintOpen` field is renamed `testWindowOpen`.
- `scripts/plumbline::unsetLintKeys`: changed. Adds `testing.enabled`.
- `scripts/plumbline::TESTING_KEYS`, `TESTING_SETTINGS`, `testingDefects`: changed. They accept `enabled` and `offers`. `enabled` must be `on`, `frozen`, or `off`; `offers` must be a list whose members are drawn from `untested`, `stale`, `legacy`, and `runtime`. A `testing` object that holds only `enabled` passes (D1).
- `scripts/plumbline::checkNoTests`: changed. The message says a test is changed only in a sprint's test stages.
- `scripts/review::cmd_certified`: changed. Where testing is `on` or `frozen`, it adds a failure for each test path a code task staged and for each stray, and it writes or removes the mark.
- `skills/plan-sprint/sprint-document.md`, archive step 2: changed. It moves `-certified.txt`.
- `admin/retired-boilerplate.json`: changed. It gains the archive step 2 line removed above, sorted.
- `admin/ADMINISTRATION.md` (lines 224 and 324): changed. "The lint reads every key but `testing`" becomes the lint also reading `testing.enabled`.

**Behavior changes**
- **B37** `scripts/plumbline::checkNoTests`.
  Before: the window was an open test sprint.
  After: it is an uncertified sprint, under `on` or `frozen`.
  Users: in the release: the edit hook and review checks. Nothing across a boundary: a test sprint still open is moved by true-up (work item 17).
  Ruling: rewrite.
- **B38** `scripts/plumbline::unsetLintKeys`.
  Before: `testing.enabled` was not read.
  After: its absence is refused.
  Users: across Trued-up projects: every project's config.
  Ruling: migrate: true-up writes it (work item 17) (call).
- **B39** `scripts/review::cmd_certified`.
  Before: none of these checks, and no mark.
  After: new refusals and a mark file.
  Users: in the release: sprint execution step 13 and the lint.
  Ruling: rewrite.
- **B228** `scripts/plumbline::testingDefects`.
  Before: `testing.enabled` and `testing.offers` are unknown-key defects.
  After: each is validated.
  Users: in the release: the `config-check` callers, and the config true-up writes (item 17). Across Trued-up projects: every project's config, which true-up writes with both keys.
  Ruling: rewrite.
- **B229** `skills/plan-sprint/sprint-document.md` (archive step 2).
  Before: it moves no `-certified.txt`.
  After: it moves the mark with the sprint.
  Users: across Trued-up projects: approved sprints not yet executed.
  Ruling: migrate: the removed line goes into `admin/retired-boilerplate.json`, so true-up brings each live sprint current line for line (item 17) (call; decided by `live-sprints-brought-current-on-true-up`).

### 15. Testability coding rules

**Calls**
- The four rules are appended as rules 12–15, so no existing reference is renumbered: rule 11 is cited by `skills/plan-sprint/core.md` step 3 and by `docs/testing.md`. Decided by: plumbline-coding rule 1 (enumerate before you edit).
- Each rule names one default fix form. The reason is that accept-list A8 counts a site as a defect only where "a rule … leaves one compliant form"; with two forms open, it is a question. Rule 12 defaults to an event under the events standard at the site that settles the outcome. Rule 14 defaults to a removal through the same surface class that creates the record. Rule 13 passes the clock and outside dependencies as explicit parameters. Rule 15 prints one line per unit of work. Decided by: `review/catalog/accept.md` A8, and work item 15's "certification counts each missing feature as a defect".
- Rule 15 sets no time threshold for "long-running". A literal threshold would be a setting under rule 10, so the rule binds any command that loops over input, waits on I/O, or runs a child process. Decided by: rule 10.
- The cheatsheet lines go in a new `## Testability` section after `## Time controls`, outside every `<!-- lint-check -->` block, because they bind whether or not `no-tests` is on. Decided by: `admin/true-up::render_rules`, which drops blocks for checks that are off.
- The opening paragraph's claim "The rules come from about 870 verified defects … across 17 certification runs on two projects" stops covering every rule. It gets narrowed to rules 1–11, with no provenance claimed for 12–15. Decided by: the technical-writing standard (write literally, one claim per sentence).
- `testing.md`'s Silence section cites rule 15 as it cites rule 11. That edit is item 16's.

**Changes**
- `docs/plumbline-coding.md`: changed. It gains four rules, each with a `Prevents:` line, numbered steps, and a closing evidence step, in the file's form:
  - `## 12. Make every promised outcome observable`. Prevents a promised outcome that only private state or logs show. Steps: name, for each outcome a story you build promises, the public entry point reply, emitted event, or state read back through the public surface that shows it. Where none shows it, emit an event at the site that settles the outcome. The task note lists each outcome and what shows it.
  - `## 13. Keep each service callable on its own`. Prevents logic reachable only through the full stack. Steps: each service's logic runs through its own command, route, or exported function, with the services it does not use left out and its clock and outside dependencies passed as parameters. The note lists each service touched and its entry point.
  - `## 14. Make every created record removable`. Prevents records a request creates that no public action removes. Steps: for each kind of record or resource the product creates on request, name the public action that removes it. Where none exists, add one in the same surface class as the create. The note lists each kind and its removal.
  - `## 15. Print progress from every long-running command`. Prevents silent commands that a caller, or the tests tool's silence clock, cannot tell from a hang. Steps: every command or tool under the project's control that loops over input, waits on I/O, or runs a child process prints one line per unit of work. The note lists each command and its progress line.
- `docs/plumbline-coding.md` opening paragraph: changed, as the call above says.
- `docs/plumbline-cheatsheet.md`: changed. New `## Testability` section with one line per rule.
- `skills/_converge/coding-rules.md::{{CONVERGE-CODING-RULES}}`: changed (see I202). Builders (`skills/_sprint/shared.md:208`) and fixers (`skills/converge/prompts/fix.md:49`) are bound to rules 12–15, and the summary clause gains "make every promised outcome observable, keep each service callable alone, make every created record removable, print progress".

**Improvements**
- **I202** `skills/_converge/coding-rules.md::{{CONVERGE-CODING-RULES}}`: maintenance cost: the block lists the rules that bind (1, 3, 4, 6, 7, 9, 10, 11), so every new rule needs an edit here or it silently does not bind builders and fixers. This work item hits exactly that. Afterward: the block names the rules excluded instead: "Follow every rule in `.claude/rules/plumbline-coding.md` but rules 2 and 8, and rule 5 before you delete anything". It keeps its rule 2, rule 9.4, and no-sweep paragraphs.

**Behavior changes**
- **B200** `docs/plumbline-coding.md`. Before: 11 rules. After: rules 12–15 bind; hunters and verifiers count a breach as an A8 defect, and `admin/true-up::suite_text` (the errors rule-file draft check) also compares drafts against the new sentences.
  Users: in the release: CONVERGE-CODING-RULES, `skills/converge/prompts/hunt-file.md` A8, `skills/triage-issues/prompts/triage.md`, `admin/true-up::COVERED_RULES`. Across Trued-up projects: each project's `.claude/rules/plumbline-coding.md`, whose content is suite-owned and whose name is unchanged; existing code that lacks a feature becomes `/converge` A8 work.
  Ruling: migrate: each project takes the rules at its next `/ok`, and its existing code meets them through `/converge` A8 fixes; no file name or stored data changes (call).
- **B201** `skills/_converge/coding-rules.md::{{CONVERGE-CODING-RULES}}`. Before: builders and fixers are bound to 1, 3, 4, 6, 7, 9, 10, 11. After: to every rule but 2 and 8, so 12–15 included.
  Users: in the release: the sprint build prompt, `fix.md`.
  Ruling: rewrite.
- **B202** `docs/plumbline-cheatsheet.md` `## Testability`. Before: absent. After: four ambient lines.
  Users: in the release: every agent session (materialized rules).
  Ruling: rewrite.

### 16. The testing standard

**Calls**
- `testing.md` is rewritten to describe the fold as well, because item 1 does not list it and it is item 16's file. The intro becomes "A sprint's test planners plan by it, its test tasks write by it, and sprint certification's fixers fix by it." The old "Time per round" section (the end-of-sprint speed walk, held tests charged their whole seconds) is removed. Decided by: work item 16, plus the deltas `tests-spend-time-only-on-their-outcome` and `tests-isolated-unless-declared`.
- The seed section is written project-neutral. The linescout hand edit (diff `31374e58..64698741`) names formations and fleets; the suite text instead says "a list of entries", "digest covers its own definition and the stored-data layout files the seed names", "recommended, not required". Decided by: work item 10 and the tests-spend-time delta.
- Silence cites coding rule 15 for progress lines. Decided by: item 15.

**Changes**
- `docs/testing.md`: changed. Sections afterward:
  - The principle, and What a test waits on: unchanged.
  - The named wastes: the setup waste gains "or data the test only reads that the project's seed could hold".
  - New `## The schedule`:
    - tests are isolated by default; `resources` lists what a test changes and `reads` what it only reads; a scenario with resources and no `reads` counts as reading every resource;
    - the recommended rule, groups on one worker, and at most the budget's workers;
    - the `testing.schedule` forms `recommended`, `groups-side-by-side`, and `groups-one-at-a-time`, where a departure is a competing practice;
    - the schedule check from result-line arrival times, skipped while `said` is null;
    - per-run locks: exclusive for changed resources, shared for read ones, none for isolated runs, and a wait line.
  - New `## What a test reaches`:
    - `reaches` per result line, where a folder covers every file under it;
    - the map is kept across sprints;
    - after a fix, rerun each test whose `reaches` names a changed file or a folder above it; a test with no record reruns, and a changed file no test names reruns every test;
    - the `testing.reaches` forms, where `none` reruns only the fixed test.
  - New `## The seed`: as the call above says, with names only the seed uses, support that refuses to change them, and "a test that changes its data builds its own copy".
  - New `## A slow product`: the product-slow verdict names `path::function`, what the site does, how its cost grows, and the cheaper behavior; where the test also wastes time, the larger saving wins. A `perf:` fixer and verifier act as for a failing test; the verdict is never an acceptance, and a fresh speed read follows the fix.
  - New `## A flaky test and a test at fault`, from the `test-loop-fixes-code-never-tests` delta.
  - Silence: as today, plus the rule 15 citation.
  - New `## When speed is read`:
    - the three points: write-time verifier (brief: seconds, workers, resources changed and read); a build-stage speed task under `on`; after a failed whole-suite round;
    - the ranking: median seconds across whole-suite rounds at the current file digest, cost = how much the schedule's lower bound drops;
    - acceptances: held until the test's own file changes, re-read on a support change only where the median rose;
    - send-backs settle on the verifier's acceptance, a failed rewrite returns to its last passing version, and a passing round ends speed work.
  - Who reads for the wastes: the speed reviewer reads the tests the ranking names and records product-slow verdicts. It states no speed floor and no time budget.
- `docs/plumbline-cheatsheet.md` Tests ambient copy (the lines after `<!-- /lint-check -->`): changed.
  - The named-wastes line gains the seed clause.
  - The "Each round records…" line becomes: ranked by median, charged by the recorded schedule; read at write time, by a build-stage speed task, and after a failed round; no time budget.
  - New lines: the schedule rule with `resources`/`reads`; `reaches` and reruns after a fix; the seed (recommended); product-slow; flaky test and test at fault.

**Behavior changes**
- **B203** `docs/testing.md`. Before: describes the test sprint's speed walk and wall-cost charging. After: as above.
  Users: in the release: every prompt citing the standard (moving into the `/plan-sprint`, `_sprint/shared.md`, and `/converge` prompts under items 3/6/7). Across Trued-up projects: a stamped suite-owned file, overwritten wholesale.
  Ruling: rewrite.
- **B204** `docs/plumbline-cheatsheet.md` ambient testing lines. Before and after: as above.
  Users: in the release: every session.
  Ruling: rewrite.

### 17. True-up

**Calls**
- `plan-tests` joins `RETIRED_VENDORED`, the archived names: the suite-stamped files are removed and project-written files are archived, as for `audit` and `document`. `checks/vendored-layer` reads that tuple and reports a stamped retired skill as a note, not a failure. Decided by: ADMINISTRATION "Retired vendored verbs" and `checks/vendored-layer::payload_retired_skills`.
- A project "whose test-state.json an earlier test sprint wrote" means the file parses to an object whose top-level `stamp` is a string, or (converted form) which holds a story stamp. Only `tests stamp` writes a commit there; `rules take` can write a null-stamp file. Decided by: `scripts/tests::cmd_stamp` and `scripts/tests::read_state`.
- `testing.enabled` is written in every project. `schedule`, `reaches`, `runners`, and `setup` are written only where `testing` declares `run`, so a project with no suite command gets `{"enabled": "off"}` alone. `offers` is written where the enabled value, declared or computed, is `on`. Decided by: work item 17 together with `settings-have-no-code-defaults`: schedule and reaches describe a suite command, and `/ok-setup` writes all of them when it turns testing on.
- The two unconfirmed-key issues are filed only where `testing.enabled`, as the plan leaves it, is `on` or `frozen`. Under `off`, `/ok-setup` asks those questions when the owner turns testing on. Decided by: `testing-set-up-by-its-own-verb` and work item 2.
- Issue ids: `testing-schedule-unconfirmed`, `testing-reaches-unconfirmed`, and `test-sprint-left-open-<slugified sprint stem>`. All are kind `audit`, category `test` ("a test question needing owner calibration", artifact-definitions), with route, recommendation, and upstream null. The key issues are filed again while `said` is null and no open issue holds the id, whatever the archive holds, as every true-up filing is. The open-sprint issue is filed once, since the sprint leaves `test-sprints/`. Decided by: ADMINISTRATION's filing pattern and `admin/true-up::unfiled`.
- The coverage issue names the coverage tool from a small fixed table keyed on the first word of `testing.run` (pytest: coverage.py per-test contexts; jest and vitest: `--coverage`; go: `-coverprofile`). Otherwise it says "the coverage tool <runner> offers". The core is deterministic and cannot read the runner's docs. Decided by: work item 17 ("naming … the coverage tool the project's runner offers").
- An open test sprint (any `.md` in `.ok-planner/test-sprints/`, complete or not) is archived with every sibling file through the existing `record_folder_step` into `history/test-sprints/`, as one destructive step with the archive's suffix rule. The stories it planned come from its `-plan.json` scenarios' `story:<slug>` sources, read at plan-build time before the move. Decided by: the `live-sprints-brought-current-on-true-up` delta.
- The scenario-list conversion is a rewrite-plan record whose `after` is the carried tests tool's `--dry-run` output (D2). It is written through true-up's atomic `write_owner` with its "changed while true-up ran" guard, and `show` prints its diff. Decided by: `whole-file-ownership` ("converts the scenario list, through the tests tool") and ADMINISTRATION "Rewrites" (one rewrite per file, temp file then rename).
- The new rewrite detail for `testing.enabled` names the value and its reason ("on, since an earlier test sprint wrote .ok-planner/test-state.json"), beside the generic former-default detail. Decided by: `settings-have-no-code-defaults` ("true-up reads that state").

**Changes**
- `admin/true-up::SKILLS` and `UNPREFIXED`: changed. `plan-tests` is removed and `ok-setup` added (D4, D5).
- `admin/true-up::RETIRED_VENDORED`: changed. Adds `"plan-tests"`.
- `admin/true-up::TEST_SPRINT_BOILERPLATE`, `planned_folders`, `plan_folders_filled`, `test_plan_transforms`: removed. Their only callers go with the test-sprint entry of `LIVE_SPRINT_KINDS` (rule 1.4).
- `admin/retired-test-sprint-boilerplate.json`: removed.
- `admin/true-up::LIVE_SPRINT_KINDS` and `rewrite_plan`: changed (I200). Only documentation sprints remain beside sprints. `rewrite_plan` also adds the `.ok-planner/test-state.json` conversion record where the tool reports the earlier form, and prints a `left:` note where the file does not decode.
- `admin/true-up::TESTS_SRC`, `tests_command(args)`: new. They run the carried `scripts/tests` with `cwd=root`, as `intake_command` runs the intake module.
- `admin/true-up::open_test_sprints()` and `planned_stories(sprint)`: new. `planned_stories` uses `carried_module(TESTS_SRC).STORY_SOURCE`; an unreadable plan yields no stories, plus a note.
- `admin/true-up::test_sprint_steps(plan)`: new, called in `build_plan` before `rewrite_steps`. It runs `record_folder_step(plan, "test-sprints", "the test sprint(s) an earlier release left open, which the carried release does not run")`, keeps the src→dst pairs in the plan for the filing, and removes an empty `test-sprints/` through the empty-folder step.
- `admin/true-up::former_testing_state()`: new. Returns `on` or `off`, as the call above says.
- `admin/true-up::former_testing(config)`: new, replacing `FORMER_TESTING_SETTINGS`. It always gives `enabled`. Where `run` is declared it adds `runners: []`, `setup: null`, `schedule: {"form": "groups-one-at-a-time", "said": null}`, and `reaches: {"form": "none", "said": null}`. Where enabled is `on` it adds `offers: ["untested", "stale", "legacy", "runtime"]`.
- `admin/true-up::project_settings(config)`: changed. It always returns `dict(FORMER_PROJECT_SETTINGS, testing=former_testing(config))`.
- `admin/true-up::planned_config`, `seed_project_config`, and `resolve_question` (`citation-tags` fallback): changed. Each uses `project_settings({})` in place of the bare `FORMER_PROJECT_SETTINGS`, so a new config holds `testing.enabled: "off"` and `amend` refuses a draft that drops it.
- `admin/true-up::testing_key_issues()` and `test_sprint_issues()`: new. Their content:
  - Schedule issue: asks which schedule the suite command runs, proposes `recommended`, and names the form held now.
  - Coverage issue: names `testing.run`, the forms `files`, `folders`, and `none`, and the coverage tool.
  - Both name `/ok-setup` as where the answer is recorded, and say true-up never edits the suite command.
  - Open-sprint issue: names the sprint, its archive path, and the stories whose stamps were cleared. Options: turn testing on with `/ok-setup` and take the untested or stale groups at the next `/plan-sprint`; or leave the work archived.
- `admin/true-up::filing_steps`: changed. It files these issues after every move and conversion.
- `admin/true-up::SUBDIRS`: changed. Drops `"test-sprints"` and keeps `"history/test-sprints"`.
- `admin/true-up` (beside `RETIRED_SHARED`'s removals): changed. True-up removes the stamped `.claude/skills/converge/prompts/backout.md` from every project (item 22).
- `admin/ADMINISTRATION.md`: changed.
  - Layout folder list: drops `test-sprints/`.
  - Executables: "the test sprint's tool" becomes "the tests tool".
  - "Live sprints": drops test sprint boilerplate and plan folders; adds the open-test-sprint archive and its issue.
  - "What each kind of content becomes": new rows for an open test sprint, the scenario-list conversion, and the testing keys; the live-sprint row edited.
  - "Declare the lint config": adds `testing.enabled` (computed from `test-state.json`), `schedule`, `reaches`, `offers`, and their former values; "which `/plan-tests` declares" becomes "which `/ok-setup` declares"; the lint-reads sentence changes per D3.
  - The `testing` input row and its draft guidance: `/plan-tests` becomes `/ok-setup`.
  - The check table's "test sprint's tool" becomes "tests tool".
  - "Retired vendored verbs": `plan-tests` added to the archived names; replacement row: "`plan-tests` | `/plan-sprint` plans each sprint's tests; `/ok-setup` sets testing up".
  - New section "The test sprint retires", covering every step above.
  - "What the administration does NOT do": owner-file edits gain the testing keys and the scenario-list conversion and lose the test-plan folders; intake filings gain the three issues.

**Improvements**
- **I200** `admin/true-up::LIVE_SPRINT_KINDS` / `rewrite_plan`: maintenance cost: once the test-sprint entry goes, the `plan_suffix`/`plan_transforms` branch has no member, a dead second mechanism. Afterward: the loop handles documentation sprints alone, with no plan-file branch.

**Behavior changes**
- **B205** `/plan-tests` slash command, public under the Slash commands rule (`plugins/ok/families/ok-planner/skills/*/SKILL.md`). Before: a user types `/plan-tests`. After: the verb is gone, and true-up's report names its replacement.
  Users: in the release: `UNPREFIXED` rendering and every skill that names it (item 1). Across the public surface: users who type the verb. No compatible form reaches the outcome. `lockstep-suite-version` makes the release a major bump, but only the owner sets `rewrite across`.
  Ruling: rewrite across public surface: testing folds into every sprint, so no separate planning verb remains (owner, 2026-11-06; released as v31).
- **B206** `.claude/skills/plan-tests/` in trued-up projects. Before: vendored. After: suite-stamped files removed, project-written files archived.
  Users: Across Trued-up projects: vendored skill names.
  Ruling: migrate: the removal rule restores nothing a person wrote, and the retired-verb table names the replacement (call).
- **B207** `admin/true-up` live test sprints. Before: brought current (boilerplate, plan folders). After: archived as they stand, one intake issue each, planned stories' stamps cleared.
  Users: Across Trued-up projects: approved test sprints not yet in execution.
  Ruling: migrate: as the `live-sprints-brought-current-on-true-up` delta says, and their unwritten work returns through untested and stale offers (call).
- **B208** `.ok-planner/test-state.json`. Before: the earlier form with one stamp. After: converted through the tests tool, substance kept, story stamps derived from the old stamp commit.
  Users: Across stored state and Trued-up projects.
  Ruling: migrate: one destructive rewrite under the owner's consent; no stamp where the commit is gone (call).
- **B209** `.ok-planner/config.json` `testing.*`. Before: absent. After: written at former behavior; `said: null` marks a guess the tools read for former behavior.
  Users: in the release: `scripts/tests`, `scripts/plumbline` (D1, D3), `/ok-setup`, `amend`. Across Trued-up projects: config fields.
  Ruling: migrate: each key at its former behavior, unconfirmed values failing no check (call).
- **B210** `admin/true-up::seed_project_config`. Before: no `testing`. After: `{"enabled": "off"}`.
  Users: in the release: bootstrap.
  Ruling: rewrite.
- **B211** `admin/true-up::filing_steps`. Before: three filing kinds. After: also the two unconfirmed-key issues and the open-sprint issue.
  Users: in the release: `/triage-issues`, `/plan-sprint`, the dashboard. Across Trued-up projects: intake records, in the existing format.
  Ruling: preserve: an added record no existing reader depends on (call).
- **B212** `admin/true-up::SUBDIRS`. Before: creates `.ok-planner/test-sprints/`. After: does not, and removes the empty folder.
  Users: in the release: `scripts/tests::TEST_SPRINTS`, `scripts/plumbline` `TEST_SPRINTS`, `scripts/review` `OWNER_PATHS` (items 8–14 retire their reads).
  Ruling: rewrite.
- **B213** `admin/true-up::project_settings`. Before: `runners` and `setup` are written into any `testing` object. After: only where `run` is declared.
  Users: in the release: `amend` and the lint-config transforms.
  Ruling: rewrite.
- **B214** `admin/ADMINISTRATION.md`. Before and after: as above.
  Users: in the release: `/ok`.
  Ruling: rewrite.

**New surface**
- `/ok-setup` vendored into each project, declared in `plugins/ok/families/ok-planner/skills/ok-setup/SKILL.md` (item 2): public by the Slash commands rule.

### 18. Documentation sprints honor a docspec's Notes

**Calls**
- Where the Notes and `## Shape`, the worked example, or the writing standard disagree, the Notes decide, for writers and for the style pass. Decided by: `documentation-style-read-once` ("reorders no outline the Notes give") and artifact-definitions (Notes are the owner's standing instructions).

**Changes**
- `skills/plan-docs/core.md::{{DOC-EDIT-RULES}}`: changed. A new row goes before the cut row: "A file departs from the docspec's `## Notes`: it breaks an outline, a passage to keep verbatim, or a thing to leave out that the Notes give. | Rewrite the passage that departs." It gains the sentence "Where the Notes and the `## Shape` disagree, follow the Notes."
- `skills/plan-docs/core.md::{{DOC-PLANNER-PROMPT}}`: changed. "Judge each file against `## Reader` and `## Covers`" adds `## Notes`; step 1's fact list is replaced (I201).
- `skills/plan-docs/core.md::{{DOC-STYLE-PROMPT}}` Review: changed. Adds "Keep what the docspec's `## Notes` order: reword no passage the Notes say to keep verbatim, reorder no outline they give, and add nothing they say to leave out. Where the Notes and the shape, the worked example, or the writing standard disagree, follow the Notes."
- `skills/plan-docs/core.md::{{DOC-WRITE-PROMPT}}`: no change. It transcludes the rules, and its Read step 1 already names Notes.

**Improvements**
- **I201** `skills/plan-docs/core.md::{{DOC-PLANNER-PROMPT}}` plan step 1: maintenance cost: step 1 restates every edit rule in prose beside the transcluded table, so each new rule needs two edits (this item is one). Afterward: step 1 reads "Per file under the Where, find each rule of the edit rules above that fires and the fact that fires it", followed by the write/change/drop/left/taken sorting as it stands.

**Behavior changes**
- **B216** `skills/plan-docs/core.md::{{DOC-EDIT-RULES}}` and the planner. Before: a passage that breaks the Notes changes only where another rule fires. After: the Notes rule fires on its own, and planners name it.
  Users: in the release: the planner, writer, and fix-brief writer prompts. Across Trued-up projects: an approved documentation sprint registers the carried prompts at its execution step 3, so its writers carry the rule while its plan keeps its items. `scripts/docs` checks no rule names; it only renders the `rule` field.
  Ruling: migrate: true-up re-vendors `core.md`, and an approved documentation sprint's plan stays as written (call).
- **B217** `skills/plan-docs/core.md::{{DOC-STYLE-PROMPT}}`. Before: may reword a verbatim passage or reorder a Notes outline. After: keeps both.
  Users: in the release: style tasks. Across Trued-up projects: as B216.
  Ruling: migrate (call), as B216.

### 19. `/converge` closes the defect issues it rejects

**Calls**
- Every backlog report the merge rejects closes its issue as `answered` with the merge's note as the reason. That includes a rejection under the prose scope rule (the merge's step 1), since every rejection ends that issue's path through `/converge`, and an open one would return on every run. Decided by: work item 19 and the harm it names; `skills/converge/prompts/merge.md` steps 1–2 and "The backlog's reports".

**Changes**
- `skills/converge/prompts/owner-list.md` "Close the issues the run resolved": changed. After the `gone` and `left alone` sentences it adds: "For every other report with an `issue` field that the merge rejected, as not real, as left standing by the accept list, or as prose the prose scope rule leaves out of review, close its issue as answered with the merge's note: `issues close <the issue id> --as answered --reason "<the merge's note>"`."
- `skills/converge/prompts/owner-list.md` Close: changed. The result line becomes `closed: <n> fixed, <n> gone, <n> left alone, <n> rejected, <n> declined`.
- `scripts/ok-planner-cheatsheet.md` "Closing" and `scripts/ok-planner-CLAUDE.md` (the defect-issue close paragraph): changed. Each adds "or that the merge rejected as not real or as left standing by the accept list, with the merge's reason". The owner list reads the cheatsheet's section for how a defect issue closes.
- `skills/_shared/artifact-definitions.md` (the owner-list row of the writers table, line 386): changed. `--reason` adds "or the merge's reason for a rejected report".

**Behavior changes**
- **B218** `skills/converge/prompts/owner-list.md` "Close the issues the run resolved". Before: a backlog issue rejected as not real or standing stays open and returns every run. After: it closes as `answered` with the reason.
  Users: in the release: the intake module, `/plan-sprint` Frame's defect list, `/triage-issues`, the dashboard. Stored records keep their format.
  Ruling: rewrite.
- **B219** `skills/converge/prompts/owner-list.md` Close result. Before: four close counts. After: adds `rejected`.
  Users: in the release: the run ledger (nothing parses it).
  Ruling: rewrite.

### 20. The archive step splits large run logs

**Calls**
- **The split verb.** `tasks split <path> ...` does the split. Every reader reaches `tasks`: `issues` loads it, `review` loads `issues`, and `tests` and `docs` load `review`. Decided by: plumbline-coding rule 6.
- **Order and commit point.**
  - The split runs before the move, so the parts share the file's name and move with it.
  - Each part is written by temp-and-rename. Removing the whole file (`git rm -q --cached --ignore-unmatch` plus unlink) is the commit point.
  - A crash leaves the whole file, which readers prefer. A rerun overwrites the parts.
  - Decided by: plumbline-coding rule 3.1.
- **An oversized line.** A line longer than `archive.part_bytes` gets a part of its own, and the tool prints a note naming it. Refusing would block the owner's archive. Decided by: work item 20.
- **What gets split.** The sprint document's archive also splits its run file, its results file, and the `/converge` ledger (the ledger in place under `review/runs/`). Work item 20 names only `{{CEREMONY-ARCHIVE}}`, but the sprint's own archive lives in `sprint-document.md`, and the work item names `bin/review` as a reader. The intake's files are never split, because `bin/issues` rewrites them whole. Decided by: work item 20 (its story, certify-completion).
- **Reading parts.** A log stored in parts is read-only. The Store rebuilds its index from the parts on each open. A gap in the part numbers is refused, naming the missing part. Decided by: plumbline-coding rules 3 and 4.
- Every stage that edits the sprint template's execution or contract sections appends the lines it removes, sorted, to `admin/retired-boilerplate.json`. Decided by: notes review.

**Changes**
- `scripts/tasks::log_parts`, `log_bytes`, `cmd_split`: new, with a parser entry and USAGE text. `cmd_split` reads `archive.part_bytes` through `count`.
- `scripts/tasks::Store.__init__`, `sync`, `rebuild`, `put_many`: changed. They read parts and refuse writes to them.
- `scripts/tests::run_file`, `results_records`: changed. Parts-aware.
- `scripts/docs::cmd_report`, `complete_failures`, `cmd_stamp`: changed. Their run-existence checks are parts-aware.
- `scripts/review::certification_failures`: changed. The ledger existence check is parts-aware.
- `scripts/plumbline::CONFIG_KEY_DEFECTS`: changed. An `archive` validator for `part_bytes`.
- `admin/true-up::FORMER_PROJECT_SETTINGS`, `CONFIG_CHECK_KEYS`: changed. `"archive": {"part_bytes": 26214400}`.
- `admin/ADMINISTRATION.md` (lines 195, 222, 224, 324): changed. Adds the `archive` key and its reader.
- `skills/_sprint/shared.md::{{CEREMONY-ARCHIVE}}` step 1: changed. Run `tasks split` on each JSON Lines file first.
- `skills/plan-sprint/sprint-document.md`, archive steps 2–3: changed. Split the run file, the results file, and the ledger, then move or stage the parts.
- `admin/retired-boilerplate.json`: changed. It gains the archive step lines removed above, sorted.
- `scripts/ok-planner-CLAUDE.md`, the task tracker section: changed. One sentence on archived parts.

**Behavior changes**
- **B40** The archive steps.
  Before: whole logs.
  After: parts beside them, for logs larger than 25 MB.
  Users: in the release: `tasks`, `tests`, `docs`, and `review`. Across Trued-up projects: archived whole logs still read.
  Ruling: preserve (call).
- **B41** `scripts/tasks::cmd_split`.
  Before: no `archive.part_bytes` key existed.
  After: it is required.
  Users: across Trued-up projects: every project's config.
  Ruling: migrate: true-up writes 26214400 (call).
- **B230** `skills/plan-sprint/sprint-document.md` (archive steps 2–3).
  Before: the archive moves whole logs.
  After: it splits the run file, the results file, and the ledger first, then moves or stages the parts.
  Users: across Trued-up projects: approved sprints not yet executed.
  Ruling: migrate: the removed lines go into `admin/retired-boilerplate.json`, so true-up brings each live sprint current line for line (item 17) (call; decided by `live-sprints-brought-current-on-true-up`).

**New surface**
- `tasks split` and `archive.part_bytes`: internal.

### 21. Suggested prohibitions are explained before approval

**Calls**
- The session fills a new compliance-reviewer slot, `[STATED]`: each prohibition the owner stated, by delta and quote, and the drafter's reason for each other prohibition. The reviewer outputs a `## Suggested prohibitions` section: one entry per forbidding sentence the stated list does not hold, with its reason or "no reason recorded". A missing reason is a mechanical finding. Decided by: item 21; only the drafter knows its reasons.
- Discovery merges record each suggested prohibition in a new `prohibitions` pool, with `sentence`, `reason`, and an optional `answer`. The discovery document renders them. Decided by: item 21 and `scripts/discover::document`.

**Changes**
- `skills/_shared/artifact-definitions.md::{{DECISION-DEFINITION}}`: changed. It gains a bullet: a decision states its choice and rationale, and a prohibition the owner did not state is a suggested prohibition, which the drafter may write where it guards against a harm, giving its reason.
- `skills/_shared/design-doc-compliance-reviewer.md`: changed. It gains the `[STATED]` slot, a section on how to substitute it, and the output section.
- `skills/plan-sprint/SKILL.md`: changed.
  - §7 fills `[STATED]`.
  - §4's discovery bullet carries the discovery's suggested prohibitions into `[STATED]`.
  - §12 Approval presents one list, each prohibition with its reason. The owner keeps or drops each. A dropped prohibition leaves the delta before approval, and the delta goes back through the compliance review.
- `skills/discover-design/SKILL.md`: changed. Its `item_states` add `"prohibitions": ["open", "withdrawn"]`.
- `skills/discover-design/core.md::{{DISCOVER-MERGE-PROMPT}}`: changed. It records the `prohibitions` pool.
- `skills/discover-design/core.md::{{DISCOVER-REVIEW-PROMPT}}`: changed. It checks that every forbidding sentence in a drafted body has a record.
- `scripts/discover::assembled`, `document`: changed. They render `## Suggested prohibitions`.

**Behavior changes**
- **B130** `skills/_shared/artifact-definitions.md::{{DECISION-DEFINITION}}`. Before: no rule on prohibitions. After: the suggested-prohibition bullet.
  Users: in the release: the compliance reviewer, and the discover merge and review prompts.
  Ruling: rewrite.
- **B131** `skills/_shared/design-doc-compliance-reviewer.md`. Before: no slot and no section. After: the `[STATED]` slot and the `## Suggested prohibitions` section.
  Users: in the release: plan-sprint §7.
  Ruling: rewrite.
- **B132** `scripts/discover::document`. Before: no prohibitions section. After: a `## Suggested prohibitions` section.
  Users: across Trued-up projects: a discovery an earlier release wrote.
  Ruling: preserve: `/plan-sprint` reads a discovery with no such section as marking none. Its compliance review then lists each forbidding sentence with no reason, for the owner to keep or drop (call).

**New surface**
- None.

### 22. A stuck defect's change is restored with care

**Calls**
- The names follow the change, so no dialect of the old idiom stays:
  - the prompt `backout` becomes `restore` (`prompts/restore.md`);
  - the verb `review backouts` becomes `review restores --folder <f>`, with `review restores --verify`;
  - the role `backout` becomes `restore`.

  Decided by: the uniformity rule.
- A restoration's send-backs count in the defect field `restore_kickbacks`, against `fix.max_kickbacks`. At the limit, the defect gets `restored=stuck`, with the state the code was left in. Decided by: `converge-finds-then-fixes`.
- Build note: `review::cmd_restores` compares `restore_kickbacks` with `int()`. True-up removes the stamped `converge/prompts/backout.md` from every project, beside `RETIRED_SHARED`'s removals (item 17). `merge.md`'s "backout task" becomes "restore task". Decided by: notes review.

**Changes**
- `skills/converge/prompts/restore.md`: new. It replaces `backout.md`, and the `tangled` close is gone.
  - The restorer reads the before blobs, every change made since, and the state of every other defect.
  - It returns the code to its prior behavior by judgment, keeping each change another defect needs.
  - It walks the callers and runs the checks.
- `skills/converge/prompts/verify.md`: changed. It gains "A restoration". The verifier checks that the prior behavior is back, that every verified fix in those files still works, and that the checks pass. It then sets `restored=<task>`, or raises `restore_kickbacks`.
- `scripts/review::cmd_restores`: new, replacing `cmd_backouts`. It files one restore task for each stuck defect with no accepted restoration that is still under the limit. With `--verify`, it files one verify task per closed restore task.
- `scripts/review::VERB_HELP` and the parser: changed to match.
- `skills/converge/SKILL.md`: changed.
  - Loop 2 step 1: restore, drain, verify, and repeat.
  - The end check waits on unsettled restorations.
  - Setup step 4 registers `restore`.
  - The "What stays outside" exception names the restorer.
- `skills/converge/prompts/owner-list.md`: changed. The stuck section names the restoration's outcome and, where the restoration stuck, the state the code was left in.
- `skills/_converge/coding-rules.md::{{FIX-LINE-RULE}}` (preamble): changed.
- `scripts/ok-planner-cheatsheet.md:144,195` and `scripts/ok-planner-CLAUDE.md:634`: changed. Each describes the restoration.

**Behavior changes**
- **B133** `skills/converge/prompts/backout.md`, which becomes `restore.md`. Before: the agent removes the stuck defect's hunks, and a `tangled` partial close leaves a change a verifier rejected in the tree. After: the agent restores by judgment, a verifier checks the restoration, its send-backs are capped, and the issue names the stuck state.
  Users: in the release: `/converge` in every mode.
  Ruling: rewrite.
- **B134** `scripts/review::cmd_backouts` (the `backouts` verb). Before: the verb exists. After: `restores` replaces it.
  Users: in the release: converge SKILL.
  Ruling: rewrite.

**New surface**
- `review restores`, declared in `scripts/review`: internal.

### 23. No step of a sprint waits on a person

**Calls**
- The rule's text lives in one new block, `{{NO-PERSON-RULE}}`, in `skills/_sprint/shared.md` beside `{{OWNER-QUESTION-TEST}}`. The code planner prompt and the notes reviewer prompt paste it, and `SKILL.md` §5 cites it instead of restating it. Decided by: strict DRY (two prompts carry the same rule). `checks/token-resolution::DEFINITIONS` already lists `_sprint/*.md`, so the block resolves with no change to the check.
- An element needs a person when a builder, a fixer, or a driver can finish it only after a person acts: an owner act on the running product, a sign-in or consent a person completes, input only a real user gives, or a credential a person fetches. Planning questions and Approval are not covered, since a person is present for them, and the archive and commit after the close stay the owner's one act. Decided by: `work-items-change-the-product` as amended, which binds execution and certification.
- A stand-in sits behind configuration: the product reaches the outside party at an address its configuration sets, and the stack's configuration points that address at the stand-in. A stand-in adds no gated element and no test branch to product code. Decided by: the delta's "never the product's own code", and coding rules 10 and 11.4.
- The review facts name each stand-in in a new prose section, `## Stand-ins for outside parties`, one line per party, after `## Running the product, for the drive`. `scripts/review` parses nothing new: drivers read the facts pasted as `[PROJECT]`, as they read the `sign-in` steps. Decided by: the work item ("the stand-in the review facts name"); `review/seed/project.md` defines the facts' sections.
- A work item that needs a person is a kickback the rules decide. The session reshapes it, as a call, into the stand-in, feature, script, or seed asset that removes the step, and never drops the work. It reaches the owner only where the reshaped item changes a promise. Decided by: the owner's ruling on item 23 ("we don't want this to become an escape hatch").
- In `drive.md`, `blocked` still covers an outside party, but only one the facts name no stand-in for; such a failure keeps going to the merge's `environment` sort and the owner list. Decided by: the rejected alternative "declared undrivable" applies to planning, which now refuses that gap before execution; certification only reports what remains.
- The sprint build prompt keeps the stand-in line current, as it keeps script inputs current, and adds the heading where facts an earlier release seeded lack it. Decided by: the drive reads stand-ins only from the review facts, which are the project's own, seeded once and never overwritten (`review/CLAUDE.md`).
- `{{CEREMONY-RUN-RULES}}` (documentation sprints) stays as it stands. Decided by: the decision binds `/plan-sprint` sprints, and that block already files no task for the owner.
- Build note: the `drive-tries-each-story-as-a-user` delta body also carries item 22's rationale wording ("restores a change when one drive defect reaches its limit"); one stage applies the whole body, chained with item 22's stage or inside it. Decided by: one artifact, one delta.
- Build note: chain stages that share files with `--after`: `skills/plan-sprint/SKILL.md` (items 3, 4, 5, 12, 21); `skills/plan-sprint/core.md` (items 1, 3, 5); `skills/_sprint/shared.md` (items 1, 4, 6, 7, 20); `skills/plan-sprint/sprint-document.md` and `admin/retired-boilerplate.json` (items 3, 6, 7, 14, 20; D6); `review/CLAUDE.md` (item 1, which edits line 6); `admin/true-up` (items 17, 20); `skills/converge/prompts/owner-list.md` (items 7, 19, 22). `skills/converge/prompts/test-write.md` is new in item 6 and changed in item 11, so this stage runs after both items' stages. Decided by: the existing build notes, and the notes review.
- A failure blocked because no stand-in exists for a party outside the product is filed as a `tooling` judgment issue whose one option is the work item that builds the stand-in, not as an upstream issue. Decided by: notes review (the owner's ruling bars a filing upstream as an escape hatch; the fix is product-internal).
- Build note: the notes reviewer prompt's "One pass. Look for two things only:" (core.md:449) also gains item 3's tested-stories check; land item 23's check as one more numbered check, after item 3's stage. Decided by: notes review.

**Changes**
- `skills/_sprint/shared.md::{{NO-PERSON-RULE}}`: new. No step of a sprint's execution or certification waits on a person. The rule binds each work item, each call in the implementation notes, each line the notes have the build write into `.ok-planner/review/project.md`, and the drive of each story. An element needs a person as the call above defines. Where a story's benefit passes through a party outside the product, the sprint builds a local stand-in, which the project's stack runs, the review facts name under `## Stand-ins for outside parties`, and the drive and the tests use. A stand-in replaces only that party, never the product's own code; the product reaches the party at an address its configuration sets. A step that needs a person is never a reason to leave work out: the element is reshaped so no person is needed.
- `skills/_sprint/shared.md::{{SPRINT-BUILD-PROMPT}}`: changed. After the script-input bullet (line 168): "Where the stage builds a stand-in for a party outside the product, name it in the same stage under `## Stand-ins for outside parties` in `.ok-planner/review/project.md`, with how the stack runs it and how a driver and a test reach it; add the heading where the file lacks it."
- `skills/plan-sprint/SKILL.md` §5 Draft (line 111): changed. Its last sentence becomes: "No step of execution or sprint certification waits on a person, as `{{NO-PERSON-RULE}}` in `.claude/skills/_sprint/shared.md` says. Draft no work item that needs a person, and no work item that leaves a task for the owner to perform. Where a story's benefit passes through a party outside the product, draft the work item that builds its local stand-in. A step that needs a person never takes work out of the sprint."
- `skills/plan-sprint/SKILL.md` §10 kickback bullet (line 210): changed. A work item that needs a person joins the work item that changes no file as a kickback the rules decide, reshaped as a call into the stand-in, feature, script, or seed asset that removes the step, never dropped.
- `skills/plan-sprint/SKILL.md` §11 (line 218): changed. "It looks for unexpected behavior changes and compatibility breaks, nothing else" also names elements that need a person. A mechanical finding is fixed in the notes as a call that adds the stand-in or the reshape.
- `skills/plan-sprint/core.md::{{CODE-PLANNER-PROMPT}}`: changed.
  - It pastes `{{NO-PERSON-RULE}}` after `{{OWNER-QUESTION-TEST}}` (line 291).
  - A new per-work-item step after step 9: the planner checks each element it writes against the rule (the work item, each call, each line it has the build write into the review facts) and writes none that needs a person.
  - Where the work item's outcome passes through a party outside the product and the review facts name no stand-in for it, the planner adds to **Changes** the stand-in service, how the stack starts it, the configuration address the product reads, and the stand-in's review-facts line.
  - A work item that needs a person, where the planner does not itself add the stand-in to **Changes**, is a kickback, in the form `<work item> — needs a person — <the step; the stand-in, feature, script, or seed asset that removes it>`, written beside the `changes no file` form (lines 394-398).
- `skills/plan-sprint/core.md::{{IMPLEMENTATION-NOTES-REVIEWER-PROMPT}}`: changed. Its inputs gain `.ok-planner/review/project.md` and `{{NO-PERSON-RULE}}`. "Look for two things only" becomes three: the third is an element in the notes that needs a person (a work item, a call, or a review-facts line), and a story the sprint adds or amends that a driver cannot complete with only what the local stack gives, the stand-ins the notes build included. Such a finding is mechanical, and its fix names the stand-in or the reshape; it is judgment only under the owner question test, such as where the reshape changes a promise.
- `skills/plan-sprint/sprint-document.md::{{SPRINT-DOCUMENT-TEMPLATE}}`, boilerplate step 11 (lines 197-206): changed. "Execution and sprint certification need no owner action: file no task for the owner to perform." becomes: "No step of execution or sprint certification waits on a person: no work item, no call, no line of the review facts, and no story's drive. File no task for the owner to perform. Where a story's benefit passes through a party outside the product, the drive and the tests use the local stand-in the review facts name for it." The genuine-blocker list stays as it stands.
- `skills/plan-sprint/sprint-document.md`, the `## Work items` guidance (lines 46-49): changed. It adds: "No item needs a person during execution or certification; a story whose benefit passes through a party outside the product gets a work item that builds its local stand-in."
- `admin/retired-boilerplate.json`: changed. It gains every boilerplate line step 11's rewrap removes, sorted, as `checks/sprint-boilerplate::history_failures` requires (D6). Run the check for the exact lines.
- `skills/converge/prompts/drive.md` Setup (line 17): changed. After "Sign in with the `sign-in` steps in the facts below." it adds: "Where the story's benefit passes through a party outside the product, such as a third party's sign-in or input only a real user gives, use the stand-in the facts below name for that party under `## Stand-ins for outside parties`. Never wait on a person, and never ask one to complete a step."
- `skills/converge/prompts/drive.md`, the **blocked** outcome (line 52): changed. "(real hardware, a hosted provider)" becomes "(real hardware, or a party outside the product the facts name no stand-in for)".
- `skills/converge/prompts/test-write.md` (item 6's template, from `{{TEST-WRITE-PROMPT}}`): changed. Its Read list adds: "The `## Stand-ins for outside parties` section of `.ok-planner/review/project.md`." Its Write list adds: "Where the scenario's outcome passes through a party outside the product, reach that party through the stand-in `.ok-planner/review/project.md` names under `## Stand-ins for outside parties`, on the stack the test opens; never the real party, and no step a person performs."
- `review/seed/project.md`: changed. A new section, `## Stand-ins for outside parties`, follows `## Running the product, for the drive`, with the instruction line: "List, one line each as `` - `<party>`: <the stand-in, and how a driver and a test reach it> ``, each party outside the product a story's benefit passes through, such as a third party's sign-in or input only a real user gives, with the local stand-in the stack runs in its place. A stand-in replaces only that party, never the product's own code." Its line 3 reads: "Agents keep this file current: a sprint build that adds or changes a script input, or builds a stand-in for a party outside the product, updates it in the same stage, and a `/converge` fixer fixes a clear defect in it."
- `admin/true-up::RETIRED_PROJECT_MD_SEED_DIGESTS`: changed. It gains `140b97251687d07f9b1708985663cc8acafdd925e26282e44d5cca2a6a98e358`, the sha256 of the seed at the commit, so `seed_text` still reads an unfilled old skeleton as seeded.
- `review/CLAUDE.md:7`: changed. Its "Agents keep it current" clause reads "a sprint build that adds or changes a script input, or builds a stand-in for a party outside the product, updates it in the same stage", and its list of what `project.md` holds adds "the stand-ins the stack runs for parties outside the product".
- `skills/converge/prompts/owner-list.md` (lines 30 and 38): changed. Line 30 ends ", save a failure blocked because the story's benefit passes through a party outside the product that the facts name no stand-in for". Line 38 adds: "A failure blocked because the facts name no stand-in for a party outside the product is filed `category: tooling`; its one option is the work item that builds the stand-in, which the project's stack runs and the review facts name."
- `.ok-planner/design/decisions/work-items-change-the-product.md` and `drive-tries-each-story-as-a-user.md`: replaced with the sidecar bodies; then `python3 .ok-planner/bin/catalog-toc`.

**Behavior changes**
- **B231** `skills/plan-sprint/SKILL.md` (§5, §10, §11). Before: the no-owner-action rule binds work items alone, and the notes review looks for two things. After: the rule binds every element; a work item that needs a person is reshaped as a call, never dropped; the notes review also reports elements that need a person.
  Users: in the release: the `/plan-sprint` session. Across the public surface: owners who run `/plan-sprint`.
  Ruling: migrate: the verb accepts every invocation it accepted, and a drafted element that needs a person is reshaped into a stand-in, feature, script, or seed asset as a call the owner may veto at Approval (call; decided by the owner's ruling on item 23 and the amended `work-items-change-the-product`).
- **B232** `skills/plan-sprint/core.md::{{CODE-PLANNER-PROMPT}}`, `{{IMPLEMENTATION-NOTES-REVIEWER-PROMPT}}`. Before: the planner kicks back only an unbuildable item or one that changes no file, and the reviewer checks two things. After: the planner checks every element against `{{NO-PERSON-RULE}}`, adds stand-ins to Changes, and has the `needs a person` kickback form; the reviewer has a third check over the review facts and the stories the sprint adds or amends.
  Users: in the release: `SKILL.md` §9-§11.
  Ruling: rewrite.
- **B233** `skills/_sprint/shared.md::{{SPRINT-BUILD-PROMPT}}`. Before: a build updates `project.md` only for a script input. After: it also writes a stand-in's line, and adds the heading where it is missing.
  Users: in the release: sprint build tasks.
  Ruling: rewrite.
- **B234** `skills/plan-sprint/sprint-document.md` (boilerplate step 11). Before: "Execution and sprint certification need no owner action." After: no step waits on a person, every element is named, and the drive and the tests use the stand-in.
  Users: across Trued-up projects: approved sprints not yet executed.
  Ruling: migrate: the removed lines go into `admin/retired-boilerplate.json`, so true-up brings each live sprint current line for line (item 17) (call; decided by `live-sprints-brought-current-on-true-up`).
- **B235** `skills/converge/prompts/drive.md` (Setup, blocked). Before: a driver signs in with the `sign-in` steps and judges a story that needs a hosted provider `blocked`. After: a driver uses the stand-in the facts name for an outside party and never waits on a person; `blocked` covers an outside party only where no stand-in is named.
  Users: in the release: `/converge` drive mode and sprint certification's drive. Across Trued-up projects: review facts an earlier release seeded, which have no such heading.
  Ruling: preserve (call): facts without the section name no stand-in, so a driver acts as before. Decided by: the review facts are the project's, seeded once and never overwritten.
- **B236** `review/seed/project.md`, `admin/true-up::RETIRED_PROJECT_MD_SEED_DIGESTS`. Before: the seed has no stand-in section. After: it has one.
  Users: in the release: `admin/true-up::seed_review_facts` and `seed_text`. Across Trued-up projects: a project whose `project.md` is the unfilled old skeleton.
  Ruling: migrate: the old seed's digest joins `RETIRED_PROJECT_MD_SEED_DIGESTS`, so true-up still reads the old skeleton as seeded and asks its `review-facts` question; a filled file is left as it stands (call; decided by `admin/true-up::seed_text`).
- **B237** `skills/converge/prompts/test-write.md` (from `{{TEST-WRITE-PROMPT}}`). Before: a test task has no rule for an outside party. After: it reaches the party through the named stand-in.
  Users: in the release: the test tasks of the write stage.
  Ruling: rewrite.
- **B238** `review/CLAUDE.md:7`. Before: the note does not list stand-ins. After: it lists them.
  Users: in the release: every agent that reads the estate note. Across Trued-up projects: the vendored copy, which true-up overwrites.
  Ruling: rewrite.

- **B239** `skills/converge/prompts/owner-list.md` (upstream and judgment routes). Before: an `environment` failure caused by an outside service is filed as an upstream issue. After: one caused by a missing stand-in is filed as a `tooling` judgment issue whose option is the stand-in work item.
  Users: in the release: `/converge`'s owner list, and the `/plan-sprint` that walks the issue.
  Ruling: rewrite.

**New surface**
- `## Stand-ins for outside parties`, a section of the review facts, declared in `review/seed/project.md`: internal.
- `{{NO-PERSON-RULE}}`, declared in `skills/_sprint/shared.md`: internal.

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
