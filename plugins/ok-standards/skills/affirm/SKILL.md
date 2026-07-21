---
name: affirm
description: Affirm the Plumbline rules in this project. Creates `.claude/rules/` if absent and writes/overwrites `.claude/rules/plumbline-cheatsheet.md` to match the plugin's canonical cheatsheet. Idempotent — a project already in compliance is a silent no-op.
---

# /ok-standards:affirm

Materialize the Plumbline cheatsheet into the current project as `.claude/rules/plumbline-cheatsheet.md` — the file every Claude Code session in this project will read as the project's coding rules.

The plugin owns the cheatsheet's contents; the project commits the materialized file (so contributors without the plugin still see the rules). Re-run `/ok-standards:affirm` after a plugin upgrade to pull in the latest canonical version.

## What this does

1. Verify the canonical source ships with the plugin at `$CLAUDE_PLUGIN_ROOT/docs/plumbline-cheatsheet.md`.
2. Create the `.claude/rules/` directory in the current project root if absent.
3. Overwrite `.claude/rules/plumbline-cheatsheet.md` with the canonical contents.
4. Report whether the file was created, updated, or already in sync.

The rules file is skill-owned boilerplate. Local edits to `.claude/rules/plumbline-cheatsheet.md` are overwritten without prompting. Place project-specific rules additions in separate files under `.claude/rules/` — those are never touched.

## Run

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
