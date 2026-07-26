---
issue: proof-relevance-scoped-queue-gate
kind: discover
category: proof
artifacts:
  - decision:relevance-scoped-queue-gate
status: verified
opened: 2026-07-25T02:16:01Z
---

# Relevance gate has no enforcing check

## Problem

Nothing fails if a planning session skips the bearing/independent split or builds over a bearing open issue; the gate is ceremony prompt text.

## Candidates

- Amend decision:relevance-scoped-queue-gate Proof to name an enforcing check once one exists
- Accept ceremony-prompt enforcement and record that in the decision

## Discussion

**The question.** `decision:relevance-scoped-queue-gate` carries a mandatory `Proof:` field describing a mechanical check, but its own current text admits none exists. Does this decision resolve by committing to build a mechanical enforcing check, by formally accepting ceremony/prompt-text as the enforcement mechanism, or by some other durable disposition — and does whichever answer is picked apply only here or set a pattern the corpus should apply consistently?

**Where this comes from, re-verified against current code.** The Problem's claim — "nothing fails if a planning session skips the bearing/independent split or builds over a bearing open issue; the gate is ceremony prompt text" — still holds exactly as filed. `plugins/ok-planner/skills/plan-sprint/SKILL.md` §4 ("The issue intake") implements the split described in the decision's Choice faithfully: a feature-work sprint drafts first (§2–§3), then dispatches a `general-purpose` subagent (the "Relevance pass," lines 164–229) that classifies each unruled open issue as `BEARS` or `INDEPENDENT` purely by following prose instructions — a "test" stated in English, an output-format request, and an anti-padding list. Nothing downstream parses that subagent's `Status:` line or per-issue verdicts, nothing blocks §5 sign-off or §6 terminal if a bearing issue was never walked, and nothing re-checks after the fact that a signed-off sprint's deltas or work items don't silently collide with a bearing issue the pass mis-scored. The discipline is 100% load-bearing on the dispatched agent's compliance with its prompt. One thing has changed since filing and is immaterial here: the issue intake itself moved from `issues.jsonl` rows to one markdown file per issue under `.ok-planner/issues/` (with ruled issues now pulled in ahead of the relevance pass at §1) — this affects *how issues are read*, not whether the relevance split or the "don't build over a bearing issue" rule is mechanically enforced. The Problem has not rotted.

**What the corpus says.** The decision's own `## Proof` section already states the gap: "No enforcing check exists today... Filed to the intake queue for owner calibration" — this issue is essentially that admission surfaced as a filed issue (`kind: discover`). The governing rule is `{{DECISION-DEFINITION}}` in `skills/_shared/artifact-definitions.md`: "a 'decision' for which no violation-detecting check can be named is either really a default (delete it) or an unenforced intention (file an issue — the next sprint decides whether to make it enforceable or let it go)." That rule says this decision cannot simply stay as-is indefinitely — it constrains the *shape* of the eventual resolution (enforceable, or let go) but does not itself pick between them. `story:plan-a-sprint`'s Acceptance and Falsifier describe the same ceremony (draft first, walk only bearing issues, owner promotes-or-retires) but its `Proof:` is a Demo — "a third party given only the finished sprint document can state exactly what will change... and the queue fold shows every walked issue promoted... or retired" — a manually-inspectable exhibit, not an automated fail-fast check, and it proves the *story*, not a substitute for this decision's own Proof field. `concept:sprint` and `concept:corpus-delta` define what a sprint and a delta are; neither speaks to how the relevance split is checked. `decision:prove-audit-audience-split` is a structural sibling — identical "No enforcing check exists today... Filed to the intake queue for owner calibration" language, and it has its own still-open sibling issue (`proof-prove-audit-audience-split`, filed in the same batch). More broadly, 9 of the corpus's 20 live decisions currently carry this exact unresolved-Proof shape, each with its own already-filed `proof-*` issue — this is a systemic pattern across the corpus, not an isolated one, though only this decision's issue is this discussion's business.

**What the code does today.** Confirmed above: the relevance pass is a single `Agent` dispatch in `plan-sprint/SKILL.md` with no downstream consumer of its structured output, no gate on sign-off, and no post-sign-off check. `surface-corpus` (`plugins/ok-planner/scripts/surface-corpus`, invoked at the issue-walk step) surfaces candidate corpus artifacts for a human to read during the walk — it is a display aid for the *human walk*, not an enforcement mechanism for whether the relevance split itself happened or was honored.

**Candidates.** The two filed candidates: (1) *amend Proof to name an enforcing check once one exists* — this is inherently deferred; it names nothing to build now and is a no-op until some future sprint separately invents and builds a check, at which point the amendment is a formality. (2) *accept ceremony-prompt enforcement and record that in the decision* — i.e. rewrite the Proof field to describe prompt-adherence itself as the accepted mechanism rather than promising a future mechanical check. This sits in tension with `{{DECISION-DEFINITION}}`'s own bar ("the mechanical check that fails if the choice is silently violated") — a Proof field that names no violation-detecting check may not be a compliant Proof at all under the corpus's stated rule, unless the owner is deliberately carving an exception for ceremony-shaped decisions (choices about what an agent does mid-session, as opposed to a static property of code) that this decision and its `prove-audit-audience-split` sibling both are.

A genuinely distinct shape neither candidate names: (3) *retire `decision:relevance-scoped-queue-gate` as a decision artifact.* `{{DECISION-DEFINITION}}`'s own "let it go" branch reads naturally as "stop treating this as a decision" rather than "keep it as a decision with a non-mechanical proof." The choice and rationale already live verbatim as skill prose in `plan-sprint/SKILL.md`; retiring the decision file would drop the corpus-catalog record of the tradeoff (and its Alternatives) without changing runtime behavior at all — a real cost if the owner wants the tradeoff durably recorded outside of skill text. (4) *Actually build the enforcing check* — e.g., something that requires the relevance-pass subagent's per-issue verdicts to be persisted and cross-checked before §5 sign-off, or that inspects a finished sprint plus the intake snapshot at draft time for an unresolved bearing issue. This is the shape candidate (1) defers to "once one exists" — naming a concrete design is a sprint's job, not this discussion's, but the owner should know that candidate (1) is not self-executing: nobody has proposed what the check would actually inspect.

**What the ruling needs to decide.** (a) Does this decision resolve by committing to design and build a mechanical enforcing check (Proof field stays a placeholder pointing at that future work), by formally accepting non-mechanical ceremony enforcement as sufficient (Proof field rewritten to say so), or by retiring the decision artifact and leaving the discipline as skill prose only? (b) If ceremony/prompt-only enforcement is accepted, is that a one-off ruling for this decision, or a policy the owner wants applied consistently to the ~9 sibling decisions currently carrying the identical unresolved-Proof gap (each already filed as its own issue)?

## Ruling

<!-- Owner: write your decision here in your own words.
The next /plan-sprint picks it up. Leave empty to discuss
it live in a planning session instead. -->
