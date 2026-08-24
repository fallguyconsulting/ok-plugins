---
name: suggest
description: "ONLY activated by explicit /suggest slash command. Never auto-triggered by conversation content. Walk Plumbline lint violations and propose a fix for each — delete the comment, convert its load-bearing content to code (assertion / test / type / name), or resolve a citation. Read-only — proposes, does not apply."
---

# /suggest

Per violation, propose a specific fix based on simple heuristics. The suggestions are deterministic and noisy; treat them as a starting point, not an oracle. Under Plumbline's strict rule, the default action for a comment-hygiene violation is **delete** — most violations are residue. The suggest heuristics route the small minority that name a real constraint toward code (assertion, test, type, name) instead of toward a tag.

## What this does

1. Runs the Plumbline lint on the current project.
2. For each violation, applies a heuristic:
   - Comment containing "must"/"always"/"requires" → propose converting to an assertion with a message, or a test that fails on violation.
   - Comment containing "deliberate"/"intentional"/"on purpose" → propose encoding the intent in a name, or a test that fails if the "obvious" alternative is substituted.
   - Comment containing "handle the error/case" or restating what code does → propose delete.
   - `TODO` / `FIXME` / `HACK` / `XXX` → propose delete (promote to issue tracker if the work matters).
   - `citation-unresolved` → propose correcting the slug, creating the missing artifact, or removing the citation.
   - No match → default action is delete (the rule is no comments).
3. Prints suggestions as proposed actions with rationale.

## Run

```bash
# Prefer the project's vendored binary — suggestions must match the rules this
# project lints against.
bin=".ok-plumbline/bin/plumbline"
if [ ! -x "$bin" ]; then
  bin="${CLAUDE_PLUGIN_ROOT:-plugins/ok}/families/ok-plumbline/bin/plumbline"
  echo "note: no vendored binary — using the payload's copy; /ok pins one to this project" >&2
fi

node "$bin" suggest .
```

## After the script runs

Walk the output with the user. For each suggestion:

- For "convert to assertion / test / name" suggestions: confirm the comment actually names a load-bearing constraint (the heuristic gets it wrong sometimes — a comment about Postgres locking that happens to say "must" might still be residue). If load-bearing, write the assertion / test / name; if not, delete.
- For citation-unresolved suggestions: surface the slug and the expected resolution rule; ask the user whether to correct the slug or create the artifact.

Never bulk-apply suggestions; each one is a draft proposal.

<!-- Materialized by ok-plumbline v19.3.0 — suite-owned; overwritten on converge; do not hand-edit. -->
