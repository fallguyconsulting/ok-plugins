---
name: ok-planner
description: "ONLY activated by explicit slash command (/brainstorm, /write-plan, /review, /discover-design, /refine-design, etc). Never auto-triggered by conversation content."
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

## Available Skills

Invoke via the `Skill` tool with the `ok-planner:` prefix.

| Skill | When to use |
|-------|-------------|
| `ok-planner:affirm` | Invoked by other ok-planner skills before they produce or move artifacts; also user-invokable as `/affirm`. Unified create-or-update: creates `.ok-planner/{specs,plans,sketches,design,history/specs,history/plans,history/sketches}/` if absent, and writes or overwrites `.ok-planner/CLAUDE.md` to match the current template (skill-owned boilerplate — drift is overwritten without prompting). Idempotent — a project already in compliance is a silent no-op. |
| `ok-planner:discover-design` | User types `/discover-design`. Runs autonomously end-to-end via produce → review → fix loops. Two phases: (1) reads code + prose and writes as-is scaffolding to `.ok-planner/design/_discover/`; (2) extracts the four durable catalogs — `concepts/` (load-bearing nouns), `stories/` (user-outcome stories the product already delivers), `decisions/` (technical choices the project has made), and `tensions/` (muddiness catalog) — plus `review-notes.md` (agent-confessed uncertainty). Outputs are as-is, not prescriptive. Aborts rather than overwrite human-edited durable artifacts. |
| `ok-planner:refine-design` | User types `/refine-design`. Specialization of `brainstorm` for resolving design tensions. Read-only intake — user picks tensions and resolution shapes; decisions go into a brief — then hands off to `brainstorm` to produce a spec with a `## Design changes` section capturing the concept-doc mutations and tension moves, alongside the code reconciliation. Flows through `write-plan` → `execute-plan`. |
| `ok-planner:merge` | User types `/merge`. Surfaces merge-only design-doc inconsistencies (mechanical artifacts — slug collisions, broken annotations — and semantic conflicts where two branches edited the same artifact incompatibly) and runs a code review of the merge diff. Does NOT look for code-vs-doc drift — the spec pipeline changes docs and code as one unit, so drift cannot accumulate when the pipeline is followed. Read-only against `.ok-planner/design/` — findings are written to a transient report and the user takes them through `/brainstorm` or `/refine-design` to produce a reconciliation spec. |
| `ok-planner:coverage` | User types `/coverage`. Diagnostic for a project whose features shipped before acceptance scenarios existed — unit/integration tests green, but the assembled product was never driven end-to-end through its real value path. Read-only: enumerates the use cases the project *claims* to support (README, CLI verbs, routes, `concepts/`), subtracts what is *really* covered (rejecting stub-driven / tautological / shape-only tests as nominal-not-real), and writes a transient report to `.ok-planner/coverage/` — a ranked backlog of real gaps (each a proposed acceptance scenario) plus drift symptoms (claims with no real implementation: over-claim / half-built surface / concept drift). The user drives each gap through `/brainstorm → /write-plan → /execute-plan` (where the acceptance pass is mandatory) and each drift symptom through a cleanup spec that removes the false signal. Does not implement, does not run the product. |
| `ok-planner:sketch` | User types `/sketch`. Single-pass design sketch for a new feature, saved to `.ok-planner/sketches/`. Pre-spec, no review loop, no dialogue. Does not lead into write-plan. |
| `ok-planner:brainstorm` | User types `/brainstorm` |
| `ok-planner:write-plan` | You have an approved spec and need an implementation plan |
| `ok-planner:execute-plan` | You have a plan and want it driven to completion, then reviewed. Runs the plan pass by pass as a background `Workflow` with an implementer + single smart validator: dispatch the implementer; if DONE, dispatch one judgment-driven validator that reads the spec, the pass's Falsifier brief, and the diff and decides "was the work done?" — triaging every issue into BLOCKING (work materially fails the pass; fixer dispatches, validator re-runs) or DEFERRED (nits/polish/doc-rule; queue grows, pass advances). The validator persists every deferred entry to `<plan>-deferred.jsonl` adjacent to the plan via Bash before returning, so the queue is durable across aborts. No cycle caps; every wall event (validator persistent-blocking, implementer BLOCKED/INVALID_PLAN, fixer BLOCKED/coverage-gap, gate non-convergence) routes through the strategist, who either re-frames the next dispatch or confirms a genuine impasse. After all passes clear, a deferred-cleanup phase drains the queue with its own fixer ↔ reviewer loop; then a verification gate (build + test + lint discovered from project docs) and the no-deferral audit run as fixer-loops until clean; the completion auditor writes a four-section report (proofs working / decisions kept / decisions diverged / coverage divergences). Human-facing intake, escalation, final review (`review-work`), and the closing walk stay in the skill. |
| `ok-planner:execute-plan-in-worktree` | User types `/execute-plan-in-worktree`. Wraps `execute-plan` with isolation setup: creates a git worktree on a new branch, copies ephemeral local config (`.env*`) and the spec+plan into it, provisions fresh host ports if the project parameterizes them (docker-compose or `.env`), then `cd`s into the worktree and hands off to `execute-plan`. Use when the host project's dev stack is running and you want plan execution on a side branch without port/state collisions. |
| `ok-planner:review-work` | Review all uncommitted changes. Runs code review on the diff (cycle 1) and a focused design-doc compliance audit (cycle 2) — cycle 2 checks artifacts touched by the change (directly modified, slug-referenced in changed code, or named in an in-flight spec/plan). For whole-corpus design-doc audit, use `/review-design`. |
| `ok-planner:review-design` | User types `/review-design`. Whole-corpus compliance sweep of `.ok-planner/design/` against the canonical artifact rules. Use when accumulated drift in untouched files needs checking (after a rule tightening lands, after a `/discover-design` re-run, after a long quiet period, when `review-work` cycle 2 result is suspect). |
| `ok-planner:review-plan` | Review implementation against a spec/plan (interactive: lists plans) |
| `ok-planner:review-commits` | Review a commit range (interactive: shows history) |
| `ok-planner:review-files` | Deep review of specific files/directories (interactive: shows structure) |
| `ok-planner:review-feature` | Exploratory review of a feature area (interactive: asks questions) |
| `ok-planner:review-holistic` | Codebase-wide convergence review aimed at parsimony — finds real issues plus extraneous accretion (code/tests/features/docs that don't earn their keep). Use after large deliveries or when other review cycles have plateaued. Run until convergence. |
| `ok-planner:review-cleanup` | **Internal.** Invoked by review skills after issues are found. Drives the fix-review loop via subagent. Do NOT invoke directly — the review skills call it. |
| `ok-planner:verify` | You're about to claim work is complete |
| `ok-planner:ok-version` | User types `/ok-version`. Read-only. Recites the plugin version and `ok-conduct` conduct version **this session** is running (plugin from the session-start line, conduct from the active output style). No disk read and no drift verdict — if a version is not what you expect, investigate from there. |

## Artifact layout

All ok-planner skills read and write under `.ok-planner/` at the project
root (created on demand by `ok-planner:affirm`):

- `.ok-planner/specs/` — active specs from `/brainstorm` (including specs produced via `/refine-design`'s handoff to brainstorm)
- `.ok-planner/plans/` — active plans from `/write-plan`, plus the
  `-completion-report.md` reports written by `/execute-plan`'s
  completion auditor (the four-section closing-walk record: proofs
  working, decisions kept, decisions diverged, coverage divergences)
  and `-deferred.jsonl` queue files (the validator's durable
  deferred-finding record, archived to history alongside the plan
  at close)
- `.ok-planner/sketches/` — design sketches from `/sketch`
- `.ok-planner/design/` — durable design docs (bootstrapped by
  `/discover-design`; mutated only by `/execute-plan` carrying out
  spec-directed plan tasks). Layout: `_discover/` (as-is
  scaffolding), `concepts/` (load-bearing nouns with definitions +
  boundaries + invariants), `stories/` (durable user-outcome
  stories), `decisions/` (durable technical decisions), `tensions/`
  (catalog of muddy / unspecified / conflicting bits).
- `.ok-planner/history/specs/` and `.ok-planner/history/plans/` —
  archived specs and plans moved here automatically when an execute-*
  skill finishes a plan
- `.ok-planner/history/sketches/` — sketches moved here automatically
  by `/brainstorm` when it produces a spec from one or more source
  sketches
- `.ok-planner/coverage/` — transient acceptance-coverage reports from
  `/coverage` (`YYYY-MM-DD-coverage-report.md`), regenerated
  whole on each run; a disposable diagnostic, not a durable registry

Specs / plans / sketches / history / coverage reports are project
records kept out of context by default — committed parts of the project,
but not the source of truth and not pulled into context unprompted; do
not propose updating them to reflect codebase evolution. The design docs
under `design/` are the exception: they are durable, read freely, and
have the same source-of-truth weight as code, updated alongside the code
through `/execute-plan` runs.

## When Skills Activate

**ok-planner skills are NOT auto-triggered.** They activate when:
- The user explicitly types a slash command (e.g., `/brainstorm`, `/review`)
- A skill's output directs you to invoke the next skill in the pipeline (e.g., brainstorm leads to write-plan)

Do NOT invoke skills based on inference about what the user might want. Wait for the slash command.

## Model Selection

Always use the most capable model available. Do not downgrade models for "simple" tasks. The user pays for quality, not savings.

## Code Review: Fix Everything

When processing code review results: **fix every issue found, regardless of severity label or origin.** Do not triage. Do not defer. Do not note for later. The reviewer may categorize issues as Critical/Important/Minor -- ignore the categories and fix them all. This overrides any skill instruction that suggests deferring minor issues.

This includes pre-existing issues discovered during review. If the reviewer reports something was "already stale," "predates this work," or "out of scope," fix it anyway. If fixing a discovered issue requires pulling additional files into the review, expand the scope. Leaving known issues unfixed because they weren't part of the original task is never acceptable.

**Structural enforcement:** All review skills invoke `ok-planner:review-cleanup` after receiving reviewer output. This skill dispatches a fixer subagent and re-reviews until clean, removing the orchestrator's ability to triage. If you find yourself writing "acceptable," "noted for later," "cosmetic," or "out of scope" next to an unfixed issue — you are violating this rule. Stop and invoke review-cleanup instead.
