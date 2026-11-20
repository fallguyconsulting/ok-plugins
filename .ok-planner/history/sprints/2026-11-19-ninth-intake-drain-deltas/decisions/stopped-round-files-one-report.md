---
decision: stopped-round-files-one-report
---

# A stopped test round files one report for the stop

## Choice

A round that stops records each test it never reached as `not run`,
not as failed. A whole-suite round that stops because no test reported
in time files one report for the stop, in the class a failing test
takes, naming each test the round never reached. One fixer takes it
up, and certification cannot pass while the latest round stands
stopped. No fixer is filed for each unreached test.

## Rationale

A round that stops early leaves tests that never ran, and reading them
as failed would file a fixer for each. With no report, certification
could read the unreached tests as no failure and pass a sprint whose
suite never finished. One report keeps
every stop in front of certification without a fixer per test that
never ran. A failure that passes alone still has a cause (see also:
flaky-tests-traced-through-the-round-window), so a stop no lone run reproduces,
such as a hang two tests cause together, still gets its report.

## Alternatives

- Rerun each unreached test alone, and report only the tests that fail
  alone: a hang two tests cause together goes unreported.
- A report class of its own for a stopped round: its fixer does the
  work the failing-test class gives, and the fix loop keeps another
  route.
- No report for the stop: certification reads the unreached tests as
  no failure.
- Read a stopped round's unreached tests as failed: files a fixer for
  each test that never ran.
