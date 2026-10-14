# Completion report: Third intake drain

Sprint: `.ok-planner/sprints/2026-10-14-third-intake-drain.md`

## Stages

- t1 — corpus. corpus-deltas — done
- t2 — true-up-rename. decision:whole-file-ownership; decision:per-project-pinning; story:true-up-project-estate; concept:true-up — done
- t3 — stamps. decision:per-project-pinning; concept:materialized-artifact — done
- t4 — docs-rename-admin. concept:true-up; concept:integration-contract; decision:administration-is-a-user-act — done
- t5 — docs-rename-skills. concept:true-up; decision:pinned-build-placed-at-true-up; decision:administration-is-a-user-act — done
- t6 — ok-web. concept:true-up — done
- t7 — port-config. decision:ports-leased-from-a-project-range; decision:port-range-chosen-at-true-up — done
- t8 — names. decision:messages-carry-their-authors-name; decision:anyone-may-rule; decision:owner-messages-can-change; decision:triage-answers-owner-messages; decision:flagged-issues-discussed-in-session — done
- t9 — cert-drive-code. decision:drive-tries-each-story-as-a-user; decision:team-execution-cold-gate; concept:completion-contract; story:certify-completion — done
- t10 — audit-folders. story:project-spans-folders; decision:project-declares-its-folders — done
- t11 — port-allocator. decision:ports-leased-from-a-project-range; story:concurrent-stacks-without-port-collisions — done
- t12 — ledger. decision:read-marks-kept-per-person; decision:agent-revisions-reach-the-owner; decision:unread-issues-count-as-new; decision:closed-answers-count-as-new; decision:intake-reads-past-stray-lines; story:see-new-analysis — done
- t13 — drive-variants. decision:drive-tries-each-story-as-a-user; story:certify-completion — done
- t14 — port-cleanup. decision:run-artifacts-removed-with-the-run; story:verification-leaves-no-artifacts-behind; concept:run-tag — partial
- t15 — compose-ports. decision:stack-ports-checked-as-a-suite-rule; decision:project-chooses-its-lint-checks — done
- t16 — word-diff. decision:agent-revisions-reach-the-owner; decision:flagged-issues-discussed-in-session — done
- t17 — merge-sorts. decision:drive-tries-each-story-as-a-user; decision:accept-list-decides-defects — done
- t18 — merge-ownership. decision:runs-fix-what-the-project-owns; decision:accept-list-decides-defects — done
- t19 — work-items-change. concept:sprint; decision:work-items-change-the-product; story:plan-a-sprint; story:certify-completion — done
- t20 — checklist-step. decision:task-tools-mirror-the-report — done
- t21 — dashboard-page. decision:messages-styled-by-type; decision:read-marks-kept-per-person; decision:agent-revisions-reach-the-owner; decision:unread-issues-count-as-new; story:see-new-analysis — done
- t22 — port-rules. decision:stack-ports-checked-as-a-suite-rule; decision:run-artifacts-removed-with-the-run; decision:ports-leased-from-a-project-range — done
- t23 — port-range-offer. decision:port-range-chosen-at-true-up — done
- t24 — drive-cleanup. decision:run-artifacts-removed-with-the-run; story:verification-leaves-no-artifacts-behind; decision:ports-leased-from-a-project-range — done
- t25 — discover-notes-record. decision:whole-file-ownership; concept:design-corpus; decision:records-stay-out-of-context — done
- t26 — port-docs. decision:ports-leased-from-a-project-range — done
- t27 — dashboard-drive. decision:drive-tries-each-story-as-a-user; decision:drive-serves-the-tree-page-build; story:see-new-analysis — done
- t28 — repoint-proven-root. decision:whole-file-ownership; decision:retired-script-repoint-needs-a-proven-root; story:true-up-project-estate — done
- t29 — strip-recoverable. story:true-up-project-estate; decision:whole-file-ownership; decision:retired-layout-strips-only-recoverable-files — done
- t30 — settings-audit. story:true-up-project-estate — done
- t31 — discover-archive. decision:discovery-notes-archived-on-consent; story:bootstrap-design-corpus; concept:design-corpus; decision:records-stay-out-of-context — done
- t32 — dashboard-detach. decision:dashboard-started-by-skill — done
- t33 — people-text. decision:messages-carry-their-authors-name; decision:read-marks-kept-per-person; decision:owner-messages-can-change; decision:agent-revisions-reach-the-owner; concept:issue — done
- t34 — cert-drive-prose. decision:drive-tries-each-story-as-a-user; concept:completion-contract; story:certify-completion — done
- t35 — issues-citations. decision:messages-carry-their-authors-name; decision:read-marks-kept-per-person; story:see-new-analysis — done
- t36 — port-cleanup. decision:run-artifacts-removed-with-the-run — done

## Divergences

