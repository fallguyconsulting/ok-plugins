---
concept: conduct
aliases:
  - ok-conduct
---

# Conduct

## What it is

The conduct is the suite's optional behavioral layer, shipped as its own user-scoped plugin: an output style layered on the harness defaults that governs delivery and working discipline — brevity, no time estimates, prose questions, grounded claims, one-concept-per-turn delivery, tight lists, running unsupervised, completeness as the floor with overshoot the only legal divergence, never destroying uncommitted work, and staying out of the planner's estate unless directed there.

## Purpose

The conduct standardizes how the assistant behaves and delivers for the user who chose it, across every project and session, regardless of which skill is active. Because attention to a session-start style decays, the conduct plugin's own reminder hook re-anchors it every turn, and its most load-bearing rules are deliberately duplicated into sprint boilerplate so executors without the conduct still receive them.

## Boundaries

The conduct is personal, not project infrastructure: chosen and installed by a user for themselves, never vendored into a project, never another plugin's dependency, and never pinned by a project's committed configuration. It is explicitly not the always-in-context rules layer (see also: cheatsheet). It yields to skills that define their own dialogue protocols or autonomous scopes. It carries its own hand-managed version, independent of the suite version, bumped only when its body changes; the stamp is read from the body by the version verbs and the conduct plugin's own announcements (see also: see-governing-versions under stories, lockstep-suite-version under decisions).

## Invariants

- The conduct version is independent of the suite version and untouched by a release; a release only warns when the body changed without a bump.
- The version stamp stays in the body with a fixed prefix, because tooling reads it from there.
- Nothing activates the conduct automatically and no skill depends on it being active.
- Installing the suite never installs the conduct; the choice is the user's alone.
