# Completion report: Stack helpers, and the fifth intake drain

Sprint: `.ok-planner/sprints/2026-10-15-stack-helpers.md`

## Stages

- t1 — rules-lint. work-item:The rules and the lint carry no stack mandate; work-item:The reuse rule prevents import cycles; decision:stack-advice-outside-the-rules; decision:project-chooses-its-lint-checks — done
- t2 — helpers. work-item:Ship the stack helpers; decision:per-run-artifact-tag; decision:ports-leased-from-a-project-range; decision:run-artifacts-found-by-run-tag; decision:one-vendored-family; story:concurrent-stacks-without-port-collisions; story:verification-leaves-no-artifacts-behind — done
- t3 — stack-rebuild. work-item:Rebuild the reference stack tool from the helpers; decision:reference-stack-runs-the-declared-stack; decision:run-artifacts-removed-with-the-run; decision:ports-leased-from-a-project-range; decision:run-artifacts-found-by-run-tag — done
- t4 — helpers-doc. work-item:A reference document for the helpers; decision:stack-helpers-serve-project-commands; decision:stack-advice-outside-the-rules — done
- t5 — ports-at-true-up. work-item:True-up brings a v26.0.0 project to the helper model; decision:port-range-chosen-at-true-up — done
- t6 — drive-commands. work-item:The process runs each project's own stack commands; decision:stack-helpers-serve-project-commands; decision:drive-tries-each-story-as-a-user — done
- t7 — instance-mark. work-item:A project can make its instance-story drives wait; decision:instance-drives-serial-on-a-project-mark — done
- t8 — stack-lines-migration. work-item:True-up brings a v26.0.0 project to the helper model; story:true-up-project-estate; decision:stack-helpers-serve-project-commands; decision:reference-stack-runs-the-declared-stack — done
- t9 — payload-copy. work-item:True-up proves a payload copy before it skips a file; decision:retired-script-repoint-needs-a-proven-root; story:true-up-project-estate — done
- t10 — citations. work-item:Every citation names a live decision; decision:stack-helpers-serve-project-commands; decision:run-artifacts-found-by-run-tag; concept:run-tag — done

## Divergences

i1 (call, planning, open) — staging: B44 (run-tag and ports leave PLANNER_RETIRED, NO_DROP_IN, WS_DROP_INS, with the retired_scripts citation) lands in the helpers stage, not the true-up stage, because the helpers stage makes true-up materialize run-tag and ports, and the tree must not retire what it materializes

i2 (call, planning, open) — staging: decision stack-helpers-serve-project-commands is applied in the stack-rebuild stage, before the drive-commands stage that realizes it, because the stack tool's EXECUTABLE_FILES entry cites it there and the lint's citation check must pass between stages

i3 (call, planning, open) — staging: the planner cheatsheet's one-line pointer to .ok-planner/docs/stack-helpers.md lands in the helpers-doc stage, with the document, not in the rules stage

i4 (call, rules-lint, open) — scripts/ok-planner-CLAUDE.md's .cache paragraph names ports.json, run-groups.json, bin/ports list, and bin/run-group as the notes say, though the helpers stage (t2) ships bin/ports and bin/run-group; no other stage owns that file, so the end-state text lands here

i5 (call, rules-lint, open) — admin/ADMINISTRATION.md rows 92 and 123 (port-range offer and its draft) still name the compose trigger and its variables; the code trigger left in this stage (published_ports removed, port_range_offer triggers on declared ports alone), and the brief assigns those rows and the offer's texts ('publishes', 'stack up leases') to the ports-at-true-up stage (t5)

i6 (call, rules-lint, open) — admin/ADMINISTRATION.md report-line bullet: removed only the compose-labels clause; kept 'or a compose file' in the list of files the suite never edits, which stays true; the same sentence's stack-start clause is the stack-lines-migration stage's (t8)

i7 (call, rules-lint, open) — docs/plumbline-coding.md rule 6 step 2 wording: appended 'Also check that the import closes no cycle. Where reuse would close one, break the cycle so every import points one way, in the shape the project's own organization calls for. An import placed inside a function to dodge a circular-import error is a defect; fix it by breaking the cycle. Check for cycles with a tool for the project's language.' to the existing step; the Prevents line adds 'an import cycle that reuse closes'

