---
approved: 2026-11-19
---

# Sprint: Ninth intake drain

## Intent

This sprint drains the intake and has no single theme. It replaces test `resources` and `reads` with locks built up from observed runs, and sizes the suite's workers to each machine. It keeps the orchestrating session out of test declarations. It reshapes `/plan-sprint`'s sign-off into one checklist pass that checks each delta body against each rule once, one fix pass, and a re-check of only what the fix changed. It makes a defect the owner takes into a sprint a certification fix. It stops every part of the suite from reading `history/` on its own, and moves the bookkeeping the tools need into live files. It splits four bundled decisions, adds a run-time cost rule to the coding rules, gives `/setup-web` a headless browser server, and fixes five defects in the planning and `/converge` text.

This sprint is planned and certified under ok-planner v31.1.0, whose installed `/converge` reads no defect issue in sprint mode. So the defect issues taken into this sprint are carried as work items. The new path for taken defects starts with the first sprint planned after the next true-up.

Issues promoted into this sprint:

- `back-out-reads-and-side-by-side-tests`
- `suite-workers-adapt-to-the-machine`
- `session-applies-planner-declarations`
- `plan-sprint-sign-off-rereads-whole-scope-every-round`
- `decisions-bundling-several-choices-await-a-split`
- `setup-web-headless-server`
- `deferred-verdict-check-counts-only-open-issues`
- `preflight-setup-checks-with-no-recorded-test`
- `short-close-frees-waiting-tasks`
- `plan-sprint-skips-out-of-band-work-after-reconcile`
- `speed-prompts-file-perf-fixer-unconditionally`
- `test-stage-drain-precedes-progress-checklist`
- `verify-refuses-boundary-question-declines`
- `drive-prompt-names-no-output-folder`
- `plainly-wasteful-work-rule`
- `true-up-check-reads-archived-sprints`
- `sprint-defects-fixed-by-certification`

## Corpus deltas

### Amend concept: completion-contract

body: in the sidecar

### Amend concept: completion-report

body: in the sidecar

### Amend concept: sprint

body: in the sidecar

### Amend concept: task-tracker

body: in the sidecar

### New story: suite-fits-the-machine-it-runs-on

body: in the sidecar

### New decision: archive-read-by-nothing

body: in the sidecar

### New decision: build-task-per-stage

body: in the sidecar

### New decision: claim-takes-the-most-waited-on

body: in the sidecar

### Amend decision: closed-issues-leave-the-live-file

body: in the sidecar

### Amend decision: closing-commit-baseline

body: in the sidecar

### New decision: code-complete-at-latest-filing

body: in the sidecar

### Amend decision: converge-finds-then-fixes

body: in the sidecar

### Amend decision: corpus-audit-hands-a-discovery-to-planning

body: in the sidecar

### Amend decision: defects-outside-scope-become-defect-issues

body: in the sidecar

### New decision: deferred-verdict-handed-off-through-the-intake

body: in the sidecar

### Amend decision: docspec-stamp-opens-the-window

body: in the sidecar

### Amend decision: drain-fills-every-free-slot

body: in the sidecar

### Amend decision: drain-runs-as-a-workflow-script

body: in the sidecar

### New decision: drive-acts-in-a-first-time-users-order

body: in the sidecar

### New decision: drive-merge-sorts-each-failure

body: in the sidecar

### Amend decision: drive-serves-the-tree-page-build

body: in the sidecar

### New decision: drive-takes-every-named-variant

body: in the sidecar

### Amend decision: drive-tries-each-story-as-a-user

body: in the sidecar

### New decision: drive-writes-only-in-scratch

body: in the sidecar

### New decision: driver-uses-only-the-public-surface

body: in the sidecar

### Amend decision: dropped-items-stay-in-the-record

body: in the sidecar

### Amend decision: every-public-class-has-a-reference

body: in the sidecar

### New decision: failed-speed-rewrite-returns-to-its-last-passing-version

body: in the sidecar

### New decision: failing-tests-rerun-alone

body: in the sidecar

### New decision: fixers-never-edit-tests

body: in the sidecar

### Amend decision: fixes-rerun-the-tests-they-reach

body: in the sidecar

### New decision: flaky-tests-traced-through-the-round-window

body: in the sidecar

### Amend decision: intake-reads-past-stray-lines

body: in the sidecar

### Amend decision: intake-writers-are-gated

body: in the sidecar

### New decision: leftovers-counted-around-each-round

body: in the sidecar

### Amend decision: live-sprints-brought-current-on-true-up

body: in the sidecar

### New decision: locks-grow-from-observed-failures

body: in the sidecar

### New decision: locks-named-from-a-project-list

body: in the sidecar

### Amend decision: no-execution-engine

body: in the sidecar

### New decision: one-confirm-driver-per-defect

body: in the sidecar

### New decision: one-verifier-bar-for-every-certification-fix

body: in the sidecar

### Amend decision: planned-tests-name-their-waits

body: in the sidecar

### Amend decision: product-slow-fixes-ride-a-round-that-runs-anyway

body: in the sidecar

### Amend decision: profiles-name-their-tools

body: in the sidecar

### Amend decision: project-declares-its-folders

body: in the sidecar

### Amend decision: project-owns-its-suite-command

body: in the sidecar

### New decision: ranking-charges-each-test-its-wall-time-cost

body: in the sidecar

### Amend decision: records-stay-out-of-context

body: in the sidecar

### New decision: review-forks-own-pass-tasks

body: in the sidecar

### New decision: review-passes-split-by-reading

body: in the sidecar

### Amend decision: round-failure-cleared-by-a-later-round

body: in the sidecar

### New decision: rounds-checked-against-the-locks

body: in the sidecar

### New decision: runs-lock-what-their-tests-declare

body: in the sidecar

### New decision: runs-stop-on-silence

body: in the sidecar

### New decision: runtime-parts-declared-in-the-scenario-list

body: in the sidecar

### Amend decision: scenario-list-decided-once

body: in the sidecar

### New decision: scenario-list-maps-each-test-without-a-tag

body: in the sidecar

### New decision: scenario-list-written-at-the-archive-step

body: in the sidecar

### Amend decision: second-whole-suite-round-refuses

body: in the sidecar

### New decision: session-writes-no-scenario-field-value

body: in the sidecar

### Amend decision: settings-have-no-code-defaults

body: in the sidecar

### New decision: shared-outcomes-checked-for-a-new-instance

body: in the sidecar

### New decision: short-close-holds-named-roles

body: in the sidecar

### New decision: sign-off-finds-then-fixes-once

body: in the sidecar

### New decision: sign-off-runs-on-the-task-tracker

body: in the sidecar

### New decision: skill-surfaces-reviewed-not-driven

body: in the sidecar

### Amend decision: skills-read-only-the-current-layout

body: in the sidecar

### Amend decision: speed-ranked-by-median-seconds

body: in the sidecar

### Amend decision: speed-read-at-three-points

body: in the sidecar

### Amend decision: sprint-goal-read-from-the-repository

body: in the sidecar

### Amend decision: sprints-carry-an-approval-mark

body: in the sidecar

### Amend decision: sprints-plan-what-their-work-reaches

body: in the sidecar

### Amend decision: stack-helpers-serve-project-commands

body: in the sidecar

### Amend decision: stopped-round-files-one-report

body: in the sidecar

### New decision: story-test-stamp-is-its-planned-blob

body: in the sidecar

### Amend decision: suite-contracts-checked-before-a-round

body: in the sidecar

### New decision: suite-defects-take-no-send-back-limit

body: in the sidecar

### New decision: taken-defects-fixed-by-certification

body: in the sidecar

### Amend decision: team-execution-cold-gate

body: in the sidecar

### Amend decision: test-loop-fixes-code-never-tests

body: in the sidecar

### New decision: test-stack-budgeted-as-one-resource

body: in the sidecar

### Amend decision: test-support-written-before-tests

body: in the sidecar

### Amend decision: test-tasks-own-the-tests

body: in the sidecar

### Amend decision: testing-set-up-by-its-own-verb

body: in the sidecar

### Amend decision: tests-isolated-unless-declared

body: in the sidecar

### New decision: tests-remove-what-they-create

body: in the sidecar

### New decision: tests-run-in-a-new-random-order

body: in the sidecar

### New decision: tests-set-up-their-own-starting-state

body: in the sidecar

### Amend decision: tests-spend-time-only-on-their-outcome

body: in the sidecar

### New decision: whole-suite-rounds-repeat-until-one-passes

body: in the sidecar

### New decision: workers-sized-per-machine

body: in the sidecar

## Work items

### Record locks and the lock list in the scenario list

The tests tool records each test's declaration as `locks`, a list of `{name, mode}` with mode `exclusive` or `shared`, in place of `resources` and `reads`, on planner `scenarios` items, `tests` items, the assembled plan, the live tests, and the scenario list the stamp writes; nothing in the tool reads, writes, or derives `resources`, `reads`, or the implied read of every resource. The scenario list holds the lock list, each name with the one line saying what shared thing it guards, and the locks each test support file declares. New verbs: `tests locks` prints the list; `tests locks add <name> --guards "<line>"` adds a name, refusing one that is not a slug or is already listed; `tests locks remove <name>` removes one, refusing while a live test or a test support file declares it. Each writes the scenario list under one lock by atomic replace. Every verb that reads a declaration (plan assembly, `run`, the task stages' briefs, `stamp`) refuses a lock name the list does not hold, and a mode other than the two, naming the test, the name, and `tests locks add`. A test support task records a file's locks as a `locks` item keyed by the file's path, and a test takes the locks of every test support file it lists, exclusive where either declares the name exclusive. The usage text states all of this. Makes true `decision:tests-isolated-unless-declared`, `decision:locks-named-from-a-project-list`, `decision:scenario-list-decided-once`. Carries `back-out-reads-and-side-by-side-tests`. Changes `plugins/ok/families/ok-planner/scripts/tests`.

### Hand the suite command each test's locks in a new random order

Each run of `tests run` writes `{tests}` as `{"workers": <n>, "seed": <seed>, "tests": [{"path", "name", "locks": [{"name", "mode"}]}]}`, the tests listed in the order of a key that a seed drawn fresh for that run gives each test, from the seed and the test's scenario id, and records the seed in the round's header; `tests run --seed <n>` orders the tests by the keys that seed gives, so a run of any subset keeps a round's relative order and a fixer replays it over the failing test and its window. Before setup and the suite command start, the run takes each lock name its tests declare, in name order, exclusive where one of its tests holds the name exclusive and shared otherwise, holds it until the run ends, and, while it waits on another run, prints one line naming that run and the lock; a run of isolated tests takes none. The usage text tells the suite command to start the tests in the listed order and to start a test only once it holds every lock the test declares. Makes true `decision:tests-run-in-a-new-random-order`, `decision:runs-lock-what-their-tests-declare`, `decision:project-owns-its-suite-command`. Carries `back-out-reads-and-side-by-side-tests`. Changes `plugins/ok/families/ok-planner/scripts/tests`. Builds on "Record locks and the lock list in the scenario list".

### Check each round against the locks

After each round, `tests failures` lists a `locks--<test>--<test>` entry for each pair of tests that ran at the same time while holding one lock name, at least one of them exclusive, by the suite command's clock where both lines carry `started` and `ended` and by arrival otherwise; the entry's tail names the lock, each test's mode, the times, and the clock. The check runs on every round that records arrival times, with no gate on an owner's word. `tests reports` files each such entry as a T4 lock breach; `tests tasks --stage speed --round` refuses a round whose only failures are lock breaches or a failed setup; the round-failure clearing rule treats a lock breach as it treated a schedule pair. The sprint class table names T4 "A lock breach", and the merge prompt files a T4 defect at state `rewrite` for a test support task that changes how the suite command starts the tests. `/converge`'s steps 3a.2, 3a.3, 5a, and 6a, and its return's `suite` line, name `locks--<a>--<b>` and a lock breach wherever they named `schedule--<a>--<b>` and a schedule breach, so a lock breach's confirm runs `tests run --only` on the pair. Makes true `decision:rounds-checked-against-the-locks`, `decision:round-failure-cleared-by-a-later-round`, `decision:speed-read-at-three-points`, `decision:one-verifier-bar-for-every-certification-fix`. Carries `back-out-reads-and-side-by-side-tests`. Changes `plugins/ok/families/ok-planner/scripts/tests`, `plugins/ok/families/ok-planner/skills/_sprint/shared.md` (the T4 row), `plugins/ok/families/ok-planner/skills/converge/prompts/merge.md`, `plugins/ok/families/ok-planner/skills/converge/SKILL.md` (steps 3a.2, 3a.3, 5a, 6a, and the return's `suite` line). Builds on "Record locks and the lock list in the scenario list".

### Rank the slowest tests by the lock bound

Every slowest list `tests run`, `tests slowest`, and `tests stamp` print or write charges each test by how much it lowers a lower bound on a round's wall time under the tests' locks: the larger of all tests' seconds over the workers and, for each lock name, its exclusive holders' seconds summed plus the larger of its longest shared holder's seconds and its shared holders' total over the workers. A round's ranking takes the workers its header records; `--from state` and the stamp take the budget's workers. The ranking reads no `testing.schedule`. Makes true `decision:ranking-charges-each-test-its-wall-time-cost`, `decision:speed-ranked-by-median-seconds`. Carries `back-out-reads-and-side-by-side-tests`, `decisions-bundling-several-choices-await-a-split`. Changes `plugins/ok/families/ok-planner/scripts/tests`. Builds on "Record locks and the lock list in the scenario list".

### Add `tests window`

`tests window --sprint <path> --round <n> --test <scenario>` prints, for that test in that round, each test whose run overlapped it and each test that ended before it started, with each one's start, end, and the clock that gave them, and marks each that declares a lock name the named test holds, naming the name and both modes. It refuses a round the results file does not hold and a test the round did not run, and writes nothing. Makes true `decision:flaky-tests-traced-through-the-round-window`. Carries `back-out-reads-and-side-by-side-tests`. Changes `plugins/ok/families/ok-planner/scripts/tests`. Builds on "Record locks and the lock list in the scenario list".

### Retire `testing.schedule`

No tool reads `testing.schedule`: the tests tool no longer requires it, `tests declare` refuses `--schedule` and `--schedule-said` with a message naming the lock model, and drops the key where the config holds it; the lint's `config-check` no longer lists `schedule` among the testing keys. True-up removes `testing.schedule` from each project's config as a step of its plan, no longer writes it as a former setting, and no longer files `testing-schedule-unconfirmed`. `/ok-setup` drops its schedule step and every mention of it, and its runner step describes the `{tests}` file with `locks`. Makes true `decision:testing-set-up-by-its-own-verb`, `decision:tests-isolated-unless-declared`. Carries `back-out-reads-and-side-by-side-tests`. Changes `plugins/ok/families/ok-planner/scripts/tests`, `plugins/ok/families/ok-planner/scripts/plumbline`, `plugins/ok/families/ok-planner/admin/true-up`, `plugins/ok/families/ok-planner/admin/ADMINISTRATION.md`, `plugins/ok/families/ok-planner/skills/ok-setup/SKILL.md`.

### Convert earlier declarations to locks on true-up

`tests convert-state` recognizes a scenario list whose scenarios record `resources` or `reads` as an earlier form and converts it: each `resources` slug becomes that name held `exclusive`, each `reads` slug is dropped with no `shared` lock in its place, the implied read of every resource is dropped, and each converted name joins the lock list with the line `converted from the shared resource <name>; say what shared thing it guards`. The same conversion rewrites each open sprint's `-plan.json`. True-up runs it as a step of its plan, drops the recorded budget's preflight mark so the next tested sprint's preflight checks the suite command against the locks, and, where `testing.enabled` is `on` or `frozen`, files one intake issue, `testing-suite-command-locks`, kind `audit` and category `test`, that names `testing.run`, says the suite command now receives `locks` in place of `resources` and `reads` and must start the listed tests in order and only once each holds its locks, and names `/ok-setup`'s runner check. `ADMINISTRATION.md` describes the step, the issue, and the `{tests}` file with `locks`. Makes true `decision:tests-isolated-unless-declared`, `decision:locks-grow-from-observed-failures`, `decision:live-sprints-brought-current-on-true-up`. Carries `back-out-reads-and-side-by-side-tests`. Changes `plugins/ok/families/ok-planner/scripts/tests`, `plugins/ok/families/ok-planner/admin/true-up`, `plugins/ok/families/ok-planner/admin/ADMINISTRATION.md`. Builds on "Record locks and the lock list in the scenario list".

### Keep a per-machine worker record and add `tests machine`

`tests machine` measures the machine (cores, memory, Docker memory, and the memory containers outside the tests run hold) and prints the measurement beside the record at `.ok-planner/.cache/tests-machine.json`, writing nothing. `tests machine --workers <n> --reason "<constraint>" --evidence "<a round, a preflight task, or a measurement>"` writes the record: the measurement taken then, the count, and a dated history entry with the reason and the evidence, appended to the entries before it; it refuses a count below 1 or above the budget's workers. Where the record exists, every `tests run` runs the record's count, never more than the budget's. `tests run --workers <n>` runs that count in place of the record's or the budget's, refusing one below 1 or above the budget's workers, so a fixer reproduces a round at the count it ran. The round's header records the count and whether it came from the flag, the record, or the budget. The usage text states this. Makes true `decision:workers-sized-per-machine`, `decision:flaky-tests-traced-through-the-round-window`, `story:suite-fits-the-machine-it-runs-on`. Carries `suite-workers-adapt-to-the-machine`. Changes `plugins/ok/families/ok-planner/scripts/tests`.

### Let the preflight and the budget planner lower the machine's count

The preflight runs `tests machine` first; where the machine cannot carry the budget's workers, such as Docker memory below what the sizing needs or memory other containers hold, it writes a lowered count with `tests machine --workers` naming the constraint and the measurement, runs its checks at that count, and closes `done` naming the count, closing `blocked` only where one worker does not fit. The budget planner reads the record and the measurement, and may write a lowered count for this machine with its reason; the committed budget's workers stay the count every machine starts from. Makes true `decision:workers-sized-per-machine`, `decision:test-stack-budgeted-as-one-resource`, `story:suite-fits-the-machine-it-runs-on`. Carries `suite-workers-adapt-to-the-machine`. Changes `plugins/ok/families/ok-planner/skills/converge/prompts/test-preflight.md`, `plugins/ok/families/ok-planner/skills/plan-sprint/tests-budget.md`. Builds on "Keep a per-machine worker record and add `tests machine`".

### Route a flaky test through its round's window

The fixer's flaky route reads `tests window` for the test and its round, the tests that failed with it, and the stack's logs for the window, and reproduces the failure with `tests run --only <the test and its window> --seed <the round's seed> --workers <the round's count>`. The prompt no longer calls a flaky test broken until its cause is found. A race: it records a `locks` item for each of the two tests, or for their test support file, naming the lock, the mode, and the evidence (the round, the window line, and the log lines), adding the name to the lock list first where none fits, and sets the defect `fixed`; the tests tool takes the item as the test's declaration, and the stamp records it. An overload: it lowers the machine's count with `tests machine --workers`, the round as evidence, adds no lock, and sets the defect `fixed`. Where it finds no cause, it records that it found none and adds nothing, and the defect rides the next whole-suite round; once a later whole-suite round passes, certification may close with that cause unfound. A missing lock is no longer a test-at-fault record. The fix verifier accepts a lock fix where the window shows the named test overlapping or preceding the failing one and both now hold the name, at least one exclusive; an overload fix where the logs show the load; and a found-none record where the window and logs show no cause. Each lock added reaches the completion report as a call. Makes true `decision:flaky-tests-traced-through-the-round-window`, `decision:locks-grow-from-observed-failures`, `decision:workers-sized-per-machine`, `decision:failing-tests-rerun-alone`. Carries `back-out-reads-and-side-by-side-tests`, `suite-workers-adapt-to-the-machine`. Changes `plugins/ok/families/ok-planner/skills/converge/prompts/fix.md`, `plugins/ok/families/ok-planner/skills/converge/prompts/verify.md`, `plugins/ok/families/ok-planner/scripts/tests`. Builds on "Record locks and the lock list in the scenario list", "Hand the suite command each test's locks in a new random order", "Add `tests window`", and "Keep a per-machine worker record and add `tests machine`".

### Count a pass as fixed under `testing.reaches` `none`

Under `testing.reaches` `none`, the fixer's lone-rerun step counts a pass as fixed where any fix landed since the test's failing round, and sends the pass down the flaky route only where none did; where `testing.reaches` names `files` or `folders`, the step keeps reading `tests reached` as now. `tests reached` under `none` still lists nothing, and its note says that the fix prompt counts a pass as fixed after any landed fix. Makes true `decision:failing-tests-rerun-alone`. Carries `decisions-bundling-several-choices-await-a-split`. Changes `plugins/ok/families/ok-planner/skills/converge/prompts/fix.md` and `plugins/ok/families/ok-planner/scripts/tests` (`cmd_reached`'s note). Builds on "Route a flaky test through its round's window".

### Have writers declare only the locks their tests show

The `{{TEST-RESOURCES-RULE}}` block becomes a locks rule: a test declares a lock on each shared thing it sets up or checks (exclusive) or only changes without caring what others do (shared), by a name from `tests locks`, adding one only where none fits, named in the product's words at the narrowest scope two tests can both see; state only one test can see needs none; and it declares nothing it does not see in its own code or its test support. The story and runtime planner prompts declare no lock of their own: a planner records `locks` only on a re-plan, carrying each lock a writer or a fixer recorded for the scenario. The test support prompt records the locks its file's code shows. The planner review and plan-wide review check that a re-plan carries the recorded locks and send back a lock a cheaper design avoids; the test writer records `locks` on its `tests` item; the test verifier judges each lock change against the test's code and records each lock added as a call; the speed reviewer and `{{TEST-SPEED-JUDGING}}` and `{{TEST-WASTE-RULE}}` name a lock held where a cheaper design keeps the test isolated, with the cost under the lock bound. No prompt asks for a search of other tests that might disturb one. Makes true `decision:locks-grow-from-observed-failures`, `decision:locks-named-from-a-project-list`, `decision:tests-isolated-unless-declared`, `decision:tests-spend-time-only-on-their-outcome`. Carries `back-out-reads-and-side-by-side-tests`. Changes `plugins/ok/families/ok-planner/skills/_sprint/shared.md`, `plugins/ok/families/ok-planner/skills/plan-sprint/tests.md`, `plugins/ok/families/ok-planner/skills/plan-sprint/tests-story.md`, `plugins/ok/families/ok-planner/skills/plan-sprint/tests-runtime.md`, `plugins/ok/families/ok-planner/skills/converge/prompts/test-write.md`, `plugins/ok/families/ok-planner/skills/converge/prompts/test-support.md`, `plugins/ok/families/ok-planner/skills/converge/prompts/test-verify.md`, `plugins/ok/families/ok-planner/skills/converge/prompts/test-speed.md`. Builds on "Record locks and the lock list in the scenario list".

### Have each test set up its own starting state

The test writer, test support, and test verifier prompts require that each test sets up the starting state it needs and relies on no earlier test, takes the exclusive lock of any shared state it sets up, removes the records it creates in teardown through the product's removal action, and, where it checks a shared outcome, resets it in setup under its exclusive lock or reads its state before the action and checks for a new instance after. The verifier sends back a test that does not. Makes true `decision:tests-set-up-their-own-starting-state`, `decision:tests-remove-what-they-create`, `decision:shared-outcomes-checked-for-a-new-instance`. Carries `back-out-reads-and-side-by-side-tests`. Changes `plugins/ok/families/ok-planner/skills/converge/prompts/test-write.md`, `plugins/ok/families/ok-planner/skills/converge/prompts/test-support.md`, `plugins/ok/families/ok-planner/skills/converge/prompts/test-verify.md`, `plugins/ok/families/ok-planner/skills/_sprint/shared.md`. Builds on "Have writers declare only the locks their tests show".

### Keep the session out of scenario field values

The "Fixing a planner's items" rule names the field values no mechanical fix covers, `locks` among them beside `action`, `waits`, `kind`, `setup`, `entry`, `reach`, `test_support`, and `silence`, and says the session writes no field value on a scenario item for a story in the sprint's scope or outside it: each lock change comes from the test writer or the flaky fixer, and a story's re-plan carries it. The budget prompt records no per-scenario declaration list and no keep entries for the session to carry, and step 4's condition reads "the plan declares a lock name no recorded test declares". Makes true `decision:session-writes-no-scenario-field-value`, `decision:tests-planned-in-execution`. Carries `session-applies-planner-declarations`. Changes `plugins/ok/families/ok-planner/skills/plan-sprint/tests.md`, `plugins/ok/families/ok-planner/skills/plan-sprint/tests-budget.md`.

### State the lock model in the testing standard and the cheatsheet

The testing standard replaces its schedule section with the lock model, the lock list, the run locks, the lock check, random order with its seed, the starting-state and shared-outcome rules, and the per-machine worker count; its flaky section names the window, the lock route, the overload route, and found-none, and says a found-none flaky test lets a later passing whole-suite round close certification; its ranking text gives the lock bound; its waste and speed-read text name locks for `resources` and `reads`. The cheatsheet's Tests section restates the same in its ambient lines, with no `resources`, `reads`, or `testing.schedule`. Makes true `decision:tests-isolated-unless-declared`, `decision:locks-named-from-a-project-list`, `decision:locks-grow-from-observed-failures`, `decision:tests-set-up-their-own-starting-state`, `decision:tests-run-in-a-new-random-order`, `decision:ranking-charges-each-test-its-wall-time-cost`, `decision:flaky-tests-traced-through-the-round-window`, `decision:workers-sized-per-machine`. Carries `back-out-reads-and-side-by-side-tests`, `suite-workers-adapt-to-the-machine`. Changes `plugins/ok/families/ok-planner/docs/testing.md`, `plugins/ok/families/ok-planner/docs/plumbline-cheatsheet.md`.

### Check the suite command against the locks before a round

The preflight's and `/ok-setup`'s line-timing check runs two recorded tests that hold one lock name, at least one exclusive, and checks that they did not overlap and that each line arrived as its test ended, skipping where no recorded pair holds such a name. Makes true `decision:suite-contracts-checked-before-a-round`. Carries `back-out-reads-and-side-by-side-tests`. Changes `plugins/ok/families/ok-planner/skills/converge/prompts/test-preflight.md`, `plugins/ok/families/ok-planner/skills/ok-setup/SKILL.md`. Builds on "Hand the suite command each test's locks in a new random order".

### Run the setup checks with no recorded test

Where the scenario list records no test, `/ok-setup`'s runner check, like the preflight, still runs `testing.setup` twice and checks that each run exits 0, and runs it beside a scratch resource and checks that it exits 0 and the resource still stands; each site skips only the readiness half and says so in one line. The runner check's kind-and-setup comparison, which has nothing to compare, says so in one line and no longer ends the step. Makes true `decision:suite-contracts-checked-before-a-round`. Carries `preflight-setup-checks-with-no-recorded-test`. Changes `plugins/ok/families/ok-planner/skills/ok-setup/SKILL.md`, `plugins/ok/families/ok-planner/skills/converge/prompts/test-preflight.md`.

### Move each decision citation to the decision that holds its choice

Every `@decision: tests-isolated-unless-declared` and `@decision: test-loop-fixes-code-never-tests` in code names the decision whose choice its site enforces after the split: lock declarations stay on `tests-isolated-unless-declared`; run locks go to `runs-lock-what-their-tests-declare`; pair checks to `rounds-checked-against-the-locks`; ranking to `ranking-charges-each-test-its-wall-time-cost`; budget and preflight filing to `test-stack-budgeted-as-one-resource`; leftover counts to `leftovers-counted-around-each-round`; the silence stop in `run_suite` to `runs-stop-on-silence`; the standing-failure rerun to `failing-tests-rerun-alone`; the fix loop's settling and reports stay on `test-loop-fixes-code-never-tests`, save a site that enforces a choice split from it at sign-off, which cites that choice's decision: the verify filing and the confirm rerun cite `one-verifier-bar-for-every-certification-fix`, the uncapped send-backs of a suite defect `suite-defects-take-no-send-back-limit`, the repeated whole-suite rounds and `review certified`'s round refusals `whole-suite-rounds-repeat-until-one-passes`, and a refusal of a fixer's test edit `fixers-never-edit-tests`. Every `@decision: scenario-list-decided-once` names the same way the decision split from it whose choice its site enforces: `scenario-list-maps-each-test-without-a-tag`, `runtime-parts-declared-in-the-scenario-list`, `story-test-stamp-is-its-planned-blob`, or `scenario-list-written-at-the-archive-step`. New sites the other items add cite their own decisions. Makes true `decision:tests-isolated-unless-declared`, `decision:test-loop-fixes-code-never-tests`, `decision:scenario-list-decided-once`. Carries `decisions-bundling-several-choices-await-a-split`. Changes `plugins/ok/families/ok-planner/scripts/tests`, `plugins/ok/families/ok-planner/scripts/review`. Builds on every other item of this cluster that changes `scripts/tests`.

### Hold the waiters of a short close for the roles a run names

The task tracker takes a run setting, `tasks config set held_roles '["<role>", ...]'`, beside `swept_roles`. Where a task of a named role closes `partial` or `blocked`, every wait on it stays open until a refile of that task exists, and the waiters then wait on the refile, as `tasks refile` already adds it to each open waiter: `next` neither issues nor counts a held waiter as waiting, `claim --agent` never takes one, and `claim <task>` refuses one, naming the short task, its outcome, and that it waits for a refile. The close that holds waiters records one `TASKS.TASK.HELD` event naming the short task and each waiter it holds, and prints no new line the drain reads. A run that names no roles keeps today's rule: a short close frees its waiters as a `done` close does, so `/converge`'s fix chains and confirm-drive relays run as they do. The tracker's usage text documents the setting and the changed `next`, `claim`, and `refile` behavior, and the readiness check carries `@decision: short-close-holds-named-roles`. Makes true `decision:short-close-holds-named-roles`, `decision:build-task-per-stage`, and `concept:task-tracker`. Carries `short-close-frees-waiting-tasks`. Changes `plugins/ok/families/ok-planner/scripts/tasks` (`open_waits` and its callers `ready` and `cmd_claim`, `cmd_close`, the usage text). Depends on the `short-close-holds-named-roles` delta for its citation.

### Name the build role as held in sprint execution

The sprint boilerplate's "Open the run" step declares `tasks config set held_roles '["build"]'` beside `swept_roles`, on a resumed run too, and its drain step says that the tracker holds every task waiting on a build closed `partial` or `blocked` until the session refiles that build, so the session refiles each short build before it drains again. No other run's text names a held role. Each boilerplate line the change replaces joins the released lines true-up brings current in a live sprint. Makes true `decision:short-close-holds-named-roles` and `decision:build-task-per-stage`. Carries `short-close-frees-waiting-tasks`. Changes `plugins/ok/families/ok-planner/skills/plan-sprint/sprint-document.md` (steps 3 and 7) and `plugins/ok/families/ok-planner/admin/retired-boilerplate.json`. Depends on "Hold the waiters of a short close for the roles a run names".

### Give every driver a scratch folder outside the checkout

`review drives`, in its story and confirm forms, names in every brief a scratch folder for the driver's drive name under the system temp directory, `drive-scratch-<drive name>`, and lists it as `scratch` in its output, as it names an instance folder. The drive prompt tells the driver to create that folder fresh, removing what an earlier driver of the same name left, and to keep in it every file it writes: each command's saved output, such as a shell redirect's target, its scratch copy of the project, and its scratch project, never a file in the checkout. Its skill-surface, confirm, rules, and clean-up sections name the same folder, and the driver removes the folder when it cleans up. The shared drive text's driver step says the verb names the folder. The function that names the folder carries `@decision: drive-writes-only-in-scratch`. Makes true `decision:drive-writes-only-in-scratch`, `decision:skill-surfaces-reviewed-not-driven`, and `story:find-and-fix-defects`. Carries `drive-prompt-names-no-output-folder`. Changes `plugins/ok/families/ok-planner/scripts/review` (`cmd_drives` and a function beside `instance_folders`), `plugins/ok/families/ok-planner/skills/converge/prompts/drive.md`, and `plugins/ok/families/ok-planner/skills/_converge/drive.md` (step 3). Depends on the `drive-writes-only-in-scratch` delta for its citation.

### Point each decision citation at the split decision that holds its choice

Every `@decision:` citation under `plugins/` names the decision that holds the choice its site enforces, after the split of `decision:team-execution-cold-gate` and `decision:drive-tries-each-story-as-a-user`. The citation on `confirm_briefs` in the review script moves to `@decision: one-confirm-driver-per-defect`. The citation on `certification_failures`, which checks that each required story had its driver, stays on `drive-tries-each-story-as-a-user`. The tracker's claim order in `next_claim` carries `@decision: claim-takes-the-most-waited-on`, and the pass-task checks in `task_records` that refuse a fork task off a root not running, on another profile, or with waits carry `@decision: review-forks-own-pass-tasks`. Makes true `decision:one-confirm-driver-per-defect`, `decision:claim-takes-the-most-waited-on`, `decision:review-forks-own-pass-tasks`, and `decision:drive-tries-each-story-as-a-user`. Carries `decisions-bundling-several-choices-await-a-split`. Changes `plugins/ok/families/ok-planner/scripts/review` and `plugins/ok/families/ok-planner/scripts/tasks`. Depends on the split's deltas, and shares files with the two items above, so it runs after them.

### Sign-off checks each delta body against each rule once, fixes once, and checks only what it changed

`/plan-sprint`'s sign-off takes the shape `decision:sign-off-finds-then-fixes-once` records, on the task tracker as `decision:sign-off-runs-on-the-task-tracker` records. The compliance reviewer file states the checklist: for each kind of delta body, the rules of the review that bind it, and for each body and rule one verdict, `passes` or `fails` with the finding and its class, recorded as a `verdicts` item. It gains an `agreement` rule: a body contradicts no body or live artifact it cites or amends, and an amendment drops nothing of its live artifact silently. The session opens a sign-off run beside the sprint, cuts the bodies into sets small enough to read whole, keeping bodies that cite each other or amend one artifact in one set, and files one root task on the review profile. The root reads the review's rules once and forks one reader per set; each reader task carries only its set, the prohibitions stated for it, and the findings already settled on it. One merge task on the opus profile folds duplicate failures into findings, sorts each `mechanical` or `judgment`, lists each pair with no verdict, and assembles the one suggested prohibitions list Approval presents. A pair with no verdict goes back to one reader task once, and a pair still without one goes on the Approval list. The session walks a judgment finding with the owner only where `{{OWNER-QUESTION-TEST}}` sends it, and records every other one as a call. One fixer task on the opus profile then fixes each finding once, changing only the passage it cites, runs the checklist on each body it changed and no other, fixes what that check finds in the same pass, and records what it cannot settle for the Approval list. The fixer's check reads no body the fixer did not change, the checklist never runs over the whole sprint a second time, and no cap or threshold stops a step. Every later "goes back through the compliance review" (a kickback at the owner's judgments, the relevance pass at Approval, a dropped prohibition, an owner's change at Approval) becomes the checklist for the amended body and each body that cites it, then the merge and the fixer for what it finds. Makes true `decision:sign-off-finds-then-fixes-once`, `decision:sign-off-runs-on-the-task-tracker`, `story:plan-a-sprint`. Carries `plan-sprint-sign-off-rereads-whole-scope-every-round`. Changes `plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md` (section 7, section 11's kickback, section 13, section 14's closing list of what the session writes), `plugins/ok/families/ok-planner/skills/_shared/design-doc-compliance-reviewer.md`, `plugins/ok/families/ok-planner/agents/ok-review.md` (its description), `plugins/ok/families/ok-planner/scripts/ok-cheatsheet.md` ("Subagent models"), `plugins/ok/families/ok-planner/scripts/ok-planner-cheatsheet.md` and `plugins/ok/families/ok-planner/scripts/ok-planner-CLAUDE.md` (the profile list under the task tracker), `plugins/ok/families/ok-planner/CLAUDE.md` (the layout line for `skills/_tasks/drain.md`).

### A defect the owner picks joins the sprint's defect list, not its work items

At Frame, each defect issue the owner picks goes under a new `## Defects` section of the sprint, one line per issue with its id, its site, and its harm, and gets no work item, no code planning, and no test scope. Terminal does not promote a taken defect: its issue stays open and unstamped. `## Intent` lists the promoted judgment issues, and Terminal's rule that every promoted id appears there stays true. Approval presents the `## Defects` list with the rest of the sprint. The sprint template carries the `## Defects` section, omitted where the sprint takes none, and states that sprint certification fixes each listed issue. Makes true `decision:taken-defects-fixed-by-certification`, `story:plan-a-sprint`. Carries `sprint-defects-fixed-by-certification`. Changes `plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md` (Frame's "Offer the defect issues", the counts line, section 13, Terminal step 1), `plugins/ok/families/ok-planner/skills/plan-sprint/sprint-document.md` (the template's `## Intent` and the new section).

### Sprint certification fixes the defect issues its sprint lists

`/converge sprint` takes up each defect issue the sprint lists under `## Defects` as a report, as `defects` mode takes up the backlog, and no other defect issue. `review backlog --sprint <path>` reads that section, adds one report per listed issue that stands open or verified in the intake, carrying its issue id, and lists each listed id that no longer stands open, or that names only files the run leaves alone, under `settled`. The merge counts each such report within the sprint's scope wherever its site lies, and folds a pass's report on the same site into it. The sprint catalog's scope test names a listed defect issue as in scope. The owner list closes each listed issue whose defect stands `verified` as `fixed`, naming the run, and routes every other one as it routes any defect issue a run took up. The return's backlog line covers sprint mode, and the execution boilerplate's step that names what certification fixes names the listed defect issues. Makes true `decision:taken-defects-fixed-by-certification`, `decision:defects-outside-scope-become-defect-issues`, `story:certify-completion`, `story:find-and-fix-defects`. Carries `sprint-defects-fixed-by-certification`. Changes `plugins/ok/families/ok-planner/scripts/review` (`cmd_backlog`), `plugins/ok/families/ok-planner/skills/converge/SKILL.md` (the Find list, the backlog section, sprint mode's steps, the return), `plugins/ok/families/ok-planner/skills/converge/prompts/merge.md`, `plugins/ok/families/ok-planner/skills/converge/prompts/owner-list.md`, `plugins/ok/families/ok-planner/skills/_sprint/shared.md` (`{{SPRINT-CATALOG}}`'s scope test), `plugins/ok/families/ok-planner/skills/plan-sprint/sprint-document.md` (step 12), `plugins/ok/families/ok-planner/admin/retired-boilerplate.json`. Depends on "A defect the owner picks joins the sprint's defect list, not its work items".

### The completion contract checks that certification took up every listed defect issue

The completion contract's item 3 names that the certification's run took up each defect issue the sprint lists under `## Defects`, and `review certified --sprint <path>` prints `SPRINT NOT COMPLETE` naming each listed id that still stands open in the intake with no report in the certification's ledger. A sprint with no `## Defects` section passes the term. Makes true `decision:taken-defects-fixed-by-certification`, `story:certify-completion`. Carries `sprint-defects-fixed-by-certification`. Changes `plugins/ok/families/ok-planner/scripts/review` (`cmd_certified`), `plugins/ok/families/ok-planner/skills/plan-sprint/sprint-document.md` (the completion contract and its goal rule), `plugins/ok/families/ok-planner/admin/retired-boilerplate.json`. Depends on "Sprint certification fixes the defect issues its sprint lists".

### The intake rules say a taken defect is fixed by certification

Every rules text that says a defect issue picked into a sprint joins as a ruled issue, closes as `promoted`, or that sprint certification reads no defect issue, says instead that a taken defect stays open, that the certification of the sprint that lists it takes it up, and that its owner list closes it as `fixed` or routes it as any defect issue. The life of a defect issue reads filed, triaged, then fixed or answered. Makes true `decision:taken-defects-fixed-by-certification`. Carries `sprint-defects-fixed-by-certification`. Changes `plugins/ok/families/ok-planner/scripts/ok-planner-cheatsheet.md` ("Routing" and "Closing" under Defect issues), `plugins/ok/families/ok-planner/scripts/ok-planner-CLAUDE.md` (the intake section's closing paragraph and the lifecycle summary), `plugins/ok/families/ok-planner/skills/_shared/artifact-definitions.md` (`{{ISSUE-DEFINITION}}` and `{{ISSUE-FILE-FORMAT}}`).

### Out-of-band work changed after Reconcile is reviewed before the handoff commits it

Reconcile records the commit and the tree it read (the tree id the same `GIT_INDEX_FILE` command `/plan-docs` uses prints), and the sprint carries both on one line. Before Approval presents the sprint, the session compares the current tree with the recorded one. Each path outside `.ok-planner/` that differs, by a commit or in the working tree, goes through `{{OUT-OF-BAND-REVIEWER-PROMPT}}`, and each bearing change joins the Reconcile batch and its one summary as Reconcile step 4 drafts it. The sprint's line then records the new commit and tree. `{{PLANNING-HANDOFF}}`, for a sprint, commits a path outside `.ok-planner/` only where it matches the recorded tree. Where a path differs, the handoff names it as changed after the last reconcile, commits nothing, and the session runs the Approval comparison again for it, so a bearing change returns the changed sprint to the owner for approval before any commit. The documentation sprint's handoff stays as it stands. Makes true `story:plan-a-sprint`, `decision:out-of-band-work-reconciled-as-a-batch`, `decision:closing-commit-baseline`. Carries `plan-sprint-skips-out-of-band-work-after-reconcile`. Changes `plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md` (section 3 and section 13), `plugins/ok/families/ok-planner/skills/_sprint/shared.md` (`{{PLANNING-HANDOFF}}`), `plugins/ok/families/ok-planner/skills/plan-sprint/sprint-document.md` (the template line).

### Execution creates the progress checklist and renders the report before any drain

In the sprint template's "How to execute this sprint", the step that creates the progress checklist and the step that renders the completion report both come before the first drain in step order. The step that files the build tasks drains nothing, and the filing and draining of the test stages sits in a step after the checklist and the report. Every step number the section, the test planning procedure, and the converge skill cite still names the step it meant. The retired boilerplate list carries the section's old lines, so true-up brings each live sprint to the new order. Makes true `story:watch-execution-progress`, `decision:task-tools-mirror-the-report`. Carries `test-stage-drain-precedes-progress-checklist`. Changes `plugins/ok/families/ok-planner/skills/plan-sprint/sprint-document.md`, `plugins/ok/families/ok-planner/skills/plan-sprint/tests.md`, `plugins/ok/families/ok-planner/admin/retired-boilerplate.json`.

### Move the closed-issue file out of the archive

The intake module keeps every closed issue's record in `.ok-planner/closed-issues.jsonl`, the closed-issue file, and reads and writes no file under `.ok-planner/history/`. Closing an issue moves its record there; `issues history`, `issues show`, `issues find`, `issues select --state closed`, the uniqueness check on a record's id and opened time, and the stray-line repair all read it there, and every message and help line that named the archive names the closed-issue file. `issues promote` checks that the sprint it names stands under `.ok-planner/sprints/`, the only place a sprint being planned sits. The dashboard keeps reading closed issues through the module, with no change of its own. The review tool's `record` ownership class lists `.ok-planner/closed-issues.jsonl`. Makes true `decision:closed-issues-leave-the-live-file`, `decision:intake-reads-past-stray-lines`, and `decision:archive-read-by-nothing`. Carries `true-up-check-reads-archived-sprints`. Changes `plugins/ok/families/ok-planner/scripts/issues` and `plugins/ok/families/ok-planner/scripts/review` (the ownership classes only).

### Keep the closed-record ledger in the review tool

The review tool owns the closed-record ledger, `.ok-planner/closed-records.jsonl`, one JSON line per closed record: its kind (`sprint`, `doc-sprint`, `test-sprint`, `sketch`, or `archived`, a name true-up moved into the archive), its file name (for `archived`, its path under the archive), and, for every kind but `sketch` and `archived`, its closing commit. `review close --kind <kind> --name <file name> [--commit <sha>]` appends one entry; it requires a commit on the current branch for a sprint and a documentation sprint, refuses one for a sketch or an `archived` entry, refuses a name the ledger already lists for that kind, and refuses a sprint or documentation sprint whose file does not stand in its live folder. It writes the file whole by atomic replace. `review closed [--kind <kind>] [--json]` lists the entries in the order they were written. A function the docs and tests tools import does each read and write, so the ledger has one writer. `review certified --sprint <path>` takes the sprint's file name from the path and checks the ledger first: where the ledger lists that name as a closed sprint with a commit, it prints `SPRINT COMPLETE` as terminal from the ledger, even while the archive step has yet to move the file, and opens no file under `.ok-planner/history/`; otherwise, where the file stands under `.ok-planner/sprints/`, it checks the contract as now; otherwise it refuses. `review stories`, `review drives`, `review deltas`, and `review approved` take a sprint under `.ok-planner/sprints/` only, and the `ARCHIVED_SPRINTS` fallback goes. `sprints_closed_since` reads the ledger's sprint entries whose commit descends from the stamp. The verdict's closing line names the closed-record ledger, not a `closed:` stamp. The `record` ownership class lists `.ok-planner/closed-records.jsonl` and `.ok-planner/test-plans/`. Makes true `decision:closing-commit-baseline`, `decision:sprint-goal-read-from-the-repository`, `decision:sprints-carry-an-approval-mark`, and `decision:archive-read-by-nothing`. Carries `true-up-check-reads-archived-sprints`. Changes `plugins/ok/families/ok-planner/scripts/review`.

### Record a deferred verdict's issue id in the certification run

The owner list, for each deferred product-slow verdict, records the id of the issue it files, or of the open issue it finds already standing on the same site, as one item in the certification run's `deferred` pool through `tasks item add`, with the verdict's speed item, its site, and the issue's id as fields. Its closing line's counts stay as they are. `review certified` reads that pool from the certification run's ledger through `tasks`, and counts a deferred verdict as handed off where an item for its speed item and site carries an issue id. It reads neither the intake nor the closed-issue file for this, and matches no issue text against the site: `names_site` goes. The failure line says the certification run records no issue id for the verdict, and names the owner list as the step that records one. Makes true `decision:deferred-verdict-handed-off-through-the-intake` and `story:certify-completion`. Carries `deferred-verdict-check-counts-only-open-issues`. Changes `plugins/ok/families/ok-planner/skills/converge/prompts/owner-list.md` ("A deferred product-slow verdict is a design issue") and `plugins/ok/families/ok-planner/scripts/review` (`unfiled_deferred`, `names_site`, and `suite_failures`, which passes it the ledger).

### Read earlier test plans from the test-plan folder

The tests tool reads each earlier plan from `.ok-planner/test-plans/<sprint-name>-plan.json`, the test-plan folder, and orders plans newest first by the closing commits the closed-record ledger lists for their sprints, as it ordered them by `closed:` stamps before; a plan whose sprint the ledger lists with no commit, or does not list, is skipped. `archived_plans` and `ARCHIVED_PLAN_FOLDERS` go, and the tool opens no file under `.ok-planner/history/`. `tests stamp --sprint <path> --commit <sha>` takes the sprint at its `.ok-planner/sprints/` path, before the archive move, and refuses a sprint the ledger already lists. Every other verb that takes `--sprint` takes a sprint under `.ok-planner/sprints/` only. The help text of `calls` and `stamp` says so. Makes true `decision:archive-read-by-nothing`, `decision:sprints-plan-what-their-work-reaches`, `decision:scenario-list-decided-once`, and `decision:scenario-list-written-at-the-archive-step`. Carries `true-up-check-reads-archived-sprints`. Changes `plugins/ok/families/ok-planner/scripts/tests`. Builds on the ledger item.

### Record a documentation sprint's close in the ledger

`docs stamp --sprint <path> --commit <sha>` takes the documentation sprint at its `.ok-planner/doc-sprints/` path, before the archive move: it writes each docspec's run state as now, records the close in the closed-record ledger through the review tool's writer, and writes no `closed:` stamp into the sprint file. `docs complete` answers terminal from the ledger for a documentation sprint the ledger lists with a commit, and opens no file under `.ok-planner/history/`. Every verb that takes `--sprint` takes a documentation sprint under `.ok-planner/doc-sprints/` only, and `ARCHIVED_DOC_SPRINTS` goes. `docs window` lists, in each entry's `sprints`, each sprint the ledger lists as closed since the docspec's stamp, with its closing commit. Makes true `decision:docspec-stamp-opens-the-window`, `decision:closing-commit-baseline`, `decision:sprint-goal-read-from-the-repository`, and `decision:archive-read-by-nothing`. Carries `true-up-check-reads-archived-sprints`. Changes `plugins/ok/families/ok-planner/scripts/docs`. Builds on the ledger item.

### Write a sprint's bookkeeping before its archive move

The sprint template's archive step runs in this order on the owner's yes: close each promoted issue; split the large logs in place; commit the sprint's change, the intake's two files, and the `/converge` run's ledger, with the sprint still under `.ok-planner/sprints/` (the closing commit); run `tests stamp` on the sprint's live path with that commit, where its `-plan.json` stands or testing is `on` or `frozen`; run `review close --kind sprint --name <file name> --commit <sha>`; move the `-plan.json` into `.ok-planner/test-plans/`; move every other file sharing the sprint's name into `.ok-planner/history/sprints/`; then commit the moves, each sketch and discovery the planning session archived, `.ok-planner/closed-records.jsonl`, `.ok-planner/test-state.json`, and the moved plan, by name. No step writes a `closed:` stamp or reads a file under `.ok-planner/history/`. The execution section's "Read the sprint whole" step stops naming `history/` as context, the base step names the closed-issue file, and the goal rule says a sprint the closed-record ledger lists with its closing commit is terminal. The lines this replaces join `admin/retired-boilerplate.json`, so true-up's live-sprint pass brings each approved sprint not yet in execution to the new step. Makes true `decision:closing-commit-baseline`, `decision:archive-read-by-nothing`, and `decision:sprint-goal-read-from-the-repository`. Carries `true-up-check-reads-archived-sprints`. Changes `plugins/ok/families/ok-planner/skills/plan-sprint/sprint-document.md` and `plugins/ok/families/ok-planner/admin/retired-boilerplate.json`. Builds on the items that move the closed-issue file, keep the ledger, and read plans from the test-plan folder.

### Write a documentation sprint's bookkeeping before its archive move

`{{CEREMONY-ARCHIVE}}` runs in this order: split the large logs in place; commit the paths the run's tasks staged, each file `<also>` names, and the intake's two files where an issue was filed (the closing commit); run the stamp command on the documentation sprint's live path with that commit; move the documentation sprint and its companion files into `.ok-planner/history/doc-sprints/`; then commit the moves, `.ok-planner/closed-records.jsonl`, and what the stamp wrote, by name. The documentation sprint template's archive paragraph names `docs stamp --sprint .ok-planner/doc-sprints/<this file's name> --commit <sha>` and says the stamp records the close in the closed-record ledger, and its goal rule says a documentation sprint the ledger lists with its closing commit is terminal. The replaced template lines join `admin/retired-boilerplate.json`. Makes true `decision:closing-commit-baseline` and `decision:archive-read-by-nothing`. Carries `true-up-check-reads-archived-sprints`. Changes `plugins/ok/families/ok-planner/skills/_sprint/shared.md`, `plugins/ok/families/ok-planner/skills/plan-docs/doc-sprint-document.md`, and `plugins/ok/families/ok-planner/admin/retired-boilerplate.json`. Builds on the item that records a documentation sprint's close.

### Reconcile from the closed-record ledger

`/plan-sprint`'s Reconcile resolves its baseline as the commit of the last sprint entry `review closed --kind sprint --json` prints, and asks the owner for one where the ledger lists no sprint. The out-of-band reviewer counts each commit the ledger lists for a documentation sprint or a test sprint as that run's work, reads no file under `.ok-planner/history/`, and counts a change to the archive or to a bookkeeping file as ambient. The Terminal phase runs `review close --kind sketch --name <file name>` for each sketch before it moves the sketch into the archive. Makes true `decision:closing-commit-baseline`, `decision:out-of-band-work-reconciled-as-a-batch`, `decision:out-of-band-documentation-reconciled`, and `decision:archive-read-by-nothing`. Carries `true-up-check-reads-archived-sprints`. Changes `plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md` (Reconcile and Terminal) and `plugins/ok/families/ok-planner/skills/plan-sprint/core.md` (the out-of-band reviewer). Builds on the ledger item.

### Plan documentation from closing commits

`/plan-docs`'s planner reads, for each sprint a window entry lists as closed since the stamp, the commit's message and the corpus artifacts that commit changed, as they stand now, for what the change meant to a user, and reads no sprint document. An unexplained change is a change in the window to what the docspec describes that no listed closing commit made. The documentation sprint template's window section names each closing commit the plan read. Makes true `decision:docspec-stamp-opens-the-window` and `decision:archive-read-by-nothing`. Carries `true-up-check-reads-archived-sprints`. Changes `plugins/ok/families/ok-planner/skills/plan-docs/core.md`, `plugins/ok/families/ok-planner/skills/plan-docs/SKILL.md` (the window paragraph), and `plugins/ok/families/ok-planner/skills/plan-docs/doc-sprint-document.md` (the window section). Builds on the item that records a documentation sprint's close.

### Check a sketch's name against the ledger

`/sketch` counts a name as taken where `.ok-planner/sketches/` holds a file of that name or `review closed --kind sketch` lists it, and reads nothing under `.ok-planner/history/`. Its note on an abandoned sketch tells the owner to record it with `review close --kind sketch --name <file name>` before moving it into the archive. Makes true `decision:closing-commit-baseline` and `decision:archive-read-by-nothing`. Carries `true-up-check-reads-archived-sprints`. Changes `plugins/ok/families/ok-planner/skills/sketch/SKILL.md`. Builds on the ledger item.

### Drive an archived sprint only on the owner's word

`/drive sprint <path>` keeps taking an archived sprint's path, because the owner who names the path directs the read. The skill reads that sprint only for the stories it names, never to learn the project's current state, and no step finds an archived sprint on its own: `review stories --sprint` and `review drives --sprint` take an archived path only where the caller names it, with no fallback from a live path to the archive. `/drive` with no sprint still drives every story. Makes true `decision:archive-read-by-nothing` and `decision:records-stay-out-of-context`. Carries `true-up-check-reads-archived-sprints`. Changes `plugins/ok/families/ok-planner/skills/drive/SKILL.md` (the invocation says the owner names the archived path) and `plugins/ok/families/ok-planner/scripts/review` (`resolved_sprint`'s callers for `stories` and `drives`). Builds on the ledger item.

### Stop discovery from mining archived sprints

The story definition's discovery sources are public surfaces and the README and docs sections that say what the product does for users; the clause naming archived sprints goes. Makes true `decision:corpus-audit-hands-a-discovery-to-planning` and `decision:archive-read-by-nothing`. Carries `true-up-check-reads-archived-sprints`. Changes `plugins/ok/families/ok-planner/skills/_shared/artifact-definitions.md` (`{{STORY-DEFINITION}}`).

### Name the closed-issue file in every skill and the administration

Every text that names the closed issues' store names `.ok-planner/closed-issues.jsonl`: the `--files` lists, the staging lines, and the hand-edit bans in `/triage-issues` and its prompts, `/converge` and its owner list, `/drive`, and `/plan-sprint`; the intake paragraphs of `{{ISSUE-DEFINITION}}`, `{{ISSUE-FILE-FORMAT}}`, and the intake's verbs in the artifact definitions; the compliance reviewer's out-of-scope list; and the intake section of the administration document. Markdown issue files under `history/issues/` stay named as an earlier layout's records. Makes true `decision:closed-issues-leave-the-live-file`. Carries `true-up-check-reads-archived-sprints`. Changes `plugins/ok/families/ok-planner/skills/triage-issues/SKILL.md`, `plugins/ok/families/ok-planner/skills/triage-issues/prompts/{triage,author,respond,clarity,links}.md`, `plugins/ok/families/ok-planner/skills/converge/SKILL.md`, `plugins/ok/families/ok-planner/skills/converge/prompts/owner-list.md`, `plugins/ok/families/ok-planner/skills/drive/SKILL.md`, `plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md`, `plugins/ok/families/ok-planner/skills/_shared/artifact-definitions.md`, `plugins/ok/families/ok-planner/skills/_shared/design-doc-compliance-reviewer.md`, and `plugins/ok/families/ok-planner/admin/ADMINISTRATION.md`. Builds on the item that moves the closed-issue file.

### Describe the write-only archive in the estate's rules text

The estate note, the planner cheatsheet, the family's development note, and the conduct output style say that no tool or agent reads `history/` on its own, save true-up's one migration of an earlier release's bookkeeping, that an agent reads an archived record when the owner directs it and never to learn the project's current state, that each archive step writes the bookkeeping first and picks its archive names from the ledger, and where the bookkeeping lives: the closed-record ledger, the closed-issue file, and the test-plan folder. They say that a sprint's close is recorded in the ledger, that the reconcile step reads an earlier release's test sprint's commit from the ledger, and that `/plan-docs` reads closing commits for intent. Makes true `decision:archive-read-by-nothing`, `decision:records-stay-out-of-context`, and `decision:closing-commit-baseline`. Carries `true-up-check-reads-archived-sprints`. Changes `plugins/ok/families/ok-planner/scripts/ok-planner-CLAUDE.md`, `plugins/ok/families/ok-planner/scripts/ok-planner-cheatsheet.md`, `plugins/ok/families/ok-planner/CLAUDE.md`, and `plugins/ok-conduct/output-styles/ok-conduct.md`.

### Drop the folder finding from the true-up check

The front door's check after a true-up no longer reads `## Paths outside the project root` in any sprint and drafts no folder into `folders`: the table row and the paragraph on a folder finding go. `folders` changes only by the owner's word, save true-up writing the estate root alone into a project that declares no list. Makes true `decision:project-declares-its-folders`, `story:project-spans-folders`, and `story:true-up-project-estate`. Carries `true-up-check-reads-archived-sprints`. Changes `plugins/ok/families/ok-planner/admin/ADMINISTRATION.md` ("Check the project against the carried version").

### Migrate the archive's bookkeeping at true-up

True-up writes the bookkeeping an earlier release kept in the archive into the live bookkeeping files, once, as plan steps that move or write to a live path (`DRIFT:` steps, with no consent of their own): it moves `.ok-planner/history/issues.jsonl` to `.ok-planner/closed-issues.jsonl` before every intake conversion, so the pre-v9 event-log conversion reads the new path, and stops naming both files where both exist; where `.ok-planner/closed-records.jsonl` is absent, it writes one entry, through the carried review tool's writer, for each sprint under `history/sprints/`, documentation sprint under `history/doc-sprints/`, and test sprint under `history/test-sprints/` (a `.md` file that is no companion of another's stem), with the `closed:` stamp its frontmatter carries, and one for each file under `history/sketches/`, ordering entries by commit ancestry, then by name; it writes one `archived` entry for each other file the archive already holds, so later archive steps pick free names from the ledger; and it moves each `-plan.json` beside an archived sprint or test sprint that the ledger lists with a commit into `.ok-planner/test-plans/`, leaving a plan whose name is taken where it is and saying so in a report line. The markdown intake conversion's check of a promoted record's sprint reads `.ok-planner/sprints/` and the ledger the plan writes. The callers sweep skips the three bookkeeping paths as records. After the migration no step of true-up reads a file under `.ok-planner/history/`. The administration document describes each step. Makes true `decision:archive-read-by-nothing`, `decision:skills-read-only-the-current-layout`, and `story:true-up-project-estate`. Carries `true-up-check-reads-archived-sprints`. Changes `plugins/ok/families/ok-planner/admin/true-up` and `plugins/ok/families/ok-planner/admin/ADMINISTRATION.md`. Builds on the items that move the closed-issue file, keep the ledger, and read plans from the test-plan folder.

### Pick archive names from the ledger and retire the every-run archive moves

Every true-up step that moves a file into `.ok-planner/history/` picks the name it moves the file to from the closed-record ledger and the names its own plan takes, never by probing the archive's paths: `archive_path` and the discovery-notes archive step stop calling `free_path` against the paths under `history/`, and take the first name that no `archived` entry and no name the plan takes holds; the markdown intake conversion's check for a taken name under `history/issues/` reads the same entries. The plan step that moves a file into the archive records its `archived` entry through the carried review tool's writer. True-up no longer moves `history/backlogs` or `history/specs` into `history/sprints` on every run: both leave `MIGRATION_DIRS`, `migration_moves`, and each check that reads them, and an archive that still holds either folder keeps it as an earlier release's records. The moves of the live `backlogs` and `specs` folders stay. After this change no true-up step but the migration reads a path under `.ok-planner/history/`. The administration document describes the name rule. Makes true `decision:archive-read-by-nothing`, `decision:closing-commit-baseline`, and `decision:skills-read-only-the-current-layout`. Carries `true-up-check-reads-archived-sprints`. Changes `plugins/ok/families/ok-planner/admin/true-up` (`free_path`, `archive_path`, the discovery-notes archive step, `MIGRATION_DIRS`, `migration_moves`, and the markdown intake conversion) and `plugins/ok/families/ok-planner/admin/ADMINISTRATION.md`. Builds on the ledger item and "Migrate the archive's bookkeeping at true-up".

### Add the run-time cost rule to the coding rules

An agent that writes or fixes code weighs what the design costs at run time as it weighs failure paths, and designs away plainly wasteful work. The coding rules at `plugins/ok/families/ok-planner/docs/plumbline-coding.md` gain one numbered rule after the last, in the shape of its siblings (a `Prevents:` line, numbered steps, and the evidence the task note carries). The rule names the wasteful patterns: a remote call per row of a listing where one call per request or a value stored at write time serves; reading data the page or reply never shows; recomputing a rarely changing answer on every request; and polling on a timer where an event or a change marker exists. It keeps the plainer design wherever a faster one costs clarity, and the task note names each wasteful pattern the change kept, with why. The cheatsheet at `plugins/ok/families/ok-planner/docs/plumbline-cheatsheet.md` gains one ambient line for the rule. No accept-list entry is added: review reaches the rule through accept-list entry A8, so a site the rule leaves one compliant form for is a defect, and a site where several compliant fixes remain is a question for the owner. Carries `plainly-wasteful-work-rule`.

### Write a headless browser server from `/setup-web`

`/setup-web` writes two browser servers into a project's `.mcp.json` by default: the headed `chrome-devtools` server as it stands, and a `chrome-devtools-headless` server that runs `chrome-devtools-mcp` with `--headless --isolated` and no other flag. Each entry follows the same merge rules: add it where its key is missing, leave it where it matches, and show both versions where the owner's entry differs. The skill's report says to use the headless server for unattended work and for a second session in the same project, and the headed server where the owner needs to watch the browser or log in. Project-specific Chrome arguments, such as host-resolver rules, stay with each project. Changes `plugins/ok-web/skills/setup-web/SKILL.md`. Carries `setup-web-headless-server`.

### State the product-slow condition in the speed and verify prompts

The test-speed and test-verify prompts describe a product-slow verdict the way `decision:product-slow-fixes-ride-a-round-that-runs-anyway` and the shared sprint text do: the fix loop files a `perf:` fixer for the site only beside another failure of the latest whole-suite round, and a verdict with no such failure beside it goes to the intake for the next sprint. Changes `plugins/ok/families/ok-planner/skills/converge/prompts/test-speed.md` (the Record section) and `plugins/ok/families/ok-planner/skills/converge/prompts/test-verify.md` (the product-slow paragraph). Makes true `decision:product-slow-fixes-ride-a-round-that-runs-anyway`. Carries `speed-prompts-file-perf-fixer-unconditionally`.

### Accept a boundary-question decline in the verifier prompt

The `/converge` verifier accepts a decline whose fix must change a behavior a user across a release boundary observes, where no ruling allows it and the fixer recorded the question, as the fixer prompt and the owner list already treat it. Such a decline is no longer sent back until the defect sticks; the owner list turns its issue into a judgment issue. Changes `plugins/ok/families/ok-planner/skills/converge/prompts/verify.md` ("Check each defect"). Makes true `story:find-and-fix-defects` and `decision:converge-finds-then-fixes`. Carries `verify-refuses-boundary-question-declines`.

## Tests

off

## Implementation notes

Planned against commit `5743a8aeb81ed20691cc03e1aa7efc5009a52fc2`.


Shared design every item below builds on (item 1 lands it):

- A lock is `{"name": <slug>, "mode": "exclusive" | "shared"}`; a declaration is a list of locks, no name twice.
- The scenario list gains two top-level keys: `lock_list`, `[{"name", "guards"}]` sorted by name, and `test_support_locks`, `{<test support path>: [<lock>, ...]}`. Each scenario records its own `locks` (never its test support's).
- One `locks` item pool in a sprint's run or certification ledger: `--key <path or scenario id> --field path=<test support file>` (a test support task's record) or `--field scenario=<id>` (the flaky fixer's record, which the "Route a flaky test" item adds), `--field 'locks=[...]'`, body the evidence. No `item_states` entry is needed: the tracker accepts any state on an undeclared pool.
- A test's effective locks are the union of its own locks and the locks of every test support file it lists, a name held `exclusive` where either declares it so. `{tests}`, the run locks, the round header, the lock check, the window, and the ranking all read effective locks.

All paths below are under `plugins/ok/families/ok-planner/` unless they start with another root. Line numbers are at commit 5743a8a. Every site below is a source file; the copies under `.claude/` and `.ok-planner/` change only when true-up runs.


Staging facts that bind several items:

- `scripts/review` is the ledger's home, and `scripts/tests` and `scripts/docs` load it with `load_sibling("review")`. `review.ARCHIVED_SPRINTS` has users in `scripts/tests` (lines 765, 1324-1325, 5277-5279). `review.sprints_closed_since` has one caller, `scripts/docs::window_entry` (line 410), and `scripts/docs::cmd_window` prints its entries (lines 466-467). `review.with_closed_stamp` has one caller, `scripts/docs::cmd_stamp` (line 929). `review.closed_stamp` has callers in `scripts/tests::archived_plans`, `scripts/docs::cmd_complete`, and `scripts/review` itself. A stage that removes or reshapes one of these symbols edits every caller in the same stage, or leaves the symbol in place until the stage that removes its last caller. The plan below does the second: the ledger stage adds the ledger and leaves `ARCHIVED_SPRINTS` and `with_closed_stamp` standing; the tests stage and the docs stage each remove the last users, and the stage that lands second removes the symbol.
- `scripts/review` is also changed by "Give every driver a scratch folder" (`cmd_drives`), "Sprint certification fixes the defect issues its sprint lists" (`cmd_backlog`), "The completion contract checks that certification took up every listed defect issue" (`cmd_certified`), and both citation items. `scripts/tests` is changed by nearly every testing item. `skills/plan-sprint/sprint-document.md` and `admin/retired-boilerplate.json` are changed by four other items. `skills/plan-sprint/SKILL.md` is changed by three other items. `skills/converge/prompts/owner-list.md` is changed by two other items. `skills/_sprint/shared.md` is changed by four other items. Stages that share a file chain with `--after`.
- `.ok-planner/review/project.md` describes `review`, `issues`, and `tests` verbs this group changes. Its own header says a build that changes a script input updates it in the same stage, so each stage below lists the lines it rewrites there.


Cross-group needs. Several items below call definitions another group builds. Each need is stated once here, and each item cites it by letter.

- **(L) The closed-record ledger group ("Keep the closed-record ledger in the review tool", `scripts/review`).** True-up loads the carried review tool (`admin/true-up::carried_review`) and needs four things from it. (L1) A reader, such as `closed_records(root)`, that returns the entries in the order they were written, `[]` where `.ok-planner/closed-records.jsonl` is absent, and refuses a malformed line by naming the file. (L2) A writer, such as `append_closed_records(root, entries)`, that appends several entries in one atomic replace under one lock and refuses a `(kind, name)` pair the ledger already lists. The writer must not run the `review close` verb's CLI-only checks, a commit on the current branch and a file in its live folder: the migration records sprints that already sit in the archive, and their stamps may name commits off the current branch. (L3) `closed_stamp` and `is_ancestor` stay importable, because the migration reads each archived sprint's `closed:` stamp once. (L4) The ledger's path is a module constant true-up imports. `review closed [--kind <kind>] [--json]` must read only the ledger, never `.ok-planner/review/config.json`, and print no entries where the ledger is absent, so `/sketch` works in any trued-up project. `--json` prints `kind`, `name`, and `commit`.
- **(C) The closed-issue file group ("Move the closed-issue file out of the archive", `scripts/issues`).** The closed-issue file's path is a module constant true-up imports through `carried_intake()`. `locked(root)` stays. `import --over-event-log` and `import --over-archived-event-log` write and read the closed-issue file.
- **(T) The test-plan group ("Read earlier test plans from the test-plan folder", `scripts/tests`).** The test-plan folder's path, `.ok-planner/test-plans/`, is a module constant true-up imports through `carried_module(TESTS_SRC)`. The plan file name is `<sprint stem>-plan.json`. The locks group's `convert-state` rewrites live sprints' plans only, so it leaves the plans this migration moves into `test-plans/` as written. Earlier plans are read only for their `calls`.
- **(R) The `record` ownership class (both groups above).** `scripts/review::OWNER_PATHS` lists `.ok-planner/closed-issues.jsonl`, `.ok-planner/closed-records.jsonl`, and `.ok-planner/test-plans/` as `record`. True-up's callers sweep (`admin/true-up::caller_kind`) and the provenance scan skip records through `carried_review().left_alone`, so the sweep skips the three bookkeeping paths with no change in true-up.



### Record locks and the lock list in the scenario list

**Calls**
- The scenario list's new keys are `lock_list` (a list of `{name, guards}`) and `test_support_locks` (a map of path to locks), and each scenario's key is `locks`. Decided by: `decision:locks-named-from-a-project-list` and `decision:scenario-list-decided-once` (the list holds the lock list and each test support file's locks); a top-level name other than `locks` keeps it apart from a scenario's own `locks`.
- One `locks` pool serves both a test support file's record (`path` field) and a fixer's record for a test (`scenario` field), with one reader, `locks_items`. Decided by: plumbline "one idiom per job"; the "Route a flaky test through its round's window" item, planned by another group, records its `locks` items through the same reader and shares `scripts/tests`.
- Precedence for a test's own locks, in the order `live_tests` applies them: the plan's (or the scenario list's for a kept test); a `tests` item's `locks`, where it records one, replaces them (as a `tests` item's `resources` replaced the plan's); each `locks` item keyed by the scenario adds its names. A test support file's locks: the scenario list's `test_support_locks`, then the latest `locks` item for that path across the sprint's run and then its certification ledger replaces them. Decided by: the work item ("a test takes the locks of every test support file it lists") and the existing rule that a `tests` item's declaration replaces the plan's.
- `read_state` refuses a scenario list in the earlier form, any scenario that records `resources` or `reads`, or a list with no `lock_list` key, naming `/ok` and `tests convert-state`, in the shape of its refusal of the earlier `support` field. `written_plan` refuses a plan scenario that records `resources` or `reads` the same way. A file that does not exist still reads as an empty list with `lock_list` `[]`. Decided by: the work item ("nothing in the tool reads ... `resources`, `reads`") and plumbline-coding rule 2 (the sibling refusal of `support`). The converter, `cmd_convert_state`, is the one reader of the earlier keys, as `decision:locks-grow-from-observed-failures` says ("save true-up's one conversion").
- `tests plan` refuses a planner `scenarios` item that records `resources` or `reads`, naming the item and its task and saying to refile that planner task. Decided by: the work item (no tool reads them) and the plan assembly's existing refusal shape for a malformed item.
- The refusal of an undeclared name reads: `test <scenario or path> declares the lock <name>, which the lock list does not hold: read .ok-planner/bin/tests locks, and add it with .ok-planner/bin/tests locks add <name> --guards "<the shared thing it guards>" only where no listed name fits`; a bad mode reads `... declares the lock <name> in mode <mode>, which is neither exclusive nor shared`. One function, `lock_refusals`, writes both, and plan assembly, `run`, `tasks` (every stage, over the plan's scenarios and the live tests), and `stamp` call it. Decided by: the work item's wording.
- `tests locks remove <name>` refuses while a scenario of the scenario list, an entry of `test_support_locks`, or a scenario of any `-plan.json` beside a sprint under `.ok-planner/sprints/` declares the name. It does not search run logs: a `locks` or `tests` item that still names a removed name meets the refusal above, which names `tests locks add`. Decided by: the work item ("refusing while a live test or a test support file declares it"); the plans are where a live sprint's tests are declared before the stamp.
- Every writer of `.ok-planner/test-state.json` takes one lock, `.ok-planner/.cache/tests-state.lock` (`fcntl.flock`, exclusive), reads the list inside it, and replaces the file atomically through `write_replacing`: `tests locks add`, `tests locks remove`, `convert-state`, `budget`, `stamp`, and `rules take`. Decided by: the work item ("each writes the scenario list under one lock by atomic replace"), plumbline-coding rule 3 (a lock guards a shared field only where every writer takes it; the value written is read inside the lock), and the sibling `results_lock`.
- `tests scenarios` (plain form) adds each scenario's locks to its line, and prints the lock list after the stamps. Decided by: the plain listing already prints each scenario's test; the JSON form prints the whole file.
- A stamp keeps a `test_support_locks` entry only for a path some stamped scenario lists as test support. Decided by: `tests locks remove` must not stay refused by a file no test uses.
- Shares `scripts/tests` with every other item of this group, with the flaky route and `cmd_reached` items, and with "Move each decision citation", "Read earlier test plans from the test-plan folder" (other groups). Each new function this item writes carries the citation of the decision it enforces: `@decision: locks-named-from-a-project-list` on the lock list verbs and `lock_refusals`; `@decision: tests-isolated-unless-declared` on the declaration readers. Decided by: the "Move each decision citation" item ("New sites the other items add cite their own decisions").

**Changes**
- `scripts/tests::USAGE`: changed. States the lock model in place of `resources`, `reads`, and the implied read: the `locks` declaration and its two modes, the lock list and `test_support_locks`, the `locks` pool with its `path` and `scenario` fields, the union with test support locks, the `tests locks` verbs, and each verb's refusal of an undeclared name or mode. The closing paragraph on the scenario list says the same.
- `scripts/tests::LOCK_MODES` (`("exclusive", "shared")`), `LOCK_LIST`, `TEST_SUPPORT_LOCKS`, `LOCKS_POOL`, `STATE_LOCK`: new constants.
- `scripts/tests::read_state`: changed. Defaults `lock_list` `[]` and `test_support_locks` `{}` for a missing file; validates `lock_list` (each `{name: slug, guards: non-empty text}`, no name twice) and `test_support_locks` (each value a held declaration); refuses the earlier form as the Calls say.
- `scripts/tests::state_lock`: new. A context manager over `.cache/tests-state.lock`, in the shape of `results_lock`.
- `scripts/tests::written_plan`: changed. Refuses a plan scenario that records `resources` or `reads`.
- `scripts/tests::locks_held` (shape check), `declared_locks(*records)` (the first record that holds a `locks` list), `merged_locks(*declarations)` (union, exclusive wins, sorted by name), `lock_refusals(state, named)` (each test or path with each undeclared name or bad mode): new.
- `scripts/tests::locks_items(root, runs)`: new. Reads the `locks` pool of each run in order, returns the latest declaration per `path` and per `scenario`.
- `scripts/tests::declared_resources`, `declared_reads`, `shared_resources`, `effective_reads`, `planned_declaration`: removed (I1).
- `scripts/tests::scenario_of`: changed. Reads `locks` from a planner item in place of `resources` and `reads`.
- `scripts/tests::assembled_plan`: changed. Refuses a `scenarios` item that records `resources` or `reads`.
- `scripts/tests::plan_failures`: changed. The two `resources`/`reads` shape checks become one `locks` check (a list of `{name, mode}`, name a slug, mode one of the two, no name twice), and it adds `lock_refusals` against the scenario list's `lock_list` for each scenario that is not retired or a gap.
- `scripts/tests::print_summary`: changed. "Shared resources declared" becomes "Locks declared": each name with each holder and its mode, "None: every planned test is isolated." where none.
- `scripts/tests::print_plan`: changed. Each scenario line carries `; locks: <name> (<mode>), ...` in place of `; resources: ...`.
- `scripts/tests::recorded_declarations`: changed. Takes a `tests` item's `locks` where it records a list.
- `scripts/tests::live_tests`: changed. Each entry carries `locks` (its own, by the precedence in Calls) and `support_locks` (the merged locks of its test support files), and `effective_locks` (the union). Without a sprint it reads the scenario list alone; with one it overlays `locks_items` of `record_runs`.
- `scripts/tests::scenario_brief`: changed. Says "Locks it holds: <name> (<mode>), ..." and, where its test support declares any, "Locks its test support declares: ...", or "It holds no lock, so it is isolated."; the three resource sentences go.
- `scripts/tests::test_support_brief`: changed. Names the locks the scenario list or the latest `locks` item records for the file, and says the task records the locks the file's code shows as a `locks` item keyed by the path.
- `scripts/tests::declaration_changes`, `declarations_text`: changed. Compare and print `locks` before and after, with each name added and its mode.
- `scripts/tests::speed_brief`: changed. Passes the entry's `locks` to `scenario_brief`.
- `scripts/tests::cmd_tasks`: changed. Runs `lock_refusals` over the plan's scenarios and the live tests before any stage files a task.
- `scripts/tests::stamped_test`, `gap_scenario`: changed. Write and drop `locks` in place of `resources` and `reads`.
- `scripts/tests::cmd_stamp`: changed. Reads and writes the list inside `state_lock`; records each scenario's own `locks`, carries `lock_list`, writes `test_support_locks` from the scenario list overlaid by the sprint's `locks` items keyed by path, kept for paths a stamped scenario lists; runs `lock_refusals` before it writes.
- `scripts/tests::cmd_budget`, `take_rule`: changed. Read and write the list inside `state_lock`.
- `scripts/tests::cmd_locks`: new. `tests locks [--json]` prints each name with its guards line; `tests locks add <name> --guards "<line>"` refuses a name that is not a slug, a name already listed, and an empty line; `tests locks remove <name>` refuses a name the list does not hold and one still declared, as Calls say. Each write runs inside `state_lock` and prints the name it added or removed.
- `scripts/tests::build_parser`, `main`: changed. Add the `locks` verb with `add` and `remove` subverbs, in the shape of `rules take`; `--json` goes with the listing alone.
- `scripts/tests::cmd_scenarios`: changed. As Calls say.
- `.ok-planner/review/project.md` (`## Scripts for developers and operators`, the `scripts/tests` line): changed. Lists the `locks` verb and its refusals, and says each verb that reads a declaration refuses an undeclared name or mode and the earlier `resources`/`reads` form.

**Improvements**
- **I1** `scripts/tests::declared_resources`, `declared_reads`, `planned_declaration`, `effective_reads`, `shared_resources`: one declaration read three ways (live tests, briefs, verify), each of which this change rewrites. Afterward: `declared_locks` and `merged_locks` are the one reader every site calls, so a later change to the declaration edits one function.

**Behavior changes**
- **B1** `scripts/tests::read_state`, `cmd_stamp` (the scenario list). Before: each scenario records `resources` and `reads`, a scenario with `resources` and no `reads` reads every resource, and the list holds no lock list. After: each scenario records `locks`; the list holds `lock_list` and `test_support_locks`; a list in the earlier form is refused, naming `/ok` and `tests convert-state`. Users: in the release: every verb of `scripts/tests`; the budget prompt, the preflight, and `/ok-setup`'s runner check, which read `tests scenarios --json` (changed by item 9 and by other groups' items). Across stored state: each project's committed `.ok-planner/test-state.json`. Ruling: migrate: true-up's plan converts the list through `tests convert-state` (item 7), each `resources` slug held `exclusive` and each `reads` dropped, and the tool refuses an unconverted list with the step that converts it (call; decided by `decision:locks-grow-from-observed-failures` and `decision:live-sprints-brought-current-on-true-up`).
- **B2** `scripts/tests::assembled_plan`, `scenario_of`, `plan_failures`, `written_plan` (the plan). Before: planner items and the plan record `resources` and `reads`. After: they record `locks`; a planner item or a plan scenario with `resources` or `reads` is refused. Users: in the release: the story and runtime planner prompts and the planner reviews (changed by "Have writers declare only the locks their tests show"). Across stored state: an open sprint's `-plan.json`, and an open test planning run's `scenarios` items. Ruling: migrate: true-up's conversion rewrites each open sprint's `-plan.json` (item 7); an open planning run's `scenarios` item that records `resources` or `reads` is refused with the step that re-records it, a refile of its planner task under the new prompt (call; decided by the work item, which reads no `resources`, and the plan assembly's refusal shape).
- **B3** `scripts/tests::live_tests`, `recorded_declarations` (a `tests` item's declaration). Before: a `tests` item's `resources` and `reads` replace the plan's. After: its `locks` replace the plan's, and its `resources` and `reads` are not read. Users: in the release: the test writer prompt (changed by the writers item). Across stored state: an open sprint's run and certification ledger, whose `tests` items an earlier release's test tasks recorded. Ruling: migrate: the conversion (item 7) folds each such scenario's latest `tests` item's `resources` into the converted plan's `locks`, held `exclusive`, so the writer's declaration stands (call; decided by `decision:locks-grow-from-observed-failures`).
- **B4** `scripts/tests::scenario_brief`, `test_support_brief`, `declarations_text`, `declaration_changes`, `speed_brief` (task briefs). Before: briefs name resources it changes and reads. After: they name the locks it holds and its test support's locks. Users: in the release: the test support, test writer, test verifier, and speed prompts (changed by other groups). Ruling: rewrite.
- **B5** `scripts/tests::print_summary`, `print_plan` (`tests plan --show`). Before: "Shared resources declared" and `; resources:`. After: "Locks declared" and `; locks:`. Users: in the release: the test planning procedure and the plan-wide review in `skills/plan-sprint/tests.md`, which read `--show`. Ruling: rewrite.
- **B6** `scripts/tests::cmd_budget`, `take_rule`, `cmd_stamp`, `cmd_convert_state` (writes of the scenario list). Before: each reads and writes with no lock. After: each waits for `tests-state.lock`. Users: in the release: `/ok-setup`, the archive step, `/plan-sprint`'s rules walk; none observes more than a short wait. Ruling: rewrite.

**New surface**
- `tests locks`, `tests locks add <name> --guards`, `tests locks remove <name>`, declared in `scripts/tests::build_parser`: internal.
- The `locks` item pool and its `path`/`scenario` fields, read by `scripts/tests::locks_items`: internal.

**Tested stories**
- None.

**Runtime parts**
- None.

### Hand the suite command each test's locks in a new random order

**Calls**
- The `run: seed <n>, <w> workers from ...` line goes to stderr, as the lock wait line in `scripts/tests::resource_locks` does, so `tests run --json` keeps printing only the JSON on stdout; the seed reaches a JSON reader through the round header. B10's users also include the readers of `tests run --json`: the preflight's line-timing check (`skills/converge/prompts/test-preflight.md` check 5), `/ok-setup`'s runner check 1, and the `--workers 2 --json` runs of "Check the suite command against the locks before a round". Decided by: the notes review (stdout parsing) and the sibling wait line.
- The key per test is the first 16 hex digits of `sha256("<seed>:<scenario id>")`, ordered as text; a seed is a whole number from 0 to 2^32 − 1, drawn with `secrets.randbelow`. A `--from` entry with no scenario keys on its locator, as its result is labelled now. Decided by: `decision:tests-run-in-a-new-random-order` (a key per test from the seed and the scenario id, so any subset keeps its relative order); the range is a data format, not a setting.
- `tests run --seed <n>` refuses a value below 0 or above 2^32 − 1. Decided by: plumbline-coding rule 7 (a bound the input needs).
- The round header records `seed`; every run, recorded or not, prints one line before setup starts: `run: seed <n>, <w> workers from <the flag | the machine record | the budget>`. Decided by: plumbline-coding rule 15 (a long-running command prints as it works) and rule 12 (the seed a fixer replays must show).
- The `{tests}` file's `locks` per test are its effective locks (own and test support), so the suite command keeps apart exactly the pairs the lock check (item 3) checks. Decided by: `decision:tests-isolated-unless-declared` (a test takes its test support's locks).
- The run's lock registry entry under `.cache/tests-runs/<pid>.json` records `locks` (name to mode) in place of `resources`; a lock file is `.cache/tests-lock-<name>.lock`. The wait line reads `tests: waiting to take the lock <name> <exclusive | shared>, which <run> holds`. An entry an earlier release's run left reads as holding no lock. Decided by: `decision:runs-lock-what-their-tests-declare`; cache files carry no state across a release beyond a running run's life.
- A run's lock on a name is exclusive where one of its tests holds the name exclusive, shared otherwise. Decided by: `decision:runs-lock-what-their-tests-declare`.
- Shares `scripts/tests::cmd_run`, `tested_round`, and `recorded_round` with item 8 (the worker count) and with the flaky route item (which passes `--seed` and `--workers`).

**Changes**
- `scripts/tests::USAGE` (`tests run`): changed. `{tests}` is `{"workers": <n>, "seed": <seed>, "tests": [{"path", "name", "locks": [{"name", "mode"}]}]}`, listed in the order of each test's key under the run's seed; `--seed <n>` replays a seed's order over any subset; the suite command starts the tests in the listed order and starts a test only once it holds every lock the test declares; the run's locks by name; the header's `seed`.
- `scripts/tests::run_order(targets, seed)`: new. Sorts targets by their key under the seed. `@decision: tests-run-in-a-new-random-order`.
- `scripts/tests::run_suite`: changed. Takes the seed, writes the `{tests}` file in the new shape from each target's `locks`.
- `scripts/tests::lock_modes`: changed. Builds name to mode from each target's `locks`; its slug refusal goes, since `lock_refusals` has already refused an undeclared name.
- `scripts/tests::resource_locks`: renamed `run_locks`, changed. Takes each name in name order with `LOCK_EX` or `LOCK_SH` by mode, registers `locks`, and names a holder only where the holder or this run holds the name exclusive. `@decision: runs-lock-what-their-tests-declare`.
- `scripts/tests::run_targets`, `live_targets`: changed. Each target carries `locks`, its effective locks, in place of `resources` and `reads`; a `--from` entry takes its optional `locks`.
- `scripts/tests::cmd_run`: changed. Draws or takes the seed, orders the targets, runs `lock_refusals` over the targets, and passes the seed on.
- `scripts/tests::tested_round`, `recorded_round`: changed. The planned targets record `locks`; the header records `seed`; the run prints its seed and worker line.
- `scripts/tests::suite_outcome`: changed (I2). An unrunnable or setup-failed target's result is built by one helper that keeps `scenario`, `path`, and `name`.
- `scripts/tests::build_parser`, `main`: changed. `run --seed` (`type=int`), with the range refusal.
- `.ok-planner/review/project.md` (the `scripts/tests` line): changed. The `{tests}` shape, `--seed`, the listed order, and the run's locks by name.

**Improvements**
- **I2** `scripts/tests::suite_outcome`: the same four `pop` calls stand twice, one copy per failure branch, and this change must edit both for `locks`. Afterward: one helper, `unran_result(target, tail)`, builds both results from the target's `scenario`, `path`, and `name`.

**Behavior changes**
- **B7** `scripts/tests::run_suite` (the `{tests}` file the suite command reads). Before: `{"workers", "tests": [{"path", "name", "resources", "reads"}]}`, tests in scenario-id order, an implied read of every resource filled in. After: `{"workers", "seed", "tests": [{"path", "name", "locks"}]}`, tests in the seed's order, and the suite command must start them in that order, each only once it holds its locks. Users: in the release: none in the tree. Across stored state: each consumer project's suite command, the script `testing.run` names in its committed `.ok-planner/config.json`, which the project owns and true-up never edits; a command that reads `resources` or `reads` fails every test of every round once true-up lands the new tool. Ruling: rewrite across stored state: true-up files the `testing-suite-command-locks` issue telling the owner to update the suite command, and the next preflight catches a command not yet updated (owner).
- **B8** `scripts/tests::run_locks`, `lock_modes` (the locks a run holds across runs). Before: an exclusive lock per changed resource, a shared lock per read resource, the implied reads included. After: one lock per declared name, exclusive where any test of the run holds it exclusive; no implied read. Users: in the release: every concurrent `tests run`, a fixer's rerun beside a round among them. Ruling: rewrite.
- **B9** `scripts/tests::recorded_round` (the round header in `-results.jsonl`). Before: header `workers`, planned targets with `resources` and `reads`. After: header `seed`, `workers`, `workers_from`; planned targets with `locks`. Users: in the release: `results_rounds` and its readers, the lock check, the window, and the ranking. Across stored state: an open sprint's `-results.jsonl`, whose earlier rounds carry `resources` and `reads`. Ruling: migrate: a round whose planned targets carry no `locks` reads as an earlier release's round, which the lock check and the window treat as holding no lock and the ranking ranks with the live tests' effective locks and the plan's budget workers, as it ranks such a round now (call; decided by `decision:round-failure-cleared-by-a-later-round`, which lets a later round clear it).
- **B10** `scripts/tests::tested_round` (printed output). Before: results, counts, then the slowest. After: one `run: seed ..., workers from ...` line first. Users: in the release: the agents and `exec` tasks that read `tests run`'s output. Ruling: rewrite.

**New surface**
- `tests run --seed <n>`, declared in `scripts/tests::build_parser`: internal.

**Tested stories**
- None.

**Runtime parts**
- None.

### Check each round against the locks

**Calls**
- One `locks--<a>--<b>` entry per pair of tests that overlapped on one clock, the pair ordered by scenario id; its tail lists every lock name the two hold with at least one exclusive, each with both modes, then both spans and the clock. Its `locks` field holds `[a, b]` in place of `schedule`. Decided by: `decision:rounds-checked-against-the-locks`; one entry per pair keeps the confirm rerun (`--only a b`) one task.
- `LOCKS_PREFIX` is `locks--`; `SCHEDULE_BREACH` is renamed `LOCK_BREACH` and stays `T4`. Decided by: the work item.
- The check reads the planned targets' `locks` from the round's header, never the live declarations, so a later lock added by a fixer does not turn an old round into a breach. Decided by: `decision:rounds-checked-against-the-locks` ("the locks its tests hold").
- `/converge` SKILL.md step 5's vocabulary line ("A T4 defect, a schedule breach") changes with the steps the item names, since it names the same entry. Decided by: plumbline-coding rule 1 (edit every site that restates a definition).
- Shares `skills/converge/SKILL.md` with "Sprint certification fixes the defect issues its sprint lists" and "Name the closed-issue file" (other groups), `skills/converge/prompts/merge.md` with the former, and `skills/_sprint/shared.md` with the writers, starting-state, and archive items. Each edit here touches only the T4 row and the lines naming `schedule--`.

**Changes**
- `scripts/tests::USAGE` (`tests failures`, `tests reports`, `tests tasks --stage speed`): changed. `locks--<test>--<test>` for each pair that ran at the same time holding one name, one of them exclusive, on every round that records arrival times; T4 a lock breach; a round whose only failures are lock breaches or a failed setup files no speed task.
- `scripts/tests::lock_failures(entry)`: new, replacing `schedule_failures`. Pairs from `overlapping_pairs` on the command clock where both lines carry `started` and `ended`, and by arrival otherwise; a pair fails where `shared_names(a, b)` holds a name one of them holds exclusive. `@decision: rounds-checked-against-the-locks`.
- `scripts/tests::held_groups`, `forbidden_pair`, `schedule_failures`, `recorded_schedule`: removed.
- `scripts/tests::entry_failures`, `entry_tests`, `standing_entries`: changed. Take no schedule; a lock breach is cleared only once a later closed round reaches both its tests (`needs_every`), as a schedule pair was.
- `scripts/tests::round_failures`, `unsettled_failures`, `suite_reports`: changed. Call `lock_failures(entry)`; reports file T4 for each.
- `scripts/tests::suite_fault`: changed. A `locks--` entry or a `setup failed` tail.
- `scripts/tests::speed_refusal`: changed. Its text says "a lock breach or a failed setup".
- `skills/_sprint/shared.md` (`{{SPRINT-CATALOG}}`'s T4 row, and the T4 sentence below the table): changed. `T4 | A lock breach | The suite command ran two tests at the same time that hold one lock name, at least one of them exclusive, a locks-- entry. Filed by tests reports. | the two tests; each lock name they share with both modes; each one's start and end, and the clock that gave them; the round`.
- `skills/converge/prompts/merge.md` (the sprint-suite paragraph, the T4 body clause, and the T4 bullet): changed. T4 is a lock breach, its id `locks--<a>--<b>`, its body the two tests and each lock with both modes, and the T4 bullet files the defect at `rewrite` for a test support task that changes how the suite command starts the tests, `files` first naming the suite command's file that starts them.
- `skills/converge/SKILL.md` (step 5's vocabulary line, steps 3a.2, 3a.3, 5a, 6a, and the return's `suite` line): changed. Each `schedule--<a>--<b>` reads `locks--<a>--<b>`, each "schedule breach" or "schedule pair" reads "lock breach", and 5a's item text names "the suite command's file that starts the tests"; 6a's confirm for a `locks--<a>--<b>` defect runs `--only a b`.

**Behavior changes**
- **B11** `scripts/tests::lock_failures`, `entry_failures`, `standing_entries` (`tests failures`, `tests settled`). Before: `schedule--a--b` entries for pairs `testing.schedule`'s form forbids, none while `said` is null. After: `locks--a--b` entries for pairs that share a name with one exclusive, on every round that records arrival times. Users: in the release: `/converge` steps 3a and 6a, `review certified` through `tests settled`, and the fix prompt. Across stored state: earlier rounds of an open sprint's `-results.jsonl` (ruled under B9), and an open ledger's `schedule--` defect, whose confirm no longer finds it listed and so verifies it. Ruling: rewrite.
- **B12** `scripts/tests::suite_reports` (`tests reports`). Before: T4 per `schedule--` entry, with field `schedule`. After: T4 per `locks--` entry, with field `locks`. Users: in the release: the merge prompt and `/converge` steps 5a and 6a. Ruling: rewrite.
- **B13** `scripts/tests::speed_refusal`, `suite_fault` (`tests tasks --stage speed --round`). Before: refuses a round whose only failures are `schedule--` entries or failed setups. After: the same for `locks--` entries. Users: in the release: `/converge` step 3a.2. Ruling: rewrite.
- **B14** `skills/converge/SKILL.md`, `skills/converge/prompts/merge.md`, `skills/_sprint/shared.md` (`/converge sprint`'s steps and its return block). Before: they name schedule breaches. After: lock breaches. Users: in the release: the certification session and its merge agents. Across the public surface: the owner reads the return's `suite` line in session; no program parses it (`review certified` reads only the ledger path under `# Sprint certification`). Ruling: rewrite.

**Tested stories**
- None.

**Runtime parts**
- None.

### Rank the slowest tests by the lock bound

**Calls**
- `lock_bound(seconds, held, workers)` is the larger of all tests' seconds over the workers and, for each name, the exclusive holders' seconds summed plus the larger of the longest shared holder's seconds and the shared holders' total over the workers; a test's cost is the bound less the bound with its seconds at 0, rounded to 3 places as now. Decided by: `decision:ranking-charges-each-test-its-wall-time-cost`, word for word.
- The ranking reads each test's effective locks: the round's planned targets for a round's ranking, the live tests for `--from state`, and the stamped tests (own and test support locks) for the stamp. Decided by: `decision:ranking-charges-each-test-its-wall-time-cost` ("under the tests' locks").
- The printed headers read "by what each costs the round's wall time under the tests' locks (workers: <n>)". Decided by: the work item ("reads no testing.schedule").

**Changes**
- `scripts/tests::USAGE` (`tests run`'s ranking paragraph, `tests slowest`, `tests stamp`): changed. The lock bound in place of the three schedule forms.
- `scripts/tests::lock_bound`: new, replacing `wall_bound`. `@decision: ranking-charges-each-test-its-wall-time-cost`.
- `scripts/tests::ranked_slowest`: changed. Takes `(results, count, workers, declared)`, no form.
- `scripts/tests::speed_ranking`: changed. No form argument.
- `scripts/tests::speed_source`: changed. A round counts as recorded where its header records `workers` and every planned target carries `locks`; otherwise the live tests and the plan's budget workers (B9).
- `scripts/tests::speed_rows`, `speed_brief`, `cmd_slowest`, `tested_round`, `cmd_stamp`: changed. Drop `testing["schedule"]["form"]` and the `form` field; the brief and the headers name the locks.

**Behavior changes**
- **B15** `scripts/tests::ranked_slowest`, `speed_ranking` (`tests run`'s slowest list, `tests slowest`, `tests stamp`'s `ranking`, and so `tests tasks --stage speed`'s batch). Before: costs under `testing.schedule`'s form, from `resources`. After: costs under the lock bound, from locks. Users: in the release: the speed stage and the speed prompt (changed by other groups). Across stored state: the `ranking` rows of `.ok-planner/test-state.json`, whose `cost` every ranking recomputes from the carried seconds, so no row is read as a cost. Ruling: rewrite.

**Tested stories**
- None.

**Runtime parts**
- None.

### Add `tests window`

**Calls**
- Each other test's span is compared with the named test's on one clock per pair, the command's where both lines carry `started` and `ended`, arrival otherwise, as the lock check compares. Decided by: `decision:rounds-checked-against-the-locks` and plumbline-coding rule 3.6 (one clock per comparison).
- Output: one line for the named test (its span, clock, and locks), then the overlapping tests, then the tests that ended before it started, each group ordered by how near its end lies to the named test's start, each line `<scenario> <start>s to <end>s <clock>; shares <name> (<its mode> here, <mode> there)` where it shares a name. `--json` prints the same as `{"test", "overlapped": [...], "before": [...]}`. Decided by: the flaky fixer reads it (the flaky route item); every sibling verb with a printed listing has `--json`.
- It reads no `testing` config and runs under any `testing.enabled`, as `tests failures` does. Decided by: the sibling `cmd_failures`, which reads only the results.
- A round an earlier release recorded (no `locks` on its targets) prints its window and says that round records no locks, so no line is marked. Decided by: B9.
- It refuses a round number the results file does not hold, a test the round did not plan, and a test whose result is `not run`, each naming the round and the results file. Decided by: the work item.

**Changes**
- `scripts/tests::USAGE`: changed. `tests window --sprint <path> --round <n> --test <scenario> [--json]`.
- `scripts/tests::window_lines(entry, sid)`: new. `@decision: flaky-tests-traced-through-the-round-window`.
- `scripts/tests::cmd_window`: new. Writes nothing.
- `scripts/tests::build_parser`: changed. The `window` verb, `--sprint`, `--round` (`type=int`), and `--test` each required.
- `.ok-planner/review/project.md` (the `scripts/tests` line): changed. Lists `window` and its refusals.

**Behavior changes**
- None. Every change is new code no existing user reaches.

**New surface**
- `tests window`, declared in `scripts/tests::build_parser`: internal.

**Tested stories**
- None.

**Runtime parts**
- None.

### Retire `testing.schedule`

**Calls**
- `tests declare --schedule` and `--schedule-said` stay parsed so they can be refused, as `--timeout` is: `--schedule is retired: each round runs under the locks its tests declare (tests locks), and the tool checks each round against them, so no schedule is recorded`. Decided by: the work item and the sibling `--timeout` refusal (plumbline-coding rule 2).
- Every `tests declare` drops `testing.schedule` where the config holds it, as it drops `timeout`. Decided by: the work item.
- The lint's `config-check` reports a config that still holds `testing.schedule` as `testing.schedule is retired: tests run under the locks each test declares; run /ok, which removes it`, rather than as an unknown key. Decided by: the sibling `RETIRED_COMPOSE_CHECK_NAMES` message in `lintChecksDefects`; a message that names `/ok` tells the user what to do. The lint's file runs read only `testing.enabled`, so no lint of a file refuses on it.
- True-up removes the key through a `lint_config_transforms` step, `testing.schedule is retired, and no tool reads it: the tests tool runs each round under the locks its tests declare; true-up removes it`. Decided by: the work item ("as a step of its plan") and the sibling `offers_retired`/`without_runtime_offer` transform.
- An open `testing-schedule-unconfirmed` issue in a project's intake stays open; `ADMINISTRATION.md` says that the next `/triage-issues` answers it, since the tooling now settles it. Decided by: `/triage-issues`'s `answered` route ("the tooling settles it"); true-up closes no issue it did not file this run.
- `/ok-setup` renumbers 3.4 to 3.6 as 3.3 to 3.5 and every reference inside its text (the "Change a setting" line). No other file names those numbers (searched). Decided by: the work item ("drops its schedule step") and plumbline-coding rule 1.
- The budget prompt's mention of `testing.schedule` (Read step 3 and the paragraph on which tests run together) goes in this item's sweep, though `skills/plan-sprint/tests-budget.md` is not in its Changes list; item 9 rewrites the same paragraph to the lock model, and "Keep the session out of scenario field values" (another group) changes the prompt's opening condition. Decided by: plumbline-coding rule 1 ("No tool reads `testing.schedule`" covers every prompt that tells an agent to read it).

**Changes**
- `scripts/tests::TESTING_KEYS`, `SCHEDULE_FORMS`, `SCHEDULE_SHAPE`, `SCHEDULE_PREFIX`, `schedule_held`, `DECLARE`: changed or removed. `schedule` leaves the required keys, the shapes go, and the `DECLARE` hint names no schedule.
- `scripts/tests::testing_config`: changed. Neither requires nor reads `schedule`.
- `scripts/tests::declared_values`, `cmd_declare`: changed. Refuse the two flags; drop the key.
- `scripts/tests::main`: changed. The `--schedule`/`--schedule-said` pairing check goes.
- `scripts/tests::USAGE` (`tests declare`): changed. No schedule; says the flags are refused and the key dropped.
- `scripts/plumbline::TESTING_SCHEDULE_FORMS`, `TESTING_SETTINGS.schedule`, `TESTING_KEYS`, `testingDefects`: changed. `schedule` leaves the keys and settings; `testingDefects` reports it retired, as Calls say.
- `admin/true-up::FORMER_SUITE_SETTINGS`: changed. No `schedule`.
- `admin/true-up::lint_config_transforms`, `schedule_retired`, `without_schedule`: changed and new. The removal transform.
- `admin/true-up::schedule_issue`: removed. `testing_key_issues`: changed, files `testing-reaches-unconfirmed` alone.
- `admin/ADMINISTRATION.md` (the `testing` key row of the drift table; "Declare the lint config"'s former values and its `said` sentence; the `config-check` paragraph's list of `testing` keys; "The testing keys" bullet and its `testing-schedule-unconfirmed` sub-bullet; the owned-set line naming "each guessed `testing.schedule`"): changed. No schedule; a new sentence says true-up removes `testing.schedule` and that an open `testing-schedule-unconfirmed` issue is the next `/triage-issues`' to answer.
- `skills/ok-setup/SKILL.md` (section 2's "Change a setting"; 3.2's `run` paragraph; 3.3, removed; 3.4 to 3.7, renumbered; section 4): changed. 3.2 describes `{tests}` as `{"workers": <n>, "seed": <seed>, "tests": [{"path", "name", "locks": [{"name", "mode"}]}]}`, says the suite command starts the tests in the listed order and each only once it holds its locks, and says the lock check compares two tests on the command's clock where both lines carry `started` and `ended`; section 4 names only `testing-reaches-unconfirmed`.
- `skills/plan-sprint/tests-budget.md` (Read step 3): changed. Reads `testing.run` alone.
- `.ok-planner/review/project.md` (the `scripts/tests` line): changed. `declare` takes no schedule, refuses both flags, and drops the key; the verbs that run or plan tests require no `schedule`.

**Behavior changes**
- **B16** `scripts/tests::testing_config`. Before: refuses a `testing` with no `schedule`, and reads its form. After: neither. Users: in the release: every verb that reads `testing`. Ruling: rewrite.
- **B17** `scripts/tests::declared_values`, `cmd_declare` (`tests declare`). Before: `--schedule` with `--schedule-said` writes `testing.schedule`. After: both are refused, and every declare drops the key. Users: in the release: `/ok-setup` (changed here). Ruling: rewrite.
- **B18** `scripts/plumbline::testingDefects` (`config-check`). Before: accepts `testing.schedule` of a known form. After: reports it retired. Users: in the release: true-up's config check, which runs over its own rewrites, and `/ok`'s `config` question. Across stored state: each project's `.ok-planner/config.json` that holds the key. Ruling: migrate: true-up's plan removes the key before it checks the config, and the materialized lint arrives only with that same true-up (call; decided by `decision:settings-have-no-code-defaults`'s rewrite of retired keys, as true-up rewrites `runtime` out of `offers`).
- **B19** `admin/true-up::FORMER_SUITE_SETTINGS`, `testing_key_issues`, `lint_config_transforms` (`/ok`'s plan). Before: writes `testing.schedule` at `groups-one-at-a-time` with a null `said`, and files `testing-schedule-unconfirmed`. After: removes the key and files no such issue. Users: in the release: `/ok`. Across the public surface: the owner who runs `/ok` sees one more rewrite in the plan of a project that holds the key, under the plan's one consent. Across stored state: a standing `testing-schedule-unconfirmed` issue in a project's intake. Ruling: migrate: the plan's removal is a step under the owner's one go-ahead, and a standing issue is answered by the next `/triage-issues` as settled by the tooling (call; decided by `decision:testing-set-up-by-its-own-verb` as the sprint amends it).
- **B20** `skills/ok-setup/SKILL.md` (`/ok-setup`). Before: asks which schedule the suite command runs, and records it. After: no schedule step; the runner step describes `locks`. Users: across the public surface: the owner who runs `/ok-setup`, which takes no arguments; an owner who asks it to change the schedule is told the key is retired. Ruling: migrate: an owner who asks for the schedule is told, in `tests declare`'s words, that rounds run under locks and no schedule is recorded (call; decided by the amended `decision:testing-set-up-by-its-own-verb`, the owner's approved delta).
- **B21** `skills/plan-sprint/tests-budget.md` (the budget planner). Before: reads `testing.schedule`. After: does not. Users: in the release: the test planning procedure and `/ok-setup` 3.5 (renumbered 3.4). Ruling: rewrite.

**Tested stories**
- None.

**Runtime parts**
- None.

### Convert earlier declarations to locks on true-up

**Calls**
- A scenario list is in the locks' earlier form where a scenario records `resources` or `reads`, or where the list holds no `lock_list` key. A list with no declarations and no `lock_list` converts to `lock_list` `[]` and `test_support_locks` `{}`, and loses its budget's preflight mark too. Decided by: the work item ("drops the recorded budget's preflight mark so the next tested sprint's preflight checks the suite command against the locks"); every project whose suite command ran under the earlier `{tests}` shape needs that preflight and the issue, declarations or none, and a missing `lock_list` marks such a project once.
- The conversion reads: each `resources` slug becomes that name `exclusive`; each `reads` slug and the implied read are dropped; each converted name joins `lock_list` with `converted from the shared resource <name>; say what shared thing it guards`; the budget's `preflight` key is dropped. Each `-plan.json` beside a sprint under `.ok-planner/sprints/` converts the same way, and each of its scenarios whose latest `tests` item, in the sprint's run and then its certification ledger, records `resources` or `reads` and no `locks` takes that item's `resources` as its `exclusive` locks (B3). Names a plan introduces join the list too. Decided by: `decision:locks-grow-from-observed-failures` and `decision:live-sprints-brought-current-on-true-up`; the fold keeps a writer's recorded declaration in a run log no tool may rewrite.
- `tests convert-state --dry-run` prints one JSON object on standard output, `{"<project-relative path>": "<the text the write would leave>", ...}`, one entry per file it would rewrite, and its said lines on standard error; without `--dry-run` it writes each file under `state_lock` (the scenario list) or by `write_replacing` (each plan). Decided by: true-up takes the tool's output as each rewrite, and one conversion now rewrites several files.
- True-up builds one rewrite record per path in that object (`DESTRUCTIVE: rewrites <path>: ...`), each with `Show: true-up show <path>`, and refuses the conversion, with a `left:` line, where any of those files changed while it read them. Decided by: the sibling `test_state_conversion` record and `apply_rewrites`'s before-check.
- True-up files `testing-suite-command-locks` where the plan converts the scenario list and `testing.enabled`, as the plan leaves the config, is `on` or `frozen`; `kind` `audit`, `category` `test`, no route, recommendation, or upstream draft; its problem names `testing.run`, says the suite command now receives `{"workers", "seed", "tests": [{"path", "name", "locks"}]}` in place of `resources` and `reads`, and must start the listed tests in that order and each only once it holds its locks, says the next tested sprint's preflight checks it, and names `/ok-setup`'s runner check; its options are to change the suite command and run `/ok-setup`'s runner check, or to change it in the next sprint's preflight. Decided by: the work item, and the sibling `reaches_issue` shape.
- Shares `admin/true-up` and `admin/ADMINISTRATION.md` with item 6 and with the archive-bookkeeping, sign-off-settings, and folder-finding items (other groups); its edits touch only `test_state_conversion`, its callers, the state detail, and the filing step.

**Changes**
- `scripts/tests::USAGE` (`tests convert-state`): changed. The third earlier form, the plans it converts, the fold of earlier `tests` items, the preflight mark, and the `--dry-run` JSON.
- `scripts/tests::converted_locks(scenario)`, `converted_plan(root, sprint)`, `earlier_lock_form(state)`: new. `@decision: locks-grow-from-observed-failures`.
- `scripts/tests::cmd_convert_state`: changed. Detects the third form, converts the list and every open plan, prints the JSON map under `--dry-run`, and writes under `state_lock` otherwise; prints one line per file converted.
- `admin/true-up::test_state_conversion`: changed. Returns a list of rewrite records, one per path the dry run names; `STATE_DETAIL` names the locks conversion and the preflight mark.
- `admin/true-up::rewrite_plan`: changed. Adds every record of the conversion.
- `admin/true-up::cleared_stories_text`, `test_sprint_steps`: changed. Read the list's record from the new return.
- `admin/true-up::suite_command_locks_issue`, `filing_steps`: new and changed. The issue, filed after every move and conversion, as the sibling issues are.
- `admin/ADMINISTRATION.md` (the drift table's scenario-list row; the `testing` question's `{tests}` shape; "The scenario list" paragraph; "The testing keys" bullet): changed. The locks conversion, the open plans, the preflight mark, the issue, and `{tests}` with `seed` and `locks`.
- `.ok-planner/review/project.md` (the `scripts/tests` line): changed. `convert-state`'s third form, its plans, and its `--dry-run` JSON.

**Behavior changes**
- **B22** `scripts/tests::cmd_convert_state` (`tests convert-state`). Before: converts two earlier forms of the list alone; `--dry-run` prints the converted list. After: converts the locks form too, and every open plan; `--dry-run` prints a JSON map of path to text. Users: in the release: `admin/true-up::test_state_conversion`, which runs the carried tool. Ruling: rewrite.
- **B23** `admin/true-up::test_state_conversion`, `filing_steps` (`/ok`'s plan). Before: no step for declarations. After: one rewrite per converted file, the dropped preflight mark, and, under `on` or `frozen`, the `testing-suite-command-locks` issue. Users: across the public surface: the owner who runs `/ok`, whose plan shows the steps under its one consent; an abort leaves the project on its stamped version. Across stored state: this is the migration B1, B2, and B3 rule. Ruling: migrate: the steps ride the plan's one go-ahead, as every conversion of an earlier form does (call; decided by `decision:live-sprints-brought-current-on-true-up`).

**Tested stories**
- None.

**Runtime parts**
- None.

### Keep a per-machine worker record and add `tests machine`

**Calls**
- Under `--json`, `tests machine` prints its per-measurement progress lines to stderr, so the JSON stays parseable. Decided by: the notes review's build note.
- The record is `{"measured": {...}, "workers": <n or null>, "history": [{"at", "workers", "reason", "evidence", "measured"}, ...]}` at `.ok-planner/.cache/tests-machine.json`; `measured` holds `cores` (`os.cpu_count()`), `memory_bytes` (`os.sysconf('SC_PAGE_SIZE') * os.sysconf('SC_PHYS_PAGES')`), `docker_memory_bytes` (`docker info --format {{.MemTotal}}`), and `containers`, each running container's name and memory from `docker stats --no-stream`, with their sum; where docker is not on PATH or does not answer, the docker fields are null with the reason. Decided by: `decision:workers-sized-per-machine` (cores, memory, Docker memory, the memory other containers hold; a dated history with the constraint and the evidence).
- The memory "containers outside the tests run hold" is every running container's at the moment `tests machine` runs, each named; the preflight runs it before it starts the stack, so what it counts is others'. Decided by: the tool cannot tell a test stack's containers from others'; the preflight's order gives the reading the decision names.
- Docker is reached through `docker-sweep`, loaded with `load_sibling` as `ports` loads it: `docker_reached`, which emits `SWEEP.DOCKER.UNREACHED` and returns false, and `docker_out` with `stack_helpers.docker_query_seconds` as its timeout. A docker query that fails after docker answered propagates to `main`'s owner frame. Decided by: plumbline-coding rule 6 (import, never copy) and rule 4 (the catch in `docker_reached` takes a branch; the rest propagates).
- `tests machine --workers <n> --reason <text> --evidence <text>` take one another: each refuses without the other two, and each text must be non-empty. The count is bounded by the budget of the sprint `--sprint <path>` names, its plan's or, where it has none, the scenario list's, and without `--sprint` by the scenario list's; where no budget stands the bound is one worker, as a run with no budget runs one. Decided by: the work item ("refuses a count below 1 or above the budget's workers") and `budget_workers`.
- `tests machine --clear --reason <text>` sets the count to null and appends a history entry, so runs go back to the budget's workers; it refuses `--workers` and `--evidence` beside it. Decided by: plumbline-coding rule 14 (every record created on request has a public action that removes it, in the same surface class).
- The record is written inside `.cache/tests-machine.lock` by `write_replacing`, its history read inside the lock. Decided by: plumbline-coding rule 3 and the sibling `results_lock`.
- `tests run` runs `min(record's count, the budget's workers)` where the record holds a count, else the budget's; `--workers <n>` overrides both and refuses below 1 or above the budget's workers. The header's `workers_from` is `flag`, `record` (the record's count ran), or `budget`. A malformed record is refused, naming its path and `tests machine --workers` or `--clear`. Decided by: the work item.
- `tests machine` prints one line per measurement as it takes it. Decided by: plumbline-coding rule 15.
- `@story: suite-fits-the-machine-it-runs-on` and `@decision: workers-sized-per-machine` stand on `machine_workers`, the function that picks the run's count, and on `cmd_machine`. Decided by: the sprint build prompt's story-annotation rule.
- Shares `scripts/tests::cmd_run`, `tested_round`, `recorded_round` with item 2, and `tests machine --workers` with the flaky route item, which writes the record with a round as evidence.

**Changes**
- `scripts/tests::USAGE`: changed. `tests machine [--sprint <path>] [--workers <n> --reason <text> --evidence <text> | --clear --reason <text>] [--json]`, and `tests run --workers <n>` with the record's and the budget's place and the header's `workers_from`.
- `scripts/tests::MACHINE_RECORD`, `MACHINE_LOCK`: new constants.
- `scripts/tests::sweep`: new module binding, `load_sibling("docker-sweep")`.
- `scripts/tests::measured_machine(root)`: new. Prints and returns the measurement.
- `scripts/tests::read_machine(root)`, `machine_workers(root, sprint, flag)`: new. Validate the record; return the count and its source.
- `scripts/tests::cmd_machine`: new. Prints the measurement beside the record, or writes the record.
- `scripts/tests::tested_round`, `recorded_round`, `cmd_run`: changed. Take the count from `machine_workers` in place of `budget_workers`; the header records `workers` and `workers_from`.
- `scripts/tests::build_parser`, `main`: changed. The `machine` verb with its flags and pairings; `run --workers` (`type=int`).
- `.ok-planner/review/project.md` (the `scripts/tests` line): changed. Lists `machine`, its record under `.cache/`, its refusals, and `run --workers`.

**Behavior changes**
- None. Every change is new code no existing user reaches: no record exists before this release, so every run keeps the budget's count until a writer writes one, and the header's new fields are read only by this release's readers.

**New surface**
- `tests machine` and `tests run --workers`, declared in `scripts/tests::build_parser`: internal.
- The record at `.ok-planner/.cache/tests-machine.json`: internal.

**Time controls**
- `scripts/tests::measured_machine`: exposed setting, each docker query's timeout is `stack_helpers.docker_query_seconds` in `.ok-planner/config.json`, the setting the stack helpers already read.

**Tested stories**
- None.

**Runtime parts**
- None.

### Let the preflight and the budget planner lower the machine's count

**Calls**
- The preflight keeps the budget's sizing in the configuration files it may edit and lowers only this machine's count; it closes `blocked` only where the stack at the budget's sizing does not fit the machine with one worker. Decided by: the work item ("closing `blocked` only where one worker does not fit") and `decision:test-stack-budgeted-as-one-resource` (the committed sizing is every machine's).
- The preflight writes its count with `tests machine --sprint [SPRINT PATH] --workers <n> --reason "<the constraint>" --evidence "preflight task <task>: <the measurement>"`, and its `done` result names the count and where it came from: `<n> workers on this machine (the budget names <b>; lowered for <constraint>): sizing, <l> limits, and the suite run's checks hold`. Decided by: the work item ("closes `done` naming the count").
- The checks run at the lowered count: each `tests run --only` the preflight starts reads the record, and a `split` limit needs one share per worker of that count. Decided by: item 8 (every run reads the record).
- The budget planner may write a lowered count only up to the scenario list's budget, the bound `tests machine` reads with no sprint; where the budget it proposes is larger and this machine cannot carry it, it says so in its budget item's body, and the preflight writes the record once the plan stands. Its proposed workers stay what every machine starts from. Decided by: item 8's bound and the work item ("the committed budget's workers stay the count every machine starts from").
- The budget prompt's paragraph on which tests run together becomes the lock model, with no `resources`, `reads`, or schedule. Decided by: plumbline-coding rule 1; item 6 removes the schedule from the same prompt.
- Shares `skills/converge/prompts/test-preflight.md` with "Check the suite command against the locks before a round" and "Run the setup checks with no recorded test" (other groups), which rewrite checks 5 to 7; this item adds the first read and check and changes the close. Shares `skills/plan-sprint/tests-budget.md` with item 6 and with "Keep the session out of scenario field values" (another group), which changes the prompt's opening condition and its record.

**Changes**
- `skills/converge/prompts/test-preflight.md` (Read; a new first Check; the blocked paragraph; Close): changed. Read gains `.ok-planner/bin/tests machine`, the measurement and the record. The new check compares the measurement with what the budget's sizing needs for its workers (Docker memory, and the memory other containers hold); where the machine cannot carry them, it writes the lowest count that fits and runs every later check at it. The blocked paragraph names one worker not fitting as the sizing failure; Close names the count.
- `skills/plan-sprint/tests-budget.md` (the lock-model paragraph, Read, Budget, Record): changed. The paragraph says a test holds locks, two tests run at once unless they hold one name and one holds it exclusive, and a run uses the budget's workers or this machine's lower count; Read step 1 notes each test's locks, a new step reads `tests machine`; Budget says the planner may write a lowered count for this machine with its reason, as Calls bound it, and never lowers the budget's workers to fit one machine.

**Behavior changes**
- **B24** `skills/converge/prompts/test-preflight.md` (the preflight task). Before: a machine that cannot carry the budget's workers fails a sizing check and closes `blocked`. After: it writes a lowered count to this machine's record and closes `done` naming it. Users: in the release: `scripts/tests::stage_preflight`, which files the test stages once the preflight closes `done`, and `stamped_budget`, which marks the budget with a `done` preflight. Ruling: rewrite.
- **B25** `skills/plan-sprint/tests-budget.md` (the budget task). Before: reads declarations as `resources` and `reads` and runs under a schedule form. After: reads locks and this machine's record, and may write the record. Users: in the release: the test planning procedure and `/ok-setup`'s budget step. Ruling: rewrite.
- **B26** `skills/plan-sprint/tests-budget.md` (the record the budget task leaves). Before: none on the machine. After: it may leave this machine's record under `.cache/`, which later runs on the machine read. Users: in the release: `tests run` and the preflight. Ruling: rewrite.

**Tested stories**
- None.

**Runtime parts**
- None.

### Route a flaky test through its round's window

**Calls**
- A fixer records a lock as one `locks` item per key: `tasks item add --pool locks --key <the scenario id, or the test support file's path> --field 'locks=[{"name": "<lock>", "mode": "<exclusive | shared>"}]' --field defect=<the defect id> --field evidence="round <n>; <the window line>; <the log lines>" --body "<what the two tests share, and why this mode>" --task <task>`. This is the same `locks` pool the test support task uses under "Record locks and the lock list in the scenario list". Decided by: that work item, which keys a test support file's `locks` item by its path, and plumbline-coding rule 6, which says to import and never copy, so the tool reads one pool.
- The tests tool reads every `locks` item in the sprint's run and its certification ledger. An item from a fixer adds its locks to the declaration of the test or test support file its key names, and the test holds a name exclusive where any declaration holds it exclusive. An item from a test support task holds that file's whole list in place of the list the scenario list records, and the latest such item stands. A `tests` item from a test writer still replaces the test's own list, but no `tests` item drops a lock that a fixer's `locks` item added in this sprint. In short, the agent that writes the code declares its locks, and a fixer adds to them. Decided by: decision:locks-grow-from-observed-failures (the set grows from findings and from what writers see), decision:tests-isolated-unless-declared (a test holds a name exclusive where it or its test support declares it exclusive), and decision:fixers-never-edit-tests (a fixer's lock changes the record, not the test). **Shared with "Record locks and the lock list in the scenario list"**, which defines the item's shape. The two stages must agree on this rule. Where that stage builds a different rule for test support items, this stage follows it, and a fixer's item still adds.
- For each lock it adds, the fixer records a call in the `divergences` pool. The call has the same shape test-verify uses: `--field kind=call --field site=<test path>[::<name>] --field choice="<id> holds <lock> <mode>: flaky in round <n>"`. The certification ledger's `calls` config already selects `divergences`, so each call reaches the completion report through `tasks render --certification`. Decided by: the work item ("Each lock added reaches the completion report as a call"), and test-verify.md:57-62, the sibling shape (plumbline-coding rule 2).
- When the fixer finds no cause, it sets the defect `fixed` with `--field cause=none`, and its note opens with `found no cause:`. It also records one `divergences` call saying that the test rides the next whole-suite round with its cause unfound. A new `defects` state would need changes to converge SKILL.md's vocabulary, to `review verifies`, and to the return. No work item lists those. The call keeps a found-none record from passing in the report as an ordinary fix. Decided by: decision:flaky-tests-traced-through-the-round-window (found-none rides the next whole-suite round, and a later passing round may close certification), and accept-list entry A9.
- The fixer names a new lock with `tests locks add` and does not stage `.ok-planner/test-state.json`. The tests tool owns that record, and the archive step commits it with the stamp. A fix that adds only a lock, or only lowers the machine's count, stages no file. Its close names each site as `<test path>=standing`, as an at-fault close already does. Decided by: the fix line rule's `record` class (`skills/_converge/coding-rules.md`:103-106: a record changes only through the act that owns it), and `scripts/tasks::check_sweep`.
- A defect marked `flaky=true` always takes the flaky route, even where a fix landed after its round. Its pass alone came before any fix. Decided by: the merge's flaky mark (`skills/converge/prompts/merge.md`:80) and decision:failing-tests-rerun-alone.
- A stopped round's reproduction (fix.md step 9) uses the round's order seed and worker count too. Decided by: plumbline-coding rule 8 (fix every member of the class), and decision:flaky-tests-traced-through-the-round-window.
- A missing lock is no longer a test-at-fault record. The at-fault text in fix.md step 5 and in verify.md stops naming a declaration. Decided by: the work item, and decision:fixers-never-edit-tests.
- Shared files: `skills/converge/prompts/fix.md` with "Count a pass as fixed under `testing.reaches` `none`" (also in this group). `skills/converge/prompts/verify.md` with "Accept a boundary-question decline in the verifier prompt". `scripts/tests` with every work item in the locks and machine cluster. Chain the stages with `--after`.

**Changes**
- `skills/converge/prompts/fix.md` "A failing test", step 1 (Read): changed. The fixer also reads the round header's `seed` (the order seed) and `workers` (the worker count). The header fields come from "Hand the suite command each test's locks in a new random order" and "Keep a per-machine worker record".
- `skills/converge/prompts/fix.md` step 3, the flaky branch: changed. It drops "broken until its cause is found" and keeps "never record it as passing as the tree stands". The fixer now:
  - reads `.ok-planner/bin/tests window --sprint [SPRINT PATH] --round <the defect's round> --test <the scenario>`, the tests that failed with it in that round, and the stack's logs for the window, where the project's facts name them;
  - reproduces the failure with `tests run --sprint [SPRINT PATH] --only <the test and each test the window lists> --seed <the round's order seed> --workers <the round's worker count>`;
  - routes the cause one of six ways:
    - **A race.** A test in the window overlapped the failing test or ran before it, and it sets up, checks, or changes what the failing test sets up or checks. The fixer reads `tests locks`. Where no name fits, it adds one with `tests locks add <name> --guards "<line>"`, by the locks rule. It records one `locks` item for each of the two tests, or one for their shared test support file, as the Calls above say. Then it sets the defect `fixed`.
    - **An overload.** The logs show the stack out of memory, connections, or time at the round's count. The fixer runs `tests machine --workers <a lower count> --reason "<the constraint>" --evidence "round <n>: <the log lines>"`, adds no lock, and sets the defect `fixed`.
    - **The product fails under load.** The fixer fixes the product as the "It fails" branch says, then follows step 4.
    - **A test leaves something behind.** The fixer fixes the `testing.leftovers` command, as now.
    - **The test or its test support is at fault.** The fixer follows step 5.
    - **No cause found.** The fixer sets the defect `fixed` with `cause=none`, as the Calls above say.
- `skills/converge/prompts/fix.md` step 5: changed. "a missing declaration included" goes, and "what it must check or declare instead" becomes "what it must check instead".
- `skills/converge/prompts/fix.md` step 9: changed. The reproduction run takes `--seed <the round's order seed> --workers <the round's worker count>`.
- `skills/converge/prompts/fix.md` "Close": changed. The result counts found-none records: `<n> fixed (<k> with no cause found)`. A lock-only or count-only fix closes with `--sites <test path>=standing`.
- `skills/converge/prompts/verify.md` "A fix for a failing test", the flaky bullet (line 43): changed. A flaky defect's record changes no file, so these three checks replace the walk through changed code:
  - **A lock fix holds** where a rerun of `tests window` for the defect's round shows the other test overlapping or preceding the failing one, and marks the lock on both tests, at least one of them exclusive. The `locks` items (`tasks item list --pool locks --json`) must name the defect, and the evidence must cite that round's window line and log lines.
  - **An overload fix holds** where the stack's logs show the load, and `tests machine` prints a history entry that names the round and a count below the count in the round's header.
  - **A found-none record holds** where the window marks no test that shares a shared thing with the failing test, and the logs show no load and no product fault.

  The verifier sends the fix back where a check fails, or where the note records the test as passing as the tree stands. The verifier runs `tests window` and `tests machine` with no `--workers` flag, and both write nothing.
- `skills/converge/prompts/verify.md` "at-fault" (line 52): changed. "or its declaration" goes.
- `scripts/tests::live_tests`: changed. After it builds each live entry, the plan's scenarios and the entries the plan does not name alike, it applies the `locks` items of `record_runs(root, sprint)`, as the Calls above say. It matches each item to a test by scenario id, or to a test support file the test lists. Every reader of a live test's declaration then sees the lock: `run`'s `{tests}` file and run locks, the lock check, `tests window`, the ranking, the verify brief, and the stamp.
- `scripts/tests::cmd_stamp`: changed. A scenario the plan does not name keeps its record from the scenario list, as now (`by_id.update(... not in planned_ids)`). A `locks` item now adds its lock to that record too. Each test support file's recorded locks take the file-keyed items. Without this, a lock a fixer adds to a kept test that the sprint did not plan is never stamped.

**Behavior changes**
- **B101** `skills/converge/prompts/fix.md` (step 3's flaky branch, step 9, the close). Before: the fixer read the round's results and reproduced the failure with `--only` at the budget's worker count. It sent tests that shared state to a missing `resources`/`reads` declaration, recorded as a test at fault, and a flaky test stayed broken until its cause was found. After: the fixer reads `tests window`, reproduces the failure at the round's order seed and worker count, and closes the defect `fixed` by one of three records: a `locks` item, a lower machine count, or a found-none record. Users: in the release, the fix verifier (verify.md, changed here), converge SKILL step 5 (unchanged: a `fixed` defect gets a verifier), and the tests tool (reads the `locks` items). Across the public surface: the owner who runs `/converge sprint`. The invocation and the return block keep their shape. A flaky defect now closes as the owner's ruling on `back-out-reads-and-side-by-side-tests` (point 8) directs. Ruling: migrate: `/converge sprint` takes the same invocation and returns the same block. A flaky defect now settles by lock, count, or found-none, which the ruling and decision:flaky-tests-traced-through-the-round-window require (call).
- **B102** `skills/converge/prompts/fix.md` step 5. Before: a missing declaration was a test fault, sent to a test task. After: a missing lock is never a test fault. Users: in the release, the verifier's at-fault check (B104) and converge SKILL step 5a (fewer `rewrite` defects). Ruling: rewrite.
- **B103** `skills/converge/prompts/verify.md` flaky check. Before: the verifier sent a flaky fix back where its note named no cause the change removes. After: it accepts a lock fix, an overload fix, or a found-none record on the window and logs evidence above. Users: in the release, the converge SKILL confirm step 6a (reruns the verified defect's test). Ruling: rewrite.
- **B104** `skills/converge/prompts/verify.md` at-fault check. Before: a wrong declaration counted as the test at fault. After: it does not. Users: in the release, converge SKILL step 5a. Ruling: rewrite.
- **B105** `scripts/tests::live_tests`. Before: a test's declaration came from the plan, the `tests` items, and the scenario list. After: the `locks` items of the sprint's run and certification ledger also add to it. Users: in the release, `cmd_run`/`run_suite` (the `{tests}` file and run locks), the lock check, `tests window`, the ranking, `stage_verify` briefs, and `cmd_stamp`. Across stored state: none. The items live in a run not yet across. Ruling: rewrite.
- **B106** `scripts/tests::cmd_stamp`. Before: the stamp carried a scenario the plan did not name verbatim. After: the record also carries the locks a `locks` item added to it. Users: in the release, the next sprint's readers of `.ok-planner/test-state.json` (planners, `run`). Across stored state: the record gains `locks` in the form "Record locks and the lock list in the scenario list" writes, and that item rules the format's migration. Ruling: rewrite.

**Tested stories**
- None.

**Runtime parts**
- None.

### Count a pass as fixed under `testing.reaches` `none`

**Calls**
- "A fix landed since the failing round" means this: a task of role `fix` in this run's ledger closed `done` and staged at least one file, and the failing round's header `tasks_closed` does not list that task as `<ledger>#<task>`. The fixer reads the tasks with `tasks dump --type task`. A `restore` task undoes fixes, so it does not count as one. Decided by: decision:failing-tests-rerun-alone ("Under `none`, a pass counts as fixed where any fix landed since the failing round"), and `scripts/tests::recorded_round`, which records `tasks_closed` in each header.
- The verifier needs no new text for this item. Its "The test still fails" rerun, and its general check of a `fixed` defect, judge a pass that another fix brought. Decided by: `skills/converge/prompts/verify.md`:38-45.
- Shared file: `skills/converge/prompts/fix.md` with "Route a flaky test through its round's window". This item builds on that item, so chain the stages.

**Changes**
- `skills/converge/prompts/fix.md` step 3, the two "It passes" branches: changed. Where `testing.reaches` names `files` or `folders`, a pass counts as fixed where `tests reached --sprint [SPRINT PATH] --files <the files those fix tasks staged>` lists the test (see I101). Under `none`, `tests reached` lists nothing and its note says so, and a pass counts as fixed where any such fix task exists. In either form, the fixer sets the defect `fixed`, naming the fix task and its own run. A defect marked `flaky`, or a pass with no such change, takes the flaky route.
- `scripts/tests::cmd_reached`: changed. The stderr note under `none` keeps "rerun only the tests the fix was for, and the final whole-suite round catches the rest". It adds that the fix prompt counts a failing test's pass alone as fixed where any fix landed since its failing round. The verb still prints no scenario id.
- `scripts/tests::USAGE`, the `tests reached` entry (lines 228-239): changed, to state the same note.

**Improvements**
- **I101** `skills/converge/prompts/fix.md` step 3. The maintenance cost: the step says "each file changed since the round" and never names how the fixer lists those files. So it gives one undefined procedure for `files`/`folders` and, after this item, a second for `none`. Afterward the step names the list once for both forms: the fix tasks of this run's ledger that closed `done` after the round's header was recorded, and the files each one staged. `files`/`folders` feeds those files to `tests reached`, and `none` counts any such task.

**Behavior changes**
- **B107** `skills/converge/prompts/fix.md` step 3 under `none`. Before: `tests reached` listed nothing, so every lone pass took the flaky route, even after a fix landed. After: a lone pass counts as fixed where a fix landed since the failing round. Users: in the release, the verifier (reruns the test), converge SKILL steps 5 and 6a. Across the public surface: the owner who runs `/converge sprint`, whose invocation and return block keep their shape. Ruling: migrate: the same invocation and the same return block. Under `none`, a pass after a landed fix settles as fixed, as decision:failing-tests-rerun-alone requires (call).
- **B108** `scripts/tests::cmd_reached` note and its usage text. Before: the note said to rerun only the tests the fix was for. After: it adds the fix prompt's rule. Users: in the release, fix.md and verify.md read the note. verify.md:45 matches on "says to rerun only the tests the fix was for", which stays. Ruling: rewrite.
- **B109** (I101) `skills/converge/prompts/fix.md` step 3 under `files`/`folders`. Before: "each file changed since the round" was undefined. After: it is the files that fix tasks closed since the round staged. Users: in the release, the fixer and its verifier. Ruling: rewrite.

**Tested stories**
- None.

**Runtime parts**
- None.

### Have writers declare only the locks their tests show

**Calls**
- The block `{{TEST-RESOURCES-RULE}}` is renamed `{{TEST-LOCKS-RULE}}` at every site: `skills/_sprint/shared.md`:698, `skills/plan-sprint/tests.md`:105, `skills/plan-sprint/tests-story.md`:167, and `skills/plan-sprint/tests-runtime.md`:119. The family's file map in `CLAUDE.md`:21 changes "the call, resources, waits, silence, and waste rules" to "the call, locks, waits, silence, and waste rules". Decided by: the technical-writing standard (use the same term for the same thing) and plumbline-coding rule 1. `checks/token-resolution` names no block, so it still resolves the new token. The build runs `python3 checks/token-resolution` after the rename and after the new blocks `{{TEST-STARTING-STATE-RULE}}` and `{{DESIGN-DOC-COMPLIANCE-MERGE-PROMPT}}` land, and fixes any token it reports.
- `{{TEST-LOCKS-RULE}}` is also transcluded into `skills/converge/prompts/test-write.md` and `skills/converge/prompts/test-support.md`, the prompts whose agents declare locks. The planner prompts keep the block, so planners know the model. Each planner prompt's own Record text then says that a planner declares no lock of its own. Decided by: decision:locks-grow-from-observed-failures (the writer declares, and the planner declares none), and plumbline-coding rule 6 (one rule text, transcluded).
- A planner's `rewrite` carries `locks` exactly as `tests scenarios --json` records them for the scenario, and adds none. A `new` records no `locks`. Decided by: the work item ("a planner records `locks` only on a re-plan, carrying each lock a writer or a fixer recorded") and decision:locks-grow-from-observed-failures.
- The test writer always records `locks` on its `tests` item: `[]` for an isolated test, and otherwise the locks its code and its test support show. The tool then takes the writer's list as the test's declaration. Decided by: the work item ("the test writer records `locks` on its `tests` item") and the B105 read rule.
- A writer that needs a name the list lacks adds it with `tests locks add <name> --guards "<line>"` before it records the item. Decided by: decision:locks-named-from-a-project-list (an agent reads the list first and adds a name only where none fits).
- The test-verify brief's wording ("the locks the test holds, each lock change before and after, and each one added") follows what `scripts/tests::test_verify_line`/`declarations_text` print once "Record locks and the lock list in the scenario list" changes the briefs. The test-speed intro follows `speed_brief`, which "Rank the slowest tests by the lock bound" changes. Decided by: those work items, which own the brief generators.
- The test verifier records each lock a `tests` item adds as a call, in the same `divergences` shape it uses now: `choice="<id> holds <lock> <mode>"`. Decided by: test-verify.md:57-62.
- Shared files:
  - `skills/_sprint/shared.md` with "Have each test set up its own starting state" (this group), "Check each round against the locks" (the T4 row), "Sprint certification fixes the defect issues its sprint lists", and the planning handoff and `{{CEREMONY-ARCHIVE}}` items.
  - `skills/plan-sprint/tests.md` with "Keep the session out of scenario field values" (this group) and "Execution creates the progress checklist".
  - `skills/converge/prompts/test-write.md`, `test-support.md`, and `test-verify.md` with "Have each test set up its own starting state".
  - `test-verify.md` and `test-speed.md` with "State the product-slow condition in the speed and verify prompts".
  - `CLAUDE.md` with "Describe the write-only archive in the estate's rules text".

**Changes**
- `skills/_sprint/shared.md::{{TEST-LOCKS-RULE}}` (was `{{TEST-RESOURCES-RULE}}`): changed. Its body says:
  - A test is isolated by default, and takes no lock.
  - A test declares `locks`, each `{name, mode}`. It holds `exclusive` on each shared thing it sets up or checks, and `shared` on one it only changes without caring what other tests do. It also takes every lock its test support files declare, exclusive where either declares the name exclusive.
  - Each name comes from `tests locks`, and a new one is added with `tests locks add` only where no name fits. A name uses the product's own words, at the narrowest scope at which two tests can both see the thing.
  - State only one test can see needs no lock.
  - A test declares nothing it does not see in its own code or its test support.
  - Each run takes the locks its tests declare, and after each round the tool checks each pair of tests that ran together against their locks.
  - A planner declares no lock of its own: a re-plan carries the recorded ones.
  - No one searches other tests for one that might disturb this test.

  The block names no `resources`, `reads`, or `testing.schedule`.
- `skills/_sprint/shared.md::{{TEST-WASTE-RULE}}`: changed. The bullet "A shared resource declared where a cheaper design keeps the test isolated" becomes "A lock held where a cheaper design keeps the test isolated".
- `skills/_sprint/shared.md::{{TEST-SPEED-JUDGING}}`: changed. The cost paragraph explains the lock bound. Each exclusive holder adds its whole seconds to the time its lock is busy. Shared holders of a name run side by side, so they cost the larger of the longest one's seconds and their total over the workers. A test that holds no lock costs about its seconds over the workers. The waste bullet names a lock held where a cheaper design keeps the test isolated, the design, and each lock the rewrite drops. It notes that an exclusive lock often costs the most. The bullet names no `resources`/`reads` and no schedule.
- `skills/plan-sprint/tests-story.md` Record (lines 180-193) and `skills/plan-sprint/tests-runtime.md` Record (lines 128-141): changed. The `resources`/`reads` fields become `[--field 'locks=[{"name": ..., "mode": ...}, ...]', on a rewrite only, carrying the locks the scenario list records for it]`. "name their entry, kind, setup, resources and reads, each `[]` for an isolated test, and waits" becomes "name their entry, kind, setup, and waits. A `new` records no `locks`, and a `rewrite` records the scenario list's locks for it, none where it records none".
- `skills/plan-sprint/tests.md::{{TEST-PLANNER-REVIEW-PROMPT}}` check bullet (lines 168-175): changed. The reviewer checks three things: each `new` records no `locks`, each `rewrite` carries exactly the locks `tests scenarios --json` records for its scenario, and no recorded lock is one a cheaper design avoids. It sends back each lock a cheaper design avoids, such as a clock the test injects or a record of its own. The phrase "the test changes or reads no shared resource it leaves undeclared" goes, because it asked for a search.
- `skills/plan-sprint/tests.md::{{TEST-PLAN-WIDE-REVIEW-PROMPT}}`: changed.
  - The intro's "the shared resources they declare" becomes "the locks they carry".
  - Read 5 names the summary's locks section, whatever name "Record locks" gives the heading that `print_summary` prints as "Shared resources declared" today.
  - The bullet at lines 280-286 becomes: each rewrite carries its recorded locks, and no lock is one a cheaper design avoids. "One slug names one resource across planners" goes, because the lock list now does that.
  - The budget bullet (lines 287-290) says "declares a lock name no recorded test declares".
- `skills/plan-sprint/tests.md` step 5 (line 39): changed. "the shared resources the planned tests declare" becomes "the locks the planned tests carry".
- `skills/converge/prompts/test-write.md`:
  - transcludes `{{TEST-LOCKS-RULE}}`;
  - its Read step adds `.ok-planner/bin/tests locks`, the lock list;
  - the Record bullet "Declarations" (lines 129-138) becomes "Locks": always record `--field 'locks=[...]'`, `[]` where the test holds none, with the locks its code and its test support show, adding a list name first with `tests locks add` where none fits. The verifier judges each change, and each lock added reaches the owner as a call. The sentence "Your record may change the scenario's declarations" now says "its locks".
- `skills/converge/prompts/test-support.md`: transcludes `{{TEST-LOCKS-RULE}}`. Its Write step records the locks the file's code shows as one `locks` item: `tasks item add --pool locks --key <the file's path> --field path=<the file's path> --field 'locks=[...]' --body "<what each lock guards in this file's helpers>" --task <task>`, with `[]` where it shows none. The close result counts the locks.
- `skills/converge/prompts/test-verify.md` "A test" (lines 26-66): changed.
  - The brief text names the locks the test holds, not `resources`/`reads`.
  - The judging paragraph judges each lock change against the test's own code. The verifier sends back a lock the code and its test support do not show, a mode that does not match what the test does to the shared thing, and a lock a cheaper design avoids, naming the design and each lock the rewrite drops.
  - On accepting the test, the verifier records each lock added as a `divergences` call, as now.
- `skills/converge/prompts/test-speed.md` intro (lines 7-21): changed. The ranking charges each test what it costs a round's wall time under the tests' locks. The brief names the locks the test holds, the ranking, and its workers. No `testing.schedule` and no `resources`/`reads`.
- `CLAUDE.md`:21: changed, as the Calls above say.

**Behavior changes**
- **B110** `skills/_sprint/shared.md::{{TEST-LOCKS-RULE}}` and its four transclusion sites, plus two new ones in test-write and test-support. Before: planners declared `resources` and `reads` for every new and rewritten test, under a schedule. After: planners declare none and carry the recorded locks on a re-plan, and writers and test support tasks declare the locks their code shows. Users: in the release, every agent that reads the prompts, and the tests tool's plan assembly and briefs, which read `locks` once "Record locks" lands. Across a release boundary: none. A prompt reaches a trued-up project only whole, through true-up, beside the tool that reads it. Ruling: rewrite.
- **B111** `skills/_sprint/shared.md::{{TEST-WASTE-RULE}}`, `{{TEST-SPEED-JUDGING}}`, and `skills/converge/prompts/test-speed.md` intro. Before: the waste named a shared resource declared, and the cost ran under `testing.schedule`. After: the waste names a lock held, and the cost runs under the lock bound. Users: in the release, the planners, the planning reviewers, the test verifier, the speed reviewer, and `speed_brief`. Ruling: rewrite.
- **B112** `skills/plan-sprint/tests-story.md` and `tests-runtime.md` Record. Before: each new and rewrite recorded `resources` and `reads`. After: a new records no `locks`, and a rewrite carries the recorded ones. Users: in the release, `scripts/tests::assembled_plan`/`plan_failures` (they read the items' `locks`, per "Record locks") and the planner review. Ruling: rewrite.
- **B113** `skills/plan-sprint/tests.md` planner review, plan-wide review, and step 5. Before: they checked that each declaration was complete against every other test. After: they check that a re-plan carries its recorded locks, and send back a lock a cheaper design avoids. Users: in the release, the session's "Fixing a planner's items" (findings come back as re-plans). Ruling: rewrite.
- **B114** `skills/converge/prompts/test-write.md` and `test-support.md` Record. Before: a writer recorded `resources`/`reads` only where they changed, and a test support task recorded no declaration. After: a writer always records `locks`, and a test support task records a `locks` item for its file. Users: in the release, `scripts/tests::live_tests`, `stage_verify`'s brief, and `cmd_stamp`. Across stored state: the stamp writes the locks into `.ok-planner/test-state.json` in the form "Record locks" defines. Ruling: rewrite.
- **B115** `skills/converge/prompts/test-verify.md` "A test". Before: the verifier judged `resources`/`reads` changes and recorded each declaration added. After: it judges lock changes against the test's own code and records each lock added. Users: in the release, the next write stage (send-backs) and the completion report (calls). Ruling: rewrite.

**Tested stories**
- None.

**Runtime parts**
- None.

### Have each test set up its own starting state

**Calls**
- The rule lives once, as a new block `{{TEST-STARTING-STATE-RULE}}` in `skills/_sprint/shared.md`, transcluded into `test-write.md`, `test-support.md`, and `test-verify.md`. It is not copied into each prompt. Decided by: plumbline-coding rule 6. The work item lists `shared.md` among its files, and test-verify already resolves a `shared.md` block (`{{TEST-SPEED-JUDGING}}`).
- "Through the product's removal action" means the public action a user has to remove that kind of record: a command, a route, or an exported function. The test never deletes the record from the store behind the product. Where the product has no removal action for a record a test creates, the writer records a call of kind `mechanics` naming the kind and the gap. It does not reach into storage. Decided by: plumbline-coding rule 14 (every created record has a public removal) and decision:tests-remove-what-they-create.
- The teardown removal runs on every exit of the test, a failing one included. Decided by: test-write.md:73-75 ("tear it down on every exit") and plumbline-coding rule 4.
- Shared files: `shared.md`, `test-write.md`, `test-support.md`, and `test-verify.md` with "Have writers declare only the locks their tests show", on which this item builds. Chain the stages.

**Changes**
- `skills/_sprint/shared.md::{{TEST-STARTING-STATE-RULE}}`: new. It says that each test:
  - sets up the starting state it needs and relies on no earlier test to leave the system clean, because tests run in a new random order every round;
  - takes the exclusive lock of any shared state it sets up;
  - removes in its teardown each record it creates, through the product's removal action, on every exit;
  - where it checks a shared outcome, either resets the outcome in setup under its exclusive lock, or reads the outcome's state before its action and checks for a new instance after it.
- `skills/converge/prompts/test-write.md` Write: transcludes the block beside the setup bullet (lines 73-75).
- `skills/converge/prompts/test-support.md` Write: transcludes the block. Its helpers that set up state and remove records follow it.
- `skills/converge/prompts/test-verify.md` "A test": transcludes the block. The verifier sends the test back, naming the rule it breaks, where the test does any of these:
  - relies on state an earlier test leaves;
  - sets up shared state without holding its lock exclusive;
  - leaves a record it created, or removes one other than through the product's removal action;
  - checks a shared outcome as it stands after its action, with neither a reset under its exclusive lock nor a before-and-after check for a new instance.

**Behavior changes**
- **B116** `skills/converge/prompts/test-write.md`, `test-support.md`, and `test-verify.md`, through `{{TEST-STARTING-STATE-RULE}}`. Before: a test set up in a scratch folder or a stack run and tore it down, and no rule covered state another test leaves or a shared outcome. After: every written test follows the rule, and the verifier sends back one that breaks it. Users: in the release, the next write stage (it files the send-backs) and the tests the suite runs. Across a release boundary: none. Ruling: rewrite.

**Tested stories**
- None.

**Runtime parts**
- None.

### Keep the session out of scenario field values

**Calls**
- The rule lets the session write two fields: the `id` a rename sets, and the body a fold or a wording fix sets. The session writes no other field value on a scenario item, and adds no scenario item, a keep entry included, for a story in the sprint's scope or outside it. Decided by: decision:session-writes-no-scenario-field-value, which lists the rename and the fold as mechanical fixes, so a rename's `id` stays the session's, and the owner's ruling on `session-applies-planner-declarations` (points 1 and 2).
- The budget prompt's paragraph on the lock model replaces its paragraph on `resources`, `reads`, and `testing.schedule` (lines 28-41 and Read 3's "`testing.schedule`, the schedule form it runs"). The prompt must state the model this sprint gives, and "Retire `testing.schedule`" lists no change to `tests-budget.md`. Decided by: plumbline-coding rule 1 (edit every site that restates a retired definition) and decision:tests-isolated-unless-declared.
- Shared files: `skills/plan-sprint/tests.md` with "Have writers declare only the locks their tests show" (this group) and "Execution creates the progress checklist". `skills/plan-sprint/tests-budget.md` with "Let the preflight and the budget planner lower the machine's count". Chain the stages.

**Changes**
- `skills/plan-sprint/tests.md` "Fixing a planner's items" (lines 42-49): changed. After the four mechanical fixes, a paragraph says that no mechanical fix covers these field values, each a planner's judgment: `locks`, `action`, `waits`, `kind`, `setup`, `entry`, `reach`, `test_support`, and `silence`. The session writes no field value on a scenario item beyond the `id` a rename sets and the body a fold or a wording fix sets, and adds no scenario item, for a story in the sprint's scope or outside it. Each lock change comes from the test writer or the flaky fixer, and a story's re-plan carries it. A finding that asks for one of those values goes back as that story's re-plan or as a planner's revision refile, as the paragraph after it already says.
- `skills/plan-sprint/tests.md` step 4 (line 35): changed. The second condition reads "the plan declares a lock name no recorded test declares".
- `skills/plan-sprint/tests-budget.md`:
  - the header line (line 9) says "a lock name a planned test declares that no recorded test declares";
  - the model paragraph (lines 28-41) is rewritten: a test declares `locks`, two tests run at the same time unless they hold one name and at least one holds it exclusive, an isolated test holds none, and the run uses at most the budget's workers;
  - Read 1 notes each test's kind, its setup, and its locks;
  - Read 3 drops `testing.schedule`;
  - the Record section adds that the budget records the budget, its limits, and its calls, and nothing per scenario: no lock list for a scenario and no keep entry for the session to carry, since a lock change comes from a test writer or a flaky fixer.

**Behavior changes**
- **B117** `skills/plan-sprint/tests.md` "Fixing a planner's items". Before: the rule named only the mechanical fixes, so a session could stretch it to set declaration fields and add keep entries. After: the rule names the field values the session leaves alone, and the session writes no field value beyond the `id` and the body. Users: in the release, the session that runs sprint step 3a. Across the Trued-up projects boundary: an approved sprint not yet in execution reads this file whole after true-up, and its groups file keeps its format. Ruling: rewrite.
- **B118** `skills/plan-sprint/tests-budget.md` and `tests.md` step 4. Before: the budget prompt explained `resources`/`reads`/`testing.schedule`, and a budget task ran where the plan declared a shared resource no recorded test declared. After: the prompt explains locks, records nothing per scenario, and a budget task runs where the plan declares a lock name no recorded test declares. Users: in the release, the budget agent, `/ok-setup` 3.5 (which runs the same prompt with `[SPRINT PATH]` set to `none`), and `scripts/tests::planned_budget` (reads one budget item and the limits, and is unchanged). Ruling: rewrite.

**Tested stories**
- None.

**Runtime parts**
- None.

### State the lock model in the testing standard and the cheatsheet

**Calls**
- The prose calls the random-order value "the order seed", and keeps "seed" for the read-only test data `testing.setup` builds. The flag stays `--seed` and the header field stays `seed`. Decided by: the technical-writing standard (use the same term for the same thing). The standard already uses "seed" for the test data (`docs/testing.md`:140-159).
- `docs/testing.md`'s "## The schedule" becomes "## Locks". The lock model's parts fold into it as one section, and the order, the lock check, the starting state, and the worker count each become a section of their own. Decided by: the work item's list and the standard's one-topic-per-section shape.
- Shared file: `docs/plumbline-cheatsheet.md` with "Add the run-time cost rule to the coding rules" (one ambient line). This item changes only the Tests section's ambient lines. Chain the stages.
- A cheatsheet change makes `tests profiles` refuse in a trued-up project until `/ok` writes the test profile again. True-up rewrites both together, so no stage here adds handling. Decided by: decision:stale-lean-body-stops-test-work.

**Changes**
- `docs/testing.md` "The named wastes" (lines 51-52): changed. The bullet reads "A lock held where a cheaper design keeps the test isolated".
- `docs/testing.md` "The schedule" (lines 56-113) becomes these sections:
  - **Locks:**
    - A test is isolated by default.
    - A test declares `locks`, each `{name, mode}`: exclusive for a shared thing it sets up or checks, and shared for one it only changes without caring what other tests do. Two tests may run at the same time unless they hold one name and at least one holds it exclusive.
    - Test support files declare locks too, and each test that lists the file takes them, exclusive where either declares the name exclusive.
    - The lock list lives in the scenario list, each name with one line saying what it guards. The tool refuses a name the list lacks. An agent reads the list before it adds a name, and a name uses the product's words at the narrowest scope two tests share. State only one test sees needs no lock. A name leaves the list only while nothing declares it.
    - Who declares: the writer declares what its code and its test support show; a planner declares nothing and carries recorded locks on a re-plan; the flaky fixer adds locks from evidence; true-up's conversion supplies the rest.
    - No one searches other tests for one that might disturb a test.
    - Each lock a writer or a fixer adds reaches the completion report as a call.
  - **The run's locks:** each run takes each name its tests declare, in name order, exclusive where one of its tests holds the name exclusive and shared otherwise. A run of isolated tests takes none. A run that waits on another run prints one line naming that run and the lock.
  - **Order:** each run draws an order seed, lists the tests by a key the seed gives each test, and records the seed in the round header. `tests run --seed <n>` keeps a round's order over any subset. The suite command starts the tests in the listed order, and starts each one only once it holds the test's locks.
  - **The lock check:** after each round, a pair that ran at the same time while holding one name, at least one of them exclusive, is a lock breach and fails the round. The check compares a pair on the suite command's clock where both lines carry `started` and `ended`, and by arrival otherwise. A test support task fixes the suite command. The check runs on every round, with no gate on the owner's words.
  - **Starting state:** the four rules of `{{TEST-STARTING-STATE-RULE}}`, in the standard's words.
  - **Workers on each machine:** a record at `.ok-planner/.cache/tests-machine.json` holds this machine's count. `tests run` runs it, never above the budget's workers, and `--workers` reproduces a round's count. The preflight, the budget planner, and the flaky fixer lower the count with a reason and evidence.
- `docs/testing.md` "A flaky test and a test at fault" (lines 187-220): changed. "broken until its cause is found" goes. The flaky fixer reads `tests window`, the tests that failed with the test, and the stack's logs, and reproduces the failure at the round's order seed and worker count. It routes a race to a lock on both tests or their test support, an overload to a lower machine count with the round as evidence, a product failure under load to a product fix, a leftover to the leftover command, and a test at fault to the test-at-fault route. Where it finds none, it records that and adds nothing, and once a later whole-suite round passes, certification may close with that cause unfound. "a missing `resources` or `reads` declaration" goes.
- `docs/testing.md` "When speed is read" (lines 247-276): changed. The write-time brief gives "the locks the test holds". The ranking paragraph gives the lock bound: the larger of all tests' seconds over the workers and, for each name, its exclusive holders' seconds summed plus the larger of its longest shared holder's seconds and its shared holders' total over the workers. A round's ranking takes the header's workers, and the scenario list's ranking takes the budget's workers. "No rule puts held tests first" becomes "No rule puts a test that holds a lock first". The three schedule bullets go.
- `docs/plumbline-cheatsheet.md` Tests ambient lines (lines 147-155): changed.
  - The named-wastes line names a lock held.
  - Line 150 is replaced by lines for:
    - the lock model and its two modes;
    - the lock list;
    - who declares;
    - the run's locks and the lock check;
    - the new random order with its recorded order seed;
    - the starting-state and shared-outcome rules;
    - the per-machine worker count.
  - The flaky line (153) states the window, the lock route, the overload route, and found-none, and drops "broken until its cause is found".
  - The ranking line (155) says the ranking charges each test by how much it lowers the lock bound on wall time.
  - No line names `resources`, `reads`, or `testing.schedule`.

**Behavior changes**
- **B119** `docs/testing.md`. Before: the standard described `resources`/`reads`, three schedule forms, a schedule check gated on the owner's words, and a flaky test broken until its cause is found. After: it describes the lock model, the order, the lock check, the starting state, the machine count, the flaky routes, and the lock bound. Users: in the release, every prompt that tells its agent to read the standard (test-write, test-verify, test-speed, the planners), and the materialized copy at `.ok-planner/docs/testing.md`. Across the Trued-up projects boundary: the file reaches a project only whole, through true-up, with the tools it describes. Ruling: rewrite.
- **B120** `docs/plumbline-cheatsheet.md` Tests section. Before: the ambient lines named `resources`, `reads`, and `testing.schedule`. After: they name the lock model. Users: in the release, every agent session through `.claude/rules/plumbline-cheatsheet.md` after true-up, and the `ok-test` profile body plus `.ok-planner/lean-profiles.json`, which true-up writes again from the new text. Ruling: rewrite.

**Tested stories**
- None.

**Runtime parts**
- None.

### Check the suite command against the locks before a round

**Calls**
- A pair qualifies where both tests hold one lock name and at least one holds it exclusive, counting the locks of each test support file a test lists. The pair is read from `tests scenarios --json`, which carries each scenario's `locks` and each test support file's locks once "Record locks" lands. Decided by: decision:suite-contracts-checked-before-a-round and decision:tests-isolated-unless-declared.
- The check runs two halves on every pair. The two tests did not overlap: on the suite command's clock where both lines carry `started` and `ended`, the later `started` is at or after the earlier `ended`. Each line arrived as its test ended: always, by arrival, the later line's `arrived` less its `seconds` is at or after the earlier line's `arrived`. Today the arrival half is skipped where both lines carry the command's clock, so a runner that writes a file's lines together passes the check. "Earlier" means the test whose line arrived first, and "in the group's order" goes, since groups go. Decided by: decision:suite-contracts-checked-before-a-round ("check that the two did not run at the same time and that each test's result line arrives as that test ends").
- The pair runs with `--workers 2` where the budget's workers is 2 or more. Then the suite command could run the two side by side, and must not. Where the budget names one worker, the overlap half is skipped and said so in one line. Without the flag, a machine record of one worker makes the check pass with nothing tested, which is accept-list entry A9. Decided by: A9, and decision:workers-sized-per-machine (`--workers` runs a count up to the budget's). This stage builds after "Keep a per-machine worker record and add `tests machine`" too.
- Shared files: `skills/converge/prompts/test-preflight.md` with "Run the setup checks with no recorded test" (this group) and "Let the preflight and the budget planner lower the machine's count". `skills/ok-setup/SKILL.md` with "Run the setup checks with no recorded test" and "Retire `testing.schedule`", which drops 3.3 and renumbers the sections: cite the runner check by its title, not its number. Chain the stages.

**Changes**
- `skills/converge/prompts/test-preflight.md` check 5 (lines 36-46): changed. It finds two recorded tests that hold one lock name, at least one exclusive, and runs `.ok-planner/bin/tests run --only <the one> <the other> --workers 2 --json`, with no `--sprint`. It checks both halves above. Where no recorded pair holds such a name, it skips the check and names the skip in its close result.
- `skills/ok-setup/SKILL.md` 3.7 check 1 (line 135): changed the same way. Where no pair holds such a name, it skips and says so in one line.

**Behavior changes**
- **B121** `skills/converge/prompts/test-preflight.md` check 5. Before: the preflight paired two tests whose `resources` shared a slug, checked their order on one clock, and skipped the arrival half where the command's clock was present. After: it pairs two tests that share a lock name, one of them exclusive, runs them at two workers, and checks both halves. Users: in the release, `tests tasks --stage write` (it refiles a preflight that closed `blocked`, and a second `blocked` close is a genuine blocker), and sprint certification. Across the public surface: none, since the preflight is a prompt of sprint execution. Ruling: rewrite.
- **B122** `skills/ok-setup/SKILL.md` 3.7 check 1. Before and after: as B121, for `/ok-setup`'s runner check. Users: in the release, none beyond the session. Across the public surface: the owner who runs `/ok-setup`. The verb takes the same invocation and asks the same kind of question about a failed check. A runner that wrote its lines together and passed before now fails, and the owner is asked to change the command or the setup. Ruling: migrate: `/ok-setup` takes the same invocation, and each setting it declared before stands. The changed check reaches the owner as the question 3.7 already asks for a failed check, as decision:suite-contracts-checked-before-a-round requires (call).

**Tested stories**
- None.

**Runtime parts**
- None.

### Run the setup checks with no recorded test

**Calls**
- The preflight says "in one line" in its close result: `readiness half skipped: the scenario list records no test`, beside the counts it already names. The preflight is a task, and its result is what the session and the report read. Decided by: decision:suite-contracts-checked-before-a-round ("each site skips only the readiness half, and says so in one line") and test-preflight.md's close (lines 74-80).
- Shared files: as listed under "Check the suite command against the locks before a round". Chain the stages.

**Changes**
- `skills/ok-setup/SKILL.md` 3.7 first paragraph (line 129): changed. "Where the scenario list records no test, say so in one line, and end the step" becomes "say in one line that the kind-and-setup comparison has nothing to compare", and the step goes on to the three checks.
- `skills/ok-setup/SKILL.md` 3.7 check 2 (Setup run again): changed. Where the scenario list records no test, the check runs setup twice and checks that each run exits 0. It says in one line that the readiness half is skipped, because it needs a recorded test to pass.
- `skills/ok-setup/SKILL.md` 3.7 check 3 (Resources setup did not create): changed. Where the scenario list records no test, the check runs setup beside the scratch resource and checks that setup exits 0 and the resource still stands. It says in one line that the readiness half is skipped.
- `skills/ok-setup/SKILL.md` 3.7 last paragraph ("The step ends when ..."): changed. A skipped readiness half does not hold the step open.
- `skills/converge/prompts/test-preflight.md` checks 6 and 7 (lines 47-62): changed. They keep the setup halves they run now, and each names the skipped readiness half in the close result.

**Behavior changes**
- **B123** `skills/ok-setup/SKILL.md` 3.7. Before: with no recorded test, the runner check said so and ended, running no setup check. After: it runs setup twice and beside a scratch resource, checks each exit and the resource, and skips only the readiness half, saying so. Users: in the release, the session only. Across the public surface: the owner who runs `/ok-setup` on a project with no recorded test. That owner now sees two setup checks run and may be asked about a failed one. Ruling: migrate: `/ok-setup` takes the same invocation, and each setting it declared before stands. The added checks reach the owner through the question 3.7 already asks for a failed check, as the amended decision:suite-contracts-checked-before-a-round commits (call).
- **B124** `skills/converge/prompts/test-preflight.md` checks 6 and 7 and the close. Before: the preflight checked the setup halves silently. After: it names the skipped readiness half in its result. Users: in the release, the session (it renders the result in the completion report) and `tests tasks --stage write` (it reads only the outcome). Ruling: rewrite.

**Tested stories**
- None.

**Runtime parts**
- None.

### Move each decision citation to the decision that holds its choice

**Calls**
- A site whose choice stays with the decision it cites keeps that citation. A site whose choice moved to a split decision cites that decision. A site that enforces no choice of a decision after this sprint drops that citation. For `scenario-list-decided-once`, the amended Choice still holds what the list records, its fields and its reaches included. So `reaches_map` stays, and each other site moves to one of the four decisions split from it. Decided by: the work item ("names the decision whose choice its site enforces after the split"), and the amended decision:scenario-list-decided-once in the sidecar.
- No code site at the commit cites `test-loop-fixes-code-never-tests` for the confirm rerun, the uncapped send-backs of a suite defect, or a refusal of a fixer's test edit. Those choices live in prose (converge SKILL steps 5 and 6a, `verify.md`). So `one-verifier-bar-for-every-certification-fix` (for the confirm), `suite-defects-take-no-send-back-limit`, and `fixers-never-edit-tests` get no citation from this item. The prompts are markdown payloads, which carry no `@decision:` citation. Decided by: `rg "@decision: (tests-isolated-unless-declared|test-loop-fixes-code-never-tests|scenario-list-decided-once)" plugins/ checks/`, which finds only `scripts/tests` and `scripts/review`, and `checks/materialized-standalone`, which reads citations in payload markdown.
- `cmd_run` keeps `test-loop-fixes-code-never-tests`, because it runs the rounds the find source reads, and moves its `tests-isolated-unless-declared` citation to `runs-lock-what-their-tests-declare`. Decided by: the amended decision:test-loop-fixes-code-never-tests ("Sprint certification runs the project's suite as a find source").
- `plan_failures` cites both `scenario-list-maps-each-test-without-a-tag` (one test path and name per scenario, with no duplicate) and `runtime-parts-declared-in-the-scenario-list` (a runtime scenario names its part, class, and harm). It enforces both. Decided by: `scripts/tests`:2147-2223.
- The citation-resolution lint and its edit hook refuse a slug with no file under `.ok-planner/design/decisions/`. So this stage runs after the stage that lands the split decisions' deltas, or applies them itself with `catalog-toc`. Decided by: `scripts/plumbline` `citation-resolution` and `.ok-planner/hooks/post-edit.js`.
- Other items remove or rename many of these functions. This stage reads the tree after them and moves each citation by the role its function plays. The names below are the commit's.
- Enumeration (plumbline-coding rule 1): in `scripts/tests`, `tests-isolated-unless-declared` at lines 866, 923, 1298, 1853, 2096, 2622, 2660, 2791, 2977, 2993, 3009, 3036, 3065, 3076, 3087, 3302, 3383, 3452, 3653, and 4488 (20 sites); `test-loop-fixes-code-never-tests` at lines 2890, 3406, 3451, 3554, 3613, 3732, 3767, 3807, 4277, and 4758 (10 sites); and `scenario-list-decided-once` at lines 1169, 2124, 3878, 5213, and 5274 (5 sites). In `scripts/review`, `test-loop-fixes-code-never-tests` at line 2222 (1 site). That is 36 sites at the commit. "Record locks", "Check each round", "Rank the slowest tests", "Retire `testing.schedule`", and "Convert earlier declarations" each add sites of their own, which cite their own decisions.
- Shared files: `scripts/tests` with every other item that changes it, so this stage runs last among them. `scripts/review` with "Move the closed-issue file out of the archive", "Keep the closed-record ledger in the review tool", "Record a deferred verdict's issue id in the certification run" (which rewrites `unfiled_deferred`), "Give every driver a scratch folder outside the checkout", "Sprint certification fixes the defect issues its sprint lists", "The completion contract checks that certification took up every listed defect issue", and "Point each decision citation at the split decision that holds its choice". Chain the stages.

**Changes**
- `scripts/tests::testing_config`: changed. It drops `@decision: tests-isolated-unless-declared`, because after `testing.schedule` retires it checks no lock choice.
- `scripts/tests::recorded_schedule` and `scripts/tests::effective_reads`: removed by "Retire `testing.schedule`" and "Record locks". Their citations go with them.
- `scripts/tests::cmd_budget`, `planned_budget`, `budget_failures`, and `stage_preflight`: changed. Each cites `@decision: test-stack-budgeted-as-one-resource` in place of `tests-isolated-unless-declared`.
- `scripts/tests::live_tests`: unchanged citation. `tests-isolated-unless-declared` stays, since it builds each test's lock declaration.
- `scripts/tests::command_clock`, `overlapping_pairs`, and the pair check that replaces `forbidden_pair`/`schedule_failures`: changed. Each cites `@decision: rounds-checked-against-the-locks`. `command_clock` keeps `project-owns-its-suite-command` and `test-support-written-before-tests`.
- `scripts/tests::held_groups` (or its successor), `wall_bound`, `ranked_slowest`, and `speed_ranking`: changed. Each cites `@decision: ranking-charges-each-test-its-wall-time-cost` in place of `tests-isolated-unless-declared`, and keeps `speed-ranked-by-median-seconds` and the `@story:` where it has one.
- `scripts/tests::resource_locks` (or the run-lock function that replaces it): changed. It cites `@decision: runs-lock-what-their-tests-declare`.
- `scripts/tests::cmd_run`: changed. `tests-isolated-unless-declared` becomes `runs-lock-what-their-tests-declare`, and `test-loop-fixes-code-never-tests` and `sprint-runs-recorded-whole` stay.
- `scripts/tests::leftover_counts` and `leftover_failures`: changed. Each cites `@decision: leftovers-counted-around-each-round`.
- `scripts/tests::run_suite`: changed. `test-loop-fixes-code-never-tests` becomes `@decision: runs-stop-on-silence`, and `project-owns-its-suite-command` stays.
- `scripts/tests::failing_targets`: changed. `test-loop-fixes-code-never-tests` becomes `@decision: failing-tests-rerun-alone`, and `fixes-rerun-the-tests-they-reach` stays.
- `scripts/tests::settled_scenarios`, `unsettled_failures`, `suite_reports`, and `cmd_reports`: unchanged citation. `test-loop-fixes-code-never-tests` stays, since these sites settle failures and file reports.
- `scripts/tests::settled_failures`: changed. `test-loop-fixes-code-never-tests` becomes `@decision: whole-suite-rounds-repeat-until-one-passes`, because it holds the refusals `tests settled` and `review certified` print. `@story: certify-completion` stays.
- `scripts/tests::awaits_verifier` and `stage_verify`: changed. `test-loop-fixes-code-never-tests` becomes `@decision: one-verifier-bar-for-every-certification-fix`, the verify filing. The other citations stay.
- `scripts/tests::cmd_convert_state`: changed. `scenario-list-decided-once` becomes `@decision: story-test-stamp-is-its-planned-blob`, since it converts the top-level stamp into story stamps. `whole-file-ownership` stays. The lock conversion that "Convert earlier declarations" adds cites its own decision.
- `scripts/tests::plan_failures`: changed. `scenario-list-decided-once` becomes `@decision: scenario-list-maps-each-test-without-a-tag` and `@decision: runtime-parts-declared-in-the-scenario-list`. The other citations stay.
- `scripts/tests::reaches_map`: unchanged citation. `scenario-list-decided-once` stays, since the list records each test's reaches.
- `scripts/tests::stamped_scenario` and `cmd_stamp`: changed. Each cites `@decision: scenario-list-written-at-the-archive-step` in place of `scenario-list-decided-once`. `cmd_stamp` keeps its `@story:` lines.
- `scripts/review::unfiled_deferred` (or the function "Record a deferred verdict's issue id" leaves): changed. `test-loop-fixes-code-never-tests` becomes `@decision: whole-suite-rounds-repeat-until-one-passes`, since it holds `review certified`'s refusal of a deferred verdict that reached no issue. `product-slow-fixes-ride-a-round-that-runs-anyway` stays.

**Behavior changes**
- None. Every change is new code no existing user reaches.

**Tested stories**
- None.

**Runtime parts**
- None.

### Hold the waiters of a short close for the roles a run names

**Calls**
- A run that holds no `held_roles` key names no roles: the tracker reads the key as `run.config("held_roles", [])`, as `check_sweep` reads `swept_roles`. Decided by: the work item ("A run that names no roles keeps today's rule") and coding rule 10.2. The key is a declaration the product's design gives each run, not a deployment setting.
- Only `partial` and `blocked` hold waiters. `disputed`, and an exec's `failed`, free waiters as today. Decided by: `decision:short-close-holds-named-roles` ("closes `partial` or `blocked`").
- A held wait is met once any task names the short task as its `previous`, which is the record `tasks refile` writes. The tracker finds that task with `run.store.where("task", previous=<id>)`. It needs no index of its own, and the query runs only for a closed-short dependency of a held role. Decided by: the work item ("until a refile of that task exists") and coding rule 6 (reuse the store's `where`).
- `tasks retry <short task>` reopens the task in place. Its waiters then wait because the task is open, and they are freed when it closes `done`, with no new code. Decided by: the decision's Choice ("a task issued again in place frees them when it closes `done`").
- `tasks file --after <short task>`, run after the short task has a refile, counts that wait as met, as it counts any wait on a closed task. `file` adds no refile to the new task's `after`. A filer that wants the refile names it. The tests tool's `--stage write` already follows each `--after` to its latest refile. Decided by: the work item, which gives the refile's waiters to `tasks refile` alone.
- `TASKS.TASK.HELD` carries `{"task", "outcome", "role", "held": [<waiter ids>]}`. `held` lists the open tasks whose `after` names the short task directly. A transitive waiter waits on a direct waiter, so it stays unready. The event is written in the same `put_many` as the close, and only when `held` is non-empty. The close prints `closed <task> <outcome>` and then the `next` lines, as today. Decided by: the work item ("one `TASKS.TASK.HELD` event naming the short task and each waiter it holds, and prints no new line the drain reads") and coding rule 3.1 (one state change, one write).
- A held waiter counts under `blocked` in the existing `waiting running=N blocked=N` line. No new token is added. With nothing else running, the drain returns `waiting`, and the caller decides. Decided by: the work item, and `_tasks/drain.md` ("Does not judge an outcome").
- The citation goes above the new `held_wait` function, the readiness rule's one site, which `open_waits` calls. A second line goes above `cmd_close`, where the hold is recorded. Every citation in `scripts/tasks` and `scripts/review` stands above a `def`; none stands inside a body. Decided by: the work item and the file's existing citation placement.
- Shared files: `scripts/tasks` is also changed by "Point each decision citation at the split decision that holds its choice" (`next_claim`, `task_records`), which runs after this item. `skills/_tasks/drain.md` is changed by this item alone.

**Changes**
- `plugins/ok/families/ok-planner/scripts/tasks::HOLDING_OUTCOMES`: new. `("partial", "blocked")`.
- `plugins/ok/families/ok-planner/scripts/tasks::held_wait`: new, under `# @decision: short-close-holds-named-roles`. It takes the run and a dependency record. It returns true where the dependency stands `closed` with an outcome in `HOLDING_OUTCOMES`, its `role` is in the run's `held_roles`, and no task names it as `previous`.
- `plugins/ok/families/ok-planner/scripts/tasks::open_waits`: changed. A dependency that is missing, not closed, or held by `held_wait` counts as an open wait. Every caller then applies the hold: `ready`, which `step` (behind `next`, `close`, and `exec`) and `next_claim` call; `cmd_claim`; and `cmd_task`'s unissue on an `after` change.
- `plugins/ok/families/ok-planner/scripts/tasks::cmd_claim`: changed. Its refusal of a task with open waits names each held dependency with its outcome and the step that frees it: `task <id> still waits on <dep>, which closed <outcome> and holds its waiters until a refile of it exists (tasks refile <dep>)`. A wait on a task not closed reads as today.
- `plugins/ok/families/ok-planner/scripts/tasks::cmd_close`: changed, under `# @decision: short-close-holds-named-roles`. Where the closing task's role is in `held_roles` and its outcome is in `HOLDING_OUTCOMES`, the close collects the open tasks whose `after` names the task. Where any exist, it appends one `TASKS.TASK.HELD` event to the same `put_many`. The printed lines are unchanged.
- `plugins/ok/families/ok-planner/scripts/tasks::cmd_config`: changed. It checks `held_roles` as a list of non-empty role names and refuses any other value with a message naming the shape (see I501).
- `plugins/ok/families/ok-planner/scripts/tasks::USAGE`: changed.
  - `config set` documents `held_roles: ["<role>", ...]`: where a task of one of these roles closes `partial` or `blocked`, every open task that waits on it stays unready until a refile of it exists, and then waits on the refile. Unset, a short close frees its waiters as a `done` close does.
  - `next` says it issues and counts a task only once every task it waits on has closed, and none of them is a held short close.
  - `claim` says it never takes such a task, and that it refuses one by id, naming the short task, its outcome, and the refile it waits for.
  - `refile` says a waiter a short close held waits on the refile and is issued once the refile closes `done`.
  - The opening paragraph's "issued tasks whose waits have all closed" names the hold too.
- `plugins/ok/families/ok-planner/skills/_tasks/drain.md` (the loop's step 1, "the tracker has issued every task whose dependencies are closed"): changed. It reads "whose waits are met", and adds one sentence: in a run that names held roles, a task waiting on a task of such a role that closed `partial` or `blocked` is not issued until the caller refiles it, and the `waiting` line counts it under `blocked`. This is a coding rule 1 site that restates the readiness rule. No step of the loop changes.
- The `concept:task-tracker` amendment and the `decision:short-close-holds-named-roles` delta land in the stage that carries this item, or a stage before it, so the citation resolves under the lint's `citation-resolution` check.

**Improvements**
- **I501** `plugins/ok/families/ok-planner/scripts/tasks::cmd_config`: `swept_roles` and `held_roles` are the same kind of setting, a list of role names. Checking one and not the other builds the check twice or leaves one unchecked. Today a string `swept_roles`, such as `'"build"'`, makes `check_sweep`'s `role not in swept` a substring test. Afterward one function, `role_list(key, value)`, checks both keys as lists of non-empty strings and refuses any other value, naming the key and the shape, such as `["build", "fix"]`.

**Behavior changes**
- **B501** `plugins/ok/families/ok-planner/scripts/tasks::open_waits` through `ready` and `step` (`tasks next`, and the lines `tasks close` and `tasks exec` print). Before: an open task whose every dependency closed, with any outcome, is issued and counted in its profile's `run` line. After: in a run whose `held_roles` names a dependency's role, and where that dependency closed `partial` or `blocked` and has no refile, the waiter is neither issued nor counted, and a `waiting` line counts it under `blocked`. Users: in the release: the drain loop's hand and Workflow forms (`skills/_tasks/drain.md`), which read the `run` and `waiting` lines unchanged in format; sprint execution, which names `build` held through the next item; `/converge`, `/triage-issues`, `/discover-design`, `/plan-docs`, and the test planning run, none of which sets `held_roles`, so each keeps today's rule. Across Trued-up projects: the task tracker's run log format. A run file an earlier release wrote holds no `held_roles` and reads under today's rule. Ruling: preserve (call). The changed rule applies only in a run that declares the new key, and no run an earlier release wrote declares it.
- **B502** `plugins/ok/families/ok-planner/scripts/tasks::next_claim` (`tasks claim --agent`). Before: it takes the most-waited-on issued task whose dependencies are all closed. After: it never takes a held waiter. Users: in the release: every vendored profile's claim protocol, which reads only what the claim prints. Across Trued-up projects: as B501. Ruling: preserve (call).
- **B503** `plugins/ok/families/ok-planner/scripts/tasks::cmd_claim` (`tasks claim <task>`). Before: it claims an issued task whose dependencies are closed. After: it refuses a held waiter, naming the short task, its outcome, and the refile it waits for. Users: in the release: forks of the review profile, which claim pass tasks by id. A pass task waits on nothing (`task_records` refuses `--after` with `--fork-of`), so no fork meets the refusal. Across Trued-up projects: as B501. Ruling: preserve (call).
- **B504** `plugins/ok/families/ok-planner/scripts/tasks::cmd_task` (`tasks task set <task> --field after=...`). Before: it takes an issued, unclaimed task back to unissued only where a named dependency is not closed. After: it also does so where a named dependency is a held short close. Users: in the release: `scripts/tests::set_task_list`, which sets test-stage tasks' `after` lists. In a sprint run, a test task set to wait on a short build now goes unissued until the refile closes, which is the rule `--stage write` already assumes when it follows each `--after` to its latest refile. Across Trued-up projects: as B501. Ruling: preserve (call).
- **B505** `plugins/ok/families/ok-planner/scripts/tasks::cmd_close`. Before: a short close writes the task and one `TASKS.TASK.CLOSED` event. After: in a run naming the closing task's role in `held_roles`, the close also writes one `TASKS.TASK.HELD` event naming the waiters it holds. Users: in the release: `tasks dump`, `snapshot`, `report`, and `render`. None of them filters events by kind in a way a new kind disturbs; `render` reads tasks and items. Across Trued-up projects: the run log format gains an event kind that only a run declaring `held_roles` writes. Ruling: preserve (call).
- **B506** (from I501) `plugins/ok/families/ok-planner/scripts/tasks::cmd_config` (`tasks config set swept_roles <value>`). Before: any JSON value is stored. After: a value that is not a list of non-empty strings is refused, naming the shape. Users: in the release: the sprint execution boilerplate (`'["build", "fix"]'`) and `/converge`'s vocabulary step (`'["fix"]'`). Both pass lists, so neither changes. Ruling: rewrite.

**New surface**
- The run setting `held_roles` (`tasks config set held_roles`), declared in `plugins/ok/families/ok-planner/scripts/tasks`: internal.
- The event kind `TASKS.TASK.HELD`, declared in `plugins/ok/families/ok-planner/scripts/tasks`: internal.

**Tested stories**
- None.

**Runtime parts**
- None.

### Name the build role as held in sprint execution

**Calls**
- Step 3's new sentence sits beside the `swept_roles` declaration, in that paragraph's last line, "returned, each one staged.". Rewriting that line gives true-up a retired line in the hunk. The step then reaches every live sprint, including one that holds no other retired line: `current_section` rewrites only a hunk that holds a retired line, or any hunk where the sprint is already `stale`. Decided by: `admin/true-up::current_section` and the work item ("Each boilerplate line the change replaces joins the released lines").
- The new text: "Declare the roles whose short close holds their waiters: `tasks config set held_roles '["build"]'`, so no stage starts on a build that closed `partial` or `blocked` before that build is refiled." Step 3 already says "run every registration and config below, again on a resumed run", so the declaration runs on a resumed run with no new sentence. Decided by: the work item.
- Step 7 gains, beside its refile rules: "The tracker holds every task that waits on a build closed `partial` or `blocked`: it issues none of them until a refile of that build exists, and they then wait on the refile. So refile each short build, as below, before you drain again." Decided by: the work item and `decision:short-close-holds-named-roles`.
- The planning group's item "Execution creates the progress checklist and renders the report before any drain" renumbers this section. The build finds steps 3 and 7 by content: the step that opens the run, and the drain step. Other items in this sprint also change `sprint-document.md` and `retired-boilerplate.json`: "Sprint certification fixes the defect issues its sprint lists" (step 12), "The completion contract checks that certification took up every listed defect issue", "Out-of-band work changed after Reconcile...", "Execution creates the progress checklist...", and "Write a sprint's bookkeeping before its archive move". `checks/sprint-boilerplate` requires `retired-boilerplate.json` to equal, sorted with no line twice, every line a `v*` tag's template held that the carried template does not hold. Every stage that edits the template brings that file to the check's expected set, and runs `python3 checks/sprint-boilerplate`. Those stages chain on these two files. Decided by: `checks/sprint-boilerplate::history_failures`.
- No other run's text gains a held role: `/converge`'s vocabulary step, the test planning procedure, and the documentation sprint template stay as they are. Decided by: the work item.

**Changes**
- `plugins/ok/families/ok-planner/skills/plan-sprint/sprint-document.md` (`{{SPRINT-DOCUMENT-TEMPLATE}}`, "How to execute this sprint", the "Open the run" step): changed. It declares `held_roles '["build"]'` beside `swept_roles`, on every run, a resumed one included.
- `plugins/ok/families/ok-planner/skills/plan-sprint/sprint-document.md` (the drain step): changed. It says the tracker holds every task waiting on a build closed `partial` or `blocked` until the session refiles that build, so the session refiles each short build before it drains again.
- `plugins/ok/families/ok-planner/admin/retired-boilerplate.json`: changed. Each v31.1.0 line of those two steps that the carried template no longer holds is added in sorted order.

**Behavior changes**
- **B507** `plugins/ok/families/ok-planner/skills/plan-sprint/sprint-document.md` (the execution section's run-opening and drain steps). Before: a sprint's run frees a short build's waiters at once, and the template says nothing of a hold. After: a sprint's run declares `build` held, and its executor refiles each short build before the next drain. Users: in the release: every sprint the carried `/plan-sprint` writes, and the tracker change of the item above, which this text depends on. Across Trued-up projects: every approved sprint not yet in execution. Ruling: migrate: true-up's live-sprint pass replaces each retired line of the two steps with the carried lines, keeping every line the owner added (call). Decided by: `.ok-planner/release-boundaries.md` ("true-up brings each to the carried shape") and `decision:live-sprints-brought-current-on-true-up`.

**Tested stories**
- None.

**Runtime parts**
- None.

### Give every driver a scratch folder outside the checkout

**Calls**
- The folder is `os.path.join(tempfile.gettempdir(), "drive-scratch-" + <drive name>)`, from a new constant `SCRATCH_FOLDER_PREFIX = "drive-scratch-"`. It uses the same temp root as `instance_folders`, and needs no run or round stamp of its own, since the drive name already carries the run-and-round digest and the ordinal. Decided by: the work item and `decision:drive-writes-only-in-scratch`.
- Each brief gains `; scratch folder <path>` right after `; drive name <name>`, before any `; instance folder`. `story_drivers` reads a story brief only up to its first `;`, so certification's story-driver check reads the same slug. Decided by: `scripts/review::story_drivers`.
- Each output row of `review drives` gains `"scratch": <path>`, on every row. `instance` stays present only where the story drives on an instance. Decided by: the work item ("lists it as `scratch` in its output, as it names an instance folder").
- The driver creates the folder fresh at the start of its task, removing what an earlier driver of the same drive name left. That earlier driver is a refile, or the one-at-a-time redrive of step 5, which keeps the brief and so the name. The driver removes the folder as the last step of its clean-up. Evidence it saved there is quoted into its failure items before removal, as the prompt already requires ("each quoted"). Decided by: the work item.
- The session removes no scratch folder: `_converge/drive.md` step 4 stays as it stands. The folder sits under the system temp directory, outside the checkout, so a folder a driver that ended early leaves is no part of the change. Decided by: the work item, which gives removal to the driver alone, and `decision:drive-writes-only-in-scratch`.
- The prompt names the decision's two other places a file may sit, the instance folder and a run folder a review-facts command makes for the drive name, so a driver on an instance is not told to move its instance files. Decided by: `decision:drive-writes-only-in-scratch` Choice.
- `converge/SKILL.md` step 6 and `drive/SKILL.md` stay as they stand. The brief carries the folder to each confirm driver. Decided by: the work item's file list.
- Shared file: `scripts/review` is also changed by "Point each decision citation at the split decision that holds its choice" (which runs after this item) and by the history and planning groups' items: the ownership classes, `cmd_certified`, `cmd_backlog`, `unfiled_deferred`, the ledger verbs, and the `--sprint` resolution of `review drives`. The `--sprint` change reaches `cmd_drives` through `sprint_stories` and its resolution. This item edits the body of `cmd_drives` after it reads the stories.

**Changes**
- `plugins/ok/families/ok-planner/scripts/review::SCRATCH_FOLDER_PREFIX`: new. `"drive-scratch-"`.
- `plugins/ok/families/ok-planner/scripts/review::scratch_folder`: new, beside `instance_folders`, under `# @decision: drive-writes-only-in-scratch`. It returns the scratch path for one drive name.
- `plugins/ok/families/ok-planner/scripts/review::cmd_drives`: changed. In the story and confirm forms, every drive's brief names its scratch folder, and every row of `{"drive_tasks": [...]}` carries `scratch`. `--confirm --dry-run` prints its `pending` list as today.
- `plugins/ok/families/ok-planner/scripts/review` (the `drives` help line in the subcommand help table): changed. It says each brief names a drive name and a scratch folder.
- `plugins/ok/families/ok-planner/skills/converge/prompts/drive.md`: changed.
  - Setup: create the folder your brief names fresh, removing what an earlier driver of your drive name left, and keep every file you write there. Every file means each command's saved output, such as a shell redirect's target, your scratch copy of the project, and your scratch project. Never write a file in the checkout. A file may also sit in your instance folder or a run folder a command in the facts makes for your drive name.
  - "A surface that is a skill": a script runs only where it writes nothing outside that folder.
  - "Confirm": a writing command runs in that folder.
  - Rules: the first and second bullets name the folder as the place of the scratch copy and the scratch project.
  - "Clean up": remove the folder last, after closing your page.
- `plugins/ok/families/ok-planner/skills/_converge/drive.md` (step 3, "The drivers"): changed. It says the verb names in every brief a scratch folder under the system temp directory for the driver's drive name, and lists it as `scratch` in its output.
- The `decision:drive-writes-only-in-scratch` delta lands in the stage that carries this item, or a stage before it, so the citation resolves.

**Behavior changes**
- **B508** `plugins/ok/families/ok-planner/scripts/review::cmd_drives` (`review drives`, `review drives --sprint`, `review drives --confirm`). Before: each brief names a drive name, and an instance folder where one applies; each row carries `task`, `story`, `name`, and the optional `after` and `instance`. After: each brief also names `scratch folder <path>`, and each row also carries `scratch`. Users: in the release: `_converge/drive.md` steps 4 and 5, which read `instance` and `name` and ignore an extra key; `converge/SKILL.md` step 6; `review::story_drivers`, which reads a brief's text up to its first `;`. Across Trued-up projects: none. `review` is a vendored script whose output only the vendored skills read. Ruling: rewrite.
- **B509** `plugins/ok/families/ok-planner/skills/converge/prompts/drive.md`. Before: a driver keeps scratch copies and scratch projects wherever it picks, and may save a command's output inside the checkout, where it lands in the change. After: every file a driver writes sits in its named scratch folder, and the driver removes the folder at clean-up. Users: in the release: every story driver and confirm driver of `/drive`, `/converge drive`, and sprint certification; the certification's change listing, which no longer meets driver output. Across Trued-up projects: none; prompts are vendored and written in one true-up. Ruling: rewrite.

**New surface**
- The `scratch` field of `review drives` output, declared in `plugins/ok/families/ok-planner/scripts/review`: internal.

**Tested stories**
- None.

**Runtime parts**
- None.

### Point each decision citation at the split decision that holds its choice

**Calls**
- `rg "team-execution-cold-gate|drive-tries-each-story-as-a-user" plugins checks .claude/agents` finds exactly two code citations, both in `scripts/review`: `confirm_briefs` (line 1440) and `certification_failures` (line 2049). No code cites `team-execution-cold-gate`, so the split moves none of its citations. Decided by: the enumeration.
- The pass-task checks in `task_records` move, unchanged, into a new function, `check_pass_task(run, tid, rec, root_task_id)`. The function carries `# @decision: review-forks-own-pass-tasks` above its `def`, and `task_records` calls it where the `if rec.get("fork_of"):` block stood. Every citation in `scripts/tasks` stands above a `def`, so moving the check keeps that placement and points the citation at the load-bearing checks alone, not at all of `task_records`. The refusals, their messages, and `rec["issued"] = 1` stay in their order. Decided by: the file's citation placement and the work item ("the pass-task checks in `task_records` ... carry ...").
- `next_claim` gets `# @decision: claim-takes-the-most-waited-on` above its `def`. `open_waiters`, its counting helper, gets none: the claim order is decided in `next_claim`. Decided by: the work item.
- This item runs after "Hold the waiters of a short close..." (`scripts/tasks`) and "Give every driver a scratch folder..." (`scripts/review`), and it shares `scripts/review` with the history, planning, and testing groups' items. Among those, "Move each decision citation to the decision that holds its choice" rewrites other `@decision:` lines in `scripts/review`. The new decisions `one-confirm-driver-per-defect`, `claim-takes-the-most-waited-on`, and `review-forks-own-pass-tasks` land in this stage, or one before it, so `citation-resolution` passes. Decided by: the work item ("Depends on the split's deltas") and the lint.

**Changes**
- `plugins/ok/families/ok-planner/scripts/review::confirm_briefs`: changed. Its citation reads `# @decision: one-confirm-driver-per-defect`.
- `plugins/ok/families/ok-planner/scripts/review::certification_failures`: unchanged. It keeps `# @decision: drive-tries-each-story-as-a-user`.
- `plugins/ok/families/ok-planner/scripts/tasks::next_claim`: changed. It gains `# @decision: claim-takes-the-most-waited-on`.
- `plugins/ok/families/ok-planner/scripts/tasks::check_pass_task`: new, under `# @decision: review-forks-own-pass-tasks`. It holds the four pass-task refusals `task_records` makes today: no root, a root not running, a non-task or another profile, and a pass task with waits. It also marks the pass task issued.
- `plugins/ok/families/ok-planner/scripts/tasks::task_records`: changed. It calls `check_pass_task` in place of the inline block.

**Behavior changes**
- None. Every change is new code no existing user reaches.

**Tested stories**
- None.

**Runtime parts**
- None.

### Sign-off checks each delta body against each rule once, fixes once, and checks only what it changed

**Calls**
- The readers run on `ok-review`: one root task, which forks one reader per set. The merge and the fixer run on `ok-opus`. No new profile. Decided by: `plugins/ok/families/ok-planner/scripts/tasks::cmd_claim`, which prints `task: <id>` before `--- prompt ---`, so a registered prompt sits after the point where two agents' contexts differ and is never a cross-agent cached prefix; `decision:sign-off-runs-on-the-task-tracker`; `decision:review-forks-own-pass-tasks` and `skills/converge/prompts/sprint-review.md`, the suite's one shape for several readers sharing one reading (`.claude/rules/plumbline-coding.md` rule 2); `agents/ok-review.md`, whose tools list holds no Edit, so a reader cannot edit the sprint; `scripts/review::merges` (`--agent` `ok-opus`) and `review fixes`, which file `/converge`'s merge and fix tasks on `ok-opus`. The rejected alternatives are a lean profile with the rules in its body (a new vendored profile that true-up writes) and `ok-opus` readers with the rules in their registered prompt (read uncached by every reader).
- One reader records every rule's verdict for every body in its set; the rules are not split by lens. Decided by: coverage, since a verdict per body and rule already shows what each rule covered, which is all a lens split bought; cost, since a lens split reads each body, its live file, and every artifact it cites once per lens, and claim grounding reads the repository once per claim; and the ruling, which has the fixer run "the same checklist", so one checklist serves the readers and the fixer.
- A set holds at most ten bodies. Bodies that cite each other, amend one artifact, or amend artifacts that cite each other stay in one set. Every docspec delta and the surface intent delta sit in one set, since reference coverage reads them together. A retirement delta carries only its heading, so it gets no set and no verdict. Each citer's `cross-references` verdict reports a citation of the retired artifact. Decided by: `skills/_shared/dispatch-discipline.md::{{DISPATCH-DISCIPLINE}}` ("Group ~10 related items per agent") and `skills/plan-sprint/SKILL.md` section 9 step 2 (groups of up to ten work items, related items kept together), under rule 2. The number stays in the skill text, as both siblings keep theirs. The ruling leaves no sign-off setting, and a configuration key would restore the settings work item the amendment deleted.
- The checklist table, by the kind of body:
  - concept, story, decision, subject, practice: `self-containment`, `current-state-only`, `form` (the kind's form section), `grounding`, `cross-references`, `agreement`, `prohibitions`. For a subject, `self-containment` skips `## How to find them`.
  - docspec and surface intent: `current-state-only`, `form`, `grounding`, `cross-references`, `agreement`, `prohibitions`, `reference-coverage`.

  Decided by: the reviewer file's sections, and the scope of `{{SELF-CONTAINMENT-RULE}}`, which binds every kind except a docspec and the surface intent, and exempts a subject's `## How to find them`.
- The new `agreement` rule: a body contradicts no body in scope and no live artifact it cites or amends. For an amendment, read against its live artifact, a claim it introduces and anything it silently drops are findings. Decided by: the work item, and the reviewer file's `[REVIEW SCOPE]` note ("catch a claim it introduces and anything it silently drops"), which moves into the rule because the scope note goes.
- A body is a delta's final-form body, inline or in the sidecar. A live file is the input to `agreement` and is not checked as a body of its own. The body replaces the artifact whole, so a violation already standing in the live file is a verdict on the body that carries it. Decided by: `{{CORPUS-DELTA-FORM}}`, `decision:final-form-deltas`, and the reviewer's "Pre-existing violations in files within scope are in scope".
- The run: `.ok-planner/bin/tasks init <name>-sign-off --file .ok-planner/sprints/<name>-sign-off.jsonl`. Where that file stands, as in a resumed session or a later amendment, run `tasks use` on it instead. Either way, register again `ok-review` and `ok-opus`, the item states, and the prompts. The session resolves each block's transclusions itself. It writes `{{DESIGN-DOC-COMPLIANCE-RULES}}` to `.ok-planner/sprints/<name>-sign-off-rules.md`, and the root, read, merge, and fix blocks to `.ok-planner/sprints/<name>-sign-off-<role>.md`, with `[SPRINT PATH]` and `[RULES PATH]` filled in. It registers each with `tasks prompt register sign-off-<role> <path>`. Decided by: `skills/plan-sprint/tests.md` "The planning run", which notes that `review prompt` reads only the review estate's prompts, so the session resolves each token and writes the prompts beside the sprint; and `skills/plan-sprint/sprint-document.md`'s archive step, which moves every `<sprint-name>-*` file with the sprint.
- The rules exist once, in the rules file. The root reads the file, so every fork inherits it. A reader the drain reissues cold, the merge, and the fixer each read it. The reader prompt names the file and holds no copy of the rules. Decided by: `skills/converge/prompts/sprint-pass.md` "Your reading" (a fork reads nothing shared again, and a fresh agent reads what the root read), and `decision:sign-off-runs-on-the-task-tracker`: a reader prompt that transcluded the rules would print them again after each fork's task id.
- Pools: `tasks config set item_states '{"verdicts": ["passes", "fails"], "findings": ["mechanical", "judgment", "fixed", "kept", "unsettled"], "gaps": ["open", "filled"], "prohibitions": ["open", "listed", "duplicate", "removed"]}'`.
  - A verdict carries `body` (the delta heading), `rule`, and `set`. A `fails` verdict also carries `class=mechanical|judgment`, and its body holds the record the reviewer's "How to scan" lists.
  - A finding carries `bodies`, `folds` (the verdict ids it folds), `rule`, and, for a judgment, `settled`, which the session writes.
  - A prohibition carries `body`, `sentence`, and `reason`, the stated reason or `no reason recorded`.

  Decided by: the reviewer file's "How to scan" record and its "Suggested prohibitions" rule as they stand, and `/converge`'s setup step 5, which declares the pools at the run's open.
- Every task and item of the first checklist carries the key `sign-off`. Each later checklist an amendment sends takes its own key, `amend-<n>`, after a `tasks round start`. Decided by: `scripts/tasks::consumed_items`, which selects a task's items by its key, not by round. Without its own key, a later merge would fold every earlier verdict again.
- Settled findings: a set's brief lists the findings already settled on its bodies, the owner's answers and the session's calls from an earlier checklist, as `[SETTLED]` lines. Where a pair's only failure is a listed settlement, the reader records `passes` and names the settlement. A violation in text written after the settlement is a new failure. The first checklist passes `none`. Decided by: the reviewer's `[SETTLED]` rule as it stands, kept so that an amendment's checklist does not walk the owner again over a finding the owner already answered.
- `[STATED]` goes into each set's brief, holding the lines for that set's bodies. The fixer's brief holds every line. Decided by: a cold reissued reader must hold its set's stated prohibitions without the root's context, and `[STATED]` changes as the draft changes, so it cannot be filled into the prompt file once, at registration.
- The root's brief holds one block per set: its number, each body with its kind, its path (or `inline`), and the live file it amends; then its `stated` lines and its `settled` lines. The root files each block whole as the brief of that set's reader task. Decided by: `skills/converge/prompts/sprint-review.md`'s filing shape (`tasks file ... --fork-of <task> --brief - <<'EOF'`), so that a reissued reader holds its set.
- The root forks every set, however few, and an amendment's checklist files one root too. The root prompt says that `{{FORK-PER-ITEM-RULE}}`'s one-item clause does not apply. Decided by: `decision:sign-off-runs-on-the-task-tracker` ("forks one reader per set"), and `skills/converge/prompts/sprint-review.md` ("Fork every pass, however few"). A reader task per set keeps every verdict under a reader task the merge's brief names, and lets a reissue reach a set alone.
- Gaps: before it folds anything, the merge checks each set's pairs against the checklist table. Where a pair has no verdict, the merge records one `gaps` item per missing pair, closes `partial` with the result `gaps: <n>`, and folds nothing. The session then files one reader task per set with a gap, with no fork (`--agent ok-review --prompt sign-off-read`) and a brief naming the set's bodies and the missing rules. It drains, then refiles the merge once with `tasks refile <merge task>`. The refiled merge marks each gap a verdict now covers `filled` and folds everything. Each gap still `open` goes on the Approval list. Decided by: `decision:sign-off-finds-then-fixes-once` ("it goes back to a reader once"), and `/converge`'s merge rule, which refiles a merge once.
- A task that closes `partial`, `blocked`, or `disputed`, other than the merge's gap close, is refiled once with `tasks refile`. A second such close stays as it closed. The session names it to the owner, and each pair of a set no reader recorded becomes a `gaps` item on the Approval list. A reader task a fork left open is reissued by the drain, as its `waiting ... fork-of` line says. Decided by: `skills/discover-design/SKILL.md` section 2's settle rules and `skills/_tasks/drain.md` (rule 2).
- The judgment walk: the session lists `tasks item list --pool findings --key <key> --state judgment --json`, walks with the owner only the findings `{{OWNER-QUESTION-TEST}}` sends there, and settles every other finding as a call. It records each answer or call with `tasks item set <id> --field settled="<the owner's answer, or the call and what decides it>"` before it files the fixer. Decided by: the decision's Choice, and section 7 as it stands ("settle every other one as a call the rules decide, and list it at Approval").
- One fixer task per checklist: `tasks file --role sign-off-fix --prompt sign-off-fix --agent ok-opus --key <key> --consumes findings:mechanical findings:judgment prohibitions:listed --files <the sprint> <its sidecar folder> --brief - <<'EOF' <[STATED]> EOF`. The sidecar folder is named whole because a `reference-coverage` fix drafts a new docspec body there. Decided by: the ruling ("the fixer"), and because findings in different sets cite each other's bodies, so one fixer checks every body changed and no two fixers hold one body.
- The fixer stages nothing. It closes with `--sites`, naming each body it changed. Decided by: `{{PLANNING-HANDOFF}}`, under which the planning session's files under `.ok-planner/` stay uncommitted until execution's base step, and the opus profile's "Follow the prompt". The fixer's role is not `fix`, so `swept_roles`, which this run never sets, asks nothing of it.
- The fixer's work:
  - For each finding, it changes only the passage the finding cites. It applies a judgment finding's `settled` answer, and sets the finding `fixed` where it changed text, `kept` where the settlement keeps the text, and `unsettled` where it cannot apply it. A judgment finding with no `settled` field is `unsettled`: the fixer decides nothing that belongs to the owner.
  - A `prohibitions` finding with `no reason recorded`: the fixer writes the harm the sentence guards against into the prohibition item's `reason`, or removes the sentence and sets the item `removed`.
  - It then runs the checklist on each body it changed or drafted, records a `verdicts` item per pair with `--field check=fix`, fixes each failure in the same pass at the passage the failure cites, and records each failure it cannot settle as a `findings` item at `unsettled`.

  Decided by: the decision's Choice, and the reviewer's "Suggested prohibitions" rule as it stands, which reads "give the harm it guards against, or remove the sentence".
- The Approval list holds: every `findings` item at `unsettled`; every `gaps` item at `open`; each call the session wrote on a judgment finding, with what decides it; and the `prohibitions` items at `listed`, each with its body and its reason. Decided by: the decision's Choice and section 13 as it stands.
- An amendment after sign-off (section 11's kickback, section 13's relevance pass, a dropped prohibition, an owner's change at approval) runs section 7's steps from the sets on, under key `amend-<n>`. Its scope is the amended body and each body that cites it. The session finds the citers with `rg` over the sprint and its sidecar for the slug, in its `see also: <slug>` and `<kind>:<slug>` forms. Decided by: the decision's Choice ("the checklist for its body and for each body that cites it").
- Section 7 opens with a precondition: where `.ok-planner/bin/tasks` or a profile under `.claude/agents/` is missing, say that `/ok` materializes it, and stop. Decided by: `skills/converge/SKILL.md` "Preconditions" and `skills/_tasks/drain.md` "Preconditions".
- Every drain uses the drain loop at `.claude/skills/_tasks/drain.md` under its default cap. The forks the root starts fall outside that cap, as the forks of sprint certification's review do. Decided by: `skills/converge/SKILL.md` sprint mode step 1.
- Shared files:
  - `plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md` is also changed by "Out-of-band work changed after Reconcile..." (sections 3 and 13), "A defect the owner picks..." (Frame, section 13, Terminal step 1), "Reconcile from the closed-record ledger", and "Name the closed-issue file in every skill and the administration". Section 13 is shared, so chain those stages.
  - `skills/_shared/design-doc-compliance-reviewer.md` is also changed by "Name the closed-issue file in every skill and the administration" (its out-of-scope list, which this item moves into `{{DESIGN-DOC-COMPLIANCE-RULES}}`). Chain the two stages.
  - `scripts/ok-planner-cheatsheet.md` and `scripts/ok-planner-CLAUDE.md` are also changed by "The intake rules say a taken defect is fixed by certification" and "Describe the write-only archive..." in other paragraphs. Chain those stages.
  - The shared-file notes other items carry for the deleted "Sign-off's hunt settings come from the project's configuration" (for `admin/true-up`, `admin/ADMINISTRATION.md`, `docs/plumbline-cheatsheet.md`, `scripts/ok-planner-cheatsheet.md`, and `scripts/ok-planner-CLAUDE.md`) lose that item.

**Changes**
- `plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md::## 7. Sign-off`: changed, rewritten in this order:
  1. The precondition, as the calls say.
  2. Open or resume the sign-off run. Register `ok-review` and `ok-opus`, declare the pools, write the rules file and the four prompt files, and register the prompts.
  3. Cut the bodies into sets, as the calls say.
  4. `tasks round start`, then file the root: `tasks file --role sign-off-root --prompt sign-off-root --agent ok-review --key <key> --brief - <<'EOF' <one block per set> EOF`. Drain, and settle each task as the calls say.
  5. File the merge: `tasks file --role sign-off-merge --prompt sign-off-merge --agent ok-opus --key <key> --consumes verdicts:* prohibitions:open --brief "<each set: its bodies and their kinds>"`. Drain, and handle gaps as the calls say.
  6. The judgment walk and the calls.
  7. File the fixer, and drain.
  8. Gather the Approval list from the run's items.
  9. The amendment rule, which every later "goes back through the compliance review" points to: steps 3 to 8 over the amended body and each body that cites it, under key `amend-<n>`.

  The paragraph on grounding ("This review is the only point at which a delta's claims are checked for truth…") stays. "Re-dispatch until a round raises no unsettled finding." goes, and so does every `[SETTLED]` sentence about re-dispatch.
- `plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md::## 11. The owner's judgments` (the kickback bullet): changed. "An amended delta goes back through the compliance review." becomes "An amended delta gets section 7's checklist, with each body that cites it."
- `plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md::## 13. Approval`: changed.
  - The three clauses that send a delta "back through the compliance review" each send it to section 7's checklist, with each body that cites it: the relevance pass's amended delta, the dropped prohibition, and the owner's change at approval.
  - "Present the suggested prohibitions from the last compliance round" becomes "the suggested prohibitions the sign-off merge listed".
  - Beside the calls, it lists each finding left `unsettled`, each gap left `open`, and each call the session wrote on a judgment finding.
- `plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md::## 14. Terminal` (the closing paragraph's list of what the session writes): changed. It adds the sign-off run beside the sprint, `<sprint-name>-sign-off.jsonl`, with its rules file and its prompts, `<sprint-name>-sign-off-*.md`.
- `plugins/ok/families/ok-planner/skills/_shared/design-doc-compliance-reviewer.md`: changed throughout.
  - The header and "How consumers use this file": the consumers are the sign-off run's root, reader, merge, and fix tasks. The session writes the rules block to a file and registers the four prompts, each with its transclusions resolved.
  - "How to substitute `[REVIEW SCOPE]`": removed. In its place, "The set block" gives the block form the root's brief holds and each reader task's brief carries.
  - "How to substitute `[SETTLED]`" and "How to substitute `[STATED]`": changed. Each fills the lines of one set's block, and the fixer's brief holds every `[STATED]` line.
  - `{{DESIGN-DOC-COMPLIANCE-REVIEWER-PROMPT}}`: removed. No file outside this one names it (`rg` over `plugins/`).
  - `{{DESIGN-DOC-COMPLIANCE-RULES}}`: new. It holds the current prompt's out-of-scope list, "Rules to enforce", each form section, "Reference coverage", "Claim grounding", "Cross-reference integrity", and "Suggested prohibitions", a new `### Agreement` section, and `### The checklist`. The checklist gives the table from each kind to its rules, the `tasks item add --pool verdicts` form for `passes` and for `fails`, the mechanical and judgment class definitions from "How to scan", and the settlement rule. "Anti-padding" closes the block.
  - `{{DESIGN-DOC-COMPLIANCE-ROOT-PROMPT}}`: new, as `Task prompt (profile ok-review):`. It holds `{{FORK-PER-ITEM-RULE}}` and `{{READ-ONLY-REVIEWER-RULE}}`, then "Read once": `[RULES PATH]` whole, `.ok-planner/practice-definitions.md` where a set holds a subject or a practice, and the `## Intent` and delta headings of `[SPRINT PATH]`. Then it files one `sign-off-read` task per set, forked from its own task, with the set's block as the brief. It closes with each reader task in its result, says the one-item clause of the fork-per-item rule does not apply, and forks with the fork prompt `sprint-review.md` uses. Its final text is its `closed` line and the whole output of `tasks next`.
  - `{{DESIGN-DOC-COMPLIANCE-READER-PROMPT}}`: new, as `Task prompt (profile ok-review):`. It holds `{{READ-ONLY-REVIEWER-RULE}}`. "Your reading": a fork reads nothing shared again, and a fresh agent reads `[RULES PATH]` whole, and `.ok-planner/practice-definitions.md` where needed. The reader then reads each body of its set whole, the live file it amends, and each artifact it cites. It records one verdict per pair the checklist table gives, and one `prohibitions` item per forbidding sentence. Before it closes, it lists its own verdicts and records each missing pair. It closes `done` with the result `<bodies> bodies, <verdicts> verdicts, <fails> failures, <prohibitions> prohibitions`.
  - `{{DESIGN-DOC-COMPLIANCE-MERGE-PROMPT}}`: new, as `Task prompt (profile ok-opus):`. It holds `{{LEAF-AGENT-RULE}}` and `{{READ-ONLY-REVIEWER-RULE}}`, and reads `[RULES PATH]`. It handles the coverage check and its `gaps` close, as the calls say. It folds the `fails` verdicts that name one passage into one `findings` item, at `mechanical` or `judgment` by the rules' class definitions, with `folds` and `bodies` set. It sets each prohibition `listed` or `duplicate`, and closes `done` with the counts.
  - `{{DESIGN-DOC-COMPLIANCE-FIX-PROMPT}}`: new, as `Task prompt (profile ok-opus):`. It holds `{{LEAF-AGENT-RULE}}`, reads `[RULES PATH]`, and does the fixer's work the calls describe. It closes with `--sites` and stages nothing.
  - Each new block has a `### {{…}}` heading, so `checks/token-resolution` resolves it.
- `plugins/ok/families/ok-planner/agents/ok-review.md` (frontmatter `description`): changed. It names the sign-off review's root and readers beside sprint certification's review and its pass tasks. The body stays: it already covers a root that forks per its prompt and a reader that records into the run's pool.
- `plugins/ok/families/ok-planner/scripts/ok-cheatsheet.md::## Subagent models`: changed. "the review profile forks so the passes of a sprint review share one reading of the change" adds "and the readers of a sprint's sign-off share one reading of the review's rules".
- `plugins/ok/families/ok-planner/scripts/ok-planner-cheatsheet.md` ("The task tracker" profile list) and `plugins/ok/families/ok-planner/scripts/ok-planner-CLAUDE.md` ("The task tracker" profile list): changed. "`ok-review`, the forking profile of sprint certification's review" becomes "`ok-review`, the forking profile of sprint certification's review and of the sign-off review's readers".
- `plugins/ok/families/ok-planner/CLAUDE.md` (the layout line for `skills/_tasks/drain.md`): changed. It names `/plan-sprint`'s sign-off among the drain loop's readers.

**Behavior changes**
- **B901** `plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md::## 7. Sign-off`. Before: the session dispatches one compliance reviewer over the whole draft scope, fixes the findings itself, and re-dispatches with `[SETTLED]` until a round raises no unsettled finding. After: the session opens a sign-off run beside the sprint. One root on `ok-review` forks one reader per set of at most ten bodies, and each reader records a verdict per body and rule. One merge on `ok-opus` folds the failures, a gap goes back to one reader once, and the owner walk and the calls follow. One fixer on `ok-opus` fixes each finding at its passage and runs the checklist on each body it changed. The checklist never runs over the whole sprint a second time, and no cap or threshold stops a step. Users: in the release: the owner in a `/plan-sprint` session, and the vendored copy true-up writes in the same release. Across the trued-up projects boundary: no one. Vendored skill content does not cross it (only skill names and verbs do), and a planning run in progress is not across it. Ruling: rewrite.
- **B902** `plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md::## 11` and `::## 13`. Before: a kickback amendment, an amended delta after the relevance pass, a dropped prohibition, and an owner's change at approval each send the delta back through the full compliance review, and Approval presents the last round's prohibitions. After: each runs section 7's checklist over the amended body and each body that cites it, then the merge and the fixer, under its own key. Approval presents the merge's listed prohibitions, the unsettled findings, the open gaps, and the calls on judgment findings. Users: in the release: the planning session and the owner at Approval. Ruling: rewrite.
- **B903** `plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md::## 14. Terminal` and the files beside the sprint. Before: planning writes no task run, and the files beside a sprint at approval are the sprint, its sidecar, and the groups file. After: planning also writes `<sprint-name>-sign-off.jsonl`, `<sprint-name>-sign-off-rules.md`, and `<sprint-name>-sign-off-{root,read,merge,fix}.md`, and the tracker's pointer under `.ok-planner/.cache/` names the sign-off run when planning ends. Users: in the release:
  - The sprint archive step in `skills/plan-sprint/sprint-document.md` moves every `<sprint-name>-*` file, these included.
  - `{{PLANNING-HANDOFF}}` leaves files under `.ok-planner/` uncommitted.
  - Execution's "Open the run" step always runs `tasks init` or `tasks use` on `<sprint-name>-run.jsonl`, so the pointer moves.
  - `scripts/review::sprints_closed_since` skips an archived `.md` that carries no `closed:` stamp.
  - `admin/true-up::live_sprints` lists every `.md` under `sprints/`, so `sprint_transforms` reads the prompt files as it already reads `<sprint-name>-build.md` and the test planning prompts.

  Across the trued-up projects boundary: an approved sprint not yet in execution gains no file, since only planning writes these. The run log format is unchanged. Ruling: rewrite.
- **B904** `plugins/ok/families/ok-planner/skills/_shared/design-doc-compliance-reviewer.md::{{DESIGN-DOC-COMPLIANCE-REVIEWER-PROMPT}}`. Before: one `Agent (general-purpose, model: opus)` prompt takes `[REVIEW SCOPE]`, `[SETTLED]`, and `[STATED]`, checks every rule over the whole draft, and returns findings and prohibitions as markdown. After: the block is gone. The rules block and four task prompts replace it. A reader records a `verdicts` item per body and rule and a `prohibitions` item per forbidding sentence, over one set. The merge and the fixer record `findings` and `gaps` items. Users: in the release: `plan-sprint/SKILL.md` section 7, its one consumer (`rg` over `plugins/` finds no other). Ruling: rewrite.
- **B905** `plugins/ok/families/ok-planner/agents/ok-review.md` (`description`), `scripts/ok-cheatsheet.md`, `scripts/ok-planner-cheatsheet.md`, `scripts/ok-planner-CLAUDE.md`, and `CLAUDE.md`. Before: each names the review profile as sprint certification's alone, and the family's layout line names five readers of the drain loop. After: each also names the sign-off review's readers, and the layout line names `/plan-sprint`'s sign-off. Users: in the release: every session and agent of a trued-up project, which loads the materialized rules files and the vendored profile from the same true-up. Across the trued-up projects boundary: the profile's name and the rules files' names are unchanged, and only those cross it. Ruling: rewrite.

**Tested stories**
None.

**Runtime parts**
None.

### A defect the owner picks joins the sprint's defect list, not its work items

**Calls**
- Each line of `## Defects` reads `` - `<issue id>`: `<site as path:function>` — <harm> ``. The parsers of the next two items read the first backticked token of each `- ` line as the id. The template states the form. Decided by: the work item ("one line per issue with its id, its site, and its harm") and the need for one line form that `review backlog --sprint` and `review certified` both read.
- `## Defects` sits after `## Work items` and before `## Tests` in the template. `review`'s `section_lines` stops at the next `## ` heading outside a fence, so `## Work items` parsing is unaffected. True-up's live-sprint pass brings only "How to execute this sprint" and "Completion contract" current, so the new section needs no retired line. Decided by: the template's order and ADMINISTRATION.md "Live sprints".
- Frame still lists every open defect issue, including one another live sprint's `## Defects` names. No mark holds a listed issue. Decided by: `decision:taken-defects-fixed-by-certification`, whose Alternatives reject a hold mark.
- Section 1's vocabulary line ("Issues move from the first to the second by promotion, one-way") gains one sentence: a defect issue the sprint lists is not promoted, and stays in the intake. Decided by: the work item ("Terminal does not promote a taken defect") and the same file's rule that a definition is restated nowhere else.
- Shared files: `plan-sprint/SKILL.md` (see the first item) and `plan-sprint/sprint-document.md`, which the next three items, the execution-order item, "Name the build role as held…", and "Write a sprint's bookkeeping before its archive move" also change. Chain every stage on `sprint-document.md`.

**Changes**
- `plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md::## 2. Frame` ("Offer the defect issues"): changed. The owner picks which defect issues the sprint takes. Each one goes under the sprint's `## Defects`, one line in the template's form, and gets no work item, no code planning, and no test scope. Sprint certification fixes each one. The rest stay for the next `/converge`.
- `plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md::## 2. Frame` (the counts line): changed. "2 of 4 defect issues picked" becomes "2 of 4 defect issues taken for certification to fix".
- `plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md::## 1 Vocabulary` (line 32): changed, as the call says.
- `plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md::## 13. Approval`: changed. The presentation includes the `## Defects` list, one line per issue, and says that sprint certification fixes each one.
- `plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md::## 14. Terminal` step 1: changed. "the ruled and defect issues pulled in at Frame" becomes "the ruled issues pulled in at Frame". A sentence says that each defect issue under `## Defects` is not promoted: it stays open with no `sprint` stamp, and the certification of this sprint takes it up. "Every promoted id also appears in the sprint's `## Intent` list" stays.
- `plugins/ok/families/ok-planner/skills/plan-sprint/sprint-document.md::{{SPRINT-DOCUMENT-TEMPLATE}}` (`## Intent`): changed. "List the ids of the issues promoted into this sprint" stays, and a sentence says that the defect issues the sprint takes go under `## Defects`, not here.
- `plugins/ok/families/ok-planner/skills/plan-sprint/sprint-document.md::{{SPRINT-DOCUMENT-TEMPLATE}}` (`## Defects`): new section, placed after `## Work items`, in the template's angle-bracket guidance style. It holds one line per defect issue the owner took at Frame, in the line form above. The section is omitted where the sprint takes none. It states that sprint certification takes up each listed issue as a report, fixes it with the sprint's other defects, and its owner list closes each fixed one.

**Behavior changes**
- **B407** `plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md::## 2. Frame`. Before: a picked defect issue joins as a ruled issue, and its generated recommendation becomes a work item, which code planning plans and a build stage lands. After: it becomes one `## Defects` line, with no work item, code planning, or test scope. Users: in the release: the owner, code planning (which plans only work items), and sprint certification (next item). Ruling: rewrite.
- **B408** `plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md::## 14. Terminal`. Before: Terminal stamps a picked defect issue with `issues promote`, and the archive step closes it `promoted`. After: the issue stays open and unstamped, and the certification's owner list closes it `fixed` or routes it. Users: in the release: the archive step (`issues list --sprint` no longer lists taken defects, so it closes none), `review backlog` (which still skips a record whose `sprint` is set), and Frame (which still leaves a stamped record alone). Across the trued-up projects boundary: the intake records (stored state) of defect issues an earlier release promoted, and approved sprints not yet in execution that carry such defects as work items. Ruling: preserve (call). Records already stamped keep their `sprint`, every reader treats them as now, and the archive step closes them `promoted`. Nothing changes for an earlier sprint's work items. Decided by: the stamped-record rules in Frame and `cmd_backlog`, which this sprint leaves as they stand.

**Tested stories**
None.

**Runtime parts**
None.

### Sprint certification fixes the defect issues its sprint lists

**Calls**
- The listed reports carry the area `backlog`, as `defects` mode's reports do, so `review merges --source backlog` files their merges and the merge prompt's "The backlog's reports" judges them. That section applies no scope test, so a listed report counts within the sprint's scope wherever its site lies. `MERGE_SOURCES` stays as it stands. Decided by: the work item ("as `defects` mode takes up the backlog"; "counts each such report within the sprint's scope wherever its site lies") and the existing source split.
- In sprint mode, the merge step drains the backlog merges first, then files `--source sprint` and `--source drive`. A `sprint` brief's merge reads every defect with an `issue` field beside its own areas' defects. A pass, noticed, or check report on the same flaw as such a defect settles `merged` onto that defect, whatever its area, and adds no defect. Suite reports keep their own rule ("never folded onto another defect"). The order matters because `file_source_merges` chunks reports by count, not by files, and merges drain in parallel. Draining the backlog first puts every listed defect on the list before any pass report is judged. Decided by: the work item ("folds a pass's report on the same site into it"), and rule 3 (no check-then-write race across parallel merges).
- `review backlog --sprint <path>` reads the sprint through `resolved_sprint`, as `sprint_stories` and `cmd_deltas` do, so the ledger item's narrowing of that helper to `.ok-planner/sprints/` covers this verb too. It reads `## Defects` through `section_lines`. Decided by: rule 2, and rule 6 (import, never copy).
- A listed id stands for the take-up when the live intake holds it with `category: defect` and a state in `BACKLOG_STATES` (`open`, `verified`). Every other listed id goes under `settled` with a `state` field: the live record's state, `not-defect` where its category is no longer `defect`, or `closed` where the live intake holds no record of that id. A listed issue whose problem names no editable file goes under `settled` with its `files` and `left_alone`, and its state `open` or `verified`, as `backlog_entry` reports it now. One predicate decides "stands for the take-up", and `review certified` imports it (rule 6). Decided by: the work item ("lists each listed id that no longer stands open, or that names only files the run leaves alone, under `settled`").
- The `state` field on `settled` entries is added only under `--sprint`. Without `--sprint`, the output is byte for byte as now. Decided by: preserving the drive, analysis, and defects callers.
- A `- ` line under `## Defects` with no backticked id is refused with a `ReviewError` that names the line. The session wrote the sprint, and a list that drops an issue silently would leave it unfixed with no record. Decided by: rule 4.8 (refuse at entry, with an actionable message).
- For each `settled` entry whose `state` is `open` or `verified`, the session adds its report itself, as the backlog section's two bullets say (left-alone files, or no file). It adds nothing for any other state. Decided by: the backlog section's existing handling of settled issues.
- In the owner list, every route for an item with an `issue` field already covers a listed issue: verified closes `fixed`, gone closes `answered`, stuck and left-alone turn the issue into a judgment issue, and a verified decline closes `answered`. The change is one sentence naming the sprint-mode source. Decided by: the work item ("routes every other one as it routes any defect issue a run took up").
- Shared files: `converge/SKILL.md` is also changed by "Check each round against the locks" (steps 3a.2, 3a.3, 5a, 6a, and the `suite` line) and "Name the closed-issue file…". `converge/prompts/merge.md` and `_sprint/shared.md` are also changed by "Check each round against the locks" (the T4 row and the merge's T4 bullet), "Have each test set up its own starting state", and "Write a documentation sprint's bookkeeping…". `converge/prompts/owner-list.md` is also changed by "Record a deferred verdict's issue id…" and "Name the closed-issue file…". `scripts/review` is also changed by most of the history group's items and two citation items. Chain them.

**Changes**
- `plugins/ok/families/ok-planner/scripts/review::DEFECTS_HEADING`: new constant, `"## Defects"`, beside `WORK_ITEMS_HEADING`.
- `plugins/ok/families/ok-planner/scripts/review::listed_defects(lines)`: new. It returns the ids the `## Defects` section lists, in order, from the first backticked token of each `- ` line, and refuses a bullet with none. It returns `[]` where the section is absent. It carries `# @decision: taken-defects-fixed-by-certification`.
- `plugins/ok/families/ok-planner/scripts/review::takes_up(rec)`: new predicate. It is true where `rec["category"] == "defect"` and `rec["state"] in BACKLOG_STATES`.
- `plugins/ok/families/ok-planner/scripts/review::cmd_backlog`: changed.
  - With `--sprint`, it reads the sprint's `listed_defects` and indexes the live intake (`issues.select(root)`) by id. Each listed id the predicate takes goes through `backlog_entry`. Each other id goes under `settled` with its `state`. It adds the reports in one `add_reports` write with area `backlog` and the `issue` field, as now, and prints `{"reports", "settled"}`.
  - Without `--sprint`, it runs as now.
- `plugins/ok/families/ok-planner/scripts/review::build_parser` (`backlog`): changed. It adds `--sprint` ("a sprint document: add one report per defect issue its ## Defects section lists that stands open or verified, and no other").
- `plugins/ok/families/ok-planner/scripts/review::VERB_HELP["backlog"]`: changed. It adds "or, with --sprint, per defect issue the sprint's ## Defects lists".
- `plugins/ok/families/ok-planner/skills/converge/SKILL.md` (the Find list, lines 15–17): changed. Sprint mode also takes up the defect issues its sprint lists under `## Defects` and no other defect issue. `drive`, `analysis`, and `defects` mode take up the backlog as now.
- `plugins/ok/families/ok-planner/skills/converge/SKILL.md::Setting up the run` step 1: changed. The sprint-mode shape line adds the count of defect issues the sprint lists.
- `plugins/ok/families/ok-planner/skills/converge/SKILL.md::### The backlog`: changed. The heading drops "in drive, analysis, and defects mode". A paragraph says that in sprint mode the step runs as `review backlog --sprint <the sprint's path>`, over the listed issues alone, as sprint step 2a says.
- `plugins/ok/families/ok-planner/skills/converge/SKILL.md::### In sprint mode` step 2a: new step, "The listed defect issues". It runs `review backlog --sprint <the sprint's path>` and adds each settled open or verified entry's report as the backlog section says. Where the sprint lists none, it says so in one line.
- `plugins/ok/families/ok-planner/skills/converge/SKILL.md::### In sprint mode` step 5: changed. Where the backlog holds a report, `review merges --source backlog` comes first, drained under the merge rule. Then come `--source sprint` and `--source drive`, as now.
- `plugins/ok/families/ok-planner/skills/converge/SKILL.md::## The return` (the `hunt` bullet's backlog sentence): changed. It reads "In `drive`, `analysis`, and `defects` mode, the backlog: …; in `sprint` mode, the defect issues the sprint lists: each taken up, merged, found gone, found to name only files the run leaves alone, or no longer open." The ambiguous "In either" goes.
- `plugins/ok/families/ok-planner/skills/converge/prompts/merge.md::"The backlog's reports"`: changed. One sentence says that in sprint certification these reports come from the defect issues the sprint lists, which are in the sprint's scope wherever their sites lie, so no scope test applies.
- `plugins/ok/families/ok-planner/skills/converge/prompts/merge.md::"A sprint's reports"` step 4: changed. It adds the fold onto a defect with an `issue` field, and the Read list adds "every defect with an `issue` field" for a `sprint` brief.
- `plugins/ok/families/ok-planner/skills/converge/prompts/owner-list.md::Read` (the reports bullet) and `::"Close the issues the run resolved"`: changed. One sentence says that in sprint mode the reports with an `issue` field came from the defect issues the sprint lists under `## Defects`, and each takes the routes below as any backlog report does.
- `plugins/ok/families/ok-planner/skills/_sprint/shared.md::{{SPRINT-CATALOG}}` (the scope test): changed. It adds: "A defect issue the sprint lists under `## Defects` is in the sprint's scope wherever its site lies: the owner took it into the sprint, and the certification fixes it with the sprint's other defects."
- `plugins/ok/families/ok-planner/skills/plan-sprint/sprint-document.md::{{SPRINT-DOCUMENT-TEMPLATE}}` step 12: changed. "It fixes each defect in the sprint's scope, a drive failure the sprint's change caused among them," adds "and each defect issue this sprint lists under `## Defects`,".
- `plugins/ok/families/ok-planner/admin/retired-boilerplate.json`: changed. It adds each line of step 12 as it stood at v31.1.0 that the carried template no longer holds.

**Behavior changes**
- **B409** `plugins/ok/families/ok-planner/skills/converge/SKILL.md::### In sprint mode`. Before: sprint certification reads no defect issue. After: it adds one report per listed open or verified defect issue, merges those reports first, fixes and verifies them with the sprint's defects, and the owner list closes or routes each one. Users: in the release: sprint execution step 12, `review certified` (next item), and the owner list. Across the trued-up projects boundary: an approved sprint not yet in execution has no `## Defects`, so its certification is unchanged. A sprint in execution is not across the boundary. Ruling: rewrite.
- **B410** `plugins/ok/families/ok-planner/skills/converge/prompts/merge.md::"A sprint's reports"`. Before: a pass report on the same flaw as a defect of another area becomes its own defect with `same_as`. After: on a `sprint` brief, one that matches a defect carrying an `issue` field settles `merged` onto it. Users: in the release: the fix loop (one fixer per flaw) and the owner list (one issue per flaw). Ruling: rewrite.
- **B411** `plugins/ok/families/ok-planner/skills/_sprint/shared.md::{{SPRINT-CATALOG}}`. Before: the scope test sends a defect whose code stood the same at the base to the intake. After: a listed defect issue is in scope wherever it lies. Users: in the release: the merge, the sprint passes, and the fixers, which all paste the catalog. Ruling: rewrite.
- **B412** `plugins/ok/families/ok-planner/skills/plan-sprint/sprint-document.md::step 12`. Before: step 12 names what certification fixes without the listed defect issues. After: it names them. Users: in the release: executing sessions. Across the trued-up projects boundary: approved sprints not yet in execution, whose step 12 lines true-up replaces. Ruling: migrate: true-up's live-sprint pass brings each such sprint's step 12 lines current through `admin/retired-boilerplate.json`, line for line, keeping every line the owner added (call; decided by `decision:live-sprints-brought-current-on-true-up`).

**New surface**
- `review backlog --sprint <path>`, declared in `plugins/ok/families/ok-planner/scripts/review::build_parser`: internal (the family's scripts are internal by the surface intent).

**Tested stories**
None.

**Runtime parts**
None.

### The completion contract checks that certification took up every listed defect issue

**Calls**
- The term fails for each listed id that `takes_up` (from the item above) would take, where the certification's ledger holds no report whose `fields.issue` is that id. The ledger is the reports pool, read with `tasks --file <ledger> item list --pool reports --key gate --json`, as `certification_failures` reads the defects pool. A listed issue that triage rerouted out of `category: defect` before certification, or that closed, passes, as the work item says ("still stands open … with no report"). A listed id no file holds passes the term too. `review backlog --sprint` names it under `settled` as `closed`, and the return says so. Decided by: the work item's wording, and rule 6 (one predicate for take-up and the check).
- Where no ledger stands (no return block), the term adds no failure of its own. `certification_failures` already fails the contract for that ledger. Decided by: avoiding a doubled failure for one cause.
- `review certified` prints one more line, `item 3 (defect issues): holds: <n> listed, each taken up by <ledger> or no longer open`, `holds: the sprint lists no defect issue`, or `fails`. Each failure line reads `defect issue <id> the sprint lists under ## Defects stands <state> in the intake, and <ledger> holds no report for it: the certification did not take it up; run /converge sprint <path> again, which takes it up as sprint step 2a says`. Decided by: the sibling lines `item 3 (suite)` and `item 3 (test paths)` (rule 2), and A9 (the message names the action).
- The new function carries `# @story: certify-completion` and `# @decision: taken-defects-fixed-by-certification`.
- Shared files: `scripts/review::cmd_certified` is also changed by "Keep the closed-record ledger in the review tool" (terminal from the ledger, `resolved_sprint`'s fallback dropped) and "Record a deferred verdict's issue id…" (`suite_failures`, `unfiled_deferred`, `names_site`). `sprint-document.md`'s contract and goal rule are also changed by "Write a sprint's bookkeeping before its archive move". Chain them.

**Changes**
- `plugins/ok/families/ok-planner/scripts/review::listed_defect_failures(root, sprint_lines, ledger)`: new. It returns `(line, failures)` from `listed_defects`, the live intake, and the ledger's reports, as the calls say.
- `plugins/ok/families/ok-planner/scripts/review::cmd_certified`: changed. It calls `listed_defect_failures` with the sprint's lines and the ledger `certification_failures` returns, prints the `item 3 (defect issues)` line after `item 3 (certification)`, and adds the failures to `certified_verdict`'s list.
- `plugins/ok/families/ok-planner/skills/plan-sprint/sprint-document.md::Completion contract` item 3: changed. It adds: "The run took up each defect issue this sprint lists under `## Defects`: each one the intake still holds open as a defect issue has a report in the run's ledger. A sprint with no `## Defects` section meets this term."
- `plugins/ok/families/ok-planner/skills/plan-sprint/sprint-document.md::the goal rule`: changed. It says that `review certified` checks item 3's defect-issue term too.
- `plugins/ok/families/ok-planner/admin/retired-boilerplate.json`: changed. It adds each line of item 3 and of the goal rule at v31.1.0 that the carried template no longer holds. `checks/sprint-boilerplate` must pass after the edit.

**Behavior changes**
- **B413** `plugins/ok/families/ok-planner/scripts/review::cmd_certified`. Before: `review certified` checks no defect issue. After: it prints an `item 3 (defect issues)` line and reports `SPRINT NOT COMPLETE` for each listed defect issue still open with no report in the ledger. A sprint with no `## Defects` prints `holds: the sprint lists no defect issue`, and its verdict is unchanged. Users: in the release: sprint execution steps 2, 11, and 13, the goal checker, and the `/converge` return paragraph. Across the trued-up projects boundary: sprints a project holds under an earlier release carry no `## Defects`, so their verdict does not change. Ruling: rewrite.
- **B414** `plugins/ok/families/ok-planner/skills/plan-sprint/sprint-document.md::Completion contract`. Before: item 3 and the goal rule name no defect-issue term. After: they do. Users: in the release: executing sessions and checkers. Across the trued-up projects boundary: approved sprints not yet in execution. Ruling: migrate: true-up's live-sprint pass replaces the retired lines through `admin/retired-boilerplate.json`. Such a sprint has no `## Defects`, so the new term holds for it (call; decided by `decision:live-sprints-brought-current-on-true-up`).

**Tested stories**
None.

**Runtime parts**
None.

### The intake rules say a taken defect is fixed by certification

**Calls**
- Enumeration (rule 1), with `rg` over `plugins/` for "picked into a sprint", "joins as a ruled", "reads none", "promoted" beside defect, and "Life of a defect issue":
  - `scripts/ok-planner-cheatsheet.md:280` ("A picked issue joins as a ruled issue does")
  - `scripts/ok-planner-cheatsheet.md:288` ("and sprint certification reads none")
  - `scripts/ok-planner-cheatsheet.md:301` ("A defect issue picked into a sprint closes as `promoted`, and sprint certification checks its fix")
  - `scripts/ok-planner-CLAUDE.md:494` ("A defect issue the owner picks into a sprint closes as `promoted`")
  - `scripts/ok-planner-CLAUDE.md:623` (the lifecycle summary's "and the defect issues the owner picked")
  - `skills/_shared/artifact-definitions.md:321` ({{ISSUE-DEFINITION}}: "A defect issue the owner picks into a sprint closes as `promoted`")
  - `skills/_shared/artifact-definitions.md:323` ("Life of a defect issue: filed → triaged → fixed, answered, or promoted")
  - `skills/_shared/artifact-definitions.md:423` ({{ISSUE-FILE-FORMAT}} "State moves forward only": the planner stamps `sprint` with `issues promote`; it is extended to say no planner stamps a defect issue)

  `converge/SKILL.md:17` and `:65` ("no sprint has promoted") are covered under the item above. 8 sites here. Decided by: rule 1.
- `.claude/rules/ok-planner-cheatsheet.md` and `.ok-planner/CLAUDE.md` are installed copies, which true-up rewrites from these templates. They are not edited. Decided by: the session notes.

**Changes**
- `plugins/ok/families/ok-planner/scripts/ok-planner-cheatsheet.md::Defect issues "Routing"`: changed. "A picked issue joins as a ruled issue does" becomes: a picked issue goes under the sprint's `## Defects`, stays open and unpromoted, and the certification of that sprint takes it up. "and sprint certification reads none" becomes "and sprint certification reads only the defect issues its sprint lists under `## Defects`".
- `plugins/ok/families/ok-planner/scripts/ok-planner-cheatsheet.md::Defect issues "Closing"`: changed. "A defect issue picked into a sprint closes as `promoted`, and sprint certification checks its fix." becomes: a defect issue a sprint lists closes through that sprint's certification, as any defect issue a run takes up does, as `fixed` or routed by the owner list.
- `plugins/ok/families/ok-planner/scripts/ok-planner-CLAUDE.md` (the intake section's closing paragraph): changed in the same way.
- `plugins/ok/families/ok-planner/scripts/ok-planner-CLAUDE.md` (the lifecycle summary): changed. "and the defect issues the owner picked" becomes "and the defect issues the owner picked, listed for its certification to fix".
- `plugins/ok/families/ok-planner/skills/_shared/artifact-definitions.md::{{ISSUE-DEFINITION}}`: changed. The closing sentence on a picked defect is replaced, and the life line becomes "Life of a defect issue: filed → triaged → fixed or answered."
- `plugins/ok/families/ok-planner/skills/_shared/artifact-definitions.md::{{ISSUE-FILE-FORMAT}}` ("State moves forward only"): changed. The planner stamps `sprint` on a judgment issue only. A defect issue a sprint lists stays unstamped and closes through `/converge`'s owner list.

**Behavior changes**
- **B415** `scripts/ok-planner-cheatsheet.md`, `scripts/ok-planner-CLAUDE.md`, and `skills/_shared/artifact-definitions.md` (the sites above). Before: the rules say a picked defect issue joins as a ruled issue, closes `promoted`, and that sprint certification reads no defect issue. After: they say it stays open, the certification of the sprint that lists it takes it up, and its owner list closes it `fixed` or routes it. Users: in the release: every agent that reads the rules layer, the estate note, or the transcluded issue blocks (triage, the owner list, `/plan-sprint`). True-up rewrites their installed copies in the same release. Ruling: rewrite.

**Tested stories**
None.

**Runtime parts**
None.

### Out-of-band work changed after Reconcile is reviewed before the handoff commits it

**Calls**
- The sprint's line goes at the end of `## Intent`: ``Reconciled against commit `<sha>`, tree `<tree>`.`` The tree is the id the `/plan-docs` command prints, `GIT_INDEX_FILE="$(git rev-parse --git-path ok-planner-window-index)" sh -c 'git read-tree --empty && git add -A && git write-tree'`. Reconcile writes the line on every path, an empty window or a skipped walk included, so the Approval comparison always has a base. Decided by: the work item ("the sprint carries both on one line") and `plan-docs/SKILL.md` section 2's command.
- The Approval comparison runs at the start of section 13, before the relevance pass, so the relevance pass reads any work the new batch drafts. It recomputes the tree and lists `git diff --name-only <recorded tree> <current tree> -- . ':(exclude).ok-planner'`. An empty list passes in one line. Otherwise it dispatches `{{OUT-OF-BAND-REVIEWER-PROMPT}}` over those paths, drafts each bearing change into the Reconcile batch and its one summary as Reconcile step 4 drafts it, and rewrites the line to the current commit and tree. Decided by: the work item, and rule 2 (the `/plan-docs` handoff's sibling comparison).
- `core.md`'s `{{OUT-OF-BAND-REVIEWER-PROMPT}}` changes too, though the work item does not list it. Its window names a commit range and is enumerated with `git log` and `git diff <closed-sha>`. That form cannot express "these paths, from a recorded tree to the current tree", and `git log` does not take tree ids. The prompt gains a second window form, `[<recorded tree> to <current tree>, over the paths: <paths>]`, enumerated with `git diff <recorded tree> <current tree> -- <paths>`. The test and the output stay as they stand. Decided by: the prerequisite rule (a definition the outcome needs that no work item changes) and the work item's "goes through `{{OUT-OF-BAND-REVIEWER-PROMPT}}`".
- In the handoff, for a sprint, a path outside `.ok-planner/` "matches the recorded tree" where `git diff --name-only <recorded tree> <current tree> -- <path>` prints nothing. A renamed path counts as both its paths, as the handoff counts it now. Where any listed path differs, the handoff names each one, commits nothing, and sends the session back to section 13's comparison for those paths. Decided by: the work item.
- Where that comparison finds a bearing change after the approval mark was written, the session removes the mark, presents the changed sprint, and writes the mark again on the owner's yes, as section 13 says for an owner's change. It then runs the handoff again. Terminal's promotions stay stamped, since they name the sprint's file, which stands. Where the comparison finds nothing bearing, the session rewrites the line and runs the handoff again, with no new approval. Decided by: section 13's approval-mark rule ("only after the owner's final yes").
- Shared files: `plan-sprint/SKILL.md` (above). `_sprint/shared.md::{{PLANNING-HANDOFF}}` is also changed by no other item. `plan-sprint/core.md`'s out-of-band reviewer is also changed by "Reconcile from the closed-record ledger" (the ledger baseline, no `history/` reads). Chain them.

**Changes**
- `plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md::## 3. Reconcile`: changed. A step after "Compute the window" records the commit (`git rev-parse HEAD`) and the tree, and writes them into the sprint's line. The closing line ("An empty window … passes in one line") keeps the record step.
- `plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md::## 13. Approval`: changed. It opens with the comparison the calls describe.
- `plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md::## 14. Terminal` step 4: changed. It says that for a sprint, the handoff's tree check can send the session back to section 13's comparison.
- `plugins/ok/families/ok-planner/skills/_sprint/shared.md::{{PLANNING-HANDOFF}}`: changed. A paragraph for a sprint runs before the commit proposal. It computes the current tree, checks each path outside `.ok-planner/` that `git status --porcelain` lists against the sprint's recorded tree, and proposes commits only where every such path matches. Where a path differs, it names it as changed after the last reconcile, commits nothing, and has the session run the Approval comparison again for it. The documentation sprint's paragraphs stay as they stand.
- `plugins/ok/families/ok-planner/skills/plan-sprint/core.md::{{OUT-OF-BAND-REVIEWER-PROMPT}}` (Inputs): changed, as the calls say.
- `plugins/ok/families/ok-planner/skills/plan-sprint/sprint-document.md::{{SPRINT-DOCUMENT-TEMPLATE}}` (`## Intent`): changed. It adds the line ``Reconciled against commit `<sha>`, tree `<tree>`.`` and its guidance: Reconcile writes it, and the Approval comparison rewrites it.

**Behavior changes**
- **B416** `plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md::## 3` and `::## 13`. Before: Reconcile reads the window once, and work out of band that lands after it reaches no reviewer before approval. After: Reconcile records its commit and tree in the sprint, and Approval reviews every path outside `.ok-planner/` that changed since, drafting bearing changes into the batch. Users: in the release: the owner in `/plan-sprint`. Ruling: rewrite.
- **B417** `plugins/ok/families/ok-planner/skills/_sprint/shared.md::{{PLANNING-HANDOFF}}`. Before: for a sprint, on the owner's yes, the handoff commits every path outside `.ok-planner/` the status lists. After: it commits only paths that match the sprint's recorded tree. Where one differs, it commits nothing and returns to the comparison. Users: in the release: `/plan-sprint` Terminal step 4. `/plan-docs` Terminal step 2 sees no change. Ruling: rewrite.

**Tested stories**
None.

**Runtime parts**
None.

### Execution creates the progress checklist and renders the report before any drain

**Calls**
- The test-stage filing and draining moves out of step 4 into a new step **6a**, "Run the test stages", between step 6 (the checklist) and step 7 (the drain loop). Every existing number keeps naming the step it meant:
  - Step 4 still files the build tasks and the time-control build tasks, which `plan-sprint/tests.md` cites three times as "step 4 of the sprint".
  - Steps 5 and 6 render and keep the checklist.
  - Step 7 is the drain loop and its refile rules, which 6a's drains run ("Drain with step 7's loop").
  - Steps 8–13 are unchanged.

  Renumbering 7–13 instead would rewrite every cross-reference (steps 2, 6, 11, 12, 13, and the archive section) for no gain. `3a` is the template's precedent for a lettered step. Decided by: the work item ("Every step number the section, the test planning procedure, and the converge skill cite still names the step it meant"), and rule 8.4 (don't widen).
- With 6a, `plan-sprint/tests.md` needs no edit: its "step 3a" and "step 4 of the sprint" citations still hold. `converge/SKILL.md` cites no step of the sprint's section: its numbers are its own steps and the shared drive text's. The work item lists `tests.md`, but it changes nothing there. Decided by: `rg` over both files.
- Step 3's "for step 4's speed read" becomes "for step 6a's speed read". Step 4's "a code stage refiled under step 7 needs no new `--after`" moves with the test-stage text into 6a unchanged. Step 6's "Create one entry per stage when the build tasks are filed" becomes "Create one entry per stage step 4 filed, before the first drain". Step 7 gains one opening sentence: where step 6a ran the test stages, its drains already drained the build tasks, and this step drains whatever stands ready. Decided by: the step order.
- Every line of the two boilerplate sections at v31.1.0 that the edited template no longer holds joins `admin/retired-boilerplate.json`. The builder confirms with `python3 checks/sprint-boilerplate` once every stage that edits `sprint-document.md` has landed. Decided by: ADMINISTRATION.md "Live sprints" and the project's `checks/sprint-boilerplate`.
- Shared file: `sprint-document.md` steps 3 and 7 are also changed by "Name the build role as held in sprint execution", and steps 1, 2, and the archive section by "Write a sprint's bookkeeping before its archive move". Chain them, and run the boilerplate check after the last.

**Changes**
- `plugins/ok/families/ok-planner/skills/plan-sprint/sprint-document.md::{{SPRINT-DOCUMENT-TEMPLATE}}` step 3: changed ("step 6a's speed read").
- `…::step 4`: changed. It keeps the staging and the build-task and time-control filing, through "Record each as a call…" and the resume rule for build tasks. The paragraph from "Where the run opened test stages, file them after the build tasks." through the speed read and "…files only what the run lacks." moves to step 6a. Step 4 drains nothing.
- `…::step 6`: changed, as the calls say.
- `…::step 6a`: new. It holds the moved test-stage text: `--stage write` with its `--after`, the preflight-first rule, "Drain with step 7's loop", the verify loop, `tests ports`, the sweep, the speed read, and the resume rule for test stages.
- `…::step 7`: changed (the opening sentence).
- `plugins/ok/families/ok-planner/admin/retired-boilerplate.json`: changed, as the calls say.

**Behavior changes**
- **B418** `plugins/ok/families/ok-planner/skills/plan-sprint/sprint-document.md::"How to execute this sprint"`. Before: step 4 files the build tasks and the test stages and drains, before step 5 renders the report and step 6 creates the checklist. After: step 4 files the build tasks only, steps 5 and 6 render the report and create the checklist, and step 6a files and drains the test stages. Users: in the release: executing sessions. Across the trued-up projects boundary: approved sprints not yet in execution. Ruling: migrate: true-up's live-sprint pass replaces the retired lines with the carried ones, line for line, and writes step 6a's new run of lines in place. A sprint in execution is not across the boundary (call; decided by `decision:live-sprints-brought-current-on-true-up` and `.ok-planner/release-boundaries.md` "Not across it").

**Tested stories**
None.

**Runtime parts**
None.


### Move the closed-issue file out of the archive

**Calls**
- The constant `ARCHIVE` is renamed `CLOSED` and its value becomes `.ok-planner/closed-issues.jsonl`. The local names `archive` and `archived` inside the module stay: they name no file and no message, and renaming them is wider than the item. Decided by: the work item, which changes only paths, messages, and help lines.
- The `import` flag keeps its name `--over-archived-event-log`, and only its help text changes. `admin/true-up` passes the flag by name, and the migration item, not this one, changes true-up's conversion. Decided by: rule 1 (a rename would add a site in another item's file) and the work item, which names help lines only.
- The module checks nothing under `.ok-planner/history/`, not even whether `history/issues.jsonl` still exists. A project that runs the new module before its migration sees no closed issues until true-up moves the file. True-up writes the module and moves the file in one apply. Decided by: `decision:archive-read-by-nothing` ("No skill, script, or hook reads it") and the migration item, which moves the file before every intake conversion.
- `promote` names one folder, `.ok-planner/sprints/`, through a new constant `SPRINTS`, replacing `SPRINT_DIRS`. Decided by: the work item.
- Shares `scripts/review` (the `OWNER_PATHS` table only) with the ledger item, which adds two more record paths to the same tuple. Land both in one stage, or chain them.

**Changes**
- `scripts/issues::ARCHIVE`: changed, renamed `CLOSED`, value `.ok-planner/closed-issues.jsonl`. Every user takes the new name: `read_store`, `stray_notes`, `transaction`, `live_record`'s refusal (`issue <id> is closed; its record is in .ok-planner/closed-issues.jsonl`), `cmd_import`'s `drop_events`, and `build_parser`'s description and import help.
- `scripts/issues::SPRINT_DIRS`: removed. New constant `SPRINTS = os.path.join(".ok-planner", "sprints")`.
- `scripts/issues::promote`: changed. It checks `.ok-planner/sprints/<name>` alone and refuses any other sprint with `no sprint <name> under .ok-planner/sprints/, where a sprint being planned sits`.
- `scripts/issues::store_defects`: changed messages only: `is archived twice opened %s` becomes `is closed twice in .ok-planner/closed-issues.jsonl opened %s`, and `is both open and archived opened %s` becomes `is both open and closed opened %s`.
- `scripts/issues::build_parser`: changed help. `close` reads `close an open issue, moving its record to .ok-planner/closed-issues.jsonl`. `history` reads `list closed issues, from .ok-planner/closed-issues.jsonl`. `--over-archived-event-log` reads `drop the pre-v9 event-log rows from .ok-planner/closed-issues.jsonl as the import lands; /ok's conversion of an earlier closed-issue file passes it`. The parser's description takes the new path through the constant.
- `scripts/issues::read_store`: unchanged code. It gains `# @decision: closed-issues-leave-the-live-file` and `# @decision: intake-reads-past-stray-lines`, the decisions it enforces: it drops a live line the closed-issue file holds, and keeps stray lines.
- `scripts/review::OWNER_PATHS`: changed. The second `record` tuple lists `.ok-planner/closed-issues.jsonl`.
- `.ok-planner/review/project.md`: changed. The `issues` line's `promote <id> --sprint <file>` sentence says the sprint must stand under `.ok-planner/sprints/`, and the line names `.ok-planner/closed-issues.jsonl` as the file `close` moves a record to and `history`, `show`, and `list --state closed` read.

**Behavior changes**
- **B201** `scripts/issues::CLOSED` (stored layout). Before: a close moves a record to `.ok-planner/history/issues.jsonl`, and every reader of closed records (`history`, `show`, `find`, `list --state closed`, the uniqueness check, the stray-line repair) reads that file. After: all of them read and write `.ok-planner/closed-issues.jsonl`, and the module opens nothing under `history/`. Users: in the release: `scripts/dashboard` (`GET /api/closed`, `GET /api/issue/<id>`, through `issues.history`, `issues.select`, `issues.find`), `scripts/surface-corpus` (`issues.load`), `scripts/review` (`issues.select`), and every skill and prompt that names the closed store, which "Name the closed-issue file in every skill and the administration" rewrites. Across stored state and the trued-up projects boundary: each project's committed `.ok-planner/history/issues.jsonl`. Ruling: migrate: true-up moves `.ok-planner/history/issues.jsonl` to `.ok-planner/closed-issues.jsonl` as a `DRIFT:` step before every intake conversion, in the apply that writes the new module, as "Migrate the archive's bookkeeping at true-up" builds (call, by `decision:archive-read-by-nothing` and `decision:skills-read-only-the-current-layout`).
- **B202** `scripts/issues::store_defects`, `live_record`, `build_parser`. Before: refusals and help name the archive and `history/issues.jsonl`. After: they name the closed-issue file. Users: in the release: the people and agents who read the messages; no code parses them. Across: none. Ruling: rewrite.
- **B203** `scripts/issues::promote`. Before: it accepts a sprint under `.ok-planner/sprints/` or `.ok-planner/history/sprints/`. After: it refuses the archived form. Users: in the release: `skills/plan-sprint/SKILL.md` Terminal step 1, which promotes into the sprint being planned under `.ok-planner/sprints/`. Across: none; a planning run in progress is not across the trued-up projects boundary. Ruling: rewrite.
- **B204** `scripts/review::OWNER_PATHS`. Before: `review owner .ok-planner/closed-issues.jsonl` prints `project`. After: it prints `record`. Users: in the release: the owner list's and fixers' fix line (`review owner`), `scripts/review::left_alone` callers, and `admin/true-up::caller_kind`, which skips a `record` path in the callers sweep. Across: none. Ruling: rewrite.

**Tested stories**
None.

**Runtime parts**
None.

### Keep the closed-record ledger in the review tool

**Calls**
- `review stories --sprint` and `review drives --sprint` keep taking an archived path the caller names, with no fallback from a missing live path, and keep their own resolution (I201's `live_path` does not serve `sprint_stories`); their `--sprint` help and their `.ok-planner/review/project.md` sentences say so, and `ARCHIVED_SPRINTS` stays while they use it. Only `deltas`, `approved`, and `certified` narrow to `.ok-planner/sprints/`. Decided by: B207, B303, and the owner's directed-read ruling.
- `/plan-sprint`'s Draft step (`skills/plan-sprint/SKILL.md`, the sprint path) and `/plan-docs` (`skills/plan-docs/SKILL.md`, the documentation sprint path) each pick a file name that neither the live folder nor `review closed --kind sprint` (or `--kind doc-sprint`) holds, adding a `-<n>` suffix as `/sketch` does, so a new sprint never takes a name the ledger lists and reads terminal before any work runs. Both skill files join this item's Changes. Decided by: the notes review (a reused name reads `SPRINT COMPLETE` at once) and the sibling name check in `/sketch`.
- An entry is one JSON object per line with the fields `kind`, `name`, and, for `sprint`, `doc-sprint`, and `test-sprint`, `commit`. No other field. Decided by: the work item, which names those three facts and no other.
- `name` is a file name with no `/` for every kind but `archived`, and ends in `.md` for `sprint`, `doc-sprint`, and `test-sprint`. For `archived` it is a path relative to `.ok-planner/history/`, with no leading `/` and no `..` segment. The writer refuses any other form, naming the entry. Decided by: the work item ("for `archived`, its path under the archive") and rule 4.8 (check a value where it enters).
- The commit is stored as given once `COMMIT_NAME` matches it, the way `closed:` stamps were stored, so the migration's entries and `review close`'s entries share one form. Decided by: `decision:closing-commit-baseline` and the existing `COMMIT_NAME` rule.
- The one writer is `record_closes(root, entries)`, a list, so the migration writes every entry in one atomic replace (rule 3.1). It checks the form of each entry and refuses a `(kind, name)` the ledger already lists or that the batch lists twice. It does not check the branch or the live folder: the migration records sprints that sit in the archive and commits an earlier history may hold off the branch. `cmd_close` runs the live-folder and branch checks before it calls the writer. Decided by: the work item ("A function the docs and tests tools import does each read and write") and the migration item, which calls the same writer.
- The writer holds an exclusive `fcntl.flock` on `.ok-planner/.cache/closed-records.lock`, through `issues.tasks.cache_dir(root)`, re-reads the file under the lock, and writes it whole through `issues.write_records`, the module's temp-file-then-`os.replace` writer. Decided by: rule 3.2 (a check-then-write holds a lock), rule 6 (import, never copy), and the sibling `scripts/issues::locked`.
- The reader `closed_records(root, kind=None)` uses only the standard library, because `certified_without_config` runs before `main` loads the intake module and the tracker. A missing file reads as no entry. A line that is not a JSON object, or that carries an unknown kind, no name, a commit on `sketch` or `archived`, or no commit on a committed kind, is refused with `ReviewError` naming the line number and saying that only `review close` and true-up write the file. Decided by: the existing `certified` path in `main` and the sibling `scripts/tests::read_state` refusal shape.
- `review close` and `review closed` find the project root by `.ok-planner/` and run without `.ok-planner/review/config.json`, as `certified` does. The ledger is planner estate, not review estate, and `/sketch` and `/plan-sprint` call these verbs. `main` runs them after the intake module loads and before `load_config`. Decided by: the ledger's path and the existing `certified` branch in `main`.
- `review close` requires a commit on the current branch (`COMMIT_NAME` and `is_ancestor(commit, "HEAD")`) for every kind that carries one, `test-sprint` included. It refuses `--commit` for `sketch` and `archived`. It checks the live folder only for `sprint` (`.ok-planner/sprints/<name>`) and `doc-sprint` (`.ok-planner/doc-sprints/<name>`). Decided by: the work item; `test-sprint` has no live folder in the carried release.
- `review closed` prints one line per entry, `<kind>\t<name>\t<commit or ->`, in file order. With `--json` it prints the entries as one JSON array. Decided by: the sibling `cmd_owner`'s tab-separated lines.
- A sprint the ledger lists is terminal by file name, whatever path `--sprint` gives. The terminal branch prints `item 1-3: the closed-record ledger lists <name> as a closed sprint at <commit>, which is terminal` and the `SPRINT COMPLETE` lines. It writes and removes no `-certified.txt` mark, because the file may already sit in the archive and a mark written to `.ok-planner/sprints/` would stand alone. Decided by: `decision:sprint-goal-read-from-the-repository` and `review::certified_mark`, which today writes only beside a sprint under `sprints/`.
- `closed_stamp` and `frontmatter_values` stay. The migration item reads each archived record's `closed:` stamp through the carried review tool (`admin/true-up::carried_review`). Where that item reads the stamp another way, the stage that lands second removes `closed_stamp`. `with_closed_stamp` goes with its last caller in the docs item. Decided by: rule 1.4.
- `ARCHIVED_SPRINTS` goes in the stage that removes its last users in `scripts/tests`. Decided by: rule 1.3.
- `.ok-planner/review/project.md` says "The tree has no atomic-replace helper". That stops being true once the ledger imports `scripts/issues::write_records` as one. The stage rewrites the sentence to name `scripts/issues::write_records`. Decided by: the file's rule that agents keep it current.
- `plugins/ok/families/ok-planner/CLAUDE.md` line 39 describes `scripts/review` as holding "the sprint frontmatter reading (the closed: stamp and the sprints closed since one)". "Describe the write-only archive in the estate's rules text" changes that file. That item's stage rewrites the line to name the closed-record ledger's reader and writer.

**Changes**
- `scripts/review::CLOSED_RECORDS`: new, `os.path.join(".ok-planner", "closed-records.jsonl")`. Beside it: `CLOSED_KINDS = ("sprint", "doc-sprint", "test-sprint", "sketch", "archived")`, `COMMITTED_KINDS = ("sprint", "doc-sprint", "test-sprint")`, `LIVE_FOLDERS = {"sprint": SPRINTS, "doc-sprint": os.path.join(".ok-planner", "doc-sprints")}`, and `CLOSED_RECORDS_LOCK = "closed-records.lock"`.
- `scripts/review::closed_records`: new. It reads the ledger as the Calls say, and filters by kind where one is given. It carries `# @decision: closing-commit-baseline` and `# @decision: archive-read-by-nothing`.
- `scripts/review::closed_entry`: new, `(root, kind, name)`. It returns the entry the ledger lists for that kind and name, or `None`.
- `scripts/review::record_closes`: new, the one writer, as the Calls say. It returns the entries it wrote and carries the same two citations.
- `scripts/review::cmd_close`: new verb `close --kind <kind> --name <file name> [--commit <sha>]`. It runs the checks the Calls name and calls `record_closes`. It prints `closed: <kind> <name> at <commit>`, or `closed: <kind> <name>` for a kind with no commit.
- `scripts/review::cmd_closed`: new verb `closed [--kind <kind>] [--json]`, as the Calls say.
- `scripts/review::VERB_HELP`: changed. It gains `close` and `closed`. The `certified` entry adds that a sprint the closed-record ledger lists is terminal by file name. `build_parser` registers both verbs, `--kind` taking `choices=CLOSED_KINDS`.
- `scripts/review::main`: changed. `close` and `closed` resolve the root by `PLANNER_ESTATE` and run after the intake module loads and before `load_config`.
- `scripts/review::resolved_sprint`: changed, replaced by I201's `live_path(root, path, SPRINTS, "sprint")`. It takes a sprint under `.ok-planner/sprints/` only, and the `ARCHIVED_SPRINTS` fallback goes. Callers: `sprint_stories` (`review stories`, `review drives --sprint`), `cmd_approved`, `cmd_deltas`, `certified_without_config`, `cmd_certified`.
- `scripts/review::certified_without_config`: changed. It takes `os.path.basename(args.sprint)` and calls `closed_entry(root, "sprint", name)` first. A listed sprint takes the terminal branch the Calls describe. Otherwise the path must stand under `.ok-planner/sprints/`, and the stop-record check runs as now. Otherwise it refuses: `no sprint at <path> under .ok-planner/sprints/, and the closed-record ledger lists no closed sprint <name>`. It reads no file under `.ok-planner/history/`.
- `scripts/review::certified_verdict`: changed. The closing line reads `Archiving, committing, and the closed-record ledger entry are the owner's acts, not goal terms.` A new sibling, `terminal_verdict(sprint, entry)`, prints the terminal lines and exits 0 without calling `certified_mark`.
- `scripts/review::sprints_closed_since`: changed. It reads `closed_records(root, "sprint")` and returns `[{"name": ..., "commit": ...}]`, in ledger order, for each entry whose commit differs from the stamp and descends from it (`is_ancestor(root, stamp, commit)`). It opens no file. The shape change lands in the docs stage, with its one caller.
- `scripts/review::with_closed_stamp`: removed, in the docs stage, with its last caller.
- `scripts/review::ARCHIVED_SPRINTS`: removed, in the tests stage, with its last users.
- `scripts/review::OWNER_PATHS`: changed. The second `record` tuple lists `.ok-planner/closed-records.jsonl` and `.ok-planner/test-plans/`.
- `scripts/review::build_parser`: changed help. The `--sprint` help of `stories`, `drives`, `deltas`, and `approved` reads `a sprint document at its .ok-planner/sprints/ path`. The `certified` help reads `the sprint document at its .ok-planner/sprints/ path; a sprint the closed-record ledger lists is terminal by its file name`.
- `.ok-planner/review/project.md`: changed. The `review` line's `certified --sprint <path>` sentence says the verb checks the closed-record ledger first, by file name, and then the stop record. The `approved`, `stories`, and `drives` sentences say each takes the sprint at its `.ok-planner/sprints/` path, not archived. The line gains `close --kind <kind> --name <file name> [--commit <sha>]` and `closed [--kind <kind>] [--json]` with their refusals. The helpers paragraph names `scripts/issues::write_records` as the atomic-replace helper.

**Improvements**
- **I201** `scripts/review::live_path` (new), replacing `scripts/review::resolved_sprint`, `scripts/tests::resolved_sprint`, and `scripts/docs::resolved_sprint`. Maintenance cost: one rule, "a sprint path stands under its live folder", is built three times, and this sprint changes all three copies to the same new rule. Afterward: `live_path(root, path, folder, noun, exists=True)` makes an absolute path relative to the root and normalizes it. It refuses a path outside `<folder>/` or not ending in `.md` (`<path> is not a <noun> under <folder>/`), and, with `exists`, one the tree does not hold (`no <noun> at <path>`). It raises `ReviewError`. Review calls it with `SPRINTS` and `"sprint"`. Tests calls it with the same arguments, passing `exists=False` where it passes it now (`cmd_plan`, `cmd_groups`). Docs calls it with `DOC_SPRINTS` and `"documentation sprint"`. Each tool's three-line copy goes. `scripts/tests::main` and `scripts/docs::main` already catch `review.ReviewError`.

**Behavior changes**
- **B205** `scripts/review::certified_without_config`, `cmd_certified`. Before: an archived path whose sprint carries a `closed:` stamp is terminal, a live path is checked, and a live path with no file falls back to the archived one. After: a sprint the closed-record ledger lists by file name is terminal from the ledger, whichever path names it. A sprint the ledger does not list is checked only at its `.ok-planner/sprints/` path, and the verb refuses any other path. Users: in the release: the sprint template's steps 2 and 13 and its goal rule, `skills/converge/SKILL.md` sprint mode, `skills/_sprint/shared.md::{{PLANNING-HANDOFF}}`'s goal line, and `admin/true-up::EARLIER_CERTIFIED_MARK`'s text, each of which passes a live path. Across stored state and the trued-up projects boundary: every sprint an earlier release archived with a `closed:` stamp. Ruling: migrate: true-up's migration writes one `sprint` entry per archived sprint from its `closed:` stamp, so `review certified` on that sprint stays terminal (call, by "Migrate the archive's bookkeeping at true-up").
- **B206** `scripts/review::certified_verdict`. Before: the closing line names `the closed: stamp`. After: it names the closed-record ledger entry. Users: in the release: a `/goal` checker, which reads only the `SPRINT COMPLETE` verdict word. Across: none. Ruling: rewrite.
- **B207** `scripts/review::resolved_sprint` (`review deltas --sprint`, `review approved --sprint`). Before: each takes an archived sprint under `.ok-planner/history/sprints/`. After: each refuses it; `review stories --sprint` and `review drives --sprint` keep an archived path the caller names (see "Drive an archived sprint only on the owner's word"). Users: in the release: the sprint template's step 2 (`approved`) and certification's delta check, each with the live path. Across: none; the two verbs are internal. Ruling: rewrite.
- **B208** `scripts/review::sprints_closed_since`. Before: it lists the archived sprint paths whose `closed:` stamp descends from the docspec's stamp, read from `.ok-planner/history/sprints/`. After: it lists `{name, commit}` entries from the ledger. Users: in the release: `scripts/docs::window_entry` and `cmd_window`, changed in "Record a documentation sprint's close in the ledger". Across: none. Ruling: rewrite.
- **B209** `scripts/review::OWNER_PATHS`. Before: `review owner` prints `project` for `.ok-planner/closed-records.jsonl` and `.ok-planner/test-plans/<file>`. After: it prints `record`. Users: in the release: the fix line in the owner list and fixers, and `admin/true-up::caller_kind`, so the callers sweep skips the bookkeeping paths, as the migration item requires. Across: none. Ruling: rewrite.
- **B210** `scripts/review::live_path` (I201). Before: `tests` and `docs` refuse a bad `--sprint` with `InputError` wording of their own. After: all three tools refuse with one wording. Each still exits 1. Users: in the release: people and agents who read the refusal; no code parses it. Across: none. Ruling: rewrite.

**New surface**
- `review close` verb, declared in `scripts/review::build_parser`: internal. The surface intent keeps the family's scripts internal.
- `review closed` verb, declared in `scripts/review::build_parser`: internal.
- `.ok-planner/closed-records.jsonl`, a new estate file: internal. Its name now crosses the trued-up projects boundary as an estate file name that the boundary lists.

**Tested stories**
None.

**Runtime parts**
None.

### Record a deferred verdict's issue id in the certification run

**Calls**
- The owner list records each handoff as `tasks item add --pool deferred --key gate --field perf=<the entry's perf> --field site=<the entry's site, or its scenario where the entry names no site> --field issue=<the issue id> --body "<the issue id> holds the deferred product-slow verdict of speed item <perf>"`. Key `gate` matches every other pool of the `/converge` ledger. The site field falls back to the scenario because the failure line falls back the same way today (`verdict.get("site") or verdict["scenario"]`). Decided by: `skills/converge/SKILL.md` step 5 ("Every task the session or a `review` verb files carries key `gate`") and the sibling `test-speed.md` item adds.
- The `deferred` pool gets no `item_states` entry in `/converge`'s step 5. The tracker accepts any state for a pool `item_states` does not name (`scripts/tasks::check_state`), and the item's state is the default `open`. So `skills/converge/SKILL.md`, which this item does not list, stays as it is. Decided by: `scripts/tasks::check_state`.
- A verdict counts as handed off where any `deferred` item of the ledger carries its `perf` and its site (or scenario) and a non-empty `issue`. Item state is not read. Decided by: `decision:deferred-verdict-handed-off-through-the-intake`.
- `unfiled_deferred` keeps its two citations and gains `# @decision: deferred-verdict-handed-off-through-the-intake`. "Move each decision citation to the decision that holds its choice" may repoint `test-loop-fixes-code-never-tests` there, so these stages chain.
- Shares `scripts/review` with the ledger item, the two defect-list items, the drive-scratch item, and both citation items. Shares `skills/converge/prompts/owner-list.md` with "Sprint certification fixes the defect issues its sprint lists" and "Name the closed-issue file in every skill and the administration".

**Changes**
- `skills/converge/prompts/owner-list.md` ("A deferred product-slow verdict is a design issue"): changed. After it files the issue, or counts an open issue on the same site as already standing, the owner list runs the `tasks item add --pool deferred` line from the Calls with that issue's id, one item per deferred verdict. The closing line's counts stay as they are.
- `scripts/review::suite_failures`: changed. It passes the certification `ledger` to `unfiled_deferred`.
- `scripts/review::unfiled_deferred`: changed to `(root, sprint, ledger)`. It reads the deferred list from `tests failures --sprint <sprint> --json` as now. It reads the run's handoffs with `tasks_run(root, "--file", ledger, "item", "list", "--pool", "deferred", "--json")`, and counts a verdict as handed off where an item's `perf` and `site` match it and `issue` is set. It reads no intake record: the `issues.select` call goes. Each unmatched verdict fails with `the suite: the product-slow verdict of speed item <perf> on <site>, which the latest whole-suite round left deferred, has no issue id recorded in the certification run <ledger>: the owner list records one in the run's deferred pool when it files or finds the verdict's issue, so run the owner list`.
- `scripts/review::names_site`: removed.

**Behavior changes**
- **B211** `scripts/review::unfiled_deferred`. Before: `review certified` counts a deferred verdict as handed off where an open intake issue's title or problem names its site. After: it counts one only where the certification ledger's `deferred` pool records an issue id for the verdict's speed item and site, so a later close of that issue changes nothing. Users: in the release: `review certified`, whose item 3 (suite) line carries the failure, and the owner list, which now writes the item (B212). Across stored state: a certification ledger an earlier release's owner list wrote, which holds no `deferred` pool. Under `testing.enabled` `on` or `frozen`, a sprint with a deferred verdict, certified and not yet archived when the owner trues up, prints `SPRINT NOT COMPLETE` on its next `review certified`. Ruling: rewrite (call). `.ok-planner/release-boundaries.md` puts "a sprint ... in execution" outside the trued-up projects boundary, and a certified sprint awaiting its archive step is still in execution. An archived sprint is terminal from the ledger (B205) and is never checked again.
- **B212** `skills/converge/prompts/owner-list.md`. Before: the owner list files or finds the deferred verdict's issue and records nothing in the run. After: it also adds one `deferred` item per verdict to the run. Users: in the release: `review certified` (B211). Across: none. Ruling: rewrite.

**Tested stories**
None.

**Runtime parts**
None.

### Read earlier test plans from the test-plan folder

**Calls**
- The tool reads earlier plans for ledger entries of kind `sprint` and of kind `test-sprint`. Today's `ARCHIVED_PLAN_FOLDERS` reads both kinds, and the migration item moves both kinds' plans into the test-plan folder. A plan's path is `.ok-planner/test-plans/<the entry's name without .md>-plan.json`. Decided by: the work item, `decision:archive-read-by-nothing` ("The test-plan folder holds the test plan of each closed sprint"), and the migration item.
- The order is today's: newest first by commit ancestry where both commits are held, then by name, descending. An entry whose plan file is missing is skipped, and so is a plan no entry lists. Decided by: the work item ("as it ordered them by `closed:` stamps before").
- From now on `ranked_sprints` in `.ok-planner/test-state.json` records the sprint's live path, `.ok-planner/sprints/<name>`. Earlier entries keep their archived paths. Only `cmd_stamp` reads the list, and only to find the sprint it stamps, so a second stamp before `review close` still finds its own path. Decided by: `scripts/tests::cmd_stamp`, the one reader.
- `tests stamp` refuses a sprint the ledger lists: `<name> is closed in the closed-record ledger at <commit>: its scenario list was written before its close`. Decided by: the work item.
- Shares `scripts/tests` with every testing item, the citation items above all, which may repoint `cmd_stamp`'s `@decision: scenario-list-decided-once` to `scenario-list-written-at-the-archive-step`. This stage removes `review.ARCHIVED_SPRINTS` from `scripts/review` once it drops the last users here, so it chains after the ledger stage.

**Changes**
- `scripts/tests::ARCHIVED_PLAN_FOLDERS`: removed. New constant `TEST_PLANS = os.path.join(ESTATE, "test-plans")`.
- `scripts/tests::archived_plans`: removed, replaced by `earlier_plans(root)`. It reads `review.closed_records(root)`, keeps the `sprint` and `test-sprint` entries, maps each to its plan under `TEST_PLANS`, skips a missing plan, and sorts as the Calls say. It returns `{"sprint": <name>, "plan": <path>, "stamp": <commit>, "held": stamp_held(...)}`. It opens no file under `.ok-planner/history/`, and carries `# @decision: archive-read-by-nothing` beside `sprints-plan-what-their-work-reaches`.
- `scripts/tests::earlier_calls`: changed. It reads `earlier_plans`. Its refusal reads `an earlier plan is read as tests plan wrote it` in place of "an archived plan".
- `scripts/tests::cmd_calls`: changed text. `no archived plan planned it` becomes `no earlier plan planned it`.
- `scripts/tests::resolved_sprint`: removed, replaced by I201's `review.live_path(root, path, review.SPRINTS, "sprint", exists=...)` at every caller (`cmd_plan`, `cmd_groups`, `run`, `failures`, `tasks`, `settled`, `stray`, `reports`, `reached`, `ports`, `stamp`, and the rest of the lines 1745 to 5276 list).
- `scripts/tests::cmd_stamp`: changed. It takes the sprint at its `.ok-planner/sprints/` path; the "is not archived" refusal goes. It refuses a sprint `review.closed_entry(root, "sprint", name)` lists, before it writes anything. The rest stands.
- `scripts/review::ARCHIVED_SPRINTS`: removed in this stage, now that it has no user.
- `scripts/tests::USAGE`: changed. `tests calls` reads: for each story, the plan of the closed sprint, or of an earlier release's test sprint, that planned it last, read from `.ok-planner/test-plans/` for each sprint the closed-record ledger lists with a commit, newest first by those commits. `tests stamp --sprint <path> --commit <sha>` reads: after the owner commits the sprint's work and before the archive step moves the sprint, for a sprint under `.ok-planner/sprints/` the closed-record ledger does not list yet. The paragraph on sprint paths says every `--sprint` names a sprint under `.ok-planner/sprints/`.
- `.ok-planner/review/project.md`: changed. The `tests` line's "Every `--sprint` names a sprint under `.ok-planner/sprints/` or `.ok-planner/history/sprints/`" drops the archived folder. Its `stamp --sprint <archived path>` sentence becomes `stamp --sprint <path> --commit <sha>`, for a sprint under `.ok-planner/sprints/` the closed-record ledger does not list, with its `-plan.json` beside it.

**Behavior changes**
- **B213** `scripts/tests::earlier_plans` (`tests calls`, `tests groups --widen` with no slug). Before: earlier plans come from `-plan.json` files beside sprints under `.ok-planner/history/sprints/` and `.ok-planner/history/test-sprints/`, ordered by their `closed:` stamps. The JSON `plan` field names the archived path. After: they come from `.ok-planner/test-plans/`, ordered by the ledger's commits, and `plan` names the test-plan path. Users: in the release: `skills/plan-sprint/tests-story.md` step 7, which reads the calls (the path is shown, not parsed), and `skills/plan-sprint/SKILL.md`'s widen offer. Across stored state and the trued-up projects boundary: every archived plan an earlier release left beside an archived sprint or test sprint. Ruling: migrate: true-up's migration writes the ledger entries and moves each listed plan into `.ok-planner/test-plans/` (call, by "Migrate the archive's bookkeeping at true-up").
- **B214** `scripts/tests::cmd_stamp`. Before: `tests stamp` requires a sprint archived under `.ok-planner/history/sprints/` and refuses a live one. After: it requires the live path and refuses a sprint the ledger lists. Users: in the release: the sprint template's archive step, rewritten in "Write a sprint's bookkeeping before its archive move". Across the trued-up projects boundary: an approved sprint not yet in execution carries the old archive step in its boilerplate. Ruling: migrate: the replaced template lines join `admin/retired-boilerplate.json`, and true-up's live-sprint pass brings each live sprint's archive step to the new text (call, by `decision:live-sprints-brought-current-on-true-up`).
- **B215** `scripts/tests` every other `--sprint` verb. Before: each accepts an archived sprint. After: each refuses one. Users: in the release: the sprint template, `/converge` sprint mode, the owner list's `tests failures --sprint` and `tests plan --show` calls, and `scripts/review`'s `tests settled` and `tests stray` calls, each with a live path. Across: none. Ruling: rewrite.

**Tested stories**
None.

**Runtime parts**
None.

### Record a documentation sprint's close in the ledger

**Calls**
- `docs stamp` refuses a documentation sprint the ledger lists before it writes any run state: `<name> is closed in the closed-record ledger at <commit>`. It writes the ledger entry last, through `review.record_closes`, because the entry is what makes the run terminal. A stamp that stops before its entry is run again. I202 keeps that rerun from doubling claims. Decided by: rule 3, and `decision:sprint-goal-read-from-the-repository` (the ledger entry is the terminal fact).
- `docs complete` takes the file name from `--sprint` and checks the ledger before the path, like `review certified`. It prints `the closed-record ledger lists <name> as a closed documentation sprint at <commit>, which is terminal`, then the `DOCS COMPLETE` lines. Decided by: the work item and the sibling `review::certified_without_config`.
- `docs window` lists the `sprint` entries only, not `doc-sprint` or `test-sprint` entries. The work item and `decision:docspec-stamp-opens-the-window` name sprints. A test sprint an earlier release closed after a docspec's stamp shows as an unexplained change, which the owner answers. Decided by: `decision:docspec-stamp-opens-the-window`.
- Each `sprints` entry is `{"name": <file name>, "commit": <sha>}`. The text form prints `  sprint closed since the stamp: <name> at <commit>`. Decided by: the work item ("each sprint ... with its closing commit").
- This stage removes `review.with_closed_stamp`, the last caller of which is here, and reshapes `review.sprints_closed_since` (B208) with its one caller.

**Changes**
- `scripts/docs::ARCHIVED_DOC_SPRINTS`: removed.
- `scripts/docs::resolved_sprint`: removed, replaced by I201's `review.live_path(root, path, DOC_SPRINTS, "documentation sprint")` at each caller (`cmd_start`, `cmd_report`, `cmd_complete`, `cmd_stamp`).
- `scripts/docs::cmd_complete`: changed. It reads the ledger first as the Calls say, then resolves the live path and runs the stop-record check and `complete_failures` as now. The `closed_stamp` read and the archived branch go. It opens no file under `.ok-planner/history/`.
- `scripts/docs::cmd_stamp`: changed. It takes the documentation sprint at its `.ok-planner/doc-sprints/` path; the "is not archived" refusal goes. It refuses a listed sprint up front. It writes the run state and removals as now, then `review.record_closes(root, [{"kind": "doc-sprint", "name": <file name>, "commit": args.commit}])`, and prints `recorded: <name> closed at <sha> in .ok-planner/closed-records.jsonl`. It writes nothing into the sprint file. It carries `# @decision: closing-commit-baseline`.
- `scripts/docs::window_entry`: unchanged call; it takes B208's entries.
- `scripts/docs::cmd_window`: changed. It prints each entry as `<name> at <commit>`.
- `scripts/review::with_closed_stamp`: removed.
- `scripts/docs::USAGE`: changed. `docs window` names the sprints the closed-record ledger lists as closed since the stamp, each with its closing commit. `docs complete` says a documentation sprint the ledger lists with its closing commit is terminal. `docs stamp --sprint <path> --commit <sha>` says it runs before the archive move on a documentation sprint under `.ok-planner/doc-sprints/`, records the close in the closed-record ledger, and refuses one the ledger lists. The `add closed: <sha>` clause goes.

**Improvements**
- **I202** `scripts/docs::ledger_after`. Entry: A1 (stored state can end half-changed). `cmd_stamp` writes each docspec's run state in separate writes and the ledger entry last. A stamp stopped before its entry is run again, and on that rerun `kept` still holds each held claim the first pass added, while `held_run_claims` adds it again, so the claim ledger lists the claim twice under one id. Afterward: `ledger_after` drops from `kept` each claim whose id `held_run_claims` returns, so a rerun leaves one claim per id. Behavior change: B220.

**Behavior changes**
- **B216** `scripts/docs::cmd_complete`. Before: an archived documentation sprint with a `closed:` stamp is terminal. After: a documentation sprint the closed-record ledger lists is terminal by file name, and the verb refuses an archived path the ledger does not list. Users: in the release: the documentation sprint template's step 8 and goal rule, `{{PLANNING-HANDOFF}}`'s goal line, and a `/goal` checker. Across stored state and the trued-up projects boundary: every documentation sprint an earlier release archived with a `closed:` stamp. Ruling: migrate: true-up's migration writes one `doc-sprint` entry per archived documentation sprint from its stamp (call, by "Migrate the archive's bookkeeping at true-up").
- **B217** `scripts/docs::cmd_stamp`. Before: `docs stamp` requires an archived documentation sprint, and adds `closed: <sha>` to its frontmatter. After: it requires the live path, writes the ledger entry, writes nothing into the sprint, and refuses a sprint the ledger lists. Users: in the release: `skills/_sprint/shared.md::{{CEREMONY-ARCHIVE}}` and the documentation sprint template's archive paragraph, both rewritten in "Write a documentation sprint's bookkeeping before its archive move". Across the trued-up projects boundary: an approved documentation sprint not yet in execution names the old command in its boilerplate. Ruling: migrate: the replaced template lines join `admin/retired-doc-sprint-boilerplate.json`, and true-up's live-sprint pass rewrites the paragraph (call, by `decision:live-sprints-brought-current-on-true-up`).
- **B218** `scripts/docs::window_entry`, `cmd_window`. Before: each entry's `sprints` is a list of archived sprint paths. After: it is a list of `{name, commit}` from the ledger. Users: in the release: `skills/plan-docs/SKILL.md` section 2 and `skills/plan-docs/core.md::{{DOC-PLANNER-PROMPT}}`, rewritten in "Plan documentation from closing commits". Across: none. Ruling: rewrite.
- **B219** `scripts/docs` `start`, `report`, and `complete` with an archived `--sprint`. Before: each accepts the archived path. After: `start` and `report` refuse it, and `complete` refuses it unless the ledger lists the name. Users: in the release: the documentation sprint template, which passes the live path. Across: none. Ruling: rewrite.
- **B220** `scripts/docs::ledger_after` (I202). Before: a stamp run again after a stop lists a held claim twice. After: once. Users: in the release: `docs claims`, `docs window`'s stale count, and the next documentation sprint's checkers. Across: none; only a harm goes. Ruling: rewrite.

**Tested stories**
None.

**Runtime parts**
None.

### Write a sprint's bookkeeping before its archive move

**Calls**
- Three other steps move files into `history/`: `/plan-docs` setting aside a never-run documentation sprint (`skills/plan-docs/SKILL.md`), `/discover-design` dropping a discovery (`skills/discover-design/SKILL.md`), and `/plan-sprint` Terminal step 3 archiving a discovery. Each records an `archived` entry in the closed-record ledger before its move, as `decision:archive-read-by-nothing` requires; those three skill files join this item's Changes. Decided by: the notes review's build note and the bookkeeping-first rule.
- The closing commit holds every path the sprint's change touched, the intake's two files (`.ok-planner/issues.jsonl` and `.ok-planner/closed-issues.jsonl`), and the `/converge` run's ledger or its parts with its run folder under `.ok-planner/review/runs/`. Like today's step 3, it never holds the sprint file or its companions: they reach git in the follow-on commit, at their archive paths. Decided by: `decision:closing-commit-baseline` ("one follow-on commit that holds only records and bookkeeping") and today's step 3, which commits the ledger's folder.
- The follow-on commit also holds every sprint file the moves removed from `.ok-planner/sprints/`, and every file the split removed, named the way today's step 3 names removed paths (`git commit -- <paths>`). Decided by: today's step 3.
- The plan move runs `mkdir -p .ok-planner/test-plans` first, and moves `<sprint-name>-plan.json` there under the same name. Decided by: the work item; `mv` into a missing folder fails.
- An archive step stopped after `review close` is resumed where it stopped. Where `review closed --kind sprint` already lists this sprint, the closing commit, the stamp, and the close are done, so the owner goes on to the moves. This replaces running `tests stamp` and `review close` again, which both refuse a listed sprint. Decided by: rule 4 (walk every exit) and the refusals the tests item and the ledger item add.
- Step 2's list of the planning session's uncommitted files names `.ok-planner/closed-records.jsonl` beside the intake's two files, because Terminal now writes sketch entries there (Reconcile item). Decided by: rule 1 (the base step enumerates the planning session's files).
- The replaced lines of "How to execute this sprint" and "Completion contract" join `admin/retired-boilerplate.json` as JSON strings, each line exactly as the released template carries it. `checks/sprint-boilerplate` fails where a released line is missing from the history. Decided by: `checks/sprint-boilerplate` and `decision:live-sprints-brought-current-on-true-up`.
- Shares `skills/plan-sprint/sprint-document.md` and `admin/retired-boilerplate.json` with "Name the build role as held in sprint execution" (step 3, step 7), "Sprint certification fixes the defect issues its sprint lists" (step 12), "The completion contract checks..." (contract item 3, goal rule), "Out-of-band work changed after Reconcile..." (template line), and "Execution creates the progress checklist..." (step order). Every step number this item names may move in that last item, so chain the stages. Each stage appends its own replaced lines to the JSON array.

**Changes**
- `skills/plan-sprint/sprint-document.md` ("How to execute this sprint" step 1): changed. "context from the intake (`.ok-planner/issues.jsonl`) or `history/` may disagree" becomes "context from the intake (`.ok-planner/issues.jsonl`) may disagree".
- `skills/plan-sprint/sprint-document.md` (step 2, the base): changed. The planning session's own files read: this file, its delta sidecar, `.ok-planner/release-boundaries.md`, the intake's two files (`.ok-planner/issues.jsonl` and `.ok-planner/closed-issues.jsonl`), the closed-record ledger `.ok-planner/closed-records.jsonl`, and the sketches and the discovery it archived.
- `skills/plan-sprint/sprint-document.md` ("The archive and the commit"): changed, rewritten into this order on the owner's yes:
  1. Close each promoted issue (`issues list --sprint` then `issues close <id> --as promoted`), which moves its record to `.ok-planner/closed-issues.jsonl`.
  2. Run `tasks split` in place on this sprint's run file, its `-results.jsonl` file, and the `/converge` run's ledger, as now.
  3. Stage by name and commit, with `git commit -- <paths>`: every path the sprint's change touched, the intake's two files, and the `/converge` run's ledger or its parts and its folder, with this sprint still under `.ok-planner/sprints/`. This is the closing commit.
  4. Where `<sprint-name>-plan.json` stands beside this file, or `tests enabled` prints `on` or `frozen`, run `.ok-planner/bin/tests stamp --sprint .ok-planner/sprints/<this file's name> --commit <the closing commit's sha>` and show its output whole.
  5. Run `.ok-planner/bin/review close --kind sprint --name <this file's name> --commit <sha>`.
  6. `mkdir -p .ok-planner/test-plans`, then move `<sprint-name>-plan.json`, where it stands, into `.ok-planner/test-plans/`.
  7. Move every other file and folder that shares this sprint's name into `.ok-planner/history/sprints/`, listed by `ls -d .ok-planner/sprints/<sprint-name>-*` as now, leaving out another sprint's files, `git mv` for a tracked file and `mv` for an untracked one.
  8. Commit by name the moves at their old and new paths, each sketch and each discovery the planning session archived at its old and new paths (the `git status --porcelain --untracked-files=all -- ...` listing as now), `.ok-planner/closed-records.jsonl`, `.ok-planner/test-state.json` where the stamp ran, and the moved plan.

  The resume rule from the Calls follows the steps. No step writes a `closed:` stamp or reads a file under `.ok-planner/history/`. The closing sentence "The next planning session reads the `closed:` stamp ..." becomes "The next planning session reads the closed-record ledger to detect work done out of band, and its test planning reads the story stamps".
- `skills/plan-sprint/sprint-document.md` (the goal rule): changed. "Presenting the report, archiving, committing, and the `closed:` stamp all follow completion" names the closed-record ledger entry in place of the stamp. "`sprints/` and `.ok-planner/history/sprints/` satisfy the rule alike, and a sprint already archived with a `closed:` stamp is terminal" becomes "A sprint the closed-record ledger, `.ok-planner/closed-records.jsonl`, lists with its closing commit is terminal: `review certified` answers from the ledger by the sprint's file name, wherever the file stands."
- `admin/retired-boilerplate.json`: changed. It appends each released line of the two boilerplate sections this item removes or rewrites.

**Behavior changes**
- **B221** `skills/plan-sprint/sprint-document.md` (the archive step). Before: the owner moves the sprint into the archive, commits, stamps the archived path with `tests stamp`, and writes `closed: <sha>` into the archived sprint. After: the owner commits with the sprint still live, stamps the live path, records the close with `review close`, moves the plan into `.ok-planner/test-plans/` and the rest into the archive, and commits the bookkeeping. Users: in the release: the owner, `scripts/tests::cmd_stamp` (B214), and `scripts/review::cmd_close`. Across the trued-up projects boundary: each approved sprint not yet in execution, whose boilerplate carries the old step. Ruling: migrate: the replaced lines join `admin/retired-boilerplate.json`, so true-up's live-sprint pass rewrites the step in each live sprint (call, by `decision:live-sprints-brought-current-on-true-up`).
- **B222** `skills/plan-sprint/sprint-document.md` (the goal rule, steps 1 and 2). Before: a sprint archived with a `closed:` stamp is terminal; step 1 names `history/` as context; step 2 names `history/issues.jsonl`. After: a sprint the ledger lists is terminal; step 1 names no archive; step 2 names the closed-issue file and the ledger. Users: in the release: a `/goal` checker and the executing session. Across: approved sprints not yet in execution. Ruling: migrate: as B221 (call).

**Tested stories**
None.

**Runtime parts**
None.

### Write a documentation sprint's bookkeeping before its archive move

**Calls**
- The documentation sprint template's replaced lines join `admin/retired-doc-sprint-boilerplate.json`, not `admin/retired-boilerplate.json` as the work item names. `admin/true-up::DOC_SPRINT_BOILERPLATE` reads the documentation sprint's retired lines from `retired-doc-sprint-boilerplate.json`, and `checks/sprint-boilerplate` checks the documentation template's released lines against that file. A line written to the sprint history would neither bring a live documentation sprint current nor pass the check. Decided by: `admin/true-up::DOC_SPRINT_BOILERPLATE` and `checks/sprint-boilerplate::KINDS`.
- `{{CEREMONY-ARCHIVE}}` keeps `<folder>`, `<also>`, and `<stamp command>` as placeholders. The template's archive paragraph fills `<stamp command>` with the live path. Decided by: the block's existing shape.
- The closing commit holds the paths the run's tasks staged, each file `<also>` names, and the intake's two files where the run or the planning session before it filed an issue. The documentation sprint and its companions reach git in the follow-on commit, at their archive paths. Decided by: the work item and `decision:closing-commit-baseline`.
- A stop after the stamp resumes at the moves where `review closed --kind doc-sprint` lists the documentation sprint, as in the sprint item. Decided by: rule 4.
- Shares `skills/_sprint/shared.md` with "Out-of-band work changed after Reconcile..." (`{{PLANNING-HANDOFF}}`), "Sprint certification fixes..." (`{{SPRINT-CATALOG}}`), and the testing items. Chain the stages.

**Changes**
- `skills/_sprint/shared.md::{{CEREMONY-ARCHIVE}}`: changed, rewritten in this order on the owner's yes:
  1. Run `tasks split` in place on each JSON Lines file of the run, its `-run.jsonl` among them.
  2. Stage by name and commit, with `git commit -- <paths>`: the paths the run's tasks staged, each file `<also>` names, and the intake's two files where an issue was filed. This is the closing commit.
  3. Run `<stamp command>` with that commit's sha, on the document's live path. It writes the run state the next plan reads and records the close in `.ok-planner/closed-records.jsonl`.
  4. Move the document and every file beside it that shares its name (its `-run.jsonl` or that file's parts, its `-base.txt` and `-completion.md`, its prompt files, its sidecar folder, its `-stopped.txt` where one stands) into `.ok-planner/history/<folder>/`, `git mv` or `mv`.
  5. Commit by name the moves at both paths, `.ok-planner/closed-records.jsonl`, and what the stamp wrote, each path it names as removed included.

  The resume rule follows. The block's lead line, which says what `<stamp command>` is, stays.
- `skills/plan-docs/doc-sprint-document.md` (the archive paragraph): changed. `<stamp command>` becomes `.ok-planner/bin/docs stamp --sprint .ok-planner/doc-sprints/<this file's name> --commit <sha>`. The sentence after it says the stamp records each docspec's stamp, its claim ledger, and the worked example in `.ok-planner/doc-state/`, and records the close in the closed-record ledger, `.ok-planner/closed-records.jsonl`. The "adds `closed: <sha>` to this file" clause goes.
- `skills/plan-docs/doc-sprint-document.md` (the goal rule): changed. "A documentation sprint archived with a `closed:` stamp is terminal" becomes "A documentation sprint the closed-record ledger lists with its closing commit is terminal: `docs complete` answers from the ledger by its file name."
- `admin/retired-doc-sprint-boilerplate.json`: changed. It appends each released line of the two boilerplate sections this item removes or rewrites.

**Behavior changes**
- **B223** `skills/_sprint/shared.md::{{CEREMONY-ARCHIVE}}`. Before: split, move into the archive, commit, then stamp the archived document, which adds `closed:`, and commit. After: split, commit with the document live, stamp the live path (the ledger entry), move, commit the bookkeeping. Users: in the release: every documentation sprint, which names the block by token. Across the trued-up projects boundary: none of its own; true-up rewrites `.claude/skills/_sprint/shared.md` wholesale. Ruling: rewrite.
- **B224** `skills/plan-docs/doc-sprint-document.md` (the archive paragraph and the goal rule). Before: the stamp command names the archived path, and an archived documentation sprint with `closed:` is terminal. After: the live path, and a listed one is terminal. Users: in the release: the executing session and a `/goal` checker. Across the trued-up projects boundary: each approved documentation sprint not yet in execution. Ruling: migrate: the replaced lines join `admin/retired-doc-sprint-boilerplate.json`, so true-up's live-sprint pass rewrites them (call, by `decision:live-sprints-brought-current-on-true-up`).

**Tested stories**
None.

**Runtime parts**
None.

### Reconcile from the closed-record ledger

**Calls**
- The out-of-band reviewer runs under `{{READ-ONLY-REVIEWER-RULE}}`, which allows only `rg` and git, so it cannot run `review closed`. The session runs `.ok-planner/bin/review closed --json` once and fills a new input, `[RUN COMMITS]`: each `doc-sprint` and `test-sprint` entry's commit, with its kind and name. The baseline comes from the same output's last `sprint` entry. Decided by: `skills/_shared/dispatch-discipline.md::{{READ-ONLY-REVIEWER-RULE}}`.
- A change is ambient where it touches only `.ok-planner/history/` or the bookkeeping files: `.ok-planner/closed-records.jsonl`, `.ok-planner/closed-issues.jsonl`, and `.ok-planner/test-plans/`. The reviewer reads none of them. Decided by: the work item and `decision:archive-read-by-nothing`.
- Terminal step 2 runs `review close --kind sketch --name <file name>` per sketch before its move. Where the verb refuses, the session leaves that sketch where it is and names the refusal in one line. Decided by: rule 4.6 (a refusal never ends in silence).
- Terminal's closing paragraph ("The session writes only ...") adds the closed-record ledger entries of the sketches it archives. Decided by: rule 1 (that paragraph enumerates the session's writes).
- Shares `skills/plan-sprint/SKILL.md` with "Out-of-band work changed after Reconcile..." (section 3, section 13), "Sign-off checks each delta body..." (sections 7, 11, 13), "A defect the owner picks..." (Frame, section 13, Terminal step 1), and "Name the closed-issue file..." (lines 32, 50, 171, 248). Both Reconcile items rewrite section 3, so they chain.

**Changes**
- `skills/plan-sprint/SKILL.md` (section 3 step 1, "Resolve the baseline"): changed. Run `.ok-planner/bin/review closed --json`. The baseline is the commit of the last `sprint` entry it prints, the newest sprint the closed-record ledger lists. Where it prints no `sprint` entry, say so and ask the owner once, in prose, whether to name a baseline ref or skip the walk.
- `skills/plan-sprint/SKILL.md` (section 3 step 3): changed. The dispatch fills `[RUN COMMITS]` from the same output.
- `skills/plan-sprint/SKILL.md` (section 3 step 4, the documentation paragraph): changed. "An edit in a commit that an archived documentation sprint's `closed:` stamp names, under `.ok-planner/history/doc-sprints/`, is that run's work" becomes "An edit in a commit the closed-record ledger lists for a documentation sprint is that run's work".
- `skills/plan-sprint/SKILL.md` (section 14 Terminal step 2): changed. For each sketch, first `.ok-planner/bin/review close --kind sketch --name <file name>`, then the move, as the Calls say.
- `skills/plan-sprint/SKILL.md` (Terminal's closing paragraph): changed, as the Calls say.
- `skills/plan-sprint/core.md::{{OUT-OF-BAND-REVIEWER-PROMPT}}`: changed. The two paragraphs that name `.ok-planner/history/doc-sprints/` and `.ok-planner/history/test-sprints/` give way to one input: `Run commits: [RUN COMMITS]`. Each is a commit the closed-record ledger lists for a documentation sprint or for a test sprint an earlier release closed, and each is that run's work, not a change out of band. A documentation sprint wrote documentation. A test sprint changed tests and fixed the code they reach so it does what a story promises. A new line says: read no file under `.ok-planner/history/`, and count a change under `.ok-planner/history/` or to the closed-record ledger, the closed-issue file, or `.ok-planner/test-plans/` as AMBIENT. The BEARING test's documentation bullet reads "in a commit the run commits do not list, or in the uncommitted tree".

**Behavior changes**
- **B225** `skills/plan-sprint/SKILL.md` (the baseline). Before: the baseline is the newest `closed:` stamp among files under `.ok-planner/history/sprints/`. After: it is the commit of the last `sprint` entry in the closed-record ledger. Users: in the release: the planning session's window and the out-of-band reviewer. Across stored state and the trued-up projects boundary: every sprint an earlier release archived with a stamp, which the baseline must still reach. Ruling: migrate: true-up's migration writes the ledger's `sprint` entries in commit-ancestry order, so the last entry is the newest closed sprint (call, by "Migrate the archive's bookkeeping at true-up").
- **B226** `skills/plan-sprint/core.md::{{OUT-OF-BAND-REVIEWER-PROMPT}}`. Before: the reviewer reads the archived documentation sprints' and test sprints' `closed:` stamps to exclude their work. After: it takes their commits from the ledger through the session and reads nothing in the archive. Users: in the release: the Reconcile summary. Across: as B225. Ruling: migrate: as B225 (call).
- **B227** `skills/plan-sprint/SKILL.md` (Terminal step 2). Before: a sketch moves into the archive and nothing records its name. After: each archived sketch's name is a `sketch` entry in the ledger. Users: in the release: `/sketch`'s name check ("Check a sketch's name against the ledger") and the sprint archive step's follow-on commit. Across: none. Ruling: rewrite.

**Tested stories**
None.

**Runtime parts**
None.

### Plan documentation from closing commits

**Calls**
- The planner reads each listed closing commit with `git show --no-patch --format=%B <commit>` for its message, and `git show --name-only --format= <commit> -- .ok-planner/design/` for the corpus artifacts it changed, then reads each such artifact as it stands now. Both are git inspection, which `{{READ-ONLY-REVIEWER-RULE}}` allows. Decided by: the work item and that rule.
- A change "no listed closing commit made" is a change in `git diff <stamp>` to what the docspec describes whose files no listed closing commit's `git show --name-only` names. Decided by: the work item's definition of an unexplained change.
- The writer prompt (`{{DOC-WRITE-PROMPT}}` step 4) reads "the code, corpus artifacts, and closing commits your brief's facts name" in place of "sprints". A planner's fact for edit-rule row 18 names the sprint's closing commit, so a writer never opens an archived sprint. Row 18's own wording ("A sprint closed since the docspec's stamp changed ...") stays, since a closing commit is that sprint's close. Decided by: `decision:archive-read-by-nothing`, and the work item's change of all of `core.md`.
- `skills/plan-docs/SKILL.md`'s Resolve bullet heading "A change no sprint explains" becomes "A change no closing commit made", so one term names one thing. The doc-sprint template's `## Owner answers` placeholder reads "whose intent no closing commit the plan read explains". Decided by: the writing standard ("Use the same term for the same thing every time").
- Shares `skills/plan-docs/doc-sprint-document.md` with "Write a documentation sprint's bookkeeping...". The Window section lies outside the boilerplate sections, so its line joins no retired list. Chain the two stages on this file.

**Changes**
- `skills/plan-docs/core.md::{{DOC-PLANNER-PROMPT}}` (Inputs): changed. "Read each sprint the entry names as closed since the stamp: its Intent, its Work items, and its Implementation notes" becomes the commit reads the Calls name, for each entry of the window entry's `sprints`, with "Read no sprint document."
- `skills/plan-docs/core.md::{{DOC-PLANNER-PROMPT}}` (The plan, step 5): changed. "that no sprint closed since the stamp made or explains" becomes "that no closing commit the entry's `sprints` lists made".
- `skills/plan-docs/core.md::{{DOC-WRITE-PROMPT}}` (step 4): changed, as the Calls say.
- `skills/plan-docs/SKILL.md` (section 2, the window paragraph): changed. "the sprints closed since its stamp" becomes "each sprint the closed-record ledger lists as closed since its stamp, with its closing commit".
- `skills/plan-docs/SKILL.md` (section 3, the Resolve bullet): changed, as the Calls say.
- `skills/plan-docs/doc-sprint-document.md` (`## Window` placeholder): changed. "Then each sprint closed since the stamp that the plan read for intent" becomes "Then each closing commit the plan read for intent, with the sprint the closed-record ledger lists it for." The `## Owner answers` placeholder changes as the Calls say.

**Behavior changes**
- **B228** `skills/plan-docs/core.md::{{DOC-PLANNER-PROMPT}}`. Before: the planner reads each archived sprint document the window entry names for intent, and an unexplained change is one no closed sprint made or explains. After: it reads each closing commit's message and the corpus artifacts the commit changed, as they stand now, reads no sprint document, and an unexplained change is one no listed closing commit made. Users: in the release: `/plan-docs`'s Resolve step, which asks the owner about each unexplained change. Across: none; `/plan-docs` is planning in progress. Ruling: rewrite.
- **B229** `skills/plan-docs/core.md::{{DOC-WRITE-PROMPT}}`. Before: a writer reads the sprints its brief's facts name. After: it reads the closing commits the facts name. Users: in the release: documentation sprint writers. Across the trued-up projects boundary: an approved documentation sprint registers its write prompt from `.claude/skills/plan-docs/core.md` at its step 4, and true-up rewrites that file wholesale. Ruling: rewrite.

**Tested stories**
None.

**Runtime parts**
None.

One work item names the wrong file: "Write a documentation sprint's bookkeeping before its archive move" lists `admin/retired-boilerplate.json`, and the code routes documentation sprint lines through `admin/retired-doc-sprint-boilerplate.json` (`admin/true-up::DOC_SPRINT_BOILERPLATE`, `checks/sprint-boilerplate::KINDS`). That item's first call settles it, so it is no kickback.

### Check a sketch's name against the ledger

**Calls**
- The skill reads the ledger through `.ok-planner/bin/review closed --kind sketch --json` and counts a name as taken where a listed entry's `name` equals the file name it would write. Decided by: the work item, and need (L4).
- Where `review closed` is missing or refuses, the skill says the message, says that `/ok` materializes the tool, and stops before it writes anything. Falling back to `sketches/` alone could reuse an archived sketch's name, which `decision:closing-commit-baseline` rules out ("so a new sketch never takes an archived sketch's name"). Decided by: `decision:closing-commit-baseline`, and A9 (a skill must not report a name as free when it is not).
- The note on an abandoned sketch names `.ok-planner/bin/review close --kind sketch --name <file name>` and then the move into `.ok-planner/history/sketches/`. That order is the bookkeeping-first rule. Decided by: `decision:archive-read-by-nothing` ("Each archive step writes the bookkeeping before it moves a file into the archive").
- `sketch/SKILL.md` is in no other group's file list. The skill depends on the ledger item's `review closed` verb, so its stage runs after that item's stage.

**Changes**
- `plugins/ok/families/ok-planner/skills/sketch/SKILL.md` (intro paragraph): changed. The sentence "an abandoned sketch the owner moves there by hand" becomes: the owner records an abandoned sketch with `.ok-planner/bin/review close --kind sketch --name <file name>`, then moves it into `.ok-planner/history/sketches/`.
- `plugins/ok/families/ok-planner/skills/sketch/SKILL.md` (Process step 4): changed. A name is taken where `.ok-planner/sketches/` holds a file of that name or `review closed --kind sketch --json` lists it. The step reads nothing under `.ok-planner/history/`. Where the command is missing or refuses, the skill reports the message and stops. The `-<n>` suffix rule and "Never overwrite an existing sketch" stay.

**Behavior changes**
- **B301** `sketch/SKILL.md` step 4. Before: a name was taken where `.ok-planner/sketches/` or `.ok-planner/history/sketches/` held a file of that name. After: a name is taken where `.ok-planner/sketches/` holds the file or the ledger lists a sketch of that name. Users: in the release: `/plan-sprint`'s Terminal step, which records each sketch with `review close --kind sketch` before the move (the Reconcile item), and true-up's migration, which writes one `sketch` entry per file under `history/sketches/`. Across trued-up projects: every project whose archive holds sketches. The vendored `/sketch` arrives in the same true-up that writes those entries, so every archived sketch stays taken. A sketch the owner later moves by hand without `review close` is no longer seen, and the skill's note tells the owner to record it first. Ruling: migrate: true-up's archive migration writes a `sketch` entry for each file under `history/sketches/` in the same plan that vendors this skill (call).
- **B302** `sketch/SKILL.md` step 4. Before: the skill needed only `mkdir`. After: it needs `.ok-planner/bin/review` to answer `review closed`, and it stops where the tool refuses. Users: in the release: every project that holds this skill also holds `bin/review`, because one true-up vendors both. Need (L4) keeps the verb free of the review config. Ruling: rewrite.

**Tested stories**
None.

**Runtime parts**
None.

### Drive an archived sprint only on the owner's word

**Calls**
- The owner ruled that an agent reads `history/` when the owner directs it, never on its own and never to learn the current state. An archived path the owner types into `/drive sprint` is such a direction, so the path stays accepted. Decided by: the owner's ruling on `archive-read-by-nothing` (an agent reads an archived record when the owner directs it). This replaces the planner's owner question B303.
- `drive/SKILL.md` is also changed by "Name the closed-issue file in every skill and the administration", which this group owns too. Land both items in one stage.

**Changes**
- `plugins/ok/families/ok-planner/skills/drive/SKILL.md` ("The invocation", the `/drive sprint <path>` bullet): changed. It keeps the archived path, says the owner names it, and says the run reads that sprint only for its new and changed stories.
- `plugins/ok/families/ok-planner/scripts/review::resolved_sprint` (the `stories` and `drives` verbs): changed. An archived path the caller names is accepted; a live path with no file no longer falls back to the archive.

**Behavior changes**
- **B303** `scripts/review::resolved_sprint` (`review stories`, `review drives`). Before: a live path with no file fell back to the archived sprint of that name. After: the verbs take an archived path only where the caller names it. Users: in the release: `skills/_converge/drive.md` step 3 and `skills/converge/SKILL.md`, which pass the live path of a live sprint. Across the public surface: an owner who types `/drive sprint <archived path>`, whose command keeps working. Ruling: preserve (call).

**Tested stories**
None.

**Runtime parts**
None.

### Stop discovery from mining archived sprints

**Calls**
- Only the sentence in `{{STORY-DEFINITION}}` changes. `discover-design/core.md` already tells its agents to "Read no ... file under `.ok-planner/history/`", so its five transclusions of the definition stop contradicting that rule with no edit of their own. Decided by: `discover-design/core.md` lines 88-90 and 204-205.
- `skills/_shared/artifact-definitions.md` is also changed by "The intake rules say a taken defect is fixed by certification" (another group, `{{ISSUE-FILE-FORMAT}}`) and by "Name the closed-issue file" (this group). This item's block, `{{STORY-DEFINITION}}`, is touched by no other item. The file is still shared, so the stages that edit it chain with `--after`.

**Changes**
- `plugins/ok/families/ok-planner/skills/_shared/artifact-definitions.md::{{STORY-DEFINITION}}` (its last line, "Discover stories from public surfaces ..."): changed. It reads: Discover stories from public surfaces (the surface goes to a decision, the outcome to a story), and README and docs sections that say what the product does for users. The clause "and `.ok-planner/history/sprints/` where present" goes.

**Behavior changes**
- **B304** `artifact-definitions.md::{{STORY-DEFINITION}}`. Before: every prompt that transcludes the definition directed its agent to mine `.ok-planner/history/sprints/` for stories. After: no such prompt names the archive. A discovery may draft fewer stories: the ones only an archived sprint showed. Users: in the release: `discover-design/core.md` (its survey, check, sort, merge, and review prompts transclude the block), `_shared/design-doc-compliance-reviewer.md`, and `/plan-sprint` through the compliance reviewer. Every one is vendored by the same true-up. Ruling: rewrite.

**Tested stories**
None.

**Runtime parts**
None.

### Name the closed-issue file in every skill and the administration

**Calls**
- The class is every text that names the closed issues' store. Two forms appear: the path `.ok-planner/history/issues.jsonl`, and the phrase "the archive" (or "archived record") where it means that store. `rg -n "history/issues" plugins` and `rg -n "archive" <the item's files>` enumerate both. Every member below changes. "The archive" stays wherever it means the sprint archive or the `history/` folder. Decided by: plumbline-coding rule 8, a defect is one instance of a class.
- The new name is "the closed-issue file, `.ok-planner/closed-issues.jsonl`" at first mention in each file, and "the closed-issue file" after that. Decided by: the `closed-issues-leave-the-live-file` delta, which names it "the closed-issue file".
- `clarity.md` and `links.md` stage only `.ok-planner/issues.jsonl`, because those tasks close no record. Their staging lines stay as they are, and only their hand-edit bans change. Decided by: `triage-issues/prompts/clarity.md` and `links.md` ("you close no record").
- Markdown issue files under `history/issues/` stay named as an earlier layout's records in `artifact-definitions.md` line 427, `ADMINISTRATION.md` line 149, and "Issue-intake integrity". Decided by: the work item.
- Shared files. `plan-sprint/SKILL.md` Terminal step 1 (line 248) is also changed by "A defect the owner picks joins the sprint's defect list" (another group). This item changes only that step's last clause, "which moves it to `.ok-planner/history/issues.jsonl`". `artifact-definitions.md::{{ISSUE-FILE-FORMAT}}` line 423 is also changed by "The intake rules say a taken defect is fixed by certification". `converge/SKILL.md` and `converge/prompts/owner-list.md` are also changed by the sprint-defects, deferred-verdict, and lock-check items. `design-doc-compliance-reviewer.md` is also changed by the sign-off item. The "Issue-intake integrity" section of `ADMINISTRATION.md` is also changed by "Migrate the archive's bookkeeping at true-up" (this group). Chain the stages that share a file with `--after`. In each paragraph another item rewrites, this item replaces only the store's name.
- The two "whatever the archive holds" phrases in `ADMINISTRATION.md` lines 248 and 326 mean the closed issues' store, so they become "whatever the closed-issue file holds". Line 489 says the same in the `testing.schedule` paragraph, which "Retire `testing.schedule`" rewrites. Whichever stage lands last carries the closed-issue file's name there. Decided by: plumbline-coding rule 1.

**Changes**
- `plugins/ok/families/ok-planner/skills/triage-issues/SKILL.md`: changed. Line 8 names the closed-issue file `.ok-planner/closed-issues.jsonl` as the file that holds closed records, in place of "its archive `.ok-planner/history/issues.jsonl`". Table rows `answered` and `retired` (lines 14 and 16) say "its record moved to the closed-issue file". Line 21 says "a closed one sits in the closed-issue file". Every `--files` list (lines 44, 49, 56, 62, 68, 74) names `.ok-planner/issues.jsonl .ok-planner/closed-issues.jsonl`. Step 1 of the close (line 79) stages `.ok-planner/closed-issues.jsonl` and says "Closing an issue already moved its record to the closed-issue file". Line 88 says "`issues show <id>` prints the closed record".
- `plugins/ok/families/ok-planner/skills/triage-issues/prompts/triage.md`: changed. The hand-edit ban (line 3) and the staging line (line 91) name `.ok-planner/closed-issues.jsonl`. Line 47 says "The close moves the record to the closed-issue file". Line 51 says "does not sit unseen in the closed-issue file".
- `plugins/ok/families/ok-planner/skills/triage-issues/prompts/author.md`: changed. The hand-edit ban (line 3) and the staging line (line 52) name `.ok-planner/closed-issues.jsonl`.
- `plugins/ok/families/ok-planner/skills/triage-issues/prompts/respond.md`: changed. The hand-edit ban (line 3) and the staging line (line 46) name `.ok-planner/closed-issues.jsonl`.
- `plugins/ok/families/ok-planner/skills/triage-issues/prompts/clarity.md` and `links.md`: changed. The hand-edit ban (line 3 in each) names `.ok-planner/closed-issues.jsonl`. Each staging line stays.
- `plugins/ok/families/ok-planner/skills/converge/SKILL.md`: changed. The owner-list `--files` (line 134) and the commit offer's "intake's two files" (line 169) name `.ok-planner/closed-issues.jsonl`.
- `plugins/ok/families/ok-planner/skills/converge/prompts/owner-list.md`: changed. Line 95 says "Closing an issue moves its record to the closed-issue file, `.ok-planner/closed-issues.jsonl`". The hand-edit ban (line 108) names it.
- `plugins/ok/families/ok-planner/skills/drive/SKILL.md`: changed. The owner-list `--files` (line 35) and the commit offer (line 52) name `.ok-planner/closed-issues.jsonl`.
- `plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md`: changed. Line 32 says "a closed issue's record moves to the closed-issue file, `.ok-planner/closed-issues.jsonl`". Line 42 says "a closed issue's record sits in the closed-issue file, which Frame does not read". Line 171 says "which moves the record to the closed-issue file". The last clause of Terminal step 1 (line 248) says "which moves it to `.ok-planner/closed-issues.jsonl`".
- `plugins/ok/families/ok-planner/skills/_shared/artifact-definitions.md`: changed. Line 17 (the "What `.ok-planner/design/` holds" section) names one record per closed issue in `.ok-planner/closed-issues.jsonl`. In `{{ISSUE-FILE-FORMAT}}`: line 329 names `.ok-planner/closed-issues.jsonl` as the second file. Line 363 becomes "A record in the closed-issue file adds ...". Line 365 becomes "a record in the closed-issue file is `closed`". Line 406 becomes "The closed-issue file is a record, so no filer reads it to decide what to file". Line 423 becomes "`issues close` moves a record from the live file to the closed-issue file". Line 427 says "whose `.ok-planner/issues.jsonl` or `.ok-planner/closed-issues.jsonl` holds the pre-v9 event log", and its last sentences say the archived log's conversion "turns its closed issues into closed records". `{{ISSUE-DEFINITION}}` names no store and does not change.
- `plugins/ok/families/ok-planner/skills/_shared/design-doc-compliance-reviewer.md` (the "Out of scope" list, lines 93-95): changed. The bullet reads: the issue intake `.ok-planner/issues.jsonl` and the closed-issue file `.ok-planner/closed-issues.jsonl`, operational state and records, not design artifacts.
- `plugins/ok/families/ok-planner/admin/ADMINISTRATION.md` ("Issue-intake integrity"): changed. Line 252 says closed records sit in `.ok-planner/closed-issues.jsonl`. "The pre-v9 event log" (line 274) says `import --over-event-log` adds the closed records to `.ok-planner/closed-issues.jsonl`. Line 283 says a v9 release moved the pre-v9 log to `history/issues.jsonl`, that true-up moves that file to the closed-issue file first (the migration item), and that a closed-issue file holding event rows converts as its own step, "as closed records". Lines 248 and 326 say "whatever the closed-issue file holds".

**Behavior changes**
- **B305** The `--files` lists of the triage batches, the `/converge` owner list, and the `/drive` owner list (`triage-issues/SKILL.md`, `converge/SKILL.md`, `drive/SKILL.md`). Before: each task could edit `.ok-planner/history/issues.jsonl`. After: each can edit `.ok-planner/closed-issues.jsonl`. Users: in the release: the intake module (need C), which writes closed records to the new path, and the task tracker, which records each task's staged paths against the list. Both ship in the same true-up. Ruling: rewrite.
- **B306** Each staging line, commit offer, and hand-edit ban in the skills and prompts above, and the "Issue-intake integrity" text. Before: they named `.ok-planner/history/issues.jsonl`. After: they name `.ok-planner/closed-issues.jsonl`. Users: in the release: the owner's commits, which stage the file true-up's migration moved there, and every vendored copy of these skills, which the same true-up writes. Across trued-up projects: the stored file is moved by "Migrate the archive's bookkeeping at true-up". Ruling: rewrite.

**Tested stories**
None.

**Runtime parts**
None.

### Describe the write-only archive in the estate's rules text

**Calls**
- The estate rules text's task tracker section (`scripts/ok-planner-CLAUDE.md`), which lists what `.ok-planner/.cache/` holds and when to delete it, names `tests-machine.json`, so deleting `.cache/` does not drop a lowered worker count without a word. Decided by: the notes review's build note.
- The ok-conduct style's rule (B308) keeps a running skill's step as a direction: it tells the agent to follow the project's own rules on what reads `history/`, and, absent a skill step or the owner's word, to read none of it. The style then reads right both in a project on this release and in one still on v31.1.0, whose skills read the archive as steps. Decided by: the Installed plugins boundary (ok-conduct updates apart from any project) and the notes review.
- Each file gains one statement of the archive rule, in the section that already lists the records. Each passage that named a closed issue's archive path, a `closed:` stamp, or an archived sprint read for intent is rewritten in place. Decided by: the cheatsheet's writing standard ("Say it once and only once"), and the work item's list of what the text says.
- The conduct output style names the three live bookkeeping files by path, and keeps its rule that `history/` is not pulled into context. In a project not yet trued up, the closed issues still sit at `history/issues.jsonl`, under that same rule, so the text reads right in both layouts. Decided by: the "Installed plugins" release boundary, under which ok-conduct updates apart from any project's true-up.
- The family dev note's file map line for `scripts/review` (line 39) names the closed-record ledger's reader and writer that `scripts/docs`, `scripts/tests`, and the true-up core load, in place of "the sprint frontmatter reading (the closed: stamp and the sprints closed since one)". The line's final wording follows the names the ledger group gives (need L). Decided by: plumbline-coding rule 1.
- Shared files. "The intake rules say a taken defect is fixed by certification" changes the cheatsheet's "Routing" and "Closing", and the estate note's intake closing paragraph and lifecycle summary. This item touches the "Closing" paragraph only to name the closed-issue file in its first sentence, and touches the lifecycle summary only for its sketch and close-out sentences. Chain the stages with `--after`.

**Changes**
- `plugins/ok/families/ok-planner/scripts/ok-planner-CLAUDE.md`: changed.
  - The intake section's opening says "Closing an issue moves its record to the closed-issue file, `closed-issues.jsonl`, a record out of agent context by default". It drops "the archive, `history/issues.jsonl`, a record like the rest of `history/`".
  - The "Promoted" bullet says "The record moves to the closed-issue file when the sprint's implementation closes".
  - "Earlier layouts" names `closed-issues.jsonl` in place of `history/issues.jsonl`. It says true-up first moves an earlier release's `history/issues.jsonl` there, and that the archived log's closed issues convert "into closed records".
  - The tests section's last paragraph says the closed-record ledger lists each test sprint an earlier release closed, with its closing commit, and that `/plan-sprint`'s reconcile step reads that commit from the ledger as the run's work. It drops "the commit an archived test sprint's `closed:` stamp names".
  - The docspecs section says the planner reads the closing commits of the sprints closed since the stamp for intent. It drops "reading the sprints closed since the stamp".
  - The "Project records" heading list gains `closed-records.jsonl`, `closed-issues.jsonl`, and `test-plans/`. The section gains one paragraph. It says that no tool or agent reads `history/` on its own, save true-up's one migration of an earlier release's bookkeeping. It says that an agent reads an archived record when the owner directs it, and never to learn the project's current state. It says that each archive step writes the bookkeeping first and picks its archive names from the ledger. It says where the bookkeeping lives: the closed-record ledger, `closed-records.jsonl`, which lists each closed sprint, closed documentation sprint, and earlier test sprint with its closing commit, each archived sketch's name, and each name true-up moved into the archive; the closed-issue file; and the test-plan folder, `test-plans/`. The `history/` sentence drops "`issues.jsonl`, the closed issues' records that `bin/issues` writes".
  - "Executing a sprint": the close-out records the sprint's closing commit in the closed-record ledger before it moves the sprint into the archive, and that entry is the baseline the next `/plan-sprint` reads. It drops the `closed: <sha>` frontmatter sentence.
  - The lifecycle summary says Terminal records each sketch in the ledger, then moves it to `history/sketches/`.
- `plugins/ok/families/ok-planner/scripts/ok-planner-cheatsheet.md`: changed.
  - The intake bullet says "Closed records move to `closed-issues.jsonl`".
  - The records bullet gains the closed-record ledger, the closed-issue file, and the test-plan folder. Its `history/` sentence says the archive is write-only: no tool or agent reads it on its own, save true-up's one migration; an agent reads an archived record when the owner directs it, never to learn the current state; and each archive step writes the bookkeeping first and picks its names from the ledger. It drops "`history/test-sprints/` holds the test sprints an earlier release ran" as a reading direction, and keeps it as a folder of the archive.
  - "Lifecycle" says that on completion the archive step records the close in the closed-record ledger, then moves each artifact to its same-named folder under `history/`, and that `/plan-docs` reads closing commits for intent.
  - "Defect issues" (line 188) names its closed records' file as `.ok-planner/closed-issues.jsonl`. "Closing" (line 291) says `issues close` moves the record to `.ok-planner/closed-issues.jsonl`.
- `plugins/ok/families/ok-planner/CLAUDE.md` (the family's development note): changed. The intake paragraph (line 73) says "closing an issue moves its record to the closed-issue file, `.ok-planner/closed-issues.jsonl`". The paragraph gains one sentence on the write-only archive and the three bookkeeping files. The `scripts/review` file-map line (line 39) changes as the Calls say.
- `plugins/ok-conduct/output-styles/ok-conduct.md` (lines 217 and 219): changed. The parenthesis names `closed-issues.jsonl` as the closed issues' file, a record out of context like the closed-record ledger `closed-records.jsonl` and the test plans under `test-plans/`. It drops "`history/issues.jsonl` holds the closed issues and is archive like the rest of `history/`". The text says that no tool or agent reads `history/` on its own, and that the owner may direct a read of an archived record, never to learn the project's current state. The default-behavior sentence names the live bookkeeping files beside `sprints/` and `history/`.

**Behavior changes**
- **B307** `scripts/ok-planner-CLAUDE.md`, `scripts/ok-planner-cheatsheet.md`, and `CLAUDE.md`, materialized into each consumer's `.ok-planner/CLAUDE.md` and `.claude/rules/ok-planner-cheatsheet.md`. Before: the rules text placed closed issues in `history/issues.jsonl`, the close in a `closed:` stamp, and the reconcile and `/plan-docs` intent in archived sprints. After: the text says the archive is write-only and names the three live bookkeeping files. Users: in the release: every agent in a consumer project, through the rules files true-up overwrites in the same step that vendors the tools that write those files. Ruling: rewrite.
- **B308** `plugins/ok-conduct/output-styles/ok-conduct.md`. Before: the style told the user's sessions that `history/issues.jsonl` holds the closed issues. After: it names `closed-issues.jsonl` and the other two bookkeeping files, and states the write-only rule. Users: across installed plugins: a user who updates ok-conduct before trueing up a project. That user's project still keeps its closed issues under `history/`, which the style still keeps out of context, so no instruction misleads in either layout. Ruling: preserve (call).

**Tested stories**
None.

**Runtime parts**
None.

### Drop the folder finding from the true-up check

**Calls**
- The front door's check is prose the `/ok` session follows. No true-up code drafts folders: `admin/true-up` writes `"folders": ["."]` only as a former setting (`FORMER_PROJECT_SETTINGS`), and that stays. `plugins/ok/skills/ok/SKILL.md` step 7 restates the read ("the sprints' outside paths"), so it changes too. Decided by: plumbline-coding rule 1. `rg "Paths outside" plugins` lists `scripts/review::OUTSIDE_HEADING` and `_sprint/shared.md`, which read the live sprint's own section for that sprint's scope, and `ADMINISTRATION.md`, which this item changes.
- B309's ruling is `rewrite`. The check's one reader, the `/ok` session's skill text, ships in the same `ok` plugin as the administration document. The person running `/ok` sees one fewer proposed draft. That draft always needed the person's yes, and nothing the person does stops working, so the owner-question test's second condition does not hold. The `project-declares-its-folders` delta commits that true-up "proposes no other entry, whatever a sprint or the archive names". Decided by: the `project-declares-its-folders` delta, and the owner-question test.
- `ADMINISTRATION.md` is also changed by four other items. This item touches only the "What it reads" table and the paragraph after it.

**Changes**
- `plugins/ok/families/ok-planner/admin/ADMINISTRATION.md` ("Check the project against the carried version"): changed. The table row for `## Paths outside the project root` goes. The paragraph "A folder finding drafts the folder into `folders` ..." goes. "**`amend` draft.**" names no folder finding. One sentence in the section says that `folders` changes only by the owner's word, save true-up writing the estate root alone into a project that declares no list.
- `plugins/ok/skills/ok/SKILL.md` (step 7, "Check"): changed. The list of what it reads drops "the sprints' outside paths".

**Behavior changes**
- **B309** `ADMINISTRATION.md` "Check the project against the carried version", followed by `plugins/ok/skills/ok/SKILL.md` step 7. Before: after each true-up, the check read `## Paths outside the project root` in every live and archived sprint and drafted each folder `folders` lacked into an `amend` draft of `.ok-planner/config.json`, or into a report line. After: the check reads no sprint and drafts no folder. Users: in the release: the `/ok` skill text, shipped in the same plugin. A person running `/ok` no longer sees the proposed draft, and every `folders` entry they wrote stays. Ruling: rewrite.

**Tested stories**
None.

**Runtime parts**
None.

### Migrate the archive's bookkeeping at true-up

**Calls**
- Plan order. The three migration steps are built first in `admin/true-up::build_plan`, before `legacy_steps`, in this order: the closed-issue move, the ledger write, then the test-plan moves. So the intake conversions meet the closed-issue file at its new path, and every later archive step finds the ledger's names. Decided by: the work item ("before every intake conversion"), and `decision:archive-read-by-nothing` (bookkeeping before any move into the archive).
- Each step is a `DRIFT:` step, because each moves or writes to a live path. The step lines are:
  - `DRIFT: moves .ok-planner/history/issues.jsonl to .ok-planner/closed-issues.jsonl, the closed-issue file the intake module reads, before every intake conversion; a dashboard service started before this true-up writes closed issues to the earlier path until it is stopped and started again`
  - `DRIFT: writes .ok-planner/closed-records.jsonl, the closed-record ledger, from what the archive holds, once: <s> sprint(s), <d> documentation sprint(s), and <t> test sprint(s) with their closing commits, <k> sketch(es), and <a> other archived name(s)`
  - `DRIFT: moves the test plan of each closed sprint the ledger lists into .ok-planner/test-plans/: <src> -> <dst>, ...`

  The dashboard clause is there because `scripts/dashboard` loads the intake module once, at start (`issues = load_sibling("issues")`). Decided by: the work item ("`DRIFT:` steps, with no consent of their own"), and the sibling note true-up prints after a retired script's removal.
- "Stops naming both files where both exist" means this: where `.ok-planner/history/issues.jsonl` and the closed-issue file both stand, the plan plans no move, and the apply refuses, writing nothing, with "`.ok-planner/history/issues.jsonl` and `.ok-planner/closed-issues.jsonl` both stand; keep the closed records in `.ok-planner/closed-issues.jsonl` alone, then run /ok again". Diagnose prints the same as a `blocked:` line. The shape copies the sibling `admin/true-up::plumbline_classes_refusal`, which appends to `plan["blocked"]` and `plan["refusals"]`. Decided by: the work item, and A2 (one closed record file must not overwrite the other).
- The move runs under the intake module's lock, `carried_intake().locked(root)`, so no intake write is in flight while the file moves. Decided by: plumbline-coding rule 3.4, and the sibling rule that every intake write holds that lock.
- The closed-issue file's path, the ledger's path, and the test-plan folder's path come from the carried intake, review, and tests modules. True-up writes no second copy of any of them. Decided by: plumbline-coding rule 6, and needs (C), (L4), and (T).
- An archived sprint, documentation sprint, or test sprint is a top-level `.md` file of its folder that no other `.md` file's stem names as a companion. `X-<suffix>.md` is a companion where `X.md` stands in the same folder. That is the general form of `admin/true-up::open_test_sprints`'s `TEST_SPRINT_BESIDE` rule, and sprint companions carry free-form suffixes (`-completion`, `-build`, and each role prompt). Decided by: the work item ("a `.md` file that is no companion of another's stem"), and the sibling `open_test_sprints`.
- A sprint, documentation sprint, or test sprint whose frontmatter holds no valid `closed:` stamp gets an `archived` entry under its archive path, not a kind entry. The ledger's kinds carry a closing commit (the ledger item). Reconcile and the test-plan order then skip it, as they skipped an unstamped file before. Its `-plan.json` stays in the archive. Decided by: the ledger item ("for every kind but `sketch` and `archived`, its closing commit"), and the work item ("that the ledger lists with a commit"). Repository history shows no spec or backlog carrying a `closed:` stamp: the stamp first appears in 6d332b6, after the specs-to-sprints rename in v5.0.0.
- Entry order. Entries that carry a commit come first, ordered by `git rev-list --count <commit>`, then by name. An ancestor always counts fewer commits than its descendant, so this order agrees with ancestry and is total. A commit git cannot resolve sorts before every resolvable one, by name, so the last sprint entry, which Reconcile takes as its baseline, is a commit git holds. `sketch` entries follow, then `archived` entries, each group by path. A comparator over `is_ancestor` alone is no total order, and a sort over it may disagree with ancestry. Decided by: the work item ("ordering entries by commit ancestry, then by name"), and the `closing-commit-baseline` delta (the baseline is the newest sprint the ledger lists).
- A `sketch` entry is each top-level file under `history/sketches/`, named by its file name. Every other file the archive holds gets an `archived` entry, named by its path under `history/`. The exceptions are `history/issues.jsonl` and each `-plan.json` the plan moves out. A plan that stays in the archive because its name is taken gets an `archived` entry. Decided by: the work item.
- The ledger is written through the carried review tool's writer (need L2), in one write of every entry, where `.ok-planner/closed-records.jsonl` is absent and the archive holds at least one file. With nothing to write, no step is planned, and a later archive step of the same plan creates the file. Decided by: the work item ("where ... absent"), and `decision:archive-read-by-nothing` (one writer).
- Test-plan moves. Each `-plan.json` beside a ledger-listed sprint or test sprint moves with `move_step` to `<test-plans>/<stem>-plan.json`. The moves go in ledger order, so where a sprint and a test sprint share a stem, the first takes the name. A plan whose destination already stands stays where it is, and `plan["notes"]` gets `left: <plan> stays in the archive: .ok-planner/test-plans/<name> already stands`. Diagnose prints that line, and the `/ok` report relays it with the other `left:` lines. Decided by: the work item, and the sibling `move_step` (the review estate's moves).
- `test-plans` joins `SUBDIRS` and the `ADMINISTRATION.md` layout list. The sprint template's archive step (the "Write a sprint's bookkeeping before its archive move" item) moves a plan there with `git mv`, which needs the folder to stand, and `history/sprints` is created the same way today. Decided by: the sibling `SUBDIRS` entries for `history/*`. The sprint-document group's archive step should also `mkdir -p` the folder, as `plan-sprint/SKILL.md` already does for `history/sprints`.
- Diagnose plans `legacy_archive_steps` from the closed-issue file where it stands, and otherwise from `history/issues.jsonl` where the move is pending. That one read is part of the migration. The step's line names `.ok-planner/closed-issues.jsonl`. The step's dry-run refusal runs before the move, so the intake module cannot see the moved file's records. Where that file held v9 records beside pre-v9 event rows, an import refusal can surface at apply instead. True-up then stops with the module's message after the move and the ledger write, both of which are complete, and the next `/ok` replans with a faithful dry run. Decided by: A1 (no half-changed file: the move is one rename, and the ledger write is one atomic replace), and plumbline-coding rule 6 (true-up does not copy the module's checks).
- The markdown conversion's check of a promoted file's sprint counts the sprint as found in three cases: `.ok-planner/sprints/<name>` stands, the ledger (or the migration's planned entries) lists a `sprint` entry of that name, or an `archived` entry `sprints/<name>` stands for an unstamped archived sprint. The refusal says "names no sprint under sprints/ or in the closed-record ledger". Decided by: the work item.
- The LICENSE text true-up writes lists the project's own records. It gains "the closed-record ledger, the closed-issue file, the test plans" beside "history". Decided by: plumbline-coding rule 1 (the list restates the set of project records, and the closed-issue file leaves `history/`).
- `checks/owned-paths` pins true-up's write roots. It gains needles: the closed-issue move's destination is the carried intake module's path; the test plans' destination is the carried tests module's folder; and the ledger is written only through `carried_review()`. It also gains a region for the new locked-move function in `move_path`'s allowed call sites. This follows the sibling needles, such as `MARKDOWN_HISTORY` and `carried_dashboard().write_build(`. Decided by: the cheatsheet's "Every written constraint needs a check", and the sibling needles.
- `admin/true-up` is also changed by "Retire `testing.schedule`", "Convert earlier declarations to locks on true-up" (other groups). Those touch `CONFIG_CHECK_KEYS`, a convert-state step, and filings, and none of them is a definition this item changes, but `build_plan` gains steps from both sides. `ADMINISTRATION.md` is shared with those items and with this group's other items. Chain the stages with `--after`.

**Changes**
- `plugins/ok/families/ok-planner/admin/true-up::CLOSED_ISSUES`: new. `os.path.join(root, carried_intake().<closed-issue path constant>)` (need C). `LEGACY_ARCHIVE` stays as the migration's source path.
- `admin/true-up::closed_issues_step(plan)`: new. Where `LEGACY_ARCHIVE` stands and `CLOSED_ISSUES` does not, it plans the move step the Calls name. Its run is a new `locked_move(src, dst)`, which holds `carried_intake().locked(root)` around `move_path(src, dst)`. It adds both paths to `plan["taken"]`, `plan["destinations"]`, `plan["gone"]`, and `touched`, as `move_step` does. Where both stand, it adds the refusal and the `blocked:` line the Calls name.
- `admin/true-up::closed_issue_source()`: new. It returns `CLOSED_ISSUES` where that path stands, and otherwise `LEGACY_ARCHIVE` where the move is pending.
- `admin/true-up::legacy_archive_steps`: changed. It reads its rows from `closed_issue_source()`. Its line names `.ok-planner/closed-issues.jsonl`, and its `touched` names the closed-issue file.
- `admin/true-up::archive_migration()`: new, lru-cached. It returns `None` where the ledger exists. Otherwise it scans `history/sprints/`, `history/doc-sprints/`, `history/test-sprints/`, `history/sketches/`, and every other file under `history/`. It reads each kind file's `closed:` stamp with `carried_review().closed_stamp` (need L3), orders the entries as the Calls say, and returns `{"entries": [...], "plans": [(src, dst)], "kept_plans": [...]}`. This function is the one read of the archive any true-up step makes.
- `admin/true-up::ledger_step(plan)`: new. Where `archive_migration()` returns entries, it plans the ledger step. Its run calls `carried_review().<writer>(root, entries)` (need L2) and prints `written: .ok-planner/closed-records.jsonl — <the counts>`.
- `admin/true-up::test_plan_steps(plan)`: new. It plans one `move_step` per entry of `archive_migration()["plans"]`, into `TEST_PLANS_DIR`, and adds a `left:` note per kept plan.
- `admin/true-up::TEST_PLANS_DIR`: new. `os.path.join(root, carried_module(TESTS_SRC).<test-plan folder constant>)` (need T).
- `admin/true-up::ledger_entries()`: new. It returns the carried reader's entries where the ledger exists (need L1), and otherwise `archive_migration()["entries"]`. The archive-name item, `issue_defects`, and `test_plan_steps` read through it.
- `admin/true-up::build_plan`: changed. It calls `closed_issues_step`, `ledger_step`, and `test_plan_steps` first, before `legacy_steps`.
- `admin/true-up::issue_defects` (the `status: promoted` check): changed. It reads `.ok-planner/sprints/` and `ledger_entries()`, never `history/sprints/`, and its message names the closed-record ledger.
- `admin/true-up::SUBDIRS`: changed. It gains `"test-plans"`.
- `admin/true-up` (the LICENSE heredoc, "It does not cover this project's own work ..."): changed, as the Calls say.
- `checks/owned-paths::check_planner`: changed, with the needles and the `move_path` region the Calls name.
- `plugins/ok/families/ok-planner/admin/ADMINISTRATION.md`: changed.
  - A new subsection under "Layout migration", "The archive's bookkeeping moves to live files", describes the three steps, their lines, their order, the companion rule, the unstamped-sprint rule, the entry order, the kept-plan note, the both-files refusal, and that after the migration no true-up step reads a file under `history/`.
  - "What each kind of content becomes" gains three rows: an earlier release's `history/issues.jsonl`; an archive with no closed-record ledger; and a test plan beside a closed sprint in the archive.
  - The layout list in "The core's modes" (line 36) gains `test-plans/`.
  - "Issue-intake integrity" (line 283, shared with the closed-issue name item) says the move happens first.
  - The owned-set sentence in "What the administration does NOT do here" (line 494) adds three writes: the closed-record ledger, through the carried review tool's writer; the closed-issue file, which the plan moves out of the archive; and the test plans, which it moves into `test-plans/`.
  - The callers paragraph (line 322) names the three bookkeeping files among the records the sweep skips.

**Behavior changes**
- **B310** `admin/true-up::closed_issues_step`, and `legacy_archive_steps` reading the new path. Before: the closed issues stayed at `.ok-planner/history/issues.jsonl`, and the archived-log conversion read and wrote that path. After: the first plan step moves the file to `.ok-planner/closed-issues.jsonl`, and the conversion reads it there. Users: in the release: the intake module (need C), the dashboard through it, and every skill text of the closed-issue name item. Across trued-up projects: the stored file in every project an earlier release wrote. A project that declines the true-up keeps its vendored copies, which read the old path. A dashboard started before the true-up keeps the earlier module until restarted, and the step line says so. Ruling: migrate: true-up moves the file once, as a `DRIFT:` step before every intake conversion, and refuses, writing nothing, where both files stand (call).
- **B311** `admin/true-up::archive_migration` and `ledger_step`. Before: each close was recorded only as a `closed:` stamp on the archived file, read by `review certified`, Reconcile, `tests`, and `docs`. After: the ledger holds the same closes, each archived sketch's name, and each other archived file's path. Users: in the release: the ledger group's readers (`review certified`, `review closed`, `sprints_closed_since`, `tests`'s plan order, and `docs window`), all vendored by the same true-up. Across trued-up projects: every archived record an earlier release closed. Ruling: migrate: true-up writes the ledger from the archive once, where it is absent, before any other step reads it (call).
- **B312** `admin/true-up::test_plan_steps`. Before: a closed sprint's `-plan.json` sat beside it in `history/sprints/` or `history/test-sprints/`, where `tests::archived_plans` read it. After: true-up moves it to `.ok-planner/test-plans/<stem>-plan.json`, and a plan whose name is taken stays, with a `left:` note. Users: in the release: the tests tool's earlier-plan reader (need T). Across trued-up projects: each project's archived plans. Ruling: migrate: true-up moves each plan the ledger lists with a commit, and reports each plan it leaves (call).
- **B313** `admin/true-up::issue_defects`. Before: a promoted markdown issue passed where its sprint stood under `sprints/` or `history/sprints/`. After: it passes where the sprint stands under `sprints/` or the ledger lists it. The ledger lists every archived sprint, as a `sprint` or an `archived` entry, so the same files pass. The refusal's wording changes. Users: in the release: the markdown conversion step only. Ruling: rewrite.
- **B314** `admin/true-up` (the LICENSE heredoc). Before: the materialized `LICENSE` listed "history" as the project's own. After: it also lists the closed-record ledger, the closed-issue file, and the test plans. Users: in the release: the estate `LICENSE`, which true-up overwrites. Ruling: rewrite.

**Tested stories**
None.

**Runtime parts**
None.

### Pick archive names from the ledger and retire the every-run archive moves

**Calls**
- A held archive name is every ledger entry's path under `history/`. A `sprint` entry maps to `sprints/<name>`, a `doc-sprint` entry to `doc-sprints/<name>`, a `test-sprint` entry to `test-sprints/<name>`, a `sketch` entry to `sketches/<name>`, and an `archived` entry to its own path. A sprint, documentation sprint, or test sprint entry also holds `<folder>/<stem>-*`, its companions. A path is held where it equals a held name, lies below one, or holds one below it. The work item names only `archived` entries. Counting the kind entries keeps true-up's archive of an open test sprint from taking a closed test sprint's name under `history/test-sprints/`. Companion prefixes cover the files a later sprint's archive step moves without entries of their own. Decided by: `decision:closing-commit-baseline` ("so an archive step picks a free name without reading the archive"), and A2.
- Moves into the archive that `migration_steps` (`plans/` and `coverage/` to `history/`, and `design/review-notes*.md` to `history/`) and `plumbline_plan` (`audits/subjects/` to `history/audits/subjects/`) make check the held names, not `os.path.exists` or `os.path.lexists`. Moves to a live path keep their existence check. Decided by: the work item ("Every true-up step that moves a file into `.ok-planner/history/`").
- The apply's refusal of "a path the plan moves a file to already stands" (`prechecks`) stays as a guard. It picks no name and draws no fact about closed work. A file someone placed in the archive without an entry now stops the apply, naming the path, where today it took a suffix. Decided by: A2 (a move must not overwrite), and the rejected alternative in `archive-read-by-nothing` (probing the archive for a free name).
- Three more checks stay, because each reads only whether a path exists or can be written, and reads no record: `subdir_steps`'s `isdir` checks of the `history/*` layout folders; `intake_migration_refusals`'s writability check of the nearest existing folder; and `convert_moving`'s `missing_folders`, which `move_back` uses to remove only the folders the step created. If the build reads "reads a path" more strictly, the alternative is to drop `history/*` from `SUBDIRS`, and then the sprint, sketch, and documentation sprint archive steps must `mkdir -p` before their `git mv`. Decided by: A2 for the cleanup case, and `plan-sprint/SKILL.md` line 36, which creates the same folders.
- `script_plan`'s and `provenance_stamped`'s `git grep` take the pathspec `:(exclude).ok-planner/history`. `caller_kind` already skipped every archived file as a record, so nothing observable changes. True-up just stops reading the archive's contents. Decided by: the work item ("no true-up step but the migration reads a path under `.ok-planner/history/`").
- Recording. One helper, `record_archived(dsts)`, writes one `archived` entry per file the move or copy places, through the carried writer (need L2), before the write it guards. It runs at the top of `archive(pairs)`, which batches every pair of its step and covers `retire_rule_file` through that call; in `move_path` where its destination lies inside `ARCHIVE_DIR`; in `archive_copy`; and in `move_all` where its destination lies inside `ARCHIVE_DIR`. A folder move records each file under the source at its new path. Where `move_back` undoes a conversion, the entries stay as held names, since the ledger only appends. Decided by: `decision:archive-read-by-nothing` ("writes the bookkeeping before it moves a file into the archive"), and plumbline-coding rule 3.1 (one write per step).
- `archive_path`'s signature and `retire_rule_file`'s `archive([(path, archive_path(path))])` call stay as they are, so `checks/owned-paths`'s `archive_path` region anchor and its `archive` call key stand. Decided by: `checks/owned-paths` lines 396 and 554.
- `MIGRATION_DIRS` drops `("history/backlogs", "history/sprints")` and `("history/specs", "history/sprints")`. `migration_moves`, `migration_steps`, and `remove_emptied` iterate the tuple, so they stop reading both folders with no edit of their own. Decided by: the work item.

**Changes**
- `plugins/ok/families/ok-planner/admin/true-up::archive_held(path)`: new. It answers whether `path` is held by `ledger_entries()` (from the migration item), under the mapping and prefix rules the Calls name.
- `admin/true-up::free_path`: changed. It loops while `archive_held(found) or found in taken`, never `os.path.lexists(found)`. Every caller (`archive_path`, and through it `archive_pairs`, `archive_step`, `record_folder_step`, `copy_step`, `retire_rule_file`, `conflict_archives`, and `removal`) and `discover_notes_step` then take ledger-free names.
- `admin/true-up::discover_notes_step`: changed only through `free_path`. Its line's "each name the archive already holds takes a suffix" becomes "each name the closed-record ledger or the plan already holds takes a suffix", and the same wording change goes into `record_folder_step`'s line.
- `admin/true-up::record_archived(dsts)`: new, as the Calls say. It is called in `archive`, `move_path` (archive destinations), `archive_copy`, and `move_all` (archive destinations).
- `admin/true-up::MIGRATION_DIRS`: changed. Both `history/` entries go.
- `admin/true-up::migration_steps`: changed. A destination inside `ARCHIVE_DIR` counts as taken by `archive_held(dst)`. Any other destination keeps `os.path.exists(dst)`.
- `admin/true-up::plumbline_plan` (the `PLUMBLINE_OWNER_DIRS` loop): changed. A target inside `ARCHIVE_DIR` counts as taken by `archive_held(dst)`, not `os.path.lexists(dst)`.
- `admin/true-up::intake_migration_refusals`: changed. `taken` lists the destinations `archive_held` holds, and the cause reads "the closed-record ledger already lists <names> under <folder>/". This covers the markdown and tensions conversions.
- `admin/true-up::script_plan` and `provenance_stamped`: changed. Each `git grep` excludes `.ok-planner/history`.
- `checks/owned-paths::check_planner`: changed. It gains a needle that `record_archived` writes through `carried_review()`.
- `plugins/ok/families/ok-planner/admin/ADMINISTRATION.md`: changed.
  - "The archive" (line 115) replaces "A move into a taken path merges entry by entry, and a taken file name gets `-2`, `-3`, and so on" with the name rule. Each step picks the name from the closed-record ledger and the names its own plan takes, never by looking at what the archive holds. A held file name gets `-2`, `-3`, and so on before its extension. Each move or copy into the archive records an `archived` entry first. An apply refuses a destination that already stands.
  - "Layout migration" (line 262): the first bullet keeps `backlogs/` and `specs/` to `sprints/`, and says an archive that still holds `history/backlogs/` or `history/specs/` keeps it as an earlier release's records.
  - Lines 467 and 480 say the suffix comes from the ledger rule.
  - "Issue-intake integrity" says the markdown step refuses where the closed-record ledger already lists a file name under `history/issues/`.

**Behavior changes**
- **B315** `admin/true-up::free_path`, and through it every archive step. Before: a destination took a `-2`, `-3` suffix where that path stood in the archive. After: it takes one where the ledger or the plan holds the name. Where a file stands in the archive with no entry, the apply refuses, naming the path, where it used to take a suffix. Users: in the release: every archive step of true-up and the resolve mode's `retire_rule_file`. Across trued-up projects: each project's archive, which the migration item lists in the ledger first. Only a file placed there by hand afterward meets the refusal. Ruling: migrate: the archive migration lists every file the archive holds before any step picks a name (call).
- **B316** `admin/true-up::MIGRATION_DIRS`. Before: every true-up moved each entry of `history/backlogs/` and `history/specs/` into `history/sprints/`, archiving a taken name, and removed the emptied folders. After: both folders stay where they are. Users: in the release: none. No carried reader reads `history/sprints/` for a sprint any more (the ledger item), and no spec or backlog carries a `closed:` stamp, so no baseline is lost. Across trued-up projects: a project upgraded from before v5.0.0 that still holds those folders. Ruling: preserve (call). Decided by: the `skills-read-only-the-current-layout` delta ("A record in the archive keeps the form it closed with").
- **B317** `admin/true-up::record_archived`, at the four sites. Before: an archive move wrote only the moved file. After: it also appends one `archived` entry per file to `.ok-planner/closed-records.jsonl` before the move. Users: in the release: the ledger's readers (need L), and later true-ups' name picks. Ruling: rewrite.
- **B318** `admin/true-up::intake_migration_refusals`. Before: the markdown and tensions conversions refused where `history/issues/` or `history/tensions/` already held a file of a moved name. After: they refuse where the ledger lists that name, with a reworded cause. Users: in the release: the two conversion steps only. Across trued-up projects: the migration lists every file those folders hold, so the same names are refused. Ruling: rewrite.

**Tested stories**
None.

**Runtime parts**
None.


### Add the run-time cost rule to the coding rules

**Calls**
- The rule is `## 16. Weigh what the design costs at run time`, after rule 15, in its siblings' shape:
  - **Prevents:** work the product repeats at run time that a design of the same clarity avoids, so each request or page pays for calls, reads, and computation its answer never uses.
  - Step 1: before writing a path that serves a request, a page, or a listing, name what it costs at run time as rule 4 names its exits: the calls it makes, the data it reads, and how each grows.
  - Step 2: the four patterns as the work item names them, each with the form that removes it: one call per request or a value stored at write time; read only what the page or reply shows; keep a rarely changing answer until it changes; wait on the event or change marker.
  - Step 3: keep the plainer design wherever a faster one costs clarity, and add no cache, index, or batch the four patterns do not call for.
  - Step 4: the task note names each wasteful pattern the change kept, with why.

  Decided by: the work item and the shape of rules 10 to 15.
- The opening paragraph's "Rules 1 to 11 come from about 870 verified defects" stays true, so it stays. Decided by: the file.
- The cheatsheet's ambient line goes under a new `## Run-time cost` section after `## Testability`, as `## Settings` and `## Time controls` each carry one coding rule's line. Its text: "- Design away plainly wasteful work: a remote call per row where one call per request or a value stored at write time serves, data the reply never shows, a rarely changing answer recomputed on every request, a timer poll where an event or change marker exists; keep the plainer design wherever a faster one costs clarity". Decided by: the work item ("one ambient line") and the cheatsheet's section-per-rule shape.
- `{{CONVERGE-CODING-RULES}}` (`skills/_converge/coding-rules.md`) stays as it stands. Its first sentence binds every rule but 2 and 8, and its own note says "every rule the coding rules file adds binds with no edit here". The lean test profile's `lean-section` list (`agents/ok-test.md`) stays as it stands: it names the coding rules a test writer needs. Decided by: those files.
- No accept-list entry is added, and A8 reaches the rule. Decided by: the work item.
- Shared file: `docs/plumbline-cheatsheet.md` is also changed by "State the lock model in the testing standard and the cheatsheet" (the Tests section). The two edits touch different sections.

**Changes**
- `plugins/ok/families/ok-planner/docs/plumbline-coding.md`: changed. It gains rule 16, as the Calls give it.
- `plugins/ok/families/ok-planner/docs/plumbline-cheatsheet.md`: changed. It gains the `## Run-time cost` section and its one line.

**Behavior changes**
- **B510** `plugins/ok/families/ok-planner/docs/plumbline-coding.md` and `docs/plumbline-cheatsheet.md`, materialized as `.claude/rules/plumbline-coding.md` and `.claude/rules/plumbline-cheatsheet.md`. Before: no rule names run-time cost, and review counts no wasteful call or read as a defect. After: every agent that writes code designs away the four patterns, and a reviewer counts a site rule 16 leaves one compliant form for as an A8 defect, or as a question where two remain. Users: in the release: every build, fix, and test task that loads the rules; `/converge` hunts and merges through A8. Across Trued-up projects: the rules files keep their names, and their text is suite-owned and overwritten whole at true-up, so a project gets the rule and its reviewers together, on the owner's `/ok`. Ruling: rewrite.

**Tested stories**
- None.

**Runtime parts**
- None.

### Write a headless browser server from `/setup-web`

**Calls**
- The headless entry is `"chrome-devtools-headless": {"command": "npx", "args": ["-y", "chrome-devtools-mcp@latest", "--headless", "--isolated"]}`. `-y` and `@latest` are the headed entry's npx form, not server flags. `--isolated` gives each server process a temporary profile, so the entry carries no `--userDataDir`. Decided by: the work item ("`--headless --isolated` and no other flag") and the headed entry's form.
- The merge runs per key. A missing key is added, touching nothing else. A matching entry is a no-op. A differing entry is shown beside the default and left standing. The headed entry's migration from the suite's prior default, `["-y", "chrome-devtools-mcp@latest"]`, applies to the headed key alone, since no earlier release wrote a headless entry. A bare project's `.mcp.json` is written with both entries. Decided by: the work item and the skill's merge-never-clobber rule.
- The intro paragraph's "launches and owns its own headed Chrome" becomes a sentence naming both servers. The report's paragraph on two sessions in the same project names the headless server as the one a second session uses. The `/mcp` check names both servers. Decided by: the work item ("The skill's report says ...") and coding rule 1.
- `README.md`'s "sets up the browser MCP server" stays as it stands: the `readme` docspec governs README.md, and only a documentation sprint writes it. `plugins/ok-web/CLAUDE.md`'s "the `chrome-devtools-mcp` browser server" stays true of two entries that run the same package. Decided by: the cheatsheet's documentation rule and the CLAUDE.md text.
- Project-specific Chrome arguments stay out of both entries. Decided by: the work item.

**Changes**
- `plugins/ok-web/skills/setup-web/SKILL.md`: changed.
  - The intro paragraph names a headed server with a per-project profile and a headless server with an isolated, throwaway profile.
  - Step 3 shows both entries in its JSON block and applies the merge rules per entry, with the prior-default migration kept for `chrome-devtools` alone.
  - Step 5's report says what changed for each entry. It says to use `chrome-devtools-headless` for unattended work and for a second session in the same project, and `chrome-devtools` where the owner needs to watch the browser or log in once to keep a profile. The verify bullet names both servers.

**Behavior changes**
- **B511** `plugins/ok-web/skills/setup-web/SKILL.md` (`/setup-web`). Before: it writes or merges one `chrome-devtools` entry, and a rerun on a project with that entry reports a no-op. After: it writes or merges `chrome-devtools` and `chrome-devtools-headless`. A rerun on a project set up by an earlier release adds the headless entry and reports it, and an owner's own `chrome-devtools-headless` entry that differs is shown, not overwritten. Users: in the release: none; no other skill reads `.mcp.json`. Across Installed plugins: each user who runs `/setup-web`, a public slash command under the intent's Slash commands class. Across stored state: each project's committed `.mcp.json` an earlier run wrote. Ruling: migrate: an existing `.mcp.json` and every entry in it stand as written, and the skill adds the headless entry beside them only where its key is missing (call). Decided by: the promoted issue `setup-web-headless-server`, carried as this work item ("by default"), and the skill's merge-never-clobber rule.

**New surface**
- The `chrome-devtools-headless` server entry `/setup-web` writes into a project's `.mcp.json`, declared in `plugins/ok-web/skills/setup-web/SKILL.md`: internal. No class of the surface intent names an `.mcp.json` entry; `/setup-web` itself is public already.

**Tested stories**
- None.

**Runtime parts**
- None.

### State the product-slow condition in the speed and verify prompts

**Calls**
- Both prompts use the wording of `{{TEST-SPEED-JUDGING}}` in `skills/_sprint/shared.md`: "the fix loop files a fixer for the site, keyed `perf:`, beside another failure of the latest whole-suite round, and once the fix is accepted the test gets a fresh speed read. A verdict with no such failure beside it goes to the intake for the next sprint." The shared text, the T3 row, and `decision:product-slow-fixes-ride-a-round-that-runs-anyway` already state the condition. Decided by: the work item and coding rule 6 (one wording, not a second).
- Shared files: `test-speed.md` is also changed by "Have writers declare only the locks their tests show" (the speed reviewer's lock text). `test-verify.md` is also changed by that item and by "Have each test set up its own starting state". This item touches only the Record section's product-slow bullet in `test-speed.md` and the product-slow paragraph in `test-verify.md`.

**Changes**
- `plugins/ok/families/ok-planner/skills/converge/prompts/test-speed.md` (Record, the "Product-slow" bullet's last sentence): changed. It states that the fix loop files the `perf:` fixer only beside another failure of the latest whole-suite round, and that a verdict with none goes to the intake for the next sprint.
- `plugins/ok/families/ok-planner/skills/converge/prompts/test-verify.md` (the product-slow paragraph's last sentence): changed. Same statement.

**Behavior changes**
- None. Every change is new code no existing user reaches. The agents record the same `speed` item and leave the `tests` item as before. `tests reports` already files the T3 report only beside another failure, so no agent's action or output changes.

**Tested stories**
- None.

**Runtime parts**
- None.

### Accept a boundary-question decline in the verifier prompt

**Calls**
- The verifier accepts such a decline where four things hold:
  - The fix the defect needs must change a behavior a user across a release boundary observes, read under the same rule the `fixed` bullet gives: `.ok-planner/release-boundaries.md`, stored state, and every element the surface intent made public at the base commit.
  - No ruling of the sprint at [SPRINT PATH] allows it.
  - The fixer recorded a `question` call for it, found with `tasks item list --pool calls --key gate --json`.
  - The defect's `source` is not `suite`.

  Decided by: the work item, `prompts/fix.md` ("A fix that must change a behavior a user across a boundary observes, where no ruling allows it, is declined with a question recorded"), and `prompts/fix.md` step 1 ("A defect whose `source` is `suite` ... is never declined").
- A decline that passes keeps its state and gets the `verified` field, as every accepted decline does. `prompts/owner-list.md` already routes it: a defect with an `issue` field becomes a judgment issue by `issues revise`, and a defect without one goes to the intake through its `question` call as a `product-intent` issue. So no other file changes. Decided by: `prompts/owner-list.md` ("A decline the fixer made with a question recorded", and "every `question` call").
- Shared file: `verify.md` is also changed by "Route a flaky test through its round's window" (the lock, overload, and found-none acceptances, under "A fix for a failing test"). This item touches only the "declined or duplicate" bullet of "Check each defect".

**Changes**
- `plugins/ok/families/ok-planner/skills/converge/prompts/verify.md` ("Check each defect", the **declined** or **duplicate** bullet): changed. A declined defect's reason also holds where the fix it needs must change a behavior a user across a release boundary observes, no ruling of the sprint allows it, and the fixer recorded a `question` call naming the change. The bullet names the calls listing to read.

**Behavior changes**
- **B512** `plugins/ok/families/ok-planner/skills/converge/prompts/verify.md`. Before: the verifier sends a boundary-question decline back to `open` with one more kickback, until the defect reaches its send-back limit, sticks, and has its change restored. After: the verifier accepts it, sets `verified`, and the defect stands `declined`. The owner list turns its issue into a judgment issue, or files the question, with no restoration. Users: in the release: Loop 2's end check and `review restores`, which no longer meet such a defect as stuck; `prompts/owner-list.md`, which already routes the accepted decline; `review certified`, whose `SETTLED_DEFECT_STATES` already holds `declined`. Across Trued-up projects: none; the prompts are vendored and written in one true-up. Ruling: rewrite.

**Tested stories**
- None.

**Runtime parts**
- None.

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
   with the owner. Where `/goal` handed you this file, the goal line
   the owner typed carries the goal's whole condition, so no message
   of yours restates it. Then, where the stop record
   `<sprint-name>-stopped.txt` stands beside this file, delete it
   before the run goes on, so this goal takes the run up again.

2. Check that the run can start, then record the base. Every check
   here runs before the base is written; where one stops the run,
   stop it as step 11 says, with its message as the reason. First
   run `ls .ok-planner/bin/review .ok-planner/bin/issues
   .ok-planner/bin/tasks` and show its output whole. `review
   certified` loads all three, so where the `ls` reports one
   missing, no command can print `SPRINT STOPPED`: write the stop
   record naming each missing tool and saying that the front door's
   administration (`/ok`) materializes it, then stop without running
   `review certified`. That `ls` output meets the goal's condition,
   and the stop is no success. Then run
   `.ok-planner/bin/review approved --sprint <this sprint's path>`.
   Where it refuses, stop: this file may be a draft the owner never
   approved, or the review estate lacks the
   `.ok-planner/review/config.json` the command reads. Then check the
   profiles under `.claude/agents/`: a missing one is `/ok`'s to
   materialize too, so stop and say so. Then,
   where `<sprint-name>-groups.json` beside this file plans tests, as
   step 3a reads it, where `<sprint-name>-plan.json` stands beside
   this file, or where `testing.enabled` in `.ok-planner/config.json`
   is `on`, the run opens its test stages (step 3), and two more
   checks run. `.ok-planner/bin/tests` is required: where it is
   missing, stop and say so. Then run `.ok-planner/bin/tests
   profiles` and show its output whole. Where it refuses, a
   cheatsheet under `.claude/rules/` changed since true-up wrote the
   test profile's body: stop, the stop record naming each file it
   names and saying that the front door's administration (`/ok`)
   writes the profile again. A run that opens no test stages runs
   neither check.
   Where the base file stands beside this sprint (the same filename,
   `-base` before the extension and `.txt` as the extension), the
   run stopped before and resumes: keep that base, skip the
   uncommitted-paths check, and go on to step 3. Where the
   `<sprint-name>-certified.txt` mark also stands, run
   `.ok-planner/bin/review certified --sprint <this sprint's path>`
   first and show its output whole. Where it prints `SPRINT
   COMPLETE`, the goal is met with no new certification: offer the
   archive and the commit below as one owner act, as step 13 does.
   Otherwise go on to step 3.
   Where no base stands, sprint certification reads the change from
   the base commit, so the tree holds nothing but this sprint's work
   from here on. The planning session leaves its own files
   uncommitted: this file, its delta sidecar,
   `.ok-planner/release-boundaries.md`, the intake's two files
   (`.ok-planner/issues.jsonl` and
   `.ok-planner/history/issues.jsonl`), and the sketches and the
   discovery it archived. Where `git status --porcelain` lists a path
   outside `.ok-planner/`, stop, naming those paths, because
   certification would count them as this sprint's work. Otherwise
   write the output of `git rev-parse HEAD` to the base file.

3. Open the run. Where `.ok-planner/sprints/<sprint-name>-run.jsonl`
   stands, the run resumes: run `tasks use <that path>`, which also
   moves the tracker's pointer back from a `/converge` ledger, then
   `tasks retry --all`, which issues again every task that did not
   close `done` and every task an agent claimed and never closed.
   Otherwise run `tasks init <sprint-name> --file
   .ok-planner/sprints/<sprint-name>-run.jsonl`. Either way, run
   every registration and config below, again on a resumed run:
   `tasks agent register ok-opus`, and register the `build` prompt:
   write it with
   `.ok-planner/bin/review prompt --name build --sprint <this sprint's
   path> --out .ok-planner/sprints/<sprint-name>-build.md`, then `tasks prompt
   register build <that path>`. Declare the roles whose close carries
   a sweep: `tasks config set swept_roles '["build", "fix"]'`, so a
   build task closes `done` only with the sites its searches
   returned, each one staged.
   Where step 2 found that the run opens its test stages, open them:
   a sprint whose groups file plans tests, or with
   `<sprint-name>-plan.json` beside it, plans tests, and under
   `testing.enabled` `on` the run opens them whether or not the sprint
   plans tests, for step 4's speed read. Register the test profile,
   which runs the test support, test, verify, and speed tasks: `tasks
   agent register ok-test`. For each role and its template, `preflight` from `test-preflight`, `test-support`
   from `test-support`, `test` from `test-write`, `legacy` from
   `test-legacy`, `sweep` from `test-sweep`, `verify` from
   `test-verify`, and `speed` from `test-speed`, write the prompt with
   `.ok-planner/bin/review prompt --name <template> --sprint <this
   sprint's path> --out .ok-planner/sprints/<sprint-name>-<role>.md`,
   then `tasks prompt register <role> <that path>`. Declare the test
   pools: `tasks config set item_states '{"tests": ["open",
   "accepted", "sent-back"], "test-support": ["open", "made"], "ports":
   ["open"], "promises": ["open", "held", "rejected"], "speed":
   ["accepted", "sent-back", "product-slow"]}'`, and the fields their
   readers take as numbers: `tasks config set field_types '{"tests":
   {"silence": "integer"}, "speed": {"seconds": "number", "rank":
   "integer"}}'`. Select the test stages' calls for the completion
   report's `## Calls` beside the build's: `tasks config set calls
   '[{"pool": "divergences"}, {"pool": "calls"}]'`.

3a. Plan the tests, before any build task is filed. Where
   `<sprint-name>-groups.json` stands beside this file and
   `<sprint-name>-plan.json` does not, run "The test planning
   procedure" in `.claude/skills/plan-sprint/tests.md`. It opens the
   test planning run, `<sprint-name>-test-planning.jsonl` beside this
   file, or resumes it where it stands. It drains the programs, story,
   runtime, sort, and budget planners, the planner reviews, and the
   plan-wide review, applies the fixes as its "Fixing a planner's
   items" says, and assembles the plan beside this file. It asks the
   owner nothing. A scenario whose outcome this sprint's work changes
   is rewritten to the outcome this sprint states, and one whose code
   the work removes while its story stands is retired as a gap. A
   test the suite command does not run inside its silence period is
   planned in a form the command runs, or its outcome is recorded as
   untested. Each of these is a call. Each entry point no story serves
   is a program question, which sprint certification's owner list
   files in the intake. The procedure ends by moving the tracker back
   to this sprint's run. Where the groups file plans nothing, it files
   nothing and writes no plan. A sprint whose plan already stands
   beside it keeps that plan and skips this step.

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
   Where step 3a assembled a plan, file one build task per time
   control its summary lists (`.ok-planner/bin/tests plan --sprint
   <this sprint's path> --show`), which builds that control as
   product code before the test stages run: `tasks file --role build
   --prompt build --agent ok-opus --key <the control's id> --files
   <its files> --cites <the control's id> <each scenario that waits on
   it> --after <the build tasks of the stages whose files it shares>
   --brief "<its form, its site, its files, its gate setting, and the
   scenarios that wait on it>"`. Record each as a call: `tasks item
   add --pool divergences --key <the control's id> --field kind=call
   --field site=<its site> --field choice="build time control <the
   control's id> as a code stage" --body "<what the time control
   does>"`.
   Where the run opened test stages, file them after the build tasks.
   They are not build tasks, and they change no product code. Run
   `.ok-planner/bin/tests tasks --sprint <this sprint's path> --stage
   write --after <the latest build task of each code stage whose files
   a planned scenario's entry or test support reaches, and of each
   time control's stage>`. Where no code
   stage's files hold one, run it with no `--after`, and the test
   stages run beside the code stages. Every `--stage write` takes the
   same `--after`: the stage follows each task it names to that
   task's latest refile, so a code stage refiled under step 7 needs no
   new `--after`. Where the plan's budget names a test stack, the
   stage files the preflight task alone first, and files the rest
   once it closed `done`: one test support task per test support
   file the scenarios name and per open `test-support` item, one test
   task per story, or per chunk of at most `testing.chunk` of the
   story's scenarios the plan writes, rewrites, or retires, each after
   every test support task of that pass, and one legacy task per
   legacy file.
   Drain with step 7's loop. After each drain, run `tests tasks
   --sprint <this sprint's path> --stage verify`, which files one
   verify task per test task whose tests await their verifier, and
   one per promise a test task recorded that awaits its verifier, and
   drain. The next `--stage write` files again the tests a verifier
   sent back, one test task per chunk of each story's, with the
   reason, and each test task that closed `blocked` having filed a
   `test-support` item, after every test support task of that pass. Repeat `--stage write`, `--stage
   verify`, and the drains until neither stage files a task. Then
   `.ok-planner/bin/tests ports --sprint <this sprint's path>` adds
   each check the legacy tasks ported to
   `.ok-planner/review/config.json` `checks`. Where it refuses because
   a ported command starts a test runner, it adds no check: refile
   each legacy task it names with the refusal, `.ok-planner/bin/tasks
   refile <task> --brief "<its brief>; revise: <the refusal>"`, drain,
   and run `tests ports` again, until it adds the checks. Then, while
   `.ok-planner/bin/tests stray --sprint <this sprint's path>` lists a
   file, run `tests tasks --sprint <this sprint's path> --stage sweep`
   and drain. Then, where `.ok-planner/bin/tests enabled` prints `on`,
   run `tests tasks --sprint <this sprint's path> --stage speed --from
   state` once. It files one speed task for each of the
   `testing.slowest` slowest tests in the ranking the scenario list
   carries that has no speed acceptance at its current test file.
   Drain. Where a speed reviewer sent a test back, run `--stage write`
   and `--stage verify`, and drain after each, until neither files a
   task, so the rewrites land before sprint certification starts.
   On a resumed run, file no stage twice. File no build task for a
   work item or a time control some build task's `--cites` already
   names; file a stage only for a work item or a time control no
   filed task cites. The test-stage verbs run
   again from `--stage write`, with the same `--after`, and each
   files only what the run lacks.

5. Render the completion report with the staged list before the first
   drain: write the output of `tasks render --title "<this sprint's
   title>" --sprint <this sprint's path>` to the report file (step
   10), with `--planning
   .ok-planner/sprints/<sprint-name>-test-planning.jsonl` where that
   test planning run stands beside this file, as step 3a leaves it,
   on a resumed run too.

6. Keep the progress checklist. Where the harness task tools are
   available, mirror the stages as a live checklist. Create one entry
   per stage when the build tasks are filed. Mark an entry in progress
   when the drain that runs its build task starts, or when its agent
   claims the task where the session runs the drain by hand, and done
   when that task closes `done`. Add one entry for sprint
   certification when every stage's build task has closed `done`.
   Mark that entry in progress at step 12 and done at step 13.
   On a resumed run, build the checklist from the run: one entry per
   stage the run holds, each marked done where its latest build task
   closed `done`.
   The run file is the record and the checklist is display.

7. Drain with the loop at `.claude/skills/_tasks/drain.md`.
   A build that closes `partial` is refiled for its remainder with
   `tasks refile <task>`; one that closes `partial` with a result
   starting `outside files:` is refiled with `tasks refile <task>
   --files <its files and that path>`. A build that closes `blocked`
   is refiled once. The session
   builds nothing and reviews nothing itself, and edits no file a
   running task owns.
   A test-stage task that closes `partial` or `blocked` is refiled
   the same way, save two the write stage files again itself, which
   you never refile by hand: a test a verifier or a speed reviewer
   sent back, and a test task that closed `blocked` having filed a
   `test-support` item. The write stage's refusals are genuine
   blockers under step 11: where `--stage write` refuses because the
   preflight closed `blocked` twice, a `test-support` item records a
   change other than `missing`, `changed`, `fixture`, or `seed`, a
   test support task closed `done` and left its `test-support` item
   open, the last two filings of one test task closed `blocked` and
   neither filed a `test-support` item,
   or a task it would file or refile waits on a task that, followed
   through the refiles the same pass plans, then to its latest
   refile in the run, closed other than `done`, surface its
   message and stop. So is `--stage speed`
   refusing because a test's last two speed tasks closed short of
   `done` or with no verdict.

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
    Where the run opened test stages, `## Calls` also shows the run's
    `calls` pool, where the test stages record their calls, each
    legacy test a legacy task deleted or ported among them, as step
    3's `calls` setting selects. Where the test planning run step 3a
    opens stands beside this file, `## Calls` also shows that run's
    calls, each id prefixed `plan:`:
    each call the test plan's planners made, a rewrite to a changed
    outcome, a retire as a gap, and an outcome left untested among
    them, as that run's `calls` setting selects.

11. Work unsupervised to a defensible done. Do not pause for
    approval, confirmation, or progress checks. No step of execution
    or sprint certification waits on a person: no work item, no call,
    no line of the review facts, and no story's drive. File no task
    for the owner to perform. Where a story's benefit passes through
    a party outside the product, the drive and the tests use the
    local stand-in the review facts name for it. The archive and the
    commit after completion stay the owner's one act. Stop only on a
    genuine blocker: a credential or
    access you cannot obtain, a step impossible in the current state,
    a destructive or irreversible action not clearly authorized, a
    task closed `blocked` twice, or sprint certification being
    unrunnable for you. To stop, wait until no agent you started
    still runs, then write the stop record: the file
    `.ok-planner/sprints/<sprint-name>-stopped.txt` beside this file,
    holding the reason as plain text, one line per reason. Then run
    `.ok-planner/bin/review certified --sprint <this sprint's path>`,
    show its output whole, and stop. While the record stands, it
    prints `SPRINT STOPPED` with the reason, which meets the goal's
    condition while the contract stays unmet: the stop is no success,
    and the owner takes up the reason. The same goal line resumes the
    run from its base and its task record. Ambiguity is not a blocker: the builder makes the most
    plausible call and records it, or records a fork and builds the
    reading it judges best. Sprint certification reads both.

12. Code complete means every stage's latest build task closed
    `done`, and, where the run opened test stages, every test-stage
    task closed `done` at its latest filing, with neither `--stage
    write`, `--stage verify`, nor `--stage sweep` left to file a
    task. Then mark the checklist's sprint certification entry in
    progress, and run sprint certification immediately after:
    `/converge sprint <this sprint's path>`. It judges the change
    from the commit in the `-base.txt` file to the working tree,
    once, against this sprint: every outcome and taken improvement
    works, a user gets what each story promises when a driver uses
    the running product, for this sprint's new and changed stories
    where `testing.enabled` is `on` or `frozen` and for every story
    where it is `off`, every delta landed, every ruling holds, no
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
    file, with `--planning
    .ok-planner/sprints/<sprint-name>-test-planning.jsonl` where that
    test planning run stands beside this file, as step 5 says.
    `--file` names this sprint's run, because `/converge`
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
    failure to the owner and stop the run as step 11 says, with each
    failure a line of the stop record, without offering the archive:
    it is a genuine blocker under step 11. The `SPRINT STOPPED` that
    follows meets the goal's condition while the contract stays
    unmet, and the same goal line resumes the run. Where it printed `SPRINT
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
2. Run `.ok-planner/bin/tasks split <path> ...` on this sprint's run
   file, its `-results.jsonl` file where one exists, and the
   `/converge` run's ledger, in place under
   `.ok-planner/review/runs/`, and show its output whole. It splits
   each file larger than `archive.part_bytes` in
   `.ok-planner/config.json` into numbered parts beside it,
   `<name>.part<n>.jsonl`, and removes the whole file from git's
   index and the disk; it leaves a smaller file whole. Split no other
   file: the intake's two files stay whole. Then move this file and
   every file and folder beside it that shares its filename to
   `.ok-planner/history/sprints/`: each one whose name is this
   sprint's name, a `-`, and a suffix, such as the completion report,
   the run file or that file's parts, the `-results.jsonl` file or
   its parts, the `-base.txt` file, the `-certified.txt` mark
   `review certified` writes, the `-stopped.txt` stop record where
   one stands, every prompt the run wrote, the test
   planning run and its prompts, the groups file, the test plan, and
   the delta sidecar. `ls -d
   .ok-planner/sprints/<sprint-name>-*` lists them; leave out the
   files of another sprint whose name starts with this one's. Use
   `git mv` for a tracked file and `mv` for an untracked one.
3. Stage by name every path the sprint's change touched, every moved
   file at its new path, the `/converge` run's ledger or its parts and
   its folder, the intake's two files, `.ok-planner/issues.jsonl` and
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
   removed path the last commit holds, a `git mv` source, a whole
   file the split removed, or a file a task removed with `git rm`
   among them, and no other, so nothing
   else standing in the index rides along.
4. Where `<sprint-name>-plan.json` stands beside the archived sprint,
   or `.ok-planner/bin/tests enabled` prints `on` or `frozen`, so
   sprint certification ran the suite, run `.ok-planner/bin/tests
   stamp --sprint .ok-planner/history/sprints/<this file's name>
   --commit <the
   commit's sha>` and show its output whole. It writes each planned
   story's test stamp, the scenario list, the speed ranking, the speed
   acceptances, and the `reaches` lists into
   `.ok-planner/test-state.json`. Then add `closed: <the commit's
   sha>` to the archived sprint's YAML frontmatter, beside its
   `approved:` mark, or as new frontmatter where the sprint has none.
   Commit both together, the archived sprint and, where the stamp
   ran, `.ok-planner/test-state.json`, with `git commit -- <those
   paths>`. The next planning session reads the `closed:` stamp to
   detect work done out of band, and its test planning reads the
   story stamps.

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
   `duplicate`, `stuck`, or `promised`, with every `stuck` defect
   listed for the owner. The run's drive took every story of its
   set: this sprint's new and changed stories where
   `testing.enabled` in `.ok-planner/config.json` is `on` or
   `frozen`, and every story where it is `off`. An empty set needs
   no drive. Drive commands unfilled or refused, or a stack that
   failed to start, mean the drive did not run. Where
   `testing.enabled` is `on` or `frozen`, the run's suite ran
   too: a whole-suite round ran after the last change, and every test
   that failed in it is `promised`, held by a `promised` defect or by
   an open issue on its scenario; every speed send-back is settled or
   returned to its last passing version; no code task, a build task
   or a certification fixer, staged a test path; and no stray test
   file stands, one no planned test claims and no plan kept.

**The goal rule, for any checker verifying this contract.** The goal
is met when items 1–3 verify against the repository as it stands.
`.ok-planner/bin/review certified --sprint <this sprint's path>`
checks them there and prints `SPRINT COMPLETE` or `SPRINT NOT
COMPLETE`. While the stop record `<sprint-name>-stopped.txt` stands
beside this sprint, it prints `SPRINT STOPPED` with the record's
reason and checks nothing else: that line meets the goal's condition
while the contract stays unmet. The stop is no success: the owner
takes up the reason, and the same goal line resumes the run. Where
the `ls` of step 2 reports a tool that command loads missing, the
command cannot run, and that `ls` output meets the goal's condition
the same way.
Under `testing.enabled` `on` or `frozen`, it checks item
3's suite terms too: the whole-suite round after the last change,
every failure in it `promised`, every speed send-back settled or
returned to its last passing version, no test path a code task
staged, and no stray test file. Under `off`, the suite is no term. A
checker that reads only the session, as `/goal`'s does,
decides from that command's latest output in the session; a checker
that runs commands runs it. A `stuck` defect listed in the
return, a check that still fails among them, is the owner's to take
up, and holds no term of the contract open. A `promised` defect is
the owner's too, through the issue the run files for it, and holds
no term open either.
Presenting the report, archiving, committing, and the
`closed:` stamp all follow completion, and none is a term of the
goal. `sprints/` and
`.ok-planner/history/sprints/` satisfy the rule alike, and a sprint
already archived with a `closed:` stamp is terminal. A missing
completion report, or one without the return block,
means not done. Nothing else counts either way.
