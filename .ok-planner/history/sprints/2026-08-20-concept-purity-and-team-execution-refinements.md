---
closed: 2718095
---
# Sprint: Concept purity, prose-hook scope, and team-execution refinements

## Intent

A disparate set, no single theme. Four things land together:

- Concepts become definitional only. The concept definition, the
  template, the sign-off reviewer, and the audit's concept instrument
  all change, and every concept in this corpus is rewritten to the
  new form.
- The prose-review hook binds files under the project root only, and
  the corpus catches up with the end-of-work reminder shape already
  in the tree.
- The team execution shape gains a retirement band, two reviewer
  instruments, a ledger sidecar, and monitor-based liveness.
- The corpus retroactively authorizes the run-tag replacement
  (content-addressed tag → per-run tag) that landed out of band.

No issues were promoted: the intake was empty at planning.

## Corpus deltas

### Amend decision: steering-over-prose-lint
body: in the sidecar

### Amend decision: team-execution-cold-gate
body: in the sidecar

### Amend decision: adversarial-implementation-audits
body: in the sidecar

### Amend decision: code-cites-design
body: in the sidecar

### Amend decision: cold-boxed-synthesis
body: in the sidecar

### Amend decision: comments-forbidden-by-default
body: in the sidecar

### Amend decision: lockstep-suite-version
body: in the sidecar

### Amend decision: vendored-skills
body: in the sidecar

### Amend decision: final-form-deltas
body: in the sidecar

### Amend decision: documentation-walk-in-composed-audit
body: in the sidecar

### Amend decision: affirmative-warrant-ladder
body: in the sidecar

### Amend decision: closing-commit-baseline
body: in the sidecar

### Amend decision: whole-file-ownership
body: in the sidecar

### Amend decision: filesystem-discovery-markers
body: in the sidecar

### Amend decision: declared-stack-profile
body: in the sidecar

### Amend decision: relevance-scoped-queue-gate
body: in the sidecar

### New decision: generated-catalog-tocs
body: in the sidecar

### New decision: sprint-goal-read-from-the-repository
body: in the sidecar

### New decision: administration-is-a-user-act
body: in the sidecar

### New decision: open-refuses-an-occupied-workspace
body: in the sidecar

### Retire concept: content-addressed-tag
### Retire decision: content-addressed-src-tag
### Retire story: content-addressed-artifacts

### New decision: per-run-artifact-tag
body: in the sidecar

### New story: fresh-artifacts-per-run
body: in the sidecar

### Amend concept: annotation
body: in the sidecar

### Amend concept: assessment
body: in the sidecar

### Amend concept: assumption
body: in the sidecar

### Amend concept: catalog-toc
body: in the sidecar

### Amend concept: cheatsheet
body: in the sidecar

### Amend concept: citation-tag
body: in the sidecar

### Amend concept: completion-contract
body: in the sidecar

### Amend concept: completion-report
body: in the sidecar

### Amend concept: concept-artifact
body: in the sidecar

### Amend concept: conduct
body: in the sidecar

### Amend concept: corpus-delta
body: in the sidecar

### Amend concept: decision-artifact
body: in the sidecar

### Amend concept: design-corpus
body: in the sidecar

### Amend concept: document-type
body: in the sidecar

### Amend concept: documentation-corpus
body: in the sidecar

### Amend concept: estate
body: in the sidecar

### Amend concept: experiment
body: in the sidecar

### Amend concept: finding
body: in the sidecar

### Amend concept: integration-contract
body: in the sidecar

### Amend concept: issue
body: in the sidecar

### Amend concept: materialized-artifact
body: in the sidecar

### Amend concept: practice
body: in the sidecar

### Amend concept: run-tag
body: in the sidecar

### Amend concept: sketch
body: in the sidecar

### Amend concept: skill
body: in the sidecar

### Amend concept: skill-family
body: in the sidecar

### Amend concept: sprint
body: in the sidecar

### Amend concept: stack-profile
body: in the sidecar

### Amend concept: story-artifact
body: in the sidecar

### Amend concept: subject
body: in the sidecar

### Amend concept: surface-extraction
body: in the sidecar

