# .ok-planner — the planner's directory

Materialized by ok-planner v11.0.0. Suite-owned
boilerplate: this file is overwritten wholesale by the front door's
administration (`/ok`); do not hand-edit it (project guidance belongs
in the project's root CLAUDE.md).

This directory holds three kinds of content with different lifecycles
and different rules for how agents should treat them.

## Durable design docs (`design/`) — source of truth, read freely

The project's canonical durable model, three catalogs, each
self-contained:

- **`concepts/`** — load-bearing nouns with definitions, purposes,
  boundaries, and invariants.
- **`stories/`** — durable user expectations, each an agile-style
  non-prescription of user need (`As <role>, I want <capability>,
  so that <benefit>` — the "so that" clause is mandatory), with
  acceptance, falsifier, and a proof: a deterministic integration
  test (or demo) annotated `@story:<slug>`.
- **`decisions/`** — durable technical decisions (choice, rationale,
  alternatives). Decisions carry no proofs: whether an implementation
  honors a Choice is determined by its implementation audit under
  `audits/decisions/`, written by certification.

**A note on the name `design/`.** The directory name is a label, not
a load-bearing claim about content. "Design" here is the project's
durable identity/model — the high-level, general framing of what the
project is and what it owes its users. It is NOT a place for
*specific* designs: interface grammars, route shapes, schema details,
implementation diagrams. Those live in code, in `sprints/`, and in
other project documentation.

Code references the design (via `@concept:`, `@story:`, `@decision:`
annotations at points of enforcement), not the other way around. The
design docs are **a source of truth with the same weight as code**:
they describe the project as it stands. What the project *commits
to* — its concepts' invariants, its stories' promises, its
decisions' choices — changes only by applying an approved sprint's
corpus deltas, never ad hoc. How a commitment is *expressed* may
also be repaired in-cycle by the certification fix loop and
`/verify-issues`, when the rules fully determine the compliant text
and no commitment changes (a stale TOC line, a stale sentence the
code and a counterpart artifact both contradict); every such repair
is surfaced to the owner for after-the-fact veto. Read the docs
freely; they are NOT an out-of-context record.

**Leave the annotation.** Annotation rollout is incremental and it is
every session's job, not a bulk pass anyone runs: any time you consult
a concept, story, or decision to understand or modify a file, leave
`@concept:` / `@story:` / `@decision:` plus the slug in a comment at
the most-specific load-bearing site in that file — the function,
branch, or block where the artifact's commitment is actually
enforced — so the next agent greps instead of re-deriving. Kind plus
slug only: never a file path, a line number, or a quotation of the
artifact. If the site already carries the annotation, leave it alone;
if the slug it names no longer exists, repoint or remove it.

## The issue intake (`issues/`) — questions awaiting judgment

One markdown file per design question requiring the project owner's
judgment, named `<YYYY-MM-DD-HHMMSS>-<slug>.md` so listings sort
chronologically. Filed by certification's architect (the gated
path — a finding from the repeating close cycle must survive the
fixer's veto test and the architect's adversarial check), by
`/discover-design`'s one-time bootstrap run, by `/plan-sprint`
transcribing a question you postponed, or by humans directly;
`/verify-issues` then makes each file **ruling-ready**: it closes
any issue the design corpus already answers (with the citation),
repairs the gaps the rules fully determine — code- or corpus-side,
so long as no commitment changes — and rewrites the rest as a
single from-the-top narrative ending in a marked generated or
recommended ruling — left untouched, those ride the next
`/plan-sprint` as rulings, named as batches at sign-off; edit or
empty one to override.

**Unmarked Ruling text is the owner's alone.** Write your decision
there in your own words, whenever you like; the next `/plan-sprint`
pulls every ruled issue into the sprint it plans without
re-discussing it. Agents write only the marked generated/recommended
forms — or transcribe a decision you give live.

**Intake, not a work tracker.** An issue is a question waiting for a
ruling. It is never worked or tracked to completion here — it closes
exactly two ways, both owner acts recorded through `/plan-sprint`:

- **Promoted** — the resolution is carried into a sprint as a corpus
  delta and/or work item, and the file is stamped with that sprint's
  filename. The sprint is then **the** source of truth for the work.
  The issue is settled and out of consideration: nothing re-opens it,
  nothing checks back on it, and no agent reads the issue file to
  learn what a promoted issue meant — whatever the work needs is in
  the sprint. The file moves to `history/issues/` when the sprint's
  implementation closes.
