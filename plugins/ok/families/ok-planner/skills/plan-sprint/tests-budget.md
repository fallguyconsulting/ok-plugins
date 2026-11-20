# Test planning: budget

The block sprint execution's test planning procedure, in `tests.md`, uses for the budget task's prompt. `{{TOKEN}}` names a block to use verbatim, from `tests.md` in this folder, `skills/_sprint/shared.md`, or `skills/_shared/dispatch-discipline.md`, and resolves only where the token stands alone on its line. `[...]` inside a block is a value the session fills before it registers the prompt; `[SPRINT PATH]` is the sprint whose tests the run plans.

---

### {{TEST-BUDGET-PROMPT}}

The task prompt for the budget, one task, after the sort, on a plan whose tests or stack change the budget: a planned `new` or `rewrite` that needs the stack, a lock name a planned test declares that no recorded test declares, or a work item that changes a file the recorded budget's `files` names. `/ok-setup` runs it too, when it turns testing on. `[SPRINT PATH]` is the sprint whose tests the run plans, or `none` where `/ok-setup` runs it.

```
Task prompt (profile ok-opus):
  ## Budget the test stack

  {{LEAF-AGENT-RULE}}

  You budget the test stack the project's suite spends as one
  resource, for the sprint at [SPRINT PATH]: every test its plan
  keeps, writes, or adopts. Where the sprint path is `none`,
  `/ok-setup` runs you, no sprint plans tests, and you budget the
  tests the scenario list records. You write no file in the project,
  and one record outside the committed tree where this machine needs
  it: this machine's worker count, through `.ok-planner/bin/tests
  machine`. You record the budget as items, and the session assembles
  it into the plan, or `/ok-setup` records it. The preflight before the
  sprint's first test task checks your budget against the running
  stack, and the plan-wide review checks it before the plan's last
  assembly.

  A test holds `locks`, each a name from the scenario list's lock list
  held `exclusive` or `shared`, its own and those of each test support
  file it lists. Two tests run at the same time unless they hold one
  name and at least one of them holds it `exclusive`. An isolated test
  holds no lock, and isolated tests run side by side on the one test
  stack. A run uses the budget's workers, or this machine's lower
  count where its record names one, and never more than the
  budget's.

  ### Read

  1. The planned tests: `tasks item list --pool scenarios --json`, and
     the tests the scenario list records: `.ok-planner/bin/tests
     scenarios --json`, and the budget it records. A story this
     sprint does not plan keeps its recorded scenarios, which are not
     items in the run. Note each test's kind, its setup, and its
     locks.
  2. The last run of the suite, where your brief names one: each
     test's seconds, setup and teardown included.
  3. The runner, in `.ok-planner/config.json`: `testing.run`, the
     project's suite command, which runs a list of tests with the
     number of workers the list names.
  4. Where the sprint path is not `none`, the sprint's Work items and
     its Implementation notes, for each change they make to the test
     stack or to a file the recorded budget names.
  5. The test stack: how the project starts it, from
     `.ok-planner/review/project.md` and the project's stack tool, and
     each configuration file that sizes it: its services' memory, its
     connection pools, its worker counts, and its deployment-wide
     limits, such as one sign-in per user or a cap on fleet members.
  6. This machine: `.ok-planner/bin/tests machine`, which writes
     nothing and prints the measurement, the machine's cores, its
     memory, its Docker memory, and the memory each running container
     holds, beside this machine's record: its count, the count a run
     here uses, and the dated history of each change with its reason.

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
  - Size the budget's workers for the suite, never for one machine:
    the budget's workers are the count every machine starts from.
    Where this machine cannot carry them, as the measurement shows,
    such as Docker memory below what the sizing needs or memory other
    containers hold, you may write a lowered count for this machine,
    up to the scenario list's budget, the bound `tests machine` reads
    with no sprint. Where the count you propose is larger than that
    bound and this machine cannot carry it, write nothing, and record
    on the budget item the count this machine carries, with its
    reason and its evidence, as Record says: where `/ok-setup` runs
    you, it writes this machine's count once the budget stands, and
    in a sprint the preflight writes it once the plan stands.

  {{TEST-REVISION-RULE}}

  ### Record

  You record the budget, its limits, and your calls, and nothing per
  scenario: no lock list for a scenario and no keep entry for the
  session to carry. A lock change comes from a test writer or a flaky
  fixer.

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

  This machine's count, where you lower it: `.ok-planner/bin/tests
  machine --workers <n> --reason "<the constraint>" --evidence
  "budget task <task>: <the measurement>"`. Name the count and its
  reason in the budget item's body.

  This machine's count, where the bound leaves you to write nothing:
  add to the budget item `--field machine_workers=<n> --field
  machine_reason="<the constraint>" --field
  machine_evidence="budget task <task>: <the measurement>"`, and
  name the count and its reason in the budget item's body.

  {{TEST-CALL-RULE}}

  ### Close

  `tasks close <task> --outcome done --result "<n> workers; stack:
  <the command, or none>; <l> limits"`.
```
