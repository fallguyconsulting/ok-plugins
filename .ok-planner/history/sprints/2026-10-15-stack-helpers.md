---
closed: 51868fdadcc89d4459666084960306b3236d2170
---

# Sprint: Stack helpers, and the fifth intake drain

## Intent

This sprint drains the intake. Its largest part returns ok-planner's
process to the model v25.3.0 ran: each project runs its own stack
commands, which its review facts name, and no process prompt or
always-loaded rule mandates a suite tool. The suite instead ships
optional helpers a project may call from its own commands, a reference
stack tool built from them, and a reference document that describes
them. The rest of the sprint is unrelated: the reuse rule learns to
prevent import cycles, a project can make its instance-story drives
wait, and true-up proves a payload copy before it stops searching it
for callers.

Promoted issues:

- `stack-lifecycle-delegates-to-project-tooling`
- `stack-docker-unreached-at-start`
- `plumbline-prescribes-no-home-for-shared-code`
- `instance-drives-run-beside-shared-drivers`
- `true-up-payload-copy-detection`

## Corpus deltas

### Retire decision: stack-tool-runs-each-run

### Retire decision: stack-ports-checked-as-a-suite-rule

### Retire decision: run-artifacts-recorded-by-the-stack-tool

### New decision: stack-helpers-serve-project-commands

```markdown
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
```

### New decision: reference-stack-runs-the-declared-stack

```markdown
---
decision: reference-stack-runs-the-declared-stack
---

# The reference stack tool runs the stack the project's configuration declares

## Choice

A project that calls the reference stack tool with no command
declares its stack once, in its ok-planner configuration: the start
command, the stop command where the stack makes anything the tool does
not find by the run tag, and the variable the start command reads the
run tag from (see also: stack-helpers-serve-project-commands). The
reference stack tool, called with no command, runs the declared stack.
Called with a command, it runs that command in the declared stack's
place, with the stop command and tag variable its caller names.

## Rationale

A start command written once cannot disagree with itself. A project
whose review facts and own scripts all call the tool with no command
start one stack the same way from every caller, and a change to the
stack is one edit. A caller that needs a different stack, such as a
build that starts one service alone, still names its own command
without a second declaration. The cost: a project keeps one setting
that only an optional tool requires, beside the review facts that the
drive and the audit read.

## Alternatives

- The reference stack tool takes its commands from its command line alone — every caller spells the start command out, and the copies drift apart.
- The declaration lives in the review facts, and the tool reads it there — the tool then reads a file the review loop owns, and a project that does not run the review loop has nowhere to declare its stack.
- A declaration per named stack — every project pays for a map of stacks that most projects never need, since a caller can already name its own command.
```

### New decision: stack-advice-outside-the-rules

```markdown
---
decision: stack-advice-outside-the-rules
---

# The suite's stack advice lives in a reference document, not in the always-loaded rules

## Choice

The suite's always-loaded rules state no rule about verification
stacks. One reference document, which no session loads unless an agent
reads it, describes the stack helpers and the reference stack tool and
gives the suite's advice on run tags and host ports (see also:
stack-helpers-serve-project-commands). The suite's lint carries no
check of a stack definition.

## Rationale

The always-loaded rules hold the conventions every change in a project
follows, and every agent in every session reads them. How a project
starts its verification stack is one of its own tools, which few
changes touch, so advice about it belongs in a document an agent reads
when it builds or changes that tool. A rule with no check is prose an
agent may skip, and a check of one stack format serves only the
projects whose stacks take that format. The cost: an agent that edits
a stack definition without reading the document can publish a bare
port or leave an unlabelled image, and nothing flags it.

## Alternatives

- The stack rules in the always-loaded rules, checked by the suite's lint for compose files — every agent in every project reads rules about a tool most of its changes never touch, and a stack outside compose goes unchecked anyway.
- The stack rules in the always-loaded rules, with no check — the same reading cost, and the rules bind nothing a lint enforces.
- Each project writes its own stack practice — every project words the same advice its own way, and a project that writes none gets none.
```

### New decision: run-artifacts-found-by-run-tag

```markdown
---
decision: run-artifacts-found-by-run-tag
---

# A run's artifacts are found by its tag: its label, its compose project, and its process group

## Choice

The suite's helpers find what a run made with no list kept by hand.
The docker sweep removes every docker container, image, volume, and
network that carries the run's label, which names the run tag, or that
belongs to the compose project the run tag names, and removes a
container's anonymous volumes with the container. Where docker's
daemon does not answer, the sweep removes nothing and exits with a
status of its own, distinct from success and from a refused removal.
The process-group helper starts a command in a process group of its
own, records the group under the run tag, and later stops every
process left in that group. The reference stack tool also gives each
run one folder for every file the run writes outside docker, and
deletes the folder with the run. The helpers find nothing a stack
makes outside those kinds; only the stack's own stop command removes
it.

## Rationale

A helper removes exactly what a run made only where it finds each
thing without guessing. A label is docker's own record of who made an
object, and it holds whatever the object's name or tag, so a suffixed
or renamed image is still found. Compose marks every object it makes
with its project's name, so a compose project named by the tag finds a
stack whose compose file carries no label, and a project's existing
compose stack is found with no edit. No other project's object carries
this run's label or compose project. A process group gathers the
processes a start command forks, and one folder per run gathers the
files, so neither needs a list. The sweep cannot tell a run that made
no docker object from a run whose daemon has since stopped, so it
reports the silence and leaves the call to its caller, the one party
that can know whether the run reached docker. The costs: an image
built outside compose without the label stays behind, and every caller
of the sweep handles one more exit status.

## Alternatives

- Match docker objects by the run tag in their names — an image tagged with a suffix, or named another way, stays behind, and the match reaches other projects' objects.
- The label alone — a project's existing compose stack must add the label to every service, volume, and network before the sweep finds anything.
- A verb the stack calls to record each artifact — every project must call it for every artifact, and a missed call leaves the artifact behind.
- The sweep reads a silent daemon as nothing made — a run whose daemon stopped before its teardown ends with its objects on disk and nothing that records them.
- The caller tells the sweep whether the run reached docker — the evidence each project collects becomes part of the sweep's interface, and the sweep no longer stands alone.
```

### New decision: instance-drives-serial-on-a-project-mark

```markdown
---
decision: instance-drives-serial-on-a-project-mark
---

# A project can make its instance-story drives run one at a time after the other drivers

## Choice

A project's review facts can mark that its stories that drive on an
instance of their own drive one at a time. With the mark, `/converge`
files each such drive after every other driver, the stories that drive
alone included, and chains each one after the one before, so at most
one instance runs beside the shared stack. The confirm drivers follow
the same order. Without the mark, instance drives run beside the
shared-stack drivers.

## Rationale

An instance is a full stack of its own, and a host that fits the
shared stack and one instance may not fit more. On an overloaded host
a drive times out, and its story goes unproven on every run there. The
review facts already carry the drive's one ordering fact, the list of
stories that drive alone, so a mark beside the instance list keeps
drive ordering in one place and in one form. A project whose hosts
have room to spare keeps its parallelism by leaving the mark off. The
cost: the right limit can depend on the machine more than on the
project, and one checkout cannot set the mark per machine.

## Alternatives

- Always drive instance stories one at a time — every project loses parallelism, even on hosts with room to spare.
- A number of instance drives at once, in the review configuration — a new key with a seed default and true-up handling that no project has asked for.
- A per-project concurrency cap for the drive — slows the shared-stack drivers too, and still lets instances overlap.
- Leave the order as it is — on a host that cannot fit three stacks, the instance stories are never proven.
```

### Amend decision: per-run-artifact-tag

```markdown
---
decision: per-run-artifact-tag
---

# Artifact tags are minted per verification run, not derived from content

## Choice

ok-planner's tag generator prints a fixed `run-` prefix followed by 12 random hex digits read from the operating system's random source, and mints a fresh value on every invocation. It depends on nothing beyond a POSIX userland and reads no repository. The reference stack tool mints each of its runs' tags with it and hands that one value to its start command through one environment variable. The helpers' reference document advises a verification run that uses the tag to mint it once, build every artifact it verifies under it, and resolve its artifact by that value alone, failing loudly when the variable is unset or no artifact carries the tag (see also: stack-advice-outside-the-rules).

## Rationale

Verification needs two properties: parallel runs must not collide on an artifact, and a run must verify the artifact it just built. A tag unique per run gives both directly. Content addressing gives both only as a side effect of a stronger claim, that identical trees produce identical tags on every machine. Beyond the two properties, that claim gives one thing more: reuse of an artifact across runs, which is a dev-loop convenience. Failing loudly is what makes staleness unrepresentable rather than merely avoided: a lookup that fell back to whatever was built last would restore the mutable-tag failure by another route.

## Alternatives

- A content-addressed tree hash — requires a definition of which files count as the tree; every non-code write, such as an audit record, moves the tag; and the cross-run reuse it gives is a dev-loop convenience, not a verification property.
- The commit hash — misses uncommitted changes, so a run verifies bits that are not the ones it built.
- A mutable tag such as `:latest` — names whatever was built last, which makes staleness representable.
```

### Amend decision: ports-leased-from-a-project-range

```markdown
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
```

### Amend decision: port-range-chosen-at-true-up

```markdown
---
decision: port-range-chosen-at-true-up
---

# The owner picks each project's port range at true-up, from a random suggestion clear of listed ports

## Choice

Where a project's configuration names ports for the port registry and declares no provisioning range, the true-up core offers one. The offer names the ports and suggests a range picked at random above 1024 and below the start of the machine's ephemeral range, in a gap that no port on the port registry's block list touches and whose ports no listening program holds at that moment. The front door asks the owner once: take the suggestion or name another range. It reads where the ephemeral range starts from the machine, uses 49152 where it cannot read the value, and refuses a range that reaches that start. Where an owner-named range overlaps listed ports, it names the ports the range hits and how many of its ports remain to lease, and the owner keeps the range or picks another. It reminds the owner that no other project on the machine may share the range. On the answer, the true-up core writes the range into the project's configuration. A declined offer returns on the next true-up. A project that names no ports gets no question.

## Rationale

Only the owner knows which other projects on the machine lease ports, so only the owner can keep their ranges apart, and true-up is the act that already settles the owner's configuration. A random suggestion keeps two projects that both take the suggestion from landing on one range. A gap clear of listed ports leaves every suggested port leasable. The ephemeral range starts at 49152 on macOS and Windows and at 32768 on a default Linux, so a fixed bound of 49152 would admit, on Linux, a range the operating system itself hands out; the bound comes from the machine. The port registry skips listed ports, so a range that spans some still works, and an overlap warns rather than refuses. A project that names no ports leases none, so a range would serve it nothing.

## Alternatives

- One default range for every project — every project that keeps the default shares one range, and their registries cannot see each other.
- A range derived from the project's path — two paths can land on one range, and a moved checkout changes its range.
- A fixed upper bound of 49152 — on Linux it admits ranges inside the operating system's own ephemeral range.
- Refuse an owner-named range that overlaps any listed port — rejects ranges the port registry can lease from by skipping the listed ports.
- Offer a range wherever a compose file publishes a host port — asks a project that never leases a port to keep a range apart from every other project's.
```

### Amend decision: run-artifacts-removed-with-the-run

