## Merge hunts into the defect list

You are a **leaf agent**: never spawn subagents. Do all reading, searching, and verifying yourself with Read/Grep. Your context is 1M tokens; a large reading set is never a reason to delegate. Read shared context (the design catalogs, the rule files) once, up front, and reuse it across every item.

This rule binds the dispatched job it is embedded in and nobody else. It never licenses skipping work. If an instruction you are bound to follow requires dispatching subagents, report the conflict to your dispatcher; never drop the step.

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

Hunters report defects independently, so the same defect arrives several times in different words, some reports are wrong, and some name a harm the accept list does not cover. You turn reports into the run's defect list: each real defect appears once in each area, and each carries the hunts that saw it. The count of defects each hunt added that no earlier hunt of its area found decides whether the area is hunted again, so count exactly. You fix nothing and edit no code.

Your brief names `drive`, `sprint`, `backlog`, or one or more areas, each with the hunt numbers you merge and the ids of their reports. Areas share a brief because their reports touch the same files, so the same flaw may arrive in several of them.

### Read

Every report your brief names: `tasks item list --pool reports --key gate --state open --json`, the items with those ids; for the drive, `tasks item list --pool failures --key gate --state open --json`, and, beside the failures, the close result of each driver whose story they name: `tasks dump --type task`, the task whose id is in the failure's `task` field. The close result lists each variant its driver drove on each surface and its outcome, so it shows what a pass covers. Every defect already on the list for your areas, in every state: `tasks item list --pool defects --key gate --json`, the items whose `area` field names one of them. The code at every site a report names.

### Judge each report

1. **Is it real?** Read the code at the site. A report whose code does not do what the report says is rejected. A report on prose the prose scope rule above leaves out of review is rejected, with that rule as the reason.
2. **Does the accept list cover it?** Apply the list, pasted below, to the harm the code actually causes. A report whose harm no entry covers is rejected, with the list's reason.
3a. **May this run edit the file its fix lies in?** Apply the ownership test below. Go on to step 3 only where the test leaves the report to merge.
3. **Is it already on the list?** Work through each area's hunts in ascending order, so a defect's first hunt is the one that found it first. A report is the same defect as one on the area's list when fixing one would fix the other: the same flaw at the same site, or one root cause behind both, whatever the line numbers or the wording. Where it is, add the report's hunt number to that defect's `seen`: `tasks item set <defect id> --field 'seen=[<the old numbers and the new one>]'`. Where it is not, it is new to the area. Where the same flaw is already a defect of another area, the report still becomes a defect of its own area, with `--field same_as=<the other defect's id>`: each area keeps its own count, and the fixer fixes the flaw once.
4. **Is it one defect?** Split a report that names two flaws into two defects. Join reports of this hunt that name one flaw into one defect.

For a new defect: `tasks item add --pool defects --key gate --fingerprint "<area>:<a short slug for the flaw>" --field area=<area> --field entry=<A1..A9> --field source=<file|flow|drive> --field 'files=["<every file the fix would touch>"]' --field 'seen=[<the report's hunt number>]' --field kickbacks=0 --body "<the site as path:function; what the code does; the trigger; the harm, in the entry's terms; the evidence, path:line quoted; the reports it came from, by id>" --task <task>`. For the drive, add `--field story=<the story slug> --field surface=<the failure's surface> --field variant=<the failure's variant>` and use the area `drive` and hunt `1`. A defect that folds failures on several variants names each in `variant`, joined by `, `.

Then settle every report: `tasks item set <report id> --state merged --note "<defect id>"` or `--state rejected --note "<why: not real, or which part of the accept list leaves it standing>"`, unless the ownership test already settled it.

### The ownership test

The fix line rule above decides which files this run may edit. Name every file the fix lies in, and run `.ok-planner/bin/review owner <the files>`; where .ok-planner/sprints/2026-10-16-docspec-and-audit-backout.md names a sprint and its change deleted a file, add `--base 89b51cf0e6d7a570fe9368a0728bf8cee9178354`. The command prints one kind per file. It does not detect a document the release regenerates: a file at a target a declared document type under `.ok-planner/surface/documents/` names (a folder target covers the folder), or a file that opens with the provenance stamp `/document` writes. Check each `project` file for that yourself. Then settle the report or failure by the first of these that holds:

- **A file reads `corpus` only because the review script's list classes it so, and a rule the corpus states decides the file's class otherwise.** The list, `OWNER_PATHS` in the review script, is the defect's site under A8, and the fix lies in the file that holds it: `.ok-planner/bin/review`, or the review script's canonical source where this project's facts below name one. Name that file in the fix's files in place of the misclassed file, and name in the note the corpus rule that decides the file's class, by artifact slug and sentence. Then apply this test again to the new files: the report merges where it leaves the report to merge, and goes `upstream` where it classes the file `suite`.
- **.ok-planner/sprints/2026-10-16-docspec-and-audit-backout.md names a sprint, and the report's entry is C3.** A delta of the certified sprint did not land, and the fix line rule above allows its one corpus write: the copy of the delta's body, or the deletion of the retired file, and the catalog TOCs `python3 .ok-planner/bin/catalog-toc` regenerates. Merge the report as a defect with `--field entry=C3` and its `files` set to the artifact and every collection's catalog TOC (`.ok-planner/design/concepts.md`, `.ok-planner/design/stories.md`, `.ok-planner/design/decisions.md`, `.ok-planner/subjects.md`, and `.ok-planner/practices.md`), since the tool rewrites them all, and go on.
- **A file is `corpus` or `declaration`.** The fix changes what the corpus or the harness settings commit to. `tasks item set <id> --state judgment --note "<the file; its kind; the defect; the evidence>"`, and merge nothing. The owner list files it in the intake as a judgment issue, and the run spends no fix, verify, or backout task on it.
- **A file is `suite`.** The suite maintains it, and the next `/ok` overwrites a local edit. `tasks item set <id> --state upstream --note "<the file; the harm; the evidence>"`, and merge nothing. The owner list files it in the intake.
- **Every file is a `record` or a document the release regenerates.** The act that owns the file changes it, and the run files nothing about it. `tasks item set <id> --state rejected --note "left alone: <record or release document>; <the file>"`, and merge nothing.
- **Otherwise** the fix lies in files the project owns. Drop from the fix's files any record or release document the report names beside them, and go on.

This test runs in every mode, and before the sprint's scope test.

### The drive's failures

Each failure is one story a driver could not get the benefit of: `failed`, `stuck`, or `blocked`. A merge that turns a correct product into a defect does harm, and so does a merge that clears a failure the story owes. Sort each failure by what the story's text names before you merge it. The story's text, and the Choice of a decision under `.ok-planner/design/`, decide what the product owes. A sprint work item never decides what a story owes.

- **defect**: the story's text, or a decision's Choice, names what the driver could not get, a missing flow included, and the product does not deliver it, or gives a user no way to find how. A page or a message that tells the user something false is a defect, whatever a work item says. For a `failed` story, read the path the driver's actions took, from the frame that receives the user's action to the result the user saw, and name the function where it goes wrong. For a `failed` skill surface, read the file the failure names and the story, and name the sentence or line where the text diverges from the story's intent; the file is the site. A `stuck` story is a defect where a message or a help text the user met failed to say what went wrong or what to do next: name that place and what it says. A `stuck` story is also a defect where the user needed a page, a verb, or a flow the product does not offer, and the story's text, or a decision's Choice, names it: name the frame where the user looked for it, and the sentence that names it. Merge it as a defect, with `--field story=<slug> --field surface=<the failure's surface> --field variant=<the failure's variant>`, then `tasks item set <failure id> --state defect --note "<defect id>"`. The entry is A8, a live artifact's commitment, for a page, a verb, or a flow the story names that the product does not offer, unless A3 fits better; A9 for a page or a message that tells the user something false; and A3 for every other failure. Where .ok-planner/sprints/2026-10-16-docspec-and-audit-backout.md names a sprint and a sprint work item asked for the code that contradicts the story, the entry is C4, a commitment contradicted. Two failures with one cause are one defect naming both stories.
- **not-owed**: the driver sought something beyond what the story's text, or a decision's Choice, names. `tasks item set <failure id> --state not-owed --note "<what the driver sought, and the story's text or Choice it goes beyond>"`.
- **environment**: the story was `blocked` by the stack, the machine, a local tool, or a need a local stack cannot meet. `tasks item set <failure id> --state environment --note "<the cause, and what the owner would do about it>"`.

A3 and A8 cover every story failure: A3 names every failure the drive records among its sites, and A8 every commitment of a live artifact. Each line of what the accept list leaves standing stands only where no entry above also holds, so no line clears a story failure.

Before you merge a defect from a failure, apply the ownership test above to the file its fix lies in; for a skill surface, that is the file the failure names. Go on only where the test leaves the failure to merge. Where .ok-planner/sprints/2026-10-16-docspec-and-audit-backout.md names a sprint, this run certifies it from the base commit 89b51cf0e6d7a570fe9368a0728bf8cee9178354, and the drive stays inside its scope: apply the sprint catalog's scope test to the function you named, reading it at the base. Where the code stood the same at the base and the sprint's change does not reach it, the defect is real but outside the sprint: `tasks item set <failure id> --state backlog --note "<the site as path:function; the entry; the evidence; why it is outside the sprint>"`, and merge nothing. The owner list files it in the intake for the next run.

Where the story's text, or a decision's Choice, leaves two readings of whether it names what the driver sought, A8 makes the failure a question rather than a defect. Sort it `not-owed` with the note `two readings: <the first>; <the second>; <the sentence each rests on>`, and record a question: `tasks item add --pool calls --key gate --field kind=question --field file=.ok-planner/design/stories/<slug>.md --body "<what the product does>; <the two readings, and the sentence of the story or the Choice each rests on>" --task <task>`.

### A sprint's reports

Where your brief starts `sprint`, this run certifies the sprint at .ok-planner/sprints/2026-10-16-docspec-and-audit-backout.md, from the base commit 89b51cf0e6d7a570fe9368a0728bf8cee9178354. The reports come from the sprint's review passes and from defects the sprint's builders noticed outside their files. Judge each by the sprint catalog below as well as the accept list:

1. **Is it real?** As above.
2. **Is it covered?** By an accept-list entry, or by a sprint class: C1, C3, C4, R1 to R5, or M1. A report neither covers is rejected.

3a. **May this run edit the file its fix lies in?** Apply the ownership test above, even where the sprint's change edited the file or a delta heading names the artifact. A C3 report merges by the test's C3 bullet: the fix loop lands the delta, and the report is never set `judgment`. Any other report whose fix lies in the corpus is set `judgment`, whatever delta names its artifact. Go on to step 3 only where the test leaves the report to merge.

3. **Is it in the sprint's scope?** Apply the catalog's scope test, reading the site at the base. In scope: merge it as a defect under its area, with `--field entry=<the class code or A1 to A9> --field source=sprint`. A defect the accept list covers whose code stood the same at the base, and which the change does not reach, is real but outside the sprint: `tasks item set <report id> --state backlog --note "<the site; the entry; the evidence; why it is outside the sprint>"`. The owner list files it in the intake for the next run.
4. **Is it already on the list, and is it one defect?** As above.

A report of an outcome not reached (C1) or a commitment contradicted (C4) that forks on what the owner wants, where the sprint and corpus do not decide it, is rejected with a question recorded, as for the drive below.

### The backlog's reports

Where your brief starts `backlog`, the reports come from `category: defect` issues in the intake, each with its issue's id in the `issue` field; `.ok-planner/bin/issues show <the id>` prints the whole issue, its discussion included. Judge each like a hunter's report, the ownership test included. A report with no site and an empty `files` came from an issue whose problem names no file of this tree: find the site the problem describes and name the files its fix touches. A defect the code no longer shows is rejected with the note `gone`, and the owner list closes its issue. Merge each real one with `--field issue=<the issue id>` and its source `backlog`.

### Count

Record each area's hunts, one item per area and hunt number in your brief, exactly once: `tasks item add --pool merges --key gate --state done --field area=<area> --field hunt=<hunt number> --field new=<defects of the area whose first hunt is this one> --field matched=<reports of this hunt folded onto a defect the area already had> --field rejected=<reports and failures of this hunt rejected> --field judgment=<reports and failures of this hunt set to judgment> --field upstream=<reports and failures of this hunt set to upstream> --body "<one line>" --task <task>`. `new` counts defects, not reports: three reports of one new flaw add one. For the drive, record one item with area `drive` and hunt `1`.

### Rules

Edit no file. Stage nothing. Commit nothing.

### Close

`tasks close <task> --outcome done --result "merge: <per area and hunt: new, matched, rejected, judgment, upstream>"`; for the drive, add the counts of failures sorted `defect`, `not-owed`, `environment`, `judgment`, `upstream`, and `rejected`, and, where .ok-planner/sprints/2026-10-16-docspec-and-audit-backout.md names a sprint, `backlog`.

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

### The standards, verbatim

#### .ok-planner/docs/events.md

# Events: the standard

This standard governs the structured events the code emits: where it
emits, what an event is, and how a kind is named. Code review enforces
it: entry A8 of the accept list counts a breach of it as a defect. No
lint checks it.

## Where the code emits

The code emits an event at each of these sites:

- every error caught: a catch that stands under the Errors section of
  the plumbline cheatsheet emits on the caught path, or ends in a bare
  `raise` and leaves the emission to the owner frame above it;
- every owner frame: its catch-all emits one event for each raise it
  disposes;
- every retry: each attempt after the first.

Each site is a construct a grep lists: a catch block, an owner frame's
catch-all, a loop that calls the failing operation again. A state
transition and a branch taken on external input are not sites: neither
names a construct, and an event added on such a judgment is one
reader's, not the code's.

A boundary crossing — I/O, RPC, a process spawned or exited — is not a
site of its own. A failed crossing raises the library's error, and the
error propagates to the owner frame. The owner frame's event is the
event for the failed crossing. The project's event helper attaches the
stack trace to every caught-error event emitted while an exception is
in flight, so that event names the library, the type, and the line
that failed. The project names that helper in its own rules. A wrapper
emits on a crossing only where its catch stands under the Errors
section.

Internal pure computation that touches no state, no boundary, and no
error emits nothing. A caught error that neither emits nor re-raises is
a defect.

## What an event is

An event is a kind plus structured fields. Prose lives in a field,
never in the kind. A field carries one value under one name; a reader
filters on the kind and on any field without parsing text.

## How a kind is named

- A kind is a raw string literal at the site that emits it. It is
  declared nowhere else: no enum, no constant, no registry.
- A kind is a dotted namespace in one case, `SUBSYSTEM.NOUN.VERB` —
  for example `QUEUE.JOB.RETRIED`. Each segment starts with an
  upper-case letter and continues with upper-case letters and digits.
  The segments join with a dot.
- A kind is unique in meaning across the tree.

## What stays the project's

Library, transport, levels, sampling, and wire format are the
project's own choices. The standard governs the sites, the shape, and
the naming.

