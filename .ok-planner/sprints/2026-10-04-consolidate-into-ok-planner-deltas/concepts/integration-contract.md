---
concept: integration-contract
---

# Integration contract

## What it is

The integration contract is the suite's normative spine: the one set
of conventions by which the suite's vendored layer meets a consumer
project and by which the front door administers it. It defines the
layers a project receives — the estate, the suite-owned rules files
every session loads, the vendored skills and agent profiles, and the
hook wiring in the project's committed harness settings — together
with the ownership rule that decides what the suite may write without
asking, and the version stamps that record which suite version wrote
each file.

## Purpose

The contract is what lets one administrator install, converge, and
repair every project the same way. The front door — the term names
the suite's administrator, and this Purpose is its canonical
definition — reads a project's presence against the contract and
converges it toward what the front door carries. The front door is
the suite's sole administrator, and administration is one process:
install, converge, repair.

## Boundaries

The contract governs how the vendored layer meets consumer projects
and how the front door administers it. It does not govern what any
skill does inside its own body. The user-scoped plugins — the front
door and the conduct — never integrate, so the contract does not
govern their presence on a machine. Repo-root machinery is
maintenance material and part of nothing the suite vendors. Its
layers are realized by neighboring concepts: estate, cheatsheet,
skill, true-up, materialized-artifact. "Front door" has no concept of
its own — this artifact defines it. The front door's administration is
the contract's consumer-side realization (see also:
converge-project-estate under stories).
