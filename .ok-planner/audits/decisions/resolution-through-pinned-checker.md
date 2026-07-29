---
audit: resolution-through-pinned-checker
artifact: decision:resolution-through-pinned-checker
determination: satisfied
audited: 2026-07-29T13:57:39Z
artifact-hash: sha256:665e3d02bd25
---

# The corpus view resolves citations by calling the project's own checker

## Confirmation

Satisfied.

- **The project's own copy is what answers.** `load_tooling` imports
  `.ok-planner/bin/audit-check` and `.ok-planner/bin/source-graph` as modules
  whenever the project carries them, falling back to the front door's payload
  only when it does not — and announcing which. Both branches are driven for
  real: a fixture carrying no estate tooling gets the announced fallback, and
  a converged-shaped fixture whose vendored copies are stamped with a version
  the payload cannot be carrying gets the pinned branch, asserted from
  outside on the service's own announcement and on `/api/meta`
  (`source: pinned`, `path: .ok-planner/bin/audit-check`, and the estate's
  stamped version answering).
- **Every citation form goes through it.** The population is the forms the
  checker defines — `cite`, `cite-span`, `cite-file`, `cite-node` (the four
  `CITE_*` regexes pinned below), and `resolve_citation` dispatches on those
  regexes rather than on patterns of its own. All four are resolved in the
  suites: a multi-hit plain anchor, a span, a whole-file pin, and a node
  citation resolved through the committed graph to the declared unit's own
  lines.
- **No second implementation of the arithmetic.** Anchor location comes from
  `locate_anchor`, release-metadata masking from `mask_release_metadata` and
  `masked_file_hash`, span hashing from `span_hash`, node lookup from
  `load_graph`, and declared-unit spans from the project's own `source-graph`
  extractor; the serving program (pinned whole below) implements none of
  them itself.
- **The verdicts are the checker's verdicts.** Both directions of staleness
  are asserted against the checker's own findings on the same tree: a broken
  anchor citation reads stale in the view exactly as the payload checker
  reports it, and a moved node reads stale exactly as the project's own
  pinned checker reports it — each asked of a long-lived process after the
  tree moved under it.

## Citations

- cite-node: plugins/ok/families/ok-planner/scripts/corpus-view @ sha256:0904adb8b491
- cite: plugins/ok/families/ok-planner/scripts/corpus-view :: "def load_tooling(root):"
- cite: plugins/ok/families/ok-planner/scripts/corpus-view :: "def resolve_citation(self, raw):"
- cite: plugins/ok/families/ok-planner/scripts/corpus-view :: "hits = self.checker.locate_anchor(lines, masked)"
- cite: plugins/ok/families/ok-planner/scripts/corpus-view :: "lines = self.checker.mask_release_metadata(raw, rel).splitlines()"
- cite: plugins/ok/families/ok-planner/scripts/corpus-view :: "actual = self.checker.span_hash(lines[start:start + count])"
- cite: plugins/ok/families/ok-planner/scripts/corpus-view :: "actual = self.checker.masked_file_hash(full, target)"
- cite: plugins/ok/families/ok-planner/scripts/corpus-view :: "def _resolve_node(self, identity, pinned):"
- cite-node: plugins/ok/families/ok-planner/scripts/audit-check @ sha256:352974d68855
- cite: plugins/ok/families/ok-planner/scripts/audit-check :: "CITE_LINE = re.compile"
- cite: plugins/ok/families/ok-planner/scripts/audit-check :: "CITE_SPAN_LINE = re.compile"
- cite: plugins/ok/families/ok-planner/scripts/audit-check :: "CITE_FILE_LINE = re.compile"
- cite: plugins/ok/families/ok-planner/scripts/audit-check :: "CITE_NODE_LINE = re.compile"
- cite-node: plugins/ok/families/ok-planner/test/stories.sh @ sha256:16ddb66851bc
- cite: plugins/ok/families/ok-planner/test/stories.sh :: "resolution-through-pinned-checker: the service names the project's own materialized checker as the resolver"
- cite: plugins/ok/families/ok-planner/test/stories.sh :: "resolution-through-pinned-checker: the reported provenance is the project's copy, at the version the estate is stamped with"
- cite: plugins/ok/families/ok-planner/test/stories.sh :: "resolution-through-pinned-checker: a cite-node resolves through the committed graph to the declared unit's own lines"
- cite: plugins/ok/families/ok-planner/test/stories.sh :: "resolution-through-pinned-checker: a moved node reads stale in the view exactly as the project's own checker reports it"
- cite: plugins/ok/families/ok-planner/test/stories.sh :: "trace-corpus-to-code: a broken citation reads stale in the view exactly as the project's own checker reports it"
- cite: plugins/ok/families/ok-planner/test/stories.sh :: "trace-corpus-to-code: opening a story excerpts the code its audit cites"
- cite: plugins/ok/families/ok-planner/test/stories.sh :: "trace-corpus-to-code: the file shows the claiming story, an unclaimed region, and the whole-file claim as file-level"
- cite: plugins/ok/families/ok-planner/test/stories.sh :: "trace-corpus-to-code: every occurrence a multi-hit anchor reaches is claimed"
- cite: plugins/ok/families/ok-planner/test/stories.sh :: "per-project-pinning: an advisory verb reading the payload's copy announces the fallback verbatim"
