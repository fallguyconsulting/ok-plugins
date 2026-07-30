---
audit: deterministic-source-graph
artifact: story:deterministic-source-graph
determination: satisfied
audited: 2026-07-29T18:40:00Z
artifact-hash: sha256:77a07a2b777d
---

# The project's sources are mapped into a committed graph that rebuilds identically and reports its own drift

## Confirmation

Satisfied. The extractor at `scripts/source-graph` writes one `.graph`
mirror per source file into `.ok-planner/graph/`; this repository carries
that graph committed, and `source-graph check` over the repository
reports no drift.

- **Mapped into a committed graph.** `graph_for` emits a file node plus
  one node per declared unit, each with a structural identity and a
  content hash, and `walk_sources` sources the file set from git (tracked
  plus untracked non-ignored) with the estate, `.git`, `node_modules`,
  symlinks and `.DS_Store` excluded. The suite builds a graph from a
  fixture tree and asserts the mirrors appear.
- **Regenerates identically from the same tree.** The graph body is a
  pure function of a file's bytes and the walked file set — node and ref
  rows are sorted before emission — so two builds over an unchanged tree
  byte-compare identical, which the suite asserts by hashing the
  concatenated mirrors across consecutive builds. The git-sourced walk is
  what makes that hold across checkouts rather than only within one
  working copy: the suite asserts a gitignored file stays out of the
  graph while its tracked neighbour is graphed, and that the non-git
  fallback walk still graphs every file.
- **Declared spans survive text the language does not read as code.**
  `blank_js_noise` blanks comment, string, template-literal and
  regular-expression content before brace counting, tracking template
  substitutions as code and deciding regex-versus-division from the
  preceding significant character or identifier — an identifier ended by
  whitespace as well as by punctuation, and a reserved word reached
  through `.` treated as a property name rather than a keyword. The suite
  holds this on four fixtures where naive scanning fails: shell heredoc
  bodies carrying unbalanced braces (both the quoted and the
  tab-stripping form); a javascript regex literal whose class carries
  `/*` beside a multi-line template literal whose body declares a
  `function`; divisions that follow a postfix `++` and a keyword-named
  property (`LIMITS.in / 2`); and regex literals reached across a space
  through the infix operators `of`, `in` and `instanceof`. Each asserts
  the file's node set is exactly its real functions — siblings, not
  nested — that an edit past the hazards moves exactly the containing
  unit's hash and no other, and that editing template prose moves the
  file node alone and declares nothing new.
- **Flags its own drift.** `check` regenerates in memory and reports
  `graph-missing`, `graph-stale` and `graph-orphaned`, exiting 2. The
  suite asserts a non-zero exit after an in-unit edit and after appending
  garbage to a committed mirror, and asserts movement is confined to the
  edited unit while an unrelated file's recorded hashes stand.
- **What a change invalidates is computed from recorded structure.**
  `audit-check` resolves `cite-node` citations only through the committed
  graph — refusing to judge through a missing or tree-divergent graph,
  each its own finding — and its `--inspection` floor derives the changed
  node set by comparing current graph rows against the rows at the
  baseline ref. The checker suite exercises this end to end: a clean node
  citation, a moved node hash, a renamed declaration that no longer
  resolves, stale and missing graphs, a release stamp bump moving no
  pinned hash, the machine-readable re-audit set, and the inspection
  floor's mechanical account.

## Citations

- cite-node: plugins/ok/families/ok-planner/scripts/source-graph @ sha256:db0409f030c9
- cite: plugins/ok/families/ok-planner/scripts/source-graph :: "def graph_for(root, rel, fileset):"
- cite: plugins/ok/families/ok-planner/scripts/source-graph :: "def walk_sources(root):"
- cite: plugins/ok/families/ok-planner/scripts/source-graph :: "def git_listed_files(root):"
- cite: plugins/ok/families/ok-planner/scripts/source-graph :: "def blank_js_noise(lines):"
- cite: plugins/ok/families/ok-planner/scripts/source-graph :: "def check(root):"
- cite-node: plugins/ok/families/ok-planner/scripts/audit-check @ sha256:352974d68855
- cite: plugins/ok/families/ok-planner/scripts/audit-check :: "def load_graph(root, source_rel):"
- cite: plugins/ok/families/ok-planner/scripts/audit-check :: "def check_inspection(root, findings, stale_files, stale_identities,"
- cite-node: plugins/ok/families/ok-planner/test/stories.sh @ sha256:f8717649820e
- cite: plugins/ok/families/ok-planner/test/stories.sh :: "deterministic-source-graph: two builds on an unchanged tree byte-compare identical"
- cite: plugins/ok/families/ok-planner/test/stories.sh :: "deterministic-source-graph: the checker reports drift after an in-unit edit and exits non-zero"
- cite: plugins/ok/families/ok-planner/test/stories.sh :: "deterministic-source-graph: a corrupted committed graph makes the checker exit non-zero"
- cite: plugins/ok/families/ok-planner/test/stories.sh :: "deterministic-source-graph: the edited unit's hash moved and no other node's did"
- cite: plugins/ok/families/ok-planner/test/stories.sh :: "deterministic-source-graph: an edit after a heredoc but inside the function moves that node's hash"
- cite: plugins/ok/families/ok-planner/test/stories.sh :: "deterministic-source-graph: a regex literal carrying /* and a template literal carrying a declaration leave exactly the file's two real functions declared"
- cite: plugins/ok/families/ok-planner/test/stories.sh :: "deterministic-source-graph: division after a postfix ++ and after a keyword-named property leaves three sibling functions, not a nest"
- cite: plugins/ok/families/ok-planner/test/stories.sh :: "deterministic-source-graph: a regex reached across a space through in/of/instanceof leaves every later function declared, siblings not nested"
- cite: plugins/ok/families/ok-planner/test/stories.sh :: "deterministic-source-graph: an edit past the infix-keyword regex lands inside the function that contains it"
- cite: plugins/ok/families/ok-planner/test/stories.sh :: "deterministic-source-graph: a gitignored local file stays out of the graph while its tracked neighbour is graphed"
- cite: plugins/ok/families/ok-planner/test/stories.sh :: "deterministic-source-graph: with no git present the fallback walk still graphs every file"
- cite-node: plugins/ok/families/ok-planner/test/run.sh @ sha256:388eb5e51cf3
- cite: plugins/ok/families/ok-planner/test/run.sh :: "run_case "node citation clean""
- cite: plugins/ok/families/ok-planner/test/run.sh :: "run_case "renamed node unresolves""
- cite: plugins/ok/families/ok-planner/test/run.sh :: "run_case "stale graph is a finding""
- cite: plugins/ok/families/ok-planner/test/run.sh :: "run_case "missing graph is a finding""
- cite: plugins/ok/families/ok-planner/test/run.sh :: "run_case "node stamp bump masked""
- cite: plugins/ok/families/ok-planner/test/run.sh :: "run_case "re-audit set""
- cite: plugins/ok/families/ok-planner/test/run.sh :: "run_case "inspection: mechanical account""
