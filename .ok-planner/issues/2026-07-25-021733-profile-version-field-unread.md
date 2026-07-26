---
issue: profile-version-field-unread
kind: discover
category: vestigial
artifacts:
  - concept:stack-profile
status: verified
opened: 2026-07-25T02:17:33Z
---

# The stack profile's `version` field is written once and read never

ok-workspaces' detector writes `version: 1` into every proposed profile. Nothing reads it back: the other `.version` references in the plugin's scripts read the *plugin's own* manifest version for artifact stamping — a different number doing a different job — and no code validates, branches on, or migrates by the profile's field. A committed profile with any value, or none, behaves identically. The field is schema-versioning machinery for a schema that has only ever had one version.

The corpus never sanctioned it: `concept:stack-profile` doesn't mention a schema-version field, and `decision:declared-stack-profile` records the detect→declare→materialize split without one. The classic motivation (migrate old profiles when the schema changes) is real in general but has never been exercised here, and an unread field is itself the pattern this intake keeps finding — capability without a consumer, looking load-bearing to readers.

## Options

- **Drop the field** — remove it from the detector's proposal; solve migration when a second schema version actually exists (at which point *absence* of the field cleanly identifies v1 profiles anyway).
- **Give it real semantics now** — define what a bump means and make diagnose/true-up check it. Speculative machinery, and a corpus invariant describing it would document behavior nothing performs — a fresh instance of this same issue shape.

The ruling decides: drop now, or build the versioning it implies.

## Ruling

> Recommended ruling (/verify-issues): drop the field — a sprint work item removes `version` from the detector's proposed profile; schema migration is designed when a second schema version actually exists, where absent-field-means-v1 gives a clean upgrade path regardless.
>
> Rationale: same grain as the other dead-capability rulings in this batch — unread machinery goes away rather than getting speculative semantics. Nothing is foreclosed: the day the schema changes, the field returns with a consumer attached and absence still identifies every old profile.

<!-- Owner: this is a recommendation, not your decision. Leave it
as-is to accept — the next /plan-sprint carries it, naming the
generated/recommended batches at sign-off. Edit the text to
redirect, empty the section to discuss live, or delete this note
to adopt the ruling as your own. -->
