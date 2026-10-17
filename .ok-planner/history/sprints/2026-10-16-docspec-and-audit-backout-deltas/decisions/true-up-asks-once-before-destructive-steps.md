---
decision: true-up-asks-once-before-destructive-steps
---

# True-up asks the owner once, before any write, where its plan holds a destructive step

## Choice

The front door first runs the true-up core's diagnosis, which lists
every step the true-up would take. A step is destructive where it
deletes a file, moves a file into the archive, or rewrites a file a
person edited, which is every file but a suite-owned file that still
carries its stamp or its fixed content. Where the plan holds a
destructive step, the front door shows the owner the whole plan with
those steps marked and asks once: go ahead with all of it, or abort.
On abort, true-up writes nothing, and the project stays on the suite
version its stamps record. On go-ahead, true-up applies every step
with no further question of consent. A plan with no destructive step
runs with no question. After the plan runs, the front door asks only
for input: a value only the owner can give, such as the port range or
the citation tags; the wiring of hooks and the environment entry into
the project's harness settings; and a reword in a file the suite does
not own.

## Rationale

The current skills read only the current estate layout (see also:
skills-read-only-the-current-layout), so a true-up that takes some
steps and skips others leaves an estate no current skill reads
correctly. All of the plan or none of it are the two states that
work. One question at the start, over the whole plan, shows the owner
every file the run would delete, move, or rewrite at the moment the
owner is watching, and costs one answer. Abort is safe because the
project runs its own vendored copies (see also: per-project-pinning):
updating the front-door plugin changes nothing in the project, so a
project whose owner aborts keeps working at its stamped version. A
step that only rewrites a suite-owned file destroys nothing a person
wrote, so a question about it would have one answer on every run. The
input questions stay separate because only the owner holds their
answers, and a yes to the plan supplies no port range and no reword.

## Alternatives

- Ask about each destructive step on its own — many questions per
  true-up, and a declined step leaves the estate partly on a retired
  layout no current skill reads.
- Ask nothing, and let the invocation authorize every step — the
  owner learns which files moved or vanished only from the report,
  with no way to stay on the version the project has.
- Ask only where a step touches work git cannot restore — the owner
  learns of every other moved or rewritten file after the fact.
