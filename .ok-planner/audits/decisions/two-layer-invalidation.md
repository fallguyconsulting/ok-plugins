---
audit: two-layer-invalidation
artifact: decision:two-layer-invalidation
determination: satisfied
audited: 2026-07-28T09:44:12Z
artifact-hash: sha256:4eb6c97b271a
---

# Whether re-audit is triggered by citations plus a judged change inspection, with annotations playing no part in either layer

Rewritten whole: an open nomination implicates this audit (the genesis build
of `.ok-planner/graph/`), and the citations it carried into the certification
skills went stale when v11.1.x rewrote them. The design artifact's hash is
unchanged, so prior determinations bind where their cited reality stands.
Three things moved around them. First, the graph now exists here, so the
Choice's "unresolvable node identity / moved node hash" triggers are
operative in this project for the first time — the nomination's point, and
they were exercised rather than argued. Second, this project has been
converged onto v11.1.1, so the consumer-side vendored copies again carry the
annotation boundary verbatim; the prior pass's reasoning about a lagging
vendored layer is superseded by facts, not overturned, and the durable
homing on the shipped templates is kept. Third, v11.1.x added the auditor's
triage and the full-pass/refresh dispatch split — a new member of the
population this decision quantifies over, enumerated and checked below.

## Claims

**Title — "Re-audit triggers are citations plus judged change inspection,
never annotations."** All three parts are separately checkable and all
three hold; each is taken below.

