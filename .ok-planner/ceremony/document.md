# ok-planner — documentation ceremony contribution

What the suite's release-documentation ceremony does about this
family's estate. The ceremony owns the spine — audit, walk, project,
assess, distill, generate, present, close out; this file owns
everything ok-planner contributes to it, including the documentation
walk the audit calls when `/document` composed it. Materialized into consumer projects at
`.ok-planner/ceremony/document.md`; the ceremony reads it there when
`.ok-planner/` exists.

## Requires

`.ok-planner/design/` at the project root — the story catalog is what
the assessments describe. Without it there is nothing to document
against: say so and point at `/discover-design`.

A **current audit**. The audit is the ceremony's entire measurement
front (`decision:document-composes-audit`): it dispatches a surface
extractor subagent that writes the run's surface extraction,
determines story support from the user's side, determines decision
and concept support from the technical side, and forms and verifies
the assumptions in its own boxed synthesis. The audit is current for
this release exactly when the tree's movement since its stamped
commit touches only the audit's own output paths (the path-scoped
rule its ceremony contribution states); otherwise the ceremony runs
`/audit` first. The surface intent
(`.ok-planner/surface/surface.md`) is the audit's requirement, read
there, not here.

The **document types** under `.ok-planner/surface/documents/`, per
`concept:document-type` — one file per document the release ships.
They are settled in the documentation walk (Walk below), so a
project with none is not blocked: the walk proposes a starter set
from the extraction and lands what the owner keeps.

## Layout

`mkdir -p .ok-planner/documentation/catalog .ok-planner/documentation/assessments .ok-planner/documentation/traps .ok-planner/documentation/evidence .ok-planner/documentation/documents .ok-planner/surface/documents`.
Estate convergence is the front door's administration (`/ok`), never
this run's.

`.ok-planner/documentation/` is the corpus's home, beside `audits/`
(`concept:documentation-corpus`), and it carries a **record's
discipline**: out of agent context by
default, never consulted to understand the current tree, never
reconciled or refreshed by day-to-day sessions. The run overwrites it
whole; prior corpora live at their release tags. The documents the
run places outside the estate — under `docs/`, at the root
`README.md` — carry the same discipline
(`decision:placed-documents-are-records`): their provenance stamp is
their only staleness marker, and an agent that finds one behind the
tree files nothing and marks nothing.

The layout is split along the vantage line
(`decision:documentation-citations-are-product`):

- **Publishable** — `catalog/`, `assessments/`, `traps/`, and the
  concept router `concepts.md`. These speak the shipped vocabulary —
  concepts, stories, and public surface elements — and cite only
  catalog rows at the stamp: `catalog:<kind>/<member>`. A source path,
  a test, or an internal entry point does not belong in a publishable
  record; the writers keep tree citations to the verification layer.
- **Verification layer** — `evidence/` (trap evidence sets) here; the
  surface extraction under `.ok-planner/audits/surface/`, the audit's
  determinations and assumption records under `.ok-planner/audits/`,
  and the experiments under `.ok-planner/experiments/` where the audit
  keeps them. Internal, never shipped; these cite the tree freely
  (`src:<path>` meaning that path **at the stamped commit**, checked
  once at production, never re-verified against the moving tree).
- **Documents** — `documents/<slug>.md`, one per declared type, the
  copy of record; each is also placed at its type's target in the
  tree. Publishable, self-contained, outside the citation rule: a
  document cites no record and no path.

## Audit

The audit's determinations set the delivery criterion: **only stories
the audit called `supported` are documented as delivered.** An
unsupported story is already an intake issue, not deliverable
documentation. The surface extraction
(`.ok-planner/audits/surface/extraction.json`) defines the catalog
domain: its public side, unconditionally — every public element is
cataloged whether or not any story claims it, so absence is
answerable. The assumption records under
`.ok-planner/audits/assumptions/` arrive carrying their
dispositions — held, trap, or unverified — measured by the audit;
this run re-measures none of them. The boxed synthesis that formed
them is the audit's machinery, with its own input rules, and it does
not run here.

## Walk

The **documentation walk** settles the document types
(`decision:documentation-walk-in-composed-audit`). It is one body
with two call sites: the audit calls it immediately after its
extractor returns, when `/document` invoked the audit; `/document`
calls it as its Walk step, against a reused audit's extraction, when
the audit was current and not repeated. Either way it runs once per
release, before construction, and it is the release run's one owner
conversation. An à la carte `/audit` never calls it.

### The document type

One file per type at `.ok-planner/surface/documents/<slug>.md`, prose,
owner-authored, walk-maintained, freely edited by the owner between
runs:

