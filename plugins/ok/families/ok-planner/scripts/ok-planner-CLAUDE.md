# .ok-planner — the planner's directory

Materialized by ok-planner v{{OK_PLANNER_VERSION}}. Suite-owned
boilerplate: this file is overwritten wholesale by the front door's
administration (`/ok`); do not hand-edit it (project guidance belongs
in the project's root CLAUDE.md).

This directory holds several kinds of content with different lifecycles
and different rules for how agents should treat them.

## Durable design docs (`design/`) — source of truth, read freely

The project's canonical durable model, three catalogs, each
self-contained:

- **`concepts/`** — load-bearing nouns with definitions, purposes,
  boundaries, and invariants.
- **`stories/`** — durable user expectations, each one agile-style
  statement of user need (`As <role>, I want <capability>,
  so that <benefit>` — the "so that" clause is mandatory) and
  nothing else: a pure expression of business value whose only
  acceptance is that the user has a way to do the capability and
  accomplish the benefit — stated concretely, so a reader can settle
  it by looking. Verification is the periodic implementation audit's:
  it reports whether the codebase supports the story at a named
  commit.
- **`decisions/`** — durable technical decisions (choice, rationale,
  alternatives). Whether an implementation honors a Choice is
  determined by its implementation audit under `audits/decisions/`,
  written by the periodic audit run.

**A note on the name `design/`.** The directory name is a label, not
a load-bearing claim about content. "Design" here is the project's
durable identity/model — the high-level, general framing of what the
project is and what it owes its users. It is NOT a place for
*specific* designs: interface grammars, route shapes, schema details,
implementation diagrams. Those live in code, in `sprints/`, and in
other project documentation.

Code references the design (via `@concept:`, `@story:`, `@decision:`
annotations at points of enforcement), not the other way around. The
design docs are **a source of truth with the same weight as code**:
they describe the project as it stands. What the project *commits
to* — its concepts' invariants, its stories' promises, its
decisions' choices — changes only by applying an approved sprint's
corpus deltas, never ad hoc. How a commitment is *expressed* may
also be repaired in-cycle by the certification fix loop, when the
rules fully determine the compliant text and no commitment changes
(a stale TOC line, a stale sentence the code and a counterpart
artifact both contradict); every such repair is surfaced to the
owner for after-the-fact veto. `/verify-issues` repairs nothing —
it names the fix in a ruling and leaves it for the sprint. Read the
docs freely; they are NOT an out-of-context record.

**Leave the annotation.** Annotation rollout is incremental and it is
every session's job, not a bulk pass anyone runs: any time you consult
a concept, story, or decision to understand or modify a file, leave
`@concept:` / `@story:` / `@decision:` plus the slug in a comment at
the most-specific load-bearing site in that file — the function,
branch, or block where the artifact's commitment is actually
enforced — so the next agent greps instead of re-deriving. Kind plus
slug only: never a file path, a line number, or a quotation of the
artifact. If the site already carries the annotation, leave it alone;
if the slug it names no longer exists, repoint or remove it.
Annotations carry exactly one job — this navigation — and play no part
in certification scope: what a change puts in question is read from the
change itself. Nothing computes audit invalidation at all, so nothing
can key on a tag.

## The public surface (`surface/`)

`surface/surface.md` is the **surface intent** — the prose document
naming what the product's user-facing surface is meant to be: which
classes of element are public by default (the CLI verbs, the HTTP
routes, the published env vars, the config keys under a named
prefix, the ports the deployment exposes) and which specific
elements depart from those rules. General rules with named
exceptions. Produced and maintained in the audit's **interactive
intent stage** — an à la carte run's one owner walk, a short
class-level conversation ("every CLI verb is public", "the foobar
module is user-facing", specific exceptions where they exist) that
lands the document — and freely edited by the owner between audits. Once
landed, each audit's autonomous portion dispatches a **surface
extractor subagent**: it reads the intent, walks the code and
deployment configuration purpose-bound to classification, and writes
the **surface extraction** to `audits/surface/extraction.json` — one
entry per element found, kind discovered by the walk (never
pre-declared), each entry naming the intent rule that placed the
element public or internal. Elements the intent still does not
clearly settle are defaulted internal for the run and filed as
intake issues asking the owner to amend the intent (the safety net
for residual drift the interactive conversation could not
enumerate). No downstream owner walk beyond the interactive stage
— except the documentation walk below, when `/document` composed the
run — no reconciler tool, no committed member lists, no stamped
ruling, no guidance-hash comparison. The extraction is committed
with the audit corpus and stamped with the closing commit — a
per-run record whose freshness is a git question anyone can answer.

`surface/documents/<slug>.md` are the **document types** — one
owner-authored file per document a release ships: what the document
is for, its audience (`public` — the user's vantage, naming only
public elements in the shipped vocabulary; or `developer` — the
contributor's or operator's, free to name internal elements,
scripts, and paths in the tree), the classes of surface it covers
(classes, never elements), and the target path in the tree where the
documentation ceremony places it (a file, or a folder when the path
ends in `/`).
The set of types is the project's generative corpus for
documentation — the declaration of what to produce, never the
produced text — and **all documentation is typed**: every document
the tree carries (the root `README.md`, any `README.md`, everything
under `docs/`, tutorials, example walkthroughs, guides) is one type's
product, regenerated whole at every release; there is no hand-written
document. Settled in the **documentation walk**: a short owner
conversation over the extraction's public side and the tree's
documents against the declared types that raises only the deltas (a
public class no type covers, a type whose classes came back empty, a
document in the tree no type produces; a starter set on an empty type
set), lands what the owner approves, and files an intake issue for a
type left unsettled (left out for the run). The walk runs inside the
audit right after its extractor returns when `/document` invoked the
audit, and inside `/document` against a reused audit's extraction
otherwise; an à la carte `/audit` never runs it. No autonomous stage
writes a type; the owner edits the files freely between runs. Read a
type as owner intent, like the surface intent beside it.

## The audit corpus (`audits/`)

`audits/{concepts,stories,decisions}/` holds one file per live concept,
story, and decision, written only by the periodic `/audit` run — never by
the session that implemented the work, never hand-edited — and
`audits/assumptions/` holds the run's own **assumption records**,
regenerated whole each run. Each audit is a
good-faith, adversarially-minded answer to **two independent
questions**: *does the artifact's text comply with its own authoring
rules?* and *does the codebase support what it claims, at this
commit?* The `implementation:` axis is one of two words — `supported`,
`unsupported`; the `text:` axis is one of two — `compliant`,
`noncompliant`, with a `## Compliance` section naming the rule broken.
Both are recorded because they come apart: a malformed artifact may be
accurately implemented, and a well-formed one implemented nowhere. The
body is one sentence to one paragraph saying what was looked at and
what was found.

**The run makes four determinations, and the support instrument
differs by kind.** It opens with the **interactive intent stage** —
an à la carte run's one owner walk, a short class-level conversation
that produces or updates `surface/surface.md`; a run `/document`
invoked adds the documentation walk right after the extractor
returns, and no other. Once the intent is landed,
the autonomous portion dispatches a surface extractor subagent that
reads it, walks the code and deployment configuration, and writes
this run's `audits/surface/extraction.json`, filing intake issues
for elements the just-landed intent still does not settle
(defaulted internal for the run). A run invoked à la carte hands
the owner the `/goal` line naming `ceremony/audit-goal.md` **once
the interactive stage lands the intent**, so everything after is
driven hands-free. Story support
is then measured **from the user's side**: the maintained
experiments (`experiments/`, one directory per experiment with its
`record.md`), re-run at this tree and driven through the public
surface the extraction records — never settled by reading or by
citing a test, which may reach behind the surface. Conclusions never
carry: an archived experiment warrants nothing until re-run at the
stamp; the runnables carry as instruments, re-run, repaired,
extended, and retired each run. Once the story verdicts land, the run
synthesizes its **assumptions** — user-vantage priors formed by one
cold, boxed agent from user-visible material alone — and measures
each on the same instrument, closing every record with a
disposition: `held`, `trap`, or `unverified`. A contradicted
assumption is documentation, never a fix issue. Decision and concept
support keeps the adversarial reading — their claims live behind the
surface, where no user-vantage run can see.

**Where an artifact claims a whole enumerable population, the
implementation verdict takes the coverage shape.** The frontmatter carries
`checked:` (the population enumerated from reality) and `unaccounted:`
(the members nothing accounts for), and every unaccounted member is
named under `## Unaccounted`; `unaccounted: 0` and `supported` mean the
same thing. Members that depart from what accounts for them go under
`## Remediation` — they are work for a future sprint, never questions
for the intake.

**An audit is a statement about a named commit.** Its `commit:` field
names the tree it describes, so asking whether it still holds is a git
question — how far has `HEAD` moved since — rather than a computation.
Nothing tracks staleness, nothing invalidates anything, and no audit
carries citations, hashes, or line numbers. What the next run navigates
by is the `@concept:` / `@story:` / `@decision:` annotations in the
code, which is the one job annotations have.

**Every universal carries its count and its population.** A quantified
claim is only worth asserting if someone enumerated the members, so an
audit reports the number it checked and where the set came from — a
sentence a reader can refute in seconds — instead of a vague
assurance.

**Two stages, no loop.** Workers are fed every live artifact —
stories and assumptions by measurement, decisions and concepts by
reading. Every escalation — the `unsupported` verdicts, the
assumption contradictions, the corpus contradictions the extraction
surfaced, and the orchestrator's own driving observations — goes to
one terminal judge. A confirmed story gap files an intake issue by
the ordinary intake conventions and `unsupported` stands; a confirmed
assumption contradiction files nothing — the `trap` disposition
stands, and it is documentation, not work. Only the `implementation:`
axis escalates — a `text:` defect is mechanical by construction, so
it is recorded in the audit file. The audit corpus and the issue
intake are independent by construction: an audit carries no `issue:`
field in either direction, and any back-reference lives in issue
prose. The judge is terminal: nothing comes back for another pass,
and the run never fixes anything — a real gap is a future sprint's
work. Experiments the run had to build, passing at the stamp, are
**nominated** through the intake; adopting one into the project's
suites is a sprint's work on the owner's ruling. The run then writes
its report to `history/audits/<date>-<sha>-report.md` — a record,
never a channel — commits everything, stamps the commit, and presents
from the report only when invoked à la carte, silently under
`/document`. **The audit run runs no validator over its own corpus:**
the orchestrator dispatches, collects, writes the report, and stamps;
no shape checker sits in its hand, and its completion is a fact about
disk state, not a tool's exit. Where an artifact's audit is malformed,
the next run rewrites it whole from a fresh read — drift self-corrects,
and no in-run judgment weighs a checker's output against the run's
own claim to be done.

**Subjective promises become referrals, never verdicts.** Where
an artifact promises something whose quality only a human discipline
can judge, the audit records the promise, what exists in form, and the
discipline that owns the judgment — and opines no further. A concrete
story avoids the situation: correct, clear, and helpful describe how
well the product owes something, not what it owes.

## The documentation corpus (`documentation/`) — a release snapshot

`documentation/` holds the corpus the `/document` ceremony produces at
a release, split along the vantage line — constructed from the
audit's records; the ceremony measures nothing. The **publishable
layer** has two tiers. The **records** — catalog rows over the
extraction's public side, assessments whose held claims cite the
audit's passing experiments driven through the public surface, traps
(reasonable user assumptions the product contradicts, read from the
audit's trap dispositions), and a concept router — speak only the
shipped vocabulary and cite catalog rows at the stamp, never source
paths, tests, or internal entry points. The **documents** under
`documentation/documents/` — one per document type declared under
`surface/documents/` — are self-contained texts a writer produced
from the type at the release, oriented by the records and verified
against the tree at the stamp: no record citations, no warrant
state, opening with a provenance stamp; each is also **placed** at
its type's target in the tree (`docs/...`, the root `README.md`),
beside a `docs/CLAUDE.md` carrying the record rule when any type
targets `docs/`. Only declared targets are written. The
**verification layer** — trap evidence sets under
`documentation/evidence/`, with the surface extraction, the audit's
records, and the experiments where the audit keeps them — stays
internal and cites the tree freely. Every record and document is
stamped with the release commit it describes.

**A snapshot, never a source of truth.** The corpus follows the record
discipline — the placed documents outside the estate included: out of
agent context by default, never consulted to understand the current
tree, never reconciled or refreshed by day-to-day sessions, and
expected to go stale as the tree moves. A placed document's
provenance stamp is its only staleness marker; an agent that finds
one behind the tree files nothing and marks nothing, and reads it
only when the owner directs it there. Each `/document` run overwrites
the corpus and the placed set whole — nothing tracks staleness and no
conclusion carries forward; the prior release's published corpus
feeds the audit's assumption synthesis, never a cache of conclusions,
and the experiments carry as instruments only. **The documentation
run runs no validator over its own corpus:** the ceremony's writers
produce the corpus, and the orchestrator presents and stamps the
closing commit; nothing sits in its hand with a pass/fail exit. Where
a produced corpus is malformed, the next release's `/document` run
rewrites it whole; drift self-corrects. Shipping the publishable
layer is a separate publisher's act, not the ceremony's; the
verification layer never ships.

## The issue intake (`issues/`) — questions awaiting judgment

One markdown file per design question requiring the project owner's
judgment, named `<YYYY-MM-DD-HHMMSS>-<slug>.md` so listings sort
chronologically. Filed by certification's architect (the gated
path — a finding from the repeating close cycle must survive the
fixer's veto test and the architect's adversarial check), by the
cycle cap's escalation (the second gated path — the remainders a
bounded fix loop tried and failed to fix), by the periodic audit's
second-opinion judge (the third — confirmed gaps and undecidable
artifacts; a confirmed assumption contradiction files nothing, it
stands as a trap disposition), by the audit run's distillation (the
fourth — only nomination candidates: experiments the run had to
build, passing at the stamp, worth maintaining), by
`/discover-design`'s one-time bootstrap run, by `/plan-sprint`
transcribing a question you postponed, or by humans directly;
`/verify-issues` then makes each file **ruling-ready**: it closes
any issue the design corpus already answers (with the citation) and
rewrites the rest as a single from-the-top narrative ending in a
marked generated or recommended ruling — left untouched, those ride
the next `/plan-sprint` as rulings, named as batches at sign-off;
edit or empty one to override. It changes no code and no design
doc: where the rules fully determine the fix, the generated ruling
says so and names the fix, and the sprint applies it.

