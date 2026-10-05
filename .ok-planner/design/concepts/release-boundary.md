---
concept: release-boundary
---

# Release boundary

## What it is

A release boundary separates code that ships in one release from a user
that does not update in the same step. Stored state is always one: data
an earlier release wrote and a later release reads does not update when
the code does.

## Purpose

The boundary tells whoever changes the code which users the change can
break without anyone seeing it in the tree. Inside one release, a
change can bring every user along. Across a boundary it cannot.

## Boundaries

A release boundary need not lie on the public surface: the user across
it may be another program the project ships (see also: surface-intent).
How a boundary constrains a change is recorded as a decision (see
also: release-boundaries-bind-changes under decisions). It is not a version
number: a version says how a break is announced, and the boundary says
who breaks.
