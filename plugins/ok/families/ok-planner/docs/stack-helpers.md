# Stack helpers: the reference

The suite ships four stack helpers and a reference stack tool under
`.ok-planner/bin/`. They are for scripts to call, not for an owner to
run by hand. A project's own stack commands may call any helper alone,
and a project with no stack tooling of its own may name the reference
stack tool as its commands. Read this document when you build or
change a project's stack tooling.

The helpers serve a project's stack scripts and the suite's own
process. True-up calls `ports` to suggest and check a port range. The
drive starts, reaches, and stops a stack only through the commands the
"Drive commands" section of `.ok-planner/review/project.md` names: a
`stack-start` line and a `stack-stop` line, or a `No stack: <why>`
line.

| Command | What it does | Settings it reads |
| --- | --- | --- |
| `run-tag` | prints a fresh run tag | none |
| `ports` | leases a run's host ports from the project's range | `ports`, `port_range` |
| `docker-sweep` | removes every docker object a run made | none |
| `run-group` | runs a command in a run's own process group, and later stops the group | none |
| `stack` | the reference stack tool: runs one verification run from start to end through the four helpers | `stack`, `ports`, `port_range` |

The settings live in `.ok-planner/config.json`. No prompt of the drive
reads them.

## Tags and ports

Mint one fresh tag for every verification run with `run-tag`. Build
every artifact the run verifies under that tag, and verify under it.
Hand the tag to the verification path through one environment
variable. The verification path resolves artifacts by the tag alone,
and fails loudly when the variable is unset or no artifact carries the
tag. Never use `:latest`, or any tag that outlives the run, in a
verification path. A tag unique to the run keeps concurrent runs from
colliding, and building and verifying inside one run makes a stale
artifact impossible.

Run a container stack as the compose project the tag names:
`COMPOSE_PROJECT_NAME=<tag>`. Docker compose then marks every
container, network, volume, and image it makes with the tag, and
`docker-sweep` finds them with no edit to the compose file. Label each
image you build outside compose with `--label ok.run-tag=<tag>`, since
the sweep finds such an image by that label alone.

Take each host port from a lease or from the operating system, never
from a bare number. A compose file publishes a leased port from its
variable, and fails when the variable is unset:

```yaml
ports:
  - "127.0.0.1:${WEB_PORT:?lease the port first}:8080"
```

A server outside compose takes its port from the environment or a
flag, or listens on port 0 and writes the port it got to a file under
the run's folder.

## Common behavior

Every helper takes `-h` or `--help`, prints its usage, and exits 0.
Each refuses a malformed argument with a message on stderr that names
the form it takes. A run tag is `run-<12 hex>`, the form `run-tag`
prints; `ports`, `docker-sweep`, `run-group`, and `stack` refuse any
other.

`ports`, `run-group`, and `stack` work on one project. They take its
root from `OK_PLANNER_PROJECT_ROOT` where it is set, and otherwise
from the nearest ancestor of the working directory that holds
`.ok-planner/`. Where neither names a project, they exit 2. Each keeps
its records under `.ok-planner/.cache/`, which git ignores, and writes
each record under a lock of its own:

| Helper | Records | Lock |
| --- | --- | --- |
| `ports` | `ports.json` | `ports.lock` |
| `run-group` | `run-groups.json` | `run-groups.lock` |
| `stack` | `stack.json` | `stack.lock` |

`run-tag` and `docker-sweep` read nothing of the project.

Where `ports`, `docker-sweep`, `run-group`, or `stack` fails for a
reason it did not foresee, it writes one JSON event line on stderr,
with the event's `kind`, the error's type and message, and the stack
trace, and exits 1. Each also writes event lines for what it skips:
`ports` where an IPv6 bind or the docker check is unavailable, for
example. A caller may ignore them.

## run-tag

```sh
.ok-planner/bin/run-tag
```

`run-tag` prints `run-<12 hex>` on one line, a new value on every
call, from six bytes of `/dev/urandom`. It takes no argument.

Exit 0 with the tag. Exit 1 where it is given an argument other than
`-h` or `--help`, with its usage on stderr, or where it cannot read
the random bytes.

## ports: the port registry

```sh
.ok-planner/bin/ports lease <run-tag>
.ok-planner/bin/ports release <run-tag>
.ok-planner/bin/ports list
.ok-planner/bin/ports stale
.ok-planner/bin/ports suggest-range
.ok-planner/bin/ports check-range <first> <last>
```

The port registry leases one host port per name the project declares,
from the project's own range, to a run tag:

```json
"ports": ["DB_PORT", "WEB_PORT"],
"port_range": {"first": 20000, "last": 20199}
```

Each name in `ports` is upper-case letters, digits, and underscores,
not starting with a digit, and appears once. `port_range` holds two
integers from 1025 to 65535, `first` at most `last`, and lies below
the machine's ephemeral range. No other project on the machine may
share the range. `/ok` suggests a range and writes it on the owner's
yes.

