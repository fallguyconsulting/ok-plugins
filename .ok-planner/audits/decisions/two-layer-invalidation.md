---
audit: two-layer-invalidation
artifact: decision:two-layer-invalidation
determination: satisfied
audited: 2026-07-29T18:40:00Z
artifact-hash: sha256:815e44ede79c
---

# Are re-audit triggers citation staleness plus judged change inspection, with annotations playing no part?

## Confirmation

Satisfied. Both layers exist over the same committed source graph, the
judgment layer's completeness is mechanically enforced, and nothing in
either layer reads a code annotation.

- **Mechanical layer.** `check_audit` invalidates an audit outright when
  its design artifact's hash moved, when a cited `cite-node:` identity no
  longer resolves in the committed graph, when a cited node's recorded
  hash moved, or when an anchor, span, or file pin no longer matches. The
  stale set is printed by `--list-stale`.
- **Pure moves re-point rather than invalidate.** `repoint_corpus`
  rewrites a `cite-node:` line whose identity vanished while its recorded
  hash matches exactly one node in the fresh graph, and leaves the
  citation stale when zero or several nodes match — ambiguity is never
  resolved mechanically. The gates run it after the graph rebuild and
  before taking the stale set.
- **Judgment layer.** The change inspector reads the diff under
  certification — working tree or commit range — against the graph and
  the audit corpus, nominates the audits whose claimed territory contains
  changed code no citation caught, records nominations as provisional
  entries in the committed inspection registry, and never invalidates:
  the auditor adjudicates. The gate's re-audit set is stated as the union
  of the stale set and the nominations.
- **The judgment layer's completeness is itself mechanical.**
  `check_inspection` computes the changed node set from the current graph
  against the graph at the baseline ref — at unit granularity where a
  file declares units, plus the file node whenever the region outside
  every declared unit moved — and fails with `inspection-unclassified`
  for any changed node that is neither mechanically accounted (a citation
  in its file or on a containing identity went stale) nor covered by a
  live registry entry; a missing registry with changed nodes is
  `inspection-missing`. A skipped judgment pass therefore fails instead of
  passing vacuously.
- **Annotations play no part in either layer.** The checker parses only
  citations, graph rows, and registry entries — there is no annotation
  reading anywhere in it — and the change-scoped gate states outright
  that code annotations play no part in its touched-set derivation or in
  any invalidation.

The code half is exercised end to end by the checker harness: node
identity unresolved, node content moved, stale and missing graphs, the
`--list-stale` set, repoint of a pure move and refusal on an ambiguous
one, and the inspection floor across a clean tree, a missing registry, an
unclassified node, a new file's units versus its module-level region, a
lapsed pin, a mechanically-accounted change needing no entry, a pure
in-unit edit, a combined unit-and-outside change, and a range-scoped run
against its base ref. Adjudicated entries are exercised as their own
disposition class: an entry built from a real `cite-node` identity closes
the floor, one naming no live audit is malformed and disposes of nothing,
and `mechanical` — the disposition the checker recomputes — is rejected
as a stored class. The story-level suite runs the same floor through the
project's own vendored checker against a seeded repository.

## Citations

- cite: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "The two-layer re-audit trigger, stated once for both gates."
- cite-node: plugins/ok/families/ok-planner/skills/_shared/certification-core.md#certification-core.how-consumers-use-this-file.change-inspector-prompt @ sha256:e1cca8db580a
- cite-node: plugins/ok/families/ok-planner/skills/certify-work/SKILL.md#certify-the-work-the-change-scoped-gate.process @ sha256:5fa3fe424650
- cite: plugins/ok/families/ok-planner/skills/certify-work/SKILL.md :: "Code annotations play no part in this derivation or in any invalidation below"
- cite-node: plugins/ok/families/ok-planner/scripts/audit-check @ sha256:352974d68855
- cite: plugins/ok/families/ok-planner/scripts/audit-check :: "def check_audit(root, path, live, findings, stale_refs,"
- cite: plugins/ok/families/ok-planner/scripts/audit-check :: "def repoint_corpus(root):"
- cite: plugins/ok/families/ok-planner/scripts/audit-check :: "def check_inspection(root, findings, stale_files, stale_identities,"
- cite-node: plugins/ok/families/ok-planner/test/run.sh @ sha256:388eb5e51cf3
- cite: plugins/ok/families/ok-planner/test/run.sh :: "repointed src/app.js#go -> src/core.js#go"
- cite: plugins/ok/families/ok-planner/test/run.sh :: "inspection: missing registry"
- cite: plugins/ok/families/ok-planner/test/run.sh :: "run_case "inspection: adjudicated entries close the floor as residue does""
- cite: plugins/ok/families/ok-planner/test/run.sh :: "the range-scoped floor sees the committed change"
- cite-node: plugins/ok/families/ok-planner/test/stories.sh @ sha256:16ddb66851bc
- cite: plugins/ok/families/ok-planner/test/stories.sh :: "certify-completion: a skipped judgment pass fails the gate's clean bar mechanically instead of reading clean"
