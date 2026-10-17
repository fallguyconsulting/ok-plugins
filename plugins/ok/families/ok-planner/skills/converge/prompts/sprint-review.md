## Read a sprint's change and cut the passes

{{FORK-PER-ITEM-RULE}}

Fork every pass, however few: the session drives the review by the pass tasks you filed, and a pass you ran yourself would be one it cannot see. The fork-per-item rule's one-item clause does not apply to you. You file no report yourself.

{{READ-ONLY-REVIEWER-RULE}}

{{PROSE-SCOPE-RULE}}

{{FIX-LINE-RULE}}

This run certifies the sprint at [SPRINT PATH]. Its change runs from the base commit [BASE] to the working tree. Leave the sprint's completion report and its build run file, where it has one, to the alignment pass: the other passes judge the code blind to the executor's account of it, so a divergence the executor did not record surfaces as a report.

### Read once

{{SPRINT-REVIEW-READING}}

Write down the list of files step 2 gives. This reading is the whole reading, and it fixes the run's scope: the passes read nothing else.

### Cut the passes

- `completion`: one pass per group of work items that share code, up to five work items a group, with their improvements. Its files are the paths the group's outcomes cross.
- `regression`: one pass per group of changed definitions that share users, grouped by module. Its files are the definitions' files and their users' files.
- `alignment`: one pass over the whole sprint.
- `documentation`: one pass per docspec a work item names, and one per other docspec whose references the change reaches, as step 6 of the reading finds them, as `docspec:<slug>`. Its files are the docspec at `.ok-planner/docspec/<slug>.md`, every file under its `## Where` as the tree stands and every one the change added, changed, or deleted there, and, where the docspec has a `## Lists` section, the surface intent at `.ok-planner/surface/surface.md` and each file it names as declaring a class the docspec lists. A sprint whose work items name no docspec, and whose change reaches no docspec's references, has no documentation pass.

Number the passes `sprint-1`, `sprint-2`, and on; that name is the pass's area. File each on your own profile, forked from your task:

    .ok-planner/bin/tasks file --role pass --prompt sprint-pass --agent ok-review --key gate --fork-of <task> --files <the pass's paths> --brief - <<'EOF'
    area: sprint-<n>
    pass: completion | regression | alignment | documentation
    <completion: the work items and I-ids, each with its entry point and path as path::symbol steps. regression: the changed definitions, each with its B-ids where the notes list it, and its users. documentation: the docspec's slug, its Where, the work items that name it or `no work item names it`, and the references of it the change reached.>
    EOF

### Close, then fork

Close your task first: `tasks close <task> --outcome done --result "<one entry per pass task: its id, its area, its pass, and its work items, definitions, or docspec, with each work item's entry point; then the counts: changed files, work items, improvements, changed definitions with users, users read, docspecs named, docspecs reached that no work item names>"`. The return reads the entry points from this result.

Then fork one agent per pass task, every fork in one message, with `subagent_type` set to `fork`, each fork's prompt exactly this, its pass task's id in place of `<pass task>`:

    You are a fork of the review root. Everything the root read
    stands in your context; read nothing shared again. Claim your
    task and finish it.
    task: <pass task>

Wait for every fork to return. Your final message is the one line the profile defines.

### This project

[PROJECT]
