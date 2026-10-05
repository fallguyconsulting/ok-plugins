## Merge hunts into the defect list

You are a **leaf agent**: never spawn subagents. Do all reading, searching, and verifying yourself with Read/Grep. Your context is 1M tokens; a large reading set is never a reason to delegate. Read shared context (the design catalogs, the rule files) once, up front, and reuse it across every item.

This rule binds the dispatched job it is embedded in and nobody else. It never licenses skipping work. If an instruction you are bound to follow requires dispatching subagents, report the conflict to your dispatcher; never drop the step.

Hunters report defects independently, so the same defect arrives several times in different words, some reports are wrong, and some name a harm the accept list does not cover. You turn reports into the run's defect list: each real defect appears once in each area, and each carries the hunts that saw it. The count of defects each hunt added that no earlier hunt of its area found decides whether the area is hunted again, so count exactly. You fix nothing and edit no code.

Your brief names `drive`, `sprint`, `backlog`, or one or more areas, each with the hunt numbers you merge and the ids of their reports. Areas share a brief because their reports touch the same files, so the same flaw may arrive in several of them.

### Read

Every report your brief names: `tasks item list --pool reports --key gate --state open --json`, the items with those ids; for the drive, `tasks item list --pool failures --key gate --state open --json`. Every defect already on the list for your areas, in every state: `tasks item list --pool defects --key gate --json`, the items whose `area` field names one of them. The code at every site a report names.

### Judge each report

1. **Is it real?** Read the code at the site. A report whose code does not do what the report says is rejected.
2. **Does the accept list cover it?** Apply the list, pasted below, to the harm the code actually causes. A report whose harm no entry covers is rejected, with the list's reason.
3. **Is it already on the list?** Work through each area's hunts in ascending order, so a defect's first hunt is the one that found it first. A report is the same defect as one on the area's list when fixing one would fix the other: the same flaw at the same site, or one root cause behind both, whatever the line numbers or the wording. Where it is, add the report's hunt number to that defect's `seen`: `tasks item set <defect id> --field 'seen=[<the old numbers and the new one>]'`. Where it is not, it is new to the area. Where the same flaw is already a defect of another area, the report still becomes a defect of its own area, with `--field same_as=<the other defect's id>`: each area keeps its own count, and the fixer fixes the flaw once.
4. **Is it one defect?** Split a report that names two flaws into two defects. Join reports of this hunt that name one flaw into one defect.

For a new defect: `tasks item add --pool defects --key gate --fingerprint "<area>:<a short slug for the flaw>" --field area=<area> --field entry=<A1..A9> --field source=<file|flow|drive> --field 'files=["<every file the fix would touch>"]' --field 'seen=[<the report's hunt number>]' --field kickbacks=0 --body "<the site as path:function; what the code does; the trigger; the harm, in the entry's terms; the evidence, path:line quoted; the reports it came from, by id>" --task <task>`. For the drive, add `--field story=<the story slug> --field surface=<the failure's surface>` and use the area `drive` and hunt `1`.

Then settle every report: `tasks item set <report id> --state merged --note "<defect id>"` or `--state rejected --note "<why: not real, or which part of the accept list leaves it standing>"`.

### The drive's failures

Each failure is one story a driver could not get the benefit of: `failed`, `stuck`, or `blocked`. A merge that turns a correct product into a defect does harm, so sort each failure before you merge it:

- **defect**: the story, or a decision it cites under `.ok-planner/design/`, says the product owes what the driver tried to get, and the product does not deliver it, or gives a user no way to find how. For a `failed` story, read the path the driver's actions took, from the frame that receives the user's action to the result the user saw, and name the function where it goes wrong. For a `stuck` story, it is a defect only where a message or a help text the user met failed to say what went wrong or what to do next: name that place and what it says. A stuck story with no such message (the user needed a page, a verb, or a flow the product does not offer) is not a defect for this run: sort it `not-owed` and record a question naming what the user was missing. Merge it as a defect (entry A3 unless another entry fits better), with `--field story=<slug> --field surface=<the failure's surface>`, then `tasks item set <failure id> --state defect --note "<defect id>"`. Two failures with one cause are one defect naming both stories.
- **not-owed**: the driver tried to get something the story and its decisions do not promise. `tasks item set <failure id> --state not-owed --note "<what the driver expected, and what the corpus says>"`.
- **environment**: the story was `blocked` by the stack, the machine, a local tool, or a need a local stack cannot meet. `tasks item set <failure id> --state environment --note "<the cause, and what the owner would do about it>"`.

