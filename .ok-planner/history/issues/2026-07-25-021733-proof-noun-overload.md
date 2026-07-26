---
issue: proof-noun-overload
kind: discover
category: overloaded
artifacts:
  - concept:proof
  - concept:issue
status: promoted
opened: 2026-07-25T02:17:33Z
sprint: 2026-07-25-ruled-intake-drain.md
---

# "Proof" does triple duty, and the corpus disambiguates only two of the senses

The word "proof" carries three unrelated meanings in live prose: the **Proof field** on a story or decision (the canonical statement of what check protects it — owner-mutated, planning-time), the **proof file** in code (the working artifact carrying the annotation — freely refactorable within intent), and the **`proof` issue category** (a classification label for intake questions about proofs — issue-lifecycle-mutated). `concept:proof` already separates the first two carefully, with distinct mutation rules for each. The third sense lives only in the issue-category enum in the shared artifact definitions, with no cross-reference in either direction — `concept:proof` doesn't know the category exists, and `concept:issue`'s category list doesn't note the collision.

No current site is actually confused; context disambiguates everywhere today. But three mutation-rule regimes sharing one noun is exactly the kind of overload the corpus exists to prevent, and the cheapest moment to fence it is while nothing is broken.

## Options

- **Document the third sense** — one addition to `concept:proof`'s Boundaries: the `proof` issue category names *questions about* proofs, not a third proof-artifact kind, cross-referencing `concept:issue`. Extends the concept's existing self-disambiguation; costs a sentence.
- **Rename the category** — removes the collision at the root, but touches the category enum, historical `category: proof` issue files, and anything keyed on the literal string, for a collision producing no observed confusion.
- **Leave it** — free until the first real confusion, at which point the fix is the same sentence plus the cleanup.

The ruling decides: document, rename, or wait.

## Ruling

> Recommended ruling (/verify-issues): document the third sense — a sprint delta adds the one-sentence disambiguation to `concept:proof`'s Boundaries (the issue category names questions about proofs; see `concept:issue`), leaving the category name unchanged.
>
> Rationale: the concept already models exactly this move for the field/file split, so extending it is consistent and nearly free; renaming buys nothing observed and costs churn across historical intake files. The close call is against waiting — a sentence now is cheaper than the same sentence after the first misreading.

<!-- Owner: this is a recommendation, not your decision. Leave it
as-is to accept — the next /plan-sprint carries it, naming the
generated/recommended batches at sign-off. Edit the text to
redirect, empty the section to discuss live, or delete this note
to adopt the ruling as your own. -->
