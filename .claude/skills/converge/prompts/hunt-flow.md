## Hunt one area of flows

{{LEAF-AGENT-RULE}}

Your brief names one area: a list of public entry points (routes, CLI verbs, topics, upload contracts), the file that declares them, and the number of this hunt. For each entry point you trace what happens to a request or a record from the moment it enters until it comes to rest or the request ends, through every file it reaches, and you report every defect the accept list covers on that path. You fix nothing and edit nothing. Other hunters trace the same entry points without seeing your reports, and a merge agent folds all the reports together; so report what you find.

### Trace

For each entry point:

1. Find the handler that receives it, and read it whole.
2. Follow the path: every call that validates, authorizes, transforms, writes, queues, sends, or answers, into every file it reaches. Load the LSP with `ToolSearch("select:LSP")` for a symbol's definition and references; `rg` for the rest. Stop where the data comes to rest (a row committed, a file published, a record acknowledged) or the request's answer is sent. Never follow a call into a library. Follow a hand-off to another service of this project only where the data itself crosses to it (a queue, a topic, a stored record that service reads), and there start at the handler that receives it.
3. Along the path, judge the accept list's harms that live in flows:
   - A3: list every input the entry point takes and what a user's mistake with each does (a wrong value, a missing field, a repeated request, steps out of order, two sessions at once). The system is deployed and configured correctly. A claim of a wrong result on a correct input is a defect only where a story or a decision states the right result; name it.
   - A6: every check of who the caller is and what it may do. Is there a path to the same action that skips it? Does a revocation reach every place the access is honored?
   - A7: every step between accepting data and storing it. Can an accepted item be dropped, skipped, or stored twice?
   - A1: a change that spans steps in different functions or services, where a failure between them leaves stored state no complete run would produce.
   - A9: the answer the entry point sends, its status or exit code, and every count or state it reports. Does each match what the path did?
   - A2, A4, A5, A8: any you meet on the path.
4. The shape catalogs show the forms these defects take. Their fix instructions are not yours.

Judge the harm, never the shape. The accept list's "What the list leaves standing" section decides the common cases. Where you cannot tell whether an entry's harm follows, the site stands.

### Report

One item per defect: `tasks item add --pool reports --key gate --field area=<your area> --field hunt=<your hunt number> --field entry=<A1..A9> --field site=<the entry point, and path:function where the path goes wrong> --field 'files=["<every file the fix would touch>"]' --body "<the entry point and the input or event that triggers it; the path, as path:function steps; what goes wrong and where; the harm, in the accept entry's terms; the evidence, as path:line quoted>" --task <task>`.

One defect per item. Two entry points that reach the same flaw are one item naming both.

### Rules

Edit nothing, stage nothing, commit nothing. Never run `git checkout`, `restore`, `reset`, `stash`, or `clean`. Run nothing that starts the product.

### Close

`tasks close <task> --outcome done --result "hunt <n> of <area>: <entry points traced> traced; <count> reported (<count per entry>)"`.

### The accept list

[ACCEPT]

### The shape catalogs

[SHAPES]

### This project

[PROJECT]

### The standards, verbatim

[STANDARDS]

<!-- Materialized by ok-planner v25.1.0 — suite-owned; overwritten on converge; do not hand-edit. -->
