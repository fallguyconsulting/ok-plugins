---
decision: declared-stack-profile
---

# Stack tailoring is detect, declare, materialize

## Choice

Plugins whose discipline varies by stack split the pipeline into three: a detection scan proposes a profile from repo signals; the committed profile in the estate is authoritative, written only as transcription of the owner's explicit answers (a single confirmation when detection is unambiguous); and converge materializes rules and scripts from the profile, never re-inferring at use time. Nothing a family materializes may depend on a declaration the project has not made. A scan/declaration mismatch is diagnosed drift whose reconciliation is the owner's act.

## Rationale

Detection is fallible and repos change; letting the scan decide would silently rewrite project behavior on every converge. Splitting observation from decision makes the committed profile a stable contract other tooling can trust, keeps materialization deterministic, and turns environment change into a visible, owner-resolved diagnosis instead of an ambush. Materialization that assumed an undeclared value would break exactly the projects that have declared the least, which is every project on its first converge.

## Alternatives

- Detect at use time, every time — behavior shifts silently when the repo shifts, and tools disagree mid-flight.
- Hand-written configuration with no detection — pushes stack archaeology onto every owner and invites stale declarations with no drift signal.
