---
issue: boilerplate-lost-task-list-instruction
kind: human
category: execution-guidance
artifacts:
  - story:plan-a-sprint
status: open
opened: 2026-07-29T01:03:05Z
---

# Sprint executors stopped building task lists after the affirmative instruction was deleted

## Problem

The v9 estate CLAUDE.md carried the execution steps inline: its
staging step said "keep it in your working state (a task list is
ideal)" and its numbered closing steps enumerated close-on-contract
then offer-the-close-out. Sessions executing a sprint reliably built
a TODO list whose last entries were certify, present, archive/commit.

The v11 rewrite compressed that section to a summary that defers to
the sprint boilerplate; "a task list is ideal" and the enumerated
final steps were deleted. What remains is dominated by prohibitions:
the boilerplate's staging step mentions "a task list, an
orchestrator's graph" only inside a warning whose punchline is "It is
never rewritten into a plan document," and the cheatsheet adds "never
write a plan document from one." With only negative signals about
staging artifacts, sessions now create nothing — and with the list
went its tail anchor, one more contributor to the closing ceremony
not firing.

The owner's placement call: this belongs in the sprint execution
boilerplate, not in CLAUDE.md — the sprint is the one document every
executor (inline session, goal agent, orchestrator) is guaranteed to
hold; the CLAUDE.md placement only ever worked incidentally for
inline sessions.

## Candidates

- Amend the boilerplate's staging step to state affirmatively that
  the executor builds a task list in its own working state (harness
  task tracking where available), one entry per stage, seeding the
  terminal entries up front — certify, present, offer archive/commit
  — with the never-a-plan-document warning kept as a qualifier after
  the affirmative, not the only statement about staging.

## Ruling

Resolved inline, ahead of the sprint (owner decision, 2026-07-29),
as the candidate states and in the boilerplate only — the owner's
placement call is recorded: this guidance belongs in the sprint
document (the one brief every executor holds), never in CLAUDE.md.
The staging step is now "Stage the work into a task list," with the
closing entries seeded up front (finish the completion report, run
/certify-work, walk the presentation, offer archive-and-commit) and
the never-a-plan-document warning kept as its qualifier. Stays open
for the next sprint to ratify; ships with the next
release/re-vendor.
