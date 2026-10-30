---
closed: 565443f73067a3c02709bb57b1759a7b43ebe967
---

# Sprint: Fifth intake drain

## Intent

This sprint drains the intake. It carries no single theme: it lands every open issue but one, through the corpus deltas and the work items below. Most of the work reshapes `/plan-tests` after its first run on a large project; the rest touches documentation planning, the front door, the lint's edit hook, `/converge`, the intake, the drain loop, and the defects the last runs left.

Promoted issues:

- `plan-tests-rejects-a-malformed-scenario-id-only-at-assembly`
- `plan-tests-fixes-a-finding-by-rebuilding-the-planner`
- `plan-tests-reviews-a-whole-plan-with-one-agent`
- `plan-tests-caps-each-story-way-at-one-scenario-per-program`
- `task-tracker-cannot-drop-an-item`
- `plan-tests-approval-shows-the-whole-plan-unsorted`
- `dom-picker-reference-carries-prose-comments`
- `closed-stamp-frontmatter-parse-copied`
- `fix-task-closed-done-leaves-defect-fixing`
- `doc-edit-rules-ignore-reader-and-covers`
- `lint-passes-python-docstrings-anywhere`
- `issues-show-hides-edited-and-withdrawn-marks`
- `docs-complete-passes-with-no-claim-checked`
- `doc-planner-output-names-wrong-reshape-step`
- `surface-corpus-skips-subjects-and-practices`
- `sign-off-review-raises-settled-findings-again`
- `sprint-close-commit-omits-discovery-move`
- `review-stories-refuses-missing-stories-folder`
- `failed-drive-start-tears-down-another-runs-stack`
- `port-lease-hangs-on-hung-docker`
- `docs-window-skips-class-with-no-declaring-line`
- `test-sort-decides-fixtures-before-adoptions`
- `file-level-runner-sorts-legacy-files-whole`
- `test-sprint-veto-of-deletion-has-no-effect`
- `first-comment-does-not-seed-read-ledger`
- `doc-sprint-veto-filed-without-ruling`
- `test-sprint-veto-filed-without-ruling`
- `ok-version-reports-installed-not-loaded-version`
- `tests-window-ignores-declared-folders`
- `edit-hook-skips-bash-and-notebook-edits`
- `retired-docspec-leaves-documentation-behind`
- `ok-outcome-after-declined-second-plan`
- `discovery-question-on-proposed-artifact-drafts-nothing`
- `confirm-drive-per-defect-or-per-story`
- `delta-body-inner-fence-breaks-certification`
- `issue-shape-gives-judgment-issues-a-bug-lead`
- `dashboard-skill-places-no-missing-build`
- `true-up-moves-document-types-without-converting`
- `plan-tests-cannot-widen-an-approved-plan`
- `drain-loop-wakes-the-session-on-every-agent-return`
- `test-write-tasks-chain-on-shared-support-files`
- `plan-tests-asks-the-owner-after-the-planners-run`
- `plan-tests-declares-the-runner-before-planning`
- `plan-tests-offers-retire-on-a-first-plan`
- `plan-tests-files-one-planner-per-story`
- `sprint-build-prompt-has-no-assembly-command`

## Corpus deltas

### Amend story: edit-time-lint-enforcement

body: in the sidecar

### Amend story: see-governing-versions

body: in the sidecar

### Amend decision: corpus-audit-hands-a-discovery-to-planning

body: in the sidecar

### Amend decision: docspec-stamp-opens-the-window

body: in the sidecar

### Amend decision: documentation-claim-ledger

body: in the sidecar

### Amend decision: documentation-edits-only-where-a-rule-fires

body: in the sidecar

### New decision: drain-runs-as-a-workflow-script

body: in the sidecar

### Amend decision: drive-tries-each-story-as-a-user

body: in the sidecar

### New decision: dropped-items-stay-in-the-record

body: in the sidecar

### Amend decision: edit-hook-blocks-in-turn

body: in the sidecar

### Amend decision: issues-read-cold-before-the-owner

body: in the sidecar

### Amend decision: no-execution-engine

body: in the sidecar

### Amend decision: pinned-build-placed-at-true-up

body: in the sidecar

### Amend decision: scenario-list-decided-once

body: in the sidecar

### New decision: test-support-written-before-tests

body: in the sidecar

### Amend decision: task-tools-mirror-the-report

body: in the sidecar

### Amend decision: team-execution-cold-gate

body: in the sidecar

### Amend decision: tests-check-scenarios

body: in the sidecar

### Amend decision: true-up-asks-once-before-destructive-steps

body: in the sidecar

### Amend decision: whole-file-ownership

body: in the sidecar

## Work items

### A scenario checks one distinct outcome a program shows

Issues: plan-tests-caps-each-story-way-at-one-scenario-per-program
Makes true: decision:tests-check-scenarios

The scenario rules in `plugins/ok/families/ok-planner/skills/plan-tests/core.md` state the amended decision. In `{{TEST-SCENARIO-DEFINITION}}`, case 1 and the cap paragraph say: each distinct outcome a user or the product sees through a program, for any plausible way the story's implementation gives or refuses its benefit, is its own scenario. Two outcomes are distinct when the user sees a different result: a different reply, a different refusal, or a different state left behind. A second scenario that checks an outcome another scenario checks is a duplicate. Each runtime pairing of part, class, and harm still yields one scenario. In `{{TEST-STORY-PLANNER-PROMPT}}`, Read step 5 has the planner find each way the implementation gives or refuses the benefit, the table row for `new` reads "Code shows an outcome of the story that no scenario checks", and a new scenario is named `<story slug>--<a short slug for the outcome>`. In `{{TEST-SORT-PROMPT}}`, the second `adopt` row reads "It checks an outcome of a story that no scenario checks, and code carries it."

Every text that restates the scenario definition says the same: the intro of `skills/plan-tests/SKILL.md`, "The tests" in `scripts/ok-planner-CLAUDE.md`, "Tests" in `scripts/ok-planner-cheatsheet.md`, the Tests section of `docs/plumbline-cheatsheet.md`, and the Tests paragraph of the family's `CLAUDE.md`. The review's check of this rule is the work item "/plan-tests reviews each planner task, then the whole plan".

### /plan-tests settles the time limit with the run command and checks the plan against both

Issues: plan-tests-declares-the-runner-before-planning
Makes true: decision:scenario-list-decided-once, decision:test-loop-fixes-code-never-tests

Step 2 of `skills/plan-tests/SKILL.md` asks the owner, in the same prose question that proposes the command that runs one test, for the time limit of one test in seconds, and runs `.ok-planner/bin/tests declare --run "<the command>" --timeout <seconds>`. Where `testing.run` is declared and `testing.timeout` is not, step 2 asks for the limit alone. The project keeps one run command. The story planner and runtime planner prompts in `core.md` read `testing.run` and `testing.timeout` (600 seconds where absent) from `.ok-planner/config.json`, and plan each test in a form the command runs within the limit where one exists. Each `new` and `rewrite` scenario records the kind of test it is (`--field kind=<such as unit, cli, browser, stack>`) and the setup it needs before it runs (`--field setup="<such as a scratch folder, a running stack, a browser>"`), and `tests plan` in `scripts/tests` refuses such a scenario with no kind or no setup, naming it.

After the last assembly and before approval, a new step of `SKILL.md` compares each planned test's kind and setup with the command and the limit. For any test they cannot run, it asks the owner, one question per turn, to change the command or the limit, and runs `tests declare` again on a change. Where the owner changes neither, the session re-plans that test's story so the test reaches the code in a form the command runs, and the planner records a call of kind `untested` for each outcome no such form reaches. The test sprint's unattended run then never meets a runner question.

Depends on: Planners tag each call with its kind, and approval leads with a sorted summary

### /plan-tests takes the owner's scope and program answers before any planner runs

Issues: plan-tests-asks-the-owner-after-the-planners-run
Makes true: decision:scenario-list-decided-once, decision:tests-check-scenarios

`skills/plan-tests/SKILL.md` opens the planning run before planning and gains a step, after the suite runs once, that settles the owner's inputs. First it asks the owner, in one prose question, which part of the project the plan covers, and records the answer in the planning run as one item: `tasks item add --pool scope --key scope --field 'paths=["<path or glob>", ...]' --field said="<the owner's words>"`. Then it files one programs task under a new `{{TEST-PROGRAMS-PROMPT}}` in `core.md`, role `programs`. That pass lists each executable entry point inside the scope and the stories each serves, and files one `unguarded` question per entry point no story serves and the stamp does not record as unguarded. The session drains it, asks each program question one per turn (an issue asking `/plan-sprint` for the story it serves, or no guard with the reason), and records each answer as step 6 records answers now. Every planner's brief then carries the scope, in the owner's words and as its paths, and each program answer. The runtime planner no longer finds unserved programs: `{{TEST-RUNTIME-PLANNER-PROMPT}}` loses that part of its title, Read step 6, Plan step 2, the unguarded record, and the unguarded count in its close result.

Planners plan no scenario outside the scope or for a program the owner left unguarded. Each `new` and `rewrite` scenario records the program its test reaches (`--field entry=<path>`). `tests plan` in `scripts/tests` counts `programs` among the planning roles, refuses to assemble a run with no scope item, and refuses, naming each, a scenario whose test path, support files, or entry lie outside the scope's paths, and a scenario whose entry is a program the stamp records as unguarded or a no-guard answer of this run names. Step 6 keeps only the questions about a scenario whose outcome changed or whose code is gone, after planning. The Owner answers section of the template in `skills/plan-tests/test-sprint-document.md` records the scope in the owner's words.

### /plan-tests groups stories into planner tasks and, after the first plan, plans only the stories a run touches

Issues: plan-tests-files-one-planner-per-story
Makes true: decision:scenario-list-decided-once

`scripts/tests` gains a verb that writes the planning groups beside the test sprint (`-groups.json` in place of `.md`) and prints them. Where the window's status is `new`, every story is touched. Otherwise a story is touched where its file changed since the stamp, where a `@story:` annotation citing it sits in a file changed since the stamp, or where its recorded test failed in the planning run's results file. The groups file records each touched story with its reasons. Stories cited from a common file join one group, up to a set size; a group over the size splits in catalog order. Touched stories no file cites are batched by count in catalog order, at the same size. Step 5 of `skills/plan-tests/SKILL.md` files one story task per group, keyed `group:<n>`, its brief naming the group's stories, the last run's path, the scope, and the program answers. `{{TEST-STORY-PLANNER-PROMPT}}` in `core.md` plans every story its brief names. Per story it plans, it records one item in a `stories` pool (`--key <slug> --field story=<slug>`), and each call it records names its story (`--field story=<slug>`). The session declares the `stories` and `scope` pools in `item_states`. `{{TEST-SORT-PROMPT}}` also reads the recorded list (`tests scenarios --json`), since an untouched story's scenarios are not items in the run.

An assembly failure or a review finding on one story re-plans that story alone, in a task keyed `story:<slug>` whose brief names that story only, in the form the work item for plan-tests-fixes-a-finding-by-rebuilding-the-planner sets: the session's edit step for a mechanical fix, with a dropped item removed through the tracker's drop verb under decision:dropped-items-stay-in-the-record, and the revision refile for a fix that needs judgment. The groups apply to that item's edits of step 5 and the planner prompts, which this item builds on. `tests plan` takes each story's scenarios, questions, and calls from the latest done task that holds a `stories` item for it, and drops that story's items from earlier tasks. It keeps each recorded scenario of a story the groups file does not list, as `keep` with the ruling "the rules: its story was not touched". It refuses a touched story no done task holds a `stories` item for, naming it, and refuses a recorded scenario the plan says nothing of only where its story was planned. The plan records the stories its planners planned. "The tests" in `scripts/ok-planner-CLAUDE.md` names planners for groups of stories in place of a planner per story.

Depends on: /plan-tests takes the owner's scope and program answers before any planner runs

### /plan-tests widens the stories the owner names, on any run

Issues: plan-tests-cannot-widen-an-approved-plan
Makes true: decision:scenario-list-decided-once, decision:tests-check-scenarios, decision:records-stay-out-of-context

The owner starts a widen run with `/plan-tests widen <story slug> ...`, naming stories, or `/plan-tests widen`, for every story an earlier plan's calls left a path out of. It runs on any run, one where nothing changed included: step 3 of `skills/plan-tests/SKILL.md` goes on to plan a widen run where the window's status is `current`, and where the owner asked for none, its stop line names the widen run. `skills/plan-tests/SKILL.md` names the earlier plans under `.ok-planner/history/test-sprints/` as records it reads. `scripts/tests` lists, for a story, the calls that the latest archived plan to plan it recorded for it. A plan that records no planned stories planned every story. A call belongs to a story by its `story` field, else by a site or key that is the story's slug or a scenario id starting `<slug>--`. A call that left a path out is one of kind `untested`; in a plan whose calls carry no kind, every call of the story counts.

The groups file lists each widened story as touched, with the reason `widen`. Its planner reads the story's recorded scenarios and those earlier calls, and adds the scenarios the code supports, within the bound the amended decision:tests-check-scenarios sets: one scenario per distinct outcome, and no duplicate. For a story whose only reason is `widen`, the planner records `new` and `gap` items and its `stories` item, and `tests plan` keeps every recorded scenario of it that the planner names nowhere, as recorded. A story the window also touched gets the whole sort and the widening together. Every other scenario stands as recorded. The widen run's test sprint files its write tasks through `tests tasks --stage write`, as any test sprint does, and its new scenarios get support tasks the same way, under decision:test-support-written-before-tests.

Depends on: /plan-tests groups stories into planner tasks and, after the first plan, plans only the stories a run touches

### /plan-tests reviews each planner task, then the whole plan

Issues: plan-tests-reviews-a-whole-plan-with-one-agent
Makes true: decision:tests-check-scenarios, decision:scenario-list-decided-once

Step 9 of `skills/plan-tests/SKILL.md` files one review task per planner task (each story group, each one-story re-plan, the runtime task, and each sort batch), keyed `review:<planner task>`, and one plan-wide review task, keyed `review:plan`. `{{TEST-PLAN-REVIEW-PROMPT}}` in `core.md` splits into a planner review prompt and a plan-wide review prompt. A planner review reads its task's items and the stories its brief names, and checks the following. Each scenario checks one distinct outcome a program shows for a plausible way the story's implementation gives or refuses its benefit, or a runtime pairing of part, class, and harm. No two of the task's scenarios check one outcome. Each distinct outcome the code shows has a scenario or a call of kind `untested`. Each scenario's text states an outcome. Each `new` and `rewrite` reaches the code through a public entry point and names its kind, setup, and entry. Each runtime one causes its condition from outside the product. Each `port` names a written rule, and each `adopt` names a scenario whose text the test checks. The plan-wide review prints `tests plan --show` and reads the test sprint. It checks that no two scenarios across planners check one outcome, and that every owner answer holds in the plan as the owner gave it: the scope, each program answer, and each scenario answer.

Each finding names its site and the planner task it refiles. The session applies it in the form the work item for plan-tests-fixes-a-finding-by-rebuilding-the-planner sets, re-planning one story alone where a re-plan is needed, then marks the finding `resolved`, assembles again, and writes the new counts into the test sprint. The family's `CLAUDE.md` line for `skills/plan-tests/` names the programs prompt and both review prompts.

Depends on: A scenario checks one distinct outcome a program shows; /plan-tests groups stories into planner tasks and, after the first plan, plans only the stories a run touches

### Planners tag each call with its kind, and approval leads with a sorted summary

Issues: plan-tests-approval-shows-the-whole-plan-unsorted
Makes true: decision:scenario-list-decided-once, decision:legacy-suites-sorted-automatically

`{{TEST-CALL-RULE}}` in `skills/plan-tests/core.md` adds `--field kind=<untested | departure | scope | mechanics>` and defines each kind. `untested`: the call leaves a behavior untested. `departure`: it departs from an owner answer. `scope`: it reads the plan's scope or what a story covers. `mechanics`: it says how a test reaches the code or sets up, or how a legacy test was sorted. A call about one story also names it (`--field story=<slug>`). `tests plan` in `scripts/tests` refuses a planning call with no kind or a kind outside the four, naming it.

`tests plan --show` leads with a summary: the count of scenarios per story by action, then every `untested` and `departure` call in full, with its site, choice, and whole body, then the other calls grouped by kind, one line each, then each kind and setup pair of planned tests with its count, then the whole listing as it prints now. Step 10 of `skills/plan-tests/SKILL.md` presents that output, and the owner still approves the whole plan once.

### The task tracker drops an item and keeps it in the record

Issues: task-tracker-cannot-drop-an-item, plan-tests-fixes-a-finding-by-rebuilding-the-planner
Makes true: decision:dropped-items-stay-in-the-record, concept:task-tracker, decision:no-execution-engine

`plugins/ok/families/ok-planner/scripts/tasks` gains `tasks item drop <item> --by <who> --reason "<why>"`. The drop requires both `--by` and `--reason` and refuses an empty one. It refuses an unknown item. It refuses an item already dropped, and names who dropped it and why. A drop appends one `TASKS.ITEM.DROPPED` event naming the item, its pool, its key, its task, who dropped it, and why, and marks the item's record dropped with who, why, and when. The run file keeps the lines that filed the item. A rebuild of the index from the run file reproduces every drop, and a run file written before this change reads as it did.

Every read the tracker serves leaves a dropped item out: `item list`, `item count`, the items a claim hands its agent, the items `batch` selects, `report`, `render`, `calls`, and `round show`. `item set` refuses a dropped item, naming the drop. `dump` and `snapshot` copy the record whole, so they keep the item with its drop mark and the removal event. `item set` also gains `--body`, which replaces an item's body; /plan-tests uses it to fix a scenario's wording in place. `tasks --help` lists both. The estate guide's task tracker section in `plugins/ok/families/ok-planner/scripts/ok-planner-CLAUDE.md` adds one sentence beside "Never hand-edit a run file": an orchestrator that must remove an item drops it with `tasks item drop`.

### /plan-tests fixes a planner's items in place, or has the planner revise only what a fix names

Issues: plan-tests-fixes-a-finding-by-rebuilding-the-planner, plan-tests-rejects-a-malformed-scenario-id-only-at-assembly
Makes true: decision:scenario-list-decided-once, decision:no-execution-engine

`plugins/ok/families/ok-planner/skills/plan-tests/SKILL.md` gives one rule for every fix to a planner's items: an assembly failure (step 7), a review finding (step 9), and a change the owner asks for at approval (step 10). A fix is mechanical when the failure, the finding, or the owner's words name the whole change: a rename, a drop, a fold of named scenarios into one, or a wording fix whose new words they give. The session applies a mechanical fix itself with the tracker's verbs on the planner's items, and the items stay under the planner's task. A rename sets the item's `id` field, and sets the same id in every question and legacy item that names the old one. A drop runs `tasks item drop <item> --by plan-tests --reason "<the failure or finding>"`, and drops each question on the dropped scenario, so the dropped item leaves the plan. A fold drops every folded item but the one it keeps, and sets the kept item's body to the folded outcome. A wording fix sets the item's body with `tasks item set <item> --body`. Every other fix needs the planner's judgment and goes back as a revision refile: `tasks refile <its task> --brief "<its brief>; revise task <its task>: <each failure or finding that names it>"`. One revision refile per planner carries every judgment fix that names it. After the fixes, the session assembles again. A finding is marked `resolved` once its fix is applied, by either path. Step 5's rule stands for a planner task that closes `partial`: it is refiled whole, and its items replace the earlier task's.

`plugins/ok/families/ok-planner/skills/plan-tests/core.md` gains one revision block that the story planner, runtime planner, and sort prompts each transclude. Where a brief says `revise task <id>`, the agent reads every item that task filed, from `tasks item list --pool <pool> --json` filtered by that task, in each pool the prompt records into. It refiles each item under its own task as filed, with the same id, fields, and body, unless a failure or finding in its brief names it. It changes only what each one names. It raises no question already answered. `tests plan` in `plugins/ok/families/ok-planner/scripts/tests` names, in each failure it prints, the item the failure rests on: the item's id and its planner's task, for scenario, question, and legacy items alike. The session edits that item without a search. The failure messages stop telling the session to refile a planner, since the skill decides the path. The id check stays at assembly, and the tracker checks no pool's schema.

Depends on: The task tracker drops an item and keeps it in the record

### The runtime planner names only scenario ids the assembly check accepts

Issues: plan-tests-rejects-a-malformed-scenario-id-only-at-assembly
Makes true: decision:scenario-list-decided-once

In `plugins/ok/families/ok-planner/skills/plan-tests/core.md`, the runtime planner prompt names a new scenario `runtime--<part>--<class>`. Where one part and class carry two harms, the id ends with the harm's entry in lower case, such as `runtime--query-engine--dependency-down--a7`. The `harm` field keeps the accept list's form, `A1` to `A9`, which `tests plan` checks. The story planner, runtime planner, and sort prompts each state, where they name an id, that an id is lower-case letters, digits, and hyphens, as `tests plan` requires. The `<part>` and `<class>` slugs follow the same rule.

### A story planner retires only a scenario the stamp recorded

Issues: plan-tests-offers-retire-on-a-first-plan
Makes true: decision:scenario-list-decided-once

In `plugins/ok/families/ok-planner/skills/plan-tests/core.md`, the story planner prompt's sorting table reads "The story's text dropped a scenario the stamp recorded. | `retire`" in place of "The story's text dropped the scenario. | `retire`". Below the table the prompt adds two sentences. A way the story dropped that no scenario recorded gets no item. `keep`, `rewrite`, and `retire` sort only a scenario the stamp recorded, so a plan with no stamp records only `new` scenarios and gaps. The runtime planner prompt already limits `retire` to a recorded runtime scenario whose part is gone, and stays as it is.

### A test sprint writes support files first and runs its test tasks side by side

Issues: test-write-tasks-chain-on-shared-support-files
Makes true: decision:test-support-written-before-tests, decision:team-execution-cold-gate, decision:test-loop-fixes-code-never-tests

`tests tasks --stage write` in `plugins/ok/families/ok-planner/scripts/tests` files one support task (role and prompt `support`, key `support:<path>`) per support file that a `new` or `rewrite` scenario names, the plan's legacy support entries for that scenario included. The task holds that one file. Its brief names every scenario that names the file, with the outcome the scenario checks, its test, and its reach. Each test task holds only its test file, and for a rewrite at a new path its old test file. It waits, with `--after`, on the support tasks for the support files its scenario names. One writer still holds each file at a time across support, test, and legacy tasks. A legacy task that holds a file a support task holds waits on it, as it waits on any earlier holder. A later `--stage write` files a new support task for a file that a scenario with no test task yet names, where no earlier support task served that scenario, briefed with those scenarios alone. Where the run registers no `support` prompt, as in a test sprint an earlier release planned, `--stage write` files nothing. It names the prompt to register instead.

`plugins/ok/families/ok-planner/skills/plan-tests/core.md` gains `{{TEST-SUPPORT-PROMPT}}`. The support task reads the scenarios in its brief, the code each reach names, and the file as it stands. It writes every helper those tests need to reach the code through its public entry point and to set up and tear down in a folder `mktemp -d` makes or on a stack run. It keeps every helper a live test already uses. It writes no test and no product code, and writes no comment. Where its brief names `helpers` items, it adds each helper and marks each item `added`. It stages its file and closes `done`. `{{TEST-WRITE-PROMPT}}` changes in three ways. The test task reads its support files and changes none of them. Where a helper it needs is missing, it records one item per helper, `tasks item add --pool helpers --key <support path> --field path=<support path> --field scenario=<id> --body "<the helper and what it must do>"`, writes no test, and closes `blocked`. A retirement deletes only the test, and the sweep deletes each support file no live test uses. The next `--stage write` files a support task for each file with an open `helpers` item, briefed with those items, and refiles each blocked test task after it. `plugins/ok/families/ok-planner/skills/plan-tests/test-sprint-document.md` registers `{{TEST-SUPPORT-PROMPT}}` as `support` in step 4 and adds `"helpers": ["open", "added"]` to the pools. Step 5 repeats `--stage write` and the drain until it files nothing, before the ports and the sweep. The completion contract counts support tasks among the tasks whose latest closes `done` and that the latest round runs after. It also requires that no `helpers` item stands open. `tests complete` and `tests report` check and list them the same way.

### Documentation follows its docspec's reader and coverage

Issues: doc-edit-rules-ignore-reader-and-covers
Makes true: decision:documentation-edits-only-where-a-rule-fires, story:declare-project-documentation

A documentation sprint's writer rewrites a passage that departs from its docspec's `## Reader` or `## Covers`. A passage departs where it addresses another reader than the one `## Reader` names, covers what `## Covers` leaves out, or omits what `## Covers` covers. The rule fires on any departure, whatever caused it. It fires on a stamped docspec whose reader or coverage changed, and on a docspec newly declared over existing documentation. Apply the delta above. In `plugins/ok/families/ok-planner/skills/plan-docs/core.md`, `{{DOC-EDIT-RULES}}` gains a seventh row after the shape and layout row: the rule "A file departs from the docspec's `## Reader` or `## Covers`: it addresses another reader, covers what the docspec leaves out, or omits what the docspec covers.", and the edit "Rewrite the passage that departs."

`{{DOC-PLANNER-PROMPT}}` in the same file gives the planner the same rule. Its Inputs tell the planner to judge each file under the Where against the docspec's `## Reader` and `## Covers`. Its step 1 adds a departure from the reader or coverage to the facts that fire a rule, and a file it fires on is a `change`. Step 3 covers a docspec with no stamp through the steps above it, so it needs no new text. Add no numbered step, so step 7 stays the step that finds reshape gaps. `{{DOC-WRITE-PROMPT}}` receives the rule through `{{DOC-EDIT-RULES}}`, and each edit the writer records names it in its `rule` field.

### Documentation planning drops or checks the files a retired or moved docspec left

Issues: retired-docspec-leaves-documentation-behind
Makes true: decision:docspec-stamp-opens-the-window, decision:documentation-claim-ledger, story:keep-documentation-current

`docs window` (`plugins/ok/families/ok-planner/scripts/docs`: `docspec_slugs`, `window_entry`, `cmd_window`, and the USAGE text) returns an entry for each docspec under `.ok-planner/docspec/`. It also returns one for each run state under `.ok-planner/doc-state/` whose docspec is gone. A gone docspec's entry stands `retired`. The tool reads that docspec as it stood at its stamp, with `git show <stamp>:.ok-planner/docspec/<slug>.md`. Where the stamp is none or the repository does not hold it, the tool reads the last commit that holds the docspec's file. The entry names that commit. Its `left` list names each file the docspec's `## Where` covered at that commit that the tree still holds and no standing docspec's `## Where` covers. A standing docspec whose stamp the repository holds gets two lists. Its `left` list names each file its `## Where` covered at the stamp that the tree still holds, that its current `## Where` no longer covers, and that no other standing docspec covers. Its `taken` list names each file the tree holds under its current `## Where` that its `## Where` at the stamp did not cover. A non-empty list is a reason, so the docspec stands `reached`. For an `in code:` Where, the lists name source files. The text output prints both lists. `docs window` says the project declares no documentation only where no docspec and no docspec run state stands. `docs stamp` removes the run state of each planned docspec whose docspec is gone, and prints each path it removed so the archive step stages the removal. `docs complete` skips the generator check for such a docspec and raises no error on it. `docs claims` and `docs example` still refuse a slug with no docspec.

`/plan-docs` (`plugins/ok/families/ok-planner/skills/plan-docs/SKILL.md`) runs while any docspec or any docspec run state stands, and stops at Layout only where neither does. Its Window step names the `retired` status. Its worked-example question skips a retired docspec. A retired docspec keeps its `### docspec:<slug>` heading in the documentation sprint. Where its planner returned no item, the heading carries the `No item` line, so the stamp still removes its run state. In `plugins/ok/families/ok-planner/skills/plan-docs/core.md`, `{{DOC-PLANNER-PROMPT}}` changes in its Inputs and in its steps 1 and 2, and gains no numbered step. The planner of a retired docspec reads the docspec at the commit its entry names and skips `docs claims`. Every planner plans a `drop` of each `left` file. Where a retired `in code:` docspec's `## Generator` said its output is committed, the planner also drops that output. A `taken` file a rule fires on is a `change`; any other `taken` file is a `check`, and every claim in it is checked. `{{DOC-WRITE-PROMPT}}` says how a drop under an `in code:` docspec works: the writer removes the doc comments on the file's declarations, changes no code, keeps the file, and stages it with `git add`. Any other drop runs `git rm`. `{{DOC-CHECK-PROMPT}}` and step 7 of the boilerplate in `plugins/ok/families/ok-planner/skills/plan-docs/doc-sprint-document.md` add a `taken` file to the files whose every claim a checker checks. The `{{DOCSPEC-DEFINITION}}` run-state bullet in `plugins/ok/families/ok-planner/skills/_shared/artifact-definitions.md` says a retired docspec's run state stands until the documentation sprint that passes the files it left is stamped. The docspecs paragraph of `plugins/ok/families/ok-planner/scripts/ok-planner-CLAUDE.md` says the window also finds each docspec retired or moved since its stamp. Apply the two decision deltas above.

### /ok-version's story promises the installed plugin version

Issues: ok-version-reports-installed-not-loaded-version
Makes true: story:see-governing-versions

The story names the ok plugin version installed on the machine, beside the vendored layer's stamp, as the drift signal. `/ok-version` keeps its behavior as it stands: its installed-version line, labeled `Plugin version (installed ok plugin)`, read from `claude plugin list --json` with the `installed_plugins.json` fallback, and its step 1 sentence that the installed version can differ from the loaded one until `/reload-plugins` or a restart. The skill gains no loaded-version line.

The skill text at `plugins/ok/families/ok-planner/skills/ok-version/SKILL.md` must agree with the amended story in its description, its opening paragraph, and step 1. It gains a `<!-- @story: see-governing-versions -->` line above step 1, the site that realizes the story.

### A declined second /ok plan backs out the answer that made it destructive

Issues: ok-outcome-after-declined-second-plan
Makes true: decision:true-up-asks-once-before-destructive-steps

When the owner aborts the second plan of `/ok` step 5.4, the true-up core backs out each answer or `amend` draft whose write made a step of that plan destructive. It restores each file that answer replaced to the bytes it held before the answer, so the project's configuration and the files built from it agree. The first plan's writes and stamps stand. `/ok` records each backed-out answer as declined, runs diagnose again, runs the bare true-up where that plan holds no destructive step, and then runs the wiring step (step 6). The outcome follows the normal rule: `trued up`, or `trued up; check findings pending: <n>` where a backed-out `amend` draft leaves its finding pending. Where no answer made a step destructive, the core backs out nothing and keeps every answer. `/ok` then writes nothing more, reports `trued up; plan steps pending: <d>` with each `DESTRUCTIVE:` line the owner turned down, and goes on to step 6, as it does now. An answer whose write does more than replace one file's bytes, a `rule-file` answer that writes a new rules file and removes or archives the old one, is never backed out.

The core gains one mode, `back-out <plan id>`. It refuses with `the plan changed since diagnose` where the plan id is not the current plan's, as `--go-ahead` does. It prints one `backed out: <id> — restored <path>` line per answer it backs out, or one line saying no answer made plan `<id>` destructive and every answer stands. To do this, `resolve` and `amend` keep the bytes each write replaced in the estate's machine-local folder `.ok-planner/.cache/`. Each plan the core applies clears that record. The back-out restores a file only where the file still holds the bytes the answer wrote, and restores through the same temporary-file-and-rename write every owner-file write uses. The change reaches `plugins/ok/families/ok-planner/admin/true-up`, the core's modes and the input-question sections of `plugins/ok/families/ok-planner/admin/ADMINISTRATION.md`, the modes list, step 5.4, the outcome paragraph of step 7, and the Boundaries of `plugins/ok/skills/ok/SKILL.md`, and the core's modes in `docs/integration-contract.md`. It also reaches `checks/owned-paths` wherever that check lists the core's write sites.

### /dashboard places the pinned page build where the project has none

Issues: dashboard-skill-places-no-missing-build
Makes true: decision:pinned-build-placed-at-true-up

`/dashboard` places the dashboard's page before it starts the service, where the project holds no placed build or one stamped with a version other than the project's pinned version. It copies the build that the installed front door carries for the pinned version. Where no installed front door carries that version, it places nothing, tells the owner that v`<pinned>` of the ok plugin is not installed and to run `/ok`, and starts the service, which serves the stub page and the data routes. Where the placed build already carries the pinned version, it places nothing. True-up keeps placing the page as it does now.

One placement routine serves both acts: it renders each file of a carried build with the version, writes it as text with the build's ignore file, and removes each placed file the carried build does not name. It lives once in the service's source, `plugins/ok/families/ok-planner/scripts/dashboard`, and true-up loads it from the carried copy of that script, the way it loads the carried intake module. Neither act keeps a second copy of the copy, stamp, check, and removal logic. The service gains a `place [--from <front door folder>]` command. It writes nothing and says so where the placed build already carries its own version. It refuses, writing nothing, where the service's version differs from the estate's stamp, where no `--from` is given, where the folder's front-door manifest names another version, or where the folder holds no build `index.html` or a build file that is not UTF-8 text. Each refusal names `/ok`. The skill finds the folder from the user-scoped `ok@ok-plugins` entry's `installPath`, read from `claude plugin list --json`, with the `~/.claude/plugins/installed_plugins.json` fallback. It uses that path where its manifest names the pinned version, and otherwise uses the sibling folder named by the pinned version. The change reaches `plugins/ok/families/ok-planner/skills/dashboard/SKILL.md`: a placement step before the start, the command list in its opening, and the sentence that it edits no file, which now excepts the page build and its ignore file. It also reaches `plugins/ok/families/ok-planner/admin/true-up` (`carried_build`, `expected`, `materialize`), "The dashboard's build" in `plugins/ok/families/ok-planner/admin/ADMINISTRATION.md`, the dashboard paragraph of `plugins/ok/families/ok-planner/scripts/ok-planner-CLAUDE.md`, the `browser/` line of `plugins/ok/families/ok-planner/CLAUDE.md`, and `docs/integration-contract.md`. In that contract, the dashboard section names both placing acts, and the clone promise says that a clone's dashboard page comes from `/dashboard` and the installed front door. `checks/owned-paths` must still pass against the moved routine. The README falls under the `readme` docspec, so this sprint leaves it to the next documentation sprint.

### True-up converts earlier documentation declarations and files one issue for what it cannot write

Issues: true-up-moves-document-types-without-converting
Makes true: decision:whole-file-ownership

True-up converts each document type an earlier release left to the docspec form, with its substance kept. It converts a document type still under `.ok-planner/surface/documents/` as it moves it to `.ok-planner/docspec/<name>`. It also converts a file already under `.ok-planner/docspec/` that holds the document-type form: front matter with a `document` key and no `docspec` key. The conversion maps the form this way. The `docspec: <slug>` front matter takes the `document` value, else the file's stem. The title line stays. `## Where` holds the `target` path alone on its first line. `## Reader` holds the `audience` value as written. `## Covers` holds the `## Purpose` text, then the `## Covers` text. `## Notes` stays last. Any other section's text moves under `## Notes`, opened by its old heading as a line of text. Each conversion is a destructive plan step under the owner's one consent, since it rewrites a file a person edited. Its `Show:` line runs `true-up show <path>`, which prints the conversion's diff. True-up writes nothing to the surface intent.

True-up files one intake issue, through the intake module, after every intake conversion, in the same filing step as the issues for retired script callers. The issue names each section it could not write. For each docspec it converted, the issue names `## References` and `## Shape`, `## Reader` where the file held no `audience`, and `## Lists` where the docspec is reference documentation. Where `.ok-planner/surface/surface.md` lacks `## Where each class is declared`, the issue names that section too. Its id is stable, so true-up files it once and never again. The report carries its `filed:` line. The change reaches `docspec_steps`, the rewrite plan, and `filing_steps` in `plugins/ok/families/ok-planner/admin/true-up`. In `plugins/ok/families/ok-planner/admin/ADMINISTRATION.md` it reaches the move bullet and the surface intent bullet of "The audit and document back-out", and the issues listed in "What the administration does NOT do here". It reaches the `/ok` row of the writer table in `plugins/ok/families/ok-planner/skills/_shared/artifact-definitions.md`, the filers named in `plugins/ok/families/ok-planner/scripts/ok-planner-cheatsheet.md` and `plugins/ok/families/ok-planner/scripts/ok-planner-CLAUDE.md`, and the issues `/ok` files as `docs/integration-contract.md` lists them. Its `docspec_steps` assertions in `checks/owned-paths` describe the new step.

### The edit hook checks every file-editing tool's call and nothing else

Issues: edit-hook-skips-bash-and-notebook-edits
Makes true: story:edit-time-lint-enforcement, decision:edit-hook-blocks-in-turn

The lint's edit hook, `plugins/ok/families/ok-planner/scripts/hooks/post-edit.js`, lints only after a call of Edit, Write, MultiEdit, or NotebookEdit, and passes clean after every other tool's call. A Read of a file that holds a comment no longer blocks. It takes the file from `file_path`, or from `notebook_path` for NotebookEdit. Every failure path still passes silently. The lint, `plugins/ok/families/ok-planner/scripts/plumbline`, reads a `.ipynb` file's code cells in the language the notebook's metadata names, and skips its markdown cells. It reports each finding at the notebook file's line that holds the source line, so the hook's changed-line scoping applies to a notebook as to any other file. A notebook whose language has no comment grammar gets no comment check, as a file with an unknown extension does.

The rules tell agents to make every file edit through Edit, Write, MultiEdit, or NotebookEdit, and say that an edit made any other way waits for the review-time lint. The hook bullet of "Tooling" in `plugins/ok/families/ok-planner/docs/plumbline-cheatsheet.md` names the four tools in place of "Edit/Write" and "It does nothing for a Bash call", and gains that rule. The descriptions of the hook in `plugins/ok/families/ok-planner/admin/ADMINISTRATION.md` ("The lint's edit hook") and `plugins/ok/families/ok-planner/scripts/ok-planner-CLAUDE.md` (the lint and hooks section) name the four tools. The hook's wiring keeps its `""` matcher, so no project's settings entry drifts.

### A confirm drive answers for one defect, and its send-back names each story that failed

Issues: confirm-drive-per-defect-or-per-story
Makes true: decision:drive-tries-each-story-as-a-user

The suite keeps its built confirm unit: `review drives --confirm` files one confirm driver per verified drive defect, its brief names every story the defect names, and the driver marks the defect `confirmed` only where every story it names succeeds. Apply the delta above. The `### Confirm, where your brief says so` section of `plugins/ok/families/ok-planner/skills/converge/prompts/drive.md` keeps its achieved and send-back rules, and its send-back note names each story that failed and what the driver saw on it, so the one verdict still shows which story failed. Step 6 of `plugins/ok/families/ok-planner/skills/converge/SKILL.md` and `review:confirm_briefs` in `plugins/ok/families/ok-planner/scripts/review` already say one confirm driver per defect; each keeps that wording, and `confirm_briefs` keeps its `@decision: drive-tries-each-story-as-a-user` annotation.

### The review tool reads a sprint's fences as CommonMark does, and refuses a body fenced no longer than a block inside it

Issues: delta-body-inner-fence-breaks-certification
Makes true: story:certify-completion, decision:final-form-deltas

The `{{CORPUS-DELTA-FORM}}` block of `plugins/ok/families/ok-planner/skills/_shared/artifact-definitions.md` gains one rule: an inline delta body sits in a fence whose info string is `markdown`, and a body that holds a fenced code block uses an outer fence longer than every fence inside it, such as four backticks around a body whose inner blocks use three. The review tool refuses a body that breaks the rule.

`plugins/ok/families/ok-planner/scripts/review` reads fences in a sprint one way, CommonMark's, in every place it reads them: `fence_depths`, and through it `section_lines`, `unfenced_lines`, and `sprint_deltas`, and `inline_body`. A fence opens on a line of three or more backticks or three or more tildes, with or without an info string. Only a line of the same character, at least as long, with no info string, closes it. No fence nests inside an open fence: every line between the opener and its closer is text, so no delta heading inside a fence counts. An inline body is the text between its `markdown` opener and that opener's CommonMark closer. Where a body holds a line that opens with a run of the outer fence's character as long as the outer fence or longer, or where a fence line stands between the body's closer and the next delta heading or the end of the section, the tool does not compare the body: `review deltas` lists the delta under `unsettled`, and `review certified` fails on it, each with the reason `<the delta>: its body holds a code block fenced as long as the body's own fence; fence the body with more backticks than any fence inside it`. A body in a four-backtick fence holding three-backtick blocks reads whole and compares as before.

### Judgment issues take a shape of their own: the decision in the title, the current state then the choice in the lead

Issues: issue-shape-gives-judgment-issues-a-bug-lead
Makes true: decision:issues-read-cold-before-the-owner

The issue's `category` picks the shape, and no agent judges it: `defect` takes the defect shape, and every other category takes the judgment shape. A defect issue keeps the title that names the cause and the lead that states the cause, then the harm and who sees it. A judgment issue's title names the decision the owner makes, in plain words. Its lead states the current state of the thing in question, what is built, what works, and what a user sees today, then the choice the owner makes. The rest of the problem keeps its order for both kinds: the context from the top, what happened, then the closing sentence or the defect's site and evidence.

Apply the delta above, and change every restatement of the shape with it. In `plugins/ok/families/ok-planner/skills/_shared/artifact-definitions.md`, the `{{ISSUE-FILE-FORMAT}}` block's shape rule states the title and step 1, the lead, for each kind, and the filing template's `problem` hint asks a judgment issue for the current state and the choice. In `plugins/ok/families/ok-planner/skills/triage-issues/prompts/clarity.md`, Rewrite steps 1 to 3 pick the shape by the record's category, the closing note under the example says which kind it shows, and the existing example stands, word for word, as the defect shape's title and lead. The prompt adds this approved judgment-issue example beside it, under a heading that names it the judgment shape:

> **Title:** Whether deploys should show the invitation-request form
>
> The invitation-request form is built and works, but every build hides it behind a build flag that no deploy sets, so no visitor sees the form today. The owner decides whether deploys show the form, and which sender the design names for the mail it sends.
>
> A build flag is a setting the site reads when it is built: a build with the flag off leaves the form out. The form went in behind the flag, and no deploy turns the flag on. The form's mail goes out through the platform, and no design decision names the platform as the sender.
>
> So the form is finished and unreachable. Turning the flag on in a deploy would show it to every visitor, and its mail would go out from a sender no decision records.
>
> The ruling decides whether deploys turn the form on, and whether a design decision names the platform as the form's mail sender.

In `plugins/ok/families/ok-planner/skills/triage-issues/prompts/author.md`, which writes the corpus, question, and upstream routes, the `title` placeholder reads `<the decision, in plain words>`, and the sentence on the shape rule says the title names the decision and the problem leads with the current state, then the choice. The `defect` template in `plugins/ok/families/ok-planner/skills/triage-issues/prompts/triage.md` keeps cause then harm. The Verifying paragraph of `plugins/ok/families/ok-planner/scripts/ok-planner-cheatsheet.md` says the clarity agent leads a defect issue with the cause, then the harm, and a judgment issue with the current state, then the choice.

### The drain runs as a Workflow script, so the session wakes once per drain, and `tasks next` prints counts

Issues: drain-loop-wakes-the-session-on-every-agent-return
Makes true: decision:drain-runs-as-a-workflow-script, decision:no-execution-engine, decision:subagent-model-follows-job, decision:team-execution-cold-gate, decision:task-tools-mirror-the-report

Apply the delta above. `plugins/ok/families/ok-planner/skills/_tasks/drain.md` defines the drain in two forms. Where the harness offers the Workflow tool, the session runs the drain as a Workflow script, starting it once per drain, and wakes when the script returns. Where it does not, the session runs the loop by hand, as the file says today. The script's text is defined once, in a fenced block of `drain.md`. The session passes it inline on its first drain, and on each later drain re-invokes the persisted copy by the `scriptPath` the first result returned. The caller's concurrency cap reaches the script as `args`, and the cap is 8 where the caller names none.

The script runs the loop the hand form runs, and plans and judges nothing. A Workflow script has no shell, so it runs each tracker command through a step agent: `model: 'haiku'`, `effort: 'low'`, whose whole job is to run one tracker command from the project root and return its output verbatim. Each task agent is an `agent()` call with `agentType` set to the profile on the `run` line, `model` set to its `model=` value, and the fixed message `Claim your task and finish it.` as its whole prompt, so every agent of one profile still shares one cached prefix. The first `next` fills the window up to the cap. After that, each returned agent leads to one `next`, and the script starts at most one fresh agent per return. For an `exec` line, a step agent runs `tasks exec <task>`. For a `waiting` line, where no agent the script started is still running, a step agent runs `tasks retry` on each `fork-of` task and the script calls `next` again. Where no `fork-of` task is listed, the script returns. The script returns on `done`, on `waiting`, and when an agent returns without a `closed` line while `next` still lists the same count for its profile and no agent of that profile runs. Before the Workflow tool's lifetime cap of 1000 agents, it returns `paused` at a margin of 50, and the session starts the drain again. Its return names the outcome, the last `next` line, each `closed <task> <outcome>` line, and the count of agents that returned without one. Each task agent carries a label unique within the drain, and the return pairs each label with the task its `closed` line names. After the script returns, the session stamps each such task's usage with `tasks task set <task> --usage <tokens>`, the tokens read from the run record the Workflow tool writes for the run (a JSON file under the session's `workflows/` folder, whose `workflowProgress` entries name each agent's `label` and `tokens`). A task whose agent the record gives no token count stays unstamped, and the session names it in the drain's report. The session acts on that return as the hand form acts on the same lines. It reads task ids for a report from `tasks status`. Where the caller keeps a progress checklist, the session updates it from the closed lines when the drain returns.

`tasks next` in `plugins/ok/families/ok-planner/scripts/tasks` prints counts and names only the tasks a loop must act on by id. The `run` line reads `run <profile> model=… effort=… count=N`, with no `tasks=` field. The `waiting` line reads `waiting running=<n> blocked=<n>`, followed by each `fork-of <task>=<root>` entry as now. `--json` keeps every id, and the usage text names the new lines. The hand form in `drain.md` reads these lines. Its stuck-task report reads the ids from `tasks status`.

The session's sites that assume it wakes on every dispatch change with the drain. `plugins/ok/families/ok-planner/skills/plan-sprint/sprint-document.md` step 6 marks an entry in progress when the drain that runs its build task starts, or at its agent's claim where the session runs the drain by hand, and adds the certification entry when every stage's build task has closed `done`. Step 10 re-renders the completion report before every drain. The same change reaches the Executing a sprint paragraph of `plugins/ok/families/ok-planner/scripts/ok-cheatsheet.md` ("before every dispatch", "in progress at dispatch"), the lifecycle lines of `plugins/ok/families/ok-planner/scripts/ok-planner-cheatsheet.md`, and the execution paragraph of `plugins/ok/families/ok-planner/scripts/ok-planner-CLAUDE.md`. Every boilerplate line of `sprint-document.md` that this change replaces joins `plugins/ok/families/ok-planner/admin/retired-boilerplate.json`, so true-up brings live sprints current. The Subagent models rule needs no change: the script names `model: 'haiku'` as a literal, which the hook at `plugins/ok/families/ok-planner/scripts/hooks/agent-model` reads, and each task agent's model comes from the tracker.

### `/discover-design` drafts a missing artifact under both answers, and planning carries the body either way

Issues: discovery-question-on-proposed-artifact-drafts-nothing
Makes true: decision:corpus-audit-hands-a-discovery-to-planning, story:bootstrap-design-corpus

Apply the delta above. For a question on an artifact the audit proposes, the merge prompt in `plugins/ok/families/ok-planner/skills/discover-design/core.md` (step 6 of the `{{DISCOVER-MERGE-PROMPT}}` block) drafts two bodies. The stale answer's body is the artifact as the code has it, as now. The wrong answer's body is the artifact as the text at issue has it once the code matches, at `[DELTAS PATH]/answers/<question>/wrong/<kind folder>/<slug>.md`, beside the work item. The `{{DISCOVER-REVIEW-PROMPT}}` checklist checks both bodies against the definitions and templates.

`plugins/ok/families/ok-planner/scripts/discover` checks and shows the second body. `question_failures` refuses a question on a proposed artifact that has no wrong-answer body, or whose wrong-answer body does not name the artifact in its frontmatter. `stray_bodies` counts a proposed question's wrong-answer body as named, and a wrong-answer body under any other question stays stray. `question_section` says the corpus does not hold the artifact and either answer creates it, and names the wrong answer's body path under `If the code is wrong`. The assembler still refuses an ordinary delta beside a question on a proposed artifact, and its message says that the question's answers create the artifact. Under the code-is-wrong answer on a proposed artifact, the planning walk in `plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md` (the A discovery bullets under Dialogue) carries the work item and a `New <kind>: <slug>` delta whose body is the wrong answer's body.

### `review prompt --name build` writes the sprint build prompt, and step 3 calls it

Issues: sprint-build-prompt-has-no-assembly-command
Makes true: decision:single-source-transclusion

The sprint build prompt comes from the same command, verb, and flags `/converge` uses for every prompt it registers. A new template, `plugins/ok/families/ok-planner/skills/converge/prompts/build.md`, holds one line, `{{SPRINT-BUILD-PROMPT}}`. The prompt's text stays defined once, in `plugins/ok/families/ok-planner/skills/_sprint/shared.md`.

`review:cmd_prompt` in `plugins/ok/families/ok-planner/scripts/review` applies its line rules to pasted block text at every depth. A token line inside a pasted block is replaced by its block, and `[SPRINT PATH]` and `[BASE]` are filled inside pasted text as they are on a template's own lines. Where a block's fenced body opens with a `Task prompt (profile <name>):` header line, the command drops that line and the indent its other lines share. A block that names itself, directly or through another block, is refused with the chain of names. `review prompt --name build --sprint <sprint> --out <path>` then writes the build prompt with `{{LEAF-AGENT-RULE}}` and `{{CONVERGE-CODING-RULES}}` resolved, `[SPRINT PATH]` filled, and no header line or indent. The verb's help line reads as assembling a prompt from its template, not only the loop's prompts.

Step 3 of the How to execute this sprint boilerplate in `plugins/ok/families/ok-planner/skills/plan-sprint/sprint-document.md` registers the build prompt with `.ok-planner/bin/review prompt --name build --sprint <this sprint's path> --out .ok-planner/sprints/<sprint-name>-build.md`, then `tasks prompt register build <that path>`. The lines it replaces join `plugins/ok/families/ok-planner/admin/retired-boilerplate.json`. The note in the `{{SPRINT-REVIEW-READING}}` block of `shared.md` drops its claim that `review prompt` fills no slot inside a block. The block keeps the names `<base>` and `<sprint>`.

### The DOM picker reference file carries no prose comment

Issues: dom-picker-reference-carries-prose-comments
Makes true: the comment rule of the Plumbline cheatsheet (accept-list entry A8)

The reference file `plugins/ok-web/skills/setup-dom-picker/reference/dom-picker.ts` opens with a 13-line prose header comment, and the lint's `comment-hygiene` check fails on it with 11 violations. Delete the header, lines 1 to 13. The skill's contract section in `plugins/ok-web/skills/setup-dom-picker/SKILL.md` already states the `window.__domPicker` globals, the `data-claude-selected` stamp, and the dev-only import, so nothing is lost. Afterward `node .ok-planner/bin/plumbline plugins/ok-web/skills/setup-dom-picker/reference/dom-picker.ts` exits 0.

### One definition reads and writes a sprint's closed stamp

Issues: closed-stamp-frontmatter-parse-copied
Makes true: rule 6 of `.claude/rules/plumbline-coding.md` (accept-list entry A8)

`plugins/ok/families/ok-planner/scripts/docs` and `scripts/tests` each carry a byte-identical `closed_stamp`, `with_closed_stamp`, and `CLOSED_STAMP` pattern, and `scripts/review::frontmatter_value` carries a third reading of the same frontmatter that accepts any non-empty `closed:` value. Keep one definition of the frontmatter parse and the stamp write, and have the other scripts load it, as `scripts/review::load_sibling` loads a sibling script. Afterward all three tools read the same `closed:` value the same way, a hex commit of 7 to 40 characters, and `review certified` reads no terminal stamp the test and documentation tools refuse.

### /converge's fix loop handles a defect a done fix task left at fixing

Issues: fix-task-closed-done-leaves-defect-fixing
Makes true: story:catch-broken-promises, decision:converge-finds-then-fixes

When a fixer closes its fix task `done` and leaves its defect at `fixing`, no verifier checks the defect, the loop's end check passes, and the owner list never files it. Fix Loop 2 of `plugins/ok/families/ok-planner/skills/converge/SKILL.md` (steps 2, 4, and 5), `scripts/review::cmd_verifies`, `scripts/tasks::check_sweep`, and `skills/converge/prompts/owner-list.md` so a defect still at `fixing` after any close of its fix task goes back to `open` (or is otherwise taken up), the loop does not end while a defect stands at `fixing`, and the owner list files every defect the run left, `fixing` included. Every set that decides a defect's state transition names `fixing`.

### The lint checks a Python docstring as a documentation comment

Issues: lint-passes-python-docstrings-anywhere
Makes true: decision:comments-forbidden-by-default, story:declare-project-documentation

`plugins/ok/families/ok-planner/scripts/plumbline::checkCommentHygiene` reads a Python `"""..."""` docstring as a string, so a docstring passes in any Python file. Fix the lint so a docstring on a Python module, class, or function in a file no in-code docspec names fails `comment-hygiene`, as a `/** ... */` comment does in TypeScript and Go. A docstring in a file an in-code docspec names, or in a file whose committed `@plumbline:allow-docstrings` marker an earlier release left, still passes. The change deletes the docstrings in `plugins/ok/families/ok-planner/scripts/tasks`, `checks/owned-paths`, and `checks/oscillation`, which no in-code docspec names and no earlier release's marker covers.

### issues show prints a message's edited and withdrawn marks

Issues: issues-show-hides-edited-and-withdrawn-marks
Makes true: decision:owner-messages-can-change, decision:triage-answers-owner-messages

The text form of `issues show` prints each person's message with its current text alone, through `plugins/ok/families/ok-planner/scripts/issues::message_line`, and drops `earlier`, `edited`, and `withdrawn`. Fix it, with Read step 1 of `skills/triage-issues/prompts/respond.md`, so an answered message that was edited shows its earlier text and its edited mark, and a withdrawn message shows its withdrawn mark, and the respond agent reads both. Afterward neither prints as a plain `not yet seen` message.

### docs complete refuses a documentation sprint that checked no claim

Issues: docs-complete-passes-with-no-claim-checked
Makes true: decision:documentation-claims-checked-until-they-hold, decision:documentation-claim-ledger, story:keep-documentation-current

`plugins/ok/families/ok-planner/scripts/docs::complete_failures` tests only the writer and style tasks, so a run that files no checker task prints `DOCS COMPLETE`. Fix it, and the completion contract in `skills/plan-docs/doc-sprint-document.md`, so a documentation sprint whose run checked no claim of a file it wrote or changed reports not complete, naming what was not checked.

### The documentation planner reports the reshape gaps its own step found

Issues: doc-planner-output-names-wrong-reshape-step
Makes true: story:keep-documentation-current, story:reference-names-the-public-surface

The Output section of `{{DOC-PLANNER-PROMPT}}` in `plugins/ok/families/ok-planner/skills/plan-docs/core.md` reports the reshape gaps "step 6 found", while step 7 finds them. Fix the Output section so it reports the gaps the step that finds them found, and the owner learns of every docspec that needs reshaping.

### surface-corpus lists subject, practice, and docspec citations

Issues: surface-corpus-skips-subjects-and-practices
Makes true: story:record-coding-practices

`plugins/ok/families/ok-planner/scripts/surface-corpus::main` maps only concepts, stories, and decisions to folders, skips every other cited kind, and prints nothing where `.ok-planner/design/` is empty. Fix it so an issue whose `artifacts` cite a `subject:`, `practice:`, or `docspec:` slug prints that file (under `.ok-planner/subjects/`, `.ok-planner/practices/`, or `.ok-planner/docspec/`), the token search reads those folders too, and an empty design folder does not stop the lookup.

### /plan-sprint's sign-off reviewer is told which findings are settled

Issues: sign-off-review-raises-settled-findings-again
Makes true: story:plan-a-sprint

Fix step 7 (Sign-off) of `plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md` and its reviewer prompt, `skills/_shared/design-doc-compliance-reviewer.md`, so each re-dispatch passes the findings the owner or the session already settled, and the reviewer raises none of them again. Sign-off then ends clean without overriding an owner's answer. The notes review's `[SETTLED]` input in `skills/plan-sprint/core.md` is the sibling shape.

### A sprint's close commits the archived discovery and sketches

Issues: sprint-close-commit-omits-discovery-move
Makes true: story:plan-a-sprint, decision:corpus-audit-hands-a-discovery-to-planning

Fix "How to execute this sprint" in `plugins/ok/families/ok-planner/skills/plan-sprint/sprint-document.md` so step 2 lists the discovery the planning session archived beside the sketches, and the archive-and-commit step names both the archived discovery and the archived sketches among the paths it commits. Afterward no clone shows a discovery as open after its sprint closes.

### review stories reads a missing stories folder as no story

Issues: review-stories-refuses-missing-stories-folder
Makes true: story:find-and-fix-defects

`plugins/ok/families/ok-planner/scripts/review::story_slugs` turns a missing `.ok-planner/design/stories/` folder into a refusal, so `review stories` and `review drives` fail in a freshly trued-up project. Fix it so a missing folder lists no story, as `review certified` already reads it, and `/converge` skips the drive and says so.

### A drive whose stack fails to start gets its stack running, and takes down only what it started

Issues: failed-drive-start-tears-down-another-runs-stack
Makes true: story:concurrent-stacks-without-port-collisions, story:fresh-artifacts-per-run, decision:run-artifacts-removed-with-the-run, concept:run-tag, story:find-and-fix-defects

The owner ruled: "a, but we need a clean way to retry the drive later and/or troubleshoot the failure and/or fall back to one drive at a time" and "no, we want the drives to work. if one drive can work, then any can. the sprint executor needs to figure that out. which encompasses retry later and fall back to one at a time."

The drive never runs its stop command after a failed start, so no teardown removes a stack this run did not start. Today, after a failed `stack up --name drive`, drive step 2 of `plugins/ok/families/ok-planner/skills/converge/SKILL.md` runs the stop line, which takes down whatever run holds the name `drive`, another live run's stack included. Afterward the drive runs the stop only after a start that passed, in drive step 2 and confirm step 6, and the stop line in `admin/ADMINISTRATION.md` (Stack declaration) and the claim in `docs/stack-helpers.md` that no run holds the name after a failed start change to match.

A failed start does not end the drive. The run that holds the drive, `/converge` in drive or sprint mode, works out why the start failed from the start's output and the stack registry, and gets the stack running with no owner action. Where another live run holds the stack's name or the resources the start needs, the drive waits for that run to finish and starts again, so drives in one checkout run one at a time. Where the start fails for another cause, the run retries the start, and falls back to one driver at a time where many drivers at once break the stack. The drive ends without driving only where no retry can succeed in the tree as it stands, and then the run names the cause in its return and files it to the intake, as an `environment` failure is filed now. Every story the drive did not drive is named in the return.

### The port registry bounds its docker calls

Issues: port-lease-hangs-on-hung-docker
Makes true: story:concurrent-stacks-without-port-collisions, decision:ports-leased-from-a-project-range

`plugins/ok/families/ok-planner/scripts/docker-sweep::docker_out` runs docker with no time limit, so a daemon that accepts the connection and never answers stalls every `stack up` and `ports lease`. Fix the call so it times out, and `ports lease` skips the docker check on a timeout as its help says it does where docker's daemon does not answer.

### docs window names a listed class that matches no declaring line

Issues: docs-window-skips-class-with-no-declaring-line
Makes true: story:reference-names-the-public-surface, decision:surface-members-listed-at-need

`plugins/ok/families/ok-planner/scripts/docs::declaring_paths` returns paths only, so a reference docspec's `## Lists` class that no declaring line of the surface intent matches leaves the docspec `current` with no note. Fix it, with `docs::window_entry`, so `docs window` names each listed class that matches no declaring line, and `/plan-docs` tells the owner.

### /plan-tests sorts a fixture by whether a kept test uses it

Issues: test-sort-decides-fixtures-before-adoptions
Makes true: story:retire-a-legacy-suite, decision:legacy-suites-sorted-automatically

Step 5.2 of `plugins/ok/families/ok-planner/skills/plan-tests/SKILL.md` sorts each fixture in a batch apart from the tests that read it, and `scripts/tests::plan_failures` never checks a `support` entry against the kept tests. Fix the sort so a fixture is kept exactly when a kept test uses it: no fixture a kept test reads is deleted, and no fixture that no kept test reads stays claimed.

### /plan-tests sorts single tests under a whole-file test command

Issues: file-level-runner-sorts-legacy-files-whole
Makes true: story:retire-a-legacy-suite, decision:legacy-suites-sorted-automatically

The Sort section of `{{TEST-SORT-PROMPT}}` in `plugins/ok/families/ok-planner/skills/plan-tests/core.md` sorts each file whole where `testing.run` holds no `{name}`, with `scripts/tests::locator`. Fix it so orphan and duplicate legacy tests inside a kept file are deleted under any runner, as the decision requires.

### A vetoed test deletion or port at a test sprint's close is undone or filed

Issues: test-sprint-veto-of-deletion-has-no-effect
Makes true: story:retire-a-legacy-suite, decision:legacy-suites-sorted-automatically, story:veto-calls-made-in-my-absence

Step 8 of "How to execute this test sprint" in `plugins/ok/families/ok-planner/skills/plan-tests/test-sprint-document.md` acts only on vetoed calls. Fix it so a vetoed deletion or port no longer stands as if the owner accepted it: the close overturns it, or files it as an issue carrying the owner's words as its ruling where `tests complete` has already closed the test paths.

### A test sprint's close records the owner's veto as a ruling

Issues: test-sprint-veto-filed-without-ruling
Makes true: story:veto-calls-made-in-my-absence, decision:converge-close-takes-vetoes

Step 8 of "How to execute this test sprint" in `plugins/ok/families/ok-planner/skills/plan-tests/test-sprint-document.md` files one issue per vetoed call with no ruling. Fix it so the close then records the owner's words as that issue's ruling with `.ok-planner/bin/issues rule <id> --text -`, and relays a refusal for want of a name, in the shape of the sibling close in `skills/plan-sprint/sprint-document.md`.

Depends on: A vetoed test deletion or port at a test sprint's close is undone or filed

### A documentation sprint's close records the owner's veto as a ruling

Issues: doc-sprint-veto-filed-without-ruling
Makes true: story:veto-calls-made-in-my-absence, decision:converge-close-takes-vetoes

Step 9 of "How to execute this documentation sprint" in `plugins/ok/families/ok-planner/skills/plan-docs/doc-sprint-document.md` files one issue per vetoed call with no ruling. Fix it so the close then records the owner's words as that issue's ruling with `.ok-planner/bin/issues rule <id> --text -`, and relays a refusal for want of a name, in the shape of the sibling close in `skills/plan-sprint/sprint-document.md`.

### A person's first write starts their read ledger

Issues: first-comment-does-not-seed-read-ledger
Makes true: story:see-new-analysis, decision:read-marks-kept-per-person

`plugins/ok/families/ok-planner/scripts/issues::person_message` writes a person's comment or ruling and creates no read ledger, so the person's first later read counts every reply that landed before it as read. Fix `person_message`, and every other person's write verb (`set_flag`, `edit_message`, `remove_message`, `withdraw_ruling`, and the dashboard's rule and comment routes that call them), so a person's first intake act of any kind starts their ledger, and an answer landing after it reads as new.

### The tests tool lists test files in the declared folders

Issues: tests-window-ignores-declared-folders
Makes true: story:project-spans-folders, decision:project-declares-its-folders

`plugins/ok/families/ok-planner/scripts/tests::tree_files` runs `git ls-files` in the project root alone, and `window_entry`, `test_file_hashes`, and `stray_paths` build on it. Fix it so the tests tool lists the files under each folder `.ok-planner/config.json` declares under `folders`, as the lint and the review tool do, and `/plan-tests` sorts, adopts, and deletes a test in a declared folder.

## Implementation notes

Planned against commit `fba31e1b6decbd311cd4d05bf97e3c1e948bf27b`.

Shared sites the stages chain on, from code planning:

Read at `fba31e1b6decbd311cd4d05bf97e3c1e948bf27b`; the working tree differs only under `.ok-planner/` (intake files and this sprint), so every site below reads the same in both. All paths are under `plugins/ok/families/ok-planner/` unless they start otherwise. The vendored copies (`.claude/skills/plan-tests/`, `.claude/rules/*.md`, `.ok-planner/CLAUDE.md`, `.ok-planner/bin/tests`) change only at the owner's next `/ok`; no stage edits them.

Shared mechanism the items below build on, stated once:

- **No earlier-run gate.** The Trued-up projects boundary leaves out a planning run in progress: the owner trues up only between runs. `tests plan` applies every new check to every run: the scope item, the groups file, the per-story selection, and the kind, setup, entry, scope, and call-kind refusals. No code reads the run's registered prompts to tell an earlier release's run apart.
- **Step numbers of `skills/plan-tests/SKILL.md` after this sprint** (the build sweeps every "as step N does" inside the file, the only references to these numbers in the tree): 1 Layout, 2 The runner, 3 Window, 4 Run the suite once, 5 The owner's inputs (new), 6 Plan, 7 The owner's answers, 8 Assemble, 9 The runner check (new), 10 Draft, 11 Review, 12 Approval, 13 Terminal. The sibling work item "/plan-tests fixes a planner's items in place…" names assembly as step 7, review as step 9, and approval as step 10; under this layout those are steps 8, 11, and 12, and the stage that lands later reconciles the cross-references.

Read at commit `fba31e1b6decbd311cd4d05bf97e3c1e948bf27b`. The working tree differs from it only in the intake's two files and the untracked sprint, so every site below is read at the commit. Paths are relative to `plugins/ok/families/ok-planner/` unless they start with `.ok-planner/`, `docs/`, or `checks/`.

Shared sites. Several of these work items, and work items other planners hold, edit the same definitions. The executing session chains their stages on these files:
- `scripts/tests`: the closed-stamp work item also makes `tests` load a sibling. Keep one `load_sibling` definition in `tests` and one `review = load_sibling("review")` line, which the folders item below needs too.
- `scripts/tasks`: the usage text is the string at line 5. The drain work item rewrites its `next` lines, and the drop item below adds lines and has `--help` print it.
- `skills/plan-tests/SKILL.md` steps 5, 7, 9, and 10, `skills/plan-tests/core.md` (the intro's prompt counts and every planner prompt), and the `skills/plan-tests/` line of `CLAUDE.md` (the family's): the scope, groups, widen, review, and call-kind work items edit these too.
- `skills/plan-tests/test-sprint-document.md` step 8: two of these work items share it, and the documentation sprint's veto item edits its sibling, step 9 of `skills/plan-docs/doc-sprint-document.md`.

Paths below are from the project root. `ok-planner/` abbreviates `plugins/ok/families/ok-planner/`. Every change lands in the canonical sources; the vendored copies under `.claude/skills/` and `.ok-planner/bin/` change only when the owner runs `/ok`.

Shared definitions across these items, which the stages must chain with `--after`:

- `ok-planner/scripts/docs`: items 2, 3, and 5 change it, and so does "One definition reads and writes a sprint's closed stamp". Items 2 and 5 both change `window_entry`, `cmd_window`, and `USAGE`. Items 2 and 3 both change `complete_failures`. Item 2 and the closed-stamp item both change `cmd_stamp`.
- `ok-planner/skills/plan-docs/core.md` `{{DOC-PLANNER-PROMPT}}`: items 1, 2, and 4 change it.
- `ok-planner/skills/plan-docs/doc-sprint-document.md`: items 2, 3, and 6 change it.
- `ok-planner/skills/_sprint/shared.md`: item 2 (`{{CEREMONY-ARCHIVE}}`) and I203 change it, and so does "`review prompt --name build` writes the sprint build prompt" (`{{SPRINT-REVIEW-READING}}`).
- `ok-planner/scripts/plumbline`: item 7 changes it, and so does "The edit hook checks every file-editing tool's call and nothing else" (notebook cells).

Read at `fba31e1b6decbd311cd4d05bf97e3c1e948bf27b`. The working tree differs only in `.ok-planner/issues.jsonl`, `.ok-planner/history/issues.jsonl`, and the untracked sprint, so no code file differs from the commit.

Several of these items, and items other planners hold, edit the same files. Staging must serialize them or put them in one stage:

- `plugins/ok/families/ok-planner/admin/true-up`, `admin/ADMINISTRATION.md`, `docs/integration-contract.md`, and `checks/owned-paths`: the back-out, dashboard, and conversion items here.
- `plugins/ok/families/ok-planner/scripts/ok-planner-CLAUDE.md`: the dashboard, conversion, and edit-hook items.
- `.ok-planner/review/project.md`: the back-out, dashboard, and docker items.
- `plugins/ok/families/ok-planner/skills/converge/SKILL.md` step 6: the failed-drive-start item here, and the confirm-drive item ("A confirm drive answers for one defect…").
- `plugins/ok/families/ok-planner/scripts/plumbline` (`checkCommentHygiene`, `runLint`): the edit-hook item here, and the Python docstring item ("The lint checks a Python docstring as a documentation comment").

All paths below are relative to the project root. Every code path is a canonical source under `plugins/`; no vendored copy under `.claude/` or `.ok-planner/bin/` changes. The tree at the working copy matches commit `fba31e1` under `plugins/`, `docs/`, and `checks/`.

Shared files across these work items, for staging: `plugins/ok/families/ok-planner/scripts/review` (fence reading, `cmd_prompt`, `cmd_verifies`, `VERB_HELP`), `plugins/ok/families/ok-planner/scripts/tasks` (`next` lines, `check_sweep`, `cmd_batch`), `plugins/ok/families/ok-planner/skills/plan-sprint/sprint-document.md` and `plugins/ok/families/ok-planner/admin/retired-boilerplate.json` (the drain item's steps 6 and 10, the build-prompt item's step 3, and the close-commit item another planner holds), `plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md` (the discovery item, and the sign-off item another planner holds), `plugins/ok/families/ok-planner/skills/_shared/artifact-definitions.md` (the fence rule, the issue shape, and the docspec run-state bullet another planner holds), `plugins/ok/families/ok-planner/scripts/ok-planner-cheatsheet.md` and `ok-planner-CLAUDE.md` (several items), and `plugins/ok/families/ok-planner/skills/converge/SKILL.md` (the fixing item). `checks/sprint-boilerplate` refuses a `retired-boilerplate.json` that is unsorted, that lacks a released line the carried template dropped, or that holds a line no `v*` tag laid out. Every line these items replace is in `v28.0.0`, so each one joins the list, sorted.

The code was read at `fba31e1b6decbd311cd4d05bf97e3c1e948bf27b`. The working tree matches that commit under `plugins/`, `checks/`, and `docs/`.


Shared sites with other work items, for staging:
- `plugins/ok/families/ok-planner/skills/converge/SKILL.md` step 6 (Loop 2, confirm): this item, and "A confirm drive answers for one defect…", which keeps step 6's wording byte for byte. This item rewrites only step 6's failed-start sentence.
- `plugins/ok/families/ok-planner/skills/converge/prompts/drive.md` `### Confirm, where your brief says so`, second bullet: I601 here adds a blocked-by-the-stack bullet before it, and the confirm item rewrites that bullet's `--note`. Chain the two stages.
- `plugins/ok/families/ok-planner/skills/converge/SKILL.md` Loop 1 drive steps: no other work item edits them.

### A scenario checks one distinct outcome a program shows

**Calls**
- `core.md` states the delta's per-program wording, not the work item's shorter sentence: one outcome two programs show yields one scenario per program, and a duplicate is a second scenario that checks an outcome another scenario checks through the same program. Decided by: the delta for decision:tests-check-scenarios, which the work item says the rules state; the sign-off call below.
- (Sign-off) decision:tests-check-scenarios keeps the per-program dimension: one outcome two programs show yields one scenario per program, and distinctness covers what the user or the product sees. Decided by: the accepted recommendation's text, "each distinct outcome a user or the product sees through a program is its own scenario".
- (Drafting) decision:legacy-suites-sorted-automatically keeps its wording ("a way a story gives its benefit that no planner named becomes a new scenario"); it stays true under the amended rule, and no issue of this batch requires it to change.
- The sort prompt's record line for a scenario a sort agent records, `--field id=<story slug>--<way>`, becomes `<story slug>--<outcome>`, the same naming the story planner's rule takes. Decided by: rule 1 of the coding rules (every literal that restates the definition).
- `README.md:147` restates the definition. It falls under the `readme` docspec, so this sprint leaves it to the next documentation sprint. Decided by: only a documentation sprint writes documentation (ok-planner cheatsheet, "Documentation"), as the sprint's /dashboard work item treats the README.
- The drive's "each way the story says its benefit comes" in `skills/converge/SKILL.md` and `skills/converge/prompts/drive.md` stays. It names the drive's variants under decision:drive-tries-each-story-as-a-user, not the scenario definition.
- The review prompt's check "No story way yields two scenarios for one program" leaves `core.md` with the review split. Decided by: the work item's last sentence, which gives the review's check to "/plan-tests reviews each planner task, then the whole plan".

**Changes**
- `skills/plan-tests/core.md::{{TEST-SCENARIO-DEFINITION}}`: changed. Case 1 reads: a story names it, and executable code carries it: each distinct outcome a user or the product sees through a program, for any plausible way the story's implementation gives or refuses its benefit. The sentences on what a program is, on prose, and on a story offered through a skill stay. The cap paragraph becomes: two outcomes through one program are distinct when the user or the product sees a different result, a different reply, a different refusal, or a different state left behind; one outcome two programs show yields one scenario per program; a second scenario that checks an outcome another scenario checks through the same program is a duplicate; each runtime pairing of part, class, and harm yields one scenario. The sentences on outcome text, gaps, support, and unserved programs stay.
- `skills/plan-tests/core.md::{{TEST-STORY-PLANNER-PROMPT}}`: changed. Read step 5 has the planner find the programs a user runs for the benefit, read each entry point and the path it takes, and find each plausible way the implementation gives or refuses the benefit and each distinct outcome a user or the product sees on it. The `new` row reads "Code shows an outcome of the story that no scenario checks." The naming line reads `<story slug>--<a short slug for the outcome>`.
- `skills/plan-tests/core.md::{{TEST-SORT-PROMPT}}`: changed. The second `adopt` row reads "It checks an outcome of a story that no scenario checks, and code carries it." The recorded scenario's id is `<story slug>--<outcome>`.
- `skills/plan-tests/SKILL.md` (opening paragraph): changed. Each scenario is a distinct outcome a user or the product sees through a program, for a way a story's implementation gives or refuses its benefit, or a runtime failure the product must survive.
- `scripts/ok-planner-CLAUDE.md` ("The tests", second paragraph), `scripts/ok-planner-cheatsheet.md` ("Tests", first paragraph), `docs/plumbline-cheatsheet.md` ("Tests", second bullet), and the "Tests." paragraph of `CLAUDE.md` (the family's): changed. Each restatement says a test checks one scenario: a distinct outcome a user or the product sees through a program, for a way a story's implementation gives or refuses its benefit, as far as executable code carries it, or a runtime failure paired with an accept-list harm, in each file's existing form.

**Behavior changes**
- **B1** `skills/plan-tests/core.md::{{TEST-SCENARIO-DEFINITION}}` and the story and sort prompts. Before: a story way yields at most one scenario per program; its variants and refusals merge into one scenario. After: each distinct outcome per program is its own scenario, and a second scenario checking one outcome through one program is a duplicate. Users: in the release: every prompt that transcludes the definition (story, runtime, sort, review, test, fix prompts). Across the public surface: owners who run `/plan-tests`. Across stored state: a `test-state.json` an earlier release recorded under the old cap. Ruling: migrate: a scenario list recorded under the old cap reads as it stands; each recorded scenario stays, and a later plan adds a scenario per distinct outcome only for a story it touches or widens (call). Decided by: the scenario-list delta, "Every other story's scenarios stand as recorded".
- **B2** the four rules texts and the family `CLAUDE.md`. Before: "a way a story says its benefit comes". After: the distinct-outcome definition. Users: in the release: every session that loads the materialized rules files, which `/ok` rewrites in the same true-up that vendors the skill; the family `CLAUDE.md` is read in this repository alone. Ruling: rewrite.

### /plan-tests settles the time limit with the run command and checks the plan against both

**Calls**
- (Drafting) The test kind and setup are the fields `kind` and `setup` on scenario items; the questions and calls pools already use `kind` for their own sorts, and a field name is per pool.
- (Drafting) `tests plan` refuses a `new` or `rewrite` scenario with no kind, setup, or entry, and a planning call with no valid kind; the cheatsheet's mechanical-checks rule asks that every written constraint fail on violation.
- (Drafting) Where `testing.run` is declared and `testing.timeout` is not, step 2 asks for the limit alone; the recommendation asks for the limit beside the command, and a project declared under v28 has a command and no limit.
- (Drafting) The runner check runs after the last assembly, before approval, and where the owner changes neither the command nor the limit, the story is re-planned to a form the command runs, with an `untested` call for each outcome no such form reaches; the recommendation leaves the no-change answer open, and this keeps every runner question in the interactive session.
- (Drafting) `tests plan --show` lists each kind and setup pair with its count, so the session compares each pair with the runner once rather than each test.
- Step 2 declares the limit alone by running `tests declare --run "<the declared command>" --timeout <seconds>`, since `declare` takes `--run` as required. The tool keeps its flags. Decided by: one idiom per job; `scripts/tests::cmd_declare` already writes both keys.
- The planners read the limit as `testing.timeout`, or 600 seconds where it is absent. Decided by: `scripts/tests::testing_config`, whose `DEFAULT_TIMEOUT` is 600.
- The kind and setup refusals reach a `keep` the owner's answer turns into a `rewrite`, so the story planner's keep-with-a-question record names the kind, setup, and entry a rewrite would need. Decided by: the story planner prompt's existing rule that such a keep names the test "as a rewrite to the new behavior would write them, so the owner's rewrite answer needs nothing more".
- `scripts/tests::scenario_brief` names each scenario's kind, setup, and entry, so the test task writes the test in the form the runner check approved. Decided by: the work item's "The test sprint's unattended run then never meets a runner question".
- The runner check's re-plan is the one-story re-plan task keyed `story:<slug>` that "/plan-tests groups stories…" sets, its brief naming each test the command cannot run and why. After it, the session assembles and checks again. Decided by: that work item's re-plan form.

**Changes**
- `skills/plan-tests/SKILL.md` step 2 (The runner): changed. Where `testing.run` is not declared, the one prose question proposes the command and asks for the time limit of one test in seconds, then runs `tests declare --run "<the command>" --timeout <seconds>`. Where `testing.run` is declared and `testing.timeout` is not, it asks for the limit alone and re-declares the standing command with `--timeout`. Where both are declared, it asks nothing. The project keeps one run command.
- `skills/plan-tests/SKILL.md` new step 9 (The runner check): new. After the last assembly, it reads the kind and setup pairs `tests plan --show` prints and compares each with `testing.run` and `testing.timeout`. For each pair the command cannot run within the limit, it asks the owner, one question per turn, to change the command or the limit, and runs `tests declare` again on a change. Where the owner changes neither, it re-plans each story whose test that pair names, as above, and assembles again.
- `skills/plan-tests/SKILL.md` step 13 (Terminal): changed. The session writes `testing.run` and `testing.timeout` through `tests declare`.
- `skills/plan-tests/core.md::{{TEST-STORY-PLANNER-PROMPT}}` and `{{TEST-RUNTIME-PLANNER-PROMPT}}`: changed. Each Read list gains `testing.run` and `testing.timeout` (600 seconds where absent) from `.ok-planner/config.json`. The Plan section plans each test in a form the command runs within the limit where one exists, and records a call of kind `untested` for each outcome no such form reaches. The Record line gains `--field kind=<such as unit, cli, browser, stack> --field setup="<such as a scratch folder, a running stack, a browser>"` for `new` and `rewrite`, and for a `keep` that carries a question.
- `scripts/tests::scenario_of`: changed. It copies `kind`, `setup`, and `entry` into the plan's scenario where the item holds them.
- `scripts/tests::plan_failures`: changed. It refuses each `new` or `rewrite` scenario with no `kind` or no `setup`, naming the scenario, its item, and its task, in the failure form the sibling work item "/plan-tests fixes a planner's items in place…" sets.
- `scripts/tests::scenario_brief`: changed. It adds `Kind: <kind>. Setup: <setup>. Entry: <entry>.` Every written scenario holds the three, since `tests plan` refuses a `new` or `rewrite` without them.

**Behavior changes**
- **B3** `skills/plan-tests/SKILL.md` step 2. Before: the session asks for the command alone and writes `testing.run`. After: it asks for the command and the limit, or the limit alone, and writes `testing.timeout` too. Users: across the public surface: owners who run `/plan-tests`. Across stored state: `.ok-planner/config.json`, whose `testing` fields cross the trued-up projects boundary. Ruling: migrate: a configuration with `testing.run` and no `testing.timeout` reads as it does now, a 600-second limit, and step 2 asks for the limit once (call). Decided by: `testing_config`, which already reads the key with that default.
- **B4** `skills/plan-tests/SKILL.md` step 9 and the planner prompts. Before: no check of a test's form against the runner before approval. After: the session asks the owner about each pair the command cannot run, and planners record kind and setup. Users: in the release: the planner prompts and the session. Across the public surface: owners who run `/plan-tests`. Ruling: migrate: `/plan-tests` takes the same arguments, and a plan whose tests all suit the command asks nothing new (call).
- **B5** `scripts/tests::plan_failures`. Before: a `new` or `rewrite` with no kind or setup assembles. After: it is refused, named. Users: in the release: the session's assembly step. Across Trued-up projects: none; the boundary leaves out a planning run in progress, which an earlier release opened. Ruling: rewrite.
- **B6** `scripts/tests::scenario_of` and `scenario_brief`. Before: a plan's scenarios carry no kind, setup, or entry, and a test task's brief names none. After: both carry them. Users: in the release: `tests tasks --stage write` and the test prompt. Across Trued-up projects: none; the boundary leaves out a test sprint an earlier release planned, which is brought current before it runs, and only `--stage write` reads these fields. Ruling: rewrite.

### /plan-tests takes the owner's scope and program answers before any planner runs

**Calls**
- Build note: the runtime planner records `entry` on a runtime `keep` that carries a question, as the story planner does, so an owner's `rewrite` answer reaches `plan_failures` with an entry.
- (Drafting) The scope is recorded as an item in a `scope` pool of the planning run, with paths and the owner's words, rather than as a new `tests` verb or a sibling file; the planning run already holds every other owner answer as an item, and one idiom per job decides it.
- (Drafting) A scenario's program is a new `entry` field on `new` and `rewrite` scenarios; the assembly can check scope and unguarded programs only against a path, and `reach` is free text.
- (Drafting) The programs pass is a new prompt, `{{TEST-PROGRAMS-PROMPT}}`, role `programs`, and it lists only entry points inside the scope; the recommendation names a pass of its own, and a program outside the scope is not the plan's to guard.
- (Drafting) The scenario-list decision now says the owner sets the scope and answers the unserved programs before planning; the paragraph it sits in is rewritten for the touched-story rule anyway, and leaving the old order would misstate when the owner decides.
- The scope refusals apply to the scenarios planners record as `new` or `rewrite`: their test path, support files, and entry. A sort agent sorts every test file its brief names whatever the scope, and an `adopt` outside the scope stands. Decided by: decision:legacy-suites-sorted-automatically ("sorts every test no scenario claims, however many there are"), which a scoped sort would break, and the work item, which records `entry` on `new` and `rewrite` alone.
- A `rewrite` an owner's answer makes is not held to the scope: the check reads each planner's action before the answers apply. Decided by: the owner gave the rewrite in their own words, and decision:scenario-list-decided-once leaves that scenario to the owner.
- A story planner sorts each recorded scenario of its story whatever the scope (`keep`, `retire`, or a question). Where a rewrite would reach outside the scope, it keeps the scenario and records a call of kind `scope`. Decided by: the decision's "The owner decides each scenario whose outcome changed or whose code is gone", and "Planners plan no scenario outside the scope".
- A file lies inside the scope where it equals a scope path, lies under it as a folder, or matches it as a glob (`fnmatch`, where `*` crosses `/`); `.` covers the project. Paths compare normalized and relative to the root. Decided by: the work item's "path or glob".
- The scope question asks for the paths that hold the code and the tests the plan covers, and the session records the paths it proposes from the owner's answer beside the owner's words. Decided by: the assembly checks test paths, support files, and entries against the same paths.
- `tests plan` refuses a run with no scope item or with more than one, naming each, and a scope item whose `paths` is not a non-empty list of non-empty strings. The session changes a recorded scope with `tasks item set <item> --field ...`. The scope item carries no task, and the assembly reads it from its pool whatever its task. Decided by: rule 7.1 of the coding rules (refuse up front, never take the first).
- The programs pass runs where the window's status is not `current`, as the runtime planner does. A widen-only run still asks and records the scope. Decided by: a window that is `current` changed no code, so no program became unserved; the drafting call on the runtime planner.
- The programs prompt reads the scope in its brief, the stamp's unguarded list (`tests scenarios --json`), the story catalog and each story an entry point may serve, `.ok-planner/review/project.md`, and the tree. It records only `unguarded` questions, in the form the runtime planner records them now, and closes with `<n> entry points; <u> unguarded`. It transcludes `{{LEAF-AGENT-RULE}}`, `{{TEST-SCENARIO-DEFINITION}}`, and `{{TEST-CALL-RULE}}`. Decided by: the runtime planner's record it replaces (rule 2, the sibling's shape).
- A scenario's entry names a program the owner left unguarded where its normalized path equals a stamp `unguarded` path or the path of a `no-guard` answer of this run.
- The sort brief carries the scope, and the sort prompt says the scope bounds the scenarios planners write, not the sort. Decided by: the work item's "Every planner's brief then carries the scope", and the first call above.
- The description in the frontmatter of `SKILL.md`, "The tests" in `scripts/ok-planner-CLAUDE.md`, and "Tests" in `scripts/ok-planner-cheatsheet.md` restate when the owner answers; each says the owner sets the scope and answers each program no story serves before planning, then each scenario whose outcome changed. Decided by: rule 1 of the coding rules.
- `plan["scope"]` holds the paths and the owner's words, and `tests plan --show` prints them first, so the plan-wide review reads the scope from the plan.

**Changes**
- `skills/plan-tests/SKILL.md` new step 5 (The owner's inputs): new. It opens the planning run here (the `tasks init`, `tasks agent register ok-opus`, prompt registration, and pool declaration that open step 5 now move here), registering `story`, `runtime`, `sort`, `programs`, `review`, and `plan-review`, and declaring `"scope": ["open"]` and `"stories": ["open"]` beside the five pools declared now. It asks the scope in one prose question and records `tasks item add --pool scope --key scope --field 'paths=[...]' --field said="<the owner's words>"`. Where the window's status is not `current`, it files one task: `tasks file --role programs --prompt programs --agent ok-opus --key programs --brief "scope: <the owner's words> (paths: ...); the last run is at <the results path, or none>"`, drains, lists the open questions with `tests plan ... --questions`, asks each program question one per turn with the two answers, and records each answer with the `tasks item set` line step 7 uses.
- `skills/plan-tests/SKILL.md` step 7 (The owner's answers): changed. It loses the program bullet; it asks only about a scenario whose outcome changed or whose code is gone.
- `skills/plan-tests/SKILL.md` frontmatter description: changed, as the call above says.
- `skills/plan-tests/core.md::{{TEST-PROGRAMS-PROMPT}}`: new, as the call above says.
- `skills/plan-tests/core.md::{{TEST-RUNTIME-PLANNER-PROMPT}}`: changed. The title becomes "Plan the runtime scenarios". It loses Read step 6, Plan step 2, the unguarded record, and `<u> unguarded entry points` in its close result. It reads the scope from its brief, plans `new` and `rewrite` inside it, and records `--field entry=<path>` on each.
- `skills/plan-tests/core.md::{{TEST-STORY-PLANNER-PROMPT}}`: changed. It reads the scope and the program answers from its brief, plans no `new` or `rewrite` outside the scope or for a program left unguarded, records `--field entry=<path>` on `new`, `rewrite`, and a keep that carries a question, and records a `scope` call where the scope excludes a rewrite.
- `skills/plan-tests/core.md::{{TEST-SORT-PROMPT}}`: changed by one sentence on the scope.
- `scripts/tests::PLAN_ROLES`: changed to `("story", "runtime", "sort", "programs")`.
- `scripts/tests::assembled_plan`: changed. It reads the one scope item, refuses as the call says, and writes `plan["scope"] = {"paths": [...], "said": "..."}`. It checks each planner's `new` and `rewrite` before the answers apply.
- `scripts/tests::plan_failures`: changed. It refuses, naming each with its item and task: a `new` or `rewrite` with no `entry`; one whose test path, a support file, or entry lies outside the scope; one whose entry is a program the stamp or a `no-guard` answer of this run leaves unguarded.
- `scripts/tests::print_plan`: changed. It prints `Scope: <said> (<paths>)` where the plan holds a scope.
- `scripts/tests` USAGE (the `plan` entry): changed. It says the assembly reads the scope item.
- `skills/plan-tests/test-sprint-document.md` (Owner answers in the template): changed. It opens with the scope in the owner's words and its paths, then the program answers, then the scenario answers.

**Behavior changes**
- **B7** `skills/plan-tests/SKILL.md` steps 5 and 7. Before: the owner answers program questions after every planner ran, and no scope is asked. After: the owner sets the scope and answers each program question before any planner runs. Users: across the public surface: owners who run `/plan-tests`. Across stored state: the stamp's `unguarded` list, which the programs pass reads as the runtime planner read it. Ruling: migrate: `/plan-tests` takes the same arguments, a stamp's unguarded list reads as now, and each program it records is not asked again (call).
- **B8** `skills/plan-tests/core.md::{{TEST-RUNTIME-PLANNER-PROMPT}}`. Before: it plans runtime scenarios and raises unguarded questions. After: it plans runtime scenarios alone. Users: in the release: the session, which now files the programs task. Ruling: rewrite.
- **B9** `scripts/tests::assembled_plan` and `plan_failures`. Before: no scope item is read, and no scenario is checked against a scope, an entry, or the unguarded list. After: each refusal above. Users: in the release: the session's assembly step. Across Trued-up projects: none; the boundary leaves out a planning run in progress. Ruling: rewrite.
- **B10** `scripts/tests::assembled_plan` (`plan["scope"]`), `print_plan`, and the test sprint template. Before: a plan and a test sprint record no scope. After: both do, and `--show` prints it. Users: in the release: the plan-wide review and the session's draft step. Across stored state: an archived test sprint's `-plan.json`, which holds none and which `tests plan --show` still reads, since `tests` accepts a test sprint under `.ok-planner/history/test-sprints/`. The boundary leaves out an open test sprint's plan, which is brought current before it runs. Ruling: migrate: a plan with no scope reads as now and prints no scope line (call).

**New surface**
- The `programs` role and prompt, declared in `skills/plan-tests/core.md`: internal.

### /plan-tests groups stories into planner tasks and, after the first plan, plans only the stories a run touches

**Calls**
- Build note: apply the per-story selection to `story`-role tasks only; a sort agent's scenario items carry `source=story:<slug>` but come from a `sort` task, and selecting them by story drops sort adoptions.
- Build note: a judgment fix on one story in a group runs as a `story:<slug>` re-plan that refiles only that story's items; the fix item's revision refile names the same task, and the assembly selects by the highest task holding each `stories` item.
- Build note: a sort agent's `adopt` into a recorded gap of an untouched story turns that scenario into `adopt` rather than the automatic `keep`.
- Build note: the citation scan calls `tests::tree_files` with the declared folders, as the folders item gives it.
- (Drafting) Group size is 8 stories per planner task, set by a flag on the groups verb; the recommendation says "a set size", and 8 cuts the linescout plan's 107 planners to about 14.
- (Drafting) Stories join a group where any file cites both; a group over the size splits in catalog order.
- (Drafting) A story is touched where its file changed, a changed file cites it, or its recorded test failed in the planning run; option D names exactly these, and a story added since the stamp counts as changed.
- (Drafting) Each planner records a `stories` item per story it plans, so the assembly tells a story planned with no scenario from a story no planner reached, and takes each story's items from the latest done task holding that item.
- (Drafting) The runtime planner runs on every run whose window status is not `current`, and not on a widen-only run; it plans no story, and the recommendation narrows only story planning.
- (Drafting) The work items build on the repair-side sibling's edits to steps 5, 9, and 10 of `skills/plan-tests/SKILL.md` and to the planner prompts in `core.md` (the edit step, the revision refile, the lower-case runtime harm suffix, and retire limited to recorded scenarios), and on its decisions dropped-items-stay-in-the-record and test-support-written-before-tests; this batch owns the scenario-definition lines and the review-check lines of `core.md`.
- The verb is `tests groups --sprint <path> --from-run <planning run> [--size <n>] [--widen [<story slug> ...]] [--json]`. It writes `<name>-groups.json` beside the test sprint and prints each group's key, its stories with their reasons, and its brief. It refuses a size below 1, a `--widen` slug with no file under `.ok-planner/design/stories/`, a missing planning run, and a run with no scope item, each with a message that names the fix. Decided by: rule 7 of the coding rules, and `tests plan`'s `--sprint`/`--from-run` shape (rule 2).
- The verb builds each brief whole: the group's stories with their reasons, the last run's path, the scope in the owner's words and as its paths, and each program answer (the path, the answer, and the reason for no guard), read from the run's scope item and answered `unguarded` questions. The session files each group with the brief the verb printed. Decided by: one place builds the text every planner reads, so the session copies no answer by hand.
- A citation is a match of `@story:\s*([a-z0-9][a-z0-9-]*)` in a text file `tree_files` lists outside `.ok-planner/`. A file that does not decode as UTF-8 is skipped. Decided by: the design corpus is not code; `tree_files` is the tool's one file lister, which the sibling work item "The tests tool lists test files in the declared folders" extends to the declared folders.
- The changed files are those `changed_since(root, stamp)` lists, as `window_entry` reads them. A story is touched by a failure where a recorded scenario whose source is `story:<slug>` fails in `<name>-planning-results.json`. The reasons are `new`, `changed`, `cited <file>`, `failed <scenario>`, and `widen`.
- Catalog order is slug order, the order `story_slugs` and `scripts/catalog-toc` both list stories in. Stories that one file cites together join one component; each component over the size splits in catalog order into chunks of the size; touched stories no file cites with another are batched by the size in catalog order; groups are numbered `group:1`, `group:2`, … in catalog order of their first story.
- The groups file records `"runtime": true` where the window's status is not `current`. Where it is `false`, the assembly keeps each recorded runtime scenario as `keep` with the ruling "the rules: no runtime planner ran"; where it is `true`, it refuses a run with no done runtime task. It refuses a run with no groups file, naming `tests groups`. Decided by: the drafting call on the runtime planner.
- The assembly selects each story's items from the done `story` task, latest per key, with the highest task number that holds a `stories` item for it: the story's scenarios (source `story:<slug>`), the questions on those scenarios, and the calls whose `story` field names it. A story task's call that names no story stands from each done story task. Runtime, sort, and programs items stand per role and key, as now. Decided by: the work item; `complete_failures`, which orders tasks by `task_order` (rule 2).
- One function, `planning_items`, selects the run's items for both `assembled_plan` and `tests plan --questions`. Decided by: rule 6 of the coding rules (one copy of one mechanism); today both call `latest_done` and `settled_questions` on their own.
- A one-story re-plan's brief is the story's group brief, narrowed to the one story with its reasons.

**Changes**
- `scripts/tests::cmd_groups`: new, with `touched_stories`, `story_citations`, and `planning_groups`, as the calls say; `build_parser` and USAGE gain the verb.
- `scripts/tests::planning_items`: new, as the call says.
- `scripts/tests::assembled_plan`: changed. It reads the groups file and the `stories` pool, selects items through `planning_items`, refuses each touched story no done task holds a `stories` item for (naming it), keeps each recorded scenario of a story the groups file does not list as `keep` with the ruling "the rules: its story was not touched", and writes `plan["stories"]`, the sorted slugs its planners planned. Each plan call carries `key`, `kind`, and `story` beside `site`, `choice`, and `body`.
- `scripts/tests::cmd_plan` (`--questions`): changed. It selects through `planning_items`.
- `scripts/tests::plan_failures`: changed. The failure "the stamp recorded it, and the plan says nothing of it" holds only where the scenario's story is in `plan["stories"]`, or the scenario is a runtime one and a runtime planner ran.
- `skills/plan-tests/SKILL.md` step 6 (Plan): changed. It runs `tests groups`, files one story task per group (`--role story --prompt story --key group:<n> --brief "<the printed brief>"`), files the runtime task where the groups file says `runtime`, files the sort batches as now, and drains. An assembly failure or review finding on one story re-plans it in a task keyed `story:<slug>` in the form the sibling work item sets.
- `skills/plan-tests/core.md::{{TEST-STORY-PLANNER-PROMPT}}`: changed. "The task prompt for a story planner, one task per group of stories." It plans each story its brief names: Read steps 1, 2, and 5 run per story, steps 3 and 4 once. Per story it records `tasks item add --pool stories --key <slug> --field story=<slug> --task <task>`, and each call names its story. Its close result gives the counts per story.
- `skills/plan-tests/core.md::{{TEST-SORT-PROMPT}}`: changed. Read step 2 also reads `.ok-planner/bin/tests scenarios --json`.
- `scripts/ok-planner-CLAUDE.md` ("The tests"): changed. It names planners for groups of stories, the programs pass, the runtime planner, and the sort agents.

**Behavior changes**
- **B11** `skills/plan-tests/SKILL.md` step 6. Before: one story task per story, keyed by slug, every story on every run. After: one task per group of up to 8, keyed `group:<n>`, and after the first plan only the touched stories. Users: across the public surface: owners who run `/plan-tests`, who see fewer planner tasks. Ruling: migrate: `/plan-tests` takes the same arguments, and each untouched story's scenarios stand as recorded (call). Decided by: the scenario-list delta.
- **B12** `scripts/tests::assembled_plan` and `plan_failures`. Before: each planner's items stand by role and key; every recorded scenario the plan omits is refused. After: the per-story selection, the untouched keep, the refusal of an unplanned touched story, and `plan["stories"]`. Users: in the release: the session. Across Trued-up projects: none; the boundary leaves out a planning run in progress. Ruling: rewrite.
- **B13** `scripts/tests::assembled_plan` (the plan's `stories` and the calls' new fields). Before: a plan holds neither. After: both. Users: in the release: `print_plan`, `cmd_report`, and the widen lookup. Across stored state: an earlier release's archived `-plan.json`, which the widen lookup, `tests plan --show`, and `tests report` read. The boundary leaves out an open test sprint's plan, which is brought current before it runs. Ruling: migrate: a plan with no `stories` reads as one that planned every story, and a call with no `key`, `kind`, or `story` reads by its `site` (call). Decided by: the widen work item's rule for older plans.
- **B14** `scripts/tests::cmd_plan --questions`. Before: it selects with `latest_done` over three roles. After: it selects through `planning_items`, with `programs` among the roles. Users: in the release: steps 5 and 7 of the skill. Across Trued-up projects: none; the boundary leaves out a planning run in progress. Ruling: rewrite.
- **B15** `scripts/ok-planner-CLAUDE.md`. Before: "a planner per story". After: planners for groups of stories. Users: in the release: sessions in a trued-up project, after the `/ok` that vendors the skill. Ruling: rewrite.

**New surface**
- `tests groups`, declared in `scripts/tests`: internal.

### /plan-tests widens the stories the owner names, on any run

**Calls**
- Build note: `earlier_calls` orders archived plans by the ancestry of their stamps; a stamp the repository no longer holds sorts by the test sprint's dated file name.
- (Drafting) The widen run starts as `/plan-tests widen [<slug> ...]`; the recommendation says the owner starts it on any run and names stories or asks for every thin story.
- (Drafting) The earlier calls of a story come from the latest archived plan that planned it, and a call maps to a story by its `story` field, else by its site or key; with only touched stories planned, the last plan may hold no call for a given story.
- (Drafting) A call "left a path out" is one of kind `untested`, and in an older plan whose calls carry no kind, every call of the story counts; the kind from the approval item names that group, and older plans predate it.
- (Drafting) For a widen-only story the planner adds `new` and `gap` items and the assembly keeps its recorded scenarios as recorded; the recommendation says every other scenario stands as recorded.
- The lookup verb is `tests calls <story slug> ... [--json]`. For each story it names the archived plan that last planned it and that plan's calls for the story that left a path out. It refuses a slug with no story file. Decided by: the work item's "lists, for a story, the calls".
- The archived plans are the `-plan.json` files beside the test sprints under `.ok-planner/history/test-sprints/` that carry a `closed:` stamp, newest first by the stamps' ancestry. One test sprint stands at a time, so the stamps form one line. Decided by: `sprints_closed_since`, the tool's sibling that reads archived sprints by their `closed:` stamps (rule 2); the closed-stamp work item keeps one `closed_stamp`.
- One function, `earlier_calls`, serves `tests calls` and `tests groups --widen`. Decided by: rule 6 of the coding rules.
- `tests groups --widen` with no slug widens each story `earlier_calls` finds a path-leaving call for. Where it finds none and the window is `current`, the session tells the owner that no earlier call left a path out, and stops.
- The skill reads its first argument: none, or `widen` followed by story slugs. Any other argument is refused with the line `/plan-tests [widen [<story slug> ...]]`, and `tests groups` refuses an unknown slug. Decided by: a value a user supplies is checked where it enters (rule 4.8 of the coding rules).
- For a story whose only reason is `widen`, the assembly keeps each recorded scenario the planner names nowhere as `keep`, with the ruling "the rules: a widen run keeps it as recorded".
- A widen run on a `current` window records the scope (step 5) and runs neither the programs pass nor the runtime planner. Decided by: the drafting call on the runtime planner; the programs call of the scope work item.

**Changes**
- `skills/plan-tests/SKILL.md` (opening and step 1): changed. It names its arguments, `/plan-tests` or `/plan-tests widen [<story slug> ...]`, and refuses any other.
- `skills/plan-tests/SKILL.md` step 3 (Window): changed. Where the status is `current` and the owner asked for no widen run, it says the tests stand where the last test sprint left them, names `/plan-tests widen [<story slug> ...]` as the way to reopen stories, and stops. Where the owner asked for one, it goes on.
- `skills/plan-tests/SKILL.md` step 6: changed. It passes `--widen [<slug> ...]` to `tests groups` on a widen run.
- `skills/plan-tests/SKILL.md` (the machinery paragraph): changed. It names the earlier plans under `.ok-planner/history/test-sprints/` as records the session reads, through `tests calls`.
- `scripts/tests::cmd_calls` and `earlier_calls`: new; `build_parser` and USAGE gain `calls`.
- `scripts/tests::touched_stories`: as above, adds `widen` reasons.
- `scripts/tests::assembled_plan`: changed by the widen-only keep.
- `skills/plan-tests/core.md::{{TEST-STORY-PLANNER-PROMPT}}`: changed. For a story the brief marks `widen`, the planner reads `tests calls <slug> --json` and adds a `new` scenario for each outcome those calls left out that the code supports, one per distinct outcome and no duplicate, or a `gap` where no code supports it. Where `widen` is the story's only reason, it records only `new` and `gap` items and its `stories` item.

**Behavior changes**
- **B16** `skills/plan-tests/SKILL.md` steps 1 and 3. Before: `/plan-tests` takes no argument and stops on a `current` window. After: it takes `widen [<slug> ...]` and plans a widen run on any window; without it, the stop line also names the widen run. Users: across the public surface: owners who run `/plan-tests`. Ruling: migrate: `/plan-tests` with no argument behaves as now, and only its stop line gains a sentence (call).
- **B17** `scripts/tests::earlier_calls`. Before: no tool reads an archived plan. After: the tool reads archived plans an earlier release wrote. Users: across stored state: every `-plan.json` under `.ok-planner/history/test-sprints/`. Ruling: migrate: a plan with no `stories` planned every story, and in a plan whose calls carry no kind every call of the story counts (call). Decided by: the work item.

**New surface**
- The `widen [<story slug> ...]` argument of `/plan-tests`, declared in `skills/plan-tests/SKILL.md`: public by the surface intent's Slash commands rule ("with the arguments its text says it takes").
- `tests calls`, declared in `scripts/tests`: internal.

### /plan-tests reviews each planner task, then the whole plan

**Calls**
- (Drafting) The review covers each sort batch with a review task of its own, besides each story group and the runtime task; the reason the recommendation gives, a bounded reading per task, holds for a sort batch too, and the current review's legacy checks need a home.
- (Drafting) The two review prompts are a planner review prompt and a plan-wide review prompt, keyed `review:<planner task>` and `review:plan`.
- The prompts are `{{TEST-PLANNER-REVIEW-PROMPT}}`, role `review`, and `{{TEST-PLAN-WIDE-REVIEW-PROMPT}}`, role `plan-review`; `{{TEST-PLAN-REVIEW-PROMPT}}` leaves `core.md`. `rg` finds the old token only in `core.md`, `SKILL.md` step 5, and the vendored copy. Decided by: rule 1 of the coding rules; `checks/token-resolution` passes with both new headings defined once.
- The review step files its tasks after the assembly, since the plan-wide review reads `tests plan --show`: one per latest done planner task (each `group:<n>`, each `story:<slug>` re-plan, `runtime`, and each `sort:<n>`), and `review:plan`. The programs task gets no planner review; the plan-wide review checks its answers. Decided by: the work item's list.
- A planner review reads its task's items with `tasks item list --pool <pool> --json`, filtered by the item's `task`, in the scenarios, questions, legacy, calls, and stories pools.
- A finding records `--field site=<scenario or file> --field refile=<planner task> --field fix="<what the planner must change>"`. Decided by: the work item's "Each finding names its site and the planner task it refiles"; the item's own `task` is the review task, so the planner task needs a field of its own.
- The review step runs once; a fix's re-plan gets no second review. Decided by: the work item names none.

**Changes**
- `skills/plan-tests/core.md::{{TEST-PLAN-REVIEW-PROMPT}}`: removed.
- `skills/plan-tests/core.md::{{TEST-PLANNER-REVIEW-PROMPT}}`: new. It transcludes the leaf rule, the read-only reviewer rule, and the scenario definition, and checks the list the work item gives: one distinct outcome per scenario for a plausible way, or a runtime pairing; no two of the task's scenarios on one outcome; each distinct outcome with a scenario or an `untested` call; outcome text; `new` and `rewrite` through a public entry point with kind, setup, and entry; runtime conditions caused from outside; `port` names a rule; `adopt` names a scenario the test checks. It records findings as the call says.
- `skills/plan-tests/core.md::{{TEST-PLAN-WIDE-REVIEW-PROMPT}}`: new. It prints `tests plan --show`, reads the test sprint, and checks that no two scenarios across planners check one outcome through one program, and that the scope, each program answer, and each scenario answer hold in the plan as the owner gave them.
- `skills/plan-tests/SKILL.md` step 11 (Review): changed. It files the review tasks above, drains, applies each finding in the form the sibling work item "/plan-tests fixes a planner's items in place…" sets, re-planning one story alone where a re-plan is needed, marks each finding `resolved`, assembles again, and writes the new counts into the test sprint. Step 5 registers both prompts.
- `CLAUDE.md` (the family's layout line for `skills/plan-tests/`): changed. It names the programs prompt and both review prompts.

**Behavior changes**
- **B18** `skills/plan-tests/SKILL.md` step 11 and the review prompts. Before: one review task reads the whole plan. After: one per planner task, then one for the plan. Users: in the release: the session. Across the public surface: owners who run `/plan-tests`. Ruling: migrate: `/plan-tests` takes the same arguments, and the owner still sees one approval (call).
- **B19** the family `CLAUDE.md` layout line. Users: in the release: agents working in this repository; the file is not vendored. Ruling: rewrite.

### Planners tag each call with its kind, and approval leads with a sorted summary

**Calls**
- Build note: `tests plan --show` prints the scope line, then the summary, then the listing (B10 and B22 together).
- Build note: `tests plan --from-run <run> --questions --json` works today, because `--questions` prints JSON whatever the flags. Refuse `--json` only where neither `--show` nor `--questions` is given.
- (Drafting) The call kinds are `untested`, `departure`, `scope`, and `mechanics`, and a sort agent's call takes one of the four; option C lists these four as examples, and the summary needs a closed set.
- (Drafting) The kind field joins the shared `{{TEST-CALL-RULE}}`, so the run's prompts that transclude it record kinds too; one call rule keeps one idiom, and only `tests plan` refuses a missing kind.
- `tests plan` refuses each call of a done planning task with no `kind` or a kind outside the four, naming the call's item and its task. Decided by: the work item, in the failure form of the sibling work item.
- The summary's per-story counts take the story from the scenario's source, `story:<slug>`, and count runtime scenarios under `runtime`. A call with no kind, from an archived plan an earlier release wrote, prints under `no kind`. The kind and setup pairs count the `new` and `rewrite` scenarios, and a scenario without them, in such a plan, prints as `no kind, no setup`.

**Changes**
- `skills/plan-tests/core.md::{{TEST-CALL-RULE}}`: changed. The `tasks item add --pool calls` line gains `--field kind=<untested | departure | scope | mechanics>`, the four definitions the work item gives, and `--field story=<slug>` for a call about one story.
- `scripts/tests::assembled_plan` and `plan_failures`: changed. The plan's calls carry `kind` and `story`; each call with no kind or an unknown kind is refused, named.
- `scripts/tests::print_plan`: changed. It leads with the summary in the work item's order (scenarios per story by action; each `untested` and `departure` call whole, with site, choice, and body; the other calls grouped by kind, one line each; each kind and setup pair with its count), then prints the listing it prints now.
- `skills/plan-tests/SKILL.md` step 12 (Approval): changed. It presents that output, and the owner approves the whole plan once.

**Improvements**
- **I2** `scripts/tests::main` (the `plan` flag check): A8, rule 7.1 of the coding rules (refuse a flag combination up front, never drop one silently). `tests plan --from-run <run> --json` ignores `--json` and assembles. Afterward: `main` refuses `--json` without `--show`, beside its refusal of `--show` with `--from-run`. It lands in this item's stage, which edits `cmd_plan` and `print_plan`.

**Behavior changes**
- **B20** `skills/plan-tests/core.md::{{TEST-CALL-RULE}}`. Before: a call records site, choice, and body. After: also kind, and story where it is about one. Users: in the release: every prompt that transcludes the rule, the run's prompts among them, which a test sprint's run writes from the vendored `core.md` when it opens. Ruling: rewrite.
- **B21** `scripts/tests::plan_failures`. Before: a call is never refused. After: a call with no valid kind is refused. Users: in the release: the session. Across Trued-up projects: none; the boundary leaves out a planning run in progress. Ruling: rewrite.
- **B22** `scripts/tests::print_plan` (`tests plan --show`). Before: the counts, then the listing. After: the summary first, then the counts and listing. Users: in the release: SKILL steps 9 and 12, the plan-wide review prompt, and the legacy, sweep, and fix prompts, which read entries from the listing. Across stored state: an archived test sprint's `-plan.json`, which `tests plan --show` still reads. The boundary leaves out an open test sprint's plan, which is brought current before it runs. Ruling: migrate: the listing keeps its lines, and an archived plan whose calls carry no kind prints them under `no kind` (call).
- **B26** (I2) `scripts/tests::main`. Before: `tests plan --json` without `--show` ignores the flag. After: it is refused. Users: in the release: none; no site in `skills/` or `scripts/` passes `--json` to `tests plan` without `--show`. Ruling: rewrite.

### The task tracker drops an item and keeps it in the record

**Calls**
- Build note: `tasks::Run.items` leaves dropped items out of `call_rows`, which reads `run.store.all("item")`, and `certification_rows`, which opens another run's store, goes through the same filter.
- From the drafting calls: no delta to `concept:task-tracker`. The concept stays true with a drop: the record keeps every item and its removal, and the tracker still judges nothing. Decided by: the drafting batch g1b.
- From the drafting calls: the drop gets a new decision, `dropped-items-stay-in-the-record`. The recommendation picks one of several real options for a stated tradeoff. Decided by: the drafting batch g1b.
- From the drafting calls: `item set` gains `--body`. A wording fix changes a scenario's outcome, which lives in the item's body, and `item set` cannot change a body today. Decided by: the drafting batch g1b.
- From the drafting calls: `dump` and `snapshot` keep a dropped item with its drop mark, and every other read leaves it out. Decided by: the drafting batch g1b and decision:dropped-items-stay-in-the-record.
- From the drafting calls: `item set` and a second drop refuse a dropped item. A dropped item is out of every read, so editing it would change something no reader sees. Decided by: the drafting batch g1b.
- One definition decides what a dropped item is. `Run.items(pool=None, state=None)` returns the item records that match and carry no `dropped` mark. `Run.live_item(iid)` returns one item, and refuses an unknown item and a dropped one. Every read and every write of an item goes through them, and `dump` and `snapshot` keep reading the store directly. Decided by: decision:dropped-items-stay-in-the-record ("one place decides what a dropped item is").
- `close --item <i>=<state>` and `batch --items <i>` refuse a dropped item, as `item set` does. Both write an item's state, so they belong to the class the work item names. Decided by: rule 8 of `.claude/rules/plumbline-coding.md`, and the drafting call above.
- The drop writes the item's new line and its `TASKS.ITEM.DROPPED` event in one `put_many`, the way `add_items` writes an item and its `TASKS.ITEM.ADDED` event. Decided by: rule 3.1 and rule 2 of the coding rules.
- The drop mark is `dropped: {"by": ..., "reason": ..., "at": ...}` on the item record. The event's fields are `item`, `pool`, `key`, `task`, `by`, and `reason`. The verb prints `dropped <id>`. Decided by: the work item's field list, and the `added` lines the tracker prints today.
- `--by` and `--reason` are required by argparse. A value that is empty after stripping is refused with `fail` (exit 2), which names the empty flag. The refusals read: `no item <id>`, and `item <id> is already dropped by <by>: <reason>`. Decided by: the work item, and `fail` as the tracker's one refusal path.
- `item set --body` takes `-` for stdin through `read_body`, as `item add --body` does. It applies wherever the value is not None, so an empty body replaces the old one. Decided by: rule 2 (the sibling `item add`), and the work item ("replaces an item's body").
- `tasks --help` lists both verbs only if the usage text reaches argparse. Today the verb list at line 5 is a bare string literal that nothing prints, and `--help` shows argparse's one-line summary. Bind the text to `USAGE`, the way `scripts/tests` does, and pass it as the parser's `description` under `argparse.RawDescriptionHelpFormatter`. Add `item drop <id> --by <who> --reason <why>` and `--body B|-` on `item set`. Decided by: the work item ("`tasks --help` lists both") and the sibling shape in `scripts/tests`. This text is also the "usage text" the drain work item rewrites, and the docstring lint work item needs to know that the literal is now an assignment.
- `.ok-planner/review/project.md` names the new input in its `scripts/tasks` bullet. Decided by: that file's own rule that a build which changes a script input updates it in the same stage.
- Leave `# @decision: dropped-items-stay-in-the-record` above the drop handler, the site that realizes the decision. Decided by: the estate's annotation rule.

**Changes**
- `scripts/tasks::Run.items`: new. Returns the item records that match `pool` and `state` (through `store.where`) and carry no `dropped` mark, in line order.
- `scripts/tasks::Run.live_item`: new. Returns one item. It fails with `no item <id>` on an unknown item, and with `item <id> was dropped by <by>: <reason>` on a dropped one.
- `scripts/tasks::cmd_item` (`drop`): new subcommand. It refuses an unknown item, an item already dropped (naming who and why), and an empty `--by` or `--reason`. It writes the marked item and one `TASKS.ITEM.DROPPED` event in one `put_many`, and prints `dropped <id>`.
- `scripts/tasks::cmd_item` (`set`): changed. It reads the item through `live_item`, so it refuses a dropped one. It gains `--body B|-`, which replaces the body.
- `scripts/tasks::select_items` (`item list`, `item count`): changed. Reads through `Run.items`.
- `scripts/tasks::consumed_items` (`claim`): changed. Reads pools through `Run.items`, and skips a dropped `batch_items` entry.
- `scripts/tasks::grouped_batch`: changed. Reads through `Run.items`. `scripts/tasks::explicit_batch`: changed. Reads through `live_item`, so it refuses a dropped item.
- `scripts/tasks::cmd_close`: changed. `--item` reads through `live_item`.
- `scripts/tasks::cmd_report`, `scripts/tasks::call_rows` (`render`, `calls`, and `render --certification`'s rows through `certification_rows`), and `scripts/tasks::round_summary` (`round show`, `status --json`): changed. Read items through `Run.items`.
- `scripts/tasks::cmd_dump`, `scripts/tasks::Store.snapshot`, `scripts/tasks::Store.rebuild` and `sync`: unchanged. They copy or replay the record whole, so a drop survives a rebuild, and a run file with no drop reads as it did.
- `scripts/tasks::build_parser` and the usage text: changed. `item drop` gets its parser, and `item set` gets `--body`. `USAGE` becomes the parser's description.
- `scripts/ok-planner-CLAUDE.md`, the task tracker section: changed. Beside "Never hand-edit a run file" it adds: an orchestrator that must remove an item drops it with `tasks item drop`.
- `.ok-planner/review/project.md`, the `scripts/tasks` bullet: changed. Names `item drop <item> --by <who> --reason <why>`, which refuses an unknown item, an item already dropped, and an empty flag, and `item set --body <text|->`.

**Behavior changes**
- **B101** `scripts/tasks` run log and item reads (`item list`, `item count`, `claim`, `batch`, `report`, `render`, `calls`, `round show`). Before: every item record in the run file is read, and an item has no drop mark. After: an item record may carry `dropped`, the log may hold `TASKS.ITEM.DROPPED` events, and every read but `dump` and `snapshot` leaves a dropped item out. Users: in the release, every caller of `item list` (`scripts/tests`, `scripts/review`, `scripts/docs`, `scripts/discover`, and the skill prompts). None of them observes a change until some caller drops an item. Across Trued-up projects (the task tracker's run log format), a run file an earlier release wrote: it holds no drop mark, so it reads as it did. Ruling: preserve (call).
- **B102** `scripts/tasks::build_parser` (`tasks --help`). Before: argparse's one-line summary with the list of verb names. After: the whole usage text, verb by verb, `item drop` and `item set --body` included. Users: in the release, people and agents who read the help. No script parses it. Ruling: rewrite.

**New surface**
- `tasks item drop`, `tasks item set --body`, and the event kind `TASKS.ITEM.DROPPED`, declared in `scripts/tasks`: internal.

### /plan-tests fixes a planner's items in place, or has the planner revise only what a fix names

**Calls**
- Build note: under the shared layout of `skills/plan-tests/SKILL.md`, this item's steps 7, 9, and 10 are steps 8, 11, and 12, and its paragraph placed before step 7 goes before the owner's-answers step. The later stage reconciles the numbers.
- From the drafting calls: the session drops with `--by plan-tests`, since the session acts as /plan-tests. Decided by: the drafting batch g1b.
- From the drafting calls: a fix is mechanical when the failure, the finding, or the owner's words name the whole change. This covers all four mechanical kinds the recommendation names and sends anything else to the planner. Decided by: the drafting batch g1b.
- From the drafting calls: a rename also renames the id in questions and legacy items, and a drop drops the scenario's questions. Otherwise the assembly refuses a question or a legacy entry that names a scenario no planner planned. Decided by: the drafting batch g1b.
- From the drafting calls: a revising planner refiles its unchanged items, as filed, under its new task. The assembler keeps only the items of each planner's latest done task, so an item that is not refiled would leave the plan. Decided by: the drafting batch g1b and `scripts/tests::latest_done`.
- From the drafting calls: the revision rule is one block that three prompts transclude, and a revising agent reads its earlier items by task id. Decided by: the drafting batch g1b.
- From the drafting calls: one revision refile per planner carries all of its judgment fixes. Decided by: the drafting batch g1b (44 findings across about 38 planners in the case behind the issue).
- From the drafting calls: `tests plan` failures name the item and its task, because the rename repair needs the item. Decided by: the drafting batch g1b.
- From the drafting calls: the scenario-list decision carries the sentence "A fix to the proposed list changes only the scenarios it names, …". The edit step and the revision refile keep reviewed scenarios and their ids stable. Decided by: the drafting batch g1a, on the coordinator's word.
- From the drafting calls: the scope, groups, widen, and review work items build on this item's edits to steps 5, 9, and 10 and to the planner prompts. Decided by: the drafting batch g1a. Their stages chain after this one on `SKILL.md` and `core.md`.
- A drop or fold is mechanical only for a scenario the stamp did not record. Dropping the item of a recorded scenario makes the next assembly refuse it with "the stamp recorded it, and the plan says nothing of it". Its fix needs an action (`keep`, `retire`, or a question), which takes the planner's judgment. Decided by: `scripts/tests::plan_failures`.
- A fold treats each folded id as renamed to the kept id: it sets the kept id on each legacy item that names a folded id. It drops each question on a folded id, as a drop does. Decided by: the work item ("a fold drops every folded item but the one it keeps"), with the rename and drop rules above.
- A legacy `adopt` item whose scenario is dropped (not folded) is not edited. The next assembly names it ("adopted into X, which the plan does not adopt"), and re-sorting a test is a judgment fix for its sort agent. Decided by: the mechanical-fix test above, since a finding that drops a scenario does not name the test's new sort.
- The session applies every mechanical fix before it refiles any planner for judgment. The revising agent then reads the fixed items and does not see the dropped ones. Decided by: `Run.items` (dropped items are left out of `item list`) and the revision block, which reads the earlier task's items.
- A revising agent refiles each earlier question with its fields and body, at state `open`. The assembly settles it from the answered question that has the same target. Decided by: `scripts/tests::settled_questions`, which collects answers from every task, and step 6 ("An answer stands for its scenario or program").
- The block's name is `{{TEST-REVISION-RULE}}`, beside `{{TEST-CALL-RULE}}`. Decided by: the sibling block's naming. `checks/token-resolution` requires its `###` heading in `core.md`.
- Assembly messages carry the item as `<item id> (task <task id>)`. A failure that rests on no item ("the stamp recorded it, and the plan says nothing of it", or a test file no sort names) names the scenario or the path. Where the source is a story, it also names the planner task whose key is that story, if one exists. Decided by: the work item ("the item the failure rests on"); such a failure rests on a missing item.
- `plan_failures` gets the item ids from a map the assembly passes in, `origins: {("scenario", id) | ("legacy", path, name) | ("question", id): (item id, task id)}`. The written `-plan.json` stays free of item ids. Decided by: the plan file is stored state that `live_tests`, `stage_write`, `cmd_report`, and `cmd_stamp` read, and none of them needs item ids.

**Changes**
- `skills/plan-tests/SKILL.md`: changed. A new paragraph, "Fixing a planner's items", placed before step 7, gives the one rule for an assembly failure (step 7), a review finding (step 9), and a change the owner asks for at approval (step 10).
  - A fix is mechanical when its words name the whole change: a rename, a drop, a fold of named scenarios, or a wording fix whose new words they give. The session applies it to the planner's items with the tracker's verbs, and the items stay under the planner's task.
  - A rename runs `tasks item set <item> --field id=<new>`, then sets the same id in every question's `scenario` field and every legacy item's `scenario` field that names the old id.
  - A drop runs `tasks item drop <item> --by plan-tests --reason "<the failure or finding>"`, then drops each question on that scenario.
  - A fold drops every folded item but the one it keeps, sets the kept item's body with `tasks item set <item> --body`, and moves legacy references to the kept id.
  - A wording fix runs `tasks item set <item> --body`.
  - Any other fix is a revision refile: `tasks refile <task> --brief "<its brief>; revise task <task>: <each failure or finding that names it>"`, one per planner, after the mechanical fixes. The session drains it.
  - Every finding is marked `resolved` once its fix is applied, by either path, and the session assembles again.
  - Step 5's rule stands for a planner task that closes `partial`.
- `skills/plan-tests/SKILL.md` steps 7, 9, and 10: changed. Each applies a failure, a finding, or an owner's change through that paragraph, in place of "refile the planner … with the failure added to its brief".
- `skills/plan-tests/core.md::{{TEST-REVISION-RULE}}`: new. Where a brief says `revise task <id>`, the agent reads every item task `<id>` filed, from `tasks item list --pool <pool> --json` filtered by `task`, in each pool the prompt records into. It refiles each item under its own task, with the same id, fields, and body, except what a failure or finding in its brief names, and it changes only what each one names. It raises no question on a target the owner already answered.
- `skills/plan-tests/core.md::{{TEST-STORY-PLANNER-PROMPT}}`, `{{TEST-RUNTIME-PLANNER-PROMPT}}`, and `{{TEST-SORT-PROMPT}}`: changed. Each transcludes `{{TEST-REVISION-RULE}}`, on a line of its own, before its Record section.
- `scripts/tests::assembled_plan`: changed. It builds `origins` from each scenario, question, and legacy item it reads.
  - Every refusal it raises names the item and the task: no id, no question target, an unanswered question, a scenario planned twice (both items), an answer naming a scenario no planner planned, and an invalid answer.
  - It drops the advice "refile the planner of each with the failure in its brief" and "refile their planners".
  - It passes `origins` to `plan_failures`.
- `scripts/tests::plan_failures`: changed. It takes `origins`, and every failure that rests on an item names `<item id> (task <task id>)`. The id check stays here, at assembly.
- `.ok-planner/design/decisions/scenario-list-decided-once.md`: the amended decision delta, applied by the stage that lands this item or by the scope or groups item, whichever runs first.

**Behavior changes**
- **B103** `scripts/tests::assembled_plan` and `plan_failures` (`tests plan`). Before: each failure names a scenario id or a path, and several tell the session to refile a planner. After: each names the item and its planner's task, and gives no refile advice. Users: in the release, `SKILL.md` steps 7, 9, and 10, which this item rewrites. No caller parses the text. Ruling: rewrite.
- **B104** `skills/plan-tests/SKILL.md` steps 7, 9, and 10 (`/plan-tests`). Before: each failure, finding, or owner change refiles its whole planner, which plans its story again from the start. After: a mechanical fix edits the planner's items in place, and a judgment fix is one revision refile per planner that keeps every item no fix names. Users: in the release, the session that runs the skill. Across the public surface, the owner who types `/plan-tests`: the command keeps its name and its arguments, and still ends at one approved test sprint and its plan in the same form. Ruling: rewrite in the release. Across the public surface: preserve (call).

### The runtime planner names only scenario ids the assembly check accepts

**Calls**
- (Drafting) The `harm` field keeps `A1` to `A9`. `tests plan` checks that form against the accept list, and only the id must be lower case.
- The id rule reads, in each prompt: "An id is lower-case letters, digits, and hyphens, as `tests plan` requires." The runtime prompt adds that `<part>` and `<class>` are short slugs in that form, such as `dependency-down` for "A dependency goes down". Decided by: `scripts/tests::SLUG`, the pattern `plan_failures` checks.

**Changes**
- `skills/plan-tests/core.md::{{TEST-RUNTIME-PLANNER-PROMPT}}`: changed. Plan step 1 names a new scenario `runtime--<part>--<class>`, and where one part and class carry two harms, ends the id with the harm's entry in lower case, such as `runtime--query-engine--dependency-down--a7`. The id rule stands beside the naming.
- `skills/plan-tests/core.md::{{TEST-STORY-PLANNER-PROMPT}}` and `{{TEST-SORT-PROMPT}}`: changed. Each states the id rule where it names an id.

**Behavior changes**
- **B23** `skills/plan-tests/core.md::{{TEST-RUNTIME-PLANNER-PROMPT}}`. Before: the prompt asks for `runtime--<part>--<class>` with the harm's entry appended, which yields `--A7`, an id the assembly refuses. After: the suffix is lower case, and every prompt states the id rule. Users: in the release: the session's assembly. Across stored state: none, since the assembly never recorded an id outside the pattern. Ruling: rewrite.

### A story planner retires only a scenario the stamp recorded

**Calls**
- (Drafting) The story planner prompt limits `keep` and `rewrite` to a recorded scenario, beside `retire`. The assembler already refuses `keep` for an unrecorded scenario, and rule 8 of the coding rules fixes the whole class.
- The runtime planner prompt stays as it is: it already limits `retire` to a recorded runtime scenario whose part is gone. Decided by: the work item.

**Changes**
- `skills/plan-tests/core.md::{{TEST-STORY-PLANNER-PROMPT}}`: changed. The row reads "The story's text dropped a scenario the stamp recorded. | `retire`". Below the table: "A way the story dropped that no scenario recorded gets no item. `keep`, `rewrite`, and `retire` sort only a scenario the stamp recorded, so a plan with no stamp records only `new` scenarios and gaps."

**Improvements**
- **I1** `scripts/tests::plan_failures`: A8, the cheatsheet's mechanical-checks rule ("Every written constraint needs a check that fails on violation") over the constraint this item writes. The assembly refuses `keep` and `retire` for a scenario the stamp did not record, and accepts `rewrite` for one. Afterward: it refuses `rewrite` the same way, with the message it gives `keep` and `retire`.

**Behavior changes**
- **B24** `skills/plan-tests/core.md::{{TEST-STORY-PLANNER-PROMPT}}`. Before: a first plan's planner can record `retire` for a way the story dropped, which the assembly refuses. After: it records no item for it. Users: in the release: the session's assembly. Ruling: rewrite.
- **B25** (I1) `scripts/tests::plan_failures`. Before: a `rewrite` of an unrecorded scenario assembles and runs as a `new` the plan mislabels. After: it is refused. Users: in the release: the session. Across Trued-up projects: none; the boundary leaves out a planning run in progress. Ruling: rewrite; the check removes only the harm A8 names, so it keeps the contract.

Kickbacks: none.

### A test sprint writes support files first and runs its test tasks side by side

**Calls**
- Notes review: `scenario_brief` prints kind, setup, and entry only where the scenario holds them, since a `retire` holds none. Decided by: `plan_failures` requires the three only on `new` and `rewrite`.
- Notes review: a retirement deletes only its test, and the sweep deletes unused support: `stray_paths` also counts each support path the stamp or the plan records that no live test claims, so a support file outside the test paths, such as `fixtures/data.json`, is deleted once its last test retires. Decided by: the drafting call that places the deletion in the sweep; accept-list A2 forbids leaving it.
- From the drafting calls: the support-first shape gets a new decision, `test-support-written-before-tests`. Decided by: the drafting batch g1b.
- From the drafting calls: support tasks cover every support file a `new` or `rewrite` scenario names, legacy support entries included, and none for `keep`, `adopt`, or `retire`. Only a test task that writes a test needs its helpers written first. Decided by: the drafting batch g1b.
- From the drafting calls: a support task's brief is built from each scenario's outcome, test, and reach, with no new planner field. Decided by: the drafting batch g1b.
- From the drafting calls: a blocked test task reports each missing helper as an item in a new `helpers` pool and closes `blocked`. Decided by: the drafting batch g1b.
- From the drafting calls: the sweep deletes support a retired test leaves unused. Decided by: the drafting batch g1b.
- From the drafting calls: "`--stage write` refuses where the run registers no `support` prompt": it files nothing and names the prompt to register, as the work item says. Only a test sprint an earlier release planned registers none, and the Trued-up projects boundary leaves it out: the owner trues up only between test sprints, and a test sprint not yet executed is brought current before it runs. Decided by: the drafting batch g1b, the work item, and `.ok-planner/release-boundaries.md`.
- From the drafting calls: the summaries of the test sprint in `ok-planner-CLAUDE.md`, `ok-planner-cheatsheet.md`, and the `/plan-tests` description stay as written. Decided by: the drafting batch g1b.
- A support task records the scenarios it serves in `--cites`. A later `--stage write` reads those cites to find a scenario no earlier support task served. Decided by: the tracker's existing `cites` field, so no new task field is needed.
- Keys: the first support task for a file is `support:<path>`. A later one for the same file is `support:<path>:<n>`, with `n` counting that file's support tasks. Decided by: `complete_failures` judges the latest task per (role, key), and each support task must close `done` on its own.
- Helpers round. `--stage write` files a support task for each path that has an open `helpers` item and that no unclosed support task holds. Its brief lists those items by id and body. Then, for each scenario whose latest test task closed `blocked` and filed a `helpers` item, it runs `tasks refile <test task> --after <the support tasks for its files>`. The session does not refile such a test task by hand. Decided by: the work item ("refiles each blocked test task after it") and `{{CEREMONY-RUN-RULES}}`, whose blocked-refile rule would otherwise refile it twice.
- `--stage write` refuses where a scenario's last two test tasks both closed `blocked`, naming them, as a genuine blocker. Decided by: rule 2 (`stage_fix`'s sibling refusal, "closed blocked twice") and rule 4.7 (a retry budget that covers every branch).
- The holders map takes its seed from the unclosed support, test, and legacy tasks. Support tasks are filed first, then test tasks, then legacy tasks, so a legacy task that holds a support file waits on its support task. Decided by: the work item ("One writer still holds each file at a time across support, test, and legacy tasks").
- `tests complete` treats `support` as a holding role: a test path a support task holds or staged is not a stray change. Without this, every support file a support task writes would fail the check "test path changed since the base, and no test, legacy, or sweep task holds it". Decided by: `scripts/tests::complete_failures`.
- `tests report` gains a "Support files" section: each support task's key, outcome, and result, then each `helpers` item with its path, scenario, and state. Decided by: the work item ("`tests complete` and `tests report` check and list them the same way").
- Leave `# @decision: test-support-written-before-tests` above the support filing in `stage_write`. Decided by: the estate's annotation rule.

**Changes**
- `scripts/tests::stage_write`: changed.
  - It reads the run's registered prompts (`tasks dump --type prompt`). Where `support` is missing, it refuses, files nothing, and names the `support` prompt to register, as the work item says.
  - Otherwise it builds, for each support file, the `new` and `rewrite` scenarios that name it, from their `support` field and the plan's legacy `support` entries. It files one `support` task per file (`--files <path>`, `--cites <scenario ids>`, brief: `scenario_brief` of each scenario), waiting on that file's holder.
  - It files a later support task for a file that a scenario names where that scenario has no test task yet and no earlier support task cites it.
  - It files one test task per written scenario. The task holds its test path, plus the old path for a rewrite at a new path, and waits on the latest support task for each of its support files and on the holder of each file it holds.
  - Then it files legacy tasks as today, through the same holders map.
  - Then it runs the helpers round and the twice-blocked refusal from the calls above.
  - Its JSON output lists support tasks and refiles beside the rest.
- `scripts/tests::file_task`: changed. Takes `cites`, passed as `--cites`.
- `scripts/tests::RUN_ROLES` and `CHANGING_ROLES`: changed. Both gain `support`.
- `scripts/tests::complete_failures`: changed. The latest support task for each key must close `done`, and the latest round must run after it. Each open `helpers` item is a failure (`helpers item <id> (<path>) stands open`). A support task's files and staged paths count as held in the base check and in the round-hash check.
- `scripts/tests::cmd_report`: changed. Adds the "Support files" section.
- `skills/plan-tests/core.md::{{TEST-SUPPORT-PROMPT}}`: new, as the work item states it. It reads the scenarios in its brief, the code each reach names, and the file as it stands. It writes every helper those tests need to reach the public entry point and to set up and tear down in a `mktemp -d` folder or on a stack run. It keeps every helper a live test uses, writes no test, no product code, and no comment, adds each `helpers` item its brief names and marks it `added`, stages its file, and closes `done`.
- `skills/plan-tests/core.md::{{TEST-WRITE-PROMPT}}`: changed, as the work item states. The task reads its support files and changes none of them. For a missing helper, it records `tasks item add --pool helpers --key <support path> --field path=<support path> --field scenario=<id> --body "<the helper and what it must do>"`, writes no test, and closes `blocked`. A retirement deletes only the test.
- `skills/plan-tests/core.md`, intro: changed. The run-prompt count gains the support prompt, in the same edit as the other planners' count changes.
- `skills/plan-tests/test-sprint-document.md`:
  - Step 4: changed. Registers `{{TEST-SUPPORT-PROMPT}}` as `support`, and adds `"helpers": ["open", "added"]` to `item_states`.
  - Step 5: changed. `--stage write` files the support, test, and legacy tasks. Drain, and repeat `--stage write` and the drain until it files nothing. A test task that closes `blocked` with a `helpers` item is refiled by `--stage write`, not by hand. Then the ports, then the sweep.
  - Completion contract items 1 to 3: changed. Support tasks join the task list, item 2 adds "no `helpers` item stands open", and item 3 counts support tasks among those the latest round ran after.
  - The opening paragraph: changed. "file the support, test, and legacy tasks".
- `CLAUDE.md` (the family's), the `skills/plan-tests/` layout line: changed. Names the support prompt among the run prompts.
- `.ok-planner/design/decisions/test-support-written-before-tests.md` and the amended `team-execution-cold-gate.md`: the deltas, with `.ok-planner/design/decisions.md` regenerated.

**Improvements**
- **I101** `scripts/tests::complete_failures` (twice) and `scripts/tests::stage_write` (`holders_of`): the maintenance cost. The tuple of roles that hold test files is written at three sites (`("test", "legacy", "sweep")` twice, and `("test", "legacy")`), and this work item must add `support` to each. Afterward one constant, `HOLDING_ROLES = ("support", "test", "legacy", "sweep")`, serves all three, and `holders_of` takes it with `sweep` removed, since a sweep runs after the write stage.

**Behavior changes**
- **B105** `scripts/tests::stage_write` (`tests tasks --stage write`). Before: one test task per written scenario holds its test file and every support file, and tasks that share a support file run in one chain. After: one support task per support file runs first, test tasks hold only their test files, wait on those support tasks, and run side by side, and a later call files helper rounds and refiles blocked test tasks. A run that registers no `support` prompt is refused, as the work item says. Users: in the release, `test-sprint-document.md` step 5, which this item rewrites. Across Trued-up projects: none; the boundary leaves out a test sprint an earlier release planned, whether in execution or not yet executed, and one not yet executed is brought current before it runs. Ruling: rewrite.
- **B106** `scripts/tests::complete_failures` and `cmd_report` (`tests complete`, `tests report`). Before: the contract and the report know the test, legacy, sweep, fix, and verify roles. After: they also require each support task done and no `helpers` item open, and they list both. Users: in the release, the test sprint's completion contract and step 7, which this item rewrites. Across stored state: an archived test sprint's run file and plan, which `tests report` still reads: its run holds no support task and no `helpers` item, so its report lists none, and `tests complete` reads an archived test sprint with a `closed:` stamp as terminal and runs no check. The boundary leaves out an open test sprint planned earlier. Ruling: rewrite in the release. Across stored state: preserve (call).
- **B107** `skills/plan-tests/core.md::{{TEST-WRITE-PROMPT}}`. Before: a test task edits its support files, and a retirement deletes each support file no other test uses. After: it changes no support file, reports a missing helper and closes `blocked`, and a retirement deletes only its test. Users: in the release, the run step 4 opens, which registers the prompt. Across Trued-up projects: none; the boundary leaves out an open test sprint, whose run is in execution or not yet opened, and one not yet executed is brought current before it runs. Ruling: rewrite.

**New surface**
- The `support` role and prompt, the `helpers` pool, and `{{TEST-SUPPORT-PROMPT}}`, declared in `scripts/tests`, `skills/plan-tests/core.md`, and `skills/plan-tests/test-sprint-document.md`: internal.

### Documentation follows its docspec's reader and coverage

**Calls**
- From drafting: the edit decision states the rewrite as its own sentence after the rule list, so the list stays parallel. Decided by: the recommendation's "in the shape of its layout rule", which sets the rule's wording, and the list's form, which sets where the rewrite sentence goes.
- From drafting: the edit decision's Rationale and Alternatives name the tradeoff: more rewritten prose, resting on a judgment of what departs, against the option not taken. Decided by: the issue's one option, which states that cost, and the decision template, which requires a tradeoff.
- From drafting: the reader-and-coverage rule fires on any departure, not only where `## Reader` or `## Covers` changed since the stamp. Decided by: every other rule fires on a file's state, and the issue names a docspec newly declared over existing documentation as the same gap.
- From drafting: the new rule's row sits after the shape and layout row. Decided by: the order the decision lists the rules in.
- The table gets a seventh row in total, placed sixth: after the shape and layout row, and before the row for a claim the tree cannot settle. Decided by: the work item ("a seventh row after the shape and layout row") and the decision's order.
- `{{DOC-WRITE-PROMPT}}` gets no text of its own. Its Read step 1 already sends the writer to `## Reader` and `## Covers` ("say what the file holds and for whom"), and the row reaches it through `{{DOC-EDIT-RULES}}`. Decided by: the work item.
- `{{DOC-STYLE-PROMPT}}` and `{{DOC-CHECK-PROMPT}}` stay as written. The style pass changes no claim, and the checker checks every claim in a file the run changed, which covers a rewritten passage. Decided by: decision:documentation-claim-ledger.
- The planner's step 3, for a docspec with no stamp, covers a newly declared docspec through steps 1 and 2. It gets no new text. Decided by: the work item.
- Rule 1 enumeration of the sites that restate the rule set: `ok-planner/skills/plan-docs/core.md::{{DOC-EDIT-RULES}}` (the one table), `.ok-planner/design/decisions/documentation-edits-only-where-a-rule-fires.md` (the delta). `ok-planner/scripts/ok-planner-CLAUDE.md` and `ok-planner/scripts/ok-planner-cheatsheet.md` say only "writers edit only where a rule fires", which stays true. Count: 2 sites.

**Changes**
- `.ok-planner/design/decisions/documentation-edits-only-where-a-rule-fires.md`: changed, the sidecar's body applied verbatim. `.ok-planner/design/decisions.md`: regenerated with `python3 .ok-planner/bin/catalog-toc`.
- `ok-planner/skills/plan-docs/core.md::{{DOC-EDIT-RULES}}`: changed. A new row after "A file departs from the docspec's `## Shape`, or from the layout its `## Where` states.": rule "A file departs from the docspec's `## Reader` or `## Covers`: it addresses another reader, covers what the docspec leaves out, or omits what the docspec covers.", edit "Rewrite the passage that departs." Every row a writer applies now includes this one, and so does each `rule` field it records.
- `ok-planner/skills/plan-docs/core.md::{{DOC-PLANNER-PROMPT}}`, Inputs: changed. One sentence after "Read the files under the docspec's `## Where` as they stand.": judge each file against the docspec's `## Reader` and `## Covers`.
- `ok-planner/skills/plan-docs/core.md::{{DOC-PLANNER-PROMPT}}`, The plan step 1: changed. The facts that fire a rule gain "a passage that addresses another reader than `## Reader` names, covers what `## Covers` leaves out, or omits what it covers". A file a rule fires on stays a `change`. The step count stays at seven.

**Behavior changes**
- **B201** `ok-planner/skills/plan-docs/core.md::{{DOC-EDIT-RULES}}`. Before: a writer leaves a passage that addresses the wrong reader, or covers too much or too little, as written, unless another rule fires on it. After: the writer rewrites that passage and records the edit under the new rule. Every other sentence stays.
  Users: in the release: `{{DOC-PLANNER-PROMPT}}` and `{{DOC-WRITE-PROMPT}}`, which transclude the table, and `/plan-docs`. Across trued-up projects: none. The boundary leaves out an open documentation sprint planned under the earlier release: the owner trues up only between documentation sprints, and one not yet executed is brought current before it runs.
  Ruling: rewrite.
- **B202** `ok-planner/skills/plan-docs/core.md::{{DOC-PLANNER-PROMPT}}`. Before: a file whose only fault is its reader or coverage is a `check` or no item. After: it is a `change` whose Rules field names the departure, so the documentation sprint files a writer for it. The plan the owner approves carries more `change` items.
  Users: in the release: `/plan-docs` step 3, which dispatches the prompt in session. No copy of the prompt is stored.
  Ruling: rewrite.

### Documentation planning drops or checks the files a retired or moved docspec left

**Calls**
- Build note: where `docspec_at` returns `None` for a standing docspec whose stamp commit lacks the file, `left` and `taken` are both empty, as for a docspec read at no stamp.
- From drafting: the check of a newly covered file reaches every file a standing docspec covers now and did not cover at its stamp. That set includes every file a retired or moved docspec left that a standing docspec now covers, which the recommendation names. It also includes files a widened `## Where` reaches for the first time. Each docspec's own entry computes the set, so no lookup across docspecs is needed. Decided by: the narrower set would leave the newly reached files unchecked.
- From drafting: decision:documentation-claim-ledger is amended as well. Decided by: under its current Choice, a check of an unchanged file with no ledger claims checks nothing, which would leave the recommendation's check empty.
- From drafting: story:keep-documentation-current stays as written. Decided by: the ruling reads "every document my project keeps" as covering files a retired docspec left, and the decision that delivers the story carries that reading.
- From drafting: a retired docspec with no stamp, or with a stamp the repository no longer holds, is read at the last commit that holds its file. Decided by: that commit is the nearest record of where its documentation lived, and the window rule for an unheld stamp already falls back to the best record the repository holds.
- From drafting: a file a retired or moved docspec left, which another standing docspec covers, is an item of that standing docspec: a `taken` file, or no item where its `## Where` already covered the file at its stamp. Decided by: the recommendation's "a check for each file a standing docspec now covers"; the covering docspec's rules govern the file from then on.
- From drafting: a drop under an `in code:` docspec removes doc comments and keeps the source file. Decided by: the file holds code that no documentation sprint may delete.
- From drafting: the planner of a retired `in code:` docspec drops the generator output that its `## Generator` said is committed. Decided by: that output is documentation the docspec left, and only the planner can read where the prose put it.
- From drafting: a retired docspec's run state goes at `docs stamp`, not at planning. Decided by: the recommendation keeps planning running while run state stands, so the state must outlive the plan until its run is committed.
- From drafting: the window's new status is `retired`, and its lists are `left` and `taken`. Decided by: these names follow the window's existing one-word statuses.
- Every window entry carries `left` and `taken`, empty where none, and a retired entry also carries `commit`, the commit the tool read the docspec at. A non-empty list adds a reason line, `left: <file>, ...` or `taken: <file>, ...`, so the documentation sprint's Window section, which copies each reason, names the files. The executor reads that section in boilerplate step 7 to learn which `check` items need every claim checked. Decided by: the work item ("a non-empty list is a reason") and the template's Window line ("each reason `.ok-planner/bin/docs window` gave").
- A retired entry also carries the reason `retired: .ok-planner/docspec/<slug>.md is gone; read at <commit>`, with `sprints` empty and `stale_claims` 0. Its planner plans drops only, so it reads no closed sprint and no ledger. Decided by: the work item ("skips `docs claims`").
- The last commit that holds a gone docspec's file is `HEAD` where `HEAD` holds it (a deletion not yet committed). Otherwise it is the first parent of the commit `git rev-list -1 HEAD -- <path>` names, the commit that deleted it. Where no commit ever held the file, the entry stands `retired` with `commit: null`, empty lists, and a reason saying no commit holds the docspec. Its planner returns no item, its heading carries the `No item` line, and the stamp removes its run state. Decided by: the work item's fallback rule, and the window's sibling rule for an unheld stamp, which plans from the best record the repository holds.
- The tool reads a docspec at a commit only after a `git cat-file -e <commit>:<path>` probe, in the shape of `cmd_example`, because `git()` raises on a missing path. A probe that fails falls back as the previous call says. Decided by: plumbline-coding rule 2 (the sibling at `docs::cmd_example`) and rule 4.3 (the probe takes a different branch).
- `docs` lists the tree with its own `git ls-files --cached --others --exclude-standard`, kept to files that exist, and a commit's tree with `git ls-tree -r --name-only <commit>`. `tests::tree_files` holds the same two-line listing. Decided by: the cheatsheet's "Do not extract trivia" rule. The closed-stamp item's shared module is the place to move it, should a later change need a third copy.
- Coverage uses the window's own `matches(path, entry)` for every Where form: one file, a folder ending in `/`, and `in code:` paths and globs. Decided by: rule 6 (import, never copy).
- `docspec_slugs` lists only run states whose filename is a slug (`SLUG`) and ends in `.json`. A state file whose `docspec` field does not match its name still raises `read_state`'s existing refusal. Decided by: `read_state`, which only the tool writes, so a malformed one ends in its refusal under the accept list's "malformed value from inside the system" standing.
- The planner of a retired docspec plans `drop` items only. It returns `none` for unexplained changes, the example draft, and the reshape, and these words go in the prompt's Inputs, so no numbered step is added. Decided by: the work item ("gains no numbered step"), and the SKILL's worked-example question, which skips a retired docspec.
- The planner lists drop items for `left` files after the layout's files. Decided by: the Output's order rule ("ordered as the layout orders the files"), which a file outside the layout cannot follow.
- A drop under an `in code:` docspec keeps its file, and the writer changes it, so boilerplate step 6 and `complete_failures` exempt `drop` items from the style pass. Otherwise a style task would be filed for a file with no doc comments left, against a docspec that may be gone. Decided by: the style pass reads the docspec whole (Read step 1), and a drop leaves no documentation to style.
- The writer of a drop under a retired docspec reads the docspec at the commit its brief names. Boilerplate step 5's brief names that commit for each item of a docspec the window shows `retired`. Decided by: the writer needs the Where's `in code:` form to choose between `git rm` and removing doc comments.
- `docs stamp` computes every state and every removal before it writes. It then writes the states, removes each retired docspec's run state, and adds the sprint's `closed:` stamp last. A rerun after a crash finds a retired slug with no docspec and no state and removes nothing. Decided by: plumbline-coding rule 3.1 (the stamp keeps the sprint's mark as the last write, as `cmd_stamp` does now).
- `{{CEREMONY-ARCHIVE}}` step 3 says to stage what the stamp command wrote and each path it printed as removed. `git add <path>` on a removed tracked path stages the removal. Decided by: the work item ("prints each path it removed so the archive step stages the removal").

**Changes**
- `.ok-planner/design/decisions/docspec-stamp-opens-the-window.md` and `.ok-planner/design/decisions/documentation-claim-ledger.md`: changed, the sidecar bodies applied verbatim. `.ok-planner/design/decisions.md`: regenerated.
- `ok-planner/scripts/docs::docspec_slugs`: changed. Returns the standing slugs (each `.md` under `.ok-planner/docspec/`) and the retired slugs (each `<slug>.json` under `.ok-planner/doc-state/` with no docspec file).
- `ok-planner/scripts/docs::docspec`: changed. It reads the file and hands the text to a new `parse_docspec(slug, text)`, which holds today's parse unchanged. New `docspec_at(root, slug, commit)` reads the docspec at a commit through the probe and `git show`, and returns `None` where the commit lacks the file.
- New `ok-planner/scripts/docs::tree_files(root)`, `files_at(root, commit)`, `covered(files, spec)` (the files any `where` entry matches), and `last_holding_commit(root, rel)`.
- `ok-planner/scripts/docs::window_entry`: changed. It takes the set of files the standing docspecs cover now, which `cmd_window` builds once. For a standing docspec whose stamp the repository holds, it reads the docspec at the stamp. `left` holds the files that Where covered at the stamp that the tree still holds, that the current Where does not cover, and that no other standing docspec covers. `taken` holds the tree's files under the current Where that the Where at the stamp did not cover. Each non-empty list adds its reason and makes the docspec `reached`. A new `retired_entry(root, slug, state, covered)` builds the retired entry: the docspec read at its stamp where the repository holds the stamp and the file, else at `last_holding_commit`, and `left` holding the files that Where covered at that commit that the tree still holds and no standing docspec covers.
- `ok-planner/scripts/docs::cmd_window`: changed. It prints the standing entries, then the retired ones. The text form prints `read at: <commit>` for a retired entry, with the `left:` and `taken:` reason lines. It prints the no-documentation line only where no docspec and no run state stands.
- `ok-planner/scripts/docs::USAGE`: changed. `docs window` covers each run state whose docspec is gone, the `retired` status, and the `left` and `taken` lists. `docs stamp` removes a retired docspec's run state.
- `ok-planner/scripts/docs::cmd_stamp`: changed. For a planned slug with no docspec file it skips `checked_slug` and the ledger, removes `.ok-planner/doc-state/<slug>.json` where it stands, and prints `removed: .ok-planner/doc-state/<slug>.json (docspec:<slug> is retired)`. Every other slug is stamped as now (see I202).
- `ok-planner/scripts/docs::complete_failures`: changed. The generator check skips a planned slug with no docspec file and raises nothing on it. The style-task requirement skips `drop` items.
- `ok-planner/skills/plan-docs/SKILL.md`, step 1 Layout: changed. It stops only where `.ok-planner/docspec/` holds no docspec and `.ok-planner/doc-state/` holds no run state.
- `ok-planner/skills/plan-docs/SKILL.md`, step 2 Window: changed. It names `retired` ("its docspec is gone and its run state stands: its planner drops the files it left"), and the count line counts retired docspecs.
- `ok-planner/skills/plan-docs/SKILL.md`, step 4, the worked-example bullet: changed. It skips a docspec whose entry stands `retired`.
- `ok-planner/skills/plan-docs/SKILL.md`, step 5 Draft: changed. A retired docspec keeps its `### docspec:<slug>` heading. Where its planner returned no item, the heading carries the `No item` line, so the stamp removes its run state.
- `ok-planner/skills/plan-docs/core.md::{{DOC-PLANNER-PROMPT}}`, Inputs: changed. A retired entry's docspec is read with `git show <commit>:.ok-planner/docspec/[SLUG].md` at the commit the entry names. `docs claims` is skipped, and the planner returns `none` for unexplained changes, the example draft, and the reshape. The `left` and `taken` lists are read from the entry.
- `ok-planner/skills/plan-docs/core.md::{{DOC-PLANNER-PROMPT}}`, step 1: changed. Each `left` file is a `drop`. Where a retired `in code:` docspec's `## Generator` said its output is committed, that output is a `drop` too. A `taken` file a rule fires on is a `change`.
- `ok-planner/skills/plan-docs/core.md::{{DOC-PLANNER-PROMPT}}`, step 2: changed. Any other `taken` file is a `check`, and every claim in it is checked.
- `ok-planner/skills/plan-docs/core.md::{{DOC-WRITE-PROMPT}}`: changed. Read step 1 reads a gone docspec at the commit the brief names. Close: a drop under an `in code:` docspec removes the doc comments on the file's declarations, changes no code, keeps the file, and stages it with `git add`. Any other drop runs `git rm`.
- `ok-planner/skills/plan-docs/core.md::{{DOC-CHECK-PROMPT}}`: changed. The brief's every-claim list gains "in a file the docspec did not cover at its stamp".
- `ok-planner/skills/plan-docs/doc-sprint-document.md`, boilerplate step 5: changed. The brief of an item under a docspec the window shows `retired` names the commit the docspec is read at. Step 6: changed. The style pass lists the files of `write` and `change` items only. Step 7: changed. The checker brief's every-claim list gains "or the item is a `check` of a file the docspec's `taken` reason names". Completion contract item 1: changed. Every file the run changed that still exists has a style task, except the file of a `drop` item.
- `ok-planner/skills/_shared/artifact-definitions.md::{{DOCSPEC-DEFINITION}}`, the run-state bullet: changed. A retired docspec's run state stands until the documentation sprint that passes the files it left is stamped.
- `ok-planner/scripts/ok-planner-CLAUDE.md`, "Only a documentation sprint writes documentation." paragraph: changed. The window also finds each docspec retired or moved since its stamp.
- `ok-planner/skills/_sprint/shared.md::{{CEREMONY-ARCHIVE}}` step 3: changed. "Stage what it wrote, and each path it names as removed, by name, and commit that alone."

**Improvements**
- **I202** `ok-planner/scripts/docs::cmd_stamp`: A9. The ledger it writes keeps a claim about a file the docspec no longer covers, such as a `left` file another docspec has taken, as long as the file exists. Each later window then counts that claim among the docspec's `stale_claims`, marks the docspec `reached`, and hands its planner a claim to check again in a file outside its Where. Afterward: `cmd_stamp` passes `ledger_after` only the prior claims whose file the docspec's current `## Where` covers. The ledger holds claims only about files under the docspec's own Where.

**Behavior changes**
- **B203** `ok-planner/scripts/docs::cmd_window`, `window_entry`, `docspec_slugs`. Before: the window lists only docspecs whose file stands. A docspec deleted since its stamp drops out silently, its files stay behind, and its run state stays forever. A project with run state but no docspec prints "the project declares no documentation". After: each such run state yields a `retired` entry with `commit` and `left`. Every standing entry carries `left` and `taken`, and each non-empty list is a reason. The no-documentation line prints only where neither a docspec nor a run state stands.
  Users: in the release: `/plan-docs` steps 1 to 3, and `{{DOC-PLANNER-PROMPT}}` through `[WINDOW ENTRY]`. Across trued-up projects: each `.ok-planner/doc-state/<slug>.json` an earlier release wrote, which this release reads.
  Ruling: migrate: the run state's format is unchanged and needs no conversion. A state an earlier release left for a docspec since deleted now reads as a retired docspec, at its stamp or the last commit that holds its file (call). Decided by: decision:docspec-stamp-opens-the-window as amended ("Planning runs while any docspec's run state stands").
- **B204** `ok-planner/scripts/docs::cmd_stamp`. Before: a planned docspec whose file is gone makes `checked_slug` refuse ("no docspec at ..."). The stamp exits 1, writes nothing, and adds no `closed:` mark. After: the stamp removes that docspec's run state, prints each removed path, and stamps the rest.
  Users: in the release: `{{CEREMONY-ARCHIVE}}` step 3, as the documentation sprint's archive names it. Across trued-up projects: no documentation sprint an earlier release planned holds a retired docspec, since that window never listed one.
  Ruling: rewrite.
- **B205** `ok-planner/scripts/docs::complete_failures`. Before: a planned docspec whose file is gone makes `docspec()` raise, and `docs complete` exits 1 with `docs: no docspec at ...`. The file of an `in code:` drop, if kept, needs a style task. After: neither is checked for a retired docspec, and a `drop` item's file needs no style task.
  Users: in the release: boilerplate step 8 and the `/goal` checker. Across trued-up projects: an open documentation sprint's drop items were each `git rm`, so the file no longer exists and no style task was needed. Its verdict is unchanged.
  Ruling: rewrite.
- **B206** `ok-planner/skills/plan-docs/SKILL.md` steps 1, 2, 4, and 5. Before: `/plan-docs` stops at Layout where no docspec stands, and a retired docspec never enters a plan. After: it runs while any run state stands, plans each retired docspec, asks no worked-example question for one, and keeps its heading in the documentation sprint.
  Users: in the release: the owner running `/plan-docs`, which keeps its name and arguments. The vendored copy changes on `/ok`.
  Ruling: rewrite.
- **B207** `ok-planner/skills/plan-docs/core.md::{{DOC-PLANNER-PROMPT}}`. Before: the planner reads only the docspec as it stands and plans no item for a file outside the current Where. After: it plans a `drop` of each `left` file and of a retired `in code:` docspec's committed generator output, a `change` or `check` of each `taken` file, and, for a retired docspec, reads the docspec at the entry's commit.
  Users: in the release: `/plan-docs` step 3.
  Ruling: rewrite.
- **B208** `ok-planner/skills/plan-docs/core.md::{{DOC-WRITE-PROMPT}}`. Before: every drop runs `git rm <file>`, so a drop under an `in code:` docspec would delete a source file. After: that drop removes only the file's doc comments and stages the file. Every other drop runs `git rm` as before.
  Users: in the release: documentation sprints planned from now on. Across trued-up projects: none; the boundary leaves out an open documentation sprint.
  Ruling: rewrite. The change removes only the A2 harm of `git rm` on a source file, which no caller may rely on.
- **B209** `ok-planner/skills/plan-docs/core.md::{{DOC-CHECK-PROMPT}}`. Before: a checker briefed on a file newly under a docspec, with no ledger claims there, checks only the claims its brief lists by id, which may be none. After: it checks every claim in such a file.
  Users: in the release: boilerplate step 7's checker tasks. Across trued-up projects: an open documentation sprint's briefs name no `taken` file, so its checkers do as before.
  Ruling: rewrite.
- **B210** `ok-planner/skills/plan-docs/doc-sprint-document.md`, boilerplate steps 5, 6, and 7 and contract item 1. Before: a style task is filed for every changed file, and the checker brief has no every-claim case for a newly covered file. After: drop items get no style task, a retired docspec's briefs name the commit, and a `taken` check is checked whole.
  Users: in the release: documentation sprints `/plan-docs` writes from now on, which copy the boilerplate verbatim. Across trued-up projects: none; the boundary leaves out an open documentation sprint, which is brought current before it runs.
  Ruling: rewrite.
- **B211** `ok-planner/skills/_sprint/shared.md::{{CEREMONY-ARCHIVE}}` step 3. Before: stage what the stamp wrote. After: stage that and each path it printed as removed. A test sprint's `tests stamp` removes nothing, so its archive is unchanged.
  Users: in the release: the archive steps of `doc-sprint-document.md` and `test-sprint-document.md`, which name the block, and every open documentation or test sprint, which reads it from the vendored `shared.md` when it archives.
  Ruling: rewrite.
- **B212** (I202) `ok-planner/scripts/docs::cmd_stamp`. Before: a moved docspec's ledger keeps claims about files it left while they exist. After: the stamp drops them, and the docspec's next window counts no stale claim outside its Where.
  Users: in the release: `docs window` and `docs claims --stale`. Across trued-up projects: a ledger an earlier release wrote loses those claims at its next stamp, as decision:documentation-claim-ledger's "a ledger claim that should have been checked and was not leaves the ledger" already allows.
  Ruling: migrate: the next stamp rewrites the ledger. No conversion is needed, and the ledger loses only claims about files outside the docspec (call).

### /ok-version's story promises the installed plugin version

**Calls**
- (drafting) The see-governing-versions story carries the reload fact as a second sentence beside the story sentence, not in the capability clause, because the one-need test fails a clause that names two capabilities. The title changes because "governs" no longer names the version shown. Decided by: the drafting batch. Note: the sidecar `stories/see-governing-versions.md` as it stands carries the story sentence alone, and the build applies the sidecar as written.
- (drafting) `/ok-version` gains only the story annotation. Its text already reports the installed version under the label the recommendation keeps, and already states the reload. Decided by: the drafting batch.
- The description, the opening paragraph, and step 1 stay word for word. The description already says "the installed ok plugin version". In the opening paragraph, "that **this session** is running" attaches to the conduct version alone. Step 1 already reads the installed version and states the reload. Decided by: the work item's "keeps its behavior as it stands", and the drafting call above.
- The annotation is the line `<!-- @story: see-governing-versions -->`, alone, with a blank line on each side, directly above `### 1. Installed plugin version`. Decided by: the sibling form at `plugins/ok/skills/ok/SKILL.md:50` (`<!-- @story: … -->` above a step heading), and the `@story:` citation declared in `.ok-planner/config.json`.

**Changes**
- `plugins/ok/families/ok-planner/skills/ok-version/SKILL.md`: changed. It gains the annotation line above step 1, and no other line changes.
- `.ok-planner/design/stories/see-governing-versions.md`: changed, by the story delta: the new title and the new story sentence. `.ok-planner/bin/catalog-toc` then regenerates `.ok-planner/design/stories.md`, whose line for the story still quotes the old sentence.

**Behavior changes**
None. Every change is new code no existing user reaches.

### A declined second /ok plan backs out the answer that made it destructive

**Calls**
- Build note: on a project where no tracker run has made `.ok-planner/.cache/` yet, true-up writes `.cache/.gitignore` when it creates the folder for `true-up-answers.json`, as `tasks` does, so the record never shows as untracked.
- (drafting) The back-out finds the answers that made the second plan destructive by trial. It restores each answer in turn and plans again. It keeps the restore where the plan lost a destructive step, and puts the answer back where the plan lost none. Decided by: the recommendation names the answer to back out but not how to tell which one it is, and trial is the one method that needs no map from configuration keys to rendered files.
- (drafting) The record of replaced bytes lives under `.ok-planner/.cache/`, and each applied plan clears it. A restore runs only where the file still holds what the answer wrote. Decided by: rule 3.7, and the machine-local folder holds suite state, not the owner's work.
- (drafting) A `rule-file` answer is never backed out. That answer writes one file and removes or archives another, and the recommendation's flip case says a back-out that touches other files is not safe.
- (drafting) Where the back-out restores some answers and a destructive step remains, `/ok` reports `trued up; plan steps pending: <d>`, with the restored answers declined. Decided by: all-or-none forbids applying part of that plan.
- (sign-off) decision:true-up-asks-once-before-destructive-steps says an answer true-up cannot restore on its own stands, and the second plan's steps then stay pending. Decided by: the accepted recommendation's flip case and the work item's exemptions.
- The trial re-plans in a child process: `subprocess.run(["bash", core, "diagnose"], cwd=root, capture_output=True, text=True)`. The destructive steps are the stdout lines that start `DESTRUCTIVE: `. The core can plan only once per process, because `exp`, `COLLIDED`, and every `functools.lru_cache` plan function (`lint_config_plan`, `rewrite_plan`, `script_plan`, and the rest) are computed once. Diagnose's output is the contract `/ok` already reads. Decided by: the code as it stands.
- The trial runs the answers newest first. A restore needs the file to still hold what that answer wrote, so an earlier answer to the same file can be restored only after every later one. Decided by: the restore condition the work item states.
- A restore is kept only where the re-planned destructive step lines lose at least one line of the plan before the restore and gain none. Otherwise the answer is put back. A restore that adds a destructive step would leave a plan the bare true-up still refuses. Decided by: the work item's "runs the bare true-up where that plan holds no destructive step".
- The trial writes the restore, re-plans, and puts the answer back inside one `try/finally`. The `finally` rewrites the answer's bytes on every exit except a kept restore, so a raise during the re-plan never leaves an answer silently backed out. Decided by: rule 4.2.
- A `settings` answer is never tried. No plan step reads `.claude/settings.json`: the wiring is outside the plan, and the plan id covers no wiring. So a settings answer can never make a plan step destructive. Leaving it out also keeps the integration contract's rule that only `wire-hooks`, `wire-env`, and the `settings` resolve write that file. Decided by: `build_plan` in the code, and `docs/integration-contract.md` "The administration files".
- The record is one JSON file, `.ok-planner/.cache/true-up-answers.json`, declared as `ANSWER_RECORD = os.path.join(CACHE_DIR, "true-up-answers.json")`. It holds a list of entries, oldest first. Each entry holds `id` (the question id, or `amend:<config path>`), `path` (from the project root), `before` (the prior text, or null where no file stood), `digest` (the sha256 of the bytes written), and `restorable` (false, with a `why`, for `rule-file` and `settings` answers and for a prior file that did not decode as UTF-8). The core writes it through `write_owner`. Decided by: the work item ("the bytes each write replaced"), `write_owner` (the one temporary-file-and-rename writer), and the core's text-only owner writes.
- The owner file is written first and the record entry second. A crash between the two leaves an answer that the back-out cannot see, and that answer stands, as every answer stands today. Decided by: rule 3, judged by which direction stays safe.
- Where an answer created its file (`citation-tags` with no config), the restore removes the file. It does so only where the file still holds what the answer wrote. Decided by: the work item's "restores each file that answer replaced to the bytes it held before".
- The back-out restores only a path that some answer kind names: `.ok-planner/config.json`, `.ok-planner/review/config.json`, or `.ok-planner/review/project.md`. It refuses a record entry that names any other path. Decided by: accept-list A2, and the owned set `checks/owned-paths` enforces.
- The back-out drops each restored entry from the record. A second back-out then restores nothing twice. Decided by: rule 3.7.
- Output lines are `backed out: <id> — restored <path>`, or `backed out: <id> — removed <path>` for a created file. They are followed by one `stands: <id> — <why>` line per answer the back-out could not restore. Where it restores nothing, it prints the one line `backed out: nothing — no answer made plan <id> destructive; every answer stands`. It exits 0, and on a refusal it exits 1 with `back-out: <reason>; nothing written`. Decided by: the work item's two line forms. The `stands:` lines carry the "only such an answer did" case of the decision delta to the report.
- The record is cleared after the last action of an applied plan: `--go-ahead`, and a bare true-up that applies. A failed apply leaves the record for the next pass. Decided by: the work item's "Each plan the core applies clears that record."
- The INPUT NEEDED blocks the bare true-up prints again for backed-out answers are recorded as declined in that pass, not asked again. Decided by: the work item's "records each backed-out answer as declined", and the decision delta's "the declined answer waits for the next run".
- Where `back-out` refuses with `the plan changed since diagnose`, `/ok` runs diagnose again, shows the new plan, and asks the same one question about it, as step 4.6 does for `--go-ahead`. Decided by: the sibling step 4.6.

**Changes**
- `plugins/ok/families/ok-planner/admin/true-up` (bash prelude): changed. `USAGE` names `back-out PLAN_ID`, and the mode `case` accepts `back-out`. The `vendor_layer "$MODE" "${@:2}"` branch carries it to the python.
- `true-up::ANSWER_RECORD`, `read_record`, `write_record`, and `clear_record`: new. The record's one reader and its writers, all under `CACHE_DIR`.
- `true-up::answer_write(answer_id, path, text)`: new. It reads the prior text and the prior file's state, calls `write_text`, then appends the entry. Every `resolve_question` branch that writes a project file calls it in place of `write_text`/`write_json`, and so does `amend` in place of its `write_owner(target, text)`. The `rule-file` branch and the `settings` branch append a non-restorable entry and keep their own writes.
- `true-up::apply_plan`: changed. After its last action it calls `clear_record()`.
- `true-up` `if mode == "back-out":` block: new. It checks the argument with `PLAN_ID`. It refuses `the plan changed since diagnose; run diagnose again; nothing written` where `plan_id(build_plan()) != <id>`. It then runs the trial loop above through `write_owner`, or `os.remove` for a created file, and prints its lines.
- `plugins/ok/families/ok-planner/admin/ADMINISTRATION.md`: changed in four places. The modes block gains `bash admin/true-up back-out <plan id>`, with a paragraph on its refusal, its trial, its lines, and its limits (rule-file and settings answers, and a changed file). "Input questions" gains a sentence: `resolve` and `amend` keep the replaced bytes in `.ok-planner/.cache/true-up-answers.json`, and each applied plan clears the record. "**Abort.**" under "The plan" gains the second-plan rule. "What the administration does NOT do here" names the record and the back-out's restores among the writes, both through the rename.
- `plugins/ok/skills/ok/SKILL.md`: changed. The modes list (line 12) gains `back-out <plan id>`. Step 5.4's "On abort" sentence becomes the back-out flow: run `back-out <plan id>`, relay its lines, record each backed-out id as declined, run diagnose again, run the bare true-up where its plan holds no destructive step, then step 6. Where the core backed out nothing, write nothing more and report the pending line. The outcome paragraph of step 7 says `trued up; plan steps pending: <d>` holds only where a destructive step remains after the back-out. In Boundaries, the line "Writes nothing the owner has not let proceed… an abort writes nothing" is reworded so that an abort of the first plan writes nothing, and an abort of the second plan restores only the answers that made it destructive.
- `docs/integration-contract.md`: changed. The modes list in "The administration files" and the "Current conformance" mode list gain `back-out`. "The plan and the one consent" gains the second-plan abort. "Input questions and `resolve`" gains the record.
- `plugins/ok/CLAUDE.md` (the mode list in "Plugin purpose") and `plugins/ok/families/ok-planner/CLAUDE.md` (the `admin/true-up` layout line): changed. Each names `back-out <plan id>`.
- `checks/owned-paths::check_planner`: changed. It adds regions for `answer_write`, `write_record`, `clear_record`, and the `back-out` mode block. It allows `write_owner(ANSWER_RECORD…)` in `write_record`, `write_text(path)` in `answer_write`, `write_owner(path)` and `os.remove` of the restored path in `back-out`, `os.remove(ANSWER_RECORD)` in `clear_record`, and `subprocess.run(["bash", core, "diagnose"]…)` in `back-out`. It adds a needle that `ANSWER_RECORD` is rooted in `CACHE_DIR`. It moves the `write_text` keys `target_path` and `replacement` from `resolve` to the sites they now take.
- `.ok-planner/review/project.md`: changed. The true-up line under "Scripts for developers and operators" names `back-out <plan id>`, what it prints, and that it refuses a changed plan.
- `.ok-planner/design/decisions/true-up-asks-once-before-destructive-steps.md`: changed, by the decision delta.

**Behavior changes**
- **B301** `true-up::resolve_question` and the `amend` mode. Before: each writes the owner's draft and nothing else. After: each also writes or extends `.ok-planner/.cache/true-up-answers.json`. Users: in the release: the `back-out` mode alone reads it. Across Trued-up projects: none. The file is new, machine-local, and git-ignored, and no earlier release reads or writes it. Ruling: rewrite.
- **B302** `true-up::apply_plan`. Before: an applied plan leaves `.ok-planner/.cache/` as it is. After: it removes `true-up-answers.json` after its last action. Users: in the release: `back-out`. Across Trued-up projects: none. Ruling: rewrite.
- **B303** `plugins/ok/skills/ok/SKILL.md` step 5.4. Before: when the owner aborts the second plan, `/ok` writes nothing more and goes to step 6. After: `/ok` runs `back-out`. That restores each answer whose write made a step destructive, records it declined, re-diagnoses, and runs the bare true-up where no destructive step remains. Users: in the release: the core and the skill ship together in the `ok` plugin. Across Installed plugins: each owner who types `/ok`. A session whose loaded `/ok` text predates the update runs the newer core without `back-out` and keeps today's behavior. Ruling: migrate: the abort path follows the amended decision:true-up-asks-once-before-destructive-steps the owner approved. The first plan's question, the go-ahead, and every answer's command stay as they are. A second plan no answer made destructive gets today's pending report (call).
- **B304** `plugins/ok/skills/ok/SKILL.md` step 7, the outcome rule. Before: every abort of the second plan reads `trued up; plan steps pending: <d>`. After: that line stands only where a destructive step remains after the back-out. Otherwise the outcome is `trued up`, or `trued up; check findings pending: <n>` where a backed-out `amend` draft leaves its finding pending. Users: in the release: none. Across Installed plugins: the owner reading the report. Ruling: migrate: as B303, decided by the same delta (call).

**New surface**
- `true-up back-out <plan id>`, declared in `plugins/ok/families/ok-planner/admin/true-up`: internal. The surface intent classes the family's administration files as internal.
- `.ok-planner/.cache/true-up-answers.json`, written by the same file: internal.

### /dashboard places the pinned page build where the project has none

**Calls**
- (drafting) The placement routine lives in the service's source, and the vendored service runs it, reading the pinned version's carried build as data. True-up loads the routine from the carried script. Decided by: decision:per-project-pinning's rule that only administration runs from the payload, and the rule to keep one routine.
- (drafting) `/dashboard` finds the pinned version's front door as the sibling, named by that version, of the installed entry's `installPath`. Decided by: the plugin cache's layout on this machine, which holds 25.4.0 through 28.0.0 side by side. Note: `~/.claude/plugins/cache/ok-plugins/ok/<version>/` holds each version, and 28.0.0's `.claude-plugin/plugin.json` names `28.0.0`.
- (drafting) Where the pinned version is not installed, `/dashboard` still starts the service, which serves the stub page. Decided by: the data routes keep answering, and the stub already names `/ok`.
- (drafting) The service's own notices and the page's stub keep naming `/ok`. Decided by: `/dashboard` places before it starts the service, so a notice shows only where placement could not happen, and `/ok` is then the fix.
- (drafting) decision:dashboard-started-by-skill takes no delta. Decided by: its Choice says the skill starts the service and reports the address, and no sentence there forbids the skill from writing. The "edits no file" sentence is skill text.
- (drafting) The README's clone promise is left to the next documentation sprint, and this sprint narrows the clone promise of `docs/integration-contract.md`. Decided by: the `readme` docspec governs README.md, and a build task writes no documentation. `docs/integration-contract.md` falls under no docspec.
- (sign-off) decision:pinned-build-placed-at-true-up drops the drafted sentence "The build a project serves is always its pinned version's build", which the service does not do, for the service's actual behavior: a mismatched placed build serves with a note naming /ok. Decided by: the accepted recommendation names no change to what the service serves.
- The routine's parts in `scripts/dashboard`:
  - `class Unplaceable(Exception)`.
  - `placed_build(family, version)`. It returns `{rel: text}`: every file under `<family>/browser/dist/` with `{{OK_PLANNER_VERSION}}` replaced, plus `.gitignore` from `<family>/scripts/dashboard-gitignore` rendered the same way. It raises `Unplaceable` naming the path where `index.html` or the ignore file is missing, or where a file does not decode as UTF-8.
  - `unplaced(dest, names)`. It returns the files under `dest` that `names` does not name, and `[]` where `dest` is a symbolic link or not a folder.
  - `write_build(dest, files, extras)`. It writes each file as UTF-8 text, removes each extra, and removes each folder those removals empty, bounded by `dest`.

  Decided by: the work item's "renders each file…, writes it as text with the build's ignore file, and removes each placed file the carried build does not name", and true-up's `carried_build`, `placed_extras`, and the `materialize` loop as they stand, collapsed into one place.
- The ignore file moves from true-up's `ESTATE_FILES` into `placed_build`. Otherwise `dashboard-gitignore` would be rendered and written by two mechanisms. Its rendered bytes and its key, `os.path.join(BUILD_DEST, rel_)`, stay as they are. Decided by: the work item ("with the build's ignore file") and the cheatsheet's strict-DRY rule.
- `write_build` writes `.gitignore` first and `index.html` last. A placement that stops partway never leaves the build un-ignored. Its `index.html` still carries the old stamp, or is missing, so the next `place` places again rather than reading the build as current. Decided by: accept-list A1, and `place`'s "already carries its version" check, which reads `index.html`.
- `place` checks in this order, each refusal writing nothing:
  1. It refuses where the service is unstamped or its version differs from the estate's stamp: `dashboard: this service is v<V>, but this project is pinned to v<E>; nothing placed; run /ok`.
  2. It writes nothing and exits 0, with `dashboard: the placed build already carries v<V>; nothing placed`, where `build_version(build_dir(root)) == VERSION`.
  3. It refuses where no `--from` is given.
  4. It refuses where `<folder>/.claude-plugin/plugin.json` is missing, does not parse, or names a version other than `VERSION`.
  5. It refuses where `placed_build` raises `Unplaceable`.

  Each refusal is `dashboard: <reason>; nothing placed; run /ok` with exit 1. A placement prints `placed: the dashboard build at .ok-planner/dashboard/ (v<V>) from <folder>`, then one `removed:` line naming each extra it removed. Decided by: the work item's refusals and their "names /ok". The order puts the "already carries" check, which needs no folder, ahead of the checks on the folder.
- `place` is dispatched on `argv[0] == "place"` before the serve parser runs, with an `argparse` parser of its own that takes `--from`. `dashboard`, `dashboard --port N`, and `dashboard --open` parse as they do now. The serve parser's description names `place`. Decided by: existing callers (`/dashboard`'s start line, the drive steps in `.ok-planner/review/project.md`) must keep working.
- `place` runs under `main`'s existing catch-all, which emits `DASHBOARD.SERVICE.FAILED` on an unexpected raise. A refusal the owner acts on prints and exits 1, emits no event, and catches only `Unplaceable`. Decided by: rule 4.3 (a refusal the user acts on) and rule 4.4 (the owner frame).
- The skill reads the pinned version from the `Materialized by ok-planner v<X.Y.Z>` line of `.ok-planner/CLAUDE.md`, as `/ok-version` step 2 does. It reads `installPath` as `/ok`'s "Resolving the payload" does. It uses `installPath` where that folder's manifest names the pinned version, else `<dirname of installPath>/<pinned>` where that folder's manifest names it. Otherwise it finds no folder. Where it finds a folder, it runs `python3 .ok-planner/bin/dashboard place --from <folder>`. Where it finds none, it runs `place` with no `--from`. A current build then reports "already carries" and the skill says nothing. Otherwise the no-`--from` refusal comes back, and the skill tells the owner that v`<pinned>` of the ok plugin is not installed and to run `/ok`. Any other refusal it relays verbatim. In every case it goes on to start the service. Decided by: the work item's three outcomes, and the drafting call that the service still starts.
- The skill carries `<!-- @decision: pinned-build-placed-at-true-up -->` above its placement step, and `scripts/dashboard` carries `# @decision: pinned-build-placed-at-true-up` above `placed_build`. True-up strips that citation line from the vendored copy. Decided by: the configured `@decision:` citation and the sibling at `true-up:283`.

**Changes**
- `plugins/ok/families/ok-planner/scripts/dashboard`: changed. It gains `Unplaceable`, `placed_build`, `unplaced`, `write_build`, `front_door_version(folder)` (which reads `.claude-plugin/plugin.json`), and `place(root, folder)`. `main` dispatches `place`.
- `plugins/ok/families/ok-planner/admin/true-up`: changed. `DASHBOARD_SRC = os.path.join(family_dir, "scripts", "dashboard")` and `carried_dashboard()` (through `carried_module`) are new. `carried_build` and `BUILD_SRC` are removed. `expected()` keys `os.path.join(BUILD_DEST, rel_)` from `carried_dashboard().placed_build(family_dir, version)`. `ESTATE_FILES` drops the `scripts/dashboard-gitignore` row. `placed_extras` becomes a call to `carried_dashboard().unplaced(BUILD_DEST, …)`. `materialize` writes the build's share of `writes` through `carried_dashboard().write_build(BUILD_DEST, …, extras)`, drops its own `os.remove(placed_extra)` and `prune(extras, BUILD_DEST)`, and keeps its `materialized:`, `placed:`, and `removed:` lines and its count as they are.
- `plugins/ok/families/ok-planner/skills/dashboard/SKILL.md`: changed. The description and the opening paragraph say the skill places the page build where the project holds none, or one stamped with another version. The command list in the opening names the reads (`claude plugin list --json`, `~/.claude/plugins/installed_plugins.json`, the manifest, `.ok-planner/CLAUDE.md`) and the `place` call. The "edits no file" sentence excepts the page build and its ignore file under `.ok-planner/dashboard/`, which the service's `place` writes. A new step places the build between "Find the service" and "Start the service". Step 3's line about notices still holds.
- `plugins/ok/families/ok-planner/admin/ADMINISTRATION.md` ("The dashboard's build"): changed. It says one placement routine, in the service's source, serves true-up and `/dashboard`, and that true-up runs it from the carried copy.
- `plugins/ok/families/ok-planner/scripts/ok-planner-CLAUDE.md` (the dashboard paragraph, "`dashboard/` holds the page's build…"): changed. It names true-up and `/dashboard` as the two acts that place it.
- `plugins/ok/families/ok-planner/CLAUDE.md`: changed. The `browser/` line says true-up and `/dashboard` place the build. The `skills/dashboard/` line adds the placement step. The `scripts/dashboard` line names `place`. The `scripts/dashboard-gitignore` line says the placement routine writes it with the build.
- `docs/integration-contract.md` (Support scripts, the dashboard paragraph): changed. It names both placing acts and the one routine. "A project serves the build its last true-up placed" becomes this: a clone or a new worktree holds no placed build, `/dashboard` places the pinned version's build from the installed front door, and where that version is not installed it names `/ok`.
- `checks/owned-paths::check_planner`: changed. It drops the `os.remove` key `placed_extra` from `materialize`, which has no site any more. Its needles keep `BUILD_DEST = os.path.join(ok_dir, "dashboard")` and the `expected()` key. See I301 for its coverage of the moved writes.
- `.ok-planner/review/project.md` (the dashboard line): changed. It names `place [--from <front door folder>]`, its refusals, and its exit codes.
- `.ok-planner/design/decisions/pinned-build-placed-at-true-up.md`: changed, by the decision delta.

**Improvements**
- **I301** `checks/owned-paths::check_planner`: maintenance cost. After the move, true-up's writes under `.ok-planner/dashboard/` run in `scripts/dashboard`, which the check never reads. So the check that every true-up write lands in the owned set would pass while covering none of them. Afterward: the check reads `scripts/dashboard`, finds `write_build`, `unplaced`, and `place` by region, and runs `check_sites` over them. Every `open(…, "w")`, `os.remove`, and `os.rmdir` there must target a path built from the `dest` parameter. `place` must pass `os.path.join(root, BUILD)` as `dest`.

**Behavior changes**
- **B305** `plugins/ok/families/ok-planner/skills/dashboard/SKILL.md`. Before: `/dashboard` writes no project file. It starts the service, which serves the stub page where no build stands, and a notice where the build's version differs. After: before the start, it places the pinned version's build and its ignore file under `.ok-planner/dashboard/` where none stands or the version differs. Where that version is not installed, it says so and names `/ok`. The start, the report, and the stop are unchanged. Users: in the release: none. Across Installed plugins: each owner who types `/dashboard`. Across Trued-up projects: the placed build an earlier true-up wrote, which `place` reads by its `index.html` stamp and leaves alone where it carries the pinned version. Ruling: migrate: the skill writes only the git-ignored build folder, with the bytes true-up places for that version, and only where it holds no build of the pinned version. A project whose build is current sees no change (call).
- **B306** `true-up::expected` (was `carried_build`). Before: a carried payload with no build `index.html`, or with a non-UTF-8 build file, stops every mode with an `AssertionError` reading `true-up: the carried payload holds no dashboard build at <path>; a release builds it…`. After: the same cases stop every mode with `Unplaceable` and the routine's message, which names the path and the release step. Users: in the release: `/release` and any developer who runs true-up from a tree whose `browser/dist/` was never built. Across boundaries: none. Ruling: rewrite.

**New surface**
- `dashboard place [--from <front door folder>]`, declared in `plugins/ok/families/ok-planner/scripts/dashboard`: internal. The surface intent classes the family's scripts as internal.

### True-up converts earlier documentation declarations and files one issue for what it cannot write

**Calls**
- (drafting) True-up converts a document-type file that an earlier true-up already moved under `docspec/`, detected by a `document` key and no `docspec` key. Decided by: the linescout-inl case is that state, and the recommendation's goal of no unconverted declaration needs it.
- (drafting) A document type with no `audience` gets no `## Reader`, and the issue names that section. True-up does not write the earlier release's `public` default. Decided by: only the owner's words carry substance.
- (drafting) The issue names `## Lists` only "where the docspec is reference documentation". Decided by: nothing in a document type says whether it is.
- (drafting) One issue covers every section, with a stable id that true-up files once. Its category is `unspecified`. Decided by: the recommendation's "one intake issue", the never-refile rule of the sibling filing step, and the issue naming load-bearing sections no one has written.
- (drafting) A section of a document type other than Purpose, Covers, and Notes moves under `## Notes`. Decided by: the docspec form allows no other section, and moving the text keeps its substance.
- The conversion is a rewrite record in `rewrite_plan()`, keyed by the docspec path, with `source` set to the document-type path. For a file already under `docspec/`, the two paths are the same. So `rewrite_steps` prints the one `DESTRUCTIVE: rewrites <docspec path>: <detail>` step with `Show: true-up show <docspec path>`, `show` prints the diff `a/<source>` → `b/<docspec path>`, and `apply_rewrites` writes it through `write_owner` after the move. Decided by: the work item's "`Show:` line runs `true-up show <path>`", and the sibling rewrites (retired sections, provenance stamp) that run through the same plan.
- One predicate decides both the move and the conversion of a document type: its docspec path does not stand yet (`os.path.lexists`). `docspec_steps` drops its `or dst in plan["taken"]` clause. Names under one folder are unique, and no earlier step moves a file into `docspec/`, so the clause holds back nothing today. Keeping it would let a conversion record outlive a move that never ran. Decided by: rule 8.3 (walk every exit of the changed step).
- The detail line reads: `it holds the documentation declaration an earlier release wrote (document, audience, target); true-up converts it to the docspec form and keeps its substance`. Decided by: the sibling detail lines of `rewrite_plan`.
- The conversion takes no archive copy first. It keeps every byte of substance, as the config-key rewrites do, unlike the retired-section strip, which deletes text. Decided by: decision:whole-file-ownership ("keep their substance").
- The mapping beyond the work item's list:
  - The `docspec:` value is the `document` value where it is non-empty, else the file stem.
  - Prose between the title and the first `## ` section moves under `## Notes`, ahead of the moved sections.
  - Under `## Notes`, the file's own Notes text comes first. After it comes each other section in file order, opened by its heading text alone on a line (for example `Method`), then a blank line, then its text.
  - A front-matter key other than `document`, `audience`, and `target` moves under `## Notes` as a `<key>: <value>` line.
  - An empty section is not written, and `## Notes` is left out where nothing goes under it.
  - A document type with no `target` gets no `## Where`, and the issue names `## Where` for it too.
  - A file with CRLF line endings fails `frontmatter()` and stays as written.

  Decided by: decision:whole-file-ownership (substance kept; the owner writes what the retired form lacks), and the core's byte-for-byte sibling rule for CRLF sprints.
- A document type under `surface/documents/` that does not decode as UTF-8 still moves, and diagnose prints `left: <docspec path> does not decode as UTF-8, so true-up cannot convert it to the docspec form`. A file under `docspec/` that does not decode is never detected. Decided by: the sibling `UNDECODABLE_SECTIONS` note.
- The issue's id is `docspec-sections-unwritten`. It is kind `audit`, category `unspecified`, with artifacts `[]` and no route, recommendation, or upstream. Its problem lists each converted docspec's path and the sections true-up did not write. Its one option: plan a sprint whose docspec deltas write each named section, and whose surface intent delta writes the declaring files. True-up prints `filed: docspec-sections-unwritten — <n> converted docspec(s) lack sections only the owner writes`. Decided by: the sibling `facts_issues` shape and decision:surface-intent-changed-by-sprints.
- The issue is filed only on a plan that converts at least one docspec. It names the surface intent's `## Where each class is declared` only where `.ok-planner/surface/surface.md` exists and lacks that heading. Where no surface intent exists, the project declares no surface, and no section is missing. Decided by: decision:whole-file-ownership ("Where the retired form holds nothing for a section the current form requires").

**Changes**
- `plugins/ok/families/ok-planner/admin/true-up`: changed.
  - `document_type_form(text)` is new: front matter with a `document` key and no `docspec` key, read through the existing `frontmatter`.
  - `converted_docspec(stem, text)` is new: the mapping above.
  - `docspec_conversions()` is new, under `functools.lru_cache`. It lists `(docspec path, source)` for each regular file under `DOCUMENT_TYPES` whose docspec path does not stand, and for each `*.md` under `DOCSPEC_DIR` that is in document-type form, symbolic links excluded.
  - `docspec_steps` is changed: the one predicate, and the `left:` note.
  - `rewrite_plan` is changed: it adds a record per conversion.
  - `docspec_issues()` is new, and `DOCSPEC_ISSUE_ID = "docspec-sections-unwritten"` is new.
  - `filing_steps` is changed. It adds `DRIFT: <n> converted docspec(s) lack sections only the owner writes; true-up files intake issue docspec-sections-unwritten, after every intake conversion`, and passes the issue to `file_issues` with the others.
- `plugins/ok/families/ok-planner/admin/ADMINISTRATION.md`: changed.
  - In "The audit and document back-out", the move bullet now says the plan converts as it moves, and converts a document-type file already under `docspec/`, with the mapping. Its sentence "A moved document type keeps its text; the docspec index lists it with 'where: not declared'…" goes.
  - In the same section, the surface intent bullet says true-up writes nothing to the surface intent, and that the issue names its missing declaring section.
  - "What the administration does NOT do here" names the docspec-sections issue among the intake writes.
  - The "What each kind of content becomes" table's back-out row covers the conversion.
- `plugins/ok/families/ok-planner/skills/_shared/artifact-definitions.md` (the `/ok` row of the writer table): changed. It adds the one issue for the sections a docspec conversion could not write.
- `plugins/ok/families/ok-planner/scripts/ok-planner-cheatsheet.md` ("True-up files under kind `audit` too…") and `plugins/ok/families/ok-planner/scripts/ok-planner-CLAUDE.md` (the filers sentence, about lines 304 to 305): changed. Each adds the docspec-sections issue.
- `docs/integration-contract.md` ("The ownership rule"'s list of named migrations): changed. A new bullet covers the conversion of an earlier documentation declaration to the docspec form, with its substance kept, and the one issue true-up files for the sections it cannot write.
- `checks/owned-paths::check_planner`: changed. The `docspec_steps` needles keep `dst = os.path.join(DOCSPEC_DIR, os.path.basename(src))` and `move_step(plan, src, dst,`. A new `rewrite_plan` needle, `converted_docspec`, is added, with a use check like `stamp_uses` that `converted_docspec` is called only inside `rewrite_plan`. A `filing_steps` needle, `docspec_issues()`, is added, and the `file_issues` region keeps its intake-module needle.
- `.ok-planner/design/decisions/whole-file-ownership.md`: changed, by the decision delta.

**Improvements**
- **I302** `docs/integration-contract.md` ("The ownership rule"): maintenance cost. The contract lists the issues `/ok` files in its migration bullets, but names only the retired-script-caller issues, and leaves out the `review-facts-undecodable` issue the core already files. A reader of the contract then counts one filing short, and this change adds a third filing to the list. Afterward: the list names all three filings: the retired-script callers, the undecodable review facts file, and the docspec sections. Behavior changes: none, since the change is text only.

**Behavior changes**
- **B307** `true-up::docspec_steps` with `rewrite_plan`, for a document type under `.ok-planner/surface/documents/`. Before: one `DRIFT:` move to `docspec/<name>`, with its text unchanged. After: the same move, then a `DESTRUCTIVE: rewrites` step with `Show:`. The plan now asks the owner's one consent and converts the file to the docspec form with its substance kept, or prints a `left:` note where the file does not decode. Users: in the release: the docspec index (`catalog-toc`), `scripts/docs`, and `/plan-docs`, which read the docspec form. Across Trued-up projects: every project holding a document type an earlier release wrote. Ruling: migrate: stored declarations convert to the current form with their substance kept, as the amended decision:whole-file-ownership commits (call).
- **B308** `true-up::rewrite_plan`, for a file under `.ok-planner/docspec/` in document-type form. Before: no step, and the file stays in a form the current skills misread. After: a `DESTRUCTIVE: rewrites` conversion step. Users: the same as B307. Ruling: migrate: as B307 (call).
- **B309** `true-up::filing_steps`. Before: the plan files issues only for retired-script callers and an undecodable review facts file. After: on a plan that converts, it also files `docspec-sections-unwritten` once, through the intake module, and prints its `filed:` line. Users: in the release: `/triage-issues` and `/plan-sprint`, which read the intake, and `/ok`'s report, which relays every `filed:` line. Across Trued-up projects: the intake, which gains one record in the current format. Ruling: rewrite.

### The edit hook checks every file-editing tool's call and nothing else

**Calls**
- (drafting) The edit hook filters by `tool_name` inside the hook and keeps the `""` matcher. Decided by: a narrower matcher would make every wired project drift and re-consent, and would leave a project that had not rewired still blocking on Read.
- (drafting) The rule to edit through the file-editing tools goes in the cheatsheet's hook bullet. Decided by: that bullet is where the rules already describe what the hook checks, and every session loads it.
- (sign-off) story:edit-time-lint-enforcement keeps its scope, "every agent edit made through a file-editing tool, notebooks included". Decided by: the accepted recommendation, "The story and the decision name that scope". Striking the clause would promise checks on shell edits that the decision sends to the review-time lint.
- The tool set is the constant `EDIT_TOOLS = new Set(['Edit', 'Write', 'MultiEdit', 'NotebookEdit'])`. The path is `tool_input.notebook_path` for `NotebookEdit` and `tool_input.file_path` for the rest. A missing or non-string `tool_name`, or another tool, exits 0 before any read. Decided by: the work item, and the sibling `scripts/hooks/agent-model`, which reads `event.get("tool_name")`.
- The lint reads a notebook through one source reader shared by both content checks. `comment-hygiene` and `citation-resolution` each read the code cells. A citation in a notebook cell that passes the comment check is then resolved too, rather than passing both checks unseen. Decided by: the story delta's "notebooks included", and the cheatsheet's rule of one idiom per job.
- The language is `metadata.language_info.name`, else `metadata.kernelspec.language`, lower-cased. It maps through an explicit table, `NOTEBOOK_LANGUAGES`: python to `.py`; javascript to `.js`; typescript to `.ts`; bash and sh to `.sh`; ruby to `.rb`; perl to `.pl`; go to `.go`; rust to `.rs`; c to `.c`; c++ and cpp to `.cpp`; java, kotlin, scala, swift, and php to their extensions; csharp and c# to `.cs`. A name the table lacks gets no comment check. Decided by: the work item ("the language the notebook's metadata names", "no comment grammar gets no comment check") and the cheatsheet's explicit-registration rule.
- Each code cell is checked on its own. A block comment cannot span cells. Markdown and raw cells are skipped. Every line of a cell is read in the notebook's language, IPython `%`/`!` lines included. Decided by: the work item ("its code cells", "skips its markdown cells").
- Line mapping comes from a small recursive JSON reader in the lint that records the file line each string token starts on, because `JSON.parse` keeps no positions. A cell whose `source` is an array maps source line k to the file line of element k. A cell whose `source` is one string maps every source line to that string's line. Decided by: the work item's "reports each finding at the notebook file's line that holds the source line".
- A notebook that does not parse as JSON, or that has no `cells` array, gets no comment check, as an unreadable file does today. Decided by: the sibling `content = null` path of `runLint`.

**Changes**
- `plugins/ok/families/ok-planner/scripts/hooks/post-edit.js::lintStage`: changed. It returns `null` unless `EDIT_TOOLS.has(event.tool_name)`, and takes the path from `notebook_path` for `NotebookEdit`. Every other line stays, the changed-line scoping included.
- `plugins/ok/families/ok-planner/scripts/plumbline`:
  - `NOTEBOOK_LANGUAGES` and `notebookGrammar(filePath)` are new.
  - `readNotebook(text)` is new: the positioned reader. It returns the language and, for each code cell, its source text and its line map.
  - `lintSources(file)` is new. It yields `{text, grammar, lineOf}`: one source with the identity map for an ordinary file, and one per code cell for a `.ipynb`.
  - `grammarFor` is changed: `.ipynb` resolves through `notebookGrammar`.
  - `runLint` and `checkCitationResolution` are changed. Each reads through `lintSources`, and each finding's `line` is mapped through `lineOf` before the `--lines` filter in `lintCmd` applies.
  - `checkCommentHygiene` and `parseCitations` take a source's text and map its lines. Their findings keep `file` as the notebook path.
- `plugins/ok/families/ok-planner/docs/plumbline-cheatsheet.md` (Tooling, the hook bullet): changed. It says the hook runs the lint after each call of Edit, Write, MultiEdit, or NotebookEdit over the file it names, a notebook's code cells included, and checks nothing after any other tool's call. It says: make every file edit through Edit, Write, MultiEdit, or NotebookEdit, because an edit made any other way waits for the review-time lint. "A test written by Edit or Write" becomes "A test written by one of those tools", with the `no-tests` markers kept around it. "It does nothing for a Bash call" goes.
- `plugins/ok/families/ok-planner/admin/ADMINISTRATION.md` ("The lint's edit hook") and `plugins/ok/families/ok-planner/scripts/ok-planner-CLAUDE.md` (lines 118 to 119, "each Edit or Write touches"): changed. Each names the four tools.
- `.ok-planner/design/stories/edit-time-lint-enforcement.md` and `.ok-planner/design/decisions/edit-hook-blocks-in-turn.md`: changed, by the deltas. `catalog-toc` regenerates `.ok-planner/design/decisions.md`, whose line quotes the old Choice.

**Improvements**
- **I303** `post-edit.js::main`: accept-list A8. decision:edit-hook-blocks-in-turn commits that every hook failure path degrades to a silent pass, and the work item restates it ("Every failure path still passes silently"). But a raise inside `lintStage`, from `require(binary)` on a vendored lint that does not load or from `findProjectRoot`, escapes as an uncaught exception. Node then exits 1 with a stack trace, which the harness shows as a non-blocking error. Afterward: `main` runs `lintStage` inside `try { … } catch (err) { process.exit(0); }`, the hook's owner frame, as the existing `require` and stdin catches at its top do.

**Behavior changes**
- **B310** `post-edit.js::lintStage`. Before: after any tool's call whose `tool_input.file_path` names an existing file inside the project (Read included), the hook lints that file's changed lines and blocks on a violation. A Read of a dirty tracked file blocks. After: it lints only after Edit, Write, MultiEdit, or NotebookEdit, and passes clean after every other tool. Users: in the release: every session in a project wired for the `lint` group. Across Trued-up projects: the hook file is suite-owned and replaced at true-up. The wiring entry, its `""` matcher, and the hook path stay byte for byte, so no settings entry drifts. Ruling: rewrite. Across Trued-up projects: preserve (call), because the wiring and the path that cross the boundary do not change.
- **B311** `post-edit.js::lintStage`. Before: a NotebookEdit call passes unchecked, since the hook reads only `file_path`. After: the hook lints the notebook named by `notebook_path`, scoped to the notebook file's changed lines. Users and ruling: as B310.
- **B312** `scripts/plumbline::grammarFor`, `runLint`, and `checkCitationResolution`. Before: a `.ipynb` file has no grammar and gets neither content check. After: the code cells of a notebook in a mapped language get `comment-hygiene` and `citation-resolution`, reported at notebook file lines. Users: in the release: the edit hook, `review checks` (whose lint check runs over the files a run changed), and every whole-tree lint run. Across Trued-up projects: a project's own notebooks. A notebook carrying prose comments in a code cell is reported once a change touches it: the hook scopes to changed lines, and `review checks` to changed files. Ruling: migrate: the lint reads notebooks from the true-up that vendors it. A notebook no change touches is reported only by a whole-tree run, as the story delta commits ("notebooks included") (call).
- **B313** `docs/plumbline-cheatsheet.md` (rendered to `.claude/rules/plumbline-cheatsheet.md`). Before: the rules say the hook checks "the file an Edit/Write touched" and "does nothing for a Bash call". After: they name the four tools and tell agents to edit only through them. Users: every session, through the rules file true-up renders. Ruling: rewrite.
- **B318** `post-edit.js::main` (I303). Before: a raise inside `lintStage` ends the hook with node's uncaught-exception exit 1 and a stack trace, which the harness shows as a non-blocking error after each such call. After: the hook exits 0 silently. Users: in the release: every wired session. Across Trued-up projects: as B310. Ruling: rewrite. The fix removes only the A8 harm, so the contract holds.

### A confirm drive answers for one defect, and its send-back names each story that failed

**Calls**
- The confirm send-back note names each story that failed. Decided by: the accepted recommendation's rationale (drafting call, g4): the driver's note carries that record.
- The achieved rule, the `confirmed` field, and the per-defect brief stay as built. `review drives --confirm`, `review:confirm_briefs`, and step 6 of `skills/converge/SKILL.md` change no byte. Decided by: the work item ("each keeps that wording") and decision:drive-tries-each-story-as-a-user as amended.
- The send-back note takes the form `confirm drive: failed on <slug>[, <slug>]: <per story: what you did; saw: what happened; evidence: quoted>`, and a story that succeeded gets no entry. Decided by: the amended decision's "a note that names each story that failed". The verifier's send-back form in `prompts/verify.md` is the sibling shape: it names what is still wrong.
- The close result already names each story slug a confirm brief names, with an outcome per surface and variant, so it stays. Decided by: the work item, which changes only the send-back.

**Changes**
- `plugins/ok/families/ok-planner/skills/converge/prompts/drive.md` (section `### Confirm, where your brief says so`, the second bullet): changed. Where any story the brief names fails, the driver sends the defect back with `--note "confirm drive: failed on <each story slug that failed>: <for each such story: what you did; saw: what happened; evidence: quoted>"`. The `--state open` and `--field kickbacks=<its count plus one>` parts stay. The first bullet, the section's opening paragraph, and the Close line stay as they stand.
- `.ok-planner/design/decisions/drive-tries-each-story-as-a-user.md`: the delta lands from the sidecar, and `python3 .ok-planner/bin/catalog-toc` runs. `confirm_briefs` keeps its `@decision: drive-tries-each-story-as-a-user` line.

**Behavior changes**
- **B401** `plugins/ok/families/ok-planner/skills/converge/prompts/drive.md` (confirm send-back note). Before: a confirm driver that fails writes one note, `confirm drive: <what you did>; saw: ...; evidence: ...`, which does not say which of several stories failed. After: the note opens with `failed on <slug>, ...` and gives what the driver saw on each failed story. Users: in the release: the fixer, which reads a sent-back defect's note at step 1 of `prompts/fix.md`; the owner list, which files a stuck defect with the last note kept (Loop 2 step 1 of `skills/converge/SKILL.md`). Neither parses the note. Across Trued-up projects: a project's vendored `.claude/skills/converge/prompts/drive.md` and the review prompt files a run assembles update together at true-up; a run ledger holds notes as free text, which nothing parses. Ruling: rewrite.

### The review tool reads a sprint's fences as CommonMark does, and refuses a body fenced no longer than a block inside it

**Calls**
- Tilde fences count, because CommonMark reads them. `block_sources`, which reads the shared skill blocks and not a sprint, keeps its reading. Decided by: drafting call (g4), and the work item's scope ("reads fences in a sprint").
- The refusal fires on either condition: a line inside the body opens with a run of the outer fence's character at least as long as the outer fence, or a line that opens a fence stands between the body's closer and the next delta heading or the section's end. Decided by: drafting call (g4); the recommendation names no test.
- An opener or a closer may sit behind up to three spaces of indent, and a backtick opener's info string holds no backtick, as CommonMark reads them. An unclosed fence runs to the end of the lines read. Decided by: the work item ("as CommonMark does").
- An inline body may open with `~~~markdown` as well as with a backtick run and `markdown`. Decided by: the work item's one reading for every fence, and the new delta-form rule names only the info string.
- The refusal reason is `delta_failure`'s return for a broken inline body, so `cmd_deltas` keeps its order: a stuck C3 defect still lists the delta under `stuck`, an open one still names the defect, and otherwise the reason lands under `unsettled` with `why` set to it. `review certified` prints it through `delta_failures`. Decided by: the work item's wording ("lists the delta under `unsettled`, and `review certified` fails on it") and the sibling path every other body failure takes.
- The reason reads `<delta_name>: its body holds a code block fenced as long as the body's own fence; fence the body with more backticks than any fence inside it`, with `<delta_name>` from `review::delta_name`. Decided by: the work item's text.
- A broken body can hide the deltas after it inside a stray fence, so `compared` counts fewer deltas. The tool still fails the sprint on the broken delta, so certification cannot pass over it. The tool adds no second count. Decided by: the work item ("no delta heading inside a fence counts").
- `outside_paths` reads `## Paths outside the project root` and stops at any `#` line. It reads no fence, and the work item names the definitions that do, so it stays. Decided by: Scope.
- No delta to decision:final-form-deltas or concept:corpus-delta. The fence rule lives in the delta form, which is skill text. Decided by: drafting call (g4).

**Changes**
- `plugins/ok/families/ok-planner/scripts/review::FENCE_OPENING`: changed. It matches up to three spaces, then three or more backticks or three or more tildes, and captures the run. A backtick run followed by an info string that holds a backtick does not match.
- `plugins/ok/families/ok-planner/scripts/review::closes_fence`: changed. It takes the opener's run and closes on a line of up to three spaces, then a run of the same character at least as long, then only whitespace.
- `plugins/ok/families/ok-planner/scripts/review::fence_depths`: changed. It keeps at most one open fence. Inside an open fence, only that fence's closer counts, and every other line is text. The yielded `before` and `after` depths are 0 or 1. `section_lines`, `unfenced_lines`, and `sprint_deltas` keep their bodies and read through it, so a heading inside any fence, a tilde fence included, is text.
- `plugins/ok/families/ok-planner/scripts/review::inline_body`: changed. It finds the first `markdown` opener (either character), takes the lines up to that opener's CommonMark closer, and returns the body together with whether it breaks the rule: some body line opens with a run of the opener's character at least as long as the opener, or some line after the closer opens a fence. It returns no body where no opener stands, as now.
- `plugins/ok/families/ok-planner/scripts/review::sprint_deltas`: changed. Each delta tuple carries the broken flag beside its body. A sidecar delta carries none.
- `plugins/ok/families/ok-planner/scripts/review::delta_failure`: changed. For an inline body flagged broken, it returns the reason above and compares nothing. `delta_failures` and `cmd_deltas` pass the flag through.
- `plugins/ok/families/ok-planner/skills/_shared/artifact-definitions.md` (`{{CORPUS-DELTA-FORM}}`, the bullet on bodies): changed. It adds the rule. An inline delta body sits in a fence whose info string is `markdown`. A body that holds a fenced code block uses an outer fence longer than every fence inside it, such as four backticks around a body whose inner blocks use three. The review tool refuses a body that breaks the rule.

**Behavior changes**
- **B402** `plugins/ok/families/ok-planner/scripts/review::fence_depths` (and through it `section_lines`, `unfenced_lines`, `sprint_deltas`). Before: a backtick line with an info string opens a nested fence inside an open fence, and a tilde line is never a fence. After: no fence nests, and tilde fences open and close as backtick fences do. A `### New|Amend|Retire` line, or a `## ` line, inside a tilde fence no longer counts as a heading. Users: in the release: `cmd_deltas`, `cmd_certified` through `delta_failures`, and `certification_failures`, which reads the completion report's `# Sprint certification` section with `section_lines`. Across Trued-up projects: none. The boundary leaves out a live sprint and its completion report: the owner trues up only between sprints, and a sprint not yet executed is brought current before it runs. `review certified` reads an archived sprint with a `closed:` stamp as terminal before it reads any delta or report. Ruling: rewrite.
- **B403** `plugins/ok/families/ok-planner/scripts/review::inline_body` / `delta_failure`. Before: a body closes only on a line exactly equal to its opener, so a three-backtick body holding a three-backtick block ends at the inner block's closer and fails the comparison with `differs from the delta's body`. After: a body closes on its CommonMark closer, and a body that breaks the fence rule is not compared: `review deltas` lists it under `unsettled`, and `review certified` fails, each with the reason that tells the owner to fence the body with more backticks. A four-backtick body holding three-backtick blocks reads whole and compares as before. Users: in the release: sprint certification (`skills/converge/SKILL.md` sprint mode reads `review deltas`), step 13 of the sprint boilerplate and the `/goal` checker, which read `review certified`. Across Trued-up projects: none; the boundary leaves out a live sprint an earlier release planned, as B402 says. Ruling: rewrite.
- **B404** `plugins/ok/families/ok-planner/skills/_shared/artifact-definitions.md::{{CORPUS-DELTA-FORM}}`. Before: the form says nothing about how an inline body is fenced. After: it states the `markdown` info string and the longer-outer-fence rule. Users: in the release: `/plan-sprint`'s drafting (its SKILL reads the block as the authority on a delta's parts), and the sign-off compliance reviewer, which reads the block. Across Trued-up projects: the vendored copy updates at true-up with the review tool. Ruling: rewrite.

### Judgment issues take a shape of their own: the decision in the title, the current state then the choice in the lead

**Calls**
- Every category but `defect` takes the judgment shape, `upstream` included. Decided by: drafting call (g4) and `{{ISSUE-DEFINITION}}`, which counts every category but `defect` as a judgment issue.
- The existing clarity example stays word for word as the defect shape's example, though it ends with a ruling sentence. The judgment example is the sprint's approved text. Decided by: drafting call (g4) and the work item.
- The sentence "For a rule violation, the lead states the rule, then how the code breaks it." in `{{ISSUE-FILE-FORMAT}}` now applies to a defect issue's lead and says so. A judgment issue about a rule leads with the current state, as the shape requires. Decided by: decision:issues-read-cold-before-the-owner as amended, which gives a judgment issue's lead as the current state.
- The filing template's `title` hint reads `<the cause, for a defect issue; the decision the owner makes, for any other category>`, beside the `problem` hint the work item names. Decided by: the amended decision, which keys the title by kind, and rule 1 of the coding rules (the hint restates the shape).
- The filers that build issue text in code (true-up's issues for retired script callers and an undecodable review facts file) keep their text. The clarity pass holds every routed or ruled issue to its kind's shape, whatever its filer wrote. Decided by: the amended decision ("one pass at the end holds them all to one shape per kind").
- Issues the clarity pass already stamped keep their text until their text changes, since `issues clarity --pending` takes a record again only then. Decided by: `{{ISSUE-FILE-FORMAT}}`'s clarity stamp rule and clarity.md's Write section; the decision asks the pass to apply the shape when it reads, and adds no re-read.

**Changes**
- `plugins/ok/families/ok-planner/skills/_shared/artifact-definitions.md` (`{{ISSUE-FILE-FORMAT}}`): changed. The shape bullet says the category picks the shape: `defect` takes the defect shape, and every other category the judgment shape. The `title` sentence states both titles: a defect issue's names the cause in plain words, and a judgment issue's names the decision the owner makes, in plain words, under about twelve, naming no project term but the part it concerns. Step 1 states both leads: for a defect issue, the cause, then the harm and who sees it; for a judgment issue, the current state of the thing in question (what is built, what works, what a user sees today), then the choice the owner makes. Steps 2 to 4 stay. The rule-violation sentence names the defect issue. The filing template's `problem` hint asks a defect issue for the cause and the commitment it breaks, and a judgment issue for the current state and the choice; its `title` hint follows the call above.
- `plugins/ok/families/ok-planner/skills/triage-issues/prompts/clarity.md`: changed. Rewrite step 1 finds the cause for a defect issue, and for a judgment issue the current state and the choice. Step 2 writes the title by the record's `category`: the cause for `defect`, the decision in plain words for every other category. Step 3 writes the lead by the same test. "An issue in the shape" becomes two headed examples. The existing example stands word for word under a heading that names it the defect shape, and its closing note says it shows a defect issue. The sprint's approved judgment example follows under a heading that names it the judgment shape, with a one-line note saying its title names the decision and its lead gives the current state, then the choice.
- `plugins/ok/families/ok-planner/skills/triage-issues/prompts/author.md`: changed. The `title` placeholder reads `<the decision, in plain words>`. The shape sentence (line 34) says the title names the decision and the problem leads with the current state, then the choice, then runs the context from the top, what happened, and the sentence naming what the ruling decides.
- `plugins/ok/families/ok-planner/skills/triage-issues/prompts/triage.md`: unchanged. Its `defect` template keeps cause then harm.
- `plugins/ok/families/ok-planner/scripts/ok-planner-cheatsheet.md` ("Verifying" paragraph, "the cause first, then the harm"): changed. It says the clarity agent leads a defect issue with the cause, then the harm, and a judgment issue with the current state, then the choice, then the context from the top with each term defined.
- `.ok-planner/design/decisions/issues-read-cold-before-the-owner.md`: the delta lands from the sidecar, and catalog-toc runs.

**Behavior changes**
- **B405** `plugins/ok/families/ok-planner/skills/_shared/artifact-definitions.md::{{ISSUE-FILE-FORMAT}}` (shape rule and filing hints). Before: every issue's title names a cause and its lead states the cause, then the harm. After: a judgment issue's title names the decision, and its lead gives the current state, then the choice. Users: in the release: every filer that reads the block: `/converge`'s owner list (`prompts/owner-list.md`), the sprint build prompt's upstream filing (`{{SPRINT-BUILD-PROMPT}}`), `/plan-sprint`'s postponed questions and vetoed calls, the sprint, documentation sprint, and test sprint closes that file vetoed rows, `/discover-design`, and the clarity, author, and respond prompts. Across Trued-up projects: the vendored block and prompts update together at true-up. Ruling: rewrite.
- **B406** `plugins/ok/families/ok-planner/skills/triage-issues/prompts/clarity.md` (Rewrite steps 1 to 3, the examples). Before: the clarity agent writes every issue with a cause title and a cause-then-harm lead. After: it picks the shape by the record's category. Users: in the release: the owner and `/plan-sprint`, which read issues the pass rewrote. Across stored state: intake records an earlier clarity pass stamped keep their text until their text changes (call above). Ruling: preserve (call).
- **B407** `plugins/ok/families/ok-planner/skills/triage-issues/prompts/author.md` (`title` placeholder, shape sentence). Before: the author writes each `corpus`, `question`, and `upstream` record with a cause title. After: it writes the decision as the title and leads with the current state, then the choice. Users: in the release: the clarity pass, which reads the author's records next; the owner. Ruling: rewrite.
- **B408** `plugins/ok/families/ok-planner/scripts/ok-planner-cheatsheet.md` ("Verifying"). Before: the rules say the clarity agent leads every issue with the cause. After: they state both leads. Users: in the release: every session, through the vendored `.claude/rules/ok-planner-cheatsheet.md`. Across Trued-up projects: the rules file's name stays; its text updates at true-up. Ruling: rewrite.

### The drain runs as a Workflow script, so the session wakes once per drain, and `tasks next` prints counts

**Calls**
- The Workflow drain cites decision:drain-runs-as-a-workflow-script: `drain.md` carries `<!-- @decision: drain-runs-as-a-workflow-script -->` on its own line above the Workflow form's section. Decided by: the coordinator's word after the sign-off split, and the new decision in the sidecar.
- The script stamps no usage, since `agent()` returns no token count. The session stamps each task from the Workflow run record's per-agent `tokens` after the script returns. Decided by: drafting call (g4). The record is `<the session's folder>/workflows/<runId>.json`, `<runId>` as the Workflow tool's result names it; its `workflowProgress` entries of `type: workflow_agent` carry `label` and `tokens`, as a record on this machine shows (`wf_0efa6cc4-cc9.json`). The session stamps every task of one drain in one Bash call. Decided by: the run record's layout, and the batching rule of `.claude/rules/ok-cheatsheet.md`.
- The script's text lives in a fenced `js` block of `drain.md`; the session passes it inline once, then re-invokes the persisted copy by `scriptPath`. Decided by: drafting call (g4): true-up vendors only markdown from skill folders.
- The session never passes `resumeFromRunId`: a resumed run would replay cached `next` outputs that no longer match the tracker. Decided by: the Workflow tool's resume rule (the longest unchanged prefix of `agent()` calls returns cached results), and decision:drain-runs-as-a-workflow-script (the script runs what the tracker holds).
- Tracker commands run through `haiku` step agents at `effort: 'low'`, because a Workflow script has no shell. Decided by: drafting call (g4). Each step agent returns through a schema, `{"output": string, "exit": integer}`, so the script reads the output with no parsing of prose. Decided by: the Workflow API (a schema forces a validated object) and the work item's "return its output verbatim".
- The script receives `args` as `{"root": <the project root, absolute>, "cap": <the caller's cap, or 8>}`. Each step agent's prompt runs `.ok-planner/bin/tasks <verb>` from `args.root`. Decided by: the work item (the cap reaches the script as `args`), and the session's working folder, which can be a folder below the root, as this session's is.
- A step agent that runs `tasks exec <task>` sets its Bash timeout to the tool's limit, 600000 ms. Decided by: an `exec` task's command can run for minutes, as a stack start does, and the Bash tool's default timeout is 120000 ms.
- The window counts task agents and `exec` steps. A `next` or `retry` step runs between them and takes no slot. Decided by: the work item ("the first `next` fills the window up to the cap"; "at most one fresh agent per return").
- The lifetime count counts every `agent()` call, step agents included, and the script returns `paused` once it has started 950. Decided by: drafting call (g4) and the Workflow tool's lifetime cap of 1000 agents, which counts every agent.
- On a `waiting` line while an agent the script started still runs, the script waits for the next return. Decided by: the work item ("where no agent the script started is still running").
- A task agent whose `agent()` call returns `null`, or text with no `closed <task> <outcome>` line, counts as returned without a `closed` line. Decided by: the Workflow API (`agent()` returns null for a skipped or dead agent).
- Each task agent's label is `<profile>-<n>`, `n` counting task agents within the drain. Decided by: the work item ("a label unique within the drain").
- The script drains every profile, `ok-review` included. No source shows whether an agent a Workflow script starts can fork itself, so sprint certification's drive shows it. Decided by: drafting call (g4).
- `tasks next --json` keeps every id; the `waiting` object gains `running` and `blocked` counts beside its `tasks` list. Decided by: drafting call (g4), and the text line's new fields.
- `running` counts open tasks at state `running`; `blocked` counts every other open task, the unclaimed `fork-of` pass tasks included, so the two sum to the open tasks. Decided by: the tracker's three task states (`open`, `running`, `closed`).
- "Before every dispatch" becomes "before every drain" at each site that renders the completion report or marks the checklist. Decided by: drafting call (g4).
- No delta to decision:subagent-model-follows-job: it already covers every `agent()` call in a Workflow script, and `scripts/hooks/agent-model` reads the script's `model: 'haiku'` literal. Decided by: drafting call (g4) and the hook's `check_workflow_script`.
- The task-tracker section of `ok-planner-cheatsheet.md` ("`tasks next` issues every ready task and prints one line per profile with the count waiting") stays: it holds under both forms. Decided by: the work item names only the lifecycle lines of that file.
- README.md falls under the `readme` docspec, so this sprint leaves it. Decided by: the build prompt's documentation rule.

**Changes**
- `plugins/ok/families/ok-planner/skills/_tasks/drain.md`: changed. The opening keeps the prompt-cache and cap paragraphs. A new section, "Two forms", says the session runs the drain as the Workflow script below where the harness offers the Workflow tool, and by hand where it does not. A new section, "The Workflow form", under the decision annotation, gives:
  - how the session invokes it: `Workflow` with the fenced script inline on its first drain of the session, and `{scriptPath}` from that first result on every later drain, with `args` as the call above gives;
  - the script, in one fenced `js` block, starting with a pure-literal `export const meta = {name: 'ok-drain', description: ...}`. Its body holds a `step(command)` helper (one `agent()` call, `model: 'haiku'`, `effort: 'low'`, the schema above, a prompt that runs `cd <args.root> && .ok-planner/bin/tasks <command>` and returns its output and exit code with no comment), a parser for the `next` lines (`run <profile> model=<m> effort=<e> count=<n>`, `exec <task> <command>`, `waiting running=<n> blocked=<n>[ fork-of <task>=<root> ...]`, `done`), and the loop: the first `next` fills the window up to `args.cap` across the `run` lines in printed order, each task agent being `agent('Claim your task and finish it.', {agentType: <profile>, model: <m>, label: <profile>-<n>})`; the in-flight agents and exec steps are awaited with `Promise.race`; each return leads to one `next`, and the script starts at most one fresh agent for it, of the first profile the line lists with a count above zero; an `exec` line starts one exec step; a `waiting` line with nothing in flight runs `retry <task>` per `fork-of` entry and calls `next` again, or returns `waiting` where none is listed; the script returns `done` on `done`, `stuck` where an agent returned without a `closed` line, `next` still lists the same count for its profile, and no agent of that profile runs, and `paused` at 950 agents. The return is one object: `outcome`, `next` (the last `next` output), `closed` (one `{label, task, outcome}` per `closed` line), and `unclosed` (the count of task agents that returned without one). The script holds no comment;
  - what the session does when it returns: stamps usage from the run record in one Bash call (`tasks task set <task> --usage <tokens>` per closed task), names each task the record gives no token count, acts on `waiting` and `stuck` as the hand form acts on those lines, reading task ids for a report from `tasks status`, marks the caller's checklist from the `closed` list, and starts the drain again on `paused`.
  The hand form ("The loop") keeps its steps, and reads the new lines: step 2's `run` line drops `tasks=…`; its `waiting` line reads `waiting running=<n> blocked=<n> [fork-of <task>=<root> …]`; the stop-and-report reads the task ids from `tasks status`. Step 3's stuck rule reads "where `next` still lists the same count for a profile that as many agents were started for and none of them claimed", and reads the ids from `tasks status`. Step 3's checklist sentence stays for the hand form. "What this loop does NOT do" stays, with "the loop" covering both forms.
- `plugins/ok/families/ok-planner/scripts/tasks::format_instruction`: changed. The `run` line reads `run <profile> model=<m> effort=<e> count=<n>`. The `waiting` line reads `waiting running=<n> blocked=<n>`, then ` fork-of <task>=<root> ...` as now.
- `plugins/ok/families/ok-planner/scripts/tasks::step`: changed. The `waiting` instruction carries `running` and `blocked` counts beside `tasks` and `forks`.
- `plugins/ok/families/ok-planner/scripts/tasks` (module usage text for `tasks next`, the paragraph above `tasks init` saying `next` prints one line per profile): changed. It names the `run` line without `tasks=` and the `waiting` line with its two counts, and says `--json` keeps every id.
- `plugins/ok/families/ok-planner/skills/plan-sprint/sprint-document.md` (How to execute, step 6 and step 10): changed. Step 6 marks an entry in progress when the drain that runs its build task starts, or when its agent claims the task where the session runs the drain by hand, done when that task closes `done`, and adds the certification entry when every stage's build task has closed `done`. Its sentence "Mark that entry in progress at step 12 and done at step 13." stays. Step 10 re-renders the completion report "before every drain".
- `plugins/ok/families/ok-planner/admin/retired-boilerplate.json`: changed. Each `sprint-document.md` line steps 6 and 10 replace joins it, verbatim with its indent, in sorted order.
- `plugins/ok/families/ok-planner/scripts/ok-cheatsheet.md` (Executing a sprint): changed. "in progress at dispatch" reads "in progress when the drain that runs its build task starts"; "(created when the drain ends, …)" reads "(created when every stage's build task has closed `done`, …)"; "before every dispatch" reads "before every drain".
- `plugins/ok/families/ok-planner/scripts/ok-planner-cheatsheet.md` (Lifecycle, "marked in progress at dispatch"): changed to "marked in progress when the drain that runs its build task starts". The sentence on the drain loop names its Workflow form in one clause: the session runs it as one Workflow script per drain where the harness offers one.
- `plugins/ok/families/ok-planner/scripts/ok-planner-CLAUDE.md` ("Executing a sprint": "marked in progress at dispatch", and "before every dispatch"): changed to the same wording.
- `.ok-planner/design/decisions/drain-runs-as-a-workflow-script.md` (new), `no-execution-engine.md`, `task-tools-mirror-the-report.md`, `team-execution-cold-gate.md`: the deltas land from the sidecar, and catalog-toc runs.

**Improvements**
- **I401** `plugins/ok/families/ok-planner/skills/_tasks/drain.md` (hand form, step 2's `waiting` rule and the "Repeat until" line): the maintenance cost of one mechanism built twice with different rules. The hand form says to stop and report on any `waiting` line where an agent it started still runs, while the Workflow form the work item specifies waits for the next return there. Two forms of one loop that disagree make every later change to the loop a change to be made twice and kept in agreement. Afterward: the hand form waits for the next return while an agent it started still runs, and stops and reports only where none runs and no `fork-of` task is listed, as the script does.

**Behavior changes**
- **B409** `plugins/ok/families/ok-planner/scripts/tasks::format_instruction` (`run` line). Before: `run <profile> model=… effort=… count=N tasks=<id>,<id>,…`. After: `run <profile> model=… effort=… count=N`. Users: in the release: the hand form of `drain.md`, which reads only the profile, model, and count; the Workflow script; no other site parses the line (`rg` over `plugins/`, `docs/`, and `checks/`). Across Trued-up projects: the vendored `bin/tasks` and `.claude/skills/_tasks/drain.md` update in one true-up; the run log format does not change. Ruling: rewrite.
- **B410** `plugins/ok/families/ok-planner/scripts/tasks::format_instruction` / `step` (`waiting` line). Before: `waiting <every open task id> [fork-of <task>=<root> …]`. After: `waiting running=<n> blocked=<n> [fork-of <task>=<root> …]`; `--json` adds `running` and `blocked`. Users: in the release: both forms of `drain.md`; `skills/converge/SKILL.md` step 1 of sprint mode, which reads a `fork-of` entry under `waiting` (unchanged). Ruling: rewrite.
- **B411** `plugins/ok/families/ok-planner/skills/_tasks/drain.md` (the Workflow form). Before: the session starts every agent and wakes on every return, stamping each task's usage as its agent returns. After: where the harness offers the Workflow tool, the session wakes once per drain, stamps usage from the run record, and marks the checklist from the returned `closed` lines. Users: in the release: every caller that drains: sprint execution (`sprint-document.md` steps 6, 7, 10), `/converge` (`skills/converge/SKILL.md`), `/triage-issues`, `/plan-tests`, `/plan-docs`, `/discover-design`, and the documentation and test sprint boilerplates; each reads usage from `tasks status`, which the stamp still fills. Across Trued-up projects: the vendored drain and the vendored callers update together. Ruling: rewrite.
- **B412** `plugins/ok/families/ok-planner/skills/plan-sprint/sprint-document.md` (steps 6 and 10). Before: an entry goes in progress at dispatch, certification's entry is added when the drain ends, and the report re-renders before every dispatch. After: an entry goes in progress when its drain starts (at claim by hand), certification's entry is added when every stage's build task has closed `done`, and the report re-renders before every drain. Users: in the release: the executing session. Across Trued-up projects: every live sprint an earlier release planned carries the old lines. Ruling: migrate: the replaced lines join `admin/retired-boilerplate.json`, and true-up rewrites them in each live sprint under the owner's one consent (call, decided by decision:live-sprints-brought-current-on-true-up).
- **B413** `plugins/ok/families/ok-planner/scripts/ok-cheatsheet.md`, `ok-planner-cheatsheet.md`, `ok-planner-CLAUDE.md` (the execution and lifecycle sentences). Before: they say the checklist marks at dispatch and the report renders before every dispatch. After: they say before every drain and at the drain's start. Users: in the release: every session, through the vendored rules and `.ok-planner/CLAUDE.md`. Ruling: rewrite.
- **B414** (I401) `plugins/ok/families/ok-planner/skills/_tasks/drain.md` (hand form, `waiting`). Before: a hand-run drain that reads `waiting` while one of its agents still runs stops and reports. After: it waits for that agent's return, and stops only where none runs. Users: in the release: every caller of the hand form, as B411 lists; each acts on the drain's report only after it stops. Ruling: rewrite.

### `/discover-design` drafts a missing artifact under both answers, and planning carries the body either way

**Calls**
- The wrong answer's body lives at `[DELTAS PATH]/answers/<question>/wrong/<kind folder>/<slug>.md`, beside the stale answer's folder, so no path collides with a kind folder. Decided by: drafting call (g4).
- The question item gains no field: the wrong body's path follows from the question's key and its artifact, as the stale body's path does through `answer_path`. Decided by: the stale answer's sibling shape in `scripts/discover::answer_path`.
- The wrong body is required only for a question on a proposed artifact. A question on a live artifact keeps one body. Decided by: the work item and the amended decision ("Where a question asks about an artifact the corpus lacks").
- `{{DISCOVER-FINDING-FORMS}}` in `core.md` (the question bullet's proposed-artifact sentences) and the assembly sentence of `skills/discover-design/SKILL.md` step on `discover assemble --check` restate the question's answers, so both name the wrong answer's body. Decided by: rule 1 of the coding rules.
- `skills/plan-sprint/SKILL.md`'s rule for copying a discovery's body into the sprint's sidecar drops the `answers/<question>/wrong/` prefix as it drops `answers/<question>/`. Decided by: rule 1 of the coding rules; the sidecar layout of `{{CORPUS-DELTA-FORM}}`.
- A standing discovery an earlier release assembled holds no wrong body. Under the code-is-wrong answer on its proposed artifact, the planning session drafts the `New <kind>: <slug>` body with the owner, and the sign-off compliance review reads it as it reads every delta. Decided by: the amended decision ("either answer adds the artifact to the corpus"), and step 7 of `skills/plan-sprint/SKILL.md`, which reviews every delta.

**Changes**
- `plugins/ok/families/ok-planner/skills/discover-design/core.md` (`{{DISCOVER-FINDING-FORMS}}`, the question bullet): changed. For an artifact the audit proposes, both answers draft the artifact's body: the stale answer's as the code has it, and the wrong answer's as the text at issue has it once the code matches.
- `plugins/ok/families/ok-planner/skills/discover-design/core.md` (`{{DISCOVER-MERGE-PROMPT}}`, Merge step 6): changed. For an artifact the audit proposes, the wrong answer is the work item plus the artifact's whole body as the text at issue has it once the code matches, written at `[DELTAS PATH]/answers/<question>/wrong/<kind folder>/<slug>.md` per the template, its frontmatter naming the artifact.
- `plugins/ok/families/ok-planner/skills/discover-design/core.md` (`{{DISCOVER-REVIEW-PROMPT}}`, Check): changed. The question bullet checks both bodies of a question on a proposed artifact against the definitions and templates, and the reviewer reads each body under [DELTAS PATH]/ either answer names.
- `plugins/ok/families/ok-planner/scripts/discover::wrong_answer_path`: new. `os.path.join(deltas, "answers", qid, "wrong")` joined with the kind folder and slug through `body_path`.
- `plugins/ok/families/ok-planner/scripts/discover::question_failures`: changed. For a question where `proposed(question)` holds, it refuses where no body stands at the wrong-answer path, and where that body's frontmatter does not name the artifact, each failure naming the path and the question, in the form of the stale body's failures.
- `plugins/ok/families/ok-planner/scripts/discover::stray_bodies`: changed. A proposed question's wrong-answer path counts as named. A body under `answers/<question>/wrong/` for any other question stays stray.
- `plugins/ok/families/ok-planner/scripts/discover::question_section`: changed. For a proposed artifact, the Artifact line reads that the corpus does not hold it and either answer creates it, and under `If the code is wrong` a line names the wrong answer's body path.
- `plugins/ok/families/ok-planner/scripts/discover::assembled`: changed. The refusal of an ordinary delta beside a question on a proposed artifact reads `delta <key>: question <id>'s answers create the artifact; withdraw the delta`.
- `plugins/ok/families/ok-planner/skills/discover-design/SKILL.md` (the `discover assemble --check` paragraph): changed. It names the check of the wrong answer's body for a question on a proposed artifact.
- `plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md` (Dialogue, the A discovery bullet on questions, and the corpus-deltas paragraph's sidecar copy rule): changed. Under *The code is wrong* on a proposed artifact, the session carries the work item and a `New <kind>: <slug>` delta whose body is the wrong answer's body, or a body it drafts with the owner where the discovery holds none (call above). The copy rule drops the `answers/<question>/wrong/` prefix too.
- `.ok-planner/design/decisions/corpus-audit-hands-a-discovery-to-planning.md`: the delta lands from the sidecar, and catalog-toc runs.

**Behavior changes**
- **B415** `plugins/ok/families/ok-planner/skills/discover-design/core.md` (merge step 6, the finding forms, the review check). Before: a question on a proposed artifact drafts one body, under the stale answer. After: it drafts a second body under the wrong answer, and the review checks both. Users: in the release: the merge and review agents of `/discover-design`; `discover assemble`, which checks the bodies. Ruling: rewrite.
- **B416** `plugins/ok/families/ok-planner/scripts/discover::question_failures` / `stray_bodies`. Before: `discover assemble` accepts a proposed-artifact question with one body, and counts any other body under `answers/` but the stale one as stray. After: it refuses such a question with no wrong-answer body, or with one whose frontmatter does not name the artifact, and counts the wrong-answer body as named. Users: in the release: the assembly step of `skills/discover-design/SKILL.md`, which refiles the merge task each failure names. Across Trued-up projects: a discovery run an earlier release started and this release assembles. Ruling: migrate: `discover assemble` refuses that run's proposed-artifact questions, naming the missing body's path, and the skill's refile loop has the merge write it (call).
- **B417** `plugins/ok/families/ok-planner/scripts/discover::question_section` / `assembled` (texts). Before: the discovery says the stale answer creates the proposed artifact, and the assembler's refusal says the stale answer creates it. After: the discovery says either answer creates it and names the wrong body's path, and the refusal says the question's answers create it. Users: in the release: `/plan-sprint`, which reads the discovery whole; the session that reads the refusal. Ruling: rewrite.
- **B418** `plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md` (the discovery walk). Before: under the code-is-wrong answer on a proposed artifact, the sprint carries the work item alone, so the corpus still lacks the artifact. After: it carries the work item and a `New` delta from the wrong body. Users: in the release: the owner at the walk; the build stage that applies the delta. Across Trued-up projects: a standing discovery under `.ok-planner/discoveries/` an earlier release assembled, which holds no wrong body. Ruling: migrate: the session drafts the body with the owner and sends it through the sign-off compliance review (call).

### `review prompt --name build` writes the sprint build prompt, and step 3 calls it

**Calls**
- `cmd_prompt` applies every line rule at every depth, whole-line slots included, and refuses a block cycle. Decided by: drafting call (g4).
- No delta to decision:single-source-transclusion: the template holds only the token, and the review tool still writes the prompt. Decided by: drafting call (g4).
- A pasted block's header drop and dedent run before the line rules apply to its lines. The dedent removes the indent every non-blank line of the block shares. Decided by: the work item ("drops that line and the indent its other lines share"), and the token pattern, which already allows leading space.
- The cycle refusal reads `prompt <name>: block <A> names <B>, which names <A>: <A> -> <B> -> <A>`. Decided by: the work item ("refused with the chain of names").
- `review prompt --name build` changes nothing for the loop's own prompts: no block in the seeded `block_sources` holds a nested token line, a whole-line slot, `[SPRINT PATH]`, `[BASE]`, or a header line, save `{{SPRINT-BUILD-PROMPT}}`, which no converge template names. Decided by: a read of every block in `_shared/dispatch-discipline.md`, `_converge/coding-rules.md`, and `_sprint/shared.md`.
- A project whose `review/config.json` `block_sources` lacks `_sprint/shared.md` gets the tool's refusal naming `SPRINT-BUILD-PROMPT`; sprint certification already needs that source for `{{SPRINT-CATALOG}}`, so no migration is added. Decided by: the refusal names the block, and true-up's config check already drafts a missing seed key.
- `project.md`'s review tool entry stays: the change adds no input. Decided by: the build prompt's rule, which names a changed input.
- The help line reads `assemble a prompt from its template into a file`. Decided by: the work item.

**Changes**
- `plugins/ok/families/ok-planner/skills/converge/prompts/build.md`: new. One line, `{{SPRINT-BUILD-PROMPT}}`.
- `plugins/ok/families/ok-planner/scripts/review::cmd_prompt`: changed. It applies one line function to the template's lines and, recursively, to each pasted block's lines: a token line is replaced by its block (header line dropped and shared indent removed where the block's body opens with `Task prompt (profile <name>):`), its lines run through the same function; a whole-line slot is replaced by its value; every other line has `[SPRINT PATH]` and `[BASE]` filled. A chain that returns to a block it is inside is refused with `ReviewError` naming the chain. The output is written as now.
- `plugins/ok/families/ok-planner/scripts/review::VERB_HELP["prompt"]`: changed, per the call above.
- `plugins/ok/families/ok-planner/skills/plan-sprint/sprint-document.md` (How to execute, step 3): changed. It registers the build prompt with `.ok-planner/bin/review prompt --name build --sprint <this sprint's path> --out .ok-planner/sprints/<sprint-name>-build.md`, then `tasks prompt register build <that path>`. The rest of step 3 stays.
- `plugins/ok/families/ok-planner/admin/retired-boilerplate.json`: changed. Each step-3 line the change replaces joins it, verbatim, sorted.
- `plugins/ok/families/ok-planner/skills/_sprint/shared.md` (`{{SPRINT-REVIEW-READING}}`, the note above the fence): changed. It drops "`review prompt` fills no slot inside a block, so"; the note says the block names the base commit `<base>` and the sprint's path `<sprint>`, which the prompt states above it.

**Behavior changes**
- **B419** `plugins/ok/families/ok-planner/scripts/review::cmd_prompt`. Before: a token line inside a pasted block is copied as text, `[SPRINT PATH]` and `[BASE]` stay unfilled inside a block, and a block's header and indent are kept. After: nested tokens resolve, slots fill at every depth, the header and shared indent drop, and a cycle is refused. Users: in the release: `/converge`'s prompt step (`skills/converge/SKILL.md` step 4), whose prompts come out byte for byte the same (call above); sprint execution step 3. Across Trued-up projects: a project's own `block_sources` entries beyond the seed, whose blocks would now resolve nested tokens; none in the seed. Ruling: rewrite.
- **B420** `plugins/ok/families/ok-planner/scripts/review::VERB_HELP["prompt"]`. Before: the help says the verb assembles one of the loop's prompts. After: it says it assembles a prompt from its template. Users: in the release: a reader of `review --help`. Ruling: rewrite.
- **B421** `plugins/ok/families/ok-planner/skills/plan-sprint/sprint-document.md` (step 3). Before: the session resolves the build prompt's transclusions by hand. After: one `review prompt` command writes it. Users: in the release: the executing session. Across Trued-up projects: live sprints carry the old step 3. Ruling: migrate: the replaced lines join `admin/retired-boilerplate.json`, and true-up brings each live sprint's step 3 current under the owner's consent (call, decided by decision:live-sprints-brought-current-on-true-up). A live sprint's `-build.md` already written stays as written.
- **B422** `plugins/ok/families/ok-planner/skills/_sprint/shared.md::{{SPRINT-REVIEW-READING}}` (note). Before: the note says `review prompt` fills no slot inside a block. After: it does not. Users: in the release: the sprint review root and a reissued pass, which read the block; the placeholders `<base>` and `<sprint>` stay. Ruling: rewrite.

### The DOM picker reference file carries no prose comment

**Calls**
- Delete lines 1 to 14: the 13-line header and the blank line after it, so the file opens at `interface SelectedDescriptor {`. A leading blank line would be residue of the deletion. Decided by: rule 1.4 (delete what only the removed text used).
- The skill text stays as it is. "## The contract" in `plugins/ok-web/skills/setup-dom-picker/SKILL.md` already states the globals, the stamp, the descriptor, and the dev-only import, and it says a frontend is brought "in line with this behavior, not to byte-identical source". Decided by: the work item.

**Changes**
- `plugins/ok-web/skills/setup-dom-picker/reference/dom-picker.ts`: changed. Lines 1 to 14 are deleted. A search shows lines 1 to 13 are the only comment lines in the file. Afterward the file's comment-hygiene findings are zero.

**Behavior changes**
- **B314** `plugins/ok-web/skills/setup-dom-picker/reference/dom-picker.ts`. Before: `/setup-dom-picker` copies a reference that opens with a 13-line prose header into a frontend with no picker. After: the copy has no header. Users: in the release: the skill. Across Installed plugins: each project the skill sets up. A picker copied earlier stays, since "An existing picker that meets the contract stays as it is". Ruling: preserve (call). The change removes only the A8 harm, and no caller relies on comment text.

### One definition reads and writes a sprint's closed stamp

**Calls**
- Notes review: the one `closed_stamp` returns the first `closed:` line in the frontmatter whose value is a 7 to 40 character hex commit. That keeps every stored file `docs` and `tests` read today, and still removes the B501 harm in `review certified`. I502 and B505 read today's `docs` and `tests` behavior that way: they skip a non-hex `closed:` line and return the first hex one. Decided by: stored state is a release boundary.
- No drafting call bears on this work item. Decided by: `drafting-calls.md`, every batch read.
- The one definition lives in `plugins/ok/families/ok-planner/scripts/review`, and `docs` and `tests` load it with `load_sibling("review")`. Decided by: `review` already holds `frontmatter_value`, the only general frontmatter parse of the three, and the `approved:` reader. `review` loads only `issues`, and `issues` loads `tasks`, so `docs -> review` and `tests -> review` close no cycle. `discover` already loads `review` this way. Rule 6 of `plumbline-coding.md`.
- `docs` and `tests` gain `load_sibling` in the shape of `review::load_sibling` and `discover::load_sibling`, as a module-level `review = load_sibling("review")` after the imports. Decided by: rule 2, the sibling's shape. Every family script that shares code loads it this way.
- `admin/true-up::EXECUTABLE_FILES` keeps `scripts/review` before `scripts/docs` and `scripts/tests`. This already holds at the commit. `materialize` probes each script with `--help` right after writing it, and a `docs` or `tests` probe now loads `.ok-planner/bin/review`, so `review` has to be written first. Decided by: `true-up::materialize` and `true-up::probe`.
- The one parse reads frontmatter this way. Line 1, stripped, is `---`. The block ends at the next line that is `---` when stripped. A block that never closes is no frontmatter. Each key line is matched after `strip()`. Decided by: the closing rule follows `review::frontmatter_value`, and `with_closed_stamp` already treats an unclosed block as none. The strip rule follows `docs` and `tests`, which are two of the three readers, and it reads a CRLF file the same way as an LF file.
- `closed_stamp(text)` is `frontmatter_value(text, "closed")` when that value matches `^[0-9a-f]{7,40}$`, and `None` otherwise. The pattern is defined once, as `review::CLOSED_STAMP`. Decided by: the work item ("a hex commit of 7 to 40 characters").
- `with_closed_stamp(text, sha)` asserts that `sha` matches the stamp pattern, and the assertion message names the value. This keeps the writer from writing a stamp the reader refuses. `docs::cmd_stamp` and `tests::cmd_stamp` keep their own `SHA` check of `--commit`, because that check refuses a user's value with a message the user can act on. Decided by: the cheatsheet's mechanical-checks rule and rule 4.8.
- `checks/oscillation::close_commits` is a fourth reader of a sprint's closed stamp. It searches the whole file with `re.M` and does not anchor the end. It joins the change and reads the stamp through the same definition. It loads `plugins/ok/families/ok-planner/scripts/review` as a module, in the `load_sibling` shape, from the path the check already roots at `ROOT`. Decided by: rules 1, 6.3, and 8.1, which treat every reader of the stamp as one class. On this repository's `.ok-planner/history/sprints/`, every file reads the same stamp under both readings. That was checked file by file.
- `plugins/ok/families/ok-planner/CLAUDE.md`, the `scripts/review` line, adds that the script also holds the sprint frontmatter reading, which `docs` and `tests` load. Decided by: rule 1, every text that describes the module.
- `docs` and `tests` are also changed by other work items of this sprint, `tests` by many of them. Every stage that touches either file chains with `--after` on this one. Decided by: the boilerplate's step 4 on overlapping files.

**Changes**
- `plugins/ok/families/ok-planner/scripts/review::CLOSED_STAMP`: new. The compiled pattern `^[0-9a-f]{7,40}$` for a `closed:` value.
- `plugins/ok/families/ok-planner/scripts/review::frontmatter_value`: changed. It reads the frontmatter under the rule in Calls: fence lines and key lines are compared after `strip()`, and a block with no closing fence is none. It still returns the first key line's non-empty value. `approval_refusal` keeps calling it for `approved`.
- `plugins/ok/families/ok-planner/scripts/review::closed_stamp`: new. It returns the `closed:` value where it is a 7 to 40 character hex commit, else `None`.
- `plugins/ok/families/ok-planner/scripts/review::with_closed_stamp`: new, moved from `docs` and `tests`. It asserts the sha, removes every `closed:` key line in the frontmatter (I502), and writes `closed: <sha>` as the frontmatter's last line. Where the frontmatter is missing or never closes, it opens a new block above the text, as now.
- `plugins/ok/families/ok-planner/scripts/review::cmd_certified`: changed. It reads the stamp with `closed_stamp(text)` in place of `frontmatter_value(text, "closed")`.
- `plugins/ok/families/ok-planner/scripts/docs::load_sibling`, and module-level `review`: new.
- `plugins/ok/families/ok-planner/scripts/docs::CLOSED_STAMP`, `::closed_stamp`, `::with_closed_stamp`: removed.
- `plugins/ok/families/ok-planner/scripts/docs::sprints_closed_since`, `::cmd_complete`, `::cmd_stamp`: changed. Each calls `review.closed_stamp` or `review.with_closed_stamp`. Under I501, `sprints_closed_since` is removed and its caller `window_entry` calls `review.sprints_closed_since`.
- `plugins/ok/families/ok-planner/scripts/tests::load_sibling`, and module-level `review`: new.
- `plugins/ok/families/ok-planner/scripts/tests::CLOSED_STAMP`, `::closed_stamp`, `::with_closed_stamp`: removed.
- `plugins/ok/families/ok-planner/scripts/tests::sprints_closed_since`, `::cmd_complete`, `::cmd_stamp`: changed, as in `docs`.
- `checks/oscillation::close_commits`: changed. It loads the family's `review` and reads each archived sprint's stamp with `closed_stamp`, in place of its own `re.search`. It still skips a stamp that resolves to no commit.
- `plugins/ok/families/ok-planner/CLAUDE.md`, the `scripts/review` line: changed, as in Calls.

Enumerated sites, for the task note: `scripts/docs:71,262-287,571,602-609,646`; `scripts/tests:95,206-241,1404,1467`; `scripts/review:1503-1511,1516,1784`; `checks/oscillation:19-36`; `CLAUDE.md:35`. That is 5 files. Other readers were checked and left alone. `admin/true-up::frontmatter` reads issue markdown, not a sprint. `catalog-toc::frontmatter_lines` and `discover::frontmatter_names` read corpus artifacts. Skill prose that tells an agent to read or add `closed:` (`plan-sprint/SKILL.md` step 1 of Reconcile, `sprint-document.md`'s archive step 4) describes the stamp and needs no code.

**Improvements**
- **I501** `plugins/ok/families/ok-planner/scripts/review::sprints_closed_since` (new), with `review::is_ancestor` (new): `docs::sprints_closed_since` and `tests::sprints_closed_since` are byte-identical copies of one mechanism, both changed above. The same holds for `docs::is_ancestor` and `tests::is_ancestor`, which that mechanism calls. This is a rule 6 cost. Afterward one `sprints_closed_since(root, stamp)` lives in `review`. It reads each archived sprint under `review::ARCHIVED_SPRINTS` with `errors="replace"`, as the copies do, so a file that is not UTF-8 still reads. One `is_ancestor` lives beside it. `docs` and `tests` delete both copies and call `review.sprints_closed_since` and `review.is_ancestor`, the latter from `cmd_stamp`. No behavior changes.
- **I502** `plugins/ok/families/ok-planner/scripts/review::with_closed_stamp`: today's writer removes only a `closed:` line that already holds a hex commit. A `closed:` line with any other value, such as an unfilled `closed: <sha>`, stays above the new stamp. The reader takes the first `closed:` key, so it reads the stale value and finds no stamp. `docs stamp` and `tests stamp` still print `closed: <sha> added`. This is A9. Afterward the writer removes every `closed:` key line before it writes the stamp, so what it prints is what the reader reads.

**Behavior changes**
- **B501** `plugins/ok/families/ok-planner/scripts/review::cmd_certified`. Before: an archived sprint whose frontmatter holds any non-empty `closed:` value (`closed: <the commit's sha>` left unfilled, upper-case hex, a value with a trailing note) reads as terminal, and `review certified` prints `SPRINT COMPLETE`. After: only a 7 to 40 character lower-case hex value reads as terminal. Any other value reads as no stamp, and the contract is checked. Users: in the release, the executing session and `/goal`'s checker, through the boilerplate's goal rule ("a sprint already archived with a `closed:` stamp is terminal"). That rule's wording holds, because a value that names no commit is no stamp. Across stored state and Trued-up projects: archived sprints in each project. Ruling: migrate: every stamp the archive step writes is a commit sha and reads terminal as before; a value that names no commit reads as no stamp, and reading it as terminal is the A9 harm the fix removes, which no user may rely on (call).
- **B502** `plugins/ok/families/ok-planner/scripts/review::frontmatter_value`. Before: `review approved` and `review certified` find no frontmatter where a fence line carries trailing whitespace or a CR, and no key whose line is indented. `review approved` then refuses an approved sprint. After: those fences and keys read. Users: in the release, step 2 of the boilerplate (`review approved`) and `review certified`. Across stored state: live and archived sprints in trued-up projects. Ruling: preserve: every sprint that read before reads the same, and only a sprint refused before now reads (call).
- **B503** `plugins/ok/families/ok-planner/scripts/docs::sprints_closed_since`, `docs::cmd_complete`, `tests::sprints_closed_since`, `tests::cmd_complete`. Before: a file whose first line is `---` and which has no closing fence is scanned to its end, and any `closed: <hex>` line counts as its stamp. After: such a file has no frontmatter and no stamp, which is how `with_closed_stamp` already reads it. Users: in the release, `docs window` and `tests window` (the sprints closed since a stamp), and `docs complete` and `tests complete` (the terminal check). Across stored state: archived sprints, documentation sprints, and test sprints. Ruling: migrate: every stamp a stamp verb or the archive step wrote sits in a closed block and reads as before (call).
- **B504** `checks/oscillation::close_commits`. Before: the first line anywhere in an archived file that starts `closed: <7+ hex>` counts, a longer non-hex tail included. After: only the frontmatter's whole-line stamp counts. Users: in the release, `checks/run`. This repository's history reads the same under both. Ruling: rewrite.
- **B505** `plugins/ok/families/ok-planner/scripts/review::with_closed_stamp` (I502). Before: `docs stamp` and `tests stamp` leave a non-hex `closed:` line beside the new stamp, and the stamp reads as absent. After: the new stamp replaces every `closed:` line and reads. Users: in the release, the archive steps of the documentation and test sprints' boilerplate. Across stored state: an archived documentation or test sprint that holds a non-hex `closed:` line. Ruling: migrate: such a file gets a stamp that reads on its next stamp; every other file is written as before (call).

### /converge's fix loop handles a defect a done fix task left at fixing

**Calls**
- `tasks::check_sweep` refuses a `done` close of a task of a swept role while any item its batch marked still stands at the state the batch marked it with, naming each such item: `a <role> task closes done only once every item its batch marked <state> has left that state: <ids>; settle each, or close partial`. Decided by: the work item names `check_sweep`, the sibling refusal for missing sites sits there, and rule 3.2 of the coding rules (a check before the write that would leave the state wrong).
- `tasks::cmd_batch` records the mark on each task it files, as `batch_mark`, and `COPIED_ON_REFILE` carries it, so a refile keeps the check. A task filed before this change carries no `batch_mark`, and the check skips it. Decided by: the run log crosses the Trued-up projects boundary, so the read must accept old records.
- After the round's fix tasks close, the session sends every defect of the round still at `fixing` back to `open`, `kickbacks` raised by one, whatever the close: a `done` close (a run file the new refusal does not cover) the same as a second failed close. The `outside files:` wait keeps its own rule and runs first. Decided by: the work item ("a defect still at `fixing` after any close of its fix task goes back to `open`"), and Loop 2's cap on `kickbacks`, which then bounds the loop.
- `review verifies` prints, beside `verify_tasks`, `fixing`: each defect a closed chain's batch holds that still stands at `fixing`. Step 5 sends each one back as step 4 does before it files a verifier. The set that picks verified defects, `VERIFIED_STATES`, stays; a new constant `UNFINISHED_FIX_STATES = ("fixing",)` names the state the new list reads. Decided by: rule 7.4 of the coding rules (a set that decides a state transition names every member), and the work item.
- The end check reads "where no defect stands at `open` or `fixing`". Decided by: the work item ("the loop does not end while a defect stands at `fixing`").
- `prompts/fix.md`'s Close line gains one sentence: a defect you leave at `fixing` makes a `done` close refuse; set it, or close `partial`. Decided by: the new refusal, whose user the fixer is.

**Changes**
- `plugins/ok/families/ok-planner/scripts/tasks::cmd_batch`: changed. Each task it files records `batch_mark` (the `--mark` value; absent where `--mark` is absent).
- `plugins/ok/families/ok-planner/scripts/tasks::COPIED_ON_REFILE`: changed. It names `batch_mark`.
- `plugins/ok/families/ok-planner/scripts/tasks::check_sweep`: changed. After the sites checks, for a `done` close of a swept role with `batch_mark`, it reads each `batch_items` item and refuses, per the call above, where any stands at `batch_mark`.
- `plugins/ok/families/ok-planner/scripts/review::cmd_verifies`: changed. It collects, from each closed chain's batch items, those whose state is in `UNFINISHED_FIX_STATES`, and prints them under `fixing` in its JSON.
- `plugins/ok/families/ok-planner/scripts/review::UNFINISHED_FIX_STATES`: new. `("fixing",)`.
- `plugins/ok/families/ok-planner/skills/converge/SKILL.md` (Loop 2 steps 2, 4, 5): changed. Step 2's end check names `fixing`. Step 4 adds, after its existing close rules, that every defect of the round still `fixing` once its fix task's chain has closed goes back to `open` with `kickbacks` raised by one. Step 5 sends back each defect `review verifies` lists under `fixing` the same way before draining the verifiers.
- `plugins/ok/families/ok-planner/skills/converge/prompts/owner-list.md` (Read, the defects bullet; "a defect the run did not finish"): changed. It reads the defects still `open`, `fixing`, or `fixed`, and files each as a defect the run did not finish.
- `plugins/ok/families/ok-planner/skills/converge/prompts/fix.md` (Close): changed, per the call above.

**Behavior changes**
- **B423** `plugins/ok/families/ok-planner/scripts/tasks::check_sweep` / `cmd_batch`. Before: a fix task closes `done` with a defect of its batch still at `fixing`. After: the close refuses and names the defect; a batched task records `batch_mark`. Users: in the release: the fixer (`prompts/fix.md`); every swept role a ceremony batches with `--mark` (only `fix` today; `build` tasks are not batched; triage's batched roles are not swept). Across Trued-up projects: run files an earlier release wrote, whose tasks carry no `batch_mark`. Ruling: preserve (call): an old task skips the check, and the new field is additive to the run log.
- **B424** `plugins/ok/families/ok-planner/scripts/review::cmd_verifies`. Before: its JSON holds `verify_tasks` alone, and a defect a closed chain left at `fixing` is silently skipped. After: the JSON adds `fixing`. Users: in the release: Loop 2 step 5 of `skills/converge/SKILL.md`. Ruling: rewrite.
- **B425** `plugins/ok/families/ok-planner/skills/converge/SKILL.md` (Loop 2). Before: a defect a done fix task left at `fixing` gets no verifier, the end check passes, and the run ends with it unsettled. After: it goes back to `open` with a send-back counted, and the loop runs until it settles or reaches `stuck`. Users: in the release: every `/converge` mode; `review certified`, which already counts `fixing` as unsettled. Ruling: rewrite.
- **B426** `plugins/ok/families/ok-planner/skills/converge/prompts/owner-list.md`. Before: the owner list reads only defects at `open` or `fixed` among the unfinished, so one at `fixing` reaches no issue. After: it files a defect at `fixing` as one the run did not finish. Users: in the release: the intake and the next `/converge`. Ruling: rewrite.

### The lint checks a Python docstring as a documentation comment

**Calls**
- Build note: `scripts/surface-corpus` and `scripts/tasks` hold a module-level string after `VERSION = "{{OK_PLANNER_VERSION}}"`. The Python lexer counts that assignment as the first statement, so neither string is a docstring, matching the 15-docstring enumeration.
- Python gets a lexer of its own, `extractPythonRawComments(content)`. `extractRawComments` dispatches to it for a grammar marked `python: true`, as it dispatches to `extractShellRawComments` for `shell: true`. The `.py` grammar, which the Python shebang grammar shares, gains `python: true`. Decided by: plumbline-coding rule 2 (the shell lexer is the sibling for a language whose strings and comments the generic scanner cannot read).
- The lexer reads `"""` and `'''` strings whole, with an optional prefix of `r`, `u`, `b`, `f`, or two of them in either case, and honors a backslash escape. A `#` inside any string is text. Decided by: the docstring check cannot see a docstring that the scanner splits into `""` plus a one-quote string.
- A docstring is a string literal, single- or triple-quoted, standing alone as the first statement of the module, of a `class` body, or of a `def` or `async def` body, the one-line `def f(): "doc"` form included. Only whitespace, a `;`, a `#` comment, or the line's end may follow it. A literal with a `b` or `f` prefix is not one, and neither is the first statement of any other block. A header's `:` counts only at bracket depth 0, so annotations, defaults, and lambdas inside the brackets do not end the header. Decided by: Python's own rule (`ast.get_docstring`), which the work item's "a docstring on a Python module, class, or function" names.
- The lexer returns each docstring as `{ text, line, kind: 'docstring' }`. `checkCommentHygiene` passes it where `docstringsAllowed`, beside the JSDoc and Go doc branches. Elsewhere its significant lines go through the same machine-directive and clean-citation filter as every other comment, so a module docstring that is a license header stands as a `#` license header does. Decided by: the cheatsheet's machine-directive rule (license headers), and one path for every comment ("one idiom per job").
- A docstring's violation message reads "docstring is a documentation comment, permitted only in a file an in-code docspec or a committed earlier marker covers". The marker message is unchanged. `commentRefusal` takes the comment's kind. Decided by: plumbline-coding rule 7.5 (the message names the case on its branch).
- Python inside a shell heredoc, as in `admin/true-up`, stays unlinted. The shell lexer skips heredoc bodies today, `#` comments included. Decided by: plumbline-coding rule 8.4 (no wider mechanism than the defect asks).
- No rules text changes. The cheatsheet's documentation-comment rule and decision:comments-forbidden-by-default already cover docstrings as documentation comments. Decided by: the work item and the decision.
- The project's own docstrings: see the kickback. Rule 1 enumeration of the docstrings the fixed lint refuses (a scan with `ast.get_docstring` over every tracked Python file outside `.ok-planner/`): `ok-planner/scripts/tasks::instructions` (line 578), `::step` (617), `::oldest_issued` (836); `checks/owned-paths::unquote` (43), `::bash_lines` (54), `::_segments` (98), `::check_bash_file_ops` (105), `::check_forbidden_git` (141), `::call_args` (170), `::check_sites` (202), `::check_git_helper` (266), `::check_destinations` (302); `checks/oscillation::close_commits` (19), `::sections_at` (40), `::sections_edited` (66). Count: 15 docstrings in 3 files. None of the 3 files holds a committed `@plumbline:allow-docstrings` marker, and no in-code docspec names any of them. `tasks::instructions` and `::step` are the functions the work item "The drain runs as a Workflow script, so the session wakes once per drain, and `tasks next` prints counts" rewrites, so that stage and this one chain.
- Sprint certification's check, `node .ok-planner/bin/plumbline`, runs the vendored v28 lint, which does not see docstrings. `checks/materialized-standalone` runs the canonical lint, which this change fixes. Decided by: `.ok-planner/review/config.json` `checks` and `checks/materialized-standalone::LINT`.

**Changes**
- `ok-planner/scripts/plumbline::COMMENT_GRAMMARS['.py']`: changed. It gains `python: true`.
- New `ok-planner/scripts/plumbline::extractPythonRawComments`: Python's lexer. It returns `#` line comments as the generic scanner does (`line`, `kind: 'line'`, `trailing`), and docstrings as `kind: 'docstring'`, after reading prefixed and triple-quoted strings whole.
- `ok-planner/scripts/plumbline::extractRawComments`: changed. It dispatches `python: true` to the new lexer.
- `ok-planner/scripts/plumbline::checkCommentHygiene`: changed. A `docstring` comment passes where `docstringsAllowed`. Otherwise its lines that survive the directive and citation filter are violations with the docstring message.
- `ok-planner/scripts/plumbline::commentRefusal`: changed. It takes the comment's kind and returns the docstring message for a docstring line.
- The 15 docstrings above: deleted, pending the kickback's resolution.

**Behavior changes**
- **B219** `ok-planner/scripts/plumbline::checkCommentHygiene` and `extractRawComments`. Before: a Python docstring passes in any file. After: in a file that no in-code docspec names and that holds no committed marker, each docstring line that is not a machine directive or a clean citation fails `comment-hygiene` and makes the lint exit 2. The edit hook blocks a docstring an edit adds or changes, and a whole-file run refuses each one.
  Users: in the release: the edit hook (`scripts/hooks/post-edit.js`, through the vendored lint on `/ok`), the review checks, and `checks/materialized-standalone`, which lints the payload's materialized copies with the canonical lint. That check fails on the materialized `bin/tasks`'s three docstrings until they go. Across trued-up projects: each consumer whose Python carries docstrings outside an in-code docspec's files sees the lint refuse them after `/ok`: on the changed lines at edit time, and on the whole of each changed file in review.
  Ruling: migrate: decision:comments-forbidden-by-default already forbids these docstrings. The change removes only the A8 harm of a written constraint with no check, which no caller may rely on, and the message names the in-code docspec and the committed marker, the two routes to keep one (call).
- **B220** `ok-planner/scripts/plumbline::extractRawComments`, for Python. Before: `"""` reads as an empty string followed by a one-quote string. A `#` inside a triple-quoted string that holds a quote can be reported as a comment, and a real `#` comment after a mis-read `'''it's'''` can be hidden. After: a triple-quoted string reads whole. No text inside a string is reported, and every `#` comment outside one is.
  Users: as B219.
  Ruling: migrate: every refusal the change adds is of a comment the decision forbids, and every refusal it drops was false (call).

### issues show prints a message's edited and withdrawn marks

**Calls**
- A person's message line adds `, edited <stamp>` where `edited` stands and `, withdrawn <stamp>` where `withdrawn` stands, after its seen mark. Under the text, an `earlier:` line lists each earlier text, oldest first, indented as the update diff is. Decided by: the `issues show` sibling shape for an update's diff in `message_line`, and `{{ISSUE-FILE-FORMAT}}`'s message table (`earlier`, `edited`, `withdrawn`).
- A withdrawn message keeps its text in the print, as the record keeps it. Decided by: `{{ISSUE-FILE-FORMAT}}` ("with its text kept").

**Changes**
- `plugins/ok/families/ok-planner/scripts/issues::message_line`: changed. For a person's message, the head adds the edited and withdrawn marks, and the body adds the earlier texts, per the calls above. Agent messages print as now.
- `plugins/ok/families/ok-planner/skills/triage-issues/prompts/respond.md` (Read step 1): changed. It says `issues show` marks each person's message edited or withdrawn, with when, and prints an edited message's earlier texts, which "Judge each unseen message" acts on.

**Behavior changes**
- **B427** `plugins/ok/families/ok-planner/scripts/issues::message_line`. Before: the text form of `issues show` prints an edited message as a plain `not yet seen` message with its current text, and a withdrawn message as a plain seen one. After: each prints its mark, and an edited one its earlier texts. Users: in the release: the respond, author, and triage agents, which read `issues show`; `/plan-sprint`'s issue walks; a person at a terminal. The dashboard and every `--json` reader read the record, not this text. Across Trued-up projects: the vendored module updates with the prompts. Ruling: rewrite.
- **B428** `plugins/ok/families/ok-planner/skills/triage-issues/prompts/respond.md` (Read step 1). Before: step 1 says the show prints each message seen or not yet seen. After: it names the edited and withdrawn marks and the earlier texts. Users: in the release: the respond agent. Ruling: rewrite.

### docs complete refuses a documentation sprint that checked no claim

**Calls**
- Build note: boilerplate step 7 gives the checker every claim of each `write` and `change` item's file, not only of a file the run changed, so B213's `scope=file` requirement has a checker to meet it.
- "A file it wrote or changed" means each `write` or `change` item whose file still exists. A `drop` item needs no claim, and its file is gone, or, for an `in code:` drop, holds no documentation. Decided by: decision:documentation-claim-ledger ("checks every claim in a file it changes").
- A file counts as checked where the `claims` pool holds at least one item with the docspec's key, that file as its `file`, `scope=file`, and no `generator` field, in any state. A `cut` or `replaced` claim shows the file was checked. A generator run's claim names a source file by convention and does not count. Decided by: `{{DOC-CHECK-PROMPT}}`, which records `scope=file` where every claim in the file was checked.
- The failure reads ``docspec:<slug>: `<file>` (<write|change>) has no claim checked: no checker recorded its claims with scope file``. It names what was not checked. Decided by: the work item ("naming what was not checked") and the sibling failures in `complete_failures`.
- A written file that makes no claim at all fails this check. The session works the failure as boilerplate step 8 says, or names it as a blocker. No checker provision is added for an empty file. Decided by: `{{DOC-CLAIM-DEFINITION}}`, under which a link, an example, or any statement of what the project does is a claim, so a documentation file with none falls outside what a docspec keeps.
- The contract's new term joins item 2, which governs claims. Item 1 governs tasks. Decided by: the contract's existing grouping.

**Changes**
- `ok-planner/scripts/docs::complete_failures`: changed. For each planned `write` or `change` item whose file exists, it requires a `scope=file` claim of that file, and otherwise adds the failure above.
- `ok-planner/skills/plan-docs/doc-sprint-document.md`, Completion contract item 2: changed. It adds: "Every file a `write` or `change` item names that still exists has a claim the checkers recorded with scope `file`." (See I201 for its second sentence.)

**Improvements**
- **I201** `ok-planner/scripts/docs::complete_failures`: A9. A `check` item exists only because something in its file must be checked: a stale ledger claim, a change since the stamp, a `taken` file, or a docspec with no stamp. A run that filed no checker for it still prints `DOCS COMPLETE`. Afterward: each `check` item whose file exists must hold at least one non-generator claim of its file, any scope, or `complete_failures` adds ``docspec:<slug>: `<file>` (check) has no claim checked``. Contract item 2 adds "and every file a `check` item names holds a claim the checkers recorded."

**Behavior changes**
- **B213** `ok-planner/scripts/docs::complete_failures`. Before: a run that wrote or changed files and filed no checker task prints `DOCS COMPLETE`, and the stamp then keeps old ledger claims about rewritten files. After: it prints `DOCS NOT COMPLETE` and names each written or changed file with no `scope=file` claim.
  Users: in the release: boilerplate step 8, whose session works each failure, and the `/goal` checker, which reads the line. Across trued-up projects: none; the boundary leaves out an open documentation sprint, and `docs complete` reads an archived documentation sprint with a `closed:` stamp as terminal and runs no check.
  Ruling: rewrite. The change removes only the A9 harm of a false `DOCS COMPLETE`, which no caller may rely on, and the failure names the file to check.
- **B214** (I201) `ok-planner/scripts/docs::complete_failures`. Before: a `check` item no checker reached passes. After: it fails and is named.
  Users: as B213.
  Ruling: rewrite, as B213.

### The documentation planner reports the reshape gaps its own step found

**Calls**
- The Output line reads "Then `Reshape:` and one line per gap step 7 found: what keeps the docspec from being planned well, or `none`." The step number stays, with its job beside it, so a reader can match the line to the step. Items 1 and 2 add no numbered step, so step 7 stays the step that finds reshape gaps. Decided by: the work item.
- Rule 1 enumeration: `rg "step 6 found"` finds one site, `ok-planner/skills/plan-docs/core.md:153`. `/plan-docs` step 4 says "each reshape a planner returned", which names no step and stands. Count: 1 site.

**Changes**
- `ok-planner/skills/plan-docs/core.md::{{DOC-PLANNER-PROMPT}}`, Output: changed. Its last line names step 7, as above.

**Behavior changes**
- **B215** `ok-planner/skills/plan-docs/core.md::{{DOC-PLANNER-PROMPT}}`. Before: the planner reports the gaps "step 6 found". Step 6 drafts a worked example and finds no gaps, so a planner reports `none`, or reports the wrong list, and the owner never hears of a docspec that needs a reshape. After: the planner reports step 7's gaps, and `/plan-docs` step 4 names each one to the owner as work for `/plan-sprint`.
  Users: in the release: `/plan-docs` step 4.
  Ruling: rewrite.

### surface-corpus lists subject, practice, and docspec citations

**Calls**
- The kind-to-folder map comes from `scripts/discover::LIVE_DIRS`, which already maps all six kinds to their live folders; `surface-corpus` drops its own `FOLDERS`. It loads `.ok-planner/bin/discover` the way `load_issues` loads the intake module, and takes the intake module from it (`discover.review.issues`), so the intake loads once. Decided by: rule 6 of the coding rules (import, never copy); `review::delta_target` is a second copy the sprint does not change, so it stays.
- The output's kind column reads `subject`, `practice`, or `docspec` for those files. Decided by: the column already names the kind.
- The rare-token threshold counts every folder read, so a corpus with standards has more documents. Decided by: the work item ("the token search reads those folders too").
- The module docstring, which names concepts, stories, and decisions, stays as it stands. Decided by: the cheatsheet's comment rule (a build leaves a doc comment as it stands).

**Changes**
- `plugins/ok/families/ok-planner/scripts/surface-corpus::gather`: changed. It walks each kind's folder from `LIVE_DIRS` (concept, story, decision, subject, practice, docspec), skipping a missing folder, and returns path to kind.
- `plugins/ok/families/ok-planner/scripts/surface-corpus::main`: changed. A cited `subject:`, `practice:`, or `docspec:` artifact resolves to its live file and prints at the top score. A missing or empty `.ok-planner/design/` stops nothing: the lookup runs over whatever folders hold files, and prints nothing only where none does.
- `plugins/ok/families/ok-planner/scripts/surface-corpus::load_issues`: changed into a loader of `discover` by path; `FOLDERS`: removed.

**Improvements**
- **I402** `plugins/ok/families/ok-planner/scripts/surface-corpus` (`__main__`): accept-list entry A8, rule 4.4 of `.claude/rules/plumbline-coding.md`: a process main is an owner frame and catches the top-level type, emitting one event. Today an error other than the intake's refusal, such as a failure the intake module raises while it reads the store, ends in a bare traceback. Afterward: the `__main__` block runs `main()` inside `try`, re-raises `SystemExit`, and on any other exception emits `SURFACE.CORPUS.FAILED` with `type` and `message` through `tasks::event` (reached as `discover.review.issues.tasks.event`), which attaches the trace, and exits 1, in the shape of `scripts/discover`'s `__main__`. A failure to load `discover` itself raises before the helper exists and ends as now.

**Behavior changes**
- **B430** `plugins/ok/families/ok-planner/scripts/surface-corpus::main` / `gather`. Before: an issue citing a `subject:`, `practice:`, or `docspec:` slug prints nothing for it, the token search reads only design artifacts, and an empty design folder prints nothing. After: those files print, the token search covers them, and the lookup runs with no design folder. Users: in the release: `prompts/triage.md` step 5 and `prompts/respond.md` Read step 3, whose agents read what it lists. Across Trued-up projects: the vendored `.ok-planner/scripts/surface-corpus` and `bin/discover` update in one true-up. Ruling: rewrite.
- **B431** (I402) `plugins/ok/families/ok-planner/scripts/surface-corpus` (`__main__`). Before: an uncaught error prints a Python traceback and exits 1. After: it prints one `SURFACE.CORPUS.FAILED` event with the trace on stderr and exits 1. Users: in the release: the triage and respond agents, which read its stderr and its exit status. Ruling: rewrite.

### /plan-sprint's sign-off reviewer is told which findings are settled

**Calls**
- No drafting call bears on this work item. The round-1 sign-off calls in `drafting-calls.md` are an instance of the settled list this item passes, not a call about it. Decided by: `drafting-calls.md`, every batch read.
- The new input is `[SETTLED]`, written in the compliance reviewer prompt's `### Scope`, below `[REVIEW SCOPE]`, as one line: `Settled by the owner or the session, and not raised again: [SETTLED].` Decided by: the work item's sibling, `{{IMPLEMENTATION-NOTES-REVIEWER-PROMPT}}`'s `Settled by the owner, and not raised again: [SETTLED].` The rule is said once, so Anti-padding gains no second copy.
- `[SETTLED]` lists each finding an earlier round raised that the owner answered or the session settled as a call. Each entry gives the delta heading or file, the finding's one-line summary, and the answer or the call with what decides it. The first dispatch passes `none`. A mechanical fix is not listed, because the draft already holds it. Decided by: the work item ("the findings the owner or the session already settled"), and the sibling's `or none` form.
- The prompt adds that a violation in text written after the finding was settled is a new finding. The settled list then cannot hide a defect an owner's answer introduced. Decided by: step 7's rule that "a grounding finding stands even when the artifact is otherwise well-formed".
- Step 7 states the fill once, for every dispatch of the compliance review in the session. Steps 10 and 12 send an amended delta "back through the compliance review", and they reach the same rule with no edit of their own. Decided by: say it once (the writing standard), and decision:single-source-transclusion's rule against restating.

**Changes**
- `plugins/ok/families/ok-planner/skills/_shared/design-doc-compliance-reviewer.md` `{{DESIGN-DOC-COMPLIANCE-REVIEWER-PROMPT}}`, `### Scope`: changed. It gains the `[SETTLED]` line, and the sentence that a violation in text written after its settling is a new finding.
- `plugins/ok/families/ok-planner/skills/_shared/design-doc-compliance-reviewer.md`, "How consumers use this file" and "The prompt": changed. A new "How to substitute `[SETTLED]`" section gives the entry form from Calls and `none` for the first dispatch. "Replace `[REVIEW SCOPE]`; everything else is invariant." names both placeholders.
- `plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md` step 7 (Sign-off): changed. The first dispatch fills `[SETTLED]` with `none`. Every later dispatch of the compliance review, a re-dispatch here and the reruns steps 10 and 12 send, fills it with every finding settled so far, in the form the reviewer file gives. "Re-dispatch until clean" now ends at a round that raises no unsettled finding.

**Improvements**
- **I503** `plugins/ok/families/ok-planner/skills/_shared/design-doc-compliance-reviewer.md` `{{DESIGN-DOC-COMPLIANCE-REVIEWER-PROMPT}}`, `### Your job`: the sentence "The caller fixes mechanical findings and files judgment findings to the intake" restates what step 7 does with findings, and it disagrees with step 7. Step 7 walks a judgment finding with the owner, or settles it as a call. It files nothing to the intake. Two copies disagree, which is A8 under rule 6.3. Afterward the sentence is deleted. Step 7 alone says what the caller does, and the prompt keeps the classes under "How to scan". No behavior changes: the reviewer's output form is unchanged.

**Behavior changes**
- **B506** `plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md` step 7, with the compliance reviewer prompt. Before: each re-dispatch reviews the scope cold and may raise a finding the owner already answered or the session settled. Sign-off then loops, or ends by overriding the owner's answer. After: the reviewer raises no settled finding, and sign-off ends at the first round with no unsettled finding. Users: in the release, the `/plan-sprint` session, and the vendored copies of both files, which true-up overwrites together. Across the public surface: users who run `/plan-sprint`. The change removes only the harm story:plan-a-sprint names ("without ... deciding my open questions for me"), an A8 harm, so it keeps the slash command's contract. Ruling: preserve: the contract holds, and a user may not rely on the harm (call).

### A sprint's close commits the archived discovery and sketches

**Calls**
- No drafting call bears on this work item. Decided by: `drafting-calls.md`, every batch read.
- The archive-and-commit step finds what the planning session archived from `git status --porcelain -- .ok-planner/sketches .ok-planner/history/sketches .ok-planner/discoveries .ok-planner/history/discoveries`. It stages each listed path at its old path and its new one. Decided by: `plan-sprint/SKILL.md` step 13 moves sketches with a plain move and discoveries with `git mv` or `mv`, and it leaves both uncommitted. The executor at close may be another session, so it needs a way to read the set from the tree.
- "naming only paths that exist or that `git mv` removed" becomes "naming only paths that exist, or that a move removed and git still tracks". Decided by: a sketch moved by plain `mv` leaves a tracked deletion that `git commit -- <path>` must name. A discovery file `/discover-design` never committed leaves no tracked path, and naming it fails the commit with an unmatched pathspec.
- Each boilerplate line this change removes that a released template held (`v*` tags) joins `plugins/ok/families/ok-planner/admin/retired-boilerplate.json`, sorted. A line the new text holds again leaves the history. Decided by: `checks/sprint-boilerplate`, which requires exactly the released lines the carried template no longer holds, sorted, and decision:live-sprints-brought-current-on-true-up. In `v28.0.0` the lines are template lines 96 ("`.ok-planner/history/issues.jsonl`), and the sketches it archived. Where `git") and 262 to 268 (archive step 3), wherever the new wording leaves one out. Two other work items of this sprint (the drain and the build-prompt items) also edit `sprint-document.md` and `retired-boilerplate.json`, so their stages chain with this one.
- The drafted sprint's own "How to execute this sprint" and "Completion contract" sections do not match the template at the commit. Its step 2 lacks the `review approved` check, and it also lacks the checklist's certification-entry lines, the archive step 4's `approved:` wording, and the contract's drive sentence. The planning session should recopy both sections from the template, with this item's change, before the approval. The executor follows the sprint's own copy. Decided by: the template's rule "copy them verbatim into every sprint".

**Changes**
- `plugins/ok/families/ok-planner/skills/plan-sprint/sprint-document.md` `{{SPRINT-DOCUMENT-TEMPLATE}}`, "How to execute this sprint" step 2: changed. The list of files the planning session leaves uncommitted ends "and the sketches and the discovery it archived".
- `plugins/ok/families/ok-planner/skills/plan-sprint/sprint-document.md`, "The archive and the commit" step 3: changed. It stages, by name, each sketch and each discovery file the planning session archived, which the `git status` from Calls lists, at its old path and its new one. It sits beside the other paths, and the commit-path rule from Calls applies.
- `plugins/ok/families/ok-planner/admin/retired-boilerplate.json`: changed. It holds each replaced released line, sorted.

**Behavior changes**
- **B507** `sprint-document.md` step 2. Before: the base step's list of the planning session's own files names the sketches but not the archived discovery. The stop rule is unchanged, since both sit under `.ok-planner/`. After: the list names both, so the executor knows the discovery's moved files belong to planning and not to the sprint. Users: in the release, every executor of a new sprint. Across Trued-up projects: live sprints whose boilerplate an earlier release wrote. Ruling: migrate: true-up's live-sprint rewrite (`true-up::current_boilerplate`) replaces the retired lines in each live sprint; an archived sprint is a record and stays as written (call, decision:live-sprints-brought-current-on-true-up).
- **B508** `sprint-document.md`, archive step 3. Before: the archive commit leaves the moved sketches and discovery uncommitted. A clone still holds the discovery under `.ok-planner/discoveries/`, so `discover status` lists it as standing and `/discover-design` refuses a second run there. A clone also still holds the sketch under `.ok-planner/sketches/`. After: the commit carries both moves, so a clone shows the discovery and the sketches archived. Users: in the release, the owner's archive act, and `discover status` and `/discover-design` in a clone. Across Trued-up projects: live sprints, as in B507. Ruling: migrate: true-up's live-sprint rewrite replaces the retired lines in each live sprint (call, decision:live-sprints-brought-current-on-true-up).

### review stories reads a missing stories folder as no story

**Calls**
- No drafting call bears on this work item. Decided by: `drafting-calls.md`, every batch read.
- `story_slugs` returns `[]` where `.ok-planner/design/stories/` is not a directory, through `os.path.isdir`. Listing an existing directory keeps its `except OSError` refusal. Decided by: the work item ("as `review certified` already reads it"). `certification_failures` and `tests::story_slugs` both use the `isdir` reading. `review::main` catches `ReviewError` by name, so the existing conversion stands under rule 4.5.
- Drive mode's step 1 states the empty case in the shape of the step 2 branch that cannot start: "say so in the return ... and go to Loop 2 with what the list holds". Sprint mode's step 4 already states it, and it stays as written. Decided by: rule 2, the sibling's shape. Loop 2 still takes up the intake's defect issues the backlog step added.
- In drive mode, the return's `hunt` line says the project has no story where the drive was skipped. Decided by: drive mode's "say so in the return", and the return's `hunt` field, which lists the stories tried.

**Changes**
- `plugins/ok/families/ok-planner/scripts/review::story_slugs`: changed. A missing folder lists no story. A listing that fails on an existing folder still raises `ReviewError` naming the folder.
- `plugins/ok/families/ok-planner/skills/converge/SKILL.md` "In drive mode" step 1: changed. Where `review stories` prints no slug, the project has no story: skip steps 2 to 5, say so in the return, and go to Loop 2 with what the list holds.
- `plugins/ok/families/ok-planner/skills/converge/SKILL.md` "The return", the `hunt` bullet: changed. In drive mode it names a skipped drive as "the project has no story".

**Improvements**
- **I504** `plugins/ok/families/ok-planner/scripts/tests::story_slugs`: it is a second copy of `review::story_slugs`, with its own `STORIES` path. After this item both read a missing folder alike, so this is a rule 6 cost. Afterward `tests` deletes `story_slugs` and calls `review.story_slugs`, through the `review` module the closed-stamp item loads, so this lands after that stage. It keeps `STORIES`, which `window_entry` still reads for `stories_changed`. See B511.
- **I505** `plugins/ok/families/ok-planner/scripts/review::certification_failures`: its `os.path.isdir(os.path.join(root, STORIES_DIR)) and` guard restates the missing-folder reading that `story_slugs` now owns. That is two readings of one fact. Afterward it reads `if story_slugs(root):`. No behavior changes.

**Behavior changes**
- **B509** `plugins/ok/families/ok-planner/scripts/review::story_slugs`, through `cmd_stories` and `cmd_drives`. Before: in a project with no `.ok-planner/design/stories/` folder, which a fresh true-up leaves where `design/` is absent (`true-up::subdirs`), `review stories` and `review drives` exit 1 with `review: cannot list .ok-planner/design/stories: ...`. After: `review stories` prints nothing and exits 0, and `review drives` files no driver and prints `{"drive_tasks": []}`. `review drives --confirm` is unchanged. Users: in the release, `/converge`'s drive mode steps 1 and 3, and sprint mode's step 4. Across Trued-up projects: none, because the vendored script and the skill update together. Ruling: rewrite.
- **B510** `plugins/ok/families/ok-planner/skills/converge/SKILL.md`, drive mode. Before: a `/converge` drive run in a project with no story fails at `review stories`, and the run has no drive branch for that case. After: the run skips the drive, says so in the return, and goes on to Loop 2 with the intake's defects. Users: in the release, the `/converge` session. Across the public surface: users who run `/converge`. The change removes only the A3 harm (a refusal that tells the user nothing they did wrong), so it keeps the contract. Ruling: preserve: the contract holds, and no user may rely on the harm (call).
- **B511** `plugins/ok/families/ok-planner/scripts/tests::story_slugs` (I504). Before: where the stories folder exists but cannot be listed, `tests` prints `tests: internal error: [Errno ...] ...`. After: it prints `tests: internal error: cannot list .ok-planner/design/stories: [Errno ...]`. A missing folder still lists no story. Users: in the release, `tests window`, `tests plan`, and every `tests` verb that lists stories. Ruling: rewrite.

### A drive whose stack fails to start gets its stack running, and takes down only what it started

**Calls**
- The class this defect belongs to is a teardown, run after a failed start, that finds its target by a name another run may hold. Its members, found by `rg -n -i 'failed start|start fails|fails to start|stack-stop|start passed|did not start'` over `plugins/`, `docs/`, and `checks/`:
  - `skills/converge/SKILL.md` drive step 2 ("file and drain step 4's `stack-stop` task, which takes down what the failed start left").
  - `skills/converge/SKILL.md` confirm step 6 ("file and drain the `stack-stop` task as drive mode's step 4 does").
  - `skills/converge/SKILL.md` drive step 4, which files the stop "where `review drive-stack` printed `stack`", with no test that the start passed.
  - `docs/stack-helpers.md`, "Drive commands for the reference stack tool": "The drive runs the stop line whether the start passed or failed; after a failed start no run holds the name, and `down --name` exits 0".
  - `docs/stack-helpers.md`, "A project's own commands": the example start script leaves its run standing when its start fails, so its stop script relies on the drive running it after the failure.
  - `admin/ADMINISTRATION.md`, "Stack declaration": the sentence on the stop line, which says nothing about when the drive runs it.

  All six change here. The other hits stand: `scripts/stack` (`up` already takes its own run down on a failed start), `admin/true-up` (`DRIVE_STACK_LINES`), `scripts/review` (`STACK_ROLES`, `DRIVE_ROLES`, `undriven_reason`), and `review/seed/project.md`. Decided by: rule 8.1 of `.claude/rules/plumbline-coding.md`.
- The fix is one rule, settled by the owner (B316 of the earlier notes): the drive never runs its stop line after a failed start. A `stack-start` line that fails takes down what it opened before it exits. The reference stack tool already does so: `stack::start_run` calls `take_down` on a nonzero exit and on every exception, and a `stack up` refused because a live run holds the name opened nothing, since `stack::free_name` and `stack::open_entry` raise before any entry is made. `DRIVE_STACK_START`, `DRIVE_STACK_STOP`, and the two lines true-up writes stay byte for byte, so no review facts file needs a rewrite. Decided by: the owner's ruling on B316, `stack::up`, `stack::free_name`, `stack::open_entry`, and `stack::start_run` as they stand.
- After a failed start, `stack cleanup` (the tail of the stop line) is skipped. A stale run waits for the next passing drive's stop, or for the owner. Decided by: decision:run-artifacts-removed-with-the-run, under which a crashed run's artifacts already wait for a later cleanup.
- Who works out why a start failed: a new agent task, role `drive-start`, on `ok-opus`, under a new prompt `skills/converge/prompts/drive-start.md`. The session judges nothing and reads no file for judgment (the paragraph above `## Scope` in `skills/converge/SKILL.md`), and a project's own start line prints free text, so only an agent can read the cause. Decided by: that paragraph ("Every agent is a task in the task tracker"), and decision:subagent-model-follows-job (diagnosis is an analytical job, so `opus`).
- The `drive-start` agent closes with one word that opens its result, and the session acts on the word alone:
  - `held`: another live run holds the stack's name or a resource the start needs. The agent waited until that run ended, and the session starts again.
  - `own`: what holds the name is a stack this run started earlier whose `stack-stop` task failed (the ledger holds that failed `exec` task). The session files and drains the `stack-stop` task again, then starts again. A drive may take down a stack it started.
  - `retry`: a second start can pass, such as a dependency down for a moment, a timeout, or a port race the tool did not absorb. The agent waits 60 seconds before it closes, and the session starts again.
  - `blocked`: no start can pass in the tree as it stands, such as a missing tool, a malformed declaration, a build error, a daemon that does not run, a stale holder nothing uses, or a holder still live at the end of the wait.

  Decided by: the work item (wait where another live run holds the name or the resources, retry for any other cause, end only where no retry can succeed) and its "takes down only what it started". `own` names the one case where the holder is the run's own stack.
- One budget covers every failure branch: at most **3** starts per start sequence (the first and two more), whatever each `drive-start` verdict was. The brief says `start <n> of 3`. Where it says `start 3 of 3`, the agent waits for nothing and closes `blocked` whatever it found, because no start follows. A `drive-start` task that closes with any outcome but `done` is refiled once. After a second such close, the sequence ends and the session records the failure itself (Changes, step 2). The number 3 matches `stack::START_ATTEMPTS`, the reference tool's own start budget. Decided by: rule 4.7 (a retry budget covers every failure branch of the loop), and accept-list entry A5 (a wait that never returns).
- The `held` wait checks once a minute whether the holder still holds the name or resource. It runs in Bash calls of at most 9 minutes each, under the Bash tool's 10-minute limit, and lasts at most **3 hours**. Past that, the verdict is `blocked`, naming the holder, how long it held, and the command the owner would run once that holder's run is done. Decided by: A5 (the wait must return), and the length of a full drive, which holds the name from its start to its stop.
- A holder that nothing still uses, such as a project's own start script's pointer left by a run that crashed, is `blocked`, not `held`. Waiting cannot free it, and the drive takes down only what it started. The reference tool frees such a holder itself, because `stack::free_name` takes down a named run nothing uses. Decided by: the work item ("where another live run holds").
- On `blocked`, and on any verdict where the brief says `start 3 of 3`, the agent records the cause as a failure at state `environment`: `tasks item add --pool failures --key gate --state environment --fingerprint "stack-start-<start task>" --field surface=stack --field result=blocked --field start=<start task> --body "<the start command>; exit <code>; saw: <quoted lines>; cause: <the cause>; what the owner would change so a later drive gets through: <…>" --task <task>`. The owner list files it as it files every `environment` failure today, as a judgment issue or, for an outside tool, an upstream issue (`skills/converge/prompts/owner-list.md`, "every other drive failure at `environment`"). The owner list and the merge need no change: the merge reads only `open` failures (`review::file_source_merges`). Decided by: the work item ("files it to the intake, as an `environment` failure is filed now").
- The `drive-start` prompt names the reference stack tool's `list` verb as the registry reader where the start line calls `.ok-planner/bin/stack`. It names no helper (`run-tag`, `ports`, `docker-sweep`, `run-group`), and it reads no `stack` key of `.ok-planner/config.json`. For a project's own lines, it reads what the start's output and the project's facts name. Decided by: decision:stack-helpers-serve-project-commands ("No prompt of the drive names a helper or reads the stack the configuration declares"). That decision counts the reference stack tool apart from the helpers, and the work item names "the stack registry" as evidence.
- The `drive-start` agent changes nothing. It runs no stop line, no `stack down`, `stack cleanup`, or `stack up`, and no `docker` verb that stops or removes anything. It kills no process and edits no file. It runs only commands that change nothing, plus `sleep`. Decided by: the work item ("takes down only what it started"), and accept-list entry A2 (cleanup that reaches something it did not create).
- "Falls back to one driver at a time where many drivers at once break the stack" is a new drive step 5. A driver whose shared stack stopped answering, or broke, while it drove, where nothing it did shows why, records each such failure at a new failures state `redrive` with `--field cause=stack`. The merge never sees a `redrive` failure. Where any failure stands at `redrive`, the run does three things. It stops what the drive started, as step 4 does. It starts the stack again, as step 2 does, with a fresh budget of 3. It refiles each driver task those failures name, chained one after the other, with `; one at a time` added to its brief. Under that mark, a driver records a broken stack as any `blocked` outcome, at `open`, so the fallback runs once per drive and its outcome reaches the merge. Decided by: the work item, and rule 2 of the coding rules. The sibling shapes are step 3's `tasks refile` of a driver that closed `partial`, and the `- One at a time` chain of decision:instance-drives-serial-on-a-project-mark.
- The fallback refiles the driver rather than filing a fresh brief through `review drives`. A refile keeps the story's one driver, as step 3's refile after `partial` already does. decision:drive-tries-each-story-as-a-user ("gives every story its own driver once per run") reads the refile after `partial` as that same driver, so it reads the refile after a broken stack the same way. The refile keeps the brief's drive name and instance folder, which step 4's stops have just freed. Decided by: decision:drive-tries-each-story-as-a-user, and `tasks::cmd_refile` (it copies kind, prompt, role, and brief, and chains through `--after`).
- The session marks no item to tell a re-driven failure from a live one. The state `redrive` is written once, by the driver that records it. This avoids a multi-item write across `tasks` calls with no transaction. Decided by: rule 3.1 (one state change, one transaction).
- The fallback runs only in drive mode's Loop 1 and in sprint mode's drive (steps 2 to 5). A confirm driver records nothing in the `failures` pool. I601 carries the confirm case: a confirm driver blocked by the stack leaves its defect unconfirmed for the next confirm round. Decided by: `skills/converge/prompts/drive.md` ("Record nothing in the `failures` pool"), and Loop 2's end check, which runs a final confirm.
- The new step is numbered 5, after the stop, and the merge becomes step 6. That way, the only references to renumber are sprint mode step 4's "drive mode's steps 2 to 4", which becomes "2 to 5". `rg "drive mode's step|steps 2 to 4|step 4's"` finds these references only in `skills/converge/SKILL.md`. Decided by: rule 1 of the coding rules.
- The stack-helpers example start script takes its own run down on every failed exit after it writes the pointer. An `EXIT` trap runs `scripts/stack-stop "$name"` unless the start reached `started=yes`. The script writes `no` to `$folder/docker-reached` right after making the folder, so the stop script never reads a missing file. Today a `set -e` exit at `ports lease` leaves the pointer, and the example stop's `cat "$folder/docker-reached"` fails on the missing file. A refusal of a held name still exits before the script writes anything. Decided by: the one rule above, and rule 4.2 (cleanup runs on every exit).
- The seed `review/seed/project.md` stays as it is. Its text points at the stack helpers' document for the commands, and a seed edit would need its old digest added to `RETIRED_PROJECT_MD_SEED_DIGESTS`. Decided by: true-up's `seed_text` (carried from the earlier notes).
- `review::undriven_reason` stays as it is. It names the last failed `exec` task whose command is the start line, and a refile carries the same command, so it names the last of the 3 starts. Decided by: `review::certification_failures` and `tasks::COPIED_ON_REFILE`.
- From the drafting calls (g4), on the confirm sibling that shares I601's site: "The confirm send-back note names each story that failed: the recommendation's rationale says the driver's note carries that record." I601 adds a bullet beside that send-back and leaves its note to the sibling. Decided by: the drafting call, and the sibling work item. No other drafting call bears on this item.

**Changes**
- `plugins/ok/families/ok-planner/skills/converge/SKILL.md` (Setting up the run, step 4): changed. The prompt list reads "`drive` and `drive-start` in `drive` and `sprint` mode".
- `plugins/ok/families/ok-planner/skills/converge/SKILL.md` (Setting up the run, step 5): changed. The `failures` vocabulary gains `redrive`: `["open", "defect", "not-owed", "environment", "redrive", "backlog", "judgment", "upstream", "rejected"]`. The `calls` selector stays, so a `redrive` failure is no call.
- `plugins/ok/families/ok-planner/skills/converge/SKILL.md` (In drive mode, step 2, the `stack` branch): changed. The branch says the following:
  - File the start `exec` task in the form it gives today, and drain it. Where it passes, go to step 3.
  - Where it fails, file one `drive-start` task, `tasks file --role drive-start --prompt drive-start --agent ok-opus --key gate --brief "start task <the failed exec task>; start <n> of 3"`, and drain it. Act on the first word of its result. On `held` or `retry`, `tasks refile <the failed start task>` and drain. On `own`, file and drain the `stack-stop` task in this step's form, then refile the start and drain. On `blocked`, the drive ends. At most 3 starts in all.
  - A `drive-start` task that closes with any outcome but `done` is refiled once. After a second such close, the drive ends, and the session records the start's output tail as the failure, in the form the `drive-start` prompt gives.
  - Where the drive ends, say so in the return with the cause the last `drive-start` result names, and name every story `review stories` listed as not driven. File no `stack-stop` task. A start that fails takes down what it opened, and a start refused because a run holds its name opened nothing, so a stop line run then would take another run's stack down. Go to Loop 2 with what the list holds.

  The sentence "file and drain step 4's `stack-stop` task, which takes down what the failed start left" goes. The `none` branch keeps "skip this step and step 4's stack stop", and adds step 5's start and stop to what it skips.
- `plugins/ok/families/ok-planner/skills/converge/SKILL.md` (In drive mode, step 4): changed. The stack stop is filed "where `review drive-stack` printed `stack` and this step's start passed". Every other sentence stays.
- `plugins/ok/families/ok-planner/skills/converge/SKILL.md` (In drive mode, new step 5, **One driver at a time.**): new.
  - Run `tasks item list --pool failures --key gate --state redrive --json`. Where it lists no item, go to step 6.
  - Otherwise the shared stack broke while drivers ran together. Where the drive has a stack, start it again as step 2 does, with a fresh budget of 3. Step 4 has already stopped the stack.
  - Refile each driver task the items name, once each, in the order the items list them: `tasks refile <task> --brief "<its brief>; one at a time" --after <the refile filed before it>`, the first with no `--after`. Drain under a cap of **8**. A refiled driver that closes `partial` is refiled once more, as step 3 says.
  - Then stop what this step started, as step 4 does, over the same `instance` folders and `name`s.
  - Where the start ends the drive, name each story whose driver is not refiled as not driven again, file no stop, and go to step 6.
- `plugins/ok/families/ok-planner/skills/converge/SKILL.md` (In drive mode, the merge): renumbered from step 5 to step 6. Its text stays.
- `plugins/ok/families/ok-planner/skills/converge/SKILL.md` (In sprint mode, step 4): changed. "run drive mode's steps 2 to 4" becomes "steps 2 to 5". "or the stack fails to start" becomes "or the drive ends without driving after its starts, as drive mode's step 2 says". The return names every story the drive did not drive. The rest stays.
- `plugins/ok/families/ok-planner/skills/converge/SKILL.md` (Loop 2, step 6): changed in its failed-start sentence only. The stack starts as drive mode's step 2 starts it, with its `drive-start` tasks and its 3 starts. Where the drive ends without driving, say so in the return with the cause, name the defects left unconfirmed, file no confirm driver and no `stack-stop` task, and go to step 7. The sentence "file and drain the `stack-stop` task as drive mode's step 4 does" goes. The closing stop keeps "where this step started the stack".
- `plugins/ok/families/ok-planner/skills/converge/SKILL.md` (The return, `hunt`): changed. In `drive` and `sprint` mode it also lists three things. First, each start that failed, with the first word and cause of its `drive-start` result. Second, where the drive ended without driving, the cause and every story it did not drive. Third, each story driven again one driver at a time after the shared stack broke, with its outcome, and each story the fallback did not drive again. The sorted failure states gain `redrive`.
- `plugins/ok/families/ok-planner/skills/converge/prompts/drive-start.md`: new. It opens with `{{LEAF-AGENT-RULE}}` and holds five parts:
  - The job: read why the drive's stack start failed, wait where that is the cause, and change nothing.
  - What to read:
    - `.ok-planner/bin/tasks dump --type task`, for the start task's `command` and `result` (its exit code and output tail), and for each earlier `exec` task of this run whose command is the `stack-stop` line `.ok-planner/bin/review drive-command --role stack-stop` prints.
    - `.ok-planner/bin/stack list`, where the start line calls `.ok-planner/bin/stack`.
    - For a project's own lines, what the output and the facts below name.
  - The four verdicts and their tests, as Calls gives them. On `held`: what holds the name or resource, and how to tell it ended; the check once a minute for at most 3 hours; and `blocked` past that. On `own`: the failed `stack-stop` task. On `retry`: the 60-second wait before the close. The rule for `start 3 of 3`.
  - The `environment` failure's `tasks item add` line, as Calls gives it.
  - The Rules: run only commands that change nothing, plus `sleep`, and none of the commands Calls forbids. The Close: `tasks close <task> --outcome done --result "<held|own|retry|blocked>: <the cause; the evidence, quoted>"`. It ends with `### This project` and the `[PROJECT]` slot, as `drive.md` does.
- `plugins/ok/families/ok-planner/skills/converge/prompts/drive.md` (`### Judge the outcome`, after the recording paragraph): changed. Where the shared stack stopped answering, or broke, while you drove, and nothing you did shows why, record each such failure with `--state redrive --field cause=stack`, unless your brief says `one at a time`. The run then drives your story again, one driver at a time, on a fresh stack. Under `one at a time`, record it as any `blocked` outcome. The `### Setup` line "The stack is already up; do not start or stop it" stays.
- `plugins/ok/families/ok-planner/admin/ADMINISTRATION.md` ("Stack declaration"): changed. After "every stop runs the cleanup and exits with the status of `down`" comes this: the drive runs the stop line only after a start that passed. A failed `stack up` has already taken its own run down, and a `stack up` refused because a live run holds the name `drive` opened nothing, so a stop line run then would take that other run down.
- `plugins/ok/families/ok-planner/docs/stack-helpers.md` ("Drive commands for the reference stack tool"): changed. The false sentence ("The drive runs the stop line whether the start passed or failed; after a failed start no run holds the name, and `down --name` exits 0") becomes two claims. The drive runs the stop line only after a start that passed, for the reason ADMINISTRATION.md gives. Where a live run holds the name, the drive waits for that run to end and starts again.
- `plugins/ok/families/ok-planner/docs/stack-helpers.md` ("A project's own commands"): changed. The intro gains this: a start command that fails takes down what it opened before it exits, because the drive runs the stop command only after a start that passed. A start refused because a run holds the name writes nothing. The example start script gains three lines after the pointer refusal: `started=no`, `trap '[ "$started" = yes ] || scripts/stack-stop "$name"' EXIT`, and `echo no > "$folder/docker-reached"` after `mkdir -p "$folder"`. It ends with `[ "$code" -ne 0 ] || started=yes` before `exit "$code"`. The stop script stays.
- No code file changes. `scripts/stack`, `scripts/review`, `scripts/tasks`, and true-up's `DRIVE_STACK_*` constants stay as they are.

**Improvements**
- **I601** `plugins/ok/families/ok-planner/skills/converge/prompts/drive.md` (`### Confirm, where your brief says so`): accept-list entry A9. Today a confirm driver that the stack blocked takes the "Any other outcome" bullet. It sends the defect back with `kickbacks` raised, which reports that the fix failed when the stack did. Two such send-backs make the defect `stuck` and back a verified fix out of the tree. Afterward: a new bullet, before "Any other outcome", says that where the shared stack stopped answering or broke and nothing you did shows why, you leave the defect's state, `kickbacks`, and `confirmed` as they stand, and add `--note "confirm drive: blocked by the stack: <saw; evidence>"`. The defect stays verified and unconfirmed. The next round's step 6 lists it again, and Loop 2's end check runs the final confirm. The return lists each defect still unconfirmed, as `fixed` already says.

**Behavior changes**
- **B601** `plugins/ok/families/ok-planner/skills/converge/SKILL.md` (drive step 2, a failed start). Before: the drive ends, files and drains the `stack-stop` task, and goes to Loop 2. Under the reference tool's lines, the stop runs `stack down --name drive`, which takes down another live run that holds the name, and then `stack cleanup`. After: a failed start gets a `drive-start` task, and the drive waits, retries, or re-stops its own stack, within 3 starts. It never runs the stop after a failed start, and ends only on `blocked` or a spent budget. It then records an `environment` failure and names every story it did not drive. Users: in the release: sprint mode step 4 and Loop 2 step 6, which reuse step 2; `review::undriven_reason`, which still names the last failed start, since a refile keeps the command; the owner list, which files the `environment` failure as it files any; and the merge, which reads only `open` failures. Across Trued-up projects: every project whose review facts give stack lines. Under the lines true-up writes, the harm is gone, the cleanup is skipped on that occasion, and the drive may wait up to 3 hours for another run. Under a project's own lines whose start leaves state when it fails, as the earlier stack-helpers example did, the drive no longer takes that state down. That project's next start refuses on its own held name, and the `drive-start` agent judges the holder stale and records a blocked drive that names the stop command to run. Across the public surface: `/converge`, whose arguments do not change. A person who runs it waits longer on a held stack and reads more return lines. Ruling: migrate: a project whose own start leaves its run on a failure gets, once, a blocked drive whose `environment` failure names the leftover run and its stop command, and the stack-helpers example now takes its own run down; `/converge` takes the same arguments and ends in the same return block (call, decided by the owner's settlement of B316: the drive never stops after a failed start).
- **B602** `plugins/ok/families/ok-planner/skills/converge/SKILL.md` (drive step 4). Before: the stop is filed wherever `review drive-stack` printed `stack`. After: it is filed only where step 2's start passed. Users: in the release: step 2, which no longer reaches step 4 after a failed start, and Loop 2 step 6, which already stops only where it started. Across Trued-up projects: as B601. Ruling: migrate, as B601 (call).
- **B603** `plugins/ok/families/ok-planner/skills/converge/SKILL.md` (Loop 2 step 6, a failed confirm start). Before: the drive names the defects left unconfirmed, files and drains the `stack-stop` task, and goes to step 7. After: the start runs step 2's sequence. Where it ends without driving, the drive names the defects left unconfirmed and files no stop. Users: in the release: Loop 2's end check, and the return's `fixed` line, which lists each unconfirmed defect. Across Trued-up projects: as B601. Ruling: migrate, as B601 (call).
- **B604** `plugins/ok/families/ok-planner/skills/converge/SKILL.md` (sprint mode step 4). Before: a failed start means the drive did not run. After: the drive did not run only where it ended without driving after its starts, and the return names every story it did not drive. The step runs drive steps 2 to 5. Users: in the release: `review certified`, which reads the ledger for driver tasks (`review::driven_stories`) and is unchanged; the completion contract, which stays open where no story was driven. Ruling: rewrite.
- **B605** `plugins/ok/families/ok-planner/skills/converge/SKILL.md` (new drive step 5; the merge renumbered to step 6). Before: a driver blocked by a broken stack records an `open` failure, which the merge sorts `environment` and the owner list files. After: a driver blocked by a broken stack records a `redrive` failure. The run restarts the stack and refiles that driver one at a time, and only the refiled driver's outcome reaches the merge. Users: in the release: sprint mode step 4, which now names steps 2 to 5; the merge (`review::file_source_merges`, `open` failures only); the owner list, which reads no `redrive` failure; `tasks calls`, whose selector names no `redrive`; and `review::driven_stories`, which reads the `story <slug>` head the refiled brief keeps. Across Trued-up projects: the vendored skill and its prompts update in one true-up. A run ledger an earlier release opened holds no `redrive` item. Ruling: rewrite.
- **B606** `plugins/ok/families/ok-planner/skills/converge/prompts/drive.md` (`### Judge the outcome`). Before: a broken shared stack is a `blocked` failure at `open`. After: outside `one at a time` it is a failure at `redrive` with `cause=stack`. Users: in the release: drive step 5 and the merge, as B605. Ruling: rewrite.
- **B607** `plugins/ok/families/ok-planner/skills/converge/SKILL.md` (setup steps 4 and 5). Before: drive and sprint mode register `drive` alone, and the `failures` vocabulary has no `redrive`. After: they register `drive-start` too, and the vocabulary has `redrive`. Users: in the release: `tasks::check_state`, which refuses a state outside the vocabulary, and `tasks file --prompt drive-start`, which needs the registration. Ruling: rewrite.
- **B608** `plugins/ok/families/ok-planner/skills/converge/SKILL.md` (The return, `hunt`). Before: it names no failed start but a stop that failed. After: it names each failed start with its verdict, each story not driven, and each story driven again one at a time. Users: in the release: the sprint boilerplate, which pastes the return into the completion report; `review certified`, which reads the block's ledger path and stuck defect ids alone (`review::certification_failures`). Across the public surface: a person who reads `/converge`'s return; every earlier field stays. Ruling: rewrite.
- **B609** `plugins/ok/families/ok-planner/docs/stack-helpers.md` (Drive commands for the reference stack tool). Before: it claims the drive runs the stop after a failed start, harmlessly. After: it says the drive runs the stop only after a start that passed, and waits where a live run holds the name. Users: in the release: agents that build a project's stack tooling, which `ok-planner-cheatsheet.md` sends here. Across Trued-up projects: the vendored copy at `.ok-planner/docs/stack-helpers.md` updates at true-up. Ruling: rewrite.
- **B610** `plugins/ok/families/ok-planner/docs/stack-helpers.md` (the example start script). Before: on a failed `docker compose up`, or a `set -e` exit after the pointer, the script exits with the pointer, ports, process group, and containers of its run left for the stop script. After: an `EXIT` trap runs its stop script on every failed exit after the pointer, so the script exits with nothing of its run left. Users: in the release: none. Across Trued-up projects: projects that copy the example from now on. A copy made earlier is the project's own file and does not change, which B601 covers. Ruling: rewrite (a document's example, read by the projects that copy it).
- **B611** `plugins/ok/families/ok-planner/admin/ADMINISTRATION.md` (Stack declaration). Before: it says nothing about when the drive runs the stop line. After: it says the drive runs it only after a start that passed, and why. Users: in the release: the `/ok` session, which reads the administration document; no code parses the sentence. Ruling: rewrite.
- **B612** (I601) `plugins/ok/families/ok-planner/skills/converge/prompts/drive.md` (confirm, blocked by the stack). Before: the confirm driver sends the defect back and raises `kickbacks`. After: it leaves the defect verified and unconfirmed, with a note, so the next confirm round tries it again. Users: in the release: Loop 2 step 1, which no longer counts a stack failure toward `stuck`; step 6's dry run, which lists the defect again; the return's `fixed` line. Across Trued-up projects: the vendored prompt updates at true-up. Ruling: rewrite.

**New surface**
- The prompt `drive-start`, its task role, the failures state `redrive`, the field `cause`, and the brief mark `one at a time`, declared in `plugins/ok/families/ok-planner/skills/converge/SKILL.md` and `skills/converge/prompts/`: internal. The surface intent makes public only plugins, slash commands with the arguments their text says they take, and output styles, and `/converge` takes no new argument.

Kickbacks: none.

### The port registry bounds its docker calls

**Calls**
- `docker_out` takes a time limit per call. Queries (`version`, `ps`, `ls`, `container inspect`) get `QUERY_SECONDS = 15`, and removals (`rm`, `network rm`, `volume rm`, `image rm`) get `REMOVAL_SECONDS = 120`. Both are constants in `scripts/docker-sweep`, so `ports` and `stack` reach them through the module they already load. Decided by: the work item ("so it times out"), weighed against the cost each limit carries. A short limit on a large image's removal would read a slow success as a refusal, which keeps the run's entry. A long limit on queries would stall `stack up` through its two probes and the lease.
- A timeout propagates as `subprocess.TimeoutExpired`, and docker_out wraps it in nothing. Each site that already catches `(DockerFailed, OSError)` around a docker call adds `subprocess.TimeoutExpired` to the tuple: `docker-sweep::docker_reached`, `docker-sweep::sweep`, `ports::published`, and `stack::in_use`. Each handler already takes the branch the work item wants: an unreached daemon, a refused removal, an unchecked docker lease, a run counted in use. Decided by: rule 4.5 (no catch that only converts one type to another), and rule 4.3 (catch at the site that acts).
- `subprocess.run` with `timeout=` kills the docker CLI child before it raises, so no docker process outlives the call. Decided by: the standard library's documented behavior.
- `docker-sweep running <tag>` keeps no catch of its own. A timeout there reaches `__main__`'s catch-all, which emits `SWEEP.RUN.FAILED` and exits 1. Decided by: rule 4.4 (the owner frame).
- The help texts name the limits. `ports` says "Where docker's daemon does not answer within 15 seconds, lease skips the docker check." `docker-sweep`'s `USAGE` says a query with no answer in 15 seconds counts as a daemon that does not answer (exit 3 at the probe), and a removal with no answer in 120 seconds counts as a refusal (exit 1). Decided by: the work item ("as its help says").

**Changes**
- `plugins/ok/families/ok-planner/scripts/docker-sweep`: changed. `docker_out(docker, args, absent_ok=False, seconds=QUERY_SECONDS)` passes `timeout=seconds`. `sweep` passes `seconds=REMOVAL_SECONDS` on the removal call. `docker_reached` and `sweep` add `subprocess.TimeoutExpired` to their catches. `QUERY_SECONDS` and `REMOVAL_SECONDS` are new. `USAGE` is changed as above.
- `plugins/ok/families/ok-planner/scripts/ports`: changed. `published` adds `subprocess.TimeoutExpired` to its catch, and its `PORTS.DOCKER.UNCHECKED` event carries the error type as today. The help text is changed as above.
- `plugins/ok/families/ok-planner/scripts/stack::in_use`: changed. It adds `subprocess.TimeoutExpired` to its catch.
- `plugins/ok/families/ok-planner/docs/stack-helpers.md` (the docker-sweep section, and the `ports lease` bullet "Where docker does not answer"): changed. Each names the two limits.
- `.ok-planner/review/project.md` (the `ports` and `docker-sweep` lines): changed. Each names the limits.

**Behavior changes**
- **B315** `docker-sweep::docker_out` and its callers. Before: a daemon that accepts the connection and never answers stalls `docker-sweep probe`, `sweep`, and `running`, and with them `ports lease`, `stack up`, `stack down`, and `stack cleanup`, without end. After: each query gives up after 15 seconds and each removal after 120 seconds. In each case:
  - The probe reports the daemon unanswered: docker-sweep exits 3, and `stack` records the run unreached.
  - `ports lease` skips the docker check with `PORTS.DOCKER.UNCHECKED`.
  - A timed-out removal is a refusal: docker-sweep exits 1, and `stack down` keeps the entry with the refusal named.
  - `stack cleanup` counts a run in use when its containers cannot be listed.

  Users: in the release: `ports`, `stack`, true-up (which loads `ports` as a module for `declared_names` and never calls docker through it), and drivers. Across Trued-up projects: a project's own stack scripts that call `docker-sweep probe` or `sweep`, such as the stack-helpers example. They now get the documented exit 3 or exit 1 where they hung before. Ruling: rewrite. Across Trued-up projects: preserve (call), because a timeout falls under the exits each script already documents ("does not answer", "a refused removal").

### docs window names a listed class that matches no declaring line

**Calls**
- `declaring_paths` returns a mapping from each listed class, as the docspec names it, to the paths of its declaring line, with an empty list where no line matches. Its one caller gets the paths from the mapping's values and the unmatched classes from its empty entries. Where the surface intent file is missing, every listed class is unmatched. Decided by: the work item ("returns paths only" is the defect), and plumbline-coding rule 1 (one caller, edited in the same change).
- The entry's field is `unmatched_classes`, a list of class names, on every entry, empty where none. The field name follows `stale_claims`. Decided by: the window's existing JSON shape.
- An unmatched class is not a reason and leaves the status alone. A docspec with nothing else behind stays `current`, so no planner runs for a class that has no members to list. Decided by: the owner can act only through `/plan-sprint` (only `/plan-sprint` changes a docspec or the surface intent), and the planner's step 7 already names such a class as a reshape where the docspec is reached for another reason.
- The entry computes `unmatched_classes` before its `new` early return, so a docspec with no stamp names them too. Decided by: the work item ("each listed class that matches no declaring line").
- The text form prints `  - listed class matches no declaring line under "## Where each class is declared": <class>`, or `  - listed class: no surface intent at .ok-planner/surface/surface.md: <class>` where the file is missing. Decided by: the window's text form, one line per finding.
- `/plan-docs` step 2 names each unmatched class to the owner in one line, as work for `/plan-sprint`, whatever the entry's status. It does so before the step's stop where every docspec is `current`. Decided by: the work item ("and `/plan-docs` tells the owner"), and the shape of step 4's reshape line.

**Changes**
- `ok-planner/scripts/docs::declaring_paths`: changed, to the mapping above.
- `ok-planner/scripts/docs::window_entry`: changed. It sets `unmatched_classes` from the mapping before any early return, and gets the declaring-file reasons from the mapping's paths.
- `ok-planner/scripts/docs::cmd_window`: changed. It prints the unmatched-class lines.
- `ok-planner/scripts/docs::USAGE`: changed. `docs window` names each listed class that matches no declaring line.
- `ok-planner/skills/plan-docs/SKILL.md`, step 2 Window: changed. The entry description names `unmatched_classes`, and the step tells the owner as above.

**Behavior changes**
- **B216** `ok-planner/scripts/docs::window_entry` and `cmd_window`. Before: a reference docspec whose `## Lists` names a class with no matching line under `## Where each class is declared` stands `current` with no note, and its reference is never checked for that class. After: the entry names the class, the text form prints it, and `/plan-docs` tells the owner, even where it then stops.
  Users: in the release: `/plan-docs` step 2. Across trued-up projects: none; the output is not stored.
  Ruling: rewrite.

### /plan-tests sorts a fixture by whether a kept test uses it

**Calls**
- Build note: `SKILL.md` step 5.2 and step 7 here are step 6.2 and step 8 under the shared step layout; sweep the numbers with the rest.
- `print_plan` prints a support entry's `users` only where the entry holds them, so `tests plan --show` reads an archived `-plan.json` written before this change. Decided by: an archived plan is stored state, as B10 and B22 keep it.
- The assembly decides each fixture, not the sort agent. A sort agent records each fixture, helper, or data file as `sort=support` with `users`: each test that reads it, as `<path>` or `<path>::<name>`, found across the whole tree. The assembly sets the entry's `scenarios` to every kept scenario whose test is among its users or whose `support` names the entry's path. It turns an entry that no kept scenario uses into `delete` with reason `orphan` and the note "no kept test uses it". Decided by: the work item ("a fixture is kept exactly when a kept test uses it"), decision:legacy-suites-sorted-automatically ("So is a fixture or a data file no kept test uses"), and the sibling in `assembled_plan`, which already turns a second adoption into a duplicate deletion (rule 2).
- A kept scenario is one whose plan action is `keep`, `new`, `rewrite`, or `adopt`. Its test is the plan's test, else the test the stamp recorded. A user named by path alone matches any kept test in that file. A user named `<path>::<name>` matches that test only. Decided by: `scripts/tests::live_tests`, which defines which tests live on.
- A test sorted `port` or `delete` is not a kept user, so a fixture only those tests read is deleted. A port's check lives outside the test paths and reads no test fixture. Decided by: the sort prompt's port rule.
- `plan_failures` adds two refusals. A `delete` or `port` of a path that a kept scenario names in its `support`. A `support` entry with no `users`, where no kept scenario names its path. Decided by: the work item ("no fixture a kept test reads is deleted") and the cheatsheet's mechanical-checks rule.

**Changes**
- `skills/plan-tests/core.md::{{TEST-SORT-PROMPT}}`: changed. The support row reads: "It is a fixture, a helper, or a data file a test reads → `support`, naming each test that reads it (`rg` the tree for its name or path)". The Record line takes `--field 'users=["<path>[::<name>]", ...]'` in place of `scenarios` for a support entry. A note says the assembly keeps a fixture only where a kept test uses it.
- `skills/plan-tests/SKILL.md` step 5.2: changed. Sort agents record each fixture with the tests that read it, whatever batch those tests fall in. Step 7: changed. Its account of the assembly adds that it keeps each fixture a kept test uses as that test's support and deletes each one no kept test uses.
- `scripts/tests::assembled_plan`: changed. Reads `users` on legacy items. After the adoptions, it computes each support entry's `scenarios` from the kept scenarios and turns an unused one into an orphan deletion.
- `scripts/tests::plan_failures`: changed. The two refusals above, each naming the legacy item and its task (see the fix work item).
- `scripts/tests::print_plan`: changed. A support entry prints its users beside its scenarios.

**Behavior changes**
- **B108** `scripts/tests::assembled_plan` (`tests plan`). Before: a support entry stands as its sort agent wrote it, with the scenarios that agent named, though the tests that read it sit in other batches. After: the assembly derives each support entry's scenarios from the kept tests that use it, and deletes a fixture no kept test uses. Users: in the release, `SKILL.md` steps 5.2 and 7 and `{{TEST-SORT-PROMPT}}`, which this item rewrites. Downstream, `live_tests`, `stage_write`, and the legacy task briefs read `scenarios` as before. Across Trued-up projects: none; the boundary leaves out a planning run in progress and an open test sprint, whose plan was assembled already. Ruling: rewrite.
- **B109** `scripts/tests::plan_failures` (`tests plan`). Before: it refuses a support entry only where it names a scenario the plan lacks. After: it also refuses deleting or porting a fixture a kept scenario names, and a support entry with no users. Users: in the release, `SKILL.md` step 7. Ruling: rewrite.

### /plan-tests sorts single tests under a whole-file test command

**Calls**
- Build note: `SKILL.md` step 7 here is step 8 under the shared step layout.
- A sort agent records each test by its name under any runner, and records a file with no test (a fixture, a data file) by its path. The name is the test's name as its file declares it. Decided by: the work item ("orphan and duplicate legacy tests inside a kept file are deleted under any runner"). A legacy task can delete one test only where the plan names it.
- Under a runner whose `testing.run` holds no `{name}`, the assembly sets an adopted scenario's test to `{"path": <file>, "name": None}`, and the legacy entry keeps its name. So `locator` of the scenario's test is the file, which `command_for` runs and `seen_tests` keys, and `scripts/tests::locator` itself stays as it is. Decided by: `command_for` and the `seen_tests` check in `plan_failures` (one test per scenario).
- Under such a runner, a file is adopted into one scenario at most. The sort prompt tells the agent to adopt a file's tests into the one scenario most of them check, and to sort each test in it that checks another scenario as a duplicate, which that scenario's own new test replaces, with a call. The `seen_tests` refusal ("scenarios A and B share the test") stays, and names both items. Decided by: one runnable command per scenario under a whole-file runner, and the decision's duplicate rule.
- Claimed files a person edited are sorted under any runner, not only under a named one. Under a whole-file runner, the agent sorts each test in a claimed file that checks none of the outcomes its scenarios state. Decided by: rule 8, since a claimed file is a kept file the work item covers, and decision:legacy-suites-sorted-automatically.
- A legacy task's brief names each kept test from the legacy entries, by name. A recorded test at that path is named only where its locator names a test. Decided by: `{{TEST-LEGACY-PROMPT}}` ("Leave every test the brief keeps exactly as written"), which needs names to keep some tests of a file and delete others.

**Changes**
- `skills/plan-tests/core.md::{{TEST-SORT-PROMPT}}`, the Sort section and the claimed-file paragraph: changed. "Sort each test by its name, under any runner; a file that holds no test gets one entry by its path." The rule for adopting under a whole-file runner, as the calls say. A claimed file: sort each test in it that checks none of the outcomes its claiming scenarios state.
- `skills/plan-tests/SKILL.md` step 5.2: changed. It adds each claimed test file the window lists as edited, marked `claimed`, under any runner (the condition "Where `testing.run` holds `{name}`" goes).
- `scripts/tests::assembled_plan`: changed. Reads `testing_config` and, under a whole-file runner, gives an adopted scenario's test no name.
- `scripts/tests::plan_failures`: changed. The `edited_tests` check runs under any runner.
- `scripts/tests::stage_write` (legacy briefs): changed. A delete or port names its test, and "Keep as written" lists the kept tests by name, as the calls say.

**Behavior changes**
- **B110** `skills/plan-tests/core.md::{{TEST-SORT-PROMPT}}`, `SKILL.md` step 5.2, and `scripts/tests::plan_failures`. Before: under a whole-file runner, each legacy file is sorted whole, and claimed files a person edited are never sorted or checked. After: each test is sorted by name under any runner, and an edited claimed file must be sorted. Users: in the release, the session and the sort agents, which this item rewrites. Ruling: rewrite.
- **B111** `scripts/tests::assembled_plan` and `stage_write` (legacy briefs). Before: under a whole-file runner, a legacy entry names a file, and the brief deletes or keeps the whole file. After: entries name tests, an adopted scenario's test is still its file, and a legacy task deletes the named tests inside a kept file. Users: in the release, `{{TEST-LEGACY-PROMPT}}`, which already deletes a named test and keeps the rest. Across Trued-up projects: none; the boundary leaves out an open test sprint, whose plan was assembled already. Ruling: rewrite.

### A vetoed test deletion or port at a test sprint's close is undone or filed

**Calls**
- Build note: `{{CEREMONY-VETO}}` carries the call's reading: the test sprint's close never overturns a deletion or port and files every vetoed one. B218 names `{{CEREMONY-VETO}}`, the one name.
- Build note: I102 and I203 propose one new `_sprint/shared.md` block under two names, `{{CEREMONY-VETO}}` and `{{CEREMONY-VETOES}}`. Land one block under one name, `{{CEREMONY-VETO}}`; `checks/token-resolution` needs exactly one `###` heading for it.
- Every vetoed deletion or port is filed. The close never changes the tree. By step 8, step 7 has run `tests complete`, which writes `-complete.txt` (`scripts/tests::cmd_complete`) and closes the test paths, so restoring a test would add a test outside an open test sprint. The work item's "the close overturns it" branch therefore never runs in the boilerplate's order, and its own condition ("where `tests complete` has already closed the test paths") sends every veto to the filing branch. Decided by: the Tests rule of the cheatsheet ("Only a test sprint adds, edits, or deletes a test") and the boilerplate's step order.
- The issue for a vetoed deletion or port names:
  - the test's path and name;
  - the base commit (`-base.txt`), which still holds the test;
  - its sort and its reason, or its rule and its check;
  - that a later test sprint restores the test, or for a port also drops the check.

  It takes kind `human` and category `product-intent`, as the sibling close files a vetoed row. Decided by: decision:converge-close-takes-vetoes and the sibling in `skills/plan-sprint/sprint-document.md` step 13.
- The owner should know one consequence. A ruled issue reaches the next `/plan-sprint`, whose builders write no test, and `/plan-tests` reads no intake. So the record now shows the veto, but no planner restores the test until a person takes the issue to a test sprint. Building that path widens the work item into a new mechanism (rule 8.4), so this plan leaves it out. Decided by: rule 8.4. The session may raise it at sign-off.
- The close asks one question that covers every presented row: each call, each deletion, and each port. Decided by: the sibling close, which asks once over the calls table.

**Changes**
- `skills/plan-tests/test-sprint-document.md` step 8: changed. It presents the report and asks which calls, deletions, and ports the owner vetoes. It files one issue per vetoed row, as the calls say, and records the ruling under the next work item. It changes no test.

**Improvements**
- **I102** `skills/_sprint/shared.md`, a new `{{CEREMONY-VETO}}` block beside `{{CEREMONY-ARCHIVE}}`: the maintenance cost. The veto close is written three times: `sprint-document.md` step 13, `doc-sprint-document.md` step 9, and `test-sprint-document.md` step 8. The two ceremony copies lost the ruling step the sprint copy gained, which is the defect two work items of this sprint fix. Afterward the block holds the filing and the ruling once, with `<rows>` (what the close presents) and `<problem>` (what a vetoed row's issue states). Step 8 here, and step 9 of the documentation sprint (the other planner's veto item), each say "Follow `{{CEREMONY-VETO}}` in `.claude/skills/_sprint/shared.md`, with …", as both already do for `{{CEREMONY-ARCHIVE}}`. The sprint's step 13 stays as written, because changing it would retire boilerplate lines through `admin/retired-boilerplate.json` for no change in behavior. Behavior changes: none beyond B112.

**Behavior changes**
- **B112** `skills/plan-tests/test-sprint-document.md` step 8 (this item and the next). Before: a vetoed call becomes an issue with no ruling, and a vetoed deletion or port has no effect. After: each vetoed call, deletion, or port becomes an issue, with the owner's words recorded as its ruling. Users: in the release, the session that executes a test sprint. Across Trued-up projects: none; the boundary leaves out a test sprint planned earlier, which is brought current before it runs. Ruling: rewrite.

### A test sprint's close records the owner's veto as a ruling

**Calls**
- The ruling step copies the sibling close's words in `skills/plan-sprint/sprint-document.md` step 13: `.ok-planner/bin/issues rule <id> --text -`, the words on stdin. Where `issues rule` refuses for want of a name, the session relays the refusal's setting text and records the ruling once a name resolves. Decided by: the work item and rule 2.
- This item shares step 8 with the item above. Both land in one stage, and its behavior change is B112. Decided by: one definition, one edit.

**Changes**
- `skills/plan-tests/test-sprint-document.md` step 8: changed (one edit with the item above, or through `{{CEREMONY-VETO}}` under I102). After each issue it files, it records the owner's words as that issue's ruling and relays a refusal for want of a name.

**Behavior changes**
- None beyond B112, which this item shares.

### A documentation sprint's close records the owner's veto as a ruling

**Calls**
- Build note: land I203's block as the one `{{CEREMONY-VETO}}` block I102 also uses.
- Boilerplate step 9 takes the sibling's wording from `ok-planner/skills/plan-sprint/sprint-document.md` step 13. After the issue is filed: "Then record the owner's words as that issue's ruling with `.ok-planner/bin/issues rule <id> --text -`, the words on stdin, so the next `/plan-sprint` pulls the veto in as the owner's decision. `issues rule` signs the ruling with the name of the person running the session; where it refuses for want of a name, relay the refusal's setting text to the owner and record the ruling once a name resolves." Decided by: the work item and plumbline-coding rule 2.
- Rule 8 class: a ceremony's close files a vetoed call as an issue with no ruling. Members: `skills/plan-docs/doc-sprint-document.md` step 9 (this item), `skills/plan-tests/test-sprint-document.md` step 8 (the work item "A test sprint's close records the owner's veto as a ruling"), and `skills/plan-sprint/sprint-document.md` step 13, which already rules. `skills/converge/SKILL.md`'s close is decision:converge-close-takes-vetoes' sibling and is not touched here. Count: 2 sites to fix, both in this sprint.

**Changes**
- `ok-planner/skills/plan-docs/doc-sprint-document.md`, boilerplate step 9: changed, as above.

**Improvements**
- **I203** `ok-planner/skills/plan-docs/doc-sprint-document.md` step 9 and `ok-planner/skills/plan-tests/test-sprint-document.md` step 8: one mechanism written twice. Both closes take vetoes with the same file-then-rule text, and this sprint fixes the same defect in each copy through two work items. Afterward: `ok-planner/skills/_sprint/shared.md` gains a `{{CEREMONY-VETOES}}` block holding the file-and-rule text with the `issues rule` refusal relay. Each step reads "Take the owner's vetoes as `{{CEREMONY-VETOES}}` in `.claude/skills/_sprint/shared.md` says", in the shape both boilerplates already use for `{{CEREMONY-ARCHIVE}}` and `{{CEREMONY-RUN-RULES}}`. The test sprint's step keeps its own text for overturning a vetoed deletion or port, from the work item "A vetoed test deletion or port at a test sprint's close is undone or filed". `checks/token-resolution` reads `_sprint/*.md` as a definitions file, so the new token resolves. This improvement needs the test sprint item's stage to take the same block. Where that stage does not, this item lands the inline text above alone.

**Behavior changes**
- **B217** `ok-planner/skills/plan-docs/doc-sprint-document.md` step 9. Before: each vetoed call becomes an issue with no ruling, so the next `/plan-sprint` treats it as an open question instead of the owner's decision. After: the issue carries the owner's words as its ruling, signed with the session's person's name, or the session relays the name refusal and rules once a name resolves.
  Users: in the release: documentation sprints planned from now on, which copy the boilerplate, and `/plan-sprint`, which pulls in ruled issues. Across trued-up projects: none; the boundary leaves out an open documentation sprint, which is brought current before it runs.
  Ruling: rewrite. Decided by: decision:converge-close-takes-vetoes ("with the owner's words as its ruling").
- **B218** (I203) `ok-planner/skills/_sprint/shared.md::{{CEREMONY-VETOES}}`, new, as both boilerplates read it. Before: each boilerplate carries its own veto text. After: both read the block from the vendored `shared.md` when the close runs. The text the session follows matches B217.
  Users: in the release: documentation and test sprints planned from now on. Across trued-up projects: none; an open sprint names no such block.
  Ruling: rewrite.

### A person's first write starts their read ledger

**Calls**
- Each person's write verb seeds the person's ledger with `issues::seeded_ledger(root, name)` before its transaction, under that function's own lock. Decided by: rule 6 of the coding rules (the function exists), and rule 3: the ledger is a separate, machine-local file, and seeding first means any message landing after the person's act reads as new.
- A write that then refuses still leaves a ledger, which counts everything existing as read, as the person's first read would. Decided by: `{{ISSUE-FILE-FORMAT}}` ("A ledger starts with everything that exists counted as read").
- `set_flag` resolves a name only to seed: where no name resolves, it flags and unflags as now, with no new refusal. Decided by: `set_flag` signs nothing today, and the work item asks for a seed, not a refusal.
- The dashboard's routes change no code: they call `issues.rule`, `issues.comment`, `issues.edit_message`, `issues.remove_message`, `issues.withdraw_ruling`, and `issues.set_flag` (`scripts/dashboard` lines 327 to 346), which seed. Decided by: the routes' code.

**Changes**
- `plugins/ok/families/ok-planner/scripts/issues::person_message`, `edit_message`, `remove_message`, `withdraw_ruling`: changed. Each calls `seeded_ledger(root, name)` after `person(...)` resolves the name and before `transaction`.
- `plugins/ok/families/ok-planner/scripts/issues::set_flag`: changed. It tries `person(root, "count unread messages by")`; on a name it calls `seeded_ledger`; on the `unnamed` refusal it goes on; any other refusal propagates, as in `reading_ledger`.

**Behavior changes**
- **B429** `plugins/ok/families/ok-planner/scripts/issues` (person write verbs). Before: a person with no ledger who comments, rules, edits, removes, withdraws, or flags gets no ledger, so their first read counts every reply that landed in between as read. After: the act creates the ledger, and a reply landing after it shows as new to that person in `issues list --unread`, `issues show`, and the dashboard. Users: in the release: the CLI verbs `rule`, `comment`, `edit`, `remove`, `unrule`, `flag`, `unflag`; the dashboard's POST routes; every reader of the ledger (`view`, `list --unread`, `GET /api/issues?unread=1`). Across stored state: ledgers under `.ok-planner/.cache/read/`, which git ignores; an existing ledger is read and written as before, and `seeded_ledger` converts an old-marks ledger as `reading_ledger` already does. Ruling: rewrite.

### The tests tool lists test files in the declared folders

**Calls**
- Build note: `tests::tree_files` gains a `folders` parameter; pass it at every call site, the groups item's citation scan included.
- Build note: confirm that `plumbline test-paths` classifies a declared folder's `../<folder>/...` paths as the lint does, including a configured test pattern that holds `/`.
- Build note: `tests::main` handles `review.ReviewError` from `review::declared_folders` as a refusal, not an internal error, and the note names the tests tool.
- Build note: `tests::tree_files` returns paths in a declared folder relative to the project root, and `review.listed_changes` returns paths relative to the repository's top level; `window_entry` brings both lists to one path form before it compares them.
- `tests` reads the declared folders through `review.project_folders(root)`, loaded with `load_sibling("review")` the way `scripts/discover` loads it. That function validates `folders` through `plumbline config-check`. Decided by: rule 6 (import, never copy) and decision:project-declares-its-folders ("one list every tool reads"). No cycle forms: review loads issues, issues loads tasks, and none of them loads tests.
- The `git ls-files … -- . <folders>` call stays inline in `tests::tree_files` with an explicit folder list. It is one line at two sites. Decided by: the cheatsheet ("Do not extract trivia").
- `tests::changed_since` lists changes in the root alone too (`git diff --relative`), and `window_entry` (`changed`, `edited_tests`) and `complete_failures` (the base check) build on it. It is a member of the same class, so this item fixes it too. Decided by: rule 8. Its diff across folders beside the root (no `--relative`, paths taken relative to the top level, untracked files) is inline in `review::changed_files`. Extract it in `review` as `listed_changes(root, base, beside)`, which `review::changed_files` and `tests::changed_since` both call. Decided by: rule 6. The review stages of other work items edit `scripts/review`, so this stage chains with them.
- Sprint-scoped reads use the folders the plan was planned over. The assembly records `"folders": <review.project_folders(root)>` in `-plan.json`, and `stray_paths`, `test_file_hashes` in a sprint round, and `complete_failures`' base check read the plan's `folders`. A folder declared after planning holds test files no planner sorted; read from the configuration, they would be strays, the sweep would delete them (A2), and the round hashes would fail on them. Decided by: accept-list entry A2.
- No delta to decision:project-declares-its-folders. Its Choice already reads "Every tool that lists or scopes the project's code reads that list", and the tests tool joins that set. The list after the colon names the review tool, the lint, and the edit hook. The session may add the tests tool there with an aligning delta, which changes no promise. Decided by: `{{OWNER-QUESTION-TEST}}` 1 (rewording to match the code is not a promise change).
- `scripts/docs` holds the same root-only listing (its `changed_since`, and its window's file listing). No definition this item changes reaches it, so it belongs to the documentation planner's window work item or to `/converge`'s next run. Decided by: the planner's Scope rule.
- Leave `# @story: project-spans-folders` above `tests::tree_files`, as `review::declared_folders` carries it. Decided by: the estate's annotation rule.

**Changes**
- `scripts/tests`: gains `load_sibling` and `review = load_sibling("review")`. These are shared with the closed-stamp work item: one definition and one load.
- `scripts/tests::tree_files(root, folders)`: changed. Lists `git ls-files --cached --others --exclude-standard -- . <folders>` and keeps the paths that are files, so paths in a declared folder come back as `../<folder>/…`.
- `scripts/tests::changed_since(root, since, folders)`: changed. Returns the paths `review.listed_changes` gives across the root and the folders.
- `scripts/review::listed_changes(root, base, beside)`: new, extracted from `changed_files` with no filter. `scripts/review::changed_files`: changed. It calls `listed_changes` with `sorted(set(outside) | set(project_folders(root)))`, then filters as today, so its output is unchanged.
- `scripts/tests::window_entry`: changed. Passes `review.project_folders(root)` to `tree_files` and `changed_since`.
- `scripts/tests::assembled_plan`: changed. Records `folders` in the plan.
- `scripts/tests::plan_folders(plan)`: new. Returns `plan["folders"]`, which every plan this release assembles records.
- `scripts/tests::stray_paths`, `scripts/tests::test_file_hashes` (called with the sprint's plan folders from `cmd_run --sprint` and `complete_failures`), and `scripts/tests::complete_failures` (the base check): changed. Each reads the plan's folders.

**Behavior changes**
- **B113** `scripts/tests::tree_files`, `changed_since`, and `window_entry` (`tests window`). Before: unmapped test files, changed files, and edited claimed tests are listed under the project root alone. After: they include each folder `.ok-planner/config.json` declares under `folders`, so `/plan-tests` sorts, adopts, and deletes tests there. Users: in the release, `SKILL.md` steps 3 and 5.2, the planner prompts that read the window, and `plan_failures`, which requires every unmapped file sorted. A project with no `folders` sees no change. Ruling: rewrite.
- **B114** `scripts/tests::stray_paths`, `test_file_hashes`, and `complete_failures` (`tests stray`, `tests run --sprint`, `tests complete`, and the sweep). Before: they read the root alone. After: they read the folders the test sprint's plan records. Users: in the release, the test sprint's steps 5 to 7. Across Trued-up projects: none; the boundary leaves out a test sprint planned earlier, whose `-plan.json` holds no `folders`, and one not yet executed is brought current before it runs. `tests complete` reads an archived test sprint with a `closed:` stamp as terminal before the base check. Ruling: rewrite.

**New surface**
- `review::listed_changes` and the `folders` key of a test sprint's `-plan.json`, declared in `scripts/review` and `scripts/tests`: internal.


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

2. Record the base. Sprint certification reads the change from this
   commit, so the tree holds nothing but this sprint's work from here
   on. The planning session leaves its own files uncommitted: this
   file, its delta sidecar, `.ok-planner/release-boundaries.md`, the
   intake's two files (`.ok-planner/issues.jsonl` and
   `.ok-planner/history/issues.jsonl`), and the sketches it archived. Where `git
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
   register ok-opus`, and register the `build` prompt: write
   `{{SPRINT-BUILD-PROMPT}}` from `.claude/skills/_sprint/shared.md`,
   its transclusions resolved and `[SPRINT PATH]` filled, to
   `.ok-planner/sprints/<sprint-name>-build.md`, then `tasks prompt
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
   when its build task is dispatched, and done when that task closes
   `done`. Add one entry for sprint certification when the drain ends.
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
    re-renders it whole from the run before every dispatch: `##
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
    `done`. Then run sprint certification, immediately after:
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
    this. Then run `.ok-planner/bin/review certified --sprint <this
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
   file at its new path, the `/converge` run's ledger and folder, and
   the intake's two files, `.ok-planner/issues.jsonl` and
   `.ok-planner/history/issues.jsonl`. Commit those paths alone
   with `git commit -- <paths>`, naming only paths that exist or that
   `git mv` removed, so nothing else standing in the index rides
   along.
4. Add `closed: <the commit's sha>` to the archived sprint as YAML
   frontmatter, and commit that edit alone. The next planning
   session reads that stamp to detect work done out of band.

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
   owner.

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
