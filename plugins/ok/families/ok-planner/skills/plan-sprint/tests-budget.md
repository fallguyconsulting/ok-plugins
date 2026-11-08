# Plan-sprint test planning: budget

The block `/plan-sprint` uses for the budget task's prompt when it plans a sprint's tests. `{{TOKEN}}` names a block to use verbatim, from `tests.md` in this folder, `skills/_sprint/shared.md`, or `skills/_shared/dispatch-discipline.md`, and resolves only where the token stands alone on its line. `[...]` inside a block is a value the session fills before it registers the prompt; `[SPRINT PATH]` is the sprint the session is planning.

---

### {{TEST-BUDGET-PROMPT}}

The task prompt for the budget, one task, after the sort, on a plan whose tests or stack change the budget: a planned `new` or `rewrite` that needs the stack, a resource a planned test declares that no recorded test declares, or a work item that changes a file the recorded budget's `files` names. `/ok-setup` runs it too, when it turns testing on. `[SPRINT PATH]` is the sprint the session is planning, or `none` where `/ok-setup` runs it.

```
Task prompt (profile ok-opus):
  ## Budget the test stack

  {{LEAF-AGENT-RULE}}

  You budget the test stack the project's suite spends as one
  resource, for the sprint at [SPRINT PATH]: every test its plan
  keeps, writes, or adopts. Where the sprint path is `none`,
  `/ok-setup` runs you, no sprint plans tests, and you budget the
  tests the scenario list records. You write no file in the project.
  You record the budget as items, and the session assembles it into
  the plan, or `/ok-setup` records it. The preflight before the
  sprint's first test task checks your budget against the running
  stack, and the plan-wide review checks it before the owner approves
  the plan.

  A test declares each shared resource it changes in `resources`, and
  each shared resource it reads and does not change in `reads`. A
  test that declares a resource it changes and no `reads` counts as
  reading every shared resource. An isolated test declares no
  resource and reads no shared resource. Isolated tests run side by
  side on the one test stack. Tests that share a changed resource
  form one group, which runs its tests one after another on one
  worker. Which tests run at the same time follows the schedule the
  project records in `testing.schedule`: under `recommended`, two
  tests may run at the same time unless one changes a resource the
  other changes or reads; under `groups-side-by-side`, held groups
  run at the same time as each other, after the isolated tests; under
  `groups-one-at-a-time`, held groups run one after another, after
  the isolated tests. The run uses at most the budget's workers.

  ### Read

  1. The planned tests: `tasks item list --pool scenarios --json`, and
     the tests the scenario list records: `.ok-planner/bin/tests
     scenarios --json`, and the budget it records. A story this
     sprint does not plan keeps its recorded scenarios, which are not
     items in the run. Note each test's kind, its setup, the shared
     resources it declares in `resources`, and those it declares in
     `reads`.
  2. The last run of the suite, where your brief names one: each
     test's seconds, setup and teardown included.
  3. The runner, in `.ok-planner/config.json`: `testing.run`, the
     project's suite command, which runs a list of tests with the
     number of workers the list names, and `testing.schedule`, the
     schedule form it runs.
  4. Where the sprint path is not `none`, the sprint's Work items and
     its Implementation notes, for each change they make to the test
     stack or to a file the recorded budget names.
  5. The test stack: how the project starts it, from
     `.ok-planner/review/project.md` and the project's stack tool, and
     each configuration file that sizes it: its services' memory, its
     connection pools, its worker counts, and its deployment-wide
     limits, such as one sign-in per user or a cap on fleet members.

  ### Budget

  - Name the number of workers the suite runs, a whole number of 1 or
    more. Each worker runs one test at a time, every worker on the
    same test stack.
  - Name the command that starts the test stack, or `none` where no
    planned test needs one.
  - Name the sizing: each configuration file and the values it gives
    for that many workers, such as memory per service and pool sizes,
    with each change the preflight writes to reach them. A sizing the
    configuration does not give for that many workers lowers the
    workers, or names the change.
  - Name the configuration files the preflight may edit, none where
    the configuration already gives the sizing.
  - Per deployment-wide limit the tests meet, say how the suite meets
    it: `raise`, the test stack's configuration raises it; `split`,
    the workers split it, such as one user per worker; or `lease`, a
    lease hands it out, and say what hands it out.

  {{TEST-REVISION-RULE}}

  ### Record

  One budget: `tasks item add --pool budget --key budget --field
  workers=<n> --field stack="<the command that starts the test stack,
  or none>" --field sizing="<each configuration file and the values it
  gives for that many workers, with each change the preflight writes>"
  --field 'files=["<each configuration file the preflight may edit>",
  ...]' --body "<why this many workers>" --task <task>`.

  Per limit: `tasks item add --pool limits --key <a slug for the
  limit> --field limit="<the limit>" --field how=<raise | split |
  lease> --field detail="<the setting that raises it, how the workers
  split it, or what hands out the lease>" --body "<the tests that meet
  it>" --task <task>`.

  {{TEST-CALL-RULE}}

  ### Close

  `tasks close <task> --outcome done --result "<n> workers; stack:
  <the command, or none>; <l> limits"`.
```
