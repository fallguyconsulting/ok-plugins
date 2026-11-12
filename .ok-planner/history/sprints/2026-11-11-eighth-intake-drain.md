---
approved: 2026-11-11
closed: e0baa162a703f6ecaeddb91ec19a03e781c2f4a4
---
# Sprint: Eighth intake drain

## Intent

This sprint drains the intake. It has no single theme. Its largest
changes move detailed test planning out of `/plan-sprint` into sprint
execution, add a `/drive` skill that sprint certification and
`/converge drive` share, phrase a sprint's goal so a stop ends it,
give each vendored agent profile a named tool list with a lean test
profile that carries its rules in its body, and split two decisions
that each bundled several choices. It also fixes eleven defects the
intake holds.

Issues promoted into this sprint:

- `sprint-planning-waits-on-detailed-test-planning`
- `sprint-changes-skip-runtime-test-re-plan`
- `test-tasks-run-before-support-they-import`
- `test-tasks-file-one-agent-per-scenario`
- `scenario-list-decision-bundles-several-choices`
- `test-speed-decision-bundles-several-choices`
- `whole-suite-rounds-fail-with-no-product-or-test-fault`
- `write-stage-refuses-chained-blocked-refiles`
- `sprint-certification-drives-every-story-under-testing`
- `stopped-sprint-never-ends-goal`
- `doc-handoff-commit-rewrite-reading`
- `confirm-drives-skip-duplicate-drive-defects`
- `vendored-profiles-start-from-an-unshrunk-context`
- `test-stage-agents-start-from-the-full-opus-context`
- `rules-files-load-whole-into-every-agent`
- `drain-window-held-at-first-fill`
- `refile-leaves-waiters-issued`
- `certified-counts-unrun-drives`
- `doc-sprint-fixed-check-file-has-no-style-task`
- `doc-sprint-lists-classes-in-one-checker-task`
- `certification-speed-ignores-build-stage-verdicts`
- `speed-ranking-keeps-batch-size-seconds`
- `support-of-kept-legacy-test-deleted`
- `nothing-to-plan-sweeps-untaken-legacy-tests`
- `true-up-rewrites-untracked-edited-stamped-file`
- `commit-patterns-refuse-sha256-names`
- `sprint-stop-unreachable-without-review-script`

## Corpus deltas

### Amend decision: scenario-list-decided-once

body: in the sidecar

### New decision: project-owns-its-suite-command

body: in the sidecar

### New decision: sprint-runs-recorded-whole

body: in the sidecar

### New decision: second-whole-suite-round-refuses

body: in the sidecar

### New decision: sprints-plan-what-their-work-reaches

body: in the sidecar

### New decision: runtime-parts-planned-without-an-offer

body: in the sidecar

### New decision: tests-planned-in-execution

body: in the sidecar

### Amend decision: testing-runs-inside-the-sprint

body: in the sidecar

### Amend decision: tests-spend-time-only-on-their-outcome

body: in the sidecar

### New decision: speed-ranked-by-median-seconds

body: in the sidecar

### New decision: speed-acceptance-outlives-support-changes

body: in the sidecar

### New decision: speed-read-at-three-points

body: in the sidecar

### New decision: product-slow-verdict-fixes-the-product

body: in the sidecar

### New decision: product-slow-fixes-ride-a-round-that-runs-anyway

body: in the sidecar

### New decision: no-speed-floor

body: in the sidecar

### Amend decision: test-support-written-before-tests

body: in the sidecar

### New decision: test-tasks-take-a-story-at-a-time

body: in the sidecar

### New decision: suite-contracts-checked-before-a-round

body: in the sidecar

### Amend decision: tests-isolated-unless-declared

body: in the sidecar

### Amend decision: fixes-rerun-the-tests-they-reach

body: in the sidecar

### Amend decision: test-loop-fixes-code-never-tests

body: in the sidecar

### Amend decision: seed-recommended-never-required

body: in the sidecar

### Amend decision: planned-tests-name-their-waits

body: in the sidecar

### Amend decision: every-timer-has-a-time-control

body: in the sidecar

### Amend decision: legacy-suites-sorted-automatically

body: in the sidecar

### Amend decision: test-tasks-own-the-tests

body: in the sidecar

### Amend decision: team-execution-cold-gate

body: in the sidecar

### Amend decision: drive-tries-each-story-as-a-user

body: in the sidecar

### New decision: one-drive-procedure-fixes-nothing

body: in the sidecar

### New decision: certification-drives-what-the-sprint-changes

body: in the sidecar

### Amend decision: every-stop-ends-the-goal

body: in the sidecar

### Amend decision: sprint-goal-read-from-the-repository

body: in the sidecar

### New decision: planned-commit-moves-only-over-read-work

body: in the sidecar

### Amend decision: defects-outside-scope-become-defect-issues

body: in the sidecar

### Amend decision: intake-writers-are-gated

body: in the sidecar

### Amend decision: converge-close-takes-vetoes

body: in the sidecar

### New decision: profiles-name-their-tools

body: in the sidecar

### New decision: lean-profiles-carry-their-rules

body: in the sidecar

### New decision: lean-body-copied-word-for-word

body: in the sidecar

### New decision: stale-lean-body-stops-test-work

body: in the sidecar

### New decision: drain-fills-every-free-slot

body: in the sidecar

### New decision: ancestor-claude-md-left-to-the-owner

body: in the sidecar

### Amend decision: slash-only-activation

body: in the sidecar

### New decision: skill-descriptions-hold-the-guard-and-one-sentence

body: in the sidecar

### Amend concept: cheatsheet

body: in the sidecar

### Amend decision: steering-over-prose-lint

body: in the sidecar

## Work items

### Detailed test planning runs in sprint execution, ahead of the build
Realizes: decision:tests-planned-in-execution, decision:testing-runs-inside-the-sprint, decision:planned-tests-name-their-waits, decision:every-timer-has-a-time-control, decision:legacy-suites-sorted-automatically, decision:test-tasks-own-the-tests, decision:team-execution-cold-gate, story:plan-a-sprint
Issues: sprint-planning-waits-on-detailed-test-planning

`/plan-sprint` sets the sprint's test scope and plans no test in detail. `plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md` changes as follows. Its description and opening say that the owner approves the scope. Frame keeps the offers and the widen. Resolve drops "The programs". Code planning keeps the re-plan list. Section 10 runs `tests groups` with the scope and writes the `## Tests` section from what it prints. It opens no planning run, files no planner, review, programs, or budget task, asks no programs, test, or runner question, and drafts no time-control work item. Section 11 drops the test question. Approval presents the scope. An owner who declines a new story's tests drops it from the scope, and `tests groups` runs again. Terminal lists only the files the session writes.

The `## Tests` template in `skills/plan-sprint/sprint-document.md` records the scope:
- the state line;
- the groups taken and the stories widened;
- the stories that get new, revised, or retired tests;
- the runtime parts the sprint plans;
- each program a ruled issue leaves unguarded, with the owner's reason;
- the groups file's path.

Its "How to execute this sprint" section gains a test planning step after the run opens and before any build task is filed. The step runs only where the groups file stands beside the sprint and no plan does. It opens the planning run beside the sprint. It drains the programs, story, runtime, sort, and budget planners, the planner reviews, and the plan-wide review. It applies the fixes as "Fixing a planner's items" says, and it assembles the plan. It runs the runner check as a rule: a test the suite command does not run inside its silence period is re-planned in a form the command runs, or recorded as an untested call. It cuts one build stage per time control the plan lists, under the build prompt, and records each as a call. Steps 2 and 3 of that section decide from the groups file, not from the plan, whether the run opens its test stages. A sprint whose plan already stands beside it keeps that plan and skips the step.

The procedure moves out of `SKILL.md` into `skills/plan-sprint/tests.md`, together with the fixing rules and the re-plan-list rule, and the execution step reads it by path. The planner prompts in `tests-story.md`, `tests-runtime.md`, `tests-programs.md`, `tests-sort.md`, and `tests-budget.md`, and the two review prompts in `tests.md`, address execution:
- A story or runtime planner records a scenario whose outcome the sprint changes as a `rewrite` to the outcome the sprint states, with a call.
- It records a scenario whose code the sprint removes while its story stands as a `retire` to a `gap`, with a call.
- The programs planner records each entry point no story serves as a question for the intake.
- No prompt says the owner approves or answers.

`plugins/ok/families/ok-planner/scripts/tests` changes in four places:
- `groups` reads no planning run and no program answers. It takes each unguarded program the `## Tests` section names.
- `plan` assembles with no owner answer, and carries those unguarded programs into the plan.
- `plan --questions` lists the program questions alone.
- Its usage text follows.

`skills/converge/prompts/owner-list.md` changes so that sprint certification's owner list files each program question the plan records as a `product-intent` judgment issue for the next `/plan-sprint`. The completion report's `## Calls` shows the test plan's calls. `scripts/ok-planner-cheatsheet.md`, `scripts/ok-planner-CLAUDE.md`, `docs/plumbline-cheatsheet.md`, `docs/testing.md`, and the family `CLAUDE.md` say that planning sets the test scope and execution plans the tests.

### Runtime parts are planned with no offer
Realizes: decision:runtime-parts-planned-without-an-offer, decision:testing-runs-inside-the-sprint
Issues: sprint-changes-skip-runtime-test-re-plan
Depends on: "Detailed test planning runs in sprint execution, ahead of the build"

The runtime group leaves the standing offers. `tests offers` prints no runtime group, and `tests declare --offers` and `tests groups --take` refuse `runtime`. The true-up core, `admin/true-up`, removes `runtime` from a project's `testing.offers` and from the former offers it writes. The lint's testing validation in `scripts/plumbline` refuses the value.

The code planner prompt and the implementation notes form in `skills/plan-sprint/core.md` list, per work item, the runtime parts the work item adds, changes, or removes. The notes review checks that list as it checks **Tested stories**. `tests groups` takes those parts. Under `on`, it marks the runtime planner to run in every sprint, for those parts and for every part with no recorded scenario. Under `frozen`, it marks the planner to run only where a part is listed, for that part's rewrites and retirements. `skills/plan-sprint/tests-runtime.md` briefs the planner that way and drops "the owner took the runtime group". Section 3.6 of `skills/ok-setup/SKILL.md` lists three offers. `/plan-sprint`'s Frame, the family `CLAUDE.md`, and the cheatsheets drop the runtime offer.

### Each annotation cites the decision that holds its choice
Realizes: decision:scenario-list-decided-once, decision:project-owns-its-suite-command, decision:sprint-runs-recorded-whole, decision:second-whole-suite-round-refuses, decision:sprints-plan-what-their-work-reaches, decision:tests-spend-time-only-on-their-outcome, decision:speed-ranked-by-median-seconds, decision:speed-acceptance-outlives-support-changes, decision:speed-read-at-three-points, decision:product-slow-verdict-fixes-the-product
Issues: scenario-list-decision-bundles-several-choices, test-speed-decision-bundles-several-choices

Each `@decision: scenario-list-decided-once` and `@decision: tests-spend-time-only-on-their-outcome` annotation in `scripts/tests`, `admin/true-up`, and `scripts/plumbline` names the decision that holds the choice its site enforces:
- the suite command run (`run_suite`): project-owns-its-suite-command;
- the results file and recorded rounds (`results_rounds`, `results_file`, `cmd_run`, `recorded_round`): sprint-runs-recorded-whole;
- the whole-round lock (`whole_round_lock`): second-whole-suite-round-refuses;
- the groups, the touched stories, and the earlier calls (`cmd_groups`, `touched_stories`, `earlier_calls`, `offer_groups`): sprints-plan-what-their-work-reaches;
- the ranking (`ranked_slowest`, `median_seconds`, `speed_ranking`): speed-ranked-by-median-seconds;
- the acceptances (`speed_settled`, `stamped_acceptances`): speed-acceptance-outlives-support-changes;
- the speed stage (`stage_speed`, `speed_rows`, `speed_candidates`, `cmd_slowest`): speed-read-at-three-points;
- `perf_failures`: product-slow-verdict-fixes-the-product.

A site of the list's own form, its stamps, or its conversion keeps scenario-list-decided-once. A site of the standard's waste and wait rules keeps tests-spend-time-only-on-their-outcome.

### Every test task of a pass waits on every test support task, under one name
Realizes: decision:test-support-written-before-tests, decision:team-execution-cold-gate, decision:seed-recommended-never-required, decision:fixes-rerun-the-tests-they-reach, decision:test-loop-fixes-code-never-tests, decision:scenario-list-decided-once, decision:speed-acceptance-outlives-support-changes
Issues: test-tasks-run-before-support-they-import

`tests tasks --stage write` makes every test task it files or refiles in a pass wait on every test support task of that pass, and its usage text says so. The term "support" becomes "test support" everywhere, stored names included:
- the task role `support` becomes `test-support`, with its registered prompt, its task keys, and its brief prefix;
- the item pool `support` becomes `test-support`, with its cite prefix;
- support files become test support files, in the plan, the scenario list's per-scenario field, the legacy sort value, and the T4 defect's field;
- every prompt, brief, refusal, and message says test support task and test support file.

The files are `scripts/tests`, `scripts/review` (the prompt files beside the sprint that the archive moves), `admin/true-up`, `skills/converge/SKILL.md` (the item states, the prompt registration, step 5a), `skills/converge/prompts/test-support.md`, `test-write.md`, `test-verify.md`, `test-speed.md`, `test-sweep.md`, `merge.md`, `fix.md`, and `verify.md`, `skills/plan-sprint/sprint-document.md`, `skills/plan-sprint/tests-story.md`, `tests-sort.md`, and `tests-runtime.md`, `skills/_sprint/shared.md`, `docs/testing.md`, `docs/plumbline-cheatsheet.md`, `scripts/ok-cheatsheet.md`, `scripts/ok-planner-cheatsheet.md`, and `scripts/ok-planner-CLAUDE.md`.

No ledger already written is migrated. The code planner rules as release boundaries on three cases: a sprint in flight across the upgrade; a sprint archived and not yet stamped, whose run and certification ledger hold the old names; and the stored scenario list.

### A test task takes a story's scenarios, up to `testing.chunk`
Realizes: decision:test-tasks-take-a-story-at-a-time, decision:settings-have-no-code-defaults, decision:testing-set-up-by-its-own-verb
Issues: test-tasks-file-one-agent-per-scenario
Depends on: "Every test task of a pass waits on every test support task, under one name"

`testing.chunk` is a required key with no default:
- `scripts/tests` reads it, refuses with the key named where it is missing, and writes it through `tests declare --chunk <n>`;
- the lint's testing validation in `scripts/plumbline` checks it;
- `/ok-setup` asks for it in `skills/ok-setup/SKILL.md`;
- `admin/true-up` writes it, at 1, into each project whose `testing` declares a suite command.

The write stage files one test task per story, or per chunk of at most `testing.chunk` of the story's scenarios. Each task carries every scenario's brief and holds every test file those scenarios name. The rewrites of a story's sent-back tests take one task per chunk the same way. Its refusals and refiles count per task, not per scenario. The verify stage files one verify task per test task, and its brief names each scenario's test, seconds, and declarations. Sprint certification's write and verify stages, run on its ledger, file the same way. `skills/converge/prompts/test-write.md` and `test-verify.md` take several scenarios per task.

### The write stage refiles a blocked test task that waits on another blocked test task
Realizes: decision:test-support-written-before-tests, decision:stopped-run-resumes
Issues: write-stage-refuses-chained-blocked-refiles
Depends on: "Every test task of a pass waits on every test support task, under one name" and "A test task takes a story's scenarios, up to `testing.chunk`"

`after_refusals` in `scripts/tests` maps each dependency of a filing through the refiles planned in the same pass, then to its latest refile in the run. It refuses only where the task it reaches closed other than `done`. It checks a refile's mapped waits even where they end empty. It falls back to the copied list's original ids nowhere.

The work checks the two points the partial fix in `stage_write` (commit 0679f45) leaves:
- A refile whose dependency's refile is planned later in the same pass waits on that refile. The pass files each refile after the refiles it waits on, so no wait is dropped.
- A planned task id that no task record holds yet counts as a task not yet closed, and is never refused.

The refusal message names the task the mapping reached. Step 7 of the execution section in `skills/plan-sprint/sprint-document.md` describes the refusal as the code checks it.

### Result lines carry the command's clock, and the suite's contracts are checked before a round
Realizes: decision:project-owns-its-suite-command, decision:tests-isolated-unless-declared, decision:suite-contracts-checked-before-a-round
Issues: whole-suite-rounds-fail-with-no-product-or-test-fault

A result line may carry `started` and `ended`, the test's start and end in seconds on the suite command's own clock. `tests run` records them. `schedule_failures` in `scripts/tests` compares two tests by those times. Where a line carries neither, it takes the start as the line's arrival less its seconds. The tool's usage text, the runner contract in section 3.2 of `skills/ok-setup/SKILL.md`, `docs/testing.md`, and the test rules in `skills/_sprint/shared.md` describe the two fields.

`skills/converge/prompts/test-preflight.md` and section 3.7 of `skills/ok-setup/SKILL.md` each run three checks:
- the suite command over two tests of one held group, where the scenario list or the plan declares one, checking that each line arrives as its test ends and in the group's order;
- `testing.setup` twice in a row on a running test stack, checking that the stack stays ready;
- `testing.setup` once beside resources it did not create, checking that it readies the stack and leaves them standing.

A failed check closes the preflight `blocked`, naming the check. In `/ok-setup` a failed check goes to the owner as a proposed change to the command or the setup.

### Suite faults file no speed step, and product-slow fixes ride a round that runs anyway
Realizes: decision:speed-read-at-three-points, decision:product-slow-fixes-ride-a-round-that-runs-anyway, decision:test-loop-fixes-code-never-tests
Issues: whole-suite-rounds-fail-with-no-product-or-test-fault
Depends on: "Result lines carry the command's clock, and the suite's contracts are checked before a round"

Step 3a.2 of `skills/converge/SKILL.md`, and `tests tasks --stage speed --round` in `scripts/tests`, file no speed step for a round whose only failures are schedule pairs or a failed setup.

Certification applies a product-slow fix only where the same round lists another failure, so another whole-suite round runs anyway. `tests reports` adds a T3 report only beside another failure of the round. Where a whole-suite round leaves product-slow verdicts as its only failures, three things hold:
- no product-slow fix lands;
- `tests settled` and `tests failures` count those verdicts as deferred, not as failures;
- the loop ends.

`skills/converge/prompts/owner-list.md` files each deferred verdict as a `design` judgment issue for the next `/plan-sprint`. The issue names the site, what it does, how its cost grows, and the cheaper behavior. Loop 2's step 2a, the return's `suite` line, and the T3 class in `skills/_sprint/shared.md` say the same.

### `/drive` drives stories and fixes nothing; `/converge` and sprint certification run its drive
Realizes: decision:drive-tries-each-story-as-a-user,
decision:one-drive-procedure-fixes-nothing,
decision:certification-drives-what-the-sprint-changes,
decision:defects-outside-scope-become-defect-issues,
decision:intake-writers-are-gated, decision:converge-close-takes-vetoes,
story:catch-broken-promises, story:veto-calls-made-in-my-absence.
Issues: sprint-certification-drives-every-story-under-testing.

- **The shared drive text.** The drive's steps leave
  `skills/converge/SKILL.md` for shared process text read by path,
  `skills/_converge/drive.md`. The steps are: the stories, the
  stack, the drivers, stopping the stack, one driver at a time, and
  the merge. The text takes the story set from its caller. Its tasks
  and items go into the caller's ledger.
