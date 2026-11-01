# Testing: the standard

This standard governs how a test spends its time. A test sprint's
planners plan by it, its test tasks write by it, and its fixers fix
by it. The planning reviewer and the verifier read each test against
it. No lint checks it.

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

## Time per round

Each round records each test's seconds, setup and teardown included,
and lists the slowest tests. The next test plan reads the list its
planning run records, and its planners replan a slow test whose time
comes from a named waste. No time budget decides a verdict.

## Who reads for the wastes

The planning reviewer reads each planned test for each named waste.
The verifier reads each written test for each named waste, and for a
verdict that waits on elapsed time, and sends back a test that has
either.

<!-- Materialized by ok-planner v30.0.0 — suite-owned; overwritten on true-up; do not hand-edit. -->
