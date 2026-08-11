---
name: document
description: "ONLY activated by explicit /document slash command. Never auto-triggered by conversation content. The suite's release-documentation ceremony, covering every estate this project has: ensures a current audit at the release (running /audit when the tree has moved past its stamp), then constructs the documentation corpus from the audit's records — the catalog projected over the extraction's public side, assessments from the story and assumption determinations, the trap registry from the assumption dispositions — measuring nothing itself, and leaves behind a commit-stamped corpus split along the vantage line: a publishable layer in shipped vocabulary, a verification layer that stays internal. Produced fresh at every release, never carried forward."
---

# Document (the release run)

Documentation here is a **measured assessment**, not maintained prose:
every claim the produced corpus makes rests on a warrant the audit
took at this release, every element the surface extraction records
public is cataloged whether or not any story claims it, and the corpus
is stamped with the release commit it describes — a snapshot that is
allowed to go stale because nothing treats it as a source of truth.

This is a **suite verb**, not any one family's. One canonical body
covers whichever skill families the project integrates, and which those
are is read from the filesystem when the verb runs — never fixed when
it was vendored.

## The audit is the measurement front

**This ceremony measures nothing.** The audit dispatches a surface
extractor subagent that writes the run's surface extraction,
determines story support from the user's side (experiments driven
through the extraction's public elements on the maintained
experiments), determines decision and concept support from the
technical side, and forms and verifies the assumptions in its own
boxed synthesis. This run **constructs** from those records: the
supported stories are the delivery criterion, the extraction's public
side is the catalog domain, the story and assumption determinations
become the assessments, and the assumption dispositions become the
trap registry. Composition, never absorption — one canonical audit
body exists, and the two ceremonies cannot drift apart on what an
audit is.

## The two spines

Two independent drivers produce the corpus, and neither substitutes for
the other:

- **The extraction's public side drives the catalog, unconditionally.**
  Every element the surface extraction records public gets a catalog
  row whether or not any story claims it. That is what makes absence
  answerable: a reader can trust that what is not in the catalog does
  not exist. Internal elements appear nowhere in the publishable layer.
- **The audit's measurements drive the assessments.** The story
  determinations say how the product's promises played out; the
  assumption dispositions say how a user's priors played out. The
  divergence set — the traps — is the content a user cannot derive
  from the surface alone, and it arrives here already measured.

## The vantage split

The corpus the run leaves behind has two layers, and the line between
them is the reader's vantage:

- **The publishable layer** — catalog, assessments, traps, the
  concept router — speaks entirely in the shipped vocabulary:
  concepts, stories, and public surface elements. Its citations
  resolve to catalog rows at the stamp; no publishable record names a
  source path, a test, or an internal entry point.
- **The verification layer** — the surface extraction, the audit's
  determinations and assumption records, the experiments, trap
  evidence sets — is what makes the publishable layer honest. Its
  reader is the process itself, so it cites the tree freely, and it
  never ships.

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
family's **ceremony contribution**. That file, not this one, says what
the family contributes: where the corpus lives, how its layers split,
what the record shapes are, what feeds the projection. This body never
carries family-specific instructions and never improvises them. A
contribution that is missing where its estate exists is a conformance
defect: report it and carry on with the rest.

No estate at all → say so and stop; there is nothing to document
against.

**`.ok-planner/` is required for this verb.** It owns the story
catalog, the documentation corpus's home, and the audit whose records
this run constructs from. Without it, say so and stop.

Tell the owner which estates are in scope, and what release is being
documented, before anything else.

## The subject

The run documents a **release**: the invocation names a tag or commit,
and every record the run writes is a statement about that commit. With
no argument, document the working tree as it stands and say so in one
line — the stamp is then the current commit, which is the honest
anchor either way. The prior release's **published documentation
corpus**, where one exists, is an input to the *audit's* assumption
synthesis — shipped, user-visible material, legitimate user priors —
never to this run's construction: none of its conclusions carry, and
nothing tracks staleness between runs.

## The spine

1. **Layout** — each family ensures its own directories exist. Estate
   convergence is the front door's administration (`/ok`), never this
   run's.
