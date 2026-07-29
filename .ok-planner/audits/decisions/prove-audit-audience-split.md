---
audit: prove-audit-audience-split
artifact: decision:prove-audit-audience-split
determination: satisfied
audited: 2026-07-28T22:30:00Z
artifact-hash: sha256:b54c3ac8ecde
---

# Do both corpus-checking verbs report in-context, is the proof run's cost record really its one durable trace, and does a certification finding still reach the intake through exactly one gated agent writer?

Rewritten whole. The design artifact's own hash moved: the Choice dropped
"pure" from "pure in-context reporters" and gained a new sentence — "The audit
writes nothing at all; the proof run's one durable trace is the machine-local
record of what each executed proof cost — a measurement, not a finding, and no
more a claim on the owner's attention than the in-context report is." That
amendment is precisely a concession that one of the two verbs now leaves
something behind, so the prior audit's precedent lapses and every clause is
re-derived. Its two notes and their adjudications are carried forward below as
history, not as binding.

The adversarial question this cycle is narrow and sharp: the decision's whole
point is that neither reporting verb costs the owner attention, and one of
them now writes a file. So the new sentence was tested three ways — is it
really *one* trace, is it really *machine-local*, and is it really *not a
finding* by this corpus's own definition of the word.

## Claims

**Title — "Both corpus-checking verbs report in-context; the architect is the
intake's one gated writer."** Both halves hold. The second is a claim about
*gating*, not exclusive membership: among the writers into the intake, only
the architect applies a gate. The enumeration below finds no second gated
writer.

**Choice clause 1 — "The two corpus-checking verbs are in-context reporters
distinguished by audience: the proof run reports to the executing agent at
machine tempo, and the audit reports to its caller — the human who invoked it,
or the certification gate consuming it as a producer — with every finding
classified mechanical or judgment."** Honored. The population is two verbs,
`prove` and `audit`, enumerated from the converge core's `SKILLS` map (what a
consumer actually receives; `audit` vendored as `ok-planner-audit`) rather
than from the decision's own examples. `prove` declares itself a producer of
"work items for an **agent**, not a human" with a fixed in-context report
shape; `audit` declares itself a "**pure reporter**" that "returns everything
in-context, and writes nothing", opens its process with "Create nothing", and
classifies every finding mechanical or judgment across its four passes.

Two verbs were added to the family this cycle and both were tested as
candidates to widen the population, because a new corpus-facing verb is
exactly what would falsify a "the two verbs" claim. Neither does. `/browse`
is a read-only *view*, not a checker: it renders determinations someone else
recorded, "never re-audits, never re-derives a verdict", and resolves
staleness by calling the project's own `audit-check` rather than judging; its
service opens files for reading and writes only to its socket. The
`source-graph` tool is a deterministic extractor and drift checker over source
files, not over the corpus's claims. Neither reports findings about stories or
decisions, and neither writes the intake.

**Choice clause 2 — "Neither verb writes the issue intake."** Honored, and
pinned against quiet erosion: prove's never-writes sentence stands in both its
body and its frontmatter; audit's NOT-do list closes "Does not touch the issue
intake — no filing, no editing, no closing"; and a repository maintenance
assertion registered under this decision's own annotation fails if either
governing line is deleted or reworded. The check runs clean on the current
tree.

**Choice clause 3 (new) — "The audit writes nothing at all; the proof run's
one durable trace is the machine-local record of what each executed proof cost
— a measurement, not a finding, and no more a claim on the owner's attention
than the in-context report is."** Honored on all three of its testable parts.

*The audit writes nothing at all.* Stronger than "writes no issues", and the
text is correspondingly stronger: "returns everything in-context, and writes
nothing", and step 1's "it does not even ensure its own layout: if
`.ok-planner/issues/` or `.ok-planner/history/issues/` is absent, report that
in the findings … and carry on." A missing directory is a finding, not a
`mkdir` — which is the sharpest available form of the claim, since ensuring
one's own layout is the one write a read-only verb usually forgives itself.
The suite's own roster proof asserts exactly this sentence against the verb a
project runs.

