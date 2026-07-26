---
concept: stack-profile
status: as-is
aliases:
  - profile
---

# Stack profile

## What it is

A stack profile is a plugin's committed, owner-declared description of the consumer project's stack — the languages, runtime isolation model, naming and path choices from which the plugin materializes its rules and scripts. Detection scans propose it from repo signals; the committed profile is what is authoritative.

## Purpose

The profile separates observation from decision: detection never silently decides, declaring is deciding rather than typing, and converge is driven by the committed declaration instead of re-inference at use time. A scan/declaration mismatch is diagnosable drift whose reconciliation is the owner's act.

## Boundaries

The profile is owner-decided content — written only as transcription of explicit in-conversation answers, never a field the owner didn't confirm (see also: whole-file-ownership under decisions, true-up). Values pointing outside plugin defaults are declarations, not drift. What gets materialized from it belongs to materialized-artifact and cheatsheet; the detect → declare → materialize shape is the recorded choice (see also: declared-stack-profile under decisions).

## Invariants

- Detection proposes; the committed profile decides; materialization follows the profile.
- Confident detection is put to the owner as a single confirmation; questions are spent only on genuinely ambiguous signals.