- `lease <run-tag>` picks one port per name from the range and prints
  one `NAME=<port>` line per name, in declared order. A shell can
  export the lines, and docker compose reads them as an env file. The
  lease skips every port another lease holds, every port a program on
  the machine holds over TCP or UDP now, every port a docker container
  publishes, and every port on the block list (`ports-blocklist`
  beside the script, and `/etc/services` where it exists). A second
  lease for a tag replaces its ports with fresh ones; lease again
  after a bind failure. A project that declares no port names leases
  nothing, and `lease` prints nothing. Where docker does not answer,
  `lease` skips the docker check.
- `release <run-tag>` ends the run's lease. It exits 0 also where the
  tag holds no lease. Release a lease only once the run is down, so no
  other run takes a port the run still holds.
- `list` prints every lease, one line each: the tag, the lease's time,
  and its ports.
- `stale` prints, in the same form, each lease at least an hour old
  none of whose ports a program holds. It releases nothing; the
  caller releases each stale lease once it has taken the lease's run
  down.
- `suggest-range` prints a free `FIRST-LAST` range of 200 ports below
  the machine's ephemeral range that avoids the block list and every
  port held now.
- `check-range <first> <last>` checks a range before you declare it,
  and prints how many of its ports remain to lease after the block
  list.

`suggest-range` and `check-range` read nothing of the project.

Exit 0 on success. Exit 1 on a refusal, with its reason on stderr: a
malformed `ports` or `port_range`, names declared with no range, a
range that reaches the ephemeral range, or too few free ports in the
range. Exit 2 where no project is found.

## docker-sweep

```sh
.ok-planner/bin/docker-sweep sweep <run-tag>
.ok-planner/bin/docker-sweep running <run-tag>
.ok-planner/bin/docker-sweep probe
```

A docker object belongs to a run when it carries the label
`ok.run-tag=<run-tag>`, or when it belongs to the compose project the
run tag names, which docker compose records as the label
`com.docker.compose.project=<run-tag>`.

- `sweep <run-tag>` removes each container of the run with its
  anonymous volumes, then each network, volume, and image of the run,
  and prints one line: `swept: <run-tag> (<n> container(s), <n>
  network(s), <n> volume(s), <n> image(s))`. Where docker refuses one
  removal, the sweep still attempts every other one, names each
  refusal on stderr, and exits 1.
- `running <run-tag>` prints the id of each running container of the
  run, one per line, and nothing where none runs.
- `probe` prints `docker: the daemon answers` where docker's daemon
  answers.

Exit 0 on success. Exit 1 on a refused removal or a malformed
argument. Exit 3 where docker is not on PATH or its daemon does not
answer: the sweep then removed nothing.

Exit 3 does not say whether the run made any docker object. A run that
never reached docker and a run whose daemon has since stopped look the
same to the sweep. Only the caller can know which one it has, so a
project's own teardown runs `probe` before and after its start
command, on a failed start as on a passing one, and records whether
either probe answered. At teardown, a sweep that exits 3 counts as
done only where neither probe answered; otherwise the run's objects
may still be on disk, and the teardown reports a failure.

## run-group: the process-group helper

```sh
.ok-planner/bin/run-group start <run-tag> -- <command> ...
.ok-planner/bin/run-group stop <run-tag>
.ok-planner/bin/run-group members <run-tag>
```

- `start <run-tag> -- <command> ...` runs the command in the run's
  own process group, from the working directory, with its input from
  `/dev/null`, and the caller's output and environment. The first
  `start` for a tag starts a holder process that leads the group and
  waits, and records the group under the tag. A later `start` for the
  same tag, while the holder lives, joins the same group. `start`
  waits for the command to exit and exits with its status, or with 128
  plus the signal's number where a signal ended it. A process the
  command starts in the background, such as a server, stays in the
  group. The command gets no terminal: a read of a terminal fails, and
  a write to one goes through. On Ctrl-C, `start` kills only the
  command it ran and exits 130; every other process of the run's group
  lives until `stop`. `start` refuses a command that names no program
  on PATH and no runnable path, and refuses a tag whose holder is gone
  while processes still carry its group's id.
- `stop <run-tag>` sends SIGTERM to the group, waits up to 10 seconds,
  sends SIGKILL to what is left, waits up to 2 seconds, drops the
  record, and prints `stopped: <run-tag>`. It exits 0 also where the
  tag records no group. Where a process outlives SIGKILL, or where the
  holder is gone while processes still carry the group's id, `stop`
  signals nothing it cannot prove is the run's, keeps the record, and
  exits 1.
- `members <run-tag>` prints the pid of each process left in the
  group, one per line, and nothing where the tag records no group.

