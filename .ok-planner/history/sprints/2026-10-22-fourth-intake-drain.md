# Sprint: Fourth intake drain

## Intent

This sprint drains the intake and brings the design corpus up to the
work landed outside a sprint since the docspec and audit back-out
sprint closed. It has no single theme.

It declares the project's public surface and its one docspec, the
README. It makes the corpus describe the redesigned `/discover-design`
and the public surface as the documentation-sprint change left it. It
fixes ten defects in the suite's skills and scripts, and it carries
the owner's rulings and accepted recommendations on how certification
reports deltas, how drive defects get their confirm drivers, how an
approved sprint differs from a draft, where a payload script cites the
corpus, how a plain `/converge` run takes vetoes, and how true-up
treats an uncommitted edit to a stamped file.

The sketch `2026-10-19-discover-design-audit-sketch` was the source of
the `/discover-design` redesign that the reconcile deltas below catch
the corpus up to.

Promoted issues:

- readme-docspec-and-surface-intent-unwritten
- certification-return-names-no-deltas
- converge-skipped-confirm-drivers
- draft-sprint-indistinguishable-from-approved
- lists-section-internal-class-exceptions
- payload-script-story-citation
- plain-converge-return-offers-no-veto
- true-up-rewrites-uncommitted-suite-edit
- accepted-upstream-recommendation-asked-again
- certification-checklist-entry-never-marked
- certification-closes-done-with-no-story-driven
- converge-file-wait-charged-as-kickback
- converge-silent-on-dropped-folders
- discover-design-phase-one-findings-filed-as-questions
- ok-version-reports-no-plugin-version
- owner-list-verified-decline-leaves-issue-open
- review-backlog-misses-extensionless-files
- sketch-overwrites-same-day-sketch

## Corpus deltas

### Amend story: rule-the-public-surface

```markdown
---
story: rule-the-public-surface
---

# Declare what is public

## Story

As a project owner, I want a way to declare which parts of my project
are public, so that no element becomes part of my public surface
unless I chose it.
```

### Amend story: bootstrap-design-corpus

```markdown
---
story: bootstrap-design-corpus
---

# Bring a design corpus in line with an existing codebase

## Story

As a project owner, I want a way to have my existing code read
against my design corpus, whether the corpus is empty or out of date,
and turned into the corpus changes it needs plus the questions only
I can answer, so that my design attention goes to the questions that need
my judgment instead of to writing or repairing the corpus by hand.
```

### Retire decision: discovery-notes-archived-on-consent

### New decision: corpus-audit-hands-a-discovery-to-planning

body: in the sidecar, `2026-10-22-fourth-intake-drain-deltas/decisions/corpus-audit-hands-a-discovery-to-planning.md`

### Amend decision: intake-writers-are-gated

body: in the sidecar, `2026-10-22-fourth-intake-drain-deltas/decisions/intake-writers-are-gated.md`

### Amend decision: final-form-deltas

body: in the sidecar, `2026-10-22-fourth-intake-drain-deltas/decisions/final-form-deltas.md`

### Amend decision: records-stay-out-of-context

```markdown
---
decision: records-stay-out-of-context
---

# Records are committed and versioned, and stay out of agent context by default

## Choice

The estate's records — sprints, documentation sprints, test
sprints, each docspec's run state, the scenario list, sketches,
discoveries, the notes an earlier release's discovery run left, the
archive, and the review runs' records — are
committed and versioned, and stay out of agent context by default.
The one live exception is the sprint, documentation sprint, or test
sprint being executed, and a skill that reads a record it names. An agent reads or touches a record only when the owner or a
skill directs it, and then does exactly what was asked.

## Rationale

A record describes a past moment. An agent that reads one to
understand the project pulls that moment into its present reasoning,
and drift between the record and the code is expected, so the agent
reasons from a state the project has left. The design corpus and the
code are the source of truth, and they describe the project as it
stands. Committing the records keeps the project's history versioned
and available to the owner and to the skills that need it. Keeping
them out of context by default keeps that history from competing with
the source of truth.

## Alternatives

- Records read freely as context — an agent sees the project's history
  whole, and reasons from states the code has since left.
- Records not committed — nothing stale reaches an agent, and the
  project loses its versioned history of sprints, sketches, and runs.
```

### Amend decision: whole-file-ownership

body: in the sidecar, `2026-10-22-fourth-intake-drain-deltas/decisions/whole-file-ownership.md`

### Amend decision: code-cites-design

body: in the sidecar, `2026-10-22-fourth-intake-drain-deltas/decisions/code-cites-design.md`

### Amend concept: design-corpus

body: in the sidecar, `2026-10-22-fourth-intake-drain-deltas/concepts/design-corpus.md`

### Amend concept: docspec

body: in the sidecar, `2026-10-22-fourth-intake-drain-deltas/concepts/docspec.md`

### New decision: sprints-carry-an-approval-mark

body: in the sidecar, `2026-10-22-fourth-intake-drain-deltas/decisions/sprints-carry-an-approval-mark.md`

### New decision: converge-close-takes-vetoes

body: in the sidecar, `2026-10-22-fourth-intake-drain-deltas/decisions/converge-close-takes-vetoes.md`

### New decision: payload-citations-stripped-at-true-up

body: in the sidecar, `2026-10-22-fourth-intake-drain-deltas/decisions/payload-citations-stripped-at-true-up.md`

### Amend decision: converge-finds-then-fixes

body: in the sidecar, `2026-10-22-fourth-intake-drain-deltas/decisions/converge-finds-then-fixes.md`

### Amend decision: true-up-asks-once-before-destructive-steps

body: in the sidecar, `2026-10-22-fourth-intake-drain-deltas/decisions/true-up-asks-once-before-destructive-steps.md`

### New surface intent

body: in the sidecar, `2026-10-22-fourth-intake-drain-deltas/surface/surface.md`

### New docspec: readme

body: in the sidecar, `2026-10-22-fourth-intake-drain-deltas/docspecs/readme.md`

## Work items

Every path below is in the family's source under
`plugins/ok/families/ok-planner/` unless it names another root. The
vendored copies under `.claude/` and `.ok-planner/` change only when
the owner runs `/ok`; no work item edits them.

1. **The corpus catches up with the work landed outside a sprint.**
   Apply the deltas above for `story:rule-the-public-surface`,
   `story:bootstrap-design-corpus`, the retirement of
   `decision:discovery-notes-archived-on-consent`, the new
   `decision:corpus-audit-hands-a-discovery-to-planning`, and the
   amendments of `decision:intake-writers-are-gated`,
   `decision:final-form-deltas`, `decision:records-stay-out-of-context`,
   `decision:whole-file-ownership`, `decision:code-cites-design`, and
   `concept:design-corpus`. Every place the family's source names the
   retired decision's slug names the new decision instead. The code is
   already right: these deltas describe it.

2. **The project declares its public surface and its README docspec.**
   Apply the new surface intent and `docspec:readme`. The README's
   text is written by a later documentation sprint (`/plan-docs`), not
   here. Realizes the owner's ruling on
   `readme-docspec-and-surface-intent-unwritten` and
   `decision:every-public-class-has-a-reference`.

3. **An accepted upstream recommendation to file is not asked again.**
   `/plan-sprint` reads an upstream ruling that chooses a filing but
   names no location as a choice to file, not as a ruling it cannot
   understand. It asks the owner where the draft was filed, as a fact,
   and closes the issue `answered` with that location. The owner is not
   asked to rule again. Site: `skills/plan-sprint/SKILL.md`, Frame, the
   upstream issues. Realizes `story:rule-on-the-whole-intake` and
   `decision:foreign-harms-become-upstream-issues`.

4. **The certification checklist entry is marked.** The sprint
   execution steps mark the sprint-certification checklist entry in
   progress when certification starts and done when its return is
   written into the completion report. Site:
   `skills/plan-sprint/sprint-document.md`, How to execute this sprint,
   steps 6, 12, and 13. Realizes `story:watch-execution-progress` and
   `decision:task-tools-mirror-the-report`.

5. **A sprint whose stories were not driven is not done.** Where the
   project has a story, a sprint certification whose drive did not run
   — the drive commands unfilled or refused, or the stack failing to
   start — leaves the completion contract open, and `review certified`
   prints `SPRINT NOT COMPLETE` naming the drive that did not run. A
   project with no story, and a drive that ran with no stack because
   the project declares none, are not affected. Sites:
   `skills/converge/SKILL.md` sprint mode step 4, the completion
   contract in `skills/plan-sprint/sprint-document.md`, and
   `scripts/review` `certification_failures`. Realizes
   `story:certify-completion` and
   `decision:drive-tries-each-story-as-a-user`.

