---
decision: tests-isolated-unless-declared
---

# A test is isolated unless it declares the shared resource it changes

## Choice

A test is isolated by default: it touches only state it created and
named, and isolated tests run in parallel; those that need the stack
share one test stack. A
test that must change shared state declares each shared resource it
changes, such as the stack's message broker or its clock. The scenario
list records the declaration, and the project's suite command runs the
test while holding each declared resource alone, so no test that uses
the resource runs beside it. The planning reviewer sends back a
declaration a cheaper design avoids, such as a clock the test could
inject or a broker of its own.

The test plan budgets the shared test stack as one resource the whole
suite spends. It names the number of workers, and the test stack's
configuration sizes memory, connection pools, and deployment-wide
limits for that many. A preflight before the first test task checks
that the test stack runs alone with what it needs. For each
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
resources still run side by side. Counting leftovers each round
catches a leak in the round that made it.

## Alternatives

- One full stack per test: isolated, and every test pays a stack's
  start.
- Fixed phases of tests, such as shared, deployment, and disruptive:
  mixes what breaks other tests with what costs memory, and runs every
  disruptive test alone.
- Each project works out isolation for itself: every project meets the
  same failures under its first parallel run.
