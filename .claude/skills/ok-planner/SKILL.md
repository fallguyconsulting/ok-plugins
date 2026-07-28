---
name: ok-planner
description: "ONLY activated by explicit slash command (/plan-sprint, /certify-work, /certify-all, /sketch, /ok-planner-audit, /prove, /verify-issues, /discover-design, /ok-version). Never auto-triggered by conversation content."
---

<SUBAGENT-STOP>
If you were dispatched as a subagent to execute a specific task, skip this skill.
</SUBAGENT-STOP>

## What ok-planner is

The specification for an opinionated documentation corpus — **concepts** (load-bearing nouns), **stories** (agile-style non-prescriptions of user need, each with a mandatory "so that" clause and a proof), **decisions** (project-specific technical choices, each with a proof) — plus the planning ceremony that maintains it. Implementation planning and execution are NOT ok-planner's job: a sprint's completion contract tells whoever executes it when the work is done (`/prove` clean, `/certify-work` closing).

**Executing a sprint needs no orchestrator.** A sprint is exactly that — disparate work items, no theme, no imposed order — and staging it into a sensible order is planning that belongs to execution, done at execution time by whoever does the work: an ordinary inline session is a first-class way to run one. The execution shape is written into every sprint document itself as a "How to execute this sprint" section, so the sprint can be picked up inline, handed to the native `goal` mechanism, or dispatched to an orchestrator that does its own planning. Never turn a sprint into a plan document.

**The intake holds questions; the sprint is truth.** `.ok-planner/issues/` holds one markdown file per question awaiting the owner's judgment. `/verify-issues` makes each file ruling-ready, and issues close only through `/plan-sprint`: promoted into that sprint (the file stamped with the sprint's name, moved to `history/issues/` when the implementation closes) or retired. Once promoted, an issue is settled: the sprint carries the whole resolution and is the source of truth for the work, and nothing reads the issue file to interpret it.

## The verbs

A router, not a briefing. Each row below is single-sourced from that skill's own frontmatter description — a repo maintenance check asserts row-description agreement, so a change starts at the description and the row follows. Read the skill body itself before running one. Invoke by slash command, or via the Skill tool (`ok-planner:<name>` from the installed plugin; the materialized name in a vendored project).

| Skill | What it does |
|-------|--------------|
| `/plan-sprint` | The planning ceremony: pulls ruled issues in, reconciles work done out of band since the last close (detected from the previous sprint's closing-commit stamp), drafts final-form corpus deltas and flat work items with the owner, resolves the open issues that bear on the work, and terminates at an approved, self-sufficient sprint with a fixed completion contract — execution is a separate act. |
| `/sketch` | Single-pass pre-commitment design sketch to .ok-planner/sketches/ — externalizes an idea to think about, sit on, or share; assumptions noted, no review loop, and no authorization to build. |
| `/discover-design` | Autonomous two-phase bootstrap of the design corpus: as-is discovery scaffolding, then extraction of the concept, story, and decision catalogs, filing judgment questions to the issue intake; aborts rather than overwrite human-edited artifacts. |
| `/ok-planner-audit` | A pure reporter: findings return in-context, nothing is written. |
| `/prove` | Executes every in-scope story proof deterministically; findings return in-context to the caller and never write the issue intake. |
| `/verify-issues` | Drains every obvious issue and makes the rest ruling-ready: converts any legacy issues.jsonl, closes issues the design corpus already answers, repairs the gaps the rules fully determine (code- or corpus-side, so long as no commitment changes), then — inline, in the main loop — rewrites each surviving issue as a single from-the-top narrative any engineer can read cold, ending in a marked generated or recommended ruling the owner accepts by silence or overrides. |
| `/certify-work` | Change-scoped certification: certifies the work just done — the uncommitted tree by default, a commit range on request — running prove, the implementation audits (the re-audit set from citation staleness plus adjudicated change-inspection nominations), and the corpus checks over only what the change touched, the code review over the diff, a no-discretion review-fix loop (fixer, then an architect on kickbacks), and the presentation — reconciliation ledger included — with archival/commit offered as owner acts. Whole-corpus certification is /certify-all. |
| `/certify-all` | The whole-corpus certification gate: runs /prove and /ok-planner-audit over the entire corpus plus the review cycles, drives every finding to fixed-or-promoted through the no-discretion review-fix loop (fixer, then an architect on kickbacks), presents outcomes and divergences to the user, then offers archival and commit as owner acts. Cost scales with the corpus, not the change — the everyday, change-scoped close is /certify-work. |
| `/ok-version` | Read-only recital of the ok-planner plugin version and the conduct version this session is running; no disk read, no drift verdict. |

<!-- Materialized by ok-planner v11.1.0 — suite-owned; overwritten on converge; do not hand-edit. -->
