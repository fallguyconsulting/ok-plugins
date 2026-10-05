---
issue: port-block-reads-back-a-stale-record
kind: audit
category: product-intent
artifacts:
  - story:concurrent-stacks-without-port-collisions
  - decision:os-assigned-ports-read-back-by-run-tag
status: verified
triage: question
opened: 2026-10-04T23:34:00Z
---

# port-block prints a dev server's recorded port after that server has stopped

`port-block` tells a verification run which host ports its own stack got. It handles two kinds of entry. A service entry names a container. When no container of that service runs, `port-block` refuses. A record entry names a file a dev server wrote its port to. `port-block` prints that port with exit 0 whether or not the server still runs. The story concurrent-stacks-without-port-collisions promises that one verification run never disturbs another's results. A stale record can break that promise.

## How it happens

A dev server listens on port 0, the operating system hands it a free port, and the server writes that port to a file whose path holds the run tag. `port-block <run-tag>` later reads the file back (`plugins/ok/families/ok-planner/scripts/port-block`, `recorded_port`). It refuses only when the file is missing or holds no port number. `ADMINISTRATION.md` describes the record entry and says nothing about who removes the file.

The file outlives its server unless something deletes it. A run tag is unique to one run, so a later run never reads an earlier run's file. The harm falls inside one run: its server stops or crashes, the operating system gives the freed port to another run's server, and the first run reads its record back and verifies against the other run's server. The run sees a passing result that belongs to someone else.

Evidence, from drive failure i28 in sprint certification run converge-2026-10-04T060800: after run B's dev server stopped, `port-block run-1d45e73b9246` printed `DB_PORT=55058` and `WEB_PORT=55061` and exited 0, and `curl -s -m 2 localhost:55061` exited 7, connection refused. After run A's compose stack went down, its service entry refused: `no running container of service db in compose project run-7478b68995b5`, exit 1.

## What the corpus says

The decision os-assigned-ports-read-back-by-run-tag says `port-block` "reads back, by that tag, the host ports the stack got". It also says that where a stack cannot bind this way, "the project's own stack commands handle isolation". The concept run-tag says wiring the tag into stacks is the project's own change. Neither says what happens to a record whose server has stopped. One reading promises a live readback. The other leaves stale records to the project's stack commands. If the decision promises a live readback, the accept list's entry for a false report someone acts on (A9) covers this, and it is a defect.

## Options

- **Probe the port.** The readback refuses a recorded port nothing listens on. Cost: it still races, since another process may already listen on the freed port, so it narrows the hole and cannot close it. The decision's own Rationale rejects allocators for leaving exactly this kind of race open.
- **Make stack-stop clear records.** The decision states that a readback reports what the record holds, and that the project's stack-stop command deletes the run's records. Cost: the duty moves to every project's stack commands, and a crashed server, which runs no stop command, still leaves a stale record.
- **Record the writer.** The record holds the server's process id beside the port, and the readback refuses when that process is gone. Cost: the record format changes, and every project's dev server must write both values.

The ruling decides whether the readback owes a live answer, and how it checks one.

## Ruling

Replace the read-back model with leases. The intent of port management is fresh ports for ad hoc runs of a project's stacks during testing, and a project's dev servers must not have to do anything special for it to work.

- Amend decision:os-assigned-ports-read-back-by-run-tag to a lease model: whatever provisions a stack runs `port-block <run-tag> lease`, which takes a handful of free ports from the operating system and records a lease for each (port, project, run tag, the lease holder's process id) in a machine-wide registry, prints one `NAME=<port>` line per declared name, and the stack starts with those values as environment variables. `port-block <run-tag> release` frees the run's leases when its work ends. A lease whose holder process is gone is reclaimed by the next lease.
- The registry never hands one port to two runs. A process outside the registry can still take a port between lease and bind; the stack then fails to bind and stops loudly, never verifying against another run's server.
- Drop the record files and every requirement that a dev server write its own port.
- The registry lives at `~/.ok-plugins/ports/`, with its lock file beside it; an environment variable (`OK_PLUGINS_HOME`) overrides the root, for sandboxes and for containers or CI jobs that share a machine.
- This issue's stale-record case is closed by the design. Update the ports paragraph of ADMINISTRATION.md and the ok-planner cheatsheet's per-run section to match.
