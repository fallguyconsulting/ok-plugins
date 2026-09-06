---
issue: certification-rounds-verify-only-what-a-fixer-staged
kind: human
category: conflicting
artifacts:
  - decision:team-execution-cold-gate
  - story:certify-completion
status: open
opened: 2026-09-06T07:39:53Z
---

# Later certification rounds read only the paths a fixer staged, so a defect the first sweep missed is never reviewed again

## Problem

The review-fix loop runs its four code-review passes once and never
again. Every later round files one verify task that consumes the
`staged` pool and reads the round's edits as hunks. A defect the first
sweep missed in a file no fixer touches is never read again, and the
loop exits clean over it. The owner's original design ran the whole
review in every round.

The canonical text in
`plugins/ok/families/ok-planner/skills/_shared/certification-core.md`:

- Phase A files the four passes and says "Every pass reads the whole
  change".
- Step 4, Re-verify, says "file one verification pass ... it verifies
  each fixed finding on the tree, reads the round's edits as hunks
  against the round's tree ... and a whole file only where a hunk's
  meaning needs it".
- Step 5, Exit, rests on that shape: "The tree did not move, so
  re-verification would read the same tree."

`decision:team-execution-cold-gate` states the same shape: "A verify
pass reads the round's edits as hunks against the round's recorded
tree, not whole files."

The history of the vendored copy in the GridIQ platform project shows
the drift. From v15.2.0 through v18.7.0, step 4 read "Re-run each
producer whose findings were worked or whose subject a fix touched, at
its original scope", and the code-review producer's subject was the
whole change, so every round with a fix re-ran the whole review. The
cap in that text was "After 3 fixer passes without a clean review".
The v18.8.0 converge replaced step 4 with a standing reviewer that
"re-reads the touched files, continues its sweep where files remain
unread, and reports DRY", and raised the cap to eight edited rounds.
The v20.1.0 converge replaced the standing reviewer with the per-round
verify task over staged paths. Neither rewrite restored the whole-change
re-run, and no sprint in this repository records the owner choosing the
incremental shape.

The cost showed in one run. The GridIQ platform executed its
remove-line-topology sprint under v20.1.0. The `references` pass, whose
row in the code-review prompt covers "Every symbol the change leaves
whose callers it deleted", closed round one reporting only the
deleted-name half of its population, with no orphan-symbol count. The
build had deleted the one caller of `console/views.py::run_panel` and
two of its helpers, cut `console/screens.py::Screen` down to one member
that reads only `.plural`, and left `control/schemas.py::LABEL_LIMIT`
with no reader. No fixer staged those three files in rounds two to
four, so no verify task opened them, and the loop exited clean with
the five orphans in the tree. The same sprint executed under v19.7.0
on another branch removed all five.

Two facts bear on the candidates. The four sweep passes cost about
1.3 million subagent tokens in that run, and the loop ran three rounds
with edits after the sweep. The pass's closing population line is the
one mechanical check the orchestrator has on a pass that under-
enumerates, and the text asks each pass to close "with its checked
population in the result" but gives the orchestrator no rule to refuse
a close whose population omits a heading its row names.

## Candidates

- Every round with an edit re-files the four passes over the whole
  change, and the verify task verifies the fixed findings; the exit
  rule reads the passes' closes instead of the staged pool. The cap
  returns to its original three.
- The verify task consumes the staged pool and, in addition, re-runs
  the `references` and `test-inventory` enumeration passes over the
  whole change on `ok-sonnet` every round, since those two reduce to
  enumerate-then-grep and are the ones a partial sweep hurts.
- The incremental shape stands, and the orchestrator refuses a pass
  close whose population line omits a heading the pass's row names,
  sending the task back through `tasks retry`.
