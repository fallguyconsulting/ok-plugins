# .ok-planner — the planner's directory

Materialized by ok-planner v{{OK_PLANNER_VERSION}}. Suite-owned
boilerplate: true-up (`/ok`) overwrites this file wholesale. Do not
hand-edit it; project guidance belongs in the project's root
CLAUDE.md.

This directory holds several kinds of content with different
lifecycles and different rules.

## Durable design docs (`design/`) — source of truth, read freely

The project's durable model, three self-contained catalogs:

- **`concepts/`** — load-bearing nouns with definitions, purposes,
  and boundaries. A concept defines; it guarantees, forbids, and
  decides nothing.
- **`stories/`** — durable user expectations, each one statement of
  user need (`As <role>, I want <capability>, so that <benefit>`; the
  "so that" clause is mandatory) and nothing else. Its only
  acceptance is that the user has a way to do the capability and gain
  the benefit, stated concretely.
- **`decisions/`** — technical decisions: choice, rationale,
  alternatives.

**The name `design/` is a label.** The directory holds the project's
durable identity — what the project is and what it owes its users —
never specific designs: interface grammars, route shapes, schema
details, and implementation diagrams live in code, in `sprints/`, and
in other project documentation.

Code references the corpus via `@concept:` / `@story:` / `@decision:`
annotations at points of enforcement; the corpus references no code.
The corpus is a source of truth with the same weight as code and
describes the project as it stands. What it commits to changes only
by applying an approved sprint's corpus deltas. `/converge` and
`/triage-issues` edit no corpus file, except that sprint
certification lands an approved delta of its own sprint that
execution missed, the one corpus write a review run makes. Where the
corpus needs any other change, they name it in an issue and leave it
for a sprint. Read the corpus freely; it is not a record.

**Leave the annotation.** Rollout is incremental and every session's
job: whenever you consult a concept, story, or decision to understand
or modify a file, leave `@concept:` / `@story:` / `@decision:` plus
the slug in a comment at the most-specific load-bearing site — the
function, branch, or block that enforces the commitment. Kind plus
slug only: no file path, no line number, no quotation. Leave an
existing annotation alone; repoint or remove one whose slug no longer
exists. Navigation is the annotations' one job: they play no part in
a review's scope.

**The TOCs are generated.** `concepts.md`, `stories.md`, and
`decisions.md` list one line per artifact; `bin/catalog-toc` rewrites
them, and applying a concept, story, or decision delta includes
running it. A hand edit is discarded by the next run.

## The coding standards (`subjects/`, `practices/`) — read freely

The project's own coding policies, two owner-authored catalogs beside
`design/`:

- **`subjects/`** — each names an enumerable population of constructs
  in this codebase: what a member is, and how a reader lists them.
- **`practices/`** — each says, affirmatively, what this codebase does
  about some members of one subject, the condition under which it
  governs, and the maintenance operation it buys. A departure is a
  competing practice, never an exemption.

`practice-definitions.md` carries the authoring rules. Subjects and
practices are corpus: what they commit to changes only by applying an
approved sprint's corpus deltas, and `/converge` and `/triage-issues`
edit neither, save sprint certification's landing of a missed delta.
Code cites the practice that governs it with a
`@practice:` annotation at the site. A member no practice covers is a
gap, the owner's question; a site that departs from its practice is a
defect, which `/converge` fixes or files as a `category: defect`
issue. **The TOCs are generated.** `subjects.md` and `practices.md`
list one line per artifact; `bin/catalog-toc` rewrites them, and
applying a subject or practice delta includes running it. A hand edit
is discarded by the next run.

## The standards documents (`docs/`)

`docs/events.md` (the events standard) and `docs/technical-writing.md`
(the writing standard) are suite-owned and overwritten on every
true-up. `.claude/rules/plumbline-cheatsheet.md` carries the ambient
copy of each; read the standard for the full text.
`docs/stack-helpers.md`, the reference document for the stack helpers
and the reference stack tool, is suite-owned and overwritten on every
true-up too; read it before you build or change a project's stack
tooling. The review loop's
`standards` setting pastes the events standard and the practices into
`/converge`'s prompts, so review fixes a breach of either as a defect.

## The configuration (`config.json`)

