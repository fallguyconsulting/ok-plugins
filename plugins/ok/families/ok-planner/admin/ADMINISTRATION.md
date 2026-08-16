# ok-planner administration

The judgment side of this family's administration — everything the deterministic core beside this document (`admin/converge`) cannot encode. The suite's front door (`/ok`) reads this document when it administers the family; nothing here is improvised, and nothing here is a user-facing verb.

The governing rule is ownership: converge freely overwrites what the suite owns — version-stamped, regenerable files — and migration moves retired-layout files into the shape the current skills expect. Anything not suite-owned reaches the owner as a consent question.

## The core's modes

```
bash admin/converge            # converge: materialize/repair the suite-owned layer
bash admin/converge diagnose   # read-only drift report; non-zero on findings
bash admin/converge wire-hooks # consented settings transcription — see below
```

Converge materializes: the `.ok-planner/` layout (the `issues/` intake and, where `design/` exists, the `audits/` corpus buckets), `.ok-planner/CLAUDE.md` and the cheatsheet from their templates, the session-start hook into `.ok-planner/hooks/`, the helper scripts (`scripts/surface-corpus`), and the vendored skills under `.claude/skills/` — removing retired payloads (the merged `true-up` verb, any `bin/audit-check`, `bin/document-check`, or `bin/surface-reconcile` an earlier release materialized, and the retired surface apparatus below). Idempotent: a compliant project is a silent no-op.

## Wire the hook — consent, then transcription

The session-start hook executes through a `SessionStart` entry in `.claude/settings.json` carrying the `startup|clear|compact` matcher (never firing on resume) — owner-declared configuration, written **only** as transcription of the owner's explicit yes, by the core's `wire-hooks` mode. Diagnose reports a missing or drifted entry as a `WIRING NEEDED` block carrying the exact entry and the exact consent command. Present the block, ask, and on yes run the command it names. Declined means declined: record it in the report and write nothing.

## Identify overlapping project context

Per the integration contract, surface preexisting project content that overlaps this family's territory — planning, design-record, and decision-log material the suite would now govern — before converging, and never convert it silently. Scan the project root and one level into the conventional doc locations (`docs/`, `doc/`, `design/`, `.claude/rules/`) for:

- planning and record directories beside `.ok-planner/` — `plans/`, `specs/`, `proposals/`, `rfcs/`, `adr/`, `decisions/`, `sprints/`, `backlog*/`, `design/` at the repo root;
- design or decision documents carrying corpus-shaped content — an architecture-decision log, a concepts/glossary document, a requirements or user-story file;
- rules files in `.claude/rules/` other than this family's cheatsheet that state planning or design-doc conventions.

Tell suite-materialized from hand-written by the stamp: everything the suite owns carries a `Materialized by ok-planner v…` line (and lives under `.ok-planner/` or is the cheatsheet). No stamp means it is the owner's; the suite's own retired layouts are the migration section's business, not this one's.

For each hit, propose a conversion plan for the owner's consent, naming three outcomes and a recommendation:

- **fold** — corpus material: carry it into `.ok-planner/design/` as concept / story / decision artifacts, executed by `/discover-design` on an empty corpus or a `/plan-sprint` delta on a populated one — never by this administration, which authors no corpus content;
- **keep alongside** — specific design or reference material the corpus deliberately does not hold (interface grammars, schemas, runbooks): leave it where it is and record that it was seen and kept;
- **retire** — superseded: the owner moves it to their own archive; the administration deletes nothing.

Report every hit and its outcome in the administration report, including the ones the owner declined to act on.

## Check issue-intake integrity

Every file under `.ok-planner/issues/` must carry frontmatter with `issue` (the stable slug), a known `kind` (`audit` | `discover` | `sprint` | `human`), `category`, a known `status` (`open` | `verified` | `answered` | `promoted` | `retired`), and `opened`. A `status: promoted` file must carry a `sprint:` field naming a file under `sprints/` or `history/sprints/` — a promotion receipt pointing at nothing is a finding. An `answered` or `retired` file still sitting in `issues/` is a finding (closed states live in `history/issues/`). Report a malformed file with its path for the human to repair — issue files are not suite-owned, and the administration never edits them.

## Layout migration (only when the core reports one)

Run the migration for whatever `PRE-MIGRATION LAYOUT PRESENT` names, with no consent prompt: driving the administration is itself the authorization to migrate the suite's own retired layouts, and the current skills misbehave against a retired one. The migrations are mechanical — files move between directories, contents are not rewritten, `history/` preserves the record. Report what was done.

The one exception is a genuine collision between old and new locations; the first migration below stops for the owner to resolve it.

### `backlogs/` (or `specs/`) → `sprints/` (the backlog → sprint rename)

The planning ceremony's artifact is now the **sprint**, in `sprints/`. A recent layout called it a "sprint backlog" (`backlogs/`); an older one a "sprint spec" (`specs/`). Either migrates the same way:

