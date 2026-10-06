## Link the citations in issues

Your task holds up to six issues from the intake store, each named by its record id. You make each record's citations into working links and repair its broken ones, and you change nothing else. You read and write the intake only through `.ok-planner/bin/issues`, and only the records your task names: no code, nothing under `.ok-planner/design/`, no other issue, and no hand edit of `.ok-planner/issues.jsonl` or `.ok-planner/history/issues.jsonl`. You never write a record's `ruling`, its route, or its messages, and you close no record.

### Read

1. The Links rule in the `{{ISSUE-FILE-FORMAT}}` block of `.claude/skills/_shared/artifact-definitions.md`: the form every link takes.
2. Each record whole: `.ok-planner/bin/issues show <id> --json`.
3. `.ok-planner/bin/issues links --json`: each record's links and whether each file exists.
4. For each citation in the record's `problem`, options, recommendation, and `upstream` draft, the file it names. A corpus citation resolves by its kind and slug. A code citation (`path:function`, `path:line`, a bare path) resolves by finding the file, and the function's or line's place in it now, with `rg` or a read.

Issue independent reads together in one message.

### Link

For each record, rewrite each of its four texts that holds a citation to link, or a broken link:

- A citation you resolve becomes a link per the rule. Keep its text exactly as written.
- A broken link whose file moved points at the new path. One whose file is gone, with no successor, becomes its text alone, no link.
- A code link's line follows the function or line it cites, as the file stands now.

Change no word outside the link markup: the analysis, the options' substance, and the recommendation stay as they are. A citation you cannot resolve stays plain text.

Each record takes one call, with only the fields you rewrote. Pass `options` whole, each option keeping its `label`. Pass the JSON object on stdin through a quoted heredoc (`<<'EOF'`), so the shell expands nothing; a line break inside a JSON string is `\n`:

```
.ok-planner/bin/issues revise <id> --from - <<'EOF'
{"problem": "...", "options": [{"label": "A", "text": "..."}], "recommendation": {"form": "...", "text": "..."}, "upstream": "..."}
EOF
```

A revise that changes only link markup writes no update message, so it carries no `by` and no `text`. On a routed or ruled record, the module refuses a revise that changes any word outside the link markup: restore those words as the record holds them and run the call again.

A record with nothing to link takes no `revise` call. Then run `.ok-planner/bin/issues links --json` again and check that every link in your records resolves. Once a record's links all resolve, record the check: `.ok-planner/bin/issues linked <id>`, for every record your task names, with or without a `revise` call.

### Close

Stage the store by name: `git add .ok-planner/issues.jsonl`. Then `tasks close <task> --outcome done --result "links: <n> issues, <n> links written, <n> repaired, <n> unlinked" --staged .ok-planner/issues.jsonl`. Where a record's links still fail, close `partial` and name each record and target in the result.
