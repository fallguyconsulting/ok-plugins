---
concept: skill
status: as-is
---

# Skill

## What it is

A skill is one named prompt file inside a plugin whose markdown body is executable substance: process steps, embedded subagent prompts, verbatim command blocks, output formats, and a closing enumeration of what it does NOT do. Skills are the suite's verbs; consumers drive them by slash command, and machinery drives the plumbing class through the skill-invocation tool.

## Purpose

Treating prompt text as code is what makes a methodology shippable without a runtime: the skill is simultaneously the implementation, the documentation, and the contract of a verb. The negative-behavior section is load-bearing — it bounds each verb as sharply as its positive steps.

## Boundaries

Skills split into two activation classes: user-facing skills declare themselves activated only by their explicit slash command, never auto-triggered by conversation content — some widening the activator to a named non-human caller such as whoever executes a completion contract (see also: completion-contract) — and plumbing skills drop that restriction so other machinery can drive them. Skills do not chain into pipelines; each is terminal at its own artifact. Two plugins additionally ship an index skill — a briefing, not a verb — injected into sessions at start (see also: session-awareness under stories). Canonical shared rule text is transcluded, never restated (see also: single-source-transclusion under decisions).

## Invariants

- The explicit-activation phrasing on user-facing skills is deliberate and preserved on new skills; inferential invocation is forbidden.
- A skill's negative-behavior list binds as strongly as its steps.