```markdown
---
decision: run-artifacts-removed-with-the-run
---

# A run's artifacts are removed when the run ends, pass or fail

## Choice

A run's artifacts end with the run: the run tag's life is mint, build, verify, remove. The reference stack tool removes everything a run made when the run ends, whether the run passed or failed, and the suite's helpers let a project's own teardown do the same, finding each artifact by the tag (see also: run-artifacts-found-by-run-tag). The reference stack tool records each run in the project's registry. Its `down` runs the run's stop command where one was given, stops the run's process group, sweeps its docker objects, deletes its folder, releases its ports, and deletes its entry once every removal succeeds. Its cleanup, run periodically, such as after a batch of drives, takes down each entry in the project's own registry that is at least an hour old and that nothing still uses: no process is left in its process group, no running container carries its label or belongs to its compose project, and no program holds its leased ports. The reference tool probes docker's daemon before and after its start command, on a failed start as on a passing one, and records on the run's entry whether either probe answered. Where the sweep reports that the daemon did not answer, the tool counts the sweep as done only for a run whose probes both went unanswered; a run that reached docker keeps its entry for a later cleanup. A removal docker refuses leaves the entry in place with the refusal named, and the cleanup goes on to the next entry.

## Rationale

A tag unique per run means no later build replaces a run's artifacts, so every run adds to the disk until something removes what it built. A teardown removes them for every run that reaches its end, and a cleanup removes a crashed run's. The registry entry tells a run something still uses from one nothing uses, and what the entry records is all the cleanup touches. The hour of grace keeps the cleanup from taking down a run still building, before its first process or container exists. The probes around the start command tell the tool whether the run reached docker: on a machine whose daemon never answered, each run ends with its entry deleted and its ports released, and a run that made objects and then lost its daemon keeps its entry until docker answers. A refused entry that stays lets a later cleanup try it again, and going on keeps one stuck artifact from blocking every other run's removal. A failed run's evidence lives in its service logs and its recorded output, and a rerun builds under a fresh tag, so keeping a failed run's artifacts buys little. The costs: a crashed run's artifacts wait for a cleanup at least an hour later, a run whose stack stopped while its checks still run can be taken down under them, a daemon started and stopped inside the start command or started by a later verification step escapes both probes, and a project whose own teardown skips the helpers keeps whatever that teardown leaves.

## Alternatives

- Remove the artifacts of every run tag docker knows that holds no lease and has no containers — the scan reaches other projects' artifacts, and misses an artifact whose name hides its tag.
- Take down every stale entry at once, whatever its age — a run still building loses its artifacts.
- Remove a run's artifacts at the stack's stop alone — a run that crashes before its stop leaves its artifacts on disk for good.
- Stop the cleanup at the first refused removal — one stuck artifact keeps every later run's artifacts on disk.
- Leave removal to each project's own wiring, with no helpers — every project rebuilds the search for what a run made, and a project that skips it fills its disk.
- Keep an entry owing a docker sweep for every run whose sweep met a silent daemon — on a machine where docker is installed and never started, the registry grows on every run.
- Keep a failed run's artifacts for debugging — the evidence already lives in logs and output, and the kept artifacts fill the disk.
```

### Amend decision: project-chooses-its-lint-checks

```markdown
---
decision: project-chooses-its-lint-checks
---

# Each project turns each lint check on or off, and the rule text follows

## Choice

Each project turns each of the suite's lint checks on or off in
ok-planner's configuration: the comment rule, citation
resolution, and the no-tests rule. A check is on unless the project
turns it off. The edit hook and every whole-tree run of the lint read
the same choice. Turning a check off also drops its rule from the
suite-owned rules text the project's agents read, so the written rule
and the lint never disagree.

## Rationale

A project may allow comments or tests where this suite forbids them,
and only its owner knows which. With no switch, such a project either
carries a check that blocks every legitimate edit or stops using the
lint, and loses the checks it does want. The switch is one owner act
in committed configuration, per check and per project, so no agent
editing code meets a seam it can reach for at a site. Agents follow
the text they read, so a rule the lint no longer enforces must leave
that text in the same act; otherwise the text tells every agent a
rule the project has dropped.

## Alternatives

- No switch, with a recorded baseline that may only fall: eases a
  backlog the project means to clear, and gives a project that allows
  comments or tests no way to say so.
- Suppression markers at each exempt site: scatters exemptions through
  the code as residue, each one a judgment an agent can make alone.
- A switch in the lint's configuration alone, the rule text unchanged:
  agents read a rule the lint no longer checks, and follow the text.
```

### Amend decision: one-vendored-family

```markdown
---
decision: one-vendored-family
---

# Everything the suite vendors comes from one family

## Choice

Everything the suite vendors into a project comes from one family,
ok-planner, carried as the front door's payload: every skill, agent
profile, rules file, support script, hook, and the one estate. The
coding standards and their lint, the stack helpers,
`/audit`, and `/document` are all ok-planner's. No skill reads a
per-family contribution: each skill carries its own instructions
whole.

## Rationale

Separate families that ship at one suite version give the owner no
separate releases. Each family still costs something: an estate, a
discovery marker, an administration pair, a cheatsheet, and a ceremony
contribution that `/audit` and `/document` resolve at run time. The
families are also not independent. The planner's review pastes the
coding standards into the prompts of the agents that hunt, fix, and
verify, the audit sweeps the lint, and
sprint planning runs the coding standards' planning steps itself. One
family turns each of those reaches into an ordinary read inside one
payload. A project then has one estate to discover, one true-up to
drive, and one body per ceremony. The cost: new tooling goes into
ok-planner rather than into a conforming directory of its own.

## Alternatives

- Three families, each with its own estate, marker, and
  administration files — the owner gains nothing for them.
- Two families, the coding standards apart from the planner — carries
  no unused verbs, and splits the coding standards from the review and
  the audit that read them.
- One family, with `/audit` and `/document` kept as front-door
  ceremonies that read the family's contribution — keeps a
  contribution convention that has one family left to serve.
```

### Amend decision: drive-tries-each-story-as-a-user

body: in the sidecar

### Amend decision: retired-script-repoint-needs-a-proven-root

```markdown
---
decision: retired-script-repoint-needs-a-proven-root
---

# True-up repoints a retired script reference only behind a prefix it can prove names the project root

## Choice

True-up repoints a line that names a retired suite script's path only
behind a prefix that names the project root with certainty: one of the
fixed root forms, or a prefix true-up proves resolves to the root, such
as git's top-level idiom where the project root is the repository's
top. A line whose prefix may name the project root but that true-up
cannot prove does stays as written: true-up files an intake issue
naming the line and keeps the retired copy, because that line still
names it. A path built at run time is outside what true-up sees, and
true-up's report says so when it removes a retired copy. True-up
searches every tracked file for such lines but a payload copy's own
files: a file below a folder that holds a family's true-up core and
administration document, where the payload running true-up carries a
file at the same path relative to its own root. Every other file below
such a folder is searched like any project file.

## Rationale

Text alone cannot tell whether a prefix such as a shell variable or a
home directory names the project root. Rewriting such a line can point
a line about some other file at the suite's copy, and removing the
copy behind it can break a real caller, so holding the copy and asking
the owner costs only a kept file. A prefix true-up proves names the
root is as certain as a fixed root form, and asking about it adds a
question with one sensible answer. A caller that builds the path at
run time leaves no text to find, so the report names that limit where
a removal could reach one. A payload copy documents the scripts its
release retires, and those lines call nothing. A path the running
payload also carries proves a file belongs to such a copy, and the
proof holds when the working tree moves past the installed release,
which a match on the file's content does not. Its one false positive,
a payload file newer than the installed release, costs a kept copy and
an issue until the next release, the cost this choice already accepts.

## Alternatives

- Repoint every reference whose prefix may name the project root — a line about a home or sibling-repository script is rewritten wrongly, with only a report line as warning.
- Leave an uncertain reference as written and remove the retired copy anyway — a real caller fails at its next run.
- Count only the fixed root forms as certain — files an issue for a prefix true-up could have settled.
- Skip every file below a folder holding the two administration files — a project file there that calls a retired script is never found, and true-up removes the copy it calls.
- Skip only the payload that runs true-up — the suite's own repository gets a standing issue for every retired script its payload copy documents.
- Skip the folders the project's configuration declares as payload copies — a configuration key that one repository uses, and every file in a declared folder goes unsearched.
```

### Amend concept: run-tag

```markdown
---
concept: run-tag
---

# Run tag

## What it is

A run tag is the identifier one verification run mints for itself. The run builds every artifact it verifies under that tag. No other run uses the value. Verification paths resolve artifacts by it.

## Purpose

A tag unique to the run gives verification two properties. Concurrent runs cannot collide on an artifact or on a stack. A run that builds and then verifies under one tag cannot resolve an artifact an earlier run left behind, so staleness is unrepresentable rather than avoided. No derivation has to define which files count as the tree. The tag also marks what each run built, so whatever a run leaves behind can be found by its tag and removed.

## Boundaries

The tag names artifact and stack identity for verification. The concrete derivation is recorded as a decision (see also: per-run-artifact-tag under decisions), and so are who wires the tag into builds, stacks, and harnesses (see also: stack-helpers-serve-project-commands under decisions), how a run's artifacts are found and removed (see also: run-artifacts-found-by-run-tag, run-artifacts-removed-with-the-run under decisions) and how a stack's host ports are tied to the tag (see also: ports-leased-from-a-project-range under decisions).
```

## Work items

### The process runs each project's own stack commands

Makes true `decision:stack-helpers-serve-project-commands` and
`decision:drive-tries-each-story-as-a-user`.

`/converge`'s drive, its confirm drivers, sprint certification's drive,
and `/audit`'s deployments start, reach, and stop a stack only through
the commands the "Drive commands" section of
`.ok-planner/review/project.md` names: a `stack-start` and a
`stack-stop` line, or a `No stack: <why>` line, as in v25.3.0, beside
the roles that section already carries. No process prompt names
`.ok-planner/bin/stack` or any other helper: not the converge skill
and its drive prompt, not the audit skill, not the implementation
auditor, and not the seed review facts. The review tool's drive verbs
read the stack lines from that section and no longer read the `stack`
key of `.ok-planner/config.json`. A driver reaches the stack, its own
resources, and its instance as the project's review facts say. The
converge return no longer reports a stack tool's cleanup. This
project's own review facts keep driving the dashboard through the
working tree's reference stack tool; where that tool's command line
changes, update `.ok-planner/review/project.md` to match.

### The rules and the lint carry no stack mandate

Makes true `decision:stack-advice-outside-the-rules` and
`decision:project-chooses-its-lint-checks`.

Remove coding rule 10 from the suite's coding rules, the "Per-run
artifacts and verification stacks" section and the `bin/stack` entry
from the planner cheatsheet and the estate's `CLAUDE.md`, and every
sentence of the plumbline cheatsheet that names the compose checks or
says the process runs the `stack` key. The lint drops its
`compose-ports` and `compose-labels` checks. `ports` and `port_range`
stay, checked as the port registry's settings, and `stack` stays,
checked as the reference stack tool's setting. Every place that
describes the configuration's keys, the cheatsheets' descriptions of
`.ok-planner/config.json` among them, names `ports` and `port_range`
as the port registry's settings and `stack` as the reference stack
tool's, and says no prompt of the drive or the audit reads them. A project configuration
that still names `compose-ports` or `compose-labels` under
`lint_checks` is not an error for the lint before true-up migrates it.

