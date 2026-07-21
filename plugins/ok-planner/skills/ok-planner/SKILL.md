---
name: ok-planner
description: "ONLY activated by explicit slash command (/sprint, /audit, /prove, /discover-design, /affirm, /doctor, /ok-version). Never auto-triggered by conversation content."
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

The specification for an opinionated documentation corpus — **concepts** (load-bearing nouns), **stories** (agile-style non-prescriptions of user need, each with a mandatory "so that" clause and a proof), **decisions** (project-specific technical choices, each with a proof) — plus the planning ceremony that maintains it. Implementation planning and execution are NOT ok-planner's job: a sprint spec's completion contract tells whatever orchestrator executes it when the work is done (`/prove` clean, `/audit` run last).

## Available Skills

Invoke via the `Skill` tool with the `ok-planner:` prefix.

| Skill | When to use |
|-------|-------------|
| `ok-planner:affirm` | Invoked by other ok-planner skills before they produce artifacts; also user-invokable as `/affirm`. Runs the deterministic layout script: creates `.ok-planner/{specs,history/specs}/` and an empty `issues.jsonl` if absent, overwrites `.ok-planner/CLAUDE.md` from the version-stamped template. If a legacy pre-4.0 estate is detected (tensions/, plans/, sketches/…), performs the migration (tensions become issue rows). Idempotent. |
| `ok-planner:sprint` | User types `/sprint`. The planning ceremony. Entry gate: fold `issues.jsonl` and drain every open issue with the owner (only sprint writes `resolve` rows) — no new work is planned over an unstable design. Then intake dialogue → a sprint spec in `specs/`: **final-form corpus deltas** (complete artifact bodies — applying a delta IS updating the corpus), **work items**, and the fixed **completion contract** (corpus matches deltas; `/prove` clean; `/audit` run last). Sign-off review dispatches the shared compliance reviewer over the draft before the owner approves. Terminal: the approved spec — implementation happens elsewhere. |
| `ok-planner:discover-design` | User types `/discover-design`. Runs autonomously end-to-end via produce → review → fix loops. Two phases: (1) reads code + prose and writes as-is scaffolding to `.ok-planner/design/_discover/`; (2) extracts the durable catalogs — `concepts/`, `stories/`, `decisions/` — and appends judgment questions to `issues.jsonl` as open rows. Outputs are as-is, not prescriptive. Aborts rather than overwrite human-edited durable artifacts. |
| `ok-planner:audit` | User types `/audit`, or an implementation orchestrator runs it per a sprint spec's completion contract. Whole-corpus audit producing work items for a **human**: pass 1 checks every live artifact against the canonical rules (self-containment, current-state-only, story form incl. mandatory "so that", decision form incl. mandatory Proof); pass 2 checks proof coverage (every live story AND decision has an annotated proof artifact), intent drift, and annotation integrity. Mechanical findings are reported for the caller to fix in-cycle and re-run; judgment findings are appended by the audit itself to `issues.jsonl` (deduped against open ids) for the next `/sprint`. Its only write is that append. |
| `ok-planner:prove` | User types `/prove`, or an implementation orchestrator runs it per the completion contract. Executes every live story's and decision's proof (whole-corpus by default; caller may scope) and judges non-vacuity — a proof must be able to fail, and must not pass with the value-delivering component stubbed or absent. Findings return **in-context** as a structured report for the orchestrator's own triage; never writes the issue queue or any durable file. Clean = every in-scope artifact has ≥1 passing, non-vacuous proof. |
| `ok-planner:doctor` | User types `/doctor`, or `ok-doctor` drives it. Read-only estate upkeep per the ok-plugins integration contract: layout matches the current affirm tree, no legacy pre-4.0 residue, `.ok-planner/CLAUDE.md` version stamp matches the installed plugin, `issues.jsonl` parses. Reports drift + remedy (usually: run `/affirm`). Never drives corpus work — that's `/audit` and `/prove`. |
| `ok-planner:ok-version` | User types `/ok-version`. Read-only. Recites the plugin version and `ok-conduct` conduct version **this session** is running (plugin from the session-start line, conduct from the active output style). No disk read and no drift verdict — if a version is not what you expect, investigate from there. |

## Artifact layout

All ok-planner skills read and write under `.ok-planner/` at the project root (created on demand by `ok-planner:affirm`):

- `.ok-planner/design/` — the durable design corpus (bootstrapped by `/discover-design`; mutated only by applying an approved sprint spec's corpus deltas). Layout: `_discover/` (as-is scaffolding), `concepts/`, `stories/`, `decisions/`.
- `.ok-planner/issues.jsonl` — the append-only issue queue: the human-review backlog of design questions requiring owner judgment. Opened by `/audit` / `/discover-design` / `/sprint` / humans; resolved only in `/sprint`.
- `.ok-planner/specs/` — active sprint specs from `/sprint`.
- `.ok-planner/history/specs/` — archived specs, moved here by the implementation orchestrator when a spec's completion contract is met.

Specs and history are project records kept out of context by default — committed, but not the source of truth and not pulled into context unprompted. The design docs under `design/` are the exception: durable, read freely, the same source-of-truth weight as code. The issue queue is operational state: fold it when a skill needs it; don't editorialize it into prose summaries.

## When Skills Activate

**ok-planner skills are NOT auto-triggered.** They activate when:
- The user explicitly types a slash command (e.g., `/sprint`, `/audit`)
- A running skill or an executing sprint spec's completion contract directs the invocation (e.g., the contract's closing `/prove` + `/audit`)

Do NOT invoke skills based on inference about what the user might want. Wait for the slash command.

## Model Selection

Always use the most capable model available. Do not downgrade models for "simple" tasks. The user pays for quality, not savings.
