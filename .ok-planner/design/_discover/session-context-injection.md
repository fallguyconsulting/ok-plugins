---
topic: session-context-injection
kind: concept
---

# Index skills and session context injection

## Description

Two plugins (ok-planner, ok-workspaces) ship an **index skill** named after the plugin (`skills/ok-planner/SKILL.md`, `skills/ok-workspaces/SKILL.md`) whose body is not a verb but a briefing: what the plugin is, the table of available skills with when-to-use guidance, the estate layout, and the "When Skills Activate" rule. The index is injected into every session's context by the materialized SessionStart hook: true-up copies the index SKILL.md to `.ok-<name>/context/skills-index.md`, and the project-side `session-start` hook cats it into `hookSpecificOutput.additionalContext` with a banner line — `ok-planner vX.Y.Z (conduct A.B.C (Animal)) is materialized in this project. Skills are invoked only when the user types a slash command.` (ok-workspaces analogous, no conduct). This is how the skills are advertised without any inferential triggering.

ok-planner's session-start hook injects a second payload when present: the project's `design/concepts.md` TOC, prefixed with the framing "the TOC of project-narrowed nouns. Before defining or invoking any term that appears here, open `.ok-planner/design/concepts/<slug>.md` and read it; do not paraphrase from prior context." So a project with a discovered corpus gets its concept catalog into every session automatically.

ok-planner also ships a per-turn **UserPromptSubmit** hook: a conduct attention refresher. Its header documents the rationale: output styles load once at session start and "their attentional weight decays as the conversation grows even though the rules are still literally in context. This hook freshens their position." Cadence is every turn (`REMINDER_EVERY=1`; an earlier version fired every 5 prompts, tightened because "the rules still drifted within those 5 turns"; cost "~30 tokens of context per prompt"). It requires `jq` (silent no-op without), counts real top-level user prompts from the transcript JSONL (excluding tool_results and sidechains), and injects a fixed reminder string ("ok-conduct active. Compose your full reply, then send only the first complete concept ...").

Both index skills open with a `<SUBAGENT-STOP>` block: "If you were dispatched as a subagent to execute a specific task, skip this skill." — keeping the briefing out of subagent context. ok-planner's index additionally carries an **Instruction Priority** ladder (project rules > user instructions > ok-planner skills > default system prompt) and a **Model Selection** rule ("Always use the most capable model available. Do not downgrade models for 'simple' tasks. The user pays for quality, not savings.").

## Code surface

- Index skills: `plugins/ok-planner/skills/ok-planner/SKILL.md`, `plugins/ok-workspaces/skills/ok-workspaces/SKILL.md`.
- Hook sources: `plugins/ok-planner/scripts/hooks/session-start` (skills-index + concepts.md injection), `scripts/hooks/user-prompt-submit` (conduct refresher), `plugins/ok-workspaces/scripts/hooks/session-start`.
- Context copies made by true-up: `plugins/ok-planner/scripts/true-up` (`cp` to `.ok-planner/context/skills-index.md`), `plugins/ok-workspaces/scripts/true-up.js`.
- Live instance: `.ok-planner/context/skills-index.md`, `.ok-planner/hooks/*` in this repo.

## Prose surface

- `plugins/ok-planner/CLAUDE.md` Layout (describes the hooks — partly stale, see `hook-shim`); the hooks' own extensive header comments.

## Adjacent topics

- `hook-shim`, `skill`, `ok-conduct`, `catalog-tocs` (the concepts.md payload), `version-stamping` (the banner's two versions).

## Observations

- ok-plumbline has no index skill and no session injection — its always-in-context surface is the cheatsheet alone. The suite thus has two different mechanisms for "rules in every session" (cheatsheet file vs hook-injected index) used in different mixes per plugin.
- The ok-planner index skill's table is the most drift-prone surface in the plugin and currently disagrees with the true-up SKILL in two places (specs/ naming, consent-vs-no-consent migration) and with `/sketch` in one ("sketch → `/plan-sprint` → spec").
- The injected banner says "Skills are invoked only when the user types a slash command," which understates the documented exceptions (completion contract, orchestrators, /ok driving true-up).
- The Model Selection and Instruction Priority blocks live only in ok-planner's index — suite-wide behavior rules placed in one plugin's briefing.
