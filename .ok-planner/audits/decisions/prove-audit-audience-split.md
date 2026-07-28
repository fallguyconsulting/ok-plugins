---
audit: prove-audit-audience-split
artifact: decision:prove-audit-audience-split
determination: satisfied
audited: 2026-07-28T10:29:55Z
artifact-hash: sha256:3a32f3d14707
---

# Do both corpus-checking verbs report in-context, does a certification finding reach the intake through exactly one gated agent writer, and is the bootstrap really the ungated exception the text names?

Amended, not rewritten. The design artifact's hash is unchanged and not one
citation of this audit went stale, so the derivation below binds as written;
this pass exists because two nominations landed in its territory and both
needed adjudicating against reality rather than against the prior text. The
first is a corpus move: `concept:finding`'s Purpose and Boundaries were
rewritten to state the gated-intake routing directly, restating this
decision's Choice almost verbatim a few lines below the untouched anchor this
audit already carried on that file. The second is better than a corpus move —
three architect-filed issues appeared in `.ok-planner/issues/`, the first live
instances of the gated writer since this audit was written, so the claim that
was previously read out of prompt text can now be checked against filed
artifacts. Both are adjudicated in the Notes; the claims they touch are
amended below with what the live evidence adds, and nothing else is
re-derived.

## Claims

**Title — "Both corpus-checking verbs report in-context; the architect is the
intake's one gated writer."** Both halves hold on the current text. The second
half is a claim about *gating*, not about exclusive membership: among the
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
the claim, and the sprint under certification added none (the new `source-graph`
tool is a deterministic extractor and drift checker, not a verb, and reports no
findings against the corpus). `prove` declares itself a producer of "work items
for an **agent**, not a human" with a fixed in-context report shape. `audit`
declares itself a "**pure reporter**", opens its process with "Create nothing.
This verb is read-only against the project", classifies every finding
`mechanical` or `judgment` per the canonical rule in all four of its passes and
carries the class into the report block, and names both audiences — `/certify-all`
consuming it as a producer, and the human running it standalone.

**Choice clause 2 — "Neither verb writes the issue intake."** Honored, and pinned
against quiet erosion: prove's never-writes sentence stands in both its body and
its frontmatter; audit's NOT-do list closes "Does not touch the issue intake — no
filing, no editing, no closing"; and a repository maintenance assertion
registered under this decision's own `@decision:` annotation fails if either
governing line is deleted or reworded (the harness runs clean today).

**Choice clause 3 — "A certification finding reaches the intake through exactly
one gated agent writer: certification's architect, filing only findings that
survived the fixer's veto test and its own adversarial check."** Honored, and
re-enumerated this cycle rather than carried, because the sprint under
certification rebuilt the gates' machinery — new agents, a new record surface,
and a new class of reported material — which is exactly the shape of change that
could introduce a second writer. Enumerated from the two gates and their shared
core:

- Producers (sprint alignment, `/prove`, the implementation audit, the corpus
  checks, code review) are stateless reporters that "never file issues and never
  fix" — the one defined exception is the implementation auditor, whose output is
  audit documents under `.ok-planner/audits/`, not intake files.
- The **change inspector**, new this cycle, was tested as the likeliest second
  writer and is not one. It writes only into audit files — a provisional note
  appended to the implicated audit's `## Notes` section, with everything else in
  that file explicitly off-limits — and its own rules state "Residue is a report,
  never a verdict — you do not file issues". Its output otherwise returns
  in-context.
- The **reconciliation ledger**, also new, is the other candidate: residue is
  described as "intake material". It reaches the owner through the
  *presentation*, enumerated as one line each for the owner to act on — reported,
  never filed. Nothing in either gate writes a residue entry to
  `.ok-planner/issues/`.
- The orchestrator holds no discretion and files nothing on its own initiative:
  "Promotion is the loop's only path to the intake, and the owner is never asked
  live", and "the gate files nothing on its own initiative".
