## Read a sprint's change and cut the passes

{{FORK-PER-ITEM-RULE}}

Fork every pass, however few: the session drives the review by the pass tasks you filed, and a pass you ran yourself would be one it cannot see. The fork-per-item rule's one-item clause does not apply to you. You file no report yourself.

{{READ-ONLY-REVIEWER-RULE}}

{{RELEASE-DOCUMENTS-RULE}}

{{PROSE-SCOPE-RULE}}

{{FIX-LINE-RULE}}

This run certifies the sprint at [SPRINT PATH]. Its change runs from the base commit [BASE] to the working tree. Leave the sprint's completion report and its build run file, where it has one, to the alignment pass: the other passes judge the code blind to the executor's account of it, so a divergence the executor did not record surfaces as a report.

### Read once

1. The sprint, whole: intent, deltas and their sidecar, work items, implementation notes. Every artifact under `.ok-planner/design/` a delta names or a work item cites, in full. `.ok-planner/release-boundaries.md` where it exists.
2. The change: `.ok-planner/bin/review changed --base [BASE] --sprint [SPRINT PATH]` lists every file the sprint added, changed, or deleted, relative to the project root, less the files `.ok-planner/bin/review owner` classes as anything but `project` and the paths `.ok-planner/review/config.json` excludes. A changed declaration, corpus file, or record is not on the list; step 1 reads each artifact a delta names. It includes the files under each folder the sprint lists under `## Paths outside the project root`, as paths starting `../`. Write down that list. Read each file's diff with `git diff [BASE] -- <path>`, and each added file whole.
3. Every changed file in full, as it stands now, and each changed file's base version where the diff alone does not show a changed definition whole (`git show [BASE]:./<path>`, the `./` making the path relative to the project root).
4. Each work item's and each taken improvement's path: from the entry point that reaches its outcome to the outcome, reading every unchanged file the path crosses in full.
5. The users of each changed definition that existed at the base: its callers and references (load the LSP with `ToolSearch("select:LSP")`; `rg` for the rest), code that reads the same stored data or configuration, and what each release boundary's Where to look names. Read each user's calling function in full.

This reading is the whole reading, and it fixes the run's scope: the passes read nothing else.

### Cut the passes

- `completion`: one pass per group of work items that share code, up to five work items a group, with their improvements. Its files are the paths the group's outcomes cross.
- `regression`: one pass per group of changed definitions that share users, grouped by module. Its files are the definitions' files and their users' files.
- `alignment`: one pass over the whole sprint.

Number the passes `sprint-1`, `sprint-2`, and on; that name is the pass's area. File each on your own profile, forked from your task:

    .ok-planner/bin/tasks file --role pass --prompt sprint-pass --agent ok-review --key gate --fork-of <task> --files <the pass's paths> --brief - <<'EOF'
    area: sprint-<n>
    pass: completion | regression | alignment
    <completion: the work items and I-ids, each with its entry point and path as path::symbol steps. regression: the changed definitions, each with its B-ids where the notes list it, and its users.>
    EOF

### Close, then fork

Close your task first: `tasks close <task> --outcome done --result "<one entry per pass task: its id, its area, its pass, and its work items or definitions, with each work item's entry point; then the counts: changed files, work items, improvements, changed definitions with users, users read>"`. The return reads the entry points from this result.

Then fork one agent per pass task, every fork in one message, with `subagent_type` set to `fork`, each fork's prompt exactly this, its pass task's id in place of `<pass task>`:

    You are a fork of the review root. Everything the root read
    stands in your context; read nothing shared again. Claim your
    task and finish it.
    task: <pass task>

Wait for every fork to return. Your final message is the one line the profile defines.

### This project

[PROJECT]

<!-- Materialized by ok-planner v25.0.1 — suite-owned; overwritten on converge; do not hand-edit. -->
