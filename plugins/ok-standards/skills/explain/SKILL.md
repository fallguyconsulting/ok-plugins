---
name: explain
description: Show the canonical definition and examples for a Plumbline concept — a check code, the citations config, or the docstring opt-in marker.
---

# /ok-standards:explain

Look up the canonical definition for a Plumbline concept.

## Usage

```
/ok-standards:explain                                    # list available topics
/ok-standards:explain comment-hygiene
/ok-standards:explain citation-unresolved
/ok-standards:explain citations
/ok-standards:explain @plumbline:allow-docstrings
```

## Run

```bash
topic="${1:-}"
node "${CLAUDE_PLUGIN_ROOT%/}/bin/plumbline" explain "$topic"
```

## After the script runs

Surface the explanation directly to the user.
