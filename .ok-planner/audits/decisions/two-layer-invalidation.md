---
audit: two-layer-invalidation
artifact: decision:two-layer-invalidation
determination: satisfied
audited: 2026-07-29T08:19:19Z
artifact-hash: sha256:141749c18461
---

# Whether re-audit is triggered by citations plus a judged change inspection, with annotations playing no part — and whether the judgment layer's completeness is genuinely mechanical

Rewritten whole. The design artifact's hash is unchanged
(`sha256:141749c18461`), so precedent did not lapse — but the fix cycle
since the standing `violated` landed directly on the claim line that
determination rested on (the Choice's completeness sentence and, through
it, the Rationale's third bound), so it is re-derived from the code
rather than refreshed. The pre-existing clauses were re-derived too and
hold; the "never annotations" negative was re-enumerated over every
derivation from reality, including the floor's new inputs. The prior
pass's note stands below as history.

Refreshed again. The design artifact's hash is unchanged. Eight citations
moved this pass — `certification-core.md` and its `{{CERTIFY-REVIEW-FIX-LOOP}}`
node, `certify-work/SKILL.md` and its `#process` node, `certify-all/SKILL.md`
and its `#process` node, `ok-planner-CLAUDE.md`, and `test/proofs.sh` — all
from the owner-ratified rewording of the review-fix loop's cycle cap (the
exit rule's choice between another cycle and escalating is now stated as
the owner's alone with no unattended default, and each gate's close-out
sentence repoints accordingly, plus the estate guide's own goal-rule
paragraph gaining the matching "legal in-flight state" sentence). None of
that touches this decision's territory: the two-layer paragraph, the
touched-artifacts and re-audit-set derivations, the "never annotations"
enumeration's eleven derivation sites, and the closure-floor mechanism are
all in different sections and remain byte-identical, re-confirmed directly
— including the `#process` nodes' own producer-list content and the
re-review step's "4. **Re-review.**" span, neither touched. Citations
regenerated; nothing else touched.

## Claims

**Title — "Re-audit triggers are citations plus judged change
inspection, never annotations."** All three parts are separately
checkable and all three hold; each is taken below.

**"What forces an audit to be re-derived is two layers reading the same
source graph."** Honored as the stated architecture in the one place both
gates read it from: the certification core opens with the two-layer
paragraph, names `audit-check` as the mechanical layer and the change
inspector as the judgment layer, and closes "The gate's re-audit set is
always the union". Both layers read the same committed graph:
`audit-check` resolves `cite-node:` identities through `.ok-planner/graph/`
and refuses to judge through a graph that no longer matches the tree; the
inspector is handed the committed graph as an input and resolves each
hunk to the nodes it falls in, with containment encoded in identity.

**"The mechanical layer needs no review: a cited node identity that no
longer resolves, a cited content hash that moved, or a design artifact
whose own hash changed invalidates the audit outright."** Honored, and the
enumeration was checked against the checker rather than against the
sentence. `check_audit` sets `stale` on: a design artifact hash that no
longer matches `artifact-hash`; a `cite:` anchor that has vanished; a
`cite-span:` region whose content hash moved or whose anchor stopped
being unique; a `cite-file:` pin whose masked hash moved or whose file is
gone; and a `cite-node:` identity absent from the graph or whose recorded
hash moved. `graph-missing` and `graph-stale` also set `stale`, so a
citation that cannot be judged is never a silent pass. Every stale ref
lands in `stale_refs`, which `--list-stale` prints. Nothing in that path
consults an annotation, a filename convention, or any tag; six harness
fixtures hold the triggers directly, and the artifact-hash trigger fired
on this very batch (four artifacts amended by the in-flight sprint).

