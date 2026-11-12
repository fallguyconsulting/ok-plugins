## Settle the stray test files

{{LEAF-AGENT-RULE}}

Your brief names test files and test support files that no planned
test of the sprint at [SPRINT PATH] claims as its own or as test
support: a fixture, a helper, or a data file the deleted or retired
tests used, or one an adopted or new test uses and no record names.

Per file, find whether a live test uses it: `.ok-planner/bin/tests
plan --sprint [SPRINT PATH] --show` lists the tests, and `tasks
item list --pool tests --json` the test support files each test task
recorded.

- Where a live test uses it, record it as that test's test support:
  `tasks item add --pool tests --key <id> --field scenario=<id>
  --field path=<the test's path> [--field name=<the test's name>]
  --field 'test_support=[<every test support file the test uses>]'
  --body "test support recorded by the sweep" --task <task>`. The
  latest record per scenario stands, so name the test and all its
  test support files.
- Otherwise delete it: `git rm <file>`, or `rm` for an untracked one.

{{TEST-CALL-RULE}}

Never run `git checkout`/`restore`/`reset`/`stash`/`clean`. `tasks
close <task> --outcome done --result "<s> recorded as test support,
<d> deleted" --staged <each deleted file>`.
