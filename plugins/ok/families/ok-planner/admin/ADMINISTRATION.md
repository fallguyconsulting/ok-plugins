# ok-planner administration

The judgment side of this family's administration — everything the
deterministic core beside this document (`admin/converge`) cannot
encode. The suite's front door (`/ok`) reads this document when it
administers the family; nothing here is improvised by the
administrator, and nothing here is a user-facing verb.

The governing rule is ownership: converge freely overwrites what the
suite owns — version-stamped, regenerable files — and migration moves
retired-layout files into the shape the current skills expect, because
the skills will not work against the old shape. Anything not
suite-owned reaches the owner as a consent question.

## The core's modes

```
bash admin/converge            # converge: materialize/repair the suite-owned layer
bash admin/converge diagnose   # read-only drift report; non-zero on findings
bash admin/converge wire-hooks # consented settings transcription — see below
```

Converge materializes: the `.ok-planner/` layout (including the
`issues/` intake and, where `design/` exists, the `audits/` corpus
buckets), `.ok-planner/CLAUDE.md` and the cheatsheet from their
templates, the session-start hook into `.ok-planner/hooks/`, the
helper scripts (`scripts/surface-corpus`) and the vendored skills
under `.claude/skills/` — removing retired payloads (including the
merged `true-up` verb earlier suite versions vendored, any
`bin/audit-check` an earlier release materialized, any
`bin/document-check` an earlier release materialized, any
`bin/surface-reconcile` an earlier release materialized, and the
whole retired surface apparatus described below).
Idempotent: a compliant project is a silent no-op.

## Wire the hook — consent, then transcription

The session-start hook executes through a `SessionStart` entry in
`.claude/settings.json` carrying the `startup|clear|compact` matcher
(never firing on resume) — owner-declared configuration, written
**only** as transcription of the owner's explicit yes, by the core's
`wire-hooks` mode. Diagnose reports a missing or drifted entry as a
`WIRING NEEDED` block carrying the exact entry and the exact consent
command. Present the block, ask, and on yes run the command it names.
Declined means declined — record it in the report and write nothing.

## Identify overlapping project context

Per the integration contract, surface preexisting project content that
overlaps this family's territory — planning, design-record, and
decision-log material the suite would now govern — before converging,
and never convert it silently. Scan, at the project root and one level
into the conventional doc locations (`docs/`, `doc/`, `design/`,
`.claude/rules/`):

- planning and record directories beside `.ok-planner/` — `plans/`,
  `specs/`, `proposals/`, `rfcs/`, `adr/`, `decisions/`, `sprints/`,
  `backlog*/`, `design/` at the repo root;
- design or decision documents carrying corpus-shaped content — an
  architecture-decision log, a concepts/glossary document, a
  requirements or user-story file;
- rules files in `.claude/rules/` other than this family's cheatsheet
  that state planning or design-doc conventions.

Tell suite-materialized from hand-written by the stamp: everything the
suite owns carries a `Materialized by ok-planner v…` line (and lives
under `.ok-planner/` or is the cheatsheet). No stamp means it is the
owner's, and the suite's own retired layouts are handled by the
migration section below, not here.

For each hit, **propose a conversion plan for the owner's consent**,
naming the three outcomes and a recommendation:

- **fold** — the content is corpus material: carry it into
  `.ok-planner/design/` as concept / story / decision artifacts (the
  owner's call, executed by `/discover-design` on an empty corpus or
  by a `/plan-sprint` delta on a populated one — never by this
  administration, which does not author corpus content);
- **keep alongside** — the content is specific design or reference
  material the corpus deliberately does not hold (interface grammars,
  schemas, runbooks): leave it exactly where it is, and record that it
  was seen and kept;
- **retire** — the content is superseded: the owner moves it to their
  own archive; the administration never deletes it.

Never convert, edit, move, or delete such content silently — and never
skip surfacing it. Report every hit and its outcome in the
administration report, including the ones the owner declined to act on.

## Check issue-intake integrity

Every file under `.ok-planner/issues/` must carry frontmatter with
`issue` (the stable slug), a known `kind` (`audit` | `discover` |
`sprint` | `human`), `category`, a known `status` (`open` | `verified`
| `answered` | `promoted` | `retired`), and `opened`; a
`status: promoted` file must carry a `sprint:` field naming a file that
exists under `sprints/` or `history/sprints/` — a promotion receipt
pointing at nothing is a finding. An `answered` or `retired` file still
sitting in `issues/` (closed states live in `history/issues/`) is a
finding too. A malformed file is a finding to report with its path for
the human to repair — issue files are not suite-owned content; the
administration never edits them.

