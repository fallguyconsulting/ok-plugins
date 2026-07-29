---
decision: built-bundle-fetched-at-pin
---

# The view's build is fetched to match the project's pinned version, never committed

## Choice

The corpus view's frontend is built once per suite release and carried as family payload. A project receives the build matching the suite version its estate is already stamped with: the family's converge places it, in the same administration pass that writes the estate's version stamp, inside the planner's estate and ignored by git rather than committed. The fetch is the administration's act, never the view's: the build a project serves is the one its last convergence placed, not something retrieved when a reader opens the page. Earlier versioned builds stay retrievable because every released version carries its own, so a project pinned to an older suite version keeps a build that understands the corpus of its era.

## Rationale

Per-project pinning is the property that decides this. The corpus's citation forms move between releases, so a view built against a newer corpus renders an older project as empty or broken. Committing the build into each consumer estate would pin it correctly but pay a permanent, churning generated artifact in repositories that gain nothing from its bytes; running the front door's carried build unpinned would keep those repositories clean but misread exactly the projects that have not converged. Placing the pinned build at converge keeps both properties, and keeps the act where the suite's other pinning already happens: administration writes what a project runs, so the build needs no access class of its own. No new committed record is needed to support it either: the estate already carries the suite version stamp and already serves as the discovery marker.

## Alternatives

- Commit the built bundle into each consumer estate — correctly pinned, but a large generated artifact rewritten wholesale in every repository on every converge.
- Run the front door's carried build unpinned — nothing lands in consumer repositories, but a project behind the current release gets a view that misreads its own corpus.
- Render every view server-side and ship no build — no distributed artifact at all, at the cost of the interaction the surface choice exists to buy.
