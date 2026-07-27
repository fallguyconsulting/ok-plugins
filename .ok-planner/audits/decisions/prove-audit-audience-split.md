---
audit: prove-audit-audience-split
artifact: decision:prove-audit-audience-split
determination: satisfied
audited: 2026-07-27T00:00:00Z
artifact-hash: sha256:3a32f3d14707
---

# Do both corpus-checking verbs report in-context, does a certification finding reach the intake through exactly one gated agent writer, and is the bootstrap really the ungated exception the text now names?

## Claims

**Title — "Both corpus-checking verbs report in-context; the architect is the
intake's one gated writer."** Both halves hold on the current text. The second
half is now a claim about *gating*, not about exclusive membership: among the
writers into the intake, only the architect applies a gate. The enumeration
below finds no second gated writer — every other filer's only discipline is the
slug check, which the Choice itself attributes to all writers.

**Choice clause 1 — "The two corpus-checking verbs are pure in-context reporters
distinguished by audience: the proof run reports to the executing agent at
machine tempo, and the audit reports to its caller — the human who invoked it, or
the certification gate consuming it as a producer — with every finding classified
mechanical or judgment."** Honored. The population is two verbs, `prove` and
`audit`, enumerated from the converge core's `SKILLS` map (what a consumer
actually receives, `audit` vendored as `ok-planner-audit`) and confirmed against
the family's skill directories — no third corpus-checking verb exists to widen
the claim. `prove` declares itself a producer of "work items for an **agent**,
not a human" with a fixed in-context report shape. `audit` declares itself a
"**pure reporter**", opens its process with "Create nothing. This verb is
read-only against the project", classifies every finding `mechanical` or
`judgment` per the canonical rule in all four of its passes and carries the class
into the report block, and names both audiences — `/certify-all` consuming it as
one of five producers, and the human running it standalone.

**Choice clause 2 — "Neither verb writes the issue intake."** Honored, and pinned
against quiet erosion: prove's never-writes sentence stands in both its body and
its frontmatter; audit's NOT-do list closes "Does not touch the issue intake — no
filing, no editing, no closing"; and a repository maintenance assertion
registered under this decision's own `@decision:` annotation fails if either
governing line is deleted or reworded (the harness runs clean today).

**Choice clause 3 — "A certification finding reaches the intake through exactly
one gated agent writer: certification's architect, filing only findings that
survived the fixer's veto test and its own adversarial check."** Honored — and
this is where the two prior audits' counterexamples were tested again rather than
assumed away. The quantifier's population is now *certification* findings, so it
was enumerated from the two gates and their shared core, not from the family at
large:

- Producers (sprint alignment, `/prove`, the implementation audit, the corpus
  checks, code review) are stateless reporters that "never file issues and never
  fix" — the one defined exception is the implementation auditor, whose output is
  audit documents under `.ok-planner/audits/`, not intake files.
- The orchestrator holds no discretion and files nothing on its own initiative:
  "Promotion is the loop's only path to the intake, and the owner is never asked
  live."
- The fixer's only legal non-fix is a kickback, gated by the veto test; it writes
  no issue.
- The architect is the sole writer, and it writes only on CONFIRM, after
  adversarially testing the kickback with an explicit bias to refute, deduped
  "against every slug already present".
- `/verify-issues`, which both gates invoke *after* promotion, was checked as a
  possible second certification-time writer and is not one: its only file-creating
  step is the legacy `issues.jsonl` conversion (absent on a converged project),
  and its in-scope work supersedes, closes, or repairs files that already exist.
- Both gates' NOT-do lists restate the same rule: "only the architect's confirmed
  forks reach the intake."

