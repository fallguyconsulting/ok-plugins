---
name: ok-setup
description: "ONLY activated by explicit /ok-setup slash command. Never auto-triggered by conversation content. Sets up a project's testing, apart from the front door's administration. Run once, it turns testing on: it records the suite command and its settings, the schedule the suite command runs, the per-test coverage it writes, the test stack's budget, and the standing offers /plan-sprint makes, and checks that the suite command runs every kind of test the project's recorded tests hold. Run again, it changes any of those settings, freezes testing, or turns it off. It writes testing's settings only through .ok-planner/bin/tests."
---

# Testing setup

`/ok-setup` sets up a project's testing. Testing is part of every sprint, under `testing.enabled` in `.ok-planner/config.json`:

- `on`: every sprint plans, writes, and maintains tests, and `/plan-sprint` makes the standing offers `testing.offers` lists.
- `frozen`: sprint certification runs the existing suite and fixes the code for what it finds. `/plan-sprint` makes no offer and plans only the rewrites and retirements each changed story needs.
- `off`: sprint certification skips the suite. The tests stay in the tree, unmaintained.

The owner runs this verb. It is no part of the front door's administration (`/ok`): true-up asks no testing question live, and files one intake issue for each testing value it has to guess. `/ok-setup` asks those questions. It reads `testing`, and asks only what is missing, what an earlier release guessed, or what the owner asks to change.

The session writes testing's settings only through `.ok-planner/bin/tests declare`, the test stack's budget only through `.ok-planner/bin/tests budget`, and its budget run under `.ok-planner/tasks/`. It edits no key of `.ok-planner/config.json` by hand.

## 1. Layout

The project root is the nearest ancestor of the working directory (itself included) holding `.ok-planner/`. Without it, say so and stop.

`.ok-planner/bin/tests`, `.ok-planner/bin/tasks`, and the profile `ok-opus` under `.claude/agents/` are required: where one is missing, say that `/ok` materializes it, and stop.

Run `.ok-planner/bin/tests enabled`. Where it refuses for want of `testing.enabled`, relay its message, say that `/ok` writes the key, and stop. Otherwise it prints the testing state, `on`, `frozen`, or `off`. Read `testing` in `.ok-planner/config.json` beside it.

## 2. The owner's choice

Tell the owner the state in one line, with each key `testing` declares and its value. Then ask, in one prose question, what the owner wants:

- Where the state is `off`: turn testing on, freeze it, or leave it off.
- Where the state is `frozen`: turn testing on, change a setting, turn testing off, or change nothing.
- Where the state is `on`: change a setting, freeze testing, turn it off, or change nothing.

Freezing needs a suite command to run. Where `testing` declares no `run`, offer no freeze: say that a frozen suite runs the suite command, which the project has not declared, and offer to turn testing on instead.

On the owner's answer:

- **Turn testing on**: run every step of section 3.
- **Change a setting**: run the steps of section 3 that the setting belongs to, and only those: the runner (3.2) for `run`, `silence`, `named`, `leftovers`, `slowest`, `runners`, `setup`, or `setup_silence`; the schedule (3.3); the coverage (3.4); the budget (3.5); or the offers (3.6, under `on` only). A change to `run`, `setup`, or `silence` also runs the runner check (3.7).
- **Freeze testing**: run `.ok-planner/bin/tests declare --enabled frozen`, and nothing else.
- **Turn testing off**: run `.ok-planner/bin/tests declare --enabled off`, and nothing else. Tell the owner in one line that the tests stay in the tree, unmaintained, and that sprint certification skips the suite until `/ok-setup` turns testing on again.
- **Change nothing**, or leave it off: say so in one line, and stop.

Then report, as section 4 says.

## 3. Turning testing on

### 3.1 The state

Run `.ok-planner/bin/tests declare --enabled on` first, before any other step of this section, so the runner check and the budget task read testing as on.

### 3.2 The runner

