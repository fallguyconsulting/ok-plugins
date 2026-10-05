---
name: triage-issues
description: "ONLY activated by explicit /triage-issues slash command, or as the step /converge's owner list names after it writes issues. Never auto-triggered by conversation content. Triages every untriaged issue in the intake, in a fresh task ledger. A defect claim whose harm the accept list covers and whose fix leaves the design corpus as it stands becomes a `category: defect` issue with a generated ruling, for the next /converge. A defect claim the accept list does not cover is retired, unless it proposes a new entry. A harm whose fix lies in a part the project does not own, a proposed entry or a change to a suite-owned file among them, becomes an upstream issue with a draft ready to file and stays in the intake for the next /plan-sprint, until the project no longer shows the harm. Any other issue that needs the owner's judgment, about the product or the project's own tooling, goes to the next /plan-sprint with a generated ruling where the rules decide the change and a recommended ruling where an owner must choose. An issue the code, the corpus, or the tooling already settles is answered. Triage agents and author agents claim their own tasks from the tracker, one cached prefix per profile."
---

# Triage the issue intake

This skill verifies the issue intake. The Defect issues section of `.claude/rules/ok-planner-cheatsheet.md` defines the two kinds of issue the intake holds.

**Every issue leaves triage on one of six routes.** An issue is either a defect claim or a judgment issue. A defect claim asserts that the code is wrong and asks only that it be fixed: `category: defect`, or a Problem whose one Candidate fixes a code site. A judgment issue asks the owner to choose: what the product commits to, or how the project's own tooling works (its skills, prompts, and rules). A harm whose fix lies in a part the project does not own is an upstream issue: a suite-owned file, as the Defect issues section defines it, a library the project depends on, an outside tool or service, or the suite's accept list itself, for a harm the list does not name. The project cannot fix such a harm in place, so the issue waits in the intake for the owner. The accept list at `.ok-planner/review/catalog/accept.md` filters defect claims alone, as it stands: an entry the issue proposes counts for nothing until the suite adopts it. A judgment issue reaches the owner with a ruling, whatever the accept list says. How the fix touches the design corpus under `.ok-planner/design/` decides between the last three routes.

| Route | When | What the file becomes | Who takes it next |
|---|---|---|---|
| `answered` | The code no longer shows the problem, a live corpus artifact squarely decides the question, or the tooling now does what the issue asks. For an upstream issue, the project no longer shows its harm, as after an update of the foreign part. | `status: answered`, a closure note, moved to `history/issues/`. | Nobody. The report lists it for veto. |
| `upstream` | The fix lies in a part the project does not own: a change to a suite-owned file (a vendored skill, prompt, rule, or catalog), a library the project depends on, an outside tool or service, or a proposed accept-list entry the list as it stands does not cover. A `tooling` issue whose change falls in a suite-owned file routes here. | `category: upstream`, `status: verified`, a verified narrative, a `## Upstream issue` section ready to file, `## Options` (a workaround, a filing upstream, or both), and a recommended ruling. | `/plan-sprint`, which walks it with the owner. It stays open while the project shows the harm. |
| `retired` | A defect claim that no accept-list entry, A1 to A9, covers as a harm the code causes today at a site the agent can name. | `status: retired`, the reason under `## Ruling`, moved to `history/issues/`. | Nobody. The report lists it for veto. |
| `defect` | An entry covers the harm, and the fix leaves the corpus as it stands. How many ways the code could be fixed does not matter: the fixer picks the mechanism. | `category: defect`, `status: verified`, a Problem that names the site, the entry, the trigger, the harm, and the evidence, and a generated ruling. | `/converge`, in `drive`, `analysis`, or `defects` mode. |
| `corpus` | The harm, or an A8 misfire, comes from corpus text the rules already decide: text that contradicts a later ruling, or that the code and a counterpart artifact both contradict. A stale commitment makes every later `/converge` report correct code as an A8 defect. | `status: verified`, a verified narrative, and a generated ruling naming the corpus change. | `/plan-sprint`, because no `/converge` agent edits the corpus. |
| `question` | A judgment issue the code, the corpus, and the tooling do not settle: two live commitments conflict, a promise must be added, dropped, widened, or narrowed, or the project's own tooling must change, and reasonable owners would choose differently. An entry-covered harm whose removal needs such a choice routes here too. | `status: verified`, a verified narrative with `## Options`, and a recommended ruling. | `/plan-sprint`. |

