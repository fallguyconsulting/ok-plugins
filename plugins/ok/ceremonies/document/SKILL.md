---
name: document
description: "ONLY activated by explicit /document slash command. Never auto-triggered by conversation content. The suite's release-documentation ceremony, covering every estate this project has: ensures a current audit at the release (running /audit when the tree has moved past its stamp), consumes its determinations and surface ruling, synthesizes user-vantage assumptions in a boxed cold agent, verifies them on the maintained experiment harness through the ruled public surface, and leaves behind a commit-stamped documentation corpus split along the vantage line — a publishable layer in shipped vocabulary, a verification layer that stays internal — produced fresh at every release, never carried forward."
---

# Document (the release run)

Documentation here is a **measured assessment**, not maintained prose:
every claim the produced corpus makes rests on a warrant taken at this
release, every element the surface ruling classifies public is
cataloged whether or not any story claims it, and the corpus is
stamped with the release commit it describes — a snapshot that is
allowed to go stale because nothing treats it as a source of truth.

This is a **suite verb**, not any one family's. One canonical body
covers whichever skill families the project integrates, and which those
are is read from the filesystem when the verb runs — never fixed when
it was vendored.

## The audit is the measurement front

This ceremony measures nothing the audit already determined. The
audit rules the surface partition, determines story support from the
user's side (experiments driven through the ruled public surface on
the maintained harness), and determines decision and concept support
from the technical side. This run **consumes** those determinations:
the supported stories are the delivery criterion, the ruling's public
side is the catalog domain, and the same harness machinery verifies
the assumptions this run synthesizes. Composition, never absorption —
one canonical audit body exists, and the two ceremonies cannot drift
apart on what an audit is.

## The two spines

Two independent drivers produce the corpus, and neither substitutes for
the other:

- **The ruled public surface drives the catalog, unconditionally.**
  Every element the surface ruling classifies public gets a catalog
  row whether or not any story claims it. That is what makes absence
  answerable: a reader can trust that what is not in the catalog does
  not exist. Private elements appear nowhere in the publishable layer.
- **Stories and assumptions drive the assessments.** The story catalog
  says what the product promises; the synthesized assumptions say what
  a user would take for granted. Both are measured against the release
  from the user's side, and the divergence set — the traps — is the
  content a user cannot derive from the surface alone.

## The vantage split

The corpus the run leaves behind has two layers, and the line between
them is the reader's vantage:

- **The publishable layer** — catalog, assessments, traps, the
  concept router — speaks entirely in the shipped vocabulary:
  concepts, stories, and public surface elements. Its citations
  resolve to catalog rows at the stamp; no publishable record names a
  source path, a test, or an internal entry point.
- **The verification layer** — the surface ruling, the experiment
  harness, trap evidence sets — is what makes the publishable layer
  honest. Its reader is the process itself, so it cites the tree
  freely, and it never ships.

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
family contributes: where the corpus lives, how its layers split, what
the record shapes are, what feeds the projection. This body never
carries family-specific instructions and never improvises them. A
surface that is missing where its estate exists is a conformance
defect: report it and carry on with the rest.

No estate at all → say so and stop; there is nothing to document
against.

**`.ok-planner/` is required for this verb.** It owns the story
catalog the assessments measure, the documentation corpus's home, the
audit whose determinations this run consumes, and the issue intake
where defects land. Without it, say so and stop.

Tell the owner which estates are in scope, and what release is being
documented, before dispatching anything.

## The subject

The run documents a **release**: the invocation names a tag or commit,
and every record the run writes is a statement about that commit. With
no argument, document the working tree as it stands and say so in one
line — the stamp is then the current commit, which is the honest
anchor either way. The prior release's **published documentation
corpus** (its publishable layer), where one exists, is retrieved from
the prior release and becomes an input to synthesis — it is shipped,
user-visible material, so its contents are legitimate user priors —
but none of its conclusions carry: everything is re-derived and
re-warranted at this release, and nothing tracks staleness between
runs.

## The spine

1. **Layout** — each family ensures its own directories exist. Estate
   convergence is the front door's administration (`/ok`), never this
   run's.
2. **Ensure a current audit.** The audit is current for this release
   exactly when the diff from its stamped commit to the release tree
   touches only the audit's own output paths — the path-scoped rule
   the audit's close-out states; no tracked state, just git. Current →
   say so in one line and consume it. Not current, or none exists →
   invoke `/audit` now, composing it as its own skill, never absorbing
   its logic. Either way the run proceeds on the audit's
   determinations and its surface ruling; audit output steers dispatch
   and reaches the orchestrator only — it never enters the
   synthesizer's box.
3. **Project** — the mechanical pass. Read the surface ruling's public
   side and build the catalog rows and structural reference material
   by projection from the release's own artifacts, one row per public
   member per kind. The ruling is consumed, never recomputed; a
   partition question this phase cannot answer from the ruling means
   the audit is not current after all — go back to the previous step.
4. **Synthesize** — one cold agent, boxed as described below, reads
   only user-visible material — the delivered stories, the published
   concepts, the rendered public surface, the prior published
   corpus — and writes the assumption set: what a user would take to
   be true before anyone checks. Written down before any verification
   begins.
5. **Assess** — batched warm assessors verify every assumption — and
   record every delivered story-way — under the warrant rule below,
   on the same experiment harness the audit's story determinations
   ran. One assessment record per measured way.
