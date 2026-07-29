---
audit: certify-completion
artifact: story:certify-completion
determination: violated
audited: 2026-07-29T09:20:08Z
artifact-hash: sha256:68a86d5d969f
---

# Does one terminal gate align work to its sprint, drive findings to zero unattended, record the judgment layer durably, reserve the cycle cap's choice to the owner on every run alike, and present outcomes and divergences whole — and does its proof span what it now promises?

Rewritten whole. The design artifact's hash moved from `sha256:b603018c9019`
to `sha256:68a86d5d969f` — the Acceptance's cap clause was amended (the
unattended-escalation default is gone; the choice is the owner's alone and
the run stops and waits, however long that takes) and the Falsifier gained
"the run takes either cap step without the owner's word, attended or not" —
so precedent lapsed wholesale and this is a fresh adversarial read. The
prior pass carried no `## Notes` section and none was opened since, so
there is nothing to carry as history.

The amendment is honored at the load-bearing surfaces — the shared
certification core's exit rule and intake paragraph, both gates'
"does NOT" cap bullets and close-out paragraphs, the planning ceremony's
baked goal rule, the estate template — and the proof grew three conjuncts
that pin the new governing sentences. It is **not** honored at one shipped
surface: `certify-all`'s own overview still scopes the cap choice to an
interactive run, which is the removed default restated, and the new
conjuncts do not reach that gate at all. Both are recorded as claim lines
below.

## Claims

**Title / Story — "one terminal gate that aligns finished work to its
sprint, drives every fixable finding to zero without my mid-run
involvement, and presents outcomes and divergences to me whole, so that
'done' means the same thing for every piece of work and I keep an
after-the-fact veto over every call made in my absence."** Honored in the
sense the story means, with the population of gates enumerated from reality
rather than assumed: the converge core's `SKILLS` map is the list of verbs
a project actually receives, and it vendors exactly two certification
verbs, `certify-work` and `certify-all` (eleven verbs total, map unmoved
this cycle). Both were read in full. They are one gate in the load-bearing
sense — everything except scope is transcluded verbatim from
`skills/_shared/certification-core.md`, both are checked clause by clause
below, and the sprint boilerplate names exactly one of them
(`/certify-work`) as the terminal step. "One terminal gate" is a claim
about a single meaning of done, not a cardinality claim about how many
certification verbs exist — which is precisely why a clause honored in one
gate and contradicted in the other is a finding rather than a curiosity.

**Acceptance 1 — "The owner (or the sprint's own boilerplate) invokes
certification over completed work."** Honored: `certify-work`'s frontmatter
names both entry points ("ONLY activated by explicit /certify-work slash
command, or as the terminal step named in the sprint document's execution
boilerplate"), and the ceremony's baked execution boilerplate names
`/certify-work` in return — the two ends of one handshake.

**Acceptance 2 — "sprint alignment is verified by its own dispatched judge
with undershoot treated as blocking."** Honored on both halves. Each gate
dispatches `{{SPRINT-ALIGNMENT-PROMPT}}` from the shared core with
`[SPRINT PATH]` filled; that block is a subagent dispatch in its own right,
separate from the auditor and the code reviewer, and it is the only
producer that judges the corpus change. Blocking is stated at both ends:
each gate's producer line carries "(an undershoot is a **blocking**
finding)" and the dispatched prompt itself carries "An undershoot is a
BLOCKING finding even when every test is green — that is how spec'd work
ships unbuilt."

**Acceptance 3 — "the completion-contract verbs run."** Honored, checked
against the contract's own baked text rather than the gate's
self-description. The ceremony bakes a four-item contract — deltas applied
verbatim; `/prove` clean over new and touched stories; the
implementation-audit corpus current for everything the change touched or
made stale with any standing violation linked, stated mechanically as
`.ok-planner/bin/audit-check --inspection` exiting 0; and the completion
report finished carrying `/certify-work`'s presentation. `certify-work`'s
producers are that set; `certify-all` runs the same set at full scope plus
whole-corpus `/audit`.

**Acceptance 4 — "implementation audits are written or refreshed by an
auditor that did not implement the work — determining
implemented-and-covered over the touched artifacts and everything the
change made stale."** Honored on all three halves. Author separation is
stated as load-bearing in the auditor file's consumer notes and reinforced
by the core's bar on the fixer editing an audit file. Implemented-and-
covered is the auditor's method step 2 in its own words ("'implemented'
means implemented AND covered"), with step 4 extending it to the proof
frontier. The staleness half is computed rather than remembered: the
re-audit set is the union of the touched stories and decisions, every ref
`audit-check --list-stale` names (explicitly including audits outside the
delta), and every audit the change inspector nominated, recomputed after
each fix cycle with the graph regenerated first.

