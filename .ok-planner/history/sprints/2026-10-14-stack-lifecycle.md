---
closed: 18c0bc841087496e38ec6ee87dda7476dac6bdd4
---

# Sprint: Stack lifecycle and the fourth intake drain

## Intent

This sprint drains the intake. It has no single theme. Its largest item replaces the run tag script, the port allocator, and each project's hand-wired lease and teardown steps with one stack tool that runs a verification run from start to end and records what the run makes, so the cleanup removes exactly that and never guesses from names. It also has sprint certification land a delta of its own sprint that execution missed, keeps closed issues out of the new-analysis inbox, lets /discover-design's back-edge sharpen every artifact kind, and fixes seven defects.

Promoted issues: ports-cleanup-suffixed-run-tags, ports-cleanup-stops-at-refused-removal, certification-cannot-land-its-own-delta, closed-issues-leave-the-unread-inbox, discover-design-back-edge-kinds, sprint-pass-diff-skips-declared-folders, sprint-contract-stuck-check-two-verdicts, surface-corpus-misses-cited-stories, audit-experiments-leave-provisioned-deployments, true-up-leaves-retired-sprint-boilerplate, ok-trues-up-from-superseded-payload, owner-question-test-one-owner-ruling.

## Corpus deltas

### New decision: stack-tool-runs-each-run

body: in the sidecar

### New decision: run-artifacts-recorded-by-the-stack-tool

body: in the sidecar

### Amend decision: run-artifacts-removed-with-the-run

body: in the sidecar

### Amend decision: per-run-artifact-tag

body: in the sidecar

### Amend decision: ports-leased-from-a-project-range

body: in the sidecar

### Amend concept: run-tag

body: in the sidecar

### Amend decision: final-form-deltas

body: in the sidecar

### Amend decision: runs-fix-what-the-project-owns

body: in the sidecar

### Amend concept: corpus-delta

body: in the sidecar

### Amend decision: sprint-goal-read-from-the-repository

body: in the sidecar

### New decision: closed-issues-leave-new-analysis

body: in the sidecar

### Retire decision: closed-answers-count-as-new

### Amend decision: unread-issues-count-as-new

body: in the sidecar

### Amend story: see-new-analysis

body: in the sidecar

### Amend concept: issue

body: in the sidecar

### Amend decision: agent-revisions-reach-the-owner

body: in the sidecar

### Amend decision: drive-tries-each-story-as-a-user

body: in the sidecar

### Amend decision: stack-ports-checked-as-a-suite-rule

body: in the sidecar

### Amend decision: port-range-chosen-at-true-up

body: in the sidecar

### Amend decision: one-vendored-family

body: in the sidecar

### Amend decision: project-chooses-its-lint-checks

body: in the sidecar

## Work items

### One stack tool runs each verification run

- Issues: ports-cleanup-suffixed-run-tags, ports-cleanup-stops-at-refused-removal
- Makes true: decision:stack-tool-runs-each-run, decision:run-artifacts-recorded-by-the-stack-tool, decision:run-artifacts-removed-with-the-run, decision:per-run-artifact-tag, decision:ports-leased-from-a-project-range, decision:port-range-chosen-at-true-up, decision:one-vendored-family, story:verification-leaves-no-artifacts-behind, story:concurrent-stacks-without-port-collisions
- Outcome: the family ships one stack tool, materialized as `.ok-planner/bin/stack`, in place of `scripts/ports` and `scripts/run-tag`. Its verbs:
  - `stack up [-- <command>]` mints the run tag, leases one port per declared name from `port_range` (nothing where the project declares no port names), makes the run's folder, writes one registry entry for the run under one lock, and runs, in a new process group, the start command `.ok-planner/config.json` declares, or the command named after `--` in its place. The start command's environment holds the tag (under the variable the project declares for it), one variable per leased port, the run's docker label (`ok.run-tag=<tag>`), the compose project name the tag names, and the run folder's path. `up` prints the tag and the `NAME=<port>` lines on stdout, On a failed start it takes the run down. Where a leased port is then held by a program outside the run, the failure was a bind collision: `up` starts the run again with a fresh tag and a fresh batch, within a budget of three attempts. On any other failed start, or once the budget is spent, it exits non-zero with the start command's output.
  - `stack down <tag>` runs the declared stop command with the same environment where the run used the declared start command, stops every process left in the run's process group, removes every docker container, image, volume, and network carrying the run's label, deletes the run folder, releases the lease, and deletes the entry. It works on a run whose start only partly finished, and on a project that declares no stop command. Where docker refuses a removal, `down` attempts every other removal, keeps the entry with the refusal named, and exits non-zero.
  - `stack cleanup` takes down each entry in the project's own registry that is at least an hour old and that nothing still uses: no process left in its group, no running container carrying its label, no program holding its ports. It reads no other project's state and scans docker only by the labels its entries name. A refused removal leaves that entry and the cleanup goes on to the next one; it prints one line per run it took down and one per run it left, with the reason.
  - `stack list` prints the registry's runs, one per line.
  - `stack suggest-range` and `stack check-range` behave as `ports suggest-range` and `ports check-range` do today.
- Outcome: `.ok-planner/config.json` declares the stack: its start and stop commands and the tag variable's name, beside the `ports` names and `port_range` it holds today. A project with no stack declares so there, and `stack up` with no command refuses on it with a message that says the project has no stack; `stack up -- <command>` still opens a run. A project that declares neither a start command nor no stack has not configured its stack: `stack up` with no command refuses with a message naming the field to set.
- Outcome: true-up materializes `.ok-planner/bin/stack`, removes `.ok-planner/bin/ports` and `.ok-planner/bin/run-tag` as retired suite scripts, and repoints or files an issue for each caller of either, as its retired-script handling does today. Its range offer calls `stack suggest-range` and `stack check-range`. Diagnose reports a project whose estate still holds either retired script.

### The suite's rules teach the stack tool and its label rule

- Makes true: decision:stack-tool-runs-each-run, decision:run-artifacts-recorded-by-the-stack-tool, decision:stack-ports-checked-as-a-suite-rule, decision:project-chooses-its-lint-checks
- Outcome: rule 10 of the coding rules (`docs/plumbline-coding.md`) and the ok-planner cheatsheet's section on per-run artifacts and verification stacks teach one flow: a project declares its start and stop commands; every verification path that builds or starts anything runs `stack up` and `stack down`; the start command makes every container, image, volume, and network with the run's label, writes every other file under the run folder, and leaves no process outside its process group; a stack makes nothing else unless its stop command removes it. The port steps (a variable with a fallback per published port, a declared name, no fallback in the range) stay. Neither text names `run-tag`, `ports lease`, or `ports release` any longer.
- Outcome: the suite's lint gains a check, on by default and off only where `lint_checks` turns it off, that reports each compose service, each image a `build:` makes, and each named volume and network, the default network among them, that does not carry the run label from its environment variable. `stack down` removes each container's anonymous volumes with the container. A project lint that replaces the suite's lint checks the label rule too. Its rules text leaves the rules files when the check is off, as `compose-ports`'s does.
- Outcome: every suite document that names the retired scripts names the stack tool instead: the estate's `CLAUDE.md` template, the family's and the `ok` plugin's `CLAUDE.md`, and the administration document.

### Drives and audit experiments run their stacks through the stack tool

- Issues: audit-experiments-leave-provisioned-deployments
- Makes true: decision:stack-tool-runs-each-run, decision:run-artifacts-removed-with-the-run, decision:drive-tries-each-story-as-a-user, story:verification-leaves-no-artifacts-behind
- Outcome: `/converge`'s drive starts its stack with `stack up` and stops it with `stack down <tag>`, and runs `stack cleanup` after its drivers drain. The review facts template (`review/seed/project.md`) and this project's `.ok-planner/review/project.md` drop the `stack-start` and `stack-stop` roles: the drive reads the stack from `.ok-planner/config.json`. A project that declares no stack there runs its drivers with no stack to start, and a project that declares neither a start command nor no stack has its drive refuse with the reason, as an unfilled stack refuses today. A driver that starts a resource of its own, such as a second stack or a server, starts it with `stack up -- <the command>` and ends it with `stack down <tag>`.
- Outcome: this project's `.ok-planner/config.json` declares that it has no stack, and its review facts' dashboard drive serves the page it builds through `stack up -- <the service's command>` and ends with `stack down <tag>`, its scratch project and build folder under the run folder.
- Outcome: true-up's project audit finds a consumer project's `stack-start` and `stack-stop` lines, or its no-stack line, in `.ok-planner/review/project.md`, and drafts the matching stack declaration for `.ok-planner/config.json` as an `amend` draft `/ok` offers the owner. The draft drops each step the stack tool now runs: a `run-tag` call that mints the tag, a `port-block` read-back, and a `ports lease` or `ports release` step. It keeps the stop command's steps that remove the run's artifacts, since the project's compose files carry no run label until the owner adds it; the audit reports each compose file the label check flags.
- Outcome: every stack the audit starts for its experiments goes through the stack tool. The audit skill and its auditor prompt (`_shared/implementation-auditor.md`) start the deployment the experiments share with `stack up` and end it with `stack down <tag>` once the measurements drain, pass or fail. A reset takes the deployment down and starts it again the same way. An experiment that provisions a second deployment starts it with `stack up` and ends it with `stack down <tag>`. A deployment the run did not start, such as one the owner keeps running, is no run's stack, and the tool leaves it alone. The audit's cleanup step runs `stack cleanup`.

### Sprint certification lands a delta execution missed

