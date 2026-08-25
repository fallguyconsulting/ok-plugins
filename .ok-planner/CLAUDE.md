# .ok-planner — the planner's directory

Materialized by ok-planner v19.4.4. Suite-owned
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
by applying an approved sprint's corpus deltas. How a commitment is
expressed may also be repaired in-cycle by the certification fix
loop, when the rules determine the compliant text and no commitment
changes; every repair is surfaced to the owner for after-the-fact
veto. `/verify-issues` repairs nothing: it names the fix in a ruling
and leaves it for a sprint. Read the corpus freely; it is not a
record.

**Leave the annotation.** Rollout is incremental and every session's
job: whenever you consult a concept, story, or decision to understand
or modify a file, leave `@concept:` / `@story:` / `@decision:` plus
the slug in a comment at the most-specific load-bearing site — the
function, branch, or block that enforces the commitment. Kind plus
slug only: no file path, no line number, no quotation. Leave an
existing annotation alone; repoint or remove one whose slug no longer
exists. Navigation is the annotations' one job: they play no part in
certification scope, and nothing computes audit invalidation.

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
document, which the ceremony runs as sonnet dispatches before the
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

`audits/{concepts,stories,decisions}/` holds one file per live
artifact, written only by the periodic `/audit` run — never by the
implementing session, never hand-edited. `audits/assumptions/` holds
the run's **assumption records**, regenerated whole each run.
**Only a running `/audit` reads or writes `audits/` and
`experiments/`.** They record behavior at the time of the audit. No
other session — a sprint's execution, the certify gate, a hotfix —
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
owner the `/goal` line naming `ceremony/audit-goal.md` once the
intent lands, and proceeds hands-free. Story support is measured from
the user's side: the maintained experiments (`experiments/`, one
directory per experiment with its `record.md`), re-run at this tree
through the public surface the extraction records — never settled by
reading or by citing a test, which may reach behind the surface. Each
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
`unaccounted: 0` and `supported` agree. Members that depart from what
accounts for them go under `## Remediation` — work for a future
sprint, never intake questions.

**An audit is a statement about a named commit.** Its `commit:` field
names the tree it describes, so whether it still holds is a git
question. Nothing tracks staleness; no audit carries citations,
hashes, or line numbers. The next run navigates by the annotation
grep.

**Every universal carries its count and its population** — the number
checked and where the set came from, refutable by a reader in
seconds.

**Two stages, no loop.** Workers are fed every live artifact —
stories and assumptions by measurement, decisions and concepts by
reading. Every escalation — `unsupported` verdicts, assumption
contradictions, corpus contradictions from the extraction, the
orchestrator's driving observations — goes to one terminal judge.
Only the `implementation:` axis escalates; a `text:` defect is
mechanical and recorded in the audit file. A confirmed gap files an
intake issue and `unsupported` stands; a confirmed assumption
contradiction files nothing — the `trap` disposition stands. The
audit corpus and the intake are independent: no `issue:` field in
either direction; a back-reference lives in issue prose. The judge is
terminal, and the run fixes nothing — a real gap is a future sprint's
work. The experiments and the project's test suites stay apart: the
experiments are the audit's instruments, they remain in its
collection, and the run never files one as a candidate test. The run writes its
report to
`history/audits/<date>-<sha>-report.md` — a record, never a channel —
commits everything, stamps the commit, and presents from the report
only when invoked à la carte, silently under `/document`. **The run
runs no validator over its own corpus:** the orchestrator dispatches,
collects, writes the report, and stamps; completion is a fact about
disk state, not a tool's exit. A malformed audit is rewritten whole
by the next run.

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
and cite catalog rows at the stamp, never source paths, tests, or
internal entry points. The **documents** — one per declared document
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

## The issue intake (`issues/`) — questions awaiting judgment