### Ship the stack helpers

Makes true `decision:per-run-artifact-tag`,
`decision:ports-leased-from-a-project-range`,
`decision:run-artifacts-found-by-run-tag`,
`story:concurrent-stacks-without-port-collisions`, and
`story:verification-leaves-no-artifacts-behind`.

The payload ships four helpers, each a command a project's own stack
commands can call alone, with no other helper and no `stack` key, and
true-up materializes each under `.ok-planner/bin/`:

- the tag generator at `.ok-planner/bin/run-tag`, at v25.3.0's path,
  printing `run-<12 hex>` on one line, as v25.3.0's did;
- the port registry: it leases one port per name `ports` declares from
  `port_range` to a tag, releases a tag's lease, lists every lease, and
  lists the stale ones, as `decision:ports-leased-from-a-project-range`
  says, treating a port as taken over TCP, over UDP, or where a docker
  container publishes it;
- the docker sweep: it removes every docker object carrying a tag's
  run label or belonging to the compose project the tag names, and
  exits with a status of its own where docker's daemon does not
  answer, as `decision:run-artifacts-found-by-run-tag` says;
- the process-group helper: it starts a command in a process group of
  its own under a tag, and later stops every process left in that
  group.

Each helper prints a usage line that names its verbs, and refuses a
malformed argument with a message the caller can act on.

### Rebuild the reference stack tool from the helpers

Makes true `decision:run-artifacts-removed-with-the-run`,
`decision:ports-leased-from-a-project-range`,
`decision:run-artifacts-found-by-run-tag`, and
`decision:reference-stack-runs-the-declared-stack`.

Depends on "Ship the stack helpers".

`.ok-planner/bin/stack` stays as a reference start and stop for a
project with no stack tooling of its own, and calls the helpers for
its tag, its lease, its docker sweep, and its process group instead of
carrying its own copies. `stack up` with no command runs the start
command the `stack` key declares, with that key's stop command and tag
variable, as v26.0.0's did. `stack up -- <command>` runs the named
command in the key's place, with the stop command and tag variable its
own command line names. A bare `stack up` refuses where the project
declares no stack, or declares `none`, with a message that names `--`
and the `stack` key. A project's `stack-start` and `stack-stop` lines
can name the tool, and the stop line takes down the run the start line
opened. It probes docker's daemon
before and after the start command, on a failed start as on a passing
one, and handles the sweep's no-answer status as
`decision:run-artifacts-removed-with-the-run` says. Its cleanup and
its listing stay.

### A reference document for the helpers

Makes true `decision:stack-helpers-serve-project-commands` and
`decision:stack-advice-outside-the-rules`.

The payload ships one reference document, materialized into the
estate outside `.claude/rules/`, so no session loads it unless an
agent reads it. It describes each helper and the reference stack tool:
what each does, how to call it, the settings it reads (`ports` and
`port_range` for the port registry, `stack` for the reference stack
tool), and its exit statuses, the sweep's
no-answer status among them, with the probe a project's own teardown
can run before and after its start command. It carries v25.3.0's
cheatsheet advice on tags and ports: mint one fresh tag per run, build
and verify under it, resolve artifacts by it alone and fail loudly
when it is unset, never `:latest`, run a container stack as the
compose project the tag names, and take each host port from a leased
port or from the operating system, never a bare number. The planner
cheatsheet names the document in one line, so an agent that builds a
project's stack tooling knows where to read.

### True-up brings a v26.0.0 project to the helper model

Makes true `story:true-up-project-estate`,
`decision:port-range-chosen-at-true-up`, and
`decision:stack-helpers-serve-project-commands`.

Depends on "The process runs each project's own stack commands",
"The rules and the lint carry no stack mandate", and "Rebuild the
reference stack tool from the helpers".

True-up leaves a v26.0.0 project's `stack` key in
`.ok-planner/config.json` as it stands, and writes "Drive commands"
lines in its `.ok-planner/review/project.md` from it. A `none`
declaration becomes the `No stack: <why>` line. A start command
becomes a `stack-start` line that runs `.ok-planner/bin/stack up`
under one run name and a `stack-stop` line that runs
`.ok-planner/bin/stack down` for that name, so the project's stack
starts and stops as it did under v26.0.0 and the start command stays
written once, in the key. Where the section already carries stack
lines, true-up keeps them. It removes `compose-ports`
and `compose-labels` from `lint_checks`. It materializes
`.ok-planner/bin/run-tag` again and no longer treats it as a retired
script. It offers a port range only where `ports` names a port. Every
step is idempotent, and a project true-up cannot migrate whole gets a
cleanup offer that names what it left.

### The reuse rule prevents import cycles

Promotes `plumbline-prescribes-no-home-for-shared-code`.

Step 2 of the coding rules' "Import, never copy" rule checks that an
import does not close a cycle, as well as what the import weighs.
Where reuse would close a cycle, the agent breaks the cycle so every
import points one way, in whatever shape the project's own
organization calls for. An import placed inside a function to dodge a
circular-import error is a defect, fixed by breaking the cycle. A
project checks for cycles with a tool for its language. The rules say
nothing about where shared code lives. The plumbline cheatsheet's
"Mechanical Checks" list names the cycle check beside the dependency
lint.

### A project can make its instance-story drives wait

Makes true `decision:instance-drives-serial-on-a-project-mark`.

The seed review facts describe the mark beside the list of stories
that drive on an instance of their own. With the mark, the review
tool's drives verb files each instance-story drive after every other
driver, the stories that drive alone included, and chains each one
after the one before; the confirm drivers follow the same order. The
converge skill describes the order. Without the mark, the order stays
as it is now.

### True-up proves a payload copy before it skips a file

Makes true `decision:retired-script-repoint-needs-a-proven-root` and
`story:true-up-project-estate`.

True-up skips a file below a folder holding a family's true-up core
and administration document only where the payload that runs true-up
carries a file at the same path relative to its own root. Every other
file below such a folder counts as a caller of a retired script, as
any project file does. The administration document's skip clause says
the same.

### Every citation names a live decision

Makes true `decision:stack-helpers-serve-project-commands` and
`decision:run-artifacts-found-by-run-tag`.

Every `@decision:` annotation that names `stack-tool-runs-each-run`,
`stack-ports-checked-as-a-suite-rule`, or
`run-artifacts-recorded-by-the-stack-tool` names the decision that now
holds its site's choice, or goes where the site it marked goes. The
lint's citation check passes over the whole payload.

## Implementation notes

Planned against commit `eda17da5746b61d1a1528c452b67fff6f73ddfb6`.

Paths below are relative to `plugins/ok/families/ok-planner/` unless they start with `.ok-planner/`, `checks/`, `docs/`, or `plugins/`.

### The process runs each project's own stack commands

**Calls**
- The review tool stays the one reader of the "Drive commands" section, and the audit reads it through `.ok-planner/bin/review drive-stack` and `drive-command --role stack-start|stack-stop`. Decided by: coding rule 6.
- The `{tag}` placeholder retires. `drive-command` refuses a line that still names `{tag}`, with a message saying the drive no longer fills it; without the refusal, `{tag}` would print literally. True-up converts `{tag}` in v26.0.0 lines (B2 and the true-up item). Decided by: v25.3.0's model and accept-list A9.
- The drive prompt's one exception to "edit nothing" becomes generic: the writes the project's facts name for starting and stopping runs, into a folder git ignores. Decided by: the work item ("No process prompt names a helper").
- The audit records its deployment in the `stacks` pool: key `deployment` with the body `started`, and key `provisioned` with an instance folder as its body. A reset runs stack-stop, then stack-start. A second deployment uses `instance-create --folder` and `instance-destroy` where the facts give them; where they do not, that route is closed. Decided by: the work item ("only through those commands").
- The seed's "Drive commands" instruction names `.ok-planner/docs/stack-helpers.md` in one clause, as optional reading, and names no helper. Decided by: `decision:stack-advice-outside-the-rules`.
- `skills/_shared/implementation-auditor.md`, the judge paragraph near line 761 ("Where the `stacks` pool names a deployment … provision your own by route 3"): reworded to the new route 3, `instance-create --folder` where the facts give it, or closed. Decided by: the implementation notes review.
- The audit's "The deployment" step treats a `review drive-stack` refusal for a missing `## Drive commands` section as converge does, the same as `unfilled`. Decided by: the implementation notes review and coding rule 2.

