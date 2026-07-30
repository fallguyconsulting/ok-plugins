---
decision: adversarial-implementation-audits
---

# Implementation claims are verified by adversarial audits, not test mandates

## Choice

Whether the project supports what a story or decision claims is
determined by an adversarial implementation audit: a per-artifact
determination — `supported`, `unsupported`, or `unclear` — recorded in
a fourth corpus collection, written only by the periodic audit run and
never by the session that implemented the work, and never hand-edited.
An audit is a statement about a **named commit** rather than a standing
verdict: its frontmatter carries the commit it describes, so whether it
still holds is a question about how far the tree has since moved, and
nothing computes that. The audit body is one sentence to one paragraph
saying what was looked at and what was found, broad rather than
exhaustive, carrying no citations, hashes, line numbers, or pasted
code. Where the artifact quantifies over a population, the audit
reports the count it checked and the population it enumerated from —
the one precision a reader can refute in seconds. Where a claim is
implemented in code, the audit asks whether a test in the project's
ordinary suites exercises it end-to-end and says so; whether that test
passes is the change gate's business. Qualitative clauses ground no
determination: each becomes a referral naming the promise, what was
established in form, and the discipline that owns the judgment. The
run has two stages and no loop — auditors read every live artifact in
parallel batches, and everything they could not call `supported` goes
to one second-opinion judge that confirms it, overturns it, or calls it
undecidable, filing an intake issue in the first and third cases. The
judge is terminal, and neither stage fixes anything. A determination of
`unsupported` or `unclear` must name its issue; a deterministic checker
enforces that, the audit file's shape, and its one-paragraph bound, and
nothing else.

## Rationale

The claims that go wrong in practice are disproportionately
structural, negative, or quantified — a transport a decision's text
never reached, a rationale selling a property nothing delivers, an
"every" enforced on the members someone remembered — and for those the
honest verification is an adversarial reading against reality, with the
population enumerated from the filesystem or the route table rather
than from the artifact's own examples. Mandating a test per claim buys
determinism at the cost of test-side machinery per claim and still
misses the claims that are not runtime-observable; an audit covers
every decidable claim at the cost of trusting a reader, and that trust
is bounded three ways: the reader is never the author of the work, an
independent judge re-reads everything the reader could not affirm, and
the determination names a count and a population a later reader can
refute cheaply.

Pinning an audit to a commit rather than to the code it describes is
what keeps the cost proportionate. A citation-and-hash tripwire buys
precise invalidation and charges for it twice: a monolithic file cited
by many audits re-opens all of them for an edit that concerns one, and
each re-opening costs an agent a read. Naming the commit instead makes
freshness a question anyone can answer with git, and makes upkeep a
single periodic sweep priced by the corpus rather than by how often
unrelated code moves. A broad paragraph is the same trade: the audit's
job is to tell a reader whether the claim holds and what was looked at,
not to reproduce the evidence, and precision nobody will refute is not
precision. Determinations stop at the decidability line because an
adversarial re-audit against quality prose never converges — there is
always one more sense in which an explanation might fall short — so
qualitative clauses become referrals marking where this process's
jurisdiction ends. The run refuses a fix loop for the same reason it
refuses staleness: a loop whose own fixes invalidate its measurements
cannot converge, so the judge's third outcome is filing an issue and
the run ends there.

## Alternatives

- Test mandates with a registered failure exhibit per claim —
  deterministic and unfoolable where it applies, but a per-claim
  authoring and maintenance layer, and structurally blind to claims
  that live in rationale text, titles, and concept invariants.
- Read-and-judge review without durable records — catches the same
  class once, but leaves nothing behind for the next reader to compare
  against or refute.
- Citations pinned by content hash, with a mechanical stale set and a
  judged inspection layer above it — precise about what a change puts
  in question, at the cost of re-opening every audit that happens to
  name a file an unrelated edit touched, each re-opening priced as an
  agent's read.
- Auditing at every change close rather than on a cadence — catches
  drift sooner, but pays the whole corpus's read price per sprint and
  re-runs against a target its own fix loop keeps moving.
- A fix loop inside the audit run — closes gaps in the same pass, but
  every fix invalidates the reads already taken, so the run either
  re-audits repeatedly or reports measurements its own edits voided.
- An auditor licensed to run tests and experiments — settles some
  claims first-hand, at the cost of corrupting the state under
  judgment and leaving the evidence unrecorded.
- Forbidding qualitative language in artifacts so every clause is
  mechanically auditable — a corpus made clean by silencing intent;
  the decidability boundary handles it instead by referring such
  clauses out.
