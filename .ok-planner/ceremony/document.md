# ok-planner — documentation ceremony contribution

What the suite's release-documentation ceremony does about this family's estate. The ceremony owns the spine — audit, walk, project, assess, distill, generate, present, close out; this file owns everything ok-planner contributes to it, including the documentation walk the audit calls when `/document` composed it. Materialized into consumer projects at `.ok-planner/ceremony/document.md`; the ceremony reads it there when `.ok-planner/` exists.

## Requires

`.ok-planner/design/` at the project root — the story catalog is what the assessments describe. Without it there is nothing to document against: say so and point at `/discover-design`.

A **current audit**. The audit is the ceremony's entire measurement front: it writes the surface extraction, determines story support from the user's side, determines decision and concept support from the technical side, and forms and verifies the assumptions in its own boxed synthesis. The audit is current for this release exactly when the tree's movement since its stamped commit touches only the audit's own output paths (the path-scoped rule its ceremony contribution states); otherwise the ceremony runs `/audit` first. The surface intent (`.ok-planner/surface/surface.md`) is the audit's requirement, read there.

The **document types** under `.ok-planner/surface/documents/` — one file per document the release ships. The documentation walk settles them, so a project with none is not blocked: the walk proposes a starter set from the extraction and lands what the owner keeps.

## Layout

`mkdir -p .ok-planner/documentation/catalog .ok-planner/documentation/assessments .ok-planner/documentation/traps .ok-planner/documentation/evidence .ok-planner/surface/documents`. Estate convergence is the front door's administration (`/ok`), never this run's.

`.ok-planner/documentation/` is the records' home, beside `audits/`, and it carries a **record's discipline**: out of agent context by default, never consulted to understand the current tree, never reconciled or refreshed by day-to-day sessions. The run overwrites the records whole; prior records live at their release tags.

**The documents live in the tree, and only there.** Each document sits at its type's target — `docs/…`, the root `README.md` — where its readers already look. The estate keeps no second copy. Each document carries a provenance stamp naming the release the run last verified it against. An agent that finds one behind the tree files nothing and marks nothing; the next run revises it.

The layout splits along the vantage line:

- **Publishable** — `catalog/`, `assessments/`, `traps/`, and the concept router `concepts.md`. These speak the shipped vocabulary — concepts, stories, public surface elements — and cite only catalog rows at the stamp: `catalog:<kind>/<member>`. Source paths, tests, and internal entry points stay in the verification layer.
- **Verification layer** — `evidence/` (trap evidence sets) here; the surface extraction under `.ok-planner/audits/surface/`, the audit's determinations and assumption records under `.ok-planner/audits/`, and the experiments under `.ok-planner/experiments/`. Internal, never shipped; these cite the tree freely (`src:<path>` means that path **at the stamped commit**, checked once at production, never re-verified against the moving tree).
- **Documents** — one per declared type, living at that type's target in the tree. Publishable, self-contained, outside the citation rule: a document cites no record and no path.

## Audit

The audit's determinations set the delivery criterion: **only stories the audit called `supported` are documented as delivered.** An unsupported story is already an intake issue, not deliverable documentation. The surface extraction (`.ok-planner/audits/surface/extraction.json`) defines the catalog domain: its public side, unconditionally — every public element is cataloged whether or not any story claims it, so absence is answerable. The assumption records under `.ok-planner/audits/assumptions/` arrive carrying their dispositions — held, trap, or unverified — measured by the audit; this run re-measures none of them.

## Walk

The **documentation walk** settles the document types. One body, two call sites: the audit calls it immediately after its extractor returns, when `/document` invoked the audit; `/document` calls it as its Walk step, against a reused audit's extraction, when the audit was current and not repeated. Either way it runs once per release, before construction, and it is the release run's one owner conversation. An à la carte `/audit` never calls it.

### The document type

**All documentation is typed.** Every document the tree carries — the root `README.md`, a `README.md` at any depth, everything under `docs/`, a tutorial, an example walkthrough, a guide — is one document type's product, revised at every release. A document no type claims is a walk delta, never a file the ceremony works around. What is not documentation is not a type's business: agent-rules files (`CLAUDE.md`, `.claude/rules/`), the estate's own files, the design corpus, licenses, generated tables of contents, and the non-document inputs a document describes — configuration files, schemas, model builders, data, scripts.

