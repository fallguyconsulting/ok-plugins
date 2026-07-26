---
decision: hook-shims
---

# Plugin-root hooks are shims; behavior is materialized project-side

## Choice

Every hook file in a plugin is a shim with one job: resolve the project root, exec the same-named materialized hook inside the plugin's project-side estate, and exit silently when that file is absent. All hook behavior and injected payloads live in the materialized, version-stamped project copies; the shim is the only part that may read the plugin-root path, and it reads nothing but the path it execs. Session-start injection fires on session startup, clear, and compact — never on resume, where the session already holds its earlier injection — uniformly across plugins.

## Rationale

The harness resolves hook commands against the installed, machine-shared plugin copy, which changes on every update or edit — so nothing a hook actually does may live there. The shim split buys per-project hook versions (a project runs the hooks it was converged to), safe plugin development (editing a plugin cannot disturb another project's session), and discovery-by-filesystem (no estate, silent no-op). Excluding resume avoids re-injecting content a resumed session already carries.

## Alternatives

- Run hook behavior directly from the plugin root — every plugin update instantly changes behavior in every project and session.
- Fire session injection on every session source including resume — duplicates the briefing into sessions that already hold it.
- No hooks at all — forfeits session injection and edit-time enforcement.

## Proof

Conformance check: every plugin-root hook file matches the canonical shim shape — root resolution, hand-off to the same-named materialized hook, silent exit when absent, nothing else — and every session-start hook declaration carries the shared startup-clear-compact matcher. Falsifier: a shim that grows behavior beyond the hand-off, or a session-start declaration that drops or widens the matcher, turns the check red.
