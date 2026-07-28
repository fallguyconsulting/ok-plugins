---
audit: adversarial-implementation-audits
artifact: decision:adversarial-implementation-audits
determination: satisfied
audited: 2026-07-28T10:29:55Z
artifact-hash: sha256:58601127b06e
---

# Whether implementation claims are verified by durable adversarial audits with node-and-anchor citations, mechanical staleness plus adjudicated nominations, and a mask that survives a release

Amended, not rewritten. The design artifact's hash is unchanged, and the
whole-regime derivation below was written this morning against a reality that
has moved in exactly two narrow places — so the determinations bind and only
the touched claims are re-derived. What moved: (1) the fix cycle rewrote
`source-graph`'s `walk_sources()`, breaking this audit's whole-file node pin
on that program — a pin whose job here is the mask contract, not the walk, so
the pin is re-homed and the mask contract re-verified rather than the
program's behavior re-argued (`story:deterministic-source-graph`'s audit owns
the walk); (2) `concept:decision-artifact` dropped its
proof-field-mandatory / falsifier-producible / mechanical-check-ownership
text, which is a change *in this decision's subject matter* — an open
nomination, adjudicated below, and a corroboration rather than a threat. The
prior pass's exhibitions — the 721-file, 1080-row release demonstration and
the live `cite-node:` tier exercises — are precedent under the standing rule
and are carried, their cited reality (the four mask spans, the five stamp
sites, the `emit_citation` / `CITE_NODE_LINE` / `load_graph` spans) verified
unmoved this pass. Where a number below is that pass's, it is labelled.

The earlier preamble is preserved here because the claims still rest on it:
that pass was itself a whole rewrite, prompted by the genesis build of
`.ok-planner/graph/` giving the `cite-node:` tier live data to resolve against
for the first time in this project, and by `certify-all`'s "re-derives every
determination fresh" being replaced with coverage-under-triage wording.

## Claims

