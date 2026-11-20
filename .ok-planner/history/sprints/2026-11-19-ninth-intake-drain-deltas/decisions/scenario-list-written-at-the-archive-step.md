---
decision: scenario-list-written-at-the-archive-step
---

# A sprint writes the scenario list at its archive step

## Choice

A sprint's archive step writes the scenario list through the tests
tool: it stamps each story the sprint planned whose every planned
scenario has its test written, kept, or retired, or is a gap, and
clears the stamp of each other story the sprint planned (see also:
story-test-stamp-is-its-planned-blob). A story whose plan found
nothing to test still takes its stamp. It records the scenarios whose
tests the sprint wrote or kept: a planned new scenario whose test was
never written gets no record, and a scenario planned for a rewrite or
a retirement the sprint never made keeps its earlier record. It also
records the speed acceptances, the ranking, and the `reaches` lists
the sprint leaves (see also: scenario-list-decided-once).

## Rationale

Writing the list at the archive step records only the tests a closed
sprint wrote or kept, and a story with a planned test left unwritten
loses its stamp, so it reads as untested or stale, and planning offers
it where `testing.enabled` is `on` and `testing.offers` lists that
kind. A story whose plan found nothing to test still takes its stamp,
so the story leaves the untested offer and returns as stale once its
file changes: the stamp answers the story for the version the plan
read, and the owner is not asked the same question every sprint.

## Alternatives

- Each test task writes its scenario's record as it closes: a sprint
  that stops short leaves records of tests its certification never
  passed.
- A stamped story with no recorded scenario stays untested: a story
  with nothing to test returns in every untested offer.
- Record each story a plan gave no scenario as left without a test:
  the record never clears when the story's file changes, so a changed
  story hides from every offer.
