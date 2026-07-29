---
audit: plan-a-sprint
artifact: story:plan-a-sprint
determination: satisfied
audited: 2026-07-28T22:40:00Z
artifact-hash: sha256:953bb8b3dc5d
---

# Does the planning ceremony turn goals, bearing issues, and unreconciled work into a signed-off, self-sufficient sprint?

## Claims

**Title / Story — "an interactive ceremony that turns my goals — and the open
design questions and unreconciled work that bear on them — into a signed-off,
self-sufficient sprint, so that any executor can realize my intent without
re-deriving it or deciding my open questions for me."** Honored. The ceremony
is interactive by construction (framing dialogue, out-of-band walk, issue walk,
sign-off), and self-sufficiency is not left as an aspiration: it is stated as a
property of the produced artifact and enforced by what the artifact must
contain.

**Acceptance 1 — "work done since the last close is detected against the
close's recorded baseline."** Honored: the baseline is the `closed:` stamp of
the newest archived sprint carrying one, the window is `git log <closed>..HEAD`
plus the uncommitted tree, and an absent stamp is an explicit one-question ask
rather than a guess. The counterpart end of the mechanism is real and exercised
— the certify gates stamp `closed: <sha>` at archival, and the harness resolves
the newest stamp against a real commit — so the baseline the ceremony reads is
written by something.

**Acceptance 2 — "filtered to what bears on the corpus's commitments."**
Honored by a dedicated dispatched reviewer with a stated four-part test
(contradicts a commitment; retires, replaces or bypasses a named mechanism;
adds load-bearing structure the corpus is silent on; edits `design/` directly)
and a fixed tiebreak toward BEARING. Only what it returns as BEARING is walked,
and the ambient remainder is explicitly not listed.

**Acceptance 3 — "reconciled with the owner up front — the corpus catching up,
the code catching up, or the question deferred to the intake, each an owner
call."** Honored: exactly those three outcomes, walked one change at a time,
positioned before the intake dialogue builds on them, with the deferral filed
as an issue so the question is held by the intake rather than by memory, and
with the sprint barred from otherwise touching the artifacts a deferred
divergence bears on.

**Acceptance 4 — "the dialogue surfaces every tradeoff explicitly."** Honored,
as a prohibition rather than an exhortation: "surface every tradeoff explicitly
— never resolve one silently on the owner's behalf", with the proof-protection
dialogue gate named for the case where a delta implies a story- or
decision-intent change (preserve / shift / remove, the owner picks).

**Acceptance 5 — "on feature work a draft is produced first and only the open
issues that bear on it are walked, one at a time, with the corpus artifacts
relevant to each surfaced and read before presenting."** Honored in that order.
The feature-work branch routes §2 → §3 and consults the unruled issues only at
§4; the relevance pass runs over the §3 draft and the unruled open issues only;
the walk is "one at a time (never as a wall)"; and each issue is preceded by
running the materialized corpus surfacer and reading what it prints in full,
with an empty result treated as its own signal to flag rather than proceed
blind.

**Acceptance 6 — "each walked issue ends in the owner's promote-or-retire
call."** Honored: exactly two outcomes, both owner acts, with the retirement
recorded on the spot (reason, `status: retired`, moved to `history/issues/`)
and the promotion carried into the sprint in final form.

**Acceptance 7 — "the draft passes compliance review."** Honored: the shared
compliance reviewer dispatched in draft mode scoped to the deltas plus the live
artifacts they amend, mechanical findings fixed in the draft, judgment findings
walked with the owner, re-dispatched until clean. The reviewer is the same
prompt body the whole-corpus audit uses, so draft-time and corpus-time review
cannot drift.

