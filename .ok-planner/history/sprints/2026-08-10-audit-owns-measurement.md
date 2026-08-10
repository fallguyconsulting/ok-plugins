---
closed: 377cfa1fb52aaaf8b3aa8debab0861a552f42475
---
# Sprint: The audit owns measurement

## Intent

Rebuild the audit around the owner's rulings of 2026-08-10: surface
extraction becomes agentic, hierarchical, and pruned by guidance
notations, retiring mechanical enumerator commands and dissolving the
surface-inventory sweep; assumption synthesis and verification move
from `/document` into `/audit`, making the audit the suite's entire
measurement front and `/document` a construction over its records;
the Determine stage becomes a message-fed worker pool with measured
context retirement; the run writes a report record and presents
conditionally on its caller; a vendored goal file lets an owner drive
the post-walk run with `/goal`; and the vocabulary is repaired —
"harness" struck for **the experiments**, "nomination" replacing
"promotion" for canonizing an experiment, "surface" reserved for the
public-surface partition alone. The reconciliation walk also ratified
the out-of-band conduct edit (the technical-writing standard as a
session-wide channel), carried here as deltas and a version-bump work
item.

Issues promoted into this sprint:
`surface-inventory-runs-after-the-partition-it-should-inform`.

## Corpus deltas

### Amend decision: owner-guided-surface-partition

body: in the sidecar

### Amend concept: surface-declaration

body: in the sidecar

### Amend decision: cold-boxed-synthesis

body: in the sidecar

### Amend decision: document-composes-audit

body: in the sidecar

### Amend decision: full-reassessment-per-release

body: in the sidecar

### Amend concept: assumption

body: in the sidecar

### Amend concept: experiment

body: in the sidecar

### Amend decision: audit-audience-split

body: in the sidecar

### Amend decision: user-vantage-story-audits

body: in the sidecar

### Amend decision: affirmative-warrant-ladder

body: in the sidecar

### Amend decision: adversarial-implementation-audits

body: in the sidecar

### Amend decision: steering-over-prose-lint

body: in the sidecar

### Amend concept: documentation-corpus

body: in the sidecar

### Amend concept: skill-family

body: in the sidecar

### Amend concept: integration-contract

body: in the sidecar

### Amend concept: skill

body: in the sidecar

### Amend concept: true-up

body: in the sidecar

## Work items

Each item names the artifacts it makes true and describes the
outcome. Real dependencies are stated inline; there is no order
beyond them.

- **Rewrite the audit ceremony body** at
  `plugins/ok/ceremonies/audit/SKILL.md`. The orchestrator's role is
  declared at the top — you orchestrate, you file nothing of your own
  motion, everything you would tell the owner goes in the run
  report — and the spine becomes: resolve estates and subject;
  opening surface determination (agentic extraction with candidate
  discovery feeding the walk — no step-8 sweep exists anywhere);
  story determinations; cold-boxed assumption synthesis; assumption
  determinations; decision/concept determinations (these reading
  tracks run in parallel with the measurement tracks); one terminal
  judge over every escalation — non-supported determinations, corpus
  contradictions from extraction, and the orchestrator's own driving
  observations; distillation filing only nominations; Check
  (audit-check); Verify (verify-issues on filings); write the run
  report to `history/audits/<date>-<sha>-report.md`; commit
  everything, stamp in the follow-on; present from the report only
  when invoked à la carte, silently otherwise. The Determine stages
  use the worker pool where the harness has cross-agent messaging (N
  workers per instrument, fed one artifact at a time, locality-routed,
  each writing its audit file per item; retire a worker when it
  finishes an item and its last round exceeded ~300k measured from the
  task notification's `subagent_tokens` — per-request, not
  cumulative, threshold scaled to the model window — spawning a
  replacement to hold N; a quiet worker is a liveness problem, not a
  retirement), with bounded batches as the fallback: stories and
  assumptions grouped by driven surface elements, decisions and
  concepts by code locality, five to ten per batch, split when the
  shared reading set exceeds what one agent can genuinely hold.
  Absorbs and supersedes the uncommitted pre-session edits to this
  file. Makes true: decision:owner-guided-surface-partition,
  decision:cold-boxed-synthesis, decision:audit-audience-split,
  decision:user-vantage-story-audits, story:corpus-audit.