i8 (noticed, rules-lint, noticed) — checks/oscillation:2-17,49-50,104-105: 18 prose comments the comment-hygiene check flags (old and new lint alike, unchanged since v14.0.0); 'node plumbline checks' exits 2 on them

i9 (call, helpers, open) — scripts/tasks gains RUN_TAG (the run-<12 hex> form) beside event; scripts/ports, scripts/docker-sweep, scripts/run-group, and scripts/stack each match tags through tasks.RUN_TAG, so the form has one Python definition beside run-tag's shell one

i10 (call, helpers, open) — read_config, CONFIG_REL, and CONFIG_CHECK moved into scripts/ports with declared_names (ports reads the configuration itself); scripts/stack uses ports.read_config, ports.CONFIG_REL, ports.CONFIG_CHECK, and ports.leasable_range, so the stack-rebuild notes' 'Kept: read_config, CONFIG_CHECK' builds on ports' copies; scripts/review::drive_stack reads stack.ports.read_config and its owner frame also catches stack.ports.Refusal, so a malformed ports key still prints 'review: <reason>' and exits 1

i11 (call, helpers, open) — scripts/stack loads its helpers through the existing idiom: ports = load_sibling('ports'), issues = ports.issues, tasks = issues.tasks, sweep = ports.sweep, group = load_sibling('run-group'); the stack owner frame catches (Refusal, ports.Refusal), the only helper refusal stack's calls can raise in this stage

i12 (call, helpers, open) — scripts/stack::legacy_taken now reads the live port registry through ports.leases(root) and counts every lease as taken, not only leases younger than an hour, since ports.json is now the live registry (B16); the stack-rebuild stage removes legacy_taken

i13 (call, helpers, open) — the move already routes stack through the helpers' behavior: down and cleanup sweep by label or compose project (B38, preserve), stack's lease and held_port check UDP as well as TCP (part of B36, preserve), and the moved code's event kinds are PORTS.PORT.HELD, PORTS.IPV6.ABSENT, SWEEP.DOCKER.UNREACHED, SWEEP.REMOVAL.REFUSED, GROUP.MEMBERS.GONE (B41, rewrite); stack still mints its tag with os.urandom and keeps its own stack.json lease and holder until the stack-rebuild stage

i14 (call, helpers, open) — ports lease with no declared port names exits 0 and prints nothing, recording no lease (the decision's 'A project that declares no port names leases nothing'), where the unreleased v25.4 bin/ports refused; lease skips the docker published-port check with a PORTS.DOCKER.UNCHECKED event where docker is not on PATH or does not list

i15 (call, helpers, open) — docker-sweep checks the daemon before sweep and running and exits 3 before removing anything where docker is absent or silent; probe prints 'docker: the daemon answers'; sweep prints 'swept: <tag> (<counts>)', and each refusal goes to stderr with exit 1; the published-ports reader is docker-sweep::published_ports (docker ps -aq, then docker inspect .HostConfig.PortBindings, ranges expanded); checked against docker 29.6.2 with compose v5.3.1 that a compose-built image carries com.docker.compose.project=<tag>

i16 (call, helpers, open) — run-group stop drops the record only when the group stopped, keeping it with exit 1 where pids outlive SIGKILL or the holder is gone with pids left; run-group start refuses where the recorded holder is gone but pids still carry its group id, naming run-group stop; start checks the program is on PATH or executable before it spawns a holder; a command killed by a signal exits 128+signal

i17 (call, helpers, open) — run-group keeps v26.0.0's holder mark ok-stack-hold, so holder_is_ours still recognizes the holder a v26.0.0 stack.json entry records

i18 (call, helpers, open) — admin/true-up EXECUTABLE_FILES lists run-tag, docker-sweep, ports, run-group after dashboard and before stack, so each --help probe finds the siblings its script loads already written

i19 (call, helpers, open) — admin/ADMINISTRATION.md: beyond lines 31, 32, 38 and the retired-script paragraphs, the owned-set bullet (near line 387) now says 'the port registry's block list', and 'settles the three retired .ok-planner/bin/ scripts' became 'settles the retired .ok-planner/bin/port-block'; lines 16, 21, 23 ('as the stack tool checks it') are left for the ports-at-true-up stage

i20 (call, helpers, open) — admin/true-up STACK_RUN now gives the helper path (run-tag, ports lease <tag>, ports release <tag>) and then the reference stack tool (declare stack by hand, a bare stack up, stack down <tag>) as the option for a project with no tooling of its own; PORTS_NO_DROP_IN says 'taking the ports from the NAME=<port> lines either prints'

i21 (call, helpers, open) — unlisted behavior change: scripts/stack (declared_range via ports.declared_range); before: the missing-range refusal said 'the provisioning range stack up leases them from'; after: 'the provisioning range the port registry leases them from'; users: owners reading stack up's refusal

i22 (call, helpers, open) — unlisted behavior change: scripts/stack USAGE; before: down removes objects labelled ok.run-tag=<tag> and cleanup checks running containers with its label; after: the text adds 'or in the compose project <tag>' to both; users: stack --help readers

i23 (call, stack-rebuild, open) — unlisted behavior change: scripts/stack::declared_stack; before: the unfilled reason named stack.start and stack.none; after: it names stack.start (with stack.tag_variable) in .ok-planner/config.json and stack up -- <command>; users: a bare stack up's refusal (B35) and, until the drive-commands stage removes it, the second line of scripts/review drive-stack

i24 (call, stack-rebuild, open) — a new stack.json entry opens with docker: false, then records the first probe before the start command runs and 'first or second' after it (in a finally, so a raised or failed start records it too); an entry that crashes before the first probe ran no command, so its sweep counts as done when the daemon does not answer

i25 (call, stack-rebuild, open) — the refusal for an unanswered sweep on a run that reached docker reads 'docker: <docker-sweep's reason>, and the run reached docker' (the reason is 'docker is not on PATH' or 'docker's daemon does not answer'), not the notes' fixed 'docker's daemon did not answer' text, so the PATH case is named truly

