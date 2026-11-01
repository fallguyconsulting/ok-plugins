---
name: ok-version
description: "ONLY activated by explicit /ok-version slash command. Never auto-triggered by conversation content. Shows the installed ok plugin version and the conduct version governing this session beside the stamp on the project's vendored layer; no drift verdict."
---

# ok-planner version check

Read-only. Shows the installed ok plugin version and the `ok-conduct` conduct version that **this session** is running, side by side with the version stamped on this project's vendored layer. No verdict: if a version is not what you expect, investigate from there (e.g. `/reload-plugins` then `/clear`, `/ok`, or a fresh session).

## Procedure

### 1. Installed plugin version

Run `claude plugin list --json`, take the entry whose `id` is `ok@ok-plugins` and whose `scope` is `user`, and report its `version`. Where the command fails, lists no such entry, or the entry carries no `version`, read the `version` of the user-scoped entry under `plugins["ok@ok-plugins"]` in `~/.claude/plugins/installed_plugins.json` and report it. If neither source names a version, report `unknown`. Both reads change nothing. The installed version can differ from the version loaded in this session until `/reload-plugins` or a restart, and from the vendored stamp (step 2) until an `/ok` run trues up the project.

### 2. Vendored-layer stamp

Read `.ok-planner/CLAUDE.md` at the project root and find the line `Materialized by ok-planner v<X.Y.Z>`. Report the `X.Y.Z`. If the file is absent or carries no such line, report `—`.

### 3. Governing conduct version

Look at your own active **Output Style** instructions — the conduct currently in your system prompt — and find the line that begins `Conduct version:`. Report it verbatim. This is the conduct **actually governing the session**, which is why it comes from the output style rather than the session-start line. If there is no such line, report `unstamped` (no `ok-conduct` style is active, or it predates version stamping).

### 4. Report

Print exactly these three lines, in this order, filling in the values:

- **Plugin version (installed ok plugin):** `<X.Y.Z or unknown>`
- **Vendored layer (this project's stamp):** `<X.Y.Z or —>`
- **Conduct version (governing this session):** `<verbatim, or unstamped>`

This skill never edits files, never chains to another skill, and gives no verdict. Report and stop.

<!-- Materialized by ok-planner v30.0.0 — suite-owned; overwritten on true-up; do not hand-edit. -->
