# Plan-sprint test planning

The blocks `/plan-sprint` uses when it plans a sprint's tests: the revision rule, the planner review prompt, and the plan-wide review prompt. The planner prompts are in `tests-story.md`, `tests-runtime.md`, `tests-programs.md`, `tests-sort.md`, and `tests-budget.md`. `{{TOKEN}}` names a block to use verbatim, from `tests.md` in this folder, `skills/_sprint/shared.md`, or `skills/_shared/dispatch-discipline.md`, and resolves only where the token stands alone on its line. `[...]` inside a block is a value the session fills before it registers the prompt; `[SPRINT PATH]` is the sprint the session is planning.

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
finding names. Refile each question as it was filed, at state `open`:
the owner's answer stands for its scenario or program. Raise no new
question on a scenario or program the owner already answered.

Where task <id> planned stories your brief does not name, refile the
items of the stories your brief names alone: each one's `stories`
item, its scenarios, the questions on them, the calls that name it,
and the time control items that name it. The assembly takes every
other story's items from task <id>.
```

---

### {{TEST-PLANNER-REVIEW-PROMPT}}

The task prompt for a planner review, one task per planner task: each story group, each one-story re-plan, the runtime task, and each sort batch. `[SPRINT PATH]` is the sprint the session is planning.

```
Task prompt (profile ok-opus):
  ## Review one planner task's items

  {{LEAF-AGENT-RULE}}

  {{READ-ONLY-REVIEWER-RULE}}

  You review the items one planner task filed, for the sprint at
  [SPRINT PATH], before the owner approves the plan. Your brief
  names the task as `review task <task id> (<its key>)`, the stories
  whose items the assembly takes from it, and the program answers
  every planner works inside. Another review checks the plan as a whole; you check this
  task's items alone.

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
     item, its scenarios, the questions on them, the calls that name
     it, and the time control items that name it. A later story task re-planned that story, the assembly
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
  - Each runtime `new` and `rewrite` causes its condition from outside
    the product, save through a time control the product has or a
    work item builds.
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

The task prompt for the plan-wide review, one task, filed beside the planner reviews. `[SPRINT PATH]` is the sprint the session is planning.

```
Task prompt (profile ok-opus):
  ## Review a sprint's test plan as a whole

  {{LEAF-AGENT-RULE}}

  {{READ-ONLY-REVIEWER-RULE}}

  You review the plan of the sprint at [SPRINT PATH] as a
  whole, before the owner approves it. A planner review checks each
  planner task's items; you check what no single planner's items
  show: the scenarios across planners, the shared resources they
  declare, the setup they repeat, the time controls they record, the
  budget of the test stack, and the owner's answers. The budget is
  the one a budget task recorded, or, where none ran, the recorded
  budget the plan carries.

  {{TEST-SCENARIO-DEFINITION}}

  {{TEST-WASTE-RULE}}

  ### Read

  1. The plan: `.ok-planner/bin/tests plan --sprint [SPRINT PATH]
     --show`, and `--show --json` for each scenario's source,
     entry, and test.
  2. The sprint whole, the owner's test answers above all: the
     groups the owner took, each program answer, and each scenario
     answer.
  3. The owner's answers as the run records them: `tasks item list
     --pool questions --state answered --json`.
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

  ### Check

  - No two scenarios across planners check one outcome through one
    program.
  - The plan sorts only the legacy folders the owner took: no `legacy`
    entry names a file outside them, and the plan records every other
    test file no scenario claims as kept.
  - Each program answer holds as the owner gave it: no planned test
    enters a program the owner left unguarded, and each issue answer
    names the issue filed.
  - Each scenario answer holds as the owner gave it: a retire retires
    the scenario, a rewrite plans the outcome the owner stated, and an
    issue keeps the scenario's test and names the issue.
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
    duplicate. Each item stands in the sprint as a work item a code
    stage builds.

  ### Record

  Per finding: `tasks item add --pool review --key <scenario or file>
  --field site=<scenario, file, or budget> --field refile=<the planner
  or budget task whose item it is, or none where no task of this run filed it>
  --field fix="<what the planner must change>" --body "<what breaks
  which check>" --task <task>`. Close: `tasks close <task> --outcome
  done --result "<n> findings"`.
```
