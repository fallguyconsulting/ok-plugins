---
decision: failing-tests-rerun-alone
---

# A failing test runs alone before a fixer is filed for it

## Choice

Each test that fails in a round runs alone before a fixer is filed for
it. A failure alone files the fixer. A pass counts as fixed only where
a change since the test's failing round reached the test. Where
`testing.reaches` names `files` or `folders`, a change reaches each
test the verifier's rerun rule reruns after that change (see also:
fixes-rerun-the-tests-they-reach). Under `none`, a pass counts as
fixed where any fix landed since the failing round. A pass with no
reaching change takes the flaky route (see also:
flaky-tests-traced-through-the-round-window).

## Rationale

Running a failing test alone before a fixer is filed spends a code
fix only on a failure that repeats, and sends a failure that passes
alone to the flaky route, where its fixer looks for the cause. On one project, 444 of the failures
rerun before a fixer passed, and on another, 41 of 44 whole-suite
failures passed alone. A pass alone after a change that reached the
test shows that the change fixed it. A pass with no such change shows
only that the test passes alone, so its cause still stands.

## Alternatives

- File a fixer for each failing test of the round, with no rerun: a
  code fix is spent on each failure that does not repeat, and no fixer
  looks for the cause of a failure that passes alone.
- Count a test that passes alone as passing: a flaky test's cause
  stays in the tree and fails a later round.
