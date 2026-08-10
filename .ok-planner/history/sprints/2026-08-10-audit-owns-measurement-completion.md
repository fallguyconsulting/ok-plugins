# Completion report: The audit owns measurement

Sprint: `2026-08-10-audit-owns-measurement.md`
Execution: goal-driven session, started 2026-08-10.

# Certification — The audit owns measurement

Status: certified clean

## Outcomes delivered

- The audit ceremony now runs as an orchestrator-driven, four-determination
  pipeline: agentic surface extraction feeding the owner's opening walk
  (no surface-inventory sweep exists anywhere), story measurement on the
  maintained experiments, cold-boxed assumption synthesis and measurement
  inside the audit, adversarial decision/concept reading in parallel —
  one terminal judge over every escalation, a distillation that files
  only nominations, a run report written to `history/audits/`, and a
  presentation composed from that report only when invoked à la carte.
- `/document` measures nothing: it ensures a current audit and constructs
  the documentation corpus from the audit's records — catalog projection,
  assessments from determinations, trap registry from assumption
  dispositions — filing nothing.
- The surface machinery matches the ruling: no per-kind enumerator
  commands, universal `reads` plus committed member lists,
  `surface-reconcile` rejecting the legacy schema loudly, `audit-check`
  validating the assumption corpus and the run report at close.
- The owner can drive both long runs hands-free: converge materializes
  `ceremony/audit-goal.md` and `ceremony/document-goal.md`, and the à la
  carte walk ends by handing the one-line `/goal` paste.
- The Determine stages have a worker-pool discipline
  (`{{WORKER-POOL-RULE}}`): spawn-feed-retire over cross-agent messaging,
  measured-context retirement at ~300k per-request (scaled to window),
  bounded batches as the fallback.
- The vocabulary is repaired suite-wide: the experiments (never
  "harness" for the collection), nomination (never "promotion" for an
  experiment entering the suites), surface reserved for the
  public-surface partition alone, ceremony contributions and
  administration files named as such.
- The conduct's ratified technical-writing channel now rides a released
  version: 1.12.0 (Lemur).

## Divergences

Beyond the work-log divergences recorded above (the superseded
pre-session edits; the calls listed under "Calls made where the sprint
was silent" — the dissolved cross-artifact-consistency pass, the
deferred `/ok` converge of the vendored ceremony skills, the
report-at-close firing shape, the Lemur release name, the re-keyed
ok-plumbline/ok-workspaces contributions, the dedicated assumption
auditor prompt), the fix cycle added:

- Corpus repairs (rules-determined, wording-only, for after-the-fact
  veto): `.ok-planner/design/decisions/suite-owned-ceremonies.md` —
  retired vocabulary replaced at five sites in Choice, Rationale, and
  Alternatives; `.ok-planner/design/concepts/estate.md` — "ceremony
  surfaces" → "ceremony contributions" in the What-it-is enumeration.
  No commitment changed in either; both verified compliant and coherent
  by the alignment judge's re-review.