**Unmarked Ruling text is the owner's alone.** Write your decision
there in your own words, whenever you like; the next `/plan-sprint`
pulls every ruled issue into the sprint it plans without
re-discussing it. Agents write only the marked generated/recommended
forms — or transcribe a decision you give live.

**Intake, not a work tracker.** An issue is a question waiting for a
ruling. It is never worked or tracked to completion here — it closes
exactly two ways, both owner acts recorded through `/plan-sprint`:

- **Promoted** — the resolution is carried into a sprint as a corpus
  delta and/or work item, and the file is stamped with that sprint's
  filename. The sprint is then **the** source of truth for the work.
  The issue is settled and out of consideration: nothing re-opens it,
  nothing checks back on it, and no agent reads the issue file to
  learn what a promoted issue meant — whatever the work needs is in
  the sprint. The file moves to `history/issues/` when the sprint's
  implementation closes.
- **Retired** — the owner drops the question. Nothing is carried
  anywhere; the file moves to `history/issues/` immediately.

If a promoted decision later turns out wrong, that is a *new* issue
with a new file, not a revival of the old one.

Open issues gate the work they bear on, not all work. A `/plan-sprint`
planning new work pulls the ruled issues in first, drafts, then
resolves — with the owner — every unruled open issue that bears on
the draft, because building over such an issue would decide it
silently. Issues the sprint's work neither touches nor presumes an
answer to stay open, untouched, for a later sprint. A sprint whose
stated purpose is working the intake takes it (or a named batch of
it) as its agenda instead.

