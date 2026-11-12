---
decision: speed-acceptance-outlives-support-changes
---

# A speed acceptance holds until the test's own file changes

## Choice

A speed acceptance records that a reader found no waste in a test. It
holds across sprints until the test's own file changes, and a change
to a test support file the test lists does not clear it. An accepted
test counts as unreviewed again only where a test support file it
lists changed since its acceptance and its median seconds rose (see
also: speed-ranked-by-median-seconds).

## Rationale

A test support change on one project moved the digests of 1,026 tests
whose own files had not changed, so an acceptance keyed to test
support files would send each of them back to a reader. A test
support change that slows an accepted test still sends that one test
back.

## Alternatives

- Clear an acceptance whenever a test support file the test lists
  changes: one shared change sends a thousand accepted tests back to a
  reader.
- An acceptance that holds whatever changes: a test whose own file
  changed keeps a verdict no reader gave its new version.
