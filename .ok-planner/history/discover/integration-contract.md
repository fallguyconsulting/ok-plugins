---
topic: integration-contract
kind: schema
---

# The ok-plugin integration contract

## Description

`docs/integration-contract.md` is the suite's normative spine: "Every plugin in this marketplace integrates into a consumer project the same way. The `ok` plugin is a pure dispatcher over this contract ... A plugin that needs `ok` to special-case it has integrated wrong." The `ok` plugin's existence is described as "the mechanical check on this contract" — if `/ok` cannot drive a plugin through the contract's two conventions (discovery markers + the uniform true-up verb), the plugin is wrong, not `/ok`.

The contract defines **three layers** of a plugin's presence in a consumer project: (1) the dot-directory `.ok-<name>/` at the repo root — the committed project-side estate (declared config, corpus, materialized support scripts), whose existence is the discovery marker; (2) the cheatsheet — one plugin-owned file under `.claude/rules/`, the "small, stable, always-in-context rules layer," overwritten (never merged) by true-up; (3) the skills — the plugin's behavior as verbs with uniform semantics.

It then defines: the **ownership rule** (plugins own whole files, never edit human-edited files, never touch `.claude/rules/rules.md` or `CLAUDE.md`; ownership decides what true-up may do silently vs by consent); the **verb set** (every plugin exposes `true-up`; plugins with rules also expose `audit`; the diagnose phase stays available standalone as a script/CLI with a drift exit code for CI — "that layer is implementation, not a skill"); **version stamps** (every materialized artifact records the writing plugin's version so drift is mechanically checkable "without content comparison"); **support scripts** (canonical copy in the plugin, materialized project-side at `.ok-<name>/bin/<script>` or a profile-declared path, byte-identical-checked; "the only thing that legitimately runs from the plugin copy is the true-up entry point itself"); **hooks are shims** (see `hook-shim`); **stack tailoring** (detect → declare → materialize, see `stack-profile`); **the ok plugin** (see `ok-dispatcher`); and a **current conformance** section asserting all three integrable plugins are "fully conformant" and documenting ok-plumbline's pre-migration marker (root `.plumbline.json`).

The contract is explicitly the thing new plugins must conform to: the README says "New plugins must conform; the `ok` plugin depends on it."

## Code surface

- `docs/integration-contract.md` — the whole contract (186 lines).
- Realizations: `plugins/ok-planner/scripts/true-up` + `skills/true-up/SKILL.md`; `plugins/ok-workspaces/scripts/{detect,diagnose,true-up}.js` + `skills/true-up/SKILL.md`; `plugins/ok-plumbline/skills/true-up/SKILL.md` + `bin/plumbline diagnose`; `plugins/ok/skills/ok/SKILL.md` (the dispatcher over it).
- Standalone diagnose layers named by the contract: `plugins/ok-workspaces/scripts/diagnose.js` (exit 2 on drift), `plumbline diagnose`.

## Prose surface

- `README.md` Layout section — the contract's normative status.
- `plugins/ok/CLAUDE.md` — "It is deliberately dumb — it knows the contract's two conventions ... and nothing about any plugin's internals."
- Each true-up SKILL.md restates the contract's phases in plugin-specific form.

## Adjacent topics

- `dot-directory-and-discovery`, `cheatsheet-rules-layer`, `ownership-and-consent`, `true-up-verb`, `version-stamping`, `script-materialization`, `hook-shim`, `stack-profile`, `ok-dispatcher`.

## Observations

- The contract's "current conformance" section documents exactly one pre-migration marker for ok-plumbline (root `.plumbline.json`), but `/ok`'s SKILL.md discovery step adds a second: "**ok-plumbline** is integrated iff `.plumbline.json` exists at the root **or** `.claude/rules/plumbline-cheatsheet.md` exists." The dispatcher knows a marker the contract does not document, which is precisely the kind of per-plugin knowledge the contract forbids the dispatcher to carry undocumented.
- The verb set is stated as "one lifecycle verb, plus a compliance verb where it has rules to check," but ok-planner also exposes `prove` (named in the contract's conformance line as "true-up / audit / prove") — a third verb the verb-set section itself never defines.
- The contract's hook-shim section and the support-scripts section overlap: materialized hooks are version-stamped artifacts under the dot-directory (`.ok-<name>/hooks/`), yet the support-scripts default-home text names only `.ok-<name>/bin/<script>`.
- ok-planner's conformance line says "cheatsheet at `.claude/rules/ok-planner-cheatsheet.md` (materialized by true-up)" — realized by `scripts/true-up` writing it; consistent.
