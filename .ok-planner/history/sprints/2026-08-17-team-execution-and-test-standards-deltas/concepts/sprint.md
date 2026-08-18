---
concept: sprint
---

# Sprint

## What it is

A sprint is the planning ceremony's terminal artifact: a
change-order against the design corpus, expressed as final-form
corpus deltas plus the flat, unordered work items that realize them,
terminated by a fixed completion contract. It is a sprint in the
scrum sense — a collection of potentially disparate changes with no
required unifying focus and no manufactured narrative.

## Purpose

The sprint is the whole interface between planning and execution.
Because it is self-sufficient — everything the work needs, in final
form — any executor works from the same brief: an inline session
running the execution shape's team, a fan-out of subagents, or an
external orchestrator. Staging and sequencing belong to execution
time, so the sprint never has to be rewritten into a plan.

## Boundaries

A sprint owns approved intent: deltas, work items, and the two
verbatim boilerplate sections (execution shape and completion
contract). The execution shape names roles and their hand-offs — a
builder and a standing reviewer relayed by the session, the
completion report as the record between them, a harness task list
mirroring the report's stages where the tools exist (see also:
team-execution-cold-gate and task-tools-mirror-the-report under
decisions). It does NOT own execution order — items are never grouped
into stages, phases, or themes — and it is NOT the intake queue:
questions live as issues until promoted, and after promotion the
sprint alone is the source of truth (see also: issue, corpus-delta,
completion-contract, plan-a-sprint under stories). The record of its
execution is its companion completion report, kept by the executor
and archived with it (see also: completion-report). Sprints are
project records under the estate's record discipline, and the sprint
being executed is that discipline's single live exception — the one
record allowed in context (see also: estate, design-corpus). An
archived sprint carries the record of its close, which the next
planning ceremony reads as the baseline for detecting work done out
of band (see also: closing-commit-baseline under decisions).

## Invariants

- Self-sufficiency: an executing agent never reads the queue or
  history to learn what a promoted issue "really meant"; a genuine
  gap is raised with the owner, never filled by inference.
- Work items name the stories and decisions they make true, and
  describe outcomes, not methods.
- A sprint archives only once it certifies clean, together with its
  completion report; an uncertified sprint stays in flight.
- A sprint is never rewritten into a plan document.
- The execution shape names roles and hand-offs, never an order of
  work.
