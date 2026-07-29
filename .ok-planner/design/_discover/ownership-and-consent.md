---
topic: ownership-and-consent
kind: discipline
---

# Ownership rule and consent gates

## Description

The suite's central cross-cutting discipline, stated in the integration contract: "A plugin owns whole files and never edits a file a human also edits. In particular: no plugin touches `.claude/rules/rules.md` or `CLAUDE.md` ... Anything long-lived a plugin maintains must live in a file the plugin can deterministically regenerate in full." Ownership then *decides what true-up may do silently*: plugin-owned files (version-stamped, deterministically regenerable) are converged without prompting; anything else at a path the plugin cares about — an estate from an earlier plugin version, a hand-written file where the plugin would materialize its own — is "presented for the owner's consent — migrate, adopt, replace, or leave — never silently overwritten."

The consent rule extends to **preexisting overlapping context**: guidance the project already carries where the plugin would now govern (an alternate coding-style doc vs plumbline's cheatsheet, a hand-rolled worktree script vs ok-workspaces', an ad-hoc planning directory beside `.ok-planner/`). True-up's diagnose phase must surface these and "propose a conversion plan ... for the owner to decide. Nothing overlapping is ignored, and nothing is converted silently." ok-plumbline's true-up realizes this as its §2 ("Identify overlapping project context").

Owner-decided vs plugin-owned splits per file: profiles/configs (`.ok-workspaces/config.json`, `.ok-plumbline/config.json`) are **owner-declared** — written by the plugin only "as transcription of the owner's explicit in-conversation answers — never a field they didn't confirm, never silently" (ok-workspaces CLAUDE.md); the issue queue is **append-only, not plugin-owned content** ("the queue is not plugin-owned content; this skill never edits it beyond the migration appends"); materialized artifacts (cheatsheets, estate CLAUDE.md, hooks, vendored binaries, src-tag) are **plugin-owned wholesale-overwrite**. ok-planner's true-up is explicit that `.ok-planner/CLAUDE.md` "is not a user-customization surface."

Notable calibration: ok-planner's true-up runs its retired-layout migration **without** a consent prompt ("Run the migration for whatever the script reported — no consent prompt. The current skills key on the current layout and will misbehave against a retired one"), reserving the stop for genuine collisions (old and new locations both populated). `/ok` agrees: "A true-up should never stop to ask permission to migrate its own retired layout — running `/ok` is that permission." Other consent gates that never bend: `/ok` never bootstraps silently and never installs plugins; ok-workspaces close-gates override only on the user's explicit word; proof removals "require explicit user direction ... the agent never proposes removal."

## Code surface

- `docs/integration-contract.md` "The ownership rule".
- `plugins/ok-planner/skills/true-up/SKILL.md` (governing-rule paragraph; §3 no-consent migration; collision stop in §3a; "Does not preserve local edits to `.ok-planner/CLAUDE.md`").
- `plugins/ok-workspaces/scripts/true-up.js` (root `.gitignore` never touched — plugin writes only `.ok-workspaces/.gitignore`), `plugins/ok-workspaces/skills/true-up/SKILL.md` ("never writes `config.json` silently").
- `plugins/ok-plumbline/skills/true-up/SKILL.md` §2, §3 (both-exist conflict is "the one owner-consent case"), §5 (config declared in conversation, transcription only).
- `plugins/ok/skills/ok/SKILL.md` §3 (bootstrap consent), "does not edit any file itself".

## Prose surface

- `docs/integration-contract.md` (ownership + overlapping-context paragraphs); `plugins/ok-workspaces/CLAUDE.md` Constraints ("the committed profile is owner-*decided*"); `plugins/ok-planner/scripts/ok-planner-CLAUDE.md` (the materialized estate rules restating no-hand-edit).

## Adjacent topics

- `integration-contract`, `true-up-verb`, `stack-profile`, `cheatsheet-rules-layer`, `issue-queue`, `workspace-lifecycle` (close gates).

## Observations

- There is a mild tension between the contract's general text ("an estate laid out by an earlier plugin version ... is presented for the owner's consent — migrate, adopt, replace, or leave") and ok-planner true-up's "no consent prompt" for retired-layout migration. Both texts justify themselves; they draw the silent/consent line in different places for the same case (pre-4.0/pre-rename estates). `/ok`'s "running `/ok` is that permission" is a third formulation.
- The consent vocabulary is spread across four files with slightly different verbs (migrate/adopt/replace/leave; fold/keep/retire; accept/keep) — same discipline, no single canonical statement beyond the contract.
