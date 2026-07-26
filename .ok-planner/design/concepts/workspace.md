---
concept: workspace
status: as-is
---

# Workspace

## What it is

A workspace is one job's isolated place of work: its own checkout on its own branch under profile-declared naming, plus its own namespaced runtime stack — a per-job container project, a reserved port block, or nothing, per the committed profile. The workspace discipline is three rules that travel together: one worktree per job, one isolated runtime per worktree, content-addressed artifacts — each rule making the next one safe.

## Purpose

Workspaces are what make parallel agent work non-colliding: concurrent jobs cannot fight over files, container names, networks, volumes, or ports, and no job ever works on the main checkout. The discipline is stack-invariant; the profile tailors its realization.

## Boundaries

A workspace owns a job's checkout, branch, and runtime namespace for the job's lifetime, from gated open to safety-gated close (see also: isolated-parallel-workspaces, safe-workspace-teardown under stories). The naming and location come from the profile (see also: stack-profile); artifact identity within verification belongs to the content-addressed tag (see also: content-addressed-tag). A worktree is the git mechanism; the workspace is the worktree plus its isolation.

## Invariants

- A workspace is never reused or clobbered: opening stops if its directory or branch already exists.
- A workspace's worktree is the only record of its uncommitted work; teardown must be incapable of destroying it.
- Only files invisible to version control carry over on open; tracked files come with the worktree.