**Title — "Implementation claims are verified by adversarial audits, not
test mandates."** Both halves hold. The auditor is a canonical shared prompt
block dispatched by both gates, written as a refutation exercise ("Your bias
is adversarial: you are trying to REFUTE the claim"). No skill anywhere
mandates a registered test per claim; the only runtime obligation in the
corpus is the story proof, and decisions are stated to carry none.

**"a durable, per-artifact determination (`satisfied` or `violated`)
recorded in a fourth corpus collection."** Honored mechanically. The checker
hard-codes exactly the two determination values and rejects anything else as
`audit-malformed`; the collection is `.ok-planner/audits/{stories,decisions}/`;
the live population is derived from `.ok-planner/design/{stories,decisions}/`
so both directions are covered (`audit-missing` / `audit-orphaned`); and
placement itself is checked — an audit whose `artifact:` ref disagrees with
its directory or basename is malformed. Re-verified against reality on this
tree: seventeen live stories and twenty-two live decisions, seventeen and
twenty-two audit files at the matching paths, and the checker names no
`audit-missing` and no `audit-orphaned` ref.

**"written only by a certification producer that did not implement the work
under audit, and never hand-edited."** Enforced at the only layer a
prompt-executed system can enforce it: the auditor file states author
separation as load-bearing, and the certification core bars the fixer from
editing an audit file at all. Nothing mechanical prevents a hand-write — a
recognised limit of a prompt-enforced regime, stated at every point that
could violate it, and the one place a machine can help
(`checks/oscillation`) reads git history for determinations that flipped
while the artifact hash and every citation stood still.

**"Audits cite the source graph by node identity and content hash — span
anchors within a node where finer resolution carries the verdict — and pin
quantified claims' population sources whole."** Honored, four citation tiers
implemented and machine-read — and, for the first time in this project,
exercised against a real graph rather than against fixtures alone, which is
what the nomination asks. `cite-node:` resolves `<path>` or `<path>#<chain>`
through the committed graph and compares against the hash the graph records,
masked where the graph records a masked one; `cite-span:` anchors within a
node, content-hashed, with `anchor-ambiguous` when the anchor is not unique;
`cite:` is bare existence; `cite-file:` is the pre-graph whole-file
population pin, whose graph-era equivalent is a whole-file `cite-node:`. No
citation form records a line number anywhere. The shared definitions file
describes exactly this tiering, and the description was checked against live
behavior rather than taken on its word:

- A whole-file identity resolves and emits (`scripts/source-graph`), and a
  declared-unit identity resolves through the declaration chain the graph
  records (`admin/converge#vendor_layer`, and nested markdown sections such
  as `certify-all/SKILL.md#certify-everything-the-full-gate.process`).
- The mask is applied on emission exactly as on checking: the front-door
  manifest's graph row records `sha256:0a63d8f25de3 masked:6ec970155f6e`,
  and `audit-check cite-node` for that path emits `6ec970155f6e` — the
  masked value, matching the `cite-file:` pin this corpus already carried.
- An identity absent from the graph refuses to emit
  (`admin/converge#no_such_function` → "does not resolve in the committed
  graph", exit 1), and so does a citation into a file whose committed graph
  no longer matches the tree ("run source-graph build first", exit 1).

The migration wording in the Choice's own framing has now largely been
discharged here: this corpus is being re-homed onto the graph in this pass,
with population pins on `.ok-planner/design/` catalogs necessarily remaining
`cite-file:` — the root estate is excluded from the graph by design, so no
node exists to pin. That is the pre-graph form doing exactly the job the
Choice reserves for it, not a gap.

One asymmetry between helper and checker, recorded because it borders on the
"cannot disagree" claim below and does not breach it: for a bare `cite:`, the
helper requires the anchor to occur on one line, while the checker accepts
any whitespace-normalized whole-file match. The helper is therefore strictly
stricter, so no line the helper emits can fail the checker — which is the
direction the claim asserts.

**"a deterministic checker flags any audit whose design artifact or cited
nodes have changed."** Honored, and exhibited on this tree twice over rather
than asserted — the second exhibition is what dispatched this pass, which is
the strongest form the claim can take. Entering *this* batch, `audit-check`
named eleven stale citations across eight refs, every one of them traceable
to a substantive edit and none to noise: the node pins on `source-graph` and
`proofs.sh` moved because the fix cycle changed those files, the
`walk_sources` span moved because the change was inside it, and
`bootstrap-design-corpus`'s population pin on `.ok-planner/design/concepts.md`
moved because the catalog's TOC was reordered — a population source changing,
which is the pin's whole purpose. `--list-stale` printed exactly the eight
refs, and this audit was among them for exactly one reason: the whole-file
node pin on the program the fix cycle edited. The trigger fired on real code
this project actually changed, not on a fixture.

Entering the *previous* batch, the same checker named this audit's own three
stale refs — two `cite-span:` regions whose hashes moved when v11.1.x rewrote
the two gates' implementation-audit bullets, and a bare `cite:` anchor
deleted outright when `certify-all`'s "re-derives every determination fresh"
sentence was replaced. The node triggers are no longer fixture-only:
in a scratch copy of this tree, a `cite-node:` pinned to a real shell
function reported "the cited content changed" after a one-line edit and "no
longer resolves in the committed graph" after a rename, while the file's
three sibling nodes held their committed hashes; before the rebuild the same
citation reported `graph-stale` rather than a verdict. The artifact-hash
trigger is held by fixtures (no design artifact moved this cycle). Six
harness fixtures cover the node and graph triggers directly, at exit 0.

**"and the re-audit set is that stale set plus the change-inspection
nominations the auditor adjudicates."** Honored in both gates and in the
shared core, with `certify-all`'s side restated because its wording changed.
`certify-work` defines the re-audit set as the union of the touched
artifacts, every ref `--list-stale` names (explicitly including audits
outside the delta), and every audit the inspector nominated — "and nothing
else; code annotations play no part in it". `certify-all` no longer says it
re-derives every determination fresh; it says the full gate's scope is
**coverage** — every determination is revisited, not just the stale ones,
each ref taking the triage's cheapest honest outcome — and it still
dispatches the inspector over the uncommitted tree so nominations and the
reconciliation ledger are recorded at full scope. Both readings satisfy the
Choice: the Choice fixes the re-audit set's *floor* (stale plus
nominations), and coverage is a superset of it. The core's re-review step
recomputes the same union after every fix cycle. `--list-stale` is
implemented as the machine-readable projection of exactly the refs
`check_audit` marked stale.

**The triage added in v11.1.x does not let a stale audit stand unread.**
Checked because it is the sharpest way the new machinery could have hollowed
out this decision. Three things hold it shut. The prompt's refresh outcome
is available only when "the changed bytes lie outside every claim's
territory", and a citation *is* a claim's evidence, so bytes that moved a
cited hash are inside that territory by construction and land in amend or
rewrite-whole. A ref carrying a nomination, or whose artifact hash moved, is
a full pass by rule. And a refresh batch that discovers otherwise must
report `escalate: <ref> — <why>` rather than deep-read cheaply, with both
gates stating that they re-dispatch escalations as full passes. What varies
is the price of responding to the trigger, never whether it fires.

**"The checker masks release-mutable metadata — the suite-version stamp
lines materialization writes and the plugin manifests' version fields —
before hashing anything a citation or pin covers, so a release that changes
only versions voids no audit."** Honored. The enumeration binds by precedent
— every pin it rests on verifies unmoved this pass: the three carried
families' converge cores (the planner core's six `sed
"s/{{OK_PLANNER_VERSION}}/…/g"` passes plus its python vendor layer's
`STAMP` constant; the plumbline core's cheatsheet and post-edit
substitutions, its `const VERSION = '0.0.0-unvendored'` rewrite, and its
binary's vendored-skill stamp; the workspaces `converge.js` `stamp()` helper
plus its three generated stamp strings) and the two
`.claude-plugin/plugin.json` manifests, all covered by the four mask rules
(`Materialized by … v<semver>`, a `VERSION = "…"` assignment, a `"version"`
field in a plugin manifest, and any `v<semver>` on a line naming an `ok-*`
family).

