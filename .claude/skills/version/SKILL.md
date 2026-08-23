---
name: version
description: "ONLY activated by explicit /version slash command. Never auto-triggered by conversation content. Print the plumbline version this project lints with, and the carried payload's."
---

# /version

Echo the plumbline version **this project** lints with — its vendored binary — alongside the carried payload's. They differ whenever the installed front door has moved ahead of the project's last converge, and that gap is the useful signal: the project keeps linting at its pinned version until the owner converges deliberately.

## Run

```bash
bin=".ok-plumbline/bin/plumbline"
if [ -x "$bin" ]; then
  echo "project (vendored): $(node "$bin" version)"
else
  echo "project (vendored): none — /ok pins one to this project"
fi
payload="${CLAUDE_PLUGIN_ROOT:-plugins/ok}/families/ok-plumbline/bin/plumbline"
if [ -x "$payload" ]; then
  echo "carried payload:    $(node "$payload" version)"
else
  echo "carried payload:    none — the ok front door is not installed on this machine"
fi
```

## After the script runs

A payload copy reporting `0.0.0-unvendored` is expected: that placeholder is stamped with the real version only when converge vendors the binary into a project. A payload line reading `none` means the front door is not installed on this machine — the project still lints at its own pinned version.

<!-- Materialized by ok-plumbline v19.0.0 — suite-owned; overwritten on converge; do not hand-edit. -->
