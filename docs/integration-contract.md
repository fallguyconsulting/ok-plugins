# The ok-plugin Integration Contract

Normative. Every plugin in this marketplace integrates into a consumer
project the same way. `ok-doctor` is a pure dispatcher over this contract:
it knows the discovery convention and the verb set below, and nothing else.
A plugin that needs ok-doctor to special-case it has integrated wrong.

## The three layers

Each plugin's presence in a project consists of exactly three layers:

1. **The dot-directory: `.ok-<name>/` at the repo root.** The plugin's
   committed project-side estate: declared configuration (including any
   stack profile), the full corpus, and any materialized support scripts.
   Its existence is the discovery marker — "which ok-plugins does this
   project use?" is a filesystem check, never an inference.
2. **The cheatsheet: one plugin-owned file under `.claude/rules/`.** The
   small, stable, always-in-context rules layer. Wholly owned and
   overwritten by the plugin's affirm; drift is corrected by overwrite,
   never by merge.
3. **The skills.** The plugin's behavior, exposed as verbs with uniform
   semantics across the suite (below).

## The ownership rule

A plugin owns whole files and never edits a file a human also edits. In
particular: no plugin touches `.claude/rules/rules.md` or `CLAUDE.md`.
Humans may reference plugin cheatsheets from their own files; nothing in
the suite depends on it. Anything long-lived a plugin maintains must live
in a file the plugin can deterministically regenerate in full.

## The verb set

Every ok-plugin exposes these lifecycle verbs with these semantics:

- **affirm** — idempotent create-or-refresh of the plugin's estate
  (dot-directory, cheatsheet, materialized scripts). A compliant project
  is a silent no-op. Materialization is driven by the project's committed
  declarations, never re-inferred at use time.
- **doctor** — read-only drift report. Drift is defined as reality
  disagreeing with declaration, on two axes: *project drift* (the repo's
  detected state no longer matches its committed declarations — e.g. a
  stack signal appears that the declared profile lacks) and *version
  drift* (a materialized artifact carries an older plugin version than
  the installed one). Every finding names the remedy — normally
  re-running affirm.
- **audit** — read-only project-compliance report against the plugin's
  rules, where the plugin has rules to check (e.g. ok-standards' lint).

## Version stamps

Every materialized artifact records the version of the plugin that wrote
it, so version drift is mechanically checkable by doctor without content
comparison.

## Stack tailoring (detect → declare → materialize)

Plugins whose discipline varies by project stack (ok-workspaces) follow
this shape: a detection scan *proposes* a stack profile from repo signals
(compose files, `go.mod`, `package.json`, build targets); the committed
profile in the dot-directory is what's *authoritative*; affirm
materializes rules and scripts *from the profile*. Detection never
silently decides — a scan/declaration mismatch is doctor-reported project
drift, remedied by an explicit re-affirm.

## Current conformance

The contract postdates the two shipped plugins; they conform partially
and migrate as they are next reworked:

- `ok-planner` — dot-directory `.ok-planner/` conforms; its rules layer
  currently ships as an output style rather than a `.claude/rules/`
  cheatsheet.
- `ok-standards` — cheatsheet under `.claude/rules/` conforms; its
  project config is `.plumbline.json` at the repo root rather than inside
  a dot-directory, kept for compatibility with existing Plumbline
  estates.
