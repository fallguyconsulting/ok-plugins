---
audit: prove-audit-audience-split
artifact: decision:prove-audit-audience-split
determination: violated
audited: 2026-07-29T09:20:08Z
artifact-hash: sha256:cc747776ad12
---

# Do both corpus-checking verbs report in-context, is the proof run's cost record really its one durable trace, and is the cap escalation "taken only on the owner's word" everywhere the shipped machinery speaks of it?

Rewritten whole. The design artifact's hash moved from `sha256:1c19d1543ede`
to `sha256:cc747776ad12` — Choice clause 4's cap condition was amended (the
interactive-word / unattended-default split is gone: the escalation is now
"taken only on the owner's word, the run stopping at the cap and waiting
for their direction however long that takes"), clause 6 and the Rationale's
cap-bound sentence were brought along ("the cap's by exhaustion and the
owner's word … until a bounded loop has tried and failed to fix it and the
owner directs the wrap-up"), and a fifth Alternative was added recording
the abandoned unattended default as a road not taken. Precedent lapsed
wholesale; this is a fresh adversarial read. Both prior notes and their
adjudications are carried forward verbatim below as history; neither is
open and neither binds this determination.

The prior determination was `satisfied`. It no longer holds, for one
locatable reason: the amendment removed the unattended default from the
loop and from three of the four gate surfaces, but `certify-all`'s own
overview still scopes the cap choice to an interactive run — so the
Alternative this amendment records as rejected is still permitted by the
shipped text of one of the two gates, and clause 4's "taken only on the
owner's word" is not true of the machinery as a whole.

## Claims

**Title — "Both corpus-checking verbs report in-context; certification
reaches the intake only through gated writers."** Both halves hold, and the
title is unchanged by this amendment.

**Choice clause 1 — "The two corpus-checking verbs are in-context reporters
distinguished by audience: the proof run reports to the executing agent at
machine tempo, and the audit reports to its caller — the human who invoked
it, or the certification gate consuming it as a producer — with every
finding classified mechanical or judgment."** Honored. The population is
two verbs, `prove` and `audit`, enumerated from the converge core's
`SKILLS` map (what a consumer actually receives; `audit` vendored as
`ok-planner-audit`) rather than from the decision's own examples — eleven
verbs, unchanged this cycle. `prove` declares itself a producer of "work
items for an **agent**, not a human" with a fixed in-context report shape;
`audit` declares itself a "**pure reporter**" that "returns everything
in-context, and writes nothing", opens its process with "Create nothing",
and classifies every finding mechanical or judgment.

No third corpus-checking verb appeared. The candidates were re-tested:
`/browse` is a read-only view that "never re-audits, never re-derives a
verdict" and resolves staleness by calling the project's own checker;
`source-graph` is a deterministic extractor over source files, not over the
corpus's claims; and the change inspector with its committed registry is a
certification producer rather than a verb a consumer invokes.

**Choice clause 2 — "Neither verb writes the issue intake."** Honored.
Prove's never-writes sentence stands in both its body and its frontmatter;
audit's NOT-do list closes "Does not touch the issue intake — no filing, no
editing, no closing". The maintenance assertion registered under this
decision's own annotation in `checks/text-presence` pins both governing
lines, and both literals were verified present in the files it names.

**Choice clause 3 — "The audit writes nothing at all; the proof run's one
durable trace is the machine-local record of what each executed proof cost
— a measurement, not a finding, and no more a claim on the owner's
attention than the in-context report is."** Honored on all four testable
parts, unmoved this cycle.

*The audit writes nothing at all.* Taken to its sharpest form: "returns
everything in-context, and writes nothing", and step 1's "it does not even
ensure its own layout: if `.ok-planner/issues/` or
`.ok-planner/history/issues/` is absent, report that in the findings … and
carry on." A missing directory is a finding, not a `mkdir`. The suite's own
roster proof asserts exactly this against the verb a project runs.

*The proof run's durable trace is one file, and that file.* The verb's
NOT-do list says it — "the only thing a run leaves behind is
`.ok-planner/proof-timings.json`" — and the recorder bears it out: `cmd_run`
creates a system tempfile for the child's emitted spans and unlinks it
after reading; `merge` / `save_store` write exactly
`<root>/.ok-planner/proof-timings.json`. No second output path, no log, no
marker file; the recorder's node pin is unmoved this cycle.

*Machine-local, and therefore not a claim on owner attention.* The estate's
own ignore file names `proof-timings.json` (alongside only `browser/`), and
the converge core renders that ignore file into every consumer estate — so
the record is real on disk, read freely, never repository content, and
never in the source graph.

*A measurement, not a finding.* `concept:finding` fixes "finding" as one
defect surfaced by a review pass; the record has no field in which a defect
could be expressed — story, proof path, verdict, seconds, scope, timestamp,
cases — and it is git-ignored, so its verdicts reach the owner nowhere.

**Choice clause 4 — "A certification finding reaches the intake through
exactly two gated paths and no others: certification's architect, filing
only findings that survived the fixer's veto test and its own adversarial
check; and the cycle cap's escalation, which files the remainders a bounded
fix loop tried and failed to drive to clean — reachable only once the cap
is hit, taken only on the owner's word, the run stopping at the cap and
waiting for their direction however long that takes, and made ruling-ready
before it becomes owner agenda."** This is the amended clause. Four of its
five sub-claims are honored; the fifth — the amended one — is honored in
the loop and at three gate surfaces and contradicted at the fourth.

*Path one, the architect, with its stated gate.* Real and exactly as
claimed: dispatched only when kickbacks or dissolutions exist, on CONFIRM
only, after adversarially testing the kickback while roleplaying the
reasonable owner with an explicit bias to refute ("'It seems minor' refutes
nothing, and 'it seems hard' confirms nothing"), writing the file per
`{{ISSUE-FILE-FORMAT}}` with `kind: audit`, deduped against every slug
already present. The upstream veto test is real too, in both the loop's
statement of it and the fixer's own prompt, including "Inability is never
grounds".

*Reachable only once the cap is hit.* Honored: the escalation lives in the
loop's step 5, which fires only "After **3 fixer passes** without a clean
review"; nothing before that step files anything.

*Made ruling-ready before it becomes owner agenda.* Honored: step 5
continues "then continue to `/verify-issues` and the presentation like any
other run", the intake paragraph says the pre-presentation `/verify-issues`
pass makes both kinds ruling-ready, and both gates' step 4 fires "if the
architect promoted any or the cap escalation filed any". The ordering is
file, verify, present — and it is the ordering the code has.

*"And no others" — enumerated from the machinery, not trusted.* Every place
in certification that could write `.ok-planner/issues/` was checked:
**producers** ("they never file issues and never fix"; the auditor is
explicitly barred from adding an `issue:` link); **the fixer** (two legal
non-fixes, DISSOLVE and KICKBACK, both *reported* to the orchestrator,
neither written anywhere); **the change inspector** ("Residue is a report,
never a verdict — you do not file issues"); **the reconciliation ledger**
(residue reaches the owner through the presentation, which is reporting);
**upheld dissolutions** (routed to the audit's Referrals — "the rim it
names belongs in the audit's Referrals, not the intake"); **`/verify-issues`
invoked by the gate** (reads and rewrites; the one place it creates files is
the legacy `issues.jsonl` conversion, transcribing ids already open in a
retired container); and **the orchestrator itself** ("the gate files nothing
on its own initiative"). The count is two, the core says two in its own
heading, and both gates, the `/audit` verb's line, the `text-presence`
assertion that pins it, `concept:finding`, the estate-guide template and
the cheatsheet template all state two.

*"Taken only on the owner's word, the run stopping at the cap and waiting
for their direction however long that takes" — NOT HONORED at
`certify-all`.* The loop's Exit step carries the amended rule in full:
"**The choice between those two steps is the owner's alone, and the run
never takes either step itself.** It waits for their word however long that
takes — a minute or a day — attended or not: there is no default and no
unattended exception, so a goal hook, an orchestrator, or any run with
nobody watching holds at the cap exactly as an interactive one does." The
intake paragraph agrees, in the very sentence that names this decision's
second gated path: the cap escalation is "always an owner act, on every run
alike, never a default the gate takes for them". Both gates' "does NOT"
bullets agree verbatim, and both close-outs say "the choice is always
theirs".

But `certify-all`'s overview of what it orchestrates still reads: the
presentation is "the run's only owner touchpoint (plus, **on an interactive
run only**, the cap choice the loop defines)". That is the pre-amendment
split restated from the touchpoint side. Under it, an unattended
`/certify-all` reaching the cap has no owner touchpoint at all — and a loop
that must exit with every finding "fixed or promoted" and no owner to ask
has exactly one way out: file the remainders itself. That is the escalation
taken without the owner's word, which this clause forbids on every run, and
it is a statement inside the same file whose closing bullet says the
opposite. A gated path whose gate is described two ways in one prompt is not
the gate the Choice claims.

**Choice clause 5 — "Those gates govern the repeating cycle's findings, not
the intake's whole membership — humans file directly whenever they choose,
the ceremonies that transcribe the owner's own questions file directly, and
so does the one-time corpus bootstrap … a run that aborts rather than
repeat over a populated corpus cannot accumulate against the owner."**
Honored as a roll call, re-enumerated across the whole intake, live plus
archived. **67 files: `kind: discover` ×46** (the one-time bootstrap, this
clause's named ungated exception), **`kind: audit` ×5** (certification's
gated paths), **`kind: human` ×16** (humans and transcriptions filing
directly — one more than the prior pass, the owner's own cap-decision issue
this cycle). No file carries a kind the roll call does not account for, and
no two files share a slug. The gate's own count is unmoved at five across
the project's life, against forty-six from the ungated one-time run — the
quantitative shape the Rationale predicts.

The bootstrap's bound is implemented at every point: `/discover-design`'s
state detection stops at "Non-empty `concepts/`, `stories/`, or
`decisions/` → abort", the abort precedes phase 1 so an aborted run writes
no issue file at all, `story:bootstrap-design-corpus` commits to the same
behavior, and nothing invokes the bootstrap programmatically.
`/plan-sprint` files only questions the owner postponed; `/verify-issues`'
legacy conversion transcribes ids already open in a retired container.

**Choice clause 6 — "The owner's durable agenda is a property of those two
gates, never of either reporting verb: the architect's path is bounded by
adversarial confirmation before anything costs owner attention, and the
cap's by exhaustion and the owner's word — nothing is filed there until a
bounded loop has tried and failed to fix it and the owner directs the
wrap-up. Deduplication … is the standing discipline of every writer into the
intake, the gates included."** Honored on the negative half (neither
reporting verb supplies any of it, and the cost record is not an agenda),
on the architect's bound (adversarial confirmation, per clause 4), on the
exhaustion half of the cap's bound (three fixer passes must have run and
the review must still be unclean before step 5 is reachable, and
"inability is never grounds" is why a remainder is a finding the fixer
*failed* to fix), and on dedup (the canonical issue file format states it as
binding for every filer, transcluded into the writers' prompts; the
architect's CONFIRM branch names it; the loop dedups before the fixer runs;
the legacy conversion skips ids already filed). The clause's newly added
second half of the cap's bound — "**and the owner's word** … and the owner
directs the wrap-up" — carries the same defect as clause 4: it is the bound
the core states and the bound `certify-all`'s overview does not concede for
an unattended run.

**Rationale — "The split keeps execution unblocked and the owner
uninterrupted … Routing certification's findings through gated paths only is
what keeps the intake meaning 'requires owner calibration': certification
runs at every close, so a reporting verb that also filed would be an
ungated writer inside that repeating cycle."** Honored as stated.
"Certification runs at every close" is literal — `/certify-work` is a fixed
clause of the completion contract baked into every sprint. The named hazard
is unrealized: no reporting verb files, and neither the change inspector nor
the reconciliation ledger does.

**Rationale — "The two gated paths bound that growth in different ways and
both bound it — the architect's by adversarial confirmation, the cap's by
exhaustion and the owner's word: a remainder is filed only after a bounded
loop has failed to fix it and the owner chooses the wrap-up over another
cycle, which makes it rare by construction and makes the filing the
alternative to losing the finding altogether when the owner closes a capped
run."** Partly honored, and the unhonored part is the amendment's own new
argument. "Rare by construction" holds: the cap requires three completed
fixer passes over findings the fixer is instructed to fix unconditionally.
"The alternative to losing the finding altogether" holds: before this path
existed the remainders survived only in conversation, the failure
`story:certify-completion`'s Falsifier names. What does not hold
unconditionally is "**the owner chooses** the wrap-up over another cycle" —
true of the core and of both gates' cap bullets, denied by `certify-all`'s
overview for a run with nobody watching.

**Rationale — "The corpus bootstrap files ungated without defeating that,
because it sits outside the repeating cycle."** Honored — same evidence as
clause 5: the refusal is implemented, story-backed, and
slash-command-only.

**Rationale — "A standalone audit's judgment findings still reach the owner:
the human who ran it is holding the report, and reading it is the
calibration act."** Honored: "The caller decides what happens next; the
audit routes nothing", and "A human running `/audit` standalone fixes what
they choose and files what they judge fork-worthy themselves."

**Alternatives.** Five now. "One verb doing both", "Both verbs writing the
intake", "The audit filing its own judgment class", and "Routing cap
remainders through the architect too" are all genuine roads not taken, and
the fourth's stated reasoning is verifiable in the code it describes (the
architect's dispatch condition is kickbacks-or-dissolutions, and "Inability
is never grounds" is present verbatim in both the loop's statement and the
fixer's prompt). The **fifth is new and is not fully a road not taken**:
"Escalating by default on an unattended capped run — keeps the run moving
without the owner, at the cost of making the cap's choice for them." The
loop abandoned it, but `certify-all`'s overview still tells an unattended
run that the cap choice is not its business — which is the rejected
alternative's operative content surviving at a shipped surface. An
Alternative is a claim that the suite does *not* do the thing; here it does,
in one of the two gates' own words.

**The vendored layer.** This repository's materialized `.claude/skills/`
copies still carry the pre-amendment cap text ("On an unattended run …
escalation is the default") and `.ok-planner/CLAUDE.md` the older intake
wording. That is the pinned vendored layer between a release and the next
deliberate converge — `checks/vendored-layer` pins those paths to HEAD and
states in its own header that "between a release and the next deliberate
converge the layer legitimately lags the family source in this repo" —
governed by `decision:per-project-pinning`. It is not a finding here; the
family canonicals are the judged reality, and the finding above is in the
canonical.

## Determination

**violated**, on one claim line with two dependents:

- **Choice clause 4's amended cap condition** — "taken only on the owner's
  word, the run stopping at the cap and waiting for their direction however
  long that takes" — is not true of the shipped machinery as a whole.
  `plugins/ok/families/ok-planner/skills/certify-all/SKILL.md` still states
  that the presentation is "the run's only owner touchpoint (plus, on an
  interactive run only, the cap choice the loop defines)", which denies the
  cap touchpoint to an unattended run of that gate and leaves filing the
  remainders as the only way such a run can exit a loop whose exit demands
  every finding fixed or promoted. Clause 6's new "and the owner's word"
  bound and the Rationale's "the owner chooses the wrap-up" rest on the same
  sentence and fall with it; the fifth Alternative, which records escalating
  by default as rejected, is contradicted by it.

Everything else in the decision is honored and was re-derived rather than
inherited: two corpus-checking verbs from the converge map, both in-context
reporters to the described audiences, mechanical/judgment classification
real, neither touching the intake, with the `text-presence` assertion's two
governing sentences verified present; the audit refusing even to create its
own layout; the proof run's single git-ignored output with its tempfile
unlinked and no second path; the architect's dispatch condition, CONFIRM
gate, dedup, and the veto test's "inability is never grounds"; the cap's
reachability only after three fixer passes and `/verify-issues` running
before the presentation; the "and no others" quantifier enumerated over
seven candidate writers, none of which files; and clause 5's roll call
accounting for all 67 intake files across three kinds with no duplicate
slug and the gate's own count unmoved at five.

This flips to satisfied when `certify-all`'s overview states the cap choice
as the owner's on every run — or stops scoping the run's owner touchpoints
by attendance at all — so that no shipped surface of either gate permits a
capped run to take the escalation without the owner's word. It would then
stop being satisfied again if: a third path into the intake appeared inside
the repeating cycle (a producer, the inspector, the ledger, the fixer, or
the orchestrator given filing authority); the cap escalation became
reachable before the cap, or stopped running `/verify-issues` before the
presentation; the architect's CONFIRM gate lost its adversarial
owner-roleplay or its dedup, or the veto test lost "inability is never
grounds" (which is what makes exhaustion the cap's honest bound); either
reporting verb acquired a write into `.ok-planner/issues/` (the
`text-presence` assertion fails first); the audit acquired any write,
including ensuring its own layout; the proof run acquired a second durable
output, or its record stopped being ignored by the estate;
`/discover-design` lost its abort-before-phase-1 guard; an intake file
appeared carrying a kind the roll call does not account for, or two files
shared a slug; or a third corpus-checking verb appeared.

## Notes

Both notes below were opened and adjudicated in earlier passes. They are
carried forward verbatim as history. The design artifact's hash moved this
cycle, so precedent lapsed wholesale and neither note binds this
determination; both remain factually consistent with it.

- note: `.ok-planner/design/concepts/finding.md` — Purpose and Boundaries rewritten to the gated intake routing ("it never by itself puts anything in front of the owner — reaching the intake is a separate, gated act"; "the intake is reached only through the gated writers … certification's architect files what survived the fixer's veto test and its own adversarial check"), restating this decision's Choice almost verbatim a few lines below this audit's untouched `cite:` anchor on that same file — changed bytes inside a claim's territory that no citation caught.
  adjudication: promoted — read against the prior text rather than only the new: the concept previously made the mechanical/judgment classification itself the route into the queue ("Judgment findings become open rows in the intake queue"; "Everything downstream … follows from the classification"), which contradicted the Choice's core denial, and the rewrite removes that contradiction and cross-references this decision, so the corroborating-surfaces claim strengthens; tested for the failure mode a near-verbatim restatement would signal — corpus duplication — and it is not one, since the concept states the rule as a property of findings while the decision states it of the verbs and the gate, and the concept names no writer the decision does not; the nominated territory is now carried by the two new anchors on the concept's Purpose and Boundaries sentences alongside the pre-existing anchor on its opening definition.
- note: `.ok-planner/issues/2026-07-28-101259-plumbline-{ci-emission,explain-verb,slug-verb}-ungoverned.md` — three new architect-promoted issue files (`kind: audit`), the first live instances of this decision's "one gated agent writer" claim since the audit was written; worth checking them against the claimed shape rather than reading the gate's prompts again.
  adjudication: promoted — all three verify against the shape the Choice fixes: `kind: audit` as the certification core's CONFIRM branch instructs, `status: open`, exactly the filer's `## Problem` + `## Candidates` slice with no Discussion or Ruling, slugs unique across all fifty-three files in `issues/` and `history/issues/`, and a Problem section attributing the finding to `/certify-all`'s surface inventory — a pass of `/audit`, the pure reporter forbidden to touch the intake — so origin and filing are separated exactly as claimed; the whole-intake kind enumeration (46 `discover`, 5 `audit`, 2 `human`) accounts for every file under the Choice's own roll call with no unexplained writer; the nominated territory is now carried by existence anchors on the three files' stable `issue:` slugs (which survive `/verify-issues`' rewrite, unlike a body pin) and by the pinned CONFIRM span and `kind: audit` anchor in the certification core.

## Citations

- cite-node: plugins/ok/families/ok-planner/skills/prove/SKILL.md @ sha256:c015b0e2ffd7
- cite-node: plugins/ok/families/ok-planner/skills/prove/SKILL.md#prove-the-corpus.what-this-skill-does-not-do @ sha256:0ea56c9a8b95
- cite: plugins/ok/families/ok-planner/skills/prove/SKILL.md :: "never writes to the issue intake"
- cite: plugins/ok/families/ok-planner/skills/prove/SKILL.md :: "produces work items for an **agent**, not a human"
- cite: plugins/ok/families/ok-planner/skills/prove/SKILL.md :: "the only thing a run leaves behind is"
- cite-node: plugins/ok/families/ok-planner/skills/audit/SKILL.md @ sha256:bf7abd501b40
- cite: plugins/ok/families/ok-planner/skills/audit/SKILL.md :: "Audit is a **pure reporter**"
- cite: plugins/ok/families/ok-planner/skills/audit/SKILL.md :: "returns everything in-context, and writes nothing"
- cite: plugins/ok/families/ok-planner/skills/audit/SKILL.md :: "1. Create nothing. This verb is read-only against the project"
- cite: plugins/ok/families/ok-planner/skills/audit/SKILL.md :: "it does not even ensure its own layout"
- cite: plugins/ok/families/ok-planner/skills/audit/SKILL.md :: "Does not touch the issue intake — no filing, no editing, no closing"
- cite: plugins/ok/families/ok-planner/skills/audit/SKILL.md :: "The caller decides what happens next; the audit routes nothing."
- cite: plugins/ok/families/ok-planner/skills/audit/SKILL.md :: "`.ok-planner/issues/` is reached only by the two gated paths — the architect's confirmed forks, and the remainders escalated at the cap"
- cite: plugins/ok/families/ok-plumbline/test/run.sh :: "ok-planner: its compliance verb writes nothing at all, not even its own layout"
- cite-node: plugins/ok/families/ok-planner/scripts/proof-timings @ sha256:a02e8cbfb2fa
- cite-span: plugins/ok/families/ok-planner/scripts/proof-timings :: "def merge(root, entries):" +12 sha256:2487159f0b5b
- cite: plugins/ok/families/ok-planner/scripts/proof-timings :: "    env = dict(os.environ, PROOF_TIMINGS_OUT=spans_file)"
- cite: plugins/ok/families/ok-planner/scripts/ok-planner-gitignore :: "proof-timings.json"
- cite-node: plugins/ok/families/ok-planner/admin/converge @ sha256:a75d56bfab1e
- cite-span: plugins/ok/families/ok-planner/admin/converge :: "SKILLS = {" +14 sha256:28339628a2e3
- cite: plugins/ok/families/ok-planner/admin/converge :: "sed "s/{{OK_PLANNER_VERSION}}/${SUITE_VERSION}/g" "$ESTATE_GITIGNORE" > "${OK_DIR}/.gitignore""
- cite-node: plugins/ok/families/ok-planner/skills/browse/SKILL.md @ sha256:772c8b604d8a
- cite: plugins/ok/families/ok-planner/skills/browse/SKILL.md :: "this verb never re-audits, never"
- cite-node: plugins/ok/families/ok-planner/scripts/corpus-view @ sha256:c985b50ad376
- cite-node: plugins/ok/families/ok-planner/skills/_shared/certification-core.md @ sha256:f42b50f44a66
- cite-node: plugins/ok/families/ok-planner/skills/_shared/certification-core.md#certification-core.how-consumers-use-this-file.certify-review-fix-loop @ sha256:45bcc0229e41
- cite-node: plugins/ok/families/ok-planner/skills/_shared/certification-core.md#certification-core.how-consumers-use-this-file.certify-fixer-prompt @ sha256:0edd73c66429
- cite-node: plugins/ok/families/ok-planner/skills/_shared/certification-core.md#certification-core.how-consumers-use-this-file.certify-architect-prompt @ sha256:6ac606973af0
- cite-node: plugins/ok/families/ok-planner/skills/_shared/certification-core.md#certification-core.how-consumers-use-this-file.change-inspector-prompt @ sha256:c1f9ccb49f08
- cite-node: plugins/ok/families/ok-planner/skills/_shared/certification-core.md#certification-core.how-consumers-use-this-file.certify-presentation @ sha256:b27fc9b325a6
- cite-span: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "**Producers.** The gate's review passes" +5 sha256:78b58ad9d45f
- cite: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "Two paths reach the intake, and the owner is never asked live mid-cycle"
- cite: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "always an owner act, on every run alike, never a default the gate takes for them"
- cite: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "The choice between those two steps is the owner's alone, and the run never takes either step itself."
- cite: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "there is no default and no unattended exception"
- cite: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "1. **Dedup.** Subtract findings already promoted"
- cite-span: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "  - **CONFIRM and promote.** If a reasonable owner might genuinely" +10 sha256:17090e873559
- cite: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "Inability is never grounds"
- cite: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "  - Residue is a report, never a verdict — you do not file issues, do"
- cite: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "the intake except through the architect's adversarial check or the"
- cite-node: plugins/ok/families/ok-planner/skills/certify-work/SKILL.md @ sha256:3fa398a77d5e
- cite-node: plugins/ok/families/ok-planner/skills/certify-work/SKILL.md#certify-the-work-the-change-scoped-gate.what-this-skill-does-not-do @ sha256:a77c5546f7f5
- cite: plugins/ok/families/ok-planner/skills/certify-work/SKILL.md :: "the intake is reached only by the two gated paths"
- cite: plugins/ok/families/ok-planner/skills/certify-work/SKILL.md :: "the gate never takes either cap step itself"
- cite: plugins/ok/families/ok-planner/skills/certify-work/SKILL.md :: "waits for their word, however long that takes, attended or not"
- cite: plugins/ok/families/ok-planner/skills/certify-work/SKILL.md :: "4. **Verify the promoted issues** — if the architect promoted any or the cap escalation filed any."
- cite-node: plugins/ok/families/ok-planner/skills/certify-all/SKILL.md @ sha256:c4edf29db435
- cite-node: plugins/ok/families/ok-planner/skills/certify-all/SKILL.md#certify-everything-the-full-gate.what-certify-orchestrates @ sha256:248f04d4bc07
- cite-node: plugins/ok/families/ok-planner/skills/certify-all/SKILL.md#certify-everything-the-full-gate.what-this-skill-does-not-do @ sha256:85bd0e2543a0
- cite: plugins/ok/families/ok-planner/skills/certify-all/SKILL.md :: "plus, on an interactive run only, the cap choice the loop defines"
- cite: plugins/ok/families/ok-planner/skills/certify-all/SKILL.md :: "the intake is reached only by the two gated paths"
- cite: plugins/ok/families/ok-planner/skills/certify-all/SKILL.md :: "the gate never takes either cap step itself"
- cite: plugins/ok/families/ok-planner/skills/certify-all/SKILL.md :: "the choice is always theirs"
- cite: plugins/ok/families/ok-planner/skills/certify-all/SKILL.md :: "4. **Verify the promoted issues** — if the architect promoted any or the cap escalation filed any."
- cite: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md :: "a question the owner explicitly postpones is filed to"
- cite-node: plugins/ok/families/ok-planner/skills/verify-issues/SKILL.md @ sha256:7b32b860a92d
- cite: plugins/ok/families/ok-planner/skills/verify-issues/SKILL.md :: "For each open id, write an issue file to"
- cite-node: plugins/ok/families/ok-planner/skills/discover-design/SKILL.md @ sha256:80c8c02787b4
- cite-span: plugins/ok/families/ok-planner/skills/discover-design/SKILL.md :: "   - Non-empty `concepts/`, `stories/`, or `decisions/` → abort." +5 sha256:6a9fe916b98e
- cite: plugins/ok/families/ok-planner/skills/discover-design/SKILL.md :: "4. One issue file written to `.ok-planner/issues/` per case"
- cite: plugins/ok/families/ok-planner/skills/_shared/artifact-definitions.md :: "- **`issue:` is a stable fingerprint**"
- cite: plugins/ok/families/ok-planner/admin/ADMINISTRATION.md :: "issue file to `.ok-planner/issues/` per `{{ISSUE-FILE-FORMAT}}` with"
- cite-node: plugins/ok/families/ok-planner/scripts/ok-planner-CLAUDE.md @ sha256:284a6200837e
- cite: plugins/ok/families/ok-planner/scripts/ok-planner-CLAUDE.md :: "cycle cap's escalation (the second gated path — the remainders a"
- cite: plugins/ok/families/ok-planner/scripts/ok-planner-CLAUDE.md :: "kickbacks; the issue intake is reached only by the two gated"
- cite-node: plugins/ok/families/ok-planner/scripts/ok-planner-cheatsheet.md @ sha256:1d1d41e12b03
- cite: plugins/ok/families/ok-planner/scripts/ok-planner-cheatsheet.md :: "architect-confirmed intent forks and the remainders escalated at its"
- cite: checks/text-presence :: "# @decision: prove-audit-audience-split"
- cite: checks/text-presence :: "`.ok-planner/issues/` is reached only by the two gated paths — the architect's confirmed forks, and the remainders escalated at the cap"
- cite: .ok-planner/design/concepts/finding.md :: "A finding is one defect surfaced by any of the suite's review passes"
- cite: .ok-planner/design/concepts/finding.md :: "the repeating cycle reaches the intake through its two gated paths"
- cite: .ok-planner/design/concepts/finding.md :: "the intake is reached only by a deliberate act of filing"
- cite: .ok-planner/design/concepts/issue.md :: "Many writers may open; only the planning ceremony"
- cite: .ok-planner/design/concepts/completion-contract.md :: "loop's cycle cap awaiting the owner"
- cite: .ok-planner/design/stories/bootstrap-design-corpus.md :: "On a project with non-empty durable catalogs the run aborts"
- cite: .ok-planner/design/stories/certify-completion.md :: "at the cycle cap exactly two steps are"
- cite: .ok-planner/history/issues/2026-07-28-101259-plumbline-ci-emission-ungoverned.md :: "issue: plumbline-ci-emission-ungoverned"
- cite: .ok-planner/history/issues/2026-07-28-101259-plumbline-explain-verb-ungoverned.md :: "issue: plumbline-explain-verb-ungoverned"
- cite: .ok-planner/history/issues/2026-07-28-101259-plumbline-slug-verb-ungoverned.md :: "issue: plumbline-slug-verb-ungoverned"
