# Plumbline

**Code that runs true under agentic maintenance.**

Plumbline is a methodology for writing code that AI coding agents can safely maintain in parallel, across model generations, and at scale. It packages as a Claude Code plugin that installs the project rules into any consuming codebase, with lint tooling to follow.

## Install

This repository is its own single-plugin marketplace (the catalog lives at `.claude-plugin/marketplace.json` under the marketplace name `fallguy`). In Claude Code:

```
/plugin marketplace add fallguyconsulting/plumbline
/plugin install plumbline@fallguy
```

## Quick start

In any project:

```
/ok-plumbline:true-up
```

This writes `.claude/rules/plumbline-cheatsheet.md` into the current project — the rules file every Claude Code session in the project will read. Commit it. Re-run `/ok-plumbline:true-up` after a plugin upgrade to pick up the latest canonical cheatsheet.

True-up also vendors the edit hook into the project (`.ok-plumbline/hooks/post-edit.js`) and, on your consent, wires a `PostToolUse` entry into `.claude/settings.json` pointing at it — from then on `plumbline` runs on every Edit/Write automatically and blocks (exit 2) when violations are found, so the agent sees the message and fixes in the same turn.

## Documents

- [docs/plumbline-manifesto.md](docs/plumbline-manifesto.md) — the philosophy: why agentic maintenance needs different design priorities and the cost model the methodology serves.
- [docs/plumbline-style-guide.md](docs/plumbline-style-guide.md) — the actionable rules: how to write Plumbline code, examples, the comment rule, and a PR checklist.
- [docs/plumbline-cheatsheet.md](docs/plumbline-cheatsheet.md) — the compact form materialized into consuming projects by `/ok-plumbline:true-up`.
- [docs/plumbline-porting-guide.md](docs/plumbline-porting-guide.md) — the migration arc for adopting Plumbline on an existing codebase. Phase-by-phase, tool sequencing, decision points, plan template. Consume directly or via `/ok-plumbline:port` (emits a project-specific plan with backlog numbers filled in).

## The rule on comments

Plumbline's central comment rule is strict: **code is the documentation; comments are not permitted in source files** except three structural exemptions:

1. **Machine directives** — license headers (SPDX, Copyright, Licensed under), lint suppressions (`eslint-disable`, `ts-ignore`, `noqa`, `pylint:`, `nolint`, etc.), build tags (`go:`), generated-file markers, shebangs.
2. **Configured citation tags** — declared in the plumbline config's `citations` array. Each entry pairs a tag with a structural resolution rule (a `file_template` containing `{slug}`, or an `appears_in_glob`). A comment using the tag is allowed only when its slug resolves per the rule. Plumbline ships zero default citation tags; projects declare them.
3. **Documentation comments** — JSDoc/GoDoc adjacent to declarations, only in files carrying the opt-in marker `// @plumbline:allow-docstrings` (or `# ...` for hash-comment languages).

Everything else is residue. The default action for any comment-hygiene violation is **delete**. Load-bearing information — a constraint, a deliberate-choice guard, a named invariant — belongs in code: an assertion with a message, a test whose name carries the rule, a type that enforces the shape. Comments are the wrong layer for any of it.

## Lineage

Plumbline grew out of the Cold Read methodology. Cold Read v1 optimized for AI agents whose binding constraint was comprehension; v2 reweighted around verification. Plumbline v1 took Cold Read v2's content forward under a name that describes the goal — code that runs true. Plumbline v0.2 added the lint binary with a tag-vocabulary comment-hygiene check. v0.4 (this document) replaces the tag vocabulary with the strict no-comments rule and the structural citation-config exemption: experience showed the tag vocabulary was a judgment-call seam that agents reliably routed around. The new rule has only structural exemptions.

## Subcommands

The `plumbline` binary is a multi-tool CLI. The default (no subcommand) is the lint:

```
plumbline                              # lint cwd
plumbline <path>                       # lint a path
plumbline patterns [path]              # cluster violations by shape
plumbline budget save|check [path]     # ratchet baseline
plumbline suggest [path]               # propose per-violation fixes
plumbline slug "<prose>"               # generate a kebab-case slug
plumbline starter [path]               # generate a starter plumbline config
plumbline diagnose [path]              # read-only true-up diagnosis
plumbline explain [<topic>]            # show docs for a check or config concept
plumbline ci github|gitlab|pre-commit  # emit a CI workflow
```

Each subcommand is also wrapped as a Claude Code skill: `/ok-plumbline:patterns`, `/ok-plumbline:budget`, and so on.

## Lint, config, and CI

The lint binary is Node.js with no build step, and `/ok-plumbline:true-up` **vendors it into the project** at `.ok-plumbline/bin/plumbline`, stamped with the version that project converged to. That committed copy is what everything uses — the skills, the edit hook, and CI:

```
node .ok-plumbline/bin/plumbline [path]
```

Vendoring is what makes linting reproducible: updating the installed plugin does not change what any project lints until its owner runs true-up, an active session is unaffected by edits to the plugin itself, and the command above works with no Claude Code installed at all. The plugin's own copy at `bin/plumbline` is the canonical source true-up copies from; it reports version `0.0.0-unvendored`, which is how you can tell you are running it rather than a project's pinned binary.

From a Claude Code session with the consented hook entry wired, the vendored binary runs automatically after every Edit/Write.

Project config lives in `.ok-plumbline/config.json` (optional):

```json
{
  "citations": [
    { "tag": "@concept:",  "file_template": ".ok-planner/design/concepts/{slug}.md" },
    { "tag": "@story:",    "file_template": ".ok-planner/design/stories/{slug}.md" },
    { "tag": "@decision:", "file_template": ".ok-planner/design/decisions/{slug}.md" }
  ],
  "ignore": ["generated/", "test/fixtures/"]
}
```

Both checks always run; the config exposes no switch that disables one. `citations` is the only way to declare project-specific allowed comment forms; each entry must pair a tag with a structural resolution rule. `/ok-plumbline:starter` produces a project-shaped config (including the ok-planner citation entries above when it detects `.ok-planner/`).

For CI, run `node .ok-plumbline/bin/plumbline .` from the project root and treat any non-zero exit as a failure — no install step, since the binary is committed. `/ok-plumbline:ci` emits ready-made GitHub Actions, GitLab, and pre-commit configs that do exactly that.

## License

Apache-2.0. The methodology, docs, and tooling are designed for adoption — copy, modify, ship.
