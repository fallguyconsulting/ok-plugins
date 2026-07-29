# Completion report: Ratify the inline certification repairs

Execution record for `2026-07-28-ratify-inline-certification-repairs.md`.
Kept current by the executor as stages land; finished by the closing
certification, which writes its presentation in below.

## Work done

- Staged the sprint into the harness task list: corpus deltas, the
  explain-lint-rules work item, and the closing ceremony entries
  (finish report, `/certify-work`, presentation walk,
  archive-and-commit offer) seeded up front.
- Applied all 9 corpus deltas verbatim (verified byte-identical to
  the sprint's fenced blocks by scripted diff): new
  `decision:inspection-registry`, new `concept:completion-report`,
  amended `decision:adversarial-implementation-audits`,
  `decision:two-layer-invalidation`, `decision:recorded-adjudication`,
  `concept:completion-contract`, `concept:sprint`, `concept:issue`,
  `story:certify-completion`. Refreshed the catalog TOCs: updated the
  `completion-contract` one-liner and added `completion-report`
  (concepts.md) and `inspection-registry` (decisions.md), matching
  the generator's 117-character truncation convention; stories.md
  needed no change (no amended story's opening 117 characters moved).

- Work item (explain-lint-rules): confirmed the standing decidable
  finding holds — the proof harness hard-coded each worked example's
  starting state while its conjunct messages claimed the inputs were
  read from the topic text. Corrected the harness
  (`plugins/ok/families/ok-plumbline/test/run.sh`): new block-scoped
  extraction helpers (`example_block`, `example_source_file`,
  `example_source_content`, `example_config_entry`) read each
  example's source file, source content, and config entry out of the
  example's own block at run time, and all three fixtures are built
  from what was read, failing closed on any empty extraction.
  Verified both directions: the full harness runs green in-repo, and
  on a sandbox copy the audit's previously-green input mutations
  (offending comment → exempt SPDX directive; `file_template`
  retargeted; glob changed) now each fail the conjuncts that read
  those inputs. The re-audit that re-resolves the determination is
  certification's.

## Divergences

(none — deltas applied verbatim; the one work item executed as
directed)

## Calls made where the sprint was silent

- Catalog TOC refresh: the sprint said nothing about the TOC files;
  followed the generator's observed convention (alphabetical entry,
  first body paragraph hard-truncated at 117 characters).
- Harness fix shape: chose in-place extraction helpers in the same
  awk/sed idiom the harness already uses, and refactored
  `example_config_path` / `example_reported_line` onto the shared
  `example_block` helper (mechanical deduplication, no behavior
  change).
- Fix-side inputs (each example's stated remediations) remain
  hard-coded: the standing audit records that as an honest limit
  under the Proof field's wording, not part of the finding, and the
  sprint directs only the starting-state correction.

---

# Certification — Ratify the inline certification repairs

Status: certified clean

## Outcomes delivered

- The design corpus now carries the twelve promoted issues'
  ratifications: all nine deltas applied byte-verbatim (verified by
  the alignment judge on both passes) — the inspection-registry
  decision, the completion-report concept, the
  implemented-and-covered audit charter, the two-layer invalidation
  with its mechanical closure floor, recorded adjudication with the
  registry, the repository-verifiable completion contract with its
  goal rule, the sprint/report pairing, the issue intent-altitude
  invariants, and the certify-completion story's amended acceptance.
- `story:explain-lint-rules` — the standing violated determination is
  resolved: the proof harness now reads each worked example's
  starting state out of the lint's own topic text and builds the
  fixtures from what it read; the re-audit (sixth pass) confirmed the
  recorded flip condition met and flipped the determination to
  satisfied. The intake's one unlinked violation is gone.
- `story:certify-completion` — its proof grew to the amended
  acceptance: the cycle cap's exactly-two steps, the presentation
  written into the completion report, archival paired with the
  report, and the `--inspection` closure floor are each exhibited by
  deterministic conjuncts; determination satisfied.
- `decision:two-layer-invalidation` and `decision:inspection-registry`
  — the certification run itself surfaced that the shipped closure
  floor covered a strict subset of the ratified sentence (bytes
  outside every declared unit escaped disposition when a unit also
  moved; a commit-range subject got no floor). The floor now hashes
  and compares the outside-unit remainder and threads a base ref
  (`--inspection[=<base>]`); nine fixtures hold it, including the
  vacuous-clean case the decisions foreclose. Both flipped to
  satisfied.
- `decision:prove-audit-audience-split` — reconciled to the two-path
  intake model the sprint ratified elsewhere; satisfied.
- The whole audit corpus is current: `audit-check` exits 0 (no stale
  citations, no missing audits, no unlinked violations),
  `audit-check --inspection` exits 0 (every changed node
  dispositioned), `source-graph check` exits 0, and both proof
  harnesses run clean through the timing recorder.

## Divergences

Every call made in the owner's absence, named for after-the-fact
veto:

- **Corpus repair — `decision:prove-audit-audience-split` rewritten**
  (title, one Choice clause, one Rationale sentence, one added
  Alternative) from "exactly one gated agent writer" to the two
  gated intake paths (architect's confirmed forks + the cycle cap's
  escalation). The sprint carried no delta for this decision; the
  fixer judged the old sentence a stale expression of the cap design
  the owner ratified through the promoted issue ruling and this
  sprint's certify-completion delta, and the alignment judge
  confirmed the repair legal and coherent. This is the most
  veto-worthy call of the run.
- **Corpus repair — `concept:finding`** Boundaries sentence aligned
  to the same two-path model.
- **Vendored layer deliberately not synced.** The fixes to the
  closure floor live in the family source under `plugins/`; the
  project's pinned `.ok-planner/bin/audit-check` keeps the v11.2.0
  floor until the next release/converge, per the vendored-layer
  discipline (`checks/vendored-layer` green). The widened floor was
  verified to surface nothing new on this tree under either copy.
- **Floor implementation shape**: unit spans are not recorded in the
  committed graph, so the floor loads the sibling `source-graph`
  extractor to compute the outside-unit region, failing conservative
  (over-flag, never go blind) when it cannot.
- **Issue receipts recategorized** (frontmatter only): eight promoted
  issue files carried ad-hoc `category:` values; mapped to the
  canonical taxonomy (unspecified / conflicting / inconsistent).
- **`checks/hub-rows` repaired** though not in any finding list —
  same defect class as the repointed `checks/text-presence` needles
  (pre-v11.2.0 wording), found red at session start.
- **Latent fixture bug fixed**: the ok-planner harness's
  truncate-before-read fixture edits (`open(p,"w").write(open(p)...`)
  emptied files instead of editing them, which had masked the floor
  gap; replaced with a read-first helper that fails loudly.
- Executor-side calls recorded earlier in this report (TOC
  truncation convention; extraction-helper shape; fix-side inputs
  left as the audit's recorded honest limit) stand as written.

## Findings fixed

- Sprint alignment: clean on both passes; mid-cycle corpus repairs
  verified legal.
- Prove: 5 failing verdicts fixed — certify-completion's stale
  undershoot tripwire (re-pinned at both ends of the dispatch),
  plan-a-sprint's three failures (completion report mistaken for a
  sprint — globs now filter `-completion.md`), bootstrap's category
  finding. Both harnesses clean.
- Implementation audit: 28 audits written or refreshed across five
  dispatched batches; 4 violated determinations raised adversarially
  mid-run and all 4 driven to satisfied by code/corpus fixes — none
  softened, none waved through; 0 violations standing.
- Code review: 3 findings fixed (fail-closed diagnostics naming only
  a subset of their guards; the combined unit+outside-unit floor gap;
  a cheatsheet rewrap slip).
- Mechanical floor: clean both passes (annotations resolve, both
  touched stories carry annotated proofs).
- Cycle count: two fixer cycles, no kickbacks, no dissolutions — the
  architect seat was never needed, and the cap was never reached.

## Reconciliation ledger

- Mechanical: every changed source node not below was accounted by
  the re-audit set — 28 audits re-derived or refreshed against the
  tree as it stands.
- Adjudicated: 16 live registry entries — each changed node judged
  into the territory of an audit that read exactly those bytes this
  run (the floor code → two-layer-invalidation; the two-path wording
  → prove-audit-audience-split; the shared prompt blocks →
  adversarial-implementation-audits; the harnesses →
  certify-completion / explain-lint-rules; the estate templates →
  their owning decisions).
- Residue: 1 entry, reported here as intake material and never
  dropped — the front-door hub's `/certify-work` row description
  resync (`skills/ok-planner/SKILL.md`, the verb table): no audit
  claims the router's per-verb summary table as territory.
- No hunk is without a disposition; `audit-check --inspection`
  exits 0.

## Referrals

- The presentation being *walked* with the owner (not merely written
  to a file): delivered in form — the gate's two-step presentation
  (composed into this report, then walked in session) — with
  suitability of any given walk owned by human review
  (`story:certify-completion`'s audit).
- The explain-lint-rules qualitative rim (canonical definitions, the
  explanation matching the lint in substance) remains referred to
  the documentation discipline per its audit's standing record.

## Issues promoted

None. No finding reached the intake this run: the fixer kicked
nothing back, so the architect never sat, and the fix loop closed in
two cycles without touching the cap. The twelve `promoted` issue
receipts in the intake belong to this sprint and move to
`history/issues/` at close-out.

---

The close-out offer: archive this sprint together with this
completion report and the twelve promoted issue receipts to
`.ok-planner/history/`, and commit the work — both performed only on
the owner's word; the close-out then stamps the archived sprint with
the closing commit (`closed: <sha>`), the baseline the next planning
ceremony reads.

---

# Post-certification amendment and owner-directed close

After the certification above came back clean, the owner amended the
sprint in flight (issue `cap-decision-reserved-to-owner`, promoted
2026-07-29): the fix loop's cycle cap must always stop and wait for
the owner's word — the unattended-escalation default is removed, and
the goal rule gains the parked-at-the-cap state as a legal in-flight
condition.

**Delivered and verified:** the three amended deltas applied
byte-verbatim (story:certify-completion, concept:completion-contract,
decision:prove-audit-audience-split); the default removed from the
certification core's exit rule and intake-paths paragraph, both
gates' cap touchpoints and close-outs, the planning template's goal
rule, and the estate template; certify-all's "on an interactive run
only" overview parenthetical — the one surviving contradiction,
caught by re-audit — fixed; the proof tripwires repointed to the new
governing sentences and reading BOTH gates. All suites green
(`proofs.sh` 0 FAIL, `run.sh` 0 FAIL, `checks/run` clean,
`source-graph check` clean); no shipped family text instructs any
cap step without the owner's word.

**Closed by owner direction over a non-clean gate.** The owner
stopped the in-flight auditor dispatches and directed
archive-and-commit before the re-certification bookkeeping finished.
Standing at close: the audits of `story:certify-completion` and
`decision:prove-audit-audience-split` read `violated` on the
certify-all sentence that has since been fixed — the re-read that
would flip them was stopped before it wrote — and fourteen audits
carry stale citations (whole-file pins on the shared proof harness
and on certify-all, moved by the amendment's edits). The next
whole-corpus certification (`/certify-all`) or any later
change-scoped run will re-derive them; the code they judge is
believed correct per the verification above.

**Owner observations recorded at close, unfiled by direction:**
whole-file pins on a shared multi-story proof harness give staleness
a file-granular blast radius (eleven unrelated audits re-staled by a
cap-conjunct edit); the certification process's cost in time and
tokens — three fixer cycles, five auditor batches, repeated
refresh sweeps within one close — is, in the owner's words, a
debacle, and sprints in this shape are too expensive to continue
paying for. Both are candidate intake material for whatever process
change comes next; the owner declined to file them as issues at
this time.

**Vendored layer:** pinned at v11.2.0 throughout, per the
vendored-layer discipline; the family source carries all repairs and
re-vendors at the next release/converge.
