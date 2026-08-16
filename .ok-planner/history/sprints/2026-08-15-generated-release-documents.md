# Sprint: Generated release documents

## Intent

Give the documentation ceremony a generative corpus and an output
readers can find. The owner declares **document types** at
`.ok-planner/surface/documents/` — what each document is for, the
classes of public surface it covers, its target path — settled in a
**documentation walk** that runs inside the audit right after
extraction when `/document` composed the audit, and inside `/document`
against a current audit otherwise. `/document` gains a **Generate**
step: one writer per declared type, oriented by the records, verified
against the tree at the stamp, writing a self-contained document that
is placed in the tree at the type's target with a provenance stamp,
beside a `docs/CLAUDE.md` carrying the record rule. Placed documents
are records: out of context by default, staleness files nothing. The
sprint also carries the reconciliation ratified against the window
since the last close: the surface-partition retirement, the
`audit-check` retirement, and the axis rename left stale references in
six design artifacts (corpus catches up), in the README, and in
`checks/materialized-standalone` (code catches up).

No issues were promoted into this sprint; the intake was empty.

After this sprint closes, the project's own vendored copies under
`.claude/skills/` and `.ok-planner/ceremony/` are refreshed by `/ok` —
the owner's act, not this sprint's.

## Corpus deltas

All bodies are in the sidecar beside this file,
`2026-08-15-generated-release-documents-deltas/<kind>s/<slug>.md`.

### New story: ship-release-documents

body: in the sidecar

### New concept: document-type

body: in the sidecar

### New decision: documentation-walk-in-composed-audit

body: in the sidecar

### New decision: documents-generated-per-type-and-placed

body: in the sidecar

### New decision: placed-documents-are-records

body: in the sidecar

### Amend concept: documentation-corpus

body: in the sidecar — adds the documents tier and its invariants;
repairs the dead `surface-declaration` / `surface-ruling` references.

### Amend concept: surface-intent

body: in the sidecar — the "only owner walk" invariant admits the
documentation walk when `/document` composes the audit.

### Amend concept: estate

body: in the sidecar — the record discipline names the documentation
corpus and the documents the ceremony places outside the estate.

### Amend concept: experiment

body: in the sidecar — `surface-ruling` → `surface-extraction`.

### Amend concept: assumption

body: in the sidecar — `surface-ruling` → `surface-extraction`.

### Amend decision: document-composes-audit

body: in the sidecar — the walk hook and the Generate step; "ruling"
wording repaired.

### Amend decision: owner-guided-surface-partition

body: in the sidecar — the autonomous determinations follow the
documentation walk when `/document` composed the run.

### Amend decision: audit-audience-split

body: in the sidecar — the audit writes the extraction, not a ruling;
the documentation walk lands in the document types, never the intake.

### Amend decision: documentation-citations-are-product

body: in the sidecar — extraction vocabulary; generated documents are
outside the citation rule.

### Amend decision: adversarial-implementation-audits

body: in the sidecar — the run runs no checker over its own corpus.

## Work items

Each item names the artifacts it makes true. Canonical files live
under `plugins/ok/`; the vendored copies in this repository's own
`.claude/` and `.ok-planner/` are `/ok`'s to refresh.

- **Audit ceremony: composed-run hook.** In
  `plugins/ok/ceremonies/audit/SKILL.md`, the Surface step's
  description and the "What this skill does NOT do" list say: when
  `/document` invoked the run, immediately after the extractor
  returns and before Enumerate, run the documentation walk the
  owning contribution defines; an à la carte run does not. The
  interactive intent stage stops being described as the run's *only*
  owner walk. Makes true: `documentation-walk-in-composed-audit`,
  `surface-intent`.

- **ok-planner audit contribution: the hook.** In
  `plugins/ok/families/ok-planner/ceremony/audit.md`, the Surface
  section gains a sub-stage after Autonomous extraction: when the run
  was invoked by `/document`, run the documentation walk defined in
  `ceremony/document.md` against the extraction just written; the
  goal-handoff paragraph says the handoff comes after that walk in a
  composed run. Layout adds `.ok-planner/surface/documents`. Makes
  true: `documentation-walk-in-composed-audit`, `document-type`.

- **Document ceremony: walk, generate, place.** In
  `plugins/ok/ceremonies/document/SKILL.md`: the spine gains
  **Walk** after "Ensure a current audit" (run only when the audit
  was reused, against its extraction; skipped when this run invoked
  the audit, which ran it), **Generate** after Distill, and placement
  in Close-out; the presentation gains a Documents line (types
  declared, documents written, targets placed); the "What this skill
  does NOT do" list is amended — the walk is the run's one owner
  conversation, before construction; the ceremony places documents in
  the tree and does not publish outside the repository. Makes true:
  `ship-release-documents`, `documentation-walk-in-composed-audit`,
  `documents-generated-per-type-and-placed`.

