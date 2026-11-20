# Testing: the standard

This standard governs how a test spends its time. `/plan-sprint` sets
a sprint's test scope, and the test planners sprint execution runs
ahead of the build plan each test inside it by this standard. Its
test tasks write by it, and sprint certification's fixers fix by it. The planning reviewer, the test
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
- A lock held where a cheaper design keeps the test isolated.
- Work the outcome does not need, such as extra devices, records, or
  steps.

## Locks

A test is isolated by default: it touches only state it created and
named, and it may run beside any other test. Isolated tests run in
parallel, and those that need the stack share one test stack. A test
that sets up, checks, or changes a shared thing, such as a notice the
whole deployment shows or the stack's clock, declares `locks`. Each
lock is a name and a mode, `exclusive` or `shared`. A test holds a
lock `exclusive` on a shared thing it sets up or checks, and `shared`
on one it only changes without caring what other tests do to it. Two
tests may run at the same time unless they hold one name and at least
one of them holds it `exclusive`. So the tests that raise a
deployment-wide notice hold its lock `shared` and run side by side,
and the tests that watch the notice hold it `exclusive` and run apart
from them.

A test support file declares locks too. Each test that lists the file
as its test support takes the file's locks. Where a test and its test
support declare one name, the test holds it `exclusive` where either
declares it `exclusive`.

The scenario list holds the lock list: each lock name, with one line
saying what shared thing it guards. `tests locks` prints the list, and
the tests tool refuses a name the list lacks wherever it reads a
declaration. An agent that needs a lock reads the list first, and adds
a name with `tests locks add` only where no name on it fits. A name
names the shared thing in the product's own words, at the narrowest
scope at which two tests can both see it: `resource-change-notice`,
not the service `formation-graph` or the action `formation-apply`.
State only one test can see, such as an account or a device the test
created, needs no lock. `tests locks remove` takes a name off the list
only while no test and no test support file declares it.

The test writer declares the locks its own test code shows: the shared
things the test sets up or checks, and the locks its test support
declares. A test support task declares the locks its file's code
shows. A planner plans before any test code exists, so it declares no
lock of its own, and a re-plan carries the locks a writer or a fixer
recorded for the scenario. The flaky fixer adds a lock where a round's
window shows the test that disturbed a failing test, as "A flaky test
and a test at fault" says. True-up's one conversion of the earlier
form supplies the rest: each shared resource a test declared it
changes becomes that name held `exclusive`, and each one it declared
it only reads is dropped. No one searches the other tests for one
that might disturb a test. Each lock a writer or a fixer adds reaches
the completion report as a call.

The planning reviewer checks that a re-plan carries the recorded
locks, and sends back a lock a cheaper design avoids, such as a clock
the test could inject or a broker of its own. The test verifier checks
only the locks the test's own code shows.

## The run's locks

Before setup and the suite command start, each run of the tests tool
takes each lock name its tests declare, in name order, and holds it
until the run ends. It takes a name `exclusive` where one of its tests
holds the name `exclusive`, and `shared` otherwise. A whole-suite
round takes every name its tests declare, and a run of isolated tests
takes none. A run that needs a lock another run holds waits for it,
and prints one line naming that run and the lock it waits on.

## Order

Each run of the tests tool draws an order seed. It gives each test a
key from the order seed and the test's scenario id, lists the tests
for the suite command in key order, and records the order seed in the
round's header as `seed`. A race between two tests shows only in an
order that exposes it, so a new order each round makes the race fail
over time. `tests run --seed <n>` gives each test the key that order
seed gives it, so a run over any subset of a round's tests, such as a
failing test and its window, keeps their order in that round. The
suite command starts the tests in the listed order, and starts each
one only once it holds the test's locks.

## The lock check

After each round, the tests tool checks every pair of tests that ran
at the same time against their locks. A pair that held one name, at
least one of the two `exclusive`, is a lock breach, and fails the
round. A result line may carry `started` and `ended`, the test's
start and end in seconds on the suite command's own clock. Where both
lines of a pair carry both, the tests tool compares the two tests on
that clock. Otherwise it takes each test's start as the arrival of
its result line less its seconds, and its end as that arrival, so no
pair mixes two clocks. Write `started` and `ended` wherever the runner
reports them: a runner that writes a file's lines together as the file
ends fails the check by arrival where every test passed. A test
support task fixes how the suite command starts the tests. The check
runs on every round, with no gate on the owner's words.

## Starting state

Each test sets up the starting state it needs, and relies on no
earlier test to leave the system clean. Tests run in a new order every
round, so a test that relies on an earlier one passes in one order and
fails in the next. A test that sets up shared state holds that state's
lock `exclusive`, so no other test that holds the lock changes the
state between the setup and the check.

