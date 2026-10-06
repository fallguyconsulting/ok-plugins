---
closed: bd433a7a97bf23228f92e3d01022c1087329117b
---

# Sprint: Drain the intake, second pass

## Intent

This sprint works the intake. It has no single theme. It carries the
owner's rulings on eleven issues, fixes the three open defect issues,
and brings the corpus up to four changes that landed outside any
sprint: the intake module's tolerant reads, the owner's edit, withdraw,
unrule, and flag verbs, issue links with the dashboard's file view,
and the before-and-after diff on update messages.

Promoted issues:

- `retired-run-tag-callers-never-repointed`
- `migration-leaves-project-configs-stale`
- `backout-exception-to-left-alone-files`
- `installed-version-entry-selection`
- `lint-patterns-divider-bound`
- `version-surface-absent-outside-integrated-projects`
- `markdown-intake-import-then-move-half-change`
- `review-project-facts-omit-opened-key`
- `revise-writes-no-update-message`
- `unread-view-lists-closed-issues`
- `owner-declarations-take-direct-fixes`
- `cheatsheet-says-silence-accepts-every-ruling` (defect)
- `review-backlog-aborts-after-partial-writes` (defect)
- `history-event-log-blocks-intake-import` (defect)

## Corpus deltas

### Amend decision: issue-writes-through-one-module

```markdown
---
decision: issue-writes-through-one-module
---

# Every intake write goes through one locking module

## Choice

Every reader and writer of the intake goes through one module: the
filers, humans included, triage, the planner, the defect runs, the
front door's migration, and the dashboard's service. The module
serializes every write under an exclusive lock and applies each change
to the file as reread under that lock, and it refuses a write that
adds a schema fault to a record, naming each fault. Nobody edits the
intake by hand.

## Rationale

Triage agents run in parallel, and the service writes while a run
works. A writer that skips the lock, or writes from a copy it read
before taking it, erases another writer's change. One module that
checks every record it writes keeps every reader and writer on one
schema.

## Alternatives

- Agents edit the file by hand — lost writes under concurrency, and the schema drifts writer by writer.
- A long-running service owns the file and every writer calls it — every run would need the service running.
```

### New decision: intake-reads-past-stray-lines

```markdown
---
decision: intake-reads-past-stray-lines
---

# The intake module reads past lines it cannot use and keeps them

## Choice

The intake module skips each line that holds no usable record, or
repeats an id already read (in the archive, an id and opened time),
keeps it in its file, and names how many such lines each file holds.
It drops a live line whose record the archive already holds, which
finishes a close that stopped between its two writes. A schema fault a
record already carried never blocks a write.

## Rationale

One stray line or one old fault should not stop every verb: the owner
can still work the intake while the front door's offer to convert the
line waits. Keeping a stray line in its file loses nothing an earlier
layout wrote before a migration reads it. A close writes the archive
before the live file, so a live line the archive already holds is the
trace of a close that stopped partway, and dropping it completes that
close.

## Alternatives

- Refuse every verb while any line breaks the schema — one stray line stops every reader and writer until someone repairs it by hand.
- Drop or repair stray lines on read — a line an earlier layout wrote is lost before any migration reads it.
- Keep a live line the archive already holds — the issue shows as open and closed at once.
```

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
An issue carries its discussion: the owner's comments and rulings,
and the replies and revisions written in answer.

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
triage-answers-owner-messages, owner-messages-can-change,
flagged-issues-discussed-in-session, agent-revisions-reach-the-owner,
closed-answers-count-as-new under decisions; rule-on-the-whole-intake, discuss-an-issue,
see-new-analysis under stories).
```

### Amend decision: triage-answers-owner-messages

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
acting on it. A message the owner changes after triage saw it waits
for the next run again, and a message the owner withdraws needs no
answer. Triage may revise a ruled issue's analysis; the issue stays
ruled, and the revision reaches the owner as new analysis. It never
rewrites the owner's ruling.

## Rationale

Triage already reads the code and the corpus an issue cites, so it
is the reader able to answer. Answering in a batch run keeps model
calls out of the dashboard's service and keeps every answer to an
owner's message in one verb. Marking a message seen only after acting
leaves it for the next run when a run dies midway.

## Alternatives

- The service calls a model live — the service needs credentials and an agent loop of its own.
- The owner asks in a session and nothing is written back — the answer never reaches the issue, and the next reader misses it (see also: flagged-issues-discussed-in-session).
```

### New decision: owner-messages-can-change

```markdown
---
decision: owner-messages-can-change
---

# The owner may change or withdraw their own messages

## Choice

The owner may change or withdraw their own comment or ruling on an
issue. A message an answer already followed keeps its earlier text
beside the change, and a withdrawn ruling leaves the issue unruled.

## Rationale

A slip in a comment or a ruling should not stand as the owner's word.
Keeping the earlier text of an answered message keeps each reply
readable against what it answered.

## Alternatives

- The owner's messages are fixed once written — a mistaken comment or ruling stands until a later one overrides it.
- A change overwrites the message whole — a reply then answers text nobody can read.
```

### New decision: flagged-issues-discussed-in-session

```markdown
---
decision: flagged-issues-discussed-in-session
---

# A flagged issue is discussed in a session, and the outcome lands on the issue

## Choice

The owner may flag an issue for discussion and talk it over in a
session. The session records the outcome on the issue through the
owner's own comment and ruling, on the owner's word, and clears the
flag once the issue needs no more talk; triage answers those messages
like any other.

## Rationale

Some questions are quicker to settle in conversation than in a thread
answered once per run. Writing the outcome through the owner's own
messages puts it on the issue, so the next reader sees it.

## Alternatives

- The owner asks in a session and nothing is written back — the answer never reaches the issue, and the next reader misses it.
- Every discussion waits for the next triage run — a question that needs several exchanges takes several runs.
```

### New decision: agent-revisions-reach-the-owner

```markdown
---
decision: agent-revisions-reach-the-owner
---

# Every agent revision of a shown issue reaches the owner as a diff

## Choice

Every agent revision of an issue already routed or ruled reaches the
owner as new analysis, whichever ceremony writes it: the intake
records an update message the owner has not read, holding each revised
field's text before and after, and the owner reads the difference. A
first routing stays silent, and so does a change to link markup alone.

## Rationale

The owner acts on a ruling's premises, so a premise rewritten under a
standing ruling must reach the owner whoever rewrote it. A diff shows
exactly what changed, so the update message needs only one line, and
the owner never rereads a whole problem to find the edit. A first
routing already shows the issue as needing a ruling, and a link change
alters no analysis, so a signal for either would only inflate the
count.

## Alternatives

- Only triage's revisions reach the owner — a ruled issue whose problem another ceremony rewrites stays ruled with no signal.
- An agent revision of a ruled issue drops it back to needing a ruling — an agent's act unsettles the owner's ruling.
- The update message narrates each revised field — the owner reads prose about a change instead of the change.
```

### New decision: closed-answers-count-as-new

```markdown
---
decision: closed-answers-count-as-new
---

# An answer on a closed issue counts as new until the owner reads it

## Choice

A new answer or revision on a closed issue counts as new until the
owner reads it, and shows among the new answers, marked closed.

## Rationale

The answer that lands just before a close often explains the close:
why triage answered or retired the issue, or why a run fixed it. The
owner acts on it by vetoing the close or filing a new issue, so it
belongs where the owner looks for new answers. The closed mark keeps
it apart from the open issues awaiting a ruling.

## Alternatives

- A closed issue's answers show only on the closed list — the owner browses closed issues to find them.
- Closing an issue marks its answers read — the owner never sees the last answer as new.
```

### New decision: issue-citations-are-links

```markdown
---
decision: issue-citations-are-links
---

# An issue's citations link to the files they name

## Choice

Each citation of a corpus artifact or a code site in an issue is a
link to the file, and to the line where it names one. Every
`/triage-issues` run checks the links of each open issue no sprint has
taken up that it has never checked, or whose linked file moved,
vanished, or changed since its last check, and repairs them; a
citation whose file is gone becomes plain text (see also:
linked-files-open-in-place).

## Rationale

The owner rules from an issue's evidence, and a link puts that
evidence one step away. Code moves under an open issue, so a link
checked once at filing rots; checking links each run keeps them true
at the cost of one pass over the issues whose files changed.

## Alternatives

- Plain-text citations — the reader searches for each file by hand.
- Links written once at filing — they point at the wrong line once the code moves.
```

### New decision: linked-files-open-in-place

```markdown
---
decision: linked-files-open-in-place
---

# The dashboard shows a linked file over the issue

## Choice

The dashboard reads, and never writes, a project file the page asks
for, such as one an issue links, and shows it in a dialog over the
issue. It refuses a path outside the project root, inside the
repository's git directory, or ignored by git.

## Rationale

Showing a linked file over the issue keeps the owner in the queue
while checking its evidence. Refusing paths git ignores keeps local
secrets off the page.

## Alternatives

- A link opens the file in the owner's editor or on the git host — the owner leaves the queue to read the evidence.
- Links are plain text — the owner finds each file by hand.
```

### Amend story: see-new-analysis

```markdown
---
story: see-new-analysis
---

# See new analysis since I last looked

## Story

As a project owner, I want a way to see which issues, open or closed,
have new answers or revisions since I last read them, whoever wrote
them, so that I respond to each change without rereading the intake.
```

### Amend story: see-governing-versions

```markdown
---
story: see-governing-versions
---

# See which version governs this context

## Story

As the owner of a project that integrates ok-planner, I want a way to see which plugin version governs my current session beside the version this project's vendored layer carries, so that version drift is visible.
```

### Amend decision: whole-file-ownership

