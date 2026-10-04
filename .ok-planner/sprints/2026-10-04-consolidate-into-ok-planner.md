# Sprint: Consolidate the suite into ok-planner

## Intent

This sprint folds everything the suite vendors into one family, ok-planner, and settles the open intake around that move. ok-plumbline folds in as the means by which ok-planner defines and maintains a project's coding standards; its lint survives as ok-planner's lint, configurable per project, and its eight skills retire. ok-workspaces retires its worktrees and keeps `run-tag` and a reworked `port-block`. `/audit` and `/document` become ok-planner skills. The events standard and a project's ruled practices join the accept list's rule sources, so review fixes breaches of them as defects. Analytical subagents ride opus. A project may declare the folders it owns. The concept invariance test is restated.

The sprint also brings the corpus up to the work that landed out of band since the last closed sprint: `/converge` and `/triage-issues` replacing `/certify-work` and `/verify-issues`, the task tracker, the narrowed events standard, the second rules file, and the conduct's per-prompt rules. The 27 corpus edits the v20.0.0 to v22.0.0 releases made outside any sprint are approved as they stand. The session-start hook stops telling the agent to read the concept index; a suite-owned rules file imports it instead.

Every project an earlier release converged is a user across the "Converged projects" release boundary: `/ok` recognizes every retired layout this sprint creates and migrates it, preserving everything the owner wrote.

Promoted issues:

- `concept-invariance-test-reads-as-any-change`
- `project-spans-paths-beyond-its-root`
- `analytical-subagents-ride-opus`
- `retire-the-worktrees-keep-run-tag-and-port-block`
- `consolidate-the-suite-into-ok-planner`
- `events-are-a-logging-discipline-enforced-by-review`
- `practice-violations-are-a8-defects`

## Corpus deltas

Every body below lives in the sidecar folder `2026-10-04-consolidate-into-ok-planner-deltas/`, under `concepts/`, `stories/`, or `decisions/` by kind.

### New concept: defect

body: in the sidecar

### New concept: task-tracker

body: in the sidecar

### New concept: accept-list

body: in the sidecar

### New concept: release-boundary

body: in the sidecar

### New story: find-and-fix-defects

body: in the sidecar

### New story: concurrent-stacks-without-port-collisions

body: in the sidecar

### New story: project-spans-folders

body: in the sidecar

### New story: veto-calls-made-in-my-absence

body: in the sidecar

### New decision: one-vendored-family

body: in the sidecar

### New decision: converge-finds-then-fixes

body: in the sidecar

### New decision: drive-tries-each-story-as-a-user

body: in the sidecar

### New decision: analysis-hunts-until-converged

body: in the sidecar

### New decision: accept-list-decides-defects

body: in the sidecar

### New decision: defects-outside-scope-become-defect-issues

body: in the sidecar

### New decision: release-boundaries-bind-changes

body: in the sidecar

### New decision: os-assigned-ports-read-back-by-run-tag

body: in the sidecar

### New decision: project-declares-its-folders

body: in the sidecar

### New decision: project-chooses-its-lint-checks

body: in the sidecar

### New decision: concept-vocabulary-imported-by-rules-file

body: in the sidecar

### New decision: practice-violations-are-defects

body: in the sidecar

### New decision: records-stay-out-of-context

body: in the sidecar

### Amend concept: issue

body: in the sidecar

### Amend concept: completion-contract

body: in the sidecar

### Amend concept: completion-report

body: in the sidecar

### Amend concept: corpus-delta

body: in the sidecar

### Amend concept: integration-contract

body: in the sidecar

### Amend concept: estate

body: in the sidecar

### Amend concept: materialized-artifact

body: in the sidecar

### Amend concept: cheatsheet

body: in the sidecar

### Amend concept: skill

body: in the sidecar

### Amend concept: true-up

body: in the sidecar

### Amend concept: citation-tag

body: in the sidecar

### Amend concept: practice

body: in the sidecar

### Amend concept: concept-artifact

body: in the sidecar

### Amend concept: design-corpus

body: in the sidecar

### Amend concept: conduct

body: in the sidecar

### Amend concept: run-tag

body: in the sidecar

### Amend story: certify-completion

body: in the sidecar

### Amend story: converge-project-estate

body: in the sidecar

### Amend story: corpus-audit

body: in the sidecar

### Amend story: edit-time-lint-enforcement

body: in the sidecar

### Amend decision: audit-audience-split

body: in the sidecar

### Amend decision: final-form-deltas

body: in the sidecar

### Amend decision: sprint-goal-read-from-the-repository

body: in the sidecar

### Amend decision: single-source-transclusion

body: in the sidecar

### Amend decision: generated-catalog-tocs

body: in the sidecar

### Amend decision: filesystem-discovery-markers

body: in the sidecar

### Amend decision: vendored-skills

body: in the sidecar

### Amend decision: lockstep-suite-version

body: in the sidecar

### Amend decision: per-project-pinning

body: in the sidecar

### Amend decision: whole-file-ownership

body: in the sidecar

### Amend decision: slash-only-activation

body: in the sidecar

### Amend decision: documentation-walk-in-composed-audit

body: in the sidecar

### Amend decision: adversarial-implementation-audits

body: in the sidecar

### Amend decision: tests-forbidden

body: in the sidecar

### Amend decision: event-kinds-as-conventioned-strings

body: in the sidecar

### Amend decision: no-execution-engine

body: in the sidecar

### Amend decision: team-execution-cold-gate

body: in the sidecar

### Amend decision: subagent-model-follows-job

body: in the sidecar

### Amend decision: steering-over-prose-lint

body: in the sidecar

### Amend decision: documents-generated-per-type-and-placed

body: in the sidecar

### Amend decision: per-run-artifact-tag

body: in the sidecar

### Retire concept: workspace

### Retire concept: stack-profile

### Retire concept: skill-family

### Retire concept: finding

### Retire story: isolated-parallel-workspaces

### Retire story: safe-workspace-teardown

### Retire story: inventory-event-kinds

### Retire story: explain-lint-rules

### Retire story: incremental-lint-adoption

### Retire story: one-ceremony-per-project

### Retire story: one-command-suite-upkeep

### Retire decision: worktrees-inside-project-root

### Retire decision: open-refuses-an-occupied-workspace

### Retire decision: teardown-gates-in-git-flags

### Retire decision: declared-stack-profile

### Retire decision: suite-owned-ceremonies

### Retire decision: ratchet-over-soft-start

### Retire decision: violations-are-remediation-not-issues

## Work items

1. **Move the payload into ok-planner.** Makes true: `decision:one-vendored-family`, `concept:integration-contract`, `concept:estate`, `concept:cheatsheet`, `concept:materialized-artifact`, `decision:vendored-skills`, `concept:true-up`. Every file the suite vendors into a project comes from ok-planner's payload: the lint and its edit hook, the catalog TOC generator, the standards documents (events, technical writing, practice definitions, coding rules, the plumbline cheatsheet), `run-tag`, `port-block`, the ok cheatsheet, and the agent-model and subagent-batching hooks with their settings wiring. ok-planner's converge core materializes all of them. The ok-plumbline and ok-workspaces families and the front door's own ceremony layer no longer exist as sources. Most other items build on this one.

2. **The front door administers one family.** Makes true: `concept:integration-contract`, `concept:true-up`, `story:converge-project-estate`, `decision:filesystem-discovery-markers`, `decision:administration-is-a-user-act`, `decision:lockstep-suite-version`. `/ok` discovers the project by the planner's estate alone and converges one family. The per-family loop and the ceremony-layer step go. Its report and its list of retired verbs name every verb this sprint retires with its replacement or "retired". Depends on 1.

3. **`/ok` migrates every retired layout without losing owner content.** Makes true: `story:converge-project-estate`, `decision:whole-file-ownership`, `decision:filesystem-discovery-markers`. Run in a project an earlier release converged, `/ok` recognizes each retired layout and moves it to its new home: the plumbline estate's configuration, subjects, practices, their TOCs, and audits into the planner's estate, with the project's lint check choices and citation tags carried over; the workspaces estate removed, with a cleanup offer (never a silent removal) where live worktrees or `wt/*` branches exist; every retired skill, rules file, agent profile, and ceremony contribution removed from the vendored layer; hook wiring re-pointed at the new hook paths. Owner content arrives unchanged. A second `/ok` run changes nothing. Sprint certification's drive of `story:converge-project-estate` runs `/ok` against three copies: the linescout project's `platform/` folder (at `/Users/patrick/Documents/projects/research/linescout/platform`, copied, never the original), this repository, and a fresh project; on each it checks that owner content arrived unchanged, that retired pieces are gone, that hooks resolve, that live worktrees produced a cleanup offer, and that a second run, now against a project already at the current version, leaves the tree unchanged, as the same story requires. Depends on 1.

4. **`/audit` and `/document` become ok-planner skills.** Makes true: `decision:one-vendored-family`, `story:corpus-audit`, `story:practice-coverage-report`, `story:lint-rules-compliance-report`, `decision:document-composes-audit`, `decision:documentation-walk-in-composed-audit`, `decision:audit-audience-split`, `decision:adversarial-implementation-audits`, `decision:per-run-artifact-tag`. Each is one ok-planner skill with its contribution text folded in; the per-family contribution reading goes. The audit judge files the practice violations a coverage run finds as `category: defect` issues, one per practice, naming every breaking site; the audit file format and the planner's rules text drop the `## Remediation` section. The audit no longer flags an unconsumed `run-tag`, and the workspaces discipline pass goes. Depends on 1.

5. **Retire the plumbline skills.** Makes true the retirements of `story:explain-lint-rules`, `story:incremental-lint-adoption`, `story:inventory-event-kinds`, `decision:ratchet-over-soft-start`, and `decision:event-kinds-as-conventioned-strings`. `/budget`, `/events`, `/explain`, `/patterns`, `/port`, `/starter`, `/suggest`, and `/version` are gone, with every lint subcommand and file only they used (the budget file among them). What `/audit`'s sweep uses stays. Depends on 1.

6. **Each project chooses its lint checks.** Makes true: `decision:project-chooses-its-lint-checks`, `story:edit-time-lint-enforcement`, `decision:tests-forbidden`, `decision:comments-forbidden-by-default`, `concept:cheatsheet`. ok-planner's configuration names each lint check (comment hygiene, citation resolution, no tests) as on or off, defaulting on. The lint and its edit hook run only the checks that are on. Converge drops each off check's rules from the materialized rules text, so the text agents read and the lint never disagree. Depends on 1.