A test removes in its teardown each record it creates, through the
product's removal action, on every exit, a failing one included. The
product's removal action is the public action a user has to remove
that kind of record: a command, a route, or an exported function. A
test never deletes a record from the store behind the product.

A test that checks a shared outcome either resets the outcome in its
setup under its `exclusive` lock, or reads the outcome's state before
its action and checks for a new instance after it. Either way, the
check passes only on what the test caused.

## Workers on each machine

The budget's workers are the count every machine starts from. A
record at `.ok-planner/.cache/tests-machine.json`, outside the
committed tree, holds this machine's measured resources (its cores,
its memory, its Docker memory, and the memory other containers hold),
its worker count, and a dated history of each change with its reason
and its evidence. `tests machine` measures the machine and prints the
record. Where the record holds a count, `tests run` runs that count,
never above the budget's workers. `tests run --workers <n>` runs the
count it names, never above the budget's workers, so a fixer
reproduces a round at the count it ran. The round's header records
the count and where it came from.

The preflight, the budget planner, and the flaky fixer lower this
machine's count with `tests machine --workers`, naming the constraint
and the evidence: a measurement, a preflight's refusal, or a failed
round. The preflight closes `blocked` only where one worker does not
fit. A machine's record changes no other machine's count.

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
builds, a test task that needs seeded data records a test support
item naming the entry, a test support task adds the entry and lists
it as test support on each test that reads it, and a speed reviewer
may name a seed entry as the cheaper form, with the objects the entry
must hold. Where it has none, no reader, writer, or test support task
names a seed,
and a test builds or reads its own data, such as a fixture.

## A slow product

A speed reviewer may find a test slow because the product is slow. It
then records a product-slow verdict. The verdict names the site as
`path::function`, what the site does, how its cost grows, and the
cheaper behavior. Where the test also wastes time of its own, the
reviewer records the verdict whose fix saves more seconds.

A product fix changes the product, so a whole-suite round must run
after it. Sprint certification applies a product-slow fix only where
another whole-suite round runs anyway: beside another failure of the
latest whole-suite round, which reopens the fix loop. There the fix
loop files a fixer for the site, keyed `perf:`, and a verifier, as for
a failing test. A product-slow verdict alone reopens no loop. Once a
whole-suite round passes with nothing else left to fix, each
product-slow verdict still standing goes to the intake as a judgment
issue for the next sprint, which runs the whole suite anyway.

The fixer runs the test and notes its
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

A flaky test still has a cause, such as another test, load, or a
leak, and no fixer records it as passing as the tree stands. Its fixer
reads `tests window` for the test and its round: the tests whose run
overlapped it and the tests that ran before it, each marked where it
declares a lock name the failing test holds. The fixer also reads the
tests that failed with it and the test stack's logs for that window.
It reproduces the failure by running the test and its window at the
round's order seed and worker count. It then routes the cause:

- A test in the window disturbed it, a race: the fixer adds the lock
  to both tests or to their test support, with the round, the window
  line, and the log lines as its evidence. Where no name on the lock
  list fits, it adds one first.
- The machine was overloaded: the fixer lowers this machine's worker
  count, with the round as its evidence, and adds no lock.
- The product fails under load: a product fix.
- A test leaves something behind: a count the project's leftover
  command prints.
- The test or its test support is at fault: the test-at-fault route
  below.

Where the fixer finds none of these, it records that it found none,
and adds no lock. The next whole-suite round runs the test again. Once
a later whole-suite round passes, certification may close with that
cause unfound.

A fixer starts from the test being right and follows the evidence. A
fix never changes a test, a test support file, or a fixture. A fixer
who finds the test, its test support, its fixture, or its data at
fault changes
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
  budget's workers, and the locks the test holds.
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
test by what it costs a round's wall time under the tests' locks. The
tests tool takes a lower bound on a round's wall time, and a test's
cost is how much the bound drops when the test's seconds drop to zero.
The bound is the largest of these:

- all tests' seconds over the workers;
- for each lock name, its `exclusive` holders' seconds summed, plus
  the larger of its longest `shared` holder's seconds and its `shared`
  holders' total seconds over the workers.

A round's ranking takes the workers the round's header records, and
the ranking the scenario list carries takes the budget's workers. No
rule puts a test that holds a lock first: the ranking charges each
test for what it costs.

A speed acceptance records that a reader found no waste in a test. It
holds across sprints until the test's own file changes, and a change
to a test support file the test lists does not clear it. An accepted
test counts as unreviewed again only where a test support file it
lists changed
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
