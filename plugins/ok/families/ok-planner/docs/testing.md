# Testing: the standard

This standard governs how a test spends its time. A test sprint's
planners plan by it, its test tasks write by it, and its fixers fix
by it. The planning reviewer, the verifier, and the speed reviewer
read each test against it. No lint checks it.

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
  or a stack per test.
- A shared resource declared where a cheaper design keeps the test
  isolated.
- Work the outcome does not need, such as extra devices, records, or
  steps.

## Silence

A test is never silent for long. `tests run` stops a run after
`testing.silence` seconds with no result line and no output, and the
project keeps that setting as small as it can. Each test, and each
tool under the project's control that a test runs, prints a line of
progress as it works, so long silences are rare. `testing.setup`
gets the test environment ready before the silence clock starts, so
no test waits out a stack's start.

A test with no choice but a longer stretch of silence, such as one
that waits on a program the project does not control and that prints
nothing, records a silence of its own, as small as its wait needs.
The run waits that long only while that test has no result. The
project never raises `testing.silence` for every test to fit its
slowest or longest-waiting test. The verifier and the speed reviewer
send back a test's own silence that a progress line or a cheaper
design would remove.

## Time per round

Each round records each test's seconds, setup and teardown included,
and lists the slowest tests, ranked by what each test adds to the
run's wall time. A test that declares a shared resource runs holding
it alone, so it adds its whole seconds. An isolated test runs beside
the others, so it adds its seconds divided by the workers.

The test sprint works each test it writes or modifies until the test
runs as quickly as it can while it still proves its outcome. Once a
whole-suite round passes, a speed reviewer reads those tests down
the round's ranked list, `testing.slowest` at a time, and the sprint
rewrites each test the reviewer sends back, then runs the whole
suite again. The review walks past each batch that held a send-back,
and stops at a batch accepted with no send-back. The next test plan also reads the list its planning run
records, and its planners replan a slow test whose time comes from a
named waste. No time budget decides a verdict: the ranking picks the
tests to read, and the reader judges the waste.

## Who reads for the wastes

The planning reviewer reads each planned test for each named waste.
The verifier reads each written test for each named waste, for a
verdict that waits on elapsed time, and for a silence of its own that
a progress line or a cheaper design would remove, and sends back a
test that has any of them. The speed reviewer reads each test the sprint wrote or
modified, down a passing round's ranked list, for each named waste,
and sends back a test whose time goes to one, naming the cheaper
form. No count of send-backs makes it accept: a test goes back as
often as a rewrite leaves a named waste.