**Changes**
- `scripts/review::drive_stack`, `cmd_drive_stack`: changed. They read `## Drive commands` as v25.3.0 did: a `- No stack:` line prints `none`; a `stack-start` role prints `stack`; otherwise `unfilled`, with a second line that names the section and the lines to write. A `- No stack:` line beside a stack role raises `ReviewError`.
- `scripts/review::DRIVE_ROLES`, `cmd_drive_command`: changed. `stack-start` and `stack-stop` are roles again, refused under `No stack`. `"tag"` leaves `DRIVE_PLACEHOLDER_VALUES` and `DRIVE_PLACEHOLDERS_PASSED_UNNAMED`, and `--tag` goes. A command naming `{tag}` is refused.
- `scripts/review::cmd_drives`, `build_parser`: changed. `--tag` and the "; run tag" brief clause go.
- `scripts/review` module top: `stack = load_sibling("stack")` goes. The owner frame catches `(ReviewError, issues.Refusal)` and emits `REVIEW.RUN.FAILED` through the shared event helper (I1). `VERB_HELP["drive-stack"]` names the section.
- `skills/converge/SKILL.md`: drive steps 2 to 4 return to v25.3.0: start with what `review drive-command --role stack-start` prints; at the end, run each `instance-destroy` and `resource-stop` first and `stack-stop` last, so a line that reads the running stack's tag still finds it; no `stack cleanup` step, since the stop line true-up writes runs it. Step 3 drops the tag and `stack up --`. Sprint step 4 keeps "every story". Confirm step 6 uses stack-start and stack-stop, in the same stop order. The return drops `cleanup`, and names a failed stack-stop, instance-destroy, or resource-stop under `hunt` with its output tail.
- `skills/converge/prompts/drive.md`: the stack parts return to v25.3.0 (instance-create and instance-destroy, resource-start and resource-stop, as the facts say; no run tag, `stack list`, or `stack up`). v26.0.0's variant and first-time-user text stays.
- `skills/audit/SKILL.md`: the tool list at line 34 names `.ok-planner/bin/review` in place of `bin/stack`. "The deployment" reads `review drive-stack` and runs stack-start. "Stack cleanup" becomes "Stack stop": instance-destroy per `provisioned` folder first, then stack-stop once. The report's `Stack:` and `Cleanup:` lines become `Stack:` (started, the failed start's output tail, none, or unfilled) and `Stop:`. Line 350 names the stack-start command.
- `skills/_shared/implementation-auditor.md::{{DEPLOYMENT-STATE-RULE}}`, the three write-exception sentences (near lines 205, 393, and 612), and line 12: the deployment is the one the project's stack-start opened, reached as `.ok-planner/review/project.md`'s "Running the product" says. The write exception becomes "the writes the project's stack commands make".
- `review/seed/project.md`: "Drive commands", "Running the product", and "Resources a driver starts" return to v25.3.0's text (roles `stack-start` and `stack-stop`, and `- No stack: <why>`), plus the reference-document clause.
- `admin/true-up::RETIRED_PROJECT_MD_SEED_DIGESTS`: adds the v26.0.0 seed digest `e6b75311c402c9fa1fbb2c1f1bf0f0deaad16fe0a9b6b3b04c9108052310c6d0`.
- `.ok-planner/review/project.md` (this repository's facts): the scripts list says `review drive-stack` reads the section; `drive-command` roles add stack-start and stack-stop and drop `--tag`; `plumbline` drops `compose-ports`; `stack` takes its new command line; `run-tag`, `ports`, `docker-sweep`, and `run-group` are added. "The helpers the catalogs name" names the event helper (I1). "Running the product" lists the new bin scripts. The dashboard steps stay valid (`stack up -- sh -c …`, `stack down <tag>`, and `list` with the folder after the tag).
- `.ok-planner/design/decisions/drive-tries-each-story-as-a-user.md`: the sidecar delta applies.

**Behavior changes**
- **B1** `scripts/review::drive_stack`. Before: reads `stack` in `.ok-planner/config.json`. After: reads the review facts' section. Users: in the release: the converge and audit skills. Across Trued-up projects: a v26.0.0 project whose `stack` key has no lines yet, its review facts still the seed skeleton included; and a project trued up from v25.3.0 whose v25.3.0 `stack-start` and `stack-stop` lines stand beside the key, which the drive starts to read. Ruling: migrate: in the same act that vendors the new tool, true-up writes `stack-start` and `stack-stop` lines that call the reference stack tool, which runs the key, or a `- No stack:` line from `none`, and leaves the key in place (call).
- **B2** `scripts/review::cmd_drive_command`. Before: no stack roles; `{tag}` and `--tag` filled. After: stack roles return and `{tag}` is refused. Users: in the release: converge, the drive prompt, audit, and the implementation auditor. Across Trued-up projects: v26.0.0 role lines naming `{tag}`. Ruling: migrate: where the section's `stack-start` line runs `.ok-planner/bin/stack up --name drive`, true-up rewrites each role line naming `{tag}` to read the tag from `.ok-planner/bin/stack tag drive` and fail when it is empty, and names every other line naming `{tag}` in the `stack-lines` cleanup offer (call).
- **B3** `scripts/review::cmd_drives`. Before: takes `--tag`, and briefs carry a run tag. After: neither. Users: in the release: the converge skill. Ruling: rewrite.
- **B4** `skills/converge/SKILL.md`. Before: the drive runs `stack up`, `down`, and `cleanup`, and the return has `cleanup`. After: project commands, and no `cleanup` field. Users: in the release: the owner and the completion report's copy of the return. Across Trued-up projects: a v26.0.0 project that relied on the drive's cleanup, which the `stack-stop` line true-up writes runs (B42). Ruling: rewrite.
- **B5** `skills/converge/prompts/drive.md`. Before: drivers use `stack list`, `up`, and `down`, and run `instance-create` and each `resource-start` inside `.ok-planner/bin/stack up -- sh -c …`, which gives them `OK_RUN_FOLDER`, `OK_RUN_LABEL`, `COMPOSE_PROJECT_NAME`, the key's tag variable, the leased port variables, and a process group that `stack down <tag>` stops. After: they act as the facts say, and run those lines bare. Users: in the release: drivers. Across Trued-up projects: v26.0.0 `instance-create` and `resource-start` lines that read those variables or a `ports` name, or that leave processes or containers for `stack down`. Ruling: migrate: the `stack-lines` offer lists each such role line, and its draft wraps the start in `.ok-planner/bin/stack up --name <the drive name> -- sh -c '…'` and adds `.ok-planner/bin/stack down --name <the drive name>` to the matching stop line (call).
- **B6** `skills/audit/SKILL.md`. Before: starts with `stack up` from the config key, even from a skeleton review facts file, and reports `Stack` and `Cleanup`. After: stack-start and stack-stop from the review facts, and reports `Stack` and `Stop`. Users: in the release: the owner reading the report. Across Trued-up projects: a v26.0.0 project with a skeleton review facts file, which true-up gives the stack lines. Ruling: migrate: true-up writes the stack lines into a skeleton too (call).
- **B7** `skills/_shared/implementation-auditor.md::{{DEPLOYMENT-STATE-RULE}}`. Before: a tag read from the pool, and `stack up` and `down`. After: the project's commands. Users: in the release: audit auditors. Ruling: rewrite.
- **B8** `review/seed/project.md`. Before: the v26.0.0 text. After: v25.3.0's text plus the instance mark. Users: in the release: true-up's skeleton detection (`seeded_project_md`). Across Trued-up projects: an unfilled v26.0.0 skeleton. Ruling: migrate: the v26.0.0 seed digest joins `RETIRED_PROJECT_MD_SEED_DIGESTS`, so its `review-facts` offer still stands (call).

### The rules and the lint carry no stack mandate

**Calls**
- `lint_checks` accepts `compose-ports` and `compose-labels` with boolean values. It reports no defect for them and ignores them. Decided by: the work item ("not an error for the lint before true-up migrates it").
- `config-check` keeps checking `stack` exactly as v26.0.0 does. `STACK_KEYS`, `STACK_TOOL_VARIABLES`, `stackTagVariableDefect`, `stackDefects`, and `CONFIG_KEY_DEFECTS.stack` stay, and their messages are unchanged. The messages still name "the stack tool", which is still that tool's name. `config_named_keys` in true-up sorts defects by their `stack` prefix. Decided by: the work item ("`stack` stays, checked as the reference stack tool's setting") and the amended ruling, point 2.
- The `stack` check stays in two places: the lint (JavaScript) and the stack tool's `stack_defects` (Python). The two copies agree today. Coding rule 6 step 3 binds only where copies disagree. Collapsing them would make the stack tool depend on node, or make true-up's `config` offer lose malformed-`stack` coverage. The true-up migration imports the Python copy through `carried_module` and writes no third copy. Decided by: coding rule 6 and `decision:reference-stack-runs-the-declared-stack`.
- The `compose-ports` subcommand joins `RETIRED_SUBCOMMANDS`. Its one user, true-up's compose trigger (`published_ports`), leaves in this sprint. Decided by: coding rule 1 step 4 and `decision:port-range-chosen-at-true-up`, whose alternatives reject the compose trigger.
- After the rules stage, the builder runs `checks/run`, with `checks/materialized-standalone` and `checks/owned-paths` among its checks, to confirm that `render_rules`' marker assertion and the owned-path regions agree with the removals. Decided by: coding rule 9 step 3.
- Wording of the configuration descriptions (both cheatsheets, the estate `CLAUDE.md`, ADMINISTRATION.md). `ports` and `port_range` are "the port registry's settings (`.ok-planner/bin/ports`)". `stack` is "the stack the reference stack tool, `.ok-planner/bin/stack`, runs when called with no command". One sentence says no process prompt reads any of the three. Decided by: the work item.
- `skills/_converge/coding-rules.md` `{{CONVERGE-CODING-RULES}}` names "rules 1, 3, 4, 6, 7, 9, and 10"; rule 10 leaves that list, since the block is transcluded into every fix, verify, and build prompt. Decided by: coding rule 1 and the implementation notes review.

**Changes**
- `scripts/plumbline`: removed: `LINT_CHECK_COMPOSE_PORTS`, `LINT_CHECK_COMPOSE_LABELS` (from `LINT_CHECK_NAMES` too), `CODE_COMPOSE_PORTS`, `CODE_COMPOSE_LABELS`, and every compose parser and check function, `isComposeFile` through `composePortsCmd` (near lines 1174 to 1700, `RUN_LABEL_FIX` and `COMPOSE_PORT_NAME_FIX` included). Also removed: the compose branches of `patternKey` and `runLint`, `loadConfig`'s `portNames` and `portRange`, `declaredPortRange` once unused, and `SUBCOMMANDS['compose-ports']`. New: `RETIRED_LINT_CHECK_NAMES = ['compose-ports', 'compose-labels']`, which `lintChecksDefects` accepts with a boolean value. `'compose-ports'` joins `RETIRED_SUBCOMMANDS`. These stay: `portsDefects`, `portRangeDefects`, `declaredPortNames` (which `stackDefects` still reads), and the whole `stack` check.
- `docs/plumbline-coding.md`: rule 10 goes, with its two `lint-check` blocks. Rules 1 to 9 are unchanged.
- `docs/plumbline-cheatsheet.md`: the `compose-ports` and `compose-labels` entries under Tooling go, with their markers. The configuration line (line 161) names `ports` and `port_range` as the port registry's settings and `stack` as the reference stack tool's setting, and says no process prompt reads them.
- `scripts/ok-planner-cheatsheet.md`: the `config.json` bullet (lines 73 to 81) names the three keys in the same words. The `bin/stack` bullet (lines 82 to 84) and the section "Per-run artifacts and verification stacks" (line 363 to the end of the section, its "Rule 10" sentence included) go. One line names `.ok-planner/docs/stack-helpers.md` as the reference document for the helpers and the reference stack tool. That line is listed again under the reference-document item.
- `scripts/ok-planner-CLAUDE.md`: the configuration paragraph (lines 104 to 107) is reworded as in the cheatsheet. The `bin/stack` sentence in "The lint and the hooks" (lines 119 to 122) goes. The `.cache` paragraph (lines 519 to 525) names the registries (`stack.json`, `ports.json`, `run-groups.json`). It says to delete `.cache` only when `bin/stack list` and `bin/ports list` print nothing.
- `admin/true-up::LINT_CHECKS`: the two compose names go. Its citation repoints from `stack-ports-checked-as-a-suite-rule` to `project-chooses-its-lint-checks`.
- `admin/true-up::published_ports`, `compose_port_line`: removed.
- `admin/ADMINISTRATION.md`:
  - Line 165 keeps `stack` in config-check's list. It says the lint reads every key but `stack`, `ports`, and `port_range`; the port registry reads `ports` and `port_range`; the reference stack tool reads `stack`; and no process prompt reads them.
  - The "Lint checks" list (line 167) loses the compose checks and says a retired compose name under `lint_checks` is accepted and ignored until true-up removes it.
  - The **Ports** paragraph (line 169) says `.ok-planner/bin/ports lease <tag>` leases the ports and prints them, and that the reference stack tool leases through it.
  - The **Stack** paragraph (line 171) stays, reworded to `decision:reference-stack-runs-the-declared-stack`: the key declares the stack `.ok-planner/bin/stack up` runs when called with no command; `stop` removes what the tool does not find by the run tag; a bare `stack up` with no key, or with `none`, refuses and names `stack up -- <command>` and the key; nothing else in the suite reads the key.
  - The compose-labels audit row (line 266) goes, and so does the compose clause of the report-line bullet (line 277).
- `checks/owned-paths`: the `published_ports` region and the `[NODE, PLUMBLINE_SRC, "compose-ports"]` site (line 474) go.
- `.ok-planner/design/decisions/project-chooses-its-lint-checks.md`: the delta applies.

**Improvements**
None.

**Behavior changes**
- **B31** `scripts/plumbline::runLint`, `lintChecksDefects`. Before: compose files are flagged, and `lint_checks` names five checks. After: compose files are never flagged. `lint_checks` names three checks and accepts the two retired names, ignoring them. Users: in the release: the edit hook, whole-tree lint runs, true-up's `config` offer. Across Trued-up projects: projects that relied on the checks or set them under `lint_checks`. Ruling: migrate: the retired names are accepted and ignored, and true-up removes them; the lost check is the approved decision's stated cost (call).
- **B32** `scripts/plumbline` `compose-ports` subcommand. Before: prints JSON. After: prints "`compose-ports` is retired" and exits 1. Users: in the release: true-up (`published_ports`, removed in this release) and this repository's facts (the first work item drops the entry). Ruling: rewrite.
- **B33** The rules text: `plumbline-coding.md` rule 10, both cheatsheets, the estate `CLAUDE.md`, and the ADMINISTRATION.md configuration paragraphs. Before: the stack mandate and the compose checks. After: neither, and the three keys are described as helper settings. Users: in the release: agents, which read the text that the same true-up renders. Ruling: rewrite.
- **B34** `admin/true-up::LINT_CHECKS`, `lint_rules_notice`, `chosen_lint_checks`. Before: five checks named. After: three. Users: in the release: `render_rules`, whose marker assertion matches once the compose blocks leave the docs in the same change, and the notice text. Ruling: rewrite.

### Ship the stack helpers

**Calls**
- The helpers are `scripts/run-tag`, `scripts/ports` (the port registry), `scripts/docker-sweep`, and `scripts/run-group` (the process-group helper); true-up materializes each to `.ok-planner/bin/<name>`. `ports` reuses the path and store of the unreleased `bin/ports` (`.ok-planner/.cache/ports.json`, `{"leases": {tag: {"at", "ports"}}, "next"}`), so the stack tool's `legacy_taken` collapses into the registry. Decided by: the work item, which names only run-tag's path.
- The helpers carry no citation lines. `checks/materialized-standalone` lints payload scripts in a scratch project that declares no citation tags, and no script under `scripts/` carries one today. Each helper's `@decision:` and `@story:` lines go on its `EXECUTABLE_FILES` entry in `admin/true-up`, the sibling shape for issues, dashboard, and stack. Decided by: coding rule 2.
- Each Python helper loads its siblings with the existing `load_sibling` idiom (review loads stack, stack loads issues). The stack tool calls `run-tag` as a subprocess through `sh <path beside itself>`, so it does not depend on the file's mode bit. Decided by: coding rule 2 and `decision:per-run-artifact-tag`.
- run-tag keeps v25.3.0's `od … /dev/urandom` body and stamps "overwritten on true-up". `-h` and `--help` print `usage: run-tag (prints run-<12 hex>; takes no argument)`, and any argument is refused with that line and exit 1. Smoke probe: `("--help",)`. Decided by: the work item.
- ports verbs: `lease <tag>` prints one `NAME=<port>` line per declared name, in order, and a second lease for the tag replaces its batch, as the retired `ports` did; `release <tag>` exits 0, also with no lease; `list`; `stale` (at least an hour old, no port held); `suggest-range`; `check-range <first> <last>`. "Taken" means held over TCP or UDP on the bind addresses, or published by any docker container, read through `docker ps -aq` and `docker inspect … .HostConfig.PortBindings`. Where docker does not answer, the docker check is skipped and an event names why. Exit 0, or 1 for a refusal or failure (`PORTS.RUN.FAILED`). It owns `ports-blocklist` beside itself. Moved from the stack tool: `ephemeral_start`, `block_list`, `bind_addresses`, `held`, `declared_names`, `declared_range`, `pick_order`, `suggest_range`, `check_range`, `range_bound`, `PORT_NAME`, and their constants. Decided by: `decision:ports-leased-from-a-project-range`.
- docker-sweep verbs: `sweep <tag>` removes containers (`rm -f -v`), networks, volumes, and images matching `label=ok.run-tag=<tag>` or `label=com.docker.compose.project=<tag>`, in two list calls joined; `probe`; `running <tag>`. Exit 0 for done, 1 for a refusal or usage error (every other removal is still attempted), and 3 where the daemon does not answer or docker is not on PATH; 3 because `tasks.fail` uses 2. Moved from the stack tool: `docker_out`, `docker_ids`, `docker_reached`, `DOCKER_STEPS`, `DOCKER_ABSENT`, and `label_filter`. It also carries the published-ports reader that `ports` imports. The builder checks against the installed docker that compose-built images carry the compose project label. Decided by: `decision:run-artifacts-found-by-run-tag`.
- run-group verbs: `start <tag> -- <command>…` spawns the v26.0.0 holder (`HOLDER_MARK` plus the tag in argv, its own group), records `{tag: {pgid, at}}` in `.ok-planner/.cache/run-groups.json` under `run-groups.lock`, runs the command joined to the group, waits, and exits with the command's status; a tag whose holder still lives joins that group. `stop <tag>`: SIGTERM, 10 seconds, SIGKILL, 2 seconds, then the record is dropped; exit 1 where pids outlive SIGKILL or where the holder is gone and pids carry its group id. `members <tag>`. The module's `stop(root, tag, pgid=None)` takes a v26.0.0 entry's `holder`. Moved from the stack tool: `spawn_holder`, `join_group`, `new_group`, `ps_lines`, `pid_live`, `holder_is_ours`, `group_members`, `orphaned_text`, `signal_group`, `wait_group_empty`, and `stop_group`. Decided by: `decision:run-artifacts-found-by-run-tag`.
- Every helper finds the estate as `tasks.project_root` does; docker-sweep needs no root. Decided by: coding rule 2.

**Changes**
- `scripts/run-tag`, `scripts/ports`, `scripts/docker-sweep`, `scripts/run-group`: new.
- `admin/true-up::EXECUTABLE_FILES`: four new entries with `("--help",)` probes, cited: run-tag `per-run-artifact-tag`; ports `ports-leased-from-a-project-range`, `port-range-chosen-at-true-up`, and `@story: concurrent-stacks-without-port-collisions`; docker-sweep `run-artifacts-found-by-run-tag` and `@story: verification-leaves-no-artifacts-behind`; run-group `run-artifacts-found-by-run-tag`.
- `admin/true-up::ESTATE_LICENSE_PREAMBLE`: "the port registry's block list".
- `admin/ADMINISTRATION.md` lines 31, 32, and 38: list and probe the four helpers.
- `checks/materialized-standalone::PAYLOADS`: the four are added (`.sh` for run-tag, `.py` for the others).
- `CLAUDE.md` layout lines, `plugins/ok/CLAUDE.md` line 7, and `docs/integration-contract.md` lines 28 to 31 and 312 to 318: name the helpers.

**Improvements**
- **I1** `scripts/tasks::event(kind, **fields)` (new), replacing `scripts/stack::emit`: the maintenance cost of one mechanism built several times. Today the stack tool and review share `stack.emit`; after this sprint review no longer loads the stack tool, and the three Python helpers each need an emitter, so the same trace-attaching helper would be written five times, where the events standard names one project event helper. Afterward: every one of those scripts calls `tasks.event`, which tasks loads for all of them, and `.ok-planner/review/project.md`'s "helpers the catalogs name" names it. The JSON line on stderr is unchanged, so this is no behavior change.

**Behavior changes**
- **B15** `.ok-planner/bin/run-tag`. Before: v25.3.0 ignored arguments; v26.0.0 has no such file. After: `--help` prints usage and an argument is refused. Users: across Trued-up projects: v25.3.0 callers. Ruling: preserve: a call with no argument prints the same line (call).
- **B16** `.ok-planner/bin/ports` and `.ok-planner/.cache/ports.json`. Before: the path is a retired script (`planner-ports`) that true-up removes, and the stack tool reads the file as legacy leases taken for an hour. After: the live port registry and its store. Users: across Trued-up projects: development-tree projects that trued up between v25.4.0 and v26.0.0 (unreleased). Ruling: migrate: the same `{"leases"}` shape is read as the registry's own leases (call).

### Rebuild the reference stack tool from the helpers

**Calls**
- A bare `stack up` (no `--`) runs the key's `start` through `sh -c`, records the key's `stop` and `tag_variable` on the entry, and runs that `stop` at `down`, as v26.0.0 did. Decided by: `decision:reference-stack-runs-the-declared-stack` and the work item.
- `stack up -- <command>` runs the command and records the stop command `--stop` names. The run's tag variable is the one `--tag-variable` names. Where `--tag-variable` is absent, it is the key's `tag_variable` where the key declares one. v26.0.0's `start_plan` exported the key's variable on `up --`, and v26.0.0's rule 10 told agents to write `up --` calls that may read it. Decided by: the Trued-up projects boundary (preserve within a major version). The decision's "the tag variable its caller names" holds for every caller that names one.
- `--stop` and `--tag-variable` without `--` are refused, with "the stack key supplies the stop command and tag variable of a bare stack up". Decided by: coding rule 7 step 1.
- The key is validated wherever it is present, on `up` and on `up --` alike. `stack_declaration` and `stack_defects` stay, with the message naming `plumbline config-check` (`CONFIG_CHECK`). The names `stack_defects` checks come from `ports.declared_names`. Decided by: v26.0.0's behavior, and the accept list's standing ground for grossly wrong operator configuration.
- A bare `up` where no key is declared refuses. The message names `stack.start` (with `stack.tag_variable`) in `.ok-planner/config.json` and `stack up -- <command>`. It no longer suggests setting `stack.none`, which only makes a bare `up` refuse. The `none` refusal keeps its text, which already names both. Decided by: the work item ("names `--` and the `stack` key") and `decision:reference-stack-runs-the-declared-stack` ("names both ways").
- `declared_stack` stays as `start_plan`'s helper. After the first work item, its one caller is `start_plan`; the review tool no longer calls it. Decided by: coding rule 6 (no copy is made).
- `stack up` and `stack up --` take `--name <name>` (alphabet `[a-z0-9-]+`). `stack down` takes `<run-tag>` or `--name <name>`. `stack tag <name>` prints the tag of the entry that holds the name, or refuses naming `stack list`. Where an entry already holds the name, `up` takes that entry down first when `in_use` finds nothing still using it, and refuses, naming `stack down --name <name>`, only when something is; an interrupted drive then never blocks the next one. A refused `down` clears the entry's name, so a kept entry never blocks the next start. Decided by: the work item ("the stop line takes down the run the start line opened").
- `stack down --name <name>` where no entry holds the name exits 0 and prints `took down: nothing (no run holds the name <name>)`. A stop line runs whether the start passed or failed, so a stop after a failed start must not report a failure. `stack down <run-tag>` for an unknown tag keeps refusing, as v26.0.0 did. Decided by: accept-list A9 and the drive's pass-or-fail stop.
- The full command line is `stack up [--name N] [--stop <command> --tag-variable NAME] [-- <command> …]`, plus `down <run-tag> | --name N`, `tag <name>`, `cleanup`, `list`, `suggest-range`, `check-range <first> <last>`, and `-h | --help`. USAGE and the no-verb refusal list every form. Decided by: the work item and v26.0.0's verbs.
- Across two stores, the tool writes the stack entry first and the lease second. On the way down it releases the lease first and deletes the entry second. A crash between the two steps leaves an entry that `cleanup` takes down. Decided by: coding rule 3 step 1, since two helper stores cannot share one transaction.
- The tool probes docker before and after the start command, on a failed start as on a passing one, and records `docker:` as whether either probe answered. A v26.0.0 entry's `docker` counts as unanswered only when it is `False`, as v26.0.0's `docker_out_of_reach` did. A sweep that exits 3 counts as done only when `docker` is `False`. Otherwise the entry stays, with the refusal "docker's daemon did not answer, and the run reached docker". Decided by: `decision:run-artifacts-removed-with-the-run`.
- `list` appends ` name: <name>` after the folder and before `refused:`, so existing parsers keep their field positions: this repository's facts and v26.0.0 auditors. Decided by: the Trued-up projects boundary.
- For a v26.0.0 registry entry, the tool stops the group with `run-group.stop(…, pgid=entry["holder"])`, lists the entry's `ports`, runs its `stop` where `declared` is true, and releases no lease. A live v26.0.0 server's port stays out of new leases through the TCP and UDP held check. Decided by: the stored-state boundary.
- `suggest-range` and `check-range` stay as verbs and call the ports module. Decided by: the Trued-up projects boundary.
- Citations: the stack tool's `EXECUTABLE_FILES` entry in `admin/true-up` cites `reference-stack-runs-the-declared-stack`, `run-artifacts-removed-with-the-run`, `run-artifacts-found-by-run-tag`, `stack-helpers-serve-project-commands`, `per-run-artifact-tag`, `ports-leased-from-a-project-range`, and both stories. It drops `stack-tool-runs-each-run` and `run-artifacts-recorded-by-the-stack-tool`. Decided by: the helpers notes' citation call (payload scripts carry none, per `checks/materialized-standalone`) and the dispatcher's instruction.
- The stage that changes the command line also updates the `stack` entry of `.ok-planner/review/project.md`'s scripts list: the new forms, and `up` reading `stack`, `ports`, and `port_range`. This is the same edit the first work item's notes name, so the two stages chain on that file. Decided by: the review facts' rule that a build which changes a script input updates the file in the same stage.
- `list_runs`, `down`'s `took down:` text, `held_port`, `in_use`, and `start_run`'s bind-failure retry read a new entry's ports from the port registry's lease for its tag, and `down` reads the lease before it releases it. Decided by: the implementation notes review (new entries store no `ports`).
- `down` and `cleanup` release a run's lease only when they delete its entry, once every removal succeeded. A refused entry keeps its lease, as v26.0.0 kept a refused entry's ports. Decided by: `decision:run-artifacts-removed-with-the-run`.
- A v26.0.0 entry's `ports` stay out of new leases until the entry is taken down: the first time the tool reads such an entry, it records those ports in the port registry as a lease under the entry's tag, and it releases that lease when it takes the entry down. Decided by: the stored-state boundary and `decision:ports-leased-from-a-project-range` ("A lease keeps a port away from every other run of the project until the lease ends").
- B35's "none of the process prompts call a bare `up`" holds for the prompts' own text; after migration, the `stack-start` line true-up writes is a bare `up` the drive and the audit run, so the new refusal text reaches them. The ruling stands. Decided by: the implementation notes review.

**Changes**
- `scripts/stack`: rewritten over the helpers.
  - Kept: `read_config`, `nonempty_text`, `STACK_KEYS`, `TOOL_VARIABLES`, `stack_defects`, `stack_declaration`, `declared_stack`, `CONFIG_CHECK`, `start_plan`, `checked_command`, `open_entry` (it stores name, stop, tag_variable, declared, folder, docker, refused, and stopping, and no `ports`), `run_env` (the tag variable plus `ports lease` output, `OK_RUN_LABEL`, `COMPOSE_PROJECT_NAME`, and `OK_RUN_FOLDER`), `run_stop`, `remove_folder`, `removal_steps`, `attempt_step`, `claim`, `settle`, `take_down`, `start_run` (bind-failure retry through `ports.held`), `up`, `down`, `in_use` (run-group members, docker-sweep `running`, ports held), `cleanup`, `list_runs`, and `main`.
  - New: the `--name`, `--stop`, and `--tag-variable` parsing, `tag`, and the name lookup inside `transaction`.
  - Removed: the code moved to the helpers (the earlier helpers notes list it), `mint_tag`, `LEGACY_REGISTRY_NAME`, and `legacy_taken`.
  - The owner frame catches `Refusal` and each helper's `Refusal`, and emits `STACK.RUN.FAILED` through `tasks.event` (I1).
- `admin/true-up` (the stack tool's `EXECUTABLE_FILES` entry, lines 242 to 249): the citations above.
- `.ok-planner/review/project.md`: the `stack` entry under "Scripts for developers and operators", as the call above says.

**Improvements**
None.

**Behavior changes**
- **B35** `scripts/stack::start_plan`, `main`, `USAGE`. Before: a bare `up` with no key refuses, naming `stack.start` and `stack.none`; the usage text lists six verbs. After: the refusal names `stack.start` and `stack up -- <command>`; the usage lists the new options and `tag`. The exit status (1), and every input v26.0.0 accepted or refused, are unchanged. Users: in the release: none of the process prompts call a bare `up`. Across Trued-up projects: owners and scripts that call a bare `.ok-planner/bin/stack up`, which runs the key as before. Ruling: preserve (call): the text a person reads gains the second way, and nothing a program reads changes.
- **B36** `scripts/stack::up` lease. Before: a port counts as taken when it fails a TCP bind, is on the block list, or is leased in the registry or in a legacy `ports.json`; the tag comes from `os.urandom`. After: through `ports lease`, a port also counts as taken when it fails a UDP bind or a docker container publishes it; the tag comes from `run-tag`. The output (tag on line 1, then one `NAME=<port>` line per name) is unchanged. Users: in the release: this repository's facts (`up -- sh -c …`). Across Trued-up projects: v26.0.0 scripts that call `stack up`. Ruling: preserve (call): the inputs and output contract are unchanged, and which free port a lease picks was never part of the contract.
- **B37** `.ok-planner/.cache/stack.json` entry shape. Before: `ports`, `holder`, `declared`, `stop`, `tag_variable`, `docker`. After: no `ports` or `holder`; `name` is added. Across stored state: v26.0.0 entries. Ruling: migrate: `read_registry` accepts both shapes, and honours a v26.0.0 entry's `holder`, `ports`, and `declared` with `stop` (call).
- **B38** `scripts/stack::down`, `cleanup`. Before: docker objects are matched by label alone, with one probe. After: by label or by the compose project the tag names, with two probes and the sweep's exit-3 handling. Users: in the release: drivers and this repository's facts. Across Trued-up projects: v26.0.0 scripts that call `stack down <tag>` or `stack cleanup`. Ruling: preserve (call): v26.0.0's `up` already named every run's compose project after its tag, so the objects `down` now also finds belong to the run, and the run ends as `down` promised.
- **B39** `scripts/stack::list_runs`. Before: tag, at, ports, folder, refused. After: a ` name:` field is added between the folder and `refused:`. Users: in the release: this repository's facts. Across Trued-up projects: v26.0.0 auditors that parse the line. Ruling: preserve (call).
- **B40** `scripts/stack` `suggest-range`, `check-range`. Before: computed inline. After: delegated to the ports module, with the same output. Across Trued-up projects: owners' scripts. Ruling: preserve (call).
- **B41** Event kinds on stderr (`STACK.PORT.HELD`, `STACK.IPV6.ABSENT`, `STACK.DOCKER.UNREACHED`, `STACK.GROUP.GONE`). Before: `STACK.*`. After: `PORTS.*`, `SWEEP.*`, and `GROUP.*` from each helper. Users: none parse them. Ruling: rewrite.

### A reference document for the helpers

**Calls**
- The source is `docs/stack-helpers.md`, materialized as `.ok-planner/docs/stack-helpers.md` in the `"stamped"` form, beside `events.md`. It carries no citation, because `checks/materialized-standalone` scans `ok-planner/docs`. Decided by: `decision:stack-advice-outside-the-rules`.
- The document gives the `stack` key's shape and the `Drive commands` lines a project with no tooling of its own may write: `` - `stack-start`: `.ok-planner/bin/stack up --name drive` `` and `` - `stack-stop`: `.ok-planner/bin/stack down --name drive` ``, the lines true-up writes. It is a reference document, not a process prompt, so naming the tool there keeps "no process prompt names a helper". Decided by: `decision:reference-stack-runs-the-declared-stack` and `decision:stack-helpers-serve-project-commands`.

**Changes**
- `docs/stack-helpers.md`: new. It covers:
  - Each helper (`run-tag`, `ports`, `docker-sweep`, `run-group`): verbs, the settings each reads (`ports` and `port_range` for the port registry), environment, and exit statuses: docker-sweep's 3 where the daemon does not answer, and run-group's 1 where pids outlive SIGKILL. It also covers `docker-sweep probe` before and after a project's own start command.
  - The reference stack tool: the `stack` key (`start`, `stop`, `tag_variable`, or `none`); a bare `up` running it; `up --` with `--stop` and `--tag-variable`, falling back to the key's variable; `--name` and `down --name`; `tag`; the variables the start command receives (`OK_RUN_LABEL`, `COMPOSE_PROJECT_NAME`, `OK_RUN_FOLDER`, one `NAME=<port>` per leased port); `cleanup`; `list`; and the refusal of a bare `up` with no key.
  - v25.3.0's advice on tags: mint one fresh tag per run, build and verify under it, resolve artifacts by it alone and fail loudly when it is unset, never `:latest`.
  - v25.3.0's advice on stacks and ports: run a container stack as the compose project the tag names, and take each host port from a lease or from the operating system, never a bare number.
- `admin/true-up::ESTATE_FILES`: the entry `("docs/stack-helpers.md", ".ok-planner/docs/stack-helpers.md", "stamped")` is added.
- `scripts/ok-planner-cheatsheet.md`: the one-line pointer (listed under the rules work item).

**Improvements**
None.

**Behavior changes**
None. Every change is new code no existing user reaches.

### True-up brings a v26.0.0 project to the helper model

**Calls**
- The core does the migration with no consent, beside `repair_templates` and `repair_ignore` (the "Core rewrite" category). It is a new `vendor_layer stack-lines` step that runs right after `review_config fix`, because the review facts are seeded after `migrate`. Decided by: `plugins/ok/CLAUDE.md` ("the suite's own retired layouts migrate under true-up").
- The steps, in order, each idempotent:
  - (a) Where the carried stack tool's `stack_defects` (through `carried_module(STACK_SRC)`, names from the ports module's `declared_names`) finds a defect in `stack`, the step writes no stack line. The existing `config` offer already lists that defect, and the next true-up after the fix writes the lines.
  - (b) Where the section already has a `stack-start`, `stack-stop`, or `- No stack:` line, the step writes no stack line. Where its `stack-start` line does not call `.ok-planner/bin/stack` while the key declares `start`, the `stack-lines` offer names the section, since those lines, perhaps left from v25.3.0, now start the stack in the key's place. It reads the section with the carried review module's `drive_commands` and its no-stack pattern.
  - (c) Otherwise, where the key declares `start`, the step appends `` - `stack-start`: `.ok-planner/bin/stack up --name drive` `` and `` - `stack-stop`: `.ok-planner/bin/stack down --name drive; s=$?; .ok-planner/bin/stack cleanup; exit $s` `` at the end of `## Drive commands`, so every drive and confirm round still runs the cleanup v26.0.0's converge ran, and the line exits with the status of `down`. Where the key declares `none`, it appends `- No stack: <why>`, with the reason's whitespace collapsed to one line. It creates the section at the file's end where the section is missing. The start command stays in the key alone.
  - (d) Where the section's `stack-start` line is the one (c) writes, each role line that names `{tag}` becomes `t=$(.ok-planner/bin/stack tag drive) && <the line, with each {tag} replaced by "$t">`, so the line fails where no run holds the name instead of running with an empty tag.
  - (e) `compose-ports` and `compose-labels` leave `lint_checks` in `.ok-planner/config.json`, through `write_owner` and `dumped`. The step drops `lint_checks` where nothing else is left in it. The `stack` key stays as it stands.
  - The review facts are written before the configuration. A crash between the two writes re-runs as case (b) followed by (e).
  - Decided by: the work item, the amended ruling (point 6), and coding rules 3 and 6.
- The run name is the constant `DRIVE_RUN_NAME = "drive"`. The drive and the audit's deployment share one stack per checkout, as v25.3.0's stack-start lines did. A second concurrent start is refused, and the refusal names `stack down --name drive`. Decided by: the work item ("under one run name").
- A skeleton review facts file also gets the stack lines (c) writes, so the drive and the audit's deployment still start the stack the key declares, as v26.0.0's did from a skeleton. `seeded_project_md` strips exactly those lines before it compares, so the `review-facts` offer still stands. Decided by: the Trued-up projects boundary and coding rule 6.
- Left alone: a symlinked or undecodable review facts file (`CALLER_LEFT` kinds); a pending `.ok-review/` move. Decided by: `decision:whole-file-ownership`.
- The new cleanup offer is `stack-lines:.ok-planner/review/project.md`. It lists the cases left: a symlinked or undecodable file; a `{tag}` that (d) does not rewrite; and each other line in the file that names `{tag}`, "run tag", or `stack list` for a tag the drive brief no longer carries. Its draft is the whole review facts file, which `resolve` writes. A malformed key is not listed there, because the `config` offer covers it. Decided by: the work item ("a cleanup offer that names what it left").
- `src-tag`, `port-block`, `planner-port-block`, and the texts built on them name `.ok-planner/bin/run-tag` for the tag and `.ok-planner/bin/ports lease <tag>` and `release <tag>` for the ports. They name the reference stack tool, run as a bare `stack up` from the `stack` key, as the option for a project with no tooling of its own. Decided by: `decision:stack-helpers-serve-project-commands`.
- Stages that touch `admin/true-up` overlap the helpers, rebuild, migration, payload-copy, and citation work. They chain with each other and with `checks/owned-paths`. Decided by: the sprint's execution rule that overlapping stages chain.
- `admin/true-up::ports_answer` parses the port registry's own refusal prefix, not `STACK_REFUSAL = "stack: "`, and names the ports helper in its failure exit. Decided by: the implementation notes review.
- `migrate_stack_lines` skips step (a) and every later step wherever `config-check` reports a defect, which the `config` offer already covers, so the carried ports module's `Refusal` on a malformed `ports` does not stop true-up. Decided by: coding rule 4 step 3.
- The new diagnose line "DRIFT: stale: … true-up writes them" leaves out every case the step leaves alone: a symlinked or undecodable file, a pending `.ok-review/` move, and a malformed key. Otherwise diagnose reports drift that true-up never clears. Decided by: accept-list A9.

**Changes**
- `admin/true-up::migrate_stack_lines`: new. It is cited `@story: true-up-project-estate`, `@decision: stack-helpers-serve-project-commands`, and `@decision: reference-stack-runs-the-declared-stack`, the site that reads the key.
  - Diagnose gains a `DRIFT: stale: .ok-planner/review/project.md — its ## Drive commands section gives no stack line while .ok-planner/config.json declares stack; true-up writes them` line, a `{tag}` line, and a `DRIFT: retired layout: .ok-planner/config.json — its lint_checks names compose-ports, compose-labels; true-up removes them` line.
  - `offers()` adds `stack-lines`, and `resolve` handles it as `review-facts` is handled, with `write_text`.
  - The bash flow calls `vendor_layer stack-lines` after `review_config fix` and prints the step's `rewrote:` lines.
- `admin/true-up::DRIVE_RUN_NAME`: new constant.
- `admin/true-up::port_range_offer`: triggers only on declared `ports`, or on the retired object form; no compose lines; its texts say "the port registry".
- `admin/true-up::stack_command`, `stack_answer`, `STACK_SRC` (for ranges): become `ports_command`, `ports_answer`, `PORTS_SRC` (`carried_module(PORTS_SRC).PORT_NAME`), used by `range_refusal`, check-range, and the offer. `STACK_SRC` stays for the `stack_defects` import in `migrate_stack_lines`.
- `admin/true-up::PLANNER_RETIRED`: the `run-tag` and `ports` entries leave it. `planner-port-block` stays.
- `admin/true-up::NO_DROP_IN`: `run-tag`, `planner-run-tag`, and `planner-ports` leave it, with `TAG_NO_DROP_IN`. `STACK_DECLARED` and `STACK_RUN` are reworded to the helper model as the call above says, and serve `PORTS_NO_DROP_IN` and the `src-tag` text.
- `admin/true-up::WS_DROP_INS["run-tag"]`: becomes `.ok-planner/bin/run-tag`, the suite's copy as v25.3.0 named it.
- `admin/true-up` line 1853: the `stack-tool-runs-each-run` citation on `retired_scripts` goes with the site it marked, run-tag's retirement.
- `admin/ADMINISTRATION.md`:
  - Lines 16, 21, and 23 say "as the port registry checks it".
  - Offer table row 89 keeps "a malformed `stack` declaration among them".
  - Row 92 loses the compose trigger and `stack up`, and says the port registry leases nothing without a range.
  - Row 106 drops `.ok-planner/bin/ports` and `.ok-planner/bin/run-tag` and keeps `port-block`.
  - Row 123 drops the compose variables.
  - New row and draft rule for `stack-lines`.
  - The `review-facts` draft bullet (line 117) adds the stack lines: a declared `start` gives the two lines that call the reference stack tool, and `none` gives `- No stack: <why>`.
  - A new "Stack declaration" paragraph describes the migration: the key stays, the lines are written, `{tag}` is rewritten, and the compose `lint_checks` names are removed.
  - Lines 243 to 249 give the retired-script set and texts.
  - Audit row 261: `stack` is the reference stack tool's setting, and `ports` and `port_range` the port registry's.
  - Audit row 265 is inverted: the drive reads the `stack-start`, `stack-stop`, and `- No stack:` lines. A finding is a section with none of them while the config declares `stack` (core rewrite, pending while diagnose reports it), or a `- No stack:` line beside a stack line (report line).
  - The sentences at line 276 that draft `stack` from the lines go.
  - The `stack-start` clause of the report-line bullet at line 277 goes.
  - "The suite never edits … the review facts" gains "apart from the stack lines and the `{tag}` rewrites the stack migration writes".
  - The owner-file exceptions paragraph (near line 390) lists the migration's writes to `review/project.md` and to `lint_checks`.
- `docs/integration-contract.md` lines 250 to 255: the retired-script list.
- `checks/owned-paths`: the region and subprocess site are renamed to `ports_command`. The `migrate_stack_lines` region and its `write_owner` sites (`planner_config`, the review facts) are added.
- `.ok-planner/design/decisions/port-range-chosen-at-true-up.md`: the delta applies.

**Improvements**
None.

**Behavior changes**
- **B42** `admin/true-up` stack migration. Before: none; v26.0.0's audit drafted `stack` from v25.3.0 lines. After: true-up writes stack lines in the owner's review facts, rewrites `{tag}`, and removes the compose names from `lint_checks`. It leaves `stack` in place. Diagnose prints the new drift lines. Across Trued-up projects: every v26.0.0 project with a `stack` key, `{tag}` lines, or compose `lint_checks`. It also changes two things a migrated project sees: the cleanup v26.0.0's converge ran after each drive and confirm round now runs from the written `stack-stop` line, and the drive's run holds the fixed name `drive`, which `up --name` frees when nothing still uses it. Ruling: migrate: stored data is converted in place, the project's stack starts and stops through the same key, and an offer covers what is left (call).
- **B43** `admin/true-up::port_range_offer`. Before: offered when a compose file publishes a port, and the draft adds the compose variables. After: offered only on declared `ports`. Across Trued-up projects: compose-only projects lose the question. Ruling: rewrite (the approved amended decision).
- **B44** `admin/true-up::PLANNER_RETIRED`, `NO_DROP_IN`, `WS_DROP_INS`. Before: `run-tag` and `ports` are retired, and callers of the workspaces `run-tag` get issues. After: both are materialized, and callers of the workspaces `run-tag` are repointed. Across Trued-up projects: issues already filed stay open, for triage to answer once the code no longer shows them. Ruling: migrate: callers are rewritten under the existing repoint rule (call).
- **B45** `admin/ADMINISTRATION.md` offer table, draft rules, and audit rows. Before: v26.0.0's. After: the helper model, as listed. Users: in the release: `/ok`. Ruling: rewrite.
- **B46** `admin/true-up` check-range and `amend`'s range refusal. Before: run through the stack tool. After: run through the ports module, with the same messages. Across Trued-up projects: owners at `/ok`. Ruling: preserve (call).

### The reuse rule prevents import cycles

**Calls**
- The "Prevents:" line of rule 6 adds "an import cycle that reuse closes". Decided by: the work item.

**Changes**
- `docs/plumbline-coding.md` rule 6 step 2: also check that the import closes no cycle. Where reuse would close one, break the cycle so every import points one way, in the project's own shape. An import placed inside a function to dodge a circular-import error is a defect, fixed by breaking the cycle. A project checks for cycles with a tool for its language. Nothing is said about where shared code lives.
- `docs/plumbline-cheatsheet.md` "Mechanical Checks": "import cycles → cycle check" beside the dependency lint.

**Behavior changes**
- **B29** the rules text. Before: weight only. After: weight and cycles. Users: in the release: agents. Ruling: rewrite.

### A project can make its instance-story drives wait

**Calls**
- The mark is the line `- One at a time` (optionally `: <why>`) under "## Stories that drive on an instance of their own", matched by `^- One at a time\b`. Decided by: the shape of `- No stack:`; the story pattern already skips it.
- With the mark, each instance drive is filed `--after` every task already filed, which covers "after every other driver" and "after the one before" in one rule; `--confirm` takes the same path. Decided by: `decision:instance-drives-serial-on-a-project-mark`.

**Changes**
- `scripts/review::story_lists`: also returns the mark.
- `scripts/review::cmd_drives`: with the mark, the order is non-alone non-instance drives, then alone drives, then instance drives, chained. Without the mark the order is unchanged.
- `admin/true-up` review entry: `# @decision: instance-drives-serial-on-a-project-mark`.
- `review/seed/project.md`: describes the mark.
- `skills/converge/SKILL.md` step 3: describes the order.

**Behavior changes**
None. Every change is new code no existing user reaches. The seed text is B8.

### True-up proves a payload copy before it skips a file

**Calls**
- For each ancestor folder F of a file f that holds `admin/true-up` and `admin/ADMINISTRATION.md`, f is skipped only where `os.path.isfile(os.path.join(family_dir, relpath(f, F)))`. The `inside(…, family_dir)` skip stays. Decided by: `decision:retired-script-repoint-needs-a-proven-root`.

**Changes**
- `admin/true-up::payload_copy_file`: as above, cited `retired-script-repoint-needs-a-proven-root`.
- `admin/ADMINISTRATION.md` line 247: the skip clause says the same.
- `.ok-planner/design/decisions/retired-script-repoint-needs-a-proven-root.md`: the delta applies.

**Behavior changes**
- **B30** `admin/true-up::caller_kind`. Before: every file under a payload copy is skipped. After: a file the running payload lacks counts as a caller. Users: in the release: this repository (new payload files that name a retired path file issues until the next release). Ruling: rewrite (the delta's accepted cost).

### Every citation names a live decision

**Calls**
- `admin/true-up` lines 242 and 243 (the stack entry) cite `stack-helpers-serve-project-commands`, `reference-stack-runs-the-declared-stack`, and `run-artifacts-found-by-run-tag`; line 393 (`LINT_CHECKS`) cites `project-chooses-its-lint-checks`; line 1853 goes with its site. Decided by: the work item.

**Changes**
- The four citation lines above in `admin/true-up`, the tree's only uses of the three retired slugs (searched across `plugins/`, `checks/`, `docs/`, and `.claude/skills/release`).
- The three retired decision files are deleted, the `run-tag` concept delta applies, and `.ok-planner/design/decisions.md` and `concepts.md` are regenerated with `catalog-toc`.

**Behavior changes**
None. Every change is new code no existing user reaches.

## How to execute this sprint

This sprint is self-sufficient. Every executor — an inline session,
an agent handed this file via `/goal`, an orchestrator with its own
planning — runs the same shape: record the base commit, plan the work
into the task tracker as small build tasks cut from the
implementation notes, drain them, then run sprint certification once.
No review runs during the build.

1. Read the sprint whole first: intent, deltas, work items,
   implementation notes, completion contract. The sprint is the whole
   brief: context from the intake (`.ok-planner/issues.jsonl`) or
   `history/` may disagree with what the owner approved. Raise a gap
   with the owner.

2. Record the base. Sprint certification reads the change from this
   commit, so the tree holds nothing but this sprint's work from here
   on. The planning session leaves its own files uncommitted: this
   file, its delta sidecar, `.ok-planner/release-boundaries.md`, the
   intake's two files (`.ok-planner/issues.jsonl` and
   `.ok-planner/history/issues.jsonl`), and the sketches it archived. Where `git
   status --porcelain` lists a path outside `.ok-planner/`, name those
   paths to the owner and stop, because certification would count
   them as this sprint's work. Otherwise write the output of `git
   rev-parse HEAD` to the file beside this sprint with the same
   filename, `-base` before the extension and `.txt` as the
   extension.

3. Open the run. The task tracker at `.ok-planner/bin/tasks` and the
   profiles under `.claude/agents/` are required; a missing one is
   the front door's administration (`/ok`) to materialize: say so and
   stop. `tasks init <sprint-name> --file
   .ok-planner/sprints/<sprint-name>-run.jsonl`, `tasks agent
   register ok-opus`, and register the `build` prompt: write
   `{{SPRINT-BUILD-PROMPT}}` from `.claude/skills/_sprint/shared.md`,
   its transclusions resolved and `[SPRINT PATH]` filled, to
   `.ok-planner/sprints/<sprint-name>-build.md`, then `tasks prompt
   register build <that path>`. Declare the roles whose close carries
   a sweep: `tasks config set swept_roles '["build", "fix"]'`, so a
   build task closes `done` only with the sites its searches
   returned, each one staged.

4. Plan the work into stages from the implementation notes. Read the
   code each work item's notes name, in the tree as it stands now,
   before you file anything. Where the tree has moved since the
   notes' commit and a named site no longer matches, plan from the
   outcome the notes state and record the difference as a divergence
   call. Cut the sprint into stages, each **the smallest change that
   makes progress toward the completion contract and leaves the tree
   runnable**: it builds, nothing is half-wired, and the work after it
   can build on it. A stage lands one work item or a part of one. A
   work item that needs more than one agent's reading set becomes
   several stages in sequence. A taken improvement lands in the same
   stage as the change to its definition. Per stage, file one build
   task: `tasks file --role build --prompt build --agent ok-opus
   --key <stage> --files <the paths it may edit> --cites <the work
   items and slugs> --after <the build tasks of the stages it builds
   on, omitted where it builds on none> --brief "<the work items it
   lands, the improvements and deltas it applies, the behavior
   changes it carries by id with their rulings, and where the code
   is and what to reuse>"`. Two stages whose files overlap are
   chained with `--after`; a stage that applies a delta reaches its
   collection's catalog TOC too (`.ok-planner/design/concepts.md`,
   `stories.md`, or `decisions.md`, or `.ok-planner/subjects.md` or
   `.ok-planner/practices.md`, every one of which
   `python3 .ok-planner/bin/catalog-toc` regenerates), so two
   delta-bearing stages overlap. Stages with disjoint files run together. Apply a
   delta no work item implements in a stage of its own.