1. `git mv` (or `mv`) every file from `.ok-planner/backlogs/` into `.ok-planner/sprints/`, and from `.ok-planner/history/backlogs/` into `.ok-planner/history/sprints/` — likewise from any `specs/` and `history/specs/` — merging with whatever is there. Remove the emptied directories.
2. Leave the moved files' contents alone: an archived record that calls itself a backlog or a spec is a record of what it was. Live sprints the owner still intends to execute may be reheaded `# Sprint: …` if they ask — offer, don't insist.
3. Do not touch a legacy `issues.jsonl` here. Its rows stay as written — legacy `promote` rows with a `backlog` field (and older `resolve` rows with a `spec` field) fold as terminal, the legacy field read as the sprint reference. Its conversion is the final migration's business, below.
4. Re-run the core; it must no longer report `backlogs`, `history/backlogs`, `specs`, or `history/specs`.

If a project has both `backlogs/` and `sprints/` (or `specs/` and `sprints/`) with overlapping filenames, stop and put the collision to the owner — never overwrite.

### Pre-4.0 kinds

Read `{{ISSUE-FILE-FORMAT}}` in the family's `skills/_shared/artifact-definitions.md` first, then:

1. **`design/tensions/` → issue files.** For each live tension file (skip `_resolved/` and `_rejected/` — settled history): write an issue file to `.ok-planner/issues/` per `{{ISSUE-FILE-FORMAT}}` with `issue` = the tension slug, `kind: "human"`, `category` from the tension's frontmatter, `artifacts` from its `affects:` list, `status: open`, the title from its title, `## Problem` condensed from its "What is muddy" and "Why it matters" sections, `## Candidates` from its "Resolution candidates", filename timestamp via `date -u +%Y-%m-%d-%H%M%S` (skip slugs already present). Then move the whole `design/tensions/` tree to `history/tensions/`.
2. **`plans/`, `coverage/`, `design/review-notes*.md` → archive.** These kinds have no live consumers. (`sketches/` is not among them — sketches remain live, archived per-file when an idea is taken up or abandoned.) Move each retired kind to its same-named folder under `history/` (`history/plans/`, `history/coverage/`; loose `design/review-notes*.md` files to `history/` directly), merging with anything there. Nothing is deleted. This is the general completion rule, not a migration special case: a retired or completed artifact moves to its same-named folder under `history/`.
3. Re-run the core; it must no longer report a retired layout.

### `decision-proof-sections` — the retired proof-mandate model

Decisions carried a mandatory `## Proof` section; a decision's verification is now its implementation audit, and a `## Proof` section is a compliance violation. When the core reports `decision-proof-sections`:

1. For each live decision carrying a `## Proof` section: delete the section, heading and body, and nothing else. The content survives in git history, and the enforcement it named stays discoverable through `@decision:` annotations.
2. This is a form migration, not a commitment change: Choice, Rationale, and Alternatives are the commitment, and none move. The next audit re-derives the verification as a determination about a named commit.
3. Test files the old sections pointed at stay exactly where they are — ordinary tests, no longer corpus-mandated. Never delete or rename them here.
4. Re-run the core; it must no longer report `decision-proof-sections`.

### Legacy `issues.jsonl` → the file-per-issue intake

The conversion is `/verify-issues`' job: expanding rows into files is mechanical, but making them ruling-ready is agentic work that belongs with the verifier. When the core reports `issues.jsonl`, tell the owner to run `/verify-issues` in the project. The administration never runs work-driving verbs.

### Falsifier and story-proof elimination (automatic — the core does it on converge)

Falsifiers and story proof sections are retired corpus-wide: a story affirms in the positive and carries no verification section; verification is the periodic audit's. This migration needs no procedure — the core eliminates the retired material on sight (`## Falsifier` and `## Proof` sections stripped from `design/stories/*.md`, the `falsifier` concept file and its TOC line removed, touching nothing outside those sections) and reports it on its `Retired story sections eliminated:` line. It also removes the retired `prove` vendored skill, `bin/proof-timings`, and the machine-local `proof-timings.json`. Relay the line in the administration report.

## The retired corpus view

The corpus view is gone: the local page, its service, the `browse` helper, and the per-release frontend build. The core sweeps the leftovers on sight — the vendored `browse` skill, `bin/corpus-view`, `bin/browse`, the placed `browser/` build, the machine-local `run/` state, and the estate's own `.gitignore` (its only entries covered those two directories). Every removal is suite-owned, so none is a consent question; each swept path appears on the core's `Retired payloads removed:` line. Relay that line.

## The audit model changed shape

Audits used to be adversarial determinations (`satisfied` | `violated`) carrying an artifact hash and content-anchored citations, re-derived by certification at every close and invalidated by a staleness computation. They are now one-paragraph verdicts on two independent axes — `implementation:` (`supported` | `unsupported`) and `text:` (`compliant` | `noncompliant`) — about a named commit, written by the periodic audit run. Nothing computes staleness, and there are no citations.

