# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Family purpose

`ok-planner` is the specification for an opinionated documentation corpus: concepts, stories, and decisions, verified by the periodic implementation audit. This family owns the corpus, the issue intake, and the sprint document. It owns four verbs of its own — `/sketch`, `/verify-issues`, `/discover-design`, `/ok-version`. **The ceremonies are the suite's**: `/plan-sprint`, `/certify-work`, `/audit`, and `/document` are hoisted verbs covering whichever estates a project has, and what this family contributes to each lives in `ceremony/<verb>.md`, materialized into `.ok-planner/ceremony/`.

Execution works directly from the sprint document. The planning ceremony bakes a fixed "How to execute this sprint" section into every sprint, so a sprint can be picked up inline, handed to the native `goal` mechanism, or dispatched to an orchestrator; every executor works from the same brief: a builder and a standing reviewer the session relays, one stage at a time, the reviewer under the same code-review brief the gate runs cold (`{{STANDING-REVIEWER-PROMPT}}` in `skills/_shared/certification-core.md`), and `/certify-work` immediately after as the cold regression. `/certify-work` discharges the completion contract at the change's scope and audits nothing; the corpus's claims are `/audit`'s question, on the owner's cadence. There is **no plan artifact**: a sprint is never rewritten into a plan, and staging happens at execution time, recorded in the sprint's completion report.

This is a **skill family**, not a plugin: it lives at `plugins/ok/families/ok-planner/` as payload inside the front-door plugin, carries no manifest of its own (version stamps derive from the front door's manifest), and reaches consumer projects only by vendoring. Administration — install, converge, repair — is the front door's (`/ok`), driven through this family's two files under `admin/`.

## Layout

```
admin/converge                    # Deterministic converge core (diagnose/converge/wire-hooks) — the file /ok drives; vendors the skills into .claude/skills/
admin/ADMINISTRATION.md           # The administration document: retired-layout migrations, intake integrity, wiring consent — the judgment the core cannot encode
skills/<skill>/SKILL.md           # The skill prompts; frontmatter name/description required
skills/_shared/                   # Transclusion sources: artifact definitions, sprint document, certification core, auditor and judge prompts, dispatch discipline, compliance reviewer
ceremony/<verb>.md                # This family's contribution to each suite ceremony, materialized into .ok-planner/ceremony/ — beside audit-goal.md and document-goal.md, the vendored goal files
scripts/surface-corpus            # Ceremony-time helper; materialized to consumer .ok-planner/scripts/
scripts/hooks/session-start       # The session-start hook, materialized into .ok-planner/hooks/ and wired via a consented settings entry
scripts/ok-planner-CLAUDE.md      # Template materialized into consumer projects ({{OK_PLANNER_VERSION}} stamped by the converge core)
scripts/ok-planner-cheatsheet.md  # The always-in-context rules layer template
test/stories.sh                   # Story-level integration tests, annotated @story: for navigation
```

There are **no family-root hooks**: hook implementations are materialized project-side and reached through consented entries in each consumer's `.claude/settings.json`, per the integration contract. The converge core vendors this family's user-facing skills into each consumer's `.claude/skills/` under their bare names, rewriting sibling slash-command references (never support-script paths); the family-side copies are the vendor source. The suite's own converge core vendors the ceremony verbs.

## The single source of truth

`skills/_shared/artifact-definitions.md` canonically defines concept / story / decision / issue and the cross-cutting rules. Skills transclude its `{{TOKEN}}` blocks into subagent dispatches or reference it directly. Never restate a definition inline in a skill; edit the shared file.

**Verification is the audit's.** The periodic `/audit` run writes one audit per live artifact under the consumer's `.ok-planner/audits/`: an `implementation:` verdict (`supported` | `unsupported`) beside an independent `text:` reading (`compliant` | `noncompliant`). The run opens with the interactive intent stage (the owner walk that lands the surface intent at `.ok-planner/surface/surface.md`), dispatches the surface extractor (which writes `.ok-planner/audits/surface/extraction.json` and files intake issues for elements the intent does not settle), measures story support through the public surface on the maintained experiments, synthesizes and measures user-vantage assumptions on the same instrument, and reads decision and concept support adversarially against the code. A `/document`-composed run adds the documentation walk right after the extractor returns; an à la carte run never runs it. An audit is one sentence to one paragraph about a named commit — every universal a count plus its population, no citations, hashes, or line numbers. Nothing computes staleness; whether an audit holds is how far `HEAD` has moved. The audit corpus and the intake are independent: the judge files intake issues for confirmed gaps, and no audit carries an `issue:` field. The run validates nothing: dispatch, collect, report, stamp — a malformed audit is rewritten whole by the next run.

The issue intake (`.ok-planner/issues/` in consumer projects) is one markdown file per issue, timestamped so filenames sort chronologically. Section ownership is strict: filers (certification's architect, the audit judge, `/discover-design`, `/plan-sprint`, humans) write Problem and Candidates; `/verify-issues` writes the from-the-top narrative and closes corpus-answered issues with a citation; the owner alone writes unmarked `## Ruling` text. Files close through `/plan-sprint` — promoted into a sprint or retired — and move to `history/issues/`: retirements immediately, promotions when the certify gate archives their sprint. `/verify-issues` converts a legacy `issues.jsonl` and archives it to `history/issues.jsonl`; its rows are never rewritten.

**Two words that must not blur.** The *issue intake* holds questions; the *sprint* holds committed work. An issue crosses by promotion, one-way, and from then on the sprint is the source of truth — nothing reads an issue file to interpret a sprint. Never call the intake a sprint in user-facing text.

The intake gate is **relevance-scoped, not an entry gate**: a feature-work `/plan-sprint` pulls ruled issues straight in (a written ruling is the owner's decision, never re-litigated), drafts, then a relevance reviewer splits the unruled open issues into bearing and independent, and only the bearing ones are walked with the owner. The justification is narrow and worth preserving in any rewording: building over a bearing issue decides it silently; an independent issue costs nothing by staying open. A sprint convened to work the intake takes it as its scope instead.

## How skills are wired

Every `SKILL.md` starts with YAML frontmatter; the "ONLY activated by explicit slash command" phrasing in `description` is load-bearing — it prevents Claude from invoking skills inferentially. Preserve it on new skills.

Skills do not chain into a pipeline. `/plan-sprint` is terminal at the approved sprint; `/certify-work` is invoked by the user or by whoever executes a sprint's completion contract; `/audit` runs on the owner's cadence; `/document` runs at a release, ensuring a current audit first. Ceremonies ensure their own layout with a `mkdir -p`; estate convergence is the front door's administration, never a ceremony's.

The artifact was called a "sprint spec" in `specs/` through 4.x. It is now the **sprint** in `sprints/`; the administration migrates consumer projects by moving files (contents untouched) per `admin/ADMINISTRATION.md`.

## Versioning and releases

The suite version lives in the front-door manifest (`plugins/ok/.claude-plugin/plugin.json`), bumped by the repo-root `/release` skill; this family carries no version of its own. The converge core stamps the suite version into every materialized and vendored file (`{{OK_PLANNER_VERSION}}` in templates; the trailing stamp comment in vendored skills), which is how a later diagnose detects staleness. The conduct version lives with the ok-conduct plugin, not here.

## Constraints

- Never commit `.claude/settings.local.json`.
- Do not create `.ok-planner/` artifacts in this repo unless dogfooding — those paths are conventions the skills write into *consumer* projects.
- No Node tooling anywhere: skills are markdown, hooks are bash, support scripts are bash or python. Nothing this family ships or a consumer runs needs node, at runtime or at build time.