i26 (call, stack-rebuild, open) — cleanup's in_use counts a run that reached docker as in use where docker does not answer now, printing a left: line and keeping the entry, rather than attempting the removal and printing a refusal with exit 1

i27 (call, stack-rebuild, open) — v26.0.0 stack.json migration runs inside stack's transaction on every read: each entry's ports go to the port registry through the new ports.record_lease (port lock nested inside the stack lock, never the reverse), then the entry's ports key and the registry's next cursor are dropped; the entry's holder, declared, stop, and docker stay and are honoured

i28 (call, stack-rebuild, open) — helpers edited for module functions the rebuild lacked: scripts/ports::record_lease(root, tag, leased, at) records a lease where the tag holds none; scripts/run-group::members(root, tag, pgid=None) takes a v26.0.0 entry's holder as stop() already did; neither CLI changes

i29 (call, stack-rebuild, open) — up --name, where a run nothing uses holds the name, takes it down and writes one line on stderr ('stack: took down: <tag> (...), which held the name <name>', or the refusals with 'its entry stays without the name'); stdout keeps the tag-then-ports contract

i30 (call, stack-rebuild, open) — --tag-variable is refused where it is not a NAME, is a variable the tool sets, or is a declared port name: the stack.tag_variable checks moved into tag_variable_defects, which stack_defects and the CLI share; --stop with empty text, a repeated option, an option missing its value, and an unknown option before -- are refused

i31 (call, stack-rebuild, open) — new process groups go through run-group's registry (group.holder_group, group.stop), so the stack tool passes no holder Popen to the stop; a failed start's holder is reaped by the interpreter, and ps-state Z is excluded from the group as before

i32 (noticed, helpers-doc, noticed) — plugins/ok/families/ok-planner/admin/ADMINISTRATION.md:30 lists the standards true-up materializes under .ok-planner/docs/ (events.md, technical-writing.md) 'from one table'; ESTATE_FILES now also materializes .ok-planner/docs/stack-helpers.md, so the list is incomplete

i33 (noticed, helpers-doc, noticed) — plugins/ok/families/ok-planner/scripts/ok-planner-CLAUDE.md section 'The standards documents (docs/)' (line 85) names events.md and technical-writing.md as docs/'s suite-owned files; docs/stack-helpers.md now also lands there and is not named

i34 (noticed, helpers-doc, noticed) — plugins/ok/families/ok-planner/CLAUDE.md:27 layout line for docs/ lists the standards and rules files but not stack-helpers.md, the reference document materialized to .ok-planner/docs/

