## Write one test support file

{{LEAF-AGENT-RULE}}

You write one test support file of the sprint at [SPRINT PATH]:
the one file your task's files name. Your brief names the scenarios
whose tests use it, each with the outcome it checks, its test, and
how the test reaches the code. Where a test task found its test
support short, your brief names each `test-support` item it recorded
instead, with the change it needs. Every test task of this pass runs
after every test support task of the pass: each reads this file and
changes none of it. You write no test and no product code.

### Read

1. Each scenario in your brief, and its story at
   `.ok-planner/design/stories/<slug>.md`, or for a runtime scenario
   the accept-list entry it names.
2. The code each scenario's reach names: the public entry point, and
   the path it takes, enough to call it as a user does.
3. `testing` in `.ok-planner/config.json`: `run`, the project's
   suite command, which runs every test in one run, and `named`,
   whether it runs a test by its name inside its file; every helper
   must suit them. Also `setup`: the project holds a seed only where
   `setup` is a command that builds one, and holds none where `setup`
   is `null`.
4. The file as it stands, and each live test that uses it:
   `.ok-planner/bin/tests plan --sprint [SPRINT PATH] --show`
   lists the tests, and `tasks item list --pool tests --json` the
   test support files each test task recorded.

### Write

- Write every helper the tests in your brief need to reach the code
  through its public entry point: the command, the route, the
  exported function.
- Write every helper they need to set up in a folder `mktemp -d`
  makes, or on a stack run the project's stack tool opens, and to
  tear it down on every exit. A helper writes nothing into the
  project's tree when a test runs.
- Keep every helper a live test already uses working for that test.
- Write no test, no product code, and no comment: the lint's comment
  rule covers test support files too.
- Per `test-support` item your brief names, make the change its
  `change` names, then mark it: `tasks item set <item> --state made`.
  - `missing`: add the helper the item asks for.
  - `changed`: change the helper as the item asks. Where a live test
    that uses the helper needs it as it works now, add the changed
    form as a helper of its own and keep the old one.
  - `fixture`: add the test data the item asks for, or change it as
    the item asks, keeping the data each live test that reads the
    file uses.
  - `seed`: add the seed entry, as the next bullet says, where the
    project holds a seed that `testing.setup` builds. Where it holds
    none, which your brief marks as a fixture, add the data the item
    asks for as a fixture in this file, keeping the data each live
    test that reads the file uses.
- Per `test-support` item your brief names whose `change` is `seed`,
  where the project holds a seed, add the seed entry it names to the
  project's seed, in the form the seed's other entries take. The
  entry holds each object the item asks for, and names the
  stored-data layout files it depends on, so `testing.setup` builds
  it where it is missing or stale and reuses it otherwise. Give each
  object the entry holds a name only the seed uses. Make the test
  support code refuse to change or remove a seeded object, with a
  message that names the object and says the test builds its own
  copy of data it changes. Once the entry stands, mark the item:
  `tasks item set <item> --state made`.

{{TEST-CALL-RULE}}

### Close

Stage your file by name: `git add <file>`. Never run `git checkout`/
`restore`/`reset`/`stash`/`clean`. `tasks close <task> --outcome
done --result "<file>: <n> helpers written, <m> test support items
made" --staged <file>`.
