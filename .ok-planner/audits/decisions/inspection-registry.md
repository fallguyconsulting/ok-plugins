---
audit: inspection-registry
artifact: decision:inspection-registry
determination: satisfied
audited: 2026-07-29T08:19:19Z
artifact-hash: sha256:6404bf8652d6
---

# Whether the change inspection's state is a permanent node-keyed, hash-pinned registry whose closure floor makes a skipped judgment pass a mechanical failure

Rewritten whole. The design artifact's hash is unchanged
(`sha256:6404bf8652d6`), so precedent did not lapse — but the fix cycle
since the standing `violated` landed directly on the two claim lines
that determination rested on, so both are re-derived from the code
rather than refreshed. The prior determination charged the closure
floor's universal quantifier: changed bytes lying outside every declared
unit of a unit-bearing file entered the changed set nowhere, and the
committed half of a range-scoped run got no floor at all. Both are now
closed in the canonical checker, in both directions, with fixtures
holding each direction separately. Everything the prior pass found
delivered was re-derived and still holds.

Refreshed again. The design artifact's hash is unchanged. Six whole-file
pins moved this pass — `certification-core.md`, `certify-work/SKILL.md`,
`certify-all/SKILL.md`, `plan-sprint/SKILL.md`, and `test/proofs.sh` — plus
`certify-work`'s `#process` node, all from the owner-ratified rewording of
the review-fix loop's cycle cap (the exit rule's choice between another
cycle and escalating is now stated as the owner's alone with no unattended
default, and each gate's close-out sentence repoints accordingly). None of
that touches this decision's own territory: the closure-floor sentence, the
`--inspection=<base>` scope extension, the registry format, and the three
consuming clean bars are all in different paragraphs from the cap text and
are byte-identical to what this audit already read (`certify-work`'s clean
bar sentence and its `--inspection=<base>` clause, `plan-sprint`'s
completion-contract item 3, both untouched).

One citation is not mere hash noise and was read rather than assumed: the
`test/proofs.sh` span pinning the `certify-completion` story's proof section
grew substantially (a `+159`-line span), because this cycle's fixer added a
parallel, deterministic exhibition of this decision's own closure-floor
claim through a different harness — a scratch repository is built, a new
function and file are added, `audit-check --inspection` is run with no
registry (asserted to fail with an `inspection-` finding, the vacuous-clean
case this decision forecloses), then an `inspection.md` registry is written
with `residue` entries covering both the new function's node and the file's
own node (via `cite-node` for each), and the same command is asserted to
exit 0. Read directly against the mechanism this audit already verified
(`INSPECTION_CLASSES`, the residue/adjudicated-only parser, the
liveness test), the new exhibition is consistent with it and adds a second,
independent demonstration of the same already-satisfied claim rather than
contradicting it — no claim or the determination moves. Citations
regenerated; nothing else touched.

## Claims

**Title — "The change inspection's state is a permanent node-keyed
registry, not a per-run receipt."** Honored on all three elements, each
re-checked rather than carried. Permanent: the file is committed estate
content — the estate's own ignore file excludes only `browser/` and
`proof-timings.json`, so `audits/inspection.md` is tracked, and the
inspector's step 4b carries live entries forward rather than rewriting
the file per pass. Node-keyed: the parser's entry grammar is
`- node: <identity> @ sha256:<12 hex>` and identities resolve through the
same committed graph the citations use. Not a per-run receipt: nothing
in the format or in `check_inspection` references the diff, the run, or
any content address over the change — liveness is per entry, against the
current graph.

**"The judgment layer's durable state is one committed registry file in
the audit corpus."** Honored: one path, `.ok-planner/audits/inspection.md`,
hard-coded once as `INSPECTION_REL` and named identically in the
canonical format block, in the inspector's steps 3 and 4b, and in both
gates' clean bars. No second location exists to drift against. Live on
this tree with five entries — four `adjudicated` pointing at
`story:explain-lint-rules`, one `residue`.

