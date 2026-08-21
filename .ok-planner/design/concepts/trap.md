---
concept: trap
---

# Trap

## What it is

A trap is an assumption a user would reasonably hold, contradicted by
the product's actual behavior at a release — recorded as the
assumption, the actual behavior, and the warrant behind the
contradiction. It is the documentation corpus's statement "your
reasonable expectation is wrong here, and here is what is true
instead."

## Purpose

Traps are the creative core of documentation-as-assessment: the
divergence set between user expectation and product behavior is
precisely the content a user cannot derive from the product's surface
and the content that tests, written from the developer's side, do not
cover. A trap also doubles as a test-gap report — behavior no test
reaches, surfaced with the evidence in hand — making the trap registry
a standing critique of the project's suite.

## Boundaries

A trap is a contradicted *assumption*; a contradicted *promise* (a
story that does not work) is a defect and reaches the issue intake
instead. A trap's record splits along the vantage line: the shipped
statement speaks in surface terms — the assumption, the actual
behavior, and a surface demonstration where one exists — while the
full evidence set that warrants the contradiction, which may rest on
reading, is a verification-layer record that stays internal. See also:
`assumption`, `assessment`, `experiment`, `documentation-corpus`.
