---
decision: edit-hook-blocks-in-turn
---

# The edit hook blocks in-turn, scoped to changed lines, and never breaks a session

## Choice

Lint enforcement runs as a post-edit hook that blocks the agent in the same turn on violations. It checks the file each call of a file-editing tool names — Edit, Write, MultiEdit, and NotebookEdit, a notebook's code cells included — and checks nothing after any other tool's call, a shell command and a file read among them. An edit made any other way waits for the review-time lint, and the rules tell agents to make file edits through the file-editing tools. The check runs only within the edited file's changed line ranges for tracked files (untracked files, and files outside any repository, checked whole), and every hook failure path (missing input, no vendored binary, spawn error) degrades to a silent pass.

## Rationale

Blocking in-turn is the only moment the fix is free — the agent sees the message with the edit still in hand. Scoping to the change keeps pre-existing debt from blocking unrelated work, which is what makes strict enforcement livable on legacy code; failing open on infrastructure errors means the check can only ever block on genuine findings, never break a session. Limiting the check to the tools that name the file they edit keeps it scoped to the agent's own change: a shell command names no file, and checking every file git reports changed after one would lint the whole changed tree and block on edits the agent did not make. A file read changes nothing, so it has nothing to check.

## Alternatives

- Advisory-only reporting after the fact — residue accumulates faster than sessions clean it.
- Whole-file blocking — any legacy file becomes uneditable until fully clean, punishing unrelated edits.
- Failing closed on hook errors — session breakage as the price of an infrastructure hiccup.
- Check every file git reports changed after each shell command — shell edits are checked too, at a status and a diff on every shell call, and the hook blocks on changes another process made.
- Leave notebooks out of the file-editing tools — no notebook grammar to keep, and residue written through a notebook lands unchecked until review.