The claim was then exercised end to end on the tree as it now stands, and
re-run rather than carried, because the tree now carries a committed graph
and a release therefore touches more than it used to. In a scratch copy,
both manifests were bumped `11.1.1` → `11.1.2` and the planner converge core
re-run — precisely the release act's step 5c. Results:

- Over all 721 files in the tree, **zero** diverged under the checker's own
  `masked_file_hash` before and after. Every `cite:`, `cite-span:` and
  `cite-file:` in the corpus therefore stands.
- Across the committed graph's 1080 file-and-node rows: 52 **exact** hashes
  moved, 0 rows appeared or disappeared, and **zero** pinned hashes (the
  masked value where one is recorded, the exact value otherwise) moved. No
  `cite-node:` citation in the corpus can be voided by a version-only
  release.
- After the graph rebuild both gates mandate before judging citations,
  `audit-check`'s finding set over the released tree is **byte-identical**
  to the pre-release baseline — not one finding more, not one fewer.

The harness holds the same property from both sides: `masked-version-bump`
carries all five stamp shapes two releases ahead of the audit citing them and
must exit 0, its twin `masked-edit-trips` carries a non-version edit on each
of those same five surfaces and must trip, and `node-masked-bump` carries
the node-citation case.

**"before hashing anything a citation or pin covers."** Honored including
the non-text case, where masking could have quietly weakened a pin:
`masked_file_hash` decodes strictly and, on `UnicodeDecodeError`, hashes raw
bytes rather than decoding lossily — a lossy decode is not injective, and
the `binary-pin-changed` fixture's two blobs differ only in invalid UTF-8
that `errors="replace"` would collapse. Both directions are held (the
fixture must trip; the `clean` fixture's binary pin must not).
`source-graph` carries a byte-compatible copy of the same mask and records a
`masked:` hash only where masking changes the bytes; the genesis build
confirms the two implementations agree on live data — 35 mirrors carry
`masked:` rows, and the manifest spot-check above matches the checker's
emitter exactly.

That agreement was re-verified this pass rather than carried, because the
fix cycle edited `source-graph` and this audit's pin on it moved. The edit is
confined to the file set the walk produces (`walk_sources` split into
`is_excluded` / `git_listed_files` / `filesystem_files`); the mask itself is
untouched, both `mask_release_metadata` and `hash_pair` verifying byte-for-byte
unmoved against their pinned spans, and the mask population is unmoved with
it — 35 `masked:` mirrors under the committed graph and 35 under the fixed
program's output over the same tree. So the one thing this decision asks of
`source-graph` — that its mask and the checker's cannot disagree — is
undisturbed by the change that broke the pin. The re-homed pin is the honest
consequence of a whole-file pin doing its job: it re-opens the audit whenever
*any* of the pinned program changes, and this pass is the read that confirms
the change was outside the claim's substance.

One honest limit, recorded and not charged, because no sentence of the
artifact claims otherwise — and now quantified, where before it was
predicted. The freshness gate `cite-node:` resolution runs first compares
the graph's recorded *exact* file hash against the tree, so a version-only
release does move exact hashes (52 of them, above) and does leave the
committed graph stale until `source-graph build` is re-run. In that window
the checker reports `graph-stale` rather than a verdict: in the simulated
release, four such transient findings appeared on audits carrying
`cite-node:` lines into restamped files. They are refusals to judge, not
invalidations, and they vanish on the rebuild that both gates perform before
computing `--list-stale`, after which the finding set is byte-identical to
baseline. The Choice's claim is about the checker's hashing, which is masked
as stated. If the Choice were ever tightened to say a release voids nothing
*without* regenerating generated state, this becomes a violation.

A second recorded limit, likewise not charged: the family-scoped rule masks
a strict superset of the stamp population — any `v<semver>` on any line
naming an `ok-*` family, whether a materialized stamp or an ordinary
literal. No sentence claims the mask is minimal. If one is ever added, this
flips.

**"Stories additionally carry deterministic integration-test proofs;
decisions carry no test obligation."** Honored as the obligation each kind
bears, with both populations re-enumerated from reality this pass (catalogs
pinned below): all seventeen live stories carry a `## Proof` section and none
of the twenty-two live decisions carries one. The shared definitions file
states "Decisions are audited, not proof-mandated", and `/prove` says the
same from the running end.

This clause is where the open nomination lands, and it strengthens rather
than threatens. `concept:decision-artifact` — the corpus's own definition of
the kind this sentence legislates for — used to contradict it outright: its
Boundaries gave a decision ownership of "the mechanical check that fails if
the choice is silently violated", and two of its three invariants made a
proof field mandatory and demanded a concretely producible falsifier for that
check. The fix cycle replaced that with "It owns no verification of its own:
it carries no proof and states no separate falsifier — whether an
implementation honors the choice is determined adversarially by the
decision's implementation audit". The Choice's negative half is now asserted
by the concept as well as by the machinery, and the last live surface that
said otherwise is gone. Swept for residue rather than assumed: across the
family's skills and this project's `design/{concepts,stories,decisions}/`, no
surface now obligates a decision-side check — the six places that speak to it
all say decisions carry no proofs. The one remaining statement of the old
rule is in `.ok-planner/design/_discover/decision-artifact.md`, the bootstrap's
as-is discovery scaffold, which is a record of what was found at extraction
time rather than a live commitment, and is left alone here for that reason.

**"A negative determination stands in place until a re-audit flips it, and
blocks certification unless linked to an intake issue awaiting the owner's
ruling."** Honored mechanically: `violated` with no `issue:` produces
`violated-unlinked`; `violated` with an `issue:` naming no file under
`issues/` or `history/issues/` produces `issue-link-dangling`; and both
fixture directions (`violated-unlinked` must trip, `violated-linked` must
not) are held. Nothing deletes a negative audit — the auditor overwrites
whole and the fixer is barred from touching the file.

**Rationale — "the fixer cannot satisfy an audit by any means except
changing the code it cites, which moves the hashes of the nodes it cites and
forces a fresh adversarial read."** Holds by exhaustion of the alternatives,
each closed at a citable point: editing the audit is prohibited in both the
auditor file and the certification core; leaving the code alone leaves a
standing `violated-unlinked` finding blocking the gate; editing the design
artifact instead trips `audit-stale-artifact`. The "fresh adversarial read"
half survives the triage, per the claim above: a fixer's edit to cited code
lands inside a claim's territory by construction, which is the
rewrite-whole class.

**Rationale — "the judged inspection layer covers the one blindness
citations keep — work added beside a cited span breaks no hash, so an agent
reads the change itself and its nominations reach the auditor as recorded,
adjudicable candidates."** Honored: the change inspector prompt exists in
the shared core, is dispatched by both gates and again at every re-review,
records nominations as provisional notes, and is explicitly candidacy ("You
nominate; you never invalidate"). The auditor's method step 0 is the
adjudication side, and this audit's own Notes ledger is an instance of the
round trip completing.

**Rationale — "Version stamps sit inside otherwise-cited bytes and must
change on every release, so masking them is what keeps the tripwire
meaningful: staleness signals substantive change, never the release act,
while any edit beyond the masked patterns still breaks its anchor."**
Honored on both halves — the release half by the 721-file, 1080-row
demonstration above, the second half by five harness cases and by the live
corpus, where every stale ref this batch inherited traces to a substantive
rewrite of the certification skills and none to a version change.

**Alternatives — "Hashing stamped bytes as-is and re-auditing at release
time."** A genuine road not taken and negated in the code: the release skill
states that the checker's masking is precisely why the release dispatches no
agent, re-derives no audit, and never writes `.ok-planner/audits/`.

## Determination

**satisfied.** The whole regime is implemented in one deterministic checker
both gates consume as their clean bar — two determination values, four
citation tiers, staleness triggers on the artifact hash, node identity, node
hash, anchor, span and file pin, the `graph-missing` / `graph-stale`
findings that refuse a silent pass, missing/orphaned/malformed findings, the
`violated-unlinked` block, and `--list-stale` as the machine-readable floor
of the re-audit set — with the judged inspection layer and its recorded
adjudications supplying the rest of that set. The nomination's question is
answered: with a real graph in place, the `cite-node:` tier resolves whole
files and declared units, emits under the same mask it checks, refuses to
resolve an absent identity, and refuses to judge through a tree-divergent
graph — so the Choice's description of the tier matches live behavior, not
just fixtures. `certify-all`'s coverage-under-triage wording satisfies the
Choice's re-audit-set floor as a superset, and the triage cannot let a stale
audit stand unread. The masking clause holds against the tree as it now
stands, exhibited at a scale the graph made possible: 0 masked-file
divergences over 721 files, 0 pinned hashes moved over 1080 graph rows, and
a byte-identical finding set after the mandated rebuild.

This determination stops holding if: a new materialization site writes a
stamp in a shape none of the four masks covers (the whole-file node pins on
all three converge cores break when any gains a substitution site, and the
pinned spans over the four mask definitions break if the masks move); the
harness's masked, binary, or node fixtures are deleted or weakened (the pin
on `test/run.sh` and the anchors on its `run_case` lines break first);
`masked_file_hash` stops decoding strictly, so a binary pin becomes
forgeable; `source-graph`'s mask stops being byte-compatible with
`audit-check`'s, so an emitted node citation and a checked one could
disagree (the whole-file pin on that program re-opens this audit on any edit
to it, and the `mask_release_metadata` and `hash_pair` spans are what fix the
contract); `concept:decision-artifact` re-acquires a proof field or a
mechanical-check obligation for decisions, putting the corpus back in
contradiction with the Choice's last clause (the pinned Boundaries anchor
breaks); the `cite-node:` tier stops masking on emission, stops refusing an
unresolvable identity, or stops refusing a tree-divergent graph (the
`emit_citation`, `CITE_NODE_LINE` and `load_graph` spans break); the fixer's
bar on editing audit files is removed; `--list-stale` stops being the
mechanical floor the gates consume, or the inspector's nominations stop
joining it; the refresh triage loses its territory test or its `escalate:`
back-channel, so a cheap dispatch could absorb a real invalidation; or a
story lands without a `## Proof` section or a decision acquires one (the
catalog pins break). It flips to violated if the Choice or Rationale is
tightened to claim the mask covers *only* release-mutable metadata, or that
a release voids nothing without regenerating the committed graph.

