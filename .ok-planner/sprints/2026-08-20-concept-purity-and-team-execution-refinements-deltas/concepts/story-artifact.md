---
concept: story-artifact
aliases:
  - story
---

# Story (artifact kind)

## What it is

A story is the design-corpus artifact kind that records a durable user expectation — what the product owes its users on an ongoing basis, stated as who needs what and why. The test for story status: years from now, a regression of the capability would be a defect a reasonable user would notice and complain about. Build records, migrations, and one-time changes are not stories.

## Purpose

Stories prevent high-level feature loss when individual tests miss end-to-end regression, and give a third party a single place to read what the product is for. They outlive specs, refactors, and library swaps because they describe the need, never the mechanism.

## Boundaries

A story owns the need — who wants what capability, and why — and nothing else: it is a pure expression of business value, one agile-style statement with no acceptance section, whose only acceptance is that the user has a way to do the capability and accomplish the benefit. It does NOT own the delivery surface or any mechanism — those are decision territory (see also: decision-artifact). Two stories describing the same user outcome through different surfaces are one story. Whether the product supports the story is the implementation audit's determination, taken from the user's side; where code carries the story, it says so with an annotation (see also: annotation).
