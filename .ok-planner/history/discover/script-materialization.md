---
topic: script-materialization
kind: discipline
---

# Support-script materialization and vendoring

## Description

Contract rule: "A plugin that gives a project executable machinery owns the canonical script and **materializes** it project-side — every script, not just the leaf utilities: lint binaries, hook implementations, and diagnostic tools all count, and the only thing that legitimately runs from the plugin copy is the true-up entry point itself, because it is what creates the project copy." Default home is `.ok-<name>/bin/<script>`; a profile may declare another path so existing consumers keep working (ok-workspaces' `srcTag.path`). Materialized scripts are plugin-owned whole files — version-stamped, executable, overwritten wholesale, never hand-edited — and diagnose checks each is **byte-identical** to the canonical version for the installed plugin.

The fullest realization is ok-plumbline's **vendoring**: true-up copies `bin/plumbline` (1225-line node CLI) to `.ok-plumbline/bin/plumbline` with the VERSION constant stamped, then *proves it executes* (`node .ok-plumbline/bin/plumbline version` — "A vendored binary that cannot run is worse than none — the hook would silently skip"). Everything downstream prefers the vendored copy: the edit hook resolves the binary relative to itself under `.ok-plumbline/`; the audit/budget/patterns/suggest/explain/version skills all begin `bin=".ok-plumbline/bin/plumbline"; [ -x "$bin" ] || bin="${CLAUDE_PLUGIN_ROOT%/}/bin/plumbline"` with a per-skill comment justifying the preference ("an audit must report what THIS project was trued up to"; "a baseline is only comparable against the version that produced it"; CI "lints at the project's pinned version with no plugin installed"). Two skills deliberately invert the preference as **bootstrap verbs**: `starter` and `port` run the plugin's copy because "this runs before the project has an estate — there is nothing vendored yet, and a stale vendored binary from an earlier true-up would propose against the wrong rules"; true-up's `diagnose` likewise runs the plugin copy since "its job is to compare the project against the version being installed."

ok-workspaces materializes `src-tag` (POSIX sh, byte-identity-checked by diagnose against the version-substituted canonical). ok-planner materializes no `bin/` scripts but materializes hooks and the context payload; its `surface-corpus` helper is invoked from the *plugin* root by `/plan-sprint` (`python3 "${CLAUDE_PLUGIN_ROOT%/}/scripts/surface-corpus"`), not materialized.

## Code surface

- `docs/integration-contract.md` "Support scripts".
- `plugins/ok-plumbline/skills/true-up/SKILL.md` §4b; skill preludes in `skills/{audit,budget,ci,explain,patterns,suggest,version}/SKILL.md`; bootstrap exceptions in `skills/{starter,port}/SKILL.md`.
- `plugins/ok-workspaces/scripts/true-up.js` (src-tag write), `scripts/diagnose.js` (byte-identity check).
- Counterexample: `plugins/ok-planner/skills/plan-sprint/SKILL.md` §4 issue walk (surface-corpus run from `${CLAUDE_PLUGIN_ROOT}`).

## Prose surface

- `plugins/ok-plumbline/README.md` "Lint, config, and CI" — the vendoring rationale ("Vendoring is what makes linting reproducible ...").

## Adjacent topics

- `true-up-verb`, `version-stamping`, `hook-shim`, `plumbline-lint`, `src-tag`, `plan-sprint-ceremony` (the surface-corpus exception).

## Observations

- `surface-corpus` appears to sit outside the contract's own rule: it is executable machinery a skill runs from the plugin copy at use time, and it is neither materialized project-side nor the true-up entry point. Whether it counts as "gives a project executable machinery" (it runs against the project's corpus during a ceremony) is arguable; the contract's "every script, not just the leaf utilities" phrasing suggests it does.
- The vendored-binary fallback (`[ -x "$bin" ] || bin=plugin copy`) means several "prefer vendored" skills silently run the un-vendored plugin copy on an unintegrated project, printing only a stderr note — a soft edge on an otherwise strict pinning discipline.