**"written only by certification's change inspector."** Honored to the
degree a prompt-executed system can enforce authorship, and stated at
every point that could violate it: the canonical format block says
"Written only by certification's change inspector, never hand-edited",
the inspector claims the file as its own durable state, and the checker
is explicitly barred from judging content. Recorded as a limit rather
than charged, exactly as the prior pass did and for the same reason: no
sentence in the Choice claims a *mechanical* authorship bar, and this is
the same class of prompt-level rule the corpus already accepts for the
audit files themselves.

**"entries keyed to source-graph node identities and pinned to the
node's recorded content hash."** Honored, and the pin is the graph's
*recorded* hash rather than a freshly computed one, which is what makes
it comparable to a `cite-node:` pin. `check_inspection` resolves each
entry's identity through `load_graph` on the identity's path and tests
`erows[identity] == pin`; the masked value is used where the graph
records one, so the same release-metadata masking that governs citations
governs entries.

**"storing only the judged classes — residue … and adjudication
pointers … — never the mechanical disposition, which is recomputable."**
Honored in both directions. Positively: `INSPECTION_CLASSES =
("residue", "adjudicated")`. Negatively: any other class — `mechanical`
included — is `inspection-malformed` and the entry is dropped, so the
record cannot acquire the recomputable rows even by accident. The
adjudication pointer is a real pointer: an `adjudicated` entry must
carry an `audit:` matching `^(story|decision):[a-z0-9-]+$` **and**
naming an existing file under `.ok-planner/audits/{stories,decisions}/`.
And the mechanical disposition genuinely is recomputed — `check_inspection`
takes the citation-derived `stale_files` / `stale_identities` sets
computed moments earlier by `check_audit` and decides accounting by
`identity_contains` containment.

**"Entries carry audit-style precedent semantics: an entry stands while
its pin holds and lapses when the node's content moves or its identity
vanishes."** Honored exactly as stated: liveness is
`eerr is None and identity in erows and erows[identity] == pin`, so
content-moved and identity-vanished are the two failure branches and
both drop the entry. Held from both sides by fixtures — `inspection:
residue entry covers` must exit 0 with a matching pin, `inspection:
lapsed entry trips` must produce `inspection-unclassified` once the pin
no longer matches.

**"so the registry rides forward cycle to cycle and sprint to sprint,
and each inspection pass works only the unclassified new work."**
Honored: the inspector carries live entries forward untouched, never
re-judges a live entry, prunes entries whose identities vanished, and
re-judges lapsed ones. The sprint-to-sprint half is a property of the
baseline — the changed set is computed against the graph at the baseline
ref, so once a sprint's work commits its nodes leave the changed set
while their entries remain.

**"The vendored checker enforces the closure floor mechanically: every
source node the change touched is accounted — by a stale citation or a
live entry — or the gate fails, and a missing registry with changed
nodes fails the same way, so a skipped judgment pass is a mechanical
failure, never a vacuous clean." NOW HONORED, quantifier included.**
This is the sentence the standing determination turned on, so it is
taken apart clause by clause.

*Subject — "the vendored checker."* Judged against the canonical the
release vendors, `scripts/audit-check`, which is what converge
materializes to a consumer's `.ok-planner/bin/audit-check`. In *this*
repository the vendored copy is one converge behind the family source
(it carries the pre-repair `git_changed_sources(root)` and no
outside-units accounting), and that lag is governed rather than a
defect: `decision:per-project-pinning` fixes that "Updating the
front-door plugin changes nothing in any project until its owner
converges deliberately", and `checks/vendored-layer` pins this repo's
vendored layer to the last commit precisely so a working session cannot
re-vendor mid-flight — it exits 0 on this tree, so the layer is exactly
where the discipline requires it to be. Treating the in-flight lag as a
violation of the Choice would make the discipline and the decision
mutually unsatisfiable; the honest subject is the shipped canonical.