- Issues: certification-cannot-land-its-own-delta
- Makes true: decision:final-form-deltas, decision:runs-fix-what-the-project-owns, concept:corpus-delta, story:certify-completion
- Outcome: in `/converge sprint`, an alignment finding that an approved delta of the certified sprint did not land (its artifact does not match the delta's body byte for byte, or a retired artifact still exists) becomes a defect in the fix loop, never a judgment item. Its fixer copies the delta's body into place verbatim, or deletes the retired file, and regenerates the collection's catalog TOC. Its verifier compares the artifact with the delta byte for byte. The ownership rule every merge, fix, and verify prompt carries names this one corpus write as allowed; every other corpus fix still goes to the intake. The ok-planner cheatsheet (`scripts/ok-planner-cheatsheet.md`) and the estate's `CLAUDE.md` template (`scripts/ok-planner-CLAUDE.md`), which say `/converge` and `/triage-issues` edit no corpus file, name sprint certification's landing of a missed delta as the one corpus write a review run makes.

### A stuck check holds no term of the contract open

- Issues: sprint-contract-stuck-check-two-verdicts
- Makes true: decision:sprint-goal-read-from-the-repository, story:certify-completion
- Outcome: the sprint template's completion contract (`plan-sprint/sprint-document.md`) has item 2 and the goal rule give one verdict: a check failure certification lists as stuck is the owner's to take up and holds neither item 2 nor the goal open.

### Closed issues leave the new-analysis inbox

- Issues: closed-issues-leave-the-unread-inbox
- Makes true: decision:closed-issues-leave-new-analysis, decision:unread-issues-count-as-new, decision:agent-revisions-reach-the-owner, story:see-new-analysis
- Outcome: `issues list --unread` lists open issues alone, and a closed record's views count nothing unread and mark nothing new. The dashboard's unread tab and its counts show open issues alone; the closed list still shows each closed issue's last answers. No code cites `decision:closed-answers-count-as-new`.

### /discover-design's back-edge serves every artifact kind

- Issues: discover-design-back-edge-kinds
- Makes true: story:bootstrap-design-corpus
- Outcome: /discover-design's phase 2 reviewer may request a second read for a thin concept, story, or decision. Its inclusion test covers all three kinds, each request names the artifact's kind and slug, and its promotion field reads `Promote new artifact: <kind:name | none>`, matching what the focused extractor already expects. The back-edge still runs at most once per invocation.

### The issue walk's corpus script prints cited stories

- Issues: surface-corpus-misses-cited-stories
- Outcome: `scripts/surface-corpus` resolves every kind its `artifacts` loop meets to the folder `gather` reads (`stories` for a story), so a cited story prints.

### A reissued sprint pass reads the diff of a file in a declared folder

- Issues: sprint-pass-diff-skips-declared-folders
- Outcome: `converge/prompts/sprint-pass.md` reads each file's diff the way its sibling `sprint-review.md` does, without `--relative`, so a file under a declared folder or a path outside the project root shows its change.

### True-up brings every retired line of a live sprint's boilerplate current

- Issues: true-up-leaves-retired-sprint-boilerplate
- Makes true: decision:live-sprints-brought-current-on-true-up
- Outcome: true-up brings current, line for line, every line of a live sprint's "How to execute this sprint" and "Completion contract" sections that an earlier release's template laid out and the carried template no longer holds, whatever release laid it out, so the sprint names no removed verb or file. It leaves every other line and section as written. Diagnose reports a live sprint whose boilerplate still names a retired verb or file, and agrees only once none does.

### /ok trues the project up from the payload it just installed

- Issues: ok-trues-up-from-superseded-payload
- Makes true: story:true-up-project-estate
- Outcome: when `/ok`'s step 1 updates the ok plugin, every later step resolves the payload from the newly installed version's folder, so one `/ok` brings the project to the current suite version.

### The owner question test counts any person's ruling

- Issues: owner-question-test-one-owner-ruling
- Makes true: decision:anyone-may-rule
- Outcome: test 3 of the owner question test (`_sprint/shared.md`) reads "a person's ruling", as its siblings do.

## Implementation notes

Planned against commit `cbb59f7294f61fe11bbadffacff44cfebb3e9f0d`.

### One stack tool runs each verification run

**Calls**
- The released users across Trued-up projects are v25.4.0's: `.ok-planner/bin/port-block` and `.ok-planner/bin/run-tag` callers, and the `stack-start`/`stack-stop` lines of `.ok-planner/review/project.md` built on them. `scripts/ports` never shipped (`git show v25.4.0:plugins/ok/families/ok-planner/scripts/ports` fails), so no released project holds `.ok-planner/bin/ports`, a `ports.json` lease, or a `ports lease` step. B1, B4, and B5 name those released users in place of `ports` callers. Every `true-up::NO_DROP_IN` fix text (`port-block`, `planner-port-block`, `src-tag`, and the new `planner-run-tag`) and the `held_for`/`what` texts of `port_range_offer` name the `stack` declaration in `.ok-planner/config.json` and `stack up`/`stack down`, never `ports` or `run-tag`. Whether `stack` reads a legacy `ports.json` at all is the builder's call, since no released state holds one. Decided by: the notes review; release-boundaries.md.
- `stack cleanup`, `stack list`, and `stack down` work on an absent or malformed `stack` declaration, since converge runs `stack cleanup` after every drive; only `stack up` needs the declaration. Decided by: the notes review; decision:run-artifacts-removed-with-the-run.
- `plumbline::CONFIG_KEY_DEFECTS` validators take `(value, repoRoot)`; the check that no `ports` name equals `tag_variable`, `OK_RUN_LABEL`, `OK_RUN_FOLDER`, or `COMPOSE_PROJECT_NAME` reads the whole config, so it is passed the config or sits in `configDefects`. Decided by: the notes review.
- `stack` resolves the registry through `tasks.project_root()`. The start environment drops `OK_PLANNER_PROJECT_ROOT`, so a scratch project under the run folder resolves to itself, and every driver and auditor runs `stack up` and `stack down` from the project root. Decided by: the notes review; decision:stack-tool-runs-each-run.
- The process-group mechanism holds on macOS: a run in this session started a holder with `os.setpgid(0, 0)`, ran `sh -c 'sleep 30 & …'` with `os.setpgid(0, holder_pid)`, saw the background process listed in the holder's group by `ps -A -o pid=,pgid=`, and saw `os.killpg` leave the group empty once the holder was reaped. `ps -o args= -p <holder>` printed the holder's `ok-stack-hold <tag>` arguments. Decided by: that run. Linux is unchecked; certification's drive meets it where the drive runs on Linux.
- `admin/true-up` is also edited by the closed-issues item (the `scripts/issues` annotation beside the `run-tag` and `ports` entries this item removes) and the live-sprint boilerplate item. Chain those stages with `--after`. Decided by: the sprint's step 4.
- The tool is one file, `scripts/stack`, materialized to `.ok-planner/bin/stack`. It is built from `scripts/ports` and absorbs `run-tag`. Sibling: `scripts/ports` (loads `issues`/`tasks` through `load_sibling`, `Refusal` → `stack: <msg>` exit 1, `except Exception` owner frame emitting one event, `transaction()` under one `fcntl` lock). The file runs past the ~500-line guideline. Decided by: true-up materializes and probes whole scripts, and the lease, the range verbs, and the block list share `ephemeral_start`/`block_list`/`held`.
- The block list stays at `.ok-planner/bin/ports-blocklist`, and the tool reads it beside itself. Decided by: no work item renames it, and keeping the path adds no retired file.
- The config shape is `"stack": {"start": "<sh command>", "stop": "<sh command>", "tag_variable": "<NAME>"}`, or `"stack": {"none": "<why>"}`. `tag_variable` is required beside `start` and optional beside `none`. `stop` is optional. Commands run through `sh -c` from the project root. Decided by: the outcome (start, stop, tag variable, a no-stack declaration). `none` carries the reason so the /ok audit can convert a `- No stack: <why>` line verbatim.
- Validation of `stack` is a new `stackDefects` in `scripts/plumbline::CONFIG_KEY_DEFECTS` (not in `LINT_CONFIG_KEYS`, so a bad `stack` never blocks the lint). It refuses: start and none together; an empty command; an unknown key; a `tag_variable` that is not a NAME; a port name equal to `tag_variable`, `OK_RUN_LABEL`, `OK_RUN_FOLDER`, or `COMPOSE_PROJECT_NAME`. The stack tool also refuses each defect it reads, naming `config-check`. Decided by: the sibling pair of `ports`/`port_range` checks in both `ports::declared_names` and `plumbline::portsDefects`. "One definition decides whether the config is well formed" in ADMINISTRATION.md.
- The start environment is `os.environ` plus:
  - `<tag_variable>=<tag>` where one is declared;
  - one `NAME=<port>` per leased port;
  - `OK_RUN_LABEL=ok.run-tag=<tag>`;
  - `COMPOSE_PROJECT_NAME=<tag>`;
  - `OK_RUN_FOLDER=<folder>`.

  Decided by: the outcome's list. The decision says the label comes "from its environment variable", in the singular.
- The run folder is `<tempfile.gettempdir()>/ok-planner-stack/<tag>/`, never inside the project. The entry records it. `down` deletes only a recorded folder whose basename is the tag and whose parent is named `ok-planner-stack`. Decided by: A2. true-up's `resolve_root`, `tasks.project_root`, and plumbline's `findProjectRoot` all walk up to the nearest estate, so a scratch project made inside `.ok-planner/.cache/` would resolve to the outer project, and true-up would rewrite it. Sibling: `review::instance_folders` uses `tempfile.gettempdir()`.
- The registry is `.ok-planner/.cache/stack.json` under `stack.lock`, opened through `tasks.cache_dir`. Its shape is `{"runs": {tag: {"at", "ports", "folder", "declared", "stop", "holder", "refused", "stopping"}}, "next": <cursor>}`. Decided by: the sibling `ports.json`/`ports.lock`. Recording `stop` at `up` means `down` runs the stop command the run started with (coding rule 3.3).
- Process group: `up` spawns a holder process, `sys.executable -c "<signal.pause()>" ok-stack-hold <tag>`, in a new process group of its own (`os.setpgid(0, 0)` in the child, never `start_new_session`). The start command joins that group with `os.setpgid(0, holder_pid)`. `down` and `cleanup` signal the group only after `ps -o args= -p <holder>` shows that tag. "No process left in its group" means a group member other than the holder, read from `ps -A -o pid=,pgid=`. Where the holder is gone but members carry the id, the entry is left with that reason. Decided by: A2, because a dead group's id can be reused. A separate session would make `setpgid` fail with EPERM.
- `up` waits for the start command to exit. The start command and the holder run with stdin from `/dev/null` and stdout and stderr to `<folder>/stack-start.log` (the holder to DEVNULL), `close_fds=True`. On success `up` prints the tag alone on line 1, then the `NAME=<port>` lines. On a failed start it prints nothing on stdout, writes the log and the failure on stderr, and exits 1. Decided by: `tasks::cmd_exec` runs commands with `capture_output=True`, so any background process that inherits a pipe would hang every exec task.
- Bind collision: after a failed start, `up` takes the run down first, then probes each leased port with `held()`. A port still held belongs to a program outside the run, and `up` retries with a fresh tag and batch, up to 3 attempts. It emits `STACK.START.RETRIED` (tag, attempt, port) on stderr for each retry after the first. Decided by: the outcome and the events standard.
- `up` writes the entry (lease included) in the same transaction as the lease, before it makes the folder or the holder, then records the holder pid. An exception or interrupt after the entry is written takes the run down and re-raises with bare `raise`. Decided by: coding rules 3.1 and 4.2.
- `down <tag>` claims the entry under the lock (`stopping: <pid>`). It refuses where a live pid holds the claim. Then it runs, attempting every step and recording each failure:
  1. the recorded stop command, where `declared` is set, with the rebuilt environment;
  2. SIGTERM to the group, a 10-second wait, then SIGKILL;
  3. where docker is on PATH: `docker ps -a -q --filter label=ok.run-tag=<tag>` → `docker rm -f -v`, then networks, volumes, and images (`image rm -f`) by the same filter, with absent objects ignored (`DOCKER_ABSENT`);
  4. `rmtree` of the folder.

  On full success it deletes the entry, which releases the lease. Otherwise it keeps the entry, with `refused` and the lease, and exits 1 naming each refusal. An unknown tag is refused with "stack list prints the runs". Decided by: the outcome and coding rule 4.2.
- `cleanup` claims each due entry under the lock and does its docker and process work outside the lock, then re-takes the lock to delete or record. This departs from `ports::cleanup`, which holds the lock throughout, so that `up` never waits on a cleanup's docker calls (A3 stall). Output is one `took down: <tag> (…)` or `left: <tag> — <reason>` line per entry. Exit is 1 only where a removal was refused, 0 otherwise. Decided by: the outcome and A9.
- `list` prints one line per run: tag, start time (UTC), `NAME=port` list or `no ports`, folder, and `refused: …` where present. With no runs it prints nothing.
- The legacy `.ok-planner/.cache/ports.json` is read-only to the tool. The ports of a lease there younger than an hour count as taken. Decided by: both shapes accepted at the stored-state boundary, while a kept retired `ports` copy may still lease.
- The retired planner scripts have no drop-in. Their callers get intake issues, with fix text naming the stack declaration in `.ok-planner/config.json` and `stack up`/`stack down`. `WS_DROP_INS["run-tag"]` becomes `None` with a `NO_DROP_IN["run-tag"]` text. Decided by: the outcome ("repoints or files an issue … as its retired-script handling does today"). `stack up` behaves as neither `run-tag` nor `ports lease`.
- Diagnose prints `retired payload present: <path> — true-up removes it` where removable. Where a filed caller issue holds the script, it prints a non-drift line, `retired script kept: <path> — named by intake issue(s) <ids>`. Decided by: ADMINISTRATION.md, "A filed issue is no longer drift".

**Changes**
- `plugins/ok/families/ok-planner/scripts/stack`: new. It holds the verbs `up [-- <cmd>]`, `down <tag>`, `cleanup`, `list`, `suggest-range`, and `check-range <first> <last>`, plus `--help` USAGE. `suggest_range`/`check_range`/`block_list`/`held`/`ephemeral_start`/`read_config`/`declared_range`/`transaction`/`docker_out` are carried over from `ports`. It adds `declared_stack(config)`, which returns `stack`/`none`/`unfilled` with a reason and is loaded by `review`. Leasing nothing is allowed where no port names are declared. The range is refused only where names are declared. Event kinds are `STACK.PORT.HELD`, `STACK.IPV6.ABSENT`, `STACK.START.RETRIED`, and `STACK.RUN.FAILED`. Annotations: `# @decision: stack-tool-runs-each-run`, `run-artifacts-recorded-by-the-stack-tool`, `run-artifacts-removed-with-the-run`, `per-run-artifact-tag`, `ports-leased-from-a-project-range`, `# @story: verification-leaves-no-artifacts-behind`, and `concurrent-stacks-without-port-collisions` at their sites.
- `plugins/ok/families/ok-planner/scripts/ports`, `scripts/run-tag`: removed.
- `plugins/ok/families/ok-planner/scripts/plumbline::CONFIG_KEY_DEFECTS`: changed. It adds `stack: stackDefects`.
- `plugins/ok/families/ok-planner/admin/true-up` (shared file):
  - `EXECUTABLE_FILES`: drops `run-tag` and `ports`, adds `("scripts/stack", ".ok-planner/bin/stack", None, ("--help",))`.
  - `ESTATE_FILES`: the block-list row's annotation is updated.
  - `ESTATE_LICENSE_PREAMBLE`: says "the stack tool's block list".
  - `PORTS_SRC`/`ports_command`/`PORTS_REFUSAL`/`ports_answer` → `STACK_SRC`/`stack_command`/`"stack: "`/`stack_answer`.
  - `port_range_offer`: uses `carried_module(STACK_SRC).PORT_NAME`, and its `what` text names `.ok-planner/bin/stack`.
  - `CONFIG_CHECK_KEYS`: adds `"stack"`.
  - `retired_scripts`, `port_block_plan` → `planner_scripts_plan`, `planner_port_block_issues`, `caller_issue`, `NO_DROP_IN`, `WS_DROP_INS`, `migrate_port_block` → `migrate_planner_scripts`, and the diagnose loop: cover `.ok-planner/bin/port-block`, `.ok-planner/bin/ports`, and `.ok-planner/bin/run-tag` (see I2).
  - The diagnose kept-script line is added.
- `checks/owned-paths::check_planner`: changed. The region names and pinned call sites follow the renames (`stack_command`, `[sys.executable, STACK_SRC] + args`, `migrate_planner_scripts`).
- `checks/materialized-standalone::PAYLOADS`: drops `ports` and `run-tag`, adds `("ok-planner/scripts/stack", ".py")`.
- `plugins/ok/families/ok-planner/admin/ADMINISTRATION.md` (shared with the other planner's true-up item). It changes the modes block, the `amend`/`check-range` text ("as `.ok-planner/bin/stack` reads it"), the executables list, the block list, the probe list (`stack --help`), **Ports** (`stack up` leases, nothing where no names, a range required only with names), "Declare the lint config" (keys incl. `stack`, which the stack tool reads, and the `stack` shape), and the `port-range` and `config` offer rows. "Callers of retired suite scripts" gains the two planner scripts, ids `planner-ports`/`planner-run-tag`; "Three have a drop-in" becomes two, the workspaces `run-tag` has none, and the diagnose lines change. The ok-workspaces section loses its "`run-tag` lives on" sentence. The `estate-edits` row names the three retired planner scripts. The "does NOT do" owned set says "the stack tool's block list".
- `plugins/ok/families/ok-planner/CLAUDE.md` layout rows; `plugins/ok/CLAUDE.md` ("support scripts (the lint, `catalog-toc`, and the stack tool `stack` …)"); `docs/integration-contract.md` (lines ~30, 241, 250, 311–313); `README.md` ("Per-run verification stacks" bullet); `plugins/ok-conduct/output-styles/ok-conduct.md` (`script:bin/stack` example): changed, naming the stack tool.
- `.ok-planner/review/project.md` (shared file), "Scripts for developers and operators": the `run-tag` and `ports` entries become one `plugins/ok/families/ok-planner/scripts/stack` entry with its verbs and inputs (`down <tag>`, a run tag `run-<12 hex>`, `-- <command>`, `check-range` bounds 1025–65535). The `true-up` entry is unchanged.

**Improvements**
- **I2** `plugins/ok/families/ok-planner/admin/true-up::retired_scripts`, `port_block_plan`, `planner_port_block_issues`, `caller_issue`. Maintenance cost: `planner-port-block` is special-cased by name in five sites, and adding two more retired planner scripts would triple them. Afterward: one table, `PLANNER_RETIRED = ((path, name, state text, keep note), …)`, drives `retired_scripts`, the removal plan, the issue's shown path and keep text, the `estate-edits` offer, and the diagnose lines.

**Behavior changes**
- **B1** `scripts/ports` → `.ok-planner/bin/ports`. Before: true-up materializes it with `lease`/`release`/`cleanup`/`suggest-range`/`check-range`. After: it is not materialized; a stamped copy is removed once no caller names it, or kept while a caller's intake issue names it. Users: in the release: true-up (`ports_answer`, `port_range_offer`), `converge/SKILL.md`, `audit/SKILL.md`, the seed `project.md`, and the docs, all changed here. Across trued-up projects: consumers' `stack-start`/`stack-stop` lines in `review/project.md`, CI and scripts calling `.ok-planner/bin/ports`. Ruling: migrate: true-up files a `retired-planner-ports-caller-*` issue per calling file and keeps the stamped copy while such an issue's caller names it, so old callers keep working (call).
- **B2** `scripts/run-tag` → `.ok-planner/bin/run-tag`. Before: materialized, it mints a tag. After: retired as in B1; only `stack up` mints. Users: in the release: converge steps 2 and 6. Across trued-up projects: consumer callers (`RUN_TAG=$(.ok-planner/bin/run-tag)`). Ruling: migrate: the same caller issue and kept copy as B1 (call).
- **B3** `admin/true-up::WS_DROP_INS["run-tag"]`. Before: a line naming `.ok-workspaces/bin/run-tag` is repointed to `.ok-planner/bin/run-tag`. After: it gets an intake issue, and the workspaces copy is kept while named. Users: across trued-up projects: projects still holding the workspaces estate. Ruling: migrate: the no-drop-in path files the issue and keeps the copy (call).
- **B4** cleanup (`ports cleanup` → `stack cleanup`). Before: it removes images, volumes, and networks of any dead run tag docker shows, matched by name or compose project. After: it touches only registry entries, by label. Users: in the release: converge step 4 and the audit cleanup. Across stored state: docker objects of runs made under the earlier release stay until removed by hand, or by a kept `ports` copy's own cleanup. Ruling: migrate: legacy `ports.json` leases are read as taken, and the name scan is not ported, since the approved `run-artifacts-removed-with-the-run` lists it as a rejected alternative (call).
- **B5** registry `.ok-planner/.cache/ports.json` → `stack.json`. Before: leases live in `ports.json`. After: runs live in `stack.json`, and `ports.json` is only read. Users: across stored state: an earlier release's live leases and a kept `ports` copy. Ruling: migrate: ports of a `ports.json` lease younger than an hour count as taken, and nothing writes the old file (call).
- **B6** `admin/true-up` diagnose and true-up output. Before: `missing:`/`stale:` lines for `bin/run-tag` and `bin/ports`. After: `missing: .ok-planner/bin/stack`, `retired payload present: .ok-planner/bin/{ports,run-tag} — true-up removes it`, `retired script caller: …`, and the non-drift `retired script kept: …`. Users: in the release: `/ok` (`plugins/ok/skills/ok/SKILL.md` relays the lines). Ruling: rewrite.
- **B7** `admin/true-up::stack_answer` (the port-range offer, `check-range` mode, and `amend`'s range refusal). Before: it runs `scripts/ports` and strips `ports: `. After: it runs `scripts/stack` and strips `stack: `; the printed answers are unchanged, and the offer text names `.ok-planner/bin/stack`. Users: in the release: `/ok`. Ruling: rewrite.
- **B8** `scripts/plumbline::configCheckCmd`. Before: a `stack` key is not checked. After: a malformed `stack` is a defect, so it gets a `config` offer and `amend` refuses it. Users: in the release: true-up and `/ok`. Across trued-up projects: a config that already holds a `stack` key of another shape. Ruling: migrate: the `config` offer lists the defect and drafts the repair for the owner's yes (call).

### The suite's rules teach the stack tool and its label rule

**Calls**
- The check is named `compose-labels`, with code `compose-labels`. Decided by: the sibling `compose-ports`, and `project-chooses-its-lint-checks` names "the compose label check".
- The label form the check accepts is a `labels` sequence item whose value references `OK_RUN_LABEL` (`${OK_RUN_LABEL}` or `$OK_RUN_LABEL`, with or without a `:-`/`-` fallback). The check reads:
  - each service's `labels`;
  - each `build:`'s `labels` (a scalar `build:` reports "write build in the long form with labels");
  - each top-level named volume and network that is not `external: true`;
  - the `default` network, reported on the first service that attaches to it (no `networks:` and no `network_mode:`, or `networks` listing `default`) unless top-level `networks.default` carries the label.

  Map-form labels cannot carry the variable and report. Decided by: the decision ("carries the run's label from its environment variable", in the singular). Pulled images are not the run's.
- Rule 10 is retitled "Run each verification run through the stack tool". Steps 1–3, the port steps, stay verbatim. Steps 4–8 become:
  - declare `stack` in `.ok-planner/config.json`;
  - every verification path that builds or starts anything runs `.ok-planner/bin/stack up` (or `up -- <command>`) and ends with `stack down <tag>`, pass or fail;
  - the start command labels every container, image, volume, and network with `${OK_RUN_LABEL}`, writes every other file under `$OK_RUN_FOLDER`, leaves no process outside its process group (no `setsid` or daemonizing), and makes nothing else unless the stop command removes it, with compose running as `COMPOSE_PROJECT_NAME`;
  - name the start and stop commands in the task note;
  - check steps 1–3 and the label step with the suite's lint, a project lint, or both, a project lint also checking the label rule.

  The old step 5 (re-lease on bind failure) leaves, because the tool retries. Decided by: the outcome.

**Changes**
- `plugins/ok/families/ok-planner/scripts/plumbline`: changed.
  - `LINT_CHECK_COMPOSE_LABELS`/`LINT_CHECK_NAMES` add `compose-labels`.
  - `CODE_COMPOSE_LABELS` and `checkComposeLabels(file)` are new, built on the shared service iterator (I1) plus top-level `volumes`/`networks` blocks.
  - `runLint` runs it where `config.checks.has('compose-labels')`.
  - `patternKey` gains `compose-labels:<rule>`.
- `plugins/ok/families/ok-planner/admin/true-up::LINT_CHECKS`: changed. It adds `"compose-labels"`, so the `lint-check` marker blocks render and the `lint rules:` notice lists it.
- `plugins/ok/families/ok-planner/docs/plumbline-coding.md` § 10: changed as the call says. The sentence naming the suite's check sits in a `<!-- lint-check: compose-labels -->` block beside the `compose-ports` one.
- `plugins/ok/families/ok-planner/docs/plumbline-cheatsheet.md`: changed. The Tooling list gets a `compose-labels` entry in its marker block. The config paragraph names `stack` ("its start and stop commands and the tag variable, or that the project has none") and "`port_range` the range `.ok-planner/bin/stack` leases them from".
- `plugins/ok/families/ok-planner/scripts/ok-planner-cheatsheet.md` (shared file): changed. The `config.json` bullet adds the stack declaration. The `bin/run-tag, bin/ports` bullet becomes `bin/stack`. "Per-run artifacts and verification stacks" is rewritten as one flow: declare start and stop; `stack up` mints the tag, leases, makes the folder, records the entry, and runs the start command with tag, ports, label, compose project, and folder in its environment; `stack down` removes by label, folder, and group, pass or fail; `stack cleanup` is run periodically; range ownership and refusals stay. It names no `run-tag`, `ports lease`, or `ports release`.
- `plugins/ok/families/ok-planner/scripts/ok-planner-CLAUDE.md` (shared file): changed. The config paragraph adds `stack`. "The lint and the hooks" says `bin/stack` runs each verification run. The `.cache/` paragraph says the stack registry is `stack.json` under its own lock, and to delete the cache only when `stack list` prints no run.
- `plugins/ok/families/ok-planner/admin/ADMINISTRATION.md` "Lint checks" list: adds `compose-labels`.

**Improvements**
- **I1** `plugins/ok/families/ok-planner/scripts/plumbline::composePortEntries`. Maintenance cost: the label check needs the same `services:` block walk, which would otherwise be built twice. Afterward: a `composeServiceBlocks(lines)` iterator yields each service's line span, and both `composePortEntries` and `checkComposeLabels` use it. Output is unchanged.

**Behavior changes**
- **B9** `docs/plumbline-coding.md` § 10, `plumbline-cheatsheet.md`, `ok-planner-cheatsheet.md`, `ok-planner-CLAUDE.md` (materialized rules and estate text). Before: they teach `run-tag`, `ports lease`, and `ports release` in project commands. After: they teach the declaration and `stack up`/`stack down`. Users: in the release: every vendored file. Across trued-up projects: consumers' agents read it after `/ok`; their old commands keep working per B1/B2. Ruling: rewrite.
- **B10** `scripts/plumbline::runLint`. Before: compose files are checked only for ports. After: each unlabeled service, build, named volume or network, or default network is a violation, on by default; the edit hook blocks it on changed lines, and the audit sweep and `/converge` checks report it. Users: in the release: the edit hook, `/converge` checks, and the audit sweep. Across trued-up projects: every consumer compose file. Ruling: migrate: on by default as the amended `stack-ports-checked-as-a-suite-rule` and `project-chooses-its-lint-checks` decisions say; the edit hook reports only an edit's changed lines of a tracked file, and `lint_checks: {"compose-labels": false}` turns it off (call).
- **B11** `scripts/plumbline::lintChecksDefects` and `true-up::LINT_CHECKS`. Before: `lint_checks` naming `compose-labels` is a defect. After: it is accepted and drops the label sentences from the rendered rules. Users: in the release: true-up's rendering and `config-check`. Ruling: rewrite.

### Drives and audit experiments run their stacks through the stack tool

**Calls**
- `review` loads `stack`, which loads its own copy of `issues`, so `declared_stack` raises only `stack.Refusal`, and `review::main` catches `stack.Refusal` alongside `issues.Refusal`. Decided by: the notes review; plumbline-coding rule 4.
- `review drive-stack` keeps its verb and its three words. It reads `.ok-planner/config.json` through the stack module (`stack = load_sibling("stack")`, `stack.declared_stack`). `review::main` adds `stack.Refusal` to its caught tuple. The `unfilled` reason names `stack.start` (with `stack.tag_variable`) or `stack.none` in `.ok-planner/config.json`. Decided by: coding rule 6 (one reader of the declaration). Sibling: `main` already catches `issues.Refusal`.
- The converge session takes the tag from line 1 of the output of the `stack up` exec task. A failed `up` has already taken its run down, so the session only reports it. `stack cleanup` runs after every drive and every confirm round, with or without a declared stack, because drivers open runs of their own. Decided by: the outcome ("runs `stack cleanup` after its drivers drain").
- Drivers start any resource or instance under `.ok-planner/bin/stack up -- <the facts' resource-start or instance-create command>`, keep the printed tag, and end with the facts' stop or destroy command, where one is given, then `stack down <tag>`. Converge step 4's `resource-stop`/`instance-destroy` exec tasks stay as the fallback for a driver that ended early. The one root write a driver's command may make is the stack registry under `.ok-planner/.cache/`, which git ignores. Decided by: the outcome. Drivers already write `.ok-planner/.cache/` and the run file through `tasks claim`/`close`, and the certified tree is git's.
- This project's dashboard drive uses the working tree's copy, `python3 plugins/ok/families/ok-planner/scripts/stack`, from the project root. Decided by: project.md's "a driver serves a page built from the working tree's source". This repo's materialized estate (v25.4.0) holds no `bin/stack` until the owner runs `/ok`.
- This project keeps its `- No stack: <why>` line in `.ok-planner/review/project.md` beside the new config declaration. Decided by: the trued-up projects boundary. This repo's materialized v25.4.0 `.ok-planner/bin/review` reads that line, so removing it would make this sprint's own certification drive print `unfilled` and be skipped. The work item drops only the `stack-start`/`stack-stop` roles, which this file does not hold.
- The audit names the current deployment's tag in a `stacks` pool (`tasks item add --pool stacks --key deployment --body <tag>`), never in a brief. An auditor that resets runs `stack down <tag>`, then `stack up`, and adds the new tag. Every measuring auditor reads the latest `deployment` item and reaches the ports through `stack list`. At the end the session runs `stack down` on every pool tag that `stack list` still shows, then `stack cleanup`. Where the config declares `none` or nothing, the audit starts no stack and measures what is running, saying so in the report. Decided by: the outcome (a reset starts again "the same way" with a fresh tag). The brief grammar ("nothing else goes in a brief") stays intact.
- The /ok project audit gets a new row: `## Drive commands` in `.ok-planner/review/project.md`, read against `stack` in `.ok-planner/config.json`.
  - Finding: a `stack-start`/`stack-stop` line or a `- No stack:` line while the config declares no `stack`.
  - Sorted as: an `amend` draft of `stack`. The draft sets `start`/`stop` from the lines, with every `run-tag` call, `port-block` read-back, and `ports lease`/`ports release` step dropped, every step that removes the run's artifacts kept, and `{tag}` replaced by `"$<tag_variable>"`. The draft sets `tag_variable` from the line's `VAR={tag}` hand-off; where a `stack-start` line hands the tag over by no `VAR={tag}`, such as `docker compose -p {tag} up`, it sets `tag_variable` to `RUN_TAG` and writes `{tag}` as `"$RUN_TAG"`. A no-stack line becomes `{"none": "<why>"}`.
  - The stale role lines become report lines once the config declares `stack`.

  Decided by: the outcome, and the audit's "Report line" class for owner files the suite never edits.

**Changes**
- `plugins/ok/families/ok-planner/scripts/review`: changed.
  - `NO_STACK_PATTERN` and `STACK_ROLES` removed; `DRIVE_ROLES` drops `stack-start`/`stack-stop`.
  - `drive_stack`: reads the config as the call says, and no longer reads `## Drive commands`.
  - `cmd_drive_command`: its stack-role refusal is removed.
  - `main`: per the call, plus I3.
- `plugins/ok/families/ok-planner/skills/converge/SKILL.md` (shared file): changed.
  - Step 2: `unfilled` names the config field; `stack`: file the exec task `.ok-planner/bin/stack up`, keep line 1 as the tag; failure: report and go on.
  - Step 3: as now, `--tag`.
  - Step 4: `.ok-planner/bin/stack down <tag>` where step 2 started one; then the instance and resource fallbacks; then always `.ok-planner/bin/stack cleanup`.
  - Step 6: the same with a fresh `stack up`.
  - Sprint step 4: as now.
  - Return `cleanup` field: "what each `stack cleanup` printed …".
- `plugins/ok/families/ok-planner/skills/converge/prompts/drive.md` (shared file): changed. Setup says the stack's ports and folder for the brief's tag come from `.ok-planner/bin/stack list`. The resource and instance paragraph changes per the call. The rules allow the registry write.
- `plugins/ok/families/ok-planner/review/seed/project.md`: changed. The roles list drops `stack-start`/`stack-stop`. The `{tag}` text becomes "the tag `stack up` printed for the drive's stack". The `- No stack:` paragraph is dropped, with a line saying the stack is declared in `.ok-planner/config.json`. "Running the product" says ports come from `stack list`. "Resources a driver starts" gives the command a driver runs under `stack up --`.
- `plugins/ok/families/ok-planner/admin/true-up::RETIRED_PROJECT_MD_SEED_DIGESTS` (shared file): adds the current seed's digest `56e7fb2b9446e0a14de6899a9a5cb7eeef020b1d279c2dfa5f3b21209652aaf1`. Sibling: each seed edit appends the prior digest.
- `.ok-planner/config.json`: adds `"stack": {"none": "<the No stack reason from project.md>"}`.
- `.ok-planner/review/project.md` (shared file): changed.
  - Dashboard drive steps 1–7 become: `python3 plugins/ok/families/ok-planner/scripts/stack up -- sh -c '<steps>'` from the root, where the steps run in `$OK_RUN_FOLDER`: `project/` (`git init`, true-up via the root's `admin/true-up`), `build/` (tar copy, `npm ci`, `npm run build`, copy and stamp the dist), `config-a/` (and `config-b/`) as `XDG_CONFIG_HOME`, and the dashboard started in the background from `project/`, so its serving line lands in `<folder>/stack-start.log`.
  - Names are set and the intake seeded under those folders; the driver drives; `stack down <tag>` ends it.
  - A failed `up` means the outcome is `blocked`.
  - "Running the product" names `.ok-planner/bin/stack`.
  - The `- No stack:` line is kept per the call.
- `plugins/ok/families/ok-planner/skills/audit/SKILL.md`: changed. Line 34 says "the stack tool at `.ok-planner/bin/stack`". The story stage gets a stack start before filing measurement tasks (where the config declares `start`) and the `stacks` pool. "Port cleanup" becomes "Stack cleanup": `stack down` per live pool tag, then `stack cleanup`, pass or fail. The report's `Cleanup:` line changes.
- `plugins/ok/families/ok-planner/skills/_shared/implementation-auditor.md` "Obtaining the deployment state": route 1 reads the current tag from the `stacks` pool and its ports from `stack list`; route 2 resets with `stack down <tag>`, then `stack up`, adding the new tag to the pool; route 3 provisions with `stack up` and ends with `stack down <tag>`. A deployment the run did not start is no run's stack and is left alone.
- `plugins/ok/families/ok-planner/admin/ADMINISTRATION.md` "Audit the project against the carried version": the new table row and the sorting text per the call.

**Improvements**
- **I3** `plugins/ok/families/ok-planner/scripts/review::main`. Accept-list entry: A8 via coding rule 4.4 (an owner frame with no catch-all), and A4. An unexpected exception ends in a bare traceback with no event. Afterward: `except Exception` emits one `REVIEW.RUN.FAILED` event with `type`, `message`, and `trace` on stderr and returns 1, mirroring `ports`'s `PORTS.RUN.FAILED` frame.

**Behavior changes**
- **B12** `scripts/review::drive_stack`. Before: it reads `stack-start` or `- No stack:` from `review/project.md`. After: it reads `stack` from `.ok-planner/config.json`, and an absent declaration prints `unfilled` with a reason naming the field. Users: in the release: converge steps 2, 4, and 6 and sprint step 4. Across trued-up projects: consumers whose review facts hold the old lines, and this repo, whose v25.4.0 materialized review still reads `- No stack:`. Ruling: migrate: `/ok`'s project audit drafts the config declaration from those lines for the owner's yes, and until then the drive refuses with the field named, as the outcome says. This repo keeps its `- No stack:` line, so its materialized tool still reads it (call).
- **B13** `scripts/review::cmd_drive_command`. Before: it accepts `--role stack-start|stack-stop`. After: argparse refuses those roles. Users: in the release: converge, changed here. Ruling: rewrite.
- **B14** `skills/converge/SKILL.md` drive and confirm. Before: the session mints with `run-tag`, starts and stops through the project's commands, and runs `ports cleanup` only where there is a stack. After: it runs `stack up`/`stack down` and always runs `stack cleanup`; the return's `cleanup` field changes. Users: in the release: the converge session and owner list. Ruling: rewrite.
- **B15** `skills/converge/prompts/drive.md`. Before: drivers start resources with `resource-start` alone. After: they start them under `stack up --` and end them with `stack down`, and read ports from `stack list`. Users: in the release: drive tasks. Ruling: rewrite.
- **B16** `review/seed/project.md` and `true-up::seeded_project_md`. Before: the seed carries the stack roles, and the prior seed text reads as a skeleton. After: new seed text; the prior seed's digest is retired, so a project still holding it keeps its `review-facts` offer. Users: in the release: true-up seeding. Across trued-up projects: unfilled skeletons. Ruling: preserve (call).
- **B17** `.ok-planner/review/project.md` dashboard drive and scripts list. Before: mktemp scratch, `kill <pid>`. After: run through the source `stack up --`/`stack down`, with folders under the run folder. Users: in the release: this project's drivers. Ruling: rewrite.
- **B18** `.ok-planner/config.json` `stack` key. Before: absent. After: `{"none": …}`. Users: in the release: the new `review`. Across trued-up projects: this repo's materialized v25.4.0 `plumbline` and `config-check`, which read only known keys and ignore it. Ruling: preserve (call).
- **B19** `skills/audit/SKILL.md` and `_shared/implementation-auditor.md`. Before: experiments drive the deployment already running, and the audit runs `ports cleanup`. After: where a start command is declared, the audit starts and ends its own run, resets through `stack down`/`up`, and runs `stack cleanup`. Users: in the release: the audit's auditors. Across trued-up projects: consumers' maintained experiments that reach a fixed address. Ruling: migrate: the auditor repairs such an experiment to reach the run's ports, as its repair step does for any stale instrument (call).
- **B20** the /ok project audit's `## Drive commands` row (`admin/ADMINISTRATION.md`). Before: `/ok` drafts nothing from a project's `stack-start`/`stack-stop` lines. After: it drafts a `stack` declaration for `.ok-planner/config.json` that drops the `run-tag`, `port-block`, and `ports` steps and keeps the stop command's removal steps. Users: across Trued-up projects: every consumer whose review facts hold those lines. Ruling: migrate: the draft reaches the project only on the owner's yes, and the kept removal steps keep the drive removing what it built until the compose files carry the label (call).

### Sprint certification lands a delta execution missed

**Calls**
- A C3 fix task's `--files` names every collection's catalog TOC, since `catalog-toc` regenerates all of them. Decided by: the notes review; `{{CORPUS-DELTA-FORM}}`.
- **No script change.** `review owner` keeps classing `.ok-planner/design/`, `subjects/`, `practices/` and their TOCs as `corpus`. The exception lives in the prompt rules, keyed on sprint class C3 in sprint mode. Decided by: the work item ("the ownership rule every merge, fix, and verify prompt carries names this one corpus write"); the C3 class already exists in `{{SPRINT-CATALOG}}`.
- **What a C3 report names.** The alignment pass's C3 report names in `files` the artifact path and its collection's catalog TOC (`.ok-planner/design/{concepts,stories,decisions}.md`, `.ok-planner/subjects.md`, `.ok-planner/practices.md`). It names the delta as `site`. Decided by: sprint-pass report step 3 ("every file the fix would touch"); `{{CORPUS-DELTA-FORM}}` (applying a delta includes the TOC).
- **How the fixer gets the body.** It reads the delta's body from the sprint, or from `<sprint-name>-deltas/<kind>s/<slug>.md` where the heading says `body: in the sidecar`. It copies the body with no edit, or deletes the file for a retirement (`git add <path>` stages the deletion). Then it runs `python3 .ok-planner/bin/catalog-toc` and stages the TOC. Decided by: final-form-deltas (amended).
- **Verifier comparison.** For an inline body the verifier compares the same way the C3 check already does. Then it requires `python3 .ok-planner/bin/catalog-toc --check` to exit 0. Decided by: the work item; `{{CORPUS-DELTA-FORM}}`.
- **A stuck C3 defect** (not expected for a verbatim copy) keeps the existing path: backout, then a judgment issue. Decided by: SKILL Loop 2 step 1, unchanged.
- **Snapshot, verify, and backout need no change.**
  - `review snapshot` already includes an open defect's files whatever their owner class (`round_paths`).
  - `before_blob` falls back to HEAD or `new`.
  - The backout prompt already restores left-alone files the run's fix changed.

  Decided by: `plugins/ok/families/ok-planner/scripts/review::round_paths`, `::before_blob`, `prompts/backout.md` Rules.
- **Two extra sentences are rewritten (rule 1):**
  - `triage-issues/SKILL.md`, `corpus` row: "no `/converge` agent edits the corpus" becomes "changes what the corpus commits to".
  - `plan-sprint/SKILL.md` §3 Reconcile: "the one place the corpus moves" becomes "the one place the corpus catches up with out-of-band work; sprint certification lands only its own sprint's approved deltas".

  Both now overstate the new rule. Decided by: final-form-deltas ("No review run changes what the corpus commits to").

**Changes**
- `plugins/ok/families/ok-planner/skills/_converge/coding-rules.md::{{FIX-LINE-RULE}}`: changed. The `corpus` bullet adds one exception. In sprint certification, a defect of class C3 lands the certified sprint's own delta: the fixer copies the delta's body verbatim into the artifact, or deletes the retired file, and regenerates that collection's catalog TOC. That copy and that TOC are the one corpus write a review run makes; every other corpus fix still goes to the intake as a judgment issue. It reaches merge, fix, verify, backout, sprint-review, and sprint-pass through `block_sources`.
- `plugins/ok/families/ok-planner/skills/converge/prompts/merge.md::The ownership test`: changed. A new first-matching bullet, placed before "A file is `corpus` or `declaration`": where [SPRINT PATH] names a sprint and the report's entry is C3, the corpus files are the artifact and its TOC. Merge the report with those files and entry C3, as the fix line rule allows. Section "A sprint's reports" step 3a gets the same carve-out.
- `plugins/ok/families/ok-planner/skills/converge/prompts/fix.md::Fix`, `::Rules`: changed. New paragraph on fixing a C3 defect (the copy, the TOC, staging). The Rules line "Edit no file the fix line rule above leaves alone" names the C3 write as the rule's one allowed corpus write.
- `plugins/ok/families/ok-planner/skills/converge/prompts/verify.md::Check each defect`: changed.
  - A new `fixed` check for C3: the artifact matches the delta's body byte for byte (or the retired file is gone), and `catalog-toc --check` exits 0.
  - The send-back line for a left-alone file excepts the C3 write.
- `plugins/ok/families/ok-planner/skills/converge/prompts/sprint-pass.md::The passes` (alignment row): changed. A delta that did not land is reported C3, with `files` set to the artifact and its TOC. The fix loop lands it; it is never a question.
- `plugins/ok/families/ok-planner/skills/converge/SKILL.md` (shared file), three sites, all changed:
  - `## Scope`, first paragraph: the corpus clause names the C3 landing.
  - `### In sprint mode` step 5: "even where ... a delta names the artifact: a fix in the corpus ... `judgment`" carves out C3, which merges.
  - `## What stays outside this skill`: "two exceptions" becomes three, adding sprint certification's landing of a missed delta.
- `plugins/ok/families/ok-planner/skills/_sprint/shared.md::{{SPRINT-CATALOG}}` (shared file): changed. A sentence under the classes: a C3 defect is fixed in the run by landing the delta.
- `plugins/ok/families/ok-planner/scripts/ok-planner-cheatsheet.md`, `## The content kinds` `design/` bullet (shared file): changed. "`/converge` and `/triage-issues` edit no corpus file" adds "except that sprint certification lands an approved delta of its own sprint that execution missed, the one corpus write a review run makes".
- `plugins/ok/families/ok-planner/scripts/ok-planner-CLAUDE.md`, `## Durable design docs` paragraph (shared file): changed, with the same sentence.
- `plugins/ok/families/ok-planner/skills/triage-issues/SKILL.md`, route table `corpus` row: changed (the call above).
- `plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md::3. Reconcile` intro: changed (the call above).
- `plugins/ok/families/ok-planner/skills/_shared/artifact-definitions.md::{{CORPUS-DELTA-FORM}}`, review bullet: changed. "checks the applied corpus against the deltas by file equality" adds "and lands each delta whose artifact does not match, by the same copy".

**Improvements**
- None.

**Behavior changes**
- **B100** `prompts/merge.md::The ownership test`, `SKILL.md` sprint step 5. Before: a C3 report is set `judgment`, and the owner list files a `design` issue. After: it merges as a defect and is fixed in the run. Users: in the release: owner-list.md (files nothing for it now), the return's `fixed` and `intake` sections, `/triage-issues` (receives no such issue). Across Trued-up projects: the vendored converge prompts and blocks are rewritten together by true-up; no stored layout changes. Ruling: rewrite.
- **B101** `coding-rules.md::{{FIX-LINE-RULE}}`, `fix.md`, `verify.md`. Before: no agent edits a corpus file; a verifier sends back any corpus edit. After: a C3 fixer writes the artifact and its TOC; a verifier accepts that write after the byte comparison. Users: in the release: all six prompts that carry the rule, and `review owner` (unchanged). Across Trued-up projects: a project's `review/config.json` `block_sources` names the vendored `coding-rules.md` by path, and the path is unchanged. Ruling: rewrite.
- **B102** Rules text (cheatsheet, CLAUDE template, triage SKILL row, plan-sprint Reconcile, `{{CORPUS-DELTA-FORM}}`). Before: "edit no corpus file", with no exception. After: names certification's landing of a missed delta. Users: every session that loads the materialized rules; true-up rewrites the materialized copies. Ruling: rewrite.

### A stuck check holds no term of the contract open

**Calls**
- **Wording.**
  - Item 2 reads: "The project builds, and the checks `.ok-planner/review/config.json` lists under `checks` pass on every file the change touched, or fail only where sprint certification's return lists the failure as a `stuck` defect."
  - The goal rule's stuck sentence reads: "A `stuck` defect listed in the return, a check that still fails among them, is the owner's to take up, and holds no term of the contract open."

  Decided by: sprint-goal-read-from-the-repository (amended Choice).
- **The template lines this replaces become retired boilerplate.** The work item "True-up brings every retired line…" brings live sprints current. Its history file must hold the v25.4.0 lines this change retires, and its check (`checks/sprint-boilerplate`, below) fails until it does. So this stage either lands before that one, or adds its retired lines to `admin/retired-boilerplate.json` itself. Decided by: live-sprints-brought-current-on-true-up.

**Changes**
- `plugins/ok/families/ok-planner/skills/plan-sprint/sprint-document.md::{{SPRINT-DOCUMENT-TEMPLATE}}` "Completion contract", item 2 and the goal rule (shared file): changed, as worded above.

**Improvements**
- None.

**Behavior changes**
- **B103** `sprint-document.md` Completion contract. Before: a check failure certification lists as `stuck` fails item 2, while the goal rule says a stuck defect does not hold the goal open: two verdicts. After: one verdict; the stuck check holds no term open. Users: in the release: every sprint `/plan-sprint` writes, and the `/goal` checker of each. Across Trued-up projects: live sprints carry the old item 2 and goal rule. Ruling: migrate: true-up's live-sprint rewrite (the true-up work item) replaces each old line with the carried line; archived sprints keep their text (call, by live-sprints-brought-current-on-true-up).

### Closed issues leave the new-analysis inbox

**Calls**
- **A closed record counts nothing.** In `view`, `counted = ledger is not None and not archived`. A closed view then has `unread` 0, `unopened` false, and no message marked `new`. Decided by: the work item; closed-issues-leave-new-analysis.
- **`issues read <id>` on a closed record still writes the ledger**, which is harmless. It now returns 0, so its printed count agrees with the views. Decided by: A9; the work item ("a closed record's views count nothing unread").
- **Annotations.**
  - `@decision: closed-issues-leave-new-analysis` goes at the materialization entry in `admin/true-up::EXECUTABLE_FILES` for `scripts/issues`, beside `unread-issues-count-as-new`. Materialized scripts carry no annotations.
  - In `browser/src/lib/api.js` it replaces the removed `closed-answers-count-as-new` line on `isUnread`.

  Decided by: the work item ("No code cites decision:closed-answers-count-as-new"); the existing annotation sites.
- **`browser/dist/` is not rebuilt.** `/release` builds it (project.md). The service change alone delivers the outcome with the old build: `/api/issues?unread=1` returns no closed views, so the old page's `filter(state==='closed')` merges nothing. Decided by: project.md "Drive commands" and `/release`.

**Changes**
- `plugins/ok/families/ok-planner/scripts/issues::view`: changed. It counts nothing unread and marks nothing new on an archived record.
- `plugins/ok/families/ok-planner/scripts/issues::select`: changed. The pool is `open_views` for every state but `closed`; it no longer adds closed views under `unread_only`.
- `plugins/ok/families/ok-planner/scripts/issues::mark_read`: changed. It returns 0 for an archived record.
- `plugins/ok/families/ok-planner/scripts/issues::build_parser` (`list --unread` help): changed. "...closed ones among them" becomes "open issues with agent messages you have not read, or that you have never read".
- `plugins/ok/families/ok-planner/browser/src/App.svelte::gather`: changed. It returns `(await issues()).issues` alone, and the `unread` import goes.
- `plugins/ok/families/ok-planner/browser/src/lib/api.js::unread`: removed, with its annotation. `isUnread` gains `@decision: closed-issues-leave-new-analysis`.
- `plugins/ok/families/ok-planner/admin/true-up::EXECUTABLE_FILES`, the `scripts/issues` entry (shared file): changed (annotation added).
- `plugins/ok/families/ok-planner/skills/_shared/artifact-definitions.md` (state paragraph): changed. "`issues list --unread` lists every issue, open or closed" becomes "every open issue"; "They mark each agent message ... `new`" becomes "on an open issue".
- `plugins/ok/families/ok-planner/scripts/ok-planner-cheatsheet.md::Discussing` (shared file): changed. "...stays unread to each person..." adds "on an open issue"; "an issue a person has never read" becomes "an open issue".
- `plugins/ok/families/ok-planner/scripts/ok-planner-CLAUDE.md`, discussion paragraph (shared file): changed, with the same wording.
- `.ok-planner/review/project.md`, the `scripts/issues` entry's `--unread` text (shared file): changed. It drops "closed ones among them".
- The delta-bearing stage regenerates `.ok-planner/design/decisions.md` and `.ok-planner/design/stories.md`.

**Improvements**
- **I100** `plugins/ok/families/ok-planner/scripts/issues::history` and its callers `issues::cmd_history` and `dashboard::_get` (`/api/closed`): maintenance cost. After `view` counts nothing on archived records, the `ledger` parameter does nothing. Yet both callers still resolve, and seed, the reader's ledger and print the no-name note. Afterward: `history(root)` takes no ledger, and neither caller resolves one.

**Behavior changes**
- **B104** `issues::view`, `issues::select`. Before: a closed record's views count unread messages, mark messages `new`, and set `unopened`; `list --unread` includes closed issues. After: closed views count and mark nothing; `list --unread` lists open issues alone. Users: in the release: `dashboard::_get` (`/api/issues?unread=1`, `/api/closed`, `/api/issue/<id>`), `browser/src/App.svelte::gather` and its tab counts, `views/IssueList.svelte` and `views/IssueDetail.svelte` (`isUnread`, `isNew` on closed records), `issues::summary_line` and `message_line`. Across stored state: the read ledgers under `.ok-planner/.cache/read/` keep their format and are still written. Ruling: rewrite.
- **B105** `issues::mark_read`. Before: on a closed record it returns the count of agent messages above the mark. After: it returns 0. Users: `issues::cmd_read`'s printed line, `dashboard::_post` `{"marked": n}` (the page ignores the value). Ruling: rewrite.
- **B106** `browser/src/App.svelte::gather`, `api.js::unread`. Before: the unread tab and the counts merge closed views from `/api/issues?unread=1`. After: open issues alone. Users: the page's tabs and counts. Ruling: rewrite.
- **B115** (I100) `issues::history`, `/api/closed`, `issues history`. Before: each call seeds the reader's ledger where none exists, and the CLI prints the no-name note. After: neither happens there; `/api/issues` and `show` still seed. Users: the dashboard page's closed tab (reads `issues` only). Ruling: rewrite.

### /discover-design's back-edge serves every artifact kind

**Calls**
- **Request heading.** The heading reads `### <kind>:<slug>`, matching the focused extractor, which already reads "the affected artifact kind and slug". Decided by: the work item.

**Changes**
- `plugins/ok/families/ok-planner/skills/discover-design/SKILL.md::Phase 2 — Extraction Reviewer Subagent Prompt` ("Thin discovery requests" and "Anti-padding"): changed.
  - The inclusion test names "the affected artifact(s) by kind and slug, existing or new" and "what the thin material prevents the artifact from saying".
  - The format becomes `### <kind:slug>`, `- Missing: <what the artifact cannot currently say>`, `- Promote new artifact: <kind:name | none>`.
  - Anti-padding reads "an artifact that is shallow ... what this artifact says".
- `plugins/ok/families/ok-planner/skills/discover-design/SKILL.md::Back-Edge — Focused Discoverer Subagent Prompt`: changed. "too thin to support a real concept", "the affected concept", and "whether a new concept may be promoted" become artifact wording, with the kind named.
- `SKILL.md` Process step 6 stays as it is: at most one back-edge per invocation.

**Improvements**
- None.

**Behavior changes**
- **B107** the Phase 2 reviewer's thin-request block. Before: concepts only, with `Promote new concept: <name | none>`. After: concept, story, or decision, with `Promote new artifact: <kind:name | none>`. Users: in the release: Process step 6a/6b (the orchestrator fills both back-edge prompts from the block), and the focused extractor (already expects this form). Ruling: rewrite.

### The issue walk's corpus script prints cited stories

**Calls**
- **One kind-to-folder table.** A module-level table `FOLDERS = (("concepts", "concept"), ("stories", "story"), ("decisions", "decision"))` (or its dict form) is read by both `gather` and the `artifacts` loop. `catalog-toc` holds a similar table, but surface-corpus does not import it: each materialized script stays standalone, and the script already loads only `bin/issues`. Decided by: plumbline-coding rule 6; `checks/materialized-standalone`.

**Changes**
- `plugins/ok/families/ok-planner/scripts/surface-corpus::gather`, `::main` (the `artifacts` loop): changed. Both resolve kind to folder from the one table, so `story:<slug>` resolves to `design/stories/<slug>.md` instead of `storys/`.

**Improvements**
- None.

**Behavior changes**
- **B108** `surface-corpus::main`. Before: a cited `story:` artifact never prints as cited (it may still print by rare tokens). After: it prints first, "cited in the issue's artifacts". Users: in the release: `triage-issues/prompts/triage.md` step 5, `prompts/respond.md` step 3, and the `plan-sprint/SKILL.md` issue walk. Ruling: rewrite.

### A reissued sprint pass reads the diff of a file in a declared folder

**Calls**
- **The diff matches the review root's.** `git diff [BASE] -- <path>`, run from the project root, exactly as `sprint-review.md` step 2 does. Decided by: the work item.

**Changes**
- `plugins/ok/families/ok-planner/skills/converge/prompts/sprint-pass.md::Your reading` (shared file): changed. `git diff --relative [BASE] -- <path>` becomes `git diff [BASE] -- <path>`.

**Improvements**
- **I102** `prompts/sprint-pass.md::Your reading` and `prompts/sprint-review.md::Read once`: maintenance cost. One reading list is written twice, and the reissue copy has drifted twice:
  - the `--relative` flag;
  - the users of each changed definition and the base versions (root steps 3–5), which it omits.

  Afterward: a block `{{SPRINT-REVIEW-READING}}` in `_sprint/shared.md`, already a `block_sources` entry, carries root steps 1–5. Both prompts transclude it; the root keeps its "write down that list" and scope sentence.

**Behavior changes**
- **B109** `sprint-pass.md`. Before: a reissued pass reading a file under a declared folder or `../` gets an empty diff. After: it reads the change. Users: the reissued pass agent and the reports it files. Ruling: rewrite.
- **B116** (I102) `sprint-pass.md`, `sprint-review.md`. Before: a reissued regression pass reads no users and no base versions. After: it reads what the root read. Users: the pass's reports, then the merge. Ruling: rewrite.

### True-up brings every retired line of a live sprint's boilerplate current

**Calls**
- `checks/sprint-boilerplate` refuses where the clone holds no `v*` tag, so `checks/run` names that cause in its failure. For the v8–v10 templates inside `plan-sprint/SKILL.md`, each section is bounded to the template's fence, so a `## Completion contract` heading elsewhere in that file feeds nothing into the retired set. Decided by: the notes review.
- This repository holds 79 `v*` tags, which the history file and `checks/sprint-boilerplate` read. Decided by: `git tag -l 'v*'` in this session.
- **Where the history lives.** The history of every released template goes in a new payload data file, `plugins/ok/families/ok-planner/admin/retired-boilerplate.json`. It is a sorted JSON array of every non-blank line that any `v*` tag's sprint template held in "## How to execute this sprint" or "## Completion contract" and the carried template does not hold. The template file moved across releases:
  - `plugins/ok-planner/skills/plan-sprint/SKILL.md`, from v8 to v10;
  - `families/ok-planner/skills/plan-sprint/SKILL.md`, from v11 to v14;
  - `_shared/sprint-document.md`, from v15 to v22;
  - `plan-sprint/sprint-document.md`, from v23 on.

  The file is not materialized; true-up reads it from `script_dir`. Decided by: the work item ("whatever release laid it out"); the payload is the only thing a consumer has.
- **A check enforces it.** A new `checks/sprint-boilerplate` derives that set from the tags and the working tree's template. It fails when the file differs from the set: a line missing, or a line the carried template holds. Where the repository holds no `v*` tag, it refuses with a message to fetch tags. Decided by: the cheatsheet "Every written constraint needs a check"; A9 (a check that passes on nothing says something false).
- **Section bounds.** A section runs from its heading to the next line starting `## `, a column-0 fence, or the end of the file. True-up reads the carried sections from the `{{SPRINT-DOCUMENT-TEMPLATE}}` fence of `skills_src/plan-sprint/sprint-document.md`. Only `live_sprints()` files that carry the heading are touched, so `-build.md` and `-completion.md` files are skipped. Decided by: the work item ("those two sections").
- **The mapping.** Line for line, via `difflib.SequenceMatcher(None, sprint_section, carried_section, autojunk=False)`:
  - Consecutive non-equal opcodes are grouped into one hunk.
  - A hunk whose sprint side holds a retired line is replaced by the hunk's carried side. The sprint's lines that no template laid out (in neither set) are kept: those before the first template line go before the carried lines, the rest after.
  - A hunk with no retired line stays as written, and so does a pure insert (carried lines with no sprint counterpart).

  Decided by: live-sprints-brought-current-on-true-up ("line for line, and leaves the rest of the sprint as written").
- **Diagnose and true-up report the same set.** Diagnose reports a live sprint while either section holds a retired line, which is exactly what true-up would change. After a true-up none remains, so diagnose agrees. Finding text: `retired layout: <sprint> — its boilerplate holds <n> line(s) an earlier release's template laid out; true-up brings them current`. Decided by: the work item ("agrees only once none does").
- **Build-prompt rewrites are kept.** The four 4-space `RETIRED_PATH_LINES` entries are build-prompt lines (`-build.md`), not sprint boilerplate. `rewritten_sprint` keeps them for `-build.md` files. Decided by: their source (`{{SPRINT-BUILD-PROMPT}}`).

**Changes**
- `plugins/ok/families/ok-planner/admin/retired-boilerplate.json`: new (the history file above).
- `plugins/ok/families/ok-planner/admin/true-up` (shared file), all inside the Python block:
  - new: a loader for the carried template's two sections and the retired set; a function `current_boilerplate(text) -> (text, n)` implementing the mapping.
  - changed `rewrite_live_sprints`: applies it, plus the build-prompt rewrites, and prints `Live sprint boilerplate brought current: <path> (<n> line(s) an earlier release's template laid out)`.
  - changed diagnose (the `live_sprints()` loop near the `retired layout:` findings): uses the same function.
- `checks/sprint-boilerplate`: new. `checks/run`: changed (adds it to the loop).
- `checks/owned-paths::regions` and `owner_paths`: changed. The `"in-flight contract"` region goes. The `"live sprints"` region's end marker follows the rewritten function, and the needle `folder = os.path.join(ok_dir, "sprints")` stays.
- `plugins/ok/families/ok-planner/admin/ADMINISTRATION.md` (shared file):
  - The "In-flight sprint contracts are brought current" bullet under "## The audit model changed shape" is removed.
  - "## The core's modes" gains one paragraph saying what true-up and diagnose do to live sprints.
  - Line 222 (plumbline step 5) narrows to the build prompt's lines.
  - The exceptions bullet near line 384 names the live-sprint boilerplate rewrite.
- `docs/integration-contract.md` (the plumbline-move bullet near line 234): changed. The live-sprint clause names every retired boilerplate line.
- `.ok-planner/review/project.md`, "Scripts for developers and operators" (shared file): changed. The checks line lists `checks/sprint-boilerplate`.

**Improvements**
- **I101** `admin/true-up::RETIRED_CONTRACT_ITEM`, `::retire_contract_item`, and the 3-space `RETIRED_PATH_LINES` plus `RETIRED_DRAIN_STEPS` entries of `::SPRINT_LINE_REWRITES`: maintenance cost. These are a second hand-kept mechanism for the same job. Every line they rewrite is in the tag-derived retired set, which I checked against the tags. Afterward: they are removed, along with the `corpus` mode's call to `retire_contract_item`; the history mechanism covers them; `SPRINT_LINE_REWRITES` keeps the four build-prompt lines alone.

**Behavior changes**
- **B110** `true-up::rewrite_live_sprints`. Before: it rewrites only the hand-listed lines (plumbline paths, the `execute-tasks` drain step, the retired audit contract item). After: it rewrites every retired line of both sections from any release, keeping owner-added lines. Users: Across Trued-up projects: every live sprint under `.ok-planner/sprints/` (stored state the owner keeps); archived sprints are untouched. Ruling: migrate: each retired line becomes the carried template's line in place, every other line stays, and `history/` stays as written (call, by live-sprints-brought-current-on-true-up).
- **B111** true-up diagnose. Before: drift only for the hand-listed lines. After: drift (exit 1) for any retired boilerplate line, with the new finding text. Users: in the release: `plugins/ok/skills/ok/SKILL.md` step 4.1 (reads 1 as drift, then true-up), and ADMINISTRATION's audit. Ruling: rewrite.
- **B112** true-up's printed lines. Before: `In-flight sprint contracts brought current: …` and `Live sprint boilerplate brought current: … repointed at the current paths`. After: one `Live sprint boilerplate brought current:` line per sprint, with the new count wording. Users: `/ok` relays the core's lines; ADMINISTRATION's bullet (removed). Ruling: rewrite.

### /ok trues the project up from the payload it just installed

**Calls**
- `claude plugin list --json` prints a JSON list, one object per installed plugin, with `id` (such as `ok@ok-plugins`), `scope`, and `installPath`. `/ok` reads the user-scoped `ok@ok-plugins` entry's `installPath`, and the `installed_plugins.json` fallback is not needed. Decided by: a run in this session.
- **Where the new path comes from.** After step 1's `claude plugin update ok@ok-plugins` reports a change, `/ok` reads the user-scoped `ok@ok-plugins` entry's install path from `claude plugin list --json`. Where that output carries no path, it reads `~/.claude/plugins/installed_plugins.json`'s `installPath`. `<payload>` becomes `<that path>/families/ok-planner` for steps 2–7. Where ok did not move, or `CLAUDE_PLUGIN_ROOT` is unset (the in-tree monorepo case), the resolution stays as written. The field name needs confirmation by a run (see the top). Decided by: the work item.
- **"carried" follows the resolved payload.** The report's "carried" column reads the resolved payload's manifest. `true-up` already stamps from `SUITE_MANIFEST` relative to itself, so no script change is needed. Decided by: `admin/true-up` (`SUITE_MANIFEST="${SCRIPT_DIR}/../../../.claude-plugin/plugin.json"`).

**Changes**
- `plugins/ok/skills/ok/SKILL.md::Resolving the payload` and `::1. Update the installed user-scoped plugins`: changed. Step 1 records the new install path when ok moved, and every later `<payload>` resolves from it.

**Improvements**
- None.

**Behavior changes**
- **B113** `/ok` steps 2–7. Before: after updating ok, `/ok` runs the superseded version's `true-up`, so the project is trued up one version behind. After: it runs the new version's. Users: in the release: the owner and the report's "carried" column. Across Installed plugins: a user whose installed ok predates this release runs the old skill text once; the fix takes effect from the next `/ok`. Ruling: rewrite.

### The owner question test counts any person's ruling

**Calls**
- **`{{BEHAVIOR-RULINGS}}` is left alone.** Its "a ruling the owner already gave" is the same class, but it lies outside this item's definition. I leave it for the next `/converge`. Decided by: plumbline-coding rule 8.4; this planner's scope rule.

**Changes**
- `plugins/ok/families/ok-planner/skills/_sprint/shared.md::{{OWNER-QUESTION-TEST}}` (shared file): changed. Test 3 reads "Two readings of a person's ruling".

**Improvements**
- None.

**Behavior changes**
- **B114** `{{OWNER-QUESTION-TEST}}`. Before: only the owner's ruling triggers test 3. After: any person's ruling does. Users: in the release: `plan-sprint/core.md` (both transclusions, and the line 390 judgment test), `plan-sprint/SKILL.md` line 173, and the code planner and notes review prompts. Ruling: rewrite.


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
