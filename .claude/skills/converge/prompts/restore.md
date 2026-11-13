## Restore the code a stuck defect's fixes changed

{{LEAF-AGENT-RULE}}

{{FIX-LINE-RULE}}

A defect reached its limit of send-backs, so the run gives up on fixing it. Its fixes still stand in the tree, and a verifier sent each of them back. You return the code to the behavior it had before the stuck defect's fixes, and you keep every change another defect needs. You fix nothing: the defect goes to the intake as a judgment issue after you. A verifier checks your restoration next.

Your brief names the defect, the attempt, every fix task that set it `fixed`, every earlier restore task for it, and, for each file those tasks staged, its content before the defect's first fix as a git blob, or `new` where the file did not exist then. Where the attempt is not the first, a verifier sent the earlier restoration back, and the defect's note says what was still wrong.

### Read

1. The defect: `tasks item list --pool defects --key gate --json`, the item your brief names, with its note: each fixer's account and each verifier's reason.
2. Every other defect in the pool, with its state, its `files` field, and its note. `tasks dump --type task` lists each fix task's `batch_items` and `staged`, so you see which defects' fixes changed which files. A `verified` defect's change stays. So does the change of a defect still `open` or `fixing`, and the code a decline or duplicate a verifier accepted rests on.
3. The prior behavior: `git show <before blob>` prints each file as it stood before the defect's first fix.
4. Every change made since: for each file, `git diff <before blob> $(git hash-object -w <path>)`. Read each hunk as the change of one defect, or of an earlier restoration: the fix tasks' staged files and their defects' notes say whose it is.

### Restore

Decide, file by file, what the code must do: what it did at the before blob, save each change another defect needs. Then write the file so it does that. Work by judgment, not by removing hunks. Where another defect's change shares lines with the stuck defect's fixes, or builds on code they added, keep what that change needs and return the rest to its prior behavior.

- Where no other defect's change touched a file after the before blob, write it back whole: `git cat-file -p <before blob> > <path>`.
- Where the before blob reads `new`, the stuck defect's fixes created the file. Delete it unless another defect's change needs it.
- Where an earlier restoration was sent back, start from the file as it stands and correct what the verifier named.

Then walk every caller of anything whose signature, return, or raise the restoration changed back (`rg`, or the LSP: load the LSP tool once with `ToolSearch("select:LSP")`, then call it). A caller the stuck defect's fixes brought along goes back with them. A caller another defect's change needs stays, and so does the code it reaches.

Run the project's checks on every file you changed, in the foreground. Each file passes, or fails only where it failed at its before blob.

Stage every file you changed, by name.

### Rules

Edit only the files your brief names and the callers the walk above reaches. Never run `git checkout`, `restore`, `reset`, `stash`, or `clean`: other defects' work in the same files has no commit to come back from. A file your brief names is one the stuck defect's fixes changed, so you restore it as above even where the fix line rule above leaves that file alone: the restoration undoes the run's own edit and makes none of its own. Edit no other file the fix line rule leaves alone; a caller the walk reaches in such a file stays as it is, and you name it in your close.
Edit no test.
Commit nothing. Run nothing that starts the product.

### Close

`tasks close <task> --outcome done --staged <the paths you staged> --result "restored <defect id>: <n> files written back whole, <n> by judgment, <n> deleted; kept: <each other defect id whose change stayed, with its file>"`. Where a file cannot return to its prior behavior without undoing a change another defect needs, keep that change, and add to the result `; not restored: <path>: <what of the stuck defect's change stands, and the defect that needs it>`. Add `; left alone: <path>` for each caller the walk reached in a file the fix line rule leaves alone. The verifier judges the restoration as it stands.

### This project

[PROJECT]

<!-- Materialized by ok-planner v31.1.0 — suite-owned; overwritten on true-up; do not hand-edit. -->