**Choice clause 4 — "That gate governs the repeating cycle's findings, not the
intake's whole membership — humans file directly whenever they choose, the
ceremonies that transcribe the owner's own questions file directly, and so does
the one-time corpus bootstrap, whose review loops surface findings in the defined
sense and file them ungated by design: the queue is what the owner invoked that
run to get, and a run that aborts rather than repeat over a populated corpus
cannot accumulate against the owner."** Honored, and it is the sentence that
closes the ground the two prior audits stood on. `concept:finding` still fixes
"finding" as any defect surfaced by a review pass, so `/discover-design`'s five
filing sites — the two cycle-3 unresolved-finding filings, the extractor's
muddiness filings, the phase-2 reviewer's confessed-uncertainty filings, and the
back-edge reviewer's residual-uncertainty filings — are findings by the corpus's
own definition and reach the intake with nothing but a slug check in front of
them. The text no longer denies that; it names it and bounds it, and both halves
of the bound are real in the code:

- *Ungated by design* — matches reality exactly: the sites file directly,
  disciplined only by "check the slugs already present and skip them".
- *The queue is what the owner invoked the run to get* — `story:bootstrap-design-corpus`
  asks for "durable catalogs plus a queue of judgment questions", so the filings
  are the deliverable, not a cost imposed on the owner.
- *Aborts rather than repeat over a populated corpus* — the skill's state
  detection stops at "Non-empty `concepts/`, `stories/`, or `decisions/` →
  abort", and the abort is reached at step 3, before phase 1 runs, so an aborted
  run writes no issue file at all. The story's Acceptance and Falsifier commit to
  the same behavior, and the frontmatter description advertises it. The one
  re-run path is the owner deleting the durable catalogs themselves — an owner
  act, not an agent's repetition.
- *Outside the repeating cycle* — nothing invokes `/discover-design`
  programmatically; audit's missing-corpus branch only tells the caller to run it.

The carve-out's other two branches were re-tested and still hold: `/plan-sprint`
files only "a question the owner explicitly postpones" (`kind: "sprint"`), and
`/verify-issues`' legacy conversion transcribes ids already open in the retired
container, creating no new membership.

One writer sits outside the sentence's literal list and is recorded here rather
than glossed over: the family's administration document, migrating a pre-4.0
`design/tensions/` tree, writes an issue file per live tension. It is neither a
human, a ceremony, nor the bootstrap. It is not a refutation — it surfaces no
defect of its own, stamps what it writes `kind: "human"`, transcodes questions
that were already the owner's queue into the current container, and skips slugs
already present — the same container-conversion shape the clause already covers
in `/verify-issues`. Read as an exhaustive roll call of everything that has ever
appended a file, the clause would miss it; read as what it says — the gate does
not govern the intake's whole membership, and here is who else legitimately
files — it stands.

**Choice clause 5 — "The owner's durable agenda is a property of that promotion
gate — adversarial confirmation before anything costs owner attention — never of
either reporting verb; deduplication against the slugs already present is the
standing discipline of every writer into the intake, the gate included."**
Honored, and the correction the prior audit demanded has landed: the exclusive
attribution is now narrowed to adversarial confirmation, which genuinely is the
gate's alone (no other writer tests its filing against a roleplayed owner), while
dedup is attributed to all writers — which is what the code says. `{{ISSUE-FILE-FORMAT}}`
states it as a binding rule for every filer, and it is transcluded into the
prompts of the writers that file (the architect, the discover-design extractor
and reviewers, plan-sprint's postponed-question filing, the administration's
migration); `/verify-issues`' conversion skips ids already filed; the
certification loop's step 1 dedups before the fixer even runs. `concept:issue`
carries the same as an invariant of writers in general. The negative half is
honored too: neither reporting verb supplies any of it.

**Rationale — "Routing certification's findings through one adversarial gate is
what keeps the intake meaning 'requires owner calibration': certification runs at
every close, so a reporting verb that also filed would be a second ungated writer
inside that repeating cycle."** Honored. "Certification runs at every close" is
literal, not rhetorical: `/certify-work` is a fixed clause of the completion
contract baked verbatim into every sprint `/plan-sprint` writes. The hazard is
stated hypothetically and is unrealized inside that cycle — no certification-time
producer files.

