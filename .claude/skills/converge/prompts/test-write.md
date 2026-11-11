## Write, rewrite, or retire one scenario's test

{{LEAF-AGENT-RULE}}

You work one scenario of the sprint at [SPRINT PATH]. Your
brief names the scenario, its action, the outcome it checks, its
source, its test's path and name, its support files, how the test
reaches the code, and any owner ruling. You change only the files
your task's files name: your test file, for a rewrite at a new path
its old test file, and for a test the verifier or the speed reviewer
sent back its scenario's support files. A support task wrote each
support file before you ran: read them, and change a support file
only where your task's files name it. You change no product code.

{{TEST-SCENARIO-DEFINITION}}

{{TEST-SILENCE-RULE}}

### Read

1. The scenario's story at `.ok-planner/design/stories/<slug>.md`,
   or for a runtime scenario the accept-list entry it names.
2. The code the brief's reach names: the public entry point, and
   the path it takes, enough to call it as a user does.
3. `testing` in `.ok-planner/config.json`: `run`, the project's
   suite command, which runs every test in one run and reports each
   by the path and name your record names, and `named`, whether it
   runs a test by its name inside its file; your test must suit them.
   Also `setup`: the project holds a seed only where `setup` is a
   command that builds one, and holds none where `setup` is `null`.
4. For a rewrite, a retirement, or a test the verifier or the speed
   reviewer sent back, the test as it stands.
5. Each support file your brief names, whole.
6. The testing standard at `.ok-planner/docs/testing.md`.
7. The `## Stand-ins for outside parties` section of
   `.ok-planner/review/project.md`.

### Write

- Where your brief says the verifier or the speed reviewer sent the
  test back, rewrite the test as it stands to answer its reason,
  whatever action the brief names, and record it as a rewrite. A
  speed reviewer's reason names a waste and the cheaper form that
  proves the same outcome: write that form. Where the reason's cause
  lies in a support file your task's files name, change the support
  file to remove the cause. Keep every helper another live test uses
  working as it works now: `tasks item list --pool tests --json`
  lists the support each test task recorded.
- Check the scenario's outcome, and nothing else. Reach the code
  through its public entry point: the command, the route, the
  exported function. Mock nothing the scenario checks.
- Cause a runtime condition from outside the product, as the reach
  says. Change no product code to make a condition possible: use
  the time control the scenario's waits names, which a code stage of
  the sprint built before you ran, or which the product already had.
- Where the scenario's outcome passes through a party outside the
  product, reach that party through the stand-in
  `.ok-planner/review/project.md` names under `## Stand-ins for
  outside parties`, on the stack the test opens; never the real
  party, and no step a person performs.
- Make the test's verdict wait only on what the scenario's waits
  names: the event, the time control, or the clock the test moves.
  Write no sleep, and no poll under a deadline. Spend the test's
  time on nothing the testing standard names a waste.
- Keep the test printing progress as the silence rule below says.
- Set up in a folder `mktemp -d` makes, or on a stack run the
  project's stack tool opens, and tear it down on every exit. Write
  nothing into the project's tree when the test runs.
- Write no comment: the lint's comment rule covers test files too.
- Use the support your support files hold. Where your test needs
  support that a support file your task's files do not name lacks,
  record one item per change in the `support` pool: `tasks item add
  --pool support --key <support path> --field path=<support path>
  --field scenario=<id> --field change=<missing | changed | fixture
  | seed> --body "<the change and what it must do>" --task <task>`.
  Give the item the one change that fits it:
  - `missing`: a helper the file lacks.
  - `changed`: a helper the file holds that must work differently.
  - `fixture`: test data the file must hold.
  - `seed`, only where the project holds a seed that `testing.setup`
    builds: an entry in the project's seed, read-only data your test
    reads and never changes. The body names the entry and each
    object it must hold. Where the project holds no seed, name no
    seed: read-only data your test needs goes in as a `fixture`, or
    into the test's own setup.

  Then write no test, and close `blocked`: `tasks close <task>
  --outcome blocked --result "<id>: <n> support items recorded"`. The
  next write stage files a support task that makes each change, and
  files your task again after it.
- For a retirement, delete the test and nothing else: the sweep
  deletes each support file no live test uses. For a rewrite at a
  new path, delete the old test the same way.

Run the test once: `.ok-planner/bin/tests run --sprint [SPRINT PATH]
--only <id>` runs it and records a rerun round, once your
record below names it. Where it fails because the code never did
what the scenario says, and never supported it, the scenario is a
gap: delete the test, and record the gap. Where it fails because the
code broke what it once did, keep the test: the run's fixers fix the
code.

### Record

`tasks item add --pool tests --key <id> --field scenario=<id> --field
path=<test path> [--field name=<test name>] --field 'support=["<path>",
...]' --body "<what the test does, in one line>" --task <task>`. List
in `support` every support file your test uses, and, where the
project holds a seed, each seed file your test reads.

Your record may change the scenario's declarations and its plan
text. It never changes the scenario's outcome.

- **Declarations.** Where your test changes or reads a different set
  of shared resources than your brief declares, add `--field
  'resources=["<each one it changes>", ...]'` and `--field
  'reads=["<each one it reads and does not change>", ...]'`, `[]` for
  none: an isolated test records `[]` for both, and the suite
  command then runs it beside the others. Add a declaration only
  where no cheaper design keeps the test isolated: a clock the test
  injects, a broker or a record of its own, or data of its own. The
  verifier judges each change, and each declaration you add reaches
  the owner as a call.
- **Plan text.** Where your test reaches the code, enters it, waits,
  or sets up other than as your brief says, add `--field
  reach="<how the test reaches the code>"`, `--field
  entry="<the public entry point>"`, `--field waits="<event: ... |
  control: ... | clock: ...>"`, `--field kind=<the test's kind>`, or
  `--field setup="<what the test sets up>"`, one per field that
  changed. Each replaces the plan's.
- **The outcome.** Write the test to the outcome your brief states.
  Where you find the outcome itself must change, such as where the
  story or the sent-back reason asks for a different one, write the
  test to the outcome as it stands and record a promise too:
  `tasks item add --pool promises --key <id> --field scenario=<id>
  --field 'artifacts=["<kind:slug>", ...]' --body "<the outcome the
  test checks, the outcome you find it must check, and the
  commitment that decides between them>" --task <task>`. Its
  verifier holds the promise or rejects it.

Where your test has no choice but a longer silence, add `--field
silence=<seconds>`, as the silence rule says. For a retirement:
`--field scenario=<id> --field retired=true`. For a gap: `--field
scenario=<id> --field gap=true --body "<why no code supports it>"`.

{{TEST-CALL-RULE}}

### Close

Stage every file you changed by name: `git add <file>`, or `git rm
<file>` for a deletion. Never run `git checkout`/`restore`/`reset`/
`stash`/`clean`. `tasks close <task> --outcome done --result "<id>:
<written | rewritten | retired | gap>[, promise recorded]" --staged
<file> ...`.

<!-- Materialized by ok-planner v31.0.0 — suite-owned; overwritten on true-up; do not hand-edit. -->
