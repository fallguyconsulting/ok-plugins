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
The audit's one job is to identify where and how in the project the
artifact is implemented, and its charter is implemented AND covered,
bounded by the artifact's decidable claims: for every claim
implemented in code, the audit verifies there is a test or tests in
the project's ordinary suites exercising that feature end-to-end and
cites them — a code-implemented claim with no such test is an
ordinary finding, and whether the cited tests pass is the test
run's business, not the audit's; for every claim realized in prose, the audit
simply cites the relevant prose, narrowly. For each quantified
claim, completeness is the difference of two enumerable lists — the
members enumerated from the population source minus the members the
cited tests exercise — with uncovered members reported as ordinary
findings. Qualitative
clauses ground no determination and no finding: each is recorded as
a referral — the promised thing verified to exist in form,
suitability explicitly not opined, the owning discipline named.
Audits cite the source graph by node identity and content hash —
span anchors within a node where finer resolution carries the
verdict — and pin quantified claims' population sources whole;
citations cover both frontiers, the code that delivers a claim and
the test code that exercises it, so a test edit re-stales the
coverage judgment that rested on it. A deterministic checker flags
any audit whose design artifact or cited nodes have changed, and the
re-audit set is that stale set plus the change-inspection
nominations the auditor adjudicates (see also: two-layer-invalidation
under decisions). The checker masks release-mutable metadata — the
suite-version stamp lines materialization writes and the plugin
manifests' version fields — before hashing anything a citation or
pin covers, so a release that changes only versions voids no audit.
The auditor reads and judges, never executes: the gate runs the
project's test suites, and a claim that could only be settled by
running something is a claim no cited test settles — an ordinary
finding, with the fixer writing the missing test. Neither stories nor decisions carry proof artifacts of their own:
the tests an audit cites are the project's ordinary suites, and a
decision's structural claims may need no test at all — just the
citation. The audit file itself is a plain pass/fail with a terse paragraph
or a few bullets of reasons, followed by its citations — written
for an experienced engineer with little knowledge of the project
and not a lot of time — and carries nothing backward-looking and
nothing hypothetical: no history of the audit, no prior
determinations, no account of rewrites or citation changes, no
anticipated objections or speculation about invalidation; it
describes only the project as it stands at audit time, with
nominations and adjudications living in the inspection registry,
and its citations carrying the staleness intent — reconsider the
audit when what they pin changes. A negative determination stands in place until a
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
open-ended failure hunting ("find a way this fails") does not
terminate, while a population diffed against the members the cited tests
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
stays with the gate — which runs the project's own test suites — and
"this must be run" resolves to a missing test written through the
loop, never to the auditor running it. Determinations stop at the
decidability line because an
adversarial re-audit against quality prose never converges — there
is always one more sense in which an explanation might fall short —
so qualitative clauses become referrals marking where this process's
jurisdiction ends, and artifacts stay free to state qualitative
intent. Structural node identities and content hashes rather than
line numbers make the tripwire survive unrelated edits; whole-source
pins on population sources make a new member re-open the exact
audits whose quantifiers it threatens; test files are cited like
any evidence, so a coverage judgment re-opens when the test it
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

- Test mandates with a registered failure exhibit per claim —
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
