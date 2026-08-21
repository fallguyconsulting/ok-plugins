---
decision: lockstep-suite-version
---

# One suite version across all plugin manifests

## Choice

Every plugin manifest carries the same semantic version at every release, bumped together at the highest level any change in the suite warrants, with one annotated repo-wide tag per release cut by the repo-local release skill; the carried family payload is stamped with that same suite version wherever it materializes. The release act itself is mechanical: it changes only release-mutable metadata — the manifest version fields and the stamps a re-converge rewrites — plus the release commit and tag, verifies itself with deterministic assertions alone (manifest equality, remote installability), and neither runs nor re-derives implementation audits; the sole judgment a release holds is the semver level. A release is done only when the release commit is reachable from the remote default branch and the tag points at it. Between releases manifests may drift while work is in flight; the release converges them. The conduct's version is the one carve-out: hand-managed and untouched by a release, which warns when the conduct's body changed without a bump and does nothing further.

## Rationale

The plugins and the families they carry are designed as a set — one integration contract, one administrator, and a change in one family routinely implies a change in another. A shared number is what makes "which versions work together" answerable, and equality at release time is the property consumers actually depend on. Correctness is established where it belongs, at certification: by release time the tree is already certified, so any verification beyond deterministic assertions would re-buy what the gates already paid for, at the moment of least new information. A warning keeps the conduct's number its author's to set. It still surfaces a changed body under an unchanged version, at the one moment anyone is reading versions.

## Alternatives

- Independent semver per plugin or per family — drifting numbers make compatibility a question nobody can answer.
- Rejecting mid-cycle drift outright — turns a benign pre-release hand-bump into a release blocker for no consumer-visible gain.
- Per-plugin release tags — gives tag-based tooling an ambiguous answer for the repo.
- A release gate that re-audits or re-certifies — duplicates certification's work inside an act whose whole value is being cheap, repeatable, and mechanical.
