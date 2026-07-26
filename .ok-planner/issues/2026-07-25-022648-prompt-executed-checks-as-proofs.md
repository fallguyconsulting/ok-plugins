---
issue: prompt-executed-checks-as-proofs
kind: discover
category: proof
artifacts:
  - decision:falsifier-exhibition
  - decision:append-only-issue-queue
  - decision:code-cites-design
status: verified
opened: 2026-07-25T02:26:48Z
---

# Decide whether prompt-executed checks count as enforcing checks in decision Proofs

## Problem

The extractor's real-check/no-check split (11 with, 9 without) counts agent-performed, skill-prompt-directed checks as enforcing — the lifecycle verb's queue-integrity walk, the audit's annotation-integrity sweep, and, weakest, the proof run itself for falsifier-exhibition — while classifying comparable prompt-text disciplines (prove-audit-audience-split, relevance-scoped-queue-gate) as having no check. Nothing mechanical fails if those skills stop performing the named checks; where the line sits is the extractor's judgment.

## Candidates

- Amend the affected decision Proofs to label prompt-executed checks explicitly as such
- Reclassify the weakest cases into the no-check set, each with a proof issue row
- Record a corpus-wide rule on whether prompt-directed checks satisfy decision Proof fields

## Discussion

**The question.** Some decision Proof fields credit a check performed by an agent *following skill-prompt instructions* (no independent tooling, nothing that runs unless the agent does it) as an enforcing mechanical check, while other, comparably prompt-driven disciplines are marked as having no check at all and are filed to the intake for owner calibration. Where should that line sit, and should the credited ones be relabeled, reclassified, or left as-is with a corpus-wide rule stated?

**Re-verified: the two groups as they exist today.**
Credited as enforcing (Proof field states a check exists and describes it as failing):
- `decision:append-only-issue-queue`'s Proof: "The lifecycle verb's queue-integrity check fails on rows that do not parse, unknown events, missing required fields, or promote rows naming a nonexistent sprint file." Note this decision's Choice also describes the now-superseded JSONL mechanism (see the sibling issue `intake-queue-concept-unpromoted`, which found the intake moved to file-per-issue) — so this particular Proof's credited check may not even describe a check the current code runs at all, which sharpens rather than resolves this issue's question.
- `decision:code-cites-design`'s Proof: "The corpus audit's annotation-integrity sweep fails on any annotation whose slug resolves to no live artifact or to the wrong kind... Projects declaring the citation-tag bridge get the same integrity enforced mechanically by the lint on every edit." This one is split: the lint-enforced half (for citation-tag-bridge projects) is a real, tool-run check; the audit sweep half is `rg -n '@(concept|story|decision):\s*\S+'` run by an agent under `/audit`'s prompt instructions, per `{{ANNOTATION-INTEGRITY-RULE}}` — no independent process fails if the agent skips it.
- `decision:falsifier-exhibition`'s Proof: "The proof run itself is the enforcing check: it reports vacuous for any proof that stays green under its falsifier or whose falsifier cannot be produced, and never issues a pass without an exhibited red-green cycle." This is the weakest of the three by the issue's own framing — the "check" is `/prove` itself, an agent-run skill, self-certifying that it performed its own discipline correctly; nothing external verifies the agent actually applied and reverted the falsifier rather than asserting it did.

Credited as having no check (Proof field states none exists, filed to intake):
- `decision:prove-audit-audience-split`'s Proof: "No enforcing check exists today: nothing fails if the proof run writes the queue or the audit reports judgment findings only in-context; the channel discipline lives in prompt text. Filed to the intake queue for owner calibration."
- `decision:single-source-transclusion`'s Proof (read while verifying issue `root-resolution-copy-family`): "No enforcing check exists today: substitution is performed by the model with no tooling verifying a token resolves to a real block... Filed to the intake queue for owner calibration."
- `decision:filesystem-discovery-markers`'s Proof (same): "No enforcing check exists today: nothing fails if a plugin's discovery depends on an undocumented marker... Filed to the intake queue for owner calibration."

All six are, mechanically, the same shape: an agent, dispatched by a skill prompt, is supposed to perform some check and report red on violation. None has independent tooling that runs without the agent choosing to run it. Yet three are written as "the check X does Y" (credited) and three as "no enforcing check exists" (not credited) for the same underlying kind of mechanism.

**What the corpus says about the standard.** The `{{DECISION-DEFINITION}}` (shared, not a corpus artifact itself but the rule the extractor works from) says a decision's Proof is "the mechanical check that fails if the choice is silently violated," and that "a 'decision' for which no violation-detecting check can be named is either really a default (delete it) or an unenforced intention (file an issue)." It does not define "mechanical" precisely enough to say whether an agent executing a skill's prompt-directed steps counts as a "mechanical check" or as the same "prompt text" the three uncredited decisions explicitly disclaim. `concept:proof`'s Invariants state "every live story and decision has at least one annotated proof" and describe non-vacuity via the falsifier, but is written from the proof-artifact side (demos, executable checks) and doesn't address whether a *skill's own prompt-directed self-check* qualifies as a proof artifact in the first place, or whether it's better understood as the discipline described by the neighboring `decision:falsifier-exhibition` and `story:corpus-audit` rather than as its own separate proof.

**Candidates and their tradeoffs, undecided:**
- *Amend the affected decision Proofs to label prompt-executed checks explicitly as such.* Keeps all six honest about what actually enforces them (agent discipline, not independent tooling) without changing anything's classification — but doesn't resolve whether an explicitly-labeled prompt-executed check still counts as satisfying "the mechanical check that fails if silently violated," so a reader could still ask the same question about the newly-labeled ones.
- *Reclassify the weakest cases (starting with `falsifier-exhibition`, by the issue's own ordering) into the no-check set*, each spawning its own proof-category issue. Makes the corpus's credited/uncredited split internally consistent by the strictest reading, but is a real workload multiplier — every reclassified decision needs its own issue, and `falsifier-exhibition` is the decision that *governs proof non-vacuity itself*, so declaring it unenforced has outsized weight relative to the other five.
- *Record a corpus-wide rule on whether prompt-directed checks satisfy decision Proof fields*, applied once to settle all six (and future) cases in one place rather than issue-by-issue. Most economical if the owner has a clean answer either way; least useful if the real answer is "it depends on how independently the check can be verified to have run," which would need per-case judgment anyway.

**What the ruling must decide.** Whether an agent following a skill's prompt-directed steps ever counts as "the mechanical check" a decision's Proof field requires — and if the answer is conditional, what distinguishes a credited case (`append-only-issue-queue`, `code-cites-design`, `falsifier-exhibition`) from an uncredited one (`prove-audit-audience-split`, `single-source-transclusion`, `filesystem-discovery-markers`) closely enough that the corpus can state the line once.

## Ruling

Transcribed from a live session with the owner:

Skills do not get a separate development regime — the split is by what
kind of check a proof can honestly be, not skills-vs-code. The
correctness of a skill or prompt cannot be proven mechanically.
Therefore:

- Prompt-realized expectations are captured as **stories**, with
  observational acceptance: the falsifier is the user-observable
  absence of the outcome, policed by audit and actual use, not by an
  executable proof.
- A **decision** about prompt-directed behavior may carry a
  **text-presence proof**: the mechanical check is that the rule still
  stands in the governing prompt text (grep-able; falsifier: the line
  deleted or reworded away). Such a proof must state that it checks
  presence, not behavior.
- The credited/uncredited inconsistency resolves accordingly: a
  prompt-directed discipline counts as having an enforcing check only
  as a declared text-presence check; behavior-level proof claims for
  prompts are vacuous and must not be written.
