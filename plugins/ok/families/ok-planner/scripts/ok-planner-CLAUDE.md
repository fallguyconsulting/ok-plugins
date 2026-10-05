# .ok-planner — the planner's directory

Materialized by ok-planner v{{OK_PLANNER_VERSION}}. Suite-owned
boilerplate: the front door's administration (`/ok`) overwrites this
file wholesale. Do not hand-edit it; project guidance belongs in the
project's root CLAUDE.md.

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
  the benefit, stated concretely. The periodic audit verifies it.
- **`decisions/`** — technical decisions: choice, rationale,
  alternatives. The periodic audit verifies each Choice under
  `audits/decisions/`.

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
`/triage-issues` edit no corpus file: where the corpus needs a
change, they name it in an issue and leave it for a sprint. Read the
corpus freely; it is not a record.

**Leave the annotation.** Rollout is incremental and every session's
job: whenever you consult a concept, story, or decision to understand
or modify a file, leave `@concept:` / `@story:` / `@decision:` plus
the slug in a comment at the most-specific load-bearing site — the
function, branch, or block that enforces the commitment. Kind plus
slug only: no file path, no line number, no quotation. Leave an
existing annotation alone; repoint or remove one whose slug no longer
exists. Navigation is the annotations' one job: they play no part in
a review's scope, and nothing computes audit invalidation.

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
edit neither. Code cites the practice that governs it with a
`@practice:` annotation at the site. A member no practice covers is a
gap, the owner's question; a site that departs from its practice is a
defect, which `/converge` fixes or files as a `category: defect`
issue. **The TOCs are generated.** `subjects.md` and `practices.md`
list one line per artifact; `bin/catalog-toc` rewrites them, and
applying a subject or practice delta includes running it. A hand edit
is discarded by the next run. The periodic `/audit` reads coverage per
subject into `audits/subjects/`.

## The standards documents (`docs/`)

`docs/events.md` (the events standard) and `docs/technical-writing.md`
(the writing standard) are suite-owned and overwritten on every
converge. `.claude/rules/plumbline-cheatsheet.md` carries the ambient
copy of each; read the standard for the full text. The review loop's
`standards` setting pastes the events standard and the practices into
`/converge`'s prompts, so review fixes a breach of either as a defect.

## The configuration (`config.json`)

`config.json` is the owner's, written by hand or through an accepted
`/ok` offer, never overwritten. It turns each lint check on or off
(`lint_checks`; a check it does not name is on, and an off check's
rules leave the materialized rules text), declares the citation tags
the lint resolves (`citations`), the test paths (`tests`), the paths
the lint skips (`ignore`), the folders the project owns beside its
root (`folders`, which the lint, the review loop, the audit's sweep,
and the surface extractor all read), and the names `bin/port-block`
prints (`ports`). An absent file means the defaults.

## The lint and the hooks (`bin/`, `hooks/`)

`bin/plumbline` is the lint, a node script: `node
.ok-planner/bin/plumbline <path>` exits 0 clean, 2 with violations,
and 1 on an internal error. `hooks/post-edit.js` runs it over the file
each Edit or Write touches, where the owner consented to its wiring: a
violation blocks, so the agent fixes it in the same turn, and an
internal error shows its message and blocks nothing. `bin/run-tag`
mints a verification run's tag, and `bin/port-block` reads back the
ports its stack got; `.claude/rules/ok-planner-cheatsheet.md` carries
the rule. `bin/issues` is the issue intake's one reader and writer,
and `bin/dashboard` serves the intake's dashboard; the issue intake
section below describes both. `hooks/session-start` tells each session which ok-planner
version is materialized. Every file under `bin/` and `hooks/` is suite-owned and
overwritten on every converge.

## The public surface (`surface/`)

