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
