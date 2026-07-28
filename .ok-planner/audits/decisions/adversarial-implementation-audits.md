---
audit: adversarial-implementation-audits
artifact: decision:adversarial-implementation-audits
determination: satisfied
audited: 2026-07-28T00:00:00Z
artifact-hash: sha256:58601127b06e
---

# Whether implementation claims are verified by durable adversarial audits with node-and-anchor citations, mechanical staleness plus adjudicated nominations, and a mask that survives a release

The design artifact is unchanged since the prior cycle (hash
identical), so its determinations bind absent moved reality. What moved
is the plumbline converge core, pinned whole below as one of the three
enumeration sources for the masking quantifier: its module-marker write
changed mechanism. The masking clause was therefore re-enumerated
against that core rather than carried, and the release demonstration was
re-run on the tree as it now stands. This audit carries no `## Notes`
ledger — no change inspection has ever implicated it — so none is
carried forward and none is opened here.

## Claims

**Title — "Implementation claims are verified by adversarial audits, not
test mandates."** Both halves hold. The auditor is a canonical shared
prompt block dispatched by both gates, written as a refutation exercise
("Your bias is adversarial: you are trying to REFUTE the claim"). No
skill anywhere mandates a registered test per claim; the only runtime
obligation in the corpus is the story proof, and decisions are stated to
carry none.

**"a durable, per-artifact determination (`satisfied` or `violated`)
recorded in a fourth corpus collection."** Honored mechanically. The
checker hard-codes exactly the two determination values and rejects
anything else as `audit-malformed`; the collection is
`.ok-planner/audits/{stories,decisions}/`; the live population is derived
from `.ok-planner/design/{stories,decisions}/` so both directions are
covered (`audit-missing` / `audit-orphaned`); and placement itself is
checked — an audit whose `artifact:` ref disagrees with its directory or
basename is malformed. Verified against reality on this tree: the live
population is seventeen stories and twenty-two decisions, every one of
them carries a file at the matching path, and the checker names no
`audit-missing` and no `audit-orphaned` ref.

**"written only by a certification producer that did not implement the
work under audit, and never hand-edited."** Enforced at the only layer a
prompt-executed system can enforce it: the auditor file states author
separation as load-bearing, and the certification core bars the fixer
from editing an audit file at all. Nothing mechanical prevents a
hand-write — a recognised limit of a prompt-enforced regime, stated at
every point that could violate it, and the one place a machine can help
(`checks/oscillation`) reads git history for determinations that flipped
while the artifact hash and every citation stood still.

**"Audits cite the source graph by node identity and content hash — span
anchors within a node where finer resolution carries the verdict — and
pin quantified claims' population sources whole."** Honored, four
citation tiers implemented and machine-read. `cite-node:` resolves
`<path>` or `<path>#<chain>` through the committed graph and compares
against the hash the graph records (masked where the graph records a
masked one); `cite-span:` anchors within a node, content-hashed, with
`anchor-ambiguous` when the anchor is not unique; `cite:` is bare
existence; `cite-file:` is the pre-graph whole-file population pin, whose
graph-era equivalent is a whole-file `cite-node:`. No citation form
records a line number anywhere. The helper subcommands emit the same four
shapes under the same mask the checker applies, so an emitted line and a
checked line cannot disagree. `cite-node` additionally refuses to emit
through a graph that no longer describes the tree.

This project carries no committed graph yet (pre-genesis by the sprint's
own recorded sequencing), so this corpus — including this file — uses the
anchor forms throughout; that is the migration path the Choice's own
"corpora not yet re-homed onto the graph" wording provides for, not a
gap. The node path is exercised rather than merely present: six harness
cases drive it end to end, and the extractor was run over the real
249-file tree of this repository (in a scratch copy) with `check` exiting
0 afterwards.