i1 (call, planning, open) — Every corpus delta lands in one leading stage (corpus), not in the stage of the work item that realizes it, except the two converge retirements, which land in true-up-rename with their six annotation repoints. Every delta-bearing stage regenerates the three catalog TOCs, so per-item delta application would have chained all 35 stages one after another; one leading stage gives the same final corpus and puts every new slug on disk before any code cites it.

i2 (call, planning, open) — Three work items are split across stages to keep shared files from chaining unrelated work: the true-up wording item into docs-rename-admin and docs-rename-skills (the second runs the item's closing rg); 'Sprint certification drives every story' into cert-drive-code and cert-drive-prose; and the core's materialization-row citations for scripts/issues (from the names, ledger, and word-diff items) into one closing stage, issues-citations, so the issues stages never touch the core.

i3 (call, planning, open) — The ephemeral-start refusal in amend and resolve config: moves from the port-config stage to the port-allocator stage. The notes build it on scripts/ports check-range, which the allocator item adds, while the work items order the config item first.

i4 (call, planning, open) — The tree matched the implementation notes' commit (119169e) at planning: HEAD is that commit and git status listed no path outside .ok-planner/, so no named site differed.

i5 (call, true-up-rename, open) — Left .ok-planner/review/project.md line 43 (the dashboard drive bullet, 'converge it with the converge core') unchanged: the work item lists that phrase, but the implementation notes assign line 43 to the dashboard-drive stage (t27), which rewrites it naming the new path; it names no core path today.

i6 (call, true-up-rename, open) — In the shared docs this stage renamed 'converge core' to 'true-up core' only in the phrase that names the core's path (SKILL.md:12, plugins/ok/CLAUDE.md:7, integration-contract bullet and layout list, README:190, project.md limits and drive facts) and the default mode in each modes line; every other administration-sense 'converge' in those docs is left for the docs-rename stages t4/t5.

i7 (call, true-up-rename, open) — Per the call on the retired skill name: ADMINISTRATION.md's 'the merged true-up verb' now reads 'the retired /true-up skill', and checks/vendored-layer's two messages read 'retired /true-up skill'; the Offered names list, RETIRED_VENDORED, and the three detection paths are unchanged. checks/owned-paths' check_destinations docstring was reworded to 'true-up' (I60 names only the core's four docstrings, so it was not deleted). The core's STAMP (line 116) still says 'overwritten on converge': the stamps stage t3 owns it.

i8 (call, docs-rename-admin, open) — README.md's plugin table row keeps its 'and': '/ok is install, true up, and repair in one process'; the work item quotes 'install, true up, repair' for the manifests and CLAUDE.md files, which carry no 'and'. Every remaining converg hit in this stage's files is a keep-list site (/converge, /converge sprint, _converge, converge-local/converge-cascade, the converge skill name) or an ok-web site (README.md:39-40, marketplace.json ok-web entry) left to the ok-web stage.

i9 (call, audit-folders, open) — [FOLDERS] rides a '### The project's folders' section in each of the reading, subjects, and judge prompts (root plus one declared folder per line, 'none' = root alone); the enumeration steps point at that section by name. The 'How consumers use this file' bullet in implementation-auditor.md now names [FOLDERS] as the prompts' one per-run fill, so the file's statement that prompts carry no per-task text stays true.

i10 (call, port-config, open) — admin/true-up::config_offers: a config with the retired ports form beside another defect gets the config offer listing every defect, the retired-form line included, and its keep names ports (config_named_keys), so the draft converts the form; resolve config: still refuses a draft config-check flags, the retired form included. Only a config whose sole defect is the retired form skips the config offer.

i11 (call, port-config, open) — ADMINISTRATION.md: the amend refusals paragraph lists no lint-config keys, so this stage adds no port_range there; the ephemeral-start refusal sentence lands with the refusal itself in the port-allocator stage (t11), per planning call i3.

i12 (call, port-config, open) — plumbline::loadConfig returns portNames (the array's entries, or the retired object's keys, kept only where each is a NAME, first occurrence kept) and portRange ({first,last} only when portRangeDefects finds nothing, else null); no reader uses them until the compose-ports stage.

i13 (call, port-config, open) — scripts/review::project_folders: where config-check exits 2 and every defect line is a ports-prefixed line of the retired object form, it returns the declared folders; where any other defect stands, its stderr note still prints every defect line, the retired-form line included, as before.

i14 (call, names, open) — project.md's scripts/issues and scripts/dashboard entries (the name verb, edit/remove/unrule on your own messages, the unnamed and foreign refusals, /api/meta's name and name_hint) are left to the text stage, which the sprint assigns them to; .ok-planner/review/project.md is outside this stage's files

i15 (call, names, open) — unread and mark_read also tell an agent message by type (reply or update via AGENT_TYPE_AUTHORS) instead of by in AGENT_AUTHORS, so no site in scripts/issues tells a person's message from an agent's by its author; every stored record counts the same; the ledger stage rewrites both

