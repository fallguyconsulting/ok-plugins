---
issue: proof-edit-hook-wiring
kind: discover
category: proof
artifacts:
  - decision:edit-hook-blocks-in-turn
status: promoted
opened: 2026-07-25T02:16:01Z
sprint: 2026-07-26-vendored-suite-conduct-split.md
---

# The edit-hook's wiring is real code with zero test coverage

`decision:edit-hook-blocks-in-turn` — Plumbline's PostToolUse hook lints an edit in-turn and blocks the violating change — is realized by genuine deterministic logic in the materialized hook (`plugins/ok-plumbline/scripts/hooks/post-edit.js`): it parses changed-line ranges out of `git diff -U0` hunk headers, scopes the lint to those lines, and carries five deliberate fail-open branches for degraded environments. None of that is exercised by the plugin's test suite — `test/run.sh` invokes the lint binary directly against twelve fixtures and never runs the hook itself. The decision's Proof field states the gap plainly.

This is not a prompt-fidelity question, so the owner's prompt-executed-checks precedent doesn't cap it: hook wiring is ordinary code with mechanically testable behavior. The stakes are asymmetric — this is the suite's one *blocking* enforcement path, and its most likely failure modes (a hunk-header format edge case mis-scoping the lint; a fail-open branch that opens when it shouldn't) are exactly the kind that stay invisible until a consumer project hits them, because fail-open by design produces no signal.

## Options

- **Build a hook-invocation harness** — extend `test/run.sh` with git-fixture cases that invoke the hook as the harness would (a staged edit, a hunk at file start/end, a degraded environment per fail-open branch). Real, bounded work with a producible falsifier for each branch; the plugin already has fixture machinery to build on.
- **Unit-test only the hunk-parsing function** — cheapest real coverage; leaves the fail-open branches and end-to-end wiring unproven.
- **Accept binary-level testing as the permanent boundary** — record it honestly in the Proof; the wiring stays covered by nothing.

## Ruling

> Recommended ruling (/verify-issues): build the hook-invocation harness — a sprint work item extends the plumbline test suite with git-fixture cases invoking the materialized hook end-to-end, covering changed-line scoping and each fail-open branch, and the decision's Proof is rewritten to name that harness.
>
> Rationale: this is the one place in the suite where enforcement blocks a user's edit in real time, and its failure modes are silent by design — the strongest claim on real coverage anywhere in the estate. The precedent that lets sibling decisions settle for text-presence proofs is explicitly about what *cannot* be checked; this can be, and Plumbline's whole identity is deterministic enforcement over prompt trust.

<!-- Owner: this is a recommendation, not your decision. Leave it
as-is to accept — the next /plan-sprint carries it, naming the
generated/recommended batches at sign-off. Edit the text to
redirect, empty the section to discuss live, or delete this note
to adopt the ruling as your own. -->
