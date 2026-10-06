---
name: triage-issues
description: "ONLY activated by explicit /triage-issues slash command, or as the step /converge's owner list names after it writes issues. Never auto-triggered by conversation content. Triages every untriaged issue in the intake store, and answers every owner message triage has not yet seen, in a fresh task ledger, reading and writing the store only through .ok-planner/bin/issues. A defect claim whose harm the accept list covers and whose fix leaves the design corpus as it stands becomes a `category: defect` issue with a generated ruling, for the next /converge. A defect claim the accept list does not cover is retired, unless it proposes a new entry. A harm whose fix lies in a part the project does not own, a proposed entry or a change to a suite-owned file among them, becomes an upstream issue with a draft ready to file and stays in the intake for the next /plan-sprint, until the project no longer shows the harm. Any other issue that needs the owner's judgment, about the product or the project's own tooling, goes to the next /plan-sprint with a generated ruling where the rules decide the change and a recommended ruling where an owner must choose. An issue the code, the corpus, or the tooling already settles is answered. Each owner comment or ruling triage has not yet seen gets a reply where it asks something and a revision where it shows the issue wrong or thin, and is marked seen once acted on; the owner's ruling is never rewritten. Every citation triage writes becomes a link to the cited file, a record with a broken link is relinked, and `/triage-issues links` relinks every open issue. Triage, author, and respond agents claim their own tasks from the tracker, one cached prefix per profile."
---

# Triage the issue intake

This skill verifies the issue intake and answers the owner's messages on it. The Defect issues section of `.claude/rules/ok-planner-cheatsheet.md` defines the two kinds of issue the intake holds. The intake is the store `.ok-planner/issues.jsonl`, one record per open issue, and its archive `.ok-planner/history/issues.jsonl`, which holds closed records. Every read and write goes through `.ok-planner/bin/issues`: the run and its agents never edit either file by hand.

**Every issue leaves triage on one of six routes.** An issue is either a defect claim or a judgment issue. A defect claim asserts that the code is wrong and asks only that it be fixed: `category: defect`, or a problem whose one option fixes a code site. A judgment issue asks the owner to choose: what the product commits to, or how the project's own tooling works (its skills, prompts, and rules). A harm whose fix lies in a part the project does not own is an upstream issue: a suite-owned file, as the Defect issues section defines it, a library the project depends on, an outside tool or service, or the suite's accept list itself, for a harm the list does not name. The project cannot fix such a harm in place, so the issue waits in the intake for the owner. The accept list at `.ok-planner/review/catalog/accept.md` filters defect claims alone, as it stands: an entry the issue proposes counts for nothing until the suite adopts it. A judgment issue reaches the owner with a ruling, whatever the accept list says. How the fix touches the design corpus under `.ok-planner/design/` decides between the last three routes.

| Route | When | What the record becomes | Who takes it next |
|---|---|---|---|
| `answered` | The code no longer shows the problem, a live corpus artifact squarely decides the question, or the tooling now does what the issue asks. For an upstream issue, the project no longer shows its harm, as after an update of the foreign part. | Closed as `answered` with a reason, its record moved to the archive. | Nobody. The report lists it for veto. |
| `upstream` | The fix lies in a part the project does not own: a change to a suite-owned file (a vendored skill, prompt, rule, or catalog), a library the project depends on, an outside tool or service, or a proposed accept-list entry the list as it stands does not cover. A `tooling` issue whose change falls in a suite-owned file routes here. | `route: upstream`, `category: upstream`, a verified narrative as its `problem`, an `upstream` draft ready to file, three `options` (a workaround, a filing upstream, or both), and a recommended ruling. | `/plan-sprint`, which walks it with the owner. It stays open while the project shows the harm. |
| `retired` | A defect claim that no accept-list entry, A1 to A9, covers as a harm the code causes today at a site the agent can name. | Closed as `retired` with the reason, its record moved to the archive. | Nobody. The report lists it for veto. |
| `defect` | An entry covers the harm, and the fix leaves the corpus as it stands. How many ways the code could be fixed does not matter: the fixer picks the mechanism. | `route: defect`, `category: defect`, a `problem` that names the site, the entry, the trigger, the harm, and the evidence, and a generated ruling. | `/converge`, in `drive`, `analysis`, or `defects` mode. |
| `corpus` | The harm, or an A8 misfire, comes from corpus text the rules already decide: text that contradicts a later ruling, or that the code and a counterpart artifact both contradict. A stale commitment makes every later `/converge` report correct code as an A8 defect. | `route: corpus`, a verified narrative as its `problem`, and a generated ruling naming the corpus change. | `/plan-sprint`, because no `/converge` agent edits the corpus. |
| `question` | A judgment issue the code, the corpus, and the tooling do not settle: two live commitments conflict, a promise must be added, dropped, widened, or narrowed, or the project's own tooling must change, and reasonable owners would choose differently. An entry-covered harm whose removal needs such a choice routes here too. | `route: question`, a verified narrative as its `problem`, `options`, and a recommended ruling. | `/plan-sprint`. |

