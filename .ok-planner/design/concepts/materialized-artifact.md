---
concept: materialized-artifact
aliases:
  - vendored binary
  - materialization
---

# Materialized artifact

## What it is

A materialized artifact is a project-side copy of a plugin-canonical file — a support script, hook implementation, lint binary, cheatsheet, or context payload — written into the consumer project by the lifecycle verb, version-stamped with the plugin version that wrote it, executable where relevant, and overwritten wholesale on converge. Vendoring is the same act applied to an executable binary.

## Purpose

Materialization is what pins behavior per project: a project runs what it was converged to, updating the installed plugin changes nothing anywhere until each owner converges deliberately, and editing a plugin cannot disturb a session running in another project. The stamp makes version drift mechanically checkable.

## Boundaries

Materialized artifacts are plugin-owned whole files, never hand-edited; the only thing that legitimately runs from the plugin copy is the lifecycle verb's own entry point, plus bootstrap verbs that by definition run before anything is vendored (see also: true-up, per-project-pinning under decisions). Plugin-root hook files are deliberately not behavior — they are shims to the materialized hooks (see also: hook-shims under decisions). Owner-declared configuration is the neighbor that is never materialized wholesale (see also: stack-profile).

## Invariants

- Every materialized artifact records the version of the plugin that wrote it.
- Diagnosis verifies fidelity against the canonical copy for the installed version — stamp comparison as the norm, byte-identity as the stricter check reserved for artifacts whose exact derivation is itself the guarantee (see also: content-addressed-src-tag under decisions).
- A vendored executable is proven to run at materialization time; one that cannot run is worse than none.