`config.json` is the project's configuration, written by hand, by a
`/converge` fixer, or by `/ok`, which rewrites a retired key and
transcribes the owner's answers, and never overwritten. It turns each lint check on or off
(`lint_checks`; a check it does not name is on, and an off check's
rules leave the materialized rules text), declares the citation tags
the lint resolves (`citations`), the test paths (`tests`), the paths
the lint skips (`ignore`), the folders the project owns beside its
root (`folders`, which the lint and the review loop read), and the dashboard's title, shown
exactly as written (`title`; `ok-planner dashboard` where absent).
`ports` and `port_range` are the port registry's settings
(`bin/ports`), and `stack` is the stack the reference stack tool,
`bin/stack`, runs when called with no command. No process prompt
reads any of the three. An absent file means the defaults.

## The lint and the hooks (`bin/`, `hooks/`)

`bin/plumbline` is the lint, a node script: `node
.ok-planner/bin/plumbline <path>` exits 0 clean, 2 with violations,
and 1 on an internal error. `hooks/post-edit.js` runs it over the file
each Edit or Write touches, where the owner consented to its wiring: a
violation blocks, so the agent fixes it in the same turn, and an
internal error shows its message and blocks nothing. `bin/issues` is
the issue intake's one reader and writer, and `bin/dashboard` serves
the intake's dashboard; the issue intake section below describes both. `hooks/session-start` tells each session which ok-planner
version is materialized. Every file under `bin/` and `hooks/` is suite-owned and
overwritten on every true-up.

## The public surface (`surface/`)

`surface/surface.md` is the **surface intent**: one prose document of
class rules with named exceptions, naming which classes of element are
public (the CLI verbs, the HTTP routes, the published env vars), which
specific elements depart, and, under
`## Where each class is declared`, the files that declare each class's
members, such as a command table or a route table. It is owner intent, read like the
design corpus: it changes only by applying an approved sprint's
surface intent delta, save true-up's migrations, which change no
commitment. `/converge` leaves it alone and names a needed change in
an issue for a sprint.

Nothing is public until you declare it. An element no rule or
exception makes public is internal, and a new feature makes nothing
public but a new member of a class a rule already makes public.
Declaring a docspec in `/plan-sprint` opens the question of what
surface it describes, and your answer becomes a surface intent delta in
the same sprint. Every class the intent makes public has a reference
docspec that lists it. Every element the intent
classes as public is a release boundary, with its callers outside the
project across it: planning sends a change that breaks its contract
to the owner, and a fix keeps it working. A reference docspec names the
classes its documentation lists in full, and reads the intent to learn
which classes are public. `/converge` in `analysis` mode cuts one flow
area per declaring file on each run; where the project has no surface
intent, or it names no declaring file, the run hunts file areas only
and says so in its return.

No stored list of surface members exists: no extraction, no map, no
index of entry points. Whoever needs a class's members lists them from
the tree at that moment, starting from the declaring files: a
documentation sprint's writer as it writes reference documentation,
and its checker again, to check that the documentation misses none.

## The docspecs (`docspec/`, `docspec.md`)

`docspec/<slug>.md` holds one **docspec** per kind of documentation
the project keeps: the owner's order for documentation written for
humans, or for agents that use a deliverable shipped without its
source. Its frontmatter is `docspec: <slug>`, and its sections say
where the documentation lives (`## Where`: a file, a folder and how
its files are laid out, or `in code:` and the files whose doc comments
are the documentation), whom it is for (`## Reader`), what it covers
(`## Covers`), which parts of the project it describes
(`## References`: corpus artifacts and code paths), the surface
classes a reference document lists in full (`## Lists`), the parts of
one file in order (`## Shape`, copied from a template under
`docs/shapes/` when the docspec is declared), the tool that builds
in-code documentation (`## Generator`), and notes. A docspec carries
the order, never the text. An agent working with the source reads the
design corpus, the code, and the rules, not the documentation. A
docspec is owner intent, read like the design corpus: it changes only
by applying an approved sprint's docspec delta, save true-up's
migrations, and `/converge` leaves it alone. `docspec.md` is the
generated index, one line per docspec with its location and
references; `bin/catalog-toc` rewrites it, and applying a docspec
delta includes running it. The lint reads its `in code:` lines: a doc
comment is allowed only in a file one of them names. Where `docspec/`
is missing, the project declares no documentation.

