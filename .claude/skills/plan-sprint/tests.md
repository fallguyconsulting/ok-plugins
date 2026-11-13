# Test planning

`/plan-sprint` sets a sprint's test scope and plans no test in detail. Sprint execution plans each test inside that scope as its first stage, ahead of the build, by the procedure below, which step 3a of the sprint's "How to execute this sprint" section reads at `.claude/skills/plan-sprint/tests.md`. This file holds the procedure, the fixing rules, the scope-change rule, the revision rule, the planner review prompt, and the plan-wide review prompt. The planner prompts are in `tests-story.md`, `tests-runtime.md`, `tests-programs.md`, `tests-sort.md`, and `tests-budget.md`. `{{TOKEN}}` names a block to use verbatim, from `tests.md` in this folder, `skills/_sprint/shared.md`, or `../_shared/dispatch-discipline.md`, and resolves only where the token stands alone on its line. `[...]` inside a block is a value the session fills before it registers the prompt; `[SPRINT PATH]` is the sprint whose tests the run plans.

## The test planning procedure

The executing session runs this procedure where the groups file `<name>-groups.json` stands beside the sprint and no plan `<name>-plan.json` does. A sprint whose plan already stands keeps that plan and skips the procedure. Below, `<name>` is the sprint's filename without `.md`, `<sprint>` is `.ok-planner/sprints/<name>.md`, and `<run>` is `.ok-planner/sprints/<name>-test-planning.jsonl`. Pass `--frozen` to `tests plan`'s assembly exactly where `testing.enabled` is `frozen`. The planners read the code as it stands, before any build task changes it, beside the sprint's work items and implementation notes, which say what the code does once built. They write no file in the project. No step of the procedure waits on the owner: each point at which a planner would need the owner's word becomes a call, which the completion report lists for the owner's veto, or a program question, which sprint certification's owner list files in the intake.

**Nothing to plan.** Read the groups file. Where its `stories` map is empty, its `sort` list is empty, its `runtime` is false, and its `unguarded` list is empty or absent, the sprint plans no test: file nothing, write no plan, and go on to step 4 of the sprint. A groups file an earlier release wrote reads the same way.

**The planning run.** Where `<run>` stands, the procedure resumes it: run `.ok-planner/bin/tasks use <run>`, then `.ok-planner/bin/tasks retry --all`. Otherwise open it:

```bash
.ok-planner/bin/tasks init <name>-test-planning --file .ok-planner/sprints/<name>-test-planning.jsonl
```

Either way, run every registration and config below, again on a resumed run:

```bash
.ok-planner/bin/tasks agent register ok-opus
.ok-planner/bin/tasks config set item_states '{"stories": ["open"], "scenarios": ["open"], "questions": ["open"], "legacy": ["open"], "calls": ["open"], "controls": ["open"], "budget": ["open"], "limits": ["open"], "review": ["open", "resolved"]}'
.ok-planner/bin/tasks config set field_types '{"budget": {"workers": "integer"}, "scenarios": {"gap": "boolean"}}'
.ok-planner/bin/tasks config set calls '[{"pool": "calls", "latest": true}]'
```

The `calls` setting selects, for the completion report, each call the latest done task of each role and key recorded, so a refiled planner's calls replace the earlier task's.

Then, for each of `{{TEST-PROGRAMS-PROMPT}}` in `tests-programs.md` as `programs`, `{{TEST-STORY-PLANNER-PROMPT}}` in `tests-story.md` as `story`, `{{TEST-RUNTIME-PLANNER-PROMPT}}` in `tests-runtime.md` as `runtime`, `{{TEST-SORT-PROMPT}}` in `tests-sort.md` as `sort`, `{{TEST-BUDGET-PROMPT}}` in `tests-budget.md` as `budget`, `{{TEST-PLANNER-REVIEW-PROMPT}}` in this file as `review`, and `{{TEST-PLAN-WIDE-REVIEW-PROMPT}}` in this file as `plan-review`, write the block, its transclusions resolved and `[SPRINT PATH]` filled with `<sprint>`, to `.ok-planner/sprints/<name>-test-planning-<role>.md`, and register it: `.ok-planner/bin/tasks prompt register <role> <that path>`. The blocks live under `.claude/skills/plan-sprint/`, and `review prompt` reads only the review estate's prompts, so the session resolves each token itself. Every task below runs on this run, under the profile `ok-opus`, and every drain uses the drain loop at `.claude/skills/_tasks/drain.md`.

