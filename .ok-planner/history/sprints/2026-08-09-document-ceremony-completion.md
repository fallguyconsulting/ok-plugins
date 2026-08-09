# Completion report: The /document ceremony

Sprint: `2026-08-09-document-ceremony.md`. Execution record, kept
current as stages landed.

## Work done

- **Corpus deltas applied.** All 13 sidecar bodies copied verbatim into
  `.ok-planner/design/` (6 concepts, 2 stories, 5 decisions). All three
  catalog TOCs refreshed; `.ok-planner/bin/audit-check` reports no
  TOC/shape findings. Its 85 `audit-missing` findings are pre-existing
  and corpus-wide — the audit corpus is empty pending the first
  periodic `/audit` run — and are not introduced by this sprint.
- **Ceremony body** written at `plugins/ok/ceremonies/document/SKILL.md`:
  activation guard, estate resolution, the two spines, the `/audit`
  phase 0 with the delivery criterion, the nine-phase spine (Layout,
  Audit, Project, Synthesize, Assess, Distill, Check, Present,
  Close-out), the warrant ladder, the four-layer box with the fixed
  synthesis brief embedded, the presentation, and the boundary list.
- **Family surfaces** written at
  `plugins/ok/families/{ok-planner,ok-plumbline,ok-workspaces}/ceremony/document.md`.
  ok-planner's carries the corpus home (`.ok-planner/documentation/`),
  the surface declaration (`.ok-planner/surface.json`), the record
  shapes (catalog row, assessment, trap, archived experiment), the
  attestation rule, story-fitness measurement, the three filing kinds,
  and the checker invocation with the fallback announcement.
  ok-plumbline's contributes the story↔test map; ok-workspaces' is the
  conventional nothing-to-contribute surface.
- **Admin layer at four ceremonies.** `plugins/ok/admin/ADMINISTRATION.md`
  and `plugins/ok/admin/converge` (CEREMONIES tuple) carry `document`.
  Each family's converge core materializes its `document.md` surface:
  ok-planner's `CEREMONY_VERBS` array, ok-plumbline's converge loop and
  its binary's `CEREMONY_VERBS` list, ok-workspaces'
  `vendored-skills.js` list.
- **Conformance check.** `checks/ceremony-surfaces` gained the
  `document` verb with the phase tuple matching the body's spine.
- **Contract and README.** `docs/integration-contract.md` (four
  suite-owned verbs, surface list, collision rule, conformance
  section), `README.md`, `plugins/ok/CLAUDE.md`,
  `plugins/ok/skills/ok/SKILL.md`, the family index skill
  `ok-planner/skills/ok-planner/SKILL.md`, and the family CLAUDE.md
  files all name four ceremonies.
- **Cheatsheet and estate CLAUDE.md.** The ok-planner cheatsheet
  template gained `documentation/` in the records bullet, `/document`
  in the lifecycle, and a Documentation section; the estate CLAUDE.md
  template gained a documentation-corpus section and a lifecycle
  paragraph.
- **Checker.** `plugins/ok/families/ok-planner/scripts/document-check`
  (python, exit 0/2/1, version-stamped): stamp, warrant, remainder,
  evidence, catalog, citation checks — materialized to
  `.ok-planner/bin/document-check` by the family converge (diagnose
  covers it too). Annotated `@story: answer-absence-from-catalogs`.
- **Tests.** New harness
  `plugins/ok/families/ok-planner/test/document-check.sh` (13 cases,
  all passing, `@story: answer-absence-from-catalogs`);
  `plugins/ok/test/administration.sh` extended to the fourth verb and
  the materialized `bin/document-check` (green);
  ok-plumbline's collision-rule test extended to `document` (green);
  `checks/run` all green; `node --check` clean on the touched js.
- **Sketch archived.** `2026-08-09-docs-as-assessment-sketch.md` moved
  to `.ok-planner/history/sketches/`.

## Divergences

None from the work items. Overshoot within intent: the three family
converge cores and ok-plumbline's binary each carried their own
ceremony-verb enumeration, and the sprint's admin item promised that
"each family's converge materializes its `document.md` surface" — the
lists were extended to make that outcome hold.

**In-cycle corpus repairs, for the owner's after-the-fact veto.** The
certification fix loop aligned four pre-existing artifacts whose text
still enumerated three suite ceremonies, each a mechanical count
update and nothing else:

- `concepts/integration-contract.md` — the ceremony-surface sentence
  now names documentation beside planning, certification, and audit.
- `concepts/skill-family.md` — the Boundaries sentence likewise.
- `decisions/suite-owned-ceremonies.md` — title and Choice name the
  fourth suite verb; the ambiguous "three ceremonies" Alternatives
  line now reads "once per family", which is what it meant.
- `stories/one-ceremony-per-project.md` — the Story clause adds
  documentation to the ceremonies that reach every estate.

One further repair changed more than a count. The
certification fix loop amended one pre-existing decision the sprint
listed no delta for: `decisions/audit-audience-split.md` enumerated
"exactly three gated paths" into the issue intake, which the sprint's
own approved deltas contradict — `concept:trap` commits that a
contradicted promise "is a defect and reaches the issue intake", and
the ceremony work item commits the distill phase to "defects filed as
intake issues" and to "defect and story-fitness issue filing into the
intake". The enumeration now reads four, naming the documentation
ceremony's assess and distill phases and the bound they file under (a
warrant over a population the owner already fixed), plus the matching
bullet in Alternatives for the rejected in-context-only option. No other gate's
text changed, and nothing new was decided: the fourth path is the one
the approved deltas and the built ceremony already commit to. Leaving
the sentence at three would have left the corpus contradicting itself.

