---
name: document
description: "ONLY activated by explicit /document slash command. Never auto-triggered by conversation content. The suite's release-documentation ceremony, covering every estate this project has: runs the periodic audit at the release first, mechanically enumerates the owner-declared surface, synthesizes user-vantage assumptions in a boxed cold agent, verifies stories and assumptions up an affirmative-only warrant ladder, and leaves behind a commit-stamped documentation corpus — catalog, assessments, traps, archived experiments — produced fresh at every release, never carried forward."
---

# Document (the release run)

Documentation here is a **measured assessment**, not maintained prose:
every claim the produced corpus makes rests on a warrant taken at this
release, every declared surface element is cataloged whether or not any
story claims it, and the corpus is stamped with the release commit it
describes — a snapshot that is allowed to go stale because nothing
treats it as a source of truth.

This is a **suite verb**, not any one family's. One canonical body
covers whichever skill families the project integrates, and which those
are is read from the filesystem when the verb runs — never fixed when
it was vendored.

## The two spines

Two independent drivers produce the corpus, and neither substitutes for
the other:

- **The declared surface drives the catalog, unconditionally.** The
  project's surface declaration names its user-facing surface kinds and
  a mechanical enumeration source for each; every enumerated element
  gets a catalog row whether or not any story claims it. That is what
  makes absence answerable: a reader can trust that what is not in the
  catalog does not exist.
- **Stories and assumptions drive the assessments.** The story catalog
  says what the product promises; the synthesized assumptions say what
  a user would take for granted. Both are measured against the release,
  and the divergence set — the traps — is the content a user cannot
  derive from the surface alone.

## Resolve the estates

Every family's presence is a filesystem check at the project root —
the nearest ancestor of the working directory (itself included)
holding an estate directory, never derived from `.git` and never an
inference:

| estate | family |
|---|---|
| `.ok-planner/` | ok-planner |
| `.ok-plumbline/` | ok-plumbline |
| `.ok-workspaces/` | ok-workspaces |

For each estate present, read `<estate>/ceremony/document.md` — the
family's **ceremony surface**. That file, not this one, says what the
family contributes: where the corpus and the surface declaration live,
what the record shapes are, what feeds the projection. This body never
carries family-specific instructions and never improvises them. A
surface that is missing where its estate exists is a conformance
defect: report it and carry on with the rest.

No estate at all → say so and stop; there is nothing to document
against.

**`.ok-planner/` is required for this verb.** It owns the story
catalog the assessments measure, the documentation corpus's home, the
surface declaration, and the issue intake where defects land. Without
it, say so and stop.

Tell the owner which estates are in scope, and what release is being
documented, before dispatching anything.

## The subject

The run documents a **release**: the invocation names a tag or commit,
and every record the run writes is a statement about that commit. With
no argument, document the working tree as it stands and say so in one
line — the stamp is then the current commit, which is the honest
anchor either way. The prior release's **published documentation
corpus**, where one exists, is retrieved from the prior release and
becomes an input to synthesis — it is shipped, user-visible material,
so its contents are legitimate user priors — but none of its
conclusions carry: everything is re-derived and re-warranted at this
release, and nothing tracks staleness between runs.

## The spine

1. **Layout** — each family ensures its own directories exist. Estate
   convergence is the front door's administration (`/ok`), never this
   run's.
2. **Audit** — invoke `/audit` at the release commit as this run's
   first phase, composing it as its own skill, never absorbing its
   logic. Its support determinations set the **delivery criterion**:
   only stories the audit called `supported` are documented as
   delivered — an unsupported story is already an intake issue, not
   deliverable documentation. Audit output steers dispatch and reaches
   the orchestrator only; it never enters the synthesizer's box, and
   assessors form their positions from their own reading.
3. **Project** — the mechanical pass. Read the surface declaration,
   run each declared kind's enumeration source, and build the catalog
   rows and structural reference material by projection from the
   release's own artifacts. An enumeration that errors or returns zero
   members fails loudly unless the kind is marked expected-empty.
   Candidate kinds detected but not declared are reported to the
   owner, never auto-added.
4. **Synthesize** — one cold agent, boxed as described below, reads
   only user-visible material and writes the assumption set: what a
   user would take to be true before anyone checks. Written down
   before any verification begins.
5. **Assess** — batched warm assessors verify every audit-supported
   story-way and every assumption up the warrant ladder below. One
   assessment record per measured way.
6. **Distill** — sort the outcomes. Contradicted assumptions become
   trap records with their evidence sets; contradicted promises are
   defects, filed into the issue intake, never documented as product;
   experiments worth maintaining are named as promotion candidates in
   an intake issue — promotion itself is the owner's act through a
   sprint, never this run's. Every synthesized assumption is recorded
   with its disposition — held, trap, or unverified — never silently
   dropped.
7. **Check** — the mechanical gates, run per each surface's
   instructions: the catalog one-to-one with every enumerated
   population, every held claim carrying an affirmative warrant, every
   citation resolving at the stamp, undispatched items recorded as
   unverified, and the synthesizer transcript scanned for out-of-box
   access (a hit voids the assumption set; re-run the synthesis).
