---
decision: ports-leased-from-a-project-range
---

# A verification stack's host ports are leased from the project's own range

## Choice

A project's ok-planner configuration names the host ports its verification stack expects, by name, and one provisioning range of host ports that lies below the machine's ephemeral range and belongs to that project alone. When a run starts its stack, ok-planner's port allocator leases a free batch from the range to the run tag, one port per name, under one lock. The allocator skips every port a program already holds and every port on its block list: the suite's own list of the ports that protocols, apps, and services use by default, and every port the machine's services database lists. It writes the lease to a registry in the project's cache and prints the ports, one per name, for the stack's start to pass to the stack's environment. The services do nothing special: a container stack runs as the compose project the run tag names and publishes each host port from its name, and a server outside compose takes its port from the environment or a flag. A bind failure is loud, and the run retries with a fresh batch. A lease ends when the run's stack goes down. A cleanup step, run periodically, such as after a batch of drives, frees each lease at least an hour old whose ports nothing holds and whose compose project has no containers left. The allocator refuses to lease until the project has a range, and refuses where the range holds too few free ports for the declared names. The registry serves one checkout of the project.

## Rationale

A run reads another run's result only when a port it was given passes to that other run. Under ports the operating system assigns, every stack draws from the machine's ephemeral range, and nothing keeps a freed port from the next run that asks; a run whose server stopped then reads back its old port and verifies against another run's server. A lease keeps a port away from every other run of the project until the lease ends. A run whose server stopped reaches a port nothing listens on, and its checks fail instead of passing against someone else's server. A program outside the scheme can still bind a leased port between the lease and the stack's bind. Skipping held ports narrows that window, a range below the ephemeral range keeps the operating system's own picks out of it, the block list keeps the range off the ports other software binds by default, and a loud bind failure with a retry closes what remains. A range per project keeps projects apart, since no project reads another's registry. The hour of grace keeps a run that is still building, with no container yet, from losing its lease. The costs: a crashed run's lease waits for a cleanup at least an hour later, a live run whose server outside compose stopped more than an hour after its lease can lose the lease to a cleanup and see its port pass to another run, an exhausted range refuses, two projects that share a range can collide, and a second checkout of the project keeps a registry of its own.

## Alternatives

- Free every lease whose ports nothing holds and whose compose project has no containers, whatever its age — a run still building its images loses its lease.
- Ports the operating system assigns, read back by the run tag — a stopped server's port can pass to another run, and the read-back then verifies against that run's server.
- Probe a read-back port before reporting it — another run's server may already listen on the freed port, so the probe passes.
- Record the server's process id beside its port — a wrapper reports its own id, a container's id belongs to another namespace, and the operating system reuses ids.
- The stack's stop command deletes its port records — a crashed server runs no stop command and leaves its record.
- Hash the run tag to a port block — two tags can land on one block.
- One registry for every project on the machine — every project must agree on one store outside its own tree.
