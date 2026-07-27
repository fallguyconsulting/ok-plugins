---
concept: cheatsheet
aliases:
  - rules layer
---

# Cheatsheet

## What it is

A cheatsheet is the one suite-owned file each integrated skill family maintains in the consumer's always-in-context rules directory: the small, stable, condensed statement of the family's rules that every session sees, wholly owned and overwritten by the front door's administration — drift corrected by overwrite, never merge.

## Purpose

The cheatsheet is the layer that reaches contributors and sessions that never load a skill: committed to the project, it delivers the rules even to people with nothing installed. Keeping it small and stable is what earns it permanent context residency.

## Boundaries

One file per family; the project's other rules files are never touched, per the ownership rule (see also: whole-file-ownership under decisions). Production varies by family — stamped template, byte-copy of a canonical document, or rendered from the committed profile (see also: stack-profile, materialized-artifact). The optional conduct output style is explicitly not this layer (see also: conduct).

## Invariants

- Wholly suite-owned: local edits are not preserved.
- Content is a condensation of rules canonical elsewhere, never the canonical statement itself.