8. **Present** — the report below.
9. **Close-out** — commit the corpus, naming the release it
   describes.

## The warrant ladder

A claim is recorded as **held** only on an affirmative warrant — a
passing run. Verification climbs three rungs and stops at the first
that settles the item:

1. **An existing passing test.** The project's own suite, exercised at
   the release, already covers the behavior — the cheapest warrant,
   found through the story↔test linkages the estates contribute.
2. **Careful reading.** What the story's linkages lead to is read.
   Reading is investigative and never a warrant of its own: it either
   lands the item on a passing test the first rung's search missed —
   that test is then the warrant recorded — or produces the evidence
   set for a contradiction. If it does neither, climb; there is no
   reading-only warrant to record.
3. **An experiment.** A small runnable built for this item, run
   against the release, archived in the corpus with what it observed.

A failing run is **never a finding** — it cannot distinguish a false
assumption from a stale or wrong probe — so it only dispatches
diagnosis. A contradiction (a trap) is warranted by an **evidence set
produced by reading**, with any failed runnable attached as
corroboration, never as the warrant itself. An item the run could not
settle on any rung is recorded as **unverified**, which is an honest
state and not a failure.

## The box

The synthesizer must not hold developer knowledge — traps live in the
gap between developer knowledge and user expectation, and
instruction-only restriction demonstrably fails. Four mechanical
layers, failing independently:

1. **Export, never checkout.** The user-visible inputs — each estate's
   export set per its surface, the rendered surface enumerations, the
   prior release's published corpus — are copied into a scratch
   directory outside the project tree. A checkout would carry the
   source; an export carries only what a user could see.
2. **Minimal launch.** The agent's world is the box: no repository
   path, no shell, no network, read-only file tools only.
3. **Tool-layer denial.** Any access resolving outside the box is
   denied at the tool layer, not by instruction.
4. **Transcript verification.** After the run, the Check phase scans
   the agent's transcript; any out-of-box access voids the output.

The brief is the fixed template below — the orchestrator interpolates
file paths and nothing else. Composing a per-run brief is how
contamination happens.

```
You are looking at the complete user-visible material for a software
product: its story catalog, its published concepts, its declared
user-facing surface, and the documentation published with its previous
release. You have not seen its source code, its tests, or its internal
design notes, and you must not seek them.

Read everything under [BOX PATH].

Then write down what you assume to be true about what this product
does and how it behaves — the expectations a competent user would hold
before ever running it. Work the enumerable sources of expectation:
names that promise observable behavior; symmetry between sibling
elements (if X supports this, its sibling surely does too); the
conventions of the craft this product belongs to; what the published
concepts imply must hold; what the previous release's documentation
leads a reader to expect still holds. Prefer assumptions that are
specific enough to be checked against the product and wrong-able —
"doing X produces Y", never "the product is well-designed".

For each assumption, state: the assumption itself, one sentence on
where it comes from (which source of expectation), and what observable
behavior would confirm or contradict it. Write one entry per
assumption to [OUTPUT PATH]. Do not verify anything; verification is
someone else's job. Do not soften an assumption because you are unsure
of it — unsureness is exactly what makes it worth checking.
```

## The presentation

Compose it in full — it is a report, so it is delivered whole rather
than paced:

```
# Documentation — <project> at <release>

Estates: <the ones in scope>
Audit: <the delivery criterion's numbers: stories supported and
documented / excluded as unsupported, each exclusion named>

Catalog: <per declared kind: members enumerated, rows written; any
kind that failed loudly or came back empty>

Assessments: <stories and ways measured, assumptions synthesized;
held / trap / unverified counts, and which rung settled each count>

Traps: <one line each: the assumption, the actual behavior. The
corpus holds the full records.>

Defects and filings: <every issue this run filed — contradicted
promises, story-fitness findings, promotion candidates — by path.
These are the next planning ceremony's business, not this run's.>
```

## The close-out

Commit the documentation corpus in one commit naming the release it
documents. The records already carry the release stamp — the commit
makes the corpus part of the tree without changing what it is: a
statement about the named release, not a standing verdict. Publishing
the corpus is a separate act with its own machinery, and this run does
not perform it.

## What this skill does NOT do

- Does not carry family knowledge. Everything family-specific comes
  from the ceremony surfaces in the estates present, and nothing else.
- Does not absorb the audit. It invokes `/audit` as its first phase
  and consumes the determinations; one canonical audit body exists.
- Does not document a known gap as product. Unsupported stories and
  contradicted promises are intake issues; the corpus documents what
  held.
- Does not maintain anything between releases. Every run re-derives
  the assumption set, re-warrants every claim, and overwrites the
  corpus whole; the prior corpus is an input, never a cache.
- Does not promote an experiment into the project's test suite. It
  names candidates in the intake; promotion is a sprint's work on the
  owner's ruling.
- Does not edit the design corpus, the surface declaration, or any
  code. Findings about them become issues, not edits.
- Does not publish. The corpus is produced and committed; shipping it
  is a separate publisher's job.
- Does not ask the owner anything mid-run. It measures, records,
  files, presents, and commits.
- Does not converge an estate, materialize a file, or repair a
  family's presence. That is `/ok`, always a user action.
