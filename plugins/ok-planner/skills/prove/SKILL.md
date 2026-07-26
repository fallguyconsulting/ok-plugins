---
name: prove
description: "ONLY activated by explicit /prove slash command or by whoever is executing a sprint's completion contract — an inline session or an orchestrator. Never auto-triggered by conversation content."
---

# Prove the Corpus

Execute every live story's and decision's proof and report which are missing, failing, or vacuous — establishing non-vacuity by *exhibiting* each proof's falsifier (mutating the code so the proof must go red), never by reading it and forming an opinion. A sprint's work is not done until this comes back clean. Exhibiting the falsifier is what makes a corpus claim that outran the code fail mechanically here, regardless of who executed the sprint: a proof whose red cannot be produced — an implementation a decision asserts but the code lacks, an "every" over a population of one — is vacuous, not clean.

`/prove` produces work items for an **agent**, not a human: its findings return in-context as a structured report the executing agent consumes with its own triage. It **never writes to the issue intake (`.ok-planner/issues/`)** — filing for the human belongs to `/audit`. If a prove finding turns out to need owner judgment (an intent question, not a broken proof), the escalation path is the next `/audit` catching the underlying corpus problem.

Read `{{PROOF-PROTECTION-RULE}}` in `skills/_shared/artifact-definitions.md` before starting — it defines what a proof is, the annotation link, and non-vacuity.

## Scope

Default: every live story under `.ok-planner/design/stories/` and every live decision under `.ok-planner/design/decisions/`. The caller may narrow with an argument (a list of slugs, or a sprint path whose deltas name the touched artifacts) — but the completion-contract invocation runs whole-corpus: touched artifacts must pass, and untouched artifacts must not have regressed.

## Process

1. **Collect.** For each in-scope artifact, read its slug and `Proof:` field, then find its proof artifacts: `rg -l '@story:\s*<slug>'` / `rg -l '@decision:\s*<slug>'` across the codebase (excluding `.ok-planner/`, `.git/`, build outputs, vendored deps). Zero matches → verdict `missing`, done with that artifact.

2. **Discover the run harness.** Proofs are project-shaped: tests run by the project's test runner, demos with a documented invocation, lint/dependency gates run by the project's lint target. Discover the commands from the project's own docs (CLAUDE.md, README, Makefile, package manifest) — never invent an invocation. A proof artifact with no discoverable way to run it → verdict `unrunnable` (with what you tried).

3. **Execute.** Run each proof. Capture pass/fail and the failure output verbatim on failure.

4. **Exhibit the falsifier** for each passing proof — do not judge vacuity by reading. A green run proves nothing until you have seen the proof go red. Read the artifact's declared falsifier: a story's `Falsifier` field, or for a decision the "silently violated" mutation its `Proof:` field names (derive it from the Proof intent if the artifact predates an explicit statement). Then:

   - **Apply the falsifying mutation** to the code under proof — stub the value-delivering component, cross the enforced boundary, add the disallowed dependency, introduce a deliberately non-conforming member of the population — **re-run the proof, and confirm it goes red.** Then restore the code and confirm the proof greens again.
   - Verdicts: reddens under its falsifier and greens on restore → **non-vacuous, `pass`**. Stays green under its falsifier → **`vacuous`** (it does not discriminate the property it claims to protect). The falsifier **cannot be produced at all** — there is no code whose mutation would redden it (a universal claim over a population of one, an implementation the corpus asserts but the code lacks, an enforced boundary with nothing on the far side) → **`vacuous`**, and name the missing population member or absent component as the specific gap. This is the case that catches a corpus claim that outran the code.
   - **Quantified proofs** ("every implementation / handler / route …") are exhibited by introducing a non-conforming member and confirming the proof rejects it; if the population the artifact names has members absent from the code, that absence *is* the finding — the proof passes only because the missing members can't be tested.
   - Only when a falsifier genuinely cannot be applied without a destructive side effect you cannot safely stage and undo → verdict `uncertain`, naming the exact mutation you could not run. Never fall back to a read-only opinion reported as `pass`.

   **Restoration is fix-forward.** Record the exact original text before mutating, and restore by editing it back — never with `git checkout`/`restore`/`stash`/`reset`, which would also discard any other uncommitted work in the tree. After restoring, confirm the working tree matches its pre-mutation state and the proof is green again before moving on. Run on a tree clean enough that you can verify the restore, staging pre-existing changes first if needed.

5. **Report** in-context, structured, one entry per in-scope artifact:

   ```
   Status: clean | findings

   ## Verdicts

   | artifact | proof file(s) | verdict |
   |---|---|---|
   | story:<slug> | <path> | pass |
   | decision:<slug> | — | missing |

   ## Findings

   (one block per non-pass verdict:)

   ### <story|decision>:<slug> — <missing|failing|vacuous|unrunnable|uncertain>
   Proof field: <quoted>
   <evidence: failure output for failing; the specific vacuity for
   vacuous; what was tried for unrunnable>
   Suggested fix: <restore/repair/strengthen the proof — an agent-doable
   action. If the honest fix is "the artifact's intent has changed",
   say so: that is an intent-level corpus mutation only a sprint can make, and the
   caller should leave the proof failing rather than bend it.>
   ```

**Clean means:** every in-scope story and decision has at least one proof artifact that runs, passes, and was **shown non-vacuous by exhibiting its falsifier** — the proof went red under the mutation and green on restore. A proof that merely passed but whose falsifier could not be produced is not clean; it is a `vacuous` finding. Anything else is findings, and the caller's loop continues.

## What this skill does NOT do

- Does not fix proofs, code, or corpus — it executes and exhibits only. The falsifier mutations it applies are transient probes, restored fix-forward the moment the red is confirmed; it leaves no durable change to code, the corpus, the issue intake, or any file.
- Does not weaken its verdict to help a run complete: a vacuous pass is a finding, full stop, and a falsifier that cannot be produced is a vacuous pass. Bending a proof to green — or accepting a green it never watched go red — is the exact failure this verb exists to catch.