- Fixer calls: three literal substitutions that would have doubled a
  noun were reworded minimally ("a contribution silent on a phase adds
  nothing"; "the contribution adds nothing"; "each present contribution
  declares at close-out"); differently-phrased uses of "surface" no rule
  names ("consumer surfaces", "user-customization surface", root
  README) were left; records under `history/` and `sprints/` untouched
  per the record discipline.

## Findings fixed

- Test suites: clean on first pass (all seven scripts exit 0, before
  and after the fix cycle).
- Mechanical floor (annotation integrity): clean on first pass — every
  annotation in the changed set resolves; the two grep artifacts
  (`@concept:foo`, "@story: for") are prose describing the form.
- Sprint alignment: 3 findings (vocabulary undershoot across six
  payload files; retired vocabulary standing in two live artifacts) —
  all fixed in one cycle; re-review clean, with a full-repo grep for
  the retired phrases returning zero hits.
- Code review: 4 findings (a dangling Sweep→Determine cross-reference;
  one materialized copy drifted from its canonical; residual
  unswept sites; a doubled noun from the literal substitution) — all
  fixed in one cycle; re-review clean, mirrors verified byte-identical
  modulo the documented rendering.

## Issues promoted

None. No kickbacks reached the architect, nothing was dissolved, and
the cap was never approached; the intake gained no files from this run.

## Work log

*(Kept current as stages land: what was done, divergences, calls made
where the sprint was silent.)*

- **Corpus deltas applied.** All 17 sidecar bodies copied verbatim into
  `design/concepts/` and `design/decisions/` (verified byte-identical),
  and the two catalog TOCs refreshed: seven summary lines changed
  (`documentation-corpus`, `surface-declaration`, `cold-boxed-synthesis`,
  `document-composes-audit`, `full-reassessment-per-release`,
  `owner-guided-surface-partition`, `steering-over-prose-lint`), the
  rest reproduced identically at the same 117-character truncation.

- **Audit ceremony body rewritten** (`plugins/ok/ceremonies/audit/SKILL.md`):
  orchestrator role at top, four determinations, twelve-step spine with
  no sweep stage, worker-pool section with the measured-context
  retirement rule, run-report stage, conditional presentation, goal
  handoff at the à la carte walk. Supersedes the ratified pre-session
  edits, whose substance (the files-nothing rule, observations reaching
  the owner outside the intake) is carried forward in the new form.
- **ok-planner audit contribution rewritten**
  (`plugins/ok/families/ok-planner/ceremony/audit.md`, mirrored to
  `.ok-planner/ceremony/audit.md`): new declaration schema (no
  enumerator commands, universal `reads` + member lists), agentic
  extraction protocol with pruning notations and candidate discovery
  at the walk, assumption synthesis (box construction + fixed
  synthesizer brief) and measurement, judge asymmetry, nomination
  distillation, run-report shape, close-out paths including
  `history/audits/`. Sweep section deleted.
- **Shared prompts updated**
  (`skills/_shared/implementation-auditor.md`, both copies): per-item
  feed mode beside batch mode, new `{{ASSUMPTION-AUDITOR-PROMPT}}`,
  judge rewritten for the four escalation kinds and the trap
  asymmetry, experiments/nomination vocabulary.
  `skills/_shared/dispatch-discipline.md` (both copies) gains
  `{{WORKER-POOL-RULE}}` (spawn-feed-retire, ~300k per-request
  retirement threshold scaled to window, liveness rule, batch
  fallback).

- **Document ceremony slimmed** (`plugins/ok/ceremonies/document/SKILL.md`
  and `plugins/ok/families/ok-planner/ceremony/document.md`, mirrored to
  `.ok-planner/ceremony/document.md`): the run constructs and measures
  nothing — Synthesize and the box moved out (the export-set specifics
  ported verbatim-in-substance into the audit contribution's box step),
  Assess became construction from the audit's records, the trap
  registry reads the assumption dispositions, filing dropped to none,
  and the wrap-up reads the audit's run report, covering both
  ceremonies when this run invoked the audit.

- **Surface machinery**: `surface-reconcile` rewritten to the new
  declaration schema (kinds carry `kind`/`reads`/`expectedEmpty` only;
  legacy `enumerate`/`derivation` fields rejected with an instructive
  error; populations read from committed member lists, missing or empty
  lists loud); `audit-check` gains the assumption corpus
  (`assumption-malformed` checks: shape, disposition vocabulary, slug
  match, no `issue:`, body present) and the run-report-at-close check
  (`report-missing`, firing only when every record in an estate agrees
  on one real short sha); vendored `bin/` copies refreshed.
- **Goal files** written at
  `plugins/ok/families/ok-planner/ceremony/{audit,document}-goal.md`,
  wired into converge (new `CEREMONY_FILES` covering diagnose and
  materialize loops), noted in `admin/ADMINISTRATION.md`, and
  materialized into `.ok-planner/ceremony/`.
- **Vocabulary sweep** across the payload, templates, contract doc,
  and materialized copies: "ceremony contribution" replaces "ceremony
  surface" (37 sites), "administration files"/"conventional
  contributions" replace "administration surfaces"/"conventional
  surfaces", the experiments replace "experiment harness"/"maintained
  harness", nomination replaces experiment "promotion". The estate
  CLAUDE.md and cheatsheet templates also had their surface, audit,
  and documentation sections brought to the new design (agentic
  extraction, assumptions in the audit, document-constructs, run
  report, goal handoff) — required to stop them contradicting the
  applied deltas — and the materialized copies were regenerated.
- **Conduct bumped** to 1.12.0 (Lemur) in
  `plugins/ok-conduct/output-styles/ok-conduct.md`; the session-start
  hook and `/ok-version` read the version from that line dynamically,
  so no other file carries it.

- **Suite tests updated and green** (all seven suites exit 0):
  `surface-reconcile.sh` rewritten to the member-list schema (legacy
  `enumerate`/`derivation` rejection cases added; enumerator and
  derivation-marker fixtures removed); `run.sh` gains the assumption
  corpus cases (clean three-disposition set, bad vocabulary, missing
  disposition, issue-link ban, slug mismatch, bodyless record) and the
  run-report cases (report-missing on a stamped corpus, silence on
  mixed mid-run stamps), with clean fixtures now carrying the report a
  stamped corpus requires; `administration.sh` asserts converge
  materializes both goal files and the audit goal file's one-line
  `/goal` paste; `document-check.sh` vocabulary aligned (experiments,
  not harness).
- **ok-plumbline and ok-workspaces audit contributions re-keyed to the
  new spine**: their `## Sweep`/`## Present` sections (hosted by
  stages that no longer exist) became `## Lint`/`## Determine` run
  with the Determine stage and `## Report` contributions to the run
  report, with judgment-class findings routed to the ceremony's judge
  and nothing "reported in-context" anymore.

## Divergences

- The uncommitted pre-session edits to the audit ceremony body and
  contribution (ratified at reconcile) were superseded wholesale by
  the sprint's rewrites, their substance carried forward as the sprint
  directs.

## Calls made where the sprint was silent

- **The cross-artifact-consistency pass died with the Sweep stage.**
  The sprint's spine names no sweep ("no step-8 sweep exists
  anywhere") and enumerates the judge's escalations without it, so the
  whole-corpus consistency check was removed along with the
  surface-inventory pass rather than rehosted. Contradictions between
  artifacts now surface only through the ordinary reading
  determinations and the extraction's corpus-contradiction escalation.
- **Vendored ceremony skills under `.claude/skills/` were not
  regenerated** (audit, document, certify-work, plan-sprint — still
  the v15.1.0 renderings, plus this sprint's vocabulary sweep where
  phrases matched). Refreshing them is converge's act and
  administration is always a user action: run `/ok` before the next
  `/audit` or `/document` so the vendored bodies match the canonical
  rewrites. The `_shared/` prompt files both ceremonies transclude
  were regenerated in place, as the earlier in-session ruling on the
  compliance reviewer established that precedent.
- **The report-at-close check fires on any estate whose audit records
  all agree on one real short sha.** An estate stamped by a pre-report
  audit run will show one `report-missing` finding until its next
  `/audit` — the same honest-state shape as `audit-missing` before a
  first run.
- **Conduct release name**: 1.12.0 needed a name after Koala; no
  recorded sequence exists beyond Koala, so the next letter's animal,
  Lemur, was chosen.
- **The other families' audit contributions** were re-keyed to the new
  spine (see the work log) though no work item named them: leaving
  sections keyed to a stage the ceremony no longer runs would have
  made the rewritten body unable to drive them — the
  unstated-but-necessary case.
- **Assumption measurement got its own prompt**
  (`{{ASSUMPTION-AUDITOR-PROMPT}}`): the contribution's Determine
  section needed a dispatchable instrument for assumptions, and
  bending the story auditor with a deviation list would have left the
  disposition semantics implicit.
