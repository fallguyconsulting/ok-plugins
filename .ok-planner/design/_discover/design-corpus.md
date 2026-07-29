---
topic: design-corpus
kind: concept
---

# The design corpus (.ok-planner/design/)

## Description

The design corpus is ok-planner's central artifact: the project's "durable identity / model — the high-level, general framing of what the project is and what it owes its users," held as three catalogs under `.ok-planner/design/` — `concepts/` (load-bearing nouns), `stories/` (durable user expectations), `decisions/` (technical tradeoffs) — plus the `_discover/` scaffolding directory and three auto-generated TOCs (`concepts.md`, `stories.md`, `decisions.md`). The canonical self-description is `skills/_shared/artifact-definitions.md`, which every authoring/reviewing skill reads: "This file is the single source of truth."

The directory *name* is explicitly declared non-load-bearing: "'Design' here is shorthand ... The directory name is what it is for historical reasons; the bright line is the altitude of its contents, not the literal noun 'design.'" What is NOT in `design/`: "specific designs of interfaces, route shapes, CLI grammars, schema details, implementation diagrams, anything that prescribes how a particular piece of the product looks. Those live in code, in `.ok-planner/sprints/`, and in other project documentation." The `/audit` compliance pass flags altitude violations.

The corpus's standing relative to code: "a source of truth with the same weight as code: they describe the project as it stands. Like code, they change only by applying an approved sprint's corpus deltas — never ad hoc. Read them freely; they are NOT an out-of-context record" (materialized estate CLAUDE.md). The direction of reference is fixed: "code references design, not the other way around" — code carries `@concept:`/`@story:`/`@decision:` annotations at points of enforcement, so "a refactor that moves files around does not invalidate the design; a code path that diverges from a concept's stated boundary is a defect."

Lifecycle: bootstrapped once by `/discover-design` (as-is only); thereafter mutated exclusively by applying sprint corpus deltas; audited by `/audit`. The presence of `design/` itself is a gate — true-up "does **not** create `design/` itself — its presence is the 'design docs exist for this project' gate other skills key on" (the script creates the three buckets only if `design/` already exists). `_retired/` subdirectories under any catalog are terminal historical record, out of audit scope.

## Code surface

- `plugins/ok-planner/skills/_shared/artifact-definitions.md` — the whole schema (339 lines): definitions, templates, self-containment, current-state-only, annotation-integrity, issue format.
- `plugins/ok-planner/scripts/true-up` (the design/-gate logic, lines ~60–70).
- Consumers: discover-design (writes), plan-sprint (drafts deltas), audit (checks), certify (aligns), sketch (skims catalog).
- Live instance: `.ok-planner/design/` in this repo (buckets exist, currently empty — this discovery is populating `_discover/`).

## Prose surface

- `artifact-definitions.md` "What 'design' means in `.ok-planner/design/`"; `scripts/ok-planner-CLAUDE.md` "Durable design docs"; `scripts/ok-planner-cheatsheet.md`; `plugins/ok-planner/CLAUDE.md` "The single source of truth".

## Adjacent topics

- `concept-artifact`, `story-artifact`, `decision-artifact`, `issue-queue`, `sprint`, `catalog-tocs`, `annotation-convention`, `self-containment-rule`, `current-state-only-rule`, `discover-design`, `context-discipline`.

## Observations

- The "design/ is a label" disclaimer is restated in at least four places (artifact-definitions, discover-design, estate CLAUDE.md template, and by implication the cheatsheet) — the project evidently considers the misreading a live hazard.
- The corpus has two mutation authorities in tension by design: sprints (the only sanctioned mutator) and discover-design (which writes catalogs directly, but only on a project with empty durable directories — it "aborts rather than overwrite human-edited durable artifacts").
