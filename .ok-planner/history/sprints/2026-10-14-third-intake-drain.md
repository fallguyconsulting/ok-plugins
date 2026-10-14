---
closed: 45678885143286ced004b59addd48e2390a1718d
---

# Sprint: Third intake drain

## Intent

This sprint drains the intake. It has no single theme. It carries every open issue's ruling into the corpus and the code: a project-local port registry with a run's artifacts removed at its end; several people working one intake, each with their own reading; certification that drives every story, every variant a story names; a merge that sorts drive failures by the story's text; work items that always change the product; a dashboard drive that serves the page the tree builds; the administration act renamed true-up; true-up's repoint limited to prefixes it can prove; discovery notes treated as records and archived on consent; and five defect fixes. It also brings the corpus up to the discovery notes' move into the archive, made outside a sprint in commit 515ac2d.

Promoted issues: port-block-reads-back-a-stale-record, per-run-artifacts-never-removed, foreign-author-message-renders-as-agent, new-issues-show-no-unread-mark, issues-show-omits-update-diff, sprint-certification-drives-only-sprint-stories, drive-pass-is-one-try, merge-sorts-drive-failures-off-the-story, agents-route-clear-defects-to-the-owner, sprint-work-item-operates-the-product, dashboard-drive-reads-stale-page-build, converge-names-true-up-and-a-command, retired-script-reference-root-prefix-unsettled, discover-design-offers-to-archive-its-notes, converge-repoints-observation-notes-and-migration-docs, audit-auditors-skip-declared-folders, converge-strips-uncommitted-story-and-decision-text, settings-audit-reports-valid-estate-script-hooks, dashboard-holds-goal-evaluation-open.

## Corpus deltas

Every body lives in the sidecar folder `2026-10-14-third-intake-drain-deltas/` beside this file. A retirement carries only its heading.

### Amend concept: completion-contract

body: in the sidecar

### Amend concept: design-corpus

body: in the sidecar

### Amend concept: estate

body: in the sidecar

### Amend concept: integration-contract

body: in the sidecar

### Amend concept: issue

body: in the sidecar

### Amend concept: materialized-artifact

body: in the sidecar

### Amend concept: run-tag

body: in the sidecar

### Amend concept: sprint

body: in the sidecar

### Amend concept: true-up

body: in the sidecar

### Amend story: see-new-analysis

body: in the sidecar

### New story: true-up-project-estate

body: in the sidecar

### New story: verification-leaves-no-artifacts-behind

body: in the sidecar

### Retire story: converge-project-estate

### Amend decision: accept-list-decides-defects

body: in the sidecar

### Amend decision: administration-is-a-user-act

body: in the sidecar

### Amend decision: agent-revisions-reach-the-owner

body: in the sidecar

### New decision: anyone-may-rule

body: in the sidecar

### Amend decision: closed-answers-count-as-new

body: in the sidecar

### New decision: discovery-notes-archived-on-consent

body: in the sidecar

### New decision: drive-serves-the-tree-page-build

body: in the sidecar

### Amend decision: drive-tries-each-story-as-a-user

body: in the sidecar

### Amend decision: flagged-issues-discussed-in-session

body: in the sidecar

### Amend decision: intake-reads-past-stray-lines

body: in the sidecar

### New decision: live-sprints-brought-current-on-true-up

body: in the sidecar

### Amend decision: lockstep-suite-version

body: in the sidecar

### New decision: messages-carry-their-authors-name

body: in the sidecar

### New decision: messages-styled-by-type

body: in the sidecar

### Amend decision: one-vendored-family

body: in the sidecar

### Amend decision: owner-messages-can-change

body: in the sidecar

### Amend decision: per-project-pinning

body: in the sidecar


### New decision: pinned-build-placed-at-true-up

body: in the sidecar

### New decision: port-range-chosen-at-true-up

body: in the sidecar

### New decision: ports-leased-from-a-project-range

body: in the sidecar

### Amend decision: project-chooses-its-lint-checks

body: in the sidecar

### New decision: read-marks-kept-per-person

body: in the sidecar

### New decision: run-artifacts-removed-with-the-run

body: in the sidecar

### Amend decision: records-stay-out-of-context

body: in the sidecar

### Amend decision: release-boundaries-bind-changes

body: in the sidecar

### New decision: retired-layout-strips-only-recoverable-files

body: in the sidecar

### New decision: retired-script-repoint-needs-a-proven-root

body: in the sidecar

### Amend decision: runs-fix-what-the-project-owns

body: in the sidecar

### New decision: stack-ports-checked-as-a-suite-rule

body: in the sidecar

### Amend decision: task-tools-mirror-the-report

body: in the sidecar

### Amend decision: team-execution-cold-gate

body: in the sidecar

### Amend decision: triage-answers-owner-messages

body: in the sidecar

### New decision: unread-issues-count-as-new

body: in the sidecar

### Amend decision: vendored-skills

body: in the sidecar

### Amend decision: whole-file-ownership

body: in the sidecar

### New decision: work-items-change-the-product

body: in the sidecar

### Retire decision: os-assigned-ports-read-back-by-run-tag

### Retire decision: pinned-build-placed-at-converge

## Work items

Every item below calls the administration act "true-up" and keeps "converge" only for the `/converge` defect run. Canonical sources live under `plugins/ok/families/ok-planner/`. The vendored copies under `.claude/` and `.ok-planner/bin`, `.ok-planner/scripts`, and `.ok-planner/hooks` change only when true-up runs, so no item edits them.

How to tell the two senses apart in the enumeration (`rg -n -i 'converg' plugins/ .claude/skills/release README.md docs/ checks/ .claude-plugin/ .ok-planner/release-boundaries.md .ok-planner/review/project.md`):

- **Keep (the defect run):** every `/converge` and `/converge sprint`; the skill folder `skills/converge/` and its prompts; `skills/_converge/` and its `{{CONVERGE-CODING-RULES}}` block, including "converge skill" and "converge agent" in `_converge/coding-rules.md`; the core's `SKILLS` entry `"converge": "converge"`, `UNPREFIXED`, `SHARED`'s `_converge`, and the retired names `converge-local` and `converge-cascade`; the core's messages about `/converge`'s prompts (around its lines 2007, 2023, 2720); `AGENT_AUTHORS`'s `converge` in `scripts/issues` and `browser/src/lib/api.js`, and the `converge` author in `skills/_shared/artifact-definitions.md`; the dashboard's `.converge` CSS class and its `/converge` link in `browser/src/App.svelte`; the review seed config's `prompts_dir` and `block_sources`; `checks/token-resolution`'s `_converge`; the review tally's `stop: converged`; "the converge coding rules" in the decision single-source-transclusion.
- **Rename (the administration act):** everything else, including "converged project", "converges it", "on every converge", "estate convergence", "re-converge", and "its last convergence".

### The port allocator leases a run's host ports from the project's range, replacing `port-block`

