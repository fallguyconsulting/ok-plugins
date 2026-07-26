---
issue: status-field-values-undefined
kind: discover
category: unspecified
artifacts:
  - concept:concept-artifact
  - concept:story-artifact
  - concept:decision-artifact
status: verified
opened: 2026-07-25T02:16:44Z
---

# Artifact status field has exactly one defined value

## Problem

'status: as-is' is the only frontmatter status value appearing anywhere in templates; no other value is defined, making the field look vestigial or reserved.

## Candidates

- Amend the three artifact-kind concepts to enumerate the legal status values
- Amend the templates (via a sprint) to drop the status field as vestigial

## Discussion

The question: what values (beyond `as-is`) is the `status:` frontmatter field on a concept/story/decision artifact allowed to carry, and if none exist, should the field be defined or dropped? (This is the `status:` on design artifacts — concepts, stories, decisions — not the `status:` on issue files, which is a separate, already-defined field with its own enumerated values.)

Where it comes from: filed against concept:concept-artifact, concept:story-artifact, and concept:decision-artifact. Re-verified against current code: `plugins/ok-planner/skills/_shared/artifact-definitions.md` contains three artifact templates (concept, story, decision), and every one shows `status: as-is` as the frontmatter value with no comment enumerating alternatives. A search of that file for other `status:` usage against a concept/story/decision turns up none — the only other `status:` block in the file is the unrelated issue-file field (`status: open | verified | answered | promoted | retired`).

What the corpus says: none of the three cited concepts (concept-artifact, story-artifact, decision-artifact) mentions the `status:` frontmatter field at all in their What-it-is, Purpose, Boundaries, or Invariants — each names what the artifact owns (definition/purpose/boundary/invariants for a concept; need/acceptance/falsifier/proof-intent for a story; choice/rationale/alternatives/proof for a decision) without mentioning `status`. The field exists only in the templates, not in the concepts that define what these artifacts are.

What the code does today: every concept/story/decision file, live or as templated, carries `status: as-is` and nothing else; no skill branches on the field's value — it is currently write-only, set once at creation and never read by anything downstream.

Candidates as filed: amend the three artifact-kind concepts to enumerate the legal status values; amend the templates (via a sprint) to drop the status field as vestigial. A third shape: keep the field but repurpose it meaningfully — e.g. a value distinguishing an as-is (bootstrap-extracted, unreviewed) artifact from one that has since passed through at least one sprint delta — giving the field an actual signal to carry (useful to the corpus audit or to `discover-design`) instead of being either enumerated-but-inert or removed outright.

What the ruling must decide: whether the `status:` field on concept/story/decision artifacts is genuinely vestigial and should be dropped, or is a placeholder for a real distinction that the corpus should now define.

## Ruling

<!-- Owner: write your decision here in your own words.
The next /plan-sprint picks it up. Leave empty to discuss
it live in a planning session instead. -->
