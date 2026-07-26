---
concept: falsifier
---

# Falsifier

## What it is

A falsifier is the declared, concretely producible mutation that must turn a proof red: the value-delivering component stubbed, the enforced boundary crossed, the choice silently violated. For stories it is stated as the user-observable absence proving the story undelivered; for decisions it is the silent-violation clause of the proof field.

## Purpose

The falsifier is how non-vacuity is demonstrated rather than judged: a proof earns its name only if it can fail, and "can fail" is established by exhibiting the failure — applying the falsifier, watching red, reverting, watching green. Reading a proof and forming an opinion is the foolable step the falsifier exists to eliminate.

## Boundaries

The falsifier belongs to a proof's intent, declared in the owning story or decision (see also: proof, story-artifact, decision-artifact). The two artifact kinds state it differently by design: a story's falsifier is a first-class user-visible failure with its own section, while a decision's is inseparable from its proof — the silent-violation clause itself — so decisions carry no separate falsifier field. Exhibition — actually applying the mutation transiently — belongs to the proof run; a falsifier that cannot be produced at all marks the proof vacuous, which is the seam where a corpus claim has outrun the code (see also: corpus-proof under stories). Restoration after exhibition is fix-forward and never destroys other uncommitted work.

## Invariants

- A proof is non-vacuous only when applying its falsifier actually reddens it and reverting restores green.
- Every live decision's proof field states its silent-violation clause explicitly; nothing derives a decision's falsifier by inference.
- Quantified claims are falsified by introducing a non-conforming population member and confirming rejection.
- Only a mutation that cannot be safely staged and undone excuses exhibition, and then the exact unrunnable mutation is named — never a read-only opinion reported as passing.