`surface/surface.md` is the **surface intent**: one prose document
naming which classes of element are public by default (the CLI verbs,
the HTTP routes, the published env vars) and which specific elements
depart — general rules with named exceptions. The audit's
**interactive intent stage** produces and maintains it: a short
class-level conversation with the owner ("every CLI verb is public"),
an à la carte run's one owner walk. The owner may edit the file
between audits. Once the intent lands, the run's autonomous portion
dispatches a **surface extractor subagent**: it reads the intent,
walks the code and deployment configuration purpose-bound to
classification, and writes the **surface extraction** to
`audits/surface/extraction.json` — one entry per element found, kind
discovered by the walk, each entry naming the intent rule that placed
it. Elements the intent does not settle are defaulted internal for
the run and filed as intake issues asking the owner to amend the
intent. No downstream owner walk beyond the interactive stage —
except the documentation walk below, when `/document` composed the
run — no reconciler tool, no committed member lists, no stamped
ruling. The extraction is committed with the audit corpus and stamped
with the closing commit.

`surface/documents/<slug>.md` are the **document types**: one
owner-authored file per document a release ships — what the document
is for, its audience (`public`: the user's vantage, naming only
public elements in the shipped vocabulary; `developer`: the
contributor's or operator's, free to name internal elements, scripts,
and paths), the classes of surface it covers (classes over
elements), and the target path in the tree (a file, or a folder when
the path ends in `/`). A type carries whatever else the owner writes
into it — an outline, prose to keep verbatim, a correction, something
to leave out, a **Method** naming how the writer produces the
document, which the ceremony runs as opus dispatches before the
writer and whose findings it hands over — and the writer honors all
of it. **All documentation is
typed**: every document the tree carries — the root `README.md`, any
`README.md`, everything under `docs/`, tutorials, guides — is one
type's product, revised at every release. The **documentation walk** settles the types:
a short owner conversation over the extraction's public side and the
tree's documents against the declared types that raises only the
deltas, lands what the owner approves, and files an intake issue for
a type left unsettled (left out for the run). The walk runs inside
the audit right after its extractor returns when `/document` invoked
the audit, and inside `/document` against a reused audit's extraction
otherwise; an à la carte `/audit` never runs it. No autonomous stage
writes a type; the owner edits the files freely between runs. Read a
type as owner intent, like the surface intent beside it.

## The audit corpus (`audits/`)

`audits/{concepts,stories,decisions,subjects}/` holds one file per
live artifact, written only by the periodic `/audit` run — never by the
implementing session, never hand-edited. `audits/assumptions/` holds
the run's **assumption records**, regenerated whole each run.
**Only a running `/audit` reads or writes `audits/` and
`experiments/`.** They record behavior at the time of the audit. No
other session — a sprint's execution, a `/converge` run, a hotfix —
reads them for direction or writes them. An experiment the work
breaks stays broken until the next run repairs or retires it. A
determination the work overtakes stays as written until the next run
rewrites it. An
audit answers two independent questions: `text:` (`compliant` |
`noncompliant`, with a `## Compliance` section naming the rule
broken) — does the body follow its authoring rules — and
`implementation:` (`supported` | `unsupported`) — does the codebase
support the claim at this commit. They come apart: a malformed
artifact may be accurately implemented. The body is one sentence to
one paragraph saying what was looked at and found.

**The support instrument differs by kind.** The run opens with the
interactive intent stage (above); a run invoked à la carte hands the
owner the `/goal` line naming `.claude/skills/audit/goal.md` once the
intent lands, and proceeds hands-free. Story support is measured from
the user's side: the maintained experiments (`experiments/`, one
directory per experiment with its `record.md`), re-run at this tree
through the public surface the extraction records — never settled by
reading. Each
experiment is self-contained: it uses only what an end user has — the
released product, its public surface, stock tooling — and shares no
helper code with the project or with another experiment. A project
keeps no shared code whose only use is its experiments.
Conclusions never carry: an archived experiment warrants nothing
until re-run at the stamp; the runnables carry as instruments,
re-run, repaired, extended, and retired each run. Once the story
verdicts land, one cold, boxed agent synthesizes the run's
**assumptions** — user-vantage priors formed from user-visible
material alone — and the run measures each on the same instrument,
closing every record with a disposition: `held`, `trap`, or
`unverified`. A contradicted assumption is documentation, never a fix
issue. Decision support is an adversarial reading against the code;
its claims live behind the surface. Concept support is the vocabulary
reading: one live name, and the citing sites and the code around them
agree with What it is and Boundaries.

