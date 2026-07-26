---
topic: prove-verb
kind: concept
---

# /prove — execute proofs and exhibit falsifiers

## Description

`/prove` executes "every live story's and decision's proof and report[s] which are missing, failing, or vacuous — establishing non-vacuity by *exhibiting* each proof's falsifier (mutating the code so the proof must go red), never by reading it and forming an opinion." Its audience is explicit: "produces work items for an **agent**, not a human: its findings return in-context as a structured report the executing agent consumes with its own triage. It **never writes to `.ok-planner/issues.jsonl`**" — the human channel belongs to `/audit`, and "if a prove finding turns out to need owner judgment ... the escalation path is the next `/audit` catching the underlying corpus problem."

Process: **collect** (read each in-scope artifact's slug and `Proof:` field; find proof files by annotation grep; zero matches → `missing`); **discover the run harness** ("Proofs are project-shaped ... Discover the commands from the project's own docs ... — never invent an invocation"; undiscoverable → `unrunnable` with what was tried); **execute**; **exhibit the falsifier** for each passing proof — apply the declared falsifying mutation, re-run, confirm red, restore, confirm green. Verdicts: reddens-and-restores → `pass`; stays green → `vacuous`; falsifier cannot be produced at all ("a universal claim over a population of one, an implementation the corpus asserts but the code lacks, an enforced boundary with nothing on the far side") → `vacuous` naming the specific gap — "This is the case that catches a corpus claim that outran the code." Quantified proofs are exhibited "by introducing a non-conforming member and confirming the proof rejects it." Only a falsifier unapplicable "without a destructive side effect you cannot safely stage and undo" yields `uncertain`, "naming the exact mutation you could not run. Never fall back to a read-only opinion reported as `pass`."

**Restoration is fix-forward**: "Record the exact original text before mutating, and restore by editing it back — never with `git checkout`/`restore`/`stash`/`reset`, which would also discard any other uncommitted work in the tree. ... Run on a tree clean enough that you can verify the restore, staging pre-existing changes first if needed." Scope: whole-corpus by default; caller may narrow by slugs or a sprint path, "but the completion-contract invocation runs whole-corpus: touched artifacts must pass, and untouched artifacts must not have regressed." Report format: status line, verdict table per artifact, one finding block per non-pass with quoted Proof field, evidence, and a suggested fix — with the honesty rule that if "the artifact's intent has changed ... that is a corpus mutation only a sprint can make, and the caller should leave the proof failing rather than bend it."

The NOT-do list is a two-item creed: it fixes nothing ("The falsifier mutations it applies are transient probes"), and it never weakens a verdict — "Bending a proof to green — or accepting a green it never watched go red — is the exact failure this verb exists to catch."

## Code surface

- `plugins/ok-planner/skills/prove/SKILL.md` (66 lines).
- Callers: sprint completion contract clause 2; certify step 4; humans ad hoc.
- Depends on: `{{PROOF-PROTECTION-RULE}}` in artifact-definitions ("Read ... before starting").

## Prose surface

- Index skill prove row; `docs/integration-contract.md` conformance line lists prove among ok-planner's lifecycle verbs.

## Adjacent topics

- `proof-and-falsifier`, `completion-contract`, `audit-verb` (the human-channel twin), `certify-gate`, `ok-conduct` (never-destroy-work is the same rule prove restates for mutation probes).

## Observations

- prove is the one suite verb that deliberately mutates consumer code (transiently); its safety story is entirely prose discipline (record text, edit back, verify) with no mechanical safeguard.
- The verb pair's division of audiences is stated crisply and twice: prove → agent, in-context, no queue writes; audit → human, queue appends. Phase 2 likely wants this as a decision.
