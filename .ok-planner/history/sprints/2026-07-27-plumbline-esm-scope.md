---
closed: ed9d8b0c572332edef3184794e26f3d3d3205aa2
---

# Sprint: Plumbline converges under ESM roots

## Intent

Make ok-plumbline's materialized layer work in consumer projects whose root
`package.json` declares `"type": "module"`. Today the vendored CommonJS
binary and edit hook inherit the consumer's ambient module context and fail
there, aborting converge at its own sanity check. The fix is the scoped
module marker the owner's ruling names. One issue is promoted into this
sprint: `plumbline-vendored-cjs-esm-project`.

## Corpus deltas

None. The commitment this work restores is already carried by
`concept:integration-contract` (nothing in any family may assume a specific
consumer project) and `concept:materialized-artifact` (a vendored executable
is proven to run at materialization time); the corpus needs no change.

## Work items

- **Scoped module marker in the plumbline estate** (bears on
  `concept:materialized-artifact`, `concept:integration-contract`). The
  ok-plumbline converge core materializes `.ok-plumbline/package.json` with
  content `{"type":"commonjs"}` as part of the suite-owned layer, written
  before the converge sanity check (`node .ok-plumbline/bin/plumbline
  version`), so that converge — and the vendored binary and
  `hooks/post-edit.js` hook at fire time — succeed in a consumer project
  whose root `package.json` declares `"type": "module"`. Diagnose reports
  the file's absence or drift as a finding with converge as the remedy.
  `admin/ADMINISTRATION.md` lists the file among the suite-owned,
  overwritten-on-converge estate content. The family's test harness
  (`plugins/ok/families/ok-plumbline/test/run.sh`) exercises the case
  deterministically: under a fixture root declaring `"type": "module"`, the
  materialized binary runs and the hook loads; without the marker the same
  fixture demonstrably fails. No paths change: the binary stays
  extensionless at `.ok-plumbline/bin/plumbline`, the hook stays
  `hooks/post-edit.js` — already-converged consumers gain the marker on
  their next converge with no migration.

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

2. Stage the work. The items above are a flat, unordered list; group
   them by theme, file surface, or dependency and order the groups so
   nothing is built on something not yet there. Staging lives in the
   executor's working state — a task list, an orchestrator's graph.
   It is never rewritten into a plan document: this sprint is the
   whole brief.

3. Apply each corpus delta as part of the work that realizes it —
   copy the final-form body into `.ok-planner/design/` verbatim, or
   delete the file for a retirement. A delta no work item implements
   (a clarification, a retirement) is applied on its own.

4. Build stage by stage. Every new or amended story gets its proof: a
   deterministic integration test (or demo) present, carrying its
   `@story:` annotation, and able to actually fail under the story's
   falsifier. Write the proof with the work, not at the end. Decisions
   carry no proofs — a decision's verification is the implementation
   audit certification writes.

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
   impossible in the current state, or a destructive/irreversible
   action not clearly authorized. Ambiguity is not a blocker — pick
   the most plausible reading and continue, surfacing the choice at
   the end. (An orchestrator that supervises its own executors folds
   this into its own control.)

8. Close by running `/certify-work`. It brings the work into
   alignment with this sprint and discharges the completion contract
   below at the change's own scope: `/prove` over the touched
   stories and decisions, change-scoped corpus checks over the
   touched artifacts and annotations, code review over the diff —
   all producers feeding a no-discretion review-fix loop (a fixer
   fixes everything a reasonable owner would wave through; an
   architect adversarially checks its kickbacks, fixing the refuted
   and promoting only genuine intent forks to the issue intake),
   and the outcomes and divergences are presented to the owner.
   (Whole-corpus certification is `/certify-all`, run on the owner's
   cadence, not per close.) The goal is to finish the work: this
   file stays in `sprints/` through the presentation (so a stop
   condition keyed to its path can verify completion against it),
   and `/certify-work` ends by offering the close-out — archiving
   this sprint and the issue files it resolved to `history/`, and
   committing the work — performed only on the owner's word. The
   close-out then stamps the archived sprint's frontmatter with
   the closing commit (`closed: <sha>`, one small follow-on
   commit): the baseline the next planning ceremony uses to
   detect work done out of band.

## Completion contract

The work is not done until all of the following hold:

1. The design corpus matches every delta above (applied verbatim).
2. `/prove` returns clean over all new and touched stories: every
   registered proof present, passing, and runnable.
3. The implementation-audit corpus is current for everything the
   change touched or made stale, with any standing violation linked
   to an intake issue.
4. `/certify-work`'s review-fix loop has been run last and come
   back clean: every finding fixed, with only architect-confirmed
   intent forks promoted to `.ok-planner/issues/` and verified
   ruling-ready for the next sprint.