**A coverage claim takes the coverage shape.** Where an artifact
claims a whole enumerable population, the frontmatter carries
`checked:` (the population enumerated from reality) and `unaccounted:`
(the members nothing accounts for), and `## Unaccounted` names each;
`unaccounted: 0` and `supported` agree. A member that departs from
the practice governing it is a defect, never an unaccounted member:
it goes to the judge, which files the confirmed violations as
`category: defect` issues, one per practice naming every breaking
site, for the next `/converge`.

**An audit is a statement about a named commit.** Its `commit:` field
names the tree it describes, so whether it still holds is a git
question. Nothing tracks staleness; no audit carries citations,
hashes, or line numbers. The next run navigates by the annotation
grep.

**Every universal carries its count and its population** — the number
checked and where the set came from, refutable by a reader in
seconds.

**Two stages, no loop.** Auditors, filed as tasks, take every live
artifact — stories and assumptions by measurement, decisions and
concepts by reading, subjects by coverage. Every escalation —
`unsupported` verdicts, practice violations, assumption
contradictions, corpus contradictions from the extraction, the
orchestrator's driving observations — goes to one terminal judge.
Only the `implementation:` axis escalates; a `text:` defect is
mechanical and recorded in the audit file. A confirmed gap files an
intake issue and `unsupported` stands; a confirmed practice
violation files a `category: defect` issue, unless an open one on
that practice already stands; a confirmed harm in a part the project
does not own files an upstream issue; a confirmed assumption
contradiction files nothing — the `trap` disposition stands. The audit
corpus and the intake are independent: no `issue:` field in either
direction; a back-reference lives in issue prose. The judge is terminal,
and the run fixes nothing — a real gap is a future sprint's work. The
experiments are the audit's instruments and remain in its collection.
The run writes its report to
`history/audits/<date>-<sha>-report.md` — a record, never a channel —
commits everything, stamps the commit, and presents from the report only
when invoked à la carte, silently under `/document`. **The run runs no
validator over its own corpus:** the orchestrator dispatches, collects,
writes the report, and stamps; completion is a fact about disk state,
not a tool's exit. A malformed audit is rewritten whole by the next run.

**Subjective promises become referrals, never verdicts.** Where an
artifact promises something whose quality only a human discipline can
judge, the audit records the promise, what exists in form, and the
owning discipline, and opines no further. A concrete story avoids
this: correct, clear, and helpful describe how well the product owes
something, not what it owes.

## The documentation corpus (`documentation/`) — a release snapshot

`documentation/` holds the corpus `/document` produces at a release,
constructed from the audit's records; the ceremony measures nothing.
The **publishable layer** has two tiers. The **records** — catalog
rows over the extraction's public side, assessments whose held claims
cite the audit's passing experiments, traps (reasonable user
assumptions the product contradicts, read from the trap
dispositions), and a concept router — speak the shipped vocabulary
and cite catalog rows at the stamp, never source paths or internal
entry points. The **documents** — one per declared document
type — live at their types' targets in the tree (`docs/...`, the root
`README.md`) and nowhere else: self-contained texts a writer brought
up to date at the release and verified against the tree at the stamp,
with no record citations, no warrant state, and a provenance stamp at
the top. A `docs/CLAUDE.md` carrying the record rule sits beside them
when any type targets `docs/`. Only declared targets are written. The
**verification layer** — trap evidence under
`documentation/evidence/`, with the extraction, the audit's records,
and the experiments where the audit keeps them — stays internal and
cites the tree freely. Every record and document is stamped with the
release commit it describes.

