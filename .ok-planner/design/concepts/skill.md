---
concept: skill
---

# Skill

## What it is

A skill is one named prompt file whose markdown body is executable substance: process steps, embedded subagent prompts, verbatim command blocks, output formats, and a closing enumeration of what it does NOT do. Skills are the suite's verbs: authored inside a skill family, or in the suite's own ceremony layer where the verb belongs to no family, and vendored by the front door's administration into the consumer project's committed skills directory, where consumers drive them by slash command and machinery drives the plumbing class through the skill-invocation tool.

## Purpose

Treating prompt text as code is what makes a methodology shippable without a runtime: the skill is simultaneously the implementation, the documentation, and the contract of a verb. The negative-behavior section is load-bearing where it traces to a real failure or boundary confusion — it bounds each verb as sharply as its positive steps.

## Boundaries

Skills split into two activation classes: user-facing skills declare themselves activated only by their explicit slash command, never auto-triggered by conversation content — some widening the activator to a named non-human caller such as whoever executes a completion contract (see also: completion-contract) — and plumbing skills drop that restriction so other machinery can drive them; a skill belongs to the plumbing class only while another suite surface is documented to drive it (see also: slash-only-activation under decisions). The project's skills directory is a flat namespace, so vendored names follow the contract's collision rule (see also: integration-contract). Skills do not chain into pipelines; each is terminal at its own artifact. A family may additionally ship an index skill — a router and briefing, not a verb, its per-skill rows single-sourced from the skills' own descriptions (see also: session-awareness under stories). Neither administration nor the ceremonies is a family's skill surface: families expose conventional surfaces — converge cores, administration documents, ceremony surfaces — and neither lifecycle verbs nor ceremony verbs of their own (see also: true-up, integration-contract). Canonical shared rule text is transcluded, never restated (see also: single-source-transclusion under decisions).

## Invariants

- The explicit-activation phrasing on user-facing skills is deliberate and preserved on new skills; inferential invocation is forbidden.
- A skill's negative-behavior list binds as strongly as its steps, and every entry traces to an observed failure or a genuine boundary confusion — never a mere negation of the skill's own description.
- A vendored skill is a materialized artifact: version-stamped, suite-owned, overwritten on converge, never hand-edited (see also: materialized-artifact).
