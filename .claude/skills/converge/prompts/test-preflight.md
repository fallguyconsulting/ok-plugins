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
5. Stop the test stack, and check that nothing it started stands.

Where a check fails and an edit to your files within the budget's
sizing cannot meet it, close `blocked`, naming the check and what it
showed. `tests tasks --stage write` files the preflight once more,
and a preflight that closes `blocked` twice is a genuine blocker.

{{TEST-CALL-RULE}}

### Close

Stage every file you changed by name: `git add <file>`. Never run
`git checkout`/`restore`/`reset`/`stash`/`clean`. `tasks close
<task> --outcome done --result "<n> workers: sizing and <l> limits
hold" --staged <file> ...`, or `--outcome blocked --result "<the
check that failed, and what it showed>"`.

<!-- Materialized by ok-planner v31.0.0 — suite-owned; overwritten on true-up; do not hand-edit. -->
