---
concept: completion-contract
status: as-is
---

# Completion contract

## What it is

The completion contract is the fixed, verbatim stop condition carried in every sprint: the corpus matches every delta applied verbatim; the proof run returns clean over the affected stories and decisions — every proof present, passing, and non-vacuous; and the corpus audit has been run last, with mechanical findings fixed in-cycle and judgment findings filed to the intake queue for the next sprint.

## Purpose

Because the planner deliberately ships no execution engine, the contract is the entire interface between planning and execution: it tells whoever executes a sprint when the work is done, identically for every executor. It is what does not scale away when execution fans out.

## Boundaries

The contract owns the definition of "done" for a sprint. It does NOT own how work is staged or performed — that is execution-time planning (see also: sprint). The certification gate is the contract's realization plus review and presentation (see also: certify-completion under stories). The contract also legitimizes non-slash invocation of the checking verbs by whoever is executing it (see also: skill).

## Invariants

- The ordering is load-bearing: the audit runs last because its judgment findings seed the next sprint's intake.
- The contract text is included verbatim in every sprint; executors owe the contract and nothing else.
- Proof cleanliness is established by execution and falsifier exhibition, never by reading (see also: falsifier).
