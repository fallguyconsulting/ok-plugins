---
decision: surface-intent-changed-by-sprints
---

# The surface intent changes only through a sprint, and nothing is public until the owner declares it

## Choice

The surface intent is owner intent: it changes only through a sprint's
approved delta, in final form, save the administrator's migrations,
which change no commitment (see also: final-form-deltas). Nothing is
public until the owner declares it. An element no rule or exception of
the intent makes public is internal, and planning asks nothing about
it; a new element of a class a rule already makes public is public by
that rule. The surface question opens in planning when the owner asks
to make something public, and when the drafted work declares a
docspec: the owner says what surface its documentation describes, and
the answer becomes a surface-intent delta in the same sprint. Each
rule is general, such as every endpoint of one interface, and names a
single element only where no general rule can say it. Where the intent
names the files that declare each class's members is a decision of its
own (see also: surface-members-listed-at-need).

## Rationale

Modules, internal interfaces, and tools a project builds for itself
far outnumber what it means to offer, so a surface that grows by
default makes every new helper a promise. Declaring only what is
public keeps the intent short and leaves nothing to track about what
is internal. Asking only when the owner or a new docspec raises the
question spends the owner's attention where intent is changing, and a
class rule carries every later member of the class without a question.
Changing the intent only through a delta gives the owner's sign-off
the same weight over the surface as over the corpus.

## Alternatives

- Ask the owner about every new user-facing element no rule claims —
  each element is classed before it ships, and every sprint asks about
  helpers the owner never meant to offer.
- Let the owner edit the intent freely — no ceremony, and the surface
  moves with no sign-off.
- Classify after the fact, filing an issue for each new element — the
  run proceeds, and the owner rules on each element cold, after it
  shipped.
