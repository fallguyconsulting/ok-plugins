---
name: document
description: "ONLY activated by explicit /document slash command. Never auto-triggered by conversation content. The suite's release-documentation ceremony, covering every estate this project has: ensures a current audit at the release (running /audit when the tree has moved past its stamp), settles the declared document types in the documentation walk (inside the audit it invoked, or against a reused audit's extraction), constructs the documentation corpus's records from the audit's records — the catalog projected over the extraction's public side, assessments from the story and assumption determinations, the trap registry from the assumption dispositions — measuring nothing itself, then brings each declared type's document up to date in the tree — revising what is there, writing one where none exists — and stamps it with the release. Leaves behind a commit-stamped corpus split along the vantage line: a publishable layer in shipped vocabulary, a verification layer that stays internal, and the documents in the tree. The records are produced fresh at every release; the documents accumulate."
---

# Document (the release run)

A release brings the project's documentation up to date, in two tiers. The **records** are a measured assessment: every claim rests on a warrant the audit took at this release, and every element the surface extraction records public is cataloged whether or not any story claims it. The run writes them fresh each time. The **documents** are self-contained texts — one per document type the owner declares — living in the tree where readers expect them, revised at each release against the type, the records, and the tree. Both carry the release commit they were verified against. Neither is a source of truth: an agent reads one only when directed to it.

This is a **suite verb**, not any one family's. One canonical body covers whichever families the project integrates, read from the filesystem when the verb runs.

## The audit is the measurement front

**This ceremony measures nothing.** The audit writes the surface extraction, determines story support from the user's side, determines decision and concept support from the technical side, and forms and verifies the assumptions in its own boxed synthesis. This run **constructs** from those records: the supported stories are the delivery criterion, the extraction's public side is the catalog domain, the story and assumption determinations become the assessments, and the assumption dispositions become the trap registry. Composition, never absorption — one canonical audit body exists, so the two ceremonies cannot drift apart on what an audit is.

## The three drivers

Three independent drivers produce the corpus, and none substitutes for another:

- **The extraction's public side drives the catalog, unconditionally.** Every public element gets a catalog row whether or not any story claims it, so a reader can trust that what is not in the catalog does not exist. Internal elements appear nowhere in the publishable layer.
- **The audit's measurements drive the assessments.** The story determinations say how the product's promises played out; the assumption dispositions say how a user's priors played out. The divergence set — the traps — is the content a user cannot derive from the surface, and it arrives already measured.
- **The declared document types drive the documents.** Each type under `.ok-planner/surface/documents/` owns exactly one document, brought up to date by its own writer at the type's target. No type, no document: nothing is written at a path no type claims.

## The vantage split

The corpus has two layers, split by the reader's vantage:

- **The publishable layer** — catalog, assessments, traps, the concept router — speaks the shipped vocabulary: concepts, stories, public surface elements. Its citations resolve to catalog rows at the stamp; no publishable record names a source path, a test, or an internal entry point.
- **The verification layer** — the surface extraction, the audit's determinations and assumption records, the experiments, trap evidence sets — cites the tree freely and never ships.
- **The documents** sit on the publishable side but outside the records' citation regime: self-contained, citing no record, carrying no warrant state, opening with the provenance stamp naming the release commit they were verified against and this ceremony.

## Resolve the estates

Every family's presence is a filesystem check at the project root — the nearest ancestor of the working directory (itself included) holding an estate directory, never derived from `.git`:

| estate | family |
|---|---|
| `.ok-planner/` | ok-planner |
| `.ok-plumbline/` | ok-plumbline |
| `.ok-workspaces/` | ok-workspaces |

For each estate present, read `<estate>/ceremony/document.md` — the family's **ceremony contribution**. That file, not this one, says what the family contributes: where the corpus lives, how its layers split, the record shapes, what feeds the projection. This body never carries family-specific instructions and never improvises them. A contribution missing where its estate exists is a conformance defect: report it and carry on.

No estate at all → say so and stop; there is nothing to document against.

**`.ok-planner/` is required for this verb.** It owns the story catalog, the document types, the documentation corpus's home, and the audit whose records this run constructs from. Without it, say so and stop.

Tell the owner which estates are in scope, and what release is being documented, before anything else.

## The subject

The run documents a **release**: the invocation names a tag or commit, and every record is a statement about that commit. With no argument, document the working tree as it stands and say so in one line; the stamp is then the current commit. The prior release's **published documentation corpus**, where one exists, is an input to the *audit's* assumption synthesis — shipped, user-visible material, legitimate user priors — never to this run's construction: none of its conclusions carry, and nothing tracks staleness between runs.

## The spine

