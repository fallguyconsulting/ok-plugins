---
issue: materialized-artifact-stamp-fixed-content
kind: human
category: conflicting
artifacts:
  - concept:materialized-artifact
status: promoted
opened: 2026-07-28T01:12:01Z
sprint: 2026-07-27-source-graph-certification.md
---

# The version-stamp invariant does not fit fixed-content materialized artifacts

## Problem

`concept:materialized-artifact` commits to "Every materialized artifact
records the version of the payload that wrote it." The plumbline module
marker (`.ok-plumbline/package.json`, fixed content `{"type":"commonjs"}`)
is a suite-owned materialized file that carries no stamp: JSON has no
comment channel, and diagnose verifies its fidelity by exact content
instead. Read literally, the invariant's "every" is false by one member.
Two independent certification auditors examined the collision and
declined to charge it — one reasoning the invariant's staleness purpose
is delivered another way (content equality is a stronger check than a
stamp for a file that never varies), the other that the clause does not
cover a converge-generated literal — and both recorded that a rewording
would flip their determination. The conclusion is currently auditor case
law, re-derived at each close and sensitive to auditor temperament.

## Candidates

- Stamp the marker via an extra JSON key, keeping the invariant as
  written. Cost: the file's content changes per release, and diagnose's
  exact-content check becomes version-dependent churn.
- Amend the invariant to scope fixed-content artifacts: an artifact
  records the version of the payload that wrote it, or is fixed content
  whose fidelity diagnosis verifies exactly. Cost: one corpus delta, a
  slightly narrower "every".

## Ruling

Amend the invariant (the second candidate). A materialized artifact
records the version of the payload that wrote it, except a fixed-content
artifact — one whose bytes never vary across suite versions — whose
fidelity diagnosis verifies by exact content instead; content equality
already outperforms what the stamp exists to provide. The next
`/plan-sprint` drafts the corpus delta.
