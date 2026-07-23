---
name: true-up
description: "True up the .ok-planner/ estate: diagnose, propose any retired-layout migration for the owner's consent (pre-4.0 kinds, and specs/ → backlogs/ for the spec → sprint-backlog rename), then converge the plugin-owned layout (directory tree, issue queue if absent, version-stamped `.ok-planner/CLAUDE.md`). Idempotent; a compliant project is a silent no-op. Plumbing — normally driven by /ok or invoked by other ok-planner skills before they produce artifacts; also user-invokable as /true-up."
---

# True up the ok-planner estate

Bring the realized estate into agreement with what the installed plugin declares. Three phases: **diagnose** (read-only), **consent** (only when something not plugin-owned needs migrating or repairing), **converge** (deterministic script over plugin-owned files). The governing rule is ownership: the skill freely overwrites what it owns — version-stamped, regenerable files — and never silently touches anything else.

## 1. Converge what's owned

Invoke via Bash:

```
bash "${CLAUDE_PLUGIN_ROOT}/scripts/true-up"
```

The script is the diagnose-and-converge core. It:

- Resolves the project root: the nearest `.git` ancestor of the working directory, else the working directory itself.
- Creates any missing subdirectories under `.ok-planner/`: `backlogs/`, `sketches/`, `history/backlogs/`, `history/sketches/`.
- If `.ok-planner/design/` already exists (bootstrapped by `discover-design` or by hand), also creates any missing buckets under it: `design/concepts/`, `design/stories/`, `design/decisions/`. Does **not** create `design/` itself — its presence is the "design docs exist for this project" gate other skills key on.
- Creates an empty `.ok-planner/issues.jsonl` if absent. Never truncates or rewrites an existing one — the issue queue is append-only.
- Overwrites `.ok-planner/CLAUDE.md` from the canonical template at `scripts/ok-planner-CLAUDE.md`, stamping the installed plugin version into the template's version placeholder. No read, no diff, no prompt — the file is skill-owned boilerplate and the template is authoritative.
- Overwrites `.claude/rules/ok-planner-cheatsheet.md` from `scripts/ok-planner-cheatsheet.md` the same way — the plugin's always-in-context rules layer per the integration contract.
- Detects retired layout and reports it on the last line: pre-4.0 kinds (`plans/`, `coverage/`, `design/tensions/`, `design/review-notes*.md`) and the pre-rename `specs/` / `history/specs/` (the artifact is now the sprint backlog). `sketches/` is a live artifact kind (see `/sketch`), never flagged for migration. `history/` is the archive, never flagged either, and anything under it — whatever its subdirectory name — is preserved as-is, out of context by default.

Idempotent. Re-running on a project already in compliance leaves the working tree unchanged at the git level.

## 2. Check issue-queue integrity

Every line of `.ok-planner/issues.jsonl` must parse as JSON with a known `event` (`open` | `promote` | `retire`, or the legacy terminal `resolve`) and the fields that event requires: `id`, `kind`, `category`, `summary` on `open`; `backlog` on `promote`. A `promote` row naming a backlog file that does not exist under `backlogs/` or `history/backlogs/` is a finding too — the promotion's receipt points at nothing. A malformed line is a finding to report with its line number for the human to repair — the queue is not plugin-owned content; this skill never edits it beyond the migration appends below.

## 3. Layout migration (only when the script reports one)

A retired layout is not plugin-owned in its current form — migrating it is a consent step, not a silent write. Present what will happen (the plans below: what is renamed, which tensions become issue rows, what moves to `history/`) and get the owner's go-ahead before executing. When invoked by another skill mid-ceremony, the owner is present — ask there too.

### 3a. `specs/` → `backlogs/` (the spec → sprint-backlog rename)

The artifact formerly called a "sprint spec" is now the **sprint backlog**, and it lives in `backlogs/`. The migration is mechanical — contents untouched, no rewriting of file bodies:

