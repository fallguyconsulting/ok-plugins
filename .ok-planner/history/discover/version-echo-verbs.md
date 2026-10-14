---
topic: version-echo-verbs
kind: concept
---

# Version-echo verbs (/ok-version, /ok-plumbline:version)

## Description

Two plugins ship a read-only verb whose whole job is to recite version numbers, each shaped around the plugin's pinning model.

ok-planner's `/ok-version` reports what **this session** is running, deliberately without reading disk: the plugin version comes from the SessionStart hook's injected banner line (`ok-planner vX.Y.Z (conduct ...) is available` — report `unknown` if absent), and the conduct version comes from the live output style's `Conduct version:` line ("the conduct **actually governing the session**, which is why it comes from the output style rather than the session-start line"; report `unstamped` if absent). "No disk read, no comparison, no verdict — if a version is not what you expect, investigate from there (e.g. `/reload-plugins` then `/clear`, or a fresh session)." Exactly two output lines, then stop; never chains.

ok-plumbline's `/version` echoes the **project's vendored** binary's version alongside the installed plugin's: "They differ whenever the plugin has moved ahead of the project's last true-up, and that gap is the useful signal: the project keeps linting at its pinned version until the owner converges deliberately." The plugin's own copy reporting `0.0.0-unvendored` is expected and documented.

The two verbs encode the same idea — the version that matters is the one governing *your* context (session or project), not what is installed — from the two plugins' different delivery models (context injection vs vendored executable). ok-workspaces has no version verb; its version visibility is diagnose.js's stamp checks.

## Code surface

- `plugins/ok-planner/skills/ok-version/SKILL.md`; the banner produced by `plugins/ok-planner/scripts/hooks/session-start`; the `Conduct version:` line in `output-styles/ok-conduct.md` (which the CLAUDE.md says "must stay in the body ... and keep its prefix (the session-start hook and `/ok-version` grep it)").
- `plugins/ok-plumbline/skills/version/SKILL.md`; the vendored-version probe in `bin/plumbline` (`version` subcommand; reads the vendored copy's VERSION line).

## Prose surface

- `plugins/ok-planner/CLAUDE.md` Versioning section; materialized session-start hook header ("/ok-version reports the live session's numbers; a disagreement between the two is exactly the drift /true-up exists to converge").

## Adjacent topics

- `version-stamping`, `suite-versioning`, `ok-conduct`, `script-materialization`.

## Observations

- `/ok-version` expects the banner text "is available" while the current hook template emits "is materialized in this project" — the grep-anchor prose in the skill and the emitted line have drifted in wording (the version-bearing prefix `ok-planner vX.Y.Z (conduct ...)` still matches).
- The ok-planner index-skill row for ok-version matches the skill; one of the few fully in-sync table rows.
