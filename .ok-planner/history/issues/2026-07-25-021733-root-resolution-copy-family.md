---
issue: root-resolution-copy-family
kind: discover
category: inconsistent
artifacts:
  - concept:estate
status: promoted
opened: 2026-07-25T02:17:33Z
sprint: 2026-07-25-ruled-intake-drain.md
---

# Project-root resolution is implemented at least six times, two different ways

Everything in the suite keys on "the project root," and at least six independent implementations compute it: four bash walk-up-to-`.git` loops (ok-planner's two hooks and its true-up script, ok-workspaces' session-start hook), one Node equivalent (ok-plumbline's post-edit hook), and a different strategy entirely — `git rev-parse --show-toplevel` — in ok-workspaces' three scripts and src-tag. Two languages, two semantics families, six-plus copies. A semantics change (worktrees, submodules, a missing `.git`) would need hand-application at every site, with nothing to catch a missed one — and the walk-up and rev-parse strategies already disagree in edge cases (rev-parse fails outside a work tree; the walk-up falls back to the working directory).

The corpus states the *result* — `decision:filesystem-discovery-markers` says roots resolve "as the nearest git ancestor" — but no artifact owns the rule, and `concept:estate` never mentions resolution at all. Deduplicating the *code* runs against the suite's architecture: plugins are deliberately self-contained, with no shared runtime to import from, and the transclusion pattern covers ok-planner's prompts, not cross-plugin bash. So the realistic fix is a canonical rule the copies must conform to, not a shared implementation.

## Options

- **State the invariant once in `concept:estate`** — "the project root is the nearest ancestor containing `.git`, else the working directory" — making every implementation's conformance checkable and future drift a findable violation. No code deduplication, but the rule gains a home.
- **Record the copy family as a decision** — names the single-file-script tradeoff explicitly (matching the src-tag decision's no-dependency value), but must still say what the copies keep in lockstep, which is the invariant above anyway.
- **Leave it** — six unanchored copies, two strategies, no rule.

The ruling decides: where the canonical resolution rule lives (and whether the rev-parse family is conforming or divergent).

## Ruling

> Recommended ruling (/verify-issues): state the invariant in `concept:estate` — a sprint delta adds the resolution rule (nearest `.git` ancestor, else the working directory) to the concept's invariants, noting that `git rev-parse --show-toplevel` is a conforming implementation *inside* a work tree, and a work item sweeps the six sites for conformance.
>
> Rationale: shared runtime is off the table by the suite's own self-containment architecture, so the honest single source is the rule, not the code — the same resolution the corpus reached for annotation integrity, where copies are checked against a stated canon rather than merged.

<!-- Owner: this is a recommendation, not your decision. Leave it
as-is to accept — the next /plan-sprint carries it, naming the
generated/recommended batches at sign-off. Edit the text to
redirect, empty the section to discuss live, or delete this note
to adopt the ruling as your own. -->
