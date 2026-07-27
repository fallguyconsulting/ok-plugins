---
name: true-up
description: "The project's merged lifecycle verb: diagnose and converge every integrated ok-plugin's presence — estate, cheatsheet, vendored skills, hook wiring — toward what the installed plugins declare. Plumbing — normally driven by /ok; also user-invokable as /true-up."
---

# /true-up — the merged lifecycle verb

Converging the whole integrated set is a single act. This skill is materialized project-side and carries only the integration contract's two conventions — discovery markers and the uniform lifecycle verb — never any plugin's internals. Each plugin's own true-up (in the installed plugin) is the vendor source and the authority on its own estate; this verb drives them all once.

## 1. Discover the integrated set

Resolve the project root: the nearest `.git` ancestor of the working directory, else the working directory itself. A plugin `ok-<name>` is integrated iff its discovery markers exist at that root — its dot-directory `.ok-<name>/`, or any pre-migration marker the integration contract documents (currently: ok-plumbline is also integrated iff a root `.plumbline.json` exists or `.claude/rules/plumbline-cheatsheet.md` does). A filesystem check, never an inference.

## 2. Drive each integrated plugin's own true-up

For each integrated plugin, sequentially, invoke `<plugin>:true-up` via the Skill tool. That skill diagnoses, proposes any migration or conflict resolution for the owner's consent, converges what the plugin owns — estate, cheatsheet, vendored skills, materialized scripts and hooks, all fetched from the installed plugin copy — and reports.

- If the skill is unavailable (the plugin is not installed on this machine), record status `not-installed` with remedy `claude plugin install <plugin>@ok-plugins`, and continue with the next plugin. The project keeps running on its committed vendored layer; only converging to a newer version needs the plugin.
- Relay each plugin's consent questions verbatim, collect the owner's answer, and let that plugin's true-up finish before moving to the next.
- Never reinterpret, filter, or re-derive a plugin's findings. The plugin's true-up is the authority on its own estate.

## 3. Wire the hooks — by consented transcription only

Plugins whose behavior includes hooks execute them from the project's own materialized copies, reached through entries in `.claude/settings.json` — owner-declared configuration written only as transcription of explicit answers. Each plugin's diagnose reports a missing or drifted entry as a `WIRING NEEDED` block carrying the exact entry and the exact consent command that writes it.

Collect every such block from step 2 and present them to the owner **once**, together. On the owner's yes, run the consent command each block names — nothing else touches `.claude/settings.json`, and no entry or matcher is ever widened beyond the block presented. A declined entry is recorded in the report as declined, not as drift.

## 4. Report

One line per plugin: converged / clean / waiting on owner (with what) / not-installed (with remedy), plus what was wired or declined. If any hook entry changed, remind the owner that hook changes take effect in the next session.

<!-- Materialized by the ok suite v10.0.0 — plugin-owned; overwritten by the true-up verb; do not hand-edit. -->
