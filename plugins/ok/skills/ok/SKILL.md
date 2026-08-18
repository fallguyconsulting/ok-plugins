---
name: ok
description: "ONLY activated by explicit /ok slash command. Never auto-triggered by conversation content. The suite's whole administration process in one command: updates the installed user-scoped plugins, discovers the skill families this project integrates by their filesystem markers, offers to bootstrap the rest in one consent question, then converges the suite's own ceremony layer and administers each family by driving its conventional administration files — converge core plus administration document — from the carried payload."
---

<!-- @story: one-command-suite-upkeep -->

# ok — Suite Front Door

The suite's sole administrator. One command brings the whole ok-* suite current in this project: update the installed user-scoped plugins, discover every integrated skill family, offer to bootstrap the carried families the project does not use yet, converge the suite's own ceremony layer, then administer each family in one pass — diagnose, any consent the ownership rule requires, converge. Every converge is an idempotent installer: it bootstraps an empty project and repairs an existing one, so `/ok` never needs to know which case it is in.

**Family knowledge lives in the family's directory.** The families travel as this plugin's payload at `families/{ok-planner,ok-plumbline,ok-workspaces}`, and each exposes two administration files: a deterministic converge core at `admin/converge` (modes: `diagnose`, converge, and `wire-hooks` where the family declares hooks) and an administration document at `admin/ADMINISTRATION.md` carrying the migration, conflict, and declaration judgment the core cannot encode. Administer every family by driving those two files: run the core, follow the document. If administering a family seems to require a special case neither file covers, the family's conformance is wrong, not this skill; report that instead of accommodating it.

**The suite owns one layer of its own**: the four ceremony verbs — `plan-sprint`, `certify-work`, `audit`, `document` — which belong to no family and cover whichever estates a project has, plus the suite's rules file and the subagent-model hook. The same two conventional files administer them, at this plugin's own `admin/converge` and `admin/ADMINISTRATION.md`.

## Resolving the payload

Every path below resolves against the carried payload: `${CLAUDE_PLUGIN_ROOT:-plugins/ok}/families/<family>`. Invoked from the installed plugin, `CLAUDE_PLUGIN_ROOT` is the plugin root; in the suite's own monorepo the payload sits at `plugins/ok/families/` in-tree.

## Process

### 1. Update the installed user-scoped plugins

Bring every installed ok-plugin — the front door itself, and the conduct where the user installed it — to the marketplace's current version:

```bash
claude plugin list --json   # which ok-plugins are installed, at what version
claude plugin update <name>@ok-plugins   # for each installed ok-plugin, including ok itself
```

Record what moved from which version to which. If anything was updated, note for the final report that plugin changes take effect after `/reload-plugins` or a session restart. Vendored families in the project change only when the owner converges, never here.

### 2. Discover

Resolve the project root: the nearest ancestor of the working directory (the working directory included) carrying an estate marker — current or pre-migration — else the working directory itself, where a fresh install roots. Resolve by marker only: the suite may live in a subfolder, submodule, or subproject of a repo whose own `.git` root wants no estate. A family is integrated iff its discovery markers exist at the root — its current marker (`.ok-<name>/`) or any pre-migration marker the integration contract documents; a project carrying only an earlier layout is still discovered, so its migration gets offered. The contract's current-conformance section is the authority on markers. Currently documented pre-migration markers: ok-plumbline is integrated iff a root `.plumbline.json` exists or `.claude/rules/plumbline-cheatsheet.md` exists.

### 3. Offer to bootstrap the rest

A carried family with no discovery markers is a **bootstrap candidate**: the payload is on the machine, but this project has no estate for it. If any exist, ask the owner once, in one question, before administering anything: name the candidates and ask "bootstrap them all?" — all, a subset, or none. Consented candidates join the administration pass below. Record declined candidates as `not integrated (declined)`; declining is a valid state, not drift, and `/ok` asks again no sooner than its next run.

### 3b. Converge the suite's own ceremony layer

Before the families, drive this plugin's own two files:

1. **Diagnose.** `bash "${CLAUDE_PLUGIN_ROOT:-plugins/ok}/admin/converge" diagnose`. Include what it reports. A line it prints outside a `WIRING NEEDED` block, such as an unusable or unparseable `.claude/settings.json`, reaches the owner only through your report.
2. **Consult** `${CLAUDE_PLUGIN_ROOT:-plugins/ok}/admin/ADMINISTRATION.md` for whatever takes judgment.
3. **Converge.** `bash "${CLAUDE_PLUGIN_ROOT:-plugins/ok}/admin/converge"`.