One file per type at `.ok-planner/surface/documents/<slug>.md`, prose, owner-authored, walk-maintained, freely edited by the owner between runs:

```
---
document: <slug>
audience: public | developer
target: <path in the tree — a file, or a folder when it ends in `/`>
---
# <Title the document carries at its target>

## Purpose
<What the document is for, in a few sentences: who opens it and what
they should be able to do when they close it.>

## Covers
<The classes of surface the document covers, one per line, in the
extraction's kind vocabulary where a kind exists — "every public
CLI verb", "the published environment variables"; a developer-facing
type may name internal classes too — "the repository operator
scripts". Prefer classes to elements: a hand-listed set of verbs
drifts, and the extraction already holds the list.>

## Method
<Optional. How the writer produces the document, beyond reading the
type and the tree: the research to run, the sources to consult, the
steps to follow, what counts as current. Leave the section out when
reading the tree is the whole method.>
```

Purpose, audience, Covers, and target are the fields the writer always reads. **The type is the owner's document, and it carries whatever the owner puts in it** — an outline to follow, prose to carry verbatim, a worked example, a standing correction, something to leave out. The writer honors every one. Where an owner's instruction and the tree disagree about a fact, the tree decides the fact and the instruction still governs the shape.

**A Method names how the writer produces the document:** any procedure — research to run, sources to consult, steps to follow, what counts as current. The ceremony runs it before the writer as dispatches (the Generate section below) and hands the findings to the writer. The writer states what the findings establish and leaves out what they do not.

A folder target (`docs/examples/`) tells the writer to produce a set under that folder; a file target names the one file.

**The audience is the document's vantage.** `public` (the default when the field is absent) is the user's: the document names only elements the extraction records public and speaks the shipped vocabulary — a reference, a quickstart, a tutorial. `developer` is the contributor's or operator's: the document may name internal elements — repository scripts, service entry points, internal ports and keys, the layout of the tree — and its Covers may name internal classes; a setup guide, an operations runbook, a contributor's map of the tree. The run revises both against the type at every release, verifies both against the tree, and keeps both self-contained; the audience changes only what the writer may name. An element named in a developer document is no more public for being named there.

### Inputs

- `.ok-planner/audits/surface/extraction.json` — the public side only, grouped by kind. Internal elements are invisible to the walk.
- Every file under `.ok-planner/surface/documents/`.
- The tree's documentation files — every markdown document outside the estate and the agent-rules layer — to find documentation no type produces, and to note whether a proposed target already exists.

### Compute the deltas, and raise only those

Read the extraction's public side against the declared types and compute:

- **Uncovered classes** — a public kind in the extraction no type's Covers names. Propose one type per uncovered kind: a reference for that kind, slug from the kind, target under `docs/`. Internal kinds raise no delta: a developer-facing type may cover them, and none has to.
- **Empty types** — a declared type whose covered classes returned no public element in this extraction. Propose keeping it (its classes may be public next release), narrowing it, or dropping it.
- **Untyped documentation** — a document in the tree no type's target covers: a `README.md` at any depth, a file under `docs/`, a tutorial or guide, a walkthrough beside example inputs. Propose one type per document, or one folder-target type per set that belongs together: purpose read from what the file does today, classes from the surface it exercises, audience `developer` where it documents internal tooling or the tree, target at the file's own path. The owner keeps it as a type or drops the file as not documentation; either way no document is left untyped.
- **Nothing** — every public kind covered, no type empty, every document typed. Say so in one line ("document types: N declared, all covered, nothing to settle") and ask nothing. Agreement passes in silence.

**On an empty type set** — no files under `surface/documents/` — propose a **starter set**: one reference per public kind the extraction found, one leading document for the whole at the root `README.md`, and one type per documentation file or set already in the tree, per the untyped-documentation delta. The owner keeps, drops, renames, or retargets each; nothing lands they did not approve.

Where a proposed target already exists in the tree without a provenance stamp, say so in the same line — the type adopts the file, and the next run revises what is there. Never propose a target outside the repository.

### Ask, land, and move on

Put the deltas to the owner in **one message**: a tight list, one line per delta with the proposed type (slug, purpose in a phrase, classes, target). Take their answer — keep, drop, rename, retarget, reword — and land every approved type as a file in the shape above, showing the diff. Ask questions in prose, never through a form. Open no other topics here: driving observations and audit findings belong to the audit's report and judge.

