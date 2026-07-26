---
topic: concept-artifact
kind: concept
---

# Concept (design artifact kind)

## Description

Per `{{CONCEPT-DEFINITION}}`: "A **concept** is a load-bearing noun the system traffics in — general and abstract. The bar is: a reviewer reading code that mentions this noun needs a stable definition to know what it means." A concept names "**what kind of thing exists**, not the specific instances that exist now." The altitude rule is the kind's sharpest edge: a concept body that lists current implementations (CLI verbs, library names, file extensions, route paths, wire-format identifiers, license identifiers) "has descended below concept altitude — those specifics are implementation detail that belongs in code, in specs, or (for choices with tradeoffs) in a decision. The concept body states the general property; the decisions name the instances that satisfy it." One concept per file.

The file shape (`{{CONCEPT-TEMPLATE}}`): `.ok-planner/design/concepts/<slug>.md` with frontmatter `concept:`, `status: as-is`, optional `aliases:`; sections **What it is** (one standalone-intelligible paragraph), **Purpose** (what its presence makes possible over a flatter design), **Boundaries** (in vs out; neighbors named by slug — "Concept Boundaries is the in-vs-out section, and it names neighbor concepts by slug", replacing any "Owns / Does NOT own" code-path listing), **Invariants** (properties of the concept, not descriptions of code; codebase invariant IDs may be cited because "the ID is stable across file moves, the file path is not"), and **Aliases** (only names that appear *live* in code or prose; multiple live names for one concept is itself an issue candidate; drop the section when empty).

Concepts are the one artifact kind without a proof — stories and decisions carry `Proof:` fields; concepts carry invariants instead, and code cites concepts via `@concept:` annotations at load-bearing sites. The concepts catalog additionally has session-level standing: the generated `concepts.md` TOC is injected into every session by the session-start hook, with instructions to read the full file before using any term it names.

## Code surface

- `plugins/ok-planner/skills/_shared/artifact-definitions.md` `{{CONCEPT-DEFINITION}}` and `{{CONCEPT-TEMPLATE}}` blocks; the concept-specific tightening inside `{{SELF-CONTAINMENT-RULE}}`.
- Reviewer checks: discover-design Phase 2 Reviewer ("What to check on concepts"); the shared compliance reviewer (self-containment, current-state-only, cross-reference integrity).
- `plugins/ok-planner/scripts/hooks/session-start` — the concepts.md injection.

## Prose surface

- `scripts/ok-planner-CLAUDE.md` and cheatsheet one-liners ("load-bearing nouns with definitions, purposes, boundaries, and invariants").

## Adjacent topics

- `design-corpus`, `story-artifact`, `decision-artifact` (the altitude split between them), `self-containment-rule`, `current-state-only-rule`, `annotation-convention`, `catalog-tocs`, `issue-queue` (alias-convergence issues).

## Observations

- The template's Invariants guidance references "if the codebase numbers its invariants under any convention" — support for external invariant-ID schemes with no example in this repo.
- The alias rules are enforced twice with different emphases: the template ("List only names that actually appear in the live codebase") and the phase-2 reviewer cross-check ("Aliases that no longer appear anywhere live must not be listed") — consistent, duplicated by design via transclusion.