## Notes

- note: `.ok-planner/graph/` — 249 new `.graph` mirror files, the genesis build of the committed source graph — implicated because this decision describes `cite-node:` as a citation tier ("the graph-era equivalent is a whole-file `cite-node:`"); this build is the first time a real graph exists in this project for that tier to resolve against, worth confirming the tiering description still matches now that there is live data to test it on.
  adjudication: promoted — the tier was exercised against the genesis graph on live data (whole-file and declaration-chain identities resolving; the mask applied identically on emission and on checking, confirmed on the front-door manifest; an unresolvable identity and a tree-divergent graph each refusing to emit) and the description in the shared definitions file was read against that behavior and matches; the nominated territory is now carried by the whole-file node pins on `scripts/audit-check`, `scripts/source-graph` and `skills/_shared/artifact-definitions.md`, by the `CITE_NODE_LINE`, `load_graph`, `emit_citation` and `hash_pair` spans, and by the four node-and-graph `run_case` fixtures.
- note: `.ok-planner/design/concepts/decision-artifact.md` — the fix cycle dropped the "proof field is mandatory" and "the check's falsifier must be concretely producible" invariants and rewrote Boundaries so a decision owns no verification of its own, aligning the concept with "decisions carry no proofs; verification is the implementation audit" — this decision's own subject matter, and no citation of this audit covered that file.
  adjudication: promoted — read against the Choice's last clause and against the whole live surface, not just the diff: the concept previously *contradicted* this decision (a decision owned "the mechanical check that fails if the choice is silently violated", and two invariants made that check mandatory and its falsifier producible), and the rewrite removes the contradiction rather than creating one, so the claim strengthens; a sweep of the family's skills and this project's `design/{concepts,stories,decisions}/` found no surviving surface obligating a decision-side check, the sole remaining statement of the old rule being the bootstrap's as-is `design/_discover/` scaffold, which records what extraction found rather than what the corpus commits to; the nominated territory is now carried by the anchor on the concept's new Boundaries sentence, alongside the existing `artifact-definitions.md` and `/prove` anchors and the two catalog population pins.

