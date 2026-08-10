---
concept: assessment
---

# Assessment

## What it is

An assessment is a documentation-corpus record capturing one measured
way a promise or prior played out against a released product, measured
from the user's side: what was attempted through the public surface,
what was observed, the warrant behind the claim, and the honest
boundary of what was not verified. It is the documentation ceremony's
unit of documentation — the how-to content for a story is the record
of the benefit actually being obtained, not prose describing the
feature.

## Purpose

Assessments make documentation a measurement instead of a restatement.
Prose that describes code drifts silently because nothing re-checks it;
an assessment's claim rests on a warrant that is re-taken at every
release, so the documentation and the product cannot quietly tell
different stories. The path a user follows to the promised benefit is
itself the product of the record — and because that path was driven
through the public surface, the reader can retrace it without ever
being handed an internal shortcut.

## Boundaries

One assessment covers exactly one measured way. A story the product
honors through several ways carries several assessments, each standing
on its own warrant; the story's documentation is the set. The
measurement result an assessment records — held or unverified — is a
byproduct; the demonstrated path is the product. A contradiction is
not one of those results: it leaves the assessment and is dispatched
to a record of its own kind, a trap or a defect. An assessment is not
an audit determination: the determination is the audit's verdict over
the story, while the assessment is the publishable record of one
measured way — both resting on the same user-vantage runs. See also:
`story-artifact`, `assumption`, `trap`, `experiment`,
`documentation-corpus`.

## Invariants

- Every assessment names the release it is a statement about and the
  warrant its claim rests on.
- A warrant is affirmative: a passing experiment driven through the
  public surface at the release — never a reading alone, never a
  failed run, and never a test that reaches behind the surface.
- An assessment speaks in the shipped vocabulary — concepts, stories,
  and public surface elements — and cites catalog rows at the stamp,
  never source paths.
- The unverified remainder is stated in the record, never left silent.
- Assessments are re-derived at every release; none carries forward.
