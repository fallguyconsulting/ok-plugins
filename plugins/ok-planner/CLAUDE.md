# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Plugin purpose

`ok-planner` is the specification for an opinionated documentation corpus — concepts, stories (agile-style non-prescriptions of user need with a mandatory "so that" clause and a proof), decisions (technical choices, each with a proof) — plus the planning ceremony (`/sprint`) that maintains it, the pre-commitment sketch verb (`/sketch`), the corpus verbs (`/audit`, `/prove`), the estate verb (`/true-up`), and the bootstrap (`/discover-design`). Implementation planning and execution are deliberately out of scope *as skills*: a sprint backlog's completion contract tells whoever executes it when the work is done. How a backlog gets executed — staged at execution time, inline in an ordinary session or by an orchestrator — is **guidance, not a skill**, and lives in the two materialized files (`scripts/ok-planner-CLAUDE.md` has the long form, `scripts/ok-planner-cheatsheet.md` the pointer). Keep it that way: no execute verb, no plan artifact.

The deliverable is markdown `SKILL.md` files, the plugin manifest, an output style (`ok-conduct`), and bash hooks. There is no build and no test runner. This plugin lives at `plugins/ok-planner/` inside the `ok-plugins` marketplace monorepo; the marketplace manifest is at the repo root.

## Layout

```
.claude-plugin/plugin.json        # Plugin manifest (name/description/version)
hooks/hooks.json                  # Declares SessionStart + UserPromptSubmit
hooks/session-start               # Injects skills/ok-planner/SKILL.md as context; must stay executable
hooks/user-prompt-submit          # Per-turn ok-conduct attention refresher (jq-dependent, no-ops without it)
skills/<skill>/SKILL.md           # The skill prompts; frontmatter name/description required
skills/_shared/                   # Canonical artifact definitions + shared reviewer prompt (transclusion source)
scripts/true-up                   # Deterministic layout script run by the true-up skill
scripts/ok-planner-CLAUDE.md      # Template materialized into consumer projects ({{OK_PLANNER_VERSION}} stamped by the script)
output-styles/ok-conduct.md       # The conduct; body carries `Conduct version: X.Y.Z (Animal)`
```

## The single source of truth

`skills/_shared/artifact-definitions.md` canonically defines concept / story / decision / issue and the cross-cutting rules (self-containment, current-state-only, proof-protection, the issue-queue format). Skills transclude its `{{TOKEN}}` blocks into subagent dispatches or reference it directly. Never restate a definition inline in a skill — edit the shared file.

The intake queue (`.ok-planner/issues.jsonl` in consumer projects) is append-only: `open` rows from `/audit`, `/discover-design`, `/sprint`, humans; the terminal rows `promote` (naming the backlog that took the work) and `retire` only from `/sprint`. Legacy `resolve` rows from before the split are folded as terminal and never rewritten. `/prove` returns findings in-context and never writes the queue.

**Two words that must not blur.** The *intake queue* holds questions; the *sprint backlog* holds committed work. An issue crosses from one to the other by promotion, one-way, and from then on the backlog is the source of truth — nothing reads the queue to interpret a backlog. Never call `issues.jsonl` a backlog in any user-facing text.

The queue gate is **relevance-scoped, not an entry gate**: a feature-work `/sprint` drafts first, then a dedicated relevance reviewer splits the open issues into bearing vs. independent and only the bearing ones are walked with the owner. The justification is narrow and worth preserving in any rewording — building over a bearing issue *decides it silently*; an independent issue costs the sprint nothing by staying open. A sprint convened to work the queue takes the queue as its scope instead.

## How skills are wired

Every `SKILL.md` starts with YAML frontmatter; the "ONLY activated by explicit slash command" phrasing in `description` is load-bearing — it prevents Claude from invoking skills inferentially. Preserve it on new skills.

Skills do not chain into a pipeline. `/sprint` is terminal at the approved backlog; `/audit` and `/prove` are invoked by the user or by whoever executes a backlog's completion contract.

The artifact was called a "sprint spec" in `specs/` through 4.x. It is now the **sprint backlog** in `backlogs/`; `/true-up` migrates consumer projects by moving files (contents untouched, archived records keep their old wording).

## Versioning and releases

Two **independent** version numbers:

- **Plugin version** — semver in `.claude-plugin/plugin.json`, and it is the **suite** version: every plugin in the monorepo carries the same number, bumped together by the repo-root `/release` skill (see the README's Versioning section). Claude Code's update key: bump on every release or installs freeze. The true-up script stamps it into materialized `.ok-planner/CLAUDE.md` files (`{{OK_PLANNER_VERSION}}`), which is how a later true-up detects staleness. Do not hand-edit it, and do not bump ok-planner alone.
- **Conduct version** — `Conduct version: X.Y.Z (Animal)` as the first body line of `output-styles/ok-conduct.md`; bump (and advance the animal one letter) only when the conduct body changes. The stamp must stay in the body (frontmatter is stripped from the system prompt) and keep its prefix (the session-start hook and `/ok-version` grep it).

## Constraints

- Never commit `.claude/settings.local.json`.
- Do not create `.ok-planner/` artifacts in this repo unless dogfooding — those paths are conventions the skills write into *consumer* projects.
- No Node tooling; skills are markdown, hooks are bash.