The runner is the project's suite command and its settings, under `testing` in `.ok-planner/config.json`, each required, with no default:

- `run`, the suite command, which runs a list of tests in one run, deciding batching and each test's own setup, with the number of workers the list names. It holds `{tests}`, where the tool puts the path of a JSON file, `{"workers": <n>, "tests": [{"path", "name", "resources": [...], "reads": [...]}]}`, and `{results}`, where it puts the path of a stream the command writes one line to per test as each finishes, `{"path", "name", "passed": true or false, "seconds": <number>, "output": "<text>", "reaches": [<path>, ...]}`, `reaches` optional, each line within 512 bytes, its output capped to fit. A line names its test by the path and name the scenario list records; a test the stream never reports fails.
- `silence`, the whole seconds with no result line and no output after which the tool stops a run. Keep it as small as the project can: each test, and each tool under the project's control that a test runs, prints progress as it works, so long silences are rare. A test with no choice but a longer silence records its own on its `tests` item in the sprint's test stages, and the run waits that long only while that test has no result.
- `named`, `true` where the suite command runs a test by its name inside its file, `false` where it runs a whole file.
- `leftovers`, a command that prints one JSON object counting each kind of resource a test may leave behind; a project with nothing to count declares `echo {}`.
- `slowest`, how many of the slowest tests each run lists, and so the size of each batch a sprint's speed review reads.
- `runners`, the project's own test-running commands that `review checks` refuses as a check, an empty list where the project has no runner of its own to name.
- `setup`, a command the tool runs before each run of the suite command to get the test environment ready, such as starting the shared test stack or installing a browser, or `null` where the project needs none. It must be safe to run again, and finish fast where the environment is ready. The silence clock starts only after it exits 0. A failed setup fails every test of the run, with a note that opens `setup failed`.
- `setup_silence`, the whole seconds with no output after which the tool stops setup. A project whose `setup` is a command declares it.

Count a key as missing where it is absent, and count `run` as missing where `testing` declares the earlier one-test form: a `run` holding `{path}` and no `{tests}`, or a `timeout` key. Where any key is missing, or the owner asked to change one, read how the project runs its tests today: its package manifests, its build files, its CI configuration, and the runner's plugins or reporters that write one line per test as each finishes. Propose to the owner, in one prose question, a value for every missing key and every key the owner asked to change: the suite command with each placeholder shown and the result line it writes, such as a small script beside the tests that reads the list, runs the tests with the project's runner, and writes one line per test. Where the project has no tests and no runner, propose one that fits its language. Propose a `setup` wherever the tests need an environment started or provisioned, so the suite command starts no environment inside the silence clock, and propose the smallest `silence` the tests' progress output allows.

On the owner's answer, run `.ok-planner/bin/tests declare` with the flag of each key the owner gave: `--run "<the command>"`, `--silence <seconds>`, `--named <yes | no>`, `--leftovers "<the command>"`, `--slowest <n>`, `--runners [<command> ...]`, `--setup "<the command>"` or `--setup none`, and `--setup-silence <seconds>`. The tool drops an earlier `timeout`. Where every key is declared and the owner asked to change none, ask nothing.

### 3.3 The schedule

`testing.schedule` records the schedule the suite command runs, `{"form": "<the form>", "said": "<the owner's words>"}`. The tool knows three forms:

- `recommended`: two tests may run at the same time unless one changes a resource the other changes or reads. Tests that share a changed resource form one group, which runs its tests one after another on one worker.
- `groups-side-by-side`: the isolated tests run first; then the held groups run at the same time as each other, each group's tests one after another.
- `groups-one-at-a-time`: the isolated tests run first; then the held groups run one after another.

