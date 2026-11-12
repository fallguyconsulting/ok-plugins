---
decision: product-slow-verdict-fixes-the-product
---

# A test slow because the product is slow gets a product fix, not a test rewrite

## Choice

A speed reviewer may find a test slow because the product is slow. It
then records a product-slow verdict that names the site, what the site
does, how its cost grows, and the cheaper behavior. Where the test
also wastes time of its own, the reviewer records the verdict whose
fix saves more seconds.

The fix loop files a fixer for the site and a verifier, as for a
failing test (see also: test-loop-fixes-code-never-tests). The fixer
changes the product so the site does only the work its answer uses,
and runs every test that reaches the site. The verifier sends back a
fix that leaves the slow work, drops a promised outcome, or fails a
test that reaches the site. A product-slow verdict is never a speed
acceptance: it settles once its fix is accepted, and the test then
gets a fresh speed read. When certification applies a product-slow
fix is a decision of its own (see also:
product-slow-fixes-ride-a-round-that-runs-anyway).

## Rationale

A test that is slow because the product is slow has no cheaper form
of its own; a fix to the product site took one test from 13.4 seconds
to 5.9. A verifier that reruns every test reaching the site holds the
fix to the outcomes those tests check, so the product sheds the slow
work and keeps every promise.

## Alternatives

- Rewrite the test for a product-slow verdict: the test has no cheaper
  form, and the product keeps its cost.
- Read a product-slow verdict as a speed acceptance: the slow site
  stays, and no reader reads the test again.
