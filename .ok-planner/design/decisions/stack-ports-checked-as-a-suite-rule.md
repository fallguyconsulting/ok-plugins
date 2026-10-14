---
decision: stack-ports-checked-as-a-suite-rule
---

# A stack publishes each host port from a declared name, under a suite rule a lint checks

## Choice

The suite's coding rules require that every host port a stack definition publishes comes from an environment variable with a fallback, never a bare number; that each variable's name is a port name the project declares; and that no fallback falls inside the project's provisioning range. A project checks the port rule with the suite's lint where the lint applies, with a project lint, or with both. The suite's lint checks compose files, in a check that is on by default and off only where the project turns it off. A project lint also checks the suite's other lint rules: no prose comments, every citation resolves, and no test edits. A site that breaks the rule is a defect, and `/converge` fixes it.

## Rationale

A lease protects a run only where the stack binds the ports the lease names. A stack that publishes a bare number binds the same port in every run, so its concurrent runs collide. A stack whose fallback lies inside the range can, when started without the allocator, take a port the registry leased to another run. The rule holds for every project that uses the allocator, so the suite states it once instead of leaving each owner to write it as a practice. A written constraint needs a check that fails on violation. The suite's lint checks the one stack format it can read in every project, and a project whose stack takes another form checks it with a lint of its own.

## Alternatives

- A project practice each owner drafts — every project words and checks the rule its own way, or not at all.
- A prose rule with no check — a bare number reaches a stack, and nothing fails until two runs collide.
- The allocator inspects the stack definition when it leases — the break surfaces when a run starts, long after the edit that made it.
