---
name: ok
description: "ONLY activated by explicit /ok slash command. Never auto-triggered by conversation content."
---

# ok — Suite Front Door

One command that brings the whole ok-* suite current in this project: update the installed suite plugins, discover every ok-plugin the project integrates, offer to bootstrap the installed ones it doesn't yet, and drive each one's `true-up` verb — the plugin's own diagnose → consent → converge cycle. Every true-up is an idempotent installer: on an empty project it bootstraps the plugin's estate, on an existing one it repairs and converges — so `/ok` never needs to know which case it's in. Pure dispatcher: it knows the integration contract's two conventions — the discovery markers and the uniform verb (`true-up`) — and **nothing about any plugin's internals**. If driving a plugin ever seems to require a special case, the plugin's integration is wrong, not this skill; report that instead of accommodating it.

Plugin upkeep only. `/ok` never invokes work-driving verbs (`audit`, `prove`, `open`, …) — those belong to humans and implementation orchestrators. And true-up is always a user action: nothing in the suite runs it from a hook.

## Process

### 1. Update installed suite plugins

Bring every *installed* ok-plugin to the marketplace's current version — never install one that is absent (presence of a plugin is the user's choice; presence of an integration is the project's):

```bash
claude plugin list --json   # which ok-plugins are installed, at what version
claude plugin update <name>@ok-plugins   # for each installed ok-plugin, including ok itself
```

Record what moved from which version to which. If anything was updated, note for the final report: updated skills are live in this session, but **hooks only take effect after the user runs `/reload-plugins`** — say so.

### 2. Discover

Resolve the project root (nearest `.git` ancestor). A plugin `ok-<name>` is integrated iff its discovery markers exist at the root — its current marker (`.ok-<name>/`) **or any pre-migration marker documented in the integration contract** — a filesystem check, never an inference. Pre-migration markers matter here: a project carrying only an earlier layout must still be discovered, or its migration is never offered.

Currently documented pre-migration markers (from the contract's current-conformance section): **ok-plumbline** is integrated iff `.plumbline.json` exists at the root or `.claude/rules/plumbline-cheatsheet.md` exists.

### 3. Offer to bootstrap the rest

An installed ok-plugin with no discovery markers is a **bootstrap candidate** — the user chose the plugin (it's installed) but the project has no estate yet. If any exist, ask the owner once, in one question, before truing anything up: name the candidates and ask "bootstrap them all?" (all, a subset, or none — their call). Consented candidates join the true-up pass below; their true-up runs its normal empty-project path and bootstraps the estate. Declined candidates are recorded as `not integrated (declined)` — declining is a valid state, not drift, and `/ok` asks again no sooner than its next run.

Never bootstrap silently, and never install a *plugin* here — this step integrates installed plugins into the project, nothing else.

### 4. True up each

For each integrated plugin and each consented bootstrap candidate, invoke its true-up verb via the Skill tool: `<plugin>:true-up`, sequentially. Each run diagnoses, proposes any migration or conflict resolution for the owner's consent, converges what it owns, and reports.

- If the skill is unavailable (plugin not installed in this session), record status `not-installed` with remedy `claude plugin install <plugin>@ok-plugins` — do not attempt any substitute check of your own.
- When a plugin's true-up stops for owner input (a migration to consent to, a profile proposal to review, a conflict to resolve), relay its questions verbatim, collect the owner's answer, and let that plugin's true-up finish before moving to the next plugin.
- Never reinterpret, filter, or re-derive a plugin's findings. The plugin's true-up is the authority on its own estate.

### 5. Report

```
ok — <project root>

| plugin | installed | outcome |
|---|---|---|
| ok-planner | v4.0.0 → v4.1.0 | trued up (pre-4.0 layout migrated) |
| ok-plumbline | v0.8.0 | clean |
| ok-workspaces | v0.2.0 | waiting on owner: proposal at .ok-workspaces/config.proposed.json |
| ok-example | v1.0.0 | bootstrapped (estate created by true-up) |

<each plugin's true-up report, verbatim, under its own heading>

<if any plugin was updated in step 1:> Run /reload-plugins to activate updated hooks.
```

## What this skill does NOT do

- Does not know any plugin's file formats, check logic, or estate layout beyond the discovery markers above.
- Does not run `audit`, `prove`, or any other work-driving verb.
- Does not install a plugin that is not installed — presence of a plugin is the user's choice, made outside `/ok`.
- Does not bootstrap without consent. An installed plugin with no markers is *offered* for bootstrap (step 3), never integrated silently; a decline means "not used here", which is a valid state, not drift.
- Does not edit any file itself. All writes happen inside the plugins' own true-up verbs.
