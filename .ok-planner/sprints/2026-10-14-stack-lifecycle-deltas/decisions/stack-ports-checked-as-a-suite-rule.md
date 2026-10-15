---
decision: stack-ports-checked-as-a-suite-rule
---

# A stack publishes each host port from a declared name and labels what it makes, under suite rules a lint checks

## Choice

The suite's coding rules require that every host port a stack definition publishes comes from an environment variable with a fallback, never a bare number; that each variable's name is a port name the project declares; and that no fallback falls inside the project's provisioning range. They also require that every docker container, image, volume, and network a stack makes carries the run's label from its environment variable (see also: run-artifacts-recorded-by-the-stack-tool). A project checks both rules with the suite's lint where the lint applies, with a project lint, or with both. The suite's lint checks compose files, in one check per rule, each on by default and off only where the project turns it off: the port check reads each published host port, and the label check reads each service, each image its builds make, and each named volume and network, the default network among them. A project lint also checks the suite's other lint rules: no prose comments, every citation resolves, and no test edits. A site that breaks either rule is a defect, and `/converge` fixes it.

## Rationale

A lease protects a run only where the stack binds the ports the lease names. A stack that publishes a bare number binds the same port in every run, so its concurrent runs collide. A stack whose fallback lies inside the range can, when started without the stack tool, take a port the registry leased to another run. A label lets the stack tool remove a run's docker objects only where the stack applies it, and an object made without it stays on disk with nothing to report it. Both rules hold for every project that uses the stack tool, so the suite states them once instead of leaving each owner to write them as practices. A written constraint needs a check that fails on violation. The suite's lint checks the one stack format it can read in every project, and a project whose stack takes another form checks both rules with a lint of its own. The cost: the suite's lint does not read a build command written outside a compose file, so only a project lint catches a missing label there.

## Alternatives

- A project practice each owner drafts — every project words and checks the rules its own way, or not at all.
- A prose rule with no check — a bare number or a missing label reaches a stack, and nothing fails until two runs collide or the disk fills.
- The stack tool inspects the stack definition when it starts a run — the break surfaces when a run starts, long after the edit that made it.
