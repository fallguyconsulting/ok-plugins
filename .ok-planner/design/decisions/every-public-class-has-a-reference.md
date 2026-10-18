---
decision: every-public-class-has-a-reference
---

# Every class the surface intent makes public has a reference docspec

## Choice

Each class of element a rule of the surface intent makes public, and
each class an exception draws a public member from, is named in the
lists of at least one reference docspec. Where a sprint's surface
intent delta declares a class no docspec lists, planning drafts a
reference docspec for it from the reference template, as a call the
owner may veto. The sign-off review refuses a sprint that leaves a
public class unlisted. A guide, a tutorial, or an overview does not
count, and a docspec for documentation of internal behavior is
allowed.

## Rationale

A public element is one callers outside the project depend on, so
they need one place that lists all of it. Drafting the reference from
a template costs one call, and tying it to the surface delta means a
surface never ships without the documentation that names its members.
A tutorial teaches a path through the surface and lists no element in
full, so it cannot stand in.

## Alternatives

- Leave reference documentation to the owner's choice per class — no
  docspec the owner did not ask for, and a public class can ship with
  nothing that lists its members.
- Let any docspec that mentions a class count — fewer docspecs, and a
  reader finds no complete list.
