# Testing: the standard

This standard governs how a test spends its time. A sprint's test
planners plan by it, its test tasks write by it, and sprint
certification's fixers fix by it. The planning reviewer, the test
verifier, and the speed reviewer read each test against it. No lint
checks it.

## The principle

A test spends time only on proving its outcome. Every second a test
spends goes to the work that shows the outcome holds, and to nothing
else.

## What a test waits on

A test's verdict never waits on elapsed time. A test waits on one of
these:

- an event the product emits: an event, a state it leaves behind, or
  a reply it gives to a call;
- a time control that forces the event: one that makes the event
  happen now, sets the time the product sees, or sets how long the
  product waits;
- a clock the test moves: a clock the test injects into the product
  and moves forward.

A test never sleeps, and never polls under a deadline.

The product takes its clock from outside and emits the events a test
waits on. Coding rule 11, "Give every timer a time control", in
`.claude/rules/plumbline-coding.md` says what a timer's time control
is.

## The named wastes

Each of these is a waste:

- A costlier reach than the outcome needs. An outcome inside one
  service is tested through that service's own entry point, its
  command, its route, or its exported function, with its clock
  injected. An outcome that crosses services is tested on the shared
  test stack. Only an outcome about bringing up a deployment brings
  one up. A cheaper reach drops the services the outcome does not
  cross, and fakes none it checks.
- Setup a test repeats that it could share safely, such as a sign-in
  or a stack per test, or, where the project has a seed
  `testing.setup` builds, data the test only reads that the seed could
  hold.
- A shared resource declared where a cheaper design keeps the test
  isolated.
- Work the outcome does not need, such as extra devices, records, or
  steps.

## The schedule

A test is isolated by default: it touches only state it created and
named. Isolated tests run in parallel, and those that need the stack
share one test stack. A test that must change shared state declares
each shared resource it changes, such as the stack's message broker or
its clock, in `resources`. A test declares each shared resource it
reads and does not change in `reads`. A scenario that declares a
resource it changes and no `reads` counts as reading every shared
resource. An isolated scenario declares no resource and reads no
shared resource, so its test takes no lock. The planners write both
declarations, and the planning reviewer sends back a declaration a
cheaper design avoids, such as a clock the test could inject or a
broker of its own.

The standard recommends one schedule: two tests may run at the same
time unless one changes a resource the other changes or reads. Tests
that share a changed resource form one group, which runs its tests one
after another on one worker. The run uses at most the budget's
workers.

A project records the schedule its suite command runs in
`testing.schedule`, a required key with no default in code. The key
holds the schedule's form and the owner's words for it. The tests tool
knows three forms:

- `recommended`: the schedule above.
- `groups-side-by-side`: held groups run at the same time as each
  other, after the isolated tests.
- `groups-one-at-a-time`: held groups run one after another, after the
  isolated tests.

A project whose suite command cannot follow the recommendation records
the form it runs instead. A departure is a competing practice, never
an exemption: the recorded form names what the project does, and the
schedule check holds the project to it.

After each round, the tests tool checks every pair of tests that ran
at the same time against the recorded schedule. It takes a test's
start as the arrival of its result line less its seconds. A forbidden
pair fails the round, and a fixer of the suite command takes it up.
While the key holds no words from the owner, the tests tool skips the
schedule check, because a guessed form must fail no round.

Before the suite command starts, each run of the tests tool locks each
shared resource its tests declare: an exclusive lock for a resource a
test changes, and a shared lock for one a test only reads. The run
holds its locks until it ends. A whole-suite round locks every
resource its tests declare, and a run of isolated tests takes no lock.
A run that needs a lock another run holds waits for it, and prints one
line naming that run and the resource it waits on.

## What a test reaches

Each result line the suite command writes may carry `reaches`: the
product files the test ran, from a per-test coverage record, or, for a
stack test, the folders of the services it reached. A folder covers
every file under it. The tests tool keeps each test's latest
`reaches`, and every run of the test replaces it. The first
whole-suite run builds the map, and the scenario list keeps it across
sprints.

After a fix, the verifier reruns each test whose `reaches` names a
file the fix changed or a folder above one. It sends back a fix that
fails a test that passed before it. No record means rerun: a test with
no `reaches` reruns after every fix. A changed file no test's
`reaches` names, such as a configuration file, a template, a
migration, or a lockfile, reruns every test.

A project records what its suite command writes in `testing.reaches`,
a required key with no default in code. The key holds the form,
`files`, `folders`, or `none`, and the owner's words for it. The rerun
rules above hold where the form is `files` or `folders`. Under `none`,
the verifier reruns only the tests the fix was for, and the final
whole-suite round catches the rest. While the key holds no words from
the owner, the tests tool uses the form the key names.

## The seed

The standard recommends a seed and requires none. A seed is read-only
test data that slow tests read, declared as a list of entries. A
project may have no seed. Each entry's digest covers its own
definition and the stored-data layout files the seed names, so a
product code change never makes an entry stale. The setup step,
`testing.setup`, builds each entry that is missing or stale and reuses
the rest.

Each seeded object carries a name only the seed uses, and the test
support refuses to change or remove one. A test that changes its data
builds its own copy. Where the project has a seed its setup step
builds, a test task that needs seeded data records a support item
naming the entry, a support task adds the entry and lists it as
support on each test that reads it, and a speed reviewer may name a
seed entry as the cheaper form, with the objects the entry must hold.
Where it has none, no reader, writer, or support task names a seed,
and a test builds or reads its own data, such as a fixture.

## A slow product

