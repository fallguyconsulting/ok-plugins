---
name: ok
description: "ONLY activated by explicit /ok slash command. Never auto-triggered by conversation content. The suite's whole administration process in one command: updates the installed user-scoped plugins, discovers whether this project integrates ok-planner by its filesystem markers (the planner's estate, or a layout an earlier release left), offers to bootstrap it in one consent question where it is absent, then administers the one family by driving its conventional administration files — converge core plus administration document — from the carried payload, settles every cleanup offer the core prints with the owner, and converges again."
---

<!-- @story: converge-project-estate -->

# ok — Suite Front Door

The suite's sole administrator. One command brings the suite current in this project: update the installed user-scoped plugins, discover whether the project integrates ok-planner, offer to bootstrap it where the project does not use it yet, then administer it in one pass — diagnose, converge, then every cleanup offer settled with the owner and a second converge. One pass ends with the project converged. Every converge is an idempotent installer: it bootstraps an empty project, migrates a layout an earlier release left, and repairs an existing one, so `/ok` never needs to know which case it is in.

**The suite vendors one family.** ok-planner travels as this plugin's payload at `families/ok-planner`, and everything the suite vendors into a project comes from it: the planner's skills (`audit` and `document` among them), the rules files, the hooks, the lint, and the standards. The family exposes two administration files: a deterministic converge core at `admin/converge` (modes: `diagnose`, converge, `resolve` for the cleanup offers it prints, `wire-hooks <group>` for one hook group, and `wire-env` for the task-tools env entry) and an administration document at `admin/ADMINISTRATION.md` carrying the migration, conflict, and declaration judgment the core cannot encode. Administer the family by driving those two files: run the core, follow the document. If administering the family seems to require a special case neither file covers, the family's conformance is wrong, not this skill; report that instead of accommodating it.

## Resolving the payload

Every path below resolves against the carried payload: `${CLAUDE_PLUGIN_ROOT:-plugins/ok}/families/ok-planner`, written `<payload>` below. Invoked from the installed plugin, `CLAUDE_PLUGIN_ROOT` is the plugin root; in the suite's own monorepo the payload sits at `plugins/ok/families/ok-planner` in-tree.

## Process

### 1. Update the installed user-scoped plugins

Bring every installed ok-plugin — the front door itself, and the conduct where the user installed it — to the marketplace's current version:

```bash
claude plugin list --json   # which ok-plugins are installed, at what version
claude plugin update <name>@ok-plugins   # for each installed ok-plugin, including ok itself
```

Record what moved from which version to which. If anything was updated, note for the final report that plugin changes take effect after `/reload-plugins` or a session restart. The vendored layer in the project changes only when the owner converges, never here.

<!-- @decision: one-vendored-family -->
### 2. Discover

Resolve the project root: the nearest ancestor of the working directory (the working directory included) carrying a marker below, else the working directory itself, where a fresh install roots. Resolve by marker only: the suite may live in a subfolder, submodule, or subproject of a repo whose own `.git` root wants no estate.

The project integrates ok-planner iff one of these markers exists at the root:

- `.ok-planner/`, the planner's estate;
- a pre-migration marker an earlier release laid out: `.ok-plumbline/`, `.ok-workspaces/`, a root `.plumbline.json`, or `.claude/rules/plumbline-cheatsheet.md`.

A project carrying only a pre-migration marker is integrated: the converge in step 4 migrates its retired layout into the planner's estate. The integration contract's "Discovery markers" section is the authority on markers; the converge core resolves the root from the same set.

### 3. Offer to bootstrap ok-planner

A project with no marker is a **bootstrap candidate**: the payload is on the machine, but this project has no estate. Ask the owner once, before administering anything: "bootstrap ok-planner here?" On yes, the administration pass below bootstraps it. On no, record `not integrated (declined)`, skip steps 4 through 6, and report. Declining is a valid state, not drift, and `/ok` asks again no sooner than its next run.

### 4. Administer ok-planner, one pass

Drive the family's two files from the payload, once:

1. **Diagnose.** `bash "<payload>/admin/converge" diagnose` — the read-only report: layout, materialized-artifact fidelity and stamps, retired layout, hook wiring. Include what it reports; a clean, integrated project needs nothing else. Diagnose exits 0 when the layer is clean, 1 on drift, and 3 when its only findings are cleanup offers awaiting the owner. Read 3 as offers pending, which step 5 settles, never as a broken layer; read 1 as drift, which converge repairs. Missing or drifted hook wiring is drift, so it exits 1.
2. **Consult the administration document** — `<payload>/admin/ADMINISTRATION.md` — for everything diagnose surfaced that takes judgment: overlapping project context, and how to draft each offer that needs the owner's words. Follow its procedures exactly.
3. **Converge.** `bash "<payload>/admin/converge"` — the deterministic materialization of the suite-owned layer. A converge migrates the suite's own retired layout without asking: running `/ok` is that permission, and consent is reserved for what the ownership rule names.
4. **Hold the offers and the wiring.** Collect every `CLEANUP OFFERED` block and every `WIRING NEEDED` block diagnose or converge printed, one per id; a later block with the same id replaces the earlier one. Act on none of them yet.

### 5. Settle the cleanup offers — one question, then converge again