Where .ok-planner/sprints/2026-10-04-consolidate-into-ok-planner.md names a sprint, this run certifies it from the base commit 9c7aff70721a58714b12cebaab507d6cf907c230, and the drive stays inside its scope. Before you merge a defect from a failure, apply step 3a of a sprint's reports, below, to the file its fix lies in: where no sprint agent may edit that file, `tasks item set <failure id> --state judgment --note "<the file; the defect; why no sprint agent may edit it>"`, and merge nothing. Otherwise apply the sprint catalog's scope test to the function you named, reading it at the base. Where the code stood the same at the base and the sprint's change does not reach it, the defect is real but outside the sprint: `tasks item set <failure id> --state backlog --note "<the site as path:function; the entry; the evidence; why it is outside the sprint>"`, and merge nothing. The owner list files it in the intake for the next run.

Where the corpus does not decide whether the product owes what the driver tried to get, sort it `not-owed`, say so in the note, and record a question: `tasks item add --pool calls --key gate --field kind=question --field file=.ok-planner/design/stories/<slug>.md --body "<what the product does>; <what a user would expect, and the story, decision, or message each reading rests on>" --task <task>`.

### A sprint's reports

Where your brief starts `sprint`, this run certifies the sprint at .ok-planner/sprints/2026-10-04-consolidate-into-ok-planner.md, from the base commit 9c7aff70721a58714b12cebaab507d6cf907c230. The reports come from the sprint's review passes and from defects the sprint's builders noticed outside their files. Judge each by the sprint catalog below as well as the accept list:

1. **Is it real?** As above.
2. **Is it covered?** By an accept-list entry, or by a sprint class: C1, C3, C4, R1 to R5, or M1. A report neither covers is rejected.

3a. **May a sprint agent edit the file its fix lies in?** Name the file the fix lies in. No agent of this run edits a skill or tooling file, under `.claude/`, `.ok-planner/review/`, `.ok-planner/bin/`, `.ok-plumbline/`, or `.ok-workspaces/`, or a design-corpus artifact under `.ok-planner/design/`, even where the sprint's change edited the file or a delta heading names the artifact. For such a report, `tasks item set <report id> --state judgment --note "<the file; the defect; why no sprint agent may edit it>"`, and merge nothing. The owner list files it in the intake as a judgment issue, `category: design` for a corpus artifact, for the next `/plan-sprint`, and the run spends no fix, verify, or backout task on it. Otherwise go on to step 3.

3. **Is it in the sprint's scope?** Apply the catalog's scope test, reading the site at the base. In scope: merge it as a defect under its area, with `--field entry=<the class code or A1 to A9> --field source=sprint`. A defect the accept list covers whose code stood the same at the base, and which the change does not reach, is real but outside the sprint: `tasks item set <report id> --state backlog --note "<the site; the entry; the evidence; why it is outside the sprint>"`. The owner list files it in the intake for the next run.
4. **Is it already on the list, and is it one defect?** As above.

A report of an outcome not reached (C1) or a commitment contradicted (C4) that forks on what the owner wants, where the sprint and corpus do not decide it, is rejected with a question recorded, as for the drive below.

### The backlog's reports

Where your brief starts `backlog`, the reports come from `category: defect` issues in the intake, each with its issue file in the `issue` field. Judge each like a hunter's report. A defect the code no longer shows is rejected with the note `gone`, and the owner list closes its issue. Merge each real one with `--field issue=<the issue file>` and its source `backlog`.

### Count

Record each area's hunts, one item per area and hunt number in your brief, exactly once: `tasks item add --pool merges --key gate --state done --field area=<area> --field hunt=<hunt number> --field new=<defects of the area whose first hunt is this one> --field matched=<reports of this hunt folded onto a defect the area already had> --field rejected=<reports of this hunt rejected> --field judgment=<reports and failures of this hunt set to judgment> --body "<one line>" --task <task>`. `new` counts defects, not reports: three reports of one new flaw add one. For the drive, record one item with area `drive` and hunt `1`.

### Rules

Edit no code, no prose file, and no estate. Stage nothing. Commit nothing.

### Close

`tasks close <task> --outcome done --result "merge: <per area and hunt: new, matched, rejected, judgment>"`; for the drive, add the counts of failures sorted `defect`, `not-owed`, and `environment`, and, where .ok-planner/sprints/2026-10-04-consolidate-into-ok-planner.md names a sprint, `backlog` and `judgment`.

