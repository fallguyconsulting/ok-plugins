---
closed: d2bcbb3
---

# Sprint: Team execution and test standards

## Intent

Three changes to how the suite executes and certifies work, plus the
corpus catching up with work done out of band since the last closed
sprint. First, sprint execution becomes a team the session relays —
a builder and a standing reviewer — so review happens as each stage
lands and the terminal certification passes cold in one cycle.
Second, the harness task list returns as a mirror of the completion
report's stages. Third, plumbline gains a testing standard and an
events standard, both enforced by code review during the build and
at the gate, never by lint or audit, with a read-only event-kind
inventory. The reconcile deltas admit the document audience, the
retired experiment nomination, the subagent-model rule, and the
stop-time prose review. No issues were promoted into this sprint.

## Corpus deltas

### New decision: team-execution-cold-gate

body: in the sidecar

### New decision: test-quality-by-review

body: in the sidecar

### New decision: event-kinds-as-conventioned-strings

body: in the sidecar

### New decision: subagent-model-follows-job

body: in the sidecar

### New decision: task-tools-mirror-the-report

body: in the sidecar

### New story: watch-execution-progress

```markdown
---
story: watch-execution-progress
---

# Watch a running sprint's progress in the session

## Story

As a project owner, I want the stages of a running sprint shown as a
live checklist in my session, each marked as it lands, so that I can
follow a long run without opening the completion report.

```

### New story: review-tests-against-the-standard

```markdown
---
story: review-tests-against-the-standard
---

# Tests are reviewed for substance and for the testing standard

## Story

As a project owner, I want every test a sprint writes reviewed —
for what it proves, and for reaching its verdict independent of
elapsed time — before the work is certified, so that my suites grow
only where a behavior needs proving and pass the same on a loaded
machine as on an idle one.

```

### New story: inventory-event-kinds

```markdown
---
story: inventory-event-kinds
---

# List every event kind the code emits

## Story

As a project owner, I want every event kind my code emits listed
with the sites that emit it and the tests that wait on it, so that I
can prune stale kinds and reuse an existing kind instead of adding a
near-duplicate.

```

### Amend concept: sprint

body: in the sidecar

### Amend concept: completion-report

body: in the sidecar

### Amend concept: document-type

body: in the sidecar

### Amend concept: experiment

body: in the sidecar

### Amend decision: audit-audience-split

body: in the sidecar

### Amend decision: document-composes-audit

body: in the sidecar

### Amend decision: owner-guided-surface-partition

body: in the sidecar

### Amend decision: steering-over-prose-lint

body: in the sidecar

## Work items

- **Sprint execution boilerplate.** Rewrite the "How to execute this
  sprint" section in `plugins/ok/families/ok-planner/skills/_shared/sprint-document.md`
  so an executor runs the team: the session as relay that edits
  nothing; one builder fed a stage per message that writes, tests
  what it built, keeps the report, and fixes the standing reviewer's
  findings; one standing reviewer fed each landed stage's paths;
  retirement only at a stage boundary once measured context passes a
  threshold below the compaction window, the replacement builder
  reading the sprint and the report; the builder recording every
  determined call as a divergence and every unsettled fork with its
  options; code complete as "the built work works", with
  `/certify-work` running immediately after as the regression; and
  "use the task tools, if available" — one task per stage mirroring
  the report's staged list, the report remaining the record. Where
  the harness offers no messaging, the section says how a single
  session runs the same shape in bounded batches. Makes true:
  `team-execution-cold-gate`, `task-tools-mirror-the-report`,
  `watch-execution-progress`.
- **Standing reviewer brief.** Add to `certification-core.md` a shared
  block for the standing reviewer that wraps `{{CERTIFY-CODE-REVIEW-PROMPT}}`
  with a per-stage scope stanza (paths only, the increment read in
  the context of the change so far, findings confined to the increment
  and what it breaks), a finding ledger the reviewer re-checks on
  every message, and the read-only per-stage producers each present
  ceremony contribution names. Each family's `ceremony/certify-work.md`
  gains a "Standing producers" heading: ok-planner names annotation
  integrity; ok-plumbline names practice citation reading;
  ok-workspaces names none. `docs/integration-contract.md` documents
  the heading. Makes true: `team-execution-cold-gate`.
