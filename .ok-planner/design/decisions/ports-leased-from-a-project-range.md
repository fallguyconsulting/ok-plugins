---
decision: ports-leased-from-a-project-range
---

# A verification stack's host ports are leased from the project's own range

## Choice

A project that leases its verification stacks' host ports names the ports in its ok-planner configuration, by name, and one provisioning range of host ports that lies below the machine's ephemeral range and belongs to that project alone. The suite's port registry leases a free batch from the range to a run tag, one port per name, under one lock. It treats a port as taken where a program holds it over TCP or over UDP, or where a docker container publishes it, and it skips every port on its block list: the suite's own list of the ports that protocols, apps, and services use by default, and every port the machine's services database lists. It records the lease in the project's registry and prints the ports, one per name. The lease ends when its caller releases it. The registry lists each stale lease, one at least an hour old none of whose ports a program holds, so a cleanup can release it. A project that declares no port names leases nothing. The registry refuses to lease until a project that declares port names has a range, and refuses where the range holds too few free ports for the names. The registry serves one checkout of the project. The reference stack tool leases its runs' ports from the registry and passes them to its start command's environment, and a run of a project that declares no port names goes on with no ports. A bind failure in the start command is loud: the tool takes the run down and starts it again with a fresh batch. The tool releases a run's ports when it takes the run down, and its cleanup frees a crashed run's lease with the rest of the run (see also: run-artifacts-removed-with-the-run).

## Rationale

A run reads another run's result only when a port it was given passes to that other run. Under ports the operating system assigns, every stack draws from the machine's ephemeral range, and nothing keeps a freed port from the next run that asks; a run whose server stopped then reads back its old port and verifies against another run's server. A lease keeps a port away from every other run of the project until the lease ends. A run whose server stopped reaches a port nothing listens on, and its checks fail instead of passing against someone else's server. A program outside the scheme can still bind a leased port between the lease and the stack's bind. Treating a port as taken over either protocol, or where a container publishes it, narrows that window, since a server may listen over UDP alone and a container docker has not started still claims the port it publishes. A range below the ephemeral range keeps the operating system's own picks out of it, the block list keeps the range off the ports other software binds by default, and a loud bind failure with a fresh batch closes what remains. A range per project keeps projects apart, since no project reads another's registry. A registry usable alone serves a project whose own tooling starts its stack, which gains the lease without the rest of the reference tool. The costs: a lease whose caller crashed waits for a cleanup that releases it, a run whose stack stopped while its checks still run can lose its lease to a cleanup an hour after its start and see its port pass to another run, an exhausted range refuses, two projects that share a range can collide, and a second checkout of the project keeps a registry of its own.

## Alternatives

- Ports the operating system assigns, read back by the run tag — a stopped server's port can pass to another run, and the read-back then verifies against that run's server.
- Probe a read-back port before reporting it — another run's server may already listen on the freed port, so the probe passes.
- Treat a port as taken only where it fails to bind over TCP — a server listening over UDP, or a container docker has not started, loses its port to another run.
- Record the server's process id beside its port — a wrapper reports its own id, a container's id belongs to another namespace, and the operating system reuses ids.
- Hash the run tag to a port block — two tags can land on one block.
- One registry for every project on the machine — every project must agree on one store outside its own tree.
