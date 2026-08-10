# Sprint: The public-surface partition and the user-vantage audit

## Intent

Restructure the suite's release-measurement machinery around an
owner-ruled public surface. The public surface becomes a total
partition — every enumerated element ruled public or private by
owner-maintained guidance prose, no default, nothing invisible — and
the audit becomes its front door: it opens by settling the partition
with the owner where anything is unsettled, verifies story support
from the user's side by driving the release through the public surface
on a maintained experiment harness, and keeps the adversarial reading
for decisions and concepts. The documentation ceremony consumes the
audit instead of re-measuring, and its shipped corpus speaks only in
concepts, stories, and public surface elements — code-path citations
and test references retreat to the internal verification layer.

No issues are promoted into this sprint; the intake is empty.

## Corpus deltas

### New concept: surface-guidance

body: in the sidecar
(`2026-08-09-public-surface-partition-deltas/concepts/surface-guidance.md`)

### New concept: surface-ruling

body: in the sidecar
(`2026-08-09-public-surface-partition-deltas/concepts/surface-ruling.md`)

### Amend concept: surface-declaration

body: in the sidecar
(`2026-08-09-public-surface-partition-deltas/concepts/surface-declaration.md`)

### Amend concept: assessment

body: in the sidecar
(`2026-08-09-public-surface-partition-deltas/concepts/assessment.md`)

### Amend concept: assumption

body: in the sidecar
(`2026-08-09-public-surface-partition-deltas/concepts/assumption.md`)

### Amend concept: experiment

body: in the sidecar
(`2026-08-09-public-surface-partition-deltas/concepts/experiment.md`)

### Amend concept: documentation-corpus

body: in the sidecar
(`2026-08-09-public-surface-partition-deltas/concepts/documentation-corpus.md`)

### Amend concept: trap

body: in the sidecar
(`2026-08-09-public-surface-partition-deltas/concepts/trap.md`)

### New story: rule-the-public-surface

body: in the sidecar
(`2026-08-09-public-surface-partition-deltas/stories/rule-the-public-surface.md`)

### New decision: user-vantage-story-audits

body: in the sidecar
(`2026-08-09-public-surface-partition-deltas/decisions/user-vantage-story-audits.md`)

### New decision: owner-guided-surface-partition

body: in the sidecar
(`2026-08-09-public-surface-partition-deltas/decisions/owner-guided-surface-partition.md`)

### Amend decision: affirmative-warrant-ladder

body: in the sidecar
(`2026-08-09-public-surface-partition-deltas/decisions/affirmative-warrant-ladder.md`)

### Amend decision: full-reassessment-per-release

body: in the sidecar
(`2026-08-09-public-surface-partition-deltas/decisions/full-reassessment-per-release.md`)

### Amend decision: document-composes-audit

body: in the sidecar
(`2026-08-09-public-surface-partition-deltas/decisions/document-composes-audit.md`)

### Amend decision: documentation-citations-are-product

body: in the sidecar
(`2026-08-09-public-surface-partition-deltas/decisions/documentation-citations-are-product.md`)

### Amend decision: cold-boxed-synthesis

body: in the sidecar
(`2026-08-09-public-surface-partition-deltas/decisions/cold-boxed-synthesis.md`)

### Amend decision: audit-audience-split

body: in the sidecar
(`2026-08-09-public-surface-partition-deltas/decisions/audit-audience-split.md`)

### Amend decision: adversarial-implementation-audits

body: in the sidecar
(`2026-08-09-public-surface-partition-deltas/decisions/adversarial-implementation-audits.md`)

## Work items

- **Restructure the audit ceremony body**
  (`plugins/ok/ceremonies/audit/SKILL.md`). Makes true:
  `user-vantage-story-audits`, `owner-guided-surface-partition`,
  `adversarial-implementation-audits`, `corpus-audit`,
  `rule-the-public-surface`. Outcome: the audit opens with the surface
  determination — run the declared enumerators, produce the extraction,
  diff it against the cached extraction from the last ruling, detect
  unratified guidance changes by anchor comparison (sprint-carried
  changes acknowledged, ad hoc ones walked), apply the guidance to
  classify every element, walk unsettled elements with the owner and
  land every answer in the guidance, then write the stamped surface
  ruling. A settled partition and ratified guidance pass the opening
  silently, so cadence runs stay hands-free. Story support is then
  determined by re-running, repairing, and extending the experiment
  harness through the ruled public surface; decision and concept
  support by adversarial reading as today. The judge stage, issue
  discipline, and stamped outputs remain; the body documents the
  output-path staleness rule consumers use.

- **Amend the documentation ceremony body**
  (`plugins/ok/ceremonies/document/SKILL.md`). Makes true:
  `document-composes-audit`, `documentation-citations-are-product`,
  `full-reassessment-per-release`, `document-a-release`,
  `answer-absence-from-catalogs`. Outcome: the ceremony opens by
  ensuring a current audit (the path-scoped diff rule; otherwise run
  `/audit`), consumes its determinations and ruling, synthesizes
  assumptions in the unchanged box from the delivered stories, the
  public surface, and the prior corpus, verifies assumptions with the
  same user-vantage harness machinery, and produces the split corpus:
  publishable records in shipped vocabulary citing catalog rows at the
  stamp, verification records internal. The porch and surface phases
  move out (now the audit's); the presentation and NOT-do list are
  updated to match.

- **Amend the ok-planner audit ceremony surface**
  (`plugins/ok/families/ok-planner/ceremony/audit.md`). Makes true:
  `owner-guided-surface-partition`, `user-vantage-story-audits`.
  Outcome: the surface names the estate homes and record shapes — the
  surface declaration and guidance under `.ok-planner/surface/`
  (`surface.json`, `guidance.md`), the ruling and cached extraction
  under `.ok-planner/audits/surface/`, the experiment harness under
  `.ok-planner/experiments/` — plus the ruling's two anchors (release
  commit, guidance blob hash), the ratification walk, and the story
  audit's experiment protocol.

