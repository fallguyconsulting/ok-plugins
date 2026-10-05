---
name: document
description: "ONLY activated by explicit /document slash command. Never auto-triggered by conversation content. ok-planner's release-documentation ceremony: ensures a current audit at the release (running /audit when the tree has moved past its stamp), settles the declared document types in the documentation walk (inside the audit it invoked, or against a reused audit's extraction), constructs the documentation corpus's records from the audit's records — the catalog projected over the extraction's public side, assessments from the story and assumption determinations, the trap registry from the assumption dispositions — measuring nothing itself, then brings each declared type's document up to date in the tree — revising what is there, writing one where none exists — and stamps it with the release. Leaves behind a commit-stamped corpus split along the vantage line: a publishable layer in shipped vocabulary, a verification layer that stays internal, and the documents in the tree. The records are produced fresh at every release; the documents accumulate."
---

# Document (the release run)

A release brings the project's documentation up to date, in two tiers. The **records** are a measured assessment: every claim rests on a warrant the audit took at this release, and every element the surface extraction records public is cataloged whether or not any story claims it. The run writes them fresh each time. The **documents** are self-contained texts — one per document type the owner declares — living in the tree where readers expect them, revised at each release against the type, the records, and the tree. Both carry the release commit they were verified against. Neither is a source of truth: an agent reads one only when directed to it.

## The audit is the measurement front

**This ceremony measures nothing.** The audit writes the surface extraction, determines story support from the user's side, determines decision and concept support from the technical side, and forms and verifies the assumptions in its own boxed synthesis. This run **constructs** from those records: the supported stories are the delivery criterion, the extraction's public side is the catalog domain, the story and assumption determinations become the assessments, and the assumption dispositions become the trap registry. Composition, never absorption — one canonical audit body exists, so the two ceremonies cannot drift apart on what an audit is.

## The three drivers

Three independent drivers produce the corpus, and none substitutes for another:

- **The extraction's public side drives the catalog, unconditionally.** Every public element gets a catalog row whether or not any story claims it, so a reader can trust that what is not in the catalog does not exist. Internal elements appear nowhere in the publishable layer.
- **The audit's measurements drive the assessments.** The story determinations say how the product's promises played out; the assumption dispositions say how a user's priors played out. The divergence set — the traps — is the content a user cannot derive from the surface, and it arrives already measured.
- **The declared document types drive the documents.** Each type under `.ok-planner/surface/documents/` owns exactly one document, brought up to date by its own writer at the type's target. No type, no document: nothing is written at a path no type claims.

## The vantage split

The corpus has two layers, split by the reader's vantage, and the documents beside them:

- **The publishable layer** — `catalog/`, `assessments/`, `traps/`, and the concept router `concepts.md` under `.ok-planner/documentation/` — speaks the shipped vocabulary: concepts, stories, public surface elements. It cites only catalog rows at the stamp: `catalog:<kind>/<member>`. No publishable record names a source path or an internal entry point.
- **The verification layer** — `evidence/` (trap evidence sets) under `.ok-planner/documentation/`; the surface extraction under `.ok-planner/audits/surface/`, the audit's determinations and assumption records under `.ok-planner/audits/`, and the experiments under `.ok-planner/experiments/`. Internal, never shipped; these cite the tree freely (`src:<path>` means that path **at the stamped commit**, checked once at production, never re-verified against the moving tree).
- **The documents** — one per declared type, living at that type's target in the tree. They sit on the publishable side but outside the records' citation regime: self-contained, citing no record and no path, carrying no warrant state, opening with the provenance stamp naming the release commit they were verified against and this ceremony.

## Requires

The project root is the nearest ancestor of the working directory (itself included) holding `.ok-planner/`, never derived from `.git`. `.ok-planner/` owns the story catalog, the document types, the documentation corpus's home, and the audit whose records this run constructs from. Without it, say so and stop; there is nothing to document against.

`.ok-planner/design/` at the project root — the story catalog is what the assessments describe. Without it there is nothing to document against: say so and point at `/discover-design`.

A **current audit**. The audit is current for this release exactly when the tree's movement since its stamped commit touches only the audit's own output paths (the path-scoped rule its Close-out states); otherwise this run runs `/audit` first. The surface intent (`.ok-planner/surface/surface.md`) is the audit's requirement, read there.

The intake module at `.ok-planner/bin/issues`, through which the documentation walk files. Where it is missing, say that `/ok` materializes it, and stop. Run `.ok-planner/bin/issues list`. It writes a note on stderr for each markdown issue file or stray line it skips; pass those notes to the owner, and go on.

