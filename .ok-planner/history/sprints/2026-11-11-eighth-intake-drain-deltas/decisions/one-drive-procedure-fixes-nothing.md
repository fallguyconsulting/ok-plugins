---
decision: one-drive-procedure-fixes-nothing
---

# One drive procedure, which fixes nothing, runs in each caller's own ledger

## Choice

The drive is one procedure, the one `/drive` runs: it tries stories
and fixes nothing. It takes every story, or, given a sprint, that
sprint's new and changed stories (see also:
certification-drives-what-the-sprint-changes). Run on its own,
`/drive` merges what its drivers find so only real defects remain,
sends each to the intake as a defect issue for the next `/converge`,
and reports each story's result (see also:
defects-outside-scope-become-defect-issues). `/converge` in drive mode
runs the same drive over every story, on the owner's cadence and apart
from any sprint, and then fixes what the merge keeps. Sprint
certification runs it inside its own run. Each caller runs the drive's
steps from one shared text, as tasks in its own run's ledger, so the
drive's failures merge with the caller's other findings into one
defect list; no caller starts the drive as a run of its own.

## Rationale

One drive procedure keeps one way to try a story, whoever needs the
answer. Run alone, it shows the owner which promises hold with nothing
changing the tree, and each defect it finds waits in the intake for
the run that fixes defects. Its merge keeps that intake to real
defects: a failure the corpus does not promise, or a failure of the
environment, is sorted out before anything is filed. Run inside
`/converge` or certification, its steps file their tasks in the
caller's ledger, so the merge folds the drive's failures with the
review's, the suite's, and the backlog's into the one list the fix
loop works. A drive started as a run of its own would hold its
failures in a ledger that merge never reads.

## Alternatives

- `/converge` in drive mode as the only way to drive — no second verb,
  and an owner who wants to see which promises hold takes the run's
  fixes with the answer.
- `/drive` fixes what it finds — two verbs with one job, and the fix
  loop kept twice.
- Certification starts `/drive` as a run of its own — the drive's
  failures land in another ledger, and the merge cannot fold them with
  the review's and the suite's.
- A drive-only run files every failure unmerged — no merge to pay for,
  and each failure the corpus does not promise, or each failure of the
  environment, reaches the intake as a defect to fix.