## Layout migration (only when the core reports one)

Run the migration for whatever `PRE-MIGRATION LAYOUT PRESENT` names —
no consent prompt: driving the administration is itself the
authorization to migrate the suite's own retired layouts. The current
skills key on the current layout and will misbehave against a retired
one; leaving the estate half-migrated is worse than migrating it. The
migrations below are mechanical: files move between directories,
contents are not rewritten, and `history/` preserves the record.
Report what was done.

The one exception is a genuine collision between old and new
locations — that is a real conflict, not a consent question, and the
first migration below stops for the owner to resolve it.

### `backlogs/` (or `specs/`) → `sprints/` (the backlog → sprint rename)

The artifact the planning ceremony produces is now the **sprint**, and
it lives in `sprints/`. A recent layout called it a "sprint backlog"
(in `backlogs/`); an older one called it a "sprint spec" (in `specs/`).
Either migrates the same mechanical way — contents untouched, no
rewriting of file bodies:

1. `git mv` (or `mv`) every file from `.ok-planner/backlogs/` into
   `.ok-planner/sprints/`, and from `.ok-planner/history/backlogs/`
   into `.ok-planner/history/sprints/` — and likewise from any `specs/`
   and `history/specs/` — merging with whatever is already there. Then
   remove the emptied directories.
2. Leave the moved files' contents alone. An archived record that calls
   itself a backlog or a spec is a record of what it was; rewriting
   history records is not the administration's business. Live sprints
   the owner still intends to execute may be reheaded `# Sprint: …` if
   they ask — offer, don't insist.
3. Do not touch a legacy `issues.jsonl` here. Its rows stay exactly as
   written — legacy `promote` rows carrying a `backlog` field (and
   older `resolve` rows with a `spec` field) fold as terminal, reading
   the legacy field as the sprint reference. Its conversion is the
   final migration's business, below.
4. Re-run the core; it must no longer report `backlogs`,
   `history/backlogs`, `specs`, or `history/specs`.

If a project has both `backlogs/` and `sprints/` (or `specs/` and
`sprints/`) with overlapping filenames, stop and put the collision to
the owner — never overwrite.

### Pre-4.0 kinds

Read `{{ISSUE-FILE-FORMAT}}` in the family's
`skills/_shared/artifact-definitions.md` first, then:

1. **`design/tensions/` → issue files.** For each live tension file
   (skip `_resolved/` and `_rejected/` — settled history): write an
   issue file to `.ok-planner/issues/` per `{{ISSUE-FILE-FORMAT}}` with
   `issue` = the tension slug, `kind: "human"`, `category` from the
   tension's frontmatter, `artifacts` from its `affects:` list,
   `status: open`, the title from its title, `## Problem` condensed
   from its "What is muddy" and "Why it matters" sections,
   `## Candidates` from its "Resolution candidates", filename timestamp
   via `date -u +%Y-%m-%d-%H%M%S` (skip slugs already present in
   `issues/`). Then move the whole `design/tensions/` tree (live files
   and `_resolved/`/`_rejected/`) to `history/tensions/`.
2. **`plans/`, `coverage/`, `design/review-notes*.md` → archive.**
   These artifact kinds have no live consumers. (`sketches/` is not
   among them — sketches remain a live artifact kind, written by
   `/sketch` and archived per-file only when an idea has been taken up
   or abandoned.) Move each retired kind to its same-named folder under
   `history/` (`history/plans/`, `history/coverage/`; loose
   `design/review-notes*.md` files move to `history/` directly),
   merging with anything already archived there. Nothing is deleted:
   `history/` preserves the record. This is the general completion
   rule, not a migration special case — whenever an artifact kind is
   retired or an artifact completes, it moves to its same-named folder
   under `history/`.
3. Re-run the core. It must no longer report a retired layout.

### `decision-proof-sections` — the retired proof-mandate model

Decisions carried a mandatory `## Proof` section under the retired
proof-mandate model; verification of a decision is now its
implementation audit under `.ok-planner/audits/`, and a `## Proof`
section on a decision is a compliance violation. When the core reports
`decision-proof-sections`:

1. For each live decision under `.ok-planner/design/decisions/`
   carrying a `## Proof` section: delete the section — heading and
   body. Do not rewrite anything else in the file; the section's
   content survives in git history, and whatever enforcement it named
   remains discoverable through the code's `@decision:` annotations,
   which stay untouched.
2. This is a form migration, not a commitment change: the decision's
   Choice, Rationale, and Alternatives are the commitment, and none of
   them move. The next periodic audit re-derives the verification the
   section used to gesture at — as a determination about a named
   commit rather than a sentence of intent.
