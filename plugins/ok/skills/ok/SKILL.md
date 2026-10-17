---
name: ok
description: "ONLY activated by explicit /ok slash command. Never auto-triggered by conversation content. The suite's whole administration process in one command: updates the installed user-scoped plugins, discovers whether this project integrates ok-planner by its filesystem markers (the planner's estate, or a layout an earlier release left), offers to bootstrap it in one consent question where it is absent, then administers the one family by driving its conventional administration files — true-up core plus administration document — from the carried payload: it shows the core's one plan and, where the plan deletes, archives, or rewrites a person's file, asks once to go ahead with all of it or abort, applies it, then settles the input questions with the owner and trues up again."
---

<!-- @story: true-up-project-estate -->

# ok — Suite Front Door

The suite's sole administrator. One command brings the suite current in this project: update the installed user-scoped plugins, discover whether the project integrates ok-planner, offer to bootstrap it where the project does not use it yet, then administer it in one pass. Diagnose prints one plan, every step the true-up would take with each destructive step marked; where the plan holds a destructive step, the owner answers one question, go ahead with all of it or abort, before anything is written. The plan runs, then a check of the project against the carried version, then the input questions and the wiring settled with the owner and a second true-up. One pass ends with the project trued up, with each check finding still pending named in the report, or, on abort, with the project unchanged on the version its stamps record. Every true-up is an idempotent installer: it bootstraps an empty project, migrates a layout an earlier release left, and repairs an existing one, so `/ok` never needs to know which case it is in.

