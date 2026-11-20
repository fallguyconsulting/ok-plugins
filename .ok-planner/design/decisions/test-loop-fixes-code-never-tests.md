---
decision: test-loop-fixes-code-never-tests
---

# Sprint certification runs the suite as a find source

## Choice

Sprint certification runs the project's suite as a find source, beside
the review passes, the build's noticed defects, the project's checks,
and the drive, where `testing.enabled` is `on` or `frozen` (see also:
testing-runs-inside-the-sprint). The first whole-suite round runs once
the build's stages close. Each failing test, and each leftover count
that grew, files a report, and the merge folds every report into the
one defect list (see also: converge-finds-then-fixes). Which failing
test gets a fixer is a decision of its own (see also:
failing-tests-rerun-alone), and so is the route a test takes that
fails in a round and passes alone (see also:
flaky-tests-traced-through-the-round-window).

How a fixer treats a test is a decision of its own (see also:
fixers-never-edit-tests), and so are the verifier every fix passes
(see also: one-verifier-bar-for-every-certification-fix), the
send-backs a suite defect takes (see also:
suite-defects-take-no-send-back-limit), and the whole-suite rounds
that repeat until one passes (see also:
whole-suite-rounds-repeat-until-one-passes).

How a run of the suite stops is a decision of its own (see also:
runs-stop-on-silence). Which tests a reader reads for speed, and when,
is a decision of its own (see also: speed-read-at-three-points,
speed-ranked-by-median-seconds), and so is when a product-slow fix
lands (see also: product-slow-fixes-ride-a-round-that-runs-anyway).

## Rationale

A test checks the code against a promise on every later change, so a
failing test is a defect the rules already decide. Folding each
failing test and each leftover count into the one defect list gives
the suite's defects the fix loop every other defect of the run takes,
and the run waits on the owner for none of them while it fixes.

## Alternatives

- Stop at the first failing test and ask the owner: the run needs the
  owner, and certification never stops to ask.