A legacy `issues.jsonl` from an older layout is converted by
`/verify-issues` (open rows become files; the log archives to
`history/issues.jsonl`). Never edit its rows.

## Project records (`sprints/`, `sketches/`, `history/`) — out of context by default

The record discipline, stated once: records — sprints, sketches, and
the archive — are committed and versioned parts of the project but
out of agent context by default, with exactly one live exception (the
sprint currently being executed), and every completed or retired
record moves to its same-named folder in the archive.

`sprints/` holds sprints from `/plan-sprint`; a sprint is in context
only while it is the work being executed. `sketches/` holds design
sketches from `/sketch` — speculative or in-progress future
thinking; reading one without a directing goal is context pollution.
`history/` holds a same-named archive folder per artifact kind
(`sprints/`, `sketches/`, `issues/`, and on projects migrated from
older layouts also `specs/`, `plans/`, `coverage/`, `tensions/`):
completed or retired artifacts move there and are preserved
indefinitely.

- **Do not consult these files to understand the project.** They
  reflect a moment in time. The codebase and `design/` are the
  source of truth.
- **Do not include them in general repository exploration** or "how
  does this project work" research.
- **Do not propose updating, refreshing, or reconciling them** with
  the current state of the code. Drift between an old sprint and
  the current code is expected and fine.