A routed record carries its route in `route`, and a closed one sits in the archive. A message triage has acted on carries a `seen` mark. Those three facts make the run idempotent: a routed or closed record leaves the routing scope, and a seen message leaves the answering scope.

Triage writes only a marked ruling: the record's `recommendation`, generated or recommended. The owner's `ruling` is the owner's alone, and no agent of this run writes it. An agent of this run never closes a record that carries a `ruling`.

## The scope

List the store with `.ok-planner/bin/issues list --json`. It writes a note on stderr for each markdown issue file or stray line it skips; pass those notes to the owner, and go on. A record whose `sprint` is set is promoted: the sprint is its source of truth, and it is out of scope. Of the other records, the scope is the union of three parts:

- **Unrouted**: every record with no `route` and no `ruling` (state `open`). Phases 1 and 2 route it.
- **Upstream re-check**: every record with `route: upstream` and no `ruling`. Phase 1 checks one thing alone: whether the project still shows its harm.
- **Owner messages**: every record with an owner message at `seen: null` (`unseen` above zero), routed, ruled, or neither. Phase 3 answers it. A ruled record with no route is not routed, but its messages are answered.
- **Broken links**: every record `.ok-planner/bin/issues links --broken --json` lists. Phase 4 relinks it.

Invoked as `/triage-issues links`, the run takes one part alone: every live record not promoted, whatever its links. It skips phases 1 to 3 and runs phase 4 over them, so the owner can link the issues filed before triage wrote links, or relink after the tree moved.

Zero records in scope: say so and stop.

## Setting up the run

1. **Preconditions.** `.ok-planner/bin/tasks`, `.ok-planner/bin/issues`, the profile `ok-opus` under `.claude/agents/`, and `.ok-planner/review/catalog/accept.md` exist; otherwise say which is missing and stop. Say the run's shape in one line: the count of records in each part of the scope.
2. **Open a fresh ledger.** `tasks init triage-issues-<date>T<time> --file .ok-planner/tasks/triage-issues-<date>T<time>.jsonl`, the timestamp from `date +%Y-%m-%dT%H%M%S`. Never `tasks use` an existing file.
3. **Register** the profile `ok-opus` with `tasks agent register`, and the prompts `triage`, `author`, `respond`, and `links` with `tasks prompt register <name> .claude/skills/triage-issues/prompts/<name>.md`.
4. **Declare the vocabulary**: `tasks config set item_states '{"issues": ["open", "batched"], "questions": ["open", "batched"], "messages": ["open", "batched"], "links": ["open", "batched"]}'`.

Every task this run files may edit exactly the two store files, through the module: pass `--files .ok-planner/issues.jsonl .ok-planner/history/issues.jsonl` to every `tasks batch`. The module's lock serializes the agents' writes.

## Phase 1: triage

1. **File the issues.** One item per unrouted or upstream re-check record, in order of the first artifact each record lists, then by `opened`: `tasks item add --pool issues --key triage --field id=<the record id> --field artifact=<the first artifact, or none> --body "<the record id>"`.
2. **Batch them.** `tasks batch --pool issues --key triage --state open --size 6 --prompt triage --agent ok-opus --role triage --mark batched --files .ok-planner/issues.jsonl .ok-planner/history/issues.jsonl`. The batch keeps filing order, so issues that cite the same artifact mostly share a task, and one agent reads that artifact once.
3. **Drain** with the drain loop at `.claude/skills/_tasks/drain.md` under its default cap. A task that closed `partial` is refiled once with `tasks refile <task>`. A second `partial`, or a close at `blocked` or `disputed`, is named in the report, and its unfinished records stay in scope for the next run.

