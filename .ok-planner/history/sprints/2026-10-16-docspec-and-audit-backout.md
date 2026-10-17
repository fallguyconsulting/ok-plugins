---
closed: df2a178ac1ea3db6f64edca01fca460c37f43e39
---

# Sprint: Back out the audit, add docspecs, and true up the whole estate

## Intent

This sprint has no single theme. Its main work backs `/audit` and
`/document` out of the suite, retires every artifact and estate folder
they alone used, and replaces release-time documentation with
docspecs: owner-declared specs for each kind of documentation a
project maintains, which every sprint's builders keep current as part
of the work and which planning's out-of-band walk covers like code.
The surface intent stays, maintained by sprints, and now names the
files that declare each class of entry point, so `/converge` analysis
mode cuts its flow areas from it on each run. True-up takes the
position that the estate is the skill family's: the skills read only
the current layout, and true-up ports, archives, or removes every
earlier layout's material, under one up-front consent that lets the
owner abort and stay on the current version where any step is
destructive.

The sprint also lands five ruled issues and eight defect issues: one
table of every call the agents made, presented for the owner's veto at
the close; `run-group` lending no terminal; a browser tool for this
project's drivers; true-up filing an issue for an undecodable review
facts file; unread counts that include people's messages; and the
defect fixes below.

This sprint changes the suite only. This project's own docspec and
surface intent wait for a sprint planned after the owner trues the
project up (`readme-docspec-and-surface-intent-unwritten`).

Promoted issues:

- `converge-calls-reach-owner-as-counts`
- `run-group-lends-terminal`
- `surface-extraction-completeness-unrecorded`
- `dashboard-drive-needs-browser-tool`
- `true-up-undecodable-review-facts-skipped`
- `unread-counts-only-agent-messages`
- `checks-oscillation-prose-comments`
- `compliance-reviewer-skips-practice-form`
- `conduct-writing-standard-handoff-and-scope`
- `converge-fix-close-blocked-strands-defects`
- `converge-merge-close-unhandled`
- `converge-review-root-close-unhandled`
- `discover-design-reviewer-cap-unsignalled`
- `review-verifies-skips-declined`

## Corpus deltas

### Amend concept: catalog-toc

body: in the sidecar

### Amend concept: completion-contract

body: in the sidecar

### Amend concept: completion-report

body: in the sidecar

### Amend concept: corpus-delta

body: in the sidecar

### Amend concept: decision-artifact

body: in the sidecar

### Amend concept: design-corpus

body: in the sidecar

### New concept: docspec

body: in the sidecar

### Amend concept: issue

body: in the sidecar

### Amend concept: estate

body: in the sidecar

### Amend concept: practice

body: in the sidecar

### Amend concept: sprint

body: in the sidecar

### Amend concept: story-artifact

body: in the sidecar

### Amend concept: surface-intent

body: in the sidecar

### Amend concept: true-up

body: in the sidecar

### New story: declare-project-documentation

body: in the sidecar

### New story: keep-documentation-current

body: in the sidecar

### New story: reference-names-the-public-surface

body: in the sidecar

### Amend story: rule-the-public-surface

body: in the sidecar

### New story: turn-down-a-destructive-true-up

body: in the sidecar

### Amend decision: administration-is-a-user-act

body: in the sidecar

### Amend decision: analysis-hunts-until-converged

body: in the sidecar

### New decision: intake-writers-are-gated

body: in the sidecar

### Amend decision: discovery-notes-archived-on-consent

body: in the sidecar

### Amend decision: drive-tries-each-story-as-a-user

body: in the sidecar

### Amend decision: final-form-deltas

body: in the sidecar

### Amend decision: foreign-harms-become-upstream-issues

body: in the sidecar

### Amend decision: generated-catalog-tocs

body: in the sidecar

### Amend decision: intake-reads-past-stray-lines

body: in the sidecar

### Amend decision: lockstep-suite-version

body: in the sidecar

### New decision: one-docspec-per-file

body: in the sidecar

### Amend decision: one-vendored-family

body: in the sidecar

### New decision: out-of-band-documentation-reconciled

body: in the sidecar

### Amend decision: per-project-pinning

body: in the sidecar

### Amend decision: per-run-artifact-tag

body: in the sidecar

### Amend decision: practice-violations-are-defects

body: in the sidecar

### Amend decision: project-declares-its-folders

body: in the sidecar

### Amend decision: records-stay-out-of-context

body: in the sidecar

### Amend decision: reference-stack-runs-the-declared-stack

body: in the sidecar

### Amend decision: retired-layout-strips-only-recoverable-files

body: in the sidecar

### Amend decision: runs-fix-what-the-project-owns

body: in the sidecar

### Amend decision: single-source-transclusion

body: in the sidecar

### New decision: skills-read-only-the-current-layout

body: in the sidecar

### Amend decision: slash-only-activation

body: in the sidecar

### New decision: sprints-write-the-documentation

body: in the sidecar

### Amend decision: stack-helpers-serve-project-commands

body: in the sidecar

### Amend decision: subagent-model-follows-job

body: in the sidecar

### New decision: surface-intent-changed-by-sprints

body: in the sidecar

### New decision: surface-intent-is-one-prose-document

body: in the sidecar

### New decision: surface-members-listed-at-need

body: in the sidecar

### Amend decision: tests-forbidden

body: in the sidecar

### New decision: true-up-asks-once-before-destructive-steps

body: in the sidecar

### Amend decision: whole-file-ownership

body: in the sidecar

### Retire concept: assessment

### Retire concept: assumption

### Retire concept: document-type

### Retire concept: documentation-corpus

### Retire concept: experiment

### Retire concept: surface-extraction

### Retire concept: trap

### Retire story: corpus-audit

### Retire story: document-a-release

### Retire story: ship-release-documents

### Retire story: answer-absence-from-catalogs

### Retire story: practice-coverage-report

### Retire story: lint-rules-compliance-report

### Retire decision: adversarial-implementation-audits

### Retire decision: affirmative-warrant-ladder

### Retire decision: cold-boxed-synthesis

### Retire decision: document-composes-audit

### Retire decision: documentation-citations-are-product

### Retire decision: documentation-walk-in-composed-audit

### Retire decision: documents-generated-per-type-and-placed

### Retire decision: full-reassessment-per-release

### Retire decision: owner-guided-surface-partition

### Retire decision: placed-documents-are-records

### Retire decision: user-vantage-story-audits

### Retire decision: audit-audience-split

## Work items

Each work item names the corpus artifacts it makes true. "The family"
means the payload at `plugins/ok/families/ok-planner/`. The vendored
copies under `.claude/` and the materialized files under `.ok-planner/`
are suite-owned: this sprint changes the family, and the owner's next
`/ok` trues this project up to it.

### 1. Remove `/audit` and `/document` from the family

Realizes: the retirement of every audit and documentation artifact
below, and the amended `one-vendored-family`, `slash-only-activation`,
`subagent-model-follows-job`, `single-source-transclusion`.

The family no longer carries the `/audit` and `/document` skills, their
goal files, the `ok-audit` agent profile, or the audit's shared prompt
file. The shared artifact definitions carry no audit definition, no
audit file format, no referral, and no sentence saying the audit
verifies a story or a decision; the decidability boundary still tells
a drafter to write the concrete version of a qualitative clause, and
says nothing of how an audit rules on one. The plan-sprint compliance
reviewer's text names no audit. The lint has no `patterns` subcommand,
since its only caller was the audit's lint sweep. No skill, prompt,
script, or check in the family names `/audit`, `/document`, an audit
record, an experiment, an assumption, a trap, an assessment, the
documentation corpus, a document type, or the surface extraction,
save the retired-verb table and true-up's migration of the retired
layout (work item 5). `/plan-sprint`'s text on coverage questions says
that a gap or a collision any run or session meets goes to the intake
as a judgment issue, and names no coverage run. The `/ok` front door's text, the family's and the
front door's `CLAUDE.md` files, the administration document, and the
integration contract name neither verb as a family verb, and the
retired-verb table names both as retired with no replacement.

### 2. Rewrite the rules layer and the repo's text without the audit

Realizes: the same retirements, and the amended `practice-violations-are-defects`,
`tests-forbidden`, `records-stay-out-of-context`.

The suite-owned rules and estate guidance the family materializes
describe the suite as it now stands: the ok-planner cheatsheet (its
content kinds, lifecycle, defect issues, public surface, audit, and
documentation sections), the estate `CLAUDE.md` template, the ok
cheatsheet's subagent rule, the plumbline cheatsheet's tests and tooling
sections, the practice definitions, the stack helpers reference, and
the accept list's A3 wording that points at "the project's surface
record". Each says what the docspec process, the surface intent, and
flow areas now do, per the deltas, once and in the place a reader looks
for it. The repo's root `README.md` drops its audit and documentation
sections and says how a project's documentation stays current through
docspecs. Every citation of the retired `decision:audit-audience-split`, such
as `/plan-sprint`'s rule on rulings accepted by silence, cites
`decision:intake-writers-are-gated` instead.

### 3. Docspecs in planning

Realizes: `concept:docspec`, the amended `concept:surface-intent`, the
new docspec and documentation decisions and story below, and the
amended decision on out-of-band work.

- The shared artifact definitions define a docspec and give its
  template: where the documentation lives (a file, or a folder and how
  its files are laid out), its reader, what it covers, its references
  (the corpus artifacts and code paths it describes), the surface
  classes it must list in full (reference documentation only), and
  notes. A docspec lives at `.ok-planner/docspec/<slug>.md`, and
  `catalog-toc` writes an index beside the folder listing each
  docspec's location and references, regenerated like the corpus TOCs.
  The corpus delta form covers docspec and surface intent deltas, with
  sidecar paths for each.
- `/plan-sprint`'s Draft phase matches the drafted work against every
  docspec's references and adds one work item per docspec the work
  touches. Its predictive classification test answers an unclaimed
  surface with a surface intent delta, not a work item. Its release
  boundaries step still reads the surface intent.
- `/plan-sprint`'s Reconcile phase and its out-of-band reviewer prompt
  flag documentation a docspec governs that changed outside a sprint,
  with the three outcomes edit stands, documentation goes back to its
  docspec, or record and defer; and flag code or corpus a docspec
  references that changed outside a sprint, with the outcomes a work
  item that updates the documentation, or record and defer.
- The planning session writes docspec and surface intent deltas like
  any other delta; the sign-off review checks their form.

### 4. Docspecs in execution and certification

Realizes: the new documentation decision, and the amended
`runs-fix-what-the-project-owns`.

- The sprint build prompt's rule on release documents is replaced by a
  documentation rule: a builder whose work item names a docspec writes
  that documentation after the code it describes, per the docspec,
  deciding which files under its location to add, change, or drop; it
  lists each surface class the docspec names from the tree as it
  stands; and it records as a call any edit to documentation the sprint
  did not name.
- The sprint boilerplate's step on `.ok-planner/audits/` and
  `.ok-planner/experiments/` goes; the completion contract's first item
  covers docspec and surface intent deltas beside the corpus. Every line
  removed from the boilerplate is added to the retired-boilerplate list
  true-up reads.
- Sprint certification's review checks each documentation a work item
  named against its docspec and the change, lists each surface class a
  reference docspec names and reports a member the documentation omits,
  and checks every docspec and surface intent delta landed.
- `/converge`'s scope rule and its prompts drop the "document the
  release regenerates" kind. `review owner` classes a docspec and the
  surface intent the way it classes the design corpus, so only a
  sprint changes them. The `review` tool's record paths drop the audit
  and documentation folders.

### 5. True-up: one consent for the whole plan, and the whole estate current

Realizes: the amended `whole-file-ownership`,
`administration-is-a-user-act`, `concept:true-up`, and the new true-up
decisions below.

- Diagnose prints one plan: every step true-up would take, each
  destructive step marked. A destructive step deletes a file, moves a
  file into the archive, or rewrites a file a person edited.
- `/ok` shows the plan once where it holds a destructive step, and asks
  once: go ahead with all of it, or abort. Abort writes nothing, and the
  project stays on the suite version its stamps record. Go ahead applies
  every step. A plan with no destructive step runs with no question.
- Every item true-up offers today about estate content becomes a plan
  step: true-up ports what the current skills use, archives under
  `.ok-planner/history/` what they no longer use, collisions and
  owner-edited copies included, and removes only what git can recover.
  It never discards uncommitted work: an uncommitted file it would
  delete moves to the archive instead.
- True-up asks separately, after the plan runs, only for a value the
  owner alone can give (the port range, the citation tags), for the
  hook and env wiring in the harness settings, and for a reword in a
  file the suite does not own.
- For the back-out, in a consumer project: true-up removes the vendored
  `/audit` and `/document` skills, the `ok-audit` profile, and the
  audit's shared prompt; moves each document type to
  `.ok-planner/docspec/<slug>.md`; moves `.ok-planner/audits/`,
  `.ok-planner/experiments/`, and `.ok-planner/documentation/` to
  same-named folders under `.ok-planner/history/`; deletes the audit's
  scratch folder under `.ok-planner/.cache/`; deletes the provenance
  stamp line `/document` wrote at the top of each placed document;
  drops `hunt.extraction` and `hunt.flow_kinds` from the review config;
  leaves the surface intent in place; and stops creating the audit
  folders on bootstrap.
- The administration document, the `/ok` skill, and the issue format
  in the shared artifact definitions describe this one consent: none
  of them describes a per-item cleanup offer or an earlier layout that
  waits for the owner to accept its conversion. The repo's checks that
  pin true-up's behavior follow it.

### 6. True-up files an issue for an undecodable review facts file

Realizes: `true-up-undecodable-review-facts-skipped`, as the amended
`whole-file-ownership` states it.

Where `.ok-planner/review/project.md` does not decode as UTF-8, true-up
files an intake issue for the owner, says in its report that it filed
one, and leaves the file as it stands. The issue names the file, says
that true-up cannot read or rewrite it, and names the retired review
tool's path and the path that replaces it.

### 7. Flow areas from the surface intent

Realizes: the amended `analysis-hunts-until-converged` and
`concept:surface-intent`.

`review areas` cuts flow areas on each run from the files the surface
intent names as declaring each class of entry point, and a flow hunt's
brief names the declaring file and the class, so the hunter finds the
entry points itself. Nothing stores the entry points. Where the project
has no surface intent, or it names no declaring file, analysis mode
hunts file areas only and says so in its return. The review config seed
and this project's `.ok-planner/review/config.json` drop
`hunt.extraction` and `hunt.flow_kinds`, and `.ok-planner/review/project.md`
drops its mention of `/audit` and of the retired `ceremony-surfaces`
check.

### 8. The repo's checks follow the back-out

Realizes: the retirements above.

`checks/ceremony-surfaces`, which exists only to check the audit's and
`/document`'s spines, goes, and `checks/run` stops running it.
`checks/oscillation` drops its audit-flip report and keeps its
section-churn report. `checks/owned-paths` stops pinning the retired
audit-corpus reset and pins the migration of work item 5 instead.
`checks/vendored-layer` and `checks/sprint-boilerplate` pass with the
skills gone and the boilerplate lines retired. Every check in
`checks/run` passes.

### 9. One table of every call, vetoed at the close

Realizes: `converge-calls-reach-owner-as-counts`, and the amended
`concept:completion-report`.

Every judgment an agent makes without the owner counts as a call: a
builder's calls, forks, noticed defects, and taken improvements, and
certification's declines, not-owed sorts, rejections, and unlisted
calls. Each agent writes a one-line choice when it records the call.
`tasks render` writes one table in place of `## Divergences`, one row
per call, with the columns id, kind, stage or role, site, and choice. A
plain `/converge` run's return lists its declines, not-owed sorts, and
rejections in the same table. The sprint boilerplate's close presents
the table, and the owner vetoes any row they disagree with; the session
walks nothing else.

### 10. `run-group` lends no terminal

Realizes: `run-group-lends-terminal`, and the amended
`stack-helpers-serve-project-commands`.

