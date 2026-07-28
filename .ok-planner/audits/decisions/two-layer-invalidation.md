---
audit: two-layer-invalidation
artifact: decision:two-layer-invalidation
determination: satisfied
audited: 2026-07-28T00:00:00Z
artifact-hash: sha256:4eb6c97b271a
---

# Whether re-audit is triggered by citations plus a judged change inspection, with annotations playing no part in either layer

The design artifact's hash is unchanged since the prior audit, so that audit's
reasoning binds absent moved reality, and it carried no `## Notes` ledger, so
no adjudication is open. What moved is this repo's vendored planner layer,
restored to its pinned HEAD state: a release-era copy that predates the change
inspector entirely. Under `decision:per-project-pinning` that layer changes
only by a deliberate, committed converge after a release, so it now
legitimately lags the family source. Two of the prior pass's citations pointed
at it to corroborate the negative from the consumer side; both are re-homed
below to the surfaces the family actually ships, and the claim they supported
is restated against what now holds. No other citation moved and every claim was
re-run against the tree.

## Claims

**Title — "Re-audit triggers are citations plus judged change inspection,
never annotations."** All three parts are separately checkable and all
three hold; each is taken below.

**"What forces an audit to be re-derived is two layers reading the same
source graph."** Honored as the stated architecture in the one place both
gates read it from: the certification core opens with the two-layer
paragraph, names `audit-check` as the mechanical layer and the change
inspector as the judgment layer, and closes "The gate's re-audit set is
always the union". Both layers read the graph where one exists —
`audit-check` resolves `cite-node:` identities through `.ok-planner/graph/`
and refuses to judge through a graph that no longer matches the tree, and
the inspector is handed the committed graph as an input and resolves each
hunk to the nodes it falls in. This project carries no committed graph
yet, and the inspector prompt provides the pre-genesis fallback
explicitly (map hunks by file against the audits' cited paths); that is
the migration path, not a missing layer.

**"The mechanical layer needs no review: a cited node identity that no
longer resolves, a cited content hash that moved, or a design artifact
whose own hash changed invalidates the audit outright."** Honored, and the
enumeration was checked against the checker rather than against the
sentence. `check_audit` sets `stale` on: a design artifact hash that no
longer matches `artifact-hash`; a `cite:` anchor that has vanished; a
`cite-span:` region whose content hash moved, or whose anchor stopped
being unique; a `cite-file:` pin whose masked hash moved, or whose file is
gone; and a `cite-node:` identity absent from the graph or whose recorded
hash moved. `graph-missing` and `graph-stale` also set `stale`, so a
citation that cannot be judged is never a silent pass. Every stale ref
lands in `stale_refs`, which `--list-stale` prints. Nothing in that path
consults an annotation, a file name convention, or any tag. All six
triggers are held by fixtures, exercised green on this tree — the family
harness runs to exit 0 this cycle, including the `re-audit set`, `node
citation clean`, and `stale graph is a finding` cases pinned below.

This pass is a small live demonstration of the mechanical layer working as
described. The vendored-layer restore deleted `.ok-planner/bin/source-graph`
and moved `checks/vendored-layer`; `audit-check` flagged exactly six stale
refs across five audits — a missing cited file, two moved `cite-file` pins,
and three vanished anchors — and named nothing else. No annotation was
consulted to produce that set, and the audits it named are precisely the ones
whose citations the change touched.

**"The judgment layer covers what anchors cannot see: an inspector reads
the change under certification — the diff itself, working tree or commit
range — and nominates the audits whose claimed closures contain changed
nodes."** Honored. `{{CHANGE-INSPECTOR-PROMPT}}` exists once in the shared
core, states the blindness it exists to close in its own job section
("work added beside a cited span breaks no hash"), and defines an audit's
territory as its Citations block's downward closure — the cited nodes,
what their identities contain, and what their graph files' `ref` edges
reach. Its `[CHANGE SCOPE]` slot is filled by the consuming gate, and both
scopes the Choice names are real: `certify-work`'s subject is the
uncommitted tree by default and a commit range plus the tree on request,
and it passes that subject through verbatim; `certify-all` fills the same
slot with the uncommitted tree. The mechanical stale set is handed to the
inspector as already-handled territory so the two layers partition rather
than duplicate.

**"nominations are recorded on the audits they implicate and adjudicated
by the auditor, never auto-invalidating."** Honored on all three counts.
Recording: inspector method step 4 appends a `- note:` /
`  adjudication: open (awaiting the next audit pass)` line pair to the
implicated audit's `## Notes` section, creating it if absent, and is
forbidden to touch anything else in the file — not the determination, not
the claims, not the citations, not existing notes. Adjudication: the
auditor's method step 0 requires every open note to be adjudicated,
promoted into a citation or dismissed with a stated reason, and forbids
leaving one open. Never auto-invalidating: the inspector says so in its
own words ("You nominate; you never invalidate"), and the gates' clean
bars require no note be left open rather than treating a nomination as a
verdict. The auditor prompt's own consumer notes name it as "the sole
adjudicator of the inspector's provisional notes".

**"Code annotations play no part in either layer."** This is the
artifact's one universal negative, so the population was enumerated from
reality — every place either gate derives what gets re-audited — rather
than from the sentence. In `certify-work`: the touched set is derived from
changed files, design files changed directly, and the artifacts a
sprint-in-scope's deltas and work items name, with an explicit disclaimer
that annotations play no part in the derivation "or in any invalidation
below"; the re-audit set is the union of that touched set, the checker's
refs, and the inspector's nominations, closed with "and nothing else; code
annotations play no part in it". In `certify-all`: the audit set is every
live story and decision, which no annotation can widen or narrow, and the
compliance producer's scope carries the same disclaimer. In the core's
re-review step: the same two-layer union, recomputed. In `audit-check`: no
annotation is read at any point — the live population comes from directory
listings under `design/`. In the inspector: the inputs are the diff, the
graph, the audit corpus, and the stale set. In the auditor: `rg -n '@story:'`
is named as a navigation aid and immediately disclaimed ("annotations play no
part in what you audit or invalidate, and an untagged enforcement point counts
exactly like a tagged one").

The two remaining annotation consumers were checked and are outside both
layers: `/prove` collects proof artifacts by `@story:` annotation, and the
gates' corpus-checks producer runs annotation integrity and per-story
coverage. Neither feeds the re-audit set; both are separate producers
whose findings enter the fix loop like any other.

The consumer-side statement of the same boundary was re-checked at the right
altitude this pass. It reaches a consumer project through the two documents
the family's converge materializes into every estate — the estate guide and
the project cheatsheet, rendered from templates under the family's
`scripts/` — and both say it in the owner's own words: annotations carry
exactly two jobs, navigation and proof registration, and play no part in
certification scope or audit invalidation, because what a change puts in
question is computed from citations and from the change itself, never from
tags. Those templates are the shipped surface and are cited below. The prior
pass instead cited this repo's *vendored* copies of the core and of
`certify-work` — "the vendored copies this project actually runs carry both
sentences verbatim." That sentence is no longer true of this tree, and it is
not a violation: the vendored layer was restored to its pinned HEAD state,
which is the v11.0.0 release-era copy predating the two-layer work, and
per-project pinning is exactly the commitment that a project runs what it was
converged to until the owner deliberately converges again. The negative the
Choice asserts is a claim about the suite's own derivations, and it holds at
every one of them in the family source; a lagging vendored copy is the pinning
decision behaving, not a counter-example.

**Rationale — "Citations alone under-invalidate: work added beside a cited
span breaks no hash, so a purely mechanical trigger is silent about
violations introduced in code no audit cited."** True of the
implementation as built, and it is precisely why the inspector exists —
`span_hash` covers the N lines from the anchor and nothing else, and a
`cite:` line tests only that its anchor still appears. The rationale
describes a real property of the code it justifies rather than selling one
nothing delivers.

**Rationale — "Annotation-derived triggers err in both directions at once
… a mis-tagged file invalidates strangers, an untagged one invalidates
nothing, and at file granularity one incidental tag sweeps unrelated
artifacts into every close."** A statement about the rejected alternative,
not a claim on this code; no annotation-derived touched set exists
anywhere in either gate to contradict it.

**Rationale — "The two layers bound each other: the mechanical floor fires
regardless of anyone's opinion, and the judged layer's variance is bounded
by being candidacy — the auditor, not the inspector, decides."** Honored:
`--list-stale` is computed with no agent in the path, and the inspector's
output is explicitly candidacy the auditor adjudicates. The rule "when you
cannot tell whether an audit is implicated, nominate" is the deliberate
bias toward over-nomination that keeps the bound one-sided.

**Alternatives.** All three name genuine roads not taken and none is
secretly in force: no annotation-derived touched set exists; pure citation
staleness is not the whole trigger (the inspector's nominations join the
union in both gates); and whole-corpus re-derivation is confined to
`certify-all`, which the change-scoped gate explicitly defers to.

## Determination

**satisfied.** Both layers exist, are stated once in the shared core so
the gates cannot drift apart, and are wired into both gates' producer
lists and into the core's re-review step. The mechanical layer is a
deterministic checker whose six staleness triggers are each held by a
passing fixture and none of which reads a tag; the judgment layer is a
dispatched prompt with a defined territory model, a defined recording
format, and an explicit prohibition on invalidating anything itself. The
"never annotations" negative was enumerated over every re-audit-set
derivation in both gates, the checker, the inspector, and the auditor, and
holds at each; the two genuine annotation consumers that remain are
producers of other findings, not triggers.

The determination does not move on the changed reality, and the boundary is
worth stating because it will recur: this decision claims a property of what
the suite ships, so its evidence is the family source under
`plugins/ok/families/ok-planner/` plus the templates that source materializes
into a consumer estate — never this repo's own vendored copies, which
`decision:per-project-pinning` deliberately holds at the last committed
converge. A vendored copy that lags falsifies nothing here. What would falsify
the negative is an annotation reappearing in a re-audit-set derivation, and
none does.

This stops holding if: `audit-check` gains an annotation-derived input, or
loses one of its staleness triggers, or stops marking `graph-missing` /
`graph-stale` as stale (the pinned `check_audit` and `load_graph` spans
break first); `{{CHANGE-INSPECTOR-PROMPT}}` is deleted, or either gate
stops dispatching it, or stops including its nominations in the re-audit
set (the whole-file pins on both gates and on the core break); the
inspector is allowed to invalidate rather than nominate, or to edit
anything in an audit beyond appending a note; the auditor stops being the
adjudicator; either gate reintroduces annotations into the touched-set
or re-audit-set derivation (the pinned `Touched artifacts` and
`Implementation audit` lines break); or the estate guide or cheatsheet
template stops carrying the annotation boundary to the consumer, so the
shipped surface and the prompts disagree about what annotations are for.

## Citations

- cite-span: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "**The two-layer re-audit trigger, stated once for both gates.**" +1 sha256:9b77fdd72dad
- cite: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "### {{CHANGE-INSPECTOR-PROMPT}}"
- cite-span: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "  3. Disposition the hunk:" +15 sha256:9b3cbeeaa602
- cite-span: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "  4. Record each nomination as a provisional note on the audit it" +8 sha256:4285e41b1b38
- cite-span: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "4. **Re-review.** Re-run each producer whose findings were worked" +1 sha256:925bc9bd6fde
- cite-span: plugins/ok/families/ok-planner/skills/certify-work/SKILL.md :: "- **Touched artifacts** — design files changed directly" +1 sha256:4995e24c70e6
- cite-span: plugins/ok/families/ok-planner/skills/certify-work/SKILL.md :: "   - **Implementation audit, two layers.**" +1 sha256:62a96e92cc0f
- cite: plugins/ok/families/ok-planner/skills/certify-work/SKILL.md :: "code annotations play no part in it"
- cite-span: plugins/ok/families/ok-planner/skills/certify-all/SKILL.md :: "   - **Implementation audit, whole-corpus.**" +1 sha256:ca40b8632807
- cite-span: plugins/ok/families/ok-planner/skills/_shared/implementation-auditor.md :: "  0. Read the prior audit file first, if one exists — it is the" +17 sha256:0dc64431681a
- cite: plugins/ok/families/ok-planner/skills/_shared/implementation-auditor.md :: "     part in what you audit or invalidate, and an untagged"
- cite-span: plugins/ok/families/ok-planner/scripts/audit-check :: "def check_audit(root, path, live, findings, stale_refs):" +55 sha256:f5f073d2a484
- cite-span: plugins/ok/families/ok-planner/scripts/audit-check :: "        m = CITE_NODE_LINE.match(raw)" +33 sha256:8dcf6bfe3f85
- cite-span: plugins/ok/families/ok-planner/scripts/audit-check :: "def load_graph(root, source_rel):" +35 sha256:1aacd02c60fc
- cite: plugins/ok/families/ok-planner/scripts/audit-check :: "--list-stale prints only the artifact refs (kind:slug) needing"
- cite: plugins/ok/families/ok-planner/test/run.sh :: "run_case "re-audit set""
- cite: plugins/ok/families/ok-planner/test/run.sh :: "run_case "node citation clean""
- cite: plugins/ok/families/ok-planner/test/run.sh :: "run_case "stale graph is a finding""
- cite: plugins/ok/families/ok-planner/skills/prove/SKILL.md :: "1. **Collect.** For each in-scope story, read its slug and `Proof:` field"
- cite: plugins/ok/families/ok-planner/scripts/ok-planner-CLAUDE.md :: "registration (`@story:` on proof artifacts) — and play no part in"
- cite: plugins/ok/families/ok-planner/scripts/ok-planner-cheatsheet.md :: "navigation — and play no part in audit scope or invalidation."
- cite-file: plugins/ok/families/ok-planner/skills/_shared/certification-core.md @ sha256:f96e5bcb96d6
- cite-file: plugins/ok/families/ok-planner/skills/certify-work/SKILL.md @ sha256:30f3667b968b
- cite-file: plugins/ok/families/ok-planner/skills/certify-all/SKILL.md @ sha256:d22e4b74e9a3
- cite-file: plugins/ok/families/ok-planner/skills/_shared/implementation-auditor.md @ sha256:43d1b1213bb1
