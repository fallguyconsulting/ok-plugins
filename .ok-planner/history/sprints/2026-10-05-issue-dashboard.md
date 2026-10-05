---
closed: 170c2875c00b7d8a0517be45b5e21c1be858e347
---

# Sprint: The issue dashboard

## Intent

The owner works the intake today by opening one markdown file per
issue and typing a ruling under `## Ruling`. Nothing shows the whole
intake at once, and nothing lets the owner ask about an issue and get
an answer on that issue. This sprint ships a standard dashboard with
ok-planner whose first view is an issue tracker, and moves the intake
to the structured store the tracker needs.

The sprint carries the owner's answers from planning:

- One store. Every writer files, rules, and closes an issue through
  one module, and the markdown intake retires.
- Closing an issue moves its record to a history file. The live store
  holds open issues only.
- Silence still accepts a generated or recommended ruling, as
  `decision:audit-audience-split` already says. An owner comment that
  triage has not yet marked seen holds the recommendation back.
- `/release` builds the page, and converge places a git-ignored copy
  in the estate, pinned to the estate's suite version.
- The page uses Svelte 5 and the current Vite.
- A vendored `/dashboard` skill starts the service.

The sprint takes up `sketch:2026-10-04-project-dashboard`. It promotes
no issue.

## Corpus deltas

### Amend concept: issue

```markdown
---
concept: issue
---

# Issue

## What it is

An issue is one entry in the intake, and it is one of two kinds. A
judgment issue is anything that requires human judgment to resolve,
such as sloppy, unspecified, unclear, overloaded, conflicting, or vestigial
design, a question about the project's own tooling, or a question
deferred during planning. A defect issue is a defect waiting for a run,
not a question: the rules already decide its fix (see also: defect).
An issue carries its discussion: the owner's comments and rulings, and
the replies and revisions written in answer.

## Purpose

The issue separates judgment from work: a judgment issue asks for the
owner's judgment, and a defect issue asks only for a worker. The intake turns
scattered design muddiness into one owner-facing agenda, and it holds
each defect found outside a run's scope until a later run fixes it.
The discussion lets the owner question or correct an issue's analysis
on the issue itself, so the answer reaches every later reader.

## Boundaries

An issue waits: the intake is a holding area, not a work tracker, and
nothing is worked to completion in it (see also: task-tracker,
sprint, accept-list, defect;
defects-outside-scope-become-defect-issues,
foreign-harms-become-upstream-issues, audit-audience-split under
decisions; plan-a-sprint under stories). A ruling proposed on the
owner's behalf is distinct from the owner's ruling until the owner
accepts it; a comment in the discussion is not a ruling (see also: audit-audience-split,
triage-answers-owner-messages under decisions; rule-on-the-whole-intake,
discuss-an-issue, see-new-analysis under stories).
```

### Amend decision: audit-audience-split

```markdown
---
decision: audit-audience-split
---

# The audit records what it saw; the intake is reached only through gated writers

## Choice

The audit writes its own records — the per-artifact determinations
of the two axes it checks, into the corpus collection that holds them,
and the surface extraction, into its own machinery record — and reaches
the intake only through its judge, its surface extractor, and, in a
composed run, its documentation walk, below. It
writes no code and no design artifact, and it fixes
nothing. Its opening surface walk is owner conversation, not filing:
what the owner settles there lands in the surface intent as the
owner's own text, never in the intake. The documentation walk a
`/document`-composed run adds after extraction lands what the owner
settles in the document types, and files one intake issue for each
document type the owner leaves unsettled; that type is left out for
the run. What the run saw reaches
the owner through the run report it writes at its close — a record
beside its other outputs; an à la carte run's wrap-up is composed from
that report, and a run a ceremony invoked ends silently at its stamp.
The experiments stay the audit's instruments: the run never proposes
adopting one into the project.

An agent reaches the intake through these gated paths and no others:

- `/converge`'s owner list, the one writer of what a run leaves: each
  real defect outside the run's scope as a `category: defect` issue
  for the next run; each defect stuck at its limit of send-backs, its
  change backed out of the tree, as a judgment issue; each defect whose fix would edit the design
  corpus, the coding standards, or an owner's declaration, as a
  judgment issue; each harm in a part the project does not own, as
  an upstream issue; and each
  question about what the product owes or how the project's own
  tooling works, as a judgment issue.
- `/triage-issues`, which opens no new question: it rewrites each
  untriaged issue for its next reader, closes what the code, the
  corpus, or the tooling already answers, leaves an upstream issue
  open for the planning session while the project still shows its
  harm, retires a defect claim no
  accept-list entry covers and that proposes no entry, and writes under the ruling only a marked ruling: generated, recommended, or a
  retirement reason. It answers the owner's messages on an issue,
  replying and revising the issue where a message shows it wrong or
  thin, and never rewrites the owner's ruling (see also:
  triage-answers-owner-messages).
- The audit's second-opinion judge, filing only what an independent
  read confirmed as a real gap or found undecidable from the
  artifact's own text — a story's measured surface contradiction among
  them, a corpus contradiction the extraction turned up, and the run's
  own driving observations, which reach the intake through the judge's
  confirmation and no other way — and filing the practice violations it
  confirms as defect issues, one per practice, per
  decision:practice-violations-are-defects, and filing each harm in a
  part the project does not own as an upstream issue (see also:
  foreign-harms-become-upstream-issues).
- A sprint's build task, filing only an upstream issue for a harm in
  a part the project does not own (see also:
  foreign-harms-become-upstream-issues).
- The surface extractor, filing one issue for each element the
  surface intent does not settle, which the run defaults to internal.
- The documentation walk, at either of its call sites (see
  decision:documentation-walk-in-composed-audit), filing one issue for
  each document type the owner leaves unsettled, which the run leaves
  out.

Every judgment issue is made ruling-ready before it becomes owner
agenda. Unmarked ruling text is the owner's alone, and a marked
generated or recommended ruling becomes the owner's when the owner
leaves it standing until a planning session carries it. An owner
comment that triage has not yet marked seen holds the marked ruling
back from that session, which walks the issue with the owner instead.
Those gates govern the repeating cycle's filings, not the
intake's whole membership — humans file directly whenever they choose,
the owner rules and comments on an issue directly,
the front door's administration converts an earlier intake into the
current one on the owner's consent, the ceremonies that transcribe the
owner's own questions file directly, and so does the one-time corpus
bootstrap, whose review loops file
their questions ungated by design: the queue is what the owner invoked
that run to get, and a run that aborts rather than repeat over a
populated corpus cannot accumulate against the owner. The owner's
durable agenda is a property of those gates, never of how much the
audit records. Deduplication against the slugs already present is the
standing discipline of every writer into the intake, the gates
included.

## Rationale

The split keeps work moving and the owner uninterrupted: an agent that
fixes defects needs them now, in context, at machine tempo, while the
owner's queue must stay an owner-calibrated worklist. What bounds the
queue is which paths may write to it, not whether the audit keeps a
record of what it saw — an audit that records determinations in its
own collections costs the owner nothing to ignore, while an audit that
filed every observation as a question would be an ungated writer
inside a repeating cycle, growing the queue run after run without
anything checking that a reasonable owner would want to read it. Each
gate bounds that growth its own way. The owner list writes only what a
run could not fix, had no scope to fix, or could not decide, and a defect issue asks no
judgment: it waits for the next run, not for the owner. Triage applies
the accept list, the corpus, and the tooling, and closes or retires
what they settle. The judge confirms by an independent second read that
overturns as readily as it confirms. The corpus bootstrap files ungated without
defeating that, because it sits outside the repeating cycle — one
owner-invoked adoption run that refuses to run again over a populated
corpus, and the queue of judgment questions it hands back is the
outcome the owner invoked it for rather than a cost imposed on them. A
standalone audit's other observations still reach the owner: the human
who ran it is holding the report, and reading it is the calibration
act — what they judge fork-worthy, they file.

## Alternatives

- The audit writing the intake directly — the intake stops meaning
  "requires owner calibration" by construction, growing run after
  run inside the repeating cycle.
- The audit writing nothing at all, reporting only in context —
  keeps every write gated, and leaves no durable record of either
  axis for the next reader to compare against.
- The audit filing its own judgment class — preserves a durable
  agenda from standalone runs, but reintroduces ungated agent writes
  and duplicates the gates' dedup and confirmation outside them.
- A capped fix loop that stops and waits for the owner's word before
  filing what it could not fix — bounds the loop, and holds a run or a
  sprint open on the owner's attention instead of ending at a state
  they can read.
- The measurement runs nominating passing built experiments into the
  intake as candidates for adoption — another writer, and it blurs
  the audit's instruments with the project's code.
- The orchestrator filing its own driving observations directly —
  an ungated writer inside the repeating
  cycle, pre-empting the owner's intake under the appearance of
  bookkeeping; routing them through the judge keeps the observation
  and the gate both.
```

