---
closed: 5f64ea5
---

# Sprint: The /document ceremony

## Intent

Add `/document` to the suite: a fourth suite ceremony that produces a
project's release documentation as a measured assessment — audit first,
then a surface catalog driven by an owner declaration, cold-synthesized
assumptions verified up an affirmative-only warrant ladder, and a
commit-stamped documentation corpus in the estate beside the audits.
The design was settled in owner discussion on 2026-08-09 (sketch:
`docs-as-assessment`, archived by this sprint's work). No issues were
promoted into this sprint; the intake is empty.

## Corpus deltas

### New concept: assessment

body: in the sidecar

### New concept: assumption

body: in the sidecar

### New concept: trap

body: in the sidecar

### New concept: experiment

body: in the sidecar

### New concept: surface-declaration

body: in the sidecar

### New concept: documentation-corpus

body: in the sidecar

### New story: document-a-release

body: in the sidecar

### New story: answer-absence-from-catalogs

body: in the sidecar

### New decision: affirmative-warrant-ladder

body: in the sidecar

### New decision: cold-boxed-synthesis

body: in the sidecar

### New decision: full-reassessment-per-release

body: in the sidecar

### New decision: document-composes-audit

body: in the sidecar

### New decision: documentation-citations-are-product

body: in the sidecar

## Work items

Each item names the stories/decisions it makes true and describes the
outcome. Real dependencies are stated inline; there is no order beyond
them.

- **The `/document` ceremony body** at
  `plugins/ok/ceremonies/document/SKILL.md`. The orchestrator: declares
  the explicit-slash-command activation guard
  (decision:slash-only-activation), resolves estates from the
  filesystem at invocation like the other three ceremonies
  (decision:suite-owned-ceremonies), invokes `/audit` at the release
  commit as phase 0 and applies the delivery criterion
  (decision:document-composes-audit), then runs the phases the settled
  design gives it — mechanical projection/enumeration from the surface
  declaration, cold boxed synthesis with the fixed-template brief
  (decision:cold-boxed-synthesis), batched warm assessment up the
  warrant ladder (decision:affirmative-warrant-ladder), distillation
  (traps, defects filed as intake issues, candidate-test emission for
  the sprint-loop promotion path), and the mechanical gates (catalog
  one-to-one with enumerated populations, citations resolving at the
  stamp, warrants present, undispatched items recorded unverified,
  synthesizer transcript scan). Everything is re-derived per release
  (decision:full-reassessment-per-release), and the produced corpus is
  stamped and snapshot-semantic
  (decision:documentation-citations-are-product). Reads each family's
  `ceremony/document.md` surface per phase; family knowledge lives
  there, never in the body. Makes true: story:document-a-release,
  story:answer-absence-from-catalogs.

- **ok-planner's ceremony surface** at
  `plugins/ok/families/ok-planner/ceremony/document.md`. The family's
  contributions: the documentation corpus's home in the estate
  (`.ok-planner/documentation/`, beside `audits/`, with the record
  discipline of a snapshot), the surface declaration's committed home
  in the estate, the record shapes (catalog row, assessment with
  warrant and unverified boundary, trap with evidence set and
  three-state repro, archived experiment), the economy rule's
  attestation requirement, defect and story-fitness issue filing into
  the intake, and the promotion path for candidate tests (owner act via
  intake and sprint, never the ceremony's).

- **ok-plumbline's ceremony surface** at
  `plugins/ok/families/ok-plumbline/ceremony/document.md`. Contributes
  the story↔test map to the projection phase, read from `@story:`
  annotations and scenario names — the linkage set the warrant ladder's
  first rung climbs.

- **ok-workspaces' ceremony surface** at
  `plugins/ok/families/ok-workspaces/ceremony/document.md`. Every
  family exposes one surface per ceremony verb (the conformance check
  enforces this); this family has no documentation-specific knowledge
  to contribute, and its surface says so in the conventional
  minimal shape.

- **The suite administration layer knows four ceremonies.**
  `plugins/ok/admin/ADMINISTRATION.md` (currently "the suite's three
  ceremony verbs", the collision-rule name list, the per-family surface
  enumeration) and `plugins/ok/admin/converge` carry `document` as a
  fourth ceremony, so `/ok` vendors the body into consumer projects and
  each family's converge materializes its `document.md` surface into
  the estate.

- **The ceremony conformance check covers `/document`.**
  `checks/ceremony-surfaces` gains the `document` verb with its phase
  tuple matching the ceremony body's spine, so the payload defect the
  runtime would report is caught before it ships. Depends on the
  ceremony body existing (its phase names are the check's expected
  set).

- **The integration contract and README enumerate four ceremonies.**
  `docs/integration-contract.md` (the per-verb surface list and any
  "three ceremonies" phrasing) and `README.md` (the ceremony-surface
  description) name `document` alongside the other three.

- **The ok-planner cheatsheet and estate `CLAUDE.md` teach the new
  corpus.** The family's canonical cheatsheet payload and estate
  `CLAUDE.md` (sources under `plugins/ok/families/ok-planner/`) gain
  the documentation corpus: where it lives, its snapshot semantics and
  out-of-context-by-default record discipline, and `/document` in the
  lifecycle summary.

- **A vendored documentation-corpus checker.** A checker in the
  ok-planner family's vendored scripts (beside the audit checker's
  pattern) validates a produced documentation corpus mechanically:
  release stamp present on every record, every held claim carrying an
  affirmative warrant, trap records carrying evidence sets, catalog
  counts agreeing with enumerated populations, unverified remainders
  present where climbing stopped, and citations resolving at the
  stamped commit. Makes true: story:answer-absence-from-catalogs
  (the completeness contract is only real if checkable).

- **The suite test covers the fourth ceremony.**
  `plugins/ok/test/administration.sh` (and any check the `checks/`
  runner drives that enumerates ceremony verbs) passes with `document`
  present, in the shape the existing tests use. Depends on the ceremony
  body and surfaces existing.

- **Archive the sketch.** Move
  `.ok-planner/sketches/2026-08-09-docs-as-assessment-sketch.md` to
  `.ok-planner/history/sketches/` — the idea is taken up by this
  sprint, which supersedes it as the source of truth.

- **Catalog TOCs list the new slugs.** Applying the deltas refreshes
  `.ok-planner/design/{concepts,stories,decisions}.md` so each TOC
  lists exactly its collection's live slugs, new artifacts included.

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
   path as its argument, clear this task list just before the
   presentation (complete or remove every remaining entry, so a
   stale list does not linger past the run), walk the presentation,
   offer archive-and-commit — so the ceremony is a
   standing unchecked item from the first minute, not a memory to
   retain past a long run. Staging is never rewritten into a plan
   document: this sprint is the whole brief.

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
   run, on the owner's cadence, never this close.) The goal is to
   finish the work: this file stays in `sprints/` through the
   presentation (so a stop
   condition keyed to its path can verify completion against it),
   and `/certify-work` ends the run as the ceremony: it writes its
   composed presentation into the completion report (finishing the
   record kept in step 8), walks it with the owner, and offers the
   close-out — archiving this sprint together with its completion
   report and the issue files it resolved to `history/`, and
   committing the work — performed only on the owner's word. The
   close-out then stamps the archived sprint's frontmatter with
   the closing commit (`closed: <sha>`, one small follow-on
   commit): the baseline the next planning ceremony uses to
   detect work done out of band.

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
is met in exactly two ways: this sprint file has moved to
`.ok-planner/history/sprints/` bearing a `closed:` stamp — the owner
accepted and closed the work; terminal, stop checking — or this file
is still at its `sprints/` path and items 1–3 all verify against the
repository. A missing completion report means NOT done, however
green the rest looks; an archived, stamped sprint means DONE,
whatever else seems unfinished. A run parked at the review-fix
loop's cycle cap awaiting the owner's direction is a legal in-flight
state — not done, not failed, and never grounds for the run to take
either cap step itself. Nothing else counts either way.