- **Do not edit, rename, move, or delete files here on your own
  initiative**, even if they look stale.

Read or touch them only when the user explicitly asks, or when an
ok-planner skill directs it (e.g. `/plan-sprint` writing a new sprint to
`sprints/`, or an executing session archiving a completed one to
`history/sprints/`). Do exactly what was asked, then stop.

## Lifecycle summary

`/sketch` captures an unplanned idea in `sketches/` — single-pass,
speculative, no authorization to build; when the idea is taken up
for real it flows through `/plan-sprint`, and the sketch moves to
`history/sketches/`.

`/plan-sprint` produces a sprint in `sprints/`: final-form corpus
deltas + work items + a fixed completion contract, with the open
issues that bear on that work resolved by the owner in-session and
promoted into the sprint. The approved sprint is where planning
stops — and from then on it, not the queue, is the source of truth
for that work. Executing it is the next section.

`/document` runs at a release: it ensures a current audit — reusing
one whose stamped commit the tree has moved past only on the audit's
own output paths, running `/audit` otherwise — settles the document
types in the documentation walk (inside the composed audit right
after its extractor returns, or against a reused audit's extraction),
constructs the commit-stamped split corpus in `documentation/` from
the audit's records — the catalog projected over the extraction's
public side, assessments from the story and assumption
determinations, the trap registry from the assumption dispositions —
then generates one self-contained document per declared type and
places it at the type's target in the tree with a provenance stamp.
It measures nothing, and files only for a type the owner left
unsettled in the walk; the audit's judge and distillation filed its
issues and nominations before this run consumed the records.

## Executing a sprint

**The sprint document is the brief — its own "How to execute this
sprint" section is the execution shape.** Every sprint `/plan-sprint`
produces carries that fixed section: read whole, stage into the
completion report's opening `## Stages` section (a sprint is never
rewritten into a plan document),
apply deltas verbatim with the work, test as you build, work
unsupervised to the contract, and keep the sprint's **completion
report** current — the file beside the sprint (same filename with
`-completion`) recording work done, divergences, and calls made,
which the closing ceremony finishes and the completion contract
requires. Follow it; nothing here overrides it.
"Implement sprint X" is an ordinary working session, not a special
mode — inline, a fan-out of subagents, or an external orchestrator
all owe the same completion contract and nothing else, so a sprint
can equally be handed to the native `goal` mechanism
(`/goal <path-to-sprint>`).

