---
audit: recorded-adjudication
artifact: decision:recorded-adjudication
determination: satisfied
audited: 2026-07-28T00:00:00Z
artifact-hash: sha256:a1e553ac8e80
---

# Whether certification's judgments are written into the record the next run reads, bind later runs, and close over every hunk of the change

The design artifact's hash is unchanged since the prior audit, so that audit's
reasoning binds absent moved reality, and it carried no `## Notes` ledger, so
no adjudication is open. What moved is not this decision's mechanism but where
one citation pointed: this repo's vendored planner layer was restored to its
pinned HEAD state, which is a release-era copy that predates the change
inspector and the adjudication-binding instruction. That copy legitimately lags
the family source until the owner's next release → update → `/ok` converge —
`decision:per-project-pinning` is the whole point of the lag, not a defect —
so an audit of *this suite's* claim has no business resting on it. The single
citation that did is re-homed below to the family source that ships the same
commitment to consumers. Every other citation verifies unchanged; every claim
was re-run against the tree.

## Claims

**Title — "Certification judgments are recorded transactions, not per-run
derivations."** Honored in the sense the body defines and no wider: the
judgments the gate carries forward between runs — nominations,
adjudications, and determinations — live in the audit files, and the
gate's closure over a change is a per-run ledger. The scope is taken
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
computation, written as the audit files themselves; and (d) the
architect's confirmed forks, consumed by the next `/plan-sprint`, written
as issue files in the intake. Each has a citable write site. The judgments
a run produces and discharges inside itself — a fixer's veto-test call, an
architect's refutation — become code and are reported in the
presentation's Divergences for the owner's after-the-fact veto; nothing in
the Choice claims those are carried into the next run, and the Rationale
scopes the property to adjudications explicitly.

**"An inspector's nomination lands as a provisional note on the audit it
implicates."** Honored, mechanically specified rather than gestured at:
inspector method step 4 fixes the exact line pair
(`- note: <file/hunk> — <why this audit is implicated>` /
`  adjudication: open (awaiting the next audit pass)`), requires the
`## Notes` section to be created when absent, forbids duplicating an
identical note, and forbids touching anything else in the file. The
canonical audit file format carries the matching `## Notes` section with
the same three adjudication values, so writer and reader agree on one
shape defined in one place.

**"the auditor adjudicates each note — promoted into a citation, or
dismissed with a stated reason — and the notes and their adjudications
are part of the audit record."** Honored. The auditor's method step 0
makes every open note "yours to adjudicate now", names both outcomes with
their obligations (a promotion must add the citation covering the
nominated territory; a dismissal must state the reason), and forbids
leaving a note open in an audit it writes. Its report line carries
`notes: N promoted, M dismissed` back to the gate. Permanence is stated
from both ends: the auditor is told never to drop or rewrite existing
notes and adjudications but to carry them forward verbatim, and the
inspector is told to touch no existing note.

