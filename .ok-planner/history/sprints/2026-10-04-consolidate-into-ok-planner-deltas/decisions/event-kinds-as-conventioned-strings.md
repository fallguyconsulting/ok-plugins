---
decision: event-kinds-as-conventioned-strings
---

# Event kinds are dotted-namespace strings, enforced by review and never linted

## Choice

The suite carries one events standard, materialized into each
project with a section of the always-in-context rules text as its
ambient copy. Code emits a structured event at every error caught, at
every owner frame's catch-all once for each raise it disposes, and at
every retry after the first. Each site is a construct a grep lists. A
state transition, a branch taken on external input, and a boundary
crossing are not sites of their own: a failed crossing raises to the
owner frame, and the owner frame's event names it. An event is a kind
plus structured fields; prose lives in a field, never in the kind. A
kind is a raw string literal in one fixed convention — dotted
namespaces in upper case, `SUBSYSTEM.NOUN.VERB` — declared nowhere
else and unique in meaning across the tree, so a grep for a kind from
a log line finds every site that emits it. Internal pure computation
that touches no state, no boundary, and no error emits nothing.

Review enforces the standard with the code open. The accept list
names the events standard among the rules whose breach it counts, so
a site the standard decides and the code breaks is a defect
`/converge` fixes. No lint checks events, and no inventory lists
them. Library, transport, levels, sampling, and wire format are the
project's own.

## Rationale

The literal is the wire value. A declaration adds a second name and a
hop, and an enum list grows and needs its own pruning. A convention
makes the literal itself the declaration, findable with one regex in
any language. A caught error that emits nothing is the failure that
costs most later.

Each site names a construct, so review can decide whether one is
missing. A state transition or a branch on external input names none:
an event added on that judgment is one reader's, not the code's, and
its absence is no breach anyone can decide.

Events serve someone debugging from a log with the code in hand: they
grep the kind from the log line and land on every site that emits it.
Uniqueness of meaning is what makes that grep complete, and it is not
lintable. A tree-wide list of kinds serves no one in that work. A rule
review reads but cannot file goes unenforced, so the accept list names
the standard as a source.

## Alternatives

- Enums or constants per module — a second name for the wire value;
  the list itself needs pruning.
- A read-only inventory of every kind with its sites — gives an author
  the population before adding a kind, and serves no one debugging
  from a log.
- Emitting at every state transition, external-input branch, and
  boundary crossing — wider coverage, and each such site rests on one
  reader's judgment.
- A lint enforcing coverage per path — language-specific, and
  "meaningful path" is not mechanically decidable.
- Free-form log lines — unfilterable; a reader greps prose.
- Prescribing the library or transport — a universal rule made
  stack-specific.