```markdown
---
decision: whole-file-ownership
---

# The suite owns whole files and never edits human-edited files, save a retired family's unread state file and references to retired suite paths

## Choice

The suite's machinery — the front door's administration and ok-planner's converge core — owns whole files only: version-stamped — save for a fixed-content file, whose bytes never vary across suite versions and which carries no stamp to verify by — deterministically regenerable, overwritten wholesale. It never edits a file a human also edits, save the one removal of a retired family's unread state file and the rewrites of references to retired suite paths, both below; the consumer's own rules file and memory file are categorically untouchable. Records are where the ownership rule stops. The estate preserves them indefinitely, a migration moves them and never rewrites their bodies, and an archived record keeps the wording it closed with. Ownership decides consent: suite-owned files converge silently, and the suite's own retired-layout content is suite territory, migrated mechanically under the administration's own authorization. A retired family's state file, such as its profile or its baseline, is part of that content once nothing reads it after the converge, even where the owner edited it; removing it is the one removal of a human-edited file the converge makes without the owner's word. Converge removes a committed one whole, recoverable from version history, and names each removed file in its report; an uncommitted or symlinked one goes to the owner like any other estate edit, and a state file a kept script still reads stays. A value in owner-declared configuration that names a retired estate's path is part of that content too, and converge rewrites or removes it with no offer. So is a line in a tracked project file, other than a record and the consumer's own rules file and memory file, that names a retired suite script's path: where the suite's current copy behaves as the retired one did, converge rewrites the line to name it and names each rewritten file in its report; where it does not, or where the line sits in the rules file or the memory file, converge files an intake issue for the owner and leaves the line. Converge removes a retired script once no tracked file other than a record names it. Anything else at a path the suite cares about — hand-written overlaps, preexisting guidance the suite would now govern, or a genuine collision between an earlier layout and the current one — is presented for the owner's decision, and owner-declared configuration, hook wiring in the project's committed harness settings included, is written only as transcription of explicit answers, save a value naming a retired estate's path, above.

## Rationale

Whole-file ownership is what makes silent convergence safe and drift correction trivial — overwrite, never merge. The moment the machinery edits shared files it needs merge logic, risks destroying human work, and loses the ability to regenerate its layer deterministically; the consent boundary keeps the owner sovereign over everything that is theirs, while the suite's own retired layouts stay converge-territory because a half-migrated estate misbehaves under every current skill. A retired family's state file configured a family that no longer runs, so nothing the owner relies on reads it, and version history keeps whatever the owner added. A value or line naming a retired suite path points at the suite's own layout, which the suite may relocate; repointing it to a copy that behaves the same changes nothing the caller relies on, and a caller whose behavior would change reaches the owner as an issue rather than as unrecorded work. A record states what was true when it was written, so rewriting one to match a current layout destroys the only thing it is for.

## Alternatives

- Managed sections inside shared files — merge logic, marker rot, and inevitable collisions with human edits.
- Silent adoption of overlapping preexisting files — the machinery destroys or shadows guidance the project chose deliberately.
- Consent-gating the suite's own layout migration — stalls every legacy project's first converge on a question with one sensible answer.
- Offer each retired state file before removing it — protects a hand-added key, and puts one more question on the first converge of every project that used the retired family.
- Offer each retired script caller's repoint with a draft — one more question per caller on a migrated project's first converge, for a change with one sensible answer.
```

### Amend concept: true-up

```markdown
---
concept: true-up
---

# True-up

## What it is

True-up is the suite's administration act: the idempotent converge of a project's suite presence — every layer the integration contract defines — toward what the front door's carried payload declares. True-up also migrates a project from an earlier release, bringing what that release laid out and what the suite reads to the current version.

## Purpose

True-up lets one administration act cover bootstrap, upgrade, migration, and repair alike, so bringing a project's whole suite presence current is a single deliberate pass per project.

## Boundaries

True-up is what the front door does, not a verb a project carries (see also: skill, integration-contract). It does not validate artifact contents — that is the periodic audit's job. Which content converge may move or write without asking is the ownership rule's (see also: estate; whole-file-ownership under decisions).
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
  corpus, the coding standards, or the harness settings, as a
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
current one on the owner's consent and files one issue for each
retired suite script caller it cannot repoint, the ceremonies that transcribe the
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

### Amend decision: runs-fix-what-the-project-owns

```markdown
---
decision: runs-fix-what-the-project-owns
---

# A run leaves five kinds of file alone and fixes every other file the project owns

## Choice

A `/converge` run's agents fix a clear defect in every file the project
owns, wherever the file sits: its code, its own scripts, skills,
rules, and other tooling, its configuration, its review facts, its
release boundaries, its surface intent, and its document types, with
prose other than skill text in review only as the skill-text rule
allows (see also: skill-text-is-reviewed-as-code). A probable defect or
a judgment call goes to the intake. They leave five kinds of file
alone: the design corpus and the coding standards, which change only
through a sprint's deltas; a file the suite owns; the harness
settings, which decide what runs in every session and change only by
the owner's hand or the owner's consent; a record, such as a
sprint, an issue, an audit, an experiment, or anything archived, which
keeps what it said when it was written and changes only by the act
that owns it; and a document the release regenerates. A defect whose
fix lies in the corpus, the coding standards, or the harness settings
goes to the intake as a judgment issue. A harm in a file the suite owns goes to the intake as
an upstream issue (see also: foreign-harms-become-upstream-issues). A
record changes only through the act that owns it, and a run files
nothing about it. A document the release regenerates is left to the
documentation run (see also: placed-documents-are-records).

## Rationale

The line follows ownership, not location. A file the suite owns is
maintained upstream, and the next converge overwrites a local edit. A
project's own tooling and configuration have no maintainer but the
project, so a run that skips them leaves their defects with nobody,
and filing a clear defect spends the owner's attention on a fix the
rules already decide. The corpus and the coding standards move only
through an approved sprint, and the harness settings govern the
owner's own sessions, so changing any of them is the owner's act. A
record is worth keeping only as it was written, and it causes no harm
as it stands.

## Alternatives

- Leave every file in the suite's estates alone — a simple line, and a
  project's own skills and rules kept there get no fixer.
- Fix a suite-owned file in place — fixes the harm soonest, and the
  next converge overwrites the fix.
- Send every defect outside code to the owner — keeps a run narrow, and
  spends the owner's attention on fixes the rules already decide.
- Leave the owner's configuration and review facts alone — each stale
  entry waits for the owner, who never edits them.
