---
decision: test-stack-budgeted-as-one-resource
---

# The test plan budgets the shared test stack as one resource

## Choice

The test plan budgets the shared test stack as one resource the whole
suite spends. The budget names the number of workers, the command
that starts the test stack, and the sizing the stack's configuration
gives for that many workers: memory, connection pools, and
deployment-wide limits. For each deployment-wide limit the tests
meet, such as one sign-in per user or a cap on fleet members, the
budget says whether the test stack's configuration raises it, the
workers split it, or a lease hands it out. A preflight before the
sprint's first test task, in a sprint that changes the budget, or
whose recorded budget no preflight has yet passed, checks
that the test stack runs alone with what it needs, and checks the
suite command's contracts (see also:
suite-contracts-checked-before-a-round). The budget's workers are the
count every machine starts from, and one machine's own count is a
decision of its own (see also: workers-sized-per-machine).

## Rationale

On one project, eight workers on one shared stack failed 179 of 456
tests: services ran out of memory, a connection pool ran dry, and
deployment-wide limits refused parallel work. A budget that sizes the
stack for its workers, and names how the suite meets each limit, puts
those failures in the plan instead of the first round. A preflight
that starts the stack alone with the budget's sizing finds a
shortfall at a cost of minutes, before a whole-suite round meets it.

## Alternatives

- Size the stack by hand, outside the plan: a sprint that adds tests
  meets a dry pool or a refused limit in its first round.
- One stack per worker: each worker pays a stack's memory and start.
- Leave each limit to the tests that meet it: tests on several workers
  race for one sign-in or one fleet slot.
