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

# Every corpus artifact carries a `status:` field that nothing defines or reads

Every concept, story, and decision file in the design corpus carries `status: as-is` in its frontmatter — every template emits it, every live file has it, and no value other than `as-is` has ever appeared. Nothing reads the field: no skill branches on it, no check validates it, and none of the three artifact-kind concepts (`concept-artifact`, `story-artifact`, `decision-artifact`) mentions it in their What-it-is, Boundaries, or Invariants. It is write-only data whose legal values are defined nowhere.

The cost is small but real: a reader can't tell whether the field is vestigial, reserved for something planned, or meaningful with an undocumented vocabulary — and a contributor authoring a new artifact has no rule to follow beyond copying `as-is`. The corpus is silent; nothing forces any particular resolution.

## Options

- **Drop the field** — remove it from the three templates and strip it from live files in one migration pass. Removes dead weight; costs a mechanical sweep across the corpus.
- **Define the vocabulary** — enumerate legal values in the three artifact-kind concepts. Cheap, but inventing values for a field nothing consumes just documents dead weight more thoroughly.
- **Repurpose it** — give it a real consumer (e.g. distinguishing bootstrap-extracted artifacts from sprint-refined ones, which audit or discover-design could key on). Genuinely new signal, but speculative machinery until something actually needs the distinction.

The ruling decides: drop, define, or repurpose.

## Ruling

> Recommended ruling (/verify-issues): drop the field — a sprint delta removes `status:` from the three templates in the shared artifact definitions, and a work item strips it from the live corpus files in the same pass.
>
> Rationale: a field nothing reads and nothing defines is exactly the shape of capability this intake retired elsewhere today (the lint's disable flags, the profile's version field) — the suite's grain is that unread machinery goes away rather than getting documentation that ratifies it. If a bootstrap-vs-refined distinction is ever needed, reintroducing a field *with* a consumer is a clean future decision.

<!-- Owner: this is a recommendation, not your decision. Leave it
as-is to accept — the next /plan-sprint carries it, naming the
generated/recommended batches at sign-off. Edit the text to
redirect, empty the section to discuss live, or delete this note
to adopt the ruling as your own. -->