Each triaged file carries `triage: <route>` in its frontmatter. That stamp is what makes the run idempotent.

## The scope

The scope is every file directly under `.ok-planner/issues/` whose `## Ruling` is empty, missing, or holds only a blockquote marked `Generated ruling` or `Recommended ruling`, and that carries no `triage:` field or carries `triage: upstream`. A `triage: upstream` file is in scope for one check alone: whether the project still shows its harm. A Ruling that holds any other text is the owner's: the file is out of scope, whatever its status. `promoted` files are out of scope. Zero files in scope: say so and stop.

## Setting up the run

1. **Preconditions.** `.ok-planner/bin/tasks`, the profile `ok-opus` under `.claude/agents/`, and `.ok-planner/review/catalog/accept.md` exist; otherwise say which is missing and stop. Say the run's shape in one line: the count of files in scope, open and verified.
2. **Open a fresh ledger.** `tasks init triage-issues-<date>T<time> --file .ok-planner/tasks/triage-issues-<date>T<time>.jsonl`, the timestamp from `date +%Y-%m-%dT%H%M%S`. Never `tasks use` an existing file.
3. **Register** the profile `ok-opus` with `tasks agent register`, and the prompts `triage` and `author` with `tasks prompt register <name> .claude/skills/triage-issues/prompts/<name>.md`.
4. **Declare the vocabulary**: `tasks config set item_states '{"issues": ["open", "batched"], "questions": ["open", "batched"]}'`.

## Phase 1: triage

1. **File the issues.** One item per file in scope, in order of the first artifact each frontmatter lists, then by filename: `tasks item add --pool issues --key triage --field file=.ok-planner/issues/<name> --field artifact=<the first artifact, or none> --body "<name>"`.
2. **Batch them.** `tasks batch --pool issues --key triage --state open --size 6 --prompt triage --agent ok-opus --role triage --mark batched`. The batch keeps filing order, so issues that cite the same artifact mostly share a task, and one agent reads that artifact once. Each task may edit exactly the issue files it holds.
3. **Drain** with the drain loop at `.claude/skills/_tasks/drain.md` under its default cap. A task that closed `partial` is refiled once with `tasks refile <task>`. A second `partial`, or a close at `blocked` or `disputed`, is named in the report, and its unfinished files stay in scope for the next run.

A triage agent writes the `answered`, `retired`, and `defect` files itself. For an `upstream`, `question`, or `corpus` issue it leaves the file untouched and files a brief into the `questions` pool. A `triage: upstream` file whose harm the project still shows stays untouched, and nothing is filed for it. The author writes the body and the stamp, so a file whose author never finishes stays in scope for the next run.

## Phase 2: author

1. **Batch the briefs.** Where `tasks item count --pool questions --key triage --state open` is non-zero: `tasks batch --pool questions --key triage --state open --size 4 --prompt author --agent ok-opus --role author --mark batched`. Triage agents file briefs in their batch's order, so related briefs stay together.
2. **Drain** with the drain loop at `.claude/skills/_tasks/drain.md`, and handle a `partial` close as in phase 1.

## Closing the run

1. **Move the closed files.** For every file under `.ok-planner/issues/` whose frontmatter reads `status: answered` or `status: retired`: `git mv` it to `.ok-planner/history/issues/` under the same name. Stage every other file the run edited, by name.
2. **Check the stamps.** Every file the run took in scope now carries `triage:`, or its task is named in the report as unfinished.

## The report

Present one block:

- `scope`: files taken, open and verified.
- `routes`: the count per route.
- `retired` and `answered`: each file's slug and one-line reason. This is the veto list: the owner restores a file by moving it back and deleting its `triage:` stamp.
- `to /converge`: each `defect` slug with its accept-list entry.
- `to /plan-sprint`: each `corpus` slug with its one-line fix, then each `question` slug with its one-line recommendation, then each `upstream` slug, routed this run or re-checked and still showing its harm, with the foreign part and its one-line recommendation. Skimming this list is the owner's whole review.
- `unfinished`: tasks that closed other than `done`, and their files.
- `cost`: the usage `tasks status` totals.

Commit only on the owner's word. Do not push.
