---
concept: integration-contract
---

# Integration contract

## What it is

The integration contract is the suite's normative spine: the single set
of conventions by which every skill family meets a consumer project, by
which the front door administers them all, and by which the suite's
ceremonies cover them all. It defines the layers of a family's presence
— the committed project-side estate whose existence is the discovery
marker, the always-in-context rules cheatsheet, the vendored skill set
in the project's committed skills directory, and hook wiring transcribed
into the project's committed harness settings — plus each family's
conventional surfaces (a deterministic converge core and an
administration document for the judgment the core cannot encode, and a
ceremony surface carrying what planning, certification, audit, and
documentation need to know about that family's corpus), the ownership
rule, the vendored-name collision rule, version stamps, and stack
tailoring.

## Purpose

The contract is what keeps the suite composable as it grows: family
knowledge lives in the family's own directory at the contract's
conventional surfaces, so the front door — the term names the
administrator plugin, and this Purpose is its canonical definition —
administers every family by driving those surfaces, and the suite's
ceremonies cover every family by driving theirs. Adding a family means
adding a conforming directory, never rewriting the administrator and
never editing a ceremony. The front door is the suite's sole
administrator, and administration is one process: install, converge,
repair.

## Boundaries

The contract governs how families meet consumer projects, how the front
door administers them, and how the suite's ceremonies reach them; it
does not govern any family's interior behavior, and the user-scoped
plugins — the front door and the conduct — never integrate, so it does
not govern their presence on a machine. Repo-root machinery — the
marketplace catalog, the contract's own document, the release tooling,
the maintenance checks — is maintenance material and part of no plugin
or family. Its layers are realized by neighboring concepts:
skill-family, estate, cheatsheet, skill, true-up, materialized-artifact,
stack-profile. "Front door" has no concept of its own — this artifact
defines it. The front door's own conduct is the contract's consumer-side
realization (see also: one-command-suite-upkeep under stories).

## Invariants

- Every family exposes the conventional surfaces the suite drives —
  administration and ceremony alike; families expose no administration
  verbs of their own, and no ceremony verbs of their own.
- Vendored verb names collide by rule, never by accident: a verb name
  claimed by more than one integrated family materializes
  family-prefixed.
- Whether a project uses a family is a filesystem check, never an
  inference, and it is answered when a verb runs rather than when it
  is vendored.
- Every discovery marker the front door honors is documented in the
  contract; the contract, not the administrator's prompt, is where the
  convention lives.
- Nothing in any family may assume a specific consumer project, and
  nothing a family materializes into one may depend on a declaration
  that project has not made.
