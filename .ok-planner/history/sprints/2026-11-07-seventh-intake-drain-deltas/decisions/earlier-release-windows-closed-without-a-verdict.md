---
decision: earlier-release-windows-closed-without-a-verdict
---

# True-up closes an earlier release's test-edit windows and claims no verdict

## Choice

True-up closes the test-edit window of each sprint an earlier release
laid out whose completion report holds sprint certification's return.
The mark it writes claims no verdict: it says that an earlier release
ran certification, that no record keeps the verdict, and that running
`review certified` for the sprint again records one. Running `review
certified` for that sprint again replaces the mark with `SPRINT
COMPLETE` where the contract holds, and removes it, which reopens the
window, where the contract does not hold (see also:
test-tasks-own-the-tests).

## Rationale

An open window lifts the test guard for every agent in the project,
and nobody sees it open, so true-up closes each window an earlier
release left. Earlier releases recorded no verdict, so true-up cannot
know how that certification ended, and its mark claims none. One run
of `review certified` turns the mark into the real verdict: a mark
that stands where the contract holds, or an open window where it does
not.

## Alternatives

- True-up marks an earlier release's certified sprint complete: a
  failed certification gets a mark that says it passed.
- The owner closes an earlier release's sprints by archiving them:
  each window stays open, unseen, until the owner acts.
- The lint treats every sprint whose completion report holds
  certification's return as closed: a failed sprint closes under the
  carried release too, which records its verdict.
