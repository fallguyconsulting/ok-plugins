---
closed: 4950be93c65e5bf3f9c769937b559b8d059f1f54
---
# Sprint: Ratify the inline certification repairs

## Intent

Bring the design corpus into agreement with the certification-process
repairs made inline ahead of this sprint and shipped in the suite's
current release: the decidability boundary and audit referrals, the
implemented-and-covered audit charter with proof-frontier citations,
the read-only reviewer discipline, the inspection registry and its
mechanical closure floor, the cap's two-step escalation, the
execution-owned completion report and the repository-verifiable
completion contract with its goal rule, and the intent-altitude
ruling register for issues. One work item resolves the standing
violated determination on `story:explain-lint-rules` under the
ratified rules.

Issues promoted into this sprint:

- acceptance-clauses-must-be-deterministically-decidable
- explain-lint-rules-story-carries-qualitative-commitments
- cap-remainders-leave-no-durable-record
- no-producer-expands-or-bounds-test-coverage
- certification-leaves-no-run-receipt
- sprint-work-presentation-lost-with-execute-plan
- leaf-agent-rule-unscoped-second-person
- completion-contract-terms-not-inspectable
- boilerplate-lost-task-list-instruction
- orchestrator-not-fixer-inside-loop
- auditor-executes-instead-of-reading
- verified-issues-still-verbose-and-planner-toned
- cap-decision-reserved-to-owner (promoted in-flight by the owner,
  2026-07-29: the cap's two-step choice is the owner's alone — the
  run waits for their word, never escalating by default; the deltas
  below carry the amended final forms)

## Corpus deltas

### New decision: inspection-registry

```markdown
---
decision: inspection-registry
---

# The change inspection's state is a permanent node-keyed registry, not a per-run receipt

## Choice

The judgment layer's durable state is one committed registry file in
the audit corpus, written only by certification's change inspector:
entries keyed to source-graph node identities and pinned to the
node's recorded content hash, storing only the judged classes —
residue (changed code no audit claims) and adjudication pointers
(the audit carrying the nomination's note) — never the mechanical
disposition, which is recomputable. Entries carry audit-style
precedent semantics: an entry stands while its pin holds and lapses
when the node's content moves or its identity vanishes, so the
registry rides forward cycle to cycle and sprint to sprint, and each
inspection pass works only the unclassified new work. The vendored
checker enforces the closure floor mechanically: every source node
the change touched is accounted — by a stale citation or a live
entry — or the gate fails, and a missing registry with changed nodes
fails the same way, so a skipped judgment pass is a mechanical
failure, never a vacuous clean. Standing residue is reported to the
owner as intake material and served to the project's local corpus
view (see also: local-web-surface under decisions).

## Rationale

The gate's judgment layer used to live only in conversation: the
inspector reported its reconciliation in-context, and the clean
bar's "no note left open, no hunk without a disposition" went
vacuously true whenever the inspector never ran — a skipped pass and
a clean pass were indistinguishable, and a goal-seeking orchestrator
took the early-out. A durable record fixes that only if the checker
can tell whether the record covers the change at hand, which is what
node keys and hash pins buy: coverage is computed against the same
committed graph the citations use, unit by unit. Storing only the
judged classes keeps the registry small and honest — the mechanical
account is recomputable at any moment, so storing it would only let
it go stale — and precedent semantics make maintenance incremental:
last sprint's residue rides forward untouched until the code it
names actually changes, the same convergence property recorded
adjudications already rely on (see also: recorded-adjudication under
decisions).

## Alternatives

- A per-run receipt content-addressed to the certified diff — proves
  one run happened, but its coverage dies with that diff: the next
  change starts blind and nothing rides forward.
- Storing every disposition, mechanical ones included — a larger
  record whose mechanical rows go stale the moment anything moves,
  duplicating what the checker recomputes for free.
- In-context reporting only — leaves a clean pass and a skipped pass
  indistinguishable to the gate and to any goal checker.
```

### New concept: completion-report

