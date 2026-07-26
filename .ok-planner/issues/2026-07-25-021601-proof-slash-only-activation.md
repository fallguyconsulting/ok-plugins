---
issue: proof-slash-only-activation
kind: discover
category: proof
artifacts:
  - decision:slash-only-activation
status: verified
opened: 2026-07-25T02:16:01Z
---

# Activation-phrase convention has no check

## Problem

Nothing verifies that a new user-facing skill carries the explicit-activation phrase; the convention is enforced only by contributor-doc prose.

## Candidates

- Amend decision:slash-only-activation Proof to name a frontmatter-phrase check once one exists
- Record the convention as editorially enforced and retire the proof expectation

## Discussion

**The question.** `decision:slash-only-activation` requires every user-facing
skill to declare, in its frontmatter `description`, that it activates only by
explicit slash command (never inferentially, with at most one named
non-human co-activator). No mechanical check verifies any skill actually
carries the phrase, and the decision's own `Proof:` field admits this. Should
the suite build that check now, or accept the convention as prose-only and
retire the decision's proof requirement?

**Where it comes from, re-verified.** The Problem statement is accurate and,
if anything, understates the current gap. `decision:slash-only-activation`'s
own `Proof` section reads verbatim: "No enforcing check exists today: nothing
verifies a new user-facing skill carries the phrase, and the class
membership rule itself is stated nowhere. Filed to the intake queue for
owner calibration." — i.e. the decision was authored already admitting it
has no proof, and this issue is that filing. There is no
`@decision:slash-only-activation` annotation anywhere in the repo (`rg -n
"@decision:slash-only-activation"` returns nothing), consistent with "no
check exists."

Walking the live code confirms the drift is real, not hypothetical. Of the
27 `SKILL.md` files across all plugins, 14 carry the "ONLY activated by
explicit..." phrase and 13 don't. The 13 split into two groups:

- Plumbing skills correctly omitting it: `ok-planner/true-up`,
  `ok-plumbline/true-up`, `ok-workspaces/true-up` (each self-describes as
  "Plumbing — normally driven by `/ok`"). This matches the decision's Choice
  ("plumbing skills deliberately drop the restriction").
- **All ten `ok-plumbline` skills** (`slug`, `suggest`, `explain`,
  `patterns`, `ci`, `audit`, `version`, `starter`, `port`, `budget`) —
  every one of them a user-facing verb invoked by its own slash command,
  none self-describing as plumbing — carry no activation restriction at all.
  This is exactly the silent violation the decision's Invariant forbids
  ("inferential invocation is forbidden" on user-facing skills). `ok-planner`
  and `ok-workspaces` skills are internally consistent (every user-facing
  skill in both carries the phrase, including the newly added
  `verify-issues`); `ok-plumbline` as a whole is not.

That last point also explains why the "contributor-doc prose" enforcement in
the filed Problem is even thinner than described: the instruction to
"preserve it on new skills" lives only in `plugins/ok-planner/CLAUDE.md`
(line 37). `ok-plumbline` has no plugin-level `CLAUDE.md` at all, so its
contributors had no prose reminder to follow — the convention was never
stated where `ok-plumbline` skills are written, not just unchecked.

**What the corpus says.** `concept:skill`'s Boundaries and Invariants restate
the two-class split and call the explicit-activation phrasing "deliberate
and preserved on new skills," but state it as a property to hold, not a
mechanism that holds it. `decision:slash-only-activation` is the load-bearing
artifact and, per its own Proof field, is silent on how the choice is
verified — that silence is precisely this issue. Neither
`concept:story-artifact` nor `concept:falsifier` bears on the substance
directly; they define what a proof and falsifier are in general, and confirm
the general rule cited implicitly by the candidates: a `Proof:` field must
name a mechanical check with a concretely producible falsifier, or (per
`{{DECISION-DEFINITION}}` in `skills/_shared/artifact-definitions.md`) the
decision "is either really a default (delete it) or an unenforced intention
(file an issue — the next sprint decides whether to make it enforceable or
let it go)." No artifact in the corpus decides which of those two paths this
decision takes — that is squarely a ruling, not something derivable from
what's written.

**What the code does today.** Nothing greps `SKILL.md` frontmatter for the
phrase anywhere in the suite: not in `/audit` (whose Pass 2 checks proof
*coverage/annotation integrity* for stories and decisions in general, not
this decision's specific claim), not in `/true-up`, not in any CI workflow
under the repo. The only artifact resembling enforcement is the sentence in
`ok-planner/CLAUDE.md` telling a human contributor to preserve the phrase —
and even that reminder doesn't exist for `ok-plumbline` or `ok-workspaces`
contributors, though `ok-workspaces` happens to comply anyway.

**Candidates.**

- *Build the check, name it in the Proof field.* A mechanical scan — for
  every `SKILL.md` under `plugins/*/skills/`, its `description` either
  contains the activation-restriction phrasing or the skill is on a
  maintained plumbing allowlist — run by `/audit` or a lint step. This is
  concretely producible today: exhibiting the falsifier (drop the phrase
  from a user-facing skill's description) would redden it, and reverting
  would restore green, satisfying `{{PROOF-PROTECTION-RULE}}`'s
  non-vacuity bar. It would also immediately catch the ten already-drifted
  `ok-plumbline` skills, so "once one exists" (as the filed candidate
  phrases it) undersells the state — the check would have work to do from
  the moment it lands, which is itself an argument for building it rather
  than deferring it further. Corpus impact: `decision:slash-only-activation`'s
  Proof field is rewritten to name the check; some enforcing artifact
  carries `@decision:slash-only-activation`. Code impact: the ten
  `ok-plumbline` skills would need the phrase added (or an explicit,
  documented case for why they're plumbing) to pass.
- *Accept prose-only enforcement, drop the proof requirement (as filed).*
  Per `{{DECISION-DEFINITION}}`, decisions carry a mandatory `Proof:` field —
  "a 'decision' for which no violation-detecting check can be named is
  either really a default (delete it) or an unenforced intention." Since a
  decision cannot lawfully keep an empty/absent Proof field, "retire the
  proof expectation" while leaving this as a decision artifact isn't a
  self-consistent end state under the corpus's own rules as currently
  written — the closest legal shape is retiring the decision itself (moving
  the two-class-split rule out of `design/decisions/` and into ordinary
  contributor documentation, e.g. `ok-planner/CLAUDE.md`, `ok-plumbline`
  gaining its own equivalent). That is a heavier move than the candidate's
  wording suggests, and worth the owner knowing explicitly.
- *Editorial fix first, mechanical check deferred* — a third shape neither
  filed candidate names: add the phrase to the ten `ok-plumbline` skills now
  (closing the live drift) without committing either way on whether a
  standing mechanical check gets built, leaving the Proof field's "filed to
  intake" status as-is for a future decision. This resolves the concrete
  code problem immediately but leaves the underlying issue (the decision
  remains unproven) exactly where it is today, just re-filed.

**What the ruling needs to decide.** (1) Should
`decision:slash-only-activation` gain a mechanical proof check, or be
retired as an unenforceable decision and folded into ordinary contributor
docs? (2) Independent of (1), should the ten `ok-plumbline` skills currently
missing the activation phrase be brought into compliance as a matter of
course, given they appear to be a genuine oversight rather than a deliberate
plumbing classification?

## Ruling

<!-- Owner: write your decision here in your own words.
The next /plan-sprint picks it up. Leave empty to discuss
it live in a planning session instead. -->
