---
name: true-up
description: "True up the Plumbline presence in this project: diagnose the installation (config present and valid, cheatsheet committed, vendored binary/hook/skills current, hook wiring in .claude/settings.json), then converge — create `.ok-plumbline/` (migrating a root `.plumbline.json` from an earlier layout into it), write/overwrite the cheatsheet, vendor the binary, the edit hook, and the skills, and with no config, walk the owner through declaring one from the starter's detection in conversation. Hook wiring is written only on the owner's consent. Idempotent — a project already in compliance is a silent no-op. Plumbing — normally driven by /ok or the project's merged true-up verb; also user-invokable via that merged verb."
---

# /ok-plumbline:true-up

Bring the project's Plumbline estate into agreement with the installed plugin. Diagnose first (read-only, via the lint binary's `diagnose` subcommand), then converge what the plugin owns — the dot-directory layout and the cheatsheet are plugin-owned, converged without prompting. The config's *contents* are owner-declared: never invented or edited by the skill's own judgment. Declaring, per the integration contract, happens in conversation — with no config, the skill walks the owner through the starter's detected proposal and transcribes their answers; it never sends them away to hand-edit a file unless they ask to.

## 1. Diagnose

```bash
# The plugin's copy, deliberately: diagnose runs before §4b vendors anything,
# and its job is to compare the project against the version being installed.
# true-up is the one entry point that legitimately executes from the plugin
# root — everything else runs the project's vendored binary.
node "${CLAUDE_PLUGIN_ROOT%/}/bin/plumbline" diagnose .
```

Checks: the config (`.ok-plumbline/config.json`, or a root `.plumbline.json` from an earlier layout) exists and parses cleanly (and how many citation tags are declared, and whether it still carries the retired `checks` key — both checks always run); `.claude/rules/plumbline-cheatsheet.md` is committed; the budget baseline (`.ok-plumbline/budget.json`, or a root `.plumbline-budget.json` from an earlier layout — optional, only reports its existence and location); `.claude/settings.json` lists the plumbline plugin under `enabledPlugins`.

## 2. Identify overlapping project context

Per the integration contract, diagnose must surface preexisting project guidance that overlaps Plumbline's territory before converging. Scan `.claude/rules/` and the repo's conventional doc locations (root and `docs/`) for coding-style / comment-policy / lint-convention documents that are not plugin-materialized (no version stamp) — e.g. a hand-written style guide, a CONTRIBUTING section on comments, an alternate lint cheatsheet. For each hit, **propose a conversion plan** for the owner's consent: fold enforceable rules into the plumbline config (`citations`, `ignore`), keep the rest as a project-specific rules file alongside the cheatsheet, or retire the document. Never convert, edit, or delete such context silently — and never skip surfacing it.

## 3. Converge the estate

The dot-directory is the integration marker and the config's home. Creating it, and relocating a root-level config or budget baseline from an earlier layout into it, are mechanical layout moves the plugin owns — the files' contents are never altered:

```bash
set -euo pipefail

mkdir -p .ok-plumbline

if [ -f .plumbline.json ] && [ ! -f .ok-plumbline/config.json ]; then
  git mv .plumbline.json .ok-plumbline/config.json 2>/dev/null || mv .plumbline.json .ok-plumbline/config.json
  echo "config migrated: .plumbline.json -> .ok-plumbline/config.json"
elif [ -f .plumbline.json ] && [ -f .ok-plumbline/config.json ]; then
  echo "CONFLICT: both .ok-plumbline/config.json and root .plumbline.json exist — ask the owner which is authoritative"
fi

if [ -f .plumbline-budget.json ] && [ ! -f .ok-plumbline/budget.json ]; then
  git mv .plumbline-budget.json .ok-plumbline/budget.json 2>/dev/null || mv .plumbline-budget.json .ok-plumbline/budget.json
  echo "budget baseline migrated: .plumbline-budget.json -> .ok-plumbline/budget.json"
elif [ -f .plumbline-budget.json ] && [ -f .ok-plumbline/budget.json ]; then
  echo "CONFLICT: both .ok-plumbline/budget.json and root .plumbline-budget.json exist — ask the owner which is authoritative"
fi
```

The binary reads `.ok-plumbline/config.json` first and falls back to a root-level .plumbline.json from an earlier layout, and the budget check reads both baseline locations the same way, so a not-yet-migrated project keeps working. A both-exist conflict is the one owner-consent case: never pick silently.

## 4. Converge what's owned

Materialize the cheatsheet — the file every Claude Code session in this project will read as the project's coding rules. The plugin owns its contents; the project commits the materialized file (so contributors without the plugin still see the rules). Local edits to it are overwritten without prompting; project-specific rules additions belong in separate files under `.claude/rules/` — those are never touched.

The materialized copy is version-stamped: the canonical doc carries the `{{OK_PLUMBLINE_VERSION}}` placeholder, the copy carries the plugin version that wrote it, and the sync check compares against the stamped rendering — never the raw canonical bytes.

