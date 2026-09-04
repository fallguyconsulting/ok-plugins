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
planning — runs the same shape: plan the work into the task tracker
as small build and review tasks, drain them, then one cold
certification, then the closing ceremony.

1. Read the sprint whole first: intent, deltas, work items,
   completion contract. Do not look for context behind it, in the
   intake (`.ok-planner/issues/`) or in `history/`. Raise a gap with
   the owner; never fill it by inference.

2. Open the run. The task tracker at `.ok-planner/bin/tasks` and the
   profiles under `.claude/agents/` are required; a missing one is
   the front door's administration (`/ok`) to materialize — say so
   and stop. Open one run for this sprint per the certification
   core (`_shared/certification-core.md` under `.claude/skills/`,
   **How consumers use this file**): `tasks init <sprint-name>
   --file .ok-planner/sprints/<sprint-name>-run.jsonl`, the
   `staged_pool` config, the two profiles, and the prompt files —
   `build` from `{{BUILD-TASK-PROMPT}}` and `review` from
   `{{BUILD-REVIEW-PROMPT}}`, each with `[SPRINT PATH]` filled and
   `[BUILD-REVIEW PRODUCERS]` filled from every present family's
   **Build-review producers** section. The run file is the record of
   this execution and archives with this sprint.

3. Plan the work into stages. Read the code the work items touch
   before you file anything; this planning is the session's own
   act, and it needs the sprint and the tree both in view. Cut the
   sprint into stages, each **the smallest change that makes
   progress toward the completion contract and leaves the tree
   runnable**: its own tests pass, nothing is half-wired, and the
   work after it can build on it. A stage lands one work item or a
   part of one, never several. A work item that needs more than one
   agent's reading set becomes several stages in sequence. Per
   stage, file one build task: `tasks file --role build --prompt
   build --agent ok-opus --key <stage> --files <the paths it may edit
   and the test modules it runs> --cites <the work items and slugs>
   --after <the build tasks of the stages it builds on> --brief "<the work items it
   lands, the deltas it applies, and the collateral you captured:
   where the code is, what to reuse, what the tests must prove>"`.
   Then file its review task: `tasks file --role review --prompt
   review --agent ok-opus --key <stage> --after <the build task>
   --consumes staged:unread --brief "<the work items and deltas the
   stage lands>"`. Two stages whose files overlap are chained with
   `--after`; a stage that applies a delta reaches the catalog TOCs
   under `.ok-planner/design/` too, so two delta-bearing stages
   overlap. Stages with disjoint files run together. Apply a delta
   no work item implements in a stage of its own. Every dispatch
   names its profile, and the profile names its model.

4. Render the completion report (step 9) with the staged list before
   the first drain: `## Stages`, one line per build task naming the
   stage, its work items, and its state, read from `tasks dump
   --type task`. The harness task tools,
   where available, mirror that list as a live checklist, one task
   per stage, marked done as each closes; the run file is the
   record and the task list is display.

5. Drain with the `execute-tasks` loop (`.claude/skills/execute-tasks/SKILL.md`):
   `tasks next --all` prints every ready task; dispatch them together
   under their profiles with the fixed message, stamp each task's
   usage as its agent returns, and call `next` again when every agent
   has returned. After each review task closes, run the per-stage
   fix loop the certification core states under
   `{{BUILD-REVIEW-PROMPT}}`: no open finding → the stage is
   complete; otherwise batch the open findings into fix tasks under
   the `build` prompt — `--after` every build task still open whose
   files overlap the findings' files, so no two tasks write one file
   — file a review after them, and drain again, under the bound that
   section sets. A build that closes `partial`
   leaves its review task ready to run against half a stage: close
   that review `blocked` with the result `superseded`, refile the
   build's remainder with `tasks refile <task>`, then refile the
   review `--after` the remainder. Re-render
   the report after every drain step. The session builds nothing
   and reviews nothing itself, and never edits a file a running task
   owns.

6. Every stage applies its corpus deltas as part of the work that
   realizes them, and every new or amended story implemented in code
   is exercised end-to-end by a test in the project's ordinary
   suites, carrying the `@story:` annotation. The build task's
   prompt carries both rules. Leave `.ok-planner/audits/` and
   `.ok-planner/experiments/` untouched: only a running `/audit`
   reads or writes them.

