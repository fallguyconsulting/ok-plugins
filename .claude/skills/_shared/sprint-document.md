# The sprint document

The planning ceremony's terminal artifact, defined once. The ceremony's
ok-planner surface references this file; nothing restates it inline.

`{{SPRINT-DOCUMENT-TEMPLATE}}` is the whole document. Its **How to
execute this sprint** and **Completion contract** sections are fixed
boilerplate — copied verbatim into every sprint, never paraphrased and
never trimmed. Together they make the sprint self-driving: the how
frames the executor's approach, the contract is the stop condition, and
`/certify-work` discharges the contract. That is what lets a sprint be
handed directly to `/goal`, to an orchestrator, or picked up inline —
every executor works from the same brief.

---

### {{SPRINT-DOCUMENT-TEMPLATE}}

```markdown
# Sprint: <title>

## Intent

<What this sprint is for, in a few sentences. A sprint with no single
theme says so plainly — do not invent one. List the ids of the issues
promoted into this sprint, if any.>

## Corpus deltas

<The substantive body, authored per {{CORPUS-DELTA-FORM}} in
`artifact-definitions.md`. Each delta sits under a heading naming the
operation and target:>

### New story: <slug>
### Amend concept: <slug>
### Retire decision: <slug>

<Every delta is a complete FINAL-FORM body, resolved during planning:
new artifacts and amendments carry the whole file content; a
retirement carries nothing beyond its heading. A sprint with large
bodies carries them in the sidecar folder beside this file
(`<sprint-name>-deltas/<kind>s/<slug>.md`), the heading pointing
there. No delta carries a diff, a base pin, or a derivation.>

## Work items

<The implementation units that realize the deltas — a flat, unordered
list. Each names the stories/decisions it makes true (by slug) and
describes the outcome, not the method. Real dependencies between items
are stated as such; do NOT group items into stages, phases, or themes,
and do not impose an order that is merely tidy. Sequencing is the
executor's job.>

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
is met when items 1–3 all verify against the repository, this sprint
file still at its `sprints/` path. That state IS the goal met — do
not require more: archiving, committing, and the `closed:` stamp are
owner-initiated acts that FOLLOW completion, and a pending
archive-and-commit offer is evidence the goal is met, never that
work remains. A checker that instead finds this file at
`.ok-planner/history/sprints/` bearing a `closed:` stamp is looking
at a goal already met and closed by the owner — terminal, whatever
else seems unfinished; stop checking. A missing completion report
means NOT done, however green the rest looks. Distinct from both
states above: a run parked at the review-fix loop's cycle cap
awaiting the owner's direction has not met the goal — a legal
in-flight state, not done, not failed, and never grounds for the run
to take either cap step itself. Nothing else counts either way.
```

<!-- Materialized by ok-planner v15.2.0 — suite-owned; overwritten on converge; do not hand-edit. -->
