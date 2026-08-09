---
name: ok
description: "ONLY activated by explicit /ok slash command. Never auto-triggered by conversation content. The suite's whole administration process in one command: updates the installed user-scoped plugins, discovers the skill families this project integrates by their filesystem markers, offers to bootstrap the rest in one consent question, then converges the suite's own ceremony layer and administers each family by driving its conventional administration surfaces — converge core plus administration document — from the carried payload."
---

<!-- @story: one-command-suite-upkeep -->

# ok — Suite Front Door

The suite's sole administrator, and administration is one process: install, converge, repair. One command brings the whole ok-* suite current in this project: update the installed user-scoped plugins, discover every skill family the project integrates, offer to bootstrap the carried families it doesn't use yet, converge the suite's own ceremony layer, then administer each family in one pass — diagnose, any consent the ownership rule requires, converge from the carried payload. Every converge is an idempotent installer: on an empty project it bootstraps the family's estate, on an existing one it repairs and converges — so `/ok` never needs to know which case it's in.

**Family knowledge lives in the family's directory, at the contract's conventional surfaces.** The families travel as this plugin's payload at `families/{ok-planner,ok-plumbline,ok-workspaces}`, and each exposes exactly two administration surfaces: a deterministic converge core at `admin/converge` (modes: `diagnose`, converge, and `wire-hooks` where the family declares hooks) and an administration document at `admin/ADMINISTRATION.md` carrying the migration, conflict, and declaration judgment the core cannot encode. Administer every family by driving those two surfaces — run the core, follow the document — and never improvise family knowledge from anywhere else. If administering a family ever seems to require a special case neither surface covers, the family's conformance is wrong, not this skill; report that instead of accommodating it.

**The suite owns one layer of its own**, beside the families: the four ceremony verbs — `plan-sprint`, `certify-work`, `audit`, `document` — which belong to no family and cover whichever estates a project has. They are administered through the same two conventional surfaces, at this plugin's own `admin/converge` and `admin/ADMINISTRATION.md`.

Administration only. `/ok` never invokes work-driving verbs (`audit`, `plan-sprint`, `open`, …) — those belong to humans and implementation orchestrators — and no family or ceremony verb is ever invoked through the Skill tool anywhere in this flow: they are consumer surfaces, vendored into projects, not administration machinery. Administration is always a user action: nothing in the suite runs it from a hook.

**The conduct is not this skill's business.** `ok-conduct` is a personal, user-scoped plugin: `/ok` updates it in step 1 if the user already installed it, but never installs it, never vendors it, never offers it for bootstrap, and never treats its absence as a finding. The choice is the user's alone, made outside `/ok`.

## Resolving the payload

Every path below resolves against the carried payload: `${CLAUDE_PLUGIN_ROOT:-plugins/ok}/families/<family>`. Invoked from the installed plugin, `CLAUDE_PLUGIN_ROOT` is the plugin root; in the suite's own monorepo the payload sits at `plugins/ok/families/` in-tree.

## Process

### 1. Update the installed user-scoped plugins

Bring every *installed* ok-plugin — the front door itself, and the conduct where the user chose it — to the marketplace's current version. Never install one that is absent:

```bash
claude plugin list --json   # which ok-plugins are installed, at what version
claude plugin update <name>@ok-plugins   # for each installed ok-plugin, including ok itself
```

Record what moved from which version to which. If anything was updated, note for the final report: plugin changes take effect after `/reload-plugins` or a session restart — say so. (Vendored families in the project change only when the owner converges, never here.)

### 2. Discover

Resolve the project root: the nearest ancestor of the working directory (the working directory included) carrying an estate marker — current or pre-migration — else the working directory itself, where a fresh install roots. Never derive the root from `.git`: the suite may live in a subfolder, submodule, or subproject of a repo whose own root wants no estate. A family is integrated iff its discovery markers exist at the root — its current marker (`.ok-<name>/`) **or any pre-migration marker documented in the integration contract** — a filesystem check, never an inference. Pre-migration markers matter here: a project carrying only an earlier layout must still be discovered, or its migration is never offered.

The contract's current-conformance section is the authority on markers. Currently documented pre-migration markers: **ok-plumbline** is integrated iff a root `.plumbline.json` exists or `.claude/rules/plumbline-cheatsheet.md` exists.

### 3. Offer to bootstrap the rest

