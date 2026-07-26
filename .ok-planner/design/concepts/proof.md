---
concept: proof
---

# Proof

## What it is

A proof is a codebase artifact — a demo, example, executable exhibition, or enforcing check — that shows a story or decision holding, linked to its artifact by an annotation. The artifact's proof field is the canonical statement of intent; proof files are working examples of that intent. Proofs are not regression tests: they are exhibitions of intent that happen to live as runnable code.

## Purpose

Proofs make the corpus's claims falsifiable. A story or decision without an annotated proof is, for coverage purposes, an unverified claim; with one, drift between what the corpus asserts and what the code does becomes mechanically detectable.

## Boundaries

The protected thing is the intent, not the byte shape: updates that keep a proof satisfying its artifact's proof field are ambient code change; a change that makes it exhibit something different, less, or nothing is an artifact mutation and must ride a sprint's deltas. Removal requires explicit user direction — the agent never proposes it. Non-vacuity belongs to the falsifier (see also: falsifier); linkage belongs to the annotation (see also: annotation); execution belongs to the proof run and coverage to the audit (see also: corpus-proof, corpus-audit under stories). The intake's proof category names questions *about* proofs awaiting the owner's ruling — a classification label, not a third proof sense (see also: issue).

## Invariants

- Every live story and decision has at least one annotated proof; an unannotated proof file proves nothing.
- Multiple proofs per artifact are welcome and adding one is unrestricted.
- Quantified proofs enumerate their population: "every" over a singleton is vacuously true, and coverage checks presence and cardinality.
- When intent shifts, the proof-field rewrite comes first and the proof modification follows — never the reverse.
