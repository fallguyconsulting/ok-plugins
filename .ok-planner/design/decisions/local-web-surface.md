---
decision: local-web-surface
---

# The dashboard is a local web application

## Choice

The dashboard is a local web application: a page served over loopback
by a program the project runs on demand, on a loopback port the
operating system assigns unless the owner names one. It reads and
writes the intake through the intake's one module.

## Rationale

Working the intake needs the whole list in view, a thread per issue,
and keys to move through the queue and rule without leaving it. A
terminal report prints one issue per invocation and loses the reader's
place. An editor extension binds the surface to one editor's plugin
model. A local page carries the list and the thread together and runs
only while the owner runs it.

## Alternatives

- A terminal report per issue — composes with the suite's verbs, but flattens the queue into one dump per invocation.
- An editor extension — a strong reading surface, at the cost of an implementation per editor.
- A static site generated per project — no service to run, but it cannot accept a ruling or a comment.
