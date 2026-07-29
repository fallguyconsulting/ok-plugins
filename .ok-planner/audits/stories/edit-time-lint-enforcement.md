---
audit: edit-time-lint-enforcement
artifact: story:edit-time-lint-enforcement
determination: satisfied
audited: 2026-07-29T12:30:00Z
artifact-hash: sha256:5db92b4ae72b
---

# Agent edits are checked in-turn against both lint rules, scoped to the lines the edit changed

## Confirmation

Satisfied. The capability is delivered by two materialized artifacts in an
adopted project's estate — the edit hook at `.ok-plumbline/hooks/post-edit.js`
and the pinned binary at `.ok-plumbline/bin/plumbline` — reached from a
`PostToolUse` settings entry whose matcher is `Edit|Write`, transcribed by the
family's `wire-hooks` path and verified by `diagnose`.

- **Every agent edit, at the moment it lands.** The hook is a `PostToolUse`
  command entry over `Edit|Write`; it reads the tool event, takes
  `tool_input.file_path`, resolves the repository root, refuses paths outside
  it, and runs the vendored binary on that file. Files it checks are those the
  binary has a grammar for — the extension table plus shebang resolution for
  extensionless scripts (enumerated from the binary, pinned whole below).
- **Against the comment *and* citation rules.** The hook invokes the binary's
  ordinary lint entry, and a lint pass runs both checks over the target:
  comment hygiene per file, then citation resolution across the files walked.
- **Blocking in the same turn.** A violation exits 2 with the report written on
  the agent-visible channel, carrying `file:line: plumbline/<code>: <message>`.
- **Only in the lines it changed.** For a tracked file the hook derives changed
  ranges from `git diff -U0 HEAD` and passes `--lines`; the binary filters
  violations to those ranges. A tracked file with no changed ranges exits 0
  without running the lint. An untracked file is checked whole.
- **Exercised end to end** by the plumbline harness: the hook harness drives the
  materialized hook with synthetic tool events over a real git sandbox (a
  violation on an untouched line passes, a violation on a changed line blocks
  with exit 2, an untracked file is checked whole); the message proof asserts
  the block carries file, line, rule code and message on the channel the agent
  receives, that a clean edit passes while an older violation stands elsewhere
  in the same file, and that an extensionless script is checked by its shebang;
  the module-marker fidelity case converges an estate, runs `wire-hooks`, and
  requires `diagnose` — which fails unless the `PostToolUse` entry exists with
  matcher `Edit|Write` — to report healthy; and the fixture table exercises both
  check codes firing and the clean cases passing.

## Citations

- cite-node: plugins/ok/families/ok-plumbline/scripts/hooks/post-edit.js#main @ sha256:c037279fc8a1
- cite-node: plugins/ok/families/ok-plumbline/scripts/hooks/post-edit.js#getChangedLineRanges @ sha256:88946b571a1a
- cite-node: plugins/ok/families/ok-plumbline/scripts/hooks/post-edit.js#blockWithViolationsOnAgentVisibleChannel @ sha256:566ada8a982f
- cite-node: plugins/ok/families/ok-plumbline/bin/plumbline @ sha256:e38de2cc2e2a
- cite-node: plugins/ok/families/ok-plumbline/bin/plumbline#runLint @ sha256:c4fd8a6c4b80
- cite-node: plugins/ok/families/ok-plumbline/bin/plumbline#lintCmd @ sha256:675a1be4712b
- cite-node: plugins/ok/families/ok-plumbline/bin/plumbline#wireHooksCmd @ sha256:9b21c67330ff
- cite-node: plugins/ok/families/ok-plumbline/bin/plumbline#wiringFindings @ sha256:6a643ac3d593
- cite: plugins/ok/families/ok-plumbline/bin/plumbline :: "  matcher: 'Edit|Write',"
- cite: plugins/ok/families/ok-plumbline/bin/plumbline :: "const HOOK_MARKER = '.ok-plumbline/hooks/post-edit.js';"
- cite-node: plugins/ok/families/ok-plumbline/test/run.sh#run_hook_harness @ sha256:a182154ede75
- cite-node: plugins/ok/families/ok-plumbline/test/run.sh#invoke_hook @ sha256:1a2818ecedfd
- cite-node: plugins/ok/families/ok-plumbline/test/run.sh#run_message_proof @ sha256:0b1756d4b8ff
- cite-node: plugins/ok/families/ok-plumbline/test/run.sh#run_module_marker_fidelity_case @ sha256:9322d9d15982
- cite-span: plugins/ok/families/ok-plumbline/test/run.sh :: "run_case "clean (legacy root config)"  "$fixtures/clean"                       0 """ +15 sha256:66464ca07bfc
