# Events: the standard

This standard governs the structured events the code emits: where it
emits, what an event is, and how a kind is named. Code review enforces
it: entry A8 of the accept list counts a breach of it as a defect. No
lint checks it.

## Where the code emits

The code emits an event at each of these sites:

- every error caught: a catch that stands under the Errors section of
  the plumbline cheatsheet emits on the caught path, or ends in a bare
  `raise` and leaves the emission to the owner frame above it;
- every owner frame: its catch-all emits one event for each raise it
  disposes;
- every retry: each attempt after the first.

Each site is a construct a grep lists: a catch block, an owner frame's
catch-all, a loop that calls the failing operation again. A state
transition and a branch taken on external input are not sites: neither
names a construct, and an event added on such a judgment is one
reader's, not the code's.

A boundary crossing — I/O, RPC, a process spawned or exited — is not a
site of its own. A failed crossing raises the library's error, and the
error propagates to the owner frame. The owner frame's event is the
event for the failed crossing. The project's event helper attaches the
stack trace to every caught-error event emitted while an exception is
in flight, so that event names the library, the type, and the line
that failed. The project names that helper in its own rules. A wrapper
emits on a crossing only where its catch stands under the Errors
section.

Internal pure computation that touches no state, no boundary, and no
error emits nothing. A caught error that neither emits nor re-raises is
a defect.

## What an event is

An event is a kind plus structured fields. Prose lives in a field,
never in the kind. A field carries one value under one name; a reader
filters on the kind and on any field without parsing text.

## How a kind is named

- A kind is a raw string literal at the site that emits it. It is
  declared nowhere else: no enum, no constant, no registry.
- A kind is a dotted namespace in one case, `SUBSYSTEM.NOUN.VERB` —
  for example `QUEUE.JOB.RETRIED`. Each segment starts with an
  upper-case letter and continues with upper-case letters and digits.
  The segments join with a dot.
- A kind is unique in meaning across the tree.

## What stays the project's

Library, transport, levels, sampling, and wire format are the
project's own choices. The standard governs the sites, the shape, and
the naming.
