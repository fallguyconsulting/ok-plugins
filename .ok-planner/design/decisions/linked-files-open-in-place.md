---
decision: linked-files-open-in-place
---

# The dashboard shows a linked file over the issue

## Choice

The dashboard reads, and never writes, a project file the page asks
for, such as one an issue links, and shows it in a dialog over the
issue. It refuses a path outside the project root, inside the
repository's git directory, or ignored by git.

## Rationale

Showing a linked file over the issue keeps the owner in the queue
while checking its evidence. Refusing paths git ignores keeps local
secrets off the page.

## Alternatives

- A link opens the file in the owner's editor or on the git host — the owner leaves the queue to read the evidence.
- Links are plain text — the owner finds each file by hand.
