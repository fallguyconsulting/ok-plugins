---
issue: completion-contract-terms-not-inspectable
kind: human
category: conflicting
artifacts:
  - concept:completion-contract
  - story:plan-a-sprint
status: promoted
sprint: 2026-07-28-ratify-inline-certification-repairs.md
opened: 2026-07-29T01:03:04Z
---

# The completion contract's terms cannot be verified from the tree, so goal checkers accept early-outs

## Problem

Observed: a goal invocation was declared satisfied before
certification and presentation ran. The checker read its evidence
correctly — the contract is defective in two ways.

First, its final term is unverifiable by construction: "/certify-work's
review-fix loop has been run last and come back clean" is a claim
about session history with no on-disk trace. Every inspectable
artifact can be in its passing state while certification never ran:
deltas match the corpus, audit-check exits 0 (vacuously, when the
inspector never ran), the tree is staged and tidy.

Second, the presentation is not a contract term at all. The
requirement that the run end in a presentation lives only in the
how-to-execute prose ("this file stays in sprints/ through the
presentation"); the contract — which the boilerplate designates as
the stop condition — never mentions the presentation or close-out.
Read strictly, a goal keyed to the contract is entitled to declare
success before any ceremony. The guidance and the contract disagree,
and the checker followed the contract.

## Candidates

- Rekey the contract's terms to durable records a checker can
  inspect: a certification receipt covering the current tree's
  content, and the completion report present at its path (both per
  their own open issues), replacing the has-been-run-last phrasing.
- Add the presentation/close-out as an explicit contract term so the
  stop condition and the execution guidance agree.

## Ruling

Resolved inline, ahead of the sprint (owner decision, 2026-07-29),
jointly with the completion-report ruling. The contract's fourth
item now points at the completion report beside the sprint — it must
be finished, carrying certification's presentation with the
review-fix loop clean — making every item verifiable from the
repository. The contract also gains an explicit goal rule for any
checker: the goal is met either when the sprint file has moved to
history with its `closed:` stamp (terminal — fixes the
never-ends-after-archive failure), or when the file is still in
flight and all four items verify against the tree (a missing
completion report is NOT done, however green the rest — fixes the
early-out). Implemented in the sprint boilerplate's contract
section and reflected in the estate CLAUDE.md template. This issue
stays open so the next sprint ratifies; the work ships with the next
release/re-vendor.