Exit 0 on success, or the command's status from `start`. Exit 1 on a
refusal, with its reason on stderr. Exit 2 where no project is found.

## A project's own commands

A project that keeps its own stack tooling calls the helpers it needs.
This start script and stop script start a compose stack under a fresh
tag, and take it down with the probe the docker-sweep section
describes. Each runs from the project root and takes the run's name,
in lower-case letters, digits, and hyphens. The start script records
the run's tag in a file named for the project's path and the run's
name, and refuses where a run already holds the name. The stop script
reads the tag back from that file, so each stop takes down the run its
own start opened, and runs under other names, or from other projects,
stay apart:

```sh
set -eu
name=$1
case $name in ''|*[!a-z0-9-]*) echo "a run name is lower-case letters, digits, and hyphens" >&2; exit 1 ;; esac
base="${TMPDIR:-/tmp}/my-stack"
pointer="$base/$(pwd -P | cksum | cut -d ' ' -f 1)-$name"
mkdir -p "$base"
tag=$(.ok-planner/bin/run-tag)
if ! (set -C; echo "$tag" > "$pointer") 2>/dev/null; then
  echo "a run holds the name $name; run scripts/stack-stop $name first" >&2
  exit 1
fi
folder="$base/$tag"
mkdir -p "$folder"
.ok-planner/bin/ports lease "$tag" > "$folder/ports.env"
reached=no
.ok-planner/bin/docker-sweep probe >/dev/null 2>&1 && reached=yes
code=0
COMPOSE_PROJECT_NAME="$tag" .ok-planner/bin/run-group start "$tag" -- \
  docker compose --env-file "$folder/ports.env" up -d || code=$?
.ok-planner/bin/docker-sweep probe >/dev/null 2>&1 && reached=yes
echo "$reached" > "$folder/docker-reached"
exit "$code"
```

```sh
set -u
name=$1
case $name in ''|*[!a-z0-9-]*) echo "a run name is lower-case letters, digits, and hyphens" >&2; exit 1 ;; esac
base="${TMPDIR:-/tmp}/my-stack"
pointer="$base/$(pwd -P | cksum | cut -d ' ' -f 1)-$name"
if [ ! -e "$pointer" ]; then
  echo "no run holds the name $name"
  exit 0
fi
tag=$(cat "$pointer")
folder="$base/$tag"
failed=0
.ok-planner/bin/run-group stop "$tag" || failed=1
.ok-planner/bin/docker-sweep sweep "$tag"; swept=$?
if [ "$swept" -eq 3 ] && [ "$(cat "$folder/docker-reached")" = no ]; then swept=0; fi
[ "$swept" -eq 0 ] || failed=1
if [ "$failed" -eq 0 ]; then
  .ok-planner/bin/ports release "$tag"
  rm -rf "$folder" "$pointer"
fi
exit "$failed"
```

The project then names its own scripts in its review facts, with the
run's name:

```markdown
- `stack-start`: `scripts/stack-start drive`
- `stack-stop`: `scripts/stack-stop drive`
```

## stack: the reference stack tool

```sh
.ok-planner/bin/stack up [--name <name>]
.ok-planner/bin/stack up [--name <name>] [--stop <command>] [--tag-variable <NAME>] -- <command> ...
.ok-planner/bin/stack down <run-tag>
.ok-planner/bin/stack down --name <name>
.ok-planner/bin/stack tag <name>
.ok-planner/bin/stack cleanup
.ok-planner/bin/stack list
.ok-planner/bin/stack suggest-range
.ok-planner/bin/stack check-range <first> <last>
```

The reference stack tool runs one verification run from start to end.
It mints the run's tag with `run-tag`, leases the run's ports with
`ports`, runs the start command in the run's process group with
`run-group`, and removes the run's docker objects with
`docker-sweep`. A project with no stack tooling of its own may name it
as its stack commands.

### The stack key

A project that calls `stack up` with no command declares its stack
once, in `.ok-planner/config.json`:

```json
"stack": {"start": "<command>", "stop": "<command>", "tag_variable": "RUN_TAG"}
```

- `start` is the command that starts the stack. It is required, unless
  the key declares `none`.
- `tag_variable` names the variable the start command reads the run
  tag from. It is required beside `start`. It is a NAME, it is not a
  name `ports` declares, and it is none of the variables the tool sets
  itself: `OK_RUN_LABEL`, `OK_RUN_FOLDER`, and `COMPOSE_PROJECT_NAME`.
- `stop` is optional. It removes what the stack makes that the tool
  does not find by the run tag.

A project with no stack declares `"stack": {"none": "<why>"}`.
`.ok-planner/bin/plumbline config-check` names each defect in the key,
and `stack up` refuses a malformed key, with or without a command.

### up