```

## Work items

1. **The front door migrates the whole project from any earlier release.**
   After the converge core moves every retired layout it recognizes,
   the front door's administration reads the estate and every tracked
   project file the suite reads or governs (`.ok-planner/config.json`,
   `.ok-planner/review/config.json`, the hook wiring in
   `.claude/settings.json`, the project's own rules files, and the root
   `CLAUDE.md`) against the carried version's documentation of each
   setting and path. It finds each value, path, or reference the
   current version no longer supports, and each setting it newly
   needs, such as `folders` for a project whose sprints name outside
   paths. It sorts each finding by the ownership rule: the suite's
   retired-layout content (such as a retired estate named in `ignore`
   or `exclude`) the core rewrites with no offer; owner-declared
   configuration goes to the owner as an offer with a draft; the root
   `CLAUDE.md` gets a report line naming its stale lines. Diagnose
   reports agreement only once the audit finds nothing pending. The
   administration document defines the audit step, what it reads, and
   its report, in place of its claim that nothing in it is improvised.
   Makes true: `concept:true-up`, `story:converge-project-estate`,
   `story:project-spans-folders`, `decision:whole-file-ownership`.
   Issue: `migration-leaves-project-configs-stale`.

2. **Converge repoints the callers of retired suite scripts.** The
   converge core rewrites, with no offer, every line in a tracked
   project file, other than a record (anything under
   `.ok-planner/history/`, a sprint, an issue, a run ledger) and the
   project's own rules files and root `CLAUDE.md`, that names the retired lint, `catalog-toc`, or
   `run-tag` copy under a retired estate, to name the suite's copy
   under `.ok-planner/bin/`, and names each rewritten file in its
   report. The `script-path` offer retires. Each caller of a retired
   `src-tag` (one tag per git tree, where `run-tag` gives a fresh tag
   per call), each caller of a retired `port-block` (no drop-in), and
   each line in the project's own rules files or root `CLAUDE.md` that
   names any retired script gets one intake issue, filed through `.ok-planner/bin/issues`, which
   converge names in its report; this replaces the `retired-script`
   offer. Converge removes a retired script, and its retired estate
   once empty, when no tracked file other than a record names it. The administration
   document and the front door's skill describe the new behavior.
   Makes true: `decision:whole-file-ownership`,
   `story:converge-project-estate`. Issue:
   `retired-run-tag-callers-never-repointed`.

3. **Converge's exception list names the backout.** The converge
   skill's statement under "What stays outside this skill" names both
   exceptions: the owner-list agent writes the intake, and a backout
   restores a stuck defect's own edits, left-alone files included. The
   backout prompt keeps the full statement of its exception, and the
   shared fix-line rule stays as it stands. Issue:
   `backout-exception-to-left-alone-files`.

4. **`/ok-version` reports no install.** `/ok-version` drops its two
   installed lines and its `claude plugin list` call, and prints three
   lines: the plugin version governing this session, the stamp on this
   project's vendored layer, and the conduct version governing this
   session. Makes true: `story:see-governing-versions`. Issue:
   `installed-version-entry-selection`.

5. **The conduct's session-start hook names no command.** The
   `ok-conduct` session-start hook drops the clause "/ok-version
   reports the conduct actually governing", so its line states the
   installed conduct version and names no command. Makes true:
   `story:see-governing-versions`. Issue:
   `version-surface-absent-outside-integrated-projects`.

6. **A divider is any punctuation-only comment.** `plumbline patterns`
   labels every comment of punctuation alone `divider`, whatever its
   length. Issue: `lint-patterns-divider-bound`.

7. **The intake migration ends whole or not at all.** Before its first
   write, the `markdown-intake` and `tensions` migration refuses,
   writing nothing and naming the cause, while `.git/index.lock`
   exists, a source or destination folder cannot be written, a
   destination is taken, or a dry run of the import through the intake
   module refuses a record. It then moves every tracked file in one
   `git mv` call and each untracked file by rename, and imports. Where
   the import fails after the move, it moves the files back and stops
   with the cause named. The administration document describes each
   refusal and the move back, and `checks/owned-paths` lists each new
   move call site. Makes true: `story:converge-project-estate`,
   `decision:issue-records-in-one-file`. Issue:
   `markdown-intake-import-then-move-half-change`.

8. **Fixers fix the project's configuration and review facts.** The
   owner's configuration (`.ok-planner/config.json`,
   `.ok-planner/review/config.json`), the review facts
   (`.ok-planner/review/project.md`), the release boundaries, the
   surface intent, and the document types become files the project
   owns: `review owner` classes them `project`, and a `/converge` fixer
   fixes a clear defect in them like any other project file. The
   harness settings (`.claude/settings.json` and `.mcp.json`) stay left
   alone, classed `declaration`, and a defect there goes to the intake
   as a judgment issue. The fix-
   line rule in the converge coding rules, the converge skill, and every
   prompt and document that names these files as left alone or as the
   owner's say so. The review facts' seed header no longer says the
   owner writes the file: agents keep it current, and a sprint build
   that adds or changes a script input updates it in the same stage.
   The review facts keep their limits on agents ("What no agent of
   this loop ever runs") as rules. The seed and the converge and
   sprint-build prompts that describe the file change to match. Makes
   true: `decision:runs-fix-what-the-project-owns`. Issues:
   `review-project-facts-omit-opened-key`,
   `owner-declarations-take-direct-fixes`.

9. **Every agent revision of a shown issue reaches the owner.**
   `issues revise` records an update message the owner has not read,
   with each revised field's text before and after, when the issue is
   already routed or ruled, whichever ceremony calls it. A first
   routing writes no message, and neither does a revision that changes
   link markup alone. Each prompt that calls `revise` on a routed or
   ruled issue writes the one-line update text the respond prompt
   asks for. Makes true: `decision:agent-revisions-reach-the-owner`,
   `story:see-new-analysis`. Issue: `revise-writes-no-update-message`.

10. **The unread view marks closed issues.** `issues list --unread`,
    `GET /api/issues?unread=1`, and the dashboard's unread view list
    each closed issue holding an unread answer, and mark each one as
    closed. Makes true: `decision:closed-answers-count-as-new`,
    `story:see-new-analysis`. Issue: `unread-view-lists-closed-issues`.

11. **The cheatsheet states how upstream issues close.** Fix the
    ok-planner cheatsheet's issue-intake bullet so it no longer says
    silence settles an upstream issue or that a planning session
    closes a judgment issue only as promoted or retired. Where the
    source already reads correctly, the work item confirms it. Issue:
    `cheatsheet-says-silence-accepts-every-ruling`.

12. **`review backlog` writes all its reports or none.** Fix
    `review:cmd_backlog` so an issue whose problem names no file no
    longer leaves earlier reports in the ledger with no result
    printed. Issue: `review-backlog-aborts-after-partial-writes`.

13. **Converge converts an archived pre-v9 event log.** Fix the
    converge core's intake offers so a pre-v9 event log archived at
    `.ok-planner/history/issues.jsonl` gets an offer that converts its
    rows to archived records, and the intake module's note on those
    rows names that offer. Makes true:
    `decision:closed-issues-leave-the-live-file`,
    `decision:issue-records-in-one-file`,
    `story:converge-project-estate`. Issue:
    `history-event-log-blocks-intake-import`.

## Implementation notes

Planned against commit `1ff2a91e2c5fa25c6cf9c1227b231911bc97c02e`.

Annotation constraint for every stage: `checks/materialized-standalone` refuses any `@concept:`, `@story:`, or `@decision:` citation of this repository's corpus in the family's payload (the markdown under `skills/`, `docs/`, `agents/`, `review/`, the `scripts/*.md` files, and the payload scripts `issues`, `dashboard`, `review`, `plumbline`, `tasks`, and the hooks). Annotations go only in `plugins/ok/families/ok-planner/browser/src/**/*.js`, `plugins/ok/families/ok-planner/admin/converge`, `checks/`, and `plugins/ok-conduct/`. `.svelte` files take none. A story or decision whose enforcing code is all payload takes no new annotation.

Nothing in this sprint rebuilds `plugins/ok/families/ok-planner/browser/dist/`; `/release` builds the page. A certification drive checks page-facing behavior through the JSON routes and the CLI, and reads the page source.

### The front door migrates the whole project from any earlier release

**Calls**
- The audit needs judgment, so `/ok` runs it and the core does not. The core's diagnose covers only the audit's mechanical part: `ignore` and `exclude` entries naming a retired estate. Core diagnose stays not-in-agreement while a mechanical finding stands, and `/ok`'s report gives the outcome `converged` only once its audit step lists nothing pending. Decided by: `plugins/ok/CLAUDE.md` (deterministic mechanics in `admin/converge`, judgment in `ADMINISTRATION.md`), and the core keeping no record of an agent's findings.
- An audit finding in owner-declared configuration is written through a new core mode, `amend <config path> --from <draft>`. It takes only `.ok-planner/config.json` and `.ok-planner/review/config.json`; refuses a draft that does not parse as an object; for the lint config refuses a draft `plumbline config-check` flags (when `node` is present) or that keeps the retired `"checks"` key; for the review config refuses a draft with `review_config_defects`; refuses a draft identical to the file; and writes through `write_owner`. Decided by: the `/ok` boundary "All writes happen inside the converge core", and `decision:whole-file-ownership` (owner-declared configuration written only as transcription of explicit answers).
- The project's own rules files, every tracked `CLAUDE.md`, and `.claude/settings.json` entries outside the wiring table get a report line naming each stale line, and no draft. Decided by: `decision:whole-file-ownership` (rules file and memory file categorically untouchable; harness settings written only through the wiring or `settings` transcriptions).
- A lint-config `ignore` or review-config `exclude` entry naming a retired estate is suite retired-layout content, handled with no offer: an entry naming a path the plumbline migration moved is repointed through `planner_path`; any other entry under `.ok-plumbline`, `.ok-workspaces`, or `.ok-review`, or naming the root `.plumbline.json` or `.plumbline-budget.json`, is removed once that estate is gone or its migration is unblocked; an estate a kept script still holds keeps its entry. Decided by: the `whole-file-ownership` delta.
- The audit reads: `config-check` and ADMINISTRATION's "Declare the lint config" for the lint config's keys; the carried `review/seed/config.json` and `review/CLAUDE.md` for the review config's keys; the wiring table for hook entries; the rules-file names the core materializes and the retired paths in ADMINISTRATION for rules files and `CLAUDE.md`; every sprint under `sprints/` and `history/sprints/` for `## Paths outside the project root`, which drives the `folders` finding. Decided by: work item 1's list.

**Changes**
- `plugins/ok/families/ok-planner/admin/converge` (mode `case`, `USAGE`): changed. Accepts `amend`; the usage line names it.
- `plugins/ok/families/ok-planner/admin/converge::<amend mode block>`: new. Validates and writes the draft as above. Prints `written: <path>`, or `amend: <reason>; nothing written` with exit 1.
- `plugins/ok/families/ok-planner/admin/converge::stale_review_settings`: changed. Also removes `exclude` entries naming `.ok-plumbline` or `.ok-workspaces` paths once their estate is gone; the `.ok-review/` removal stays.
- `plugins/ok/families/ok-planner/admin/converge::<lint-config ignore repair>`: new. Runs beside `repair_templates` in `migrate` mode, rewrites stale `ignore` entries through `write_owner`, prints `rewrote: <config> ignore …`. Diagnose prints `DRIFT: retired layout: <config> — its ignore names <entries>; converge rewrites them`.
- `plugins/ok/families/ok-planner/admin/ADMINISTRATION.md`: changed. Line 3 drops "nothing here is improvised". A new section, "Audit the project against the carried version", says when the audit runs (after the first converge), what it reads, and how it sorts each finding (core rewrite, `amend` draft, or report line), and names the `/ok` report lines. The modes block lists `amend`. "What the administration does NOT do" names the `amend` writes and the `ignore`/`exclude` rewrite among the exceptions.
- `plugins/ok/skills/ok/SKILL.md`: changed. Step 4 gains an "Audit" sub-step after converge, following ADMINISTRATION's audit section. Step 5 presents each config finding with its draft in the one question and applies an accepted one with `bash "<payload>/admin/converge" amend <path> --from <draft>`. Step 7's report lists each audit finding, its disposition, and each report line for a rules file or `CLAUDE.md`; the outcome reads `converged` only when the audit leaves nothing pending. The modes paragraph and the Boundaries bullet name `amend`.
- `docs/integration-contract.md`: changed. The modes lists name `amend`; the administration-document bullet names the migration audit; the ownership-rule exceptions name the `ignore`/`exclude` rewrite and the `amend` transcription.
- `checks/owned-paths::check_planner`: changed. Adds an `amend` region allowing its `write_owner` site.
- `.ok-planner/review/project.md`: changed. The converge entry under "Scripts for developers and operators" lists `amend <config path> --from <draft>`.