- **Certification core reads the report and reviews tests and events.**
  In `certification-core.md`: the sprint-alignment judge reads the
  completion report's divergences and claimed forks — each divergence
  under the veto test, each claimed fork routed to the architect; the
  architect prompt takes claimed forks beside kickbacks; the
  presentation's Divergences section merges the executor's recorded
  calls with the fixer's; the code-review prompt gains a Tests focus
  (substance first — substantive or specious, proves what something
  owes, extend an existing test or stand alone, suite growth only
  where a behavior needs proving; then the testing standard) and an
  Events focus (coverage at the named sites, declared-convention
  kinds, uniqueness of meaning, a caught error that emits nothing is a
  finding). Makes true: `team-execution-cold-gate`,
  `test-quality-by-review`, `review-tests-against-the-standard`,
  `event-kinds-as-conventioned-strings`.
- **Dispatch discipline for builders.** Refine `{{WORKER-POOL-RULE}}`
  in `dispatch-discipline.md`: retire only at an item boundary; hold
  the threshold below the compaction window; a builder's hand-off is
  the sprint plus the completion report on disk, a reviewer's is the
  open ledger the session holds; the session relays and never edits.
  Makes true: `team-execution-cold-gate`, `subagent-model-follows-job`.
- **Testing standard.** Author `plugins/ok/families/ok-plumbline/docs/testing.md`
  under the writing standard; the converge core materializes it to
  `.ok-plumbline/docs/testing.md`; rewrite the cheatsheet's Testing
  section (`docs/plumbline-cheatsheet.md` and its materialized copy)
  as the ambient copy, dropping the co-location and no-shared-fixture
  lines and pointing at the full standard. Makes true:
  `test-quality-by-review`, `review-tests-against-the-standard`.
- **Events standard.** Author `plugins/ok/families/ok-plumbline/docs/events.md`
  likewise, materialized to `.ok-plumbline/docs/events.md`, with a
  cheatsheet section as its ambient copy: the coverage sites, the
  kind-plus-fields shape, the dotted-namespace convention, prose only
  in a field, what stays the project's. Makes true:
  `event-kinds-as-conventioned-strings`.
- **`/events` skill.** A new read-only ok-plumbline skill in the shape
  of `/patterns`: one regex over the tree for the convention; every
  kind with its sites, split by the project's test-path convention
  (declared in `.ok-plumbline/config.json`, defaulting to common test
  path patterns); format violations listed; kinds referenced only
  from test files called out as orphans; kinds referenced nowhere
  listed as the pruning list, never a finding. Vendored by the
  family's converge core like its siblings; slash-only activation in
  the description. Makes true: `inventory-event-kinds`,
  `event-kinds-as-conventioned-strings`.
- **`/ok` offers the task tools.** The front door's converge core
  reports a missing `env.CLAUDE_CODE_ENABLE_TODO_TOOLS` in
  `.claude/settings.json` as a `WIRING NEEDED` block beside the hook
  entry, with the exact entry and consent command; the owner's yes
  transcribes it; declined is recorded and nothing is written.
  `plugins/ok/admin/ADMINISTRATION.md` names it as the second
  consented settings entry. Makes true: `task-tools-mirror-the-report`,
  `watch-execution-progress`.
- **Restate the execution shape where it is described.** The
  `.ok-planner/CLAUDE.md` template, `scripts/ok-planner-cheatsheet.md`,
  the ok cheatsheet, `plugins/ok/CLAUDE.md`, and
  `plugins/ok/families/ok-planner/CLAUDE.md` describe execution as the
  team and certification as the cold gate that follows. Makes true:
  `team-execution-cold-gate`.

Dependencies: the standing reviewer brief and the certification core
item both edit `certification-core.md`; the testing and events
standards precede the code-review focus text that names them. Every
reconcile delta applies on its own. The stories are realized in skill
prose and carry no test.

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
   archive-and-commit. Mark each stage done as it lands. The list
   lives in the report only: not in a harness task tool, never in a
   plan document.
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
   prose carries no test. Write the tests with the work. Leave
   `.ok-planner/audits/` and `.ok-planner/experiments/` untouched:
   only a running `/audit` reads or writes them, and they record
   behavior at the time of the audit. An experiment the work breaks
   stays broken until the next run repairs or retires it.

5. Completeness is the floor. Never stub, defer, narrow, no-op, or
   leave a `TODO` in place of a promised outcome. Deliver every
   capability the deltas or work items promise in full, or surface
   the blocker that prevents it.

6. Never destroy uncommitted work. Stage the paths you touched as
   each stage finishes (`git add <paths>`). Never run `git checkout`/
   `restore`/`reset`/`stash`/`clean` on your own initiative. Fix a bad
   edit forward by editing again.

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
