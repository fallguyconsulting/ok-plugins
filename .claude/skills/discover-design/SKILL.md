---
name: discover-design
description: "ONLY activated by explicit /discover-design slash command. Never auto-triggered by conversation content. ok-planner's corpus audit: it reads the code and the design corpus, empty or out of date, on the task tracker, and asks the owner nothing. Survey agents record the nouns, user outcomes, and choices each area of the code shows; check agents read each artifact against the current rules and the code; sort agents group what they found by artifact; merge agents draft the deltas the code settles and the questions only the owner can answer, each with both answers; a review checks the drafts. A script assembles one discovery document. The audit writes no corpus file and files no issue: the owner takes the discovery up with /plan-sprint, which holds the whole discussion."
---

# Discover Design

`/discover-design` audits a project's code and its design corpus and writes one **discovery**: a document under `.ok-planner/discoveries/` that says what the corpus needs to match the code and the current rules. It runs on an empty corpus and on an out-of-date one alike. The run asks the owner nothing, writes no file under `.ok-planner/design/`, and files no issue.

The owner takes the discovery up with `/plan-sprint`, naming its file, as they name a sketch. That session walks each question with the owner, carries every form-only change in without discussion, drafts every promise change into a sprint, and lists each promise change for the owner's veto at approval. The corpus changes only through that sprint.

The machinery lives beside this body. `core.md` holds what a finding is and the task prompts of the five roles: survey, check, sort, merge, and review. `../_shared/artifact-definitions.md` defines the artifacts, and `../_shared/dispatch-discipline.md` the agent rules. A `{{TOKEN}}` names the block of that name in one of these files, and resolves only where the token stands alone on its line. `.ok-planner/bin/discover` does the mechanical steps: the discoveries that stand, the areas, the artifacts, and the assembly.

## 1. Layout

`mkdir -p .ok-planner/discoveries .ok-planner/history/discoveries`. Estate true-up is the front door's administration (`/ok`).

`.ok-planner/bin/discover`, `.ok-planner/bin/tasks`, `.ok-planner/bin/review`, `.ok-planner/bin/issues`, `.ok-planner/review/config.json`, and the profile `ok-opus` under `.claude/agents/` are required: where one is missing, say that `/ok` materializes it, and stop.

Run `.ok-planner/bin/discover status`. One discovery stands at a time, and a discovery it lists still stands:

- **`assembled`**: name it, say that the owner takes it up with `/plan-sprint` naming its file, or moves every file starting with its name under `.ok-planner/history/discoveries/` to drop it, and stop.
- **`running`**: an earlier session stopped before it assembled. Resume it: select its run with `tasks use .ok-planner/discoveries/<name>-run.jsonl`, read `tasks status`, and settle every task that is not closed `done`, as step 2 says. Then go on from the first step below whose tasks have not all closed `done`; steps 2 and 3 are done where survey tasks stand. Its name, base file, and prompts stand from the earlier session.

Where `.ok-planner/design/_discover/` exists, an earlier release's notes stand there: say in one line that `/ok` archives them, and go on. The run reads nothing in it.

Name the discovery `YYYY-MM-DD-<slug>`, from `date +%Y-%m-%d` and a slug for what it audits, such as `corpus`. Every file the run writes sits under `.ok-planner/discoveries/` and starts with that name. Record the commit the audit reads: `git rev-parse HEAD > .ok-planner/discoveries/<name>-base.txt`. Where `git status --porcelain` lists a path outside `.ok-planner/`, name the count in one line; the audit reads the tree as it stands.

## 2. Open the run

`tasks init <name> --file .ok-planner/discoveries/<name>-run.jsonl`, and `tasks agent register ok-opus`. For each of `{{DISCOVER-SURVEY-PROMPT}}` as `survey`, `{{DISCOVER-CHECK-PROMPT}}` as `check`, `{{DISCOVER-SORT-PROMPT}}` as `sort`, `{{DISCOVER-MERGE-PROMPT}}` as `merge`, and `{{DISCOVER-REVIEW-PROMPT}}` as `review`, in `core.md`, write the block, its transclusions resolved, `[DISCOVERY PATH]` filled with `.ok-planner/discoveries/<name>.md`, `[DELTAS PATH]` with `.ok-planner/discoveries/<name>-deltas`, and `[RUN PATH]` with `.ok-planner/discoveries/<name>-run.jsonl`, to `.ok-planner/discoveries/<name>-<role>.md`, and register it: `tasks prompt register <role> <that path>`. Declare the pools:

```
tasks config set item_states '{"nouns": ["open", "drafted", "matched", "dropped"], "outcomes": ["open", "drafted", "matched", "dropped"], "choices": ["open", "drafted", "matched", "dropped"], "findings": ["open", "drafted", "matched", "dropped"], "artifacts": ["open", "batched"], "checked": ["open"], "groups": ["open", "batched"], "deltas": ["open", "withdrawn"], "questions": ["open", "withdrawn"], "review": ["open", "resolved"], "calls": ["open"]}'
```

Say the run's shape in one line once step 3 has cut the areas: the counts of areas by shape, and of artifacts by kind.

Each stage below drains with the drain loop at `.claude/skills/_tasks/drain.md`, and settles every task before the next stage starts:

- A task left `running` whose agent has returned is released with `tasks retry <task>`, and the drain issues it again.
- A task that closes `partial` is refiled once, whole, with `tasks refile <task>`.
- A task that closes `blocked` or `disputed` is refiled once with the reason its result gives added to its brief, `tasks refile <task> --brief "<its brief, whole>; it closed <outcome>: <its result>"`, where the reason names something the brief can settle, such as a file to read or a field to fill.
- A task that closes other than `done` a second time stays as it closed. Stop the run there, and report the task, its result, and the step the run stopped at: the owner settles it, and the next `/discover-design` resumes the run.