**A snapshot, never a source of truth.** The records and the documents
alike follow the record discipline: out of agent context by
default, never consulted to understand the current tree, never
reconciled or refreshed by day-to-day sessions, expected to go stale.
A document's provenance stamp is its only staleness marker; an
agent that finds one behind the tree files nothing and marks nothing,
and reads it only when the owner directs it there. Each `/document`
run overwrites the records whole and revises each document at its
target, keeping what the tree still supports; no conclusion
carries forward. The prior release's published corpus feeds the
audit's assumption synthesis, never a cache; the experiments carry as
instruments only. **The run runs no validator over its own corpus:**
a malformed corpus is rewritten whole by the next release's run.
Shipping the publishable layer is a separate publisher's act; the
verification layer never ships.

## The issue intake (`issues.jsonl`, `bin/issues`, `bin/dashboard`) — questions and defects

The intake is one JSON Lines file, `issues.jsonl`, with one record
per open issue. Closing an issue moves its record to the archive,
`history/issues.jsonl`, a record like the rest of `history/`.
`bin/issues` is the intake's one module: every filer, `/triage-issues`,
`/plan-sprint`, `/converge`, the front door's administration, and the
dashboard read and write both files through it. It checks every record
against the issue format the skills carry, skips a line that breaks
it, keeps that line in its file, and names it in a note on stderr. It
runs every write under one lock, `.cache/issues.lock`, replacing each
file whole. Never edit either file by hand; `bin/issues
--help` lists the verbs.

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
the product owes, and upstream issues), the periodic audit's judge
(confirmed gaps and undecidable artifacts, practice violations as
`category: defect` issues, one per practice, and upstream issues), a
sprint's build task (upstream issues alone), `/discover-design`'s
bootstrap, `/plan-sprint` transcribing a question you postponed, and
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
carrying a comment of yours that triage has not yet seen, ride
nothing: `/plan-sprint` walks each with you. Triage changes no code
and no design doc.

**The discussion.** Every record carries its discussion: your comments
and rulings, and the replies and updates `/triage-issues` writes in
answer. Comment on an issue to question or correct its analysis. The
next `/triage-issues` run answers each message of yours it has not yet
seen: it replies where the message asks something, revises the issue
where the message shows it wrong or thin, and marks the message seen
only after acting on it. It never rewrites your ruling. Each reply and
revision stays unread until you open the issue.