```markdown
---
concept: completion-report
---

# Completion report

## What it is

The completion report is a sprint execution's durable record: one
file beside the sprint document, named for it, that the executor
keeps current as stages land — the work done, every divergence, and
every call made where the sprint was silent — and that the closing
certification finishes by writing its presentation into. It is a
record of one execution, never a plan document, and it archives
together with its sprint.

## Purpose

The report gives the close of a sprint an artifact instead of a
memory. Without a durable report, the end-of-sprint ceremony —
outcomes, divergences, the archive-and-commit offer — lives only in
conversation, where any upstream failure deletes it silently, and a
completion contract's final term is a claim about session history no
checker can inspect. The report lets the ceremony's material survive
the session that produced it, gives the contract an inspectable
final term, and gives a goal checker the artifact whose absence
means not-done.

## Boundaries

The report owns the record of one execution: what was done, what
diverged, what was decided in the owner's absence, and — once
certification finishes it — the presentation the owner walks. It
does NOT own the work's definition (see also: sprint), the
derivation of certification outcomes (see also: certify-completion
under stories), or the audit record (see also:
adversarial-implementation-audits under decisions). Once archived it
is a project record under the estate's record discipline (see also:
estate).

## Invariants

- Kept by the executor from the first stage, never reconstructed at
  the end.
- Finished only by the closing certification: the presentation the
  owner walks is written into the report, so the artifact a goal
  checker requires and the ceremony the owner sees are the same
  thing.
- Archives with its sprint, as one record of intent and execution.
- A sprint without its finished report is not done, whatever else
  verifies.
```

### Amend decision: adversarial-implementation-audits

```markdown
---
decision: adversarial-implementation-audits
---

# Implementation claims are verified by adversarial audits, not test mandates

## Choice

Whether the project implements what a story or decision claims is
determined by an adversarial implementation audit: a durable,
per-artifact determination (`satisfied` or `violated`) recorded in a
fourth corpus collection, written only by a certification producer
that did not implement the work under audit, and never hand-edited.
The audit's charter is implemented AND covered, bounded by the
artifact's decidable claims: for each quantified claim, completeness
is the difference of two enumerable lists — the members enumerated
from the population source minus the members the proofs exercise —
with uncovered members reported as ordinary findings and growth of
the proof suite governed by the measure-first cost discipline (see
also: measure-first-verification-cost under decisions). Qualitative
clauses ground no determination and no finding: each is recorded as
a referral — the promised thing verified to exist in form,
suitability explicitly not opined, the owning discipline named.
Audits cite the source graph by node identity and content hash —
span anchors within a node where finer resolution carries the
verdict — and pin quantified claims' population sources whole;
citations cover both frontiers, the code that delivers a claim and
the proof code that exercises it, so a proof edit re-stales the
coverage judgment that rested on it. A deterministic checker flags
any audit whose design artifact or cited nodes have changed, and the
re-audit set is that stale set plus the change-inspection
nominations the auditor adjudicates (see also: two-layer-invalidation
under decisions). The checker masks release-mutable metadata — the
suite-version stamp lines materialization writes and the plugin
manifests' version fields — before hashing anything a citation or
pin covers, so a release that changes only versions voids no audit.
The auditor reads and judges, never executes: demonstrations are run
by the gate that dispatched it and consumed as recorded precedent,
and a claim only a new demonstration can settle is reported back on
a defined line for the gate to run. Stories additionally carry
deterministic integration-test proofs; decisions carry no test
obligation. A negative determination stands in place until a
re-audit flips it, and blocks certification unless linked to an
intake issue awaiting the owner's ruling.

## Rationale

The claims that go wrong in practice are disproportionately
structural, negative, or quantified — a transport a decision's text
never reached, a rationale selling a property nothing delivers, an
"every" enforced on the members someone remembered — and for those
the honest verification is an adversarial reading against reality,
with the population enumerated from the compose file or route table
rather than from the artifact's own examples. Coverage belongs to
the same charter because its tractable form is the same enumeration:
falsifier-driven coverage ("find a way this fails") does not
terminate, while a population diffed against the members the proofs
exercise makes completeness a checkable difference of two lists,
found in one audit rather than reactively, one gap per adversarial
pass. Mandating a test per claim buys determinism at the cost of
test-side machinery per claim and still misses the claims that are
not runtime-observable; an audit covers every decidable claim at the
cost of trusting a reader, and that trust is bounded three ways: the
reader is never the author of the work, the determination is a
citation-carrying record that can be re-derived and compared, and
staleness is mechanical — the fixer cannot satisfy an audit by any
means except changing the code it cites, which moves the hashes of
the nodes it cites and forces a fresh adversarial read. The reader
is also only a reader: ad hoc execution corrupts the state under
judgment and drifts the audit into experimentation, so execution
stays with the gate — which owns the proof verb and the project's
stack — and the defined report line for a needed demonstration keeps
"this must be run" from dead-ending into the auditor running it
anyway. Determinations stop at the decidability line because an
adversarial re-audit against quality prose never converges — there
is always one more sense in which an explanation might fall short —
so qualitative clauses become referrals marking where this process's
jurisdiction ends, and artifacts stay free to state qualitative
intent. Structural node identities and content hashes rather than
line numbers make the tripwire survive unrelated edits; whole-source
pins on population sources make a new member re-open the exact
audits whose quantifiers it threatens; proof files are cited like
any evidence, so a coverage judgment re-opens when the proof it
rested on changes; and the judged inspection layer covers the one
blindness citations keep — work added beside a cited span breaks no
hash, so an agent reads the change itself and its nominations reach
the auditor as recorded, adjudicable candidates (see also:
recorded-adjudication under decisions). Version stamps sit inside
otherwise-cited bytes and must change on every release, so masking
them is what keeps the tripwire meaningful: staleness signals
substantive change, never the release act, while any edit beyond the
masked patterns still breaks its anchor.

## Alternatives

- Test mandates with registered falsifier exhibits per claim —
  deterministic and unfoolable where it applies, but a per-claim
  authoring and maintenance layer, and structurally blind to claims
  that live in rationale text, titles, and concept invariants.
- Read-and-judge review without durable records — catches the same
  class once, but leaves nothing to go stale, so nothing triggers
  the re-read when the code moves.
- Diff-scoped review as the only reader — reviews the change, so a
  claim whose code was never written produces nothing to review;
  absence has no diff.
- Hashing stamped bytes as-is and re-auditing at release time —
  every release voids whichever audits cite stamped files and buys
  an agentic re-read that can only confirm version strings changed.
- An auditor licensed to run tests and experiments — settles some
  claims first-hand, at the cost of corrupting the state under
  judgment and leaving the evidence unrecorded.
- Forbidding qualitative language in artifacts so every clause is
  mechanically auditable — a corpus made clean by silencing the
  intent stories exist to carry.
- A dedicated coverage producer in the certification roster — a
  separate seat duplicating the enumeration the audit already
  performs against the same populations.
```

