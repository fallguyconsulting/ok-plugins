# The documentation sprint document

`/plan-docs`'s terminal artifact, defined once. `/plan-docs` writes every documentation sprint from this template and never restates it.

`{{DOC-SPRINT-DOCUMENT-TEMPLATE}}` is the whole document. Its **How to execute this documentation sprint** and **Completion contract** sections are fixed boilerplate: copy them verbatim into every documentation sprint. Every executor, `/goal` or an inline session, works from the same brief.

---

### {{DOC-SPRINT-DOCUMENT-TEMPLATE}}

```markdown
# Documentation sprint: <title>

## Window

Planned against commit `<sha>`.

<One line per docspec in this documentation sprint: `docspec:<slug>`,
its stamp or `none`, and each reason `.ok-planner/bin/docs window`
gave for it. Then each sprint closed since the stamp that the plan
read for intent.>

## Owner answers

<Each change in the window whose intent no sprint explains, and the
owner's answer: the documentation describes it as it stands, or
leaves it out, with the issue filed for `/plan-sprint`. Omit the
section when there are none.>

## Items

### docspec:<slug>

Worked example: <`<path>` at `<sha>`, as the owner approved it; or
``draft below, written to `<file>` ``, with the draft of one entry in
the docspec's shape the owner approved, and the file its entry goes
in; or `declined`; or `none`.>

- `<file>`: write | change | drop | check. Rules: <each rule that
  fires, and the fact that fires it, or `none` for a check>. Claims to
  check again: <the id of each ledger claim `.ok-planner/bin/docs
  claims <slug> --stale` lists for this file, or `none`>.

<Or, for a docspec the window reached where nothing its reader sees
changed, the one line `No item: nothing its reader sees changed.`>

## How to execute this documentation sprint

This documentation sprint is self-sufficient. Every executor runs the
same shape: record the base, file one writer task per item that
writes, a style task per file the writers changed, and checker tasks
over the claims, then loop on false claims until every claim holds or
is cut. No code changes in this run but doc comments.

1. Read the documentation sprint whole first. It is the whole brief.
   Where `/goal` handed you this file, its checker is a separate model
   that reads only the session: it opens no file and runs no command.
   State its stop condition in your first message, in these words:
   "This goal is met when `.ok-planner/bin/docs complete --sprint
   <this file's path>` prints `DOCS COMPLETE` in this session.
   Archiving, committing, and the stamps are the owner's acts, not
   goal terms."

2. Follow `{{CEREMONY-RUN-RULES}}` in
   `.claude/skills/_sprint/shared.md` for the whole run.

3. Record the base. The code holds still while the run works, so the
   tree holds nothing but this run's work from here on. Where `git
   status --porcelain` lists a path outside `.ok-planner/`, name those
   paths to the owner and stop. Otherwise write the output of `git
   rev-parse HEAD` to the file beside this one with the same filename,
   `-base` before the extension and `.txt` as the extension.

4. Open the run. `.ok-planner/bin/tasks`, `.ok-planner/bin/docs`, and
   the profile `ok-opus` under `.claude/agents/` are required; a
   missing one is the front door's administration (`/ok`) to
   materialize: say so and stop. `tasks init <name> --file
   .ok-planner/doc-sprints/<name>-run.jsonl`, `tasks agent register
   ok-opus`, and for each of `{{DOC-WRITE-PROMPT}}`,
   `{{DOC-STYLE-PROMPT}}`, and `{{DOC-CHECK-PROMPT}}` in
   `.claude/skills/plan-docs/core.md`, write the block, its
   transclusions resolved and `[DOC SPRINT PATH]` filled, to
   `.ok-planner/doc-sprints/<name>-<write|style|check>.md`, and
   register it: `tasks prompt register <write|style|check> <that
   path>`. Declare the pools: `tasks config set item_states
   '{"claims": ["open", "held", "false", "cut", "replaced"], "edits":
   ["recorded"], "style": ["recorded"], "calls": ["open"]}'`.

5. Write. Per `write`, `change`, or `drop` item, file one writer
   task: `tasks file --role write --prompt write --agent ok-opus --key
   <slug>:<file> --files <file> --brief "<the docspec, the file, write
   | change | drop, the rules that fire and their facts, the claims to
   check again, and the worked example>"`. An in-code item's file is
   the source file whose doc comments it writes. A `check` item gets no
   writer. Drain.

