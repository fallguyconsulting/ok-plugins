---
concept: estate
aliases:
  - dot-directory
  - project-side estate
---

# Estate

## What it is

An estate is a skill family's committed project-side presence, rooted in one dot-directory at the consumer repo root named for the family: declared configuration (including any stack profile), the family's corpus of durable content, materialized support scripts, hooks and program payloads, injected-context payloads, and any machine-written determination records. Beside those a family may keep machine-local content its own ignore file holds out of the repository — real on disk, never part of what the project commits. Its existence doubles as the discovery marker answering "which suite families does this project use."

## Purpose

Rooting everything in one committed directory makes integration state a property of the project rather than of any machine: contributors without anything installed still see the estate, discovery is a filesystem check, and each project runs exactly what it was converged to. Absence is a meaningful state — a bootstrap candidate or a recorded decline — not an error.

## Boundaries

The estate is suite territory inside the consumer's repo, converged by the front door's administration (see also: true-up); outside it a family owns only its cheatsheet and its vendored skill files (see also: cheatsheet, vendored-skills under decisions). Documented pre-migration marker locations are honored for discovery so un-migrated projects are still found and offered migration (see also: filesystem-discovery-markers under decisions). The front-door plugin deliberately has no estate. Content kinds inside an estate carry distinct context rules — source-of-truth corpus content, operational intake state, machine-written audit determinations, mechanically derived generated state (regenerated wholesale from the project's own sources, carrying no judgment and nothing hand-written, so it is always safe to rebuild), project records, and the machine-local content a family's own ignore file excludes from the repository (a build its administration placed, a measurement one of its runs left), which is nobody's source of truth and is never read as project content (see also: design-corpus, issue, source-graph, adversarial-implementation-audits under decisions). The record discipline is this concept's to state once: records — sprints, sketches, and the archive — are committed and versioned but out of agent context by default, with exactly one live exception (the sprint currently being executed), and every completed or retired record moves to its same-named folder in the archive (see also: sprint, sketch).

## Invariants

- The project root everything resolves against is the nearest git ancestor of the working directory, falling back to the working directory itself; every implementation of root resolution across the suite conforms to this one rule.
- Whether the estate is tracked in git is the project owner's decision where the family has no gitignore of its own.
- Records in an estate are preserved indefinitely in its archive; migration moves files, never rewrites their bodies.
- An estate-less family carried by the installed front door is offered bootstrap by consent; declining is a valid state, not drift.
