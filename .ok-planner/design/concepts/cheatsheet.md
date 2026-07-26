---
concept: cheatsheet
status: as-is
aliases:
  - rules layer
---

# Cheatsheet

## What it is

A cheatsheet is the one plugin-owned file each integrable plugin maintains in the consumer's always-in-context rules directory: the small, stable, condensed statement of the plugin's rules that every session sees, wholly owned and overwritten by the plugin's lifecycle verb — drift corrected by overwrite, never merge.

## Purpose

The cheatsheet is the layer that reaches contributors and sessions that never load a skill: committed to the project, it delivers the rules even to people without the plugin installed. Keeping it small and stable is what earns it permanent context residency.

## Boundaries

One file per plugin; the project's other rules files are never touched, per the ownership rule (see also: whole-file-ownership under decisions). Production varies by plugin — stamped template, byte-copy of a canonical document, or rendered from the committed profile (see also: stack-profile, materialized-artifact). The optional conduct output style is explicitly not this layer (see also: conduct).

## Invariants

- Wholly plugin-owned: local edits are not preserved.
- Content is a condensation of rules canonical elsewhere, never the canonical statement itself.
