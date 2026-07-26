---
decision: no-execution-engine
---

# No plan artifact, no execution engine

## Choice

The planner ships no execution machinery and defines no plan artifact: a sprint is never rewritten into a plan, staging happens at execution time in the executor's own working state, and every sprint bakes a fixed execution-shape section plus the completion contract so it can be picked up inline, handed to a goal-driving harness mechanism, or dispatched to any orchestrator unchanged.

## Rationale

Executor-agnosticism through the artifact rather than through an engine: the contract is what does not scale away, while sequencing is planning that belongs to whoever does the work, at the moment they do it. The verification burden an engine would carry lives instead in the corpus itself (proofs with exhibited falsifiers) and the terminal gates.

## Alternatives

- A workflow engine with plan documents, gate pre-flight, and escalation taxonomy.
- A required orchestrator for sprint execution — forecloses the ordinary inline session as a first-class executor.

## Proof

Declared text-presence check: the no-plan-artifact commitment — a sprint is never rewritten into a plan document; staging lives in the executor's working state — stands verbatim in the planning ceremony's governing text and the materialized estate guidance. Falsifier: those lines deleted or reworded turn the presence check red. Declared as presence, not behavior.