The core prints a `CLEANUP OFFERED` block for each item it cannot settle alone. The block's first line names the layer and the item's id. `What:` says what is there. `Fix:` says what the fix does, or one `Choice <name>:` line per choice says what each choice does. `Recommended:` names the answer to take. `On the owner's consent run:` gives the exact command. A `Show:` line gives a command that prints what the fix would discard. A `Draft:` line marks an item whose fix needs the owner's words or judgment, and says what the draft must hold. An `Uncommitted:` line names paths with uncommitted or staged-only changes, and a `Symbolic link:` line names a link the paths sit behind; the core's `resolve` refuses such an item until the owner commits the changes or removes the link. No offer has a choice that discards changes.

1. **Draft.** For each block with a `Draft:` line, write the draft it describes to a scratch path outside the project: the session's scratchpad directory, else a directory from `mktemp -d`. Write a file where the block names a file, and a directory of files where it names a directory. Draft from the project's own material — the file and lines the block names, the tree, and the administration document. Change only what the block says must change, and keep every line and entry the block does not name exactly as it stands. The draft is not a write to the project; the core writes it on consent.
2. **Ask once.** Present every held block together in one message, as a plain-text list with one line per item: the id, what is there, the fix, and the recommended answer. Put each draft under its line, as a diff where it replaces a file, and the output of each `Show:` command under its line. Then ask once, in prose. The owner may accept all, some, or none, and picks one choice for each item that offers two.
3. **Apply.** For each accepted item, run the command its block names, with the chosen choice name after the id, or `--from <draft path>` where the block carries a draft. Keep the id quoted as the block prints it, so a path with a space stays one argument. The core re-reads its offers and refuses an id it no longer holds; relay the refusal in the report. A core that refuses a draft says why: correct the draft, show it again, and ask about that item alone. A collision's or retired verb's fix deletes only the files its block lists. Where an item's block carries an `Uncommitted:` or `Symbolic link:` line, the core refuses it: tell the owner to commit those changes or remove the link, then run `/ok` again.
4. **Converge again.** Where you applied any offer, run the converge core again, then its diagnose. Settle any block the second run prints the same way, so the pass ends with the project converged.

Record each declined item in the report as declined, not as drift. `/ok` offers it again on its next run.

### 6. Wire the consented settings entries — by transcription only, once

Present every collected `WIRING NEEDED` block to the owner together, once. Each block carries the exact settings entry and the exact consent command that writes it: `bash "<payload>/admin/converge" wire-hooks <group>` for a hook group (`session-start`, `subagents`, or `lint`, as the block names it) and `bash "<payload>/admin/converge" wire-env` for the task-tools env entry. On the owner's yes, run the consent command each accepted block names; nothing else touches `.claude/settings.json`, and no entry or matcher is widened beyond the block presented. Each block is its own consent: the owner may take one and decline another. Record a declined entry as declined, not as drift. If any entry changed, remind the owner that hook and env changes take effect in the next session.

### 7. Report

```
ok — <project root>

| family | carried | vendored in project | outcome |
|---|---|---|---|
| ok-planner | v10.1.0 | v10.0.0 | converged (vendored layer re-stamped to v10.1.0; .ok-plumbline/ migrated into .ok-planner/) |

<what was wired or declined, each cleanup offer applied or declined, and any migration performed>

<for each retired verb removed:> `<name>` is gone; use `<its replacement>`.

<if any plugin was updated in step 1:> Plugin updates take effect after /reload-plugins or a session restart.
```

Name each removed verb's replacement from the retired-verb table in the administration document:

| retired | replaced by |
|---|---|
| `certify-work` | sprint certification, `/converge sprint <path>` |
| `verify-issues` | `/triage-issues` |
| `plan-sprint-code` | `/plan-sprint` |
| `converge-local`, `converge-cascade` | `/converge` |
| `ok-planner-audit`, `ok-plumbline-audit`, `ok-workspaces-audit`, `verify-corpus`, `certify-all` | `/audit` |
| `budget` | retired; turn a lint check off with `lint_checks` |
| `patterns` | retired; `/audit`'s lint sweep clusters violations |
| `version` | `/ok-version` |
| `execute-tasks` | the drain loop, which `/audit`, `/converge`, `/triage-issues`, and sprint execution read by path |
| `events`, `explain`, `port`, `starter`, `suggest`, `open`, `close`, `ok-workspaces`, `ok-planner`, `slug`, `ci` | retired |

**carried** is the suite version the payload carries (the front-door manifest); **vendored in project** is the version the vendored layer's stamps record here, `—` where the project has no vendored presence. The gap between the two columns is the useful signal, not an error. A retired verb removed by a converge is the one user-visible break worth naming.

## Boundaries

- Administration only, always a user action. `/ok` never invokes a family verb — via the Skill tool or otherwise; `audit`, `plan-sprint`, and the rest are consumer surfaces for humans and implementation orchestrators. Nothing in the suite runs `/ok` from a hook.
- Improvises no family knowledge. Everything family-specific comes from the converge core, the administration document, and the contract's discovery markers.
- Installs no plugins. The front door and the conduct are the only plugins; step 1 updates installed ones and does nothing else. The conduct (`ok-conduct`) is personal and user-scoped: `/ok` never installs, vendors, or offers it, and never treats its absence as a finding.
- Bootstraps only on consent (step 3); a decline means "not used here".
- Edits no file itself. All writes happen inside the converge core. Hook wiring goes only through the consented `wire-hooks <group>` and `wire-env` transcriptions. A cleanup offer's fix goes only through the core's consented `resolve` mode, and every draft the owner approved reaches the project through that mode from a scratch path outside it.
