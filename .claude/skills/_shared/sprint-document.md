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
planning — runs the same shape: a team of two workers the session
relays, then one cold certification.

1. Read the sprint whole first: intent, deltas, work items,
   completion contract. Do not look for context behind it, in the
   intake (`.ok-planner/issues/`) or in `history/`. Raise a gap with
   the owner; never fill it by inference.

2. Stage the work. Group the items by theme, file surface, or
   dependency, and order the groups so nothing is built on something
   not yet there. Before building, write the staged list as the
   opening section of the completion report (step 9): `## Stages`,
   one line per stage, each marked pending. Seed the closing stages
   now — finish the completion report, run `/certify-work` with this
   sprint's path as its argument, walk the presentation, offer
   archive-and-commit. The builder marks each build stage done as it
   lands. The session marks the closing stages after the team
   retires. The report is the record of the stages, never a plan
   document. The session keeps one task per stage in the harness task
   tools, where available, mirroring the report's staged list, and
   marks each task done as its stage lands. The task list is display;
   the report remains the record.
   An orchestrator uses its own graph and still records the stages in
   the report.

3. Run the team. The session orchestrates and never joins as a
   worker: it relays messages between the two workers, reads their
   task notifications, and holds the reviewer's ledger. It opens the
   completion report with the staged list before the build and marks
   the closing stages after the team retires; during the build it
   edits nothing. Every dispatch names its model.
   - **The builder** (`opus`), dispatched once with this sprint's
     path and the report's path, fed one stage per message. It
     writes the code, applies the stage's corpus deltas, tests what
     it built, marks the stage in the report with what it did, and
     stands by. It fixes the reviewer's findings in its own context
     when they arrive.
   - **The standing reviewer** (`opus`), dispatched once under the
     standing-reviewer brief in the certification core
     (`_shared/certification-core.md` under `.claude/skills/`), fed
     each landed stage's paths. It reads the increment under the
     certification gate's code-review brief plus the read-only
     per-stage producers each present family's ceremony contribution
     names under **Standing producers**, keeps a ledger of open
     findings, and replies with the ledger. It reports each claimed
     fork outside the ledger, in every reply until the completion
     report carries it. It edits nothing and runs no suite.
   - **The relay.** The session runs the relay protocol stated with
     that brief in the certification core: the message it sends the
     reviewer as each stage lands, the lines and claimed forks it
     relays back to the builder, the fix-only rounds it runs after the
     final stage, and the bound on those rounds.
   - **Retirement.** Retire a worker only at a stage boundary, once
     its measured context (`subagent_tokens`) passes a threshold held
     below the harness's compaction window (~300k tokens on a
     1M-token window). A replacement builder reads this sprint and
     the report and continues at the next stage; a replacement
     reviewer receives the open ledger and the open claimed forks the
     session holds.
   - **Without messaging.** Where the harness offers no cross-agent
     messaging, one session runs the same shape in bounded batches.
     The session orchestrates here too. Per batch it dispatches a
     fresh builder (`opus`) with this sprint's path, the report's
     path, one stage, and the open findings, then a fresh reviewer
     (`opus`) under the same brief over that stage's paths. The
     ledger and the open claimed forks travel in the prompt. After
     the last stage's batch, the session runs fix-only batches — a
     builder with the open ledger, then a reviewer over the fixed
     paths — until the reviewer reports an empty ledger, under the
     same bound the protocol sets.

4. Apply each corpus delta as part of the work that realizes it:
   copy the final-form body into `.ok-planner/design/` verbatim (from
   the sidecar where the heading points there), or delete the file
   for a retirement. Apply a delta no work item implements on its
   own.

5. Build stage by stage. Every new or amended story implemented in
   code is exercised end-to-end by a test in the project's ordinary
   suites, carrying the `@story:` annotation. No test checks the
   existence of static text, code, or prose; a commitment realized in
   prose carries no test. Write the tests with the work; the
   builder runs the tests that cover what it built, never the full
   suites — the gate runs the regression. Leave
   `.ok-planner/audits/` and `.ok-planner/experiments/` untouched:
   only a running `/audit` reads or writes them, and they record
   behavior at the time of the audit. An experiment the work breaks
   stays broken until the next run repairs or retires it.