**`/certify-work` closes.** Named as the terminal step in the
sprint's own boilerplate, it discharges the completion contract at
the change's scope: the sprint-alignment judge (deltas verbatim,
no undershoot, changed corpus coherent), the project's own test
suites, code review over the diff — all feeding
a no-discretion review-fix loop (fixer, then an architect on
kickbacks; the issue intake is reached only by the two gated
paths — architect-confirmed intent forks, and the remainders
escalated at the cycle cap — both made ruling-ready by
`/verify-issues`) — then the
presentation, written into the sprint's completion report and
walked with the owner, which ends by offering to archive the sprint
(together with its report) and commit the work: owner acts, taken
only on the owner's word, with the sprint left at its `sprints/`
path until then. A goal keyed to the sprint follows the contract's
own goal rule: done when the sprint is archived with its `closed:`
stamp, or when every contract item — the finished completion report
included — verifies against the repository; a run parked at the
review-fix loop's cycle cap awaiting the owner's direction is a
legal in-flight state — not done, not failed, and never grounds for
the run to take either cap step itself. The close-out finishes by stamping
the archived sprint with the closing commit (`closed: <sha>`
frontmatter, one follow-on commit) — the baseline the next
`/plan-sprint` reads to detect and reconcile work done out of band
since this close. The gate never audits: whether the corpus's
concepts, stories, and decisions are still supported by the codebase is
`/audit`'s question, asked over the whole corpus on the
owner's cadence — before a release, after several sprints, when
drift is suspected — and never at a close.
