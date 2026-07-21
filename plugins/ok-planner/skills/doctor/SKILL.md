---
name: doctor
description: "ONLY activated by explicit /doctor slash command or driven by ok-doctor. Never auto-triggered by conversation content."
---

# Doctor — ok-planner Estate Upkeep

Read-only drift report for ok-planner's integration into this project. This is ok-planner's `doctor` verb in the ok-plugins integration contract: it checks that the plugin's materialized estate matches what the installed plugin would materialize, and reports each check with a status and a remedy. It never drives work — auditing the corpus is `/audit`, running proofs is `/prove`, neither is doctor's business.

## Checks

Resolve the project root (nearest `.git` ancestor). Then:

1. **Layout** — `.ok-planner/` contains the current tree: `specs/`, `history/specs/`, `issues.jsonl`, and (if the corpus is bootstrapped) `design/{concepts,stories,decisions}/`. Missing pieces → drift; remedy: run `/affirm`.
2. **Legacy estate** — none of the retired layout is present: `plans/`, `sketches/`, `history/plans/`, `history/sketches/`, `coverage/`, `design/tensions/`, `design/review-notes*.md`. Any present → version drift from a pre-4.0 estate; remedy: run `/affirm` (its migration steps convert tensions to issue rows and archive the rest).
3. **Materialized CLAUDE.md** — `.ok-planner/CLAUDE.md` exists and its `Materialized by ok-planner v<X>` stamp matches the installed plugin version (read `version` from this plugin's `.claude-plugin/plugin.json`). Missing stamp or older version → drift; remedy: run `/affirm` (it overwrites from the current template). A byte-diff beyond the stamp is also drift — the file is skill-owned boilerplate, never hand-merged.
4. **Issue queue integrity** — every line of `.ok-planner/issues.jsonl` parses as JSON with a known `event` (`open` | `resolve`) and, for `open` rows, the required fields (`id`, `kind`, `category`, `summary`). A malformed line → drift; remedy: report the line number for the human to repair (doctor never edits the log).

## Output

```
ok-planner doctor — <project root>

[ok|DRIFT] layout        <detail>
[ok|DRIFT] legacy estate <detail>
[ok|DRIFT] CLAUDE.md     installed v<X>, materialized v<Y>
[ok|DRIFT] issue queue   <N> rows, <M> open

Remedy: <run /affirm | repair issues.jsonl line N | nothing — clean>
```

Read-only: this skill writes nothing, ever. The remedy is a report, not an action.