*The proof run's durable trace is one file, and that file.* The verb's NOT-do
list says it: "the only thing a run leaves behind is
`.ok-planner/proof-timings.json`". Checked against the recorder rather than
the promise: `cmd_run` creates a system tempfile for the child's emitted
spans and unlinks it after reading; `merge`/`save_store` write exactly
`<root>/.ok-planner/proof-timings.json`, creating only that file's parent
directory. There is no second output path, no log, no marker file.

*Machine-local, and therefore not a claim on owner attention.* The estate's
own ignore file names `proof-timings.json`, and the converge core renders that
ignore file into every consumer estate — so the record is real on disk, read
freely, and never content of the repository (and, because the graph asks git
what is ignored, never in the source graph either). The recorder's own header
states the reason in the decision's terms: "a profile of this machine, not a
commitment of the project".

*A measurement, not a finding.* This is the part that could have been a bare
assertion and is not. `concept:finding` fixes "finding" as one defect surfaced
by a review pass; a row saying a proof took 0.331 seconds surfaces no defect,
and the record has no field in which a defect could be expressed — every entry
is story, proof path, verdict, seconds, scope, timestamp, cases. The verdicts
it carries are the same four the in-context report carries, and they reach the
owner nowhere: the file is git-ignored and the intake is untouched. So the
sentence's final clause — "no more a claim on the owner's attention than the
in-context report is" — is accurate rather than rhetorical.

**Choice clause 4 — "A certification finding reaches the intake through
exactly one gated agent writer: certification's architect, filing only
findings that survived the fixer's veto test and its own adversarial
check."** Honored. Re-enumerated from the two gates and their shared core:

- Producers (sprint alignment, `/prove`, the implementation audit, the corpus
  checks, code review) are stateless reporters that "never file issues and
  never fix"; the one defined exception is the implementation auditor, whose
  output is audit documents under `.ok-planner/audits/`, not intake files.
- The change inspector writes only provisional notes into audit files, and its
  own rules state "Residue is a report, never a verdict — you do not file
  issues".
- The reconciliation ledger's residue reaches the owner through the
  presentation, enumerated for the owner to act on — reported, never filed.
- The orchestrator holds no discretion: "Promotion is the loop's only path to
  the intake, and the owner is never asked live."
- The fixer's only legal non-fix is a kickback, gated by the veto test; it
  writes no issue.
- The architect is the sole writer, on CONFIRM only, after adversarially
  testing the kickback with an explicit bias to refute, deduped against every
  slug already present, stamping `kind: audit`.
- `/verify-issues`, invoked by both gates *after* promotion, creates nothing on
  a converged project: its only file-creating step is the legacy
  `issues.jsonl` conversion.
- Both gates' NOT-do lists restate it: "only the architect's confirmed forks
  reach the intake."

The clause has live instances, and they were re-checked rather than carried.
Four issue files now sit in `.ok-planner/issues/`; three are the
architect-filed ones this audit already recorded (`kind: audit`, the value the
CONFIRM branch instructs), and all four are now stamped `status: promoted`
into the sprint under certification — the one-way handoff the lifecycle
requires, with the intake's involvement over.

**Choice clause 5 — "That gate governs the repeating cycle's findings, not the
intake's whole membership — humans file directly whenever they choose, the
ceremonies that transcribe the owner's own questions file directly, and so
does the one-time corpus bootstrap … a run that aborts rather than repeat over
a populated corpus cannot accumulate against the owner."** Honored, and the
population was re-enumerated across the whole intake, live plus archived,
because a new file appeared since the last reading. **54 files: `kind:
discover` ×46 (the one-time bootstrap, this clause's named ungated
exception), `kind: audit` ×5 (the gate), `kind: human` ×3 (humans filing
directly, also this clause).** No file carries any other kind and no file's
kind is unaccounted for by the Choice's roll call. The one new file since the
prior reading — the owner's own question about verification-cost work having
no measurement discipline, the question that produced
`decision:measure-first-verification-cost` — is `kind: human`, an owner
question filed directly, exactly the branch the clause names. Critically, the
gate's count did not move: the only agent writer inside the repeating close
cycle has produced five files across the project's life, while the ungated
one-time run produced forty-six.

