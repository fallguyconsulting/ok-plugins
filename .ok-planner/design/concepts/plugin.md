---
concept: plugin
---

# Plugin

## What it is

A plugin is the suite's unit of distribution: a self-contained directory carrying a manifest, a tree of skill prompt files, and optionally hooks, support scripts, documentation, and an output style. The suite ships no application runtime — the executable substance is prompt text and small support tools — and each plugin owns exactly one concern: what to build, how code reads, where work happens, or the suite front door.

## Purpose

One concern per plugin lets consumers adopt à la carte while the front door composes them uniformly. The manifest-with-dependencies pattern makes installing the front door pull the whole set, without the plugins needing knowledge of each other.

## Boundaries

A plugin owns everything a consumer receives; repo-root machinery — the marketplace catalog, the normative contract, the release tooling — is maintenance material and part of no plugin. Integrable plugins additionally materialize a project-side estate and conform to the integration contract (see also: integration-contract, estate); the front door deliberately has no estate and is never integrated. The behavior itself lives in skills (see also: skill).

## Invariants

- Every plugin carries the same suite version at every release, converged and stamped by the release procedure (see also: lockstep-suite-version under decisions).
- A plugin that would need the front door to special-case it has integrated wrong.
- Nothing in any plugin may assume a specific consumer project.
