---
name: true-up
description: "True up the .ok-planner/ estate: diagnose, run any retired-layout migration (pre-4.0 kinds, backlogs/ or specs/ → sprints/, and routing a legacy issues.jsonl to /verify-issues for conversion), then converge the plugin-owned layout (directory tree including the issues/ intake, version-stamped `.ok-planner/CLAUDE.md`). Idempotent; a compliant project is a silent no-op. Plumbing — normally driven by /ok or invoked by other ok-planner skills before they produce artifacts; also user-invokable as /true-up."
---

# True up the ok-planner estate

Bring the realized estate into agreement with what the installed plugin declares. Two phases: **diagnose** (read-only) and **converge** (deterministic script over plugin-owned files, plus a mechanical migration of any retired layout the script detects). The governing rule is ownership: the skill freely overwrites what it owns — version-stamped, regenerable files — and moves retired-layout files into the shape the current skills expect, because the skills will not work against the old shape.

## 1. Converge what's owned

Invoke via Bash:

```
bash "${CLAUDE_PLUGIN_ROOT}/scripts/true-up"
```

The script is the diagnose-and-converge core. It:

- Resolves the project root: the nearest `.git` ancestor of the working directory, else the working directory itself.
- Creates any missing subdirectories under `.ok-planner/`: `sprints/`, `sketches/`, `issues/`, `history/sprints/`, `history/sketches/`, `history/issues/`.
- If `.ok-planner/design/` already exists (bootstrapped by `discover-design` or by hand), also creates any missing buckets under it: `design/concepts/`, `design/stories/`, `design/decisions/`. Does **not** create `design/` itself — its presence is the "design docs exist for this project" gate other skills key on.
- Overwrites `.ok-planner/CLAUDE.md` from the canonical template at `scripts/ok-planner-CLAUDE.md`, stamping the installed plugin version into the template's version placeholder. No read, no diff, no prompt — the file is skill-owned boilerplate and the template is authoritative.
- Overwrites `.claude/rules/ok-planner-cheatsheet.md` from `scripts/ok-planner-cheatsheet.md` the same way — the plugin's always-in-context rules layer per the integration contract.
- Detects retired layout and reports it on the last line: pre-4.0 kinds (`plans/`, `coverage/`, `design/tensions/`, `design/review-notes*.md`), the pre-rename `backlogs/` / `history/backlogs/` and older `specs/` / `history/specs/` (the artifact is now the sprint), and a legacy `issues.jsonl` (the issue intake is now one markdown file per issue under `issues/`). `sketches/` is a live artifact kind (see `/sketch`), never flagged for migration. `history/` is the archive, never flagged either, and anything under it — whatever its subdirectory name — is preserved as-is, out of context by default.

Idempotent. Re-running on a project already in compliance leaves the working tree unchanged at the git level.

## 2. Check issue-intake integrity

Every file under `.ok-planner/issues/` must carry frontmatter with `issue` (the stable slug), a known `kind` (`audit` | `discover` | `sprint` | `human`), `category`, a known `status` (`open` | `verified` | `answered` | `promoted` | `retired`), and `opened`; a `status: promoted` file must carry a `sprint:` field naming a file that exists under `sprints/` or `history/sprints/` — a promotion receipt pointing at nothing is a finding. An `answered` or `retired` file still sitting in `issues/` (closed states live in `history/issues/`) is a finding too. A malformed file is a finding to report with its path for the human to repair — issue files are not plugin-owned content; this skill never edits them.

## 3. Layout migration (only when the script reports one)

Run the migration for whatever the script reported — no consent prompt. The current skills key on the current layout and will misbehave against a retired one; leaving the estate half-migrated is worse than migrating it. The migrations below are mechanical: files move between directories, contents are not rewritten, and `history/` preserves the record. Report what was done in step 4.

The one exception is a genuine collision between old and new locations — that is a real conflict, not a consent question, and step 3a stops for the owner to resolve it.

### 3a. `backlogs/` (or `specs/`) → `sprints/` (the backlog → sprint rename)

The artifact this ceremony produces is now the **sprint**, and it lives in `sprints/`. A recent layout called it a "sprint backlog" (in `backlogs/`); an older one called it a "sprint spec" (in `specs/`). Either migrates the same mechanical way — contents untouched, no rewriting of file bodies:

1. `git mv` (or `mv`) every file from `.ok-planner/backlogs/` into `.ok-planner/sprints/`, and from `.ok-planner/history/backlogs/` into `.ok-planner/history/sprints/` — and likewise from any `specs/` and `history/specs/` — merging with whatever is already there. Then remove the emptied directories.
2. Leave the moved files' contents alone. An archived record that calls itself a backlog or a spec is a record of what it was; rewriting history records is not this skill's business. Live sprints the owner still intends to execute may be reheaded `# Sprint: …` if they ask — offer, don't insist.
3. Do not touch a legacy `issues.jsonl` here. Its rows stay exactly as written — legacy `promote` rows carrying a `backlog` field (and older `resolve` rows with a `spec` field) fold as terminal, reading the legacy field as the sprint reference (see `{{ISSUE-FILE-FORMAT}}`). Its conversion is step 3c's business.
4. Re-run the script; it must no longer report `backlogs`, `history/backlogs`, `specs`, or `history/specs`.