- **ok-planner document contribution: types, walk, writer,
  placement.** In `plugins/ok/families/ok-planner/ceremony/document.md`:
  the document-type file shape (purpose, surface classes, target); the
  walk body — read the extraction's public side against the declared
  types, raise only deltas, starter set on an empty type set, land the
  owner's rulings as type files, file an intake issue for a type left
  unsettled and leave it out for the run, one line and no question
  when nothing changed; the Generate brief — one writer per type,
  inputs (type, extraction's public side, records for orientation,
  tree at the stamp), verify against the tree, self-contained, no
  record citations, provenance stamp first; placement — write to
  `documentation/documents/` and copy to the type's target, only
  declared targets, `docs/CLAUDE.md` text carrying the record rule and
  the pointer into `.ok-planner/documentation/`; Present and
  Boundaries updated. Layout adds `documentation/documents` and
  `surface/documents`. Makes true: `document-type`,
  `documents-generated-per-type-and-placed`,
  `placed-documents-are-records`, `documentation-corpus`.

- **Goal files.** `plugins/ok/families/ok-planner/ceremony/document-goal.md`:
  the goal rule adds a document at every declared type's target,
  provenance-stamped, and `docs/CLAUDE.md` present when any type
  targets `docs/`; the guard clause covers the walk (a goal set before
  the types are landed is too early). `audit-goal.md`: the brief notes
  that a composed run's walk precedes the hands-free portion. Makes
  true: `documentation-walk-in-composed-audit`,
  `documents-generated-per-type-and-placed`.

- **Cheatsheet.** `plugins/ok/families/ok-planner/scripts/ok-planner-cheatsheet.md`:
  the record discipline sentence covers documents placed under `docs/`
  and the root README (out of context by default, read only when
  directed there, staleness files nothing); the Documentation and
  Lifecycle passages mention the document types, the walk, and
  Generate. Makes true: `placed-documents-are-records`.

- **Estate rules.** `plugins/ok/families/ok-planner/CLAUDE.md`: the
  per-directory rules cover `surface/documents/` (owner intent,
  walk-maintained) and `documentation/documents/` (records), and the
  audit description no longer says "no downstream owner walk beyond
  the interactive stage" without the composed-run exception. Makes
  true: `document-type`, `documentation-corpus`.

- **Ceremony-surfaces check.** `checks/ceremony-surfaces`: the
  `PHASES` map for `document` and `audit` matches the spines as they
  stand after this sprint (new `Walk` and `Generate` headings
  admitted; retired names dropped). Makes true:
  `suite-owned-ceremonies` (kept true).

- **Materialized-standalone check.** `checks/materialized-standalone`:
  drop the three deleted payload entries (`audit-check`,
  `document-check`, `surface-reconcile`) so `checks/run` passes.
  Makes true: `whole-file-ownership`, `integration-contract` (kept
  true). Reconciliation item.

- **README.** `README.md`: the audit and surface passages describe
  the current model — `implementation:` (`supported` | `unsupported`)
  beside `text:`, surface intent + extraction, no checker — and the
  documentation passage names the document types and placed
  documents. Reconciliation item plus this sprint's outcome. Makes
  true: `adversarial-implementation-audits`,
  `owner-guided-surface-partition`, `ship-release-documents`.

- **Annotations.** Every load-bearing site touched above carries the
  `@decision:` / `@concept:` / `@story:` annotation for the artifact
  it enforces, per `code-cites-design`.

## How to execute this sprint

This sprint is self-sufficient. Whoever executes it — an inline
working session, an agent this file is handed to via the native
`goal` mechanism, or an orchestrator that does its own planning —
proceeds the same way.

1. Read the sprint whole first — intent, deltas, work items,
   completion contract — before touching anything. Do not go looking
   for context behind it (not in the issue intake under
   `.ok-planner/issues/`, not in `history/`). The sprint is
   self-sufficient by construction; a genuine gap is raised with the
   owner, never filled by inference.

2. Stage the work into a task list. The items above are a flat,
   unordered list; group them by theme, file surface, or dependency,
   order the groups so nothing is built on something not yet there,
   and build the list in your own working state — the harness's task
   tracking where available, one entry per stage; an orchestrator
   uses its own graph. Seed the closing entries up front — finish
   the completion report, run `/certify-work` with this sprint's
   path as its argument, clear this task list the moment
   `/certify-work` completes, walk the presentation, offer
   archive-and-commit — so the ceremony is a standing unchecked
   item from the first minute, not a memory to retain past a long
   run. You built this list and you close it: when `/certify-work`
   returns, complete or remove every entry still standing —
   including the closing entries themselves — before you put
   anything in front of the owner, so no stale list survives into
   the presentation or past the run. Staging is never rewritten
   into a plan document: this sprint is the whole brief.

3. Apply each corpus delta as part of the work that realizes it —
   copy the final-form body into `.ok-planner/design/` verbatim
   (from the sidecar where the heading points there), or delete the
   file for a retirement. A delta no work item implements (a
   clarification, a retirement) is applied on its own.