**Behavior changes**
- **B1** `admin/converge` (`amend`). Before: `converge amend …` printed "amend names no mode; nothing written" and exited 1. After: it writes a validated draft over one of the two owner configs. Users: in the release: `plugins/ok/skills/ok/SKILL.md`, `.ok-planner/review/project.md`. Across installed plugins: `/ok` ships the core in the same plugin. Ruling: preserve (call).
- **B2** `admin/converge::stale_review_settings` and the `ignore` repair. Before: only an `.ok-review/` entry in `exclude` was rewritten. After: converge rewrites every `ignore`/`exclude` entry naming a retired estate, and diagnose reports each as DRIFT (exit 1) until it does. Users: in the release: `/ok` reading diagnose. Across converged projects: owners' `.ok-planner/config.json` and `.ok-planner/review/config.json` (stored state). Ruling: migrate: converge rewrites them on the next `/ok`, with no offer (call), per the `whole-file-ownership` delta.
- **B3** `plugins/ok/skills/ok/SKILL.md`. Before: diagnose, converge, offers, converge, reported `converged` once the core was quiet. After: an audit step follows; its findings join the one question, and a pending finding keeps the outcome from reading `converged`. Users: in the release: the owner running `/ok`. Ruling: rewrite.

### Converge repoints the callers of retired suite scripts

**Calls**
- The retired scripts: `.ok-plumbline/bin/plumbline` → `.ok-planner/bin/plumbline`; `.ok-plumbline/bin/catalog-toc` → `.ok-planner/bin/catalog-toc`; `.ok-workspaces/bin/run-tag`, and the path the retired profile names under `runTag.path` → `.ok-planner/bin/run-tag`. `.ok-workspaces/bin/src-tag`, the profile's `srcTag.path`, and `.ok-workspaces/bin/port-block` have no drop-in, so their callers get intake issues. A profile-named copy outside the estate counts as the retired script it replaces. Decided by: the `whole-file-ownership` delta, and the ok-workspaces family having written those copies.
- A path matches only where the next character is not `[A-Za-z0-9_.-]`. Decided by: accept-list A2.
- The core classifies each caller with the carried review module's `left_alone`, loaded the way `carried_intake` loads the issues module: a `record` (anything under `.ok-planner/history/`, a sprint, the intake files, a run ledger, an audit, an experiment, a sketch, documentation) is skipped; a `suite` file, and any file under a retired estate, is skipped; a `declaration` (the harness settings), a `.claude/rules/` file without the suite stamp, and any tracked `CLAUDE.md` get an issue; a `corpus` or `project` file is rewritten. Decided by: plumbline-coding rule 6, and the delta's exclusions.
- A rewrite is byte-exact apart from the path: read and write with `newline=""`. A caller that does not decode as UTF-8, or that is or sits behind a symbolic link, gets an intake issue instead. Decided by: A2, and the existing refusal of paths behind a link.
- One issue per caller file per no-drop-in script, and one per rules, `CLAUDE.md`, or settings file per retired script, listing each line. Ids: `retired-<script>-caller-<slug of the path>` and `retired-<script>-named-in-<slug of the path>`. Each is filed with kind `audit`, `category: tooling`, `route`, `recommendation`, and `upstream` null, and options to repoint by hand or keep the copy. A src-tag issue says the tag changes from one per tree to one per call. Converge files nothing whose id is already open or archived. Decided by: `{{ISSUE-FILE-FORMAT}}`, the owner list's precedent for a machine filer, and the dedup discipline in `decision:audit-audience-split`.
- Repointing and filing run in `migrate` mode, before the workspaces plan decides which scripts to keep. Diagnose writes nothing; it prints `DRIFT: retired script caller: <file> names <script>; converge repoints it` and `DRIFT: … converge files intake issue <id>`. A filed issue is no longer drift. Decided by: diagnose being read-only.
- A retired script goes once no tracked file other than a record names it, through `git rm`; a script with uncommitted changes, or behind a link, gets the existing `estate-edits` offer. Decided by: the delta, and the commit-first rule of `remove_files`.
- `.ok-planner/review/project.md` lines naming `.ok-workspaces/bin/` leave the `review-wording` offer; the repoint and the caller issues own every script reference. Decided by: the cheatsheet's Uniformity rule (I2).
- Beside the `git grep` scan, the repoint reads `.ok-planner/config.json`, `.ok-planner/review/config.json`, and `.ok-planner/review/project.md` directly, whether git tracks them or not, so I1 and I2 drop no rewrite the old mechanisms made. Decided by: the `whole-file-ownership` delta (a value in owner-declared configuration naming a retired path is rewritten with no offer), and the notes review.
- `plumbline_plan` holds `.ok-plumbline/bin/plumbline` and `catalog-toc` while a caller with a filed issue still names them, rather than removing them as suite files. Decided by: the delta ("removes a retired script once no tracked file other than a record names it").
- This work item's classification needs work item 8's `OWNER_PATHS` change in place: order the stage that changes `OWNER_PATHS` before the repoint stage, or land both in one. Decided by: the notes review.

**Changes**
- `plugins/ok/families/ok-planner/admin/converge::RETIRED_SCRIPT_PATHS`, `script_path_lines`, `script_path_files`, `script_path_offers`, and the `script-path` resolve branch: removed.
- `plugins/ok/families/ok-planner/admin/converge::script_callers` and `retired_script_offer`: removed; the `retired-script` kind leaves the resolve block's tuple.
- `plugins/ok/families/ok-planner/admin/converge::<retired-script table and caller scan>`: new. `git grep -n -I -F` per retired path, classifying each hit as above.
- `plugins/ok/families/ok-planner/admin/converge::<repoint>`: new, in `migrate` mode. Rewrites each line through `write_owner`; prints `repointed: <file> (<n> line(s)): <old> -> <new>`.
- `plugins/ok/families/ok-planner/admin/converge::<caller-issue filing>`: new. Runs `ISSUES_SRC file --from -` with `OK_PLANNER_PROJECT_ROOT=root`, checking live and archived ids first through `carried_intake().load`. Prints `filed: <id> — <file> names <script>`. A refusal by the module stops converge with its message.
- `plugins/ok/families/ok-planner/admin/converge::workspaces_plan`: changed. A kept script whose callers are all repointable, or that no non-record tracked file names, goes to `plan["removes"]`, or to `estate-edits` where dirty or linked. A src-tag or port-block something still names stays, and so does the profile while port-block stays. No `retired-script` offers.
- `plugins/ok/families/ok-planner/admin/converge` (diagnose block): changed. Prints the DRIFT lines above.
- `plugins/ok/families/ok-planner/admin/converge::RETIRED_ESTATE_PATHS`: changed. Drops `.ok-workspaces/bin/` (I2).
- `plugins/ok/families/ok-planner/admin/converge::MOVED_TO_PLANNER`: changed. Drops `bin/plumbline` and `bin/catalog-toc` (I1).
- `plugins/ok/families/ok-planner/admin/ADMINISTRATION.md`: changed. Removes the `retired-script` and `script-path` table rows, the `script-path` draft bullet, and the "recommends decline" sentence. Rewrites plumbline step 5 and workspaces step 2 ("Kept scripts") around the repoint, the issues, and removal once nothing names a script. Workspaces step 5 no longer sends `.ok-workspaces/bin/` lines to `review-wording`, and the `review-wording` row drops `.ok-workspaces/bin/`. "What the administration does NOT do" lists the repoint among the exceptions and the intake filing among the writes.
- `plugins/ok/skills/ok/SKILL.md` step 7: changed. Relays each `repointed:` and `filed:` line, and each removed retired script.
- `plugins/ok/families/ok-planner/skills/_shared/artifact-definitions.md` (writers table, `/ok` row): changed. Adds `issues file`, one issue per retired-script caller it cannot repoint.
- `docs/integration-contract.md` (ownership-rule exceptions): changed. Adds the repoint and the issues filed for the rest.
- `checks/owned-paths::check_planner`: changed. Adds a region for the repoint (allowing `write_owner`) and one for the caller-issue filing (allowing its `subprocess.run` command). Drops the `script-path` resolve's `write_text(target_path)` dependency only where it was the sole user.

**Improvements**
- **I1** `admin/converge::MOVED_TO_PLANNER`: one job done by two mechanisms (`stale_review_settings` and the caller repoint would both rewrite a review-config `checks` entry naming `.ok-plumbline/bin/plumbline`). Afterward: the caller repoint alone rewrites script paths, reading the three estate files directly whether tracked or not, and `planner_path` keeps the docs, subjects, practices, and practice-definitions paths. No behavior change a user observes.
- **I2** `admin/converge::RETIRED_ESTATE_PATHS`: one job done by two mechanisms (a `.ok-workspaces/bin/run-tag` line in `project.md` would be both repointed and offered as `review-wording`). Afterward: `review-wording` covers `.ok-review` and `.ok-plumbline/` alone. Behavior change: B4.

