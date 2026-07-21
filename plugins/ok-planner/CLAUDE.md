# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Plugin purpose

`ok-planner` is the specification for an opinionated documentation corpus — concepts, stories (agile-style non-prescriptions of user need with a mandatory "so that" clause and a proof), decisions (technical choices, each with a proof) — plus the planning ceremony (`/sprint`) that maintains it, the corpus verbs (`/audit`, `/prove`), the estate verbs (`/affirm`, `/doctor`), and the bootstrap (`/discover-design`). Implementation planning and execution are deliberately out of scope: a sprint spec's completion contract tells an external orchestrator when work is done.

The deliverable is markdown `SKILL.md` files, the plugin manifest, an output style (`ok-conduct`), and bash hooks. There is no build and no test runner. This plugin lives at `plugins/ok-planner/` inside the `ok-plugins` marketplace monorepo; the marketplace manifest is at the repo root.

## Layout

```
.claude-plugin/plugin.json        # Plugin manifest (name/description/version)
hooks/hooks.json                  # Declares SessionStart + UserPromptSubmit
hooks/session-start               # Injects skills/ok-planner/SKILL.md as context; must stay executable
hooks/user-prompt-submit          # Per-turn ok-conduct attention refresher (jq-dependent, no-ops without it)
skills/<skill>/SKILL.md           # The skill prompts; frontmatter name/description required
skills/_shared/                   # Canonical artifact definitions + shared reviewer prompt (transclusion source)
scripts/affirm                    # Deterministic layout script run by the affirm skill
scripts/ok-planner-CLAUDE.md      # Template materialized into consumer projects ({{OK_PLANNER_VERSION}} stamped by the script)
output-styles/ok-conduct.md       # The conduct; body carries `Conduct version: X.Y.Z (Animal)`
```

## The single source of truth

`skills/_shared/artifact-definitions.md` canonically defines concept / story / decision / issue and the cross-cutting rules (self-containment, current-state-only, proof-protection, the issue-queue format). Skills transclude its `{{TOKEN}}` blocks into subagent dispatches or reference it directly. Never restate a definition inline in a skill — edit the shared file.

The issue queue (`.ok-planner/issues.jsonl` in consumer projects) is append-only: `open` rows from `/audit`, `/discover-design`, `/sprint`, humans; `resolve` rows only from `/sprint`. `/prove` returns findings in-context and never writes the queue.

## How skills are wired

Every `SKILL.md` starts with YAML frontmatter; the "ONLY activated by explicit slash command" phrasing in `description` is load-bearing — it prevents Claude from invoking skills inferentially. Preserve it on new skills.

Skills do not chain into a pipeline. `/sprint` is terminal at the approved spec; `/audit` and `/prove` are invoked by the user or by an external orchestrator executing a spec's completion contract.

## Versioning and releases

Two **independent** version numbers:

- **Plugin version** — semver in `.claude-plugin/plugin.json`. Claude Code's update key: bump it on every release or installs freeze. The affirm script stamps it into materialized `.ok-planner/CLAUDE.md` files (`{{OK_PLANNER_VERSION}}`), which is what `/doctor` compares against.
- **Conduct version** — `Conduct version: X.Y.Z (Animal)` as the first body line of `output-styles/ok-conduct.md`; bump (and advance the animal one letter) only when the conduct body changes. The stamp must stay in the body (frontmatter is stripped from the system prompt) and keep its prefix (the session-start hook and `/ok-version` grep it).

## Constraints

- Never commit `.claude/settings.local.json`.
- Do not create `.ok-planner/` artifacts in this repo unless dogfooding — those paths are conventions the skills write into *consumer* projects.
- No Node tooling; skills are markdown, hooks are bash.