- **The new skill, `skills/drive/SKILL.md`.**
  - Its description is guarded by the slash-only activation phrase.
  - It takes `/drive`, which drives every story, or `/drive sprint
    <path>`, which drives that sprint's new and changed stories.
  - It checks the same preconditions as `/converge`, then opens a
    fresh ledger, `.ok-planner/review/runs/drive-<date>T<time>.jsonl`.
    It registers `ok-opus` and the `drive`, `drive-start`, `merge`,
    and `owner-list` prompts, and declares the pools it uses.
  - It runs the shared drive text, then the owner list, then
    `/triage-issues` where the owner list wrote anything, as
    `/converge` does.
  - Its return gives each story's outcome per surface and variant.
    It also lists the failures as the merge sorted them, each issue
    the owner list filed or found already open, the stack tasks that
    failed, and the cost.
  - It closes with the calls table, the vetoes, and the offer to
    commit the ledger, the run's folder, and the intake's two files,
    as `/converge` does.
  - It edits no product file and runs no fix, verify, or confirm
    task.
- **The owner list.** `skills/converge/prompts/owner-list.md` files
  every defect a drive-only run's merge kept as a `category: defect`
  issue for the next `/converge`. It first reads the open issues, so
  a defect already filed adds nothing.
- **`/converge` drive mode** runs the shared drive text over every
  story, then its fix loop as it does today, the confirm steps
  included.
- **Sprint certification** runs it in its own ledger, before the
  merge, over the sprint's new and changed stories where the run's
  testing state is `on` or `frozen`, and over every story where it is
  `off`. Its findings merge with the review's, the checks', the
  build's, and the suite's.
- **The review tool.**
  - `review stories --sprint <path>` prints the sprint's new and
    changed stories, once each, whatever the testing state. The set is every story slug a `### New story:` or `###
    Amend story:` delta heading of the sprint names, and every
    `story:<slug>` the sprint's `## Work items` section names whose
    story file exists.
  - `review drives --sprint <path>` files one driver per story of
    that set. With no `--sprint`, both verbs keep every story.
  - `review certified` (`certification_failures`) requires a driver
    task in the certification ledger for each story of the required
    set. Under `testing.enabled` `on` or `frozen`, that set is the
    sprint's new and changed stories, and none is required where it
    is empty. Under `off`, it is every story, as it is today. Its
    item 3 line names the count driven and which set it took, or
    says that the sprint names no new or changed story.
- **Wording.**
  - `skills/converge/SKILL.md`: its description, modes, setup shape
    line, sprint step 4, and return all say this split, with the
    narrowing under testing `on` or `frozen` alone. Step 4 files the
    drivers with `review drives --sprint <path>` under `on` or
    `frozen`, and with no `--sprint` under `off`.
  - `skills/plan-sprint/sprint-document.md`:
    - The Work items placeholder says each item names the stories
      and decisions it realizes as `story:<slug>` and
      `decision:<slug>`.
    - Step 12 and Completion contract item 3 name the sprint's new
      and changed stories under testing `on` or `frozen`, and every
      story under `off`.
    - The replaced template lines join
      `admin/retired-boilerplate.json`.
  - The same claim changes in `skills/_sprint/shared.md` (the sprint
    catalog's "Every story is checked by the drive"),
    `scripts/ok-planner-CLAUDE.md`, `scripts/ok-planner-cheatsheet.md`,
    `scripts/ok-cheatsheet.md`, `CLAUDE.md`, and `plugins/ok/CLAUDE.md`.
    The family `CLAUDE.md` counts ten verbs and lists `/drive`, and
    its layout names `skills/drive/` and `skills/_converge/drive.md`.
- **True-up.** `admin/true-up`'s `SKILLS` map and `UNPREFIXED` list
  add `drive`, so true-up vendors it into `.claude/skills/drive/`.
- **Citations.** Each site that enforces the drive set cites
  `@decision: certification-drives-what-the-sprint-changes`, and each
  site that enforces the split cites
  `@decision: one-drive-procedure-fixes-nothing`.

### Confirm drives cover drive defects a verifier folded into another defect
Realizes: decision:drive-tries-each-story-as-a-user,
story:catch-broken-promises, story:certify-completion.
Issues: confirm-drives-skip-duplicate-drive-defects.
- `scripts/review:unconfirmed_drive_defects` also returns each
  `source: drive` defect at state `duplicate` whose `same_as` defect
  stands `verified` with no `confirmed` field.
- `confirm_briefs` briefs one confirm driver per story and surface
  those defects name. A driver that gets the story confirms the
  verified defect. One that does not sends that defect back.
- `review drives --confirm --dry-run`, the fix loop's end check, and
  the return's list of unconfirmed drive defects all read that filter.
- The confirm step and `skills/converge/prompts/drive.md`'s confirm
  instructions name the defect the driver marks.
- Builds on "`/drive` drives stories and fixes nothing; `/converge` and sprint certification run its drive", which moves the confirm-adjacent drive text.

### A stop meets the goal's condition, and says it is no success
Realizes: decision:every-stop-ends-the-goal,
decision:sprint-goal-read-from-the-repository,
decision:stopped-run-resumes.
Issues: stopped-sprint-never-ends-goal.
- **`scripts/review:stopped_verdict`.** After the reasons, it prints a
  line saying the goal's condition is met: the run reached a verdict,
  the verdict is a stop and not a success, the owner takes up the
  reason, and the same goal line resumes the run. The line drops
  "This ends the goal".
- **`scripts/docs:stopped_verdict`.** It does the same in both its
  branches. Where the plan no longer covers the product, the
  condition is met, the stop is no success, and the owner plans again.
- **`skills/plan-sprint/sprint-document.md`.**
  - Step 1 drops the first-message instruction. It says the goal line
    carries the condition, and keeps deleting a standing stop record
    first.
  - Steps 11 and 13 and the goal rule say that `SPRINT STOPPED`
    meets the goal's condition while the contract stays unmet.
  - The start check's `ls` reporting a missing tool meets the
    condition the same way. That `ls` is the step 2 check the
    work item "The sprint's start checks check the review script" adds.
- **`skills/plan-docs/doc-sprint-document.md`.** The same changes land
  in step 1, step 3, and the goal rule. In step 3, "That `ls` output
  ends the goal" becomes "meets the goal's condition".
- **Other sites.**
  - `skills/_sprint/shared.md` `{{CEREMONY-RUN-RULES}}` and
    `skills/converge/SKILL.md`'s sprint return paragraph change
    their wording to match.
  - `scripts/ok-planner-CLAUDE.md` and
    `scripts/ok-planner-cheatsheet.md` drop "ends the goal unmet",
    the first-message sentences, and "a new `/goal`". In their place,
    they say the same goal line resumes the run.
- **Retired lines.** The template lines replaced in the two
  boilerplate sections join `admin/retired-boilerplate.json` and
  `admin/retired-doc-sprint-boilerplate.json`.
- Depends on "The sprint's start checks check the review script".

### Planning hands the owner the whole goal line
Realizes: decision:sprint-goal-read-from-the-repository,
decision:every-stop-ends-the-goal,
decision:drain-runs-as-a-workflow-script.
Issues: stopped-sprint-never-ends-goal.
- `skills/_sprint/shared.md` `{{PLANNING-HANDOFF}}` hands over one
  goal line per kind, with the path, the command, and the start
  check's `ls` paths stamped in. For a sprint:

  ```
  /goal Run .ok-planner/sprints/<name>.md as its "How to execute this sprint" section says. This goal is met when `.ok-planner/bin/review certified --sprint .ok-planner/sprints/<name>.md` prints `SPRINT COMPLETE` or `SPRINT STOPPED`, or when the start check's `ls <the paths step 2 lists>` reports one of them missing, in this session after this goal was set. `SPRINT STOPPED` and a missing tool mean the run stopped and the owner takes up the reason; neither is a success. Archiving and committing are the owner's acts, not goal terms. Run each drain as a workflow.
  ```

- For a documentation sprint, the line names:
  - `.ok-planner/doc-sprints/<name>.md`;
  - the "How to execute this documentation sprint" section;
  - `.ok-planner/bin/docs complete --sprint <path>`;
  - `DOCS COMPLETE` and `DOCS STOPPED`;
  - the step 3 `ls .ok-planner/bin/tasks .ok-planner/bin/issues
    .ok-planner/bin/review .ok-planner/bin/docs`;
  - "Archiving, committing, and the stamps are the owner's acts, not
    goal terms."
- The handoff tells the owner two things. The last sentence opts in
  to Workflow drains. Leaving it out has the session drain by hand.
- The block keeps the documentation sprint's conditional reset of
  the `Planned against commit` line exactly as it stands
  (decision:planned-commit-moves-only-over-read-work).
- In `skills/plan-sprint/SKILL.md` step 14.4 and
  `skills/plan-docs/SKILL.md` step 7.2, the first-message sentence
  becomes one saying that the goal line carries the condition.
- `skills/_tasks/drain.md` quotes the opt-in as `Run each drain as a
  workflow.`
- Depends on "A stop meets the goal's condition, and says it is no success".

The new decision planned-commit-moves-only-over-read-work needs no work
item. `{{PLANNING-HANDOFF}}` already enforces it, and "Planning hands the owner the whole goal line" keeps that
text. Its delta lands in a stage of its own. Skill text carries no
citation.

### The drain fills every free slot on each return

Realizes: decision:drain-fills-every-free-slot, decision:team-execution-cold-gate, decision:drain-runs-as-a-workflow-script
Issues: drain-window-held-at-first-fill

After each agent returns, both forms of the drain loop in `plugins/ok/families/ok-planner/skills/_tasks/drain.md` start one fresh agent per task the lines list as waiting, up to the cap less the agents in flight. They count each agent started and not yet claimed against its profile's waiting tasks, so no task gets two agents. This applies to the hand loop's steps 1 to 3 and to the Workflow script's fill after a return and the prose above the script. Step 3 no longer says "one in for one out" or "never exceeds the first fill". To make the unclaimed count exact, each `run` line that `plugins/ok/families/ok-planner/scripts/tasks` prints also names how many of the profile's tasks agents hold (`running=<n>`). The drain reads the agents of a profile in flight beyond that count as unclaimed, and counts zero where forks hold more tasks than the drain has agents in flight. `tasks --help` and the drain's description of the `run` line name the new field. The stuck check and the lifetime pause behave as they do now.

### Every vendored profile names its tools, and drivers run on a drive profile

Realizes: decision:profiles-name-their-tools, decision:subagent-model-follows-job, decision:drive-tries-each-story-as-a-user
Issues: vendored-profiles-start-from-an-unshrunk-context

Each profile under `plugins/ok/families/ok-planner/agents/` names a `tools` list with no Skill tool:
- `ok-opus.md`: Bash, Read, Edit, Write, NotebookEdit, Grep, Glob, LSP. The list replaces its `disallowedTools`.
- `ok-haiku.md`: Bash, Read, Grep, Glob.
- `ok-review.md`: Agent, Bash, Read, Grep, Glob, LSP.

A new `ok-drive.md` pins `opus` at high effort and denies Agent and Skill with no `tools` list, so its agents keep the session's MCP tools. Its body is the claim protocol `ok-opus` carries, closing without `--sites`, and its description follows the other profiles' "ONLY dispatched by the task tracker's drain loop" form. `scripts/review`'s `drives` verb files every driver and confirm-driver task under `ok-drive`. `skills/converge/SKILL.md` registers `ok-drive` in `drive` and `sprint` mode. The `drive-start` task stays on `ok-opus`.

Every prompt names one instruction for reaching the language server tool: `scripts/ok-cheatsheet.md`, `scripts/hooks/subagent-batching`, `skills/_sprint/shared.md`, `skills/plan-sprint/core.md`, and the `fix`, `verify`, `restore`, `hunt-file`, and `hunt-flow` prompts under `skills/converge/prompts/`. An agent of `ok-opus` and of `ok-review` can follow that instruction. Where a tools list hands `LSP` over deferred, the list also names ToolSearch. Where it hands `LSP` over callable at once, the instruction says to call it directly.

The text `scripts/hooks/subagent-batching` injects into every subagent words its LSP instruction so that it applies only to an agent whose tools include LSP. `ok-test` and `ok-haiku` agents read it as not theirs, and keep their tool lists as ruled.

The profile lists in `scripts/ok-planner-cheatsheet.md` ("The task tracker") and `scripts/ok-planner-CLAUDE.md` name `ok-drive` and what it runs.

### A lean test profile runs the test stages' test-support, test, verify, and speed tasks, with the suite's rules for its role in its body

Realizes: decision:lean-profiles-carry-their-rules, decision:lean-body-copied-word-for-word, decision:stale-lean-body-stops-test-work, decision:profiles-name-their-tools, decision:team-execution-cold-gate, decision:steering-over-prose-lint, story:write-time-prose-steering
Issues: test-stage-agents-start-from-the-full-opus-context, vendored-profiles-start-from-an-unshrunk-context, rules-files-load-whole-into-every-agent

A new `plugins/ok/families/ok-planner/agents/ok-test.md` names `tools: Bash, Read, Edit, Write, Grep, Glob` and `omitClaudeMd: true`, and pins `opus` at high effort. Its canonical body holds the claim protocol the other profiles carry, closing without `--sites`. It names the suite sections it carries by source file and heading and copies none of their text.

`admin/true-up` writes the vendored `.claude/agents/ok-test.md` in two parts:
- The claim protocol.
- The suite sections, copied word for word by heading from the cheatsheets as true-up renders them for the project, the lint check choices applied, so each section matches its materialized cheatsheet word for word:
  - from `docs/plumbline-cheatsheet.md`: Comments, DRY and Abstraction, Uniformity, Errors, Technical Writing, and Tests;
  - from `docs/plumbline-coding.md`: rules 1, 2, 4, 6, and 9;
  - from `scripts/ok-cheatsheet.md`: "Batch independent tool calls".

The body holds only those suite-authored sections. No project rules file, no CLAUDE.md, no `ok-concepts.md`, and no concept catalog goes into it.

True-up refuses to render a profile that names a section its source lacks, and names the section. True-up records a hash of each of the four materialized cheatsheets under `.claude/rules/`, which the sections match word for word, in `.ok-planner/lean-profiles.json` in the same write as the profile. That record names the profile, each cheatsheet's path, and its hash. Diagnose reports a vendored `ok-test.md` that differs from its rendering, as it does for every vendored file.

`scripts/tests` gains one check. It compares each of the four cheatsheets with the record, and fails where a cheatsheet's hash differs or a recorded cheatsheet is gone. It names each such file and says to run `/ok`. Every verb of `scripts/tests` that files an `ok-test` task runs this check first and files nothing while it fails. That covers the write, verify, and speed stages, and the test tasks sprint certification files.

The tests tool files test-support, test, verify, and speed tasks under `ok-test`, and preflight, legacy, and sweep tasks under `ok-opus`. The start checks in the execution section of `skills/plan-sprint/sprint-document.md` run the same check wherever the run opens test stages. Where it fails, they stop the run with a stop record that names the files and `/ok`. The registration step of that section registers `ok-test` wherever the run opens test stages. `admin/retired-boilerplate.json` carries the replaced text, so true-up brings live sprints current. `skills/converge/SKILL.md` registers `ok-test` in `sprint` mode wherever the suite runs.

The opening paragraph of `skills/_tasks/drain.md` says that a lean profile's body also carries the suite's rules for its role. The profile lists in `scripts/ok-planner-cheatsheet.md` and `scripts/ok-planner-CLAUDE.md` name `ok-test` and the roles it runs.

Depends on "Every vendored profile names its tools, and drivers run on a drive profile", which shares `skills/converge/SKILL.md` and the two profile lists. It also depends on "Every test task of a pass waits on every test support task, under one name" and "A test task takes a story's scenarios, up to `testing.chunk`", since both touch the filing in `scripts/tests`.

### Every suite skill's description is its guard and one sentence

Realizes: decision:skill-descriptions-hold-the-guard-and-one-sentence, decision:slash-only-activation
Issues: vendored-profiles-start-from-an-unshrunk-context

Each suite skill's `description` reads as its activation guard plus one short sentence naming what the verb does, and nothing more. The skills are the nine under `plugins/ok/families/ok-planner/skills/*/SKILL.md`, the front door's `plugins/ok/skills/ok/SKILL.md`, and the two under `plugins/ok-web/skills/*/SKILL.md`. The guard keeps its current words. `/converge` keeps naming sprint execution as its one machine caller. `/triage-issues`'s guard names its machine caller as the step after the owner list that `/converge` and `/drive` each end with, which the session runs. What each description drops stays in the skill's body. Where the body lacks it, the body gains it.

### The administration names an ancestor CLAUDE.md for exclusion

Realizes: decision:ancestor-claude-md-left-to-the-owner
Issues: vendored-profiles-start-from-an-unshrunk-context

`plugins/ok/families/ok-planner/admin/true-up`'s diagnose prints one line for each `CLAUDE.md` in a folder above the project root that `claudeMdExcludes` in `.claude/settings.json` does not name. The line recommends listing the file there. It changes no exit code, writes nothing, and adds no plan step. `admin/ADMINISTRATION.md` tells `/ok` to put each such line in the administration report as a recommendation the owner may take or leave.

### Refile holds its waiters until the refile closes

Realizes: `concept:task-tracker`. Issues: `refile-leaves-waiters-issued`.

`tasks refile` makes each open task that waited on the refiled task wait on the refile, and takes back the issued mark of each such task that stands issued and unclaimed, so `tasks claim` never hands out a waiter before the refile closes. Changes `plugins/ok/families/ok-planner/scripts/tasks` (`cmd_refile`), with every sibling verb that issues a task checked for the same gap.

### Certification counts only drives that ran and reviews that forked

Realizes: `story:certify-completion`, `concept:completion-contract`, `decision:drive-tries-each-story-as-a-user`, `decision:certification-drives-what-the-sprint-changes`. Issues: `certified-counts-unrun-drives`.

`review certified` counts a story as driven only where a driver task for it closed with a result, and counts the review as run only where the review root forked at least one pass task that closed `done`. A ledger with filed but unrun drivers, or a review root with no pass task, prints `SPRINT NOT COMPLETE` naming what did not run. Changes `plugins/ok/families/ok-planner/scripts/review` (`certification_failures`, `driven_stories`). Depends on the work item that adds `/drive` and narrows certification's drive, since both change which stories `certification_failures` requires.

### Documentation sprints give every fixed file a style read

Realizes: `story:keep-documentation-current`, `decision:documentation-style-read-once`, `decision:documentation-sprints-write-the-documentation`. Issues: `doc-sprint-fixed-check-file-has-no-style-task`.

When a fix writer changes a file the plan only checked, the documentation sprint files a style task for that file before the fact loop checks the file again, so every changed file gets one cold style read and every claim the style read changes gets checked. A run that follows the template reaches `DOCS COMPLETE` unattended. Changes `plugins/ok/families/ok-planner/skills/plan-docs/doc-sprint-document.md` steps 6 and 7, and `plugins/ok/families/ok-planner/scripts/docs` (`complete_failures`) where it must agree.

### Documentation sprints check every reference file against the public surface

Realizes: `story:reference-names-the-public-surface`, `decision:surface-members-listed-at-need`, `decision:every-public-class-has-a-reference`. Issues: `doc-sprint-lists-classes-in-one-checker-task`.

Every checker task that holds a file of a reference docspec compares that file's listing against the public surface, so no reference file can leave out a public element or list an internal one unchecked. Changes `plugins/ok/families/ok-planner/skills/plan-docs/doc-sprint-document.md` step 7 and the DOC-CHECK-PROMPT in `plugins/ok/families/ok-planner/skills/plan-docs/core.md`.

### Certification reads speed verdicts from both of a sprint's ledgers

Realizes: `story:suite-gets-faster-over-time`, `decision:speed-acceptance-outlives-support-changes`, `decision:speed-read-at-three-points`. Issues: `certification-speed-ignores-build-stage-verdicts`.

The tests tool reads speed verdicts from the sprint's build run file and from the certification ledger, so a test the build stage accepted at its current blob is not read again, and a product-slow site already reported is not reported a second time. Changes `plugins/ok/families/ok-planner/scripts/tests` (`speed_rows`, `speed_candidates`, `stage_speed`, `cmd_slowest`).

### The speed ranking carries every whole-suite round at the current blob

Realizes: `story:suite-gets-faster-over-time`, `decision:speed-ranked-by-median-seconds`. Issues: `speed-ranking-keeps-batch-size-seconds`.

`tests stamp` carries each test's seconds from every whole-suite round that ran it at its current test file's blob, not only the latest `testing.slowest`, so the next sprint ranks by the median of all of them. Changes `plugins/ok/families/ok-planner/scripts/tests` (`speed_ranking`, `cmd_stamp`).

### The test plan keeps test support that kept legacy tests read

Realizes: `story:retire-a-legacy-suite`, `decision:legacy-suites-sorted-automatically`. Issues: `support-of-kept-legacy-test-deleted`.

When the tests tool assembles a plan, it counts each kept legacy test file as a reader of the test support files it uses, so no test support file a kept legacy test reads is marked for deletion as an orphan. Changes `plugins/ok/families/ok-planner/scripts/tests` (`sorted_support`, `kept_uses`, `assembled_plan`, `plan_failures`). Depends on the work item that renames support to test support.

### A sprint that plans no tests leaves untaken legacy tests alone

Realizes: `story:retire-a-legacy-suite`, `decision:legacy-suites-sorted-automatically`. Issues: `nothing-to-plan-sweeps-untaken-legacy-tests`.

A sprint whose test scope plans nothing still records each legacy test file it leaves alone as kept, so the sweep deletes none of them and a frozen certification refuses none. Changes `plugins/ok/families/ok-planner/scripts/tests` (`stray_paths`) and the nothing-to-plan branch wherever the test-planning move puts it. Depends on the work item that moves detailed test planning into execution.

### True-up asks before it rewrites an edited untracked suite file

Realizes: `story:turn-down-a-destructive-true-up`, `decision:true-up-asks-once-before-destructive-steps`. Issues: `true-up-rewrites-untracked-edited-stamped-file`.

True-up compares each stamped suite file git does not track against the text its stamp's release wrote, and marks a rewrite of one that differs as destructive, so `/ok` asks the owner once and true-up copies the file into the archive before it rewrites it. The git-ignored folders the suite writes keep their exemption. Changes `plugins/ok/families/ok-planner/admin/true-up` (`materialize_steps`, `uncommitted`) and the matching statement in `plugins/ok/families/ok-planner/admin/ADMINISTRATION.md`.

### Scripts accept SHA-256 commit names

Realizes: `decision:closing-commit-baseline`, `decision:corpus-audit-hands-a-discovery-to-planning`. Issues: `commit-patterns-refuse-sha256-names`.

Every suite script that checks a commit name accepts 7 to 64 hex digits, so a repository on Git's SHA-256 object format reads back the base files and `closed:` stamps the suite writes. Changes `plugins/ok/families/ok-planner/scripts/tests` (`SHA`), `scripts/review` (`CLOSED_STAMP`), and `scripts/discover` (`cmd_assemble`), and every other pattern a search of `plugins/` finds that bounds a commit name at 40 digits.

### The sprint's start checks check the review script

Realizes: `decision:every-stop-ends-the-goal`. Issues: `sprint-stop-unreachable-without-review-script`.

The sprint template's start checks first run `ls` over the tools `review certified` needs, `.ok-planner/bin/review` among them, and show its output whole. Where one is missing, the run writes the stop record naming each missing tool and saying that `/ok` materializes it, and stops without running `review certified`. The goal's condition names that `ls` output as a verdict that ends the goal, as the documentation sprint template does for `docs complete`. Changes `plugins/ok/families/ok-planner/skills/plan-sprint/sprint-document.md` steps 1 and 2. Depends on the work item that rephrases the goal as reaching a verdict.

## Tests

off

## Implementation notes

Planned against commit `349193a610d34da51635b3345682374ac0409395`.

Paths below are under `plugins/ok/families/ok-planner/` unless they start with `.ok-planner/`, `checks/`, `docs/`, or `plugins/`. The canonical copies change; true-up rewrites the materialized copies under `.claude/` and `.ok-planner/bin/`. No story has a recorded scenario, so every **Tested stories** list is `None.`

Files several work items change, whose stages chain with `--after`:
- `scripts/tests`: the test-support rename, then the chunk item, then the refile-mapping item (their stated order); then test planning, runtime parts, kept-legacy support, and nothing-to-plan; then result-line clocks and suite faults; then the lean check, speed ledgers, and the ranking carry; SHA-256 at any point after the rename.
- `scripts/tasks`: the drain's `running=`, refile, and test planning's `--planning` render.
- `scripts/review`: the `/drive` split, confirm drives, certified counts, the stop verdict, SHA-256, the drive profile, and the lean record's owner class.
- `admin/true-up`: runtime offers, chunk and group size, the lean render, untracked edits, the ancestor CLAUDE.md line, and the `drive` skill entry.
- `skills/plan-sprint/sprint-document.md` and `admin/retired-boilerplate.json`: test planning, test-support, chunk, refile mapping, lean profile, `/drive`, the stop, and the start checks. Whichever stage edits the template last regenerates the retired list and runs `python3 checks/sprint-boilerplate`; `skills/plan-docs/doc-sprint-document.md` and `admin/retired-doc-sprint-boilerplate.json` the same for the stop, style-read, and reference-listing items.
- `skills/converge/SKILL.md`, `skills/converge/prompts/owner-list.md`, `skills/_tasks/drain.md`, `skills/_sprint/shared.md`, `scripts/ok-planner-cheatsheet.md`, `scripts/ok-planner-CLAUDE.md`, and `plugins/ok/skills/ok/SKILL.md`: most items.
- The annotation item lands after the stage that applies this sprint's decision deltas and runs `catalog-toc`, or the citation-resolution lint blocks its edits.
- `checks/owned-paths` changes in the same stage as each new true-up write site.

### Detailed test planning runs in sprint execution, ahead of the build

**Calls**
- The procedure moves into a new section of `skills/plan-sprint/tests.md`, `## The test planning procedure`, beside "Fixing a planner's items" and the scope-change rule. Step 3a reads it at `.claude/skills/plan-sprint/tests.md`. Decided by: the work item ("moves … into tests.md … reads it by path").
- The new step is numbered `3a`, so the steps other items and texts cite (2, 7, 11, 13) keep their numbers. Decided by: coding rule 2; converge's 2a, 3a and 5a are the sibling.
- Step 3a opens `.ok-planner/sprints/<name>-test-planning.jsonl`. Where that file already stands, it resumes it with `tasks use` and `tasks retry --all`. After the last assembly it runs `tasks use <name>-run.jsonl` so step 4 files into the sprint's run. Decided by: decision stopped-run-resumes; step 3 is the sibling.
- The programs task drains first. Every later planner brief names the program questions it raised as programs the plan holds no test for. Decided by: decision tests-planned-in-execution ("the plan holds no test for it until a story or that record stands").
- The runner check becomes a check in the plan-wide review prompt. Each kind-and-setup pair the suite command does not run inside `testing.silence` is a finding, and the fixing rules re-plan it. Where no form works, the planner records an `untested` call. Decided by: boilerplate step 7 ("The session … reviews nothing itself").
- The session writes each planning prompt with its transclusions resolved, as section 10 does today. `review prompt` reads only `prompts_dir`. Decided by: `scripts/review::cmd_prompt`.
- Each time control the plan lists becomes one step-4 build task:
  - key `<control id>`;
  - `--cites` the control id and each scenario that waits on it;
  - brief: its form, site, files, gate and scenarios.
  - The session records it with `tasks item add --pool divergences --key <id> --field kind=call --field site=<site> --field choice="build time control <id> as a code stage"`.
  - The write stage's `--after` names it.
  - Decided by: decision planned-tests-name-their-waits.
- Scenario questions end:
  - `tests plan` refuses a `questions` item that names a scenario, and names its task.
  - A scenario whose outcome the sprint changes is a `rewrite` plus a call.
  - A scenario whose code the sprint removes while its story stands is `retire` with `--field gap=true`: its test task deletes the test, and `tests stamp` records a gap.
  - Decided by: decision tests-planned-in-execution. No existing action both deletes the test and records a gap.
- `tests groups` takes the unguarded programs as `--unguarded '<path>=<owner's reason>' ...`. `/plan-sprint` passes them from the ruled issues, and `## Tests` lists the same set. Decided by: the work item. `groups` runs before the section is written, so it cannot read the section.
- The completion report shows the plan's calls through a new `tasks render --planning <run>`, with rows prefixed `plan:` (`--certification` and `cert:` are the sibling).
  - The planning run sets `calls` to `[{"pool": "calls", "latest": true}]`.
  - `latest` is a new selector key: it keeps an item only where its task is the latest task of its role and key and closed `done`.
  - What remains: a story re-planned under `story:<slug>` may also show the earlier group task's call for that story.
  - Decided by: the work item; `tasks::certification_rows`.
- Where the groups file plans nothing, step 3a files nothing and writes no plan. "Plans nothing" means no touched story, no file to sort, no runtime planner and no unguarded program. It is read from the file's contents, so a groups file an earlier release wrote reads the same way. Decided by: `tests::cmd_groups`'s nothing-to-plan rule.
- The planning run's `questions` pool takes state `open` only. Decided by: nobody answers in execution.
- The skill-description item also rewrites this skill's `description`. This item puts "the owner approves the scope" in the body's opening, and their two stages chain. Decided by: the two work items.
- Build note: I1 also changes the lint. `scripts/plumbline` `TESTING_KEYS` and `TESTING_SETTINGS` gain `group_size`, which the lint refuses as an unknown key today (B221). Decided by: the notes review.
- Build note: in sprint mode the owner list reads the plan only where `<name>-plan.json` stands. `read_plan` refuses with "no plan at" under `testing.enabled off` and for a nothing-to-plan sprint, so the read is guarded on the plan file. The owner-list template gains a `[SPRINT PATH]` placeholder, which it lacks today (B6). Decided by: the notes review.
- Build note: where steps 2 and 3 decide from the groups file, they keep the branch that opens test stages under `testing.enabled on` for step 4's speed read, and keep opening them where a `-plan.json` stands with no groups file beside it (B5). Decided by: the notes review.
- The planning run `<name>-test-planning.jsonl` is archived whole beside the sprint; the archive step does not split it. Decided by: the archive step splits only the run file, the results file, and the certification ledger, and nothing reads the planning run after the plan is assembled.

**Changes**
- `skills/plan-sprint/SKILL.md`: changed.
  - Opening, and description if it still names tests: the owner approves the test scope.
  - §2: keeps the offers and the widen.
  - §6: "The programs" subsection and its mention are removed.
  - §9 step 5: keeps the re-plan list.
  - §10: runs `tests groups --sprint <sprint>` with `--replan`, `--take`, `--new`, `--widen`, `--parts` (item 2), `--unguarded`, `--frozen`. It writes `## Tests` from the output. It opens no planning run, files no task, asks no programs, test or runner question, and drafts no time-control work item. Where nothing is planned: `Plan: none: nothing to plan`.
  - §11: the test-question bullet is removed.
  - §12: checks the re-plan list and the runtime parts.
  - §13: presents the scope. A declined new story leaves `--new`, and `groups` runs again.
  - §14 Terminal: names only the files the session writes, `<name>-groups.json` among them.
- `skills/plan-sprint/tests.md`: changed.
  - Gains the procedure: the run init; `ok-opus`; `item_states` with questions `["open"]`; `field_types`; the `calls` config; the seven prompts. Its steps: programs task, the groups' story tasks, runtime and sort tasks, assembly, the budget (old step 5's three conditions), the planner reviews, the plan-wide review, the fixes, the time controls handed to step 4.
  - Gains "Fixing a planner's items", moved from SKILL.
  - Gains the scope-change rule: a change at planning reruns `tests groups`.
  - Both review prompts:
    - say "before the plan is assembled";
    - check that no planned test enters an unguarded program or a program question;
    - check that each `rewrite` states the outcome the sprint states and each removed-code scenario is `retire` with a gap, each with a call;
    - drop the owner-answer checks;
    - the plan-wide review gains the runner check.
