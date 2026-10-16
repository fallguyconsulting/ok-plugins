---
decision: run-artifacts-found-by-run-tag
---

# A run's artifacts are found by its tag: its label, its compose project, and its process group

## Choice

The suite's helpers find what a run made with no list kept by hand.
The docker sweep removes every docker container, image, volume, and
network that carries the run's label, which names the run tag, or that
belongs to the compose project the run tag names, and removes a
container's anonymous volumes with the container. Where docker's
daemon does not answer, the sweep removes nothing and exits with a
status of its own, distinct from success and from a refused removal.
The process-group helper starts a command in a process group of its
own, records the group under the run tag, and later stops every
process left in that group. The reference stack tool also gives each
run one folder for every file the run writes outside docker, and
deletes the folder with the run. The helpers find nothing a stack
makes outside those kinds; only the stack's own stop command removes
it.

## Rationale

A helper removes exactly what a run made only where it finds each
thing without guessing. A label is docker's own record of who made an
object, and it holds whatever the object's name or tag, so a suffixed
or renamed image is still found. Compose marks every object it makes
with its project's name, so a compose project named by the tag finds a
stack whose compose file carries no label, and a project's existing
compose stack is found with no edit. No other project's object carries
this run's label or compose project. A process group gathers the
processes a start command forks, and one folder per run gathers the
files, so neither needs a list. The sweep cannot tell a run that made
no docker object from a run whose daemon has since stopped, so it
reports the silence and leaves the call to its caller, the one party
that can know whether the run reached docker. The costs: an image
built outside compose without the label stays behind, and every caller
of the sweep handles one more exit status.

## Alternatives

- Match docker objects by the run tag in their names — an image tagged with a suffix, or named another way, stays behind, and the match reaches other projects' objects.
- The label alone — a project's existing compose stack must add the label to every service, volume, and network before the sweep finds anything.
- A verb the stack calls to record each artifact — every project must call it for every artifact, and a missed call leaves the artifact behind.
- The sweep reads a silent daemon as nothing made — a run whose daemon stopped before its teardown ends with its objects on disk and nothing that records them.
- The caller tells the sweep whether the run reached docker — the evidence each project collects becomes part of the sweep's interface, and the sweep no longer stands alone.