1. **The programs.** File one programs task: `.ok-planner/bin/tasks file --role programs --prompt programs --agent ok-opus --key programs --brief "work item files: <each file the work items name>; taken legacy test files: <each path of the groups file's sort list, or none>; <the groups file's inputs line>"`. Drain. List the program questions it raised: `.ok-planner/bin/tests plan --sprint <sprint> --from-run <run> --questions`. Each is an executable entry point no story serves, which the plan holds no test for until a story or an unguarded record stands. Below, `<the questions>` stands for `program questions: <each question's path>`, or `program questions: none`.
2. **The planners.** File one story task per group of the groups file, with its brief: `.ok-planner/bin/tasks file --role story --prompt story --agent ok-opus --key <the group's key> --brief "<the group's brief>; <the questions>"`. Where the groups file's `runtime` is true, file one runtime task: `.ok-planner/bin/tasks file --role runtime --prompt runtime --agent ok-opus --key runtime --brief "<the inputs line>; <the questions>; the last run is at <the groups file's last_run, or none>"`. Where the `sort` list holds files, file one sort task per ten of them, in path order: `.ok-planner/bin/tasks file --role sort --prompt sort --agent ok-opus --key sort:<n> --brief "<the inputs line>; files: <the paths>"`. Drain. A task that closes `partial` is refiled whole with `.ok-planner/bin/tasks refile <task>`: the latest done task of each key stands, and its items replace the earlier task's. Each story's items come from the highest-numbered story task that records a `stories` item for it, so a one-story re-plan replaces that story's items alone.
3. **Assemble.** Run `.ok-planner/bin/tests plan --sprint <sprint> --from-run <run>`. It reads the groups and the planners' items, writes the plan beside the sprint, `<name>-plan.json`, which names each test path and its action, records each program question in the plan's `questions`, and prints the counts. It sorts only the files of the taken legacy folders, and records every other test file no scenario claims as kept. Where it refuses, it names each failure and the item it rests on, as `<item id> (task <task id>)`: fix each one as "Fixing a planner's items" below says, and assemble again.
4. **The budget.** Read the plan, `.ok-planner/bin/tests plan --sprint <sprint> --show --json`, and the budget the scenario list records, `.ok-planner/bin/tests scenarios --json`. File one budget task only where one of these holds:
   - the plan holds a `new` or `rewrite` that needs the test stack;
   - the plan declares a shared resource no recorded test declares;
   - a work item changes a file the recorded budget's `files` names.

   The task: `.ok-planner/bin/tasks file --role budget --prompt budget --agent ok-opus --key budget --brief "<the inputs line>; the last run is at <the groups file's last_run, or none>"`. Drain, and assemble again, as step 3 says. Where none holds, file no budget task: the plan carries the recorded budget, its preflight mark included, and the sprint's test stages run no preflight for a budget the plan leaves as recorded.
