---
decision: story-test-stamp-is-its-planned-blob
---

# Each story's test stamp is the blob its plan last planned

## Choice

Each story carries a test stamp of its own: the git blob id of the
story's file as a plan last planned that story's scenarios, so a
planner recovers the planned version and reads how the file differs
(see also: scenario-list-decided-once). Whether a story whose plan
found nothing to test takes a stamp is a decision of its own (see
also: scenario-list-written-at-the-archive-step).

## Rationale

A test stamp per story lets the owner take stale stories a group at a
time, where one stamp for the whole list would mark every story
current or every story stale at once. A blob id names the planned
version itself, so git returns that version for the planner to read
against the current file.

## Alternatives

- One stamp for the whole list, at the last close: a sprint that plans
  some stories leaves the rest looking current.
- A digest of the story's file as its stamp: it shows that the file
  changed, and the planner cannot recover the planned version to read
  how.
