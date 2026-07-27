---
decision: adversarial-implementation-audits
---

# Implementation claims are verified by adversarial audits, not test mandates

## Choice

Whether the project implements what a story or decision claims is determined by an adversarial implementation audit: a durable, per-artifact determination (`satisfied` or `violated`) recorded in a fourth corpus collection, written only by a certification producer that did not implement the work under audit, and never hand-edited. Audits cite code by content anchors and pin quantified claims' population sources by file hash; a deterministic checker flags any audit whose design artifact, cited code, or population source has changed, and the stale set — not human memory — is what gets re-audited. The checker masks release-mutable metadata — the suite-version stamp lines materialization writes and the plugin manifests' version fields — before hashing anything a citation or pin covers, so a release that changes only versions voids no audit. Stories additionally carry deterministic integration-test proofs; decisions carry no test obligation. A negative determination stands in place until a re-audit flips it, and blocks certification unless linked to an intake issue awaiting the owner's ruling.

## Rationale

The claims that go wrong in practice are disproportionately structural, negative, or quantified — a transport a decision's text never reached, a rationale selling a property nothing delivers, an "every" enforced on the members someone remembered — and for those the honest verification is an adversarial reading against reality, with the population enumerated from the compose file or route table rather than from the artifact's own examples. Mandating a test per claim buys determinism at the cost of test-side machinery per claim and still misses the claims that are not runtime-observable; an audit covers every normative sentence at the cost of trusting a reader, and that trust is bounded three ways: the reader is never the author of the work, the determination is a citation-carrying record that can be re-derived and compared, and staleness is mechanical — the fixer cannot satisfy an audit by any means except changing the code it cites, which breaks its anchors and forces a fresh adversarial read. Content anchors rather than line numbers make the tripwire survive unrelated edits; whole-file pins on population sources make a new member re-open the exact audits whose quantifiers it threatens. Version stamps sit inside otherwise-cited bytes and must change on every release, so masking them is what keeps the tripwire meaningful: staleness signals substantive change, never the release act, while any edit beyond the masked patterns still breaks its anchor.

## Alternatives

- Test mandates with registered falsifier exhibits per claim — deterministic and unfoolable where it applies, but a per-claim authoring and maintenance layer, and structurally blind to claims that live in rationale text, titles, and concept invariants.
- Read-and-judge review without durable records — catches the same class once, but leaves nothing to go stale, so nothing triggers the re-read when the code moves.
- Diff-scoped review as the only reader — reviews the change, so a claim whose code was never written produces nothing to review; absence has no diff.
- Hashing stamped bytes as-is and re-auditing at release time — every release voids whichever audits cite stamped files and buys an agentic re-read that can only confirm version strings changed.