**Rationale — "The corpus bootstrap files ungated without defeating that, because
it sits outside the repeating cycle — one owner-invoked adoption run that refuses
to run again over a populated corpus, and the queue of judgment questions it
hands back is the outcome the owner invoked it for rather than a cost imposed on
them."** Honored — same evidence as Choice clause 4. The refusal is implemented
and story-backed, and the run is slash-command-only.

**Rationale — "A standalone audit's judgment findings still reach the owner: the
human who ran it is holding the report, and reading it is the calibration act —
what they judge fork-worthy, they file."** Honored: "The caller decides what
happens next; the audit routes nothing", and "A human running `/audit` standalone
fixes what they choose and files what they judge fork-worthy themselves."

**Alternatives.** All three are roads not taken, correctly recorded. "One verb
doing both" and "Both verbs writing the intake" contradict the shipped shape;
"The audit filing its own judgment class" names costs that match the code — it
would reintroduce an ungated writer and duplicate the gate's dedup and
confirmation, exactly what the certification core and the estate guide forbid.

**Corroborating surfaces agree.** The estate guide template and the project's
materialized `.ok-planner/CLAUDE.md` are byte-identical after version
substitution, and their filer sentence now says what this decision says:
certification's architect is "the gated path — a finding from the repeating close
cycle must survive the fixer's veto test and the architect's adversarial check",
listed alongside "`/discover-design`'s one-time bootstrap run", `/plan-sprint`
transcription, and humans. The self-contradiction the prior two audits cited in
that sentence is gone.

## Determination

**satisfied.** The verb half was never in doubt and remains true: `prove` and
`audit` are the whole population of corpus-checking verbs, both are pure
in-context reporters with exactly the described audiences, the
mechanical/judgment classification is real and carried into the report, neither
touches the intake, and a maintenance assertion pins both governing sentences.

The half that failed twice now holds because the text was narrowed to what the
code does rather than the code being read charitably. The quantifier is scoped to
certification findings, and inside certification the architect really is the only
writer — producers are forbidden to file, the orchestrator has no discretion, the
fixer's only non-fix is a kickback, and `/verify-issues` creates nothing on a
converged project. The writer that broke the last two determinations,
`/discover-design`, is now named in the text as an ungated filer of findings in
`concept:finding`'s own sense, and the boundary the text draws around it —
one-time, owner-invoked, aborting before it writes anything over a populated
corpus, handing back the queue the owner asked for — is implemented at every
point: the abort precedes phase 1, the story commits to it, and nothing invokes
the bootstrap automatically. The dedup over-attribution the last audit flagged
has been corrected to a discipline of all writers, which the canonical issue
format and `concept:issue` both state.

One writer is not literally in the Choice's roll call — the administration's
pre-4.0 `design/tensions/` migration. It files no finding, authors no new
question, stamps `kind: "human"`, and dedups; it is a container conversion of the
same kind the clause already accounts for, so it does not refute a sentence whose
point is that the gate governs findings from the repeating cycle rather than the
intake's whole membership. A future rewrite that turns that clause into an
exhaustive list of filers would have to name it.

The whole-file pins on the audit, prove, discover-design, certification-core, and
converge sources, plus the anchors on every filing site and on both copies of the
estate guide's filer sentence, will re-open this audit if any of them moves.

## Citations