The **document types** under `.ok-planner/surface/documents/` — one file per document the release ships. The documentation walk settles them, so a project with none is not blocked: the walk proposes a starter set from the extraction and lands what the owner keeps.

Tell the owner what release is being documented before anything else.

## The release

The run documents a **release**: the invocation names a tag or commit, and every record is a statement about that commit. With no argument, document the working tree as it stands and say so in one line; the stamp is then the current commit. The prior release's **published documentation corpus**, where one exists, is an input to the *audit's* assumption synthesis — shipped, user-visible material, legitimate user priors — never to this run's construction: none of its conclusions carry, and nothing tracks staleness between runs.

## The spine

1. **Layout** — ensure the corpus directories exist, per Layout below. Estate convergence is the front door's administration (`/ok`), never this run's.
2. **Ensure a current audit.** The audit is current for this release exactly when the diff from its stamped commit to the release tree touches only the audit's own output paths — the path-scoped rule the audit's close-out states; no tracked state, just git. Current → say so in one line and construct from it. Not current, or none exists → invoke `/audit` now, composing it as its own skill, never absorbing its logic; invoked this way it runs the documentation walk immediately after its extractor returns, ends silently at its stamp, and this run's wrap-up covers both ceremonies. Either way the run proceeds on the audit's determinations, its assumption records, and its surface extraction, per Audit below.
3. **Walk** — the documentation walk, run only when the audit was reused: the Walk section below, driven against the reused audit's extraction — the extraction's public side read against the declared document types, only the deltas raised, the owner's rulings landed as type files, a type left unsettled left out for the run and filed as an intake issue by the walk's own rule, one line and no question when nothing changed. When this run invoked the audit, the audit ran the same walk immediately after its extractor returned, and this step is skipped. Either way the walk is this run's one owner conversation, and it is over before construction begins. Once it lands — at whichever call site — hand the owner the `/goal` handoff line naming the vendored goal file at `.claude/skills/document/goal.md`; the run then proceeds hands-free whether or not the owner sets the goal.
4. **Project** — gated by the handoff: the walk's last act, at either call site, is showing the owner the `/goal` line; if it has not appeared in the conversation, show it now before anything else. Then the mechanical pass, per Project below. Read the surface extraction's public members and build the catalog rows and structural reference material by projection from the release's own artifacts, one row per public member per kind. The extraction is consumed, never recomputed; a partition question this phase cannot answer from the extraction means the audit is not current after all — go back to the previous step.
5. **Assess** — construct the assessment records from the audit's measurements, per Assess below: one assessment per measured story-way and per assumption, its held claim citing the passing experiments the audit ran at the stamp as its warrant. This run runs nothing; an item the audit could not measure is recorded as unverified — an honest state, not a failure.
6. **Distill the traps** — every assumption record the audit closed with `disposition: trap` becomes a trap record, per Distill below: the shipped statement in surface terms in the publishable layer, the evidence set in the verification layer. Contradicted promises and unmeasurable stories are already intake issues from the audit's judge — never documented as product, never re-filed here. Every assumption arrives carrying a disposition and every one is represented, never silently dropped.
7. **Generate** — one writer per declared document type, dispatched per Generate below: briefed with the type, the document already at the type's target, the extraction's public side, the records this run constructed as orientation, and the tree at the release commit. A type carrying a Method — the owner's steps for how the writer produces the document — gets that run first, dispatched per Generate below, and the writer takes the findings as one more input. The writer revises the document that is there and composes one only where the target is empty, keeping every sentence the tree still supports, verifying what it states against the tree at the stamp, and leaving a self-contained document — no record citations, no warrant fields — opening with the provenance stamp. It writes that document at the type's target, the one place the document lives. Where any type targets a path under `docs/` — `docs/` itself as a folder target included — the step also writes `docs/CLAUDE.md` carrying the record rule, and where none does any more it removes the `docs/CLAUDE.md` a prior run wrote. Only declared targets are written.
8. **Present** — the wrap-up, composed from the audit's run report and this run's construction counts, per Present below. When this run invoked the audit, the wrap-up covers both ceremonies — the audit presented nothing at its stamp — reading the same report as an input.
9. **Close-out** — commit the records and the revised documents, naming the release they describe.

## Warrants

A claim is recorded as **held** only on an affirmative warrant: a passing experiment driven through the extraction's public elements at the stamped commit — taken by the audit, on the maintained experiments. This run takes no runs and grants no warrants of its own: it cites the audit's. Reading is never a warrant, and a failing run is never a defect. A trap is warranted by an **evidence set**, with a passing demonstration of the actual behavior through the surface as its strongest member where one is possible, and any failed runnable attached as corroboration, never as the warrant.

