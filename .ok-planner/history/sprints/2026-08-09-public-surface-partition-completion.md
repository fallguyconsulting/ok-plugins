# Completion report: The public-surface partition and the user-vantage audit

Execution record for `2026-08-09-public-surface-partition.md`, kept
current as stages land. Dispatched via the native `goal` mechanism.

## Work done

- **Corpus deltas applied.** All 18 sidecar bodies copied verbatim into
  `.ok-planner/design/` (2 new concepts, 6 amended concepts, 1 new
  story, 2 new decisions, 7 amended decisions). All three TOCs
  refreshed: new entries added alphabetically
  (`surface-guidance`, `surface-ruling`, `rule-the-public-surface`,
  `owner-guided-surface-partition`, `user-vantage-story-audits`),
  amended one-liners updated where the artifact's first sentence
  changed. Entry counts verified against live files: 35 concepts,
  23 stories, 32 decisions.
- **ok-planner ceremony surfaces amended.** `ceremony/audit.md`
  rewritten: requires the declaration and guidance under
  `.ok-planner/surface/` (`surface.json`, `guidance.md`); the `Surface`
  phase runs `surface-reconcile`, ratifies guidance changes by anchor
  comparison with `git log` provenance (sprint-carried acknowledged, ad
  hoc walked), classifies unclaimed elements with every answer landing
  in the guidance, and writes the ruling
  (`.ok-planner/audits/surface/ruling.json` beside `extraction.json`,
  two anchors: stamped commit + guidance blob hash); stories are
  enumerated and batched apart (measurement) from decisions/concepts
  (reading); the story protocol runs the harness at
  `.ok-planner/experiments/`; a `Distill` phase files promotion
  candidates; the close-out states the output-path staleness rule.
  `ceremony/document.md` rewritten: requires a current audit (path
  rule), split-corpus layout under `.ok-planner/documentation/`
  (publishable: catalog/assessments/traps/concepts.md; verification:
  evidence/), shipped-vocabulary rule with `catalog:<kind>/<member>`
  citations, export set for the box, harness reuse for assumptions.
  `ceremony/plan-sprint.md`: predictive classification test added to
  Draft (claimed passes silently; unclaimed is one prose question; the
  answer rides the sprint as a guidance-edit work item; stories carry
  the public-by-construction prior).
- **Audit ceremony body restructured**
  (`plugins/ok/ceremonies/audit/SKILL.md`): three determinations
  (surface, story-from-user-side, decision/concept-by-reading), the
  spine gains `Surface` (one interactive moment, silent when settled)
  and `Distill` phases, the instrument split stated family-neutrally,
  the output-path staleness rule documented in the close-out,
  boundaries updated (story instrument executes the product through
  public elements only; the opening walk is the one owner
  conversation).
