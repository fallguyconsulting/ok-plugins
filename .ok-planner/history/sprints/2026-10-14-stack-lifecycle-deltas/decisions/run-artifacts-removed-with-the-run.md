---
decision: run-artifacts-removed-with-the-run
---

# A run's artifacts are removed when the run ends, pass or fail

## Choice

A run's artifacts end with the run: the run tag's life is mint, build, verify, remove. The stack tool's `down` removes everything the run's registry entry records, whether the run passed or failed (see also: run-artifacts-recorded-by-the-stack-tool). The stack tool's cleanup, run periodically, such as after a batch of drives, takes down each entry in the project's own registry that is at least an hour old and that nothing still uses: no process is left in its process group, no running container carries its label, and no program holds its leased ports. The cleanup reads only the project's own registry, so it never removes another project's artifacts. A removal docker refuses leaves the entry in place with the refusal named, and the cleanup goes on to the next entry.

## Rationale

A tag unique per run means no later build replaces a run's artifacts, so every run adds to the disk until something removes what it built. `down` removes them for every run that reaches its end, and the cleanup removes a crashed run's. The registry entry tells a run something still uses from one nothing uses, and what the entry records is all the cleanup touches. The hour of grace keeps the cleanup from taking down a run still building, before its first process or container exists. A refused entry that stays lets a later cleanup try it again, and going on keeps one stuck artifact from blocking every other run's removal. A failed run's evidence lives in its service logs and its recorded output, and a rerun builds under a fresh tag, so keeping a failed run's artifacts buys little. The costs: a crashed run's artifacts wait for a cleanup at least an hour later, a run whose stack stopped while its checks still run can be taken down under them, and an artifact made outside the three recorded kinds stays unless the stop command removes it.

## Alternatives

- Remove the artifacts of every run tag docker knows that holds no lease and has no containers — the scan reaches other projects' artifacts, and misses an artifact whose name hides its tag.
- Take down every stale entry at once, whatever its age — a run still building loses its artifacts.
- Remove a run's artifacts at the stack's stop alone — a run that crashes before its stop leaves its artifacts on disk for good.
- Stop the cleanup at the first refused removal — one stuck artifact keeps every later run's artifacts on disk.
- Leave removal to each project's own wiring — every project fills its disk by default.
- Keep a failed run's artifacts for debugging — the evidence already lives in logs and output, and the kept artifacts fill the disk.
