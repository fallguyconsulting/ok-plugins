---
topic: pre-4-0-kinds
kind: alias
---

# Pre-4.0 artifact kinds and their migration

## Description

ok-planner 4.0 (commit 1d4af77, "corpus-spec + planning-ceremony rework") retired a family of artifact kinds whose estates true-up still detects and migrates: `plans/`, `coverage/`, `design/tensions/`, and loose `design/review-notes*.md`. The script reports them (`PRE-MIGRATION LAYOUT PRESENT: ...`); the SKILL migrates without a consent prompt ("The current skills key on the current layout and will misbehave against a retired one; leaving the estate half-migrated is worse than migrating it").

Migration semantics (true-up §3b): **`design/tensions/` → issue rows** — each live tension file (skipping `_resolved/` and `_rejected/` — "settled history") becomes an `open` row: id = tension slug, `kind: "human"`, category from frontmatter, `artifacts` from its `affects:` list, summary from title, detail condensed from "What is muddy" / "Why it matters", candidates from "Resolution candidates"; then the whole tree moves to `history/tensions/`. **`plans/`, `coverage/`, `review-notes*.md` → archive** — "These artifact kinds have no live consumers in ok-planner 4.x"; each moves to its same-named folder under `history/`, merging with prior archives. "Nothing is deleted ... This is the general completion rule, not a migration special case." `sketches/` is pointedly *not* among the retired kinds ("sketches remain a live artifact kind"), and `history/` itself is never flagged ("anything under it — whatever its subdirectory name — is preserved as-is").

The retired kinds map to the pre-4.0 skill suite preserved in `design-notes/`: plans were written by `write-plan` and executed by the flip-gated `execute-plan` engine; `coverage` was a standing regression check over story acceptance; tensions were the predecessor of issue rows (same muddiness taxonomy, file-per-tension instead of JSONL events); review-notes belonged to the review skills. The design notes also name `brainstorm`, `verify`, `review-work`, `review-plan`, `refine-design`, `merge`, and `affirm` — none of which exists as a skill today. The two design-note files themselves (`2026-06-05-flip-gated-execution.md`, `2026-06-06-completeness-contract.md`) are in-plugin prose describing that retired architecture, marked "design, pre-implementation," never updated after the 4.0 reversal.

## Code surface

- `plugins/ok-planner/scripts/true-up` (premigration scan list); `skills/true-up/SKILL.md` §3b.
- `plugins/ok-planner/design-notes/*.md` (the retired architecture's fullest description).

## Prose surface

- Index skill true-up row (mentions "tensions/, plans/, coverage/…" with the stale consent phrasing); `scripts/ok-planner-CLAUDE.md` history list (archive folders for migrated kinds); contract conformance line ("its true-up detects and migrates (with consent) the retired pre-4.0 estate").

## Adjacent topics

- `backlog-sprint-rename` (the sibling migration), `issue-queue` (tensions' successor), `execution-model` (the retired engine), `plugin-renames`, `true-up-verb`.

## Observations

- Consent phrasing disagrees across three surfaces for the same migration: contract ("migrates (with consent)"), index skill ("proposes the migration for the owner's consent, then performs it"), true-up SKILL ("no consent prompt"). The SKILL is the executing text; the other two look stale.
- The tension→issue mapping preserves the muddiness taxonomy — the issue categories (`overloaded`, `unclear`, `conflicting`, ...) are the tension categories carried forward; the design notes and the categories are the only remaining witnesses of the tension kind's shape.
- `design-notes/` is itself an artifact kind found nowhere in any layout spec — plugin-side working notes, not part of the estate or the deliverable, and the only place the pre-4.0 skill names survive.
