---
topic: context-discipline
kind: discipline
---

# Context discipline: records out of context, design read freely

## Description

ok-planner splits its estate into three content kinds with different **context** rules (explicitly "a context-discipline rule, not a commit rule" — everything is committed):

1. **Durable design docs (`design/`)** — "source of truth, read freely ... with the same source-of-truth weight as code." The one subdirectory agents read like code.
2. **The intake queue (`issues.jsonl`)** — "operational state, not a record; skills fold it when they need it," never editorialized into prose summaries.
3. **Project records (`sprints/`, `sketches/`, `history/`)** — "committed, versioned parts of the project — but not the source of truth and not to be pulled into context unprompted. `history/` describes a past moment; reading it without a directing goal is context pollution when you are reasoning about the project as it is now."

The one exception to record-avoidance: "the sprint you are actively executing is in context for as long as you are executing it" — it is "your brief." The materialized estate CLAUDE.md turns the discipline into four imperatives for any agent that wanders in: don't consult records to understand the project; don't include them in general exploration; "Do not propose updating, refreshing, or reconciling them with the current state of the code. Drift between an old sprint and the current code is expected and fine"; don't edit/rename/move/delete them on your own initiative "even if they look stale."

The rule is enforced at multiple layers so it holds for agents that never load a skill: the ok-conduct output style carries it as a standing rule ("Don't pull `.ok-planner/` into context unless directed there"); the materialized `.ok-planner/CLAUDE.md` sits inside the directory itself ("Putting them under `.ok-planner/` with an embedded `CLAUDE.md` signals to any agent that wanders in: this is the planner's directory, treat it correctly"); the cheatsheet compresses it into the always-in-context layer; and individual skills embody it (audit "Does not read `.ok-planner/sprints/` or `.ok-planner/history/`"; sprint boilerplate "Do not go looking for context behind it — not in `issues.jsonl`, not in `history/`").

The archive rule rides along: "whenever an artifact kind is retired or an artifact completes, it moves to its same-named folder under `history/`" (true-up: "This is the general completion rule, not a migration special case"). "Nothing is deleted: `history/` preserves the record ... preserved indefinitely," out of context by default; migrated projects may hold `history/specs/`, `history/backlogs/`, `history/plans/`, `history/coverage/`, `history/tensions/` beside the live kinds' archives.

## Code surface

- `plugins/ok-planner/scripts/ok-planner-CLAUDE.md` (the materialized statement — "Project records ... out of context by default" section and its four bullets).
- `plugins/ok-planner/output-styles/ok-conduct.md` (the final rule).
- `scripts/ok-planner-cheatsheet.md`; `skills/audit/SKILL.md` NOT-do; sprint boilerplate step 1; `skills/true-up/SKILL.md` ("Why this skill exists" three-kinds breakdown; archive rule in §3b).

## Prose surface

- Index skill "Artifact layout" closing paragraph (the same three-way split with the two exceptions).

## Adjacent topics

- `ok-planner-estate`, `design-corpus`, `issue-queue`, `sprint`, `ok-conduct`, `pre-4-0-kinds` (what history/ absorbs).

## Observations

- The discipline is stated in at least six places with consistent substance; the estate CLAUDE.md is the fullest and the conduct is the only statement that reaches sessions with no ok-planner skill active — but only for users running the optional ok-conduct output style. A session with neither conduct nor cheatsheet sees only the embedded `.ok-planner/CLAUDE.md`.
- "Out of context by default" is defined behaviorally (don't read unprompted) rather than mechanically — no hook or tool enforces it; it is pure prose discipline, which the plumbline manifesto's own cost model ("discipline does not compose across sessions; checks do") would classify as the weak form. The suite appears aware and accepts it for context rules.