i35 (call, helpers-doc, open) — docs/stack-helpers.md gives the stack-stop line the brief names (down --name drive; s=$?; stack cleanup; exit $s, the true-up notes' form), not the reference-document notes' shorter 'stack down --name drive'; it also carries one worked example of a project's own start and stop scripts built from run-tag, ports, run-group, and docker-sweep probe/sweep, checked by running it in a scratch estate with a sleep in place of docker compose

i36 (call, helpers-doc, open) — checks/materialized-standalone and checks/vendored-layer need no edit: the first already scans the whole ok-planner/docs tree for citations, and the second pins the .ok-planner/docs folder, not each file; the cheatsheet pointer is one sentence appended to the config.json bullet

i37 (call, ports-at-true-up, open) — admin/true-up: PORTS_SRC is reached only through ports_command's subprocess; no carried_module(PORTS_SRC).PORT_NAME read is added, because the one PORT_NAME reader (the compose-variable branch of port_range_offer) left in the rules-lint stage (t1) and nothing else in true-up checks a port name; STACK_SRC stays, unread, for the stack-lines-migration stage's stack_defects import

i38 (call, ports-at-true-up, open) — admin/true-up::port_range_offer texts: the lead lines read '<config> declares no port_range, so the port registry leases no port for:' and '... beside its port_range <first>-<last>:', and the empty retired form says 'names no port in it, so the port registry leases nothing for the project', replacing 'the project publishes'; the suggestion line says 'clear of the port registry's block list'

i39 (call, ports-at-true-up, open) — admin/ADMINISTRATION.md: beyond lines 16, 21, 23, rows 92, 123, and 261, the config draft bullet (line 122) also says 'as the port registry checks it' in place of 'read as .ok-planner/bin/stack reads it', and the port-range draft's last sentence says 'Where the block says the retired object form names no port' in place of 'the project publishes no host port', the same class of sentence

i40 (call, drive-commands, open) — skills/converge/SKILL.md drive step 2 and confirm step 6: a failed stack-start runs no stack-stop, as v25.3.0's text said; the drive names the failure with its output tail and goes on, since the project's own start owns what its failure leaves

i41 (call, drive-commands, open) — skills/audit/SKILL.md: a failed stack-start records no deployment item and files its output tail as an observation, so Stack stop runs no stack-stop for it; Stack stop runs instance-destroy only for each provisioned folder that still exists, then stack-stop once where a deployment item stands; any review drive-stack refusal (a missing section, or a No stack line beside a stack line) is treated as unfilled and its text carried into the report's Stack line

i42 (call, drive-commands, open) — skills/converge/prompts/drive.md keeps one sentence beyond v25.3.0's setup text, 'Reach it, its ports, and its logs as the facts below say.', per the work item ('A driver reaches the stack, its own resources, and its instance as the project's review facts say'); the edit-nothing exception reads 'one the facts below name for starting and stopping a stack, an instance, or a resource, into a folder git ignores'

i43 (call, drive-commands, open) — skills/_shared/implementation-auditor.md: a reset records the restart as another deployment item with body 'started'; route 3 picks a folder under the system temp directory named for the task and records it as provisioned before instance-create runs, so the session's stop finds it even where the create fails midway; the judge paragraph says that with no instance-create command route 3 is closed and the re-run escalates as a precondition the run cannot meet

i44 (call, drive-commands, open) — scripts/review: drive_stack keeps returning (word, reason) as v26.0.0's did, so cmd_drive_stack prints the reason on a second line for unfilled; the {tag} refusal is the constant RETIRED_TAG_PLACEHOLDER and names the section and file without naming any helper; NO_STACK_PATTERN and drive_commands keep v25.3.0's names for the stack-lines-migration stage to load

i45 (call, instance-mark, open) — With the One at a time mark, review drives files the instance drives in the order the instance list names them, as it files the alone drives in the alone list's order; the sprint names no order among instance drives.

i46 (call, stack-lines-migration, open) — stack-lines offer: beyond the notes' case (a stack-start line that does not call .ok-planner/bin/stack while the key declares start), the offer lists every stack line that disagrees with the key: a stack-stop line beside no stack-start line or a '- No stack:' line while the key declares start, and a stack-start or stack-stop line while it declares none; its draft rule asks the owner which starts the stack

