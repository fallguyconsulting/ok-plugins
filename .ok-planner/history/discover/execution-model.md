---
topic: execution-model
kind: choice
---

# The execution model: no plan artifact, executor-agnostic sprints

## Description

ok-planner makes a pointed negative choice: **there is no plan artifact and no execution engine.** "There is still **no plan artifact**: a sprint is never rewritten into a plan; staging happens at execution time in the executor's own working state" (plugin CLAUDE.md). "**Executing a sprint needs no orchestrator.** ... staging it into a sensible order is planning that belongs to execution, done at execution time by whoever does the work: an ordinary inline session is a first-class way to run one" (index skill). The estate CLAUDE.md makes staging concrete: "Group items that share a theme, a file surface, or a dependency; order the groups so nothing is built on something not yet there. This is real planning and it happens here, not in the sprint — keep it in your working state (a task list is ideal). Do not write a plan document; ok-planner has no plan artifact, and a sprint is never rewritten into one."

Executor-agnosticism is achieved by baking the execution shape into the artifact: "/plan-sprint bakes a fixed 'How to execute this sprint' section into every sprint it produces, so the sprint can be picked up inline, handed to the native `goal` mechanism, or dispatched to an orchestrator that does its own planning — every executor works from the same brief." The long form lives in the materialized `.ok-planner/CLAUDE.md`; the cheatsheet carries the pointer. "'Implement sprint X' is an ordinary working session, not a special mode." Scale is a judgment call ("independent, large stages are worth parallel subagents or a worktree; coupled or small ones are not"), but the completion contract "is what does not scale away."

This is a reversal of the plugin's own pre-4.0 architecture, preserved only in git history: the gate-driven execution engine (2026-06-05) was a full workflow engine — baseline snapshots, gate pre-flight classification, artifact probes, gate repair with flip-validation, an escalation taxonomy, cap accounting, a strategist rung. The 4.0 rework (commit 1d4af77 "corpus-spec + planning-ceremony rework") deleted the engine skills (write-plan, execute-plan, execute-plan-in-worktree, brainstorm, verify, review-work, review-plan, coverage, refine-design, affirm, merge, sketch survived) and moved the verification burden into the terminal gates (`/audit`, `/certify`) and the project's own test suites. What survived the reversal: the completeness contract (as sprint boilerplate step 5 and ok-conduct's floor rule), asymmetric divergence (certify's "An undershoot must never appear here — it was fixed, not reported"), and the never-destroy-work rule.

## Code surface

- `plugins/ok-planner/skills/plan-sprint/SKILL.md` (the baked boilerplate); `scripts/ok-planner-CLAUDE.md` "Executing a sprint"; `skills/ok-planner/SKILL.md` ("Never turn a sprint into a plan document").
- Absences as evidence: no execute/plan skills exist under `plugins/ok-planner/skills/`.

## Prose surface

- `plugins/ok-planner/CLAUDE.md` plugin purpose; the predecessor architecture survives only in git history.

## Adjacent topics

- `sprint`, `completion-contract`, `certify-gate`, `ok-conduct` (run-unsupervised + completeness floor), `pre-4-0-kinds`.

## Observations

- The design-notes describe skills, file paths, and JSON escalation kinds that no longer exist anywhere; they are the largest block of dead prose in the plugin and are not marked superseded.
- The "native `goal` mechanism" (`/goal <path-to-sprint>`, "its Stop hook drives the build to completion") is referenced in three places as an execution path but is harness functionality, not anything this repo ships — an external dependency named in load-bearing text.
