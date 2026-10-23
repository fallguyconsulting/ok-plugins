---
decision: pinned-build-placed-at-true-up
---

# The dashboard's build is placed to match the project's pinned version, never committed

## Choice

The dashboard's frontend is built once per suite release and carried
as family payload. A project receives the build matching the suite
version its vendored layer is stamped with, placed inside the
planner's estate and ignored by git rather than committed. Two acts
place it, through one placement routine: the family's true-up, in the
same administration pass that writes the vendored layer's stamps, and
the `/dashboard` skill, where the project holds no placed build or one
stamped with another version. Each copies the build the installed
front door carries for the pinned version. Where no installed front
door carries that version, `/dashboard` places nothing and names
`/ok`. Where the placed build's version differs from the
project's pinned version, the service serves it with a note that names
`/ok`.

## Rationale

Per-project pinning decides this. The intake record's schema moves
between releases, so a page built for a newer schema misreads an
older project's intake. Committing the build into each consumer estate
would pin it correctly but adds a churning generated artifact to
repositories that gain nothing from its bytes. Serving the front
door's carried build unpinned keeps those repositories clean but
misreads exactly the projects that have not been trued up. Placing the
pinned build at true-up keeps both properties, and keeps the act
where the suite's other pinning already happens (see also:
per-project-pinning). Git ignores the placed build, so a fresh clone
or a new worktree holds none. Placing it at `/dashboard` as well gives
the owner the page from the verb they asked for, with no `/ok`, which updates plugins and can rewrite the suite's files. The plugin
cache keeps earlier versions of the front door, so the pinned
version's build is usually on the machine, and the page `/dashboard`
places is still that version's build.

## Alternatives

- Commit the built bundle into each consumer estate — correctly pinned, but a generated artifact rewritten in every repository on every true-up.
- Serve the front door's carried build unpinned — nothing lands in consumer repositories, but a project behind the current release gets a page that misreads its intake.
- Place the build only at true-up, so a clone runs `/ok` before the page serves — the pinning holds, and the owner runs a second verb, one that can rewrite the suite's files, before the page serves.
- Serve the page straight from the installed front door's copy for the pinned version, placing nothing — no placed files, and the page breaks whenever that version leaves the machine.