### Amend decision: steering-over-prose-lint

```markdown
---
decision: steering-over-prose-lint
---

# Prose is steered at write time, never linted

## Choice

The writing standard is enforced by steering, through two channels.
ok-planner's rules files carry the standard's portable dispatch rule
ambiently, pointing at the full standard materialized in the estate,
so the standard is in context for every write. The personal conduct
carries the same rule as session-wide governance, in its output style
and in the rules it restates with every prompt, binding everything a
session writes and says — replies, reports, issues, commit
messages, authored skill prose — where no rules file is in context.
No hook detects prose and no hook reviews it: ok-planner's lint edit
hook lints comments, citations, and tests after an edit and does
nothing else.
No prose lint exists: the lint's charter stays comments, citations,
and tests.

## Rationale

Most of the standard is not mechanically decidable. A checker cannot
see elegant variation, a broken metaphor, or a decorative example; it
can only match phrases, and a phrase list catches too little while
flagging legitimate prose. Steering acts where the failure happens:
at generation. The ambient channels shape what the agent is about to
write, and the conduct channel covers the session's own voice, since
spoken replies and reports go through no file write and the conduct
is the one layer present in every session the owner works in, project
or not. The conduct restates its rules with every prompt because a
rule stated once at session start loses weight as the session grows.

## Alternatives

- A prose lint in the lint binary — the decidable subset (a
  banned-phrase list, sentence-length caps) is a poor proxy for the
  standard, and false positives would teach agents to ignore the lint.
  Rejected as too rigid, and it would widen the lint's charter from
  comments, citations, and tests to prose.
- Rules files only — reaches every agent, but relies on ambient
  salience alone with nothing at the moment of writing.
- The dispatch rule pasted into every skill prompt — depends on every
  skill author remembering it; the standard would erode one forgotten
  prompt at a time.
- Rules files and the lint hook, no conduct channel — files are
  steered but the session's own replies and reports are governed by
  nothing, and the standard stops at the terminal.
- Injecting the standard at the moment of each write through a
  PreToolUse hook — the freshest instruction the model holds at the
  write, but it shapes prose before it exists and leaves a long turn's
  drift unread.
- A PostToolUse prose detector with a Stop hook review — one review
  per turn of every file the turn wrote, at the price of a visible
  extra turn after every turn that wrote prose, each continuation
  re-reading the whole context, for rewrites no better than the draft.
- Reviewing after every write — one review per edit, re-reading a
  file edited many times in one turn.
```

### New story: rule-on-the-whole-intake

```markdown
---
story: rule-on-the-whole-intake
---

# Rule on the whole intake

## Story

As a project owner, I want a way to rule on every open judgment issue
in one sitting, so that my next planning session starts with no
question left unanswered.
```

### New story: discuss-an-issue

```markdown
---
story: discuss-an-issue
---

# Discuss an issue before ruling

## Story

As a project owner, I want a way to question an issue's analysis and
get an answer on that issue, so that I can rule on an issue whose
first analysis left me unsure.
```

### New story: see-new-analysis

```markdown
---
story: see-new-analysis
---

# See new analysis since I last looked

## Story

As a project owner, I want a way to see which issues have new answers
or revisions since I last read them, so that I respond to each change
without rereading the intake.
```

### New decision: issue-records-in-one-file

```markdown
---
decision: issue-records-in-one-file
---

# The intake is one JSON Lines file, one record per issue

## Choice

The intake is one JSON Lines file with one mutable record per open
issue. A record holds the issue's fields, the owner's ruling apart
from any marked generated or recommended ruling, and its whole discussion, and a writer
changes an issue by rewriting its line.

## Rationale

Structured fields let a page list, filter, and thread issues without
parsing prose, and they keep the owner's ruling and triage's
marked ruling apart. One
line per issue keeps a change to one issue a change to one line in
version control. A long discussion makes that line long, and the diff
shows the whole line.

## Alternatives

- One markdown file per issue — readable and hand-editable, but a threaded discussion has no structure and every reader parses prose.
- An append-only event log — every reader replays the log to learn an issue's current state.
- An embedded database — a binary file version control cannot diff or merge.
```

### New decision: closed-issues-leave-the-live-file

```markdown
---
decision: closed-issues-leave-the-live-file
---

# A closed issue's record moves to an archive file

## Choice

When an issue closes, its writer moves the record from the live
intake file to an archive file of the same form among the estate's
records. The live file holds open issues only.

## Rationale

The live file stays as small as the open intake, so every reader that
needs open issues reads only those. Moving closed records out keeps
the rule that archived records stay out of context by default (see
also: records-stay-out-of-context). A reader that wants the veto
list or the closed history reads the archive file.

## Alternatives

- Keep closed records in the live file, marked closed — one file to read, but it grows without bound and every reader skips closed lines.
```

### New decision: issue-writes-through-one-module

```markdown
---
decision: issue-writes-through-one-module
---

# Every intake write goes through one locking module

## Choice

Every reader and writer of the intake goes through one module: the
filers, humans included, triage, the planner, the defect runs, the
front door's migration, and the dashboard's service. The module serializes every write under an exclusive lock
and applies each change to the file as reread under that lock, and it
refuses a record that breaks the schema, naming its line. Nobody
edits the intake by hand.

## Rationale

Triage agents run in parallel, and the service writes while a run
works. A writer that skips the lock, or writes from a copy it read
before taking it, erases another writer's change. One module that
validates every record keeps every reader and writer on one schema.

## Alternatives

- Agents edit the file by hand — lost writes under concurrency, and the schema drifts writer by writer.
- A long-running service owns the file and every writer calls it — every run would need the service running.
```

### New decision: triage-answers-owner-messages

```markdown
---
decision: triage-answers-owner-messages
---

# Triage answers the owner's messages in its next run

## Choice

An owner's comment or ruling on an issue waits for the next
`/triage-issues` run. That run reads each message it has not seen,
replies where the message asks something, revises the issue where the
message shows it wrong or thin, and marks the message seen only after
acting on it. It may revise a ruled issue's analysis; the issue stays
ruled, and the revision reaches the owner as new analysis. It never
rewrites the owner's ruling.

## Rationale

Triage already reads the code and the corpus an issue cites, so it
is the reader able to answer. Answering in a batch run keeps model
calls out of the dashboard's service and keeps every analysis of an
issue in one verb. Marking a message seen only after acting leaves it
for the next run when a run dies midway.

## Alternatives

- The service calls a model live — the service needs credentials and an agent loop of its own.
- The owner asks in a session — the answer never reaches the issue, and the next reader misses it.
```

### New decision: local-web-surface

```markdown
---
decision: local-web-surface
---

# The dashboard is a local web application

## Choice

The dashboard is a local web application: a page served over loopback
by a program the project runs on demand, on a loopback port the
operating system assigns unless the owner names one. It reads and
writes the intake through the intake's one module.

## Rationale

Working the intake needs the whole list in view, a thread per issue,
and keys to move through the queue and rule without leaving it. A
terminal report prints one issue per invocation and loses the reader's
place. An editor extension binds the surface to one editor's plugin
model. A local page carries the list and the thread together and runs
only while the owner runs it.

## Alternatives

- A terminal report per issue — composes with the suite's verbs, but flattens the queue into one dump per invocation.
- An editor extension — a strong reading surface, at the cost of an implementation per editor.
- A static site generated per project — no service to run, but it cannot accept a ruling or a comment.
```

### New decision: pinned-build-placed-at-converge

```markdown
---
decision: pinned-build-placed-at-converge
---

# The dashboard's build is placed to match the project's pinned version, never committed

## Choice

The dashboard's frontend is built once per suite release and carried
as family payload. A project receives the build matching the suite
version its vendored layer is stamped with: the family's converge
places it, in the same administration pass that writes the vendored
layer's stamps, inside the planner's estate and ignored by git rather than
committed. The build a project serves is the one its last convergence
placed, never one retrieved when the owner opens the page.

## Rationale

Per-project pinning decides this. The intake record's schema moves
between releases, so a page built for a newer schema misreads an
older project's intake. Committing the build into each consumer estate
would pin it correctly but adds a churning generated artifact to
repositories that gain nothing from its bytes. Serving the front
door's carried build unpinned keeps those repositories clean but
misreads exactly the projects that have not converged. Placing the
pinned build at converge keeps both properties, and keeps the act
where the suite's other pinning already happens (see also:
per-project-pinning).

## Alternatives

- Commit the built bundle into each consumer estate — correctly pinned, but a generated artifact rewritten in every repository on every converge.
- Serve the front door's carried build unpinned — nothing lands in consumer repositories, but a project behind the current release gets a page that misreads its intake.
```

