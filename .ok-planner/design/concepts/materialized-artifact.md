---
concept: materialized-artifact
aliases:
  - vendored binary
  - materialization
---

# Materialized artifact

## What it is

A materialized artifact is a project-side copy of a family-canonical file — a skill file, support script, hook implementation, lint binary, cheatsheet, or context payload — written into the consumer project by the front door's administration, version-stamped with the suite version that wrote it, executable where relevant, and overwritten wholesale on converge. Vendoring is the same act applied to an executable binary.

## Purpose

Materialization is what pins behavior per project: a project runs what it was converged to, updating the front-door plugin changes nothing anywhere until each owner converges deliberately, and editing the suite's source cannot disturb a session running in another project. The stamp makes version drift mechanically checkable.

## Boundaries

Materialized artifacts are suite-owned whole files, never hand-edited. Hooks execute from the project's own materialized copies, reached through wiring transcribed into the project's committed harness settings — never from the front door's carried payload (see also: vendored-skills under decisions). The things that legitimately run from the payload are the administration process itself — diagnosis, bootstrap, and converge run before or while the project copies are being written — and read-only advisory verbs falling back with an announcement (see also: true-up under concepts; per-project-pinning under decisions). Owner-declared configuration is the neighbor that is never materialized wholesale (see also: stack-profile).

## Invariants

- Every materialized artifact records the version of the payload that wrote it, except a fixed-content artifact — one whose bytes never vary across suite versions — whose fidelity diagnosis verifies by exact content instead; content equality outperforms what the stamp exists to provide.
- Diagnosis verifies fidelity against the canonical copy for the carried version — stamp comparison as the norm, byte-identity as the stricter check reserved for artifacts whose exact derivation is itself the guarantee (see also: content-addressed-src-tag under decisions).
- A vendored executable is verified to run at materialization time; one that cannot run is worse than none.