- `skills/plan-sprint/tests-story.md`, `tests-runtime.md`, `tests-programs.md`, `tests-budget.md`: changed.
  - Briefs name unguarded programs and program questions, not "the owner's answer".
  - Table rows "outcome changed" become `rewrite` with a call, and "code gone, story stands" becomes `retire` with `gap=true` and a call.
  - Scenario question records are removed.
  - The programs planner records each entry point no story serves as a question "for the intake, which sprint certification's owner list files".
  - No prompt says the owner approves or answers.
- `skills/plan-sprint/sprint-document.md`: changed.
  - `## Tests` template has six entries: state line; groups taken and stories widened; stories with new, revised or retired tests; runtime parts; unguarded programs with reasons; groups file path.
  - Step 2 and step 3 decide from the groups file.
  - New step 3a, as the calls say.
  - Step 4's `--after` includes the time-control stages.
  - Steps 5 and 13 render with `--planning <run>` where 3a ran.
  - Step 10 names the plan's calls.
- `admin/retired-boilerplate.json`: changed. Gains every replaced line.
- `scripts/tests`: changed.
  - `cmd_groups`: no `--from-run`, no program-question refusal. `--unguarded` is added. The `inputs` line names the unguarded programs, and the record carries `unguarded`.
  - `planning_inputs`, `settled_questions`, `apply_answer` and `ANSWERS` are removed, as symbols only they used. `planning_items` no longer returns `settled`.
  - `assembled_plan`: no answers. Program questions go to `plan["questions"]`. It refuses a scenario question. `unguarded` = the scenario list's plus the groups'.
  - `plan_failures`: refuses a new or rewrite whose entry a plan question names.
  - `cmd_plan --questions`: prints the program questions only.
  - `scenario_of`: reads `gap`.
  - `stamped_scenario`: a retire with `gap` returns `gap_scenario`.
  - `print_summary` and `print_plan`: list the program questions.
  - `build_parser` and `USAGE` follow.
- `scripts/tasks`: changed. `cmd_render` gains `--planning <run>`. `CALL_SELECTOR_KEYS`, `call_selectors`, `selects` and `call_rows` gain `latest`. Usage text follows.
- `skills/converge/prompts/owner-list.md`: changed. In sprint mode it reads `tests plan --sprint [SPRINT PATH] --show --json`. For each `questions` entry with no open issue on that program, it files a kind `audit`, `category: product-intent` issue. The close line counts them.
- Prose:
  - `scripts/ok-planner-cheatsheet.md` ("Lifecycle", "Tests");
  - `scripts/ok-planner-CLAUDE.md` ("The tests", lifecycle);
  - `docs/plumbline-cheatsheet.md` (Tests, `/ok-setup` line);
  - `docs/testing.md` (opening: "a sprint's test planners");
  - `CLAUDE.md` (the `tests*.md` layout line, the Tests paragraph).
  - Each says planning sets the scope and execution plans the tests.
- `.ok-planner/review/project.md`: changed. It records the `tests groups` and `plan` arguments and `tasks render --planning`.

**Improvements**
- **I1** `scripts/tests::GROUP_SIZE` and `groups --size`, default 8.
  - The harm: A8. Coding rule 10 makes a tuning literal a setting, read from config with no default.
  - Afterward:
    - `testing.group_size` is a required key, read by `cmd_groups` and `offer_groups`;
    - `tests declare --group-size`;
    - `groups --size` is removed;
    - the lint checks the key;
    - true-up writes 8 through `FORMER_SUITE_SETTINGS`;
    - `/ok-setup` §3.2 asks for it.

**Behavior changes**
- **B1** `scripts/tests::cmd_groups`.
  - Before: requires `--from-run` and refuses unanswered program questions.
  - After: no run is read; it takes `--unguarded`.
  - Users: in the release, SKILL §10 and the tests.md procedure. Across trued-up projects: an earlier release's groups file, which step 3a reads only where no plan stands, with a missing `unguarded` read as none.
  - Ruling: rewrite.
- **B2** `scripts/tests::assembled_plan`.
  - Before: applies owner answers and refuses unanswered questions.
  - After: records program questions, refuses scenario questions, carries the groups' unguarded programs.
  - Users: in the release, the procedure, owner-list and `cmd_stamp`. Across trued-up projects: a `-plan.json` an earlier release wrote beside an approved or archived sprint.
  - Ruling: migrate: a plan with no `questions` reads as one with none (call).
- **B3** `scripts/tests::cmd_plan` `--questions`.
  - Before: scenario and program questions waiting on answers.
  - After: program questions only.
  - Users: in the release, the procedure.
  - Ruling: rewrite.
- **B4** `/plan-sprint`, a public slash command.
  - Before: plans every test, asks the programs, test and runner questions, writes the plan.
  - After: sets the scope and writes the groups file and `## Tests`.
  - Users: across the public surface, the owner.
  - Ruling: preserve (call). Its arguments and its terminal approved sprint stand. The dropped questions are decision tests-planned-in-execution's Choice, which this sprint's delta commits.
- **B5** `skills/plan-sprint/sprint-document.md` "How to execute", steps 2, 3, 3a, 4, 5, 10, 13.
  - Before: test stages open from the plan, and no planning step runs.
  - After: they open from the groups file, and step 3a plans the tests.
  - Users: every executor. Across trued-up projects: approved sprints not yet in execution.
  - Ruling: migrate: the replaced lines join `retired-boilerplate.json` so true-up brings each sprint current, and a sprint whose plan already stands skips 3a (call).
- **B6** `skills/converge/prompts/owner-list.md`.
  - Before: files no program issue.
  - After: files one per plan question.
  - Users: in the release, converge sprint mode.
  - Ruling: rewrite.
- **B7** `scripts/tests::stamped_scenario`.
  - Before: a retire drops the scenario.
  - After: a retire with `gap` records a gap.
  - Users: in the release, `cmd_stamp`. Earlier plans carry no `gap`, so they behave as before.
  - Ruling: rewrite.

- **B36** `scripts/tests::testing_config` with I1.
  - Before: no `group_size`.
  - After: refuses its absence.
  - Users: across trued-up projects, `.ok-planner/config.json`.
  - Ruling: migrate: true-up writes `group_size: 8` where `testing` declares `run` (call).
- **B37** `scripts/tests::cmd_groups` with I1.
  - Before: `--size` is accepted.
  - After: removed.
  - Users: in the release, SKILL §10, which passes no `--size` today.
  - Ruling: rewrite.
- **B221** `scripts/plumbline::testingDefects` with I1.
  - Before: refuses `group_size` as an unknown key.
  - After: checks it.
  - Users: the edit hook and true-up's config check.
  - Ruling: rewrite.

