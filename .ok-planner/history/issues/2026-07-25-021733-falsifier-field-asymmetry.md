---
issue: falsifier-field-asymmetry
kind: discover
category: inconsistent
artifacts:
  - concept:falsifier
  - concept:decision-artifact
  - concept:story-artifact
status: promoted
opened: 2026-07-25T02:17:33Z
sprint: 2026-07-25-ruled-intake-drain.md
---

# Stories get a Falsifier section; decisions don't — and nothing says whether that's intended

The story template has a standalone `## Falsifier` section; the decision template has none — a decision's falsifier lives inside its `## Proof` field as the "what fails if this is silently violated" clause. `concept:falsifier`'s Boundaries states this asymmetry as current fact without ruling on whether it is the intended permanent shape, and `/prove`'s skill text still carries a compatibility hedge: derive a decision's falsifier from Proof intent "if the artifact predates an explicit statement." So three surfaces describe the asymmetry and none owns it — a reader can't tell design choice from historical accident, and the prove verb still budgets for decisions whose falsifier might be missing.

There is a defensible logic to the current shape: a story's falsifier is a first-class user-visible failure (the story template separates it because acceptance and falsification are different conversations), while a decision's falsifier is definitionally the silent violation of the choice — inseparable from the proof that watches for it. But nobody has written that down.

## Options

- **Keep the asymmetry, own it** — state in `concept:falsifier` that the two shapes are deliberate (with the rationale above), and drop the derive-shim from `/prove` after an audit pass confirms every live decision's Proof states its violation clause explicitly. Small footprint; ends the ambiguity.
- **Symmetrize** — give decisions a dedicated `Falsifier:` field: template change, concept updates, and a migration of every live decision. Real churn for consistency's sake alone.
- **Leave everything** — costs nothing, keeps the hedge and the unexplained asymmetry indefinitely.

The ruling decides: deliberate asymmetry (documented) or symmetry (migrated)?

## Ruling

> Recommended ruling (/verify-issues): keep the asymmetry and own it — a sprint delta amends `concept:falsifier` to state the two shapes as deliberate (story falsifiers are first-class user-visible failures; a decision's falsifier is the silent-violation clause its Proof names), plus a work item verifying every live decision's Proof states that clause and then removing `/prove`'s derive-shim.
>
> Rationale: the asymmetry tracks a real difference in what the two artifact kinds promise, so symmetrizing buys uniformity at the cost of corpus-wide churn with no new protection; the actual defect is only that the choice is unwritten and the prove verb still hedges against a state the corpus no longer permits.

<!-- Owner: this is a recommendation, not your decision. Leave it
as-is to accept — the next /plan-sprint carries it, naming the
generated/recommended batches at sign-off. Edit the text to
redirect, empty the section to discuss live, or delete this note
to adopt the ruling as your own. -->
