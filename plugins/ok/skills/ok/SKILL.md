---
name: ok
description: "ONLY activated by explicit /ok slash command. Never auto-triggered by conversation content. The suite's whole administration process in one command: updates the installed user-scoped plugins, discovers the skill families this project integrates by their filesystem markers, offers to bootstrap the rest in one consent question, then converges the suite's own ceremony layer and administers each family by driving its conventional administration files — converge core plus administration document — from the carried payload, settles every cleanup offer the cores print with the owner, and converges again."
---

<!-- @story: one-command-suite-upkeep -->

# ok — Suite Front Door

The suite's sole administrator. One command brings the whole ok-* suite current in this project: update the installed user-scoped plugins, discover every integrated skill family, offer to bootstrap the carried families the project does not use yet, converge the suite's own ceremony layer, then administer each family in one pass — diagnose, converge, then every cleanup offer settled with the owner and a second converge. One pass ends with the project converged. Every converge is an idempotent installer: it bootstraps an empty project and repairs an existing one, so `/ok` never needs to know which case it is in.

**Family knowledge lives in the family's directory.** The families travel as this plugin's payload at `families/{ok-planner,ok-plumbline,ok-workspaces}`, and each exposes two administration files: a deterministic converge core at `admin/converge` (modes: `diagnose`, converge, `resolve` for the cleanup offers it prints, and `wire-hooks` where the family declares hooks) and an administration document at `admin/ADMINISTRATION.md` carrying the migration, conflict, and declaration judgment the core cannot encode. Administer every family by driving those two files: run the core, follow the document. If administering a family seems to require a special case neither file covers, the family's conformance is wrong, not this skill; report that instead of accommodating it.

**The suite owns one layer of its own**: the two ceremony verbs — `audit` and `document` — which belong to no family and cover whichever estates a project has, plus the suite's rules file and its two hooks — the subagent-model gate and the subagent-batching context injection. The same two conventional files administer them, at this plugin's own `admin/converge` and `admin/ADMINISTRATION.md`.

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

1. **Diagnose.** `bash "${CLAUDE_PLUGIN_ROOT:-plugins/ok}/admin/converge" diagnose`. Include what it reports, and read its exit code as step 4 says.
2. **Consult** `${CLAUDE_PLUGIN_ROOT:-plugins/ok}/admin/ADMINISTRATION.md` for whatever takes judgment.
3. **Converge.** `bash "${CLAUDE_PLUGIN_ROOT:-plugins/ok}/admin/converge"`.

Drive it before the families. It also materializes the suite's own rules file (`.claude/rules/ok-cheatsheet.md`) and the two hooks (`.claude/hooks/ok-agent-model`, `.claude/hooks/ok-subagent-batching`); hold its `CLEANUP OFFERED` blocks with the families' for step 5 and its `WIRING NEEDED` blocks — the hook entries and the task-tools env entry — with the families' for step 6.

### 4. Administer each family, one pass

For each integrated or consented family, sequentially, drive its two files from the payload:

1. **Diagnose.** `bash "<payload>/<family>/admin/converge" diagnose` — the read-only report: layout, materialized-artifact fidelity and stamps, retired layout, hook wiring. Include what it reports; a clean, integrated family needs nothing else. Diagnose exits 0 when the layer is clean, 1 on drift, and 3 when its only findings are cleanup offers awaiting the owner. Read 3 as offers pending, which step 5 settles, never as a broken layer; read 1 as drift, which converge repairs. Missing or drifted hook wiring is drift, so it exits 1.
2. **Consult the administration document** — `<payload>/<family>/admin/ADMINISTRATION.md` — for everything diagnose surfaced that takes judgment: overlapping project context, and how to draft each offer that needs the owner's words. Follow its procedures exactly.
3. **Converge.** `bash "<payload>/<family>/admin/converge"` — the deterministic materialization of the suite-owned layer. A converge migrates the suite's own retired layout without asking: running `/ok` is that permission, and consent is reserved for what the ownership rule names.
4. **Hold the offers and the wiring.** Collect every `CLEANUP OFFERED` block and every `WIRING NEEDED` block diagnose or converge printed, one per id; a later block with the same id replaces the earlier one. Act on none of them yet.

### 5. Settle the cleanup offers — one question, then converge again

A core prints a `CLEANUP OFFERED` block for each item it cannot settle alone. The block's first line names the layer and the item's id. `What:` says what is there. `Fix:` says what the fix does, or one `Choice <name>:` line per choice says what each choice does. `Recommended:` names the answer to take. `On the owner's consent run:` gives the exact command. A `Show:` line gives a command that prints what the fix would discard. A `Draft:` line marks an item whose fix needs the owner's words or judgment, and says what the draft must hold. An `Uncommitted:` line names paths with uncommitted or staged-only changes, and a `Symbolic link:` line names a link the paths sit behind; the core's `resolve` refuses such an item until the owner commits the changes or removes the link. No offer has a choice that discards changes.