5. **Review.** File one review task per planner task the assembly reads, the latest done task of each key: each `group:<n>`, each `story:<slug>` re-plan, `runtime`, and each `sort:<n>`. `.ok-planner/bin/tasks report` lists each task's key, role, state, and outcome. A story task's review names only the stories whose items the assembly takes from that task, as step 2 picks them: each story whose `stories` item that task records and no higher-numbered done story task records, from `.ok-planner/bin/tasks item list --pool stories --json`. A story task whose every story a later re-plan took gets no review. Per planner task: `.ok-planner/bin/tasks file --role review --prompt review --agent ok-opus --key review:<its key> --brief "review task <its task id> (<its key>); stories: <the stories the assembly takes from it, or none>; <the inputs line>; <the questions>"`. Then file one plan-wide review task: `.ok-planner/bin/tasks file --role plan-review --prompt plan-review --agent ok-opus --key review:plan --brief "review the plan; <the inputs line>; <the questions>"`. The programs task and the budget task get no review of their own: the plan-wide review checks the program questions, the unguarded programs, the shared resources the planned tests declare, the budget, and whether the suite command runs every planned test. Drain. List the findings: `.ok-planner/bin/tasks item list --pool review --state open --json`. Each finding names its site, the planner task its `refile` field names, and the fix. Apply each one to that planner task's items, as "Fixing a planner's items" says. A finding on the budget is a judgment fix, and goes back as a revision refile of the budget task; where no budget task ran, file one as step 4 does, its brief ending in the finding. A finding whose `refile` is `none` names a scenario no task of this run planned: a story's scenario re-plans its story alone, and a runtime scenario goes to a runtime task filed as step 2 files one, its brief ending in the finding. Mark each finding `resolved` once its fix is applied, and assemble again. The review runs once: a re-plan a finding sends gets no second review.
6. **Hand over the time controls.** After the last assembly, run `.ok-planner/bin/tasks use .ok-planner/sprints/<name>-run.jsonl`, so the sprint's step 4 files into the sprint's run. The summary of `.ok-planner/bin/tests plan --sprint <sprint> --show` lists each time control the plan builds, with its form, its site, its files, its gate setting, and the scenarios that wait on it. Step 4 of the sprint files one build task per time control, which a code stage builds before the test stages run, and records each one as a call.

**Fixing a planner's items.** One rule covers every fix to a planner's items: an assembly failure (step 3) and a review finding (step 5), a test the suite command does not run inside its silence period among them. A fix is mechanical when the failure or the finding names the whole change: a rename, a drop, a fold of named scenarios into one, or a wording fix whose new words it gives. The session applies a mechanical fix itself, with the tracker's verbs, to the item the failure or finding names, and the items stay under the planner's task:

- **A rename** sets the item's id: `.ok-planner/bin/tasks item set <item> --field id=<new id>`. It then sets the new id on every legacy item whose `scenario` field or `scenarios` list names the old id.
- **A drop** runs `.ok-planner/bin/tasks item drop <item> --by test-planning --reason "<the failure or finding>"`, so the dropped item leaves the plan.
- **A fold** drops every folded item but the one it keeps, as a drop does, sets the kept item's body to the folded outcome with `.ok-planner/bin/tasks item set <item> --body "<the outcome>"`, and sets the kept id on each legacy item that names a folded id, as a rename does.
- **A wording fix** sets the item's body: `.ok-planner/bin/tasks item set <item> --body "<the new words>"`.

A drop or a fold is mechanical only for a scenario the scenario list does not record: a recorded scenario needs an action, `keep`, `rewrite`, or `retire`, and choosing one is the planner's judgment. Every other fix needs the planner's judgment, and goes back once every mechanical fix is applied. A judgment fix to a story's items re-plans that story alone, in a story task keyed `story:<slug>` whose brief is the story's group brief narrowed to that story: `.ok-planner/bin/tasks file --role story --prompt story --agent ok-opus --key story:<slug> --brief "stories: <slug> (<its reasons in the groups file>); <the inputs line>; <the questions>; the last run is at <the groups file's last_run, or none>; revise task <the task its items came from>: <each failure or finding that names the story>"`, or, where a `story:<slug>` task already planned it, `.ok-planner/bin/tasks refile <that task>` with the same brief. A touched story no story task planned re-plans the same way, with no `revise` part. Every other judgment fix goes back as a revision refile of its planner: `.ok-planner/bin/tasks refile <its task> --brief "<its brief>; revise task <its task>: <each failure or finding that names it>"`. One re-plan per story, and one revision refile per other planner, carries every judgment fix that names it. A test the suite command does not run inside `testing.silence` is a judgment fix: its planner plans it in a form the command runs, with `testing.setup` readying its environment, or records a call of kind `untested` for each outcome no such form reaches. Drain. Mark a finding `resolved` with `.ok-planner/bin/tasks item set <finding> --state resolved` once its fix is applied, by either path. After the fixes, assemble again, as step 3 says. A task that closes `partial` is still refiled whole, as step 2 says.