6. **Distill** — sort the outcomes. Contradicted assumptions become
   trap records — shipped statement in surface terms, evidence set in
   the verification layer. Experiments this run had to build, passing
   at the stamp, are named as promotion candidates in an intake
   issue — the run's only filings; promotion itself is the owner's act
   through a sprint, never this run's. Contradicted promises and
   unmeasurable stories are already intake issues from the audit's
   judge — never documented as product, and never re-filed here. Every
   synthesized assumption is recorded with its disposition — held,
   trap, or unverified — never silently dropped.
7. **Check** — the mechanical gates, run per each surface's
   instructions: the catalog one-to-one with the ruling's public side,
   every held claim carrying its experiment warrant, publishable
   records clean of tree citations with their catalog-row citations
   resolving at the stamp, verification-layer citations resolving in
   the stamped tree, undispatched items recorded as unverified, and
   the synthesizer transcript scanned for out-of-box access (a hit
   voids the assumption set; re-run the synthesis).
8. **Present** — the report below.
9. **Close-out** — commit the corpus, naming the release it
   describes.

## The warrant rule

A claim is recorded as **held** only on an affirmative warrant: a
passing experiment driven through the ruled public surface at the
release. Verification runs on the **maintained harness** — an
archived experiment covering the claim is re-run at the stamp, one
the surface diff makes suspect is repaired first, and a claim no
archived experiment covers gets a new one.

**Reading is investigative and never a warrant**: it locates,
diagnoses, and builds evidence sets. **The project's tests are never
warrants for user-vantage claims** — a test may reach behind the
surface and prove something no user can reach — though they may steer
diagnosis. A failing run is **never a finding** — it cannot
distinguish a false assumption from a stale or wrong probe — so it
only dispatches diagnosis. A contradiction (a trap) is warranted by
an **evidence set**, with a passing demonstration of the actual
behavior through the surface as its strongest member where one is
possible, and any failed runnable attached as corroboration, never as
the warrant itself. An item the run could not settle is recorded as
**unverified**, which is an honest state and not a failure.

## The box

The synthesizer must not hold developer knowledge — traps live in the
gap between developer knowledge and user expectation, and
instruction-only restriction demonstrably fails. Four mechanical
layers, failing independently:

1. **Export, never checkout.** The user-visible inputs — the delivered
   stories and published concepts per each estate's export set, the
   rendered public surface from the ruling, the prior release's
   published corpus — are copied into a scratch directory outside the
   project tree. A checkout would carry the source; an export carries
   only what a user could see.
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
product: its story catalog, its published concepts, its public
surface, and the documentation published with its previous release.
You have not seen its source code, its tests, or its internal design
notes, and you must not seek them.

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
Audit: <current at <sha> — reused | run by this ceremony. Then the
delivery criterion's numbers: stories supported and documented /
excluded as unsupported, each exclusion named>

Catalog: <per kind: public members in the ruling, rows written; the
private count left uncataloged>

Assessments: <ways recorded for delivered stories, assumptions
synthesized; held / trap / unverified counts; experiments re-run /
repaired / built for this run's own verification>

Traps: <one line each: the assumption, the actual behavior. The
corpus holds the full records.>

Filings: <the promotion candidates this run filed, by path — its only
filings. These are the next planning ceremony's business, not this
run's. Contradicted promises and unmeasurable stories were the
audit's filings, named in its own report.>
```

## The close-out

Commit the documentation corpus in one commit naming the release it
documents. The records already carry the release stamp — the commit
makes the corpus part of the tree without changing what it is: a
statement about the named release, not a standing verdict. Publishing
the **publishable layer** is a separate act with its own machinery,
and this run does not perform it; the verification layer is never
published at all.

## What this skill does NOT do

- Does not carry family knowledge. Everything family-specific comes
  from the ceremony surfaces in the estates present, and nothing else.
- Does not absorb the audit, and does not repeat a current one. It
  consumes the audit's determinations and ruling, running `/audit`
  only when the path-scoped rule says the stamp is behind the release.
- Does not re-measure story support or the surface partition. Those
  are the audit's determinations; this run measures assumptions and
  records the delivered ways.
- Does not document a known gap as product. Unsupported stories are
  the audit judge's intake issues; the corpus documents what held.
- Does not file defects or fitness findings of its own. Its only
  filings are promotion candidates, per the gated-writers rule.
- Does not put a source path, test, or internal entry point in a
  publishable record. The shipped layer speaks the shipped vocabulary;
  tree citations live in the verification layer.
- Does not maintain anything between releases. Every run re-derives
  the assumption set, re-warrants every claim, and overwrites the
  corpus whole; the prior corpus is an input, never a cache. The
  harness's runnables do carry — as instruments, never as conclusions.
- Does not promote an experiment into the project's test suite. It
  names candidates in the intake; promotion is a sprint's work on the
  owner's ruling.
- Does not edit the design corpus, the surface declaration, the
  guidance, the ruling, or any code. Findings about them become
  issues, not edits.
- Does not publish. The corpus is produced and committed; shipping it
  is a separate publisher's job.
- Does not ask the owner anything mid-run. Its measurement front — the
  audit — holds the one interactive moment; this run measures,
  records, files, presents, and commits.
- Does not converge an estate, materialize a file, or repair a
  family's presence. That is `/ok`, always a user action.