### Amend decision: two-layer-invalidation

```markdown
---
decision: two-layer-invalidation
---

# Re-audit triggers are citations plus judged change inspection, never annotations

## Choice

What forces an audit to be re-derived is two layers reading the same
source graph. The mechanical layer needs no review: a cited node
identity that no longer resolves, a cited content hash that moved,
or a design artifact whose own hash changed invalidates the audit
outright. The judgment layer covers what anchors cannot see: an
inspector reads the change under certification — the diff itself,
working tree or commit range — and nominates the audits whose
claimed closures contain changed nodes; nominations are recorded on
the audits they implicate and adjudicated by the auditor, never
auto-invalidating. The judgment layer's completeness is itself
mechanical: every changed source node must be accounted — by a stale
citation or by a live entry in the committed inspection registry —
or the checker fails the gate, so a skipped inspection pass fails
instead of passing vacuously (see also: inspection-registry under
decisions). Code annotations play no part in either layer.

## Rationale

Citations alone under-invalidate: work added beside a cited span
breaks no hash, so a purely mechanical trigger is silent about
violations introduced in code no audit cited. Annotation-derived
triggers err in both directions at once, because they trust
self-reporting — a mis-tagged file invalidates strangers, an
untagged one invalidates nothing, and at file granularity one
incidental tag sweeps unrelated artifacts into every close. The
change visible to git is the only ground truth about what work
happened, and mapping it to the claims it bears on requires
judgment — so an agent renders that judgment, and what the gate
consumes is the recorded adjudication, never a tag. The two layers
bound each other twice over: the mechanical floor fires regardless
of anyone's opinion; the judged layer's variance is bounded by being
candidacy — the auditor, not the inspector, decides — and its
absence is bounded by the closure floor, because a judgment pass
whose skipping looks clean will be skipped exactly when it matters.

## Alternatives

- Annotation-derived touched sets — mechanical to compute, but
  inherits every annotation mistake and over-sweeps at file
  granularity.
- Pure citation staleness — fully deterministic, but blind to
  violations introduced in uncited code until the next whole-corpus
  pass.
- Re-deriving every audit at every close — sound and unaffordable;
  whole-corpus re-derivation is deliberately an owner-cadence act.
- Trusting the orchestrator's word that the judgment pass ran —
  self-reported process state, the exact failure the closure floor
  exists to remove.
```

### Amend decision: recorded-adjudication