**The scope-change rule.** In `/plan-sprint`, a change after the scope is set that changes it reruns `.ok-planner/bin/tests groups` with the changed flags, and the session writes the `## Tests` section again from its output: a kickback's re-run of code planning or a notes review finding that changes a **Tested stories** list, a change at Approval, and a story whose new tests the owner declines, whose slug leaves `--new`. Execution plans inside the scope the groups file holds when the owner approves the sprint.

---

### {{TEST-REVISION-RULE}}

```
Where your brief says `revise task <id>`, the session found items of
that earlier task wanting and named each in your brief. Read every
item task <id> filed, in each pool this prompt records into: `tasks
item list --pool <pool> --json`, the entries whose `task` is <id>.
Refile each one under your own task as it was filed, with the same
`id` field, the same fields, and the same body, unless a failure or
finding in your brief names it. Change only what each failure or
finding names. Refile each program question as it was filed, at state
`open`.

Where task <id> planned stories your brief does not name, refile the
items of the stories your brief names alone: each one's `stories`
item, its scenarios, the calls that name it, and the time control
items that name it. The assembly takes every
other story's items from task <id>.
```

---

### {{TEST-PLANNER-REVIEW-PROMPT}}

The task prompt for a planner review, one task per planner task: each story group, each one-story re-plan, the runtime task, and each sort batch. `[SPRINT PATH]` is the sprint whose tests the run plans.

