---
topic: self-containment-rule
kind: invariant
---

# The self-containment rule (artifact bodies cite no code paths)

## Description

`{{SELF-CONTAINMENT-RULE}}`: "Concept, story, and decision bodies are self-contained. The design owns the definition; code references it via `@concept:`, `@story:`, and `@decision:` annotations. A refactor that moves files around does not invalidate an artifact, and an external doc that moves to another repo does not orphan one. Citations in artifact body are restricted to forms that survive the codebase moving."

**Allowed** in bodies: other artifact slugs across catalogs (`see also: claim-handle`, `decision:persistence`) and codebase invariant IDs ("the ID is stable across file moves; the file path is not"). **Disallowed**: file or directory paths in any form; citation forms like `code:foo.go::Symbol`, `pkg:...`, bare URLs; references to external documentation (docs/, READMEs, CHANGELOG, sibling repos); quoted code, quoted lint-config allowlists, quoted external prose ("If a property matters, state it as a property of the artifact; the code is responsible for enforcing it"); "Owns / Does NOT own" sections naming code paths.

The rule extends to **frontmatter**: a `references:` field listing `_discover/` paths, spec paths, or sketch paths "is the same durability problem the rule exists to prevent ... Once an artifact is baked, the lineage that produced it lives in the `_discover/` scaffolding (as history) and in the git history of the artifact file itself; the artifact body and frontmatter carry no lineage. Frontmatter is restricted to slug-form metadata only" (`concept:`/`story:`/`decision:`, `status:`, `aliases:`). A path-form `references:` from an earlier-version run is stripped on sight.

Two altitude-specific riders: the **concept tightening** (no implementation enumeration — see `concept-artifact`) and the **decision exemption** (Choice may name the picked artifact — see `decision-artifact`). The escape valve: "If an artifact feels like it can't say what it needs to without naming a file, that's either (a) a hint that the artifact's boundary is muddier than the current text claims — file an issue — or (b) material that belongs in the `_discover/` scaffolding (Code surface section), not in the artifact body." `_discover/` itself is exempt by design ("phase 1 scaffolding is allowed to cite code paths freely"), as is `_retired/` and the issue queue.

The same durability logic governs issue-queue `candidates`: they "must be stated as durable corpus mutations (which artifact's sections change, and how), never as file/symbol citations — a candidate becomes sprint text and lives forward in time" (while issue `detail` MAY quote point-in-time evidence, expected to rot).

## Code surface

- `artifact-definitions.md` `{{SELF-CONTAINMENT-RULE}}` (canonical); transcluded into the shared compliance reviewer, discover-design phase-2 extractor/reviewer, and back-edge extractor prompts.
- Enforcement: compliance reviewer scope/out-of-scope lists (`_discover/`, `_retired/`, `issues.jsonl` exempt); TOC one-liners held to the same rule ("no paths, no external-doc refs").

## Prose surface

- Anti-padding lists in artifact-definitions and discover-design ("Don't introduce code-path citations into concept, story, or decision bodies").

## Adjacent topics

- `concept-artifact`, `decision-artifact`, `current-state-only-rule` (the twin bright-line rule), `annotation-convention` (the sanctioned direction of reference), `issue-queue` (candidates rule), `catalog-tocs`.

## Observations

- The frontmatter paragraph reads as a patch responding to a specific prior failure ("if a `discover-design` or earlier-version run wrote one, strip it") — evidence an earlier skill version emitted `references:` frontmatter.
- The rule's list of disallowed citation forms names schemes (`pkg:github.com/...`) that belong to a Go-flavored consumer world, not this repo — the rule text is written for arbitrary consumer projects.
