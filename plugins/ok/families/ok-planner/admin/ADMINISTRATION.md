# ok-planner administration

The judgment side of this family's administration — everything the deterministic core beside this document (`admin/converge`) cannot encode. The suite's front door (`/ok`) reads this document when it administers the family; nothing here is improvised, and nothing here is a user-facing verb.

The governing rule is ownership: converge freely overwrites what the suite owns — version-stamped, regenerable files — and migration moves retired-layout files into the shape the current skills expect. Anything not suite-owned reaches the owner as a cleanup offer, and the core's `resolve` mode applies the fix on the owner's yes.

## The core's modes

```
bash admin/converge            # converge: materialize/repair the suite-owned layer
bash admin/converge diagnose   # read-only drift report; exit 0 clean, 1 on drift, 3 when only cleanup offers await the owner
bash admin/converge wire-hooks # consented settings transcription — see below
bash admin/converge resolve <id> [keep-new|keep-old|--from <draft>]  # one consented cleanup — see below
```

Converge materializes: the `.ok-planner/` layout (the `issues/` intake and, where `design/` exists, the `audits/` corpus buckets), `.ok-planner/CLAUDE.md` and the cheatsheet from their templates, the session-start hook into `.ok-planner/hooks/`, the helper scripts (`scripts/surface-corpus`), the task tracker and the review loop's mechanics (`bin/tasks`, `bin/review`), the review estate at `.ok-planner/review/` (its `CLAUDE.md` and `catalog/` overwritten, its `config.json` and `project.md` seeded once and never overwritten; the seeded `config.json` lists the ok-plumbline standards under `standards` and the plumbline lint under `checks` only where `.ok-plumbline/` exists, and leaves both empty otherwise), and the vendored skills under `.claude/skills/` — removing retired payloads (the merged `true-up` verb, any `bin/audit-check`, `bin/document-check`, or `bin/surface-reconcile` an earlier release materialized, and the retired surface apparatus below). Converge removes suite-stamped retired files and the retired estate payloads itself, with no offer and no commit check. The commit-first rule binds `resolve` and the `.ok-review/` migration: neither deletes a file that carries uncommitted changes. Idempotent: a compliant project is a silent no-op.

## Wire the hook — consent, then transcription

The session-start hook executes through a `SessionStart` entry in `.claude/settings.json` carrying the `startup|clear|compact` matcher (never firing on resume) — owner-declared configuration, written **only** as transcription of the owner's explicit yes, by the core's `wire-hooks` mode. Diagnose reports a missing or drifted entry as a `WIRING NEEDED` block carrying the exact entry and the exact consent command. Present the block, ask, and on yes run the command it names. Declined means declined: record it in the report and write nothing.

## Cleanup offers — consent, then resolve

Diagnose and converge print one `CLEANUP OFFERED (ok-planner): <id>` block for each item converge leaves for the owner. The block says what is there, what the fix does, the recommended answer, and the exact consent command. The front door (`/ok`) presents every block in one question and runs the command for each item the owner accepts. `resolve` re-reads the offers first, refuses an id diagnose would not report now, and applies that one fix: it deletes with `git rm` where git tracks the file, so the deletion is staged and recoverable, and moves with `git mv` the same way. A block whose paths carry uncommitted or staged-only changes prints an `Uncommitted:` line, and a block whose paths sit behind a symbolic link prints a `Symbolic link:` line. `resolve` refuses such an item, changing nothing, until the owner commits those changes or removes the link and runs `/ok` again. No offer has a choice that discards changes. The consent command quotes the id, so a path with a space stays one argument. Converge again after it. `/ok` records an offer the owner declines as declined, and the next run offers it again.

An id is `<kind>:<path from the project root>`, so it stays the same across diagnose and converge runs:

