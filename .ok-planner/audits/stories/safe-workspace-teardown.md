---
audit: safe-workspace-teardown
artifact: story:safe-workspace-teardown
determination: satisfied
audited: 2026-07-29T13:13:38Z
artifact-hash: sha256:b12e1f83a57a
---

# Workspace teardown is gated on a clean tree and a merged branch, overridable only by the owner

## Confirmation

Satisfied.

- **Both gates exist and precede any teardown.** The `close` verb states
  them as the two conditions that must pass before anything is removed:
  `git -C <worktree> status --porcelain` empty, and the job branch fully
  contained in the integration branch — the branch the remote itself
  reports via `git ls-remote --symref origin HEAD`, never a guess, with a
  named fallback when there is no remote.
- **The gates hold end to end.** `demo.sh` drives a sandbox repository whose
  origin HEAD deliberately names `integration` rather than `main`: it
  asserts the resolved branch is what the remote reports and is not the
  common guess; it dirties a workspace and asserts the dirty path is named
  and that `git worktree remove` refuses; it commits unmerged work on the
  second job and asserts `git branch --merged` does not list it, `git cherry`
  reports unmerged commits, and `git branch -d` refuses. After merging, it
  asserts both gates pass, tears the workspace down with the non-forcing
  commands, and asserts the merge commit is still an ancestor of HEAD — the
  work survived the close.
- **The owner's explicit word is the only override.** Realized in the
  `close` verb's prose: no gate may be bypassed on the agent's own judgment,
  and the user saying to close anyway and discard the work is the sole
  override, scoped to exactly that.

## Citations

- cite-node: plugins/ok/families/ok-workspaces/skills/close/SKILL.md#close-a-workspace.gates-all-must-pass-before-any-teardown @ sha256:107760511bf2
- cite-node: plugins/ok/families/ok-workspaces/skills/close/SKILL.md#close-a-workspace.teardown-only-after-both-gates-pass @ sha256:4320ae67416a
- cite: plugins/ok/families/ok-workspaces/skills/close/SKILL.md :: "Never bypass a gate on your own judgment. The user saying "close it anyway, discard the work" is the only override, and then you do exactly that and nothing broader."
- cite-node: plugins/ok/families/ok-workspaces/test/demo.sh @ sha256:de713b342666
