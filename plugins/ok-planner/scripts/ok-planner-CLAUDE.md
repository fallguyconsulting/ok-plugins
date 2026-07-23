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
implementation diagrams. Those live in code, in `backlogs/`, and in
other project documentation.

Code references the design (via `@concept:`, `@story:`, `@decision:`
annotations at points of enforcement), not the other way around. The
design docs are **a source of truth with the same weight as code**:
they describe the project as it stands. Like code, they change only
by applying an approved sprint backlog's corpus deltas — never ad hoc.
Read them freely; they are NOT an out-of-context record.

## The intake queue (`issues.jsonl`) — questions awaiting judgment

An append-only JSONL event log of design questions that require the
project owner's judgment (opened by `/audit`, `/discover-design`,
`/sprint`, or humans). Never edit or delete rows; only append. An
issue's current state is the fold of its rows by id.

**Intake, not a work tracker.** An issue is a question waiting to
reach a sprint backlog. It is never worked or tracked to completion
here — it leaves the queue exactly two ways, both owner acts
performed in a `/sprint` session:

- **Promoted** — the resolution is carried into a sprint backlog as
  a corpus delta and/or work item, and the row is marked with that
  backlog's filename. The backlog is then **the** source of truth
  for the work. The issue is settled and out of consideration:
  nothing re-opens it, nothing checks back on it, and no agent reads
  the queue to learn what a promoted issue meant — whatever the work
  needs is in the backlog.
- **Retired** — the owner drops the question. Nothing is carried
  anywhere.

If a promoted decision later turns out wrong, that is a *new* issue
with a new id, not a revival of the old one.

Open issues gate the work they bear on, not all work. A `/sprint`
planning new work drafts it first, then resolves — with the owner —
every open issue that bears on it, because building over such an
issue would decide it silently. Issues the sprint's work neither
touches nor presumes an answer to stay open, untouched, for a later
sprint. A sprint whose stated purpose is working the queue takes the
queue (or a named batch of it) as its agenda instead.

## Project records (`backlogs/`, `sketches/`, `history/`) — out of context by default

Committed, versioned parts of the project — but not the source of
truth, and not to be pulled into context unprompted. `backlogs/`
holds sprint backlogs from `/sprint`; a backlog is in context only
while it is the work being executed. `sketches/` holds design
sketches from `/sketch` — speculative or in-progress future
thinking; reading one without a directing goal is context pollution.
`history/` holds a same-named archive folder per artifact kind
(`backlogs/`, `sketches/`, and on projects migrated from older
layouts also `specs/`, `plans/`, `coverage/`, `tensions/`):
completed or retired artifacts move there and are preserved
indefinitely.

- **Do not consult these files to understand the project.** They
  reflect a moment in time. The codebase and `design/` are the
  source of truth.
- **Do not include them in general repository exploration** or "how
  does this project work" research.
- **Do not propose updating, refreshing, or reconciling them** with
  the current state of the code. Drift between an old backlog and
  the current code is expected and fine.
- **Do not edit, rename, move, or delete files here on your own
  initiative**, even if they look stale.

Read or touch them only when the user explicitly asks, or when an
ok-planner skill directs it (e.g. `/sprint` writing a new backlog to
`backlogs/`, or an executing session archiving a completed one to
`history/backlogs/`). Do exactly what was asked, then stop.

## Lifecycle summary

`/sketch` captures an unplanned idea in `sketches/` — single-pass,
speculative, no authorization to build; when the idea is taken up
for real it flows through `/sprint`, and the sketch moves to
`history/sketches/`.

`/sprint` produces a sprint backlog in `backlogs/`: final-form corpus
deltas + work items + a fixed completion contract, with the open
issues that bear on that work resolved by the owner in-session and
promoted into the backlog. The approved backlog is where planning
stops — and from then on it, not the queue, is the source of truth
for that work. Executing it is the next section.

## Executing a sprint backlog

"Implement backlog X" is an ordinary working session, not a special
mode. Nothing about a sprint backlog requires an orchestrator or a
worker fleet: whoever picks it up — this session inline, a fan-out
of subagents, an external orchestrator — owes the same completion
contract and nothing else. Use whatever machinery the work actually
warrants; a three-item backlog is simply done, inline, by the agent
that was asked.

**The backlog is the whole brief.** It is self-sufficient by
construction: final-form deltas, work items, completion contract. Do
not go looking for context behind it — not in `issues.jsonl` (a
promoted issue's substance is in the backlog, and the row is only a
receipt), not in older records under `history/`. If something the
work needs genuinely is not in the backlog, that is a gap to raise
with the owner, not to fill by inference.

**Its work items are a flat, possibly disparate list** with no theme
and no imposed order. Sequencing them is *your* job, at execution
time:

1. **Read the backlog whole first** — deltas, work items, completion
   contract — before touching anything.
2. **Stage it.** Group items that share a theme, a file surface, or
   a dependency; order the groups so nothing is built on something
   not yet there. This is real planning and it happens here, not in
   the backlog — keep it in your working state (a task list is
   ideal). Do not write a plan document; ok-planner has no plan
   artifact, and a backlog is never rewritten into one.
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
   touched stories and decisions → `/audit` last, fixing its
   mechanical findings in-cycle and re-running until that section is
   empty. `/audit`'s judgment findings file themselves to
   `issues.jsonl`; they are the next sprint's business, not this
   session's.
6. **Archive** the backlog to `history/backlogs/` once the contract
   holds.

Scale is a judgment call: independent, large stages are worth
parallel subagents or a worktree; coupled or small ones are not. The
contract in step 5 is what does not scale away.
