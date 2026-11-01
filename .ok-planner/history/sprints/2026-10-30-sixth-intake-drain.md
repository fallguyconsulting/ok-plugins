---
approved: 2026-10-31
closed: a4d0d6f6a811ad3a6cc463542a6cff810383e64f
---
# Sprint: Sixth intake drain: fast, deterministic test sprints

## Intent

This sprint drains the intake and remakes the test sprint so its suite
runs fast and gives the same verdict every run. Its source is the
sketch `2026-10-30-fast-test-sprints-sketch`, refined in planning: a
test is isolated unless it declares a shared resource (no fixed
phases), the term is "time control", a time control a test sprint
builds is a gated element that stays internal, the speed goal is a
principle with named wastes and no budget, and the no-defaults sweep
covers the suite's own tools. The defect fixes share no theme.

Promoted issues:

- `tests-tool-owns-the-per-test-run-loop`
- `test-sprints-write-tests-that-wait-on-the-wall-clock`
- `approved-test-sprint-across-true-up-boundary`
- `legacy-sort-deletes-unwritten-rule-tests`
- `owner-list-refiles-closed-judgments`
- `drive-prompt-forbids-undoing-scratch-probe-edits`
- `workflow-drain-marks-stages-only-on-return`
- `certified-accepts-another-sprints-ledger`
- `certified-base-refusal-names-a-refused-flag`
- `converge-return-omits-stuck-defect-id`
- `doc-prompts-miss-dangling-stamp-as-new`
- `docs-example-probes-path-from-repository-root`
- `merge-prompt-reads-none-as-a-sprint`
- `plan-sprint-drafts-rulings-before-reconcile`
- `ported-check-may-start-a-test-runner`
- `review-facts-give-no-resource-stop-line`
- `sprint-close-commit-omits-git-rm-removals`
- `sprint-close-skips-veto-when-not-complete`
- `lint-committed-marker-check-misses-subfolder-roots`

## Corpus deltas

### New decision: settings-have-no-code-defaults

body: in the sidecar

### New decision: every-timer-has-a-time-control

body: in the sidecar

### New decision: gated-elements-stay-internal

body: in the sidecar

### New decision: test-sprints-build-approved-time-controls

body: in the sidecar

### New decision: tests-spend-time-only-on-their-outcome

body: in the sidecar

### New decision: tests-isolated-unless-declared

body: in the sidecar

### Amend decision: scenario-list-decided-once

body: in the sidecar

### Amend decision: test-loop-fixes-code-never-tests

body: in the sidecar

### Amend decision: legacy-suites-sorted-automatically

body: in the sidecar

### Amend decision: intake-writers-are-gated

body: in the sidecar

### Amend decision: live-sprints-brought-current-on-true-up

body: in the sidecar

### Amend decision: surface-intent-changed-by-sprints

body: in the sidecar

### Amend decision: project-declares-its-folders

body: in the sidecar

### Amend decision: accept-list-decides-defects

body: in the sidecar

### Amend story: watch-execution-progress

body: in the sidecar

### Amend concept: sprint

body: in the sidecar

## Work items

Paths below are from the project root. "The payload" is
`plugins/ok/families/ok-planner/`; every suite-owned file a work item
changes is changed there, in the payload, and reaches this repo's
vendored copies only through `/ok`.

### W1. Restore the testing standard

Realizes `decision:tests-spend-time-only-on-their-outcome` and
`decision:test-loop-fixes-code-never-tests`; carries the ruling of
`test-sprints-write-tests-that-wait-on-the-wall-clock`.

Add a testing standard to the payload's standards documents, beside
the events and writing standards, materialized into each project's
estate as the others are. It states the principle, that a test's
verdict never waits on elapsed time, what a test waits on instead,
that the product takes its clock from outside and emits the events a
test waits on, and the named wastes. Carry its condensed rules in the
Tests section of the payload's plumbline cheatsheet, as the Events
section carries the events standard. Cite it from the test-writing,
fix, and verify prompts of `/plan-tests`. Widen the verify prompt and
the tasks the loop files so the verifier reads each written test as
well as each fix, and sends back a test or fix whose verdict waits on
elapsed time; a test it sends back returns to a test task.

### W2. The project owns the suite run

Realizes `decision:scenario-list-decided-once` and
`decision:test-loop-fixes-code-never-tests`; carries the ruling of
`tests-tool-owns-the-per-test-run-loop`.

`testing.run` becomes one suite command over a list of tests and a
path for a results stream. The tests tool passes each test's path,
name, and declared shared resources, reads one result line per test as
each lands, matches it to the scenario list by path and name, appends
it to the round at once, and reads a planned test the stream never
reports as failed. A fixer's run of its own test goes through the same
command with a list of one. Replace the per-test time limit with a
silence period the project declares, after which the tool stops the
run. Record each test's seconds, setup and teardown included, and
list the slowest tests in each round's report. Rewrite `/plan-tests`'s
runner question and its post-assembly check that compares the
declared runner with the planned tests, and every text that calls
`testing.run` the command that runs one test, including the
cheatsheets, the estate's `CLAUDE.md`, and the tool's usage text.
True-up asks the owner, as an input question, for the suite command
and the silence period in a project that declares the earlier
one-test form.

### W3. The fix loop reruns only failing tests

Realizes `decision:test-loop-fixes-code-never-tests`.

The test sprint's loop runs the whole suite, fixes and verifies each
failure, reruns only the failing tests until they pass, then runs the
whole suite as the gate, and loops on any test that fails there.
`tests complete` requires that the latest whole-suite round ran after
the last change. Change the test sprint document's loop step and the
tests tool's run and completion verbs to match.

### W4. A test sprint builds the time controls its plan lists

Realizes `decision:test-sprints-build-approved-time-controls`,
`decision:every-timer-has-a-time-control`, and `concept:sprint`.

`/plan-tests` planners name, in each planned test's reach, what the
test waits on: an event, a time control, or a clock the test moves.
A time control the product lacks becomes a time control item in the
plan, with its gate setting where it forces an event or moves the
product's time, shown to the owner with the plan and approved in its
one approval. The test sprint builds every time control item in tasks
of their own that run before any test task, each that forces an event
or moves time as a gated element. Narrow the bans in `/plan-tests`' prompts that
forbid a test from changing product code to cause its condition and
that send back a fix reading a setting only a test sets, so each
keeps its ban on test-only code and allows an approved time control.

### W5. Tests are isolated unless they declare a shared resource

Realizes `decision:tests-isolated-unless-declared` and
`decision:scenario-list-decided-once`.

The plan records, per test, each shared resource it declares it
changes, and the scenario list carries the declaration; the suite
command receives it. The plan names the number of workers, the
sizing the test stack's configuration gives for them, and, for each
deployment-wide limit the tests meet, whether configuration raises
it, the workers split it, or a lease hands it out. The test sprint
runs a preflight before the first test task that checks the test
stack runs alone with what it needs. The project declares a command
that prints one count per kind of resource a test may leave behind;
the tests tool runs it before and after each round, and a count that
grew fails the round. The planning reviewer reads the whole plan
against these, and sends back a declaration a cheaper design avoids.

### W6. Planning and review read for wasted test time

Realizes `decision:tests-spend-time-only-on-their-outcome`.

`/plan-tests` planners plan each test at the cheapest reach that still
proves its outcome, and avoid each named waste. The planning reviewer
and the verifier read for each waste. A plan reads the slowest-tests
list its planning run records, and its planners replan a slow test
whose time comes from a named waste.

### W7. The no-defaults coding rule

Realizes `decision:settings-have-no-code-defaults`.

Add the rule to the payload's coding rules and its ambient copy to the
plumbline cheatsheet: what a setting is, what stays a constant, that
code refuses to start and names a missing key, and that the change
that removes a default writes the former value into every deployment
the project owns. In the cheatsheet's Mechanical Checks section, add
that review under the accept list's rule entry is the check for a rule
only judgment decides, and no lint is owed for it.

### W8. The time-control coding rule

Realizes `decision:every-timer-has-a-time-control`.

Add the rule to the payload's coding rules and its ambient copy to the
plumbline cheatsheet. The `/plan-sprint` code planner names, for each
timer, schedule, or threshold a work item adds, the time control and
its gate setting, as part of that work item's notes.

### W9. The suite's own tools give no setting a default

Realizes `decision:settings-have-no-code-defaults`,
`decision:project-declares-its-folders`, and
`decision:accept-list-decides-defects`.

Every setting in the suite's own scripts, hooks, and dashboard
service moves to the project's configuration with no default in code,
and a tool that finds one missing refuses and names the key. True-up
writes each key, with its former default as its value, into every
project's `.ok-planner/config.json`, creating the file where a project
has none. Among them are the folder list, which true-up writes as the estate
root alone, and the review loop's standards list. Write the same keys
into this repo's own `.ok-planner/config.json` and
`.ok-planner/review/config.json`. Change every text that says an
absent configuration file or key means the defaults.

### W10. The suite's own timers get time controls

Realizes `decision:every-timer-has-a-time-control`.

Each timer, schedule, and threshold-driven event in the suite's own
scripts gets a time control under the rule, built as a gated element
where it forces an event or moves time.

### W11. Gated elements stay internal

Realizes `decision:gated-elements-stay-internal` and
`decision:surface-intent-changed-by-sprints`.

The surface intent's definition in the shared artifact definitions
says no class rule reaches a gated element. Each reader that lists a
class's members leaves gated elements out: the `/plan-docs` reference
writer and checker, `/converge`'s flow areas, and `/plan-sprint`'s
surface step.

### W12. A legacy sort ports a test whose rule no document states

Realizes `decision:legacy-suites-sorted-automatically`; carries the
ruling of `legacy-sort-deletes-unwritten-rule-tests`.

The sort and legacy prompts port a test that enforces an unwritten
rule on the code's shape, naming the rule they infer. The plan shown
to the owner lists each inferred rule, and the completion report lists
each port for veto. The next `/plan-sprint` meets each surviving
inferred rule and drafts it as a practice with the owner or retires
it with its check.

### W13. No process reads the issue archive

Realizes `decision:intake-writers-are-gated`; carries the ruling of
`owner-list-refiles-closed-judgments`.

No writer into the intake, run, or ceremony reads the archive to
decide what to file: each writer checks only the open issues for a
duplicate. True-up's filing of the issues it raises stops reading the
archive, so it files an issue again while its harm stands. State the
rule once in the issue format's id rule, and keep every text that
restates a writer's duplicate check consistent with it.

### W14. Approved documentation and test sprints cross the true-up boundary

Realizes `decision:live-sprints-brought-current-on-true-up`; carries
the ruling of `approved-test-sprint-across-true-up-boundary`.

Amend `.ok-planner/release-boundaries.md` so an approved sprint,
documentation sprint, or test sprint not yet in execution is across
the trued-up projects boundary, and state the owner's habit of truing
up between runs as the owner's choice. True-up brings each approved
documentation sprint and test sprint to the carried shape, beside its
live-sprint step, such as filling a test sprint plan's missing
`folders` from the project's folder list.

### W15. A driver undoes a scratch edit without git

Carries the ruling of `drive-prompt-forbids-undoing-scratch-probe-edits`.

Keep the git ban whole in `/converge`'s drive prompt, and name the two
ways a driver undoes a scratch edit: copy the file aside before a
probe edit and copy it back afterward, or discard the scratch project
and make a fresh one where a command wrote what no copy saved.

### W16. `review certified` checks the ledger's sprint

Fixes `certified-accepts-another-sprints-ledger`; realizes
`story:certify-completion`. Fix
`plugins/ok/families/ok-planner/scripts/review:certification_failures`
so a completion report that names another sprint's ledger no longer
earns `SPRINT COMPLETE`.

### W17. `review certified` names no flag it refuses

Fixes `certified-base-refusal-names-a-refused-flag`; realizes
`story:certify-completion`. Fix
`plugins/ok/families/ok-planner/scripts/review:sprint_base` and its
caller `cmd_certified` so `review certified` no longer tells the user
to pass a flag it refuses.

### W18. A return block written as the text asks completes the sprint

Fixes `converge-return-omits-stuck-defect-id`; realizes
`decision:sprint-goal-read-from-the-repository`. Fix the return in
`/converge`'s skill text, or the stuck check in
`review:certification_failures`, so a return block written as the
text asks no longer leaves a finished sprint's contract open.

### W19. A docspec with a dangling stamp is planned as new

Fixes `doc-prompts-miss-dangling-stamp-as-new`; realizes
`decision:docspec-stamp-opens-the-window` and
`decision:documentation-claim-ledger`. Fix the `/plan-docs` planner,
style, and checker prompts, the skill's window step, and the
documentation sprint's fact-loop step so a docspec the window reports
as `new` with a stamp set gets every claim checked and no `git diff`
against its missing stamp.

### W20. Worked examples resolve from the project root

Fixes `docs-example-probes-path-from-repository-root`; realizes
`story:keep-documentation-current`. Fix `docs:cmd_example`, and the
worked-example and retired-docspec reads in the `/plan-docs` writer
and style prompts, so a project below its repository's root can record
and read its approved worked example by its project path.

### W21. The merge prompt reads `none` as no sprint

Fixes `merge-prompt-reads-none-as-a-sprint`; realizes
`story:catch-broken-promises`. Fix each line of `/converge`'s merge
prompt that turns on its sprint placeholder, so a drive, analysis, or
defects run no longer sends real drive failures to the backlog
unfixed.

### W22. `/plan-sprint` reconciles before it drafts

Fixes `plan-sprint-drafts-rulings-before-reconcile`; realizes
`story:plan-a-sprint`. Fix `/plan-sprint`'s Frame and Reconcile phases
so a ruled issue's amendment and a Reconcile outcome on the same
artifact end in one whole body that carries both.

### W23. A ported check never starts a test runner

Fixes `ported-check-may-start-a-test-runner`; realizes
`decision:legacy-suites-sorted-automatically`. Fix `tests:cmd_ports`
and the sort and legacy prompts' port sentences so a ported check
whose command starts a test runner is refused before it reaches the
review loop's checks.

### W24. `/converge` can stop what its drivers leave open

Fixes `review-facts-give-no-resource-stop-line`; realizes
`decision:run-artifacts-removed-with-the-run`. Fix
`.ok-planner/review/project.md`'s `## Drive commands` section so a run
a driver leaves open no longer outlives the `/converge` run.

### W25. A sprint's close commit holds every removal

Fixes `sprint-close-commit-omits-git-rm-removals`; realizes
`story:plan-a-sprint`. Fix the sprint document's archive step 3 so the
close commit names every path the last commit holds that the sprint
removed, and add the replaced text to the retired-boilerplate list.

### W26. A failed certification still asks for vetoes

Fixes `sprint-close-skips-veto-when-not-complete`; realizes
`decision:converge-close-takes-vetoes`. Fix the sprint document's
execution step 13 so a certification that ends in `SPRINT NOT
COMPLETE` no longer closes without asking the owner which calls to
veto, and add the replaced text to the retired-boilerplate list.

### W27. The lint finds a committed marker in a subfolder project

Fixes `lint-committed-marker-check-misses-subfolder-roots`. Fix
`plugins/ok/families/ok-planner/scripts/plumbline:committedLegacyMarker`
so a marker committed in a project whose root is a subfolder of its
repository is no longer reported as a new marker.

## Implementation notes

Planned against commit `df287cf04ef1e4207f754df5bc55cb89b3e8d662`. Sections write the payload, `plugins/ok/families/ok-planner/`, as `<payload>/` or `P/`, or give payload paths bare where the section says so.

### W1. Restore the testing standard

**Calls**
- Build note: W13 changes no `{{TEST-VERIFY-PROMPT}}` line; the overlap named above does not hold.
- The standard is a new suite-owned file, `docs/testing.md`, materialized as `.ok-planner/docs/testing.md` in "stamped" form like `docs/events.md`. Decided by: decision tests-spend-time-only-on-their-outcome ("beside its events and writing standards"), and the ESTATE_FILES sibling shape.
- The condensed lines go in the plumbline cheatsheet's `## Tests`, after the `<!-- /lint-check -->` close. That puts them outside the `no-tests` marker, so a project that turns `no-tests` off keeps them. Decided by: the delta's rationale that "the wait rules bind product code as much as tests" and reach product-code writers only through the always-loaded rules.
- The standard states the test side: a verdict waits on an event, a time control, or a clock the test moves. It states the product side in one sentence: the product takes its clock from outside and emits the events a test waits on. For timers it points to the time-control coding rule W8 adds. It does not restate that rule. Decided by: the writing standard's "say it once".
- A test verify task reads the test and runs nothing, so test verifies are filed with no `--after` chain and can run in parallel. Fix verifies stay one at a time. Decided by: the verify prompt's read-only role, and decision tests-spend-time-only-on-their-outcome (a serial queue of read-only verifiers is a named waste).
- The verifier also sends back a test that spends time on a named waste. Its plan's reach does not require that time. Decided by: W6 ("the verifier read for each waste").
- A fix verifier that finds the fix's test waiting on elapsed time sends the test back too, by setting its `tests` item to `sent-back`. Decided by: decision test-loop-fixes-code-never-tests ("sends back any test or fix whose verdict waits on elapsed time; a test it sends back goes to a test task again").
- Overlap: W7 and W8 also change `docs/plumbline-cheatsheet.md` (Mechanical Checks and new rule sections); W1 adds only to `## Tests`. W13 also edits `{{TEST-VERIFY-PROMPT}}` (its promise `issues file` line). W14 must carry the boilerplate changes below into approved test sprints.