1. **Layout** — each family ensures its own directories exist. Estate convergence is the front door's administration (`/ok`), never this run's.
2. **Ensure a current audit.** The audit is current for this release exactly when the diff from its stamped commit to the release tree touches only the audit's own output paths — the path-scoped rule the audit's close-out states; no tracked state, just git. Current → say so in one line and construct from it. Not current, or none exists → invoke `/audit` now, composing it as its own skill, never absorbing its logic; invoked this way it runs the documentation walk immediately after its extractor returns, ends silently at its stamp, and this run's wrap-up covers both ceremonies. Either way the run proceeds on the audit's determinations, its assumption records, and its surface extraction.
3. **Walk** — the documentation walk, run only when the audit was reused: the owning contribution's Walk section, driven against the reused audit's extraction — the extraction's public side read against the declared document types, only the deltas raised, the owner's rulings landed as type files, a type left unsettled left out for the run and filed as an intake issue by the walk's own rule, one line and no question when nothing changed. When this run invoked the audit, the audit ran the same walk immediately after its extractor returned, and this step is skipped. Either way the walk is this run's one owner conversation, and it is over before construction begins. Once it lands — at whichever call site — hand the owner the `/goal` handoff line naming the vendored goal file at `.ok-planner/ceremony/document-goal.md`; the run then proceeds hands-free whether or not the owner sets the goal.
4. **Project** — gated by the handoff: the walk's last act, at either call site, is showing the owner the `/goal` line; if it has not appeared in the conversation, show it now before anything else. Then the mechanical pass. Read the surface extraction's public members and build the catalog rows and structural reference material by projection from the release's own artifacts, one row per public member per kind. The extraction is consumed, never recomputed; a partition question this phase cannot answer from the extraction means the audit is not current after all — go back to the previous step.
5. **Assess** — construct the assessment records from the audit's measurements: one assessment per measured story-way and per assumption, its held claim citing the passing experiments the audit ran at the stamp as its warrant. This run runs nothing; an item the audit could not measure is recorded as unverified — an honest state, not a failure.
6. **Distill the traps** — every assumption record the audit closed with `disposition: trap` becomes a trap record: the shipped statement in surface terms in the publishable layer, the evidence set in the verification layer. Contradicted promises and unmeasurable stories are already intake issues from the audit's judge — never documented as product, never re-filed here. Every assumption arrives carrying a disposition and every one is represented, never silently dropped.
7. **Generate** — one writer per declared document type, dispatched per the owning contribution's Generate section: briefed with the type, the document already at the type's target, the extraction's public side, the records this run constructed as orientation, and the tree at the release commit. A type carrying a Method — the owner's steps for how the writer produces the document — gets that run first, as sonnet dispatches per the owning contribution's Generate section, and the writer takes the findings as one more input. The writer revises the document that is there and composes one only where the target is empty, keeping every sentence the tree still supports, verifying what it states against the tree at the stamp, and leaving a self-contained document — no record citations, no warrant fields — opening with the provenance stamp. It writes that document at the type's target, the one place the document lives. Where any type targets a path under `docs/` — `docs/` itself as a folder target included — the step also writes `docs/CLAUDE.md` carrying the record rule, and where none does any more it removes the `docs/CLAUDE.md` a prior run wrote. Only declared targets are written.
8. **Present** — the wrap-up, composed from the audit's run report and this run's construction counts. When this run invoked the audit, the wrap-up covers both ceremonies — the audit presented nothing at its stamp — reading the same report as an input.
9. **Close-out** — commit the records and the revised documents, naming the release they describe.

## Warrants

A claim is recorded as **held** only on an affirmative warrant: a passing experiment driven through the extraction's public elements at the stamped commit — taken by the audit, on the maintained experiments. This run takes no runs and grants no warrants of its own: it cites the audit's. Reading is never a warrant, the project's tests are never warrants for user-vantage claims, and a failing run is never a finding. A trap is warranted by an **evidence set**, with a passing demonstration of the actual behavior through the surface as its strongest member where one is possible, and any failed runnable attached as corroboration, never as the warrant.

## The presentation

Compose it in full — it is a report, delivered whole:

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

Documents: <types declared (and any left out for the run, each named
with its intake issue); documents revised and created, by target
path, one line each on what changed>

Filings: <none — this run files nothing. The audit's judge and
surface extractor filed its issues, named in its run report; they
are the next planning ceremony's business.>
```

## The close-out

Commit the documentation records and the revised documents in one commit naming the release they document. The records and documents already carry the release stamp; the commit makes them part of the tree without changing what they are — statements about the named release, not standing verdicts. Writing a document at its type's target is this run's act; publishing outside the repository is a separate act this run never performs, and the verification layer is never published at all.

## What this skill does NOT do

- Does not carry family knowledge. Everything family-specific comes from the ceremony contributions in the estates present.
- Does not absorb the audit, and does not repeat a current one. It constructs from the audit's records, running `/audit` only when the path-scoped rule says the stamp is behind the release.
- Does not measure anything. No synthesis, no experiments, no box: story support, assumption dispositions, and the surface extraction arrive from the audit, already determined. A writer's check of its own sentences against the tree is reading for accuracy, never a warrant, and grants no held state. A document type's Method runs whatever the owner names, and its findings are never a warrant.
- Does not document a known gap as product. Unsupported stories are the audit judge's intake issues; the corpus documents what held.
- Does not file anything. The audit's judge and surface extractor are the measurement front's only filing paths; construction has none.
- Does not put a source path, test, or internal entry point in a publishable record. Tree citations live in the verification layer; a generated document cites nothing at all.
- Does not maintain anything between releases. Every run re-derives the records whole from a current audit and revises the documents at that release; the prior published documentation feeds the audit's synthesis, never this construction.
- Does not rewrite a document from scratch when one is already at the target. It revises, keeping what the tree still supports — an owner's hand edits included.
- Does not edit the design corpus, the surface intent, the surface extraction, any audit record, or any code. The document types are written only in the documentation walk, with the owner.
- Does not write a document at any path no declared type targets, and does not publish outside the repository.
- Does not ask the owner anything after the documentation walk. The walk is the run's one owner conversation, over before construction begins; the audit's autonomous portion asks nothing, so this run constructs, generates, presents, and commits.
- Does not converge an estate, materialize a file, or repair a family's presence. That is `/ok`, always a user action.

<!-- Materialized by ok v19.0.0 — suite-owned; overwritten on converge; do not hand-edit. -->
