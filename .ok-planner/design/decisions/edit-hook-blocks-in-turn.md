---
decision: edit-hook-blocks-in-turn
---

# The edit hook blocks in-turn, scoped to changed lines, and never breaks a session

## Choice

Lint enforcement runs as a post-edit hook that blocks the agent in the same turn on violations — but only within the edited file's changed line ranges for tracked files (untracked files checked whole), and with every hook failure path (missing input, no root, no vendored binary, spawn error) degrading to a silent pass.

## Rationale

Blocking in-turn is the only moment the fix is free — the agent sees the message with the edit still in hand. Scoping to the change keeps pre-existing debt from blocking unrelated work, which is what makes strict enforcement livable on legacy code; failing open on infrastructure errors means the check can only ever block on genuine findings, never break a session.

## Alternatives

- Advisory-only reporting after the fact — residue accumulates faster than sessions clean it.
- Whole-file blocking — any legacy file becomes uneditable until fully clean, punishing unrelated edits.
- Failing closed on hook errors — session breakage as the price of an infrastructure hiccup.

## Proof

The lint binary's violation exit code — the signal the hook propagates to block — is asserted by the fixture test suite, and a violating edit in an integrated project visibly blocks in-turn. The hook wiring itself (change-scoping, fail-open paths) has no automated check; that gap is filed to the intake queue.