`run-group start` runs the command with its input from `/dev/null`,
and keeps the caller's output and environment. The terminal-lending
code leaves `run-group`. The stack helpers reference drops its
paragraph on Ctrl-C, Ctrl-Z, `bg`, and `fg`, and says in its opening
that the helpers are for scripts to call, not for an owner to run by
hand.

### 11. A browser tool for this project's drivers

Realizes: `dashboard-drive-needs-browser-tool` (option A).

This project's `.mcp.json` carries the chrome-devtools MCP server entry
`/setup-web` writes, so every driver session has a browser tool and a
drive of `story:rule-on-the-whole-intake` reaches the dashboard's page.

### 12. Unread counts include people's messages

Realizes: `unread-counts-only-agent-messages`, and the read-mark
decisions as amended.

Every message on an open issue, a person's comment or ruling included,
counts as unread to each person except its author until that person
next reads the issue, on the command line and the dashboard alike.
Reading an issue marks every message on it read. A message counts once,
by its number, so an edit or withdrawal of a message the reader already
read does not count again. The issue format text and every other
tooling text that describes unread counts say the same.

### 13. The oscillation check's comments pass the lint

Realizes: `checks-oscillation-prose-comments`.

Fix `checks/oscillation` so the lint over it no longer reports a
comment-hygiene violation. Lands with work item 8's change to the same
file.

### 14. Sign-off checks a subject or practice delta's form

Realizes: `compliance-reviewer-skips-practice-form`.

Fix the plan-sprint compliance reviewer's rules so a malformed subject
or practice delta no longer passes sign-off as approved: it checks each
against the practice definitions' authoring rules.

### 15. The conduct's writing standard reaches every write

Realizes: `conduct-writing-standard-handoff-and-scope`.

Fix the ok-conduct output style's first section and its prompt hook so
the conduct no longer narrows the writing standard to messages or names
a retired write-time hand-off.

### 16. `/converge` handles every unfinished close

Realizes: `converge-fix-close-blocked-strands-defects`,
`converge-merge-close-unhandled`, `converge-review-root-close-unhandled`.

- A fix task that closes `blocked` or `disputed` no longer strands its
  defects at `fixing`: the run refiles or reports each one.
- A merge task that closes `partial`, `blocked`, or `disputed` no
  longer leaves its reports and failures open and unreported, in every
  mode.
- A certification whose review root did not finish no longer reports
  as reviewed.

### 17. The discovery reviewer knows its last pass is final

Realizes: `discover-design-reviewer-cap-unsignalled`.

Fix `/discover-design`'s Phase 2 reviewer prompt so the capped pass's
residual uncertainty no longer goes unfiled.

### 18. A verifier checks every declined or duplicate defect

Realizes: `review-verifies-skips-declined`.

Fix `review verifies` so a declined or duplicate defect no longer ends
the run with no verifier having checked its reason.

### 19. The vendored scripts read only the current layout

Realizes: `decision:skills-read-only-the-current-layout`.

No script the family vendors reads a layout an earlier release left or
carries a fallback for one: a retired lint check name, a retired form
of a configuration value, a retired placeholder, the pre-v9 intake
event rows, or the markdown issue files of the retired intake. Each
earlier layout such a fallback served is one true-up converts in its
plan (work item 5), so a trued-up project never holds it. A script
that meets an earlier layout refuses with a message that says to run
`/ok`, rather than reading it.

## Implementation notes

Planned against commit `89b51cf0e6d7a570fe9368a0728bf8cee9178354`.

### 1. Remove `/audit` and `/document` from the family

**Calls**
- The issue kind value `audit` stays in `scripts/issues::KINDS` and in `{{ISSUE-FILE-FORMAT}}`. Stored intake records carry it, and `/converge`'s owner list and true-up still file under it. Only the text that says "the audit's judge files…" changes. Decided by: the stored-state boundary, and WI 1's list ("an audit record") does not include the kind value.
- `/ok`'s own "Audit the project against the carried version" step is renamed "Check the project against the carried version", and "audit finding" becomes "check finding". The word now names only the retired verb. Decided by: technical-writing standard (same term, one thing); WI 1.
- `audit` and `document` join `RETIRED_VENDORED`, not `RETIRED_WHERE_STAMPED`. The project's own files in those folders are archived (WI 5), not left behind. Decided by: whole-file-ownership (amended): "archives … a suite file a person edited included".
- `scripts/surface-corpus` stays. Plan-sprint's issue walk and triage use it, not the audit. Only its mislabel in the family `CLAUDE.md` layout changes.
- Payload markdown carries no `@story:`/`@decision:` annotation. `checks/materialized-standalone` fails any payload markdown citation that resolves in this repo. New annotations go only in `admin/true-up` and `checks/`. Decided by: checks/materialized-standalone.
- WI 1, WI 3, and WI 14 all edit `skills/_shared/design-doc-compliance-reviewer.md`, so the stages chain. They make no conflicting change.

**Changes**
- `plugins/ok/families/ok-planner/skills/audit/` (SKILL.md, goal.md): removed.
- `plugins/ok/families/ok-planner/skills/document/` (SKILL.md, goal.md): removed.
- `plugins/ok/families/ok-planner/agents/ok-audit.md`: removed.
- `plugins/ok/families/ok-planner/skills/_shared/implementation-auditor.md`: removed.
- `plugins/ok/families/ok-planner/skills/_shared/artifact-definitions.md`, changed:
  - The opening sentence lists concept, story, decision, docspec, surface intent, issue, and corpus delta. It no longer lists audit.
  - Line 13 ("The `/audit` compliance pass flags them") becomes: the sign-off review flags them in a delta.
  - `{{STORY-DEFINITION}}`: line 92 says to write the concrete version per `{{DECIDABILITY-BOUNDARY}}`, with no referral. Line 93 keeps only "A story carries no `Proof:` field. The code that realizes a story carries `@story:<slug>`."
  - `{{DECISION-DEFINITION}}`: line 125 keeps only "Code that enforces the choice carries `@decision:<slug>` at the point of enforcement."
  - `{{ISSUE-FILE-FORMAT}}`: "the count belongs in the audit record" is dropped.
  - `{{DECIDABILITY-BOUNDARY}}` keeps the core/rim split and "write the concrete version first". It drops "Audits determine these", the "No determination rests on the rim…" rule, and the referral rule.
  - `{{AUDIT-DEFINITION}}` and `{{AUDIT-FILE-FORMAT}}` are removed.
- `plugins/ok/families/ok-planner/skills/_shared/design-doc-compliance-reviewer.md`, changed:
  - The line 3 and line 11 sentences about the periodic audit go.
  - The slot `[AUDIT SCOPE]` becomes `[REVIEW SCOPE]`, and "Audit the …" becomes "Review the …" in the substitution note and the prompt.
  - Lines 145–148 say: write the concrete version per `{{DECIDABILITY-BOUNDARY}}`. The words "audits attach … referrals" go.
- `plugins/ok/families/ok-planner/skills/_shared/dispatch-discipline.md::{{DISPATCH-DISCIPLINE}}`: changed. The model-follows-job bullet drops "the surface extractor, a document Method's leaf agents".
- `plugins/ok/families/ok-planner/scripts/ok-cheatsheet.md` (Subagent models): changed. It drops "the audit profile forks so…" and "the surface extractor, and a document Method's leaf agents", matching the amended subagent-model-follows-job.
- `plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md`, changed:
  - Line 85: the referral sentence becomes "write the concrete version per `{{DECIDABILITY-BOUNDARY}}`".
  - Line 99 drops "and the audit's next run reads it" (WI 3 rewrites the rest of the paragraph).
  - Line 121 ("Coverage questions") becomes: a gap or a collision that any run or session meets goes to the intake as a judgment issue, through that run's gate. A violation is a defect, offered at Frame. No coverage run is named.
- `plugins/ok/families/ok-planner/skills/discover-design/SKILL.md` Phase 2 extractor prompt, lines 316–318: changed. "The periodic audit verifies both" and "an unenforced Choice is what its audit will report" go. It keeps "Never write a `## Proof` section, and never file an issue because a decision lacks an enforcing check." WI 17 edits the same file.
- `plugins/ok/families/ok-planner/scripts/plumbline`, changed:
  - `patternsCmd`, `patternKey`, `commentHygieneShape`, and `isLikelyCode` are removed. Only `patterns` used them (rule 1.4).
  - `SUBCOMMANDS.patterns` is removed, and `RETIRED_SUBCOMMANDS` gains `patterns`, so the call prints "`patterns` is retired" and exits 1.
- `plugins/ok/families/ok-planner/admin/true-up`, changed:
  - `SKILLS` and `UNPREFIXED` drop `audit` and `document`.
  - `RETIRED_VENDORED` gains `audit` and `document`.
  - `RETIRED_AGENTS` gains `ok-audit.md`.
  - `RETIRED_SHARED` gains `_shared/implementation-auditor.md`.
  - `ESTATE_LICENSE_PREAMBLE` drops "audits" and adds "docspecs, the surface intent".
  - The bash diagnose and removal messages for `bin/audit-check`, `bin/document-check`, and `bin/surface-reconcile` name "the retired audit's" and "the retired /document's" checkers. Messages that imply a live audit go. (WI 5 moves these removals into the plan.)
- `plugins/ok/families/ok-planner/admin/ADMINISTRATION.md`, changed:
  - Lines 27, 31, 36, 42, 57, 399 drop the audit, extraction, and /document mentions.
  - The sections "The audit model changed shape", "The ceremony verbs are this family's own", "The documentation run runs no validator…", and "The ceremony goal files" are rewritten as retired-layout migrations. They no longer describe live verbs.
  - The retired-verb table's `patterns` row reads "retired". New row: `audit`, `document` | retired. The `certify-all`/`*-audit`/`verify-corpus` rows read "retired" (their replacement, `/audit`, is gone). The `execute-tasks` row's text drops `/audit`.
  - The section "Falsifier and story-proof elimination" drops "verification is the periodic audit's" and "a decision's verification is its implementation audit now".
- `plugins/ok/skills/ok/SKILL.md`, changed:
  - The intro drops "(`audit` and `document` among them)".
  - Boundaries says "`plan-sprint` and the rest" and drops `audit`.
  - The retired-verb table matches ADMINISTRATION's.
  - WI 5 rewrites the process steps.
- `plugins/ok/families/ok-planner/CLAUDE.md`, changed:
  - Family purpose: the corpus is no longer "verified by the periodic implementation audit". The verbs are `/sketch`, `/discover-design`, `/plan-sprint`, `/converge`, `/triage-issues`, `/dashboard`, `/ok-version`.
  - Layout drops `skills/audit/`, `skills/document/`, and "auditor prompt". It names `/converge`, `/triage-issues`, and sprint execution as the drain's readers. `scripts/surface-corpus` is described as "the corpus surfacer `/plan-sprint`'s issue walk and `/triage-issues` run".
  - "Verification is the audit's" is replaced by one paragraph on docspecs and the surface intent (WI 3).
  - The filers list drops "the audit judge".
  - "How skills are wired" drops the `/audit` and `/document` sentences.
- `plugins/ok/CLAUDE.md`, changed. "(`/audit` and `/document` among them)" is dropped, and the work-driving verbs are `plan-sprint` and `converge`. WI 5 rewrites the consent sentence.
- `docs/integration-contract.md`, changed:
  - Lines 28–33: the family "carries the design corpus, the issue intake, the sprint and the review loop, …". It drops "and its audit" and "the two periodic verbs".
  - Line 46 drops "the machine-written determination records".
  - Lines 62–63 go.
  - "Current conformance" drops `audit`, `document`, `ok-audit`, and "with their audits at `.ok-planner/audits/subjects/`", and adds `.ok-planner/docspec/` and `.ok-planner/surface/surface.md`.
