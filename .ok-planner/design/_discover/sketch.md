---
topic: sketch
kind: concept
---

# /sketch — pre-commitment design sketches

## Description

A sketch is "**pre-commitment**: it captures an idea in enough detail to think about it, share it, or come back to it — without committing to the full planning ceremony." Written in one pass to `.ok-planner/sketches/YYYY-MM-DD-<topic>-sketch.md`; "One pass, one document, no review loop, no dialogue. The agent makes reasonable assumptions and notes them" in an Open questions section rather than stopping to ask (single exception: ask once for the topic if the invocation didn't name one).

The boundary against the sprint is drawn hard: "**A sketch is not a sprint.** A sketch can be wrong, incomplete, or speculative. It exists to externalize thinking, not to authorize implementation. Do not invoke `/plan-sprint` or any implementation skill from a sketch ... If the user wants to build what's in the sketch, the path is sketch → `/plan-sprint` → sprint." Mid-sketch upgrades are forbidden: "finish the sketch first, then suggest `/plan-sprint` as the next step. Do not silently upgrade."

The corpus interaction is deliberately light: "Glance at the codebase only as much as needed ... If `.ok-planner/design/` exists, skim the catalog filenames under `design/concepts/` and grep for `@concept:` annotations in any code you skim ...; read full `concepts/<slug>.md` files only for concepts the sketched idea touches. Use the catalog's terms; respect stated boundaries." Boundary questions go into the sketch's Open questions, "not as silent assumptions — and not into `issues.jsonl` (a sketch is speculative; it does not file design issues)."

Template: Idea / Shape (free-form — "No prescribed sections", ASCII diagrams fine) / Open questions / Risks-unknowns ("sketches are for thinking, not for selling") / optional What-this-is-not (deliberate omissions "considered and skipped, not forgotten"). Status line stamps "Sketch (not a sprint; not authorization to build)". Lifecycle: live in `sketches/` while the idea is open; "When the idea is taken up for real (via `/plan-sprint`) or abandoned, the sketch file moves to `history/sketches/` — per file, not wholesale." Sketches are a *live* artifact kind that true-up must never flag for migration. NOT-do list: no reviewer subagent, no section-by-section approval, no writes to design/ or the queue, no phased rollouts/commit plans/PR strategies, no code edits.

## Code surface

- `plugins/ok-planner/skills/sketch/SKILL.md` (120 lines).
- `scripts/true-up` creates `sketches/` and `history/sketches/`; true-up SKILL: "`sketches/` is a live artifact kind (see `/sketch`), never flagged for migration."

## Prose surface

- Estate CLAUDE.md lifecycle ("`/sketch` captures an unplanned idea ... no authorization to build"); cheatsheet; index skill row.

## Adjacent topics

- `plan-sprint-ceremony` (the upgrade path), `context-discipline` (sketches are records, out of context by default), `ok-planner-estate`, `issue-queue` (deliberately not written by sketch).

## Observations

- The index-skill row for sketch ends "the path to building is sketch → `/plan-sprint` → spec" — the retired noun "spec" survives in exactly this row.
- Sketch is the one ok-planner artifact producer with no review loop of any kind — a deliberate inversion of the suite's produce→review→fix habit, justified by speculation status.
