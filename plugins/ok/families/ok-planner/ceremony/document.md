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

`.ok-planner/surface.json` — the **surface declaration**: the owner's
committed list of the product's user-facing surface kinds, each paired
with a mechanical enumeration source. Shape:

```json
{
  "kinds": [
    { "kind": "cli-verbs",
      "enumerate": "<command whose stdout is one member per line>",
      "expectedEmpty": false }
  ]
}
```

The declaration is owner-owned like a stack profile: detection may
propose a kind, only the owner declares it, and the file is written
only as transcription of the owner's explicit answers. A project
without one has no catalog spine — say so, report any candidate kinds
detected, and let the assessment spine run over the story catalog
alone.

## Layout

`mkdir -p .ok-planner/documentation/catalog .ok-planner/documentation/assessments .ok-planner/documentation/traps .ok-planner/documentation/experiments .ok-planner/issues`.
Estate convergence is the front door's administration (`/ok`), never
this run's.

`.ok-planner/documentation/` is the corpus's home, beside `audits/`,
and it carries a **record's discipline**: out of agent context by
default, never consulted to understand the current tree, never
reconciled or refreshed by day-to-day sessions. The run overwrites it
whole; prior corpora live at their release tags.

## Project

Catalog files at `documentation/catalog/<kind>.md`, one per declared
kind:

```
---
kind: <kind>
release: <commit>
population: <count the enumerator returned>
---
```

Then one row per enumerated member — `` - `<member>` — <one line> ``,
naming the assessments that measure it where any do. The rows match
the enumerated population one-to-one; `population:` is the number the
Check phase holds them to. A kind marked expected-empty writes its
file with `population: 0` and no rows.

The corpus's reader handoff is the **citation**: `src:<path>` in any
record means that path **at the stamped commit**, per the family's
citation policy for documentation — checked once, when the corpus is
produced, and never re-verified against the moving tree. (The audit
corpus's citation ban is audit-local; documentation citations serve a
reader whose job they do.)

The router at `documentation/concepts.md` lists the published
concepts — slug and one line each — pointing the reader into the
concept bodies the synthesis box also saw.

## Synthesize

The estate's contribution to the box's export set — the user-visible
material, and nothing else:

- every story body under `design/stories/` and the story TOC;
- every concept body under `design/concepts/` and the concept TOC —
  the published concept layer;
- the prior release's published documentation corpus, exported from
  the prior release, when one exists.

**Decisions are developer material and never enter the box.** Neither
do audits, sprints, issues, sketches, history, or any code or test.

## Assess

The record shapes. One assessment per measured way, at
`documentation/assessments/<subject>--<way>.md`:

```
---
assessment: <subject>--<way>
subject: story:<slug> | assumption:<slug>
way: <way-slug>
release: <commit>
outcome: held | unverified
warrant: test:<id> | experiment:<slug> | none
---
```

The body records what was attempted, what was observed, and the
**unverified remainder** — stated in the record, never left silent. An
`outcome: held` requires an affirmative warrant (`test:` or
`experiment:`); `warrant: none` is legal only with
`outcome: unverified`. A story the product honors through several ways
carries several assessments; the demonstrated path is the product of
the record, the outcome a byproduct.

**The attestation rule.** Published silence about an assumption is
honest only because a record attests the measurement: every
synthesized assumption ends the run holding an assessment record
(held or unverified) or a trap record — never nothing.

**Story fitness is measured by the run itself.** A story whose ways
cannot be identified or whose promise cannot be measured as written —
qualitative clauses, no observable outcome — is a fitness finding:
file it as an intake issue and record the story's ways as unverified.

## Distill

Trap records at `documentation/traps/<slug>.md`:

```
---
trap: <slug>
release: <commit>
repro: reproduced | not-reproduced | not-attempted
---
## Assumption
## Actual behavior
## Evidence
```

The evidence set is produced by reading and frozen at the release; a
reproduction is corroboration and `not-attempted` is an honest state.
A trap never rests on a failed run alone.

Archived experiments at `documentation/experiments/<slug>/`: the
runnable files plus a `record.md` (frontmatter `experiment:`,
`release:`; body: what it ran against, what was observed).

**Filing.** Three kinds of intake issue leave this phase, each per the
estate's issue-file conventions: a **defect** (a contradicted promise —
a story that does not work is never documented as product), a
**fitness finding** (from the Assess phase), and a **promotion
candidate** (an experiment worth maintaining — as an ordinary test, or
as an expected-fail test encoding a standing trap). Promotion is the
owner's act through the intake and a sprint, never this run's.

## Check

Run `.ok-planner/bin/document-check`. If the project has not
converged, fall back to the payload's `scripts/document-check` and
**announce the fallback verbatim in the report**, on its own line,
before the findings: `note: no vendored checker — using the payload's
copy; /ok pins one to this project`. An unpinned verdict is never
delivered silently.

The checker validates the produced corpus mechanically: the release
stamp on every record, every `held` claim carrying an affirmative
warrant, trap records carrying evidence sets, catalog counts agreeing
with their enumerated populations, unverified remainders present where
climbing stopped, and citations resolving at the stamped commit. Its
output is authoritative; do not re-derive its checks by reading.

## Present

```
## ok-planner

Corpus: <records written, by kind: catalog rows, assessments, traps,
experiments>
Attestation: <assumptions synthesized / accounted for — the two
numbers must agree>
Filed: <defects, fitness findings, promotion candidates, by path>
```

## Boundaries

- Never edits `design/`. A story that fails its measurement is a
  defect in the intake, never a story rewritten to match the product.
- Never writes `surface.json`. Declaring the surface is the owner's
  act, transcribed by administration; this run reports candidates.
- Never promotes an experiment. The intake carries the candidate; a
  sprint does the work.
- Never publishes. The corpus is committed to the estate; shipping it
  is a separate publisher's job.
- Never reads sprints, sketches, or history — records are out of
  context; the prior published corpus enters only as the box's input.
