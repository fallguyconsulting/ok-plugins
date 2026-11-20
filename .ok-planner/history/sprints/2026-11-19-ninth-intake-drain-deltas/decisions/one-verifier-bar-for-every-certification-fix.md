---
decision: one-verifier-bar-for-every-certification-fix
---

# Every certification fix passes one verifier, and a sent-back fix takes `/converge`'s shape

## Choice

Every fix in certification, whatever its source, passes one verifier.
It checks that the fix adds no harm the accept list names, brings
along every caller of a contract it changes, changes no behavior
across a release boundary without a ruling, and passes the project's
checks on the changed files. It sends a fix back where the fix checks
whether a test runs, reads a setting only a test sets, treats the
test's data as a special case, hides a failure behind a swallowing
catch, a longer wait, or a blind retry, fakes the effect the test
looks for, touches a test path, or waits on elapsed time (see also:
tests-spend-time-only-on-their-outcome). A time control a sprint's code
stages built is product code every deployment carries, not a
setting only a test sets (see also: planned-tests-name-their-waits).
The verifier reruns the tests the fix reaches (see also:
fixes-rerun-the-tests-they-reach). A fix the verifier sends back is
fixed again in `/converge`'s shape: the next fixer starts from the code
as it stands and reads the verifier's reason, and each verifier reads
its fixer's change as `/converge`'s verifiers do (see also:
converge-finds-then-fixes). A confirm run reruns the fixed test for
each suite defect.

## Rationale

One verifier holds every fix to one bar, whatever found its defect. A
sent-back suite fix takes `/converge`'s shape, so certification runs
one fix loop for every defect, and the verifier's reason carries what
the rejected change got wrong to the next fixer.

## Alternatives

- Back a sent-back fix out of the tree before the next attempt starts:
  no rejected change stands in the tree the next fixer finds, and the
  suite's defects take a fix shape `/converge`'s other defects do not,
  where the verifier's reason already tells the next fixer what the
  rejected change got wrong.
- Fixers and verifiers one at a time, each verifier reading its
  fixer's change from snapshots taken before and after it: each
  verifier sees one change alone, and a round with many failing tests
  waits for every fix in turn.
