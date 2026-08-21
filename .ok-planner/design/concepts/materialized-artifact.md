---
concept: materialized-artifact
aliases:
  - vendored binary
  - materialization
---

# Materialized artifact

## What it is

A materialized artifact is a project-side copy of a canonical file the suite carries — a family's, or the suite's own — written into the consumer project by the front door's administration, version-stamped with the suite version that wrote it, and overwritten wholesale on converge. Vendoring is the same act applied to an executable binary.

## Purpose

Materialization is what pins behavior per project: a project runs what it was converged to, updating the front-door plugin changes nothing anywhere until each owner converges deliberately, and editing the suite's source cannot disturb a session running in another project. The stamp makes version drift mechanically checkable.

## Boundaries

Materialized artifacts are suite-owned whole files. Hooks execute from the project's own materialized copies (see also: vendored-skills under decisions). What legitimately runs from the payload instead — the administration process itself, and read-only advisory verbs — belongs to the pinning rule (see also: true-up; per-project-pinning under decisions). Owner-declared configuration is the neighbor that is not materialized wholesale (see also: stack-profile).
