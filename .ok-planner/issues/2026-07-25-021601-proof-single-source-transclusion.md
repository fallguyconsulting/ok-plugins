---
issue: proof-single-source-transclusion
kind: discover
category: proof
artifacts:
  - decision:single-source-transclusion
status: verified
opened: 2026-07-25T02:16:01Z
---

# Token transclusion has no resolution check

## Problem

Substitution is performed by the running model; no tooling verifies a {{TOKEN}} resolves to a real shared block, so a typo degrades silently to literal prompt text.

## Candidates

- Amend decision:single-source-transclusion Proof to name a token-resolution check once one exists
- Accept model-time substitution as unchecked and record that in the decision

## Discussion

**The question.** `decision:single-source-transclusion` requires every skill to
pull shared rule text in by `{{TOKEN}}` blocks rather than restating it, so
canonical wording never drifts between the skill that authors an artifact and
the skill that reviews it. Substitution happens at dispatch-assembly time,
performed by the running model reading the token name and copying the
matching `###` block's body — there is no tool in the loop. If a token is
mistyped, renamed on one side only, or a referenced heading is deleted, the
model has no way to notice: the token just degrades to literal, unexpanded
`{{TOKEN}}` text (or, worse, the model silently improvises content it thinks
the token probably meant). The question for the owner: should this decision
gain an enforcing check, or is "unenforced by design" the accepted state —
and if the latter, does the decision's own contract (every decision needs a
named mechanical check, `{{DECISION-DEFINITION}}` in
`skills/_shared/artifact-definitions.md`) require it to be rewritten to say
so, or retired?

**Where this comes from, re-verified against current code.** The filed
Problem is still accurate as stated — nothing about it has rotted. I
independently re-verified the mechanism: every `{{TOKEN}}` in
`plugins/ok-planner/skills/*/SKILL.md` and `skills/_shared/*.md` was diffed
against every `### {{TOKEN}}` heading defined in
`skills/_shared/artifact-definitions.md` and
`skills/_shared/design-doc-compliance-reviewer.md`. Today every used token
resolves to a defined heading — no dangling references exist right now. But
that is a snapshot, not a guarantee: I found it by running the exact grep a
resolution-checking tool would run, and nothing in the plugin's `scripts/`
runs that grep automatically. `scripts/` today holds only `true-up`,
`surface-corpus` (issue-to-corpus relevance ranking, unrelated), and the
hooks — no token-resolution check exists anywhere in the repo.

The task context flagged one instance worth naming directly: the shared
token `{{ISSUE-QUEUE-FORMAT}}` was recently renamed to `{{ISSUE-FILE-FORMAT}}`
as part of the issues.jsonl → file-per-issue migration. This is precisely the
failure shape the issue describes — a rename on the definitions side that
every transcluding skill must also pick up, with nothing to catch a site that
was missed. In this instance the rename was swept correctly everywhere (the
grep above confirms it), but that correctness was established by manual
diligence in this session, not by any standing check — which is itself the
issue's point: today, catching a missed token rename depends entirely on
someone happening to grep for it.

**What the corpus says.** `decision:single-source-transclusion`'s own Proof
section already states the gap in the same terms as this issue: "No
enforcing check exists today: substitution is performed by the model with no
tooling verifying a token resolves to a real block... Filed to the intake
queue for owner calibration." The corpus does not resolve the question — it
names it and defers, which is why this issue exists. Per
`{{DECISION-DEFINITION}}` in `skills/_shared/artifact-definitions.md`, every
decision must carry "the mechanical check that fails if the choice is
silently violated"; a decision for which none can be named is "either really
a default (delete it) or an unenforced intention (file an issue — the next
sprint decides whether to make it enforceable or let it go)." That is the
exact fork this issue puts to the owner. Per
`{{PROOF-PROTECTION-RULE}}` (same file), `/prove` treats a decision with no
annotated proof artifact in code as missing coverage — and indeed no code
anywhere carries `@decision:single-source-transclusion` (verified: zero
matches repo-wide), so this decision fails `/prove`'s completeness bar today,
by its own Proof text's admission. `concept:design-corpus` and
`concept:skill` (see also: `single-source-transclusion` under decisions) both
assume transclusion happens but say nothing about verifying it — they are
silent on enforcement, not in tension with the issue.

Note for the owner: a structurally identical issue exists for
`decision:whole-file-ownership`
(`.ok-planner/issues/2026-07-25-021601-proof-whole-file-ownership.md`) — same
"no enforcing check exists today... filed to intake queue for owner
calibration" pattern, same fork. A ruling here may set the pattern the owner
wants applied there too, though the two are independent questions with
independent code surfaces.

**What the code does today.** Substitution is pure model behavior: a skill's
markdown body contains `{{TOKEN}}` and the running model, when assembling a
subagent dispatch or reading `skills/_shared/artifact-definitions.md`
directly, replaces it with the matching block's body by convention alone
(`How consumers use this file`, `skills/_shared/artifact-definitions.md`).
No script parses a skill file, extracts its tokens, and confirms each
resolves to a live `###` heading — the closest existing analogue is
`{{ANNOTATION-INTEGRITY-RULE}}`, which `/audit` already runs mechanically
against code-side `@concept:`/`@story:`/`@decision:` annotations (`rg -n
'@(concept|story|decision):\s*\S+'`, every match's slug checked against a
live artifact file). That check is a template for what a token-resolution
check could look like, but nothing equivalent runs against `{{TOKEN}}` sites
today.

**Candidates developed.** The two filed candidates, plus one this reading
surfaced:

- *Amend the Proof to name a check once one exists.* Defers the actual
  question — it says what to do after a check is built, not whether to build
  one. On its own this leaves the decision non-compliant with
  `{{DECISION-DEFINITION}}`'s "name the mechanical check" requirement
  indefinitely, since nothing commits to building it.
- *Accept model-time substitution as unchecked, record that in the
  decision.* This is close to the decision's current state already — the
  Proof section already discloses the gap. Making it the final answer would
  mean rewriting the Proof field to stop calling this "filed to intake queue
  for owner calibration" and instead state, permanently, that resolution is
  unchecked by design. Under `{{DECISION-DEFINITION}}`'s fork, an
  intentionally-unenforceable decision is arguably not a decision that can
  carry a mandatory Proof field at all — this candidate would need to
  either accept the decision as a rare Proof-less exception or retire it.
- *Build a mechanical resolution check, structurally mirroring
  `{{ANNOTATION-INTEGRITY-RULE}}`.* A script (or an `/audit` pass) that
  extracts every `{{TOKEN}}` used across `skills/*/SKILL.md` and
  `skills/_shared/*.md` and confirms each resolves to a `### {{TOKEN}}`
  heading in `artifact-definitions.md` or
  `design-doc-compliance-reviewer.md` — dangling and orphaned tokens
  reported the same way dangling annotations are today. This is what would
  let the decision name a real enforcing check and pass `/prove`. Tradeoff:
  it is new surface to build and maintain, and (per the filed Problem) it
  only catches *unresolved* tokens — a token that resolves to the *wrong*
  block, or a block edited to no longer say what a distant skill assumes,
  would still pass silently.

**What the ruling needs to decide.** Does `decision:single-source-transclusion`
get a mechanical resolution check built (making a token-resolution audit part
of `/audit` or a standalone script, with the decision's Proof field naming
it), or does the owner accept unchecked model-time substitution as the
permanent state (and if so, does the Proof field get rewritten to say so
outright, or does the decision get retired as unenforceable)?

## Ruling

<!-- Owner: write your decision here in your own words.
The next /plan-sprint picks it up. Leave empty to discuss
it live in a planning session instead. -->