i16 (call, names, open) — list --flagged help reads 'list issues flagged for discussion' (was 'the owner flagged'); the notes say a 'you flagged' text stays, but a flag carries no author, so the help names no flagger

i17 (call, names, open) — issues name --set refuses an empty, multi-line, or unsignable name (triage-issues, converge, owner) with reason unnamed, the same reason a missing name takes; after a set it prints the file it wrote and the resolved name line

i18 (call, names, open) — own_entry's foreign refusal ends 'write a new comment instead' on a comment and 'rule again to replace the ruling' on a ruling message, and names no step on an agent's message; git_name treats a whitespace-only user.name as no name and refuses an unsignable one (unnamed) rather than falling through

i19 (call, drive-variants, open) — drive.md 'Every way the story can be done' also says a flag, control, or order of actions the story's text does not name is no variant of its own, so a driver does not widen the drive past the story's words (decision drive-tries-each-story-as-a-user rejects listing every path); the confirm drive starts as a first-time user would, as every drive does.

i20 (call, ledger, open) — scripts/issues::mark_read: where the reading person has no ledger yet, mark_read seeds a fresh ledger (every live and archived record at its current agent mark) under the same lock before raising the record's mark, so the first read of a record that existed before the ledger reports 0 marked, as the seed rule counts it read

i21 (call, ledger, open) — scripts/issues::read_ledger: a ledger file that is not a JSON object whose records map '<id> <opened>' to {first_read (a time), mark (an integer)} refuses with reason invalid on every reader and on read (CLI exit 2, dashboard 409); the message names the file and says deleting it starts a fresh ledger with everything counted read

i22 (call, ledger, open) — scripts/issues::mark_read writes the ledger only when the entry is new, the mark rises, or the ledger is being seeded; a repeat read writes nothing

i23 (noticed, ledger, noticed) — .ok-planner/review/project.md:32 says 'read <id> [--opened <time>] marks every agent message read'; after this stage it records the read in the caller's git-ignored ledger and refuses with no name. The inputs are unchanged, so this stage left the entry; the issue-format item that edits project.md should restate it

i24 (noticed, ledger, noticed) — artifact-definitions.md:244 defines unread as 'agent messages the owner has not yet read' and :253 gives a reply's read field as 'null until the owner reads it'; after this stage unread and unopened come from the reading person's ledger and new agent messages carry no read field (retired, accepted when present). The issue-format item that edits this file should restate both

i25 (call, merge-sorts, open) — merge.md 'The drive's failures': a not-owed failure with two readings carries the note form 'two readings: <the first>; <the second>; <the sentence each rests on>', so owner-list.md's read of not-owed failures whose note names the story text's two readings has a fixed form to match.

i26 (call, merge-sorts, open) — fix.md step 1 names where the sprint classes live ('the sprint catalog of .claude/skills/_sprint/shared.md', C1 to M1), since fix.md pastes no {{SPRINT-CATALOG}} and now reads a sprint class for any entry, not only source sprint; the C4 row's evidence column adds 'for a story, the work item that asked for it'.

i27 (noticed, merge-ownership, noticed) — plugins/ok/families/ok-planner/skills/converge/SKILL.md:103 (sprint step 5, The merge) summarizes the ownership test as 'a fix in the corpus or the harness settings sets the item to judgment' and does not name merge.md's new first bullet: a file the review script's OWNER_PATHS misclasses as corpus, where a corpus rule decides its class otherwise, merges as a defect in the list's file. The summary now undersells the test; the notes list no change to SKILL.md for B94.

i28 (noticed, word-diff, noticed) — The notes' call adds '# @decision: agent-revisions-reach-the-owner' above the EXECUTABLE_FILES row for scripts/issues in admin/true-up (line ~228); that file is outside this stage's files, so the citation is not written. word_diff carries no citation, per checks/materialized-standalone.

i29 (call, word-diff, open) — message_line skips a diff entry that is not an object or carries no parts (a malformed stored record), and diff_text turns a recommendation or option whose text is not a string through diff_text itself (null becomes empty) where diff.js would throw; indented() gained an optional prefix so the field after-text indents eight spaces. Compared against diff.js on all 20 update fields in the intake and archive plus 5 edge cases: 19 identical, 1 differing only in a run's placement within the trimmed common tail, as the notes allow.

i30 (call, dashboard-page, open) — unlisted behavior change: browser/src/views/IssueDetail.svelte::open; before: a failed read post shows 'Could not mark the new messages read: <error>'; after: 'Could not mark this issue read: <error>', since a never-read issue with no agent messages now posts a read too; users: people on the page

