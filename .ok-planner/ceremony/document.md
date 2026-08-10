# ok-planner — documentation ceremony surface

What the suite's release-documentation ceremony does about this
family's estate. The ceremony owns the spine — audit, project,
synthesize, assess, distill, check, present, close out; this file owns
everything ok-planner contributes to it. Materialized into consumer
projects at `.ok-planner/ceremony/document.md`; the ceremony reads it
there when `.ok-planner/` exists.

## Requires

`.ok-planner/design/` at the project root — the story catalog is what
the assessments measure. Without it there is nothing to document
against: say so and point at `/discover-design`.

A **current audit**. The audit is the ceremony's entire measurement
front (`decision:document-composes-audit`): it rules the surface
partition, determines story support from the user's side, and
determines decision and concept support from the technical side. The
audit is current for this release exactly when the tree's movement
since its stamped commit touches only the audit's own output paths
(the path-scoped rule its ceremony surface states); otherwise the
ceremony runs `/audit` first. The surface declaration and guidance
(`.ok-planner/surface/surface.json`, `.ok-planner/surface/guidance.md`)
are the audit's requirement, checked there, not here.

## Layout

`mkdir -p .ok-planner/documentation/catalog .ok-planner/documentation/assessments .ok-planner/documentation/traps .ok-planner/documentation/evidence .ok-planner/issues`.
Estate convergence is the front door's administration (`/ok`), never
this run's.

`.ok-planner/documentation/` is the corpus's home, beside `audits/`,
and it carries a **record's discipline**: out of agent context by
default, never consulted to understand the current tree, never
reconciled or refreshed by day-to-day sessions. The run overwrites it
whole; prior corpora live at their release tags.

The layout is split along the vantage line
(`decision:documentation-citations-are-product`):

- **Publishable** — `catalog/`, `assessments/`, `traps/`, and the
  concept router `concepts.md`. These speak the shipped vocabulary —
  concepts, stories, and public surface elements — and cite only
  catalog rows at the stamp: `catalog:<kind>/<member>`. A source path,
  a test, or an internal entry point in a publishable record is a
  defect the Check phase flags.
- **Verification layer** — `evidence/` (trap evidence sets) here;
  the surface ruling under `.ok-planner/audits/surface/` and the
  experiment harness under `.ok-planner/experiments/` where the audit
  keeps them. Internal, never shipped; these cite the tree freely
  (`src:<path>` meaning that path **at the stamped commit**, checked
  once at production, never re-verified against the moving tree).

## Audit

The audit's determinations set the delivery criterion: **only stories
the audit called `supported` are documented as delivered.** An
unsupported story is already an intake issue, not deliverable
documentation. The surface ruling
(`.ok-planner/audits/surface/ruling.json`) defines the catalog domain:
its public side, unconditionally — every public element is cataloged
whether or not any story claims it, so absence is answerable. Audit
output steers dispatch and reaches the orchestrator only; it never
enters the synthesis box.

## Project

Catalog files at `documentation/catalog/<kind>.md`, one per declared
kind:

```
---
kind: <kind>
release: <commit>
population: <public members the ruling holds for this kind>
---
```

Then one row per **public** member — `` - `<member>` — <one line> ``,
naming the assessments that measure it where any do. The rows match
the ruling's public side one-to-one; `population:` is the number the
Check phase holds them to. A kind with no public members writes its
file with `population: 0` and no rows. Private members appear
nowhere in the publishable layer.

The router at `documentation/concepts.md` lists the published
concepts — slug and one line each — pointing the reader into the
concept bodies the synthesis box also saw.

## Synthesize

The estate's contribution to the box's export set — the user-visible
material, and nothing else (`decision:cold-boxed-synthesis`):

- every **delivered** story body (the audit-supported set) and their
  TOC entries;
- every concept body under `design/concepts/` and the concept TOC —
  the published concept layer;
- the **rendered public surface**: the ruling's public members per
  kind, rendered as plain member lists — never the ruling file
  itself, which is a verification record;
- the prior release's published documentation corpus (its publishable
  layer only), when one exists.

**Decisions are developer material and never enter the box.** Neither
do audits, the ruling file, experiments, sprints, issues, sketches,
history, or any code or test.

## Assess