### New decision: svelte-dashboard-frontend

```markdown
---
decision: svelte-dashboard-frontend
---

# The dashboard's frontend is Svelte 5, built with Vite

## Choice

The dashboard's frontend is written in Svelte 5 and built with Vite
into static files the service serves.

## Rationale

The page is small: a header, a list, a thread, and a few keyed
actions. Svelte compiles it to a small static bundle with no runtime
framework to ship, and Svelte 5 is the supported major line, so no
later release has to migrate the page.

## Alternatives

- Svelte 4 — the previous major line, which a later release would have to migrate.
- React — a larger runtime for a page this size.
- Server-rendered pages with no build — no Node at release time, but every action costs a page round trip, and keyed queue work needs script anyway.
```

### New decision: dashboard-started-by-skill

```markdown
---
decision: dashboard-started-by-skill
---

# A vendored skill starts the dashboard

## Choice

A vendored `/dashboard` skill starts the dashboard's service in the
background of the owner's session and reports the page's address. The
service also runs directly from a terminal.

## Rationale

The owner plans and triages from a session, so a verb there keeps the
dashboard one command away. The skill is a thin verb over the same
program, so the program stays usable without a session.

## Alternatives

- Only a terminal command — no new verb, but the owner leaves the session to start the page.
```

## Work items

1. **The intake module.** A stdlib-only Python program and module,
   `bin/issues` in the estate, carried in the family payload beside
   `tasks` and `review`, owns the intake file
   `.ok-planner/issues.jsonl` and its archive
   `.ok-planner/history/issues.jsonl`. It defines the record (the
   sketch's shape: `id`, `title`, `kind`, `category`, `artifacts`,
   `route`, `state`, `problem`, `options`, `recommendation`
   `{form, text}`, `ruling` `{text, at}`, `messages`, `opened`,
   `updated`, plus the fields the closing writers need: `sprint`,
   `fixed_by`, `closed_as`, and the upstream draft). It validates every
   record on read and names the line it refuses. Every write takes the
   lock, rereads, changes, writes a temporary file, and renames it. Its
   verbs cover every writer: file an issue, triage-route and rewrite an
   issue, respond to owner messages (replies, an update, seen marks, in
   one write), rule, comment, mark triage messages read, and close an
   issue (moving its record to the archive). An owner message on a
   closed issue and an empty text are refused with a message the
   caller shows. Makes true `decision:issue-records-in-one-file`,
   `decision:closed-issues-leave-the-live-file`,
   `decision:issue-writes-through-one-module`.

2. **Every filer and closer writes through the module.** `/converge`'s
   owner list (file a defect issue, close as fixed or answered, turn a
   stuck defect into a judgment issue), the audit's judge,
   `/discover-design`, and `/plan-sprint` (file a postponed question,
   retire, record a filing upstream, stamp promotions at Terminal) all
   call the module instead of writing markdown files. Every reader of
   the intake reads through it: `/plan-sprint`'s Frame and Resolve
   (ruled means a `ruling`; a `recommendation` rides by silence per
   `decision:audit-audience-split`),
   `/converge`'s backlog verb in `review`, `surface-corpus`, and the
   sprint archive step in the sprint boilerplate. A human files with
   the module's file verb. Depends on 1.

3. **`/triage-issues` works the store and answers the owner.** The
   scope becomes every record with no route plus every record with an
   owner message not yet seen. Triage agents route and rewrite records
   through the module. A new phase answers owner messages: one author
   task per batch reads the issue, its whole discussion, and what it
   cites, and in one module call writes its replies, any revised
   fields with an update message naming them, and the seen marks on
   every owner message it acted on. It never rewrites `ruling`. Makes
   true `decision:triage-answers-owner-messages`, and the
   triage's half of `story:discuss-an-issue` and
   `story:see-new-analysis`. Depends on 1.

4. **The intake's rules and documents describe the store.** The issue
   definition and format in the family's shared artifact definitions,
   the planner cheatsheet's Defect issues section, the estate's
   `CLAUDE.md` template, the family `CLAUDE.md`, the compliance
   reviewer, the implementation auditor, the sprint boilerplate, the
   `/converge` prompts, the coding rules, the practice definitions,
   the review estate's `CLAUDE.md`, and ok-conduct's rule on
   `.ok-planner/` describe the JSON Lines intake, its archive, the
   discussion, and the module, and no longer describe markdown issue
   files as the live intake. Records already under
   `.ok-planner/history/issues/` stay as they are and read as closed.

5. **`/ok` migrates a project's intake.** The converge core offers,
   as a cleanup offer on the owner's consent, to convert every open or
   verified markdown file under `.ok-planner/issues/` into a record in
   the store and move the file to `.ok-planner/history/issues/`, the
   owner's `## Ruling` text becoming the record's `ruling` and a marked
   generated or recommended ruling its `recommendation`. The
   `legacy-intake` offer no longer deletes `.ok-planner/issues.jsonl`:
   it recognizes the pre-v9 event log by its lines and converts it to
   records, and it leaves a record store alone. The administration
   document carries the judgment either offer needs. Depends on 1.

6. **The dashboard's service.** A stdlib-only Python program,
   `bin/dashboard` in the estate, restored in shape from the removed
   corpus view (`52425a8^:.ok-planner/bin/corpus-view`: the server
   loop, static serving, root resolution, and the estate-version
   check) with every citation resolver dropped. It serves the placed
   build and answers JSON on loopback only, through the intake module:
   list issues (filter by state, waiting on triage, unread, category),
   get one record, list closed records from the archive, rule,
   comment, and mark read. A GET changes nothing. Its port is one the
   OS assigns unless `--port` names one, and it prints the page's
   address. Makes true `decision:local-web-surface`. Depends on 1.

7. **The tracker page.** A Svelte 5 app built with Vite, under
   `browser/` in the family payload, restoring the removed browser's
   shell (`52425a8^:plugins/ok/families/ok-planner/browser/`: header,
   nav, route helper, API helper, list view, version-pin banner)
   rewritten in Svelte 5. Tabs list issues needing a ruling, issues
   with unread triage messages, issues waiting on triage, ruled
   issues, and closed issues, with a category filter. An issue shows
   its problem, options, recommendation, the owner's ruling, and its
   thread: each owner message seen or not yet seen, each triage
   message new until read. Keys `j`/`k` move through the list; `a`
   accepts the recommendation as the ruling, `r` writes a ruling, `c`
   writes a comment. Opening an issue marks its triage messages read.
   Makes true `decision:svelte-dashboard-frontend`,
   `story:rule-on-the-whole-intake`, `story:discuss-an-issue`, and
   `story:see-new-analysis`. Depends on 6.

8. **The build ships pinned.** `/release` (this repo's
   `.claude/skills/release/SKILL.md`) builds the page and commits the
   built bundle into the family payload before the release commit.
   The converge core places the bundle inside the planner's estate
   with a suite-owned ignore file covering it, and diagnose reports a
   missing or stale placement as drift. No placed path collides with
   an entry in the converge core's retired-estate list. Makes true
   `decision:pinned-build-placed-at-converge`. Depends on 7.

9. **The `/dashboard` skill.** A vendored skill starts the service in
   the background, reports the page's address, and stops it when the
   owner asks. The suite's skill listings name it. Makes true
   `decision:dashboard-started-by-skill`. Depends on 6.

## Implementation notes

Planned against commit `3617c7b0bb532abf98ed6f6a7c05740b32a3c820`.

`F/` below is `plugins/ok/families/ok-planner/`. The vendored copies
under `.claude/` and `.ok-planner/bin/` change only through `/ok`, so
no work item edits them; this repo's own `.claude/skills/release/SKILL.md`
is project-owned and work item 8 edits it.

Facts that bind several work items:

- `checks/materialized-standalone` lints every payload script and
  markdown payload as a consumer sees it, so no `@story:`/`@decision:`
  annotation stands in `F/scripts/*` or `F/skills/**`. Annotations go
  only where nothing is materialized: `F/admin/converge`, `checks/`,
  and `F/browser/src/**/*.js`.
- `checks/owned-paths` allows only the write sites it declares inside
  `F/admin/converge`; every new write in the core gets a matching entry.
- The converge core's `RETIRED_ESTATE` sweeps `browser`, `run`,
  `.gitignore`, `bin/corpus-view`, and `bin/browse` under the estate.
  The build is placed at `.ok-planner/dashboard/` with its own
  `.ok-planner/dashboard/.gitignore`, which collides with none of them.

### 1. The intake module

