## Clarify issues for a cold reader

Your task holds up to four issues from the intake store, each named by its record id. You rewrite each one so an engineer who does not know the project can read it once and judge it, and you check every fact it states against the project as it stands. You did not write these records, and you read them as their reader will: cold. You read and write the intake only through `.ok-planner/bin/issues`, and only the records your task names: no code, nothing under `.ok-planner/design/`, no other issue, and no hand edit of `.ok-planner/issues.jsonl` or `.ok-planner/history/issues.jsonl`. You never write a record's `ruling`, its route, its category, or its messages, and you close no record.

### Read

1. The shape rule and the Links rule in the `{{ISSUE-FILE-FORMAT}}` block of `.claude/skills/_shared/artifact-definitions.md` (open that file and read the block).
2. The writing standard, `.ok-planner/docs/technical-writing.md`.
3. Each record whole: `.ok-planner/bin/issues show <id> --json`.
4. For each fact a record states about the project now, the source that settles it: the code, the corpus, the run ledgers under `.ok-planner/review/runs/` and `.ok-planner/tasks/`, the intake, and `git log`. A fact about the project now is what a file says, what the code does, what a run did, or what remains to do. Read a source only to check a stated fact, to find the cause a record leaves out, or to define a term.

Issue independent reads together in one message.

### Check the facts

Check each fact against its source. A fact that still holds stands. A fact that no longer holds is rewritten as the project stands now. Where the change makes an option moot, or changes which option best serves the project, revise `options` and `recommendation` to match, and keep the recommendation's form. Where the project no longer shows any harm the record names, change nothing, and name the record as `settled` in your close result.

### Rewrite

For each record, in this order:

1. **Find the cause.** Ask what the project does or lacks that lets the harm happen. Where the record leads with the effect, such as a false report, name the cause that produces it. Where the record gives no cause, find it in the sources you read. Where no source shows why the cause happens, say only what the sources show.
2. **Write the title** as the cause, in everyday words: what can happen, such as "`/converge` sessions can skip confirming fixes". Name no project term but the part it concerns.
3. **Write the lead**: the cause, then the harm and who sees it, in one or two sentences, using no term the reader has not been given yet.
4. **List each project term** the text uses: a skill, a verb, a role, a field, an artifact kind, a run name, a slug. Keep a term only where judging the ruling needs it. Define each kept term in plain words where it first appears.
5. **Order the context** as things happen, then say why the cause happens.
6. **Cut** each sentence whose removal changes nothing, and each section label. Cut run names, task ids, defect ids, and line numbers from the prose unless an option turns on one; keep the link on the words it supports, per the Links rule. The problem ends under about 250 words, and never longer than the text it replaces. A new fact you add replaces an old sentence; it never stacks on top of one.
7. **Reread each sentence once, as the reader.** It reads one way on the first pass, its subject is an actor, and its verb is the action. Rewrite a noun that can read as a verb, a clause stacked on a clause, and a sentence that makes two claims.
8. **Reread the options and the recommendation** under the same standard. Change their words for clarity and their facts where the check above found them stale; keep each option's substance and label, and the recommendation's ruling.

A record already in the shape, with every fact holding, takes no rewrite.

### An issue in the shape

The owner approved this rewrite of one issue as the shape done well. Its options and recommendation stand apart from it.

> **Title:** `/converge` sessions can skip confirming fixes, and nothing stops them
>
> The session running `/converge` can skip the step that tests a fix by using the product, and no tool catches the skip. The run then reports those defects as fixed, though no one tried them as a user.
>
> `/converge` finds some defects by driving. An agent, the driver, uses the product as a user would and records each failure as a defect. A fixer then changes the code, and a verifier reads only that change. The verifier never runs the product, so each fix round ends with a confirm step: a fresh driver uses the product again and sends the defect back if it still fails.
>
> The skip happens because the session runs the fix loop by hand, from the skill's text. The confirm step applies only to defects a driver found, so the session has to check where each verified defect came from. When the session doesn't check, it goes on to the next round, and no tool stops it. The review tool's confirm command picks only the current round's defects, so once the next round starts, it can no longer pick the skipped ones.
>
> Sessions skipped the step in 2 of the last 8 certification runs, on Oct 4 and Oct 17, and left nine defects unconfirmed. At the owner's word, the session ran the Oct 17 run's eight confirms late. Seven passed. One failed and was fixed again.
>
> The ruling decides how `/converge` makes sure no verified drive defect ends a run without a confirm driver.

Each paragraph opens with its point. The title and the lead name the cause before the effect. Each term (driver, fixer, verifier, confirm step) is defined where it first appears. No id appears, because no option turns on one.

### Write

Each rewritten record takes one call, with only the fields you changed. Pass `options` whole, each option keeping its `label`. Pass the JSON object on stdin through a quoted heredoc (`<<'EOF'`), so the shell expands nothing; a line break inside a JSON string is `\n`:

```
.ok-planner/bin/issues revise <id> --from - <<'EOF'
{"title": "...", "problem": "...", "options": [{"label": "A", "text": "..."}], "recommendation": {"form": "...", "text": "..."},
 "by": "triage-issues", "text": "<one line of at most twelve words: what changed>"}
EOF
```

The module records the revision as an update message holding each changed field before and after, so the owner reads it as new analysis. Then record the pass for every record your task names, rewritten or not, settled ones included: `.ok-planner/bin/issues clarified <id>`. The stamp holds a digest of the text you read, so the next run takes the record again only once its text changes.

### Close

Stage the store by name: `git add .ok-planner/issues.jsonl`. Then `tasks close <task> --outcome done --result "clarity: <n> rewritten, <n> unchanged, <n> settled: <the settled ids, or none>" --staged .ok-planner/issues.jsonl`. Where you could not finish a record, leave it unstamped, close `partial`, and name its id in the result.

<!-- Materialized by ok-planner v27.0.0 — suite-owned; overwritten on true-up; do not hand-edit. -->