The bootstrap's bound is implemented at every point: `/discover-design`'s state
detection stops at "Non-empty `concepts/`, `stories/`, or `decisions/` →
abort", the abort precedes phase 1 so an aborted run writes no issue file at
all, `story:bootstrap-design-corpus` commits to the same behavior, and nothing
invokes the bootstrap programmatically. `/plan-sprint` files only questions the
owner postponed; `/verify-issues`' legacy conversion transcribes ids already
open in a retired container.

One writer still sits outside the sentence's literal list, recorded rather
than glossed: the family's administration document, migrating a pre-4.0
`design/tensions/` tree, writes one issue file per live tension. It surfaces
no defect of its own, stamps `kind: "human"`, transcodes questions that were
already the owner's queue, and skips slugs already present — the same
container-conversion shape the clause already covers in `/verify-issues`. Read
as an exhaustive roll call of everything that has ever appended a file, the
clause would miss it; read as what it says, it stands.

**Choice clause 6 — "The owner's durable agenda is a property of that
promotion gate — adversarial confirmation before anything costs owner
attention — never of either reporting verb; deduplication against the slugs
already present is the standing discipline of every writer into the intake,
the gate included."** Honored. Adversarial confirmation is the gate's alone —
no other writer tests its filing against a roleplayed owner. Dedup is
attributed to all writers, which is what the code says: the canonical issue
file format states it as binding for every filer and is transcluded into the
prompts of the writers that file; the conversion skips ids already filed; the
certification loop dedups before the fixer runs. The negative half holds too:
neither reporting verb supplies any of it — and the proof run's new durable
trace supplies none of it either, because it is not an agenda.

**Rationale — "The split keeps execution unblocked and the owner
uninterrupted … Routing certification's findings through one adversarial gate
is what keeps the intake meaning 'requires owner calibration': certification
runs at every close, so a reporting verb that also filed would be a second
ungated writer inside that repeating cycle."** Honored. "Certification runs at
every close" is literal: `/certify-work` is a fixed clause of the completion
contract baked into every sprint the ceremony writes. The hazard is stated
hypothetically and remains unrealized: no certification-time producer files,
and neither the change inspector nor the ledger does.

**Rationale — "The corpus bootstrap files ungated without defeating that,
because it sits outside the repeating cycle."** Honored — same evidence as
clause 5: the refusal is implemented, story-backed, and slash-command-only.

**Rationale — "A standalone audit's judgment findings still reach the owner:
the human who ran it is holding the report, and reading it is the calibration
act."** Honored: "The caller decides what happens next; the audit routes
nothing", and "A human running `/audit` standalone fixes what they choose and
files what they judge fork-worthy themselves."

**Alternatives.** All three are roads not taken, correctly recorded. "One verb
doing both" and "Both verbs writing the intake" contradict the shipped shape;
"The audit filing its own judgment class" names costs that match the code.

