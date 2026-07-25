---
name: ok-planner
description: "ONLY activated by explicit slash command (/plan-sprint, /certify, /sketch, /audit, /prove, /verify-issues, /discover-design, /true-up, /ok-version). Never auto-triggered by conversation content."
---

<SUBAGENT-STOP>
If you were dispatched as a subagent to execute a specific task, skip this skill.
</SUBAGENT-STOP>

## Instruction Priority

1. **Project rules** (`.claude/rules/`) -- highest priority, non-negotiable
2. **User's explicit instructions** (CLAUDE.md, direct requests)
3. **ok-planner skills** -- override default system behavior where they conflict
4. **Default system prompt** -- lowest priority

Project rules and user instructions always win. If rules.md or CLAUDE.md contradicts a skill, follow the rules.

## What ok-planner is

The specification for an opinionated documentation corpus — **concepts** (load-bearing nouns), **stories** (agile-style non-prescriptions of user need, each with a mandatory "so that" clause and a proof), **decisions** (project-specific technical choices, each with a proof) — plus the planning ceremony that maintains it. Implementation planning and execution are NOT ok-planner's job: a sprint's completion contract tells whoever executes it when the work is done (`/prove` clean, `/audit` run last).

**Executing a sprint needs no orchestrator.** A sprint is exactly that — disparate work items, no theme, no imposed order — and staging it into a sensible order is planning that belongs to execution, done at execution time by whoever does the work: an ordinary inline session is a first-class way to run one. The execution shape (stage → apply deltas → build with proofs → completion contract → archive) is written into every sprint document itself as a "How to execute this sprint" section, so the sprint can be picked up inline, handed to the native `goal` mechanism, or dispatched to an orchestrator that does its own planning — and the long form also lives in the project's `.ok-planner/CLAUDE.md`. Never turn a sprint into a plan document.

