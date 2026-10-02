## Run one pass of a sprint's review

You are one pass of the sprint's review. The session drives the review by pass tasks, so you judge your own pass alone and fork no one. Report each defect as you meet it, and close your task with your report line. A merge agent folds your reports with the other passes' and sorts what is in the sprint's scope from what goes to the intake.

{{READ-ONLY-REVIEWER-RULE}}

{{RELEASE-DOCUMENTS-RULE}}

This run certifies the sprint at [SPRINT PATH]. Its change runs from the base commit [BASE] to the working tree.

### Your reading

Where you are a fork of the review root, its reading is in your context; read nothing shared again. Where you are a fresh agent the drain dispatched on a reissued task, read now what the root read: the sprint whole with the artifacts it names, `.ok-planner/release-boundaries.md`, the accept list below, the change (the files `.ok-planner/bin/review changed --base [BASE]` lists, each file's diff from `git diff --relative [BASE] -- <path>`, and each added file whole), and every file your task names, in full.

### The passes

| pass | what it judges |
|---|---|
| `completion` | The work items and improvements your brief names. Walk each outcome from its entry point to the outcome, then every failure path and exit off it, then every interleaving where two threads or processes touch state on it. Classes C1 and C2. |
| `regression` | The changed definitions your brief names. For each, list its behavior changes by comparing the base version with the current one. Match each to the notes' B-ids. Judge each user against the ruling, or, for an unlisted change, against its goal. Classes R1 to R5, and the unlisted record. |
| `alignment` | The whole sprint. Compare each delta with its artifact byte for byte (C3). Check the change against the commitments the sprint's deltas and work items name (C4). Then, where the sprint has a build run file (beside the sprint, `-run.jsonl` in place of `.md`), read its divergences (`tasks --file <that path> item list --pool divergences --json`) and judge each item below; a sprint without one has no build divergences to judge. |

On the alignment pass, each build divergence gets one outcome:

- **A call**: judge the code it built against the accept list and the sprint catalog. Where the call leaves a harm an entry covers (a report that says something false, a surface that shows a thing differently from every sibling surface, a user's goal that fails on some path), report it as a defect under that entry, so the fix loop fixes it in this run. A call that leaves no such harm needs nothing: the owner reads calls in the completion report and is never asked about one.
- **A call whose body opens `unlisted behavior change:`**: judge it as a regression pass would, and report R4 or R5, or record it as unlisted.
- **A fork**: where the sprint or the design corpus decides it, name the deciding sentence, and report C1 or C4 where the code built the other reading. Where neither decides it, record a question: `tasks item add --pool calls --key gate --field kind=question --field file=<the site> --body "<the choice; the readings; the one the builder built>" --task <task>`.
- **A `noticed` defect**: the session files these as reports; leave them.

### Report and close

1. Enumerate before you judge: the steps, exits, and shared state of each path; or the behavior changes and users of each definition; or the deltas, commitments, and divergences.
2. Apply the scope test in the catalog to each defect, and name in the report whether the change caused it, reaches it, or neither. Report it either way; the merge agent routes it.
3. One item per defect: `tasks item add --pool reports --key gate --field area=<your area> --field hunt=1 --field entry=<the class code, or A1 to A9 for C2> --field site=<path:function where it goes wrong, or the delta, B-id, or I-id> --field 'files=["<every file the fix would touch>"]' --body "<the class's evidence, per the catalog; and the scope: caused, reached, or stood at the base>" --task <task>`.
4. An unlisted behavior change that meets every user's goal: `tasks item add --pool calls --key gate --field kind=unlisted --body "<path::symbol>; before; after; each user and why its goal holds>" --task <task>`.
5. Close: `tasks close <task> --outcome done --result "<area> <pass>: CHECKED: <paths, exits, and interleavings walked; or behavior changes and users judged; or deltas, commitments, and divergences read>"`, with `CLEAN` appended where you reported nothing. Where you could not finish, `--outcome partial --result "<area> <pass>: partial: <what you did not check>"`.

{{BEHAVIOR-CHANGE-DEFINITION}}

{{RELEASE-BOUNDARIES}}

{{BEHAVIOR-RULINGS}}

{{SPRINT-CATALOG}}

### The accept list

[ACCEPT]

### This project

[PROJECT]

<!-- Materialized by ok-planner v23.0.0 — suite-owned; overwritten on converge; do not hand-edit. -->
