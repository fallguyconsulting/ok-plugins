---
decision: surface-members-listed-at-need
---

# Surface members are listed from the tree when needed, never stored

## Choice

For each class of entry point, the surface intent names the files
that declare the class's members, such as a command table or a route
table. No stored list of surface members exists: no extraction file, no map,
no index of entry points. Whoever needs a class's members lists them
from the tree at that moment, starting from the files the surface
intent names as declaring the class. A builder who writes reference
documentation lists the members of each class its docspec names as it
writes, and sprint certification lists them again to check that the
documentation misses none. A defect run cuts its flow areas from the
declaring files on each run (see also: analysis-hunts-until-converged).

## Rationale

Every stored artifact a project keeps is one more source of drift. A
stored map or index of the surface must itself be checked and
regenerated, and costs more to keep current than it saves. A list made
at the moment of need answers from the tree as it stands, so it cannot
be stale. Naming the declaring files in the surface intent gives every
listing a known place to start, so it reads a few files instead of
walking the whole tree. Certification's second listing checks the
builder's against the same tree, at the cost of one more reading.

## Alternatives

- A surface extraction stored per run — one walk serves every reader
  of that run, and the file is stale from the first change after it.
- An entry-point list each sprint maintains — cheap to read, and a
  second record every sprint must keep in step with the code.
- An enumerator command per class — deterministic where it applies,
  and itself software the owner writes and that drifts unchecked.
- Name only the classes in the intent, and have each reader search the
  tree for their members — nothing more to keep current, and two
  readers can find different members of one class.
