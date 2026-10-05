# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Family purpose

`ok-planner` is the specification for an opinionated documentation corpus: concepts, stories, and decisions, verified by the periodic implementation audit. It is the one family the suite vendors: everything the front door puts into a project comes from this directory. This family owns the corpus, the issue intake, the sprint document, the review loop, and the project's coding standards — the plumbline cheatsheet and coding rules, the events and technical-writing standards, the subject and practice definitions, and the lint that checks them. It owns eight verbs — `/sketch`, `/discover-design`, `/plan-sprint`, `/converge`, `/triage-issues`, `/audit`, `/document`, `/ok-version`. `/audit` is the periodic run and `/document` the release documentation; each skill carries its own instructions whole and reads no per-family contribution.

Execution works directly from the sprint document. `/plan-sprint` bakes a fixed "How to execute this sprint" section into every sprint, so a sprint can be picked up inline, handed to the native `goal` mechanism, or dispatched to an orchestrator. Every executor works from the same brief: the session plans the work into the task tracker as build tasks, one stage each (`{{SPRINT-BUILD-PROMPT}}` in `skills/_sprint/shared.md`), drains them with the drain loop at `skills/_tasks/drain.md`, and closes the sprint with sprint certification (`/converge sprint <path>`). That run reviews the sprint's change for completion and regression against the implementation notes' rulings, runs the project's checks, drives the stories the sprint adds or amends, and fixes and verifies what it finds. It audits nothing; the corpus's claims are `/audit`'s question, on the owner's cadence. There is **no plan artifact**: a sprint is never rewritten into a plan, and staging happens at execution time, recorded in the sprint's task run and rendered into its completion report.

