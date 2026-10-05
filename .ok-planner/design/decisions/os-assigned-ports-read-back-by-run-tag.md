---
decision: os-assigned-ports-read-back-by-run-tag
---

# A verification stack binds ports the OS assigns, and the run reads them back by its tag

## Choice

A verification stack asks the operating system for free host ports at the moment it binds them: a container stack publishes its container ports with no host port given, and a dev server listens on port 0 and records the port it got. The stack runs under the run's tag. ok-planner's `port-block` reads back, by that tag, the host ports the stack got, and prints one `NAME=<port>` line per declared name. Where a project's stack cannot bind this way, the project's own stack commands handle isolation, and `port-block` refuses with a message that says so.

## Rationale

Any allocator in which one program picks a port and a different program binds it later races: another process can take the port in between. Choosing a block by position, hashing the tag to a block, or claiming a block with a lock file narrows that race and leaves it open. Only the program that binds the port closes it, so the operating system picks the port at the moment the stack binds it, and the run learns the answer afterward. Keying the read-back on the run tag ties the ports to the one run that started the stack, with no list of jobs to keep in step. The cost is that a project's stack must bind this way; a stack that cannot keeps its isolation in its own commands.

## Alternatives

- Port blocks chosen by the job's position in a list of open checkouts — needs every job to hold its own checkout, and two jobs with no checkout get the same block.
- Hash the run tag to a port block — two tags can land on one block, and another process can still take a port before the stack binds it.
- Claim a port block with an exclusive-create lock file the stack's stop command deletes — a crashed stack leaves its block claimed, and a process outside the scheme can still take a port before the stack binds it.
