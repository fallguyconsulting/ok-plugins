---
name: version
description: "ONLY activated by explicit /ok-plumbline:version slash command. Never auto-triggered by conversation content. Print the plumbline version this project lints with, and the installed plugin's."
---

# /ok-plumbline:version

Echo the plumbline version **this project** lints with — its vendored binary — alongside the installed plugin's. They differ whenever the plugin has moved ahead of the project's last true-up, and that gap is the useful signal: the project keeps linting at its pinned version until the owner converges deliberately.

## Run

```bash
bin=".ok-plumbline/bin/plumbline"
if [ -x "$bin" ]; then
  echo "project (vendored): $(node "$bin" version)"
else
  echo "project (vendored): none — /ok-plumbline:true-up pins one to this project"
fi
echo "installed plugin:   $(node "${CLAUDE_PLUGIN_ROOT%/}/bin/plumbline" version)"
```

A plugin copy reporting `0.0.0-unvendored` is expected: that placeholder is stamped with the real version only when true-up vendors the binary into a project.
