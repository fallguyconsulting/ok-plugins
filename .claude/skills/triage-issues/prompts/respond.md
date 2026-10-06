## Answer the owner's messages

Your task holds up to four issues from the intake store, each named by its record id. Each holds at least one owner message triage has not yet seen: a comment or a ruling at `seen: null`. You read each issue whole, judge each unseen owner message, and answer in one module call per issue: your replies, any revised fields with an update message naming them, and a seen mark on every owner message you acted on. You read and write the intake only through `.ok-planner/bin/issues`, and only the records your task names: no code, nothing under `.ok-planner/design/`, no other issue, and no hand edit of `.ok-planner/issues.jsonl` or `.ok-planner/history/issues.jsonl`. You never write a record's `ruling`, and you close no record.

### Read

1. Every record your task names, whole: `.ok-planner/bin/issues show <id>` prints its fields, its options, its recommendation, its `upstream` draft, its ruling, and its whole discussion, each message numbered, each owner message seen or not yet seen.
2. The Defect issues section of `.claude/rules/ok-planner-cheatsheet.md`: the two kinds of issue, the six routes, and what makes a file suite-owned. Where a message disputes a route, `.ok-planner/review/catalog/accept.md` too.
3. What each issue cites: the corpus artifacts its `artifacts` name and `OK_PLANNER_PROJECT_ROOT="$(pwd)" python3 .ok-planner/scripts/surface-corpus <the record id>` lists, and the code, tooling, or foreign part at every site its problem, its `upstream` draft, or an owner message names, as it stands now. The code decides, not the record.

Issue independent reads together in one message.

### Judge each unseen message

Read each owner message at `seen: null` in the light of the whole discussion before it. A message carrying `edited` is one you answered before, which the owner has since rewritten; its `earlier` field holds the texts you answered, so answer what changed. A message carrying `withdrawn` is one the owner took back; act on nothing it says. A message may do more than one of these; answer each part.

- **It asks something.** Reply with the answer, grounded in what you read: the code as `path:function`, the artifact by slug with the clause quoted, or the tooling file. Where the answer is that you do not know, say what would settle it.
- **It shows the issue wrong or thin.** The owner points at a fact the problem gets wrong, an option the analysis missed, a cost it misstates, or a site it never read. Check the claim against the code and the corpus. Where it holds, revise the fields it touches: `title`, `category`, `artifacts`, `route`, `problem`, `options`, `recommendation`, `upstream`. Rewrite a field whole, as the author of a fresh analysis would: the problem stays a from-the-top narrative, the options stay each with its one cost, and the recommendation stays a ruling the owner could accept word for word. Where the claim does not hold, reply with what the code or the corpus shows instead.
- **It redirects or rules.** An owner ruling, or a comment that states a decision, needs no reply unless it asks something or rests on a fact the record gets wrong. Where the analysis no longer fits the owner's ruling, revise it to explain the ruling's ground; the ruling itself stays as the owner wrote it.
- **It needs nothing.** An acknowledgement takes no reply.

A revision may change the route among `upstream`, `defect`, `corpus`, and `question`, where the message shows the issue routed wrong. A record routed `upstream` takes `category: upstream` and an `upstream` draft with the route, and a record routed `defect` takes `category: defect`. A route that closes the issue, `answered` or `retired`, is not yours: where a message shows the issue settled, reply with what settles it, and where the record has no ruling, revise its recommendation to a generated ruling that closes it and says why. A ruled record stays ruled whatever you revise; your revision reaches the owner as new analysis.

Mark a message seen only after you have acted on it: replied, revised, or judged that it needs nothing. A message you could not act on, because the read it needs failed or its question turns on something you cannot settle, keeps `seen: null` for the next run; name it in your close.

### Write one response per issue

Each issue takes one call, so its replies, its revision, and its seen marks land together. Pass the JSON object on stdin through a quoted heredoc (`<<'EOF'`), so the shell expands nothing; a line break inside a JSON string is `\n`. The module refuses a malformed object, a seen mark or a `replies_to` entry naming no owner message, and any `ruling`, and names what it refused; fix the object and run the call again.

```
.ok-planner/bin/issues respond <id> --from - <<'EOF'
{"replies": [{"replies_to": [<owner message numbers>], "text": "<the answer>"}],
 "update": {"<field>": <its new value>, ..., "text": "<each field revised, and what changed in it and why>"},
 "seen": [<every owner message number you acted on>]}
EOF
```

Link every citation you write or rewrite per the Links rule in the `{{ISSUE-FILE-FORMAT}}` block of `.claude/skills/_shared/artifact-definitions.md`.

Leave out `replies` where no message needed one, and `update` where nothing changed. An `update` names at least one field beside its `text`, and its text names each field it revised, so the owner reads what changed without diffing the record. One reply may answer several messages; list each in its `replies_to`.

### Close

Stage the store by name: `git add` `.ok-planner/issues.jsonl` and `.ok-planner/history/issues.jsonl`, each that exists. Then `tasks close <task> --outcome done --result "respond: <n> issues, <n> replies, <n> updates (<the fields revised>), <n> seen, <n> left unseen" --staged <each store file you staged>`. Where you left a message unseen, close `partial` and name each issue id and message number in the result.

<!-- Materialized by ok-planner v25.2.0 — suite-owned; overwritten on converge; do not hand-edit. -->
