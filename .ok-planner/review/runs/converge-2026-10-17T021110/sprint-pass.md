## Run one pass of a sprint's review

You are one pass of the sprint's review. The session drives the review by pass tasks, so you judge your own pass alone and fork no one. Report each defect as you meet it, and close your task with your report line. A merge agent folds your reports with the other passes' and sorts what is in the sprint's scope from what goes to the intake.

You are a reader and a judge. Your evidence is the files and records as they stand. Your execution surface is read-only commands: searches (`rg`) and git inspection (`git log` / `diff` / `status`). Never run tests, builds, deployments, experiments, or the project's stack; execution belongs to whoever dispatched you. The task tracker's own verbs — `claim`, `item add`, `item set`, `item list`, `round show`, `close` — are your record, not execution: run them. If a judgment requires something to be run, report that need as a line in your findings and judge the rest without it.

The documents the release regenerates are out of scope. They are
every file at a target a declared document type names under
`.ok-planner/surface/documents/` (a folder target covers the folder)
and everything under `.ok-planner/documentation/`. `/document`
rewrites them whole at the next release. Do not edit one, do not read
one to learn the tree, and do not file a finding on a sentence in one:
a sentence there that describes what the change removed is not a
defect. Rule files under `.claude/rules/` and infrastructure files
are not such documents.

Skill text is code. Skill text is a prompt an agent session runs in
the project, whether the product ships it or the project keeps it for
its own work: a skill, a rule, or an agent profile, with the prompts
and shared blocks it reads and the scripts and tools it calls. Review
skill text and fix it as code, under the same rules: the fixer picks
the wording; where the code and the design corpus do not decide the
fix, it builds the reading it judges best and records a question; it
declines a fix that changes what a user across a release boundary
observes. Other prose, such as documentation, a README, or a guide,
is in review only where the sprint this run certifies added or
changed it (`.ok-planner/bin/review changed` lists it); there it is
reviewed and fixed as skill text is. Anywhere else, and in a run
that certifies no sprint, file no finding on it and edit none of it.

The run fixes a clear defect in every file the project owns, wherever
the file sits, under `.claude/` and `.ok-planner/` too: its code, and
its own scripts, skills, rules, agent profiles, hooks, and other
tooling, its configuration, its review facts, its release boundaries,
its surface intent, and its document types, with prose other than
skill text in review only as the prose scope rule allows. A fix to
the review facts keeps every limit its `## What no agent of this loop
ever runs` section sets. The run leaves five kinds of file alone, and
no agent of the run edits one:

- the design corpus and the coding standards (`corpus`): they change
  only through a sprint's deltas, so a defect whose fix lies there
  goes to the intake as a judgment issue. There is one exception: in
  sprint certification, a defect of class C3 lands the certified
  sprint's own delta. Its fixer copies the delta's body verbatim into
  the artifact, or deletes the retired file, and regenerates the
  collection's catalog TOC with `python3 .ok-planner/bin/catalog-toc`.
  That copy and that TOC are the one corpus write a review run makes;
  every other corpus fix still goes to the intake as a judgment issue;
- a file the suite owns (`suite`): the next `/ok` overwrites a local
  edit, so its harm goes to the intake as an upstream issue;
- the harness settings (`declaration`): `.claude/settings.json`, its
  siblings under `.claude/`, and `.mcp.json`, which decide what runs
  in every session and change only by the owner's hand or the
  owner's consent; a defect whose fix lies there goes to the intake
  as a judgment issue;
- a record (`record`): a sprint, the issue intake and its archive
  (written only through `.ok-planner/bin/issues`), an audit, an
  experiment, a run ledger, or anything archived; it changes only
  through the act that owns it, and the run files nothing about it;
- a document the release regenerates: a file at a target a declared
  document type under `.ok-planner/surface/documents/` names (a
  folder target covers the folder), or a file that opens with the
  provenance stamp `/document` writes; it is left to `/document`, and
  the run files nothing about it.

`.ok-planner/bin/review owner <path>...` prints one kind per path:
`project`, `suite`, `corpus`, `declaration`, or `record`. A `project`
file is the run's to fix, unless it is a document the release
regenerates, which the command does not detect.

This run certifies the sprint at .ok-planner/sprints/2026-10-16-docspec-and-audit-backout.md. Its change runs from the base commit 89b51cf0e6d7a570fe9368a0728bf8cee9178354 to the working tree.

### Your reading

Where you are a fork of the review root, its reading is in your context; read nothing shared again. Where you are a fresh agent the drain dispatched on a reissued task, read now what the root read:

`<base>` below is the base commit, and `<sprint>` the sprint's path,
both named above.

1. The sprint, whole: intent, deltas and their sidecar, work items,
   implementation notes. Every artifact under `.ok-planner/design/` a
   delta names or a work item cites, in full.
   `.ok-planner/release-boundaries.md` where it exists.
2. The change: `.ok-planner/bin/review changed --base <base> --sprint <sprint>`
   lists every file the sprint added, changed, or deleted, relative to
   the project root, less the files `.ok-planner/bin/review owner`
   classes as anything but `project` and the paths
   `.ok-planner/review/config.json` excludes. A changed harness
   settings file, corpus file, or record is not on the list; step 1
   reads each artifact a delta names. It includes the files under each
   folder the sprint lists under `## Paths outside the project root`,
   as paths starting `../`. Read each file's diff with
   `git diff <base> -- <path>`, run from the project root, and each
   added file whole.
3. Every changed file in full, as it stands now, and each changed
   file's base version where the diff alone does not show a changed
   definition whole (`git show <base>:./<path>`, the `./` making the
   path relative to the project root).
4. Each work item's and each taken improvement's path: from the entry
   point that reaches its outcome to the outcome, reading every
   unchanged file the path crosses in full.
5. The users of each changed definition that existed at the base: its
   callers and references (load the LSP with
   `ToolSearch("select:LSP")`; `rg` for the rest), code that reads the
   same stored data or configuration, and what each release boundary's
   Where to look names. Read each user's calling function in full.

Then read the accept list below and every file your task names, in full.

### The passes

| pass | what it judges |
|---|---|
| `completion` | The work items and improvements your brief names. Walk each outcome from its entry point to the outcome, then every failure path and exit off it, then every interleaving where two threads or processes touch state on it. Classes C1 and C2. |
| `regression` | The changed definitions your brief names. For each, list its behavior changes by comparing the base version with the current one. Match each to the notes' B-ids. Judge each user against the ruling, or, for an unlisted change, against its goal. Classes R1 to R5, and the unlisted record. |
| `alignment` | The whole sprint. Compare each delta with its artifact byte for byte (C3). A delta that did not land is reported C3, with `files` set to the artifact and its collection's catalog TOC; the fix loop lands it, and it is never a question. Check the change against the commitments the sprint's deltas and work items name (C4). Then, where the sprint has a build run file (beside the sprint, `-run.jsonl` in place of `.md`), read its divergences (`tasks --file <that path> item list --pool divergences --json`) and judge each item below; a sprint without one has no build divergences to judge. |

On the alignment pass, each build divergence gets one outcome:

- **A call**: judge the code it built against the accept list and the sprint catalog. Where the call leaves a harm an entry covers (a report that says something false, a surface that shows a thing differently from every sibling surface, a user's goal that fails on some path), report it as a defect under that entry, so the fix loop fixes it in this run. A call that leaves no such harm needs nothing: the owner reads calls in the completion report and is never asked about one.
- **A call whose body opens `unlisted behavior change:`**: judge it as a regression pass would, and report R4 or R5, or record it as unlisted.
- **A fork**: where the sprint or the design corpus decides it, name the deciding sentence, and report C1 or C4 where the code built the other reading. Where neither decides it, record a question: `tasks item add --pool calls --key gate --field kind=question --field file=<the site> --body "<the choice; the readings; the one the builder built>" --task <task>`.
- **A `noticed` defect**: the session files these as reports; leave them.

### Report and close

1. Enumerate before you judge: the steps, exits, and shared state of each path; or the behavior changes and users of each definition; or the deltas, commitments, and divergences.
2. Apply the scope test in the catalog to each defect, and name in the report whether the change caused it, reaches it, or neither. Report it either way; the merge agent routes it.
3. One item per defect: `tasks item add --pool reports --key gate --field area=<your area> --field hunt=1 --field entry=<the class code, or A1 to A9 for C2> --field site=<path:function where it goes wrong, or the delta, B-id, or I-id> --field 'files=["<every file the fix would touch>"]' --body "<the class's evidence, per the catalog; and the scope: caused, reached, or stood at the base>" --task <task>`.
4. An unlisted behavior change that meets every user's goal: `tasks item add --pool calls --key gate --field kind=unlisted --body "<path::symbol>; before; after; each user and why its goal holds>" --task <task>`.
5. Close: `tasks close <task> --outcome done --result "<area> <pass>: CHECKED: <paths, exits, and interleavings walked; or behavior changes and users judged; or deltas, commitments, and divergences read>"`, with `CLEAN` appended where you reported nothing. Where you could not finish, `--outcome partial --result "<area> <pass>: partial: <what you did not check>"`.

A behavior change is something a user outside the changed code can
observe: the inputs it accepts or refuses, what it returns, what it
raises, the rows, files, messages, or events it writes, their order,
the state it leaves, and the format of its output. A change no user
can observe is not a behavior change.

A user is a site that depends on the behavior: a caller or reference,
code that reads the same stored data or configuration, or a user
across a release boundary. A user that passes the change on to its
own users is a behavior change in turn; follow it until the change
stops spreading.

A release boundary separates code that ships in one release from a
user that does not update in the same step. The project declares its
boundaries in `.ok-planner/release-boundaries.md`, each with who is
across it, what crosses it, and where in the tree to look. A boundary
need not be part of the declared public surface.

One boundary applies to every project and is never declared:

  Stored state. Data an earlier release wrote and a later release
  reads or writes: database rows and columns, files and objects,
  configuration files a running deployment holds, messages waiting in
  a queue. The data does not update when the code does.

Each behavior change in a sprint's implementation notes carries one
ruling:

- `rewrite`: every user ships in the same release, and the sprint
  changes each user that must change. The code planner sets it.
- `preserve`: users across the boundary observe no change. The change
  adds beside the behavior and alters nothing they reach.
- `migrate: <how>`: the behavior changes, and `<how>` states how old
  users keep working or the refusal they get: both shapes accepted,
  stored data converted, a minimum version named and refused below it.
- `rewrite across <boundary>: <reason>`: the owner accepts that users
  across the boundary break, for the reason given.

The code planner sets `rewrite`, and sets `preserve` or `migrate:
<how>` where the rules, the corpus, or a ruling the owner already gave
determine it, marking it `(call)` after the ruling. Within a major
version a change across a boundary is `preserve` or `migrate` with both
shapes accepted; a migration that refuses an older part is a break. A
behavior change that meets the owner question test above is written
`owner (<boundary>)` until the owner rules. Only the owner sets
`rewrite across <boundary>`.

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
| C3 | Delta not landed | A corpus delta whose artifact (under `.ok-planner/design/`, or under `.ok-planner/subjects/` or `.ok-planner/practices/` for a subject or practice) does not match the delta's final-form body byte for byte, or is not deleted for a retirement. | the delta; the artifact; the first differing line |
| C4 | Commitment contradicted | Code in the change contradicts a commitment a corpus artifact states that the sprint's deltas or work items name, or a story a driver could not get, where a sprint work item asked for the contradicting code. | the artifact and its sentence; the code site; what the code does instead; for a story, the work item that asked for it |
| R1 | Preserved behavior changed | A `preserve` behavior change whose users across the boundary now observe a difference. | the B-id; before and after, from the code at the base and now |
| R2 | Migration not as ruled | A `migrate` behavior change whose old users neither keep working nor get the refusal its ruling states. | the B-id; the ruling; what an old user gets now |
| R3 | Rewrite left a user behind | A `rewrite` behavior change with a user in the release the change did not update, whose goal now fails. | the B-id; the user; its goal and source; what it gets now |
| R4 | Unlisted change breaks a user | A behavior change the notes do not list, with a user in the release whose goal now fails on some path. | the changed site; the user; its goal and source; the trigger, old outcome, new outcome |
| R5 | Boundary user not ruled | A behavior change with a user across a boundary that no ruling covers: the notes do not list the change, or list it without naming that user. | the changed site or B-id; the boundary and its user; before and after |
| M1 | Check fails | A check `.ok-planner/review/config.json` names fails on a file the change touched. Filed by the session. | the check; the file; the output |

A C3 defect is fixed in the run by landing the delta: its fixer
copies the delta's body into the artifact, or deletes the retired
file, and regenerates the catalog TOCs.

An unlisted behavior change that meets every user's goal is not a
defect; it is recorded for the owner as a `kind=unlisted` call. A
change a work item or delta asks for is not a regression; the
completion classes cover it. Every story is checked by the drive,
and the merge agent sorts its failures by the scope test.

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
| A8 | **The code breaks a rule the project states, and the rule decides the fix.** A rule from one of five sources leaves one compliant form for the site, and the code has another: a rule in `.claude/rules/plumbline-coding.md`, where the project carries it; a rule in a code-rule file that `.ok-planner/review/project.md` lists under `## Code rules`; a commitment of a live artifact under `.ok-planner/design/`; a rule of the events standard at `.ok-planner/docs/events.md`; or a ruled practice under `.ok-planner/practices/` whose condition covers the site. A site where two compliant forms remain is a question, not this entry's. | Every site a rule in `plumbline-coding.md`, a rule in a listed code-rule file, a design commitment, a rule of the events standard, or a ruled practice governs. |
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

Where you cannot tell whether an entry covers a site, it stands. Before recording a proposal, test the site against A8: where a rule from one of A8's sources decides the fix, it is a defect under A8, not a proposal. Where you see a harm of the same weight as the entries (wrong or lost data, a destroyed resource, access gained or kept that should not be, a stuck service) that no entry names, leave the code and record a proposal: `tasks item add --pool calls --key gate --field kind=proposal --body "<the site; the harm; the entry wording that would cover it>" --task <task>`.

### This project

#### .ok-planner/review/project.md

# This project, for the review loop

Agents keep this file current: a sprint build that adds or changes a script input updates it in the same stage, and a `/converge` fixer fixes a clear defect in it. The limits under "What no agent of this loop ever runs" bind every agent. The review loop pastes the file into every prompt that reads or runs the tree. It holds the facts a general loop cannot know.

## The root and what is out of scope

The project root is the ok-plugins monorepo root, the folder that holds `.claude-plugin/marketplace.json`. The shipped product is `plugins/` (`plugins/ok`, `plugins/ok-conduct`, `plugins/ok-web`) and the ok-planner family the front door carries at `plugins/ok/families/ok-planner/`. No agent edits the suite-owned files of the vendored suite layer this repo dogfoods: each file under `.claude/skills/`, `.claude/agents/`, `.claude/hooks/`, and `.claude/rules/` that carries the suite's `Materialized by ok-` stamp or is a suite `LICENSE`, `.claude/rules/ok-concepts.md`, and the materialized files under `.ok-planner/`; only `/ok` rewrites them. The project's own files under `.claude/`, such as `.claude/skills/release/`, are in the run like any other file the project owns. No agent reads `.ok-planner/sprints/`, `.ok-planner/sketches/`, or `.ok-planner/history/` unless a skill directs it. A sprint lists no folders outside the root.

## What no agent of this loop ever runs

- `/release` (`.claude/skills/release/`): it commits, tags, and pushes to `origin`.
- `git push`, and any `git tag` pushed to `origin`.
- `claude plugin update`, `claude plugin install`, and `claude plugin marketplace update`: they change the operator's own installed plugins.
- `/ok`: it rewrites the vendored suite layer and `.claude/settings.json`, and stays an owner act.
- `issues name --set` (`plugins/ok/families/ok-planner/scripts/issues`, or a scratch project's `.ok-planner/bin/issues`) with `XDG_CONFIG_HOME` unset or naming the operator's own configuration folder: it writes the operator's own name file, `~/.config/ok-planner/user.json` by default. A driver sets `XDG_CONFIG_HOME` to a scratch folder first, as the dashboard's drive steps say.
- The true-up core at `plugins/ok/families/ok-planner/admin/true-up`, run at the project root: it rewrites the vendored suite layer and the estate this repository dogfoods. A driver runs it only against a scratch project, as "Resources a driver starts" says.

## The helpers the catalogs name

The event helper is `plugins/ok/families/ok-planner/scripts/tasks::event`, `event(kind, **fields)`: it writes one JSON line with the kind and the fields on stderr, and attaches the stack trace to an event emitted while an exception is in flight. Every Python script of the family that emits an event calls it through the `tasks` module it loads. The tree has no atomic-replace helper, and no practice that governs owner frames.

## Code rules

- `.claude/rules/plumbline-cheatsheet.md`
- `.claude/rules/plumbline-coding.md`

## Scripts for developers and operators

- `checks/run`: takes no inputs; runs every check under `checks/` with `python3` and exits non-zero when one fails.
- `checks/token-resolution`, `checks/materialized-standalone`, `checks/vendored-layer`, `checks/owned-paths`, `checks/sprint-boilerplate`, `checks/oscillation`: each takes no inputs and is run by `checks/run`. `checks/sprint-boilerplate` reads the `v*` tags and refuses where the clone holds none.
- `plugins/ok/families/ok-planner/admin/true-up`: takes a mode: `diagnose`, which prints the plan, each destructive step marked `DESTRUCTIVE:`, and a closing `PLAN:` line with the plan's id; none, which applies a plan that holds no destructive step, and where the plan holds one, writes nothing and exits 1; `--go-ahead <plan id> [--drafts <dir>]`, which applies the plan whose id `diagnose` printed, and refuses, writing nothing, where the plan has changed since; `show <path>`, which prints the diff of a rewrite the plan lists and writes nothing; `resolve <id> [--from <draft>]`; `amend <config path> --from <draft>` with the config path `.ok-planner/config.json` or `.ok-planner/review/config.json`; `wire-hooks <group>` with the group `session-start`, `subagents`, or `lint`; `wire-env`; and `check-range <first> <last>`, which writes nothing.
- `plugins/ok/families/ok-planner/scripts/tasks` and `plugins/ok/families/ok-planner/scripts/review`: the task tracker and the review tool, each taking a subcommand. The tracker's `item add --from <path|->` reads JSON Lines, one item per line with `body` and `fields` and optionally `fingerprint` and `state`, and adds every item in one write or none. The tracker's `calls` prints the run's calls table, `| id | kind | stage or role | site | choice |`, one row per item the run's `calls` config selects (every `divergences` item where `calls` is unset), or `None.`. Its `render [--title <title>] [--sprint <path>] [--certification <run file>]` prints the completion report's `## Stages` and `## Calls`, and `--certification` adds the call rows of that run file, each id prefixed `cert:`, without moving the tracker's pointer. The review tool's `drive-stack` reads the `## Drive commands` section of `.ok-planner/review/project.md` and prints `stack` where the section gives a `stack-start` line, `none` where it gives a `- No stack:` line, or `unfilled` with the lines to write on a second line, and refuses a missing section or a `- No stack:` line beside a stack line. Its `drive-command --role` takes `stack-start`, `stack-stop`, `instance-create`, `instance-destroy`, `resource-start`, `resource-stop`, `service-log`, or `sign-in`, with `--name`, `--folder`, and `--service` for the placeholders the line names; it refuses a stack role under `- No stack:`, and a line that names `{tag}`, which the drive no longer fills, saying to run `/ok`, which rewrites the line or asks you to reword it.
- `plugins/ok/families/ok-planner/scripts/issues`: the intake module, taking a subcommand. `file`, `revise <id>`, `respond <id>`, and `import` each read one JSON object (records, for `import`) from `--from <path|->`, and `import` also takes `--over-event-log`, `--over-archived-event-log`, and `--dry-run`, which checks the import under the lock, prints what it would write, and writes nothing. `revise <id>`'s object may also carry `by` (`triage-issues` or `converge`) and `text`, one line saying what changed, and needs both on a routed or ruled issue unless the change is link-only. `close <id>` takes `--from <path|->`, or `--as`, `--reason`, and `--fixed-by` in its place. `rule <id>` and `comment <id>` take `--text <text|->` and sign the message with the caller's name. `name` prints that name and its source, and `name --set <name>` writes `{"name": <name>}` to `$XDG_CONFIG_HOME/ok-planner/user.json` (`~/.config/ok-planner/user.json` where `XDG_CONFIG_HOME` is not an absolute path), outside every project; with no such file, the name is `git config user.name` in the project root. `edit <id> <n> --text <text|->` rewrites, and `remove <id> <n>` removes, your own message number `n`. `unrule <id>` withdraws your own ruling. A person's write with no name refuses with reason `unnamed`, and an edit, removal, or withdrawal of a message another name signs refuses with reason `foreign`; each exits 2. `flag <id>` and `unflag <id>` set and clear the discussion flag. `read <id> [--opened <time>]` marks the issue read in your own ledger under `.ok-planner/.cache/read/`, which git ignores, and writes no intake file; a reader with a name creates that name's ledger the first time, counting everything that exists as read. `promote <id> --sprint <file>` stamps a sprint. `linked <id>` records that triage checked an issue's links. The readers are `list` (`--state`, `--category`, `--artifact`, `--sprint`, `--waiting`, `--unread`, which lists open issues with messages you have not read, or that you have never read, `--flagged`, `--json`), `show <id> [--opened <time>] [--json]`, `links` (`--broken`, `--pending`, `--json`), and `history [--json]`. `--opened` names one record among several closed records under the same id, by its opened time. Every verb but `import` refuses, with reason `layout` and exit 2, an intake that holds pre-v9 event-log rows or markdown issue files under `.ok-planner/issues/`, saying to run `/ok`, which converts it. It works on the estate of the nearest ancestor of the working directory holding `.ok-planner/`, or the one `OK_PLANNER_PROJECT_ROOT` names.
- `plugins/ok/families/ok-planner/scripts/dashboard`: the dashboard's service, taking `--port <n>` (0 to 65535; the default, 0, lets the OS assign one) and `--open` (opens the page in the default browser once the service listens). It finds the estate as `issues` does, serves `.ok-planner/dashboard/` and its JSON routes on `127.0.0.1` until SIGTERM or Ctrl-C, and takes HTTP input:
  - `GET /api/meta`, which answers `name`, the name the service signs with, or null, and `name_hint`, the setting text where `name` is null; `GET /api/issues` (query `state`, `category`, `waiting=1`, `unread=1`); `GET /api/closed` (query `category`); `GET /api/issue/<id>` (query `opened`); `GET /api/file` (query `path`, a path relative to the project root; it refuses a path outside the root, under `.git`, or one git ignores).
  - `POST /api/issue/<id>/rule` and `/comment`, each with a JSON body `{"text": ...}`; `POST /api/issue/<id>/read` (query `opened`); `POST /api/issue/<id>/unrule`, `/flag`, and `/unflag`; `POST /api/issue/<id>/message/<n>/edit` with a JSON body `{"text": ...}`, and `POST /api/issue/<id>/message/<n>/remove`.
  - Every request carries a `Host` of `127.0.0.1:<port>` or `localhost:<port>`, and every POST `Content-Type: application/json`.
  - The service writes and counts unread messages under the name of the person who started it, resolved as `issues` resolves it on each request. A write with no name answers 400, and a change to a message another name signs answers 403.
- `plugins/ok/families/ok-planner/scripts/plumbline`: takes a path to lint, or a subcommand (`config-check [--config <file>]`, `version`). It reads `.ok-planner/config.json` alone, and reports a retired check name under `lint_checks` or the retired object form of `ports` as a config defect that says to run `/ok`.
- `plugins/ok/families/ok-planner/scripts/catalog-toc`: the catalog TOC generator (a project root, or `--check`). It writes the design and coding-standard TOCs, and the docspec index `.ok-planner/docspec.md` where `.ok-planner/docspec/` exists.
- `plugins/ok/families/ok-planner/scripts/run-tag`: the tag generator, a POSIX shell script that takes no argument and prints `run-<12 hex>` from `/dev/urandom` on one line. `-h` or `--help` alone prints its usage line, and any other argument is refused with that line on stderr and exit 1.
- `plugins/ok/families/ok-planner/scripts/ports`: the port registry, taking a verb: `lease <run-tag>`, `release <run-tag>`, `list`, `stale`, `suggest-range`, or `check-range <first> <last>`. `lease` reads `ports` and `port_range` from `.ok-planner/config.json`, prints one `NAME=<port>` line per declared name, and prints nothing where `ports` names none, and refuses the retired object form of `ports`, saying to run `/ok`, which converts it. It counts a port as taken where another lease holds it, a program holds it over TCP or UDP, a docker container publishes it (read through `docker ps -aq` and `docker inspect`, and skipped with a `PORTS.DOCKER.UNCHECKED` event where docker does not answer), or the block list names it (`ports-blocklist` beside the script, and `/etc/services`). It records leases in `.ok-planner/.cache/ports.json`, `{"leases": {<tag>: {"at", "ports"}}, "next"}`, under `ports.lock`, both of which git ignores. `release` exits 0 where the tag holds no lease, and `stale` lists the leases at least an hour old none of whose ports a program holds. It finds the estate as `tasks` does; `suggest-range` and `check-range` read nothing of the project. It exits 0, or 1 on a refusal or a failure.
- `plugins/ok/families/ok-planner/scripts/docker-sweep`: the docker sweep, taking `sweep <run-tag>`, `running <run-tag>`, or `probe`. It runs the `docker` on PATH, reads nothing of the project, and needs no estate. A docker object belongs to the run where it carries `label=ok.run-tag=<run-tag>` or `label=com.docker.compose.project=<run-tag>`. `sweep` removes the run's containers (`rm -f -v`), networks, volumes, and images; `running` prints the id of each running container of the run; `probe` checks the daemon. It exits 0, 1 on a refused removal (every other removal still attempted) or a malformed argument, and 3 where docker is not on PATH or its daemon does not answer.
- `plugins/ok/families/ok-planner/scripts/run-group`: the process-group helper, taking `start <run-tag> -- <command> ...`, `stop <run-tag>`, or `members <run-tag>`. `start` starts a holder process that leads a process group of its own the first time a tag starts, records the group in `.ok-planner/.cache/run-groups.json`, `{<tag>: {"pgid", "at"}}`, under `run-groups.lock`, runs the command from the working directory in that group with its input from `/dev/null` and the caller's output, and exits with the command's status; on Ctrl-C it kills only the command it ran and exits 130, and the rest of the group lives until `stop`; a later `start` for the tag joins the same group while its holder lives. `stop` sends SIGTERM, waits up to 10 seconds, sends SIGKILL, waits up to 2 seconds, and drops the record; it exits 0 where the tag records no group, and 1, keeping the record, where pids outlive SIGKILL or the holder is gone while pids carry the group's id. `members` prints each pid left in the group but the holder. It finds the estate as `tasks` does.
- `plugins/ok/families/ok-planner/scripts/stack`: the reference stack tool, built from the stack helpers, taking a verb: `up [--name <name>]`, which runs the start command `stack` in `.ok-planner/config.json` declares; `up [--name <name>] [--stop <command>] [--tag-variable <NAME>] -- <command> ...`, which runs that command from the project root in the declared one's place, runs the `--stop` command at `down`, and sets the variable `--tag-variable` names (else `stack.tag_variable`) to the tag; `down <run-tag>` or `down --name <name>`; `tag <name>`; `cleanup`; `list`; `suggest-range`; or `check-range <first> <last>`. `up` prints the run tag on line 1, then one `NAME=<port>` line per leased port. A run tag is `run-<12 hex>`, a name is lower-case letters, digits, and hyphens, and a bound an integer from 1025 to 65535. `--stop` and `--tag-variable` without `--` are refused. A bare `up` refuses where `stack` declares no start command. Where a run already holds the name `up --name` gives, `up` takes that run down first when nothing still uses it, and refuses when something does. `down --name` exits 0 and prints `took down: nothing` where no run holds the name; `down <run-tag>` refuses an unknown tag. `tag` refuses where no run holds the name. `list` prints each run's tag, time, ports, and folder, then `name: <name>` where the run has one, then `refused: ...` where a removal was refused. `up` reads `stack` (`start`, `stop`, and `tag_variable`, or `none`), `ports`, and `port_range` from `.ok-planner/config.json`; `down`, `tag`, `cleanup`, and `list` read no stack declaration. It loads `ports`, `docker-sweep`, and `run-group` beside it and runs `sh run-tag` beside it for each tag, leases its ports through the port registry, keeps each run's process group in `run-group`'s registry, probes docker's daemon before and after the start command, records its runs in `.ok-planner/.cache/stack.json`, which git ignores, makes each run's folder under the machine's temp folder (`ok-planner-stack/<tag>/`), and finds the estate as `tasks` does; the start command's environment drops `OK_PLANNER_PROJECT_ROOT`.

## Drive commands

- No stack: the product runs inside a Claude Code session; its stories are offered through skills, which drivers review, and through the true-up core and the materialized scripts, which drivers run against a scratch project.
- The dashboard: a driver serves a page built from the working tree's source, never the committed release build true-up places. It runs the page under the working tree's stack tool, `python3 plugins/ok/families/ok-planner/scripts/stack`, from the project root, and takes these steps in order:
  1. Open the run. Its command works in the run folder, `$OK_RUN_FOLDER`. It makes the scratch project `project/` with `git init` and trues it up by running the root's `plugins/ok/families/ok-planner/admin/true-up` from `project/` with no argument. It copies the working tree's `plugins/ok/families/ok-planner/browser/` into `build/` without its `node_modules/` and `dist/`, and runs `npm ci` and then `npm run build` there. It replaces every file under `project/.ok-planner/dashboard/` but `.gitignore` with the contents of `build/dist/`, and in each copied file replaces `{{OK_PLANNER_VERSION}}` with the version the core's `placed: the dashboard build at .ok-planner/dashboard/ (v<version>), …` line names, as true-up stamps the build it places, so the page's `GET /api/meta` reports a build version that agrees with the service. It makes the configuration folders `config-a/` and `config-b/`, and starts the service from `project/` in the background with `XDG_CONFIG_HOME` set to `config-a/`:

     ```
     python3 plugins/ok/families/ok-planner/scripts/stack up -- sh -c '
       set -e
       root="$PWD" f="$OK_RUN_FOLDER"
       mkdir "$f/project" "$f/build" "$f/config-a" "$f/config-b"
       git -C "$f/project" init -q
       (cd "$f/project" && bash "$root/plugins/ok/families/ok-planner/admin/true-up") > "$f/true-up.log"
       version=$(sed -n "s|^placed: the dashboard build at \.ok-planner/dashboard/ (v\([^)]*\)).*|\1|p" "$f/true-up.log")
       test -n "$version"
       tar -C "$root/plugins/ok/families/ok-planner/browser" --exclude=./node_modules --exclude=./dist -cf - . | tar -C "$f/build" -xf -
       (cd "$f/build" && npm ci && npm run build)
       find "$f/project/.ok-planner/dashboard" -mindepth 1 -maxdepth 1 ! -name .gitignore -exec rm -rf {} +
       cp -R "$f/build/dist/." "$f/project/.ok-planner/dashboard/"
       find "$f/project/.ok-planner/dashboard" -type f ! -name .gitignore -exec perl -pi -e "s/\{\{OK_PLANNER_VERSION\}\}/$version/g" {} +
       (cd "$f/project" && XDG_CONFIG_HOME="$f/config-a" exec python3 .ok-planner/bin/dashboard) &
       i=0
       until grep -q "^dashboard: serving" "$f/stack-start.log"; do i=$((i + 1)); test "$i" -le 100; sleep 0.1; done'
     ```

     `stack up` prints the run's tag on line 1; keep it. `python3 plugins/ok/families/ok-planner/scripts/stack list` prints the run's folder after its tag; below, `<folder>` names it. The service's line, `dashboard: serving http://127.0.0.1:<port>/ (pid <pid>)`, is in `<folder>/stack-start.log`, with the output of every step before it. A failed `stack up` has already taken its run down and printed the start command's output on stderr, and makes the drive's outcome `blocked`: a missing `npm`, or a failed `npm ci` or `npm run build`, fails it.
  2. Where the drive needs a person's name, run `XDG_CONFIG_HOME=<folder>/config-a .ok-planner/bin/issues name --set <name>` from `<folder>/project/`, and the same with `<folder>/config-b` for a second person. Set `XDG_CONFIG_HOME` to one of those folders for every `issues` call. Never run `issues name --set` without that setting: it would write the operator's own `~/.config/ok-planner/user.json`. The service from step 1 signs as the `config-a/` person. To serve the page as the `config-b/` person too, open a second run from the project root, which starts a second service and writes its serving line to that run's own `stack-start.log`:

     ```
     python3 plugins/ok/families/ok-planner/scripts/stack up -- sh -c '
       (cd "<folder>/project" && XDG_CONFIG_HOME="<folder>/config-b" exec python3 .ok-planner/bin/dashboard) &
       i=0
       until grep -q "^dashboard: serving" "$OK_RUN_FOLDER/stack-start.log"; do i=$((i + 1)); test "$i" -le 100; sleep 0.1; done'
     ```

  3. Seed the intake with `.ok-planner/bin/issues file --from -`, one JSON object per issue, run from `<folder>/project/`. Drive the page at the service's address, or its JSON routes with `curl`, sending `Content-Type: application/json` on every POST.
  4. End each run with `python3 plugins/ok/families/ok-planner/scripts/stack down <tag>` from the project root, pass or fail, a second run's tag before the first's. It stops the run's service and deletes its folder: the first run's takes the scratch project, the build folder, and both configuration folders with it.

  Nothing under `plugins/ok/families/ok-planner/browser/` changes during a drive: the driver writes no `node_modules/` and no `dist/` there. The committed `browser/dist/` stays the release artifact that `/release` builds.

## Running the product, for the drive

The product has no stack to start or stop. It runs inside a Claude Code session: the primary user surface is the slash commands the plugins and the vendored skills offer (`/ok`, `/plan-sprint`, `/converge`, and the rest). The other surfaces are the true-up core's command line, the materialized scripts (`.ok-planner/bin/tasks`, `.ok-planner/bin/issues`, `.ok-planner/bin/review`, `.ok-planner/bin/plumbline`, `.ok-planner/bin/run-tag`, `.ok-planner/bin/ports`, `.ok-planner/bin/docker-sweep`, `.ok-planner/bin/run-group`, `.ok-planner/bin/stack`), the dashboard's service at `.ok-planner/bin/dashboard`, which serves a page on loopback while a driver runs it, and the hooks the plugins and the vendored layer wire. No surface signs a user in.

A driver reviewing a skill surface reads the skill's source under `plugins/`, never the materialized copy under `.claude/skills/`.

## Resources a driver starts

A driver that needs a consumer project opens a run of its own from the project root, `python3 plugins/ok/families/ok-planner/scripts/stack up -- sh -c 'git init -q "$OK_RUN_FOLDER/project"'`, keeps the tag it prints on line 1, and finds the run's folder in what `python3 plugins/ok/families/ok-planner/scripts/stack list` prints for that tag. It drives the true-up core at `plugins/ok/families/ok-planner/admin/true-up` against `<folder>/project/`, and ends the run with `python3 plugins/ok/families/ok-planner/scripts/stack down <tag>` from the project root when done, which deletes the folder.

## Stories that drive alone

## Stories that drive on an instance of their own