**"The judgment layer covers what anchors cannot see: an inspector reads
the change under certification — the diff itself, working tree or commit
range — and nominates the audits whose claimed closures contain changed
nodes."** Honored, and the "working tree or commit range" half is now
matched by the mechanical side as well as the judged one.
`{{CHANGE-INSPECTOR-PROMPT}}` exists once in the shared core, states the
blindness it exists to close in its own job section ("work added beside a
cited span breaks no hash"), and defines an audit's territory as its
Citations block's downward closure. Its `[CHANGE SCOPE]` slot is filled
by the consuming gate, and both scopes the Choice names are real:
`certify-work`'s subject is the uncommitted tree by default and a commit
range plus the tree on request, passed through verbatim; `certify-all`
fills the same slot with the uncommitted tree, explicitly so nominations
and the ledger are recorded even at full scope. The mechanical stale set
is handed to the inspector as already-handled territory, so the two
layers partition rather than duplicate.

**"nominations are recorded on the audits they implicate and adjudicated
by the auditor, never auto-invalidating."** Honored on all three counts.
Recording: inspector method step 4 appends a `- note:` /
`  adjudication: open (awaiting the next audit pass)` line pair to the
implicated audit's `## Notes` section, creating it if absent, and is
forbidden to touch anything else in the file. Adjudication: the auditor's
method step 0 requires every open note to be adjudicated — promoted into
a citation or dismissed with a stated reason — and forbids leaving one
open; the same step makes recorded adjudications binding on later passes
unless their cited reality moved. Never auto-invalidating: the inspector
says so in its own words ("You nominate; you never invalidate"), and both
gates' clean bars require that no note be left open rather than treating
a nomination as a verdict. The round trip is visible on this tree: the
registry's four `adjudicated` entries name `story:explain-lint-rules`,
whose audit carries the matching notes.

**"The judgment layer's completeness is itself mechanical: every changed
source node must be accounted — by a stale citation or by a live entry in
the committed inspection registry — or the checker fails the gate, so a
skipped inspection pass fails instead of passing vacuously." NOW
HONORED, quantifier included.** This is the sentence the standing
determination turned on. The mechanism, unchanged and re-derived:
`audit-check --inspection` computes the changed set from the current
committed graph against the graph at the baseline ref, parses the
registry at `.ok-planner/audits/inspection.md`, treats an entry as live
only while its pinned hash still matches the graph's recorded hash for
that identity, and emits `inspection-unclassified` for any changed node
neither covered by a stale citation (by file or by a containing identity)
nor by a live entry — with `inspection-missing` when changed nodes exist
and no registry does, and `inspection-malformed` for a bad entry or an
`adjudicated` entry naming no audit file. Both gates consume it as a
clean-bar condition and the ceremony bakes it into completion-contract
item 3.

What changed is the population, in the two classes the prior pass
charged, and the fuller reasoning is under
`decision:inspection-registry`, which owns the floor's own claims:

1. **Bytes outside every declared unit of a unit-bearing file.** Now
   accounted. The file's own node enters the changed set whenever the
   region outside every declared unit moved, and that region is computed
   on both sides and compared (`outside_units_hash` excises every unit
   span under the release mask; `outside_units_moved` compares the tree
   against `git show <baseline>:<path>`, treating an absent baseline file
   as an empty region) rather than inferred from which units moved. Unit
   boundaries are loaded from the sibling `source-graph` extractor's
   `declared_unit_spans` instead of restated, so the floor's granularity
   cannot drift from the graph's, and every unavailability answers True —
   the file node enters the set rather than a byte going unwatched.
   Population re-enumerated from the committed graph, not assumed: 268
   mirrors, 152 unit-bearing; all 152 now have that region watched,
   including the two cases the prior audit named as sharpest
   (`.claude/skills/certify-work/SKILL.md`'s pre-heading frontmatter and
   `test/proofs.sh`'s top-level assertion surface). Five fixtures hold
   the rule's directions, and one of them is the regression guard that
   makes this a real fix rather than a blunt one: `inspection: a pure
   in-unit edit needs no file-node disposition`, which fails for any
   implementation that bought completeness by giving up unit
   granularity.

2. **The committed half of a range-scoped run.** Now accounted.
   `git_changed_sources(root, base)` unions `git status --porcelain
   -uall` with `git diff --name-status <base>`; `baseline_graph_rows`
   takes the ref rather than always reading HEAD; `check_inspection`
   takes `base`; `main()` parses `--inspection=<base>`. And the gate
   passes it — `certify-work`'s clean bar now reads "invoked as
   `--inspection=<base>` with the range's base ref where this run's
   subject is a commit range, so the floor judges the committed half of
   its own subject too", which is what makes the Choice's "working tree
   or commit range" true of both layers rather than only the judged one.
   Fail-closed on the new input: an unresolvable base makes
   `check_inspection` return False and `main()` exit 1, held by
   `inspection: an unresolvable base ref fails closed`. Three fixtures
   hold the scope rule.

The canonical rules block was brought along with the code rather than
left behind — it now states the same population, the same
compute-and-compare rule, and the same `--inspection=<base>` scope
extension, so the consumer-facing statement and the implementation agree.

**"Code annotations play no part in either layer."** This is the
artifact's one universal negative, so the population was re-enumerated
from reality — every place either gate or the shared machinery derives
what gets re-audited or what the gate fails on. All eleven, with the
floor re-read because it gained inputs this cycle:

1. `certify-work`'s **Touched artifacts** — derived from changed files,
   design files changed directly, and the artifacts a sprint-in-scope's
   deltas and work items name, with an explicit disclaimer that
   annotations play no part in the derivation "or in any invalidation
   below".
2. `certify-work`'s **re-audit set** — the union of that touched set, the
   checker's refs, and the inspector's nominations, closed with "and
   nothing else; code annotations play no part in it".
3. `certify-all`'s **audit set** — every live story and decision, which
   no annotation can widen or narrow.
4. `certify-all`'s **re-review scope** — the same two-layer union,
   recomputed after each fix cycle.
5. The core's **re-review step 4** — the two-layer union, stated once.
6. The core's **two-layer paragraph** — the canonical statement, which
   says the negative itself.
7. `audit-check`'s staleness path — no annotation read at any point; the
   live population comes from directory listings under `design/`.
8. `audit-check --inspection` — inputs are `git status`, `git diff
   --name-status <base>`, the current committed graph, the graph at the
   baseline ref, the file's own bytes at both versions, the extractor's
   `declared_unit_spans`, the registry, and the citation-derived stale
   sets. Every input added this cycle was checked: none reads a tag. The
   `@decision:` / `@concept:` comments *on* the new functions are
   navigation left by the implementer, not inputs to it.
9. The **change inspector** — inputs are the diff, the graph, the audit
   corpus, and the stale set.
10. The **auditor's triage split** — hashes, nominations, and audit
    existence only.
11. The **auditor prompt** — the `@story:` grep is named as a navigation
    aid and immediately disclaimed ("annotations play no part in what you
    audit or invalidate, and an untagged enforcement point counts exactly
    like a tagged one").

The three remaining annotation consumers in the family were re-checked
and all lie outside both layers: `/prove` collects proof artifacts by
`@story:` annotation; `/audit` runs whole-corpus annotation integrity;
and `certify-work`'s mechanical floor runs annotation integrity over the
changed files. None feeds the re-audit set or the closure floor; each is
a producer of other findings that enters the fix loop like any other. The
consumer-side statement is carried by both templates the family's
converge materializes into every estate — the estate guide ("What forces
a re-audit is **two layers, never annotations**") and the project
cheatsheet ("**What triggers a re-audit is two layers, never
annotations.**").

**Rationale — "Citations alone under-invalidate: work added beside a
cited span breaks no hash, so a purely mechanical trigger is silent about
violations introduced in code no audit cited."** True of the
implementation as built, and it is precisely why the inspector exists —
`span_hash` covers the N lines from the anchor and nothing else, a `cite:`
line tests only that its anchor still appears, and a `cite-node:` line
tests one declared unit's bytes.

**Rationale — "Annotation-derived triggers err in both directions at
once …"** A statement about the rejected alternative, not a claim on this
code; no annotation-derived touched set exists anywhere in either gate.

**Rationale — "The change visible to git is the only ground truth about
what work happened, and mapping it to the claims it bears on requires
judgment — so an agent renders that judgment, and what the gate consumes
is the recorded adjudication, never a tag."** Honored: the inspector's
inputs are git's diff and the graph; its output is recorded, not consumed
live.

**Rationale — "The two layers bound each other twice over: the
mechanical floor fires regardless of anyone's opinion; the judged layer's
variance is bounded by being candidacy — the auditor, not the inspector,
decides — and its absence is bounded by the closure floor, because a
judgment pass whose skipping looks clean will be skipped exactly when it
matters."** All three bounds now hold, and the third is what moved.
`--list-stale` is computed with no agent in the path. The inspector's
output is explicitly candidacy with a deliberate bias toward
over-nomination, and the auditor adjudicates. And the absence bound is
real over the whole population rather than a subset: there is no longer a
class of change for which skipping the judgment pass looks clean — the
fixture named `inspection: outside-units change is no vacuous clean`
exists specifically to hold the case where it used to, and a range-scoped
run's committed half is judged against the range's own base. By this
Rationale's own reasoning that is the load-bearing part: the bound is
worth nothing if a skipped pass reads clean anywhere, because that is
exactly where it will be skipped.

**Alternatives.** All four name genuine roads not taken and none is
secretly in force: no annotation-derived touched set exists; pure
citation staleness is not the whole trigger (the inspector's nominations
join the union in both gates); whole-corpus re-derivation is confined to
`certify-all`; and the fourth — "Trusting the orchestrator's word that
the judgment pass ran" — is genuinely rejected, since the gate's
condition is the checker's exit code and not the orchestrator's report.
That rejection is now unqualified: the prior pass could only call it real
"wherever the floor can see the change".

## Determination

**satisfied.** The standing `violated` rested on one claim line — the
Choice's completeness sentence, enforced over a strict subset of its
stated population — and the flip condition that audit stated was that
"the floor's population matches the sentence: the file node accounted for
when a change moves it and no unit hash, and the changed set derived from
the gate's actual subject rather than from `git status` alone when a
commit range is in scope." Both hold in the canonical checker, and hold
in the strong form: the outside-unit region is computed and compared, not
inferred, so the floor demands the file node for a combined change
without demanding it for a pure in-unit edit; unit boundaries are loaded
from the graph's own extractor so the two cannot drift; every
unavailability answers conservatively; the range scope is threaded from
the gate's instruction through the flag, the changed-set union, and the
baseline graph ref; and an unresolvable base exits non-zero rather than
clean. Nine fixtures hold the floor's directions, six of them new,
including the exact vacuous clean the sentence forecloses.

Everything else was re-derived and holds. Both layers exist and are
stated once in the shared core so the gates cannot drift apart, and are
wired into both gates' producer lists and the core's re-review step. The
mechanical layer is a deterministic checker whose staleness triggers are
each held by a passing fixture, none of which reads a tag. The judgment
layer is a dispatched prompt with a defined territory model, a defined
recording format, an explicit prohibition on invalidating anything
itself, and a durable committed registry with audit-style precedent
semantics that both gates check. The "never annotations" negative was
re-enumerated over all eleven derivations — including every input the
floor gained this cycle — and holds at each, with the consumer-side
statement carried by both materialized templates.

One thing a reader should not mistake for a violation: this repository's
own `.ok-planner/bin/audit-check` still carries the pre-repair floor
(tree-only changed set, no outside-units accounting). That is the
vendored layer doing exactly what `decision:per-project-pinning` and
`checks/vendored-layer` (green on this tree) require of it between a
release and the next deliberate converge; this decision's subject is the
mechanism the family ships.

This would stop being satisfied if: `audit-check` gained an
annotation-derived input, or lost one of its staleness triggers, or
stopped marking `graph-missing` / `graph-stale` as stale (the pinned
`check_audit`, `CITE_NODE_LINE` and `load_graph` spans break first);
`{{CHANGE-INSPECTOR-PROMPT}}` were deleted, or either gate stopped
dispatching it, or stopped including its nominations in the re-audit set;
the inspector were allowed to invalidate rather than nominate, or to edit
anything in an audit beyond appending a note; the auditor stopped being
the adjudicator, or the triage split acquired an input that is not a
hash, a nomination, or an audit's existence; `outside_units_moved` /
`outside_units_hash` were removed or stopped answering conservatively, or
the floor stopped loading `declared_unit_spans` from the extractor and
restated unit boundaries locally; the changed set lost its base union, or
`certify-work` stopped instructing `--inspection=<base>` for a
range-scoped run, or the unresolvable-base guard stopped exiting
non-zero; either gate dropped `--inspection` from its clean bar, or the
ceremony dropped contract item 3; the registry's precedent semantics
changed so an entry no longer lapsed when its node moved; any of the nine
`inspection:` fixtures were deleted or weakened — in particular the
pure-in-unit-edit guard; or the estate guide or cheatsheet template
stopped carrying the annotation boundary to the consumer.

## Notes

<!-- The note below was opened and adjudicated in an earlier pass, before
     the design artifact's hash moved and moved back into a fresh read.
     It is carried forward verbatim as history; it is not open, and this
     pass's re-derivation reached the same conclusion on the territory it
     named. -->

- note: `.ok-planner/graph/` — 249 new `.graph` mirror files, the genesis build of the committed source graph — implicated because before this change every `cite-node:` target in this project was necessarily unresolvable (no graph existed); this build is the enabling event that makes the mechanical `unresolvable node identity` / `moved node hash` triggers this decision describes actually operative here for the first time, worth confirming against the decision's claim.
  adjudication: promoted — both triggers were exercised against the committed genesis graph on this repository's own code (a moved hash on `admin/converge#vendor_layer` reported as `the cited content changed` with the file's three sibling nodes unmoved; a renamed declaration reported as `no longer resolves`; an un-rebuilt graph reported as `graph-stale` rather than judged), and the nominated territory is carried by the `CITE_NODE_LINE`, `check_audit` and `load_graph` spans, the whole-file node pin on `scripts/audit-check`, and the `node content change trips` / `renamed node unresolves` / `stale graph is a finding` fixtures.

## Citations

- cite-node: plugins/ok/families/ok-planner/skills/_shared/certification-core.md @ sha256:f42b50f44a66
- cite-node: plugins/ok/families/ok-planner/skills/_shared/certification-core.md#certification-core.how-consumers-use-this-file.change-inspector-prompt @ sha256:c1f9ccb49f08
- cite-node: plugins/ok/families/ok-planner/skills/_shared/certification-core.md#certification-core.how-consumers-use-this-file.certify-review-fix-loop @ sha256:45bcc0229e41
- cite-node: plugins/ok/families/ok-planner/skills/certify-work/SKILL.md @ sha256:3fa398a77d5e
- cite-node: plugins/ok/families/ok-planner/skills/certify-work/SKILL.md#certify-the-work-the-change-scoped-gate.process @ sha256:ab43437dd800
- cite-node: plugins/ok/families/ok-planner/skills/certify-work/SKILL.md#certify-the-work-the-change-scoped-gate.scope @ sha256:133faeb4e2a1
- cite-node: plugins/ok/families/ok-planner/skills/certify-all/SKILL.md @ sha256:c4edf29db435
- cite-node: plugins/ok/families/ok-planner/skills/certify-all/SKILL.md#certify-everything-the-full-gate.process @ sha256:619fe94738d0
- cite-node: plugins/ok/families/ok-planner/skills/certify-all/SKILL.md#certify-everything-the-full-gate.the-review-fix-loop @ sha256:323c1044f6bd
- cite-node: plugins/ok/families/ok-planner/skills/_shared/implementation-auditor.md @ sha256:049ea0635856
- cite-node: plugins/ok/families/ok-planner/skills/_shared/artifact-definitions.md#shared-artifact-definitions.token-catalog.inspection-registry-format @ sha256:5f1c4527fd56
- cite-node: plugins/ok/families/ok-planner/scripts/audit-check @ sha256:32b1732e3fdd
- cite-node: plugins/ok/families/ok-planner/scripts/source-graph @ sha256:e293c0d31163
- cite-node: plugins/ok/families/ok-planner/scripts/ok-planner-CLAUDE.md @ sha256:284a6200837e
- cite-node: plugins/ok/families/ok-planner/scripts/ok-planner-cheatsheet.md @ sha256:1d1d41e12b03
- cite-node: plugins/ok/families/ok-planner/skills/prove/SKILL.md @ sha256:c015b0e2ffd7
- cite-node: plugins/ok/families/ok-planner/test/run.sh @ sha256:a4d8463946b0
- cite-node: plugins/ok/families/ok-planner/test/proofs.sh @ sha256:10f3b1e855fd
- cite-span: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "**The two-layer re-audit trigger, stated once for both gates.**" +2 sha256:a70f916b9762
- cite: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "### {{CHANGE-INSPECTOR-PROMPT}}"
- cite-span: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "  3. Disposition the hunk:" +15 sha256:9b3cbeeaa602
- cite-span: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "  4. Record each nomination as a provisional note on the audit it" +8 sha256:4285e41b1b38
- cite-span: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "  4b. Update the inspection registry per the format above: one" +12 sha256:4371ec2c3a2d
- cite-span: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "4. **Re-review.** Re-run each producer whose findings were worked" +1 sha256:925bc9bd6fde
- cite-span: plugins/ok/families/ok-planner/skills/certify-work/SKILL.md :: "- **Touched artifacts** — design files changed directly" +2 sha256:0ec6f21290f2
- cite: plugins/ok/families/ok-planner/skills/certify-work/SKILL.md :: "code annotations play no part in it"
- cite: plugins/ok/families/ok-planner/skills/certify-work/SKILL.md :: "**On request — a commit range.**"
- cite: plugins/ok/families/ok-planner/skills/certify-work/SKILL.md :: "This producer's clean bar: `audit-check --inspection` exits 0"
- cite: plugins/ok/families/ok-planner/skills/certify-work/SKILL.md :: "invoked as `--inspection=<base>` with the range's base ref where this run's subject is a commit range"
- cite: plugins/ok/families/ok-planner/skills/certify-all/SKILL.md :: "Clean bar: `.ok-planner/bin/audit-check --inspection` exits 0"
- cite-span: plugins/ok/families/ok-planner/skills/_shared/implementation-auditor.md :: "  0. Read the prior audit file first, if one exists — it is the" +17 sha256:0dc64431681a
- cite: plugins/ok/families/ok-planner/skills/_shared/implementation-auditor.md :: "     is a navigation aid and nothing more — annotations play no"
- cite: plugins/ok/families/ok-planner/skills/_shared/implementation-auditor.md :: "**Split by triage class, price by the job.**"
- cite: plugins/ok/families/ok-planner/skills/_shared/artifact-definitions.md :: "The judged population is every node whose recorded hash moved"
- cite-span: plugins/ok/families/ok-planner/scripts/audit-check :: "def check_audit(root, path, live, findings, stale_refs," +57 sha256:a750093fa49c
- cite-span: plugins/ok/families/ok-planner/scripts/audit-check :: "        m = CITE_NODE_LINE.match(raw)" +37 sha256:931c7e0c7c2d
- cite-span: plugins/ok/families/ok-planner/scripts/audit-check :: "def load_graph(root, source_rel):" +35 sha256:1aacd02c60fc
- cite-span: plugins/ok/families/ok-planner/scripts/audit-check :: "def check_inspection(root, findings, stale_files, stale_identities," +76 sha256:132cb08a382a
- cite-span: plugins/ok/families/ok-planner/scripts/audit-check :: "        # Judge at unit granularity where the file declares units: an" +16 sha256:de6822ea1136
- cite-span: plugins/ok/families/ok-planner/scripts/audit-check :: "# The judged population is every node whose hash moved, at unit" +17 sha256:2494b220d5e9
- cite-span: plugins/ok/families/ok-planner/scripts/audit-check :: "def outside_units_moved(root, rel, baseline, has_units):" +24 sha256:5fe5736a3cba
- cite-span: plugins/ok/families/ok-planner/scripts/audit-check :: "def outside_units_hash(rel, text):" +17 sha256:6e9f48633198
- cite-span: plugins/ok/families/ok-planner/scripts/audit-check :: "def declared_unit_spans(rel, lines):" +32 sha256:9d357a06f381
- cite-span: plugins/ok/families/ok-planner/scripts/audit-check :: "def git_changed_sources(root, base=None):" +40 sha256:a9f67e39dae4
- cite-span: plugins/ok/families/ok-planner/scripts/audit-check :: "def baseline_graph_rows(root, source_rel, ref):" +16 sha256:90077e7a763d
- cite-span: plugins/ok/families/ok-planner/scripts/audit-check :: "    inspection = False" +12 sha256:b9f579720e1e
- cite-span: plugins/ok/families/ok-planner/scripts/audit-check :: "def identity_contains(container, identity):" +12 sha256:473033c84068
- cite: plugins/ok/families/ok-planner/scripts/audit-check :: "--list-stale prints only the artifact refs (kind:slug) needing"
- cite-span: plugins/ok/families/ok-planner/scripts/source-graph :: "def declared_unit_spans(rel, lines):" +9 sha256:717f6aec996b
- cite-span: plugins/ok/families/ok-planner/scripts/source-graph :: "ADAPTERS = [" +11 sha256:2736506eccba
- cite-span: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md :: "3. The implementation-audit corpus is current for everything the" +4 sha256:72227505dde8
- cite: plugins/ok/families/ok-planner/test/run.sh :: "run_case "re-audit set""
- cite: plugins/ok/families/ok-planner/test/run.sh :: "run_case "node citation clean""
- cite: plugins/ok/families/ok-planner/test/run.sh :: "run_case "node content change trips""
- cite: plugins/ok/families/ok-planner/test/run.sh :: "run_case "renamed node unresolves""
- cite: plugins/ok/families/ok-planner/test/run.sh :: "run_case "stale graph is a finding""
- cite-span: plugins/ok/families/ok-planner/test/run.sh :: "# The change-inspection floor (--inspection): every node the" +6 sha256:ad422cef347e
- cite: plugins/ok/families/ok-planner/test/run.sh :: "run_case "inspection: missing registry""
- cite: plugins/ok/families/ok-planner/test/run.sh :: "run_case "inspection: unclassified node""
- cite: plugins/ok/families/ok-planner/test/run.sh :: "run_case "inspection: lapsed entry trips""
- cite: plugins/ok/families/ok-planner/test/run.sh :: "run_case "inspection: mechanical account""
- cite: plugins/ok/families/ok-planner/test/run.sh :: "run_case "inspection: outside-units change is no vacuous clean""
- cite: plugins/ok/families/ok-planner/test/run.sh :: "run_case "inspection: outside-units change needs a disposition""
- cite: plugins/ok/families/ok-planner/test/run.sh :: "run_case "inspection: a file-node entry covers the outside-units region""
- cite: plugins/ok/families/ok-planner/test/run.sh :: "run_case "inspection: a pure in-unit edit needs no file-node disposition""
- cite: plugins/ok/families/ok-planner/test/run.sh :: "run_case "inspection: a unit edit does not absorb the outside-units bytes""
- cite: plugins/ok/families/ok-planner/test/run.sh :: "run_case "inspection: both nodes dispositioned closes the combined change""
- cite: plugins/ok/families/ok-planner/test/run.sh :: "run_case "inspection: a committed change leaves the tree-scoped floor clean""
- cite: plugins/ok/families/ok-planner/test/run.sh :: "run_case "inspection: the range-scoped floor sees the committed change""
- cite: plugins/ok/families/ok-planner/test/run.sh :: "run_case "inspection: an unresolvable base ref fails closed""
- cite: plugins/ok/families/ok-planner/skills/prove/SKILL.md :: "1. **Collect.** For each in-scope story, read its slug and `Proof:` field"
- cite: plugins/ok/families/ok-planner/scripts/ok-planner-CLAUDE.md :: "What forces a re-audit is **two layers, never annotations**:"
- cite: plugins/ok/families/ok-planner/scripts/ok-planner-cheatsheet.md :: "**What triggers a re-audit is two layers, never annotations.**"