## Layout

`mkdir -p .ok-planner/documentation/catalog .ok-planner/documentation/assessments .ok-planner/documentation/traps .ok-planner/documentation/evidence .ok-planner/surface/documents`. Estate convergence is the front door's administration (`/ok`), never this run's.

`.ok-planner/documentation/` is the records' home, beside `audits/`, and it carries a **record's discipline**: out of agent context by default, never consulted to understand the current tree, never reconciled or refreshed by day-to-day sessions. The run overwrites the records whole; prior records live at their release tags.

**The documents live in the tree, and only there.** Each document sits at its type's target — `docs/…`, the root `README.md` — where its readers already look. The estate keeps no second copy. Each document carries a provenance stamp naming the release the run last verified it against. An agent that finds one behind the tree files nothing and marks nothing; the next run revises it.

## Audit

The audit's determinations set the delivery criterion: **only stories the audit called `supported` are documented as delivered.** An unsupported story is already an intake issue, not deliverable documentation. The surface extraction (`.ok-planner/audits/surface/extraction.json`) defines the catalog domain: its public side, unconditionally — every public element is cataloged whether or not any story claims it, so absence is answerable. The assumption records under `.ok-planner/audits/assumptions/` arrive carrying their dispositions — held, trap, or unverified — measured by the audit; this run re-measures none of them.

## Walk

The **documentation walk** settles the document types. It is defined here, once. One body, two call sites: the audit calls it immediately after its extractor returns, when `/document` invoked the audit; `/document` calls it as its Walk step, against a reused audit's extraction, when the audit was current and not repeated. Either way it runs once per release, before construction, and it is the release run's one owner conversation. An à la carte `/audit` never calls it.

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

**A Method names how the writer produces the document:** any procedure — research to run, sources to consult, steps to follow, what counts as current. The run executes it before the writer as dispatches (Generate below) and hands the findings to the writer. The writer states what the findings establish and leaves out what they do not.

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

Put the deltas to the owner in **one message**: a tight list, one line per delta with the proposed type (slug, purpose in a phrase, classes, target). Take their answer — keep, drop, rename, retarget, reword — and land every approved type as a file in the shape above, showing the diff. Ask questions in prose, never through a form. Open no other topics here: driving observations and audit defects belong to the audit's report and judge.

A type the owner leaves **unsettled** — no answer, or "not sure" — is **left out for the run** (no file, no document this release) and filed as one intake issue (kind `audit`, category `unclear`), asking the owner to declare or decline it. File it through `.ok-planner/bin/issues file --from -`, one JSON object per `{{ISSUE-FILE-FORMAT}}` from `.claude/skills/_shared/artifact-definitions.md`. First run `.ok-planner/bin/issues list --category unclear`; where an open issue already asks about that type, file nothing. The walk does not stall on it. Nothing else in the walk files.

**No autonomous stage writes a type.** The walk lands what the owner approves, in conversation; between runs the owner edits the files directly. Where the audit's close-out commits, the types the walk landed ride the audit's first commit; where `/document` ran the walk itself, they ride the corpus commit.

### The handoff is the walk's last act

The walk is not over until the owner has been shown the release run's goal line. Show it in the message that lands the types — or, when nothing was there to settle, in the same one-line message that says so — and only then move on. The walk may have run for many turns by then; the check is simple: if the line below has not appeared in the conversation, the walk has not ended. The run proceeds hands-free from here whether or not the owner sets the goal:

```
/goal the documentation run described in .claude/skills/document/goal.md is complete — every term of its goal rule verifies against this repository
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

The body records what the audit ran, what was observed, and the **unverified remainder** — stated in the record, never left silent — in the shipped vocabulary, citing catalog rows. An `outcome: held` requires an `experiment:` warrant — a passing experiment the audit drove through the public surface at the release. A reading is never a warrant and a failed run is never a warrant; `warrant: none` is legal only with `outcome: unverified`. A story the product honors through several ways carries several assessments; the demonstrated path is the product of the record, the outcome a byproduct.

**The attestation rule.** Every assumption the audit synthesized ends the run holding an assessment record (held or unverified) or a trap record — never nothing.

**Story defects and fitness are the audit's determinations, not this run's.** A story the product contradicts is `unsupported` in the audit, already an intake issue from its judge; a story that cannot be measured as written is likewise `unsupported`, its paragraph naming what the story leaves undecidable. This run consumes those verdicts: it documents the supported stories and files nothing about the rest.

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

For a type carrying a Method, run the Method before you dispatch its writer: dispatch its steps as `Agent (general-purpose, model: opus)` leaf agents — `{{LEAF-AGENT-RULE}}` — batched per `{{DISPATCH-DISCIPLINE}}` from `.claude/skills/_shared/dispatch-discipline.md`, one batch per independent subject where the Method names several. Each researcher does what the Method says and returns findings only: what it established, the source and date for each, and what it could not establish. Investigation is an analytical job and rides opus, as the writer does. Paste the findings whole into the writer's brief as the input the brief names. Findings are the run's working material, not a record: they land in no layer and ship nowhere. A type without a Method skips this step.

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
`public`: no source paths or internal entry points; speak
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

Compose it in full — it is a report, delivered whole:

```
# Documentation — <project> at <release>

