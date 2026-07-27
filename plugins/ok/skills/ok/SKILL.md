---
name: ok
description: "ONLY activated by explicit /ok slash command. Never auto-triggered by conversation content. One command that brings the whole ok-* suite current in this project: updates installed suite plugins, discovers integrated ones by their filesystem markers, offers to bootstrap the rest in one consent question, then drives the project's merged true-up verb once."
---

<!-- @story: one-command-suite-upkeep -->

# ok — Suite Front Door

One command that brings the whole ok-* suite current in this project: update the installed suite plugins, discover every ok-plugin the project integrates, offer to bootstrap the installed ones it doesn't yet, and drive the project's merged `true-up` verb — the single lifecycle act that diagnoses and converges the whole integrated set. Every true-up is an idempotent installer: on an empty project it bootstraps the plugin's estate, on an existing one it repairs and converges — so `/ok` never needs to know which case it's in. Pure dispatcher: it knows the integration contract's two conventions — the discovery markers and the uniform lifecycle verb — and **nothing about any plugin's internals**. If driving a plugin ever seems to require a special case, the plugin's integration is wrong, not this skill; report that instead of accommodating it.

Plugin upkeep only. `/ok` never invokes work-driving verbs (`audit`, `prove`, `open`, …) — those belong to humans and implementation orchestrators. And true-up is always a user action: nothing in the suite runs it from a hook.

**The conduct is not this skill's business.** `ok-conduct` is a personal, user-scoped plugin: `/ok` updates it in step 1 if the user already installed it (it is an installed suite plugin like any other), but never installs it, never vendors it, never offers it for bootstrap, and never treats its absence as a finding. The choice is the user's alone, made outside `/ok`.

## Process

### 1. Update installed suite plugins

Bring every *installed* ok-plugin to the marketplace's current version — never install one that is absent (presence of a plugin is the user's choice; presence of an integration is the project's):

```bash
claude plugin list --json   # which ok-plugins are installed, at what version
claude plugin update <name>@ok-plugins   # for each installed ok-plugin, including ok itself
```

Record what moved from which version to which. If anything was updated, note for the final report: hook changes and updated plugin skills take effect after `/reload-plugins` or a session restart — say so. (Vendored skills in the project change only when the owner converges, never here.)

### 2. Discover

Resolve the project root (nearest `.git` ancestor). A plugin `ok-<name>` is integrated iff its discovery markers exist at the root — its current marker (`.ok-<name>/`) **or any pre-migration marker documented in the integration contract** — a filesystem check, never an inference. Pre-migration markers matter here: a project carrying only an earlier layout must still be discovered, or its migration is never offered.

The contract's current-conformance section is the authority on markers. Currently documented pre-migration markers: **ok-plumbline** is integrated iff a root `.plumbline.json` exists or `.claude/rules/plumbline-cheatsheet.md` exists.

### 3. Offer to bootstrap the rest

An installed, integrable ok-plugin with no discovery markers is a **bootstrap candidate** — the user chose the plugin (it's installed) but the project has no estate yet. (`ok` itself and `ok-conduct` are user-scoped, never integrable, never candidates.) If any exist, ask the owner once, in one question, before truing anything up: name the candidates and ask "bootstrap them all?" (all, a subset, or none — their call). Consented candidates join the true-up pass below. Declined candidates are recorded as `not integrated (declined)` — declining is a valid state, not drift, and `/ok` asks again no sooner than its next run.

Never bootstrap silently, and never install a *plugin* here — this step integrates installed plugins into the project, nothing else.

### 4. Drive the merged true-up, once

The project's lifecycle verb is the merged `true-up` skill vendored at `.claude/skills/true-up/SKILL.md`. Invoke it once via the Skill tool (`true-up`); it drives every integrated plugin's own true-up, collects each plugin's `WIRING NEEDED` blocks, presents all hook wiring for the owner's consent in one place, and reports per plugin.

- **Consented bootstrap candidates** have no vendored layer yet, so for each one first invoke the installed plugin's own entry point (`<plugin>:true-up` via the Skill tool) — its converge bootstraps the estate and materializes the merged verb, which then covers it.
- **No merged verb materialized and nothing integrated or consented** — nothing to do; report the project as not using the suite.
- When a true-up stops for owner input (a profile proposal to review, a conflict to resolve, a wiring consent), relay its questions verbatim, collect the owner's answer, and let it finish. A true-up never stops to ask permission to migrate its own retired layout — running `/ok` is that permission.
- Never reinterpret, filter, or re-derive a plugin's findings. Each plugin's true-up is the authority on its own estate.

### 5. Report

```
ok — <project root>

| plugin | installed | vendored in project | outcome |
|---|---|---|---|
| ok-planner | v9.0.0 → v9.1.0 | v9.0.0 | trued up (vendored layer converged to v9.1.0) |
| ok-plumbline | v9.1.0 | v9.1.0 | clean |
| ok-workspaces | v9.1.0 | — | waiting on owner: proposal in conversation |
| ok-example | v9.1.0 | — | bootstrapped (estate created by true-up) |

<the merged true-up's report, verbatim, under its own heading>

<if any plugin was updated in step 1:> Plugin updates take effect after /reload-plugins or a session restart.
```

The **vendored in project** column is the version each plugin's stamp records in the project's vendored layer (the merged true-up's report carries it); `—` where the plugin has no vendored layer here. The gap between installed and vendored is the useful signal, not an error.

## What this skill does NOT do

- Does not know any plugin's file formats, check logic, or estate layout beyond the discovery markers the contract documents.
- Does not run `audit`, `prove`, or any other work-driving verb.
- Does not install a plugin that is not installed — presence of a plugin is the user's choice, made outside `/ok`.
- Does not bootstrap without consent. An installed plugin with no markers is *offered* for bootstrap (step 3), never integrated silently; a decline means "not used here", which is a valid state, not drift.
- Does not install, vendor, or offer the conduct. `ok-conduct` is personal and user-scoped; the only thing `/ok` ever does with it is update an already-installed copy in step 1.
- Does not edit any file itself. All writes happen inside the plugins' own true-up verbs (and hook wiring only through their consented transcription paths).
