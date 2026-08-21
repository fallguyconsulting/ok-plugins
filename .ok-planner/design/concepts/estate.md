---
concept: estate
aliases:
  - dot-directory
  - project-side estate
---

# Estate

## What it is

An estate is a skill family's committed project-side presence, rooted
in one dot-directory named for the family: declared configuration
(including any stack profile), the family's corpus of durable content,
materialized support scripts, hooks and program payloads, ceremony
contributions, injected-context payloads, and any machine-written
determination records. Beside those a family may keep machine-local
content the repository does not carry — real on disk, never part of
what the project commits. Its existence doubles as the discovery
marker answering "which suite families does this project use," and as
the anchor the project root is resolved from.

## Purpose

Rooting everything in one committed directory makes integration state
a property of the project rather than of any machine: contributors
without anything installed still see the estate, discovery is a
filesystem check, and each project runs exactly what it was converged
to. Absence is a meaningful state — a bootstrap candidate or a
recorded decline — not an error.

## Boundaries

The estate is suite territory inside the consumer's repo, converged by
the front door's administration (see also: true-up); outside it a
family owns only its cheatsheet and its vendored skill files (see
also: cheatsheet, vendored-skills under decisions). Documented
pre-migration marker locations also serve discovery (see also:
filesystem-discovery-markers under decisions). The front-door plugin
deliberately has no estate. Content kinds inside an estate carry
distinct context rules — source-of-truth corpus content, operational
intake state, machine-written audit determinations, project records,
and the machine-local content the repository does not carry, which is
nobody's source of truth and is never read as project content (see
also: design-corpus, issue, adversarial-implementation-audits under
decisions). The record discipline is this concept's to state once:
records — sprints, sketches, the archive, the documentation corpus,
and the documents the documentation ceremony places in the tree
outside the estate — are committed and versioned but out of agent
context by default, with exactly one live exception, the sprint
currently being executed (see also: sprint, sketch,
documentation-corpus).
