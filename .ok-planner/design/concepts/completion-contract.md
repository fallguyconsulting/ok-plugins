---
concept: completion-contract
---

# Completion contract

## What it is

The completion contract is the fixed, verbatim stop condition
carried in every sprint, every term verifiable from the repository
as it stands: the corpus matches every delta applied verbatim; the
proof run returns clean over the new and touched stories — every
registered proof present, passing, and runnable; the
implementation-audit corpus is current for everything the change
touched or made stale, with any standing violation linked to an
intake issue and the currency mechanically checkable — the vendored
checker confirms citations current and every changed source node
dispositioned by the change inspection; and the sprint's completion
report is finished — the work and divergences recorded,
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
scope is the change: the stories, decisions, and audits the work
touched. Whole-corpus proof and audit are the whole-corpus
certification gate's business, run on the owner's cadence rather
than per close (see also: certify-completion under stories). It does
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
- Story proofs are established by deterministic execution; whether
  an implementation genuinely satisfies a claim is established by
  the implementation audit, never by the implementer's own read (see
  also: proof, falsifier).