The tool ranks the slowest tests by the form, and, once `said` holds the owner's words, fails a round in which two tests ran at the same time that the form forbids. Where `testing.schedule` is absent, its `said` is null, as true-up writes a guessed form, or the owner asked to change it, read the suite command, and ask the owner, in one prose question, which schedule it runs: name the form the command shows, the form `testing.schedule` holds now, where it holds one, and propose `recommended` where the command can run it. Where the project's command runs a schedule none of the three forms names, say so, and propose changing the command to the nearest form: the tool refuses any other form. On the answer, run `.ok-planner/bin/tests declare --schedule <recommended | groups-side-by-side | groups-one-at-a-time> --schedule-said "<the owner's words>"`.

### 3.4 The coverage

`testing.reaches` records what the suite command writes as each result line's `reaches`, `{"form": "<the form>", "said": "<the owner's words>"}`:

- `files`: each line names the product files the test ran, from a per-test coverage record.
- `folders`: each line names the folders of the services the test reached, each path ending in `/`, as a stack test does.
- `none`: the suite command writes no `reaches`.

After a fix in sprint certification, the verifier reruns the tests whose `reaches` names a file the fix changed or a folder above one. Under `none`, it reruns only the tests the fix was for, and the final whole-suite round catches the rest. Where `testing.reaches` is absent, its `said` is null, as true-up writes a guessed form, or the owner asked to change it, read the suite command and the coverage tool the project's runner offers, such as per-test contexts in coverage.py, `--coverage` in jest or vitest, or `-coverprofile` in go, and ask the owner, in one prose question, what per-test coverage the suite command writes: name the form the command shows, and propose the change to the command that writes `reaches` where the runner offers per-test coverage. On the answer, run `.ok-planner/bin/tests declare --reaches <files | folders | none> --reaches-said "<the owner's words>"`. Where the owner changes the suite command to write `reaches`, declare the new command with `--run` too.

### 3.5 The budget

The budget sizes the test stack the suite spends as one resource: the number of workers, the command that starts the test stack, the sizing its configuration gives for that many workers, the configuration files the preflight may edit, and how the suite meets each deployment-wide limit. `.ok-planner/bin/tests scenarios --json` prints the budget the scenario list records. Where it records none, or the owner asked to change it, budget the stack on a run of its own. Below, `<stamp>` is the run's timestamp, `date +%Y-%m-%dT%H%M%S`, taken once as the run opens, and `<run>` is `.ok-planner/tasks/ok-setup-<stamp>.jsonl`.

```bash
.ok-planner/bin/tasks init ok-setup-<stamp> --file .ok-planner/tasks/ok-setup-<stamp>.jsonl
.ok-planner/bin/tasks agent register ok-opus
.ok-planner/bin/tasks config set item_states '{"budget": ["open"], "limits": ["open"], "calls": ["open"]}'
.ok-planner/bin/tasks config set field_types '{"budget": {"workers": "integer"}}'
.ok-planner/bin/tasks config set calls '[{"pool": "calls"}]'
```

Each `/ok-setup` opens a fresh run. Never pass `--force` to `tasks init`, and never `tasks use` an existing file to open the run: an earlier run's file stays as it stands.

Write `{{TEST-BUDGET-PROMPT}}` from `.claude/skills/plan-sprint/tests-budget.md`, its transclusions resolved from `.claude/skills/plan-sprint/tests.md`, `.claude/skills/_sprint/shared.md`, and `.claude/skills/_shared/dispatch-discipline.md`, and `[SPRINT PATH]` filled with `none`, to `.ok-planner/tasks/ok-setup-<stamp>-budget.md`, and register it: `.ok-planner/bin/tasks prompt register budget .ok-planner/tasks/ok-setup-<stamp>-budget.md`. File the one budget task: `.ok-planner/bin/tasks file --role budget --prompt budget --agent ok-opus --key budget --brief "budget the tests the scenario list records; the last run is at none"`. Drain with the drain loop at `.claude/skills/_tasks/drain.md`. A task that closes `partial` is refiled whole with `.ok-planner/bin/tasks refile <task>`, and drained again.

