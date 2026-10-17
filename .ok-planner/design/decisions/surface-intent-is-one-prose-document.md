---
decision: surface-intent-is-one-prose-document
---

# The surface intent is one prose document of class rules with named exceptions

## Choice

A project's surface intent is one prose document of class-level rules:
which classes of element are public by default, with the specific
elements that depart from those rules named. Every reader of the
public surface reads that one document (see also:
surface-intent-changed-by-sprints, surface-members-listed-at-need).

## Rationale

One prose document of class rules with named exceptions matches how an
owner thinks about the surface: a few general rules and a few
carve-outs, edited when intent moves. One shared document lets several
documents cite one class without disagreeing about its members'
status.

## Alternatives

- Keep the surface as structured data, one entry per class or element —
  a tool reads it directly, and the owner edits a schema instead of
  saying what they mean.
- Let each reference docspec name its own surface inline — no shared
  file, and two documents that list the same classes can disagree.
