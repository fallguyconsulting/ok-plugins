---
decision: issue-writes-through-one-module
---

# Every intake write goes through one locking module

## Choice

Every reader and writer of the intake goes through one module: the
filers, humans included, triage, the planner, the defect runs, the
front door's migration, and the dashboard's service. The module serializes every write under an exclusive lock
and applies each change to the file as reread under that lock, and it
refuses a record that breaks the schema, naming its line. Nobody
edits the intake by hand.

## Rationale

Triage agents run in parallel, and the service writes while a run
works. A writer that skips the lock, or writes from a copy it read
before taking it, erases another writer's change. One module that
validates every record keeps every reader and writer on one schema.

## Alternatives

- Agents edit the file by hand — lost writes under concurrency, and the schema drifts writer by writer.
- A long-running service owns the file and every writer calls it — every run would need the service running.
