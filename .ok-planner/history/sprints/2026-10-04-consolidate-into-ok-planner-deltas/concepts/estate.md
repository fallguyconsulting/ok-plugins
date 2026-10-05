---
concept: estate
aliases:
  - dot-directory
  - project-side estate
---

# Estate

## What it is

An estate is the suite's committed project-side presence: the place in
a consumer project that holds what the suite keeps for that project.
It holds content the owner writes beside suite-owned content and the
records the suite's runs write, and it may keep machine-local content
the project does not commit.

## Purpose

Rooting the suite's state in one committed place makes integration
state a property of the project rather than of any machine, so each
project runs what it was converged to.

## Boundaries

The estate is suite territory inside the consumer's project, converged
by the front door's administration (see also: true-up); outside it the
suite owns only what the ownership rule assigns it (see also:
cheatsheet; whole-file-ownership, vendored-skills under decisions).
Its content kinds carry distinct context rules (see also:
design-corpus, issue, subject, practice;
adversarial-implementation-audits, records-stay-out-of-context under
decisions). Records are the project's history of its work (see also:
sprint, sketch, documentation-corpus; records-stay-out-of-context
under decisions). See also: one-vendored-family,
filesystem-discovery-markers, project-declares-its-folders under
decisions.
