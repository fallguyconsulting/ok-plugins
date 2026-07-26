---
issue: proof-prove-audit-audience-split
kind: discover
category: proof
artifacts:
  - decision:prove-audit-audience-split
status: verified
opened: 2026-07-25T02:16:01Z
---

# Channel split between prove and audit is prompt-only

## Problem

Nothing fails if the proof run writes the intake queue or the audit stops filing judgment findings; the audience discipline lives entirely in skill text.

## Candidates

- Amend decision:prove-audit-audience-split Proof to name an enforcing check once one exists
- Accept prompt-level discipline and record that in the decision

## Discussion

**The question.** Should `decision:prove-audit-audience-split` — the choice
that `/prove` reports only in-context to the executing agent while `/audit`
only files to the human-facing issue intake — carry a mechanical check that
fails if either verb crosses into the other's channel, or should the corpus
accept that this split is, and will remain, enforced only by skill prompt
text?

**Where it comes from, re-verified.** The filed Problem is not rotted —
current code still matches it exactly. `plugins/ok-planner/skills/prove/SKILL.md`
states in prose "It never writes to the issue intake
(`.ok-planner/issues/`) — filing for the human belongs to `/audit`" and its
"What this skill does NOT do" section repeats that it "leaves no durable
change to code, the corpus, the issue intake, or any file." Symmetrically,
`plugins/ok-planner/skills/audit/SKILL.md` states its only write is filing
issue files ("filing is this skill's only write") and reports mechanical
findings back to the caller in-context rather than executing or fixing
anything. Both disciplines are prose only: a search of the plugin tree and
`.ok-planner/` for any hook, lint, or CI step that would fail if `/prove`
wrote a row to the intake, or if `/audit` returned judgment findings
in-context instead of filing them, turns up nothing — no such check exists
anywhere in the repo today.

**What the corpus says.** `decision:prove-audit-audience-split` itself
already names this exact gap in its own Proof field: "No enforcing check
exists today: nothing fails if the proof run writes the queue or the audit
reports judgment findings only in-context; the channel discipline lives in
prompt text." That is an acknowledgment, not a resolution — the decision
records that the gap exists and that it was filed for calibration; it does
not decide whether a check should be built, or whether prompt discipline is
the intended permanent state. `concept:completion-contract` fixes that the
audit runs last in the completion contract "because its judgment findings
seed the next sprint's intake," which depends on the audience split holding
but does not itself enforce it. No other artifact in `design/` bears on
whether this split needs mechanical enforcement.

One filed issue is directly relevant to how this should be decided:
`prompt-executed-checks-as-proofs` (`.ok-planner/issues/2026-07-25-022648-prompt-executed-checks-as-proofs.md`)
observes that the corpus already counts some skill-prompt-directed
behaviors as satisfying a decision's Proof field elsewhere — e.g. the
audit's own annotation-integrity sweep, and (weakest) the proof run's own
falsifier-exhibition step — while classifying `prove-audit-audience-split`
and `relevance-scoped-queue-gate` as having no check at all, even though
both are also skill-prompt-directed disciplines of the same general shape.
That issue asks the corpus-wide question of where the line sits between "a
prompt-directed behavior counts as an enforcing check" and "prompt text is
not a check." Its resolution bears directly on this one: if prompt-directed
checks are ruled to count, the natural resolution here may be to name the
existing prose discipline itself as the check (word it explicitly, build
nothing new) rather than treat this as an open gap. Two sibling issues of
identical shape for other decisions are also open and unruled:
`proof-relevance-scoped-queue-gate` and `proof-single-source-transclusion`
and `proof-whole-file-ownership` (all filed the same run) — a ruling here
sets a pattern the owner will likely want applied consistently across all
four rather than decided piecemeal.

**What the code does today.** Confirmed above: `/prove` and `/audit` each
observe the split as a matter of following their own skill text, with no
runtime, hook, or lint verifying either does. The plugin ships no Node
tooling — per `plugins/ok-planner/CLAUDE.md`, "skills are markdown, hooks
are bash" — which constrains what a mechanical check could even look like;
`hooks/` scripts are the only executable surface this plugin has today, and
none currently inspects which skill/verb produced a write to
`.ok-planner/issues/` or a return to context.

**Candidates.**

- *Amend the Proof field to name an enforcing check once one exists*
  (filed). Presumes a check gets built. Given the plugin's markdown/bash-only
  constraints, the only plausible mechanical shape would be something like a
  hook that inspects writes under `.ok-planner/issues/` and fails if the
  active skill/session is `/prove` — feasible only if the hook runtime can
  identify which skill is currently active, which is unconfirmed. Until a
  check is actually designed, this candidate leaves the decision's Proof
  field exactly as it is today (naming a gap, not a check).
- *Accept prompt-level discipline and record that in the decision* (filed).
  Rewrites the Proof field to state plainly that the split is enforced by
  skill prompt convention, not mechanically, and drops the "filed to the
  intake queue for owner calibration" framing since the question would be
  considered settled rather than deferred. This issue would retire rather
  than promote.
- *Fold into the prompt-executed-checks-as-proofs ruling* (not filed,
  surfaced here). Rather than deciding this decision in isolation, treat it
  as an instance of the corpus-wide question that issue raises: if the owner
  rules there that prompt-directed, skill-performed disciplines can satisfy
  a Proof field, the resolution here would be to reword this decision's
  Proof to name the existing "prove never writes the intake / audit's only
  write is filing" self-discipline as the check itself — no new tooling,
  just a reclassification consistent with how other decisions in this
  corpus were treated. If that issue is instead ruled the other way (prompt
  text never counts), the "accept prompt-level discipline" candidate above
  is the only currently buildable option, since no mechanical alternative
  exists without new tooling this plugin doesn't have.

**What the ruling needs to decide.**

1. For `decision:prove-audit-audience-split`, is the enforcement permanently
   prompt-level (rewrite the Proof field to say so and retire this issue),
   or should a mechanical check be pursued (leave the gap on record until
   one is designed)?
2. Should that decision be made per-decision now, or deferred until
   `prompt-executed-checks-as-proofs` settles the corpus-wide rule on
   whether prompt-directed checks satisfy a Proof field — given that
   `proof-relevance-scoped-queue-gate`, `proof-single-source-transclusion`,
   and `proof-whole-file-ownership` are the same shape and would likely want
   the same answer?

## Ruling

<!-- Owner: write your decision here in your own words.
The next /plan-sprint picks it up. Leave empty to discuss
it live in a planning session instead. -->
