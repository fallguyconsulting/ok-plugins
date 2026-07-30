---
audit: code-cites-design
artifact: decision:code-cites-design
determination: satisfied
audited: 2026-07-30T00:31:21Z
artifact-hash: sha256:2478a5f439ea
---

# Reference runs one way: code annotates design, design bodies stay self-contained

## Confirmation

Satisfied. The choice is a corpus rule, realized in the rule prose the
project's sessions and reviewers run on and in the state of the corpus and
the code themselves.

- **Corpus bodies are self-contained.** Enumerated from the three catalogs
  pinned below — 26 concepts, 18 stories, 26 decisions — no artifact body
  carries a file path, a file extension, a symbol citation or quoted code.
  Every slash-bearing token in the bodies is prose
  (`mechanical/judgment`, `scan/declaration`, `pass/fail`); the only
  backticked literals anywhere in the 70 bodies are the determination
  values `satisfied`/`violated` and the frontmatter key form
  `closed: <sha of the archive commit>`, all design-owned identities the
  artifacts commit to rather than citations of code.
- **Slugs and invariant IDs the only sanctioned citation forms.** Stated as
  the corpus's self-containment rule in the canonical shared definitions,
  which names the permitted forms and excludes code-referent tags from
  artifact bodies. The compliance reviewer the audit and planning
  ceremonies dispatch checks that rule directly.
- **Code carries kind-plus-slug annotations at load-bearing sites.** A
  repo-wide grep for `@concept:`/`@story:`/`@decision:` outside the
  records and the generated graph finds 147 annotation lines over 47
  distinct kind-plus-slug pairs, spread across all three families' cores,
  scripts, hooks, checks and test suites plus this repo's own materialized
  copies under `.claude/skills/`, `.ok-planner/bin/` and
  `.ok-planner/hooks/`. Thirty-nine of the 47 pairs resolve to a live
  artifact file. The eight that do not are every one of them not an
  annotation site: `@concept:cascade`, `@story:parker` and
  `@concept:claim-holder-guard` are `ok-plumbline`'s own documentation
  examples of citation-comment syntax, `@concept:foo` and
  `@concept:missing` are that family's resolved/unresolved citation-lint
  fixtures and the shared definitions' kind-mismatch illustration, and
  `@decision:annotation`, `@story:annotations` and `@story:for` are prose
  sentences that happen to place a word after the tag syntax. So the grep
  does stand in for an index, and there is no second index in the
  repository mapping artifacts to sites.
- **Rollout is incremental, no bulk pass.** Stated as a per-session
  obligation in the estate's own rules — leave the annotation at the
  most-specific load-bearing site when you consult an artifact, repoint or
  remove one whose slug no longer exists — and as the whole-corpus
  mechanical check the `/audit` verb runs, where a dangling or
  kind-mismatched annotation is a mechanical finding the caller fixes
  in-cycle.

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
- cite: plugins/ok/families/ok-planner/scripts/browse :: "# @story: trace-corpus-to-code"
- cite: plugins/ok/families/ok-planner/scripts/browse :: "# @decision: local-web-surface"
- cite: plugins/ok/test/administration.sh :: "# @decision: per-project-pinning"
- cite: .claude/skills/ok-planner-audit/SKILL.md :: "### Annotation integrity (mechanical)"
