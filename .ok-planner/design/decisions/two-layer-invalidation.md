---
decision: two-layer-invalidation
---

# Re-audit triggers are citations plus judged change inspection, never annotations

## Choice

What forces an audit to be re-derived is two layers reading the same
source graph. The mechanical layer needs no review: a cited node
identity that no longer resolves, a cited content hash that moved, or
a design artifact whose own hash changed invalidates the audit
outright. The judgment layer covers what anchors cannot see: an
inspector reads the change under certification — the diff itself,
working tree or commit range — and nominates the audits whose claimed
closures contain changed nodes; nominations are recorded on the audits
they implicate and adjudicated by the auditor, never auto-invalidating.
Code annotations play no part in either layer.

## Rationale

Citations alone under-invalidate: work added beside a cited span
breaks no hash, so a purely mechanical trigger is silent about
violations introduced in code no audit cited. Annotation-derived
triggers err in both directions at once, because they trust
self-reporting — a mis-tagged file invalidates strangers, an untagged
one invalidates nothing, and at file granularity one incidental tag
sweeps unrelated artifacts into every close. The change visible to git
is the only ground truth about what work happened, and mapping it to
the claims it bears on requires judgment — so an agent renders that
judgment, and what the gate consumes is the recorded adjudication,
never a tag. The two layers bound each other: the mechanical floor
fires regardless of anyone's opinion, and the judged layer's variance
is bounded by being candidacy — the auditor, not the inspector,
decides.

## Alternatives

- Annotation-derived touched sets — mechanical to compute, but
  inherits every annotation mistake and over-sweeps at file
  granularity.
- Pure citation staleness — fully deterministic, but blind to
  violations introduced in uncited code until the next whole-corpus
  pass.
- Re-deriving every audit at every close — sound and unaffordable;
  whole-corpus re-derivation is deliberately an owner-cadence act.