**Corroborating surfaces agree.** The estate guide template and this project's
materialized `.ok-planner/CLAUDE.md` carry the same filer sentence the Choice
states — the architect as "the gated path", alongside the bootstrap,
`/plan-sprint` transcription, and humans. `concept:finding` states the same
routing as a property of findings ("it never by itself puts anything in front
of the owner — reaching the intake is a separate, gated act"; "the intake is
reached only by a deliberate act of filing") and cross-references this
decision. That corroboration is not a corpus duplication defect: the concept
states the rule of *findings*, the decision of *the verbs and the gate*, and
the concept names no writer the decision does not.

## Determination

**satisfied.** The verb half holds: `prove` and `audit` are still the whole
population of corpus-checking verbs — the cycle's two new corpus-facing tools
are a read-only view that calls the project's checker rather than judging, and
a graph extractor — both verbs report in-context with exactly the described
audiences, the mechanical/judgment classification is real and carried into the
report, neither touches the intake, and a maintenance assertion pins both
governing sentences.

The amended sentence is the one this pass existed to test, and it survives
adversarially. "Writes nothing at all" is the audit's actual stance, taken to
the point of refusing to create its own layout. The proof run's durable trace
really is one file and only one — the recorder's tempfile is unlinked and no
other path is written — it really is machine-local, because the estate's own
ignore file names it and converge places that ignore file, and it really is
not a finding under this corpus's own definition, because it records no defect
and has no field in which one could appear. The decision conceded a durable
output and then bounded it exactly as far as the code bounds it.

The gated-writer half holds. Inside certification the architect is still the
only writer: producers are forbidden to file, the inspector writes only
provisional notes into audit files, the ledger's residue is presented rather
than filed, the orchestrator has no discretion, and `/verify-issues` creates
nothing on a converged project. Enumerated across the whole intake — 54 files,
46 `discover`, 5 `audit`, 3 `human` — every file is accounted for by the
Choice's roll call, the gate's own count is unchanged since the last reading,
and the one new file is an owner question filed directly, which is the
carve-out working rather than an exception to it.

This stops holding if: either reporting verb acquires a write into
`.ok-planner/issues/` (the `text-presence` assertion fails first); the proof
run acquires a second durable output, or its record stops being ignored by the
estate (at which point "machine-local, no claim on attention" fails and the
record becomes repository content); the audit acquires any write, including
ensuring its own layout; the change inspector or any successor producer is
given filing authority, or the reconciliation ledger's residue starts being
filed rather than reported; the architect's CONFIRM branch stops being
adversarial, stops deduping, or stops stamping `kind: audit`; `concept:finding`
reverts to routing judgment findings into the queue by classification alone;
`/discover-design` loses its abort-before-phase-1 guard; an intake file appears
carrying a kind the Choice's roll call does not account for, or two files share
a slug; a third corpus-checking verb appears; or the intake gains a new agent
writer inside the repeating close cycle.

## Notes

Both notes below were opened and adjudicated in the prior pass, before this
artifact's hash moved. They are carried forward verbatim as history; neither
binds this rewritten determination, and both remain consistent with it.

- note: `.ok-planner/design/concepts/finding.md` — Purpose and Boundaries rewritten to the gated intake routing ("it never by itself puts anything in front of the owner — reaching the intake is a separate, gated act"; "the intake is reached only through the gated writers … certification's architect files what survived the fixer's veto test and its own adversarial check"), restating this decision's Choice almost verbatim a few lines below this audit's untouched `cite:` anchor on that same file — changed bytes inside a claim's territory that no citation caught.
  adjudication: promoted — read against the prior text rather than only the new: the concept previously made the mechanical/judgment classification itself the route into the queue ("Judgment findings become open rows in the intake queue"; "Everything downstream … follows from the classification"), which contradicted the Choice's core denial, and the rewrite removes that contradiction and cross-references this decision, so the corroborating-surfaces claim strengthens; tested for the failure mode a near-verbatim restatement would signal — corpus duplication — and it is not one, since the concept states the rule as a property of findings while the decision states it of the verbs and the gate, and the concept names no writer the decision does not; the nominated territory is now carried by the two new anchors on the concept's Purpose and Boundaries sentences alongside the pre-existing anchor on its opening definition.
- note: `.ok-planner/issues/2026-07-28-101259-plumbline-{ci-emission,explain-verb,slug-verb}-ungoverned.md` — three new architect-promoted issue files (`kind: audit`), the first live instances of this decision's "one gated agent writer" claim since the audit was written; worth checking them against the claimed shape rather than reading the gate's prompts again.
  adjudication: promoted — all three verify against the shape the Choice fixes: `kind: audit` as the certification core's CONFIRM branch instructs, `status: open`, exactly the filer's `## Problem` + `## Candidates` slice with no Discussion or Ruling, slugs unique across all fifty-three files in `issues/` and `history/issues/`, and a Problem section attributing the finding to `/certify-all`'s surface inventory — a pass of `/audit`, the pure reporter forbidden to touch the intake — so origin and filing are separated exactly as claimed; the whole-intake kind enumeration (46 `discover`, 5 `audit`, 2 `human`) accounts for every file under the Choice's own roll call with no unexplained writer; the nominated territory is now carried by existence anchors on the three files' stable `issue:` slugs (which survive `/verify-issues`' rewrite, unlike a body pin) and by the pinned CONFIRM span and `kind: audit` anchor in the certification core.

