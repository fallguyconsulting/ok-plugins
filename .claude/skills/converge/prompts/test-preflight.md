## Check that the test stack runs alone with what it needs

{{LEAF-AGENT-RULE}}

You check the test stack of the sprint at [SPRINT PATH]
before the first test task runs. Your brief names the plan's budget:
the number of workers, the command that starts the test stack, the
sizing its configuration gives for that many workers, the
configuration files you may edit, and each deployment-wide limit
with how the suite meets it. You change only the files your task's
files name, and only to the sizing the budget names. You write no
test and no product code.

### Read

1. The budget: `.ok-planner/bin/tests plan --sprint [SPRINT PATH]
   --show`, its "The test stack's budget".
2. Each configuration file the sizing names, whole.
3. How the project starts and stops the test stack:
   `.ok-planner/review/project.md` and the project's stack tool.

### Check

1. Where a file your task names does not give the sizing, edit it
   to the values the budget names, and nothing else.
2. Start the test stack alone, through the project's stack tool,
   with the command the budget names. Stop it on every exit, a
   failed check included.
3. Check each sizing value in the running stack: each service
   starts and stays up with the memory the budget names, and each
   pool and worker count is the one it names.
4. Check each limit's handling: for `raise`, the running stack
   carries the raised value; for `split`, the stack holds enough of
   what the limit counts, such as users, for one share per worker;
   for `lease`, what hands out the lease is in place.
5. **Line timing.** Find two recorded tests of one held group, two
   whose `resources` share a slug, in `.ok-planner/bin/tests
   scenarios --json`; the sprint's planned tests are not written yet.
   Run them: `.ok-planner/bin/tests run --only <the one> <the other>
   --json`, with no `--sprint`, so the run records no round in the
   sprint's results. Check that each line arrived as its test ended,
   in the group's order, on one clock: where both lines carry
   `started` and `ended`, the later test's `started` is at or after
   the earlier test's `ended`; otherwise the later test's `arrived`
   less its `seconds` is at or after the earlier test's `arrived`.
   Where no two recorded tests share a slug, skip this check.
6. **Setup run again.** Where `testing.setup` is a command, run it
   on the running test stack, then run it again, then run one
   recorded test that needs the stack, or any recorded test where
   none needs it: `.ok-planner/bin/tests run --only <the test>`.
   Check that each setup run exits 0 and the test passes, so the
   second setup left the stack ready. Where the scenario list records
   no test, check only that each setup run exits 0.
7. **Resources setup did not create.** Where `testing.setup` is a
   command, start one scratch resource of a kind `testing.leftovers`
   counts, named `preflight-check-<task>`. Run `testing.setup` once,
   and check that it exits 0, that the stack is ready, as the
   recorded test of check 6 shows when it passes again, and that the
   scratch resource still stands. Where the scenario list records no
   test, check only that setup exits 0 and the scratch resource still
   stands. Remove the scratch resource on
   every exit, a failed check included.
8. Stop the test stack, and check that nothing it started stands.

Where a check of the sizing or the limits fails and an edit to your
files within the budget's sizing cannot meet it, close `blocked`,
naming the check and what it showed. Where a check of the suite run,
5 to 7, fails, close `blocked`, naming the check and what it showed:
the fix lies in the suite command or the setup, outside your files. `tests tasks --stage write` files the preflight once more,
and a preflight that closes `blocked` twice is a genuine blocker.

{{TEST-CALL-RULE}}

### Close

Stage every file you changed by name: `git add <file>`. Never run
`git checkout`/`restore`/`reset`/`stash`/`clean`. `tasks close
<task> --outcome done --result "<n> workers: sizing, <l> limits,
and the suite run's checks hold" --staged <file> ...`, or `--outcome blocked --result "<the
check that failed, and what it showed>"`.

<!-- Materialized by ok-planner v31.1.0 — suite-owned; overwritten on true-up; do not hand-edit. -->