*Failure path.* Mechanical and non-zero: `inspection-unclassified` for a
changed node with neither a mechanical account nor a live entry,
`inspection-missing` when changed nodes exist and no registry does,
`inspection-malformed` for a bad entry or a dangling audit pointer, with
`main()` returning 2 on any finding and 1 when `check_inspection` cannot
run at all.

*"Or the gate fails."* Real at three consuming sites in near-identical
words — `certify-work`'s and `certify-all`'s implementation-audit clean
bars both require `audit-check --inspection` to exit 0, and the ceremony
bakes it into completion-contract item 3, so an executor's stop
condition depends on it too.

*The quantifier — "every source node the change touched."* This is what
moved. The judged population is now computed as: every declared unit
whose recorded hash moved, **plus the file's own node whenever the
region outside every declared unit moved**. That region is not inferred
from which units moved — it is computed on both sides and compared.
`outside_units_hash` excises every declared-unit span from the file and
hashes the remainder under the same release mask citations use;
`outside_units_moved` computes it for the working tree and for
`git show <baseline>:<path>` and compares, treating a file the baseline
does not carry as an empty region so a new file's non-unit content
counts as moved. Knowing what a declared unit *is* is not restated: the
floor loads `declared_unit_spans` from the sibling `source-graph`
extractor, so the floor's granularity cannot drift from the graph's, and
every failure to load or compute answers `True` — the file node enters
the changed set rather than a byte going unwatched (no extractor, an
extractor predating the entry point, an adapter raising, an unreadable
file, a non-UTF-8 file, a file that declares no units at all). The
population where this was previously blind was re-enumerated from the
committed graph, not assumed: 268 graph mirrors, 152 of them carrying at
least one unit row. All 152 now have their outside-unit region watched,
and the concrete instance the prior audit verified —
`.claude/skills/certify-work/SKILL.md`, whose `name:` / `description:`
frontmatter precedes its first heading and which no audit cites — is
covered by exactly that path, as is `test/proofs.sh`'s top-level
assertion surface.

Four fixtures hold the four directions this rule has to get right, and
they are four because no single one distinguishes them: an
outside-units-only change with no registry at all must fail
(`inspection: outside-units change is no vacuous clean` — the specific
vacuous clean the sentence forecloses), the same change must still be
demanded when an unrelated entry exists (`… needs a disposition`) and
must be closed by a file-node entry (`… a file-node entry covers the
outside-units region`), a pure in-unit edit must **not** demand a
file-node disposition (`… a pure in-unit edit needs no file-node
disposition` — the regression the naive fix would introduce, costing the
floor its unit granularity), and a change touching a unit *and* the
outside region must demand both (`… a unit edit does not absorb the
outside-units bytes`, then `… both nodes dispositioned closes the
combined change`). Two more hold the new-file case in both directions.

*Scope — the committed half of a range-scoped run.* Also closed.
`git_changed_sources(root, base)` unions `git status --porcelain -uall`
with `git diff --name-status <base>`, `baseline_graph_rows(root, rel,
ref)` reads the graph mirror as of that ref rather than always HEAD,
`check_inspection` takes `base` and defaults `baseline` to `HEAD`, and
`main()` parses `--inspection=<base>`. The gate passes it: `certify-work`
now says the bar is "invoked as `--inspection=<base>` with the range's
base ref where this run's subject is a commit range, so the floor judges
the committed half of its own subject too", closing the exact hole the
prior pass charged (the gate offering a commit range as its subject and
then applying a tree-only floor). `certify-all`'s subject is the
uncommitted tree by its own definition, so bare `--inspection` is
correct there. Fail-closed rather than fail-open on the new input: an
unresolvable base makes both `git_changed_sources` and the `rev-parse`
guard fail, `check_inspection` returns False and `main()` exits 1, held
by `inspection: an unresolvable base ref fails closed`. Three fixtures
hold the scope rule — a committed change leaves the tree-scoped floor
clean, the same change surfaces under `--inspection=<base>`, and a bad
base exits 1.