**The intake holds questions; the sprint is truth.** `.ok-planner/issues/` holds one markdown file per question awaiting the owner's judgment. `/verify-issues` makes each file ruling-ready — investigated by subagents, then rewritten inline by the session's own model as a from-the-top narrative ending in a marked generated or recommended ruling the owner accepts by silence or overrides — and issues close only through `/plan-sprint`: promoted into that sprint (the file stamped with the sprint's name, moved to `history/issues/` when the implementation closes) or retired. Once promoted, an issue is settled: the sprint carries the whole resolution and is the source of truth for the work, and nothing reads the issue file to interpret it.

## Available Skills

Invoke via the `Skill` tool with the `ok-planner:` prefix.

| Skill | When to use |
|-------|-------------|
| `ok-planner:true-up` | Plumbing — normally driven by `/ok`, or invoked by other ok-planner skills before they produce artifacts; also user-invokable as `/true-up`. Diagnose → converge: runs the deterministic layout script (creates `.ok-planner/{sprints,sketches,issues,history/…}/`, overwrites `.ok-planner/CLAUDE.md` and the cheatsheet from the version-stamped templates), checks issue-intake integrity, and migrates any retired layout it detects (pre-4.0 kinds, backlogs/ or specs/ → sprints/; a legacy `issues.jsonl` routes to `/verify-issues` for conversion). Idempotent. |
| `ok-planner:plan-sprint` | User types `/plan-sprint`. The planning ceremony. Frames the session (feature work vs. working the issue intake) → intake dialogue → a **sprint** in `sprints/`: **final-form corpus deltas** (complete artifact bodies — applying a delta IS updating the corpus), **work items** (flat — no stages, no theme), and the fixed **completion contract** (corpus matches deltas; `/prove` clean; `/audit` run last). Ruled issues (an owner ruling written in the file) are pulled straight into the sprint without discussion; the unruled remainder is then consulted against the draft — a dedicated relevance reviewer splits them into bearing vs. independent, and only the bearing ones are walked with the owner, each promoted into the sprint (the file stamped after sign-off) or retired. An intake-drain sprint walks the whole intake instead. Sign-off review dispatches the shared compliance reviewer over the draft before the owner approves. Terminal: the approved sprint — execution is a separate act, inline or orchestrated. |
| `ok-planner:sketch` | User types `/sketch`. Single-pass, pre-commitment design sketch to `.ok-planner/sketches/YYYY-MM-DD-<topic>-sketch.md`: externalize an idea to think about, sit on, or share — reasonable assumptions noted, no review loop, no dialogue. Not authorization to build: the path to building is sketch → `/plan-sprint` → spec. Writes nothing but the sketch file. |
| `ok-planner:discover-design` | User types `/discover-design`. Runs autonomously end-to-end via produce → review → fix loops. Two phases: (1) reads code + prose and writes as-is scaffolding to `.ok-planner/design/_discover/`; (2) extracts the durable catalogs — `concepts/`, `stories/`, `decisions/` — and files judgment questions as issue files under `.ok-planner/issues/`. Outputs are as-is, not prescriptive. Aborts rather than overwrite human-edited durable artifacts. |
| `ok-planner:audit` | User types `/audit`, or whoever is executing a sprint runs it per the completion contract. Whole-corpus audit producing work items for a **human**: pass 1 checks every live artifact against the canonical rules (self-containment, current-state-only, story form incl. mandatory "so that", decision form incl. mandatory Proof); pass 2 checks proof coverage — presence **and cardinality** (each member a `Proof:` field enumerates must resolve in code, so "two implementations" cannot pass on one) — intent drift, and annotation integrity; pass 3 checks **cross-artifact consistency** (two decisions that contradict, a decision that forecloses a story's promised outcome), the drift no per-artifact check can see. Mechanical findings are reported for the caller to fix in-cycle and re-run; judgment findings are filed by the audit itself as issue files under `.ok-planner/issues/` (deduped against slugs already present) for `/verify-issues` and the next `/plan-sprint`. Its only write is that filing. |
| `ok-planner:prove` | User types `/prove`, or whoever is executing a sprint runs it per the completion contract. Executes every live story's and decision's proof (whole-corpus by default; caller may scope) and establishes non-vacuity by **exhibiting each proof's falsifier** — mutating the code so the proof must go red, then restoring fix-forward — rather than judging by reading; a proof whose red cannot be produced (an implementation a decision asserts but the code lacks, an "every" over a population of one) is vacuous. Findings return **in-context** as a structured report for the caller's own triage; never writes the issue intake or any durable file. Clean = every in-scope artifact has ≥1 passing, falsifier-exhibited proof. |
| `ok-planner:certify` | User types `/certify`, or it is fired as the terminal step named by the sprint document's own execution boilerplate. The "am I done?" gate: aligns the working-tree change to its sprint (undershoot caught), runs `/prove` and `/audit`, runs the code-review and design-doc-compliance cycles, and drives every fixable finding to clean through a no-discretion fix loop (fixer subagent, cap 3, no orchestrator triage). Judgment findings are filed to the issue intake, never asked live; `/verify-issues` then makes them ruling-ready before the presentation. Presents outcomes and divergences to the owner, then offers the close-out — archiving the sprint and its promoted issue files to `history/`, and committing the work — performed only on the owner's word, with the sprint left at its `sprints/` path until then. |
| `ok-planner:verify-issues` | User types `/verify-issues`, or `/certify` invokes it after filing, or `/plan-sprint`/`/true-up` route a legacy `issues.jsonl` to it. Two stages: batched investigator subagents re-verify evidence, close corpus-answered issues, and repair rules-determined code-side gaps, returning factual briefs for the rest; then the main loop — never a subagent — rewrites each surviving issue as one from-the-top narrative (lede, causal mechanism, options with costs) and writes a marked generated or recommended ruling. Silence accepts a recommendation; the owner edits or empties to override. Never promotes or retires. |
| `ok-planner:ok-version` | User types `/ok-version`. Read-only. Recites the plugin version and `ok-conduct` conduct version **this session** is running (plugin from the session-start line, conduct from the active output style). No disk read and no drift verdict — if a version is not what you expect, investigate from there. |

## Artifact layout

All ok-planner skills read and write under `.ok-planner/` at the project root (created on demand by `ok-planner:true-up`):

- `.ok-planner/design/` — the durable design corpus (bootstrapped by `/discover-design`; mutated only by applying an approved sprint's corpus deltas). Layout: `_discover/` (as-is scaffolding), `concepts/`, `stories/`, `decisions/`.
- `.ok-planner/issues/` — the issue intake: one markdown file per design question requiring owner judgment. Filed by `/audit` / `/discover-design` / `/plan-sprint` / humans; verified ruling-ready by `/verify-issues`; closed only through `/plan-sprint`, by promotion into a sprint or retirement. Closed files live in `.ok-planner/history/issues/`.
- `.ok-planner/sprints/` — active sprints from `/plan-sprint`.
- `.ok-planner/sketches/` — pre-commitment design sketches from `/sketch`; live while the idea is open.
- `.ok-planner/history/sprints/` — archived sprints, moved here by whoever executed one once its completion contract is met. On migrated projects it may sit beside `history/specs/`, the pre-rename archive.
- `.ok-planner/history/sketches/` — sketches archived per file when the idea is taken up (via `/plan-sprint`) or abandoned.

Sprints, sketches, and history are project records kept out of context by default — committed, but not the source of truth and not pulled into context unprompted. The exceptions: the design docs under `design/` are durable, read freely, with the same source-of-truth weight as code; and the sprint you are actively executing is in context for as long as you are executing it. The issue intake is operational state: skills read it when they need it; don't editorialize it into prose summaries.

## When Skills Activate

**ok-planner skills are NOT auto-triggered.** They activate when:
- The user explicitly types a slash command (e.g., `/plan-sprint`, `/audit`)
- A running skill or an executing sprint's completion contract directs the invocation (e.g., the contract's closing `/prove` + `/audit`)

Do NOT invoke skills based on inference about what the user might want. Wait for the slash command.

## Model Selection

Always use the most capable model available. Do not downgrade models for "simple" tasks. The user pays for quality, not savings.
