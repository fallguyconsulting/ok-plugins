---
decision: driver-uses-only-the-public-surface
---

# A driver uses only what a user has, with a local stand-in for an outside party

## Choice

A driver uses only what a user in the story's role has: the public
surface and what the product tells a user, never the source or the
database. In place of a party outside the product that a story's
benefit passes through, the driver uses the local stand-in the review
facts name for that party (see also: work-items-change-the-product).
No step of a drive waits on a person. A surface that is a skill is the
one exception to the source rule (see also:
skill-surfaces-reviewed-not-driven).

## Rationale

Driving as a user finds what a reader of the code misses: a path that
works in the code and that no user can find, or a message that does
not say what went wrong. A driver that read the source would find the
path a user cannot, and pass it. A local stand-in keeps the benefit's
whole path under the drive with no person present, so no run stops to
wait for one.

## Alternatives

- The driver reads the source or the database to find a path or to
  check an outcome — quicker to steer, and it passes a path no user
  can find.
- A person completes a third party's step, such as a consent screen,
  while the driver waits — the drive tries the real service, and the
  run stops until a person is present.
