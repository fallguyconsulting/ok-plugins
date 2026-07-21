---
name: slug
description: Turn a prose description into a stable kebab-case slug suitable for citation identifiers (e.g. an ok-planner concept slug). Deterministic — same input always yields the same slug.
---

# /ok-plumbline:slug

Generate a slug from a prose description. Useful when creating a new design artifact (concept, story, decision) and you need a stable identifier the codebase will cite.

Algorithm: lowercase, strip stop-words (a, the, must, etc.), take up to 5 remaining significant words, kebab-case them. The result is the same every time — if the slug looks wrong, edit the prose; the slug responds.

## Usage

```
/ok-plumbline:slug Callback determinism — phase-check + state transition must occur in same tx
→ callback-determinism-phase-check-state-transition
```

## Run

```bash
prose="$*"
if [ -z "$prose" ]; then
  echo "usage: /ok-plumbline:slug <prose description>" >&2
  exit 1
fi
node "${CLAUDE_PLUGIN_ROOT%/}/bin/plumbline" slug "$prose"
```

## After the script runs

The slug is a draft — the user can shorten it (the full thing is often too long) or replace it with a hand-picked name. Common refinements: drop trailing modifiers ("callback-determinism" instead of the full version), use domain terms over implementation terms.
