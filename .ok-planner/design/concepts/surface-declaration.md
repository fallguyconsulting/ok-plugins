---
concept: surface-declaration
---

# Surface declaration

## What it is

A surface declaration is a project's owner-declared list of its
user-facing surface kinds, each paired with a mechanical enumeration
source that produces the kind's full population. It is the committed
answer to "what does this product expose to a user, and how is the
complete list obtained" — judgment exercised once by the owner, then
mechanical ever after.

## Purpose

The declaration drives the unconditional spine of the documentation
corpus: every enumerated element is cataloged whether or not any story
claims it, which is what makes absence answerable — a reader can trust
that what is not in the catalog does not exist. It also makes
completeness checkable rather than aspirational: the declared
enumerator defines the domain the catalog must match one-to-one.

## Boundaries

The declaration names kinds and their enumeration sources; the catalog
rows it drives, and the behavioral claims they carry, belong to the
documentation corpus. It is patterned on the owner-declared shape of
`stack-profile` but is its own artifact: the profile describes the
stack the project is built on, the declaration describes the surface
the product exposes. Candidate kinds detected but not declared are
reported to the owner, never auto-added. See also: `stack-profile`,
`documentation-corpus`.

## Invariants

- Every declared kind carries a mechanical enumeration source; no kind
  is populated by hand.
- The catalog over a declared kind matches its enumerated population
  one-to-one.
- An enumeration that errors or returns zero members fails loudly
  unless the kind is explicitly marked expected-empty.
- The declaration is owner-owned: detection may propose, only the
  owner declares.