**Only a documentation sprint writes documentation.** A sprint
declares docspecs and the surface; its builders write no
documentation and no doc comment, and sprint certification checks
none. On your schedule, usually before a release, `/plan-docs` runs
`bin/docs window`, which finds each docspec whose references, listed
classes, docspec text, or documentation changed since its stamp. A
planner per docspec names each file to write, change, or drop and the
rules that fire on it, reading the sprints closed since the stamp for
intent. You approve each docspec's first worked example, decide each
change no sprint explains, and approve the plan once. The
documentation sprint, in `doc-sprints/`, runs under `/goal` on the task
tracker: writers edit only where a rule fires, a cold style pass reads
each changed file once and decides from its diff whether it needs a
review, and a fact loop with no cap checks every claim against the
tree, by running it, asking the program, or reading the code, until
every claim holds or is cut. `bin/docs complete --sprint <path>` prints
`DOCS COMPLETE` when it is done. After you commit, `bin/docs stamp`
writes each docspec's stamp and claim ledger to `doc-state/<slug>.json`,
so the next run checks again only the claims whose sources changed.

**Direct documentation edits are reconciled at planning.** Over the
window since the last closed sprint, `/plan-sprint`'s reconcile step
flags documentation a person edited outside a documentation sprint,
and you decide each: the edit stands (with a docspec delta where it
changed what the documentation covers), or an issue records it and
defers it. A change to what a docspec describes needs no flag: the
next documentation sprint's window finds it.

## The issue intake (`issues.jsonl`, `bin/issues`, `bin/dashboard`) — questions and defects

The intake is one JSON Lines file, `issues.jsonl`, with one record
per open issue. Closing an issue moves its record to the archive,
`history/issues.jsonl`, a record like the rest of `history/`.
`bin/issues` is the intake's one module: every filer, `/triage-issues`,
`/plan-sprint`, `/converge`, the front door's administration, and the
dashboard read and write both files through it. It checks every record
against the issue format the skills carry. It reads every record with
an id, keeping fields it does not know, and skips only a line that is
no record at all, keeping that line in its file and naming it in a
note on stderr. It
runs every write under one lock, `.cache/issues.lock`, replacing each
file whole. Never edit either file by hand; `bin/issues
--help` lists the verbs.

A person flags an open issue for discussion with `bin/issues flag
<id>` or the dashboard's flag. When a person asks a session to go
over the flagged issues, list them with `bin/issues list --flagged`,
take them one at a time with `bin/issues show <id>`, and record what
that person decides with a person's own verbs, on that person's word:
`rule`, `comment`, or `unflag` once the issue needs no more talk. The
session writes under the name of the person running it; where no name
resolves, the write refuses with the step that sets one, and the
session relays that step and records nothing until a name resolves.
Closing an issue drops its flag.

The intake holds two kinds, told apart by the record's `category`. A
**judgment issue** asks the owner to choose: what the product commits
to, or how the project's own tooling works. An **upstream issue**
(`category: upstream`) is a judgment issue whose fix lies in a part
the project does not own: a suite-owned file, a library the project
depends on, an outside tool or service, or a harm the accept list does
not name. A **defect issue** (`category: defect`) names a harm the
accept list at `review/catalog/accept.md` covers, at a named site, for
the next `/converge` to fix. The "Defect issues" section of
`.claude/rules/ok-planner-cheatsheet.md` carries the full rules.

The filers, each through `bin/issues file`: `/converge`'s owner list
(defects outside a run's scope, stuck defects, questions about what
the product owes, and upstream issues), a sprint's build task
(upstream issues alone), `/discover-design`'s bootstrap, `/plan-sprint`
transcribing a question you postponed, the front door's
administration (one issue for each retired suite script caller it
cannot repoint, and one for a review facts file it cannot decode), and
humans directly. `/triage-issues` then routes each record no run has
routed: it answers an issue the code, the corpus, or the tooling
already settles; retires a defect claim the accept list does not
cover; turns a covered defect claim into a `category: defect` issue
with a generated ruling; leaves an upstream issue (a proposed
accept-list entry the list does not cover, a change to a suite-owned
file, or another harm in a part the project does not own) open with a
draft ready to file and a recommended ruling, for the next
`/plan-sprint`, and closes it once the project no longer shows the
harm; and sends every other judgment issue to the next `/plan-sprint`
with a generated or recommended ruling. Left standing, those rulings
ride the next `/plan-sprint`, named as batches at sign-off; rule in
your own words to override one. An upstream issue, and an issue
carrying a person's comment that triage has not yet seen, ride
nothing: `/plan-sprint` walks each with you. Triage changes no code
and no design doc.