`stack up` opens a run. It mints a tag, records the run in
`.ok-planner/.cache/stack.json`, leases one port per declared name
(nothing where `ports` declares none), makes the run's folder at
`<the machine's temp folder>/ok-planner-stack/<tag>`, and runs the
start command from the project root in the run's own process group.
It waits for the command to exit. The start command therefore exits
once the stack is up: it starts each server in the background, such as
with `docker compose up -d` or a trailing `&`, which keeps the server
in the run's process group.

- A bare `stack up` runs the key's `start` through `sh -c`, and
  records the key's `stop` and `tag_variable` for the run. It refuses
  where the project declares no stack key, or declares `none`, and the
  refusal names `stack up -- <command>` and the key.
- `stack up -- <command> ...` runs the named command in the key's
  place. Its stop command is the one `--stop` names, and the run has
  none without it. Its tag variable is the one `--tag-variable` names,
  or the key's `tag_variable` where the option is absent and the key
  declares one. `--stop` and `--tag-variable` belong to `up --` alone.
  A command given as a path is found from the project root.
- `--name <name>` names the run, in lower-case letters, digits, and
  hyphens, so `down --name` and `tag` find it. Where a run already
  holds the name, `up` takes that run down first when nothing still
  uses it, and refuses, naming `stack down --name <name>`, when
  something does.

The start command's environment holds the run tag under the tag
variable, one `NAME=<port>` per leased port, `OK_RUN_LABEL` set to
`ok.run-tag=<tag>`, `COMPOSE_PROJECT_NAME` set to the tag, and
`OK_RUN_FOLDER` set to the run's folder. A start command labels each
docker object it makes outside compose with `$OK_RUN_LABEL`, and
writes every other file it makes under `$OK_RUN_FOLDER`. The command's
output goes to `stack-start.log` in the run's folder.

`up` probes docker's daemon before and after the start command, on a
failed start as on a passing one, and records whether either probe
answered. On success it prints the tag on its first line, then one
`NAME=<port>` line per leased port. On a failed start it takes the run
down. Where a program outside the run then holds a leased port, it
starts again with a fresh tag and fresh ports, within 3 attempts.
Otherwise it prints the start command's output on stderr and exits 1.

### down, tag, cleanup, and list

- `stack down <run-tag>` and `stack down --name <name>` take a run
  down. `down` runs the run's stop command where it has one, stops
  every process left in the run's process group, sweeps the run's
  docker objects, deletes the run's folder, releases the run's ports,
  and deletes the run's entry. It prints `took down: <tag> (<ports>;
  <the sweep's counts>)`. Where a removal is refused, `down` attempts
  every other one, keeps the entry and its lease with the refusal
  named, clears the entry's name, and exits 1. Where the stop command
  fails, the run's folder stays for the stop command's next run. Where
  docker's daemon does not answer now, `down` counts the sweep as done
  only for a run whose two probes both went unanswered; a run that
  reached docker keeps its entry. `down --name` where no run holds the
  name prints `took down: nothing (no run holds the name <name>)` and
  exits 0. `down` with a tag the tool does not record refuses.
- `stack tag <name>` prints the tag of the run that holds the name, or
  refuses, naming `stack list`.
- `stack cleanup` takes down each run at least an hour old that nothing
  still uses: no process left in its process group, no running
  container with its label or in its compose project, and no program
  holding its ports. It prints one `took down:` line or one `left:`
  line per run, and exits 1 only where a removal was refused.
- `stack list` prints one line per run: its tag, its time, its ports,
  and its folder, then `name: <name>` where the run has a name, then
  `refused: <refusals>` where a removal was refused.
- `stack suggest-range` and `stack check-range <first> <last>` do what
  the same verbs of `ports` do.

`cleanup`, `down`, `tag`, and `list` read no stack key.

Exit 0 on success. Exit 1 on a refusal, with its reason on stderr, or
on a failure, with one `STACK.RUN.FAILED` event on stderr. Exit 2
where no project is found.

### Drive commands for the reference stack tool

A project that names the reference stack tool as its stack commands
writes these lines in the "Drive commands" section of
`.ok-planner/review/project.md`:

```markdown
- `stack-start`: `.ok-planner/bin/stack up --name drive`
- `stack-stop`: `.ok-planner/bin/stack down --name drive; s=$?; .ok-planner/bin/stack cleanup; exit $s`
```

The start line runs the stack the key declares, under the name
`drive`. The stop line takes down the run the start line opened, then
takes down every stale run nothing still uses, and exits with the
status of `down`. The drive runs the stop line whether the start
passed or failed; after a failed start no run holds the name, and
`down --name` exits 0. True-up writes these two lines for a project
whose stack key declares `start`, and `- No stack: <why>` for a
project whose key declares `none`. Where the section already carries
stack lines, true-up keeps them. The start command stays written once,
in the key.
