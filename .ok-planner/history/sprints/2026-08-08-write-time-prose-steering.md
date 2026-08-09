# Sprint: Write-time prose steering

## Intent

Agent-written prose in this project drifts into literary register —
abstraction, elegant variation, decorative examples — and the fix the
owner chose is steering, not linting: a canonical writing standard in
the ok-plumbline family, delivered to every writing agent ambiently
and again at the moment it writes markdown. This sprint authorizes
the already-drafted standard document, records the
steering-over-lint decision, and wires the delivery channels. No
issues were promoted into this sprint; the intake is empty.

## Corpus deltas

### New story: write-time-prose-steering

```markdown
---
story: write-time-prose-steering
---

# The writing standard reaches agents when they write

## Story

As a project owner, I want every agent that writes a markdown file in my project to receive the project's writing standard before it writes, so that the prose I read follows the standard instead of the agent's own style.
```

### New decision: steering-over-prose-lint

```markdown
---
decision: steering-over-prose-lint
---

# Prose is steered at write time, never linted

## Choice

The writing standard is enforced by steering. Its portable dispatch rule is injected into the writing agent's context whenever any agent in the session writes a markdown file — a consented PreToolUse hook on Write and Edit, firing for the main session and dispatched subagents alike — and the family cheatsheet carries the same rule ambiently, pointing at the full standard materialized in the estate. No prose lint exists: the plumbline lint's charter stays comments and citations.

## Rationale

Most of the standard is not mechanically decidable. A checker cannot see elegant variation, a broken metaphor, or a decorative example; it can only match phrases, and a phrase list catches too little while flagging legitimate prose. Steering acts where the failure happens — at generation: an ambient rule competes with a full context for salience, but a rule injected at the moment of the write is the freshest instruction the model holds. The subagent coverage the Choice commits to is what the ambient channels cannot give: a dispatched writer whose prompt omits the rule still receives it at the moment of writing.

## Alternatives

- A prose lint in the plumbline binary — the decidable subset (a banned-phrase list, sentence-length caps) is a poor proxy for the standard, and false positives would teach agents to ignore the lint. Rejected as too rigid, and it would widen the lint's charter from comments to prose.
- Cheatsheet only — reaches every agent, but relies on ambient salience alone with nothing at the moment of writing.
- The dispatch rule pasted into every skill prompt — depends on every skill author remembering it; the standard would erode one forgotten prompt at a time.
```

## Work items

- The canonical writing standard ships in the family payload at
  `plugins/ok/families/ok-plumbline/docs/technical-writing.md` (the
  drafted document now staged in the tree is authorized by this
  sprint), and plumbline's converge materializes it into the
  consumer estate at `.ok-plumbline/docs/technical-writing.md`.
  Realizes `write-time-prose-steering`, `steering-over-prose-lint`.
- The plumbline cheatsheet gains a writing-standard section: the
  standard's dispatch rule verbatim, plus a pointer to the
  materialized guide. Realizes `write-time-prose-steering`.
- Plumbline's consented hook wiring gains the steering hook: a
  PreToolUse hook on Write and Edit that, for any target path ending
  `.md`, injects the standard's dispatch rule as context. Same
  consent path as the existing edit-time lint hook; wired only where
  the owner consented. Exercised end-to-end by a test in the
  plumbline suite carrying `@story: write-time-prose-steering`.
  Realizes `write-time-prose-steering`, `steering-over-prose-lint`.

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