### The sprint catalog

#### The defect standard

The accept list at `.ok-planner/review/catalog/accept.md` names the harms that
count as defects, and what it leaves standing. A sprint adds its own
promises: its work items, its taken improvements, its deltas, and its
implementation notes' rulings. The classes below cover both.

#### The scope test

A defect is in the sprint's scope when the change caused it, or when
the change makes a promised outcome fail through it, or newly exposes
an existing user to it. Read the site at the sprint's base commit
(`git show <base>:./<path>`, from the project root) to tell. A defect the accept list covers whose code
stood the same at the base, and which the change does not reach, is
real but outside the sprint: it goes to the intake as a
`category: defect` issue, and the next `/converge` fixes it.

Code structure is out of scope unless the sprint's notes have taken an
improvement for it: planning decides structure, and the loop this
replaced ran to its round cap filing structure findings on its own
fixes.

A user's goal is what it needs from a behavior, read from a named
source: a design corpus artifact it cites, a sprint work item, or
what its own code does with the value. A user across a boundary has
no code in this tree to read, so its goal is the behavior as it stood
at the base; a ruling other than `preserve` is how the owner allows a
difference there.

#### The classes

| code | class | the check | the evidence |
|---|---|---|---|
| C1 | Outcome not reached | A work item's outcome, or an improvement the notes list (I-id), that no entry point reaches, or reaches only in part: the entry never calls the code that produces it, a value is computed and not used, a configuration is read and not honored, or a stub, `TODO`, or ignored flag stands in for it. | the entry point; where the path ends; the outcome and its work item or I-id |
| C2 | Accept-list harm on the change | A harm an accept-list entry names, reached through a path the change added or altered, that the list does not leave standing. Report it under the entry's own code, A1 to A8. | the entry; the trigger; the path as path:function steps; the harm; path:line quoted |
| C3 | Delta not landed | A corpus delta whose artifact (under `.ok-planner/design/`, or under `.ok-plumbline/subjects/` or `.ok-plumbline/practices/` for a subject or practice) does not match the delta's final-form body byte for byte, or is not deleted for a retirement. | the delta; the artifact; the first differing line |
| C4 | Commitment contradicted | Code in the change contradicts a commitment a corpus artifact states that the sprint's deltas or work items name. | the artifact and its sentence; the code site; what the code does instead |
| R1 | Preserved behavior changed | A `preserve` behavior change whose users across the boundary now observe a difference. | the B-id; before and after, from the code at the base and now |
| R2 | Migration not as ruled | A `migrate` behavior change whose old users neither keep working nor get the refusal its ruling states. | the B-id; the ruling; what an old user gets now |
| R3 | Rewrite left a user behind | A `rewrite` behavior change with a user in the release the change did not update, whose goal now fails. | the B-id; the user; its goal and source; what it gets now |
| R4 | Unlisted change breaks a user | A behavior change the notes do not list, with a user in the release whose goal now fails on some path. | the changed site; the user; its goal and source; the trigger, old outcome, new outcome |
| R5 | Boundary user not ruled | A behavior change with a user across a boundary that no ruling covers: the notes do not list the change, or list it without naming that user. | the changed site or B-id; the boundary and its user; before and after |
| M1 | Check fails | A check `.ok-planner/review/config.json` names fails on a file the change touched. Filed by the session. | the check; the file; the output |

An unlisted behavior change that meets every user's goal is not a
defect; it is recorded for the owner as a `kind=unlisted` call. A
change a work item or delta asks for is not a regression; the
completion classes cover it. A story the sprint adds or amends is
checked by the drive, and the merge agent sorts its failures.

#### How to state a report

State the failure, not the edit: the fixer chooses the fix, and a
report that names an edit narrows the fix to that edit. One report per
failure; two paths that fail through one site the same way are one
report.

### The accept list

#### .ok-planner/review/catalog/accept.md

# The accept list

The bug families fix a site only when an entry below covers it. Every row of the `failure-paths` and `input-state` catalogs, and every unit a bug-family agent records, is read through this list. A site the list does not cover is not a defect for this run, whatever a row's plain reading says: list it `=standing` in your close and record nothing for it.

Each entry names a harm and the sites that can cause it. Judge the harm, never the shape: a site that has a row's shape and cannot cause an entry's harm stands.

