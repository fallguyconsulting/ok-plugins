---
topic: audit-verb
kind: concept
---

# /audit (ok-planner) — whole-corpus audit and the mechanical/judgment split

## Description

ok-planner's `/audit` is a "whole-corpus audit of the project's durable design docs ... producing work items for a **human**: its judgment findings are appended to `.ok-planner/issues.jsonl` ... Mechanical findings are reported to the caller for in-cycle fixing." It is "read-only against the corpus and the code — its only write is appending `open` rows to the intake queue, which is its output channel." Precondition: `design/concepts/` must exist, else "tell the caller to run `/discover-design` first and stop."

Three dispatched passes: **Pass 1 — compliance**: the shared design-doc compliance reviewer in whole-corpus mode (self-containment, current-state-only, story form, decision form, TOC consistency, cross-reference integrity). **Pass 2 — coverage + intent-drift + annotation integrity**: coverage is "presence *and cardinality* — one annotation is not proof the whole claim is realized"; every population member a Proof/Falsifier names must itself resolve to an annotated artifact ("`/prove` passes vacuously over only the members that exist, so a decision asserting two implementations goes green against one. ... This is the check that catches a corpus claim that outran the code"); intent-drift reads each annotated proof against its artifact's Proof field (satisfies / does-not-satisfy / uncertain — all judgment); plus the structural vacuity catch ("because `/audit` reads and cannot exhibit, this is where a foolable `Proof:` field is caught structurally rather than by opinion": population quantifiers with no enumeration, proofs with no nameable falsifying mutation); annotation integrity is the mechanical `rg` sweep. **Pass 3 — cross-artifact consistency**: "the pass no per-artifact check can perform: a contradiction between two artifacts is invisible to a check that reads each one alone." Conflict kinds are enumerated (incompatible mandated mechanisms, Choice negating Choice, invariant contradicted, decision foreclosing a story's promised outcome, Proof failing against another artifact's mandated state); all findings judgment, category `conflicting`; the anti-padding line distinguishes conflict from tension ("Two artifacts on the same topic conflict only if both cannot hold").

**The mechanical/judgment split** is the suite's finding taxonomy: mechanical = "fixable without owner judgment — a forbidden section to strip, a stale TOC line, a dangling cross-reference with an obvious live successor"; judgment = "requires owner calibration — a boundary that can't be stated without naming a file, a story with no honest benefit clause, a decision with no expressible proof" (compliance reviewer). Audit files judgment findings itself (step 6: fold the queue, dedup against open ids, append per format, `kind: "audit"`) and hands mechanical ones back: "The caller (worker or human) fixes the mechanical findings and re-runs `/audit` until the mechanical section is empty. Filed issues are not the caller's to fix — they wait for `/plan-sprint`."

NOT-do list: does not audit code quality; "Does not read `.ok-planner/sprints/` or `.ok-planner/history/` — project records are out of context"; does not fix anything ("The caller fixes; the audit re-verifies"); does not execute proofs ("that's `/prove`. The intent-drift check reads; it never runs"); append-only, open events only.

## Code surface

- `plugins/ok-planner/skills/audit/SKILL.md` (188 lines; two embedded subagent prompts, both `model: sonnet-5`).
- `skills/_shared/design-doc-compliance-reviewer.md` (pass 1 prompt, shared with plan-sprint).
- Queue append mechanics: step 6.

## Prose surface

- Index skill audit row (three-pass summary); contract verb-set ("audit — read-only project-compliance report ... where the plugin has rules to check").

## Adjacent topics

- `prove-verb` (the agent-channel twin; reads-vs-exhibits division), `issue-queue`, `proof-and-falsifier`, `annotation-convention`, `design-corpus`, `certify-gate` (drives audit's loop), `transclusion-tokens`.

## Observations

- The suite has three unrelated verbs named `audit` (ok-planner's corpus audit, ok-plumbline's lint audit, ok-workspaces' discipline audit) — uniform per the contract's verb set, but "run /audit" is ambiguous in a project integrating more than one plugin; nothing in prose addresses the collision.
- Audit is titled read-only yet appends to the queue; the text pre-empts the objection ("Its issue-queue append is reporting, not fixing") — a definitional carve-out phase 2 may want stated once, canonically.
- Pass 2's population-cardinality check and prove's falsifier-unproducible verdict are the same drift caught by two independent mechanisms (read-side and run-side) — explicitly designed redundancy ("all three must agree before certification", certify step 3).
