---
name: starter
description: Generate a project-shaped .plumbline.json by scanning the repo for known patterns (Go module, Node package, ok-planner sibling, generated dirs). Output to stdout; user reviews and saves.
---

# /ok-standards:starter

Print a starter `.plumbline.json` configured for the project's actual shape. Detects:

- Go module (`go.mod`) — adds known generated-code dirs to ignore
- Node package (`package.json`) — adds .next, .turbo, storybook-static to ignore
- ok-planner sibling (`.ok-planner/`) — adds `@concept:`, `@story:`, `@decision:` citation entries that resolve against `.ok-planner/design/{concepts,stories,decisions}/{slug}.md`; adds `.ok-planner/` to ignore
- Generated-code dirs (`gen/`, `generated/`, `mocks/`, etc.) anywhere in the tree

Default check selection: both `comment_hygiene` and `citation_resolution` enabled. Plumbline's rule is strict by default (no comments except machine directives, configured citations, or docstrings in opt-in files); there is no "soft start" with checks disabled.

## Run

```bash
node "${CLAUDE_PLUGIN_ROOT%/}/bin/plumbline" starter .
```

## After the script runs

Review the proposed config with the user. Common adjustments:

- Add more citation entries if the project tracks design artifacts the heuristic didn't detect.
- Add directories the heuristic missed (e.g. an internal `dist/` location).

Propose saving as `.plumbline.json` at the repo root once the user is happy.