| id | what is there | the fix |
|---|---|---|
| `collision:.claude/skills/<folder>` or `collision:.claude/agents/<profile>.md` | the project's own unstamped files at vendored paths, listed in the block, which says whether they differ from the suite's copy | delete the listed files and nothing beside them; converge writes the suite's copy, and the folder's other files stay |
| `retired-verb:.claude/skills/<name>` | files the project wrote in a skill folder at a retired name (`plan-sprint-code`, `converge-local`, `converge-cascade`, and the rest of the retired list), listed in the block; converge removes the folder's suite-stamped files itself | delete the listed files |
| `rule-file:.claude/rules/defect-issues.md` | a project rule file the cheatsheet's "Defect issues" section now carries, beside facts only this project holds | write a non-empty draft as `.claude/rules/project-defect-issues.md`, then delete the old file; an empty draft only deletes it |
| `catalog-edits:.ok-review/catalog/<file>` | an old catalog file that differs from the suite's, or matches it but carries uncommitted changes; its `Show:` line prints the diff | delete it; the suite's catalog stands |
| `review-edits:.ok-review/bin/review` or `review-edits:.ok-review/CLAUDE.md` | the old review tool or directory note, differing from the suite's copy or carrying uncommitted changes; its `Show:` line prints the diff | delete it; the suite's copy stands |
| `review-leftover:.ok-review/<path>` | a file in `.ok-review/` that is neither an owner file the move takes nor a suite file | `move` moves it to the same path under `.ok-planner/review/`, offered only while that path is free; `delete` deletes it |
| `review-config:.ok-planner/review/config.json` | a review config that does not parse, is not an object, or lacks `exclude`, `prose_suffixes`, `test_patterns`, or `bug_families`, so converge rewrites no stale setting in it | write the draft over it |
| `review-conflict:.ok-review/<item>` | `.ok-review/<item>` and `.ok-planner/review/<item>` both hold content | `keep-new` deletes the old one; `keep-old` replaces the new one with the old |
| `move-conflict:.ok-planner/<path>` | a retired-layout entry whose new path is taken | `keep-new` deletes the old entry; `keep-old` replaces the new one with it |
| `intake-closed:.ok-planner/issues/<file>` | a closed issue (`answered`, `retired`, `fixed`) still in the intake | move it to `history/issues/` |
| `review-facts:.ok-planner/review/project.md` | the seeded skeleton, never filled in | write the draft |
| `review-wording:.ok-planner/review/project.md` | lines that still name `.ok-review`, listed in the block | write the draft |
| `legacy-intake:.ok-planner/issues.jsonl` | the retired single-file intake | write the drafted issue files, then delete the file |
| `tensions:.ok-planner/design/tensions` | the pre-4.0 tension layout | write the drafted issue files, then move the tree to `history/tensions/` |
| `intake:.ok-planner/issues/<file>` | an issue file whose frontmatter is malformed, defects listed | write the draft over it |

A block with a `Draft:` line needs the owner's words or judgment. The front door writes the draft to a scratch path outside the project, shows it, and on the owner's yes passes it as `--from <draft>`. Draft each kind this way. Change nothing the block does not name, and keep every line and entry it does not name as it stands:

- **`review-facts`** — the whole `project.md`: replace each section's instruction line with this project's facts, read from the tree (its root and out-of-scope paths, the commands no agent runs, the helpers the catalogs name, the `## Code rules` list of `.claude/rules/` files that state rules about the shape of code, which accept-list entry A8 enforces, the drive commands); leave a section empty where the project has nothing to say. The checks live in `config.json` `checks` alone. `resolve` refuses an empty draft and a draft identical to the seed.
- **`review-wording`** — the whole `project.md`, each listed line reworded to name the current path. `resolve` refuses a draft that is empty, has a different line count, changes a line the block does not list, or still names `.ok-review`.
- **`review-config`** — the whole `config.json`, each listed defect repaired and nothing else changed. `resolve` refuses a draft that still has a listed defect.
- **`rule-file`** — a short project rule holding only this project's own facts: each project-only skill, path, accept-list entry, or term the old file names that the cheatsheet's section leaves to the project. Where it names none, the draft is an empty file. `resolve` refuses a draft that is not shorter than the old file, or that repeats any sentence of eight or more words from the suite's text, or whose target `.claude/rules/project-defect-issues.md` already exists.
- **`legacy-intake`** — a directory with one issue file per open row of `issues.jsonl`, in `{{ISSUE-FILE-FORMAT}}`, named `<YYYY-MM-DD-HHMMSS>-<slug>.md`; rows that only close an earlier row write nothing.
- **`tensions`** — a directory with one issue file per live tension, per the pre-4.0 migration below.
- **`intake`** — the whole issue file with its frontmatter repaired per `{{ISSUE-FILE-FORMAT}}` and its body unchanged; `resolve` refuses a draft whose body differs.

