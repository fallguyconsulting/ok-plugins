# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Plugin purpose

`ok-web` carries web-project setup as idempotent converge skills:

- `/setup-web` (`skills/setup-web/SKILL.md`) — the project's agent-facing
  web tooling; today the `chrome-devtools-mcp` browser server merged into
  the project's `.mcp.json`, and the intake point for future web MCPs and
  utilities under the same merge-never-clobber discipline.
- `/setup-dom-picker` (`skills/setup-dom-picker/SKILL.md`) — the dev-only
  DOM picker (human-to-agent pointing channel) converged into every web
  frontend found in the project, against the contract in that skill;
  the framework-agnostic reference implementation travels beside it at
  `skills/setup-dom-picker/reference/dom-picker.ts`.

The plugin is **user-scoped and setup-only**: a user installs it for
themselves, and its skill's entire output is configuration written into the
target project (committed there, owned there). Nothing is vendored — no
estate, no cheatsheet, no true-up, no integration under the suite's
integration contract, and `/ok` neither installs nor administers it. The
configuration it writes is inert without the skill: once `.mcp.json` is in a
project, every collaborator gets the tools with or without this plugin.

## Boundaries

- `/setup-web` never deletes or rewrites anything it did not write in the
  same run: existing `.mcp.json` entries are merged around, conflicting
  entries are surfaced and left standing, and superseded browser kits are
  flagged for the owner, never removed.
- `/setup-dom-picker` touches only the picker module, its one dev-gated
  import line, and the project's rules note — and never leaves a
  production-reachable picker behind.
- Setup only — neither skill ever drives the tooling it configures.

## Versioning

Plugin version — semver in `.claude-plugin/plugin.json`, kept in lockstep
with the suite by the repo-root `/release` skill. Claude Code's update key;
never hand-edit, never bump alone.
