---
name: ok-planner
description: "ONLY activated by explicit slash command (/sprint, /sketch, /audit, /prove, /discover-design, /true-up, /ok-version). Never auto-triggered by conversation content."
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

The specification for an opinionated documentation corpus — **concepts** (load-bearing nouns), **stories** (agile-style non-prescriptions of user need, each with a mandatory "so that" clause and a proof), **decisions** (project-specific technical choices, each with a proof) — plus the planning ceremony that maintains it. Implementation planning and execution are NOT ok-planner's job: a sprint backlog's completion contract tells whoever executes it when the work is done (`/prove` clean, `/audit` run last).

**Executing a backlog needs no orchestrator.** A sprint backlog is exactly that — disparate work items, no theme, no imposed order — and staging it into a sensible order is planning that belongs to execution, done at execution time by whoever does the work: an ordinary inline session is a first-class way to run one. The execution shape (stage → apply deltas → build with proofs → completion contract → archive) is written out in the project's `.ok-planner/CLAUDE.md`; read it when asked to implement a backlog. Never turn a backlog into a plan document.

**The queue is intake; the backlog is truth.** `issues.jsonl` holds questions awaiting the owner's judgment. They leave it only in `/sprint` — promoted into that sprint's backlog (the row marked with the backlog's name) or retired. Once promoted, an issue is settled: the backlog carries the whole resolution and is the source of truth for the work, and nothing reads the queue to interpret it.

## Available Skills

Invoke via the `Skill` tool with the `ok-planner:` prefix.

| Skill | When to use |
|-------|-------------|
| `ok-planner:true-up` | Plumbing — normally driven by `/ok`, or invoked by other ok-planner skills before they produce artifacts; also user-invokable as `/true-up`. Diagnose → consent → converge: runs the deterministic layout script (creates `.ok-planner/{specs,sketches,history/specs,history/sketches}/` and an empty `issues.jsonl` if absent, overwrites `.ok-planner/CLAUDE.md` from the version-stamped template), checks issue-queue integrity, and if a pre-4.0 layout is detected (tensions/, plans/, coverage/…) proposes the migration for the owner's consent, then performs it (tensions become issue rows). Idempotent. |
| `ok-planner:sprint` | User types `/sprint`. The planning ceremony. Frames the session (feature work vs. working the intake queue) → intake dialogue → a **sprint backlog** in `backlogs/`: **final-form corpus deltas** (complete artifact bodies — applying a delta IS updating the corpus), **work items** (flat — no stages, no theme), and the fixed **completion contract** (corpus matches deltas; `/prove` clean; `/audit` run last). The intake queue is then consulted against the draft: a dedicated relevance reviewer splits open issues into bearing vs. independent, and only the bearing ones are walked with the owner — each promoted into the backlog (a `promote` row naming it, written after sign-off) or retired. A queue-drain sprint walks the whole queue instead. Sign-off review dispatches the shared compliance reviewer over the draft before the owner approves. Terminal: the approved backlog — execution is a separate act, inline or orchestrated. |
| `ok-planner:sketch` | User types `/sketch`. Single-pass, pre-commitment design sketch to `.ok-planner/sketches/YYYY-MM-DD-<topic>-sketch.md`: externalize an idea to think about, sit on, or share — reasonable assumptions noted, no review loop, no dialogue. Not authorization to build: the path to building is sketch → `/sprint` → spec. Writes nothing but the sketch file. |
| `ok-planner:discover-design` | User types `/discover-design`. Runs autonomously end-to-end via produce → review → fix loops. Two phases: (1) reads code + prose and writes as-is scaffolding to `.ok-planner/design/_discover/`; (2) extracts the durable catalogs — `concepts/`, `stories/`, `decisions/` — and appends judgment questions to `issues.jsonl` as open rows. Outputs are as-is, not prescriptive. Aborts rather than overwrite human-edited durable artifacts. |
| `ok-planner:audit` | User types `/audit`, or whoever is executing a sprint backlog runs it per the completion contract. Whole-corpus audit producing work items for a **human**: pass 1 checks every live artifact against the canonical rules (self-containment, current-state-only, story form incl. mandatory "so that", decision form incl. mandatory Proof); pass 2 checks proof coverage (every live story AND decision has an annotated proof artifact), intent drift, and annotation integrity. Mechanical findings are reported for the caller to fix in-cycle and re-run; judgment findings are appended by the audit itself to `issues.jsonl` (deduped against open ids) for the next `/sprint`. Its only write is that append. |
| `ok-planner:prove` | User types `/prove`, or whoever is executing a sprint backlog runs it per the completion contract. Executes every live story's and decision's proof (whole-corpus by default; caller may scope) and judges non-vacuity — a proof must be able to fail, and must not pass with the value-delivering component stubbed or absent. Findings return **in-context** as a structured report for the caller's own triage; never writes the issue queue or any durable file. Clean = every in-scope artifact has ≥1 passing, non-vacuous proof. |
| `ok-planner:ok-version` | User types `/ok-version`. Read-only. Recites the plugin version and `ok-conduct` conduct version **this session** is running (plugin from the session-start line, conduct from the active output style). No disk read and no drift verdict — if a version is not what you expect, investigate from there. |

## Artifact layout

All ok-planner skills read and write under `.ok-planner/` at the project root (created on demand by `ok-planner:true-up`):

- `.ok-planner/design/` — the durable design corpus (bootstrapped by `/discover-design`; mutated only by applying an approved sprint backlog's corpus deltas). Layout: `_discover/` (as-is scaffolding), `concepts/`, `stories/`, `decisions/`.
- `.ok-planner/issues.jsonl` — the append-only intake queue: design questions requiring owner judgment. Opened by `/audit` / `/discover-design` / `/sprint` / humans; terminated only in `/sprint`, by promotion into a backlog or retirement.
- `.ok-planner/backlogs/` — active sprint backlogs from `/sprint`.
- `.ok-planner/sketches/` — pre-commitment design sketches from `/sketch`; live while the idea is open.
- `.ok-planner/history/backlogs/` — archived backlogs, moved here by whoever executed one once its completion contract is met. On migrated projects it may sit beside `history/specs/`, the pre-rename archive.
- `.ok-planner/history/sketches/` — sketches archived per file when the idea is taken up (via `/sprint`) or abandoned.

Backlogs, sketches, and history are project records kept out of context by default — committed, but not the source of truth and not pulled into context unprompted. The exceptions: the design docs under `design/` are durable, read freely, with the same source-of-truth weight as code; and the backlog you are actively executing is in context for as long as you are executing it. The intake queue is operational state: fold it when a skill needs it; don't editorialize it into prose summaries.

## When Skills Activate

**ok-planner skills are NOT auto-triggered.** They activate when:
- The user explicitly types a slash command (e.g., `/sprint`, `/audit`)
- A running skill or an executing sprint backlog's completion contract directs the invocation (e.g., the contract's closing `/prove` + `/audit`)

Do NOT invoke skills based on inference about what the user might want. Wait for the slash command.

## Model Selection

Always use the most capable model available. Do not downgrade models for "simple" tasks. The user pays for quality, not savings.