```markdown
---
decision: recorded-adjudication
---

# Certification judgments are recorded transactions, not per-run derivations

## Choice

Every judgment the certification gate consumes is written down where
the next run reads it. An inspector's nomination lands as a
provisional note on the audit it implicates; the auditor adjudicates
each note — promoted into a citation, or dismissed with a stated
reason — and the notes and their adjudications are part of the audit
record. The inspection's own judged dispositions persist the same
way, in the committed inspection registry, keyed and pinned so each
stands until the code it names moves (see also: inspection-registry
under decisions). A recorded adjudication binds later runs:
departing from one requires naming the cited reality that changed.
The gate closes only when every hunk of the change carries a
disposition — mechanically accounted, adjudicated, or residue — and
residue (change no claim accounts for) is reported to the owner as
intake material and served to the project's local corpus view (see
also: local-web-surface under decisions), never silently dropped.

## Rationale

Oscillation lives in re-derivation: two readings of unchanged
reality can disagree, and when nothing records the first reading,
the second is free to flip it. Recording adjudications makes
convergence a property of the record rather than of agent
temperament — a flip must point at changed reality — and the closure
requirement turns "was everything considered?" from a hope into a
checkable invariant, at a bookkeeping cost proportional to the
change.

## Alternatives

- Fresh judgment at every run — maximally open-minded, and the same
  interpretive seam re-litigates at every close without ever
  settling.
- Precedent as prompt discipline only ("read the prior audit") —
  cheaper, but binding by temperament: nothing distinguishes a
  justified departure from an arbitrary one.
- Disposition tracking without recorded reasons — the ledger closes,
  but dismissals cannot bind the next run, so candidacy re-litigates
  anyway.
```

### Amend concept: completion-contract

```markdown
---
concept: completion-contract
---

# Completion contract

## What it is

The completion contract is the fixed, verbatim stop condition
carried in every sprint, every term verifiable from the repository
as it stands: the corpus matches every delta applied verbatim; the
proof run returns clean over the new and touched stories — every
registered proof present, passing, and runnable; the
implementation-audit corpus is current for everything the change
touched or made stale, with any standing violation linked to an
intake issue and the currency mechanically checkable — the vendored
checker confirms citations current and every changed source node
dispositioned by the change inspection; and the sprint's completion
report is finished — the work and divergences recorded,
certification's presentation written in, the review-fix loop run
last and come back clean with every finding fixed or
promoted-and-verified.

## Purpose

Because the planner deliberately ships no execution engine, the
contract is the entire interface between planning and execution: it
tells whoever executes a sprint when the work is done, identically
for every executor. It is what does not scale away when execution
fans out.

## Boundaries

The contract owns the definition of "done" for a sprint, and its
scope is the change: the stories, decisions, and audits the work
touched. Whole-corpus proof and audit are the whole-corpus
certification gate's business, run on the owner's cadence rather
than per close (see also: certify-completion under stories). It does
NOT own how work is staged or performed — that is execution-time
planning (see also: sprint) — and it does not derive the record it
requires: the completion report is execution's artifact, finished by
certification (see also: completion-report). The certification gate
is the contract's realization plus review and presentation. The
contract also legitimizes non-slash invocation of the checking verbs
by whoever is executing it (see also: skill).

## Invariants

- The ordering is load-bearing: the corpus checks run last because
  their judgment findings seed the next sprint's intake.
- The contract text is included verbatim in every sprint; executors
  owe the contract and nothing else.
- Every term is verifiable from the repository as it stands: no term
  is a claim about session history, and a checker needs nothing but
  the tree to discharge the contract.
- The goal rule: the contract is met in exactly two ways — the
  sprint file has moved to the archive bearing its close stamp
  (terminal, whatever else seems unfinished), or it is still in
  flight and every term verifies against the repository; a missing
  completion report means not done, however green the rest looks. A
  run parked at the review-fix loop's cycle cap awaiting the owner's
  direction is a legal in-flight state — not done, not failed, and
  never grounds for the run to take either cap step itself.
- Story proofs are established by deterministic execution; whether
  an implementation genuinely satisfies a claim is established by
  the implementation audit, never by the implementer's own read (see
  also: proof, falsifier).
```

### Amend concept: sprint

