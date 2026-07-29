---
audit: recorded-adjudication
artifact: decision:recorded-adjudication
determination: satisfied
audited: 2026-07-29T06:50:36Z
artifact-hash: sha256:5dd0aabd54f1
---

# Whether certification's judgments are written into the record the next run reads, bind later runs, close over every hunk of the change, and reach the owner and the corpus view as residue

Rewritten whole. The design artifact's hash moved: the in-flight sprint
added one sentence to the Choice ("The inspection's own judged
dispositions persist the same way, in the committed inspection registry,
keyed and pinned so each stands until the code it names moves") and
extended the residue sentence with a second destination ("and served to
the project's local corpus view"). Precedent lapses wholesale, so the
pre-existing clauses were re-derived from the code rather than carried;
the prior audit carried no `## Notes` ledger, so nothing is open. Both
new clauses are checked below against the mechanism rather than against
the sentence, including the one place a two-destination claim usually
fails — the second destination.

Refreshed. The design artifact's hash is unchanged and no new nomination
arrived; the subsequent fix cycle moved eight cited hashes, all outside the
territory this decision's clauses rest on. `check_inspection` gained a
`base=None` parameter and the `outside_units_moved` remainder-hashing block
(the `--inspection` floor's own feature growth, this decision's sibling
claims) ahead of the precedent check this audit actually cites — read
directly, `erows[identity] == pin` at the entry loop is untouched, so the
"an entry lapses the moment the node's content moves" claim still holds
verbatim; the span anchor is repointed to the function's new (two-line)
signature. `certify-work`'s clean-bar sentence gained the same
`--inspection=<base>` clause read elsewhere this cycle, changing "tree" to
"change" in the anchor text with no change to the sentence's substance (the
clean bar is still the mechanical proof the judgment pass ran); the anchor
is updated to the surviving wording. `test/run.sh`'s residue-entry fixture
was renamed to `"inspection: residue entries cover a new file whole"` as
part of this cycle's floor-fixture growth — same concept, more specific
name; the anchor is updated. Citations regenerated; nothing else touched.

Refreshed again. The design artifact's hash is unchanged and no new
nomination arrived. Three whole-file pins moved this pass —
`certification-core.md`, `certify-work/SKILL.md`, `certify-all/SKILL.md` —
all from the owner-ratified rewording of the review-fix loop's cycle cap
(the exit rule's choice between another cycle and escalating is now stated
as the owner's alone with no unattended default, and each gate's close-out
sentence repoints accordingly). None of this decision's cited spans sit in
that text: the inspector's note-writing step, the auditor's adjudication
step, the registry format and its precedent semantics, and the four
disposition/clean-bar citations are all in different sections and remain
byte-identical, re-confirmed directly. Citations regenerated; nothing else
touched.

## Claims

**Title — "Certification judgments are recorded transactions, not
per-run derivations."** Honored in the sense the body defines and no
wider: the judgments the gate carries forward between runs —
nominations, adjudications, determinations, and now the inspection's own
dispositions — live in committed files under `.ok-planner/audits/`, and
the gate's closure over a change is a per-run ledger. The scope is taken
sentence by sentence below rather than read off the title.

**"Every judgment the certification gate consumes is written down where
the next run reads it."** Honored for the quantifier's real population,
which was enumerated from the gates rather than from the sentence. The
judgments a run *consumes* — as opposed to produces and discharges within
the run — are: (a) the inspector's nominations, consumed by the auditor,
written as `## Notes` entries on the audits they implicate; (b) the
auditor's adjudications, consumed by the next auditor as binding
precedent, written on the same notes; (c) the auditor's determinations,
consumed by the gate's clean bar and by the next run's staleness
computation, written as the audit files themselves; (d) the architect's
confirmed forks, consumed by the next `/plan-sprint`, written as issue
files in the intake; and (e) new this cycle, the inspection's own judged
dispositions, consumed by the next inspection pass (which works only the
unclassified new work) and by the checker's closure floor, written as
entries in the committed registry. Each has a citable write site. The
judgments a run produces and discharges inside itself — a fixer's
veto-test call, an architect's refutation — become code and are reported
in the presentation's Divergences for the owner's after-the-fact veto;
nothing in the Choice claims those are carried into the next run, and the
Rationale scopes the property to adjudications explicitly.

**"An inspector's nomination lands as a provisional note on the audit it
implicates."** Honored, mechanically specified rather than gestured at:
inspector method step 4 fixes the exact line pair
(`- note: <file/hunk> — <why this audit is implicated>` /
`  adjudication: open (awaiting the next audit pass)`), requires the
`## Notes` section to be created when absent, forbids duplicating an
identical note, and forbids touching anything else in the file. The
canonical audit file format carries the matching `## Notes` section with
the same three adjudication values, so writer and reader agree on one
shape defined in one place. Live on this tree: this run's inspection
recorded four nominations against `story:explain-lint-rules`, each
present as a note on that audit.

**"the auditor adjudicates each note — promoted into a citation, or
dismissed with a stated reason — and the notes and their adjudications
are part of the audit record."** Honored. The auditor's method step 0
makes every open note "yours to adjudicate now", names both outcomes with
their obligations (a promotion must add the citation covering the
nominated territory; a dismissal must state the reason), and forbids
leaving a note open in an audit it writes. Its report line carries
`notes: N promoted, M dismissed` back to the gate, and both gates' clean
bars require that no provisional note be left open. Permanence is stated
from both ends: the auditor is told never to drop or rewrite existing
notes and adjudications but to carry them forward verbatim, and the
inspector is told to touch no existing note.

**NEW — "The inspection's own judged dispositions persist the same way,
in the committed inspection registry, keyed and pinned so each stands
until the code it names moves."** Honored on every element, and the
"same way" comparison is exact rather than loose. The registry is one
committed file in the audit corpus at `.ok-planner/audits/inspection.md`,
its format defined canonically in `{{INSPECTION-REGISTRY-FORMAT}}`
alongside the audit file format, written by the inspector at its method
step 4b and by nothing else. Entries are keyed to source-graph node
identities and pinned to the node's recorded hash, exactly the shape a
`cite-node:` line uses. Only the judged classes are stored — the parser
accepts `residue` and `adjudicated` and nothing else, rejecting any other
class as `inspection-malformed`, and an `adjudicated` entry must name a
live audit file or it is malformed too, which is what makes the pointer a
real pointer rather than a label. Precedent semantics are implemented as
stated: `check_inspection` treats an entry as live only while
`erows[identity] == pin` against the current committed graph, so an entry
lapses the moment the node's content moves or its identity vanishes, and
the inspector is told to carry live entries forward untouched, prune
vanished identities, and re-judge lapsed ones — the incremental
maintenance the sentence promises. Two harness fixtures hold the two
directions (`inspection: residue entry covers` must exit 0;
`inspection: lapsed entry trips` must trip). The registry exists on this
tree carrying four `adjudicated` entries whose `audit:` pointers resolve
to the audit holding the matching notes — the round trip completing, not
just the format existing. (The file itself is not pinned here: its
`inspected:` stamp moves on every pass, so a pin would re-open this audit
on the record's own bookkeeping rather than on anything a claim rests
on.)

**"A recorded adjudication binds later runs: departing from one requires
naming the cited reality that changed."** Honored, with the two
mechanical escapes stated in the same breath rather than left implicit:
an adjudication whose own cited reality moved is open again, and a design
artifact whose hash moved lapses its audit's precedent wholesale — the
artifact is re-audited fresh and prior notes stand as history. The same
binding rule is stated canonically in the audit file format, so it
governs any reader of an audit, not only the dispatched auditor; the
auditor prompt states it in the imperative, inside the method step that
makes reading the prior audit the first act ("adjudications BIND you:
depart from a recorded promotion or dismissal only by naming the cited
reality that changed"). This audit is an instance of the escape working
as specified rather than as a loophole: the artifact hash moved, so the
prior reasoning was set aside and every clause re-derived — and the
determination did not move, because the reality did not.

The consumer-side statement of the same rule reaches a consumer project
through the two documents the family's converge materializes into every
estate — the estate guide and the project cheatsheet, both rendered from
templates under the family's `scripts/` — and both carry the rule in
prose the owner reads: the auditor adjudicates each note, promoted into a
citation or dismissed with a reason, and recorded adjudications bind
later runs unless the cited reality moves. Those templates are the
shipped surface and are what is cited below; this repository's own
vendored copies are not evidence for a claim about what the suite ships,
because `decision:per-project-pinning` deliberately holds them at the
last committed converge.

Two independent corroborations that this is the regime rather than a
slogan: `audit-check` is what makes "cited reality moved" checkable
rather than assertable, and `checks/oscillation` reads git history for the
exact violation this sentence forbids — a determination that flipped
between two committed versions while the artifact hash and every citation
stood still. That detector is report-only and never blocks, which its own
header states; the Choice claims binding by record, not by a blocking
check, so this is corroboration and not the enforcement point.

**"The gate closes only when every hunk of the change carries a
disposition — mechanically accounted, adjudicated, or residue."**
Honored at four citable points, with the population of gates enumerated
from the converge core's `SKILLS` map rather than assumed: both
`certify-work` and `certify-all` carry it in their implementation-audit
producer's clean bar ("no ledger hunk is without a disposition"), the
shared core states it once for both ("The gate does not present as clean
while any hunk lacks a disposition"), and the presentation block repeats
it as a status rule ("A hunk without a disposition blocks a clean status;
if any remain, the run is NOT certified and they are listed here"). The
three disposition values are defined once, in the inspector, with the
test for each, and the inspector is told no hunk may be left without one.
This clause is about the *inspector's* hunk-level ledger and the gate's
clean bar, and it is honored as such — the narrower question of whether a
*checker* can mechanically verify that ledger's completeness over every
changed node is `decision:inspection-registry`'s and
`decision:two-layer-invalidation`'s claim, charged there and deliberately
not charged here, because no sentence of this decision makes it.

**"and residue (change no claim accounts for) is reported to the owner as
intake material and served to the project's local corpus view, never
silently dropped."** Honored on both destinations, and the second is new
this cycle — the exact shape of claim that usually fails on one leg, so
each was checked separately. Owner-facing: the inspector's report step
requires the residue enumerated with file, region, and one line on what
it is, explicitly as intake material for the owner and explicitly not the
inspector's judgment call, with its rules barring it from filing,
classifying beyond "no claim accounts for it", or proposing fixes; the
presentation's Reconciliation ledger section is the terminus — counts per
disposition, the adjudication outcomes, and the residue enumerated one
line each, "reported here and never silently dropped" — and both gates
name that section in their own presentation instructions. View-facing:
`corpus-view` exposes `/api/inspection`, whose handler parses the registry
fresh per request through the project's own checker and marks each entry
live or lapsed against the current committed graph, with its docstring
naming the residue list as "the dashboard's unclaimed-territory report";
the frontend consumes it (`inspection()` in `browser/src/lib/api.js`),
filters `class === 'residue'`, and renders a standing-residue section
with the last inspection stamp. The released bundle carries it too — the
built `browser/dist/assets/index-CSM9Eawd.js` contains both the
`/api/inspection` fetch and the rendered "standing residue" copy — so the
claim holds for the artifact a consumer project actually receives, not
only for the source.

**"The inspector re-runs each fix cycle over the then-current diff, so
the ledger the presentation reports describes the change as it finally
stands."** A supporting sentence in the core, and it holds: the core's
re-review step and both gates' loop descriptions re-run the inspector
over the then-current diff, so the ledger is not a first-pass artifact.

**Rationale — "Oscillation lives in re-derivation: two readings of
unchanged reality can disagree, and when nothing records the first
reading, the second is free to flip it. Recording adjudications makes
convergence a property of the record rather than of agent temperament — a
flip must point at changed reality."** A capability claim, delivered by
the binding rule above rather than merely asserted: the auditor is
required to read the prior audit first as "the record you transact
against, not scratch paper", and the only sanctioned departure is naming
the cited reality that changed.

**Rationale — "the closure requirement turns 'was everything
considered?' from a hope into a checkable invariant, at a bookkeeping cost
proportional to the change."** Honored, and stronger this cycle than it
was: the invariant is checkable because the inspector enumerates the
change as hunks and must disposition each, and it is now *also* machine-
checkable over the changed nodes the floor sees. The cost scales with the
hunk count, and the registry's precedent semantics keep it proportional to
the *new* work rather than to the accumulated history — last sprint's
residue rides forward untouched.

**Rationale — "at a bookkeeping cost proportional to the change" as
applied to the registry.** Checked for the obvious failure mode, that the
registry would grow without bound: the inspector is instructed to prune
entries whose identities vanished and to replace lapsed ones, and only the
judged classes are stored, with the mechanical account recomputed rather
than recorded — so the record's size tracks standing unclaimed territory
rather than change history.

**Alternatives.** All three are genuine roads not taken and none is in
force: judgment is not fresh at every run (the binding rule and the
registry's precedent semantics); precedent is not prompt discipline only
(the notes, adjudications and registry entries are written into committed
files a deterministic checker computes staleness over); and disposition
tracking carries reasons (a dismissal must state one, a residue entry
must carry a `note:`, and the auditor is told to carry adjudications
forward verbatim).

## Determination

**satisfied.** Every clause has a specific write site or enforcement
sentence, and the pieces fit into one loop rather than sitting beside each
other: the inspector writes notes in a format the canonical audit
template defines and dispositions in a format the canonical registry
template defines; the auditor is the sole adjudicator of the notes and may
not leave one open; the adjudication binds the next auditor with two named
mechanical escapes, one of which this very pass exercised without moving
the determination; the determinations, notes and registry entries live in
committed files a deterministic checker already computes staleness and
liveness over; and both gates refuse a clean status while any hunk lacks a
disposition or any note stays open. The clause added this cycle is real
and not a relabeling: the registry is node-keyed, hash-pinned,
judged-classes-only, precedent-lapsing, inspector-written, and
checker-read, which is the audit corpus's own discipline applied to the
inspection's state. Residue has a defined shape, a defined reporter, a bar
on the reporter deciding anything about it, a named section of the owner's
presentation, and — verified through to the built bundle a consumer
receives — a live surface in the corpus view.

Two boundaries worth stating for a later reader, neither charged because
no sentence of this decision claims otherwise. The fixer's calls and the
architect's refutations are surfaced in the presentation for veto but are
not written into a record the next run reads; "every judgment the gate
consumes" reaches the judgments carried between runs, not a run's own
discharged calls, and if that sentence were ever read as requiring a
durable ledger of fixer calls too, this would flip. And the closure
sentence here is about the inspector's hunk-level ledger and the gate's
clean bar, not about a checker verifying that ledger's completeness over
every changed node — the sibling decisions make that claim, and it is
charged there.

This stops holding if: the inspector's note-writing step is removed or
loosened so nominations are reported only in-context; the inspector's
registry step 4b is removed, so the inspection's dispositions stop
persisting; the `## Notes` section or the `{{INSPECTION-REGISTRY-FORMAT}}`
block leaves the canonical definitions file, so writer and reader stop
agreeing on one shape; the registry stops being node-keyed and
hash-pinned, or its entries stop lapsing when the node moves (the
`parse_inspection_registry` and `check_inspection` spans break first), or
it starts storing the mechanical disposition; an `adjudicated` entry is
allowed to name no audit file, so the pointer stops pointing; the auditor
is allowed to leave a note open, to drop or rewrite existing notes, or to
depart from a recorded adjudication without naming changed reality; either
gate drops "no ledger hunk is without a disposition" or "no note is left
open" from its clean bar, or the core drops the same rule; the
presentation loses its Reconciliation ledger section or stops enumerating
residue; `corpus-view` stops serving `/api/inspection`, or the view stops
rendering the residue list, or a release ships a bundle that no longer
carries it, so the second destination becomes a claim about source only;
the estate guide or cheatsheet template stops carrying the binding rule
and the three dispositions to the consumer; or `checks/oscillation` is
deleted, which would not by itself falsify the Choice but removes the only
instrument that can observe the property failing in history.

## Citations

- cite-node: plugins/ok/families/ok-planner/skills/_shared/certification-core.md @ sha256:f42b50f44a66
- cite-node: plugins/ok/families/ok-planner/skills/_shared/certification-core.md#certification-core.how-consumers-use-this-file.change-inspector-prompt @ sha256:c1f9ccb49f08
- cite-node: plugins/ok/families/ok-planner/skills/_shared/certification-core.md#certification-core.how-consumers-use-this-file.certify-presentation @ sha256:b27fc9b325a6
- cite-node: plugins/ok/families/ok-planner/skills/_shared/implementation-auditor.md @ sha256:049ea0635856
- cite-node: plugins/ok/families/ok-planner/skills/certify-work/SKILL.md @ sha256:3fa398a77d5e
- cite-node: plugins/ok/families/ok-planner/skills/certify-all/SKILL.md @ sha256:c4edf29db435
- cite-node: plugins/ok/families/ok-planner/skills/_shared/artifact-definitions.md#shared-artifact-definitions.token-catalog.inspection-registry-format @ sha256:5f1c4527fd56
- cite-node: plugins/ok/families/ok-planner/skills/_shared/artifact-definitions.md#shared-artifact-definitions.token-catalog.audit-file-format @ sha256:34118b5fbfb8
- cite-node: plugins/ok/families/ok-planner/scripts/audit-check @ sha256:32b1732e3fdd
- cite-node: plugins/ok/families/ok-planner/scripts/corpus-view @ sha256:c985b50ad376
- cite-node: plugins/ok/families/ok-planner/browser/src/views/Overview.svelte @ sha256:c76108d97ac0
- cite-node: plugins/ok/families/ok-planner/browser/src/lib/api.js @ sha256:12ecd77eaa01
- cite-node: plugins/ok/families/ok-planner/browser/dist/assets/index-CSM9Eawd.js @ sha256:a6d2942e2799
- cite-node: plugins/ok/families/ok-planner/test/run.sh @ sha256:a4d8463946b0
- cite-span: plugins/ok/families/ok-planner/skills/_shared/artifact-definitions.md :: "The recorded-adjudication ledger for this audit" +18 sha256:5a5279d030c3
- cite: plugins/ok/families/ok-planner/skills/_shared/artifact-definitions.md :: "It stores only the **judged** classes — the mechanical disposition is never stored"
- cite: plugins/ok/families/ok-planner/skills/_shared/artifact-definitions.md :: "Written only by certification's change inspector, never hand-edited; parseable by tooling (the dashboard reads its residue)."
- cite-span: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "**The reconciliation ledger.** The inspector also dispositions every hunk" +1 sha256:14044e76fddb
- cite-span: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "  3. Disposition the hunk:" +15 sha256:9b3cbeeaa602
- cite-span: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "  4. Record each nomination as a provisional note on the audit it" +8 sha256:4285e41b1b38
- cite-span: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "  4b. Update the inspection registry per the format above: one" +12 sha256:4371ec2c3a2d
- cite-span: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "## Reconciliation ledger" +8 sha256:b33ce3b03c6f
- cite-span: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "4. **Re-review.** Re-run each producer whose findings were worked" +1 sha256:925bc9bd6fde
- cite: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "The fixer never edits an audit file"
- cite-span: plugins/ok/families/ok-planner/skills/_shared/implementation-auditor.md :: "  0. Read the prior audit file first, if one exists — it is the" +17 sha256:0dc64431681a
- cite-span: plugins/ok/families/ok-planner/skills/_shared/implementation-auditor.md :: "     citations, the determination the DECIDABLE claims add up to," +16 sha256:298046b88a19
- cite: plugins/ok/families/ok-planner/skills/certify-work/SKILL.md :: "This producer's clean bar: `audit-check --inspection` exits 0 (citations current AND every changed node dispositioned — the mechanical proof the judgment pass ran against the change as it stands)"
- cite: plugins/ok/families/ok-planner/skills/certify-all/SKILL.md :: "Clean bar: `.ok-planner/bin/audit-check --inspection` exits 0 (citations current AND every changed node dispositioned — the mechanical proof the judgment pass ran against the tree as it stands)"
- cite-span: plugins/ok/families/ok-planner/scripts/audit-check :: "def parse_inspection_registry(root, findings):" +54 sha256:291c5d011709
- cite-span: plugins/ok/families/ok-planner/scripts/audit-check :: "def check_inspection(root, findings, stale_files, stale_identities," +62 sha256:e1dca42e84fe
- cite: plugins/ok/families/ok-planner/scripts/audit-check :: "INSPECTION_CLASSES = ("residue", "adjudicated")"
- cite-span: plugins/ok/families/ok-planner/scripts/corpus-view :: "    def inspection_now(self):" +6 sha256:48119285ab48
- cite: plugins/ok/families/ok-planner/scripts/corpus-view :: "        if path == "/api/inspection":"
- cite: plugins/ok/families/ok-planner/test/run.sh :: "run_case "inspection: residue entries cover a new file whole""
- cite: plugins/ok/families/ok-planner/test/run.sh :: "run_case "inspection: lapsed entry trips""
- cite-span: checks/oscillation :: "def audit_flips():" +28 sha256:73bc4b08d1f8
- cite: checks/oscillation :: "# Report-only by design: findings print, the exit code stays 0, and"
- cite-span: plugins/ok/families/ok-planner/admin/converge :: "SKILLS = {" +13 sha256:19e4a08de7f5
- cite: plugins/ok/families/ok-planner/scripts/ok-planner-CLAUDE.md :: "dismissed with a reason — and recorded adjudications bind later runs"
- cite: plugins/ok/families/ok-planner/scripts/ok-planner-CLAUDE.md :: "mechanical / adjudicated / residue — the"
- cite: plugins/ok/families/ok-planner/scripts/ok-planner-cheatsheet.md :: "a citation or dismissed with a reason — recorded adjudications"
- cite: plugins/ok/families/ok-planner/scripts/ok-planner-cheatsheet.md :: "dispositioned (mechanical / adjudicated / residue), residue is"