**Acceptance 5 — "with the change inspection's judged dispositions recorded
durably so a skipped judgment pass fails mechanically rather than reading
clean."** Honored, and unmoved this cycle. The durable state is one
committed file at `.ok-planner/audits/inspection.md`, its format defined
canonically in `{{INSPECTION-REGISTRY-FORMAT}}` and written by the
inspector at method step 4b; the mechanical-failure half lives in the
checker (`check_inspection`, with `outside_units_moved` /
`outside_units_hash` for bytes outside every declared unit and
`git_changed_sources(root, base)` / `baseline_graph_rows` for a
range-scoped run's committed half), and both directions are exhibited by
this story's own proof (below). The two decisions that own this mechanism —
`decision:inspection-registry` and `decision:two-layer-invalidation` —
carry the clause-by-clause derivation; this clause rides on the same
evidence.

**Acceptance 6 — "code review dispatches."** Honored:
`{{CERTIFY-CODE-REVIEW-PROMPT}}` is dispatched from the shared core with
`[REVIEW SCOPE]` filled by each gate.

**Acceptance 7 — "a no-discretion fix loop drives findings to zero within a
bounded number of cycles, every fix a dispatch and never the orchestrator's
own edit."** Honored, and the second half explicit rather than implied: the
loop states "**The orchestrator has no discretion inside it** — it does not
summarize, filter, reorder, or defer findings" and then "**And it never
edits code or corpus itself: every fix, however small, is a dispatch.**",
with the reason given (the orchestrator is often the implementing session).
The bound is three fixer passes. Re-read against the fixer prompt itself,
which files nothing and offers exactly two legal non-fixes.

**Acceptance 8 — "qualitative clauses ground referrals, never findings."**
Honored at three points that agree: the decidability boundary defines the
rim and says a finding grounded solely in it dissolves; the loop's
Producers paragraph says producers do not emit them, the fixer dissolves
any that arrive, the architect adversarially checks each dissolution, and
"The qualitative rim's disposition is the audit's Referrals section, never
the loop"; and the presentation carries a Referrals section fed from the
in-scope audits plus upheld dissolutions.

**Acceptance 9 — "truly unclear findings are filed to the intake queue,
never asked live."** Honored. The core states it as a rule of its own
("Two paths reach the intake, and the owner is never asked live
mid-cycle"), adding that the one place a run stops is the cap and that it
stops "to hold for the owner's choice, not to ask about a finding"; both
gates' NOT-do lists repeat it.

**Acceptance 10 — "at the cycle cap exactly two steps are offered — another
cycle, or escalating the remainders as intake issues — and the choice is
the owner's alone: the run stops at the cap and waits for their word,
however long that takes, with the ceremony proceeding unchanged whichever
step they pick." NOT HONORED — one of the two shipped gates still scopes
the cap choice to an interactive run.**

The clause is honored where the loop is defined and at three of the four
gate surfaces. The core's Exit step carries every conjunct: the cap
"stops there" and "puts exactly two process steps to the owner", the two
steps are named, "**The choice between those two steps is the owner's
alone, and the run never takes either step itself.**", "It waits for their
word however long that takes — a minute or a day — attended or not: there
is no default and no unattended exception, so a goal hook, an
orchestrator, or any run with nobody watching holds at the cap exactly as
an interactive one does", a parked run is "a legal in-flight state", and
"Once the owner picks, the cap changes nothing about the ceremony." The
intake paragraph agrees ("always an owner act, on every run alike, never a
default the gate takes for them"). Both gates' cap bullets agree, in
identical words ("Every run stops there and waits for their word, however
long that takes, attended or not; the gate never takes either cap step
itself"), and both close-outs agree ("the choice is always theirs").

The exception is `certify-all`'s own overview of what it orchestrates,
which still reads: the presentation is "the run's only owner touchpoint
(plus, **on an interactive run only**, the cap choice the loop defines)".
That sentence is the removed default restated from the touchpoint side: it
tells a reader of the gate that on an unattended run the cap choice is not
put to the owner at all — the presentation is the run's only touchpoint —
which is exactly what the amended clause forbids and what the Falsifier
names ("the run takes either cap step without the owner's word, attended or
not"). It is not a stale aside in unrelated prose: it is the gate's own
statement of its cap touchpoint, one of the surfaces the amendment had to
reach, and it now contradicts both the shared core the same gate runs
verbatim and the same file's own "does NOT" bullet fourteen lines from the
end. An unattended `/certify-all` at the cap therefore has, inside one
file, an instruction to hold for the owner and a statement that holding is
an interactive-run-only affair — and the only way to act on the second is
to take a cap step without the owner's word.

**Acceptance 11 — "the owner then receives one whole presentation, written
into the sprint's completion report and walked with them — status,
outcomes, divergences including every call made where sprint and corpus
were silent, findings fixed, issues filed, referrals recorded."** Honored.
The presentation block fixes that order of operations — composed in full
("it is a report and a file deliverable, so it is delivered whole, not
paced"), first written into the sprint's completion report (the file beside
the sprint, created if the executor did not), then walked with the owner —
and its sections are fixed: Status, Outcomes delivered, Divergences,
Findings fixed, Reconciliation ledger, Referrals, Issues promoted.
Divergences carries every fixer call made where the sprint and corpus were
silent, every corpus repair, and every architect REFUTED line, with the
counter-rule "An undershoot must never appear here — it was fixed, not
reported."

**Acceptance 12 — "the sprint archives only when clean, together with its
report, with committing left to the owner and the close-out recording the
close so the next planning ceremony can detect what lands after it."**
Honored across four points in both gates: the close-out offer is
conditioned on "everything certified clean"; the archive moves the sprint
"together with its completion report" and its promoted issue receipts;
archive and commit are performed "only when the owner says so", with "Does
not archive or commit on its own initiative" in the NOT-do list; and the
close-out stamps `closed: <sha>` in one follow-on commit. The consuming end
is real — `/plan-sprint`'s baseline resolution reads exactly that stamp and
refuses to guess when none exists.

**Falsifier.** Nine of the ten conditions have a counterpart prohibition,
each cited: undershoot blocking rather than reported; author separation in
the auditor file; the orchestrator's no-edit rule; the judgment layer's
mechanical floor; findings never triaged, deferred or summarized; the owner
never asked live; the cap's escalation writing issue files rather than
leaving remainders in conversation; the clean-status gate on archival; the
`closed:` stamp; and Divergences as the after-the-fact veto channel. The
one condition **not** closed everywhere is the amendment's own: "the run
takes either cap step without the owner's word, attended or not" — closed
in the core and in both gates' cap bullets, left open by `certify-all`'s
overview per Acceptance 10.

**Proof — "Demo — a certification over work seeded with an undershot work
item and a silent-intent gap, after which a third party sees the undershoot
fixed (absent from the presentation), the gap either fixed-and-reported as
a divergence or filed as an issue, the presentation present in the sprint's
completion report, the sprint archived only on clean status together with
that report, and the archived sprint carrying its close record."**

The story's annotated proof set was re-enumerated from reality
(`rg -l '@story: *certify-completion'`) and still has exactly one member,
`plugins/ok/families/ok-planner/test/proofs.sh`, whose `certify-completion`
section now carries eleven conjuncts. The frontier moved this cycle exactly
as the dispatch describes: the old two-steps/unattended-default conjunct
(which pinned `exactly two process steps exist` and `escalation is the
default`) is gone, replaced by three that pin the new governing sentences —
`puts exactly two process steps to the owner` plus the owner-only
reservation sentence in the core and `the gate never takes either cap step
itself` in the gate; `there is no default and no unattended exception` in
the core plus `waits for their word, however long that takes, attended or
not` in the gate; and the baked goal rule's parked-at-the-cap in-flight
state plus its terminal `Nothing else counts either way.` in the ceremony
template. Each literal was verified present in the file it greps. The other
eight conjuncts stand as the prior pass found them: the `closed:` stamp
resolved through `git cat-file`, undershoot-blocking pinned at both ends,
the Divergences bar, the silent-intent channel, the clean-status gate on
archival, the presentation-into-report sentence, the archive pairing, the
filesystem sprint/report pairing read in both directions, and the seeded
`--inspection` floor exhibited through the project's own checker in both
directions (no registry → non-zero with an `inspection-` finding; recorded
dispositions → exit 0).

**Coverage finding — the new cap conjuncts pin one of the two gates.** The
population here is the certification gates a project receives, enumerated
from the converge core's `SKILLS` map: two. The proof block binds `gate` to
`certify-work` alone (`gate="$family/skills/certify-work/SKILL.md"`) and
`core` to the shared file; every gate-side literal — the owner-only
reservation, the attended-or-not wait, undershoot blocking, the clean-status
gate, the archive pairing — is therefore asserted against `certify-work`
only. `certify-all` is named nowhere in the file (`rg 'certify-all'
test/proofs.sh` returns nothing), so no conjunct would have failed when the
amendment left its overview behind, and none would fail if the amendment
were reverted there tomorrow. For a story whose whole point is that "done"
means the same thing for every piece of work, a tripwire that covers one of
the two gates is the uncovered-member case the audit charter names: the
conjunct's own comment claims that "a regression that reintroduces any
default cap step — for an unattended run or otherwise — drops one of these
sentences and fails here", and that claim is false for half the population.
This is the mechanism by which the Acceptance-10 defect shipped green.

What the block still does not exercise is the seeded agentic run itself — a
shell harness cannot drive five producers and a fix loop — and the block
says so at its assertions. That is not a coverage finding: it is the
legitimate prompt-realized part of a Proof whose deterministic subset is
exercised. Two notes recorded so a later pass need not re-derive them.
First, the floor conjunct runs the *pinned* checker
(`.ok-planner/bin/audit-check`), one converge behind the family source per
the vendored-layer discipline; its seeded change touches a declared unit,
so it exhibits the clause the story makes, while the finer per-node-class
completeness is the two decisions' claim and is held by `test/run.sh`'s
`inspection:` fixtures. Second, several Acceptance mechanism clauses (a
dispatched code review, referrals as the rim's disposition, the
orchestrator's no-edit rule) are pinned by no conjunct; they are properties
of a dispatch graph the harness cannot observe, not enumerable populations
left unexercised, and the prior two passes reached the same boundary.

**The vendored layer.** This repository's own `.claude/skills/` copies
still carry the pre-amendment cap text ("On an unattended run … escalation
is the default"). That is the pinned vendored layer between a release and
the next deliberate converge — `checks/vendored-layer` pins those paths to
HEAD by design and says in its own header that "between a release and the
next deliberate converge the layer legitimately lags the family source in
this repo" — and it is governed by `decision:per-project-pinning`. It is
not a finding here; the family canonicals are the judged reality.

## Determination

**violated**, on two claim lines, both about the amendment this cycle
ratified:

1. **Acceptance 10 / the Falsifier's "attended or not".**
   `plugins/ok/families/ok-planner/skills/certify-all/SKILL.md` still
   states that the presentation is "the run's only owner touchpoint (plus,
   on an interactive run only, the cap choice the loop defines)". The
   amended story reserves the cap's choice to the owner on every run alike
   and requires the run to stop and wait however long that takes; this
   sentence tells one of the two shipped gates that the cap is an owner
   touchpoint only when someone is watching, which is the abandoned default
   restated and the only reading under which an unattended run takes a cap
   step itself. What was found instead of a uniform rule is a
   self-contradicting gate: the correct rule in its "does NOT" bullet and
   its close-out, the old scoping in its overview.
2. **Proof coverage over the gate population.** The three new conjuncts
   that pin the amendment bind `gate` to `certify-work` alone;
   `certify-all` appears in no conjunct in the story's only proof artifact,
   so the gate whose text is wrong is also the gate the proof never reads.
   The uncovered member is `certify-all`'s cap surface.

Everything else the story stakes itself on is real and consistent between
the two gates: a dispatched alignment judge with blocking undershoot, an
auditor that did not implement the work and determines
implemented-and-covered, a computed rather than remembered staleness set, a
durable committed inspection record whose absence fails mechanically, an
orchestrator that dispatches every fix and edits nothing, a bounded
no-discretion loop whose cap offers exactly two steps and whose choice the
core and both gates' bullets reserve to the owner, referrals as the rim's
only disposition, no question ever asked live mid-cycle, a whole
presentation written into the completion report and walked, a close that
archives sprint with report and leaves a resolvable baseline, and a baked
goal rule that recognizes a parked-at-the-cap run as legally in flight.

This flips to satisfied when both claim lines close: the `certify-all`
overview sentence states the cap choice as the owner's on every run (or
stops scoping the touchpoint by attendance at all), **and** the proof's cap
conjuncts assert the owner-only reservation and the attended-or-not wait
against `certify-all` as well as `certify-work` — the population is two
gates, and a conjunct that reads one of them cannot detect the regression
that produced this determination.

## Referrals

- referral: the presentation is walked with the owner in the session, not merely written to a file
  clause: "the owner then receives one whole presentation, written into the sprint's completion report and walked with them"
  delivered: the presentation block fixes the two-step form — composed whole, written into the sprint's completion report, then walked with the owner in session — and both gates' Present steps name it; whether a given walk-through actually lands for the owner is not opined on here
  discipline: human-review

## Citations

- cite-node: plugins/ok/families/ok-planner/skills/certify-work/SKILL.md @ sha256:3fa398a77d5e
- cite-node: plugins/ok/families/ok-planner/skills/certify-work/SKILL.md#certify-the-work-the-change-scoped-gate.process @ sha256:ab43437dd800
- cite-node: plugins/ok/families/ok-planner/skills/certify-work/SKILL.md#certify-the-work-the-change-scoped-gate.what-this-skill-does-not-do @ sha256:a77c5546f7f5
- cite-node: plugins/ok/families/ok-planner/skills/certify-all/SKILL.md @ sha256:c4edf29db435
- cite-node: plugins/ok/families/ok-planner/skills/certify-all/SKILL.md#certify-everything-the-full-gate.what-certify-orchestrates @ sha256:248f04d4bc07
- cite-node: plugins/ok/families/ok-planner/skills/certify-all/SKILL.md#certify-everything-the-full-gate.process @ sha256:619fe94738d0
- cite-node: plugins/ok/families/ok-planner/skills/certify-all/SKILL.md#certify-everything-the-full-gate.what-this-skill-does-not-do @ sha256:85bd0e2543a0
- cite-node: plugins/ok/families/ok-planner/skills/_shared/certification-core.md @ sha256:f42b50f44a66
- cite-node: plugins/ok/families/ok-planner/skills/_shared/certification-core.md#certification-core.how-consumers-use-this-file.certify-review-fix-loop @ sha256:45bcc0229e41
- cite-node: plugins/ok/families/ok-planner/skills/_shared/certification-core.md#certification-core.how-consumers-use-this-file.sprint-alignment-prompt @ sha256:3094f0778407
- cite-node: plugins/ok/families/ok-planner/skills/_shared/certification-core.md#certification-core.how-consumers-use-this-file.certify-fixer-prompt @ sha256:0edd73c66429
- cite-node: plugins/ok/families/ok-planner/skills/_shared/certification-core.md#certification-core.how-consumers-use-this-file.certify-architect-prompt @ sha256:6ac606973af0
- cite-node: plugins/ok/families/ok-planner/skills/_shared/certification-core.md#certification-core.how-consumers-use-this-file.certify-presentation @ sha256:b27fc9b325a6
- cite-node: plugins/ok/families/ok-planner/skills/_shared/certification-core.md#certification-core.how-consumers-use-this-file.change-inspector-prompt @ sha256:c1f9ccb49f08
- cite-node: plugins/ok/families/ok-planner/skills/_shared/implementation-auditor.md @ sha256:049ea0635856
- cite-node: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md @ sha256:737bfc84a094
- cite-node: plugins/ok/families/ok-planner/scripts/ok-planner-CLAUDE.md @ sha256:284a6200837e
- cite-node: plugins/ok/families/ok-planner/scripts/audit-check @ sha256:32b1732e3fdd
- cite-node: plugins/ok/families/ok-planner/test/proofs.sh @ sha256:10f3b1e855fd
- cite-node: plugins/ok/families/ok-planner/test/run.sh @ sha256:a4d8463946b0
- cite-node: plugins/ok/families/ok-planner/admin/converge @ sha256:a75d56bfab1e
- cite-span: plugins/ok/families/ok-planner/admin/converge :: "SKILLS = {" +14 sha256:28339628a2e3
- cite: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "The choice between those two steps is the owner's alone, and the run never takes either step itself."
- cite: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "there is no default and no unattended exception"
- cite: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "A run parked at the cap awaiting the owner's direction is a legal in-flight state"
- cite: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "always an owner act, on every run alike, never a default the gate takes for them"
- cite: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "Two paths reach the intake, and the owner is never asked live mid-cycle"
- cite: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "An undershoot is a BLOCKING finding even when every"
- cite: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "An undershoot must never appear here"
- cite: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "written into the sprint's completion report"
- cite: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "**And it never edits code or corpus itself: every fix, however small, is a dispatch.**"
- cite: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "The qualitative rim's disposition is the audit's Referrals section, never the loop"
- cite-span: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "**Producers.** The gate's review passes" +5 sha256:78b58ad9d45f
- cite-span: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "  4b. Update the inspection registry per the format above: one" +13 sha256:11fba0d20687
- cite: plugins/ok/families/ok-planner/skills/certify-work/SKILL.md :: "the gate never takes either cap step itself"
- cite: plugins/ok/families/ok-planner/skills/certify-work/SKILL.md :: "waits for their word, however long that takes, attended or not"
- cite: plugins/ok/families/ok-planner/skills/certify-work/SKILL.md :: "the choice is always theirs"
- cite: plugins/ok/families/ok-planner/skills/certify-work/SKILL.md :: "an undershoot is a **blocking** finding"
- cite: plugins/ok/families/ok-planner/skills/certify-work/SKILL.md :: "This producer's clean bar: `audit-check --inspection` exits 0"
- cite: plugins/ok/families/ok-planner/skills/certify-work/SKILL.md :: "together with its completion report"
- cite: plugins/ok/families/ok-planner/skills/certify-work/SKILL.md :: "Does not archive or commit on its own initiative."
- cite: plugins/ok/families/ok-planner/skills/certify-all/SKILL.md :: "plus, on an interactive run only, the cap choice the loop defines"
- cite-span: plugins/ok/families/ok-planner/skills/certify-all/SKILL.md :: "All five are **producers** feeding the shared **review-fix loop**" +1 sha256:5ab9cb48b580
- cite: plugins/ok/families/ok-planner/skills/certify-all/SKILL.md :: "the gate never takes either cap step itself"
- cite: plugins/ok/families/ok-planner/skills/certify-all/SKILL.md :: "the choice is always theirs"
- cite: plugins/ok/families/ok-planner/skills/_shared/implementation-auditor.md :: "**Author separation is load-bearing:**"
- cite-span: plugins/ok/families/ok-planner/skills/_shared/implementation-auditor.md :: "  2. For every quantifier (every, all, each, never, none, only," +24 sha256:8affebfbb863
- cite-span: plugins/ok/families/ok-planner/skills/_shared/implementation-auditor.md :: "  4. For stories: also judge the proof. Run" +15 sha256:0bd501cdb1bb
- cite: plugins/ok/families/ok-planner/skills/_shared/artifact-definitions.md :: "- **Determinations attach only to the mechanical core.**"
- cite-node: plugins/ok/families/ok-planner/skills/_shared/artifact-definitions.md#shared-artifact-definitions.token-catalog.inspection-registry-format @ sha256:5f1c4527fd56
- cite: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md :: "loop's cycle cap awaiting the owner's direction is a legal in-flight"
- cite: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md :: "either cap step itself. Nothing else counts either way."
- cite-span: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md :: "3. The implementation-audit corpus is current for everything the" +5 sha256:763f4d79132c
- cite: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md :: "1. **Resolve the baseline.** Every sprint closed by a certify gate carries the closing commit"
- cite: plugins/ok/families/ok-planner/scripts/ok-planner-CLAUDE.md :: "the run to take either cap step itself."
- cite-span: plugins/ok/families/ok-planner/scripts/audit-check :: "def check_inspection(root, findings, stale_files, stale_identities," +77 sha256:fd200fc87be8
- cite-span: plugins/ok/families/ok-planner/scripts/audit-check :: "def outside_units_moved(root, rel, baseline, has_units):" +25 sha256:f7ca9101db4a
- cite-span: plugins/ok/families/ok-planner/scripts/audit-check :: "def git_changed_sources(root, base=None):" +41 sha256:ab6b93bcae38
- cite-span: plugins/ok/families/ok-planner/test/proofs.sh :: "# --- certify-completion: the close leaves its record --------------------------" +175 sha256:26cf0307b0fb
- cite-span: plugins/ok/families/ok-planner/test/proofs.sh :: "# certify-completion, the unattended promises. The gate is a prompt, so" +6 sha256:3b94fbd88864
- cite-span: plugins/ok/families/ok-planner/test/proofs.sh :: "# The cap's two steps stand, and the choice between them is reserved to" +14 sha256:ec3da1d8f882
- cite-span: plugins/ok/families/ok-planner/test/proofs.sh :: "# Parked at the cap is a legal in-flight state, not a licence to finish:" +6 sha256:d91534f21938
- cite: plugins/ok/families/ok-planner/test/run.sh :: "run_case "inspection: missing registry""
- cite: plugins/ok/families/ok-planner/test/run.sh :: "run_case "inspection: outside-units change is no vacuous clean""
- cite: plugins/ok/families/ok-planner/test/run.sh :: "run_case "inspection: the range-scoped floor sees the committed change""