```markdown
---
concept: sprint
---

# Sprint

## What it is

A sprint is the planning ceremony's terminal artifact: a
change-order against the design corpus, expressed as final-form
corpus deltas plus the flat, unordered work items that realize them,
terminated by a fixed completion contract. It is a sprint in the
scrum sense — a collection of potentially disparate changes with no
required unifying focus and no manufactured narrative.

## Purpose

The sprint is the whole interface between planning and execution.
Because it is self-sufficient — everything the work needs, in final
form — any executor works from the same brief: an inline session, a
fan-out of subagents, or an external orchestrator. Staging and
sequencing belong to execution time, so the sprint never has to be
rewritten into a plan.

## Boundaries

A sprint owns approved intent: deltas, work items, and the two
verbatim boilerplate sections (execution shape and completion
contract). It does NOT own execution order — items are never grouped
into stages, phases, or themes — and it is NOT the intake queue:
questions live as issues until promoted, and after promotion the
sprint alone is the source of truth (see also: issue, corpus-delta,
completion-contract, plan-a-sprint under stories). The record of its
execution is its companion completion report, kept by the executor
and archived with it (see also: completion-report). Sprints are
project records under the estate's record discipline, and the sprint
being executed is that discipline's single live exception — the one
record allowed in context (see also: estate, design-corpus). An
archived sprint carries the record of its close, which the next
planning ceremony reads as the baseline for detecting work done out
of band (see also: closing-commit-baseline under decisions).

## Invariants

- Self-sufficiency: an executing agent never reads the queue or
  history to learn what a promoted issue "really meant"; a genuine
  gap is raised with the owner, never filled by inference.
- Work items name the stories and decisions they make true, and
  describe outcomes, not methods.
- A sprint archives only once it certifies clean, together with its
  completion report; an uncertified sprint stays in flight.
- A sprint is never rewritten into a plan document.
```

### Amend concept: issue

```markdown
---
concept: issue
---

# Issue

## What it is

An issue is anything about the design corpus that requires human
judgment to resolve — sloppy, unspecified, unclear, overloaded,
conflicting, or vestigial design, a proof whose intent has drifted,
or a question deferred during planning. Issues live as one markdown
file each in the intake directory, named so a listing sorts
chronologically; a file's status moves forward only — open, then
verified once a from-the-top discussion is prepared, then a terminal
state — and a non-empty ruling section is the owner's decision,
however it got there.

## Purpose

The issue separates judgment from mechanics: anything mechanically
fixable is fixed in-cycle by whoever found it and never filed, so an
issue file means "requires owner calibration" by construction. The
intake turns scattered design muddiness into a single owner-facing
agenda that verification makes ruling-ready and planning drains
deliberately.

## Boundaries

An issue is a question waiting to reach a sprint — the intake is a
holding area, not a work tracker; nothing is worked or tracked to
completion in it. Many writers may open an issue; the verifier
prepares each file for ruling and may close only what the corpus
already answers or the authoring rules fully determine, every such
closure reported for the owner's veto. All other closure is an owner
act recorded through the planning ceremony — promoted into a sprint
or retired with a reason — and closed files move to the archive.
After promotion the sprint alone carries the resolution (see also:
sprint, plan-a-sprint under stories). The issue sits at the top of a
three-step altitude ladder: the ruling states intent, the planning
ceremony translates it into deltas and work items, and the
implementer owns mechanics — each step reading the one above it,
with the ceremony's clarification question as the escape when a
ruling cannot be understood. The nature of an issue is its category;
the identity of its writer is its kind — two orthogonal labelings.
Mechanical findings are the neighbor that never becomes an issue
(see also: finding).

## Invariants

- Only judgment items become issues.
- Slugs are stable fingerprints of artifact plus nature — writers
  check the intake first and file only genuinely new questions, so
  re-observation files nothing.
- Many writers may open; only the planning ceremony and the
  verifier's corpus-cited closures terminate, and the verifier's
  closures are always reported for veto.
- A non-empty ruling is the ruled signal: the next planning session
  carries it into the sprint it plans without re-discussion.
- Settled means settled: a later sprint never re-opens a promoted
  issue; a wrong resolution becomes a new issue with its own file.
- The verified narrative serves one fixed audience — an experienced
  engineer who doesn't know much about the project or its
  implementation and doesn't have a lot of time to read, but needs
  to evaluate a ruling based on an informed technical opinion — and
  every sentence earns its place against that purpose.
- Candidates and rulings live at intent altitude: durable statements
  of what should change and why, in an engineer's plain register —
  never file or symbol citations, and never delta or
  artifact-operation phrasing, which is the planning ceremony's
  translation to make.
```

### Amend story: certify-completion