**The discussion.** Every record carries its discussion: the comments
and rulings people write, each signed with its author's name, and the
replies and updates agents write in answer. Anyone who works the
intake comments; comment on an issue to question or correct its
analysis. Your name is the one `bin/issues name --set <name>` keeps
for you outside every project, else git's user.name; `bin/issues name`
prints it, and a comment or ruling with no name refuses with the step
that sets one. The next `/triage-issues` run answers each person's
message it has not yet seen: it replies where the message asks
something, revises the issue where the message shows it wrong or
thin, and marks the message seen only after acting on it. It never
rewrites a ruling. Your reading is your own: it lives in your ledger
under `.cache/`, which git ignores, so your reading clears no one
else's unread marks. On an open issue, every message, a person's
comment or ruling included, stays unread to each person but its author
until that person reads the issue: a triage reply, an agent revision
of a routed or ruled issue, and another person's comment or ruling
alike. Reading an issue marks every message on it read, and a message
counts once, by its number, so an edit or withdrawal of a message you
already read does not count again. An open issue you have never read
counts as new. You change or withdraw only your own messages.

**A ruling is a person's alone.** Anyone who works the intake rules,
with `bin/issues rule <id> --text <your words>` or on the dashboard,
whenever they like; the next `/plan-sprint` pulls every ruled issue in
without re-discussing it. A later ruling, by anyone, replaces the
earlier one. Agents write only the marked generated or recommended
ruling, beside a person's and never over it, or transcribe a decision
a person gives live, under that person's name.

**The dashboard (`bin/dashboard`, `dashboard/`).** `bin/dashboard`
serves a local page, on loopback only, for working the intake: the
issues that need a ruling, those with analysis you have not read or
that you have never read, those waiting on triage, the ruled, and the
closed, each issue with its discussion, and keys to rule and comment.
It reads and writes through `bin/issues`, as the person who started
it: it signs that person's comments and rulings with that person's
name, counts that person's unread messages, and shows each message's
author. The `/dashboard` skill starts it as a
process detached from the session and opens the page in your browser;
the service keeps running after the session ends until you stop it
with the skill or `kill <pid>`. It also
runs from a terminal as `python3 .ok-planner/bin/dashboard`, which
opens the page too with `--open`. `dashboard/` holds the page's build: the
front door's administration places it at the version the estate is
stamped with, and an ignore file inside it keeps it out of git. It is
suite-owned and overwritten on every true-up.

**Intake, not a work tracker.** A judgment issue is a question waiting
for a ruling, never worked or tracked here. It closes three ways, each
an owner act recorded through `/plan-sprint`:

- **Promoted** — the resolution is carried into a sprint as a corpus
  delta, a work item, or both, and the record's `sprint` names that
  sprint's file. The sprint is then the source of truth: nothing
  re-opens the issue, and no agent reads the record to learn what a
  promoted issue meant. The record moves to the archive when the
  sprint's implementation closes.
- **Answered upstream** — the owner files an upstream issue's draft
  with the ok suite or the foreign part's maintainers; the ruling
  names where it was filed, and the record closes as `answered` at
  once. An upstream issue the owner answers with a workaround is
  promoted, and one answered both ways is promoted with the ruling
  naming the filing.
- **Retired** — the owner drops the question; the record closes as
  `retired`, with the reason, at once.

A promoted decision that later proves wrong is a new issue. A defect
issue closes through `/converge`: `fixed` when the run verified the
fix, `answered` when the code no longer shows the defect. A defect
issue the owner picks into a sprint closes as `promoted`.
`/triage-issues` closes an upstream issue as `answered` once the
project no longer shows its harm.

Open issues gate the work they bear on, not all work. A
`/plan-sprint` planning new work pulls the ruled issues in first,
drafts, then resolves with the owner every unruled open issue that
bears on the draft — building over such an issue would decide it
silently. Independent issues stay open for a later sprint. A sprint
convened to work the intake takes it, or a named batch, as its
agenda.

**Earlier layouts.** Markdown issue files under `history/issues/` are
records of an earlier layout: they stay as written and read as
closed, a `repaired` status included. `bin/issues` reads only the
current layout. Where `issues/` still holds markdown issue files, or
`issues.jsonl` or `history/issues.jsonl` holds the pre-v9 event log,
every verb refuses, naming the file and saying to run `/ok`. True-up
converts the earlier layout as steps of its plan, under the owner's
one consent: it turns each open markdown file into a record and moves
every file to `history/issues/`, converts the live log in place, and
converts the archived log's closed issues into archived records.
Never edit the log or the files.