**"What forces an audit to be re-derived is two layers reading the same
source graph."** Honored as the stated architecture in the one place both
gates read it from: the certification core opens with the two-layer
paragraph, names `audit-check` as the mechanical layer and the change
inspector as the judgment layer, and closes "The gate's re-audit set is
always the union". Both layers now read a real graph in this project.
`audit-check` resolves `cite-node:` identities through `.ok-planner/graph/`
and refuses to judge through a graph that no longer matches the tree; the
inspector is handed the committed graph as an input and resolves each hunk
to the nodes it falls in. The pre-genesis fallback the inspector prompt
still carries (map hunks by file against the audits' cited paths) is now the
migration path for other projects, not this one's operating mode.

**"The mechanical layer needs no review: a cited node identity that no
longer resolves, a cited content hash that moved, or a design artifact
whose own hash changed invalidates the audit outright."** Honored, and the
enumeration was checked against the checker rather than against the
sentence. `check_audit` sets `stale` on: a design artifact hash that no
longer matches `artifact-hash`; a `cite:` anchor that has vanished; a
`cite-span:` region whose content hash moved, or whose anchor stopped being
unique; a `cite-file:` pin whose masked hash moved, or whose file is gone;
and a `cite-node:` identity absent from the graph or whose recorded hash
moved. `graph-missing` and `graph-stale` also set `stale`, so a citation
that cannot be judged is never a silent pass. Every stale ref lands in
`stale_refs`, which `--list-stale` prints. Nothing in that path consults an
annotation, a file name convention, or any tag. All six triggers are held by
fixtures, green on this tree at exit 0.

The two node-shaped triggers — the ones this decision names first and the
ones the nomination flags as newly operative — were exhibited on this
project's own code this pass, not on a fixture. In a scratch copy of the
working tree, a `cite-node:` pinned to `plugins/ok/families/ok-planner/admin/
converge#vendor_layer` was clean against the committed graph. Editing one
line inside that shell function and rebuilding produced `audit-stale-citation
… node … is sha256:8c8fc65d655b, audit pinned sha256:57c9adc41d84 — the
cited content changed`, naming that identity alone while the file's three
other function nodes held their committed hashes. Renaming the function
produced `audit-stale-citation … node … no longer resolves in the committed
graph — the declared structure changed`. Running the checker *before*
rebuilding produced `graph-stale … run source-graph build, then re-judge
this citation` instead of a verdict. Moved hash, unresolvable identity, and
the refusal to judge through a stale graph: all three, on live data, with no
agent in the path.

**"The judgment layer covers what anchors cannot see: an inspector reads
the change under certification — the diff itself, working tree or commit
range — and nominates the audits whose claimed closures contain changed
nodes."** Honored. `{{CHANGE-INSPECTOR-PROMPT}}` exists once in the shared
core, states the blindness it exists to close in its own job section ("work
added beside a cited span breaks no hash"), and defines an audit's territory
as its Citations block's downward closure — the cited nodes, what their
identities contain, and what their graph files' `ref` edges reach. Its
`[CHANGE SCOPE]` slot is filled by the consuming gate, and both scopes the
Choice names are real: `certify-work`'s subject is the uncommitted tree by
default and a commit range plus the tree on request, and it passes that
subject through verbatim; `certify-all` fills the same slot with the
uncommitted tree, explicitly so nominations and the ledger are recorded even
at full scope. The mechanical stale set is handed to the inspector as
already-handled territory so the two layers partition rather than duplicate.
This audit's own Notes ledger is an instance: the nomination it carries was
written by that inspector against the genesis build.

**"nominations are recorded on the audits they implicate and adjudicated
by the auditor, never auto-invalidating."** Honored on all three counts.
Recording: inspector method step 4 appends a `- note:` /
`  adjudication: open (awaiting the next audit pass)` line pair to the
implicated audit's `## Notes` section, creating it if absent, and is
forbidden to touch anything else in the file — not the determination, not
the claims, not the citations, not existing notes. Adjudication: the
auditor's method step 0 requires every open note to be adjudicated, promoted
into a citation or dismissed with a stated reason, and forbids leaving one
open; the same step makes recorded adjudications binding on later passes
unless their cited reality moved. Never auto-invalidating: the inspector
says so in its own words ("You nominate; you never invalidate"), and both
gates' clean bars require that no note be left open rather than treating a
nomination as a verdict. The auditor prompt's consumer notes name it as "the
sole adjudicator of the inspector's provisional notes".

**The triage layer v11.1.x added does not smuggle a third trigger in.**
Checked because it is a new member of the population this decision
quantifies over, not because the artifact mentions it. The auditor's
consumer rules split a gate's audit set into full-pass batches (artifact
hash moved, a nomination landed, or no audit exists) and sonnet refresh
batches (citation-only staleness, or coverage-only scope), and the prompt's
method step 0 lets a re-audit settle at refresh / amend / rewrite-whole. Two
things to check, and both hold. The split reads only the two layers' own
outputs — hashes, nominations, and audit existence — never a tag; and the
cheap class cannot silently absorb a real invalidation, because the triage
inside the prompt governs regardless of dispatch class and a refresh batch
that finds changed bytes touching a claim's territory must report
`escalate: <ref> — <why>` for re-dispatch as a full pass, which both gates
say they re-dispatch. The trigger is unchanged; only the price of responding
to it varies.

**"Code annotations play no part in either layer."** This is the artifact's
one universal negative, so the population was enumerated from reality —
every place either gate or the shared machinery derives what gets
re-audited — rather than from the sentence, and re-enumerated this pass
because v11.1.x added a member. All ten:

1. `certify-work`'s **Touched artifacts** — derived from changed files,
   design files changed directly, and the artifacts a sprint-in-scope's
   deltas and work items name, with an explicit disclaimer that annotations
   play no part in the derivation "or in any invalidation below".
2. `certify-work`'s **re-audit set** — the union of that touched set, the
   checker's refs, and the inspector's nominations, closed with "and nothing
   else; code annotations play no part in it".
3. `certify-all`'s **audit set** — every live story and decision, which no
   annotation can widen or narrow.
4. `certify-all`'s **re-review scope** — the same two-layer union,
   recomputed after each fix cycle.
5. The core's **re-review step 4** — the two-layer union, stated once.
6. The core's **two-layer paragraph** — the canonical statement, which says
   the negative itself.
7. `audit-check` — no annotation is read at any point; the live population
   comes from directory listings under `design/`.
8. The **change inspector** — inputs are the diff, the graph, the audit
   corpus, and the stale set.
9. The **auditor's triage split** (new in v11.1.x) — hashes, nominations,
   and audit existence only.
10. The **auditor prompt** — `rg -n '@story:'` is named as a navigation aid
    and immediately disclaimed ("annotations play no part in what you audit
    or invalidate, and an untagged enforcement point counts exactly like a
    tagged one").

The three remaining annotation consumers in the family were checked and all
lie outside both layers: `/prove` collects proof artifacts by `@story:`
annotation; `/audit` runs whole-corpus annotation integrity; and
`certify-work`'s corpus-checks producer runs annotation integrity and
per-story coverage over the changed files. None feeds the re-audit set; each
is a producer of other findings whose output enters the fix loop like any
other.

The consumer-side statement of the same boundary is carried by the two
documents the family's converge materializes into every estate — the estate
guide and the project cheatsheet, rendered from the pinned templates under
the family's `scripts/`. Both say it in the owner's own words: annotations
carry exactly two jobs, navigation and proof registration, and play no part
in certification scope or audit invalidation, because what a change puts in
question is computed from citations and from the change itself, never from
tags. Those templates are the shipped surface and are the durable evidence.
This project's own vendored copies now agree, the v11.1.1 converge having
landed here — the vendored `certify-work` carries "code annotations play no
part in it" and the vendored core carries the two-layer paragraph — but that
agreement is a consequence of a converge, not the claim's evidence: under
`decision:per-project-pinning` a consumer estate legitimately lags between
converges, and a lagging copy would falsify nothing here.

**Rationale — "Citations alone under-invalidate: work added beside a cited
span breaks no hash, so a purely mechanical trigger is silent about
violations introduced in code no audit cited."** True of the implementation
as built, and it is precisely why the inspector exists — `span_hash` covers
the N lines from the anchor and nothing else, a `cite:` line tests only that
its anchor still appears, and a `cite-node:` line tests one declared unit's
bytes, so a new function beside a cited one moves nothing. The rationale
describes a real property of the code it justifies rather than selling one
nothing delivers.

**Rationale — "Annotation-derived triggers err in both directions at once
… a mis-tagged file invalidates strangers, an untagged one invalidates
nothing, and at file granularity one incidental tag sweeps unrelated
artifacts into every close."** A statement about the rejected alternative,
not a claim on this code; no annotation-derived touched set exists anywhere
in either gate to contradict it.

**Rationale — "The two layers bound each other: the mechanical floor fires
regardless of anyone's opinion, and the judged layer's variance is bounded
by being candidacy — the auditor, not the inspector, decides."** Honored:
`--list-stale` is computed with no agent in the path (exhibited above), and
the inspector's output is explicitly candidacy the auditor adjudicates. The
rule "when you cannot tell whether an audit is implicated, nominate" is the
deliberate bias toward over-nomination that keeps the bound one-sided.

**Alternatives.** All three name genuine roads not taken and none is
secretly in force: no annotation-derived touched set exists; pure citation
staleness is not the whole trigger (the inspector's nominations join the
union in both gates); and whole-corpus re-derivation is confined to
`certify-all`, which the change-scoped gate explicitly defers to — and
which v11.1.x made cheaper without making it the everyday close.

## Determination

**satisfied.** Both layers exist, are stated once in the shared core so the
gates cannot drift apart, and are wired into both gates' producer lists and
into the core's re-review step. The mechanical layer is a deterministic
checker whose six staleness triggers are each held by a passing fixture,
none of which reads a tag, and whose two node-shaped triggers were exercised
this pass against this repository's own committed graph — the nomination's
question answered by running them rather than by reading them. The judgment
layer is a dispatched prompt with a defined territory model, a defined
recording format, and an explicit prohibition on invalidating anything
itself. The "never annotations" negative was re-enumerated over all ten
re-audit-set derivations, including the triage split v11.1.x added, and
holds at each; the three genuine annotation consumers that remain are
producers of other findings, not triggers.

This stops holding if: `audit-check` gains an annotation-derived input, or
loses one of its staleness triggers, or stops marking `graph-missing` /
`graph-stale` as stale (the pinned `check_audit`, `CITE_NODE_LINE` and
`load_graph` spans break first); `{{CHANGE-INSPECTOR-PROMPT}}` is deleted,
or either gate stops dispatching it, or stops including its nominations in
the re-audit set (the inspector node and both gates' process nodes break);
the inspector is allowed to invalidate rather than nominate, or to edit
anything in an audit beyond appending a note; the auditor stops being the
adjudicator, or the triage split acquires an input that is not a hash, a
nomination, or an audit's existence (the auditor's consumer-rules and prompt
nodes break); the refresh class loses its `escalate:` back-channel, so a
cheap dispatch could absorb a real invalidation; either gate reintroduces
annotations into the touched-set or re-audit-set derivation (the pinned
`Touched artifacts` span and the gates' process nodes break); or the estate
guide or cheatsheet template stops carrying the annotation boundary to the
consumer, so the shipped surface and the prompts disagree about what
annotations are for.

## Notes

- note: `.ok-planner/graph/` — 249 new `.graph` mirror files, the genesis build of the committed source graph — implicated because before this change every `cite-node:` target in this project was necessarily unresolvable (no graph existed); this build is the enabling event that makes the mechanical `unresolvable node identity` / `moved node hash` triggers this decision describes actually operative here for the first time, worth confirming against the decision's claim.
  adjudication: promoted — both triggers were exercised against the committed genesis graph on this repository's own code (a moved hash on `admin/converge#vendor_layer` reported as `the cited content changed` with the file's three sibling nodes unmoved; a renamed declaration reported as `no longer resolves`; an un-rebuilt graph reported as `graph-stale` rather than judged), and the nominated territory is carried by the `CITE_NODE_LINE`, `check_audit` and `load_graph` spans, the whole-file node pin on `scripts/audit-check`, and the `node content change trips` / `renamed node unresolves` / `stale graph is a finding` fixtures.

## Citations

- cite-node: plugins/ok/families/ok-planner/skills/_shared/certification-core.md @ sha256:f96e5bcb96d6
- cite-node: plugins/ok/families/ok-planner/skills/_shared/certification-core.md#certification-core.how-consumers-use-this-file.change-inspector-prompt @ sha256:d28780aa91eb
- cite-node: plugins/ok/families/ok-planner/skills/_shared/certification-core.md#certification-core.how-consumers-use-this-file.certify-review-fix-loop @ sha256:27d1d51eaa8a
- cite-node: plugins/ok/families/ok-planner/skills/certify-work/SKILL.md @ sha256:d774d6480349
- cite-node: plugins/ok/families/ok-planner/skills/certify-work/SKILL.md#certify-the-work-the-change-scoped-gate.process @ sha256:d26bc8e299d5
- cite-node: plugins/ok/families/ok-planner/skills/certify-work/SKILL.md#certify-the-work-the-change-scoped-gate.scope @ sha256:133faeb4e2a1
- cite-node: plugins/ok/families/ok-planner/skills/certify-all/SKILL.md @ sha256:2c584566d01a
- cite-node: plugins/ok/families/ok-planner/skills/certify-all/SKILL.md#certify-everything-the-full-gate.process @ sha256:5c588bd4687c
- cite-node: plugins/ok/families/ok-planner/skills/certify-all/SKILL.md#certify-everything-the-full-gate.the-review-fix-loop @ sha256:323c1044f6bd
- cite-node: plugins/ok/families/ok-planner/skills/_shared/implementation-auditor.md @ sha256:e79c50adcfaa
- cite-node: plugins/ok/families/ok-planner/skills/_shared/implementation-auditor.md#implementation-auditor-prompt.how-consumers-use-this-file @ sha256:52c386db0e3e
- cite-node: plugins/ok/families/ok-planner/skills/_shared/implementation-auditor.md#implementation-auditor-prompt.the-prompt.implementation-auditor-prompt @ sha256:1e5f3fc64d36
- cite-node: plugins/ok/families/ok-planner/scripts/audit-check @ sha256:d0e1036a76ae
- cite-node: plugins/ok/families/ok-planner/scripts/ok-planner-CLAUDE.md @ sha256:c4e9d04a95c4
- cite-node: plugins/ok/families/ok-planner/scripts/ok-planner-cheatsheet.md @ sha256:edb58192c6e7
- cite-node: plugins/ok/families/ok-planner/skills/prove/SKILL.md @ sha256:c015b0e2ffd7
- cite-span: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "**The two-layer re-audit trigger, stated once for both gates.**" +1 sha256:9b77fdd72dad
- cite: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "### {{CHANGE-INSPECTOR-PROMPT}}"
- cite-span: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "  3. Disposition the hunk:" +15 sha256:9b3cbeeaa602
- cite-span: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "  4. Record each nomination as a provisional note on the audit it" +8 sha256:4285e41b1b38
- cite-span: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "4. **Re-review.** Re-run each producer whose findings were worked" +1 sha256:925bc9bd6fde
- cite-span: plugins/ok/families/ok-planner/skills/certify-work/SKILL.md :: "- **Touched artifacts** — design files changed directly" +1 sha256:4995e24c70e6
- cite: plugins/ok/families/ok-planner/skills/certify-work/SKILL.md :: "code annotations play no part in it"
- cite-span: plugins/ok/families/ok-planner/skills/_shared/implementation-auditor.md :: "  0. Read the prior audit file first, if one exists — it is the" +17 sha256:0dc64431681a
- cite: plugins/ok/families/ok-planner/skills/_shared/implementation-auditor.md :: "     part in what you audit or invalidate, and an untagged"
- cite: plugins/ok/families/ok-planner/skills/_shared/implementation-auditor.md :: "**Split by triage class, price by the job.**"
- cite: plugins/ok/families/ok-planner/skills/_shared/implementation-auditor.md :: "it reports that ref back as `escalate: <ref> — <why>` and the gate re-dispatches it in a full-pass batch."
- cite: plugins/ok/families/ok-planner/skills/_shared/implementation-auditor.md :: "If you were dispatched as a refresh batch and a ref needs more"
- cite-span: plugins/ok/families/ok-planner/scripts/audit-check :: "def check_audit(root, path, live, findings, stale_refs):" +55 sha256:f5f073d2a484
- cite-span: plugins/ok/families/ok-planner/scripts/audit-check :: "        m = CITE_NODE_LINE.match(raw)" +33 sha256:8dcf6bfe3f85
- cite-span: plugins/ok/families/ok-planner/scripts/audit-check :: "def load_graph(root, source_rel):" +35 sha256:1aacd02c60fc
- cite: plugins/ok/families/ok-planner/scripts/audit-check :: "--list-stale prints only the artifact refs (kind:slug) needing"
- cite: plugins/ok/families/ok-planner/test/run.sh :: "run_case "re-audit set""
- cite: plugins/ok/families/ok-planner/test/run.sh :: "run_case "node citation clean""
- cite: plugins/ok/families/ok-planner/test/run.sh :: "run_case "node content change trips""
- cite: plugins/ok/families/ok-planner/test/run.sh :: "run_case "renamed node unresolves""
- cite: plugins/ok/families/ok-planner/test/run.sh :: "run_case "stale graph is a finding""
- cite: plugins/ok/families/ok-planner/skills/prove/SKILL.md :: "1. **Collect.** For each in-scope story, read its slug and `Proof:` field"
- cite: plugins/ok/families/ok-planner/scripts/ok-planner-CLAUDE.md :: "registration (`@story:` on proof artifacts) — and play no part in"
- cite: plugins/ok/families/ok-planner/scripts/ok-planner-cheatsheet.md :: "navigation — and play no part in audit scope or invalidation."
