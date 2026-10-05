---
issue: lint-patterns-labels-a-comment-by-its-neighbour
kind: audit
category: defect
artifacts:
  - story:lint-rules-compliance-report
status: verified
triage: defect
opened: 2026-10-04T23:34:00Z
---

# `plumbline patterns` labels a comment by the lines below it

## Problem

The site is `plugins/ok/families/ok-planner/scripts/plumbline:commentHygieneShape`. The accept-list entry is A9: the system reports something false that someone acts on. The cluster label `plumbline patterns` prints is a printed result the owner reads to direct remediation, as story:lint-rules-compliance-report says, and it names a shape the comment does not have.

Trigger: `plumbline patterns` over a file where a comment sits within four lines above a TODO comment, a license line, or a divider.

The function reads the shape from a fixed five-line window starting at the violation's line, not from the comment's own lines. Evidence, at `plumbline:1153`, `const blockText = lines.slice(v.line - 1, Math.min(v.line + 4, lines.length)).join(' ');`, and at `plumbline:1162`, `if (/\b(TODO|FIXME|HACK|XXX)\b/.test(blockText)) {`.

Re-verified at this tree in a scratch project: `d.py` holding `x = 1`, `# validate the order first`, `y = 2`, `z = 3`, `# TODO: persist` prints `[2x] comment-hygiene: todo-marker` with samples `d.py:2` and `d.py:5`. Line 2 holds no TODO.

## Ruling

> Generated ruling (/triage-issues): fix `plugins/ok/families/ok-planner/scripts/plumbline:commentHygieneShape` so a comment's cluster label no longer comes from lines outside the comment.
