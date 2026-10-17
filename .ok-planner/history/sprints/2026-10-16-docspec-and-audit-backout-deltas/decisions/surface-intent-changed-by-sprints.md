---
decision: surface-intent-changed-by-sprints
---

# The surface intent changes only through a sprint, and planning checks new surface against it

## Choice

The surface intent is owner intent: it changes only through a sprint's
approved delta, in final form, save the administrator's migrations,
which change no commitment (see also: final-form-deltas). Planning
checks every new command, route, or other user-facing element the
drafted work introduces against the intent. An element no rule of the
intent claims is a question to the owner, and the answer becomes a
surface-intent delta in the same sprint. Where the intent names the
files that declare each class's members is a decision of its own (see
also: surface-members-listed-at-need).

## Rationale

New surface enters a project through planned work, so planning is the
moment the intent must move: the owner is present, and the work that
adds the element is drafted in front of them. Checking each new
element there settles its class before it ships, where a later check
finds it already depended on. Changing the intent only through a delta
gives the owner's sign-off the same weight over the surface as over
the corpus.

## Alternatives

- Maintain the intent in an interactive stage of a periodic run — the
  intent moves only when that run runs, and lags every change between
  runs.
- Let the owner edit the intent freely — no ceremony, and new surface
  ships unclassified unless the owner remembers to edit.
- Classify after the fact, defaulting each unclaimed element to
  internal and filing an issue — the run proceeds, and the owner rules
  on each element cold, after it shipped.
