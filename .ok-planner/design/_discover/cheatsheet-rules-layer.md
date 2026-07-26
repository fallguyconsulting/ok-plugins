---
topic: cheatsheet-rules-layer
kind: concept
---

# The cheatsheet: the always-in-context rules layer

## Description

Layer 2 of the integration contract: each integrable plugin owns exactly one file under the consumer's `.claude/rules/` — "the small, stable, always-in-context rules layer. Wholly owned and overwritten by the plugin's true-up; drift is corrected by overwrite, never by merge." The three cheatsheets are `.claude/rules/ok-planner-cheatsheet.md`, `.claude/rules/plumbline-cheatsheet.md`, and `.claude/rules/ok-workspaces-cheatsheet.md`. Project-specific rules belong in the project's *other* files under `.claude/rules/`; those are never touched (and no plugin touches `.claude/rules/rules.md` or `CLAUDE.md` — the ownership rule).

Production differs per plugin. ok-planner's cheatsheet is a static template (`scripts/ok-planner-cheatsheet.md`) with the version stamped in by `scripts/true-up` (`{{OK_PLANNER_VERSION}}` → installed version); its content is a condensed form of the estate rules: the three content kinds (design/ source of truth; issues.jsonl intake queue; sprints/sketches/history records out of context), the lifecycle, and five "Hard rules." ok-plumbline's is a byte-copy of the canonical `docs/plumbline-cheatsheet.md` (no version stamp in the file — true-up compares content with `cmp -s`); it carries the full comment rule, DRY/uniformity/types rules, and the tooling summary. ok-workspaces' cheatsheet is *rendered from the profile* by `scripts/true-up.js` — the three workspace rules with the project's concrete mechanics substituted (compose project prefix or port scheme, script path) and "Materialized by ok-workspaces v<version>" stamped.

The cheatsheet is what a contributor without the plugin still sees — plumbline's true-up notes "the project commits the materialized file (so contributors without the plugin still see the rules)."

The ok-conduct output style is explicitly *not* this layer: the contract's conformance section says "The ok-conduct output style is an additional, optional delivery-style layer, not the rules layer."

## Code surface

- Templates/canonicals: `plugins/ok-planner/scripts/ok-planner-cheatsheet.md`, `plugins/ok-plumbline/docs/plumbline-cheatsheet.md`, cheatsheet composed inline in `plugins/ok-workspaces/scripts/true-up.js`.
- Writers: `plugins/ok-planner/scripts/true-up` (sed-stamp + overwrite), `plugins/ok-plumbline/skills/true-up/SKILL.md` §4 (cmp + cp), `plugins/ok-workspaces/scripts/true-up.js`.
- Drift checks: `plugins/ok-workspaces/scripts/diagnose.js` (regex on the "Materialized by" stamp); plumbline diagnose checks the file is committed.
- Materialized instance in this repo: `.claude/rules/ok-planner-cheatsheet.md` (stamped v8.0.0).

## Prose surface

- `docs/integration-contract.md` "The three layers" (layer 2) and the ownership rule.
- `plugins/ok-plumbline/README.md` Quick start — commit-the-cheatsheet guidance.

## Adjacent topics

- `ownership-and-consent`, `version-stamping`, `true-up-verb`, `ok-conduct`, `stack-profile`.

## Observations

- Version-stamp coverage is inconsistent across the three cheatsheets: ok-planner's and ok-workspaces' carry "Materialized by ... v<version>" lines; plumbline's carries no stamp and relies on byte-comparison against the canonical — so the contract's "every materialized artifact records the version of the plugin that wrote it" holds for two of three cheatsheets by stamp and for the third only via content identity.
- ok-planner's cheatsheet contains the sentence "by **promoting** it into that sprint's sprint (row marked with the sprint's name)" — the doubled "sprint's sprint" reads as a leftover of the backlog→sprint rename (see `backlog-sprint-rename`).
