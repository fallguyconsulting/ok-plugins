---
decision: tests-remove-what-they-create
---

# Each test removes the records it creates in its teardown

## Choice

A test removes the records it creates in its teardown, through the
product's removal action (see also:
tests-set-up-their-own-starting-state).

## Rationale

Removing what a test creates, through the action a user has for it,
leaves the next test a clean start, and the leftover counts catch what
a teardown misses (see also: leftovers-counted-around-each-round).

## Alternatives

- Remove what the tests create once, after the round: a test meets the
  records of every test before it, and a leak shows only at the
  round's end.
