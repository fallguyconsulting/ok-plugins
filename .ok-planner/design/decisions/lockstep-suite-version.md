---
decision: lockstep-suite-version
---

# One suite version across all plugin manifests

## Choice

Every plugin manifest carries the same semantic version at every release, bumped together at the highest level any change in the suite warrants, with one annotated repo-wide tag per release cut by the repo-local release skill; the carried payload is stamped with that same suite version wherever it materializes. The release act itself is mechanical: it changes only release-mutable metadata — the manifest version fields, the stamps a re-converge rewrites, and the conduct's version stamp — plus the release commit and tag, verifies itself with deterministic assertions alone (manifest equality, remote installability), and neither runs nor re-derives implementation audits; the sole judgment a release holds is the semver level. A release is done only when the release commit is reachable from the remote default branch and the tag points at it. Between releases manifests may drift while work is in flight; the release converges them. The conduct carries a version of its own, apart from the suite version: where the conduct's body changed since the stamp last moved and the stamp did not move, the release advances its minor version and its animal; a stamp that already moved stays as it is, and a conduct major is its author's to land with the change.

## Rationale

The plugins and the family the front door carries are designed as a set: one integration contract, one administrator, and a change to the carried family routinely implies a change to the front door that converges it. A shared number is what makes "which versions work together" answerable, and equality at release time is the property consumers actually depend on. Correctness is established where it belongs, at sprint certification: by release time the tree is already certified, so any verification beyond deterministic assertions would re-buy what certification already paid for, at the moment of least new information. The conduct's minor bump is mechanical too, a fixed rule over a diff, so the release makes it; the author keeps the one judgment the number holds, a major.

## Alternatives

- Independent semver per plugin, or for the carried family apart from the front door — drifting numbers make compatibility a question nobody can answer.
- Rejecting mid-cycle drift outright — turns a benign pre-release hand-bump into a release blocker for no consumer-visible gain.
- Per-plugin release tags — gives tag-based tooling an ambiguous answer for the repo.
- A release gate that re-audits or re-certifies — duplicates certification's work inside an act whose whole value is being cheap, repeatable, and mechanical.
- A hand-managed conduct version the release only warns about — puts a manual step back into an act whose value is being cheap, repeatable, and mechanical.
