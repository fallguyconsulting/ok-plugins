---
name: ok-version
description: "ONLY activated by explicit /ok-version slash command. Never auto-triggered by conversation content."
---

# ok-planner version check

Read-only. Recites the ok-planner plugin version and the `ok-conduct` conduct version that **this session** is running. No disk read, no comparison, no verdict — if a version is not what you expect, investigate from there (e.g. `/reload-plugins` then `/clear`, or a fresh session).

## Procedure

### 1. Plugin version

Read it from the `SessionStart` hook's injected context line, which has the form `ok-planner vX.Y.Z (conduct ...) is available`. Report the `X.Y.Z`. If that line is not present in this session, report the plugin version as `unknown`.

### 2. Conduct version

Look at your own active **Output Style** instructions — the conduct currently in your system prompt — and find the line that begins `Conduct version:`. Report it verbatim. This is the conduct **actually governing the session**, which is why it comes from the output style rather than the session-start line. If there is no such line, report `unstamped` (no `ok-conduct` style is active, or it predates version stamping).

### 3. Report

Print exactly these two lines, filling in the values:

- **Plugin version (this session):** `<X.Y.Z or unknown>`
- **Conduct version (this session):** `<verbatim, or unstamped>`

This skill never reads from disk, never edits files, and never chains to another skill. Report and stop.
