---
topic: discover-design
kind: concept
---

# /discover-design — the corpus bootstrap

## Description

`/discover-design` is a "two-phase autonomous pass" that bootstraps the design corpus: phase 1 writes wide as-is scaffolding to `design/_discover/` (one file per topic; template Description / Code surface / Prose surface / Adjacent topics / Observations; kinds concept | invariant | discipline | schema | boundary | choice | alias); phase 2 extracts the durable catalogs (`concepts/`, `stories/`, `decisions/`) from the scaffolding and appends judgment questions to the issue queue (`kind: "discover"`). "Runs end-to-end without user interruption. ... The final report is the only thing the user sees." Outputs are as-is, never prescriptive: "Do NOT propose resolutions to issues, do NOT invent stories the product does not yet deliver, and do NOT propose decisions the project has not yet made. Document the as-is; sprints evolve the model."

Each phase runs an agentic **produce → review → fix loop** capped at 3 cycles; findings still open at the cap become issue rows rather than blocking. The phase 2 reviewer also does **final-pass uncertainty filing** — the agent's own confessed uncertainty (judgment calls made, suspected-but-unconfirmed concepts, merge/split doubts, capped findings) becomes open rows, distinct from codebase-muddiness issues. A one-shot **back-edge** exists: if the phase 2 reviewer emits a structured `## Thin discovery requests` block (only for "read more code" gaps, never "make a design decision" gaps), a focused re-discovery expands just the named `_discover/` entries, a focused extractor updates the affected artifacts (new artifacts only when explicitly authorized), and the reviewer re-checks the affected scope. "One back-edge per skill invocation."

Step 7 regenerates the **catalog TOCs**: `concepts.md`, `stories.md`, `decisions.md` — "the one-shot-readable catalogs consulted by skills that read the design docs ... they let agents know what artifacts exist without reading every full file. Generated; agents should not edit them by hand." (Header text: "refreshed whenever a sprint's deltas touch the catalog.") Entries are alphabetical, slug + ≤120-char summary, aliases parenthesized. `concepts.md` additionally gets injected into every session by the session-start hook.

Re-run discipline: idempotent on `_discover/` (re-running "deepens existing entries and adds new ones", including rewriting legacy ADR-template entries); **aborts** when any durable catalog is non-empty — "they may contain human-approved content from sprint deltas. ... Aborts rather than risk data loss." Rerun requires the user to delete the durable directories. The NOT-do list also excludes annotation introduction ("a separate convention introduced after the prescriptive design is stable") and grading ("Defects are found by the review skills").

## Code surface

- `plugins/ok-planner/skills/discover-design/SKILL.md` (1172 lines — the largest file in the suite; five embedded subagent prompts: phase-1 discoverer, phase-1 reviewer, phase-2 extractor, phase-2 reviewer, back-edge discoverer + extractor).
- Transcludes eleven `{{TOKEN}}` blocks from artifact-definitions.
- State detection: step 3 (empty `_discover/` → scratch; non-empty → expand; non-empty durable → abort).

## Prose surface

- "Why this exists" section (durable identity; grunt-work rationale: "the user's design judgment is better spent resolving the queue"); index skill row.

## Adjacent topics

- `design-corpus`, `catalog-tocs` (folded here), `issue-queue`, `transclusion-tokens`, `annotation-convention` (the convention section lives in this SKILL), `certify-gate` (same loop shape).

## Observations

- The phase-1 prompt is written for arbitrary consumer codebases (entry points `cmd/*`, schema migrations, `cold-read/` docs) — running it on this repo (as now) requires the orchestrator to re-orient it, which the live orchestrator did via a project-orientation preamble.
- The TOC-regeneration duty is assigned to discover-design and to "whenever a sprint's deltas touch the catalog" (per the generated header), but no sprint/certify text names TOC refresh as a step — the second half of the duty has no assigned owner in live skill text. The compliance reviewer *checks* TOC consistency, so drift surfaces at audit time.
- The abort-on-nonempty rule combined with "delete the directories to rerun" means there is no incremental re-discovery path once a corpus is refined — by design ("Keep the design model aligned with the code through sprints").
