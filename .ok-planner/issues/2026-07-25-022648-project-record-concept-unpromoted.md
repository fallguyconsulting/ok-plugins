---
issue: project-record-concept-unpromoted
kind: discover
category: other
artifacts:
  - concept:estate
  - concept:sketch
  - concept:sprint
status: verified
opened: 2026-07-25T02:26:48Z
---

# The project-record discipline is stated three times and owned nowhere

The rule that sprints, sketches, and history are "project records" — committed but out of context by default, one live exception (the sprint being executed), archived to `history/` on completion — is stated per-artifact in three concepts: `estate` (a one-line pointer), `sketch` (its own copy), and `sprint` (its own copy). No artifact states the general rule once. The materialized estate CLAUDE.md spells the full discipline out in prose — exactly the durable general property a concept exists to state — but that file is generated documentation, not corpus. The risk is the usual one for triplicated rules: an edit to one concept's wording drifts from the other two with nothing to catch it.

No rule forces consolidation; this is the third of three sibling issues on when a recurring cross-artifact rule earns its own file (with `front-door-concept-unpromoted` and `intake-queue-concept-unpromoted`). Under the shared standard — promote when the noun owns rules no existing concept can host without stretching — this one is the closest call: unlike the front door (whose property is a contract clause) the record discipline is genuinely its own rule set, but `concept:estate` already frames content kinds carrying distinct context rules, so it has a natural single home.

## Options

- **Fold into `concept:estate`** — its Boundaries grow the discipline stated once (record kinds, out-of-context default, the executing-sprint exception, archive-on-completion); `sketch` and `sprint` shrink to pointers. One home, no new file; pushes `estate` slightly toward procedural content.
- **Promote a `project-record` concept** — the cleanest ownership, at the cost of a fifth artifact in an already five-piece picture (estate, design-corpus, sketch, sprint, issue) for one rule.

The ruling decides: fold into estate or promote — under the same standard as the two siblings.

## Ruling

> Recommended ruling (/verify-issues): fold into `concept:estate` — a sprint delta states the project-record discipline once in estate's Boundaries/Invariants, and re-points `concept:sketch` and `concept:sprint` at it, keeping only each kind's own specifics (the sketch's per-file archival, the sprint's executing-exception).
>
> Rationale: estate already owns "what kinds of content live here and how agents treat them" — the discipline is that boundary's content, not a new noun's. Applying the fold standard consistently across all three siblings keeps the concept count honest; this is the closest call of the three, and a future fourth record kind straining estate's framing would be the evidence that reopens promotion.

<!-- Owner: this is a recommendation, not your decision. Leave it
as-is to accept — the next /plan-sprint carries it, naming the
generated/recommended batches at sign-off. Edit the text to
redirect, empty the section to discuss live, or delete this note
to adopt the ruling as your own. -->
