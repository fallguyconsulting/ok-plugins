---
concept: completion-contract
---

# Completion contract

## What it is

The completion contract is the fixed, verbatim stop condition carried in every sprint: the corpus matches every delta applied verbatim; the proof run returns clean over the new and touched stories — every registered proof present, passing, and runnable; the implementation-audit corpus is current for everything the change touched or made stale, with any standing violation linked to an intake issue; and the change-scoped corpus checks and review-fix loop have run last, with mechanical findings fixed in-cycle and judgment findings filed to the intake for the next sprint.

## Purpose

Because the planner deliberately ships no execution engine, the contract is the entire interface between planning and execution: it tells whoever executes a sprint when the work is done, identically for every executor. It is what does not scale away when execution fans out.

## Boundaries

The contract owns the definition of "done" for a sprint, and its scope is the change: the stories, decisions, and audits the work touched. Whole-corpus proof and audit are the whole-corpus certification gate's business, run on the owner's cadence rather than per close (see also: certify-completion under stories). It does NOT own how work is staged or performed — that is execution-time planning (see also: sprint). The certification gate is the contract's realization plus review and presentation. The contract also legitimizes non-slash invocation of the checking verbs by whoever is executing it (see also: skill).

## Invariants

- The ordering is load-bearing: the corpus checks run last because their judgment findings seed the next sprint's intake.
- The contract text is included verbatim in every sprint; executors owe the contract and nothing else.
- Story proofs are established by deterministic execution; whether an implementation genuinely satisfies a claim is established by the implementation audit, never by the implementer's own read (see also: proof, falsifier).