**Calls**
- Live store `.ok-planner/issues.jsonl`, archive
  `.ok-planner/history/issues.jsonl`; a missing file reads as empty.
  Lock `.ok-planner/.cache/issues.lock`, through the cache folder and
  ignore file the tracker already writes, opened and flocked once per
  write, never held open across writes, since `.cache/` may be deleted
  while the dashboard runs. The module imports
  `project_root` and `cache_dir` from its sibling `tasks` by path.
  Decided by: plumbline-coding rule 6; `tasks` owns `.cache/`.
- Every write takes the flock, rereads both files, changes them, writes
  each through a temp file beside it and `os.replace`, and removes the
  temp file in `finally`. Decided by:
  decision:issue-writes-through-one-module; sibling
  `F/admin/converge::write_owner`.
- Close writes the archive before the live file, keying archived
  records by `(id, opened)`; every locked write first drops a live
  record whose `(id, opened)` is already archived, completing a close a
  crash interrupted. Decided by: accept-list A1;
  decision:closed-issues-leave-the-live-file.
- Record schema, checked on every read; a bad line stops the command
  with `<file>:<line>: <field>: <defect>` (exit 2): `id` (slug, unique
  live; `file` refuses a live id), `title`, `kind`
  (`audit|discover|sprint|human`), `category` (the existing list),
  `artifacts` (`kind:slug` strings), `route` (null or
  `answered|upstream|retired|defect|corpus|question`), `problem`,
  `options` (`{label, text}`, labels A, B, … assigned where omitted),
  `recommendation` (`{form: generated|recommended, text}` or null),
  `ruling` (`{text, at}` or null), `messages` (the sketch's `n`, `by`,
  `at`, `type`, `text`, `seen`, `read`, `replies_to`, `changed`),
  `upstream` (draft text or null), `opened`/`updated` (ISO 8601 UTC with
  `Z`); optional `sprint`, `source`; archive-only `closed`, `closed_as`
  (`answered|retired|promoted|fixed`), `reason` (required for answered
  and retired), `fixed_by` (required for fixed). Decided by: work item
  1, the sketch, the old frontmatter fields.
- `state` is computed, never stored by a writer: no route and no ruling
  → `open`; route `defect` → `verified`; any other route with no ruling
  → `needs-ruling`; a ruling → `ruled`; archived → `closed`. Decided
  by: the cheatsheet's Defect issues routing; the sketch's state list.
- Verbs. Agent verbs take one JSON object on `--from <path|->`: `file`,
  `revise`, `respond`, `close`, `import`. Owner verbs take flags:
  `rule --text`, `comment --text`, `read`. `promote <id> --sprint
  <file>` requires the sprint file under `sprints/` or
  `history/sprints/`. Readers: `list` (`--state`, `--category`,
  `--artifact`, `--sprint`, `--waiting`, `--unread`, `--json`), `show
  <id> [--json]`, `history [--json]`. Decided by: work items 1 and 2;
  the sketch's `respond <id> --file <json>`.
