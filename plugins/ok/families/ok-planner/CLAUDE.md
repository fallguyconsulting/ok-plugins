# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Family purpose

`ok-planner` is the specification for an opinionated documentation corpus — concepts, stories (agile-style non-prescriptions of user need with a mandatory "so that" clause, each with a falsifier and a deterministic proof), decisions (technical choices; no proofs — their verification is the implementation audit) — plus the planning ceremony (`/plan-sprint`) that maintains it, the pre-commitment sketch verb (`/sketch`), the corpus verbs (`/audit`, `/prove`), the issue verifier (`/verify-issues`), the certification gates (`/certify-work` change-scoped for the everyday close, `/certify-all` whole-corpus on a cadence), and the bootstrap (`/discover-design`). Execution works directly from the sprint document: `/plan-sprint` bakes a fixed "How to execute this sprint" section into every sprint it produces, so the sprint can be picked up inline, handed to the native `goal` mechanism, or dispatched to an orchestrator that does its own planning — every executor works from the same brief. `/certify-work` discharges the completion contract at the change's scope with the review cycles and a presentation; the shared certification machinery (fix loop, fixer, reviewer, auditor, presentation) lives once in `skills/_shared/`. There is still **no plan artifact**: a sprint is never rewritten into a plan; staging happens at execution time in the executor's own working state.

This is a **skill family**, not a plugin: it lives at `plugins/ok/families/ok-planner/` as payload inside the front-door plugin, carries no manifest of its own (every version stamp derives from the front door's manifest), and reaches consumer projects only by vendoring. Administration — install, converge, repair — is the front door's (`/ok`), driven through this family's two conventional surfaces under `admin/`.

## Layout

```
admin/converge                    # Deterministic converge core (diagnose/converge/wire-hooks) — the surface /ok drives; vendors the skills into .claude/skills/
admin/ADMINISTRATION.md           # The administration document: retired-layout migrations, intake integrity, wiring consent — the judgment the core cannot encode
skills/<skill>/SKILL.md           # The skill prompts; frontmatter name/description required
skills/_shared/                   # Canonical artifact definitions, certification core, implementation auditor, dispatch discipline, shared reviewer prompt (transclusion sources)
scripts/audit-check               # Deterministic audit-corpus checker (python, exit 0/2/1): staleness via content anchors and file pins; materialized to consumer .ok-planner/bin/audit-check
scripts/surface-corpus            # Ceremony-time helper; materialized to consumer .ok-planner/scripts/
scripts/hooks/session-start       # The session-start hook implementation, materialized into .ok-planner/hooks/ and wired via a consented settings entry
scripts/ok-planner-CLAUDE.md      # Template materialized into consumer projects ({{OK_PLANNER_VERSION}} stamped by the converge core)
scripts/ok-planner-cheatsheet.md  # The always-in-context rules layer template
test/run.sh                       # audit-check proof harness (fixtures for staleness, citations, violations)
```

There are **no family-root hooks**: hook implementations are materialized project-side and reached through consented entries in each consumer's `.claude/settings.json`, per the integration contract. The user-facing skills are **vendored** into each consumer's `.claude/skills/` by the converge core (audit prefixed as `ok-planner-audit` under the contract's collision rule; sibling references rewritten — slash-command references only, never support-script paths); the family-side copies are the vendor source.

## The single source of truth

`skills/_shared/artifact-definitions.md` canonically defines concept / story / decision / issue and the cross-cutting rules (self-containment, current-state-only, proof-protection, the audit definition, the issue file format). Skills transclude its `{{TOKEN}}` blocks into subagent dispatches or reference it directly. Never restate a definition inline in a skill — edit the shared file.

**Verification splits two ways.** Stories carry proofs — deterministic integration tests or demos annotated `@story:<slug>`, run by `/prove`. Whether an implementation genuinely satisfies a story's or decision's claims is the **implementation audit**'s adversarial determination (`satisfied` | `violated`), written only by certification's auditor, recorded under the consumer's `.ok-planner/audits/`, citing code by content anchor; `audit-check` computes staleness and the re-audit set. Decisions carry no proofs.

The issue intake (`.ok-planner/issues/` in consumer projects) is one markdown file per issue, timestamped so filenames sort chronologically. Section ownership is strict: filers (`/audit`, `/discover-design`, `/plan-sprint`, humans) write Problem and Candidates; `/verify-issues` writes the from-the-top narrative (closing corpus-answered issues with a citation); the owner — and only the owner — writes unmarked `## Ruling` text. Files close through `/plan-sprint` (promoted into a sprint or retired) and move to `history/issues/` — retirements immediately, promotions when a certify gate archives their sprint. A legacy `issues.jsonl` is converted by `/verify-issues` and archived to `history/issues.jsonl`, its rows never rewritten. `/prove` returns findings in-context and never writes the intake.

**Two words that must not blur.** The *issue intake* holds questions; the *sprint* holds committed work. An issue crosses from one to the other by promotion, one-way, and from then on the sprint is the source of truth — nothing reads an issue file to interpret a sprint. Never call the intake a sprint in any user-facing text.

The intake gate is **relevance-scoped, not an entry gate**: a feature-work `/plan-sprint` pulls ruled issues straight in (a written ruling is the owner's decision — never re-litigated), then drafts, then a dedicated relevance reviewer splits the unruled open issues into bearing vs. independent and only the bearing ones are walked with the owner. The justification is narrow and worth preserving in any rewording — building over a bearing issue *decides it silently*; an independent issue costs the sprint nothing by staying open. A sprint convened to work the intake takes it as its scope instead.

## How skills are wired

Every `SKILL.md` starts with YAML frontmatter; the "ONLY activated by explicit slash command" phrasing in `description` is load-bearing — it prevents Claude from invoking skills inferentially. Preserve it on new skills.

Skills do not chain into a pipeline. `/plan-sprint` is terminal at the approved sprint; `/audit` and `/prove` are invoked by the user or by whoever executes a sprint's completion contract. Ceremonies ensure their own layout with a `mkdir -p`; estate convergence is the front door's administration, never a ceremony's.

The artifact was called a "sprint spec" in `specs/` through 4.x. It is now the **sprint** in `sprints/`; the administration migrates consumer projects by moving files (contents untouched, archived records keep their old wording) per `admin/ADMINISTRATION.md`.

## Versioning and releases

The suite version lives in the front-door manifest (`plugins/ok/.claude-plugin/plugin.json`), bumped by the repo-root `/release` skill; this family carries no version of its own. The converge core stamps the suite version into every materialized and vendored file (`{{OK_PLANNER_VERSION}}` in templates; the trailing stamp comment in vendored skills), which is how a later diagnose detects staleness. (The conduct version lives with the ok-conduct plugin, not here.)

## Constraints

- Never commit `.claude/settings.local.json`.
- Do not create `.ok-planner/` artifacts in this repo unless dogfooding — those paths are conventions the skills write into *consumer* projects.
- No Node tooling; skills are markdown, hooks are bash, support scripts are bash or python.