6. **A wait for another fixer's files is not a send-back.** A fix task
   that closes `partial` with a result starting `outside files:`
   reopens its unfinished defects without raising their `kickbacks`,
   and the return does not count the wait as a send-back. The fix loop
   still ends: a bound other than the send-back limit caps how often a
   defect waits. Site: `skills/converge/SKILL.md`, Loop 2 step 4.
   Realizes `story:find-and-fix-defects` and
   `decision:converge-finds-then-fixes`.

7. **`/converge` says when the review tool drops the declared
   folders.** Where `review files`, `review changed`, or `review
   checks` falls back to the project root because the project's config
   is malformed, the run's opening line and its return say so, with
   the tool's note, so a run never reports a root-only hunt or check
   as whole. Sites: `skills/converge/SKILL.md` Preconditions and
   analysis step 1, over `scripts/review` `project_folders`. Realizes
   `story:project-spans-folders`.

8. **The corpus audit leaves the owner no open review finding.** The
   discovery `/discover-design` assembles lists no review finding for
   the owner. In the review's last cycle, each finding the rules decide
   is fixed in the draft, and each other finding becomes a question
   with both answers. Sites: `skills/discover-design/SKILL.md` step 7
   and step 8, `skills/discover-design/core.md` the review prompt, and
   `scripts/discover` assembly. Realizes
   `story:bootstrap-design-corpus` and
   `decision:corpus-audit-hands-a-discovery-to-planning`.

9. **`/ok-version` reads the installed plugin's version.** The
    plugin-version line prints the version of the installed `ok`
    plugin, read from `claude plugin list --json`, so it differs from
    the vendored layer's stamp when the two have drifted. Site:
    `skills/ok-version/SKILL.md`, Procedure steps 1 and 4. Realizes
    `story:see-governing-versions` and
    `decision:per-project-pinning`.

10. **A verified decline closes its defect issue.** At the end of a
    `/converge` run, a defect issue whose defect ends `declined` or
    `duplicate` with a `verified` field closes, as `answered`, with the
    verifier's reason. Site: `skills/converge/prompts/owner-list.md`,
    Close the issues the run resolved. Realizes
    `story:find-and-fix-defects`.

11. **`review backlog` finds file names with no extension.** An issue
    that names an extensionless file of the tree, such as
    `.ok-planner/bin/review`, yields a report naming that file, and its
    `path:function` can be the site. Site: `scripts/review`
    `backlog_entry` and the patterns it uses. Realizes
    `story:find-and-fix-defects`.

12. **A second sketch never overwrites the first.** `/sketch` checks
    for an existing file at the path it would write, and writes a
    second sketch on the same topic and day to a new path. Site:
    `skills/sketch/SKILL.md`, Process step 4. Realizes
    `story:sketch-an-idea`.

13. **Certification's return states the deltas' delivery.** The return
    of sprint certification carries one line for the sprint's corpus
    deltas: how many it compared, how many had landed at build, how
    many it landed itself, and how many stuck, naming by artifact each
    delta it landed and each that stuck. Site:
    `skills/converge/SKILL.md`, The return. Realizes
    `story:certify-completion` and the accepted recommendation on
    `certification-return-names-no-deltas`.

14. **Every verified drive defect gets its confirm driver.** The review
    tool, not the session, decides which defects still need a confirm
    driver. A confirm driver that sees the story met marks its defect
    confirmed. `review drives --confirm` briefs every verified drive
    defect not yet marked, whatever round verified it. Before the fix
    loop ends, the confirm step runs once more where any such defect
    remains. Sites: `skills/converge/SKILL.md` Loop 2 step 6,
    `scripts/review` `cmd_drives`, and the confirm driver's prompt.
    Realizes `decision:drive-tries-each-story-as-a-user` and the
    accepted recommendation on `converge-skipped-confirm-drivers`.

15. **An approved sprint carries its mark, and executors refuse a
    draft.** Apply `decision:sprints-carry-an-approval-mark`. The
    planning session writes the mark at approval. The execution steps
    in the sprint template, sprint certification, and `review
    certified` each refuse a sprint without the mark, naming it and
    saying how to add it. A sprint whose `-base.txt` file stands beside
    it is exempt. Sprint certification checks the mark before it
    writes a missing base file, so it never exempts a draft it was
    handed. Sites:
    `skills/plan-sprint/SKILL.md` Approval,
    `skills/plan-sprint/sprint-document.md`,
    `skills/converge/SKILL.md` sprint mode, and `scripts/review`.
    Realizes `story:plan-a-sprint` and the accepted recommendation on
    `draft-sprint-indistinguishable-from-approved`.

16. **A reference docspec may list a class whose exceptions make its
    members public.** Apply the amendment of `concept:docspec`. The
    tooling already lists such members; this item lands the concept.
    Realizes `story:reference-names-the-public-surface` and the
    accepted recommendation on `lists-section-internal-class-exceptions`.

17. **Payload scripts carry design citations, and true-up strips
    them.** Apply `decision:payload-citations-stripped-at-true-up`.
    True-up removes each citation comment line from a payload script
    as it copies it into a project. `checks/materialized-standalone`
    lints the copy true-up would write, and keeps refusing a citation
    in a markdown payload. The task tracker's calls table carries the
    `@story: veto-calls-made-in-my-absence` annotation. Sites:
    `admin/true-up` render, `checks/materialized-standalone`, and
    `scripts/tasks` `calls_table`. Realizes
    `story:veto-calls-made-in-my-absence` and the accepted
    recommendation on `payload-script-story-citation`.

18. **A plain `/converge` run takes vetoes at its close.** Apply
    `decision:converge-close-takes-vetoes` and the amendment of
    `decision:converge-finds-then-fixes`. A drive,
    analysis, or defects run's return presents its calls table and,
    beside the archive-and-commit offer, asks which rows the owner
    vetoes, and files one issue per vetoed row with the owner's words
    as its ruling, as sprint certification's close does. A run that
    made no calls asks nothing new. Site: `skills/converge/SKILL.md`,
    The return. Realizes `story:veto-calls-made-in-my-absence`.

19. **True-up keeps an uncommitted edit to a stamped file.** Apply the
    amendments of `decision:true-up-asks-once-before-destructive-steps`
    and `decision:whole-file-ownership`. A rewrite of a stamped
    suite-owned file that holds an uncommitted or staged-only change is
    a destructive step: true-up copies the working file into the
    archive before it rewrites it, and the plan marks the step for the
    owner's one consent. A rewrite of a stamped file whose difference
    git holds in a commit stays a step with no question. Sites:
    `admin/true-up` `materialize_steps`, `uncommitted`, and the plan's
    destructive marking. Realizes `story:true-up-project-estate`.

## Implementation notes

Planned against commit `e9949f9`.

Every path is under `plugins/ok/families/ok-planner/` unless it names another root.

### 1. The corpus catches up with the work landed outside a sprint

**Calls**
- No file in the family's source names the retired slug: `rg discovery-notes-archived-on-consent` over `plugins/`, `checks/`, `docs/`, and `.claude/skills/release/` finds nothing. It stands only in `.ok-planner/design/decisions.md` (a TOC, regenerated) and `.ok-planner/design/concepts/design-corpus.md` (replaced by its delta), so the repoint list is empty. Decided by: plumbline-coding rule 1.
- `rg` over `.ok-planner/design/` for the retired mechanism (`_discover`, "corpus bootstrap", "discovery notes", "Outside the one-time corpus bootstrap") finds sentences only in artifacts this sprint's deltas replace. Decided by: plumbline-coding rule 5.3.
- The family's source already matches the new decision: `skills/discover-design/SKILL.md`, `admin/true-up::discover_notes_step`, and `scripts/ok-planner-CLAUDE.md`. Decided by: the work item ("the code is already right").
- `decision:whole-file-ownership` is named by items 1 and 19 and lands once, in item 1's stage. Decided by: one delta, one application.
- Item 1's stage lands before any stage that adds `@decision: corpus-audit-hands-a-discovery-to-planning` or `@story: bootstrap-design-corpus` to code, since the lint resolves those slugs against `.ok-planner/design/`. Item 8's stage carries those annotations in `scripts/discover`. Decided by: the lint's citation-resolution check.
- `story:rule-the-public-surface` gets no code annotation: the sites that realize it are markdown payload, which carries no citation that resolves in the suite's corpus. Decided by: execution step 8 and `decision:payload-citations-stripped-at-true-up`.
- Every delta-bearing stage (items 1, 2, 16, 17, 19) regenerates the catalog TOCs, so those stages chain. Decided by: execution step 4.
- Items 15 and 18 also apply decision deltas, so the delta-bearing stages are items 1, 2, 15, 16, 17, 18, and 19, all chained on `.ok-planner/design/decisions.md`. A stage that adds `@decision: sprints-carry-an-approval-mark` or `@decision: converge-close-takes-vetoes` to code runs after that decision lands. Decided by: the lint's citation-resolution check and execution step 4.