**Changes**
- `docs/testing.md`: new. "Testing: the standard". It has these parts:
  - the principle, that a test spends time only on proving its outcome;
  - that a test's verdict never waits on elapsed time, and that a test waits on an event the product emits, a time control that forces it, or a clock the test moves;
  - that the product takes its clock from outside and emits the events a test waits on;
  - the four named wastes, from the decision (the reach rule, repeated setup, an avoidable shared resource, unneeded work);
  - that each round records seconds and lists the slowest tests, which the next plan reads, and that no time budget decides a verdict;
  - that the planning reviewer and the verifier read for each waste.
- `admin/true-up::ESTATE_FILES`: changed. Adds `("docs/testing.md", ".ok-planner/docs/testing.md", "stamped")`.
- `docs/plumbline-cheatsheet.md` `## Tests`: changed. Adds the ambient-copy paragraph, which names `.ok-planner/docs/testing.md`, and four or five condensed bullets.
- `skills/plan-tests/core.md::{{TEST-WRITE-PROMPT}}`: changed. Its Read list adds the standard. Write adds: the verdict waits only on what the scenario's `waits` names, with no sleep and no poll under a deadline.
- `skills/plan-tests/core.md::{{TEST-FIX-PROMPT}}`: changed. Read adds the standard. The ban adds "a sleep or a wait on elapsed time".
- `skills/plan-tests/core.md::{{TEST-VERIFY-PROMPT}}`: changed. It gains a `### A test` section: read the `tests` item, its test, its scenario, and its `reach` and `waits`. Send it back with `tasks item set <item> --state sent-back --field reason=...` where its verdict waits on elapsed time or it spends time on a named waste; otherwise set it `accepted`. `### A fix` gains the test send-back above. Read cites the standard.
- `scripts/tests::stage_verify`: changed. It also files one verify task, key `verify:<item>`, for each open `tests` item that records a test (not `retired`, not `gap`). The brief names the scenario, the test, and its reach and waits. There is no `after` chain for these.
- `scripts/tests::stage_write`: changed. It refiles the test task of each scenario whose latest `tests` record stands `sent-back`, with `tasks refile <task> --brief "<brief>\nThe verifier sent the test back: <reason>"`, after any holder of its files.
- `scripts/tests::complete_failures`: changed. Two new failures: a `tests` item `open` awaits its verifier; a scenario's latest `tests` record stands `sent-back` and no test task rewrote it.
- `skills/plan-tests/test-sprint-document.md`:
  - step 4: pool `"tests": ["open", "accepted", "sent-back"]`;
  - step 5: after each write drain, `tests tasks --stage verify` and drain, until neither stage files a task;
  - step 6: the loop's inner step runs `--stage write` too, for tests a fix verifier sent back;
  - contract item 2: no test awaits its verifier, and no sent-back test stands unrewritten.
- `scripts/ok-planner-CLAUDE.md` "The standards documents", `scripts/ok-planner-cheatsheet.md` (the `docs/` line near l.79), `admin/ADMINISTRATION.md` l.39, and `CLAUDE.md` (the `docs/` layout line): changed. Each names `testing.md` beside `events.md`.

**Behavior changes**
- **B1** `scripts/tests::stage_verify`, `stage_write`, and `complete_failures`, with the test sprint boilerplate.
  - Before: only fixes and promises are verified, and a written test is never read.
  - After: each written test is verified. A sent-back test is refiled to a test task. `tests complete` refuses while a test awaits its verifier or stands sent back.
  - Users in the release: the test sprint executor, and the vendored `/plan-tests` copy, which ships with the tool.
  - Users across Trued-up projects: an approved test sprint not yet in execution (W14 puts it across). Its step 4 declares `"tests": ["open"]`, so `tasks item set --state sent-back` is refused.
  - Ruling: migrate: W14's true-up step brings the approved test sprint's boilerplate to the carried shape (call).

### W2. The project owns the suite run

