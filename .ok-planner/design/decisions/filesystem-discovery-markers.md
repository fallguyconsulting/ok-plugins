---
decision: filesystem-discovery-markers
---

# Integration is discovered by filesystem markers, never inference

## Choice

"Which suite plugins does this project use" is answered solely by checking for each plugin's committed dot-directory estate at the project root (resolved as the nearest git ancestor), plus documented pre-migration marker locations so un-migrated projects are still discovered and offered migration. Hooks use the same rule to decide whether to no-op; absence is a meaningful state — bootstrap candidate or recorded decline — not an error.

## Rationale

A filesystem check is deterministic, per-project, and requires zero per-plugin knowledge in the dispatcher — exactly what lets the front door stay deliberately dumb. Inference from project content would misfire in both directions and make integration state a matter of opinion; honoring documented legacy markers keeps migration offerable without guessing.

## Alternatives

- Infer usage from project content or conversation — nondeterministic, and puts per-plugin heuristics into the dispatcher the contract forbids to carry them.
- A central registry of integrated plugins — a second source of truth that drifts from the estates themselves.