5. Render the completion report with the staged list before the first
   drain: write the output of `tasks render --title "<this sprint's
   title>" --sprint <this sprint's path>` to the report file (step
   10).

6. Keep the progress checklist. Where the harness task tools are
   available, mirror the stages as a live checklist. Create one entry
   per stage when the build tasks are filed. Mark an entry in progress
   when its build task is dispatched, and done when that task closes
   `done`. Add one entry for sprint certification when the drain ends.
   The run file is the record and the checklist is display.

7. Drain with the loop at `.claude/skills/_tasks/drain.md`.
   A build that closes `partial` is refiled for its remainder with
   `tasks refile <task>`; one that closes `partial` with a result
   starting `outside files:` is refiled with that path added to its
   files. A build that closes `blocked` is refiled once. The session
   builds nothing and reviews nothing itself, and edits no file a
   running task owns.

8. Every stage applies its corpus deltas as part of the work that
   realizes them, and every new or amended story implemented in code
   carries the `@story:` annotation at the site that realizes it. The
   build prompt carries both rules. `.ok-planner/audits/` and
   `.ok-planner/experiments/` belong to `/audit`.

9. Uncommitted work is the only record of the run. Every task stages
   the paths it touched as it closes (`git add <paths>`), and the run
   records them. Never run `git checkout`/`restore`/`reset`/`stash`/
   `clean` on your own initiative. Fix a bad edit forward by editing
   again.

