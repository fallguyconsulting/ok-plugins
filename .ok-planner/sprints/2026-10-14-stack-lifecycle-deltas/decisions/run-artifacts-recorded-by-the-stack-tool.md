---
decision: run-artifacts-recorded-by-the-stack-tool
---

# The stack tool records a run's artifacts by label, folder, and process group

## Choice

The stack tool records what a run makes in three ways. Every docker
container, image, volume, and network the run makes carries the run's
label, which names the run tag, and `down` removes every container,
image, volume, and network that carries it. Every file the run writes outside docker sits in the run's
folder, which `down` deletes. Every process the start command leaves
running belongs to the process group the tool started it in, which
`down` stops. A stack makes nothing outside those three kinds unless
its stop command removes it. `down` removes a container's anonymous
volumes with the container (see also: stack-ports-checked-as-a-suite-rule
for how the label rule is checked).

## Rationale

The tool removes exactly what a run made only where it finds each
thing without guessing. A label is docker's own record of who made an
object, and it holds whatever the object's name or tag, so a suffixed
or renamed image is still found, and no other project's object
carries this run's label. One folder per run gathers the files, and a
process group gathers the processes a start command forks, so neither
needs a list kept by hand. Only the project's own stop command reaches
a stack's other artifacts, such as a cloud deployment. The costs: a
project adds the label to its compose files and its build commands,
and an image built without it stays behind.

## Alternatives

- Match docker objects by the run tag in their names — an image tagged with a suffix, or named another way, stays behind, and the match reaches other projects' objects.
- A verb the stack calls to record each artifact — every project must call it for every artifact, and a missed call leaves the artifact behind.
- Let the compose tool remove the images its project used — it also removes shared images a stack pulled, or keeps the custom-tagged images it built.
