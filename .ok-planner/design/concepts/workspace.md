---
concept: workspace
---

# Workspace

## What it is

A workspace is one job's isolated place of work: its own checkout on its own branch under profile-declared naming, plus its own namespaced runtime stack, per the committed profile.

## Purpose

Workspaces are what make parallel agent work non-colliding: concurrent jobs cannot fight over files, container names, networks, volumes, or ports, and no job ever works on the main checkout. The discipline is stack-invariant; the profile tailors its realization.

## Boundaries

A workspace owns a job's checkout, branch, and runtime namespace for the job's lifetime, from gated open to safety-gated close (see also: isolated-parallel-workspaces, safe-workspace-teardown under stories). The naming and location come from the profile (see also: stack-profile); artifact identity within verification belongs to the run tag (see also: run-tag).
