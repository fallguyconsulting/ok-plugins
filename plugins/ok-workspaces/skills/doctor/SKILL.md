---
name: doctor
description: "ONLY activated by explicit /doctor slash command or driven by ok-doctor. Never auto-triggered by conversation content."
---

# Doctor — ok-workspaces Estate Upkeep

Read-only drift report per the ok-plugins integration contract. Drift is reality disagreeing with declaration, on two axes: **project drift** (a fresh detection scan no longer matches the committed profile — e.g. Docker was introduced after the project materialized as dev-server) and **version drift** (materialized artifacts older than, or diverging from, what the installed plugin would write).

## Run

```bash
node "${CLAUDE_PLUGIN_ROOT}/scripts/doctor.js"
```

The script checks: the profile exists and parses; detected stacks and runtime match the declared ones; the src-tag script at the profile-declared path is byte-identical to the canonical version for the installed plugin; the cheatsheet exists and its version stamp matches. Exit 0 clean, 2 drift. Relay the report verbatim.

When stacks or runtime drifted, the remedy has a human step: the owner reconciles `.ok-workspaces/config.json` with the new reality (or rejects the detected signal as noise), then `/affirm` re-materializes. Doctor never edits the profile — declaring is the owner's act.

This skill writes nothing, ever, and never drives workspace work — compliance sweeps are `/audit`, workspace lifecycle is `/open`/`/close`.
