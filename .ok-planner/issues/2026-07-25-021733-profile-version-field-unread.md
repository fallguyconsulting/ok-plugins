---
issue: profile-version-field-unread
kind: discover
category: vestigial
artifacts:
  - concept:stack-profile
status: verified
opened: 2026-07-25T02:17:33Z
---

# The profile's version field is written but never read

## Problem

Detection emits a version field in the proposed profile but nothing anywhere reads or validates it.

## Candidates

- Amend concept:stack-profile Invariants to define the field's migration semantics
- Drop the field from the profile via a sprint

## Discussion

**The question.** `ok-workspaces`'s detection (`scripts/detect.js:45`) proposes a profile carrying `version: 1`, but no script in the plugin reads, validates, or branches on that field. Should the field be given real migration semantics (making it load-bearing), or dropped as dead weight?

**Evidence, re-verified — confirmed, field is write-only.** `plugins/ok-workspaces/scripts/detect.js:45` sets `version: 1` inside the proposed profile object. A search of every `.js` reference to `.version` in `plugins/ok-workspaces/scripts/` turns up exactly two hits — `diagnose.js:14` and `true-up.js:18` — and both are `JSON.parse(...).version` reads of the *plugin's own* `.claude-plugin/plugin.json` (the suite version, used for stamping materialized artifacts), not the *profile's* `version` field. Nothing in `diagnose.js` (drift detection) or `true-up.js` (materialization) inspects `profile.version` at all — a profile with `version: 1`, `version: 99`, or no `version` field would be treated identically by every consumer that exists today.

**What the corpus says.** `concept:stack-profile`'s What-it-is section describes the profile as "a plugin's committed, owner-declared description of the consumer project's stack" without mentioning a version field on the profile document itself (as distinct from the plugin's own suite version, which is a wholly different number per `concept:materialized-artifact` and `decision:per-project-pinning`). Its Purpose and Boundaries emphasize "detection proposes; the committed profile decides; materialization follows the profile" and that the profile is "written only as transcription of explicit in-conversation answers" — this bears on how the field *should* be treated if it exists (an owner-confirmed value, not a silently-detected one) but doesn't establish that a schema-version field is expected or required. `concept:true-up`'s Invariants state "converge is driven by committed declarations, never re-inferred at use time" and "migration moves files and never rewrites their bodies" — relevant if a future profile schema change needed to distinguish old-shape from new-shape committed profiles, which is the classic purpose of a schema version field, but nothing today exercises that path since there has been exactly one profile schema. `decision:declared-stack-profile` (bearing) records the detect→declare→materialize split's rationale in detail but doesn't mention a version field either.

**What the code does today.** The field is emitted once, at detection time, and then either transcribed into the committed profile verbatim (if the owner confirms) or discarded (if the owner amends the proposal) — from that point on it sits in the committed profile file unread by any of the plugin's own tooling.

**Candidates, and what each means.** Candidate 1 (define migration semantics in `concept:stack-profile` Invariants) would mean deciding what a version bump *means* — e.g., "a schema change to the profile's own shape increments `version`; `true-up` or `diagnose` checks it and offers a migration path for stale-shaped committed profiles" — and then actually implementing that check in `diagnose.js`/`true-up.js`, since a corpus invariant describing behavior that doesn't exist in code would itself become a new instance of the story this issue is about (a promise nothing enforces). This only pays off when the profile schema actually changes for the first time; until then it's speculative machinery. Candidate 2 (drop the field via a sprint) removes the dead weight now — edit `detect.js` to stop emitting it, and accept that if the profile schema changes in the future, migration will need to be solved then (e.g., via presence/absence of newer fields, or by reintroducing a version field at that point with real semantics from day one).

**What the ruling must decide.** Whether the profile's `version` field should be given real read/validation semantics now (in anticipation of future schema changes), or dropped as an unused field until an actual schema change makes a version marker necessary.

## Ruling

<!-- Owner: write your decision here in your own words.
The next /plan-sprint picks it up. Leave empty to discuss
it live in a planning session instead. -->
