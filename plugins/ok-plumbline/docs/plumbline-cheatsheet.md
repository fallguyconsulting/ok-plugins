# Plumbline Cheatsheet

Actionable conventions for this codebase under the Plumbline methodology. The full reference (manifesto and style guide) ships with the Plumbline plugin. Core idea: comprehension is cheap, verification is not — make wrong edits fail mechanically.

## File Organization

- One feature per file, organized by feature not layer
- Tests co-located next to source
- ~500 line file guideline (edit/merge granularity, not readability), ~100 line function guideline
- Max 3 levels of nesting depth (use early returns)

## DRY and Abstraction

- Strict DRY: semantically identical logic lives in ONE place — never copy what must change together
- Shared code must resolve statically: named symbols, enumerable interface implementations, explicit composition — reachable by grep and types
- Forbidden: DI containers, reflection-driven dispatch, convention-based registration, behavior-modifying decorators, base classes / "Manager" abstractions
- Shared code carries a fast contract suite runnable in isolation; multiple implementations of one interface share a conformance suite
- Check speed is a placement criterion: prefer placements covered by fast isolated tests; "only testable end-to-end" is a design smell

## Mechanical Checks

- Every written constraint needs a check that fails on violation: layering → dependency lint, invariant → assertion + test, wire contract → conformance suite, boundary shape → type
- Lint config is authoritative: if prose and lint disagree, lint wins

## Comments

- **Do not write comments.** Default to zero. No prose comments — no narration, no "this does X", no "TODO", no rationale lines. The exemptions below are not invitations; write a comment only when something other than your own judgment requires it. The lint will catch leftovers, but the rule is prevention, not cleanup.
- Load-bearing information — a constraint, an invariant, an intentional choice — belongs in a name, a type, an assertion with a message, or a test. Reaching for a comment is a signal to move the content into code instead.
- **Machine directives** are written only when tooling requires one in that exact spot: license headers (`SPDX-License-Identifier:`, `Copyright`, `Licensed under`, `Dual-licensed`), lint suppressions (`eslint-disable`, `ts-ignore` / `ts-expect-error` / `ts-nocheck`, `noqa`, `pylint:`, `shellcheck`, `nolint`, `biome-`, `prettier-`, `tslint:`, `deno-`), build tags (`go:`), generated-file markers, C-pragmas, shebangs. Never add one as commentary.
- **Configured citation tags** are written only when a separate standard (e.g. ok-planner's design citation convention, declared in the plumbline config's `citations` array) directs you to link this code to a specific design artifact. Never invent a tag, never add one on your own initiative as documentation. Each line is exactly `// @<tag>: <slug>` — no em-dash tail, no continuation prose, no trailing punctuation. Multiple clean lines may stack as one block (e.g. `// @concept: cascade` then `// @story: parker`). Each slug is independently resolved against the configured rule. Plumbline ships zero default citation tags.
- **Documentation comments** are written only in files already carrying the opt-in marker `// @plumbline:allow-docstrings` (or `# @plumbline:allow-docstrings`). Do not add the marker yourself to license writing docstrings — it's set when the file is a public-API surface that needs documentation.
- Everything else is residue. The default action for any other comment — yours or pre-existing — is **delete**.

## Uniformity

- One idiom per job, repo-wide; never introduce a second way to do something
- When improving an idiom, sweep the old one out everywhere in the same change — no coexisting dialects
- Prefer plain over clever; lint-enforce whatever uniformity can be

## Explicit Code

- Explicit parameters over dependency injection
- Explicit registration of routes/handlers/bindings — never path- or name-derived
- Configuration as visible objects, not scattered env lookups

## Types

- Required at boundaries: API inputs/outputs, DB models, feature interfaces, config
- Flexible internally

## Repo-Wide Changes

- Shared-code change: edit the one definition, let compiler + contract suites enumerate blast radius, fix all consumers in the same change
- Idiom change: sweep all instances in the same change, add lint so the old idiom cannot return

## Tooling

The Plumbline plugin ships:

- `plumbline <path>` — the lint binary; runs two checks: `comment-hygiene` (the rule above) and `citation-resolution` (every configured citation's slug must resolve). Exit 0 clean, 2 violations, 1 internal error.
- `/ok-plumbline:true-up` — install or refresh `.claude/rules/plumbline-cheatsheet.md` from the plugin's canonical version.
- `/ok-plumbline:audit` — run the lint over the whole project and group findings into a remediation plan.
- A `PostToolUse` hook auto-runs the lint on every Edit/Write; violations block (exit 2) so the agent sees them and fixes in the same turn.
- Project config lives in `.ok-plumbline/config.json` (optional). The `citations` array adds project-specific structured-tag exemptions (each pairs a tag with a resolution rule); `ignore` adds paths to skip.
