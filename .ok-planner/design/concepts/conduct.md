---
concept: conduct
status: as-is
aliases:
  - ok-conduct
---

# Conduct

## What it is

The conduct is the suite's optional behavioral layer: an output style layered on the harness defaults that governs delivery and working discipline — brevity, no time estimates, prose questions, grounded claims, one-concept-per-turn delivery, tight lists, running unsupervised, completeness as the floor with overshoot the only legal divergence, never destroying uncommitted work, and staying out of the planner's estate unless directed there.

## Purpose

The conduct standardizes how agents behave and deliver across sessions regardless of which skill is active. Because attention to a session-start style decays, it is re-anchored every turn by a materialized reminder hook, and its most load-bearing rules are deliberately duplicated into sprint boilerplate and skill prompts so non-conduct sessions still receive them.

## Boundaries

The conduct is an additional, optional delivery-style layer — explicitly not the always-in-context rules layer (see also: cheatsheet). It yields to skills that define their own dialogue protocols or autonomous scopes. It carries its own hand-managed version, independent of the suite version, bumped only when its body changes; the stamp is read at materialization and echoed by the session banner and the version verbs (see also: see-governing-versions under stories, lockstep-suite-version under decisions).

## Invariants

- The conduct version is independent of the suite version and untouched by a release; a release only warns when the body changed without a bump.
- The version stamp stays in the body with a fixed prefix, because tooling reads it from there.
- Nothing activates the conduct automatically and no skill depends on it being active.
