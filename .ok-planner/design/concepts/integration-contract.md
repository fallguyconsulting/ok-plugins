---
concept: integration-contract
---

# Integration contract

## What it is

The integration contract is the suite's normative spine: the single set of conventions by which every integrable plugin meets a consumer project. It defines the layers of a plugin's presence — the committed project-side estate whose existence is the discovery marker, the always-in-context rules cheatsheet, the vendored skill set in the project's committed skills directory, hook wiring transcribed into the project's committed harness settings, and materialized support scripts — plus the ownership rule, the verb set and its collision rule, version stamps, and stack tailoring.

## Purpose

The contract is what makes the suite composable by a deliberately ignorant dispatcher: the front door — the term names the dispatcher plugin, and this Purpose is its canonical definition — knows the contract's two conventions, discovery markers and the uniform lifecycle verb, and nothing about any plugin's internals. A plugin needing special-casing has integrated wrong, not the dispatcher; new plugins must conform.

## Boundaries

The contract governs how integrable plugins meet consumer projects; it does not govern any plugin's interior behavior, and the user-scoped plugins — the front door and the conduct — never integrate, so it does not govern their presence on a machine. Repo-root machinery — the marketplace catalog, the contract's own document, the release tooling, the maintenance checks — is maintenance material and part of no plugin. Its layers are realized by neighboring concepts: estate, cheatsheet, skill, true-up, materialized-artifact, stack-profile. "Front door" has no concept of its own — this artifact defines it. The front door's own conduct is the contract's consumer-side realization (see also: one-command-suite-upkeep under stories).

## Invariants

- Every integrable plugin exposes the lifecycle verb — project-locally as one merged verb converging the whole integrated set; plugins with rules to check also expose a read-only compliance verb; plugins whose estate carries provable artifacts also expose a proof-running verb.
- Vendored verb names collide by rule, never by accident: the lifecycle verb materializes once, merged; any other verb name claimed by more than one integrated plugin materializes plugin-prefixed.
- Whether a project uses a plugin is a filesystem check, never an inference.
- Every discovery marker the dispatcher honors is documented in the contract; the contract, not the dispatcher, is where per-plugin knowledge lives.
- Nothing in any plugin may assume a specific consumer project.
