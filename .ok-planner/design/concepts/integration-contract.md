---
concept: integration-contract
---

# Integration contract

## What it is

The integration contract is the suite's normative spine: the single set of conventions by which every plugin integrates into a consumer project. It defines the three layers of a plugin's presence — the committed project-side estate whose existence is the discovery marker, the always-in-context rules cheatsheet, and the skills as uniform verbs — plus the ownership rule, the verb set, version stamps, support-script materialization, hook shims, and stack tailoring.

## Purpose

The contract is what makes the suite composable by a deliberately ignorant dispatcher: the front door — the term names the dispatcher plugin, and this Purpose is its canonical definition — knows the contract's two conventions, discovery markers and the uniform lifecycle verb, and nothing about any plugin's internals. A plugin needing special-casing has integrated wrong, not the dispatcher; new plugins must conform.

## Boundaries

The contract governs how plugins meet consumer projects; it does not govern any plugin's interior behavior. Its layers are realized by neighboring concepts: estate, cheatsheet, skill, true-up, materialized-artifact, stack-profile. "Front door" has no concept of its own — this artifact defines it. The front door's own conduct is the contract's consumer-side realization (see also: one-command-suite-upkeep under stories).

## Invariants

- Every integrable plugin exposes the lifecycle verb; plugins with rules to check also expose a read-only compliance verb; plugins whose estate carries provable artifacts also expose a proof-running verb.
- Whether a project uses a plugin is a filesystem check, never an inference.
- The contract, not the dispatcher, is where per-plugin knowledge is documented.
