---
name: prove
description: "ONLY activated by explicit /prove slash command or by whoever is executing a sprint backlog's completion contract — an inline session or an orchestrator. Never auto-triggered by conversation content."
---

# Prove the Corpus

Execute every live story's and decision's proof and report which are missing, failing, or vacuous. A sprint's work is not done until this comes back clean.

`/prove` produces work items for an **agent**, not a human: its findings return in-context as a structured report the executing agent consumes with its own triage. It **never writes to `.ok-planner/issues.jsonl`** — the human backlog belongs to `/audit`. If a prove finding turns out to need owner judgment (an intent question, not a broken proof), the escalation path is the next `/audit` catching the underlying corpus problem.

Read `{{PROOF-PROTECTION-RULE}}` in `skills/_shared/artifact-definitions.md` before starting — it defines what a proof is, the annotation link, and non-vacuity.

## Scope

Default: every live story under `.ok-planner/design/stories/` and every live decision under `.ok-planner/design/decisions/`. The caller may narrow with an argument (a list of slugs, or a backlog path whose deltas name the touched artifacts) — but the completion-contract invocation runs whole-corpus: touched artifacts must pass, and untouched artifacts must not have regressed.

## Process

1. **Collect.** For each in-scope artifact, read its slug and `Proof:` field, then find its proof artifacts: `rg -l '@story:\s*<slug>'` / `rg -l '@decision:\s*<slug>'` across the codebase (excluding `.ok-planner/`, `.git/`, build outputs, vendored deps). Zero matches → verdict `missing`, done with that artifact.

2. **Discover the run harness.** Proofs are project-shaped: tests run by the project's test runner, demos with a documented invocation, lint/dependency gates run by the project's lint target. Discover the commands from the project's own docs (CLAUDE.md, README, Makefile, package manifest) — never invent an invocation. A proof artifact with no discoverable way to run it → verdict `unrunnable` (with what you tried).

3. **Execute.** Run each proof. Capture pass/fail and the failure output verbatim on failure.

4. **Judge vacuity** for each passing proof: read the proof source against the artifact's `Proof:` field. It is `vacuous` if it could pass with the value-delivering component stubbed, canned, or absent — tautological assertions, shape-only checks, an enforcing lint rule whose allowlist swallows every violation, an assertion on setup rather than outcome. When genuinely uncertain, verdict `uncertain` with the specific doubt — never silently pass.

5. **Report** in-context, structured, one entry per in-scope artifact:

   ```
   Status: clean | findings

   ## Verdicts

   | artifact | proof file(s) | verdict |
   |---|---|---|
   | story:<slug> | <path> | pass |
   | decision:<slug> | — | missing |

   ## Findings

   (one block per non-pass verdict:)

   ### <story|decision>:<slug> — <missing|failing|vacuous|unrunnable|uncertain>
   Proof field: <quoted>
   <evidence: failure output for failing; the specific vacuity for
   vacuous; what was tried for unrunnable>
   Suggested fix: <restore/repair/strengthen the proof — an agent-doable
   action. If the honest fix is "the artifact's intent has changed",
   say so: that is a corpus mutation only a sprint can make, and the
   caller should leave the proof failing rather than bend it.>
   ```

**Clean means:** every in-scope story and decision has at least one proof artifact that runs, passes, and is non-vacuous. Anything else is findings, and the caller's loop continues.

## What this skill does NOT do

- Does not fix proofs, code, or corpus — it executes and judges only.
- Does not write to the intake queue, the corpus, or any durable file.
- Does not weaken its verdict to help a run complete: a vacuous pass is a finding, full stop. Bending a proof to green is the exact failure this verb exists to catch.
