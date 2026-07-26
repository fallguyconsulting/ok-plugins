---
issue: planner-diagnose-not-standalone
kind: discover
category: inconsistent
artifacts:
  - concept:true-up
  - concept:integration-contract
status: promoted
opened: 2026-07-25T02:17:33Z
sprint: 2026-07-25-ruled-intake-drain.md
---

# ok-planner's true-up can't diagnose without converging

`concept:true-up` describes the lifecycle verb as three phases — diagnose (read-only), consent, converge — and ok-planner's two siblings honor the shape: ok-workspaces ships a standalone `diagnose.js` that exits non-zero on drift, and ok-plumbline's binary has a `diagnose` subcommand that runs before anything writes. ok-planner's `scripts/true-up` has no read-only mode at all: it unconditionally creates directories, overwrites the estate CLAUDE.md and cheatsheet, and materializes hooks before reporting retired-layout presence on its last line. An owner or CI process can ask "has this project drifted?" of two plugins and only converge-to-find-out with the third.

The corpus doesn't strictly force the fix: the concept's three-phase shape is stated generally but its invariants demand no standalone invocability or exit code, and the contract's "read-only compliance verb" invariant refers to `/audit`, not a diagnose sub-mode. So this is an inconsistency between siblings and against the concept's evident spirit, not a rule violation — which is why it needs a ruling rather than a repair.

## Options

- **Give the planner a real diagnose** — split `scripts/true-up` into a read-only diagnose pass (report drift, exit non-zero) and the existing converge; parity with both siblings, CI-usable, and the concept's phase model becomes literally true across the suite. Real but bounded script work.
- **Declare standalone diagnose per-plugin-optional** — amend `concept:true-up` to say the phases need not be separately invocable. Cheap, but the only motivation is ratifying the one plugin's gap.

The ruling decides: parity through code, or a corpus carve-out.

## Ruling

> Recommended ruling (/verify-issues): parity through code — a sprint work item adds a read-only diagnose mode to ok-planner's true-up script (drift reported, non-zero exit, no writes), matching the shape its two siblings already ship.
>
> Rationale: the three-phase model is the concept's whole content, and two of three plugins realize it — carving out the third documents an accident as a choice. Diagnose-without-write is also what makes drift checkable from CI, a capability the other estates already have and the planner's (the most rule-laden estate) lacks.

<!-- Owner: this is a recommendation, not your decision. Leave it
as-is to accept — the next /plan-sprint carries it, naming the
generated/recommended batches at sign-off. Edit the text to
redirect, empty the section to discuss live, or delete this note
to adopt the ruling as your own. -->
