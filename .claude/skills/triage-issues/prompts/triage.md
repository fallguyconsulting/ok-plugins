## Triage issues

Your task holds up to six issues from the intake store, each named by its record id. You route each one, and you write the record for three of the six routes. You read and write the intake only through `.ok-planner/bin/issues`, and only the records your task names: no code, nothing under `.ok-planner/design/`, no other issue, and no hand edit of `.ok-planner/issues.jsonl` or `.ok-planner/history/issues.jsonl`. You never write a record's `ruling`, and you never close a record that carries one.

### Read

1. `.ok-planner/review/catalog/accept.md`, whole: entries A1 to A9, "What the list leaves standing", and "Where a site is unclear".
2. The Defect issues section of `.claude/rules/ok-planner-cheatsheet.md`: the two kinds of issue, the upstream issue, and what makes a file suite-owned.
3. `.claude/rules/plumbline-coding.md`, on catches. It decides when a library error reaching the owner frame is the intended path.
4. Every record your task names, whole: `.ok-planner/bin/issues show <id>` prints its fields, its options, its recommendation, its `upstream` draft, and its discussion.
5. For each issue, the corpus artifacts that bear on it: run `OK_PLANNER_PROJECT_ROOT="$(pwd)" python3 .ok-planner/scripts/surface-corpus <the record id>`, and read what it lists and what the record's `artifacts` cite. An artifact two of your issues share is read once.
6. The code at every site an issue names, as it stands now. The filed evidence may have rotted: the code decides, not the issue.

Issue independent reads together in one message.

### Route each issue

First sort each issue. A **defect claim** asserts that the code is wrong and asks only that it be fixed: `category: defect`, or a problem whose one option fixes a code site. A **judgment issue** asks the owner to choose: what the product commits to, or how the project's own tooling works (the skills, prompts, and rules it owns under `.claude/` and `.ok-planner/`). The accept list filters defect claims alone, as it stands.

A **part the project does not own** is a suite-owned file, as the Defect issues section defines it, a library the project depends on, an outside tool or service, or the suite's accept list itself, for a harm the list does not name. A fix in such a part is its maintainers' to make, never the project's, so the issue is an upstream issue.

A record that already carries `route: upstream` is in your task for one question: does the project still show its harm? Read the foreign part as the project sees it now (the installed package and its version, the tool, or the file as it sits in the project) and each site its `upstream` draft names. Where the harm is gone, as after an update of the foreign part, route `answered` and say what changed. Where the project still shows it and the record's facts still hold, write nothing and file nothing. Where the harm stands but a fact the record states has rotted (a version, a site, a quoted line), revise it through `issues respond`, never through `issues revise`, so an update message tells the owner what changed: one `.ok-planner/bin/issues respond <id> --from -` call with `{"update": {<each revised field: problem, upstream, options, recommendation>, "text": "<each field revised, and what changed in it and why>"}}`.

A record whose `problem` carries a `Stuck in <run>` section is a judgment issue, whatever it claims: a `/converge` run fixed it up to its limit of send-backs, and a verifier sent every fix back, so how to fix it is the owner's choice. Route it `answered` where the code no longer shows the harm, and `question` otherwise, never `defect`. Its options are the fixes the section records, each with the verifier's reason, and the fix no run has tried.

A record whose `problem` carries a `Proposed entry` section is a defect claim first. A `/converge` finder met a harm at a named site that no accept-list entry named, and left the code. Judge each site the section names under the accept list as it stands; the proposed entry counts for nothing. Where a listed entry covers the harm and the fix changes code alone, route `defect`, and name that entry in the problem. Where no listed entry covers it, route `upstream`: the accept list is suite-owned, so a new entry is the ok suite's to adopt.

Then take the questions in this order. The first that settles the issue is its route.

1. **Is it settled already?** The code no longer does what the issue says, a live concept, story, or decision decides the question in words you can quote without interpretation you would have to defend, or the tooling now does what the issue asks. Route `answered`.
2. **Where does the fix lie?** Where it lies in a part the project does not own, route `upstream`, whatever the issue's category; a `tooling` issue takes `category: upstream` with it. Where a judgment issue's change lies in the project's own tooling, route `question`; where a stated rule decides the one compliant change, say so in the brief, and the author writes a generated ruling.
3. **For a defect claim, does the accept list cover a harm?** Name the site as `path:function`, the entry, the trigger, and the harm in the entry's words. Apply "What the list leaves standing" before you decide. Where no entry covers a harm the code causes today, route `retired`. These defect claims are `retired`:
   - a value, route, or rule spelled in more than one place, unless the copies disagree today in a way an entry covers, or A8 applies because a stated rule leaves one compliant form;
   - corpus wording, a missing annotation, an event, a name, or a code shape, with no harm an entry covers;
   - a risk with no trigger that the product meets on a system deployed and configured correctly.
