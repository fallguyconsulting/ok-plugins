## Check that the test stack runs alone with what it needs

{{LEAF-AGENT-RULE}}

You check the test stack of the sprint at [SPRINT PATH]
before the first test task runs. Your brief names the plan's budget:
the number of workers, the command that starts the test stack, the
sizing its configuration gives for that many workers, the
configuration files you may edit, and each deployment-wide limit
with how the suite meets it. You change only the files your task's
files name, and only to the sizing the budget names. Beside them,
you write one record outside the committed tree: this machine's
worker count, through `.ok-planner/bin/tests machine`. You write no
test and no product code.

### Read

1. This machine, before you start the test stack, so the containers
   it counts are others': `.ok-planner/bin/tests machine --sprint
   [SPRINT PATH]`. It prints the measurement, the machine's cores,
   its memory, its Docker memory, and the memory each running
   container holds, beside this machine's record: its count, the
   count a run here uses and where that count comes from, and the
   dated history of each change with its reason.
2. The budget: `.ok-planner/bin/tests plan --sprint [SPRINT PATH]
   --show`, its "The test stack's budget".
3. Each configuration file the sizing names, whole.
4. How the project starts and stops the test stack:
   `.ok-planner/review/project.md` and the project's stack tool.

### Check

1. **Workers this machine carries.** Compare the measurement with
   what the budget's sizing needs for the count a run here uses: the
   Docker memory its services take for that many workers, against
   the machine's Docker memory less the memory the running
   containers hold, and the cores and memory its workers load. Keep
   the budget's sizing as it stands: it is every machine's. Where the
   machine carries that count, write nothing. Where it cannot, find
   the largest count that fits, and write it to this machine's
   record: `.ok-planner/bin/tests machine --sprint [SPRINT PATH]
   --workers <n> --reason "<the constraint, such as Docker memory
   below what the sizing needs, or memory other containers hold>"
   --evidence "preflight task <task>: <the measurement>"`. Run every
   later check at that count: each `.ok-planner/bin/tests run` reads
   the record. Where one worker does not fit, write nothing and close
   `blocked`.
2. Where a file your task names does not give the sizing, edit it
   to the values the budget names, and nothing else.
3. Start the test stack alone, through the project's stack tool,
   with the command the budget names. Stop it on every exit, a
   failed check included.
4. Check each sizing value in the running stack: each service
   starts and stays up with the memory the budget names, and each
   pool and worker count is the one it names.
5. Check each limit's handling: for `raise`, the running stack
   carries the raised value; for `split`, the stack holds enough of
   what the limit counts, such as users, for one share per worker of
   the count a run here uses; for `lease`, what hands out the lease
   is in place.
6. **Line timing.** Find two recorded tests that hold one lock name,
   at least one of them `exclusive`, in `.ok-planner/bin/tests
   scenarios --json`; the sprint's planned tests are not written yet.
   A test holds its own `locks` and the locks `test_support_locks`
   records for each test support file it lists, `exclusive` where
   either declares the name so. Run the two: `.ok-planner/bin/tests
   run --only <the one> <the other> --workers 2 --json`, with no
   `--sprint`, so the run records no round in the sprint's results.
   Two workers let the suite command run the two side by side, and it
   must not. The earlier test is the one whose line arrived first.
   Check both halves:
   - **The two did not overlap.** Where both lines carry `started`
     and `ended`, the later test's `started` is at or after the
     earlier test's `ended`.
   - **Each line arrived as its test ended.** On every run, the later
     test's `arrived` less its `seconds` is at or after the earlier
     test's `arrived`, whether or not the lines carry `started` and
     `ended`.

   Where the budget `.ok-planner/bin/tests scenarios --json` records
   names one worker, or none, run the two with no `--workers`, skip
   the overlap half, and name that skip in the close result: the
   tool refuses `--workers 2` above that budget's workers. Where no
   two recorded tests hold one lock name with at least one of them
   `exclusive`, skip this check and name that skip in the close
   result.
7. **Setup run again.** Where `testing.setup` is a command, run it
   on the running test stack, then run it again, then run one
   recorded test that needs the stack, or any recorded test where
   none needs it: `.ok-planner/bin/tests run --only <the test>`.
   Check that each setup run exits 0 and the test passes, so the
   second setup left the stack ready. Where the scenario list records
   no test, check that each setup run exits 0, skip the readiness
   half, which needs a recorded test to pass, and name that skip in
   the close result.
8. **Resources setup did not create.** Where `testing.setup` is a
   command, start one scratch resource of a kind `testing.leftovers`
   counts, named `preflight-check-<task>`. Run `testing.setup` once,
   and check that it exits 0, that the stack is ready, as the
   recorded test of check 7 shows when it passes again, and that the
   scratch resource still stands. Where the scenario list records no
   test, check that setup exits 0 and the scratch resource still
   stands, skip the readiness half, and name that skip in the close
   result. Remove the scratch resource on every exit, a failed check
   included.
9. Stop the test stack, and check that nothing it started stands.

Where the machine cannot carry one worker at the budget's sizing,
close `blocked`, naming the measurement and what the sizing needs.
Where a check of the sizing or the limits fails and an edit to your
files within the budget's sizing cannot meet it, close `blocked`,
naming the check and what it showed. Where a check of the suite run,
6 to 8, fails, close `blocked`, naming the check and what it showed:
the fix lies in the suite command or the setup, outside your files. `tests tasks --stage write` files the preflight once more,
and a preflight that closes `blocked` twice is a genuine blocker.

{{TEST-CALL-RULE}}

### Close

Stage every file you changed by name: `git add <file>`. This
machine's record sits under `.ok-planner/.cache/`, outside the
committed tree: stage it never. Never run
`git checkout`/`restore`/`reset`/`stash`/`clean`. `tasks close
<task> --outcome done --result "<n> workers on this machine (the
budget names <b>; <lowered for the constraint, or from the budget,
or from this machine's record>): sizing, <l> limits, and the suite
run's checks hold<; each check or half you skipped, and why>"
--staged <file> ...`, or `--outcome blocked
--result "<the check that failed, and what it showed>"`. Where the
scenario list records no test, the result names the skip of checks
7 and 8 in one line beside the counts: `readiness half skipped: the
scenario list records no test`.
