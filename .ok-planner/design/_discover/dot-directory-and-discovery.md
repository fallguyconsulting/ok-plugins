---
topic: dot-directory-and-discovery
kind: concept
---

# The dot-directory estate and discovery markers

## Description

Every integrable plugin's project-side presence is rooted in one committed directory at the consumer repo root: `.ok-<name>/` (`.ok-planner/`, `.ok-plumbline/`, `.ok-workspaces/`). The contract calls this "the plugin's committed project-side estate: declared configuration (including any stack profile), the full corpus, and any materialized support scripts." Its existence doubles as the **discovery marker**: "'which ok-plugins does this project use?' is a filesystem check, never an inference." `/ok` resolves the project root (nearest `.git` ancestor) and checks for the markers; the hook shims use the same rule to decide whether to no-op ("a project with no `.ok-<name>/` estate gets a silent no-op, which is the same rule the rest of this contract uses").

Discovery also honors **documented pre-migration markers** so that projects on a retired layout are still discovered and offered migration: "a project carrying only a pre-migration estate must still be discovered, or its migration is never offered." The one contract-documented case is ok-plumbline's root `.plumbline.json` (the pre-dot-directory config location); the binary honors that path until true-up migrates it mechanically into `.ok-plumbline/config.json` (contents untouched).

The estates' current shapes: `.ok-planner/` holds `CLAUDE.md` (materialized), `design/`, `issues.jsonl`, `sprints/`, `sketches/`, `history/`, `hooks/`, `context/`; `.ok-plumbline/` holds `config.json`, `bin/plumbline` (vendored), `hooks/post-edit.js`; `.ok-workspaces/` holds `config.json` (the profile), `bin/src-tag`, `worktrees/` (gitignored via the plugin-owned `.ok-workspaces/.gitignore`), `hooks/`, `context/`. The `ok` plugin deliberately has no dot-directory: "`ok` itself materializes no project estate — it has no dot-directory and is never 'integrated'."

Absence of a marker is a meaningful state, not an error: an installed plugin with no markers is a *bootstrap candidate* that `/ok` offers to integrate (one consent question), and a decline is recorded as "not integrated (declined)" — "declining is a valid state, not drift."

## Code surface

- Marker checks: `plugins/ok/skills/ok/SKILL.md` §2 (Discover); hook shims' `resolve_root` + `[ -x "$IMPL" ] || exit 0` pattern in `plugins/ok-planner/hooks/session-start`, `plugins/ok-workspaces/hooks/session-start`, `plugins/ok-plumbline/hooks/post-edit.js`.
- Estate creation: `plugins/ok-planner/scripts/true-up` (mkdir tree, issues.jsonl, CLAUDE.md, hooks, context); `plugins/ok-workspaces/scripts/true-up.js`; `plugins/ok-plumbline/skills/true-up/SKILL.md` §3 (mkdir + `.plumbline.json` migration).
- Pre-migration fallback in the binary: `plugins/ok-plumbline/bin/plumbline` reads `.ok-plumbline/config.json` first, then root `.plumbline.json`.

## Prose surface

- `docs/integration-contract.md` "The three layers" (layer 1) and "Current conformance".
- `plugins/ok/CLAUDE.md` — the `.plumbline.json` exception is "the one pre-migration exception."

## Adjacent topics

- `integration-contract`, `true-up-verb`, `ok-dispatcher`, `hook-shim`, `ok-planner-estate`, `plumbline-config`, `stack-profile`.

## Observations

- `/ok` SKILL.md treats `.claude/rules/plumbline-cheatsheet.md` as a second ok-plumbline discovery marker; the contract documents only root `.plumbline.json`. (Same disagreement noted under `integration-contract`.)
- The plumbline plugin's own directory contains a live root-format `.plumbline.json` (`plugins/ok-plumbline/.plumbline.json`, ignoring `test/fixtures/`) — the plugin self-lints using the layout its own true-up calls retired.
- "Nearest `.git` ancestor" root resolution is implemented independently at least five times (bash twice, node three times) with the same semantics — a copy family with no shared definition (skills are prompt-text, so DRY-by-symbol is impossible; still notable given the suite's own plumbline discipline).
