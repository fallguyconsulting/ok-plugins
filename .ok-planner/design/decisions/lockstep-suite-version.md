---
decision: lockstep-suite-version
---

# One suite version across all plugin manifests

## Choice

Every plugin manifest carries the same semantic version at every release, bumped together at the highest level any change in the suite warrants, with one annotated repo-wide tag per release cut by the repo-local release skill; the carried family payload is stamped with that same suite version wherever it materializes. A release is done only when the release commit is reachable from the remote default branch and the tag points at it. Between releases manifests may drift while work is in flight; the release converges them. The conduct's version is the one carve-out: hand-managed and untouched by a release.

## Rationale

The plugins and the families they carry are designed as a set — one integration contract, one administrator, and a change in one family routinely implies a change in another. A shared number is what makes "which versions work together" answerable; re-fetching identical files for an unchanged plugin costs nothing because the version is the harness's update key, and equality at release time is the property consumers actually depend on.

## Alternatives

- Independent semver per plugin or per family — drifting numbers make compatibility a question nobody can answer.
- Rejecting mid-cycle drift outright — turns a benign pre-release hand-bump into a release blocker for no consumer-visible gain.
- Per-plugin release tags — gives tag-based tooling an ambiguous answer for the repo.