1. **Draft.** For each block with a `Draft:` line, write the draft it describes to a scratch path outside the project: the session's scratchpad directory, else a directory from `mktemp -d`. Write a file where the block names a file, and a directory of files where it names a directory. Draft from the project's own material — the file and lines the block names, the tree, and the layer's administration document. Change only what the block says must change, and keep every line and entry the block does not name exactly as it stands. The draft is not a write to the project; the core writes it on consent.
2. **Ask once.** Present every held block together in one message, as a plain-text list with one line per item: the id, what is there, the fix, and the recommended answer. Put each draft under its line, as a diff where it replaces a file, and the output of each `Show:` command under its line. Then ask once, in prose. The owner may accept all, some, or none, and picks one choice for each item that offers two.
3. **Apply.** For each accepted item, run the command its block names, with the chosen choice name after the id, or `--from <draft path>` where the block carries a draft. Keep the id quoted as the block prints it, so a path with a space stays one argument. The core re-reads its offers and refuses an id it no longer holds; relay the refusal in the report. A core that refuses a draft says why: correct the draft, show it again, and ask about that item alone. A collision's or retired verb's fix deletes only the files its block lists. Where an item's block carries an `Uncommitted:` or `Symbolic link:` line, the core refuses it: tell the owner to commit those changes or remove the link, then run `/ok` again.
4. **Converge again.** Run the converge core of every layer whose offer you applied, then its diagnose. Settle any block the second run prints the same way, so the pass ends with the project converged.

Record each declined item in the report as declined, not as drift. `/ok` offers it again on its next run.

### 6. Wire the consented settings entries — by transcription only, once

Present every collected `WIRING NEEDED` block to the owner together, once. Each block carries the exact settings entry and the exact consent command that writes it. On the owner's yes, run the consent command each block names (the front door's own blocks: `bash "${CLAUDE_PLUGIN_ROOT:-plugins/ok}/admin/converge" wire-hooks` for its hook entry and `bash "${CLAUDE_PLUGIN_ROOT:-plugins/ok}/admin/converge" wire-env` for the task-tools env entry; a family's hook block: `bash "<payload>/<family>/admin/converge" wire-hooks`); nothing else touches `.claude/settings.json`, and no entry or matcher is widened beyond the block presented. Each block is its own consent: the owner may take one and decline another. Record a declined entry as declined, not as drift. If any entry changed, remind the owner that hook and env changes take effect in the next session.

### 7. Report

```
ok — <project root>

| layer | carried | vendored in project | outcome |
|---|---|---|---|
| ceremonies | v10.1.0 | v10.0.0 | converged (audit, document re-stamped to v10.1.0) |
| ok-planner | v10.1.0 | v10.0.0 | converged (vendored layer re-stamped to v10.1.0) |
| ok-plumbline | v10.1.0 | v10.1.0 | clean |
| ok-workspaces | v10.1.0 | — | waiting on owner: profile proposal in conversation |

<what was wired or declined, each cleanup offer applied or declined, and any migration performed>

<for each retired verb removed:> `<name>` is gone; use `<its replacement>`.

<if any plugin was updated in step 1:> Plugin updates take effect after /reload-plugins or a session restart.
```

Name each removed verb's replacement from the retired-verb tables in the layers' administration documents: `certify-work` → `/converge sprint <path>`; `verify-issues` → `/triage-issues`; `plan-sprint-code` → `/plan-sprint`; `converge-local` and `converge-cascade` → `/converge`; `ok-planner-audit`, `ok-plumbline-audit`, `ok-workspaces-audit`, `verify-corpus`, and `certify-all` → `/audit`.

**carried** is the suite version the payload carries (the front-door manifest); **vendored in project** is the version the layer's stamps record here, `—` where the family has no vendored presence. The gap between the two columns is the useful signal, not an error. The ceremony layer is always a row: it is vendored into every project, whatever estates the project has. A retired verb removed by a converge is the one user-visible break worth naming.

## Boundaries

- Administration only, always a user action. `/ok` never invokes a family or ceremony verb — via the Skill tool or otherwise; `audit`, `plan-sprint`, and the rest are consumer surfaces for humans and implementation orchestrators. Nothing in the suite runs `/ok` from a hook.
- Improvises no family knowledge. Everything family-specific comes from the family's converge core, its administration document, and the contract's discovery markers. Which estates a ceremony covers is read from the filesystem when the verb runs, never decided here.
- Installs no plugins. The front door and the conduct are the only plugins; step 1 updates installed ones and does nothing else. The conduct (`ok-conduct`) is personal and user-scoped: `/ok` never installs, vendors, or offers it, and never treats its absence as a finding.
- Bootstraps only on consent (step 3); a decline means "not used here".
- Edits no file itself. All writes happen inside the converge cores. Hook wiring goes only through the consented `wire-hooks` and `wire-env` transcriptions. A cleanup offer's fix goes only through the core's consented `resolve` mode, and every draft the owner approved reaches the project through that mode from a scratch path outside it.
