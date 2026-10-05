---
decision: pinned-build-placed-at-converge
---

# The dashboard's build is placed to match the project's pinned version, never committed

## Choice

The dashboard's frontend is built once per suite release and carried
as family payload. A project receives the build matching the suite
version its vendored layer is stamped with: the family's converge
places it, in the same administration pass that writes the vendored
layer's stamps, inside the planner's estate and ignored by git rather than
committed. The build a project serves is the one its last convergence
placed, never one retrieved when the owner opens the page.

## Rationale

Per-project pinning decides this. The intake record's schema moves
between releases, so a page built for a newer schema misreads an
older project's intake. Committing the build into each consumer estate
would pin it correctly but adds a churning generated artifact to
repositories that gain nothing from its bytes. Serving the front
door's carried build unpinned keeps those repositories clean but
misreads exactly the projects that have not converged. Placing the
pinned build at converge keeps both properties, and keeps the act
where the suite's other pinning already happens (see also:
per-project-pinning).

## Alternatives

- Commit the built bundle into each consumer estate — correctly pinned, but a generated artifact rewritten in every repository on every converge.
- Serve the front door's carried build unpinned — nothing lands in consumer repositories, but a project behind the current release gets a page that misreads its intake.