Assumptions are verified with the same instrument the audit's story
determinations used: the experiment harness at
`.ok-planner/experiments/`, driven only through elements the ruling
classifies public — re-run what covers a claim, repair what the
extraction diff made suspect, build what is missing. Stories and
assumptions differ only in where the claim came from — promised
versus presumed.

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

The body records what was attempted, what was observed, and the
**unverified remainder** — stated in the record, never left silent —
in the shipped vocabulary, citing catalog rows. An `outcome: held`
requires an `experiment:` warrant — a passing experiment driven
through the public surface at the release; a reading is never a
warrant, a failed run is never a warrant, and the project's tests are
never warrants for user-vantage claims (`warrant: none` is legal only
with `outcome: unverified`). A story the product honors through
several ways carries several assessments; the demonstrated path is
the product of the record, the outcome a byproduct.

**The attestation rule.** Published silence about an assumption is
honest only because a record attests the measurement: every
synthesized assumption ends the run holding an assessment record
(held or unverified) or a trap record — never nothing.

**Story defects and fitness are the audit's findings, not this
run's.** A story the product contradicts is `unsupported` in the
audit, already an intake issue from its judge; a story that cannot be
measured as written is `unclear` there, likewise filed. This run
consumes those determinations — it documents the supported stories
and files nothing about the rest.

## Distill

Trap records at `documentation/traps/<slug>.md`:

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
actual behavior, and — where the actual behavior is demonstrable
through the public surface — the passing demonstration experiment,
which is the evidence set's strongest member. The full **evidence
set** that warrants the contradiction lives at
`documentation/evidence/<slug>.md` (frontmatter `trap:`, `release:`),
may rest on reading, cites the tree freely, and never ships. A trap
never rests on a failed run alone; a failed runnable may be attached
to the evidence set as corroboration, never as the warrant.

**Filing.** One kind of intake issue leaves this run, per the
estate's issue-file conventions and the gated-writers decision
(`decision:audit-audience-split`): the **promotion candidate** — an
experiment this run had to build, passing at the stamp, that would
have to be maintained to keep. Never a failed run, never an opinion
of the product. Promotion is the owner's act through the intake and a
sprint, never this run's. Contradicted promises and unmeasurable
stories are the audit's filings, made by its judge before this run
consumed the determinations.

## Check

Run `.ok-planner/bin/document-check`. If the project has not
converged, fall back to the payload's `scripts/document-check` and
**announce the fallback verbatim in the report**, on its own line,
before the findings: `note: no vendored checker — using the payload's
copy; /ok pins one to this project`. An unpinned verdict is never
delivered silently.

The checker validates the produced corpus mechanically: the release
stamp on every record, every `held` claim carrying an `experiment:`
warrant, trap records naming their evidence sets, catalog counts
agreeing with the ruling's public side, unverified remainders present
where climbing stopped, publishable records free of tree citations
with their catalog-row citations resolving against the ruling at the
stamp, and verification-layer citations resolving in the stamped
tree. Its output is authoritative; do not re-derive its checks by
reading.

## Present

```
## ok-planner

Audit: <current at <sha> — reused | run by this ceremony>
Corpus: <records written, by kind: catalog rows, assessments, traps,
evidence sets>
Attestation: <assumptions synthesized / accounted for — the two
numbers must agree>
Filed: <promotion candidates, by path — the run's only filings>
```

## Boundaries

- Never edits `design/`. A story the product contradicts is the audit
  judge's intake issue, never a story rewritten to match the product.
- Never re-measures what the audit determined. Story support and the
  surface partition are consumed, not re-derived; this run measures
  assumptions.
- Never writes the surface declaration or guidance, and never writes
  the ruling — those are the owner's and the audit's.
- Never puts a source path, test, or internal entry point in a
  publishable record. The shipped layer speaks the shipped vocabulary.
- Never promotes an experiment. The intake carries the candidate; a
  sprint does the work.
- Never publishes. The corpus is committed to the estate; shipping its
  publishable layer is a separate publisher's job.
- Never reads sprints, sketches, or history — records are out of
  context; the prior published corpus enters only as the box's input.

<!-- Materialized by ok-planner v15.2.0 — suite-owned; overwritten on converge; do not hand-edit. -->
