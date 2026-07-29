---
audit: bootstrap-design-corpus
artifact: story:bootstrap-design-corpus
determination: satisfied
audited: 2026-07-28T18:00:00Z
artifact-hash: sha256:e818a09887a8
---

# Does the corpus bootstrap run end to end on an empty corpus, leave populated catalogs, regenerated TOCs, open issue files and one report — and abort on populated catalogs?

The design artifact's hash is unchanged since the prior audit, so its
determinations bind where their cited reality still stands. This cycle's
sprint touched three things in this claim's territory rather than one:
the converge core's `SKILLS` map gained a `browse` entry (the new corpus
view's verb), `test/proofs.sh` gained per-proof timing instrumentation
plus a new `trace-corpus-to-code` block, and the design corpus itself
grew (three new stories, four new decisions, several closed issues
replaced by new ones). None of the three touches what this story's
claims rest on — `discover-design` is still in the `SKILLS` map, the
`bootstrap-design-corpus` harness block is untouched, and the catalogs
are still populated and TOC-matched — so this is an amend: the touched
counts and citations are re-derived below, the rest carried.

## Claims

**Title + Story — "the as-is design model extracted autonomously into durable
catalogs plus a queue of judgment questions, so that my design attention is
spent resolving genuine ambiguities instead of writing documentation from
scratch."** Honored. The verb exists as a single skill whose own description
states it is an autonomous two-phase bootstrap producing the three catalogs and
filing judgment questions to the intake, aborting rather than overwriting
human-edited artifacts. It is in the converge core's `SKILLS` map — re-checked
this cycle against the current map, which gained an unrelated `browse` entry
(the corpus view's verb) but still carries `discover-design` — so a consumer
project actually has it rather than only the payload having it.

**Acceptance conjunct 1 — "the run completes end-to-end without
interruption."** Prompt-realized, and stated at three separate points: up front
("Runs end-to-end without user interruption"), at the close of the process
("The skill does not prompt the user mid-run. The final report is the only
thing the user sees during this skill's execution"), and in the "What this
skill does NOT do" list. Read against the numbered procedure rather than the
prose: there is no consent gate, no confirmation step, and no question anywhere
in steps 1–8. Honored as presence; a live run's silence is not deterministically
observable.

**Acceptance conjunct 2 — "leaving populated concept, story, and decision
catalogs describing the project as it is."** Phase 2's extractor writes one
file per load-bearing noun, per user-observable outcome, and per technical
choice, under the three catalog directories, and is bound to as-is output ("Do
NOT invent stories the product does not yet deliver … Document the as-is"),
with the extraction reviewer independently enforcing "As-is, not aspirational"
on all three kinds. Exercised on this project's own estate: the harness counts
the files on disk per kind and finds all three catalogs non-empty — 27 concepts,
20 stories, 26 decisions on the current tree (up from 27/17/22 last cycle: this
sprint's own corpus deltas added stories and decisions, which is the catalogs
growing by ordinary sprint work, not a bootstrap-run artifact — re-counted
directly against `ls .ok-planner/design/{concepts,stories,decisions}/*.md`
rather than carried). Honored.

**Acceptance conjunct 3 — "regenerated tables of contents."** Step 7
regenerates `concepts.md`, `stories.md`, and `decisions.md` by reading every
file in each directory, with a fixed entry format and a stated per-kind
summary source. The harness verifies the property that matters — for each kind,
the TOC lists exactly the number of files present — computed at run time rather
than pinned; all three assertions pass on the enlarged catalogs. I additionally
checked the stronger property the harness does not assert: for each kind, the
TOC's slug *set* equals the on-disk basename set, not merely its cardinality.
Honored.

**Acceptance conjunct 4 — "judgment questions filed as open issue files in the
intake."** The skill files judgment questions as issue files under
`.ok-planner/issues/` with `kind: "discover"` and `status: open` at every
filing point — the phase 1 cap (4d), the phase 2 extractor (5a), the phase 2
cap (5d), the reviewer's final-pass uncertainty filing (5b), and the back-edge
(6b, 6c) — and states that verification and closure belong to other verbs. The
"judgment" qualifier is not left to the filer's taste: the extractor's own
prompt transcludes `{{ISSUE-DEFINITION}}` under its "What is an issue?" heading,
whose canonical body carries the nine-category taxonomy and the rule "Only
judgment items become issues." Honored.

**Acceptance conjunct 5 — "and a single final report."** Step 8 defines one
final report with a fixed content list (scaffold count, per-kind counts, issues
by category, whether a back-edge ran, the next-step pointer), and the skill
states it is the only thing the user sees during execution. Prompt-realized;
honored as presence.

**Acceptance conjunct 6 — "The two-phase discovery-and-extraction pipeline with
its produce–review–fix loops is real, not stubbed."** Both phases are fully
specified dispatches: phase 1 discoverer + discovery reviewer, phase 2
extractor + extraction reviewer, each with an explicit
producer → reviewer → producer-with-feedback loop capped at three cycles, plus
a one-shot back-edge with its own focused discoverer, focused extractor, and
re-review. Every dispatch prompt is present in full — goal, inputs, transcluded
rule tokens, templates, anti-padding, report format — and none is a
placeholder. The pipeline's output on this project is independently visible:
the harness confirms a 48-entry `_discover/` scaffold stands behind the
populated catalogs, which is what a real phase 1 leaves. Honored.

**Acceptance conjunct 7 — "On a project with non-empty durable catalogs the run
aborts rather than risk overwriting human-approved content."** The guard is
stated at step 3, restated under re-run discipline, and again in the not-doing
list. The harness evaluates the guard's predicate deterministically over two
fixtures — an empty corpus returns `proceed`, the same corpus with one concept
file returns `abort` — and then asserts that the refusal it models is the
skill's own stated guard sentence, so a reworded or deleted guard turns the
assertion red. Honored.

**Falsifier — "catalogs empty, generic, or untraceable; aspirational
inventions; the run stalls mid-way; a re-run silently overwrites human-edited
artifacts."** None obtains: the catalogs are populated and traceable to a
present `_discover/` scaffold with TOCs matching disk (by set, not just count);
the extractor and both reviewers forbid aspirational artifacts explicitly; no
mid-run prompt exists anywhere in the procedure; and the abort guard is
exercised over both corpus states.

**Proof-field span.** The Proof names a demo with three third-party
observables.

- *Traceability* — covered structurally (a discovery scaffold behind the
  catalogs, TOC/disk agreement per kind) rather than artifact by artifact;
  tracing a concept's body to a code fact is an agentic read.
- *The refusal* — covered properly, over both fixture states plus the skill's
  own guard sentence.
- *"Sees only judgment items in the queue"* — exercised in three parts, with
  the agentic half named at the assertion as the convention requires. The
  deterministic residue is: the extractor prompt still transcludes the canonical
  issue definition, that definition still says "Only judgment items become
  issues.", and every issue file this project's intake and archive hold declares
  a `category:` drawn from that block's own taxonomy (54 issues against the
  9-category taxonomy — up from 50, re-counted directly this cycle — none
  outside it). Judged rather than
  rubber-stamped: this is a proxy, not the observable. A declared category is
  necessary but not sufficient for judgment-ness — an item filed as `other` could
  be mechanical debris and would still pass — and the population is this
  project's whole accumulated queue, filed by several verbs and by humans, not
  the output of one bootstrap run. What the assertion genuinely buys is that the
  taxonomy is live, the filing rule is still in force at the filing site, and
  nothing in the queue sits outside the judgment vocabulary. The residue is
  honest and named; it is not a demonstration of a bootstrap run's queue.

Refreshed again this pass: `test/proofs.sh`'s whole-file pin moved once more
(unrelated conjunct growth elsewhere in the file); all four spans this audit
cites inside it are byte-identical and none re-flagged stale. Citation
regenerated; nothing else touched.

Re-run this cycle against the current bytes: every `bootstrap-design-corpus`
assertion passes and the harness exits 0 (seventy-five assertions across ten
live stories now that `trace-corpus-to-code` joined the file, ten of the
seventy-five still this story's — the same count as before). All four cited
harness blocks are byte-identical to the ones the prior audit cited — their
span hashes are unchanged — so this cycle's harness edits (per-proof timing
instrumentation wrapped around every existing assertion, plus the new
`trace-corpus-to-code` block) touched none of them; only the file's whole-file
pin moved.

Refreshed once more this cycle: `test/proofs.sh`'s whole-file pin moved again
from the owner-ratified cap-rewording exhibitions added to the
`certify-completion` story's section elsewhere in the file. All four spans
this audit cites inside it — `bootstrap_state()`, the queue-conjunct spans,
the scaffold-count line — are byte-identical and none re-flagged stale.
Citation regenerated; nothing else touched.

## Determination

**satisfied.** Every conjunct of the Acceptance has a citable enforcement point
in the skill, and the deterministic ones are exercised against reality: the
abort guard over both corpus states with its governing sentence pinned, the
produced estate's traceability, the agreement of each catalog's table of
contents with the files on disk (verified this cycle by slug set as well as by
count), and the queue's conformance to the canonical judgment taxonomy. The
conjuncts that are inherently prompt-realized — the uninterrupted run and the
single final report — are stated in the skill's own governing text at three
points each and are contradicted by nothing in the numbered procedure. The
two-phase pipeline is fully specified with real review-fix loops and a
back-edge, not stubbed, and this repository's own corpus is the standing
artifact of a real run.

Re-derived, not carried: this audit went stale for three reasons this
cycle, none of them touching what the claims rest on — the `SKILLS` map
in `admin/converge` gained a `browse` entry (the span this audit cites to
confirm `discover-design`'s presence grew by one line), the whole-file
pin on `test/proofs.sh` moved (timing instrumentation plus a new story's
block), and the catalog-summary pins on `stories.md` and `decisions.md`
moved because this sprint's own corpus deltas added entries. Each was
checked directly rather than assumed: the four harness blocks this audit
rests on are unchanged byte-for-byte, `discover-design` is still a member
of the `SKILLS` map, the catalogs still match their TOCs exactly — now
27/20/26, by slug set as well as by count — the scaffold still stands at
48 entries, and the queue still declares only taxonomy categories (54
issues against 9, up from 50). The bootstrap skill itself was untouched
this cycle; its whole-file pin still verifies.

The remaining weakness, non-determinative and unchanged from the last cycle:
the queue observable is exercised by a proxy over a superset population rather
than demonstrated from a bootstrap run, and the transclusion assertion is a
whole-file grep for the token, which the skill's own token inventory list (a
second occurrence, at its "Tokens used in this skill's dispatches" list) would
also satisfy — the real transclusion sits in the phase 2 extractor prompt under
its "What is an issue?" heading and was confirmed here by reading, not by the
grep.

This stops holding if: the abort guard sentence is reworded or removed (the
harness asserts it verbatim and the `cite-span` over step 3 breaks); the TOC
regeneration step is dropped or stops enumerating from disk; a review-fix loop
or a phase dispatch becomes a placeholder; the extractor prompt stops
transcluding `{{ISSUE-DEFINITION}}`, or that block stops restricting the queue
to judgment items; the skill acquires a mid-run consent prompt or a second
user-visible report; issue filing moves off the file-per-issue intake, or issue
files stop carrying a `category:` from the canonical taxonomy; or
`discover-design` leaves the converge `SKILLS` map, making the verb unreachable
in a consumer project. It would also stop holding if the catalogs on this
project were emptied — the TOC-versus-disk assertion is computed at run time,
not pinned.

## Citations

- cite: plugins/ok/families/ok-planner/skills/discover-design/SKILL.md :: "Runs end-to-end without user interruption"
- cite: plugins/ok/families/ok-planner/skills/discover-design/SKILL.md :: "The skill does not prompt the user mid-run"
- cite: plugins/ok/families/ok-planner/skills/discover-design/SKILL.md :: "are filed as issue files under"
- cite: plugins/ok/families/ok-planner/skills/discover-design/SKILL.md :: "producer → reviewer → (if not approved) producer-with-feedback →"
- cite-span: plugins/ok/families/ok-planner/skills/discover-design/SKILL.md :: "Non-empty `concepts/`, `stories/`, or `decisions/` → abort." +5 sha256:6a9fe916b98e
- cite-span: plugins/ok/families/ok-planner/skills/discover-design/SKILL.md :: "a. Dispatch the extractor subagent with the Phase 2 Extractor" +5 sha256:951bbf9bca0f
- cite-span: plugins/ok/families/ok-planner/skills/discover-design/SKILL.md :: "7. **Regenerate the design catalog summaries.** For each of" +4 sha256:e294acca34b5
- cite: plugins/ok/families/ok-planner/skills/discover-design/SKILL.md :: "8. Final report to the user: number of"
- cite-span: plugins/ok/families/ok-planner/skills/discover-design/SKILL.md :: "### What is an issue?" +3 sha256:76e45281a83c
- cite: plugins/ok/families/ok-planner/skills/_shared/artifact-definitions.md :: "**Only judgment items become issues.**"
- cite-span: plugins/ok/families/ok-planner/admin/converge :: "SKILLS = {" +13 sha256:19e4a08de7f5
- cite: plugins/ok/families/ok-planner/test/proofs.sh :: "# @story: bootstrap-design-corpus"
- cite-span: plugins/ok/families/ok-planner/test/proofs.sh :: "bootstrap_state() {" +9 sha256:dd3cad0559a7
- cite: plugins/ok/families/ok-planner/test/proofs.sh :: "bootstrap-design-corpus: the refusal the harness models is the skill"
- cite-span: plugins/ok/families/ok-planner/test/proofs.sh :: "# The queue conjunct — "sees only judgment items in the queue". The" +7 sha256:e08a384c4b50
- cite-span: plugins/ok/families/ok-planner/test/proofs.sh :: "queue_report=$(python3 - "$family/skills/_shared/artifact-definitions.md" "$suite_repo/.ok-planner" <<'PY'" +18 sha256:442d443c3479
- cite: plugins/ok/families/ok-planner/test/proofs.sh :: "scaffold=$(ls -1"
- cite-span: plugins/ok/families/ok-planner/test/proofs.sh :: "listed=$(grep -cE" +6 sha256:7ec53d1edffc
- cite-node: plugins/ok/families/ok-planner/skills/discover-design/SKILL.md @ sha256:80c8c02787b4
- cite-node: plugins/ok/families/ok-planner/test/proofs.sh @ sha256:10f3b1e855fd
- cite-file: .ok-planner/design/concepts.md @ sha256:66af22161c14
- cite-file: .ok-planner/design/stories.md @ sha256:fb109645b6d9
- cite-file: .ok-planner/design/decisions.md @ sha256:457a9c1af13a