2. **Ensure a current audit.** The audit is current for this release
   exactly when the diff from its stamped commit to the release tree
   touches only the audit's own output paths — the path-scoped rule
   the audit's close-out states; no tracked state, just git. Current →
   say so in one line and construct from it. Not current, or none
   exists → invoke `/audit` now, composing it as its own skill, never
   absorbing its logic; invoked this way it ends silently at its
   stamp, and this run's wrap-up covers both ceremonies. Either way
   the run proceeds on the audit's determinations, its assumption
   records, and its surface extraction.
3. **Project** — the mechanical pass. Read the surface extraction's
   public members and build the catalog rows and structural reference
   material by projection from the release's own artifacts, one row
   per public member per kind. The extraction is consumed, never
   recomputed; a partition question this phase cannot answer from
   the extraction means the audit is not current after all — go back
   to the previous step.
4. **Assess** — construct the assessment records from the audit's
   measurements: one assessment per measured story-way and per
   assumption, its held claim citing the passing experiments the
   audit ran at the stamp as its warrant. This run runs nothing; an
   item the audit could not measure is recorded as unverified, which
   is an honest state and not a failure.
5. **Distill the traps** — every assumption record the audit closed
   with `disposition: trap` becomes a trap record: the shipped
   statement in surface terms in the publishable layer, the evidence
   set in the verification layer. Contradicted promises and
   unmeasurable stories are already intake issues from the audit's
   judge — never documented as product, and never re-filed here.
   Every assumption arrives carrying a disposition — held, trap, or
   unverified — and every one is represented, never silently dropped.
6. **Present** — the wrap-up, composed from the audit's run report and
   this run's construction counts. When this run invoked the audit,
   the wrap-up covers both ceremonies — the audit presented nothing at
   its stamp — reading the same report as an input.
7. **Close-out** — commit the corpus, naming the release it
   describes.

## Warrants

A claim is recorded as **held** only on an affirmative warrant: a
passing experiment driven through the extraction's public elements at
the stamped commit — taken by the audit, on the maintained experiments.
This run takes no runs and grants no warrants of its own: it cites the
audit's. Reading is never a warrant, the project's tests are never
warrants for user-vantage claims, and a failing run is never a
finding. A trap is warranted by an **evidence set**, with a passing
demonstration of the actual behavior through the surface as its
strongest member where one is possible, and any failed runnable
attached as corroboration, never as the warrant itself.

## The presentation

Compose it in full — it is a report, so it is delivered whole rather
than paced:

```
# Documentation — <project> at <release>

Estates: <the ones in scope>
Audit: <current at <sha> — reused | run by this ceremony (its counts
folded in below). Then the delivery criterion's numbers: stories
supported and documented / excluded as unsupported, each exclusion
named>

Catalog: <per kind: public members in the extraction, rows written;
the internal count left uncataloged>

Assessments: <ways recorded for delivered stories, assumptions the
audit measured; held / trap / unverified counts>

Traps: <one line each: the assumption, the actual behavior. The
corpus holds the full records.>

Filings: <none — this run files nothing. The audit's judge and
distillation filed its issues and nominations, named in its run
report; they are the next planning ceremony's business.>
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
  from the ceremony contributions in the estates present, and nothing
  else.
- Does not absorb the audit, and does not repeat a current one. It
  constructs from the audit's records, running `/audit` only when the
  path-scoped rule says the stamp is behind the release.
- Does not measure anything. No synthesis, no experiments, no box:
  story support, assumption dispositions, and the surface partition
  all arrive from the audit, already determined.
- Does not document a known gap as product. Unsupported stories are
  the audit judge's intake issues; the corpus documents what held.
- Does not file anything. The audit's judge and distillation are the
  measurement front's only filing paths, and construction has none.
- Does not put a source path, test, or internal entry point in a
  publishable record. The shipped layer speaks the shipped vocabulary;
  tree citations live in the verification layer.
- Does not maintain anything between releases. Every run re-derives
  the corpus whole from a current audit; the prior published corpus
  feeds the audit's synthesis, never this construction.
- Does not edit the design corpus, the surface intent, the surface
  extraction, any audit record, or any code.
- Does not publish. The corpus is produced and committed; shipping it
  is a separate publisher's job.
- Does not ask the owner anything mid-run. The audit asks nothing
  either — its surface extractor files intake issues for ambiguities
  and defaults them internal for the run — so this run constructs,
  presents, and commits.
- Does not converge an estate, materialize a file, or repair a
  family's presence. That is `/ok`, always a user action.

<!-- Materialized by ok v16.0.0 — suite-owned; overwritten on converge; do not hand-edit. -->