A type the owner leaves **unsettled** — no answer, or "not sure" — is **left out for the run** (no file, no document this release) and filed as one intake issue per `{{ISSUE-FILE-FORMAT}}` from `.claude/skills/_shared/artifact-definitions.md` (category `unclear`), asking the owner to declare or decline it. The walk does not stall on it. Nothing else in the walk files.

**No autonomous stage writes a type.** The walk lands what the owner approves, in conversation; between runs the owner edits the files directly. Where the audit's close-out commits, the types the walk landed ride the audit's first commit; where `/document` ran the walk itself, they ride the corpus commit.

### The handoff is the walk's last act

The walk is not over until the owner has been shown the release run's goal line. Show it in the message that lands the types — or, when nothing was there to settle, in the same one-line message that says so — and only then move on. The walk may have run for many turns by then; the check is simple: if the line below has not appeared in the conversation, the walk has not ended. The run proceeds hands-free from here whether or not the owner sets the goal:

```
/goal the documentation run described in .ok-planner/ceremony/document-goal.md is complete — every term of its goal rule verifies against this repository
```

## Project

Catalog files at `documentation/catalog/<kind>.md`, one per declared kind:

```
---
kind: <kind>
release: <commit>
population: <public members the extraction holds for this kind>
---
```

Then one row per **public** member — `` - `<member>` — <one line> ``, naming the assessments that measure it where any do. The rows match the extraction's public side one-to-one; `population:` is the count the writers hold them to. A kind with no public members writes its file with `population: 0` and no rows. Internal members appear nowhere in the publishable layer.

The router at `documentation/concepts.md` lists the published concepts — slug and one line each — pointing the reader into the concept bodies the audit's synthesis box also saw.

## Assess

Construction, not measurement: one assessment record per way the audit measured — a story-way warranted by the audit's story determinations, an assumption by its record's disposition — composed from the audit files, the assumption records, and the experiments' `record.md` observations. This run drives nothing through the surface.

One assessment per measured way, at `documentation/assessments/<subject>--<way>.md`:

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

The body records what the audit ran, what was observed, and the **unverified remainder** — stated in the record, never left silent — in the shipped vocabulary, citing catalog rows. An `outcome: held` requires an `experiment:` warrant — a passing experiment the audit drove through the public surface at the release. A reading is never a warrant, a failed run is never a warrant, and the project's tests are never warrants for user-vantage claims; `warrant: none` is legal only with `outcome: unverified`. A story the product honors through several ways carries several assessments; the demonstrated path is the product of the record, the outcome a byproduct.

**The attestation rule.** Every assumption the audit synthesized ends the run holding an assessment record (held or unverified) or a trap record — never nothing.

**Story defects and fitness are the audit's findings, not this run's.** A story the product contradicts is `unsupported` in the audit, already an intake issue from its judge; a story that cannot be measured as written is likewise `unsupported`, its paragraph naming what the story leaves undecidable. This run consumes those verdicts: it documents the supported stories and files nothing about the rest.

## Distill

Trap records at `documentation/traps/<slug>.md`, one per assumption record the audit closed with `disposition: trap`:

```
---
trap: <slug>
release: <commit>
demonstration: experiment:<slug> | none
---
## Assumption
## Actual behavior
```

The shipped trap record speaks in surface terms: the assumption, the actual behavior, and — where the audit demonstrated the actual behavior through the public surface — the passing demonstration experiment, the evidence set's strongest member. The full **evidence set** that warrants the contradiction lives at `documentation/evidence/<slug>.md` (frontmatter `trap:`, `release:`), composed from the audit's records and observations; it may rest on reading, cites the tree freely, and never ships. A trap never rests on a failed run alone; a failed runnable may join the evidence set as corroboration, never as the warrant.

**Filing: none from construction.** Contradicted promises were filed by the audit's judge, before this run consumed the records. The one filing this ceremony makes is the walk's — an intake issue per unsettled document type — and the walk is over before construction begins.

## Generate

One writer per declared document type, dispatched as `Agent (general-purpose, model: opus)` — a leaf agent, `{{LEAF-AGENT-RULE}}` from `.claude/skills/_shared/dispatch-discipline.md`; writing a document is a production job, so it rides opus, named here so no orchestrator inherits its session model by omission — after the records above are constructed. Types left out for the run by the walk get no writer.

