---
name: ok-doctor
description: "ONLY activated by explicit /ok-doctor slash command. Never auto-triggered by conversation content."
---

# ok-doctor — Suite Upkeep Dispatcher

One command that walks the project, finds every integrated ok-plugin, runs each one's own `doctor` verb, and drives the affirm-remediable drift back to clean. Pure dispatcher: it knows the integration contract's two conventions — the discovery markers and the uniform verb set (`affirm`, `doctor`) — and **nothing about any plugin's internals**. If driving a plugin ever seems to require a special case, the plugin's integration is wrong, not this skill; report that instead of accommodating it.

Plugin upkeep only. ok-doctor never invokes work-driving verbs (`audit`, `prove`, `open`, …) — those belong to humans and implementation orchestrators.

## Process

### 1. Discover

Resolve the project root (nearest `.git` ancestor). A plugin `ok-<name>` is integrated iff `.ok-<name>/` exists at the root — a filesystem check, never an inference.

One documented legacy exception (from the integration contract's current-conformance section, to be deleted when ok-plumbline migrates to `.ok-plumbline/`): **ok-plumbline** is integrated iff `.plumbline.json` exists at the root or `.claude/rules/plumbline-cheatsheet.md` exists.

### 2. Doctor each

For each integrated plugin, invoke its doctor verb via the Skill tool: `<plugin>:doctor`. Collect each report verbatim.

- If the skill is unavailable (plugin not installed in this session), record status `not-installed` with remedy `/plugin install <plugin>@ok-plugins` — do not attempt any substitute check of your own.
- Never reinterpret, filter, or re-derive a plugin's findings. The plugin's doctor is the authority on its own estate.

### 3. Remediate what affirm can fix

For each plugin whose doctor reported drift with `affirm` as the remedy, invoke `<plugin>:affirm`, then re-run `<plugin>:doctor` to confirm clean.

Drift whose remedy requires owner judgment — a stack profile to reconcile, a malformed queue row to repair, a proposal awaiting review — is **reported, never auto-resolved**. Affirm steps that stop for owner review (e.g. a freshly written proposal) stop here too; relay their instructions.

### 4. Report

```
ok-doctor — <project root>

| plugin | status | outcome |
|---|---|---|
| ok-planner | drift → clean | re-affirmed (v4.0.0) |
| ok-plumbline | clean | — |
| ok-workspaces | drift (owner) | stacks declared [go] but detected [go,docker] — reconcile .ok-workspaces/config.json, then /ok-workspaces:affirm |

<each plugin's doctor report, verbatim, under its own heading>
```

## What this skill does NOT do

- Does not know any plugin's file formats, check logic, or estate layout beyond the discovery markers above.
- Does not run `audit`, `prove`, or any other work-driving verb.
- Does not integrate a plugin into a project that lacks it — absence of a marker means "not used here", which is a valid state, not drift.
- Does not edit any file itself. All writes happen inside the plugins' own affirm verbs.