```
Task prompt (profile ok-opus):
  ## Review one planner task's items

  {{LEAF-AGENT-RULE}}

  {{READ-ONLY-REVIEWER-RULE}}

  You review the items one planner task filed, for the sprint at
  [SPRINT PATH], before the plan is assembled for the last time and
  the sprint's build starts. Your brief names the task as `review task
  <task id> (<its key>)`, the stories whose items the assembly takes
  from it, and the unguarded programs and program questions every
  planner works inside. Another review checks the plan as a whole; you
  check this task's items alone.

  {{TEST-SCENARIO-DEFINITION}}

  {{TEST-RUNTIME-CLASSES}}

  {{TEST-WASTE-RULE}}

  {{TEST-WAITS-RULE}}

  {{TEST-RESOURCES-RULE}}

  ### Read

  1. The task's items: in each of the pools `stories`, `scenarios`,
     `questions`, `legacy`, `calls`, and `controls`, `tasks item list
     --pool <pool> --json`, the entries whose `task` is the task your
     brief names. For a story task, leave out the items of each story
     it planned that your brief does not name: that story's `stories`
     item, its scenarios, the calls that name it, and the time control
     items that name it. A later story task re-planned that story, the assembly
     takes its items from that task, and that task's own review checks
     them.
  2. Each story your brief names, whole, as the sprint leaves it: the
     body of the sprint's `New story:` or `Amend story:` delta for it,
     in the sprint or in its sidecar folder, else
     `.ok-planner/design/stories/<slug>.md`. Read the code that
     carries it: the programs a user runs to get its benefit, each
     entry point, and the path it takes, beside the sprint's Work
     items and Implementation notes, which say what that code will do
     once built.
  3. For a runtime task: the accept list at
     `.ok-planner/review/catalog/accept.md`, and the runtime parts the
     product holds or depends on, as `.ok-planner/review/project.md`
     and the tree show them.
  4. For a sort task: each test file its `legacy` items name, whole,
     and each written rule a `port` names, and each rule a `port`
     states as inferred.
  5. The scenarios the list records: `.ok-planner/bin/tests
     scenarios --json`.
  6. `testing.setup` in `.ok-planner/config.json`: the project holds
     a seed only where it is a command that builds one, and holds
     none where it is `null`.

  ### Check

  - Each scenario checks one distinct outcome a program shows for a
    plausible way the story's implementation gives or refuses its
    benefit, or a runtime pairing of part, class, and harm.
  - No two of the task's scenarios check one outcome through one
    program.
  - Each distinct outcome the code shows for a story your brief names,
    or a runtime part the task planned, has a scenario, or a call of
    kind `untested`.
  - Each scenario's text states an outcome, not how the code reaches
    it.
  - Each `new` and `rewrite` reaches the code through a public entry
    point, and names its kind, its setup, and its entry.
  - No `new` or `rewrite` enters a program the scenario list records
    as unguarded, an unguarded program your brief names, or a program
    question's entry point.
  - Each scenario whose outcome the sprint changes is a `rewrite` that
    states the outcome the sprint's work items, deltas, or notes
    state, and each scenario whose code the sprint removes while its
    story stands is a `retire` with `gap` true; each has a call that
    names the work item, the delta, or the commit. The task records no
    question on a scenario.
  - Each runtime `new` and `rewrite` causes its condition from outside
    the product, save through a time control the product has or a
    code stage builds.
  - Each `new` and `rewrite` reaches its outcome at the cheapest reach
    that proves it, and spends its time on no waste the waste rule
    names.
  - Each `new` and `rewrite` records `resources` and `reads`, each
    `[]` for an isolated test. Each slug in `resources` names a
    shared resource the test changes, and each slug in `reads` one it
    reads and does not change, and the test changes or reads no shared
    resource it leaves undeclared. Send back each declaration a
    cheaper design avoids, such as a clock the test could inject, a
    broker of its own, or data of its own in place of shared data it
    reads.
  - A group the brief marks `frozen` holds no `new` scenario, and
    each outcome a `new` would check has a call of kind `untested`.
  - Each `new` and `rewrite` names in `waits` an event, a time
    control, or a clock the test moves, and none waits on elapsed
    time. Each timer, schedule, or threshold a test meets that the
    product gives no time control for has a time control item, and
    each item names its form, its site, its files, and, for a trigger
    or a clock, its gate setting.
  - Each legacy `port` names a written rule, or states in `inferred`
    the rule on the code's shape it infers, which the test enforces;
    and each `adopt` names a scenario whose text the test checks.

  ### Record

  Per finding: `tasks item add --pool review --key <scenario or file>
  --field site=<scenario or file> --field refile=<the task your brief
  names> --field fix="<what the planner must change>" --body "<what
  breaks which check>" --task <task>`. Close: `tasks close <task>
  --outcome done --result "<n> findings"`.
```

---

### {{TEST-PLAN-WIDE-REVIEW-PROMPT}}

The task prompt for the plan-wide review, one task, filed beside the planner reviews. `[SPRINT PATH]` is the sprint whose tests the run plans.

