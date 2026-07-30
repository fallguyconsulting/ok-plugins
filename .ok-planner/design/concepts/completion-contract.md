---
concept: completion-contract
---

# Completion contract

## What it is

The completion contract is the fixed, verbatim stop condition
carried in every sprint, every term verifiable from the repository
as it stands: the corpus matches every delta applied verbatim; the
project's own test suites pass, with every story the change touched
that is implemented in code exercised end-to-end by a test; and the
sprint's completion report is finished — the work and divergences recorded,
certification's presentation written in, the review-fix loop run
last and come back clean with every finding fixed or
promoted-and-verified.

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
whole corpus on the owner's cadence and never at a close (see also:
adversarial-implementation-audits under decisions). It does
NOT own how work is staged or performed — that is execution-time
planning (see also: sprint) — and it does not derive the record it
requires: the completion report is execution's artifact, finished by
certification (see also: completion-report). The certification gate
is the contract's realization plus review and presentation. The
contract also legitimizes non-slash invocation of the checking verbs
by whoever is executing it (see also: skill).

## Invariants

- The ordering is load-bearing: the corpus checks run last because
  their judgment findings seed the next sprint's intake.
- The contract text is included verbatim in every sprint; executors
  owe the contract and nothing else.
- Every term is verifiable from the repository as it stands: no term
  is a claim about session history, and a checker needs nothing but
  the tree to discharge the contract.
- The goal rule: the contract is met in exactly two ways — the
  sprint file has moved to the archive bearing its close stamp
  (terminal, whatever else seems unfinished), or it is still in
  flight and every term verifies against the repository; a missing
  completion report means not done, however green the rest looks. A
  run parked at the review-fix loop's cycle cap awaiting the owner's
  direction is a legal in-flight state — not done, not failed, and
  never grounds for the run to take either cap step itself.
- Tests establish that code-implemented behavior works. Whether the
  codebase supports a claim at all is established by the periodic
  implementation audit, never by the implementer's own read and never
  as a term of this contract.