- **Document ceremony body amended**
  (`plugins/ok/ceremonies/document/SKILL.md`): opens by ensuring a
  current audit via the path-scoped diff rule, consumes determinations
  and ruling (catalog domain = ruling's public side), warrant ladder
  replaced by the harness warrant rule (experiment-only warrants;
  test: retired; reading investigative), vantage-split corpus described,
  presentation and NOT-do list updated.
- **surface-reconcile built**
  (`plugins/ok/families/ok-planner/scripts/surface-reconcile`):
  deterministic python; reads the declaration, runs enumerators, writes
  the extraction, diffs against the ruling, reports per-element
  public/private/UNCLAIMED plus STALE ruling entries and the
  guidance-anchor comparison (git-style blob hash); exit 0/2/1 per the
  sprint; no design-corpus annotations. Smoke-tested across all five
  states (no ruling, settled, unratified, unclaimed+stale, enumerator
  error).
- **Converge/administration wired**: family converge materializes
  `surface-reconcile` to `.ok-planner/bin/` (version-stamped,
  executable), diagnose checks its rendering, `administration.sh`
  asserts presence and executability. 76 administration assertions
  pass.
- **audit-check extended**: validates the ruling where one exists —
  both anchors, totality against the cached extraction in both
  directions, no member on both sides, and the recorded guidance hash
  against the guidance blob as of the stamped commit (git-resolved,
  working-tree fallback); `audits/surface/` excluded from the
  per-artifact bucket walk. Eight new harness fixtures; all 40 cases
  pass.
- **document-check amended** for the split corpus: `src:` in a
  publishable record is a `vocabulary` finding; `catalog:` citations
  resolve against the ruling's public side at the stamp; `held`
  requires `experiment:` (the `test:` form is a named retired-form
  finding); traps carry `demonstration:` and a non-empty evidence
  record at `documentation/evidence/<slug>.md` (which keeps the
  resolve-in-tree check); catalog populations checked against the
  ruling's public side; the harness at `.ok-planner/experiments/`
  validated (record shape, `commit:` stamp). Harness rewritten to the
  new rules; all 20 cases pass.
- **Auditor prompts updated** (`_shared/implementation-auditor.md`):
  implementation auditor scoped to decisions and concepts; new
  `{{STORY-AUDITOR-PROMPT}}` (user-vantage protocol on the harness,
  `[SURFACE]` input, harness ledger in its report); judge told both
  instruments and licensed to re-run archived experiments for story
  escalations. `artifact-definitions.md`: instrument-split bullet added
  to the audit definition; the story definition's verification
  paragraph updated (audit measures from the user's side; suites remain
  engineering discipline).
- **Templates and cheatsheet**: estate CLAUDE.md template gained "The
  public surface (`surface/`)" and the three-determination audit
  paragraphs, split-corpus documentation section, updated intake-filers
  list (fourth gated path = release-measurement distillation), updated
  lifecycle. Cheatsheet gained "The public surface" section and the
  restructured audit/documentation sections.
- **Suite documentation sweep**: README (verification section restates
  the three determinations, the vantage split, and the extended checker
  jobs; test-harness list updated), family CLAUDE.md (layout rows,
  verification paragraph, skills-wiring paragraph). The integration
  contract and `/ok` SKILL.md describe the ceremonies structurally and
  needed no change.
- **New harness `test/surface-reconcile.sh`** exercising the story
  end-to-end at the tool level (settled, unclaimed, stale, unratified,
  and error states), annotated `@story: rule-the-public-surface`;
  registered in the family CLAUDE.md layout and the README harness
  list.
- **Checks**: `checks/ceremony-surfaces` spine table updated (audit
  spine gains `Surface` and `Distill`, with decision annotations). All
  seven repo checks pass; all family harnesses pass (planner run.sh,
  document-check.sh, surface-reconcile.sh, stories.sh;
  administration.sh; plumbline run.sh; workspaces demo.sh and
  tags.sh).

## Divergences

- **Document-run filings narrowed to promotion candidates.** The
  amended `decision:audit-audience-split` limits the
  release-measurement distillation to promotion candidates only, while
  the pre-sprint document ceremony filed defects and fitness findings
  too. Under the new structure those findings belong to the audit's
  judge (an unsupported story is its confirmed gap; an unmeasurable
  story is its undecidable), so the document surface, body, and estate
  template now say exactly that. This realizes the deltas as written;
  it is noted because the sprint's document-ceremony work item did not
  spell out the filing change.
- **`checks/ceremony-surfaces` updated** though not named by any work
  item: it hardcodes each ceremony's spine, and the audit spine
  legitimately changed. Without the update the check fails on the new
  `Surface` and `Distill` phases.

## Calls made where the sprint was silent

- Deltas were applied as one opening stage: they are final-form
  verbatim copies, and applying them first makes `design/` the settled
  truth the rest of the work is brought into line with.
- Record shapes pinned where the sprint named the files but not the
  bytes: `ruling.json` `{commit, guidanceHash, kinds:[{kind, public,
  private}]}`; `extraction.json` `{kinds:[{kind, members}]}`; the
  guidance hash is the git blob hash (`git hash-object`), computed
  identically by `surface-reconcile` and `audit-check`; harness records
  keep the prior `record.md` shape with `commit:` replacing `release:`;
  publishable citations take the form `catalog:<kind>/<member>`.
- `surface-reconcile` classifies against the *existing* ruling and
  reports — applying guidance prose is the audit run's judgment, so the
  deterministic tool only detects unclaimed/stale members and anchor
  drift, exactly the exit-2 conditions.
- The existing surface-inventory sweep pass was kept (it reads reality
  and catches corpus under-claims — a different question from the
  partition) and now feeds candidate-kind reports to the opening walk.
- The old `.ok-planner/surface.json` home moved to
  `.ok-planner/surface/surface.json` per the sprint; no consumer
  project carries the old path (the document ceremony shipped in the
  immediately prior sprint), so no migration procedure was added.

# Certification — 2026-08-09-public-surface-partition

Status: certified clean

## Outcomes delivered

- `story:rule-the-public-surface` — every user-facing element is ruled
  public or private by owner-maintained guidance: the declaration and
  guidance have committed homes under `.ok-planner/surface/`, the audit
  derives and stamps the total-partition ruling, `surface-reconcile`
  reports settled/unclaimed/unratified deterministically (exit 0/2/1),
  and an unclassified element is a loud failure the checkers enforce —
  exercised end-to-end by `test/surface-reconcile.sh`.
- `decision:owner-guided-surface-partition` — the audit opens with the
  surface determination as its one interactive moment (silent when
  settled), and planning carries the predictive classification test.
- `decision:user-vantage-story-audits` — story support is measured
  from the user's side on the maintained harness
  (`{{STORY-AUDITOR-PROMPT}}`), decisions and concepts keep the
  adversarial reading, and the judge handles both instruments.
- `decision:document-composes-audit` +
  `decision:documentation-citations-are-product` — `/document` ensures
  a current audit by the path-scoped rule, consumes its determinations
  and ruling, and produces the vantage-split corpus: publishable
  records in shipped vocabulary with `catalog:` citations
  (`src:` banned there by document-check), verification records
  internal.
- The amended warrant model (`decision:affirmative-warrant-ladder`,
  `decision:full-reassessment-per-release`,
  `decision:cold-boxed-synthesis`, `decision:audit-audience-split`,
  `decision:adversarial-implementation-audits`) is realized across the
  ceremony bodies, surfaces, checkers, prompts, and teaching files.

## Divergences

- Document-run filings narrowed to promotion candidates only, per the
  amended gated-writers decision (defects and unmeasurable stories are
  the audit judge's filings now) — realized in the document surface,
  body, and estate template; noted because the work item did not spell
  the filing change out.
- `checks/ceremony-surfaces` spine table updated (audit spine gains
  `Surface` and `Distill`) — the check hardcodes each spine and no
  work item named it.
- New harness `test/surface-reconcile.sh` built (overshoot): the tool
  work item promised the tool, and the completion contract requires
  the new story exercised end-to-end by a test the suites run.
- Fixer calls made where the sprint was silent: none. Corpus edits by
  the fix loop: none. Architect refutations: none (no kickbacks).

## Findings fixed

- Sprint alignment (corpus-change judge): clean on first pass — all 18
  deltas byte-identical, all 13 work items realized, TOCs exact,
  changed corpus coherent.
- Test suites: clean — all 7 repo checks and all 8 harnesses pass
  (planner run.sh 40 cases, document-check.sh 20, surface-reconcile.sh
  10, stories.sh, administration.sh 76 assertions, plumbline run.sh,
  workspaces demo.sh and tags.sh).
- Mechanical floor (annotation integrity over the changed files):
  clean — every real annotation pair resolves; the one grep hit
  (`@concept:foo`) is a pre-existing illustrative example inside the
  annotation rules, not a live annotation.
- Code review: 1 finding, fixed and re-reviewed clean —
  `surface-reconcile` was missing from `checks/materialized-standalone`'s
  `PAYLOADS` enumeration, so the standalone-payload lint silently did
  not cover the new script; the entry was added and the check passes.

## Issues promoted

None — no architect-confirmed forks, no cap escalation; the intake is
untouched.

The close-out offer: archive the sprint (with this report and the
delta sidecar) to `.ok-planner/history/sprints/` and commit the work —
both owner acts, taken only on the owner's word; the archive commit is
then stamped into the sprint's frontmatter as `closed:`.

## Owner follow-ups (not this run's acts)

- This repo's own vendored/materialized copies (`.claude/skills/`,
  `.ok-planner/ceremony/`, `.claude/rules/ok-planner-cheatsheet.md`,
  `.ok-planner/bin/`) are now behind the payload; `/ok` re-converges
  them — administration is always a user action. The estate also still
  lacks `ceremony/document.md` and `bin/document-check`, from the prior
  sprint's close.
- This project has no `.ok-planner/surface/` declaration or guidance
  yet; the next `/audit` run will report that state per the amended
  ceremony surface.
