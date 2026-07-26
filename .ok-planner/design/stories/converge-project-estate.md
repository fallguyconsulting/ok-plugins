---
story: converge-project-estate
---

# Converge my project's estate deliberately

## Story

As a project owner, I want one idempotent verb per plugin that bootstraps or repairs its project-side estate to match the installed plugin — migrating retired layouts and asking before touching anything that is mine — so that upgrades are deliberate, repeatable, and never destructive.

## Acceptance

The owner runs a plugin's lifecycle verb → on an empty project the estate is materialized whole; on a drifted project the plugin-owned layer is overwritten to match the installed version and retired layouts are migrated with bodies untouched; on a compliant project nothing changes at the git level; anything owner-declared or overlapping is surfaced for consent rather than silently converted. The diagnose-and-converge machinery of each plugin is real.

## Falsifier

Repeated runs churn the working tree; a hand-edited or owner-declared file is silently overwritten; a retired layout is left half-migrated or its archived records rewritten; or a missing estate fails to bootstrap.

## Proof

Demo — three consecutive runs on one project: a bootstrap from nothing, a repair after deliberate drift in a plugin-owned file, and a no-op on the resulting compliant estate, with the git status empty after the third.