```markdown
---
story: certify-completion
---

# Certify completed work through one gate

## Story

As a project owner, I want one terminal gate that aligns finished
work to its sprint, drives every fixable finding to zero without my
mid-run involvement, and presents outcomes and divergences to me
whole, so that "done" means the same thing for every piece of work
and I keep an after-the-fact veto over every call made in my
absence.

## Acceptance

The owner (or the sprint's own boilerplate) invokes certification
over completed work → sprint alignment is verified by its own
dispatched judge with undershoot treated as blocking, the
completion-contract verbs run, implementation audits are written or
refreshed by an auditor that did not implement the work —
determining implemented-and-covered over the touched artifacts and
everything the change made stale, with the change inspection's
judged dispositions recorded durably so a skipped judgment pass
fails mechanically rather than reading clean — code review
dispatches, and a no-discretion fix loop drives findings to zero
within a bounded number of cycles, every fix a dispatch and never
the orchestrator's own edit; qualitative clauses ground referrals,
never findings; truly unclear findings are filed to the intake
queue, never asked live; at the cycle cap exactly two steps are
offered — another cycle, or escalating the remainders as intake
issues — and the choice is the owner's alone: the run stops at the
cap and waits for their word, however long that takes, with the
ceremony proceeding unchanged whichever step they pick; the owner
then receives
one whole presentation, written into the sprint's completion report
and walked with them — status, outcomes, divergences including every
call made where sprint and corpus were silent, findings fixed,
issues filed, referrals recorded — and the sprint archives only when
clean, together with its report, with committing left to the owner
and the close-out recording the close so the next planning ceremony
can detect what lands after it.

## Falsifier

An undershoot survives into the presentation instead of being fixed;
the implementer authors its own audit determinations; the
orchestrator does fixer work itself inside the loop; the judgment
layer is skipped and the gate still reads clean; findings are
triaged, deferred, or summarized away; the owner is interrupted
mid-run with questions; the run takes either cap step without the
owner's word, attended or not; a capped run's remainders survive
only in the conversation; an uncertified sprint is archived; a close
leaves
no record for the next ceremony's baseline; or divergences the owner
should veto go unreported.

## Proof

Demo — a certification over work seeded with an undershot work item
and a silent-intent gap, after which a third party sees the
undershoot fixed (absent from the presentation), the gap either
fixed-and-reported as a divergence or filed as an issue, the
presentation present in the sprint's completion report, the sprint
archived only on clean status together with that report, and the
archived sprint carrying its close record.
```

### Amend decision: prove-audit-audience-split

```markdown
---
decision: prove-audit-audience-split
---

# Both corpus-checking verbs report in-context; certification reaches the intake only through gated writers

## Choice

The two corpus-checking verbs are in-context reporters distinguished by audience: the proof run reports to the executing agent at machine tempo, and the audit reports to its caller — the human who invoked it, or the certification gate consuming it as a producer — with every finding classified mechanical or judgment. Neither verb writes the issue intake. The audit writes nothing at all; the proof run's one durable trace is the machine-local record of what each executed proof cost — a measurement, not a finding, and no more a claim on the owner's attention than the in-context report is. A certification finding reaches the intake through exactly two gated paths and no others: certification's architect, filing only findings that survived the fixer's veto test and its own adversarial check; and the cycle cap's escalation, which files the remainders a bounded fix loop tried and failed to drive to clean — reachable only once the cap is hit, taken only on the owner's word, the run stopping at the cap and waiting for their direction however long that takes, and made ruling-ready before it becomes owner agenda. Those gates govern the repeating cycle's findings, not the intake's whole membership — humans file directly whenever they choose, the ceremonies that transcribe the owner's own questions file directly, and so does the one-time corpus bootstrap, whose review loops surface findings in the defined sense and file them ungated by design: the queue is what the owner invoked that run to get, and a run that aborts rather than repeat over a populated corpus cannot accumulate against the owner. The owner's durable agenda is a property of those two gates, never of either reporting verb: the architect's path is bounded by adversarial confirmation before anything costs owner attention, and the cap's by exhaustion and the owner's word — nothing is filed there until a bounded loop has tried and failed to fix it and the owner directs the wrap-up. Deduplication against the slugs already present is the standing discipline of every writer into the intake, the gates included.

## Rationale

The split keeps execution unblocked and the owner uninterrupted: an executing agent needs findings now, in context, at machine tempo, while the owner's queue must stay an owner-calibrated worklist. Routing certification's findings through gated paths only is what keeps the intake meaning "requires owner calibration": certification runs at every close, so a reporting verb that also filed would be an ungated writer inside that repeating cycle, growing the queue run after run without anything checking that a reasonable owner would want to read it. The two gated paths bound that growth in different ways and both bound it — the architect's by adversarial confirmation, the cap's by exhaustion and the owner's word: a remainder is filed only after a bounded loop has failed to fix it and the owner chooses the wrap-up over another cycle, which makes it rare by construction and makes the filing the alternative to losing the finding altogether when the owner closes a capped run. The corpus bootstrap files ungated without defeating that, because it sits outside the repeating cycle — one owner-invoked adoption run that refuses to run again over a populated corpus, and the queue of judgment questions it hands back is the outcome the owner invoked it for rather than a cost imposed on them. A standalone audit's judgment findings still reach the owner: the human who ran it is holding the report, and reading it is the calibration act — what they judge fork-worthy, they file.

## Alternatives

- One verb doing both — every execution-time finding becomes intake noise, and owner questions get buried in agent triage.
- Both verbs writing the intake — the intake stops meaning "requires owner calibration" by construction.
- The audit filing its own judgment class — preserves a durable agenda from standalone runs, but reintroduces ungated agent writes and duplicates the promotion gate's dedup and confirmation outside it.
- Routing cap remainders through the architect too, keeping one writer — buys an adversarial check the remainders cannot pass by construction, since a remainder is a finding the fixer failed to fix rather than one it kicked back as a fork, and the check's own rule is that inability is never grounds.
- Escalating by default on an unattended capped run — keeps the run moving without the owner, at the cost of making the cap's choice for them: the sprint wraps up in their absence and resuming the remainders costs a fresh planning ceremony, when waiting — however long — lets them finish the sprint in flight.
```

