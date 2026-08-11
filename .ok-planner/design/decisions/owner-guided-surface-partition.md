---
decision: owner-guided-surface-partition
---

# The public surface is a single owner-authored intent document plus a per-run agentic extraction

## Choice

The project's public surface is captured in one owner-authored prose
document at `.ok-planner/surface/surface.md` — the **surface intent**
per `concept:surface-intent`. The document names, in the terms the
owner uses, which classes of element are public by default and which
specific elements depart from those rules; it is committed to the
estate and edited only by the owner. Each audit run produces a **surface
extraction** at `.ok-planner/audits/surface/extraction.json` per
`concept:surface-extraction`: a subagent reads the intent, walks the
code and deployment configuration purpose-bound to classification, and
writes one entry per element found — kind, identifier, location, and
the intent rule that placed it public or internal. Kinds are
discovered by the walk, not pre-declared. The extraction is committed
with the audit corpus and stamped with the closing commit; the story
auditor and `/document` consume it as the operational surface for
that commit.

Ambiguity is asymmetric by design. An element the intent cannot
clearly settle is **defaulted internal for the run** and filed as an
intake issue asking the owner to amend the intent. The audit
proceeds; the owner responds on their own time; a future run reads
the amended intent. There is no mid-run walk with the owner, no
settlement condition on the run's completion, no run stalls waiting
on an owner ruling.

The audit orchestrator dispatches the extractor and consumes what it
returned. It runs no reconciler, reads no committed member list,
compares no guidance hash, and interprets no tool exit. The
extraction file is the record; the intent file is the source of
truth. Both are stamped with the commit they describe, so freshness
is a git question anyone can answer without a validator.

## Rationale

Three prior shapes broke on the same seam: they routed intent through
mechanical apparatus, and the apparatus drifted from what the owner
actually thought was public. A per-kind declaration keyed on
`reads`-style enumerators cannot express the general rules that
capture most elements ("every route under the public router is
public") without listing every route by hand; a prose guidance
document sitting beside a separate declaration and a separate ruling
splits one idea across three files that must be kept consistent;
committed per-kind member lists drift the moment a code change adds
an element and nobody re-runs the enumerator. A single owner-authored
document holds intent where the owner already writes it — in prose,
with general rules and named exceptions — and lets the extraction be
what it should have been all along: a fresh agentic walk of the
codebase at the run's commit, joining what the walk finds against
what the intent says.

Defaulting ambiguities to internal, and filing intake issues rather
than paging the owner mid-run, follows from the audit being a
**cadence** activity rather than a planning conversation. An audit
that stops to demand an owner's attention every time it finds
something the intent does not settle spends its lowest-cost work
(walking and classifying) at the price of its highest-cost work (the
owner's synchronous attention), and it produces the failure mode
observed in practice: a run that paused waiting on the owner and
stalled for hours. Presuming internal is safe by construction — an
element the owner has not ruled public cannot be depended on as
public by the story audits — and filing an issue routes the missing
ruling into the machinery designed for owner judgment: the intake,
which `/plan-sprint` reads. The audit finishes; the intent evolves
between audits.

Committing the extraction as part of the audit corpus, stamped with
the closing commit, keeps every audit self-describing: a reader at a
given commit can inspect exactly what was treated as public when the
audit was written, and how it was classified. Nothing tracks
staleness, nothing invalidates anything, and no per-run cache blurs
into a source of truth: the intent moves only when the owner edits
the intent file, and every extraction is a run's join of the intent
and the tree at a named point in time.

## Alternatives

- Declaration plus guidance plus ruling, three artifacts kept
  consistent by a `surface-reconcile` tool. The shape the earlier
  design carried and this decision retires. Splits one idea across
  three files, requires a validator to keep them in sync, and puts a
  tool with a pass/fail exit in the audit orchestrator's hand — the
  exact false-confirmation shape that broke a real run.
- Per-kind committed member lists at `surface/members/<kind>/`, one
  member per line, updated by the audit's opening walk. Retired with
  the rest of the mechanical apparatus. Drifts the moment a code
  change adds an element without a rerun, and encodes an
  enumeration-friendly view of the world that many real surface kinds
  do not fit.
- Mechanical enumerator commands per kind (a `reads: cmd` on each
  declared kind). Deterministic and cheap where it applies, but
  requires the owner to author an enumerator per kind, misses
  anything a project adds outside the enumerator's field of view, and
  is itself software that drifts unaudited.
- One interactive moment at the audit's opening, where the owner
  walks unclassified elements and unratified guidance with the run.
  The earlier design's compromise. Even one interactive moment turned
  a cadence run into a synchronous session, and the moment was
  routinely reached because most cadence audits find at least one
  novel element somewhere.
- A separate `surface-partition` skill run outside the audit,
  producing a stamped ruling the audit consumes. Trades one ceremony
  for two; the owner still has to sit for the walk; and it leaves the
  audit exposed to a stale ruling file that no ceremony re-derives.
- Retiring the surface artifact entirely and letting the story audits
  discover public elements by trial and error. Loses the record of
  what was treated as public at a given commit, which the story audits
  and `/document` both need, and asks each auditor subagent to make
  its own classification decisions in isolation.
