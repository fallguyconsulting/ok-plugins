# ok-planner — documentation ceremony contribution

What the suite's release-documentation ceremony does about this
family's estate. The ceremony owns the spine — audit, project,
assess, distill, check, present, close out; this file owns everything
ok-planner contributes to it. Materialized into consumer projects at
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

## Layout

`mkdir -p .ok-planner/documentation/catalog .ok-planner/documentation/assessments .ok-planner/documentation/traps .ok-planner/documentation/evidence`.
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
  a test, or an internal entry point does not belong in a publishable
  record; the writers keep tree citations to the verification layer.
- **Verification layer** — `evidence/` (trap evidence sets) here; the
  surface extraction under `.ok-planner/audits/surface/`, the audit's
  determinations and assumption records under `.ok-planner/audits/`,
  and the experiments under `.ok-planner/experiments/` where the audit
  keeps them. Internal, never shipped; these cite the tree freely
  (`src:<path>` meaning that path **at the stamped commit**, checked
  once at production, never re-verified against the moving tree).

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

**Filing: none.** This run files nothing at all
(`decision:audit-audience-split`): nomination candidates — the
experiments the audit had to build, passing at the stamp — were filed
by the audit's own distillation, and contradicted promises by its
judge, before this run consumed the records.

## Present

```
## ok-planner

Audit: <current at <sha> — reused | run by this ceremony>
Corpus: <records written, by kind: catalog rows, assessments, traps,
evidence sets>
Attestation: <assumptions the audit synthesized / accounted for — the
two numbers must agree>
Filed: none — the audit's judge and distillation hold the filing
paths.
```

When this ceremony ran the audit itself, fold the audit's run report
into the wrap-up: its receipt counts, the issues and nominations it
filed, the traps it recorded — one presentation covering both
ceremonies.

## Boundaries

- Never edits `design/`. A story the product contradicts is the audit
  judge's intake issue, never a story rewritten to match the product.
- Never measures anything. Story support, assumption dispositions,
  and the surface partition are consumed, not re-derived; no
  synthesis, no experiments, no box runs here.
- Never writes the surface intent, and never writes the extraction or
  any audit record — the intent is the owner's, and the extraction
  and audit records are the audit's.
- Never files. The audit's judge and distillation are the measurement
  front's only filing paths; construction has none.
- Never puts a source path, test, or internal entry point in a
  publishable record. The shipped layer speaks the shipped vocabulary.
- Never adopts an experiment into the project's suites. The intake
  carries the audit's nomination; a sprint does the work.
- Never publishes. The corpus is committed to the estate; shipping its
  publishable layer is a separate publisher's job.
- Never reads sprints, sketches, or history — records are out of
  context; the audit's run report in the archive is read as the
  wrap-up's input, and for nothing else.

<!-- Materialized by ok-planner v16.0.0 — suite-owned; overwritten on converge; do not hand-edit. -->
