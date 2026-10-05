## Author issue rulings

Your task holds up to four briefs from triage agents. Each brief names, by record id, an issue in the intake store whose route is `corpus`, `question`, or `upstream`. You rewrite each record's analysis as a from-the-top narrative an engineer who does not know the project can read cold, write its recommendation, and set its route. You read and write the intake only through `.ok-planner/bin/issues`, and only the records your briefs name: no hand edit of `.ok-planner/issues.jsonl` or `.ok-planner/history/issues.jsonl`. You never write a record's `ruling`.

### Read

1. Every brief your claim printed, and the record each names: `.ok-planner/bin/issues show <id>` prints its fields, its options, its recommendation, its `upstream` draft, and its discussion.
2. The corpus artifacts, code, and tooling files a brief cites, only where the brief leaves a cause-and-effect question open.
3. `.ok-planner/design/` artifacts the ruling leans on, to ground it in the project's intent or a corpus precedent. For a tooling issue, the project's own skill, prompt, or rule the change would edit, and the project rules under `.claude/rules/` that bear on it.
4. For an `upstream` brief, the `{{ISSUE-FILE-FORMAT}}` block of `.claude/skills/_shared/artifact-definitions.md` (open that file and read the block), which gives the upstream draft's shape.

### A `reuse` brief

Where the brief reads `reuse`, the record already carries a verified narrative and a recommendation. Read it. Where the recommendation still holds, set only the route: `.ok-planner/bin/issues revise <id> --from -` with `{"route": "<the brief's route>"}`, adding `"category": "upstream"` for an `upstream` route. Where it does not hold, rewrite the record as below.

### Write the record

Each record takes one `issues revise` call, so its narrative, its recommendation, and its route land together. Pass the JSON object on stdin through a quoted heredoc (`<<'EOF'`), so the shell expands nothing; a line break inside a JSON string is `\n`. The module refuses a malformed object and names the field; fix the object and run the call again.

```
.ok-planner/bin/issues revise <id> --from - <<'EOF'
{"route": "<corpus|question|upstream>",
 "title": "<a plain title that tells the story>",
 "problem": "<the narrative>",
 "options": [{"text": "<an option and its one cost>"}, ...],
 "recommendation": {"form": "<generated|recommended>", "text": "<the ruling>"}}
EOF
```

For an `upstream` route, the object also carries `"category": "upstream"` and `"upstream": "<the draft>"`. The module labels the options A, B, and on in the order you give them.

**`problem`** is the narrative, in this order:

- The defect: what the tree does or lacks, and which commitment that breaks.
- The mechanism: what talks to what, why the current shape causes the harm, and who sees it.
- The state of play: what is handled, and what gaps remain.
- One closing sentence naming what the ruling decides.

**`upstream`**, for an `upstream` route: the draft ready to file with the ok suite or the part's maintainers, in the shape the issue format gives, written from the brief.

**`options`**: each real option a reasonable owner might pick, with its one cost. For a `corpus` route, the one compliant change and the rule that forces it. For an `upstream` route, three: a workaround in the project, which becomes sprint work; a filing upstream, after which the issue closes; and both.

Use a project term only where judging the ruling needs it, and cite a slug only after the words it labels. Include implementation mechanics only where the ruling turns on them. Say each thing once.

**`recommendation`.** The owner may accept it as their ruling word for word, so write it as a ruling: no label, no address to the owner.

For a `corpus` route, and for a `question` route whose brief names a stated rule that decides a tooling change, the form is `generated`, and the text is the change, concretely: which corpus artifact or tooling file, what it says now, what it says after, and the rule that forces it. End with `Nothing was applied.`

For an `upstream` route, and for any other `question` route, the form is `recommended`, and the text is what to do and why, then a paragraph that opens `Rationale:`: why this over the other options, by reference, grounded in the project's intent, a corpus precedent, or a project rule; then the flip case, what evidence would change this call. Silence accepts no upstream recommendation: the next `/plan-sprint` walks an upstream issue with the owner, who resolves it there.

The ruling states intent, not delta phrasing or file paths. Pick the resolution that best serves the project's intent and the decisions already made, not the least-effort one. When the call is close, pick anyway and let the flip case say what makes it close.

### Close

Stage the store by name: `git add` `.ok-planner/issues.jsonl` and `.ok-planner/history/issues.jsonl`, each that exists. Then `tasks close <task> --outcome done --result "author: <n> written, <n> reused unchanged" --staged <each store file you staged>`. Where you could not write a record, leave it as it stands, close `partial`, and name its id in the result.
