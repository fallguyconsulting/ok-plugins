# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository purpose

This is a **single-plugin Claude Code marketplace** that ships the `ok-planner` plugin: planning, implementation, and review skills (a pipeline: brainstorm → write-plan → execute-plan → review-work → verify), plus the `ok-conduct` output style.

The deliverable is markdown `SKILL.md` files, plugin and marketplace manifests, an output style, and a bash `SessionStart` hook. There is no build, no test runner, no `package.json`. Edits are almost always to skill prompts under `skills/<skill>/SKILL.md`.

## Layout

```
.claude-plugin/marketplace.json   # Marketplace manifest — single-plugin, sources the plugin at "."
.claude-plugin/plugin.json        # Plugin manifest (name/description/version)
hooks/hooks.json                  # Declares SessionStart
hooks/session-start               # Bash script; must stay executable
skills/<skill>/SKILL.md           # The skill prompt; frontmatter name/description required
output-styles/<name>.md           # Claude Code output styles shipped by the plugin (e.g., ok-conduct)
```

The plugin lives at the repo root rather than under `plugins/<name>/`; `marketplace.json` points at `"."`.

The `SessionStart` hook in `hooks/session-start` reads `skills/ok-planner/SKILL.md` at session start and injects its contents as `additionalContext` via stdout JSON. It also reads the installed plugin version (from `.claude-plugin/plugin.json`) and the conduct version (from the `Conduct version:` line in `output-styles/ok-conduct.md`) and surfaces both in the opening line of the injected context. It uses a hand-rolled `escape_for_json` function — any changes to that script must preserve valid JSON output (test by running the script directly; it should emit a parseable JSON object).

The `UserPromptSubmit` hook in `hooks/user-prompt-submit` exists to fight a specific drift: output styles are loaded once at session start as part of the system prompt and are **not** re-injected per turn, so their attentional weight decays as the conversation grows even though the rules are still literally in context. Every Nth user prompt (currently N=5), this hook emits a brief `additionalContext` reminder pointing the model back at the active output style — refreshing the rules' position in attention without paying the tokens of re-stating them. It counts real user prompts by parsing the transcript JSONL pointed at by `transcript_path` on stdin: entries with `type == "user"`, no `toolUseResult`, and `isSidechain == false` (filtering out tool-result entries and subagent prompts that share the same `type`). It depends on `jq`; if `jq` isn't installed, or `transcript_path` is missing or unreadable, the hook no-ops silently rather than break the session.

## How skills are wired

Every `SKILL.md` starts with YAML frontmatter:

```
---
name: <skill-name>
description: "ONLY activated by explicit /<command> slash command. Never auto-triggered by conversation content."
---
```

The "ONLY activated by explicit slash command" phrasing is load-bearing — it prevents Claude from invoking skills inferentially. Preserve it on new skills.

Skills chain by instructing the orchestrator to invoke the next one (e.g., `brainstorm` ends by invoking `ok-planner:write-plan`). They do not chain automatically — the chain is part of the skill prompt.

## ok-planner's review discipline (important when editing skills here)

The ok-planner pipeline enforces a **no-triage** policy on code review results. Review skills (`review-work`, `review-design`, `review-plan`, `review-commits`, `review-files`, `review-feature`) all terminate by invoking `ok-planner:review-cleanup`, which dispatches a fixer subagent and loops until the reviewer reports zero issues. Guard rail: max 3 fix-review cycles.

When editing review skills, preserve two invariants:
1. The reviewer output flows to `review-cleanup` **verbatim** — do not add filtering, categorization, or severity triage logic.
2. `review-cleanup` is marked internal (not user-facing); do not expose it as a slash command.

## Output styles vs. skills (where does content belong?)

- **Skills** = capabilities invoked by slash command (e.g., `/brainstorm`). On-demand, user-triggered.
- **Output styles** = standing behavioral rules that apply across every turn of a session. One active style at a time; the user picks via `/config` → Output style. Styles ship as `output-styles/<name>.md`; the filename becomes the style name unless frontmatter `name` overrides it.
- Custom output styles **replace** Claude Code's built-in coding instructions by default. Any style in this repo intended to add *mild* rules must set `keep-coding-instructions: true` in frontmatter so it layers on top of defaults rather than replacing them. `ok-conduct` is the canonical example.
- Rule of thumb: **rules that should always apply** go in an output style. **Workflows the user chooses to run** go in a skill.

## Versioning and releases

Two **independent** version numbers, deliberately distinct so each answers its own question:

- **Plugin version** — plain semver in the `version` field of `.claude-plugin/plugin.json`. This is Claude Code's **update key**: with an explicit `version` set, a consumer's `/plugin update` fetches new files **only when this number changes** — pushing commits alone does nothing, because Claude Code sees the same version string and keeps the cached copy. So **bump it on every release**, or installs silently freeze on the last published number. (It governs update delivery only; it does not affect prompt caching.) Alternatively, omitting the field entirely makes the git commit SHA the version, so every commit ships — but then there is no human-readable semver to check, which is why we keep an explicit one.
- **Conduct version** — the `ok-conduct` output style's own semver plus a sequential-alphabetical animal codename (Ant, Bear, Cat, …), stamped as the first body line of `output-styles/ok-conduct.md`: `Conduct version: X.Y.Z (Animal)`. It counts **independently** of the plugin version — bump it, and advance the animal one letter, **only when the conduct body actually changes**. Two constraints keep it checkable: the stamp must live in the **body** (YAML frontmatter is stripped from the system prompt, so a frontmatter field would be invisible to a running session), and the line must keep the `Conduct version:` prefix (the hook greps it from disk that way, and the `/ok-version` skill reads the same line from its active output style — i.e. from the system prompt, not from disk).

Surfacing the running versions: the `SessionStart` hook surfaces both installed numbers (from disk) at session start, and the `/ok-version` skill recites what the **live session** is running — plugin from the session-start line, conduct from the active output style. It does not read disk or compute a verdict; the user compares against what they expect. This split matters because the output style is read once per session and is **not** refreshed by `/reload-plugins` — only `/clear` or a new session re-reads it — so a session can run current skills under a stale conduct.

Cutting a release: the project-local `/release` skill (`.claude/skills/release/SKILL.md` — local maintenance tooling, **not** part of the distributed plugin) automates the plugin-version bump. It inspects the changes since the last git tag, judges the semver level, bumps `version` in `.claude-plugin/plugin.json`, then commits, tags `vX.Y.Z`, and pushes branch + tag to `origin`. It only ever touches the plugin version — the conduct version stays hand-managed (the skill warns if `ok-conduct.md`'s body changed without a conduct bump). The first run has no prior tag, so it bootstraps a baseline; every run after diffs cleanly against the previous tag.

## Adding a new skill

1. Create `skills/<skill>/SKILL.md` with the required frontmatter.
2. If the skill is a new review type, make it dispatch a reviewer and then invoke `ok-planner:review-cleanup` with the raw output.
3. If the skill should show up in the session-start context listing, add it to the table in `skills/ok-planner/SKILL.md` (the hook reads that file).
4. No manifest change is needed — skills are discovered from the `skills/` directory.

## Constraints specific to this repo

- Never commit `.claude/settings.local.json` — it is gitignored.
- Do not create `.ok-planner/specs/` or `.ok-planner/plans/` files in this repo unless you are dogfooding a skill — those paths are conventions the skills write into *consumer* projects, not artifacts that belong here.
- There are no `package.json` files and no JS build — skills are pure markdown and the hooks are bash. Do not add Node tooling unless a skill actually needs it.