**New surface**
- `tests groups --unguarded`, `tasks render --planning` and the `latest` calls selector, declared in `scripts/tests` and `scripts/tasks`: internal.

**Tested stories**
- None.

### Runtime parts are planned with no offer

**Calls**
- `tests groups` takes the parts as `--parts <part slug> ...`, the slug a runtime scenario's `part` field and id use. It refuses a value that is not a slug. Decided by: tests-runtime.md's id rule.
- Under `on` the groups always mark the runtime planner. Under `frozen` they mark it only where `--parts` names parts. The record carries `parts`, and `groups` prints the runtime brief line, which names the parts and, under `on`, "every part with no recorded scenario". Decided by: decision runtime-parts-planned-without-an-offer.
- Under `frozen`, a recorded runtime scenario whose `part` is not listed stands as recorded. Decided by: the same decision ("only where a part is listed").
- `--take runtime` gets its own refusal saying runtime parts are planned with no offer. Decided by: the work item.
- `IMPLEMENTATION-NOTES-FORM` gains **Runtime parts** for every work item, `None.` where there are none, like **Tested stories**. Decided by: the work item; Tested stories is the sibling.
- True-up removes `runtime` from `testing.offers` in a transform inside `lint_config_transforms`, which runs before `parsed_config` checks the file against the carried lint. Decided by: the true-up fold order.

**Changes**
- `scripts/tests`: changed.
  - `OFFERS` drops `runtime`, which `declared_values` and `testing_config` (via `offers_listed`) then refuse.
  - `offer_groups`, `offer_line` and `cmd_offers` lose the runtime group.
  - `cmd_groups`: `--parts`, the runtime marking above, the `--take runtime` refusal.
  - `assembled_plan` and `plan_failures`: the frozen per-part standing.
  - `USAGE` and `DECLARE` follow.
- `scripts/plumbline::TESTING_OFFERS`: changed. Drops `runtime`, so the config check refuses it.
- `admin/true-up`: changed.
  - `TESTING_OFFERS` drops `runtime`, so `former_testing` writes three offers.
  - `lint_config_transforms` gains a transform, "testing.offers names runtime, which is no longer an offer; true-up removes it".
- `skills/plan-sprint/core.md`:
  - `IMPLEMENTATION-NOTES-FORM` adds **Runtime parts**, one line per part: `` `<part slug>`: added | changed | removed. <the code that holds it> ``.
  - `CODE-PLANNER-PROMPT` gains step 13, which lists them, and its output form follows.
  - The notes review's check 3 also checks a wrong **Runtime parts** list.
- `skills/plan-sprint/tests-runtime.md`: changed. Briefed with the parts; under `on`, also every part with no recorded scenario; under `frozen`, only those parts' rewrites and retirements. "The owner took the runtime group" is removed.
- `skills/plan-sprint/SKILL.md`:
  - §2 Frame drops the runtime group.
  - §9 step 5 collects the runtime parts.
  - §10 passes `--parts`.
  - §12 gives the review the parts.
- `skills/ok-setup/SKILL.md` §3.6: lists three offers and proposes three.
- Prose: `CLAUDE.md`, `scripts/ok-planner-cheatsheet.md`, `scripts/ok-planner-CLAUDE.md` and `.ok-planner/review/project.md` drop the runtime offer.

**Behavior changes**
- **B8** `scripts/tests::OFFERS`, together with `cmd_offers` and `testing_config`.
  - Before: offers a runtime group and accepts `runtime` in the config.
  - After: neither.
  - Users: in the release, SKILL §2 and `/ok-setup` §3.6. Across trued-up projects: `testing.offers` in `.ok-planner/config.json`.
  - Ruling: migrate: true-up removes `runtime` from `testing.offers` and from the former offers it writes (call).
- **B9** `scripts/plumbline::TESTING_OFFERS`.
  - Before: accepts `runtime`.
  - After: refuses it.
  - Users: the edit hook and the true-up config check. Across trued-up projects: the same config.
  - Ruling: migrate: true-up removes the value before its check runs (call).
- **B10** `scripts/tests::cmd_groups` runtime marking.
  - Before: runtime planner only on `--take runtime`.
  - After: always under `on`, by `--parts` under `frozen`.
  - Users: in the release, SKILL §10 and the procedure.
  - Ruling: rewrite.
- **B11** `scripts/tests::assembled_plan` and `plan_failures`.
  - Before: once the runtime planner ran, it had to name every recorded runtime scenario.
  - After: under `frozen`, unlisted parts stand as recorded.
  - Users: in the release, the procedure.
  - Ruling: rewrite.
- **B12** `skills/plan-sprint/core.md` notes form, code planner and notes review.
  - Before: no runtime parts.
  - After: a per-item list that the notes review checks.
  - Users: in the release, SKILL §§9 and 12.
  - Ruling: rewrite.
- **B13** `/ok-setup` §3.6, a public slash command.
  - Before: four offers.
  - After: three.
  - Users: across the public surface, the owner.
  - Ruling: preserve (call). Same arguments; the dropped offer is the approved decision's Choice.

**New surface**
- `tests groups --parts`, in `scripts/tests`: internal.

**Tested stories**
- None.

### Each annotation cites the decision that holds its choice

**Calls**
- The sites the work item does not map are judged by its last rule:
  - `scripts/tests::testing_config`, `admin/true-up::earlier_testing_split`, `admin/true-up::testing_question` and `scripts/plumbline::testingDefects` enforce the suite command's form (`{tests}` and `{results}`, and the earlier one-test form): project-owns-its-suite-command.
  - `planning_items` selects the latest planner items, which is how a fix changes only the scenarios it names: tests-planned-in-execution.
  - `stage_verify` is the write-time speed read: speed-read-at-three-points.
  - `cmd_convert_state`, `plan_failures`, `reaches_map`, `stamped_scenario` and `cmd_stamp` keep scenario-list-decided-once: the list's form, its stamps, its conversion.
  - `run_setup` (setup before the silence clock) and the `docs/testing.md` row in `admin/true-up` keep tests-spend-time-only-on-their-outcome.
  - Decided by: the work item's last paragraph.

**Changes**
- `scripts/tests`: changed. Annotations only:
  - `run_suite` → project-owns-its-suite-command;
  - `results_rounds`, `results_file`, `cmd_run`, `recorded_round` → sprint-runs-recorded-whole;
  - `whole_round_lock` → second-whole-suite-round-refuses;
  - `cmd_groups`, `touched_stories`, `earlier_calls`, `offer_groups` → sprints-plan-what-their-work-reaches;
  - `ranked_slowest`, `median_seconds`, `speed_ranking` → speed-ranked-by-median-seconds;
  - `speed_settled`, `stamped_acceptances` → speed-acceptance-outlives-support-changes;
  - `stage_speed`, `speed_rows`, `speed_candidates`, `cmd_slowest`, `stage_verify` → speed-read-at-three-points;
  - `perf_failures` → product-slow-verdict-fixes-the-product;
  - `testing_config` → project-owns-its-suite-command;
  - `planning_items` → tests-planned-in-execution.
- `admin/true-up::earlier_testing_split` and `testing_question`: changed. Annotations → project-owns-its-suite-command.
- `scripts/plumbline::testingDefects`: changed. Annotation → project-owns-its-suite-command.

**Behavior changes**
- None. Every change is new code no existing user reaches.

**Tested stories**
- None.

### Every test task of a pass waits on every test support task, under one name

**Calls**
- The new stored names:
  - role and prompt `test-support`;
  - task key `test-support:<path>`;
  - brief prefix "test support file";
  - pool `test-support`;
  - cite prefix `test-support-item:`;
  - the field for test support files in plan scenarios, scenario-list scenarios, `tests` items, planning `scenarios` items and the T4 defect: `test_support`;
  - legacy sort value `test-support`.
  - Decided by: the work item; `restore_kickbacks` sets the underscore form for field names.
- The support digest keeps its field name `support` in `speed` items and `acceptances`. Only its prose becomes "the digest of its test support files". Decided by: the work item's list of stored names, which names four sites, and a digest is not a test support file.
- "Support" in the sense of code that supports a scenario ("Support is decided once", "no code supports") and "support scripts" are a different term and stay. Decided by: decision scenario-list-decided-once.
- `admin/true-up::TEST_SPRINT_BESIDE` and ADMINISTRATION.md's list of role prompts an earlier release wrote keep `support`. They name files that release wrote. Decided by: the trued-up projects boundary.
- `scripts/review` holds no support name. The prompt files the archive moves are named by step 3's `<name>-<role>.md` and change through the boilerplate. `scripts/review` needs no change. Decided by: `rg`.
- "A pass" is one `--stage write` run. Its test tasks, filed, refiled or reopened, wait on every test-support task the same run files. Decided by: decision test-support-written-before-tests.
- Every role reader that runs over stored ledgers accepts both `support` and `test-support`: `CHANGING_ROLES` and `HOLDING_ROLES` name both, so `late_tasks`, which `settled_failures` and `review certified` run, still reads an old ledger's `support`-role task. Decided by: the notes review, the stored state boundary.

**Changes**
- `scripts/tests`: changed.
  - `SUPPORT_POOL`, `SUPPORT_CITE`, `HOLDING_ROLES`, `CHANGING_ROLES`, `SORTS` are renamed.
  - `stage_support`, `support_brief`, `write_refusals`, `cited_support_items`, `support_of`, `sorted_support`, `kept_uses`, `plan_failures`, `live_tests`, `take_record`, `rewrite_support`, `scenario_brief`, `stamped_test`, `gap_scenario`, `stray_paths`, `run_blobs` callers, `print_plan`, `USAGE` and every refusal follow the rename.
  - One reader, `test_support_of(record)`, returns `test_support`, else the older `support`, for plan scenarios and `tests` items. `sprint_plan` and `read_plan` read a legacy `support` sort as `test-support`.
  - `stage_write`: every test filing (file, refile, `after`) waits on every test-support task filed in the pass.
  - `unregistered`: takes the template name from a role→template map (`test-support`→`test-support`, `test`→`test-write`, …), not `test-<role>`.
  - `read_state` refuses a scenario that carries `support` and names `/ok`.
  - `cmd_convert_state` also converts each scenario's `support` to `test_support`, and prints `earlier:` where either form change applies.
- `admin/true-up::STATE_DETAIL`: changed. Names both conversions. `test_state_conversion` already runs `convert-state`.
- Prompts: `skills/converge/prompts/test-support.md`, `test-write.md`, `test-verify.md`, `test-speed.md`, `test-sweep.md`, `merge.md` (T4), `fix.md`, `verify.md`. Pool, field and prose are renamed.
- `skills/converge/SKILL.md`:
  - step 4 registers `test-support` as `test-support`;
  - step 5 `item_states` uses `"test-support"`;
  - step 5a's T4 item uses `--pool test-support` and `--field test_support=<item>`;
  - step 6a uses `test_support`;
  - prose follows.
- `skills/plan-sprint/sprint-document.md`: step 3 (role, item_states), steps 4 and 7 prose. `admin/retired-boilerplate.json` gains the replaced lines.
- `skills/plan-sprint/tests-story.md`, `tests-sort.md`, `tests-runtime.md`: `--field 'test_support=[...]'`, `sort=test-support`.
- Prose: `skills/_sprint/shared.md` (T4 line 375), `docs/testing.md`, `docs/plumbline-cheatsheet.md`, `scripts/ok-cheatsheet.md`, `scripts/ok-planner-cheatsheet.md`, `scripts/ok-planner-CLAUDE.md`, `CLAUDE.md` (layout line 24), `.ok-planner/review/project.md`.

**Behavior changes**
- **B14** `scripts/tests::stage_write` waits.
  - Before: a test task waits only on the support tasks of its own files.
  - After: it waits on every test-support task of the pass.
  - Users: in the release, sprint execution and certification drains.
  - Ruling: rewrite.
- **B15** Task role, prompt, pool, cite and key names in run ledgers.
  - Before: `support`.
  - After: `test-support`.
  - Users: in the release, every listed prompt and skill. Across stored state: an archived sprint not yet stamped, whose run and certification ledger `scripts/tests::late_tasks` reads through `CHANGING_ROLES`. A sprint in flight across the upgrade is outside the trued-up projects boundary, as `.ok-planner/release-boundaries.md` says.
  - Ruling: migrate: every role reader that runs over stored ledgers accepts both `support` and `test-support`; no ledger is rewritten (call).
- **B16** The `support` field and the legacy `support` sort in `-plan.json` and in `tests` items.
  - Before: old names.
  - After: new names written; both read.
  - Users: across stored state, an archived sprint not yet stamped, its run and its certification ledger, and an approved sprint's earlier plan.
  - Ruling: migrate: `test_support_of` and the sort read accept both names (call). No ledger is rewritten.
- **B17** The scenario list's per-scenario `support`.
  - Before: `support`.
  - After: `test_support`, and `read_state` refuses the old field.
  - Users: across stored state, `.ok-planner/test-state.json`.
  - Ruling: migrate: `convert-state` converts it and true-up runs it in its plan, as it does for the earlier stamp form (call).
- **B18** `scripts/tests::unregistered`.
  - Before: would name `test-test-support`.
  - After: names the right template.
  - Users: in the release, the session that reads the refusal.
  - Ruling: rewrite.

**Tested stories**
- None.

### A test task takes a story's scenarios, up to `testing.chunk`

**Calls**
- Runtime scenarios group by their `part` field, the runtime counterpart of a story. Decided by: decision test-tasks-take-a-story-at-a-time's rationale (one agent reads shared code once).
- Test task key: `test:<story or part>:<n>`, numbered within the story. `--cites` lists the scenario ids. "Already filed" means some test task cites the scenario. Decided by: `stage_support`'s `support:<path>:<n>` keys, the sibling.
- Sent-back rewrites become new chunk tasks, one per chunk of a story's sent-back tests, not refiles of each scenario's last task. Decided by: the work item ("one task per chunk the same way").
- The refusal "two blocked, no test support item filed" counts the last two filings of one task key. Decided by: the work item ("per task, not per scenario").
- Verify key: `verify:<test task id>`. The brief takes each awaiting `tests` item that task recorded, with its own run's seconds, its declarations and its plan-text changes. Decided by: the work item.
- `testing.chunk` is required in every `testing_config` call. True-up writes `chunk: 1` through `FORMER_SUITE_SETTINGS`, which applies where `testing` declares `run`. 1 keeps the former one-scenario-per-task behavior. Decided by: decision settings-have-no-code-defaults.
- Build note: `stage_verify` also files verify tasks keyed `verify:<item id>` for `fixes` and `promises` pool items, each chained to the one before. The per-test-task key `verify:<test task id>` applies to `tests` items alone (B22). Decided by: the notes review.

**Changes**
- `scripts/tests`: changed.
  - `TESTING_KEYS` and `DECLARE` gain `chunk`. `testing_config` reads it with `tasks.count`. `declared_values` adds `--chunk` and refuses values below 1. `build_parser` follows.
  - `stage_write` builds chunks per story.
  - `write_refusals` works per key.
  - `sent_back_tests`, `refiled_tests` and `unwidened_rewrites` find tasks by cites and group rewrites by chunk.
  - `blocked_on_support` and the pending loop take scenarios from cites, not from the key.
  - `stage_verify` groups items by the task that recorded them.
  - `test_verify_brief` covers several items.
  - `USAGE` follows.
- `scripts/plumbline`: `TESTING_KEYS` and `TESTING_SETTINGS.chunk` (an integer, 1 or more).
- `admin/true-up::FORMER_SUITE_SETTINGS`: gains `"chunk": 1`.
- `skills/ok-setup/SKILL.md`: §3.2 lists `chunk`, §2 sends a change of it to the runner step.
- `skills/converge/prompts/test-write.md` and `test-verify.md`: several scenarios per task. Records are per scenario, and the close line lists each.
- `skills/converge/SKILL.md` step 5a and `skills/plan-sprint/sprint-document.md` steps 4 and 7 (plus `retired-boilerplate.json`): describe tasks per chunk.
- `.ok-planner/review/project.md`: `declare --chunk`, the required key.

**Behavior changes**
- **B19** `scripts/tests::testing_config`.
  - Before: no `chunk`.
  - After: refuses a config missing `testing.chunk`, naming it.
  - Users: in the release, every verb that runs or plans tests. Across trued-up projects: `.ok-planner/config.json`.
  - Ruling: migrate: true-up writes `chunk: 1` where `testing` declares `run` (call).
- **B20** `scripts/plumbline::testingDefects`.
  - Before: refuses `chunk` as an unknown key.
  - After: checks it.
  - Users: the edit hook and true-up's config check.
  - Ruling: rewrite.
- **B21** `scripts/tests::stage_write` filing.
  - Before: one task per scenario, keyed by scenario.
  - After: one per story chunk; refusals and refiles per task.
  - Users: in the release, `test-write.md`, converge 5a, boilerplate steps 4 and 7. Across: a sprint in flight.
  - Ruling: rewrite (call). release-boundaries.md "Not across it".
- **B22** `scripts/tests::stage_verify`.
  - Before: one verify task per `tests` item.
  - After: one per test task.
  - Users: in the release, `test-verify.md`, converge 5a.
  - Ruling: rewrite.
- **B23** `/ok-setup` §3.2, a public slash command.
  - Before: no chunk question.
  - After: asks for `chunk`.
  - Users: across the public surface, the owner.
  - Ruling: preserve (call). Same arguments.

**New surface**
- `tests declare --chunk` and the `testing.chunk` key: internal. Config fields are internal per the surface intent.

**Tested stories**
- None.

### The write stage refiles a blocked test task that waits on another blocked test task

**Calls**
- The mapping covers every filing that carries waits: `file`, `refile`, and `after` (a reopened task). The copied list of an `after` filing is mapped too, and `filed_tasks` writes the mapped list. Decided by: coding rule 8 (a defect is one member of a class).
- Filings are reordered topologically on their `+n` waits, ties kept in planned order, after `loop_refusals` rules out cycles. Decided by: the work item ("files each refile after the refiles it waits on").

**Changes**
- `scripts/tests::stage_write` (tail): changed.
  - Maps each wait through `latest_of`, then through every refile planned in the pass, earlier or later, and drops none.
  - Orders the filings so each one follows those it waits on.
- `scripts/tests::after_refusals`: changed.
  - Checks only the mapped `after`, even when it is empty, and never falls back to `copied`.
  - A `+n` id, or any id no task record holds, counts as not yet closed.
  - Refuses only a reached task that closed other than `done`, and names that task.
- `scripts/tests::filed_tasks`: changed. Writes the mapped waits for `after` filings.
- `skills/plan-sprint/sprint-document.md` step 7, with `retired-boilerplate.json`: the refusal is described as "followed through the refiles the same pass plans, then to its latest refile in the run".

**Behavior changes**
- **B24** `scripts/tests::stage_write` and `after_refusals`.
  - Before: a refile whose dependency's refile was planned later dropped that wait, or was refused on the original blocked id.
  - After: it waits on that refile, and only a reached task closed other than `done` refuses, by its id.
  - Users: in the release, boilerplate step 7 and converge 5a.
  - Ruling: rewrite.

**Tested stories**
- None.

### Result lines carry the command's clock, and the suite's contracts are checked before a round

**Calls**
- Clocks:
  - A pair of tests is compared on `started`/`ended` only where both lines carry both.
  - Otherwise both tests are compared on arrival (start = arrival − seconds, end = arrival).
  - So no comparison mixes two clocks.
  - Decided by: coding rule 3.6.