10. The completion report lives beside this sprint file, same
    filename with `-completion` before the extension. The session
    re-renders it whole from the run before every dispatch: `##
    Stages` from the build tasks and `## Divergences` from the run's
    `divergences` pool. Build tasks record calls, forks, and what
    they noticed as items; the report is rendered, never
    hand-edited.

11. Work unsupervised to a defensible done. Do not pause for
    approval, confirmation, or progress checks. Execution and sprint
    certification need no owner action: file no task for the owner to
    perform. The archive and the commit after completion stay the
    owner's one act. Stop only on a genuine blocker: a credential or
    access you cannot obtain, a step impossible in the current state,
    a destructive or irreversible action not clearly authorized, a
    task closed `blocked` twice, or sprint certification being
    unrunnable for you. Surface that and stop. Ambiguity is not a blocker: the builder makes the most
    plausible call and records it, or records a fork and builds the
    reading it judges best. Sprint certification reads both.

12. Code complete means every stage's latest build task closed
    `done`. Then run sprint certification, immediately after:
    `/converge sprint <this sprint's path>`. It judges the change
    from the commit in the `-base.txt` file to the working tree,
    once, against this sprint: every outcome and taken improvement
    works, a user gets what every story promises when a driver uses
    the running product, every delta landed, every ruling holds, no
    unlisted behavior change breaks a user, and the project's checks
    pass. It fixes each defect in the sprint's scope, a drive failure
    the sprint's change caused among them, and verifies each fix on
    its own diff. A drive failure in code the change did not reach,
    and any other defect outside the sprint's scope, goes to the
    intake as a `category: defect` issue for the next `/converge`,
    and a question only the owner can decide goes to the intake for
    the next `/plan-sprint`.
    It ends by presenting its return block.

