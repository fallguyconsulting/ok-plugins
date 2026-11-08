## Port and delete the legacy tests of one file

{{LEAF-AGENT-RULE}}

You work one legacy test file of the sprint at [SPRINT PATH]
. Your brief names the file, each test in it to delete with its
reason, each test to port with the rule it enforces, written or
inferred, and the check it becomes, and each test to keep as
written. You change only the files your task's files name.

### Work

1. Read the file whole, and `.ok-planner/bin/tests plan --sprint
   [SPRINT PATH] --show`, for the entries that name it.
2. Per port: write the check at the path the brief names, outside
   every test path, as a program that takes the changed files' paths
   as arguments and exits nonzero, naming the file and the rule, on
   each breach. Make it check what the test checked. Run it over
   every file it applies to in the tree: it must pass on the tree as
   it stands, as the test did. The check's command and its program
   start no test runner: `tests ports` refuses a command that does,
   and `review checks` refuses it on every review. Then delete the
   test.
3. Per deletion: delete the test. Where nothing the brief keeps
   remains in the file, delete the file.
4. Leave every test the brief keeps exactly as written, and keep
   what it needs from the file, such as its imports.

Write no comment. The lint's comment rule covers checks and test
files too.

### Record

Per port: `tasks item add --pool ports --key <file> --field
test=<file>[::<name>] --field rule=<the rule your brief names, or
inferred> [--field inferred="<the inferred rule, as your brief
states it>", where your brief names an inferred rule] --field
command="<the command review checks runs, such as python3
checks/<rule>>" --body "<what the check enforces>" --task <task>`.
Only the latest legacy task of a file counts, so a task filed again
records every port of its brief again.

Per deletion and per port, also record one call, so the completion
report's `## Calls` lists it for the owner's veto: `tasks item add
--pool calls --key <file> --field site=<file>::<name> --field
kind=mechanics --field choice="<deleted: the reason your brief
gives | ported: the command review checks runs>" --body "<the test,
what it checked, and why your brief sorts it so>" --task <task>`. A
task filed again for the same file records a call only for a
deletion or a port that no call `tasks item list --pool calls --key
<file>` prints already names.

{{TEST-CALL-RULE}}

### Close

Stage every file you changed by name: `git add <file>`, or `git rm
<file>`. Never run `git checkout`/`restore`/`reset`/`stash`/`clean`.
`tasks close <task> --outcome done --result "<file>: <p> ported, <d>
deleted" --staged <file> ...`.