- A line with only one of the two fields, a non-number, or `ended < started` keeps its result. Its times are dropped with a stderr note, as `take_line` does for a bad `reaches`. Decided by: coding rule 2.
- The preflight's two-test check runs `tests run --only <a> <b> --json` with no `--sprint`, over two recorded tests that share a changed resource. That records no round in the sprint's results. Where none share one, the check is skipped. Decided by: decision suite-contracts-checked-before-a-round, and planned tests are not written yet when the preflight runs.
- The check that "the stack stays ready" runs `testing.setup`, runs it again, then runs one recorded stack test with `--only`.
- The resources check starts one scratch resource of a kind `testing.leftovers` counts, named for the check. It runs setup once, checks the resource still stands, then removes it on every exit.
- Decided by: the decision's wording; `testing.leftovers` lists the kinds.
- In `skills/_sprint/shared.md`, `{{TEST-RESOURCES-RULE}}`, which already states the schedule, gains a sentence on the two fields. Decided by: the work item.

**Changes**
- `scripts/tests::take_line`: changed. Records valid `started`/`ended`.
- `scripts/tests::overlapped` and `schedule_failures`: changed.
  - Compare per pair as in the calls.
  - The failure tail names which clock gave the times.
  - The sweep's early break holds only within one clock, so pairs on different clocks are compared in full.
- `scripts/tests::USAGE`: the result line and the failures text.
- `skills/ok-setup/SKILL.md`: §3.2 adds the fields to the result line; §3.7 gains the three checks, each failure proposed to the owner as a change to the command or the setup.
- `skills/converge/prompts/test-preflight.md`: gains the three checks; a failed check closes `blocked`, naming it.
- `docs/testing.md` (the schedule paragraph) and `skills/_sprint/shared.md` `{{TEST-RESOURCES-RULE}}`: changed.
- `.ok-planner/review/project.md`: the result line.

**Behavior changes**
- **B25** `scripts/tests::take_line`.
  - Before: drops `started`/`ended`.
  - After: records them.
  - Users: across trued-up projects, the project's own suite command, which updates on the owner's schedule.
  - Ruling: preserve (call). The fields are optional, and lines without them read as before.
- **B26** `scripts/tests::schedule_failures`.
  - Before: arrival only.
  - After: the command's clock where both lines carry it, and the tail names the clock.
  - Users: in the release, `standing_entries`, `suite_reports`, the merge's T4. Across stored state: results files from earlier rounds, which carry no fields and read as before.
  - Ruling: preserve (call) for lines without the fields; rewrite otherwise.
- **B27** `skills/converge/prompts/test-preflight.md`.
  - Before: checks sizing and limits.
  - After: also the three suite checks; it closes `blocked` naming a failed one.
  - Users: in the release, `stage_preflight` (refile, then blocker).
  - Ruling: rewrite.
- **B28** `/ok-setup` §3.7, a public slash command.
  - Before: pair comparison only.
  - After: three runs, each failure a proposal.
  - Users: across the public surface, the owner.
  - Ruling: preserve (call).

**Tested stories**
- None.

### Suite faults file no speed step, and product-slow fixes ride a round that runs anyway

**Calls**
- A setup failure is recognized by a failed result whose tail opens `setup failed`. One constant is shared by `run_setup` and the check. Decided by: coding rule 6; the `USAGE` contract names that prefix.
- A product-slow verdict counts as a failure where the latest closed whole-suite round has another unsettled failure in `round_failures`. It counts as `deferred` where that round has none. With no closed whole round it stays a failure, since the first round runs anyway. Decided by: decision product-slow-fixes-ride-a-round-that-runs-anyway.
- `tests failures --json` adds `deferred`. `tests settled` prints `SETTLED` with the deferred verdicts listed. It does not check that the intake took them, since the owner list files them after it. Decided by: the work item.
- The owner list reads `deferred` in sprint mode and skips one that already has an open issue on the same site. Decided by: owner-list.md's sibling dedupe.

**Changes**
- `scripts/tests::speed_refusal`: changed. Under `--round`, refuses a round whose only failures are `schedule--` entries or setup-failed tests, saying it is a suite fault.
- `scripts/tests::suite_reports`: changed. Adds T3 only where the latest whole round has another unsettled failure.
- `scripts/tests::unsettled_failures`: changed. Returns the deferred verdicts apart.
- `scripts/tests::cmd_failures`, `settled_failures`, `cmd_settled`: changed. Use and print `deferred`.
- `scripts/tests::run_setup`: changed. Uses the constant.
- `scripts/tests::USAGE`: changed.
- `skills/converge/SKILL.md`:
  - 3a.2 runs no speed step for a round whose failures `tests failures` lists as only `schedule--` entries or `setup failed` tails;
  - 2a: `SETTLED` with deferred verdicts ends the loop;
  - the return's `suite` line names them.
- `skills/converge/prompts/owner-list.md`: files each deferred verdict as `category: design`, naming the site, what it does, how its cost grows, and the cheaper behavior.
- `skills/_sprint/shared.md` T3 row and the paragraph under it: changed.
- `.ok-planner/review/project.md`: changed.

**Behavior changes**
- **B29** `scripts/tests::speed_refusal`.
  - Before: files speed tasks for any failed round.
  - After: refuses suite-fault rounds.
  - Users: in the release, converge 3a.2.
  - Ruling: rewrite.
- **B30** `scripts/tests::suite_reports`.
  - Before: T3 always.
  - After: T3 only beside another failure.
  - Users: in the release, converge 3a.4, the merge.
  - Ruling: rewrite.
- **B31** `scripts/tests::unsettled_failures`, `cmd_failures`, `settled_failures`.
  - Before: a lone perf verdict fails `settled`.
  - After: it is deferred.
  - Users: in the release, converge 2a, `scripts/review::suite_failures` (through `tests settled`), owner-list.
  - Ruling: rewrite.
- **B32** `skills/converge/prompts/owner-list.md`.
  - Before: does not file deferred verdicts.
  - After: files one `design` issue per verdict.
  - Users: in the release, converge.
  - Ruling: rewrite.

**Tested stories**
- None.

### `/drive` drives stories and fixes nothing; `/converge` and sprint certification run its drive

**Calls**
- In `docs/integration-contract.md`, "Current conformance" lists `drive` among the vendored skills. Decided by: rule 1, since that list restates the `SKILLS` map.
- Wording changes for the owner list as a writer of defect issues. Decided by: the amended decision intake-writers-are-gated.
  - `scripts/ok-planner-cheatsheet.md` "Filing" (around line 210), `scripts/ok-planner-CLAUDE.md` (around line 370), and the family `CLAUDE.md` (around line 71) name the owner list as the one writer of defect issues, the list both `/converge` and `/drive` end with.
- The `execute-tasks` row in `admin/ADMINISTRATION.md` (around line 392) and in `plugins/ok/skills/ok/SKILL.md` (around line 127) names `/drive` among the drain's readers. Decided by: rule 1.
- `README.md:110` ("drives every story") is left alone. The `readme` docspec covers it, so a documentation sprint writes it. Decided by: the docspec index and documentation-sprints-write-the-documentation.
- The work item's bare "`CLAUDE.md`" means the family `CLAUDE.md`. The repository has no root `CLAUDE.md`. Decided by: the tree.
- The shared text holds the merge step. Sprint certification runs that step inside its own step 5, beside `review merges --source sprint`, so drive failures are merged once and fold with the other findings. Decided by: one-drive-procedure-fixes-nothing.
- `/drive` writes its prompts without `--sprint`, in both forms. The sprint only picks the stories, and a drive-only run files every kept defect whatever its scope. Decided by: defects-outside-scope-become-defect-issues.
- `/drive`'s preconditions are those in step 1 of `/converge`:
  - `.ok-planner/bin/tasks` exists;
  - the profiles exist;
  - `.ok-planner/review/` holds `config.json`, `project.md`, and `catalog/accept.md`;
  - `issues list` does not refuse.

  It skips the checks only sprint certification needs: `approved`, the base file, and `tests enabled`. A drive writes no base file and fixes nothing. Decided by: the work item.
- `/drive` registers `ok-drive` beside `ok-opus` once the profile work item lands, because `review drives` then files drivers under `ok-drive`. Without it, no agent claims a driver. Decided by: the profile work item's change to `cmd_drives`.
- `/drive`'s pools: `item_states` for `failures`, `defects`, `merges`, and `calls`, with the same states `/converge` declares. Its calls setting is `[{"pool":"failures","states":["not-owed","rejected"]}]`, the merge's sorts. Decided by: converge-close-takes-vetoes and rule 2, copying the sibling's shape.
- The owner-list task's brief is `run <name>; drive only`. The prompt uses that marker to tell a drive-only run apart. Decided by: rule 2, following `/converge`'s brief shape.
- `review stories --sprint` reads `story:<slug>` with the pattern `(?<![@\w-])story:([a-z0-9][a-z0-9-]*)`. It reads the work-items section through `section_lines`, so citations (`@story:`) and placeholders (`story:<slug>`) never match. Retire deltas name no story. Decided by: the work item's definition of the set.
- `review drives --sprint` given together with `--confirm` is refused, naming both flags. Decided by: rule 7.1.
- `review certified` reads the testing state when it gives its verdict. Decided by: the delta for certification-drives-what-the-sprint-changes says that state decides.
- Citations:
  - `@decision: certification-drives-what-the-sprint-changes` goes at `sprint_stories`, `cmd_drives`, and `certification_failures`.
  - `@decision: one-drive-procedure-fixes-nothing` goes at the `drive` entry of `admin/true-up` `SKILLS`. That is the one code site of the split; skill text carries no citation.
  - Each cited decision's delta must land in the same stage or an earlier one.

  Decided by: the work item and citation-resolution.
- Where the description work item has already reduced the `/converge` description to its guard and one sentence, the split goes into the body's modes, and the description sentence stays consistent with it. Decided by: skill-descriptions-hold-the-guard-and-one-sentence.

**Changes**
- `skills/_converge/drive.md`: new. It holds drive mode's steps 1 to 6 as they stand in `skills/converge/SKILL.md` lines 74 to 85 (the stories, the stack, the drivers, stopping the stack, one driver at a time, and the merge), with its opening paragraph. The caller names the story set: every story, through `review stories` / `review drives`, or a sprint, through `review stories --sprint <path>` / `review drives --sprint <path>`. Its tasks and items go into the caller's ledger. It carries no activation phrase.
- `skills/drive/SKILL.md`: new. Its contents:
  - The description holds the guard ("ONLY activated by explicit /drive slash command. Never auto-triggered by conversation content.") and one sentence.
  - It takes `/drive` or `/drive sprint <path>`.
  - It checks the preconditions above.
  - It opens a fresh ledger: `tasks init drive-<date>T<time> --file .ok-planner/review/runs/drive-<date>T<time>.jsonl`, with the run's folder beside it.
  - It registers `ok-opus` (and `ok-drive`) and the prompts `drive`, `drive-start`, `merge`, and `owner-list`, through `review prompt --name … --out <folder>/<name>.md`.
  - It declares the pools and the calls setting above.
  - It runs `.claude/skills/_converge/drive.md`, then the owner list (`tasks file --role report --prompt owner-list --agent ok-opus --key gate --files .ok-planner/issues.jsonl .ok-planner/history/issues.jsonl --brief "run <name>; drive only"`).
  - Where the owner list wrote anything, it runs `/triage-issues`, then `tasks use` its own ledger again.
  - Its return gives each story's outcome per surface and variant, the failures as the merge sorted them, the issues the owner list filed or found already open, each stack task that failed with its output tail, and the cost (`tasks status`, `tasks report`).
  - Its close presents the `tasks calls` table and takes vetoes as `/converge` does: one `product-intent` issue per vetoed row, with the owner's words as its ruling.
  - It offers to commit the ledger, the run's folder, and the intake's two files.
  - It edits no product file and files no fix, verify, restore, or confirm task.
- `skills/converge/SKILL.md`: changed.
  - Description and the find-loop modes: drive mode drives every story and fixes what the merge keeps. Sprint certification drives the sprint's new and changed stories under `on`/`frozen`, and every story under `off`.
  - Setup step 1: the shape line's story count comes from `review stories --sprint <path>` under `on`/`frozen`, and from `review stories` under `off`.
  - "In drive mode": runs the shared text over every story.
  - Sprint step 4:
    - Under `on`/`frozen`, it runs shared steps 1 to 5 with `review stories --sprint <path>` and `review drives --sprint <path>`. Where the set is empty, it skips the drive, says the sprint names no new or changed story, and leaves the contract as it stands.
    - Under `off`, it runs those steps with no `--sprint`.
  - Step 5: runs the shared merge step beside `--source sprint`.
  - Loop 2 steps 2 and 6: "drive mode's step N" becomes "step N of the shared drive text".
  - Return `hunt`/`sprint` lines: name the set the drive took.
- `skills/converge/prompts/owner-list.md`: changed. Where the brief says `drive only`, the run has no fix loop. Every defect standing `open` is one a merge agent confirmed. It is filed as a defect outside the run's reach, `category: defect`, kind `audit`, saying a merge agent confirmed it. The existing check against `issues list --category defect` for the same site comes first, so a defect already filed adds nothing.
- `scripts/review::sprint_stories`: new. It is `(root, sprint)`, and it returns the sorted, unique set:
  - the slugs of `New`/`Amend` story deltas, from `sprint_deltas`;
  - each `story:<slug>` that `## Work items` names whose `.ok-planner/design/stories/<slug>.md` exists.

  The sprint resolves through `resolved_sprint`.
- `scripts/review::cmd_stories`: changed. It takes `--sprint <path>` and prints `sprint_stories`. With no `--sprint`, it prints every story as now.
- `scripts/review::cmd_drives`: changed. It takes `--sprint`: with it, the briefs come from `sprint_stories`, and the alone and instance lists apply as now. It refuses `--sprint` with `--confirm`.
- `scripts/review::certification_failures`: changed. It takes the testing state.
  - Required set: under `on`/`frozen`, `sprint_stories`, with nothing required where that is empty. Under `off`, `story_slugs`.
  - One failure line per required story the ledger does not show as driven.
  - It returns the set's kind for the item 3 line.
- `scripts/review::cmd_certified`: changed. It reads `testing_enabled` before `certification_failures`. The item 3 line names the count driven and the set: "the sprint's new and changed stories" or "every story". Otherwise it says "the sprint names no new or changed story" or "the project has no story".
- `scripts/review::VERB_HELP` (`stories`, `drives`) and `build_parser`: `--sprint` on both verbs.
- `skills/plan-sprint/sprint-document.md`: changed.
  - The Work items placeholder: each item names its stories and decisions as `story:<slug>` and `decision:<slug>`.
  - Step 12 and Completion contract item 3: the sprint's new and changed stories under `on`/`frozen`, and every story under `off`.
- `admin/retired-boilerplate.json`: gains each replaced released line.
- `skills/_sprint/shared.md`: in `{{SPRINT-CATALOG}}`, "Every story is checked by the drive" becomes the drive's set under each testing state.
- Wording sites:
  - `scripts/ok-planner-CLAUDE.md` (around line 669);
  - `scripts/ok-planner-cheatsheet.md` (around line 149, plus `/drive` beside `/converge` in "On the owner's cadence");
  - `scripts/ok-cheatsheet.md:19`;
  - the family `CLAUDE.md`: line 9, "nine verbs" becomes ten with `/drive` listed, and the layout gains `skills/drive/` and `skills/_converge/drive.md` and names `/drive` among the drain's readers;
  - `plugins/ok/CLAUDE.md:9`;
  - the owner-list writer sites and the `execute-tasks` rows from **Calls**;
  - `docs/integration-contract.md`.
- `admin/true-up::SKILLS` and `UNPREFIXED`: add `drive`.
- `.ok-planner/review/project.md`: the review verbs line names `stories --sprint` and `drives --sprint`, `--sprint` refused with `--confirm`, and `certified`'s item 3 drive term under each testing state.


**Behavior changes**
- **B101** `/converge sprint` (`skills/converge/SKILL.md` sprint step 4).
  - Before: drives every story whatever the testing state.
  - After: under `on`/`frozen`, drives the sprint's new and changed stories, and drives none where there are none. Under `off`, drives every story.
  - Users in the release: sprint boilerplate step 12, and owners who type it.
  - Across the trued-up boundary: approved sprints, whose boilerplate true-up rewrites, and the vendored skill, which ships in the same true-up.
  - Ruling: rewrite (call). Decided by the owner's ruling on sprint-certification-drives-every-story-under-testing ("Narrow certification's drive only where testing is on or frozen").
- **B102** `scripts/review::certification_failures`.
  - Before: item 3 holds where any driver task names any story.
  - After: each story of the required set must be driven. The set is the sprint's stories under `on`/`frozen` (none required where there are none) and every story under `off`.
  - Users in the release: sprint steps 2, 11, and 13, and the goal checker.
  - Across stored state: certification ledgers of archived, unstamped sprints, and `-certified.txt` marks. Under `on`/`frozen`, the required set is a subset of what old ledgers drove. Under `off`, an old ledger fails only where a story went undriven, which is the A9 report the work item removes.
  - Ruling: preserve (call).
- **B103** `admin/true-up` vendoring.
  - Before: no `.claude/skills/drive/`.
  - After: vendored and stamped.
  - Across the trued-up boundary: a project with its own `.claude/skills/drive/`.
  - Ruling: migrate: the existing collision rule archives the project's unstamped files before writing the suite's copy, under the owner's one consent (call).
- **B104** `skills/plan-sprint/sprint-document.md` step 12 and contract item 3.
  - Before: every story.
  - After: the set for each testing state.
  - Across the trued-up boundary: approved sprints not yet in execution.
  - Ruling: migrate: the replaced lines join `retired-boilerplate.json`, so true-up brings each live sprint to the carried shape (call).
- **B105** `skills/converge/SKILL.md` description, modes, and return.
  - Before: "a drive of every story".
  - After: the split and the narrowing.
  - Users in the release: the vendored copy. The slash name is unchanged.
  - Ruling: rewrite.

**New surface**
- `/drive` and `/drive sprint <path>`, declared in `skills/drive/SKILL.md`: public by the surface intent's "Slash commands" rule.
- `review stories --sprint` and `review drives --sprint`, declared in `scripts/review`: internal.
- `skills/_converge/drive.md`: internal, because a folder starting with `_` holds shared text.

**Tested stories**
None.

### Confirm drives cover drive defects a verifier folded into another defect

**Calls**
- A fixer marks a duplicate without a `same_as` field. It records only `choice` and the note (`skills/converge/prompts/fix.md`, line 22). The filter keys on `same_as`, so `fix.md`'s duplicate command adds `--field same_as=<the defect id>`. Decided by: the issue's ruling, which keys on `same_as`.
- A folded duplicate counts only once a verifier accepted it (it carries a `verified` field). Decided by: the work item's "a verifier folded", and Loop 2 step 5, which reopens every duplicate with no `verified` field.
- A defect with more than one confirm driver confirms through a serial relay, so its one `confirmed` mark has one writer at a time and never races. Decided by: drive-tries-each-story-as-a-user ("confirmed only once every such driver gets its story… the mark stays one") and rule 3.2.
  - `review drives --confirm` chains the defect's drivers with `--after`: the defect's own driver first, where its `source` is `drive`, then one per folded story and surface. Each brief carries `confirm <k> of <n>` and, from k=2 on, `after driver <task>`.
  - A driver at k > 1 first reads the defect. Where the defect no longer stands `verified`, or its `confirm_reached` field does not name the task before it, the driver closes `done` with `skipped: driver <task> did not get its story` and drives nothing.
  - A driver that achieves at k < n sets `confirm_reached=<its task>`. At k = n it sets `confirmed`. A driver that fails sends the defect back. A driver blocked by the stack sets no field, so the relay stops and the next confirm round tries again.
  - A stale `confirm_reached` names a task of an earlier chain, so it never matches.