A speed reviewer may find a test slow because the product is slow. It
then records a product-slow verdict. The verdict names the site as
`path::function`, what the site does, how its cost grows, and the
cheaper behavior. Where the test also wastes time of its own, the
reviewer records the verdict whose fix saves more seconds.

The fix loop files a fixer for the site, keyed `perf:`, and a
verifier, as for a failing test. The fixer runs the test and notes its
seconds, changes the product so the site does only the work its answer
uses, and runs every test that reaches the site. The verifier sends
back a fix that leaves the slow work, drops a promised outcome, or
fails a test that reaches the site. A product-slow verdict is never a
speed acceptance: it settles once its fix is accepted, and the test
then gets a fresh speed read.

## A flaky test and a test at fault

Each failing test runs alone before a fixer is filed for it. A failure
files the fixer. A pass counts as fixed only where a change since the
test's failing round reached the test. Where `testing.reaches` names
`files` or `folders`, a change reaches each test the verifier's rerun
rule reruns after that change. Under `none`, a pass counts as fixed
where any fix landed since the failing round. A pass with no reaching
change goes to the flaky route.

A flaky test is broken until its cause is found, and no fixer records
it as passing as the tree stands. Its fixer reads the round's window
and the tests that failed with it, reads the test stack's logs for
that window, and reproduces the failure at the round's worker count.
It then routes the cause:

- The product fails under load: a product fix.
- Tests share state or timing: a missing `resources` or `reads`
  declaration, or the test-at-fault route below.
- A test leaves something behind: a count the project's leftover
  command prints.

A fixer starts from the test being right and follows the evidence. A
fix never changes a test, a support file, or a fixture. A fixer who
finds the test, its support, its fixture, or its data at fault changes
nothing and records the fault, naming every other test that shares
it. The verifier runs the test and reads the product path. Where the
product is right, the verifier accepts the record, and certification
files a test task to rewrite each named test. A promise the verifier
rejects because the test is at fault takes the same route, so no fixer
is filed for it again. A fixer records a promise only where the
commitment itself stands in the way. A test at fault that the test
verifier finds while the test is written goes back to its test task.

## Silence

A test is never silent for long. `tests run` stops a run after
`testing.silence` seconds with no result line and no output, and the
project keeps that setting as small as it can. Each test, and each
tool under the project's control that a test runs, prints a line of
progress as it works, so long silences are rare. Coding rule 15,
"Print progress from every long-running command", in
`.claude/rules/plumbline-coding.md` says which commands print
progress. `testing.setup` gets the test environment ready before the
silence clock starts, so no test waits out a stack's start.

A test with no choice but a longer stretch of silence, such as one
that waits on a program the project does not control and that prints
nothing, records a silence of its own, as small as its wait needs.
The run waits that long only while that test has no result. The
project never raises `testing.silence` for every test to fit its
slowest or longest-waiting test. The verifier and the speed reviewer
send back a test's own silence that a progress line or a cheaper
design would remove.

## When speed is read

A reader reads a test for the named wastes at three points:

- At write time. The test verifier reads each new or rewritten test.
  Its brief gives the test's seconds from its test task's own run, the
  budget's workers, and the resources the test changes and reads.
- In the build stages. Under `testing.enabled` `on`, a speed task
  reads the `testing.slowest` slowest tests of the last whole-suite
  run that hold no speed acceptance at their current test file. Their
  rewrites land before sprint certification starts.
- After a failed whole-suite round. Before the next round runs, a
  speed task reads the `testing.slowest` slowest tests of the failed
  round that hold no speed acceptance at their current test file.
  Their rewrites run in the round that must run anyway.

Each round records each test's seconds, setup and teardown included.
The ranking orders the tests by each test's median seconds across the
whole-suite rounds that ran it at its current test file's digest, so
machine load in one round moves it little. The ranking charges each
test by the schedule `testing.schedule` records. The tests tool takes
a lower bound on a round's wall time under that schedule, and a test's
cost is how much the bound drops when the test's seconds drop to zero:

- Under `recommended`, the bound is the larger of the longest group's
  total seconds and all tests' total seconds over the workers.
- Under `groups-side-by-side`, the bound is the isolated tests'
  seconds over the workers plus the larger of the longest group's
  total seconds and all held tests' seconds over the workers.
- Under `groups-one-at-a-time`, the bound is the isolated tests'
  seconds over the workers plus every group's seconds.

No rule puts held tests first: the ranking charges each test for what
it costs.

A speed acceptance records that a reader found no waste in a test. It
holds across sprints until the test's own file changes, and a change
to a support file the test lists does not clear it. An accepted test
counts as unreviewed again only where a support file it lists changed
since its acceptance and its median seconds rose.

A send-back settles when the verifier accepts the rewrite. A speed
rewrite that fails returns to its last passing version, and its
send-back stays open for the next sprint to take up. A passing
whole-suite round ends a sprint's speed work, and its seconds feed the
next sprint's ranking.

The standard names no speed floor. The ranking chooses which tests a
reader reads, and the reader judges the waste. No time budget decides
a verdict.

## Who reads for the wastes

The planning reviewer reads each planned test for each named waste.
The test verifier reads each written test for each named waste, for a
verdict that waits on elapsed time, and for a silence of its own that
a progress line or a cheaper design would remove. It sends back a test
that has any of them. The speed reviewer reads the tests the ranking
names for each named waste, and sends back a test whose time goes to
one, naming the cheaper form. Where the product makes the test slow,
the speed reviewer records a product-slow verdict instead. No count of
send-backs makes a reader accept: a test goes back as often as a
rewrite leaves a named waste.

<!-- Materialized by ok-planner v31.0.0 — suite-owned; overwritten on true-up; do not hand-edit. -->
