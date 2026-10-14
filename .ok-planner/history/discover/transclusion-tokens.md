---
topic: transclusion-tokens
kind: discipline
---

# {{TOKEN}} transclusion and single-source shared definitions

## Description

ok-planner keeps its canonical definitions in exactly one file and moves them into prompts by a homegrown transclusion convention. `skills/_shared/artifact-definitions.md` is "the single source of truth. Every skill that authors, reviews, or mutates these artifacts ... reads from here. When the canonical wording changes, it changes here; consumers re-read on next invocation." The plugin CLAUDE.md enforces it editorially: "Never restate a definition inline in a skill — edit the shared file."

Two consumption modes are defined: **Mode 1 — transclusion into subagent dispatches**: prompts embed `{{TOKEN}}` placeholders; "When assembling the dispatch, replace each placeholder with the **body** of the matching `###` block in this file (the prose under the header, not the header line)." **Mode 2 — direct reference** from a skill body running in the main loop (e.g., plan-sprint's delta authoring), which cites the file by path and applies it without restating. The bracket convention is uniform: "`{{...}}` = static block to inline at dispatch-assembly time; `[...]` = per-run value to fill." The stated payoff: "Drift between skills cannot happen" — the extractor that writes, the reviewer that checks, and the back-edge that mutates each get their own dispatch and see only their own prompt, "so defining the rules once in the shared file and transcluding them keeps the wording from drifting between the agent that writes and the agent that checks."

The token catalog (each a `###` heading in artifact-definitions): `{{CONCEPT-DEFINITION}}`, `{{CONCEPT-TEMPLATE}}`, `{{STORY-DEFINITION}}`, `{{STORY-TEMPLATE}}`, `{{DECISION-DEFINITION}}`, `{{DECISION-TEMPLATE}}`, `{{ISSUE-DEFINITION}}`, `{{ISSUE-QUEUE-FORMAT}}`, `{{SELF-CONTAINMENT-RULE}}`, `{{CURRENT-STATE-ONLY-RULE}}`, `{{ANNOTATION-INTEGRITY-RULE}}`. A second shared file holds a whole prompt as a token: `_shared/design-doc-compliance-reviewer.md` defines `{{DESIGN-DOC-COMPLIANCE-REVIEWER-PROMPT}}` with **two-file transclusion** (the prompt itself contains `{{...}}` blocks from artifact-definitions plus the per-call `[AUDIT SCOPE]`), shared verbatim between `audit` (whole-corpus scope) and `plan-sprint` (draft scope) so "drift between draft-time and corpus-time review cannot happen."

A distinct, unrelated placeholder family uses the same delimiters for **version stamping**: `{{OK_PLANNER_VERSION}}`, `{{OK_CONDUCT_VERSION}}`, `{{OK_WORKSPACES_VERSION}}`, `{{OK_PLUMBLINE_VERSION}}` — substituted by sed/JS at materialization time, not by prompt assembly.

## Code surface

- `plugins/ok-planner/skills/_shared/artifact-definitions.md` ("How consumers use this file", token catalog).
- `plugins/ok-planner/skills/_shared/design-doc-compliance-reviewer.md` (two-file transclusion, scope substitution examples).
- Token uses: discover-design (11 tokens across 4 prompts), audit passes 1–2, plan-sprint (§2 intent gate, §4 queue format, §5 reviewer), certify step 5, true-up §3 (reads `{{ISSUE-QUEUE-FORMAT}}`).

## Prose surface

- `plugins/ok-planner/CLAUDE.md` "The single source of truth"; discover-design "Shared rule blocks (transclude into dispatches)".

## Adjacent topics

- `skill`, `design-corpus`, `audit-verb`, `plan-sprint-ceremony`, `discover-design`, `version-stamping` (the homographic placeholder family).

## Observations

- Transclusion is performed by the running model at dispatch-assembly time — there is no tooling that does the substitution or verifies a token name resolves to a real `###` block; a typo'd token would fail silently as literal text in a subagent prompt.
- The `{{TOKEN}}` prompt-transclusion convention and the `{{VERSION}}` sed-stamping convention share syntax but have different substitution agents (model vs script); nothing in prose flags the homography.
- ok-planner is the only plugin with a `_shared/` layer; plumbline achieves single-sourcing by shipping the canonical doc and copying it whole (cheatsheet), workspaces by generating from the profile.
