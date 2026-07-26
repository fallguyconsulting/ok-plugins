# ok-planner Cheatsheet

Materialized by ok-planner v{{OK_PLANNER_VERSION}}. Plugin-owned: overwritten
wholesale by `/true-up`; project-specific rules belong in your own files under
`.claude/rules/`.

The planner's estate lives in `.ok-planner/` (its embedded `CLAUDE.md` carries
the full per-directory rules). The short version every session needs:

## The three content kinds

- **`design/` — source of truth, read freely.** Concepts, stories, decisions:
  the project's durable model, same weight as code. What it *commits to*
  changes only by applying an approved sprint's corpus deltas — never ad
  hoc; how a commitment is *expressed* may be repaired in-cycle by the
  certification fix loop and `/verify-issues` when the rules determine the
  compliant text and no commitment changes, each repair surfaced for
  after-the-fact veto. Code cites it via
  `@concept:` / `@story:` / `@decision:` annotations.
- **`issues/` — the issue intake.** One markdown file per question awaiting
  the owner's judgment. Anyone may file one; `/verify-issues` makes each
  ruling-ready — closing it when the corpus already answers it, repairing
  rules-determined intent-preserving gaps (code- or corpus-side), and
  rewriting the rest as a from-the-top
  narrative ending in a marked generated/recommended ruling the owner
  accepts by silence or overrides. Only a `/plan-sprint` session closes
  one, by **promoting** it into that sprint (file stamped with the
  sprint's name) or **retiring** it. Closed files move to
  `history/issues/`. Unmarked ruling text is the owner's alone.
- **`sprints/`, `sketches/`, `history/` — records, out of context by
  default.** Do not read them to understand the project, do not include them
  in general exploration, do not reconcile them with current code. A sprint
  is in context while you are executing it, not otherwise; `sketches/` is
  speculative future thinking (written by `/sketch`); `history/` is the
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
`/prove` every touched story and decision, and finish with `/certify-work`
(change-scoped; its review-fix loop fixes every finding it can — only
architect-confirmed intent forks land back in `issues/`, made ruling-ready
by `/verify-issues`). Whole-corpus certification is `/certify-all`, run on
the owner's cadence, not per close. The full execution shape is in `.ok-planner/CLAUDE.md`.
On completion, artifacts move to their same-named folder under `history/`.

## Hard rules

- A sprint is a disparate set of work items: no theme, no order. Staging
  it is execution's job — never write a plan document from one.
- The sprint is the source of truth for its work. A promoted issue is settled;
  never read the queue to find out what a sprint "really meant".
- Open issues gate the work they bear on, not all work; the rest stay queued.
- Design docs are current-state only: no changelogs, no roadmaps, no TODOs.
- Nothing in the suite runs true-up from a hook; it is always a user action.
