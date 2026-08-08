---
concept: skill-family
aliases:
  - family
---

# Skill family

## What it is

A skill family is the suite's unit of project-scoped distribution: a
self-contained directory of skills, templates, support scripts, and the
conventional surfaces the suite drives, carried whole as payload inside
the front-door plugin and delivered into consumer projects as committed,
vendored files. A family is not a plugin: nothing family-scoped installs
machine-globally, and consumers meet a family only through its vendored
presence in their project.

## Purpose

The family is the shape that gives every project its own version of the
suite's behavior: installing one user-scoped plugin puts every family's
canonical source on the machine, and each project owner converges
deliberately from that payload. It also fixes where knowledge lives —
everything specific to a family, from converge mechanics to migration
judgment to what its corpus needs from a ceremony, belongs to the
family's own directory, so the suite grows by adding a conforming
directory rather than by editing its administrator or its ceremonies.

## Boundaries

A family owns its skills, its estate's shape, its cheatsheet, and its
conventional surfaces — administration and ceremony (see also: estate,
cheatsheet, skill, true-up). It does NOT own its own delivery:
vendoring, wiring, and upkeep are the front door's administration,
driven through the contract's conventional surfaces (see also:
integration-contract, one-command-suite-upkeep under stories). It does
NOT own the ceremonies that reach its corpus: planning, certification,
and audit are suite-owned verbs that drive the family's ceremony
surface. The plugin system carries only the user-scoped plugins — the
front door that carries the families, and the personal conduct (see
also: conduct).

## Invariants

- Families travel only as front-door payload and reach projects only by
  vendoring; no family is separately installable.
- Every family exposes the contract's conventional surfaces, and
  family-specific knowledge lives nowhere but the family's directory.
- Whether a project uses a family is a filesystem check against its
  committed markers, never an inference.