7. **A project declares its folders.** Makes true: `decision:project-declares-its-folders`, `story:project-spans-folders`, `decision:filesystem-discovery-markers`. One folders list in ok-planner's configuration, defaulting to the estate root, is read by the review tool in every mode, by the lint and its edit hook, by the audit's sweep, and by the surface extractor. The seeded review `project.md` describes the project as those folders. A sprint's folders outside the root stay an addition for that sprint's change. Depends on 1 and 4.

8. **Retire the worktrees; keep `run-tag`; rework `port-block`.** Makes true: `concept:run-tag`, `decision:per-run-artifact-tag`, `decision:os-assigned-ports-read-back-by-run-tag`, `story:fresh-artifacts-per-run`, `story:concurrent-stacks-without-port-collisions`. `/open`, `/close`, `/ok-workspaces`, worktree naming, the stack profile with its detection and offers, the teardown gates, and the workspaces cheatsheet go. `run-tag` and its per-run artifact rule land in ok-planner's rules text, materialized into every project. `port-block` reads back, by run tag, the host ports the OS assigned to a run's stack and prints them as `NAME=<port>` lines, one per name the project declares; where the stack cannot bind that way it refuses with a message saying the project's own stack commands must handle isolation. Depends on 1.

9. **Analytical jobs ride opus.** Makes true: `decision:subagent-model-follows-job`, `decision:team-execution-cold-gate`, `decision:documents-generated-per-type-and-placed`. Every prompt instruction that sends an investigation, relevance, enumeration, discovery, classification, compliance-reading, surface-extraction, or document-Method job to sonnet sends it to opus; the dispatch discipline drops "Do not upgrade reads"; the ok cheatsheet, the planner's embedded rules, and the administration text say so. The `ok-sonnet` profile retires and its tasks file for `ok-opus`. The agent-model hook keeps allowing sonnet. Depends on 4.

10. **The accept list names the events standard and ruled practices.** Makes true: `concept:accept-list`, `decision:accept-list-decides-defects`, `decision:event-kinds-as-conventioned-strings`, `decision:practice-violations-are-defects`, `concept:practice`, `concept:defect`. Entry A8's sources are the coding rules, the listed code-rule files, the live design corpus, the events standard, and the project's ruled practices. The review seed's `standards` default lists the events standard and the practices collection, so the hunt, fix, and verify prompts carry them in every project. The events standard drops its inventory section and the rule to read the inventory before adding a kind. The cheatsheet's Events section and its "violations are work" line, the practice definitions, and `/plan-sprint`'s violation step say a practice violation is a defect `/converge` fixes or files as a `category: defect` issue. Depends on 1 and 5.

11. **Restate the concept invariance test.** Makes true: `concept:concept-artifact`, `concept:design-corpus`. The invariance test in the shared artifact definitions, and every prompt that restates it, says: a sentence stays when it holds for every product that meets the same stories, whatever decisions that product makes; a sentence some such product could make false describes this build and goes. It carries the timeline example from `concept:concept-artifact`.

12. **The task drain loop becomes plumbing.** Makes true: `concept:task-tracker`, `decision:no-execution-engine`, `decision:team-execution-cold-gate`, `decision:slash-only-activation`, `concept:skill`. The drain loop's text moves to an underscore-prefixed shared folder and answers to no slash verb. `/audit`, `/converge`, `/triage-issues`, the sprint execution boilerplate, and the agent profiles' descriptions read it by path. Depends on 4.

13. **Retire the router skills.** Makes true: `concept:skill`. `/ok-planner` and the `checks/hub-rows` repo check that kept its table in step are gone. The `/ok-workspaces` router goes with item 8.

14. **The concept index reaches every session by import.** Makes true: `story:session-awareness`, `decision:concept-vocabulary-imported-by-rules-file`. A suite-owned rules file holds one import line, `@../../.ok-planner/design/concepts.md`, so every session loads the index whole before its first reply. The session-start hook drops its concept instruction and keeps its version line. Depends on 1.

15. **Delete the unwired conduct rewriter.** Makes true: `concept:conduct`, `decision:steering-over-prose-lint`. The six rewriter scripts under ok-conduct's `bin/` (`rewrite-draft`, `rewrite-prompt.txt`, `rewriter-env`, `warm-rewriter`, `conversation-extract`, `record-usage`) and the document describing only that technique are gone. The conduct's two wired hooks stay.

16. **Rules and planner text follow the consolidation.** Makes true: `concept:cheatsheet`, `concept:estate`, `concept:corpus-delta`, `concept:issue`, `concept:defect`, `decision:team-execution-cold-gate`. The ok-planner cheatsheet, the planner's embedded rules, the ok cheatsheet, the coding rules, and the plumbline cheatsheet's Tooling section describe one family and its estate. The artifact definitions' delta form names the subject and practice homes in the planner's estate. `/plan-sprint`'s estate table and its workspaces profile step follow the consolidation. `/converge`'s scope and exclude lists, its merge prompt, its coding rules, and the review seed's defaults name the new paths. Where `/audit` and `/document` text says "finding" for one defect, it says "defect". Depends on 1 and 3.

17. **Repository checks follow the new layout.** Makes true: `decision:vendored-skills`, `decision:single-source-transclusion`, `decision:whole-file-ownership`, `concept:integration-contract`. The checks under `checks/` pass against the consolidated layout, and every annotation that cites a retired slug is repointed or removed. Depends on 1, 4, 12, and 13.