4. Build stage by stage. Every new or amended story whose substance
   is implemented in code is exercised end-to-end by a test in the
   project's ordinary suites, carrying the `@story:` annotation for
   navigation — that annotation is also how the periodic audit finds
   the test later. No test ever checks the existence of static text,
   code, or prose: a commitment realized in prose carries no test.
   Write the tests with the work, not at the end.

5. Completeness is the floor. Never stub, defer, narrow, no-op, or
   leave a `TODO` in place of a promised outcome. A capability the
   deltas or work items promise is delivered in full, or the blocker
   that prevents it is surfaced — never silently dropped.

6. Never destroy uncommitted work. Stage progress as each stage
   finishes (`git add -A`) so a stray revert cannot reach it. Do not
   run `git checkout`/`restore`/`reset`/`stash`/`clean` on your own
   initiative; fix a bad edit forward by editing again.

7. Work unsupervised to a defensible done — no pausing for approval,
   confirmation, or progress checks. Stop only on a genuine blocker:
   a credential or access that cannot be obtained, a step literally
   impossible in the current state, a destructive/irreversible
   action not clearly authorized — or the closing `/certify-work`
   step being unrunnable for you (e.g. its subagent dispatches are
   unavailable): surface that and stop; never skip the ceremony and
   call the work done. Ambiguity is not a blocker — pick the most
   plausible reading and continue, surfacing the choice at the end.
   (An orchestrator that supervises its own executors folds this into
   its own control.)

8. Keep the completion report current. Beside this sprint file lives
   its report — same filename with `-completion` before the
   extension — and you write it as you go: as each stage lands,
   record what was done, every divergence, and every call you made
   where the sprint was silent. It is the durable record the closing
   ceremony finishes and walks with the owner, the artifact a goal
   checker requires, and it is archived together with this sprint.
   It is a record of this execution, never a plan document.

9. Close by running `/certify-work` with this sprint's path as its
   argument — the argument is what puts the sprint in the gate's
   scope; the gate never adopts one on its own. It brings the work into
   alignment with this sprint and discharges the completion contract
   below at the change's own scope, across every estate this project
   has: the project's own test suites over the touched work,
   change-scoped corpus checks over the touched artifacts and
   annotations, code review over the diff —
   all producers feeding a no-discretion review-fix loop (a fixer
   fixes everything a reasonable owner would wave through; an
   architect adversarially checks its kickbacks, fixing the refuted
   and promoting only genuine intent forks to the issue intake),
   and the outcomes and divergences are presented to the owner.
   (Whether the corpus's claims still hold is the periodic `/audit`
   run, on the owner's cadence, never this close.) `/certify-work`
   ends the run. It writes its composed presentation into the
   completion report, finishing the record kept in step 8. It walks
   that presentation with the owner. It offers the close-out. The run
   stops there.

**After the run stops.** The owner archives this sprint. The owner
commits the work. The run does neither on its own initiative. It
offers both at the end of the presentation and stops. Until the owner
answers, this file stays at its `sprints/` path. When the owner
answers yes, the run moves this file, its completion report, its
delta sidecar, and the issue files it resolved to `history/`. Then it
commits the work. Then it stamps the archived sprint with the closing
commit — `closed: <sha>` in the frontmatter, one small follow-on
commit. The next planning ceremony reads that stamp to detect work
done out of band. The words "finish the sprint" are not a yes. Nor is
"follow the boilerplate". Both ask the run for the presentation.

## Completion contract

The work is not done until all of the following hold, each
verifiable from the repository as it stands:

1. The design corpus matches every delta above (applied verbatim,
   from the sidecar where a heading points there).
2. The project's own test suites pass, and every new or touched
   story implemented in code is exercised end-to-end by a test the
   suites run.
3. The completion report beside this sprint (same filename with
   `-completion`) is finished: it records the work done and the
   divergences, and carries `/certify-work`'s presentation — the
   review-fix loop run last and come back clean, every finding
   fixed or promoted-and-verified.

**The goal rule, for any checker verifying this contract.** The goal
is met when items 1–3 all verify against the repository. Read the
repository as it stands to decide. Never decide from the session
transcript. An earlier session may have done this work, and a term
the transcript does not show may still hold on disk. That state
IS the goal met — do not require more: walking the presentation,
archiving, committing, and the `closed:` stamp all FOLLOW
completion, and a pending archive-and-commit offer is evidence the
goal is met, never that work remains. Where this sprint file sits is
no term of the rule: `sprints/` and `.ok-planner/history/sprints/`
satisfy it alike, and a sprint already archived bearing a `closed:`
stamp is terminal — stop checking, whatever else seems unfinished. A
missing completion report means NOT done, however green the rest
looks. Distinct from every state above: a run parked at the
review-fix loop's cycle cap awaiting the owner's direction has not
met the goal — a legal in-flight state, not done, not failed, and
never grounds for the run to take either cap step itself. Nothing
else counts either way.

**Handing this sprint to the native `goal` mechanism.** The condition
names this file and refers the checker to the rule above:

    /goal .ok-planner/sprints/2026-08-15-generated-release-documents.md — see the goal
    resolution criteria in that file's completion contract; read the
    file from disk and apply them