*Boundary examined and not charged: deletions.* `git_changed_sources`
excludes deletions (`"D" in status`, `D` in the diff, and an
`os.path.isfile` guard), so a delete-only change contributes nothing to
the floor. This is not a gap in the sentence, because the Choice's own
model handles disappearance by lapse rather than by disposition: an
entry "lapses when the node's content moves **or its identity
vanishes**", and the inspector is instructed to *prune* entries whose
identities vanished. A deleted file has no node in the current graph to
key or pin, so there is nothing the registry could hold for it; where an
audit cited it, `check_audit` raises `graph-missing` or an unresolvable
identity and the citation floor covers it. Recorded here so a later pass
does not have to re-derive it.

**"Standing residue is reported to the owner as intake material and
served to the project's local corpus view."** Honored on both
destinations, each checked separately. Owner-facing: the inspector's
report step requires the residue enumerated one line each as intake
material, and the presentation's Reconciliation ledger is the terminus —
residue enumerated, never silently dropped — named by both gates' Present
steps. View-facing: `corpus-view` serves `/api/inspection`, whose handler
parses the registry fresh per request and marks each entry live or lapsed
against the current committed graph; `Overview.svelte` filters
`class === 'residue'` and renders a standing-residue section; and the
release-built bundle a consumer actually receives —
`browser/dist/assets/index-CSM9Eawd.js`, unmoved this cycle — carries
both the fetch and the rendered copy, so the claim is not true of the
source only.

**Rationale — "The gate's judgment layer used to live only in
conversation … a skipped pass and a clean pass were indistinguishable,
and a goal-seeking orchestrator took the early-out."** Historical
motivation rather than a claim on current code, and consistent with what
exists.

**Rationale — "A durable record fixes that only if the checker can tell
whether the record covers the change at hand, which is what node keys
and hash pins buy: coverage is computed against the same committed graph
the citations use, unit by unit."** This is the Rationale's own
capability claim and the one the prior pass found contradicted, because
"unit by unit" was exactly the shape that left the region outside every
unit uncovered. It now holds: coverage is still computed against the same
committed graph and still at unit granularity where units exist, but the
region no unit covers is computed and compared as its own subject, so
the checker can in fact tell. The code says so in its own words and the
canonical rules block says the same thing to the consumer.

**Rationale — "Storing only the judged classes keeps the registry small
and honest — the mechanical account is recomputable at any moment, so
storing it would only let it go stale."** Honored: recomputed from
`check_audit`'s stale sets every run, and the parser refuses any class
outside the two judged ones.

**Rationale — "precedent semantics make maintenance incremental: last
sprint's residue rides forward untouched until the code it names
actually changes, the same convergence property recorded adjudications
already rely on."** Honored; the liveness test is the same
pin-still-matches test an audit citation uses.

**Alternatives.** All three name genuine roads not taken and none is
secretly in force. A per-run receipt content-addressed to the diff: no
such artifact exists, and nothing in the format or the checker
references the diff's identity. Storing every disposition including
mechanical ones: refused by the parser. In-context reporting only:
superseded by the committed file and the checker that reads it — and now
superseded for every class of change, which is what the prior pass could
not say.

## Determination

**satisfied.** The standing `violated` rested on one claim line — the
closure-floor sentence's quantifier, and with it the Rationale's "the
checker can tell whether the record covers the change at hand" — and the
flip condition that audit stated was that "the floor's population
matches the sentence: the file node accounted for when a change moves it
while no unit hash moves … and the changed set derived from the gate's
actual subject rather than from `git status` alone when a commit range is
in scope." Both are met in the canonical checker, and met in the stronger
form rather than the cheap one: the outside-unit region is *computed and
compared* rather than inferred from unit movement, which is what lets the
floor demand the file node for a combined unit-plus-outside change
without also demanding it for a pure in-unit edit; and the range scope is
threaded end to end — checker flag, changed-set union, baseline graph
ref, and the gate's own instruction to pass it — with every unavailability
answering conservatively and an unresolvable base exiting non-zero rather
than clean. Nine fixtures hold the floor's directions, six of them new,
including the exact vacuous clean the sentence forecloses.