Audit: <current at <sha> — reused | run by this ceremony (its counts
folded in below). Then the delivery criterion's numbers: stories
supported and documented / excluded as unsupported, each exclusion
named>

Walk: <inside the composed audit | this run's Walk step — types
declared N; landed this release K; left out for the run, each with
its intake issue id; or "N declared, all covered, nothing to
settle">

Catalog: <per kind: public members in the extraction, rows written;
the internal count left uncataloged>

Assessments: <ways recorded for delivered stories, assumptions the
audit measured; held / trap / unverified counts>

Traps: <one line each: the assumption, the actual behavior; the
evidence sets written. The corpus holds the full records.>

Attestation: <assumptions the audit synthesized / accounted for — the
two numbers must agree>

Documents: <types declared (and any left out for the run, each named
with its intake issue id); revised N and created K, each at its target
path, with one line per document saying what changed; research
dispatched for each type carrying a Method, by type and count | none;
unstamped files left in place under a folder target, by path | none;
docs/CLAUDE.md written | removed | not needed>

Filings: <none beyond the walk's unsettled-type issues, by id. The
audit's judge and surface extractor filed the rest, named in its run
report; they are the next planning ceremony's business.>
```

When this run invoked the audit, fold the audit's run report into the wrap-up — its receipt counts, the issues it filed, the traps it recorded — one presentation covering both ceremonies.

## Close-out

Commit the documentation records and the revised documents in one commit naming the release they document, with `.ok-planner/issues.jsonl` where this run's walk filed into it. The records and documents already carry the release stamp; the commit makes them part of the tree without changing what they are — statements about the named release, not standing verdicts. Writing a document at its type's target is this run's act; publishing outside the repository is a separate act this run never performs, and the verification layer is never published at all.

## Boundaries

- Does not absorb the audit, and does not repeat a current one. It constructs from the audit's records, running `/audit` only when the path-scoped rule says the stamp is behind the release.
- Does not measure anything. No synthesis, no experiments, no box: story support, assumption dispositions, and the surface extraction arrive from the audit, already determined. A writer's check of its own sentences against the tree is reading for accuracy, never a warrant, and grants no held state. A document type's Method runs whatever the owner names, and its findings are never a warrant.
- Does not document a known gap as product. Unsupported stories are the audit judge's intake issues, never a story rewritten to match the product; the corpus documents what held.
- Files nothing beyond the walk's one path — an intake issue per unsettled type. The audit's judge and surface extractor are the measurement front's filing paths; construction has none.
- Does not put a source path or internal entry point in a publishable record. Tree citations live in the verification layer; a generated document cites nothing at all — no record, no path.
- Does not maintain anything between releases. Every run re-derives the records whole from a current audit and revises the documents at that release; the prior published documentation feeds the audit's synthesis, never this construction.
- Does not rewrite a document that only needs revising. It revises what is at the target, keeping what the tree still supports — an owner's hand edits included.
- Does not mark a document stale or file on staleness. The stamp is the marker; the next run revises the document.
- Does not edit the design corpus, the surface intent, the surface extraction, any audit record, or any code. The intent is the owner's; the extraction and audit records are the audit's. The document types are written only in the documentation walk, with the owner.
- Does not adopt an experiment into the project. The experiments are the audit's instruments and stay in its collection.
- Does not write a document at any path no declared type targets, and does not publish outside the repository.
- Does not ask the owner anything after the documentation walk. The walk is the run's one owner conversation, over before construction begins; the audit's autonomous portion asks nothing, so this run constructs, generates, presents, and commits.
- Does not read sprints, sketches, or history. Records are out of context; the audit's run report is read as the wrap-up's input and for nothing else.
- Does not converge an estate, materialize a file, or repair the vendored layer. That is `/ok`, always a user action.

<!-- Materialized by ok-planner v25.0.0 — suite-owned; overwritten on converge; do not hand-edit. -->
