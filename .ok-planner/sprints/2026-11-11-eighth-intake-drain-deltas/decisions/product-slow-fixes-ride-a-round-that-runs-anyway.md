---
decision: product-slow-fixes-ride-a-round-that-runs-anyway
---

# A product-slow fix lands only where another whole-suite round runs anyway

## Choice

Sprint certification applies a product-slow fix (see also:
product-slow-verdict-fixes-the-product) only where another whole-suite
round runs anyway: beside a failure that reopens the fix loop. Once a
whole-suite round passes with nothing else left to fix, no
product-slow fix lands after it, and each product-slow verdict still
standing goes to the intake as a judgment issue for the next sprint,
which runs the whole suite anyway. A product-slow verdict alone
reopens no loop (see also: test-loop-fixes-code-never-tests).

## Rationale

A product fix changes the product, so a whole-suite round must run
after it. On one project a perf fixer changed the product after the
second whole-suite round had passed every test, though the speed read
had marked the test product-slow before that round ran, and
certification ran a third whole-suite round of 16 minutes for that
fix alone. On another project a sprint ran seven whole-suite rounds
where its design needs two, each extra round set off by a fault no
product code or test caused. Applying the fix only beside another
failure lets it ride a round that runs anyway, and the next sprint,
whose certification runs the whole suite, takes up the verdicts that
remain.

## Alternatives

- Apply every product-slow fix whenever its verdict stands: a fix
  after the closing round costs a whole-suite round of its own.
- Fix every product-slow verdict before the round certification means
  to close on: a verdict found after that round still costs another.
- Defer every product-slow fix to a later sprint: a fix that could
  ride a round already running waits a sprint for no saving.