**"a deterministic checker flags any audit whose design artifact or cited
nodes have changed."** Honored, and exhibited on this tree rather than
asserted: entering this batch, `audit-check` reported fourteen findings
over three distinct anchor-based staleness triggers plus one
`violated-unlinked`, all of them traced to the single upstream fix this
cycle landed — `cite-file:` population sources whose bytes moved (the
plumbline converge core and the plumbline binary), a bare `cite:` anchor
line that was deleted (the core's old `printf`), and a `cite-span:`
anchor that stopped appearing (the rewritten diagnose block). Crucially
`--list-stale` named exactly eight refs, which is exactly the set this
batch was convened to re-derive — including audits *outside* the change's
own territory (`ratchet-over-soft-start`,
`comments-forbidden-by-default`), which is the property the Choice claims
and the reason those two were re-derived at all. The artifact-hash
trigger and the node triggers are held by fixtures instead: no design
artifact moved this cycle, and no audit here cites a node yet. A content
change under a rebuilt graph trips
`audit-stale-citation`; a renamed declaration trips "no longer resolves";
and an un-rebuilt or absent graph is reported as its own `graph-stale` /
`graph-missing` finding rather than passed silently.

**"and the re-audit set is that stale set plus the change-inspection
nominations the auditor adjudicates."** Honored in both gates and in the
shared core. `certify-work` defines the re-audit set as the union of the
touched artifacts, every ref `--list-stale` names (explicitly including
audits outside the delta), and every audit the inspector nominated — "and
nothing else; code annotations play no part in it". `certify-all`
re-derives every determination fresh and still runs the inspector so the
nominations and ledger are recorded. The core's re-review step recomputes
the same union after every fix cycle. `--list-stale` is implemented as
the machine-readable projection of exactly the refs `check_audit` marked
stale.

**"The checker masks release-mutable metadata — the suite-version stamp
lines materialization writes and the plugin manifests' version fields —
before hashing anything a citation or pin covers, so a release that
changes only versions voids no audit."** Honored, and the population was
re-enumerated from reality rather than from the artifact's wording. The
stamp-writing mechanisms are every version-substitution site in all three
carried families' converge cores, whose whole files are pinned below:
the planner core's six `sed "s/{{OK_PLANNER_VERSION}}/…/g"` passes
(estate CLAUDE.md, the cheatsheet, `surface-corpus`, `audit-check`,
`source-graph`, and the session hook) plus its python vendor
layer's `STAMP` constant; the plumbline core's cheatsheet and post-edit
substitutions, its `const VERSION = '0.0.0-unvendored'` rewrite, and its
binary's vendored-skill stamp; the workspaces `converge.js` `stamp()`
helper over src-tag and port-block plus its three generated stamp strings;
and the two `.claude-plugin/plugin.json` manifests. All are covered by the
four mask rules (`Materialized by … v<semver>`, a `VERSION = "…"`
assignment, a `"version"` field in a plugin manifest, and any `v<semver>`
on a line naming an `ok-*` family).

Re-enumerated specifically against the core that moved: the plumbline
edit added a *fourth* write to that core and no fourth substitution site.
`node "$BIN" module-marker` emits a fixed literal, consults no version,
and produces a file the mask has nothing to do with — so the stamp
population is unchanged at the count above, and the changed bytes of the
core and of the binary carry no release-mutable metadata in their payload
form (the binary's `const VERSION = '0.0.0-unvendored'` is rewritten only
in the vendored copy, never in the payload).

The claim was then exercised end to end on the tree as it now stands
rather than argued member by member, and the demonstration was re-run
this cycle rather than carried. A scratch copy of the working tree had
both manifests bumped `11.0.0` → `11.0.1` by an in-place `sed` on the
`version` field and the planner converge core re-run — precisely the
release act's step 5c. Twenty-three files changed, including the vendored
`.ok-planner/bin/source-graph`. Every one of the twenty-three hashes
identically under the checker's own `masked_file_hash` before and after —
zero divergences — and `audit-check` over the released tree returns a
finding set byte-identical to the baseline: the same fourteen findings,
line for line, not one more and not one fewer.
The harness holds the same property from both sides: `masked-version-bump`
carries all five stamp shapes two releases ahead of the audit citing them
and must exit 0, its twin `masked-edit-trips` carries a non-version edit
on each of those same five surfaces and must trip, and
`node-masked-bump` carries the node-citation case.

**"before hashing anything a citation or pin covers."** Honored including
the non-text case, where masking could have quietly weakened a pin:
`masked_file_hash` decodes strictly and, on `UnicodeDecodeError`, hashes
raw bytes rather than decoding lossily — a lossy decode is not injective,
and the `binary-pin-changed` fixture's two blobs differ only in invalid
UTF-8 that `errors="replace"` would collapse. Both directions are held
(the fixture must trip; the `clean` fixture's binary pin must not).
`source-graph` carries a byte-compatible copy of the same mask and records
a `masked:` hash only where masking changes the bytes, which is what makes
an emitted `cite-node:` line and a checked one agree.

One honest limit, recorded and not charged, because no sentence of the
artifact claims otherwise: the freshness gate `cite-node:` resolution runs
first compares the graph's recorded *exact* file hash against the tree, so
on a graph-carrying project a version-only release makes the committed
graph stale until `source-graph build` is re-run — at which point the
masked node hashes are unchanged and no citation moves. Both gates mandate
that rebuild before judging citations, and the release skill's claim is
about the checker's hashing, which is masked as stated. If the Choice were
ever tightened to say a release voids nothing *without* regenerating
generated state, this becomes a violation.

A second recorded limit, likewise not charged: the family-scoped rule
masks a strict superset of the stamp population — any `v<semver>` on any
line naming an `ok-*` family, whether a materialized stamp or an ordinary
literal. No sentence claims the mask is minimal. If one is ever added,
this flips.

**"Stories additionally carry deterministic integration-test proofs;
decisions carry no test obligation."** Honored as the obligation each kind
bears, with both populations re-enumerated from reality (catalogs pinned
below): all seventeen live stories carry a `## Proof` section — including
the new `deterministic-source-graph` — and none of the twenty-two live
decisions carries one. The shared definitions file states "Decisions are
audited, not proof-mandated", and `/prove` says the same from the running
end.

**"A negative determination stands in place until a re-audit flips it, and
blocks certification unless linked to an intake issue awaiting the owner's
ruling."** Honored mechanically: `violated` with no `issue:` produces
`violated-unlinked`; `violated` with an `issue:` naming no file under
`issues/` or `history/issues/` produces `issue-link-dangling`; and both
fixture directions (`violated-unlinked` must trip, `violated-linked` must
not) are held. Nothing deletes a negative audit — the auditor overwrites
whole and the fixer is barred from touching the file.

**Rationale — "the fixer cannot satisfy an audit by any means except
changing the code it cites, which moves the hashes of the nodes it cites
and forces a fresh adversarial read."** Holds by exhaustion of the
alternatives, each closed at a citable point: editing the audit is
prohibited in both the auditor file and the certification core; leaving
the code alone leaves a standing `violated-unlinked` finding blocking the
gate; editing the design artifact instead trips `audit-stale-artifact`.

**Rationale — "the judged inspection layer covers the one blindness
citations keep — work added beside a cited span breaks no hash, so an
agent reads the change itself and its nominations reach the auditor as
recorded, adjudicable candidates."** Honored: the change inspector prompt
exists in the shared core, is dispatched by both gates and again at every
re-review, records nominations as provisional notes, and is explicitly
candidacy ("You nominate; you never invalidate"). The auditor's method
step 0 is the adjudication side.

**Rationale — "Version stamps sit inside otherwise-cited bytes and must
change on every release, so masking them is what keeps the tripwire
meaningful: staleness signals substantive change, never the release act,
while any edit beyond the masked patterns still breaks its anchor."**
Honored on both halves — the release half by the twenty-three-file
demonstration above, the second half by five harness cases and by the live
corpus, where every one of the fourteen findings this batch inherited
traces to a substantive edit (the module-marker fix) and none to a version
change.

**Alternatives — "Hashing stamped bytes as-is and re-auditing at release
time."** A genuine road not taken and negated in the code: the release
skill states that the checker's masking is precisely why the release
dispatches no agent, re-derives no audit, and never writes
`.ok-planner/audits/`.

## Determination

**satisfied.** The whole regime is implemented in one deterministic
checker both gates consume as their clean bar — two determination values,
four citation tiers including the new node pin, staleness triggers on the
artifact hash, node identity, node hash, anchor, span and file pin, the
`graph-missing` / `graph-stale` findings that refuse a silent pass,
missing/orphaned/malformed findings, the `violated-unlinked` block, and
`--list-stale` as the machine-readable floor of the re-audit set — with
the judged inspection layer and its recorded adjudications supplying the
rest of that set. The masking clause was re-derived against the tree as it
now stands (all three converge cores, both manifests, six planner
substitution sites, and the plumbline core's three — unchanged in count by
this cycle's edit, which added a write that carries no version) and then
exhibited: a simulated version-only release rewrote twenty-three files
with zero masked-hash divergences and a byte-identical finding set. The
staleness machinery was exhibited on the live corpus as well: the one
upstream fix this cycle landed tripped fourteen findings and put exactly
eight refs on `--list-stale`, two of them audits the fix's own territory
does not contain — which is the out-of-delta reach the Choice claims. The
asymmetric proof obligation holds over both live populations, seventeen
and twenty-two.

This determination stops holding if: a new materialization site writes a
stamp in a shape none of the four masks covers (the whole-file pins on all
three converge cores break when any gains a substitution site, and the
pinned spans over the four mask definitions break if the masks move); the
harness's masked, binary, or node fixtures are deleted or weakened (the
whole-file pin on `test/run.sh` and the anchors on its `run_case` lines
break first); `masked_file_hash` stops decoding strictly, so a binary pin
becomes forgeable; `source-graph`'s mask stops being byte-compatible with
`audit-check`'s, so an emitted node citation and a checked one could
disagree; the fixer's bar on editing audit files is removed; `--list-stale`
stops being the mechanical floor the gates consume, or the inspector's
nominations stop joining it; or a story lands without a `## Proof` section
or a decision acquires one (the catalog pins break). It flips to violated
if the Choice or Rationale is tightened to claim the mask covers *only*
release-mutable metadata, or that a release voids nothing without
regenerating the committed graph.

## Citations

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
- cite-span: plugins/ok/families/ok-planner/skills/_shared/implementation-auditor.md :: "     citations, the determination the claims add up to, the Notes" +15 sha256:ddc8e885f36e
- cite: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "The fixer never edits an audit file"
- cite-span: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "**The two-layer re-audit trigger, stated once for both gates.**" +1 sha256:9b77fdd72dad
- cite-span: plugins/ok/families/ok-planner/skills/certify-work/SKILL.md :: "   - **Implementation audit, two layers.**" +1 sha256:62a96e92cc0f
- cite-span: plugins/ok/families/ok-planner/skills/certify-all/SKILL.md :: "   - **Implementation audit, whole-corpus.**" +1 sha256:ca40b8632807
- cite: plugins/ok/families/ok-planner/skills/certify-all/SKILL.md :: "the full gate re-derives every determination fresh"
- cite: plugins/ok/families/ok-planner/skills/prove/SKILL.md :: "Decisions carry no proofs; their verification is the implementation audit."
- cite: .claude/skills/release/SKILL.md :: "No implementation audit goes stale — the vendored checker masks exactly these stamps"
- cite: plugins/ok/families/ok-planner/scripts/hooks/session-start :: "context="ok-planner v{{OK_PLANNER_VERSION}} is materialized in this project."
- cite-span: plugins/ok/families/ok-planner/admin/converge :: "    sed "s/{{OK_PLANNER_VERSION}}/${SUITE_VERSION}/g" "$SOURCE_GRAPH" > "${OK_DIR}/bin/source-graph"" +2 sha256:710a9e6e0dae
- cite: plugins/ok/families/ok-workspaces/scripts/src-tag :: "# ok-workspaces canonical src-tag script v{{OK_WORKSPACES_VERSION}}."
- cite: plugins/ok/families/ok-planner/test/run.sh :: "run_case "version bump masked""
- cite: plugins/ok/families/ok-planner/test/run.sh :: "run_case "binary pin change trips""
- cite: plugins/ok/families/ok-planner/test/run.sh :: "run_case "node citation clean""
- cite: plugins/ok/families/ok-planner/test/run.sh :: "run_case "stale graph is a finding""
- cite: plugins/ok/families/ok-planner/test/run.sh :: "run_case "node stamp bump masked""
- cite: plugins/ok/families/ok-planner/test/run.sh :: "run_case "re-audit set""
- cite-span: checks/oscillation :: "def audit_flips():" +28 sha256:73bc4b08d1f8
- cite-file: .ok-planner/design/stories.md @ sha256:91082b1260bc
- cite-file: .ok-planner/design/decisions.md @ sha256:b99bc4b30284
- cite-file: plugins/ok/families/ok-planner/test/run.sh @ sha256:8c0006755840
- cite-file: plugins/ok/families/ok-planner/admin/converge @ sha256:144ab87e08af
- cite-file: plugins/ok/families/ok-plumbline/admin/converge @ sha256:8ddee7fdc360
- cite-file: plugins/ok/families/ok-workspaces/scripts/converge.js @ sha256:86092f273c39
- cite-file: plugins/ok/.claude-plugin/plugin.json @ sha256:6ec970155f6e
- cite-file: plugins/ok-conduct/.claude-plugin/plugin.json @ sha256:7daa2bb3af13