Drive it before the families. It also materializes the suite's own rules file (`.claude/rules/ok-cheatsheet.md`) and the subagent-model hook (`.claude/hooks/ok-agent-model`); hold its `WIRING NEEDED` blocks — the hook entry and the task-tools env entry — with the families' for step 5.

### 4. Administer each family, one pass

For each integrated or consented family, sequentially, drive its two files from the payload:

1. **Diagnose.** `bash "<payload>/<family>/admin/converge" diagnose` — the read-only report: layout, materialized-artifact fidelity and stamps, retired layout, hook wiring. Include what it reports; a clean, integrated family needs nothing else.
2. **Consult the administration document** — `<payload>/<family>/admin/ADMINISTRATION.md` — for everything diagnose surfaced that takes judgment: retired-layout migrations, collisions, overlapping project context, config or profile declaration. Follow its procedures exactly. Put the consent questions it raises to the owner in conversation and transcribe the answers per the document.
3. **Converge.** `bash "<payload>/<family>/admin/converge"` — the deterministic materialization of the suite-owned layer. A converge migrates the suite's own retired layout without asking: running `/ok` is that permission, and consent is reserved for what the ownership rule names.
4. **Hold the wiring.** Collect every `WIRING NEEDED` block diagnose or converge printed; act on none of them yet.

### 5. Wire the consented settings entries — by transcription only, once

Present every collected `WIRING NEEDED` block to the owner together, once. Each block carries the exact settings entry and the exact consent command that writes it. On the owner's yes, run the consent command each block names (the front door's own blocks: `bash "${CLAUDE_PLUGIN_ROOT:-plugins/ok}/admin/converge" wire-hooks` for its hook entry and `bash "${CLAUDE_PLUGIN_ROOT:-plugins/ok}/admin/converge" wire-env` for the task-tools env entry; a family's hook block: `bash "<payload>/<family>/admin/converge" wire-hooks`); nothing else touches `.claude/settings.json`, and no entry or matcher is widened beyond the block presented. Each block is its own consent: the owner may take one and decline another. Record a declined entry as declined, not as drift. If any entry changed, remind the owner that hook and env changes take effect in the next session.

### 6. Report

```
ok — <project root>

| layer | carried | vendored in project | outcome |
|---|---|---|---|
| ceremonies | v10.1.0 | v10.0.0 | converged (plan-sprint, certify-work, audit, document re-stamped to v10.1.0) |
| ok-planner | v10.1.0 | v10.0.0 | converged (vendored layer re-stamped to v10.1.0) |
| ok-plumbline | v10.1.0 | v10.1.0 | clean |
| ok-workspaces | v10.1.0 | — | waiting on owner: profile proposal in conversation |

<what was wired or declined, and any migration performed>

<if any retired verb was removed:> `<name>` is gone — the ceremony verbs cover every estate now; use `/audit`.

<if any plugin was updated in step 1:> Plugin updates take effect after /reload-plugins or a session restart.
```

**carried** is the suite version the payload carries (the front-door manifest); **vendored in project** is the version the layer's stamps record here, `—` where the family has no vendored presence. The gap between the two columns is the useful signal, not an error. The ceremony layer is always a row: it is vendored into every project, whatever estates the project has. A retired verb removed by a converge is the one user-visible break worth naming.

## Boundaries

- Administration only, always a user action. `/ok` never invokes a family or ceremony verb — via the Skill tool or otherwise; `audit`, `plan-sprint`, and the rest are consumer surfaces for humans and implementation orchestrators. Nothing in the suite runs `/ok` from a hook.
- Improvises no family knowledge. Everything family-specific comes from the family's converge core, its administration document, and the contract's discovery markers. Which estates a ceremony covers is read from the filesystem when the verb runs, never decided here.
- Installs no plugins. The front door and the conduct are the only plugins; step 1 updates installed ones and does nothing else. The conduct (`ok-conduct`) is personal and user-scoped: `/ok` never installs, vendors, or offers it, and never treats its absence as a finding.
- Bootstraps only on consent (step 3); a decline means "not used here".
- Edits no file itself. All writes happen inside the converge cores; hook wiring goes only through the consented `wire-hooks` transcription, and owner-declared configuration is written only as transcription of explicit answers, per each family's administration document.
