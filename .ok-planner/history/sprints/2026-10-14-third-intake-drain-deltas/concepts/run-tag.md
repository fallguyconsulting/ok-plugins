---
concept: run-tag
---

# Run tag

## What it is

A run tag is the identifier one verification run mints for itself. The run builds every artifact it verifies under that tag. No other run uses the value. Verification paths resolve artifacts by it.

## Purpose

A tag unique to the run gives verification two properties. Concurrent runs cannot collide on an artifact or on a stack. A run that builds and then verifies under one tag cannot resolve an artifact an earlier run left behind, so staleness is unrepresentable rather than avoided. No derivation has to define which files count as the tree. The tag also marks what each run built, so whatever a run leaves behind can be found by its tag and removed.

## Boundaries

The tag names artifact and stack identity for verification; how the tag reaches builds, stacks, and harnesses is the rules layer's (see also: materialized-artifact, cheatsheet). The concrete derivation is recorded as a decision (see also: per-run-artifact-tag under decisions), and so are the removal of a run's artifacts (see also: run-artifacts-removed-with-the-run under decisions) and how a stack's host ports are tied to the tag (see also: ports-leased-from-a-project-range under decisions).
