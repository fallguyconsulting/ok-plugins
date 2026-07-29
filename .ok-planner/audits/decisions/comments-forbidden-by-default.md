---
audit: comments-forbidden-by-default
artifact: decision:comments-forbidden-by-default
determination: satisfied
audited: 2026-07-29T12:30:00Z
artifact-hash: sha256:77fd23bd8cc5
---

# Comments are a violation by default, with exactly three structural exemptions and no shipped citation tags

## Confirmation

Satisfied. The comment-hygiene check reports every comment it extracts as a
violation unless the comment takes one of exactly three exemptions — the
branches are enumerable from the check itself, and there are three:

- **Machine directives** — the comment's first significant line must match the
  directive pattern table, and every following line must be a directive too
  (or, under a license-header opener, a license continuation line). Exercised
  by the `license-header` fixture (Go SPDX + copyright header) and the
  `machine-directives` fixture (shell shebang and `shellcheck`; Python SPDX,
  copyright, `noqa`, `type: ignore`; TypeScript `eslint-disable-next-line` and
  `@ts-ignore`), all expected clean.
- **Project-declared citation tags, slug-only and structurally resolving** — a
  comment block every line of which is `@<tag>: <kebab-slug>` and nothing else;
  the resolution check then requires each slug to resolve, by `file_template`
  path existence or by word-boundary presence in a file matching
  `appears_in_glob`. Exercised in both modes and both directions by the
  `citation-file-resolved` / `citation-file-unresolved` and
  `citation-glob-resolved` / `citation-glob-unresolved` fixtures.
- **Documentation comments in an opt-in file** — only when the file carries the
  `@plumbline:allow-docstrings` marker, and only for doc comments adjacent to a
  declaration. Exercised in both directions by the `docstring-opted-in` and
  `docstring-not-opted-in` fixtures.

Everything else is a violation: the `disallowed-comment` fixture (a prose
comment above a Go function) is expected to exit 2 with
`plumbline/comment-hygiene`, and a citation-shaped line that is not slug-only
gets the citation-specific message.

**Zero shipped citation tags.** Config loading collects citation entries only
from the project's own config file; the defaults it merges are ignore paths
only. Exercised in the explain proof's preference case: with an empty project
config, `# @ghost: absent` fires `comment-hygiene` and never
`citation-unresolved` — an undeclared tag is read as prose, so no tag is
exempt by default.

**Residue's default action is delete, including in code you didn't write** — a
prose commitment of the methodology, carried in the manifesto and the style
guide, not a machine behavior: the lint reports and never edits.

## Citations

- cite-node: plugins/ok/families/ok-plumbline/bin/plumbline#checkCommentHygiene @ sha256:6fcc9779aea7
- cite-node: plugins/ok/families/ok-plumbline/bin/plumbline#machineDirectiveViolation @ sha256:ac87465e16d7
- cite-node: plugins/ok/families/ok-plumbline/bin/plumbline#isPureCitationBlock @ sha256:03e7dc591ae4
- cite-node: plugins/ok/families/ok-plumbline/bin/plumbline#hasDocstringOptIn @ sha256:6c6103f649b3
- cite-node: plugins/ok/families/ok-plumbline/bin/plumbline#isJsDocStyle @ sha256:1351a6422310
- cite-node: plugins/ok/families/ok-plumbline/bin/plumbline#isGoDocStyle @ sha256:760dad42eb7e
- cite-node: plugins/ok/families/ok-plumbline/bin/plumbline#loadConfig @ sha256:02b57f5037c6
- cite-node: plugins/ok/families/ok-plumbline/bin/plumbline#validateCitation @ sha256:d1c9723bf686
- cite: plugins/ok/families/ok-plumbline/bin/plumbline :: "function checkCitationResolution(repoRoot, files, citations, ignorePatterns) {"
- cite-node: plugins/ok/families/ok-plumbline/bin/plumbline @ sha256:e38de2cc2e2a
- cite-span: plugins/ok/families/ok-plumbline/test/run.sh :: "run_case "clean (legacy root config)"  "$fixtures/clean"                       0 """ +15 sha256:66464ca07bfc
- cite-node: plugins/ok/families/ok-plumbline/test/run.sh#run_explain_proof @ sha256:f2024ea1e8f2
- cite: plugins/ok/families/ok-plumbline/docs/plumbline-manifesto.md :: "- **Everything else is residue.** The default action is delete, including in code you didn't write — it will be regenerated as precedent otherwise."
