---
issue: markdown-intake-import-then-move-half-change
kind: audit
category: design
artifacts:
  - story:converge-project-estate
  - decision:issue-records-in-one-file
status: verified
triage: question
opened: 2026-10-05T12:23:52Z
---

# A failed file move during the intake migration leaves the project half-migrated, and the next `/ok` imports the same issues twice

The suite is retiring its old intake, one markdown file per issue, for one JSON Lines file of records (decision:issue-records-in-one-file). The front door's converge core migrates a project in one accepted offer: it imports a record for each issue file, then moves each file to the history folder. The same order serves the older `design/tensions/` layout. If one move fails partway, the project holds records in the new store while some source files still stand in the live folder. No complete run produces that state. The next `/ok` then offers the migration again and imports the unmoved issues a second time under new ids. That breaks story:converge-project-estate, which promises an upgrade "in one deliberate act" that "never costs me work I wrote". Accept-list entries A1 (stored state half-changed) and A7 (accepted data doubled) name both harms.

## Mechanism

`resolve` in `plugins/ok/families/ok-planner/admin/converge` handles the `markdown-intake` and `tensions` offers. It writes two stores in sequence. First, `import_issues` writes every record to `.ok-planner/issues.jsonl` in one transaction of the intake module. Then a loop calls `move_path` once per file, and each call runs its own `git mv`. A `git mv` fails when, for example, another git process holds `.git/index.lock`. The failure raises mid-loop. Nothing rolls the import back, and nothing records which files moved.

The owner then meets two things. Every intake verb but `import` refuses while a markdown file stands under `.ok-planner/issues/`, and names the `markdown-intake` offer. So the owner runs `/ok` again. The offer assigns each file its `issue:` value as its id only where no open issue already carries that id. The first run imported that id, so the offer derives a fresh one, `<slug>-2`. The draft checks compare the draft to the offer's ids and sources, never to records already in the store. The import skips a record only when the same id holds identical content. An owner who accepts imports each unmoved issue a second time. The filed report said the second import is refused; at this tree it succeeds, which is worse.

## State of play

Each step checks its own inputs: the draft checks refuse a malformed draft, the intake module refuses a malformed record and writes nothing, and the verbs refuse while markdown files stand. No step handles a resume.

Sprint certification of `2026-10-05-issue-dashboard.md` (run `converge-2026-10-05T045158`, defect i30) tried two fixes, then backed both out:

1. Fix task t18 moved every file first, then imported, and moved the files back where the import refused. Verifier t22 sent it back: "owned-paths check fails on converge:598; rollback move adds a split write on the refused-import path". The move back is a second write that can itself fail, and `checks/owned-paths` did not list the new move call site.
2. Fix task t24 returned to import first, then move, and taught the next `/ok` to offer a move-only resolve for files whose records already stand. It closed partial because `admin/ADMINISTRATION.md` still described the first fix, and that file lay outside its task. No verifier ruled on its code.

The tree stands as the sprint built it. A fix touches `admin/converge` (`resolve`, `markdown_plan`, the two offers), `admin/ADMINISTRATION.md` (the offer table, the draft checks, the markdown-intake paragraph, the pre-4.0 tensions paragraph), and `checks/owned-paths` for any new move call site. Project rule plumbline-coding 3.1 asks that a change writing more than one resource run in one transaction. A JSON Lines file and the git index cannot share one transaction, so a fix can only make the partial state recoverable or narrow its window.

## Options

1. **Resume.** Keep import first, then move. The next `/ok` recognizes a file whose record already stands, matched by the record's `source` field, and offers to move it without importing again. The administration document describes the resumed state. Cost: the half-migrated state becomes a documented state the offer must recognize.
2. **Move first, roll back on refusal.** Move every file, then import, and move the files back where the import refuses (the first fix tried). Cost: the move back is a second write that can fail, and each new move call site joins `checks/owned-paths`.
3. **Move first, import later.** Move every file, then import. Where the import refuses, leave the files in history, and have the next `/ok` import from there. Cost: between the two runs the issues stand in neither the live intake nor the store. The verbs no longer refuse, so `issues list` and triage run without those issues.
4. **Validate, then move in one call, then import.** Dry-run the import through the intake module, move every file in one `git mv`, then import. Cost: the window narrows but stays open, since the import after the move can still fail, and the intake module needs a dry-run verb.

The ruling decides how the intake migration recovers when a resolve stops between its import and its moves.

## Ruling

> Recommended ruling (/triage-issues): Option 1. Keep the import first. Make the `markdown-intake` and `tensions` offers recognize a source file whose record already stands, matched by its `source`, and finish its move without importing it again. Describe that resumed state in the administration document.
>
> Rationale: the two stores cannot share one transaction, so the fix chooses which partial state a failure leaves and how the next run finishes it. Option 1 leaves the one partial state the tree already guards: the intake verbs refuse while a markdown file stands, and their refusal names the offer that finishes the job. A rerun then completes the migration, the way concept:true-up describes converge as idempotent. Option 3 leaves a state nothing guards, where the issues vanish from every reader. Option 2 repeats the fix a verifier already sent back. Option 4 can still fail after its move and needs a new verb. The source match also closes the doubled import, which is the worse harm. The flip case: if the owner reads rule 3.1 as forbidding any recoverable partial state, option 4's single move narrows the window most, and it can join option 1 as a second step.

<!-- Owner: this is a recommendation, not your decision. Leave it
as-is to accept; the next /plan-sprint carries it. Edit the text to
redirect, empty the section to discuss live, or delete this note to
adopt the ruling as your own. -->