Everything the prior pass found delivered was re-derived and holds: one
committed registry at a single hard-coded path; a single writer named at
every surface; node-keyed, graph-resolved, hash-pinned entries; judged
classes only with the mechanical account recomputed and any attempt to
store it rejected as malformed; adjudication pointers validated against
real audit files; precedent semantics with lapse on moved content or
vanished identity; incremental maintenance instructions; a mechanical
failure path with three named findings and a non-zero exit; three
consuming sites including the ceremony's baked completion contract; and
standing residue reaching both the owner's presentation and the corpus
view, verified through to the built bundle.

One thing a reader should not mistake for a violation: this repository's
own `.ok-planner/bin/audit-check` still carries the pre-repair floor. That
is the vendored layer doing exactly what `decision:per-project-pinning`
and `checks/vendored-layer` (green on this tree) require of it between a
release and the next deliberate converge; the Choice's "vendored checker"
is judged against the canonical the release vendors.

This would stop being satisfied if: the registry moved off
`.ok-planner/audits/inspection.md`, or a second location appeared; the
estate's ignore file started excluding it, so "committed" became false;
`INSPECTION_CLASSES` gained a mechanical class, or the parser stopped
requiring an `adjudicated` entry's `audit:` to name a live audit file;
the liveness test stopped comparing the pin against the graph's recorded
hash; `outside_units_moved` or `outside_units_hash` were removed, or
either stopped answering conservatively when the region cannot be
computed, or the floor stopped loading `declared_unit_spans` from the
extractor and restated unit boundaries locally (so the two could drift);
`git_changed_sources` lost its `base` union or `baseline_graph_rows` lost
its `ref`, or `certify-work` stopped instructing `--inspection=<base>`
for a range-scoped run, or the unresolvable-base guard stopped exiting
non-zero; either gate dropped `--inspection` from its clean bar, or the
ceremony dropped completion-contract item 3; the inspector's step 4b or
its carry-forward/prune/re-judge instructions were removed; any of the
nine `inspection:` fixtures were deleted or weakened — in particular the
pure-in-unit-edit one, whose whole job is to catch a floor that bought
completeness by giving up unit granularity; or `corpus-view` stopped
serving `/api/inspection`, or the view or the released bundle stopped
rendering the residue list.

## Citations