**Calls**
- Call: `testing.runners` is a required key of `testing`: `testing_config` requires it, `cmd_declare` takes `--runners`, and `/plan-tests` step 2 asks for it with the other keys, an empty list where the project has no runner of its own to name. Decided by: W9's table, which makes it a setting with no default (notes review).
- Build note: `results_rounds` reads a planned test with no result line as failed from the round header's `planned` list, so a `rerun` round fails only the tests it reran.
- Build note: several workers write one FIFO, and only writes up to PIPE_BUF are atomic; cap each result line's `output` so a line fits, and say the limit in the usage text.
- Build note: open the FIFO without blocking on its writer (O_RDWR, or O_RDONLY|O_NONBLOCK before the tool's own write end).
- Build note: also rewrite `/plan-tests` SKILL.md step 8 (`testing.run` holds no `{name}` becomes `testing.named`), step 13's closing line, and the story and runtime planners' Record text that tests for `{name}`.
- Build note: `testing.leftovers` is required and non-empty; step 2's proposal says a project with nothing to count declares a command that prints `{}`.
- `testing.run` holds two placeholders.
  - `{tests}` is the path of a JSON file, `{"workers": <n>, "tests": [{"path", "name", "resources": [...]}]}`.
  - `{results}` is the path of the result stream.
  - Each result line is `{"path", "name", "passed": bool, "seconds": number, "output": "<text>"}`.
  - Decided by: decision scenario-list-decided-once (a list with path, name, and resources; the workers the plan names; one line per test, named by path and name).
- The stream is a FIFO the tool makes in a `tempfile.mkdtemp` folder. The tool holds its own write end, so no spurious EOF arrives. It `select`s on the FIFO and on the suite's output pipe, with the time left in the silence period as the timeout.
  - This needs no poll-interval literal, so decision settings-have-no-code-defaults is met.
  - The usage text tells a suite command to write lines to the path and never replace the file.
  - In `finally`, the tool kills the process group (`end_group`) and removes the folder.
- When a test is reported twice, the first line stands. Later lines, and lines that are not JSON or lack `path`, `passed`, or `seconds`, go to the round's `unmatched` list. A test with no valid line reads as unreported, so it fails. Decided by: the delta ("a planned test the stream never reports reads as failed").
- `{name}` leaves the command, so a runner's ability to run one test by name becomes `testing.named` (true or false). It replaces every `testing["named"]` read in `assembled_plan`, `plan_failures`, and the sort prompt. Decided by: the whole-file adoption rule, which needs the fact.
- "The slowest tests" needs a count. That count is a setting under decision settings-have-no-code-defaults, so it is a new required key, `testing.slowest`, with no default. The owner gives it with the runner. Decided by: settings-have-no-code-defaults.
- `testing.silence` is a timer in the suite's own tool. It is itself the exposed-setting form of time control, so decision every-timer-has-a-time-control holds. Overlap: tell W10.
- `--only` and `--from` run the suite command with `workers: 1`, since a list of one takes one worker. Decided by: arithmetic.
- The planning run (step 4, no `--sprint`) still prints its JSON list at the end. Every entry now carries seconds. It is not a round, so it is not streamed to a round file. Decided by: the decision's interrupted-round text names rounds.
- `/plan-tests` step 2 asks, in one prose question, for every key the tool reports missing: `run`, `silence`, `named`, `leftovers` (W5), and `slowest`. It treats an earlier one-test form as missing. Its proposals are from the project's tooling.
- True-up's question asks for the same keys. It derives `named` from whether the earlier `run` held `{name}`, and it drops `timeout`. `resolve` refuses its id and points to `amend`, as it does for `port-range`. Decided by: W2's text and the port-range sibling.
- Adds a `scripts/tests` line to `.ok-planner/review/project.md` "Scripts for developers and operators", since its inputs change. Decided by: the facts file's rule that a build changing a script's inputs updates it.
- Overlap with W9:
  - W2 removes `DEFAULT_TIMEOUT`, so W9 must not write `testing.timeout` into any config.
  - W9's handling of `GROUP_SIZE` and `TAIL_LINES` in `scripts/tests` must use key names the new `plumbline::TESTING_KEYS` accepts.
  - Both items change the config prose in `scripts/ok-planner-CLAUDE.md` l.100–106, `admin/ADMINISTRATION.md` l.222, and the Tooling bullet at `docs/plumbline-cheatsheet.md` l.162–165.
- The tests script is one file that W1–W6, W12, and W23 all change. Its stages chain with `--after`.

**Changes**
- `scripts/tests::testing_config`: changed.
  - It requires `run` holding `{tests}` and `{results}`, a positive whole `silence`, a boolean `named`, a non-empty `leftovers`, and a positive whole `slowest`. It refuses each missing key by name.
  - It refuses an earlier one-test form (`run` holding `{path}` with no `{tests}`, or a `timeout` key) with: `testing.run declares the earlier one-test form; run /ok, or /plan-tests, which asks for the suite command`.
- `scripts/tests::DEFAULT_TIMEOUT`, `run_one`, and `command_for`: removed.
- `scripts/tests::run_suite`: new. It writes the list file and makes the FIFO, then starts the command with the placeholders shlex-quoted, `cwd` at the root, and `start_new_session`.
  - It hands each matched line to a callback as it lands.
  - It stops the process group after `silence` seconds with no result.
  - It returns the results, the unmatched lines, `stopped` (`"silence"` or none), the exit code, and the output tail.
- `scripts/tests::cmd_run`: changed. Its targets carry `resources`, and its workers come from the plan's `budget` (W5).
  - With `--sprint` it appends a header line `{round, kind, at, tasks_closed, test_files, planned, leftovers_before}`, then one `{round, scenario, path, name, passed, seconds, tail}` line per result as it lands (one write, then a flush), then a closing line `{round, ended, exit, stopped, unmatched, leftovers_after, grew}`.
  - It prints each result and the round's slowest `testing.slowest`.
- `scripts/tests::results_rounds`: changed. It rebuilds each round from its lines. A planned test with no result line reads failed, with tail "the suite command reported no result" (plus the silence note). A round with no closing line reads unclosed.
- `scripts/tests::live_tests`: changed. Each entry carries `resources`, from the plan's scenario or the stamp's record, `[]` where absent.
- `scripts/tests::cmd_declare`: changed. It takes `--run`, `--silence`, `--named yes|no`, `--leftovers`, and `--slowest`. It merges the keys given, drops `timeout`, refuses a `--run` lacking `{tests}` or `{results}`, and refuses `--timeout` with a message naming `--silence`.
- `scripts/tests::cmd_report`: changed. Rounds shows each round's kind, its counts, `stopped`, and its grown kinds, then that round's slowest `testing.slowest` tests with their seconds.
- `scripts/tests::assembled_plan` and `plan_failures`: changed. They read `named` from `testing_config`, and the failure text names `testing.named`.
- `scripts/tests::USAGE`: changed. `declare` and `run` read as above, and "the command that runs one test" is gone.
- `scripts/plumbline::testingDefects` and `TESTING_KEYS`: changed. The keys are `run`, `silence`, `named`, `leftovers`, `slowest`, and `runners`, plus whatever W9 adds.
  - `run` must hold `{tests}` and `{results}`.
  - An earlier form (`run` with `{path}` and no `{tests}`, or `timeout`) is reported as `testing declares the earlier one-test form; run /ok, which asks for the suite command`.
- `admin/true-up::lint_config_plan`: changed. It moves the earlier-form `testing` defects into `"earlier_testing"`, out of `defects`, so `config`, `port-range`, and the other config questions are unaffected.
- `admin/true-up::testing_question`: new. Id `testing:.ok-planner/config.json`, consent `("amend", label)`. Its What line says the earlier command and timeout. The draft is the whole config with the suite command, silence, named (derived), leftovers, and slowest set, `timeout` dropped, and every other key kept.
- `admin/true-up::questions`: changed. It appends `testing_question()`.
- `resolve` refuses the `testing` id and names the amend command.
- `admin/ADMINISTRATION.md`: changed. It gains an Input questions table row and a "Draft each answer this way" bullet for `testing`. Line 222's description of `testing` is rewritten.
- `skills/plan-tests/SKILL.md`: changed.
  - Step 2 is rewritten: the runner is the suite command and its keys, and the proposal shows each placeholder and the result-line shape.
  - Step 4: the results carry each test's seconds.
  - Step 9 compares each kind and setup pair with the suite command and the silence period: one test of the pair finishes inside it.
  - Step 13 names the keys `declare` writes.
- `skills/plan-tests/core.md` story and runtime planners: Read step 6 and the "Plan each new and rewrite test in a form…" paragraph now name the suite command and `testing.silence`.
- `skills/plan-tests/core.md` sort, support, and write prompts: their `testing.run`/`{name}` text becomes `testing.named` and the suite command.
- Text that calls `testing.run` "the command that runs one test" is rewritten in `scripts/ok-planner-CLAUDE.md` l.105 and l.244–246, `scripts/ok-planner-cheatsheet.md` l.84 and l.354–355, `docs/plumbline-cheatsheet.md` l.165, and `CLAUDE.md` l.67.
- `.ok-planner/review/project.md`: changed. It gains a `scripts/tests` line.

**Improvements**
- **I1** `scripts/tests::results_rounds`. Entry: A1. Results now stream one line at a time, so a killed tool can leave a torn last line, and `json.loads` then makes every verb on the sprint refuse. Afterward: a final line that does not parse is dropped, and its round reads unclosed.

**Behavior changes**
- **B2** `testing` in `.ok-planner/config.json`, read by `scripts/tests::testing_config` and `scripts/plumbline::testingDefects`.
  - Before: `run` is a one-test command with `{path}`/`{name}`, and `timeout` is optional (600).
  - After: `run` is a suite command with `{tests}`/`{results}`, and `silence`, `named`, `leftovers`, and `slowest` are required. The earlier form is refused by `bin/tests` and reported by `config-check`, both naming `/ok`.
  - Users across Trued-up projects: every project whose config declares the earlier form, and an approved test sprint planned under it.
  - Ruling: rewrite across Trued-up projects: one way to run a suite; `bin/tests` and the lint's config check refuse the earlier form and name `/ok`, and true-up and `/plan-tests` ask for the suite command (owner).
- **B3** `scripts/tests::cmd_declare`.
  - Before: `--run`, `--timeout`.
  - After: `--run`, `--silence`, `--named`, `--leftovers`, `--slowest`; `--timeout` refused.
  - Users in the release: `/plan-tests` steps 2 and 9.
  - Ruling: rewrite.
- **B4** `scripts/tests::cmd_run`.
  - Before: one process per test, each with a time limit, and the round recorded after all tests finish.
  - After: one suite command over a list, with no per-test limit. The run stops after a silence period, and an unreported test fails. Every result carries seconds, and the round is appended as each result lands.
  - Users in the release: `/plan-tests` step 4, the planners that read results, the write, fix, verify, and sort prompts' `--only`/`--from` runs, and `tests failures`, `complete`, `report`, `stamp`, and `groups`.
  - Ruling: rewrite.
- **B5** `scripts/tests::results_rounds`, the `-results.jsonl` record.
  - Before: one line per round.
  - After: header, result, and closing lines.
  - Users in the release: the tool's own verbs.
  - A live test sprint in execution is not across the boundary, and an approved one holds no results file.
  - Ruling: rewrite.
- **B6** `scripts/tests::cmd_report`.
  - Before: Rounds shows counts only.
  - After: Rounds shows each round's kind, stop, grown kinds, and slowest tests.
  - Users in the release: test sprint step 7.
  - Ruling: rewrite.
- **B7** `scripts/plumbline::testingDefects`.
  - Before: it accepts `run` with `{path}`, and `timeout`.
  - After: it reports the earlier form and accepts the new keys.
  - Users in the release: `admin/true-up` config-check and amend.
  - Users across Trued-up projects: covered by B2's ruling.
  - Ruling: rewrite.
- **B22** (I1) `scripts/tests::results_rounds`.
  - Before: a torn last line makes every verb on the sprint refuse with a JSON error.
  - After: the line is dropped, and the round reads unclosed.
  - Users in the release: the tool's verbs.
  - Ruling: rewrite.

### W3. The fix loop reruns only failing tests

**Calls**
- Call: `tests run --failing` reruns only the test entries of the unsettled set. Where that set holds no test, as when a round's only failure is a grown leftover count, step 6 goes straight to the whole-suite gate, and `--failing`'s refusal names that step. Decided by: W5's leftover entries are not tests (notes review).
- `tests run --sprint <path> --failing` reruns each test that the latest round lists as failing with no held promise or owner issue (the set `unsettled_failures` returns), as a round of kind `rerun`. It refuses where no round is recorded or where that set is empty. Decided by: decision test-loop-fixes-code-never-tests.
- `tests complete` reads the latest round. Where its kind is `rerun`, it fails with: "round n reran failing tests only: run the whole suite as the gate". The existing late-task and test-file-hash checks stand. Decided by: W3 ("the latest whole-suite round ran after the last change").

**Changes**
- `scripts/tests::cmd_run` and `build_parser`: changed. They add `--failing`, which needs `--sprint`, and record `kind`: `whole` without the flag, `rerun` with it.
- `scripts/tests::main`: changed. It refuses `--failing` with `--only` or `--from`.
- `scripts/tests::complete_failures`: changed. It requires the latest round to be `whole`, closed, and run after every changing task.
- `scripts/tests::cmd_stamp`: changed. It takes the failed set from the latest whole round.
- `skills/plan-tests/test-sprint-document.md`:
  - step 6 becomes: run the whole suite; while `tests failures` lists a failure, run the fix and verify stages (and write, per W1) until none files a task, then `tests run --sprint <path> --failing`; when a rerun round lists no failure, run `tests run --sprint <path>` as the gate, and loop on any failure there;
  - contract item 3 names the latest whole-suite round.
- `scripts/tests::USAGE`: changed. It documents `--failing` and the completion rule.

**Improvements**
- **I2** `scripts/tests::main`. Entry: A8 (events standard: an owner frame's catch-all emits one event) and A4. Today the `__main__` catch-all prints "tests: internal error" and records no event or stack trace. Afterward: as `scripts/review::main` does, `main` catches `Exception` last and calls `review.issues.tasks.event("TESTS.RUN.FAILED", type=..., message=...)`, which attaches the stack trace, then returns 1.

**Behavior changes**
- **B8** `scripts/tests::cmd_run`, `complete_failures`, and test sprint step 6.
  - Before: every round runs the whole suite, and completion reads the latest round.
  - After: fixes are rerun alone, a whole-suite round is the gate, and completion refuses a rerun as the latest round.
  - Users in the release: the test sprint executor.
  - Users across Trued-up projects: an approved test sprint's step 6 and contract.
  - Ruling: migrate: W14's true-up step brings its boilerplate to the carried shape (call).
- **B23** (I2) `scripts/tests::main`.
  - Before: an internal error prints one line to stderr.
  - After: it also emits the `TESTS.RUN.FAILED` event with its stack trace.
  - Users in the release: none parse that stderr.
  - Ruling: rewrite.

### W4. A test sprint builds the time controls its plan lists

**Calls**
- A planned `new` or `rewrite` names `waits` as one of `event: <what the product emits>` (a call's reply counts), `control: <id>`, or `clock: <the clock the test moves>`. A `control: control--<slug>` value must name a control item in the plan. Any other `control:` value names a time control the product already has. Decided by: decision test-sprints-build-approved-time-controls.
- Planners record a control item in pool `controls`: `id=control--<slug>`, `form=<trigger|clock|setting>`, `site=<path::symbol of the timer>`, `files=[...]`, and `gate=<the gate setting key>`. `gate` is required for trigger and clock and refused for setting. The body says what the control does. Two planners naming one id must record equal fields, or assembly refuses both. Decided by: decision every-timer-has-a-time-control (three forms; trigger and clock are gated).
- Control tasks (role `control`, key `control:<id>`) run first. Then come preflight (W5), support, and test tasks, each `--after` every control task. Legacy tasks are unchanged. Decided by: W4 ("before any test task").
- A control task writes the gate setting into every deployment configuration the project owns: on in the test stack's, off in production's, with no default in code. Decided by: decisions every-timer-has-a-time-control and settings-have-no-code-defaults.
- No verify task reads a control task. The owner approved each control with the plan, the tests that use it prove it, and the fix loop fixes it. Decided by: the delta's choice to approve controls in the plan.
- Overlap: W11 keeps gated elements internal and leaves them out of member lists. Each control a test sprint builds in a consumer project is such an element.

**Changes**
- `scripts/tests::scenario_of`: changed. It reads `waits` and `resources` (W5).
- `scripts/tests::planning_items`: changed. Its pools add `controls`, `budget`, and `limits` (W5), and `PLAN_ROLES` adds `budget`.
- `scripts/tests::assembled_plan`: changed. It collects and de-duplicates controls into `plan["controls"]`.
- `scripts/tests::plan_failures`: changed.
  - It refuses a `new` or `rewrite` with no or malformed `waits`, and a `control:` value naming a missing item.
  - It refuses a control with a bad form, no site, no files, a gate set wrong for its form, or no scenario that waits on it.
- `scripts/tests::print_summary` and `print_plan`: changed. A "Time controls the plan builds" section lists each control in full.
- `scripts/tests::stage_write`: changed. It files control tasks first. It refuses when the plan names controls and the run registers no `control` prompt, worded like the support refusal. Test tasks wait on every control task.
- `scripts/tests::RUN_ROLES` and `CHANGING_ROLES`: changed. They add `control` and `preflight`.
- `scripts/tests::complete_failures`: changed. Every plan control needs a done control task.
- `scripts/tests::cmd_report`: changed. It adds a "Time controls built" section from the run's `controls` items.
- `scripts/tests::cmd_stamp`: changed. It keeps `waits` on each scenario.
- `skills/plan-tests/core.md::{{TEST-CONTROL-PROMPT}}`: new. It builds one control as product code at its site, gated where it forces an event or moves time, and writes the gate setting into each deployment configuration. Its record is `tasks item add --pool controls --key <id> --field control=<id> --field 'files=[...]' [--field gate=<key>]`.
- `skills/plan-tests/core.md` story and runtime planners: the Plan and Record sections add `waits` and the controls record.
- `skills/plan-tests/core.md` runtime planner: "A test never changes product code to cause its condition" becomes: outside an approved time control, it never does, and a timer the product cannot force gets a control item.
- `skills/plan-tests/core.md::{{TEST-WRITE-PROMPT}}`: "Change no product code…" now adds "use the time control the scenario's waits names".
- `skills/plan-tests/core.md::{{TEST-FIX-PROMPT}}` and `{{TEST-VERIFY-PROMPT}}`: the "reads a setting only a test sets" ban adds that a time control the plan approved is product code every deployment carries, not such a setting.
- `skills/plan-tests/SKILL.md`: changed. Step 5 adds the pools, step 8 adds the assembly checks, and step 12's summary lists each time control.
- `skills/plan-tests/test-sprint-document.md`: changed. Step 4 registers `{{TEST-CONTROL-PROMPT}}` as `control` and adds pool `"controls": ["open"]`. Step 5 states the order. Contract item 1 names control tasks.

**Behavior changes**
- **B9** `scripts/tests::plan_failures`.
  - Before: a `new` or `rewrite` needs no `waits`.
  - After: it refuses one with none, and a malformed control.
  - Users in the release: `/plan-tests` step 8.
  - Ruling: rewrite.
- **B10** `scripts/tests::stage_write`.
  - Before: support and test tasks only.
  - After: control tasks first, and test tasks wait on them.
  - Users in the release: the test sprint executor.
  - Users across Trued-up projects: an approved plan with no `controls` key.
  - Ruling: preserve (call). An absent `controls` reads as none, so no control task is filed and no `control` prompt is required.
- **B11** `skills/plan-tests/core.md`, the runtime, write, fix, and verify bans.
  - Before: they forbid any product change made for a test.
  - After: they allow an approved time control.
  - Users in the release: the agents of the test sprint.
  - Ruling: rewrite.

### W5. Tests are isolated unless they declare a shared resource

**Calls**
- A planned test records `resources=["<slug>", ...]`, empty for an isolated test. The plan, the stamp, and the suite list carry it. Decided by: decision tests-isolated-unless-declared.
- The budget is a new planning role, `budget`, under a new `{{TEST-BUDGET-PROMPT}}`. One task is filed on every plan, after the sort, since the budget covers the whole suite.
  - It records one `budget` item: `workers`, `stack` (the test stack's start, or `none`), `sizing` (each configuration file and the values it gives for that many workers, with any change the preflight writes), and `files`.
  - It records one `limits` item per deployment-wide limit, with `how=<raise|split|lease>` and its detail.
  - It has no planner review of its own. The plan-wide review checks it.
  - Decided by: W5, and the programs task, which already gets no review of its own.
- Preflight is role `preflight`, under a new `{{TEST-PREFLIGHT-PROMPT}}`, and is filed only where `budget.stack` is not `none`.
  - It runs after the control tasks and before support and test tasks.
  - It may edit only the configuration files the budget names, to the sizing it names. It starts the test stack alone through the project's stack tool, checks the sizing and each limit's handling, and stops the stack.
  - It closes `blocked` where it cannot. Closed blocked twice is a genuine blocker.
  - Decided by: W5 ("a preflight before the first test task").
- `testing.leftovers` prints one JSON object of kind to count, each kind a slug. The tool runs it before and after each recorded round, and around `--only` runs, where it prints the counts. A kind whose count grew makes the round fail.
  - `tests failures` lists each grown kind as `leftovers--<kind>`, and `--stage fix` files a fix task for it.
  - The fixer fixes the product where the product leaks. Where a test or its support leaves the resource behind, it records `--field 'tests=[<scenario>, ...]'` with `change=none`.
  - On accept, the verifier sends each named test back (W1's path).
  - Decided by: decision tests-isolated-unless-declared ("a count that grew fails the round"), and decision test-loop-fixes-code-never-tests (a fixer never edits a test).
- A plan or stamp with no `budget` runs with `workers: 1`, as the earlier tool ran one test at a time. Decided by: the stored-state boundary.

**Changes**
- `scripts/tests::assembled_plan` and `plan_failures`: changed.
  - They write `plan["budget"]` with its `limits`.
  - They refuse a run with no budget item, or more than one, from the latest done budget task. They also refuse `workers` that is not a positive whole number, a missing `stack` or `sizing`, a `how` outside raise, split, and lease, and a `resources` entry that is not a slug.
- `scripts/tests::print_summary`: changed. It adds "Shared resources declared" (each resource with its tests) and "The test stack's budget".
- `scripts/tests::cmd_run` and `run_suite`: changed. They pass `workers` and `resources`, run `testing.leftovers` before and after a recorded round, and record `grew`.
- `scripts/tests::unsettled_failures`: changed. It appends a `leftovers--<kind>` entry per grown kind.
- `scripts/tests::stage_fix`: changed. It files leftovers fix tasks with the grown kinds and the round's tests in the brief.
- `scripts/tests::stage_write`: changed. It files the preflight task.
- `scripts/tests::complete_failures`: changed.
  - The preflight task must close done where a stack is named.
  - The latest whole round must have no grown kind.
  - An accepted leftovers fix's named tests must be rewritten.
- `scripts/tests::cmd_stamp`: changed. It writes each scenario's `resources` and the state's `budget`.
- `scripts/tests::read_state`: changed. It defaults `budget` to none.
- `skills/plan-tests/core.md`:
  - `{{TEST-BUDGET-PROMPT}}` and `{{TEST-PREFLIGHT-PROMPT}}`: new.
  - Story and runtime planners: record `resources` and declare only what the test changes.
  - `{{TEST-FIX-PROMPT}}`: a leftovers section.
  - `{{TEST-VERIFY-PROMPT}}`: on accepting a leftovers fix, send back each test it names.
  - `{{TEST-PLAN-WIDE-REVIEW-PROMPT}}`: Read adds the budget. Check sends back a declaration a cheaper design avoids, a budget without workers, sizing, or a handling for each limit the tests meet, and a sizing the stack's configuration does not give for that many workers.
- `skills/plan-tests/SKILL.md`: changed. Step 5 registers `budget` and adds pools `"budget"` and `"limits"`. Step 6 adds item 4, filing one budget task after the sort and draining. Step 11 says the budget gets no review of its own.
- `skills/plan-tests/test-sprint-document.md`: changed. Step 4 registers `preflight`, step 5 adds the order, step 6 notes leftover failures, and contract items 1 and 3 change.

**Behavior changes**
- **B12** `.ok-planner/test-state.json` and the plan.
  - Before: scenarios carry no resources, and nothing records workers.
  - After: they carry `resources`, and the state and plan carry `budget`.
  - Users across stored state: a stamp an earlier release wrote, and an approved plan.
  - Ruling: preserve (call). Absent means no resources and one worker.
- **B13** `scripts/tests::cmd_run`, `unsettled_failures`, and `complete_failures`.
  - Before: a round fails only on tests.
  - After: a grown leftover count fails it.
  - Users in the release: the test sprint loop.
  - Ruling: rewrite.
- **B14** `scripts/tests::assembled_plan`.
  - Before: there is no budget.
  - After: it refuses a plan without one.
  - Users in the release: `/plan-tests` steps 6 and 8.
  - Ruling: rewrite.
- **B15** `scripts/tests::stage_write`, the preflight.
  - Before: none.
  - After: filed where the budget names a stack.
  - Users across Trued-up projects: an approved plan with no budget.
  - Ruling: preserve (call). No budget means no preflight.

### W6. Planning and review read for wasted test time

**Calls**
- Call: the amended `decision:scenario-list-decided-once` lists a story whose recorded test the last run lists among its slowest as touched. Decided by: decision tests-spend-time-only-on-their-outcome (notes review).
- A story becomes touched with the reason `slow <scenario> (<s>s)` where its recorded test is among the planning results' slowest `testing.slowest` tests. Its planner rewrites that test at a cheaper reach, with a call naming the waste, where the time comes from a named waste, and otherwise keeps it. Assembly treats a story whose reasons are all `widen` or `slow` as it treats a widen-only story: each recorded scenario its planner names nowhere stands. Decided by: W6 ("its planners replan a slow test"), and settings-have-no-code-defaults for the cutoff.

**Changes**
- `scripts/tests::window_touches`: changed. It adds `slow` touches from `-planning-results.json` seconds and `testing.slowest`.
- `scripts/tests::assembled_plan`: changed. The standing rule widens from `touched == ["widen"]` to every reason being `widen` or `slow …`.
- `skills/plan-tests/core.md` story and runtime planners:
  - Read adds the testing standard and the last run's per-test seconds.
  - Plan adds "plan each test at the cheapest reach that proves its outcome, and avoid each waste the testing standard names".
  - The story table and the reasons paragraph add `slow`.
- `{{TEST-PLANNER-REVIEW-PROMPT}}`: Check adds the cheapest-reach and no-waste checks.
- `{{TEST-PLAN-WIDE-REVIEW-PROMPT}}`: adds setup repeated across planners that could be shared.
- `{{TEST-VERIFY-PROMPT}}`: a test is read for each waste (W1).
- `skills/plan-tests/SKILL.md` step 6.1 and `scripts/tests::USAGE` (`groups`): they list the `slow` reason.

**Behavior changes**
- **B16** `scripts/tests::window_touches`.
  - Before: a slow test touches nothing.
  - After: its story is touched with `slow`.
  - Users in the release: `/plan-tests` step 6.
  - Ruling: rewrite.

### W7. The no-defaults coding rule

**Calls**
- Build note: B101's before-state uses the block's own words: rules 1, 3, 4, 6, 7, and 9, and rule 5 before a delete.
- The new rule goes in as rule 10, after rule 9 ("Close with the record"). Rules 1–9 keep their numbers. Decided by: the numbered references other files hold, `failure-paths.md` F2 ("coding rule 4.3") and `skills/_converge/coding-rules.md` ("rules 1, 3, 4, 6, 7, and 9", "rule 9.4"). Inserting the rule earlier would shift those numbers.
- The cheatsheet's ambient copy goes in a new `## Settings` section after `## Explicit Code`, which already says "Configuration as visible objects". It carries no `<!-- lint-check -->` marker, because no lint check enforces it. Decided by: settings-have-no-code-defaults ("no lint enforces it") and the way true-up's `render_rules` handles marker blocks.
- The Mechanical Checks bullet reads, in substance: "Where only judgment decides a rule, such as telling a setting from a constant, review under the accept list's rule entry is its check, and no lint is owed." It does not name the entry number. Decided by: W7's text, and the fact that the accept list is suite-owned and its numbering could change.
- No accept-list change is needed. A8 already names `plumbline-coding.md` as a rule source, so rule 10 counts as soon as it lands. Decided by: accept-list-decides-defects.
- Overlap: W1 rewrites the cheatsheet's Tests section, W8 adds a section to the same file, and W9 edits its Tooling bullets. Chain these stages.

**Changes**
- `docs/plumbline-coding.md::rule 10 (new)`: new. It states the failure it prevents (a default in code shared by every deployment that never set the key) and the steps:
  - A setting is a value an operator could sensibly want to differ between deployments: an interval, limit, threshold, size, timeout, or address, including a tuning literal and a library parameter.
  - Values fixed by the product's design, a spec, a protocol, arithmetic, or a data format stay constants.
  - Code reads every setting from configuration with no default. On a missing key it refuses to start and names the key.
  - The change that removes a default writes the key, at its former value, into every deployment script and configuration file the project owns, and takes a boundary ruling where a new required key would break a user.
  - Evidence in the note: each setting removed, with its key and former value, and each file written.
- `docs/plumbline-cheatsheet.md::## Settings (new)`: new. The condensed copy of rule 10.
- `docs/plumbline-cheatsheet.md::## Mechanical Checks`: changed. Gains the judgment-rule bullet.
- `skills/_converge/coding-rules.md::{{CONVERGE-CODING-RULES}}`: changed. It names rules 1, 3, 4, 6, 7, 9, 10, and 11 (with W8), and its summary clause gains "read every setting from configuration with no default, and give every timer a time control".

**Behavior changes**
- **B100** `docs/plumbline-coding.md` and `docs/plumbline-cheatsheet.md`. Before: no rule covers defaults in code. After: every agent that writes code refuses to add one, and review counts one as a defect under the rule entry. Users: in the release: every agent that loads `.claude/rules/` (the rules are vendored with the release), and `/converge` hunters, fixers, and verifiers through A8. Across the public surface: `/converge` and `/plan-sprint` callers, who type the same verbs with the same arguments. Ruling: migrate: the verbs accept the same arguments, and the new defects follow from the decision (call).
- **B101** `skills/_converge/coding-rules.md::{{CONVERGE-CODING-RULES}}`. Before: converge and build agents are bound to rules 1, 3–7, and 9. After: also rules 10 and 11. Users: in the release: every prompt that transcludes the block (converge prompts and the sprint build prompt, through `block_sources`). Ruling: rewrite.

### W8. The time-control coding rule

**Calls**
- The rule goes in as rule 11, after rule 10, for the same numbering reason as W7. Decided by: the references named under W7.
- The code planner names each time control under a new `**Time controls**` heading per work item, and adds the time control's code to Changes. The notes form carries the same heading, and a work item that adds no timer omits it. Decided by: W8 ("as part of that work item's notes"), and the shape of the existing **New surface** heading.
- The implementation notes reviewer's two checks stay as they are. A missing time control lands under its "Everything else … Build notes" line. Decided by: W8 names the code planner only.
- Overlap: same cheatsheet file as W1, W7, and W9; same `skills/plan-sprint/core.md` as W11 (step 9) and W22 (SKILL.md Frame/Reconcile is a different file, but in the same skill).

**Changes**
- `docs/plumbline-coding.md::rule 11 (new)`: new. Every timer, schedule, and threshold-driven event has a time control:
  - The three forms are a manual trigger, an injectable clock, or an exposed setting (cross-referencing rule 10).
  - A control that forces an event or moves time is a gated element behind an on-off gate setting: off in production configuration, on in a test stack's.
  - Code that changes behavior because a test is running remains a defect.
  - Evidence in the note: each timer with its control and gate setting. The rule binds existing code too.
- `docs/plumbline-cheatsheet.md::## Time controls (new)`: new. The condensed copy.
- `skills/plan-sprint/core.md::{{CODE-PLANNER-PROMPT}}`: changed.
  - A new step after step 2: for each timer, schedule, or threshold-driven event the changes add, name its time control and form, and its gate setting where it forces an event or moves time, then add the control to Changes.
  - The Output gains `**Time controls**`, with lines of the form `- <path>::<symbol>: <form>, <the control>[; gate: <setting key>]`.
- `skills/plan-sprint/core.md::{{IMPLEMENTATION-NOTES-FORM}}`: changed. The same heading, and the omit-when-empty sentence.

**Behavior changes**
- **B102** `docs/plumbline-coding.md` rule 11 and its cheatsheet copy. Before: no rule. After: agents add a time control with every timer, and review counts a timer without one as a defect, existing code included. Users: as B100. Ruling: migrate: same arguments accepted, and the requirement follows from every-timer-has-a-time-control (call).
- **B103** `skills/plan-sprint/core.md::{{CODE-PLANNER-PROMPT}}` and `{{IMPLEMENTATION-NOTES-FORM}}`. Before: the notes carry Calls, Changes, Improvements, and Behavior changes. After: they also carry Time controls. Users: in the release: the `/plan-sprint` session's step that writes the notes (SKILL.md step 4 of code planning, which follows the form), the notes reviewer, sprint build tasks, and sprint certification. All read the notes as prose. No script parses those headings (`rg` over `scripts/` and `admin/` finds none). Ruling: rewrite.

### W9. The suite's own tools give no setting a default

**Calls**
- Build note: the sweep of default-claiming text covers the plumbline cheatsheet's `## Tests` line that says `tests` replaces the defaults, which W1 also edits; chain the two stages.
- Build note: W9 and W13 both change `scripts/surface-corpus::main`; chain them.
- Build note: W9, W17 (I200), and W23 (I3) all validate `checks`; build one `review.declared_checks` and call it from `tests::cmd_ports`, `review::check_failures`, and `review::cmd_checks`.
- Build note: write the `stack_helpers` keys into this repo's config in the same stage as W24, or earlier, since the drive's `resource-stop` runs the working-tree `stack down`.
- **How I told a setting from a constant.** A value is a setting where its right value depends on the deployment (the machine, the project's size, its stack, or the owner's tolerance), so two projects could sensibly hold different values. That covers timeouts and waits on outside processes, poll intervals, staleness ages, retry counts, input size limits, a heuristic's threshold over the project's own corpus, and the value of any key configuration already offers to replace. A value stays a constant where the suite's design fixes it for every project:
  - a number skill text states as part of a ceremony's shape (planner group sizes, drain caps);
  - the shape of a record or generated file (output tails, TOC summary width, the index digest window, the binary-sniff size);
  - a value fixed by a spec or protocol (port 0, 49152, 1024/65535, signal base 128, the XDG fallback);
  - the base of a list a project can only add to (the lint's built-in ignore folders, the known test runners).
  Decided by: the settings-have-no-code-defaults Choice.
- **How I decided CLI flag defaults (call).** A flag is an invocation's input, which the caller passes each time it wants something else. So a flag's default moves only where it carries a deployment tuning value. Every flag default in the payload names a design constant (`--key gate`, `--agent ok-opus`, `--prompt merge|fix`, `--kind task`, `--mark batched`, `--sprint none`, `--base none`, empty lists), a record shape (`tasks exec --tail 200`), a ceremony shape the skill text states (`tests groups --size 8`, "up to 8" in `/plan-tests`), or a protocol value (`dashboard --port 0`, OS-assigned). So no flag default moves, and every flag stays as a per-call override. Decided by: the same Choice, where a setting is a deployment's value.
- **Settings moved to `.ok-planner/config.json`**, each written by true-up at its former default:

  | Key | Former default | Read by |
  |---|---|---|
  | `citations` | `[]` | lint |
  | `ignore` | `[]` (additions only; the base list stays a constant) | lint |
  | `tests` | `["test/","tests/","spec/","specs/","__tests__/","testdata/","*_test.*","*.test.*","*.spec.*","test_*","*_spec.rb","conftest.py"]` (from the lint's `TEST_PATH_PATTERNS`) | lint, `tests` through `plumbline test-paths` |
  | `lint_checks` | `{"comment-hygiene": true, "citation-resolution": true, "no-tests": true}` (each unnamed check written `true`) | lint, true-up `chosen_lint_checks`, `review.project_runners` |
  | `folders` | `["."]`, the estate root alone | lint, review, tests |
  | `ports` | `[]` | ports, stack, lint `stackDefects` |
  | `title` | `"ok-planner dashboard"` (`dashboard::DEFAULT_TITLE`) | dashboard |
  | `dashboard.max_body_bytes` | `1048576` (`MAX_BODY`) | dashboard |
  | `dashboard.max_file_bytes` | `1048576` (`MAX_FILE`) | dashboard |
  | `stack_helpers.docker_query_seconds` | `15` (`docker-sweep::QUERY_SECONDS`) | docker-sweep, ports `published`, stack probes |
  | `stack_helpers.docker_removal_seconds` | `120` (`REMOVAL_SECONDS`) | docker-sweep |
  | `stack_helpers.lease_stale_seconds` | `3600` (`ports::GRACE_SECONDS`) | ports `stale` |
  | `stack_helpers.run_stale_seconds` | `3600` (`stack::GRACE_SECONDS`) | stack `cleanup` |
  | `stack_helpers.start_attempts` | `3` (`START_ATTEMPTS`) | stack `up` |
  | `stack_helpers.stop_wait_seconds` | `10` (`run-group::STOP_WAIT_SECONDS`) | run-group `stop` |
  | `stack_helpers.kill_wait_seconds` | `2` (`KILL_WAIT_SECONDS`) | run-group `stop` |
  | `stack_helpers.poll_seconds` | `0.2` (`POLL_SECONDS`) | run-group `stop` |
  | `surface_corpus.rare_share` | `0.30` (`MAX_DOC_FRACTION`) | surface-corpus |
  | `testing.runners` | `[]`, written only where `testing` exists | review `project_runners` |

  The two staleness ages stay separate keys, one per tool registry.
- **Settings in `.ok-planner/review/config.json`**, which already holds most keys:
  - `block_sources`: former default `[]`.
  - `standards`: former default `[]` in code. True-up's existing `missing_standards`/`standards_added` transform already writes the seed list where the key is absent, so it stays the writer.
  - `python`: absent meant no re-exec. True-up writes `{"minimum": [3, 10], "command": ["python3"]}`. This differs only below 3.10, where review cannot run anyway: it uses `zip(strict=True)`.
  - `prompts_dir`: it had no default (a KeyError crash), so it joins true-up's question keys, not the written keys.
  - `hunt.*`, `fix.group_size`, and `checks` already refuse when missing.
- **Constants that stay**, each with its reason: the lint's `DEFAULT_IGNORE_PATTERNS` (a base a project adds to; `.ok-planner/` and `.git/` are fixed by design and git); `review::TEST_RUNNERS` and `COMMAND_WRAPPERS` (a base a guard only widens); `SNIFF_BYTES`; `tasks::TAIL_BYTES`, `DEFAULT_CALLS`, and the run's `item_states`/`swept_roles` (run log format, set by the ceremony); the calls-cell truncation `[:100]`; `tests::TAIL_LINES` and `GROUP_SIZE`; `catalog-toc::SUMMARY_CHARS`; `surface-corpus::MIN_TOKEN_LEN` (it pairs with the stop list) and `TOP_N` (the cap of what a triage agent reads); `ports::SUGGESTED_SPAN` (it shapes the owner's suggestion, and `port_range` is the setting); `DEFAULT_EPHEMERAL_START`, `LOWEST_PORT`, `HIGHEST_PORT`, `PORT_RANGE_FLOOR`, `PORT_CEILING`; `dashboard::HOST` (loopback, by decision); `issues::USER_CONFIG`'s XDG fallback; the `OK_PLANNER_PROJECT_ROOT`/cwd discovery; true-up's `WS_DEFAULT_TREES`/`WS_DEFAULT_BRANCHES` (the retired product's own data format); and the hook timeouts true-up wires (10 and 30), which already live in the project's `.claude/settings.json`. The hooks read no settings.
- **`testing` stays a declaration.** Its absence already refuses in `tests::testing_config`, and review then adds no project runners. W2 owns the shape of `testing`: `testing.timeout` (former default 600, `tests::DEFAULT_TIMEOUT`) becomes W2's silence period, which follows this rule with no default, and W2's true-up question writes it. `stack` already refuses in `stack up` where absent.
- **One reader.** It lives in `tasks`, which every Python script loads: `tasks.project_config(root)` and `tasks.setting(config, "<dotted.key>")`, raising `tasks.Unset` with a message that names the key and says to run `/ok`. Each tool's owner frame adds `tasks.Unset` to the refusals it already catches, the shape `stack::main` uses for its tuple of module Refusals. Decided by: coding rule 2 (sibling shape) and rule 6 (import, never copy).
- **`plumbline config-check` keeps its meaning:** it validates present keys and reports no missing key. It gains validators for `stack_helpers`, `dashboard`, and `surface_corpus`: waits and ages are non-negative numbers, so 0 is allowed (W10); `start_attempts` is an integer of at least 1; `poll_seconds` is above 0; the byte limits are positive integers; `rare_share` is in (0, 1]. Missing keys are refused at use and in true-up's `amend`. Decided by: the review's use of config-check for `folders`, which must not switch to "root alone" because an unrelated key is absent.
- **The former-defaults table** lives in `admin/true-up` as one constant mapping for each config file, its only reader. Decided by: rule 6.
- **Creating the config is non-destructive.** True-up's creation of a missing `.ok-planner/config.json` is a `missing:` step, like `seed_review_config`. Writing missing keys into an existing config is a `DESTRUCTIVE: rewrites …` step under the owner's one consent, like every owner-file rewrite in `rewrite_steps`. Decided by: the sibling shapes in true-up.
- **Writing `folders: ["."]` into this repo's config ahead of `/ok`** makes the old vendored lint list the root twice on a whole-root run, which doubles each violation line. File-target runs, such as certification's checks over changed files, are unaffected, and the old review strips ".". The keys still go in now, because the working-tree stack tool the drive runs reads them. Decided by: W9's text and `project.md`'s drive commands.
- **Overlaps:**
  - W2 (tests script; `plan-tests/SKILL.md` "600 seconds where absent"; `plumbline::TESTING_KEYS`/`testingDefects`; the cheatsheet's Tooling `testing.run` line; true-up's `testing` question), and W3 and W5 (tests script; W5's new resource-count command is a setting under this rule).
  - W23 (`tests::cmd_ports` and the review runner check).
  - W16, W17, and W18 (`scripts/review`).
  - W27 (`scripts/plumbline`).
  - W24 (`.ok-planner/review/project.md`).
  - W1, W7, and W8 (the cheatsheet).
  - W14 (true-up `rewrite_plan`).
  Chain the stages that share these files.

**Changes**
- `scripts/tasks::project_config`, `setting`, `Unset`: new. They read `.ok-planner/config.json` from the project root, refuse a missing or unparseable file or a missing key, name the dotted key, and say `run /ok, which writes it`.
- `scripts/plumbline::loadConfig`: changed.
  - It refuses (exit 1) an absent config, and each missing key among `citations`, `ignore`, `tests`, `lint_checks`, and `folders`, or a `lint_checks` that leaves out a check.
  - `tests` comes from config alone, and a check runs where its `lint_checks` value is `true`.
  - `TEST_PATH_PATTERNS`, `TEST_PATH_DIRECTORIES`, and `TEST_PATH_BASENAME_GLOBS` are removed once `rg` shows they have no other use.
- `scripts/plumbline::folderPaths`: changed. Drops entries that resolve to the project root, so `["."]` adds nothing to `[resolved, ...config.folders]`.
- `scripts/plumbline::CONFIG_KEY_DEFECTS`: changed. Adds the `stack_helpers`, `dashboard`, and `surface_corpus` validators.
- `scripts/review::load_config`: changed. Its required keys gain `block_sources`, `standards`, `python`, and `prompts_dir`. `block_sources` and `cmd_prompt` (`standards`) read with no `.get(…, [])` fallback, and `run_under_project_python` reads `python` unconditionally.
- `scripts/review::declared_folders`: changed. It reads through `tasks.project_config`, and a missing `folders` refuses. It keeps the config-check validation, and the "malformed → root alone" note for a malformed value.
- `scripts/review::project_runners`: changed. It reads through `tasks.project_config` and `setting(…"lint_checks")`, and refuses a missing file instead of returning the base runners.
- `scripts/review::main`: changed. It catches `tasks.Unset` with `ReviewError`.
- `scripts/tests::testing_config`: changed. It reads through `tasks.project_config`. The timeout fallback is W2's.
- `scripts/tests::cmd_ports` and `complete_failures`: changed. They refuse a review config without `checks` instead of `or []`/`or {}`.
- `scripts/dashboard::serve`: changed. Before it binds, it reads `title`, `dashboard.max_body_bytes`, and `dashboard.max_file_bytes`, and refuses (exit 1, naming the key) where any is missing. `place` reads no setting.
- `scripts/dashboard::page_title`: changed. It returns the title read at start, with no `DEFAULT_TITLE` and no `except ValueError` fallback.
- `scripts/dashboard` (`MAX_BODY`/`MAX_FILE` sites): changed. The 413 checks use the limits read at start. `DEFAULT_TITLE`, `MAX_BODY`, and `MAX_FILE` are removed.
- `scripts/docker-sweep::docker_out`, `docker_ids`, `tagged_ids`, `docker_reached`, `sweep`, `running`, `published_ports`, `answering_docker`: changed. They take the query and removal seconds as explicit parameters, with no `seconds=QUERY_SECONDS` default.
- `scripts/docker-sweep::main`: changed. It reads the two keys through `tasks`, and `tasks.Unset` maps to exit 1. The USAGE text names the keys, and "read nothing of the project" becomes "read the two `stack_helpers` docker keys".
- `scripts/ports::read_config`: changed. It delegates to `tasks.project_config`, and an absent file refuses. `GRACE_SECONDS` is removed.
- `scripts/ports::stale`: changed. Reads `lease_stale_seconds`.
- `scripts/ports::published`: changed. Passes `docker_query_seconds`.
- `scripts/ports::main`: changed. Maps `tasks.Unset` to a refusal. The USAGE text names the keys.
- `scripts/stack::up`: changed. Reads `start_attempts`. `START_ATTEMPTS` is removed.
- `scripts/stack::cleanup`: changed. Reads `run_stale_seconds`, and its `younger than an hour` line names the configured seconds. `GRACE_SECONDS` is removed.
- `scripts/stack` probe and sweep sites (`sweep_run`, `record_docker` callers): changed. They pass the docker seconds.
- `scripts/stack::take_down`: changed. Passes the waits to `group.stop`.
- `scripts/stack::main`: changed. Catches `tasks.Unset`. The USAGE text names the keys.
- `scripts/run-group::stop`, `stop_group`, `wait_group_empty`: changed. They take the wait, kill-wait, and poll seconds as parameters. `main` reads the keys for `stop`. `STOP_WAIT_SECONDS`, `KILL_WAIT_SECONDS`, and `POLL_SECONDS` are removed, and the USAGE text names the keys.
- `scripts/surface-corpus::main`: changed. Reads `surface_corpus.rare_share`, and catches `tasks.Unset` beside `issues.Refusal`. `MAX_DOC_FRACTION` is removed.
- `admin/true-up` (new former-defaults tables, `FORMER_PROJECT_SETTINGS` and `FORMER_REVIEW_SETTINGS`): new.
- `admin/true-up::lint_config_transforms`: changed. A final transform writes each table key the config lacks, plus `testing.runners` where `testing` exists, with the detail `it declares no <keys>; true-up writes each with its former default`.
- `admin/true-up::lint_config_plan` and a new creation step: changed and new. Where no config exists and no plumbline migration blocks or moves one, a `missing: .ok-planner/config.json — true-up writes it holding each setting at its former default` step writes the full table.
- `admin/true-up::config_questions`: changed. The `lint is None` branch goes. The citation question then reads `add … to its citations`.
- `admin/true-up::without_compose_checks`: changed. Keeps `lint_checks`, with every remaining check named.
- `admin/true-up::review_config_transforms`: changed. A transform writes each `FORMER_REVIEW_SETTINGS` key that is absent, ahead of the `review_config_text_defects` gate.
- `admin/true-up::REVIEW_CONFIG_KEYS`: changed. Gains `prompts_dir`.
- `admin/true-up::CONFIG_CHECK_KEYS`: changed. Gains `title`, `ignore`, `dashboard`, `stack_helpers`, and `surface_corpus`.
- `admin/true-up` amend branch: changed. Refuses a draft missing any key in the table.
- `checks/materialized-standalone`: changed. Copies `project/.ok-planner/config.json` into `lint_dir/.ok-planner/config.json` before it lints.
- Texts that claimed defaults, enumerated with `rg`:
  - `scripts/ok-planner-CLAUDE.md` § The configuration ("a check it does not name is on", "`ok-planner dashboard` where absent", "An absent file means the defaults"). It gains the new keys, and `folders` becomes "the folders the project owns, the estate root alone in a single-folder project".
  - `scripts/ok-planner-cheatsheet.md` `config.json` bullet.
  - `docs/plumbline-cheatsheet.md` Tooling bullets ("(optional)", "a check it does not name is on", "replacing the defaults"; the `testing.run` clause is W2's).
  - `admin/ADMINISTRATION.md`: line 220 "An absent config means the defaults" and the list of core-written exceptions, which gains the former-default writes; line 224, the `lint_checks` absence clause and "dropping `lint_checks`". Also document the creation step and the review-config writes.
  - `docs/stack-helpers.md` lines 21, 81, 139, 145, 188–190, 229–230, 403, and 424: the keys in place of literals, and docker-sweep's read of the project.
  - The usage texts of ports, docker-sweep, run-group, and stack.
- `.ok-planner/config.json` (this repo): changed. Adds `ignore`, `tests`, `lint_checks`, `folders: ["."]`, `ports: []`, `dashboard`, `stack_helpers`, and `surface_corpus` at the former defaults. `citations`, `title`, and `stack` stay as written.
- `.ok-planner/review/config.json` (this repo): no change. It already holds `block_sources`, `standards`, `python`, and `prompts_dir`.
- `.ok-planner/review/project.md` (this repo) § Scripts for developers and operators: changed.
  - docker-sweep "reads nothing of the project, and needs no estate" becomes "reads the two `stack_helpers` docker keys from the estate it finds as `tasks` does".
  - The 15 s, 120 s, 10 s, 2 s, "an hour", and "3 attempts" values name their keys.
  - The plumbline line says it refuses an absent config or a missing lint key.
  - The dashboard line says the service refuses to start without its keys.

**Improvements**
- **I100** `scripts/ports::read_config`, `review::declared_folders`, `review::project_runners`, `tests::testing_config`, `dashboard::page_title`: one mechanism built five times. Each read and judged `.ok-planner/config.json` on its own. Afterward: all of them go through `tasks.project_config`/`setting`.
- **I101** `scripts/dashboard::page_title`: rule 4.6 (A8). A config parse error ended in a silent default title. Afterward: the service refuses at start and names the parse error.
- **I102** `scripts/review::load_config`/`cmd_prompt`: A3, because review is a listed operator script. A missing `prompts_dir` raised a KeyError that ended as `REVIEW.RUN.FAILED` without naming the key. Afterward: `load_config` refuses and names it.
- **I103** `scripts/review::project_runners`: rule 4.6 (A8). A non-object config silently returned the base runners. Afterward: the shared reader refuses it.

**Behavior changes**
- **B104** `scripts/plumbline::loadConfig`. Before: an absent config or an absent key meant built-in values. After: exit 1, naming the file or key and `/ok`.
  - Users in the release: `hooks/post-edit.js` (exit 1 shows the message and blocks nothing), `review checks` through `node .ok-planner/bin/plumbline`, `tests` through `plumbline test-paths`, and `checks/materialized-standalone` (changed above).
  - Across trued-up projects: each project's config.
  - Ruling: migrate: true-up creates the file or writes each missing key at its former default before the new lint can run, because the lint is vendored by the same true-up (call).
- **B105** `scripts/plumbline::folderPaths`. Before: a `folders` entry naming the root linted the root twice on a whole-root run. After: once. Users: in the release: `lintCmd`/`runLint`. Ruling: rewrite.
- **B106** `scripts/plumbline::CONFIG_KEY_DEFECTS`. Before: `stack_helpers`, `dashboard`, and `surface_corpus` went unchecked. After: config-check reports a malformed value. Users: in the release: true-up `parsed_config` (the plan and `amend`), `review::declared_folders`. Ruling: rewrite.
- **B107** `scripts/review::load_config`. Before: absent `block_sources`/`standards` read as `[]`, an absent `python` meant no re-exec, and an absent `prompts_dir` crashed. After: each refuses with its name. Users: in the release: every `review` verb, plus `tests` and `docs`, which load review. Across trued-up projects: review configs. Ruling: migrate: true-up writes `block_sources`/`python` at their former defaults, the existing transform writes `standards`, and `prompts_dir` joins the review-config question (call).
- **B108** `scripts/review::declared_folders`, `project_runners`. Before: an absent `folders` meant the root alone, and an absent config meant the base runners. After: both refuse. Users: in the release: `review changed`/`areas`/`checks`/`snapshot`/`certified`, and `tests window`/`groups`/`plan`. Across trued-up projects: configs. Ruling: migrate: true-up writes `folders: ["."]` and the full `lint_checks` (call).
- **B109** `scripts/tests::cmd_ports`, `complete_failures`. Before: a review config without `checks` read as none. After: refuses. Users: in the release: `/plan-tests` and the test sprint. Ruling: rewrite (call): seeding always writes `checks`, and review already refuses its absence.
- **B110** `scripts/dashboard::serve`/`page_title`. Before: a missing title showed `ok-planner dashboard`, a malformed config showed it too, and the limits were fixed at 1 MiB. After: the service refuses to start without the three keys. Users: in the release: `/dashboard` (it relays an early exit from its log), and the drive steps in `project.md` (their scratch project's true-up writes the keys). Across the public surface: `/dashboard` callers, with the same arguments. Ruling: migrate: true-up writes `title` and the limits (call).
- **B111** `scripts/docker-sweep::main`. Before: it read nothing of the project and ran with no estate. After: it reads two keys from the estate it finds, and refuses (exit 1) without them. Users: in the release: ports and stack, which load it and pass the seconds. Across trued-up projects: a project's own stack scripts. The examples in `stack-helpers.md` call `.ok-planner/bin/docker-sweep` from the project root. Ruling: migrate: true-up writes the keys, and callers run inside the project (call).
- **B112** `scripts/ports::stale`/`published`, `stack::up`/`cleanup`/`take_down`, `run-group::stop`. Before: fixed literals, and cleanup printed "younger than an hour". After: the values come from `stack_helpers`, a missing key refuses, and the line names the seconds. Users: in the release: the stack tool's verbs, and the drive commands in `project.md` (this repo's config gains the keys). Across trued-up projects: configs. Ruling: migrate: true-up writes the keys (call).
- **B113** `scripts/surface-corpus::main`. Before: a fixed 0.30 share. After: reads `surface_corpus.rare_share`, and refuses where absent. Users: in the release: the `/triage-issues` triage and respond prompts, and `/plan-sprint`'s issue walk. Ruling: migrate: true-up writes it (call).
- **B114** `admin/true-up::config_questions` and the creation step. Before: a project with no config got the `citation-tags` question asking the owner to write a file holding only citations. After: true-up writes the file and asks the citation question as an addition. Users: in the release: `plugins/ok/skills/ok/SKILL.md`, which relays questions. Across the public surface: `/ok` callers, with the same arguments. Ruling: migrate: `/ok` accepts the same input, and settings-have-no-code-defaults commits true-up to write the keys (call).
- **B115** `admin/true-up::lint_config_transforms`, `review_config_transforms`. Before: no write of missing keys. After: one destructive rewrite step per config, under the owner's one consent. Users: as B114. Ruling: migrate, as B114 (call).
- **B116** `admin/true-up::without_compose_checks`. Before: it dropped `lint_checks` when it emptied the key. After: it keeps every check named. Users: in the release: the plan's rewrite of retired compose names. Ruling: rewrite.
- **B117** `admin/true-up` amend. Before: a draft without a key passed. After: refused, naming the key. Users: in the release: `/ok` drafting `config`/`port-range` answers (it drafts the whole file with every other key kept). Ruling: rewrite.
- **B118** `checks/materialized-standalone`. Before: it linted a folder with no config. After: it gives the folder the scratch project's config. Users: in the release: `checks/run`. Ruling: rewrite.

**New surface**
- Config keys `dashboard.*`, `stack_helpers.*`, and `surface_corpus.*`, declared in `admin/true-up` and validated in `scripts/plumbline`: internal ("the fields of a project's configuration" are internal).

### W10. The suite's own timers get time controls

**Calls**
- Every timer and threshold-driven event in the payload's scripts takes the exposed-setting form, through W9's keys. A caller makes each event happen now by setting its wait or age to 0 (an immediate timeout, or a lease or run that is stale at once), so no gated manual trigger or injectable clock is needed and nothing is gated. Decided by: every-timer-has-a-time-control (three forms; gating only where a control forces an event or moves time).
- `rg` across the scripts, hooks, and dashboard finds no schedule. The locks (`fcntl.flock`) block with no timer. The dashboard's `serve_forever` has none. `START_ATTEMPTS` is a retry count, not a timer (it is a W9 setting). True-up holds no timer of its own; its hook timeouts already live in `.claude/settings.json`.
- W10 lands in the same stages as W9's `stack_helpers` changes and shares their overlaps.

**Changes**
- `scripts/plumbline::CONFIG_KEY_DEFECTS` (`stack_helpers` validator): changed under W9. Waits and ages accept 0. `poll_seconds` must be above 0.
- The usage texts of docker-sweep, ports, stack, and run-group, and `docs/stack-helpers.md`: changed under W9. Each timer names its key.

**Time controls**
- `scripts/docker-sweep::docker_out` (query timeout): exposed setting `stack_helpers.docker_query_seconds`. This one setting also times ports' docker check and stack's daemon probes.
- `scripts/docker-sweep::sweep` (removal timeout): exposed setting `stack_helpers.docker_removal_seconds`.
- `scripts/ports::stale` (lease staleness): exposed setting `stack_helpers.lease_stale_seconds`.
- `scripts/stack::cleanup` (run staleness): exposed setting `stack_helpers.run_stale_seconds`.
- `scripts/run-group::stop_group` (SIGTERM and SIGKILL waits; poll tick): exposed settings `stack_helpers.stop_wait_seconds`, `kill_wait_seconds`, and `poll_seconds`.
- `scripts/tests` (per-test limit): W2's silence period, an exposed setting.

**Behavior changes**
- None. Every change is new code no existing user reaches. The value changes are W9's B111 and B112.

### W11. Gated elements stay internal

**Calls**
- A reader tells a gated element from the code: an element the product exposes only while an on-off gate setting is on. Decided by: gated-elements-stay-internal ("Reading the gate from the element itself").
- I add one sentence to `{{RELEASE-BOUNDARIES}}`'s public-surface paragraph ("A gated element is internal whatever its class, so changing or removing one crosses no release boundary"), because the code planner and `/converge`'s fix and verify prompts transclude that block, not the artifact definition. Decided by: gated-elements-stay-internal ("crosses no release boundary").
- The restatements `rg` finds of "a new member of a class a rule already makes public" (`scripts/ok-planner-CLAUDE.md:149`, `scripts/ok-planner-cheatsheet.md:290`, `plan-sprint/SKILL.md:118`) gain "save a gated element". Decided by: rule 1 and the amended surface-intent-changed-by-sprints.
- `scripts/review::areas` needs no change: it cuts one area per declaring file and lists no members.
- Overlaps: W19 (`plan-docs/core.md` planner, style, and checker prompts), W18 and W21 (`converge/SKILL.md`, merge prompt), W22 (`plan-sprint/SKILL.md`), W8 (`plan-sprint/core.md`).

**Changes**
- `skills/_shared/artifact-definitions.md::{{SURFACE-INTENT-DEFINITION}}`: changed. A new bullet: a gated element is internal whatever its class; no class rule reaches it; it becomes public only through a delta that names it; whoever lists a class's members leaves it out. `discover-design/core.md` transcludes the block and gets it unchanged.
- `skills/_shared/artifact-definitions.md` § `## Lists` bullet (line 173): changed. Adds "and no gated element".
- `skills/plan-docs/core.md::{{DOC-PLANNER-PROMPT}}` (line 110, "list each class's public elements"), `{{DOC-WRITE-PROMPT}}` (step 4, and the doc-comment sentence), `{{DOC-CHECK-PROMPT}}` (line 357): changed. Each leaves gated elements out, and the checker counts a listed gated element as false.
- `skills/converge/prompts/hunt-flow.md` (the "list every entry point" step): changed. Leaves out each entry point the code exposes only behind a gate setting.
- `skills/converge/SKILL.md` lines 14 and 89 ("each entry point that file declares"): changed to match.
- `skills/plan-sprint/SKILL.md` § The surface (line 118): changed. Adds "save a gated element, which stays internal until a sprint's surface intent delta names it".
- `skills/plan-sprint/core.md::{{CODE-PLANNER-PROMPT}}` step 9: changed. A gated element is listed `internal` whatever its class.
- `skills/_sprint/shared.md::{{RELEASE-BOUNDARIES}}`: changed. The sentence above.
- `scripts/ok-planner-CLAUDE.md` § The public surface, `scripts/ok-planner-cheatsheet.md` § The public surface: changed. "save a gated element".

**Behavior changes**
- **B119** `skills/_shared/artifact-definitions.md::{{SURFACE-INTENT-DEFINITION}}`. Before: a class rule reached every member. After: gated members are internal. Users: in the release: every prompt that transcludes the block (`/plan-sprint`, `/discover-design`). Ruling: rewrite.
- **B120** `skills/plan-docs/core.md` planner, writer, and checker. Before: reference documentation listed gated members of a listed class. After: it leaves them out, and the next documentation sprint drops any listed one. Users: in the release: documentation sprints. Across the public surface: `/plan-docs` callers, with the same arguments. Ruling: migrate: same arguments accepted, and the output follows gated-elements-stay-internal (call).
- **B121** `skills/converge/prompts/hunt-flow.md`, `converge/SKILL.md`. Before: a flow hunt traced every entry point in the declaring file. After: it skips gated ones, which file areas still hunt. Users: in the release: `/converge analysis`. Across the public surface: `/converge` callers, with the same arguments. Ruling: migrate, as B120 (call).
- **B122** `skills/plan-sprint/SKILL.md` surface step, `core.md` step 9, `_sprint/shared.md::{{RELEASE-BOUNDARIES}}`. Before: a new gated element in a public class was public, and changing it was a boundary question. After: it is internal and asks nothing. Users: in the release: `/plan-sprint`'s code planner and notes reviewer, and `/converge`'s fix and verify prompts. Ruling: rewrite.

### W12. A legacy sort ports a test whose rule no document states

**Calls**
- Build note: `tests rules [--json]` runs at every `/plan-sprint` Frame; it needs no `testing` config and no test-state file, and prints an empty list where the state is absent.
- A sort records a port of an unwritten rule as `rule=inferred --field inferred="<the rule, one sentence>"`. A port of a written rule keeps `rule=<kind:slug | rules file>`.
  - Assembly refuses `rule=inferred` with no `inferred` text, and `inferred` text with any other rule.
  - `tests plan --show` adds an "Inferred rules" section: each rule with its test and check.
  - The report's "Legacy tests ported" line and the veto problem of step 8 name the inferred rule.
  - Decided by: decision legacy-suites-sorted-automatically.
- To let the next `/plan-sprint` meet each surviving rule, `tests stamp` records it in `.ok-planner/test-state.json` under `inferred`: `{rule, check, command, test, sprint}`.
  - `tests rules [--json]` lists each recorded rule that is not settled and whose command still stands in review `checks`; this is "surviving".
  - `tests rules take <check> --as practice:<slug> | retired` settles one. It refuses an unknown or settled check, and a practice with no `.ok-planner/practices/<slug>.md`.
  - Decided by: decision intake-writers-are-gated. Filing an issue per rule would add an ungated intake writer, so the record stays with the tool that alone writes the state.
- `/plan-sprint` Frame runs `tests rules --json`, sets each rule apart, and counts it in the opening line. Resolve walks each with the owner, who picks one of three answers:
  - *practice*: draft the practice delta with the owner, and a work item that ends with `tests rules take <check> --as practice:<slug>`;
  - *retire*: a work item that removes the command from `.ok-planner/review/config.json` `checks`, deletes the check program, and runs `tests rules take <check> --as retired`;
  - *postpone*: it stays listed.

  The build task's run of `bin/tests rules take` runs no test, so the plan-sprint rule against work items that run tests holds. Decided by: W12.
- Overlap: W22 changes `/plan-sprint`'s Frame and Reconcile, and W11 its surface step. Both share `skills/plan-sprint/SKILL.md` with the Frame and Resolve additions here.

**Changes**
- `skills/plan-tests/core.md::{{TEST-SORT-PROMPT}}`:
  - The port row reads "a rule on the code's shape, written or not". Port recording adds the `inferred` field. The delete row reads "no story names and no rule on the code's shape covers, written or inferred".
  - Read step 4 says to infer a rule where no document states one.
- `{{TEST-PLANNER-REVIEW-PROMPT}}`: "Each legacy port names a written rule" now also accepts the stated inferred rule on the code's shape.
- `{{TEST-LEGACY-PROMPT}}`: the brief and record carry the inferred rule.
- `scripts/tests::assembled_plan` (the legacy entry gains `inferred`), `plan_failures`, `print_summary`, and `stage_write` (the legacy brief): changed.
- `scripts/tests::cmd_report` and `cmd_stamp` (writes `inferred`, carrying older entries forward): changed.
- `scripts/tests::cmd_rules`: new, with `build_parser` and `USAGE`.
- `scripts/tests::read_state`: changed. It defaults `inferred` to `[]`.
- `skills/plan-sprint/SKILL.md`: changed. Frame sets the inferred rules apart, and Resolve walks them.
- `skills/plan-tests/test-sprint-document.md` step 8: a port's problem names its inferred rule.
- `skills/plan-tests/SKILL.md` l.8, `scripts/ok-planner-cheatsheet.md` l.361, and `scripts/ok-planner-CLAUDE.md` l.257: "written rule" becomes "rule on the code's shape, written or inferred".

**Behavior changes**
- **B17** `{{TEST-SORT-PROMPT}}` and `scripts/tests::plan_failures`.
  - Before: a test whose rule no document states is deleted as an orphan.
  - After: it is ported, with its inferred rule listed.
  - Users in the release: `/plan-tests`.
  - Ruling: rewrite.
- **B18** `.ok-planner/test-state.json` `inferred`.
  - Before: absent.
  - After: written at stamp and settled by `tests rules take`.
  - Users across stored state: an earlier stamp.
  - Ruling: preserve (call). Absent reads `[]`.
- **B19** `skills/plan-sprint/SKILL.md` Frame and Resolve.
  - Before: there is no inferred-rule walk.
  - After: each surviving rule is walked.
  - Users in the release: the owner in planning, with the skill vendored alongside the tool.
  - Ruling: rewrite.

**New surface**
- `tests rules [--json]` and `tests rules take`, declared in `scripts/tests`: internal (the surface intent makes vendored scripts internal).

### W13. No process reads the issue archive

**Calls**
- `unfiled` reuses `admin/true-up::open_issue_ids` and stops loading records itself. That function already returns the open ids, from the folded pre-v9 log where one stands. Decided by: plumbline-coding rule 6 (import, never copy).
- A refile under an archived id does not collide. The module keys archived records on id and opened time, and `file_issue` refuses only an id that is open, or one closed in the same second. Decided by: `scripts/issues::file_issue` and `::store_key`.
- Consequence: the owner may close a retired-script-caller issue by keeping the retired copy (one of its own options). True-up then files it again on each run while that caller stands. Under the ruling, the owner settles it by changing the caller or the design. Decided by: the owner's ruling as the amended decision states it.
- `surface-corpus` looks up the open record only and refuses a closed id, using the module's refusal: "issue X is closed; its record is in .ok-planner/history/issues.jsonl" (reason `closed`), exit 2. Its callers (triage prompts `triage.md`, `respond.md`; plan-sprint's walk) pass open ids. Decided by: the decision ("no writer, run, or ceremony reads it"), and plumbline-coding rule 6, by reusing `issues.live_record`.
- The rule is written once, in the `id` rule of `{{ISSUE-FILE-FORMAT}}`. The texts that restate a writer's dedup check are already open-only and stay as they are:
  - `owner-list.md` lines 23, 32, 42, 61
  - `_sprint/shared.md` lines 237–241
- The stuck filing with no `issue` field (`owner-list.md` line 49) has no dedup check. It gets the same open-issue check as the others. Decided by: plumbline-coding rule 8 and the W13 text ("each writer checks only the open issues").
- Overlaps:
  - `admin/true-up` and `admin/ADMINISTRATION.md` are also changed by W2, W9, and W14.
  - `skills/_shared/artifact-definitions.md` is also changed by W11.
  - The stage that applies the decision delta also reaches `.ok-planner/design/decisions.md`, through catalog-toc.

**Changes**
- `.ok-planner/design/decisions/intake-writers-are-gated.md`: changed. Apply the revised sidecar body verbatim, then run `python3 .ok-planner/bin/catalog-toc`.
- `admin/true-up::unfiled`: changed. Afterward it is `[issue for issue in issues if issue["spec"]["id"] not in open_issue_ids()]`, reads no archive, and gains a `# @decision: intake-writers-are-gated` annotation. `file_issues` keeps calling it unchanged.
- `admin/ADMINISTRATION.md`, "Callers of retired suite scripts" (line 312): changed. "A filed issue is no longer a step" becomes: an issue the intake holds open is no longer a step; true-up files the issue again, under its id, while its harm stands, whatever the archive holds.
- `skills/_shared/artifact-definitions.md::{{ISSUE-FILE-FORMAT}}`, the `id` rule (line 404): changed. After "An open issue re-observed files nothing.", add: the archive is a record, so no filer reads it to decide what to file, and a harm or question a closed issue named, met again, files a new issue.
- `skills/converge/prompts/owner-list.md`, "A stuck defect is a judgment issue" (line 49): changed. Before filing a new issue for a stuck defect with no `issue` field, read `issues list --json` for an open issue on the same defect. Where one stands, file nothing, and settle the defect with that id as the note.
- `scripts/surface-corpus::main`: changed. `record, _ = issues.find(...)` becomes `live, archive = issues.load(root)` and `record = issues.live_record(live, archive, id)`. A closed or unknown id refuses through the existing `issues.Refusal` branch (stderr, exit 2).

**Behavior changes**
- **B400** `admin/true-up::unfiled`. Before: an issue id the archive holds, in any close, stops both the filing and its `DRIFT:` plan step. After: only an open issue stops them. While the harm stands, the plan lists the filing again and true-up files a new record under the same id. Users: in the release: owners running /ok, and the plan text in `ADMINISTRATION.md` (changed above). Across Trued-up projects: a project whose archive holds a closed true-up issue whose harm still stands gets that issue open again on its next /ok. The archive is read no more; its records and their shape are unchanged. Ruling: rewrite. The owner's ruling, now in the amended decision's Choice, commits to it.
- **B401** `skills/converge/prompts/owner-list.md`, the stuck filing. Before: a stuck defect with no `issue` field files a new issue even where an open issue names the same defect. After: it files nothing, and the defect's note names the open issue. Users: in the release: the owner, and `/triage-issues`. Ruling: rewrite.
- **B402** `scripts/surface-corpus::main`. Before: given an id no open issue holds, it surfaces artifacts from the newest closed record. After: it refuses with the module's "is closed" message, exit 2. Users: in the release: the `triage.md` and `respond.md` prompts and `/plan-sprint`'s walk, which pass open ids. Ruling: rewrite.

### W14. Approved documentation and test sprints cross the true-up boundary

**Calls**
- Call: the documentation-sprint and test-sprint boilerplate histories run after every stage that edits those templates (W19 steps 6 and 7; W1, W3, W4, W5, W12, and W23 in the test sprint template), and hold each line they replace; true-up then brings an approved one's changed steps current. Decided by: `checks/sprint-boilerplate` (notes review).
- Call: no plan-shape transform beyond `folders` is needed: B10, B12, and B15 read an absent field as none. Decided by: those rulings (notes review).
- Build note: the `folders` fill reads the config as the plan leaves it after its rewrites, since W9's transform may write `folders` in the same true-up.
- True-up covers every `.md` under `.ok-planner/test-sprints/` and `.ok-planner/doc-sprints/` (not `history/`), complete or not, as `live_sprints` covers `sprints/`. Decided by: live-sprints-brought-current-on-true-up ("not yet archived").
- Boilerplate is brought current line for line, through the existing `current_section` matcher. The carried templates are `{{TEST-SPRINT-DOCUMENT-TEMPLATE}}` (sections `## How to execute this test sprint` and `## Completion contract`) and `{{DOC-SPRINT-DOCUMENT-TEMPLATE}}` (`## How to execute this documentation sprint` and `## Completion contract`). Each kind gets its own retired-line history file, so `admin/retired-boilerplate.json`, which W25 and W26 append to, keeps its shape. Decided by: the sibling shape, and the overlap with W25/W26.
- The plan-shape step fills a test sprint's `-plan.json` that has no `folders` with the value `tests plan` writes: the planned config's `folders`, normalized, with "." removed. True-up writes the field in place, as it rewrites sprint boilerplate. Decided by: W14's example, and `tests::plan_folders` refusing a plan without it.
- No doc-sprint plan-shape field is required today. The mechanism carries a per-kind transform list, so later shape changes ship their own entry. W2, W3, W4, and W5 change the test sprint's shape (the run command, the loop step, time-control items, shared-resource declarations), and each adds its transform here. Decided by: the decision's "Each change to the shape … ships with the true-up step".
- `.ok-planner/release-boundaries.md` is the project's file. The sprint edits it directly. Decided by: W14's text, and its format block (`plan-sprint/core.md::{{RELEASE-BOUNDARIES-FILE}}`), which needs no change.

**Changes**
- `.ok-planner/release-boundaries.md` § Trued-up projects (this repo): changed.
  - "Across it" adds every approved sprint, documentation sprint, and test sprint not yet in execution, which true-up brings to the carried shape.
  - "Not across it" keeps runs in execution and planning runs in progress.
  - "The owner trues up only between them … and a sprint runs soon after it is planned" becomes "When to true up is the owner's choice; the owner usually trues up between runs."
- `admin/true-up::live_test_sprints`, `live_doc_sprints` (new, beside `live_sprints`), `carried_test_boilerplate`/`carried_doc_boilerplate` and `retired_test_boilerplate`/`retired_doc_boilerplate` (new, the shape of `carried_boilerplate`/`retired_boilerplate`), `test_sprint_transforms`/`doc_sprint_transforms` (new): new. Annotated `@decision: live-sprints-brought-current-on-true-up`.
- `admin/true-up::rewrite_plan`: changed. Plans those transforms for each file, including the sibling `-plan.json` for test sprints.
- `admin/retired-test-sprint-boilerplate.json`, `admin/retired-doc-sprint-boilerplate.json`: new. Every line a released template laid out in those sections that the carried template no longer holds, computed from the `v*` tags.
- `checks/sprint-boilerplate::main`: changed. Checks each of the three histories against its template's homes across tags. The builder finds earlier homes with `git log --follow`.
- `admin/ADMINISTRATION.md`, the live-sprint paragraph: changed. Names both new kinds and the folders fill.

**Behavior changes**
- **B123** `.ok-planner/release-boundaries.md`. Before: approved runs not yet started were outside the boundary, and the owner was assumed to true up between runs. After: they are across it, and the timing is the owner's choice. Users: in the release: the code planner and the notes reviewer, which read the file. Ruling: rewrite.
- **B124** `admin/true-up::rewrite_plan`. Before: test and doc sprints were left as written, and `tests` refused a plan without `folders` ("assemble it again"). After: a destructive rewrite step per file brings each to the carried shape. Users: in the release: `/ok` (relays the plan). Across trued-up projects: owners' approved test and doc sprints. Ruling: migrate: each is rewritten under the owner's one consent, and the work the owner approved is left as written (call).
- **B125** `checks/sprint-boilerplate`. Before: it checked one history. After: three, so a template edit that leaves a history stale fails `checks/run`. Users: in the release: `checks/run` and `/release`. Ruling: rewrite.

### W15. A driver undoes a scratch edit without git

**Calls**
- Only the drive prompt changes. The ban stays word for word in all seven prompts. Decided by: the ruling of drive-prompt-forbids-undoing-scratch-probe-edits.
- A fresh scratch project under the same drive name replaces the old run, because `stack up --name` takes down a run holding that name when nothing uses it. This works with W24's naming. Decided by: P/scripts/stack (the `up --name` behavior).
- Overlap: W10 may touch drive.md for timers.

**Changes**
- `P/skills/converge/prompts/drive.md`, Rules (line 70): changed. After the git ban: to undo a probe edit in your scratch copy or scratch project, copy the file aside before the edit and copy it back afterward; where a command wrote what no copy saved, discard the scratch project and make a fresh one.

**Behavior changes**
- **B205** `P/skills/converge/prompts/drive.md`. Before: a driver has no allowed undo for a scratch edit. After: it has the two named ways. Users: in the release: drivers and confirm drivers. Ruling: rewrite.

### W16. `review certified` checks the ledger's sprint

**Calls**
- The tool learns which sprint a ledger certified from the `sprint-review` prompt the ledger registered. `review prompt --sprint` assembles that file mechanically, and its line "This run certifies the sprint at <path>." carries the path. This works on every ledger ever written, needs no skill change, and does not depend on a brief the session types. The rejected alternative was to put the sprint in the review root's `--brief`. That would leave every earlier ledger unreadable: the run-log format crosses the Trued-up boundary, so it would need a second fallback mechanism. Decided by: `{{BEHAVIOR-RULINGS}}` (both shapes accepted within a major version) and plumbline-cheatsheet "one idiom per job".
- The match compares file names (basename), so `.ok-planner/sprints/x.md` and `.ok-planner/history/sprints/x.md` match alike. Sprint names are unique dated slugs. Decided by: P/scripts/review::resolved_sprint.
- If the registered prompt file's sha256 differs from the ledger's record, that is a failure line: the text is not what the run read. Decided by: accept-list A9.
- Each of these is a failure line in the verdict, never a raise: no `sprint-review` prompt, a missing file, a changed file, or no certifies line. Decided by: the sibling shape `undriven_reason` → failure list.
- Overlap: W9 and W11 also change P/scripts/review. One stage should carry W16, W17, and I200.

**Changes**
- `P/scripts/review`: new constant, a regex `^This run certifies the sprint at (\S+)\.`, multiline.
- `P/scripts/review::certified_sprint` (new; or inline in certification_failures): reads `tasks --file <ledger> dump --type prompt`, takes the `sprint-review` record, reads its file under the root, checks the file's sha256 against the record, and returns the certified path or a failure reason.
- `P/scripts/review::certification_failures`: changed. After loading the ledger it adds a failure unless the certified sprint's basename equals the asked sprint's: "the ledger <L> certified <path>, not <sprint>", or the reason the ledger names no sprint. The review-done, defects, stuck, and drive checks stand.

**Behavior changes**
- **B206** `P/scripts/review::certification_failures`. Before: a completion report naming another sprint's ledger earns `SPRINT COMPLETE`, exit 0. After: `SPRINT NOT COMPLETE` naming the ledger's sprint, exit 2. Users: in the release: sprint-document step 13, /goal checkers, /converge sprint's return. Across Trued-up projects: earlier ledgers in `.ok-planner/review/runs/` (stored state). Each registers its `sprint-review` prompt with path and sha, so each still reads. A sprint archived with `closed:` stays terminal and is never read. Ruling: preserve (call). The fix removes only the A9 harm.

### W17. `review certified` names no flag it refuses

**Calls**
- A missing or empty base file becomes a failure line in the verdict, not a refusal. The tool prints `SPRINT NOT COMPLETE` with every failure; the next step is the sprint's own execution, which writes the base file. Decided by: plumbline-coding 4.3 (take a different branch the caller acts on); `certified_verdict`'s existing failure list.
- The "pass --base" advice stays where it is true: `changed` and `checks`, through `chosen_base`. Decided by: the parsers at P/scripts/review::build_parser.
- Failure text: "<sprint> records no base commit: <base file> is missing or empty; the sprint's execution writes it when it starts". Decided by: A9 (say what is so and what to do).

**Changes**
- `P/scripts/review::sprint_base`: removed. Its two callers (`chosen_base`, `check_failures`) are the whole list.
- `P/scripts/review::recorded_base` (new): returns the base file's stripped text, or None where the file is missing or empty. It raises ReviewError on any other read failure, as before.
- `P/scripts/review::chosen_base`: changed. With `--sprint` and no `--base`, where `recorded_base` gives None, it raises today's text: "…records no base commit (no <file>, or it is empty); pass --base".
- `P/scripts/review::check_failures`: changed. Where `recorded_base` gives None, it returns `(len(checks), 0, [<failure text>])` before diffing.

**Behavior changes**
- **B207** `P/scripts/review::cmd_certified`, through `check_failures`. Before: with no base file it prints `review: … pass --base` on stderr and exits 1, giving no verdict. After: it prints items 1–3 and `SPRINT NOT COMPLETE` with the base failure among the rest, and exits 2. Users: in the release: sprint-document steps 1 and 13, /goal checkers. Ruling: rewrite.

**Improvements**

- **I200** `P/scripts/review::check_failures` against `::cmd_checks`. The `checks` list is validated twice, and the copies disagree. `cmd_checks` refuses a check that starts a test runner (`test_runner_of`); `check_failures` runs it inside `review certified`. That runs tests outside a test sprint, against plumbline-cheatsheet "Tests" (a listed code-rule file: A8), and keeps two copies that must change together. Afterward:
  - One validator, `declared_checks(root, config)`, returns the checks or a refusal reason: not a list, an empty command, or a test runner.
  - `cmd_checks` raises the reason, as it does now.
  - `check_failures` returns it as a failure line.
  - Overlap: W23 changes test-runner refusal in `tests:cmd_ports`; it should reuse `test_runner_of` and not add a third copy.
- **B211** `P/scripts/review::cmd_certified`, through `check_failures`. Before: a `checks` entry that starts a test runner runs during `review certified`. After: `SPRINT NOT COMPLETE` naming the check, and nothing runs. Users: in the release: sprint-document step 13 and /goal checkers. Across Trued-up projects: a project's `review/config.json` holding such a check. `review checks` already refuses it, so certification already could not pass its checks. Ruling: rewrite (call).

### W18. A return block written as the text asks completes the sprint

**Calls**
- The fix goes in the skill text, not the check. The check's tracker-id match is exact and already gives `SPRINT COMPLETE` once the id is written. Decided by: the work item allows either; this is the smaller change.
- Overlap: P/skills/converge/SKILL.md is also changed by W11 (flow areas) and my W13 (line 126).

**Changes**
- `P/skills/converge/SKILL.md`, The return:
  - The `fixed` line (152) adds: each `stuck` defect also by its item id in the run's `defects` pool, such as `i2`.
  - The `intake` line (155) says each stuck defect "by that id, with its last verifier's note".

**Behavior changes**
- **B208** `P/skills/converge/SKILL.md`, The return. Before: the block names stuck defects by entry and note, and `review certified` reports them unlisted. After: the block names each by its id, and the contract closes. Users: in the release: the session writing the block (sprint-document step 13), `review certified`. Across the public surface (`/converge`'s printed return): the fix removes only the A9 harm, so the contract holds. Ruling: rewrite.

### W19. A docspec with a dangling stamp is planned as new

**Calls**
- Build note: B300's across-boundary sentence reads: true-up brings an approved documentation sprint's steps 6 and 7 current, under W14's migrate ruling.
- The prompts key the full check on "planned as new" and never on "no stamp". Planned as new means either no stamp or a stamp the repository no longer holds. That is the wording of `decision:docspec-stamp-opens-the-window` and the `new` status `docs:window_entry` already reports. Decided by: decision:docspec-stamp-opens-the-window, decision:documentation-claim-ledger.
- `docs` itself needs no change. `window_entry` already reports `new` for a dangling stamp. `cmd_claims --stale` already returns every claim when the stamp is not held. `cmd_stamp` already treats a dangling stamp as stale. Decided by: the code at the commit.
- How the executor of a documentation sprint tells "planned as new": its Window line gives the stamp as `none`, or carries the reason `docs window` prints ("stamp … is not a commit this repository holds … planned as new"). `/plan-docs` §5 already copies every reason into that line. So no new field enters the plan's shape, and W14's true-up step for documentation sprints owes nothing for this item. Decided by: decision:live-sprints-brought-current-on-true-up (amended), which asks a true-up step only for a change to the plan's shape.
- The style prompt checks the stamp itself (`git cat-file -e <stamp>^{commit}`) as well as reading its brief. This way a style task registered from the trued-up `core.md` in an older approved documentation sprint, whose brief still names a dangling stamp, runs no `git diff` against a missing commit. Decided by: the Trued-up projects boundary (both brief shapes keep working).
- Class enumerated (prompts that tie a full treatment to "no stamp" while the tool reports `new`):
  - `<payload>/skills/plan-docs/core.md` {{DOC-PLANNER-PROMPT}}: the Inputs diff sentence and step 3.
  - {{DOC-STYLE-PROMPT}}: Read step 4.
  - {{DOC-CHECK-PROMPT}}: the brief paragraph.
  - `<payload>/skills/plan-docs/SKILL.md` §2.
  - `<payload>/skills/plan-docs/doc-sprint-document.md`: steps 6 and 7.
  - `<payload>/skills/plan-tests/SKILL.md:36`, "A status of `new` means no stamp". This one is a description only: `tests:window` sets `new` for a dangling stamp too, and the planners act on the `new` reason the tool gives. It is outside this item's files and goes to `/converge`. The builder records it as noticed. Decided by: plan-sprint core.md Scope.
- Overlap: W11 changes {{DOC-WRITE-PROMPT}} and {{DOC-CHECK-PROMPT}} in `plan-docs/core.md`, and W20 changes `core.md` too. Chain the stages that touch `plan-docs/core.md`. W14's true-up of approved documentation sprints touches the same template family (`doc-sprint-document.md`) but none of these lines.

**Changes**
- `<payload>/skills/plan-docs/core.md::{{DOC-PLANNER-PROMPT}}` (changed):
  - Inputs: where the entry stands `new`, the planner runs no `git diff <stamp>`; every file the tree holds counts as changed.
  - Step 3 reads "For a docspec the entry shows `new`, with no stamp or with a stamp the repository no longer holds, …". The rest of the step is unchanged: every claim in each existing file is checked, and only a missing file is written whole.
- `<payload>/skills/plan-docs/core.md::{{DOC-STYLE-PROMPT}}` (changed). Read step 4: the whole file changed for a docspec whose brief gives no stamp, or whose stamp `git cat-file -e <stamp>^{commit}` does not find, or for a file new since the stamp. In those cases the agent runs no `git diff`.
- `<payload>/skills/plan-docs/core.md::{{DOC-CHECK-PROMPT}}` (changed). "or in any file of a docspec with no stamp" becomes "or in any file of a docspec planned as new: one with no stamp, or with a stamp the repository no longer holds".
- `<payload>/skills/plan-docs/SKILL.md::2. Window` (changed). The `new` parenthetical becomes: no stamp, or a stamp the repository no longer holds, as after a rebase; its missing files are written whole and every claim in its existing files is checked.
- `<payload>/skills/plan-docs/doc-sprint-document.md::{{DOC-SPRINT-DOCUMENT-TEMPLATE}}` (changed):
  - Step 6's style brief gives "its stamp, or `none` where the docspec is planned as new".
  - Step 7's "or the docspec has no stamp" becomes "or the docspec is planned as new". "Planned as new" is defined once, in step 6: the Window line gives the stamp as `none`, or the window's reason that the stamp is not a commit the repository holds.

**Behavior changes**
- **B300** `<payload>/skills/plan-docs/{core.md, SKILL.md, doc-sprint-document.md}`.
  - Before: a docspec whose stamp names a missing commit has only its stale ledger claims checked. Its planner and style task run `git diff` against the missing commit, which fails with `fatal: bad object`.
  - After: every claim in every existing file of that docspec is checked, and no agent runs a diff against the missing stamp.
  - Users: in the release: the `/plan-docs` session, its planner, style, and checker agents, and each documentation sprint drafted from the template. Across Trued-up projects: each project's vendored plan-docs on its next `/ok`. True-up brings an approved documentation sprint's steps 6 and 7 current, under W14's migrate ruling. Its style tasks still gain the stamp check from the re-registered prompt, and its checker briefs follow its own step 7 as before.
  - Ruling: rewrite. Across the boundary the fix removes only the A8 harm, and an older sprint runs as it did.

### W20. Worked examples resolve from the project root

**Calls**
- `cmd_example` calls the sibling `blob_held(root, commit, rel)` in the same script, which already uses `<commit>:./<path>`. It does not get a second spawn of its own. Decided by: plumbline-coding rule 6 (import, never copy) and rule 2 (copy the sibling).
- The writer and style prompts read the example at `git show <sha>:./<path>`, run from the project root. Where git refuses that path, they fall back to `git show <sha>:<path>`. In a subfolder project, the earlier `docs example` recorded only paths relative to the repository's root (the one form it accepted), so the fallback keeps those records readable. Decided by: the stored-state boundary (both shapes accepted within the major version).
- Class enumerated (`<commit>:<path>` reads that resolve from the repository's root, across the payload):
  - Defects, fixed here: `docs:484` (`cmd_example`), `plan-docs/core.md` {{DOC-PLANNER-PROMPT}} line 100 (the retired docspec read, which the issue did not name), {{DOC-WRITE-PROMPT}} lines 203–204 and 208, and {{DOC-STYLE-PROMPT}} line 283.
  - Defect, fixed by W27: `plumbline:596`.
  - Already standing (=standing): `docs:212` and `docs:219`; `review:229` and `review:1395`; `_sprint/shared.md:290`, `:357`, and `:372`.
  - Not this form, standing: `tests` reads blobs by hash (lines 1885 and 1938); `docs` `ls-tree` and `diff --relative` resolve from the working directory (lines 148, 306, 318, 719); `hooks/post-edit.js` passes pathspecs; `checks/sprint-boilerplate` is a monorepo check run at the repository's top.
- `docs` usage text: the `--path` line names "a path from the project root". Decided by: rule 1, every text that restates the input.
- Overlap: W9 sweeps `scripts/docs` for defaults, and W11 and W19 change `plan-docs/core.md`. Chain the stages.

**Changes**
- `<payload>/scripts/docs::cmd_example` (changed): checks the path with `blob_held(root, args.commit, args.path)`, so a path relative to the project root is found in a subfolder project. It refuses as before, with the same message, where the commit lacks the file.
- `<payload>/scripts/docs::USAGE` (changed): the `docs example` line says `<file>` is a path from the project root.
- `<payload>/skills/plan-docs/core.md::{{DOC-PLANNER-PROMPT}}` (changed): the retired docspec is read with `git show <commit>:./.ok-planner/docspec/[SLUG].md`, from the project root.
- `<payload>/skills/plan-docs/core.md::{{DOC-WRITE-PROMPT}}` (changed):
  - Read 1 reads `git show <commit>:./.ok-planner/docspec/<slug>.md`.
  - Read 2 reads `git show <sha>:./<path>`, with the fallback `<sha>:<path>`.
- `<payload>/skills/plan-docs/core.md::{{DOC-STYLE-PROMPT}}` (changed): Read 2 reads the same way as the writer's Read 2.

**Behavior changes**
- **B301** `<payload>/scripts/docs::cmd_example`.
  - Before: in a project below its repository's root, a path relative to the project root is refused with "does not exist at <sha>", and only a path from the repository's root is recorded. A project at the repository's root works.
  - After: the path is read from the project root and recorded. A path from the repository's root, in a subfolder project, is now refused with the same message.
  - Users: in the release: `/plan-docs` Terminal step 1, which passes project paths. Across the stored-state boundary: a `doc-state/<slug>.json` whose example an earlier release recorded from the repository's root.
  - Ruling: migrate: the writer and style prompts read `<sha>:./<path>` and fall back to `<sha>:<path>`, so both stored shapes keep working (call).
- **B302** `<payload>/skills/plan-docs/core.md::{{DOC-PLANNER-PROMPT}}`, `::{{DOC-WRITE-PROMPT}}`, and `::{{DOC-STYLE-PROMPT}}`.
  - Before: in a subfolder project, the reads of the retired docspec and of the worked example fail.
  - After: both read from the project root.
  - Users: in the release: the planner, writer, and style agents. Across Trued-up projects: vendored plan-docs on `/ok`.
  - Ruling: rewrite. The fix removes only the harm.

### W21. The merge prompt reads `none` as no sprint

**Calls**
- Matches the sibling fix.md line 41: one sentence states "This run certifies the sprint at [SPRINT PATH], or no sprint where that reads `none`." Each condition that turns on the placeholder then reads "Where this run certifies a sprint". The five sites are lines 31, 34, 46, 52, and 84. Line 58 sits under "Where your brief starts `sprint`" and stands. No other converge prompt turns on [SPRINT PATH] without the `none` reading (verify.md and fix.md already carry it; sprint-review and sprint-pass are sprint-only). Decided by: plumbline-coding rule 2 and rule 8.
- Overlap: if W9's sweep removes the `none` defaults of `review prompt --sprint/--base`, the `none` sentence in merge.md, fix.md, and verify.md must change in the same change, or keep that value.

**Changes**
- `P/skills/converge/prompts/merge.md`: changed. The `none` sentence goes after the brief paragraph (line 11). Lines 31, 34, 46, and 84 read "Where this run certifies a sprint". Line 52 reads "Where this run certifies a sprint, its change runs from the base commit [BASE], and the drive stays inside its scope: …".

**Behavior changes**
- **B209** `P/skills/converge/prompts/merge.md`. Before: in a drive, analysis, or defects run a merge agent may read "Where none names a sprint" as true and backlog real failures. After: those runs merge every real failure. Users: in the release: merge agents; the owner list, which files fewer backlog issues. Ruling: rewrite.

### W22. `/plan-sprint` reconciles before it drafts

**Calls**
- The fix is one rule, stated once in §5 Draft: one artifact, one delta. Wherever two outcomes of the session change one artifact, the sprint carries one delta for it. The outcomes are: a ruled issue drafted at Frame, a promotion from the issue walk an intake-drain sprint runs at Frame, a Reconcile "Corpus catches up", a discovery's body, and a promotion at Resolve. The delta's whole body carries every change, and it is rebuilt from the artifact as the latest outcome leaves it. §3 Reconcile step 4 and §6 Resolve's Promote point at that rule, so it is not restated. Phase order stays as it is. Decided by: the issue's generated ruling ("end in one whole body that carries both"), and plumbline-coding rule 8.4 (no reordering beyond the report).
- §3's opening sentence, "before anything is drafted on top of it", is rewritten so it is true: Frame may already have drafted a ruled delta, and Reconcile rebuilds it under the rule.
- "Record and defer" stays as written. A ruled delta drafted from the live artifact already leaves the divergent text as it stands, so it does not decide the deferred divergence. Decided by: the step's own text ("leaves the artifacts that divergence bears on untouched").
- Overlap: W8 (the code planner's timer step, in `plan-sprint/core.md`) and W11 (§5's surface step, in `plan-sprint/SKILL.md`). W11 edits the same §5 paragraph region, so chain the stage with W11's stage.

**Changes**
- `<payload>/skills/plan-sprint/SKILL.md::5. Draft` (changed): the corpus-delta paragraph adds the one-artifact-one-delta rule.
- `<payload>/skills/plan-sprint/SKILL.md::3. Reconcile` (changed):
  - The opening sentence names the rebuild.
  - Step 4's "Corpus catches up" adds that where the draft already carries a delta on an affected artifact, that delta is rebuilt to carry both, under §5's rule.
- `<payload>/skills/plan-sprint/SKILL.md::6. Resolve` (changed): Promote's "including where the resolution collides with a delta already drafted" now cites §5's rule instead of saying it a second time.
- `<payload>/skills/plan-sprint/SKILL.md::4. Dialogue` (changed): the discovery bullet's "in place of any other delta the discovery drafts on that artifact" adds "and merged under §5's rule with any delta the draft already carries on it".

**Behavior changes**
- **B303** `<payload>/skills/plan-sprint/SKILL.md`.
  - Before: a ruled issue's delta and a Reconcile catch-up on one artifact can leave two whole-body deltas in the sprint, and the later one drops the earlier one's change.
  - After: the sprint carries one delta per artifact, with both changes.
  - Users: in the release: the `/plan-sprint` session; execution and `review deltas`, which read one delta per heading as before. Across Trued-up projects: vendored plan-sprint on `/ok`. A planning run in progress is not across the boundary.
  - Ruling: rewrite.

### W23. A ported check never starts a test runner

**Calls**
- Build note: the suite command's lead words stop before the first placeholder and keep the script after an interpreter, such as `node scripts/suite.mjs`, never a bare `node`, which would refuse the lint's own check.
- `tests ports` checks every recorded command with `review.test_runner_of(command, review.project_runners(root))`, imported from the sibling `review` module and not copied. Where any command starts a runner, it writes nothing and refuses. The refusal names each port item, the legacy task that recorded it, and the runner, and says to refile that task with `tasks refile <task> --brief "<brief>; revise: <the refusal>"`. Decided by: plumbline-coding rule 6, and decision legacy-suites-sorted-automatically.
- After W2, the project's own runner is its declared suite command. So `project_runners` adds the words of `testing.run` before its first placeholder (through `command_words`), and `.ok-planner/bin/tests run` with its `python` form. Without them, a check that calls the suite script passes. Both `review checks` and `tests ports` read this one definition. Decided by: decision test-sprints-own-the-tests ("the review loop refuses a check that does").
- Overlap: W9 may treat `review::TEST_RUNNERS` and `COMMAND_WRAPPERS` as constants or as settings.

**Changes**
- `scripts/tests::cmd_ports`: changed. It refuses any command that starts a test runner, as above, and adds nothing.
- `scripts/review::project_runners`: changed. It appends the suite command's lead words and `.ok-planner/bin/tests run`.
- `skills/plan-tests/core.md::{{TEST-SORT-PROMPT}}`: the port sentence adds that a check never starts a test runner, since `review checks` and `tests ports` refuse such a command.
- `{{TEST-LEGACY-PROMPT}}`: Per port says the check's command and program start no test runner.
- `skills/plan-tests/test-sprint-document.md` step 5: where `tests ports` refuses, refile each legacy task it names with the refusal, drain, and run `tests ports` again.

**Improvements**
- **I3** `scripts/tests::cmd_ports`. Entry: A2. A review config whose `checks` is a string becomes `list("node …")`, so a write of single characters lands over `checks`. Afterward: it refuses a `checks` that is not a list of strings, writing nothing, as `review::cmd_checks` does.

**Behavior changes**
- **B20** `scripts/tests::cmd_ports`.
  - Before: it adds every recorded command.
  - After: it refuses and writes nothing where any command starts a runner.
  - Users in the release: test sprint step 5.
  - Ruling: rewrite.
- **B21** `scripts/review::project_runners`, read by `cmd_checks`.
  - Before: a check calling the project's suite command or `bin/tests run` passes.
  - After: `review checks` refuses it, naming the check and the runner.
  - Users across Trued-up projects: a project whose review `checks` names its suite command.
  - Ruling: migrate (call). The refusal says to take the check out of `checks`, as it does for every runner it knows. Such a check already breaks decision test-sprints-own-the-tests, and a fix that removes only that harm keeps the contract.
- **B24** (I3) `scripts/tests::cmd_ports`.
  - Before: a string `checks` is written back mangled.
  - After: it is refused.
  - Users in the release: test sprint step 5.
  - Ruling: rewrite.

### W24. `/converge` can stop what its drivers leave open

**Calls**
- Drivers open every run under their drive name: `stack up --name <the drive name your brief gives>`. A dashboard drive's second run uses `<the drive name>-b`. Decided by: the sibling migration in P/admin/ADMINISTRATION.md (line 189), which wraps `resource-start` in `stack up --name <the drive name>` and appends `stack down --name <the drive name>` to `resource-stop`; and `stack up --name` frees a name nothing uses.
- `resource-stop` tries both names, second run first, and exits with the first failure: `` `sh -c 'python3 plugins/ok/families/ok-planner/scripts/stack down --name {name}-b; held=$?; python3 plugins/ok/families/ok-planner/scripts/stack down --name {name} && exit $held'` ``. `down --name` exits 0 where no run holds the name. Decided by: plumbline-coding 4.2 (a cleanup loop attempts every item).
- `resource-start` is a steps line that points to "Resources a driver starts" and the dashboard steps. The seed format allows a steps line (P/review/seed/project.md line 27), and drivers read the facts directly. Decided by: the seed's role-line grammar.
- Overlap: W9 and W10 will update this file's "Scripts for developers and operators" section, for defaults and timers such as `run-group`'s 10 s and `ports`' 15 s.

**Changes**
- `.ok-planner/review/project.md`, `## Drive commands`: changed. Adds `` - `resource-start`: <the steps under "Resources a driver starts", and the dashboard's steps below> `` and the `resource-stop` line above. The `- No stack:` line stays.
- `.ok-planner/review/project.md`, dashboard steps 1, 2, and 4: changed. Step 1's `stack up` gains `--name <the drive name>`. Step 2's second run gains `--name <the drive name>-b`. Step 4 ends with `stack down --name <the drive name>-b`, then `stack down --name <the drive name>`.
- `.ok-planner/review/project.md`, `## Resources a driver starts`: changed. `stack up --name <the drive name> -- sh -c 'git init -q "$OK_RUN_FOLDER/project"'`, ending with `stack down --name <the drive name>`.

**Behavior changes**
- **B210** `.ok-planner/review/project.md` (pasted into every prompt), as read by `review drive-command --role resource-stop`. Before: drivers open unnamed runs; the role refuses (exit 1), and every stop task fails. After: drivers open runs under their drive names, the role prints the stop command, and drive step 4 and the confirm round take down what a driver left. Users: in the release: drivers, the /converge session's step 4 and confirm-round stops, `review drive-command`. Ruling: rewrite.

### W25. A sprint's close commit holds every removal

**Calls**
- The new sentence copies its sibling, the step-2 sentence of {{CEREMONY-ARCHIVE}} in `<payload>/skills/_sprint/shared.md`: name each path that exists and each removed path the last commit holds, a `git mv` source or a file a task removed with `git rm` among them, and no other. Decided by: plumbline-coding rule 2.
- The replaced lines of the sprint template's archive step 3 go into `<payload>/admin/retired-boilerplate.json`, kept sorted, exactly as `checks/sprint-boilerplate` computes them. That means each line a released `v*` template held that the carried template no longer holds, and no line the carried template keeps. The builder runs `python3 checks/sprint-boilerplate` (or `checks/run`). Decided by: decision:live-sprints-brought-current-on-true-up, `checks/sprint-boilerplate`.
- Overlap: W26 and W25 both edit `sprint-document.md` and `retired-boilerplate.json`. Other planners' items may also touch the template's boilerplate (W9's sweep of default-text, W14). Every stage that edits either file is chained, and the last one re-runs `checks/sprint-boilerplate`.

**Changes**
- `<payload>/skills/plan-sprint/sprint-document.md::{{SPRINT-DOCUMENT-TEMPLATE}}` (changed): in the archive step 3, the last sentence is in the sibling form above, and the step's listing names a `D` line from `git status --porcelain` as a removed path to name.
- `<payload>/admin/retired-boilerplate.json` (changed): adds the replaced lines, sorted.

**Behavior changes**
- **B304** `<payload>/skills/plan-sprint/sprint-document.md`, archive step 3.
  - Before: the close commit leaves out a path a task removed with `git rm` or a plain delete. The staged deletion rides into the next commit.
  - After: the close commit names it, and the commit the `closed:` stamp names holds the whole change.
  - Users: in the release: every sprint drafted from the template, and its executing session; `checks/sprint-boilerplate`. Across Trued-up projects: each live sprint under `.ok-planner/sprints/` that an earlier release wrote.
  - Ruling: migrate: true-up's live-sprint step (`true-up::current_boilerplate`) rewrites the retired lines to the carried ones, under its destructive-rewrite consent. The retired list carries those lines (call).

### W26. A failed certification still asks for vetoes

**Calls**
- Build note: amend `{{CEREMONY-VETO}}`'s description, which names runs a ceremony other than `/plan-sprint` planned, once the sprint template cites it.
- New order of step 13: render, write the return block, run `review certified` and show its output.
  - Then present the `## Calls` table and ask for vetoes on both outcomes, filing and ruling each vetoed row.
  - On `SPRINT NOT COMPLETE`, name each failure and stop without offering the archive. On `SPRINT COMPLETE`, offer the archive and the commit.
  - Decided by: decision:converge-close-takes-vetoes ("Every `/converge` run closes the same way"; in sprint certification the execution steps make this close), and the contract's goal rule (the archive follows completion).
- A later certification's close presents every row again, including rows vetoed at an earlier close. This item adds no de-duplication. Decided by: plumbline-coding rule 8.4 (no new mechanism).
- The restatement in `<payload>/skills/converge/SKILL.md` (the `sprint` mode paragraph of The return, line 160: "presents that report, and offers the archive and the commit") is brought in line. Decided by: plumbline-coding rule 1.
- Overlap: W18 changes `converge/SKILL.md` The return, so chain with W18's stage. W25 shares `sprint-document.md` and `retired-boilerplate.json`.

**Changes**
- `<payload>/skills/plan-sprint/sprint-document.md::{{SPRINT-DOCUMENT-TEMPLATE}}` (changed): step 13 in the order above. Its veto paragraph cites `{{CEREMONY-VETO}}` (I300).
- `<payload>/skills/converge/SKILL.md::The return` (changed): the sprint-mode sentence says the boilerplate presents the report and its calls for veto, and offers the archive and the commit only where `review certified` printed `SPRINT COMPLETE`.
- `<payload>/admin/retired-boilerplate.json` (changed): adds step 13's replaced lines, sorted, as under W25.

**Improvements**
- **I300** `<payload>/skills/plan-sprint/sprint-document.md::{{SPRINT-DOCUMENT-TEMPLATE}}` step 13. The cost it ends: step 13's veto paragraph is a near-verbatim second copy of `{{CEREMONY-VETO}}` in `<payload>/skills/_sprint/shared.md`, which the documentation and test sprint templates already cite. Two copies must change together. Afterward: step 13 says "follow `{{CEREMONY-VETO}}` in `.claude/skills/_sprint/shared.md`, with `<rows>` as the rows of the completion report's `## Calls` table and `<problem>` as the row". The executor files and rules each veto exactly as before, so there is no behavior change of its own. Its replaced lines go to the retired list with W26's.

**Behavior changes**
- **B305** `<payload>/skills/plan-sprint/sprint-document.md`, step 13.
  - Before: on `SPRINT NOT COMPLETE` the session names the failures and stops, and the owner is never asked to veto a call.
  - After: the session names the failures, asks which calls the owner vetoes, files and rules each one, and stops without offering the archive. `SPRINT COMPLETE` behaves as before.
  - Users: in the release: every sprint drafted from the template and its executor; `converge/SKILL.md` The return, changed above; `checks/sprint-boilerplate`. Across Trued-up projects: live sprints an earlier release wrote.
  - Ruling: migrate: the retired lines go to `admin/retired-boilerplate.json`, and true-up's live-sprint step brings step 13 current (call).

### W27. The lint finds a committed marker in a subfolder project

**Calls**
- `committedLegacyMarker` passes `HEAD:./${rel}`, the form the review tool uses at `review:1395`. `rel` is relative to the project root, which is git's working directory here, and the `./` makes git resolve it from there. A file under a declared folder outside the root has a `rel` starting `../`. `folderDefect` keeps every such folder inside the repository, so `HEAD:./../<path>` resolves too. Decided by: plumbline-coding rule 2, decision:filesystem-discovery-markers.
- Class: see W20's enumeration. `plumbline:596` is the lint's only commit-path read. `changedPaths` already resolves against the repository's top (=standing).
- Overlap: W9 (defaults such as `DEFAULT_IGNORE_PATTERNS`) and W10 may edit `scripts/plumbline`. Chain the stages.

**Changes**
- `<payload>/scripts/plumbline::committedLegacyMarker` (changed): runs `git show HEAD:./<rel>` from the project root. It finds a marker an earlier release committed wherever the project root sits in its repository, and returns false, as before, where git has no committed copy.

**Behavior changes**
- **B306** `<payload>/scripts/plumbline::committedLegacyMarker`.
  - Before: in a project whose root is a subfolder of its repository, a committed `@plumbline:allow-docstrings` marker is reported as a new marker, the file's doc comments are refused, and the edit hook blocks every edit to the file.
  - After: the committed marker is found, and the file keeps its doc comments. A project at the repository's root behaves as before.
  - Users: in the release: `checkCommentHygiene`, `hooks/post-edit.js`, and the review check `node .ok-planner/bin/plumbline`. Across Trued-up projects: each project's vendored lint on `/ok`.
  - Ruling: rewrite. The fix removes only the A9 harm, which no caller may rely on.


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
    Where it prints `SPRINT NOT COMPLETE`, name each failure to the
    owner and stop: it is a genuine blocker under step 11. Then
    present the completion report's `## Calls` table to
    the owner, and ask which rows, if any, the owner vetoes. For each
    vetoed row, file one issue with `.ok-planner/bin/issues file
    --from -`, in the format of the `{{ISSUE-FILE-FORMAT}}` block of
    `.claude/skills/_shared/artifact-definitions.md`: kind `human`,
    category `product-intent`, its problem the row. Then record the
    owner's words as that issue's ruling with `.ok-planner/bin/issues
    rule <id> --text -`, the words on stdin, so the next
    `/plan-sprint` pulls the veto in as the owner's decision. `issues
    rule` signs the ruling with the name of the person running the
    session; where it refuses for want of a name, relay the refusal's
    setting text to the owner and record the ruling once a name
    resolves. Then offer the archive and the commit below as one
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
   `git mv` moved, a ` D <old>` line names an old path a plain `mv`
   removed, and a `?? <new>` line names a new path under
   `.ok-planner/history/`. Commit those paths alone with
   `git commit -- <paths>`, naming only paths that exist, or that a
   move removed and git still tracks, so nothing else standing in the
   index rides along.
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
