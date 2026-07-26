---
issue: budget-baseline-outside-estate
kind: discover
category: inconsistent
artifacts:
  - decision:ratchet-over-soft-start
  - concept:estate
status: verified
opened: 2026-07-25T02:16:44Z
---

# Ratchet baseline lives at repo root outside the estate with no documented migration

## Problem

The baseline file sits at the repo root, outside the dot-directory the contract says holds the estate — predating the dot-directory layer like the old root config, but unlike it, with no documented migration path.

## Candidates

- Amend decision:ratchet-over-soft-start Choice to name the baseline's home inside the estate and migrate via true-up
- Amend concept:estate Boundaries to document the baseline as a sanctioned root-level exception

## Discussion

**The question.** The Plumbline ratchet's baseline file, `.plumbline-budget.json`,
is written and read at the consumer repo's root, outside `.ok-plumbline/`.
Should it move inside the estate (with `/ok-plumbline:true-up` migrating
existing root copies, mirroring how the old root `.plumbline.json` config
is handled), or is a root-level baseline file a legitimate, permanent
exception the corpus should name explicitly?

**Where this comes from, re-verified against current code.** The filed
evidence holds up under a fresh read of `plugins/ok-plumbline/`:

- `plugins/ok-plumbline/skills/budget/SKILL.md` has the ratchet script write
  and read `.plumbline-budget.json` at the project root (`node "$bin" budget
  save .` / `budget check .`, with the doc explicitly naming the root-level
  path).
- `plugins/ok-plumbline/skills/ci/SKILL.md` and
  `plugins/ok-plumbline/docs/plumbline-porting-guide.md` both refer to the
  same root-level `.plumbline-budget.json`, including the guide's own
  cleanup step ("once the baseline reaches 0: remove
  `.plumbline-budget.json`").
- `plugins/ok-plumbline/skills/true-up/SKILL.md` §1 (Diagnose) *reports* the
  baseline file's existence as optional, but §3 (Converge the estate) —
  which does migrate a root-level `.plumbline.json` config into
  `.ok-plumbline/config.json` with `git mv`, exactly the "old root config"
  precedent the issue points at — has no equivalent step for the budget
  file. Nothing in true-up ever moves, or offers to move, an existing
  `.plumbline-budget.json` into the estate. The asymmetry the issue names
  (config migrates, budget doesn't) is real and current, not stale.

No rot to note: the issue's evidence matches the code as it stands today.

**What the corpus says.**

- `concept:estate` (Boundaries): "The estate is plugin territory inside the
  consumer's repo... the one file a plugin owns outside it is its
  cheatsheet." This is stated as an enumerated, singular exception — the
  cheatsheet — with no mention of a budget/ratchet file. Read literally, a
  root-level `.plumbline-budget.json` is currently unsanctioned by this
  boundary. The same section does carve out "documented pre-migration
  marker locations," but the issue's own Problem notes this file has no
  documented migration path, so it doesn't presently qualify for that
  carve-out either — it isn't a legacy marker being phased in, it's the
  live, current location the skill itself writes to.
- `decision:ratchet-over-soft-start`: fully specifies the ratchet's
  *mechanism* (baseline count, CI fails on increase, checks stay strict)
  but is silent on where the baseline file lives. Its Choice, Rationale,
  Alternatives, and Proof never mention a path or the estate at all — this
  decision answers "how does adoption ease," not "where does the record
  live."
- `story:incremental-lint-adoption`: describes the ratchet from the owner's
  experience (survey, cluster, plan, ratchet) and requires "a recorded
  baseline" that gates CI — also silent on the file's location.
- `decision:filesystem-discovery-markers`: establishes that estate presence
  is the sole discovery signal, plus "documented pre-migration marker
  locations." This is about *discovering which plugins are in use*, not
  about where a plugin's own operational files live once it's clearly
  already in use (an estate already exists here) — tangential rather than
  dispositive, and its Proof section notes the "documented" bar for
  legacy markers is itself unenforced today, so it can't be leaned on to
  legitimize an undocumented one.
- `decision:per-project-pinning`: covers version-stamping of materialized
  artifacts (scripts, hooks, cheatsheets, the vendored binary) and prefers
  project copies over the plugin's. The budget file isn't a materialized,
  version-stamped artifact in this sense — it's ratchet *data* the project
  itself produces via `budget save`, not something true-up writes from a
  plugin canonical. This decision doesn't reach the question either.

No artifact in the bearing set states, one way or the other, where the
ratchet baseline file should live. The question is open.

**What the code does today.** `.plumbline-budget.json` is created by
`/ok-plumbline:budget save` at the repo root (never inside
`.ok-plumbline/`); read from the root by `/ok-plumbline:budget` (check),
`/ok-plumbline:ci`-generated workflows, and the PostToolUse hook's full
lint pass; reported-but-not-converged by true-up's diagnose step; and never
touched by true-up's converge step. There is no code path that would move
an existing root-level baseline into the estate even if the corpus were
amended to want that — a migration step would need to be added wherever
the ruling lands.

**Candidates, and what each means.**

1. **Move the baseline inside the estate; true-up migrates it.** Amend
   `decision:ratchet-over-soft-start`'s Choice to name
   `.ok-plumbline/budget.json` (or similar) as the baseline's home, and add
   a true-up §3-style migration (`git mv .plumbline-budget.json
   .ok-plumbline/budget.json` when the destination doesn't already exist,
   mirroring the existing config migration exactly). Code changes: the
   `budget` skill's save/check paths, `ci`'s generated workflow, the
   porting guide's references, and true-up's converge step all move in
   lockstep. This makes the estate boundary in `concept:estate` literally
   true again ("the one file... is its cheatsheet") with no asterisk, and
   gives every plugin-owned file one consistent home. Cost: an extra
   migration path to build and test, and CI workflows already emitted by
   `/ok-plumbline:ci` for existing adopters reference the old root path —
   those would need regenerating (or the check would need to look in both
   places during a transition).
2. **Document the baseline as a sanctioned root-level exception.** Amend
   `concept:estate`'s Boundaries to name the ratchet baseline alongside the
   cheatsheet as a file a plugin may legitimately place outside the
   estate — e.g. because CI systems and tooling outside Claude Code (raw
   `git diff`, other linters, humans skimming the repo root) benefit from
   the ratchet state being visible at the root the same way `.gitignore` or
   `.editorconfig` is, rather than buried in a dot-directory. No code
   changes needed — this ratifies the status quo. Cost: it weakens the
   estate boundary's single-exception claim into a small enumerated list,
   and invites the question of whether other plugins' operational
   root-level files (if any exist or get added later) should also
   qualify — the boundary becomes a list to maintain rather than a rule.
3. **A third shape neither candidate names:** treat the budget file the
   same way `filesystem-discovery-markers` treats legacy config —
   "documented pre-migration marker" — by explicitly documenting *today's*
   root path as the sanctioned legacy location while designing any *future*
   baseline format to live in the estate. This splits the difference (no
   migration code needed now, boundary stays honest) but only postpones
   candidate 1 vs. 2 rather than resolving it, and the issue's Problem
   already observes this path currently lacks the documentation
   `filesystem-discovery-markers` would require.

**What the ruling must decide.** Does the Plumbline ratchet baseline file
belong inside `.ok-plumbline/` (amend
`decision:ratchet-over-soft-start` and add a true-up migration), or is a
root-level baseline a second sanctioned exception to the estate boundary
(amend `concept:estate`)?

## Ruling

<!-- Owner: write your decision here in your own words.
The next /plan-sprint picks it up. Leave empty to discuss
it live in a planning session instead. -->
