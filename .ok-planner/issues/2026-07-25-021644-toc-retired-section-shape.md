---
issue: toc-retired-section-shape
kind: discover
category: inconsistent
artifacts:
  - concept:catalog-toc
status: verified
opened: 2026-07-25T02:16:44Z
---

# The reviewer checks for a "Retired" TOC section no generator ever emits

The design-doc compliance reviewer checks that "Retired-only entries belong in the 'Retired' section, not the live list" of each catalog TOC. But the TOC generator (`discover-design` step 7) has no Retired section in its template and no `_retired/` handling at all, and `concept:catalog-toc`'s own body never mentions retired entries. The check verifies conformance to a format that no artifact defines and no generator produces — it can only ever pass vacuously or misfire.

This is one half of a single underlying question, shared with the sibling issue `retirement-mechanics-diverge`: does retiring a corpus artifact *delete* the file (as the planning ceremony and `concept:corpus-delta` say) or *archive* it into `_retired/` (as the reviewer's checks presuppose)? If deletion, there are never retired entries and the Retired-section check is dead prose to remove. If archival, `concept:catalog-toc` needs to define the section's shape and the generator needs to emit it. The two issues must land the same way.

## Options

- **Retirement is deletion** — drop the Retired-section check (and the `_retired/` carve-outs) from the reviewer prompt; `concept:catalog-toc` stays as written, correctly silent.
- **Retirement is archival** — define the Retired-section format in `concept:catalog-toc` and make the generator emit it; the check becomes meaningful.

The ruling decides: the same delete-vs-archive choice as `retirement-mechanics-diverge`, applied to the TOC surface.

## Ruling

> Recommended ruling (/verify-issues): retirement is deletion — the same ruling recommended on `retirement-mechanics-diverge`: strip the Retired-section check and `_retired/` references from the reviewer prompt; `concept:catalog-toc` and the generator stay as they are.
>
> Rationale: `design/` is current-state-only with git history as the archive, so no retired entries can ever exist for a TOC section to hold; the check guards a convention the corpus never adopted. Whichever way the owner rules the sibling, this issue must follow it — the two are one decision.

<!-- Owner: this is a recommendation, not your decision. Leave it
as-is to accept — the next /plan-sprint carries it, naming the
generated/recommended batches at sign-off. Edit the text to
redirect, empty the section to discuss live, or delete this note
to adopt the ruling as your own. -->
