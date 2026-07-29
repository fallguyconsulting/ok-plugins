---
issue: sprint-work-presentation-lost-with-execute-plan
kind: human
category: ceremony
artifacts:
  - story:plan-a-sprint
  - story:certify-completion
status: open
opened: 2026-07-29T01:03:02Z
---

# The end-of-sprint work presentation lost its owner and its artifact when execute-plan was retired

## Problem

The original execute-plan skill owned the close of a run as its own
steps, independent of certification: the workflow produced a
completion-report file, the skill's closing step was "Walk the
completion report with the user" (proofs exhibited, decisions kept,
decisions diverged, coverage divergences), and the report was
archived with the plan — "The report is the durable record; what the
user walks IS what goes to history." Both the report artifact and
the walk were deleted in the v4.0.0 rework and never reappeared.

Today the sprint-work presentation exists only as the tail of
/certify-work's in-context presentation — a category error:
certification reports certification outcomes (findings fixed,
ledger); the missing ceremony is the presentation of the work
itself. It survived while certify-work was short; the v11 expansion
made the terminal step long and dispatch-heavy, and every upstream
failure (a leaf-rule conflict, a goal early-out, end-of-chain
attrition) now silently deletes the ceremony with it. Observed
repeatedly: sprints end with no tidy summary, no divergences, no
archive/commit offer.

A durable report also resolves a live conflict: the conduct's
delivery rules license a single comprehensive message only when the
deliverable is a file, while the presentation block instructs
"delivered whole, not paced" for a chat message — a file deliverable
satisfies both.

## Candidates

- Restore an execution-owned completion report: the sprint execution
  boilerplate has the executor accumulate it as a durable file (work
  done, divergences, promoted issues), the ceremony is walking that
  file with the owner, and certification verifies the report exists
  and matches rather than hosting the presentation.
- Narrower: keep the ceremony inside certify-work but anchor it to a
  written report file the contract can name, so its absence is
  detectable.

## Ruling

Resolved inline, ahead of the sprint (owner decision, 2026-07-29),
in the first candidate's shape: the completion report returns as an
execution-owned durable file — same filename as the sprint with
`-completion`, placed alongside the sprint document, kept current by
the executor as stages land (work done, divergences, calls made),
finished by the certify ceremony (the composed presentation is
written into it, then walked with the owner), and archived to
`history/sprints/` together with the sprint at close-out. The sprint
boilerplate carries the executor step; the presentation block,
both certify gates' close-outs, and the estate templates were
updated accordingly. Being a file deliverable, the presentation is
also now unambiguously delivered whole. This issue stays open so the
next sprint ratifies; the work ships with the next
release/re-vendor.
