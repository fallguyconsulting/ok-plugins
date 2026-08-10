---
concept: surface-declaration
---

# Surface declaration

## What it is

A surface declaration is a project's owner-declared list of its
user-facing surface kinds, each paired with a mechanical enumeration
source that produces the kind's full candidate population. It is the
committed answer to "what kinds of things does this product expose,
and how is the complete list obtained" — judgment exercised once by
the owner, then mechanical ever after. The declaration is the
enumerating layer of a three-part surface structure: the declaration
enumerates, the surface guidance rules each element public or private,
and the surface ruling records the resulting partition.

## Purpose

The declaration defines the domain of the total partition that makes
absence answerable: every enumerated element must be ruled public or
private, and the public side drives the documentation catalog
unconditionally — every public element is cataloged whether or not any
story claims it, so a reader can trust that what is not in the catalog
does not exist. Completeness is checkable against the enumerators,
never aspirational.

## Boundaries

The declaration names kinds and their enumeration sources; how
elements are ruled belongs to the surface guidance, the recorded
partition to the surface ruling, and the catalog rows to the
documentation corpus. It is patterned on the owner-declared shape of
`stack-profile` but is its own artifact: the profile describes the
stack the project is built on, the declaration describes the surface
the product exposes. Candidate kinds detected but not declared are
reported to the owner, never auto-added. See also: `stack-profile`,
`surface-guidance`, `surface-ruling`, `documentation-corpus`.

## Invariants

- Every declared kind carries a mechanical enumeration source; no kind
  is populated by hand.
- Enumeration produces candidates, not publics: kinds whose medium has
  no native public/private notion contribute their whole population,
  and the guidance decides each member.
- An enumeration that errors or returns zero members fails loudly
  unless the kind is explicitly marked expected-empty.
- The declaration is owner-owned: detection may propose, only the
  owner declares.
