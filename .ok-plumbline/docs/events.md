# Events: the standard

This standard governs the structured events the code emits: where it
emits, what an event is, and how a kind is named. Code review enforces
it under the certification code-review brief. `/events` inventories
the kinds; no lint checks them.

## Where the code emits

The code emits an event at each of these sites:

- every state transition;
- every branch taken on external input;
- every boundary crossed — I/O, RPC, a process spawned or exited;
- every retry;
- every error caught.

Internal pure computation that touches no state, no boundary, and no
error emits nothing. A caught error that emits nothing is a review
finding.

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
- A test waits on a kind by the same literal the product emits.

## The inventory

`/events` lists every kind in the tree with the sites that emit it and
the tests that wait on it, split by the project's test-path
convention. It flags a kind-shaped literal that breaks the format. It
calls out a kind referenced only from test files as an orphan. It
hands over the kinds no test waits on as a pruning list, never as a
finding. Operators consume events outside the tree, so such a kind is
not an unused one.

The scan reads every file under the path it is given. It skips the
ignored paths and prose files. The kind is a literal, so one regex
finds it in any language. The sites under a kind list by path, then by
line number.

The scan reports every file it did not read under three counts, each
count naming its paths: `unreadable` for a file or a directory the
scan could not open, `binary` for a file holding a NUL byte, and
`oversized` for a file over one megabyte. Such a file may hold an emit
site or a test. The inventory is partial while any of the three counts
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
matched the scan's shape test. It settles nothing about conformance.

The `tests` array in `.ok-plumbline/config.json` declares the test
paths. A declared array replaces the defaults. Declare every test path
the project keeps.

A `tests` entry ending in `/` names a directory run. The run matches
at any depth: `packages/*/test/` marks `x/packages/api/test/q.js` a
test path. A `*` matches within one segment.

An entry holding a `/` but not ending in one matches the whole
repo-relative path. `src/*_test.js` marks `src/queue_test.js` and
leaves `packages/api/test/queue.js` a product path.

An entry holding no `/` matches the file name at any depth. `*_test.*`
marks `src/queue_test.js` and `packages/api/queue_test.rb`. Every
default that names no directory — `*_test.*`, `*.test.*`, `*.spec.*`,
`test_*`, `*_spec.rb` — matches the file name.

## What stays the project's

Library, transport, levels, sampling, and wire format are the
project's own choices. The standard governs the sites, the shape, and
the naming.

<!-- Materialized by ok-plumbline v19.3.0 — suite-owned; overwritten on converge; do not hand-edit. -->
