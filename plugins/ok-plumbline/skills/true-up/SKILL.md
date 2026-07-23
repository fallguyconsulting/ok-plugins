---
name: true-up
description: "True up the Plumbline estate in this project: diagnose the installation (config present and valid, cheatsheet committed, plugin enabled, budget baseline if used), then converge — create `.ok-plumbline/` (migrating a root `.plumbline.json` from an earlier layout into it), write/overwrite `.claude/rules/plumbline-cheatsheet.md` to match the plugin's canonical cheatsheet, and with no config, walk the owner through declaring one from the starter's detection in conversation. Idempotent — a project already in compliance is a silent no-op. Plumbing — normally driven by /ok; also user-invokable as /true-up."
---

# /ok-plumbline:true-up

Bring the project's Plumbline estate into agreement with the installed plugin. Diagnose first (read-only, via the lint binary's `diagnose` subcommand), then converge what the plugin owns — the dot-directory layout and the cheatsheet are plugin-owned, converged without prompting. The config's *contents* are owner-declared: never invented or edited by the skill's own judgment. Declaring, per the integration contract, happens in conversation — with no config, the skill walks the owner through the starter's detected proposal and transcribes their answers; it never sends them away to hand-edit a file unless they ask to.

## 1. Diagnose

```bash
node "${CLAUDE_PLUGIN_ROOT%/}/bin/plumbline" diagnose .
```

Checks: the config (`.ok-plumbline/config.json`, or a root `.plumbline.json` from an earlier layout) exists and parses cleanly (and how many checks are enabled, and how many citation tags are declared); `.claude/rules/plumbline-cheatsheet.md` is committed; `.plumbline-budget.json` baseline file (optional — only reports its existence); `.claude/settings.json` lists the plumbline plugin under `enabledPlugins`.

## 2. Identify overlapping project context

Per the integration contract, diagnose must surface preexisting project guidance that overlaps Plumbline's territory before converging. Scan `.claude/rules/` and the repo's conventional doc locations (root and `docs/`) for coding-style / comment-policy / lint-convention documents that are not plugin-materialized (no version stamp) — e.g. a hand-written style guide, a CONTRIBUTING section on comments, an alternate lint cheatsheet. For each hit, **propose a conversion plan** for the owner's consent: fold enforceable rules into the plumbline config (`checks`, `citations`, `ignore`), keep the rest as a project-specific rules file alongside the cheatsheet, or retire the document. Never convert, edit, or delete such context silently — and never skip surfacing it.

## 3. Converge the estate

The dot-directory is the integration marker and the config's home. Creating it, and relocating a root-level config from an earlier layout into it, are mechanical layout moves the plugin owns — the config's contents are never altered:

```bash
set -euo pipefail

mkdir -p .ok-plumbline

if [ -f .plumbline.json ] && [ ! -f .ok-plumbline/config.json ]; then
  git mv .plumbline.json .ok-plumbline/config.json 2>/dev/null || mv .plumbline.json .ok-plumbline/config.json
  echo "config migrated: .plumbline.json -> .ok-plumbline/config.json"
elif [ -f .plumbline.json ] && [ -f .ok-plumbline/config.json ]; then
  echo "CONFLICT: both .ok-plumbline/config.json and root .plumbline.json exist — ask the owner which is authoritative"
fi
```

The binary reads `.ok-plumbline/config.json` first and falls back to a root-level .plumbline.json from an earlier layout, so a not-yet-migrated project keeps working. A both-exist conflict is the one owner-consent case: never pick silently.

## 4. Converge what's owned

Materialize the cheatsheet — the file every Claude Code session in this project will read as the project's coding rules. The plugin owns its contents; the project commits the materialized file (so contributors without the plugin still see the rules). Local edits to it are overwritten without prompting; project-specific rules additions belong in separate files under `.claude/rules/` — those are never touched.

```bash
set -euo pipefail

canonical="${CLAUDE_PLUGIN_ROOT%/}/docs/plumbline-cheatsheet.md"

if [ ! -f "$canonical" ]; then
  echo "error: canonical cheatsheet not found at $canonical" >&2
  exit 1
fi

mkdir -p .claude/rules
target=".claude/rules/plumbline-cheatsheet.md"

if [ -f "$target" ]; then
  if cmp -s "$canonical" "$target"; then
    echo "plumbline-cheatsheet.md already in sync"
    exit 0
  fi
  cp "$canonical" "$target"
  echo "plumbline-cheatsheet.md updated"
  exit 0
fi

cp "$canonical" "$target"
echo "plumbline-cheatsheet.md created"
```

## 5. Report what needs the owner

For each remaining diagnosis failure or warning — these require judgment or project-owned changes, so they are reported with a remedy, never fixed here:

- **Missing config**: declare one with the owner, in conversation. Run the starter's detection and hold its output — never park it in a file and leave:

  ```bash
  node "${CLAUDE_PLUGIN_ROOT%/}/bin/plumbline" starter .
  ```

  Present the detected config compactly — which checks it enables (plumbline is strict by default; there is no soft start), which citation tags it wires (e.g. ok-planner's `@concept:`/`@story:`/`@decision:` when `.ok-planner/` is present), which dirs it ignores — and ask. When detection is unambiguous and the owner has nothing to add, that's one yes/no: "declare this as `.ok-plumbline/config.json`?" Where there are judgment calls (extra citation tags, generated dirs the heuristic missed), settle them in dialogue. On consent, write the result to `.ok-plumbline/config.json` exactly as agreed — transcription of explicit answers, never a field the owner didn't confirm. If the owner prefers to hand-edit, print the proposal and stop as before.
- **Plugin not enabled**: walk the user through `/plugin marketplace add ...` and `claude plugin install ok-plumbline@ok-plugins`.
- **Malformed config**: surface the parse error and propose the fix.

Report whether the cheatsheet was created, updated, or already in sync, whether a config was declared, plus any findings above.
