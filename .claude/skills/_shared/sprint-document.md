# The sprint document

The planning ceremony's terminal artifact, defined once. The ceremony references this file and never restates it.

`{{SPRINT-DOCUMENT-TEMPLATE}}` is the whole document. Its **How to execute this sprint** and **Completion contract** sections are fixed boilerplate: copy them verbatim into every sprint. The how frames the executor's approach; the contract is the stop condition; `/certify-work` discharges the contract. Every executor — `/goal`, an orchestrator, an inline session — works from the same brief.

---

### {{SPRINT-DOCUMENT-TEMPLATE}}

```markdown
# Sprint: <title>

## Intent

<What this sprint is for, in a few sentences. A sprint with no single
theme says so. List the ids of the issues promoted into this sprint,
if any.>

## Corpus deltas

<Authored per {{CORPUS-DELTA-FORM}} in `artifact-definitions.md`.
Each delta sits under a heading naming the operation and target:>

### New story: <slug>
### Amend concept: <slug>
### Retire decision: <slug>

<Every delta is a complete final-form body. New artifacts and
amendments carry the whole file content; a retirement carries only
its heading. Large bodies go in the sidecar folder beside this file
(`<sprint-name>-deltas/<kind>s/<slug>.md`), the heading pointing
there. No delta carries a diff, a base pin, or a derivation.>

## Work items

<The implementation units that realize the deltas: a flat, unordered
list. Each names the stories and decisions it makes true (by slug)
and describes the outcome, not the method. State real dependencies
between items. Do not group items into stages, phases, or themes,
and do not order them. Sequencing is the executor's job.>

## How to execute this sprint

This sprint is self-sufficient. Every executor — an inline session,
an agent handed this file via `/goal`, an orchestrator with its own
planning — proceeds the same way.

1. Read the sprint whole first: intent, deltas, work items,
   completion contract. Do not look for context behind it, in the
   intake (`.ok-planner/issues/`) or in `history/`. Raise a gap with
   the owner; never fill it by inference.

2. Stage the work. Group the items by theme, file surface, or
   dependency, and order the groups so nothing is built on something
   not yet there. Before building, write the staged list as the
   opening section of the completion report (step 8): `## Stages`,
   one line per stage, each marked pending. Seed the closing stages
   now — finish the completion report, run `/certify-work` with this
   sprint's path as its argument, walk the presentation, offer
   archive-and-commit — so the ceremony is a pending line from the
   start. Mark each stage done as it lands. The list lives in the
   report only: not in a harness task tool, never in a plan document.
   An orchestrator uses its own graph and still records the stages in
   the report.

3. Apply each corpus delta as part of the work that realizes it:
   copy the final-form body into `.ok-planner/design/` verbatim (from
   the sidecar where the heading points there), or delete the file
   for a retirement. Apply a delta no work item implements on its
   own.

4. Build stage by stage. Every new or amended story implemented in
   code is exercised end-to-end by a test in the project's ordinary
   suites, carrying the `@story:` annotation. No test checks the
   existence of static text, code, or prose; a commitment realized in
   prose carries no test. Write the tests with the work.

5. Completeness is the floor. Never stub, defer, narrow, no-op, or
   leave a `TODO` in place of a promised outcome. Deliver every
   capability the deltas or work items promise in full, or surface
   the blocker that prevents it.

6. Never destroy uncommitted work. Stage the paths you touched as
   each stage finishes (`git add <paths>`), so a stray revert cannot
   reach them. Never run `git checkout`/`restore`/`reset`/`stash`/
   `clean` on your own initiative. Fix a bad edit forward by editing
   again.

7. Work unsupervised to a defensible done. Do not pause for
   approval, confirmation, or progress checks. Stop only on a
   genuine blocker: a credential or access you cannot obtain, a step
   impossible in the current state, a destructive or irreversible
   action not clearly authorized, or the closing `/certify-work`
   step being unrunnable for you (its subagent dispatches
   unavailable). Surface that and stop; never skip the ceremony and
   call the work done. Ambiguity is not a blocker: pick the most
   plausible reading, continue, and surface the choice at the end.
   An orchestrator that supervises its own executors folds this into
   its own control.

8. Keep the completion report current. It lives beside this sprint
   file, same filename with `-completion` before the extension. Open
   it in step 2 with the staged list. As each stage lands, mark it
   done and record what was done, every divergence, and every call
   you made where the sprint was silent. It is the record the
   closing ceremony finishes and walks with the owner, the artifact
   a goal checker requires, and it is archived with this sprint. It
   is a record of this execution, never a plan.

9. Close by running `/certify-work` with this sprint's path as its
   argument. The argument puts the sprint in the gate's scope; the
   gate never adopts one on its own. The gate brings the work into
   alignment with this sprint and discharges the completion contract
   at the change's scope, across every estate the project has: the
   project's test suites over the touched work, change-scoped corpus
   checks over the touched artifacts and annotations, code review
   over the diff. All producers feed a no-discretion review-fix loop:
   a fixer fixes everything a reasonable owner would wave through; an
   architect adversarially checks its kickbacks, fixes the refuted,
   and promotes only genuine intent forks to the intake. Whether the
   corpus's claims still hold is the periodic `/audit` run's
   question, never this close's. `/certify-work` ends the run: it
   writes its presentation into the completion report, walks the
   presentation with the owner, offers the close-out, and stops.

**After the run stops.** The owner archives this sprint and commits
the work. The run offers both at the end of the presentation and
does neither on its own. Until the owner answers, this file stays at
its `sprints/` path. On yes, the run moves this file, its completion
report, its delta sidecar, and the issue files it resolved to
`history/`, commits the work, then stamps the archived sprint with
the closing commit — `closed: <sha>` in the frontmatter, one small
follow-on commit. The next planning ceremony reads that stamp to
detect work done out of band. "Finish the sprint" and "follow the
boilerplate" are not a yes; both ask for the presentation.

## Completion contract

The work is done when all of the following hold, each verifiable
from the repository as it stands:

1. The design corpus matches every delta above, applied verbatim
   (from the sidecar where a heading points there).
2. The project's own test suites pass, and every new or touched
   story implemented in code is exercised end-to-end by a test the
   suites run.
3. The completion report beside this sprint (same filename with
   `-completion`) is finished: it records the work done and the
   divergences, and carries `/certify-work`'s presentation — the
   review-fix loop run last and come back clean, every finding
   fixed or promoted-and-verified.

**The goal rule, for any checker verifying this contract.** The goal
is met when items 1–3 verify against the repository as it stands.
Decide from the repository, never from the session transcript: an
earlier session may have done the work, and a term the transcript
does not show may hold on disk. That state is the goal met. Walking
the presentation, archiving, committing, and the `closed:` stamp all
follow completion; a pending archive-and-commit offer is evidence
the goal is met. Where this sprint file sits is no term of the rule:
`sprints/` and `.ok-planner/history/sprints/` satisfy it alike, and
a sprint already archived with a `closed:` stamp is terminal — stop
checking. A missing completion report means not done. A run parked
at the review-fix loop's cycle cap awaiting the owner's direction
has not met the goal: a legal in-flight state, not done, not failed,
and never grounds for the run to take either cap step itself.
Nothing else counts either way.
```

<!-- Materialized by ok-planner v18.6.1 — suite-owned; overwritten on converge; do not hand-edit. -->