Show the owner the calls before the budget is written: run `.ok-planner/bin/tasks calls` and show what it prints whole, one row per call the budget agent made without the owner. Where it prints `None.`, say so in one line. Otherwise ask the owner once which rows, if any, the owner vetoes, naming only the rows not shown before. Where the owner vetoes a row, refile the budget task with `.ok-planner/bin/tasks refile <task> --brief "budget the tests the scenario list records; the last run is at none; revise task <task>: the owner vetoes <each vetoed row's id>: <the owner's words>"`, drain, and show the calls again.

Write the budget: `.ok-planner/bin/tests budget --from-run <run>`. It prints the budget it wrote. Where it refuses because the budget does not hold, it names each failure: refile the budget task with `.ok-planner/bin/tasks refile <task> --brief "budget the tests the scenario list records; the last run is at none; revise task <task>: <each failure>"`, drain, show the calls as above, and write the budget again. Show the owner the budget in one short list: the workers, the stack command, the sizing, the files the preflight may edit, and each limit with its handling.

The next sprint with test stages runs the preflight against the budget before its first test task.

### 3.6 The offers

`testing.offers` lists the standing offers `/plan-sprint` makes at Frame where testing is on, each kind at most once:

- `untested`: the stories with no recorded scenario, in groups the owner takes one at a time.
- `stale`: the tested stories whose file changed since their tests were planned.
- `legacy`: the test files no scenario claims, one group per folder.
- `runtime`: the runtime group, the failures of the parts the product holds or depends on that it must survive.

Where `testing.offers` is absent, or the owner asked to change it, ask the owner, in one prose question, which offers `/plan-sprint` makes, and propose all four. On the answer, run `.ok-planner/bin/tests declare --offers <each kind the owner named>`, or `.ok-planner/bin/tests declare --offers` with no kind for no standing offer.

### 3.7 The runner check

Check that the suite command runs every kind and setup pair of test the project's recorded tests hold. Read the recorded tests: `.ok-planner/bin/tests scenarios --json`. Each scenario record that names a test holds its `kind` and its `setup` where a sprint recorded them. Where a record holds neither, read its test file and name its kind and its setup. Where the scenario list records no test, say so in one line, and end the step.

List each kind and setup pair with its count. Compare each pair with `testing.run`, `testing.setup`, and `testing.silence`: `testing.setup` gets that setup's environment ready, the suite command runs a test of that kind, and the test prints a line of output or its result inside every silence period, so the run never stops on it. A suite command that runs files under a unit runner does not run a test that needs a browser, and a stack that takes a minute to start belongs in `testing.setup`, outside the silence clock, not in the silence period.

For each pair the suite command does not run inside the silence period, ask the owner, one question per turn, in prose: name the pair, its count, and what the command or the silence period lacks, and propose the change. The owner picks one: *change the command*, *change the setup*, *change the silence period*, or *neither*. Propose a change to the command or the setup before a longer silence period. On a change, run `.ok-planner/bin/tests declare --run "<the command>"`, `.ok-planner/bin/tests declare --setup "<the command>" --setup-silence <seconds>`, or `.ok-planner/bin/tests declare --silence <seconds>`, and compare every pair again. Where the owner changes neither, name that pair's tests to the owner in one list: each fails every run of the suite until a sprint's test planning rewrites it in a form the suite command runs, and its failures reach sprint certification as defects.

The step ends when the suite command runs every pair inside the silence period, or the owner has chosen *neither* for each pair it does not run.

## 4. Report

Run `.ok-planner/bin/tests enabled`, and tell the owner, in a few lines, the state it prints, each key the session declared with its value, and the budget where the session wrote one, with each call the owner vetoed. Where the intake holds an open `testing-schedule-unconfirmed` or `testing-reaches-unconfirmed` issue and the session recorded the owner's words for that key, say that the next `/triage-issues` answers it. Where testing is `on`, say that the next `/plan-sprint` offers the groups `testing.offers` lists. Then stop.
