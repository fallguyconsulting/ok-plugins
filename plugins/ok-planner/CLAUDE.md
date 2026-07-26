# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Plugin purpose

`ok-planner` is the specification for an opinionated documentation corpus — concepts, stories (agile-style non-prescriptions of user need with a mandatory "so that" clause and a proof), decisions (technical choices, each with a proof) — plus the planning ceremony (`/plan-sprint`) that maintains it, the pre-commitment sketch verb (`/sketch`), the corpus verbs (`/audit`, `/prove`), the issue verifier (`/verify-issues`), the certification gates (`/certify-work` change-scoped for the everyday close, `/certify-all` whole-corpus on a cadence), the estate verb (`/true-up`), and the bootstrap (`/discover-design`). Execution works directly from the sprint document: `/plan-sprint` bakes a fixed "How to execute this sprint" section into every sprint it produces, so the sprint can be picked up inline, handed to the native `goal` mechanism, or dispatched to an orchestrator that does its own planning — every executor works from the same brief. `/certify-work` discharges the completion contract at the change's scope with the review cycles and a presentation; the shared certification machinery (fix loop, fixer, reviewer, presentation) lives once in `skills/_shared/certification-core.md`. The long-form execution shape also lives in the materialized files (`scripts/ok-planner-CLAUDE.md` has the long form, `scripts/ok-planner-cheatsheet.md` the pointer). There is still **no plan artifact**: a sprint is never rewritten into a plan; staging happens at execution time in the executor's own working state.

The deliverable is markdown `SKILL.md` files, the plugin manifest, an output style (`ok-conduct`), and bash hooks. There is no build and no test runner. This plugin lives at `plugins/ok-planner/` inside the `ok-plugins` marketplace monorepo; the marketplace manifest is at the repo root.

## Layout

```
.claude-plugin/plugin.json        # Plugin manifest (name/description/version)
hooks/hooks.json                  # Declares SessionStart + UserPromptSubmit
hooks/session-start               # Injects skills/ok-planner/SKILL.md as context; must stay executable
hooks/user-prompt-submit          # Per-turn ok-conduct attention refresher (jq-dependent, no-ops without it)
skills/<skill>/SKILL.md           # The skill prompts; frontmatter name/description required
skills/_shared/                   # Canonical artifact definitions, certification core, dispatch discipline, shared reviewer prompt (transclusion sources)
scripts/true-up                   # Deterministic layout script run by the true-up skill
scripts/ok-planner-CLAUDE.md      # Template materialized into consumer projects ({{OK_PLANNER_VERSION}} stamped by the script)
output-styles/ok-conduct.md       # The conduct; body carries `Conduct version: X.Y.Z (Animal)`
```

## The single source of truth

`skills/_shared/artifact-definitions.md` canonically defines concept / story / decision / issue and the cross-cutting rules (self-containment, current-state-only, proof-protection, the issue file format). Skills transclude its `{{TOKEN}}` blocks into subagent dispatches or reference it directly. Never restate a definition inline in a skill — edit the shared file.

The issue intake (`.ok-planner/issues/` in consumer projects) is one markdown file per issue, timestamped so filenames sort chronologically. Section ownership is strict: filers (`/audit`, `/discover-design`, `/plan-sprint`, humans) write Problem and Candidates; `/verify-issues` writes the from-the-top Discussion (closing corpus-answered issues with a citation); the owner — and only the owner — writes `## Ruling`. Files close through `/plan-sprint` (promoted into a sprint or retired) and move to `history/issues/` — retirements immediately, promotions when a certify gate archives their sprint. A legacy `issues.jsonl` is converted by `/verify-issues` and archived to `history/issues.jsonl`, its rows never rewritten. `/prove` returns findings in-context and never writes the intake.

**Two words that must not blur.** The *issue intake* holds questions; the *sprint* holds committed work. An issue crosses from one to the other by promotion, one-way, and from then on the sprint is the source of truth — nothing reads an issue file to interpret a sprint. Never call the intake a sprint in any user-facing text.

The intake gate is **relevance-scoped, not an entry gate**: a feature-work `/plan-sprint` pulls ruled issues straight in (a written ruling is the owner's decision — never re-litigated), then drafts, then a dedicated relevance reviewer splits the unruled open issues into bearing vs. independent and only the bearing ones are walked with the owner. The justification is narrow and worth preserving in any rewording — building over a bearing issue *decides it silently*; an independent issue costs the sprint nothing by staying open. A sprint convened to work the intake takes it as its scope instead.

## How skills are wired

Every `SKILL.md` starts with YAML frontmatter; the "ONLY activated by explicit slash command" phrasing in `description` is load-bearing — it prevents Claude from invoking skills inferentially. Preserve it on new skills.

Skills do not chain into a pipeline. `/plan-sprint` is terminal at the approved sprint; `/audit` and `/prove` are invoked by the user or by whoever executes a sprint's completion contract.

The artifact was called a "sprint spec" in `specs/` through 4.x. It is now the **sprint** in `sprints/`; `/true-up` migrates consumer projects by moving files (contents untouched, archived records keep their old wording).

## Versioning and releases

Two **independent** version numbers:

- **Plugin version** — semver in `.claude-plugin/plugin.json`, and it is the **suite** version: every plugin in the monorepo carries the same number, bumped together by the repo-root `/release` skill (see the README's Versioning section). Claude Code's update key: bump on every release or installs freeze. The true-up script stamps it into materialized `.ok-planner/CLAUDE.md` files (`{{OK_PLANNER_VERSION}}`), which is how a later true-up detects staleness. Do not hand-edit it, and do not bump ok-planner alone.
- **Conduct version** — `Conduct version: X.Y.Z (Animal)` as the first body line of `output-styles/ok-conduct.md`; bump (and advance the animal one letter) only when the conduct body changes. The stamp must stay in the body (frontmatter is stripped from the system prompt) and keep its prefix (the session-start hook and `/ok-version` grep it).

## Constraints

- Never commit `.claude/settings.local.json`.
- Do not create `.ok-planner/` artifacts in this repo unless dogfooding — those paths are conventions the skills write into *consumer* projects.
- No Node tooling; skills are markdown, hooks are bash, support scripts are bash or python.