13. Write the return block into the completion report, after its
    rendered sections, under a `# Sprint certification` heading, with
    the `/converge` run's ledger path. Nothing renders the report
    after this. Then present the completion report and offer the
    archive and the commit below as one owner act. Ask the owner
    nothing else: every defect the run could not fix and every
    question it raised is already in the intake, for the next
    `/converge` or `/plan-sprint`.

**The archive and the commit.** The owner archives this sprint and
commits the work; offer both as one owner act, and wait. "Finish the
sprint" and "follow the boilerplate" are not a yes; both ask for the
presentation. On the owner's yes:

1. Close each issue this sprint promoted: for each id that
   `.ok-planner/bin/issues list --sprint <this file's name>` prints,
   run `.ok-planner/bin/issues close <id> --as promoted`, which moves
   its record to `.ok-planner/history/issues.jsonl`.
2. Move this file, its completion report, its run file, its
   `-base.txt` file, its `-build.md` prompt, and its delta sidecar to
   `.ok-planner/history/sprints/`: `git mv` for a tracked file, `mv`
   for an untracked one.
3. Stage by name every path the sprint's change touched, every moved
   file at its new path, the `/converge` run's ledger and folder, and
   the intake's two files, `.ok-planner/issues.jsonl` and
   `.ok-planner/history/issues.jsonl`. Commit those paths alone
   with `git commit -- <paths>`, naming only paths that exist or that
   `git mv` removed, so nothing else standing in the index rides
   along.
