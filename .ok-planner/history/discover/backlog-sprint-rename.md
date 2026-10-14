---
topic: backlog-sprint-rename
kind: alias
---

# The specs → backlogs → sprints rename

## Description

The planning ceremony's terminal artifact has had three names: "sprint spec" in `.ok-planner/specs/` (through 4.x), "sprint backlog" in `.ok-planner/backlogs/` ("a recent layout"), and now **sprint** in `.ok-planner/sprints/`. The plugin CLAUDE.md records it: "The artifact was called a 'sprint spec' in `specs/` through 4.x. It is now the **sprint** in `sprints/`; `/true-up` migrates consumer projects by moving files (contents untouched, archived records keep their old wording)."

Migration mechanics (true-up §3a): `git mv` everything from `backlogs/` → `sprints/` and `history/backlogs/` → `history/sprints/` (likewise `specs/`), merging; remove emptied dirs; **never rewrite file bodies** ("An archived record that calls itself a backlog or a spec is a record of what it was; rewriting history records is not this skill's business" — live sprints "may be reheaded `# Sprint: …` if they ask — offer, don't insist"); never touch `issues.jsonl`; re-run the script to confirm the report clears. The one stop: overlapping filenames between old and new locations ("a real conflict, not a consent question"). The queue format absorbs the rename on the read side: a `promote` row's "legacy `backlog` field, from before the backlog → sprint rename, is read the same way" as `sprint`, and legacy `resolve` rows "optionally with a `spec` or `backlog` field" fold as terminal — "Do not rewrite them (the log is append-only) and do not emit new ones."

Alongside the artifact rename, the *skill* was renamed `sprint` → `plan-sprint` (in flight in the working tree at discovery time), and the estate template's history section documents that migrated projects may have `history/specs/` sitting beside `history/sprints/`.

## Code surface

- `plugins/ok-planner/skills/true-up/SKILL.md` §3a; `scripts/true-up` premigration scan (`specs`, `history/specs`, `backlogs`, `history/backlogs`).
- `artifact-definitions.md` `{{ISSUE-QUEUE-FORMAT}}` (legacy `backlog`/`spec` field handling).
- Git status: `plugins/ok-planner/skills/sprint/SKILL.md -> plugins/ok-planner/skills/plan-sprint/SKILL.md`.

## Prose surface

- `plugins/ok-planner/CLAUDE.md` "How skills are wired" (the rename note); index skill layout note ("On migrated projects it may sit beside `history/specs/`, the pre-rename archive").

## Adjacent topics

- `sprint`, `issue-queue`, `true-up-verb`, `pre-4-0-kinds`, `plugin-renames`, `ok-planner-estate`.

## Observations

- Rename residue in live text, gathered: "promoted into that sprint's **sprint**" (index skill), "by **promoting** it into that sprint's **sprint**" (cheatsheet template), "promoted into this sprint's **sprint**" (plan-sprint §4), "promoted into that sprint's sprint or retired" (artifact-definitions.md line 14) — the doubled noun scans as a mechanical replace of "backlog"→"sprint" over the phrase "sprint's backlog". Also "sketch → `/plan-sprint` → **spec**" (index sketch row) and the true-up index row's `{specs,...}` directory list.
- The index skill row for true-up ("if a pre-4.0 layout is detected (tensions/, plans/, coverage/…) proposes the migration for the owner's consent") does not mention the backlog/spec rename migration at all — the row predates §3a.
- Three name generations are readable from the queue-format's compatibility clauses alone — the format doubles as the rename's fossil record.
