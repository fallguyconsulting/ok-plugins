# Events: the standard

This standard governs the structured events the code emits: where it
emits, what an event is, and how a kind is named. Code review enforces
it. `/events` inventories the kinds; no lint checks them.

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
a review finding.

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
- A kind is unique in meaning across the tree. Before adding one, read
  the inventory and reuse the kind that already means the same thing.

## The inventory

`/events` lists every kind in the tree with the sites that reference
it. It flags a kind-shaped literal that breaks the format. It judges
nothing else: operators consume events outside the tree, so a kind
referenced at one site is not an unused one.

The scan reads every file under the path it is given. It skips the
ignored paths and prose files. The kind is a literal, so one regex
finds it in any language. The sites under a kind list by path, then by
line number.

The scan reports every file it did not read under three counts, each
count naming its paths: `unreadable` for a file or a directory the
scan could not open, `binary` for a file holding a NUL byte, and
`oversized` for a file over one megabyte. Such a file may hold an emit
site. The inventory is partial while any of the three counts
stands above zero.

The regex matches on shape alone. A dotted constant another system
owns carries that shape too, such as an Android intent action or a
Java class name. Such a literal is a scan false positive. Read every
flagged literal and rename only the kinds this project emits.

The scan treats a dotted literal as kind-shaped only when it carries
an upper-case segment. It flags `QUEUE.job.failed`. It passes over
`queue.job.retried` and `Queue.Job.Retried`. Over a tree whose
literals carry no upper-case segment, the inventory reports zero kinds
and zero violations. An empty inventory means no literal in the tree
matched the scan's shape. It settles nothing about conformance.

## What stays the project's

Library, transport, levels, sampling, and wire format are the
project's own choices. The standard governs the sites, the shape, and
the naming.

<!-- Materialized by ok-plumbline v23.0.0 — suite-owned; overwritten on converge; do not hand-edit. -->
