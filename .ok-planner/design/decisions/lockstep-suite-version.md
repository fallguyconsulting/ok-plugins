---
decision: lockstep-suite-version
status: as-is
---

# One suite version across all plugin manifests

## Choice

Every plugin manifest carries the same semantic version, bumped together at the highest level any plugin's changes warrant, with one annotated repo-wide tag per release cut by the repo-local release skill. A release is done only when the release commit is reachable from the remote default branch and the tag points at it. The conduct's version is the one carve-out: hand-managed and untouched by a release.

## Rationale

The plugins install à la carte but are designed as a set — the front door declares the others as dependencies, they share one integration contract, and a change in one routinely implies a change in another. A shared number is what makes "which versions work together" answerable; re-fetching identical files for an unchanged plugin costs nothing because the version is the harness's update key.

## Alternatives

- Independent semver per plugin — four drifting numbers make compatibility a question nobody can answer.
- Per-plugin release tags — gives tag-based tooling an ambiguous answer for the repo.

## Proof

No enforcing check exists today: nothing fails if a manifest is bumped alone or the versions drift apart between releases; the release procedure converges rather than rejects. Filed to the intake queue for owner calibration.
