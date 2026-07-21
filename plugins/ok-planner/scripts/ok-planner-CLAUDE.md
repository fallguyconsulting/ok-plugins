# .ok-planner — the planner's directory

Materialized by ok-planner v{{OK_PLANNER_VERSION}}. Skill-owned
boilerplate: this file is overwritten wholesale by `/affirm`; do not
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
implementation diagrams. Those live in code, in `specs/`, and in
other project documentation.

Code references the design (via `@concept:`, `@story:`, `@decision:`
annotations at points of enforcement), not the other way around. The
design docs are **a source of truth with the same weight as code**:
they describe the project as it stands. Like code, they change only
by applying an approved sprint spec's corpus deltas — never ad hoc.
Read them freely; they are NOT an out-of-context record.

## The issue queue (`issues.jsonl`) — the human-review backlog

An append-only JSONL event log of design questions that require the
project owner's judgment (opened by `/audit`, `/discover-design`,
`/sprint`, or humans; resolved only in a `/sprint` session). Never
edit or delete rows; only append. An issue's current state is the
fold of its rows by id. While any issue is open, `/sprint` will not
plan new work — draining the queue is the planning session's entry
gate.

## Project records (`specs/`, `history/`) — out of context by default

Committed, versioned parts of the project — but not the source of
truth, and not to be pulled into context unprompted:

- **Do not consult these files to understand the project.** They
  reflect a moment in time. The codebase and `design/` are the
  source of truth.
- **Do not include them in general repository exploration** or "how
  does this project work" research.
- **Do not propose updating, refreshing, or reconciling them** with
  the current state of the code. Drift between an old spec and the
  current code is expected and fine.
- **Do not edit, rename, move, or delete files here on your own
  initiative**, even if they look stale.

Read or touch them only when the user explicitly asks, or when an
ok-planner skill directs it (e.g. `/sprint` writing a new spec to
`specs/`, or an implementation orchestrator archiving a completed
spec to `history/specs/`). Do exactly what was asked, then stop.

## Lifecycle summary

`/sprint` drains the issue queue with the owner, then produces a
sprint spec in `specs/`: final-form corpus deltas + work items + a
fixed completion contract. An implementation orchestrator (outside
ok-planner) executes the spec: applies the deltas to `design/`,
builds the work items, runs `/prove` until every touched story and
decision has a passing, non-vacuous proof, and finishes with
`/audit` — whose judgment findings land back in `issues.jsonl` for
the next sprint. Completed specs are archived to `history/specs/`.
