---
topic: plugin-renames
kind: alias
---

# Historical plugin and verb renames

## Description

The suite's current names sit on top of several completed renames, visible in git history and occasionally in surviving prose.

**ok-standards → ok-plumbline.** Commit eba51a7: "Rename ok-standards to ok-plumbline: the plugin slot carries the brand." The *methodology* keeps the Plumbline name deliberately: "the lint binary, the `@plumbline:allow-docstrings` marker, and `.plumbline.json` are unchanged), so existing Plumbline projects remain compatible. Skill invocations use the plugin namespace: `/ok-plumbline:true-up`" (README). Plumbline itself descends from an earlier methodology: "Plumbline grew out of the Cold Read methodology. Cold Read v1 optimized for ... comprehension; v2 reweighted around verification. Plumbline v1 took Cold Read v2's content forward under a name that describes the goal" (plumbline README "Lineage"; the phase-1 discoverer prompt in discover-design still lists `cold-read/` among prose inputs to read).

**ok-doctor → ok.** Commit 19bdfb5 created "ok-doctor 0.1.0: suite upkeep dispatcher"; the plugin is now `ok` and the "doctor verb" it drove is now `true-up`. The same commit message uses a third retired verb name: "re-affirms **affirm**-remediable drift" — `affirm` appears in the pre-4.0 ok-planner design-notes as the skill that maintained the estate CLAUDE.md template.

**Artifact renames** (covered in depth by their own entries): "sprint spec" in `specs/` → "sprint backlog" in `backlogs/` → **sprint** in `sprints/` (see `backlog-sprint-rename`); the pre-4.0 skill suite (write-plan, execute-plan, brainstorm, verify, review-work, review-plan, coverage, refine-design, affirm, merge — all named in `design-notes/`) was retired in the 4.0 "corpus-spec + planning-ceremony rework" (commit 1d4af77); `sprint` the skill name was recently renamed to `plan-sprint` (git status shows `skills/sprint/SKILL.md -> skills/plan-sprint/SKILL.md`, uncommitted at discovery time).

## Code surface

- Git history: c330c4d, 19bdfb5, eba51a7, 1d4af77; the uncommitted `sprint → plan-sprint` rename in the working tree.
- Survivals: `plugins/ok-plumbline/.plumbline.json` (root-format self-config), `plugins/ok-plumbline/README.md` (fallguy marketplace install), `plugins/ok-planner/design-notes/` (retired skill names).

## Prose surface

- `README.md` (the ok-plumbline naming paragraph); `plugins/ok-plumbline/README.md` "Lineage".

## Adjacent topics

- `backlog-sprint-rename`, `pre-4-0-kinds`, `dot-directory-and-discovery` (the `.plumbline.json` pre-migration marker), `marketplace-monorepo`.

## Observations

- Three generations of the converge-verb name are recoverable: `affirm` → `doctor` → `true-up`. Only true-up survives in live text.
- The discover-design phase-1 prompt's "cold-read docs" reference is a live mention of a retired methodology name inside a shipping skill.
- The `sprint → plan-sprint` skill rename is mid-flight in the working tree; the certify skill and sprint boilerplate already say `/plan-sprint` throughout, so live text is consistent, but any consumer pinned to an older release has `/sprint`.
