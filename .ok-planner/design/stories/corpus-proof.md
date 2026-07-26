---
story: corpus-proof
---

# Prove the corpus's claims by exhibition

## Story

As an executing agent closing work against a sprint, I want every live story's and decision's proof executed with its falsifier exhibited, so that a green corpus claim can be trusted to be non-vacuous rather than taken on a read-through opinion.

## Acceptance

The proof run executes over the corpus → each artifact receives a verdict (pass, missing, failing, vacuous, unrunnable, or uncertain) in a structured in-context report; a pass means the proof went red under its declared falsifying mutation and returned green on restoration; restoration is fix-forward and the tree is left as found; the intake queue is never written. The proof-running skill and the proofs it executes are real.

## Falsifier

A pass verdict is issued for a proof never watched going red; a vacuous or population-outrun claim reports green; the run bends a proof to green or weakens a verdict; restoration destroys other uncommitted work; or findings leak into the owner's queue.

## Proof

Demo — a run over a corpus containing one honest proof, one stubbed value-delivering component, and one universal claim with a single-member population, reporting pass, failing, and vacuous respectively, with the working tree byte-identical afterward.