18. **Maintenance prose and annotations.** Makes true: `concept:integration-contract`, `decision:lockstep-suite-version`, `decision:one-vendored-family`, `concept:accept-list`, `concept:release-boundary`, `decision:converge-finds-then-fixes`, `decision:drive-tries-each-story-as-a-user`, `decision:analysis-hunts-until-converged`, `decision:defects-outside-scope-become-defect-issues`, `decision:release-boundaries-bind-changes`. The repository's integration contract document, the `ok` plugin's and ok-planner's maintainer notes, and the release skill describe one family. Each new concept, story, and decision whose enforcing site the repository's standalone check for materialized files allows to carry a citation (the admin cores, `checks/`, the front door's skill, the release skill) carries its annotation there; an artifact whose enforcing sites lie only in materialized payload carries none, because a consumer's corpus could not resolve it. Depends on 1, 2, and 4.

## Implementation notes

Planned against commit `441d4aae359335b479ffb8c4ab412e4db810e18d`.

### Move the payload into ok-planner

**Calls**
- The payload root stays `plugins/ok/families/ok-planner/`. Removed: `plugins/ok/families/ok-plumbline/`, `plugins/ok/families/ok-workspaces/`, `plugins/ok/admin/`, `plugins/ok/ceremonies/`, `plugins/ok/rules/`, `plugins/ok/hooks/`. Decided by: `decision:one-vendored-family`.
- These homes govern every work item; where another item's notes name a different path for the same file, this list wins. Consumer paths stay put wherever no estate retires: `.claude/rules/ok-cheatsheet.md`, `plumbline-cheatsheet.md`, `plumbline-coding.md`, `.claude/hooks/ok-agent-model`, `.claude/hooks/ok-subagent-batching`. Only files an estate held move into `.ok-planner/`: `bin/plumbline`, `bin/catalog-toc`, `bin/run-tag`, `bin/port-block`, `hooks/post-edit.js`, `docs/events.md`, `docs/technical-writing.md`, `practice-definitions.md`, `package.json`, `config.json`, `subjects/`, `practices/`, `subjects.md`, `practices.md`, `audits/subjects/`. Decided by: the "Converged projects" boundary (rules file names and hook script paths cross it); every project's `## Code rules` names the two plumbline rules files and A8 names `plumbline-coding.md`, so only the lint's hook entry needs re-pointing.
- Subjects and practices live at the estate root beside `design/`. Decided by: `concept:design-corpus`.
- The lint and its hook stay in node; `port-block` is rewritten in python (item 8); the "no Node" constraint is amended by item 18. Decided by: scope, and A3 for the node-missing path.
- Where `node` is not on PATH, the core still writes the lint files, skips the run check, prints one line saying the lint needs node, and withholds the lint wiring block; no hook entry points at a missing interpreter. Decided by: A3.
- The lint's admin subcommands (`diagnose`, `vendor-skills`, `module-marker`, `wire-hooks`, `resolve`, `offers`, with `cleanupOffers`, `configDefects`, `COVERED_RULES`) are ported into the core's python; the binary keeps `lint` (default), `patterns`, and `version`. Decided by: `decision:one-vendored-family` and coding rule 6.
- All hook wiring moves into one `WIRINGS` table in the core, read with the ok core's guarded reader. The wiring blocks keep today's grouping, each its own consent: `wire-hooks session-start`, `wire-hooks subagents` (agent-model and batching), `wire-hooks lint` (PostToolUse, compared as a whole entry), and `wire-env`. A bare `wire-hooks` is refused with a usage line naming the groups. Decided by: `/ok`'s "each block is its own consent".
- Every moved file is stamped `{{OK_PLANNER_VERSION}}` and "Materialized by ok-planner v"; the lint's `0.0.0-unvendored` special case becomes the family placeholder. Decided by: `decision:lockstep-suite-version`.
- The subject and practice layout and TOCs are created on every converge. Decided by: the plumbline core it replaces.
- The module marker becomes `.ok-planner/package.json`, fixed content, no stamp. Decided by: the fixed-content carve-out in `decision:whole-file-ownership`.
- The review seed sets `checks` to `node .ok-planner/bin/plumbline` where `node` is on PATH and to `[]` otherwise, matching the node-missing call; `standards` per item 10 (the events standard and the practices collection). Decided by: work item 10 and A3.
- `plugins/ok/ceremonies/{audit,document}/SKILL.md` move to `families/ok-planner/skills/{audit,document}/` and are vendored by the core, so the tree runs before item 4 folds the contributions in; item 4's stage follows this one.
- Path changes in prose belong to item 16, which owns that text.
- Build notes from the notes review: `port-block` answers `-h`/`--help` with exit 0, so I4's probe passes; I4 skips the `plumbline version` probe where node is absent; the collision test learns each materialized file's stamp form (the rules files' line-3 prose stamp) and compares the fixed-content files (`package.json`, `ok-concepts.md`) by bytes; the ported diagnose and `config:` texts never name `plumbline starter`; the review tool's `project_folders` reuses `config-check`'s validation and treats a malformed config as the root alone with the `config:` offer standing; B123's live-sprint rewrite also covers a live sprint's `-build.md` prompt and its completion-contract line.

**Changes**
- New payload files under `families/ok-planner/`, moved from their old families: `scripts/plumbline`, `scripts/catalog-toc` (rooted at `.ok-planner/`), `scripts/run-tag`, `scripts/hooks/post-edit.js`, `scripts/hooks/agent-model`, `scripts/hooks/subagent-batching`, `scripts/ok-cheatsheet.md`, `docs/{events,technical-writing,practice-definitions,plumbline-cheatsheet,plumbline-coding}.md`.
- `scripts/plumbline`: drops the admin subcommands; `configPathFor` reads `.ok-planner/config.json`, falling back to `.ok-plumbline/config.json` and then `.plumbline.json` only when the new file is absent; `DEFAULT_IGNORE_PATTERNS` keeps `.ok-plumbline/` and `.ok-workspaces/` (B34); messages name `.ok-planner/config.json`; `CORPUS_CITATIONS` names `.ok-planner/subjects` and `.ok-planner/practices`.
- `scripts/hooks/post-edit.js`: the `PLUMBLINE_MARKERS` gate goes; every ok-planner project lints.
- `admin/converge::vendor_layer`: `SKILLS` adds `audit` and `document`; `RETIRED_VENDORED` adds the ok core's `ok-planner-audit`, `ok-plumbline-audit`, `ok-workspaces-audit`, `verify-corpus`, `certify-work` and plumbline's `slug` and `ci`; `expected()` adds the rules files and hooks; settings handling becomes the ok core's `read_settings`, `marked_entry`, `unusable_findings`, `unusable_entries`, `dropped_entries`, with the `settings:.claude/settings.json` offer and its resolve, over `WIRINGS`; new `wire-env` mode; `COVERED_RULES` gains `errors-reach-the-owner-frame.md`; the `config:`, `config-key:`, and `citation-tags:` offers are ported, `citation-tags` widening to `@concept:`, `@story:`, `@decision:` (where `design/` exists) and `@subject:`, `@practice:`; the missing-config offer goes (an absent file means the defaults), and `citation-tags:` fires when the config is absent too, drafting a new `.ok-planner/config.json` that holds only the citations, so a project's `@concept:`, `@story:`, `@decision:` annotations never read as comment residue (B35).
- `admin/converge` (bash): `SUBDIRS` adds `subjects`, `practices`, `audits/subjects`, `docs`; materializes the new scripts with their mode bits; runs `node .ok-planner/bin/plumbline version` where node exists; `estate_license` lists the new files.
- `admin/converge::review_config seed`: unconditional new paths.
- `review/seed/config.json::exclude`: drops `.ok-plumbline/` and `.ok-workspaces/`.
- `admin/ADMINISTRATION.md`: absorbs from `plugins/ok/admin/ADMINISTRATION.md` the subagent-model and batching rules and hooks, the env entry, the unusable-settings table, and the retired table; absorbs plumbline's lint wiring, config offers, and coding-style overlap scan; the modes list gains `wire-hooks <group>` and `wire-env`.

**Improvements**
- **I1** `admin/converge::vendor_layer` `wire-hooks` (A3): an unguarded `json.load` and `e.get` on entries that may not be objects end in a traceback on unparseable or oddly shaped settings. Afterward: every wire mode uses the guarded reader, refuses with the named unusable line, and the settings offer drafts the repair.
- **I2** `scripts/hooks/post-edit.js::lintStage` (A9): lint exit 1 (an internal error such as a malformed config) is read as clean, so enforcement goes silently off. Afterward: the hook exits 1 with the lint's stderr, a non-blocking error the user sees, and blocks only on exit 2.
- **I3** `admin/converge` rendering: one mechanism built twice (bash `sed`/`check_rendered` for estate files, python `expected()` for skills). Afterward: one `expected()` table covers every materialized file, executables with their mode bits included, and drives diagnose and converge.
- **I4** `admin/converge` materialization (A8 against `decision:vendored-skills`, which verifies a vendored executable runs when it is written): only the lint was checked. Afterward: the core runs `tasks --help`, `review --help`, `catalog-toc --help`, `run-tag`, `port-block --help`, and `plumbline version` after writing them, and stops with the failing path, writing nothing further.

**Behavior changes**
- **B1** Consumer estate layout. Before: lint, hook, standards, and practice definitions under `.ok-plumbline/`. After: under `.ok-planner/`. Users: in the release: the core, `/ok`. Across Converged projects: the review config's `checks` and `standards`, the PostToolUse entry, project files naming the old paths. Ruling: migrate: item 3 moves the estate, rewrites the review config, re-points the wiring, and offers repointed drafts of the project's own files (call).
- **B2** Stamps. Before: "ok v", "ok-plumbline v", "ok-workspaces v". After: "ok-planner v". Users: `ANY_OK_STAMP`, `review::MATERIALIZED_STAMP`, `agent-model::VENDORED_STAMP`, all of which accept the new stamp. Across Converged projects: none read the suffix. Ruling: preserve (call).
- **B3** `plugins/ok/admin/converge` removed; its modes move to the core. Users: in the release: `/ok` (item 2), `checks/owned-paths` and `checks/vendored-layer` (item 17), this repo's `project.md` (item 17). Ruling: rewrite.
- **B4** `wire-hooks` takes a group name. Users: in the release: `/ok` and the consent commands it prints. Ruling: rewrite.
- **B5** The lint loses `diagnose`, `vendor-skills`, `module-marker`, `wire-hooks`, `resolve`, `offers`. Users: in the release: the deleted plumbline core. Across Converged projects: a project script calling them. Ruling: migrate: each is refused with a message saying it retired (I7) (call).
- **B6** Projects that ran ok-planner alone gain the lint rules files, the standards, the subject layout, the lint hook offer, and `.ok-planner/package.json`. Users: across Converged projects: every planner-only project. Ruling: migrate: the `/ok` report names the new rules and the `lint_checks` switch, the hook stays behind consent, and without node nothing is wired (call). Decided by: the default in `decision:project-chooses-its-lint-checks`.
- **B7** A project carrying only a plumbline or workspaces marker is discovered and converges into the full ok-planner estate. Users: across Converged projects: those projects. Ruling: migrate (call). Decided by: `decision:one-vendored-family`, `decision:filesystem-discovery-markers`.
- **B8** Review seed defaults. Before: conditional on `.ok-plumbline/`. After: always set. Users: projects seeded after this release. Ruling: preserve (call).
- **B9** (I1) Wire modes on unusable settings. Before: traceback. After: a named refusal and an offer. Users: in the release: `/ok`. Ruling: rewrite.
- **B10** (I2) Hook on a lint internal error. Before: silent pass. After: a non-blocking error with the lint's message. Users: sessions in converged projects; hook and binary ship in one converge. Ruling: rewrite.
- **B11** (I4) Converge stops on a materialized executable that fails to run. Before: silent. Users: in the release: `/ok`. Ruling: rewrite.
- **B34** The lint's default ignore list. Before: skips `.ok-plumbline/` and `.ok-workspaces/`. After: unchanged, so kept scripts, pending worktrees, and leftover estate files a migration leaves are never linted. Users: across Converged projects: root lint runs, the audit's sweep, seeded checks, the hook. Ruling: preserve (call).
- **B35** `citation-tags:` on a project with no config. Before: the missing-config offer drafts a config declaring the corpus tags. After: `citation-tags:` drafts a config holding only the citations. Users: across Converged projects: planner-only projects B6 brings the lint into, and fresh projects. Ruling: migrate: the offer declares the tags before any check reads an annotation (call).
- **B36** `.ok-planner/package.json` scopes the module type of every `.js` file under `.ok-planner/`, `experiments/` included. Before: an experiment takes its type from the project's root `package.json`. After: CommonJS. Users: across stored state: `.js` experiments in a `"type": "module"` project. Ruling: rewrite: an experiment the work breaks stays broken until the next `/audit` repairs it (call).

### The front door administers one family

**Calls**
- The project is integrated if it carries `.ok-planner/` or a pre-migration marker (`.ok-plumbline/`, `.ok-workspaces/`, `.plumbline.json`, `.claude/rules/plumbline-cheatsheet.md`); otherwise one bootstrap question for ok-planner. Decided by: `decision:filesystem-discovery-markers`.
- The retired-verb rows, for `/ok`'s report and the ADMINISTRATION table: `budget` (retired; turn a check off with `lint_checks`); `events`, `explain`, `port`, `starter`, `suggest` (retired); `patterns` (retired; `/audit`'s lint sweep clusters violations); `version` (`/ok-version`); `open`, `close`, `ok-workspaces`, `ok-planner` (retired); `execute-tasks` (replaced by the drain loop read by path). Earlier rows stay. Decided by: the sprint's retirements.
- The plugin manifest descriptions change under item 18. Decided by: `.ok-planner/release-boundaries.md` (descriptions do not cross).

**Changes**
- `plugins/ok/skills/ok/SKILL.md`: description and opening name one family; step 2 uses the marker set above; step 3 has one candidate; step 3b deleted; step 4 drives the core once; step 6's consent commands are `wire-hooks <group>` and `wire-env` on the core; step 7 reports one row plus the retired-verb list; Boundaries drop `open`, `close`, and the ceremony layer; the annotation `@story: one-command-suite-upkeep` becomes `@story: converge-project-estate`.
- `families/ok-planner/admin/ADMINISTRATION.md`: the merged retired-verb table, and a section saying the ceremony verbs are the family's own.

**Behavior changes**
- **B12** `/ok` discovers by the planner's estate and the pre-migration markers, administers one core, and reports one row. Users: the owner, interactively; the plugin's name and verb are unchanged across Installed plugins. Ruling: rewrite.
- **B13** The env consent command moves to the core (`wire-env`), and the report lists the retired verbs. Users: in the release: `/ok`. Ruling: rewrite.

### `/ok` migrates every retired layout without losing owner content

**Calls**
- Each retired estate gets a plan settled before anything moves (`plumbline_plan()` then `migrate_plumbline()`; `workspaces_plan()` then `migrate_workspaces()`), copying the sibling `review_plan()` / `migrate_review()`. Unmerged paths, or tracked files missing from the working tree, block the move and diagnose says why. These run before the layout is created. Decided by: coding rule 2.
- Config: `git mv` `.ok-plumbline/config.json` (or a root `.plumbline.json`) to `.ok-planner/config.json`, bytes unchanged; then rewrite only the citation `file_template` values beginning `.ok-plumbline/subjects/` or `.ok-plumbline/practices/`, an idempotent repair run on every converge so a crash between the steps heals. A retired `checks` key is carried unchanged and offered by `config-key:` as today. Decided by: the retired-layout clause of `decision:whole-file-ownership`, and the `.ok-review` config rewrite precedent.
- Both old and new config exist: `config-conflict:<old>`, keep-new or keep-old.
- Subjects, practices, and `audits/subjects` entries move by `git mv`; a taken path is a `move-conflict`; TOCs move, then `catalog-toc` regenerates them.
- Suite-owned plumbline leftovers (`bin/`, `hooks/`, `docs/`, `ceremony/`, `practice-definitions.md`, `package.json`, `LICENSE`, `.DS_Store`) go silently when uncommitted-clean; one that differs or carries uncommitted changes becomes `estate-edits:<path>` with a `Show:` diff. Budget files become `retired-file:<path>`, delete. Any other file becomes `estate-leftover:<path>`, move or delete. The emptied `.ok-plumbline/` is pruned.
- The old workspaces run-tag copy (at `runTag.path`, else `srcTag.path`, else the default) is kept: it reads nothing, so it keeps working. It is offered as `retired-script:<path>`, listing the literal callers `git grep -F` finds, recommending decline while any caller is listed. A dev-server project's old `port-block` and the profile it reads are kept and offered the same way. Decided by: `story:converge-project-estate`. In linescout, `bin/allinone`, `bin/up`, `infra/allinone-fly`, `infra/env.sh`, and `src/gridiq/cli/instance.py` (as a path built in code no literal scan finds) call `.ok-workspaces/bin/src-tag`.
- Otherwise the workspaces profile, `config.proposed.json`, `LICENSE`, `ceremony/`, `.ok-workspaces/.gitignore`, the stamped ignore file at a custom in-repo prefix, and `.claude/rules/ok-workspaces-cheatsheet.md` (stamped on line 3) are removed, by `git rm` where tracked, so recoverable. Decided by: work item 3 and the retired-layout clause of `decision:whole-file-ownership`.
- Live worktrees under the profile's `dirPrefix`, `branchPrefix*` branches, or any content under the worktree directory become `worktrees:<dirPrefix>`, and the estate stays until settled. The fix refuses the whole set unless every listed tree is clean and every branch shows in `git branch --merged HEAD`; then `git worktree remove <path>` (no force) and `git branch -d` (no `-D`). Content that is not a registered worktree stays and is offered as `estate-leftover`. `.gitignore` is never removed while the worktree directory holds anything. Decided by: work item 3 and the retired close's gates.
- Project files (tracked, outside the estates, `.ok-planner/`, and `.claude/settings.json`, not suite-stamped) naming `.ok-plumbline/bin/plumbline` or `.ok-plumbline/bin/catalog-toc` become `script-path:<file>`, drafting the whole file with only those lines repointed. Decided by: the `review-wording` precedent.
- The old hook file goes with the estate; the `lint` wiring block, one consent, removes the entries for `.ok-plumbline/hooks/{post-edit,pre-write,stop-review,stop-instructions}.js` and adds the new one.
- For certification's drive: make a worktree in the fresh copy to exercise the worktree offer; check that linescout's `bin/up` still resolves `src-tag`; run `checks/run` on this repo's copy after committing the converge output.

**Changes**
- `admin/converge`: `plumbline_plan`, `migrate_plumbline`, `workspaces_plan`, `migrate_workspaces`: new; offer kinds `config-conflict`, `estate-edits`, `estate-leftover`, `retired-file`, `retired-script`, `worktrees`, `script-path`: new, each with a branch in resolve; a non-choice offer gains an optional `recommended`.
- `RETIRED_VENDORED`: gains the eight plumbline skills, `open`, `close`, `ok-workspaces`, `ok-planner` (item 13), and `execute-tasks` (item 12); `RETIRED_AGENTS` (item 9) is swept the same way.
- `RETIRED_RULES`: new, with `ok-workspaces-cheatsheet.md`, detected by stamp within its first five lines.
- `WIRINGS` lint group: the retired hook markers.
- `review_config` check/fix: rewrites inside `standards` and `checks` entries — `.ok-plumbline/docs/{events,technical-writing}.md` → `.ok-planner/docs/…`, `.ok-plumbline/{subjects,practices}` → `.ok-planner/…`, `.ok-plumbline/practice-definitions.md` → `.ok-planner/practice-definitions.md`, `.ok-plumbline/bin/{plumbline,catalog-toc}` → `.ok-planner/bin/…`; every other byte left alone; `exclude` left as is.
- `stale_wording_lines`: also matches `.ok-plumbline/` and `.ok-workspaces/bin/`.
- Diagnose reports each pending move as `retired layout:`.
- `admin/ADMINISTRATION.md`: offer table rows and a migration section per retired estate.

**Improvements**
- **I6** `admin/converge` owner-file writes (A1, coding rule 3.1): `review_config fix`, `write_text`, the wire modes' settings writes, and the template rewrite use plain `open(…,"w")`, so a crash mid-write truncates the owner's file. Afterward: through one helper that resolves `os.path.realpath(path)` and writes a temp file beside the real file, then `os.replace`, so a symlinked owner file keeps its link (B37).

**Behavior changes**
- **B14** `.ok-plumbline/` migrates into `.ok-planner/`. Users: across Converged projects: every plumbline project. Ruling: migrate: the plan and moves above; owner content byte-identical except the two citation templates; conflicts and leftovers offered (call).
- **B15** `.ok-workspaces/` removed, except the kept scripts. Users: across Converged projects: workspaces projects and their callers. Ruling: migrate: old scripts kept and offered; worktrees offered (call).
- **B16** The owner's review `config.json` `checks` and `standards` paths are rewritten without an offer. Users: across Converged projects: `/converge` (a stale path today drops the standard silently, and a stale checks command fails). Ruling: migrate: extends the documented `.ok-review` exception (call).
- **B17** The `review-wording` offer also fires on `project.md` lines naming retired estate paths. Users: across Converged projects. Ruling: migrate (call).
- **B18** `script-path` offers on project files. Users: across Converged projects. Ruling: migrate: a declined offer leaves the call failing with "not found" (call).
- **B19** Retired vendored verbs and the workspaces rules file are removed. Users: across Converged projects. Ruling: migrate: stamped files removed, project files offered, the report names replacements (call).
- **B37** (I6) Owner-file writes through a symlink. Before: `open(path, "w")` writes through the link. After: the helper replaces the real file, so the link stays. Users: across Converged projects: a symlinked `.claude/settings.json`, review `config.json`, or `project.md`. Ruling: preserve (call).
- **B20** The lint PostToolUse entry is re-pointed under consent; until consent, the dangling entry errors on each tool call and diagnose reports it as drift. Users: across Converged projects. Ruling: migrate (call).

### `/audit` and `/document` become ok-planner skills

**Calls**
- The skill bodies are `plugins/ok/families/ok-planner/skills/audit/SKILL.md` and `skills/document/SKILL.md`, each built from the front-door body plus the planner's contribution; the audit also takes the plumbline audit contribution. The workspaces contributions and the plumbline document contribution are dropped (they contribute nothing, or only the retired discipline pass). Decided by: `decision:one-vendored-family`.
- The goal files move beside the skills as `skills/audit/goal.md` and `skills/document/goal.md`, vendored to `.claude/skills/{audit,document}/goal.md` by the existing `skill_markdown` walk; each `/goal` line names the new path; `.ok-planner/ceremony/` retires whole. Decided by: `decision:one-vendored-family`.
- The coverage auditor's prompt moves into `skills/_shared/implementation-auditor.md` as `{{COVERAGE-AUDITOR-PROMPT}}`, registered as `subjects` at `.ok-planner/.cache/audit/subjects.md`. Decided by: `decision:single-source-transclusion`.
- The documentation walk is defined once, in `skills/document/SKILL.md`'s Walk section; the audit follows it by path (`.claude/skills/document/SKILL.md`). Decided by: `decision:documentation-walk-in-composed-audit` as amended.
- The coverage auditor files each practice's violating members as one `violation` escalation (fingerprint: the practice slug; body: every breaking site as `path:symbol`). The judge confirms it and files one `category: defect` issue per practice, kind `audit`, naming A8, every site, and the harm; before filing it runs `rg` over the intake for an open defect issue on that practice and files nothing where one stands. Decided by: `decision:practice-violations-are-defects`, and the dedupe rule of `decision:audit-audience-split`.
- A violation does not count toward `unaccounted:`; `unaccounted: 0` ⇔ `supported` stands. Decided by: the coverage shape in `{{AUDIT-DEFINITION}}`.
- The lint sweep runs the lint at its new path over item 7's folders and `plumbline patterns` (kept, per work item 5). The "no vendored binary, using the payload's copy" fallback is dropped: the skill exists only where converge also wrote the lint. Decided by: `decision:one-vendored-family`.

**Changes**
- `plugins/ok/families/ok-planner/skills/audit/SKILL.md`: new. The spine of `plugins/ok/ceremonies/audit/SKILL.md` without "suite verb", "Resolve the estates", or any contribution reading (`.ok-planner/` required); the planner contribution's sections folded in (Requires, Layout with `audits/subjects`, Surface, the goal handoff naming `.claude/skills/audit/goal.md`, Enumerate, Determine, Synthesize, Judge, Verify, Report, Close-out, Present, Boundaries); the plumbline sections folded in (subject Enumerate, the coverage task `--role subjects --prompt subjects`, the Lint step: mechanical violations to the report, judgment-class violations to `escalations` key `observation`). One report shape: the Receipt adds Subjects, Practice-violations (practices, sites, defect issues filed), and Lint lines; the `ok-workspaces` and Remediation sections are gone. The description drops "covering every estate this project has". Staleness output paths stay `.ok-planner/audits/`, now including `subjects/`.
- `.../skills/document/SKILL.md`: new. The spine of `ceremonies/document/SKILL.md` with the planner contribution folded in (Requires, Layout, Audit, Walk, Project, Assess, Distill, Generate with the writer's brief and Placement, Present, Boundaries); no estate table or contribution reading; the goal line names `.claude/skills/document/goal.md`.
- `.../skills/audit/goal.md`, `.../skills/document/goal.md`: new, from `ceremony/{audit,document}-goal.md`; the course points at the skill alone; the audit goal rule's term 2 reads "one audit file per live concept, story, decision, and subject"; the run file path stays `.ok-planner/tasks/audit-<date>.jsonl`.
- `plugins/ok/ceremonies/`, `families/ok-planner/ceremony/`, `families/ok-plumbline/ceremony/`, `families/ok-workspaces/ceremony/`: removed (the two family directories wholesale under item 1).
- `families/ok-planner/admin/converge::vendor_layer`: `SKILLS` and `UNPREFIXED` add `audit` and `document`; comments drop "they belong to the suite".
- `families/ok-planner/admin/converge` (top level): `CEREMONY`, `CEREMONY_VERBS`, `CEREMONY_FILES`, and the ceremony diagnose and materialization loops removed; `ceremony` leaves `SUBDIRS`; `RETIRED_ESTATE` adds the four `ceremony/*.md` files, each removed by name, then `rmdir ceremony/` when empty (never `rm -rf`); `estate_license` drops the ceremony clause; `render_ceremony` stays (the review catalogs use it).
- `families/ok-planner/skills/_shared/implementation-auditor.md`: gains `{{COVERAGE-AUDITOR-PROMPT}}` (writes `.ok-planner/audits/subjects/<slug>.md`, reads the new practice-definitions path, files a violating member as a `violation` escalation); "How consumers use this file" lists the fourth auditor and `subject:<slug>` refs; `{{AUDIT-JUDGE-PROMPT}}` gains the `violation` key (confirmed → one defect issue per practice after dedupe; refuted → a report line) and reads "as the coverage auditor defines".
- `skills/_shared/artifact-definitions.md::{{AUDIT-DEFINITION}}`: audits live at `.ok-planner/audits/{concepts,stories,decisions,subjects}/`; "or a remediation site" dropped. `::{{AUDIT-FILE-FORMAT}}`: the `## Remediation` section removed.
- `scripts/ok-planner-CLAUDE.md`: departing members go to the judge, filed as `category: defect` issues one per practice; the filers list adds practice violations; the goal path becomes `.claude/skills/audit/goal.md`; "each estate's" wording dropped.
- `scripts/ok-planner-cheatsheet.md`: the Audits section and Defect issues → Filing name the audit judge as a filer for practice violations.
- `families/ok-planner/admin/ADMINISTRATION.md`: "The ceremony goal files" names the new goal paths and the retired `.ok-planner/ceremony/`; "What the administration does NOT do" drops `ceremony/<verb>.md`.
- `plugins/ok/admin/converge`, `plugins/ok/skills/ok/SKILL.md`, `plugins/ok/admin/ADMINISTRATION.md`: the front-door ceremony layer goes (items 1 and 2), and that layer must not list `audit` or `document` as retired.
- Item 17's checks that read the removed paths: `checks/ceremony-surfaces`, `checks/token-resolution`, `checks/materialized-standalone`, `checks/vendored-layer`.

**Behavior changes**
- **B101** `.claude/skills/{audit,document}/`. Before: vendored by the front-door core, stamped `Materialized by ok v…`. After: vendored by the planner core, stamped `Materialized by ok-planner v…`. Users: in the release: the planner core's collision test, the front-door core. Across Converged projects: every project holding front-door-stamped copies. Ruling: migrate: the planner core overwrites a copy carrying either suite stamp; an unstamped copy is a `collision` offer as today (call).
- **B102** `.ok-planner/ceremony/` and the `/goal` line. Before: four files materialized there, the run hands `/goal … .ok-planner/ceremony/audit-goal.md`. After: the folder retires; the line names `.claude/skills/{audit,document}/goal.md`. Users: in the release: `ok-planner-CLAUDE.md`, ADMINISTRATION.md, both skills. Across Converged projects: estate file names. Ruling: migrate: converge removes the four stamped files by name and the folder when empty (call).
- **B103** The audit judge and coverage auditor. Before: violations listed under `## Remediation`, never filed. After: one `category: defect` issue per practice. Users: in the release: `/triage-issues`, `/converge` drive, analysis, and defects modes, `/plan-sprint` Frame. Ruling: rewrite.
- **B104** `{{AUDIT-FILE-FORMAT}}`. Before: an optional `## Remediation`. After: none. Users: across stored state: audit files carrying the section; nothing reads it. Ruling: migrate: the next `/audit` rewrites every audit whole (call).
- **B105** The audit's workspaces discipline pass. Before: four checks and an `## ok-workspaces` report section. After: gone. Users: in the release: the report reader. Ruling: rewrite.
- **B106** The coverage audit location. Before: `.ok-plumbline/audits/subjects/`. After: `.ok-planner/audits/subjects/`. Users: across stored state: existing coverage audits (a moved file reads as stale to `/document`, which re-runs `/audit`, failing safe). Ruling: migrate: item 3 moves them (call).
- **B107** The lint step's payload fallback. Before: falls back with a note. After: none. Users: none reach it. Ruling: rewrite.
- **B108** The `/audit` and `/document` descriptions and the missing-contribution conformance line. Before: "covering every estate"; a missing contribution reported. After: one estate, no contributions. Users: in the release. Ruling: rewrite.

### Retire the plumbline skills

**Calls**
- `patterns`, `version`, and the lint stay; `/audit` and converge use them. Decided by: work item 5.
- `docs/plumbline-porting-guide.md` and the family `README.md` do not move; only `/port` used the guide. Decided by: work item 5.

**Changes**
- `scripts/plumbline`: removes `explainCmd`/`EXPLAIN_TOPICS`, `budgetCmd`, `suggestCmd`/`SUGGEST_HEURISTICS`/`suggestForViolation`/`isLikelyCode`, `starterCmd`/`existsSomewhere`, `eventsCmd`/`collectEventKinds`/`eventScanFilter`/`EVENT_*`/`PROSE_EXTENSIONS`/`compareSites`/`isEventKindShaped`/`printUnreadFiles`, and their `SUBCOMMANDS` rows, plus any helper left with no caller.
- The eight skill folders: not carried.
- `RETIRED_VENDORED`: gains the eight (item 3).

**Improvements**
- **I7** `scripts/plumbline::main` (A3): `plumbline budget check` falls through to "target not found: budget". Afterward: a first argument naming a retired subcommand, where no such file exists, is refused with "plumbline: `<name>` is retired" and exit 1.

**Behavior changes**
- **B21** `/budget`, `/events`, `/explain`, `/patterns`, `/port`, `/starter`, `/suggest`, `/version` are gone from converged projects. Users: across Converged projects. Ruling: migrate: retired-verb removal, the report naming the replacements (call).
- **B22** The lint's `budget`, `events`, `explain`, `suggest`, `starter` subcommands. Before: they ran. After: refused with a retirement message (I7). Users: across Converged projects: CI scripts the porting guide suggested. Ruling: migrate: named refusal (call).

### Each project chooses its lint checks

**Calls**
- The key is `lint_checks` in `.ok-planner/config.json`: `{"comment-hygiene": bool, "citation-resolution": bool, "no-tests": bool}`; an absent key or name means on. It is not `checks`, so no stored config carrying the retired `checks` key is read anew. Decided by: the "Converged projects" boundary.
- Marker lines in the templates, `<!-- lint-check: NAME -->` through `<!-- /lint-check -->`, drop the block when that check is off; the marker lines are always stripped, and a `## ` section the drops leave empty is dropped. One `render_rules(text, checks)` applies this to every markdown file the core renders, and diagnose compares against the same rendering. Decided by: `decision:project-chooses-its-lint-checks`.
- A malformed config renders with every check on and gets the `config:` offer. Decided by: "A check is on unless the project turns it off".
- The lint wiring is offered whatever the switches say; the binary does nothing when all are off.

**Changes**
- `scripts/plumbline::loadConfig`: reads and validates `lint_checks`; an unknown name or a non-boolean value prints an error and exits 1.
- `scripts/plumbline::runLint`: skips off checks.
- `scripts/plumbline` `config-check [--config <file>]`: new; prints each defect in `citations`, `tests`, `lint_checks`, and `folders`; exit 0 clean, 2 with defects. The core's `config:` offer and its draft check call it, so lint-key validity is defined once.
- `admin/converge::render_rules`: new, used by `expected()`.
- Blocks marked in `docs/plumbline-cheatsheet.md`: comment-hygiene (the Comments bullets except citation tags, and the "ordinary comments and the lint rejects them" sentence); citation-resolution (the citation-tag bullet and the resolution paragraph); no-tests (the Tests section and the hook bullet's test clause); each check's own clause in Tooling.
- Blocks marked in `skills/converge/prompts/fix.md` (the no-test sentence) and `verify.md` (the test clause, on a line of its own).
- The `config-key` offer: reworded.

**Behavior changes**
- **B23** `config-key` offer text. Before: "all three checks always run". After: names `lint_checks`. Users: in the release: the `/ok` owner prompt. Ruling: rewrite.

### A project declares its folders

**Calls**
- `folders` in `.ok-planner/config.json` lists paths relative to the project root; each must resolve inside `git rev-parse --show-toplevel` and be an existing directory, or it is refused with a message naming the entry. The root is always in. Validation reuses `review::outside_paths`'s beside-the-root check through one helper. Decided by: `decision:project-declares-its-folders`.
- A lint run whose target is the project root lints the root plus the declared folders; any other target stays literal.
- `findProjectRoot` order: the nearest marker ancestor of the target; failing that, the marker root of `CLAUDE_PROJECT_DIR` or cwd when the target lies in one of its declared folders; failing that, today's fallback.

**Changes**
- `scripts/review::project_folders`: new.
- `scripts/review::scoped_files`: lists `ls-files` over the root and each folder.
- `scripts/review::changed_files`: merges the folders into the `outside` path set as a sprint's outside paths are merged; the sprint section stays an addition. `cmd_files`, `cmd_changed`, `cmd_checks`, `file_areas` follow.
- `scripts/plumbline`: `findProjectRoot` and the root-target expansion change; `config-check` covers `folders`; exports `findProjectRoot`, `loadConfig`, `inProject` under `if (require.main === module) main();`.
- `scripts/hooks/post-edit.js`: imports the binary's exports in place of its own `ROOT_MARKERS`, `resolveProjectRoot`, `isInsideRoot` (I5).
- `skills/audit/SKILL.md` (after item 4): the surface extractor brief names the folders.
- `skills/converge/SKILL.md`: the population sentence names the folders.
- `review/seed/project.md`: the root-and-scope instruction names `folders`.
- `admin/converge::seeded_project_md`: also recognizes the v23 seed text by a digest constant.

**Improvements**
- **I5** `scripts/hooks/post-edit.js` root resolution and inside-project gate: the binary's resolution built a second time in the hook. Afterward: the hook imports it, so one reader decides membership in the declared folders.

**Behavior changes**
- **B24** The seed text changes. Before: `review-facts` fires on the v23 skeleton. After: it still fires, because the digest list holds the old seed. Users: across Converged projects: never-filled `project.md` files. Ruling: migrate: both seed texts recognized (call).

### Retire the worktrees; keep `run-tag`; rework `port-block`

**Calls**
- `ports` in `.ok-planner/config.json` maps each `NAME` (`^[A-Z_][A-Z0-9_]*$`) to `{"service": str, "port": int}` (a container; the compose project name is the run tag; read back with `docker ps -q --filter label=com.docker.compose.project=<tag> --filter label=com.docker.compose.service=<service>`, then `docker port <id> <port>/tcp`) or `{"record": "<path with {tag}>"}` (a dev server that listens on port 0 and writes the port it got). Decided by: `decision:os-assigned-ports-read-back-by-run-tag`.
- Exit codes: 1 for a missing argument or one not matching `^run-[0-9a-f]{12}$` (the message says port-block reads back by run tag); 2 when no `ports` are declared (the refusal says the project's own stack commands handle isolation); 1 for a readback that finds nothing, naming the name and the tag; otherwise one `NAME=<port>` line per declared name, in declared order.
- Written in python and materialized in every project. Decided by: the family's script constraint.

**Changes**
- `families/ok-planner/scripts/port-block`: new.
- `scripts/run-tag`: moved and restamped; materialized at `.ok-planner/bin/run-tag`, beside `.ok-planner/bin/port-block`.
- `scripts/ok-planner-cheatsheet.md`: a new "Per-run artifacts and verification stacks" section carrying the old workspaces rule 3 and the port readback; the worktree rule goes.
- Removed, by not being carried: `skills/{open,close,ok-workspaces}`, `scripts/{detect,diagnose,offers,converge,vendored-skills}.js`, the workspaces cheatsheet, its `admin/*`, `CLAUDE.md`, `ceremony/*`, the old `port-block`.

**Behavior changes**
- **B25** `port-block`. Before: `<job>`, position arithmetic, dev-server projects only. After: `<run-tag>` readback at `.ok-planner/bin/port-block`. Users: across Converged projects: scripts calling the old copy. Ruling: migrate: the old copy and its profile are kept and offered (item 3), and the new one refuses a job argument with a message (call).
- **B26** run-tag path. Before: the profile's path. After: `.ok-planner/bin/run-tag`. Users: across Converged projects. Ruling: migrate: the old copy is kept (call).
- **B27** The workspaces rules file is gone; the run-tag rule continues in the planner cheatsheet. Users: across Converged projects. Ruling: migrate (call).
- **B28** `/open`, `/close`, `/ok-workspaces` removed. Users: across Converged projects. Ruling: migrate: retired-verb removal and the report (call).

### Analytical jobs ride opus

**Calls**
- The agent-model hook stays as it is, still allowing `sonnet` and listing three models. Decided by: `decision:subagent-model-follows-job` as amended.
- Retiring `ok-sonnet` needs an agent-profile retirement path the planner core lacks: `RETIRED_AGENTS = ("ok-sonnet.md",)`; a stamped file is removed, an unstamped one stays. Item 3's retirement sweep absorbs this list. Decided by: `decision:whole-file-ownership`.
- The rules keep "every dispatch names one of opus, sonnet, haiku" and add that no suite instruction sends a job to sonnet. Decided by: the delta.

**Changes**
- `plugins/ok/rules/ok-cheatsheet.md` (at item 1's home): every analytical job (investigation, relevance, enumeration, discovery, classification, compliance reading, the surface extractor, a document Method's leaf agents) rides opus; no suite instruction sends a job to sonnet.
- `families/ok-planner/skills/_shared/dispatch-discipline.md`: the same rule; "Do not upgrade reads or downgrade fixes" becomes "Do not downgrade a job".
- `skills/plan-sprint/core.md` (`{{RELEVANCE-PASS-PROMPT}}`), `skills/discover-design/SKILL.md` (both prompt blocks): `model: opus`.
- `skills/audit/SKILL.md` (item 4), the surface extractor: `model: opus`, and the "classification is an investigation job, so it rides sonnet" clause becomes the opus rule.
- `skills/document/SKILL.md` (item 4), the Method researchers: `model: opus`; "as sonnet dispatches" dropped.
- `families/ok-planner/agents/ok-sonnet.md`: removed.
- `admin/converge::vendor_layer`: `RETIRED_AGENTS` removed in converge and reported in diagnose.
- `scripts/ok-planner-cheatsheet.md`, `scripts/ok-planner-CLAUDE.md`: the profile lists drop `ok-sonnet`; the Method line reads "opus dispatches".
- The drain text from item 12: the profile list drops `ok-sonnet` (I101).
- `plugins/ok/admin/ADMINISTRATION.md` (wherever items 1 and 2 land it): the model each kind of job rides.
- `families/ok-planner/admin/ADMINISTRATION.md`: the retired-verb section gains a row for the retired `ok-sonnet` profile.

**Behavior changes**
- **B109** Analytical dispatches (relevance pass, both discoverers, the surface extractor, Method researchers). Before: sonnet. After: opus. Users: in the release; cost only. Ruling: rewrite.
- **B110** `.claude/agents/ok-sonnet.md`. Before: vendored. After: not vendored; a stamped copy is removed, so `tasks agent register ok-sonnet` fails with "no agent file". Users: in the release: nothing files for `ok-sonnet`. Across Converged projects: agent profile names, a hand-built run that registered `ok-sonnet`. Ruling: migrate: converge removes the stamped profile and leaves an unstamped one (call).
- **B111** The dispatch discipline's "Do not upgrade reads". Before: present. After: dropped. Users: in the release: every dispatching skill. Ruling: rewrite.

### The accept list names the events standard and ruled practices

**Calls**
- The seed's `standards` default lists the events standard and the practices collection, not subjects. Decided by: work item 10.
- An existing owner `config.json` is stored state that only an owner answer may change, so a `standards` list naming neither entry gets a `review-standards` cleanup offer that adds them; stale `.ok-plumbline/…` entries are rewritten silently by item 3, following the `review_config fix` precedent. Decided by: `decision:whole-file-ownership`.
- `hunt-file.md`'s A8 lens restates A8's sources, so it changes with A8. Decided by: coding rule 1.

**Changes**
- `families/ok-planner/review/catalog/accept.md`: A8's sources become the coding rules, the listed code-rule files, the live design corpus, the events standard (new path), and the project's live practices (new path); the sites column follows; "A8's three sources" becomes "A8's sources".
- `families/ok-planner/review/seed/config.json`: `"standards"` lists the events standard and the practices collection at their new paths.
- `families/ok-planner/admin/converge::review_config`: `seed` drops the `.ok-plumbline` override; `check`/`fix` gain a `review-standards` finding and offer through `offers()` and `resolve`.
- The events standard (new path): the "`/events` inventories the kinds" sentence dropped; "Before adding one, read the inventory…" becomes "A kind is unique in meaning across the tree."; "## The inventory" removed; the enforcement line names the accept list.
- The plumbline cheatsheet: the Events bullet "read `/events` before adding one" dropped; "Violations of a ruled practice are work…" becomes "a site that departs from its practice is a defect: `/converge` fixes it, or files it as a `category: defect` issue outside its scope".
- The practice definitions: a violation is a defect, which `/converge` fixes or files and which the audit files as one `category: defect` issue per practice; the traced-member exception stays a judgment issue.
- `skills/plan-sprint/SKILL.md`: "A violation is remediation work: it enters a sprint as a work item" becomes "A violation is a defect: it reaches the intake as a `category: defect` issue, offered at Frame like any other".
- `skills/converge/prompts/hunt-file.md`: the A8 lens names all five sources.

**Behavior changes**
- **B112** accept.md A8. Before: three sources. After: five. Users: in the release: hunters, merge, fix, verify, triage, owner-list. Ruling: rewrite.
- **B113** The seed `standards` default. Before: `[]`, or the plumbline paths where `.ok-plumbline/` existed. After: the events standard and the practices collection. Users: in the release: new projects. Across stored state: existing `config.json`. Ruling: migrate: item 3 rewrites stale plumbline entries; a list naming neither entry gets the `review-standards` offer (call).
- **B114** The events standard and the cheatsheet Events bullet. Before: an inventory section and "read `/events` before adding". After: neither. Users: in the release: fix and verify prompts, `{{CONVERGE-CODING-RULES}}`. Ruling: rewrite.
- **B115** Practice violations in the rules text and plan-sprint. Before: remediation work items. After: defects offered at Frame. Users: in the release: `/plan-sprint`. Ruling: rewrite.
- **B116** `hunt-file.md` A8 lens. Before: three sources. After: five. Users: in the release: analysis hunters. Ruling: rewrite.

### Restate the concept invariance test

**Calls**
- The story invariance test stays as it is. Decided by: work item 11's scope.

**Changes**
- `skills/_shared/artifact-definitions.md::{{CONCEPT-DEFINITION}}`: Invariance reads that a sentence under What it is or Boundaries stays when it holds for every product that meets the same stories, whatever decisions that product makes; a sentence some such product could make false describes this build and goes, to a decision or to code; it carries the timeline and edit-decision-list example.
- `skills/_shared/design-doc-compliance-reviewer.md`: the concept invariance check quotes each sentence that some product meeting the same stories under other decisions could make false; the classing is unchanged.
- `skills/plan-sprint/SKILL.md`: "survives a rebuild on a different surface" becomes "holds for every product that meets the same stories, whatever decisions it makes".

**Behavior changes**
- **B117** The concept invariance test. Before: the surface-or-implementation counterfactual. After: the same-stories, any-decisions counterfactual. Users: in the release: the compliance reviewer, the audit's `text:` axis, the discover-design writers. Across stored state: concept audits' `text:` verdicts, rewritten whole by the next run. Ruling: rewrite.

### The task drain loop becomes plumbing

**Calls**
- The loop lives at `plugins/ok/families/ok-planner/skills/_tasks/drain.md`, vendored as `.claude/skills/_tasks/drain.md`, with `_tasks` added to `SHARED`; no frontmatter, no activation phrase. Decided by: `decision:slash-only-activation` and `concept:skill` as amended.
- A live sprint's fixed boilerplate names `.claude/skills/execute-tasks/SKILL.md`; converge rewrites that one line in `.ok-planner/sprints/*.md`, never under `history/`. Decided by: the `contract_report` migration precedent.
- The tracker carries no `@concept:` annotation: `checks/materialized-standalone` rejects a citation in a materialized payload. Decided by: the session's call on annotations (work item 18).

**Changes**
- `skills/_tasks/drain.md`: new; the body of `skills/execute-tasks/SKILL.md` without frontmatter; "this skill" becomes "this loop"; `ok-sonnet` dropped (I101).
- `skills/execute-tasks/`: removed.
- `admin/converge::vendor_layer`: `SKILLS` and `UNPREFIXED` drop `execute-tasks`; `SHARED` adds `_tasks`; `RETIRED_VENDORED` adds `execute-tasks`; a live-sprint boilerplate rewrite (`.claude/skills/execute-tasks/SKILL.md` → `.claude/skills/_tasks/drain.md`) beside `contract_report`, reported.
- Readers repointed to "the drain loop at `.claude/skills/_tasks/drain.md`": `skills/audit/SKILL.md`, `skills/converge/SKILL.md`, `skills/triage-issues/SKILL.md` (both phases), `skills/plan-sprint/sprint-document.md`, `scripts/ok-planner-cheatsheet.md`, `scripts/ok-planner-CLAUDE.md`, `rules/ok-cheatsheet.md`, and the five `agents/ok-*.md` descriptions ("ONLY dispatched by the task tracker's drain loop (`.claude/skills/_tasks/drain.md`)…").
- `families/ok-planner/admin/ADMINISTRATION.md`: the retired-verb table gains `execute-tasks`, replaced by the drain loop read by path; the front door's retired-verb list (item 2) carries the same row.

**Improvements**
- **I101** `skills/_tasks/drain.md`, the profile list: a hard-coded second list of the vendored profiles that changed by hand in item 9. Afterward it says "one of the vendored profiles under `.claude/agents/`" and names none.

**Behavior changes**
- **B118** The `/execute-tasks` slash verb. Before: a vendored skill. After: gone; the loop is read by path. Users: in the release: audit, converge, triage-issues, sprint-document, the cheatsheets, the profiles, all repointed. Across Converged projects: vendored skill names and slash verbs. Ruling: migrate: converge removes the stamped `.claude/skills/execute-tasks/`; the project's own files there get a `retired-verb:` offer; both retired-verb tables name the replacement (call).
- **B119** Live sprint boilerplate. Before: names `.claude/skills/execute-tasks/SKILL.md`. After: names `.claude/skills/_tasks/drain.md`. Users: across stored state: unarchived sprints. Ruling: migrate: converge rewrites the line in `sprints/` only (call).
- **B120** The agent profiles' `description`. Before: "drain (execute-tasks)". After: the drain path. Users: in the release: the harness. Ruling: rewrite.

### Retire the router skills

**Changes**
- `skills/ok-planner/`: removed.
- `admin/converge::SKILLS` and `UNPREFIXED`: drop `ok-planner`; `RETIRED_VENDORED` adds it.
- `checks/hub-rows`: removed; `checks/run` drops it.

**Behavior changes**
- **B29** `/ok-planner` is gone from converged projects. Users: across Converged projects. Ruling: migrate: retired-verb removal and the report (call).
- **B30** `checks/run` no longer runs hub-rows. Users: in the release: maintainers. Ruling: rewrite.

### The concept index reaches every session by import

**Calls**
- The file is `.claude/rules/ok-concepts.md`, exactly `@../../.ok-planner/design/concepts.md` and a newline: fixed content, no stamp; diagnose compares bytes; a project-owned file at that path is a `collision` offer. Decided by: the fixed-content carve-out in `decision:whole-file-ownership`.
- It is materialized whether or not `design/` exists, on the assumption that importing an absent file loads nothing; certification's drive confirms this on the fresh project, and if the harness warns, it is rendered only where `concepts.md` exists.

**Changes**
- `families/ok-planner/scripts/ok-concepts.md`: new, written by `expected()`, with `# @decision: concept-vocabulary-imported-by-rules-file` at the core site.
- `scripts/hooks/session-start`: drops the `concepts.md` framing block and keeps the version line.

**Behavior changes**
- **B31** Before: the session-start hook tells the agent to read `concepts.md`. After: the harness loads it whole through the import. Users: sessions and every subagent and drained profile agent in converged projects (context cost only); both files land in one converge. Ruling: migrate: one converge writes both (call).

### Delete the unwired conduct rewriter

**Calls**
- No conduct version bump: the release skill bumps the conduct only when the output-style body changes. Decided by: `decision:lockstep-suite-version`.

**Changes**
- `plugins/ok-conduct/bin/{rewrite-draft,rewrite-prompt.txt,rewriter-env,warm-rewriter,conversation-extract,record-usage}`: removed; `bin/` is then empty and removed.
- `plugins/ok-conduct/docs/second-pass-rewrite.md`: removed.
- `hooks/hooks.json`, `hooks/session-start`, `hooks/user-prompt-submit{,.md}`: unchanged.

**Behavior changes**
- **B121** The `ok-conduct/bin/` scripts. Before: shipped, wired by nothing. After: gone. Users: in the release: none. Across Installed plugins: nothing the boundary lists. Ruling: rewrite.

### Rules and planner text follow the consolidation

**Calls**
- The paths are item 1's homes. Subjects and practices count as corpus for converge's no-edit rule. Decided by: `concept:corpus-delta` and `decision:final-form-deltas` as amended.
- The `checks` seed default becomes the lint at its new path, since every project carries it; an existing `config.json` whose `checks` names `node .ok-plumbline/bin/plumbline` is rewritten by item 3, or certification's checks fail. Decided by: `decision:one-vendored-family`.
- In `/audit` and `/document` text, "finding" changes to "defect" only where it names one defect; a Method's "findings" stay. Decided by: work item 16.

**Changes**
- `scripts/ok-planner-cheatsheet.md`: the content kinds gain the coding standards (subjects, practices, their TOCs, the standards documents, the lint configuration) and the run tag (item 8's text); the "checked all 23 skills under the families plus the front door" example becomes a one-payload example; the profile and drain lines per items 9 and 12.
- `scripts/ok-planner-CLAUDE.md`: sections for subjects and practices (owner-authored through deltas, TOCs generated), the standards documents, the configuration, the lint and hooks; plus items 4, 9, and 12.
- `rules/ok-cheatsheet.md`: items 9 and 12 only; the stamp is item 1's.
- `docs/plumbline-coding.md`: the stamp is item 1's; plus I103.
- The plumbline cheatsheet: Tooling rewritten ("ok-planner ships" the lint at its new path with the checks item 6 makes switchable, `/ok`, `/audit` with coverage and lint sweep, `/plan-sprint`, the edit hook, the configuration path; `/events` dropped); Technical Writing, Subjects and Practices, Tests, and Events name the new paths.
- `skills/_shared/artifact-definitions.md::{{CORPUS-DELTA-FORM}}`: subject and practice deltas land under the new homes in every project, the TOC regenerated by the new `catalog-toc` path; "Where `.ok-plumbline/` exists" dropped.
- `skills/plan-sprint/SKILL.md`: the estate table has one row; every "Where `.ok-plumbline/` exists" condition becomes unconditional with the new paths; the `.ok-workspaces/` Reconcile paragraph removed.
- `skills/plan-sprint/sprint-document.md` and `skills/_sprint/shared.md` (C3 and the build prompt): name the new subject, practice, and TOC paths.
- `skills/converge/SKILL.md`: the scope excludes `.claude/` and `.ok-planner/` plus the project's own paths; the no-edit list becomes `.claude/`, `.ok-planner/review/`, `.ok-planner/bin/`, `.ok-planner/hooks/`, `.ok-planner/docs/`, design-corpus artifacts, subjects and practices. `converge/prompts/merge.md` and `owner-list.md`: the same list.
- `skills/_converge/coding-rules.md`: the events path changes to the new one.
- `review/seed/config.json`: `exclude` drops `.ok-plumbline/` and `.ok-workspaces/`; `checks` holds the lint; `standards` per item 10.
- "finding" → "defect" in `skills/audit/SKILL.md`, `skills/document/SKILL.md`, `skills/audit/goal.md`, `_shared/implementation-auditor.md`, and the folded lint text ("findings" → "violations").

**Improvements**
- **I102** `skills/converge/prompts/merge.md`: A8 now names the events standard and the practices, but the merge prompt, which judges every report against A8, carries no `[STANDARDS]` slot, so a merge agent may reject a real breach it cannot read. Afterward merge.md carries `[STANDARDS]` beside `[ACCEPT]` and `[PROJECT]`, as fix, verify, and the hunts do.
- **I103** `docs/plumbline-coding.md` rule 8 ("A finding is one instance of a class") uses the retiring term. Afterward rule 8 and its steps say "defect".

**Behavior changes**
- **B122** The materialized rules texts (both cheatsheets, the CLAUDE template, the coding rules). Before: three families and `.ok-plumbline` paths. After: one estate and the new paths. Users: in the release: every session; overwritten on converge. Ruling: rewrite.
- **B123** `{{CORPUS-DELTA-FORM}}` and the sprint boilerplate. Before: subject and practice deltas only where `.ok-plumbline/` exists, at plumbline paths. After: in every project, at the planner paths. Users: in the release: plan-sprint, sprint execution. Across stored state: live sprints naming the old paths. Ruling: migrate: item 3's live-sprint rewrite repoints the subject, practice, and catalog-toc paths in `sprints/` only (call).
- **B124** plan-sprint estates. Before: a per-estate table and the workspaces profile reconcile. After: one estate, no profile step. Users: in the release: plan-sprint. Ruling: rewrite.
- **B125** The converge exclude and no-edit lists. Before: name `.ok-plumbline/` and `.ok-workspaces/`. After: the planner paths, subjects and practices no-edit. Users: in the release: merge and owner-list agents. Ruling: rewrite.
- **B126** The review seed defaults. Before: `exclude` holds the retired estates; `checks` is `[]` or the plumbline lint. After: no retired estates; the lint at the new path. Users: in the release: new projects. Across stored state: existing `config.json`. Ruling: migrate: retired `exclude` entries stay (harmless); item 3 rewrites a `checks` entry naming `.ok-plumbline/bin/plumbline` (call).
- **B127** `/audit` and `/document` wording. Before: "finding". After: "defect". Users: in the release. Ruling: rewrite.
- **B129** I102's merge prompt. Before: no standards text. After: the project's standards pasted. Users: in the release: merge agents. Ruling: rewrite.

### Repository checks follow the new layout

**Calls**
- `checks/run` passes once the owner's `/ok` refreshes this repo's vendored layer; until then `vendored-layer` reports the retired skills and drift. Certification verifies on item 3's converged and committed copy of this repository.
- `ceremony-surfaces` survives: each phase heading must appear, in order, in the folded `skills/{audit,document}/SKILL.md`, with name and guard.
- This repo's `.ok-planner/review/project.md` script lines are repointed (`checks/hub-rows`, `plugins/ok/admin/converge`, `families/<family>/admin/converge`, the plumbline lint paths, `.ok-workspaces/bin/run-tag`). Decided by: A3 reads its script list.

**Changes**
- `checks/token-resolution`: drops the `plugins/ok/ceremonies/**` consumer.
- `checks/ceremony-surfaces`: targets the two skill folders; drops the contribution and collision loops; its `@decision: suite-owned-ceremonies` annotation becomes `@decision: one-vendored-family`.
- `checks/materialized-standalone`: `PAYLOADS` lists the ok-planner paths, adding agent-model and subagent-batching (.py), port-block (.py), plumbline (.js), post-edit (.js), catalog-toc (.py), run-tag (.sh); `MARKDOWN_PAYLOADS` lists `ok-planner/docs/*.md` and `scripts/ok-cheatsheet.md`; the trees drop plumbline and workspaces; `MARKDOWN_PAYLOAD_LITERALS` and its loop removed; `CORPUS` subject and practice entries point at `.ok-planner/`; `LINT` points at the new path; the ceremonies walk goes.
- `checks/vendored-layer`: `FAMILIES = ("ok-planner",)`; the suite-admin asserts dropped; the front-door hooks assert becomes "`plugins/ok/hooks/` is absent".
- `checks/owned-paths`: `CORES` keeps only the core; `check_suite`, `check_plumbline`, `check_workspaces` removed, their surviving asserts moved into `check_planner` (hook and rules destinations, `json.dump` only in the wire, wire-env, and settings-resolve regions, the catalog-toc target); new regions for the two migrations, the worktree resolve (allowing `git worktree remove` and `git branch -d`), and the I6 helper.
- `checks/run` and `.ok-planner/review/project.md`: changed.
- Annotations citing retired slugs are repointed or removed.

**Behavior changes**
- **B32** The checks assert the new layout. Users: in the release: maintainers. Ruling: rewrite.
- **B33** This repo's `project.md` script list changes. Users: in the release: `/converge` prompts in this repo. Ruling: rewrite.

### Maintenance prose and annotations

**Calls**
- An annotation sits only where `checks/materialized-standalone` allows it: `decision:one-vendored-family` at the planner `admin/converge` header and at the front door's single-family discovery step; `concept:integration-contract` at the planner core's materialization pass; `decision:lockstep-suite-version` at the planner core's `SUITE_VERSION` read (the release skill already carries it). The other artifacts the item names have no allowed site and carry none. Decided by: the session's call on annotations.
- The `ok` descriptions in `plugin.json` and `marketplace.json` change here; the boundary does not list descriptions. Decided by: `.ok-planner/release-boundaries.md`.

**Changes**
- `docs/integration-contract.md`: rewritten for one family: the intro drops "every skill family" and the plan-sprint exception; "Skill families" becomes "The vendored family"; the layers are one estate, the suite-owned rules files (including item 14's import file), the vendored skills including `/audit` and `/document`, agent profiles, and hook wiring for the session-start, lint edit, agent-model, and subagent-batching hooks; the front door drives ok-planner's two administration files; "The ceremony contributions" removed; the collision rule covers only the project's own unstamped files; the discovery markers are `.ok-planner/` plus the pre-migration markers (`.ok-plumbline/`, `.ok-workspaces/`, `.plumbline.json`, `.claude/rules/plumbline-cheatsheet.md`); the ownership exceptions add item 3's owner-config rewrites; support scripts are the lint, catalog-toc, `run-tag`, and `port-block` at their homes; "Stack tailoring" removed; the front door table has one row; current conformance has one ok-planner entry.
- `plugins/ok/CLAUDE.md`: one family as payload; no ceremony layer; the constraints drop "never into a ceremony body", the plan-sprint exception, and `open`/`close`.
- `plugins/ok/families/ok-planner/CLAUDE.md`: the purpose names `/audit`, `/document`, and the coding standards; the verb list loses `/execute-tasks` and the index skill; the Layout gains `skills/audit/`, `skills/document/`, `skills/_tasks/`, and the lint, hook, docs, run-tag, and port-block sources, and loses `ceremony/`; the constraint "No Node tooling anywhere" becomes "the lint and its edit hook are node; everything else is bash or python".
- `.claude/skills/release/SKILL.md`: "the families" becomes the one family at its payload path; `.ok-plumbline/` dropped.
- `plugins/ok/.claude-plugin/plugin.json`, `.claude-plugin/marketplace.json`: the `ok` description reads "carries the ok-planner family as payload".

**Improvements**
- **I104** `.claude/skills/release/SKILL.md`: "the vendored audit checker masks release-mutable metadata before hashing" names `audit-check`, which converge already retires. Afterward the clause is dropped; the sentence still states that a release runs no audit.

**Behavior changes**
- **B128** The `ok` plugin's description in `plugin.json` and `marketplace.json`. Before: three families. After: one. Users: across Installed plugins: the marketplace listing; descriptions do not cross. Ruling: rewrite.


## How to execute this sprint

This sprint is self-sufficient. Every executor — an inline session,
an agent handed this file via `/goal`, an orchestrator with its own
planning — runs the same shape: record the base commit, plan the work
into the task tracker as small build tasks cut from the
implementation notes, drain them, then run sprint certification once.
No review runs during the build.

1. Read the sprint whole first: intent, deltas, work items,
   implementation notes, completion contract. The sprint is the whole
   brief: context from the intake (`.ok-planner/issues/`) or
   `history/` may disagree with what the owner approved. Raise a gap
   with the owner.

2. Record the base. Sprint certification reads the change from this
   commit, so the tree holds nothing but this sprint's work from here
   on. The planning session leaves its own files uncommitted: this
   file, its delta sidecar, `.ok-planner/release-boundaries.md`, the
   issue files it stamped, and the sketches it archived. Where `git
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
   collection's catalog TOC too (under `.ok-planner/design/`, or
   `.ok-plumbline/subjects.md` or `.ok-plumbline/practices.md`, which
   `python3 .ok-plumbline/bin/catalog-toc` regenerates), so two
   delta-bearing stages overlap. Stages with disjoint files run together. Apply a
   delta no work item implements in a stage of its own.

5. Render the completion report with the staged list before the first
   drain: write the output of `tasks render --title "<this sprint's
   title>" --sprint <this sprint's path>` to the report file (step
   10).

6. Keep the progress checklist. Where the harness task tools are
   available, mirror the stages as a live checklist, one entry per
   stage, created when the build tasks are filed, and add one entry
   for sprint certification when the drain ends. The run file is the
   record and the checklist is display.

7. Drain with the `execute-tasks` loop (`.claude/skills/execute-tasks/SKILL.md`).
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
    approval, confirmation, or progress checks. Stop only on a genuine
    blocker: a credential or access you cannot obtain, a step
    impossible in the current state, a destructive or irreversible
    action not clearly authorized, a task closed `blocked` twice, or
    sprint certification being unrunnable for you. Surface that and
    stop. Ambiguity is not a blocker: the builder makes the most
    plausible call and records it, or records a fork and builds the
    reading it judges best. Sprint certification reads both.

12. Code complete means every stage's latest build task closed
    `done`. Then run sprint certification, immediately after:
    `/converge sprint <this sprint's path>`. It judges the change
    from the commit in the `-base.txt` file to the working tree,
    once, against this sprint: every outcome and taken improvement
    works, a user gets what each story the sprint adds or amends
    promises when a driver uses the running product, every delta
    landed, every ruling holds, no unlisted behavior change breaks a
    user, and the project's checks pass. It fixes each defect in the
    sprint's scope and verifies each fix on its own diff. A defect
    outside the sprint's scope goes to the intake as a `category:
    defect` issue for the next `/converge`, and a question only the
    owner can decide goes to the intake for the next `/plan-sprint`.
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

1. Stamp each issue file this sprint promoted (`status: promoted`,
   `sprint: <this file's name>`) and move it to
   `.ok-planner/history/issues/`.
2. Move this file, its completion report, its run file, its
   `-base.txt` file, its `-build.md` prompt, and its delta sidecar to
   `.ok-planner/history/sprints/`: `git mv` for a tracked file, `mv`
   for an untracked one.
3. Stage by name every path the sprint's change touched, every moved
   file at its new path, the `/converge` run's ledger and folder, and
   every issue file the run wrote or moved. Commit those paths alone
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
   for a concept, story, or decision, and `.ok-plumbline/subjects/` or
   `.ok-plumbline/practices/` for a subject or practice, with its
   catalog TOC regenerated.
2. The project builds, and the checks `.ok-planner/review/config.json`
   lists under `checks` pass on every file the change touched.
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
return is the owner's to take up, and does not hold the goal open.
Presenting the report, archiving, committing, and the
`closed:` stamp all follow completion; a pending archive-and-commit
offer is evidence the goal is met. `sprints/` and
`.ok-planner/history/sprints/` satisfy the rule alike, and a sprint
already archived with a `closed:` stamp is terminal. A missing
completion report, or one without the return block,
means not done. Nothing else counts either way.