**Changes**
- `.ok-planner/design/stories/rule-the-public-surface.md` and `.ok-planner/design/stories/bootstrap-design-corpus.md`: changed, from the inline bodies.
- `.ok-planner/design/decisions/discovery-notes-archived-on-consent.md`: removed.
- `.ok-planner/design/decisions/corpus-audit-hands-a-discovery-to-planning.md`: new, from the sidecar.
- `.ok-planner/design/decisions/{intake-writers-are-gated,final-form-deltas,whole-file-ownership,code-cites-design}.md`: changed, from the sidecar.
- `.ok-planner/design/decisions/records-stay-out-of-context.md`: changed, from the inline body.
- `.ok-planner/design/concepts/design-corpus.md`: changed, from the sidecar.
- `.ok-planner/design/{stories,decisions,concepts}.md`: regenerated by `catalog-toc`.

**Behavior changes**
None. Every change is new code no existing user reaches. The corpus text changes, the code already matches it, and no code cites the retired slug.

### 2. The project declares its public surface and its README docspec

**Calls**
- The delta creates `.ok-planner/surface/`; the surface intent has no TOC. `catalog-toc` rewrites `.ok-planner/docspec.md`, which the vendored v28 `catalog-toc` supports. Decided by: `decision:final-form-deltas`.
- This sprint's own certification reads the public surface as it stood at the base commit, which has no intent, so no element is public for this sprint's regression check. Decided by: the public surface boundary.
- `README.md` now sits under a docspec's `## Where`, so the build prompt (builders leave it as it stands), `/plan-sprint`'s Reconcile flag on direct documentation edits, and `/converge`'s prose scope rule apply to it from this sprint on. No current writer is affected; `/release` only reads it. Decided by: the docspec rules.

**Changes**
- `.ok-planner/surface/surface.md`: new, from the sidecar.
- `.ok-planner/docspec/readme.md`: new, from the sidecar.
- `.ok-planner/docspec.md`: regenerated; it lists `readme` with `README.md` and its references.

**Behavior changes**
- **B101** `.ok-planner/surface/surface.md`, as read by `scripts/review::declared_classes` and `flow_areas`, `scripts/discover::cmd_areas`, and the vendored `.ok-planner/bin/review`. Before: there is no intent; `flow_areas` returns `None`, and `/converge analysis` hunts file areas only and says so. After: one flow area per declaring file (`.claude-plugin/marketplace.json`, each `SKILL.md` the three globs match, each output style), through `declaring_files`' existing glob path, and later sprints' public-surface boundary covers plugins, slash commands, and output styles.
  Users: in the release: `/converge`, `/discover-design`, later `/plan-sprint` code planning. Across trued-up projects: none; this is this repository's own estate.
  Ruling: rewrite.
- **B102** `.ok-planner/docspec.md` and `.ok-planner/docspec/readme.md`, as read by `scripts/docs` and the lint's `in code:` scan. Before: the index says none. After: one docspec; the next `/plan-docs` window finds `readme` unstamped and plans `README.md`. The lint's doc-comment allowance is unchanged, since the docspec has no `in code:` line.
  Users: in the release: `/plan-docs`, the lint.
  Ruling: rewrite.

### 3. An accepted upstream recommendation to file is not asked again

**Calls**
- A ruling that chooses a filing upstream and names no location, an accepted recommendation to file among them, is a choice to file. The session asks the owner where the draft was filed, in prose, as a fact, then closes `issues close <id> --as answered --reason "<where it was filed>"`, writes no ruling, and pulls nothing into the sprint. Decided by: the work item and `decision:foreign-harms-become-upstream-issues`.
- Where the owner has not filed it yet, the session shows the issue's `upstream` draft so the owner can, then asks where; where the owner leaves it unfiled, the issue stays open with its ruling, and the session names it in one line. Decided by: the same decision.
- A ruling that chooses both a workaround and a filing and names no location rides the sweep as promoted; the session asks where it was filed and writes the location into the work item that carries the workaround. Decided by: the Promote rule ("the sprint carries the whole resolution").
- "Cannot be understood" now covers only a ruling that chooses neither a filing nor a workaround. Decided by: the work item.
- `skills/_shared/artifact-definitions.md` line 420 also restates the answered-upstream close ("with the ruling naming where it was filed"); it changes with the other two lines. Decided by: plumbline-coding rule 1.

**Changes**
- `skills/plan-sprint/SKILL.md::Frame`, "Set the upstream issues apart": changed, with the three readings above; the case that names where the owner filed keeps its close.
- `skills/plan-sprint/SKILL.md::Terminal` step 1: changed. It reads "its ruling or its work item naming where it was filed".
- `skills/_shared/artifact-definitions.md`, the issue format's answered-upstream and promoted-both-ways lines: changed. The close's reason names where it was filed, and the ruling or the sprint's work item names the filing.
- `scripts/ok-planner-CLAUDE.md`, "Answered upstream": changed to match.

**Behavior changes**
- **B103** `skills/plan-sprint/SKILL.md::Frame`. Before: a ruling that chooses a filing but names no location "cannot be understood", and the owner is asked to rule again. After: the owner is asked only where the draft was filed; the issue closes `answered` with that location, or, both ways, the location goes into the work item. The owner's ruling stands as written.
  Users: in the release: the owner in session, and the two documents changed above. Across trued-up projects: the vendored `/plan-sprint` changes on `/ok`; closed records keep their text.
  Ruling: rewrite.

### 4. The certification checklist entry is marked

**Calls**
- No delta is needed: `decision:task-tools-mirror-the-report` names the moments the checklist is touched, and two marks on the certification entry it already creates contradict nothing. Decided by: that decision's Choice and the work item.
- The ok cheatsheet's "Executing a sprint" sentence restates the checklist's moments, so it gains the certification entry. Decided by: plumbline-coding rule 1.

**Changes**
- `skills/plan-sprint/sprint-document.md::How to execute this sprint`: changed. Step 6 keeps "Add one entry for sprint certification when the drain ends" and says the entry is marked in progress at step 12 and done at step 13. Step 12 marks the entry in progress before it runs `/converge sprint`. Step 13 marks it done right after the return block is written into the completion report, before `review certified` runs.
- `admin/retired-boilerplate.json`: changed. It gains every replaced boilerplate line, sorted; `checks/sprint-boilerplate` enforces it.
- `scripts/ok-cheatsheet.md::Executing a sprint`: changed. It adds the certification entry: in progress while certification runs, done when its return is in the report.

**Behavior changes**
- **B1** `skills/plan-sprint/sprint-document.md::How to execute this sprint`. Before: the certification entry is created when the drain ends and never marked. After: it is marked in progress when certification starts and done when its return is in the report.
  Users: in the release: the executing session. Across trued-up projects: live sprints carry the old steps until true-up replaces the retired lines; the cheatsheet arrives at true-up.
  Ruling: migrate: true-up brings live sprints' steps current through `retired-boilerplate.json` (call). Decided by `decision:live-sprints-brought-current-on-true-up`.

### 5. A sprint whose stories were not driven is not done

**Calls**
- "The drive ran" means the ledger holds at least one task with role `drive` whose brief starts `story ` (a confirm brief starts `confirm:`); a driver that closed `partial` still counts. Decided by: the work item ("the drive did not run").
- The failure line names why, from `drive_stack(root)`: for `unfilled`, the reason it prints; for a refusal, the refusal's message; for `stack`, the failed `exec` task whose command equals the `stack-start` command, with its result tail, else "no driver task was filed"; for `none`, "no driver task was filed". Decided by: the work item ("naming the drive that did not run").
- A project "has a story" when `.ok-planner/design/stories/` exists and holds a slug; a missing folder counts as no story, so `certified` never raises on a project with no corpus. Decided by: the work item.
- `certified` reads the stories as they stand. A sprint whose C3 fix lands the project's first story after the drive is a known edge, left alone. Decided by: the work item's scope.
- The failure is reported under contract item 3. Decided by: the amended item 3.
- `drive_stack` raises `ReviewError` on a missing section, or on a `- No stack:` line beside a stack line; `certification_failures` catches that refusal and puts its message in the failure line, so `review certified` still prints a verdict. The `stack` case needs the stack-start command as a value, which `cmd_drive_command` only prints today: factor the lookup so both use it. Decided by: plumbline-coding rules 4 and 6.

**Changes**
- `scripts/review::certification_failures`: changed. Where the project has a story and the ledger holds no `story` drive task, it adds `the drive did not run in <ledger>: <reason>`.
- `scripts/review::cmd_certified`: changed. Item 3's "holds" line adds "the drive ran over <n> stories", or "no story".
- `skills/plan-sprint/sprint-document.md::Completion contract` item 3: changed. It adds: where the project has a story, the run's drive ran; drive commands unfilled or refused, or a stack that failed to start, mean it did not.
- `admin/retired-boilerplate.json`: changed. It gains the replaced lines.
- `skills/converge/SKILL.md::In sprint mode` step 4: changed. No slug: the drive is skipped and the contract is unaffected. `unfilled`, a refusal, or a failed stack start: the drive did not run, the contract stays open, and `review certified` prints `SPRINT NOT COMPLETE` naming it.
- `skills/converge/SKILL.md::The return`, the `sprint` bullet: changed. Where the drive did not run, it says why and that the contract stays open.

