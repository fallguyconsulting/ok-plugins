---
story: incremental-lint-adoption
---

# Adopt the lint on a legacy codebase without regressing

## Story

As an owner of a codebase that predates the lint, I want the violation backlog surveyed, clustered by shape, planned into passes, and held behind a one-way ratchet, so that I can adopt strict rules incrementally without stopping work and without ever moving backward.

## Acceptance

The owner drives the adoption verbs → a whole-repo report groups violations by check and by file; clusters of similar violations surface as single proposed bulk fixes; a port plan enumerates the passes to zero; a recorded baseline makes any change that increases the count fail in CI while any that holds or decreases it passes; and a starter proposal shapes the config from detected repo signals for the owner to confirm. All proposal verbs are read-only — nothing is applied without the owner.

## Falsifier

The violation count rises without a failure; proposals are bulk-applied without confirmation; the backlog is only readable violation-by-violation with no clustering or plan; or adoption requires disabling the checks.

## Proof

Demo — on a repo with a seeded backlog: a baseline recorded, a change adding one violation failing the ratchet check while a reducing change passes, and a clustered report plus port plan a third party can follow to drive one cluster to zero.