- A folded entry already covered by the verified defect's own story and surface files no second driver. Decided by: the delta's "per story and surface the duplicates name".

**Changes**
- `scripts/review::unconfirmed_drive_defects`: changed. It returns each verified defect with no `confirmed` field whose `source` is `drive`. It also returns each verified defect with no `confirmed` field that one or more folded duplicates name, where a folded duplicate has state `duplicate`, `source: drive`, a `verified` field, and `same_as` set to that defect. Each entry carries its folded duplicates. It never calls `defect_stories` on a defect with no `story` field: a review- or hunt-found target has none.
- `scripts/review::confirm_briefs`: changed.
  - The defect's own brief comes first, as now, where the defect's `source` is `drive`.
  - Then one brief per distinct (story, surface) of its folded duplicates, in the form `confirm: defect <verified id>; story <slug>; surface <s>; variant <the variants the duplicates name>; kickbacks <the verified defect's>; folded <dup ids>; earlier driver saw: <dup body>`.
  - Each brief carries its relay place.
- `scripts/review::cmd_drives`: changed.
  - `--confirm` chains each defect's briefs, each after the one before, merged with the existing `held` chaining.
  - `--dry-run` prints `{"pending": [{"defect", "story", "surface", "folded"}]}` with one entry per brief. `surface` and `folded` are present on folded entries.
- `skills/converge/prompts/drive.md`: the "Confirm" section names the defect the driver marks (the verified one) and gives the relay rules above.
- `skills/converge/prompts/fix.md`: the duplicate command adds `--field same_as=<the defect id>`.
- `skills/converge/SKILL.md`:
  - Loop 2 step 6: files one confirm driver per pending entry, chained per defect. A driver that gets the story marks the defect its brief names.
  - The end check, step 2, and the return's `fixed` list all read `review drives --confirm --dry-run`.
- `.ok-planner/review/project.md`: the `drives --confirm` description names the folded entries, the chain, and the new dry-run fields.
- Lands after the `/drive` item's move of the drive text.

**Behavior changes**
- **B106** `review drives --confirm --dry-run`.
  - Before: verified `source: drive` defects only, as `{defect, story}`.
  - After: also defects reached through folded duplicates, one entry per brief, with `surface` and `folded`.
  - Users in the release: `skills/converge/SKILL.md` steps 2 and 6 and the return.
  - Ruling: rewrite.
- **B107** `review drives --confirm`.
  - Before: one unchained driver per verified drive defect.
  - After: more drivers for folded duplicates, with each defect's drivers chained.
  - Users in the release: Loop 2 step 6 and the drain.
  - Ruling: rewrite.
- **B108** `skills/converge/prompts/fix.md` duplicates.
  - Before: no `same_as`.
  - After: `same_as` is set, so `review::cmd_fixes` groups a reopened duplicate with its target.
  - Users in the release: `cmd_fixes`.
  - Ruling: rewrite.
- **B109** `skills/converge/prompts/drive.md` confirm.
  - Before: an achieving driver always sets `confirmed`.
  - After: the relay rules above.
  - Users in the release: the confirm drivers.
  - Ruling: rewrite.

**Tested stories**
None.

### A stop meets the goal's condition, and says it is no success

**Calls**
- An owner who trues up between planning and execution may still type the old short goal line. That line is not stored state, and the boundary's "Not across: … a planning run in progress" leaves it out. Step 1 therefore drops the first-message instruction outright, with no fallback. Decided by: the work item, and the release-boundaries file.
- The new verdict lines:
  - `review`: "The run stopped at <record>. The run reached a verdict, so the goal's condition is met. The verdict is a stop, not a success: the owner takes up the reason, and the same goal line resumes the run."
  - `docs`, unrunnable branch: "…the goal's condition is met. The stop is no success: the plan no longer covers the product, so the run cannot resume; the owner sets the documentation sprint aside and plans again with /plan-docs."

  Decided by: the ruling on stopped-sprint-never-ends-goal.

**Changes**
- `scripts/review::stopped_verdict`: changed to the line above. Exit 3 is unchanged.
- `scripts/docs::stopped_verdict`: both branches changed as above. Exit 3 is unchanged.
- `skills/plan-sprint/sprint-document.md`:
  - Step 1 drops the first-message paragraph. It says the goal line carries the condition and keeps deleting a standing stop record.
  - Step 11 and step 13: `SPRINT STOPPED` meets the goal's condition while the contract stays unmet, and the same goal line resumes the run.
  - The goal rule says the same, and names the step 2 `ls` reporting a missing tool as meeting the condition.
- `skills/plan-docs/doc-sprint-document.md`:
  - Step 1 changes the same way.
  - Step 3: "That `ls` output ends the goal" becomes "That `ls` output meets the goal's condition".
  - The goal rule changes the same way.
- `skills/_sprint/shared.md` `{{CEREMONY-RUN-RULES}}`: "which ends the goal" becomes "meets the goal's condition; the stop is no success". "says how that stop ends the goal" becomes "meets". "A new `/goal`…" becomes "The same goal line resumes…".
- `skills/converge/SKILL.md`, the sprint-return paragraph (line 180): "so the goal ends until…" becomes "which meets the goal's condition; the stop is no success, and the owner takes up the reason".
- `scripts/ok-planner-CLAUDE.md` (around lines 230 to 237 and 697 to 711) and `scripts/ok-planner-cheatsheet.md` (around lines 162 to 168 and 371 to 376):
  - drop "ends the goal unmet", the first-message sentences, and "a new `/goal`";
  - say the goal is met on COMPLETE or STOPPED, and that the same goal line resumes the run.
- `admin/retired-boilerplate.json` and `admin/retired-doc-sprint-boilerplate.json`: gain the replaced released lines.
- `.ok-planner/review/project.md`: `certified`'s stop description says the line reports that the goal's condition is met and that the stop is no success.
- Builds on the start-check item for the `ls` step.

**Improvements**
- **I101** `scripts/docs::stopped_verdict` and `scripts/review::stopped_verdict`: the same stop-verdict lines are printed in two places that must change together, and this item changes both. Afterward `review` holds one `stopped_lines(word, sprint, reason, closing)`. `docs` already loads `review`, and it calls that helper with `DOCS` and its own closing sentence. No behavior change beyond B110 and B111.

**Behavior changes**
- **B110** `review certified` stop output.
  - Before: "This ends the goal…; a new /goal resumes the run."
  - After: the condition-met, no-success line.
  - Users in the release: the goal checker, which reads the `SPRINT STOPPED` token (unchanged), and sprint steps 11 and 13.
  - Ruling: rewrite.
- **B111** `docs complete` stop output. Same change. Users in the release: doc boilerplate steps 3 and 8, and the checker. Ruling: rewrite.
- **B112** Sprint boilerplate steps 1, 11, and 13 and the goal rule.
  - Across the trued-up boundary: approved sprints.
  - Ruling: migrate: the retired lines let true-up rewrite them to the carried shape (call).
- **B113** Doc-sprint boilerplate steps 1 and 3 and the goal rule.
  - Across the trued-up boundary: approved documentation sprints.
  - Ruling: migrate: through `retired-doc-sprint-boilerplate.json` (call).
- **B114** `{{CEREMONY-RUN-RULES}}` and the `/converge` sprint-return wording.
  - Users in the release: documentation sprints and sprint execution, which read the vendored copy.
  - Ruling: rewrite.

**Tested stories**
None.

### Planning hands the owner the whole goal line

**Calls**
- The sprint goal line stamps `ls .ok-planner/bin/review .ok-planner/bin/issues .ok-planner/bin/tasks`, the paths step 2 lists (see the start-check item). The documentation sprint line stamps the step 3 `ls` of tasks, issues, review, and docs. Decided by: the work item.
- A goal line from before the change (`— run each drain as a workflow`) still opts in. `drain.md` keeps "or in their own words". Decided by: drain-runs-as-a-workflow-script.

**Changes**
- `skills/_sprint/shared.md` `{{PLANNING-HANDOFF}}`: the last block hands over one goal line per kind.
  - For a sprint: the work item's line verbatim, with `<name>` and the `ls` paths stamped in.
  - For a documentation sprint: a line naming its path, "How to execute this documentation sprint", `docs complete --sprint <path>`, `DOCS COMPLETE`/`DOCS STOPPED`, the step 3 `ls`, and "Archiving, committing, and the stamps are the owner's acts, not goal terms."
  - The block tells the owner that the last sentence opts in to Workflow drains, and that leaving it out has the session drain by hand.
  - The conditional reset of `Planned against commit` stays word for word.
- `skills/plan-sprint/SKILL.md` step 14.4 and `skills/plan-docs/SKILL.md` step 7.2: the first-message sentence becomes "The goal line carries the goal's whole condition, so the executing session restates it in no message."
- `skills/_tasks/drain.md`, paragraph "Two forms": quotes the opt-in as `Run each drain as a workflow.`
- Lands after the stop item.

**Behavior changes**
- **B115** `{{PLANNING-HANDOFF}}`.
  - Before: `/goal <path> — run each drain as a workflow`.
  - After: the whole condition line.
  - Users in the release: owners at the end of `/plan-sprint` and `/plan-docs`.
  - Ruling: rewrite (call). The line is not stored, and nothing past the boundary reads it.
- **B116** `skills/_tasks/drain.md` opt-in quote.
  - Before: `— run each drain as a workflow`.
  - After: `Run each drain as a workflow.`, with own words still accepted.
  - Users in the release: sessions that drain.
  - Ruling: rewrite.

**Tested stories**
None.

### The drain fills every free slot on each return

**Calls**
- `running=<n>` is added to the end of the `run` line, after `count=`, so a reader that parses key=value pairs by position or by name keeps working. Decided by: plumbline-coding rule 7.5, and the work item's field name.
- `running` counts every task of the profile that stands `running`, pass tasks held by forks included. So when a review root and its forks hold more tasks than the drain has agents in flight, the unclaimed count comes to zero. Decided by: the work item ("counts zero where forks hold more tasks"), decision:drain-fills-every-free-slot.
- The Workflow script reads a `run` line with no `running` field as `running=0`. That counts every in-flight agent of the profile as unclaimed, so the drain starts fewer agents, never more. Decided by: decision:drain-fills-every-free-slot (no task gets two agents).
- The lifetime pause (`LIFETIME = 950`) stays a constant. It is fixed by the Workflow tool's cap of 1000, not by any deployment. Decided by: plumbline-coding rule 10.2.

**Changes**
- `scripts/tasks::instructions`: changed. Each `run` op also carries `running`: the number of tasks with `state == running` and `agent == <profile>`. `step` passes the pending tasks it already holds. Cite `# @decision: drain-fills-every-free-slot` here.
- `scripts/tasks::format_instruction`: changed. Prints `run %s model=%s effort=%s count=%d running=%d`. `next --json` carries the new key.
- `scripts/tasks::USAGE`: changed. The opening paragraph and the `tasks next` entry name `running=R`: how many of the profile's tasks agents hold.
- `skills/_tasks/drain.md`, the script:
  - `parse` reads `running`, with a missing value read as 0.
  - New `unclaimed(profile, run)` = max(0, task agents of that profile in `inFlight` − `run.running`).
  - `fill` starts `run.count − unclaimed` agents per `run` line, within the slots left.
  - `drain` calls `fill(parsed, CAP - inFlight.size)` after every return. The `returned ? Math.min(1, …)` branch goes.
- `skills/_tasks/drain.md`, the prose:
  - "The script" paragraph: drop "after that, the script starts at most one fresh agent per return" and say it fills every free slot.
  - Hand loop step 1: the line's `running=` field, and what an agent started but not yet claimed means.
  - Hand loop step 2: the `run` line reads `run <profile> model=… effort=… count=N running=R`.
  - Hand loop step 3: drop "one in for one out", "never more than one per return" and "never exceeds the first fill". Start one agent per waiting task, less that profile's unclaimed agents, up to the cap less the agents in flight.
  - The stuck check and the `paused` outcome stay as they are.
- `scripts/ok-planner-cheatsheet.md` ("The task tracker"): "starts that many agents up to its concurrency cap" becomes "starts one agent per waiting task it has not already started one for, up to its concurrency cap".
- `.ok-planner/design/decisions/drain-fills-every-free-slot.md`: new, from the sidecar. Then run `catalog-toc`.


**Behavior changes**
- **B201** `scripts/tasks::format_instruction`.
  - Before: `run <p> model=… effort=… count=N`.
  - After: the same line with ` running=R` appended. `next --json` gains `running`.
  - Users in the release: `skills/_tasks/drain.md` (both forms) and the tool's usage text.
  - Across Trued-up projects: none. The line is printed output, not the run log format, and a session draining mid-upgrade is in execution.
  - Ruling: rewrite.
- **B202** `skills/_tasks/drain.md` (fill).
  - Before: after the first fill, at most one new agent per return.
  - After: every free slot is filled on each return, net of unclaimed agents.
  - Users in the release: every caller of the drain (sprint execution, `/converge`, `/triage-issues`, `/discover-design`, `/plan-docs`, `/plan-sprint`). Each already files ready tasks with disjoint files, as the drain's step 3 says.
  - Across: none.
  - Ruling: rewrite.

**Tested stories**
- None.

### Every vendored profile names its tools, and drivers run on a drive profile

**Calls**
- Whether a `tools` list hands LSP over deferred or callable can only be settled by running an agent, which this plan cannot do. So `ok-opus` and `ok-review` also name `ToolSearch`. One instruction serves every site: "load the LSP tool once with `ToolSearch("select:LSP")`, then call it." If LSP is callable at once, the load is one extra request. If LSP is deferred and ToolSearch is missing, LSP cannot be reached at all. Decided by: the work item ("Where a tools list hands LSP over deferred, the list also names ToolSearch"); certification's drive can check which way the harness behaves.
- `tools:` and `disallowedTools:` are each written on one comma-separated frontmatter line. `scripts/tasks::read_frontmatter` and the `agent-model` hook read one-line `key: value` pairs only. Decided by: plumbline-coding rule 2 (sibling shape).
- `scripts/review drives` keeps its `--agent` flag and defaults it to `ok-drive`. No caller passes the flag, so drivers and confirm drivers both land on `ok-drive`. Decided by: the work item.
- `/drive` (`skills/drive/SKILL.md`, from the `/drive` work item) also registers `ok-drive`. Its drivers are filed through `review drives`, and `tasks file` refuses a profile the run has not registered. Decided by: the work item, and `scripts/tasks::task_records`.
- No profile file carries a design citation. `checks/materialized-standalone` refuses a live citation under `ok-planner/agents`. Decided by: that check.
- Build note: documentation-sprint checker tasks run on `ok-opus` and check claims on a stack the project's stack tool opens (`skills/plan-docs/core.md`). With the tools list they lose the session's MCP browser tools. The build confirms that no documentation check or fix prompt needs an MCP tool, and records a call where one does (B203). Decided by: the notes review.

**Changes**
- `agents/ok-opus.md`: changed. `tools: Bash, Read, Edit, Write, NotebookEdit, Grep, Glob, LSP, ToolSearch` replaces `disallowedTools: Agent`.
- `agents/ok-haiku.md`: changed. `tools: Bash, Read, Grep, Glob` replaces `disallowedTools: Agent`.
- `agents/ok-review.md`: changed. Gains `tools: Agent, Bash, Read, Grep, Glob, LSP, ToolSearch`.
- `agents/ok-drive.md`: new.
  - Frontmatter: `name: ok-drive`; `description: "ONLY dispatched by the task tracker's drain loop (…). Never selected by conversation content. The suite's drive profile: story drivers and confirm drivers, at high effort on opus, with every tool the session has but Agent and Skill."`; `disallowedTools: Agent, Skill`; `model: opus`; `effort: high`; no `tools`.
  - Body: `ok-opus`'s claim protocol with `--agent ok-drive`. The close carries no `--sites` and no build/fix sentence.
- `scripts/review` (`drives` parser): changed. `--agent` defaults to `ok-drive`.
- `skills/converge/SKILL.md` step 3: changed. Adds `tasks agent register ok-drive` in `drive` and `sprint` mode. `drive-start` stays on `ok-opus`.
- `skills/drive/SKILL.md`: changed after the `/drive` stage. Registers `ok-drive` beside `ok-opus`.
- One LSP instruction, worded the same at every site:
  - `scripts/ok-cheatsheet.md` "Prefer the LSP for symbol navigation": it binds an agent whose tools include LSP, not every subagent.
  - `scripts/hooks/subagent-batching::CONTEXT`: "Where your tools include LSP, for a symbol question … load it once with ToolSearch("select:LSP") and call it instead of grep." `ok-haiku` and `ok-test` agents read that as not theirs.
  - `skills/_sprint/shared.md`:430, `skills/plan-sprint/core.md`:311, and `skills/converge/prompts/{fix,verify,restore,hunt-file,hunt-flow}.md`.
- `scripts/ok-planner-cheatsheet.md` ("The task tracker") and `scripts/ok-planner-CLAUDE.md` (the profile list near line 571): name `ok-drive` and that it runs the drivers.
- `.ok-planner/design/decisions/profiles-name-their-tools.md`: new. Run `catalog-toc`.

**Behavior changes**
- **B203** `agents/ok-opus.md`, `ok-haiku.md`, `ok-review.md`.
  - Before: every session tool, the Skill tool and MCP tools included (only Agent denied on two profiles).
  - After: only the listed tools.
  - Users in the release: every job these profiles run (build, fix, verify, restore, hunts, merges, owner list, triage, discovery and plan-docs roles, test planners, preflight, legacy, sweep, drive-start). None of their prompts names a tool outside the lists.
  - Across Trued-up projects: profile names do not change. The contents arrive with the skills on the same true-up.
  - Ruling: rewrite.
- **B204** `scripts/review::cmd_drives`.
  - Before: drivers filed under `ok-opus`.
  - After: under `ok-drive`.
  - Users in the release: `/converge` drive and sprint mode, `/drive`, `skills/_converge/drive.md`.
  - Across: none; a ledger in flight is in execution.
  - Ruling: rewrite.
- **B205** `scripts/hooks/subagent-batching::CONTEXT`.
  - Before: tells every subagent to load LSP.
  - After: only an agent whose tools include LSP.
  - Users: every subagent, in the release.
  - Ruling: rewrite.
- **B219** `admin/true-up` vendoring of `agents/ok-drive.md`.
  - Before: no `.claude/agents/ok-drive.md`.
  - After: vendored and stamped.
  - Across trued-up projects: a project that already holds its own unstamped `.claude/agents/ok-drive.md`, which `owned()` classes as the project's.
  - Ruling: migrate: the existing collision rule archives the project's unstamped file before writing the suite's copy, under the owner's one consent (call).

**New surface**
- `ok-drive` profile, declared in `agents/ok-drive.md`: internal.

**Tested stories**
- None.

### A lean test profile runs the test stages' test-support, test, verify, and speed tasks, with the suite's rules for its role in its body

