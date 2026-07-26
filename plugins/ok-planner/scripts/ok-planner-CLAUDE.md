# .ok-planner — the planner's directory

Materialized by ok-planner v{{OK_PLANNER_VERSION}}. Skill-owned
boilerplate: this file is overwritten wholesale by `/true-up`; do not
hand-edit it (project guidance belongs in the project's root CLAUDE.md).

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
  acceptance, falsifier, and a proof.
- **`decisions/`** — durable technical decisions (choice, rationale,
  alternatives) — and each carries a proof: the mechanical check
  that fails if the choice is silently violated.

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

## The issue intake (`issues/`) — questions awaiting judgment

One markdown file per design question requiring the project owner's
judgment, named `<YYYY-MM-DD-HHMMSS>-<slug>.md` so listings sort
chronologically. Filed by certification's architect (the only
agent path in — a finding must survive the fixer's veto test and
the architect's adversarial check), `/discover-design`,
`/plan-sprint`, or humans; `/verify-issues` then makes each file
**ruling-ready**: it closes any issue the design corpus already
answers (with the citation), repairs the gaps the rules fully
determine — code- or corpus-side, so long as no commitment
changes — and rewrites the rest as a single from-the-top narrative
ending in a marked generated or recommended ruling — left untouched,
those ride the next `/plan-sprint` as rulings, named as batches at
sign-off; edit or empty one to override.

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

Committed, versioned parts of the project — but not the source of
truth, and not to be pulled into context unprompted. `sprints/`
holds sprints from `/plan-sprint`; a sprint is in context only
while it is the work being executed. `sketches/` holds design
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

"Implement sprint X" is an ordinary working session, not a special
mode. Nothing about a sprint requires an orchestrator or a
worker fleet: whoever picks it up — this session inline, a fan-out
of subagents, an external orchestrator — owes the same completion
contract and nothing else. Use whatever machinery the work actually
warrants; a three-item sprint is simply done, inline, by the agent
that was asked.

**The sprint is the whole brief.** It is self-sufficient by
construction: final-form deltas, work items, completion contract. Do
not go looking for context behind it — not in the issue intake (a
promoted issue's substance is in the sprint, and the file is only a
receipt), not in older records under `history/`. If something the
work needs genuinely is not in the sprint, that is a gap to raise
with the owner, not to fill by inference.

**Its work items are a flat, possibly disparate list** with no theme
and no imposed order. Sequencing them is *your* job, at execution
time:

1. **Read the sprint whole first** — deltas, work items, completion
   contract — before touching anything.
2. **Stage it.** Group items that share a theme, a file surface, or
   a dependency; order the groups so nothing is built on something
   not yet there. This is real planning and it happens here, not in
   the sprint — keep it in your working state (a task list is
   ideal). Do not write a plan document; ok-planner has no plan
   artifact, and a sprint is never rewritten into one.
3. **Apply each corpus delta as part of the work that realizes it.**
   A delta is a final-form artifact body: copy it into `design/`
   verbatim, or delete the file for a retirement. Deltas no work
   item implements — a clarification, a retirement — are applied on
   their own.
4. **Build stage by stage.** Every new or amended story and decision
   needs its proof to exist, carry the `@story:` / `@decision:`
   annotation, and actually be able to fail. Write the proof with
   the work, not at the end.
5. **Close on the completion contract, in its order.** The corpus
   matches every delta verbatim → `/prove` clean over all new and
   touched stories and decisions → the review-fix loop last: every
   producer's findings (alignment, prove, the change-scoped corpus
   checks, code review) driven to fixed-or-promoted — a fixer fixes
   everything a reasonable owner would wave through (intent-
   preserving corpus repairs included, each surfaced for veto), an
   architect adversarially checks its kickbacks and alone promotes
   genuine intent forks to `.ok-planner/issues/`, and
   `/verify-issues` makes those ruling-ready; they are the next
   sprint's business, not this session's. `/certify-work` runs
   exactly this contract as its core — and is the recommended way
   to close. (Whole-corpus `/prove` + `/audit` is `/certify-all`,
   run on the owner's cadence — before a release, after several
   sprints, when drift is suspected — not per close.)
6. **Offer the close-out** once the contract holds: archiving the
   sprint to `history/sprints/` together with the issue files it
   resolved (which move to `history/issues/`), and committing the
   work. Both are owner acts — `/certify-work` offers them at the end of
   its presentation and performs them only on the owner's word,
   leaving the sprint at its `sprints/` path until then so a goal
   keyed to that path can verify completion.

Scale is a judgment call: independent, large stages are worth
parallel subagents or a worktree; coupled or small ones are not. The
contract in step 5 is what does not scale away.

**The shape above is baked into every sprint.** `/plan-sprint`
writes a fixed "How to execute this sprint" section into each sprint
document — the same steps in short form — so the sprint is
self-driving from the moment it is signed off. That means the sprint
can be picked up inline by an ordinary working session, handed
straight to the native `goal` mechanism (`/goal <path-to-sprint>`)
so its Stop hook drives the build to completion, or dispatched to an
orchestrator that does its own planning. Every executor works from
the same brief.

**`/certify-work` closes.** Named as the terminal step in the
sprint's execution boilerplate, `/certify-work` discharges the
completion contract (steps 5–6 above) at the change's own scope,
adds the diff-scoped code review and the compliance producer to the
review-fix loop that drives every finding to fixed-or-promoted,
presents the
outcomes and any divergences to the owner, and closes by offering to
archive the sprint and commit the work — owner acts, taken only on
the owner's word. It is the same call whether the sprint was run
inline, under a goal, or under an orchestrator — the contract does
not change. `/certify-all` is the same gate at whole-corpus scope,
for the owner's cadence rather than the everyday close.
