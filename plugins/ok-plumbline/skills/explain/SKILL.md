---
name: explain
description: Show the canonical definition and examples for a Plumbline concept — a check code, the citations config, or the docstring opt-in marker.
---

# /ok-plumbline:explain

Look up the canonical definition for a Plumbline concept.

## Usage

```
/ok-plumbline:explain                                    # list available topics
/ok-plumbline:explain comment-hygiene
/ok-plumbline:explain citation-unresolved
/ok-plumbline:explain citations
/ok-plumbline:explain @plumbline:allow-docstrings
```

## Run

```bash
topic="${1:-}"
node "${CLAUDE_PLUGIN_ROOT%/}/bin/plumbline" explain "$topic"
```

## After the script runs

Surface the explanation directly to the user.
