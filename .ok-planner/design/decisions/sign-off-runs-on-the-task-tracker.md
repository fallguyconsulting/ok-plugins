---
decision: sign-off-runs-on-the-task-tracker
---

# Sign-off's readers, merge, and fixer run on the task tracker, the readers forked from one reading of the rules

## Choice

The sign-off review's readers, its merge, and its fixer each run as a
task on the task tracker, drained by the drain loop under a vendored
profile (see also: sign-off-finds-then-fixes-once). Each reader's task
carries only its set of delta bodies, the prohibitions stated for
them, and the findings already settled on them, and the fixer's task
carries only the findings it fixes, the suggested prohibitions the
merge listed, and the stated prohibitions. Each verdict, finding, and suggested
prohibition is an item in the run's pools.

The readers run on the review profile. One root, a task on that
profile, reads the review's rules and the material every set shares
once, files one reader task per set forked from its own task, closes
its task, and forks one reader per set in one message (see also:
review-forks-own-pass-tasks). Every reader starts from the root's
context, in which the rules stand, so the rules are one cached prefix
for every reader. The merge and the fixer run on the opus profile.

## Rationale

The fixed cost of a sign-off reader is the review's rules: the
artifact forms, claim grounding, cross-reference integrity, and the
checklist, the same text for every reader. A task's claim prints the
task's id before its prompt, so a prompt read through a claim sits
after the point where two agents' contexts differ, and each reader
would read the rules with no cache. A root that reads the rules once
and forks puts them in the prefix every fork inherits, so each reader
pays only for its own bodies. A reader edits nothing, and the review
profile reads, searches, and forks without editing. The fixer edits
the sprint, so it runs on the opus profile, and the merge shares no
reading with another agent worth forking.

Items in the run's pools make the checklist's coverage a count the
session reads from the tracker, so a missing verdict shows without a
reading of prose. A fork that dies leaves its reader task open, and
the drain reissues it to a fresh agent of the profile, as any task.

## Alternatives

- Direct dispatches from the session, each with the rules pasted into its prompt — no run to open, and every reader writes the rules into a cache of its own, and its verdicts live only in its reply.
- One task per reader on the opus profile, the rules in its registered prompt — no root and no fork, and every reader reads the rules after its task id, with no cache.
- A lean profile whose body carries the review's rules — the rules join the cached prefix with no fork, and true-up writes and keeps current a new vendored profile for one review.
