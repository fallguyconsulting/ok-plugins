---
decision: testing-set-up-by-its-own-verb
---

# Testing is set up by a verb of its own, apart from the front door's administration

## Choice

`/ok-setup`, a verb the owner runs, sets up testing. Run once, it
turns testing on; run again, it changes any of testing's settings,
freezes testing, or turns it off (see also:
testing-runs-inside-the-sprint). Turning testing on records the suite
command and its settings, the schedule the command runs, the coverage
it writes, the test stack's budget, and the offers planning makes, and
checks that the suite command runs every kind of test the project's
recorded tests hold. `/ok-setup` is no part of the front door's
administration (see also: administration-is-a-user-act).

## Rationale

The front door's administration brings the project's vendored layer
current on every upgrade. The answers testing needs are questions about the
project's runner, which the owner answers once and changes rarely. A
verb of its own asks them only when the owner sets up or changes
testing. True-up asks none of them live: for each value it has to
guess, it files one intake issue. One verb for turning
testing on, changing it, freezing it, and turning it off gives every
testing answer one place, and the check it runs when testing turns on
finds a suite command that cannot run the project's tests before any
sprint relies on it.

## Alternatives

- Testing set up inside the front door's administration: every
  true-up carries product questions about the project's runner.
- The owner writes the testing keys into the configuration by hand:
  the owner must learn every key, and nothing checks that the suite
  command runs the project's tests.
