---
concept: run-tag
---

# Run tag

## What it is

A run tag is the identifier one verification run mints for itself. The run builds every artifact it verifies under that tag. No other run uses the value. Verification paths resolve artifacts by it.

## Purpose

A tag unique to the run gives verification two properties. Concurrent runs cannot collide on an artifact or on a stack. A run that builds and then verifies under one tag cannot resolve an artifact an earlier run left behind, so staleness is unrepresentable rather than avoided. No derivation has to define which files count as the tree.

## Boundaries

The tag names artifact and stack identity for verification; wiring it into builds, stacks, and harnesses is deliberately the project's own change, guided by the rules layer (see also: materialized-artifact, cheatsheet). The concrete derivation is recorded as a decision (see also: per-run-artifact-tag under decisions), and so is how a stack's ports are found by the tag (see also: os-assigned-ports-read-back-by-run-tag under decisions).