```
---
document: <slug>
target: <path in the tree — a file, or a folder when it ends in `/`>
---
# <Title the placed document carries>

## Purpose
<What the document is for, in a few sentences: who opens it and what
they should be able to do when they close it.>

## Covers
<The classes of public surface the document covers, one per line, in
the extraction's kind vocabulary where a kind exists — "every public
CLI verb", "the published environment variables", "the HTTP routes
under /api". Classes, never elements: a list of verbs is the
extraction's job and would drift.>
```

Three things and nothing else: purpose, covered classes, target. No
outline, no generated text, no citations, no warrant state — the type
declares what to produce, never the produced text. A folder target
(`docs/examples/`) tells the writer to produce a set under that
folder; a file target names the one file.

### Inputs

- `.ok-planner/audits/surface/extraction.json` — the public side
  only, grouped by kind. Internal elements are invisible to the walk.
- Every file under `.ok-planner/surface/documents/`.
- The tree, only to note whether a proposed target already exists.

### Compute the deltas, and raise only those

Read the extraction's public side against the declared types and
compute:

- **Uncovered classes** — a public kind in the extraction that no
  type's Covers names. Propose one type per uncovered kind: a
  reference for that kind, slug from the kind, target under `docs/`.
- **Empty types** — a declared type whose covered classes returned
  no public element in this extraction. Propose keeping it (its
  classes may be public next release), narrowing it, or dropping it.