### Research first, where the type carries a Method

For a type carrying a Method, run the Method before you dispatch its writer: dispatch its steps as `Agent (general-purpose, model: sonnet)` leaf agents — `{{LEAF-AGENT-RULE}}` — batched per `{{DISPATCH-DISCIPLINE}}` from `.claude/skills/_shared/dispatch-discipline.md`, one batch per independent subject where the Method names several. Each researcher does what the Method says and returns findings only: what it established, the source and date for each, and what it could not establish. Investigation rides sonnet; the writer, a production job, still rides opus. Paste the findings whole into the writer's brief as the input the brief names. Findings are the run's working material, not a record: they land in no layer and ship nowhere. A type without a Method skips this step.

### The writer's brief

```
You are bringing one document a release ships up to date: <title>,
at <target path>, from the document type at
.ok-planner/surface/documents/<slug>.md. Read the type first: its
Purpose is what the document is for; its audience (`public` when
absent) is whose vantage you write from; its Covers names the
classes of surface it must cover; its target is the file you write.
Everything else the owner wrote in the type is an instruction to
you — an outline to follow, prose to carry verbatim, a correction to
apply, something to leave out. Honor all of it.

Release: <commit sha> — every statement you write is about the tree
at this commit, and you verify it there.

Inputs, in this order:
1. The type file (what to write, and for whom).
2. The document already at the target, when one is there. This is
   your starting text. Read it whole before you change a line.
3. .ok-planner/audits/surface/extraction.json — the elements of the
   covered classes at this release; the population the document must
   account for. Audience `public`: read the public side only, and do
   not name internal elements. Audience `developer`: read both
   sides; you may name internal elements — repository scripts,
   service entry points, internal ports and keys — where the Purpose
   calls for them, and every one you name you verify in the tree
   like any other claim.
4. The documentation records under .ok-planner/documentation/
   (catalog/, assessments/, traps/, concepts.md) — orientation: what
   the audit measured, which assumptions the product contradicts,
   the shipped vocabulary. Read them to know what to look at and what
   to warn about; do not cite them and do not copy their warrant
   fields.
5. The tree at the release commit — the source of truth for every
   sentence about the product. Read the code, the help text, the
   configuration, the examples; run nothing that changes state.
6. The findings of the type's Method, pasted below, when it carries
   one. State what they establish, dated as they date it, and leave
   out what they do not. Where a finding and the tree disagree about
   the product, the tree decides.

**Revise the document that is there; write from scratch only when
the target is empty.** The text at the target is a person's work as
much as a prior run's, and the owner may have edited it by hand
since. Keep what still holds. Change a sentence when the tree
contradicts it, when the type asks for something it does not do, or
when it fails the writing standard. Add what the type covers and the
document lacks. Cut what the release removed. Leave everything else
exactly as you found it — matching wording, ordering, and voice you
did not have to touch. Aim for a diff a reviewer can read. A rewrite
that says the same thing in new words is a defect.

Where the existing text and the tree disagree, the tree wins — but
look before you conclude. A statement you cannot confirm may be
about a part of the tree you have not read, so read for it. Change a
sentence when you have established what the truth is, and leave it
when you have not.

The finished document is self-contained: a reader uses it without
following anything — no citations into the records, no
`held`/`unverified` state, no references to the estate. Audience
`public`: no source paths, tests, or internal entry points; speak
the shipped vocabulary — concepts, stories, public surface elements.
Audience `developer`: paths in the tree, scripts, and internal entry
points are yours to name where the Purpose needs them; still no
estate references and no record citations. Verify each claim against
the tree at the stamp — or, for the facts the type's Method covers,
against the findings — before you state it; where you cannot verify a
claim, leave it out rather than hedge it. Cover every element of the
covered classes the extraction lists — a reference that omits a verb
of a class it covers is wrong.

Open the document with its provenance stamp, replacing any stamp a
prior run left, exactly:

<!-- Revised by /document at <commit sha> on <date>. Verified
against the tree at that commit and not since; a record, not a
source of truth. Read it only when directed here. -->

Then the title, then the body. Write in the project's technical
writing standard. Write the document to its target path yourself.
Return a summary of what you changed and why — the sections you
touched, what the release made wrong, what you added — and nothing
else.
```