**Behavior changes**
- **B2** `scripts/review::certification_failures` and `cmd_certified`. Before: `SPRINT COMPLETE` with no drive run. After: `SPRINT NOT COMPLETE` naming the drive that did not run.
  Users: in the release: template step 13 and the `/goal` checker, which already stop on any failure. Across trued-up projects: a live, unarchived sprint certified without a drive before true-up; and every project with a story whose `## Drive commands` section in `.ok-planner/review/project.md` is unfilled or refused, as a fresh true-up seeds it, whose every certification now ends `SPRINT NOT COMPLETE` until the owner writes the lines. An archived sprint with `closed:` stays terminal.
  Ruling: migrate: the failure line quotes `drive_stack`'s unfilled reason or refusal, which names the lines to write, and once they are written, running steps 12 and 13 again completes the sprint; the change removes only the A9 harm of a false `SPRINT COMPLETE`, so no caller may rely on it (call).
- **B3** `skills/plan-sprint/sprint-document.md::Completion contract` item 3. Before/After: as B2.
  Users: in the release: executors and checkers. Across trued-up projects: live sprints, which true-up brings current, and every project with a story and an unfilled or refused `## Drive commands` section, as B2 says.
  Ruling: migrate: through `retired-boilerplate.json`, with B2's failure line naming the lines to write (call). Decided by `decision:live-sprints-brought-current-on-true-up`.
- **B4** `skills/converge/SKILL.md::In sprint mode` step 4 and the return. Before: a skipped drive was only named. After: the return also says the contract stays open.
  Users: in the release: the session. Across trued-up projects: skill text at true-up.
  Ruling: rewrite.

### 6. A wait for another fixer's files is not a send-back

**Calls**
- The bound is a new defect field, `waits`, missing counts as 0. A defect waits at most `fix.max_kickbacks` times; past that, a wait raises `kickbacks` by one, as before. Both counts are capped, so the loop ends. Decided by: `.ok-planner/review/config.json` is seeded once and never overwritten, so a new key would be missing in trued-up projects; reusing the existing ceiling reaches them with no stored-config change.

**Changes**
- `skills/converge/SKILL.md::Loop 2: fix and verify` step 4: changed. A fix task that closed `partial` with a result starting `outside files:` sets its defects still `fixing` back to `open` with `waits` raised by one and `kickbacks` unchanged; where `waits` already stands at `fix.max_kickbacks`, the wait raises `kickbacks` by one instead.
- The closing sentence of that section: changed. It adds that a defect waits at most `fix.max_kickbacks` times.
- `skills/converge/SKILL.md::The return`, the `fixed` bullet: changed. It lists the send-backs by defect and the waits by defect apart.

**Behavior changes**
- **B5** `skills/converge/SKILL.md::Loop 2` step 4. Before: a wait raised `kickbacks` and counted as a send-back. After: it raises `waits`; only waits past the cap raise `kickbacks`.
  Users: in the release: step 1's stuck rule, the return, and the owner list's stuck section, none of which changes. Across trued-up projects: skill text at true-up; no ledger outlives a run.
  Ruling: rewrite.

### 7. `/converge` says when the review tool drops the declared folders

**Calls**
- Both fallbacks in `project_folders` count: a malformed config, and node missing from PATH while folders are declared. Both notes already say "the review reads the project root alone", and the skill keys on that phrase, so `project_folders` needs no change for the work item. Decided by: the work item.
- `review areas` (analysis) and `review changed` (sprint) run before the opening line, so their note goes there; in drive and defects mode only `review snapshot` lists files, and its note goes in the return. Decided by: the skill's step order.

**Changes**
- `skills/converge/SKILL.md::Setting up the run` step 1: changed. Where any `review` verb writes a stderr note saying the review reads the project root alone, the opening line says so and quotes the note, and the return says it again.
- `skills/converge/SKILL.md::In analysis mode` step 1: changed. Where `review areas` writes that note, the file areas cover the project root alone; say so with the slice.
- `skills/converge/SKILL.md::The return`: changed. The analysis `hunt` bullet and the `sprint` bullet's checks carry the note; in every mode, any later verb that wrote it is named.

**Improvements**
- **I1** `scripts/review::cmd_certified` and `project_folders`: A9, `certified` prints "item 2 (checks): holds: <n> checks over <m> changed files pass" while the declared folders were dropped. Afterward: `declared_folders(root)` returns the folders and the fallback note or None; `project_folders` prints the note and returns the folders as now; `cmd_certified` appends "(the project root alone: <note>)" to item 2's line and still reports item 2 as holding.

**Behavior changes**
- **B6** `skills/converge/SKILL.md` opening line and return. Before: the note went unreported. After: both carry it.
  Users: in the release: the owner. Across trued-up projects: skill text at true-up.
  Ruling: rewrite.
- **B7** (I1) `scripts/review::cmd_certified`. Before: item 2's line claims the whole change. After: it names the fallback; the verdict is unchanged.
  Users: in the release: step 13 and the owner; the `/goal` checker is unaffected. Across trued-up projects: the tool at true-up.
  Ruling: rewrite.

### 8. The corpus audit leaves the owner no open review finding

**Calls**
- The review record gains `--field decided=<yes | no>`: `yes` where the rules leave one fix, which `fix` names; `no` where they leave the owner a choice, and `fix` names the choice and each answer. Decided by: the work item.
- Every cycle, the last included, refiles each named merge with its findings; the brief adds "fix in the draft each finding whose `decided` is `yes`, as its `fix` says; ask each finding whose `decided` is `no` as a question with both answers, as the merge prompt's step 6 says (one question per artifact)". After the third cycle's refiles drain, no review follows; each finding is marked `resolved` and the drafts are checked. Decided by: the work item and the sibling shape of step 7's refile.
- The assembly, with and without `--check`, fails on each `review` item a done review task recorded that still stands `open`: `review finding <id> (<site>): it stands open; refile merge task <merge> with it, drain, and mark it resolved`. Decided by: the work item and the sibling `failures.append` shape in `assembled`.
- The counts line `Review findings left open: <n>[; no review ran]` becomes `Review findings: <n>, each fixed in a draft or asked as a question`, keeping `; no review ran`; the `## Review findings left open` section goes; `cmd_assemble` prints `questions: <q>; review findings: <n>; calls: <c>`. Decided by: the work item; an unreviewed discovery is a fact the owner acts on.
- This stage carries item 1's annotations in `scripts/discover`: `# @story: bootstrap-design-corpus` at `cmd_assemble`, and `# @decision: corpus-audit-hands-a-discovery-to-planning` at `cmd_status` and at `assembled`. It runs after the stages of items 1 and 17. Decided by: execution step 8 and the lint.
- The intro sentence of `scripts/discover::document` ("the session walks each question and each review finding left open with you") drops its review-finding clause, and so does the document's description in `skills/discover-design/SKILL.md` step 8. Decided by: plumbline-coding rule 1.

**Changes**
- `skills/discover-design/core.md::{{DISCOVER-REVIEW-PROMPT}}`: changed. The Record line gains `decided`, defined as above.
- `skills/discover-design/SKILL.md` step 7: changed, as in the second call; "A finding of the third cycle stays open, and the discovery lists it for the owner" goes.
- `skills/discover-design/SKILL.md` step 8: changed; "each review finding left open" goes, and it names the count of review findings.
- `scripts/discover::assembled`: changed. Open findings become failures; it returns the count of resolved findings done review tasks recorded, and whether a review ran.
- `scripts/discover::document`: changed, as in the counts call.
- `scripts/discover::cmd_assemble`: changed; the new counts line and the story annotation.
- `scripts/discover::cmd_status`: changed; the decision annotation, which `assembled` carries too.
- `skills/plan-sprint/SKILL.md`, Dialogue, "A discovery": changed; the bullet "Walk each review finding the discovery left open…" goes.

**Behavior changes**
- **B105** `scripts/discover::assembled` and the assembly. Before: open review findings pass `--check` and the assembly, and are listed. After: both refuse, exit 2, naming each open finding.
  Users: in the release: `skills/discover-design/SKILL.md` steps 6 to 8, changed above. Across trued-up projects: none; no release holds `scripts/discover`.
  Ruling: rewrite.
- **B106** `scripts/discover::document`. Before: the discovery carries `## Review findings left open` and a left-open count. After: no such section, and the counts line as above.
  Users: in the release: the `/plan-sprint` Dialogue bullet, removed above. Across trued-up projects: none, as B105.
  Ruling: rewrite.