## Work items

- **Reserve the cap's choice to the owner across the certification
  machinery.** Makes true: `story:certify-completion`,
  `decision:prove-audit-audience-split`, `concept:completion-contract`.
  The unattended-escalation default is removed everywhere it lives:
  the certification core's review-fix-loop exit rule and intake-paths
  paragraph, both certify gates' cap touchpoint and close-out text,
  and the sprint boilerplate's goal rule in the planning ceremony's
  template — which gains the parked-at-the-cap state as a legal
  in-flight stopping point a goal checker must respect (this sprint's
  own contract section updated to match). A run that hits the cap
  stops and waits for the owner's word, a minute or a day, attended
  or not; it never takes either step itself. Proof conjuncts that pin
  the old default's wording are repointed at the new governing
  sentences. End state: no shipped text or prompt instructs a run to
  escalate (or take any cap step) without the owner's word.

- **Resolve the standing violated determination on
  `story:explain-lint-rules`.** Makes true: `story:explain-lint-rules`,
  `decision:adversarial-implementation-audits`. The story stands as
  written — no rewrite. Its implementation audit is re-derived under
  the decidability boundary: the qualitative clauses (canonical
  definitions, the explanation matching the lint in substance) are
  recorded as referrals to the documentation discipline, and the
  determination re-resolves against the decidable claims alone. The
  one standing decidable finding — the worked-examples harness
  invents each example's starting state rather than reading it from
  the example's own text — stands or falls on its merits at that
  re-audit: if it holds, the harness is corrected so each documented
  example is exercised from the starting state its text states; if
  it is refuted, the refutation is recorded with citations. End
  state: a current determination that is not an unlinked violation.

All other change this sprint ratifies is already implemented and
released in the suite's current version; the corpus deltas above are
applied on their own per the execution boilerplate, and the closing
certification verifies the ratified claims against the code as it
stands.

## How to execute this sprint

This sprint is self-sufficient. Whoever executes it — an inline
working session, an agent this file is handed to via the native
`goal` mechanism, or an orchestrator that does its own planning —
proceeds the same way.

1. Read the sprint whole first — intent, deltas, work items,
   completion contract — before touching anything. Do not go looking
   for context behind it (not in the issue intake under
   `.ok-planner/issues/`, not in `history/`). The sprint is
   self-sufficient by construction; a genuine gap is raised with the
   owner, never filled by inference.

2. Stage the work into a task list. The items above are a flat,
   unordered list; group them by theme, file surface, or dependency,
   order the groups so nothing is built on something not yet there,
   and build the list in your own working state — the harness's task
   tracking where available, one entry per stage; an orchestrator
   uses its own graph. Seed the closing entries up front — finish
   the completion report, run `/certify-work`, walk the
   presentation, offer archive-and-commit — so the ceremony is a
   standing unchecked item from the first minute, not a memory to
   retain past a long run. Staging is never rewritten into a plan
   document: this sprint is the whole brief.

3. Apply each corpus delta as part of the work that realizes it —
   copy the final-form body into `.ok-planner/design/` verbatim, or
   delete the file for a retirement. A delta no work item implements
   (a clarification, a retirement) is applied on its own.

