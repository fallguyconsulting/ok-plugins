## Fix a group of defects

{{LEAF-AGENT-RULE}}

{{RELEASE-DOCUMENTS-RULE}}

{{PROSE-SCOPE-RULE}}

{{FIX-LINE-RULE}}

Your brief lists defects from the run's defect list, grouped because their fixes touch the same files. You fix each one at its root, in every file the fix reaches, in this task. A verifier reads your change next, against each defect and against the accept list; so make each fix complete and make it change nothing else.

You do not hunt. The defects in your brief are your whole job.

### Read

1. Each defect in your brief: `tasks item list --pool defects --key gate --state fixing --json`, the items your brief names. Where a defect has a `note` from a verifier, a fix of yours was sent back: the note says why, and your fix answers it.
2. The code at each site, whole functions, and every caller or reader your fix will reach: `rg` for the symbol and every literal that restates it; the LSP (`ToolSearch("select:LSP")`) for references.

### Fix

For each defect:

1. Confirm it is real and covered by the accept list, pasted below, or, for a defect whose `source` is `sprint`, by the sprint class its `entry` names. A defect from a skill surface is fixed by making the skill text, or the script or tool it calls, deliver what the story promises. A defect from a `stuck` story is fixed only by making the message or the help text at the place the defect names tell the user what went wrong or what to do next; a change to what a page or a verb offers is not yours: decline it and record a question. A defect you find is not real, or whose harm the list leaves standing, is declined: `tasks item set <id> --state declined --note "<why, with the code that shows it>"`. A defect that is the same flaw as another in your brief, or as another on the list, is a duplicate: `tasks item set <id> --state duplicate --note "<the defect id it duplicates>"`.
2. Fix it where the flaw is, not where it shows. Where the fix changes what a function takes, returns, or raises, bring every caller along in this task. Where the fix reaches a file another open task holds (`.ok-planner/bin/review held --task <your task> <paths>` exits 2), add those paths to the defect's files so the next round groups it with them (`tasks item set <id> --field 'files=[<its files and the new paths>]'`), finish every other defect, then close `partial` with a result that starts `outside files: <the paths>`.
3. Change nothing the defect does not need: no rename, no reshaping, no fix of something you happened to notice.
4. `tasks item set <id> --state fixed --note "<what you changed, where, and why that removes the harm; every file you changed>"`.

Where you notice a defect that is not in your brief, leave it and record it once: `tasks item add --pool calls --key gate --field kind=noticed --field file=<the file> --body "<the site; the harm, in an accept entry's terms>" --task <task>`. The next run's hunt reads code, not this note; the note reaches the owner.

Where the code and the design corpus do not decide what the fix should be, and reasonable owners would choose differently, build the reading you judge best and record a question: `tasks item add --pool calls --key gate --field kind=question --field file=<the file> --body "<the site; the choice; the readings, and the one you built>" --task <task>`.

### Release boundaries and a sprint's rulings

A fix keeps every user across a release boundary working. Read `.ok-planner/release-boundaries.md` where it exists.

{{RELEASE-BOUNDARIES}}

{{BEHAVIOR-CHANGE-DEFINITION}}

This run certifies the sprint at [SPRINT PATH], or no sprint where that reads `none`. Where it names one, read its implementation notes: a fix keeps every `preserve` behavior unchanged for its users across the boundary and every `migrate` behavior's migration, as the rulings below define them.

{{BEHAVIOR-RULINGS}}

A fix that must change a behavior a user across a boundary observes, where no ruling allows it, is declined with a question recorded: that change is the owner's to rule on.

### The coding rules

{{CONVERGE-CODING-RULES}}

Add no test, edit no test, run no test, and read no test as evidence.
Run the project's checks on every file you changed, in the foreground, and close with no process of your own still running. Leave the tree runnable.

### Rules

- Never destroy uncommitted work. Stage every path whose content you changed, by name (`git add <paths>`). Never run `git checkout`, `restore`, `reset`, `stash`, or `clean`. Fix a bad edit forward by editing again. Do not commit.
- Edit prose only where the prose scope rule above puts it in review. Edit no file the fix line rule above leaves alone, per the project's facts below. Where a defect's fix lies only in such a file, decline the defect with a note naming the file and the kind `.ok-planner/bin/review owner` prints for it, and record it once as `noticed` with that file, so the owner list routes it.

### Close

`tasks close <task> --outcome done --staged <every path you changed> --sites <every site you changed, path[:locator]> --result "<n> fixed, <n> declined, <n> duplicate: <defect ids by outcome>"`. A group you could not finish closes `partial` with where you stopped and what is staged.

### The accept list

[ACCEPT]

### This project

[PROJECT]

### The standards, verbatim

[STANDARDS]

<!-- Materialized by ok-planner v24.1.0 — suite-owned; overwritten on converge; do not hand-edit. -->
