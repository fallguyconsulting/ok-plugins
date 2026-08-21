---
concept: run-tag
aliases:
  - per-run tag
---

# Run tag

## What it is

A run tag is the artifact identifier one verification run mints for itself. The run builds every artifact it verifies under that tag. No other run uses the value. Verification paths resolve artifacts by it.

## Purpose

A tag unique to the run gives verification two properties. Concurrent runs and concurrent workspaces cannot collide on an artifact. A run that builds and then verifies under one tag cannot resolve an artifact an earlier run left behind, so staleness is unrepresentable rather than avoided. No derivation has to define which files count as the tree.

## Boundaries

The tag names artifact identity for verification; wiring it into builds and harnesses is deliberately the project's own change, guided by the rules layer (see also: workspace, materialized-artifact). The concrete derivation is recorded as a decision (see also: per-run-artifact-tag under decisions).
