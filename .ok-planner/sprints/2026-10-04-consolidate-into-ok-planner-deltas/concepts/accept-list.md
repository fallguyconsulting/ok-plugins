---
concept: accept-list
---

# Accept list

## What it is

The accept list is the enumerated set of harms that decides what a
review counts as a defect. What the list leaves standing stands. The list judges harm, never shape: a site that
looks like a defect and cannot cause a named harm is not one.

## Purpose

The list gives every agent in a review — whoever finds, fixes, or
checks a defect — the same test for "is this a defect?". What a run fixes then
does not depend on who read the code, and a run that has fixed
everything on its list can end. A site the list does not cover needs
no ruling, so a review can run without the owner.

## Boundaries

The list owns which harms count. It may count a breach of a rule the
project states where that rule leaves one compliant form (see also:
accept-list-decides-defects under decisions). A harm the list does not
name is a proposal to change the list, never a defect (see also:
defect). The certification of a sprint also counts that sprint's own
promises, which come from the sprint, not from the list (see also:
sprint). Whether a fix may change what a user across a release boundary
observes is not the list's question (see also: release-boundary).
