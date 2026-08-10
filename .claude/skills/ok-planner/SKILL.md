---
name: ok-planner
description: "ONLY activated by explicit slash command (/sketch, /verify-issues, /discover-design, /ok-version). Never auto-triggered by conversation content."
---

<SUBAGENT-STOP>
If you were dispatched as a subagent to execute a specific task, skip this skill.
</SUBAGENT-STOP>

## What ok-planner is

The specification for an opinionated documentation corpus — **concepts** (load-bearing nouns), **stories** (agile-style non-prescriptions of user need, each with a mandatory "so that" clause), **decisions** (project-specific technical choices) — plus this family's contribution to the ceremonies that maintain it. Implementation planning and execution are NOT ok-planner's job: a sprint's completion contract tells whoever executes it when the work is done (test suites clean, `/certify-work` closing).

**The ceremonies are the suite's, not this family's.** `/plan-sprint`, `/certify-work`, `/audit`, and `/document` are suite-owned verbs covering whichever estates a project has, and each reads what this family contributes from `.ok-planner/ceremony/<verb>.md`. That is where this family's planning, certification, audit, and documentation knowledge lives; the verbs below are what remains ok-planner's own.

**Executing a sprint needs no orchestrator.** A sprint is exactly that — disparate work items, no theme, no imposed order — and staging it into a sensible order is planning that belongs to execution, done at execution time by whoever does the work: an ordinary inline session is a first-class way to run one. The execution shape is written into every sprint document itself as a "How to execute this sprint" section, so the sprint can be picked up inline, handed to the native `goal` mechanism, or dispatched to an orchestrator that does its own planning. Never turn a sprint into a plan document.

**The intake holds questions; the sprint is truth.** `.ok-planner/issues/` holds one markdown file per question awaiting the owner's judgment. `/verify-issues` makes each file ruling-ready, and issues close only through `/plan-sprint`: promoted into that sprint (the file stamped with the sprint's name, moved to `history/issues/` when the implementation closes) or retired. Once promoted, an issue is settled: the sprint carries the whole resolution and is the source of truth for the work, and nothing reads the issue file to interpret it.

## The verbs

A router, not a briefing. Each row below is single-sourced from that skill's own frontmatter description — a repo maintenance check asserts row-description agreement, so a change starts at the description and the row follows. Read the skill body itself before running one. Invoke by slash command, or via the Skill tool (`ok-planner:<name>` from the installed plugin; the materialized name in a vendored project).

| Skill | What it does |
|-------|--------------|
| `/sketch` | Single-pass pre-commitment design sketch to .ok-planner/sketches/ — externalizes an idea to think about, sit on, or share; assumptions noted, no review loop, and no authorization to build. |
| `/discover-design` | Autonomous two-phase bootstrap of the design corpus: as-is discovery scaffolding, then extraction of the concept, story, and decision catalogs, filing judgment questions to the issue intake; aborts rather than overwrite human-edited artifacts. |
| `/verify-issues` | Makes every open issue ruling-ready without changing code or the corpus: converts any legacy issues.jsonl, closes issues the design corpus already answers, then — inline, in the main loop — rewrites each surviving issue as a single from-the-top narrative any engineer can read cold, ending in a marked generated or recommended ruling the owner accepts by silence or overrides; where the rules fully determine the fix, the ruling names that fix rather than applying it. |
| `/ok-version` | Read-only recital of the ok-planner plugin version and the conduct version this session is running; no disk read, no drift verdict. |

<!-- Materialized by ok-planner v15.2.0 — suite-owned; overwritten on converge; do not hand-edit. -->
