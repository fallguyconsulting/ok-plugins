---
decision: tests-isolated-unless-declared
---

# A test is isolated unless it declares the shared resource it changes

## Choice

A test is isolated by default: it touches only state it created and
named, and isolated tests run in parallel; those that need the stack
share one test stack. A
test that must change shared state declares each shared resource it
changes, such as the stack's message broker or its clock, in
`resources`. A test declares each shared resource it reads and does
not change in `reads`. A scenario that declares a resource it changes
and no `reads` counts as reading every shared resource. An isolated
scenario declares no resource and reads no shared resource, so its
test takes no lock and may run beside any test the recorded schedule
allows. The scenario list
records both declarations. The test planners write them, and the test plan's review checks them
and sends back a declaration a cheaper design avoids, such as a clock the test
could inject or a broker of its own.

The testing standard and the suite command's contract recommend one
schedule: two tests may run at the same time unless one changes a
resource the other changes or reads. Tests that share a changed
resource form one group, which runs its tests one after another on one
worker. The run uses at most the budget's workers.

Before the suite command starts, each run of the tests tool locks each
shared resource its tests declare: an exclusive lock for a resource a
test changes, and a shared lock for one a test only reads, held until
the run ends. A whole-suite round locks every resource its tests
declare, and a run of isolated tests takes no lock. A run that needs a
lock another run holds waits for it, and prints one line naming that
run and the resource it waits on.

A project records the schedule its suite command runs in
`testing.schedule`, a required key that holds the schedule's form and
the owner's words for it. The forms the tests tool knows are
`recommended`, `groups-side-by-side`, in which held groups run at the
same time as each other after the isolated tests, and
`groups-one-at-a-time`, in which held groups run one after another
after the isolated tests. A project whose suite command cannot follow
the recommendation records the form it runs instead. A departure is a
competing practice, never an exemption: the recorded form names what
the project does, and the schedule check holds the project to it. The
key has no default in code (see also: settings-have-no-code-defaults).

After each round, the tests tool checks every pair of tests that ran
at the same time against the recorded schedule. It takes each test's start and end from
its result line, as the suite command's own clock reads them (see
also: project-owns-its-suite-command), and, for a line that carries
neither, takes the test's start as the line's arrival less its
seconds. A forbidden
pair fails the round, and a fixer of the suite command takes it up.
While the key holds no words from the owner, the tests tool ranks by
the recorded form and skips the schedule check, because a guessed form
must fail no round.

The tests tool ranks the slowest tests by the recorded schedule. It
takes a lower bound on a round's wall time under that schedule, and a
test's cost is how much the bound drops when the test's seconds drop
to zero. Under `recommended`, the bound is the larger of the longest
group's total seconds and all tests' total seconds over the workers.
Under `groups-side-by-side`, it is the isolated tests' seconds over the
workers plus the larger of the longest group's total seconds and all
held tests' seconds over the workers. Under `groups-one-at-a-time`, it
is the isolated tests' seconds over the workers plus every group's
seconds. No rule puts held tests first;
the ranking charges each test for what it costs.

The test plan budgets the shared test stack as one resource the whole
suite spends. It names the number of workers, and the test stack's
configuration sizes memory, connection pools, and deployment-wide
limits for that many. A preflight before the sprint's first test task, in a sprint that
changes the budget, checks that the test stack runs alone with what
it needs, and checks the suite command's contracts (see also:
suite-contracts-checked-before-a-round). For each
deployment-wide limit the tests meet, such as one sign-in per user or
a cap on fleet members, the plan says whether the test stack's
configuration raises it, the workers split it, or a lease hands it
out. The project declares a command that prints one count per kind of
resource a test may leave behind. The tests tool compares the counts
before and after each round, and a count that grew fails the round.

## Rationale

Unique names keep one test's data apart from another's, and do nothing
for the stack they share. On one project, eight workers on one shared
stack failed 179 of 456 tests: services ran out of memory, a
connection pool ran dry, deployment-wide limits refused parallel
work, one test's restart of the message broker cut every worker off,
and tests left hundreds of records behind that slowed the rest.
Declaring each changed resource lets two tests that change different
resources still run side by side. A test that reads a resource while
another test changes it sees the change half done, so the schedule
keeps a reader apart from a changer, and `reads` lets two readers run
side by side. Two runs at once, such as a fixer's rerun beside
another's, would otherwise run a reader beside a changer, so each run
locks what its tests declare, and a run of isolated tests, which can
disturb no other, waits on nothing. A line that names what a run
waits on tells its caller why the run has not started. Counting
leftovers each round catches a leak in the
round that made it.

The project owns its suite command, and the testing standard
recommends what may run at the same time, so every project's suite
runs as much in parallel as its declarations and its recorded schedule
allow. Some projects' runners cannot follow the recommendation. A
recorded form and the owner's words let such a project say so once
(see also: settings-have-no-code-defaults).
The schedule check reads the times the results already carry, so a
suite command that runs a forbidden pair fails the round that ran it,
where it would otherwise show as a flaky test far from its cause. A
start and an end the command reads from one clock compare two tests
on that clock alone. A start taken as a line's arrival less its
seconds subtracts a time on the command's clock from a time on the
tool's: on one project a runner that wrote a file's result lines
together as the file ended, and overlaps of a few milliseconds,
failed two rounds in which every test passed. A
held test adds its whole seconds to the wall time under one schedule
and only a share of them under another, so a ranking that ignores the
schedule misjudges which test costs the round the most.

## Alternatives

- One full stack per test: isolated, and every test pays a stack's
  start.
- Fixed phases of tests, such as shared, deployment, and disruptive:
  mixes what breaks other tests with what costs memory, and runs every
  disruptive test alone.
- Each project works out isolation for itself: every project meets the
  same failures under its first parallel run.
- Require the recommended schedule of every project: a project whose
  runner cannot follow it has no way to say so, and every check fails
  it.
- Declare only the resources a test changes: a test that reads a
  resource runs beside the test that changes it.
- Trust the suite command's schedule with no check: a forbidden pair
  shows only as a test that fails now and then.
- Take every start as a line's arrival less its seconds: a runner that
  writes its lines late, or a few milliseconds of noise, fails a round
  in which every test passed.
- A tolerance of a set number of seconds on each pair: the check bends
  to fit the noise, and passes a real overlap shorter than the
  tolerance.
- Rank held tests first: charges a held test as if it ran alone under
  every schedule.
- Refuse a run that needs a resource another run holds: a rerun that
  could wait a few minutes fails instead.
- One lock for every run of the suite: a rerun of isolated tests waits
  on a round it cannot disturb.
