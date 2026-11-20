---
decision: tests-set-up-their-own-starting-state
---

# Each test sets up the state it starts from

## Choice

Each test sets up the starting state it needs, and relies on no
earlier test to leave the system clean. A test that sets up shared
state holds that state's lock exclusive (see also:
tests-isolated-unless-declared). How a test removes what it creates,
and how it checks a shared outcome, are decisions of their own (see
also: tests-remove-what-they-create,
shared-outcomes-checked-for-a-new-instance).

## Rationale

Tests run in a new order every round (see also:
tests-run-in-a-new-random-order), so a test that relies on an earlier
one to leave the system clean passes in one order and fails in the
next. Setup under an exclusive lock keeps every other test that holds
the lock from changing the state between the setup and the check.

## Alternatives

- Reset the whole stack between tests: every test pays a reset, and no
  two tests run side by side.
- Run the tests in a fixed order, each starting from what the one
  before it left: a race hides in the same order every round, and one
  failure fails every test after it.