**Behavior changes**
- **B4** `admin/converge` (`script-path` offer). Before: a project file naming the lint or `catalog-toc` under `.ok-plumbline/bin/` got a `CLEANUP OFFERED script-path:` block with a draft. After: converge rewrites the line with no offer and prints `repointed:`; lines naming the old `run-tag`, `project.md` lines included, get the same. Users: in the release: `/ok`'s SKILL. Across converged projects: owners' tracked files (stored state). Ruling: migrate: converge rewrites them on the next `/ok` (call), per the `whole-file-ownership` delta.
- **B5** `admin/converge` (`retired-script` offer). Before: each kept workspaces script got an offer to delete it, recommended `decline` while callers stood. After: run-tag callers are repointed and the copy removed once nothing names it; src-tag and port-block callers, and rules, `CLAUDE.md`, and settings lines naming any retired script, get intake issues. A caller that builds the path in code meets "not found" once the copy goes. Users: in the release: `/ok`. Across converged projects: owners' code calling `.ok-workspaces/bin/*`. Ruling: migrate: literal callers are repointed or get an issue, and the report names each removed script (call), per the `whole-file-ownership` delta.
- **B6** `admin/converge` (converge mode). Before: converge never wrote the intake. After: it files issues through `issues file` and prints `filed:`. Users: in the release: `.ok-planner/bin/issues`, triage, and the dashboard, which read records in the existing format. Ruling: rewrite.
- **B7** `admin/converge` (diagnose). Before: pending callers were offers (exit 3). After: pending repoints and filings are DRIFT (exit 1) until converge runs. Users: in the release: `/ok` step 4.1. Ruling: rewrite.
- **B8** `admin/converge::workspaces_plan`. Before: `.ok-workspaces/` stayed while any kept script stood. After: it goes once its scripts go. Users: across converged projects: the owner's tree. Ruling: migrate: removed by `git rm`, recoverable (call), per the delta.
- **B9** `admin/converge` (resolve). Before: `resolve 'script-path:…'` and `resolve 'retired-script:…'` applied fixes. After: they refuse with "ok-planner offers nothing as …". Users: across converged projects: an owner holding an old consent command. Ruling: migrate: the refusal names diagnose, whose current output applies (call).

### Converge's exception list names the backout

**Calls**
- The backout exception reads "a backout task restores the files a stuck defect's own fixes changed, a file the fix line rule leaves alone included". Decided by: work item 3 and `prompts/backout.md`'s Rules paragraph.
- This bullet also carries work item 8's rewording ("the harness settings" in place of "an owner's declaration"); both edits land in one stage. Decided by: the two work items touching one line.

**Changes**
- `plugins/ok/families/ok-planner/skills/converge/SKILL.md` ("What stays outside this skill"): changed. Names the owner-list agent's intake writes and the backout's restoration of a stuck defect's own edits, left-alone files included.
- `prompts/backout.md` and `{{FIX-LINE-RULE}}`: unchanged.

**Behavior changes**
None. Every change is new code no existing user reaches.

### `/ok-version` reports no install

**Calls**
- The skill takes no `@story: see-governing-versions` annotation. Decided by: `checks/materialized-standalone`.
- The report prints three lines in the work item's order. Decided by: work item 4.
- Step 3 (governing conduct) keeps its sentence explaining why it reads the output style and not the session-start line. Decided by: work item 5 keeps that hook line as an installed-version statement.

**Changes**
- `plugins/ok/families/ok-planner/skills/ok-version/SKILL.md` (frontmatter description): changed. Shows the ok-planner plugin version and the conduct version governing this session beside the stamp on the project's vendored layer; no drift verdict.
- `plugins/ok/families/ok-planner/skills/ok-version/SKILL.md` (intro paragraph): changed. The two installed values go.
- `plugins/ok/families/ok-planner/skills/ok-version/SKILL.md` (step 2, installed plugin version; step 5, installed conduct version): removed, with the `claude plugin list --json` call and its entry-selection rule.
- `plugins/ok/families/ok-planner/skills/ok-version/SKILL.md` (procedure numbering): changed. Steps become 1 governing plugin, 2 vendored-layer stamp, 3 governing conduct, 4 report; step 1's "(step 3)" becomes "(step 2)".
- `plugins/ok/families/ok-planner/skills/ok-version/SKILL.md` (report step): changed. Prints exactly `Plugin version (governing this session)`, `Vendored layer (this project's stamp)`, `Conduct version (governing this session)`.
- No other site names the two installed lines. `plugins/ok-conduct/CLAUDE.md`, `.claude/skills/release/SKILL.md`, `plugins/ok/skills/ok/SKILL.md`, and `admin/ADMINISTRATION.md` stand as written.

**Behavior changes**
- **B100** `plugins/ok/families/ok-planner/skills/ok-version/SKILL.md`. Before: runs `claude plugin list --json` and prints five lines, two of them installed versions. After: runs no command and prints three lines. Users: in the release: the owner reading the report; no code parses it. Across converged projects: none; each project gets the new text at its next `/ok`. Ruling: rewrite.

### The conduct's session-start hook names no command

**Calls**
- The line becomes exactly: `ok-conduct ${CONDUCT_VERSION} is installed for this user. If the ok-conduct output style is active, its delivery rules govern this session.` Decided by: the ruling on `version-surface-absent-outside-integrated-projects` (option C).
- The conduct body and its `Conduct version:` stamp do not change. Decided by: `/release` owns the stamp; a hook change is not a body change.
- The hook takes no annotation. Decided by: it no longer realizes `story:see-governing-versions`.

**Changes**
- `plugins/ok-conduct/hooks/session-start` (`context`): changed. Drops the clause "/ok-version reports the conduct actually governing." and names no command.

**Behavior changes**
- **B101** `plugins/ok-conduct/hooks/session-start`. Before: every session's context names `/ok-version` as the way to see the governing conduct. After: the line states the installed conduct version and names no command. Users: in the release: the session model reading the injected context; no code reads the line. Across installed plugins: none. Ruling: rewrite.

### A divider is any punctuation-only comment

**Calls**
- A divider is a comment whose text, once markers are stripped (the `stripped` value `commentHygieneShape` already computes), holds no Unicode letter or digit: `!/[\p{L}\p{N}]/u.test(stripped)`, at any length, a trailing comment after code included. Decided by: the owner's ruling on `lint-patterns-divider-bound`; Unicode classes keep a non-Latin prose comment out of the delete bucket.
- An empty comment (`//`, `#`) also labels `divider`. Decided by: the ruling (it holds no letter or digit).
- The divider test stays first, so a brace-only comment (`// }`) labels `divider`, not `commented-out-code`. Decided by: the ruling ("every comment of punctuation alone"); both labels sit in the audit's mechanical cluster.

**Changes**
- `plugins/ok/families/ok-planner/scripts/plumbline::commentHygieneShape`: changed. The first branch returns `'divider'` when `stripped` holds no `\p{L}` or `\p{N}`; the source-length bound and the source-line character class go.
- `plugins/ok/families/ok-planner/scripts/plumbline::isLikelyCode`: changed. The `/^[{}]$/` branch is removed (unreachable; one caller).
- `plugins/ok/families/ok-planner/scripts/plumbline::checkCommentHygiene`: changed. The violation drops its `source` field; the divider test was its only reader.

**Behavior changes**
- **B102** `plugins/ok/families/ok-planner/scripts/plumbline::commentHygieneShape` (`plumbline patterns`). Before: a punctuation-only comment shorter than 8 source characters, and a trailing punctuation comment after code, cluster as `disallowed-prose`; `// }` clusters as `commented-out-code`. After: all three cluster as `divider`. The lint's verdict and exit codes do not change. Users: in the release: `/audit`'s lint sweep. Across converged projects: the lint and the audit skill are materialized in the same converge. Ruling: rewrite.

### The intake migration ends whole or not at all

**Calls**
- The core finds the index lock with `git rev-parse --git-path index.lock`, resolved from the root through `git_lines`. Decided by: the ruling's "`.git/index.lock` exists", and the root being marker-defined.
- "Cannot be written" means `os.access(W_OK)` fails on the source folder (`issues/` or `design/tensions/`) or the destination folder; where the destination does not exist yet, on its nearest existing ancestor. Decided by: the ruling's checks.
- Tracked sources move in one call, `git -C root mv -- <srcs…> <destination folder>/`, after `os.makedirs` of the destination; untracked entries then move by `shutil.move`. A tensions entry is a top-level entry of `design/tensions/`, `_resolved/` and `_rejected/` included. The builder tests whether `git mv` of a folder carries untracked files inside it, and moves any it leaves behind by rename. Decided by: the ruling.
- Any failure after the first move moves back everything already moved, then stops naming the cause, a failed rename as well as a failed import; the move back runs tracked files in one `git mv` call and untracked ones by rename. Decided by: plumbline-coding rule 4.2 and the ruling's move back.
- The dry run is `issues import --dry-run --from -`: it runs the import's checks, its `change`, and `store_defects` under the lock, prints the counts it would write, and writes nothing. Decided by: the ruling.
- A project left half-migrated by an earlier release still gets today's offer; this sprint adds no repair for that state. Decided by: the ruling (option A over B).
- `import_issues` calls the carried `ISSUES_SRC` for the dry run, never the project's `.ok-planner/bin/issues`: only the carried copy has `--dry-run` in this release. Decided by: the converged-projects boundary.

**Changes**
- `plugins/ok/families/ok-planner/scripts/issues::transaction`: changed. Gains a `write` switch; with it off, it validates and returns without writing.
- `plugins/ok/families/ok-planner/scripts/issues::import_records`, `cmd_import`, `build_parser`: changed. Add `--dry-run` to `import`, printing "would import …".
- `plugins/ok/families/ok-planner/admin/converge::import_issues`: changed. Takes a dry-run switch and returns the completed run; `legacy-intake` still exits on refusal, and the markdown and tensions path moves back first.
- `plugins/ok/families/ok-planner/admin/converge::<intake-migration checks>`: new. Returns each refusal cause; the resolve block exits with `resolve: <cause>; nothing written` before any write.
- `plugins/ok/families/ok-planner/admin/converge::<move-all and move-back>`: new.
- `plugins/ok/families/ok-planner/admin/converge` (`tensions` and `markdown-intake` resolve branches): changed. Checks, then move all, then import, moving back on failure. The tensions branch removes the emptied `design/tensions/`, the markdown branch the emptied `issues/`.
- `plugins/ok/families/ok-planner/admin/converge::markdown_offer` and the `tensions` offer: changed. Their `fix` text says move, then import.
- `plugins/ok/families/ok-planner/admin/ADMINISTRATION.md`: changed. The offer table rows for `markdown-intake` and `tensions`, the Issue-intake integrity paragraph (each refusal, the one-call move, the move back), and the "Pre-4.0 tensions" paragraph.
- `checks/owned-paths::check_planner`: changed. Regions for the move-all and move-back helpers, allowing their `git mv` `subprocess.run`, `shutil.move`, and `os.rmdir` sites, and the call site in the resolve block.
- `.ok-planner/review/project.md`: changed. Lists `issues import --dry-run`.

