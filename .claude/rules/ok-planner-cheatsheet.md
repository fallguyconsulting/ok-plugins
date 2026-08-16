# ok-planner Cheatsheet

Materialized by ok-planner v18.4.1. Suite-owned: overwritten
wholesale by the front door's administration (`/ok`); project-specific rules
belong in your own files under `.claude/rules/`.

The planner's estate lives in `.ok-planner/` (its embedded `CLAUDE.md` carries
the full per-directory rules). The short version every session needs:

## The three content kinds

- **`design/` — source of truth, read freely.** Concepts, stories, decisions:
  the project's durable model, same weight as code. What it *commits to*
  changes only by applying an approved sprint's corpus deltas — never ad
  hoc; how a commitment is *expressed* may be repaired in-cycle by the
  certification fix loop when the rules determine the compliant text and
  no commitment changes, each repair surfaced for after-the-fact veto.
  `/verify-issues` repairs nothing. Code cites it via
  `@concept:` / `@story:` / `@decision:` annotations — and rollout is
  incremental: consult an artifact while working on a file and you leave
  the annotation (kind plus slug, at the load-bearing site) before you
  are done, so the next agent greps instead of re-deriving.
- **`issues/` — the issue intake.** One markdown file per question awaiting
  the owner's judgment. Anyone may file one; `/verify-issues` makes each
  ruling-ready — closing it when the corpus already answers it, and
  rewriting the rest as a from-the-top
  narrative ending in a marked generated/recommended ruling the owner
  accepts by silence or overrides; it fixes nothing itself, naming a
  rules-determined fix in the ruling instead. Only a `/plan-sprint` session closes
  one, by **promoting** it into that sprint (file stamped with the
  sprint's name) or **retiring** it. Closed files move to
  `history/issues/`. Unmarked ruling text is the owner's alone.
- **`sprints/`, `sketches/`, `documentation/`, `history/` — records,
  out of context by
  default.** Do not read them to understand the project, do not include them
  in general exploration, do not reconcile them with current code. A sprint
  is in context while you are executing it, not otherwise; `sketches/` is
  speculative future thinking (written by `/sketch`); `documentation/`
  is the release-stamped documentation corpus `/document` produces — a
  snapshot, never a source of truth, allowed to go stale — and so are
  the **documents it places in the tree** (under `docs/`, the root
  `README.md`), each opening with a provenance stamp naming the
  release it describes: out of context by default, read only when the
  owner directs you there, never reconciled with the code; a placed
  document behind the tree files nothing and marks nothing — the next
  `/document` regenerates the set whole; `history/` is the
  archive — same-named folder per artifact kind, preserved indefinitely.
  Touch records only when the user or an ok-planner skill directs it.

## Lifecycle

`/sketch` captures an idea in `sketches/` (no authorization to build).
`/plan-sprint` produces a sprint in `sprints/` — corpus deltas + work
items + a fixed completion contract — pulling in every ruled issue without
re-discussion, then resolving with the owner the unruled open issues that
bear on the work and promoting them into it. Executing the sprint is an
ordinary working session (or an orchestrator's job — same contract either
way): stage the work items yourself, apply the deltas to `design/`, build,
run the project's own test suites, and finish with `/certify-work`
(change-scoped; its review-fix loop fixes every finding it can — only
architect-confirmed intent forks and the remainders escalated at its
cycle cap land back in `issues/`, made ruling-ready by
`/verify-issues`). Whether the corpus's claims still hold is a separate
question, asked by `/audit` on the owner's cadence and never at
a close. At a release, `/document` ensures a current audit (running it
when the tree has moved past its stamp), settles the owner's
**document types** (`.ok-planner/surface/documents/`) in the
documentation walk — inside the composed audit right after its
extractor returns, or against a reused audit's extraction —
constructs the commit-stamped documentation corpus in
`documentation/` from the audit's records — measuring nothing itself
— split along the vantage line, then generates one self-contained
document per declared type and places it at the type's target in the
tree. The full execution shape is in `.ok-planner/CLAUDE.md`.
On completion, artifacts move to their same-named folder under `history/`
(a sprint together with its `-completion` report — the durable record
the executor keeps and the certify ceremony finishes and walks).

## The public surface

The public surface is one prose document — the **surface intent** at
`.ok-planner/surface/surface.md` — naming which classes of element
are public by default and which specific elements depart from those
rules (general rules with named exceptions). It is produced and
maintained in the audit's **interactive intent stage** at the top of
each run: an à la carte run's one owner walk, a short class-level
conversation ("every CLI verb is public", "the foobar module is
user-facing", specific exceptions where they exist) that lands the
document. The
owner may also edit the file directly between audits. Once landed,
the run's autonomous portion dispatches a **surface extractor
subagent** that reads the intent, walks the code and deployment
configuration purpose-bound to classification, and writes the run's
**surface extraction** at `.ok-planner/audits/surface/extraction.json`
— one entry per element found, kind discovered by the walk. Elements
the intent still does not clearly settle are **defaulted internal
for the run** and filed as intake issues asking the owner to amend
the intent — the safety net for residual drift the interactive
conversation could not enumerate, never the primary path. No
reconciler tool, no committed member lists, no stamped ruling.
Planning participates predictively: work introducing surface the
intent cannot classify is settled during `/plan-sprint`.

## Audits

Concepts, stories, and decisions are verified by the
**implementation-audit corpus** under
`.ok-planner/audits/{concepts,stories,decisions}/` — one file per
artifact, written only by the periodic `/audit` run, never by
the implementing session and never hand-edited. The run opens with
its **interactive intent stage** — an à la carte run's one owner
walk, a short class-level conversation that produces or updates the
surface intent at `.ok-planner/surface/surface.md` (a run `/document`
invoked adds the documentation walk right after the extractor
returns, settling the document types, and no other). It then autonomously
dispatches a **surface extractor subagent** that reads the
just-landed intent and writes this run's surface extraction
(elements the intent still does not settle are defaulted internal
and filed as intake issues; the autonomous portion does not stall
on the owner) — a run invoked à la carte hands the owner the
`/goal` line, once the intent is landed, that drives the rest
hands-free — then makes its other determinations: **story support
from the user's side** (the maintained experiments at
`.ok-planner/experiments/`, re-run at this tree and driven through
the public surface the extraction records — never settled by reading
or by citing a test, and conclusions never carry: an archived
experiment warrants nothing until re-run at the stamp);
**assumptions**, synthesized cold by a boxed agent from user-visible
material once the story verdicts land and measured on the same
instrument (story-shaped records under `.ok-planner/audits/assumptions/`,
each closing with a disposition — `held`, `trap`, or `unverified` — a
contradicted assumption is documentation, never a fix issue); and
**decision and concept support from the technical side** (adversarial
reading). An audit answers **two
independent questions** — *does the artifact's text comply with its
own authoring rules?* and *does the codebase support what it claims,
at this commit?* — in one sentence to one paragraph, with an
`implementation:` verdict of `supported` or `unsupported` beside a
`text:` reading of `compliant` or `noncompliant`. They come apart: a
malformed artifact may be accurately implemented. Where an artifact
claims a whole enumerable population, the implementation verdict adds
the coverage shape — `checked:`, `unaccounted:`, and the unaccounted
members named.

**An audit is a statement about a named commit, not a standing
verdict.** Its frontmatter carries the `commit:` it describes, so
asking whether it still holds is a git question — how far has `HEAD`
moved — and not a computation. Nothing tracks staleness, nothing
invalidates anything, and there are no citations, hashes, or line
numbers in an audit. The reading list for the next run is the
`@concept:` / `@story:` / `@decision:` annotation grep, which is the
one job annotations have.

**Every universal comes back as a count and its population.** A
quantifier is only worth asserting if someone enumerated the members,
so an audit says "checked all 23 skills under the families plus the
front door and `/release`" — refutable by a reader in seconds — rather
than offering a vague assurance.

**The run is two stages and no loop.** Workers are fed every live
artifact — stories and assumptions by measurement, decisions and
concepts by reading; every escalation — the `unsupported` verdicts,
assumption contradictions, corpus contradictions from the extraction,
the orchestrator's own driving observations — goes to one terminal
judge. A confirmed story gap files an intake issue by the ordinary
intake conventions; a confirmed assumption contradiction files
nothing and stands as a trap disposition. The audit corpus and the
issue intake are independent by construction: an audit carries no
`issue:` field in either direction, and any back-reference lives in
issue prose. Nothing is ever fixed by the run itself — a real gap
becomes an intake issue and a future sprint's work. Experiments the
run had to build, passing at the stamp, are **nominated** for the
project's suites by filing an intake issue; adopting one is a
sprint's work on the owner's ruling. The run ends by writing its
report to `.ok-planner/history/audits/<date>-<sha>-report.md` — a
record, never a channel — committing everything and stamping the
commit; it presents from the report only when invoked à la carte, and
silently otherwise. **The orchestrator runs no validator over the
corpus:** dispatch, collect, write the report, stamp — nothing
sits in the orchestrator's hand with a pass/fail exit, so nothing
about the run can "fail" against a tool. Where an audit is malformed,
the next run rewrites it whole; drift self-corrects.

## Documentation

Release documentation is produced by `/document` into
`.ok-planner/documentation/`, in two tiers, and `/document` measures
nothing: it ensures a current audit and constructs from the audit's
records. The **records** are a measured assessment split along the
vantage line. Their **publishable layer** — a catalog over the
extraction's public side, assessments whose held claims cite the
audit's passing surface experiments, traps (reasonable assumptions
the product contradicts, read from the audit's trap dispositions),
and a concept router — speaks only the shipped vocabulary (concepts,
stories, public surface elements) and cites catalog rows at the
stamp, never source paths or tests. The **verification layer** — trap
evidence sets, the surface extraction, the audit's records, the
experiments — stays internal and cites the tree freely. The
**documents** — one per **document type** the owner declares at
`.ok-planner/surface/documents/<slug>.md` (what the document is for,
the classes of public surface it covers, its target path), settled in
the **documentation walk** — are written by one writer per type
(`Generate`), oriented by the records, verified against the tree at
the stamp, self-contained (no record citations, no warrant state),
kept under `documentation/documents/` and placed at the type's target
in the tree with a provenance stamp, beside `docs/CLAUDE.md` when any
type targets `docs/`. Only declared targets are written. Every record
and document is stamped with the release commit it describes; nothing
tracks staleness and no conclusion carries forward — each release
re-derives the whole corpus, with the prior published corpus feeding
the audit's synthesis, never a cache; the experiments do carry, as
instruments. The corpus is a record, placed documents included: out
of context by default, never consulted to understand the current
tree. **The
documentation run runs no validator over its own corpus:** nothing
sits in the orchestrator's hand with a pass/fail exit, and a
malformed corpus is rewritten whole by the next release's run — drift
self-corrects, as with the audit.

**A concrete story does not speak to the qualitative.** Correct, clear,
helpful, intuitive — these describe how well the product owes
something, not what it owes, and a story reaching for them has usually
not finished naming the need. Where a promise genuinely rests on a
human discipline's judgment, the audit records it as a **referral** —
the promise, what exists in form, and the discipline that owns it —
and opines no further.

## Hard rules

- A sprint is a disparate set of work items: no theme, no order. Staging
  it is execution's job — never write a plan document from one.
- The sprint is the source of truth for its work. A promoted issue is settled;
  never read the queue to find out what a sprint "really meant".
- Open issues gate the work they bear on, not all work; the rest stay queued.
- Design docs are current-state only: no changelogs, no roadmaps, no TODOs.
- Suite upkeep is the front door's administration (`/ok`), never a
  ceremony's job and never run from a hook; it is always a user action.
