---
name: drive
description: "ONLY activated by explicit /drive slash command. Never auto-triggered by conversation content. Drives every story, or a sprint's new and changed stories, as a user would, and files each defect it finds as a `category: defect` issue, fixing nothing."
---

# Drive (try the stories, fix nothing)

`/drive` tries stories as a user would and reports what it finds. One driver per story tries once to get what the story promises by using the running product. A merge agent sorts every failure, and the owner list files each defect the merge keeps in the intake as a `category: defect` issue, for the next `/converge` to fix. The run fixes nothing: it edits no product file, and it files no fix, verify, restore, or confirm task.

The drive's steps are the shared drive text at `.claude/skills/_converge/drive.md`, which `/converge` in `drive` mode and sprint certification run too. This skill names the story set, opens the ledger the drive writes into, and leaves what the drive found for the owner.

Every mechanical step is a verb of `.ok-planner/bin/review` or an `exec` task. Every agent is a task in the task tracker at `.ok-planner/bin/tasks`, drained by the drain loop at `.claude/skills/_tasks/drain.md` under a vendored profile. The skill dispatches no agent directly. The session reads no file for judgment and edits no file but the run's ledger, save the intake at the close, where it files one issue per call the owner vetoes, through `.ok-planner/bin/issues` alone.

**The invocation** takes one of two forms:

- `/drive`: every story under `.ok-planner/design/stories/`.
- `/drive sprint <path>`: the new and changed stories of the sprint at `<path>` under `.ok-planner/sprints/`. The owner may name an archived sprint's path under `.ok-planner/history/sprints/` instead; the run takes that path only where the owner names it, and reads that sprint only for its new and changed stories, never to learn the project's current state. The sprint only picks the stories: the run files every defect its merge keeps, whatever the sprint's scope.

## Setting up the run

1. **Preconditions.** `.ok-planner/bin/tasks`, the profiles under `.claude/agents/`, and `.ok-planner/review/` with its `config.json`, `project.md`, and `catalog/accept.md` exist; otherwise say which is missing and stop. Run `.ok-planner/bin/issues list`. Where it refuses because the intake holds an earlier layout, say that `/ok` converts it, and stop. It writes a note on stderr for each stray line it skips; say each note in the return, and go on. In the sprint form, run `.ok-planner/bin/review stories --sprint <the sprint's path>`; where it refuses, say its message and stop, with no return block. Say the run's shape in one line before it starts: the form, with the sprint's path in the sprint form, and the count of stories the drive takes.
2. **Open a fresh ledger.** `tasks init drive-<date>T<time> --file .ok-planner/review/runs/drive-<date>T<time>.jsonl`, the timestamp from `date +%Y-%m-%dT%H%M%S`. Never `tasks use` an existing file to open the run. The run's folder is `.ok-planner/review/runs/drive-<date>T<time>/`.
3. **Register the profiles**: `tasks agent register ok-opus`, and `tasks agent register ok-drive`, the profile `review drives` files every driver under.
4. **Assemble and register the prompts** `drive`, `drive-start`, `merge`, and `owner-list`, each written into the run's folder by `review prompt --name <name> --out <folder>/<name>.md` and registered with `tasks prompt register <name> <path>`. No call adds `--sprint`, in either form: the run certifies no sprint, and no sprint's rulings bind it.
5. **Declare the vocabulary**: `tasks config set item_states '{"defects": ["open", "fixing", "fixed", "declined", "duplicate", "verified", "stuck", "promise", "promised", "at-fault", "rewrite"], "failures": ["open", "defect", "not-owed", "environment", "redrive", "backlog", "judgment", "upstream", "rejected"], "merges": ["done"], "calls": ["open", "promoted"]}'`, and `tasks config set calls '[{"pool":"failures","states":["not-owed","rejected"]}]'`, so `tasks calls` prints one row per failure the merge sorted `not-owed` or rejected. Every task the session or a `review` verb files carries key `gate`.

## The drive

