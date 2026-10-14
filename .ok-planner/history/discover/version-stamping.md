---
topic: version-stamping
kind: discipline
---

# Version stamping of materialized artifacts

## Description

Contract rule: "Every materialized artifact records the version of the plugin that wrote it, so version drift is mechanically checkable by true-up's diagnose phase without content comparison." The mechanism is a placeholder in the canonical/template copy, substituted at materialization time: `{{OK_PLANNER_VERSION}}` (ok-planner templates and hook sources, sed-stamped by `scripts/true-up`), `{{OK_WORKSPACES_VERSION}}` (src-tag script and hook, stamped by `true-up.js`'s `stamp()`), `{{OK_PLUMBLINE_VERSION}}` (the post-edit hook), and plumbline's binary variant — `const VERSION = '0.0.0-unvendored';` rewritten to the plugin version during vendoring, with the placeholder value doubling as a provenance signal ("seeing it means you are running the plugin's own copy rather than a project's pinned one").

Stamps carry a human-readable prefix in prose artifacts: "Materialized by ok-planner v8.0.0. Plugin-owned: overwritten wholesale by `/true-up`; do not hand-edit." The stamp is what diagnose greps: ok-workspaces' `diagnose.js` regexes `Materialized by ok-workspaces v([0-9a-zA-Z.\-]+)` out of the cheatsheet and compares to the installed version; ok-planner's session-start line `ok-planner vX.Y.Z (conduct ...)` is what `/ok-version` reads back. ok-planner's hooks also stamp the **conduct version** (`{{OK_CONDUCT_VERSION}}`, read from the output style's `Conduct version:` line at materialization time), so a project's injected banner reports both numbers the project was trued up to.

The stamp's semantics are per-project pinning: "The versions below are stamped at materialization time: they describe what THIS project is running, not what is installed on the machine. /ok-version reports the live session's numbers; a disagreement between the two is exactly the drift /true-up exists to converge" (materialized session-start hook header).

## Code surface

- `plugins/ok-planner/scripts/true-up` lines stamping `{{OK_PLANNER_VERSION}}` / `{{OK_CONDUCT_VERSION}}` into CLAUDE.md, cheatsheet, and both hooks.
- `plugins/ok-workspaces/scripts/true-up.js` (`stamp()`), `scripts/diagnose.js` (stamp regex; src-tag byte comparison against version-substituted canonical).
- `plugins/ok-plumbline/skills/true-up/SKILL.md` §4b (sed on `const VERSION`), `bin/plumbline` line 12 and the vendored-copy version probe around line 1098.
- Materialized instances in this repo: `.ok-planner/CLAUDE.md`, `.claude/rules/ok-planner-cheatsheet.md`, `.ok-planner/hooks/*` — all v8.0.0.

## Prose surface

- `docs/integration-contract.md` "Version stamps"; header comments of every materialized artifact template.

## Adjacent topics

- `true-up-verb`, `script-materialization`, `hook-shim`, `suite-versioning`, `version-echo-verbs`, `ok-conduct` (the second version number).

## Observations

- The contract says drift is checkable "without content comparison," but two of the suite's checks are content comparisons: ok-workspaces' src-tag check is byte-identity against the stamped canonical, and plumbline's cheatsheet check is `cmp -s` (its cheatsheet has no stamp at all). Stamp-based checking is fully realized only for the ok-workspaces cheatsheet and the ok-planner artifacts.
- The plumbline vendored binary's stamp lives in a JS constant rather than a "Materialized by" line; the file's own header comment is the machine-directive-exempt SPDX line — the stamping convention has three concrete shapes (prose line, template placeholder, code constant).
