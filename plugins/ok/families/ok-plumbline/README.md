# Plumbline

**Code that runs true under agentic maintenance.**

Plumbline is a methodology for writing code that AI coding agents can safely maintain in parallel, across model generations, and at scale. It packages as a skill family in the ok-* suite — carried as payload inside the suite's front-door plugin and vendored into any consuming codebase, rules and lint tooling together.

## Install

Plumbline travels inside the `ok` plugin (the ok-* suite's front door) at `families/ok-plumbline/`. Install the front door from the ok-plugins marketplace, then run `/ok` in any project:

```
/plugin marketplace add <ok-plugins repo>
/plugin install ok@ok-plugins
/ok
```

The front door's administration converges the family into the project: it writes `.claude/rules/plumbline-cheatsheet.md` — the rules file every Claude Code session in the project will read (commit it) — vendors the lint binary, the skills, the writing standard (`.ok-plumbline/docs/technical-writing.md`), the steering hook (`.ok-plumbline/hooks/pre-write.js`), the edit hook (`.ok-plumbline/hooks/post-edit.js`), and the review hook (`.ok-plumbline/hooks/stop-review.js`), and, on your consent, wires four entries into `.claude/settings.json` — `PreToolUse` and `PostToolUse` on every tool, `Stop` and `SubagentStop` — on one consent. From then on every agent — the main session and dispatched subagents alike — receives the writing standard before every tool call; `plumbline` runs on every Edit/Write and blocks (exit 2) when violations are found, so the agent fixes them in the same turn; the post hook flags any tool call that wrote prose, a Bash heredoc or commit message included; and before an agent that wrote prose stops, the review hook blocks once and has it review every sentence it wrote against the standard and rewrite what fails. Re-run `/ok` after a plugin upgrade to converge to the latest version.

## Documents

- [docs/plumbline-cheatsheet.md](docs/plumbline-cheatsheet.md) — the complete rule set, materialized into consuming projects on converge.
- [docs/plumbline-porting-guide.md](docs/plumbline-porting-guide.md) — the migration arc for adopting Plumbline on an existing codebase. Phase-by-phase, tool sequencing, decision points, plan template. Consume directly or via `/port` (emits a project-specific plan with backlog numbers filled in).

## The rule on comments

Plumbline's central comment rule is strict: **code is the documentation; comments are not permitted in source files** except three structural exemptions:

1. **Machine directives** — license headers (SPDX, Copyright, Licensed under), lint suppressions (`eslint-disable`, `ts-ignore`, `noqa`, `pylint:`, `nolint`, etc.), build tags (`go:`), generated-file markers, shebangs. The exemption is per line: a directive exempts itself, not the prose written beneath it (a license notice's own boilerplate body is the one continuation allowed).
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
plumbline starter [path]               # generate a starter plumbline config
plumbline diagnose [path]              # read-only converge diagnosis
plumbline explain [<topic>]            # show docs for a check or config concept
```

Each subcommand is also wrapped as a skill vendored into converged projects: `/patterns`, `/budget`, and so on. The lint report is no longer a verb of this family's — the suite's `/audit` ceremony sweeps the lint and reports practice coverage in the same run.

## Subjects and practices

Beside the universal conventions, a project records **what its own codebase
does**: a **subject** names an enumerable population of constructs, and a
**practice** says, affirmatively, what the codebase does about some of that
population — the condition under which it governs and the maintenance
operation it buys. The authoring rules ship to each consumer at
`.ok-plumbline/practice-definitions.md`; the collections live at
`.ok-plumbline/{subjects,practices}/` with generated catalog tables of
contents beside them.

Two rules carry the weight. A departure from a practice cites a **competing
practice**, never a suppression — an exemption marker asserts nothing and so
can never be wrong, while a competing practice is a claim about the site a
reviewer can check (`@decision: affirmative-practices-over-exemptions`). And a
site that departs from the practice governing it is **remediation work**, not
an issue: the owner already ruled when the practice was written, so only gaps,
collisions, and sites whose governing practice cannot be established at the
point of use reach the intake (`@decision: violations-are-remediation-not-issues`).

## Lint, config, and CI

The lint binary is Node.js with no build step, and the front door's administration **vendors it into the project** at `.ok-plumbline/bin/plumbline`, stamped with the suite version that project converged to. That committed copy is what everything uses — the skills, the edit hook, and CI:

```
node .ok-plumbline/bin/plumbline [path]
```

Vendoring is what makes linting reproducible: updating the installed front door does not change what any project lints until its owner converges, an active session is unaffected by edits to the payload itself, and the command above works with no Claude Code installed at all. The family's own copy at `bin/plumbline` is the canonical source converge copies from; it reports version `0.0.0-unvendored`, which is how you can tell you are running it rather than a project's pinned binary.

From a Claude Code session with the consented hook entries wired, the vendored binary runs automatically after every Edit/Write.

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

Both checks always run; the config exposes no switch that disables one. `citations` is the only way to declare project-specific allowed comment forms; each entry must pair a tag with a structural resolution rule. `/starter` produces a project-shaped config (including the ok-planner citation entries above when it detects `.ok-planner/`).

For CI, run `node .ok-plumbline/bin/plumbline .` from the project root and treat any non-zero exit as a failure — no install step, since the binary is committed. `/ci` emits ready-made GitHub Actions, GitLab, and pre-commit configs that do exactly that.

## License

Apache-2.0. The methodology, docs, and tooling are designed for adoption — copy, modify, ship.
