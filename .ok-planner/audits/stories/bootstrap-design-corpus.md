---
audit: bootstrap-design-corpus
artifact: story:bootstrap-design-corpus
determination: satisfied
audited: 2026-07-27T13:35:00Z
artifact-hash: sha256:e818a09887a8
---

# Does the corpus bootstrap run end to end on an empty corpus, leave populated catalogs, regenerated TOCs, open issue files and one report — and abort on populated catalogs?

## Claims

**Title + Story — "the as-is design model extracted autonomously into durable
catalogs plus a queue of judgment questions."** The verb exists as a single
skill whose own description states it is an autonomous two-phase bootstrap
producing the three catalogs and filing judgment questions to the intake,
aborting rather than overwriting human-edited artifacts. Honored.

**Acceptance conjunct 1 — "the run completes end-to-end without
interruption."** Prompt-realized: the skill states it up front ("Runs
end-to-end without user interruption") and again at the close of its process
("The skill does not prompt the user mid-run"), and its "What this skill does
NOT do" repeats it. There is no consent gate anywhere in the numbered
procedure. Honored as presence; a live run's silence is not deterministically
observable, and the harness names this class explicitly in its header note
about prompt-realized conjuncts.

**Acceptance conjunct 2 — "leaving populated concept, story, and decision
catalogs describing the project as it is."** Phase 2's extractor writes one
file per load-bearing noun, per user-observable outcome, and per technical
choice, under the three catalog directories, and is bound to as-is output ("Do
NOT invent stories the product does not yet deliver … Document the as-is").
Exercised on this project's own estate: the harness counts the files on disk
per kind and finds all three catalogs non-empty (26 concepts, 16 stories, 20
decisions at the time of this audit). Honored.

**Acceptance conjunct 3 — "regenerated tables of contents."** Step 7 regenerates
`concepts.md`, `stories.md`, and `decisions.md` from the files on disk with a
fixed entry format. The harness verifies the property that matters — for each
kind, the TOC lists exactly the number of files present — and fails otherwise;
all three assertions pass. Honored.

**Acceptance conjunct 4 — "judgment questions filed as open issue files in the
intake."** The skill files judgment questions as issue files under
`.ok-planner/issues/` with `kind: "discover"` and `status: open` at every
filing point (phase 1 cap, phase 2 extractor, phase 2 reviewer's final-pass
uncertainty, back-edge), and states that verification and closure belong to
other verbs. The repaired Acceptance wording ("open issue files in the intake")
matches the file-per-issue intake the skill actually writes. Honored.

**Acceptance conjunct 5 — "and a single final report."** Step 8 defines one
final report with a fixed content list, and the skill states the final report
is the only thing the user sees during execution. Prompt-realized; honored as
presence.

**Acceptance conjunct 6 — "The two-phase discovery-and-extraction pipeline with
its produce–review–fix loops is real, not stubbed."** Both phases are fully
specified dispatches: phase 1 discoverer + discovery reviewer, phase 2
extractor + extraction reviewer, each with an explicit
producer → reviewer → producer-with-feedback loop capped at three cycles, plus
a one-shot back-edge with its own focused discoverer, focused extractor, and
re-review. Every dispatch prompt is present in full with its transcluded rule
tokens; none is a placeholder. The pipeline's output on this project is
independently visible: the harness confirms a 48-entry `_discover/` scaffold
stands behind the populated catalogs, which is what a real phase 1 leaves.
Honored.

**Acceptance conjunct 7 — "On a project with non-empty durable catalogs the run
aborts rather than risk overwriting human-approved content."** The guard is
stated at step 3 and restated under re-run discipline and in the not-doing
list. The harness evaluates the guard's predicate deterministically over two
fixtures — an empty corpus returns `proceed`, and the same corpus with one
concept file returns `abort` — and then asserts that the refusal it models is
the skill's own stated guard sentence, so a reworded or deleted guard turns the
assertion red. Honored.

**Falsifier — "catalogs empty, generic, or untraceable; aspirational
inventions; the run stalls mid-way; a re-run silently overwrites human-edited
artifacts."** None obtains: the catalogs are populated and traceable to a
present `_discover/` scaffold with TOCs matching disk; the extractor and both
reviewers forbid aspirational artifacts explicitly; no mid-run prompt exists;
and the abort guard is exercised.

**Proof-field span.** The Proof names a demo whose third-party observables are
traceability, judgment-only queue content, and a second invocation refusing to
write. The harness covers traceability (scaffold behind catalogs, TOC/disk
agreement) and the refusal (predicate over both fixture states plus the skill's
own guard sentence). The queue-content observable is covered elsewhere in the
same harness only indirectly, through the ceremony fold over this project's
intake; it is not asserted as "judgment items only" here.

## Determination

**Satisfied.** Every deterministic conjunct of the Acceptance is exercised
against reality: the abort guard over both corpus states, the produced estate's
traceability, and the exact agreement of each catalog's table of contents with
the files on disk. The conjuncts that are inherently prompt-realized — the
uninterrupted run and the single final report — are stated in the skill's own
governing text at three points, and the harness declares that convention in its
header. The two-phase pipeline is fully specified with real review-fix loops
and a back-edge, not stubbed, and this repo's own corpus is the standing
artifact of a real run.

This stops holding if: the abort guard sentence is reworded or removed (the
harness asserts it verbatim and the `cite-span` over step 3 breaks); the TOC
regeneration step is dropped or stops enumerating from disk; a review-fix loop
or a phase dispatch becomes a placeholder; the skill acquires a mid-run consent
prompt or a second user-visible report; or issue filing moves off the
file-per-issue intake. It would also stop holding if the catalogs on this
project were emptied — the harness's TOC-versus-disk assertion is computed at
run time, not pinned.

## Citations

- cite: plugins/ok/families/ok-planner/skills/discover-design/SKILL.md :: "Runs end-to-end without user interruption"
- cite: plugins/ok/families/ok-planner/skills/discover-design/SKILL.md :: "The skill does not prompt the user mid-run"
- cite: plugins/ok/families/ok-planner/skills/discover-design/SKILL.md :: "are filed as issue files under"
- cite: plugins/ok/families/ok-planner/skills/discover-design/SKILL.md :: "producer → reviewer → (if not approved) producer-with-feedback →"
- cite-span: plugins/ok/families/ok-planner/skills/discover-design/SKILL.md :: "Non-empty `concepts/`, `stories/`, or `decisions/` → abort." +5 sha256:6a9fe916b98e
- cite: plugins/ok/families/ok-planner/skills/discover-design/SKILL.md :: "Regenerate the design catalog summaries"
- cite: plugins/ok/families/ok-planner/skills/discover-design/SKILL.md :: "8. Final report to the user: number of"
- cite: plugins/ok/families/ok-planner/test/proofs.sh :: "# @story: bootstrap-design-corpus"
- cite-span: plugins/ok/families/ok-planner/test/proofs.sh :: "bootstrap_state() {" +9 sha256:dd3cad0559a7
- cite: plugins/ok/families/ok-planner/test/proofs.sh :: "bootstrap-design-corpus: the refusal the harness models is the skill"
- cite: plugins/ok/families/ok-planner/test/proofs.sh :: "scaffold=$(ls -1"
- cite-span: plugins/ok/families/ok-planner/test/proofs.sh :: "listed=$(grep -cE" +6 sha256:7ec53d1edffc