## The review estate (`review/`, `bin/review`)

`review/` is the review loop's estate. `/converge` reads and writes
it, and `/triage-issues` reads its accept list. `review/CLAUDE.md`
describes each file: `catalog/` is suite-owned and overwritten on
every true-up; `config.json` and `project.md` are seeded once and
are the project's after, and agents keep `project.md` current; `rotation.json` records which analysis areas
were hunted when; `runs/` holds one ledger and folder per run,
records out of context by default. `bin/review` carries the loop's
mechanical verbs.

## Project records (`sprints/`, `doc-sprints/`, `doc-state/`, `sketches/`, `history/`) — out of context by default

The record discipline: records are committed, versioned parts of the
project, out of agent context by default, with one live exception —
the sprint or documentation sprint currently being executed. Every completed or retired
record moves to its same-named folder in the archive.

`sprints/` holds sprints from `/plan-sprint`, and `doc-sprints/`
documentation sprints from `/plan-docs`. `doc-state/` holds each
docspec's stamp, claim ledger, and worked example, which only
`bin/docs` writes. `sketches/` holds
sketches from `/sketch` — speculative future thinking. `history/`
holds one archive folder per artifact kind (`sprints/`, `doc-sprints/`, `sketches/`,
`discover/`, the discovery notes `/discover-design` archives, and on
migrated projects `issues/`, the markdown issue files of an earlier
layout, `specs/`, `plans/`, `coverage/`, `tensions/`), and
`issues.jsonl`, the closed issues' records that `bin/issues` writes,
preserved indefinitely. On a project trued up past the retired
`/audit` and `/document`, it also holds their records as they closed:
`audits/`, `experiments/`, and `documentation/`. True-up archives
what an earlier release left that the current skills no longer use in
a folder under `history/` named as the content was. The discovery notes `/discover-design` leaves
at `design/_discover/` are records too, until the owner archives them.

- Do not consult these files to understand the project; the codebase
  and `design/` are the source of truth.
- Do not include them in general repository exploration.
- Do not propose updating, refreshing, or reconciling them with the
  code; drift is expected.
- Do not edit, rename, move, or delete files here on your own
  initiative.

Read or touch them only when the user asks or an ok-planner skill
directs it. Do exactly what was asked, then stop.

## The task tracker (`bin/tasks`, `tasks/`, `.cache/`)

