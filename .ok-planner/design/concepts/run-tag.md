---
concept: run-tag
---

# Run tag

## What it is

A run tag is the identifier one verification run mints for itself. The run builds every artifact it verifies under that tag. No other run uses the value. Verification paths resolve artifacts by it.

## Purpose

A tag unique to the run gives verification two properties. Concurrent runs cannot collide on an artifact or on a stack. A run that builds and then verifies under one tag cannot resolve an artifact an earlier run left behind, so staleness is unrepresentable rather than avoided. No derivation has to define which files count as the tree. The tag also marks what each run built, so whatever a run leaves behind can be found by its tag and removed.

## Boundaries

The tag names artifact and stack identity for verification. The concrete derivation is recorded as a decision (see also: per-run-artifact-tag under decisions), and so are the tool that runs each run from start to end (see also: stack-tool-runs-each-run under decisions), how a run's artifacts are recorded and removed (see also: run-artifacts-recorded-by-the-stack-tool, run-artifacts-removed-with-the-run under decisions), and how a stack's host ports are tied to the tag (see also: ports-leased-from-a-project-range under decisions).
