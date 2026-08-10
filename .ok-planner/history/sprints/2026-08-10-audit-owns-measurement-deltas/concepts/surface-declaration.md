---
concept: surface-declaration
---

# Surface declaration

## What it is

A surface declaration is a project's owner-declared list of its
user-facing surface kinds — the committed answer to "what kinds of
things does this product expose". Each declared kind names what its
derivation reads, and its full candidate population lives as a
committed member list the audit's extraction maintains: derived
agentically at the run's opening, re-derived and diffed against the
committed list every run, drift walked with the owner. The
declaration is the enumerating layer of a three-part surface
structure: the declaration names the kinds, the surface guidance
rules each element public or private — and bounds extraction with
its pruning notations — and the surface ruling records the resulting
partition.

## Purpose

The declaration defines the domain of the total partition that makes
absence answerable: every enumerated element must be ruled public or
private, and the public side drives the documentation catalog
unconditionally — every public element is cataloged whether or not any
story claims it, so a reader can trust that what is not in the catalog
does not exist. Completeness is checkable against the committed
member lists and their per-run diffs, never aspirational.

## Boundaries

The declaration names kinds and what their derivations read; how
elements are ruled belongs to the surface guidance, the recorded
partition to the surface ruling, and the catalog rows to the
documentation corpus. It is patterned on the owner-declared shape of
`stack-profile` but is its own artifact: the profile describes the
stack the project is built on, the declaration describes the surface
the product exposes. Candidate kinds the extraction detects are
proposed to the owner at the opening walk, never auto-added:
detection proposes, only the owner declares. See also:
`stack-profile`, `surface-guidance`, `surface-ruling`,
`documentation-corpus`.

## Invariants

- Every declared kind's population lives in its committed member
  list; populations are never maintained by hand and never produced
  by a per-kind enumerator script.
- The members are re-derived agentically and diffed against the
  committed list at each audit run's opening, and drift reaches the
  owner — never the list silently.
- Extraction produces candidates, not publics: kinds whose medium has
  no native public/private notion contribute their whole population,
  and the guidance decides each member.
- A derivation that returns zero members fails loudly unless the kind
  is explicitly marked expected-empty.
- The declaration is owner-owned: detection may propose, only the
  owner declares.
