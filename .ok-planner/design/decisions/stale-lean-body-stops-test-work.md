---
decision: stale-lean-body-stops-test-work
---

# A stale lean profile body stops its profile's work

## Choice

True-up records a hash of each of the four materialized cheatsheets
when it writes a lean profile's body (see also:
lean-body-copied-word-for-word). While any of them differs from its
recorded hash, no task of a lean profile is filed and no sprint run
that opens test stages starts.

## Rationale

A lean agent reads the cheatsheets' rules only from its profile body.
A cheatsheet edited after true-up leaves every lean agent following a
text the session no longer holds. The hashes make a stale body
visible at the two moments it would do harm: when a task for the
profile is filed, and when a sprint run that opens test stages
starts. A person who edits a cheatsheet then runs the front door's
true-up before the next test task, and the body matches the
cheatsheets again.

## Alternatives

- A body with no hash record — a cheatsheet edited after true-up differs from every test agent's copy, unseen, until the next true-up.
