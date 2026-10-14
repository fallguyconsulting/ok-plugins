---
decision: run-artifacts-removed-with-the-run
---

# A run's artifacts are removed when the run ends, pass or fail

## Choice

A run's artifacts end with the run: the run tag's life is mint, build, verify, remove. The run's stack stop removes everything the run built under its tag, whether the run passed or failed. ok-planner's port cleanup, which frees stale port leases, also removes the container artifacts (images, volumes, and networks) of every run tag that holds no lease, has no containers left, and has no artifact made in the last hour.

## Rationale

A tag unique per run means no later build replaces a run's artifacts, so every run adds to the disk until something removes what it built. The stack stop removes them for every run that reaches it, and the cleanup removes a crashed run's container artifacts; the port leases tell a live run's tag from a dead one's. A failed run's evidence lives in its service logs and its recorded output, and a rerun builds under a fresh tag, so keeping a failed run's artifacts buys little. The hour of grace keeps the cleanup from removing what a live run is still building, whether this project's run or another project's, since docker shows every project's run tags and this project's registry knows only its own leases. The costs: a crashed run's container artifacts wait for a cleanup at least an hour later, another project's run that takes longer than an hour from build to start can still lose its images, and a crashed run's artifacts of other kinds stay until the project's own stop command or a person removes them.

## Alternatives

- Remove the artifacts of every lease-less, container-less run tag at once — a live run between its build and its start loses its images.
- Remove only the tags this project leased — the audit's experiment runs, which need not lease ports, are left uncleaned.
- Remove a run's artifacts at the stack stop alone — a run that crashes before its stack stops leaves its artifacts on disk for good.
- A drive role of its own for removal — one more role every project must fill, and the audit's experiment runs reach no drive role.
- Leave removal to each project's own wiring — every project that follows the tag rule fills its disk by default.
- Keep a failed run's artifacts for debugging — the evidence already lives in logs and output, and the kept artifacts fill the disk.