```bash
set -euo pipefail

canonical="${CLAUDE_PLUGIN_ROOT%/}/docs/plumbline-cheatsheet.md"

if [ ! -f "$canonical" ]; then
  echo "error: canonical cheatsheet not found at $canonical" >&2
  exit 1
fi

plugin_version=$(sed -n 's/.*"version"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' \
  "${CLAUDE_PLUGIN_ROOT%/}/.claude-plugin/plugin.json" | head -1)
[ -n "$plugin_version" ] || plugin_version="unknown"

mkdir -p .claude/rules
target=".claude/rules/plumbline-cheatsheet.md"
rendered=$(mktemp)
sed "s/{{OK_PLUMBLINE_VERSION}}/${plugin_version}/g" "$canonical" > "$rendered"

if [ -f "$target" ] && cmp -s "$rendered" "$target"; then
  rm -f "$rendered"
  echo "plumbline-cheatsheet.md already in sync"
  exit 0
fi

existed=false
[ -f "$target" ] && existed=true
mv "$rendered" "$target"
if [ "$existed" = true ]; then
  echo "plumbline-cheatsheet.md updated"
else
  echo "plumbline-cheatsheet.md created"
fi
```

## 4b. Vendor the binary and the hook

The lint binary and the PostToolUse hook are **executable machinery**, which the integration contract requires the plugin to materialize project-side. Vendoring pins them to the version this owner converged to: updating the installed plugin no longer changes what lints in any other project, an active session is unaffected by edits to the plugin checkout, and CI can run the linter with no Claude Code installed at all.

Both are plugin-owned whole files — overwritten wholesale, never hand-edited. The binary's `VERSION` line is stamped during the copy; a copy still reporting `0.0.0-unvendored` is the plugin's own, not a project's pinned one.

```bash
set -euo pipefail

plugin_version=$(sed -n 's/.*"version"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' \
  "${CLAUDE_PLUGIN_ROOT%/}/.claude-plugin/plugin.json" | head -1)
[ -n "$plugin_version" ] || plugin_version="unknown"

mkdir -p .ok-plumbline/bin .ok-plumbline/hooks

sed "s/^const VERSION = '0\.0\.0-unvendored';\$/const VERSION = '${plugin_version}';/" \
  "${CLAUDE_PLUGIN_ROOT%/}/bin/plumbline" > .ok-plumbline/bin/plumbline
chmod 755 .ok-plumbline/bin/plumbline

sed "s/{{OK_PLUMBLINE_VERSION}}/${plugin_version}/g" \
  "${CLAUDE_PLUGIN_ROOT%/}/scripts/hooks/post-edit.js" > .ok-plumbline/hooks/post-edit.js
chmod 755 .ok-plumbline/hooks/post-edit.js

# A vendored binary that cannot run is worse than none — the hook would
# silently skip. Prove it executes and reports the stamped version.
node .ok-plumbline/bin/plumbline version

echo "vendored: .ok-plumbline/bin/plumbline + .ok-plumbline/hooks/post-edit.js (v${plugin_version})"
```

## 4c. Vendor the skills

Materialize Plumbline's user-facing skills into the project's committed skills directory, per the integration contract's vendored-skills layer: version-stamped, sibling references rewritten to the materialized names, the `audit` verb plugin-prefixed as `ok-plumbline-audit` under the contract's collision rule, and the merged lifecycle verb written once to `.claude/skills/true-up/SKILL.md`.

```bash
# The plugin's copy, deliberately: vendoring fetches from the installed
# plugin — that copy is the vendor source, and the ref it was written from
# is recorded in each file's stamp.
node "${CLAUDE_PLUGIN_ROOT%/}/bin/plumbline" vendor-skills .
```

## 4d. Wire the hook — consent, then transcription

The edit hook executes from the project's own materialized copy at `.ok-plumbline/hooks/post-edit.js`, reached through a `PostToolUse` entry in `.claude/settings.json` — owner-declared configuration, written **only** as transcription of the owner's explicit yes. The diagnose in step 1 reports a missing or drifted entry as a `WIRING NEEDED` block carrying the exact entry and the exact consent command.

- Driven by `/ok` or the project's merged true-up verb: pass the block up verbatim — the caller presents all plugins' wiring once and runs each consent command on the owner's yes.
- Invoked directly: present the block, ask, and on yes run the command it names (`plumbline wire-hooks .`). Declined means declined — record it in the report and write nothing.

## 5. Report what needs the owner

For each remaining diagnosis failure or warning — these require judgment or project-owned changes, so they are reported with a remedy, never fixed here:

- **Missing config**: declare one with the owner, in conversation. Run the starter's detection and hold its output — never park it in a file and leave:

  ```bash
  node "${CLAUDE_PLUGIN_ROOT%/}/bin/plumbline" starter .
  ```

  Present the detected config compactly — both checks always run (plumbline is strict by default; there is no soft start and no disable switch), which citation tags it wires (e.g. ok-planner's `@concept:`/`@story:`/`@decision:` when `.ok-planner/` is present), which dirs it ignores — and ask. When detection is unambiguous and the owner has nothing to add, that's one yes/no: "declare this as `.ok-plumbline/config.json`?" Where there are judgment calls (extra citation tags, generated dirs the heuristic missed), settle them in dialogue. On consent, write the result to `.ok-plumbline/config.json` exactly as agreed — transcription of explicit answers, never a field the owner didn't confirm. If the owner prefers to hand-edit, print the proposal and stop as before.
- **Plugin not enabled**: walk the user through `/plugin marketplace add ...` and `claude plugin install ok-plumbline@ok-plugins`.
- **Malformed config**: surface the parse error and propose the fix.

Report whether the cheatsheet was created, updated, or already in sync, whether a config was declared, plus any findings above.
