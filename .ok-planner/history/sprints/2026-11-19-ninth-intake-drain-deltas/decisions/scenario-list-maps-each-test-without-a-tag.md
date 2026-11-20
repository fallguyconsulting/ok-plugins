---
decision: scenario-list-maps-each-test-without-a-tag
---

# The scenario list maps each scenario to its test, and a test file carries no tag

## Choice

A test file carries no tag: the scenario list maps each scenario to
its test, so the comment rule stays whole (see also:
scenario-list-decided-once).

## Rationale

Keeping the map in the list, not in the test files, leaves the tests
free of comments and lets a runner of any language name its tests its
own way.

## Alternatives

- A citation tag in each test file naming its scenario: the lint
  could resolve it, and every test carries a comment the comment rule
  otherwise forbids.