## Citations

- cite: plugins/ok/families/ok-planner/skills/prove/SKILL.md :: "never writes to the issue intake"
- cite: plugins/ok/families/ok-planner/skills/prove/SKILL.md :: "produces work items for an **agent**, not a human"
- cite: plugins/ok/families/ok-planner/skills/prove/SKILL.md :: "the only thing a run leaves behind is"
- cite-node: plugins/ok/families/ok-planner/skills/prove/SKILL.md#prove-the-corpus.what-this-skill-does-not-do @ sha256:0ea56c9a8b95
- cite: plugins/ok/families/ok-planner/skills/audit/SKILL.md :: "Audit is a **pure reporter**"
- cite: plugins/ok/families/ok-planner/skills/audit/SKILL.md :: "returns everything in-context, and writes nothing"
- cite: plugins/ok/families/ok-planner/skills/audit/SKILL.md :: "1. Create nothing. This verb is read-only against the project"
- cite: plugins/ok/families/ok-planner/skills/audit/SKILL.md :: "it does not even ensure its own layout"
- cite: plugins/ok/families/ok-planner/skills/audit/SKILL.md :: "Does not touch the issue intake — no filing, no editing, no closing"
- cite: plugins/ok/families/ok-planner/skills/audit/SKILL.md :: "The caller decides what happens next; the audit routes nothing."
- cite: plugins/ok/families/ok-planner/skills/audit/SKILL.md :: "only the architect's confirmed forks are promoted to"
- cite: plugins/ok/families/ok-plumbline/test/run.sh :: "ok-planner: its compliance verb writes nothing at all, not even its own layout"
- cite-span: plugins/ok/families/ok-planner/scripts/proof-timings :: "def merge(root, entries):" +11 sha256:41a6f2c2ea01
- cite: plugins/ok/families/ok-planner/scripts/proof-timings :: "    env = dict(os.environ, PROOF_TIMINGS_OUT=spans_file)"
- cite: plugins/ok/families/ok-planner/scripts/ok-planner-gitignore :: "proof-timings.json"
- cite: plugins/ok/families/ok-planner/admin/converge :: "sed "s/{{OK_PLANNER_VERSION}}/${SUITE_VERSION}/g" "$ESTATE_GITIGNORE" > "${OK_DIR}/.gitignore""
- cite-span: plugins/ok/families/ok-planner/admin/converge :: "SKILLS = {" +12 sha256:8aa7cd5969fb
- cite: plugins/ok/families/ok-planner/skills/browse/SKILL.md :: "The view is read-only. Nothing in this verb writes to the working tree."
- cite: plugins/ok/families/ok-planner/skills/browse/SKILL.md :: "this verb never re-audits, never"
- cite-span: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "**Producers.** The gate's review passes" +3 sha256:90d28ae26d4e
- cite-span: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "**Promotion is the loop's only path to the intake, and the owner is never asked live.**" +4 sha256:116a2d0fedf8
- cite: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "1. **Dedup.** Subtract findings already promoted"
- cite-span: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "  - **CONFIRM and promote.** If a reasonable owner might genuinely" +9 sha256:e4b6b68da15f
- cite: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "  - Residue is a report, never a verdict — you do not file issues, do"
- cite: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "    {{ISSUE-FILE-FORMAT}} (kind `audit`, category from the"
- cite: plugins/ok/families/ok-planner/skills/certify-work/SKILL.md :: "only the architect's confirmed forks reach the intake"
- cite: plugins/ok/families/ok-planner/skills/certify-all/SKILL.md :: "only the architect's confirmed forks reach the intake"
- cite: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md :: "a question the owner explicitly postpones is filed to"
- cite: plugins/ok/families/ok-planner/skills/verify-issues/SKILL.md :: "For each open id, write an issue file to"
- cite-span: plugins/ok/families/ok-planner/skills/discover-design/SKILL.md :: "   - Non-empty `concepts/`, `stories/`, or `decisions/` → abort." +4 sha256:ae1026698373
- cite: plugins/ok/families/ok-planner/skills/discover-design/SKILL.md :: "each unresolved finding as an issue file under"
- cite: plugins/ok/families/ok-planner/skills/discover-design/SKILL.md :: "agent-confessed-uncertainty observations as issue files"
- cite: plugins/ok/families/ok-planner/skills/discover-design/SKILL.md :: "4. One issue file written to `.ok-planner/issues/` per case"
- cite: plugins/ok/families/ok-planner/skills/_shared/artifact-definitions.md :: "- **`issue:` is a stable fingerprint**"
- cite: plugins/ok/families/ok-planner/skills/_shared/artifact-definitions.md :: "- **Ownership follows the lifecycle.**"
- cite: plugins/ok/families/ok-planner/admin/ADMINISTRATION.md :: "issue file to `.ok-planner/issues/` per `{{ISSUE-FILE-FORMAT}}` with"
- cite-span: plugins/ok/families/ok-planner/scripts/ok-planner-CLAUDE.md :: "chronologically. Filed by certification's architect (the gated" +5 sha256:6c820f572ed6
- cite-span: .ok-planner/CLAUDE.md :: "chronologically. Filed by certification's architect (the gated" +5 sha256:6c820f572ed6
- cite: .ok-planner/design/concepts/finding.md :: "A finding is one defect surfaced by any of the suite's review passes"
- cite: .ok-planner/design/concepts/finding.md :: "it never by itself puts anything in front of the owner — reaching the intake is a separate, gated act"
- cite: .ok-planner/design/concepts/finding.md :: "the intake is reached only by a deliberate act of filing"
- cite: .ok-planner/design/concepts/issue.md :: "Many writers may open; only the planning ceremony"
- cite: .ok-planner/design/stories/bootstrap-design-corpus.md :: "On a project with non-empty durable catalogs the run aborts"
- cite: .ok-planner/issues/2026-07-28-101259-plumbline-ci-emission-ungoverned.md :: "issue: plumbline-ci-emission-ungoverned"
- cite: .ok-planner/issues/2026-07-28-101259-plumbline-explain-verb-ungoverned.md :: "issue: plumbline-explain-verb-ungoverned"
- cite: .ok-planner/issues/2026-07-28-101259-plumbline-slug-verb-ungoverned.md :: "issue: plumbline-slug-verb-ungoverned"
- cite: .ok-planner/issues/2026-07-28-103138-verification-cost-work-has-no-measurement-discipline.md :: "issue: verification-cost-work-has-no-measurement-discipline"
- cite: checks/text-presence :: "# @decision: prove-audit-audience-split"
- cite-node: plugins/ok/families/ok-planner/skills/audit/SKILL.md @ sha256:28563955e674
- cite-node: plugins/ok/families/ok-planner/skills/prove/SKILL.md @ sha256:c015b0e2ffd7
- cite-node: plugins/ok/families/ok-planner/skills/browse/SKILL.md @ sha256:772c8b604d8a
- cite-node: plugins/ok/families/ok-planner/skills/discover-design/SKILL.md @ sha256:80c8c02787b4
- cite-node: plugins/ok/families/ok-planner/skills/_shared/certification-core.md @ sha256:f96e5bcb96d6
- cite-node: plugins/ok/families/ok-planner/admin/converge @ sha256:a75d56bfab1e
- cite-node: plugins/ok/families/ok-planner/scripts/proof-timings @ sha256:a02e8cbfb2fa
- cite-node: plugins/ok/families/ok-planner/scripts/corpus-view @ sha256:2482b9ac2fed
