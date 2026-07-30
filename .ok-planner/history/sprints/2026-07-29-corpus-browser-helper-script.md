# Sprint: Corpus-browser helper script, browse-skill retirement, and migration ratification

## Intent

Replace the `/browse` skill with an estate-owned helper script that starts
and stops the corpus view directly — launch on any free port, open the
system browser, record the process in gitignored run state so a later
`down` can kill it — and retire the skill from the suite's verb surface.
Two owner rulings from this session's out-of-band walk ride along:

- **Ratification.** The owner ratifies the corpus state shipped in
  commits `7c0c631..5e97ec4` (the proofs/falsifiers/acceptance
  eradication, the audit-cites-ordinary-tests verification model, the
  repoint mechanic, and certification's inline corpus repair) as the
  approved baseline. The live corpus already carries that state
  verbatim and the whole-corpus certification passed 44/44 against
  it; this sprint is the approval receipt, and no delta re-applies it.
- **True-up's intent corrected.** The `true-up` invariant "migration
  moves files and never rewrites their bodies" states the opposite of
  the owner's intent: true-up brings everything it reasonably can into
  compliance. The delta below rewrites the invariant, and the
  `design-corpus` invariant it collided with is aligned in the same
  pass.

No issues were promoted into this sprint (the intake is empty).

## Corpus deltas

### Amend concept: true-up

```markdown
---
concept: true-up
---

# True-up

## What it is

True-up is the suite's administration act: the idempotent converge of a project's integrated-family presence — estate, cheatsheet, vendored skills, and hook wiring — toward what the front door's carried payload declares. It has three phases — diagnose (read-only comparison of reality against declaration, on project drift and version drift), consent (only when something not suite-owned needs migrating, resolving, or transcribing), and converge (deterministic materialization of the suite-owned layer from committed declarations and the payload's canonical copies).

## Purpose

Because true-up is an idempotent installer — materializing a missing presence the same way it repairs a drifted one — the front door needs no separate install, upgrade, or repair modes: one act covers bootstrap and convergence alike, and a compliant project is a silent no-op. Converging the whole integrated set is a single administration pass, which is what keeps every upgrade, migration, and bootstrap deliberate per project.

## Boundaries

True-up is what the front door does, not a verb any family exposes and not a skill a project carries: each family contributes its conventional administration surfaces — the deterministic converge core, and the administration document holding the migration and repair judgment the core cannot encode — and the front door drives them (see also: skill-family, integration-contract). It never validates artifact contents (that is the compliance verbs' job) and never edits owner-declared configuration except as transcription of explicit answers, hook wiring in the project's committed harness settings included (see also: estate, stack-profile, whole-file-ownership under decisions). It is always a user or user-directed action — nothing in the suite runs it from a hook.

## Invariants

- Idempotent: re-running on a compliant project leaves the working tree unchanged.
- Converge is driven by committed declarations and the payload's canonical copies, never re-inferred at use time.
- Migration brings everything the suite owns or has retired into the pinned version's compliant shape wherever the compliant end state is mechanically determined — moving files, rewriting artifact bodies to remove retired suite mechanisms, deleting retired suite-owned files — and never makes a judgment edit; archived records keep their old wording.
- Invoking the administrator is itself the authorization to migrate the suite's own retired layouts; consent is reserved for genuine collisions, for content the suite does not own, and for transcription into owner-declared configuration.
```

### Amend concept: design-corpus

```markdown
---
concept: design-corpus
aliases:
  - design docs
  - durable design docs
  - the corpus
---

# Design corpus

## What it is

The design corpus is a project's durable, committed model of what it is and what it owes its users, held at a fixed altitude: a catalog of load-bearing nouns (concepts), a catalog of durable user expectations (stories), and a catalog of technical tradeoffs (decisions), plus generated tables of contents over each catalog and a point-in-time discovery scaffold that feeds the initial extraction. It is a source of truth with the same weight as code: it describes the project as it stands, and it is read freely.

## Purpose

The corpus gives every agent and human one stable place to learn a project's identity, vocabulary, and obligations, so that identity does not live in transient conversation, stale specifications, or individual memory. Because code links back to it rather than the reverse, refactors that move files never invalidate the model, and a code path that diverges from a stated boundary is a defect rather than an ambiguity.

## Boundaries

The corpus holds only the general framing: what kinds of things exist, what the product owes users, and which tradeoffs were chosen. Specific interface designs, schemas, grammars, and implementation diagrams are NOT corpus material — they live in code and in sprints (see also: sprint). Open questions about the corpus live in the intake queue, not in artifact bodies (see also: issue). The implementation-audit corpus that verifies the corpus's claims against the code is a separate, machine-written collection in the estate — a record of determinations, not corpus material (see also: estate, adversarial-implementation-audits under decisions). The discovery scaffold inside the corpus directory is point-in-time and exempt from the durable rules. Neighbors: concept-artifact, story-artifact, decision-artifact, catalog-toc, corpus-delta, annotation.

## Invariants

- After bootstrap, what the corpus commits to changes only by applying an approved sprint's corpus deltas — never ad hoc. The only other writers are mechanical and intent-preserving: expression repairs made in-cycle by certification and issue verification, and the administrator's determined migrations removing retired suite mechanisms (see also: true-up).
- The direction of reference is fixed: code cites the corpus via annotations; corpus bodies never cite code locations.
- Artifact bodies are self-contained and current-state only: no journals, no roadmaps, no path citations.
- The presence of the corpus is the gate other planning verbs key on; a project without one is directed to bootstrap first.
- The literal directory name is not load-bearing; the bright line is the altitude of the contents.
```

### Amend decision: local-web-surface

```markdown
---
decision: local-web-surface
---

# The corpus view is a local web application

## Choice

The corpus view is delivered as a read-only local web application — a page served over loopback by a program the project runs on demand — rather than as terminal output or an editor extension. The surface is chosen for what it has to carry: lateral movement in any direction, artifact to code and code back to the artifacts claiming it, with the cited excerpts held open inline beside the list they were reached from, all within one invocation the owner starts and closes.

## Rationale

A terminal report can print any one of those movements but cannot keep several navigable at once, so every lateral step costs another invocation and loses the reader's place. An editor extension buys the best code surface at the price of one editor's plugin model and a separate implementation per editor. A local page is the cheapest surface that carries both halves at once, and unlike a committed static site it is a process the owner starts and closes rather than a committed artifact.

## Alternatives

- A terminal report per artifact — composes with the suite's existing verbs, but flattens navigation into one linear dump per invocation.
- An editor extension — the strongest code surface, at the cost of a per-editor implementation and per-editor drift.
- A static site generated and committed per project — no service to run, but excerpts freeze at generation time and the generated artifact lands in every consumer repository.
```

## Work items

- **Helper script.** A `browse` support script in the ok-planner family
  payload, materialized by converge into the estate's `bin/` beside the
  other pinned tools and version-stamped like them (decision:
  per-project-pinning). `up`: pick any free loopback port, start the
  estate's own corpus-view detached on it, record the process id and
  port in a run file under the estate's gitignored run-state directory,
  and open the system browser on the page. `down`: stop the recorded
  process and remove the run file. Both verbs idempotent and
  stale-record tolerant (a recorded pid that no longer answers is
  cleaned up, not an error). Realizes decision:local-web-surface and
  story:trace-corpus-to-code — the user's way to reach the view is
  this script once the skill is gone.

- **Run-state ignore.** The suite-owned estate gitignore gains the
  run-state directory, so the recorded pid/port never becomes
  repository content; converge materializes the updated ignore.

- **Retire the browse skill.** Remove the skill from the family payload
  and every surface that names it: the vendored-skills map, the
  `checks/vendored-layer` pinned list, the family router skill's verb
  table, the administration document, and the family CLAUDE.md /
  cheatsheet templates (decision:vendored-skills,
  decision:slash-only-activation — both populations shrink by one).

- **Tests.** End-to-end exercise in the project's ordinary suites: the
  script's up/down cycle against a real estate (server answers on the
  recorded port, the run file exists and git ignores it, `down` kills
  the process and removes the file, a stale record is tolerated), and
  converge's materialization of the script and the updated gitignore.
  The per-project-pinning coverage that exercised the browse skill's
  payload-fallback note is replaced by coverage matching the script's
  estate-pinned reality. The existing corpus-view serving tests stand.

