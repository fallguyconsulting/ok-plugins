---
audit: explain-lint-rules
artifact: story:explain-lint-rules
determination: satisfied
audited: 2026-07-29T12:30:00Z
artifact-hash: sha256:b999e4273651
---

# Every check code the lint can emit has a definition and worked examples reachable from the project's own binary

## Confirmation

Satisfied. A violation line names its rule (`plumbline/<code>`), and
`plumbline explain <code>` — run by the vendored `explain` verb against the
project's own pinned binary — prints that rule's definition, the configuration
that governs it, and worked examples with their fixes. No source reading is
required: the explanations are data in the binary, delivered by the same copy
that produced the violation.

- **Coverage of the rules that can fire.** The emittable codes are the two
  attached to violations (`comment-hygiene`, `citation-unresolved`), listed in
  the binary's own `CHECK_CODES`; both have `EXPLAIN_TOPICS` entries, and the
  topic listing refuses (exit 1) if any check code has no definition. Two
  configuration topics (`citations`, the docstring opt-in marker) are listed
  alongside.
- **Enough to decide code-versus-config.** Each check-code topic states the
  exemptions or resolution rules, the config file and entry shape that govern
  them, and several concrete fixes per example — one changing the code, one
  changing the configuration.
- **Exercised end to end** by the explain proof, which derives the emittable
  codes from the binary's source rather than a hardcoded list and then asserts:
  a real lint run names a code, the project's committed binary explains that
  code, every listed topic is deliverable, every config-file path mentioned in
  any topic is the path the lint actually resolves, every emittable code carries
  a worked example, and each worked example — reconstructed at run time from its
  own text (config entry, source file, file name) — emits the very line the
  example documents and is cleared by the fix the example states.

## Referrals

- referral: whether the explanations are clear and sufficient for a reader who
    does not know the linter
  clause: "I want the canonical definition and examples for the rule that fired"
  delivered: a definition plus worked examples per emittable check code, held in
    the binary's `EXPLAIN_TOPICS` and printed by the `explain` verb — cited below
  discipline: documentation

## Citations

- cite: plugins/ok/families/ok-plumbline/bin/plumbline :: "const CHECK_CODES = [CODE_COMMENT_HYGIENE, CODE_CITATION_UNRESOLVED];"
- cite: plugins/ok/families/ok-plumbline/bin/plumbline :: "const EXPLAIN_TOPICS = {"
- cite: plugins/ok/families/ok-plumbline/bin/plumbline :: "function explainCmd(topic) {"
- cite-node: plugins/ok/families/ok-plumbline/bin/plumbline @ sha256:e38de2cc2e2a
- cite-node: plugins/ok/families/ok-plumbline/skills/explain/SKILL.md#ok-plumbline-explain.run @ sha256:606be8caebdf
- cite-node: plugins/ok/families/ok-plumbline/test/run.sh#run_explain_proof @ sha256:f2024ea1e8f2
- cite-node: plugins/ok/families/ok-plumbline/test/run.sh#topic_listing @ sha256:7ea24c435467
- cite-node: plugins/ok/families/ok-plumbline/test/run.sh#example_reported_line @ sha256:7bc453338206
- cite-node: plugins/ok/families/ok-plumbline/test/run.sh#documented_line_holds @ sha256:bf9136006c4e
