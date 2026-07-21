---
name: affirm
description: "Affirm the .ok-planner/ artifact layout: run the deterministic bash script that creates the directory tree if absent and overwrites `.ok-planner/CLAUDE.md` from the canonical template. Idempotent. Invoked by other ok-planner skills before producing artifacts; also user-invokable as `/affirm`."
---

# Affirm ok-planner artifact layout

Hand the work to a deterministic bash script. The `.ok-planner/CLAUDE.md` template is fixed boilerplate with nothing to interpret, judge, or merge — having the LLM rewrite it on every invocation was pure token waste. The script does the whole job in one `cp` and a handful of `mkdir -p`s.

## What to do

Invoke the script via Bash. That is the entire skill:

```
bash "${CLAUDE_PLUGIN_ROOT}/scripts/affirm"
```

Pass the script's one-line summary back to the calling skill (or the user, if invoked directly) as your response. Do not add explanation. Do not produce a long report. Do not read any of the files the script wrote to "verify" — the script is deterministic and its exit code is the verification.

This behavior is identical whether affirm was invoked by the user via `/affirm` or by another skill mid-pipeline. It never interrupts a run to ask about `CLAUDE.md`.

## What the script does

- Resolves the project root: the nearest `.git` ancestor of the working directory, else the working directory itself.
- Creates any missing subdirectories under `.ok-planner/`: `specs/`, `plans/`, `sketches/`, `history/specs/`, `history/plans/`, `history/sketches/`.
- If `.ok-planner/design/` already exists (bootstrapped by `discover-design` or by hand), also creates any missing buckets under it: `design/concepts/`, `design/stories/`, `design/decisions/`, `design/tensions/`. Does **not** create `design/` itself — its presence is the "design docs exist for this project" gate other skills key on.
- Overwrites `.ok-planner/CLAUDE.md` with the canonical template at `scripts/ok-planner-CLAUDE.md` in a single `cp`. No read, no diff, no prompt — the file is skill-owned boilerplate and the template is authoritative.

Idempotent. Re-running on a project already in compliance leaves the working tree unchanged at the git level (`mkdir -p` is silent on existing dirs; rewriting the same bytes leaves the content hash unchanged).

## Why this skill exists

ok-planner artifacts split into two kinds with different rules:

- **Project records, out of context by default** (`specs/`, `plans/`, `sketches/`, `history/`) — committed, versioned parts of the project, but not the source of truth and not to be pulled into context unprompted (reading `history/`/`sketches/` without a directing goal is context pollution). This is a context-discipline rule, not a commit rule.
- **Durable design docs** (`design/`) — the project's canonical durable model: concepts, stories, decisions, and tensions catalogs. A source of truth with the same weight as code; mutated only through plan execution.

Putting both under `.ok-planner/` with an embedded `CLAUDE.md` signals to any agent that wanders in: this is the planner's directory, treat it correctly, don't pull the records into context unprompted or "fix" them, and don't edit the design docs outside the plan pipeline.

The `CLAUDE.md` template evolves alongside the skills. The script keeps the embedded copy aligned by overwriting it wholesale on every run. There are no user customizations to preserve and no confirmation to ask for — `.ok-planner/` is the planner's own folder.

## When invoked

Called by other ok-planner skills as their first step when they're about to produce or move artifacts:

- `brainstorm` — before writing a spec
- `sketch` — before writing a sketch
- `write-plan` — before writing a plan
- `execute-plan` — before dispatching the implementer, and again before archiving the plan on completion
- `discover-design` — before bootstrapping the design docs
- `refine-design` — before tension-resolution intake

Also safe for the user to invoke directly via `/affirm`. There is one command; it always does the same thing.

## What this skill does NOT do

- Does not modify `.gitignore`. Whether `.ok-planner/` is tracked in git is the user's decision.
- Does not modify any file under `.ok-planner/` other than `CLAUDE.md`. It overwrites `CLAUDE.md` (skill-owned boilerplate) but never touches specs, plans, sketches, design docs, or history.
- Does not validate the contents of existing artifacts.
- Does not rename or migrate artifacts from other locations (e.g., `docs/specs/` from older versions of these skills). Migration is a one-time user-driven task.
- Does not preserve local edits to `.ok-planner/CLAUDE.md`. The file is not a user-customization surface — it is regenerated from the template on every run. Project-specific guidance belongs in the project's own `CLAUDE.md` at the repo root, not in `.ok-planner/CLAUDE.md`.
