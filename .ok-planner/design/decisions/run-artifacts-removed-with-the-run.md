---
decision: run-artifacts-removed-with-the-run
---

# A run's artifacts are removed when the run ends, pass or fail

## Choice

A run's artifacts end with the run: the run tag's life is mint, build, verify, remove. The reference stack tool removes everything a run made when the run ends, whether the run passed or failed, and the suite's helpers let a project's own teardown do the same, finding each artifact by the tag (see also: run-artifacts-found-by-run-tag). The reference stack tool records each run in the project's registry. Its `down` runs the run's stop command where one was given, stops the run's process group, sweeps its docker objects, deletes its folder, releases its ports, and deletes its entry once every removal succeeds. Its cleanup, run periodically, such as after a batch of drives, takes down each entry in the project's own registry that is at least an hour old and that nothing still uses: no process is left in its process group, no running container carries its label or belongs to its compose project, and no program holds its leased ports. The reference tool probes docker's daemon before and after its start command, on a failed start as on a passing one, and records on the run's entry whether either probe answered. Where the sweep reports that the daemon did not answer, the tool counts the sweep as done only for a run whose probes both went unanswered; a run that reached docker keeps its entry for a later cleanup. A removal docker refuses leaves the entry in place with the refusal named, and the cleanup goes on to the next entry.

## Rationale

A tag unique per run means no later build replaces a run's artifacts, so every run adds to the disk until something removes what it built. A teardown removes them for every run that reaches its end, and a cleanup removes a crashed run's. The registry entry tells a run something still uses from one nothing uses, and what the entry records is all the cleanup touches. The hour of grace keeps the cleanup from taking down a run still building, before its first process or container exists. The probes around the start command tell the tool whether the run reached docker: on a machine whose daemon never answered, each run ends with its entry deleted and its ports released, and a run that made objects and then lost its daemon keeps its entry until docker answers. A refused entry that stays lets a later cleanup try it again, and going on keeps one stuck artifact from blocking every other run's removal. A failed run's evidence lives in its service logs and its recorded output, and a rerun builds under a fresh tag, so keeping a failed run's artifacts buys little. The costs: a crashed run's artifacts wait for a cleanup at least an hour later, a run whose stack stopped while its checks still run can be taken down under them, a daemon started and stopped inside the start command or started by a later verification step escapes both probes, and a project whose own teardown skips the helpers keeps whatever that teardown leaves.

## Alternatives

- Remove the artifacts of every run tag docker knows that holds no lease and has no containers — the scan reaches other projects' artifacts, and misses an artifact whose name hides its tag.
- Take down every stale entry at once, whatever its age — a run still building loses its artifacts.
- Remove a run's artifacts at the stack's stop alone — a run that crashes before its stop leaves its artifacts on disk for good.
- Stop the cleanup at the first refused removal — one stuck artifact keeps every later run's artifacts on disk.
- Leave removal to each project's own wiring, with no helpers — every project rebuilds the search for what a run made, and a project that skips it fills its disk.
- Keep an entry owing a docker sweep for every run whose sweep met a silent daemon — on a machine where docker is installed and never started, the registry grows on every run.
- Keep a failed run's artifacts for debugging — the evidence already lives in logs and output, and the kept artifacts fill the disk.
