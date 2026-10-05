---
decision: no-execution-engine
---

# No plan artifact, no workflow engine

## Choice

The planner defines no plan artifact and ships no workflow engine. A sprint is never rewritten into a plan: the executor stages the work at execution time, from the sprint and the code as they stand. Every sprint bakes a fixed execution-shape section plus the completion contract, so it can be picked up inline, handed to a goal-driving harness mechanism, or dispatched to any orchestrator unchanged. The suite ships a task tracker and a drain loop that every executor runs on: the executor files its stages as tasks, and the drain starts one fresh agent per task. Every agent of one profile starts from one identical message, so the run shares one cached prefix per profile. Neither one plans, gates, or judges: the tracker records what the executor filed and what each agent did, and the drain runs what the tracker holds.

## Rationale

Executor-agnosticism through the artifact rather than through an engine: the contract is what does not scale away, while sequencing is planning that belongs to whoever does the work, at the moment they do it. The verification burden an engine would carry lives instead in sprint certification and the project's lint and type checks. The tracker and the drain carry no planning, so they leave that line where it is. They exist for what every executor needs alike: a record of the run that a replacement session can read, and fresh agents that start from one cached prefix per profile instead of one standing agent fed by message.

## Alternatives

- A workflow engine with plan documents, gate pre-flight, and escalation taxonomy.
- A required orchestrator for sprint execution — forecloses the ordinary inline session as a first-class executor.
- No shared tracker, each executor dispatching and recording in its own way — every executor rebuilds the record, and a replacement session has nothing to read.
