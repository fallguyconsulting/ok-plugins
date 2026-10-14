---
topic: sprint
kind: concept
---

# The sprint (the planning ceremony's terminal artifact)

## Description

A **sprint** is "a change-order against the design corpus, expressed as final-form artifact deltas plus the work items that realize them, terminated by a fixed completion contract," written by `/plan-sprint` to `.ok-planner/sprints/YYYY-MM-DD-<slug>.md`. It is deliberately "the sprint in the scrum sense: a collection of potentially disparate changes ... with no required unifying focus. Do not manufacture a narrative to hold unrelated items together, and do not batch, stage, or phase the work items" — sequencing belongs to execution.

Document shape: **Intent** (a few sentences; "A sprint with no single theme says so plainly"; lists promoted issue ids), **Corpus deltas** — the substantive body: each delta is "a FINAL-FORM artifact body — a complete concept / story / decision file content per the templates" under an operation heading (`### New story: <slug>`, `### Amend concept: <slug>`, `### Retire decision: <slug>`); "Applying a delta IS updating the corpus: the implementer copies the final form into place (or deletes, for retirements). No summarized or partial deltas." Then **Work items** — "a flat, unordered list. Each names the stories/decisions it makes true (by slug) and describes the outcome, not the method. Real dependencies between items are stated as such; do NOT group items into stages, phases, or themes." Then two fixed boilerplate sections included verbatim in every sprint: **How to execute this sprint** (8 numbered steps: read whole; stage in your own working state; apply deltas verbatim; build stage-by-stage with tests written with the work; completeness is the floor; never destroy uncommitted work; work unsupervised to a defensible done; close with `/certify`) and the **Completion contract** (see its own entry). "Together they make the sprint self-driving ... This is what lets a sprint be handed directly to `/goal`, to an orchestrator, or picked up inline — every executor works from the same brief."

**Self-sufficiency is the invariant.** "Once written, it is the source of truth for execution: everything the work needs is in it, in final form. An executing agent never reads the issue queue to find out what a promoted issue 'really meant' — if a resolution's substance is not in the deltas or the work items, it is not in the sprint. Write accordingly." The boilerplate's step 1 mirrors it from the executor side ("Do not go looking for context behind it ... a genuine gap is raised with the owner, never filled by inference").

Lifecycle: drafted and signed off in `/plan-sprint`; executed by anyone (inline session, `/goal`, orchestrator); archived to `history/sprints/` by `/certify` "once it certifies clean" (an uncertified sprint "stays in flight"). While being executed, the sprint is the one record allowed in context ("the sprint you are actively executing is in context for as long as you are executing it").

## Code surface

- `plugins/ok-planner/skills/plan-sprint/SKILL.md` §3 (the full template with boilerplate).
- `plugins/ok-planner/skills/certify/SKILL.md` (alignment target resolution: named argument, else exactly one in-flight sprint, else none; archive step).
- `scripts/ok-planner-CLAUDE.md` "Executing a sprint" (the long-form execution shape).

## Prose surface

- `plugins/ok-planner/CLAUDE.md` plugin-purpose paragraph; index skill table row for plan-sprint; cheatsheet Lifecycle and Hard rules.

## Adjacent topics

- `plan-sprint-ceremony` (produces it), `completion-contract`, `execution-model`, `issue-queue` (promotion into it), `certify-gate` (closes and archives it), `design-corpus` (deltas mutate it), `backlog-sprint-rename` (its prior names).

## Observations

- The corpus delta is arguably its own noun (final-form body, operation heading, "applying a delta IS updating the corpus") living entirely inside the sprint template — no standalone definition exists outside plan-sprint's §3 and the executors' restatements.
- "Retire" produces file deletion in `design/`, yet compliance-review scope text elsewhere speaks of `_retired/` directories ("skip `_retired/`", "Retired-only entries belong in the 'Retired' section" of TOCs) — two retirement mechanics (delete vs move-to-_retired/) coexist in live text with no reconciliation.
- The boilerplate embeds conduct-rule content (never destroy uncommitted work; run unsupervised; completeness floor) so that non-ok-conduct executors still receive the rules — deliberate redundancy between output style and sprint text.