This is a **skill family**, not a plugin: it lives at `plugins/ok/families/ok-planner/` as payload inside the front-door plugin, carries no manifest of its own (version stamps derive from the front door's manifest), and reaches consumer projects only by vendoring. Administration — install, converge, repair — is the front door's (`/ok`), driven through this family's two files under `admin/`.

## Layout

```
admin/converge                    # Deterministic converge core (diagnose/converge/wire-hooks <group>/wire-env/resolve) — the file /ok drives; materializes the estate, rules files, scripts, and hooks, and vendors the skills and agent profiles
admin/ADMINISTRATION.md           # The administration document: retired-layout migrations, the retired-verb table, intake integrity, wiring consent — the judgment the core cannot encode
skills/<skill>/SKILL.md           # The skill prompts; frontmatter name/description required
agents/ok-<profile>.md            # The task tracker's agent profiles (model and effort pinned in frontmatter); vendored into .claude/agents/
skills/_shared/                   # Transclusion sources: artifact definitions, auditor prompt, dispatch discipline, compliance reviewer
skills/_sprint/shared.md          # Transclusion source shared by /plan-sprint and /converge: release boundaries, behavior rulings, the sprint build prompt, the sprint catalog
skills/_converge/                 # Transclusion source for /converge's agents: the coding rules
skills/_tasks/drain.md            # The task tracker's drain loop, no slash verb; /audit, /converge, /triage-issues, and sprint execution read it by path
skills/audit/                     # The periodic audit: SKILL.md, and goal.md, the brief the owner hands to the native goal mechanism
skills/document/                  # The release documentation: SKILL.md, and goal.md, its goal brief
docs/                             # The standards: events.md, technical-writing.md, and practice-definitions.md (materialized under .ok-planner/), plumbline-cheatsheet.md and plumbline-coding.md (materialized to .claude/rules/)
review/                           # The review estate template: CLAUDE.md and catalog/ (suite-owned), seed/ (config.json and project.md, seeded once); materialized to consumer .ok-planner/review/
scripts/surface-corpus            # The audit's surface helper; materialized to consumer .ok-planner/scripts/
scripts/tasks                     # The task tracker (tasks, keyed item pools, the claim model); materialized to consumer .ok-planner/bin/tasks
scripts/review                    # The review loop's mechanical verbs; materialized to consumer .ok-planner/bin/review
scripts/plumbline                 # The lint (node); materialized to consumer .ok-planner/bin/plumbline
scripts/catalog-toc               # The subject and practice TOC generator; materialized to consumer .ok-planner/bin/catalog-toc
scripts/run-tag                   # The per-run artifact tag; materialized to consumer .ok-planner/bin/run-tag
scripts/port-block                # The port reader; materialized to consumer .ok-planner/bin/port-block
scripts/hooks/session-start       # The session-start hook, materialized into .ok-planner/hooks/ and wired via a consented settings entry
scripts/hooks/post-edit.js        # The lint's edit hook (node), materialized into .ok-planner/hooks/ and wired via a consented settings entry
scripts/hooks/agent-model         # The subagent-model hook, materialized to .claude/hooks/ok-agent-model and wired via a consented settings entry
scripts/hooks/subagent-batching   # The subagent-batching hook, materialized to .claude/hooks/ok-subagent-batching and wired via a consented settings entry
scripts/ok-planner-CLAUDE.md      # Template materialized into consumer projects ({{OK_PLANNER_VERSION}} stamped by the converge core)
scripts/ok-planner-cheatsheet.md  # The always-in-context rules layer template
scripts/ok-cheatsheet.md          # The suite rules file template, materialized to .claude/rules/ok-cheatsheet.md
scripts/ok-concepts.md            # The fixed import file, materialized to .claude/rules/ok-concepts.md, that loads the concept index into every session
```

There are **no family-root hooks**: hook implementations are materialized project-side and reached through consented entries in each consumer's `.claude/settings.json`, per the integration contract. The converge core vendors this family's user-facing skills, `/audit` and `/document` among them, into each consumer's `.claude/skills/` under their bare names, rewriting sibling slash-command references (never support-script paths); the family-side copies are the vendor source.

## The single source of truth

`skills/_shared/artifact-definitions.md` canonically defines concept / story / decision / issue and the cross-cutting rules. Skills transclude its `{{TOKEN}}` blocks into subagent dispatches or reference it directly. Never restate a definition inline in a skill; edit the shared file.

**Verification is the audit's.** The periodic `/audit` run writes one audit per live artifact under the consumer's `.ok-planner/audits/`: an `implementation:` verdict (`supported` | `unsupported`) beside an independent `text:` reading (`compliant` | `noncompliant`). The run opens with the interactive intent stage (the owner walk that lands the surface intent at `.ok-planner/surface/surface.md`), dispatches the surface extractor (which writes `.ok-planner/audits/surface/extraction.json` and files intake issues for elements the intent does not settle), measures story support through the public surface on the maintained experiments, synthesizes and measures user-vantage assumptions on the same instrument, reads decision support adversarially against the code, and reads concept support as vocabulary. A `/document`-composed run adds the documentation walk right after the extractor returns; an à la carte run never runs it. An audit is one sentence to one paragraph about a named commit — every universal a count plus its population, no citations, hashes, or line numbers. Nothing computes staleness; whether an audit holds is how far `HEAD` has moved. The audit corpus and the intake are independent: the judge files intake issues for confirmed gaps, and no audit carries an `issue:` field. The run validates nothing: dispatch, collect, report, stamp — a malformed audit is rewritten whole by the next run.

The issue intake (`.ok-planner/issues/` in consumer projects) is one markdown file per issue, timestamped so filenames sort chronologically. The intake holds judgment issues and `category: defect` issues; the "Defect issues" section of `scripts/ok-planner-cheatsheet.md` defines both. Section ownership is strict: filers (`/converge`'s owner list, the audit judge, `/discover-design`, `/plan-sprint`, humans) write Problem and Candidates; `/triage-issues` routes each issue and writes the generated or recommended ruling; the owner alone writes unmarked `## Ruling` text. A judgment issue closes through `/plan-sprint`, promoted into a sprint or retired. A defect issue closes through `/converge`, fixed or answered. `/triage-issues` closes an issue the code, the corpus, or the tooling already settles, and retires a defect claim the accept list does not cover. Closed files move to `history/issues/`.

**Two words that must not blur.** The *issue intake* holds questions; the *sprint* holds committed work. An issue crosses by promotion, one-way, and from then on the sprint is the source of truth — nothing reads an issue file to interpret a sprint. Never call the intake a sprint in user-facing text.

The intake gate is **relevance-scoped, not an entry gate**: a feature-work `/plan-sprint` pulls ruled issues straight in (a written ruling is the owner's decision, never re-litigated), drafts, then a relevance reviewer splits the unruled open issues into bearing and independent, and only the bearing ones are walked with the owner. The justification is narrow and worth preserving in any rewording: building over a bearing issue decides it silently; an independent issue costs nothing by staying open. A sprint convened to work the intake takes it as its scope instead.

## How skills are wired

Every `SKILL.md` starts with YAML frontmatter; the "ONLY activated by explicit slash command" phrasing in `description` is load-bearing — it prevents Claude from invoking skills inferentially. Preserve it on new skills.

Skills do not chain into a pipeline. `/plan-sprint` is terminal at the approved sprint; sprint certification (`/converge sprint <path>`) is invoked by the user or by whoever executes a sprint's completion contract; `/converge` in its other modes and `/triage-issues` run on the owner's cadence; `/audit` runs on the owner's cadence; `/document` runs at a release, ensuring a current audit first. `/audit` and `/document` ensure their own layout with a `mkdir -p`; estate convergence is the front door's administration, never a skill's.

The artifact was called a "sprint spec" in `specs/` through 4.x. It is now the **sprint** in `sprints/`; the administration migrates consumer projects by moving files (contents untouched) per `admin/ADMINISTRATION.md`.

## Versioning and releases

The suite version lives in the front-door manifest (`plugins/ok/.claude-plugin/plugin.json`), bumped by the repo-root `/release` skill; this family carries no version of its own. The converge core stamps the suite version into every materialized and vendored file (`{{OK_PLANNER_VERSION}}` in templates; the trailing stamp comment in vendored skills), which is how a later diagnose detects staleness. The conduct version lives with the ok-conduct plugin, not here.

## Constraints

- Never commit `.claude/settings.local.json`.
- Do not create `.ok-planner/` artifacts in this repo unless dogfooding — those paths are conventions the skills write into *consumer* projects.
- The lint and its edit hook are node; everything else is bash or python. Skills are markdown. Nothing else this family ships or a consumer runs needs node, at runtime or at build time.
