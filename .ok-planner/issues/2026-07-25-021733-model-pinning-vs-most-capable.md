---
issue: model-pinning-vs-most-capable
kind: discover
category: conflicting
artifacts:
  - concept:skill
  - story:certify-completion
  - story:corpus-audit
status: verified
opened: 2026-07-25T02:17:33Z
---

# Dispatch prompts pin a specific model while the index mandates the most capable

## Problem

Two skills pin a named model for reviewer dispatches while the planner's injected briefing rules 'Always use the most capable model available. Do not downgrade models for simple tasks.' — the pins and the rule pull in opposite directions.

## Candidates

- Amend concept:skill Invariants with one canonical model-selection rule for subagent dispatch
- Record model pinning per dispatch as a decision with its cost/quality tradeoff

## Discussion

**The question.** `ok-planner/SKILL.md`'s "Model Selection" section (injected every session) says "Always use the most capable model available. Do not downgrade models for 'simple' tasks." Several skills pin a specific model on subagent dispatches regardless. Should there be one canonical model-selection rule the pins must honor, or is per-dispatch pinning a legitimate, distinct choice that needs its own recorded rationale?

**Evidence, re-verified — now three pin sites, not two.** `plugins/ok-planner/skills/audit/SKILL.md:22,115` dispatches `Agent (general-purpose, model: sonnet-5)` twice; `plugins/ok-planner/skills/certify/SKILL.md:40` dispatches the design-doc compliance reviewer with `model: sonnet-5`; `plugins/ok-planner/skills/verify-issues/SKILL.md:46` also pins `model: sonnet-5`. The index rule at `ok-planner/SKILL.md`'s "Model Selection" section is unchanged and still unqualified — it makes no exception for subagent dispatch versus the main session. The conflict is live and, if anything, more widespread than filed (three sites, not two).

**What the corpus says.** `concept:skill`'s Boundaries and Invariants describe activation classes (user-facing vs. plumbing) and the negative-behavior list's binding force, but say nothing about model selection for dispatched subagents. `story:certify-completion` and `story:corpus-audit` (both cited as bearing) describe what each verb must accomplish — driving findings to clean, checking compliance/coverage/drift — without naming or constraining which model performs the work; model choice is implementation, not the user-observable outcome either story protects. `decision:single-source-transclusion` establishes the mechanism by which shared rule text is transcluded into dispatch prompts (named tokens resolved at assembly time) but says nothing about *which* rules get transcluded or reconciled — it's the plumbing the fix would ride, not a decision about model policy. `concept:materialized-artifact` and `concept:conduct` are silent on this question too. No artifact currently decides whether "most capable" is meant to bind subagent dispatch at all, or whether it was written with only the main session in mind.

**What the code does today.** The three pinned dispatches are for review/audit-style work (compliance checking, coverage/drift checking, corpus verification) — arguably work with a different cost/quality profile than open-ended authoring, but nothing in the corpus records that as the rationale; the pins simply appear as literal `model: sonnet-5` strings in each skill's dispatch block, with no comment or cross-reference explaining why review dispatches are pinned while other subagent work (e.g. `plan-sprint`'s relevance reviewer, if it dispatches) is not verified to be pinned identically.

**Candidates, and what each means.** Candidate 1 (one canonical rule in `concept:skill` Invariants) would mean deciding a single policy — e.g. "the most-capable rule applies to the main session only; dispatched subagents may pin" or "the most-capable rule binds dispatches too, and existing pins must be removed" — and then either amending the three skills to drop their pins or amending the index text to carve out the exception explicitly. This resolves the *contradiction* but doesn't necessarily explain *why* review dispatches specifically are pinned. Candidate 2 (record pinning as a decision with its cost/quality tradeoff) keeps the pins as-is but adds a `decision:` artifact stating the tradeoff (e.g., review/compliance work is cheaper on a fixed capable-enough model than paying for whatever "most capable" resolves to at dispatch time, and consistency across runs matters more than chasing the frontier) — this doesn't touch the index rule at all, leaving the literal contradiction in the injected text unless the index is also carved out. A shape not filed: do both — record the tradeoff as a decision *and* narrow the index's "most capable" rule to explicitly exempt dispatches the decision covers, so neither piece of text overstates its scope.

**What the ruling must decide.** Whether "always use the most capable model" is meant to bind subagent dispatch (in which case the three `model: sonnet-5` pins are the defect and should be removed or the index amended to state an exception), or whether pinning review-style dispatches is the intended design (in which case it needs to be recorded, with its rationale, somewhere the index rule can be read as compatible with it).

## Ruling

Transcribed from a live session with the owner:

Model follows the job — pinning is intended design, now recorded.
Review, verification, investigation, and relevance dispatches run on
sonnet; coding and fixing dispatches run on opus. The hub's old
"always use the most capable model" text is superseded (rewritten in
this session as "Model Selection and Dispatch", backed by
`skills/_shared/dispatch-discipline.md`). Existing sonnet pins on
review-type dispatches are correct, not defects.
