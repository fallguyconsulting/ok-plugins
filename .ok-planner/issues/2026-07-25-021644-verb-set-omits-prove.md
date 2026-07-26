---
issue: verb-set-omits-prove
kind: discover
category: unspecified
artifacts:
  - concept:integration-contract
status: verified
opened: 2026-07-25T02:16:44Z
---

# The contract's verb taxonomy has no place for `/prove`

`concept:integration-contract` defines a two-verb taxonomy for integrable plugins: the lifecycle verb (`true-up`, universal) and a read-only compliance verb (`audit`, for plugins with rules to check). But ok-planner ships — and its own manifest and contributor docs name — a third peer verb, `/prove`, which is neither: it executes proofs and exhibits falsifiers, a different job from either category. `decision:prove-audit-audience-split` is explicit that prove and audit are deliberately separate verbs with disjoint audiences, so `/prove` can't be waved in as a flavor of the compliance verb. The contract's taxonomy simply doesn't describe the suite it governs.

The wrinkle is scope: the contract's invariants govern *every* integrable plugin, and only ok-planner has a proof concept at all — ok-plumbline and ok-workspaces ship nothing like `/prove` and shouldn't be obligated to. So an unconditional third category would be wrong in the other direction.

## Options

- **Conditional third category** — amend the contract's invariant: "plugins whose estate carries provable artifacts also expose a proof-running verb." Describes exactly the current suite; obligates no plugin that lacks the concept.
- **Unconditional third category** — obligates two plugins to grow a verb they have no subject matter for.
- **Leave the taxonomy as-is** — the contract keeps under-describing a verb the plugin's own manifest calls out as a peer; the next audit re-files this.

The ruling decides: does the contract gain the conditional proof-verb category?

## Ruling

> Recommended ruling (/verify-issues): add the conditional category — a sprint delta amends `concept:integration-contract`'s invariants with "plugins whose estate carries provable artifacts also expose a proof-running verb," leaving the two existing categories untouched.
>
> Rationale: the contract's value is that a reader can derive any plugin's verb surface from it; today `/prove` is underivable. The conditional wording closes that gap while matching the suite exactly — it is the same shape the contract already uses for the compliance verb ("plugins with rules to check also expose…").

<!-- Owner: this is a recommendation, not your decision. Leave it
as-is to accept — the next /plan-sprint carries it, naming the
generated/recommended batches at sign-off. Edit the text to
redirect, empty the section to discuss live, or delete this note
to adopt the ruling as your own. -->
