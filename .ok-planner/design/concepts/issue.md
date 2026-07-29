---
concept: issue
---

# Issue

## What it is

An issue is anything about the design corpus that requires human
judgment to resolve — sloppy, unspecified, unclear, overloaded,
conflicting, or vestigial design, a test whose intent has drifted,
or a question deferred during planning. Issues live as one markdown
file each in the intake directory, named so a listing sorts
chronologically; a file's status moves forward only — open, then
verified once a from-the-top discussion is prepared, then a terminal
state — and a non-empty ruling section is the owner's decision,
however it got there.

## Purpose

The issue separates judgment from mechanics: anything mechanically
fixable is fixed in-cycle by whoever found it and never filed, so an
issue file means "requires owner calibration" by construction. The
intake turns scattered design muddiness into a single owner-facing
agenda that verification makes ruling-ready and planning drains
deliberately.

## Boundaries

An issue is a question waiting to reach a sprint — the intake is a
holding area, not a work tracker; nothing is worked or tracked to
completion in it. Many writers may open an issue; the verifier
prepares each file for ruling and may close only what the corpus
already answers or the authoring rules fully determine, every such
closure reported for the owner's veto. All other closure is an owner
act recorded through the planning ceremony — promoted into a sprint
or retired with a reason — and closed files move to the archive.
After promotion the sprint alone carries the resolution (see also:
sprint, plan-a-sprint under stories). The issue sits at the top of a
three-step altitude ladder: the ruling states intent, the planning
ceremony translates it into deltas and work items, and the
implementer owns mechanics — each step reading the one above it,
with the ceremony's clarification question as the escape when a
ruling cannot be understood. The nature of an issue is its category;
the identity of its writer is its kind — two orthogonal labelings.
Mechanical findings are the neighbor that never becomes an issue
(see also: finding).

## Invariants

- Only judgment items become issues.
- Slugs are stable fingerprints of artifact plus nature — writers
  check the intake first and file only genuinely new questions, so
  re-observation files nothing.
- Many writers may open; only the planning ceremony and the
  verifier's corpus-cited closures terminate, and the verifier's
  closures are always reported for veto.
- A non-empty ruling is the ruled signal: the next planning session
  carries it into the sprint it plans without re-discussion.
- Settled means settled: a later sprint never re-opens a promoted
  issue; a wrong resolution becomes a new issue with its own file.
- The verified narrative serves one fixed audience — an experienced
  engineer who doesn't know much about the project or its
  implementation and doesn't have a lot of time to read, but needs
  to evaluate a ruling based on an informed technical opinion — and
  every sentence earns its place against that purpose.
- Candidates and rulings live at intent altitude: durable statements
  of what should change and why, in an engineer's plain register —
  never file or symbol citations, and never delta or
  artifact-operation phrasing, which is the planning ceremony's
  translation to make.