| # | Accept when | The sites that can cause it |
|---|---|---|
| A1 | **Stored state can end half-changed.** A crash, an error, or a second writer acting between two steps of one change leaves stored state that no complete run would produce. | Every operation that changes stored state (database rows, files, queue positions, remote resources) in more than one step. Every check-then-write. |
| A2 | **A write lands on the wrong target.** A delete, an overwrite, or a write reaches something it should not, because of input (hostile or not), because a read could not tell "missing" from "unreadable", or because cleanup reaches something it did not create. A value that only builds a link, a read, or a message is not this entry's. | Every delete, overwrite, and write, and each value that picks its target. |
| A3 | **An end user can break the product.** On a system deployed and configured correctly, an action a user can take through the public surface (a page, a form, a CLI verb, an API route), or a developer or operator can take through a script the project ships for its developers or operators, as `.ok-planner/review/project.md` lists them, gives a wrong result, a stall, a crash, or an error that does not tell the user what they did wrong, or leaves the product in a state where later use fails. A user's mistakes count: a wrong value, a missing field, a repeated click, steps out of order, two sessions at once. A dependency down for a moment (a network blip, a 503 reply, a broker restart) is part of a system running correctly; the disk, a permission, or the operating system failing underneath is not, and a failure that needs one of those first is not this entry's unless another entry also holds. | Every element of the public surface and every input it takes, as the project's surface record lists them; every script the project ships for its developers or operators, as `.ok-planner/review/project.md` lists them, and every input it takes; and every failure the drive records. |
| A4 | **A unit of work can end with no record.** A request, a command, a job, a message handler, or a process can end without recording how it ended and why. | Every entry point that starts a unit of work. |
| A5 | **Ongoing work stops or wears down while the system still looks healthy.** Work the system relies on happening again and again (a background loop, a scheduled job, a queue consumer, a watcher) stops for good, stops making progress, or stops recording its state: one error ends the loop, one bad item blocks the queue forever, a wait never returns. A long-running process that holds a file, a connection, or a thread on a routine path and never releases it is the same harm. | Every piece of work that repeats or runs without end, and every acquire on a routine path of a long-running process. |
| A6 | **Access is wrong.** A check that decides who a caller is, or what the caller may do, admits a caller it should refuse; or a removal of access fails to take effect. A certificate or token check that accepts a foreign one, a permission check skipped on one path, and a revocation that never runs are this entry's. | Every authentication, authorization, certificate, and token check, and every place that grants or revokes access. |
| A7 | **Accepted data is lost, skipped, or doubled.** Data the system has accepted from a sender never reaches its place of rest, or reaches it twice, however rare the trigger. A temporary failure treated as permanent that drops the item, and a failed commit or rewind read as a success that skips items, are this entry's. | Every step between accepting data and storing it: acknowledgments, retry decisions, position commits and rewinds, and duplicate checks. |
| A8 | **The code breaks a rule the project states, and the rule decides the fix.** A rule from one of three sources leaves one compliant form for the site, and the code has another: a rule in `.claude/rules/plumbline-coding.md`, where the project carries it; a rule in a code-rule file that `.ok-planner/review/project.md` lists under `## Code rules`; or a commitment of a live artifact under `.ok-planner/design/`. A site where two compliant forms remain is a question, not this entry's. | Every site a rule in `plumbline-coding.md`, a rule in a listed code-rule file, or a design commitment governs. |
| A9 | **The system reports something false that someone acts on.** A status, a result, a count, a health or readiness check, an exit code, or a message tells an operator, a user, or a calling program something that is not so: success over a failure, failure over a success, healthy over broken, done over not started, a number that does not match what happened. A unit of work that ends with no report is A4's; this entry is a report that says the wrong thing. | Every exit code, reply status, printed result, count, health or readiness check, and status field that a person or program reads to decide what to do next. |

## What the list leaves standing

These stand even where a row's shape fits, unless an entry above also holds:

- A library's error that reaches the owner frame, however it is named. The owner frame records it with its stack trace.
- A malformed value from inside the system (a reply from the project's own service, the operator's configuration, a file the program itself wrote) that ends in a raise the owner frame records. A malformed value from an end user never stands on this ground: under A3 it is refused with a message the user can act on.
- A value from the operator's own configuration that is grossly wrong, where the program stops with an error.
- The machine failing underneath the program: a file it may not read, a close or a removal that fails, a spawn that fails.
- Cleanup skipped on the error exit of a process that is ending anyway.
- A wait on foreign code in an interactive command the user can interrupt.
- A change that alters no behavior, and an event added where nothing else changes.