- **Retired** — the owner drops the question. Nothing is carried
  anywhere; the file moves to `history/issues/` immediately.

If a promoted decision later turns out wrong, that is a *new* issue
with a new file, not a revival of the old one.

Open issues gate the work they bear on, not all work. A `/plan-sprint`
planning new work pulls the ruled issues in first, drafts, then
resolves — with the owner — every unruled open issue that bears on
the draft, because building over such an issue would decide it
silently. Issues the sprint's work neither touches nor presumes an
answer to stay open, untouched, for a later sprint. A sprint whose
stated purpose is working the intake takes it (or a named batch of
it) as its agenda instead.

A legacy `issues.jsonl` from an older layout is converted by
`/verify-issues` (open rows become files; the log archives to
`history/issues.jsonl`). Never edit its rows.

## Project records (`sprints/`, `sketches/`, `history/`) — out of context by default

The record discipline, stated once: records — sprints, sketches, and
the archive — are committed and versioned parts of the project but
out of agent context by default, with exactly one live exception (the
sprint currently being executed), and every completed or retired
record moves to its same-named folder in the archive.

`sprints/` holds sprints from `/plan-sprint`; a sprint is in context
only while it is the work being executed. `sketches/` holds design
sketches from `/sketch` — speculative or in-progress future
thinking; reading one without a directing goal is context pollution.
`history/` holds a same-named archive folder per artifact kind
(`sprints/`, `sketches/`, `issues/`, and on projects migrated from
older layouts also `specs/`, `plans/`, `coverage/`, `tensions/`):
completed or retired artifacts move there and are preserved
indefinitely.

- **Do not consult these files to understand the project.** They
  reflect a moment in time. The codebase and `design/` are the
  source of truth.
- **Do not include them in general repository exploration** or "how
  does this project work" research.
- **Do not propose updating, refreshing, or reconciling them** with
  the current state of the code. Drift between an old sprint and
  the current code is expected and fine.
- **Do not edit, rename, move, or delete files here on your own
  initiative**, even if they look stale.

Read or touch them only when the user explicitly asks, or when an
ok-planner skill directs it (e.g. `/plan-sprint` writing a new sprint to
`sprints/`, or an executing session archiving a completed one to
`history/sprints/`). Do exactly what was asked, then stop.

## Lifecycle summary

`/sketch` captures an unplanned idea in `sketches/` — single-pass,
speculative, no authorization to build; when the idea is taken up
for real it flows through `/plan-sprint`, and the sketch moves to
`history/sketches/`.

`/plan-sprint` produces a sprint in `sprints/`: final-form corpus
deltas + work items + a fixed completion contract, with the open
issues that bear on that work resolved by the owner in-session and
promoted into the sprint. The approved sprint is where planning
stops — and from then on it, not the queue, is the source of truth
for that work. Executing it is the next section.

## Executing a sprint

**The sprint document is the brief — its own "How to execute this
sprint" section is the execution shape.** Every sprint `/plan-sprint`
produces carries that fixed section: read whole, stage in your own
working state (a sprint is never rewritten into a plan document),
apply deltas verbatim with the work, prove as you build, work
unsupervised to the contract. Follow it; nothing here overrides it.
"Implement sprint X" is an ordinary working session, not a special
mode — inline, a fan-out of subagents, or an external orchestrator
all owe the same completion contract and nothing else, so a sprint
can equally be handed to the native `goal` mechanism
(`/goal <path-to-sprint>`).

**`/certify-work` closes.** Named as the terminal step in the
sprint's own boilerplate, it discharges the completion contract at
the change's scope: `/prove` over the touched stories and decisions,
change-scoped corpus checks, code review over the diff — all feeding
a no-discretion review-fix loop (fixer, then an architect on
kickbacks; only architect-confirmed intent forks reach the issue
intake, made ruling-ready by `/verify-issues`) — then the
presentation, which ends by offering to archive the sprint and
commit the work: owner acts, taken only on the owner's word, with
the sprint left at its `sprints/` path until then so a goal keyed to
that path can verify completion. The close-out finishes by stamping
the archived sprint with the closing commit (`closed: <sha>`
frontmatter, one follow-on commit) — the baseline the next
`/plan-sprint` reads to detect and reconcile work done out of band
since this close. (Whole-corpus certification is
`/certify-all`, run on the owner's cadence — before a release, after
several sprints, when drift is suspected — not per close.)