**Behavior changes**
- **B10** `admin/converge` (resolve `markdown-intake:` and `tensions:`). Before: import first, then one `git mv` per file; a failure partway left records imported and files in place. After: the five refusals come before any write; then one move, then the import, with a move back on failure; output prints `moved:` lines before the import summary. Users: in the release: `/ok`. Across converged projects: a pending offer's id, block, and draft contract are unchanged. Ruling: preserve (call) for the offer and draft; rewrite for the in-release order.
- **B11** `scripts/issues::cmd_import` (`--dry-run`). Before: no such flag. After: validates and writes nothing. Users: in the release: the converge core. Ruling: preserve (call).

### Fixers fix the project's configuration and review facts

**Calls**
- The kind name `declaration` stays and now covers the harness settings alone (`.claude/settings*.json`, `.mcp.json`). Prose that listed "an owner's declaration (configuration, … document types)" now says "the harness settings". Decided by: the `runs-fix-what-the-project-owns` delta; no reader learns a new word.
- The retired-estate configs (`.ok-plumbline/config.json`, `.plumbline.json`, `.ok-workspaces/config.json`) leave `declaration` and class `project`. Decided by: the delta (only the harness settings stay left alone).
- The fix line rule gains one clause: "A fix to the review facts keeps every limit its `## What no agent of this loop ever runs` section sets." Decided by: work item 8 and the owner's ruling that the limits stay as rules.
- The new seed header reads, in substance: "Agents keep this file current: a sprint build that adds or changes a script input updates it in the same stage, and a `/converge` fixer fixes a clear defect in it. The limits under 'What no agent of this loop ever runs' bind every agent." The old seed's sha256 joins `RETIRED_PROJECT_MD_SEED_DIGESTS`, so an unfilled old seed still gets `review-facts`. Decided by: work item 8, and the stored-state boundary.
- The build prompt asks the builder to update `project.md`; a builder whose task lacks the file closes `partial` with `outside files:`, which the execution shape refiles. Decided by: the sprint document's step 7.

**Changes**
- `plugins/ok/families/ok-planner/scripts/review::OWNER_PATHS`: changed. The `declaration` entry keeps `.mcp.json` alone; `HARNESS_SETTINGS` is unchanged.
- `plugins/ok/families/ok-planner/skills/_converge/coding-rules.md::{{FIX-LINE-RULE}}`: changed. The third bullet becomes the harness settings, whose defect goes to the intake as a judgment issue. The opening paragraph names the project's configuration, review facts, release boundaries, surface intent, and document types among the files the run fixes. Adds the limits clause.
- `plugins/ok/families/ok-planner/skills/converge/SKILL.md`: changed. Scope lists the harness settings among the five; sprint-mode merge step 5 reads "a fix in the corpus or the harness settings"; "What stays outside" gets the same rewording, with work item 3.
- `plugins/ok/families/ok-planner/skills/converge/prompts/merge.md` (ownership test): changed. "The fix changes what the corpus or the harness settings commit to."
- `plugins/ok/families/ok-planner/skills/converge/prompts/owner-list.md`: changed. `declaration` means the harness settings, `category: tooling`.
- `plugins/ok/families/ok-planner/skills/_sprint/shared.md::{{SPRINT-BUILD-PROMPT}}`: changed. One bullet: where the stage adds or changes an input of a script `.ok-planner/review/project.md` lists, the builder updates that entry in the same stage.
- `plugins/ok/families/ok-planner/review/seed/project.md`: changed. New header; the "What no agent…" instruction states its lines are rules every agent keeps.
- `plugins/ok/families/ok-planner/admin/converge::RETIRED_PROJECT_MD_SEED_DIGESTS`: changed. Adds the old seed's digest.
- `plugins/ok/families/ok-planner/review/CLAUDE.md`: changed. `config.json` and `project.md` are the project's, seeded once and never overwritten; agents keep `project.md` current.
- `plugins/ok/families/ok-planner/scripts/ok-planner-cheatsheet.md`: changed. `config.json` and `project.md` are the project's; `.ok-planner/config.json` is "the project's configuration".
- `plugins/ok/families/ok-planner/scripts/ok-planner-CLAUDE.md`: changed. "are the project's after".
- `plugins/ok/families/ok-planner/admin/ADMINISTRATION.md` and `admin/converge::review_exclude_offers` (its `what` text): changed. "the owner's declarations" becomes "the harness settings".
- `.ok-planner/review/project.md`: changed. New header.

**Behavior changes**
- **B12** `scripts/review::left_alone` / `review owner`. Before: the five owner files printed `declaration`. After: they print `project`. Users: in the release: `merge.md`, `owner-list.md`, the converge SKILL, `{{FIX-LINE-RULE}}`, all vendored with the tool in one converge. Ruling: rewrite.
- **B13** `scripts/review::scoped_files` and `changed_files`. Before: these files never entered `review files`, `review changed`, `review checks`, or `review snapshot`. After: the two JSON configs, the non-prose surface files, and the retired-estate configs (`.ok-plumbline/config.json`, `.plumbline.json`, `.ok-workspaces/config.json`, the last read by a kept `port-block`) enter the analysis hunt, and any of them a sprint changes enters the sprint review's change list and checks; a `/converge` fixer may edit them. Users: in the release: the converge SKILL's analysis and sprint modes, `sprint-review.md`, `sprint-pass.md`. Ruling: rewrite.
- **B14** `scripts/review::backlog_entry`. Before: a defect issue naming only `project.md` or a config settled as left alone, and its issue turned into a judgment issue. After: it becomes a report the run fixes. Users: in the release: the converge SKILL backlog step and the owner list. Ruling: rewrite.
- **B15** `{{FIX-LINE-RULE}}`, `merge.md`, `owner-list.md`. Before: a defect in these files went to the intake as `category: tooling`. After: a fixer fixes it; only harness-settings defects go to the intake. Users: across converged projects: owners' configs and review facts, edited by the next `/converge` after `/ok`. Ruling: migrate: no stored data changes shape; the owner approved the change in the `runs-fix-what-the-project-owns` delta (call).
- **B16** `review/seed/project.md` and `admin/converge::seeded_project_md`. Before: the seed said "The owner writes this file." After: the new header; an unfilled old seed is still recognized through its digest. Users: across converged projects: unfilled seeds (stored state). Ruling: migrate: the old seed's digest joins `RETIRED_PROJECT_MD_SEED_DIGESTS`, so the `review-facts` offer still stands (call).
- **B17** `skills/_sprint/shared.md::{{SPRINT-BUILD-PROMPT}}`. Before: builders never touched `project.md`. After: a build that changes a script input updates it. Users: in the release: the sprint execution shape. Ruling: rewrite.

### Every agent revision of a shown issue reaches the owner

**Calls**
- "Shown" means the record, as reread under the lock before the write's fields apply, has `route` or `ruling` not null. Decided by: `decision:agent-revisions-reach-the-owner` and coding rule 3.3.
- "Link markup alone" means every changed field compares equal once each Markdown link is reduced to its link text with the module's existing `LINK` regex (`LINK.sub(r"\1", …)`), applied recursively over strings, option lists, and the recommendation object; non-text fields (`route`, `category`, `artifacts`) compare as values. Decided by: the decision and `prompts/links.md`.
- The message's `changed` list and `diff` cover the fields whose stored value the write changed, with before and after values as stored; a field passed unchanged is no change. When nothing changes beyond link markup, no message is written, and `updated` is still stamped. Decided by: the decision and the sibling `respond`.
- `revise`'s JSON object takes two keys beside the fields, `text` and `by`, copying `respond`'s `update` object. The module splits them off before `check_fields`. Decided by: coding rule 2.
- `by` names the ceremony that wrote the revision: `triage-issues` or `converge`. Decided by: the ruled issue's option A, and A9 (a `/converge` revision labelled triage misreports who changed the premises).
- A revision of a shown issue that changes more than link markup and lacks `text` or `by` is refused whole, exit 2, saying the issue is routed or ruled so the revision needs `by` (`triage-issues` or `converge`) and `text`, one line saying what changed; raised inside the transaction before any write. Decided by: coding rules 3 and 4.8.
- Where no message is written, `text` and `by` are accepted and unused, and the output says so (B105). Decided by: coding rule 7.5.
- One helper builds the update message for both `respond` and `revise`. Decided by: coding rule 6.
- `unread`, `issues read`, and the page treat a message whose `by` is in `AGENT_AUTHORS` as an agent message, so a message with a missing `by` (which `readable_message` reads as `""`) neither counts as unread nor gets marked read. Decided by: the decision, and A9 (a malformed message is not new analysis).
- `cmd_read` prints "%d agent message(s) marked read", and the `read` help says "mark every agent message". Decided by: B106 and A9.
- The prompts' update text follows `respond.md`: "one line of at most twelve words: what changed". Decided by: work item 9.
- The module takes no `@decision:` annotation; the page carries it. Decided by: `checks/materialized-standalone`.