- **B107** `scripts/discover::cmd_assemble`'s printed counts line. Before: `questions: …; review findings left open: …; calls: …`. After: `questions: …; review findings: …; calls: …`.
  Users: in the release: the skill's step 9.
  Ruling: rewrite.
- **B108** `{{DISCOVER-REVIEW-PROMPT}}` and the skill's step 7. Before: a finding records `site`, `merge`, and `fix`, and third-cycle findings are not refiled. After: it also records `decided`, and every cycle's findings are refiled, the last with no further review.
  Users: in the release: step 7 and the merge refile.
  Ruling: rewrite.

### 9. `/ok-version` reads the installed plugin's version

**Calls**
- Step 1 runs `claude plugin list --json`, takes the entry whose `id` is `ok@ok-plugins` and whose `scope` is `user`, and reports its `version`. Where the command fails, lists no such entry, or the entry has no `version`, it reads the `version` of the user-scoped entry under `plugins["ok@ok-plugins"]` in `~/.claude/plugins/installed_plugins.json`; where neither has it, it reports `unknown`. Decided by: the work item and the sibling resolver in `plugins/ok/skills/ok/SKILL.md`, "Resolving the payload".
- The label becomes `**Plugin version (installed ok plugin):**`, since the installed version can differ from the one loaded in the session until `/reload-plugins`, and "governing this session" would then be false. Decided by: A9.
- The intro and the frontmatter `description` say "the installed ok plugin version"; the sentence "Both sources are written by the vendored layer…" goes. Decided by: plumbline-coding rule 1.

**Changes**
- `skills/ok-version/SKILL.md`: changed in the frontmatter `description`, the intro, Procedure step 1 (rewritten as above, still read-only), and step 4 (the label).

**Behavior changes**
- **B109** `skills/ok-version/SKILL.md`. Before: the first line reports a stamp that always equals the vendored stamp. After: it reports the installed `ok` plugin's version, labeled as installed.
  Users: in the release: the owner reading the report; no program parses it. Across trued-up projects: the vendored copy changes on `/ok`; the slash command and its name do not change.
  Ruling: rewrite.

### 10. A verified decline closes its defect issue

**Calls**
- The close reason is the verifier's note on the defect, "<the fixer's reason; what you checked>"; for a `duplicate` it also names the defect it duplicates and that defect's final state. Decided by: `skills/converge/prompts/verify.md` and the work item.
- Only a decline the verifier accepted as not real, or as left standing by the accept list, and a verified duplicate close `answered`. A verified decline whose note names a file the run leaves alone, or that carries a boundary question (`prompts/fix.md`: "declined with a question recorded"), turns its defect issue into the upstream or judgment issue with `issues revise`, as the owner list's "A defect in a file the run leaves alone … With an `issue` field" route already does, and the owner list settles the fixer's `noticed` or question call `promoted` with that issue's id, so the harm keeps its id, discussion, and ruling. Decided by: the owner list's existing route and A9 (`answered` means the code no longer shows the defect).

**Changes**
- `skills/converge/prompts/owner-list.md::Close the issues the run resolved`: changed. For every defect with an `issue` field that stands `declined` (not real, or left standing by the accept list) or `duplicate` with a `verified` field, run `issues close <id> --as answered --reason "<the verifier's reason>"`; for a verified decline that names a left-alone file or carries a boundary question, revise the issue as the second call says.
- `skills/_shared/artifact-definitions.md`, the defect-close lines ("`answered` when the code no longer shows the defect", "A defect issue closes as `fixed` or `answered`"), and `scripts/ok-planner-CLAUDE.md`, the defect-close paragraph: changed. They add the verified-decline close. This stage runs after item 3's, which edits both files.
- `skills/converge/prompts/owner-list.md::Close`: changed. The result line adds `<n> declined`.
- `skills/converge/SKILL.md::What the run leaves for the owner`: changed. It adds "or declined with a reason a verifier accepted" to the issues it closes.
- `scripts/ok-planner-cheatsheet.md::Defect issues`, "Closing": changed. It adds the verified-decline close as `answered`.

**Behavior changes**
- **B8** `skills/converge/prompts/owner-list.md`. Before: a verified decline left its issue open, and the next run took it up again. After: the issue moves to the archive as `answered`, with the reason.
  Users: in the release: the next run's `review backlog`, the archive's readers, which already read `answered`, and the owner list's left-alone route, which now also takes a verified decline that names a left-alone file or a boundary question. Stored state: no format change. Across trued-up projects: prompt and cheatsheet at true-up.
  Ruling: rewrite.

### 11. `review backlog` finds file names with no extension

**Calls**
- A token counts as a path where it holds a `/` or ends in `.<ext>`: `PATH_PATTERN` becomes `[\w.-]*(?:/[\w.-]+)+|[\w./-]+\.\w+`, and `SITE_PATTERN` takes the same path alternative before `:`. A bare word with no slash stays out, so `LICENSE` in prose is not a file. Trailing dots are stripped before the file test. Decided by: the work item and its example.
- `skills/converge/SKILL.md`'s backlog paragraph ("the first `path:function` its problem names as the site") restates the site rule I2 replaces; it reads "the first whose path is among its files, else its first file". Decided by: plumbline-coding rule 1.

**Changes**
- `scripts/review::PATH_PATTERN` and `scripts/review::SITE_PATTERN`: changed. Both match extensionless paths with a slash; `backlog_entry` is their only user.
- `scripts/review::backlog_entry`: changed. It strips trailing dots from each token before the file test.

**Improvements**
- **I2** `scripts/review::backlog_entry`: A9, `site` is the first `x:y` match in the problem even where its path names no file of the tree, or one the run leaves alone, so the report names a site outside its `files`. Afterward: the site is the first `path:function` match whose path is among `files`, else `files[0]`.

**Behavior changes**
- **B9** `scripts/review::cmd_backlog`. Before: an issue naming only an extensionless file went under `settled` with `files: []`. After: it yields a report naming that file, with a site among `files`.
  Users: in the release: the skill's backlog paragraph and the merge prompt, which take reports as they are. Across trued-up projects: the tool at true-up.
  Ruling: rewrite.

### 12. A second sketch never overwrites the first

**Calls**
- Where `.ok-planner/sketches/YYYY-MM-DD-<topic>-sketch.md` stands, the sketch goes to `YYYY-MM-DD-<topic>-<n>-sketch.md`, `<n>` the lowest integer from 2 whose name is free, and the report names the path written. Decided by: the work item and the sibling `admin/true-up::free_path`.

**Changes**
- `skills/sketch/SKILL.md`: changed in the "Save sketches to" line (it names the suffix form) and Process step 4 (check the path, then write to the first free one).

**Improvements**
- **I102** `skills/sketch/SKILL.md` Process step 4: A2, `/plan-sprint` Terminal moves a taken sketch to `.ok-planner/history/sketches/` by name, so a new sketch whose name an archived one holds makes that later move overwrite the archived sketch. Afterward: a name is free only where neither `.ok-planner/sketches/` nor `.ok-planner/history/sketches/` holds it.

**Behavior changes**
- **B110** `skills/sketch/SKILL.md` step 4. Before: a second sketch on the same topic and day overwrites the first. After: it goes to the first free `-<n>` path, checked against the archive too.
  Users: in the release: `/plan-sprint` Terminal, which moves sketches by path and works with any name; nothing parses the pattern.
  Ruling: rewrite.

### 13. Certification's return states the deltas' delivery

**Calls**
- A new verb, `review deltas --sprint <path> [--key gate]`, makes the counts, so the line is mechanical. Decided by: the converge skill's "Every mechanical step is a verb of `.ok-planner/bin/review`".
- Counting: compared is every delta heading `sprint_deltas` finds; each C3 defect matches the delta whose `delta_target` is among its `files`; landed at build is a delta with no C3 defect, or only `declined` or `duplicate` ones; landed by the run, one whose C3 defect is `verified`; stuck, one whose C3 defect is `stuck`; any other state is listed as unsettled, and a C3 defect that matches no delta as unmatched. Decided by: the work item.
- The return gives it its own `deltas` bullet in sprint mode. Decided by: the work item ("one line").
- "Landed at build" is derived from the comparison `delta_failures` already makes, not from the absence of a C3 defect, so a delta the review missed and that still differs from its artifact is not counted as landed, and the `deltas` bullet agrees with `review certified` item 1. Decided by: A9 and plumbline-coding rule 6.

