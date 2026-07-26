---
decision: hook-shims
status: as-is
---

# Plugin-root hooks are shims; behavior is materialized project-side

## Choice

Every hook file in a plugin is a shim with one job: resolve the project root, exec the same-named materialized hook inside the plugin's project-side estate, and exit silently when that file is absent. All hook behavior and injected payloads live in the materialized, version-stamped project copies; the shim is the only part that may read the plugin-root path, and it reads nothing but the path it execs.

## Rationale

The harness resolves hook commands against the installed, machine-shared plugin copy, which changes on every update or edit — so nothing a hook actually does may live there. The shim split buys per-project hook versions (a project runs the hooks it was converged to), safe plugin development (editing a plugin cannot disturb another project's session), and discovery-by-filesystem (no estate, silent no-op).

## Alternatives

- Run hook behavior directly from the plugin root — every plugin update instantly changes behavior in every project and session.
- No hooks at all — forfeits session injection and edit-time enforcement.

## Proof

No enforcing check exists today: nothing fails if a plugin-root hook grows behavior or inspects plugin-root content beyond its exec path; the conformance criterion lives in contract prose only. Filed to the intake queue for owner calibration.