1. `git mv` (or `mv`) every file from `.ok-planner/specs/` into `.ok-planner/backlogs/`, and from `.ok-planner/history/specs/` into `.ok-planner/history/backlogs/`, merging with whatever is already there. Then remove the emptied directories.
2. Leave the moved files' contents alone. An archived record that calls itself a spec is a record of what it was; rewriting history records is not this skill's business. Live backlogs the owner still intends to execute may be reheaded `# Sprint backlog: …` if they ask — offer, don't insist.
3. Do not touch `issues.jsonl`. Legacy `resolve` rows carrying a `spec` field stay exactly as written — the queue is append-only, and readers already fold them as terminal (see `{{ISSUE-QUEUE-FORMAT}}`).
4. Re-run the script; it must no longer report `specs` or `history/specs`.

If a project has both `specs/` and `backlogs/` with overlapping filenames, stop and put the collision to the owner — never overwrite.

### 3b. Pre-4.0 kinds

Read `{{ISSUE-QUEUE-FORMAT}}` in `skills/_shared/artifact-definitions.md` first, then:

1. **`design/tensions/` → issue rows.** For each live tension file (skip `_resolved/` and `_rejected/` — settled history): append an `open` row to `.ok-planner/issues.jsonl` with `id` = the tension slug, `kind: "human"`, `category` from the tension's frontmatter, `artifacts` from its `affects:` list, `summary` from its title, `detail` condensed from its "What is muddy" and "Why it matters" sections, `candidates` from its "Resolution candidates", timestamp via `date -u +%Y-%m-%dT%H:%M:%SZ`. Append with `>>`; never edit existing rows. Then move the whole `design/tensions/` tree (live files and `_resolved/`/`_rejected/`) to `history/tensions/`.
2. **`plans/`, `coverage/`, `design/review-notes*.md` → archive.** These artifact kinds have no live consumers in ok-planner 4.x. (`sketches/` is not among them — sketches remain a live artifact kind, written by `/sketch` and archived per-file only when an idea has been taken up or abandoned.) Move each retired kind to its same-named folder under `history/` (`history/plans/`, `history/coverage/`; loose `design/review-notes*.md` files move to `history/` directly), merging with anything already archived there. Nothing is deleted: `history/` preserves the record, and the estate `CLAUDE.md` keeps it out of agent context unless the human directs otherwise. This is the general completion rule, not a migration special case — whenever an artifact kind is retired or an artifact completes, it moves to its same-named folder under `history/`.
3. Re-run the script. It must no longer report a retired layout.

## 4. Report

Pass the script's one-line summary back to the calling skill (or the user, if invoked directly), plus any queue-integrity findings and the outcome of a migration if one ran. Do not add explanation, do not produce a long report, do not re-read the files the script wrote — the script is deterministic and its exit code is the verification.

## Why this skill exists

ok-planner's estate splits into three kinds with different rules:

- **Project records, out of context by default** (`backlogs/`, `sketches/`, `history/`) — committed, versioned parts of the project, but not the source of truth and not to be pulled into context unprompted. A context-discipline rule, not a commit rule.
- **Durable design docs** (`design/`) — the project's canonical durable model: concepts, stories, decisions. A source of truth with the same weight as code; mutated only by applying a sprint backlog's corpus deltas.
- **The intake queue** (`issues.jsonl`) — the append-only queue of questions awaiting owner judgment; `/sprint` is where they leave it, promoted into a backlog or retired.

Putting them under `.ok-planner/` with an embedded `CLAUDE.md` signals to any agent that wanders in: this is the planner's directory, treat it correctly.

## When invoked

Called by other ok-planner skills as their first step: `sprint` (before framing the session), `audit` (before filing), `discover-design` (before bootstrapping). Also safe for the user to invoke directly via `/true-up`, and for the `ok` plugin's `/ok` to drive as this plugin's true-up verb.

## What this skill does NOT do

- Does not modify `.gitignore`. Whether `.ok-planner/` is tracked in git is the user's decision.
- Does not modify any file under `.ok-planner/` other than `CLAUDE.md` and (append-only, migration only) `issues.jsonl`. The rename migration moves record files between directories; it does not edit their contents.
- Does not validate the contents of existing artifacts — that's `/audit`.
- Does not preserve local edits to `.ok-planner/CLAUDE.md`. The file is not a user-customization surface — it is regenerated from the template on every run. Project-specific guidance belongs in the project's own root `CLAUDE.md`.
