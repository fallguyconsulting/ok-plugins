---
audit: teardown-gates-in-git-flags
artifact: decision:teardown-gates-in-git-flags
determination: satisfied
audited: 2026-07-29T13:13:38Z
artifact-hash: sha256:207d23beff27
---

# Teardown uses only the non-forcing git commands, so it cannot complete against a dirty tree or an unmerged branch

## Confirmation

Satisfied.

- **Only the non-forcing forms are used.** The teardown sequence is `git
  worktree remove <dir>` and `git branch -d <branch>`, each stated with the
  reason the forcing variant is absent: a force need means a gate lied, so
  the response is to stop and re-check.
- **No forcing flag exists anywhere in the family.** The population is the
  family's verbs, enumerated from `vendored-skills.js` — the registry that
  decides which skills reach a consumer project (`audit`, `close`,
  `ok-workspaces`, `open`); `close` is the only one that tears anything down.
  Across the whole family directory the only occurrences of `--force` or `-D`
  are the two prohibitions themselves: the `close` verb's parenthetical and
  the family constraint forbidding such paths.
- **The commands themselves are the backstop, exercised.** `demo.sh` asserts
  that `git worktree remove` fails on a workspace with an uncommitted edit,
  and that `git branch -d` fails on a branch with unmerged commits — both
  without any force flag. It then merges, asserts both gates now pass, and
  runs the same two commands successfully, confirming the merged work
  survives as an ancestor of HEAD.

## Citations

- cite-node: plugins/ok/families/ok-workspaces/skills/close/SKILL.md#close-a-workspace.teardown-only-after-both-gates-pass @ sha256:4320ae67416a
- cite-node: plugins/ok/families/ok-workspaces/skills/close/SKILL.md @ sha256:81ff352d2b1d
- cite-node: plugins/ok/families/ok-workspaces/scripts/vendored-skills.js @ sha256:fb2484ade4e1
- cite-node: plugins/ok/families/ok-workspaces/CLAUDE.md#claude-md.constraints @ sha256:8a95853ff138
- cite-node: plugins/ok/families/ok-workspaces/test/demo.sh @ sha256:de713b342666