**Changes**
- `scripts/review::cmd_deltas`: new. It reuses `resolved_sprint`, `sprint_deltas`, `delta_target`, `items_of`, and `report_files`, and prints JSON: `compared`, `landed_at_build`, `landed_by_run`, `stuck`, `unsettled`, `unmatched`, each delta named `<Operation> <kind>: <slug> (<target>)`.
- `scripts/review::VERB_HELP` and `build_parser`: changed. They add `deltas`.
- `skills/converge/SKILL.md::The return`: changed. In sprint mode a `deltas` bullet reads `<n> compared, <n> landed at build, <n> landed by this run (<each artifact>), <n> stuck (<each artifact>)`, from `review deltas`.
- `.ok-planner/review/project.md`, the review tool's entry: changed. It adds `deltas --sprint <path> [--key]`.

**Behavior changes**
- **B10** `skills/converge/SKILL.md::The return` (sprint mode). Before: no deltas line. After: the `deltas` bullet.
  Users: in the release: step 13, and `certification_failures`, which searches the section only for the ledger path and stuck defect ids. Stored state: earlier completion reports read the same.
  Ruling: rewrite.

**New surface**
- `review deltas`, declared in `scripts/review::build_parser`: internal.

### 14. Every verified drive defect gets its confirm driver

**Calls**
- The mark is a defect field, `confirmed=<the confirm driver's task>`, set with `tasks item set <defect> --field confirmed=<task>` and no state change. Decided by: it mirrors how the verifier writes `verified=<task>`.
- `review drives --confirm --dry-run` prints `{"pending": [{"defect", "story"}]}` and files nothing, so the step knows before it starts the stack; `--dry-run` without `--confirm` is refused. Decided by: plumbline-coding rule 7, and the `--dry-run` idiom `issues import` uses.
- The final confirm runs at most once per run, in a round of its own (`tasks round start`), so drive names and instance folders do not collide with step 6's. Decided by: the work item and `drive_names`.
- The return names every verified drive defect still unconfirmed at the end, from `--dry-run`, in the `fixed` bullet. Decided by: A9.
- The new end-check branch in Loop 2 step 2 runs in drive and sprint mode only, as step 6 does. Decided by: plumbline-coding rule 2.

**Changes**
- `scripts/review::confirm_briefs`: changed. It selects every defect at `verified` with `source=drive` and no `confirmed` field, from any round; the scan of this round's verify briefs goes, and `current_round` stays for `cmd_snapshot`.
- `scripts/review::cmd_drives`, `build_parser`, and `VERB_HELP`: changed. `--dry-run` with its refusal.
- `skills/converge/prompts/drive.md::Confirm, where your brief says so`: changed. On **achieved**: `tasks item set <defect id> --field confirmed=<your task> --note "confirm drive: <what you saw>"`.
- `skills/converge/SKILL.md::Loop 2` step 6: changed. Its condition becomes "where `review drives --confirm --dry-run` lists any defect".
- `skills/converge/SKILL.md::Loop 2` step 2 (end check): changed. Where no defect stands `open` but `--dry-run` lists a defect and the final confirm has not run, run `tasks round start`, then step 6, and go to step 1; otherwise the loop ends.
- `skills/converge/SKILL.md::The return`, the `fixed` bullet: changed. It names unconfirmed drive defects.
- `.ok-planner/review/project.md`, the review tool's entry: changed. It adds `drives --confirm [--dry-run]`.

**Behavior changes**
- **B11** `scripts/review::confirm_briefs` and `review drives --confirm`. Before: it briefed only defects this round's verify tasks verified. After: every verified drive defect not yet confirmed, from any round.
  Users: in the release: Loop 2 step 6. Across trued-up projects: tool and skill together at true-up; the ledger lives for one run.
  Ruling: rewrite.
- **B12** `skills/converge/prompts/drive.md` confirm. Before: `achieved` left the defect unchanged. After: it sets `confirmed`.
  Users: in the release: `confirm_briefs`; `tasks calls` and `certified` are unaffected.
  Ruling: rewrite.
- **B13** `skills/converge/SKILL.md::Loop 2` end check. Before: the loop ended when no defect was `open`. After: a final confirm runs once where a defect waits.
  Users: in the release: the session.
  Ruling: rewrite.

**New surface**
- `review drives --dry-run`, declared in `scripts/review::build_parser`: internal.

### 15. An approved sprint carries its mark, and executors refuse a draft

**Calls**
- The mark is YAML frontmatter above the title: `---`, `approved: <date from date +%Y-%m-%d>`, `---`; any non-empty value counts. Decided by: `decision:sprints-carry-an-approval-mark`, which compares the mark to the `closed:` stamp; `closed_stamp` already parses multi-key frontmatter, and no reader takes a sprint's first line as its title.
- The template's fenced block carries no mark, so a draft never has one; the preamble outside the fence says the planning session writes it at approval. `checks/sprint-boilerplate` reads only the fenced sections. Decided by: the decision.
- One check, `approval_refusal(root, sprint)` in `scripts/review`: it passes where the frontmatter holds `approved:` or where the `-base.txt` file stands beside the resolved sprint path; otherwise its message reads "<sprint> carries no approval mark, so it may be a draft the owner never approved; if you approved it, add `approved: <date>` to YAML frontmatter at its top (`---`, `approved: <date>`, `---`)". A new verb, `review approved --sprint <path>`, exposes it (exit 0 printing `approved: <value>` or `exempt: <base file>`; exit 1 with the message), and the template's step 2, converge's sprint mode, and `certified` all use it. Decided by: one idiom per job.
- `closed_stamp` becomes `frontmatter_value(text, key)`, serving `closed` and `approved`. Decided by: plumbline-coding rule 6.
- In `review certified`, the archived-with-`closed:` terminal check comes first; an unmarked sprint with no base then prints `SPRINT NOT COMPLETE: <sprint>` with the refusal as its one failure and exits 2. Decided by: the decision and the goal rule.
- In converge's sprint mode, the approval check runs before the base file is read or written from the owner's answer; writing the base first would exempt a draft. Decided by: the decision ("sprint certification writes it only for a sprint it does not refuse").
- Archive step 4 adds `closed:` to the frontmatter beside the mark, where frontmatter exists. Decided by: the file now opens with frontmatter.
- B15 and B16 are ruled by the owner's choice of exemption on `draft-sprint-indistinguishable-from-approved`: a sprint whose base file exists is exempt, and every other unmarked sprint is refused with the steps to add the mark. Decided by: the owner's ruling recorded on that issue.
- `review approved` runs `load_config` first, so execution step 2 needs `.ok-planner/review/config.json` before the base file is written; the step's refusal text covers that error too. Certification already needed the file. Decided by: plumbline-coding rule 7.

**Changes**
- `skills/plan-sprint/SKILL.md::12. Approval`: changed. Once the owner approves the final sprint, the session writes the mark at the top of the sprint file, and nowhere else; after a change at approval, only after the final yes.
- `skills/plan-sprint/sprint-document.md`, the preamble: changed. It says the planning session writes the mark at approval.
- `skills/plan-sprint/sprint-document.md::How to execute this sprint` step 2: changed. It first runs `.ok-planner/bin/review approved --sprint <this sprint's path>`; on a refusal it names the message to the owner and stops.
- `skills/plan-sprint/sprint-document.md`, archive step 4: changed. It adds `closed:` to the frontmatter beside the mark.
- `admin/retired-boilerplate.json`: changed. It gains the replaced lines.
- `skills/converge/SKILL.md::Setting up the run` step 1, sprint mode: changed. It runs `review approved --sprint` first; on a refusal it says the message and stops, with no return block.
- `scripts/review::approval_refusal` and `scripts/review::cmd_approved`: new.
- `scripts/review::closed_stamp`: becomes `frontmatter_value`.
- `scripts/review::cmd_certified`: changed. It runs the approval check after the terminal check.
- `scripts/review::VERB_HELP` and `build_parser`: changed. They add `approved`.
- `.ok-planner/review/project.md`, the review tool's entry: changed. It adds `approved --sprint <path>`.
- `.ok-planner/design/decisions/sprints-carry-an-approval-mark.md`: new, from the sidecar.
- `.ok-planner/design/decisions.md`: regenerated.

**Behavior changes**
- **B14** `skills/plan-sprint/SKILL.md::12. Approval`. Before: an approved sprint opens with `# Sprint:`. After: it opens with the frontmatter mark.
  Users: in the release: `frontmatter_value`, archive step 4, true-up's `live_sprints` and `section_bounds` (unaffected by frontmatter), `tasks render --sprint`, and `issues promote --sprint` (filename only).
  Ruling: rewrite.
