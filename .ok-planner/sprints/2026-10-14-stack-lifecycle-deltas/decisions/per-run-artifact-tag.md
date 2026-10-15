---
decision: per-run-artifact-tag
---

# Artifact tags are minted per verification run, not derived from content

## Choice

ok-planner's stack tool mints the run tag when it starts a run: a fixed `run-` prefix followed by 12 random hex digits read from the operating system's random source, a fresh value for every run (see also: stack-tool-runs-each-run). The run builds every artifact it verifies under that tag, and the tool hands that one value to the run's commands through one environment variable the project declares. A verification path resolves its artifact by that value alone and fails loudly when the variable is unset or no artifact carries the tag.

## Rationale

Verification needs two properties: parallel runs must not collide on an artifact, and a run must verify the artifact it just built. A tag unique per run gives both directly. Content addressing gives both only as a side effect of a stronger claim, that identical trees produce identical tags on every machine. Beyond the two properties, that claim gives one thing more: reuse of an artifact across runs, which is a dev-loop convenience. Failing loudly is what makes staleness unrepresentable rather than merely avoided: a lookup that fell back to whatever was built last would restore the mutable-tag failure by another route.

## Alternatives

- A content-addressed tree hash — requires a definition of which files count as the tree; every non-code write, such as an audit record, moves the tag; and the cross-run reuse it gives is a dev-loop convenience, not a verification property.
- The commit hash — misses uncommitted changes, so a run verifies bits that are not the ones it built.
- A mutable tag such as `:latest` — names whatever was built last, which makes staleness representable.