i31 (call, dashboard-page, open) — scripts/issues::untouched now reads a reply's replies_to only where it is a list, because view() calls it on every person's message on every read and a malformed reply the module reads past would otherwise crash list/show and the dashboard's GETs (decision:intake-reads-past-stray-lines)

i32 (call, dashboard-page, open) — IssueDetail's ruling section reads 'ruled by <ruling_by> <at>', omitting 'by <name>' where ruling_by is null (a ruling with no ruling message); Withdraw ruling shows only where name is non-null and equals ruling_by; the header's no-name hint also turns the announce bar to its warn style

i33 (call, port-allocator, open) — scripts/ports loads the issues module through load_sibling (as scripts/review does) and takes tasks from issues.tasks, so the registry write imports issues.write_records (mkstemp in the cache folder, then os.replace) instead of copying it; root and cache come from tasks.project_root() and tasks.cache_dir(). Rule 6.

i34 (call, port-allocator, open) — ports lease/release run outside any estate exit 2 with 'tasks: no project estate ...', the refusal tasks.project_root() owns, not the 1 the notes give for refusals; every refusal ports itself makes exits 1.

i35 (call, port-allocator, open) — PORTS.RUN.FAILED carries error, message, trace, and a fixed registry field (.ok-planner/.cache/ports.json), so a registry that does not parse is named in the event without a converting catch; a registry whose leases or ports are not objects fails an assertion that names the path.

i36 (call, port-allocator, open) — The bind probe's catch emits PORTS.PORT.HELD (port, address, errno, trace) for each refused bind and returns held; an absent IPv6 stack is detected once per call (bind of :: port 0) and emits PORTS.IPV6.ABSENT, after which only 0.0.0.0 and 127.0.0.1 are probed; any other OSError propagates. Per the events standard, a caught error emits.

i37 (call, port-allocator, open) — ports check-range prints one line, 'port_range F-L holds N port(s); K are on the block list (<port> <what>, ...), so N-K remain to lease' (or 'none is on the block list'), counting block-list hits only, not ports held at that moment; it refuses on stderr as 'ports: <reason>', which the core's range_refusal relays by that prefix. The reach refusal reads 'port_range F-L reaches the machine's ephemeral range, which starts at N'; lease appends '; choose a range below N through /ok'.

i38 (call, port-allocator, open) — ports suggest-range lists every 200-port window from 1025 up to the ephemeral start that the block list does not touch, shuffles them with SystemRandom, and prints the first window none of whose ports is held now as FIRST-LAST; it refuses when no window qualifies. On this macOS host /etc/services leaves 65 gaps of at least 200 ports.

i39 (call, port-allocator, open) — The lease cursor 'next' is one past the highest port the lease took, wrapping to first when that port is the range's last.

i40 (call, port-allocator, open) — ports lease checks the names before the range, so a project that declares neither is told to declare the names and a port_range through /ok; a missing range alone says to run /ok, which suggests one.

i41 (call, port-allocator, open) — scripts/ports-blocklist lists well-known ports below 1025 as well as the popular defaults above it (3000, 4200, 5000, 5173, 5432, 6379, 8000, 8080, 8443, 9000, 9200, 27017 among them); the ESTATE_FILES row carries '# @decision: ports-leased-from-a-project-range' beside the EXECUTABLE_FILES row's.

i42 (call, port-allocator, open) — A planner port-block copy that cannot be removed with git rm (untracked, uncommitted, or a link) is an estate-edits offer worded as a state file: 'the port reader an earlier ok-planner release materialized, which nothing reads now'. The removal uses remove_files(plan['removes'], root), the stop the sibling migrations use. The planner copy joins retired_scripts() whenever head_stamped finds the stamp, a link to a stamped file included, so a link becomes an offer.

i43 (call, port-allocator, open) — The ephemeral refusal in amend compares the draft's port_range with the current file's, read through config_defects(target); resolve config compares it with the offer's keep (None when the current file does not parse, so any draft range is checked). ADMINISTRATION.md's amend refusal list and the config draft's resolve refusals name it (planning call i3, port-config call i11).

i44 (call, port-allocator, open) — In true-up mode the core probes ports --help before it writes the ESTATE_FILES rows, so on a fresh project the block list lands after the probe; --help reads no block list, so the probe passes. Verified in a scratch project: the first true-up wrote bin/ports and bin/ports-blocklist; a tracked stamped bin/port-block with a caller filed retired-planner-port-block-caller-scripts-stack-start and stayed; with the caller gone it was removed with git rm; an untracked copy became estate-edits:.ok-planner/bin/port-block.

i45 (call, port-allocator, open) — git rm -f removed plugins/ok/families/ok-planner/scripts/port-block, discarding that file's staged stamp edit from the stamps stage, since the work item deletes the file.