For a folder target, the same brief with the folder in place of the file: the writer revises the set already under the folder, adds what the type covers and the set lacks, and stamps every file it writes.

### Placement

**Each writer writes its own document, at the type's target, in the tree.** No step moves or copies a document afterward. **Only declared targets are written**: no path is touched that no type names. A document the walk found no type for is the walk's delta, never a file this step preserves as documentation.

Under a folder target, the **provenance stamp identifies the run's own set**: after the writers finish, remove every file directly under the folder that opens with a stamp and that no declared type produced this release, so a document whose type was dropped does not linger. `docs/CLAUDE.md` opens with its own `Materialized by /document` line and never the provenance stamp, so this sweep does not see it — including where a type takes `docs/` itself as its folder target; it is the step below's to write or remove, never this sweep's. Every other file under a folder target carries no stamp and is not a document — it is an input the set describes (configuration, a schema, a model builder, data, a script) — and it stays exactly where it is, named on the presentation's Documents line so the owner sees what the run wrote around. **Never wipe a folder target**: the inputs beside a document set are what per-type placement protects.

Where any type targets a path under `docs/` — `docs/` itself as a folder target included — write `docs/CLAUDE.md` in the same step, verbatim:

```
# docs/ — generated release documents

Materialized by /document at <commit sha> on <date>. Suite-owned:
overwritten wholesale at the next release run.

Every document under this folder answers to a document type declared
in `.ok-planner/surface/documents/`, and its opening stamp names the
release it was last verified against. These files are records: out of
agent context by default, never read to understand the current tree,
never reconciled with the code by a working session. Read one only
when the owner directs you here. A document that has fallen behind
the tree is expected — file nothing and mark nothing; the next
`/document` revises it. The measured records that oriented these
documents live under `.ok-planner/documentation/`, and the project's
durable model under `.ok-planner/design/`.
```

Where no type targets a path under `docs/` and a `docs/CLAUDE.md` a prior run wrote is present — recognizable by the `Materialized by /document` line — remove it in the same step: its record rule claims every document under the folder came from a declared type, and no type places anything there any more. A `docs/CLAUDE.md` this ceremony did not write carries no such line and stays.

Placement is this run's act; publishing outside the repository is a separate publisher's, never performed here.

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
Documents: <revised N and created K, each at its target path, with
one line per document saying what changed; research dispatched for
each type carrying a Method, by type and count | none; unstamped
files left in place under a folder target, by path | none;
docs/CLAUDE.md written | removed | not needed>
Attestation: <assumptions the audit synthesized / accounted for — the
two numbers must agree>
Filed: <none beyond the walk's unsettled-type issues, by path — the
audit's judge and surface extractor hold the other filing paths.>
```

When this ceremony ran the audit itself, fold the audit's run report into the wrap-up — its receipt counts, the issues it filed, the traps it recorded — one presentation covering both ceremonies.

## Boundaries

- Never edits `design/`. A story the product contradicts is the audit judge's intake issue, never a story rewritten to match the product.
- Never measures on its own initiative. Story support, assumption dispositions, and the surface extraction are consumed, not re-derived; no synthesis, no experiments, no box runs here. A type's Method may direct whatever the owner names, and its findings are never a warrant.
- Never writes the surface intent, the extraction, or any audit record — the intent is the owner's; the extraction and audit records are the audit's. Writes a document type only in the walk, with the owner.
- Never files beyond the walk's one path — an intake issue per unsettled type. The audit's judge and surface extractor are the measurement front's filing paths; construction has none.
- Never puts a source path, test, or internal entry point in a publishable record. A generated document cites nothing at all — no record, no path.
- Never adopts an experiment into the project's suites. The experiments are the audit's instruments and stay in its collection.
- Never writes a document at a path no declared type targets, and never publishes outside the repository.
- Never marks a document stale or files on staleness. The stamp is the marker; the next run revises the document.
- Never rewrites a document that only needs revising, and never discards an owner's hand edit that the tree still supports.
- Never reads sprints, sketches, or history — records are out of context; the audit's run report is read as the wrap-up's input and for nothing else.

<!-- Materialized by ok-planner v19.4.4 — suite-owned; overwritten on converge; do not hand-edit. -->
