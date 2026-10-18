---
name: plan-tests
description: "ONLY activated by explicit /plan-tests slash command. Never auto-triggered by conversation content. ok-planner's test planning session. It reads what changed since the last test sprint's stamp, runs the suite once, and has planners name each scenario a story or a runtime part gives the executable code, sort every test against them, and sort a legacy suite into tests to adopt, port, or delete. The owner answers each scenario whose outcome changed and each program no story serves, then approves the plan once. The session ends at one approved test sprint, which runs unattended under /goal: test tasks write the tests, then a loop runs the suite and fixes the code until every test passes or waits on a promise change."
---

# Test planning

`/plan-tests` is ok-planner's test planning session: an interactive session with the project owner that produces a **test sprint**. A test sprint is a plan to bring the project's tests in line with what its stories promise: one test per scenario, each scenario a way a story gives its benefit that executable code carries, or a runtime failure the product must survive. Its execution writes, rewrites, and deletes tests, ports legacy tests that enforce a written rule into project checks, and fixes the code for each failing test. Only a test sprint changes a test.

The owner starts it on their own schedule. A test sprint changes no corpus artifact, docspec, or surface intent: a scenario whose fix needs a commitment changed goes to the next `/plan-sprint` as an issue.

The machinery lives beside this body. `core.md` holds the scenario definition, the runtime classes, the planning prompts, and the run prompts. `test-sprint-document.md` holds the test sprint's template. `.claude/skills/_sprint/shared.md` holds the run rules and the archive step the test sprint follows. A `{{TOKEN}}` names the block of that name in one of these files, and resolves only where the token stands alone on its line.

## 1. Layout

`mkdir -p .ok-planner/test-sprints .ok-planner/history/test-sprints`. Estate true-up is the front door's administration (`/ok`).

`.ok-planner/bin/tests`, `.ok-planner/bin/tasks`, `.ok-planner/bin/plumbline`, `.ok-planner/bin/issues`, and the profile `ok-opus` under `.claude/agents/` are required: where one is missing, say that `/ok` materializes it, and stop.

A test sprint under `.ok-planner/test-sprints/` that is not archived is still open: name it, say that it runs with `/goal <its path>` or that the owner archives it first, and stop. One plan stands at a time.

Name the test sprint `YYYY-MM-DD-<slug>`, from `date +%Y-%m-%d` and a slug for what this plan covers, such as `tests` or `legacy-suite`. Every file this session writes sits under `.ok-planner/test-sprints/` and starts with that name.

## 2. The runner

Where `.ok-planner/config.json` declares no `testing.run`, read how the project runs its tests today: its package manifests, its build files, its CI configuration. Propose to the owner, in one prose question, the command that runs one test, with `{path}` where the test's file goes and `{name}` where the runner needs a test's name inside its file, such as `python3 -m pytest {path}::{name}`, or for Go, whose tests run per package, `go test "./$(dirname {path})" -run '^{name}$'`. Where the project has no tests and no runner, propose one that fits its language. On the owner's answer, run `.ok-planner/bin/tests declare --run "<the command>"`.

## 3. Window

Run `.ok-planner/bin/tests window --json`. It names the stamp, the status, the files changed since the stamp, the sprints closed since it, the stories changed, the scenarios whose story is gone, the claimed tests a person edited, and the test files no scenario claims. A status of `new` means no stamp: every story is planned from the start, and every test file is a legacy test. Where the status is `current`, say that the tests stand where the last test sprint left them, and stop.

Tell the owner the counts in one line ("12 scenarios recorded; 40 files changed since the stamp; 3 stories changed; 280 legacy test files to sort"). Record the commit: `git rev-parse HEAD`.

## 4. Run the suite once

Where the stamp recorded tests, run them all: `.ok-planner/bin/tests run --json`, and write the output to `.ok-planner/test-sprints/<name>-planning-results.json`. The planners read each test's pass or failure there.

## 5. Plan

Open the planning run: `tasks init <name>-planning --file .ok-planner/test-sprints/<name>-planning.jsonl`, and `tasks agent register ok-opus`. For each of `{{TEST-STORY-PLANNER-PROMPT}}` as `story`, `{{TEST-RUNTIME-PLANNER-PROMPT}}` as `runtime`, `{{TEST-SORT-PROMPT}}` as `sort`, and `{{TEST-PLAN-REVIEW-PROMPT}}` as `review`, in `core.md`, write the block, its transclusions resolved and `[TEST SPRINT PATH]` filled with `.ok-planner/test-sprints/<name>.md`, to `.ok-planner/test-sprints/<name>-planning-<role>.md`, and register it: `tasks prompt register <role> <that path>`. Declare the pools: `tasks config set item_states '{"scenarios": ["open"], "questions": ["open", "answered"], "legacy": ["open"], "calls": ["open"], "review": ["open", "resolved"]}'`.