- cite-node: plugins/ok/families/ok-planner/scripts/audit-check @ sha256:32b1732e3fdd
- cite-node: plugins/ok/families/ok-planner/scripts/source-graph @ sha256:e293c0d31163
- cite-node: plugins/ok/families/ok-planner/skills/_shared/artifact-definitions.md#shared-artifact-definitions.token-catalog.inspection-registry-format @ sha256:5f1c4527fd56
- cite-node: plugins/ok/families/ok-planner/skills/_shared/certification-core.md @ sha256:f42b50f44a66
- cite-node: plugins/ok/families/ok-planner/skills/_shared/certification-core.md#certification-core.how-consumers-use-this-file.change-inspector-prompt @ sha256:c1f9ccb49f08
- cite-node: plugins/ok/families/ok-planner/skills/_shared/certification-core.md#certification-core.how-consumers-use-this-file.certify-presentation @ sha256:b27fc9b325a6
- cite-node: plugins/ok/families/ok-planner/skills/certify-work/SKILL.md @ sha256:3fa398a77d5e
- cite-node: plugins/ok/families/ok-planner/skills/certify-work/SKILL.md#certify-the-work-the-change-scoped-gate.process @ sha256:ab43437dd800
- cite-node: plugins/ok/families/ok-planner/skills/certify-work/SKILL.md#certify-the-work-the-change-scoped-gate.scope @ sha256:133faeb4e2a1
- cite-node: plugins/ok/families/ok-planner/skills/certify-all/SKILL.md @ sha256:c4edf29db435
- cite-node: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md @ sha256:737bfc84a094
- cite-node: plugins/ok/families/ok-planner/scripts/corpus-view @ sha256:c985b50ad376
- cite-node: plugins/ok/families/ok-planner/browser/src/lib/api.js @ sha256:12ecd77eaa01
- cite-node: plugins/ok/families/ok-planner/browser/src/views/Overview.svelte @ sha256:c76108d97ac0
- cite-node: plugins/ok/families/ok-planner/browser/dist/assets/index-CSM9Eawd.js @ sha256:a6d2942e2799
- cite-node: plugins/ok/families/ok-planner/test/run.sh @ sha256:a4d8463946b0
- cite-node: plugins/ok/families/ok-planner/test/proofs.sh @ sha256:10f3b1e855fd
- cite-span: plugins/ok/families/ok-planner/scripts/audit-check :: "def check_inspection(root, findings, stale_files, stale_identities," +76 sha256:132cb08a382a
- cite-span: plugins/ok/families/ok-planner/scripts/audit-check :: "        # Judge at unit granularity where the file declares units: an" +16 sha256:de6822ea1136
- cite-span: plugins/ok/families/ok-planner/scripts/audit-check :: "# The judged population is every node whose hash moved, at unit" +17 sha256:2494b220d5e9
- cite-span: plugins/ok/families/ok-planner/scripts/audit-check :: "def outside_units_moved(root, rel, baseline, has_units):" +24 sha256:5fe5736a3cba
- cite-span: plugins/ok/families/ok-planner/scripts/audit-check :: "def outside_units_hash(rel, text):" +17 sha256:6e9f48633198
- cite-span: plugins/ok/families/ok-planner/scripts/audit-check :: "def declared_unit_spans(rel, lines):" +32 sha256:9d357a06f381
- cite-span: plugins/ok/families/ok-planner/scripts/audit-check :: "def git_changed_sources(root, base=None):" +40 sha256:a9f67e39dae4
- cite-span: plugins/ok/families/ok-planner/scripts/audit-check :: "def baseline_graph_rows(root, source_rel, ref):" +16 sha256:90077e7a763d
- cite-span: plugins/ok/families/ok-planner/scripts/audit-check :: "    inspection = False" +12 sha256:b9f579720e1e
- cite-span: plugins/ok/families/ok-planner/scripts/audit-check :: "def parse_inspection_registry(root, findings):" +54 sha256:291c5d011709
- cite-span: plugins/ok/families/ok-planner/scripts/audit-check :: "def identity_contains(container, identity):" +12 sha256:473033c84068
- cite-span: plugins/ok/families/ok-planner/scripts/audit-check :: "def load_graph(root, source_rel):" +35 sha256:1aacd02c60fc
- cite: plugins/ok/families/ok-planner/scripts/audit-check :: "INSPECTION_CLASSES = ("residue", "adjudicated")"
- cite-span: plugins/ok/families/ok-planner/scripts/source-graph :: "def declared_unit_spans(rel, lines):" +9 sha256:717f6aec996b
- cite: plugins/ok/families/ok-planner/scripts/ok-planner-gitignore :: "# Materialized by ok-planner v{{OK_PLANNER_VERSION}}. Suite-owned:"
- cite: plugins/ok/families/ok-planner/skills/_shared/artifact-definitions.md :: "It stores only the **judged** classes — the mechanical disposition is never stored"
- cite: plugins/ok/families/ok-planner/skills/_shared/artifact-definitions.md :: "Written only by certification's change inspector, never hand-edited; parseable by tooling (the dashboard reads its residue)."
- cite: plugins/ok/families/ok-planner/skills/_shared/artifact-definitions.md :: "The judged population is every node whose recorded hash moved"
- cite-span: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "  4b. Update the inspection registry per the format above: one" +12 sha256:4371ec2c3a2d
- cite-span: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "  3. Disposition the hunk:" +15 sha256:9b3cbeeaa602
- cite-span: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "## Reconciliation ledger" +8 sha256:b33ce3b03c6f
- cite: plugins/ok/families/ok-planner/skills/certify-work/SKILL.md :: "This producer's clean bar: `audit-check --inspection` exits 0"
- cite: plugins/ok/families/ok-planner/skills/certify-work/SKILL.md :: "invoked as `--inspection=<base>` with the range's base ref where this run's subject is a commit range"
- cite: plugins/ok/families/ok-planner/skills/certify-work/SKILL.md :: "**On request — a commit range.**"
- cite: plugins/ok/families/ok-planner/skills/certify-all/SKILL.md :: "Clean bar: `.ok-planner/bin/audit-check --inspection` exits 0"
- cite-span: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md :: "3. The implementation-audit corpus is current for everything the" +4 sha256:72227505dde8
- cite-span: plugins/ok/families/ok-planner/scripts/corpus-view :: "    def inspection_now(self):" +6 sha256:48119285ab48
- cite: plugins/ok/families/ok-planner/scripts/corpus-view :: "        if path == "/api/inspection":"
- cite-span: plugins/ok/families/ok-planner/test/run.sh :: "# The change-inspection floor (--inspection): every node the" +6 sha256:ad422cef347e
- cite: plugins/ok/families/ok-planner/test/run.sh :: "run_case "inspection: clean tree""
- cite: plugins/ok/families/ok-planner/test/run.sh :: "run_case "inspection: missing registry""
- cite: plugins/ok/families/ok-planner/test/run.sh :: "run_case "inspection: unclassified node""
- cite: plugins/ok/families/ok-planner/test/run.sh :: "run_case "inspection: lapsed entry trips""
- cite: plugins/ok/families/ok-planner/test/run.sh :: "run_case "inspection: mechanical account""
- cite: plugins/ok/families/ok-planner/test/run.sh :: "run_case "inspection: a new file's units leave its module-level content unaccounted""
- cite: plugins/ok/families/ok-planner/test/run.sh :: "run_case "inspection: residue entries cover a new file whole""
- cite: plugins/ok/families/ok-planner/test/run.sh :: "run_case "inspection: outside-units change is no vacuous clean""
- cite: plugins/ok/families/ok-planner/test/run.sh :: "run_case "inspection: outside-units change needs a disposition""
- cite: plugins/ok/families/ok-planner/test/run.sh :: "run_case "inspection: a file-node entry covers the outside-units region""
- cite: plugins/ok/families/ok-planner/test/run.sh :: "run_case "inspection: a pure in-unit edit needs no file-node disposition""
- cite: plugins/ok/families/ok-planner/test/run.sh :: "run_case "inspection: a unit edit does not absorb the outside-units bytes""
- cite: plugins/ok/families/ok-planner/test/run.sh :: "run_case "inspection: both nodes dispositioned closes the combined change""
- cite: plugins/ok/families/ok-planner/test/run.sh :: "run_case "inspection: a committed change leaves the tree-scoped floor clean""
- cite: plugins/ok/families/ok-planner/test/run.sh :: "run_case "inspection: the range-scoped floor sees the committed change""
- cite: plugins/ok/families/ok-planner/test/run.sh :: "run_case "inspection: an unresolvable base ref fails closed""
- cite-span: plugins/ok/families/ok-planner/test/proofs.sh :: "# --- certify-completion: the close leaves its record --------------------------" +159 sha256:49b44975d2e5
