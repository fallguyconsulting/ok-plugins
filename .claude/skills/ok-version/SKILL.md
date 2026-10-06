---
name: ok-version
description: "ONLY activated by explicit /ok-version slash command. Never auto-triggered by conversation content. Shows the ok-planner plugin version and the conduct version governing this session beside the installed plugin version, the installed conduct version, and the stamp on the project's vendored layer; no drift verdict."
---

# ok-planner version check

Read-only. Shows the ok-planner plugin version and the `ok-conduct` conduct version that **this session** is running, side by side with the ok plugin version installed for this user, the conduct version installed for this user, and the version stamped on this project's vendored layer. No verdict: if a version is not what you expect, investigate from there (e.g. `/reload-plugins` then `/clear`, `/ok`, or a fresh session).

## Procedure

### 1. Governing plugin version

Read it from the ok-planner `SessionStart` hook's injected context line, which has the form `ok-planner vX.Y.Z is materialized in this project`. Report the `X.Y.Z`. If that line is not present in this session, report `unknown`. The project's vendored hook writes this line at session start, so it equals the vendored stamp (step 3) unless an `/ok` run converged the project during this session.

### 2. Installed plugin version

Run `claude plugin list --json` once; steps 2 and 5 both read its output. It lists one entry per install, and installs scoped to other projects appear in it too. An entry applies to this session when its `projectPath` equals this project's root, or when its `scope` is `user`. Skip every entry whose `projectPath` names another folder. Where both an entry for this project and a `user` entry apply to one plugin, take the entry for this project.

Take the applying entry whose `id` begins `ok@` and report its `version`. If the command fails or no entry applies, report `unknown`. `list` is read-only; never run `claude plugin update`, `install`, or `marketplace update` from this skill.

### 3. Vendored-layer stamp

Read `.ok-planner/CLAUDE.md` at the project root and find the line `Materialized by ok-planner v<X.Y.Z>`. Report the `X.Y.Z`. If the file is absent or carries no such line, report `—`.

### 4. Governing conduct version

Look at your own active **Output Style** instructions — the conduct currently in your system prompt — and find the line that begins `Conduct version:`. Report it verbatim. This is the conduct **actually governing the session**, which is why it comes from the output style rather than the session-start line. If there is no such line, report `unstamped` (no `ok-conduct` style is active, or it predates version stamping).

### 5. Installed conduct version

Take the applying entry from step 2's output whose `id` begins `ok-conduct@`, by the same rule. Read `output-styles/ok-conduct.md` under its `installPath` and find the line that begins `Conduct version:`. Report the rest of that line verbatim. If the command failed, no entry applies, or the file is absent or carries no such line, report `unknown`. Never take this value from the ok-conduct `SessionStart` hook's injected line: that line records what was installed when the session started, and a `claude plugin update` during the session leaves it stale.

### 6. Report

Print exactly these five lines, in this order, filling in the values:

- **Plugin version (governing this session):** `<X.Y.Z or unknown>`
- **Plugin version (installed):** `<X.Y.Z or unknown>`
- **Vendored layer (this project's stamp):** `<X.Y.Z or —>`
- **Conduct version (governing this session):** `<verbatim, or unstamped>`
- **Conduct version (installed):** `<verbatim, or unknown>`

This skill never edits files, never chains to another skill, and gives no verdict. Report and stop.

<!-- Materialized by ok-planner v25.2.0 — suite-owned; overwritten on converge; do not hand-edit. -->