i46 (call, port-allocator, open) — Sites outside this stage's files that still name port-block are left to their stages: README.md:78, docs/integration-contract.md:243 and :304, plugins/ok/CLAUDE.md:7, plugins/ok/families/ok-planner/CLAUDE.md:39, scripts/ok-planner-CLAUDE.md:115, and .ok-planner/review/project.md:38 and :47 (port-docs, t26); scripts/ok-planner-cheatsheet.md:72, :74, :369, :372 (port-rules, t22).

i47 (noticed, port-allocator, noticed) — docs/integration-contract.md: the port-docs item has the repoint paragraph name .ok-planner/bin/port-block among the retired scripts; the contract is not a record to the review tool's ownership classes, so a true-up of this repository finds it as a caller, files retired-planner-port-block-caller-docs-integration-contract-md, and keeps .ok-planner/bin/port-block for as long as the paragraph names it (the same holds for line 304 and .ok-planner/review/project.md:47 until t26 lands).

i48 (call, port-cleanup, open) — ports cleanup measures each container artifact's age against the docker daemon's own clock (docker info SystemTime), never the host clock, so the hour of grace subtracts two times from one clock (plumbline-coding rule 3.6); a lease's age uses the host clock its 'at' was written with.

i49 (call, port-cleanup, open) — ports cleanup dates an image by the later of its Created time and its Metadata.LastTagTime: a fully cached build tags an image whose Created time is old, and Created alone would let the cleanup untag a live run's fresh image.

i50 (call, port-cleanup, open) — ports cleanup counts a removal as done when docker answers 'no such image', 'no such volume' (case-insensitive), or 'network <name> not found': docker 29.6 words a missing volume 'get <name>: no such volume' and a missing network 'network <name> not found', not 'No such volume/network' as the notes quote. The same absence answer on a bulk inspect keeps the objects docker did return.

i51 (call, port-cleanup, open) — ports cleanup finds run tags from images (an exact run-tag tag, or a repository named <tag>- / <tag>_), and from the compose-project labels of volumes and networks; it does not list container labels, since a tag that has containers is never removed. It checks containers per tag with docker ps -a -q --filter label=com.docker.compose.project=<tag> for each lease it would free and again right before each tag's removals.

i52 (call, port-cleanup, open) — ports cleanup writes the registry once after the frees and prints the freed: lines then, and prints each removed: line right after that tag's removals, so a docker failure partway leaves the frees recorded and the output naming every tag already cleaned; the lock is held for the whole call (registry_lock, split out of transaction as a context manager both use).

i53 (call, compose-ports, open) — compose-ports reports one violation per entry: its rule (patternKey compose-ports:<n>) is the lowest-numbered rule the entry breaks, and its message names every rule the entry breaks, joined with '; ', so one fix round covers an entry that is both undeclared and without a fallback (plumbline::checkComposePorts, ::composePortBreaks).

i54 (call, compose-ports, open) — plumbline compose-ports reads the config leniently (ignore entries that are strings, folders only when well formed, via declaredFolders) and never refuses on a malformed config, so the core's port-range offer still reads compose files while a config offer is pending; it exits 1 only on a usage error, a missing target, or an internal error (plumbline::composeConfig). ignorePatterns(userConfig) is factored out of loadConfig so both share one builder; loadConfig's behavior is unchanged.

i55 (call, compose-ports, open) — plumbline compose-ports prints every ports entry, including one that names no host port (variables [], port null); for a host port range or fallback range, port is the range's first port; host port 0 is not a port number. The reader strips a !override/!reset tag on ports:, reads only ports: keys directly under a service of the top-level services: key (deploy:, x- extension blocks, anchors, aliases, merge keys, extends, include are not read), and reads one-line flow sequences with scalar or {target, published} items.

i56 (call, compose-ports, open) — admin/true-up::published_ports exits the core with 'true-up: plumbline compose-ports could not read the compose files (exit <n>): <detail>' on a non-zero exit, the shape config_defects uses for config-check; it returns [] where node is not on PATH. No caller yet: the port-range offer stage (port_range_offer) consumes it.

i57 (call, planning, open) — t14 (port-cleanup) closed partial with 'outside files: admin/true-up: EXECUTABLE_FILES row for scripts/ports'. tasks refile copies the file list and cannot add a path, so the remainder is filed as t36 under the same key with the core added, chained after t35 (the last stage that edits the core) so it never runs beside another core edit.

i58 (call, port-rules, open) — Rule 10 in docs/plumbline-coding.md does not restate that it binds under accept-list entry A8: A8 already counts every rule in plumbline-coding.md, and no other rule in the file names A8, so the sentence would add nothing the accept list does not already say.

i59 (call, port-rules, open) — Rule 10 has eight steps: steps 1-3 the compose shape (step 1 carries the example "127.0.0.1:${WEB_PORT:-8080}:8080"), step 4 the lease before the build (marking the run live for the cleanup), step 5 the re-lease on a bind failure within a retry budget, step 6 the stop's removal and release, step 7 the evidence step naming the stack's start and stop commands in the task note, step 8 the lint check; the compose-ports sentence is a continuation line of step 8 between lint-check markers, so turning the check off drops only that sentence and leaves the numbering whole (verified by rendering with render_rules on and off).

