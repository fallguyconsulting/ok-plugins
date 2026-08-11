---
decision: owner-guided-surface-partition
---

# The public surface is a prose intent document maintained in the audit's interactive intent stage, plus a per-run autonomous extraction

## Choice

The project's public surface is captured in one prose document at
`.ok-planner/surface/surface.md` — the **surface intent** per
`concept:surface-intent`. The document names, in the terms the owner
uses, which classes of element are public by default and which
specific elements depart from those rules; it is committed to the
estate. It is **produced and maintained in the audit's interactive
intent stage** at the top of each run: the agent and the owner walk
the current document (if any) at the class level first ("every CLI
verb is public", "the foobar module is user-facing"), name specific
exceptions where they exist, get more specific only where a class
does not have a clean rule, and land what the owner approves as the
run's intent. The owner may also edit the file directly between
audits; the audit reads whatever is on disk at the top.

Once the intent is landed, the run's autonomous portion begins. A
**surface extractor subagent** reads the intent, walks the code and
deployment configuration purpose-bound to classification, and writes
one entry per element found to
`.ok-planner/audits/surface/extraction.json` — kind discovered by
the walk (never pre-declared), each entry naming the intent rule
that placed the element public or internal. The extraction is
committed with the audit corpus and stamped with the closing commit;
the story auditor and `/document` consume it as the operational
surface for that commit.

**Residual ambiguity is asymmetric by design.** An element the
extractor still cannot clearly settle against the just-landed intent
is defaulted internal for the run and filed as an intake issue
asking the owner to amend the intent. The audit proceeds; the owner
responds on their own time; a future run's interactive stage picks
up the amendment. The safety net catches drift the interactive
conversation could not enumerate — a class whose exceptions are
easier to see when the extractor names them, an element added since
the last intent walk — never substitutes for the interactive stage
that owns the primary authoring path.

The audit orchestrator dispatches the extractor after the intent is
landed and consumes what it returned. It runs no reconciler, reads
no committed member list, compares no guidance hash, and interprets
no tool exit. The extraction file is the record; the intent file is
the source of truth. Both are stamped with the commit they describe,
so freshness is a git question anyone can answer without a
validator.

## Rationale

Three prior shapes broke on the same seam: they routed intent
through mechanical apparatus, and the apparatus drifted from what
the owner actually thought was public. A per-kind declaration keyed
on `reads`-style enumerators cannot express the general rules that
capture most elements ("every route under the public router is
public") without listing every route by hand; a prose guidance
document sitting beside a separate declaration and a separate ruling
splits one idea across three files that must be kept consistent;
committed per-kind member lists drift the moment a code change adds
an element and nobody re-runs the enumerator. A single prose
document holds intent where the owner already writes it — in prose,
with general rules and named exceptions — and lets the extraction be
what it should have been all along: a fresh agentic walk of the
codebase at the run's commit, joining what the walk finds against
what the intent says.

A fourth shape broke on the opposite seam: pretending the intent
could be authored entirely outside the audit, on the owner's own
clock, with the audit merely reading a document that had somehow
appeared. Fresh projects then had no intent at all, and existing
projects had intents that lagged the code by every commit since the
last time the owner spontaneously edited them. The run walked, found
nothing classified, defaulted everything to internal, and produced
a story track with no public surface to drive through — which
recorded stories `unsupported` on measurement grounds and buried the
real question (what is user-facing?) under a pile of intake issues
the owner would have to answer one at a time, cold, later. The
interactive intent stage exists because the audit is the moment
this project is already thinking about its surface — the owner is
present, the code is on their mind, and the conversation is short
when it starts at classes and gets specific only on real
exceptions. Making it interactive is what earns the audit its
`/audit` invocation instead of a cron entry.

Defaulting *residual* ambiguities to internal, and filing intake
issues rather than paging the owner further, follows from the same
economics one layer down. The interactive stage has already spent
the owner's synchronous attention on the intent; the extractor's
job is to walk the code and find elements the just-landed intent
still does not settle. Stopping the run for each such element would
undo the very economy the interactive stage bought — a short
class-level conversation up front, then autonomy. Presuming internal
is safe by construction (an element the intent has not placed
public cannot be depended on as public by the story audits), and
filing an issue routes the missing ruling into the machinery
designed for owner judgment: the intake, which `/plan-sprint` reads.

Committing the extraction as part of the audit corpus, stamped with
the closing commit, keeps every audit self-describing: a reader at
a given commit can inspect exactly what was treated as public when
the audit was written, and how it was classified. Nothing tracks
staleness, nothing invalidates anything, and no per-run cache blurs
into a source of truth: the intent moves at the top of each run
(through the interactive stage) or between runs (through direct
owner edits), and every extraction is a run's join of the intent
and the tree at a named point in time.

## Alternatives

- Declaration plus guidance plus ruling, three artifacts kept
  consistent by a `surface-reconcile` tool. The shape the earlier
  design carried and this decision retires. Splits one idea across
  three files, requires a validator to keep them in sync, and puts
  a tool with a pass/fail exit in the audit orchestrator's hand —
  the exact false-confirmation shape that broke a real run.
- Per-kind committed member lists at `surface/members/<kind>/`, one
  member per line, updated by the audit's opening walk. Retired
  with the rest of the mechanical apparatus. Drifts the moment a
  code change adds an element without a rerun, and encodes an
  enumeration-friendly view of the world that many real surface
  kinds do not fit.
- Mechanical enumerator commands per kind (a `reads: cmd` on each
  declared kind). Deterministic and cheap where it applies, but
  requires the owner to author an enumerator per kind, misses
  anything a project adds outside the enumerator's field of view,
  and is itself software that drifts unaudited.
- An owner-authored intent document read passively by a fully
  autonomous audit, with elements the intent does not settle
  defaulted internal and filed as intake issues, and no
  interactive stage. The shape retired here. Left fresh projects
  with no intent and existing projects with lagging intents,
  because "the owner edits it on their own time" does not describe
  the actual clock any project runs on. Buried the surface
  conversation under piles of intake issues and produced story
  tracks with no public surface to drive through.
- A separate `surface-partition` skill run outside the audit,
  producing a stamped ruling the audit consumes. Trades one
  ceremony for two; the owner still has to sit for the walk; and
  it leaves the audit exposed to a stale ruling file that no
  ceremony re-derives. The interactive intent stage inside the
  audit collapses this back into one ceremony.
- Retiring the surface artifact entirely and letting the story
  audits discover public elements by trial and error. Loses the
  record of what was treated as public at a given commit, which
  the story audits and `/document` both need, and asks each
  auditor subagent to make its own classification decisions in
  isolation.
