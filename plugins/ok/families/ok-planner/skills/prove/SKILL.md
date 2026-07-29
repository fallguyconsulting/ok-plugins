---
name: prove
description: "ONLY activated by explicit /prove slash command or by whoever is executing a sprint's completion contract — an inline session or an orchestrator. Never auto-triggered by conversation content. Executes every in-scope story proof deterministically; findings return in-context to the caller and never write the issue intake."
---

# Prove the Corpus

Execute every live story's proof — the integration tests, demos, and examples that exercise the story's functionality against the assembled product — and report which are missing, failing, or unrunnable. A sprint's work is not done until this comes back clean. Whether a green proof genuinely spans its story's claim is not this verb's question: that judgment belongs to the implementation audit (`{{AUDIT-DEFINITION}}` in `skills/_shared/artifact-definitions.md`), which certification runs as its own producer. `/prove` answers exactly one thing, deterministically: the registered proofs run, and they pass — and it answers it at a stated cost, leaving what each proof took as a durable record rather than a number that scrolls past.

`/prove` produces work items for an **agent**, not a human: its findings return in-context as a structured report the executing agent consumes with its own triage. It **never writes to the issue intake (`.ok-planner/issues/`)** — filing for the human belongs to certification's architect. Decisions carry no proofs; their verification is the implementation audit.

Read `{{PROOF-PROTECTION-RULE}}` in `skills/_shared/artifact-definitions.md` before starting — it defines what a proof is and the annotation link.

## Scope

Default: every live story under `.ok-planner/design/stories/`. The caller may narrow with an argument (a list of slugs, or a sprint path whose deltas name the touched stories) — the completion contract's invocation is exactly such a narrowing, scoped to the sprint's new and touched stories. Whole-corpus runs happen only when the caller explicitly asks for them — `/certify-all`'s invocation, on the owner's cadence — never as a contract-time override.

## Process

1. **Collect.** For each in-scope story, read its slug and `Proof:` field, then find its proof artifacts: `rg -l '@story:\s*<slug>'` across the codebase (excluding `.ok-planner/`, `.git/`, build outputs, vendored deps). Zero matches → verdict `missing`, done with that story.

2. **Discover the run harness.** Proofs are project-shaped: tests run by the project's test runner, demos with a documented invocation. Discover the commands from the project's own docs (CLAUDE.md, README, Makefile, package manifest) — never invent an invocation. A proof artifact with no discoverable way to run it → verdict `unrunnable` (with what you tried).

3. **Execute, timed.** Run every proof through the project's own recorder — `.ok-planner/bin/proof-timings run <story>[,<story>...] <proof-path> -- <the discovered invocation>` — never bare. The recorder times the invocation, folds in whatever per-story and per-case timings the harness itself emitted, passes the invocation's exit status straight back, and merges the result into `.ok-planner/proof-timings.json`. Name **every** story a harness proves in the story list, so one harness covering several stories is recorded against each of them rather than charged entirely to whichever one you ran it under. Capture pass/fail and the failure output verbatim on failure.

   A verdict reached without running anything — `missing`, or `unrunnable` — is recorded too: `.ok-planner/bin/proof-timings record <story> <proof-path> <verdict> 0`. Every in-scope story leaves a row, so the record never reads as coverage it does not have.

   The record is the durable half of this verb's output: it is what lets a later session answer "what does this suite cost, and where" by reading (`.ok-planner/bin/proof-timings show`) instead of paying for another full run. That is the profile `decision:measure-first-verification-cost` requires before anyone changes what verification costs. It is generated, machine-local, and git-ignored by the estate's own `.gitignore`, so leaving it behind is not a working-tree mutation.

4. **Report** in-context, structured, one entry per in-scope story. Every executed proof carries its time, and the report names where the durable record was left:

   ```
   Status: clean | findings
   Timings recorded in .ok-planner/proof-timings.json
   (read later with `.ok-planner/bin/proof-timings show`)

   ## Verdicts

   | story | proof file(s) | verdict | seconds |
   |---|---|---|---|
   | story:<slug> | <path> | pass | 12.345 |
   | story:<slug> | — | missing | — |

   ## Findings

   (one block per non-pass verdict:)

   ### story:<slug> — <missing|failing|unrunnable>
   Proof field: <quoted>
   <evidence: failure output for failing; what was tried for
   unrunnable>
   Suggested fix: <restore/repair the proof — an agent-doable action.
   If the honest fix is "the story's intent has changed", say so:
   that is an intent-level corpus mutation only a sprint can make,
   and the caller should leave the proof failing rather than bend it.>
   ```

**Clean means:** every in-scope story has at least one annotated proof artifact that runs and passes. Anything else is findings, and the caller's loop continues.

## What this skill does NOT do

- Does not fix proofs, code, or corpus — it executes and reports only.
- Does not judge whether a passing proof covers its story — adequacy is the implementation audit's determination, made adversarially and recorded under `.ok-planner/audits/`.
- Does not mutate code to test the proofs' sensitivity. Nothing in this verb edits the working tree: the only thing a run leaves behind is `.ok-planner/proof-timings.json`, generated machine-local estate content the estate's own `.gitignore` keeps out of the repository.
- Does not audit decisions — they have no proofs to run.