## Citations

- cite-node: plugins/ok/families/ok-planner/scripts/audit-check @ sha256:d0e1036a76ae
- cite-node: plugins/ok/families/ok-planner/scripts/source-graph @ sha256:868ff5e192f4
- cite-node: plugins/ok/families/ok-planner/skills/_shared/artifact-definitions.md @ sha256:c1cc5f500114
- cite-node: plugins/ok/families/ok-planner/skills/_shared/implementation-auditor.md @ sha256:e79c50adcfaa
- cite-node: plugins/ok/families/ok-planner/skills/_shared/certification-core.md @ sha256:f96e5bcb96d6
- cite-node: plugins/ok/families/ok-planner/skills/certify-work/SKILL.md#certify-the-work-the-change-scoped-gate.process @ sha256:d26bc8e299d5
- cite-node: plugins/ok/families/ok-planner/skills/certify-all/SKILL.md#certify-everything-the-full-gate.process @ sha256:5c588bd4687c
- cite-node: plugins/ok/families/ok-planner/skills/certify-all/SKILL.md#certify-everything-the-full-gate.what-certify-orchestrates @ sha256:f5c27dd013c4
- cite-node: plugins/ok/families/ok-planner/skills/prove/SKILL.md @ sha256:3780a5429f89
- cite-node: plugins/ok/families/ok-planner/test/run.sh @ sha256:8c0006755840
- cite-node: plugins/ok/families/ok-planner/admin/converge @ sha256:144ab87e08af
- cite-node: plugins/ok/families/ok-plumbline/admin/converge @ sha256:8ddee7fdc360
- cite-node: plugins/ok/families/ok-workspaces/scripts/converge.js @ sha256:86092f273c39
- cite-node: plugins/ok/.claude-plugin/plugin.json @ sha256:6ec970155f6e
- cite-node: plugins/ok-conduct/.claude-plugin/plugin.json @ sha256:7daa2bb3af13
- cite-node: plugins/ok/families/ok-workspaces/scripts/src-tag @ sha256:43620d1c3dbc
- cite-node: plugins/ok/families/ok-planner/scripts/hooks/session-start @ sha256:36c37d8090fb
- cite-node: checks/oscillation @ sha256:6c09b9dc57ae
- cite-node: .claude/skills/release/SKILL.md @ sha256:a210df9f5d1e
- cite: plugins/ok/families/ok-planner/scripts/audit-check :: "DETERMINATIONS = ("satisfied", "violated")"
- cite-span: plugins/ok/families/ok-planner/scripts/audit-check :: "def check_audit(root, path, live, findings, stale_refs):" +55 sha256:f5f073d2a484
- cite-span: plugins/ok/families/ok-planner/scripts/audit-check :: "        m = CITE_NODE_LINE.match(raw)" +33 sha256:8dcf6bfe3f85
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
- cite: plugins/ok/families/ok-planner/skills/_shared/artifact-definitions.md :: "Staleness is computed, never stored"
- cite: plugins/ok/families/ok-planner/skills/_shared/artifact-definitions.md :: "**Decisions are audited, not proof-mandated.**"
- cite: plugins/ok/families/ok-planner/skills/_shared/implementation-auditor.md :: "**Author separation is load-bearing:**"
- cite: plugins/ok/families/ok-planner/skills/_shared/implementation-auditor.md :: "**Split by triage class, price by the job.**"
- cite: plugins/ok/families/ok-planner/skills/_shared/implementation-auditor.md :: "- **rewrite whole**: the artifact's hash moved (precedent"
- cite: plugins/ok/families/ok-planner/skills/_shared/implementation-auditor.md :: "If you were dispatched as a refresh batch and a ref needs more"
- cite: plugins/ok/families/ok-planner/skills/_shared/implementation-auditor.md :: "Exhibitions are precedent under the same rule"
- cite-span: plugins/ok/families/ok-planner/skills/_shared/implementation-auditor.md :: "     citations, the determination the claims add up to, the Notes" +15 sha256:ddc8e885f36e
- cite: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "The fixer never edits an audit file"
- cite-span: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "**The two-layer re-audit trigger, stated once for both gates.**" +1 sha256:9b77fdd72dad
- cite: plugins/ok/families/ok-planner/skills/certify-all/SKILL.md :: "the full gate's scope is coverage: every determination is revisited"
- cite: plugins/ok/families/ok-planner/skills/prove/SKILL.md :: "Decisions carry no proofs; their verification is the implementation audit."
- cite: .ok-planner/design/concepts/decision-artifact.md :: "It owns no verification of its own: it carries no proof and states no separate falsifier"
- cite: .claude/skills/release/SKILL.md :: "No implementation audit goes stale — the vendored checker masks exactly these stamps"
- cite: plugins/ok/families/ok-planner/scripts/hooks/session-start :: "context="ok-planner v{{OK_PLANNER_VERSION}} is materialized in this project."
- cite-span: plugins/ok/families/ok-planner/admin/converge :: "    sed "s/{{OK_PLANNER_VERSION}}/${SUITE_VERSION}/g" "$SOURCE_GRAPH" > "${OK_DIR}/bin/source-graph"" +2 sha256:710a9e6e0dae
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
- cite-file: .ok-planner/design/stories.md @ sha256:91082b1260bc
- cite-file: .ok-planner/design/decisions.md @ sha256:b99bc4b30284