`resolve` checks every drafted issue file against the same reading diagnose uses — the required fields, a known `kind` and `status`, a filed name, no name already in the intake — and writes nothing from a draft that fails it.

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

## Issue-intake integrity

Every file under `.ok-planner/issues/` must carry frontmatter with `issue` (the stable slug), a known `kind` (`audit` | `discover` | `sprint` | `human`), `category`, a known `status` (`open` | `verified` | `answered` | `promoted` | `retired` | `fixed`), and `opened`. A `status: promoted` file must carry a `sprint:` field naming a file under `sprints/` or `history/sprints/`. An `answered`, `retired`, or `fixed` file belongs in `history/issues/`. Diagnose checks every file and offers each defect: a malformed file as an `intake` draft, a closed file as an `intake-closed` move. Issue files are not suite-owned, so each fix waits for the owner's yes.

## Layout migration

Converge migrates the suite's own retired layouts on sight, with no consent prompt: driving the administration is itself the authorization, and the current skills misbehave against a retired one. The migrations are mechanical — files move between directories with `git mv` where git tracks them, contents are not rewritten, `history/` preserves the record. Converge reports each move, and diagnose reports each pending one as `retired layout:`.

- **`backlogs/` and `specs/` → `sprints/`** (the backlog → sprint rename), and `history/backlogs/` and `history/specs/` → `history/sprints/`. A moved record keeps its wording: an archived record that calls itself a backlog or a spec is a record of what it was.
- **`plans/` and `coverage/` → `history/plans/` and `history/coverage/`**, and loose `design/review-notes*.md` files → `history/`. These kinds have no live consumers. (`sketches/` is not among them — sketches remain live.)
- **Decision `## Proof` sections are stripped**, heading and body, and nothing else: a decision's verification is its implementation audit now. Choice, Rationale, and Alternatives are the commitment, and none move.

An entry whose new path already holds content moves nowhere; converge offers it as a `move-conflict`. The emptied retired directories go.

### Pre-4.0 tensions

`design/tensions/` is offered as a `tensions` draft. Read `{{ISSUE-FILE-FORMAT}}` in the family's `skills/_shared/artifact-definitions.md` first. Draft one issue file per live tension file (skip `_resolved/` and `_rejected/` — settled history), with `issue` = the tension slug, `kind: human`, `category` from the tension's frontmatter, `artifacts` from its `affects:` list, `status: open`, the title from its title, `## Problem` condensed from its "What is muddy" and "Why it matters" sections, `## Candidates` from its "Resolution candidates", and the filename timestamp from `date -u +%Y-%m-%d-%H%M%S`; skip a slug already in the intake. On the owner's yes, `resolve` writes the files and moves the whole tree to `history/tensions/`.

### Legacy `issues.jsonl` → the file-per-issue intake

`issues.jsonl` is offered as a `legacy-intake` draft: one issue file per open row, in `{{ISSUE-FILE-FORMAT}}`. A legacy `promote` row with a `backlog` field (and an older `resolve` row with a `spec` field) closes its issue; the legacy field names the sprint. After the files land, `/triage-issues` makes them ruling-ready; the administration never runs work-driving verbs.

### Falsifier and story-proof elimination (automatic — the core does it on converge)

Falsifiers and story proof sections are retired corpus-wide: a story affirms in the positive and carries no verification section; verification is the periodic audit's. This migration needs no procedure — the core eliminates the retired material on sight (`## Falsifier` and `## Proof` sections stripped from `design/stories/*.md`, the `falsifier` concept file and its TOC line removed, touching nothing outside those sections) and reports it on its `Retired story sections eliminated:` line. It also removes the retired `prove` vendored skill, `bin/proof-timings`, and the machine-local `proof-timings.json`. Relay the line in the administration report.

## The retired corpus view

The corpus view is gone: the local page, its service, the `browse` helper, and the per-release frontend build. The core sweeps the leftovers on sight — the vendored `browse` skill, `bin/corpus-view`, `bin/browse`, the placed `browser/` build, the machine-local `run/` state, and the estate's own `.gitignore` (its only entries covered those two directories). Every removal is suite-owned, so none is a consent question; each swept path appears on the core's `Retired payloads removed:` line. Relay that line.

