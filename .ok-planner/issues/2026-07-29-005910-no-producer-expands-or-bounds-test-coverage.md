---
issue: no-producer-expands-or-bounds-test-coverage
kind: human
category: unspecified
artifacts:
  - story:certify-completion
  - story:corpus-proof
  - decision:measure-first-verification-cost
status: open
opened: 2026-07-29T00:59:10Z
---

# Should certification carry a capability-coverage enumerator, and what bounds test coverage?

## Problem

The certification gate's cycles are implement→review and fix→review:
every producer judges the work against its stated claims as currently
tested, and no producer's job is to expand test coverage. Coverage
gaps are detected only incidentally — the code reviewer has a coverage
bullet, and the implementation auditor judges whether a green proof
spans a story's Acceptance — so each gap is discovered reactively, one
per adversarial pass, at full audit cost, and the discovery lands in
audit prose rather than accumulating anywhere executable. Coverage is
also unbounded in principle, and nothing states a stopping rule.

Observed this sprint: every proof gap the auditors found was an
unenumerated capability member — one CI platform of three never
exercised, one explain topic of four without a worked example, one
resolution-rule kind of two untested, the one config location the lint
actually reads never built against, the lint's emittable messages never
compared. The durable fixes were all the same move: derive the
population from the source (platforms from the emitting table,
file-type tags from the grammar table, check codes from the emission
sites, config candidates from the resolver) and cover every member.
The owner's stated direction: falsifier-driven coverage ("find a way
this fails") was tried previously and is not tractable; capability
testing is — enumerate what a surface does and require a proof conjunct
per member, making completeness a diff between two lists.

## Candidates

- Add a certification producer — a capability-coverage enumerator —
  that, at change scope, reads the touched surfaces' capability
  populations from the source (the same enumerate-from-reality
  discipline the implementation auditor already applies to
  quantifiers), diffs them against the members the touched stories'
  proofs exercise, and reports uncovered members as ordinary findings
  for the fix loop. Bound it by the story's Acceptance (the sufficiency
  target) and by the measure-first verification-cost discipline (growth
  of the proof suite follows profile → justify → re-measure).
- Fold the enumeration duty into the implementation auditor's charter
  explicitly (it already pins population sources), accepting that
  coverage expansion stays coupled to audit passes.
- Leave coverage expansion out of the gate entirely; treat it as
  planning-time work the owner commissions deliberately.

## Ruling

Resolved inline, ahead of the sprint (owner decision, 2026-07-29),
by a first-principles restatement of the certification roster rather
than a new producer. The roles: the **auditor** defends the corpus,
and "audit" means implemented AND covered — for each decidable
quantified claim, completeness is the diff of two lists (members
enumerated from the source minus members the proofs exercise), with
uncovered members as claim-line findings and the bound being the
story's decidable claims plus the measure-first cost discipline. The
**reviewer** defends the code (quality, bugs, conventions; untested
behavior is an ordinary finding) and does not carry sprint
completeness. The **prover** is mechanical. **Sprint alignment**
stands as its own dispatched judge — the sprint is changing the
corpus — and absorbs consistency of the changed corpus and
undershoot detection; the **change inspector** is the audit layer's
scoping optimization. Compliance retires from the change-scoped gate
(paid at /plan-sprint sign-off; whole-corpus at /certify-all); the
annotation and proof-existence checks remain the inline mechanical
floor. No capability-enumerator producer exists — enumeration was
the auditor's charter all along. Additionally: audits now CITE the
proof frontier (proofs are code; a coverage judgment uncited by its
proofs cannot be re-triggered when a proof changes). Implemented
across both gates, the shared prompts (new sprint-alignment prompt;
code-review and auditor charters retoned), and the canonical audit
definition. Stays open for the next sprint to ratify; ships with the
next release/re-vendor.
