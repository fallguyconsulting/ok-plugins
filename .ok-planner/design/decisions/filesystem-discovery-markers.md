---
decision: filesystem-discovery-markers
---

# Integration is discovered by filesystem markers, never inference

## Choice

"Which suite families does this project use" is answered solely by
checking for each family's committed dot-directory estate at the
project root, plus documented pre-migration marker locations so
un-migrated projects are still discovered and offered migration. Every
marker the front door honors, current and pre-migration alike, is
documented in the integration contract. The project root is itself
resolved from those same markers: the nearest ancestor of the working
directory (itself included) carrying an estate or documented
pre-migration marker, else the working directory itself — never
derived from `.git`. Every estate a project carries sits at that one
resolved root, so a project has one suite presence rather than one per
family. Hooks use the same rule to decide whether to no-op; absence is
a meaningful state — bootstrap candidate or recorded decline — not an
error.

## Rationale

A filesystem check is deterministic, per-project, and independent of
anyone's memory of what was adopted where: integration state stays a
property of the project, and the administrator reads it rather than
deciding it. Inference from project content would misfire in both
directions and make integration state a matter of opinion; honoring
documented legacy markers keeps migration offerable without guessing.
Documenting the marker set in the contract is what lets a hook, a
ceremony, or a reader apply the same rule the administrator applies.
Resolving the root from the markers themselves rather than from `.git`
keeps the suite usable wherever a project actually lives — a
subfolder, submodule, or subproject of a repository whose own root
wants no estate — and makes a fresh install root exactly where the
agent is operating. One root for every estate keeps the discovery
answer a single directory listing, and stops two families from
disagreeing about where the project is.

## Alternatives

- Infer usage from project content or conversation — nondeterministic,
  and makes integration state a matter of opinion rather than a
  committed fact.
- A central registry of integrated families — a second source of truth
  that drifts from the estates themselves.
- Resolve the project root from the nearest `.git` ancestor — anchors
  the suite to the repository rather than the project, so an install
  in a subproject escalates into a parent repo that never opted in.
