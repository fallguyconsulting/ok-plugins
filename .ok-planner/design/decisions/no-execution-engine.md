---
decision: no-execution-engine
status: as-is
---

# No plan artifact, no execution engine

## Choice

The planner ships no execution machinery and defines no plan artifact: a sprint is never rewritten into a plan, staging happens at execution time in the executor's own working state, and every sprint bakes a fixed execution-shape section plus the completion contract so it can be picked up inline, handed to a goal-driving harness mechanism, or dispatched to any orchestrator unchanged.

## Rationale

Executor-agnosticism through the artifact rather than through an engine: the contract is what does not scale away, while sequencing is planning that belongs to whoever does the work, at the moment they do it. This reverses the suite's own earlier flip-gated execution engine, whose verification burden moved into the corpus itself (proofs with exhibited falsifiers) and the terminal gates.

## Alternatives

- A workflow engine with plan documents, gate pre-flight, and escalation taxonomy — the suite's own pre-4.0 architecture, retired.
- A required orchestrator for sprint execution — forecloses the ordinary inline session as a first-class executor.

## Proof

No enforcing check exists today: nothing fails if a plan artifact or execution skill reappears; the choice is visible only as the absence of such machinery. Filed to the intake queue for owner calibration.
