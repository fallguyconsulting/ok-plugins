---
issue: proof-noun-overload
kind: discover
category: overloaded
artifacts:
  - concept:proof
  - concept:issue
status: verified
opened: 2026-07-25T02:17:33Z
---

# The word proof does triple duty in live prose

## Problem

'Proof' names the artifact's intent field, the annotated codebase file, and an issue category; the texts stay careful about it but the noun is genuinely overloaded and each sense has different mutation rules.

## Candidates

- Amend concept:proof Boundaries to name the three senses and give the intent field or the category a distinct term

## Discussion

**The question.** "Proof" is used for at least three distinct things with different mutation rules: (1) the `Proof:` field on a story or decision (the canonical statement of intent), (2) the codebase artifact — demo, example, executable check — that exhibits that intent, and (3) `proof` as one of the issue-intake's category values. Should the concept name and disambiguate all three senses, and should one of them get a distinct term?

**Evidence, re-verified — confirmed, all three senses are live and named "proof."** `concept:proof`'s own body already distinguishes senses (1) and (2) explicitly: "A proof is a codebase artifact... The artifact's proof field is the canonical statement of intent; proof files are working examples of that intent." Its Invariants further separate them by mutation rule: "when intent shifts, the proof-field rewrite comes first and the proof modification follows — never the reverse" — the field is intent (owner/planning-mutated via corpus deltas), the file is implementation (freely refactorable as long as it still satisfies the field). The third sense is confirmed at `{{ISSUE-DEFINITION}}` (`plugins/ok-planner/skills/_shared/artifact-definitions.md:215`): `` `proof` — a proof question needing owner calibration (intent drift, unprovable decision, deprecation candidate). `` — a third, independent meaning: not a field, not a file, but a classification label on an intake row, mutated by whoever files or verifies the issue, following the issue lifecycle's own rules entirely disjoint from the other two senses' rules.

**What the corpus says.** `concept:proof`'s Boundaries section already carefully separates the field-sense from the file-sense within its own text ("The protected thing is the intent, not the byte shape") and cross-references `falsifier`, `annotation`, `corpus-proof`, and `corpus-audit` for the neighboring concerns — but it never mentions the issue-category sense at all, so a reader of `concept:proof` alone would reasonably believe the noun has exactly two senses, not three. `concept:issue` independently defines the category list (including `proof`) but doesn't cross-reference `concept:proof` or acknowledge the name collision — its Boundaries note "the nature of a row is its category; the identity of its writer is its kind" but don't flag that one category name is identical to an unrelated concept's name. Neither `concept:concept-artifact` nor `concept:story-artifact` (both bearing) address the naming collision; they establish the general rules for what a concept or story may and may not enumerate, which is relevant to *how* a fix would be written (concepts must not enumerate implementations, self-containment restricts cross-references to slug form) but don't bear on whether the collision itself needs resolving.

**What the code does today.** All three senses are actively in use with no renaming anywhere: skills read `Proof:` fields from story/decision frontmatter-adjacent bodies, `/prove` executes and exhibits proof files annotated `@story:`/`@decision:`, and `/audit` and `/discover-design` file issues with `category: proof` in frontmatter (confirmed live in the ISSUE-FILE-FORMAT template and definition). Nothing in the current text is actually *confused* by the overload — each site states which sense it means by context — but the noun is genuinely shared across three artifacts with unrelated mutation rules, exactly as filed.

**Candidates, and what each means.** The one filed candidate (amend `concept:proof` Boundaries to name the three senses and rename one) has two sub-choices worth separating for the ruling: *documenting* the overload (adding a sentence to `concept:proof`'s Boundaries acknowledging the issue-category sense and pointing to `concept:issue`, with no renaming) is cheap and matches the pattern of `concept:proof` already disambiguating senses (1) and (2) in its own prose — it would just extend that same disambiguation to include sense (3). *Renaming* one sense — most plausibly the issue category, since it's the newest and most local addition (categories are a closed, easily-changed enum in one template, versus the field/file senses which are woven through every story, decision, and skill) — removes the collision at the root but touches the `{{ISSUE-DEFINITION}}` category list, every filed issue using `category: proof` historically, and any skill logic keyed on that literal string. A shape not filed: leave the category name as `proof` (matching its actual subject matter — proof questions) and instead note in `concept:proof`'s Boundaries that "proof" the issue category names *questions about* proofs, not a fourth kind of proof artifact — resolving the ambiguity by clarifying relationship rather than renaming anything.

**What the ruling must decide.** Whether the three-way overload needs a rename (and if so, which sense — most plausibly the issue category, being the most locally-scoped and least entrenched) or whether documenting the collision in `concept:proof`'s Boundaries (extending its existing two-sense disambiguation to cover the third) is sufficient since no site today is actually confused by which sense is meant.

## Ruling

<!-- Owner: write your decision here in your own words.
The next /plan-sprint picks it up. Leave empty to discuss
it live in a planning session instead. -->
