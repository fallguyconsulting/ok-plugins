---
decision: whole-suite-rounds-repeat-until-one-passes
---

# Whole-suite rounds repeat until one passes after the last change

## Choice

Once no defect stands open, certification runs the whole suite once
more. Each failing test files a report, and the fix loop resumes. This
repeats until a whole-suite round passes after the last change, or
each failing test carries a verifier's recorded agreement on the
promise path (see also: suite-defects-take-no-send-back-limit). The
review passes, the checks, and the drive do not run again, so only
test failures reopen the loop. A sprint whose first whole-suite round
passes runs the suite once (see also:
test-loop-fixes-code-never-tests).

Where `testing.enabled` is `on` or `frozen`, `review certified`
refuses a sprint whose latest whole-suite round ran before its last
change, or in which a test failed with no held promise issue, or with
a speed send-back that neither settled, returned to its last passing
version (see also:
failed-speed-rewrite-returns-to-its-last-passing-version), nor, as a
product-slow verdict a passing whole-suite round left standing, went
to the intake (see also:
product-slow-fixes-ride-a-round-that-runs-anyway,
deferred-verdict-handed-off-through-the-intake).

## Rationale

Rerunning only the tests a fix reaches, with the whole suite at the
start and as the final round, still catches every regression a fix
causes, and spends a whole round only where it decides something; on
one project, rerunning the whole suite after every batch of fixes took
ten and a half hours over three rounds. The review passes, the checks,
and the drive read the change once, and running them again would
re-hunt code a fix changed. Each stop condition is a count or a pass,
so `review certified` decides completion without a model.

## Alternatives

- Rerun the whole suite after every batch of fixes: catches a
  regression one batch sooner, and pays a whole round for every batch.
- Run the review passes, the checks, and the drive again after the
  final round's fixes: re-hunts code a fix changed.
