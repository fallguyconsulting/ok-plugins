---
decision: stack-helpers-serve-project-commands
---

# The process runs each project's own stack commands, and the suite ships optional helpers

## Choice

ok-planner's process runs the stack commands each project names in its
review facts: the drive and the audit's deployments start, reach, and
stop a stack only through those commands. The suite ships helpers a
project may call from its own commands, each usable alone: a tag
generator, a port registry, a docker sweep, and a process-group
helper. It also ships a reference stack tool built from the helpers,
which a project with no stack tooling of its own may name as its
commands (see also: reference-stack-runs-the-declared-stack). No
prompt of the drive or the audit names a helper or reads the stack the
configuration declares.

## Rationale

A project that already runs its own stack tooling keeps it working,
and adopts a helper where the helper fixes a harm it has, when it
chooses. The drive and the audit each keep one path, the project's
commands, instead of one path for the suite's tool and another for the
project's.
The helpers carry the steps a project's tooling most
often gets wrong: releasing a lease, finding what a run built, and
stopping what a start forked. A project adopts each one without
rewriting the rest. The cost: a project whose own tooling skips a step, such as a
cleanup, keeps that harm until it adopts a helper.

## Alternatives

- One stack tool runs every verification run, under rules the lint checks — every project rewrites its stack tooling to fit the tool before the process works for it.
- The project's commands alone, with no helpers — every project builds its own tag, lease, and cleanup, and each breaks on its own.
- The project's commands call the reference stack tool's verbs in a fixed order — every project must call them in that order, and a project that misses a call breaks the run's life.
