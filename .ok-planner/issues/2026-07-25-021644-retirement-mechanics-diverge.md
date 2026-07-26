---
issue: retirement-mechanics-diverge
kind: discover
category: inconsistent
artifacts:
  - concept:corpus-delta
  - concept:catalog-toc
status: verified
opened: 2026-07-25T02:16:44Z
---

# Two coexisting retirement mechanics: delete vs move to a retired area

## Problem

Sprint retire deltas imply deletion from the live catalog, while reviewer and TOC prose speak of retired subdirectories and a Retired section ('skip _retired/', 'Retired-only entries belong in the Retired section'); no text reconciles the two mechanics.

## Candidates

- Amend concept:corpus-delta Invariants to define retirement as exactly one mechanic
- Amend concept:catalog-toc to drop or define the Retired-section convention consistently with the chosen mechanic

## Discussion

The question: when a sprint retires a concept, story, or decision, does the artifact leave the live corpus by deletion, or by being moved into a `_retired/` subdirectory (with a corresponding "Retired" section in its catalog TOC)?

Where it comes from: filed against concept:corpus-delta and concept:catalog-toc. Re-verified against current code: `plugins/ok-planner/skills/plan-sprint/SKILL.md` line 63 templates a retirement delta as "### Retire decision: <slug>", and lines 66 and 101 both describe applying it as the implementer copying "final form into place (or deletes, for retirements)" — the file is deleted outright. Independently, `plugins/ok-planner/skills/_shared/design-doc-compliance-reviewer.md` treats a `_retired/` subdirectory as real and populated: it excludes `.ok-planner/design/concepts/_retired/` from audit scope as "terminal state, historical record" (lines 69-70), checks that "Every TOC bullet's slug matches a live artifact file in the matching directory. (Retired-only entries belong in the 'Retired' section, not the live list.)" (lines 112-114), and flags cross-references to "a retired-only target" as violations (lines 124-126). `plugins/ok-planner/skills/audit/SKILL.md` also instructs skipping `_retired/` when reading the live catalogs (lines 92, 141). These are two live, still-current mechanics in the same plugin: one skill deletes on retirement, another skill's checks presuppose retired artifacts are moved and still present under `_retired/`.

What the corpus says: concept:corpus-delta's What-it-is states a delta is "under an operation heading declaring it new, an amendment, or a retirement. Applying a delta IS updating the corpus: the implementer copies the final form into place, or removes the artifact for a retirement" — matching the plan-sprint delete mechanic, and saying nothing about a `_retired/` directory. Its Invariants add "Retirement via delta is the only sanctioned way an artifact leaves the live corpus" but don't describe the mechanical shape of that departure beyond "removes." concept:catalog-toc's own body never mentions a Retired section or `_retired/` at all — its Invariants are generated-only, self-containment, and alphabetical-plus-summary. Neither cited concept resolves the disagreement; catalog-toc is simply silent on retired-artifact handling, and corpus-delta's "removes" wording, taken literally, contradicts the reviewer prompts' `_retired/` scope carve-out and Retired-section check.

What the code does today: plan-sprint deletes retired artifacts outright (no `_retired/` move, no archival body kept in `design/`); the two compliance-reviewer prompts and the audit skill's own read step behave as if a `_retired/` subdirectory and a "Retired" TOC section are the real, current mechanic, and check for them.

Candidates as filed: amend concept:corpus-delta's Invariants to define retirement as exactly one mechanic; amend concept:catalog-toc to drop or define the Retired-section convention consistently with the chosen mechanic. Two concretely distinct resolution shapes sit under those headings: (a) retirement means deletion — corpus-delta's current wording stands, and every `_retired/`-aware line in the reviewer prompts, audit skill, and TOC-generation step is dead conditional logic to remove; (b) retirement means archival — the delta mechanic changes from delete to move-into-`_retired/`, catalog-toc gains an explicit Retired-section shape, and the TOC generator (currently silent on this — see toc-retired-section-shape) needs to actually emit one.

What the ruling must decide: whether an artifact retirement deletes the file (matching plan-sprint's current delta mechanic) or archives it under `_retired/` with a Retired TOC section (matching the reviewer/audit prompts' current checks) — the two mechanics cannot both be the live one.

This issue and toc-retired-section-shape share the same underlying `_retired/`/Retired-section question; a ruling here likely settles both, though toc-retired-section-shape's own Discussion is written to stand alone.

## Ruling

<!-- Owner: write your decision here in your own words.
The next /plan-sprint picks it up. Leave empty to discuss
it live in a planning session instead. -->
