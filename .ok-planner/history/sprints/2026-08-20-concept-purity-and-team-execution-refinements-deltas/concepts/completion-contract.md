---
concept: completion-contract
---

# Completion contract

## What it is

The completion contract is the fixed, verbatim stop condition
carried in every sprint, every term verifiable from the repository
as it stands.

## Purpose

Because the planner deliberately ships no execution engine, the
contract is the entire interface between planning and execution: it
tells whoever executes a sprint when the work is done, identically
for every executor. It is what does not scale away when execution
fans out.

## Boundaries

The contract owns the definition of "done" for a sprint, and its
scope is the change: the stories and decisions the work touched.
Whether the corpus's claims are still supported by the codebase is no
term of it — that is the periodic audit's question, asked over the
whole corpus on the owner's cadence rather than at a close (see also:
adversarial-implementation-audits under decisions). It does
NOT own how work is staged or performed — that is execution-time
planning (see also: sprint) — and it does not derive the record it
requires: the completion report is execution's artifact, finished by
certification (see also: completion-report). The certification gate
is the contract's realization plus review and presentation. Which
callers may invoke the checking verbs belongs to the skill (see also:
skill).
