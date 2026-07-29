---
audit: adversarial-implementation-audits
artifact: decision:adversarial-implementation-audits
determination: satisfied
audited: 2026-07-29T06:50:36Z
artifact-hash: sha256:35db3e84d441
---

# Whether implementation claims are verified by durable adversarial audits that determine implemented-and-covered, refer the qualitative rim out, cite both frontiers, never execute, and survive a release intact

Rewritten whole. The design artifact's hash moved — the in-flight sprint
amended the Choice, the Rationale, and the Alternatives — so precedent
lapses wholesale and this is a fresh adversarial read; the prior audit's
three amendment layers stand as history only. Four clause groups are
genuinely new and are derived below from the code rather than from the
prior record: the implemented-AND-covered charter with its
two-list completeness test and the measure-first cost tie-in; the
qualitative-clauses-become-referrals rule; citations covering both
frontiers so a proof edit re-stales a coverage judgment; and the
auditor-reads-never-executes rule with its `needs-demonstration:`
back-channel. Three new Alternatives entered with them and were checked
for being secretly in force.

The masking clause and the four-tier citation regime are unchanged text.
Their evidence includes the prior pass's recorded demonstration (a
simulated release over 721 files and 1080 graph rows). Per the standing
exhibition rule that is precedent to consume rather than re-pay, and its
cited reality was verified unmoved on this tree before leaning on it:
every one of the five mask citations (`mask_release_metadata` +13,
`VERSION_STAMP_MASK` +3, `MANIFEST_VERSION_MASK` +3, `SUITE_FAMILY` +2,
`masked_file_hash` +12) re-emits byte-identical hashes, and
`source-graph`'s `hash_pair` +9 and its byte-compatibility comment are
likewise unmoved. What did move in `audit-check` this cycle is the
inspection floor and `check_audit`'s signature — outside the mask
contract, and re-pinned below.

Refreshed again. The design artifact's hash is unchanged. Four whole/sub-node
pins moved this pass — `certification-core.md` and its
`{{CERTIFY-REVIEW-FIX-LOOP}}` node, and `certify-work`'s and `certify-all`'s
`#process` nodes — all from the owner-ratified rewording of the review-fix
loop's cycle cap (step 5's exit rule and the "Two paths reach the intake"
paragraph: the choice between another cycle and escalating is now stated as
the owner's alone, with no unattended default, and each gate's close-out
sentence repoints from "the owner escalated (or an unattended run escalated
by default)" to "the owner chose to escalate — the choice is always
theirs"). None of that lands on this decision's territory: the Producers
paragraph this audit's "qualitative-clauses-become-referrals" claim rests on,
the coverage-charter and both-frontiers clauses, the masking contract, and
the two `#process` citations' own subject (the producer lists confirming no
separate coverage seat exists) are all byte-identical to the versions this
audit already read — re-confirmed directly rather than assumed. Citations
regenerated; nothing else touched.

## Claims

