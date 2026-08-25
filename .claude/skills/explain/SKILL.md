---
name: explain
description: "ONLY activated by explicit /explain slash command. Never auto-triggered by conversation content. Show the canonical definition and examples for a Plumbline concept — a check code, the citations config, or the docstring opt-in marker."
---

# /explain

Look up the canonical definition for a Plumbline concept.

## Usage

```
/explain                                    # list available topics
/explain comment-hygiene
/explain citation-unresolved
/explain citations
/explain @plumbline:allow-docstrings
```

## Run

```bash
# Prefer the project's vendored binary so the explanation matches the rules
# this project actually lints against.
bin=".ok-plumbline/bin/plumbline"
if [ ! -x "$bin" ]; then
  bin="${CLAUDE_PLUGIN_ROOT:-plugins/ok}/families/ok-plumbline/bin/plumbline"
  echo "note: no vendored binary — using the payload's copy; /ok pins one to this project" >&2
fi

topic="${1:-}"
node "$bin" explain "$topic"
```

## After the script runs

Surface the explanation directly to the user.

<!-- Materialized by ok-plumbline v19.4.4 — suite-owned; overwritten on converge; do not hand-edit. -->