4. Build stage by stage. Every new or amended story gets its proof: a
   deterministic integration test (or demo) present, carrying its
   `@story:` annotation, and able to actually fail under the story's
   falsifier. Write the proof with the work, not at the end. Decisions
   carry no proofs — a decision's verification is the implementation
   audit certification writes.

5. Completeness is the floor. Never stub, defer, narrow, no-op, or
   leave a `TODO` in place of a promised outcome. A capability the
   deltas or work items promise is delivered in full, or the blocker
   that prevents it is surfaced — never silently dropped.

6. Never destroy uncommitted work. Stage progress as each stage
   finishes (`git add -A`) so a stray revert cannot reach it. Do not
   run `git checkout`/`restore`/`reset`/`stash`/`clean` on your own
   initiative; fix a bad edit forward by editing again.

7. Work unsupervised to a defensible done — no pausing for approval,
   confirmation, or progress checks. Stop only on a genuine blocker:
   a credential or access that cannot be obtained, a step literally
   impossible in the current state, a destructive/irreversible
   action not clearly authorized — or the closing `/certify-work`
   step being unrunnable for you (e.g. its subagent dispatches are
   unavailable): surface that and stop; never skip the ceremony and
   call the work done. Ambiguity is not a blocker — pick
   the most plausible reading and continue, surfacing the choice at
   the end. (An orchestrator that supervises its own executors folds
   this into its own control.)

8. Keep the completion report current. Beside this sprint file lives
   its report — same filename with `-completion` before the
   extension — and you write it as you go: as each stage lands,
   record what was done, every divergence, and every call you made
   where the sprint was silent. It is the durable record the closing
   ceremony finishes and walks with the owner, the artifact a goal
   checker requires, and it is archived together with this sprint.
   It is a record of this execution, never a plan document.

9. Close by running `/certify-work`. It brings the work into
   alignment with this sprint and discharges the completion contract
   below at the change's own scope: `/prove` over the touched
   stories and decisions, change-scoped corpus checks over the
   touched artifacts and annotations, code review over the diff —
   all producers feeding a no-discretion review-fix loop (a fixer
   fixes everything a reasonable owner would wave through; an
   architect adversarially checks its kickbacks, fixing the refuted
   and promoting only genuine intent forks to the issue intake),
   and the outcomes and divergences are presented to the owner.
   (Whole-corpus certification is `/certify-all`, run on the owner's
   cadence, not per close.) The goal is to finish the work: this
   file stays in `sprints/` through the presentation (so a stop
   condition keyed to its path can verify completion against it),
   and `/certify-work` ends the run as the ceremony: it writes its
   composed presentation into the completion report (finishing the
   record kept in step 8), walks it with the owner, and offers the
   close-out — archiving this sprint together with its completion
   report and the issue files it resolved to `history/`, and
   committing the work — performed only on the owner's word. The
   close-out then stamps the archived sprint's frontmatter with
   the closing commit (`closed: <sha>`, one small follow-on
   commit): the baseline the next planning ceremony uses to
   detect work done out of band.

## Completion contract

The work is not done until all of the following hold, each
verifiable from the repository as it stands:

1. The design corpus matches every delta above (applied verbatim).
2. `/prove` returns clean over all new and touched stories: every
   registered proof present, passing, and runnable.
3. The implementation-audit corpus is current for everything the
   change touched or made stale, with any standing violation linked
   to an intake issue — mechanically: `.ok-planner/bin/audit-check
   --inspection` exits 0 (citations current, and every changed
   source-graph node dispositioned by the change inspection).
4. The completion report beside this sprint (same filename with
   `-completion`) is finished: it records the work done and the
   divergences, and carries `/certify-work`'s presentation — the
   review-fix loop run last and come back clean, every finding
   fixed or promoted-and-verified.

**The goal rule, for any checker verifying this contract.** The goal
is met in exactly two ways: this sprint file has moved to
`.ok-planner/history/sprints/` bearing a `closed:` stamp — the owner
accepted and closed the work; terminal, stop checking — or this file
is still at its `sprints/` path and items 1–4 all verify against the
repository. A missing completion report means NOT done, however
green the rest looks; an archived, stamped sprint means DONE,
whatever else seems unfinished. A run parked at the review-fix
loop's cycle cap awaiting the owner's direction is a legal in-flight
state — not done, not failed, and never grounds for the run to take
either cap step itself. Nothing else counts either way.
