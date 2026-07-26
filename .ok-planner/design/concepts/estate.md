---
concept: estate
aliases:
  - dot-directory
  - project-side estate
---

# Estate

## What it is

An estate is a plugin's committed project-side presence, rooted in one dot-directory at the consumer repo root named for the plugin: declared configuration (including any stack profile), the plugin's corpus of durable content, materialized support scripts and hooks, and injected-context payloads. Its existence doubles as the discovery marker answering "which suite plugins does this project use."

## Purpose

Rooting everything in one committed directory makes integration state a property of the project rather than of any machine: contributors without the plugin still see the estate, discovery is a filesystem check, and each project runs exactly what it was converged to. Absence is a meaningful state — a bootstrap candidate or a recorded decline — not an error.

## Boundaries

The estate is plugin territory inside the consumer's repo, converged by the lifecycle verb (see also: true-up); the one file a plugin owns outside it is its cheatsheet (see also: cheatsheet). Documented pre-migration marker locations are honored for discovery so un-migrated projects are still found and offered migration (see also: filesystem-discovery-markers under decisions). The front-door plugin deliberately has no estate. Content kinds inside an estate may carry distinct context rules — source-of-truth corpus content, operational intake state, and out-of-context records (see also: design-corpus, issue, sprint).

## Invariants

- The project root everything resolves against is the nearest git ancestor of the working directory, falling back to the working directory itself; every implementation of root resolution across the suite conforms to this one rule.
- Whether the estate is tracked in git is the project owner's decision where the plugin has no gitignore of its own.
- Records in an estate are preserved indefinitely in its archive; migration moves files, never rewrites their bodies.
- An installed plugin with no estate is offered bootstrap by consent; declining is a valid state, not drift.