**Changes**
- `plugins/ok/families/ok-planner/scripts/issues::AGENT_AUTHORS`: new constant, `(TRIAGE, "converge")`.
- `plugins/ok/families/ok-planner/scripts/issues::revision_parts` and `::beyond_links`: new. `revision_parts` splits `text` and `by` from the fields, checks `by` against `AGENT_AUTHORS` and `text` with `text_defect`, then calls `check_fields(fields, "revise")`. `beyond_links` reports whether two values differ once link markup is reduced.
- `plugins/ok/families/ok-planner/scripts/issues::update_message`: new. Appends the update message (number, `by`, `at`, `type: update`, `changed`, `diff`, `text`, `read: None`); `respond` and `revise` call it.
- `plugins/ok/families/ok-planner/scripts/issues::revise`: changed. Under the lock: reads whether the issue is shown; applies the fields; computes the changed fields; where shown and any changed field goes beyond link markup, appends an update through `update_message` (refusing without `text` and `by`); stamps `updated`. Returns the message number or the reason none was written: `first routing`, `link markup only`, or `no change`.
- `plugins/ok/families/ok-planner/scripts/issues::respond`: changed. Builds its update through `update_message` with `by=TRIAGE`; behavior unchanged.
- `plugins/ok/families/ok-planner/scripts/issues::one_message_defects`: changed. Owner types need `by == owner`, a `reply` needs `triage-issues`, an `update` needs a member of `AGENT_AUTHORS`; the failure message names the allowed values.
- `plugins/ok/families/ok-planner/scripts/issues::unread`: changed. Counts messages whose `by` is in `AGENT_AUTHORS` and `read is None`.
- `plugins/ok/families/ok-planner/scripts/issues::mark_read`: changed. Marks every message whose `by` is in `AGENT_AUTHORS`.
- `plugins/ok/families/ok-planner/scripts/issues::cmd_read` and the `read` help: changed. Say "agent message(s)".
- `plugins/ok/families/ok-planner/scripts/issues::message_line`: changed. An agent message is labelled `triage` for `triage-issues` and by its `by` value otherwise.
- `plugins/ok/families/ok-planner/scripts/issues::owner_entry`: changed. Its refusal names the message's writer, not "triage's".
- `plugins/ok/families/ok-planner/scripts/issues::cmd_revise`: changed. Prints `revised <id>: <changed fields>` then `; update message <n>` or `; no update message (<reason>)`, never listing `text` or `by`.
- `plugins/ok/families/ok-planner/scripts/issues::build_parser`: changed. The `revise` help says that on a routed or ruled issue it writes an update message from the object's `by` and `text`; the `--unread` help says "agent messages".
- `plugins/ok/families/ok-planner/browser/src/lib/api.js`: changed. The `TRIAGE` constant becomes `OWNER = 'owner'`; `isOwn` becomes `by === OWNER`; `isTriage` is renamed `isAgent` and becomes `by !== OWNER`; `isNew` becomes `by !== OWNER && read === null` and gains `// @decision: agent-revisions-reach-the-owner` beside its `@story: see-new-analysis`. Every importer changes with the rename.
- `plugins/ok/families/ok-planner/browser/src/views/IssueDetail.svelte` (thread and `load()`): changed. The label reads `triage · {type}` for `triage-issues`, else `{m.by} · {type}`; `class:triage` and `class:fresh` use `isAgent`; the read-failure notice says "Could not mark the new messages read"; Edit and Withdraw show only on the owner's own messages (`isOwn`).
- `plugins/ok/families/ok-planner/skills/triage-issues/prompts/author.md` ("A reuse brief", "Write the record"): changed. Where the record already carries a ruling, the object adds `"by": "triage-issues"` and `"text": "<one line of at most twelve words: what changed>"`.
- `plugins/ok/families/ok-planner/skills/triage-issues/prompts/triage.md` (defect): changed, with the same addition where the record is ruled.
- `plugins/ok/families/ok-planner/skills/triage-issues/prompts/links.md` (Link): changed. A link-only revise writes no update message; the module refuses a revise of a routed or ruled record that changes words outside the link markup, so restore those words and run it again.
- `plugins/ok/families/ok-planner/skills/converge/prompts/owner-list.md` (the stuck-defect and left-alone sections, their "With an `issue` field" bullets): changed. The `revise` object adds `"by": "converge"` and a one-line `"text"`, such as `Stuck in <run>; now a judgment issue`; the module records the revision as an update message the owner reads. Work item 8 edits the same file.
- `plugins/ok/families/ok-planner/skills/_shared/artifact-definitions.md`: changed in five places: the discussion paragraph (updates are written by `/triage-issues`, and by any agent that revises a routed or ruled issue); the `unread` definition ("agent messages the owner has not yet read"); the message table (`update` written by `triage-issues` or `converge`); the writers table (`issues revise` carries `by` and `text` on a routed or ruled issue); the ownership and read rules (`issues revise` on a routed or ruled issue records an update message naming its writer, with each changed field before and after; a first routing and a link-only change write none; every agent message starts `read: null`).
- `plugins/ok/families/ok-planner/scripts/ok-planner-cheatsheet.md` (Discussing): changed. A triage reply, and every agent revision of a routed or ruled issue, stays unread until the owner opens the issue.
- `plugins/ok/families/ok-planner/scripts/ok-planner-CLAUDE.md` (The discussion): changed in the same way.
- `.ok-planner/review/project.md` (the `issues` entry): changed. `revise <id>`'s object may also carry `by` (`triage-issues` or `converge`) and `text`, and needs both on a routed or ruled issue unless the change is link-only.

**Behavior changes**
- **B103** `plugins/ok/families/ok-planner/scripts/issues::revise`. Before: a revise never writes a message, so the change raises no unread count. After: a revise of a routed or ruled issue that changes more than link markup appends an unread `update` message with `changed` and `diff`; the issue appears in `issues list --unread`, `GET /api/issues?unread=1`, and the page's unread tab. A first routing or a link-only change writes none. Users: in the release: `/converge`'s owner list, triage's author, defect, and links prompts, the dashboard page; `/plan-sprint` reads `unseen` only. Across stored state: existing records unchanged. Ruling: rewrite.
- **B104** `plugins/ok/families/ok-planner/scripts/issues::revise` (input). Before: the object takes revisable fields only, and any revise of an open issue lands. After: `text` and `by` are accepted; a revise of a routed or ruled issue that changes more than link markup is refused, exit 2, unless both are given. Users: in the release: the triage and converge prompts above, and a human running `issues revise`. Ruling: rewrite.
- **B105** `plugins/ok/families/ok-planner/scripts/issues::cmd_revise`. Before: prints `revised <id>: <every key passed>`. After: prints the fields actually changed, plus the update message number or why none was written. Users: in the release: the agents reading the output; no code parses it. Ruling: rewrite.
- **B106** `scripts/issues::one_message_defects`, `unread`, `mark_read`, `message_line`; `browser/src/lib/api.js::isOwn`, `isNew`, `isAgent`. Before: only `triage-issues` may write agent messages, and only its messages count as unread, get marked read, and show as agent messages. After: an `update` may carry `by: converge`, and every non-owner message counts, marks, and shows as an agent message, labelled by its writer. Users: in the release: the dashboard service, the page, `issues show`. Across stored state: existing records (all `by: triage-issues`) read as before; a checkout on the older vendored layer reads a new `by: converge` record without a note and without blocking writes, and neither counts nor marks that message. Ruling: migrate: both author values are accepted, and existing records are unchanged (call).

### The unread view marks closed issues

**Calls**
- The work item is already built at the commit: `issues::select` adds archived views when `unread_only` is set; `summary_line` prints each view's `state` (`closed` for an archived record); `GET /api/issues?unread=1` calls the same `select`; `App.svelte::gather` merges closed unread rows, and `IssueList.svelte` shows the `closed` tag in the unread tab. Decided by: reading those definitions against `decision:closed-answers-count-as-new`.

**Changes**
- `plugins/ok/families/ok-planner/browser/src/lib/api.js::unread`: add `// @decision: closed-answers-count-as-new` beside the existing `// @story: see-new-analysis`.

**Behavior changes**
None. Every change is new code no existing user reaches.

### The cheatsheet states how upstream issues close

**Calls**
- The source already reads correctly, so this work item confirms it and changes nothing. `plugins/ok/families/ok-planner/scripts/ok-planner-cheatsheet.md` reads "Silence accepts that ruling, except on an upstream issue or while an owner comment awaits triage, and `/plan-sprint` walks each of those with the owner." and "A `/plan-sprint` session closes a judgment issue: **promoted** into that sprint, **retired**, or, for an upstream issue the owner files upstream, **answered**." Its Routing paragraph, `skills/_shared/artifact-definitions.md`, `skills/plan-sprint/SKILL.md`, and `scripts/ok-planner-CLAUDE.md` agree. Decided by: work item 11.

**Changes**
None.

**Behavior changes**
None. Every change is new code no existing user reaches.

### `review backlog` writes all its reports or none

**Calls**
- The trigger the work item names no longer reaches a raise at the commit: `backlog_entry` returns a settled entry for an issue naming no file, and `cmd_backlog` works out every report before any write. The partial write that remains is a tracker failure on report k after k−1 landed, so every report lands in one tracker write. Decided by: work item 12's title and plumbline-coding rule 3.1.
- The batch write is `tasks item add --pool P --key K --from <path|->`: JSON Lines, one object per item, `body` and `fields` required, `fingerprint` and `state` optional; `--from` is refused beside `--body`, `--field`, `--fingerprint`, or `--state`; every line and state is checked before any record is written; all item records and their `TASKS.ITEM.ADDED` events are appended in one write under the run's lock; it prints one id per line, in order. Decided by: rules 3.1 and 7.1, and the existing `TASKS.ITEM.ADDED` emission.
- `cmd_noticed` is a member of the same class (it raises "noticed item … names no file" after earlier reports landed) and changes here. Decided by: plumbline-coding rule 8.1 and A8.
- The task-filing verbs (`fixes`, `hunts`, `merges`, `drives`, `verifies`, `backouts`) file tasks, not reports, and stay for `/converge`'s next run. Decided by: the code planner's scope rule.

