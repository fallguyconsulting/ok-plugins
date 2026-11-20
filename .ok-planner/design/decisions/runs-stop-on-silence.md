---
decision: runs-stop-on-silence
---

# A run of the suite stops only on silence

## Choice

A run of the suite stops only when no result line and no output arrive
for the silence period the project declares, `testing.silence`. A test
with no choice but a longer stretch of silence, such as one that waits
on a program the project does not control, records a silence of its
own, and the run waits that long only while that test has no result.
No test has a time limit of its own. How a stopped round reports is a
decision of its own (see also: stopped-round-files-one-report).

## Rationale

A silence period stops a hung run without making elapsed time a
test's verdict: a slow test that prints progress keeps the run going,
and a hung one stops it once nothing arrives. A silence of its own on
the one test that needs it keeps the project's period small for every
other test, and the run waits the longer silence only while that test
has no result, so a hung run stops without the longer wait once that
test reports.

## Alternatives

- A time limit per test: fails a slow test on elapsed time, the
  dependence the testing standard forbids in a verdict (see also:
  tests-spend-time-only-on-their-outcome).
- Raise the project's silence period to fit its longest wait: every
  hung run waits that long before it stops.
- No stop: a hung run holds the round until a person ends it.