- **Amend the ok-planner document ceremony surface**
  (`plugins/ok/families/ok-planner/ceremony/document.md`). Makes true:
  `documentation-citations-are-product`, `document-composes-audit`.
  Outcome: the surface pins the split-corpus layout under
  `.ok-planner/documentation/`, the shipped-vocabulary rule and
  catalog-row citation form for publishable records, the export set
  for the box, and the harness reuse for assumption verification.

- **Amend the ok-planner plan-sprint ceremony surface**
  (`plugins/ok/families/ok-planner/ceremony/plan-sprint.md`). Makes
  true: `owner-guided-surface-partition`. Outcome: drafting includes
  the predictive classification test — would the surface this work
  introduces be claimed by the existing guidance? Claimed passes
  silently; unclaimed is raised with the owner as one prose question,
  and the answer rides the sprint as a guidance-document edit. Stories
  carry the public-by-construction prior, so only genuine ambiguity
  reaches the owner.

- **New reconciliation tool**
  (`plugins/ok/families/ok-planner/scripts/surface-reconcile`,
  materialized to `.ok-planner/bin/surface-reconcile`). Makes true:
  `owner-guided-surface-partition`, `rule-the-public-surface`.
  Outcome: a deterministic python tool that reads the declaration,
  runs each kind's enumerator, writes the extraction, diffs it against
  the ruling's cached extraction, and reports per element: classified
  public, classified private, or unclaimed — plus the guidance-anchor
  comparison (current guidance hash vs the ruling's recorded one).
  Exit codes distinguish settled (0) from unclaimed-or-unratified (2)
  from error (1). No node; stamped like the other materialized
  payloads; no design-corpus annotations in the vendored script.

- **Extend audit-check with ruling validation**
  (`plugins/ok/families/ok-planner/scripts/audit-check` and its
  harness `test/run.sh`). Makes true: `owner-guided-surface-partition`.
  Outcome: audit-check validates the surface ruling where one exists —
  both anchors present, the partition total against the cached
  extraction (no unclassified member), the guidance hash agreeing with
  the guidance file as of the stamped commit — with fixture coverage
  in the harness.

- **Amend document-check for the split corpus**
  (`plugins/ok/families/ok-planner/scripts/document-check` and its
  harness `test/document-check.sh`). Makes true:
  `documentation-citations-are-product`,
  `affirmative-warrant-ladder`. Outcome: publishable records
  (catalog, assessments, traps) are gated on shipped vocabulary —
  citations resolve against the ruling's catalog at the stamp, and a
  `src:` tree-path citation in a publishable record is a finding;
  `held` requires an `experiment:` warrant (the `test:` warrant form
  is retired); verification-layer records keep the resolve-in-tree
  check. Harness fixtures updated to the new rules.

- **Update the shared auditor prompts**
  (`plugins/ok/families/ok-planner/skills/_shared/implementation-auditor.md`
  and related `_shared/` transclusions). Makes true:
  `user-vantage-story-audits`, `adversarial-implementation-audits`.
  Outcome: the story auditor's protocol is the user-vantage
  measurement — drive the release through the ruled public surface via
  the harness, never settle a story by reading or by citing a test —
  while decision and concept auditor protocols stay reading-based; the
  judge's inputs describe both instruments.

- **Converge and administration updates**
  (`plugins/ok/families/ok-planner/admin/converge`,
  `plugins/ok/admin/`, `plugins/ok/test/administration.sh`). Makes
  true: `owner-guided-surface-partition`. Outcome: the converge core
  materializes `surface-reconcile` into `.ok-planner/bin/` beside the
  other checkers, diagnose detects it, and the administration test
  asserts its presence and executability.

- **Template and cheatsheet teaching**
  (`plugins/ok/families/ok-planner/scripts/ok-planner-CLAUDE.md`,
  `scripts/ok-planner-cheatsheet.md`). Makes true:
  `rule-the-public-surface`, `owner-guided-surface-partition`,
  `user-vantage-story-audits`. Outcome: the materialized estate
  CLAUDE.md and cheatsheet teach the surface structure (declaration,
  guidance, ruling), the total-partition rule, the restructured
  audit's three determinations, and the split documentation corpus —
  replacing the prior descriptions.

- **Suite documentation sweep** (`plugins/ok/CLAUDE.md`,
  `plugins/ok/families/ok-planner/CLAUDE.md`,
  `docs/integration-contract.md`, `README.md`,
  `plugins/ok/skills/ok/SKILL.md` where they describe the audit or
  documentation ceremonies). Makes true: `corpus-audit`,
  `document-a-release`. Outcome: every place the repo describes the
  two ceremonies reflects the restructure — audit as three
  determinations with the surface front door, document as consumer of
  the audit producing the split corpus.

- **Refresh the design-corpus TOCs**
  (`.ok-planner/design/{concepts,stories,decisions}.md`). Outcome:
  entries added for the new artifacts and updated for amended
  one-liners, alphabetical, matching the applied deltas.

Dependencies, stated as such: the check work (audit-check,
document-check) and the auditor-prompt work consume the record shapes
the two ceremony surfaces pin — whoever executes should settle the
surface files' shapes before or together with them. The converge item
consumes the reconciliation tool's existence.

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