**Acceptance 8 — "after sign-off a sprint document exists containing final-form
corpus deltas, flat work items, and the verbatim execution and completion
boilerplate, with promotions recorded only once the approved sprint exists."**
Honored on all four counts. The template requires final-form artifact bodies
("No summarized or partial deltas — if the artifact changes, its full new body
appears here"); the work items are specified as "a flat, unordered list" with
staging explicitly deferred to execution and imposed order forbidden; both
boilerplate sections are declared fixed and required verbatim in every sprint;
and the promotion timing is stated with its rationale — retirements during the
walk, `promoted` stamps at §6 after sign-off, because stamping mid-walk would
empty the intake into a document the owner might still reject.

**Acceptance 9 — "The ceremony, its reviewers, and the compliance reviewer are
real components."** Honored: three dispatched reviewers with full prompts
(out-of-band, relevance, compliance — the last transcluded from the shared
file), plus the `surface-corpus` helper the walk invokes, which the converge
core materializes into each project's estate rather than leaving in the
payload.

**Falsifier.** Each condition has its counterpart. Non-self-sufficiency: "An
executing agent never reads an issue file to find out what a promoted issue
'really meant' — if a resolution's substance is not in the deltas or the work
items, it is not in the sprint." Issues terminated without the owner: the
NOT-do list's "Does not close issues without the owner". Promotions before
sign-off: the §6 timing rule. Building over a bearing open issue: the relevance
gate with its BEARS tiebreak and its stated justification. Work landing outside
any sprint and being built over: the §1b reconciliation phase.

**Proof — "a third party given only the finished sprint document can state
exactly what will change in the corpus and code and when the work is done, and
the queue fold shows every walked issue promoted into that sprint or retired
with a reason."** The story is annotated in `test/proofs.sh` and both conjuncts
are exercised against reality. The first: the ceremony's baked template carries
all four governing headings, the newest produced sprint carries the execution
and completion boilerplate, its deltas are final-form artifact bodies (asserted
by finding a `concept:`/`story:`/`decision:` frontmatter line inside a fenced
delta block, not merely the heading), and its work items are a flat list. The
second: the fold enumerates every issue file in `issues/` and `history/issues/`,
requiring each `promoted` file to name a sprint that exists on disk and each
`retired` file to carry non-empty text under `## Ruling`.

Re-run this cycle against the current bytes: the fold passes over this project's
real queue (52 walked, up from 48 at the prior pass — the intake grew and
drained further this cycle, none of it a fold failure), over a seeded
fixture, and rejects — as a negative control — a fixture seeded with a
promotion pointing at no sprint. The first
conjunct runs against the newest produced sprint by mtime — now the in-flight
`2026-07-28-corpus-browser-and-ruled-intake.md` (still under `sprints/`, not
yet archived; the harness does not distinguish), superseding the
previously-cited `2026-07-27-source-graph-certification.md` — and passes on
all four assertions: boilerplate present, deltas final-form, work items
flat. All ten of this story's
assertions pass and the harness exits 0. The three `plan-a-sprint` blocks are
byte-identical to the ones the prior audit cited — their span hashes are
unchanged — so the harness edit this cycle (a sharpening of another story's
heredoc fixture, two seeded body lines and the comment above them) touched none
of them.

## Determination

**satisfied.** Every Acceptance clause has a specific, citable enforcement
point in the ceremony's body, and several are enforced by dedicated components
rather than by exhortation: the baseline resolved from the `closed:` stamp, the
out-of-band reviewer with its BEARING tiebreak, the relevance pass, the corpus
surfacer, the shared compliance reviewer, and the post-sign-off promotion
stamping with its stated rationale. The story carries an annotated proof
covering both conjuncts of its `Proof:` field, including the queue fold that
guards the ceremony's most owner-sensitive promise — and the fold is exhibited
failing as well as passing, so it is a real check rather than a vacuous one.

Re-derived, not carried: this audit went stale for exactly one mechanical
reason — the whole-file pin on `test/proofs.sh` moved when another story's
heredoc fixture was sharpened elsewhere in the file. The harness was re-read and
re-run rather than assumed: the three blocks this audit rests on are unchanged
byte-for-byte, both conjuncts run against the current queue and the current
produced sprint, and every assertion passes. The ceremony itself was untouched
this cycle — its whole-file pin still verifies — so every Acceptance finding
above stands on the same evidence as before.

Refreshed again this cycle for the same mechanical reason, different cause:
`test/proofs.sh` gained per-story timing instrumentation across the whole
harness (a `section`/`emit_timing` helper pair, plus one new fixture story
`trace-corpus-to-code`), which moved the whole-file pin again. Inside this
story's own cited territory the only change is one inserted `section
plan-a-sprint` marker line immediately after the "sprint document is the
whole brief" header — the rest of that 19-line span, and the whole
`fold_check() {` span, are byte-identical. Re-run: both conjuncts pass again
against the current queue and the current produced sprint.

Refreshed a third time this cycle, citation-only: `test/proofs.sh` gained a
new `trace-corpus-to-code` section (a decision fixture with its own audit
and new assertions) elsewhere in the file, moving only the whole-file pin.
This story's three cited blocks are unaffected — re-verified byte-identical
— and the queue fold count moved only because the intake itself moved (52
walked, 0 problems; see above), not because the harness changed.

Non-determinative note for a later reader: the relevance reviewer's input is
the *unruled* open issues; ruled ones bypass the split and are carried straight
in at §1. That is deliberate and consistent with this story's Acceptance, but
it matters when reading `decision:relevance-scoped-queue-gate`, whose Choice
describes the wider population.

This determination stops holding if: the baseline resolution stops reading the
`closed:` stamp, or starts guessing one; the out-of-band phase or its BEARING
tiebreak is removed; the draft-first ordering is reversed on feature work; the
per-issue corpus surfacing is dropped, or the surfacer stops being
materialized; issues begin to be walked as a wall; promotion stamping moves
before sign-off; the delta template stops requiring final-form bodies, or the
work items acquire an imposed order; either boilerplate section stops being
required verbatim; or `test/proofs.sh` loses its `plan-a-sprint` blocks, its
`@story:` annotation, or the fold's negative control.

## Citations

- cite: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md :: "1. **Resolve the baseline.** Every sprint closed by a certify gate carries the closing commit"
- cite: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md :: "Dispatch the out-of-band reviewer below; only what it returns as BEARING is walked."
- cite-span: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md :: "4. **Walk the bearing set with the owner, one change at a time**" +8 sha256:c3cccf04fd75
- cite: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md :: "surface every tradeoff explicitly — never resolve one silently on the owner's behalf"
- cite: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md :: "run the relevance pass below over the §3 draft and the unruled open issues only"
- cite: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md :: "python3 .ok-planner/scripts/surface-corpus"
- cite-span: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md :: "#### The issue walk" +10 sha256:210fb9b81c4e
- cite: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md :: "**Retire** — the owner drops the question"
- cite-span: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md :: "<The substantive body. Each delta is a FINAL-FORM artifact body — a" +5 sha256:13738d7eb253
- cite-span: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md :: "<The implementation units that realize the deltas — a flat, unordered" +8 sha256:303326a4f27c
- cite-span: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md :: "### 5. Sign-off review" +5 sha256:31a7946abd50
- cite-span: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md :: "### 6. Terminal" +6 sha256:42622bad9e11
- cite: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md :: "The **How to execute this sprint** and **Completion contract** sections are fixed boilerplate"
- cite: plugins/ok/families/ok-planner/skills/_shared/design-doc-compliance-reviewer.md :: "The prompt body below is shared verbatim between the two invocations."
- cite: plugins/ok/families/ok-planner/test/proofs.sh :: "# @story: plan-a-sprint"
- cite-span: plugins/ok/families/ok-planner/test/proofs.sh :: "# --- plan-a-sprint: the sprint document is the whole brief" +19 sha256:ee95d8dea1ae
- cite-span: plugins/ok/families/ok-planner/test/proofs.sh :: "fold_check() {" +32 sha256:73710e66de22
- cite-span: plugins/ok/families/ok-planner/test/proofs.sh :: "# The first conjunct, sharpened: the produced sprint's deltas are" +14 sha256:2b442247daad
- cite-node: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md @ sha256:c33f4c0ea1ad
- cite-node: plugins/ok/families/ok-planner/test/proofs.sh @ sha256:560784191d5a
