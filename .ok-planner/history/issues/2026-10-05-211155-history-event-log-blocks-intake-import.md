---
issue: history-event-log-blocks-intake-import
kind: human
category: tooling
artifacts:
  - decision:issue-records-in-one-file
  - decision:closed-issues-leave-the-live-file
  - story:converge-project-estate
status: open
opened: 2026-10-05T21:11:55Z
---

# Diagnose misses an old event log at `.ok-planner/history/issues.jsonl`, and the markdown-intake import then fails on it

## Problem

At v25.0.0 the intake module uses `.ok-planner/history/issues.jsonl` as its archive of closed records. Neither diagnose nor converge checks what that file holds when it is already there. Diagnose offers the pre-v9 conversion (`legacy-intake`) only for an event log at the live path, `.ok-planner/issues.jsonl`. It reported the consumer project linescout as clean apart from the `markdown-intake` offer.

linescout's `.ok-planner/history/issues.jsonl` was a pre-v9 event log of 28 rows (14 `open`, 12 `promote`, 2 `retire`). It has been tracked since the project was vendored, and an earlier layout archived it to that path. When the owner accepted `markdown-intake`, the intake module read that file as the archive and refused the import. It wrote nothing, and it printed one defect per field per row:

> issues: .ok-planner/history/issues.jsonl:1: event: is not a field of an archived record
> issues: .ok-planner/history/issues.jsonl:1: title: is missing

The owner had no offer for the fix. The workaround was a hand `git mv` of the log to `.ok-planner/issues.jsonl`. After that, diagnose offered `legacy-intake` (0 open, 14 closed), but `resolve` refused it until the move was committed.

## Candidates

- Diagnose detects an event log at the archive path and offers to fold it, the way `legacy-intake` folds one at the live path. The fold's closed records replace the file.
- The `markdown-intake` offer checks that the archive parses before it offers, and names the archive's defect in its block.

## Ruling
