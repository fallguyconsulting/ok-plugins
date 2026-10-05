## Back out a stuck defect's change

{{LEAF-AGENT-RULE}}

{{FIX-LINE-RULE}}

A defect reached its limit of send-backs, so the run gives up on it. Its fixes still stand in the tree, and a verifier found each of them wrong. You remove that change and keep every other change. The defect goes to the intake as a judgment issue after you; you fix nothing.

Your brief names the defect, every fix task that set it `fixed`, and for each file those tasks staged, its content before the first of them as a git blob.

### Read

1. The defect: `tasks item list --pool defects --key gate --json`, the item your brief names, with its note.
2. Every other defect whose `files` field names a file in your brief, and its state. A `verified` defect's change stays. So does the change of any defect still being fixed.
3. The change: for each file, `git diff <before blob> $(git hash-object -w <path>)`.

### Back out

For each file in your brief:

- Where no other defect's fix touched the file after the before blob, write the file back to the before blob's content: `git cat-file -p <before blob> > <path>`.
- Otherwise, remove each hunk the stuck defect's fixes made and keep each hunk the other defects' fixes made. Where one hunk mixes both, keep the other defect's lines and restore the rest from the before blob.

Then walk every caller of anything whose signature, return, or raise the backout changed back (`rg`, or the LSP via `ToolSearch("select:LSP")`). A caller that the stuck defect's fixes brought along goes back with them. A caller that another defect's verified fix needs stays.

Run the project's checks on every file you changed, in the foreground. Each file passes, or fails only where it failed at the before blob.

Stage every file you changed, by name.

### Rules

Edit only the files your brief names and the callers the walk above reaches. Never run `git checkout`, `restore`, `reset`, `stash`, or `clean`: other defects' work in the same files has no commit to come back from. A file your brief names is one the stuck defect's fixes changed, so you back it out as above even where the fix line rule above leaves that file alone: the backout undoes the run's own edit and makes none of its own. Edit no other file the fix line rule leaves alone; a caller the walk reaches in such a file stays as it is, and you name it in your close.
<!-- lint-check: no-tests -->
Edit no test.
<!-- /lint-check -->
Commit nothing. Run nothing that starts the product.

### Close

`tasks close <task> --outcome done --staged <the paths you staged> --result "backed out <defect id>: <n> files restored whole, <n> files by hunk; kept: <the other defect ids whose hunks stayed>"`. Where you cannot separate the stuck defect's lines from another defect's, restore nothing in that file and close `--outcome partial --result "tangled: <path>: <the defect ids>"`.

### This project

[PROJECT]