6. Completeness is the floor. Never stub, defer, narrow, no-op, or
   leave a `TODO` in place of a promised outcome. Deliver every
   capability the deltas or work items promise in full, or surface
   the blocker that prevents it.

7. Never destroy uncommitted work. Stage the paths you touched as
   each stage finishes (`git add <paths>`). Never run `git checkout`/
   `restore`/`reset`/`stash`/`clean` on your own initiative. Fix a bad
   edit forward by editing again.

8. Work unsupervised to a defensible done. Do not pause for
   approval, confirmation, or progress checks. Stop only on a
   genuine blocker: a credential or access you cannot obtain, a step
   impossible in the current state, a destructive or irreversible
   action not clearly authorized, or the closing `/certify-work`
   step being unrunnable for you (its subagent dispatches
   unavailable). Surface that and stop; never skip the ceremony and
   call the work done. Ambiguity is not a blocker. The builder never
   files an issue: where the sprint is silent, it makes the most
   plausible call, continues, and records the call in the report as
   a divergence; where the sprint and corpus do not determine the
   fix and reasonable owners diverge, it records the fork with its
   options, builds the reading it judges most plausible, and
   continues. The gate reads both.
   An orchestrator that supervises its own executors folds this into
   its own control.

9. The completion report stays current. It lives beside this sprint
   file, same filename with `-completion` before the extension. The
   session opens it in step 2 with the staged list and marks the
   closing stages after the team retires. The builder marks each build
   stage done as it lands and records what it did. It writes every
   divergence and every claimed fork — its own and the reviewer's —
   into one `## Divergences` section, one entry each. Each entry opens
   with a stable identifier on its first line: `D<n>` for a
   divergence, `F<n>` for a claimed fork, numbered in the order the
   builder wrote them. The identifier lets the gate's architect
   rewrite an entry in place. A fork entry carries the fork's options
   and, where the builder built one, the reading it built. The report is the record the closing ceremony
   finishes and walks with the owner, the artifact a goal checker
   requires, the brief a replacement builder reads, and it is archived
   with this sprint. It is a record of this execution, never a plan.

10. Code complete means the built work works and the reviewer's ledger
    is empty. Close by running `/certify-work` with this sprint's path
    as its argument, immediately after. The argument puts the sprint
    in the gate's scope; the gate never adopts one on its own. The
    gate is cold and is the regression: it runs the project's test
    suites over the touched work, change-scoped corpus checks over the
    touched artifacts and annotations, and one code review over the
    whole diff by a reviewer holding no history and blind to the
    report; its sprint-alignment judge reads the report's divergences
    under the veto test and routes each claimed fork to the architect.
    All producers feed a no-discretion review-fix loop: standing
    agents work in rounds against a finding ledger. The loop ends at
    the first round in which neither the fixer nor the architect
    edited any file (code, corpus, or the report's `## Divergences`).
    A fixer fixes everything a reasonable owner would wave
    through. An architect adversarially checks its kickbacks, its
    refutations, the claimed forks, and any reversal. It makes the fix
    wherever it overturns the claim, and promotes only genuine intent
    forks to the intake.
    Whether the corpus's claims still hold is the periodic `/audit`
    run's question, never this close's. `/certify-work` ends the run:
    it writes its presentation into the completion report, walks the
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
checking. A missing completion report means not done. A run parked
at the review-fix loop's cycle cap awaiting the owner's direction
has not met the goal: a legal in-flight state, not done, not failed,
and never grounds for the run to take either cap step itself.
Nothing else counts either way.
```

<!-- Materialized by ok-planner v18.8.0 — suite-owned; overwritten on converge; do not hand-edit. -->