- cite: plugins/ok/families/ok-planner/skills/prove/SKILL.md :: "never writes to the issue intake"
- cite: plugins/ok/families/ok-planner/skills/prove/SKILL.md :: "produces work items for an **agent**, not a human"
- cite-span: plugins/ok/families/ok-planner/skills/prove/SKILL.md :: "4. **Report** in-context, structured, one entry per in-scope story:" +26 sha256:830d6426400d
- cite: plugins/ok/families/ok-planner/skills/audit/SKILL.md :: "Audit is a **pure reporter**"
- cite: plugins/ok/families/ok-planner/skills/audit/SKILL.md :: "1. Create nothing. This verb is read-only against the project"
- cite: plugins/ok/families/ok-planner/skills/audit/SKILL.md :: "Does not touch the issue intake — no filing, no editing, no closing"
- cite: plugins/ok/families/ok-planner/skills/audit/SKILL.md :: "The caller decides what happens next; the audit routes nothing."
- cite: plugins/ok/families/ok-planner/skills/audit/SKILL.md :: "only the architect's confirmed forks are promoted to"
- cite-span: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "**Producers.** The gate's review passes" +3 sha256:90d28ae26d4e
- cite-span: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "**Promotion is the loop's only path to the intake, and the owner is never asked live.**" +4 sha256:116a2d0fedf8
- cite: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "1. **Dedup.** Subtract findings already promoted"
- cite-span: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "- **CONFIRM and promote.** If a reasonable owner might genuinely" +9 sha256:e4b6b68da15f
- cite: plugins/ok/families/ok-planner/skills/certify-work/SKILL.md :: "only the architect's confirmed forks reach the intake"
- cite: plugins/ok/families/ok-planner/skills/certify-all/SKILL.md :: "only the architect's confirmed forks reach the intake"
- cite: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md :: "intent forks promoted to `.ok-planner/issues/` and verified"
- cite: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md :: "a question the owner explicitly postpones is filed to"
- cite: plugins/ok/families/ok-planner/skills/verify-issues/SKILL.md :: "For each open id, write an issue file to"
- cite: plugins/ok/families/ok-planner/skills/discover-design/SKILL.md :: "Runs end-to-end without user interruption."
- cite-span: plugins/ok/families/ok-planner/skills/discover-design/SKILL.md :: "   - Non-empty `concepts/`, `stories/`, or `decisions/` → abort." +4 sha256:ae1026698373
- cite: plugins/ok/families/ok-planner/skills/discover-design/SKILL.md :: "each unresolved finding as an issue file under"
- cite: plugins/ok/families/ok-planner/skills/discover-design/SKILL.md :: "agent-confessed-uncertainty observations as issue files"
- cite: plugins/ok/families/ok-planner/skills/discover-design/SKILL.md :: "4. One issue file written to `.ok-planner/issues/` per case"
- cite-span: plugins/ok/families/ok-planner/skills/discover-design/SKILL.md :: "`status: open`, per the issue file format above; check the" +2 sha256:66975ead06a7
- cite: plugins/ok/families/ok-planner/skills/_shared/artifact-definitions.md :: "- **`issue:` is a stable fingerprint**"
- cite: plugins/ok/families/ok-planner/skills/_shared/artifact-definitions.md :: "- **Ownership follows the lifecycle.**"
- cite: plugins/ok/families/ok-planner/admin/ADMINISTRATION.md :: "issue file to `.ok-planner/issues/` per `{{ISSUE-FILE-FORMAT}}` with"
- cite-span: plugins/ok/families/ok-planner/scripts/ok-planner-CLAUDE.md :: "chronologically. Filed by certification's architect (the gated" +5 sha256:6c820f572ed6
- cite-span: .ok-planner/CLAUDE.md :: "chronologically. Filed by certification's architect (the gated" +5 sha256:6c820f572ed6
- cite: .ok-planner/design/concepts/finding.md :: "A finding is one defect surfaced by any of the suite's review passes"
- cite: .ok-planner/design/concepts/issue.md :: "Many writers may open; only the planning ceremony"
- cite: .ok-planner/design/concepts/issue.md :: "- Slugs are stable fingerprints of artifact plus nature"
- cite: .ok-planner/design/stories/bootstrap-design-corpus.md :: "On a project with non-empty durable catalogs the run aborts"
- cite: checks/text-presence :: "# @decision: prove-audit-audience-split"
- cite-file: plugins/ok/families/ok-planner/skills/audit/SKILL.md @ sha256:28563955e674
- cite-file: plugins/ok/families/ok-planner/skills/prove/SKILL.md @ sha256:3780a5429f89
- cite-file: plugins/ok/families/ok-planner/skills/discover-design/SKILL.md @ sha256:80c8c02787b4
- cite-file: plugins/ok/families/ok-planner/skills/_shared/certification-core.md @ sha256:190f0836cf08
- cite-file: plugins/ok/families/ok-planner/admin/converge @ sha256:75db5f704edb
