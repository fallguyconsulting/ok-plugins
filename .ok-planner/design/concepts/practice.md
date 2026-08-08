---
concept: practice
---

# Practice

## What it is

A practice is an affirmative statement of what a codebase does about
some members of a subject: what the code is, the condition under which
the practice governs, and the maintenance operation the practice buys.
Practices are cited from the sites they govern, so a reader meeting a
construct finds the practice that accounts for it instead of
re-deriving the intent.

## Purpose

Stating policy affirmatively makes a departure a claim rather than a
hole. A site that does not follow one practice is governed by another,
and which one applies is something a reviewer can check and can be
wrong about — where silencing a check asserts nothing and so can never
be refuted.

## Boundaries

A practice governs members of exactly one subject and never names the
population itself (see also: subject). It states what the codebase
does, not how well it does it: a practice whose benefit only taste can
settle is a style preference and belongs to formatting. Its
verification is coverage over its subject rather than a per-artifact
verdict (see also: finding).

## Invariants

- Every practice names the maintenance operation it buys, concretely
  enough that a reader can settle whether that operation holds.
- Every practice names the condition under which it governs, so a
  reader can tell which of a subject's practices applies to a member
  without asking its author.
- Where more than one condition matches a member, the more specific
  condition governs; equally specific conditions that conflict are a
  collision for the owner, not a precedence puzzle.
- A practice is never written as an exception to another practice, and
  no site is exempted by suppression.