- **Nothing** — every public kind is covered and no type is empty.
  Say so in one line ("document types: N declared, all covered,
  nothing to settle") and ask nothing. Agreement passes in silence.

**On an empty type set** — a project with no files under
`surface/documents/` — propose a **starter set** from the
extraction: one reference per public kind found, and one leading
document for the whole (proposed at the root `README.md` when no
file exists there, at `docs/README.md` otherwise). The owner keeps,
drops, renames, or retargets each; nothing lands that they did not
approve.

Where a proposed target already exists in the tree without a
provenance stamp, say so in the same line — the owner is declaring
that a generated document replaces a hand-kept file, and they should
know it. Never propose a target outside the repository.

### Ask, land, and move on

Put the deltas to the owner in **one message**: a tight list, one
line per delta with the proposed type (slug, purpose in a phrase,
classes, target). Take their answer — keep, drop, rename, retarget,
reword — and land every approved type as a file in the shape above,
showing the diff. Ask questions in prose; never through a form. Do
not open other topics here: driving observations and audit findings
belong to the audit's report and judge.

A type the owner leaves **unsettled** — no answer, or "not sure" — is
**left out for the run** (no file, no document this release) and
filed as one intake issue per `{{ISSUE-FILE-FORMAT}}` from
`.claude/skills/_shared/artifact-definitions.md` (category `unclear`),
asking the owner to declare or decline it. The walk does not stall on
it. Nothing else in the walk files.

**No autonomous stage writes a type.** The walk lands what the owner
approves, in conversation; between runs the owner edits the files
directly. Once the walk lands, hand the owner the release run's goal
line — the run proceeds hands-free from there, whether or not they
set it:

```
/goal the documentation run described in .ok-planner/ceremony/document-goal.md is complete — every term of its goal rule verifies against this repository
```
 Where the audit's close-out commits, the types the walk
landed ride the audit's first commit; where `/document` ran the walk
itself, they ride the corpus commit.

## Project

Catalog files at `documentation/catalog/<kind>.md`, one per declared
kind:

```
---
kind: <kind>
release: <commit>
population: <public members the extraction holds for this kind>
---
```

Then one row per **public** member — `` - `<member>` — <one line> ``,
naming the assessments that measure it where any do. The rows match
the extraction's public side one-to-one; `population:` is the count
the writers hold them to. A kind with no public members writes its
file with `population: 0` and no rows. Internal members appear
nowhere in the publishable layer.

The router at `documentation/concepts.md` lists the published
concepts — slug and one line each — pointing the reader into the
concept bodies the audit's synthesis box also saw.

## Assess

Construction, not measurement: one assessment record per way the
audit measured — a story-way warranted by the audit's story
determinations, an assumption by its record's disposition — composed
from the audit files under `.ok-planner/audits/`, the assumption
records, and the experiments' `record.md` observations. This run
drives nothing through the surface.

The record shapes. One assessment per measured way, at
`documentation/assessments/<subject>--<way>.md`:

```
---
assessment: <subject>--<way>
subject: story:<slug> | assumption:<slug>
way: <way-slug>
release: <commit>
outcome: held | unverified
warrant: experiment:<slug> | none
---
```

The body records what the audit ran, what was observed, and the
**unverified remainder** — stated in the record, never left silent —
in the shipped vocabulary, citing catalog rows. An `outcome: held`
requires an `experiment:` warrant — a passing experiment the audit
drove through the public surface at the release; a reading is never a
warrant, a failed run is never a warrant, and the project's tests are
never warrants for user-vantage claims (`warrant: none` is legal only
with `outcome: unverified`). A story the product honors through
several ways carries several assessments; the demonstrated path is
the product of the record, the outcome a byproduct.

**The attestation rule.** Published silence about an assumption is
honest only because a record attests the measurement: every
assumption the audit synthesized ends the run holding an assessment
record (held or unverified) or a trap record — never nothing.

**Story defects and fitness are the audit's findings, not this
run's.** A story the product contradicts is `unsupported` in the
audit, already an intake issue from its judge; a story that cannot be
measured as written is likewise `unsupported`, its paragraph naming
what the story leaves undecidable, and the judge files against that.
This run consumes those verdicts — it documents the supported stories
and files nothing about the rest.

## Distill

Trap records at `documentation/traps/<slug>.md`, one per assumption
record the audit closed with `disposition: trap`:

```
---
trap: <slug>
release: <commit>
demonstration: experiment:<slug> | none
---
## Assumption
## Actual behavior
```

The shipped trap record speaks in surface terms: the assumption, the
actual behavior, and — where the audit demonstrated the actual
behavior through the public surface — the passing demonstration
experiment, which is the evidence set's strongest member. The full
**evidence set** that warrants the contradiction lives at
`documentation/evidence/<slug>.md` (frontmatter `trap:`, `release:`),
composed from the audit's records and observations, may rest on
reading, cites the tree freely, and never ships. A trap never rests
on a failed run alone; a failed runnable may be attached to the
evidence set as corroboration, never as the warrant.

**Filing: none from construction.** Construction files nothing at
all (`decision:audit-audience-split`): nomination candidates — the
experiments the audit had to build, passing at the stamp — were filed
by the audit's own distillation, and contradicted promises by its
judge, before this run consumed the records. The one filing this
ceremony makes is the walk's — an intake issue per document type the
owner left unsettled — and the walk is over before construction
begins.

## Generate

One writer per declared document type
(`decision:documents-generated-per-type-and-placed`), dispatched as a
leaf agent — `{{LEAF-AGENT-RULE}}` from
`.claude/skills/_shared/dispatch-discipline.md` — after the records
above are constructed. Types left out for the run by the walk get no
writer.

### The writer's brief

```
You are writing one document a release ships: <title>, from the
document type at .ok-planner/surface/documents/<slug>.md. Read the
type first: its Purpose is what the document is for; its Covers
names the classes of public surface it must cover; its target is
where it will be placed.

Release: <commit sha> — every statement you write is about the tree
at this commit, and you verify it there.

Inputs, in this order:
1. The type file (what to write, and for whom).
2. .ok-planner/audits/surface/extraction.json, public side — the
   elements of the covered classes at this release; the population
   the document must account for. Do not name internal elements.
3. The documentation records under .ok-planner/documentation/
   (catalog/, assessments/, traps/, concepts.md) — orientation: what
   the audit measured, which assumptions the product contradicts,
   the shipped vocabulary. Read them to know what to look at and what
   to warn about; do not cite them and do not copy their warrant
   fields.
4. The tree at the release commit — the source of truth for every
   sentence. Read the code, the help text, the configuration, the
   examples; run nothing that changes state.

Write a self-contained document a reader uses without following
anything: no citations into the records, no `held`/`unverified`
state, no source paths, tests, or internal entry points, no
references to the estate. Verify each claim against the tree at the
stamp before you state it; where you cannot verify a claim, leave it
out rather than hedge it. Cover every public element of the covered
classes the extraction lists — a reference that omits a public verb
is wrong. Speak the shipped vocabulary: concepts, stories, public
surface elements.

Open the document with its provenance stamp, exactly:

<!-- Generated by /document at <commit sha> on <date>. A record of
that release, not a source of truth; regenerated whole at the next
release. Read it only when directed here. -->

Then the title, then the body. Write in the project's technical
writing standard. Return the finished document as your final text
and nothing else — no summary, no notes.
```

For a folder target, the same brief with the folder in place of the
file: the writer returns a set of files (each opening with the same
stamp), and the set is placed under the folder whole.

### Placement

Write each returned document to
`.ok-planner/documentation/documents/<slug>.md` (a folder target:
`documents/<slug>/` holding the set) — the copy of record — and copy
it, byte for byte, to the type's target in the tree. **Only declared
targets are written**: no path is touched that no type names, and a
project that keeps a hand-written `README.md` declares no type
targeting it. A folder target is replaced whole, and the
**provenance stamp is what identifies the set to replace**: before
the new set lands, remove every file directly under the folder that
opens with the stamp comment, so a document whose type was dropped
does not linger. `docs/CLAUDE.md` opens with its own `Materialized
by /document` line and never the provenance stamp, so this sweep does
not see it — including where a type takes `docs/` itself as its folder
target. It is the step below's to write or remove, never this
sweep's. Every other file under a folder target
carries no stamp, is not this ceremony's, and stays exactly where it
is — named on the presentation's Documents line so the owner sees what
the run wrote around. **Never wipe a folder target**: a hand-kept file no
type claims is precisely what per-type placement protects.

Where any type targets a path under `docs/` — `docs/` itself as a
folder target included — write `docs/CLAUDE.md` in the same step,
verbatim:

```
# docs/ — generated release documents

Materialized by /document at <commit sha> on <date>. Suite-owned:
overwritten wholesale at the next release run.

Every document under this folder was generated from a document type
declared in `.ok-planner/surface/documents/` and describes the
release named in its opening stamp. These files are records: out of
agent context by default, never read to understand the current tree,
never reconciled with the code by a working session. Read one only
when the owner directs you here. A document that has fallen behind
the tree is expected — file nothing and mark nothing; the next
`/document` regenerates the set whole. The measured records that
oriented these documents live under `.ok-planner/documentation/`, and
the project's durable model under `.ok-planner/design/`.
```

Where no type targets a path under `docs/` — `docs/` itself as a
folder target included — and a `docs/CLAUDE.md` a prior run wrote is
present, recognizable by the `Materialized by /document` line of the
text above, remove it in the same step. Its
record rule claims every document under the folder came from a
declared type, and no type places anything there any more. A
`docs/CLAUDE.md` this ceremony did not write carries no such line and
stays where it is.

Placement is this run's act; publishing outside the repository is a
separate publisher's, never performed here.

## Present

```
## ok-planner

Audit: <current at <sha> — reused | run by this ceremony>
Walk: <inside the composed audit | this run's Walk step — types
declared N; landed this release K; left out for the run, each with
its intake issue path; or "N declared, all covered, nothing to
settle">
Corpus: <records written, by kind: catalog rows, assessments, traps,
evidence sets>
Documents: <written N; placed at <target paths>; unstamped files
left in place under a folder target, by path | none; docs/CLAUDE.md
written | removed | not needed>
Attestation: <assumptions the audit synthesized / accounted for — the
two numbers must agree>
Filed: <none beyond the walk's unsettled-type issues, by path — the
audit's judge and distillation hold the other filing paths.>
```

When this ceremony ran the audit itself, fold the audit's run report
into the wrap-up: its receipt counts, the issues and nominations it
filed, the traps it recorded — one presentation covering both
ceremonies.

## Boundaries

- Never edits `design/`. A story the product contradicts is the audit
  judge's intake issue, never a story rewritten to match the product.
- Never measures anything. Story support, assumption dispositions,
  and the surface extraction are consumed, not re-derived; no
  synthesis, no experiments, no box runs here.
- Never writes the surface intent, and never writes the extraction or
  any audit record — the intent is the owner's, and the extraction
  and audit records are the audit's. Writes a document type only in
  the walk, with the owner; no autonomous stage writes one.
- Never files beyond the walk's one path — an intake issue per type
  the owner left unsettled. The audit's judge and distillation are
  the measurement front's filing paths; construction has none.
- Never puts a source path, test, or internal entry point in a
  publishable record. The shipped layer speaks the shipped vocabulary.
  A generated document cites nothing at all — no record, no path.
- Never adopts an experiment into the project's suites. The intake
  carries the audit's nomination; a sprint does the work.
- Never writes a document at a path no declared type targets, and
  never publishes outside the repository. Placement in the tree is
  this run's act; shipping is a separate publisher's job.
- Never marks a placed document stale or files on staleness. The
  stamp is the marker; the next run regenerates the set whole.
- Never reads sprints, sketches, or history — records are out of
  context; the audit's run report in the archive is read as the
  wrap-up's input, and for nothing else.

<!-- Materialized by ok-planner v18.4.1 — suite-owned; overwritten on converge; do not hand-edit. -->