**"A recorded adjudication binds later runs: departing from one requires
naming the cited reality that changed."** Honored, with the two mechanical
escapes stated in the same breath rather than left implicit: an
adjudication whose own cited reality moved is open again, and a design
artifact whose hash moved lapses its audit's precedent wholesale — the
artifact is re-audited fresh and prior notes stand as history. The same
binding rule is stated canonically in the audit file format, so it governs
any reader of an audit, not only the dispatched auditor; the auditor
prompt states it in the imperative, inside the method step that makes
reading the prior audit the first act ("adjudications BIND you: depart from
a recorded promotion or dismissal only by naming the cited reality that
changed").

The consumer-side statement of the same rule was re-checked this pass at the
right altitude. It reaches a consumer project through the two documents the
family's converge materializes into every estate — the estate guide and the
project cheatsheet, both rendered from templates under the family's
`scripts/` — and both carry the rule in prose the owner reads: the auditor
adjudicates each note, promoted into a citation or dismissed with a reason,
and recorded adjudications bind later runs unless the cited reality moves.
Those templates are the shipped surface and are cited below. The prior pass
cited this repo's *vendored* copy of the auditor prompt instead; that copy has
since been restored to its pinned HEAD state and no longer carries the
sentence, because per-project pinning holds the vendored layer at the last
committed converge while the family source moves ahead. The claim is
unaffected — what the decision commits to is what the suite ships, and this
repo's own lag is the pinning decision working — but the citation had to move
to survive it.

Two independent corroborations that this is the regime rather than a slogan:
`audit-check` is what makes "cited reality moved" checkable rather than
assertable, and `checks/oscillation` reads git history for the exact violation
this sentence forbids — a determination that flipped between two committed
versions while the artifact hash and every citation stood still. That detector
is report-only and never blocks, which its own header states; the Choice claims
binding by record, not by a blocking check, so this is corroboration and not
the enforcement point. Re-run this cycle: `checks/oscillation` reports and
exits 0 within `checks/run`, which passes all seven.

**"The gate closes only when every hunk of the change carries a
disposition — mechanically accounted, adjudicated, or residue."** Honored
at four citable points, and the population of gates was enumerated from
the converge core's vendored `SKILLS` map rather than assumed: both
`certify-work` and `certify-all` carry it in their implementation-audit
producer's clean bar ("no ledger hunk is without a disposition"), the
shared core states it once for both ("The gate does not present as clean
while any hunk lacks a disposition"), and the presentation block repeats
it as a status rule ("A hunk without a disposition blocks a clean status;
if any remain, the run is NOT certified and they are listed here"). The
three disposition values are defined once, in the inspector, with the test
for each, and the inspector is told no hunk may be left without one. The
estate guide and cheatsheet templates carry the same rule to the consumer,
naming the three values by name.

**"and residue (change no claim accounts for) is reported to the owner as
intake material, never silently dropped."** Honored. The inspector's
report step requires the residue enumerated with file, region, and one
line on what it is, explicitly as intake material for the owner and
explicitly not the inspector's judgment call; its rules bar it from
filing, classifying beyond "no claim accounts for it", or proposing fixes.
The presentation's Reconciliation ledger section is the owner-facing end:
counts per disposition, the adjudication outcomes, and the residue
enumerated one line each, "reported here and never silently dropped". Both
gates name that section in their own presentation instructions.

**"The inspector re-runs each fix cycle over the then-current diff, so the
ledger the presentation reports describes the change as it finally
stands."** A supporting sentence in the core, and it holds: the core's
re-review step and both gates' loop descriptions re-run the inspector over
the then-current diff, so the ledger is not a first-pass artifact.

**Rationale — "Oscillation lives in re-derivation: two readings of
unchanged reality can disagree, and when nothing records the first
reading, the second is free to flip it. Recording adjudications makes
convergence a property of the record rather than of agent temperament — a
flip must point at changed reality."** This is a capability claim and it
is delivered by the binding rule above, not merely asserted: the auditor
is required to read the prior audit first as "the record you transact
against, not scratch paper", and the only sanctioned departure is naming
the cited reality that changed. This pass is itself an instance: the
determination did not move, and the one thing that did — a citation — is
accompanied by the named reality that moved it.

**Rationale — "the closure requirement turns 'was everything considered?'
from a hope into a checkable invariant, at a bookkeeping cost proportional
to the change."** Honored: the invariant is checkable because the
inspector enumerates the change as hunks from the diff and must
disposition each, and the cost scales with the hunk count, which is the
change's size.

**Alternatives.** All three are genuine roads not taken and none is in
force: judgment is not fresh at every run (the binding rule); precedent is
not prompt discipline only (the notes and adjudications are written into
the audit file and machine-checked for staleness); and disposition
tracking carries reasons (a dismissal must state one, and the auditor is
told to carry it forward verbatim).

## Determination

**satisfied.** Every clause has a specific write site or enforcement
sentence, and the pieces fit into one loop rather than sitting beside each
other: the inspector writes notes in a format the canonical audit template
defines, the auditor is the sole adjudicator and may not leave one open,
the adjudication binds the next auditor with two named mechanical
escapes, the determinations and notes live in files a deterministic
checker already computes staleness over, and both gates refuse a clean
status while any hunk lacks a disposition or any note stays open. Residue
has a defined shape, a defined reporter, a bar on the reporter deciding
anything about it, and a named section of the owner's presentation.

The determination does not move on the changed reality, and the reason is
worth stating because it will recur: this decision is a claim about what the
suite ships, so its evidence is the family source under
`plugins/ok/families/ok-planner/` plus the templates that source materializes
into a consumer estate — never this repo's own vendored copies, which
`decision:per-project-pinning` deliberately holds at the last committed
converge. A vendored copy that lags the family source falsifies nothing here;
it is the pinning decision behaving.

The one boundary worth stating for a later reader, and not charged
because no sentence claims otherwise: the fixer's calls and the
architect's refutations are surfaced in the presentation for veto but are
not written into a record the next run reads. The Choice's "every
judgment the gate consumes" reaches the judgments carried between runs —
nominations, adjudications, determinations, promoted forks — each of
which has a durable home; a run's own discharged calls are not among
them. If that sentence were ever read as requiring a durable ledger of
fixer calls too, this would flip.

This stops holding if: the inspector's note-writing step is removed or
loosened so nominations are reported only in-context; the `## Notes`
section leaves the canonical audit file format, so writer and reader stop
agreeing on one shape; the auditor is allowed to leave a note open, to
drop or rewrite existing notes, or to depart from a recorded adjudication
without naming changed reality (the pinned method-step spans and the
`BIND` line break first); either gate drops "no ledger hunk is
without a disposition" or "no note is left open" from its clean bar, or
the core drops the same rule; the presentation loses its Reconciliation
ledger section or stops enumerating residue; the estate guide or cheatsheet
template stops carrying the binding rule to the consumer, so the shipped
surface and the prompts disagree; or `checks/oscillation` is
deleted, which would not by itself falsify the Choice but removes the only
instrument that can observe the property failing in history.

## Citations

- cite-span: plugins/ok/families/ok-planner/skills/_shared/artifact-definitions.md :: "The recorded-adjudication ledger for this audit" +18 sha256:5a5279d030c3
- cite-span: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "**The reconciliation ledger.** The inspector also dispositions every hunk" +1 sha256:14044e76fddb
- cite-span: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "  3. Disposition the hunk:" +15 sha256:9b3cbeeaa602
- cite-span: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "  4. Record each nomination as a provisional note on the audit it" +8 sha256:4285e41b1b38
- cite-span: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "## Reconciliation ledger" +8 sha256:b33ce3b03c6f
- cite-span: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "4. **Re-review.** Re-run each producer whose findings were worked" +1 sha256:925bc9bd6fde
- cite: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "Promotion is the loop's only path to the intake"
- cite-span: plugins/ok/families/ok-planner/skills/_shared/implementation-auditor.md :: "  0. Read the prior audit file first, if one exists — it is the" +17 sha256:0dc64431681a
- cite-span: plugins/ok/families/ok-planner/skills/_shared/implementation-auditor.md :: "     citations, the determination the claims add up to, the Notes" +15 sha256:ddc8e885f36e
- cite-span: plugins/ok/families/ok-planner/skills/certify-work/SKILL.md :: "   - **Implementation audit, two layers.**" +1 sha256:62a96e92cc0f
- cite-span: plugins/ok/families/ok-planner/skills/certify-all/SKILL.md :: "   - **Implementation audit, whole-corpus.**" +1 sha256:ca40b8632807
- cite-span: checks/oscillation :: "def audit_flips():" +28 sha256:73bc4b08d1f8
- cite: checks/oscillation :: "# Report-only by design: findings print, the exit code stays 0, and"
- cite-span: plugins/ok/families/ok-planner/admin/converge :: "SKILLS = {" +12 sha256:e48536a36db6
- cite: plugins/ok/families/ok-planner/scripts/ok-planner-CLAUDE.md :: "dismissed with a reason — and recorded adjudications bind later runs"
- cite: plugins/ok/families/ok-planner/scripts/ok-planner-cheatsheet.md :: "a citation or dismissed with a reason — recorded adjudications"
- cite-file: plugins/ok/families/ok-planner/skills/_shared/certification-core.md @ sha256:f96e5bcb96d6
- cite-file: plugins/ok/families/ok-planner/skills/_shared/implementation-auditor.md @ sha256:43d1b1213bb1
- cite-file: plugins/ok/families/ok-planner/skills/certify-work/SKILL.md @ sha256:30f3667b968b
- cite-file: plugins/ok/families/ok-planner/skills/certify-all/SKILL.md @ sha256:d22e4b74e9a3
