---
issue: corpus-deltas-cannot-express-a-revision
kind: human
category: other
artifacts:
  - concept:corpus-delta
  - concept:completion-contract
status: promoted
opened: 2026-08-08T01:11:15Z
sprint: 2026-08-08-practices-corpus-and-suite-ceremonies.md
---

# A corpus delta can only restate a whole artifact, never revise part of one

## Problem

A sprint's corpus deltas must each be a final-form artifact body: the
complete concept, story, or decision file content, copied into
`design/` verbatim at execution. Partial and summarized deltas are
non-compliant by definition — the corpus-delta concept's Boundaries say
a delta "is NOT a diff, a summary, or a partial edit," and the
`/plan-sprint` template repeats it ("if the artifact changes, its full
new body appears here").

The rationale is real and worth keeping. The owner signs off on exact
final text, the executor applies it with zero interpretive latitude, and
the completion contract's first item — the corpus matches every delta,
applied verbatim — stays a file-equality check that an alignment judge
can settle mechanically. The sign-off compliance review can only check a
*complete* artifact against the artifact rules; a fragment can't be
checked for its mandatory sections.

But full-body-only carries two costs the current shape doesn't
acknowledge.

**It can silently revert an in-cycle repair.** A full-body delta is a
snapshot of the artifact taken at drafting time, and nothing rechecks
that snapshot at execution time. The corpus is legally mutable in
between: the certification fix loop may repair how a commitment is
*expressed* when the rules fully determine the compliant text and no
commitment changes. If that repair lands on an artifact a pending sprint
already snapshotted, executing the sprint copies the stale body over it
— and the completion contract certifies the result as correct, because
the corpus does match the delta. The mechanism that guarantees fidelity
to approved text is the same mechanism that guarantees regression to a
stale base, with no signal distinguishing the two.

**It degrades the one review that checks a delta for truth.** The
sign-off compliance review is the only point where a delta's claims are
checked at all — after approval the alignment judge compares the corpus
to the delta, so a delta that matches itself reads clean no matter what
it asserts. That review receives a complete body with no marking of what
changed, so unchanged prose is re-read at the same weight as the one
invariant the sprint is actually changing. And because the drafting
agent retypes the whole artifact, any paraphrase it introduces in a
section nobody meant to touch becomes approved text; nothing downstream
diffs the delta against the live artifact to catch it. The rule that
eliminates interpretive latitude at apply time reintroduces it at draft
time, where there is no check at all.

## Options

- Leave it: full-body-only, accepting the stale-base revert and the
  flat review surface as the price of a mechanical apply and a
  mechanical alignment check.
- Allow a revision form as an alternative delta shape, with the
  executor applying anchored edits — cheaper to author and review, but
  it moves interpretation to apply time and the alignment check stops
  being file equality.
- Keep the full body as the *applied* form but stop making it the
  *authored* form: an amendment carries the base it was drafted
  against, the revision itself, and the resulting complete body derived
  from the two.

## Ruling

Take the third shape. An amendment delta should carry three things: a
stamp identifying the artifact body it was drafted against, the revision
as anchored edits, and the resulting complete artifact derived by
applying that revision to that base rather than retyped.

Everything downstream stays as it is. Execution still copies a complete
body into place verbatim, and the completion contract still settles by
file equality. The compliance review reads the revision as "the change"
instead of hunting it inside a wall of unchanged prose, and gains a
check it cannot do today: that the resulting body really is the base
plus the revision, with no drift in sections nobody meant to touch.

The stale-base problem becomes loud instead of silent. At execution the
base stamp either matches the live artifact or it does not, and a
mismatch stops for the owner rather than reverting an in-cycle repair
under cover of a passing gate.
