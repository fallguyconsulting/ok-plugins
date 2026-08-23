---
name: events
description: "ONLY activated by explicit /events slash command. Never auto-triggered by conversation content. Inventory every structured event kind the code emits — its emitting sites and the tests that wait on it — plus format violations, orphans, and the pruning list. Read-only — reports, fixes nothing, files nothing."
---

# /events

List every event kind in the tree so a reviewer reuses an existing kind instead of adding a near-duplicate, and the owner sees which kinds nothing in the tree waits on.

## What this does

1. Runs `plumbline events .` from the project root.
2. The binary reads every file under the path, skipping the ignored paths and prose files. It reports every file it did not read under three counts — `unreadable`, `binary`, `oversized` — each count naming its paths. It matches one regex for the convention — a quoted string literal in dotted upper-case namespaces, `SUBSYSTEM.NOUN.VERB` — and splits each site by the project's test-path convention: the `tests` array in `.ok-plumbline/config.json`, defaulting to common test paths (`test/`, `tests/`, `spec/`, `__tests__/`, `*_test.*`, `*.test.*`, `*.spec.*`, `test_*`, and similar names).
3. Prints every kind with its emitting sites and the tests that reference it, then three lists:
   - **Format violations** — kind-shaped literals that break the convention. The convention is `SUBSYSTEM.NOUN.VERB`: three or more segments; each segment starts with an upper-case letter and continues with upper-case letters and digits. The scan treats a literal as kind-shaped when it carries three or more dotted segments and one segment is an upper-case word with two upper-case letters in a row. Exit 2 when any exist.
   - **Orphans** — kinds referenced only from test files: the product emits nothing under that name.
   - **Pruning list** — kinds no test waits on. Handed over for the owner's judgment, never a finding: operators consume events outside the tree.

## Run

```bash
# Prefer the project's vendored binary — the inventory must read the test-path
# convention this project declared.
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
- A format violation over a kind this project emits is a review finding for the site's author: rename the literal to the convention at the emitting site and at every test that waits on it.
- A format violation over a constant another system owns is a scan false positive. Leave the literal alone.
- An orphan means a test waits on a kind the product does not emit under that name: either the product lost the emit or the test drifted; name both possibilities.
- Report the `unreadable`, `binary`, and `oversized` counts with their paths whenever any stands above zero, before you offer the pruning list. A file the scan did not read may hold a test that waits on a pruning-list kind. It may hold the emit site an orphan is missing.
- An empty inventory means no literal in the tree matched the scan's shape test. Report it as that fact. The scan matches no other shape, so it settles nothing about conformance.
- The pruning list is the owner's to act on. Offer it whole; recommend nothing per kind.
- Where the tree keeps tests under paths the defaults miss, propose the `tests` entry for `.ok-plumbline/config.json` and let the owner declare it through `/ok`. A declared `tests` array replaces the defaults. Propose an entry that lists every test path the project keeps.

<!-- Materialized by ok-plumbline v19.0.0 — suite-owned; overwritten on converge; do not hand-edit. -->