## Where a site is unclear

Where you cannot tell whether an entry covers a site, it stands. Before recording a proposal, test the site against A8: where a rule from one of A8's three sources decides the fix, it is a defect under A8, not a proposal. Where you see a harm of the same weight as the entries (wrong or lost data, a destroyed resource, access gained or kept that should not be, a stuck service) that no entry names, leave the code and record a proposal: `tasks item add --pool calls --key gate --field kind=proposal --body "<the site; the harm; the entry wording that would cover it>" --task <task>`.

### This project

#### .ok-planner/review/project.md

# This project, for the review loop

The owner writes this file. The review loop pastes it into every prompt that reads or runs the tree. It holds the facts a general loop cannot know. Replace each instruction line below with this project's facts, and leave a section empty where the project has nothing to say.

## The root and what is out of scope

The project root is the ok-plugins monorepo root, the folder that holds `.claude-plugin/marketplace.json`. The shipped product is `plugins/` (`plugins/ok`, `plugins/ok-conduct`, `plugins/ok-web`) and the ok-planner family the front door carries at `plugins/ok/families/ok-planner/`. No agent edits the vendored suite layer this repo dogfoods: `.claude/skills/`, `.claude/agents/`, `.claude/hooks/`, `.claude/rules/`, and the materialized files under `.ok-planner/`; only `/ok` rewrites them. No agent reads `.ok-planner/sprints/`, `.ok-planner/sketches/`, `.ok-planner/documentation/`, or `.ok-planner/history/` unless a skill directs it. A sprint lists no folders outside the root.

## What no agent of this loop ever runs

- `/release` (`.claude/skills/release/`): it commits, tags, and pushes to `origin`.
- `git push`, and any `git tag` pushed to `origin`.
- `claude plugin update`, `claude plugin install`, and `claude plugin marketplace update`: they change the operator's own installed plugins.
- `/ok`: it rewrites the vendored suite layer and `.claude/settings.json`, and stays an owner act.

## The helpers the catalogs name

The tree has no event emitter, no atomic-replace helper, and no practice that governs owner frames.

## Code rules

- `.claude/rules/plumbline-cheatsheet.md`
- `.claude/rules/plumbline-coding.md`

## Scripts for developers and operators

- `checks/run`: takes no inputs; runs every check under `checks/` with `python3` and exits non-zero when one fails.
- `checks/token-resolution`, `checks/ceremony-surfaces`, `checks/materialized-standalone`, `checks/vendored-layer`, `checks/owned-paths`, `checks/oscillation`: each takes no inputs and is run by `checks/run`.
- `plugins/ok/families/ok-planner/admin/converge`: takes a mode (`diagnose`, none for converge, `resolve <id> [choice] [--from <draft>]`, `wire-hooks <group>` with the group `session-start`, `subagents`, or `lint`, and `wire-env`).
- `plugins/ok/families/ok-planner/scripts/tasks` and `plugins/ok/families/ok-planner/scripts/review`: the task tracker and the review tool, each taking a subcommand.
- `plugins/ok/families/ok-planner/scripts/plumbline`: takes a path to lint, or a subcommand (`patterns`, `config-check`, `version`).
- `plugins/ok/families/ok-planner/scripts/catalog-toc`, `plugins/ok/families/ok-planner/scripts/run-tag`, and `plugins/ok/families/ok-planner/scripts/port-block`: the catalog TOC generator (a project root, or `--check`), the run tag minter (no inputs), and the port readback (a run tag).

## Drive commands

## Running the product, for the drive

The product has no stack to start or stop. It runs inside a Claude Code session: the primary user surface is the slash commands the plugins and the vendored skills offer (`/ok`, `/plan-sprint`, `/converge`, `/audit`, and the rest). The other surfaces are the converge core's command line, the materialized scripts (`.ok-planner/bin/tasks`, `.ok-planner/bin/plumbline`, `.ok-planner/bin/run-tag`, `.ok-planner/bin/port-block`), and the hooks the plugins and the vendored layer wire. No surface signs a user in.

## Resources a driver starts

A driver that needs a consumer project makes a scratch folder with `mktemp -d`, runs `git init` in it, drives the converge core at `plugins/ok/families/ok-planner/admin/converge` against it, and deletes the folder when done.

## Stories that drive alone

## Stories that drive on an instance of their own

