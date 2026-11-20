---
decision: round-failure-cleared-by-a-later-round
---

# A later closed round clears a failure that belongs to a whole round

## Choice

Three failures belong to a test round rather than to one test: a
leftover count that grew (see also:
leftovers-counted-around-each-round), a stop, and two tests run
together that hold one lock, at least one of them exclusive (see also:
rounds-checked-against-the-locks). A later closed round that
reaches any test a whole-suite round's leftover or stop failure
concerns clears it. A rerun round's failure, or a lock breach in
any round, clears once a later closed round reaches every test it
concerns. A later closed whole-suite round drops every earlier failure
(see
also: fixes-rerun-the-tests-they-reach).

## Rationale

The project pays no whole round per fix (see also:
fixes-rerun-the-tests-they-reach), and this rule lets a fixer's own
rerun settle the failure it fixed. A narrow rerun that clears a whole
round's leftover failure does no lasting harm: every round counts
leftovers, so a rerun that leaks again records the failure again, and
certification still ends only on a passing whole-suite round, which
drops every earlier failure and records its own (see also:
whole-suite-rounds-repeat-until-one-passes). A rerun round or a lock breach
names the exact tests at fault, so reaching all of them is the
evidence its fix holds.

## Alternatives

- Only the next whole-suite round clears a round's failure: each such
  fix waits a whole round.
- Every round's failure clears only once a later round reaches every
  test it concerns: a whole-suite round's leftover failure then needs
  a rerun of every planned test.
- Only a round whose tests match the fixed defect's own list clears
  the failure: each rerun round must be tied to a defect, which no
  result records.