- **Apply the corpus deltas** above verbatim (true-up, design-corpus,
  local-web-surface).

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
   path as its argument, walk the presentation, offer
   archive-and-commit — so the ceremony is a
   standing unchecked item from the first minute, not a memory to
   retain past a long run. Staging is never rewritten into a plan
   document: this sprint is the whole brief.

3. Apply each corpus delta as part of the work that realizes it —
   copy the final-form body into `.ok-planner/design/` verbatim, or
   delete the file for a retirement. A delta no work item implements
   (a clarification, a retirement) is applied on its own.

4. Build stage by stage. Every new or amended story whose substance
   is implemented in code is exercised end-to-end by a test in the
   project's ordinary suites, carrying the `@story:` annotation for
   navigation. No test ever checks the existence of static text,
   code, or prose — a commitment realized in prose carries no test;
   its verification is the implementation audit, citing the
   governing text narrowly. Write the tests with the work, not at
   the end.

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
   call the work done. Ambiguity is not a blocker — pick
   the most plausible reading and continue, surfacing the choice at
   the end. (An orchestrator that supervises its own executors folds
   this into its own control.)

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
   below at the change's own scope: the project's own test suites
   over the touched work, change-scoped corpus checks over the
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

1. The design corpus matches every delta above (applied verbatim).
2. The project's own test suites pass, and every new or touched
   story implemented in code is exercised end-to-end by a test the
   suites run.
3. The implementation-audit corpus is current for everything the
   change touched or made stale, with any standing violation linked
   to an intake issue — mechanically: `.ok-planner/bin/audit-check
   --inspection` exits 0 (citations current, and every changed
   source-graph node dispositioned by the change inspection).
4. The completion report beside this sprint (same filename with
   `-completion`) is finished: it records the work done and the
   divergences, and carries `/certify-work`'s presentation — the
   review-fix loop run last and come back clean, every finding
   fixed or promoted-and-verified.

**The goal rule, for any checker verifying this contract.** The goal
is met in exactly two ways: this sprint file has moved to
`.ok-planner/history/sprints/` bearing a `closed:` stamp — the owner
accepted and closed the work; terminal, stop checking — or this file
is still at its `sprints/` path and items 1–4 all verify against the
repository. A missing completion report means NOT done, however
green the rest looks; an archived, stamped sprint means DONE,
whatever else seems unfinished. A run parked at the review-fix
loop's cycle cap awaiting the owner's direction is a legal in-flight
state — not done, not failed, and never grounds for the run to take
either cap step itself. Nothing else counts either way.
