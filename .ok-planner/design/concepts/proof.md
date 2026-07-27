---
concept: proof
---

# Proof

## What it is

A proof is a codebase artifact — an integration test, demo, or example — that exercises a story's functionality deterministically against the assembled product, linked to its story by an annotation. The story's proof field is the canonical statement of intent; proof files are working examples of that intent. Proofs are not regression tests: they are exhibitions of intent that happen to live as runnable code. Proofs belong to stories only; a decision's verification is its implementation audit.

## Purpose

Proofs make a story's delivery executable: a third party can run them and watch the promised outcome happen. They are the deterministic half of verification — cheap to run, honest about pass/fail, blind to adequacy. Whether a green proof actually spans the story's claim is the implementation audit's adversarial question, answered with citations rather than assumed from the green.

## Boundaries

The protected thing is the intent, not the byte shape: updates that keep a proof satisfying its story's proof field are ambient code change; a change that makes it exhibit something different, less, or nothing is a story mutation and must ride a sprint's deltas. Removal requires explicit user direction — the agent never proposes it. Linkage belongs to the annotation (see also: annotation); execution belongs to the proof run; adequacy and implementation truth belong to the implementation audit; coverage of the audit corpus itself belongs to the corpus-audit (see also: corpus-proof, corpus-audit under stories). The intake's proof category names questions *about* proofs awaiting the owner's ruling — a classification label, not a third proof sense (see also: issue).

## Invariants

- Every live story has at least one annotated proof; an unannotated proof file proves nothing.
- Multiple proofs per story are welcome and adding one is unrestricted.
- When intent shifts, the proof-field rewrite comes first and the proof modification follows — never the reverse.
- Decisions carry no proofs; nothing in the corpus obligates a test per decision.