6. The style pass. List the files the writers changed that still
   exist: `git diff --name-only --no-renames --diff-filter=d <base>`
   and the untracked files `git status --porcelain` lists, kept to the
   files the items name. Per such file, file one style task: `tasks
   file --role style --prompt style --agent ok-opus --key
   <slug>:<file> --files <file> --brief "<the docspec, the file, its
   stamp or none, and the worked example>"`. Drain.

7. The fact loop. File checker tasks of up to six files each, files of
   one docspec together: `tasks file --role check --prompt check
   --agent ok-opus --key <slug>:<round>:<n> --brief "<the docspec; per
   file, every claim in it where the run changed it, the item is a
   `check` of a file changed since the stamp, or the docspec has no
   stamp; otherwise the ids of the claims to check again>"`, `<round>`
   counting from 1. The first checker task of a docspec in round 1
   also lists the classes its `## Lists` names, where it has that
   section, and runs its `## Generator` command, where its Where
   starts `in code:` and the section names one. A checker writes no
   file: it records each claim in the `claims` pool as `held` or
   `false`. Drain. Then, while `tasks item count --pool claims --state
   false` is above zero: per file holding a false claim, file one
   writer task `tasks file --role fix --prompt write --agent ok-opus
   --key <slug>:<file>:<round> --files <file> --brief "fix: <the false
   claim ids and what the checker found>"`, drain, then file checker
   tasks over the claims the fixers set `open`, and drain. The loop
   has no cap: a document makes a finite number of claims, and the
   code holds still.

   Where a docspec's `## Generator` says its output is committed, file
   one writer task once the loop ends: `tasks file --role write
   --prompt write --agent ok-opus --key <slug>:generate --files <the
   output path the section names> --brief "generate: run the
   docspec's generator in the project and stage its output"`, and
   drain.

8. Report. Write the output of `.ok-planner/bin/docs report --sprint
   <this file's path>` to the completion report, beside this file with
   `-completion` before the extension. Then run
   `.ok-planner/bin/docs complete --sprint <this file's path>` and
   show its output whole. Where it prints `DOCS NOT COMPLETE`, work
   each failure it names; a failure you cannot work is a genuine
   blocker.

9. Present the completion report to the owner: each edit with its
   rule, each claim cut with why, each file the style pass skipped
   with why, and each call an agent made, for the owner's veto. For
   each vetoed call, file one issue with `.ok-planner/bin/issues file
   --from -` in the format of the `{{ISSUE-FILE-FORMAT}}` block of
   `.claude/skills/_shared/artifact-definitions.md`: kind `human`,
   category `product-intent`, its problem the call. Then offer the
   archive and the commit:

**The archive and the commit.** Follow `{{CEREMONY-ARCHIVE}}` in
`.claude/skills/_sprint/shared.md`, with `<folder>` as `doc-sprints`
and `<stamp command>` as `.ok-planner/bin/docs stamp --sprint
.ok-planner/history/doc-sprints/<this file's name> --commit <sha>`.
The stamp records each docspec's stamp, its claim ledger, and the
worked example an approved draft became in `.ok-planner/doc-state/`,
and adds `closed: <sha>` to this file.

## Completion contract

The work is done when all of the following hold, each verifiable from
the repository as it stands:

1. Every writer, style, checker, and fix task of the run, the latest
   for each key, closed `done`. Every `write`, `change`, or `drop` item
   has a writer task, every file the run changed that still exists has
   a style task, and every docspec with a `## Generator` command has
   its run recorded.
2. Every claim the checkers recorded stands `held`, `cut`, or
   `replaced`.
3. The completion report beside this file (same filename with
   `-completion`) exists.

**The goal rule, for any checker verifying this contract.** The goal
is met when items 1 to 3 verify against the repository as it stands.
`.ok-planner/bin/docs complete --sprint <this file's path>` checks
them and prints `DOCS COMPLETE` or `DOCS NOT COMPLETE`. A checker that
reads only the session, as `/goal`'s does, decides from that command's
latest output in the session; a checker that runs commands runs it.
Presenting the report, archiving, committing, and the stamps follow
completion, and none is a term of the goal. A documentation sprint
archived with a `closed:` stamp is terminal. Nothing else counts
either way.
```