i47 (call, stack-lines-migration, open) — stack-lines offer: the line scan for {tag}, 'run tag', and 'stack list' covers only the drive's sections (## Drive commands, ## Running the product, for the drive, ## Resources a driver starts, ## Stories that drive on an instance of their own), so a scripts entry that describes a tool's {tag} refusal is not listed; a line naming 'stack up' or 'stack tag' reads a tag of its own and is exempt from the 'run tag'/'stack list' case; B5 lines are the instance-create and resource-start role lines that read OK_RUN_FOLDER, OK_RUN_LABEL, COMPOSE_PROJECT_NAME, the key's tag_variable, or a ports name and name no 'stack up'

i48 (call, stack-lines-migration, open) — B5 draft rule (ADMINISTRATION.md stack-lines bullet): <the drive name> is {name} for resource-start/resource-stop; the converge skill passes instance-destroy only --folder, so for instance-create/instance-destroy the run name is "$(basename {folder} | tr 'A-Z_.' 'a-z--')", which both lines derive from the same folder and which matches the stack tool's run-name alphabet

i49 (call, stack-lines-migration, open) — step (d) rewrites a role line naming {tag} only where its value is one backticked command and every {tag} sits outside single quotes (where "$t" would not expand); a steps-form line or a single-quoted {tag} is listed in the stack-lines offer instead