7. Completeness is the floor. Never stub, defer, narrow, no-op, or
   leave a `TODO` in place of a promised outcome. Deliver every
   capability the deltas or work items promise in full, or surface
   the blocker that prevents it. A stage is not complete until its
   review's findings pool is empty.

8. Never destroy uncommitted work. Every task stages the paths it
   touched as it closes (`git add <paths>`), and the run records
   them. Never run `git checkout`/`restore`/`reset`/`stash`/`clean`
   on your own initiative. Fix a bad edit forward by editing again.

9. The completion report stays current. It lives beside this sprint
   file, same filename with `-completion` before the extension. The
   session renders it from the run before every dispatch and at the
   end, per the certification core: `## Stages` from the build
   tasks, and `## Divergences` from the run's `divergences` pool,
   one entry per item, each opening with the item's id — a recorded
   call, or a claimed fork with its options and the reading built.
   Build and fix tasks file those items; nobody edits the report by
   hand during the build. The report is the record the closing
   ceremony finishes and walks with the owner, the artifact a goal
   checker requires, and it is archived with this sprint. It is a
   record of this execution, never a plan.

10. Work unsupervised to a defensible done. Do not pause for
    approval, confirmation, or progress checks. Stop only on a
    genuine blocker: a credential or access you cannot obtain, a step
    impossible in the current state, a destructive or irreversible
    action not clearly authorized, a task closed `blocked` twice, or
    the closing `/certify-work` step being unrunnable for you (its
    task dispatches unavailable). Surface that and stop; never skip
    the ceremony and call the work done. Ambiguity is not a blocker:
    the build task's prompt has the builder make the most plausible
    call and record it, or record a fork and build the reading it
    judges most plausible. The gate reads both.
    An orchestrator that supervises its own executors folds this into
    its own control.

11. Code complete means every stage is complete: every stage's
    latest build task closed `done` and every stage's findings pool
    empty. Close by
    running `/certify-work` with this sprint's path as its argument,
    immediately after. The argument puts the sprint in the gate's
    scope; the gate never adopts one on its own. The gate reuses
    this sprint's run and is cold: it runs the project's test suites
    over the touched work, change-scoped corpus checks over the
    touched artifacts and annotations, and one code review over the
    whole diff by a reviewer holding no history and blind to the
    report; its sprint-alignment judge reads the report's divergences
    under the veto test and routes each claimed fork to the architect.
    All producers feed a no-discretion review-fix loop: fixer and
    architect tasks work in rounds against the run's findings pool.
    The loop ends at the first round in which neither the fixer nor
    the architect edited any file (code, corpus, or the report's
    `## Divergences`). A fixer fixes everything a reasonable owner
    would wave through. An architect adversarially checks its
    kickbacks, its refutations, the claimed forks, and any reversal.
    It makes the fix wherever it overturns the claim, and promotes
    only genuine intent forks to the intake.
    Whether the corpus's claims still hold is the periodic `/audit`
    run's question, never this close's. `/certify-work` ends the run:
    it writes its presentation into the completion report, walks the
    presentation with the owner, offers the close-out, and stops.

**After the run stops.** The owner archives this sprint and commits
the work. The run offers both at the end of the presentation and
does neither on its own. Until the owner answers, this file stays at
its `sprints/` path. On yes, the run moves this file, its completion
report, its run file, its delta sidecar, and the issue files it
resolved to `history/`, commits the work, then stamps the archived
sprint with the closing commit — `closed: <sha>` in the frontmatter,
one small follow-on commit. The next planning ceremony reads that
stamp to detect work done out of band. "Finish the sprint" and
"follow the boilerplate" are not a yes; both ask for the
presentation.

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
   settled: `fixed <pass>`, `refuted`, `dissolved`, `reversal-ruled`,
   or promoted-and-verified.

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
checking. A missing completion report means not done. The run file is
no term of the contract: it is the execution's working record, and
whether it exists decides nothing. A run parked
at the review-fix loop's cycle cap awaiting the owner's direction
has not met the goal: a legal in-flight state, not done, not failed,
and never grounds for the run to take either cap step itself.
Nothing else counts either way.
```
