# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Plugin purpose

`ok-conduct` carries the Fall Guy Consulting code of conduct as an output style (`output-styles/ok-conduct.md`) plus two direct plugin hooks: a `SessionStart` announcement of the installed conduct version and a per-turn `UserPromptSubmit` reminder that re-anchors the conduct's delivery rules against attentional decay.

The plugin is **user-scoped by design**: a user installs it for themselves, machine-global, and that is correct — the conduct is a personal delivery discipline, not project infrastructure. It is therefore never vendored into a project, never a dependency of any other suite plugin (installing `ok` does not install it), never pinned by a project's committed configuration, and it has no estate, no cheatsheet, no true-up, and no integration under the suite's integration contract. The hooks run directly from the plugin root — the shim/materialization discipline exists to pin project-scoped behavior per project, which this plugin deliberately has none of.

## Versioning

Two **independent** version numbers:

- **Plugin version** — semver in `.claude-plugin/plugin.json`, kept in lockstep with the suite by the repo-root `/release` skill. Claude Code's update key; never hand-edit, never bump alone.
- **Conduct version** — `Conduct version: X.Y.Z (Animal)` as the first body line of `output-styles/ok-conduct.md`; hand-managed, bumped (advancing the animal one letter) only when the conduct body changes. The stamp must stay in the body (frontmatter is stripped from the system prompt) and keep its prefix — the session-start hook and `/ok-version` read it from there. `/release` warns when the body changed without a bump; it never edits the stamp.

## Constraints

- Nothing activates the conduct automatically and no skill may depend on it being active.
- No skills, no estate paths, no project-side writes. If this plugin ever seems to need one, the content in question is project-scoped and belongs elsewhere in the suite.
