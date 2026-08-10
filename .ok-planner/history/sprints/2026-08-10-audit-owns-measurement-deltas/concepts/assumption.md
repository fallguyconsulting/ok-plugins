---
concept: assumption
---

# Assumption

## What it is

An assumption is a user-vantage prior: something a user would take to
be true about a product before anyone checks, written down before it is
verified. It is formed exclusively from what a user could see — the
story catalog as delivered, the published concept layer, the ruled
public surface, the prior release's published documentation — never
from source, tests, or internal design material. Assumptions are
story-shaped records the audit run owns: formed cold by the run's
boxed synthesizer after the story determinations land, recorded beside
the audit corpora, verified in the same run by the same user-vantage
instrument as stories, and regenerated fresh each run — no standing registry is maintained.

## Purpose

Assumptions make trap-hunting semi-systematic. The gap between what a
user expects and what the product does is where documentation's
highest-value content lives, and that gap can only be seen from the
user's side. Writing the expectation down before measuring it keeps the
measurement honest: the expectation cannot be quietly softened to match
what was found. Assumption sources are enumerable — names that promise
observable behavior, symmetry between sibling elements, conventions of
the craft, expectations derived from published concepts, ecosystem
priors — so generation is creative in selection but systematic in
coverage. Forming and measuring them in the audit puts traps on the
owner's audit cadence instead of waiting for a release.

## Boundaries

An assumption is not a story: a story is a promise the owner committed
to, an assumption is a prior the user would hold — different kinds, not
grades of one kind. The difference governs what a contradiction means:
an unmet story is work, a contradicted assumption is documentation — a
trap disposition the documentation ceremony consumes, never a fix
issue. An assumption is not a trap until measurement contradicts it;
one that holds earns attested silence. See also: `story-artifact`,
`trap`, `assessment`, `surface-ruling`, `documentation-corpus`.

## Invariants

- An assumption is formed cold: only user-visible inputs, mechanically
  enforced.
- It is written down before any verification of it begins.
- Every synthesized assumption is recorded with its disposition —
  held, trap, or unverified — never silently dropped.
- The assumption set is re-derived fresh at every audit run; no
  standing registry is maintained.
- A contradicted assumption files nothing by itself; where its
  diagnosis shows a story is also violated, that is a story finding
  on the story's own track.