## The audit model changed shape

Audits used to be adversarial determinations (`satisfied` | `violated`) carrying an artifact hash and content-anchored citations, re-derived at every sprint close and invalidated by a staleness computation. They are now one-paragraph verdicts on two independent axes — `implementation:` (`supported` | `unsupported`) and `text:` (`compliant` | `noncompliant`) — about a named commit, written by the periodic audit run. Nothing computes staleness, and there are no citations.

The core handles the whole migration on sight; relay each line it reports:

- **The retired audit corpus is removed** (`Retired audit corpus removed:` line). There is no mechanical conversion — turning a citation-bearing audit into a one-paragraph determination requires reading the code, the audit run's own job — so the next `/audit` writes the corpus fresh.
- **The inspection registry is swept**, with the other retired estate payloads, on the `Retired payloads removed:` line.
- **The committed source graph goes with its extractor.** The graph existed so audits could cite code by node identity and hash; with citations gone it has no reader. `graph/` and `bin/source-graph` are swept whole; the graph was mechanically derived, so nothing is lost the sources do not hold.
- **In-flight sprint contracts are brought current.** A sprint still in `sprints/` when the model changed names the retired implementation-audit term, whose clean bar no longer exists. The contract is fixed suite-owned boilerplate and the compliant end state is determined, so the core drops the retired item, renumbers the one below it, fixes the goal rule's item range, and reports the count. Archived sprints keep their old wording.
- **The `certify-all` verb is retired**; the periodic audit replaced it.

Tell the owner after the upgrade that the corpus is unaudited until the first `/audit` run.

## Sprint planning and review moved into this family

The suite used to own `/plan-sprint` and `/certify-work` as ceremonies, each reading a contribution from every family. Both are gone in that form. This family now vendors `/plan-sprint` (planning with a code-planning phase), `/converge` (the review loop; `/converge sprint <path>`, sprint certification, closes a sprint), and `/triage-issues` (which replaces `/verify-issues`). Migrate an older project as follows, and report each step.

The vendored verbs this family retired, each with the verb that replaced it. Name the replacement in the report wherever converge removed one:

| retired | replaced by |
|---|---|
| `verify-issues` | `/triage-issues` |
| `plan-sprint-code` | `/plan-sprint` |
| `converge-local`, `converge-cascade` | `/converge` |
| `certify-all` | `/audit` |

Suite-owned, removed with no consent question:

- `.claude/skills/certify-work/` and `.claude/skills/verify-issues/` are retired. The suite's old `.claude/skills/plan-sprint/` is replaced by this family's vendored copy.
- `.ok-planner/ceremony/plan-sprint.md`, `.ok-planner/ceremony/certify-work.md`, and the same two files under `.ok-plumbline/ceremony/` and `.ok-workspaces/ceremony/` are retired.

Project-owned, each a cleanup offer:

- `.claude/skills/plan-sprint-code/`, `.claude/skills/converge-local/`, and `.claude/skills/converge-cascade/` are the project's trial skills that the vendored `/plan-sprint` and `/converge` replace. Each is a `retired-verb` offer to delete it.
- A hand-written `.claude/skills/converge/`, `.claude/skills/triage-issues/`, `.claude/skills/_sprint/`, or `.claude/skills/_converge/` carries no `Materialized by` stamp. Each is a `collision` offer to replace it with the vendored copy; until the owner accepts, the core writes nothing into it.

The review estate moves from `.ok-review/` to `.ok-planner/review/`:

1. The core moves `runs/`, `config.json`, `project.md`, and `rotation.json` from `.ok-review/` into `.ok-planner/review/`, with `git mv` where git tracks them. Where both locations hold one of them, it moves neither and offers a `review-conflict` with two choices: keep the new one, or keep the old one. Where `.ok-review/` has unmerged paths, or tracked files missing from the working tree, the core moves nothing out of it and diagnose says why; the owner settles that in git and runs `/ok` again.
2. The core rewrites the values the move left stale, and nothing else: `hunt.rotation` and the `.ok-review/` entry of `exclude` in `config.json`, a `block_sources` entry naming the retired `_shared/certification-core.md`, and `.ok-review/bin/review` in `project.md`. Any other line of `project.md` that names `.ok-review` is the owner's wording, offered as a `review-wording` draft.
3. The core writes `catalog/`, the directory note, and `.ok-planner/bin/review` from the suite's payload, and removes each old suite file (`bin/review`, the directory note, a catalog file) that matches the suite's copy and carries no uncommitted change. An old suite file that differs, or carries uncommitted changes, is offered instead: `catalog-edits` for a catalog file, `review-edits` for the tool or the note; its block's `Show:` line prints the diff. Show the owner the diff with the offer. A catalog change is a suite change: an edit worth keeping goes upstream as an issue against the ok-plugins suite, or into `project.md` where it states a fact about this project.
4. Every other file under `.ok-review/` is a `review-leftover` offer: move it under `.ok-planner/review/` where that path is free, or delete it.
5. Converge again; diagnose must no longer report `.ok-review/`.

Two project rule files restate what the suite now carries. Each is detected by its exact filename and offered as a `rule-file` draft: a new project rule file holding only the project's own facts, as the drafting list above says, after which the old file is deleted.

- `.claude/rules/defect-issues.md` — now the "Defect issues" section of `.claude/rules/ok-planner-cheatsheet.md`; this family offers it as `rule-file:.claude/rules/defect-issues.md`.
- `.claude/rules/errors-reach-the-owner-frame.md` — now ok-plumbline's coding rules at `.claude/rules/plumbline-coding.md`; ok-plumbline offers it.

## The surface apparatus changed shape

The public-surface machinery used to be three artifacts kept consistent by a reconciler tool: a JSON **surface declaration**, a prose **surface guidance**, and per-kind committed **member lists** at `surface/members/<kind>` — with the audit writing a **stamped ruling** at `audits/surface/ruling.json` and `bin/surface-reconcile` comparing it all against the tree. That apparatus is retired. The public surface is now one owner-authored prose document at `.ok-planner/surface/surface.md` — the **surface intent** — plus a per-run **surface extraction** at `.ok-planner/audits/surface/extraction.json` an audit subagent writes each run.

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

Converge materializes two goal files beside the ceremony contributions: `.ok-planner/ceremony/audit-goal.md` and `.ok-planner/ceremony/document-goal.md`. Each is a vendored brief whose **path the owner hands to the native `goal` mechanism**; the audit's opening walk ends by handing the owner the one-line `/goal` paste naming it. Each carries the driving agent's role and course (as pointers to the vendored skill and the ceremony contributions, never restating them) and the checker's goal rule. Suite-owned, regenerated on every converge; nothing to migrate, nothing to consent to.

## What the administration does NOT do here

- Does not modify the project's root `.gitignore`, and writes no ignore file of its own. Whether `.ok-planner/` is tracked is the owner's decision; every file the estate carries is tracked content.
- Does not write outside the owned set: under `.ok-planner/` only `CLAUDE.md`, `hooks/session-start`, `scripts/surface-corpus`, `bin/tasks`, `bin/review`, `review/CLAUDE.md` and `review/catalog/`, a first seeding of `review/config.json` and `review/project.md`, the files the `.ok-review/` and retired-layout migrations move, `ceremony/<verb>.md` and the two goal files, and the retired payloads it removes; outside it only the cheatsheet, the vendored skill files under `.claude/skills/`, and the vendored agent profiles under `.claude/agents/`. Everything else it touches, it touches through `resolve`, on the owner's yes to one offer. `.claude/settings.json` is reachable solely through the consented `wire-hooks` path.
- One exception edits owner files without an offer: the `.ok-review/` migration's step 2 rewrites the stale values in the owner's `review/config.json` and `review/project.md` (`hunt.rotation`, the `.ok-review/` entry of `exclude`, a `block_sources` entry naming `_shared/certification-core.md`, and `.ok-review/bin/review`), and nothing else in either file.
- Does not validate the contents of existing artifacts — the periodic `/audit` run's job.
- Does not preserve local edits to `.ok-planner/CLAUDE.md`. The file is regenerated from the template on every converge; project guidance belongs in the project's own root CLAUDE.md.