**Calls**
- The canonical `agents/ok-test.md` names each section on its own line, in this form: `<!-- lean-section: docs/plumbline-cheatsheet.md | Comments -->`, `<!-- lean-section: docs/plumbline-coding.md | 1. Enumerate before you edit -->`, `<!-- lean-section: scripts/ok-cheatsheet.md | Batch independent tool calls -->`. True-up replaces each line with that `## ` section, heading through the line before the next `## `, as `expected()` renders it for `.claude/rules/`. Decided by: decision:lean-body-copied-word-for-word.
- True-up refuses, naming the section, only where the *carried* source lacks a heading. Where the project's lint choices empty a section (for example, Comments with both comment checks off), the section is left out of the body, as it is left out of the cheatsheet. Decided by: the work item ("the lint check choices applied, so each section matches its materialized cheatsheet").
- The record is written by `materialize` right after the profile, through `write_owner` (temp file, then rename). If the record write fails, the hash check fails, and test work stops until `/ok` runs again. That is the safe direction. Decided by: plumbline-coding rule 3.1, decision:stale-lean-body-stops-test-work.
- The record is not put in `exp`. `estate_collided` would class an unstamped JSON file as the project's own copy. Its drift gets its own step in `materialize_steps`. Decided by: `admin/true-up::estate_collided`.
- The record's shape is `{"ok-test": {".claude/rules/plumbline-cheatsheet.md": "<sha256>", … all four}}`. Decided by: the work item (it names the profile, each path, each hash).
- The check is a new `tests` verb, `profiles`. It prints `lean profiles current` and exits 0. Otherwise it refuses, as the tool's other refusals do, naming each changed or missing file and saying to run `/ok`. A missing record also refuses. `tests tasks` runs the same function first for `--stage write`, `verify`, and `speed`. Decided by: the work item, decision:stale-lean-body-stops-test-work.
- The role name is `test-support`, from the rename work item. That item's stage lands first. Decided by: the work item's "Depends on".
- `review owner` classes `.ok-planner/lean-profiles.json` as `suite`. The cheatsheet's definition of a suite-owned file names it beside `package.json`. Decided by: the cheatsheet's suite-owned rule (`/ok` overwrites it on every true-up).

**Changes**
- `agents/ok-test.md`: new.
  - Frontmatter: `name`; `description` in the "ONLY dispatched by the task tracker's drain loop" form; `tools: Bash, Read, Edit, Write, Grep, Glob`; `omitClaudeMd: true`; `model: opus`; `effort: high`.
  - Body: the claim protocol with `--agent ok-test`, closing without `--sites`, then the fourteen section lines: plumbline-cheatsheet Comments, DRY and Abstraction, Uniformity, Errors, Technical Writing, Tests; plumbline-coding rules 1, 2, 4, 6, 9; ok-cheatsheet "Batch independent tool calls".
- `admin/true-up`:
  - New `LEAN_SECTION` regex and `lean_body(text, out)`. After the `render_rules` loop in `expected()`, each agent path whose source has section lines becomes `out[path] = lean_body(out[path], out)`, keyed `path`, which `checks/owned-paths` already allows. Cite `@decision: lean-body-copied-word-for-word` and `@story: write-time-prose-steering`.
  - New `LEAN_RECORD = os.path.join(ok_dir, "lean-profiles.json")` and `lean_record_text()`.
  - `materialize` writes the record after the profile.
  - `materialize_steps` adds a `missing:` or `stale:` step for the record (not destructive).
  - `ESTATE_LICENSE_PREAMBLE` names the record.
- `checks/owned-paths`: the `write_owner` allowed table gains `"LEAN_RECORD": ("materialize",)`, and the needle list gains the `LEAN_RECORD = os.path.join(ok_dir, "lean-profiles.json")` line.
- `checks/vendored-layer::PINNED`: adds `.ok-planner/lean-profiles.json`.
- `scripts/tests`:
  - New `LEAN_RECORD` and `lean_profile_failures(root)` (`@decision: stale-lean-body-stops-test-work`).
  - New verb `profiles`.
  - `cmd_tasks` runs the check before `stage_write`, `stage_verify`, and `stage_speed`.
  - `file_task` picks the profile by role: `ok-test` for `test-support`, `test`, `verify`, and `speed`; `ok-opus` for `preflight`, `legacy`, and `sweep`.
  - Usage text names `profiles`.
- `scripts/review` (`OWNER` `suite` class): adds `.ok-planner/lean-profiles.json`.
- `skills/plan-sprint/sprint-document.md`:
  - Step 2: where the run opens test stages, run `.ok-planner/bin/tests profiles`. If it refuses, stop as step 11 says, naming the files and `/ok`.
  - Step 3: register `ok-test` wherever the run opens test stages.
  - The replaced lines go into `admin/retired-boilerplate.json`.
- `skills/converge/SKILL.md` step 3: registers `ok-test` in `sprint` mode where the testing state is not `off`.
- `skills/_tasks/drain.md`, opening paragraph: a lean profile's body also carries the suite's rules for its role.
- `scripts/ok-planner-cheatsheet.md`: the profile list names `ok-test` and its four roles; the suite-owned definition names `.ok-planner/lean-profiles.json`.
- `scripts/ok-planner-CLAUDE.md`: the profile list names `ok-test` and its four roles.
- `admin/ADMINISTRATION.md`: says what true-up renders into `ok-test.md`, the record, and its refusal. Adds the record to the owned set (line 486).
- `.ok-planner/review/project.md`: the `tests` verb list gains `profiles`.
- Deltas: decisions lean-profiles-carry-their-rules, lean-body-copied-word-for-word, and stale-lean-body-stops-test-work (new); steering-over-prose-lint (amend); concept cheatsheet (amend). Run `catalog-toc`.

**Behavior changes**
- **B206** `scripts/tests::file_task`.
  - Before: every test-stage task on `ok-opus`.
  - After: test-support, test, verify, and speed tasks on `ok-test`.
  - Users in the release: the sprint-document registration and the converge registration. Both register `ok-test`, because `tasks file` refuses a profile that is not registered.
  - Across: none; a refile copies its source's profile.
  - Ruling: rewrite.
- **B207** `scripts/tests::cmd_tasks`.
  - Before: files whatever the cheatsheets hold.
  - After: refuses and files nothing where a cheatsheet differs from the record or the record is missing.
  - Users in the release: sprint execution step 4, converge 3a.2 and 5a.
  - Across Trued-up projects: the record arrives in the same true-up as the tool.
  - Ruling: rewrite.
- **B208** `skills/plan-sprint/sprint-document.md` steps 2–3.
  - Before: no check and no `ok-test` registration.
  - After: a stale record stops the run, and `ok-test` is registered.
  - Across Trued-up projects: approved sprints not yet in execution.
  - Ruling: migrate: true-up rewrites each live sprint's replaced boilerplate lines through `retired-boilerplate.json` (call).
- **B209** `admin/true-up::expected` and `materialize`.
  - Before: `ok-test.md` and the record are absent.
  - After: written, and diagnose reports either one missing or stale.
  - Users in the release: `/ok`.
  - Ruling: rewrite.
- **B210** `scripts/review` OWNER.
  - Before: the record would class as `project`.
  - After: `suite`, so `review changed` leaves it out.
  - Users in the release: converge, `review certified`.
  - Ruling: rewrite.
- **B220** `admin/true-up` vendoring of `agents/ok-test.md`.
  - Before: no `.claude/agents/ok-test.md`.
  - After: vendored and stamped.
  - Across trued-up projects: a project that already holds its own unstamped `.claude/agents/ok-test.md`, which `owned()` classes as the project's.
  - Ruling: migrate: the existing collision rule archives the project's unstamped file before writing the suite's copy, under the owner's one consent (call).

**New surface**
- `tests profiles`, declared in `scripts/tests`: internal.
- `ok-test` profile: internal.
- `.ok-planner/lean-profiles.json`: internal.

**Tested stories**
- None.

### Every suite skill's description is its guard and one sentence

**Calls**
- Proposed sentences. The guard keeps its current words:
  - converge: "Finds defects in the product by drive, analysis, sprint certification, or the intake's defect issues, then fixes and verifies each one."
  - dashboard: "Starts the project's issue dashboard, opens its page in the owner's browser, and stops it on the owner's word."
  - discover-design: "Audits the code and the design corpus and writes one discovery for /plan-sprint, asking the owner nothing."
  - ok-setup: "Turns the project's testing on, changes its settings, freezes it, or turns it off."
  - ok-version: "Shows the installed ok plugin and conduct versions beside the project's vendored stamp."
  - plan-docs: "Plans one documentation sprint that brings the project's documentation up to date with the product."
  - plan-sprint: "Plans one sprint with the owner, ending at an approved sprint whose closing step is sprint certification."
  - sketch: "Writes a single-pass design sketch to .ok-planner/sketches/, which authorizes nothing."
  - triage-issues, with its guard: "ONLY activated by explicit /triage-issues slash command, or as the step after the owner list that /converge and /drive each end with, which the session runs. Never auto-triggered by conversation content." Then: "Triages every untriaged issue in the intake and answers each person's message triage has not yet seen."
  - ok: "Updates the installed plugins and trues up this project's suite layer, asking once before any destructive step."
  - setup-dom-picker: "Sets up the dev-only DOM picker in every web frontend the project has."
  - setup-web: "Sets up a web project's agent-facing browser tooling."

  Decided by: decision:skill-descriptions-hold-the-guard-and-one-sentence, decision:slash-only-activation.
- `/drive`'s description, written by its own work item, takes the same form. This item's stage checks it after the `/drive` stage lands. Decided by: the decision ("each suite skill").
- Spot checks found each dropped fact already in its body (converge's unlimited suite defects and the veto, triage's link checks and cached prefix, setup-web's never-clobber rule, ok-setup's coverage and budget). The build checks every dropped sentence the same way and adds any it cannot find. Decided by: the work item.
- No mechanical check is added. "One short sentence naming what the verb does" is decided by judgment. Decided by: the plumbline cheatsheet's Mechanical Checks rule.

**Changes**
- `description` rewritten in `skills/{converge,dashboard,discover-design,ok-setup,ok-version,plan-docs,plan-sprint,sketch,triage-issues}/SKILL.md`, `plugins/ok/skills/ok/SKILL.md`, `plugins/ok-web/skills/{setup-dom-picker,setup-web}/SKILL.md`, and `skills/drive/SKILL.md` once it exists. Each body gains any dropped fact it lacks.
- `CLAUDE.md` (family), "How skills are wired": one sentence that the description holds the guard and one sentence.
- Deltas: skill-descriptions-hold-the-guard-and-one-sentence (new), slash-only-activation (amend). Run `catalog-toc`.

**Behavior changes**
- **B211** every suite `SKILL.md` description.
  - Before: up to 1,909 characters.
  - After: the guard plus one sentence. triage-issues names its machine caller as the step after `/converge`'s and `/drive`'s owner list.
  - Users in the release: the harness's skill listing, and the sessions that run `/triage-issues` after an owner list.
  - Across the public surface: slash commands keep their names and arguments, so the contract is unchanged.
  - Ruling: rewrite.

**Tested stories**
- None.

### The administration names an ancestor CLAUDE.md for exclusion

**Calls**
- Scope:
  - Walks from the parent of `root` up to `/`, checking for `CLAUDE.md` in each folder.
  - Reads `claudeMdExcludes` from `.claude/settings.json` through `read_settings`. An entry excludes a file when, after `~` is expanded, it equals the file's absolute path or `fnmatch`es it.
  - An unreadable settings file counts as excluding nothing.

  Decided by: the work item (it names `.claude/settings.json`), and `read_settings` as the sibling.
- Line form: `recommend: <abs path> is a CLAUDE.md above the project root, and it loads into every session and agent here; to keep it out, list it under claudeMdExcludes in .claude/settings.json`. It is printed in `diagnose` after `print_plan`, beside `lint rules:` and `NODE_MISSING`. It is not a plan note and not a step, so the exit code and the plan id stay as they are. Decided by: the work item ("changes no exit code, writes nothing, and adds no plan step").
- `/ok`'s report template in `plugins/ok/skills/ok/SKILL.md` gains the line, because `/ok` builds its report from that template. Decided by: the work item (each line goes in the report).

**Changes**
- `admin/true-up`: new `ancestor_memory_lines(settings)` (`# @decision: ancestor-claude-md-left-to-the-owner`). The `diagnose` mode prints each line.
- `admin/ADMINISTRATION.md`: states the line, and tells `/ok` to put each line in the report as a recommendation the owner may take or leave.
- `plugins/ok/skills/ok/SKILL.md` report template: `<for each recommend: line diagnose printed:> <that line verbatim>; the owner may take it or leave it.`
- `.ok-planner/design/decisions/ancestor-claude-md-left-to-the-owner.md`: new. Run `catalog-toc`.

**Behavior changes**
- **B212** `admin/true-up` (`diagnose`).
  - Before: says nothing about ancestor CLAUDE.md files.
  - After: one `recommend:` line per unexcluded one. Exit code unchanged.
  - Users in the release: `/ok`. No script parses diagnose output for this prefix (the drive greps only `placed:`).
  - Ruling: rewrite.

**Tested stories**
- None.

### Refile holds its waiters until the refile closes

**Calls**
- Sibling check on every verb that issues a task, or that changes a task's waits after it is issued:
  - `step` issues only ready tasks.
  - `retry` already takes back its waiters' issued mark (`retry_records`).
  - `file --fork-of` marks a pass task issued, and a pass task waits on nothing.
  - `task set --field after=` adds a wait to a task already issued and leaves it issued. `tests` `filed_tasks` (`op: after`) uses exactly this. It is the same gap, so it is fixed here.

  Decided by: the work item ("every sibling verb … checked"), plumbline-coding rule 8.1.
- The ids taken back are recorded as `unissued` on the refile's `TASKS.TASK.FILED` event, the field `retry`'s events carry. `task set` emits `TASKS.TASK.UNISSUED` with `task` and `waits_on`. Stdout does not change: `tests::filed_tasks` reads a refile's id as the last word of its output. Decided by: plumbline-coding rule 2 (sibling `retry_records`), rule 12.

**Changes**
- `scripts/tasks::cmd_refile`: changed. For each waiter (already `state == open`) with `issued` set and no `fork_of`, set `issued = 0` in the same `put_many`, and add `unissued` to the filed event.
- `scripts/tasks::cmd_task`: changed. Where `fields` carries `after` naming a task not closed, and the task is open, issued, and not a pass task, set `issued = 0` and emit the event in the same write.
- `scripts/tasks::USAGE` (the `refile` and `task set` entries): say both.

**Improvements**
- **I201** `scripts/tasks::next_claim` / `cmd_claim`. Cost: the only thing that keeps a task from being claimed while its waits are open is the issued mark. So every verb that adds a wait must remember to clear it (this item fixes two). Afterward: `next_claim` skips, and `cmd_claim` refuses, a task whose `after` names a task not closed, naming that task. The rule then holds in one place.

**Behavior changes**
- **B213** `scripts/tasks::cmd_refile`.
  - Before: a waiter issued before the refile stays issued and can be claimed before the refile closes.
  - After: it goes back to unissued until the refile closes.
  - Users in the release: sprint execution step 7, converge fix refiles, `tests` `filed_tasks` and `stage_speed` refiles, the drain.
  - Across Trued-up projects: the run log keeps its record shape; the event gains one field.
  - Ruling: rewrite.
- **B214** `scripts/tasks::cmd_task`.
  - Before: `task set --field after=` leaves an issued task issued.
  - After: it is taken back while the new wait is open.
  - Users in the release: `tests` `filed_tasks`.
  - Ruling: rewrite.
- **B218** (I201) `scripts/tasks::cmd_claim`.
  - Before: claims any issued task.
  - After: refuses one whose waits are open.
  - Users in the release: every profile's claim protocol.
  - Ruling: rewrite.

**Tested stories**
- None.

### Certification counts only drives that ran and reviews that forked

**Calls**
- A driver counts only where its task closed `done` with a non-empty result. A driver that closed `partial` twice leaves its story undriven, so the verdict is `SPRINT NOT COMPLETE`. Decided by: the issue's trigger, "closed other than `done`", and contract item 3.
- The review counts as run where a `review`-role task closed `done` and some task with role `pass` and prompt `sprint-pass` closed `done`. The check does not require `fork_of`, because `tasks retry` pops `fork_of` from an orphan pass task (`scripts/tasks::reset_task`), and `sprint-review.md` files pass tasks only forked from the root. Decided by: the tree.
- Build note: B117 assumes every certification ledger holds `sprint-pass` tasks, which arrived in v23.0.0. A ledger from an earlier release holds none; no unstamped archived sprint from before v23 is expected to remain. Decided by: the notes review.

**Changes**
- `scripts/review::driven_stories`: changed. It counts `drive`-role tasks whose brief starts with `story `, whose state is closed, whose outcome is `done`, and whose result is non-empty. Refiled drivers each count.
- `scripts/review::certification_failures`: changed.
  - The review check requires the pass task as above. Its message: "<ledger> holds no sprint-pass task closed done, so the find loop did not run".
  - It writes one failure per required story not driven, naming its latest driver's state (never claimed, or closed with an outcome other than `done`) or "no driver task was filed".
  - It keeps `undriven_reason` for the case where no story was driven.
- `scripts/review::cmd_certified`: the item 3 line says the review forked pass tasks that closed `done`.
- Lands with or after the `/drive` item's change to the same function.

**Behavior changes**
- **B117** `certification_failures` review check.
  - Before: any review task closed `done`.
  - After: a sprint-pass task closed `done` is also required.
  - Users in the release: sprint step 13 and the checker.
  - Across stored state: old certification ledgers. Those ledgers hold pass tasks wherever the review ran, so only a ledger with the A9 harm changes its verdict.
  - Ruling: preserve (call).
- **B118** `driven_stories`.
  - Before: a filed driver counts.
  - After: only a driver that closed `done` with a result counts.
  - Users and ruling: as B117. Ruling: preserve (call).

**Tested stories**
None.

### Documentation sprints give every fixed file a style read

**Calls**
- In the fact loop, a style task is filed only for a file a `check` item names, a fix writer changed, and no `style` task holds. It goes in after the fix writers drain and before the next checker round. Its key is `<slug>:<file>`, so a resumed run files it once. Decided by: documentation-style-read-once, one read per file.
- After such a style task:
  - Where its `style` item's verdict is `reviewed`, the next checker task checks every claim in that file, recorded with scope `file`.
  - Where the verdict is `skipped`, the checker task covers only the claims the fixers set `open`.

  Decided by: the work item ("every claim the style read changes gets checked").

**Changes**
- `skills/plan-docs/doc-sprint-document.md`:
  - Step 7 places the style step and the brief between the fix drain and the recheck.
  - Contract items 1 and 2 add the whole-file recheck of a `check` file that a style read revised.
- `skills/plan-docs/core.md` `{{DOC-CHECK-PROMPT}}`: the brief's whole-file cases include "a `check` file the style pass reviewed in the fact loop".
- `scripts/docs::complete_failures`: for each `check` item whose file's latest `style` item is `reviewed`, it requires a claim with scope `file` recorded by a `check` task filed after that style task. It compares task ids by filing order, from `run_tasks`. The existing "has no style task" failure stands.
- `admin/retired-doc-sprint-boilerplate.json`: gains the replaced released lines.

**Behavior changes**
- **B120** Doc-sprint step 7.
  - Before: a fixed `check` file gets no style task, and `docs complete` fails with "has no style task".
  - After: the style task is filed and then rechecked.
  - Across the trued-up boundary: approved documentation sprints.
  - Ruling: migrate: through the retired list (call).
