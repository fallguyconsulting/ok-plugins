## Author issue rulings

Your task holds up to four briefs from triage agents. Each brief names an issue file under `.ok-planner/issues/` whose route is `corpus` or `question`. You rewrite each file as a from-the-top narrative an engineer who does not know the project can read cold, and you write its ruling. You edit the issue files your task names and nothing else.

### Read

1. Every brief your claim printed, and the issue file each names.
2. The corpus artifacts, code, and tooling files a brief cites, only where the brief leaves a cause-and-effect question open.
3. `.ok-planner/design/` artifacts the ruling leans on, to ground it in the project's intent or a corpus precedent. For a tooling issue, the project's own skill, prompt, or rule the change would edit, and the project rules under `.claude/rules/` that bear on it.

### A `reuse` brief

Where the brief reads `reuse`, the file already carries a verified narrative and a recommended ruling. Read it. Where the ruling still holds, change only the frontmatter, as below. Where it does not, rewrite the file.

### Write the file

In the frontmatter, set `status: verified` and add `triage: <the brief's route>` on the line after it. Keep every other field. Replace the body below it:

- A plain title that tells the story.
- The defect: what the tree does or lacks, and which commitment that breaks.
- The mechanism: what talks to what, why the current shape causes the harm, and who sees it.
- The state of play: what is handled, and what gaps remain.
- `## Options`: each real option a reasonable owner might pick, with its one cost. For a `corpus` route, the one compliant change and the rule that forces it.
- One sentence naming what the ruling decides.
- `## Ruling`, in the form below.

Use a project term only where judging the ruling needs it, and cite a slug only after the words it labels. Include implementation mechanics only where the ruling turns on them. Say each thing once.

For a `corpus` route, and for a `question` route whose brief names a stated rule that decides a tooling change:

```markdown
## Ruling

> Generated ruling (/triage-issues): <the change, concretely: which corpus artifact or tooling file, what it says now, what it says after, and the rule that forces it. Nothing was applied.>
```

For any other `question` route:

```markdown
## Ruling

> Recommended ruling (/triage-issues): <what to do and why>.
>
> Rationale: <why this over the other options, by reference, grounded in the project's intent, a corpus precedent, or a project rule. Then the flip case: what evidence would change this call.>

<!-- Owner: this is a recommendation, not your decision. Leave it
as-is to accept; the next /plan-sprint carries it. Edit the text to
redirect, empty the section to discuss live, or delete this note to
adopt the ruling as your own. -->
```

The ruling states intent, not delta phrasing or file paths. Pick the resolution that best serves the project's intent and the decisions already made, not the least-effort one. When the call is close, pick anyway and let the flip case say what makes it close.

### Close

`tasks close <task> --outcome done --result "author: <n> written, <n> reused unchanged" --staged <every issue file you edited>`. Stage each file by name first.

<!-- Materialized by ok-planner v24.0.0 — suite-owned; overwritten on converge; do not hand-edit. -->
