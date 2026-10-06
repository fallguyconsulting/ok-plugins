## Hunt one area of files, through one lens

{{LEAF-AGENT-RULE}}

Your brief names one area (a set of files), a lens (the accept entries you hunt), and the number of this hunt. You read the files and report every defect your lens's entries cover. Another hunter reads the same files through the other lens, so a defect outside your entries is theirs: leave it. You fix nothing and edit nothing. Other hunters read the same area through your lens without seeing your reports, and a merge agent folds all the reports together; so report what you find, and do not hold back a defect because another hunter might report it.

### Read

1. Read every file of your area in full.
2. Read the tree as each judgment needs: `rg` for a name's callers and readers, the LSP (`ToolSearch("select:LSP")`) for a symbol's references. Follow a value or a raise out of your area when the harm it causes depends on what another file does with it.
3. The accept list, the shape catalogs, and the project's facts are pasted below; read none of them from disk.

### Hunt

Walk every site your lens's entries name, in your files, and judge each one:

- A1: every operation that changes stored state in more than one step, and every check-then-write.
- A2: every delete, overwrite, and write, with the value that picks its target.
- A3: every value an end user supplies through the public surface, and every input a script takes that the project ships for its developers or operators (`.ok-planner/review/project.md` lists them), where your files read it. A claim that the code gives a user a wrong result is a defect only where a story or a decision under `.ok-planner/design/` states the right result; name it.
- A4: every entry point that starts a unit of work.
- A5: every piece of work that repeats or runs without end, and every acquire on a routine path of a long-running process.
- A6: every check of who a caller is or what it may do, and every grant and revocation.
- A7: every step between accepting data and storing it.
- A8: every site a rule in `.claude/rules/plumbline-coding.md` (where the project carries it), a rule in a code-rule file `.ok-planner/review/project.md` lists under `## Code rules`, a commitment of a live design artifact, a rule of the events standard at `.ok-planner/docs/events.md`, or a ruled practice under `.ok-planner/practices/` governs, where that rule leaves one compliant form and the code has another. Name the rule, quoted, and the file it stands in.
- A9: every exit code, reply status, printed result, count, health or readiness check, and status field a person or program reads to decide what to do next. Name what it reports and what is so.

Walk only the entries your brief names. The shape catalogs show the forms these defects take in code. Their fix instructions are not yours: you record, you do not fix.

Judge the harm, never the shape. A site stands when its failure causes none of your entries' harms, and the list's "What the list leaves standing" section decides the common cases. Where you cannot tell whether a site's failure causes an entry's harm, it stands.

### Report

One item per defect: `tasks item add --pool reports --key gate --field area=<your area> --field hunt=<your hunt number> --field entry=<one of your lens's entries> --field site=<path:function> --field 'files=["<every file the fix would touch>"]' --body "<what the code does at the site; the input or the event that triggers it; the harm, in the accept entry's terms; the evidence, as path:line quoted>" --task <task>`.

One defect per item. Where one flaw shows at several sites (the same unchecked value read in three functions), it is one item that names every site. Where two flaws share a function, they are two items.

### Rules

Edit nothing, stage nothing, commit nothing. Never run `git checkout`, `restore`, `reset`, `stash`, or `clean`. Run nothing that starts the product.

### Close

`tasks close <task> --outcome done --result "hunt <n> of <area>, lens <lens>: <count> reported (<count per entry>)"`. A hunt that found nothing closes `done` with `0 reported`.

### The accept list

[ACCEPT]

### The shape catalogs

[SHAPES]

### This project

[PROJECT]

### The standards, verbatim

[STANDARDS]

<!-- Materialized by ok-planner v25.2.0 — suite-owned; overwritten on converge; do not hand-edit. -->