One markdown file per design question requiring the owner's judgment,
named `<YYYY-MM-DD-HHMMSS>-<slug>.md` so listings sort
chronologically. The filers: certification's architect (findings that
survive the fixer's veto test and the architect's adversarial check),
the cap's escalation (remainders the fix loop tried and failed
to fix), the periodic audit's judge (confirmed gaps and undecidable
artifacts), `/discover-design`'s bootstrap, `/plan-sprint` transcribing a question you postponed, and
humans directly. `/verify-issues` then makes each file ruling-ready:
it closes an issue the corpus already answers (with the citation) and
rewrites the rest as a from-the-top narrative ending in a marked
generated or recommended ruling. Left untouched, those rulings ride
the next `/plan-sprint`, named as batches at sign-off; edit or empty
one to override. It changes no code and no design doc: where the
rules determine the fix, the generated ruling names it and the sprint
applies it.

**Unmarked Ruling text is the owner's alone.** Write your decision
there in your own words, whenever you like; the next `/plan-sprint`
pulls every ruled issue in without re-discussing it. Agents write
only the marked generated/recommended forms, or transcribe a decision
you give live.

**Intake, not a work tracker.** An issue is a question waiting for a
ruling, never worked or tracked here. It closes two ways, both owner
acts recorded through `/plan-sprint`:

- **Promoted** — the resolution is carried into a sprint as a corpus
  delta, a work item, or both, and the file is stamped with that
  sprint's filename. The sprint is then the source of truth: nothing
  re-opens the issue, and no agent reads the file to learn what a
  promoted issue meant. The file moves to `history/issues/` when the
  sprint's implementation closes.
- **Retired** — the owner drops the question; the file moves to
  `history/issues/` at once.

A promoted decision that later proves wrong is a new issue with a new
file.

Open issues gate the work they bear on, not all work. A
`/plan-sprint` planning new work pulls the ruled issues in first,
drafts, then resolves with the owner every unruled open issue that
bears on the draft — building over such an issue would decide it
silently. Independent issues stay open for a later sprint. A sprint
convened to work the intake takes it, or a named batch, as its
agenda.

`/verify-issues` converts a legacy `issues.jsonl` (open rows become
files; the log archives to `history/issues.jsonl`). Never edit its
rows.

## Project records (`sprints/`, `sketches/`, `history/`) — out of context by default

The record discipline: records are committed, versioned parts of the
project, out of agent context by default, with one live exception —
the sprint currently being executed. Every completed or retired
record moves to its same-named folder in the archive.

`sprints/` holds sprints from `/plan-sprint`. `sketches/` holds
sketches from `/sketch` — speculative future thinking. `history/`
holds one archive folder per artifact kind (`sprints/`, `sketches/`,
`issues/`, and on migrated projects `specs/`, `plans/`, `coverage/`,
`tensions/`), preserved indefinitely.

- Do not consult these files to understand the project; the codebase
  and `design/` are the source of truth.
- Do not include them in general repository exploration.
- Do not propose updating, refreshing, or reconciling them with the
  code; drift is expected.
- Do not edit, rename, move, or delete files here on your own
  initiative.

Read or touch them only when the user asks or an ok-planner skill
directs it. Do exactly what was asked, then stop.

## Lifecycle summary

`/sketch` captures an unplanned idea in `sketches/` — single-pass,
speculative, no authorization to build. When the idea is taken up
through `/plan-sprint`, the sketch moves to `history/sketches/`.

`/plan-sprint` produces a sprint in `sprints/`: final-form corpus
deltas, work items, and a fixed completion contract, with the open
issues that bear on the work resolved by the owner in-session and
promoted in. The approved sprint ends planning and is from then on
the source of truth for that work.

`/document` runs at a release: it ensures a current audit — reusing
one only when the tree has moved past its stamp on the audit's own
output paths alone, running `/audit` otherwise — settles the document
types in the documentation walk, constructs the commit-stamped corpus
in `documentation/` from the audit's records, then generates one
self-contained document per declared type and places it at the type's
target with a provenance stamp. It measures nothing and files only
for a type left unsettled in the walk.

