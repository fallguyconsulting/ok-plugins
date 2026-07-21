---
name: affirm
description: "Affirm the ok-workspaces estate: with no committed profile, run detection and write a proposal for the owner to review; with a profile, materialize the src-tag script and cheatsheet from it (version-stamped, plugin-owned, overwritten wholesale). Idempotent. User-invokable as /affirm; also driven by ok-doctor."
---

# Affirm ok-workspaces estate

Two modes, decided by whether `.ok-workspaces/config.json` exists at the project root.

## Mode 1 — no committed profile: detect and propose

```bash
node "${CLAUDE_PLUGIN_ROOT}/scripts/detect.js"
```

Write the output to `.ok-workspaces/config.proposed.json` (create the directory). Then **stop and tell the owner**: review the proposal, adjust it (stacks, runtime, worktree naming, src-tag path, compose prefix / port scheme), and commit it as `.ok-workspaces/config.json`. Detection proposes; only the committed file is authoritative. Do not promote the proposal yourself — declaring the profile is the owner's act.

If the project already uses an equivalent script (e.g. an existing content-addressed tag script wired into its build), point the profile's `srcTag.path` at that script's path so affirm materializes the canonical version there and existing consumers keep working.

## Mode 2 — profile present: materialize

```bash
node "${CLAUDE_PLUGIN_ROOT}/scripts/affirm.js"
```

The script materializes, from the profile:

- The canonical src-tag script at `srcTag.path` (default `.ok-workspaces/bin/src-tag`), executable, version-stamped.
- `.claude/rules/ok-workspaces-cheatsheet.md` — the three rules with the profile's concrete mechanics substituted (compose project prefix, port scheme, script path), version-stamped.

Both are plugin-owned whole files, overwritten wholesale — never merged, never hand-edited. Pass the script's one-line summary back as your response.

## What this skill does NOT do

- Does not decide the profile. It proposes (mode 1) or obeys (mode 2).
- Does not touch `.gitignore`, compose files, Makefiles, or any project-owned file — wiring the src-tag script into builds/harnesses is the project's own change, guided by the cheatsheet.
- Does not create worktrees or stacks — that's `/open`.
