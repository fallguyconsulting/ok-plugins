# The documentation sprint document

`/plan-docs`'s terminal artifact, defined once. `/plan-docs` writes every documentation sprint from this template and never restates it.

`{{DOC-SPRINT-DOCUMENT-TEMPLATE}}` is the whole document. Its **How to execute this documentation sprint** and **Completion contract** sections are fixed boilerplate: copy them verbatim into every documentation sprint. Every executor, `/goal` or an inline session, works from the same brief.

---

### {{DOC-SPRINT-DOCUMENT-TEMPLATE}}

```markdown
# Documentation sprint: <title>

## Window

Planned against commit `<sha>`.

The window read tree `<tree>`.

<`<sha>` is the commit and `<tree>` the tree `/plan-docs` recorded at
its window. One line per docspec in this documentation sprint: `docspec:<slug>`,
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
   <this file's path>` prints `DOCS COMPLETE` in this session. The
   goal also ends, unmet, when that command prints `DOCS STOPPED` in
   this session, or when `ls .ok-planner/bin/tasks
   .ok-planner/bin/issues .ok-planner/bin/review .ok-planner/bin/docs`
   reports one of them missing in this session: the run stopped, and
   the owner takes up the reason.
   Archiving, committing, and the stamps are the owner's acts, not
   goal terms." Then, where the stop record `<name>-stopped.txt`
   stands beside this file, delete it before the run goes on, so this
   goal takes the run up again.

2. Follow `{{CEREMONY-RUN-RULES}}` in
   `.claude/skills/_sprint/shared.md` for the whole run.

3. Check that the run can start, then record the base. Every check
   here runs before the base is written; where one stops the run,
   stop it as `{{CEREMONY-RUN-RULES}}` says, with its message as the
   reason. First run `ls .ok-planner/bin/tasks .ok-planner/bin/issues
   .ok-planner/bin/review .ok-planner/bin/docs` and show its output
   whole. `docs complete` loads the other three, so where the `ls`
   reports one missing, no command can print `DOCS STOPPED`: write the
   stop record naming each missing tool and saying that the front
   door's administration (`/ok`) materializes it, then stop without
   running `docs complete`. That `ls` output ends the goal. Then check
   the profile `ok-opus` under `.claude/agents/`: a missing one is
   `/ok`'s to materialize too, so stop and say so. Then run
   `.ok-planner/bin/docs start --sprint <this file's path>` and show
   its output whole. Where it exits 2, a product commit made after the
   plan bears on a planned docspec with a change the plan did not
   read, and where it exits
   1, it could not read the planned commit; either way the plan must
   be made again, so stop, with the stop record's first line `docs
   start: the plan must be made again` and its output after it.
   Where the base file stands beside this file (the same filename,
   `-base` before the extension and `.txt` as the extension), the run
   stopped before and resumes: keep that base, skip the
   uncommitted-paths check, and go on to step 4.
   Where no base stands, the code holds still while the run works, so
   the tree holds nothing but this run's work from here on. Where `git
   status --porcelain` lists a path outside `.ok-planner/`, stop,
   naming those paths. Otherwise write the output of `git rev-parse
   HEAD` to the base file.

4. Open the run. Where `.ok-planner/doc-sprints/<name>-run.jsonl`
   stands, the run resumes: run `tasks use <that path>`, then `tasks
   retry --all`, which issues again every task that did not close
   `done` and every task an agent claimed and never closed. Otherwise
   run `tasks init <name> --file
   .ok-planner/doc-sprints/<name>-run.jsonl`. Either way, run every
   registration and config below, again on a resumed run: `tasks agent
   register ok-opus`, and for each of `{{DOC-WRITE-PROMPT}}`,
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
   check again, and the worked example>"`. The brief of an item under a
   docspec the window shows `retired` also names the commit the window
   read the docspec at. An in-code item's file is
   the source file whose doc comments it writes. A `check` item gets no
   writer. On a resumed run, here and in steps 6 and 7, file no task
   whose role and key the run already holds, as `tasks report` lists
   them, the tasks that closed among them. Drain.

6. The style pass. List the files the writers changed that still
   exist: `git diff --name-only --no-renames --diff-filter=d <base>`
   and the untracked files `git status --porcelain` lists, kept to the
   files the `write` and `change` items name. Per such file, file one
   style task: `tasks file --role style --prompt style --agent ok-opus
   --key <slug>:<file> --files <file> --brief "<the docspec, the file, its
   stamp, or `none` where the docspec is planned as new, and the worked
   example>"`. A docspec is planned as new where its Window line gives
   the stamp as `none`, or gives the window's reason that the stamp is
   not a commit this repository holds. Drain.

7. The fact loop. File checker tasks of up to six files each, files of
   one docspec together: `tasks file --role check --prompt check
   --agent ok-opus --key <slug>:<round>:<n> --brief "<the docspec; per
   file, every claim in it where the item is a `write` or `change`,
   the item is a `check` of a file changed since the stamp, or the
   item is a `check` of a file the docspec's `taken` reason names, or
   the docspec is planned as new; otherwise the ids of the claims to check
   again>"`, `<round>`
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
   code holds still. On a resumed run, the loop goes on from the
   highest `<round>` the keys of the run's `check` and `fix` tasks
   hold, as `tasks report` lists them: each task it files from there
   counts from the round after it.

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
   each failure it names. A failure you cannot work is a genuine
   blocker: stop the run as `{{CEREMONY-RUN-RULES}}` says, with each
   such failure a line of the stop record.

9. Present the completion report to the owner: each edit with its
   rule, each claim cut with why, each file the style pass skipped
   with why, and each call an agent made. Then follow
   `{{CEREMONY-VETO}}` in `.claude/skills/_sprint/shared.md`, with
   `<rows>` as the calls and `<problem>` as the call. Then offer the
   archive and the commit:

**The archive and the commit.** Follow `{{CEREMONY-ARCHIVE}}` in
`.claude/skills/_sprint/shared.md`, with `<folder>` as `doc-sprints`,
`<also>` as none, and `<stamp command>` as `.ok-planner/bin/docs stamp --sprint
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
   a style task, except the file of a `drop` item, and every docspec
   with a `## Generator` command has its run recorded.
2. Every claim the checkers recorded stands `held`, `cut`, or
   `replaced`. Every file a `write` or `change` item names that still
   exists has a claim the checkers recorded with scope `file`, and
   every file a `check` item names holds a claim the checkers
   recorded.
3. The completion report beside this file (same filename with
   `-completion`) exists.

**The goal rule, for any checker verifying this contract.** The goal
is met when items 1 to 3 verify against the repository as it stands.
`.ok-planner/bin/docs complete --sprint <this file's path>` checks
them and prints `DOCS COMPLETE` or `DOCS NOT COMPLETE`. While the stop
record `<name>-stopped.txt` stands beside this documentation sprint, it
prints `DOCS STOPPED` with the record's reason and checks nothing else:
that line ends the goal while the contract stays unmet, and the owner
takes up the reason. Where the `ls` of step 3 reports a tool that
command loads missing, the command cannot run, and that `ls` output
ends the goal the same way. A checker that
reads only the session, as `/goal`'s does, decides from that command's
latest output in the session; a checker that runs commands runs it.
Presenting the report, archiving, committing, and the stamps follow
completion, and none is a term of the goal. A documentation sprint
archived with a `closed:` stamp is terminal. Nothing else counts
either way.
```
