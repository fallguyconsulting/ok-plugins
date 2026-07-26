---
story: safe-workspace-teardown
status: as-is
---

# Close a workspace without ever losing work

## Story

As a project owner, I want workspace teardown gated on a clean tree and a merged branch — with my explicit word as the only override — so that closing a finished job can never destroy uncommitted or unmerged work.

## Acceptance

The owner (or an orchestrator finishing a job) closes a named workspace → the clean-tree gate and the merged-branch gate are checked first, and a failing gate stops the close with exactly what is dirty or unmerged, the fix being the owner's act in that workspace; on passing gates the job's runtime is torn down scoped to its own namespace, the worktree is removed and the branch deleted using only non-forcing commands that themselves fail if the gates lied, and the report names the merge commit the work survives in. Only the user's explicit "close it anyway, discard the work" overrides a gate, and then exactly that and nothing broader.

## Falsifier

A close discards uncommitted or unmerged work; a gate is bypassed on the agent's own judgment; teardown reaches beyond the workspace's own runtime namespace; or a forced removal succeeds where a gate had failed.

## Proof

Demo — a close attempt on a workspace with uncommitted changes stopping at the first gate with the dirty paths named, followed by a clean, merged workspace closing completely, with a third party able to locate the surviving merge commit.