- **Rewrite the ok-planner audit ceremony contribution** at
  `plugins/ok/families/ok-planner/ceremony/audit.md` (and its
  materialized copy path). Carries: the agentic extraction protocol
  (hierarchical walk from code and deploy config, pruning at guidance
  notations, novelty and drift to the opening walk, member lists
  re-derived and diffed, candidate kinds proposed at the walk);
  the assumption record shape and home
  (`.ok-planner/audits/assumptions/`, story-shaped, disposition
  held/trap/unverified); the judge asymmetry (story gap files, trap
  disposition records, story-violation crossover); nomination filing
  through the intake; the run-report shape (receipt facts plus run
  narrative); worker prompts for both instruments. The
  surface-inventory sweep section is deleted; its corpus-contradiction
  check becomes an ordinary judge escalation from extraction. Absorbs
  and supersedes the uncommitted pre-session edits to this file.
  Makes true: decision:owner-guided-surface-partition,
  concept:surface-declaration, concept:assumption,
  decision:audit-audience-split.

- **Slim the document ceremony** — body at
  `plugins/ok/ceremonies/document/SKILL.md` and contribution at
  `plugins/ok/families/ok-planner/ceremony/document.md`: `/document`
  ensures a current audit, then constructs — catalog projection over
  the ruling, assessments from determinations, trap registry from
  assumption dispositions, the publishable/verification split, the
  mechanical gates — and measures nothing; no synthesis, no
  experiments, no box. Its wrap-up reads the audit's run report as an
  input and covers both ceremonies when it invoked the audit. Makes
  true: decision:document-composes-audit,
  decision:full-reassessment-per-release,
  concept:documentation-corpus, story:document-a-release.

- **Surface machinery**: the declaration schema drops per-kind
  enumerator commands and the `derivation`/`reads`-as-exception
  marker (each kind names what its derivation reads; member lists at
  `.ok-planner/surface/members/<kind>` are universal);
  `.ok-planner/bin`'s `surface-reconcile` reads the new shape and
  reports member-list state and diffs; `audit-check` gains the
  assumption corpus (coverage, shape, dispositions) and the run
  report's presence at close, and keeps the ruling checks. Test
  fixtures updated with the schema. Makes true:
  concept:surface-declaration, story:rule-the-public-surface.

- **Goal files**: new payload files materialized by converge to
  `.ok-planner/ceremony/audit-goal.md` and
  `.ok-planner/ceremony/document-goal.md` — each a two-reader brief:
  the driving agent's role and post-walk course as pointers to the
  vendored skill and ceremony contributions, and the checker's goal
  rule (met: corpora complete per estate, assumptions regenerated,
  audit-check clean, report at its history path, both commits landed,
  stamps present; met despite: issues filed, non-supported
  determinations standing, findings unfixed; not met: check failing,
  stamp missing, report absent; guard: an unsettled partition means
  the goal was set too early — say so and stop). The audit skill's
  à la carte walk ends by handing the owner the one-line `/goal`
  paste. Converge materializes both; administration document notes
  them. Makes true: decision:no-execution-engine (the goal-driving
  path), story:corpus-audit.

- **Dispatch discipline**: `_shared/dispatch-discipline.md` gains the
  worker-pool section (spawn-feed-retire, the measured-context
  retirement rule, the messaging-availability fallback), and
  `_shared/implementation-auditor.md` is shaped for per-item feeding
  as well as batch dispatch. Makes true:
  decision:adversarial-implementation-audits.

- **Vocabulary sweep** across the carried payload and templates —
  skills, ceremony bodies, administration documents, cheatsheet
  template, estate CLAUDE.md template, artifact definitions: the
  experiment collection is **the experiments** (no "harness" in that
  sense; "harness" remains only for the Claude Code harness and
  project test harnesses); **nomination** replaces "promotion" for
  experiments entering the suites ("promotion" remains the issue
  lifecycle's word); **ceremony contribution** replaces "ceremony
  surface" and **administration files** replaces "administration
  surfaces" ("surface" is the public-surface partition's word alone).
  Makes true: concept:skill, concept:skill-family,
  concept:integration-contract, concept:true-up, concept:experiment.

- **Conduct version bump**: `plugins/ok-conduct/output-styles/`
  `ok-conduct.md` body changed (the technical-writing section, already
  in the tree, ratified by this sprint) — bump `Conduct version:` to
  1.12.0 with the next release name, and mirror wherever the version
  echoes (session-start hook, `/ok-version` expectations). Makes
  true: concept:conduct, decision:steering-over-prose-lint.

- **Suite tests**: `plugins/ok/test/` updated for the new audit
  shape — administration fixtures for the goal files, audit-check
  fixtures for the assumption corpus and report, and removal of any
  fixture asserting the sweep, the enumerator commands, or the
  derivation marker. Makes true: story:corpus-audit,
  story:rule-the-public-surface.

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