i60 (call, port-rules, open) — ok-planner-CLAUDE.md's lint-and-hooks paragraph still names bin/port-block; the work item 'The suite's documents and this project's facts name the allocator' owns that sentence (task t26 port-docs), so this stage changed only the task-tracker paragraph (the port registry ports.json under .cache/, and deleting .cache/ ends every lease).

i61 (call, port-rules, open) — The plumbline cheatsheet's compose-ports Tooling bullet points to rule 10 of the coding rules, and the ok-planner cheatsheet's per-run section ends by naming rule 10 of .claude/rules/plumbline-coding.md as the home of the steps and their check, so the rule is stated once and the two cheatsheets refer to it.

i62 (call, port-range-offer, open) — admin/true-up check-range relays the one-line answer of scripts/ports check-range (the range's size, each block-listed port it hits with what uses it, and the count left to lease) instead of the notes' three-line range:/listed:/leasable: form: scripts/ports is outside this stage's files and the core never re-reads the block list, so the core reformats nothing; refusals print as 'check-range: <ports' reason>' with exit 1.

i63 (call, port-range-offer, open) — admin/true-up::port_range_offer also stands where ports keeps the retired object form beside a declared port_range (draft converts ports and keeps the range, no suggestion run), and where the retired form names no port and nothing publishes one (draft removes ports, adds no range), so every config whose only defect is the retired form gets the converting offer the config item promises.

i64 (call, port-range-offer, open) — admin/true-up::port_range_offer lists a compose host-port variable that is not a NAME and leaves it out of the draft's ports (amend would refuse it through config-check); the NAME pattern is scripts/ports' PORT_NAME, loaded with carried_module, not a copy.

i65 (call, port-range-offer, open) — admin/true-up::offers withholds port-range whenever config_offers() returns any offer (its only kinds are config, config-key, citation-tags), and port_range_offer returns none while the lint config the core reads is not .ok-planner/config.json (a retired-layout config awaiting its move), so amend only ever targets the file the lint reads.

i66 (call, port-range-offer, open) — admin/true-up::ports_answer is the one reader of a scripts/ports read-only verb (suggest-range, check-range): exit 0 gives stdout, a last stderr line 'ports: <reason>' gives the refusal, anything else exits 'true-up: ports <verb> failed (exit n): <detail>'; range_refusal now uses it, so its internal-failure text changed from 'could not check the draft's port_range' to that line.

i67 (noticed, port-range-offer, noticed) — docs/integration-contract.md:422, plugins/ok/CLAUDE.md:7, and plugins/ok/families/ok-planner/CLAUDE.md:16 list the core's modes (diagnose / true-up / wire-hooks / wire-env / resolve / amend) without the new read-only check-range mode; ADMINISTRATION.md and project.md name it.

i68 (call, drive-cleanup, open) — audit/SKILL.md: the cleanup lives in a new '### Port cleanup' subsection after '### Lint', run from the session once every story and assumption task has closed, and the spine's Determine step names it; converge/SKILL.md: the return's cleanup bullet also covers a sprint-mode drive skipped for no stories, and step 6 runs step 4's stop sequence over the instance folders and names 'review drives --confirm' listed

i69 (call, discover-archive, open) — discover-design SKILL.md 'Where the output lives' block gains a line for .ok-planner/history/discover/ (the scaffolding once the owner archives it, step 9); the notes did not name this block, and leaving it out would list one output location the step writes to nowhere.

i70 (call, discover-archive, open) — discover-design SKILL.md 'Re-run discipline' section left unchanged: the notes name the 'When to invoke' bullet and step 3's abort message as the re-run guidance that names the archive, and a third copy would restate it (say it once). Step 3's abort message drops its parenthetical 'keeping _discover/ makes phase 1 incremental', since the restore sentence now carries the incremental-rebuild instruction.

i71 (call, discover-archive, open) — discover-design step 9 names its own files: a note is each entry directly under .ok-planner/design/_discover/; the target check runs over all of them before any move (A1, A2); rmdir removes _discover/ only when empty, else the report names what remains. The opening keeps 'The run is end-to-end.' ahead of the notes' one-question sentence.

i72 (call, dashboard-detach, open) — skills/dashboard/SKILL.md: the start command also echoes 'pid: $pid' beside the notes' 'log: ...' line, so the skill holds the pid in the branch where the process still runs after ten seconds with no serving line; that branch (not in the notes) reports the log, pid, and log path and leaves the service for the owner to stop

i73 (call, dashboard-detach, open) — skills/dashboard/SKILL.md: the skill's command list names five commands (kill -0 liveness check, start, webbrowser reopen, kill stop, rm -rf of the log folder) rather than the notes' three, since step 1's kill -0 and the log-folder removal are commands too; step 1 removes a dead service's log folder before starting anew, and step 2 removes it when the process exits without a serving line

i74 (noticed, dashboard-detach, noticed) — .ok-planner/design/decisions/dashboard-started-by-skill.md Choice says the skill starts the service 'in the background of the owner's session'; the skill now starts it as a process detached from the session that outlives it. The words still read true of a detached background process, but the decision does not say the service outlives the session; no delta in this sprint amends it

i75 (call, people-text, open) — project.md: besides the drive bullet's XDG_CONFIG_HOME step (now step 5; the seed-and-serve and stop steps renumber to 6 and 7), added a 'What no agent of this loop ever runs' entry: 'issues name --set' with XDG_CONFIG_HOME unset or naming the operator's own configuration folder, since it writes the operator's own name file; the dashboard facts also say the service signs and counts under its starter's name, 400 for no name, 403 for another's message.

i76 (call, people-text, open) — Beyond the notes' enumerated lines, the same rg also returned and this stage rewrote: plan-sprint SKILL.md lines 42 ('count of owner messages'), 44 ('the owner's own words'), 52 ('the ruling is the owner's alone'), 134 ('the owner's unseen comments'); triage SKILL.md line 8 and respond.md's heading ('the owner's messages'); respond.md's 'the owner could accept', 'reaches the owner', 'the dashboard shows the owner that diff' (now every surface, issues show included); family CLAUDE.md line 63 ('a written ruling is the owner's decision'); artifact-definitions line 292 ('becomes the owner's ruling' -> 'becomes the ruling'). Owner stays where it names the person running /plan-sprint or an owner act (closing, filing upstream).

i77 (noticed, people-text, noticed) — plugins/ok/families/ok-planner/skills/plan-sprint/core.md:148 says 'one an owner comment triage has not yet seen holds back'; the term is now 'a person's comment' (decision:anyone-may-rule, messages-carry-their-authors-name). Outside this stage's files.

i78 (noticed, people-text, noticed) — plugins/ok/families/ok-planner/skills/converge/prompts/owner-list.md:48 says 'an update message the owner reads' and 'The owner's ruling, where one stands, is the owner's'; with several people working the intake the update reaches each person and the ruling is its author's. Outside this stage's files.

i79 (call, strip-recoverable, open) — The story and decision globs and the falsifier concept path became named constants (STORY_FILES, DECISION_FILES, FALSIFIER_CONCEPT) that RETIRED_SECTIONS, the strips, diagnose, and the offers share, in place of the inline os.path.join lines inside strip_story_sections and strip_decision_proofs; checks/owned-paths' three needles now name the constant lines (plumbline-coding rule 6: one table for every reader).

i80 (call, strip-recoverable, open) — After git rm of a removable falsifier concept, strip_story_sections recreates .ok-planner/design/concepts/ with os.makedirs(exist_ok=True): git rm prunes an emptied folder, so without it a project whose only concept was falsifier.md would show 'missing directory: .ok-planner/design/concepts' on the next diagnose and need a second true-up pass. The resolve path of the estate-edits offer keeps the sibling's prune; the next true-up recreates the folder.

i81 (call, strip-recoverable, open) — I61: retired_section_files reads each story or decision as bytes, finds retired headings on a surrogateescape decode, and names a file as left only where it carries a retired heading and fails a strict UTF-8 decode, so a non-UTF-8 file with no retired section prints nothing. Diagnose prints the same left: line as a notice that does not change its exit status.

i82 (call, strip-recoverable, open) — stripped matches a retired heading as the exact line '## <name>' anywhere in the file, including the first line, where the old regex required a preceding newline; the strip reads and writes bytes exactly (CRLF lines and trailing spaces survive), where read_owner's universal-newline read would have turned CRLF into LF.

i83 (call, strip-recoverable, open) — The retired-sections offer's What reads '<path> holds the retired <## names> section(s), and it <state>; true-up strips a retired section itself only where git tracks the file unchanged and no symbolic link is involved, so it leaves this one to the owner.'; its resolve prints 'stripped: <path> — the retired <names> section(s)' and refuses a file that is itself a link with 'resolve: <path> is a symbolic link; nothing changed. Replace the link with the file it points at, or remove the link yourself, then run /ok again.'


# Sprint certification

- `mode`: `sprint`, `.ok-planner/sprints/2026-10-14-third-intake-drain.md`, base `119169e2e0dc738cd85e8e08303c708fc5741b1f`. 71 changed files, a build run file, no paths outside the project root. The run followed the vendored `/converge` skill, which drives the stories the sprint's deltas add or amend and its work items name (8 stories). The sprint's rule that certification drives every story lives in the canonical source and reaches this project's vendored skill at its next true-up.
- `hunt`: the find loop ran once. Review root t1 filed 13 pass tasks (7 completion, 5 regression, 1 alignment); every pass closed `done`. Drive: 8 stories, 8 drivers closed `done`.
  - `see-new-analysis`: achieved on every surface (issues CLI, dashboard page and routes, `/dashboard`).
  - `true-up-project-estate`: true-up core failed (i22); `/ok` failed (i23).
  - `verification-leaves-no-artifacts-behind`: `bin/ports` failed (i18, i19); `/converge` failed (i20); `/audit` failed (i21).
  - `concurrent-stacks-without-port-collisions`: allocator, run tag, and compose lint achieved; true-up core failed (i15); `/converge` failed (i16).
  - `certify-completion`: `/plan-sprint` failed (i11); `/converge` failed (i12); review and tasks scripts achieved.
  - `plan-a-sprint`: `/plan-sprint` failed (i13, i14).
  - `project-spans-folders`: every surface achieved but `/converge` (i10).
  - `bootstrap-design-corpus`: `/discover-design` failed (i17).
  - Failures sorted: 4 `defect` (i15, i16, i18, i20), 4 `not-owed` (i12, i14, i17, i19), 6 `backlog` (i10, i11, i13, i21, i22, i23), 0 `environment`, 0 `judgment`, 0 `upstream`.
  - Reports: 14 (9 build-noticed, 5 from passes); 8 merged, 6 rejected.
- `sprint`:
  - Work items: all 31 checked end to end by the completion passes, with entry points in t1's close result; the passes found 5 defects (i27, i28, i8 via core.md:148, i26, i29) and reported every other item clean. The 7 taken improvements (I1, I20, I21, I40, I60, I61, I62) work.
  - Behavior changes: every listed change (B1–B139 as numbered in the notes) judged by the 5 regression passes; 2 became defects (i29 under B1/B3, ruling `migrate`; i24 under B133/B135, ruling `rewrite`); the rest hold their rulings.
  - Alignment: every delta lands byte for byte (48 files and 3 retirements); the catalog TOCs regenerate clean; no live citation names a retired slug.
  - Stories driven: the 8 above, per surface.
  - Checks: `node .ok-planner/bin/plumbline` over the changed files passed at the start (t2) and at the end (t43); `bash checks/run` passed.
  - Sent to the intake as outside the sprint's scope: the 6 backlog failures.
- `fixed`: 8 `verified` (i30 A8, i31 C1, i33 R4, i36 R2, i42 A3, i43 A3, i44 A5, i45 A8), 0 `declined`, 3 `duplicate` (i32 C1, i34 C4, i35 A5), 0 `stuck`. Fix rounds: 2. Send-backs: i43 once (its confirm driver; fixed again and confirmed in round 2).
- `ledger`: `.ok-planner/review/runs/converge-2026-10-14T050729.jsonl`, with its folder beside it.
- `intake`: the owner list (t44) wrote 12 issues and closed none.
  - `category: defect` (8): sprint-pass-diff-skips-declared-folders, sprint-contract-stuck-check-two-verdicts, surface-corpus-misses-cited-stories, audit-experiments-leave-provisioned-deployments, true-up-leaves-retired-sprint-boilerplate, ok-trues-up-from-superseded-payload, owner-question-test-one-owner-ruling, ports-cleanup-stops-at-refused-removal.
  - `category: product-intent` (4): discover-design-back-edge-kinds, ports-cleanup-suffixed-run-tags, certification-cannot-land-its-own-delta, port-range-offer-beside-config-offers.
  - No stuck defect, no `environment` failure, no report or failure set to `judgment` or `upstream`.
  - Rejected reports (6): i1 `.ok-planner/review/project.md`, i2 `skills/_shared/artifact-definitions.md`, i3 `skills/converge/SKILL.md`, i4 `admin/true-up`, i5 `docs/integration-contract.md`, i7 `.ok-planner/design/decisions/dashboard-started-by-skill.md`; each build-noticed site was already changed by a later stage or names a corpus or record the run leaves alone.
  - Unlisted (record): i25, `browser/src/views/IssueDetail.svelte::open`, the read-failure notice wording changed.
  - `/triage-issues` (`.ok-planner/tasks/triage-issues-2026-10-14T055020.jsonl`): 12 taken; 1 `answered` (port-range-offer-beside-config-offers), 8 `defect` with generated rulings for the next `/converge`, 3 `question` with recommended rulings for the next `/plan-sprint` (discover-design-back-edge-kinds, ports-cleanup-suffixed-run-tags, certification-cannot-land-its-own-delta); 6 links written on 5 issues.
- `cost`: 3,881,751 tokens over 44 tasks in the certification run; triage 421,662 tokens over 4 tasks.