4. **Does the fix change what the design corpus commits to?** This question takes every defect claim an entry covers, and every judgment issue about the product.
   - No: the corpus or a stated rule decides the end state, and only the mechanism is open. Route `defect`. Several ways to write the fix is the fixer's choice, never a question.
   - Yes, and the rules decide the corpus change: the corpus contradicts a later ruling, or the code and a counterpart artifact both contradict one sentence. Route `corpus`.
   - Yes, and the owner must choose: two live commitments cannot both hold, or the answer adds, drops, widens, or narrows a promise the corpus makes. Route `question`.

In doubt between a defect claim and a judgment issue, ask whether the filer offers the owner a choice. Where it does, it is a judgment issue. In doubt between `defect` and `question`, ask whether a fixer would have to edit a file under `.ok-planner/design/` to make the fix correct. Where no, it is `defect`. In doubt between `retired` and any other route for a defect claim, name the harm in the entry's words. Where you cannot, it is `retired`.

### Write the record

Each write is one module call. Pass a JSON object on stdin through a quoted heredoc (`<<'EOF'`), so the shell expands nothing; a line break inside a JSON string is `\n`. The module refuses a malformed object and names the field; fix the object and run the call again.

**`answered`.** `.ok-planner/bin/issues close <id> --as answered --reason "<the question in one plain sentence>. <what settles it: the artifact's slug and the clause quoted, or what the code does now, as path:function>."` The close moves the record to the archive.

**`retired`.** `.ok-planner/bin/issues close <id> --as retired --reason "No accept-list entry covers this defect claim. <why, in one or two sentences: the harm the issue names, and the entry or the \"leaves standing\" line that keeps it off the list>."`

Before either close, look at the record's discussion. Where it holds an owner message at `seen: null`, answer it first, so the owner's word does not sit unseen in the archive: one `.ok-planner/bin/issues respond <id> --from -` call whose `replies` answer each such message with the route and the reason, and whose `seen` lists each message the reply answers. Then close.

**`defect`.** Link every citation you write or rewrite per the Links rule in the `{{ISSUE-FILE-FORMAT}}` block of `.claude/skills/_shared/artifact-definitions.md`. One `issues revise` call:

```
.ok-planner/bin/issues revise <id> --from - <<'EOF'
{"route": "defect",
 "category": "defect",
 "title": "<plain title naming what goes wrong>",
 "problem": "<The site, as path:function. The accept-list entry. The trigger: the input or event that sets it off. The harm, in the entry's words. The evidence, as path:line quoted from the code as it stands.>",
 "options": [],
 "recommendation": {"form": "generated", "text": "Fix <the site> so <the harm> no longer follows."}}
EOF
```

Where the issue was filed with one option that names the fix the rules force, add one sentence to the problem naming that rule.

**`corpus`, `question`, and `upstream`.** Leave the record unrouted: the author writes its narrative and its route in one write, so a record whose author never finishes stays in scope for the next run. File one brief:

```
tasks item add --pool questions --key triage --field id=<the record id> --field route=<corpus|question|upstream> --body "<the record id>: <the brief>" --task <task>
```

The brief carries what the author writes from, and nothing else:

- the evidence, re-verified: what the code, the corpus, or the tooling says now, with `path:line` citations, and where the filed problem has rotted;
- the mechanism: the one or two cause-and-effect facts a reader needs;
- the corpus: each bearing artifact by slug with the one clause that matters, and where it is silent; for a tooling issue, the skill, prompt, catalog, or rule the change would edit;
- the harm, and its accept-list entry where one covers it;
- for `corpus`: the one compliant corpus change and the rule that forces it;
- for `question`: each real option with its main cost, including any the filer missed, and where a stated rule decides a tooling change, that rule;
- for `upstream`: the foreign part as the project sees it (the package and its version, the tool, or the file's path as it sits in the project, never a path to a local checkout; the suite is "the ok suite"), each site as path:function with its trigger and harm, the evidence quoted, and for a proposal the entry wording, quoted; then the workaround the project could make, if any, with its cost;
- sibling issues this should be ruled with, by record id.

Where the record already holds a verified narrative and a recommendation that routes the same way and still matches the code, write `reuse` as the whole brief after the record id. The author then sets only the route.

### Close

Stage the store by name: `git add` `.ok-planner/issues.jsonl` and `.ok-planner/history/issues.jsonl`, each that exists. Then `tasks close <task> --outcome done --result "triage: <n> answered, <n> retired, <n> defect, <n> corpus, <n> question, <n> upstream, <n> upstream still showing the harm, <n> upstream revised; messages: <n> replies, <n> seen" --staged <each store file you staged>`. Where you could not route an issue, leave its record as it stands, close `partial`, and name its id in the result.

<!-- Materialized by ok-planner v25.2.0 — suite-owned; overwritten on converge; do not hand-edit. -->
