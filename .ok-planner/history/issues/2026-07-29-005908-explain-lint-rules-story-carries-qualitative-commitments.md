---
issue: explain-lint-rules-story-carries-qualitative-commitments
kind: human
category: overloaded
artifacts:
  - story:explain-lint-rules
status: promoted
sprint: 2026-07-28-ratify-inline-certification-repairs.md
opened: 2026-07-29T00:59:08Z
---

# Rewrite story:explain-lint-rules to its mechanical core and resolve its standing violated determination against the rewritten story

## Problem

`story:explain-lint-rules` commits, in its Acceptance, to the truth of
documentation content: "they receive that rule's canonical definition
and worked examples, drawn from the project's own committed lint so the
explanation matches the rules that project actually enforces." Its
Falsifier names drift of a hand-maintained copy as story failure. Those
are quality commitments over free prose, and the certification gate
spent six fix/re-audit rounds failing to discharge them: the harness
guarding the examples was strengthened five times, and each adversarial
re-audit exhibited a narrower way documentation and lint could still
silently diverge. The implementation audit at
`.ok-planner/audits/stories/explain-lint-rules.md` stands
`determination: violated` on that basis — the final finding is that the
harness invents each example's starting state rather than reading it
from the example's text — while every mechanical clause of the story
(the verb answers per code, the bare invocation lists topics, the
listing covers every emittable check code, the text is delivered from
the committed lint binary) has been verified green since the first
cycle. The explanation prose itself was audited correct by execution in
four consecutive passes and has not changed.

The owner's stated direction: the story is likely fine in the shape "I
want to see an explanation so I can understand why" — showing an
explanation is mechanical; the corpus cannot underwrite the correctness
pieces, which are an editorial quality concern.

## Candidates

- Rewrite the story's Acceptance to the mechanical core (asking about a
  check code or configuration topic yields that topic's explanation;
  asking bare lists the topics; the listing covers every check code the
  lint can emit; the delivered text comes from the project's committed
  lint), move the understanding/correctness aspiration entirely into
  the benefit clause, and align the Falsifier to the mechanical
  clauses. The standing violated determination then resolves by
  re-audit against the rewritten story; the existing harness — which
  already executes the worked examples and compares documented
  transcripts against emitted output — stays as regression protection
  but stops being the story's proof obligation beyond the mechanical
  clauses.
- Keep the story as written and continue hardening the harness toward
  full extraction of every documented claim — accepting that the audit
  may never terminate, since prose-truth has no decision procedure.
- Retire the story and leave the explain verb covered by no corpus
  artifact, as it was before this sprint.

## Ruling

The story stands as written (owner decision, 2026-07-29). Under the
decidability boundary added inline to the plugin source (see the
ruling on `acceptance-clauses-must-be-deterministically-decidable`),
no rewrite to a mechanical core is needed: on re-audit under the new
rules, the story's qualitative claims (canonical definitions, the
explanation matching what the lint enforces in substance) become
referrals in the audit — form-verified, suitability referred to
documentation — and the determination re-resolves against the
decidable claims only. The standing `violated` determination is not
waved off: its final finding (the harness invents each example's
starting state rather than reading it from the example's text) looks
decidable and stands or falls on its own merits at that re-audit.
The next sprint picks this up to direct the re-audit and close it
out.