3. Any test files the old proof sections pointed at (files annotated
   `@decision:<slug>`) are left exactly where they are: they remain
   ordinary tests, still valuable, just no longer corpus-mandated.
   Never delete or rename them in this migration.
4. Re-run the core; it must no longer report `decision-proof-sections`.

### Legacy `issues.jsonl` → the file-per-issue intake

The conversion is `/verify-issues`' job, not the administration's —
expanding rows into files is mechanical, but making them ruling-ready
(the verification narratives) is agentic work that belongs with the
verifier. When the core reports `issues.jsonl`, tell the owner to run
`/verify-issues` in the project: it folds the log, writes one issue
file per open id, archives the log to `history/issues.jsonl`, and
verifies everything unverified. The administration itself never runs
work-driving verbs.

### Falsifier and story-proof elimination (automatic — the core does it on converge)

Falsifiers and story proof sections are retired corpus-wide: stories
affirm in the positive — a story is complete if the user can do what
the story says — and carry no verification section of any kind.
Verification is the periodic implementation audit, which reads the project's
ordinary end-to-end tests for whatever is implemented in code and the
relevant prose for the rest. Unlike the migrations above, this one
needs no procedure from this document: the converge core eliminates
the retired material on sight in every project it upgrades —
`## Falsifier` and `## Proof` sections stripped from
`design/stories/*.md`, the `falsifier` concept file and its TOC line
removed — touching nothing outside those sections, and reports what
it stripped on its `Retired story sections eliminated:` line. It also
removes the retired `prove` vendored skill, `bin/proof-timings`, and
the machine-local `proof-timings.json`. Nothing to consent to and
nothing to resolve; if the line appears, relay it in the
administration report.

## The retired corpus view

The corpus view is gone: the local page, the service that served it,
the `browse` up/down helper, and the per-release frontend build the
converge core used to place. A project converged by an earlier suite
version carries the leftovers, and the core sweeps all of them on
sight — the vendored `browse` skill, `bin/corpus-view`, `bin/browse`,
the placed `browser/` build, the machine-local `run/` state the helper
recorded, and the estate's own `.gitignore`, whose only entries covered
those two directories. Every removal is suite-owned, so none of it is
a consent question, and each swept path is named on the core's
`Retired payloads removed:` line. Relay that line in the
administration report.

## The audit model changed shape

Audits used to be adversarial determinations (`satisfied` | `violated`)
carrying an artifact hash and content-anchored citations, re-derived by
certification at every close and invalidated by a two-layer staleness
computation. They are now one-paragraph verdicts on two independent
axes — `implementation:` (`supported` | `unsupported`) and `text:`
(`compliant` | `noncompliant`) — about a **named commit**, written by
the periodic audit run and never by a close. Nothing computes
staleness, and there are no citations.

The core handles the whole migration on sight; there is nothing to
consent to and nothing to resolve. Relay each line it reports:

- **The retired audit corpus is removed.** Every audit in the old shape
  goes, and the count is reported on the `Retired audit corpus
  removed:` line. There is no mechanical conversion — turning a
  citation-bearing multi-section audit into a one-paragraph
  determination requires reading the code, which is the audit run's own
  job — so the next `/audit` writes the corpus fresh. This is what makes
  the first run clean: without it, every surviving file reports
  malformed, which is a wall of findings about files nobody is meant to
  keep.
- **The inspection registry is swept**, with the other retired estate
  payloads on the `Retired payloads removed:` line. The change
  inspector that wrote it is gone.
- **The committed source graph goes with its extractor.** The graph
  existed so audits could cite code by node identity and content hash;
  with citations gone it has no reader, so `graph/` and
  `bin/source-graph` are swept whole and nothing replaces them. It was
  mechanically derived from the project's own sources and carried no
  judgment, so nothing is lost that the sources do not still hold.
- **In-flight sprint contracts are brought current.** A sprint still in
  `sprints/` when the model changed names the retired
  implementation-audit term, whose clean bar no longer exists — left
  alone it holds its executor to something nothing can satisfy. The
  contract is fixed boilerplate the suite owns and the compliant end
  state is determined, so the core drops the retired item, renumbers
  the one below it, and fixes the goal rule's item range, reporting the
  count. Archived sprints under `history/` are records and keep their
  old wording.
- **The `certify-all` verb is retired** from the vendored surface; the
  periodic audit replaced it.

Two things the owner should know after the upgrade. Until the first
`/audit` run, the corpus is unaudited and the checker says so — one
`audit-missing` finding per live story and decision, which is the
honest state rather than a defect. And `/certify-work` no longer audits
at all, so a close after the upgrade is a smaller, faster gate: tests,
sprint alignment, and code review.

