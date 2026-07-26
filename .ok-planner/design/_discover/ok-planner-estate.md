---
topic: ok-planner-estate
kind: schema
---

# The .ok-planner/ estate layout

## Description

The plugin-owned layout that `ok-planner:true-up` converges in every consumer project:

```
.ok-planner/
  CLAUDE.md            — materialized from scripts/ok-planner-CLAUDE.md, version-stamped, overwritten wholesale
  design/              — durable corpus (NOT created by true-up; its presence is the "design docs exist" gate)
    _discover/ concepts/ stories/ decisions/   (buckets created only if design/ exists)
    concepts.md stories.md decisions.md        (auto-generated TOCs)
  issues.jsonl         — append-only intake queue (created empty if absent; never truncated)
  sprints/             — active sprints
  sketches/            — live sketches
  history/sprints/  history/sketches/          (+ migrated kinds: specs/, backlogs/, plans/, coverage/, tensions/)
  hooks/session-start  hooks/user-prompt-submit — materialized real hooks (the plugin-root ones are shims)
  context/skills-index.md                       — copy of the index SKILL.md the session-start hook injects
```

The bash core (`scripts/true-up`) resolves the project root (nearest `.git` ancestor of `$PWD`, else `$PWD`), mkdir-p's the subdirectory tree, creates `issues.jsonl` if absent, sed-stamps and overwrites `CLAUDE.md` and the cheatsheet ("No read, no diff, no prompt — the file is skill-owned boilerplate and the template is authoritative"), copies the skills index into `context/`, stamps and installs both hooks (mode 755) with the plugin version and the conduct version (read from the output style's `Conduct version:` line at materialization time), and finally scans for retired layout (`plans`, `coverage`, `design/tensions`, `specs`, `history/specs`, `backlogs`, `history/backlogs`, `design/review-notes*.md`), reporting hits on a `PRE-MIGRATION LAYOUT PRESENT:` last line for the SKILL to act on. "Idempotent. Re-running on a project already in compliance leaves the working tree unchanged at the git level."

Boundary rules: true-up "does not modify `.gitignore`. Whether `.ok-planner/` is tracked in git is the user's decision" (contrast ok-workspaces, which owns a dot-directory-scoped gitignore); it modifies nothing under `.ok-planner/` except `CLAUDE.md` and (append-only, migration-only) `issues.jsonl`; it never validates artifact contents ("that's `/audit`"); local edits to `CLAUDE.md` are not preserved. The repo's own CLAUDE.md warns contributors: "Do not create `.ok-planner/` artifacts in this repo unless dogfooding — those paths are conventions the skills write into *consumer* projects."

## Code surface

- `plugins/ok-planner/scripts/true-up` (the full converge core).
- `plugins/ok-planner/scripts/ok-planner-CLAUDE.md` (the 188-line estate CLAUDE.md template: per-directory rules + the full "Executing a sprint" shape).
- `plugins/ok-planner/skills/true-up/SKILL.md` (queue integrity + migrations wrapped around the script).
- Live instance at this repo root (v8.0.0; design/ present with empty buckets; empty issues.jsonl).

## Prose surface

- Index skill "Artifact layout"; estate CLAUDE.md itself; `plugins/ok-planner/CLAUDE.md` Constraints.

## Adjacent topics

- `true-up-verb`, `context-discipline`, `design-corpus`, `issue-queue`, `hook-shim`, `session-context-injection`, `backlog-sprint-rename`, `pre-4-0-kinds`.

## Observations

- The design/-gate subtlety (true-up creates the buckets only when design/ exists, and never design/ itself) is documented in three places (script comment, SKILL, and implicitly in audit's precondition) — a small invariant with outsized coupling: discover-design is the only skill that creates `design/`.
- `context/skills-index.md` is copied *unstamped* (plain `cp`) while both hooks are stamped — the injected index therefore carries no version marker of its own; the banner line supplies the version instead.
- The template's history list names `tensions/` etc. as archive folder names "on projects migrated from older layouts" — the estate schema still describes its own predecessors, deliberately, since archives persist indefinitely.