### Amend concept: surface-intent
body: in the sidecar

### Amend concept: trap
body: in the sidecar

### Amend concept: true-up
body: in the sidecar

### Amend concept: workspace
body: in the sidecar

(The thirteen amended decisions after the first three, the new
`per-run-artifact-tag` decision, and the four other new decisions
re-home commitments the concept sweep removed. Each amended decision
differs from the live file by the Choice sentences it gains — one to
three — and, where needed, the Rationale sentences that back them.
The three retirements and the new `fresh-artifacts-per-run` story
are already applied in the tree — commit `b61e166` — and the amended
`run-tag`, `workspace`, and `materialized-artifact` concepts are
among the concept deltas. The sprint carries them to grant the
corpus's authorization retroactively; for those four, execution
verifies file equality and builds nothing. `per-run-artifact-tag`
exists live but its sidecar body adds the re-homed commitments, so
execution applies it like any other delta. Each of the 35 concept bodies in the sidecar is the
concept's complete file with its `## Invariants` section removed and
every sentence stating a requirement, prohibition, guarantee,
mechanism, constant, command, or instance taken out of `What it is`,
`Purpose`, and `Boundaries`.)

## Work items

Flat and unordered. Each names the artifacts it makes true.

- **Concept definition and template** (`concept-artifact`,
  `adversarial-implementation-audits`). In
  `skills/_shared/artifact-definitions.md`, rewrite
  `{{CONCEPT-DEFINITION}}` to: a concept is a load-bearing noun the
  system traffics in; a reviewer who meets the noun in code needs its
  definition to read the code; a concept defines — it does not
  guarantee, forbid, or decide; it says what kind of thing exists,
  what it is for, and where it ends against its neighbors; it says
  nothing about implementation — no instance (a verb, a library, a
  file extension, a route, a wire identifier, a license, a constant,
  a command), no mechanism, no requirement, no prohibition; instances
  and mechanisms belong in code or, where a tradeoff picked them, in
  a decision, and a promise to a user belongs in a story; one concept
  per file. Remove the `## Invariants` section from
  `{{CONCEPT-TEMPLATE}}`. Sweep every other site that names the
  section or describes concepts as carrying invariants:
  `skills/discover-design/SKILL.md` (extraction and sign-off rules),
  `scripts/ok-planner-CLAUDE.md` ("boundaries, and invariants"),
  `ceremony/plan-sprint.md` (the surfacer's "Invariants and
  Boundaries"), and the family `CLAUDE.md`. Re-materialize the
  project copies by converge.

- **Sign-off compliance reviewer enforces concept form**
  (`concept-artifact`). In
  `skills/_shared/design-doc-compliance-reviewer.md`, transclude
  `{{CONCEPT-DEFINITION}}` beside the story and decision definitions
  and add a "Concept form" block enforced on every in-scope concept:
  the body is `What it is`, `Purpose`, `Boundaries`, and optionally
  `Aliases` — an `## Invariants` section or any other section is a
  violation; a sentence that states a requirement, a prohibition, a
  guarantee, a mechanism, a constant, a command, or an instance is a
  violation whose fix is to remove it or move it to the decision or
  story that owns it; an alias not live in code or prose is a
  violation. Update the reviewer's preamble line listing what it
  transcludes.

- **Audit reads a concept as vocabulary**
  (`adversarial-implementation-audits`). In `ceremony/audit.md` and
  `skills/_shared/implementation-auditor.md`, replace the concept
  support axis — "Invariants read against the code" and "a concept's
  decidable claims are its Invariants and Boundaries" — with the
  vocabulary reading: the concept has one live name, and the sites
  that cite it and the code around them agree with `What it is` and
  `Boundaries`; `Purpose` carries no determination. The compliance
  axis for a concept reads the new concept form.

- **Apply the concept sweep** (`concept-artifact`). Copy the 35
  concept bodies from the sidecar into `.ok-planner/design/concepts/`
  and regenerate `.ok-planner/design/concepts.md` per
  `discover-design`'s catalog-TOC step. Run the sign-off compliance
  reviewer over the applied concepts once as a check that the new
  "Concept form" block passes them.

- **Prose hook binds files only** (`steering-over-prose-lint`). In
  `families/ok-plumbline/scripts/hooks/post-edit.js`, drop "the Bash
  command text" as a written source: a Bash call contributes only the
  files it changed under the project root (found through the start
  marker). Flip the three proofs in `test/run.sh` that assert a commit
  message or a heredoc command is flagged to assert it is not, and
  keep the proofs that a heredoc's target file is flagged. Reword
  the reminder and the Stop instruction to "every sentence you wrote
  in these files". Update the cheatsheet, `README.md`,
  `admin/ADMINISTRATION.md`, and `docs/integration-contract.md` where
  they name the command-text detection. Re-materialize by converge.

- **Retirement band** (`team-execution-cold-gate`). In
  `skills/_shared/dispatch-discipline.md`, rewrite the worker-pool
  rule's retirement bullet: a worker retires at an item boundary
  carrying roughly 300k–500k tokens of measured context on a 1M-token
  window, scaled on a smaller window; at each boundary the session
  projects the next item's cost and hands it over only when the
  worker will still retire inside the band. In
  `skills/_shared/sprint-document.md`, the Retirement bullet cites
  that band instead of the fixed ~300k threshold. Sweep the same
  sentence in `scripts/ok-planner-CLAUDE.md`, the cheatsheet, and the
  family `CLAUDE.md`.

- **Two reviewer instruments in the code-review brief**
  (`team-execution-cold-gate`, `test-quality-by-review`). In
  `{{CODE-REVIEW-BRIEF}}` in `skills/_shared/certification-core.md`:
  under the testing-standard bullet, name the three elapsed-time
  shapes that escape a fixed detector — an elapsed-time comparison
  inside an assertion, a timeout context feeding a call whose success
  the test asserts, a timer whose firing changes the outcome — with
  the one judgment rule (a deadline that is the input under test is
  fine; a deadline whose expiry decides pass or fail is a finding);
  and add a bullet: for any test suite the change did not run, `rg`
  for assertions about the behavior the change altered and read
  whether the change falsifies them — a finding where it does.
  Phrase both project-agnostically. The standing reviewer inherits
  them through the shared brief.

- **Ledger sidecar** (`team-execution-cold-gate`). In the relay
  protocol beside `{{STANDING-REVIEWER-PROMPT}}` in
  `skills/_shared/certification-core.md` and in step 3 of
  `skills/_shared/sprint-document.md`: on every relay the session
  writes the reviewer's open ledger and the open claimed forks to
  `<sprint-name>-ledger.md` beside the completion report; a
  replacement session and a replacement reviewer read it from disk.
  Narrow "during the build it edits nothing" to "during the build it
  edits no file a worker owns" in `sprint-document.md`, the worker-pool
  rule, `scripts/ok-planner-CLAUDE.md`, the cheatsheet, and the family
  `CLAUDE.md`. The gate's close-out archives the ledger file with the
  sprint; name it in the archival step and in the goal rule's
  exclusions (it is no term of the contract).

- **Monitor-based liveness** (`team-execution-cold-gate`). In the
  worker-pool rule's "Quiet is not finished" bullet in
  `skills/_shared/dispatch-discipline.md`: where the harness offers a
  file monitor, the session arms one on each worker's output and
  takes its trip as the liveness signal; it never polls by hand.

- **Family test suites follow.** Every assertion in
  `families/ok-planner/test/stories.sh` and
  `families/ok-plumbline/test/run.sh` that reads a changed prompt
  block or hook behavior is updated with the change; both suites
  pass.

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
   one line per stage naming the work items it groups, each marked
   pending. Seed the closing stages
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
     each landed stage's paths and the work items it lands. It reads
     the increment under the certification gate's code-review brief
     — findings reach anywhere in the tree the increment breaks —
     and the gate's alignment questions scoped to the stage's own
     items and deltas, plus the read-only per-stage producers each
     present family's ceremony contribution names under **Standing
     producers**, keeps a ledger of open findings, and replies with
     the ledger. It reports each claimed
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
