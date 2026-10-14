---
concept: materialized-artifact
aliases:
  - vendored binary
  - materialization
---

# Materialized artifact

## What it is

A materialized artifact is a project-side copy of a canonical file the front door carries, written into the consumer project by the front door's administration and overwritten wholesale on true-up. Vendoring is the same act applied to an executable binary.

## Purpose

Materialization is what pins behavior per project: a project runs what it was trued up to, updating the front-door plugin changes nothing anywhere until each owner trues the project up deliberately, and editing the suite's source cannot disturb a session running in another project.

## Boundaries

Materialized artifacts are suite-owned whole files. A file rendered from the project's own declared choices is still materialized: the choices are an input, and true-up rewrites the file whole (see also: cheatsheet). What legitimately runs from the payload instead — the administration process itself — belongs to the pinning rule (see also: true-up; per-project-pinning and vendored-skills under decisions). Owner-declared configuration is the neighbor that is not materialized wholesale (see also: estate).
