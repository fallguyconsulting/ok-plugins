---
closed: 68daf61
---

# Sprint: Reconcile marker-based root resolution into the corpus

## Intent

Reconciliation, no single feature theme: the suite's project-root
resolution changed out of band (shipped in v15.1.0) from
nearest-`.git`-ancestor to estate-marker-first, and the corpus still
commits to the old rule. This sprint's deltas bring `concept:estate`
and `decision:filesystem-discovery-markers` into agreement with the
shipped behavior — the approved deltas are the retroactive
authorization for that work — and one work item finishes the code
side: the ok-plumbline root-resolution sites the out-of-band change
missed, which must conform before the deltas' universal claim is
true. Promoted issue: `root-resolution-markers-not-git`.

## Corpus deltas

### Amend concept: estate

```markdown
---
concept: estate
aliases:
  - dot-directory
  - project-side estate
---

# Estate

## What it is

An estate is a skill family's committed project-side presence, rooted
in one dot-directory named for the family: declared configuration
(including any stack profile), the family's corpus of durable content,
materialized support scripts, hooks and program payloads, ceremony
surfaces, injected-context payloads, and any machine-written
determination records. Beside those a family may keep machine-local
content its own ignore file holds out of the repository — real on
disk, never part of what the project commits. Its existence doubles as
the discovery marker answering "which suite families does this project
use," and as the anchor the project root is resolved from.

## Purpose

Rooting everything in one committed directory makes integration state
a property of the project rather than of any machine: contributors
without anything installed still see the estate, discovery is a
filesystem check, and each project runs exactly what it was converged
to. Absence is a meaningful state — a bootstrap candidate or a
recorded decline — not an error.

## Boundaries

The estate is suite territory inside the consumer's repo, converged by
the front door's administration (see also: true-up); outside it a
family owns only its cheatsheet and its vendored skill files (see
also: cheatsheet, vendored-skills under decisions). Documented
pre-migration marker locations are honored for discovery so
un-migrated projects are still found and offered migration (see also:
filesystem-discovery-markers under decisions). The front-door plugin
deliberately has no estate. Content kinds inside an estate carry
distinct context rules — source-of-truth corpus content, operational
intake state, machine-written audit determinations, project records,
and the machine-local content a family's own ignore file excludes from
the repository (a build its administration placed, a measurement one
of its runs left), which is nobody's source of truth and is never read
as project content (see also: design-corpus, issue,
adversarial-implementation-audits under decisions). The record
discipline is this concept's to state once: records — sprints,
sketches, and the archive — are committed and versioned but out of
agent context by default, with exactly one live exception (the sprint
currently being executed), and every completed or retired record moves
to its same-named folder in the archive (see also: sprint, sketch).

## Invariants

- The project root is defined by the estate, not the reverse: it is
  the nearest ancestor of the working directory (itself included)
  carrying an estate or a documented pre-migration marker, else the
  working directory itself — where a fresh estate then roots. Every
  implementation of root resolution across the suite conforms to this
  one rule, and the repository layout plays no part in it: a project
  may live in a subfolder, submodule, or subproject of a repository
  whose own root carries no estate.
- All of a project's estates share one root directory — co-location is
  what keeps "the" project root a single coherent location when
  several families integrate.
- Whether the estate is tracked in git is the project owner's decision
  where the family has no gitignore of its own.
- Records in an estate are preserved indefinitely in its archive;
  migration moves files, never rewrites their bodies.
- An estate-less family carried by the installed front door is offered
  bootstrap by consent; declining is a valid state, not drift.
```

### Amend decision: filesystem-discovery-markers

```markdown
---
decision: filesystem-discovery-markers
---

# Integration is discovered by filesystem markers, never inference

## Choice

"Which suite families does this project use" is answered solely by
checking for each family's committed dot-directory estate at the
project root, plus documented pre-migration marker locations so
un-migrated projects are still discovered and offered migration. The
project root is itself resolved from those same markers: the nearest
ancestor of the working directory (itself included) carrying an estate
or documented pre-migration marker, else the working directory itself
— never derived from `.git`. Hooks use the same rule to decide whether
to no-op; absence is a meaningful state — bootstrap candidate or
recorded decline — not an error.

## Rationale

A filesystem check is deterministic, per-project, and independent of
anyone's memory of what was adopted where: integration state stays a
property of the project, and the administrator reads it rather than
deciding it. Inference from project content would misfire in both
directions and make integration state a matter of opinion; honoring
documented legacy markers keeps migration offerable without guessing.
Resolving the root from the markers themselves rather than from `.git`
keeps the suite usable wherever a project actually lives — a
subfolder, submodule, or subproject of a repository whose own root
wants no estate — and makes a fresh install root exactly where the
agent is operating.

## Alternatives

- Infer usage from project content or conversation — nondeterministic,
  and makes integration state a matter of opinion rather than a
  committed fact.
- A central registry of integrated families — a second source of truth
  that drifts from the estates themselves.
- Resolve the project root from the nearest `.git` ancestor — anchors
  the suite to the repository rather than the project, so an install
  in a subproject escalates into a parent repo that never opted in.
```

## Work items

- Bring ok-plumbline's remaining root-resolution sites into
  conformance with the amended `concept:estate` invariant and the
  `decision:filesystem-discovery-markers` choice (this item makes
  those two artifacts true). Three sites currently key on `.git`:
  the hook implementations
  `plugins/ok/families/ok-plumbline/scripts/hooks/post-edit.js` and
  `pre-write.js` (each walks ancestors for `.git` only and exits as
  "not in a repo" when none is found, never consulting an estate
  marker), and `bin/plumbline`'s `findRepoRoot` (mixes `.git` into
  the same per-directory scan as the markers, so a nearer `.git` can
  win). Outcome: all three resolve the project root as the nearest
  ancestor of the working directory (itself included) carrying an
  estate or documented pre-migration marker, else the working
  directory itself; the hooks no-op exactly when the resolved root
  carries no ok-plumbline presence; `.git` is consulted nowhere.
  Consumer projects receive the change through the ordinary channel
  (converge re-materializes hook copies); no extra distribution work
  is part of this item.

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
