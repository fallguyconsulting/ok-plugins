---
decision: per-run-artifact-tag
---

# Artifact tags are minted per verification run, not derived from content

## Choice

The tag script prints a fixed `run-` prefix followed by 12 random hex digits, and mints a fresh value on every invocation. The script is POSIX shell reading `/dev/urandom`, so it depends on nothing beyond a POSIX userland and reads no repository. A verification run invokes it once, builds every artifact it verifies under the printed tag, and hands that one value to its tests through one environment variable the project declares. A verification path resolves its artifact by that value alone and fails loudly when the variable is unset or no artifact carries the tag. A materialized tag script nothing consumes is an audit finding.

## Rationale

Verification needs two properties: parallel runs must not collide on an artifact, and a run must verify the artifact it just built. A tag unique per run gives both directly. Content addressing gave both only as a side effect of a stronger claim, that identical trees produce identical tags on every machine. Beyond the two properties, that claim gave one thing more: reuse of an artifact across runs, which is a dev-loop convenience. Failing loudly is what makes staleness unrepresentable rather than merely avoided: a lookup that fell back to whatever was built last would restore the mutable-tag failure by another route. An unconsumed script leaves the same hole while the estate looks compliant: the tag exists and nothing verifies through it. The audit reports it.

## Alternatives

- A content-addressed tree hash — requires a definition of which files count as the tree; every non-code write, such as an audit record, moved the tag; and the cross-run reuse it gives is a dev-loop convenience, not a verification property.
- The commit hash — misses uncommitted changes, so a run verifies bits that are not the ones under test.
- A mutable tag such as `:latest` — names whatever was built last, which makes staleness representable.
