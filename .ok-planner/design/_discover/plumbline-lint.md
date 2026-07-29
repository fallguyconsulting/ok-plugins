---
topic: plumbline-lint
kind: concept
---

# The plumbline lint binary, its skills, and the edit hook

## Description

`bin/plumbline` is a single-file Node CLI (1225 lines, no build step, no dependencies) that is the methodology's mechanical check. The default invocation is the lint over a path; exit codes are contractual: "Exit 0 clean, 2 violations, 1 internal error." Two checks: **comment-hygiene** (per-extension comment grammars — line/block markers, string and regex-literal awareness — with a machine-directive pattern table for the exemptions and the `@plumbline:allow-docstrings` opt-in for doc comments) and **citation-resolution** (every configured citation tag's slug must resolve per its structural rule; violation code `plumbline/citation-unresolved`). Subcommands: `patterns` (cluster violations by shape: `divider`, `license-fragment`, `todo-marker`, `commented-out-code`, `doc-residue`, `disallowed-prose`, and `tag:@...` clusters), `budget save|check` (the ratchet: baseline in `.plumbline-budget.json`; "CI fails any change that increases the count, accepts any that holds or decreases it" — one-way), `suggest` (heuristic per-violation fixes routing load-bearing comments to assertion/test/type/name, default delete), `slug` (deterministic kebab-case slug from prose), `starter` (project-shaped config proposal), `diagnose` (read-only true-up diagnosis), `explain` (topic docs), `ci github|gitlab|pre-commit` (workflow emission), `version`.

Each subcommand is wrapped as a skill (`/ok-plumbline:<name>`), and every wrapper embeds the vendored-binary preference prelude (see `script-materialization`). The wrappers are read-only proposers by doctrine: audit "proposes fixes; does not apply them"; patterns "Do not apply bulk deletions without confirming the cluster shape"; suggest "Never bulk-apply suggestions; each one is a draft proposal."

The **PostToolUse edit hook** closes the loop in-session: declared on matcher `Edit|Write` (timeout 30), the plugin-root shim hands off to the materialized `.ok-plumbline/hooks/post-edit.js`, which lints the edited file with the project's vendored binary and **blocks on violations** (exit 2 propagated) "so the agent sees the message and fixes in the same turn." The materialized hook is scoped to the *change*: for tracked files it computes changed line ranges from `git diff -U0 HEAD` and passes `--lines <ranges>` (exiting 0 when the diff is empty), so pre-existing violations elsewhere in a file don't block an unrelated edit; untracked files are linted whole. All failure paths (no JSON on stdin, no repo root, no vendored binary, spawn error) exit 0 — the hook never breaks a session, it only ever blocks on genuine lint findings.

Testing: `test/run.sh` runs the binary over 12 fixtures (clean, license-header, machine-directives, docstring opt-in/not, citation file/glob resolved/unresolved, regex literals, comment-after-regex, disallowed-comment) asserting exit codes and output substrings — the only automated test suite in the suite.

## Code surface

- `plugins/ok-plumbline/bin/plumbline` (VERSION constant line 12; MACHINE_DIRECTIVE_PATTERNS; COMMENT_GRAMMARS per extension).
- `plugins/ok-plumbline/hooks/hooks.json`, `hooks/post-edit.js` (shim), `scripts/hooks/post-edit.js` (materialized hook with `getChangedLineRanges`).
- `plugins/ok-plumbline/skills/{audit,patterns,budget,suggest,slug,starter,ci,explain,version,port}/SKILL.md` (wrappers).
- `plugins/ok-plumbline/test/run.sh` + `test/fixtures/`.

## Prose surface

- `plugins/ok-plumbline/README.md` "Subcommands" and "Lint, config, and CI"; cheatsheet "Tooling" section; `docs/plumbline-porting-guide.md` (the adoption arc `/port` consumes).

## Adjacent topics

- `plumbline-methodology`, `plumbline-config`, `script-materialization` (vendoring), `hook-shim`, `annotation-convention` (citation-resolution as the lint-side integrity check).

## Observations

- Violation identifiers appear in two spellings across prose: check names `comment_hygiene` / `citation_resolution` (config keys), output codes `plumbline/comment-hygiene` / `plumbline/citation-unresolved` (grep targets in skills), and the audit skill's category names "comment-hygiene" / "citation-unresolved" — consistent per layer, but three surface forms for two checks.
- The budget baseline lives at repo root (`.plumbline-budget.json`), outside the dot-directory that the contract says holds the estate — predating the dot-directory layer, like root `.plumbline.json`, but with no documented migration.
