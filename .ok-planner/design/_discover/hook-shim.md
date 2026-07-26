---
topic: hook-shim
kind: discipline
---

# Hooks are shims; behavior is materialized project-side

## Description

A structural rule of the contract: the harness resolves hook commands against `${CLAUDE_PLUGIN_ROOT}`, so hook files must physically live in the installed plugin copy — but that copy is machine-shared and changes on every plugin update or edit, "so **nothing a hook actually does may live there**." Every ok-plugin hook is therefore a shim with one job: "resolve the project root, exec `.ok-<name>/hooks/<hook-name>`, and exit silently when that file is absent." The real hook — and any payload it injects — is materialized project-side by true-up, version-stamped like everything else.

The contract names the three properties as the point: **per-project versions** ("A project runs the hook it was trued up to. Updating the installed plugin changes nothing anywhere until each owner converges deliberately"), **development is safe** ("Editing a plugin cannot disturb a session running in another project"), and **discovery stays a filesystem check** (no estate → silent no-op — the same rule as the rest of the contract). The shim's own limits are stated as a conformance test: "The shim itself is the only part that may read `${CLAUDE_PLUGIN_ROOT}`, and it may read nothing but the path it execs. A hook that inspects plugin-root content, or that carries logic worth versioning, has integrated wrong."

Realizations: ok-planner has two shims (`hooks/session-start` on SessionStart matcher `startup|clear|compact`; `hooks/user-prompt-submit` on UserPromptSubmit) exec'ing `.ok-planner/hooks/<name>`; ok-workspaces has one (`hooks/session-start`, no matcher, timeout 10) exec'ing `.ok-workspaces/hooks/session-start`; ok-plumbline's is a node shim (`hooks/post-edit.js`, PostToolUse matcher `Edit|Write`, timeout 30) spawning `.ok-plumbline/hooks/post-edit.js` with stdin inherited and propagating only exit code 2. The materialized-hook *sources* live under each plugin's `scripts/hooks/` and are stamped during materialization. The `ok` plugin has no hooks at all, by constraint ("No scripts, no hooks, no build").

Two behavioral corollaries elsewhere: nothing in the suite runs true-up (or any converge) from a hook; and `/ok`'s report must tell the user that updated hooks only take effect after `/reload-plugins`.

## Code surface

- Shims: `plugins/ok-planner/hooks/{session-start,user-prompt-submit}`, `plugins/ok-workspaces/hooks/session-start`, `plugins/ok-plumbline/hooks/post-edit.js`; declarations in each plugin's `hooks/hooks.json`.
- Materialized-hook sources: `plugins/ok-planner/scripts/hooks/{session-start,user-prompt-submit}`, `plugins/ok-workspaces/scripts/hooks/session-start`, `plugins/ok-plumbline/scripts/hooks/post-edit.js`.
- Materializers: `plugins/ok-planner/scripts/true-up` (loop over the two hooks), `plugins/ok-workspaces/scripts/true-up.js`, plumbline true-up §4b.
- Live instance: `.ok-planner/hooks/` in this repo (v8.0.0).

## Prose surface

- `docs/integration-contract.md` "Hooks are shims; behavior is project-local"; the shims' own header comments restate the rationale verbatim-ish ("Plugin-root shim — behavior deliberately lives elsewhere").

## Adjacent topics

- `integration-contract`, `version-stamping`, `session-context-injection` (what the materialized hooks do), `plumbline-lint` (the post-edit hook's behavior), `true-up-verb`.

## Observations

- The two bash shims (ok-planner, ok-workspaces) are near-identical files; the plumbline shim reimplements the same logic in node. Same copy-family remark as root resolution.
- ok-planner's hooks.json declares matcher `startup|clear|compact` for SessionStart; ok-workspaces declares no matcher — so workspaces' injection also fires on `resume` while planner's does not. No prose says whether that asymmetry is intended.
- ok-planner CLAUDE.md's Layout section still describes the plugin-root `hooks/session-start` as the injector ("Injects skills/ok-planner/SKILL.md as context; must stay executable"), which predates the shim split.