```
Task prompt (profile ok-opus):
  ## Review a sprint's test plan as a whole

  {{LEAF-AGENT-RULE}}

  {{READ-ONLY-REVIEWER-RULE}}

  You review the plan of the sprint at [SPRINT PATH] as a
  whole, before it is assembled for the last time and the sprint's
  build starts. A planner review checks each planner task's items; you
  check what no single planner's items show: the scenarios across
  planners, the shared resources they declare, the setup they repeat,
  the time controls they record, the budget of the test stack, the
  program questions and unguarded programs, and whether the suite
  command runs every planned test. The budget is the one a budget task
  recorded, or, where none ran, the recorded budget the plan carries.

  {{TEST-SCENARIO-DEFINITION}}

  {{TEST-WASTE-RULE}}

  ### Read

  1. The plan: `.ok-planner/bin/tests plan --sprint [SPRINT PATH]
     --show`, and `--show --json` for each scenario's source,
     entry, and test.
  2. The sprint whole, its `## Tests` section above all: the groups
     the owner took, the stories it touches, and each unguarded
     program with the owner's reason.
  3. The program questions the run raised: `tasks item list --pool
     questions --json`, and the plan's `questions`.
  4. The planner task of each scenario: `tasks item list --pool
     scenarios --json`, the entry whose `id` field is the scenario's,
     from the latest done task that planned its story or, for a
     runtime scenario, the latest done runtime task.
  5. The budget: the summary's "Shared resources declared" and "The
     test stack's budget", the budget task that recorded it, from
     `tasks item list --pool budget --json`, where one ran, and each
     configuration file the sizing names, whole.
  6. The time controls: the summary's "Time controls the plan
     builds", and the timer each names at its site.
  7. `testing.setup` in `.ok-planner/config.json`: the project holds
     a seed only where it is a command that builds one, and holds
     none where it is `null`.
  8. The runner, in `.ok-planner/config.json`: `testing.run`, the
     project's suite command; `testing.setup`, the command that gets
     the test environment ready before the silence clock starts; and
     `testing.silence`, the seconds with no result line and no output
     after which the run stops. The summary's "Planned tests by kind
     and setup" lists each kind and setup pair of the planned `new`
     and `rewrite` tests with its count.

  ### Check

  - No two scenarios across planners check one outcome through one
    program.
  - The plan sorts only the legacy folders the owner took: no `legacy`
    entry names a file outside them, and the plan records every other
    test file no scenario claims as kept.
  - No planned `new` or `rewrite` enters a program the plan's
    unguarded list names or a program its questions name.
  - Each scenario whose outcome the sprint changes is a `rewrite` to
    the outcome the sprint states, and each scenario whose code the
    sprint removes while its story stands is a `retire` with `gap`
    true, each with a call.
  - The suite command runs each kind and setup pair inside the silence
    period: `testing.setup` gets that setup's environment ready, the
    suite command runs a test of that kind, and the test prints a line
    of output or its result inside every silence period. A suite
    command that runs files under a unit runner does not run a test
    that needs a browser, and a stack that takes a minute to start
    belongs in `testing.setup`, outside the silence clock. Send back
    each `new` and `rewrite` scenario of a pair the command does not
    run, naming why: its planner plans it in a form the command runs,
    or records a call of kind `untested` for each outcome no such form
    reaches.
  - Each shared resource a test declares in `resources` is one it
    changes, each one it declares in `reads` is one it reads and does
    not change, and no cheaper design avoids the declaration, such as
    a clock the test could inject, a broker of its own, or data of its
    own in place of shared data it reads. One slug names one resource
    across planners. Send back each declaration a cheaper design
    avoids.
  - A budget task ran where the plan holds a `new` or `rewrite` that
    needs the stack, declares a resource no recorded test declares,
    or carries a work item that changes a file the recorded budget's
    `files` names.
  - The budget names its workers, its sizing, and a handling, raise,
    split, or lease, for each deployment-wide limit the planned tests
    meet.
  - The test stack's configuration gives the sizing the budget names
    for that many workers, or the budget names the change the
    preflight writes to reach it.
  - No setup repeats across the planners' tests that one shared setup
    could serve safely, such as a sign-in or a stack each test starts
    for itself. Send back each test that repeats it.
  - No two time control items control one timer, and each item is
    the time control the timer at its site needs. Send back each
    duplicate. The session files each item as a build task, a code
    stage that builds it before the test stages run.

  ### Record

  Per finding: `tasks item add --pool review --key <scenario or file>
  --field site=<scenario, file, or budget> --field refile=<the planner
  or budget task whose item it is, or none where no task of this run filed it>
  --field fix="<what the planner must change>" --body "<what breaks
  which check>" --task <task>`. Close: `tasks close <task> --outcome
  done --result "<n> findings"`.
```

<!-- Materialized by ok-planner v31.1.0 — suite-owned; overwritten on true-up; do not hand-edit. -->