**Title — "Implementation claims are verified by adversarial audits, not
test mandates."** Both halves hold. The auditor is one canonical shared
prompt block dispatched by both gates, written as a refutation exercise
("Your bias is adversarial: you are trying to REFUTE the claim, not to
confirm it"). No skill anywhere mandates a registered test per claim; the
only runtime obligation in the corpus is the story proof, and decisions
are stated to carry none.

**"a durable, per-artifact determination (`satisfied` or `violated`)
recorded in a fourth corpus collection."** Honored mechanically. The
checker hard-codes exactly the two determination values and rejects
anything else as `audit-malformed`; the collection is
`.ok-planner/audits/{stories,decisions}/`; the live population is derived
from directory listings under `.ok-planner/design/{stories,decisions}/`
so both directions are covered (`audit-missing` / `audit-orphaned`); and
placement is itself checked — an audit whose `artifact:` ref disagrees
with its directory or basename is malformed. Re-enumerated from reality
on this tree: twenty live stories and twenty-seven live decisions,
twenty and twenty-six audit files at the matching paths, and the one
gap is named by the checker itself as `audit-missing` for
`decision:inspection-registry` (the new artifact this batch writes the
first audit for) — the mechanism reporting a real hole, not a silent
pass.

**"written only by a certification producer that did not implement the
work under audit, and never hand-edited."** Enforced at the only layer a
prompt-executed system can enforce it, and stated at each point that
could violate it: the auditor file's consumer notes state author
separation as load-bearing, the certification core bars the fixer from
editing an audit file at all, and the canonical audit definition repeats
"never edited by hand mid-loop". Nothing mechanical prevents a
hand-write — a recognised limit of a prompt-enforced regime — and the one
place a machine can help (`checks/oscillation`) reads git history for
determinations that flipped while the artifact hash and every citation
stood still.

**NEW — "The audit's charter is implemented AND covered, bounded by the
artifact's decidable claims: for each quantified claim, completeness is
the difference of two enumerable lists — the members enumerated from the
population source minus the members the proofs exercise — with uncovered
members reported as ordinary findings and growth of the proof suite
governed by the measure-first cost discipline."** Honored, sentence
element by sentence element, in the auditor prompt's method step 2, which
states the two-list test in the same terms ("completeness is the diff of
two lists — the members enumerated from the source, minus the members the
story's proofs exercise"), makes each uncovered member "a claim-line
finding in a violated determination", assigns the writing of missing
conjuncts to the fixer and not the auditor, ties suite growth to the
measure-first discipline by name, and bounds the population to "the
story's decidable claims, nothing wider". The "ordinary findings" half is
delivered at the consuming end too: both gates say every `violated` line
is a finding for the loop, and the code reviewer's own focus list makes a
missing proof conjunct "an ordinary finding: the fixer writes the test,
and the proof surface grows through the loop". Checked adversarially for
the obvious hollowing-out — a separate coverage producer that would make
the charter nominal — and there is none: `certify-work`'s producer list
is alignment, prove, implementation audit, the mechanical floor, code
review; `certify-all`'s is alignment, prove, implementation audit,
`/audit`, code review. No coverage seat exists in either, which is what
the third new Alternative says was rejected.

**NEW — "Qualitative clauses ground no determination and no finding: each
is recorded as a referral — the promised thing verified to exist in form,
suitability explicitly not opined, the owning discipline named."**
Honored at four agreeing points. The decidability boundary defines the
rim, rules that no determination may rest on it, and states the referral
obligation in exactly these three parts. The canonical audit file format
carries a `## Referrals` section with a fixed four-line grammar
(referral / clause / delivered / discipline). The audit definition
repeats that determinations attach only to the mechanical core. And the
loop's Producers paragraph closes the finding half: producers do not emit
rim-only findings, the fixer dissolves any that arrive, the architect
adversarially checks each dissolution, and "The qualitative rim's
disposition is the audit's Referrals section, never the loop" — with the
presentation carrying a Referrals section fed from the in-scope audits
plus upheld dissolutions, so a referral has an owner-facing terminus and
never becomes an issue.

**NEW — "citations cover both frontiers, the code that delivers a claim
and the proof code that exercises it, so a proof edit re-stales the
coverage judgment that rested on it."** Honored as a rule and, unusually
for a new clause, already honored as practice across the whole live
population. The rule is stated canonically in the audit definition
("Citations cover both frontiers — enforcing code and proof code … so a
proof edit or deletion mechanically re-stales the audit whose coverage
judgment rested on it") and imperatively in the auditor's method step 4
("CITE the proof frontier like any other evidence … a coverage
determination uncited by its proofs cannot be re-triggered when a proof
is gutted or deleted"). The mechanism is the ordinary node pin, so no new
machinery is needed and none was added. The practice was enumerated from
reality rather than assumed: all twenty live story audits carry at least
two citations into a `test/` path (the smallest, this decision's own
sibling `certify-completion`, carries two; the largest carries
thirty-three), and the re-staling is live on this tree — `test/run.sh`
and `ok-plumbline/test/run.sh` moved this cycle, and the checker names
`corpus-proof`, `deterministic-source-graph`, `explain-lint-rules` and
`pipeline-check-wiring` stale by exactly those proof-side pins.

**NEW — "The auditor reads and judges, never executes: demonstrations are
run by the gate that dispatched it and consumed as recorded precedent,
and a claim only a new demonstration can settle is reported back on a
defined line for the gate to run."** Honored, and the loop is closed at
both ends rather than only asserted at one. Auditor side: the consumer
notes carry "**The auditor never executes; the gate runs
demonstrations.**" with the `needs-demonstration:` line defined and the
rule that no audit file is written for such a ref until re-dispatch;
method step 0 defines exhibitions as precedent to consume, never
produce, and routes a needed one back rather than running it; the Rules
say "not a runner: reading the code and the recorded evidence is your
entire toolkit"; and the Report format lists the line. Gate side — the
half that would make this vacuous if missing — both gates say they
satisfy it: `certify-work` requires "every `needs-demonstration:` line
satisfied by the gate running the named demonstration itself (via
`prove` where it is a story proof) and re-dispatching the ref with the
result recorded — auditors never execute", and `certify-all` says the
same. This audit is itself an instance of the consumption half: the
release demonstration was consumed as precedent after its citations were
verified unmoved, and nothing was re-run.

**"Audits cite the source graph by node identity and content hash — span
anchors within a node where finer resolution carries the verdict — and
pin quantified claims' population sources whole."** Honored; four
citation tiers implemented and machine-read. `cite-node:` resolves
`<path>` or `<path>#<chain>` through the committed graph and compares
against the hash the graph records, masked where the graph records a
masked one; `cite-span:` anchors within a node, content-hashed, with
`anchor-ambiguous` when the anchor is not unique; `cite:` is bare
existence; `cite-file:` is the pre-graph whole-file population pin, whose
graph-era equivalent is a whole-file `cite-node:`. No citation form
records a line number anywhere, and the emitter applies the same mask it
checks. Exercised against the live graph in the ordinary course of
writing this batch: whole-file identities and declaration-chain
identities both resolve and emit (including nested markdown sections such
as `artifact-definitions.md#shared-artifact-definitions.token-catalog.inspection-registry-format`),
the front-door manifest emits its masked value, and this pass's own
attempts to emit non-existent anchors were refused with a non-zero exit
rather than emitting a forgeable line.

**"A deterministic checker flags any audit whose design artifact or cited
nodes have changed, and the re-audit set is that stale set plus the
change-inspection nominations the auditor adjudicates."** Honored, and
exhibited on this tree rather than asserted — the exhibition is the
dispatch of this very batch. `audit-check` named 115 findings across the
corpus and `--list-stale` printed 27 refs; each traces to a substantive
edit and none to noise: this audit's own artifact hash moved because the
sprint rewrote the Choice; its node pins on `audit-check`,
`artifact-definitions.md`, `implementation-auditor.md` and
`certification-core.md` moved because the v11.2.0 repairs changed those
files; two spans moved because `check_audit` gained parameters and the
`cite-node` branch grew a `graph-stale` case; two anchors vanished
because their sentences were reworded; and the `decisions.md` population
pin moved because the catalog gained a member. The nomination half is
real and its round trip is visible elsewhere in this corpus: four
`adjudicated` registry entries this run point at
`story:explain-lint-rules`, whose audit carries the matching notes.
`--list-stale` is implemented as the machine-readable projection of
exactly the refs `check_audit` marked stale.

**The triage does not let a stale audit stand unread.** Re-checked
because it is the sharpest way the cheap-dispatch machinery could hollow
this decision out. Three things hold it shut. The refresh outcome is
available only when "the changed bytes lie outside every claim's
territory", and a citation *is* a claim's evidence, so bytes that moved a
cited hash are inside that territory by construction and land in amend or
rewrite-whole. A ref carrying a nomination, or whose artifact hash moved,
is a full pass by rule — which is why this batch is a set of full
rewrites. And a refresh batch that discovers otherwise must report
`escalate: <ref> — <why>` rather than deep-read cheaply, with both gates
stating that they re-dispatch escalations as full-pass batches. What
varies is the price of responding to the trigger, never whether it fires.

**"The checker masks release-mutable metadata — the suite-version stamp
lines materialization writes and the plugin manifests' version fields —
before hashing anything a citation or pin covers, so a release that
changes only versions voids no audit."** Honored. The four mask rules
(`Materialized by … v<semver>`, a `VERSION = "…"` assignment, a
`"version"` field in a plugin manifest, and any `v<semver>` on a line
naming an `ok-*` family) are unmoved, verified by re-emitting all five
pinned mask spans byte-identically. The prior pass's demonstration is
consumed as precedent on that basis: 0 masked-file divergences over 721
files, 0 pinned hashes moved over 1080 graph rows, and a finding set
byte-identical to baseline after the rebuild both gates mandate. The
harness holds the property from both sides — `masked-version-bump`
carries all five stamp shapes two releases ahead and must exit 0, its
twin `masked-edit-trips` carries a non-version edit on each of those same
surfaces and must trip, and `node-masked-bump` carries the node-citation
case. The non-text case is held too: `masked_file_hash` decodes strictly
and, on `UnicodeDecodeError`, hashes raw bytes rather than decoding
lossily, with the `binary-pin-changed` fixture's two blobs differing only
in invalid UTF-8 that a lossy decode would collapse.

Two recorded limits, neither charged because no sentence claims
otherwise. First, the freshness gate `cite-node:` resolution runs first
compares the graph's recorded *exact* file hash against the tree, so a
version-only release does move exact hashes and does leave the committed
graph stale until `source-graph build` re-runs; in that window the
checker reports `graph-stale` — a refusal to judge, not an invalidation —
and both gates rebuild before computing `--list-stale`. If the Choice
were ever tightened to say a release voids nothing *without* regenerating
generated state, this becomes a violation. Second, the family-scoped rule
masks a strict superset of the stamp population; no sentence claims the
mask is minimal, and if one is added, this flips.

**"Stories additionally carry deterministic integration-test proofs;
decisions carry no test obligation."** Honored as the obligation each
kind bears, with both populations re-enumerated from reality this pass
(catalogs pinned below): all twenty live stories carry a `## Proof`
section and none of the twenty-seven live decisions carries one —
including `inspection-registry`, the member added this cycle, checked
individually. The shared definitions file states "Decisions are audited,
not proof-mandated", and `/prove` says the same from the running end.

**"A negative determination stands in place until a re-audit flips it,
and blocks certification unless linked to an intake issue awaiting the
owner's ruling."** Honored mechanically, and firing on this tree right
now: `story:explain-lint-rules` stands `violated` and the checker reports
`violated-unlinked` against it, which is a blocking finding for the
gate. `violated` with an `issue:` naming no file under `issues/` or
`history/issues/` produces `issue-link-dangling` instead, and both
fixture directions are held. Nothing deletes a negative audit — the
auditor overwrites whole and the fixer is barred from touching the file.

**Rationale — "Coverage belongs to the same charter because its tractable
form is the same enumeration: falsifier-driven coverage does not
terminate, while a population diffed against the members the proofs
exercise makes completeness a checkable difference of two lists, found in
one audit rather than reactively, one gap per adversarial pass."** A
capability claim, and it is delivered rather than sold: the enumeration
step and the coverage step are the same method step 2 operating on the
same pinned population source, and the population pin (`cite-file:` /
whole-file `cite-node:`) is what makes a new member re-open the audit
whose quantifier it threatens. No falsifier-search machinery exists
anywhere to contradict the negative half.

**Rationale — "the fixer cannot satisfy an audit by any means except
changing the code it cites, which moves the hashes of the nodes it cites
and forces a fresh adversarial read."** Holds by exhaustion, each
alternative closed at a citable point: editing the audit is prohibited in
both the auditor file and the certification core; leaving the code alone
leaves a standing `violated-unlinked` finding blocking the gate; editing
the design artifact instead trips `audit-stale-artifact`. The
"fresh adversarial read" half survives the triage per the claim above.

**Rationale — "The reader is also only a reader: ad hoc execution
corrupts the state under judgment and drifts the audit into
experimentation, so execution stays with the gate — which owns the proof
verb and the project's stack — and the defined report line for a needed
demonstration keeps 'this must be run' from dead-ending into the auditor
running it anyway."** Honored: the gate genuinely owns the proof verb
(both gates invoke `ok-planner:prove` as a producer), and the
`needs-demonstration:` line is defined in the auditor's consumer notes,
its method, and its report format, with both gates committing to satisfy
it. The claim describes a real division of labour, not an aspiration.

**Rationale — "Determinations stop at the decidability line because an
adversarial re-audit against quality prose never converges … so
qualitative clauses become referrals marking where this process's
jurisdiction ends, and artifacts stay free to state qualitative
intent."** Honored, including the last clause, which is the one most
easily lost: the boundary says in so many words that the rim is legal
story content, never a defect, and that "stories are not rewritten to
scrub it".

**Rationale — "proof files are cited like any evidence, so a coverage
judgment re-opens when the proof it rested on changes."** Honored and
live, per the both-frontiers claim above.

**Rationale — the masking paragraph.** Honored on both halves — the
release half by the consumed demonstration, the second half ("any edit
beyond the masked patterns still breaks its anchor") by five harness
cases and by the live corpus, where every stale ref this batch inherited
traces to a substantive rewrite and none to a version change.

**Alternatives.** Seven, of which three are new; none is secretly in
force. Test mandates with per-claim exhibits: no such registry exists.
Read-and-judge without durable records: the records exist and go stale.
Diff-scoped review as the only reader: the auditor reads the standing
corpus, not the diff, and the diff-reading inspector only nominates.
Hashing stamped bytes as-is and re-auditing at release: negated in the
code — the release skill states that the checker's masking is precisely
why the release dispatches no agent and never writes
`.ok-planner/audits/`. **New:** an auditor licensed to run tests — barred
in the auditor's Rules and routed through `needs-demonstration:`
instead. **New:** forbidding qualitative language — contradicted by the
boundary's "the rim is legal story content, never a defect". **New:** a
dedicated coverage producer — absent from both gates' producer lists, as
enumerated above.

## Determination

**satisfied.** The whole regime is implemented in one deterministic
checker both gates consume as their clean bar — two determination values,
four citation tiers, staleness triggers on the artifact hash, node
identity, node hash, anchor, span and file pin, the `graph-missing` /
`graph-stale` findings that refuse a silent pass, missing / orphaned /
malformed findings, the `violated-unlinked` block, and `--list-stale` as
the machine-readable floor of the re-audit set — with the judged
inspection layer and its recorded adjudications supplying the rest of
that set. Every clause the sprint added lands on a specific enforcement
point rather than on a description of one: the implemented-and-covered
charter with its two-list test and measure-first tie-in is the auditor's
method step 2, and no separate coverage producer exists to make it
nominal; the referral rule is the decidability boundary plus the audit
file format's fixed grammar plus the loop's refusal to accept rim-only
findings plus the presentation's Referrals section; the both-frontiers
rule is the audit definition plus method step 4, and it is already
practice in all twenty live story audits and already re-staling four of
them this cycle; and the reads-never-executes rule is closed at both the
auditor's end and both gates' ends, with this pass consuming a recorded
demonstration rather than re-running it. The masking clause holds
against the tree as it stands: the five pinned mask spans and
`source-graph`'s byte-compatible copy are unmoved, so the demonstration
they carry stands as precedent.

This determination stops holding if: a new materialization site writes a
stamp in a shape none of the four masks covers (the whole-file node pins
on the converge cores break when any gains a substitution site, and the
pinned mask spans break if the masks move); the harness's masked, binary,
or node fixtures are deleted or weakened; `masked_file_hash` stops
decoding strictly, so a binary pin becomes forgeable; `source-graph`'s
mask stops being byte-compatible with `audit-check`'s; the `cite-node:`
tier stops masking on emission, stops refusing an unresolvable identity,
or stops refusing a tree-divergent graph (the `emit_citation`,
`CITE_NODE_LINE` and `load_graph` spans break); the fixer's bar on
editing audit files is removed; `--list-stale` stops being the mechanical
floor the gates consume, or the inspector's nominations stop joining it;
the refresh triage loses its territory test or its `escalate:`
back-channel; method step 2 loses the two-list completeness test or the
measure-first tie-in, or a separate coverage producer is added to either
gate's roster (which would make the "same charter" claim false); the
`## Referrals` grammar leaves the canonical audit file format, or the
loop starts accepting rim-only findings; method step 4's
cite-the-proof-frontier instruction is dropped, or story audits stop
carrying proof-side citations, so a gutted proof stops re-staling its
coverage judgment; the `needs-demonstration:` line is dropped from the
auditor's report format, or either gate stops committing to run the named
demonstration (which would leave the reads-never-executes rule with no
counterpart and turn it into a dead end); or a story lands without a
`## Proof` section or a decision acquires one (the catalog pins break).
It flips to violated if the Choice or Rationale is tightened to claim the
mask covers *only* release-mutable metadata, or that a release voids
nothing without regenerating the committed graph.

## Notes

<!-- The design artifact's hash moved, so the two notes below stand as
     history, not as binding precedent. Both were adjudicated before the
     lapse; neither is open, and this pass's fresh read reached the same
     conclusions on the territory they named. -->

- note: `.ok-planner/graph/` — 249 new `.graph` mirror files, the genesis build of the committed source graph — implicated because this decision describes `cite-node:` as a citation tier ("the graph-era equivalent is a whole-file `cite-node:`"); this build is the first time a real graph exists in this project for that tier to resolve against, worth confirming the tiering description still matches now that there is live data to test it on.
  adjudication: promoted — the tier was exercised against the genesis graph on live data (whole-file and declaration-chain identities resolving; the mask applied identically on emission and on checking, confirmed on the front-door manifest; an unresolvable identity and a tree-divergent graph each refusing to emit) and the description in the shared definitions file was read against that behavior and matches; the nominated territory is now carried by the whole-file node pins on `scripts/audit-check`, `scripts/source-graph` and `skills/_shared/artifact-definitions.md`, by the `CITE_NODE_LINE`, `load_graph`, `emit_citation` and `hash_pair` spans, and by the four node-and-graph `run_case` fixtures.
- note: `.ok-planner/design/concepts/decision-artifact.md` — the fix cycle dropped the "proof field is mandatory" and "the check's falsifier must be concretely producible" invariants and rewrote Boundaries so a decision owns no verification of its own, aligning the concept with "decisions carry no proofs; verification is the implementation audit" — this decision's own subject matter, and no citation of this audit covered that file.
  adjudication: promoted — read against the Choice's last clause and against the whole live surface, not just the diff: the concept previously *contradicted* this decision (a decision owned "the mechanical check that fails if the choice is silently violated", and two invariants made that check mandatory and its falsifier producible), and the rewrite removes the contradiction rather than creating one, so the claim strengthens; a sweep of the family's skills and this project's `design/{concepts,stories,decisions}/` found no surviving surface obligating a decision-side check, the sole remaining statement of the old rule being the bootstrap's as-is `design/_discover/` scaffold, which records what extraction found rather than what the corpus commits to; the nominated territory is now carried by the anchor on the concept's new Boundaries sentence, alongside the existing `artifact-definitions.md` and `/prove` anchors and the two catalog population pins.

## Citations

- cite-node: plugins/ok/families/ok-planner/scripts/audit-check @ sha256:32b1732e3fdd
- cite-node: plugins/ok/families/ok-planner/scripts/source-graph @ sha256:e293c0d31163
- cite-node: plugins/ok/families/ok-planner/skills/_shared/artifact-definitions.md @ sha256:4d1c78ea8291
- cite-node: plugins/ok/families/ok-planner/skills/_shared/artifact-definitions.md#shared-artifact-definitions.token-catalog.audit-definition @ sha256:8f71205c7278
- cite-node: plugins/ok/families/ok-planner/skills/_shared/artifact-definitions.md#shared-artifact-definitions.token-catalog.audit-file-format @ sha256:34118b5fbfb8
- cite-node: plugins/ok/families/ok-planner/skills/_shared/artifact-definitions.md#shared-artifact-definitions.token-catalog.decidability-boundary @ sha256:71d59a7fe0b6
- cite-node: plugins/ok/families/ok-planner/skills/_shared/implementation-auditor.md @ sha256:049ea0635856
- cite-node: plugins/ok/families/ok-planner/skills/_shared/implementation-auditor.md#implementation-auditor-prompt.how-consumers-use-this-file @ sha256:a632d4d58d4a
- cite-node: plugins/ok/families/ok-planner/skills/_shared/implementation-auditor.md#implementation-auditor-prompt.the-prompt.implementation-auditor-prompt @ sha256:167a073e872f
- cite-node: plugins/ok/families/ok-planner/skills/_shared/certification-core.md @ sha256:f42b50f44a66
- cite-node: plugins/ok/families/ok-planner/skills/_shared/certification-core.md#certification-core.how-consumers-use-this-file.certify-review-fix-loop @ sha256:45bcc0229e41
- cite-node: plugins/ok/families/ok-planner/skills/_shared/certification-core.md#certification-core.how-consumers-use-this-file.certify-presentation @ sha256:b27fc9b325a6
- cite-node: plugins/ok/families/ok-planner/skills/_shared/certification-core.md#certification-core.how-consumers-use-this-file.certify-code-review-prompt @ sha256:3177d4374e1a
- cite-node: plugins/ok/families/ok-planner/skills/certify-work/SKILL.md#certify-the-work-the-change-scoped-gate.process @ sha256:ab43437dd800
- cite-node: plugins/ok/families/ok-planner/skills/certify-all/SKILL.md#certify-everything-the-full-gate.process @ sha256:619fe94738d0
- cite-node: plugins/ok/families/ok-planner/skills/certify-all/SKILL.md#certify-everything-the-full-gate.what-certify-orchestrates @ sha256:248f04d4bc07
- cite-node: plugins/ok/families/ok-planner/skills/prove/SKILL.md @ sha256:c015b0e2ffd7
- cite-node: plugins/ok/families/ok-planner/test/run.sh @ sha256:a4d8463946b0
- cite-node: plugins/ok/families/ok-planner/admin/converge @ sha256:a75d56bfab1e
- cite-node: plugins/ok/families/ok-plumbline/admin/converge @ sha256:8ddee7fdc360
- cite-node: plugins/ok/families/ok-workspaces/scripts/converge.js @ sha256:86092f273c39
- cite-node: plugins/ok/.claude-plugin/plugin.json @ sha256:6ec970155f6e
- cite-node: plugins/ok-conduct/.claude-plugin/plugin.json @ sha256:7daa2bb3af13
- cite-node: plugins/ok/families/ok-workspaces/scripts/src-tag @ sha256:43620d1c3dbc
- cite-node: plugins/ok/families/ok-planner/scripts/hooks/session-start @ sha256:36c37d8090fb
- cite-node: checks/oscillation @ sha256:6c09b9dc57ae
- cite-node: .claude/skills/release/SKILL.md @ sha256:389ab919c1f5
- cite: plugins/ok/families/ok-planner/scripts/audit-check :: "DETERMINATIONS = ("satisfied", "violated")"
- cite-span: plugins/ok/families/ok-planner/scripts/audit-check :: "def check_audit(root, path, live, findings, stale_refs," +57 sha256:a750093fa49c
- cite-span: plugins/ok/families/ok-planner/scripts/audit-check :: "        m = CITE_NODE_LINE.match(raw)" +37 sha256:931c7e0c7c2d
- cite-span: plugins/ok/families/ok-planner/scripts/audit-check :: "def load_graph(root, source_rel):" +35 sha256:1aacd02c60fc
- cite-span: plugins/ok/families/ok-planner/scripts/audit-check :: "    if determination == "violated":" +10 sha256:a2c6f92e3048
- cite-span: plugins/ok/families/ok-planner/scripts/audit-check :: "def emit_citation(argv):" +45 sha256:25d0a2e4b40e
- cite: plugins/ok/families/ok-planner/scripts/audit-check :: "--list-stale prints only the artifact refs (kind:slug) needing"
- cite-span: plugins/ok/families/ok-planner/scripts/audit-check :: "def mask_release_metadata(text, target):" +13 sha256:b4095fb6d43a
- cite: plugins/ok/families/ok-planner/scripts/audit-check :: "STAMP_MASK = re.compile"
- cite-span: plugins/ok/families/ok-planner/scripts/audit-check :: "VERSION_STAMP_MASK = re.compile(" +3 sha256:e7583c1083de
- cite-span: plugins/ok/families/ok-planner/scripts/audit-check :: "MANIFEST_VERSION_MASK = re.compile(" +3 sha256:66a1433a7a09
- cite-span: plugins/ok/families/ok-planner/scripts/audit-check :: "SUITE_FAMILY = re.compile" +2 sha256:efafd5a34a7e
- cite-span: plugins/ok/families/ok-planner/scripts/audit-check :: "def masked_file_hash(full, target):" +12 sha256:f379c0418422
- cite: plugins/ok/families/ok-planner/scripts/audit-check :: "        # A non-UTF-8 (binary) pin target carries no stamp to mask, and a"
- cite: plugins/ok/families/ok-planner/scripts/source-graph :: "# The release-metadata mask, byte-compatible with audit-check's: a"
- cite-span: plugins/ok/families/ok-planner/scripts/source-graph :: "def hash_pair(data, rel):" +9 sha256:67be9d7d4edd
- cite: plugins/ok/families/ok-planner/skills/_shared/artifact-definitions.md :: "- **Citations are anchors and node pins, never reproductions.**"
- cite: plugins/ok/families/ok-planner/skills/_shared/artifact-definitions.md :: "cite-node: <identity> @ sha256:<12 hex>` — **the node pin**"
- cite: plugins/ok/families/ok-planner/skills/_shared/artifact-definitions.md :: "- **Citations cover both frontiers — enforcing code and proof code.**"
- cite: plugins/ok/families/ok-planner/skills/_shared/artifact-definitions.md :: "- **Determinations attach only to the mechanical core.**"
- cite: plugins/ok/families/ok-planner/skills/_shared/artifact-definitions.md :: "Staleness is computed, never stored"
- cite: plugins/ok/families/ok-planner/skills/_shared/artifact-definitions.md :: "**Decisions are audited, not proof-mandated.**"
- cite: plugins/ok/families/ok-planner/skills/_shared/implementation-auditor.md :: "**Author separation is load-bearing:**"
- cite: plugins/ok/families/ok-planner/skills/_shared/implementation-auditor.md :: "- **The auditor never executes; the gate runs demonstrations.**"
- cite: plugins/ok/families/ok-planner/skills/_shared/implementation-auditor.md :: "**Split by triage class, price by the job.**"
- cite: plugins/ok/families/ok-planner/skills/_shared/implementation-auditor.md :: "- **rewrite whole**: the artifact's hash moved (precedent"
- cite: plugins/ok/families/ok-planner/skills/_shared/implementation-auditor.md :: "If you were dispatched as a refresh batch and a ref needs more"
- cite: plugins/ok/families/ok-planner/skills/_shared/implementation-auditor.md :: "    not a runner: reading the code and the recorded evidence is"
- cite-span: plugins/ok/families/ok-planner/skills/_shared/implementation-auditor.md :: "  0. Read the prior audit file first, if one exists — it is the" +17 sha256:0dc64431681a
- cite-span: plugins/ok/families/ok-planner/skills/_shared/implementation-auditor.md :: "     Exhibitions are precedent you CONSUME, never produce: where" +12 sha256:4d3e7528a671
- cite-span: plugins/ok/families/ok-planner/skills/_shared/implementation-auditor.md :: "  2. For every quantifier (every, all, each, never, none, only," +23 sha256:ae60e3367507
- cite-span: plugins/ok/families/ok-planner/skills/_shared/implementation-auditor.md :: "  4. For stories: also judge the proof. Run" +14 sha256:1896bf0211e8
- cite-span: plugins/ok/families/ok-planner/skills/_shared/implementation-auditor.md :: "     citations, the determination the DECIDABLE claims add up to," +16 sha256:298046b88a19
- cite: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "The fixer never edits an audit file"
- cite-span: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "**Producers.** The gate's review passes" +4 sha256:30eacae656a2
- cite-span: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "**The two-layer re-audit trigger, stated once for both gates.**" +1 sha256:9b77fdd72dad
- cite-span: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "## Referrals" +8 sha256:9c3d4b64c72c
- cite: plugins/ok/families/ok-planner/skills/certify-all/SKILL.md :: "the full gate's scope is coverage: every determination is revisited"
- cite: plugins/ok/families/ok-planner/skills/prove/SKILL.md :: "Decisions carry no proofs; their verification is the implementation audit."
- cite: .ok-planner/design/concepts/decision-artifact.md :: "It owns no verification of its own: it carries no proof and states no separate falsifier"
- cite: .claude/skills/release/SKILL.md :: "No implementation audit goes stale — the vendored checker masks exactly these stamps"
- cite: plugins/ok/families/ok-planner/scripts/hooks/session-start :: "context="ok-planner v{{OK_PLANNER_VERSION}} is materialized in this project."
- cite-span: plugins/ok/families/ok-planner/admin/converge :: "    sed "s/{{OK_PLANNER_VERSION}}/${SUITE_VERSION}/g" "$SOURCE_GRAPH" > "${OK_DIR}/bin/source-graph"" +2 sha256:710a9e6e0dae
- cite-span: plugins/ok/families/ok-planner/admin/converge :: "sed "s/{{OK_PLANNER_VERSION}}/${SUITE_VERSION}/g" "$PROOF_TIMINGS" > "${OK_DIR}/bin/proof-timings"" +2 sha256:709791c30471
- cite: plugins/ok/families/ok-planner/scripts/proof-timings :: "VERSION = "{{OK_PLANNER_VERSION}}""
- cite: plugins/ok/families/ok-planner/scripts/corpus-view :: "VERSION = "{{OK_PLANNER_VERSION}}""
- cite: plugins/ok/families/ok-planner/scripts/ok-planner-gitignore :: "# Materialized by ok-planner v{{OK_PLANNER_VERSION}}. Suite-owned:"
- cite: plugins/ok/families/ok-workspaces/scripts/src-tag :: "# ok-workspaces canonical src-tag script v{{OK_WORKSPACES_VERSION}}."
- cite: plugins/ok/families/ok-planner/test/run.sh :: "run_case "version bump masked""
- cite: plugins/ok/families/ok-planner/test/run.sh :: "run_case "binary pin change trips""
- cite: plugins/ok/families/ok-planner/test/run.sh :: "run_case "node citation clean""
- cite: plugins/ok/families/ok-planner/test/run.sh :: "run_case "node content change trips""
- cite: plugins/ok/families/ok-planner/test/run.sh :: "run_case "renamed node unresolves""
- cite: plugins/ok/families/ok-planner/test/run.sh :: "run_case "stale graph is a finding""
- cite: plugins/ok/families/ok-planner/test/run.sh :: "run_case "node stamp bump masked""
- cite: plugins/ok/families/ok-planner/test/run.sh :: "run_case "re-audit set""
- cite-span: checks/oscillation :: "def audit_flips():" +28 sha256:73bc4b08d1f8
- cite-file: .ok-planner/design/stories.md @ sha256:fb109645b6d9
- cite-file: .ok-planner/design/decisions.md @ sha256:457a9c1af13a