- The fixer's only legal non-fix is a kickback, gated by the veto test; it writes
  no issue.
- The architect is the sole writer, and it writes only on CONFIRM, after
  adversarially testing the kickback with an explicit bias to refute, deduped
  "against every slug already present".
- `/verify-issues`, which both gates invoke *after* promotion, is not a second
  certification-time writer: its only file-creating step is the legacy
  `issues.jsonl` conversion (absent on a converged project), and its in-scope work
  supersedes, closes, or repairs files that already exist.
- Both gates' NOT-do lists restate the same rule: "only the architect's confirmed
  forks reach the intake." `certify-work` additionally routes the one
  out-of-scope case to a human rather than to itself ("if it matters, a human
  files it to the intake"), which is clause 4's carve-out, not an exception.

This clause now has live instances, which is what the second nomination
supplies and what turns a reading of prompts into a reading of artifacts.
Three architect-filed issues sit in `.ok-planner/issues/`
(`plumbline-ci-emission-ungoverned`, `plumbline-explain-verb-ungoverned`,
`plumbline-slug-verb-ungoverned`), all stamped `2026-07-28T10:12:59Z` — one
architect run. Checked against the shape the clause claims, and they match on
every axis the clause fixes:

- *Filed by the gate, in the gate's own kind.* All three carry `kind: audit`,
  which is precisely the value the certification core's CONFIRM branch
  instructs the architect to write ("Write the issue file per
  {{ISSUE-FILE-FORMAT}} (kind `audit`, category from the finding's nature,
  `status: open`, the diverging options as Candidates …)"). All three carry
  `status: open`, a `## Problem` and a `## Candidates` section, and nothing
  else — exactly the filer's ownership slice, no Discussion, no Ruling.
- *The producer did not file.* Each Problem section attributes the finding to
  "The surface inventory pass of `/certify-all`" — and the surface inventory
  is a pass of `/audit`, the pure reporter whose NOT-do list forbids touching
  the intake. So the finding's *origin* is a reporter and its *filing* is the
  architect: the routing the Choice describes, exhibited end to end rather
  than asserted. A verb that filed its own findings would have produced these
  files with no architect in the path, and the kind stamp would not be
  `audit`.
- *Deduped, as the standing discipline requires.* All three slugs are unique
  across the fifty closed files in `history/issues/` and the three open ones —
  no slug appears twice anywhere in the intake, live or archived.
- *No second writer widened the population.* Enumerated from reality across
  the whole intake, open plus archived: 53 files, `kind: discover` ×46 (the
  one-time bootstrap, clause 4's named ungated exception), `kind: audit` ×5
  (the gate), `kind: human` ×2 (humans filing directly, also clause 4). No
  file carries any other kind, and no file's kind is unaccounted for by the
  Choice's roll call. The distribution is itself the strongest available
  evidence for the clause: the only agent writer inside the repeating close
  cycle has produced five files across the project's life, while the ungated
  one-time run produced forty-six.

**Choice clause 4 — "That gate governs the repeating cycle's findings, not the
intake's whole membership — humans file directly whenever they choose, the
ceremonies that transcribe the owner's own questions file directly, and so does
the one-time corpus bootstrap, whose review loops surface findings in the defined
sense and file them ungated by design: the queue is what the owner invoked that
run to get, and a run that aborts rather than repeat over a populated corpus
cannot accumulate against the owner."** Honored. `concept:finding` still fixes
"finding" as any defect surfaced by a review pass, so `/discover-design`'s five
filing sites — the two cycle-3 unresolved-finding filings, the extractor's
muddiness filings, the phase-2 reviewer's confessed-uncertainty filings, and the
back-edge reviewer's residual-uncertainty filings — are findings by the corpus's
own definition and reach the intake with nothing but a slug check in front of
them. The text names that and bounds it, and both halves of the bound are real:

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

The carve-out's other two branches still hold: `/plan-sprint` files only "a
question the owner explicitly postpones" (`kind: "sprint"`) plus the deferred
out-of-band divergence it transcribes (`kind: "human"`), both owner-authored
questions; and `/verify-issues`' legacy conversion transcribes ids already open
in the retired container, creating no new membership.

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
Honored. Adversarial confirmation genuinely is the gate's alone: no other writer
tests its filing against a roleplayed owner. Dedup is attributed to all writers,
which is what the code says — `{{ISSUE-FILE-FORMAT}}` states it as a binding rule
for every filer and is transcluded into the prompts of the writers that file (the
architect, the discover-design extractor and reviewers, plan-sprint's postponed
question, the administration's migration); `/verify-issues`' conversion skips ids
already filed; the certification loop's step 1 dedups before the fixer runs.
`concept:issue` carries the same as an invariant of writers in general. The
negative half is honored too: neither reporting verb supplies any of it.

**Rationale — "Routing certification's findings through one adversarial gate is
what keeps the intake meaning 'requires owner calibration': certification runs at
every close, so a reporting verb that also filed would be a second ungated writer
inside that repeating cycle."** Honored. "Certification runs at every close" is
literal, not rhetorical: `/certify-work` is a fixed clause of the completion
contract baked verbatim into every sprint `/plan-sprint` writes. The hazard is
stated hypothetically and is unrealized inside that cycle — no certification-time
producer files, and neither does the new inspector.

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
materialized `.ok-planner/CLAUDE.md` carry the same filer sentence this decision
states: certification's architect is "the gated path — a finding from the
repeating close cycle must survive the fixer's veto test and the architect's
adversarial check", listed alongside "`/discover-design`'s one-time bootstrap
run", `/plan-sprint` transcription, and humans. Both copies were untouched by the
sprint's rewrite of the surrounding sections.

`concept:finding` now agrees too, which it did not before — the first
nomination. Its Purpose used to say "Everything downstream — who fixes, who is
asked, what lands in the queue — follows from the classification", and its
Boundaries used to say "Judgment findings become open rows in the intake queue
and wait for planning". Read strictly, that made the mechanical/judgment
classification itself the routing mechanism into the intake, which is the one
thing this decision denies: the split is advisory, and the *gate* is what
reaches the owner. The rewrite states the denial outright ("it never by itself
puts anything in front of the owner — reaching the intake is a separate, gated
act") and then names the writers this decision names ("the intake is reached
only by a deliberate act of filing"): the human reading a standalone report who
files what they judge fork-worthy, certification's architect — named there as
"the repeating cycle's one gated writer" — filing what survived the fixer's veto
test and its own adversarial check, and the one-time corpus bootstrap, filing
"ungated by design because it sits outside that cycle". All three are the
decision's own, in the decision's own terms, and the concept adds none of its
own; the two writers of the Choice's roll call it omits — the ceremonies that
transcribe the owner's questions — are outside its subject, since they file
owner questions rather than findings. There is a cross-reference back to this
decision. This audit had an anchor on that file already, on its
opening "A finding is one defect surfaced by any of the suite's review passes"
sentence — a sentence clause 4 leans on, and one the rewrite left standing, so
no hash moved and nothing was mechanically flagged. That is the exact blind
spot the judged inspection layer exists for: text changed beside a cited
anchor. The new sentences are pinned below so the next such move is caught
mechanically.

Worth recording as the thing that would have been a real refutation and is
not: a concept restating a decision's Choice can be a corpus duplication
defect rather than corroboration. It is not one here. `concept:finding` states
the routing rule as a property of *findings* — what a classification does and
does not do to a defect — and cross-references the decision for the choice;
the decision states it as a property of the *verbs and the gate*. Neither
carries the other's substance, and the concept names no writer the decision
does not.

## Determination

**satisfied.** The verb half holds: `prove` and `audit` are the whole population
of corpus-checking verbs, both are pure in-context reporters with exactly the
described audiences, the mechanical/judgment classification is real and carried
into the report, neither touches the intake, and a maintenance assertion pins both
governing sentences.

The gated-writer half holds after the machinery rebuild, which is what this
re-derivation was for. Inside certification the architect is still the only
writer into the intake: producers are forbidden to file, the orchestrator has no
discretion, the fixer's only non-fix is a kickback, and `/verify-issues` creates
nothing on a converged project. The two new surfaces were tested directly rather
than assumed harmless — the change inspector writes only provisional notes into
audit files and is told in its own prompt that it files no issues, and the
reconciliation ledger's residue reaches the owner through the presentation as
enumerated intake *material*, not as filed issues. The carve-out for the
one-time bootstrap remains implemented at every point: the abort precedes phase 1,
the story commits to it, and nothing invokes the bootstrap automatically.

One writer is not literally in the Choice's roll call — the administration's
pre-4.0 `design/tensions/` migration. It files no finding, authors no new
question, stamps `kind: "human"`, and dedups; it is a container conversion of the
same kind the clause already accounts for, so it does not refute a sentence whose
point is that the gate governs findings from the repeating cycle rather than the
intake's whole membership. A future rewrite that turns that clause into an
exhaustive list of filers would have to name it.

The gated-writer half is no longer read only out of prompt text. Three
architect-filed issues now exist, and they carry the gate's own kind stamp,
the filer's exact section slice, unique slugs across all fifty-three intake
files live and archived, and a Problem section attributing the finding to a
pure reporter that did not file it. Enumerated across the whole intake, the
kind distribution — 46 `discover`, 5 `audit`, 2 `human` — accounts for every
file under the Choice's own roll call, with no kind and no writer unexplained.

`concept:finding` moved into agreement this cycle: where it once made the
mechanical/judgment classification the thing that put findings in front of the
owner, it now states that the classification routes nothing and the intake is
reached only by a deliberate act of filing, naming for findings the same three
routes this decision names — the human holding a standalone report, the
architect as the repeating cycle's one gated writer, and the ungated one-time
bootstrap that sits outside that cycle — and cross-referencing this decision.
The corroboration is not a duplication defect — the concept states the rule as a
property of findings and cites the decision for the choice.

This stops holding if: either reporting verb acquires a write into
`.ok-planner/issues/` (the `text-presence` assertion fails first); the change
inspector or any successor producer is given filing authority, or the
reconciliation ledger's residue starts being filed rather than reported (the
whole-file pin on the certification core breaks on either); the architect's
CONFIRM branch stops being adversarial, stops deduping, or stops stamping
`kind: audit`, at which point the filed artifacts stop being attributable to
the gate (the pinned CONFIRM span and the `kind: audit` anchor break);
`concept:finding` reverts to routing judgment findings into the queue by
classification alone (the two new anchors on it break); `/discover-design`
loses its abort-before-phase-1 guard, so the ungated bootstrap could repeat over
a populated corpus; an intake file appears carrying a kind the Choice's roll
call does not account for, or two files share a slug; or the intake gains a new
agent writer inside the repeating close cycle. The whole-file pins on the
audit, prove, discover-design, certification-core, and converge sources, plus
the anchors on every filing site, on both copies of the estate guide's filer
sentence, and on the three live architect-filed issues, re-open this audit if
any of them moves.

## Notes

- note: `.ok-planner/design/concepts/finding.md` — Purpose and Boundaries rewritten to the gated intake routing ("it never by itself puts anything in front of the owner — reaching the intake is a separate, gated act"; "the intake is reached only through the gated writers … certification's architect files what survived the fixer's veto test and its own adversarial check"), restating this decision's Choice almost verbatim a few lines below this audit's untouched `cite:` anchor on that same file — changed bytes inside a claim's territory that no citation caught.
  adjudication: promoted — read against the prior text rather than only the new: the concept previously made the mechanical/judgment classification itself the route into the queue ("Judgment findings become open rows in the intake queue"; "Everything downstream … follows from the classification"), which contradicted the Choice's core denial, and the rewrite removes that contradiction and cross-references this decision, so the corroborating-surfaces claim strengthens; tested for the failure mode a near-verbatim restatement would signal — corpus duplication — and it is not one, since the concept states the rule as a property of findings while the decision states it of the verbs and the gate, and the concept names no writer the decision does not; the nominated territory is now carried by the two new anchors on the concept's Purpose and Boundaries sentences alongside the pre-existing anchor on its opening definition.
- note: `.ok-planner/issues/2026-07-28-101259-plumbline-{ci-emission,explain-verb,slug-verb}-ungoverned.md` — three new architect-promoted issue files (`kind: audit`), the first live instances of this decision's "one gated agent writer" claim since the audit was written; worth checking them against the claimed shape rather than reading the gate's prompts again.
  adjudication: promoted — all three verify against the shape the Choice fixes: `kind: audit` as the certification core's CONFIRM branch instructs, `status: open`, exactly the filer's `## Problem` + `## Candidates` slice with no Discussion or Ruling, slugs unique across all fifty-three files in `issues/` and `history/issues/`, and a Problem section attributing the finding to `/certify-all`'s surface inventory — a pass of `/audit`, the pure reporter forbidden to touch the intake — so origin and filing are separated exactly as claimed; the whole-intake kind enumeration (46 `discover`, 5 `audit`, 2 `human`) accounts for every file under the Choice's own roll call with no unexplained writer; the nominated territory is now carried by existence anchors on the three files' stable `issue:` slugs (which survive `/verify-issues`' rewrite, unlike a body pin) and by the pinned CONFIRM span and `kind: audit` anchor in the certification core.

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
- cite-span: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "  - **CONFIRM and promote.** If a reasonable owner might genuinely" +9 sha256:e4b6b68da15f
- cite: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "  - Residue is a report, never a verdict — you do not file issues, do"
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
- cite: .ok-planner/design/concepts/finding.md :: "it never by itself puts anything in front of the owner — reaching the intake is a separate, gated act"
- cite: .ok-planner/design/concepts/finding.md :: "the intake is reached only by a deliberate act of filing"
- cite: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "    {{ISSUE-FILE-FORMAT}} (kind `audit`, category from the"
- cite: .ok-planner/issues/2026-07-28-101259-plumbline-ci-emission-ungoverned.md :: "issue: plumbline-ci-emission-ungoverned"
- cite: .ok-planner/issues/2026-07-28-101259-plumbline-explain-verb-ungoverned.md :: "issue: plumbline-explain-verb-ungoverned"
- cite: .ok-planner/issues/2026-07-28-101259-plumbline-slug-verb-ungoverned.md :: "issue: plumbline-slug-verb-ungoverned"
- cite: .ok-planner/design/concepts/issue.md :: "Many writers may open; only the planning ceremony"
- cite: .ok-planner/design/concepts/issue.md :: "- Slugs are stable fingerprints of artifact plus nature"
- cite: .ok-planner/design/stories/bootstrap-design-corpus.md :: "On a project with non-empty durable catalogs the run aborts"
- cite: checks/text-presence :: "# @decision: prove-audit-audience-split"
- cite-node: plugins/ok/families/ok-planner/skills/audit/SKILL.md @ sha256:28563955e674
- cite-node: plugins/ok/families/ok-planner/skills/prove/SKILL.md @ sha256:3780a5429f89
- cite-node: plugins/ok/families/ok-planner/skills/discover-design/SKILL.md @ sha256:80c8c02787b4
- cite-node: plugins/ok/families/ok-planner/skills/_shared/certification-core.md @ sha256:f96e5bcb96d6
- cite-node: plugins/ok/families/ok-planner/admin/converge @ sha256:144ab87e08af
