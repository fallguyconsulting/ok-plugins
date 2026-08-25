---
name: patterns
description: "ONLY activated by explicit /patterns slash command. Never auto-triggered by conversation content. Cluster Plumbline lint violations by shape so a hundred similar violations surface as one cluster with a proposed bulk fix. Read-only — proposes, does not apply."
---

# /patterns

Run the Plumbline lint and group violations by shared shape so cleanup can target classes of problems at once instead of one violation at a time.

## What this does

1. Runs `plumbline patterns .` from the project root.
2. The binary clusters violations:
   - `citation-unresolved` violations cluster by tag (`tag:@concept:`, `tag:@story:`, ...).
   - `comment-hygiene` violations cluster by shape (`divider`, `license-fragment`, `todo-marker`, `commented-out-code`, `doc-residue`, `disallowed-prose`).
3. Prints each cluster with count + up to three example sites.

## Run

```bash
# Prefer the project's vendored binary — clustering must reflect the rules this
# project lints against.
bin=".ok-plumbline/bin/plumbline"
if [ ! -x "$bin" ]; then
  bin="${CLAUDE_PLUGIN_ROOT:-plugins/ok}/families/ok-plumbline/bin/plumbline"
  echo "note: no vendored binary — using the payload's copy; /ok pins one to this project" >&2
fi

node "$bin" patterns .
```

## After the script runs

For each cluster:
- `disallowed-prose` / `todo-marker` / `commented-out-code` clusters — propose bulk delete to the user.
- `divider` cluster — propose bulk delete (ASCII section dividers are noise).
- `license-fragment` cluster — the comments mention a license but aren't matching the machine-directive patterns. Inspect; either reformat the license header so it's recognized (SPDX-License-Identifier line or `Copyright` line at the top) or delete the residue.
- `doc-residue` cluster — block comments adjacent to declarations in a file with no opt-in marker. If the file is a public API surface, propose adding `// @plumbline:allow-docstrings` near the top; otherwise propose delete.
- `tag:` clusters — propose either fixing the slugs (typo, rename) or creating the missing artifacts.

Do not apply bulk deletions without confirming the cluster shape with the user.

<!-- Materialized by ok-plumbline v19.4.4 — suite-owned; overwritten on converge; do not hand-edit. -->
