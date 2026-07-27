---
story: converge-project-estate
---

# Converge my project's estate deliberately

## Story

As a project owner, I want each family's project-side estate bootstrapped or repaired to match the suite version my machine carries — migrating retired layouts and asking before touching anything that is mine — so that upgrades are deliberate, repeatable, and never destructive.

## Acceptance

The front door administers a family → on an empty project the estate is materialized whole; on a drifted project the suite-owned layer is overwritten to match the carried version and retired layouts are migrated with bodies untouched; on a compliant project nothing changes at the git level; anything owner-declared or overlapping is surfaced for consent rather than silently converted. Each family's diagnose-and-converge machinery is real.

## Falsifier

Repeated runs churn the working tree; a hand-edited or owner-declared file is silently overwritten; a retired layout is left half-migrated or its archived records rewritten; or a missing estate fails to bootstrap.

## Proof

Demo — three consecutive administration passes on one project: a bootstrap from nothing, a repair after deliberate drift in a suite-owned file, and a no-op on the resulting compliant estate, with the git status empty after the third.
