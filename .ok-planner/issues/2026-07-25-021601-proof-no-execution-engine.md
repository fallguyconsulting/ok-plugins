---
issue: proof-no-execution-engine
kind: discover
category: proof
artifacts:
  - decision:no-execution-engine
status: verified
opened: 2026-07-25T02:16:01Z
---

# No-execution-engine choice is enforced only by absence

## Problem

The choice is visible only as the absence of plan/execute machinery; nothing would fail if an execution skill or plan artifact reappeared.

## Candidates

- Amend decision:no-execution-engine Proof to name an enforcing structural check once one exists
- Accept the decision as unenforceable-by-nature and record that in its Proof section

## Discussion

**The question.** `decision:no-execution-engine`'s Proof field names no
violation-detecting check — it states, as its own content, that nothing
would fail if a plan artifact or execution skill reappeared. The owner
must decide whether that is an acceptable permanent state for the
decision's Proof field, or whether a real check should be found (and, if
so, roughly what kind).

**Where it comes from.** Re-verified against the current repo, not
rotted: `plugins/ok-planner/CLAUDE.md`, `skills/ok-planner/SKILL.md`,
`skills/plan-sprint/SKILL.md`, and the materialized
`scripts/ok-planner-CLAUDE.md` all still assert "no plan artifact" and
route execution through the sprint's baked completion contract, picked
up inline, via the native `goal` mechanism, or by an orchestrator.
`plugins/ok-planner/skills/audit/SKILL.md` (the corpus audit) runs three
passes — compliance, coverage/intent-drift/annotation-integrity,
cross-artifact consistency — and none of them scans for a reintroduced
plan-artifact schema or execution-engine skill; audit's own "What this
skill does NOT do" section confirms it audits corpus↔code links, not
structural reintroduction of retired architecture. No plumbline check,
schema file, or other mechanism in the current tree fills that gap
either. So the Problem as filed still holds exactly as stated.

**What the corpus says.** `concept:decision-artifact`'s invariants
require every decision to carry a mandatory Proof field, and permit
exactly this outcome for a choice with no nameable check: "an unenforced
intention (an issue is filed for owner calibration)." That is a
description of the filing mechanism, not a ruling — it explains why this
issue exists, but does not say whether the owner should let it stand or
insist on finding a check. `concept:completion-contract` and
`concept:sprint` both explain *why* the choice was made (the contract,
not an engine, is the executor-agnostic interface) but say nothing about
enforcing that no engine returns. `concept:falsifier` sets the bar any
named check would have to clear: a falsifier must be "concretely
producible" — a mutation that can actually be staged and reverted to
watch red-then-green — which is the standard any candidate check below
would be held to.

A sibling decision, `decision:slash-only-activation`, carries the
identical unenforced-Proof pattern ("No enforcing check exists today...
Filed to the intake queue for owner calibration") and has its own
sibling issue (`.ok-planner/issues/2026-07-25-021601-proof-slash-only-activation.md`),
filed in the same batch. Whatever principle the owner applies here will
likely bear on that one too, though this issue does not resolve it.

A related but distinct open issue,
`.ok-planner/issues/2026-07-25-022648-prompt-executed-checks-as-proofs.md`,
asks whether an agent-performed, skill-prompt-directed check (as opposed
to a mechanical/scripted one) counts as an "enforcing check" for a
decision's Proof field at all. That extractor's own accounting already
placed `no-execution-engine` in the "genuinely no check" bucket rather
than the ambiguous prompt-executed one — but if the owner's ruling there
lands on "prompt-executed checks count," it materially widens what
"amend the Proof to name a check" (candidate 1 below) could mean here,
since the code has no schema layer to hang a scripted check on; any
mechanical check would necessarily be prompt-executed (e.g. an
audit-pass grep/directory sweep).

**What the code does today.** There is no plan-artifact schema, no
execute-plan-style skill, and no lint or audit rule that would fire if
either reappeared. The suite once had exactly that machinery — the
retired pre-4.0 flip-gated execution engine described in
`plugins/ok-planner/design-notes/2026-06-05-flip-gated-execution.md`
(`write-plan`, `execute-plan`, gate pre-flight, escalation taxonomy) —
and `decision:no-execution-engine`'s Alternatives section names it as
the rejected shape. Nothing currently detects a regression back toward
it; the absence is total.

**Candidates.**

- *Amend the Proof to name an enforcing check once one exists.* As
  written this candidate defers rather than resolves: it doesn't name a
  check now, and `concept:decision-artifact`'s bar requires the check be
  concretely producible today, not promised for later. Adopting it
  without also designing the check leaves the Proof field exactly as
  toothless as it is now, just with different wording.
- *Accept the decision as unenforceable-by-nature, record that in its
  Proof section.* This matches the sanctioned "unenforced intention"
  path `concept:decision-artifact` already describes, and the current
  Proof text already says almost exactly this — the main change would
  be dropping the now-stale "filed to the intake queue" clause (this
  issue *is* that filing) once ruled, and stating plainly that the
  choice is enforced by convention/review only.
- *A genuinely different third shape, surfaced but not filed:* a
  structural check actually can be named, in the same idiom `/audit`'s
  own coverage pass already uses (a grep/directory sweep for named
  patterns) — e.g. failing if a skill directory matching the retired
  shape (`execute-plan`-style dispatch/gate/escalation skill) or a
  plan-artifact schema file reappears under `plugins/ok-planner/`. This
  would be prompt-executed (an agent running the sweep), not a scripted
  test, so whether it qualifies as an "enforcing check" at all turns on
  how the sibling `prompt-executed-checks-as-proofs` issue is ruled. If
  prompt-executed checks count, this closes the gap outright; if they
  don't, it collapses back into "no check exists" and the choice is
  effectively acknowledged as unenforceable regardless of Proof wording.

**What the ruling needs to decide.** (1) Is a Proof field that names no
check at all an acceptable permanent state for this decision, or must a
check be found? (2) If a check must be found, is a prompt-executed
structural sweep (candidate 3) an acceptable form of "enforcing check,"
or does this decision wait on the prompt-executed-checks-as-proofs
ruling first?

## Ruling

<!-- Owner: write your decision here in your own words.
The next /plan-sprint picks it up. Leave empty to discuss
it live in a planning session instead. -->
