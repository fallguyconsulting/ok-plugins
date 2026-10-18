---
concept: surface-intent
---

# Surface intent

## What it is

The surface intent is a project's declaration of what its user-facing
surface is meant to be: which modules, services, or paths are
user-facing at all, and which of their elements are public. It is
owner intent and the source of truth for the public surface.

## Purpose

The surface intent is the one place the project declares what belongs
to the user's field of view. Every question about the public surface
routes back to it. Whoever writes a reference docspec reads it to
learn which classes are public.

## Boundaries

The surface intent describes intent, not the element inventory. The
intent's form, how it changes, and when its members are listed are
decisions (see also: surface-intent-is-one-prose-document,
surface-intent-changed-by-sprints, surface-members-listed-at-need,
every-public-class-has-a-reference under decisions). It is not a release boundary, though every element
it classes as public lies on one: a boundary may also separate users
the public surface does not reach (see also: release-boundary). It is not a docspec, which says what one kind of
documentation tells its reader (see also: docspec).