## Executing a sprint

**The sprint document is the brief.** Every sprint carries a fixed
"How to execute this sprint" section: read the sprint whole, stage
the items into the completion report's opening `## Stages` section (a
sprint is never rewritten into a plan document; the harness task
tools, where available, mirror that list one task per stage as
display), apply deltas verbatim with the work, test what you build,
work unsupervised to the contract, and keep the **completion
report** current — the file beside the sprint (same filename with
`-completion`) recording work done, divergences, and every fork
claimed with its options and the reading built. Follow that section;
nothing here overrides it. "Implement sprint X" is an ordinary
working session — inline, a fan-out of subagents, or an external
orchestrator all owe the same completion contract — so a sprint can
be handed to the native goal mechanism (`/goal <path-to-sprint>`).

**Execution is a team the session relays.** The session dispatches
one **builder** (`opus`) and feeds it one stage per message: it
writes the code, applies the stage's deltas, tests what it built,
keeps the report, and fixes the reviewer's findings in its own
context. The session dispatches one **standing reviewer** (`opus`)
under the certification core's standing-reviewer brief and feeds it
each landed stage's paths and work items: it reads the increment
under the same code-review brief the gate runs cold, findings
reaching anywhere in the tree the increment breaks, and the gate's
alignment questions scoped to the stage's own items and deltas,
plus the read-only per-stage producers each family's ceremony
contribution names under **Standing producers**, and keeps a ledger
of open findings. The session
relays and holds the ledger. It opens the completion report with the
staged list before the build and marks the closing stages after the
team retires; during the build it edits no file a worker owns. On
every relay it writes the open ledger and the open claimed forks to
the sprint's ledger file beside the report. A worker retires only at
a stage boundary, inside a band of roughly 300k to 500k tokens of
measured context on a 1M-token window; at each boundary the session
projects the next stage's cost and hands it over only when the
worker will still retire inside the band. A replacement builder
reads the sprint and the report, a replacement reviewer reads the
ledger file. The builder never files an issue: it makes every determined
call and records it, and records a genuine fork with its options,
building the reading it judges most plausible. Code complete means
the built work works and the reviewer's ledger is empty.

**`/certify-work` closes, cold, immediately after.** Named as the
terminal step in the sprint's boilerplate, it is the regression and
discharges the completion contract at the change's scope: the
sprint-alignment judge (deltas verbatim, no undershoot, changed
corpus coherent, the report's divergences under the veto test and
its claimed forks routed to the architect), the project's test
suites, and one code review over the whole diff by a reviewer
holding no history and blind to the report, all feeding a
no-discretion review-fix loop — standing agents fed by message over
rounds, a finding ledger the orchestrator keeps, and an exit at the
first round in which neither the fixer nor the architect edited any
file (code, corpus, or the report's `## Divergences`). Two paths
reach the intake: architect-confirmed intent forks and the remainders
escalated at the cap, both made ruling-ready by `/verify-issues`. The
presentation is written into the completion report and walked with
the owner, ending with the offer to archive the sprint (with its
report) and commit the work: owner acts, taken only on the owner's
word, the sprint left at its `sprints/` path until then. A goal keyed
to the sprint follows the contract's goal rule: done when the sprint
is archived with its `closed:` stamp, or when every contract item —
the finished completion report included — verifies against the
repository. A run parked at the review-fix loop's cap awaiting the
owner's direction is a legal in-flight state: not done, not failed,
never grounds for the run to take either cap step itself.
The close-out stamps the archived sprint with the closing commit
(`closed: <sha>` frontmatter, one follow-on commit) — the baseline
the next `/plan-sprint` reads to reconcile work done out of band.
The gate never audits: whether the corpus's claims still hold is
`/audit`'s question, on the owner's cadence, never at a close.
