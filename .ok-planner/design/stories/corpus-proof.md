---
story: corpus-proof
---

# Prove the corpus's story claims deterministically

## Story

As an executing agent closing work against a sprint, I want every live story's registered proofs executed deterministically, so that a story's promised functionality is demonstrated by a run a third party can repeat rather than by a read-through opinion.

## Acceptance

The proof run executes over the in-scope stories → each receives a verdict (pass, missing, failing, or unrunnable) in a structured in-context report, with failure output carried verbatim, and each executed proof also receives the time it took; the run leaves those timings as a durable artifact a later session reads without re-running anything. The run invokes only harnesses the project itself documents; the intake queue is never written; and whether a green proof spans its story's claim is left to the implementation audit, never asserted by the run. The proof-running skill and the proofs it executes are real.

## Falsifier

A verdict is issued for a proof never executed; a failing run reports pass; the run bends a proof to green or weakens a verdict; an invented invocation stands in for the project's own harness; findings leak into the owner's queue; or a completed run leaves no readable record of what each proof cost, so the next cost question requires another full run.

## Proof

Demo — a run over stories containing one honest passing proof, one deliberately failing proof, and one story with no annotated proof, reporting pass, failing, and missing respectively, leaving per-proof timings a second session reads without re-running, with the working tree otherwise unchanged afterward.