- Issues: port-block-reads-back-a-stale-record
- Makes true: decision:ports-leased-from-a-project-range, story:concurrent-stacks-without-port-collisions
- Outcome: A new suite script, `plugins/ok/families/ok-planner/scripts/ports` (python, like the script it replaces), takes the place of `plugins/ok/families/ok-planner/scripts/port-block`, which is deleted. The true-up core (`plugins/ok/families/ok-planner/admin/true-up`) materializes it to `.ok-planner/bin/ports` with mode 755 in place of `.ok-planner/bin/port-block`, and runs `ports --help` once after writing it, where it ran `port-block --help`. `checks/materialized-standalone` lists `ok-planner/scripts/ports` in place of `ok-planner/scripts/port-block`.
  - `ports lease <run-tag>` refuses a value that is not a run tag (`run-<12 hex>`). It reads the port names (`ports`) and the provisioning range (`port_range`) from `.ok-planner/config.json`. With no range, it refuses, exit 1, with a message that names the missing range and says to run `/ok`. It refuses a range that reaches the start of the machine's ephemeral range, read from `sysctl net.inet.ip.portrange.first` on macOS and `/proc/sys/net/ipv4/ip_local_port_range` on Linux, 49152 where it cannot read the value, naming both numbers, so a range committed on one system and run on another fails loudly.
  - Under one lock in `.ok-planner/.cache/`, it reads the registry (`.ok-planner/.cache/ports.json`), picks one port per declared name from the range, skipping every port another run of the project holds a lease on, every port any program on the machine holds bound or listens on at that moment, and every port on the block list, then writes the lease (the run tag, each name and its port, the time) to the registry through a temporary file and one rename. The registry stays out of git, as the task tracker's index does.
  - The block list is the suite's own list of the ports that protocols, apps, and services use by default, including popular defaults no registry lists (such as 4200, 5173, 6379, and 27017), carried once in the payload as a data file both this script and the true-up core read, plus every port the machine's services database (`/etc/services`, where it exists) lists.
  - It prints one `NAME=<port>` line per declared name, in declared order, on stdout, a form a shell exports and docker compose reads as an env file. A second `lease` for a run tag that already holds a lease replaces its batch with a fresh one, skipping every port held at that moment: this is the retry after a loud bind failure.
  - Where the range holds too few leasable ports, it refuses, naming the range, the count it needs, and the count free.
  - `ports release <run-tag>` ends the run's lease under the same lock, and prints nothing and exits 0 when the tag holds none.
  - Every exit of a write releases the lock (`try/finally`). The script's owner frame catches the top-level type and emits one event of kind `PORTS.RUN.FAILED` with the stack trace, as `port-block`'s owner frame did; a refusal of the user's input exits 1 with a message the user can act on. The true-up core cites `@decision: ports-leased-from-a-project-range` at its materialization row for the script; the script itself carries no citation, since a materialized file carries none.
  - The core removes `.ok-planner/bin/port-block` from a project an earlier release laid out, as a retired suite script: no current copy behaves as it did, so the core files one intake issue for each tracked file that still calls it (listing each line, and saying to declare the port names and range through `/ok` and call `.ok-planner/bin/ports lease` with the run's tag), and removes the script once no tracked file other than a record names it, per decision:whole-file-ownership. The core's message for the retired workspaces `port-block` (the `WS_DROP_INS` reason text) names `.ok-planner/bin/ports lease` in place of the read-back.
  - Enumeration the build starts from: `rg -n 'port-block|port_block|PORTBLOCK' plugins checks docs README.md .ok-planner/review/project.md`.
- Depends on: The configuration declares port names and a provisioning range

### The port cleanup frees stale leases and removes the artifacts of dead runs

- Issues: port-block-reads-back-a-stale-record, per-run-artifacts-never-removed
- Makes true: decision:ports-leased-from-a-project-range, decision:run-artifacts-removed-with-the-run, story:verification-leaves-no-artifacts-behind, concept:run-tag
- Outcome: `.ok-planner/bin/ports cleanup` (in `plugins/ok/families/ok-planner/scripts/ports`) runs under the registry's lock and does two things, then prints one line per lease it freed and one line per run tag whose artifacts it removed.
  - It frees each lease none of whose ports any program holds and whose compose project (the project the run tag names) has no containers left, running or stopped. A lease whose ports something still holds, or whose compose project still has a container, stays. A lease less than one hour old stays too, so a run between its lease and its stack's bind keeps its lease.
  - It removes the container artifacts of every run tag that holds no lease, after the frees, has no containers left, and has no artifact created in the last hour: every image tagged with the run tag, and the volumes and networks of the compose project the tag names. It finds those tags from docker itself, by the `run-<12 hex>` pattern, so it reaches every run whatever started it, the audit's experiments included, and runs whether or not the project declares a range or ports.
  - Where docker is not on PATH, it frees leases by the port check alone and prints one line saying it removed no container artifacts. A docker call that fails propagates to the owner frame, which emits `PORTS.RUN.FAILED`; the lock is released on every exit.
  - Artifacts of other kinds stay the project's stack stop's job, as the rules text says.
  - The true-up core cites `@decision: run-artifacts-removed-with-the-run` at its materialization row for the script; the script itself carries no citation.
- Depends on: The port allocator leases a run's host ports from the project's range, replacing `port-block`

### The configuration declares port names and a provisioning range

- Issues: port-block-reads-back-a-stale-record
- Makes true: decision:ports-leased-from-a-project-range, decision:port-range-chosen-at-true-up
- Outcome: In `.ok-planner/config.json`, `ports` is a JSON array of port names, each a `NAME` (upper-case letters, digits, and underscores, not starting with a digit), with no name twice, and `port_range` is an object `{"first": <port>, "last": <port>}` with integers, `first` above 1024, `last` at most 65535, and `first` at most `last`.
  - The lint's `config-check` (`plugins/ok/families/ok-planner/scripts/plumbline`, `portsDefects` and the `CONFIG_KEY_DEFECTS` table) checks both keys and reports each defect by name. It reports the retired object form of `ports` (a `service`/`port` or `record` entry) as a defect that names the form as retired and says `/ok` converts it.
  - The true-up core's `CONFIG_CHECK_KEYS` adds `port_range`. `amend` refuses a draft whose `port_range` reaches the machine's ephemeral start, read as the allocator reads it, naming both numbers.
  - A config whose only defect is the retired `ports` form gets the `port-range` offer, which converts it, and no `config` offer for that defect.
  - `plugins/ok/families/ok-planner/admin/ADMINISTRATION.md`: the **Ports.** paragraph says what `ports` and `port_range` hold, that `.ok-planner/bin/ports` leases from the range by run tag and refuses until a range exists, and that a project with no ports needs neither key. Each list of the keys the lint reads (the `config` offer's draft text, the `config-check` paragraph, the audit's table row for `.ok-planner/config.json`, and the `amend` refusals) adds `port_range`.
  - `plugins/ok/families/ok-planner/scripts/ok-planner-CLAUDE.md`'s configuration paragraph names the port names and the provisioning range the allocator leases from, in place of "the names `bin/port-block` prints".
  - This project's own `.ok-planner/config.json` declares no `ports` and no `port_range`, and gains neither: this project publishes no ports and has no compose file.
- Depends on: none

### The lint checks every host port a compose file publishes

- Issues: port-block-reads-back-a-stale-record
- Makes true: decision:stack-ports-checked-as-a-suite-rule, decision:project-chooses-its-lint-checks
- Outcome: `plugins/ok/families/ok-planner/scripts/plumbline` gains a lint check named `compose-ports`, with no new dependency.
  - It reads every compose file in the project's folders that the lint does not ignore (`compose.yaml`, `compose.yml`, `docker-compose.yaml`, `docker-compose.yml`, and their `compose.*.yaml`-style override files) and each `ports` entry of each service, short form and long form (`published:`).
  - It reports, one violation per entry, at the entry's line: (1) a host port given as a bare number, or an entry that names no host port, so the operating system would pick one; (2) a host port whose variable has no fallback; (3) a variable whose name is not a port name `ports` in `.ok-planner/config.json` declares; (4) a fallback inside `port_range`, where the project declares a range. An entry such as `"127.0.0.1:${WEB_PORT:-8080}:8080"` passes when `WEB_PORT` is declared and 8080 lies outside the range.
  - Like the other checks, it is on by default and off only where `lint_checks` sets `compose-ports` to `false`. `LINT_CHECK_NAMES` in the lint and `LINT_CHECKS` in the true-up core both add it, and the core's `lint rules:` line names it. The edit hook (`scripts/hooks/post-edit.js`) runs it on a compose file an Edit or Write touches, limited to the changed lines as for the other checks. The true-up core cites `@decision: stack-ports-checked-as-a-suite-rule` at its `LINT_CHECKS`; the lint itself carries no citation.
  - The lint gains a read-only subcommand that prints, for each compose file, each host port it publishes and the variable name it uses, if any, so the true-up core reads compose files through the lint's one reader instead of a copy.
  - `ADMINISTRATION.md`'s **Lint checks.** paragraph lists `compose-ports` beside the other three.
- Depends on: The configuration declares port names and a provisioning range

### The suite's rules state the per-run port and artifact rule

- Issues: port-block-reads-back-a-stale-record, per-run-artifacts-never-removed
- Makes true: decision:stack-ports-checked-as-a-suite-rule, decision:run-artifacts-removed-with-the-run, decision:ports-leased-from-a-project-range
- Outcome: Three suite-owned rules files change.
  - `plugins/ok/families/ok-planner/docs/plumbline-coding.md` gains a rule 10, in the file's form (a title, a `Prevents:` line, numbered steps with the evidence each leaves). Prevents: a stack that publishes a bare host port or a fallback inside the range, so concurrent runs collide or a stack started without the allocator takes a leased port; and a run that leaves what it built on disk.
    - Every host port a stack definition publishes comes from an environment variable with a fallback, never a bare number.
    - Each variable's name is a port name `.ok-planner/config.json` declares under `ports`.
    - No fallback falls inside the project's provisioning range.
    - The stack's start leases its ports with `.ok-planner/bin/ports lease <run-tag>` and passes them to the stack's environment; on a bind failure it leases again for a fresh batch, within a retry budget. A server outside compose takes its port from the environment or a flag.
    - The stack's stop removes everything the run built under its tag, whether the run passed or failed, and ends the lease with `.ok-planner/bin/ports release <run-tag>`.
    - Check the port steps with the suite's lint where it applies, with a project lint, or with both. A project lint also checks the suite's other rules: no prose comments, every citation resolves, and no test edits. The sentence naming the suite's `compose-ports` check as the check for compose files sits between `<!-- lint-check: compose-ports -->` markers, so it leaves the file when the check is off; the rest of the rule stays.
    - The rule binds under accept-list entry A8, which already counts every rule in this file.
  - `plugins/ok/families/ok-planner/skills/_converge/coding-rules.md`'s `{{CONVERGE-CODING-RULES}}` block adds rule 10 to the rules it tells every converge coder to follow.
  - `plugins/ok/families/ok-planner/docs/plumbline-cheatsheet.md`'s Tooling list adds a `compose-ports` bullet between its own `lint-check` markers, and its config line names `ports` and `port_range`.
  - `plugins/ok/families/ok-planner/scripts/ok-planner-cheatsheet.md`'s "Per-run artifacts and verification stacks" section is rewritten to match the rule. It keeps the run tag's minting and its loud resolution. It says a run's artifacts end with the run: the tag's life is mint, build, verify, remove; the stack stop removes everything the run built under the tag, pass or fail; and the periodic cleanup frees stale leases and removes the artifacts of every run tag that holds no lease and has no containers left. It says host ports come from a lease on the project's own range, one per declared name, in place of ports the operating system assigns; that a container stack runs as the compose project the tag names; that the lease ends when the stack goes down; that the allocator refuses until `/ok` has set a range; that no other project on the machine may share the range; and that the registry serves one checkout. It drops "Never pick a port in one program for another to bind later", port 0, the read-back, and `port-block`'s exit 2. Its content-kinds bullets name `bin/run-tag` and `bin/ports` (minting a run's tag; leasing, releasing, and cleaning up its ports) and "the port names and the provisioning range the allocator leases from" in the `config.json` bullet.
- Depends on: The lint checks every host port a compose file publishes

### True-up walks the owner through choosing a port range

- Issues: port-block-reads-back-a-stale-record
- Makes true: decision:port-range-chosen-at-true-up
- Outcome: The true-up core (`plugins/ok/families/ok-planner/admin/true-up`) prints a `CLEANUP OFFERED (ok-planner): port-range:.ok-planner/config.json` block in diagnose and in true-up wherever the project publishes ports and declares no `port_range`. The project publishes ports when `ports` names any, in either form, or a compose file publishes a host port, which the core reads through the lint's subcommand where `node` is on PATH and skips otherwise. A project that publishes no ports gets no block. Diagnose exits 3 while only this offer is pending.
  - The block names each port it found (the declared names and each compose file's variables and bare ports) and suggests a range of 200 ports picked at random above 1024 and below the machine's ephemeral start (read as the allocator reads it, 49152 where it cannot). The suggestion lies in a gap no port on the block list touches (the shared data file and the services database) and holds no port any program listens on at that moment.
  - The block carries a `Draft:` line: the whole `.ok-planner/config.json` with `port_range` set to the range the owner chose, `ports` set to the names found (the retired object form's keys carried over), and every other key kept. Its consent command is `amend .ok-planner/config.json --from <draft>`.
  - The core gives the front door a read-only way to check an owner-named range before the draft is written: it refuses a range that reaches the ephemeral start, and where the range overlaps listed ports it names the ports the range hits and how many of its ports remain to lease.
  - `plugins/ok/families/ok-planner/admin/ADMINISTRATION.md` adds the `port-range` row to the offers table and a `port-range` entry to "Draft each kind this way". The front door asks once: take the suggestion or name another range. It refuses a range that reaches the ephemeral start. On an overlap it warns with the ports hit and the leasable count, and the owner keeps the range or picks another. It reminds the owner that no other project on the machine may share the range, since no project can see another's registry. On the answer, it drafts and runs the offer's `amend`. A declined offer is recorded as declined and returns on the next `/ok`.
  - The audit section's list of offers that own their findings adds `port-range`, so the audit drafts no `amend` for a missing range.
- Depends on: The configuration declares port names and a provisioning range, The lint checks every host port a compose file publishes

### The drive's stack roles remove a run's artifacts, and the runs that start stacks run the cleanup

- Issues: per-run-artifacts-never-removed, port-block-reads-back-a-stale-record
- Makes true: decision:run-artifacts-removed-with-the-run, story:verification-leaves-no-artifacts-behind, decision:ports-leased-from-a-project-range
- Outcome:
  - The facts template's `## Drive commands` instruction (`plugins/ok/families/ok-planner/review/seed/project.md`) says that `stack-start` leases the run's ports with `.ok-planner/bin/ports lease` and starts the stack under the run's tag, and that `stack-stop` stops the stack, removes everything the run built under its tag, whether the run passed or failed, and ends the lease.
  - In `plugins/ok/families/ok-planner/skills/converge/SKILL.md`, drive mode's step 4 and the confirm step 6 (which sprint certification's drive shares through drive mode's steps 2 to 4), after the stack stop and the instance and resource stops drain, file and drain one `exec` task running `.ok-planner/bin/ports cleanup` wherever `review drive-stack` printed `stack`.
  - `plugins/ok/families/ok-planner/skills/audit/SKILL.md` runs `.ok-planner/bin/ports cleanup` once after the story and assumption measurements drain, so a lease or container artifact the experiments' stacks left, once the cleanup's rules make it due, is freed or removed.
  - Each cleanup's output goes into the run's report or return.
- Depends on: The port cleanup frees stale leases and removes the artifacts of dead runs

### The suite's documents and this project's facts name the allocator

- Issues: port-block-reads-back-a-stale-record
- Makes true: decision:ports-leased-from-a-project-range
- Outcome: Every reader that named `port-block` names `.ok-planner/bin/ports` and what it does (lease, release, cleanup).
  - `README.md` (the per-run verification stacks bullet).
  - `docs/integration-contract.md` (the vendored scripts list, which calls it the port allocator, and the retired-script repoint paragraph, which names `.ok-planner/bin/port-block` among the retired scripts whose callers get an issue).
  - `plugins/ok/CLAUDE.md` (the support scripts list).
  - `plugins/ok/families/ok-planner/CLAUDE.md` (the layout line: `scripts/ports`, the port allocator, materialized to `.ok-planner/bin/ports`, and the block-list data file's line).
  - `plugins/ok/families/ok-planner/scripts/ok-planner-CLAUDE.md` (the lint-and-hooks paragraph).
  - `plugins/ok/families/ok-planner/admin/ADMINISTRATION.md` (the executables list, the run-once list, and the retired workspaces text that compares the retired `port-block` with the current one).
  - This project's `.ok-planner/review/project.md` (the developer-scripts line, which names `plugins/ok/families/ok-planner/scripts/ports` and its inputs: `lease <run-tag>`, `release <run-tag>`, `cleanup`).
  - A closing `rg -n 'port-block' plugins docs checks README.md .ok-planner/review/project.md` finds only the retired-script handling.
- Depends on: The port allocator leases a run's host ports from the project's range, replacing `port-block`


### Every comment and ruling records its author's name, and a write with no name refuses

- Issues: foreign-author-message-renders-as-agent
- Makes true: decision:messages-carry-their-authors-name, decision:anyone-may-rule, decision:owner-messages-can-change, decision:triage-answers-owner-messages, decision:flagged-issues-discussed-in-session
- Outcome: `plugins/ok/families/ok-planner/scripts/issues` resolves the writing person's name on every person's write (`rule`, `comment`, `edit`, `remove`, `unrule`), in this order: the name the person configured, kept in a JSON file `{"name": "<name>"}` in the user's configuration directory outside every project (`$XDG_CONFIG_HOME/ok-planner/user.json`, else `~/.config/ok-planner/user.json`), never in `.ok-planner/config.json`; else `git config user.name` run in the project root. Where git is absent, the root is not a repository, or neither source gives a non-empty one-line name, the write refuses with exit 2 and a message that says how to set one, for example `issues: no name to sign this comment with: set one with "issues name --set <your name>", or set git's user.name`. The resolved name may not be `triage-issues` or `converge`; the module refuses that name when it is set and when it is read. A new verb, `issues name`, prints the resolved name and which source gave it, and `issues name --set <name>` writes the user-scoped file by atomic replace (temp file, then rename). Every comment and ruling written from now on carries the resolved name in `by`. The schema accepts any non-empty name other than an agent's on a `comment` or `ruling` and keeps `triage-issues` for a `reply` and `triage-issues` or `converge` for an `update`. Every place the module tells a person's message from an agent's reads the message's `type`, never `by == "owner"`: the schema check's set of answerable messages, `readable_message`'s default mark, `unseen`, `respond`'s check that a seen mark or `replies_to` names a person's message, `untouched`, `message_line`, and `owner_entry`. `edit`, `remove`, and `unrule` act only on a message whose `by` equals the caller's resolved name; on another person's message they refuse with a message naming its author and, for `unrule`, saying to rule again to replace the ruling. A new ruling by anyone replaces the current one, as today. The `OWNER` constant and the `"owner"` author leave the module. Existing messages whose `by` is `owner` stay as written: they read as a person's messages under the name `owner`, triage answers and marks them seen as before, and no person's name matches them, so a person rules or comments again instead of editing one. The help and refusal texts that say "the owner's ruling", "an owner comment", or "owner message" say "your ruling", "your comment", and "a person's message". The dashboard's service, `plugins/ok/families/ok-planner/scripts/dashboard`, writes through the same module calls, so its writes carry the name of the person who started the service; its `REFUSAL_STATUS` names every refusal reason the module adds (the missing name answers 400, another person's message 403), and its `/api/meta` answers the resolved name, or `null` with the setting hint.
- Depends on: none

### Each person's reading lives in a ledger that git ignores, and an issue never read counts as new

- Issues: foreign-author-message-renders-as-agent, new-issues-show-no-unread-mark
- Makes true: decision:read-marks-kept-per-person, decision:agent-revisions-reach-the-owner, decision:unread-issues-count-as-new, decision:closed-answers-count-as-new, decision:intake-reads-past-stray-lines, story:see-new-analysis
- Outcome: `plugins/ok/families/ok-planner/scripts/issues` keeps one read ledger per resolved name under `.ok-planner/.cache/`, at a file name derived from the name so two names never share a file (for example `.ok-planner/.cache/read/<slug>-<8 hex of the name's sha256>.json`). The module reaches the directory through the tracker's `cache_dir`, which writes the `*` ignore file there, so git ignores every ledger and no `.gitignore` change is needed. The ledger maps each record's key (id and opened time, so a closed record keeps its entry) to the time the person first read it and the highest message number it held when last read. The module creates a ledger the first time a name needs one, holding an entry for every live and archived record at its current highest message number, so everything that exists counts as read. It writes the ledger by atomic replace under the intake's one lock. `issues read <id>` and the dashboard's read route write the ledger and no intake file: they add the first-read time where the entry is new and raise the mark to the record's highest message number. Filing, `show`, and every other verb mark nothing read, since agents run them. A new reply or update carries no `read` field. A `read` field already on an agent message is retired: the schema check accepts it, no verb reads it, no verb writes it, and it stays as written (the intake holds 7 agent messages with a `read` key and the archive 12, every one inside the window a fresh ledger counts as read). The views that `list`, `show`, and `history` print with `--json` compute, per the reading person's ledger, `unread` (the agent messages, by type `reply` or `update`, numbered above the mark, or every agent message where the record has no entry), `unopened` (true where the record has no entry), and a `new` flag on each such agent message, on a copy of the record, never stored. `issues list --unread` lists every open or closed record where `unread` is above zero or `unopened` holds, and `summary_line` prints `never read` beside `unread=N`. Where no name resolves, readers count nothing unread and print one stderr note naming how to set a name, and `issues read` refuses with the name-setting message.
- Depends on: Every comment and ruling records its author's name, and a write with no name refuses

### The readable `issues show` prints each update's difference as a word diff

- Issues: issues-show-omits-update-diff
- Makes true: decision:agent-revisions-reach-the-owner, decision:flagged-issues-discussed-in-session
- Outcome: `plugins/ok/families/ok-planner/scripts/issues` holds the one word-diff implementation, matching what the dashboard draws today in `plugins/ok/families/ok-planner/browser/src/lib/diff.js`: it turns each value into text (null as empty, a list of options as one `<label>. <text>` line each, a recommendation as `(<form>) <text>`, other text as written, anything else as JSON), splits it into runs of whitespace and runs of non-whitespace, and marks each run same, gone, or added by a longest-common-subsequence walk. The readable `issues show <id>` prints, under each update message's head line and one-line text, each field its `diff` holds, by name, then the field's whole after-text with each removed run in `[-…-]` and each added run in `{+…+}`, indented under the message. An update message with no `diff` prints as it does today. `show --json` and the dashboard's issue route carry the computed parts on each update's diff entry as a computed field, never stored. The dashboard draws those parts and `browser/src/lib/diff.js` is deleted, so one implementation draws the difference on every surface.
- Depends on: none

### The dashboard styles messages by type, names every author, and marks every unread issue, verified defects included

- Issues: foreign-author-message-renders-as-agent, new-issues-show-no-unread-mark
- Makes true: decision:messages-styled-by-type, decision:read-marks-kept-per-person, decision:agent-revisions-reach-the-owner, decision:unread-issues-count-as-new, story:see-new-analysis
- Outcome: in `plugins/ok/families/ok-planner/browser/src/lib/api.js`, `OWNER` goes; `isAgent` holds for a message of type `reply` or `update`; `isOwn` holds where the message's `by` equals the name `/api/meta` answers; `isNew` reads the view's computed `new` flag; `isUnread` holds where `unread` is above zero or `unopened` holds; and the `unread` tab lists verified defect issues as it lists every other kind (its `state !== 'verified'` test goes). In `browser/src/views/IssueDetail.svelte`, every message's head shows its `by` as written, a person's message as a person's whatever the name, an agent's as an agent's; the person's seen-by-triage tags stay; edit and withdraw controls show only on the viewer's own messages; the ruling section's heading reads "Ruling" and names the author of the current ruling message; opening an issue that `isUnread` marks, a never-read one included, posts the read and clears both counts. In `browser/src/views/IssueList.svelte`, a never-read issue shows a `new issue` tag beside any `N new` tag. Where `/api/meta` answers no name, the page shows once, in its header, how to set one, and a write's refusal shows as the notice it does today. `plugins/ok/families/ok-planner/scripts/dashboard` adds `unopened` to `SUMMARY_FIELDS`. The release build (`/release`) rebuilds `browser/dist/`; the sprint edits the page source alone.
- Depends on: Every comment and ruling records its author's name, and a write with no name refuses; Each person's reading lives in a ledger that git ignores, and an issue never read counts as new; The readable `issues show` prints each update's difference as a word diff

### The issue format and the suite's text describe several people working one intake

- Issues: foreign-author-message-renders-as-agent, new-issues-show-no-unread-mark, issues-show-omits-update-diff
- Makes true: decision:messages-carry-their-authors-name, decision:read-marks-kept-per-person, decision:owner-messages-can-change, decision:agent-revisions-reach-the-owner, concept:issue
- Outcome: in `plugins/ok/families/ok-planner/skills/_shared/artifact-definitions.md`, `{{ISSUE-DEFINITION}}` says the discussion holds the comments and rulings people write and the replies and updates agents write, and that any person who works the intake comments or rules. `{{ISSUE-FILE-FORMAT}}` says: the message table's `comment` and `ruling` rows are written by a person, `by` holding the author's name (the name the person configured outside every project, else git's user.name), and a message whose `by` is `owner` is a person's message from before names were recorded; the `reply` and `update` rows drop `read`; a `read` key already on an agent message is retired and kept as written; the views' `unseen` counts a person's messages triage has not seen, `unread` counts the agent messages the reading person has not read, per that person's ledger, and `unopened` says the person has never read the issue; the writers table's "The owner" row becomes "A person", adding `issues name [--set <name>]` and saying `issues read` and the dashboard's read write the person's ledger; the rule on read marks says each person's reading lives in a ledger under `.ok-planner/.cache/` that git ignores, that starts with everything counted as read, and that filing and `show` mark nothing read; the rule on edits says a person edits, removes, or withdraws only their own messages, matched by name; and the ownership rule says a person alone writes `ruling` and comments, an agent session doing so only to transcribe that person's words under that person's name. Every surface that shows an update message shows its difference: `issues show` prints the word diff, and the dashboard draws it. The same changes reach the prose that restates the format: the "Discussing" paragraph of `plugins/ok/families/ok-planner/scripts/ok-planner-cheatsheet.md` (anyone who works the intake comments or rules; a triage reply and an agent revision stay unread to each person until that person reads the issue, and an issue a person has never read counts as new); and in `plugins/ok/families/ok-planner/scripts/ok-planner-CLAUDE.md`, the flagged-issue paragraph (the session writes under the session's person's name), "The discussion" (each person's reading is their own), the "The ruling is the owner's alone" heading ("A ruling is a person's alone"), and the dashboard paragraph. The term "owner message" becomes "a person's message" in `plugins/ok/families/ok-planner/skills/triage-issues/SKILL.md`, `skills/triage-issues/prompts/respond.md`, `skills/triage-issues/prompts/triage.md`, and `skills/plan-sprint/SKILL.md`. `.ok-planner/review/project.md`, the project's own facts file, describes the `issues` verbs as they now stand (`name`, `edit` and `remove` on your own messages, `unrule` on your own ruling, `read` writing your ledger, `--unread` covering never-read issues) and `/api/meta`'s `name`.
- Depends on: Every comment and ruling records its author's name, and a write with no name refuses; Each person's reading lives in a ledger that git ignores, and an issue never read counts as new


### Sprint certification drives every story

- Issues: sprint-certification-drives-only-sprint-stories
- Makes true: decision:drive-tries-each-story-as-a-user, decision:team-execution-cold-gate, concept:completion-contract, story:certify-completion
- Outcome: `/converge sprint <path>` files one driver for every story under `.ok-planner/design/stories/`, the same set drive mode takes, not only the stories the sprint's deltas add or amend or its work items name. The existing scope test then sorts each failure: a failure in code the sprint's change caused or reaches is merged and fixed in the run; a failure in code that stood the same at the base and that the change does not reach is set `backlog` and the owner list files it as a `category: defect` issue, as `merge.md` already says. Canonical sources the outcome reaches:
  - `plugins/ok/families/ok-planner/skills/converge/SKILL.md`: sprint mode's step 4 ("The drive") runs drive mode's steps 2 to 4 over every story, filing the drivers with `review drives` and no story list; it skips the drive only where the corpus holds no story or `review drive-stack` prints `unfilled` or refuses, and says so in the return. Setup step 1's shape line for `sprint` names the count of stories the drive takes. The frontmatter description, the Find bullet for `sprint` mode, and drive mode's sentence "Drive mode takes every story every run: it is where the run spends its tokens" say the drive of sprint certification takes every story.
  - `plugins/ok/families/ok-planner/scripts/review`: `cmd_drives` and the `drives` verb's parser lose `--stories`, which sprint mode was its one caller, and the "--stories or --confirm" refusal goes with it; `drives` with no flag files every story, and `drives --confirm` stays.
  - `plugins/ok/families/ok-planner/skills/_sprint/shared.md`: the sentence under the classes table reads that every story is checked by the drive, and the merge agent sorts its failures by the scope test.
  - `plugins/ok/families/ok-planner/skills/plan-sprint/sprint-document.md`: boilerplate step 12 reads that a user gets what every story promises when a driver uses the running product, that a failure the sprint's change caused is fixed in the run, and that a failure in code the change did not reach goes to the intake as a `category: defect` issue for the next `/converge`.
  - The prose that restates certification's drive: the "Executing a sprint" section of `plugins/ok/families/ok-planner/scripts/ok-planner-CLAUDE.md`, the lifecycle paragraph of `plugins/ok/families/ok-planner/scripts/ok-planner-cheatsheet.md`, the "Executing a sprint" section of `plugins/ok/families/ok-planner/scripts/ok-cheatsheet.md`, `plugins/ok/families/ok-planner/CLAUDE.md`, `plugins/ok/CLAUDE.md`, and the sprint-loop paragraph of the root `README.md` each say certification drives every story.
  - `rg -i "adds or amends|stories the sprint|sprint touches|--stories"` over `plugins/`, `README.md`, and `.claude/skills/release/` finds no sentence that still limits certification's drive to the sprint's stories.
- Depends on: none

### A drive covers every variant the story names, in a first-time user's order

- Issues: drive-pass-is-one-try
- Makes true: decision:drive-tries-each-story-as-a-user, story:certify-completion
- Outcome: a driver may pass a surface only after it drives every variant the story's own text names on that surface, each judged on its own as each surface is, and it acts in the order a first-time user would. It reports each variant it drove, so the merge sees what a pass covers. Canonical sources the outcome reaches:
  - `plugins/ok/families/ok-planner/skills/converge/prompts/drive.md`: "Every way the story can be done" tells the driver to read the story's capability and benefit for each way the story says its benefit comes (for a story that promises records narrowed by time and by field values: a narrowing by time, and a narrowing by field values, on each kind of listing the story names) and to drive each variant on each surface; a story whose text names one way has one variant. It tells the driver to start each surface as a first-time user would: on a freshly loaded page or a fresh state, take first the action a new user takes first (the first control a user presses on a page just loaded), before building any other state. "Judge the outcome" applies per surface and per variant: a variant achieved on one surface and failed on another, or one variant achieved and another failed, is failed where it failed. A failure item carries `--field variant=<a short name for the variant>` and the fingerprint `story-<slug>-<surface>-<variant>`. A skill surface is reviewed for each variant the story names. The close result lists, per surface, each variant driven and its outcome. A confirm drive tries the surface and the variant the defect names.
  - `plugins/ok/families/ok-planner/skills/converge/prompts/merge.md`: for the drive, the merge reads the close result of each driver whose story its failures name, beside the failures, and a defect merged from a failure carries `--field variant=<the failure's variant>` beside `story` and `surface`.
  - `plugins/ok/families/ok-planner/scripts/review`: `confirm_briefs` names the defect's variant in the confirm brief beside its surface.
  - `plugins/ok/families/ok-planner/skills/converge/SKILL.md`: drive mode's description of the drive names the variants and the first-time user's order; the return's `hunt` line reports each story's outcome per surface and variant, and the `sprint` line reports the stories driven per surface and variant.
- Depends on: Sprint certification drives every story (both edit `converge/SKILL.md` and `scripts/review`)

### The merge sorts each drive failure by what the story's text names

- Issues: merge-sorts-drive-failures-off-the-story
- Makes true: decision:drive-tries-each-story-as-a-user, decision:accept-list-decides-defects
- Outcome: the section "The drive's failures" of `plugins/ok/families/ok-planner/skills/converge/prompts/merge.md` is rewritten. Today it sorts a stuck story whose user lacked a page, a verb, or a flow as `not-owed`, sorts as `not-owed` any failure the corpus does not decide, and names only A3 as the entry. Afterward it says:
  - A failure is a defect wherever the story's text, or a decision's Choice, names what the driver could not get, a missing flow included.
  - A page or a message that tells the user something false is a defect, whatever a work item says.
  - `not-owed` applies only where the driver sought something beyond what the story's text, or a decision's Choice, names.
  - A sprint work item never decides what a story owes. In sprint mode, a work item that contradicts a story is a commitment contradicted (C4).
  - A3 and A8 cover every story failure, so no line of what the accept list leaves standing clears one.
  - The stuck rule's message clause stays as one way a stuck story is a defect (a message or a help text the user met failed to say what went wrong or what to do next), not the only way.
  - The backlog scope test stays as written: in sprint mode, a defect in code that stood the same at the base and that the change does not reach is set `backlog`.
  - The paragraph that sorts an undecided failure `not-owed` keeps its question call only for a story whose text, or a decision's Choice, leaves two readings of whether it names what the driver sought, which A8 already makes a question rather than a defect.

  Two siblings follow the section. `plugins/ok/families/ok-planner/skills/converge/prompts/fix.md`'s rule for a defect from a `stuck` story fixes it by making the product deliver what the story names: the message or the help text where the defect names one, and the missing flow where the story names the flow; it no longer declines a change to what a page or a verb offers when the story names that flow. `plugins/ok/families/ok-planner/skills/converge/prompts/owner-list.md`'s read of the `not-owed` failures takes those whose note names the story text's two readings.
- Depends on: A drive covers every variant the story names, in a first-time user's order (both edit `merge.md`)

### The merge's ownership test sends a misclassed file's report to the list's own fix

- Issues: agents-route-clear-defects-to-the-owner
- Makes true: decision:runs-fix-what-the-project-owns, decision:accept-list-decides-defects
- Outcome: "The ownership test" in `plugins/ok/families/ok-planner/skills/converge/prompts/merge.md` carries one more line, ahead of the `corpus` bullet it qualifies: where a file reads `corpus` only because the review script's list classes it so, and a rule the corpus states decides the file's class otherwise, the list is the defect's site under A8 and the fix lies in project code, so the report merges instead of going to the owner. The fix's files name the file that holds the list, in this repository the review script's canonical source the project's facts list, in place of the misclassed file, and the merge applies the ownership test to that file. Triage's prompt and the author prompts stay as they stand.
- Depends on: The merge sorts each drive failure by what the story's text names (both edit `merge.md`)

### Every sprint work item changes the product

- Issues: sprint-work-item-operates-the-product
- Makes true: concept:sprint, decision:work-items-change-the-product, story:plan-a-sprint, story:certify-completion
- Outcome: every sprint work item changes the product: its code, configuration, documents, or design corpus. A work item that consists of using what the sprint builds is refused and reshaped into the feature, script, or seed asset that lets a user reach the outcome. Canonical sources the outcome reaches:
  - `plugins/ok/families/ok-planner/skills/plan-sprint/sprint-document.md`: the `## Work items` guidance in the template says each work item changes the product (its code, configuration, documents, or design corpus), and that an item that consists of using what the sprint builds is reshaped into the feature, script, or seed asset that lets a user reach the outcome. Boilerplate step 11 states that execution and sprint certification need no owner action and file no task for the owner to perform; the archive and the commit after completion stay the owner's one act, and a genuine blocker still stops the run.
  - `plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md`: section 5, Draft, states the same rule for every work item the session drafts. The kickback bullet under code planning's questions names a work item that changes no file as a kickback the rules decide: it goes back to the draft to be reshaped.
  - `plugins/ok/families/ok-planner/skills/plan-sprint/core.md`: the code planner's step 8 kicks a work item back where it changes no file in the tree, as an item that cannot be built as drafted, naming the outcome and the feature, script, or seed asset a user would need to reach it; the output's kickback line carries that reason.
  - The `concept:sprint` delta lands.
- Depends on: Sprint certification drives every story (both edit boilerplate in `sprint-document.md`)

### A dashboard drive serves a page built from the tree's source

- Issues: dashboard-drive-reads-stale-page-build
- Makes true: decision:drive-tries-each-story-as-a-user, decision:drive-serves-the-tree-page-build, story:see-new-analysis
- Outcome: the dashboard bullet under `## Drive commands` in `.ok-planner/review/project.md` (the owner's drive facts, project-owned) has a dashboard driver build the page from the tree's source into scratch space outside the tree, and the scratch project serve that build in place of the committed release build. The steps it gives: make and true up the scratch project with the true-up core as it does today; copy `plugins/ok/families/ok-planner/browser/` from the working tree, without its `node_modules/` and `dist/`, into a second folder made with `mktemp -d`; run `npm ci` and `npm run build` there; replace every file under the scratch project's `.ok-planner/dashboard/` but its `.gitignore` with the build's output, with `{{OK_PLANNER_VERSION}}` in each file replaced by the suite version the true-up core stamped into the scratch project (the version its `placed:` line prints), the way true-up stamps the placed build; then start the service as today. The page's `/api/meta` then reports the build version agreeing with the service, and the page served is the one the tree's source builds. A failed `npm ci` or build is a `blocked` outcome. The driver deletes both scratch folders when it is done. Nothing under `plugins/ok/families/ok-planner/browser/` changes during a drive: no `node_modules/`, no `dist/`. The committed `browser/dist/` stays the release artifact that `/release` builds.
- Depends on: none (the bullet names the core by its new path, `plugins/ok/families/ok-planner/admin/true-up`, run with no argument)


### The true-up core is a file named true-up whose default mode is true-up

- Issues: converge-names-true-up-and-a-command
- Makes true: concept:true-up, story:true-up-project-estate, decision:whole-file-ownership, decision:per-project-pinning
- Outcome:
  - `plugins/ok/families/ok-planner/admin/true-up` is renamed with `git mv` to `plugins/ok/families/ok-planner/admin/true-up`, executable as before. The modes keep their names (`diagnose`, `wire-hooks <group>`, `wire-env`, `resolve`, `amend`, and the internal `migrate`, `review-config`, `corpus`, `report`). The default mode, run with no argument, is named `true-up`: `MODE="true-up"`, `if mode == "true-up":`, and `vendor_layer true-up`. The `core` path variable names `true-up`.
  - The core's text names the act true-up: the usage line (`usage: true-up [diagnose | …]; with no argument, true-up materializes …`), every error prefix `converge: …` (becomes `true-up: …`), every finding, refusal, and report line that says "converge removes / moves / rewrites / repoints / files / regenerates / seeds / strips", `NODE_MISSING`, `CALLER_LEFT`, the `caller_issue` problem and option texts, the docstrings, and the closing lines `Converged ok-planner at …` (become `Trued up ok-planner at …`) and `Run converge to repair.` / `Run converge to bring the estate current.` (become `Run true-up …`). The defect-run strings in the keep list stay.
  - The core's annotations name the new slugs: `# @story: true-up-project-estate` at both sites and `# @decision: pinned-build-placed-at-true-up` at both sites.
  - Every caller names the new file: `plugins/ok/skills/ok/SKILL.md` (lines 12, 51, 53, 63, 64, 70: `bash "<payload>/admin/true-up" …`), `plugins/ok/families/ok-planner/admin/ADMINISTRATION.md` (its command block and every `admin/converge` mention), `plugins/ok/CLAUDE.md`, `plugins/ok/families/ok-planner/CLAUDE.md` (its tree line and prose), `docs/integration-contract.md` (the "true-up core: `admin/true-up`" bullet, the family table row, and the layout list), `README.md`, `checks/vendored-layer` (the path and its three messages), `checks/owned-paths` (`CORE_LABEL`, `CORE`, the region key and its marker `'\nif mode == "true-up":'`, and every `("converge",)` region name in its tables), and this repository's `.ok-planner/review/project.md` (the drive facts naming the core's path and its default mode, and "converge it with the converge core").
  - `bash checks/run` (or each check under `checks/`) passes after the rename.
- Release boundaries: no project file names the core. Its path is read only by the `/ok` skill and the administration document, which ship inside the same `ok` plugin as the core, and by this repository's checks and review facts. A project pinned to an earlier release never reads the name: its vendored layer neither names nor calls the core. The code planner checks one case under the "Installed plugins" boundary: `/ok` step 1 updates the plugin inside the running session. If `CLAUDE_PLUGIN_ROOT` can point at the newly installed copy while the session still runs the skill text it loaded before the update, that text calls `admin/converge`, which no longer exists. The code planner settles whether that can happen and gives it a behavior ruling.
- Depends on: none

### Every suite-owned file's stamp says it is overwritten on true-up

- Issues: converge-names-true-up-and-a-command
- Makes true: decision:per-project-pinning, concept:materialized-artifact
- Outcome:
  - The trailing stamp the core appends (`STAMP`) reads `<!-- Materialized by ok-planner v<version> — suite-owned; overwritten on true-up; do not hand-edit. -->`.
  - Every script header stamp under `plugins/ok/families/ok-planner/scripts/` (`run-tag`, `issues`, `review`, `tasks`, `session-start`, `plumbline`, `catalog-toc`, `dashboard`, `port-block`, `surface-corpus`, `dashboard-gitignore`, and every script this sprint adds or keeps, such as the port allocator another group adds) reads `Materialized by ok-planner v{{OK_PLANNER_VERSION}} — suite-owned; overwritten on true-up; do not hand-edit.`. The longer form in `scripts/hooks/agent-model` and `scripts/hooks/subagent-batching` reads `… overwritten wholesale on true-up by the front door's administration (/ok); …`, and `scripts/hooks/post-edit.js` the same.
  - The rules-file and template heads that name the act read `Suite-owned: overwritten wholesale on true-up (`/ok`); …` in `scripts/ok-cheatsheet.md`, `scripts/ok-planner-cheatsheet.md`, `docs/plumbline-cheatsheet.md`, and `docs/plumbline-coding.md`; `scripts/ok-planner-CLAUDE.md` reads `Suite-owned boilerplate: true-up (`/ok`) overwrites this file wholesale.`.
  - No reader of a stamp changes, and each one still reads the old stamps: every reader keys on the `Materialized by ok` prefix and the version alone, never on the tail. The readers are the core's `stamped`, `head_stamped`, and `suite_stamped` (`ANY_OK_STAMP`); `scripts/review`'s `MATERIALIZED_STAMP` and `SUITE_STAMP`; `scripts/hooks/agent-model`'s `VENDORED_STAMP`; `scripts/dashboard`'s `ESTATE_VERSION`; the lint's `materializedStamp` in `scripts/plumbline`; the `/ok-version` skill; and the cheatsheet's rule for what is suite-owned. The code planner confirms that no reader matches `overwritten on converge` and that none is added. A project at an earlier release keeps its old stamps until its next true-up, which rewrites every stamp in one pass, as a version change already does.
- Depends on: The true-up core is a file named true-up whose default mode is true-up

### The suite's documents, rules, prompts, and messages name the administration act true-up

- Issues: converge-names-true-up-and-a-command
- Makes true: concept:true-up, concept:integration-contract, story:true-up-project-estate, decision:pinned-build-placed-at-true-up, decision:administration-is-a-user-act
- Outcome: every administration-sense use of "converge" in these files says "true-up" (noun) or "true up" (verb), and every defect-run use stays:
  - `plugins/ok/skills/ok/SKILL.md`: the description ("true-up core plus administration document", "and trues up again"), the `<!-- @story: true-up-project-estate -->` annotation, the step titled **True up** and **True up again**, the report's outcome values (`trued up`, `trued up; audit findings pending: <n>`), and every other administration-sense use. The retired-verb table keeps its `/converge` rows.
  - `plugins/ok/families/ok-planner/admin/ADMINISTRATION.md`: all administration-sense uses (about 60).
  - `docs/integration-contract.md` and `README.md`: all administration-sense uses, including "install, true up, repair" and "a trued-up project is self-contained".
  - `plugins/ok/CLAUDE.md` and `plugins/ok/families/ok-planner/CLAUDE.md`: "install, true up, repair", "true-up mechanics", "the true-up core", "estate true-up is the front door's administration".
  - The templates and rules: `scripts/ok-planner-CLAUDE.md` ("overwritten on every true-up" at each site), `scripts/ok-planner-cheatsheet.md` (its suite-owned rule, "when `/ok` overwrites it on every true-up"), `skills/_shared/artifact-definitions.md` ("one `/ok` overwrites on every true-up"), and `review/CLAUDE.md`.
  - The skills that defer to `/ok`: `skills/sketch/SKILL.md`, `skills/document/SKILL.md`, `skills/audit/SKILL.md`, `skills/plan-sprint/SKILL.md`, `skills/_tasks/drain.md` ("Truing up the estate is the front door's administration (`/ok`)"; "Does not true up an estate"), and `skills/dashboard/SKILL.md` ("Run `/ok` to true up the project").
  - `skills/discover-design/SKILL.md`'s cross-check line "an open issue exists for the convergence question" reads "for the naming question".
  - `plugins/ok-conduct/output-styles/ok-conduct.md`: "A project not yet trued up to that layout".
  - The dashboard: `scripts/dashboard`'s two messages read "run /ok to true it up" and "run /ok to true it up"; `browser/src/App.svelte`'s two notices read "`/ok` to true it up". The committed build under `browser/dist/` changes at the next release, which rebuilds it.
  - This repository's release skill, `.claude/skills/release/SKILL.md`: the annotation `<!-- @decision: pinned-build-placed-at-true-up -->`, "the front door that trues it up", "The true-up core places that bundle", "so true-up cannot stamp the build", "Only the owner trues up its materialized artifacts", "A release trues up nothing", "truing up each project deliberately".
  - This repository's release boundaries, `.ok-planner/release-boundaries.md`: the section "Converged projects" is titled "Trued-up projects", and its "Where to look" names `plugins/ok/families/ok-planner/admin/` as "the true-up core and the administration document".
  - `rg -n -i 'converg' plugins/ .claude/skills/release README.md docs/ checks/ .ok-planner/release-boundaries.md` then lists only the keep-list sites above and the ok-web sites the next item covers. `rg -n 'converge-project-estate|pinned-build-placed-at-converge' plugins/ .claude/ checks/` lists nothing.
- Depends on: The true-up core is a file named true-up whose default mode is true-up

### The web setup skills and the marketplace describe their own setup without the word converge

- Issues: converge-names-true-up-and-a-command
- Makes true: concept:true-up
- Outcome: `plugins/ok-web/CLAUDE.md`, `plugins/ok-web/skills/setup-web/SKILL.md`, `plugins/ok-web/skills/setup-dom-picker/SKILL.md`, `.claude-plugin/marketplace.json`, and the `README.md` lines on `/setup-web` and `/setup-dom-picker` describe each skill's idempotent pass in plain words ("an idempotent one-pass setup", "brings each frontend in line with", "sets up") instead of "converge". The skill names, slash verbs, and plugin names stay. The `ok` plugin's marketplace description reads "install, true up, repair".
- Depends on: none

### True-up repoints a retired script reference behind a prefix it proves names the project root, and its report names what it cannot see

- Issues: retired-script-reference-root-prefix-unsettled
- Makes true: decision:whole-file-ownership, decision:retired-script-repoint-needs-a-proven-root, story:true-up-project-estate
- Outcome:
  - In `plugins/ok/families/ok-planner/admin/true-up`, a line that names a retired script's project path behind git's top-level idiom counts as certain where true-up proves that idiom resolves to the project root. The forms are `$(git rev-parse --show-toplevel)/`, the same inside double quotes before the `/`, and the backtick form. The proof runs once per run: `git rev-parse --show-toplevel` run at the project root names the project root, compared by real path. With the proof, `script_pattern` matches these forms beside `ROOT_REFERENCES`, and the line is repointed or filed as any certain reference is. Without it (the project root sits below the repository's top, or git is absent), the reference stays unsure, as today.
  - Every other prefix keeps today's behavior: the fixed root forms are certain; a prefix that may name the root but is not proven (`$ROOT/`, `$HOME/`, `~/`, `../`) stays as written, true-up files the intake issue naming the line, and the retired copy stays while the line names it; a prefix that cannot be the root names another file.
  - When true-up removes a retired script copy, the report prints, after that copy's `removed:` line, one line saying that a caller that builds the script's path at run time is outside what true-up sees and meets "not found" at its next run. `plugins/ok/skills/ok/SKILL.md`'s report template relays that line.
  - `plugins/ok/families/ok-planner/admin/ADMINISTRATION.md`'s "Callers of retired suite scripts" section and `docs/integration-contract.md`'s repoint bullet name the proven prefix and the report line.
  - Diagnose's `retired script caller:` finding reports a proven-prefix reference as one true-up repoints.
- Depends on: The true-up core is a file named true-up whose default mode is true-up

### True-up leaves discovery notes as written and counts none as a caller

- Issues: converge-repoints-observation-notes-and-migration-docs
- Makes true: decision:whole-file-ownership, concept:design-corpus, decision:records-stay-out-of-context
- Outcome:
  - In `plugins/ok/families/ok-planner/scripts/review`, `OWNER_PATHS` classes `.ok-planner/design/_discover/` as `record`, ahead of the corpus class's `.ok-planner/design/` prefix, since `left_alone` takes the first class that matches. `.ok-planner/history/discover/` stays `record` through the existing `.ok-planner/history/` entry. `review owner .ok-planner/design/_discover/<note>.md` prints `record`, and `review owner .ok-planner/design/concepts/<slug>.md` still prints `corpus`.
  - The true-up core's `caller_kind` then skips every note: true-up rewrites no line in one, files no issue about one, and keeps no retired script because a note names it. `/converge`'s file population and changed-file lists leave the notes alone as records.
  - `plugins/ok/families/ok-planner/admin/ADMINISTRATION.md`'s list of records true-up skips names the discovery notes, in the design corpus's scaffold or in the archive.
- Depends on: none

### /discover-design offers once to archive its notes after it fills the catalogs

- Issues: discover-design-offers-to-archive-its-notes
- Makes true: decision:discovery-notes-archived-on-consent, story:bootstrap-design-corpus, concept:design-corpus, decision:records-stay-out-of-context
- Outcome:
  - `plugins/ok/families/ok-planner/skills/discover-design/SKILL.md` gains a last step after the final report: where the run filled the catalogs (phase 2 wrote at least one concept, story, or decision), the skill asks the owner once whether to move the notes from `.ok-planner/design/_discover/` to `.ok-planner/history/discover/`. On yes it creates the folder, moves each note (`git mv` for a tracked one), removes the empty `_discover/`, and reports the count moved. On no, or with no answer, it moves nothing. The skill's opening says the run asks one question, at its end, and nothing earlier. The step carries no citation, since a materialized skill carries none.
  - The re-run guidance names the archive. The "When to invoke" bullet on earlier scaffolding and step 3's abort message say: before a full rebuild, restore the notes from `.ok-planner/history/discover/` to `.ok-planner/design/_discover/` to make phase 1 incremental.
  - The estate's `CLAUDE.md` template, `plugins/ok/families/ok-planner/scripts/ok-planner-CLAUDE.md`, lists `discover/` among the archive's folders: the discovery notes `/discover-design` archives.
  - The design-doc compliance reviewer, `plugins/ok/families/ok-planner/skills/_shared/design-doc-compliance-reviewer.md`, keeps its scaffold exemption as written. It covers notes left in place, and archived notes sit outside the corpus it reads.
- Depends on: none


### The audit's coverage and reading auditors count the folders the project declares

- Issues: audit-auditors-skip-declared-folders
- Makes true: story:project-spans-folders, decision:project-declares-its-folders
- Outcome: the coverage auditor's enumeration step and the reading auditor's quantifier step in `plugins/ok/families/ok-planner/skills/_shared/implementation-auditor.md` enumerate each population from the project root and from every folder `.ok-planner/config.json` declares under `folders`, and `plugins/ok/families/ok-planner/skills/audit/SKILL.md`, where it resolves those prompts into the run's task bodies, hands them the declared folders. A population member under a declared folder is counted in `checked:`, and a practice violation there is filed like any other.
- Depends on: none

### True-up never rewrites or removes owner text git cannot recover

- Issues: converge-strips-uncommitted-story-and-decision-text
- Makes true: story:true-up-project-estate, decision:whole-file-ownership, decision:retired-layout-strips-only-recoverable-files
- Outcome: the true-up core's strip of retired story sections (`## Falsifier`, `## Proof`, `## Acceptance`) and retired decision proofs, and its removal of the retired falsifier concept file, act only on a file git tracks with no uncommitted or staged-only change and no symbolic link in its path. Every other such file goes to the owner as an estate edit offer, the way the core already handles an uncommitted or symlinked retired state file, and the core's `resolve` refuses it until the owner commits the changes or removes the link. A collapse of blank lines touches only the lines the strip removed. ADMINISTRATION.md describes the same behavior. Canonical sources: `plugins/ok/families/ok-planner/admin/true-up` (the functions that strip story sections and decision proofs) and `plugins/ok/families/ok-planner/admin/ADMINISTRATION.md`.
- Depends on: The true-up core is a file named true-up whose default mode is true-up

### The front door's project audit leaves a hook that calls a live estate script alone

- Issues: settings-audit-reports-valid-estate-script-hooks
- Makes true: story:true-up-project-estate
- Outcome: the `.claude/settings.json` row of "Audit the project against the carried version" in `plugins/ok/families/ok-planner/admin/ADMINISTRATION.md` makes no finding of a hook entry whose command names a path the carried version still materializes, such as an executable under `.ok-planner/bin/`. Only a path the carried version no longer materializes is a finding. `/ok`'s outcome reads `trued up` on a project whose only such entries call live scripts.
- Depends on: none

### A running dashboard leaves a goal's check free to run

- Issues: dashboard-holds-goal-evaluation-open
- Makes true: decision:dashboard-started-by-skill
- Outcome: `/dashboard` starts the dashboard's service as a process detached from the session's background tasks, reads its `serving` line (address and pid) from a file the service writes, reports it as today, and stops it on the owner's word with `kill <pid>`. A `/goal` handed to the same session while the dashboard runs is checked when the sprint is done. Canonical source: `plugins/ok/families/ok-planner/skills/dashboard/SKILL.md`, and the service at `plugins/ok/families/ok-planner/scripts/dashboard` where it must write the serving line to a file.
- Depends on: none

### The sprint template's checklist step names when each entry moves

- Issues: none (found by this sprint's sign-off review)
- Makes true: decision:task-tools-mirror-the-report
- Outcome: boilerplate step 6 of `plugins/ok/families/ok-planner/skills/plan-sprint/sprint-document.md` names all of the checklist's moments: one entry per stage created when the build tasks are filed, an entry marked in progress when its build task is dispatched and done when that task closes `done`, and one entry added for sprint certification when the drain ends.
- Depends on: Sprint certification drives every story (both edit `sprint-document.md`)

## Implementation notes

Planned against commit `119169e2e0dc738cd85e8e08303c708fc5741b1f`.

### The port allocator leases a run's host ports from the project's range, replacing `port-block`

**Calls**
- Every `admin/converge::…` symbol these port notes name lands in `admin/true-up` after the core-rename stage. The planner's retired `port-block` joins `retired_scripts()` and stays out of `RETIRED_ESTATE`, whose bash sweep removes its entries unconditionally (`checks/owned-paths::check_retired_estate` guards it); the copy leaves only through `remove_files`. Decided by: the notes review's build notes; decision whole-file-ownership.
- The core file is named `admin/converge` at the commit. The rename item moves it to `admin/true-up` first. Every core change in this item and the five items below lands in the renamed file, sequenced after the rename. `checks/owned-paths` (the region names and the `subprocess.run` and `remove_files` tables) and this repository's `.ok-planner/review/project.md` are shared with the rename item, the dashboard-drive item, and the issue-format item, so the executor chains those stages. Decided by: the sprint's work items "The true-up core is a file named true-up…" and "Depends on" lines.
- `scripts/ports` loads `tasks` through the `load_sibling` idiom `scripts/issues` uses. It reaches the project root through `tasks.project_root()` and the cache folder (with its `*` ignore file) through `tasks.cache_dir()`. It does not copy `port-block`'s `project_root`. Decided by: plumbline-coding rule 6, and the sibling `scripts/issues::load_sibling`.
- The lock is `.ok-planner/.cache/ports.lock`, taken with `fcntl.flock` the way `scripts/issues::transaction` takes its lock. The lock is held for the read, the pick, and the write, and released on every exit, because it is a `with open(...)` block. The registry is written through `tempfile.mkstemp` in the same folder and then `os.replace`, the shape of `scripts/issues::write_records`. Decided by: plumbline-coding rules 2, 3.1, and 4.2.
- The registry's shape is `{"leases": {"<run tag>": {"ports": {"<NAME>": <port>, ...}, "at": "<UTC ISO 8601>"}}, "next": <port>}`. A registry that does not parse raises to the owner frame, with its path in the event. Decided by: the accept list's "a file the program itself wrote" standing line.
- The pick starts at the registry's `next` cursor, one past the highest port the last lease took, and wraps around inside the range. A port freed a moment ago is then the last to be leased again. A re-lease for a tag skips that tag's previous batch as well as every held, leased, and listed port, so a retry never gets back the port whose bind failed. Decided by: decision:ports-leased-from-a-project-range Rationale ("a run whose server stopped reaches a port nothing listens on").
- A port counts as held when a plain TCP `bind` on `0.0.0.0`, on `127.0.0.1`, or on `::` (where the host has IPv6) fails. The probe sets no `SO_REUSEADDR`, so a port in TIME_WAIT also counts as held. The cleanup uses the same probe. Decided by: the work item ("bound or listens on"), and rule 6 (one probe).
- The block list's data file is `plugins/ok/families/ok-planner/scripts/ports-blocklist`. It is plain text: a first line `# Materialized by ok-planner v{{OK_PLANNER_VERSION}} — suite-owned; overwritten on true-up; do not hand-edit.`, then one `<port> <what uses it>` line per entry. The core materializes it through `ESTATE_FILES` (form `versioned`, not executable) to `.ok-planner/bin/ports-blocklist`, beside the script that reads it. The block list also takes in every port `/etc/services` lists for any protocol, where that file exists. The estate `LICENSE` preamble names the block list beside the support scripts. Decided by: the work item ("carried once in the payload as a data file"), and the cheatsheet's suite-owned-stamp rule.
- The ephemeral start is read once per call: `sysctl -n net.inet.ip.portrange.first` on macOS (`/usr/sbin/sysctl` when `sysctl` is not on PATH), the first field of `/proc/sys/net/ipv4/ip_local_port_range` on Linux, and 49152 where neither read succeeds. Decided by: the work item.
- One implementation serves the allocator and the core. `scripts/ports` gains two read-only verbs: `suggest-range`, which prints `FIRST-LAST` or refuses, and `check-range <first> <last>`. The core runs these from the payload (`[sys.executable, PORTS_SRC] + args`), the way it runs `PLUMBLINE_SRC config-check`, and never re-reads the data file, the services database, or the ephemeral start itself. Decided by: plumbline-coding rule 6, and the sibling `config_defects`.
- `ports lease` reads the names from the array form and also from the keys of the retired object form, in declared order, so both shapes lease. Decided by: the stored-state boundary ("both shapes accepted within a major version").
- `ports lease` refuses, exit 1, a project whose `ports` declares no name. The message names `ports` and says to declare the names through `/ok`. It also refuses `ports` or `port_range` values it cannot lease from (a name that is not a NAME, a duplicate name, or a range that is not two ordered integers from 1025 to 65535), naming the key and `node .ok-planner/bin/plumbline config-check`. The lint's `config-check` stays the one full definition. Decided by: the sibling `port-block::entry_defects`, which kept its own check because node is optional, and the accept list's operator-configuration standing line.
- Exit codes: 0 on success, and 1 for both a refusal and the owner frame's catch-all. That is the shape `port-block::__main__` had. The catch-all event kind is `PORTS.RUN.FAILED`, with `error`, `message`, and `trace`. `--help` and `-h` print the usage and exit 0 before the root is resolved, so the core's probe (`ports --help`) needs no range. Decided by: the work item, and the sibling.
- A planner copy of `port-block` that callers still hold gets issue ids distinct from the workspaces copy's: `retired-planner-port-block-caller-<file slug>` and `retired-planner-port-block-named-in-<file slug>`. An archived `retired-port-block-caller-*` issue, closed by switching a caller to `.ok-planner/bin/port-block`, must not block the new filing, and `unfiled` skips every id that already stands. Decided by: decision:whole-file-ownership ("a caller whose behavior would change reaches the owner as an issue").
- The planner copy goes as the other retired scripts go. It is removed with `git rm` (through `remove_files`) where it is tracked, unchanged, suite-stamped, and held by no caller. Where it carries uncommitted changes, is or sits behind a link, or is untracked, it becomes an `estate-edits` offer. Diagnose reports a pending removal as `retired payload present: .ok-planner/bin/port-block — true-up removes it` and a held copy through the existing `retired script caller:` findings. Decided by: plumbline-coding rule 2 (the sibling `workspaces_plan` script handling).

**Changes**
- `plugins/ok/families/ok-planner/scripts/ports`: new (python, stamped `Materialized by ok-planner v{{OK_PLANNER_VERSION}} — suite-owned; overwritten on true-up; do not hand-edit.`, no corpus citation; the true-up core cites `@decision: ports-leased-from-a-project-range` at its materialization row for the script, decided by `checks/materialized-standalone`). It has these verbs:
  - `lease <run-tag>`: under the lock, it reads the registry, picks one port per name, writes the lease, and prints `NAME=<port>` lines in declared order. It refuses a non-run-tag; a missing `port_range` (exit 1, naming the range and `/ok`); a range that reaches the ephemeral start, naming both numbers; and a range with too few leasable ports, naming the range, the count needed, and the count free.
  - `release <run-tag>`: under the lock, it drops the lease, prints nothing, and exits 0, also when no lease stands.
  - `cleanup`: the next item builds it.
  - `suggest-range` and `check-range <first> <last>`: read-only, used by the core.
  - `--help`: prints the usage.
- `plugins/ok/families/ok-planner/scripts/ports-blocklist`: new. It lists the ports that protocols, apps, and services use by default, including 3000, 4200, 5000, 5173, 5432, 6379, 8000, 8080, 8443, 9000, 9200, and 27017.
- `plugins/ok/families/ok-planner/scripts/port-block`: removed.
- `plugins/ok/families/ok-planner/admin/converge::EXECUTABLE_FILES`: changed. The row `("scripts/ports", ".ok-planner/bin/ports", None, ("--help",))` replaces the `port-block` row.
- `admin/converge::ESTATE_FILES`: changed. It adds `("scripts/ports-blocklist", ".ok-planner/bin/ports-blocklist", "versioned")`.
- `admin/converge::ESTATE_LICENSE_PREAMBLE`: changed. It names the block list.
- `admin/converge::PORTS_SRC` and `admin/converge::ports_command(args)`: new. They give the path of the payload's `scripts/ports` and the one `subprocess.run([sys.executable, PORTS_SRC] + args, cwd=root, capture_output=True, text=True)` helper the next items use.
- `admin/converge::retired_scripts`: changed. It adds the planner copy `(os.path.join(ok_dir, "bin", "port-block"), "planner-port-block", None)` where that file exists and carries a suite stamp. `script_pattern` already treats a path outside a retired estate as the plain or root-prefixed form.
- `admin/converge::NO_DROP_IN`: changed.
  - The `"port-block"` text (the retired workspaces copy) says that `.ok-planner/bin/ports lease <run-tag>` leases ports from the project's range. Its fix says to declare the port names and range through `/ok` and to call `.ok-planner/bin/ports lease` with the run's tag.
  - A new `"planner-port-block"` entry says the suite carries no copy that behaves as `.ok-planner/bin/port-block` did. That copy read back ports the OS assigned. Its fix gives the same instruction as the workspaces entry.
- `admin/converge::caller_issue`: changed.
  - The title and problem name the script's path for the planner copy, not the key `planner-port-block`.
  - The keep option, which keeps the workspaces profile, stays limited to the workspaces `port-block`.
  - The keep option for the planner copy says that `.ok-planner/bin/port-block` reads only the retired object form of `ports`, so accepting the `port-range` conversion ends its read-back.
- `admin/converge::port_block_plan()` and `admin/converge::migrate_port_block()`: new. They hold the planner copy's removal plan and the `migrate` step that runs it after `migrate_callers()` and before `migrate_workspaces()`. The step uses `remove_files(plan["removes"], root)`, prints `removed: .ok-planner/bin/port-block`, and puts the offers into `offers()`.
- `admin/converge` diagnose: changed. It reports the pending removal.
- `admin/converge::WS_DROP_INS`: unchanged (`"port-block": None`). The workspaces copy keeps no drop-in.
- `checks/materialized-standalone::PAYLOADS`: changed. `("ok-planner/scripts/ports", ".py")` replaces the `port-block` row.
- `checks/owned-paths::check_planner`:
  - The `subprocess.run` table declares `"[sys.executable, PORTS_SRC] + args": ("ports_command",)`, with a region `"ports_command"`.
  - The `remove_files` table's `'plan["removes"], root'` tuple adds `"migrate_port_block"`, with that region.
  - The regions whose end markers move when the new functions are inserted (`migrate_workspaces`, `repair_templates`, and the rest) are kept true.
- `plugins/ok/families/ok-planner/admin/ADMINISTRATION.md`: changed. This item changes the executables list, the run-once list (`ports --help`), the workspaces section's "`run-tag` and a reworked `port-block`" sentence and the drop-in sentence, and "Callers of retired suite scripts", which names `.ok-planner/bin/port-block` among the scripts with no drop-in. The next items cover the rest of the file.

**Behavior changes**
- **B1** `admin/converge::EXECUTABLE_FILES` and `scripts/port-block`.
  - Before: true-up writes `.ok-planner/bin/port-block`, which reads back ports the OS assigned by run tag, and the core probes `port-block --help`.
  - After: true-up writes `.ok-planner/bin/ports` and `.ok-planner/bin/ports-blocklist`, probes `ports --help`, and retires `.ok-planner/bin/port-block` as a retired script. It files one intake issue per tracked non-record caller, keeps the copy while one names it, and removes it once none does.
  - Users: in the release, `ADMINISTRATION.md`, `checks/materialized-standalone`, the documents the last item lists, and this repository's `.ok-planner/review/project.md`. Across Converged projects, every project file that calls `.ok-planner/bin/port-block`: a `stack-start` line in `.ok-planner/review/project.md` (an `ESTATE_CALLERS` member, read whether or not git tracks it), project scripts, and CI files.
  - Ruling: migrate (call). Each caller gets an intake issue naming its lines and the `ports lease` fix. The retired copy stays and keeps working while the issue stands. The `port-range` offer says when converting the config ends its read-back. Decided by: decision:whole-file-ownership, and the retired decision os-assigned-ports-read-back-by-run-tag.
- **B2** `admin/converge::NO_DROP_IN["port-block"]`.
  - Before: a new issue about a retired workspaces `port-block` caller tells the owner to call `.ok-planner/bin/port-block`.
  - After: it tells the owner to declare names and a range through `/ok` and to call `.ok-planner/bin/ports lease`.
  - Users: in the release, the issues filed from now on. Issues already filed stay as written (records).
  - Ruling: rewrite.

### The port cleanup frees stale leases and removes the artifacts of dead runs

**Calls**
- **Grace period, ruled by the owner at planning (option A).** The cleanup leaves alone a lease whose `at` is under one hour old, and leaves a run tag's container artifacts alone while any of them was created under one hour ago (docker reports `CreatedAt` for images, volumes, and networks). Every dead run's artifacts are still removed, at a later cleanup. This keeps a live run's lease and images safe between its `lease` and its stack's bind, and keeps another project's run safe between its build and its `up` for an hour. Decided by: the owner's ruling at this planning session; decisions ports-leased-from-a-project-range and run-artifacts-removed-with-the-run as amended.
- The cleanup holds the registry lock for the whole call: the frees, the docker listing, and the removals. A `lease` that arrives meanwhile waits. Decided by: the work item ("runs under the registry's lock"), and plumbline-coding rule 3.2.
- Docker queries:
  - Containers per tag: `docker ps -a -q --filter label=com.docker.compose.project=<tag>`.
  - Every tag docker knows: the `com.docker.compose.project` label of all containers (`docker ps -a --format`), volumes, and networks, plus every image whose tag equals a run tag or whose repository name starts with `<run tag>-` or `<run tag>_` (compose's default image name for a project). Only an exact `run-<12 hex>` match counts.
  Decided by: decision:run-artifacts-removed-with-the-run ("every image tagged with the run tag, and the volumes and networks of the compose project the tag names").
- Removals use plain `docker image rm`, `docker volume rm`, and `docker network rm`, never forced. A removal that docker answers with "No such image", "No such volume", or "No such network" counts as removed, since the run's own stack stop may have removed the object a moment earlier. Every other docker failure propagates to the owner frame (`PORTS.RUN.FAILED`). Decided by: plumbline-coding rule 4.3 (a branch the caller acts on), and A3.
- Output: one `freed: <tag> (<NAME>=<port>, …)` line per lease freed, one `removed: <tag> (<i> image(s), <v> volume(s), <n> network(s))` line per tag cleaned, and the one line `removed no container artifacts: docker is not on PATH` where docker is absent. Nothing is printed and the exit is 0 when nothing was due. Decided by: the work item.
- No `ports` and no `port_range` needed: the cleanup reads the registry only if it exists and never reads the config. Decided by: the work item ("runs whether or not the project declares a range or ports").
- A cleanup in a project whose registry does not exist creates nothing but the lock under `.ok-planner/.cache/`. Decided by: `tasks.cache_dir`.

**Changes**
- `plugins/ok/families/ok-planner/scripts/ports::cleanup` (the `cleanup` verb): new, as the calls above say, with the port probe shared with `lease`. No corpus citation (the true-up core cites the decision at its materialization row or `LINT_CHECKS` entry for the file instead; decided by `checks/materialized-standalone`).

**Behavior changes**
None. Every change is new code no existing user reaches.

### The configuration declares port names and a provisioning range

**Calls**
- `scripts/review::project_folders` reads `.ok-planner/config.json` leniently: a config whose only `config-check` defect is the retired object form of `ports` still counts as well formed for `folders`, the same split `admin/true-up::retired_ports` makes, so `review files` and `changed_files` keep every declared folder while the `port-range` offer waits. B3's users add `scripts/review::project_folders` (`review files`, `changed_files`); the ruling stays `migrate`. Decided by: the implementation notes review; the stored-state boundary; A9 (the old stderr line would point at a `config:` offer that is withheld).
- The ephemeral-start refusal in `amend` and `resolve config:` applies only where the draft changes `port_range`, so a range committed on one system blocks no unrelated config repair on another; `ports lease` still refuses a range that reaches the machine's start. Decided by: A3 (an unrelated repair must not be blocked); the notes review's build note.
- Every lint `config-check` message names its key first:
  - `ports must be an array of port names`
  - `ports[<i>] "<x>" is not a NAME (…)`
  - `ports names "<x>" twice`
  - `port_range must be an object {"first": <port>, "last": <port>}`
  - `port_range.first must be an integer above 1024`
  - `port_range.last must be an integer at most 65535`
  - `port_range.first must be at most port_range.last`
  - the retired form, as one line: `ports uses the retired object form (a "service"/"port" or "record" entry per name); /ok converts it to the array of its names`
  An object `ports` gets that line alone. The work item decides the wording; the core's prefix-keyed `config_named_keys` relies on the leading key.
- `loadConfig` (the lint run) does not refuse on `ports` or `port_range`. `LINT_CONFIG_KEYS` stays as it is, and `compose-ports` reads what is well formed: the names from the array or from the retired object's keys, and the range only when it is well formed. Otherwise a project that declines the conversion would have every lint run, edit hook, and `/converge` check exit 1. Decided by: the stored-state boundary (both shapes accepted).
- The core marks the retired form in one place, `admin/converge::retired_ports(parsed, defects)`. It holds when `parsed["ports"]` is an object, and it splits off the `ports`-prefixed defect lines. Three readers use it:
  - `config_offers`, which raises no `config` offer when that line is the only defect;
  - `chosen_lint_checks`, which honors `lint_checks` when that line is the only defect, so a project that turned a check off is not rendered with every check on;
  - the `port-range` offer.
  Decided by: the work item ("no `config` offer for that defect"), and plumbline-coding rule 6.
- `amend` and `resolve config:` both refuse a draft whose `port_range` reaches the ephemeral start. Each runs `ports_command(["check-range", first, last])` on the draft, so a range cannot reach the config through the `config` offer that `amend` would refuse. Decided by: decision:port-range-chosen-at-true-up ("refuses a range that reaches that start").
- The front door's audit drafts for `.ok-planner/config.json` convert a retired `ports` form to the array of its names. Otherwise `amend` refuses every audit draft of a project still on the retired form, because `config-check` flags it. `ADMINISTRATION.md`'s `amend` draft guidance says so. Decided by: the `amend` refusal rule, and A3.

**Changes**
- `plugins/ok/families/ok-planner/scripts/plumbline`:
  - `portsDefects`: changed, to the array form plus the retired-form defect.
  - `portEntryDefects`: removed.
  - `PORT_TAG_PLACEHOLDER` and `isPortNumber`: removed, unless the new `portRangeDefects` reuses `isPortNumber`.
  - `portRangeDefects`: new.
  - `CONFIG_KEY_DEFECTS`: changed. It adds `port_range`.
  - `loadConfig`: changed. It also returns `portNames` and `portRange`, read leniently as the calls say.
- `admin/converge::CONFIG_CHECK_KEYS`: changed. It adds `"port_range"`.
- `admin/converge::retired_ports`: new.
- `admin/converge::config_offers`: changed.
- `admin/converge::chosen_lint_checks`: changed.
- `admin/converge` `amend` mode, and the `resolve` branch `kind == "config"`: changed. They add the ephemeral refusal: `amend: the draft is refused: port_range <first>-<last> reaches the machine's ephemeral range, which starts at <n>; nothing written`.
- `plugins/ok/families/ok-planner/admin/ADMINISTRATION.md`:
  - The **Ports.** paragraph is rewritten: `ports` is an array of names; `port_range` is the range `.ok-planner/bin/ports` leases from by run tag, refusing until a range exists; a project with no ports needs neither key.
  - The `amend` refusals paragraph, the `config` draft text, the `config-check` key list, and the audit table row for `.ok-planner/config.json` add `port_range`.
  - The `amend` draft guidance adds the retired-form conversion.
- `plugins/ok/families/ok-planner/scripts/ok-planner-CLAUDE.md`, configuration paragraph: changed. "the port names and the provisioning range the allocator leases from (`ports`, `port_range`)".
- `.ok-planner/config.json` (this repository): unchanged.

**Behavior changes**
- **B3** `plumbline::portsDefects` and `config-check`.
  - Before: an object `ports` passes `config-check` (exit 0), and an array is a defect.
  - After: an array of names passes, and an object is one defect that names the form as retired.
  - Users: in the release, `admin/converge::config_defects` and its readers (`config_offers`, `chosen_lint_checks`, `amend`, `resolve config`), the front door's audit drafts, and `ADMINISTRATION.md`. Across Converged projects, every stored `.ok-planner/config.json` holding the object form, and a project file or CI step that runs `config-check`.
  - Ruling: migrate (call). Every reader takes the object's keys as names (`ports lease`, `compose-ports`, the core's offer), the lint run never refuses on it, `chosen_lint_checks` ignores it, and the `port-range` offer converts it on the owner's yes. A CI step running `config-check` sees exit 2 with a message saying `/ok` converts it. Decided by: the work item, and decision:port-range-chosen-at-true-up.

### The lint checks every host port a compose file publishes

**Calls**
- `.ok-planner/review/project.md`'s list of `plumbline` subcommands adds the new `compose-ports [<path>]` subcommand in this stage. Decided by: the notes review's build note; project.md is the A3 inputs list.
- Compose files match `^(docker-)?compose(\.[^/]+)?\.ya?ml$` by basename, among the files `runLint` already walks (the root and the declared `folders`, less `ignore`). Decided by: the work item.
- The YAML reader is line-based, with no dependency. It finds the top-level `services:` key, each service's `ports:` key, and that key's block-sequence items: plain or quoted scalars, numbers, and mapping items with `published:` and `target:`. It also reads a flow sequence on one line (`ports: ["…", "…"]`). Entries reached only through an anchor, alias, merge key, `extends`, or `include` are not read. Decided by: the work item ("no new dependency").
- Host-port forms: `[ip:]host:container[/proto]`, a bracketed IPv6 `ip`, ranges `a-b`, and an empty host (`127.0.0.1::80`).
  - A number entry, a single-part string, an empty host, a bare host number or range, and a long form with no `published:` are violation (1).
  - `$VAR`, `${VAR}`, and `${VAR:?…}` are (2).
  - `${VAR:-n}` and `${VAR-n}` count as fallbacks.
  - A fallback that is not a port number or a port range counts as (2).
  - Each variable in the host part is checked for (3).
  - Any port of a fallback (or fallback range) inside a well-formed `port_range` is (4).
  - Variables in the IP part are ignored.
  Decided by: decision:stack-ports-checked-as-a-suite-rule.
- The violation code is `compose-ports`, and each message names its rule. `patternKey` returns `compose-ports:<1|2|3|4>`, so `/audit`'s clustering splits the four kinds. Decided by: the sibling `patternKey` shapes.
- The read-only subcommand is `plumbline compose-ports [<path>]` (`SUBCOMMANDS` entry). It prints one JSON object per published entry: `{"file": <relative path>, "line": <n>, "variables": [<names>], "port": <bare or fallback number or null>}`. It exits 0, or 1 on an internal error. The check and the subcommand share one reader function. Decided by: the work item ("one reader instead of a copy").
- `scripts/hooks/post-edit.js` needs no change. It runs `node bin/plumbline --lines <ranges> <file>` on every touched file. `runLint` walks a file target whatever its grammar, so a compose file reaches the new check, and the `--lines` filter keeps only changed lines. Decided by: the code at `post-edit.js::lintStage` and `plumbline::lintCmd`.
- The lint check sits in `runLint` under `config.checks.has(LINT_CHECK_COMPOSE_PORTS)`, beside the others. No corpus citation in `scripts/plumbline` (the true-up core cites the decision at its materialization row or `LINT_CHECKS` entry for the file instead; decided by `checks/materialized-standalone`). Decided by: plumbline-coding rule 2.

**Changes**
- `plugins/ok/families/ok-planner/scripts/plumbline`:
  - `LINT_CHECK_COMPOSE_PORTS` and `CODE_COMPOSE_PORTS`: new.
  - `LINT_CHECK_NAMES`: changed. It adds `compose-ports`.
  - `composePortEntries(file)` and `checkComposePorts(file, config)`: new.
  - `runLint`: changed. It runs the check on compose files.
  - `patternKey`: changed.
  - `SUBCOMMANDS`: changed. It adds `compose-ports`.
- `admin/converge::LINT_CHECKS`: changed. It adds `"compose-ports"`, so `render_rules` accepts the new marker (it asserts that every marker names a known check) and the `lint rules:` line names four checks. This lands before or with the rules item's marker.
- `admin/converge::published_ports()`: new. It runs `[NODE, PLUMBLINE_SRC, "compose-ports"]` at the root where `NODE` is set, and returns `[]` otherwise.
- `checks/owned-paths`: changed. It declares that `subprocess.run` site with its region.
- `ADMINISTRATION.md` **Lint checks.** paragraph: changed. It lists `compose-ports` beside the other three.

**Behavior changes**
- **B4** `plumbline::runLint` (the new check, on by default).
  - Before: a compose file publishing `"8080:80"`, `"80"`, or `${X}` lints clean.
  - After: each such entry is a `compose-ports` violation. The lint exits 2, and the edit hook blocks an edit on that line.
  - Users: in the release, `/converge`'s checks and `/audit`'s lint sweep. Across Converged projects, every project's compose files written under the previous cheatsheet rule ("publishes its container ports with no host port given").
  - Ruling: migrate (call). The project turns the check off with `lint_checks: {"compose-ports": false}`, or fixes each site, which `/converge` takes as an A8 defect, with each message naming the declared-name fix. Decided by: decision:stack-ports-checked-as-a-suite-rule, and decision:project-chooses-its-lint-checks (on by default).
- **B5** `plumbline::LINT_CHECK_NAMES` and `admin/converge::LINT_CHECKS`.
  - Before: `lint_checks` naming `compose-ports` is a defect ("unknown check"), and the `lint rules:` line names three checks.
  - After: it is valid, and the line names four.
  - Users: in the release, the `/ok` report relaying the line.
  - Ruling: rewrite.

### The suite's rules state the per-run port and artifact rule

**Calls**
- B7's Before text quotes the `{{CONVERGE-CODING-RULES}}` list as it stands at 119169e, so the After list is checked against the real text. Decided by: the notes review's build note.
- Rule 10 takes the file's form. Its title is "Lease a run's ports and remove what it built". Its `Prevents:` line comes from the work item. Its numbered steps each name evidence: the lint's output or the project lint's, and the stack commands named in the task note. One step says the stack's start leases before it builds, so the lease marks the run live for the cleanup. Decided by: decision:run-artifacts-removed-with-the-run Rationale ("the port leases tell a live run's tag from a dead one's").
- In `_converge/coding-rules.md`, the list reads "rules 1, 3, 4, 6, 7, 9, and 10, and rule 5 before you delete anything". Decided by: the work item.
- `ok-planner-CLAUDE.md`'s task-tracker paragraph names the port registry among `.cache/`'s contents. Deleting `.cache/` ends every lease, so delete it only when no run's stack is up. That file says to delete `.cache/` "between runs", and the registry would make that a collision. The file is shared with the issue-format and read-ledger items (`.cache/read/`), so the executor chains those stages. Decided by: decision:ports-leased-from-a-project-range ("the registry in the project's cache").

**Changes**
- `plugins/ok/families/ok-planner/docs/plumbline-coding.md`: changed. It adds `## 10.` with the compose-ports sentence between `<!-- lint-check: compose-ports -->` and `<!-- /lint-check -->`.
- `plugins/ok/families/ok-planner/skills/_converge/coding-rules.md` `{{CONVERGE-CODING-RULES}}`: changed. It adds rule 10.
- `plugins/ok/families/ok-planner/docs/plumbline-cheatsheet.md` Tooling: changed. A `compose-ports` bullet goes between its own markers, and the config line names `ports` and `port_range`.
- `plugins/ok/families/ok-planner/scripts/ok-planner-cheatsheet.md`: changed. "Per-run artifacts and verification stacks" is rewritten as the work item says, and the content-kinds bullets (`config.json`, and `bin/run-tag`, `bin/ports`) are updated.
- `plugins/ok/families/ok-planner/scripts/ok-planner-CLAUDE.md` task-tracker paragraph: changed, as the call says.

**Behavior changes**
- **B6** `docs/plumbline-coding.md` (rule 10) and `scripts/ok-planner-cheatsheet.md` (the per-run section).
  - Before: agents bind stacks to OS-assigned ports and read them back with `port-block`. No rule removes a run's artifacts.
  - After: agents and `/converge`'s reviewers hold every stack to the lease, release, and removal rule, which A8 counts.
  - Users: in the release, every vendored skill and agent reading the rules. Across Converged projects, each project's stack commands in `.ok-planner/review/project.md` and its compose files, which become A8 sites at the project's next true-up.
  - Ruling: migrate (call). The core's caller issues (B1) name each `port-block` line. `/converge` fixes the project-owned review facts and stack files as A8 defects. Turning `compose-ports` off drops the sentence naming the check and keeps the rule. Decided by: decision:stack-ports-checked-as-a-suite-rule.
- **B7** `skills/_converge/coding-rules.md` `{{CONVERGE-CODING-RULES}}`.
  - Before: converge coders follow rules 1, 3 to 7 (but not 2), and 9.
  - After: they also follow rule 10.
  - Users: in the release, every converge prompt and the sprint build prompt transcluding the block.
  - Ruling: rewrite.

### True-up walks the owner through choosing a port range

**Calls**
- `admin/true-up::ports_command` passes `OK_PLANNER_PROJECT_ROOT` in the environment as `intake_command` does, since `scripts/ports` resolves its root through `tasks.project_root()`. Decided by: plumbline-coding rule 2; the notes review's build note.
- The offer dict carries `"consent": ("amend", ".ok-planner/config.json")`. `print_offer` prints `On the owner's consent run: <consent_command("amend", ".ok-planner/config.json")> --from <draft>` for it, where the other offers print `resolve <id>`. `resolve port-range:.ok-planner/config.json` refuses with `resolve: port-range:… is settled by amend; run: <the amend command> --from <draft>`. Otherwise `resolve`'s fall-through would print "Resolved" over nothing written (A9). Decided by: the work item ("consent command is `amend …`"), and A9.
- The offer is withheld while a `config`, `config-key`, or `citation-tags` offer stands for `.ok-planner/config.json`. One pass then never writes that file from two drafts drawn from the same old text, which would drop the first draft's keys. It appears on the second diagnose that `/ok` step 6.4 runs in the same pass. Decided by: A7, and `/ok`'s "Settle any block the second run prints the same way".
- While the core holds a planner `port-block` copy for a caller, the block's `What:` also names that caller's issue ids and says the conversion ends the copy's read-back. Decided by: decision:whole-file-ownership (consent over owner-visible change).
- The read-only mode is `check-range FIRST LAST`, added to `USAGE` and the bash `case`. It delegates to `ports_command(["check-range", …])`.
  - It exits 1 with the refusal: a range that reaches the ephemeral start, names both numbers; a range outside 1025–65535 or out of order is also refused.
  - Otherwise it exits 0 and prints `range: F-L (<n> ports)`, `listed: <port> (<what>)` per hit, and `leasable: <count>`.
  - Listening ports are reported by the suggestion only, since they change moment to moment.
  Decided by: the work item, and decision:port-range-chosen-at-true-up ("names the ports the range hits and how many of its ports remain to lease").
- `suggest-range` picks uniformly among the 200-port windows above 1024 and below the ephemeral start that touch no listed port. It probes a window's ports for held ones and draws again on a hit, until every window has been tried. With no window left, it refuses with "no 200-port window below <n> is clear of listed and held ports; name a range". The block then says so in place of a suggestion. Decided by: decision:port-range-chosen-at-true-up.
- The block's `What:` lines name the declared names, the retired object form's keys, and each compose entry as `<file>:<line> publishes ${VAR…}` or `<file>:<line> publishes bare <port>`. The draft's `ports` is the declared names in order, then each compose variable name not yet declared, in file order. Decided by: the work item.
- `ADMINISTRATION.md`'s `port-range` drafting entry tells the front door to run `check-range` on an owner-named range before drafting. `plugins/ok/skills/ok/SKILL.md` needs no change: step 6.3 runs "the command its block names". Decided by: the code at `/ok` step 6.3.

**Changes**
- `admin/converge::port_range_offer()`: new. It is added in `offers()` after `config_offers()`. It builds the offer from the parsed config, `retired_ports`, `published_ports()`, and `ports_command(["suggest-range"])`.
- `admin/converge::print_offer`: changed. It handles `consent`.
- `admin/converge` `resolve`: changed. It refuses `port-range`.
- `admin/converge` `check-range` mode: new, with the bash `case` and `USAGE` entries.
- `checks/owned-paths`: unchanged for this mode, which writes nothing, unless its region needs naming.
- `ADMINISTRATION.md`: changed.
  - The modes block adds `check-range`.
  - The offers table adds the `port-range` row.
  - "Draft each kind this way" adds a `port-range` entry: ask once, offering the suggestion or a range the owner names; refuse a range that reaches the ephemeral start; on an overlap, warn with the ports hit and the leasable count; remind the owner that no other project may share the range; draft and run the `amend`; a decline is recorded and returns on the next `/ok`.
  - The audit section's list of offers that own their findings adds `port-range`.
- This repository's `.ok-planner/review/project.md`, the core's modes line: changed. It adds `check-range <first> <last>`. Shared with the rename item.

**Behavior changes**
- **B8** `admin/converge::offers` (diagnose, report, and the new mode).
  - Before: a project that declares `ports` or whose compose file publishes a port, with no range, diagnoses with no port offer (exit 0 when clean).
  - After: diagnose and true-up print the `port-range` block, diagnose exits 3 while it is the only one, `/ok` asks the owner one question, and `USAGE` lists `check-range`.
  - Users: in the release, `plugins/ok/skills/ok/SKILL.md`, which reads exit 3 as offers pending and runs the block's command, and `ADMINISTRATION.md`.
  - Ruling: rewrite.

### The drive's stack roles remove a run's artifacts, and the runs that start stacks run the cleanup

**Calls**
- With the one-hour grace, the audit's `ports cleanup` right after its measurements frees and removes only what is due; the experiments' own stack stops remove their fresh artifacts. The skill text and the run's receipt line say the cleanup frees and removes what is due, not that nothing is left behind. Decided by: the owner's grace-period ruling; the notes review's build note.
- The cleanup is an `exec` task: `tasks file --kind exec --key gate --command ".ok-planner/bin/ports cleanup"`, drained after step 4's stack stop and its instance and resource stops. A cleanup that fails is named in the return with its output tail, and the run goes on. Decided by: the sibling stop tasks in step 4.
- The return gains a `cleanup:` bullet: what each cleanup printed, "nothing to free or remove" where it printed nothing, or that none ran because `review drive-stack` printed `none` or `unfilled`. The audit report's Receipt gains `Cleanup: <what it printed | nothing to free or remove | the failure>`. Decided by: the work item ("into the run's report or return").
- `/audit` runs `.ok-planner/bin/ports cleanup` from the session once the assumption tasks drain, the way it runs the lint. `.ok-planner/bin/ports` joins the Requires list of materialized files. Decided by: the sibling Lint step.
- `RETIRED_PROJECT_MD_SEED_DIGESTS` adds the commit's seed digest `e8d948588a328f1c3aa7504dfcf462a34c004d9e6049d6dbd564daae39f3706a`. A project that still holds the unedited v25.4.0 seed then keeps its `review-facts` offer after the seed text changes. Decided by: the sibling digests already listed.
- `converge/SKILL.md` is shared with "Sprint certification drives every story", "A drive covers every variant…", and the rename item. The executor chains those stages. Decided by: the sprint's "Depends on" lines.

**Changes**
- `plugins/ok/families/ok-planner/review/seed/project.md` `## Drive commands` instruction: changed. `stack-start` leases with `.ok-planner/bin/ports lease <run-tag>` before it builds and starts the stack under the tag. `stack-stop` stops it, removes everything built under the tag whether the run passed or failed, and ends the lease with `.ok-planner/bin/ports release <run-tag>`.
- `admin/converge::RETIRED_PROJECT_MD_SEED_DIGESTS`: changed.
- `plugins/ok/families/ok-planner/skills/converge/SKILL.md`: changed. Drive mode step 4 adds the cleanup task, step 6 adds the same after its stops, and the return adds the `cleanup:` bullet.
- `plugins/ok/families/ok-planner/skills/audit/SKILL.md`: changed. A cleanup step after the assumption measurement drains, the Requires list, and the Receipt line.

**Improvements**
- **I1** `skills/converge/SKILL.md` drive mode step 6. The stop sequence (the stack stop, then the instance and resource stops) is written out twice, in step 4 and step 6, and this item adds the cleanup to both. That is one mechanism written twice, and every change to the stop doubles. Afterward: step 6 says "stop the stack and its drivers' resources as step 4 does, the cleanup included", and the sequence lives once, in step 4.

**Behavior changes**
- **B9** `skills/converge/SKILL.md` drive mode steps 4 and 6 (shared by sprint mode's drive).
  - Before: a drive stops its stack and leaves every lease and container artifact as it stands.
  - After: wherever the project has a stack, the drive runs `ports cleanup`, which frees the leases of dead runs in this checkout and removes container artifacts by run tag, and the return carries a `cleanup:` line.
  - Users: in the release, the sprint boilerplate that writes the return into the completion report, and the owner reading the return.
  - Ruling: rewrite.
- **B10** `skills/audit/SKILL.md`.
  - Before: the audit leaves the experiments' leases and artifacts.
  - After: it runs the cleanup once, and the report's Receipt carries its output.
  - Users: in the release, `/document`, which reads the same report.
  - Ruling: rewrite.
- **B11** `review/seed/project.md` and `admin/converge::seeded_project_md`.
  - Before: a new project's seed tells the owner the old stack roles, and a project holding the v25.4.0 seed gets the `review-facts` offer.
  - After: new seeds carry the lease and removal instruction. A project holding the v25.4.0 seed still gets the offer, through the added digest. A filled `project.md` is never rewritten.
  - Users: across Converged projects, every stored `.ok-planner/review/project.md`.
  - Ruling: preserve (call). Decided by: "seeded once and never overwritten" (`ADMINISTRATION.md`), and the digest sibling.

### The suite's documents and this project's facts name the allocator

**Calls**
- This repository's `.ok-planner/review/project.md` changes at two lines, not one. Line 38 is the developer-scripts line: `plugins/ok/families/ok-planner/scripts/ports` with `lease <run-tag>`, `release <run-tag>`, `cleanup`, `suggest-range`, and `check-range <first> <last>`. Line 47 lists the materialized scripts and gets `.ok-planner/bin/ports` in place of `.ok-planner/bin/port-block`. The file is shared with the rename, dashboard-drive, and issue-format items. Decided by: plumbline-coding rule 1.
- `docs/integration-contract.md`'s scripts list names the port allocator at `.ok-planner/bin/ports` with its block list at `.ok-planner/bin/ports-blocklist`. The repoint paragraph names `.ok-planner/bin/port-block` among the retired scripts whose callers get an issue. Decided by: the work item.
- The closing enumeration is `rg -n 'port-block|port_block|PORTBLOCK' plugins docs checks README.md .ok-planner/review/project.md`. It may list only the retired-script handling: `admin/true-up` (`WS_SCRIPTS`, `WS_DROP_INS`, `NO_DROP_IN`, `caller_issue`, `retired_scripts`, the planner plan), `ADMINISTRATION.md`'s workspaces and caller sections, and the contract's repoint paragraph. The vendored copies under `.claude/` and `.ok-planner/` change only at true-up. Decided by: the sprint's work-items preamble.

**Changes**
- `README.md` (line 78, the per-run verification stacks bullet): changed. "`run-tag` mints a fresh tag for each verification run, and `ports` leases a run's stack its host ports from the project's range, releases them, and cleans up after dead runs."
- `docs/integration-contract.md` (lines 243 and 304): changed.
- `plugins/ok/CLAUDE.md` (the support scripts list): changed, to `ports`.
- `plugins/ok/families/ok-planner/CLAUDE.md` layout: changed. `scripts/ports` is the port allocator, materialized to `.ok-planner/bin/ports`, and a new `scripts/ports-blocklist` line gives the allocator's block list, materialized to `.ok-planner/bin/ports-blocklist`.
- `plugins/ok/families/ok-planner/scripts/ok-planner-CLAUDE.md` lint-and-hooks paragraph: changed. "`bin/ports` leases, releases, and cleans up a run's host ports".
- `plugins/ok/families/ok-planner/admin/ADMINISTRATION.md`: changed. The executables list, the run-once list, and the workspaces text that compares the retired `port-block` with the current allocator. These are the same edits the first item lists; land them once.
- `.ok-planner/review/project.md` (this repository): changed, at lines 38 and 47.

**Behavior changes**
- **B12** `.ok-planner/review/project.md` (this repository's facts, pasted into every review prompt).
  - Before: the facts name `scripts/port-block` with a run-tag input, and `.ok-planner/bin/port-block` as a surface.
  - After: they name `scripts/ports` and its verbs, so A3 covers each verb's inputs.
  - Users: in the release, every `/converge` prompt in this repository.
  - Ruling: rewrite.

### Every comment and ruling records its author's name, and a write with no name refuses

**Calls**
- Shared files. `plugins/ok/families/ok-planner/scripts/issues` is edited by this item, by "Each person's reading lives in a ledger…", by "The readable `issues show`…" (`view`, `message_line`), and by "Every suite-owned file's stamp…" (line 2). `plugins/ok/families/ok-planner/scripts/dashboard` is edited by this item, by the ledger item, by the word-diff item, by the dashboard item (`SUMMARY_FIELDS`), by "The suite's documents, rules, prompts, and messages name the administration act true-up" (its two "/ok to converge" messages), and by the stamp item. The executor chains these stages in this order: this item, then the ledger item, then the word-diff item, then the dashboard item. The rename and stamp stages touch other lines of the same two files, so they are chained too. Decided by: the sprint's step 4 (overlapping files are chained).
- The module resolves the name in one function, `person(root)`, which returns `(name, source)` or raises `Refusal(…, "unnamed")`. Every person's write calls it before the transaction opens, so the git subprocess never runs under the intake lock. Decided by: plumbline-coding rule 3 (keep the lock short), rule 6 (one implementation).
- `XDG_CONFIG_HOME` counts only when it is set to an absolute path. Otherwise the module uses `~/.config/ok-planner/user.json`. Decided by: the XDG base-directory rule the outcome names.
- `user.json` can exist but not be a JSON object with a non-empty one-line string `name`. In that case the module refuses (`unnamed`): the message names the file and says to fix it with `issues name --set`. It does not fall back to git's user.name, which would sign the write under a name the person did not choose. Decided by: decision:messages-carry-their-authors-name (the configured name comes first), accept A3 (the refusal tells the user what to do).
- git counts only when `git -C <root> rev-parse --is-inside-work-tree` succeeds. Only then does the module read `git -C <root> config user.name`. Without that check, git would answer the global name outside a repository, and the outcome says a root that is not a repository gives no name. A `FileNotFoundError` from spawning git means git is absent. It is caught at that one site and treated as "no name from git", because the module takes a different branch there. Decided by: the outcome's wording, plumbline-coding rule 4.3.
- The refused names are `triage-issues`, `converge`, and also `owner`. Refusing `owner` keeps the outcome's claim that "no person's name matches" the legacy `owner` messages. The module refuses these on `--set` and when it reads the name. Decided by: the outcome's sentence on legacy messages, decision:owner-messages-can-change ("a message whose author matches no person's name stays as written").
- The refusal text names the act being signed, for example `issues: no name to sign this ruling with: set one with "issues name --set <your name>", or set git's user.name`. Decided by: the outcome's example message.
- Refusal reasons: `unnamed` covers a missing, malformed, or agent name, and `foreign` covers another person's message. The dashboard's `REFUSAL_STATUS` maps `unnamed` to 400 and `foreign` to 403. Decided by: the outcome.
- `issues name` prints `<name> (from <source>)`, where the source is the `user.json` path or `git config user.name`. With no name it refuses with the setting message, exit 2. It finds the estate like every other verb, because the git fallback reads the project root. Decided by: the outcome, and `main`'s existing estate lookup.
- `issues name --set <name>` strips the text and refuses an empty, multi-line, or refused name. It creates the folder and writes `{"name": <name>}` whole through the module's existing `write_records` (temp file, then `os.replace`), not a second atomic-write helper. Decided by: the outcome's atomic replace, plumbline-coding rule 6.
- The schema's author check for `comment` and `ruling` accepts any non-empty text with no newline that is not `triage-issues` or `converge`. `owner` stays valid, so legacy records still pass. `reply` stays `triage-issues`, and `update` stays `triage-issues` or `converge`. Decided by: the outcome.
- Renames, with every site in the same change: `OWNER_TYPES` becomes `PERSON_TYPES`, `OWNER_TRACE` becomes `PERSON_TRACE`, and `owner_text`, `owners_record`, `owner_entry`, and `owner_message` become `person_text`, `persons_record`, `own_entry`, and `person_message`. `OWNER` is deleted. These names are only called inside the module; the dashboard calls `rule`, `comment`, `edit_message`, `remove_message`, and `withdraw_ruling`, which keep their names. Enumeration: `rg -n 'OWNER|owner_|owners_' plugins/ok/families/ok-planner/scripts/issues plugins/ok/families/ok-planner/scripts/dashboard plugins/ok/families/ok-planner/scripts/review`. Decided by: plumbline-coding rule 1, cheatsheet Uniformity.
- `unrule` on a ruling that no ruling message carries (a ruling imported from a markdown issue, `admin/converge`'s import) refuses as a message with no matching author does. The refusal says to rule again to replace it. Decided by: decision:owner-messages-can-change.
- A ruling whose text equals the current ruling still writes nothing, so the author stays the first person to rule that text. Decided by: the issue format's existing rule, which no delta changes.
- `message_line` dispatches on type. A person's message prints its `by` as written. An agent message keeps today's writer display and reads `replies_to` or `changed` with `.get`, so a malformed message the module reads past cannot crash `show`. Decided by: decision:intake-reads-past-stray-lines, accept A3.
- `/api/meta` adds `name` (the resolved name, or null) and `name_hint` (the refusal's setting text when `name` is null, otherwise null). The service resolves the name on every request, so a name set while the service runs takes effect on the next write. Decided by: the outcome ("the name of the person who started the service"; the service runs in that person's environment).
- `scripts/issues` carries no citation. The true-up core's materialization row for `scripts/issues` cites `@decision: messages-carry-their-authors-name`, `@decision: owner-messages-can-change`, and `@decision: anyone-may-rule`. Decided by: `checks/materialized-standalone`, which lints every materialized script standalone with no citation tags declared and refuses a corpus citation in materialized markdown, so no file the family materializes carries a citation (the ports group's kickbacks settle the same way).

**Changes**
- `plugins/ok/families/ok-planner/scripts/issues::person`: new. Resolves the writing person's name: the configured `user.json`, then git's user.name in the project root. It refuses (`unnamed`) where neither gives a usable name.
- `…/scripts/issues::user_config_path`, `…::set_name`: new. Give the user-scoped file's path, and write it by atomic replace through `write_records`.
- `…/scripts/issues::cmd_name` and its `name` subparser (`--set <name>`): new.
- `…/scripts/issues::OWNER`: removed. `AUTHORS` becomes a per-type check: a person's name for `comment` and `ruling`, `TRIAGE` for `reply`, `AGENT_AUTHORS` for `update`.
- `…/scripts/issues::one_message_defects`: changed. Checks `by` against the per-type rule and its message names a person, not `owner`.
- `…/scripts/issues::message_defects`, `…::unseen`, `…::respond`, `…::untouched`, `…::readable_message`: changed. Each tells a person's message from an agent's by `type` (`PERSON_TYPES`, or `type == "reply"`), never by `by`. `respond`'s refusals say "a person's message".
- `…/scripts/issues::person_message` (was `owner_message`), `rule`, `comment`: changed. Write `by` = the resolved name. The latest ruling by anyone replaces the current one.
- `…/scripts/issues::own_entry` (was `owner_entry`), `edit_message`, `remove_message`, `withdraw_ruling`: changed. Act only on a message whose `by` equals the resolved name. On anything else they refuse `foreign`, naming the author; `unrule` adds "rule again to replace the ruling".
- `…/scripts/issues::message_line`: changed. A person's head is `<n>. <by> <type> <at>, <seen mark>`. Dispatch is by type.
- `…/scripts/issues::build_parser`: changed. Help reads "write your ruling", "write a comment", "withdraw your ruling", and "list issues you flagged…" stays. Adds the `name` verb.
- `…/scripts/dashboard::REFUSAL_STATUS`: changed. Adds `"unnamed": 400`, `"foreign": 403`.
- `…/scripts/dashboard::meta`: changed. Adds `name` and `name_hint` from `issues.person`, catching `issues.Refusal` with reason `unnamed` alone, because that branch returns a value the page acts on.

**Behavior changes**
- **B40** `scripts/issues::person_message` (`issues rule`, `issues comment`, the dashboard's rule and comment routes). Before: writes `by: "owner"` and never refuses for a name. After: writes the resolved name, and refuses with exit 2 (the dashboard answers 400) where no name resolves or the name is an agent's or `owner`. Users: in the release: the dashboard page's rule, accept, and comment controls; `/plan-sprint` transcribing a ruling (`issues rule --text -`, plan-sprint SKILL.md, Promote and File upstream); a flagged-issue session (ok-planner-CLAUDE.md); people at a terminal. Across Trued-up projects: none. A project's `bin/issues` and its intake are committed together, so no older module writes beside a newer one. Ruling: rewrite.
- **B41** `scripts/issues::one_message_defects` (the schema's author check). Before: a `comment` or `ruling` must carry `by: "owner"`. After: any non-empty one-line name other than an agent's, `owner` included. Users: in the release: every write's check, and `import`. Across Trued-up projects: every project's stored intake and archive, whose person messages all carry `owner`. Ruling: migrate: both shapes are accepted, `owner` and any person's name, and no record is rewritten (call; decision:intake-reads-past-stray-lines).
- **B42** `scripts/issues::own_entry`, `edit_message`, `remove_message`, `withdraw_ruling` (`issues edit`, `remove`, `unrule`, and the dashboard's edit, remove, and unrule routes). Before: act on any `owner` message, and refuse an agent's message with reason `invalid` (409). After: act only where `by` equals the caller's resolved name. Anything else refuses `foreign` (403), naming the author. A legacy `owner` message and a ruling with no ruling message stay as written. Users: in the release: the page's Edit, Remove or Withdraw, and Withdraw ruling controls (the dashboard item hides them on others' messages); people at a terminal. Across Trued-up projects: every stored `owner` message, which becomes fixed text after the upgrade. Ruling: migrate: legacy messages stay readable as a person's messages under the name `owner`, triage still answers them, and a person comments or rules again in place of editing one (call; decision:owner-messages-can-change).
- **B43** `scripts/issues::unseen`, `respond`, `message_defects`, `untouched`, `readable_message`. Before: a person's message is one whose `by` is `owner`. After: one whose `type` is `comment` or `ruling`. Every existing record gives the same counts. A named person's message now counts in `unseen` and `waiting`, and triage can answer and mark it seen. Users: in the release: `/triage-issues` (SKILL.md's owner-messages scope and `respond.md`), `/plan-sprint` Frame (`unseen`), the dashboard's waiting tab. Across Trued-up projects: none; existing data reads the same. Ruling: rewrite.
- **B44** `scripts/issues::message_line` (readable `issues show`). Before: a person's head reads `N. owner comment …`. After: `N. <by> comment …`, with the name as written. Users: in the release: people; triage's `respond` task and `/plan-sprint` read `show` as text. Ruling: rewrite.
- **B45** `scripts/issues::build_parser` and `respond`'s refusal texts. Before: "the owner's ruling", "an owner comment", "owner message". After: "your ruling", "a comment", "a person's message". Users: in the release: people reading help, and agents reading refusals. No caller matches on the text. Ruling: rewrite.
- **B46** `scripts/dashboard::REFUSAL_STATUS`, `meta`. Before: an edit of an agent's message answers 409, and `/api/meta` has no name. After: another person's message answers 403, a missing name answers 400, and `/api/meta` adds `name` and `name_hint`. Users: in the release: the page, which shows any refusal as a notice and reads `name` (the dashboard item); drivers using `curl`. Ruling: rewrite.

### Each person's reading lives in a ledger that git ignores, and an issue never read counts as new

**Calls**
- Shared files: `scripts/issues` and `scripts/dashboard`, as the first item's call says. This stage follows the names stage, because the ledger is keyed by `person(root)`.
- The ledger's mark per record is the highest **agent** message number the record held when last read. The drafted text says "the highest message number". The two count the same messages unread (`reply` and `update` above the mark), with one exception. A person can remove an untouched message at the tail; the module then gives the next message the same number. If a reader's mark had already reached that number, a "highest message number" mark would never count the new agent message as unread. Agent messages are never removed, so a mark at the highest agent number is always below the next agent message's number. Decided by: story:see-new-analysis, accept A9.
- Ledger path: `.ok-planner/.cache/read/<slug>-<first 8 hex of sha256(name, UTF-8)>.json`. The slug is the name lowercased, each run of characters other than ASCII letters and digits turned into `-`, trimmed, cut to 32 characters, and `person` where it comes out empty. The module reaches the folder through `tasks.cache_dir(root)`, which writes the `*` ignore file. Decided by: the outcome.
- Ledger content: `{"name": <name>, "records": {"<id> <opened>": {"first_read": <time>, "mark": <n>}}}`. JSON keys must be strings, so the key is the id and the opened time joined by one space. A seeded entry takes the seed time as `first_read`. Decided by: the outcome (key = id and opened time).
- The intake's lock is factored into one context manager, `locked(root)`, which opens `issues.lock` under `cache_dir` and takes `flock`. `transaction`, `mark_read`, and the ledger seeding all use it, so the lock is not opened in two places. Decided by: plumbline-coding rule 6, cheatsheet Uniformity.
- A reader needs a ledger whose file does not exist. Under `locked(root)` it then checks for the file again, rereads the store, and writes a seed holding every live and archived record at its current mark, through `write_records`. This is a check-then-write held under the lock. Decided by: plumbline-coding rule 3.2, the outcome.
- Readers read the ledger without the lock. Every write is an atomic replace, so a reader never sees a partial file. A ledger that does not parse as the shape above refuses (`invalid`): the message names the file and says that deleting it starts a fresh ledger with everything counted read. Decided by: accept A3 (a message the user can act on).
- `view(rec, archived=False, ledger=None)`, `select(…, ledger=None)`, and `history(root, ledger=None)` take the ledger as a parameter at the end. With `None`, `unread` is 0, `unopened` is false, and no message is `new`. The existing positional callers (`scripts/dashboard`, and `scripts/review::cmd_backlog`'s `select(root, category="defect")`) therefore keep working. `review`, an agent tool, passes no ledger and so neither creates nor reads one. Decided by: cheatsheet "explicit parameters", the outcome ("readers count nothing unread" without a name).
- `view` copies each message it flags (`new: true` on unread agent messages) and never changes the loaded record. Decided by: the outcome ("on a copy of the record, never stored").
- The CLI readers (`cmd_list`, `cmd_show`, `cmd_history`) get the ledger through one helper, `reading_ledger(root)`, which returns `(ledger, note)`. Where no name resolves, the CLI prints the note once on stderr (`issues: note: no name to count unread messages by: set one with …`). The dashboard calls the same helper and drops the note. `/api/meta`'s `name_hint` carries that text to the page. Decided by: the outcome (one stderr note).
- `mark_read` returns how many agent messages were unread before the read; on a never-read record that is all of them. The CLI's line and the route's `{"marked": n}` keep their form. Decided by: the existing output shape.
- `respond` and `update_message` stop writing `read: None`. `MESSAGE_FIELDS` for `reply` and `update` drop `read` from the required fields. The checker accepts `read` as an optional field and still checks its shape (null, or a time). `readable_message` adds no `read` default. Decided by: the outcome, decision:intake-reads-past-stray-lines.
- `summary_line` adds ` never read` where `unopened`, beside ` unread=N`. The agent head in `message_line` ends `, new` where the message is `new`, and carries no read time. Decided by: the outcome.
- `list --unread` includes a record, open or closed, where `unread > 0` or `unopened`. Help: "list issues with agent messages you have not read, or that you have never read, closed ones among them". `read`'s help: "record that you read an issue, in your own ledger, open or closed". Decided by: the outcome.
- The dashboard's GET routes (`/api/issues`, `/api/closed`, `/api/issue/<id>`) pass `reading_ledger(root)`'s ledger, so the service counts by the name of the person who started it. A GET may seed that person's ledger. That writes only the git-ignored file, under the lock. Decided by: the outcome, decision:read-marks-kept-per-person.
- The true-up core's materialization row for `scripts/issues` also cites `@decision: read-marks-kept-per-person`, `@decision: unread-issues-count-as-new`, and `@story: see-new-analysis`; the script carries none. The stage applies those deltas. Decided by: `checks/materialized-standalone`, which lints every materialized script standalone with no citation tags declared and refuses a corpus citation in materialized markdown, so no file the family materializes carries a citation (the ports group's kickbacks settle the same way).

**Changes**
- `plugins/ok/families/ok-planner/scripts/issues::locked`: new. The intake's lock as a context manager. `transaction` is changed to use it.
- `…/scripts/issues::ledger_path`, `…::read_ledger`, `…::seeded_ledger`, `…::reading_ledger`, `…::agent_mark`: new. Locate, read, seed, and resolve the reading person's ledger, and compute a record's highest agent message number.
- `…/scripts/issues::mark_read`: changed. Resolves the name (refusing `unnamed`). Under `locked`, it locates the record, adds `first_read` where the entry is new, raises `mark` to the record's highest agent message number, and writes the ledger. It writes no intake file.
- `…/scripts/issues::unread`: changed. Takes the ledger entry and counts agent messages above the mark, or all of them where there is no entry.
- `…/scripts/issues::view`, `…::select`, `…::history`: changed. Compute `unread`, `unopened`, and per-message `new` from the ledger. The `--unread` filter is `unread > 0 or unopened`.
- `…/scripts/issues::MESSAGE_FIELDS`, `…::one_message_defects`, `…::readable_message`, `…::update_message`, `…::respond`: changed. The retired `read` is no longer written, required, or defaulted, and is still accepted.
- `…/scripts/issues::summary_line`, `…::message_line`: changed. Print `never read`, and `new` per ledger.
- `…/scripts/issues::cmd_list`, `…::cmd_show`, `…::cmd_history`, `…::cmd_read`, `…::build_parser`: changed. Pass the ledger, print the note, and carry the help texts above.
- `…/scripts/dashboard::Handler._get`: changed. Passes `issues.reading_ledger(root)[0]` to `select`, `history`, and `view`.

**Behavior changes**
- **B47** `scripts/issues::mark_read` (`issues read`, `POST /api/issue/<id>/read`). Before: stamps `read` on every unread agent message in `.ok-planner/issues.jsonl` or the archive, a committed change that clears the marks for everyone, and needs no name. After: writes only the caller's git-ignored ledger, changes no intake file, and refuses (exit 2, or 400) with no name. Users: in the release: the dashboard page's open-an-unread-issue post (IssueDetail `open`); people at a terminal. Across Trued-up projects: none; the committed intake simply stops changing on reads. Ruling: rewrite.
- **B48** `scripts/issues::view`, `select`, `history`, `summary_line` (`list`/`show`/`history --json`, `list --unread`, the dashboard's summaries). Before: `unread` counts agent messages whose stored `read` is null, the same for everyone, and `--unread` lists only records with such messages. After: `unread` and the new `unopened` come from the reading person's ledger. `--unread` adds never-read records. With no name, nothing counts unread and one stderr note prints. Users: in the release: the dashboard page (the unread tab, counts, tags); people; no skill reads `unread`. Across Trued-up projects: each project's stored agent messages at `read: null`. Their unread marks from before the upgrade read as read once the person's fresh ledger seeds (this project: 7 live and 12 archived agent messages, all inside that window). Ruling: migrate: the `read` field stays as written and nothing reads it. A fresh ledger counts everything that exists as read, as decision:read-marks-kept-per-person chooses ("starts with everything that exists counted as read") (call; listed for the owner's veto, since a seed honoring `read: null` was the other form).
- **B49** `scripts/issues::respond`, `update_message`, `readable_message`, `MESSAGE_FIELDS`. Before: every new reply and update carries `read: null`, the schema requires `read`, and views default it. After: new agent messages carry no `read`, the schema accepts it present or absent, and views no longer add it. Users: in the release: the page's `isNew` (the dashboard item switches it to the computed `new`). Across Trued-up projects: a clone that pulled the true-up commit but still has the earlier placed page build (the build is git-ignored and placed per clone). That page reads `read === null` and shows nothing as new. Ruling: migrate: the schema accepts both shapes. For the older page, the service already reports a placed build whose version disagrees (`version_notes`, `build_agrees`), and the page's header says to run `/ok`, which places the matching build (call).
- **B50** `scripts/issues::message_line` (readable `show`, the agent head). Before: ends `read <time>` or `new`, from the stored field. After: ends `, new` where the reader's ledger counts the message new, and nothing otherwise. Users: in the release: people; triage and plan-sprint reading `show`. Ruling: rewrite.

### The readable `issues show` prints each update's difference as a word diff

**Calls**
- Shared files: `scripts/issues` (`view`'s callers, `message_line`) and `scripts/dashboard` (the issue route); this stage follows the ledger stage. `browser/src/views/IssueDetail.svelte` is shared with the dashboard item; this stage switches the drawing to `parts` and deletes `browser/src/lib/diff.js`, and the dashboard stage follows. Decided by: the sprint's step 4.
- One Python implementation in `scripts/issues`. `diff_text(value)` turns a value into text: null is empty; a list item that is an object with `text` becomes `<label or ->. <text>` and anything else is converted the same way, one item per line; an object with `text` becomes `(<form>) <text>` where it has a form, else its text; a string stays as written; anything else becomes `json.dumps(value, ensure_ascii=False, separators=(",", ":"))`, which matches `JSON.stringify`. `word_runs` uses `re.findall(r"\s+|\S+")`. `word_diff(before, after)` returns `[{"kind": "same"|"gone"|"added", "text"}]`, merging adjacent runs of one kind and breaking ties toward `gone` as `diff.js` does. Decided by: the outcome ("matching what the dashboard draws today").
- `word_diff` takes off the common leading and trailing runs before the longest-common-subsequence table, so a small edit to a long problem costs little. The largest update in this intake holds 895 runs per side, and an untrimmed table is about 800,000 cells per field on every GET of the issue. The result is a minimal diff with the same runs and kinds. Only the tie-break inside a run moved within the common tail can differ from `diff.js`. Decided by: accept A3 (a stall), the outcome's form.
- The parts are computed by one function, `with_diff_parts(v)`. Only `cmd_show` (readable and `--json`) and the dashboard's `GET /api/issue/<id>` call it, so `list` and `history` pay nothing. It sets `diff[field]["parts"]` on copies of the update message and its diff entries. Decided by: the outcome ("on each update's diff entry as a computed field, never stored").
- Readable layout under an update's head and text: per field, in the diff's own order, a line `    <field>:`, then the after-text indented eight spaces. Each `gone` run is printed as `[-…-]` and each `added` run as `{+…+}`, and a multi-line value is indented on each line. Decided by: the outcome.
- The true-up core's materialization row for `scripts/issues` also cites `@decision: agent-revisions-reach-the-owner`; `word_diff` carries none. Decided by: `checks/materialized-standalone`, which lints every materialized script standalone with no citation tags declared and refuses a corpus citation in materialized markdown, so no file the family materializes carries a citation (the ports group's kickbacks settle the same way).

**Changes**
- `plugins/ok/families/ok-planner/scripts/issues::diff_text`, `…::word_runs`, `…::word_diff`, `…::with_diff_parts`, `…::marked_diff`: new. The text form, the runs, the word diff, the computed parts, and the `[-…-]`/`{+…+}` rendering.
- `…/scripts/issues::message_line`: changed. An update with `diff` prints each field's marked after-text. One without `diff` prints as today.
- `…/scripts/issues::cmd_show`: changed. Applies `with_diff_parts` before printing or emitting JSON.
- `…/scripts/dashboard::Handler._get` (the `ISSUE_ROUTE` branch): changed. Answers `issues.with_diff_parts(issues.view(…))`.
- `plugins/ok/families/ok-planner/browser/src/views/IssueDetail.svelte`: changed. Draws `change.parts`, and the `wordDiff` import goes.
- `plugins/ok/families/ok-planner/browser/src/lib/diff.js`: removed. Its two exports, `shown` and `wordDiff`, have no other user: `rg -n "diff\.js|wordDiff|shown\(" plugins/ok/families/ok-planner/browser/src` lists IssueDetail alone.

**Behavior changes**
- **B51** `scripts/issues::message_line` (readable `issues show`). Before: an update message prints its head and one-line text. After: it also prints each revised field's after-text with removed runs in `[-…-]` and added runs in `{+…+}`. Users: in the release: people in a session; `/plan-sprint`'s walk and triage's `respond` task, which read `show`. Ruling: rewrite.
- **B52** `scripts/issues::cmd_show --json`, `scripts/dashboard` `GET /api/issue/<id>`. Before: each diff entry holds `before` and `after`. After: it adds `parts`, and the page draws `parts`. What the page shows is unchanged. Users: in the release: the dashboard page. Across Trued-up projects: an earlier placed build ignores `parts` and keeps computing its own diff, so it shows the same difference. Ruling: rewrite.

### The dashboard styles messages by type, names every author, and marks every unread issue, verified defects included

**Calls**
- B53 and B54 cross the trued-up boundary the way B49 does: a clone serving an earlier placed page build styles a named person's message as an agent's and shows controls that now answer 403. They take B49's migrate path: the service's version note tells the person to run `/ok`, which places the matching build. Decided by: the notes review's build note.
- Shared files: `browser/src/App.svelte` is also edited by the true-up rename item (its two "/ok to converge" notices). `browser/src/views/IssueDetail.svelte` is shared with the word-diff item. `scripts/dashboard` is shared as the first item says. This stage runs after the names, ledger, and word-diff stages. Decided by: the sprint's step 4.
- `App.svelte` passes `name={info?.name ?? null}` to `IssueDetail`. The page reads the name once, from `/api/meta`. Decided by: cheatsheet "explicit parameters".
- `isOwn(message, name)` holds where `name !== null && message.by === name`. Decided by: the outcome.
- `AGENT_AUTHORS` in `api.js` loses its last reader (`isNew` and `isAgent` read the type and the computed flag), so it is deleted with `OWNER`. The true-up rename item's keep list names it only so it is not renamed. Decided by: plumbline-coding rule 1.4.
- The module's view adds a computed `ruling_by`: the current ruling message's `by` (`current_ruling`), or null where none stands. The page's "Ruling" section names it, and shows "Withdraw ruling" only where `ruling_by === name`. The page gets the author from the module, not from a JS copy of `current_ruling`. Decided by: plumbline-coding rule 6, the outcome (controls only on the viewer's own messages).
- A message head shows `by` exactly as written. An agent's head reads `triage-issues · reply`, no longer `triage`, and a person's reads `<name> · comment`, no longer `you`. The `li.triage` style class keeps its name and now follows `isAgent`, which reads the type. Decided by: decision:messages-styled-by-type ("shows the author's name on every message"), the outcome ("its `by` as written").
- The compose labels "Your ruling" and "Your comment" stay. They label the viewer's own draft. Decided by: the outcome changes only the ruling section's heading.
- In `IssueList.svelte` the meta line shows `new issue` where `v.unopened`, and `{v.unread} new` only where `v.unread > 0`. Without that test, a never-read issue with no agent messages would print `0 new`. Decided by: the outcome.
- `IssueDetail`'s `open` calls `onchange({ ...view, unread: 0, unopened: false })` after the read posts. Decided by: the outcome ("clears both counts").
- When `info.name === null`, the header's announce area shows `info.name_hint` once. The page shows the module's text and does not write its own. Decided by: plumbline-coding rule 6.
- `// @decision: messages-styled-by-type` at `isAgent`, and `// @decision: unread-issues-count-as-new` at `isUnread`. Decided by: the sprint's step 8.

**Changes**
- `plugins/ok/families/ok-planner/browser/src/lib/api.js`: `OWNER` and `AGENT_AUTHORS` removed. `isAgent` = type `reply` or `update`. `isOwn(message, name)`. `isNew` = `Boolean(message.new)`. `isUnread` = `unread > 0 || unopened`. The `unread` tab's `holds` drops `v.state !== 'verified'`.
- `…/browser/src/views/IssueDetail.svelte`: takes `name`. Heads show `{m.by} · {m.type}` for every message. A person's message keeps its seen-by-triage tags. Edit and Withdraw show where `isOwn(m, name)`. The heading reads "Ruling" and the section names `record.ruling_by`. Withdraw ruling shows only on the viewer's own ruling. Opening an issue that `isUnread` marks posts the read and clears both counts.
- `…/browser/src/views/IssueList.svelte`: adds the `new issue` tag, and guards `N new` by `unread > 0`.
- `…/browser/src/App.svelte`: passes `name`, and shows `name_hint` in the header when no name resolves.
- `plugins/ok/families/ok-planner/scripts/dashboard::SUMMARY_FIELDS`: adds `unopened`.
- `plugins/ok/families/ok-planner/scripts/issues::view`: adds `ruling_by`, plus the `untouched` flag of I20.

**Improvements**
- **I20** `plugins/ok/families/ok-planner/scripts/issues::untouched`, which this sprint changes to read `type`: one mechanism built twice. `browser/src/lib/api.js::untouched` restates the same rule in JS (never seen, never edited, no reply names it) to choose the Remove or Withdraw label. Afterward: `view` marks each person's message copy with a computed `untouched`, the page reads `m.untouched`, and `api.js::untouched` is deleted.
- **I21** `plugins/ok/families/ok-planner/browser/src/lib/api.js::tabs`, which this sprint changes: accept A9. The `waiting` tab still drops `v.state === 'verified'`. A verified defect issue that holds a person's comment triage has not seen is `waiting` in the module, and triage answers it (triage-issues SKILL.md: "routed, ruled, or neither"). The tab's count leaves it out, so the page reports nothing waiting while triage still owes an answer. Afterward: the waiting tab holds `v.waiting` alone, as the unread tab now holds `isUnread` alone.

**Behavior changes**
- **B53** `browser/src/lib/api.js::isAgent`, `IssueDetail.svelte` message heads. Before: any message whose `by` is not `owner` is styled as an agent's, and heads read `you · …` and `triage · …`. After: the style follows `type`, and every head shows its `by` as written. Users: in the release: people on the page. Across Trued-up projects: none; the placed build ships with the service at true-up. Ruling: rewrite.
- **B54** `IssueDetail.svelte` controls and the ruling section. Before: Edit, Remove or Withdraw, and Withdraw ruling show on every `owner` message and ruling, and the heading reads "Your ruling". After: they show only on the viewer's own messages and ruling, and the heading reads "Ruling" with the ruling's author. Users: in the release: people on the page. Ruling: rewrite.
- **B55** `api.js::isUnread`, `tabs` (unread), `IssueList.svelte`, `IssueDetail.svelte::open`. Before: the unread tab leaves out verified defects and counts only issues with unread agent messages, and opening an issue posts a read only when agent messages are unread. After: it includes verified defects and never-read issues, shows `new issue`, and opening a never-read issue posts the read. Users: in the release: people on the page. Ruling: rewrite.
- **B56** `scripts/dashboard::SUMMARY_FIELDS`, and `scripts/issues::view`'s `ruling_by`. Before: summaries carry no `unopened`, and views carry no `ruling_by`. After: both are added. Users: in the release: the page; `list --json` readers see one more field. Ruling: rewrite.
- **B57** (I20) `scripts/issues::view`, `api.js::untouched`. Before: the page computes the Remove/Withdraw choice itself. After: views carry `untouched` on each person's message, and the page reads it. The label shown does not change. Users: in the release: the page; `--json` readers see one more field. Ruling: rewrite.
- **B58** (I21) `api.js::tabs` (waiting). Before: a verified defect with an unseen person's comment is missing from "waiting on triage". After: it is listed and counted there. Users: in the release: people on the page. Ruling: rewrite.

### The issue format and the suite's text describe several people working one intake

**Calls**
- This item's edits to `.ok-planner/review/project.md` (pasted into every review prompt) and to agent instructions (plan-sprint relaying the no-name refusal and recording nothing) are behavior changes for the agents that read them, listed the way B12 is, ruling `rewrite`. Decided by: the notes review's build note.
- Shared files: `skills/_shared/artifact-definitions.md` (also the true-up rename item); `scripts/ok-planner-cheatsheet.md` (also the port, rename, and certification-drive items); `scripts/ok-planner-CLAUDE.md` (also the port, rename, discovery-archive, and certification-drive items, and the dashboard-skill item below); `skills/plan-sprint/SKILL.md` (also the rename and work-items items); `.ok-planner/review/project.md` (also the port, rename, and dashboard-drive items); `plugins/ok/families/ok-planner/CLAUDE.md` (also the port, rename, and certification items, and the dashboard-skill item). Each is edited in a stage chained after the others that touch it. Decided by: the sprint's step 4.
- This text stage follows the names and ledger stages, so it describes the verbs as built. Decided by: the item's Depends on.
- Enumeration beyond the named paragraphs, all restating the same rule (plumbline-coding rule 1): `artifact-definitions.md` line 15 ("awaiting the owner's ruling"), line 244 (`unseen`/`unread`), line 246 ("Only the owner removes a message"), line 284 ("The owner alone writes `ruling` and owner messages"), line 292 ("An owner message triage has not yet seen"), line 293 (the read-mark and edit rules); `ok-planner-cheatsheet.md` line 32 ("while an owner comment awaits triage") and line 37 ("The ruling is the owner's alone"); `plugins/ok/families/ok-planner/CLAUDE.md`'s intake paragraph ("the owner alone writes the record's `ruling`", "answers the owner's comments"); `skills/triage-issues/SKILL.md` lines 31, 60, 73, 79, 84; `prompts/respond.md` lines 3, 15, 19, 32, 34; `prompts/triage.md` line 51; `skills/plan-sprint/SKILL.md` lines 45, 46. Command: `rg -n -i "owner message|owner comment|owner's ruling|owner messages|the owner alone|owner's alone" plugins/ok/families/ok-planner --glob '!browser/**'`. The role name "owner list" (`/converge`) stays. Decided by: decision:anyone-may-rule, plumbline-coding rule 1.
- `ok-planner-CLAUDE.md`'s task-tracker paragraph names the read ledgers among what `.cache/` holds. It says that deleting the directory between runs starts each person's ledger fresh, with everything counted as read. Decided by: decision:read-marks-kept-per-person (a fresh ledger starts with everything read), plumbline-coding rule 1.
- `plan-sprint/SKILL.md`'s Promote and File upstream steps say that `issues rule` signs the ruling with the name of the person running the session. Where it refuses for a missing name, the session relays the refusal's setting text to the owner and records nothing until a name resolves. Decided by: decision:messages-carry-their-authors-name, decision:flagged-issues-discussed-in-session.
- `.ok-planner/review/project.md`'s dashboard drive bullet tells a driver that needs a person's name to set `XDG_CONFIG_HOME` to a scratch folder for both `issues name --set` and the service. `issues name --set` must never write the operator's own `~/.config/ok-planner/user.json`. Two such folders give two people. Decided by: project.md's "What no agent of this loop ever runs" (no change to the operator's own setup), accept A2.

**Changes**
- `plugins/ok/families/ok-planner/skills/_shared/artifact-definitions.md`: `{{ISSUE-DEFINITION}}` and `{{ISSUE-FILE-FORMAT}}` are rewritten as the outcome lists, plus the enumerated lines above. The message table's `reply` and `update` rows drop `read`, and a retired `read` key stays as written. The writers table's "A person" row adds `issues name [--set <name>]`. `unseen`, `unread`, and `unopened` are defined. The edit rule matches by name. The ownership rule's transcription clause is added. Every update surface shows its difference.
- `plugins/ok/families/ok-planner/scripts/ok-planner-cheatsheet.md`: the "Discussing" paragraph, and lines 32 and 37.
- `plugins/ok/families/ok-planner/scripts/ok-planner-CLAUDE.md`: the flagged-issue paragraph, "The discussion", the heading "A ruling is a person's alone" and its paragraph, the dashboard paragraph, and the `.cache/` sentence of the task-tracker section.
- `plugins/ok/families/ok-planner/skills/triage-issues/SKILL.md`, `prompts/respond.md`, `prompts/triage.md`, `skills/plan-sprint/SKILL.md`: "owner message" becomes "a person's message", plus the plan-sprint refusal sentence.
- `plugins/ok/families/ok-planner/CLAUDE.md`: the intake paragraph's ownership sentence names a person.
- `.ok-planner/review/project.md`: the `issues` line (`name [--set <name>]`; `edit` and `remove` on your own messages; `unrule` on your own ruling; `read` writing your ledger; `--unread` covering never-read issues; the `foreign` and `unnamed` refusals); the dashboard line (`/api/meta`'s `name` and `name_hint`); the drive bullet's `XDG_CONFIG_HOME` step.

**Behavior changes**
None. Every change is new code no existing user reaches.

### Sprint certification drives every story

**Calls**
- Sprint step 4 skips the drive only where `review stories` prints no slug, or where `review drive-stack` prints `unfilled` or refuses. It says the reason in the return. Decided by: the work item ("only where the corpus holds no story") and drive mode's step 1, which lists stories with `review stories`.
- `--stories` is removed outright, with no shim. argparse then refuses it as an unrecognized argument, exit 2. Decided by: the work item, and the cheatsheet's uniformity rule (no coexisting dialects). Its one caller ships in the same payload.
- Live sprints keep their old step 12 wording. `admin/converge::SPRINT_LINE_REWRITES` gains no entry. Decided by: decision live-sprints-brought-current-on-true-up, whose Rationale scopes "retired" to a line that names a retired path or contract item. The old step 12 names neither, and its executor still runs `/converge sprint`, which now drives every story.
- This item's stage applies the deltas concept:completion-contract, decision:team-execution-cold-gate, and decision:drive-tries-each-story-as-a-user. Items 2, 3, and 6 build on that applied text. The stage regenerates `concepts.md` and `decisions.md` with `catalog-toc`. Decided by: execution step 4 (apply a delta once, in the stage that realizes it).
- Shared files the executor must sequence:
  - `skills/converge/SKILL.md`: also edited by "A drive covers every variant…" and by "The drive's stack roles remove a run's artifacts…" (drive step 4, confirm step 6).
  - `scripts/review`: also edited by "A drive covers every variant…" (`confirm_briefs`), "True-up leaves discovery notes…" (`OWNER_PATHS`), and "Every suite-owned file's stamp…" (the line-2 header).
  - `skills/plan-sprint/sprint-document.md`: also edited by items 5 and 8.
  - `skills/_sprint/shared.md`: also edited by "The merge sorts…" (the C4 row).
  - `README.md`, `plugins/ok/CLAUDE.md`, `plugins/ok/families/ok-planner/CLAUDE.md`, `scripts/ok-planner-CLAUDE.md`, `scripts/ok-planner-cheatsheet.md`, and `scripts/ok-cheatsheet.md`: also edited by the true-up rename items, the port items, and the several-people items.
  - Every delta-bearing stage shares the catalog TOCs.

  Decided by: execution step 4 (overlapping files are chained).

**Changes**
- `plugins/ok/families/ok-planner/skills/converge/SKILL.md::frontmatter description`: changed. The `sprint <path>` clause names "a drive of every story".
- `…/skills/converge/SKILL.md::The run finds, then fixes (Find, the sprint bullet)`: changed. It names a drive of every story.
- `…/skills/converge/SKILL.md::In drive mode (opening paragraph)`: changed. "Drive mode takes every story every run" now names sprint certification's drive too.
- `…/skills/converge/SKILL.md::Setting up the run step 1 (sprint shape line)`: changed. It names the count of changed files and the count of stories the drive takes.
- `…/skills/converge/SKILL.md::In sprint mode step 4 (The drive)`: changed. It runs drive mode's steps 2 to 4 over every story and files the drivers with `review drives` and no story list. It applies the skip rule from the first call.
- `plugins/ok/families/ok-planner/scripts/review::cmd_drives`: changed. The `--stories` branch goes, and so does the "--stories or --confirm" refusal. With no flag the verb files every story, through `story_slugs` (I40). `--confirm` stays as it is.
- `…/scripts/review::build_parser (drives)`: changed. `drives.add_argument("--stories", …)` goes.
- `plugins/ok/families/ok-planner/skills/_sprint/shared.md::{{SPRINT-CATALOG}}`: changed. The sentence under the classes table reads: every story is checked by the drive, and the merge agent sorts its failures by the scope test.
- `plugins/ok/families/ok-planner/skills/plan-sprint/sprint-document.md::{{SPRINT-DOCUMENT-TEMPLATE}} step 12`: changed. It reads:
  - a user gets what every story promises when a driver uses the running product;
  - a failure the sprint's change caused is fixed in the run;
  - a failure in code the change did not reach goes to the intake as a `category: defect` issue for the next `/converge`.
- `plugins/ok/families/ok-planner/scripts/ok-planner-CLAUDE.md::Executing a sprint (certification paragraph)`: changed. "Every story the sprint adds or amends holds…" becomes "every story holds…". It adds that a failure in code the change did not reach goes to the intake.
- `…/scripts/ok-planner-cheatsheet.md::Lifecycle`: changed. It names a drive of every story.
- `…/scripts/ok-cheatsheet.md::Executing a sprint`: changed. It names a drive of every story.
- `plugins/ok/families/ok-planner/CLAUDE.md::Family purpose`: changed. "drives every story".
- `plugins/ok/CLAUDE.md::Plugin purpose`: changed. "a drive of every story".
- `README.md::Planning and review (sprint loop paragraph)`: changed. "drives every story".
- Closing check: `rg -i "adds or amends|stories the sprint|sprint touches|--stories"` over `plugins/`, `README.md`, and `.claude/skills/release/` should list no sentence that limits certification's drive.

**Improvements**
- **I40** `plugins/ok/families/ok-planner/scripts/review::story_slugs` (new), called by `cmd_stories` and `cmd_drives`.
  - The maintenance cost: one population is listed twice. `cmd_stories`, which drive step 1 uses, and `cmd_drives`, which drive step 3 uses, each list `STORIES_DIR`. A filter added to one leaves the driven set different from the listed set.
  - The A3 harm: `cmd_drives` lists with a bare `os.listdir`, so a missing stories folder ends the developer script in a traceback.
  - Afterward: one function returns the sorted `*.md` stems under `STORIES_DIR`. On `OSError` it raises `ReviewError("cannot list …")`. Both verbs call it.

**Behavior changes**
- **B80** `…/skills/converge/SKILL.md::In sprint mode step 4` with `…/scripts/review::cmd_drives`.
  - Before: certification drives only the stories the sprint's deltas add or amend and those its work items name. With none, it skips the drive.
  - After: it drives every story under `.ok-planner/design/stories/`. A failure in code the change did not reach is set `backlog`, and the owner list files it as a `category: defect` issue.
  - Users in the release: sprint certification sessions; `merge.md` (its scope test, unchanged); `owner-list.md` (files the backlog failures); `_sprint/shared.md::{{SPRINT-CATALOG}}` (changed); the completion report through boilerplate step 13.
  - Across Converged projects: each consumer's vendored `converge` skill and `.ok-planner/bin/review`. One true-up writes both from the same payload. A project on an earlier release keeps both old copies.
  - Ruling: rewrite.
- **B81** `…/scripts/review::build_parser (drives --stories)`.
  - Before: `drives --stories <slugs>` filed those stories, and `--stories` with `--confirm` was refused.
  - After: `--stories` gets argparse's "unrecognized arguments", exit 2.
  - Users in the release: `converge/SKILL.md` sprint step 4, its one caller (changed).
  - Across Converged projects: the vendored skill and `bin/review` are materialized together.
  - Ruling: rewrite.
- **B82** `…/skills/plan-sprint/sprint-document.md::step 12`.
  - Before: a new sprint's step 12 says the drive covers the stories the sprint adds or amends.
  - After: step 12 says the drive covers every story, and names where each kind of failure goes.
  - Users in the release: every sprint `/plan-sprint` writes from now on.
  - Across Converged projects: live sprints in consumer projects keep the old text. Their executor runs the new `/converge sprint` anyway, and true-up leaves the text alone (first call).
  - Ruling: preserve (call).
- **B83** The prose that restates certification's drive (`ok-planner-CLAUDE.md`, `ok-planner-cheatsheet.md`, `ok-cheatsheet.md`, both `CLAUDE.md` files, `README.md`).
  - Before: the drive covers the sprint's stories.
  - After: the drive covers every story.
  - Users in the release: every session that loads the rules, and readers of the docs.
  - Across Converged projects: the materialized `.claude/rules/ok-planner-cheatsheet.md`, `.claude/rules/ok-cheatsheet.md`, and `.ok-planner/CLAUDE.md`. They are suite-owned and rewritten whole on true-up.
  - Ruling: rewrite.
- **B84** `…/scripts/review::cmd_drives` (I40).
  - Before: a missing `.ok-planner/design/stories/` raises a `FileNotFoundError` traceback.
  - After: it prints `review: cannot list .ok-planner/design/stories: <err>` and exits 1.
  - Users in the release: `converge/SKILL.md` drive step 3 and sprint step 4.
  - Across Converged projects: the vendored `bin/review`, written with the skill.
  - Ruling: rewrite.

### A drive covers every variant the story names, in a first-time user's order

**Calls**
- A variant's name is a short lowercase slug of the way the story's text names, such as `by-time` or `by-field`. A story whose text names one way has one variant, named `whole`. Decided by: the work item ("a story whose text names one way has one variant"), and the fingerprint form, which needs a name.
- A skill-surface failure also carries `--field variant=`. Its fingerprint becomes `story-<slug>-skill:<name>-<variant>-<divergence slug>`, because one variant can diverge at several lines. Decided by: the work item (a skill surface is reviewed for each variant), and `drive.md`'s existing one-fingerprint-per-divergence rule.
- The merge reads each driver's close result with `.ok-planner/bin/tasks dump --type task`, picking the task whose id is in the failure's `task` field. Every failure item records its driver's task (`--task <task>`). Decided by: `scripts/tasks::item_record`, which stores `task`. No new verb is needed (plumbline: one mechanism).
- A defect that folds failures on several variants holds them in `variant`, joined by `, `. The confirm brief names each one, and the confirm driver tries each. Decided by: `merge.md`'s existing rule that two failures with one cause are one defect.
- `confirm_briefs` prints `variant %s` from `fields.get("variant")`, the same way it prints `surface`. Decided by: plumbling-coding rule 2 (copy the sibling's shape).
- `merge.md` is shared with "The merge sorts…" and "The merge's ownership test…", in the chain 2 → 3 → 4. `SKILL.md` and `scripts/review` are shared with item 1, so this stage runs after item 1. Decided by: execution step 4.

**Changes**
- `plugins/ok/families/ok-planner/skills/converge/prompts/drive.md::Every way the story can be done`: changed. The driver reads the story's capability and benefit for each way the story says its benefit comes. Example: for a story that promises records narrowed by time and by field values, the variants are a narrowing by time and a narrowing by field values, on each kind of listing the story names. The driver drives each variant on each surface. It starts each surface as a first-time user would: on a freshly loaded page or a fresh state, it takes first the action a new user takes first, before it builds any other state.
- `…/prompts/drive.md::A surface that is a skill`: changed. The skill is reviewed for each variant. The fingerprint carries the variant (second call).
- `…/prompts/drive.md::Judge the outcome`: changed. Outcomes are judged per surface and per variant: a variant failed anywhere is failed there. The failure command adds `--field variant=<name>`, with the fingerprint `story-<slug>-<surface>-<variant>`.
- `…/prompts/drive.md::Confirm`: changed. The confirm driver tries the surface and the variant(s) the defect names.
- `…/prompts/drive.md::Close`: changed. The result reads `<slug>: <per surface: each variant: achieved|failed|stuck|blocked>; left behind: …`.
- `plugins/ok/families/ok-planner/skills/converge/prompts/merge.md::Read`: changed. For the drive, the merge also reads the close result of each driver whose story its failures name (third call).
- `…/prompts/merge.md::Judge each report (new-defect command)`: changed. For the drive it adds `--field variant=<the failure's variant>` beside `story` and `surface`.
- `plugins/ok/families/ok-planner/scripts/review::confirm_briefs`: changed. The brief reads `…; surface %s; variant %s; kickbacks %s; …`.
- `plugins/ok/families/ok-planner/skills/converge/SKILL.md::Find (drive bullet)` and `::In drive mode (opening paragraph)`: changed. Both name driving every variant the story names on each surface, in a first-time user's order.
- `…/SKILL.md::The return (hunt, sprint)`: changed. `hunt` gives each story's outcome per surface and variant. `sprint` gives the stories driven per surface and variant.

**Behavior changes**
- **B85** `…/prompts/drive.md`.
  - Before: a driver stops at the first path to the benefit on each surface. A failure is fingerprinted `story-<slug>-<surface>`, and the close lists one outcome per surface.
  - After: a driver drives each named variant per surface, in a first-time user's order. A failure carries `variant`, with the fingerprint `story-<slug>-<surface>-<variant>`. The close lists each variant.
  - Users in the release: `merge.md` (reads the failures and the close); `owner-list.md` (reads failures); the `SKILL.md` return.
  - Across Converged projects: the vendored skill and prompts, written together.
  - Ruling: rewrite.
- **B86** `…/prompts/merge.md`.
  - Before: a defect merged from a drive failure carries `story` and `surface`.
  - After: it also carries `variant`.
  - Users in the release: `scripts/review::confirm_briefs`; `fix.md`, `verify.md`, and `owner-list.md` (they read defects).
  - Across Converged projects: written together.
  - Ruling: rewrite.
- **B87** `…/scripts/review::confirm_briefs`.
  - Before: the brief names the surface.
  - After: the brief names the surface and the variant.
  - Users in the release: `drive.md::Confirm`.
  - Across Converged projects: the vendored `bin/review` with the skill.
  - Ruling: rewrite.
- **B88** `…/SKILL.md::The return`.
  - Before: per-story outcomes are given per surface.
  - After: they are given per surface and variant.
  - Users in the release: the owner, and the completion report through boilerplate step 13.
  - Across Converged projects: none beyond the vendored skill.
  - Ruling: rewrite.

### The merge sorts each drive failure by what the story's text names

**Calls**
- A failure where the story's text names a missing flow is merged as A8 (a live artifact's commitment), unless A3 fits better. A page or message that tells the user something false is merged as A9. Decided by: accept-list A8 and A9; the work item.
- `accept.md` stays as it is. Its "What the list leaves standing" lines apply "unless an entry above also holds". A3 (whose sites include "every failure the drive records") and A8 hold for every story failure. Decided by: decision accept-list-decides-defects, as amended.
- In sprint mode, a failure where a work item contradicts a story is merged with `entry=C4`. C4's check today requires an artifact "the sprint's deltas or work items name", and the drive now covers stories the sprint names nowhere. So the `{{SPRINT-CATALOG}}` C4 row adds: "or a story a driver could not get, where a sprint work item asked for the contradicting code". `fix.md` step 1 then confirms coverage by the sprint class an `entry` code names (C1 to M1), whatever the defect's `source`, so a fixer does not decline a C4 drive defect as uncovered by the accept list. Decided by: the work item ("a work item that contradicts a story is a commitment contradicted (C4)"), and plumbline-coding rule 8 (the fix's sibling).
- The `question` call for two readings keeps `--field kind=question --field file=.ok-planner/design/stories/<slug>.md`. Decided by: the work item, and A8 ("two compliant forms remain is a question").
- `merge.md` runs after item 2's stage. `_sprint/shared.md` runs after item 1's stage. `fix.md` and `owner-list.md` belong to this item alone. Decided by: execution step 4.

**Changes**
- `plugins/ok/families/ok-planner/skills/converge/prompts/merge.md::The drive's failures`: rewritten to the work item's bullets.
  - It sorts a failure as a defect wherever the story's text, or a decision's Choice, names what the driver could not get, a missing flow included.
  - A false page or message is a defect, whatever a work item says.
  - `not-owed` applies only to something the driver sought beyond the story's text or a Choice.
  - A work item never decides what a story owes. In sprint mode, a work item that contradicts a story is C4.
  - A3 and A8 cover every story failure.
  - The stuck rule's message clause stays as one way a stuck story is a defect.
  - The backlog scope test stays as it is.
  - The undecided paragraph's `not-owed` sort and question apply only where the story's text or a Choice leaves two readings.
- `…/prompts/fix.md::Fix step 1`: changed. A defect from a `stuck` story is fixed by making the product deliver what the story names: the message or help text where the defect names one, and the missing flow where the story names the flow. The sentence that declined a change to what a page or a verb offers goes. Coverage is confirmed by the sprint class an `entry` code names, whatever the `source`.
- `…/prompts/owner-list.md::Read (the not-owed bullet)`: changed. It takes the `not-owed` failures whose note names the story text's two readings.
- `plugins/ok/families/ok-planner/skills/_sprint/shared.md::{{SPRINT-CATALOG}} (C4 row)`: changed, as in the third call.

**Behavior changes**
- **B89** `…/prompts/merge.md::The drive's failures`.
  - Before: a stuck story that lacked a page, verb, or flow, and any failure the corpus did not decide, were sorted `not-owed` with a question. The owner list filed each question as a `product-intent` issue. Only A3 was named.
  - After: such failures are merged as defects where the story's text or a Choice names what was missing. A question stands only for two readings.
  - Users in the release: `fix.md` and `verify.md` (receive and judge the defects); confirm drives; `owner-list.md` (fewer product-intent issues); `/triage-issues`; the return counts.
  - Across Converged projects: the vendored prompts, written together.
  - Ruling: rewrite.
- **B90** `…/prompts/fix.md` (stuck rule).
  - Before: a fixer declines a change to what a page or a verb offers and records a question.
  - After: a fixer builds the flow the story names.
  - Users in the release: `verify.md`; confirm drives.
  - Across Converged projects: written together.
  - Ruling: rewrite.
- **B91** `…/prompts/fix.md` (coverage clause).
  - Before: a sprint class is read only for `source: sprint`.
  - After: a sprint class is read for any `entry` that names one.
  - Users in the release: `merge.md` (sets `entry`); `verify.md`.
  - Across Converged projects: written together.
  - Ruling: rewrite.
- **B92** `…/prompts/owner-list.md`.
  - Before: it files a question for each `not-owed` failure whose note says the corpus does not decide.
  - After: it files one only for a note that names two readings.
  - Users in the release: the intake's readers (`/triage-issues`, `/plan-sprint`).
  - Across Converged projects: written together.
  - Ruling: rewrite.
- **B93** `…/_sprint/shared.md::{{SPRINT-CATALOG}} C4`.
  - Before: C4 covers only artifacts the sprint names.
  - After: C4 also covers a story a work item's code contradicts.
  - Users in the release: `sprint-pass.md`, `merge.md`, `fix.md`, and `verify.md` (read the catalog).
  - Across Converged projects: written together.
  - Ruling: rewrite.

### The merge's ownership test sends a misclassed file's report to the list's own fix

**Calls**
- The merge's note names the corpus rule that decides the file's class, by artifact slug and sentence. Decided by: A8 (a rule that decides the fix).
- The fix's files name the file that holds the list.
  - In a consumer project that file is `.ok-planner/bin/review`. The test, applied again, classes it `suite`, so the report goes `upstream`.
  - In this repository it is `plugins/ok/families/ok-planner/scripts/review`, which `.ok-planner/review/project.md` lists among the developer scripts. `review owner` prints `project` for it, because its stamp reads `v{{`, not `v\d`.

  Decided by: the work item; decision runs-fix-what-the-project-owns; `scripts/review::left_alone`.
- The line goes in as the first bullet of the test, ahead of the `corpus` bullet, and binds in every mode. Decided by: the work item.
- `merge.md` runs after item 3's stage. "True-up leaves discovery notes…" fixes one such misclass in `OWNER_PATHS`. That item edits `scripts/review`, and this item does not, so the two do not conflict. Decided by: execution step 4.

**Changes**
- `plugins/ok/families/ok-planner/skills/converge/prompts/merge.md::The ownership test`: changed. It gains a first bullet. Where a file reads `corpus` only because the review script's list classes it so, and a rule the corpus states decides the file's class otherwise:
  - the list is the defect's site under A8;
  - the report merges with its fix in the file that holds the list;
  - the merge applies the ownership test to that file.

**Behavior changes**
- **B94** `…/prompts/merge.md::The ownership test`.
  - Before: a report whose file `review owner` classes `corpus` becomes a `judgment` item and an owner issue.
  - After: where a corpus rule contradicts the list's class, the report merges as a defect in the list's file. That file is the project's own here and suite-owned (so `upstream`) in a consumer.
  - Users in the release: `owner-list.md` (fewer judgment issues); `fix.md` and `verify.md` (now edit and judge the list file).
  - Across Converged projects: the vendored prompts, written together.
  - Ruling: rewrite.

### Every sprint work item changes the product

**Calls**
- The kickback line for such an item reads `<work item> — changes no file — <the outcome; the feature, script, or seed asset a user would need to reach it>`, because there is no `path::symbol` code fact to name. Decided by: the work item ("the output's kickback line carries that reason").
- Section 10 treats a no-file kickback as one the rules decide. The session reshapes the item into the feature, script, or seed asset as a call and re-runs code planning. It reaches the owner only where the reshaped item meets the owner question test, for example by changing a promise. Decided by: decision work-items-change-the-product; the work item.
- Live sprints keep their old step 11 and their old Work items guidance (decision live-sprints-brought-current-on-true-up: neither names a retired path or contract item).
- This stage applies the deltas concept:sprint and decision:work-items-change-the-product, and regenerates `concepts.md` and `decisions.md`.
- `sprint-document.md` is shared with items 1 and 8. `plan-sprint/SKILL.md` is shared with the several-people item (the term "owner message" at Frame) and the true-up rename item (§1's "Estate convergence"). Decided by: execution step 4.

**Changes**
- `plugins/ok/families/ok-planner/skills/plan-sprint/sprint-document.md::{{SPRINT-DOCUMENT-TEMPLATE}} (## Work items guidance)`: changed. Each work item changes the product: its code, configuration, documents, or design corpus. An item that consists of using what the sprint builds is reshaped into the feature, script, or seed asset that lets a user reach the outcome.
- `…/sprint-document.md::step 11`: changed. Execution and sprint certification need no owner action and file no task for the owner to perform. The archive and the commit after completion stay the owner's one act. A genuine blocker still stops the run.
- `plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md::5. Draft`: changed. It states the same rule for every work item the session drafts.
- `…/plan-sprint/SKILL.md::10. The owner's judgments (kickback bullet)`: changed. A work item that changes no file is a kickback the rules decide, and it goes back to the draft to be reshaped (second call).
- `plugins/ok/families/ok-planner/skills/plan-sprint/core.md::{{CODE-PLANNER-PROMPT}} step 8 and Output`: changed. Step 8 kicks back a work item that changes no file in the tree, as one that cannot be built as drafted, naming the outcome and the feature, script, or seed asset a user would need. The kickback line takes the form in the first call.

**Behavior changes**
- **B95** `…/core.md::{{CODE-PLANNER-PROMPT}}`.
  - Before: a work item that changes no file is planned like any other.
  - After: the code planner kicks it back with the reason above.
  - Users in the release: `plan-sprint/SKILL.md` §10 (changed).
  - Across Converged projects: the vendored `plan-sprint` skill and its `core.md`, written together.
  - Ruling: rewrite.
- **B96** `…/sprint-document.md` (Work items guidance, step 11).
  - Before and after: a new sprint carries the old text before, and the new text after.
  - Users in the release: every sprint written from now on.
  - Across Converged projects: live sprints in consumer projects keep the old text, and nothing in it names a retired path.
  - Ruling: preserve (call).
- **B97** `…/plan-sprint/SKILL.md` (§5, §10).
  - Before: the session drafts and plans an item that only operates the product.
  - After: the session reshapes such an item.
  - Users in the release: the owner in the planning session.
  - Across Converged projects: the vendored skill.
  - Ruling: rewrite.

### A dashboard drive serves a page built from the tree's source

**Calls**
- The substituted version is the bare version. The core's `placed:` line prints `(v<version>)`, and the driver strips the `v`. Decided by: `admin/converge::versioned`, which substitutes the bare version, and `scripts/dashboard::meta`/`BUILD_VERSION`, which compare bare versions for `build_agrees`.
- The copy runs `tar -C <browser> --exclude=./node_modules --exclude=./dist -cf - . | tar -C <tmp> -xf -`. macOS and Linux both ship tar; rsync may be missing.
- A missing `npm`, or a failed `npm ci` or `npm run build`, is `blocked`. Decided by: the work item, and `drive.md`'s `blocked` definition.
- The bullet stays one `- The dashboard:` bullet, and none of its lines starts with "- `<role>`:", so `scripts/review::drive_commands` (regex ``^- `([a-z-]+)`: ``) still reads the section and `review drive-stack` still prints `none`.
- `project.md` gets no `@decision` annotation. The review loop pastes the file verbatim into every prompt, and annotations mark enforcing code.
- `.ok-planner/review/project.md` is shared with the true-up rename item, which rewrites this same bullet ("converge it with the converge core", the core's path), the port docs item (the developer-scripts line), and the several-people item (the `issues` verbs, `/api/meta`). Chain this stage after the true-up core rename stage, so the bullet's `admin/true-up` path exists when it lands.
- This stage applies the delta decision:drive-serves-the-tree-page-build and regenerates `decisions.md`.

**Changes**
- `.ok-planner/review/project.md::## Drive commands (the dashboard bullet)`: changed, in order:
  1. Make a scratch project and true it up with `plugins/ok/families/ok-planner/admin/true-up`, run with no argument.
  2. Copy the working tree's `plugins/ok/families/ok-planner/browser/` into a second `mktemp -d` folder, without `node_modules/` and `dist/`.
  3. Run `npm ci` and `npm run build` there.
  4. Remove every file under the scratch project's `.ok-planner/dashboard/` except `.gitignore`, and copy in the build's `dist/` contents. Replace `{{OK_PLANNER_VERSION}}` in each file with the version from the core's `placed:` line.
  5. Seed the intake, start the service, and drive it as today.
  6. Stop the service with `kill <pid>`, then delete both scratch folders.

  The bullet says that nothing under `browser/` changes during a drive, that a failed `npm ci` or build is `blocked`, and that the committed `browser/dist/` stays `/release`'s artifact.

**Behavior changes**
- **B98** `.ok-planner/review/project.md::## Drive commands (dashboard)`.
  - Before: a dashboard driver serves the committed release build that true-up placed.
  - After: the driver serves a build of the tree's page source, stamped with the scratch project's version. The drive needs npm and network access, and an install or build failure is `blocked`.
  - Users in the release: dashboard drivers in this repository's `/converge` drive and sprint modes (`drive.md` reads `[PROJECT]`); the merge (sorts the `blocked` failures `environment`).
  - Across boundaries: none. This is the project's own facts file and ships in no plugin.
  - Ruling: rewrite.

### The true-up core is a file named true-up whose default mode is true-up

**Calls**
- The file to move is `plugins/ok/families/ok-planner/admin/converge`. The work item's first bullet names `admin/true-up` on both sides of the rename. Run `git mv plugins/ok/families/ok-planner/admin/converge plugins/ok/families/ok-planner/admin/true-up` and keep mode 755. Decided by: the tree at 119169e, which holds `admin/converge` and no `admin/true-up`, and the work item's Release boundaries paragraph, which names `admin/converge` as the old name.
- `true-up` given as an explicit first argument stays refused (`true-up: true-up names no mode; nothing written`), just as `converge` is refused today. The default mode runs only with no argument. Decided by: the work item ("run with no argument") and plumbline-coding rule 7.2 (keep each refusal the old parser made).
- The retired skill name `true-up` stays wherever it detects a layout an earlier release wrote. Those sites are `RETIRED_VENDORED` in the core, the "Offered names" list and the "merged `true-up` verb" sentence in ADMINISTRATION.md, and the three true-up checks in `checks/vendored-layer` (`scripts/true-up-skill.md`, `skills/true-up/`, `.claude/skills/true-up`). Where prose names that skill, it reads "the retired `/true-up` skill", so it reads as a slash verb and not as the act. Decided by: the concept:true-up delta ("not a verb a project carries"), and plumbline-coding rule 5 (keep the only detection of a retired layout).
- The stage that moves the file lands these deltas: story true-up-project-estate (new), story converge-project-estate (retire), decision pinned-build-placed-at-true-up (new), decision pinned-build-placed-at-converge (retire), and concept integration-contract, whose see-also names the new story. The same stage repoints all six annotation sites and runs `python3 .ok-planner/bin/catalog-toc`. The six sites are the core's lines 251, 2382, 2896, and 3427; `plugins/ok/skills/ok/SKILL.md:6`; and `.claude/skills/release/SKILL.md:131`. The last two move into this stage from the documents item. Decided by: a retirement deletes the old slug's file while six sites still cite it, and the lint's citation-resolution check (edit hook and completion contract item 2) refuses a slug that names no file.
- The same stage updates `.ok-planner/review/project.md`'s "What no agent of this loop ever runs" bullet to name `plugins/ok/families/ok-planner/admin/true-up`. Decided by: A8. The limits in that file bind every agent, and once the file moves, the limit would no longer name the core it forbids running at the root.
- I settled the "Installed plugins" case: no mismatch reaches a user (see B120). Decided by: the plugin cache on this machine, `~/.claude/plugins/cache/ok-plugins/<plugin>/`, which holds one folder per version (22.1.0 through 25.4.0 side by side), and `/ok`'s own step 1 text, which says plugin changes take effect only after `/reload-plugins` or a restart.
- This stage lands before every other stage of the sprint that touches the core or its callers. Files shared with other groups: the core (the ports items change `EXECUTABLE_FILES`, `LINT_CHECKS`, `CONFIG_CHECK_KEYS`, the port-range offer, `WS_DROP_INS`/`NO_DROP_IN`, and the retired `port-block`), `ADMINISTRATION.md`, `plugins/ok/CLAUDE.md`, `plugins/ok/families/ok-planner/CLAUDE.md`, `docs/integration-contract.md`, `README.md`, and `.ok-planner/review/project.md` (the ports developer-scripts line, the names group's `issues` verbs, and the dashboard-drive group's bullet, which names the core by its new path). Chain each of those stages after this one with `--after`. Decided by: two stages whose files overlap are chained.

**Changes**
- `plugins/ok/families/ok-planner/admin/converge` → `admin/true-up` (git mv, executable).
- `admin/true-up` (bash part): `USAGE` reads `usage: true-up [diagnose | …]; with no argument, true-up materializes …`; `MODE="true-up"`; the no-mode refusal reads `true-up: %s names no mode; nothing written`; the template-not-found message reads `true-up: template not found at %s`; `vendor_layer true-up`; both closing lines read `Trued up ok-planner at %s (…)`; diagnose's last line reads `… Run true-up to repair.`; the finding suffixes read `; true-up regenerates it`, `true-up seeds it from the carried skeleton`, `; true-up rewrites it`, and `true-up removes it on sight` / `with the apparatus` (seven lines).
- `admin/true-up` (python part): `core = os.path.join(script_dir, "true-up")`, so every printed consent command names `admin/true-up`. Every `converge: …` prefix becomes `true-up: …`: `carried_build`'s two assertions, `config_defects`, `file_caller_issues`, and `probe`'s two messages (`… ; true-up wrote nothing further`). The usage lines become `usage: true-up wire-hooks <group>` and `usage: true-up resolve <id> …`. The resolve tail reads `Resolved %s. Run true-up to bring the estate current.` The administration-sense texts say true-up: `NODE_MISSING`, `review_plan`'s conflict text, `move_conflict_offer`, both texts of `estate_edits_offer`, `leftover_offer`, the `config-conflict` text, `CALLER_LEFT` (4), `caller_issue`'s problem, fix, and keep texts, the `collision` offer's fix, the `review-config` offer's what, the three `migrate_*` "not moved/removed" messages, and every diagnose finding at lines 3328–3389. The default-mode branch becomes `if mode == "true-up":`. The annotations become `# @story: true-up-project-estate` (two sites) and `# @decision: pinned-build-placed-at-true-up` (two sites). These stay: `SKILLS["converge"]`, `UNPREFIXED`, `SHARED`'s `_converge`, `converge-local`/`converge-cascade` in `RETIRED_VENDORED`, and the `/converge` messages at lines 2007, 2023, and 2720.
- `plugins/ok/skills/ok/SKILL.md`: lines 12, 51, 53, 63, and 70 name `admin/true-up`. Line 6 reads `<!-- @story: true-up-project-estate -->`.
- `plugins/ok/families/ok-planner/admin/ADMINISTRATION.md`: line 3 "(`admin/true-up`)", the command block (lines 10–15), and line 257's `amend` command.
- `plugins/ok/CLAUDE.md` lines 7 and 15. `plugins/ok/families/ok-planner/CLAUDE.md`'s layout line 16 reads `admin/true-up   # Deterministic true-up core (diagnose/true-up/wire-hooks <group>/wire-env/resolve/amend) …`.
- `docs/integration-contract.md` lines 105, 397, and 421. `README.md` line 190.
- `checks/vendored-layer`: `core` joins `"true-up"`, and the messages read "missing the true-up core at admin/true-up" and "admin/true-up is not executable". The administration-sense messages at lines 68, 86, and 108 read "a true-up dropped it" and "a deliberate, committed true-up".
- `checks/owned-paths`: `CORE_LABEL = "ok-planner admin/true-up"`. `CORE` joins `"true-up"`. The region key `"converge"` becomes `"true-up"`, marked by `'\nif mode == "true-up":'`. Every `("converge",)` tuple (lines 454, 455, 464, 497, 522) becomes `("true-up",)`. Line 342's message reads "on every true-up".
- `.ok-planner/review/project.md`: lines 15, 30 ("none for true-up"), 42, 47, and 53 name the true-up core at its new path. Line 43, the dashboard bullet, is the dashboard-drive group's rewrite, which names the new path. Line 32's `converge` author stays.
- `.claude/skills/release/SKILL.md:131` reads `<!-- @decision: pinned-build-placed-at-true-up -->`.

**Improvements**
- **I60** `admin/true-up::collision`, `::retirements`, `::review_plan`, `::offers`: these definitions carry docstrings in a file without the `@plumbline:allow-docstrings` marker, so they break the comment rule of `.claude/rules/plumbline-cheatsheet.md` (A8; project.md lists the file under Code rules). The rename edits each of these docstrings anyway. Afterward: the four docstrings are deleted rather than reworded. Every other docstring in the core stays, since no other change touches it.

**Behavior changes**
- **B120** `plugins/ok/families/ok-planner/admin/converge`. Before: the core runs as `bash <payload>/admin/converge [mode]`. After: it runs as `bash <payload>/admin/true-up [mode]`, and `admin/converge` no longer exists. Users: in the release: `/ok`'s SKILL.md, ADMINISTRATION.md, the consent commands the core prints, `checks/vendored-layer`, `checks/owned-paths`, `.ok-planner/review/project.md`, README, both CLAUDE.md files, and the integration contract, all changed here. Across Trued-up projects: none, since no vendored file names the core (`rg 'admin/' ` over the payload's skills, scripts, agents, docs, and review finds nothing). Across Installed plugins: a session that loaded `/ok`'s text before step 1 updated the plugin. Updates install each version into a folder of its own and leave the loaded version's folder in place, and a session keeps the plugin root it loaded until `/reload-plugins` or a restart. So pre-update text resolves `<payload>` against the pre-update copy, which still holds `admin/converge`, and post-update text arrives only with the post-update root. The one mismatch is this monorepo's fallback, `${CLAUDE_PLUGIN_ROOT:-plugins/ok}` with the variable unset: it pairs the loaded text with the working tree, and there bash answers "No such file" and nothing is written. That case reaches only this repository's owner, and the next session loads the new text. Ruling: rewrite.
- **B121** `admin/true-up` output text: the usage line, the no-mode refusal prefix, every `converge:` error prefix, the closing `Trued up ok-planner at …` line, diagnose's `Run true-up to repair.`, and the finding and offer wording. Before: each says converge. After: each says true-up. Exit codes, ids, and line kinds (`DRIFT:`, `CLEANUP OFFERED`, `removed:`, `repointed:`, `filed:`) are unchanged. Users: in the release: `/ok` relays the lines, and ADMINISTRATION.md line 18 quotes the refusal and is updated. No check or script parses the wording. Ruling: rewrite.
- **B122** `admin/true-up::caller_issue`. Before: the intake issues the core files about retired-script callers say "converge rewrites none of its lines …". After: they say true-up. Users: across Trued-up projects: issues already filed in a consumer's intake are stored and keep their text. `unfiled` keys on the unchanged id, so none is filed twice. Ruling: preserve (call).

### Every suite-owned file's stamp says it is overwritten on true-up

**Calls**
- The closing sweep is `rg -n 'overwritten (wholesale )?on converge|plugin-owned, overwritten' plugins/ checks/`, covering `scripts/hooks/`, so the `post-edit.js` variant is caught. Decided by: the notes review's build note.
- No stamp reader keys on the tail, and this stage adds none. The readers: the core's `stamped` (`ANY_OK_STAMP = "<!-- Materialized by ok"` prefix), `head_stamped` (substring "Materialized by ok" in the first five lines), and `suite_stamped`; `scripts/review`'s `MATERIALIZED_STAMP` (`^<!-- Materialized by ok[a-z-]* v\S+ .*-->`, any tail) and `SUITE_STAMP` (prefix and version digit); `scripts/hooks/agent-model`'s `VENDORED_STAMP` (prefix); `scripts/dashboard`'s `ESTATE_VERSION` (the version, then `.`, `,`, `;`, or whitespace, which both forms satisfy); the lint's `materializedStamp` (`/^\s*(?:Materialized|Vendored) by\s+\S+\s+v/`); `/ok-version` (`Materialized by ok-planner v<X.Y.Z>`); and the cheatsheet's suite-owned rule (`Materialized by ok-`). `rg -n 'overwritten on converge'` finds stamp text alone, never a matcher. Decided by: reading each reader at 119169e.
- The core's `suite_renderings` and `folder_differs` compare against the current `STAMP` on both sides. An old `.ok-review/` file already fails `suite_renderings` on its version number, so the new tail moves no file from removed to offered. Decided by: `suite_renderings`, which renders the carried text at the current version.
- `scripts/hooks/post-edit.js`'s line reads `// Materialized by ok-planner v{{OK_PLANNER_VERSION}} — suite-owned; overwritten wholesale on true-up by the front door's administration (/ok); do not hand-edit.`. This drops its "plugin-owned," wording, since the work item gives it the same long form as the two Python hooks. Decided by: the work item ("the same"), and the cheatsheet's Uniformity rule (one idiom per job).
- A script another group adds (`scripts/ports`) carries the new form from its first write, and `scripts/port-block` is edited only while it still exists. Whichever stage lands second sweeps with `rg -n 'overwritten (wholesale )?on converge' plugins/ checks/` and fixes every hit. Decided by: plumbline-coding rule 1.
- This stage shares every script header with other groups: `issues` (names, ledger, diff), `review` (drives, variants, the notes item), `dashboard` (names, detach), `plumbline` and `post-edit.js` (compose-ports), and `docs/plumbline-coding.md` (rule 10). Chain it after those stages, or land it before them with each later stage keeping the new header. Decided by: overlapping files are chained.

**Changes**
- `admin/true-up::STAMP`: `"\n<!-- Materialized by ok-planner v%s — suite-owned; overwritten on true-up; do not hand-edit. -->\n"`.
- Header line of `scripts/run-tag`, `issues`, `review`, `tasks`, `hooks/session-start`, `plumbline`, `catalog-toc`, `dashboard`, `port-block` (while present), `surface-corpus`, `dashboard-gitignore`, and each script the sprint adds: `Materialized by ok-planner v{{OK_PLANNER_VERSION}} — suite-owned; overwritten on true-up; do not hand-edit.`.
- `scripts/hooks/agent-model`, `scripts/hooks/subagent-batching`, and `scripts/hooks/post-edit.js`: `… — suite-owned; overwritten wholesale on true-up by the front door's administration (/ok); do not hand-edit.`.
- Head text of `scripts/ok-cheatsheet.md`, `scripts/ok-planner-cheatsheet.md` (lines 3–5), `docs/plumbline-cheatsheet.md`, and `docs/plumbline-coding.md`: `Suite-owned: overwritten wholesale on true-up (`/ok`); project-specific rules belong in your own files under `.claude/rules/`.`. Head of `scripts/ok-planner-CLAUDE.md` (lines 3–6): `Suite-owned boilerplate: true-up (`/ok`) overwrites this file wholesale. Do not hand-edit it; …`. The `Materialized by ok-planner v{{OK_PLANNER_VERSION}}.` opening stays on line 3 of each.

**Behavior changes**
- **B123** every materialized file's stamp or head text. Before: "… overwritten on converge …" or "overwritten wholesale by the front door's administration". After: "… overwritten on true-up …". Users: in the release: the readers listed under Calls, none of which reads the tail. Across Trued-up projects: a project at an earlier release keeps its old stamps until its next true-up, which rewrites every stamp in one pass, as a version change already does. An old pinned reader therefore never meets a new stamp unless that same pass rewrites the reader too, and a new reader reads an old stamp by its prefix. Ruling: preserve (call).

### The suite's documents, rules, prompts, and messages name the administration act true-up

**Calls**
- The closing `rg` excludes `plugins/ok/families/ok-planner/browser/dist/`. It holds two hits, App.svelte's notices compiled into the committed bundle, and the sprint edits nothing there. Decided by: the work item ("The committed build under `browser/dist/` changes at the next release"), and decision lockstep-suite-version (the release rebuilds the bundle).
- Three files outside the work item's list also turn up in its closing `rg`, and this stage renames them: `plugins/ok/families/ok-planner/skills/ok-version/SKILL.md:14` ("unless an `/ok` run trued up the project during this session"), `skills/triage-issues/prompts/respond.md:40` (its example reads "Options now cover how true-up finds stale content."), and `plugins/ok/.claude-plugin/plugin.json`'s description ("install, true up, repair", the same text as its marketplace entry). Decided by: the work item's closing `rg`, and DRY (the two copies of one description must agree).
- Keep-list sites the enumeration shows in these files stay as written: `/converge` and `/converge sprint` everywhere; `.claude/skills/converge/` in ADMINISTRATION.md line 325; the `converge` skill name in `docs/integration-contract.md:404`; the work-driving verb list in `plugins/ok/CLAUDE.md:17`; `review/seed/config.json`; and `_converge`. Decided by: the sprint's keep list.
- The change to ok-conduct's body means the next `/release` advances the conduct's minor version and its animal. The sprint changes no conduct stamp. Decided by: decision lockstep-suite-version.
- The `.claude/skills/release/SKILL.md` and `plugins/ok/skills/ok/SKILL.md` annotations land in the core-rename stage (see that item). This stage edits the rest of the prose in those files.
- Files shared with other groups: ADMINISTRATION.md (the ports items, plus items 5, 8, and 9 here), `ok-planner-CLAUDE.md` and `ok-planner-cheatsheet.md` (ports, names, certification, the archive item), `skills/audit/SKILL.md` (ports cleanup, declared folders), `skills/plan-sprint/SKILL.md` (work items, names), `skills/dashboard/SKILL.md` (detach), `scripts/dashboard`, `browser/src/App.svelte` (the names group's header notice), `README.md`, and `.claude/skills/release/SKILL.md`. Chain with `--after`. Decided by: overlapping files are chained.

**Changes**
- `plugins/ok/skills/ok/SKILL.md`: the description ("true-up core plus administration document", "and trues up again"), the intro paragraph, step 1 ("only when the owner trues it up"), step 2, step 4.3 (titled **True up.**), step 5.4 (**True up again.**), the report row (`trued up (vendored layer re-stamped …)`), the outcome values (`trued up`, `trued up; audit findings pending: <n>`), "true-up left the line for the owner", and the boundary text. The retired-verb table keeps its `/converge` rows.
- `plugins/ok/families/ok-planner/admin/ADMINISTRATION.md`: every administration-sense use (about 60), including "on every true-up", "True up again after it", "pending true-up", and "rewritten by true-up". The keep sites stay.
- `docs/integration-contract.md`: lines 56, 65, 67, 92, 110, 120, 126, 145, 154, 165, 176, 196, 213, 248, 250, 287, 288, 296, 307, 313, 317 ("its last true-up placed"), 320, 326, 336, 338, 385, 389, and 422 ("diagnose / true-up / …"). `README.md` lines 19, 22, 25, 26, 28, 59, and 85.
- `plugins/ok/CLAUDE.md` (lines 7 and 11) and `plugins/ok/families/ok-planner/CLAUDE.md` (lines 11, 29, 44, 50, 58 "the true-up core's migration" and "markdown-intake", 68 "estate true-up is the front door's administration", 74).
- Templates and rules: `scripts/ok-planner-CLAUDE.md` lines 86, 120, 397, and 451 ("overwritten on every true-up"); `scripts/ok-planner-cheatsheet.md:146` ("when `/ok` overwrites it on every true-up"); `skills/_shared/artifact-definitions.md:187`; and `review/CLAUDE.md:5`.
- Skills: the sketch, document (lines 50, 66, and 402 "Does not true up an estate"), audit (34, 46, 69, 328), plan-sprint (36), `_tasks/drain.md` (45), and dashboard (16, "Run `/ok` to true up the project") skills; `discover-design/SKILL.md:494` ("for the naming question"); `ok-version/SKILL.md:14`; and `triage-issues/prompts/respond.md:40`.
- `plugins/ok-conduct/output-styles/ok-conduct.md:217`: "A project not yet trued up to that layout".
- `scripts/dashboard::version_notes`: "run /ok to true it up" (both). `browser/src/App.svelte` lines 145 and 150: "<code>/ok</code> to true it up." The `.converge` class and the `/converge` link stay.
- `.claude/skills/release/SKILL.md` lines 10, 133, 145, 234, and 236, as the work item quotes them.
- `.ok-planner/release-boundaries.md`: the heading reads `## Trued-up projects`, and "Where to look" reads "(the true-up core and the administration document)". No skill or check reads the heading by name (`rg 'Converged projects'` over plugins, docs, and README finds nothing).
- `plugins/ok/.claude-plugin/plugin.json` and `.claude-plugin/marketplace.json` (the `ok` entry): "install, true up, repair".

**Behavior changes**
- **B124** the text `/ok` and the suite's documents show the owner. Before: `/ok`'s outcome reads `converged` / `converged; audit findings pending: <n>`, and the docs and skills say converge. After: `trued up` / `trued up; audit findings pending: <n>`, and the docs say true-up. Users: in the release: the owner reading `/ok`'s report, since no program parses the outcome. Across Trued-up projects: vendored skills and rules change wording at the project's next true-up. Ruling: rewrite.
- **B125** `scripts/dashboard::version_notes` and the page source's notices. Before: "run /ok to converge it". After: "run /ok to true it up". Users: the person who started the service (stderr notes). The page shows its own source text, which reaches projects only after `/release` rebuilds `browser/dist/`. Ruling: rewrite.

### The web setup skills and the marketplace describe their own setup without the word converge

**Calls**
- `plugins/ok-web/.claude-plugin/plugin.json`'s description carries the same text as its marketplace entry, and changes with it. Decided by: DRY (one description in two manifests must agree), and the work item's closing `rg`, which covers `plugins/`.
- The descriptions keep their "ONLY activated by explicit /setup-… slash command. Never auto-triggered by conversation content." opening. Decided by: decision slash-only-activation.
- "repairs divergence from the contract" stays: it is not the word converge.

**Changes**
- `plugins/ok-web/CLAUDE.md` line 7: "carries web-project setup as idempotent one-pass setup skills". Line 14: "set up in every web frontend found in the project".
- `plugins/ok-web/skills/setup-web/SKILL.md`: the description reads "One-pass, idempotent setup of a web project's agent-facing browser tooling: …". Line 16 reads "The skill is an idempotent one-pass setup, not an installer wizard: …". Line 44 reads "The entry to bring the project in line with, …". Line 68 reads "report that the project is already set up."
- `plugins/ok-web/skills/setup-dom-picker/SKILL.md`: the description reads "One-pass, idempotent setup of the dev-only DOM picker … and brings the one-paragraph agent usage note in line in the project's rules." Line 10 reads "This skill sets up the picker in every web frontend …". Line 17 reads "Bring each frontend in line with this behavior, …". The heading at line 54 reads "### 2. Bring each frontend in line", and the heading at line 68 reads "### 3. Set up the agent usage note".
- `.claude-plugin/marketplace.json` and `plugins/ok-web/.claude-plugin/plugin.json`: "/setup-web sets up a project's agent-facing web tooling … and /setup-dom-picker sets up the dev-only DOM picker in the project's frontends". The `ok` entry is handled in the documents item.
- `README.md` lines 39–40: "`/setup-web` sets up the browser MCP server, and `/setup-dom-picker` sets up a dev-only DOM picker in the project's frontends". This file is shared with the documents item.

**Behavior changes**
- **B126** the ok-web skill and plugin descriptions. Before: they say "converge". After: they say "set up" / "bring in line". Users: across Installed plugins: a user's skill listing and marketplace view show the new text after an update. Plugin names and slash verbs, the only things that cross the boundary, are unchanged. Ruling: rewrite.

### True-up repoints a retired script reference behind a prefix it proves names the project root, and its report names what it cannot see

**Calls**
- The proven forms copy `ROOT_REFERENCES`' quoting variants for both idioms: `$(git rev-parse --show-toplevel)/`, `$(git rev-parse --show-toplevel)"/`, `$(git rev-parse --show-toplevel)\"/`, `` `git rev-parse --show-toplevel`/ ``, `` `git rev-parse --show-toplevel`"/ ``, and `` `git rev-parse --show-toplevel`\"/ ``. Decided by: the work item (the plain, double-quoted, and backtick forms), and plumbline-coding rule 2 (`ROOT_REFERENCES` gives `$CLAUDE_PROJECT_DIR` the closing-quote and escaped-quote variants).
- The proof runs once per process through `git_lines("rev-parse", "--show-toplevel")` and compares the real path of the stripped output with the real path of `root`. A non-zero git exit is no proof. A machine without git needs no separate catch: `script_plan`'s `git grep` already stops the core there. Decided by: plumbline-coding rules 6 (reuse `git_lines`) and 4.3 (catch only where the branch differs).
- The note after a retired copy's `removed:` line prints from `remove_files` itself. `remove_files` computes the retired-script paths from `retired_scripts()` before it removes anything, since a profile-named copy stops being listed once it is gone. One site then covers the plumbline and workspaces migrations and a `resolve` that deletes an `estate-edits` script copy. The text: `note: a caller that builds the path of <path> at run time is outside what true-up sees, and meets "not found" at its next run`. Decided by: decision retired-script-repoint-needs-a-proven-root ("true-up's report says so when it removes a retired copy"), and DRY.
- The ports group's retired `.ok-planner/bin/port-block` should join `retired_scripts()` and leave through `remove_files`, so its removal prints the same note. Decided by: the same decision.
- Diagnose needs no change of its own beyond the rename. A proven line lands in `scan["repoints"]` and prints `retired script caller: <file> names <script>; true-up repoints it`. Decided by: `script_plan`, which feeds diagnose.
- This item shares the core and ADMINISTRATION.md with items 1, 6, and 8 and the ports items, `docs/integration-contract.md` with the ports documents item (its repoint paragraph), and `plugins/ok/skills/ok/SKILL.md` with items 1 and 3. Chain after the core rename.

**Changes**
- `admin/true-up::GIT_TOP_REFERENCES`: new. The six forms above, beside `ROOT_REFERENCES`.
- `admin/true-up::git_top_is_root`: new, cached once per process. True when `git rev-parse --show-toplevel`, run against `root`, names `root` by real path.
- `admin/true-up::script_pattern`: changed. In the branch for a path outside the retired estates, it adds a `(?<=<ref>)` alternative for each `GIT_TOP_REFERENCES` form where `git_top_is_root()` holds. So `script_plan`, `repoint_callers`, `repointed_script`, and `stale_wording_lines` all treat a proven line as certain, and `unsure_reference` no longer counts it. Without the proof, nothing changes.
- `admin/true-up::remove_files`: changed. It prints the note line after the `removed:` line of each retired script copy it removes.
- `ADMINISTRATION.md` "Callers of retired suite scripts": the prefix paragraph names the proven git idiom and its proof (the project root is the repository's top), and says that without the proof the line stays unsure and gets an issue. The section's last sentence becomes the report line. `docs/integration-contract.md`'s repoint bullet names the proven prefix and the report line.
- `plugins/ok/skills/ok/SKILL.md` report template: after the retired-script `removed:` relay, add "<the core's `note:` line after it, verbatim>".

**Behavior changes**
- **B127** `admin/true-up::script_pattern`. Before: a line naming a profile-named retired script behind `$(git rev-parse --show-toplevel)/` (or a backtick or quoted form) was unsure. True-up filed an intake issue and kept the retired copy. After: where the project root is the repository's top, true-up repoints the line to the drop-in, or files a certain-caller issue for `src-tag` and the retired `port-block`, and removes the copy once nothing else names it. Elsewhere the line stays unsure, as today. Users: in the release: diagnose, the repoint, and the audit, all in this core. Across Trued-up projects: tracked project files carrying such lines (stored data), and issues an earlier true-up filed about them. Ruling: migrate: an issue already filed about such a line stays open as written, and `/triage-issues` answers it once the repoint lands; no line changes without the proof (call).
- **B128** `admin/true-up::remove_files`. Before: removing a retired script copy printed `removed: <path> …` alone. After: a `note:` line follows it. Users: `/ok`, which relays it (report template changed). Ruling: rewrite.

### True-up leaves discovery notes as written and counts none as a caller

**Calls**
- The `record` entry for `.ok-planner/design/_discover/` goes in a separate `("record", (".ok-planner/design/_discover/",))` entry placed first in `OWNER_PATHS`. `left_alone` keeps its first-match rule. Decided by: the work item ("ahead of the corpus class's prefix, since `left_alone` takes the first class that matches").
- Caller issues an earlier true-up filed about a note stay in the intake. Once the copy goes they show a harm the project no longer has, and `/triage-issues` answers them. Decided by: the cheatsheet's `answered` route; the intake is records, never rewritten by true-up.
- This item shares `scripts/review` with the certification item (`cmd_drives`), the variants item (`confirm_briefs`), and the stamps item. It shares ADMINISTRATION.md widely. Chain.

**Changes**
- `plugins/ok/families/ok-planner/scripts/review::OWNER_PATHS`: changed. Its first entry classes `.ok-planner/design/_discover/` as `record`. `review owner .ok-planner/design/_discover/<note>.md` prints `record`, and `review owner .ok-planner/design/concepts/<slug>.md` still prints `corpus`. `.ok-planner/history/discover/` stays `record` through `.ok-planner/history/`.
- `admin/true-up::caller_kind`: unchanged code. Through `carried_review().left_alone` it now returns `None` for every note, so `script_plan` neither rewrites, files about, nor holds a script for a note.
- `ADMINISTRATION.md` "Callers of retired suite scripts", the skip bullet: the record list adds "the discovery notes, in the design corpus's scaffold (`design/_discover/`) or in the archive (`history/discover/`)".

**Behavior changes**
- **B129** `scripts/review::left_alone` for a path under `.ok-planner/design/_discover/`. Before: `corpus`, so `/converge` sent a defect there to the intake as a judgment issue. After: `record`, so the run leaves the note alone and files nothing about it, and `scoped_files` and `changed` skip it as before. Users: in the release: `/converge`'s merge, backlog, and file population, and the core's `caller_kind`. Across Trued-up projects: a project's vendored `.ok-planner/bin/review` changes at its next true-up. Ruling: rewrite.
- **B130** `admin/true-up::script_plan` over a note. Before: true-up rewrote a retired-script path in a note, filed an issue for an unsure or no-drop-in line, and kept the retired copy while a note named it. After: it does none of these, and it removes the copy once no tracked file other than a record names it. Users: across Trued-up projects: notes that name a retired script (stored data). Ruling: migrate: a note an earlier true-up rewrote stays as it stands, and an issue already filed about a note stays open for `/triage-issues` to answer (call).

### /discover-design offers once to archive its notes after it fills the catalogs

**Calls**
- The work item asks for an `@decision: discovery-notes-archived-on-consent` annotation, and the skill cannot carry it: `checks/materialized-standalone` refuses any corpus citation in the family's skill markdown, since a consumer's lint cannot resolve this repository's slug. Built as kicked back: the step carries no annotation, and the decision is realized in the skill text alone. The same check binds every payload file, so it also binds the ports group's `@decision:` lines planned for `scripts/ports` (payload scripts carry none today).
- Before it moves anything, the step checks every target under `.ok-planner/history/discover/`. Where any target already exists, it moves nothing and names the notes that collide. Decided by: A2 (a move must not overwrite an archived record) and A1 (no half-moved notes).
- A note is tracked when `git ls-files -- <path>` prints it. A tracked note moves with `git mv`, any other note with `mv`, and outside a repository every note moves with `mv`. `_discover/` is removed only when the moves leave it empty; otherwise the report names what remains. Decided by: the work item ("`git mv` for a tracked one", "removes the empty `_discover/`").
- The opening reads "The run asks the owner one question, at its end, and nothing earlier: whether to archive its discovery notes." "What this skill does NOT do" reads "Prompts no one before its end; the final report and the one archive question are the only things the user sees." Decided by: the work item, and the technical writing standard's "say it once".
- This item shares `scripts/ok-planner-CLAUDE.md` with the ports, names, certification, rename, and stamps items. Chain.

**Changes**
- `plugins/ok/families/ok-planner/skills/discover-design/SKILL.md`: new step 9, after the final report. Where phase 2 wrote at least one concept, story, or decision, the skill asks once whether to move the notes from `.ok-planner/design/_discover/` to `.ok-planner/history/discover/`. On yes it runs `mkdir -p .ok-planner/history/discover`, checks for collisions, moves each note, removes the emptied `_discover/`, and reports the count moved. On no, or with no answer, it moves nothing. The opening paragraph and "What this skill does NOT do" change as the call says. The "When to invoke" bullet on earlier scaffolding and step 3's abort message add: "before a full rebuild, restore the notes from `.ok-planner/history/discover/` to `.ok-planner/design/_discover/` to make phase 1 incremental."
- `plugins/ok/families/ok-planner/scripts/ok-planner-CLAUDE.md` "Project records": the `history/` folder list adds `discover/`, the discovery notes `/discover-design` archives.
- `skills/_shared/design-doc-compliance-reviewer.md`: unchanged.

**Improvements**
- **I62** `scripts/ok-planner-CLAUDE.md` "Project records" paragraph: the template tells every agent to read `design/` freely and names no record inside it. Agents therefore read notes left in place as live corpus, against the discovery-notes-archived-on-consent delta ("every reader treats them as records") and records-stay-out-of-context (A8, a live design commitment). Afterward: the same paragraph adds one sentence saying that the discovery notes `/discover-design` leaves at `design/_discover/`, until the owner archives them, are records too.

**Behavior changes**
- **B131** `skills/discover-design/SKILL.md`. Before: the run asked no question, and the notes stayed in `design/_discover/`. After: a run that wrote an artifact ends with one question, and on yes the notes move to `history/discover/`. The re-run guidance names the archive. Users: in the release: the owner running the vendored skill. Across Trued-up projects: notes from an earlier bootstrap stay where they are, and nothing moves them (the decision rejects a true-up offer). Ruling: rewrite.
- **B132** `scripts/ok-planner-CLAUDE.md` (I62 and the archive list). Before: the template names no discovery-notes record. After: agents read notes in place and in `history/discover/` as records. Users: each project's materialized `.ok-planner/CLAUDE.md`, rewritten at its next true-up. Ruling: rewrite.

### The audit's coverage and reading auditors count the folders the project declares

**Calls**
- A `[FOLDERS]` placeholder goes into the `reading`, `subjects`, and `judge` bodies. The orchestrator fills it at Determine step 2 with each `folders` entry of `.ok-planner/config.json` as written, relative to the project root, one per line, or `none` where the file or the key is absent. Decided by: the audit skill's rule that a brief holds only `refs:` and `surface:` and the prompt carries everything shared; decision project-declares-its-folders.
- The judge's "Start with the counts" re-derivation counts the same population. Otherwise a judge that overturns a subject rewrites `checked:` without the declared folders, and the outcome ("a member under a declared folder is counted in `checked:`") fails on that path. Decided by: the work item's outcome; the judge prompt ("rewrites them with your own").
- The story and assumption auditors stay as they are. They drive the public elements the extraction records, and the extractor already walks the declared folders.
- `skills/audit/SKILL.md` is shared with "The drive's stack roles remove a run's artifacts…" (the `ports cleanup` step) and the true-up rename item (lines 34, 46, 69, 328). Decided by: execution step 4.

**Changes**
- `plugins/ok/families/ok-planner/skills/_shared/implementation-auditor.md::{{IMPLEMENTATION-AUDITOR-PROMPT}} Method step 2`: changed. It enumerates each quantifier's population from the project root and from every folder `[FOLDERS]` names.
- `…/implementation-auditor.md::{{COVERAGE-AUDITOR-PROMPT}} Method step 1`: changed. It follows How to find them across the project root and every folder `[FOLDERS]` names. A member under a declared folder counts in `checked:`, and a violation there is escalated like any other.
- `…/implementation-auditor.md::{{AUDIT-JUDGE-PROMPT}} (Start with the counts)`: changed. It re-derives over the root and `[FOLDERS]`.
- `plugins/ok/families/ok-planner/skills/audit/SKILL.md::Determine, The run step 2`: changed. When it writes the `reading`, `subjects`, and `judge` bodies, it fills `[FOLDERS]` from `.ok-planner/config.json` `folders`.

**Behavior changes**
- **B99** The audit's reading, coverage, and judge enumeration.
  - Before: a population is enumerated without reaching the folders the project declares.
  - After: it counts members under the project root and every declared folder. Violations there are filed as `category: defect` issues.
  - Users in the release: the audit records under `.ok-planner/audits/`; the judge; `/document`, which builds from the audit's records.
  - Across Converged projects: the vendored `audit` skill and `_shared/implementation-auditor.md`, written together. Earlier audits are records that the next run rewrites whole.
  - Ruling: rewrite.

### True-up never rewrites or removes owner text git cannot recover

**Calls**
- One table and one predicate serve diagnose, the corpus strip, and the offers: `RETIRED_SECTIONS` (stories: `Falsifier`, `Proof`, `Acceptance`; decisions: `Proof`), and the existing `state_file_removable` (not a link, tracked, no uncommitted or staged-only change, no link above it). Decided by: plumbline-coding rule 6. Today the bash diagnose greps `^## Proof` while the strip uses its own regex, and stories get no diagnose finding at all.
- A story or decision file that is not removable gets a new offer kind, `retired-sections:<path>`, whose fix strips the sections, since `estate-edits` deletes. The falsifier concept reuses `estate-edits` through `estate_edits_offer(concept, None, None, "the retired falsifier concept")`, whose fix deletes it. Decided by: the work item ("an estate edit offer, the way the core already handles an uncommitted or symlinked retired state file").
- The new offer's state and Show come from the code `estate_edits_offer` uses, extracted into one helper both call: "carries uncommitted changes" with `git diff HEAD`, "sits behind a symbolic link", "is a symbolic link", and "is not tracked by git". `resolve` refuses an uncommitted or linked file through `refuse_unless_removable` (`touches: [path]`). It also refuses a file that is itself a link, which `symlinked` does not see, with the same message form. On the owner's yes it strips an untracked file, as an untracked state file's offer deletes it on yes. Decided by: plumbline-coding rule 2 (the sibling `estate-edits` shape), and the work item ("refuses it until the owner commits the changes or removes the link").
- A tracked, clean falsifier concept goes through `remove_files([concept], stop_for(concept))` (git rm, staged, with its `removed:` line). The `Retired story sections eliminated:` line drops its own `removed:` part. Decided by: the decision's "removes … only from a file git tracks with no uncommitted or staged-only change", and rule 2 (the state-file sibling removes with git rm).
- The strip removes each section from its `## ` heading through the line before the next `## ` heading or the end of the file. At each seam it collapses a run of three or more newlines to two. Every other byte stays. Decided by: the work item ("touches only the lines the strip removed").
- `strip_story_sections` and `strip_decision_proofs` keep their names, their order, and the `os.path.join(ok_dir, "design", …)` lines, so `checks/owned-paths`' regions and needles hold. The strip helper that `resolve` calls is defined inside those regions, so its `write_owner(path, …)` stays declared. `checks/owned-paths` gains `remove_files` key `"[concept], stop_for(concept)"` in `("falsifier-elimination",)` and drops the `os.remove` `"concept"` entry. Decided by: plumbline-coding rule 1.4 (remove what only the deleted call used).
- This item shares the core and ADMINISTRATION.md with items 1 and 5 and the ports items, and `checks/owned-paths` with item 1. Chain after the rename.

**Changes**
- `admin/true-up::RETIRED_SECTIONS`, `::stripped(text, names)`, and `::retired_section_files()`: new. The last lists each story or decision file whose strip changes its text, with its new text and the section names.
- `admin/true-up::strip_story_sections` and `::strip_decision_proofs`: changed. They strip only files where `state_file_removable(path)` holds, using `stripped`, and remove the falsifier concept with `remove_files` only where it is removable.
- `admin/true-up::estate_edits_offer`: changed. Its state and Show computation moves into a helper the new offer shares.
- `admin/true-up::offers`: changed. It adds one `retired-sections:<path>` offer per unremovable file from `retired_section_files()` (What: the path, the sections, its state; Show; Fix: "strip the retired <names> section(s) from <path>, heading and body, nothing else"; `touches: [path]`), and an `estate-edits` offer for an unremovable falsifier concept.
- `admin/true-up` resolve: new kind `retired-sections`. It refuses a linked file and otherwise strips that one file through the region's helper.
- `admin/true-up` diagnose (python): adds `retired layout: <path> — its retired <names> section(s); true-up strips them` for each removable file, and `retired layout: .ok-planner/design/concepts/falsifier.md — the retired falsifier concept; true-up removes it` where that file is removable. The bash grep at lines 3586–3588 is removed.
- `checks/owned-paths`: as the call says.
- `ADMINISTRATION.md`: the "Decision `## Proof` sections are stripped" bullet, and "Falsifier and story-proof elimination", which now names `## Acceptance`, the git condition, and the offer. The offers table gains a `retired-sections:<path>` row, and its `estate-edits` row adds the falsifier concept. The exceptions in "What the administration does NOT do" add "where git tracks the file unchanged and no symbolic link is involved".

**Improvements**
- **I61** `admin/true-up::retired_section_files`: today `read_owner` raises `UnicodeDecodeError` on a story or decision that is not UTF-8. True-up then stops with a traceback after materializing, before the TOC regeneration and the offers report, and stops the same way on every rerun (A3: the shipped operator script gives a crash that does not say what is wrong). Afterward: such a file is left as written and named on one line, `left: <path> does not decode as UTF-8, so true-up cannot strip its retired sections byte for byte`, the way `CALLER_LEFT["encoding"]` treats a caller.

**Behavior changes**
- **B133** `admin/true-up::strip_story_sections` and `::strip_decision_proofs`. Before: true-up stripped retired sections from every story and decision file, whatever its git state. After: only from files git tracks unchanged with no link in the path; every other file gets a `retired-sections` offer. Users: across Trued-up projects: owners' story and decision files (stored data). The core runs from the payload, so no older part acts on them. Ruling: rewrite.
- **B134** the falsifier concept removal. Before: `os.remove` of any `concepts/falsifier.md`. After: `git rm` (staged) where it is removable, and an `estate-edits` offer otherwise. Users: as B133. Ruling: rewrite.
- **B135** `admin/true-up::stripped`. Before: a stripped file had every run of three or more newlines collapsed, anywhere in it. After: only the run at each seam collapses. Users: as B133. Ruling: rewrite.
- **B136** diagnose. Before: one bash line for decision Proof sections, none for story sections, so diagnose could exit 0 while true-up would still change story files (A9). After: one line per file true-up strips or removes, and an offer block for each file it leaves. Exit 1 on findings and 3 when only offers remain, as for other kinds. Users: `/ok`. Ruling: rewrite.
- **B137** `resolve` gains the `retired-sections` kind. Before: no such id. After: `resolve retired-sections:<path>` strips that file on consent and refuses a file that is uncommitted or linked. Users: `/ok`, which runs consent commands as printed, and the ADMINISTRATION.md table. Ruling: rewrite.
- **B138** (I61) a story or decision file that is not UTF-8. Before: true-up stopped with a traceback. After: it leaves the file and prints a `left:` line. Users: `/ok`. Ruling: rewrite.

### The front door's project audit leaves a hook that calls a live estate script alone

**Calls**
- "A path the carried version materializes" means the destinations "The core's modes" lists, the executables under `.ok-planner/bin/`, `.ok-planner/scripts/`, `.ok-planner/hooks/`, and `.claude/hooks/` among them. The row points there rather than repeating the list. Decided by: the technical writing standard ("say it once"), and the work item ("such as an executable under `.ok-planner/bin/`").
- A retired entry that the `lint` group's command removes stays wiring drift, as today. Decided by: the row's current exception.
- This row shares ADMINISTRATION.md's audit table with the ports item (the `.ok-planner/config.json` row adds `port_range`) and the rename item (the outcome word). Chain.

**Changes**
- `ADMINISTRATION.md` "Audit the project against the carried version", the `.claude/settings.json` row: "an entry whose command names a path under `.ok-planner/`, `.claude/hooks/`, `.ok-plumbline/`, or `.ok-workspaces/` that the carried version does not materialize ("The core's modes" lists what it does) and the `lint` group's command does not remove". An entry calling a live estate script, such as `.ok-planner/bin/issues`, is no finding.

**Behavior changes**
- **B139** `/ok`'s project audit. Before: a hook entry calling a live script outside the wiring table, such as `.ok-planner/bin/<script>`, was a report-line finding, so the outcome read `… audit findings pending: <n>`. After: no finding, and the outcome reads `trued up` where nothing else is pending. Users: in the release: the owner reading `/ok`'s report. Ruling: rewrite.

### A running dashboard leaves a goal's check free to run

**Calls**
- The service needs no change. The skill redirects the service's stdout and stderr to a log file in a folder made with `mktemp -d` outside the project, and reads the `serving` line from that file. The service already prints every line with `flush=True`. The outcome changes the service only "where it must", so this item leaves `scripts/dashboard` alone. Decided by: the outcome, plumbline-coding rule 8.4 (do not widen).
- Start command, one foreground Bash call with no `run_in_background`: `d="$(mktemp -d)"; nohup python3 .ok-planner/bin/dashboard --open [--port <port>] > "$d/dashboard.log" 2>&1 < /dev/null & pid=$!; for i in $(seq 1 100); do grep -q '^dashboard: serving ' "$d/dashboard.log" && break; kill -0 "$pid" 2>/dev/null || break; sleep 0.1; done; echo "log: $d/dashboard.log"; cat "$d/dashboard.log"`. The redirection and `nohup` detach the service from the session's background tasks. The loop waits up to ten seconds for the line, or for the process to exit. Decided by: the outcome.
- The skill reports what it reports today. It adds that the service keeps running after the session ends until `kill <pid>`, because a detached process no longer ends with the session. Decided by: accept A9 (the report says what is so).
- Step 1's "already started" check also runs `kill -0 <pid>`. Where the process is gone, the skill starts a new one and does not report a dead address. Decided by: accept A9.
- Stop: `kill <pid>`, then `rm -rf` the log folder. Where `kill` reports no such process, the skill says the service had already exited, as today. Decided by: the outcome.
- The skill's "runs no command but the two below" becomes the start command, the reopen (`python3 -m webbrowser -t`), and the stop. Its description and opening say "as a process detached from the session". `plugins/ok/families/ok-planner/CLAUDE.md`'s `skills/dashboard/` layout line and `scripts/ok-planner-CLAUDE.md`'s dashboard paragraph ("starts it in the background of a session") say the same. Decided by: plumbline-coding rule 1.
- Shared files: `skills/dashboard/SKILL.md` (the true-up rename item: "Run `/ok` to true up the project"), `plugins/ok/families/ok-planner/CLAUDE.md`, and `scripts/ok-planner-CLAUDE.md`, as the text item's call lists. Decided by: the sprint's step 4.
- The build cannot show that a detached process frees `/goal`'s check. It needs a running Claude Code session with `/goal`. Sprint certification's skill review and drive judge it. Decided by: this planner runs nothing.

**Changes**
- `plugins/ok/families/ok-planner/skills/dashboard/SKILL.md`: frontmatter description, opening, step 1 (the liveness check), step 2 (the detached start and the log read), step 3 (adds that the service outlives the session), step 4 (kill, then remove the log folder).
- `plugins/ok/families/ok-planner/CLAUDE.md` (the `skills/dashboard/` line) and `plugins/ok/families/ok-planner/scripts/ok-planner-CLAUDE.md` (the dashboard paragraph): say the skill starts the service detached.

**Behavior changes**
- **B59** `skills/dashboard/SKILL.md` (`/dashboard`). Before: the service runs as the session's background task, holds a `/goal` check open while it runs, and its output is the task's output. After: the service runs detached, its output goes to a log file in a temp folder, a `/goal` check is free to run, and the service outlives the session until `kill <pid>`. Users: in the release: the owner in a session. Across Trued-up projects: the vendored skill, which true-up replaces whole. Ruling: rewrite.

### The sprint template's checklist step names when each entry moves

**Calls**
- The step's wording follows decision task-tools-mirror-the-report and the existing `ok-cheatsheet.md` "Executing a sprint" text. This stage applies that decision's delta (only "converges" becomes "trues up") and regenerates `decisions.md`.
- `sprint-document.md` is shared with items 1 and 5. Decided by: execution step 4.

**Changes**
- `plugins/ok/families/ok-planner/skills/plan-sprint/sprint-document.md::{{SPRINT-DOCUMENT-TEMPLATE}} step 6`: changed. Where the harness task tools are available, it names:
  - one entry per stage, created when the build tasks are filed;
  - an entry marked in progress when its build task is dispatched, and done when that task closes `done`;
  - one entry added for sprint certification when the drain ends.

  The run file stays the record, and the checklist is display.

**Behavior changes**
- **B100** `…/sprint-document.md::step 6`.
  - Before: new sprints name only the entries' creation and the certification entry.
  - After: new sprints name every moment.
  - Users in the release: every sprint written from now on, and its executing session.
  - Across Converged projects: live sprints keep the old step, which names no retired path (decision live-sprints-brought-current-on-true-up).
  - Ruling: preserve (call).


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
   available, mirror the stages as a live checklist, one entry per
   stage, created when the build tasks are filed, and add one entry
   for sprint certification when the drain ends. The run file is the
   record and the checklist is display.

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
    approval, confirmation, or progress checks. Stop only on a genuine
    blocker: a credential or access you cannot obtain, a step
    impossible in the current state, a destructive or irreversible
    action not clearly authorized, a task closed `blocked` twice, or
    sprint certification being unrunnable for you. Surface that and
    stop. Ambiguity is not a blocker: the builder makes the most
    plausible call and records it, or records a fork and builds the
    reading it judges best. Sprint certification reads both.

12. Code complete means every stage's latest build task closed
    `done`. Then run sprint certification, immediately after:
    `/converge sprint <this sprint's path>`. It judges the change
    from the commit in the `-base.txt` file to the working tree,
    once, against this sprint: every outcome and taken improvement
    works, a user gets what each story the sprint adds or amends
    promises when a driver uses the running product, every delta
    landed, every ruling holds, no unlisted behavior change breaks a
    user, and the project's checks pass. It fixes each defect in the
    sprint's scope and verifies each fix on its own diff. A defect
    outside the sprint's scope goes to the intake as a `category:
    defect` issue for the next `/converge`, and a question only the
    owner can decide goes to the intake for the next `/plan-sprint`.
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
   lists under `checks` pass on every file the change touched.
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
return is the owner's to take up, and does not hold the goal open.
Presenting the report, archiving, committing, and the
`closed:` stamp all follow completion; a pending archive-and-commit
offer is evidence the goal is met. `sprints/` and
`.ok-planner/history/sprints/` satisfy the rule alike, and a sprint
already archived with a `closed:` stamp is terminal. A missing
completion report, or one without the return block,
means not done. Nothing else counts either way.
