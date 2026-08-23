---
name: starter
description: "ONLY activated by explicit /starter slash command. Never auto-triggered by conversation content. Generate a project-shaped plumbline config (.ok-plumbline/config.json) by scanning the repo for known patterns (Go module, Node package, ok-planner sibling, generated dirs). Output to stdout; user reviews and saves."
---

# /starter

Print a starter plumbline config (`.ok-plumbline/config.json`) configured for the project's actual shape. Detects:

- Go module (`go.mod`) — adds known generated-code dirs to ignore
- Node package (`package.json`) — adds .next, .turbo, storybook-static to ignore
- ok-planner sibling (`.ok-planner/`) — adds `@concept:`, `@story:`, `@decision:` citation entries that resolve against `.ok-planner/design/{concepts,stories,decisions}/{slug}.md`; adds `.ok-planner/` to ignore
- Generated-code dirs (`gen/`, `generated/`, `mocks/`, etc.) anywhere in the tree

Both checks — comment hygiene and citation resolution — always run; the config exposes no switch that disables one. Plumbline's rule is strict by default (no comments except machine directives, configured citations, or docstrings in opt-in files); there is no "soft start" with checks disabled.

## Run

```bash
# Prefer the project's pinned binary, so a cloned converged project proposes at
# its own version with nothing installed. Fall back to the carried payload with
# an announcement — this verb often runs before the project has an estate.
bin=".ok-plumbline/bin/plumbline"
if [ ! -x "$bin" ]; then
  bin="${CLAUDE_PLUGIN_ROOT:-plugins/ok}/families/ok-plumbline/bin/plumbline"
  echo "note: no vendored binary in this project — proposing from the carried payload" >&2
fi
node "$bin" starter .
```

## After the script runs

Review the proposed config with the user. Common adjustments:

- Add more citation entries if the project tracks design artifacts the heuristic didn't detect.
- Add directories the heuristic missed (e.g. an internal `dist/` location).

Propose saving as `.ok-plumbline/config.json` once the user is happy.

<!-- Materialized by ok-plumbline v19.1.0 — suite-owned; overwritten on converge; do not hand-edit. -->