- `revise` sets any of `title, category, artifacts, route, problem,
  options, recommendation, upstream`, accepts `route: null` (the owner
  list's stuck-defect turn), and refuses `ruling`, `messages`, `id`,
  `opened`, and the closing routes `answered`/`retired` (those go
  through `close`). Decided by: decision:triage-answers-owner-messages.
- `respond` applies `{replies:[{replies_to:[n…], text}], update:{<fields>…,
  text}, seen:[n…]}` in one write, writes the `update` message with
  `changed` from the field keys, refuses a `seen` or `replies_to` entry
  naming no owner message and any `ruling`, and starts every triage
  message at `read: null`. Decided by: work items 1 and 3.
- `rule` and `comment` are refused on a closed record, on a record with
  `sprint` set, and on text empty after trimming, each with a message
  the caller shows (exit 2). Decided by: work item 1; a promoted issue
  is never reopened.
- `close` requires `reason` for answered and retired, `sprint` for
  promoted, `fixed_by` for fixed; triage never closes a record that has
  a `ruling`. Decided by: the old triage scope rule.
- `import` checks every record, sends open records to the live file and
  closed ones to the archive under one lock, skips a record already
  present byte for byte, refuses a differing record with a live id, and
  with `--over-event-log` replaces a store whose every line carries
  `event`. Decided by: work item 5; A1.
- Every verb but `import` refuses while the store holds pre-v9 event
  lines or `.ok-planner/issues/` holds a `*.md` directly under it,
  naming `/ok` and its offer (`legacy-intake` or `markdown-intake`).
  Decided by: A7; plan-sprint's existing legacy-intake stop.
- CLI shape copied from `F/scripts/tasks`: argparse subcommands,
  `fail(msg, 2)`, Python 3.10 floor, stdlib only. Decided by:
  plumbline-coding rule 2.

**Changes**
- `F/scripts/issues`: new. The store module and CLI above, with the
  stamp header and `VERSION = "{{OK_PLANNER_VERSION}}"` as `tasks` has.
- `F/admin/converge::EXECUTABLE_FILES`: changed. Adds `("scripts/issues",
  ".ok-planner/bin/issues", None, ("--help",))`, the row carrying
  `@decision:` lines for issue-records-in-one-file,
  closed-issues-leave-the-live-file, issue-writes-through-one-module.
- `checks/materialized-standalone::PAYLOADS`: changed. Adds
  `("ok-planner/scripts/issues", ".py")`.

**Behavior changes**
None. Every change is new code no existing user reaches.

### 2. Every filer and closer writes through the module

**Calls**
- Every filer writes through `issues file`, including the audit's
  surface extractor and the documentation walk (audit-composed and
  `/document`'s own). Each dedups first with `issues list`
  (`--artifact practice:<slug> --category defect` for practice
  violations). Decided by: "every filer"; decision:audit-audience-split.
- Plan-sprint: retire is `close --as retired --reason`; a filing
  upstream is `rule` (the owner's live words) then `close --as answered
  --reason <where filed>`; a walk promotion is `rule` with the verbatim
  text; Terminal is `promote --sprint`; the archive step is `close --as
  promoted` for each `issues list --sprint <file>`. Ruled means
  `ruling` is set; `recommendation` rides by silence except on an
  upstream issue and on a record with an owner comment at `seen: null`,
  which Frame treats as unruled and walks at Resolve. `rule` on a ruled record replaces
  the ruling. Decided by: work item 2; decision:audit-audience-split;
  the owner's ruling at planning.
- Converge report and defect items carry `issue=<record id>`; the owner
  list's `--files` becomes `.ok-planner/issues.jsonl
  .ok-planner/history/issues.jsonl`; closes are `close --as fixed
  --fixed-by <run>` and `close --as answered --reason`; a stuck or
  left-alone defect is turned with `revise` (new category, `route:
  null`, `recommendation: null`, `problem` plus the `Stuck in`/`Left
  alone in` section). Decided by: work item 2; the owner-list text.
- `surface-corpus` takes a record id as argv[1] and imports
  `.ok-planner/bin/issues` by path; its stdin legacy-row mode goes,
  since nothing uses it. Decided by: decision:issue-writes-through-one-module.
- Skill text that names intake paths (the audit's staleness output,
  the `mkdir` lines) names `.ok-planner/issues.jsonl` and drops
  `.ok-planner/issues`. Decided by: the store's paths.
- `review owner` classes `.ok-planner/dashboard/` as `suite`. Decided
  by: decision:pinned-build-placed-at-converge.
- Build note: `F/skills/audit/SKILL.md` names filings "by path" in
  Phase 8, the Report shape, and the line naming `.ok-planner/issues/`,
  and `F/skills/document/SKILL.md` does the same; reword each to ids,
  and check `audit/goal.md` and `document/goal.md` for the same
  wording. The audit's close-out commit list names
  `.ok-planner/history/issues.jsonl` beside `issues.jsonl`.
- Build note: the converge SKILL backlog step builds a settled issue's
  report from `site=<its first file>`; give it a rule for I1's
  `settled` entry with `files: []`.

**Changes**
- `F/scripts/review::cmd_backlog`: changed. Lists open and verified
  `category: defect` records through the module; the report body is
  `problem`, carrying `issue=<id>`.
- `F/scripts/review::ISSUES_DIR`, `issue_frontmatter`, `issue_problem`:
  removed (orphaned).
- `F/scripts/review::OWNER_PATHS`: changed. `suite` gains
  `.ok-planner/dashboard/`.
- `F/scripts/surface-corpus::parse_issue_file`, `main`: changed. Read
  the record (`artifacts`, `id`, `title`, `problem`, option texts)
  through the module.
- `F/skills/converge/SKILL.md`, `F/skills/converge/prompts/owner-list.md`,
  `F/skills/converge/prompts/merge.md`: changed. Backlog step, owner-list
  task files, verbs, ids, dedup through `issues list`.
- `F/skills/_shared/implementation-auditor.md` (the judge): changed.
  Write scope, filing, dedup through the module.
- `F/skills/audit/SKILL.md`: changed. Extractor filing, layout `mkdir`,
  close-out commit list, staleness output paths.
- `F/skills/document/SKILL.md`: changed. The walk files through `issues file`.
- `F/skills/discover-design/SKILL.md`: changed. Filings, layout tree and
  `mkdir`, reviewer checks on records.
- `F/skills/plan-sprint/SKILL.md`, `F/skills/plan-sprint/core.md`
  (relevance pass input: ids, `issues show`),
  `F/skills/plan-sprint/sprint-document.md` (intake context, archive
  step 1, staged paths): changed.
- `F/skills/_sprint/shared.md` `{{SPRINT-BUILD-PROMPT}}`: changed.
  Upstream filing through `issues file`, dedup through `issues list`.

**Improvements**
- **I1** `F/scripts/review::cmd_backlog`: A1. Today it adds earlier
  records' reports to the ledger, then raises on a record whose Problem
  names no file. Afterward: it works out every report before adding
  any, and lists a record naming no file under `settled` with `files:
  []` instead of raising.

**Behavior changes**
- **B1** `F/scripts/review::cmd_backlog`. Before: read
  `.ok-planner/issues/*.md`, set `issue=<path>`, raised when the folder
  was missing. After: reads records, sets `issue=<id>`; a missing store
  is an empty backlog. Users: in the release: converge SKILL backlog
  step, `merge.md`, `owner-list.md`. Across Converged projects: none; a
  ledger is not reread across runs. Ruling: rewrite.
- **B2** `F/scripts/surface-corpus::main`. Before: argv[1] a markdown
  path; stdin a legacy row. After: argv[1] a record id; no stdin mode.
  Users: in the release: the plan-sprint issue walk, `triage.md`.
  Ruling: rewrite.
- **B3** Every filer (owner list, judge, extractor, documentation walk,
  discover-design, plan-sprint, sprint build task, human). Before:
  wrote `.ok-planner/issues/<ts>-<slug>.md`. After: writes a record to
  `.ok-planner/issues.jsonl`. Users: in the release: every intake
  reader, rewritten in work items 2 and 3. Across Converged projects:
  the owner's stored markdown intake, and an in-flight sprint whose
  `-build.md` was written from the old build prompt and still files
  upstream issues as markdown, which `markdown-intake` converts when
  `/ok` offers it again. Ruling: migrate: work item 5's
  `markdown-intake` offer converts it, and B19's refusal stops every
  reader until it does (call).
- **B4** `F/skills/converge/SKILL.md`, `owner-list.md`. Before: the
  owner list wrote files, `git mv`-ed closed ones, named paths. After:
  writes and closes through the module and names ids. Users: in the
  release: the converge report, `/triage-issues`. Ruling: rewrite.
- **B5** `F/skills/plan-sprint/SKILL.md`. Before: read frontmatter and
  `## Ruling`, stamped and moved files, stopped on a legacy
  `issues.jsonl`. After: reads, rules, closes, promotes through the
  module, and stops on the module's refusal. Users: in the release: the
  planning session. Ruling: rewrite.
- **B6** `F/skills/plan-sprint/sprint-document.md` archive step.
  Before: stamped promoted files and moved them. After: `issues close
  --as promoted` for each record whose `sprint` is this sprint. Users:
  in the release: new sprints. Across Converged projects: in-flight
  sprints carrying the old text, whose promoted files are already
  stamped and which `markdown-intake` moves to `history/issues/`, so
  the old step finds them done. Ruling: preserve (call).
- **B7** `F/skills/audit/SKILL.md` staleness output paths. Before:
  `.ok-planner/issues/`. After: `.ok-planner/issues.jsonl`. Users: in
  the release: `/document`'s current-audit check. Ruling: rewrite.
- **B8** (I1) `F/scripts/review::cmd_backlog`. Before: raised mid-loop,
  printing no JSON. After: prints every report, a no-file record under
  `settled`. Users: in the release: the converge SKILL backlog step.
  Ruling: rewrite.

### 3. `/triage-issues` works the store and answers the owner

**Calls**
- Scope is the union of: records with no route and no ruling (phases 1
  and 2 route them); records with route `upstream` (the harm
  re-check); records with any owner message at `seen: null` (phase 3).
  A ruled record with no route is not routed, but its messages are
  answered. Decided by: work item 3; the old scope rule;
  decision:triage-answers-owner-messages.
- Pool items carry `--field id=<record id>`. Phase 3 adds a `messages`
  pool (`open`/`batched`), batches of 4, prompt `respond`, role
  `respond`. Decided by: phases 1 and 2's batches.
- Triage agents use `issues show`, `issues revise` (route `defect`:
  `category: defect`, `problem`, a generated `recommendation`), and
  `issues close --as answered|retired --reason`. Author agents use
  `issues revise` (narrative into `problem`, plus `options`,
  `recommendation`, `upstream`, `route`). Decided by: work item 3.
- The closing `git mv` step goes, since `close` moves records; agents
  stage both store files; the report gains a `messages` line (replies,
  updates, seen marks). Decided by:
  decision:closed-issues-leave-the-live-file.
- Every triage change to an already-routed record, the upstream harm
  re-check's included, goes through `respond`'s `update` message, so
  story:see-new-analysis flags it. Decided by: the notes review.
- The triage half of the two stories lives in payload markdown, which
  carries no annotation. Decided by: `checks/materialized-standalone`.

**Changes**
- `F/skills/triage-issues/SKILL.md`: changed. Scope, setup (registers
  `respond`; `item_states` adds `messages`), phases 1 and 2 on ids, new
  phase 3, closing, report, description.
- `F/skills/triage-issues/prompts/triage.md`,
  `F/skills/triage-issues/prompts/author.md`: changed. Records and verbs
  in place of file edits.
- `F/skills/triage-issues/prompts/respond.md`: new. Per record: read it
  whole with `issues show`, its discussion, and what it cites; judge
  each unseen owner message; make one `issues respond <id> --from -`
  call with replies, revised fields with the update text naming them,
  and `seen` for each message acted on; never touch `ruling`.

**Behavior changes**
- **B9** `F/skills/triage-issues/SKILL.md` scope and writes. Before:
  stamped `triage:`, `status:`, and bodies in markdown files. After:
  sets `route` and fields, closes through the module, answers owner
  messages. Users: in the release: plan-sprint, converge's backlog.
  Across Converged projects: markdown files already stamped `triage:`,
  whose route the `markdown-intake` draft carries. Ruling: migrate:
  converted by work item 5 (call).
- **B10** `F/skills/triage-issues/SKILL.md` closing and report. Before:
  `git mv`-ed answered and retired files. After: moves nothing itself;
  reports messages. Users: in the release: the converge return that
  embeds the triage report. Ruling: rewrite.

### 4. The intake's rules and documents describe the store

**Calls**
- `{{ISSUE-DEFINITION}}` and `{{ISSUE-FILE-FORMAT}}` keep their names;
  only their bodies change. The format block shows the record and names
  `.ok-planner/bin/issues` as the schema's authority and only writer.
  Decided by: plumbline-coding rule 8.4; prompts across the
  converged-project boundary name the block.
- Records under `history/issues/` stay as written and read as closed,
  `repaired` still read as closed. Decided by: work item 4.
- `docs/integration-contract.md` (support-script paragraph, conformance
  list) and `README.md` change too. Decided by: plumbline-coding rule 1.

**Changes**
- `F/skills/_shared/artifact-definitions.md`: changed. Intake location
  line, `{{ISSUE-DEFINITION}}`, `{{ISSUE-FILE-FORMAT}}` and its rules
  (status becomes state/route/closed_as; the discussion; the
  ruling/recommendation split; the legacy-log rule points at `/ok`'s
  conversion).
- `F/scripts/ok-planner-cheatsheet.md`: changed. The `issues/` bullet
  and the Defect issues section.
- `F/scripts/ok-planner-CLAUDE.md`: changed. The issue intake section
  (store, archive, discussion, `bin/issues`, `bin/dashboard`,
  `dashboard/`, the lock in `.cache/`) and its `bin/` paragraph.
- `F/CLAUDE.md`: changed. Intake paragraph and layout.
- `F/skills/_shared/design-doc-compliance-reviewer.md`: changed.
  Out-of-scope list.
- `F/skills/_shared/implementation-auditor.md`: changed. Intake wording
  and the judge's write scope.
- `F/skills/_sprint/shared.md`: changed. Build prompt.
- `F/skills/converge/prompts/*.md`: changed, as in work item 2.
- `F/skills/_converge/coding-rules.md`: changed. Intake wording that
  names files.
- `F/docs/practice-definitions.md`, `F/review/CLAUDE.md`,
  `F/skills/sketch/SKILL.md`: changed. Intake wording.
- `plugins/ok-conduct/output-styles/ok-conduct.md`: changed. The
  `.ok-planner/` rule's intake wording.
- `docs/integration-contract.md`, `README.md`: changed.

**Improvements**
- **I2** `F/scripts/ok-planner-cheatsheet.md` (the `issues/` bullet,
  rewritten anyway): A8 against
  decision:foreign-harms-become-upstream-issues. Afterward the bullet
  says silence accepts a generated or recommended ruling except on an
  upstream issue, which `/plan-sprint` walks with the owner, and that
  planning closes a judgment issue promoted, retired, or answered
  upstream.

**Behavior changes**
- **B11** The materialized `.ok-planner/CLAUDE.md`, the cheatsheet, the
  artifact definitions. Before: tell agents the intake is markdown
  files. After: the store and its module. Users: in the release: every
  session and agent in a converged project. Ruling: rewrite.
- **B12** `plugins/ok-conduct/output-styles/ok-conduct.md`. Before:
  names `issues/` as the intake. After: names `issues.jsonl` (and
  `history/issues.jsonl`) as the intake, and `issues/` as the layout a
  project not yet converged still holds. Users: across Installed
  plugins: a conduct newer or older than the project's estate. Ruling:
  migrate: both shapes named (call).
- **B13** `F/skills/_shared/design-doc-compliance-reviewer.md`. Before:
  out of scope `issues/` and the legacy `issues.jsonl`. After: the
  store and its archive. Users: in the release: plan-sprint's
  compliance review. Ruling: rewrite.
- **B14** (I2) The cheatsheet bullet. Before: silence settles any
  ruling; planning closes only promoted or retired. After: as above.
  Users: in the release: every reader of the rules layer. Ruling: rewrite.

### 5. `/ok` migrates a project's intake

**Calls**
- `legacy-intake` needs no draft: resolve folds the event log
  deterministically (`open` with no terminal row → live record with
  `title` = summary, `problem` = detail, `options` = candidates,
  `opened` = `at`; `promote` → archived `promoted` with `sprint`;
  `retire` → archived `retired` with `reason`; legacy `resolve` →
  `promoted` when it names a spec, backlog, or sprint, else `retired`),
  piping to the carried `F/scripts/issues import --from -
  --over-event-log` through `subprocess.run` with
  `OK_PLANNER_PROJECT_ROOT` set. It still refuses while the log carries
  uncommitted changes, and prints only when the store holds `event`
  lines. Decided by: work item 5; the mapping is field to field.
- `markdown-intake:.ok-planner/issues` replaces `intake:` and
  `intake-closed:`. Draft: a JSONL of one record per file directly under
  `issues/` whose status is not closed
  (`answered|retired|fixed|promoted|repaired`), `source` set to the
  file's history path. Resolve imports the draft through the module,
  then moves every `*.md` there to `history/issues/` with `move_path`;
  closed and promoted files move unconverted. Resolve requires one
  record per non-closed file, matched by `source`, and refuses a draft
  whose record's `ruling.text` does not match that file's owner `## Ruling`
  text after normalizing whitespace (the section less marked
  `Generated`/`Recommended` blockquotes and HTML comments); a marked
  blockquote becomes `recommendation`. The draft takes a record's id
  from `issue:` where that value is a valid slug unique among the
  drafted records, and otherwise derives it from the filename's slug
  part with a `-2`, `-3`, … suffix on a collision; the `legacy-intake`
  fold derives ids the same way. Diagnose names each file whose id is
  derived in the offer's `What:` line. The offer lists every file it
  moves in `touches`, so the existing uncommitted and symlink refusals
  apply. Converted records take `ruling.at` from the file's last commit
  time, and the draft normalizes an `opened:` missing its `Z` or given
  as a date alone; the ADMINISTRATION draft guidance says both. It
  refuses while the pre-v9 log stands. Decided by: work item 5; A7; the
  `intake` draft's precedent; the notes review.
- `tensions` drafts JSONL records and imports them the same way.
  Decided by: the markdown intake retiring.
- `SUBDIRS` drops `issues`; resolve prunes an emptied `issues/`.
  Decided by: the store layout.
- New core write sites (the import's `subprocess.run` and each
  `move_path`, both in `resolve`) are declared in `checks/owned-paths`;
  the `write_text` into `issues/` goes with `drafted_issues`. Decided
  by: the owned-paths check.

**Changes**
- `F/admin/converge::offers`: changed. Legacy detection by lines;
  `markdown-intake`; the `tensions` draft; `intake:` and
  `intake-closed:` removed.
- `F/admin/converge::drafted_issues`, `ISSUE_NAME`, `CLOSED_STATUSES`:
  removed or replaced; `frontmatter`, `issue_body`, `issue_defects` kept
  for the markdown check.
- `F/admin/converge` resolve branches `legacy-intake`, `tensions`,
  `markdown-intake`: changed or new, as above.
- `F/admin/converge` bash `SUBDIRS`: changed; `issues` dropped.
- `F/admin/ADMINISTRATION.md`: changed. Layout list, offers table,
  drafts, the issue-intake integrity, legacy, and tensions sections,
  with the judgment the `markdown-intake` draft needs (frontmatter to
  fields; title; Problem or narrative; Candidates or Options; Upstream;
  extra sections appended to `problem`).
- `checks/owned-paths::check_planner`: changed. Allowed sites.

**Behavior changes**
- **B15** `F/admin/converge` `legacy-intake`. Before: drafted markdown
  files and deleted the log. After: converts the log in place to live
  and archived records, with no draft. Users: in the release: `/ok`,
  the ADMINISTRATION table. Across Converged projects: a pre-v9 log.
  Ruling: migrate: converted to records (call).
- **B16** `intake:`/`intake-closed:` → `markdown-intake:`. Before:
  repaired or moved single files, leaving the markdown intake live.
  After: converts the open markdown intake and moves every file to
  history. Users: in the release: `/ok`. Across Converged projects:
  every project's markdown intake. Ruling: migrate: converted on the
  owner's yes (call).
- **B17** `tensions` resolve. Before: wrote markdown files into
  `issues/`. After: imports records. Users: in the release: `/ok`.
  Ruling: rewrite.
- **B18** `SUBDIRS`. Before: converge created `issues/`; diagnose
  reported it missing. After: neither. Users: in the release:
  plan-sprint, audit, discover-design, whose `mkdir` lines are
  rewritten. Ruling: rewrite.
- **B19** `F/scripts/issues`. Before: n/a. After: every verb but
  `import` refuses while unconverted markdown or the event log stands,
  naming the `/ok` offer. Users: across Converged projects: owners who
  converge but decline the offer, whose skills stop with the message
  as plan-sprint already stops on the legacy log. Ruling: migrate:
  `/ok` converts; until then the module refuses with a message naming
  the offer (call). This estate change makes the release major under
  `/release`'s table.

### 6. The dashboard's service

**Calls**
- Restored from `52425a8^:.ok-planner/bin/corpus-view`: the
  `ThreadingHTTPServer` loop (daemon threads), static serving with the
  separator-bounded containment check, the estate-version check. Root
  from the module's `project_root`; `--root` and `--bundle` dropped. No
  payload fallback: the service serves only `.ok-planner/dashboard/`,
  and a "no build; run /ok" page when it is missing. Decided by:
  decision:pinned-build-placed-at-converge.
- Binds `127.0.0.1`; `--port` defaults to 0, argparse validates the
  range; a port in use prints `dashboard: port N is in use; omit
  --port to let the OS assign one` and exits 1. Prints `dashboard:
  serving http://127.0.0.1:<port>/ (pid <pid>)`. SIGTERM closes it
  cleanly. Decided by: decision:local-web-surface; A3.
- Routes import the sibling `issues` module by path: `GET /api/meta`
  (service version, estate version from the `.ok-planner/CLAUDE.md`
  stamp, build version from the placed `index.html` meta); `GET
  /api/issues?state=&waiting=1&unread=1&category=` (summaries with
  unseen and unread counts; `waiting` means no route and no ruling, or
  an unseen owner message); `GET /api/issue/<id>` (the live record, else
  the newest archived); `GET /api/closed?category=`; `POST
  /api/issue/<id>/rule|comment` with `{text}`; `POST
  /api/issue/<id>/read`. A GET writes nothing. Decided by: work item 6.
- 400 for empty text or bad JSON; 415 for a non-`application/json`
  POST; 403 when `Host` is not `127.0.0.1:<port>` or `localhost:<port>`
  or a present `Origin` is foreign; 404 for an unknown id or route; 409
  for a closed or promoted record. Decided by: A6 (a text/plain
  cross-site POST would otherwise reach the ruling route).
- The per-request handler is the owner frame: it catches everything,
  answers 500 with JSON, and prints one `DASHBOARD.REQUEST.FAILED` line
  with the traceback to stderr; one bad request never ends the loop.
  Decided by: A5; the events standard; project.md (no event emitter).

**Changes**
- `F/scripts/dashboard`: new.
- `F/admin/converge::EXECUTABLE_FILES`: changed. Adds
  `("scripts/dashboard", ".ok-planner/bin/dashboard", None,
  ("--help",))` with `@decision: local-web-surface`.
- `checks/materialized-standalone::PAYLOADS`: changed. Adds
  `("ok-planner/scripts/dashboard", ".py")`.
- `.ok-planner/review/project.md`, "Scripts for developers and
  operators": changed. Adds `scripts/issues` and `scripts/dashboard`
  with their inputs, so A3 covers them. Its "Drive commands" section
  gains how a driver runs the dashboard: `bin/dashboard` against a
  scratch project holding a placed build, so certification can drive
  the three new stories.

**Behavior changes**
None. Every change is new code no existing user reaches.

### 7. The tracker page

**Calls**
- Svelte 5 (runes, `mount`) with the current Vite major and matching
  `@sveltejs/vite-plugin-svelte`, locked in `package-lock.json`.
  `index.html` carries `<meta name="ok-planner-version"
  content="{{OK_PLANNER_VERSION}}">`, stamped at placement.
  `src/lib/route.js` restored as it was; `src/lib/api.js` keeps `get`
  and adds `post`; `App.svelte` has the header, nav, and version-pin
  banner from `/api/meta`; `views/IssueList.svelte` is based on
  `ArtifactList`; `views/IssueDetail.svelte` and `src/lib/keys.js` are
  new. Decided by: decision:svelte-dashboard-frontend; work item 7.
- Tabs: needs ruling (`needs-ruling`), unread (any triage `read:
  null`), waiting on triage (the service's `waiting`), ruled, closed,
  with a category filter. Verified defect records belong to no tab by
  default; the header shows their count as waiting on `/converge`.
  Decided by: story:rule-on-the-whole-intake ("every open judgment issue").
- Selecting an issue (click or `j`/`k`) opens it and posts `read` once
  when it has unread messages, live records only. `a` posts a ruling
  with the recommendation's text and is off without one; `r`/`c` open a
  text box (Ctrl/Cmd+Enter submits, Esc cancels); keys are ignored
  while typing; a closed or promoted record is read-only. Decided by:
  work item 7; the service's refusals.
- `@story:` annotations sit in the `.js` modules: `rule` and `keys.js`
  (rule-on-the-whole-intake), `comment` (discuss-an-issue), `markRead`
  and the unread predicate (see-new-analysis); `vite.config.js` carries
  `@decision: svelte-dashboard-frontend`; `.svelte` files carry no
  comments, since the lint has no grammar for them. Decided by: the
  build prompt's annotation rule; `checks/materialized-standalone`.
- `F/.gitignore` gains `browser/node_modules/`. Decided by: the removed
  root ignore entry's purpose.

**Changes**
- `F/browser/package.json`, `package-lock.json`, `vite.config.js`,
  `index.html`, `src/main.js`, `src/app.css`, `src/App.svelte`,
  `src/lib/route.js`, `src/lib/api.js`, `src/lib/keys.js`,
  `src/views/IssueList.svelte`, `src/views/IssueDetail.svelte`: new.
- `F/.gitignore`: changed.

**Behavior changes**
None. Every change is new code no existing user reaches.

### 8. The build ships pinned

**Calls**
- `F/admin/converge::expected` carries each file of `F/browser/dist/`,
  keyed at `os.path.join(ok_dir, "dashboard", rel_)` and passed through
  `versioned`. Placement reads text; an asset that does not decode as
  UTF-8, or a missing `dist/index.html`, stops converge with an
  assertion message. Diagnose reports missing and stale files per file.
  Decided by: decision:pinned-build-placed-at-converge.
- Converge removes any file under `.ok-planner/dashboard/` that
  `expected()` does not name, and diagnose reports each as `stale: … is
  not part of the carried v… build`; both skip a symlinked
  `dashboard/`. Decided by: A2.
- The suite-owned ignore file is `F/scripts/dashboard-gitignore` (a
  stamp line, then `*`), materialized through `ESTATE_FILES` to
  `.ok-planner/dashboard/.gitignore`; a source named `.gitignore`
  inside `browser/` would ignore itself. Decided by: the tracker's
  `.cache/.gitignore` precedent.
- `checks/owned-paths` gains a check that no `ESTATE_FILES` or
  placement destination equals or sits under a `RETIRED_ESTATE` entry,
  comparing both on one base: `RETIRED_ESTATE` entries are relative to
  `.ok-planner/`, `ESTATE_FILES` destinations to the project root.
  Decided by: every written constraint needs a check.
- `/release` gains a step after the manifest bump: `rm -rf dist`, `npm
  ci`, `npm run build`, then assert `dist/index.html` exists and
  carries the version placeholder; the release commit's `git add -A`
  takes it. The "release is mechanical" paragraph names the bundle
  beside the metadata. Decided by: work item 8; the removed build step.

**Changes**
- `F/admin/converge::expected`: changed (placement keys).
- `F/admin/converge::ESTATE_FILES`: changed (the ignore file row).
- `F/admin/converge` converge mode: changed (sweep of extra placed
  files, `@decision: pinned-build-placed-at-converge`).
- `F/admin/converge` diagnose: changed (extra-file drift).
- `F/admin/converge::ESTATE_LICENSE_PREAMBLE`: changed (names `dashboard/`).
- `F/scripts/dashboard-gitignore`: new.
- `checks/owned-paths::EXPECTED_KEYS`, `check_sites` allowed set (the
  `os.remove` of an extra placed file in `converge`), and the new
  retired-estate check: changed.
- `.claude/skills/release/SKILL.md`: changed (build step, the
  mechanical paragraph).
- `F/CLAUDE.md` Constraints: changed. Node is needed at release time in
  this repo; consumers need none beyond the lint.
- `F/admin/ADMINISTRATION.md`: changed. Materialize list, a placement
  paragraph, and "What the administration does NOT do" (it now writes
  the one ignore file under `dashboard/`).
- `docs/integration-contract.md`: changed (support scripts, the placed build).

**Behavior changes**
- **B20** `F/admin/converge` expected/diagnose/converge. Before: no
  placement; ADMINISTRATION said converge writes no ignore file. After:
  places `.ok-planner/dashboard/` with its ignore file; diagnose drifts
  on a missing, stale, or extra placed file. Users: in the release:
  `/ok`. Across Converged projects: every project, whose next diagnose
  drifts until it converges, the ordinary update path. Ruling: rewrite.
- **B21** `.claude/skills/release/SKILL.md`. Before: a release needed no
  Node. After: needs Node and npm, and fails with no commit on a failed
  build. Users: in the release: the repo owner. Ruling: rewrite.

### 9. The `/dashboard` skill

**Calls**
- The skill runs `python3 .ok-planner/bin/dashboard` with
  `run_in_background`, reports the address from the `serving` line,
  and on the owner's word stops it with `kill <pid>` from that line. It
  refuses with a message naming `/ok` when `.ok-planner/bin/dashboard`
  is missing. Decided by: decision:dashboard-started-by-skill.
- Converge's `SKILLS` dict and `UNPREFIXED` regex gain `dashboard`,
  with `@decision: dashboard-started-by-skill`. The verb listings gain
  it: `F/CLAUDE.md` (eight verbs become nine, and the layout),
  `README.md`, `docs/integration-contract.md`. The description carries
  "ONLY activated by explicit /dashboard slash command". Decided by:
  work item 9; `F/CLAUDE.md`'s activation rule.

**Changes**
- `F/skills/dashboard/SKILL.md`: new.
- `F/admin/converge::SKILLS`, `UNPREFIXED`: changed.
- `F/CLAUDE.md`, `README.md`, `docs/integration-contract.md`: changed.

**Behavior changes**
- **B22** `F/admin/converge::SKILLS`. Before: converge vendored no
  `dashboard` folder. After: vendors `.claude/skills/dashboard/`; a
  project's own unstamped `dashboard` skill gets the existing
  `collision` offer and stays until the owner consents. Users: across
  Converged projects: a project with its own `/dashboard`. Ruling:
  preserve (call).

## How to execute this sprint

This sprint is self-sufficient. Every executor — an inline session,
an agent handed this file via `/goal`, an orchestrator with its own
planning — runs the same shape: record the base commit, plan the work
into the task tracker as small build tasks cut from the
implementation notes, drain them, then run sprint certification once.
No review runs during the build.

1. Read the sprint whole first: intent, deltas, work items,
   implementation notes, completion contract. The sprint is the whole
   brief: context from the intake (`.ok-planner/issues/`) or
   `history/` may disagree with what the owner approved. Raise a gap
   with the owner.

2. Record the base. Sprint certification reads the change from this
   commit, so the tree holds nothing but this sprint's work from here
   on. The planning session leaves its own files uncommitted: this
   file, its delta sidecar, `.ok-planner/release-boundaries.md`, the
   issue files it stamped, and the sketches it archived. Where `git
   status --porcelain` lists a path outside `.ok-planner/`, name those
   paths to the owner and stop, because certification would count
   them as this sprint's work. Otherwise write the output of `git
   rev-parse HEAD` to the file beside this sprint with the same
   filename, `-base` before the extension and `.txt` as the
   extension.

3. Open the run. The task tracker at `.ok-planner/bin/tasks` and the
   profiles under `.claude/agents/` are required; a missing one is
   the front door's administration (`/ok`) to materialize: say so and
   stop. `tasks init <sprint-name> --file
   .ok-planner/sprints/<sprint-name>-run.jsonl`, `tasks agent
   register ok-opus`, and register the `build` prompt: write
   `{{SPRINT-BUILD-PROMPT}}` from `.claude/skills/_sprint/shared.md`,
   its transclusions resolved and `[SPRINT PATH]` filled, to
   `.ok-planner/sprints/<sprint-name>-build.md`, then `tasks prompt
   register build <that path>`. Declare the roles whose close carries
   a sweep: `tasks config set swept_roles '["build", "fix"]'`, so a
   build task closes `done` only with the sites its searches
   returned, each one staged.

4. Plan the work into stages from the implementation notes. Read the
   code each work item's notes name, in the tree as it stands now,
   before you file anything. Where the tree has moved since the
   notes' commit and a named site no longer matches, plan from the
   outcome the notes state and record the difference as a divergence
   call. Cut the sprint into stages, each **the smallest change that
   makes progress toward the completion contract and leaves the tree
   runnable**: it builds, nothing is half-wired, and the work after it
   can build on it. A stage lands one work item or a part of one. A
   work item that needs more than one agent's reading set becomes
   several stages in sequence. A taken improvement lands in the same
   stage as the change to its definition. Per stage, file one build
   task: `tasks file --role build --prompt build --agent ok-opus
   --key <stage> --files <the paths it may edit> --cites <the work
   items and slugs> --after <the build tasks of the stages it builds
   on, omitted where it builds on none> --brief "<the work items it
   lands, the improvements and deltas it applies, the behavior
   changes it carries by id with their rulings, and where the code
   is and what to reuse>"`. Two stages whose files overlap are
   chained with `--after`; a stage that applies a delta reaches its
   collection's catalog TOC too (`.ok-planner/design/concepts.md`,
   `stories.md`, or `decisions.md`, or `.ok-planner/subjects.md` or
   `.ok-planner/practices.md`, every one of which
   `python3 .ok-planner/bin/catalog-toc` regenerates), so two
   delta-bearing stages overlap. Stages with disjoint files run together. Apply a
   delta no work item implements in a stage of its own.

5. Render the completion report with the staged list before the first
   drain: write the output of `tasks render --title "<this sprint's
   title>" --sprint <this sprint's path>` to the report file (step
   10).

6. Keep the progress checklist. Where the harness task tools are
   available, mirror the stages as a live checklist, one entry per
   stage, created when the build tasks are filed, and add one entry
   for sprint certification when the drain ends. The run file is the
   record and the checklist is display.

7. Drain with the loop at `.claude/skills/_tasks/drain.md`.
   A build that closes `partial` is refiled for its remainder with
   `tasks refile <task>`; one that closes `partial` with a result
   starting `outside files:` is refiled with that path added to its
   files. A build that closes `blocked` is refiled once. The session
   builds nothing and reviews nothing itself, and edits no file a
   running task owns.

8. Every stage applies its corpus deltas as part of the work that
   realizes them, and every new or amended story implemented in code
   carries the `@story:` annotation at the site that realizes it. The
   build prompt carries both rules. `.ok-planner/audits/` and
   `.ok-planner/experiments/` belong to `/audit`.

9. Uncommitted work is the only record of the run. Every task stages
   the paths it touched as it closes (`git add <paths>`), and the run
   records them. Never run `git checkout`/`restore`/`reset`/`stash`/
   `clean` on your own initiative. Fix a bad edit forward by editing
   again.

10. The completion report lives beside this sprint file, same
    filename with `-completion` before the extension. The session
    re-renders it whole from the run before every dispatch: `##
    Stages` from the build tasks and `## Divergences` from the run's
    `divergences` pool. Build tasks record calls, forks, and what
    they noticed as items; the report is rendered, never
    hand-edited.

11. Work unsupervised to a defensible done. Do not pause for
    approval, confirmation, or progress checks. Stop only on a genuine
    blocker: a credential or access you cannot obtain, a step
    impossible in the current state, a destructive or irreversible
    action not clearly authorized, a task closed `blocked` twice, or
    sprint certification being unrunnable for you. Surface that and
    stop. Ambiguity is not a blocker: the builder makes the most
    plausible call and records it, or records a fork and builds the
    reading it judges best. Sprint certification reads both.

12. Code complete means every stage's latest build task closed
    `done`. Then run sprint certification, immediately after:
    `/converge sprint <this sprint's path>`. It judges the change
    from the commit in the `-base.txt` file to the working tree,
    once, against this sprint: every outcome and taken improvement
    works, a user gets what each story the sprint adds or amends
    promises when a driver uses the running product, every delta
    landed, every ruling holds, no unlisted behavior change breaks a
    user, and the project's checks pass. It fixes each defect in the
    sprint's scope and verifies each fix on its own diff. A defect
    outside the sprint's scope goes to the intake as a `category:
    defect` issue for the next `/converge`, and a question only the
    owner can decide goes to the intake for the next `/plan-sprint`.
    It ends by presenting its return block.

13. Write the return block into the completion report, after its
    rendered sections, under a `# Sprint certification` heading, with
    the `/converge` run's ledger path. Nothing renders the report
    after this. Then present the completion report and offer the
    archive and the commit below as one owner act. Ask the owner
    nothing else: every defect the run could not fix and every
    question it raised is already in the intake, for the next
    `/converge` or `/plan-sprint`.

**The archive and the commit.** The owner archives this sprint and
commits the work; offer both as one owner act, and wait. "Finish the
sprint" and "follow the boilerplate" are not a yes; both ask for the
presentation. On the owner's yes:

1. Stamp each issue file this sprint promoted (`status: promoted`,
   `sprint: <this file's name>`) and move it to
   `.ok-planner/history/issues/`.
2. Move this file, its completion report, its run file, its
   `-base.txt` file, its `-build.md` prompt, and its delta sidecar to
   `.ok-planner/history/sprints/`: `git mv` for a tracked file, `mv`
   for an untracked one.
3. Stage by name every path the sprint's change touched, every moved
   file at its new path, the `/converge` run's ledger and folder, and
   every issue file the run wrote or moved. Commit those paths alone
   with `git commit -- <paths>`, naming only paths that exist or that
   `git mv` removed, so nothing else standing in the index rides
   along.
4. Add `closed: <the commit's sha>` to the archived sprint as YAML
   frontmatter, and commit that edit alone. The next planning
   session reads that stamp to detect work done out of band.

The owner publishes; the run never pushes.

## Completion contract

The work is done when all of the following hold, each verifiable
from the repository as it stands:

1. Every corpus matches every delta above, applied verbatim (from
   the sidecar where a heading points there): `.ok-planner/design/`
   for a concept, story, or decision, and `.ok-planner/subjects/` or
   `.ok-planner/practices/` for a subject or practice, with its
   catalog TOC regenerated.
2. The project builds, and the checks `.ok-planner/review/config.json`
   lists under `checks` pass on every file the change touched.
3. The completion report beside this sprint (same filename with
   `-completion`) carries the return block of sprint certification
   (`/converge sprint`) run on this sprint, under `# Sprint certification`: the run's find
   loop ran once, and every defect stands `verified`, `declined`,
   `duplicate`, or `stuck`, with every `stuck` defect listed for the
   owner.

**The goal rule, for any checker verifying this contract.** The goal
is met when items 1–3 verify against the repository as it stands.
Decide from the repository, never from the session transcript: an
earlier session may have done the work, and a term the transcript
does not show may hold on disk. A `stuck` defect listed in the
return is the owner's to take up, and does not hold the goal open.
Presenting the report, archiving, committing, and the
`closed:` stamp all follow completion; a pending archive-and-commit
offer is evidence the goal is met. `sprints/` and
`.ok-planner/history/sprints/` satisfy the rule alike, and a sprint
already archived with a `closed:` stamp is terminal. A missing
completion report, or one without the return block,
means not done. Nothing else counts either way.
