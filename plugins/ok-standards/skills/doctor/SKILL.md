---
name: doctor
description: Diagnose the Plumbline installation in the current project — config present and valid, cheatsheet committed, plugin enabled, budget baseline if used. Reports each check with a status indicator.
---

# /ok-standards:doctor

Run health checks against the Plumbline setup in the current project.

## What this does

- `.plumbline.json` exists and parses cleanly (and how many checks are enabled, and how many citation tags are declared)
- `.claude/rules/plumbline-cheatsheet.md` is committed
- `.plumbline-budget.json` baseline file (optional — only reports its existence)
- `.claude/settings.json` lists the plumbline plugin under `enabledPlugins`

## Run

```bash
node "${CLAUDE_PLUGIN_ROOT%/}/bin/plumbline" doctor .
```

## After the script runs

For each failure or warning:

- **Missing .plumbline.json**: suggest `/ok-standards:starter` to generate a project-shaped one.
- **Missing cheatsheet**: suggest `/ok-standards:affirm` to materialize it.
- **Plugin not enabled**: walk the user through `/plugin marketplace add ...` and `/plugin install plumbline@fallguy`.
- **Malformed config**: surface the parse error and propose the fix.

The skill never modifies files — it reports state and recommends actions.
