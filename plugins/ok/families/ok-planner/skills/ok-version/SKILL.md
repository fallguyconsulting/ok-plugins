---
name: ok-version
description: "ONLY activated by explicit /ok-version slash command. Never auto-triggered by conversation content. Shows the ok-planner plugin version and the conduct version governing this session beside the stamp on the project's vendored layer; no drift verdict."
---

# ok-planner version check

Read-only. Shows the ok-planner plugin version and the `ok-conduct` conduct version that **this session** is running, side by side with the version stamped on this project's vendored layer. No verdict: if a version is not what you expect, investigate from there (e.g. `/reload-plugins` then `/clear`, `/ok`, or a fresh session).

## Procedure

### 1. Governing plugin version

Read it from the ok-planner `SessionStart` hook's injected context line, which has the form `ok-planner vX.Y.Z is materialized in this project`. Report the `X.Y.Z`. If that line is not present in this session, as when the owner declined the session-start hook wiring, read the project rules the session loaded at its start instead: find the line `Materialized by ok-planner v<X.Y.Z>` in a suite rules file under `.claude/rules/` (such as `ok-cheatsheet.md`) as it appears in your context, and report that `X.Y.Z`. Take it from your context, never from the file on disk: an `/ok` run during this session rewrites the file and leaves the loaded copy as it was. If neither source is present, report `unknown`. Both sources are written by the vendored layer the session started with, so the value equals the vendored stamp (step 2) unless an `/ok` run converged the project during this session.

### 2. Vendored-layer stamp

Read `.ok-planner/CLAUDE.md` at the project root and find the line `Materialized by ok-planner v<X.Y.Z>`. Report the `X.Y.Z`. If the file is absent or carries no such line, report `—`.

### 3. Governing conduct version

Look at your own active **Output Style** instructions — the conduct currently in your system prompt — and find the line that begins `Conduct version:`. Report it verbatim. This is the conduct **actually governing the session**, which is why it comes from the output style rather than the session-start line. If there is no such line, report `unstamped` (no `ok-conduct` style is active, or it predates version stamping).

### 4. Report

Print exactly these three lines, in this order, filling in the values:

- **Plugin version (governing this session):** `<X.Y.Z or unknown>`
- **Vendored layer (this project's stamp):** `<X.Y.Z or —>`
- **Conduct version (governing this session):** `<verbatim, or unstamped>`

This skill never edits files, never chains to another skill, and gives no verdict. Report and stop.
