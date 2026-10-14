---
concept: integration-contract
---

# Integration contract

## What it is

The integration contract is the suite's normative spine: the one set
of conventions by which the suite's vendored layer meets a consumer
project and by which the front door administers it. It defines the
layers a project receives, together with the ownership rule that
decides what the suite may write without asking.

## Purpose

The contract is what lets one administrator install, upgrade, and
repair every project the same way. The front door — the term names
the suite's administrator, and this Purpose is its canonical
definition — reads a project's presence against the contract and
trues it up to what the front door carries. The front door is the
suite's sole administrator, and administration is one process, the
true-up, whether it installs, upgrades, or repairs.

## Boundaries

The contract governs how the vendored layer meets consumer projects
and how the front door administers it. It does not govern what any
skill does inside its own body. The contract does not govern what a
machine installs for its user (see also: vendored-skills under
decisions). Its layers are realized by neighboring concepts: estate, cheatsheet,
skill, true-up, materialized-artifact. "Front door" has no concept of
its own — this artifact defines it. The front door's administration is
the contract's consumer-side realization (see also:
true-up-project-estate under stories).
