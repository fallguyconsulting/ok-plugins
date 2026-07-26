---
story: isolated-parallel-workspaces
---

# Open isolated workspaces for parallel jobs

## Story

As a project owner running parallel agent jobs, I want each job opened in its own checkout on its own branch with its own namespaced runtime, so that concurrent jobs cannot collide on files, containers, volumes, or ports — and none of them ever works on my main checkout.

## Acceptance

The owner (or an orchestrator starting a job) opens a named job → a new worktree and branch are created under the committed profile's naming, only version-control-invisible local files carry over, the runtime is namespaced per the profile — a per-job container project name or a reserved port block — and the report names path, branch, and namespace with the reminder that work happens in the worktree; an existing directory or branch stops the open rather than being reused. Reporting of discipline residue is the compliance-report outcome, not this story's (see also: rules-compliance-report).

## Falsifier

Two concurrent jobs share a tree, container namespace, or port; an existing workspace is clobbered or reused; job work lands on the main checkout; or a second workspace cannot start without editing the first.

## Proof

Demo — two jobs opened side by side whose checkouts, branches, and runtime namespaces a third party can verify are disjoint, both stacks startable simultaneously, plus an open of an already-existing job name stopping with a report.