`bin/tasks` is the task tracker an orchestrating session drives: one
append-only JSONL log per run, holding tasks, the items agents file
into keyed pools, and the events between them. A run file lives where
the ceremony that created it put it — `tasks/<name>.jsonl` by default,
or beside a sprint — and is committed with the work it records. The
derived SQLite index, the lock, the pointer to the selected run, and
the prompt files a ceremony resolves for a run live under `.cache/`,
which the tracker ignores from git itself; so do the issue intake's
lock, which `bin/issues` takes afresh for each write, each person's
read ledger, which `bin/issues` keeps under `read/`, and the
registries of the stack helpers: `stack.json`, where `bin/stack`
records each run, `ports.json`, where `bin/ports` records each lease,
and `run-groups.json`, where `bin/run-group` records each process
group, each under its own lock. Delete the directory between runs,
never during one: `tasks rebuild` recreates the index, the next run
rewrites its prompts, and a running claim reads its prompt from there.
Deleting it also loses those registries, so delete it only when
`bin/stack list` and `bin/ports list` print nothing.
It also starts each person's read ledger fresh, with everything
counted as read. Agents dispatched against the tracker are the vendored
profiles under `.claude/agents/` (`ok-opus`, `ok-haiku`, and
`ok-review`, the forking profile of sprint certification's review),
each pinning a model and an effort; the drain loop at
`.claude/skills/_tasks/drain.md` drains a run.
Never hand-edit a run file; the tracker's verbs are the only writers.

## Lifecycle summary

`/sketch` captures an unplanned idea in `sketches/` — single-pass,
speculative, no authorization to build. When the idea is taken up
through `/plan-sprint`, that session's terminal phase moves the
sketch to `history/sketches/`.

`/plan-sprint` produces a sprint in `sprints/`: final-form deltas to
the corpus, the coding standards, the docspecs, and the surface
intent, work items, implementation notes, and a fixed completion contract, with the open issues that bear on the work resolved by the
owner in-session and promoted in, and the defect issues the owner
picked. A code planner writes the implementation notes: the code
changes, every existing behavior they alter with its ruling, and the
improvements the sprint takes, judged against the release boundaries:
those `release-boundaries.md` declares, stored state, and the public
surface. The approved sprint ends planning and is
from then on the source of truth for that work.

Sprint certification, `/converge sprint <path>`, closes an executed
sprint. On the owner's
cadence, `/converge` in `drive`, `analysis`, or `defects` mode finds
and fixes defects across the product, and `/triage-issues` verifies
the intake.

## Executing a sprint

**The sprint document is the brief.** Every sprint carries a fixed "How
to execute this sprint" section: read the sprint whole, open the
sprint's task run, plan the work into stages — each the smallest change
that makes progress toward the completion contract and leaves the tree
runnable — filed as build tasks (a sprint is never rewritten into a
plan document; the harness task tools, where available, mirror the
stages one entry each, created at filing, marked in progress at
dispatch and done as each build closes), drain them,
apply deltas verbatim with the work, work
unsupervised to the contract, and keep the **completion report**
current — the file beside the sprint (same filename with
`-completion`), rendered from the run, recording the work done and
every call. Follow that section; nothing here overrides it.
"Implement sprint X" is an ordinary working session — inline, a fan-out
of subagents, or an external orchestrator all owe the same completion
contract — so a sprint can be handed to the native goal mechanism
(`/goal <path-to-sprint>`).

**Execution is a task run the session plans and drains.** The session
records the base commit beside the sprint, reads the sprint and the
code, cuts the work into stages from the implementation notes, and
files one **build task** (`ok-opus`, under the sprint build prompt)
per stage into the task tracker, naming the files it may touch, the
work items and slugs it cites, and the stages it builds on; stages
with disjoint files run together, and no review task is filed. The
drain loop at `.claude/skills/_tasks/drain.md` drains the run: a fresh agent per task, every
agent of one profile starting from one identical message, so the
project context is one cached prefix per profile. The build task
writes the code, applies the stage's deltas, stages its paths, and
records its calls, forks, and what it noticed as items in the run's
`divergences` pool. The session builds nothing, writes `tasks
render`'s output into the completion report before every dispatch,
and edits no file a running task owns. The build task files no issue
but one: a harm in a part the project does not own, which it files as
an upstream issue. It makes every determined call and records it, and records a
genuine fork with its options, building the reading it judges most
plausible. Code complete means every stage's build task closed
`done`.

**Sprint certification (`/converge sprint <path>`) closes, immediately
after.** Named as the
terminal step in the sprint's boilerplate, it judges the change from
the base commit to the working tree, once, against the sprint: every
outcome and taken improvement works, every story holds when a driver
uses the running product, every delta landed, every ruling holds, no unlisted
behavior change breaks a user, and the project's checks pass.
Fixers work through the merged defect list once; verifiers read only
each fixer's change, until none is sent back. A defect at its limit of
send-backs has its change backed out and goes to the intake as a
judgment issue. A drive failure in code the change did not reach, and
any other defect outside the sprint's scope, goes to the intake as a
`category: defect` issue for the next `/converge`, and a
question only the owner can decide goes to the intake for the next
`/plan-sprint`. The session writes the run's return block into the
completion report and presents it with its calls table: one row for
every judgment an agent made without the owner, in the build or in
the certification. The owner vetoes any row they disagree with, and
the session files each vetoed row as an issue for the next
`/plan-sprint`. The presentation ends with the offer to archive
the sprint (with its report, run file, base file, and build prompt)
and commit the work: owner acts, taken only on the owner's word, the
sprint left at its `sprints/` path until then. A goal keyed to the
sprint follows the contract's goal rule: `.ok-planner/bin/review
certified --sprint <path>` checks the contract against the repository
and prints `SPRINT COMPLETE`, and the executing session states that
stop condition in its first message, so a checker that reads only the
session can decide from it.
The close-out stamps the archived sprint with the closing commit
(`closed: <sha>` frontmatter, one follow-on commit) — the baseline
the next `/plan-sprint` reads to reconcile work done out of band.

`/plan-docs` produces a documentation sprint in `doc-sprints/`, on the
owner's schedule, as "The docspecs" above says. It runs under `/goal`,
writes documentation and doc comments alone, and closes with
`bin/docs complete`; its archive stamps each docspec it wrote.
