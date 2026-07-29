---
audit: code-cites-design
artifact: decision:code-cites-design
determination: satisfied
audited: 2026-07-29T00:00:00Z
artifact-hash: sha256:2478a5f439ea
---

# Reference runs one way: code annotates design, design bodies stay self-contained

## Confirmation

Satisfied. The choice is a corpus rule, realized in the rule prose the
project's sessions and reviewers run on and in the state of the corpus and
the code themselves.

- **Corpus bodies are self-contained.** Enumerated from the three catalogs
  pinned below — 26 concepts, 18 stories, 26 decisions — no artifact body
  carries a file path, a symbol citation or quoted code. Every slash-bearing
  token in the bodies is prose (`mechanical/judgment`,
  `scan/declaration`); the only backticked literals are the determination
  values `satisfied`/`violated` and the frontmatter key form
  `closed: <sha ...>`, both design-owned identities the artifacts commit to
  rather than citations of code.
- **Slugs and invariant IDs the only sanctioned citation forms.** Stated as
  the corpus's self-containment rule in the canonical shared definitions,
  which names the permitted forms and excludes code-referent tags from
  artifact bodies. The compliance reviewer the audit and planning ceremonies
  dispatch checks that rule directly.
- **Code carries kind-plus-slug annotations at load-bearing sites.** The
  repository carries 138 annotation lines over 43 distinct kind-plus-slug
  pairs. Every pair used as a real annotation resolves to a live artifact
  file: the seven non-resolving pairs are all documentation examples,
  fixture payloads for another family's citation lint, or prose mentions of
  the tag syntax, not annotation sites. So the grep does stand in for an
  index — there is no second index in the repository mapping artifacts to
  sites.
- **Rollout is incremental, no bulk pass.** Stated as a per-session
  obligation in the estate's own rules — leave the annotation at the
  most-specific load-bearing site when you consult an artifact, repoint or
  remove one whose slug no longer exists.

## Citations

- cite-file: .ok-planner/design/concepts.md @ sha256:9da9adb06ffb
- cite-file: .ok-planner/design/stories.md @ sha256:adedb2cd4431
- cite-file: .ok-planner/design/decisions.md @ sha256:cc2cb179a06d
- cite-node: plugins/ok/families/ok-planner/skills/_shared/artifact-definitions.md#shared-artifact-definitions.token-catalog.self-containment-rule @ sha256:58d881fc5fe4
- cite-node: plugins/ok/families/ok-planner/skills/_shared/artifact-definitions.md#shared-artifact-definitions.token-catalog.annotation-integrity-rule @ sha256:911689c4591a
- cite: plugins/ok/families/ok-planner/skills/_shared/artifact-definitions.md :: "Concept, story, and decision bodies are self-contained."
- cite: plugins/ok/families/ok-planner/skills/_shared/design-doc-compliance-reviewer.md :: "self-containment rule — no paths, no external-doc refs."
- cite: .ok-planner/CLAUDE.md :: "**Leave the annotation.**"
- cite: plugins/ok/families/ok-planner/scripts/corpus-view :: "# @decision: resolution-through-pinned-checker"
- cite: plugins/ok/families/ok-planner/scripts/audit-check :: "# @decision: two-layer-invalidation"
- cite: plugins/ok/families/ok-planner/skills/browse/SKILL.md :: "<!-- @story: trace-corpus-to-code -->"
- cite: .claude/skills/ok-planner-audit/SKILL.md :: "### Annotation integrity (mechanical)"
