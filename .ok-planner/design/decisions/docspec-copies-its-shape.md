---
decision: docspec-copies-its-shape
---

# Each docspec copies its shape from a suite template when it is declared

## Choice

A docspec states the shape of its documentation at two levels: the
layout, how the files of its section split up, and the shape of one
file, its parts in order and what each part holds. The suite carries
a few shape templates (reference, tutorial, how-to, overview). When
planning declares a docspec, it proposes the template that fits, the
owner adjusts it, and the docspec carries the result as its own text.
The docspec never names its template, so a later template change
reaches a project only through a sprint's docspec delta.

## Rationale

Generated documentation wanders, with facts and topics in no
particular order, and the writing standard governs sentences, not
their order. A shape gives the writer and the style pass a fixed order
to follow and check. Templates spare the owner from inventing a shape
for each kind of documentation. Copying keeps the docspec owner
intent: a suite release never changes what a project's documentation
looks like behind the owner's back.

## Alternatives

- The docspec names its template, with any changes — template
  improvements reach every docspec at the next true-up, and a suite
  release changes owner intent with no sprint.
- No shapes; the writing standard alone — nothing to declare, and
  structure wanders with each writer.