1. **The planners.** File one story task per story under `.ok-planner/design/stories/`: `tasks file --role story --prompt story --agent ok-opus --key <slug> --brief "story <slug>; the last run is at <the results path, or none>"`. File one runtime task: `tasks file --role runtime --prompt runtime --agent ok-opus --key runtime --brief "the last run is at <the results path, or none>"`. Drain with the drain loop at `.claude/skills/_tasks/drain.md`.
2. **The sort.** Where the window lists test files no scenario claims, file one sort task per ten of them, in path order: `tasks file --role sort --prompt sort --agent ok-opus --key sort:<n> --brief "files: <the paths>"`. Where `testing.run` holds `{name}`, add each claimed test file the window lists as edited, marked `claimed` in the brief, so a sort agent finds each test in it no scenario names. Drain.

A task that closes `partial` is refiled whole with `tasks refile <task>`: the latest done task of each planner stands, and its items replace the earlier task's.

## 6. The owner's answers

List the questions no answer settles yet: `.ok-planner/bin/tests plan --sprint .ok-planner/test-sprints/<name>.md --from-run .ok-planner/test-sprints/<name>-planning.jsonl --questions`. An answer stands for its scenario or program, so a refiled planner that raises the same question again is not asked twice. Ask the owner each one, one per turn, in prose, with the scenario or the program, what changed, and the answers that apply:

- **A scenario whose outcome changed, or whose code is gone.** Name the commit and what it changed for the user. The owner picks one: *retire* the test; *rewrite* it to the new behavior, with the outcome the owner states; or *file an issue* so a sprint restores the old behavior, and the test stays failing until it does. For an issue, file it with `.ok-planner/bin/issues file --from -` per the `{{ISSUE-FILE-FORMAT}}` block of `skills/_shared/artifact-definitions.md`, kind `human`, category `product-intent`, the change as its `problem`.
- **A program no story serves.** Say what it does. The owner picks one: *file an issue* that asks `/plan-sprint` for the story it serves, filed the same way; or *no guard*, with the reason, so later plans do not ask again.

Record each answer on its question: `tasks item set <question> --state answered --field answer=<retire | rewrite | issue | no-guard> --field said="<the owner's words>" [--field text="<the new outcome, for a rewrite>"] [--field issue=<the issue id>] [--field reason="<the reason, for no guard>"]`.

## 7. Assemble

 Run `.ok-planner/bin/tests plan --sprint .ok-planner/test-sprints/<name>.md --from-run .ok-planner/test-sprints/<name>-planning.jsonl`. It writes the plan beside the test sprint, `-plan.json` in place of `.md`, and prints the counts. It retires each scenario whose story is gone, adopts a legacy test in place of a new one where a sort agent adopted it, and keeps the first of two legacy tests adopted into one scenario, sorting the second as a duplicate. Where it refuses, it names each failure: refile the planner whose items fail with `tasks refile <its task> --brief "<its brief, and the failure>"`, drain, and assemble again. Ask any question the refiled planner raises, as step 6 does.

## 8. Draft

Write the test sprint to `.ok-planner/test-sprints/<name>.md` from `{{TEST-SPRINT-DOCUMENT-TEMPLATE}}` in `test-sprint-document.md`: the window, the owner's answers, and the counts the last assembly printed. Copy the boilerplate verbatim.

## 9. Review

File one review task: `tasks file --role review --prompt review --agent ok-opus --key review --brief "review the plan"`, and drain. For each finding, refile the planner its site names, as step 7 does, with the finding added to its brief, drain, mark the finding `resolved` with `tasks item set <finding> --state resolved`, assemble again, and write the new counts into the test sprint.

## 10. Approval

Present the test sprint for approval, with the output of `.ok-planner/bin/tests plan --sprint <its path> --show`: every scenario with its action, every legacy test with its sort, and every call a planner made. It is not final until the owner approves. A change the owner asks for refiles the planner it touches, then assembles again, as step 7 does.

## 11. Terminal

Hand the owner the line that starts execution under the native `goal` mechanism, with this test sprint's filename stamped in, whole:

    /goal .ok-planner/test-sprints/<name>.md

The executing session states the goal's stop condition in its first message, as the test sprint's boilerplate says.

Then stop. The session writes only the test sprint, the files beside it that start with its name, `testing.run` through `.ok-planner/bin/tests declare`, and the issues it files through `.ok-planner/bin/issues`.