- **B121** `docs complete`.
  - Before: no recheck requirement.
  - After: the whole-file recheck after a `reviewed` style task.
  - Users in the release: doc steps 8 and 9 and the checker.
  - Across stored state: runs of archived, unstamped documentation sprints. Any run that passes today has no style task on a changed `check` file, so it stays passing.
  - Ruling: preserve (call).

**Tested stories**
None.

### Documentation sprints check every reference file against the public surface

**Calls**
- Every checker task, in every round, that holds a file of a docspec whose `## Lists` names a class lists those classes and compares each such file's listing. So a fixer's edit to a listing is compared again. Decided by: the work item's "every checker task", and surface-members-listed-at-need ("its checker lists them again").
- The comparison is per file:
  - Each public element the layout places in the file must appear there. Each missing one is recorded as `missing: <element>`.
  - Each listed element must be public.

  The generator run stays with the first checker task of round 1. Decided by: the docspec shape at `docs/shapes/reference.md`.

**Changes**
- `skills/plan-docs/doc-sprint-document.md` step 7: "The first checker task of a docspec in round 1 also lists…" becomes the rule above for listings. The generator clause stays.
- `skills/plan-docs/core.md` `{{DOC-CHECK-PROMPT}}`: the listing paragraph compares each file the brief holds, for the elements its layout gives that file.
- `admin/retired-doc-sprint-boilerplate.json`: gains the replaced released lines. Shared with the style item, so the two stages are chained.

**Behavior changes**
- **B122** Checker briefs and the check prompt.
  - Before: one task lists the classes.
  - After: every task holding a reference file lists them.
  - Users in the release: the checker agents.
  - Across the trued-up boundary: approved documentation sprints, migrated through the retired list.
  - Ruling: migrate: through `retired-doc-sprint-boilerplate.json` (call).

**Tested stories**
None.

### Certification reads speed verdicts from both of a sprint's ledgers

**Calls**
- Items from the two ledgers are ordered by (ledger position, item order): the build run file first, then the certification ledger. Today `latest_verdict` and `rewrite_accepted` compare bare `task_order`, and the two ledgers reuse the same ids. Decided by: the outcome (the build-stage verdict counts, and a later certification verdict wins).
- `stage_speed` keeps counting its own refile limit per ledger, from the run it files into. Decided by: the work item names only reading verdicts.

**Changes**
- `scripts/tests`: new `speed_runs(root, sprint, run)`: `record_runs(root, sprint)` plus `run`, without duplicates, in that order.
- `scripts/tests::speed_rows`: changed. Takes `speed` items, `recorded_tests`, and `fixes` from `speed_runs`. Each item gets its ledger position for ordering.
- `scripts/tests::latest_verdict` and `rewrite_accepted`: changed. Order by (ledger position, `task_order`).
- `scripts/tests::speed_candidates`: changed. Passes the run through to `speed_rows`.
- `scripts/tests::stage_speed`: changed. `awaits_rewrite` and `speed_sent_back` read the merged items.
- `scripts/tests::cmd_slowest`: changed. Reads the certification ledger as well, through `speed_rows`.

**Behavior changes**
- **B215** `scripts/tests::stage_speed` and `cmd_slowest`.
  - Before: in certification, build-stage acceptances and product-slow verdicts are ignored, so a test is read again and a site is reported twice.
  - After: both ledgers decide what is settled.
  - Users in the release: converge 3a.2, `tests slowest`.
  - Ruling: rewrite.

**Tested stories**
- None.

### The speed ranking carries every whole-suite round at the current blob

**Calls**
- `speed_ranking` drops its `keep` parameter. `testing.slowest` keeps its one job: how many tests a speed step reads. Decided by: decision:speed-ranked-by-median-seconds.
- This item shares `speed_rows` with the item above; its stage comes after that one.

**Changes**
- `scripts/tests::speed_ranking`: changed. Each row's `seconds` holds every value `median_seconds` returns, not `values[-keep:]`.
- Callers `speed_rows` and `cmd_stamp`: changed. They drop the `testing["slowest"]` argument.

**Behavior changes**
- **B216** `scripts/tests::cmd_stamp`.
  - Before: `test-state.json` ranking rows keep only the last `testing.slowest` seconds.
  - After: every passing whole-suite second at the current blob.
  - Users in the release: `median_seconds`, the next sprint's ranking.
  - Across Stored state: `test-state.json` rows an earlier release wrote, and rows a later one writes.
  - Ruling: migrate: both shapes accepted. A row's `seconds` is a list of any length in both releases, and an earlier row's shorter list reads as it stands, with no conversion (call).

**Tested stories**
- None.

### The test plan keeps test support that kept legacy tests read

**Calls**
- `kept_uses` also yields one reader per kept legacy test file (no scenario id, test `{path, name: null}`), so `reads()` matches a `users` entry on that path. Decided by: the work item.
- A test-support legacy entry read by a kept file keeps its sort and records `kept_by`. `assembled_plan` adds its path to `plan["kept"]`, so `stray_paths` and `tests stamp`'s `kept` keep it in this sprint and later ones. `print_plan` names the reader. Decided by: `stray_paths` and `cmd_stamp` read `kept`.

**Changes**
- `scripts/tests`: changed.
  - `kept_uses`: takes the kept files.
  - `sorted_support`: counts them as readers.
  - `assembled_plan`: passes `groups["kept"]` and extends `plan["kept"]`.
  - `plan_failures`: accepts `kept_by` as users, and refuses a delete or port of a file a kept legacy test reads.
  - `print_plan`: changed.
- `skills/plan-sprint/tests-sort.md`: changed. A support entry's `users` names kept tests outside the batch too, as it already says.

**Behavior changes**
- **B33** `scripts/tests::sorted_support` and `assembled_plan`.
  - Before: test support read only by a kept legacy test was marked an orphan and deleted.
  - After: it is kept and recorded in `kept`.
  - Users: in the release, `stray_paths`, the sweep, `cmd_stamp`.
  - Ruling: rewrite.

**Tested stories**
- None.

### A sprint that plans no tests leaves untaken legacy tests alone

**Calls**
- For a sprint with no `-plan.json`, `stray_paths` keeps every test file no recorded scenario claims. That is the set the groups file's `kept` records. A sprint with no groups file gets the same set, since such a sprint retired nothing. A test file a code task adds is still caught by `review certified`'s check on staged test paths. Decided by: decision legacy-suites-sorted-automatically.
- The nothing-to-plan branch stays in SKILL §10: `## Tests` reads `Plan: none: nothing to plan`, and step 3a writes no plan. Decided by: the planning move.

**Changes**
- `scripts/tests::stray_paths`: changed, as in the calls.
- `scripts/tests::USAGE` (stray, and the no-plan paragraph): changed.
- `skills/plan-sprint/SKILL.md` §10 and the `## Tests` template: the nothing-to-plan line notes the files kept.

**Improvements**
- **I2** `scripts/tests::stray_paths`.
  - The harm: A2. `claimed` and `recorded` hold paths as test tasks wrote them, while candidates come normalized from `tree_files`. A test recorded as `./tests/x.py` reads as stray, and the sweep deletes a live test.
  - Afterward: `claimed`, `recorded` and the legacy paths are normalized with `os.path.normpath` before the comparison.

**Behavior changes**
- **B34** `scripts/tests::stray_paths`.
  - Before: a no-plan sprint listed every unclaimed legacy file, so the `on` sweep deleted them and `frozen` certification refused them.
  - After: none is listed.
  - Users: in the release, the sweep (boilerplate step 4) and `scripts/review::stray_files`. Across trued-up projects: approved no-plan sprints. The change removes only the A2 harm.
  - Ruling: rewrite.

- **B35** `scripts/tests::stray_paths` (I2).
  - Before: a non-normal claimed path made its file stray.
  - After: it is claimed.
  - Users: in the release, the sweep and `review certified`.
  - Ruling: rewrite.

**Tested stories**
- None.

### True-up asks before it rewrites an edited untracked suite file

**Calls**
- True-up carries no earlier release's text and keeps no record of what it wrote, so no "text its stamp's release wrote" exists to compare against. The plan adds a machine-local record, `.ok-planner/.cache/true-up-written.json`: `{<rel path>: {"version", "digest"}}`, written by every `materialize`. It sits beside `true-up-answers.json`, and it shares a machine with the untracked files it vouches for. Decided by: the work item's comparison, and `ANSWER_RECORD` as the sibling.
- An untracked stamped file in `differs` counts as edited, and its rewrite is destructive with an archive copy, where the record has no entry for it, the entry's version differs from the file's stamp, or the file's digest differs from the entry's. So the first true-up after this release, on a project with untracked suite files, asks once and archives each differing file. After that, the record decides. Decided by: decision:true-up-asks-once-before-destructive-steps (an edit no commit holds is not restorable). Vetoable alternative: no record, with every differing untracked file destructive on every true-up.
- `uncommitted` keeps its git-diff meaning, which its other callers (`removal_split`, `state_file_removable`, `archive_show`, `record_folder_step`) depend on. A new sibling decides the untracked case. Decided by: plumbline-coding rule 1 (callers enumerated).
- The step's `Show:` stays `archive_show([path])`, which prints `cat --` for a file git does not track. Decided by: the sibling copy step.

**Changes**
- `admin/true-up`: new `WRITTEN_RECORD = os.path.join(CACHE_DIR, "true-up-written.json")`, `written_record()`, `write_written(entries)` (mirrors `write_record`, CACHE_IGNORE included), and `untracked_edits(paths)`.
  - `untracked_edits` takes suite-stamped paths not in `tracked_files` and not `machine_local`, and compares `held_digest` with the record.
- `admin/true-up::materialize_steps`: changed. A path in `untracked_edits` gets `copy_step` and a destructive `stale: <path> differs from the carried v<version> rendering and holds an edit git does not track` step.
- `admin/true-up::materialize`: changed. After the writes, merges `{rel: {version, text_digest(exp[path])}}` for each path written into the record.
- `admin/ADMINISTRATION.md`:47: changed. An untracked stamped file that differs from what true-up last wrote, or that the record does not cover, is destructive. `.ok-planner/dashboard/` and `.ok-planner/.cache/` keep their exemption.
- `checks/owned-paths`: the `write_owner` table gains `"WRITTEN_RECORD": ("write_written",)`, plus the needle for its constant and a `write_written` region.
- `scripts/ok-planner-CLAUDE.md` (the `.cache/` paragraph): deleting the folder also drops true-up's record, so the next true-up asks before rewriting each untracked suite file that differs.

**Behavior changes**
- **B217** `admin/true-up::materialize_steps`.
  - Before: an edited untracked stamped file is rewritten with no question and no copy.
  - After: destructive, copied to the archive, and asked once.
  - Users in the release: `/ok`, and a bare true-up (which refuses on a destructive plan, as it does today).
  - Across Trued-up projects: projects whose suite files git does not track.
  - Ruling: migrate: the first true-up with no record asks once and archives a copy of each differing untracked suite file; from then on the record decides (call).

**New surface**
- `.ok-planner/.cache/true-up-written.json`: internal.

**Tested stories**
- None.

### Scripts accept SHA-256 commit names

**Calls**
- The search of `plugins/` and `checks/` finds four sites that bound a commit name: `scripts/tests:563` `SHA`, `scripts/review:82` `CLOSED_STAMP` and the assert message at `review:1703`, and the inline pattern in `scripts/discover:823`. `scripts/docs` already accepts 64 digits. `tasks` `RUN_TAG`, the `issues` digest, and the `true-up` `PLAN_ID` are not commit names. Decided by: the search.
- Build note: `docs::PLANNED_COMMIT` and `WINDOW_TREE` compile at module level before `review = load_sibling("review")`, and `tests::SHA` before its load. Building them from `review.COMMIT_HEX` (I102) means compiling them after the load. Decided by: the notes review.

**Changes**
- `scripts/review::CLOSED_STAMP`: becomes `^[0-9a-f]{7,64}$`. `with_closed_stamp`'s assert says "7 to 64".
- `scripts/tests::SHA`: becomes 7 to 64.
- `scripts/discover::cmd_assemble`: becomes 7 to 64.
- `@decision: closing-commit-baseline` at the pattern's definition.

**Improvements**
- **I102** `scripts/review`: a new `COMMIT_HEX = "[0-9a-f]{7,64}"` and `COMMIT_NAME = re.compile("^%s$" % COMMIT_HEX)`. These replace `CLOSED_STAMP`, `tests::SHA`, `docs::SHA`, and the inline `discover` pattern. `docs::PLANNED_COMMIT` and `docs::WINDOW_TREE` are built from `COMMIT_HEX`. `tests`, `docs`, and `discover` already load `review`.
  - The maintenance cost today: four copies of a value that must change together have already drifted (`docs` 64, the rest 40). Rule 6.3.
  - Afterward: one definition. No behavior change beyond B123.

**Behavior changes**
- **B123** `review::closed_stamp`/`with_closed_stamp`, `tests stamp --commit` and the conversion of the earlier state, and `discover assemble`.
  - Before: refuse or ignore 41 to 64 hex digits.
  - After: accept 7 to 64.
  - Across stored state: archived sprints' `closed:` stamps, `-base.txt` files, and `test-state.json` stamps. Every value written before stays accepted.
  - Ruling: preserve (call).

**Tested stories**
None.

### The sprint's start checks check the review script

**Calls**
- The `ls` covers `review`, `issues`, and `tasks`, the three tools `review certified` loads to check the contract. `review` alone prints `SPRINT STOPPED`, but one rule mirrors the documentation template: any missing tool means no `certified` run. Decided by: the work item ("`.ok-planner/bin/review` among them") and the sibling step 3 of the documentation template.

**Changes**
- `skills/plan-sprint/sprint-document.md` step 2:
  - It opens with `ls .ok-planner/bin/review .ok-planner/bin/issues .ok-planner/bin/tasks` and shows the output whole.
  - Where the `ls` reports a tool missing, the run writes the stop record naming each missing tool and saying that `/ok` materializes it. It stops without running `review certified`, and that `ls` output meets the goal's condition.
  - It then runs `review approved` as now. The separate tasks check is folded into the `ls`; the profiles check stays.
  - The goal rule names the `ls`, as the documentation template does.
- `admin/retired-boilerplate.json`: gains the replaced released lines.

**Behavior changes**
- **B119** Sprint step 2.
  - Before: a missing `review` script fails `review approved`, and the stop path calls the missing `certified`.
  - After: the `ls` comes first, and a missing tool is a verdict.
  - Across the trued-up boundary: approved sprints.
  - Ruling: migrate: through `retired-boilerplate.json` (call).

**Tested stories**
None.

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
   in this session. The goal also ends, unmet, when that command
   prints `SPRINT STOPPED` in this session: the run stopped, and the
   owner takes up the reason. Archiving and committing are the
   owner's acts, not goal terms." Then, where the stop record
   `<sprint-name>-stopped.txt` stands beside this file, delete it
   before the run goes on, so this goal takes the run up again.

2. Check that the run can start, then record the base. Every check
   here runs before the base is written; where one stops the run,
   stop it as step 11 says, with its message as the reason. First
   run `.ok-planner/bin/review approved --sprint <this sprint's
   path>`. Where it refuses, stop: this file may be a draft the owner
   never approved, or the review estate lacks the
   `.ok-planner/review/config.json` the command reads. Then check the
   task tracker at `.ok-planner/bin/tasks` and the profiles under
   `.claude/agents/`: a missing one is the front door's
   administration (`/ok`) to materialize, so stop and say so. Then,
   where `<sprint-name>-plan.json` stands beside this file, or
   `testing.enabled` in `.ok-planner/config.json` is `on`, the run
   opens its test stages (step 3), and `.ok-planner/bin/tests` is
   required too: where it is missing, stop and say so.
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
   a sprint with `<sprint-name>-plan.json` beside it plans tests, and
   under `testing.enabled` `on` the run opens them whether or not the
   sprint plans tests, for step 4's speed read. For each role and
   its template, `preflight` from `test-preflight`, `support` from
   `test-support`, `test` from `test-write`, `legacy` from
   `test-legacy`, `sweep` from `test-sweep`, `verify` from
   `test-verify`, and `speed` from `test-speed`, write the prompt with
   `.ok-planner/bin/review prompt --name <template> --sprint <this
   sprint's path> --out .ok-planner/sprints/<sprint-name>-<role>.md`,
   then `tasks prompt register <role> <that path>`. Declare the test
   pools: `tasks config set item_states '{"tests": ["open",
   "accepted", "sent-back"], "support": ["open", "made"], "ports":
   ["open"], "promises": ["open", "held", "rejected"], "speed":
   ["accepted", "sent-back", "product-slow"]}'`, and the fields their
   readers take as numbers: `tasks config set field_types '{"tests":
   {"silence": "integer"}, "speed": {"seconds": "number", "rank":
   "integer"}}'`. Select the test stages' calls for the completion
   report's `## Calls` beside the build's: `tasks config set calls
   '[{"pool": "divergences"}, {"pool": "calls"}]'`.

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
   Where the run opened test stages, file them after the build tasks.
   They are not build tasks, and they change no product code. Run
   `.ok-planner/bin/tests tasks --sprint <this sprint's path> --stage
   write --after <the latest build task of each code stage whose files
   a planned scenario's entry or support reaches>`. Where no code
   stage's files hold one, run it with no `--after`, and the test
   stages run beside the code stages. Every `--stage write` takes the
   same `--after`: the stage follows each task it names to that
   task's latest refile, so a code stage refiled under step 7 needs no
   new `--after`. Where the plan's budget names a test stack, the
   stage files the preflight task alone first, and files the rest
   once it closed `done`: one support task per support file the
   scenarios name and per open `support` item, one test task per
   scenario the plan writes, rewrites, or retires, each after the
   support tasks for its files, and one legacy task per legacy file.
   Drain with step 7's loop. After each drain, run `tests tasks
   --sprint <this sprint's path> --stage verify`, which files one
   verify task per test or promise a test task recorded that awaits
   its verifier, and drain. The next `--stage write` files again each
   test a verifier sent back, with the reason, and each test task
   that closed `blocked` having filed a `support` item, after the
   support task that makes it. Repeat `--stage write`, `--stage
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
   work item some build task's `--cites` already names; file a stage
   only for a work item no filed task cites. The test-stage verbs run
   again from `--stage write`, with the same `--after`, and each
   files only what the run lacks.

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
   `support` item. The write stage's refusals are genuine blockers
   under step 11: where `--stage write` refuses because the preflight
   closed `blocked` twice, a `support` item records a change other
   than `missing`, `changed`, `fixture`, or `seed`, a support task
   closed `done` and left its `support` item open, a scenario's last
   two test tasks closed `blocked` and neither filed a `support` item,
   or a task it would file or refile waits on a task that, followed
   to its latest refile, closed other than `done`, surface its
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
    3's `calls` setting selects.

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
    prints `SPRINT STOPPED` with the reason, which ends the goal. A
    new `/goal` on this file resumes the run from its base and its
    task record. Ambiguity is not a blocker: the builder makes the most
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
    failure to the owner and stop the run as step 11 says, with each
    failure a line of the stop record, without offering the archive:
    it is a genuine blocker under step 11. Where it printed `SPRINT
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
   plan, and the delta sidecar. `ls -d
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
   listed for the owner. Where the project has a story, the run's
   drive ran: drive commands unfilled or refused, or a stack that
   failed to start, mean it did not. Where `testing.enabled` in
   `.ok-planner/config.json` is `on` or `frozen`, the run's suite ran
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
reason and checks nothing else: that line ends the goal while the
contract stays unmet, and the owner takes up the reason. Under `testing.enabled` `on` or `frozen`, it checks item
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