Run the shared drive text at `.claude/skills/_converge/drive.md`, steps 1 to 6, over the story set the invocation names: `review stories` and `review drives` for `/drive`, and `review stories --sprint <the sprint's path>` and `review drives --sprint <the sprint's path>` for `/drive sprint <path>`.

The session records its own observations as items the moment it has them, never at the end from memory: `tasks item add --pool calls --key gate --field kind=session-note --field topic=<accept-..., prompt-..., tool-..., product-...> --body "<the observation, with the task ids and sites it rests on>"`.

## What the run leaves for the owner

File one last task: `tasks file --role report --prompt owner-list --agent ok-opus --key gate --files .ok-planner/issues.jsonl .ok-planner/closed-issues.jsonl --brief "run <the run's name>; drive only"`, and drain it. The owner list writes the intake through `.ok-planner/bin/issues` alone and names each issue by its id. It files each defect the merge kept as a `category: defect` issue, unless an open defect issue already names its site. It files every harm whose fix lies in a part the project does not own as a `category: upstream` issue, and every other failure that needs the owner's judgment as an issue in any other category but `defect`.

Where the owner list wrote or turned any issue, run `/triage-issues` next, before the return. `/triage-issues` opens a ledger of its own, which moves the tracker's pointer off this run's ledger. Once it returns, select this run's ledger again with `tasks use .ok-planner/review/runs/drive-<date>T<time>.jsonl`, so every `tasks` and `review` call after it reads this run: the session notes, and the return's `tasks calls`, `tasks status`, and `tasks report`.

## The return

The run ends by presenting one block.

- `form`: `/drive`, or `/drive sprint` with the sprint's path.
- `stories`: where step 1 of the drive printed no slug, that the project has no story, or that the sprint names no new or changed story. Otherwise each story tried and its outcome (`achieved`, `failed`, `stuck`, `blocked`) per surface and variant; each story driven again one driver at a time after the shared stack broke, with its outcome, and each story the fallback did not drive again; and, where the drive ended without driving, the cause and every story it did not drive.
- `failures`: the failures as the merge sorted them, `defect`, `not-owed`, `environment`, `redrive`, `judgment`, `upstream`, and `rejected`, and each merge that closed unfinished twice, with the failures it left `open`.
- `stack`: each start that failed, with the first word and the cause of its `drive-start` result, and each `stack-stop`, `instance-destroy`, or `resource-stop` task that failed, with its output tail.
- `calls`: what `tasks calls` prints, one row per `not-owed` or rejected failure, with its site and choice.
- `ledger`: the ledger's path; the run's folder stands beside it.
- `intake`: every issue the owner list filed, turned, or found already open, by id, with its category; every `environment` failure; and, where any issue was written, the `/triage-issues` report: the issues it closed or retired, and each route and ruling it wrote.
- `cost`: the usage `tasks status` totals and the task count from `tasks report`.

The block is the whole report. Present the `calls` rows to the owner and, beside the offer below, ask which rows, if any, the owner vetoes. Where `tasks calls` printed `None.`, ask nothing beyond the offer. For each vetoed row, file one issue with `.ok-planner/bin/issues file --from -`, in the format of the `{{ISSUE-FILE-FORMAT}}` block of `.claude/skills/_shared/artifact-definitions.md`: kind `human`, category `product-intent`, its problem the row. Then record the owner's words as that issue's ruling with `.ok-planner/bin/issues rule <id> --text -`, the words on stdin, so the next `/plan-sprint` pulls the veto in as the owner's decision. `issues rule` signs the ruling with the name of the person running the session; where it refuses for want of a name, relay the refusal's setting text to the owner and record the ruling once a name resolves. End the report with one offer, to commit the run: the ledger, the run's folder, and the intake's two files, `.ok-planner/issues.jsonl` and `.ok-planner/closed-issues.jsonl`, where the owner list or a veto changed either, staged by name. Commit only on the owner's word. Do not push.

## What stays outside this skill

- No agent edits a product file. The run files no fix, verify, restore, or confirm task: `/converge` fixes what the drive finds.
- The owner-list agent writes the intake, and the session writes it once more at the close, filing one issue per call the owner vetoes.
