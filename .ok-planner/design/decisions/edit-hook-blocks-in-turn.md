---
decision: edit-hook-blocks-in-turn
---

# The edit hook blocks in-turn, scoped to changed lines, and never breaks a session

## Choice

Lint enforcement runs as a post-edit hook that blocks the agent in the same turn on violations — but only within the edited file's changed line ranges for tracked files (untracked files checked whole), and with every hook failure path (missing input, no repository, no vendored binary, spawn error) degrading to a silent pass.

## Rationale

Blocking in-turn is the only moment the fix is free — the agent sees the message with the edit still in hand. Scoping to the change keeps pre-existing debt from blocking unrelated work, which is what makes strict enforcement livable on legacy code; failing open on infrastructure errors means the check can only ever block on genuine findings, never break a session.

## Alternatives

- Advisory-only reporting after the fact — residue accumulates faster than sessions clean it.
- Whole-file blocking — any legacy file becomes uneditable until fully clean, punishing unrelated edits.
- Failing closed on hook errors — session breakage as the price of an infrastructure hiccup.

## Proof

The lint binary's violation exit code is asserted by the fixture suite, and the hook wiring itself is exercised end-to-end by the hook-invocation harness: git-backed cases invoke the materialized hook as the harness would, asserting changed-line scoping — a violation on an untouched line passes, the same violation on a changed line blocks — and that each fail-open branch degrades to a silent pass. Falsifier: mis-scope the range parsing or make a fail-open branch block — the harness case for that behavior goes red.
