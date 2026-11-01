## Find out why the drive's stack did not start

{{LEAF-AGENT-RULE}}

The drive's stack start failed. Your brief names the start task, as `start task <id>`, and where that start stands in the run's sequence of starts, as `start <n> of 3`. You read why the start failed, wait where another run that holds the stack is the cause, and close with one verdict. The session acts on that verdict alone. You change nothing: you start no stack, take none down, and edit no file. The drive takes down only what it started, and a start that fails takes down what it opened, so a stop run now would take down whatever run holds the stack's name, another run's stack included.

### What to read

- `.ok-planner/bin/tasks dump --type task`: the start task your brief names, its `command`, and its `result`, which holds its exit code and the tail of its output. Read also each earlier `exec` task of this run whose command is the stop line `.ok-planner/bin/review drive-command --role stack-stop` prints, with its state and its result.
- `.ok-planner/bin/stack list`, where the start command calls `.ok-planner/bin/stack`. It prints one line per run the reference stack tool records: its tag, its time, its ports, and its folder, then `name: <name>` where the run holds a name, then `refused: <refusals>` where a removal was refused.
- For a project's own start command, what its output and the project's facts below name: the file that records which run holds a name, the ports and resources the stack needs, and the process or container that holds them.

Read only to find the cause, and run only commands that change nothing.

### The verdicts

Close with the first verdict that holds.

- **`own`**: what holds the stack's name is a stack this run started earlier, and this run's `stack-stop` task for it failed: the ledger holds that failed `exec` task, and nothing started the holder after it. The session runs the stop line again, then starts again. Name the failed `stack-stop` task.
- **`held`**: another live run holds the stack's name or a resource the start needs, such as a port. A live run still has a process running, a container running, or a program holding its ports. Name what holds the name or the resource, and how you tell that it ended. Wait until it ends: check once a minute whether the holder still holds the name or the resource, in Bash calls of at most 9 minutes each, for at most 3 hours in all. Close `held` once the holder lets go, and the session starts again. Where the holder still holds at the end of 3 hours, the verdict is `blocked`: name the holder, how long it held, and the command the owner would run once that holder's run is done.
- **`retry`**: a second start can pass, such as after a dependency that was down for a moment, a timeout, or a port taken between the lease and the start that the start command did not absorb. Wait 60 seconds with `sleep 60` before you close, and the session starts again.
- **`blocked`**: no start can pass in the tree as it stands, such as where a tool is missing, a declaration is malformed, the build fails, a daemon does not run, or a holder still holds at the end of the wait. A holder that nothing still uses, such as the record of a name a crashed run left, is `blocked`, not `held`: waiting cannot free it, and the drive takes down only what it started. Name the command that would free it.

Where your brief says `start 3 of 3`, no start follows yours. Wait for nothing, and close `blocked` whatever you found, with the cause the evidence shows.

### Record a blocked start

On `blocked`, record the cause as a failure at state `environment`, which the owner list files in the intake:

`tasks item add --pool failures --key gate --state environment --fingerprint "stack-start-<the start task>" --field surface=stack --field result=blocked --field start=<the start task> --body "<the start command>; exit <code>; saw: <the lines that name the failure, quoted>; cause: <the cause>; what the owner would change so a later drive gets through: <the change>" --task <task>`

### Rules

- Run only commands that change nothing, plus `sleep`. Never run the stop line, the start line, `stack down`, `stack cleanup`, `stack up`, or a `docker` verb that stops or removes anything. Kill no process.
- Edit nothing, stage nothing, commit nothing. Never run `git checkout`, `restore`, `reset`, `stash`, or `clean`.
- Leave no process of your own running.

### Close

`tasks close <task> --outcome done --result "<held|own|retry|blocked>: <the cause; the evidence, quoted>"`. The verdict is the result's first word.

### This project

[PROJECT]

<!-- Materialized by ok-planner v30.0.0 — suite-owned; overwritten on true-up; do not hand-edit. -->