**The ruling is the owner's alone.** Rule with `bin/issues rule <id>
--text <your words>`, or on the dashboard, whenever you like; the next
`/plan-sprint` pulls every ruled issue in without re-discussing it. A
later ruling replaces the earlier one. Agents write only the marked
generated or recommended ruling, beside yours and never over it, or
transcribe a decision you give live.

**The dashboard (`bin/dashboard`, `dashboard/`).** `bin/dashboard`
serves a local page, on loopback only, for working the intake: the
issues that need a ruling, those with analysis you have not read,
those waiting on triage, the ruled, and the closed, each issue with
its discussion, and keys to rule and comment. It reads and writes
through `bin/issues`. The `/dashboard` skill starts it in the
background of a session, and it runs from a terminal as `python3
.ok-planner/bin/dashboard`. `dashboard/` holds the page's build: the
front door's administration places it at the version the estate is
stamped with, and an ignore file inside it keeps it out of git. It is
suite-owned and overwritten on every converge.

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
closed, a `repaired` status included. A project whose `issues/` still
holds markdown issue files, or whose `issues.jsonl` is the pre-v9
event log, converts it through the front door's administration
(`/ok`): on the owner's yes, its `markdown-intake` cleanup offer turns
each open file into a record and moves every file to
`history/issues/`, and its `legacy-intake` offer converts the log in
place. Until then `bin/issues` reads past them and names the offer
in a note on stderr. Never edit the log or the files.

## The review estate (`review/`, `bin/review`)

`review/` is the review loop's estate. `/converge` reads and writes
it, and `/triage-issues` reads its accept list. `review/CLAUDE.md`
describes each file: `catalog/` is suite-owned and overwritten on
every converge; `config.json` and `project.md` are seeded once and
are the owner's after; `rotation.json` records which analysis areas
were hunted when; `runs/` holds one ledger and folder per run,
records out of context by default. `bin/review` carries the loop's
mechanical verbs.

## Project records (`sprints/`, `sketches/`, `history/`) — out of context by default

The record discipline: records are committed, versioned parts of the
project, out of agent context by default, with one live exception —
the sprint currently being executed. Every completed or retired
record moves to its same-named folder in the archive.

`sprints/` holds sprints from `/plan-sprint`. `sketches/` holds
sketches from `/sketch` — speculative future thinking. `history/`
holds one archive folder per artifact kind (`sprints/`, `sketches/`,
and on migrated projects `issues/`, the markdown issue files of an
earlier layout, `specs/`, `plans/`, `coverage/`, `tensions/`), and
`issues.jsonl`, the closed issues' records that `bin/issues` writes,
preserved indefinitely.

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
which the tracker ignores from git itself; so does the issue intake's
lock, which `bin/issues` takes afresh for each write. Delete the directory
between runs, never during one: `tasks rebuild` recreates the index,
the next run rewrites its prompts, and a running claim reads its
prompt from there. Agents dispatched against the tracker are the vendored
profiles under `.claude/agents/` (`ok-opus`, `ok-haiku`,
`ok-audit`, the audit's forking profile, and `ok-review`, the forking
profile of sprint certification's review),
each pinning a model and an effort; the drain loop at
`.claude/skills/_tasks/drain.md` drains a run.
Never hand-edit a run file; the tracker's verbs are the only writers.

## Lifecycle summary

`/sketch` captures an unplanned idea in `sketches/` — single-pass,
speculative, no authorization to build. When the idea is taken up
through `/plan-sprint`, that session's terminal phase moves the
sketch to `history/sketches/`.

`/plan-sprint` produces a sprint in `sprints/`: final-form corpus
deltas, work items, implementation notes, and a fixed completion
contract, with the open issues that bear on the work resolved by the
owner in-session and promoted in, and the defect issues the owner
picked. A code planner writes the implementation notes: the code
changes, every existing behavior they alter with its ruling, and the
improvements the sprint takes, judged against the release boundaries
at `release-boundaries.md`. The approved sprint ends planning and is
from then on the source of truth for that work.

Sprint certification, `/converge sprint <path>`, closes an executed
sprint. On the owner's
cadence, `/converge` in `drive`, `analysis`, or `defects` mode finds
and fixes defects across the product, and `/triage-issues` verifies
the intake.

`/document` runs at a release: it ensures a current audit — reusing
one only when the tree has moved past its stamp on the audit's own
output paths alone, running `/audit` otherwise — settles the document
types in the documentation walk, constructs the commit-stamped corpus
in `documentation/` from the audit's records, then generates one
self-contained document per declared type and places it at the type's
target with a provenance stamp. It measures nothing and files only
for a type left unsettled in the walk.

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
`-completion`), rendered from the run, recording work done,
divergences, and every fork claimed with its options and the reading
built. Follow that section; nothing here overrides it.
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
outcome and taken improvement works, every story the sprint adds or
amends holds when a driver uses the running product, every delta
landed, every ruling holds, no unlisted behavior change breaks a user,
and the project's checks pass. Fixers work through the merged defect
list once; verifiers read only each fixer's change, until none is sent
back. A defect at its limit of send-backs has its change backed out
and goes to the intake as a judgment issue. A defect outside the
sprint's scope goes to the intake as a `category: defect` issue, and a
question only the owner can decide goes to the intake for the next
`/plan-sprint`. The session writes the run's return block into the
completion report and presents it, ending with the offer to archive
the sprint (with its report, run file, base file, and build prompt)
and commit the work: owner acts, taken only on the owner's word, the
sprint left at its `sprints/` path until then. A goal keyed to the
sprint follows the contract's goal rule.
The close-out stamps the archived sprint with the closing commit
(`closed: <sha>` frontmatter, one follow-on commit) — the baseline
the next `/plan-sprint` reads to reconcile work done out of band.
Sprint certification never audits: whether the corpus's claims still
hold is `/audit`'s question, on the owner's cadence, never at a close.