The core handles the whole migration on sight; relay each line it reports:

- **The retired audit corpus is removed** (`Retired audit corpus removed:` line). There is no mechanical conversion — turning a citation-bearing audit into a one-paragraph determination requires reading the code, the audit run's own job — so the next `/audit` writes the corpus fresh.
- **The inspection registry is swept**, with the other retired estate payloads, on the `Retired payloads removed:` line.
- **The committed source graph goes with its extractor.** The graph existed so audits could cite code by node identity and hash; with citations gone it has no reader. `graph/` and `bin/source-graph` are swept whole; the graph was mechanically derived, so nothing is lost the sources do not hold.
- **In-flight sprint contracts are brought current.** A sprint still in `sprints/` when the model changed names the retired implementation-audit term, whose clean bar no longer exists. The contract is fixed suite-owned boilerplate and the compliant end state is determined, so the core drops the retired item, renumbers the one below it, fixes the goal rule's item range, and reports the count. Archived sprints keep their old wording.
- **The `certify-all` verb is retired**; the periodic audit replaced it.

Two things the owner should know after the upgrade: until the first `/audit` run the corpus is unaudited, and the checker says so — the honest state, not a defect; and `/certify-work` no longer audits, so a close is a smaller gate — tests, sprint alignment, code review.

## The surface apparatus changed shape

The public-surface machinery used to be three artifacts kept consistent by a reconciler tool: a JSON **surface declaration**, a prose **surface guidance**, and per-kind committed **member lists** at `surface/members/<kind>` — with the audit writing a **stamped ruling** at `audits/surface/ruling.json` and `bin/surface-reconcile` comparing it all against the tree. That apparatus is retired. The public surface is now one owner-authored prose document at `.ok-planner/surface/surface.md` (the **surface intent**, per `concept:surface-intent`) plus a per-run **surface extraction** at `.ok-planner/audits/surface/extraction.json` an audit subagent writes each run (per `concept:surface-extraction`).

The core handles the migration on sight. On any converge over a legacy estate, the sweep removes:

- `.ok-planner/surface/surface.json` — the retired declaration.
- `.ok-planner/surface/guidance.md` — the retired guidance.
- `.ok-planner/surface/members/` — every per-kind committed member list.
- `.ok-planner/audits/surface/ruling.json` — the retired ruling.
- `.ok-planner/audits/surface/extraction.json` — only when it sits beside the retired apparatus above; the next `/audit` writes a fresh one. An extraction on its own is the current audit's committed record and stays.
- `.ok-planner/bin/surface-reconcile` — the retired tool.

The `.ok-planner/surface/` directory itself stays — the intent document lives there. Where the intent is missing after the sweep, converge prints an advisory line: the next `/audit` run files one intake issue asking the owner to author it, and the story track treats every element as internal until the intent lands.

## The documentation run runs no validator over its own corpus

The documentation ceremony used to end with a Check stage that ran `.ok-planner/bin/document-check` and refused completion on a non-zero exit. The stage and the tool are retired: the orchestrator constructs the corpus, presents, and stamps; nothing sits in its hand with a pass/fail exit. A malformed corpus is rewritten whole by the next `/document` run — the corpus is a full-reassessment-per-release artifact (see `.ok-planner/design/decisions/full-reassessment-per-release.md`), so drift self-corrects as audit drift does.

The core removes any `.ok-planner/bin/document-check` an earlier release materialized and reports it on a `Retired binary removed:` line. Nothing to consent to.

## The ceremony goal files

Converge materializes two goal files beside the ceremony contributions: `.ok-planner/ceremony/audit-goal.md` and `.ok-planner/ceremony/document-goal.md`. Each is a vendored brief whose **path is what the owner hands to the native `goal` mechanism** — the audit's opening walk ends by handing the owner the one-line `/goal` paste naming it — so a long run drives to completion hands-free after its one interactive moment. Each carries the driving agent's role and course (as pointers to the vendored skill and the ceremony contributions, never restating them) and the checker's goal rule. Suite-owned, regenerated on every converge; nothing to migrate, nothing to consent to.

## What the administration does NOT do here

- Does not modify the project's root `.gitignore`, and writes no ignore file of its own. Whether `.ok-planner/` is tracked is the owner's decision; every file the estate carries is tracked content.
- Does not write outside the owned set: under `.ok-planner/` only `CLAUDE.md`, `hooks/session-start`, `scripts/surface-corpus`, `ceremony/<verb>.md` and the two goal files, the retired payloads it removes, and (migration only) new issue files written from retired tensions; outside it only the cheatsheet and the vendored skill files under `.claude/skills/`. `.claude/settings.json` is reachable solely through the consented `wire-hooks` path.
- Does not validate the contents of existing artifacts — the periodic `/audit` run's job.
- Does not preserve local edits to `.ok-planner/CLAUDE.md`. The file is regenerated from the template on every converge; project guidance belongs in the project's own root CLAUDE.md.