- `.ok-planner/review/project.md` (this project's file): the `plumbline` entry lists the subcommands `config-check` and `version`, and drops `patterns`.

**Behavior changes**
- **B1** `plugins/ok/families/ok-planner/admin/true-up::SKILLS`, `RETIRED_VENDORED`, `RETIRED_AGENTS`, `RETIRED_SHARED`. Before: true-up vendors `/audit`, `/document`, `ok-audit.md`, and `_shared/implementation-auditor.md`. After: it vendors none of them, and its plan removes the suite-stamped copies (archiving any the project edited, per WI 5). The retired-verb table names both verbs as retired with no replacement. Users: in the release: `plugins/ok/skills/ok/SKILL.md`, ADMINISTRATION, `checks/vendored-layer` (WI 8). Across Trued-up projects: every owner who types `/audit` or `/document`, the agents who dispatch `ok-audit`, and any project skill that names the verbs. Ruling: rewrite across Trued-up projects: the owner backed `/audit` and `/document` out until they are redesigned, and this release is a major version (the owner's planning ruling, transcribed).
- **B2** `plugins/ok/families/ok-planner/scripts/plumbline::SUBCOMMANDS`. Before: `plumbline patterns <path>` clusters violations and exits 0 or 2. After: it prints "`patterns` is retired" and exits 1. Users: in the release: the audit's lint sweep, which is removed with it. Across Trued-up projects: any project script that calls `plumbline patterns`. Ruling: rewrite across Trued-up projects: the owner's ruling retires the subcommand with the audit (transcribed).
- **B3** `plugins/ok/families/ok-planner/skills/_shared/artifact-definitions.md::{{AUDIT-DEFINITION}}` and `{{AUDIT-FILE-FORMAT}}`. Before: two transcludable blocks. After: none. Users: in the release: the audit skill and auditor prompt (removed), `{{STORY-DEFINITION}}`, `{{DECISION-DEFINITION}}`, `{{DECIDABILITY-BOUNDARY}}` (changed), and `checks/token-resolution`. Across Trued-up projects: none; `_shared/` is vendored whole beside its consumers. Ruling: rewrite.
- **B4** `plugins/ok/families/ok-planner/skills/_shared/design-doc-compliance-reviewer.md` slot `[AUDIT SCOPE]` becomes `[REVIEW SCOPE]`. Before: the sign-off dispatcher fills `[AUDIT SCOPE]`. After: it fills `[REVIEW SCOPE]`. Users: in the release: the plan-sprint sign-off (`skills/plan-sprint/SKILL.md` §7 reads the file and substitutes). Ruling: rewrite.

### 2. Rewrite the rules layer and the repo's text without the audit

**Calls**
- A3's site wording becomes "as the project's surface intent declares them". No member list is stored now. Decided by: surface-members-listed-at-need.
- `.claude/skills/release/SKILL.md` (repo-owned) drops its two audit sentences: line 32 ("never runs, re-derives, or repairs implementation audits") and line 234 ("never writes `.ok-planner/audits/` — audits belong to `/audit`"). The amended lockstep-suite-version drops the same clause, and the skill would describe a retired verb. Decided by: lockstep-suite-version delta; WI 2 ("the repo's text").
- WI 2 and WI 10 both edit `docs/stack-helpers.md`, so the stages chain.
- Build note: the cheatsheet names both writers of kind `audit`: `/converge`'s owner list and true-up (its caller issues and `review-facts-undecodable`).

**Changes**
- `plugins/ok/families/ok-planner/scripts/ok-planner-cheatsheet.md`, changed:
  - The content-kinds bullet `sprints/, sketches/, documentation/, history/` drops `documentation/` and the in-tree "provenance stamp" sentences.
  - New bullets for `docspec/` (owner intent, changed only by a sprint's delta, index generated by `catalog-toc`) and `surface/surface.md`.
  - The `subjects/`/`practices/` bullet keeps its text.
  - Lifecycle drops the `/audit` and `/document` sentences. It says a sprint that touches a docspec's references carries a work item that updates that documentation, written by the builders after the code, and certification checks it.
  - Defect issues: "Filing" names one writer, `/converge`'s owner list. The audit judge sentence goes, and kind `audit` is attributed to the owner list alone.
  - "The public surface" is rewritten. The surface intent is owner intent, changed only by a sprint's delta. It names each class's declaring files. Planning checks new surface against it. Reference docspecs read it by class. `/converge` analysis cuts flow areas from it. Members are listed from the tree at need, and nothing stores them.
  - "Audits" is removed. "Documentation" is rewritten around docspecs.
  - "The task tracker" profile list drops `ok-audit`.
- `plugins/ok/families/ok-planner/scripts/ok-planner-CLAUDE.md` (estate template), changed:
  - `design/`: drops "The periodic audit verifies it" and "…verifies each Choice under `audits/decisions/`".
  - "Leave the annotation" drops "nothing computes audit invalidation".
  - Coding standards drops "The periodic `/audit` reads coverage…".
  - Configuration: `folders` is read by the lint and the review loop. The audit's sweep and the surface extractor go.
  - "The public surface (`surface/`)" is rewritten as in the cheatsheet, and the document-types half is replaced by a new section "The docspecs (`docspec/`, `docspec.md`)".
  - "The audit corpus (`audits/`)" and "The documentation corpus (`documentation/`)" are removed.
  - The intake filers drop the audit judge. "Earlier layouts" is rewritten: `bin/issues` refuses an earlier layout and names `/ok`, and true-up converts it under the one consent (WI 5/19).
  - Project records drop `documentation/` and add `audits/`, `experiments/`, and `documentation/` as archived folders under `history/`.
  - The task tracker drops `ok-audit`.
  - Lifecycle drops the `/document` paragraph.
  - "Executing a sprint" drops "Sprint certification never audits…".
- `plugins/ok/families/ok-planner/docs/plumbline-cheatsheet.md`, changed:
  - Line 67: "it is what a reviewer reads instead of tracing".
  - Line 111: "…and the drive, which tries each story through the public surface".
  - Line 147: the `/audit` bullet goes.
- `plugins/ok/families/ok-planner/docs/practice-definitions.md` "Coverage, gaps, and collisions", changed:
  - Line 127: "That is the claim a reviewer checks by counting".
  - Lines 139–141: "The audit files the violations…" goes.
  - Gaps and collisions reach the intake through whichever run's gate meets them (practice-violations-are-defects, amended).
- `plugins/ok/families/ok-planner/docs/stack-helpers.md`, changed. Lines 9 and 23 drop "and the audit".
- `plugins/ok/families/ok-planner/review/catalog/accept.md::A3` ("The sites" column), changed. "as the project's surface record lists them" becomes "as the project's surface intent declares them".
- `README.md`, changed:
  - The bullet "Verification and documentation: `/audit` and `/document`" becomes a docspec bullet.
  - The sections "Verification: a periodic audit" and "Documentation: generated at a release, never maintained" are replaced by one section, "Documentation: docspecs, kept current by sprints". It covers the owner's docspec per kind of documentation, planning's match against references, builders writing after the code, certification's check, and the surface intent naming declaring files.
  - The Layout `checks/` line says "section-churn detection" in place of "audit-oscillation detection".
- `plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md` line 45: changed. It cites `decision:intake-writers-are-gated`. A repo-wide search finds no other live citation of `audit-audience-split` outside `checks/ceremony-surfaces`, which WI 8 removes.
- `.claude/skills/release/SKILL.md` lines 32 and 234: changed, per the call.

**Behavior changes**
- **B5** `plugins/ok/families/ok-planner/scripts/ok-planner-cheatsheet.md`, `scripts/ok-planner-CLAUDE.md`, `scripts/ok-cheatsheet.md`, `docs/plumbline-cheatsheet.md`, `docs/practice-definitions.md`, `docs/stack-helpers.md` (the materialized rules and estate guidance). Before: every session of a trued-up project reads that `/audit` verifies the corpus, `/document` writes the documentation at release, and documents are records. After: it reads the docspec, sprint-documentation, and surface-intent process. Users: in the release: every agent session after true-up rewrites these suite-owned files. Ruling: rewrite.
- **B6** `plugins/ok/families/ok-planner/review/catalog/accept.md::A3`. Before: A3's sites are "as the project's surface record lists them". After: "as the project's surface intent declares them". Users: in the release: `/converge`'s hunters, merge, fixers, and verifiers, which paste the accept list. Ruling: rewrite.

### 3. Docspecs in planning

**Calls**
- The docspec template lives in `{{DOCSPEC-TEMPLATE}}`, under the frontmatter `docspec: <slug>`. Its sections are `## Where`, `## Reader`, `## Covers`, `## References`, `## Lists` (reference documentation only), and `## Notes` (optional). `## References` lists one bullet per reference: `concept:<slug>`, `story:<slug>`, `decision:<slug>`, or a backticked code path or glob. `## Lists` names one surface class per line, in the surface intent's terms. Decided by: the docspec concept and the brief's fields.
- A `{{SURFACE-INTENT-DEFINITION}}` (with template) is added. WI 3 makes the delta form cover the surface intent and has sign-off check its form, and WI 7 needs a section a tool reads. Template: `# Surface intent`, then prose sections for the user-facing parts and the class rules with named exceptions, then `## Where each class is declared`, one line per class: `- <class>: \`<path or glob>\`[, \`<path or glob>\`]`. Decided by: surface-intent-is-one-prose-document, surface-members-listed-at-need.
- Delta headings: `### New docspec: <slug>`, `### Amend docspec: <slug>`, `### Retire docspec: <slug>`, `### New surface intent`, `### Amend surface intent`. Sidecar paths: `<sprint>-deltas/docspecs/<slug>.md` and `<sprint>-deltas/surface/surface.md`. Decided by: `{{CORPUS-DELTA-FORM}}`'s `<kind>s/<slug>.md` pattern.
- The docspec index is `.ok-planner/docspec.md`. Each row is `` - `<slug>` — where: <the first line of ## Where>; references: <the bullets, comma-joined> ``. The index reads only the docspec form. A file with no `## Where` shows "where: not declared", and one with no `## References` shows "references: none". This covers a document type WI 5 moved unchanged, without a fallback. Draft names each such docspec to the owner as needing a reshape. Decided by: skills-read-only-the-current-layout; one-docspec-per-file.
- Draft matches the drafted work against the index by the corpus artifacts each work item names and the paths the owner names. Code planning closes the gap the draft cannot see. `{{CODE-PLANNER-PROMPT}}` adds an output line per work item, "Docspecs: <each docspec whose code-path references a Changes path falls under>". The session adds any missing documentation work item as a call at step 10. Decided by: sprints-write-the-documentation (one work item per docspec the work touches). Files are known only after code planning.
- The compliance reviewer applies `{{SELF-CONTAINMENT-RULE}}` to corpus artifacts alone, because docspecs and the surface intent name paths by design. `{{CURRENT-STATE-ONLY-RULE}}` binds all of them. Decided by: the docspec fields (where, references).
- Where `.ok-planner/docspec/` is missing, the project declares no documentation, and Draft and Reconcile skip the docspec steps.
- Build note: `issues::ARTIFACT` admits only concept, story, decision, subject, and practice. Widen it additively to `docspec:<slug>`, so a Reconcile record-and-defer issue about a docspec can list it in `artifacts`.
- Build note: the compliance reviewer's self-containment scope (corpus artifacts alone) and I101's cross-reference rule each state their reach over subjects, practices, and a docspec's `## References` (work item 14).

**Changes**
- `plugins/ok/families/ok-planner/skills/_shared/artifact-definitions.md`, changed:
  - New `{{DOCSPEC-DEFINITION}}`, `{{DOCSPEC-TEMPLATE}}`, and `{{SURFACE-INTENT-DEFINITION}}` (with template).
  - `{{CORPUS-DELTA-FORM}}` covers docspec and surface intent deltas, their headings, their homes (`.ok-planner/docspec/<slug>.md`, `.ok-planner/surface/surface.md`), their sidecar paths, and regeneration of the docspec index with `catalog-toc`.
- `plugins/ok/families/ok-planner/scripts/catalog-toc`, changed:
  - `CATALOGS` gains a `docspec` entry rendered by a docspec row renderer: where and references, under a docspec-specific header.
  - `render`, `USAGE`, and `main` write and check `.ok-planner/docspec.md` where `.ok-planner/docspec/` exists.
- `plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md`, changed:
  - §1/Estate: a line on `docspec/`.
  - §3 Reconcile: step 4 gains the two documentation flags with their outcomes: (a) documentation edited outside a sprint: edit stands, back to its docspec, or record and defer; (b) a referenced code path or corpus artifact changed outside a sprint: a work item updates the documentation, or record and defer.
  - §5 Draft: the docspec match. Read `.ok-planner/docspec.md` and add one "Update the documentation per docspec:<slug>" work item per touched docspec. Name docspecs with no where or references.
  - The predictive classification test: an unclaimed surface is one question to the owner, and the answer becomes a surface intent delta.
  - Line 95 lists `.ok-planner/docspec.md` among the TOCs.
  - §7 Sign-off scopes the reviewer to docspec and surface intent deltas too.
  - §9 step 4 carries the planner's Docspecs lines.
  - The release boundaries step is unchanged.
- `plugins/ok/families/ok-planner/skills/plan-sprint/core.md`, changed:
  - `{{OUT-OF-BAND-REVIEWER-PROMPT}}`: inputs add the docspec index and every docspec's Where. The test adds BEARING for documentation under a docspec's Where edited in the window, for a change to a docspec's referenced artifact or path, and for a direct edit under `.ok-planner/docspec/` or to `.ok-planner/surface/surface.md`. The output names the kind per group.
  - `{{CODE-PLANNER-PROMPT}}`: the Docspecs output line. A documentation work item's Changes name the docspec, its Where, and the references the sprint changes.
  - `{{IMPLEMENTATION-NOTES-FORM}}`: an optional `Docspecs:` line.
- `plugins/ok/families/ok-planner/skills/_shared/design-doc-compliance-reviewer.md`, changed. New "### Docspec form" (`{{DOCSPEC-DEFINITION}}`) and "### Surface intent form" (`{{SURFACE-INTENT-DEFINITION}}`). The self-containment scope narrows as the call says.
- `plugins/ok/families/ok-planner/skills/plan-sprint/sprint-document.md::{{SPRINT-DOCUMENT-TEMPLATE}}` "Corpus deltas": changed. The example headings include a docspec and the surface intent. (WI 4 owns the boilerplate lines.)

**Improvements**
- **I2** `plugins/ok/families/ok-planner/scripts/catalog-toc::main` (changed by WI 3). A1: each TOC is written in place with `open(target, "w")`. A crash mid-write leaves a truncated `design/concepts.md`, which `.claude/rules/ok-concepts.md` loads into every session until the next run. Afterward: each TOC is written to a temp file beside it and replaced with one `os.replace`. `checks/owned-paths` updates its catalog-toc needle (WI 8 stage). No behavior change a user observes.

**Behavior changes**
- **B7** `plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md` (predictive classification test). Before: the owner's answer on an unclaimed surface becomes a work item that edits `surface.md`. After: it becomes a surface intent delta, which execution applies verbatim and certification checks as C3. Users: in the release: the owner at planning, sprint execution, and the `{{SPRINT-CATALOG}}` C3 class (WI 4). Ruling: rewrite.

### 4. Docspecs in execution and certification

**Calls**
- `{{RELEASE-DOCUMENTS-RULE}}` is removed, and `{{DOCUMENTATION-RULE}}` is defined in `skills/_sprint/shared.md`, which `/converge` already reads through `block_sources`. It is transcluded by `{{SPRINT-BUILD-PROMPT}}` alone. The rule:
  - A builder whose work item names `docspec:<slug>` reads the docspec, writes the documentation under its Where after the code, decides which files to add, change, or drop, and lists each class the docspec's Lists names from the declaring files the surface intent names.
  - A builder that edits documentation the sprint did not name records a `kind=call`.
  - Decided by: sprints-write-the-documentation.
- Certification cuts one `documentation` pass per docspec a work item names, and adds class C5, "Documentation off its docspec". A C5 report is one of: a member of a Lists class missing, a sentence the change made false, a departure from the docspec's Reader, Covers, or Notes, or a named docspec whose documentation did not move where the change reached its references. Decided by: WI 4 (checks each documentation against its docspec and lists each class).
- `{{PROSE-SCOPE-RULE}}` puts in review the documentation under the Where of each docspec a work item names, as well as prose the sprint changed. Without that, an unwritten documentation file could not be fixed. Decided by: WI 4; sprints-write-the-documentation.
- A live sprint whose `-build.md` was registered under v26 keeps that prompt until it closes. Its old rule names `.ok-planner/surface/documents/`, which true-up moves, so it then names no file. Decided by: records-stay-out-of-context (a running sprint's prompt is its record).
- The docspec index joins the TOC list in boilerplate step 4.
- Notes review: true-up's retired-script caller scan (`admin/true-up::caller_kind`, `script_plan`) keeps every folder the plan archives or converts (`.ok-planner/audits/`, `experiments/`, `documentation/`, `.ok-planner/issues/`) out of its callers, through one list in true-up, so the plan never rewrites a record's body or files a caller issue about one. B10 adds `admin/true-up::caller_kind`/`script_plan` as in-release users. Decided by: whole-file-ownership (records keep their bodies).
- Build note: extend `{{FIX-LINE-RULE}}`'s C3 exception to docspec and surface intent deltas and the docspec index, since certification checks they landed.
- Build note: the `{{DOCUMENTATION-RULE}}` `kind=call` record carries `--field site=` and `--field choice=` like every other call item (work item 9).

**Changes**
- `plugins/ok/families/ok-planner/skills/_sprint/shared.md`, changed:
  - `{{RELEASE-DOCUMENTS-RULE}}` is removed. `{{DOCUMENTATION-RULE}}` is new.
  - `{{SPRINT-BUILD-PROMPT}}` transcludes `{{DOCUMENTATION-RULE}}`, and its delta bullet adds the homes for a docspec (`.ok-planner/docspec/`) and the surface intent (`.ok-planner/surface/surface.md`), with `catalog-toc` after a docspec delta.
  - `{{SPRINT-CATALOG}}`: C3 covers docspec and surface intent deltas, and C5 is new.
  - `{{SPRINT-REVIEW-READING}}` step 1 adds every docspec and surface-intent delta's artifact, every docspec a work item names, and the surface intent where a named docspec has Lists.
- `plugins/ok/families/ok-planner/skills/plan-sprint/sprint-document.md`, changed:
  - Boilerplate step 8 drops "`.ok-planner/audits/` and `.ok-planner/experiments/` belong to `/audit`."
  - Step 4's TOC list adds `.ok-planner/docspec.md`.
  - Completion contract item 1 adds `.ok-planner/docspec/` for a docspec and `.ok-planner/surface/surface.md` for the surface intent, with the docspec index regenerated.
- `plugins/ok/families/ok-planner/admin/retired-boilerplate.json`: changed. Every carried line the change above alters or drops is appended (step 4's line 129 region, step 8's lines 158–159, contract item 1's lines 244–248), kept sorted and unique. WI 9 edits the same file, so the stages chain.
- `plugins/ok/families/ok-planner/skills/_converge/coding-rules.md`, changed:
  - `{{FIX-LINE-RULE}}`: four kinds. `corpus` names the design corpus, the coding standards, the docspecs, and the surface intent. The fixable list drops "its surface intent, and its document types". The record list drops "an audit, an experiment". The fifth kind (a document the release regenerates) and the closing "unless it is a document…" sentence go.
  - `{{PROSE-SCOPE-RULE}}` extended per the call.
- `plugins/ok/families/ok-planner/skills/converge/SKILL.md` lines 34, 103, 150, 159: changed. Four kinds. The surface intent and docspecs are left alone as corpus. "a document the release regenerates" goes everywhere. The sprint-mode passes add `documentation`.
- `plugins/ok/families/ok-planner/skills/converge/prompts/sprint-review.md`, `sprint-pass.md`, `fix.md`: changed. The `{{RELEASE-DOCUMENTS-RULE}}` lines go. sprint-review cuts `documentation` passes. sprint-pass's table gains the `documentation` row (C5), and the alignment row's C3 covers docspecs and the surface intent.
- `plugins/ok/families/ok-planner/skills/converge/prompts/merge.md` lines 31 and 37: changed. The release-document detection and route are removed.
- `plugins/ok/families/ok-planner/skills/converge/prompts/owner-list.md` lines 19, 23, 70: changed. Four kinds. The `/audit` and `/document` closing reasons go.
- `plugins/ok/families/ok-planner/scripts/review::OWNER_PATHS`: changed. The `corpus` entry gains `.ok-planner/docspec/`, `.ok-planner/docspec.md`, and `.ok-planner/surface/`. The `record` entry drops `.ok-planner/audits/`, `.ok-planner/experiments/`, and `.ok-planner/documentation/`. `VERB_HELP["owner"]` is unchanged.

**Behavior changes**
- **B8** `plugins/ok/families/ok-planner/skills/_sprint/shared.md::{{SPRINT-BUILD-PROMPT}}` and `{{DOCUMENTATION-RULE}}`. Before: a builder left every file at a document type's target alone. After: a builder writes the documentation a work item's docspec names, after the code, and records edits to unnamed documentation as calls. Users: in the release: build tasks and sprint execution step 3, which writes `-build.md`. Across Trued-up projects: a live sprint's registered `-build.md`. Ruling: preserve (call). A running sprint keeps its registered prompt, and new sprints get the new rule.
- **B9** `plugins/ok/families/ok-planner/skills/_converge/coding-rules.md::{{FIX-LINE-RULE}}`. Before: fixers fixed defects in the surface intent and the document types, and left "documents the release regenerates" alone. After: the surface intent and docspecs are left alone (a fix there becomes a judgment issue), and documentation falls under the prose scope rule. Users: in the release: the merge, fix, verify, backout, sprint-review, sprint-pass, and owner-list prompts, and `skills/converge/SKILL.md`. Ruling: rewrite.
- **B10** `plugins/ok/families/ok-planner/scripts/review::OWNER_PATHS` (via `left_alone`, `cmd_owner`, `changed_files`, `scoped_files`). Before: `review owner .ok-planner/surface/surface.md` prints `project`, and `.ok-planner/audits/…`, `experiments/…`, `documentation/…` print `record`. After: `surface/` and `docspec*` print `corpus`, and the three archived folders get no special class. Users: in the release: every converge prompt that runs `review owner`; `review changed`, which drops docspec and surface-intent files from certification's change list (step 1 reads them from the deltas instead); `review backlog`'s `left_alone`; `admin/true-up::caller_kind`, which loads the review module and still routes `corpus` to the rewrite path. Across Trued-up projects: none; true-up archives the three folders in the same plan that writes the new tool. Ruling: rewrite.
- **B11** `plugins/ok/families/ok-planner/skills/plan-sprint/sprint-document.md` (step 4, step 8, contract item 1). Before: these carry the audit sentence and the corpus-only contract. After: the new text. Users: in the release: executing sessions and `checks/sprint-boilerplate`. Across Trued-up projects: live sprints planned under v26. Ruling: migrate: true-up's live-sprint rewrite replaces each retired line through `retired-boilerplate.json` (call).
- **B12** `plugins/ok/families/ok-planner/skills/_sprint/shared.md::{{SPRINT-CATALOG}}` and `skills/converge/prompts/sprint-review.md`. Before: three passes, and C3 covers corpus and coding-standard deltas. After: a `documentation` pass per named docspec, C3 covers docspec and surface intent deltas, and C5 exists. Users: in the release: the sprint-pass and merge prompts, and `/converge sprint`'s return. Ruling: rewrite.

### 5. True-up: one consent for the whole plan, and the whole estate current

**Calls**
- Modes after the change:
  - `true-up` alone applies a plan that holds no destructive step. Where the plan holds one, it writes nothing, prints the destructive steps and "the owner has not said go ahead", and exits 1.
  - `true-up --go-ahead <plan id> [--drafts <dir>]` recomputes the plan and refuses, writing nothing, where the id differs ("the plan changed since diagnose; run diagnose again"). Otherwise it applies every step.
  - `diagnose` prints the plan. Non-destructive steps keep the `DRIFT:` prefix. Destructive steps print as `DESTRUCTIVE: <step>`, with a `Show:` command where the step rewrites or archives a person's file. A closing `PLAN: <n> step(s), <d> destructive; plan <id>` line follows. The id is the first 12 hex of sha256 over the sorted step lines.
  - Exit codes are unchanged: 0 clean, 1 steps or wiring pending, 3 only input questions.
  - Decided by: true-up-asks-once-before-destructive-steps (one answer before any write; abort writes nothing). The id binds the consent to the plan shown, so a tree that moved between diagnose and apply cannot slip a different plan through (A1, check-then-write).
- Destructive means: every file deletion and every move into the archive, and every rewrite of a file other than a suite-owned file carrying its stamp or fixed content. Two carve-outs follow the machine-local clause of whole-file-ownership (git-ignored suite content is not the project's work): stale files of the git-ignored dashboard build under `.ok-planner/dashboard/`, and content under `.ok-planner/.cache/`. Without the carve-out, every release with new hashed dashboard assets would ask the owner. Also not destructive: regenerating a catalog TOC whose first line is a prior generation, seeding a file where none stands, creating folders, and filing an intake issue (it adds a record and rewrites none). Decided by: true-up-asks-once-before-destructive-steps, whole-file-ownership. A reading the owner may veto.
- Every current offer about estate content becomes a plan step with this disposition:
  - `collision`: archive the project's copy, then write the suite's.
  - `retired-verb`: archive the owned files.
  - `catalog-edits`, `review-edits`, `estate-edits`: archive.
  - `review-conflict`, `move-conflict`, `config-conflict`: keep the new path and archive the old.
  - `review-leftover`, `estate-leftover`: archive. The "move under `.ok-planner/`" choice goes, because no current skill reads such a file.
  - `retired-sections`: copy the file into the archive where git cannot restore it, then strip.
  - The falsifier file git cannot recover: archive.
  - `worktrees`: plan steps (`git worktree remove`, `git branch -d`, never forced). A dirty, locked, or unmerged entry stands as a `blocked:` line and holds back only the workspaces estate, like unmerged paths today.
  - `legacy-intake`, `legacy-archive`: convert.
  - `markdown-intake`, `tensions`: convert from an agent-written draft passed in `--drafts`. A missing or refused draft refuses the whole go-ahead before any write.
  - `review-wording`: a mechanical path rewrite (`.ok-review` to `.ok-planner/review`, `.ok-plumbline/<moved path>` to `.ok-planner/<path>`). A line naming a path with no counterpart becomes a reword question.
  - `review-standards`, `review-exclude`, `config-key`: rewrite steps.
  - The port-range offer's object-form conversion to the array of names: a rewrite step.
  - Decided by: whole-file-ownership (amended), retired-layout-strips-only-recoverable-files (amended), the brief §5.
- The questions after the plan run as `INPUT NEEDED (ok-planner): <id>` blocks, renamed from `CLEANUP OFFERED`, through `resolve` and `amend`. They are `citation-tags`; `port-range` (the range only, through `amend`); `settings`; `config` and `review-config` (malformed); `review-facts` (the seeded skeleton); `rule-file`; `stack-lines`; reword lines; and the check's `amend` drafts for a config key the seed carries that the config lacks, or a path the tree does not hold. `resolve` takes `--from <draft>` or nothing. Its choice names (`keep-new`, `keep-old`, `move`, `delete`) are retired. Decided by: true-up-asks-once-before-destructive-steps (value, wiring, reword).
- The archive path mirrors the content's path under `.ok-planner/history/`. For content inside `.ok-planner/`, it is the path within the estate (`audits/` becomes `history/audits/`). For content outside it, it is the path from the project root with the leading dot of the first segment dropped (`.claude/skills/x/f` becomes `history/claude/skills/x/f`; `.ok-review/f` becomes `history/ok-review/f`). Moves into a taken path merge entry by entry, and a taken file name gets `-2`, `-3` before its extension. Each move prints `archived: <src> -> <dst>`. Tracked files move with `git mv`, so the move is staged. Decided by: whole-file-ownership ("a folder named as the content was").
- One removal rule for every deletion: a tracked file matching HEAD is removed with `git rm`; an untracked file carrying its suite stamp is removed; a file with an uncommitted or staged-only change, or behind a symbolic link, is archived. The current `os.remove` calls on retired stamped files (`retirements` loop, `RETIRED_SHARED`, `RETIRED_AGENTS`) and the bash `rm -rf` sweeps (`RETIRED_ESTATE`, the surface apparatus, the three retired binaries) take an edited stamped file without checking for uncommitted work. They all move into the python plan and this rule. This also leaves one removal mechanism, where diagnose and true-up each built their own list in bash. Decided by: whole-file-ownership ("never discards uncommitted work").
- Every removal and rewrite the bash body made moves into the python plan, so one gate covers them. The bash body keeps orchestration only. Decided by: true-up-asks-once-before-destructive-steps.
- `.ok-planner/docspec/` joins `SUBDIRS`, so a bootstrap holds the folder and an index ("none yet"), as `subjects/` does. The `audits/*` entries leave `SUBDIRS`. Decided by: WI 5 ("stops creating the audit folders"); the subjects precedent.
- The provenance stamp found is any tracked or untracked-not-ignored file whose first non-blank line opens `<!-- Revised by /document at`, outside records and suite files. True-up deletes the comment through its first `-->` and one following blank line. A file that does not decode prints a `left:` line. The scan is not limited to declared targets, so a document whose type was dropped earlier is covered. The deletion keeps no archive copy, because the line is the suite's own text. Decided by: whole-file-ownership ("deletes that line and leaves the rest").
- `docs/CLAUDE.md` is removed where its first line is `# docs/ — generated release documents` and a line opens `Materialized by /document at`. It is archived where git cannot restore it. That file tells every agent the documentation is a record never to be read, which contradicts sprints-write-the-documentation. Decided by: whole-file-ownership (suite text written under a retired verb).
- `hunt.flow_area_size` retires with `hunt.extraction` and `hunt.flow_kinds` (see WI 7's call). The review-config rewrite drops all three.
- The plumbline migration moves `.ok-plumbline/audits/subjects/` to `.ok-planner/history/audits/subjects/`, since `audits/` is archived. Decided by: the brief §5.
- A moved document type whose `docspec/<slug>.md` path is taken is archived under `history/surface/documents/`.
- `.ok-planner/tasks/audit-*.jsonl` run files stay. They are records in a live records folder that nothing misreads. Decided by: records-stay-out-of-context.
- The surface apparatus sweep keeps `surface.json`, `guidance.md`, and `members/`, and drops its `audits/surface/*` items (the archive move takes them). Its message names no audit. The "No surface intent document … the audit will file…" advisory goes.
- The `placed: the dashboard build at .ok-planner/dashboard/ (v<version>), …` line stays byte for byte. The dashboard drive steps in `.ok-planner/review/project.md` parse it with sed.
- The one consent also covers the docs this change touches but WI 5 does not name: `docs/integration-contract.md` (collision rule, administration files, migration check, ownership consent paragraph, front door) and `plugins/ok/CLAUDE.md` (the consent sentence). Leaving them would state the retired per-item model as normative. Decided by: the contract's own "normative" status; the brief §5.
- New annotations in `admin/true-up`: `# @story: turn-down-a-destructive-true-up` and `# @decision: true-up-asks-once-before-destructive-steps` at the go-ahead gate; `# @decision: skills-read-only-the-current-layout` at the plan builder.
- Notes review: true-up's bare-mode refusal names no runnable go-ahead. It says nothing was written and tells the session to run `/reload-plugins` and then `/ok` again; ADMINISTRATION's opening says the same for a session whose `/ok` text predates the plan, because a session whose `/ok` updated ok still runs the old skill text against the new core. B13 and B20 gain: Across Installed plugins: a session running the older `/ok` text. Ruling: migrate: an older `/ok` text driving the new core writes nothing and is told to reload (call).
- Notes review: the go-ahead applies the intake conversions (legacy-intake, legacy-archive, markdown-intake) before any step that files through the intake module (retired-script caller issues, `review-facts-undecodable`), and the plan states that order, so no filing meets the module's earlier-layout refusal partway through a plan. Decided by: A1 (no half-applied plan).
- Notes review: the go-ahead refuses and writes nothing while `.ok-planner/config.json` is absent and a blocked retired estate (`estate_blocked`) holds the lint config, naming what to settle; the project stays on its stamped version until then, so the new lint never runs without the project's citation tags. Decided by: true-up-asks-once-before-destructive-steps (abort writes nothing).
- Build note: before the first write, pre-check every step's refusal conditions (git's index lock, writable folders, taken paths, import dry runs), as `intake_migration_refusals` does, so a go-ahead applies whole or writes nothing.
- Build note: evaluate `config_defects`, `config_offers`, `port_range_offer`, and `stack_config` on the config as the plan's compose-name removal and port-form conversion leave it, so the plan raises no question about names it removes itself and `stack_config` does not skip the stack migration on the object form.
- Build note: the port-form conversion's plan line names the callers of a held `.ok-planner/bin/port-block`, as the old offer's text did.
- Build note: `RETIRED_ESTATE` holds `audits/inspection.md`, which the `audits/` archive move also takes; one step owns it.
- Build note: with the lint no longer ignoring `.ok-workspaces/` (work item 19), a dirty or locked worktree the plan keeps is walked by a whole-tree lint run; the plan line for a blocked worktree says so.

**Changes**
- `plugins/ok/families/ok-planner/admin/true-up`, changed:
  - The bash mode parsing and `USAGE` add `--go-ahead <id>` and `--drafts <dir>`.
  - A new python mode `plan`, with `plan_steps()` gathering: `expected()` drift; `retirements()`; `RETIRED_SHARED`/`RETIRED_AGENTS`; `migration_moves()`; `review_plan()`, `plumbline_plan()`, `workspaces_plan()`, `planner_scripts_plan()`; `script_plan()` repoints (destructive) and filings (non-destructive); `retired_rules_split()`; `retired_section_files()` and the falsifier; live sprints; stale templates and ignore; `review_config_mode` rewrites; the stack migration; the intake conversions; `COLLIDED`; and the back-out steps below. `plan_id()` digests the steps.
  - `offers()` becomes `questions()`; `print_offer` becomes `print_step` and `print_question`.
  - `resolve` keeps only question kinds.
  - `remove_files` follows the one removal rule and no longer refuses uncommitted files. New `archive(paths)` and `archive_path(src)`.
  - `mode == "true-up"`, `migrate`, `corpus`, `stack-lines`, and `review-config` apply only from an accepted plan.
  - Back-out steps:
    - Remove the vendored `audit`/`document` folders, `ok-audit.md`, and `_shared/implementation-auditor.md`.
    - Move `.ok-planner/surface/documents/<f>` to `.ok-planner/docspec/<f>` (git mv).
    - Move `.ok-planner/audits/`, `.ok-planner/experiments/`, and `.ok-planner/documentation/` to `history/audits/`, `history/experiments/`, `history/documentation/`.
    - `RETIRED_ESTATE` gains `.cache/audit`.
    - Delete the provenance stamp; remove `docs/CLAUDE.md`.
    - `stale_review_settings` drops `hunt.extraction`, `hunt.flow_kinds`, `hunt.flow_area_size` (printing `rewrote: …/config.json hunt names <keys>; removed`).
    - `SUBDIRS` per the call.
    - `PLUMBLINE_OWNER_DIRS` audits/subjects target per the call.
  - The `audit_reset` heredoc and its "Retired audit corpus removed" line are removed.
  - The compose-name removal (`retired_compose_checks`) runs before the `stack_config` gate, from the parsed JSON. WI 19's lint refuses those names, and `stack_config` gates on `config-check`, so the migration would otherwise never run.
  - `unfiled()` and `open_issue_ids()` read the intake through the module's converter path (WI 19).
- `plugins/ok/families/ok-planner/admin/ADMINISTRATION.md`, changed:
  - "The core's modes": the new modes, and the plan and its destructive marking.
  - "Cleanup offers — consent, then resolve" is replaced by two sections. "The plan": each step kind and its disposition per the calls, the archive rule, the go-ahead, drafts. "Input questions": the question ids table, and the draft guidance kept for `review-facts`, `stack-lines`, `settings`, `config`, `review-config`, `rule-file`, `port-range` (range only).
  - The `markdown-intake`/`tensions` draft guidance moves under the plan's drafts.
  - "Issue-intake integrity": the module refuses an earlier layout; conversion is a plan step.
  - "Check the project against the carried version" re-sorts each finding into plan step, `amend` question, or report line. Its table drops `hunt.extraction`.
  - New section "The audit and document back-out", listing the WI 5 moves.
  - "What the administration does NOT do": its write list adds `history/` archive moves, `docspec/`, and the stamp-line deletions.
- `plugins/ok/skills/ok/SKILL.md`, changed:
  - Frontmatter `description` and intro: one plan, one question.
  - Steps 4–6 become: diagnose; read ADMINISTRATION; write each step's draft to a scratch dir; where the plan holds a destructive step, show the whole plan once, with destructive steps marked and each `Show:` output, and ask "go ahead with all of it, or abort"; on abort report `declined; stays on v<stamped>` and stop, writing nothing and asking nothing else; on go-ahead run `true-up --go-ahead <id> --drafts <dir>`, or bare `true-up` where nothing is destructive; then the check, the input questions and `amend` drafts, the wiring; true up again where any applied.
  - Report template: `archived:` and `filed:` lines, the declined outcome. No per-item offer text remains.
- `plugins/ok/families/ok-planner/skills/_shared/artifact-definitions.md::{{ISSUE-FILE-FORMAT}}`, changed:
  - The skipped-line list drops "a pre-v9 event row". The module refuses an earlier layout and names `/ok`.
  - "Earlier layouts are converted…" describes conversion as a true-up plan step under the one consent. Every `markdown-intake`/`legacy-*` offer reference goes.
  - The `/ok` writer row adds "one issue for a review facts file it cannot decode" (WI 6).
- `plugins/ok/families/ok-planner/CLAUDE.md`: changed. The `markdown-intake` offer sentence, and the Layout line for `admin/true-up` (modes).
- `plugins/ok/CLAUDE.md`: changed. The consent sentence and the `CLEANUP OFFERED` sentence become the one-plan model.
- `docs/integration-contract.md`: changed per the call.
- `.ok-planner/review/project.md` (this project): the `admin/true-up` modes entry becomes `diagnose`; none or `--go-ahead <plan id> [--drafts <dir>]`; `resolve <id> [--from <draft>]`; `amend`; `wire-hooks`; `wire-env`; `check-range`.

**Behavior changes**
- **B13** `plugins/ok/families/ok-planner/admin/true-up` (bare mode). Before: it applies every step it owns and leaves consent items as offers. After: where the plan holds a destructive step, it writes nothing and exits 1 naming `--go-ahead <id>`. Users: in the release: `plugins/ok/skills/ok/SKILL.md` (rewritten); the dashboard drive steps in `.ok-planner/review/project.md`, which true up a fresh scratch project with no destructive step and stay unchanged. Across Installed plugins: none; the `/ok` skill and the core ship in one plugin. Ruling: rewrite.
- **B14** `plugins/ok/families/ok-planner/admin/true-up::resolve`. Before: resolves every offer kind, with the choices `keep-new`/`keep-old`/`move`/`delete`. After: input questions alone; an estate-content id is refused ("ok-planner offers nothing as <id>"). Users: in the release: `/ok`. Ruling: rewrite.
- **B15** `plugins/ok/families/ok-planner/admin/true-up` (diagnose output). Before: `CLEANUP OFFERED` blocks. After: `DESTRUCTIVE:` lines, a `PLAN:` line, and `INPUT NEEDED` blocks. `DRIFT:`, `WIRING NEEDED`, and the exit codes keep their form. Users: in the release: `/ok`. Ruling: rewrite.
- **B16** `plugins/ok/families/ok-planner/admin/true-up::remove_files` and the retired-payload removals. Before: an uncommitted file refuses the offer (resolve), or a stamped retired file is deleted with no check. After: such a file moves to the archive. Users: in the release: every plan step that removes. Across Trued-up projects (stored state): a project's edited copies of suite files. Ruling: migrate: the bytes survive under `.ok-planner/history/` (call).
- **B17** Estate-content dispositions in `plugins/ok/families/ok-planner/admin/true-up::plan_steps`. Before: collisions, leftovers, conflicts, edited copies, and retired sections wait for the owner per item, and a declined item stays. After: each is ported, archived, or stripped under the one go-ahead. Users: across Trued-up projects (stored state): owners whose estates hold such content. Ruling: migrate: one go-ahead covers the plan, every archived piece keeps its bytes under `.ok-planner/history/`, and an abort leaves the project on its stamped version (call; the owner's ruling, brief §5).
- **B18** The back-out estate moves in `plugins/ok/families/ok-planner/admin/true-up::plan_steps`. Before: `.ok-planner/audits/`, `experiments/`, `documentation/`, `surface/documents/`, `.cache/audit`, provenance stamps, `docs/CLAUDE.md`, and the three hunt keys stand. After: they are archived, moved to `docspec/`, deleted, or dropped. Users: in the release: `scripts/review` (WI 7 reads no extraction), `catalog-toc` (reads `docspec/`). Across Trued-up projects (stored state): owners' estates and documents, and any project tooling that reads `audits/surface/extraction.json`. Ruling: migrate: true-up's plan ports or archives each, and nothing is discarded (call; the owner's ruling, brief §5).
- **B19** `plugins/ok/families/ok-planner/admin/true-up` bash `SUBDIRS`. Before: a bootstrap creates `audits/subjects` and, with `design/`, `audits/{concepts,stories,decisions}`. After: it creates none of them, and creates `docspec/`. Users: in the release: none; no reader of `audits/` remains. Across Trued-up projects: existing empty `audits/` dirs go with the archive move. Ruling: rewrite.
- **B20** `plugins/ok/skills/ok/SKILL.md` (process). Before: the owner answers each cleanup offer and draft and may accept some. After: one go-ahead or abort for the whole plan, then input questions. Users: across Installed plugins: owners running `/ok` (the skill updates with its plugin, and the payload it drives is the same plugin's). Ruling: rewrite.

### 6. True-up files an issue for an undecodable review facts file

**Calls**
- The issue is filed through the intake module in the `file_caller_issues` shape. It is skipped when the id is open or archived, as `unfiled()` does.
  - Fields: id `review-facts-undecodable`, kind `audit`, category `tooling`, `artifacts: []`, title "`.ok-planner/review/project.md` does not decode as UTF-8", route, recommendation, and upstream null.
  - The `problem` names the file and says true-up cannot read or rewrite it. It says that where the file names the retired review tool `.ok-review/bin/review`, the tool now stands at `.ok-planner/bin/review`.
  - Options: re-encode the file as UTF-8 and run `/ok` again; or rewrite the path by hand.
  - Decided by: whole-file-ownership (amended), "one shape for every retired reference true-up cannot rewrite".
- Filing is a non-destructive plan step. Diagnose prints `DRIFT: … true-up files intake issue review-facts-undecodable`, and true-up prints `filed: review-facts-undecodable — .ok-planner/review/project.md does not decode as UTF-8`.
- `stack_plan` drops its separate undecodable `left` entry, which today feeds the `stack-lines` question. The issue is the one record of the undecodable file. Decided by: the same clause (one shape).

**Changes**
- `plugins/ok/families/ok-planner/admin/true-up::review_config_mode`: changed. On `UnicodeDecodeError` in `check` it reports the pending filing; in `fix` it files the issue and prints the `filed:` line. Before, it returned silently.
- `plugins/ok/families/ok-planner/admin/true-up::stack_plan`: changed per the call.
- `plugins/ok/families/ok-planner/admin/ADMINISTRATION.md` "Stack declaration" and the `stack-lines` row: changed. The undecodable case moves to the issue.

**Behavior changes**
- **B21** `plugins/ok/families/ok-planner/admin/true-up::review_config_mode`. Before: an undecodable `project.md` is skipped with no line. After: true-up files `review-facts-undecodable` once and reports it. Users: in the release: `/ok`'s report; `/triage-issues` and `/plan-sprint`, which meet the new record. Across Trued-up projects (stored state): the intake gains one record. Ruling: rewrite.

### 7. Flow areas from the surface intent

**Calls**
- `review areas` reads `.ok-planner/surface/surface.md`'s `## Where each class is declared` section (format in WI 3).
  - Each backticked path or glob is expanded over the files `git ls-files --cached --others --exclude-standard` lists under the root and the declared `folders`, skipping files `left_alone` classes.
  - It cuts one flow area per (class, declaring file), named `flow:<class>@<path>`.
  - A literal path the tree does not hold prints a stderr note and is skipped.
  - Decided by: analysis-hunts-until-converged (amended) and surface-members-listed-at-need. "One flow area per declaring file" meets the Choice's "or" clause.
- `hunt.flow_area_size` retires with `hunt.flow_kinds` and `hunt.extraction`. It only sized chunks of a stored entry list, which no longer exists. `hunt_settings` stops requiring all three and ignores them where an old config still holds them. Decided by: WI 7 (nothing stores the entry points). A key the owner may veto; the alternative is to keep it unread.
- Rotation keys for flow areas become `flow:<class>@<path>`, with the declaring file's content hash, so a changed declaring file reads as changed. Old `entry:` records in `rotation.json` stay and are never looked up. Decided by: records keep their form; skills-read-only-the-current-layout.
- `areas.json` replaces `"extraction"` with `"surface"`: the intent's path, or null. Where there is no intent or no declaring file, stderr says "areas: no surface intent at .ok-planner/surface/surface.md (or it names no declaring file); the run hunts files alone", and the session puts that in the return.
- This project's `.ok-planner/review/project.md` also drops `.ok-planner/documentation/` from its out-of-scope list, since true-up archives the folder. Decided by: WI 5's back-out.

**Changes**
- `plugins/ok/families/ok-planner/scripts/review`, changed:
  - `flow_areas` is rewritten per the calls (new constants `SURFACE_INTENT_PATH`, `DECLARING_HEADING`).
  - `hunt_settings` drops the three keys from its required list.
  - `area_keys`, `area_priority`, and `cmd_rotate` use `flow:` keys with a hash.
  - `cmd_areas` notes and writes `"surface"`.
  - `cmd_hunts` sets the flow brief to `area %s; hunt %d; class %s; declared in %s`.
  - `--only` matches flow areas by declaring file (unchanged rule).
- `plugins/ok/families/ok-planner/skills/converge/prompts/hunt-flow.md`: changed. The brief names one class and its declaring file. Trace starts by reading the declaring file whole and listing every entry point of that class it declares. The close result counts the entry points found and traced.
- `plugins/ok/families/ok-planner/skills/converge/SKILL.md` lines 14 and 86 (analysis mode): changed. Flow areas come from the surface intent's declaring files. Without an intent or declaring files, file areas only, said in the return.
- `plugins/ok/families/ok-planner/review/seed/config.json`: changed. `hunt.flow_area_size`, `hunt.flow_kinds`, and `hunt.extraction` are removed.
- `plugins/ok/families/ok-planner/review/CLAUDE.md`: no change needed (it names `hunt` generally).
- `.ok-planner/review/config.json` (this project): changed. The same three keys are removed.
- `.ok-planner/review/project.md` (this project), changed:
  - "Running the product" drops `/audit` from the slash-command list.
  - The checks list drops `checks/ceremony-surfaces`.
  - The out-of-scope line drops `.ok-planner/documentation/`.
  - WI 1, WI 5, WI 8, WI 10, and WI 12 also edit this file, so the stages chain.

**Behavior changes**
- **B22** `plugins/ok/families/ok-planner/scripts/review::cmd_areas` / `flow_areas`. Before: flow areas come from `.ok-planner/audits/surface/extraction.json`'s public entries of `hunt.flow_kinds`, `flow_area_size` per area. After: one per declaring file the surface intent names, with no stored list. Users: in the release: `skills/converge/SKILL.md`, `review hunts`, and `prompts/hunt-flow.md` (rewritten). Across Trued-up projects (stored state): a surface intent written by the audit's intent stage has no declaring-files section. Ruling: migrate: the run hunts file areas alone and says so until a sprint's surface intent delta names the declaring files (call; the owner's ruling, brief §4).
- **B23** `plugins/ok/families/ok-planner/scripts/review::hunt_settings`. Before: a config lacking `flow_kinds`, `extraction`, or `flow_area_size` is refused. After: they are neither required nor read. Users: across Trued-up projects (stored state): review configs holding the keys (ignored) and new seeds without them. Ruling: preserve (call). Both shapes are accepted, and true-up drops the keys (WI 5).
- **B24** `plugins/ok/families/ok-planner/scripts/review::area_keys` / `cmd_rotate` (`rotation.json`). Before: flow stamps are `entry:<kind> <id>`. After: `flow:<class>@<path>` with a hash. Users: across Trued-up projects (stored state): existing rotation records. Ruling: migrate: old `entry:` stamps are ignored, and each flow area counts as never hunted on the first run (call).

### 8. The repo's checks follow the back-out

**Calls**
- `checks/vendored-layer` accepts a tracked `.claude/skills/<name>` folder the payload no longer carries when its `SKILL.md` carries the suite stamp and the payload's `admin/true-up` lists `<name>` in `RETIRED_VENDORED` or `RETIRED_WHERE_STAMPED`. It prints that folder as "retired by the payload; the owner's next /ok removes it". This repo's `.claude/skills/audit/` and `document/` stay until the owner runs `/ok`, which no agent may run (project.md). Without this, the check fails for the whole sprint. Decided by: WI 8 ("pass with the skills gone"); project.md's limits.
- `checks/owned-paths` follows WI 5's code:
  - It drops the `"audit-corpus reset"` region, its needle, and its `os.remove` `"p"` site.
  - It renames and narrows the `"resolve"`, `"settings-resolve"`, and `"worktree-resolve"` regions to the new code.
  - It pins the new write sites: `archive`/`archive_path` (rooted under `os.path.join(ok_dir, "history")`), the stamp-line rewrite through `write_owner`, the `.cache/audit` sweep inside `RETIRED_ESTATE`, the `docspec/` move through `move_path`, the hunt-key drop in `review_config`, and the undecodable-facts filing through `intake_command`.
  - It keeps `check_forbidden_git` (the worktree steps still run plain `git worktree remove` and `git branch -d`).
  - Decided by: WI 8 ("pins the migration of work item 5").

**Changes**
- `checks/ceremony-surfaces`: removed.
- `checks/run`: changed. The loop drops `ceremony-surfaces`.
- `checks/oscillation`: changed. `audit_flips` and `parse_audit` are removed, and the call `audit_flips()` goes. The clean line becomes "oscillation: no section churn in history".
- `checks/owned-paths::check_planner`: changed per the call.
- `checks/vendored-layer`: changed per the call. A new reader of the payload true-up's two retired lists.
- `checks/sprint-boilerplate`: no code change. It passes once WI 4's lines join `retired-boilerplate.json`.
- `checks/token-resolution`, `checks/materialized-standalone`: no code change. They pass once WI 1/3/4 remove every `{{AUDIT-*}}` and `{{RELEASE-DOCUMENTS-RULE}}` consumer and define the new tokens.

**Improvements**
- **I1** `checks/oscillation::git` / top level. A9: when ROOT is not a readable git repository, every `git()` returns None and the check prints "no unexplained flips". Afterward: where `git rev-parse --git-dir` fails, it prints "oscillation: cannot read git history at <root>" and exits 1. The report-only exit 0 stays for real findings.

**Behavior changes**
- **B25** `checks/run`. Before: it runs `ceremony-surfaces`, which fails once the skills are gone. After: it runs six checks. Users: in the release: maintainers, `.ok-planner/review/project.md`'s scripts list (WI 7). Ruling: rewrite.
- **B26** `checks/oscillation`. Before: it reports audit determination flips and section churn. After: section churn only, and it exits 1 on unreadable history (I1). Users: in the release: `checks/run`. Ruling: rewrite.
- **B27** `checks/vendored-layer`. Before: any tracked `.claude/skills/<name>` outside the payload is unsanctioned. After: a stamped folder the payload's true-up retires passes with a note. Users: in the release: `checks/run`. Ruling: rewrite.

### 9. One table of every call, vetoed at the close

**Calls**
- The tracker picks out calls through a new run config key, `calls`: a list of `{"pool", "states"?, "kinds"?}` selectors set with `tasks config set`, like `item_states` and `swept_roles`. Where `calls` is unset, the default is `[{"pool": "divergences"}]`, which is what `render` reads today, so a build run needs no declaration and older run files render unchanged. Decided by: plumbline-coding rule 2 (sibling `swept_roles`); the Trued-up projects boundary (the run log format).
- The certification calls are defects at `declined` or `duplicate`, failures at `not-owed` or `rejected`, reports at `rejected`, and `calls` items of kind `unlisted`. A duplicate is a dismissal made without the owner, so it is a row. A fixer's `noticed` and `question` items stay out of the table, because they already reach the intake. Decided by: the ruling ("every judgment an agent makes without the owner").
- Columns: `kind` is the item's `kind` field, else its state; `site` is the `site` field, else `file`, else the first of `files`, else `story:<story> <surface>/<variant>` for a failure, else `-`; `choice` is the `choice` field, else the first line of the body (the fallback serves run files whose `-build.md` predates this sprint); `stage or role` is a build item's key, or for a certification row the role of the task that recorded it, or `session` where no task did. Decided by: the ruling's columns.
- Certification rows show their id as `cert:<item id>`, because both runs number items from `i1`. Decided by: one table needs unique ids.
- A builder records each I-id it lands as `kind=improvement`: the ruling's "taken improvements".
- `site` and `choice` are written as fields when the call is recorded (`--field choice="<one line>"`). The merge also adds `--field site=` to each new defect, so the table can read a decline's site.
- Boilerplate step 13 re-renders with `tasks --file .ok-planner/sprints/<name>-run.jsonl render ... --certification <ledger>` before it appends the return, because `/converge`'s `tasks init` has moved the tracker's pointer to its own ledger.
- When the owner vetoes a row, the session files one issue for it with `issues file`: kind `human`, category `product-intent`, the problem being the row and the owner's words, for the next `/plan-sprint`. It asks nothing else. Decided by: the intake is where owner decisions wait.
- In sprint mode the return lists no calls, because the report's table carries them. In drive, analysis, and defects mode the return gains a `calls` line with what `tasks calls` prints.
- `@story: veto-calls-made-in-my-absence` goes on the shared table function in `tasks`.
- Build note: `render --certification` opens the second ledger without moving the tracker's pointer (`write_pointer`), and reads that ledger's own `calls` config.

**Changes**
- `plugins/ok/families/ok-planner/scripts/tasks::call_rows` / `::calls_table`: new. Select call items through the `calls` config, or the default, and print `| id | kind | stage or role | site | choice |`, or `None.` when there are no rows. Cells pass through the existing `cell()`.
- `scripts/tasks::cmd_render`: changed. Prints `## Stages` as today, then `## Calls`, the table, in place of `## Divergences`. A new `--certification <run file>` opens a second `Store` on that ledger and adds its rows to the same table.
- `scripts/tasks::cmd_calls` (new verb `calls`), `::build_parser`, and the module docstring: new and changed. `calls` prints the table for the selected run. The docstring's `render` line, which says "two rendered sections", is updated.
- `skills/_sprint/shared.md::{{SPRINT-BUILD-PROMPT}}`, "Calls, forks, and what you notice" and the unlisted-change bullet: changed. Each `tasks item add --pool divergences` carries `--field site=<path::symbol> --field choice="<one line>"`. New sentence: record each I-id the stage lands as `--field kind=improvement`.
- `skills/converge/prompts/sprint-pass.md`, alignment outcomes and step 4: changed. An `improvement` item needs nothing, because the completion pass judges its I-id. An `unlisted` item carries `site` and `choice`.
- `skills/converge/prompts/fix.md`, Fix step 1: changed. Declined and duplicate set `--field choice=`.
- `skills/converge/prompts/merge.md`: changed. The new-defect add carries `--field site=`. Settling a report or failure as `rejected` or `not-owed` carries `--field choice=`, the ownership test's `left alone` rejection included.
- `skills/converge/SKILL.md`: changed. Setup step 5 also runs `tasks config set calls '[{"pool":"defects","states":["declined","duplicate"]},{"pool":"failures","states":["not-owed","rejected"]},{"pool":"reports","states":["rejected"]},{"pool":"calls","kinds":["unlisted"]}]'`. In the `## Calls` table, the `unlisted` reader becomes "the completion report's calls table, for the owner's veto". `## The return` gains the `calls` line in drive, analysis, and defects mode, and the `intake` line drops "in sprint mode also every `unlisted` call".
- `skills/converge/prompts/owner-list.md` line 9: changed. It names `unlisted` as a row of the completion report's table.
- `skills/plan-sprint/sprint-document.md`, "How to execute" steps 10 and 13: changed. Step 10 names `## Calls`. Step 13 re-renders with `--certification`, then writes the return block, then presents the `## Calls` table for veto, files each vetoed row, and walks nothing else.
- `plugins/ok/families/ok-planner/admin/retired-boilerplate.json`: changed. Every line removed from steps 10 and 13 is added, so true-up brings live sprints current and `checks/sprint-boilerplate` passes.
- `scripts/ok-planner-CLAUDE.md`, "Executing a sprint": changed. The report records the work done and every call, and the close presents the calls for veto. "divergences, and every fork claimed" goes.
- `.ok-planner/design/concepts/completion-report.md` and `concepts.md`: apply the delta and run `catalog-toc`.

**Behavior changes**
- **B101** `scripts/tasks::cmd_render`. Before: a `## Divergences` list with id, kind, key, state, body, and note. After: a `## Calls` table with id, kind, stage or role, site, and choice, plus certification rows under `--certification`. Users: in the release: sprint boilerplate steps 5, 10, and 13, and the CLAUDE.md template. Across Trued-up projects: a live sprint's boilerplate text and an older run file. Ruling: migrate: `retired-boilerplate.json` lets true-up bring live sprints' steps current, and an older run's items render with the body's first line as their choice (call).
- **B102** `skills/converge/SKILL.md::The return`. Before: declines are counted, and not-owed sorts and rejections are counted on `hunt`. After: a plain run adds a `calls` table, one row each, and sprint mode moves `unlisted` into the report's table. Users: in the release: the owner, and sprint-document step 13. Ruling: rewrite.
- **B103** `skills/plan-sprint/sprint-document.md`, step 13. Before: write the return and present the report; nothing renders after that. After: render with the certification calls, write the return, present the table for veto, and file each veto. Users: in the release: the executor. Across Trued-up projects: live sprints. Ruling: migrate: true-up's retired-boilerplate replacement (call).
- **B104** `skills/_sprint/shared.md::{{SPRINT-BUILD-PROMPT}}`. Before: divergence items carry a kind and a body. After: they also carry `site` and `choice`, and a new kind, `improvement`. Users: in the release: the sprint-pass alignment pass (updated above) and `review noticed`, which reads only `noticed`. Across Trued-up projects: a live sprint's existing `-build.md` keeps the old prompt. Ruling: preserve (call): rows without the fields fall back.

### 10. `run-group` lends no terminal

**Calls**
- `start` runs `subprocess.run(command, stdin=subprocess.DEVNULL, preexec_fn=...)`. The preexec function also sets SIGTTIN and SIGTTOU to ignored before it joins the group. Without the terminal lent, the run's group is a background group, and a command whose output is a terminal, or that opens `/dev/tty`, would otherwise stop on a terminal write, a mode change, or a read; the plain `waitpid` in `subprocess.run` never returns for a stopped child, so `start` would hang. With both signals ignored, the write proceeds and the read fails with EIO. Decided by: A5 ("a wait never returns"), and the delta's "runs the command with an empty input and keeps its caller's output".
- `HOLD_CODE` keeps ignoring SIGINT, SIGQUIT, and SIGTSTP. That is not terminal-lending code: it keeps the holder alive against a signal a project's own command sends to the group. Decided by: `stop` must find the holder (`holder_is_ours`).
- `start` still maps a signal death to 128 plus the signal number.
- Build note: put the SIGTTIN and SIGTTOU dispositions in a new preexec for `start` and leave `join_group` alone, since `scripts/stack` passes `group.join_group(pgid)` and changing it would change `stack up`'s start command too.
- Build note: on Ctrl-C, `subprocess.run` kills only the direct child, and the rest of the run's group lives until `stop`. Say so in `USAGE` and in the stack helpers reference, and map the interrupt's exit in `start`'s owner frame.
- Build note: the stack helpers reference's line "ok-planner's process calls no helper" sits beside the amended decision's "serve ... the suite's own process"; the stages that edit the opening (work items 2 and 10) leave one statement.

**Changes**
- `plugins/ok/families/ok-planner/scripts/run-group`: removed: `foreground_terminal`, `hand_terminal`, `take_back`, `lent_wait`, `run_lent`, `exit_code`, `TERMINAL_FDS`, and the `GROUP.TERMINAL.UNCHECKED` event. Changed: `start` runs the command with its input from `/dev/null` and terminal stops ignored; `join_group`, or a new preexec beside it, sets the two signal dispositions and calls `setpgid`; `USAGE` drops its terminal paragraph and says input comes from `/dev/null`.
- `plugins/ok/families/ok-planner/docs/stack-helpers.md`: changed. The opening says the helpers and the reference stack tool are for scripts to call, not for an owner to run by hand. The `run-group` `start` bullet says "with its input from `/dev/null`, and the caller's output and environment" and drops the Ctrl-C, Ctrl-Z, `bg`, and `fg` sentences.
- `.ok-planner/review/project.md`, the `run-group` entry: changed. "with the caller's input and output" becomes "with its input from `/dev/null` and the caller's output", per the build prompt's script-entry rule.
- `.ok-planner/design/decisions/stack-helpers-serve-project-commands.md` and `decisions.md`: apply the delta and run `catalog-toc`.
- `scripts/stack` is unchanged. It calls `group.holder_group` and `join_group` with its own `DEVNULL` input, and none of the removed functions.

**Behavior changes**
- **B105** `scripts/run-group::start`. Before: at a terminal where `run-group` is in the foreground, the run's group got the terminal: the command read it, and Ctrl-C and Ctrl-Z reached the run; elsewhere the command got the caller's stdin. After: input is always `/dev/null`, Ctrl-C reaches only the caller's group, and a terminal read or write never stops the command. Users: in the release: `scripts/stack`, which does not reach it. Across Trued-up projects: a project's own stack script that pipes input into `run-group start`, or runs it at a terminal, gets EOF where it got its input; no compatible form keeps that input and meets the ruling. Ruling: rewrite across Trued-up projects: the owner's ruling on `run-group-lends-terminal` orders input from `/dev/null`, and this release is a major version.

### 11. A browser tool for this project's drivers

**Calls**
- The build task writes `.mcp.json` with the entry `/setup-web` step 3 gives, with `<project-name>` set to `ok-plugins`. The builder does not invoke `/setup-web`, which only an explicit slash command starts. Decided by: the ruling (option A) and the skill's entry.
- `.claude/settings.json` gains no `enabledMcpjsonServers` key. The owner approves the server at the next session start, as `/setup-web`'s follow-ups say.
- `.ok-planner/review/project.md` drive step 3 ("or its JSON routes with `curl`") stays. Option B's text change was not ruled.

**Changes**
- `.mcp.json`: new. Its one entry is `{"mcpServers":{"chrome-devtools":{"command":"npx","args":["-y","chrome-devtools-mcp@latest","--userDataDir=${HOME}/.cache/chrome-devtools-mcp/profiles/ok-plugins"]}}}`.

**Behavior changes**
- **B106** `.mcp.json`. Before: no session in this project has a browser MCP server. After: every session started after the owner approves loads `chrome-devtools` and has `new_page`. Users: in the release: drivers, and every session of this project. `review owner` classes the file `declaration`, so `/converge` leaves it alone. The tool reaches a session only after a restart and the owner's approval, so this sprint's own certification drive, run in the session that builds the file, drives the dashboard's routes as today. Ruling: rewrite.

### 12. Unread counts include people's messages

**Calls**
- No read-mark decision needs amending: `read-marks-kept-per-person` already allows the change ("how far into each discussion"), and so do `unread-issues-count-as-new` and `agent-revisions-reach-the-owner`.
- A message is unread to a reader when its `n` is above the reader's mark and its `by` is not the reader's name (`ledger["name"]`). The reader's own messages never count. A withdrawn message counts by its number like any other. Decided by: the ruling ("counts once, by its number").
- The ledger gains a top-level marker, `"marks": "every-message"`. A ledger without the marker is converted once, under `locked(root)`, by the first `seeded_ledger` or `mark_read` that reads it: an entry whose mark is at or above the record's highest agent message takes the record's highest message number, which keeps exactly what the old rule counted; every other entry keeps its mark; `fresh_ledger` writes the marker. Decided by: the stored-state boundary (migrate, stored data converted), and plumbline-coding rule 3 (one lock).
- The CLI's `show` prints `, new` on a person's message as it does on an agent's. The page tags it `new` too.
- Notes review: a new message is numbered above every number the record ever issued, a removed one included, through an additive record field that both shapes read, so a reader whose mark equals a removed message's number still sees the next message as unread. B107 gains this. Ruling: preserve (call). Decided by: A9 (an unread count that reports nothing new).
- Build note: `mark_read` calls `read_ledger` inside `with locked(root)`; convert an unmarked ledger under the caller's lock and never take it twice.
- Build note: `IssueDetail.svelte` wraps the `new` tag in `{#if isAgent(m)}`; the person-message branch needs the tag too.

**Changes**
- `plugins/ok/families/ok-planner/scripts/issues`: `agent_mark` is renamed `read_mark`, the highest `n` over every message (users: `fresh_ledger`, `mark_read`). `unread_message(m, entry, reader)` counts any message by someone other than the reader above the mark; `unread`, `shown_message`, and `view` pass the reader's name from the ledger. `read_ledger`, `seeded_ledger`, and `mark_read` convert an unmarked ledger. `message_line` adds `, new` for a person's message. `cmd_read` prints `message(s) marked read`. The `--unread` help says "open issues with messages you have not read, or that you have never read".
- `plugins/ok/families/ok-planner/browser/src/views/IssueDetail.svelte`: changed. The `fresh` class and the `new` tag apply to any message, not only `isAgent(m)`. `dist/` is built at release.
- `skills/_shared/artifact-definitions.md::{{ISSUE-FILE-FORMAT}}`: changed. `unread` becomes "the messages others wrote that the reading person has not read". "mark each agent message ... `new`" becomes "each message another person or an agent wrote". The ledger rule adds that reading marks every message read.
- `scripts/ok-planner-CLAUDE.md` (the intake's unread paragraph) and `scripts/ok-planner-cheatsheet.md` ("Discussing"): changed. Every message on an open issue, a person's included, stays unread to each person but its author until that person reads the issue.
- `.ok-planner/review/project.md`, the `issues` entry: changed. `--unread` lists "open issues with messages you have not read".

**Behavior changes**
- **B107** `scripts/issues::unread_message`/`unread`. Before: only agent messages count. After: every message by someone other than the reader counts. Users: in the release: `select` (`list --unread`), `summary_line`, `show --json`, the dashboard's `GET /api/issues` and `unread=1`, and the page's unread tab and `n new` badge. Ruling: rewrite.
- **B108** `scripts/issues::read_mark`/`mark_read`/`fresh_ledger`. Before: a read sets the mark to the highest agent message. After: to the highest message. Across stored state: each person's ledger under `.ok-planner/.cache/read/`. Ruling: migrate: an unmarked ledger is converted once under the lock, so issues with nothing unread under the old rule stay read (call).
- **B109** `scripts/issues::shown_message`, `message_line`, and `IssueDetail.svelte`. Before: only agent messages carry `new`. After: a person's unread message carries `new` on `show`, `show --json`, and the page. Users: in the release: the page and the CLI reader. Ruling: rewrite.
- **B110** `scripts/issues::cmd_read` and the dashboard's `POST .../read` `marked`. Before: "N agent message(s) marked read", counting agents only. After: "N message(s) marked read", counting every unread message. Users: no code parses either; the page ignores `marked`. Ruling: rewrite.

### 13. The oscillation check's comments pass the lint

**Calls**
- Rationale the deleted comments carried that still matters moves into names. `walk_oldest_first` replaces the reversed-`shas` comment. The fence rule stays as code, since `fence_mark` already names it. Decided by: plumbline-cheatsheet Comments.
- The module comment block (lines 2–17) goes entirely. Its audit half describes what WI 8 removes. Lands in the same stage as WI 8.
- Build note: drop the `walk_oldest_first` rename; the comment it replaced sits inside `audit_flips`, which work item 8 deletes.

**Changes**
- `checks/oscillation`: changed. Lines 2–17, the trailing comments at 49–50, and lines 104–105 are deleted. The docstrings are strings, which the lint's python grammar does not flag, so they stay.

**Behavior changes**
None. Every change is new code no existing user reaches.

### 14. Sign-off checks a subject or practice delta's form

**Calls**
- The reviewer reads `.ok-planner/practice-definitions.md` whole. That file is not a token-definitions file (`checks/token-resolution` `DEFINITIONS`), so it cannot be transcluded; the reviewer enforces each rule it states for a subject and a practice without restating it. Decided by: plumbline-coding rule 6, and `single-source-transclusion`.
- Findings are classed as for the other forms. Mechanical: a missing or extra section, frontmatter that does not match, a `subject:` that does not resolve. Judgment: a `How to find them` that yields no count (a topic), a practice condition with no yes or no, a `What it buys` only taste settles, a prohibition or an exemption.

**Changes**
- `plugins/ok/families/ok-planner/skills/_shared/design-doc-compliance-reviewer.md::{{DESIGN-DOC-COMPLIANCE-REVIEWER-PROMPT}}`: "Your job" names subject form and practice form. New `### Subject form`: frontmatter `subject: <slug>`, and exactly `## What it is` and `## How to find them`, with no policy. New `### Practice form`: frontmatter `practice:` and `subject:` naming a live subject or one a delta of this sprint adds, and exactly `## Practice`, `## When it governs`, `## What it buys`, affirmative. Cross-reference integrity covers `subject:` and `practice:` references and the `subject:` frontmatter. The out-of-scope TOCs add `subjects.md` and `practices.md`. The lead paragraph names the practice-definitions read beside the transclusions. The scope example may list a `.ok-planner/practices/` path.

**Improvements**
- **I101** `design-doc-compliance-reviewer.md`, "Cross-reference integrity". A9: the rule requires "a live artifact file", so a reference to an artifact a delta of the same sprint adds reports `Issues Found` over a correct draft. Afterward: a reference resolves to a live artifact, or to one a delta in scope adds.

**Behavior changes**
- **B111** the reviewer's status. Before: a malformed subject or practice delta returns `Approved`. After: it returns `Issues Found` with each form violation. Users: in the release: `/plan-sprint` step 7, which fixes mechanical findings and re-dispatches until clean. Ruling: rewrite.
- **B120** (I101) the reviewer's status. Before: a reference to a sprint-added artifact is a violation. After: it resolves. Users: in the release: `/plan-sprint` step 7. Ruling: rewrite.

### 15. The conduct's writing standard reaches every write

**Calls**
- The hook builds its context from the output style's section 1 bullet list, read at run time, followed by `user-prompt-submit.md`; the `.md` carries no second copy of the standard. Decided by: plumbline-coding rule 6. Where the extraction is empty, the hook writes a message naming the output style file on stderr and exits 1, so a non-blocking UserPromptSubmit error shows that message, not a silent default (rule 4.6).
- The injected text opens with a heading for the standard that binds everything the session writes and says. The `### When Responding to the User ###` section keeps its delivery rules.
- The `Conduct version:` stamp is not edited, because `/release` owns it (`plugins/ok-conduct/CLAUDE.md`).

**Changes**
- `plugins/ok-conduct/output-styles/ok-conduct.md`, section 1, first paragraph: changed. "This standard governs everything you write and say: every message to the user, and every file, report, issue, commit message, and prompt you write." The `ok-plumbline` hand-off sentence is deleted, and the reason line says the style loads the standard for every session it governs.
- `plugins/ok-conduct/hooks/user-prompt-submit`: changed. It extracts the `## 1.` section's `- ` lines from the style, puts them under the standard's heading, and appends the `.md`.
- `plugins/ok-conduct/hooks/user-prompt-submit.md`: unchanged unless the builder retitles it; it keeps "When Responding to the User".
- `plugins/ok-conduct/CLAUDE.md`, "Plugin purpose": changed. The per-turn reminder re-anchors the writing standard, read from the output style, and the conduct's delivery rules.

**Behavior changes**
- **B112** the conduct's output style and its per-prompt context. Before: the standard is scoped to messages, names a hand-off no hook performs, and the per-prompt text carries only delivery rules. After: the standard binds every write and is restated with every prompt. Users: every session under the conduct. Across Installed plugins: the user's installed copy updates whole, and no other part reads this text; `session-start` reads only the version line, which stays. Ruling: rewrite.

### 16. `/converge` handles every unfinished close

**Calls**
- Fix tasks, one rule beside the existing `partial` rule: a fix task that closes `blocked` or `disputed`, or `partial` with any result other than `outside files:`, is refiled once with `tasks refile` and drained. After a second such close, its defects still `fixing` go back to `open` with `kickbacks` raised by one, so they reach `stuck` and the owner list files them as judgment issues. Decided by: the sibling rule at Loop 2 step 4.
- `tasks refile` must copy `batch_items`, or the verifier and the backout never see a refiled fix task's defects (`review::cmd_verifies` and `cmd_backouts` read `batch_items`). `COPIED_ON_REFILE` lacks it today.
- Merge tasks, in every mode, one paragraph at the top of Loop 1: a merge that closes with any outcome but `done` is refiled once and drained; after a second, the session names the merge in the return. In analysis mode the session also records a count item for each area and hunt in the brief that has none: `new=0`, plus `unmerged=<the open reports>`, so the tally stops that area instead of re-hunting it. Every report and failure the brief names that still stands `open` goes to the owner list. Decided by: the siblings (hunt and driver `partial` refiled once).
- `merge.md` makes its counts safe across attempts: each count is taken over every report of the area and hunt in the pool, whatever attempt settled it, recorded once just before a `done` close; where an earlier attempt recorded an item for that area and hunt, the merge updates it with `tasks item set`. A merge that cannot finish closes `partial`, naming what it settled.
- The owner list files each report and failure still `open` as a `category: defect` issue saying no merge agent judged it, after the `review owner` check it applies to a `noticed` call, and sets the item to `backlog` with the issue id as the note. Decided by: the cheatsheet's defect issues; triage verifies such claims.
- Review root: where the root's task closes with any outcome but `done`, or the run holds no pass task forked from it, the session refiles the root once with `tasks refile` (`retry` refuses a `done` close). Where the second root also does not finish, the run stops, says the review did not run with each root's outcome and result, and presents no return block, so the completion report carries no certification and the contract stays open. Decided by: `team-execution-cold-gate` ("the only review the work gets"), and sprint-document step 11 (stop on certification unrunnable).
- Pass tasks forked from a root that did not finish are left as they close; the merge deduplicates their reports.
- Build note: owner-list's rule for a `declined` or `duplicate` defect with no `verified` field reaches only a defect the loop left unverified, since Loop 2 step 5 sends the rest back to `open`. Say which defects it covers, and file such a defect once: it is not also a calls-table row.

**Changes**
- `plugins/ok/families/ok-planner/skills/converge/SKILL.md`: Loop 1 intro gets the merge rule, which the backlog merge, drive step 5, analysis step 3, and sprint step 5 all obey. Sprint step 1 gets the root rule. Loop 2 step 4 gets the blocked and disputed rule. `## The return`: `hunt` names each merge that closed unfinished twice and the open items it left, and `sprint` reads entry points from the root that finished.
- `skills/converge/prompts/merge.md`, "Count" and "Close": changed, as above.
- `skills/converge/prompts/owner-list.md`: "Read" adds reports and failures at `open`, and defects at `declined` or `duplicate` with no `verified` field (work item 18); "A defect outside the run's reach" files them unconfirmed; the close result counts them.
- `plugins/ok/families/ok-planner/scripts/tasks::COPIED_ON_REFILE`: adds `"batch_items"`.
- `scripts/review::cmd_verifies`: refile chains, under work item 18.

**Behavior changes**
- **B113** `converge/SKILL.md`, Loop 2 step 4. Before: `blocked` and `disputed` fix tasks leave their defects at `fixing` and unreported. After: refiled once, then their defects go back to `open` with `kickbacks` raised, so they end `stuck` and filed. Users: in the release: the owner list and the return. Ruling: rewrite.
- **B114** `scripts/tasks::cmd_refile`. Before: a refiled task loses `batch_items`. After: it keeps them. Users: in the release: `review verifies`, `review backouts`, and the converge refile steps; build, hunt, and drive tasks carry no `batch_items`. Across Trued-up projects (the run log format): the field is additive, and an older run's refiles read as before. Ruling: preserve (call).
- **B115** `converge/SKILL.md` merge steps, `merge.md`, and `owner-list.md`. Before: an unfinished merge leaves its reports and failures `open`, and nothing reports them. After: refiled once, then named in the return, a zero count stops the area, and every open item is filed as an unconfirmed defect issue. Users: in the release: the tally, the owner list, `/triage-issues`, and the return. Ruling: rewrite.
- **B116** `converge/SKILL.md`, sprint step 1. Before: a root that did not finish lets the run go on and return as if reviewed. After: the root is refiled once, and the run then stops with no return block. Users: in the release: sprint-document steps 11–13 and completion contract item 3. Ruling: rewrite.

### 17. The discovery reviewer knows its last pass is final

**Calls**
- The Phase 2 reviewer prompt gets a `### This pass` slot the session fills: `Cycle <N> of 3` in the fix loop, or `Back-edge pass` at step 6c. Its pass is final when it is cycle 3, the back-edge pass, or a pass it reports `Approved`. The back-edge pass never loops (step 6c), so it is final too.

**Changes**
- `plugins/ok/families/ok-planner/skills/discover-design/SKILL.md`: the Phase 2 Reviewer Prompt adds the slot and ties "final pass" to it. Process 5b and 5c fill the slot each cycle, and 6c fills `Back-edge pass`.

**Improvements**
- **I102** `discover-design/SKILL.md`, the reviewer's "Final-pass uncertainty filing". Two writers file the same thing: its bullet "Findings unresolved at the cycle cap" duplicates step 5d, where the session files "Findings still open at the cap", and the two filings take different ids. Afterward: the bullet goes, and step 5d alone files the open findings.

**Behavior changes**
- **B117** the Phase 2 reviewer's filing. Before: on the capped cycle and the back-edge pass, residual-uncertainty issues go unfiled. After: they are filed. Users: in the release: the intake and `/triage-issues`. Ruling: rewrite.
- **B121** (I102) the intake after a capped Phase 2. Before: each open finding may be filed twice. After: once, by step 5d. Ruling: rewrite.

### 18. A verifier checks every declined or duplicate defect

**Calls**
- A verifier that accepts a decline leaves the defect at `declined` or `duplicate`, sets `--field verified=<its task>`, and writes its note. Moving it to `verified` would lose the decline in `review::DEFECT_NOT_REAL` in the tally, in the return's `fixed` counts, and in the calls table, which reads `declined` and `duplicate` (work item 9).
- After the verifiers close, a defect still `declined` or `duplicate` with no `verified` field goes back to `open` with `kickbacks` raised by one: the sibling of "a defect still `fixed`".
- `cmd_verifies` reads each refile chain whole: it takes a round's fix task that no later task names as `previous`, collects `batch_items` and `staged` across its chain, and files one verify per chain. Without this, work item 16's refile copy would file two verifies for the same defects. It also fixes today's verify of a partial-then-refiled fix, which names only the first attempt's files.
- Build note: `cmd_verifies` walks refile chains by `previous` within the snapshot's round only, since a refiled task takes the round current when it is refiled.

**Changes**
- `plugins/ok/families/ok-planner/scripts/review::cmd_verifies`: walks refile chains in the snapshot's round and names defects at `fixed`, `declined`, or `duplicate`. A chain that staged nothing gets an empty `before:` list. `VERB_HELP["verifies"]` becomes "file one verify task per fix task that set a defect fixed, declined, or duplicate".
- `skills/converge/prompts/verify.md`: "Read" says a declined or duplicate defect has no change of its own: read the code at its site as it stands, and for a duplicate, the defect it names. Where the check holds, a declined or duplicate defect gets `--field verified=<task>` and keeps its state. A send-back is unchanged.
- `skills/converge/SKILL.md`, Loop 2 step 5: verifies are filed for fixed, declined, and duplicate defects, and unverified declines are sent back.
- `skills/converge/prompts/owner-list.md`: unverified declines become defect issues (shared with work item 16).

**Behavior changes**
- **B118** `scripts/review::cmd_verifies`. Before: it files no verifier for a declined or duplicate defect, and verifies a refiled fix only against the first attempt's staged files. After: every fixed, declined, or duplicate defect gets one verifier per fix chain, over every file the chain staged. Users: in the release: converge Loop 2 step 5, `verify.md`, and the run's cost. Ruling: rewrite.
- **B119** `verify.md` and converge Loop 2 step 5. Before: a decline ends the run unchecked. After: an accepted decline keeps its state with `verified`, and an unchecked decline goes back to `open`. Users: in the release: the owner list, the return's `fixed` line, and the contract's defect states, which are unchanged. Ruling: rewrite.

### 19. The vendored scripts read only the current layout

**Calls**
- `issues import` is the one verb that reads past an earlier layout. It is the converter's writer that only true-up calls (with `--over-event-log` / `--over-archived-event-log`, and the dry run before a markdown move). Every other verb refuses with a `Refusal` of reason `layout`, exit 2, naming the file and saying "run /ok, which converts it". The intake decision makes the module the intake's only writer, and the front door converts an earlier intake. An event row with an id is an earlier layout, not a stray line under the amended intake-reads-past-stray-lines, so the stray-line rule is untouched. Decided by: issue-writes-through-one-module; intake-writers-are-gated (amended); WI 19.
- `issues::load` gains a keyword the payload's true-up passes for its in-process reads (`unfiled`, `open_issue_ids`), so diagnose over an unconverted intake does not crash. Decided by: per-project-pinning (administration runs from the payload).
- A retired message field `read` and the `owner` signer stay readable. They are fields a closed record keeps, not a layout. Decided by: intake-reads-past-stray-lines ("a field the schema no longer uses stays"); skills-read-only-the-current-layout ("a record in the archive keeps the form it closed with").
- The lint's root markers become `.ok-planner` alone. The administration (true-up, `/ok`) keeps every pre-migration marker, because it migrates them. Decided by: WI 19; filesystem-discovery-markers governs the administration.
- `{tag}` detection stays in `review drive-command` and `admin/true-up` uses the constant. The refusal message says to run `/ok`. True-up rewrites the line, or asks the owner to reword it.
- The dashboard needs no code change. It maps a `layout` refusal to 409 through `REFUSAL_STATUS`'s default, with the message.
- Notes review: B30 holds only where the plan moved the plumbline config; work item 5's go-ahead refuses while a blocked retired estate holds it.
- Build note: the earlier-layout refusal matches an event row with an id. `is_event` today is any dict with an `event` key; an id-less event line stays a stray line the module reads past, per intake-reads-past-stray-lines.

**Changes**
- `plugins/ok/families/ok-planner/scripts/issues`, changed:
  - `read_store`/`transaction` refuse a store with an event row, or with markdown files under `.ok-planner/issues/`, unless the caller is the converter.
  - `cmd_import` passes the converter flag.
  - `stray_notes` drops the event and markdown notes, now refusals. The stray-line note stays.
  - `main` prints the refusal.
  - `EVENT_LOG_OFFERS` is removed.
  - The `--over-*` help text names `/ok`'s conversion.
- `plugins/ok/families/ok-planner/scripts/plumbline`, changed:
  - `CONFIG_PATHS` is `.ok-planner/config.json` alone (affects `configPathFor`).
  - `RETIRED_LINT_CHECK_NAMES` is removed. `lintChecksDefects` reports a compose name as "lint_checks names the retired check "<name>"; run /ok, which removes it".
  - `portsDefects` keeps the object-form defect with the text "…; run /ok, which converts it to the array of its names".
  - `declaredPortNames` reads arrays only.
  - `DEFAULT_IGNORE_PATTERNS` drops `.ok-plumbline/` and `.ok-workspaces/`.
  - `ROOT_MARKERS` is `.ok-planner` alone.
- `plugins/ok/families/ok-planner/scripts/ports::declared_names`: changed. An object refuses, naming `/ok`. `scripts/stack` inherits this through `ports.declared_names`.
- `plugins/ok/families/ok-planner/scripts/review`, changed:
  - `project_folders` drops the `retired_ports` filter and says "run /ok".
  - `OWNER_PATHS` drops the `.ok-plumbline/*`, `.plumbline-budget.json`, and `.ok-planner/issues/` entries.
  - `cmd_drive_command`'s `{tag}` message says to run `/ok`.
- `plugins/ok/families/ok-planner/admin/true-up`: changed. `unfiled`/`open_issue_ids` pass the converter keyword. The compose-name removal is reordered (WI 5).
- `plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md` §1, `skills/converge/SKILL.md` step 1, `skills/triage-issues/SKILL.md` line 27, `skills/discover-design/SKILL.md` line 42: changed. Where `issues list` refuses for an earlier layout, say that `/ok` converts it, and stop. The stray-line note is still passed on.

**Behavior changes**
- **B28** `plugins/ok/families/ok-planner/scripts/issues::read_store` / `main`. Before: every verb reads past event rows and markdown intake files, with a stderr note. After: every verb but `import` refuses (exit 2), naming `/ok`. Users: in the release: plan-sprint, converge (`review backlog`), triage, discover-design, the dashboard, `scripts/surface-corpus`, and true-up's in-process reads (keyword). Across Trued-up projects (stored state): intakes still holding the pre-v9 log or markdown files. Ruling: migrate: true-up's plan converts them under the one consent before the new module serves any verb, and an unconverted project keeps its own vendored module (call).
- **B29** `plugins/ok/families/ok-planner/scripts/plumbline::lintChecksDefects` / `loadConfig`. Before: `compose-ports`/`compose-labels` under `lint_checks` are accepted and ignored. After: they are a config defect, so the lint exits 1 and the edit hook shows the message. Users: in the release: the lint, the edit hook, `review project_folders` (`config-check`), and true-up's `config_defects`, which removes the names before it gates. Across Trued-up projects (stored state): configs holding the names. Ruling: migrate: true-up's plan removes them in the run that writes the new lint (call).
- **B30** `plugins/ok/families/ok-planner/scripts/plumbline::configPathFor` / `ROOT_MARKERS` / `DEFAULT_IGNORE_PATTERNS`. Before: the lint falls back to `.ok-plumbline/config.json` or `.plumbline.json`, roots at retired markers, and ignores retired estates. After: none of these. Users: across Trued-up projects: projects still on the plumbline layout. Ruling: migrate: true-up moves the old config and removes the estates in the same plan (call).
- **B31** `plugins/ok/families/ok-planner/scripts/ports::declared_names` (via `scripts/stack`, `plumbline::declaredPortNames`, `review::project_folders`). Before: the object form of `ports` is read as its keys. After: it refuses, naming `/ok`. Users: in the release: `stack up`, `ports lease`, the lint's `config-check`, the review. Across Trued-up projects (stored state): configs in the object form. Ruling: migrate: true-up's plan converts the form to the array of its names (call).
- **B32** `plugins/ok/families/ok-planner/scripts/review::OWNER_PATHS` (retired estate entries). Before: `.ok-plumbline/subjects/…` reads `corpus`, and `.ok-plumbline/audits/`, `budget.json`, `.plumbline-budget.json`, `.ok-planner/issues/` read `record`. After: no class. Users: across Trued-up projects: un-migrated estates. Ruling: migrate: true-up removes or archives those estates in the plan that writes the new tool (call).
- **B33** `plugins/ok/families/ok-planner/scripts/review::cmd_drive_command`. Before: a `{tag}` line is refused with "rewrite the line…". After: the refusal says to run `/ok`. Users: in the release: `/converge` drive steps, which name the output tail. Ruling: rewrite.

### Files the two halves of the notes share

- `skills/converge/SKILL.md` and `prompts/merge.md`, `fix.md`, `verify.md`, `owner-list.md`, `sprint-pass.md`: work items 4, 7, 9, 16, 18.
- `skills/_sprint/shared.md`: work items 4 and 9.
- `skills/plan-sprint/sprint-document.md` and `admin/retired-boilerplate.json`: work items 4 and 9.
- `scripts/ok-planner-CLAUDE.md` and `scripts/ok-planner-cheatsheet.md`: work items 2, 5, 9, 12.
- `skills/_shared/artifact-definitions.md`: work items 1, 3, 5, 12.
- `skills/_shared/design-doc-compliance-reviewer.md`: work items 1, 3, 14.
- `skills/discover-design/SKILL.md`: work items 1, 17, 19.
- `docs/stack-helpers.md`: work items 2 and 10.
- `.ok-planner/review/project.md`: work items 1, 3, 5, 7, 9, 10, 12, 18, 19.
- `scripts/review`: work items 4, 7, 18, 19.
- `scripts/tasks`: work items 9 and 16.
- The catalog TOCs: every delta-bearing stage.


## How to execute this sprint

This sprint is self-sufficient. Every executor — an inline session,
an agent handed this file via `/goal`, an orchestrator with its own
planning — runs the same shape: record the base commit, plan the work
into the task tracker as small build tasks cut from the
implementation notes, drain them, then run sprint certification once.
No review runs during the build.

1. Read the sprint whole first: intent, deltas, work items,
   implementation notes, completion contract. The sprint is the whole
   brief: context from the intake (`.ok-planner/issues.jsonl`) or
   `history/` may disagree with what the owner approved. Raise a gap
   with the owner.

2. Record the base. Sprint certification reads the change from this
   commit, so the tree holds nothing but this sprint's work from here
   on. The planning session leaves its own files uncommitted: this
   file, its delta sidecar, `.ok-planner/release-boundaries.md`, the
   intake's two files (`.ok-planner/issues.jsonl` and
   `.ok-planner/history/issues.jsonl`), and the sketches it archived. Where `git
   status --porcelain` lists a path outside `.ok-planner/`, name those
   paths to the owner and stop, because certification would count
   them as this sprint's work. Otherwise write the output of `git
   rev-parse HEAD` to the file beside this sprint with the same
   filename, `-base` before the extension and `.txt` as the
   extension.

3. Open the run. The task tracker at `.ok-planner/bin/tasks` and the
   profiles under `.claude/agents/` are required; a missing one is
   the front door's administration (`/ok`) to materialize: say so and
   stop. `tasks init <sprint-name> --file
   .ok-planner/sprints/<sprint-name>-run.jsonl`, `tasks agent
   register ok-opus`, and register the `build` prompt: write
   `{{SPRINT-BUILD-PROMPT}}` from `.claude/skills/_sprint/shared.md`,
   its transclusions resolved and `[SPRINT PATH]` filled, to
   `.ok-planner/sprints/<sprint-name>-build.md`, then `tasks prompt
   register build <that path>`. Declare the roles whose close carries
   a sweep: `tasks config set swept_roles '["build", "fix"]'`, so a
   build task closes `done` only with the sites its searches
   returned, each one staged.

4. Plan the work into stages from the implementation notes. Read the
   code each work item's notes name, in the tree as it stands now,
   before you file anything. Where the tree has moved since the
   notes' commit and a named site no longer matches, plan from the
   outcome the notes state and record the difference as a divergence
   call. Cut the sprint into stages, each **the smallest change that
   makes progress toward the completion contract and leaves the tree
   runnable**: it builds, nothing is half-wired, and the work after it
   can build on it. A stage lands one work item or a part of one. A
   work item that needs more than one agent's reading set becomes
   several stages in sequence. A taken improvement lands in the same
   stage as the change to its definition. Per stage, file one build
   task: `tasks file --role build --prompt build --agent ok-opus
   --key <stage> --files <the paths it may edit> --cites <the work
   items and slugs> --after <the build tasks of the stages it builds
   on, omitted where it builds on none> --brief "<the work items it
   lands, the improvements and deltas it applies, the behavior
   changes it carries by id with their rulings, and where the code
   is and what to reuse>"`. Two stages whose files overlap are
   chained with `--after`; a stage that applies a delta reaches its
   collection's catalog TOC too (`.ok-planner/design/concepts.md`,
   `stories.md`, or `decisions.md`, or `.ok-planner/subjects.md` or
   `.ok-planner/practices.md`, every one of which
   `python3 .ok-planner/bin/catalog-toc` regenerates), so two
   delta-bearing stages overlap. Stages with disjoint files run together. Apply a
   delta no work item implements in a stage of its own.

5. Render the completion report with the staged list before the first
   drain: write the output of `tasks render --title "<this sprint's
   title>" --sprint <this sprint's path>` to the report file (step
   10).

6. Keep the progress checklist. Where the harness task tools are
   available, mirror the stages as a live checklist. Create one entry
   per stage when the build tasks are filed. Mark an entry in progress
   when its build task is dispatched, and done when that task closes
   `done`. Add one entry for sprint certification when the drain ends.
   The run file is the record and the checklist is display.

7. Drain with the loop at `.claude/skills/_tasks/drain.md`.
   A build that closes `partial` is refiled for its remainder with
   `tasks refile <task>`; one that closes `partial` with a result
   starting `outside files:` is refiled with that path added to its
   files. A build that closes `blocked` is refiled once. The session
   builds nothing and reviews nothing itself, and edits no file a
   running task owns.

8. Every stage applies its corpus deltas as part of the work that
   realizes them, and every new or amended story implemented in code
   carries the `@story:` annotation at the site that realizes it. The
   build prompt carries both rules. `.ok-planner/audits/` and
   `.ok-planner/experiments/` belong to `/audit`.

9. Uncommitted work is the only record of the run. Every task stages
   the paths it touched as it closes (`git add <paths>`), and the run
   records them. Never run `git checkout`/`restore`/`reset`/`stash`/
   `clean` on your own initiative. Fix a bad edit forward by editing
   again.

10. The completion report lives beside this sprint file, same
    filename with `-completion` before the extension. The session
    re-renders it whole from the run before every dispatch: `##
    Stages` from the build tasks and `## Divergences` from the run's
    `divergences` pool. Build tasks record calls, forks, and what
    they noticed as items; the report is rendered, never
    hand-edited.

11. Work unsupervised to a defensible done. Do not pause for
    approval, confirmation, or progress checks. Execution and sprint
    certification need no owner action: file no task for the owner to
    perform. The archive and the commit after completion stay the
    owner's one act. Stop only on a genuine blocker: a credential or
    access you cannot obtain, a step impossible in the current state,
    a destructive or irreversible action not clearly authorized, a
    task closed `blocked` twice, or sprint certification being
    unrunnable for you. Surface that and stop. Ambiguity is not a blocker: the builder makes the most
    plausible call and records it, or records a fork and builds the
    reading it judges best. Sprint certification reads both.

12. Code complete means every stage's latest build task closed
    `done`. Then run sprint certification, immediately after:
    `/converge sprint <this sprint's path>`. It judges the change
    from the commit in the `-base.txt` file to the working tree,
    once, against this sprint: every outcome and taken improvement
    works, a user gets what every story promises when a driver uses
    the running product, every delta landed, every ruling holds, no
    unlisted behavior change breaks a user, and the project's checks
    pass. It fixes each defect in the sprint's scope, a drive failure
    the sprint's change caused among them, and verifies each fix on
    its own diff. A drive failure in code the change did not reach,
    and any other defect outside the sprint's scope, goes to the
    intake as a `category: defect` issue for the next `/converge`,
    and a question only the owner can decide goes to the intake for
    the next `/plan-sprint`.
    It ends by presenting its return block.

13. Write the return block into the completion report, after its
    rendered sections, under a `# Sprint certification` heading, with
    the `/converge` run's ledger path. Nothing renders the report
    after this. Then present the completion report and offer the
    archive and the commit below as one owner act. Ask the owner
    nothing else: every defect the run could not fix and every
    question it raised is already in the intake, for the next
    `/converge` or `/plan-sprint`.

**The archive and the commit.** The owner archives this sprint and
commits the work; offer both as one owner act, and wait. "Finish the
sprint" and "follow the boilerplate" are not a yes; both ask for the
presentation. On the owner's yes:

1. Close each issue this sprint promoted: for each id that
   `.ok-planner/bin/issues list --sprint <this file's name>` prints,
   run `.ok-planner/bin/issues close <id> --as promoted`, which moves
   its record to `.ok-planner/history/issues.jsonl`.
2. Move this file, its completion report, its run file, its
   `-base.txt` file, its `-build.md` prompt, and its delta sidecar to
   `.ok-planner/history/sprints/`: `git mv` for a tracked file, `mv`
   for an untracked one.
3. Stage by name every path the sprint's change touched, every moved
   file at its new path, the `/converge` run's ledger and folder, and
   the intake's two files, `.ok-planner/issues.jsonl` and
   `.ok-planner/history/issues.jsonl`. Commit those paths alone
   with `git commit -- <paths>`, naming only paths that exist or that
   `git mv` removed, so nothing else standing in the index rides
   along.
4. Add `closed: <the commit's sha>` to the archived sprint as YAML
   frontmatter, and commit that edit alone. The next planning
   session reads that stamp to detect work done out of band.

The owner publishes; the run never pushes.

## Completion contract

The work is done when all of the following hold, each verifiable
from the repository as it stands:

1. Every corpus matches every delta above, applied verbatim (from
   the sidecar where a heading points there): `.ok-planner/design/`
   for a concept, story, or decision, and `.ok-planner/subjects/` or
   `.ok-planner/practices/` for a subject or practice, with its
   catalog TOC regenerated.
2. The project builds, and the checks `.ok-planner/review/config.json`
   lists under `checks` pass on every file the change touched, or fail
   only where sprint certification's return lists the failure as a
   `stuck` defect.
3. The completion report beside this sprint (same filename with
   `-completion`) carries the return block of sprint certification
   (`/converge sprint`) run on this sprint, under `# Sprint certification`: the run's find
   loop ran once, and every defect stands `verified`, `declined`,
   `duplicate`, or `stuck`, with every `stuck` defect listed for the
   owner.

**The goal rule, for any checker verifying this contract.** The goal
is met when items 1–3 verify against the repository as it stands.
Decide from the repository, never from the session transcript: an
earlier session may have done the work, and a term the transcript
does not show may hold on disk. A `stuck` defect listed in the
return, a check that still fails among them, is the owner's to take
up, and holds no term of the contract open.
Presenting the report, archiving, committing, and the
`closed:` stamp all follow completion; a pending archive-and-commit
offer is evidence the goal is met. `sprints/` and
`.ok-planner/history/sprints/` satisfy the rule alike, and a sprint
already archived with a `closed:` stamp is terminal. A missing
completion report, or one without the return block,
means not done. Nothing else counts either way.