## Calls made where the sprint was silent

- Phase names for the document spine: Layout, Audit, Project,
  Synthesize, Assess, Distill, Check, Present, Close-out.
- The surface declaration's committed home: `.ok-planner/surface.json`
  (owner-declared, stack-profile-patterned), and the corpus home's
  substructure: `documentation/{catalog,assessments,traps,experiments}/`
  plus the `concepts.md` router.
- Record shapes: assessment frontmatter (`assessment/subject/way/
  release/outcome/warrant`, outcomes `held|unverified`, mandatory
  `## Unverified` section); trap frontmatter (`trap/release/repro`,
  three-state repro, mandatory Assumption/Actual behavior/Evidence
  sections); experiment `record.md`; catalog frontmatter
  (`kind/release/population`) with one list row per member. The
  citation form is `src:<path>`, meaning "at the stamped commit".
- The synthesis brief's exact wording (fixed template embedded in the
  ceremony body).
- The estate CLAUDE.md template's opening line changed from "three
  kinds of content" to "several kinds" — the old count already
  undercounted its own sections before the documentation corpus
  joined.
- Not done, deliberately: this repo's own converged estate
  (`.ok-planner/ceremony/`, `.claude/skills/`,
  `.claude/rules/ok-planner-cheatsheet.md`) still reflects v15.1.1
  materializations without `document`. Estate convergence is `/ok`'s
  administration — always a user action, never an executor's — so the
  owner runs `/ok` to materialize the new surfaces here.

## Certification

# Certification — The /document ceremony

Status: certified clean

## Outcomes delivered

- **story:document-a-release** — `/document` exists as the suite's
  fourth ceremony: one canonical body vendored bare-named into every
  project, composing `/audit` as its first phase, enumerating the
  owner-declared surface mechanically, synthesizing assumptions in a
  four-layer box, warranting claims up the affirmative-only ladder,
  and leaving a release-stamped documentation corpus in the estate.
- **story:answer-absence-from-catalogs** — the catalog spine is
  checkable: `document-check` (vendored to
  `.ok-planner/bin/document-check`) holds every catalog file's rows
  one-to-one against its declared population, exercised by a 13-case
  harness.
- The five new decisions and six new concepts are live in the design
  corpus, TOCs refreshed; the admin layer, conformance check,
  integration contract, README, cheatsheet, and estate guide all teach
  four ceremonies; the sketch is archived.

## Divergences

- Overshoot within intent: the three family converge cores and
  ok-plumbline's binary each carried their own ceremony-verb
  enumeration; all were extended so each family's `document.md`
  surface actually materializes (the admin work item's promised
  outcome).
- Five in-cycle corpus repairs, each surfaced above in this report's
  Divergences for after-the-fact veto: four mechanical three→four
  enumeration alignments (`integration-contract`, `skill-family`,
  `suite-owned-ceremonies`, `one-ceremony-per-project`) and one
  substantive alignment — `audit-audience-split` now enumerates four
  gated intake paths, the fourth being the documentation ceremony's
  assess and distill filings the sprint's approved deltas already
  commit to. **This last one deserves your eye**: the fix loop first
  over-wrote it (adding rationale and alternatives of its own), a
  re-review caught the overreach, and a second pass cut it back to
  exactly what the approved deltas determine.
- One expression-only repair to an approved delta body:
  `concepts/assessment.md`'s Boundaries sentence now matches the
  enforced two-value outcome vocabulary (held/unverified, with trap
  and defect as dispatched record kinds), applied to the artifact and
  its sidecar copy in lockstep, byte-identical.
- Fixer calls where the sprint was silent: rung 2 of the warrant
  ladder clarified as investigative-only in the ceremony body (the
  decision already foreclosed reading-only warrants); the fourth
  gated path names both filing phases ("assess and distill") to match
  the built surface.

## Findings fixed

- Sprint alignment: 9 findings over three rounds — four stale
  three-ceremony corpus artifacts, the audit-audience-split
  reconciliation, missing annotations for the new artifacts, a README
  test-harness omission, a phase misattribution, a report-disclosure
  gap. All fixed; final round otherwise clean.
- Code review: 6 findings over three rounds — a design-corpus
  annotation baked into the vendored checker (plus the missing
  `materialized-standalone` coverage that would have caught it), a
  dead parameter, two family-CLAUDE.md completeness gaps, the
  overreach of the first audit-audience-split rewrite, a stale line in
  this report. All fixed; final round otherwise clean.
- Test suites: clean on first pass and every re-run (checks/run,
  planner run.sh + stories.sh + document-check.sh, administration.sh,
  plumbline run.sh, workspaces tags.sh — workspaces demo.sh not run:
  the change touches only that family's ceremony-surface list,
  exercised by administration.sh).
- Mechanical floor (annotation integrity): clean every round.

## Issues promoted

None. No kickbacks survived to the architect and nothing was escalated
at the cap; the intake is untouched by this run.

The close-out offer: with everything certified clean, the standing
offer is to archive this sprint (with this report, its delta sidecar,
and no issue receipts — none exist) to `.ok-planner/history/` and
commit the work — both owner acts, taken only on the owner's word.