- **B15** `skills/plan-sprint/sprint-document.md` step 2. Before: any sprint executes. After: an unmarked sprint with no base file is refused with the steps to add the mark.
  Users: in the release: executors and `/goal`. Across trued-up projects: a live sprint approved before this release, unmarked and not yet started, is refused once true-up rewrites its step 2, until the owner adds the mark.
  Ruling: rewrite across trued-up projects: the owner chose this exemption, and the refusal says how to add the mark (owner's ruling on `draft-sprint-indistinguishable-from-approved`).
- **B16** `skills/converge/SKILL.md` sprint mode. Before: an unmarked sprint was certified, and a missing base was asked for. After: an unmarked sprint with no base is refused.
  Users: in the release: template step 12. Across trued-up projects: the same live sprints as B15; every executed sprint has a base and is exempt.
  Ruling: rewrite across trued-up projects: as B15.
- **B17** `scripts/review::cmd_certified`. Before: it checked items 1 to 3 for any sprint. After: an unmarked sprint with no base gets `SPRINT NOT COMPLETE` naming the mark.
  Users: in the release: step 13 and `/goal`. Across trued-up projects: none in practice; `certified` runs after execution wrote the base, and archived terminal sprints come first.
  Ruling: migrate: the base-file exemption keeps every executed sprint's verdict (call). Decided by `decision:sprints-carry-an-approval-mark`.

**New surface**
- `review approved`, declared in `scripts/review::build_parser`: internal.

### 16. A reference docspec may list a class whose exceptions make its members public

**Changes**
- `.ok-planner/design/concepts/docspec.md`: changed, from the sidecar.
- `.ok-planner/design/concepts.md`: regenerated.

**Behavior changes**
None. Every change is new code no existing user reaches. The concept's text changes, and the tooling already behaves this way.

### 17. Payload scripts carry design citations, and true-up strips them

**Calls**
- A citation line is a line whose only content is a `#` or `//` comment holding one tag from the core's `DESIGN_CITATIONS` and `CORPUS_CITATIONS` (`@concept:`, `@story:`, `@decision:`, `@subject:`, `@practice:`) and one slug, with optional whitespace; its line ending goes with it. The pattern is built from those two tuples, not a new list. Decided by: the decision, the cheatsheet's citation grammar, and plumbline-coding rule 6.
- The strip applies to `EXECUTABLE_FILES` renderings only; `ESTATE_FILES`, the skills, and the page build are untouched. Decided by: the decision (payload script vs markdown payload).
- `suite_renderings` also yields the stripped rendering, so the legacy `.ok-review/bin/review` match compares against what true-up writes. Decided by: plumbline-coding rules 1 and 6.
- `checks/materialized-standalone` reads the copy true-up would write: it makes a temp folder with `project/` and `lint/` (each `git init -q`), runs `bash <family>/admin/true-up` from `project/` with `OK_PLANNER_PROJECT_ROOT` dropped from the environment, copies every regular file true-up wrote under `project/.ok-planner/bin/`, `.ok-planner/scripts/`, `.ok-planner/hooks/`, and `.claude/hooks/` into `lint/` with the relative path flattened by `__` and its leading dot dropped, runs `node <family>/scripts/plumbline lint/` with the existing exit and line mapping, reports each name as its project path, and removes the temp folder in `finally`. Where true-up exits non-zero, it reports `true-up failed in a scratch project: <stderr>` and fails. The markdown loop stays: a markdown payload citing a live slug still fails. Decided by: the decision, plumbline-coding rule 6, and the drive's scratch-project sibling in `.ok-planner/review/project.md`.
- Annotations: `# @story: veto-calls-made-in-my-absence` above `scripts/tasks::calls_table`; `# @decision: payload-citations-stripped-at-true-up` at the strip helper in `admin/true-up` (never copied, so its citations stand) and at the check's run. Decided by: the work item and execution step 8.
- `admin/ADMINISTRATION.md`'s executables bullet and `docs/integration-contract.md` layer 1 say each executable is written with its citation comment lines removed. Decided by: plumbline-coding rule 1.
- Items 17 and 19 both edit `admin/true-up`, `admin/ADMINISTRATION.md`, and `docs/integration-contract.md`, in different functions and paragraphs: item 19's stage runs after item 17's. Item 8's stage, which adds citations to `scripts/discover`, runs after item 17's, since the check refuses a payload citation until the strip lands. Decided by: execution step 4.
- The flattened names drop `.py`, `.sh`, and `.js` suffixes, so the lint picks each file's grammar from its shebang: every payload script keeps its shebang as its first line, and `ports-blocklist`, with none, is skipped. The scratch true-up runs each script's `--help` probe, so the check also needs a python3 at least 3.10 (the scripts call `zip(..., strict=True)`), beside `bash` and `git`. Decided by: the lint's `grammarFor` and the scripts' own requirements.

**Changes**
- `admin/true-up`, constant `CITATION_LINE` and helper `script_rendering(text)`: new. The helper applies `versioned(text)`, then removes every citation line.
- `admin/true-up::expected`: changed. The `EXECUTABLE_FILES` loop uses `script_rendering`.
- `admin/true-up::suite_renderings`: changed. It also yields `script_rendering(raw)`.
- `checks/materialized-standalone`: changed, as in the check call; the `PAYLOADS` table goes (I101), and a missing payload is reported by true-up's own failure.
- `scripts/tasks::calls_table`: changed; it carries the story annotation, with no behavior change.
- `admin/ADMINISTRATION.md`, the executables bullet: changed.
- `docs/integration-contract.md`, layer 1: changed.
- `.ok-planner/design/decisions/payload-citations-stripped-at-true-up.md`: new, from the sidecar.
- `.ok-planner/design/decisions.md`: regenerated.

**Improvements**
- **I101** `checks/materialized-standalone::PAYLOADS`: one list kept twice; the table restates `admin/true-up::EXECUTABLE_FILES`, so a script the core gains and the table lacks is never checked. Afterward: the check lints every file true-up wrote under the four script folders, so the core's table is the one list.

**Behavior changes**
- **B111** `admin/true-up::expected`, the executable renderings. Before: each payload script is copied with its version placeholder filled and every line kept. After: whole-line citation comments are also removed.
  Users: in the release: `materialize_steps`, diagnose, and the check. Across trued-up projects: a vendored copy of a script whose source now carries a citation (`bin/tasks`, and `bin/discover` after item 8) reads `DRIFT: stale:` on the next `/ok` and is rewritten; it behaves the same, since only comment lines differ.
  Ruling: preserve (call).
- **B112** `checks/materialized-standalone`. Before: it lints raw copies of 19 listed scripts, and any citation comment in a script source fails it. After: it lints the files true-up writes; a source citation passes once stripped, one inside other text still fails, every file true-up writes is checked, and the check needs `bash` and `git`, which true-up already needs.
  Users: in the release: `checks/run`, and developers before `/release`.
  Ruling: rewrite.
- **B113** `admin/true-up::suite_renderings`. Before: a legacy `.ok-review/bin/review` equal to the stripped current rendering is classed an edit and archived. After: it is a suite copy and is removed.
  Users: in the release: `review_plan`. Across trued-up projects: a project still on the pre-move `.ok-review/` layout whose copy equals the current carried rendering.
  Ruling: rewrite.

### 18. A plain `/converge` run takes vetoes at its close

**Calls**
- A vetoed row is filed as sprint step 13 files one: `issues file --from -`, kind `human`, category `product-intent`, its problem the row; then `issues rule <id> --text -` with the owner's words; where `issues rule` refuses for want of a name, relay the setting text and rule once a name resolves. Decided by: `decision:converge-close-takes-vetoes` ("as sprint certification's close does").
- A run whose `tasks calls` prints `None.` asks nothing beyond the offer. Decided by: the same decision.
- The archive-and-commit offer also stages the intake's two files where a veto filed an issue. Decided by: plumbline-coding rule 9.
- `skills/converge/SKILL.md` says the session "edits no file but the run's ledger", and "What stays outside this skill" names the owner-list agent as the one intake writer among its exceptions: both are amended to admit the session's filing of vetoed rows. Decided by: plumbline-coding rule 1.

**Changes**
- `skills/converge/SKILL.md`, frontmatter `description`: changed. "leaves the owner nothing to settle" becomes: the run ends in a report that asks which of its calls the owner vetoes, and an offer to archive and commit. The command's arguments do not change.
- `skills/converge/SKILL.md`, the paragraph "The run leaves the owner nothing to settle": changed. The owner reads the report, vetoes any call, and decides whether to archive and commit.
- `.ok-planner/design/decisions/converge-close-takes-vetoes.md`: new, from the sidecar; `.ok-planner/design/decisions/converge-finds-then-fixes.md`: changed, from the sidecar; `.ok-planner/design/decisions.md`: regenerated.
- `skills/converge/SKILL.md::The return`, the drive, analysis, and defects paragraph: changed. "it asks the owner nothing" becomes: present the `calls` rows and, beside the offer, ask which rows the owner vetoes, then file one issue per vetoed row as above. Sprint mode is unchanged: the template's step 13 makes that close.

**Behavior changes**
- **B18** `skills/converge/SKILL.md::The return` (drive, analysis, defects). Before: the run asked nothing beyond the offer. After: it asks for vetoes where the run made calls, and files a ruled issue per vetoed row.
  Users: in the release: the owner, and the next `/plan-sprint`. Across trued-up projects: skill text at true-up.
  Ruling: rewrite.

### 19. True-up keeps an uncommitted edit to a stamped file

**Calls**
- "Holds an uncommitted or staged-only change" is what `admin/true-up::uncommitted` already computes: a working-tree or index difference from `HEAD`, or every tracked file where there is no `HEAD`. An untracked stamped file, and any file in a project with no git repository, stay rewrites with no question. Decided by: the sibling `removal_split` and the decision's wording; counting untracked files would mark every stale vendored file in a project trued up but not yet committed.
- Paths under `.ok-planner/dashboard/` and `.ok-planner/.cache/` never take the question. Decided by: `decision:whole-file-ownership` (machine-local content holds no work of the project's).
- A `missing:` write and the mode-only `not executable` fix stay `DRIFT`. Decided by: the decision (only a rewrite of a file holding such a change is destructive).
- `copy_step` gains a reason argument; its strip caller keeps its line, "before true-up strips it". `materialize_steps` calls it, then adds `DESTRUCTIVE: archives a copy of <path> as it stands, which git cannot restore, before true-up rewrites it with the carried v<version> rendering: <path> -> <dst>` and `DESTRUCTIVE: stale: <path> differs from the carried v<version> rendering and holds an uncommitted or staged-only change`, with `Show: git -C <root> diff HEAD -- <path>`. The copy's action is appended before the materialize action. `uncommitted` runs once over all stale candidates. Decided by: plumbline-coding rule 2 and the siblings `rewrite_steps`, `copy_step`, and `removal_split`.
- A project that trues up to one version and, before committing, to the next gets archive copies of the first version's uncommitted renderings. Decided by: the amended decision, as written.
- `# @decision: true-up-asks-once-before-destructive-steps` at `materialize_steps`. Decided by: execution step 8.
- This stage applies `decision:true-up-asks-once-before-destructive-steps`; `decision:whole-file-ownership` lands in item 1's stage. It runs after item 17's stage. Decided by: one delta, one application, and the shared files.

**Changes**
- `admin/true-up::materialize_steps`: changed. For each existing, non-collision path whose text differs from its rendering and that is neither machine-local nor clean in git, it adds the copy step, and the stale step becomes destructive with a Show; every other branch is unchanged.
- `admin/true-up::copy_step`: changed; it takes the reason clause as a parameter.
- `admin/ADMINISTRATION.md`, the stale step's description and the destructive-step definition: changed. They name the destructive stale form and the archive copy, and read "…a suite-owned file that still carries its stamp or its fixed content and holds no uncommitted or staged-only change".
- `docs/integration-contract.md`, the true-up consent paragraph: changed. Suite-owned files are trued up with no question unless one holds an uncommitted or staged-only change, which true-up copies into the archive first under the one consent.
- `.ok-planner/design/decisions/true-up-asks-once-before-destructive-steps.md`: changed, from the sidecar.
- `.ok-planner/design/decisions.md`: regenerated.

**Behavior changes**
- **B114** `admin/true-up::materialize_steps` and `apply_plan`. Before: a stale stamped suite file holding an uncommitted or staged-only edit is `DRIFT: stale: …`, a bare `true-up` rewrites it with no question, and the edit is lost. After: two `DESTRUCTIVE:` steps, the archive copy and then the rewrite with its diff as Show; a bare `true-up` refuses, writes nothing, and exits 1, and `--go-ahead <id>` applies both. The plan id changes accordingly.
  Users: in the release: `/ok` step 4, which already shows destructive plans and asks once; ADMINISTRATION.md and the integration contract, changed above; the drive's scratch true-up, which writes only `missing:` files; and `checks/materialized-standalone`, which runs in a fresh repository with nothing stale; and `/ok` step 5.4, "True up again": where an input answer or an `amend` draft changes a rendering, such as a repaired `lint_checks` that turns a check off, the second pass finds the rules files pass one wrote stale and uncommitted, so it shows two more `DESTRUCTIVE:` steps, asks the one question again as step 5.4 already does for a destructive second plan, and archives copies of text true-up wrote minutes earlier. Across trued-up projects: an owner whose suite file holds an uncommitted edit meets the one question and gets an archive copy, as the amended decisions commit to. Across installed plugins: a session whose `/ok` text predates the update runs a bare `true-up` and meets the core's existing refusal, which names `/reload-plugins` and then `/ok`.
  Ruling: migrate: the bare-true-up path keeps the core's existing refusal, which names `/reload-plugins` and `/ok`; the second pass of `/ok` step 5.4 is rewritten as the amended `decision:true-up-asks-once-before-destructive-steps` writes it (call).

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
   with the owner. Where `/goal` handed you this file, its checker is
   a separate model that reads only the session: it opens no file and
   runs no command. State its stop condition in your first message,
   in these words: "This goal is met when `.ok-planner/bin/review
   certified --sprint <this sprint's path>` prints `SPRINT COMPLETE`
   in this session. Archiving and committing are the owner's acts,
   not goal terms."

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
   `stories.md`, or `decisions.md`, `.ok-planner/subjects.md` or
   `.ok-planner/practices.md`, or the docspec index
   `.ok-planner/docspec.md`, every one of which
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
   build prompt carries both rules.

9. Uncommitted work is the only record of the run. Every task stages
   the paths it touched as it closes (`git add <paths>`), and the run
   records them. Never run `git checkout`/`restore`/`reset`/`stash`/
   `clean` on your own initiative. Fix a bad edit forward by editing
   again.

10. The completion report lives beside this sprint file, same
    filename with `-completion` before the extension. The session
    re-renders it whole from the run before every dispatch: `##
    Stages` from the build tasks and `## Calls` from the run's
    `divergences` pool, one row per call an agent made without the
    owner. Build tasks record calls, forks, what they noticed, and
    the improvements they landed as items; the report is rendered,
    never hand-edited.

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

13. Re-render the completion report whole with the certification's
    calls: write the output of `tasks --file
    .ok-planner/sprints/<sprint-name>-run.jsonl render --title
    "<this sprint's title>" --sprint <this sprint's path>
    --certification <the /converge run's ledger>` to the report
    file. `--file` names this sprint's run, because `/converge`
    moved the tracker's pointer to its own ledger. Then write the
    return block into the completion report, after its rendered
    sections, under a `# Sprint certification` heading, with the
    `/converge` run's ledger path. Nothing renders the report after
    this. Then run `.ok-planner/bin/review certified --sprint <this
    sprint's path>` and show its output whole. It checks items 1 to 3
    of the completion contract against the repository, and prints
    `SPRINT COMPLETE`, or `SPRINT NOT COMPLETE` with each failure.
    Where it prints `SPRINT NOT COMPLETE`, name each failure to the
    owner and stop: it is a genuine blocker under step 11. Then
    present the completion report's `## Calls` table to
    the owner, and ask which rows, if any, the owner vetoes. For each
    vetoed row, file one issue with `.ok-planner/bin/issues file
    --from -`, in the format of the `{{ISSUE-FILE-FORMAT}}` block of
    `.claude/skills/_shared/artifact-definitions.md`: kind `human`,
    category `product-intent`, its problem the row. Then record the
    owner's words as that issue's ruling with `.ok-planner/bin/issues
    rule <id> --text -`, the words on stdin, so the next
    `/plan-sprint` pulls the veto in as the owner's decision. `issues
    rule` signs the ruling with the name of the person running the
    session; where it refuses for want of a name, relay the refusal's
    setting text to the owner and record the ruling once a name
    resolves. Then offer the archive and the commit below as one
    owner act. Walk nothing else with the
    owner: every defect the run could not fix and every question it
    raised is already in the intake, for the next `/converge` or
    `/plan-sprint`.

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
   for a concept, story, or decision, `.ok-planner/subjects/` or
   `.ok-planner/practices/` for a subject or practice, and
   `.ok-planner/docspec/` for a docspec, each with its catalog TOC
   regenerated, the docspec index `.ok-planner/docspec.md` among
   them; and `.ok-planner/surface/surface.md` for the surface
   intent.
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
`.ok-planner/bin/review certified --sprint <this sprint's path>`
checks them there and prints `SPRINT COMPLETE` or `SPRINT NOT
COMPLETE`. A checker that reads only the session, as `/goal`'s does,
decides from that command's latest output in the session; a checker
that runs commands runs it. A `stuck` defect listed in the
return, a check that still fails among them, is the owner's to take
up, and holds no term of the contract open.
Presenting the report, archiving, committing, and the
`closed:` stamp all follow completion, and none is a term of the
goal. `sprints/` and
`.ok-planner/history/sprints/` satisfy the rule alike, and a sprint
already archived with a `closed:` stamp is terminal. A missing
completion report, or one without the return block,
means not done. Nothing else counts either way.
