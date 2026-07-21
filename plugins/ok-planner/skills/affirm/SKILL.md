---
name: affirm
description: "Affirm the .ok-planner/ artifact layout: run the deterministic bash script that creates the directory tree and the issue queue if absent and overwrites `.ok-planner/CLAUDE.md` from the canonical template (stamped with the installed plugin version). Idempotent. Invoked by other ok-planner skills before producing artifacts; also user-invokable as `/affirm`. If the script reports a legacy pre-4.0 estate, this skill performs the migration."
---

# Affirm ok-planner artifact layout

Hand the work to a deterministic bash script; do judgment work only if the script reports a legacy estate.

## 1. Run the script

Invoke via Bash:

```
bash "${CLAUDE_PLUGIN_ROOT}/scripts/affirm"
```

Pass the script's one-line summary back to the calling skill (or the user, if invoked directly) as your response. Do not add explanation, do not produce a long report, do not re-read the files the script wrote — the script is deterministic and its exit code is the verification.

If the output does **not** contain a `LEGACY ESTATE PRESENT:` line, you are done.

## What the script does

- Resolves the project root: the nearest `.git` ancestor of the working directory, else the working directory itself.
- Creates any missing subdirectories under `.ok-planner/`: `specs/`, `history/specs/`.
- If `.ok-planner/design/` already exists (bootstrapped by `discover-design` or by hand), also creates any missing buckets under it: `design/concepts/`, `design/stories/`, `design/decisions/`. Does **not** create `design/` itself — its presence is the "design docs exist for this project" gate other skills key on.
- Creates an empty `.ok-planner/issues.jsonl` if absent. Never truncates or rewrites an existing one — the issue queue is append-only.
- Overwrites `.ok-planner/CLAUDE.md` from the canonical template at `scripts/ok-planner-CLAUDE.md`, stamping the installed plugin version into the template's version placeholder (that stamp is what `/doctor` compares against). No read, no diff, no prompt — the file is skill-owned boilerplate and the template is authoritative.
- Detects retired pre-4.0 layout (`plans/`, `sketches/`, `history/plans/`, `history/sketches/`, `coverage/`, `design/tensions/`, `design/review-notes*.md`) and reports it on the last line.

Idempotent. Re-running on a project already in compliance leaves the working tree unchanged at the git level.

## 2. Legacy migration (only when reported)

Read `{{ISSUE-QUEUE-FORMAT}}` in `skills/_shared/artifact-definitions.md` first, then:

1. **`design/tensions/` → issue rows.** For each live tension file (skip `_resolved/` and `_rejected/` — settled history; git preserves them): append an `open` row to `.ok-planner/issues.jsonl` with `id` = the tension slug, `kind: "human"`, `category` from the tension's frontmatter, `artifacts` from its `affects:` list, `summary` from its title, `detail` condensed from its "What is muddy" and "Why it matters" sections, `candidates` from its "Resolution candidates", timestamp via `date -u +%Y-%m-%dT%H:%M:%SZ`. Append with `>>`; never edit existing rows. Then delete `design/tensions/`.
2. **`plans/`, `sketches/`, `coverage/`, `design/review-notes*.md` → retire.** These artifact kinds have no live consumers in ok-planner 4.x. Move anything the human may still want to browse under `history/` (keeping its existing subdir if one exists); delete the rest. When in doubt, move rather than delete.
3. Re-run the script. It must no longer report a legacy estate.

## Why this skill exists

ok-planner's estate splits into three kinds with different rules:

- **Project records, out of context by default** (`specs/`, `history/`) — committed, versioned parts of the project, but not the source of truth and not to be pulled into context unprompted. A context-discipline rule, not a commit rule.
- **Durable design docs** (`design/`) — the project's canonical durable model: concepts, stories, decisions. A source of truth with the same weight as code; mutated only by applying a sprint spec's corpus deltas.
- **The issue queue** (`issues.jsonl`) — the append-only human-review backlog, drained at every `/sprint`.

Putting them under `.ok-planner/` with an embedded `CLAUDE.md` signals to any agent that wanders in: this is the planner's directory, treat it correctly.

## When invoked

Called by other ok-planner skills as their first step: `sprint` (before the gate), `audit` (before filing), `discover-design` (before bootstrapping). Also safe for the user to invoke directly via `/affirm`, and for `ok-doctor` to drive as this plugin's affirm verb.

## What this skill does NOT do

- Does not modify `.gitignore`. Whether `.ok-planner/` is tracked in git is the user's decision.
- Does not modify any file under `.ok-planner/` other than `CLAUDE.md` and (append-only, migration only) `issues.jsonl`.
- Does not validate the contents of existing artifacts — that's `/audit`.
- Does not preserve local edits to `.ok-planner/CLAUDE.md`. The file is not a user-customization surface — it is regenerated from the template on every run. Project-specific guidance belongs in the project's own root `CLAUDE.md`.
