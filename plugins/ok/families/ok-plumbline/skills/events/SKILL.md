---
name: events
description: "ONLY activated by explicit /ok-plumbline:events slash command. Never auto-triggered by conversation content. Inventory every structured event kind the code emits — the sites that reference it — plus format violations. Read-only — reports, fixes nothing, files nothing."
---

# /ok-plumbline:events

List every event kind in the tree so a reviewer reuses an existing kind instead of adding a near-duplicate.

## What this does

1. Runs `plumbline events .` from the project root.
2. The binary reads every file under the path, skipping the ignored paths and prose files. It reports every file it did not read under three counts — `unreadable`, `binary`, `oversized` — each count naming its paths. It matches one regex for the convention — a quoted string literal in dotted upper-case namespaces, `SUBSYSTEM.NOUN.VERB`.
3. Prints every kind with the sites that reference it, then one list:
   - **Format violations** — kind-shaped literals that break the convention. The convention is `SUBSYSTEM.NOUN.VERB`: three or more segments; each segment starts with an upper-case letter and continues with upper-case letters and digits. The scan treats a literal as kind-shaped when it carries three or more dotted segments and one segment is an upper-case word with two upper-case letters in a row. Exit 2 when any exist.

## Run

```bash
# Prefer the project's vendored binary — the inventory must read the ignore
# paths this project declared.
bin=".ok-plumbline/bin/plumbline"
if [ ! -x "$bin" ]; then
  bin="${CLAUDE_PLUGIN_ROOT:-plugins/ok}/families/ok-plumbline/bin/plumbline"
  echo "note: no vendored binary — using the payload's copy; /ok pins one to this project" >&2
fi

node "$bin" events .
```

## After the script runs

- Present the inventory as it prints. Do not edit code, do not file issues, do not remove a kind.
- Read every format violation before you report it. The regex matches on shape alone, so a dotted constant another system owns — an Android intent action, a Java class name — lands in the list too.
- A format violation over a kind this project emits is a review finding for the site's author: rename the literal to the convention at every site that references it.
- A format violation over a constant another system owns is a scan false positive. Leave the literal alone.
- Report the `unreadable`, `binary`, and `oversized` counts with their paths whenever any stands above zero. A file the scan did not read may hold a site the inventory is missing.
- An empty inventory means no literal in the tree matched the scan's shape. Report it as that fact. The scan matches no other shape, so it settles nothing about conformance.
- A kind referenced at one site only is not an unused one: operators consume events outside the tree. Recommend nothing per kind.