If a project has both `backlogs/` and `sprints/` (or `specs/` and `sprints/`) with overlapping filenames, stop and put the collision to the owner — never overwrite.

### 3b. Pre-4.0 kinds

Read `{{ISSUE-FILE-FORMAT}}` in `skills/_shared/artifact-definitions.md` first, then:

1. **`design/tensions/` → issue files.** For each live tension file (skip `_resolved/` and `_rejected/` — settled history): write an issue file to `.ok-planner/issues/` per `{{ISSUE-FILE-FORMAT}}` with `issue` = the tension slug, `kind: "human"`, `category` from the tension's frontmatter, `artifacts` from its `affects:` list, `status: open`, the title from its title, `## Problem` condensed from its "What is muddy" and "Why it matters" sections, `## Candidates` from its "Resolution candidates", filename timestamp via `date -u +%Y-%m-%d-%H%M%S` (skip slugs already present in `issues/`). Then move the whole `design/tensions/` tree (live files and `_resolved/`/`_rejected/`) to `history/tensions/`.
2. **`plans/`, `coverage/`, `design/review-notes*.md` → archive.** These artifact kinds have no live consumers in ok-planner 4.x. (`sketches/` is not among them — sketches remain a live artifact kind, written by `/sketch` and archived per-file only when an idea has been taken up or abandoned.) Move each retired kind to its same-named folder under `history/` (`history/plans/`, `history/coverage/`; loose `design/review-notes*.md` files move to `history/` directly), merging with anything already archived there. Nothing is deleted: `history/` preserves the record, and the estate `CLAUDE.md` keeps it out of agent context unless the human directs otherwise. This is the general completion rule, not a migration special case — whenever an artifact kind is retired or an artifact completes, it moves to its same-named folder under `history/`.
3. Re-run the script. It must no longer report a retired layout.

### 3c. Legacy `issues.jsonl` → the file-per-issue intake

The conversion is `/verify-issues`' job, not this skill's — expanding rows into files is mechanical, but making them ruling-ready (the verification discussions) is agentic work that belongs with the verifier. When the script reports `issues.jsonl`:

1. If this true-up was invoked *by* `ok-planner:verify-issues` (step 0 of its own run), just report the finding back — the caller is about to convert it.
2. Otherwise, invoke `ok-planner:verify-issues` now. It folds the log, writes one issue file per open id, archives the log to `history/issues.jsonl`, and verifies everything unverified.
3. Re-run the script; it must no longer report `issues.jsonl`.

## 4. Report

Pass the script's one-line summary back to the calling skill (or the user, if invoked directly), plus any queue-integrity findings and the outcome of a migration if one ran. Do not add explanation, do not produce a long report, do not re-read the files the script wrote — the script is deterministic and its exit code is the verification.

## Why this skill exists

ok-planner's estate splits into three kinds with different rules:

- **Project records, out of context by default** (`sprints/`, `sketches/`, `history/`) — committed, versioned parts of the project, but not the source of truth and not to be pulled into context unprompted. A context-discipline rule, not a commit rule.
- **Durable design docs** (`design/`) — the project's canonical durable model: concepts, stories, decisions. A source of truth with the same weight as code; mutated only by applying a sprint's corpus deltas.
- **The issue intake** (`issues/`, one markdown file per issue) — questions awaiting the owner's judgment, each verified into a ruling-ready discussion by `/verify-issues`; they close through `/plan-sprint`, promoted into a sprint or retired, and closed files live in `history/issues/`.

Putting them under `.ok-planner/` with an embedded `CLAUDE.md` signals to any agent that wanders in: this is the planner's directory, treat it correctly.

## When invoked

Called by other ok-planner skills as their first step: `plan-sprint` (before framing the session), `audit` (before filing), `discover-design` (before bootstrapping). Also safe for the user to invoke directly via `/true-up`, and for the `ok` plugin's `/ok` to drive as this plugin's true-up verb.

## What this skill does NOT do

- Does not modify `.gitignore`. Whether `.ok-planner/` is tracked in git is the user's decision.
- Does not modify any file under `.ok-planner/` other than `CLAUDE.md` and (migration only) new issue files written from retired tensions. The rename migration moves record files between directories; it does not edit their contents, and it never edits existing issue files or a legacy `issues.jsonl`.
- Does not validate the contents of existing artifacts — that's `/audit`.
- Does not preserve local edits to `.ok-planner/CLAUDE.md`. The file is not a user-customization surface — it is regenerated from the template on every run. Project-specific guidance belongs in the project's own root `CLAUDE.md`.
