---
decision: stack-tool-runs-each-run
---

# One stack tool runs each verification run from start to end

## Choice

ok-planner's stack tool runs the whole life of every verification run
with two verbs. `up` mints the run tag, leases the run's host ports,
makes the run's folder, writes one entry for the run in the project's
registry, and runs the start command the project's configuration
declares, or a command its caller names in its place, with the tag, the ports, the run's label, and the folder's
path in its environment. `down` runs the declared stop command
where the run used the declared start command, removes every artifact the entry records,
releases the lease, and deletes the entry once every removal
succeeds, whether the run passed or failed and whether its start
finished. A periodic cleanup takes down
each stale entry in the project's registry. Every verification path
that builds or starts anything, such as a drive, a driver's own
server, a test run, or an audit experiment, starts its run with `up`
and ends it with `down`, naming its own command where the project's
stack is not what it starts.
The tool is the only way to mint a run tag. A project writes a start command
that builds and starts its stack, and a stop command where its stack
makes anything the tool does not record, and follows the suite's
stack rules.

## Rationale

Where separate tools and each project's own commands carry the steps
of a run's life, each step breaks on its own: a lease no stop
releases, artifacts named so a cleanup cannot find them, a cleanup
that reaches other projects' images, an experiment with no teardown. One program that runs every step in order keeps the steps
together, and its registry tells a live run from a dead one without
guessing from names. A project's commands stay plain, since the tool
supplies the tag, the ports, the label, and the folder. The costs: a
project's stack starts only through its declared start command, and a verification path that bypasses the tool gets no tag.

## Alternatives

- The project's start and stop commands call the tool's verbs — every project must call them in the right order, and a project that misses or misorders a call breaks the run's life.
- Separate tools for the tag, the lease, and the cleanup — each step works alone, and nothing ties a run's artifacts to its life.
- A tag tool beside the stack tool for runs that start no declared stack — a tag with no registry entry, whose artifacts nothing removes.