i50 (call, stack-lines-migration, open) — migrate_stack_lines, its drift lines, and the stack-lines offer all stand down wherever config-check reports a defect other than the retired ports object form (the config offer's own trigger), and wherever the carried ports module refuses ports (node absent); key-independent lines ({tag} prose, B5 lines) are listed once the config is fixed. The stack-lines offer also stands down for a seeded skeleton, which the review-facts offer covers whole

i51 (call, stack-lines-migration, open) — resolve stack-lines refuses an empty draft and a draft identical to the file, then writes it with write_text, as review-facts is handled; seeded_project_md compares the file and the file with the migration's block removed (the two fixed stack lines, or one '- No stack:' line, with the blank line the migration put before it)

i52 (call, stack-lines-migration, open) — migrate_stack_lines prints its rewrote: lines through the bash flow (stack_rewritten=$(vendor_layer stack-lines) after review_config fix, printed after the review settings' lines at the end), and writes a CRLF review facts file's appended and rewritten lines with its CRLF ending

i53 (noticed, stack-lines-migration, noticed) — admin/true-up::review_config_mode reads .ok-planner/review/project.md with read_owner (strict UTF-8), so a review facts file that does not decode as UTF-8 crashes diagnose (review_config check) and true-up (review_config fix) with a UnicodeDecodeError traceback before any other step reports; present at HEAD, outside this stage's brief

i54 (noticed, citations, noticed) — checks/oscillation lines 2-17, 49-50, 104-105: comment-hygiene violations (prose comments) from v14.0.0, unchanged by this sprint; the lint over checks/ exits 2 on them. The citation check over checks/ reports nothing.

i55 (call, citations, open) — The brief says python3 checks/run; checks/run is a bash script, so I ran bash checks/run (all checks passed). admin/true-up already carried no retired slug, so it is left unchanged.


# Sprint certification

Ledger: `.ok-planner/review/runs/converge-2026-10-16T040507.jsonl` (run folder beside it).

- **mode**: `sprint` — `.ok-planner/sprints/2026-10-15-stack-helpers.md`, base `eda17da5746b61d1a1528c452b67fff6f73ddfb6`. 27 changed files, 27 stories, no paths outside the root, build run file read (55 build divergences; 6 noticed defects became reports).
- **hunt**:
  - Review: root t1 and eight pass tasks (t2–t9: four completion, three regression, one alignment) closed `done` on the first try. They filed 15 reports; the build's noticed items added 6.
  - Drive: all 27 stories tried once, each closed `done`; the project declares no stack (`- No stack:`), so drivers ran with none. 41 failures, sorted: defect 5, not-owed 7, environment 1, backlog 28, judgment 0, upstream 0, rejected 0.
  - Reports: merged 18 into 16 defects, rejected 2 (i10, i19: the CRLF claims on `admin/true-up::facts_plan`, not real), backlog 2 (i1, i6: `checks/oscillation` prose comments, outside the change).
- **sprint**:
  - Work items, each working end to end after the fix loop:
    - The process runs each project's own stack commands — entry `skills/converge/SKILL.md` Loop 1 steps 2–4 → `scripts/review::cmd_drive_stack`, `::cmd_drive_command`; `skills/audit/SKILL.md` The deployment / Stack stop.
    - The rules and the lint carry no stack mandate — entry `admin/true-up::render_rules` over `docs/plumbline-*.md`; `scripts/plumbline::main`, `::lintChecksDefects`.
    - Ship the stack helpers — entry `.ok-planner/bin/run-tag`, `bin/ports`, `bin/docker-sweep`, `bin/run-group` → each script's `main`.
    - Rebuild the reference stack tool from the helpers — entry `.ok-planner/bin/stack` → `scripts/stack::main`.
    - A reference document for the helpers — entry `admin/true-up::ESTATE_FILES` → `docs/stack-helpers.md`.
    - True-up brings a v26.0.0 project to the helper model — entry the true-up bash flow `vendor_layer stack-lines` → `::migrate_stack_lines`; diagnose `::stack_drift`; `::offers`; `resolve stack-lines`.
    - The reuse rule prevents import cycles — entry `docs/plumbline-coding.md` rule 6.
    - A project can make its instance-story drives wait — entry `skills/converge/SKILL.md` step 3 → `scripts/review::cmd_drives`, `::story_lists`.
    - True-up proves a payload copy before it skips a file — entry `admin/true-up::caller_kind` → `::payload_copy_file`.
    - Every citation names a live decision — entry the `admin/true-up` citation lines and `design/decisions`; 13 delta bodies and the sidecar landed verbatim, 3 retired decisions deleted, `catalog-toc --check` clean.
    - Improvement I1 `scripts/tasks::event` — works; every helper, the stack tool, and the review tool emit through it.
  - Behavior changes judged: 28 (rewrite 11, migrate 10, preserve 7). One became a defect (i82, B37); the B4/B42 findings (i73, i74) merged into i72.
  - Stories driven (outcome per surface and variant):
    - achieved on every surface: concurrent-stacks-without-port-collisions, discuss-an-issue (rendered page not opened), edit-time-lint-enforcement, practice-coverage-report, project-spans-folders, see-governing-versions, session-awareness, sketch-an-idea, watch-execution-progress, write-time-prose-steering (true-up, skill:ok).
    - fresh-artifacts-per-run: skill:ok and the reference stack tool achieved; the reference document's own-commands sample failed no-other-run (i66), fixed, and confirmed achieved.
    - verification-leaves-no-artifacts-behind: skill:converge and skill:audit failed (a failed stack-start skipped stack-stop; i69, i72), fixed, and confirmed achieved for skill:converge; the reference stack tool, the helpers, and true-up achieved.
    - true-up-project-estate: whole-presence achieved; earlier-layout failed (the stack migration re-serialized the owner's `config.json`; i71), fixed, and confirmed achieved.
    - bootstrap-design-corpus: catalogs achieved; questions failed (backlog).
    - certify-completion: scripts and skill:plan-sprint achieved; skill:converge failed (backlog).
    - rule-on-the-whole-intake: JSON routes, issues CLI, skill:dashboard, skill:plan-sprint achieved; the dashboard page blocked (no browser tool; environment).
    - rule-the-public-surface: skill:plan-sprint achieved; skill:audit and skill:document failed (backlog).
    - veto-calls-made-in-my-absence: plan-sprint, triage-issues, issues CLI, tasks render achieved; skill:converge failed (not-owed, question); the dashboard stuck on a closed issue (backlog).
    - see-new-analysis: never-read and new-revisions achieved; new-answers failed on the CLI and the dashboard (not-owed, question).
    - lint-rules-compliance-report: skill:audit and plumbline failed lint-drift and unresolved-citations (not-owed).
    - failed outside the change (backlog): answer-absence-from-catalogs (skill:document, skill:audit), corpus-audit (skill:audit), document-a-release, find-and-fix-defects, plan-a-sprint, record-coding-practices (skill:plan-sprint; true-up and scripts achieved), ship-release-documents, write-time-prose-steering (skill:ok-conduct).
  - Checks: `node .ok-planner/bin/plumbline` over the 27 changed files passed before and after the fix loop; `checks/run` passes.
  - Sent to the intake as outside the sprint's scope: reports i1, i6 and the 28 backlog failures.
- **cleanup**: `.ok-planner/bin/stack cleanup` ran after the drive and after the confirm round; both printed nothing (nothing to take down). No stack started, and the facts name no `resource-stop` or `instance-destroy` line.
- **fixed**: 16 defects: verified 12, declined 0, duplicate 4 (i70, i73, i74 of i72; i83 of i64), stuck 0.
  - By entry: A9 4 (i63, i64, i66, i72); A8 3 (i69, i75, i85); A3 2 (i71, i81); C1 1 (i76); C4 1 (i84); R2 1 (i82).
  - Two fix rounds. One send-back: i81 (`scripts/run-group::start`), verified in round 2. One confirm round (t55–t57) confirmed i66, i69, i71.
- **ledger**: `.ok-planner/review/runs/converge-2026-10-16T040507.jsonl`; folder `.ok-planner/review/runs/converge-2026-10-16T040507/`.
- **intake**: the owner list (t62) wrote 29 issues: 23 `defect`, 5 `product-intent`, 1 `tooling`. It turned and closed none, and no defect was stuck.
  - defect: audit-dirty-tree-commit-misnamed, audit-extraction-entry-omits-intent-rule, audit-extractor-unsuspected-element-unfiled, audit-lint-mechanical-sites-unreported, audit-practice-text-unchecked, audit-staleness-rule-intent-edit-contradiction, audit-surface-intent-not-committed, audit-toc-consistency-unchecked, checks-oscillation-prose-comments, compliance-reviewer-judgment-disposition-contradiction, compliance-reviewer-skips-practice-form, conduct-writing-standard-handoff-and-scope, converge-fix-close-blocked-strands-defects, converge-merge-close-unhandled, converge-review-root-close-unhandled, dashboard-closed-issue-no-way-to-overturn, discover-design-reviewer-cap-unsignalled, document-assessment-warrant-unrecorded, document-catalog-per-declared-kind, document-dropped-type-document-lingers, document-goal-skips-catalog-completeness, document-named-release-not-measured, review-verifies-skips-declined.
  - product-intent: converge-calls-reach-owner-as-counts, run-group-lends-terminal, surface-extraction-completeness-unrecorded, true-up-undecodable-review-facts-skipped, unread-counts-only-agent-messages.
  - tooling: dashboard-drive-needs-browser-tool (the environment failure i49: the driver session had no browser tool).
  - Rejected reports: i10, i19 (`admin/true-up`, the CRLF claims; not real). No report or failure was set to `judgment` or `upstream`.
  - Unlisted calls (record):
    - i11 `scripts/stack` missing-range refusal now names "the port registry"; users' goal holds.
    - i12 `scripts/stack::USAGE` adds "or in the compose project <tag>" to `down` and `cleanup`; it matches B38.
    - i18 the first stack verb that reads a v26.0.0 registry, `stack list` among them, moves each entry's ports into `.ok-planner/.cache/ports.json` as a lease.
  - `/triage-issues` (ledger `.ok-planner/tasks/triage-issues-2026-10-16T051311.jsonl`) routed all 29: defect 20, question 7, retired 2, answered 0, corpus 0, upstream 0.
    - retired (veto list): dashboard-closed-issue-no-way-to-overturn — no accept-list entry covers it; the comment POST's 409 names the closed state and the archive. compliance-reviewer-judgment-disposition-contradiction — no accept-list entry covers it; the sentence is told to a subagent that does not triage.
    - to /converge: the 20 remaining defect issues above (all but the two retired and document-dropped-type-document-lingers).
    - to /plan-sprint (question, each with a recommended ruling): converge-calls-reach-owner-as-counts, dashboard-drive-needs-browser-tool, document-dropped-type-document-lingers, run-group-lends-terminal, surface-extraction-completeness-unrecorded, true-up-undecodable-review-facts-skipped, unread-counts-only-agent-messages.
    - messages: none waited. links: 27 issues relinked, 36 links written, 9 repaired, 0 unlinked. `issues links --broken` still lists four links on the sprint's promoted issues, which name the three retired decisions; those records close at the archive.
- **cost**: converge 6,752,554 tokens over 62 tasks; triage 1,349,289 tokens over 12 tasks; the build 1,756,331 tokens over 10 tasks.
