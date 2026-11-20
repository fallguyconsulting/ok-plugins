---
decision: team-execution-cold-gate
---

# Sprint certification is the one review of a sprint's work

## Choice

The build runs no review of its own. Sprint certification,
`/converge sprint`, runs immediately after code complete (see also:
code-complete-at-latest-filing), in a ledger of its own, stays cold,
and is the only review the work gets. It reads the change from the
sprint's base commit to the working tree, once (see also:
review-forks-own-pass-tasks, review-passes-split-by-reading). The
test verifier that reads each new or rewritten test, for speed among
its checks, is part of the test work, not a review of the change (see
also: speed-read-at-three-points), and so is the review of the test
plan, which reads the test planners' items.

Beside the review, the project's checks run over the files the change
added or changed, and drivers try the stories certification drives on
the running product (see also:
certification-drives-what-the-sprint-changes). Where testing is on or
frozen, the project's suite runs too (see also:
test-loop-fixes-code-never-tests).

A merge agent folds the passes' reports, the checks' failures, the
drive's failures, the suite's failing tests, the build's noticed
defects, and the defect issues the sprint lists into one defect list
(see also: taken-defects-fixed-by-certification). What lies outside the sprint's scope
goes to the intake as a defect issue (see also:
defects-outside-scope-become-defect-issues), what needs the owner's judgment
goes to the intake as a judgment issue, and a defect in a file no
agent of the run edits goes where the rule on what a run fixes sends
it (see also: runs-fix-what-the-project-owns). Fixers work through the
list once, defects grouped by the files their fixes touch. The fix
loop runs as every defect run's does (see also:
converge-finds-then-fixes). The checks run once more when the fixes
end. No task leaves a process of its own running when it closes. Where the suite runs, the rounds the suite repeats say when the
fix loop ends (see also: whole-suite-rounds-repeat-until-one-passes).

## Rationale

Reviewing every stage as it lands and the whole diff again at the
end reads the same code twice. One measured execution of that
alternative shows the cost. The stage reviews reported 31 defects. The
final review reported 32 more over the same code. The per-stage loop
turned 63 defects into 40 fix tasks, and most held one defect. The
tasks ran chained one after another, and each was a fresh agent paying
the same startup for a two-minute edit. Several stage reports named
intermediate states a later stage was already going to remove. The one
cross-stage defect was fixed piecemeal across three stages where one
fixer holding the whole diff would have made one fix. Reviewing once,
over the finished work, removes the duplicated reading, and grouping
defects by the files their fixes touch removes the per-defect
dispatch.

The drive runs beside the review because a pass reads code, and a
story is met only when a user gets what it promises from the running
product.

Certification stays cold because a reviewer that has watched the code
grow can drift toward the builder's framing. A fresh reading of the
whole change is the check on that, and it is what discharges the
completion contract.

## Alternatives

- A build task and a review task per stage, with a per-stage fix
  loop — duplicated reading, reports about
  intermediate states, one fresh agent per defect.
