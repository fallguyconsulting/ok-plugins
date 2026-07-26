---
decision: lockstep-suite-version
---

# One suite version across all plugin manifests

## Choice

Every plugin manifest carries the same semantic version at every release, bumped together at the highest level any plugin's changes warrant, with one annotated repo-wide tag per release cut by the repo-local release skill. A release is done only when the release commit is reachable from the remote default branch and the tag points at it. Between releases manifests may drift while work is in flight; the release converges them. The conduct's version is the one carve-out: hand-managed and untouched by a release.

## Rationale

The plugins install à la carte but are designed as a set — the front door declares the others as dependencies, they share one integration contract, and a change in one routinely implies a change in another. A shared number is what makes "which versions work together" answerable; re-fetching identical files for an unchanged plugin costs nothing because the version is the harness's update key, and equality at release time is the property consumers actually depend on.

## Alternatives

- Independent semver per plugin — four drifting numbers make compatibility a question nobody can answer.
- Rejecting mid-cycle drift outright — turns a benign pre-release hand-bump into a release blocker for no consumer-visible gain.
- Per-plugin release tags — gives tag-based tooling an ambiguous answer for the repo.

## Proof

The release procedure's post-bump verification asserts every plugin manifest carries the new version before tagging. Falsifier: hand-edit one manifest to a different version after the bump step — the release's verification fails rather than tagging a mixed set.