4. Add `closed: <the commit's sha>` to the archived sprint as YAML
   frontmatter, and commit that edit alone. The next planning
   session reads that stamp to detect work done out of band.

The owner publishes; the run never pushes.

## Completion contract

The work is done when all of the following hold, each verifiable
from the repository as it stands:

1. Every corpus matches every delta above, applied verbatim (from
   the sidecar where a heading points there): `.ok-planner/design/`
   for a concept, story, or decision, and `.ok-planner/subjects/` or
   `.ok-planner/practices/` for a subject or practice, with its
   catalog TOC regenerated.
2. The project builds, and the checks `.ok-planner/review/config.json`
   lists under `checks` pass on every file the change touched, or fail
   only where sprint certification's return lists the failure as a
   `stuck` defect.
3. The completion report beside this sprint (same filename with
   `-completion`) carries the return block of sprint certification
   (`/converge sprint`) run on this sprint, under `# Sprint certification`: the run's find
   loop ran once, and every defect stands `verified`, `declined`,
   `duplicate`, or `stuck`, with every `stuck` defect listed for the
   owner.

**The goal rule, for any checker verifying this contract.** The goal
is met when items 1–3 verify against the repository as it stands.
Decide from the repository, never from the session transcript: an
earlier session may have done the work, and a term the transcript
does not show may hold on disk. A `stuck` defect listed in the
return, a check that still fails among them, is the owner's to take
up, and holds no term of the contract open.
Presenting the report, archiving, committing, and the
`closed:` stamp all follow completion; a pending archive-and-commit
offer is evidence the goal is met. `sprints/` and
`.ok-planner/history/sprints/` satisfy the rule alike, and a sprint
already archived with a `closed:` stamp is terminal. A missing
completion report, or one without the return block,
means not done. Nothing else counts either way.