A carried family with no discovery markers is a **bootstrap candidate** — the payload is on the machine, but this project has no estate for it yet. If any exist, ask the owner once, in one question, before administering anything: name the candidates and ask "bootstrap them all?" (all, a subset, or none — their call). Consented candidates join the administration pass below. Declined candidates are recorded as `not integrated (declined)` — declining is a valid state, not drift, and `/ok` asks again no sooner than its next run.

Never bootstrap silently, and never install a plugin here — bootstrap integrates a carried family into the project, nothing else.

### 3b. Converge the suite's own ceremony layer

Before the families, drive this plugin's own two surfaces — the layer that belongs to no family:

1. **Diagnose.** `bash "${CLAUDE_PLUGIN_ROOT:-plugins/ok}/admin/converge" diagnose`.
2. **Consult** `${CLAUDE_PLUGIN_ROOT:-plugins/ok}/admin/ADMINISTRATION.md` for whatever takes judgment.
3. **Converge.** `bash "${CLAUDE_PLUGIN_ROOT:-plugins/ok}/admin/converge"`.

It runs first for two reasons: a project that carries no estate is still entitled to the ceremony verbs (they resolve to "no estate in scope" and say so), and if a family's converge then fails, the owner still has the verbs to see what state the project is in. This layer declares no hooks, so it produces no wiring block.

### 4. Administer each family, one pass

For each integrated or consented family, sequentially, drive its two conventional surfaces from the payload:

1. **Diagnose.** `bash "<payload>/<family>/admin/converge" diagnose` — the read-only report: layout, materialized-artifact fidelity and stamps, retired layout, hook wiring. Include what it reports; on a clean, integrated family there is nothing else to do.
2. **Consult the administration document** — `<payload>/<family>/admin/ADMINISTRATION.md` — for everything diagnose surfaced that takes judgment: retired-layout migrations, collisions, overlapping project context, config or profile declaration. Follow its procedures exactly; migration and repair judgment comes from the document, never improvised. Consent questions it raises (a profile to declare, a conflict to resolve) are put to the owner in conversation and the answers transcribed per the document.
3. **Converge.** `bash "<payload>/<family>/admin/converge"` — the deterministic materialization of the suite-owned layer. A converge never stops to ask permission to migrate the suite's own retired layout — running `/ok` is that permission; consent is reserved for what the ownership rule names.
4. **Hold the wiring.** Collect every `WIRING NEEDED` block diagnose or converge printed — do not act on them yet.

Never reinterpret, filter, or re-derive a family's findings: the core and the document are the authority on the family's estate.

### 5. Wire the hooks — by consented transcription only, once

Present every collected `WIRING NEEDED` block to the owner **together, once**. Each block carries the exact settings entry and the exact consent command that writes it. On the owner's yes, run the consent command each block names (`bash "<payload>/<family>/admin/converge" wire-hooks`) — nothing else touches `.claude/settings.json`, and no entry or matcher is ever widened beyond the block presented. A declined entry is recorded in the report as declined, not as drift. If any entry changed, remind the owner that hook changes take effect in the next session.

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

The **carried** column is the suite version the payload carries (the front-door manifest); **vendored in project** is the version the layer's stamps record in this project — `—` where the family has no vendored presence here. The gap between carried and vendored is the useful signal, not an error. The ceremony layer is always a row: it is vendored into every project, whatever estates the project has.

A retired verb removed by a converge is the one user-visible break worth naming in the report, because an owner in the habit of typing it will find it gone.

## What this skill does NOT do

- Does not improvise family knowledge. Everything family-specific it acts on comes from the family's own administration surfaces — the converge core's output and the administration document's procedures — plus the discovery markers the contract documents.
- Does not decide which estates a ceremony covers. The ceremony layer vendors the same four bodies everywhere; which estates are in scope is read from the filesystem when a verb runs.
- Does not invoke any family or ceremony verb via the Skill tool, and does not run `audit`, `plan-sprint`, `certify-work`, or any other work-driving verb.
- Does not install plugins. The front door and the conduct are the only plugins, and updating installed ones is the whole of step 1.
- Does not bootstrap without consent. A carried family with no markers is *offered* for bootstrap (step 3), never integrated silently; a decline means "not used here", which is a valid state, not drift.
- Does not install, vendor, or offer the conduct. `ok-conduct` is personal and user-scoped; the only thing `/ok` ever does with it is update an already-installed copy in step 1.
- Does not edit any file itself. All writes happen inside the families' converge cores (and hook wiring only through their consented `wire-hooks` transcription paths); owner-declared configuration is written only as transcription of explicit answers, per each family's administration document.