**The suite vendors one family.** ok-planner travels as this plugin's payload at `families/ok-planner`, and everything the suite vendors into a project comes from it: the planner's skills, the rules files, the hooks, the lint, and the standards. The family exposes two administration files: a deterministic true-up core at `admin/true-up` (modes: `diagnose`, which prints the plan, the input questions, and the wiring blocks; true-up, which applies a plan with no destructive step, and `--go-ahead <plan id> [--drafts <dir>]`, which applies the plan the owner went ahead with; `show <path>` for a rewrite's diff; `resolve` for an answered input question; `amend` for a check finding's approved draft of the project's configuration; `wire-hooks <group>` for one hook group; `wire-env` for the task-tools env entry; and `check-range <first> <last>` for a read-only check of a port range the owner names) and an administration document at `admin/ADMINISTRATION.md` carrying the migration, conflict, and declaration judgment the core cannot encode. Administer the family by driving those two files: run the core, follow the document. If administering the family seems to require a special case neither file covers, the family's conformance is wrong, not this skill; report that instead of accommodating it.

## Resolving the payload

Every path below resolves against the carried payload, written `<payload>` below. Resolve it once, after step 1, and use that one path in steps 2 through 7.

- **Where step 1 updated ok itself and `CLAUDE_PLUGIN_ROOT` is set**, the session's `CLAUDE_PLUGIN_ROOT` still names the superseded version's folder until `/reload-plugins` or a restart, so resolve the payload from the new install. Read the `installPath` of the entry in `claude plugin list --json` whose `id` is `ok@ok-plugins` and whose `scope` is `user`. Where that entry carries no `installPath`, read the `installPath` of the user-scoped entry under `plugins["ok@ok-plugins"]` in `~/.claude/plugins/installed_plugins.json`. `<payload>` is `<that path>/families/ok-planner`. Where neither source names a path, or `<that path>/families/ok-planner/admin/true-up` does not exist, stop before step 2: report what step 1 moved, and tell the owner to run `/reload-plugins` and then `/ok` again.
- **Otherwise**, where ok did not move or `CLAUDE_PLUGIN_ROOT` is unset, `<payload>` is `${CLAUDE_PLUGIN_ROOT:-plugins/ok}/families/ok-planner`. Invoked from the installed plugin, `CLAUDE_PLUGIN_ROOT` is the plugin root; in the suite's own monorepo, where it is unset, the payload sits at `plugins/ok/families/ok-planner` in-tree.

## Process

### 1. Update the installed user-scoped plugins

Bring every installed ok-plugin — the front door itself, and the conduct where the user installed it — to the marketplace's current version:

```bash
claude plugin list --json   # which ok-plugins are installed, at what version
claude plugin update <name>@ok-plugins   # for each installed ok-plugin, including ok itself
```

Record what moved from which version to which. Where `claude plugin update ok@ok-plugins` reports a change, resolve `<payload>` from the new install path, as "Resolving the payload" says, so steps 2 through 7 run the new version's true-up core and administration document. If anything was updated, note for the final report that plugin changes take effect after `/reload-plugins` or a session restart. The vendored layer in the project changes only when the owner trues it up, never here.

<!-- @decision: one-vendored-family -->
### 2. Discover

Resolve the project root: the nearest ancestor of the working directory (the working directory included) carrying a marker below, else the working directory itself, where a fresh install roots. Resolve by marker only: the suite may live in a subfolder, submodule, or subproject of a repo whose own `.git` root wants no estate.

The project integrates ok-planner iff one of these markers exists at the root:

- `.ok-planner/`, the planner's estate;
- a pre-migration marker an earlier release laid out: `.ok-plumbline/`, `.ok-workspaces/`, a root `.plumbline.json`, or `.claude/rules/plumbline-cheatsheet.md`.

A project carrying only a pre-migration marker is integrated: the plan in step 4 migrates its retired layout into the planner's estate. The integration contract's "Discovery markers" section is the authority on markers; the true-up core resolves the root from the same set.

### 3. Offer to bootstrap ok-planner

A project with no marker is a **bootstrap candidate**: the payload is on the machine, but this project has no estate. Ask the owner once, before administering anything: "bootstrap ok-planner here?" On yes, the administration pass below bootstraps it. On no, record `not integrated (declined)`, skip steps 4 through 6, and report. Declining is a valid state, not drift, and `/ok` asks again no sooner than its next run.

<!-- @story: turn-down-a-destructive-true-up -->
<!-- @decision: true-up-asks-once-before-destructive-steps -->
### 4. Show the plan, ask once, apply it

Drive the family's two files from the payload, once:

1. **Diagnose.** `bash "<payload>/admin/true-up" diagnose` — the read-only report. It prints the plan: one `DRIFT: <step>` line per step that destroys nothing, one `DESTRUCTIVE: <step>` line per step that deletes a file, moves a file into the archive, or rewrites a file a person edited, a `Show:` line under a step whose archive or rewrite it prints, a `Draft:` line under a step that needs a draft, `blocked:` lines for an estate the plan leaves alone, `left:` and `retired script kept:` notes, and the closing `PLAN: <n> step(s), <d> destructive; plan <id>` line. It also prints the input questions (`INPUT NEEDED` blocks) and the wiring (`wiring:` lines and `WIRING NEEDED` blocks). Diagnose exits 0 when the layer is clean, 1 while the plan holds a step or a blocked line or wiring is pending, and 3 when its only findings are input questions. Read 3 as questions pending, which step 5 settles, never as a broken layer.
2. **Consult the administration document** — `<payload>/admin/ADMINISTRATION.md` — for everything diagnose surfaced that takes judgment: overlapping project context, each draft a plan step or a question needs, and each step's meaning. Follow its procedures exactly.
3. **Draft.** For each plan step with a `Draft:` line, write the draft it describes into one scratch folder outside the project: the session's scratchpad directory, else a directory from `mktemp -d`. Name each file as the `Draft:` line names it. Draft from the project's own material — the files the step names, the tree, and the administration document. The draft is not a write to the project; the core reads it on the go-ahead.
4. **Ask once, where the plan holds a destructive step.** Show the owner the whole plan once, in one message: every step, each destructive step marked, the output of each `Show:` command under its step, each draft under its step, and every `blocked:` and `left:` line. Then ask once, in prose: go ahead with all of it, or abort. Ask nothing else in that message. A plan with no destructive step needs no question.
5. **On abort**, write nothing and ask nothing else. Skip steps 5 and 6, and report the outcome `declined; stays on v<stamped>`, where `<stamped>` is the version the vendored layer's stamps record: the project keeps working on the copies it has.
6. **On go-ahead**, run `bash "<payload>/admin/true-up" --go-ahead <plan id> --drafts <the scratch folder>`, with the id the `PLAN:` line printed; leave out `--drafts` where no step carries a `Draft:` line. Where the plan holds no destructive step, run the bare `bash "<payload>/admin/true-up"`. Where the core refuses with `the plan changed since diagnose`, run diagnose again and show the new plan, asking the same one question about it. Where it refuses with any other `nothing written` line, relay its causes: the owner settles them, and the project stays on its stamped version until the next `/ok`.
7. **Check.** Follow "Check the project against the carried version" in the administration document: read the project's configuration, the sprints' outside paths, the hook entries, the project's own rules files, and every tracked `CLAUDE.md` against the carried version, and sort each finding as that section says: a plan step, an `amend` draft, or a report line. Write each `amend` draft to a scratch path outside the project, one whole file per configuration file. The check writes nothing to the project.
8. **Hold the questions, the drafts, and the wiring.** Collect every `INPUT NEEDED` block and every `WIRING NEEDED` block the true-up printed after the plan ran, one per id. Hold each `amend` draft beside them. Act on none of them yet.

### 5. Settle the input questions and the check drafts — one message, then true up again

The core prints an `INPUT NEEDED` block for each answer only the owner can give. The block's first line names the layer and the question's id. `What:` says what is there. A `Draft:` line marks a question whose answer is a draft the session writes and the owner approves, and says what the draft must hold. `Fix:` says what the answer does. `On the owner's answer run:` gives the exact command.

1. **Draft.** For each block with a `Draft:` line, write the draft it describes to a scratch path outside the project, as the administration document's "Draft each answer this way" says. Change only what the block says must change, and keep every line and entry the block does not name exactly as it stands.
2. **Ask once.** Present every held block and every `amend` draft together in one message, as a plain-text list with one line per item: the id, what is there, and what the answer does; for an `amend` draft, the configuration file, each check finding in it, and the fix. Put each draft under its line, as a diff where it replaces a file. A question that asks for a value, such as the port range, asks for it there. Then ask once, in prose. The owner may answer all, some, or none.
3. **Apply.** For each answered question, run the command its block names, with `--from <draft path>` where the block carries a draft. For each accepted `amend` draft, run `bash "<payload>/admin/true-up" amend <config path> --from <draft path>`, where `<config path>` is `.ok-planner/config.json` or `.ok-planner/review/config.json`; the core prints `written: <path>`, or `amend: <reason>; nothing written` when it refuses the draft. Keep the id quoted as the block prints it, so a path with a space stays one argument. The core re-reads its questions and refuses an id it no longer holds; relay the refusal in the report. A core that refuses a draft says why: correct the draft, show it again, and ask about that item alone.
4. **True up again.** Where you applied any answer or draft, run diagnose again. Where its plan holds no destructive step, run the bare true-up; where an answer unblocked a step that is destructive, settle that plan as step 4 does, with the same one question. Settle any question the second run prints the same way, so the pass ends with the project trued up.

Record each declined question in the report as declined, not as drift. `/ok` asks it again on its next run, and its check drafts a declined finding again.

### 6. Wire the consented settings entries — by transcription only, once

Present every collected `WIRING NEEDED` block to the owner together, once. Each block carries the exact settings entry and the exact consent command that writes it: `bash "<payload>/admin/true-up" wire-hooks <group>` for a hook group (`session-start`, `subagents`, or `lint`, as the block names it) and `bash "<payload>/admin/true-up" wire-env` for the task-tools env entry. On the owner's yes, run the consent command each accepted block names; nothing else touches `.claude/settings.json`, and no entry or matcher is widened beyond the block presented. Each block is its own consent: the owner may take one and decline another. Record a declined entry as declined, not as drift. If any entry changed, remind the owner that hook and env changes take effect in the next session.

### 7. Report

```
ok — <project root>

| family | carried | vendored in project | outcome |
|---|---|---|---|
| ok-planner | v10.1.0 | v10.0.0 | trued up (vendored layer re-stamped to v10.1.0; .ok-plumbline/ migrated into .ok-planner/) |

<what was wired or declined, each input question answered or declined, and any migration performed>

<for each `archived:` line the core printed:> `<src>` archived at `<dst>`: no current skill reads it, and the archive keeps its bytes.

<for each `removed:` line the core printed:> `<path>` removed<, git rm; staged, where the line says so>: version history keeps it. <the core's `note:` line after it, verbatim>

<for each `rewrote:` line the core printed:> `<file>`: <the detail>.

<for each `filed:` line the core printed:> intake issue `<id>` filed: <the summary>.

<for each `blocked:` or `left:` line diagnose printed:> <that line verbatim>

<for each check finding:> check: `<file>` — <the finding>: <rewritten by true-up | pending true-up | written by amend | declined>

<for each report line the check wrote:> check: `<file>:<line>`: <the line> — <what the carried version names in its place>; the suite never edits this file, so the owner rewords it.

<if diagnose or true-up printed a `lint rules:` line, that line verbatim>

<for each retired verb removed:> `<name>` is gone; <its replacement, or "retired, with no replacement">.

<if any plugin was updated in step 1:> Plugin updates take effect after /reload-plugins or a session restart.
```

Name each removed verb's replacement from the retired-verb table in the administration document:

| retired | replaced by |
|---|---|
| `certify-work` | sprint certification, `/converge sprint <path>` |
| `verify-issues` | `/triage-issues` |
| `plan-sprint-code` | `/plan-sprint` |
| `converge-local`, `converge-cascade` | `/converge` |
| `audit`, `document` | retired |
| `certify-all` | retired |
| `ok-planner-audit`, `ok-plumbline-audit`, `ok-workspaces-audit`, `verify-corpus` | retired |
| `budget` | retired; turn a lint check off with `lint_checks` |
| `patterns` | retired |
| `version` | `/ok-version` |
| `execute-tasks` | the drain loop, which `/converge`, `/triage-issues`, and sprint execution read by path |
| `events`, `explain`, `port`, `starter`, `suggest`, `open`, `close`, `ok-workspaces`, `ok-planner`, `slug`, `ci` | retired |

The outcome reads `declined; stays on v<stamped>` where the owner aborted the plan, and the row's vendored column keeps the stamped version. Otherwise it reads `trued up` only when the check leaves nothing pending: every finding rewritten by true-up or written by `amend`. A declined draft, a plan step diagnose still lists, or a report line leaves its finding pending, and the outcome reads `trued up; check findings pending: <n>`.

**carried** is the suite version the resolved payload carries (the front-door manifest at `<payload>/../../.claude-plugin/plugin.json`, the manifest that payload's true-up stamps from); **vendored in project** is the version the vendored layer's stamps record here, `—` where the project has no vendored presence. The gap between the two columns is the useful signal, not an error. A retired verb removed by a true-up is the one user-visible break worth naming.

## Boundaries

- Administration only, always a user action. `/ok` never invokes a family verb — via the Skill tool or otherwise; `plan-sprint` and the rest are consumer surfaces for humans and implementation orchestrators. Nothing in the suite runs `/ok` from a hook.
- Improvises no family knowledge. Everything family-specific comes from the true-up core, the administration document, and the contract's discovery markers.
- Installs no plugins. The front door and the conduct are the only plugins; step 1 updates installed ones and does nothing else. The conduct (`ok-conduct`) is personal and user-scoped: `/ok` never installs, vendors, or offers it, and never treats its absence as a finding.
- Bootstraps only on consent (step 3); a decline means "not used here".
- Writes nothing the owner has not let proceed. A plan with a destructive step runs only on the owner's go-ahead, through the core's `--go-ahead <plan id>`; an abort writes nothing.
- Edits no file itself. All writes happen inside the true-up core. Hook wiring goes only through the consented `wire-hooks <group>` and `wire-env` transcriptions. An input question's answer goes only through the core's `resolve` mode, and a check finding's fix in the project's configuration only through its `amend` mode; every draft the owner approved reaches the project through the go-ahead or one of those modes from a scratch path outside it.
