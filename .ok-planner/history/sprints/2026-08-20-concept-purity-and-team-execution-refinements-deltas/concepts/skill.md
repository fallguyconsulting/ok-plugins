---
concept: skill
---

# Skill

## What it is

A skill is one named prompt file whose body is executable substance: process steps, embedded subagent prompts, verbatim command blocks, output formats, and a closing enumeration of what it does NOT do. Skills are the suite's verbs: authored inside a skill family, or in the suite's own ceremony layer where the verb belongs to no family, and vendored into the consumer project by the front door's administration.

## Purpose

Treating prompt text as code is what makes a methodology shippable without a runtime: the skill is simultaneously the implementation, the documentation, and the contract of a verb. The negative-behavior section is load-bearing where it traces to a real failure or boundary confusion — it bounds each verb as sharply as its positive steps.

## Boundaries

Skills split into two activation classes: user-facing skills, which a person activates deliberately, and plumbing skills, which other suite machinery drives (see also: slash-only-activation under decisions). A user-facing skill may widen its activator to a named non-human caller, such as whoever executes a completion contract (see also: completion-contract). The project's skills directory is a flat namespace, so vendored names follow the contract's collision rule (see also: integration-contract). Skills do not chain into pipelines; each is terminal at its own artifact. A family may additionally ship an index skill — a router and briefing, not a verb (see also: session-awareness under stories). Neither administration nor the ceremonies is a family's skill contribution: families expose conventional contributions — converge cores, administration documents, ceremony contributions — and neither lifecycle verbs nor ceremony verbs of their own (see also: true-up, integration-contract). Canonical shared rule text is transcluded (see also: single-source-transclusion under decisions).