## 3. Survey

Cut the areas: `.ok-planner/bin/discover areas --out .ok-planner/discoveries/<name>-areas.json`. It groups every file the project owns that the review loop would read, by folder, into file areas of code and prose areas of prose, and cuts one flow area per file the surface intent names as declaring a class of entry point. It leaves out tests, the corpus, the records, and every suite-owned file.

File one survey task per area, in the file's order: `.ok-planner/bin/discover surveys --areas .ok-planner/discoveries/<name>-areas.json --run .ok-planner/discoveries/<name>-run.jsonl`. Each task's brief names its area and the area's files. Drain.

## 4. Check

List the artifacts: `.ok-planner/bin/discover artifacts --json`. It lists every concept, story, and decision with scope `full`, and every subject, practice, docspec, and the surface intent with scope `rules`. Where it lists none, the corpus is empty: skip to step 5.

File one item per artifact: `tasks item add --pool artifacts --key <kind>:<slug> --field kind=<kind> --field slug=<slug> --field path=<path> --field scope=<scope> --body "<kind>:<slug>"`. Batch them: `tasks batch --pool artifacts --state open --group-by fields.kind --size 6 --prompt check --agent ok-opus --role check --mark batched`. Drain.

## 5. Sort and merge

Take the kinds in order: `concept`, `story`, `decision`, and `standards`, which covers subjects, practices, docspecs, and the surface intent. Take `standards` only where step 4 listed one of those. For each kind, finish both stages below before the next kind starts, since a kind's merges may record candidates a later kind's sort groups:

1. **Sort.** File one sort task: `tasks file --role sort --prompt sort --agent ok-opus --key <kind> --brief "kind <kind>"`. Drain. It groups every candidate and finding of the kind by the artifact it belongs to, folding the candidates several areas recorded under different slugs.
2. **Merge.** Batch the kind's groups, a few per merge task: `tasks batch --pool groups --state open --where fields.merge=<kind> --size 8 --prompt merge --agent ok-opus --role merge --mark batched`. Drain. The merges of one kind run together: each drafts only its own groups.

Before a stage's next step, settle each task of the stage that closed `partial`, as step 2 says, and drain again.

## 6. Check the drafts

Run `.ok-planner/bin/discover assemble --discovery .ok-planner/discoveries/<name>.md --from-run .ok-planner/discoveries/<name>-run.jsonl --title "<a title>" --check`. It checks every delta's key, operation, mark, and body against the live corpus, every question for both answers and for an artifact that is live or that its answers create, with a body under each answer where the audit proposes the artifact, every candidate and finding for the merge that settled it, every artifact for its check, and every body for the delta or question that names it. Where it refuses, it names each failure with the task that recorded it: refile that task with the failures added to its brief, `tasks refile <task> --brief "<its brief, whole>; the assembly refused: <the failures>"`, drain, and check again. A merge's brief lists its groups, so keep it whole. Where a failure names a candidate with no group, file a sort task for its kind again, which groups only the items with none; drain; batch the groups it adds, as step 5 does; drain; and check again.

## 7. Review

Run up to three review cycles. The first reviews every merge; each later cycle reviews only the merges the cycle before refiled. In each, file one review task per merge task under review, its latest refile: `tasks file --role review --prompt review --agent ok-opus --key review:<cycle>:<merge task> --brief "review cycle <cycle> of 3; merge task <merge task>; its groups: <the group keys its brief lists>"`, and drain. Where the cycle records no finding, stop. Otherwise group the open findings by their `merge` field, and refile each merge task named, the third cycle's included, with its findings and this instruction added to its whole brief: `tasks refile <merge task> --brief "<its brief, whole>; the review found: <its findings, each with its site, decided, and fix>; fix in the draft each finding whose decided is yes, as its fix says; ask each finding whose decided is no as a question with both answers, as the merge prompt's step 6 says (one question per artifact)"`. Drain, mark each finding `resolved` with `tasks item set <finding> --state resolved`, and check the drafts again, as step 6 does. After the third cycle's refiles drain and the drafts hold, no review follows. The assembly refuses a finding that stands open.

## 8. Assemble

Run the assembly of step 6 without `--check`. It writes the discovery to `.ok-planner/discoveries/<name>.md`: the commit its base file names, the counts, the count of review findings among them, each question with both answers and the open issues on its artifact, each promise change and each form-only change with its body's path, and each call an agent made. It prints the counts.

## 9. Report

Give the owner the discovery's path and the counts the assembly printed, in a few lines, and name each task that closed other than `done`. Say that `/plan-sprint`, naming the discovery, takes it up, and that until then the discovery stands and `/discover-design` refuses a second run.

Then stop. The run writes only the files under `.ok-planner/discoveries/` that start with its name, and it commits nothing.

## What this skill does NOT do

- Asks the owner nothing. The owner's one discussion is in `/plan-sprint`.
- Writes no file under `.ok-planner/design/`, `.ok-planner/subjects/`, `.ok-planner/practices/`, `.ok-planner/docspec/`, or `.ok-planner/surface/`, and files, rules, and closes no issue.
- Drafts no new subject, practice, docspec, or surface class, and no change to one but a form-only amendment the rules decide.
- Changes no code. A question's code-is-wrong answer is a work item a sprint builds.
- Adds no code annotation; that convention rolls out during ordinary work, per `.ok-planner/CLAUDE.md`.

<!-- Materialized by ok-planner v29.0.0 — suite-owned; overwritten on true-up; do not hand-edit. -->
