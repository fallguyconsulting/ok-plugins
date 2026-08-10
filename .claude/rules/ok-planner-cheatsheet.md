# ok-planner Cheatsheet

Materialized by ok-planner v15.2.0. Suite-owned: overwritten
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
  snapshot, never a source of truth, allowed to go stale; `history/` is the
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
when the tree has moved past its stamp), consumes its determinations
and surface ruling, measures the synthesized user assumptions on the
same experiment harness, and leaves a commit-stamped documentation
corpus in `documentation/`, split along the vantage line. The full
execution shape is in `.ok-planner/CLAUDE.md`.
On completion, artifacts move to their same-named folder under `history/`
(a sprint together with its `-completion` report — the durable record
the executor keeps and the certify ceremony finishes and walks).

## The public surface

Every user-facing element is ruled **public or private, totally**: the
**surface declaration** (`.ok-planner/surface/surface.json`) names the
surface kinds and a mechanical enumerator each; the **surface
guidance** (`.ok-planner/surface/guidance.md`) is the owner's prose
rules for classifying what the enumerators produce; the **surface
ruling** (`.ok-planner/audits/surface/ruling.json`, beside its cached
extraction) is the derived, stamped partition the audit run writes.
No default exists — an unclassified element is a loud failure, never
"private by omission". A kind no mechanical source can enumerate is
marked **agentically derived** (`"derivation": "agentic"`, `reads`
naming what the derivation reads); its enumerator reads the committed
member list at `.ok-planner/surface/members/<kind>` — re-derived and
diffed at each audit run's opening, drift walked with the owner — and
the marked set is a standing inventory the owner retires by adopting
practices that make those populations mechanical. The guidance
legally changes outside sprints,
but every change is ratified: carried by an approved sprint, or
confirmed with the owner at the next audit run, detected by comparing
anchors (`.ok-planner/bin/surface-reconcile` reports the state).
Planning participates predictively: work introducing surface the
guidance cannot classify is settled during `/plan-sprint`.

## Audits

Concepts, stories, and decisions are verified by the
**implementation-audit corpus** under
`.ok-planner/audits/{concepts,stories,decisions}/` — one file per
artifact, written only by the periodic `/audit` run, never by
the implementing session and never hand-edited. The run opens with the
**surface determination** — its one interactive moment; a settled
partition passes silently — then makes its other two determinations:
**story support from the user's side** (experiments driven through the
ruled public surface on the maintained harness at
`.ok-planner/experiments/` — never settled by reading or by citing a
test, and conclusions never carry: an archived experiment warrants
nothing until re-run at the stamp) and **decision and concept support
from the technical side** (adversarial reading). An audit answers **two
independent questions** — *does the artifact comply with its own
authoring rules?* and *is it supported by the codebase at this
commit?* — in one sentence to one paragraph, with a support
determination of `supported`, `unsupported`, or `unclear` beside a
`compliance:` of `compliant` or `noncompliant`. They come apart: a
malformed artifact may be accurately implemented. Where an artifact
claims a whole enumerable population, the determination adds the
coverage shape — `checked:`, `unaccounted:`, and the unaccounted
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

**The run is two determination stages and no loop.** Auditors work
every live artifact in parallel batches — stories by measurement,
decisions and concepts by reading; everything they could not call
`supported` goes to one second-opinion judge, which confirms it (filing
an issue), overturns it to `supported`, or calls it undecidable (filing
an issue for the owner to settle). Only the support axis escalates — a
compliance defect is mechanical, so it is recorded and reported rather
than judged. The judge is terminal, so nothing comes back for another
pass, and nothing is ever fixed by the run itself — a real gap becomes
an intake issue and a future sprint's work. Experiments the run had to
build, passing at the stamp, are filed as promotion candidates.
`.ok-planner/bin/audit-check` validates every estate's corpus in one
pass: audit coverage, shape on both axes, brevity, the coverage counts
agreeing with the determination, the rule that no `unsupported` or
`unclear` determination stands without an `issue:` slug, each
catalog TOC listing exactly its collection's live slugs, and — where a
surface ruling exists — its anchors, its totality against the cached
extraction, and its guidance hash.

## Documentation

Release documentation is a **measured assessment**, produced by
`/document` into `.ok-planner/documentation/`, split along the vantage
line. The **publishable layer** — a catalog over the ruling's public
side, assessments warranted by passing surface experiments, traps
(reasonable assumptions the product contradicts), and a concept
router — speaks only the shipped vocabulary (concepts, stories, public
surface elements) and cites catalog rows at the stamp, never source
paths or tests. The **verification layer** — trap evidence sets, the
surface ruling, the experiment harness — stays internal and cites the
tree freely. Every record is stamped with the release commit it
describes; nothing tracks staleness and no conclusion carries
forward — each release re-derives the whole corpus, with the prior
published corpus as a synthesis input, never a cache; the harness's
runnables do carry, as instruments. The corpus is a record: out of
context by default, never consulted to understand the current tree.
`.ok-planner/bin/document-check` validates a produced corpus
mechanically.

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