## The surface apparatus changed shape

The public-surface machinery used to be three artifacts kept
consistent by a reconciler tool: a JSON **surface declaration**
naming the surface kinds, a prose **surface guidance** classifying
each extracted element public or private, and per-kind committed
**member lists** at `surface/members/<kind>` derived by an agentic
walk at the audit run's opening — with the audit writing a
**stamped ruling** at `audits/surface/ruling.json` and the
`bin/surface-reconcile` tool comparing it all against the tree. That
apparatus is retired. The public surface is now one owner-authored
prose document at `.ok-planner/surface/surface.md` (the **surface
intent** per `concept:surface-intent`) plus a per-run **surface
extraction** at `.ok-planner/audits/surface/extraction.json` an audit
subagent writes each run (per `concept:surface-extraction`).

The core handles the whole migration on sight; there is nothing to
consent to and nothing to resolve. On any converge over a legacy
estate, the sweep removes:

- `.ok-planner/surface/surface.json` — the retired declaration.
- `.ok-planner/surface/guidance.md` — the retired guidance.
- `.ok-planner/surface/members/` — every per-kind committed member
  list.
- `.ok-planner/audits/surface/ruling.json` — the retired ruling.
- `.ok-planner/audits/surface/extraction.json` — any cached
  extraction from an earlier release; the next `/audit` writes a
  fresh one.
- `.ok-planner/bin/surface-reconcile` — the retired tool.

The `.ok-planner/surface/` directory itself is not removed — the new
intent document lives there. Where the intent document is missing
after the sweep, converge prints an advisory line: the next `/audit`
run will file one intake issue asking the owner to author it, and
the story track will treat every element as internal for the run
until the intent lands. This is the migration that makes the first
audit run after the upgrade clean.

## The documentation run runs no validator over its own corpus

The documentation ceremony used to end its spine with a Check stage
that ran `.ok-planner/bin/document-check` and refused the run's
completion on a non-zero exit. That stage is retired, and so is the
tool. The ceremony's orchestrator now constructs the corpus, presents,
and stamps the closing commit; nothing sits in its hand with a
pass/fail exit. Where the produced corpus is malformed, the next
`/document` run rewrites it whole from a fresh read of the audit's
records — the documentation corpus is a full-reassessment-per-release
artifact (see `.ok-planner/design/decisions/full-reassessment-per-release.md`),
so drift self-corrects the same way audit drift does.

The core handles the whole migration on sight: any
`.ok-planner/bin/document-check` an earlier release materialized is
removed on converge, and the removal is reported on a
`Retired binary removed:` line. There is nothing to consent to and
nothing to resolve.

## The ceremony goal files

Converge materializes two goal files beside the ceremony
contributions: `.ok-planner/ceremony/audit-goal.md` and
`.ok-planner/ceremony/document-goal.md`. Each is a vendored brief
whose **path is what the owner hands to the native `goal`
mechanism** — the audit's opening walk ends by handing the owner the
one-line `/goal` paste naming it — so a long run is driven to
completion hands-free after its one interactive moment. Each carries
the driving agent's role and course (as pointers to the vendored
skill and the ceremony contributions, never restating them) and the
checker's goal rule. They are suite-owned and regenerated on every
converge like every other ceremony file; there is nothing to migrate
and nothing to consent to.

## What the administration does NOT do here

- Does not modify the project's root `.gitignore`, and writes no ignore
  file of its own. Whether `.ok-planner/` as a whole is tracked in git
  is the project owner's decision; every file the estate carries is
  tracked content.
- Does not write outside the owned set: under `.ok-planner/` only
  `CLAUDE.md`, `hooks/session-start`,
  `scripts/surface-corpus`,
  `ceremony/<verb>.md` and the two ceremony goal files,
  the retired payloads it
  removes (including any `bin/audit-check`, `bin/document-check`, or
  `bin/surface-reconcile` an earlier release materialized, and the
  retired surface apparatus described above), and (migration
  only) new issue files written from retired tensions; outside it only
  the cheatsheet and the vendored skill files under `.claude/skills/`.
  `.claude/settings.json` is reachable solely through the consented
  `wire-hooks` path.
- Does not validate the contents of existing artifacts — that is the
  periodic `/audit` run's job, which records a compliance determination
  per artifact beside its support one.
- Does not preserve local edits to `.ok-planner/CLAUDE.md`. The file is
  not a user-customization surface — it is regenerated from the
  template on every converge. Project-specific guidance belongs in the
  project's own root `CLAUDE.md`.
