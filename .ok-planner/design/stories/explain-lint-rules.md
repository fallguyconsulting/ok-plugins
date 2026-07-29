---
story: explain-lint-rules
---

# Learn what a lint rule means without reading the linter

## Story

As someone meeting a lint violation I do not recognise, I want the canonical definition and examples for the rule that fired, so that I can decide whether to fix the code or change the configuration without reading the linter's source.

## Acceptance

The reader asks about a check code or a configuration topic → they receive that rule's canonical definition and worked examples, drawn from the project's own committed lint so the explanation matches the rules that project actually enforces; asking without a topic lists what can be explained. The definitions delivered are the lint's own, not a separately maintained restatement of them.

## Falsifier

An explained rule's description contradicts what the lint enforces; a check code the lint can emit has no explanation; the explanation is a hand-maintained copy that drifts from the rules it describes; or the reader must read the lint's source to learn what a code means.

## Proof

Demo — a check code taken from a real lint run and explained; the explanation's stated behavior confirmed by a run that triggers the rule and then satisfies it; and the topic listing covering every check code the lint can emit.
