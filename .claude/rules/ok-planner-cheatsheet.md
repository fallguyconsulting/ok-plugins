# ok-planner Cheatsheet

Materialized by ok-planner v18.6.1. Suite-owned:
overwritten wholesale by the front door's administration (`/ok`);
project-specific rules belong in your own files under `.claude/rules/`.

The planner's estate lives in `.ok-planner/`; its embedded `CLAUDE.md`
carries the full per-directory rules. The short version every session
needs:

## The three content kinds

- **`design/` — source of truth, read freely.** Concepts, stories,
  decisions: the project's durable model, same weight as code. What it
  commits to changes only by applying an approved sprint's corpus
  deltas. How a commitment is expressed may be repaired in-cycle by the
  certification fix loop, when the rules determine the compliant text
  and no commitment changes; each repair is surfaced for after-the-fact
  veto. `/verify-issues` repairs nothing. Code cites the corpus with
  `@concept:` / `@story:` / `@decision:` annotations, and rollout is
  incremental: consult an artifact while working on a file and leave
  the annotation — kind plus slug, at the load-bearing site — before
  you are done.
- **`issues/` — the intake.** One markdown file per question awaiting
  the owner's judgment. Anyone may file one. `/verify-issues` makes
  each ruling-ready: it closes an issue the corpus already answers and
  rewrites the rest as a from-the-top narrative ending in a marked
  generated or recommended ruling the owner accepts by silence or
  overrides; it fixes nothing, naming a rules-determined fix in the
  ruling instead. Only a `/plan-sprint` session closes an issue —
  **promoted** into that sprint (file stamped with the sprint's name)
  or **retired** — and closed files move to `history/issues/`.
  Unmarked Ruling text is the owner's alone.
- **`sprints/`, `sketches/`, `documentation/`, `history/` — records,
  out of context by default.** Do not read them to understand the
  project, include them in general exploration, or reconcile them with
  current code. A sprint is in context while you execute it, not
  otherwise. `sketches/` is speculative future thinking (written by
  `/sketch`). `documentation/` is the release-stamped corpus
  `/document` produces — a snapshot, never a source of truth, allowed
  to go stale — and so are the documents it places in the tree (under
  `docs/`, the root `README.md`), each opening with a provenance
  stamp; a placed document behind the tree files nothing and marks
  nothing, and the next `/document` regenerates the set whole.
  `history/` is the archive: one same-named folder per artifact kind,
  preserved indefinitely. Touch records only when the user or an
  ok-planner skill directs it.

## Lifecycle

`/sketch` captures an idea in `sketches/`; it authorizes nothing.
`/plan-sprint` produces a sprint in `sprints/` — corpus deltas, work
items, a fixed completion contract — pulling every ruled issue in
without re-discussion, then resolving with the owner the unruled open
issues that bear on the work. Executing the sprint is an ordinary
working session or an orchestrator's job, same contract either way:
stage the work items yourself, apply the deltas to `design/`, build,
run the project's test suites, and finish with `/certify-work`. The
gate's review-fix loop fixes every finding it can; only
architect-confirmed intent forks and the remainders escalated at its
cycle cap land in `issues/`, made ruling-ready by `/verify-issues`.
Whether the corpus's claims still hold is `/audit`'s question, on the
owner's cadence, never at a close. At a release, `/document` ensures a
current audit (running `/audit` when the tree has moved past its
stamp), settles the document types (`.ok-planner/surface/documents/`)
in the documentation walk, constructs the commit-stamped documentation
corpus from the audit's records — measuring nothing — and generates
one self-contained document per declared type, placed at the type's
target in the tree. On completion, artifacts move to their same-named
folder under `history/` (a sprint with its `-completion` report). The
full execution shape is in `.ok-planner/CLAUDE.md`.

## The public surface

The **surface intent** at `.ok-planner/surface/surface.md` is one
prose document naming which classes of element are public by default
and which specific elements depart: general rules with named
exceptions. The audit's **interactive intent stage** produces and
maintains it — a short class-level conversation ("every CLI verb is
public"), an à la carte run's one owner walk — and the owner may edit
the file between audits. Once the intent lands, the run dispatches a
**surface extractor subagent** that reads it, walks the code and
deployment configuration, and writes the run's **surface extraction**
at `.ok-planner/audits/surface/extraction.json`, one entry per element
found, kind discovered by the walk. Elements the intent does not
settle are defaulted internal for the run and filed as intake issues.
No reconciler tool, no committed member lists, no stamped ruling.
Work that introduces surface the intent cannot classify is settled
during `/plan-sprint`.

## Audits

The implementation-audit corpus under
`.ok-planner/audits/{concepts,stories,decisions}/` holds one file per
live artifact, written only by the periodic `/audit` run, never by the
implementing session, never hand-edited. An audit answers two
independent questions in one sentence to one paragraph: `text:`
(`compliant` | `noncompliant`) — does the body follow its authoring
rules — and `implementation:` (`supported` | `unsupported`) — does the
codebase support the claim at this commit. They come apart: a
malformed artifact may be accurately implemented. Where an artifact
claims an enumerable population, the verdict adds the coverage shape:
`checked:`, `unaccounted:`, and the unaccounted members named.

The instrument differs by kind. Story support is measured from the
user's side: the maintained experiments at `.ok-planner/experiments/`,
re-run at this tree through the public surface the extraction
records — never settled by reading or by citing a test, and
conclusions never carry. Assumptions — user-vantage priors a boxed
agent synthesizes cold from user-visible material — are measured on
the same instrument, each record closing with a disposition (`held` |
`trap` | `unverified`); a contradicted assumption is documentation,
never a fix issue. Decision and concept support is an adversarial
reading against the code.

An audit is a statement about a named commit, not a standing verdict:
its `commit:` frontmatter names the tree it describes, so whether it
still holds is a git question. Nothing tracks staleness. No audit
carries citations, hashes, or line numbers; the next run navigates by
the annotation grep. Every universal comes back as a count and its
population ("checked all 23 skills under the families plus the front
door and `/release`").

The run is two stages and no loop: workers over every live artifact,
then one terminal judge over every escalation — `unsupported`
verdicts, assumption contradictions, corpus contradictions from the
extraction, the orchestrator's driving observations. A confirmed gap
becomes an intake issue; the run fixes nothing. The audit corpus and
the intake are independent: no `issue:` field in either direction.
Experiments the run built, passing at the stamp, are nominated
through the intake; adopting one is a sprint's work. The run ends by
writing its report to `.ok-planner/history/audits/<date>-<sha>-report.md`
— a record, never a channel — committing everything, and stamping the
commit; it presents only when invoked à la carte. The orchestrator
runs no validator over the corpus; a malformed audit is rewritten
whole by the next run.

## Documentation

`/document` produces release documentation into
`.ok-planner/documentation/` and measures nothing: it ensures a
current audit and constructs from the audit's records. The
**publishable layer** — a catalog over the extraction's public side,
assessments whose held claims cite the audit's passing experiments,
traps read from the assumption dispositions, a concept router —
speaks the shipped vocabulary and cites catalog rows at the stamp,
never source paths or tests. The **verification layer** — trap
evidence, the extraction, the audit's records, the experiments —
stays internal and cites the tree freely. The **documents** — one per
declared document type, settled in the documentation walk — are
self-contained, kept under `documentation/documents/`, and placed at
each type's target in the tree with a provenance stamp. Only declared
targets are written. Every record and document is stamped with the
release commit; each release re-derives the whole corpus. The run
runs no validator over its own corpus; the next release rewrites a
malformed one whole.

A concrete story does not speak to the qualitative. Correct, clear,
helpful, intuitive describe how well the product owes something, not
what it owes. Where a promise rests on a human discipline's judgment,
the audit records a **referral** — the promise, what exists in form,
and the owning discipline — and opines no further.

## Hard rules

- A sprint is a disparate set of work items: no theme, no order.
  Staging it is execution's job; never write a plan document from one.
- The sprint is the source of truth for its work. A promoted issue is
  settled; never read the intake to learn what a sprint meant.
- Open issues gate the work they bear on, not all work; the rest stay
  queued.
- Design docs are current-state only: no changelogs, no roadmaps, no
  TODOs.
- Suite upkeep is the front door's administration (`/ok`), never a
  ceremony's job and never run from a hook; it is always a user
  action.