A triage agent writes the `answered`, `retired`, and `defect` routes itself. For an `upstream`, `question`, or `corpus` issue it leaves the record unrouted and files a brief into the `questions` pool. The author writes the narrative and the route in one write, so a record whose author never finishes stays in scope for the next run. An upstream re-check record whose harm the project still shows keeps its route; the triage agent revises its analysis only where its facts have rotted, through `issues respond`'s update message, so the owner sees the change as new analysis.

## Phase 2: author

1. **Batch the briefs.** Where `tasks item count --pool questions --key triage --state open` is non-zero: `tasks batch --pool questions --key triage --state open --size 4 --prompt author --agent ok-opus --role author --mark batched --files .ok-planner/issues.jsonl .ok-planner/history/issues.jsonl`. Triage agents file briefs in their batch's order, so related briefs stay together.
2. **Drain** with the drain loop at `.claude/skills/_tasks/drain.md`, and handle a `partial` close as in phase 1.

## Phase 3: respond

1. **File the messages.** List the store again with `issues list --json`, since phases 1 and 2 changed it. One item per live record not promoted that holds an owner message at `seen: null`, in order of the first artifact each record lists, then by `opened`: `tasks item add --pool messages --key triage --field id=<the record id> --field artifact=<the first artifact, or none> --body "<the record id>"`. Where none holds one, skip to closing.
2. **Batch them.** `tasks batch --pool messages --key triage --state open --size 4 --prompt respond --agent ok-opus --role respond --mark batched --files .ok-planner/issues.jsonl .ok-planner/history/issues.jsonl`.
3. **Drain** with the drain loop at `.claude/skills/_tasks/drain.md`, and handle a `partial` close as in phase 1. A message a respond agent did not act on keeps `seen: null`, so the next run takes it up.

## Phase 4: links

1. **File the records.** List the broken links again with `issues links --broken --json`, since phases 1 to 3 rewrote records; in a `links` run, list every live record not promoted instead. One item per record, in order of the first artifact each lists, then by `opened`: `tasks item add --pool links --key triage --field id=<the record id> --field artifact=<the first artifact, or none> --body "<the record id>"`. Where none, skip to closing.
2. **Batch them.** `tasks batch --pool links --key triage --state open --size 6 --prompt links --agent ok-opus --role links --mark batched --files .ok-planner/issues.jsonl .ok-planner/history/issues.jsonl`.
3. **Drain** with the drain loop at `.claude/skills/_tasks/drain.md`, and handle a `partial` close as in phase 1. A link pass changes only link markup, so it writes through `issues revise` and no update message.

## Closing the run

1. **Stage the store.** `git add` `.ok-planner/issues.jsonl` and `.ok-planner/history/issues.jsonl`, each that exists, by name. Closing an issue already moved its record to the archive: the run moves no file itself.
2. **Check the scope.** Every unrouted record the run took in scope is now routed or closed, every owner message phase 3 took now carries `seen`, or its task is named in the report as unfinished. `issues list --json` shows both.

## The report

Present one block:

- `scope`: records taken, unrouted, upstream re-check, with owner messages, and with broken links (or, in a `links` run, the records relinked).
- `routes`: the count per route.
- `retired` and `answered`: each record's id and one-line reason. This is the veto list: `issues show <id>` prints the archived record, and the owner restores one by filing it again with `issues file`.
- `to /converge`: each `defect` id with its accept-list entry.
- `to /plan-sprint`: each `corpus` id with its one-line fix, then each `question` id with its one-line recommendation, then each `upstream` id, routed this run or re-checked and still showing its harm, with the foreign part and its one-line recommendation. Skimming this list is the owner's whole review.
- `messages`: the records answered, the replies written, the updates written with the fields each revised, and the owner messages marked seen, summed from the respond and triage tasks' results; then each record a message left unanswered, with its task.
- `links`: the records relinked, the links written, repaired, and unlinked, summed from the links tasks' results, and any link `issues links --broken` still lists.
- `unfinished`: tasks that closed other than `done`, and their records.
- `cost`: the usage `tasks status` totals.

Commit only on the owner's word. Do not push.