**Changes**
- `plugins/ok/families/ok-planner/scripts/tasks::cmd_item`, `build_parser`, usage text: changed. Add `item add --from`.
- `plugins/ok/families/ok-planner/scripts/tasks::<batch add>` and `Store::<many-record put>`: new. Validate all lines, then append all records in one write and sync once.
- `plugins/ok/families/ok-planner/scripts/review::tasks_run`: changed. Takes optional stdin input.
- `plugins/ok/families/ok-planner/scripts/review::add_reports`: new. One `tasks item add --from -` call for a list of reports; returns their ids, and raises `ReviewError` with nothing written on refusal.
- `plugins/ok/families/ok-planner/scripts/review::cmd_backlog`: changed. Uses `add_reports`; prints the same JSON.
- `plugins/ok/families/ok-planner/scripts/review::cmd_noticed`: changed. Works out every report first, refusing before any write, then calls `add_reports`.
- `plugins/ok/families/ok-planner/skills/converge/SKILL.md` (backlog paragraph): changed. "It adds every report in one write, or none."

**Behavior changes**
- **B18** `scripts/tasks::cmd_item` (`--from`). Before: no such flag. After: batch add. Users: in the release: `scripts/review`. Across converged projects: the run log format is unchanged. Ruling: preserve (call).
- **B19** `scripts/review::cmd_backlog`. Before: a tracker failure on a later report left earlier reports in the ledger and printed no JSON. After: no report lands, and the verb exits 1 naming the cause. Users: in the release: the converge SKILL backlog step. Ruling: rewrite.
- **B20** `scripts/review::cmd_noticed`. Before: a noticed item with no file raised after earlier reports landed. After: it refuses before any write. Users: in the release: the converge SKILL sprint step 2. Ruling: rewrite.

### Converge converts an archived pre-v9 event log

**Calls**
- The offer id is `legacy-archive:.ok-planner/history/issues.jsonl`; it stands while any line of the archive is an event row. Decided by: the `<kind>:<path>` id rule and the `legacy-intake` sibling.
- The fold imports only the issues the log closed, as archived records. An issue the log left open was carried forward by the v9 conversion into the markdown intake, so the block lists each one and imports none. Decided by: work item 13 and `decision:closed-issues-leave-the-live-file`.
- A new flag, `issues import --over-archived-event-log`, drops the archive's event rows as the import lands; `--over-event-log` keeps its meaning for the live file. Decided by: B21 is preserve.
- An import with no records is accepted when either over-flag is set; that write only drops the event rows. Decided by: A3 (I3).
- For a closed record, `import_records` checks the archive key `(id, opened)` alone, not whether a live record uses the id, so a pre-v9 closed id a later live issue reused does not refuse the whole `legacy-archive` import. Decided by: A3 (an offer that never clears) and `decision:intake-reads-past-stray-lines`'s archive keying.

**Changes**
- `plugins/ok/families/ok-planner/admin/converge::event_log_rows`: changed. Takes the file to read: live (`LEGACY_LOG`) or archive.
- `plugins/ok/families/ok-planner/admin/converge::<archive offer builder>` and `intake_offers`: new and changed. Fold the archived rows with `folded_log`, keep the closed records, and list the derived ids and the skipped open ones.
- `plugins/ok/families/ok-planner/admin/converge` (resolve block, `legacy-archive` branch): new. Calls `import_issues(closed records, "--over-archived-event-log")`, refusing while the archive carries uncommitted changes, as `legacy-intake` does.
- `plugins/ok/families/ok-planner/scripts/issues::read_store`, `transaction`, `import_records`, `cmd_import`, `build_parser`: changed. Add the archive flag, filtering the archive's stray event rows, and accept an empty import under an over-flag.
- `plugins/ok/families/ok-planner/scripts/issues::stray_notes`: changed. The archive note says "which /ok's legacy-archive offer converts".
- `plugins/ok/families/ok-planner/admin/ADMINISTRATION.md`: changed. Adds an offer table row, and updates the Issue-intake integrity paragraph and "The pre-v9 event log" section.
- `plugins/ok/families/ok-planner/scripts/ok-planner-CLAUDE.md`: changed. Names the archived log's offer.
- `.ok-planner/review/project.md`: changed. Lists `import --over-archived-event-log`.

**Improvements**
- **I3** `scripts/issues::import_records`: accept-list A3 (a live event log whose fold yields no record gets a `legacy-intake` offer that `resolve` always refuses with "import takes one record or more", so the offer never clears). Afterward: an empty import under an over-flag drops the rows. Behavior change: B23.

**Behavior changes**
- **B21** `scripts/issues::cmd_import` (`--over-archived-event-log`). Before: no flag. After: drops archive event rows. Users: in the release: the converge core. Ruling: preserve (call).
- **B22** `admin/converge::intake_offers` and `scripts/issues::stray_notes`. Before: an archive holding event rows got no offer, and diagnose exited 0. After: a `legacy-archive` offer appears, diagnose exits 3, and the note names the offer. Users: in the release: `/ok` and the converge SKILL's precondition relay. Across converged projects: archives a v9 release wrote (stored state). Ruling: migrate: the offer converts the closed issues on the owner's yes (call).
- **B23** `scripts/issues::import_records` (I3). Before: an empty import always refused. After: accepted under an over-flag. Users: in the release: the converge core's `legacy-intake` and `legacy-archive`. Ruling: rewrite.

### Corpus deltas with no work item

**Calls**
- `decision:intake-reads-past-stray-lines`, `decision:issue-writes-through-one-module`, `decision:triage-answers-owner-messages`, and `decision:audit-audience-split` get no new annotation: their enforcing sites are payload. Existing annotations at `admin/converge` and `checks/ceremony-surfaces` stand. Decided by: `checks/materialized-standalone`.
- `decision:issue-citations-are-links` is annotated only on the page's link reader; its writers are payload. Decided by: the same check.

**Changes**
- `plugins/ok/families/ok-planner/browser/src/lib/api.js::editMessage`, `::removeMessage`, `::unrule`, `::untouched`: add `// @decision: owner-messages-can-change`, beside any existing annotation.
- `plugins/ok/families/ok-planner/browser/src/lib/api.js::flag`: add `// @decision: flagged-issues-discussed-in-session`.
- `plugins/ok/families/ok-planner/browser/src/lib/api.js::file`: add `// @decision: linked-files-open-in-place`.
- `plugins/ok/families/ok-planner/browser/src/lib/markdown.js::projectLinkAt`: add `// @decision: linked-files-open-in-place`.
- `plugins/ok/families/ok-planner/browser/src/lib/markdown.js::resolveLink`: add `// @decision: issue-citations-are-links`.
- `plugins/ok/families/ok-planner/browser/src/lib/api.js::issue`: add `// @concept: issue`.

**Behavior changes**
None. Every change is new code no existing user reaches.

### Staging notes

- Work items 1, 2, 7, and 13 all edit `admin/converge`, `admin/ADMINISTRATION.md`, and `checks/owned-paths`: chain them.
- Work items 7 and 13 both change `issues::import_records`/`transaction` and `converge::import_issues`; work item 9 also changes `scripts/issues`.
- Work items 3 and 8 share the converge SKILL "What stays outside" bullet; work items 8 and 9 share `prompts/owner-list.md`, `skills/_shared/artifact-definitions.md`, and `scripts/ok-planner-cheatsheet.md`; work item 12 also edits the converge SKILL.
- Work items 1, 7, 8, 9, and 13 each edit this project's `.ok-planner/review/project.md`.

## How to execute this sprint

This sprint is self-sufficient. Every executor — an inline session,
an agent handed this file via `/goal`, an orchestrator with its own
planning — runs the same shape: record the base commit, plan the work
into the task tracker as small build tasks cut from the
implementation notes, drain them, then run sprint certification once.
No review runs during the build.

1. Read the sprint whole first: intent, deltas, work items,
   implementation notes, completion contract. The sprint is the whole
   brief: context from the intake (`.ok-planner/issues.jsonl`) or
   `history/` may disagree with what the owner approved. Raise a gap
   with the owner.

2. Record the base. Sprint certification reads the change from this
   commit, so the tree holds nothing but this sprint's work from here
   on. The planning session leaves its own files uncommitted: this
   file, its delta sidecar, `.ok-planner/release-boundaries.md`, the
   intake's two files (`.ok-planner/issues.jsonl` and
   `.ok-planner/history/issues.jsonl`), and the sketches it archived. Where `git
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

1. Close each issue this sprint promoted: for each id that
   `.ok-planner/bin/issues list --sprint <this file's name>` prints,
   run `.ok-planner/bin/issues close <id> --as promoted`, which moves
   its record to `.ok-planner/history/issues.jsonl`.
2. Move this file, its completion report, its run file, its
   `-base.txt` file, its `-build.md` prompt, and its delta sidecar to
   `.ok-planner/history/sprints/`: `git mv` for a tracked file, `mv`
   for an untracked one.
3. Stage by name every path the sprint's change touched, every moved
   file at its new path, the `/converge` run's ledger and folder, and
   the intake's two files, `.ok-planner/issues.jsonl` and
   `.ok-planner/history/issues.jsonl`. Commit those paths alone
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
