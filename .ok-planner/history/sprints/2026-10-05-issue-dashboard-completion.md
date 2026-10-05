# Completion report: Issue dashboard

Sprint: `.ok-planner/sprints/2026-10-05-issue-dashboard.md`

## Stages

- t1 — s01-corpus. concept:issue; decision:audit-audience-split; decision:steering-over-prose-lint; story:rule-on-the-whole-intake; story:discuss-an-issue; story:see-new-analysis; decision:issue-records-in-one-file; decision:closed-issues-leave-the-live-file; decision:issue-writes-through-one-module; decision:triage-answers-owner-messages; decision:local-web-surface; decision:pinned-build-placed-at-converge; decision:svelte-dashboard-frontend; decision:dashboard-started-by-skill — done
- t2 — s02-module. work-item:1; decision:issue-records-in-one-file; decision:closed-issues-leave-the-live-file; decision:issue-writes-through-one-module — done
- t3 — s03-service. work-item:6; decision:local-web-surface — done
- t4 — s04-converge-readers. work-item:2; work-item:4; decision:issue-writes-through-one-module — done
- t5 — s05-plan-sprint. work-item:2; work-item:4; decision:audit-audience-split — done
- t6 — s06-filers. work-item:2; work-item:4; decision:issue-writes-through-one-module — done
- t7 — s07-triage. work-item:3; decision:triage-answers-owner-messages; story:discuss-an-issue; story:see-new-analysis — done
- t8 — s08-docs. work-item:4; concept:issue; decision:issue-records-in-one-file; decision:foreign-harms-become-upstream-issues — done
- t9 — s09-migration. work-item:5; decision:issue-records-in-one-file — done
- t10 — s10-page. work-item:7; decision:svelte-dashboard-frontend; story:rule-on-the-whole-intake; story:discuss-an-issue; story:see-new-analysis — done
- t11 — s11-pinned. work-item:8; decision:pinned-build-placed-at-converge — done
- t12 — s12-skill. work-item:9; decision:dashboard-started-by-skill — done

## Divergences

i1 (call, s01-corpus, open) — Every corpus delta lands in one first stage (s01-corpus) rather than in the stage that realizes it: every delta-bearing stage writes the shared catalog TOCs, so per-stage application would chain all twelve stages; every later stage builds on s01.

i2 (call, s02-module, open) — issues close takes either flags (--as, --reason, --fixed-by) or --from with a JSON object {closed_as, reason, fixed_by}, and refuses both at once: notes section 1 lists close among the --from verbs while section 2 writes 'close --as retired --reason'.

i3 (call, s02-module, open) — F/scripts/issues raises Refusal(message, reason) with reason one of missing, closed, promoted, empty, invalid, legacy, conflict, so the dashboard (stage s03) can map 404/409/400 without parsing text; the CLI's main catches Refusal alone, prints 'issues: <line>' per line, and exits 2.

i4 (call, s02-module, open) — The module does not enforce 'triage never closes a record that has a ruling': it cannot tell triage from plan-sprint, which closes ruled records (a filing upstream is rule then close --as answered). The rule stays in the triage prompts (stage s07).

i5 (call, s02-module, open) — Computed state precedence: archived -> closed; route defect -> verified (even with a ruling); a ruling -> ruled; any other route -> needs-ruling; else open. waiting = (no route and no ruling) or an owner message at seen null; unread = triage messages at read null. list/show --json add state, waiting, unseen, unread to each record on output only.

i6 (call, s02-module, open) — issues read (mark triage messages read) leaves 'updated' alone; every other write sets 'updated' to the write's time. promote stores the sprint file's basename in 'sprint', and list --sprint matches by basename; promote into a second sprint is refused.

i7 (call, s02-module, open) — issues file takes id, kind, source and the revisable fields (route included, answered/retired refused); it fills artifacts [], route/recommendation/ruling/upstream null, options [], messages [], opened = updated = now. import fills the same defaults and updated = opened, takes a JSON array or JSON Lines, treats a record carrying closed or closed_as as archived, and refuses a closed record whose id is live. respond's update must name at least one revisable field, and each reply a non-empty replies_to.

i8 (call, s02-module, open) — Schema bounds: artifacts are concept|story|decision|subject|practice:<slug>; category is the 14-entry list of {{ISSUE-DEFINITION}} (the retired 'proof' category of archived markdown files is not accepted, which touches only open files, the ones markdown-intake converts); timestamps are YYYY-MM-DDTHH:MM:SSZ. A new store file is written mode 0644; an existing one keeps its mode.

i9 (call, s02-module, open) — Outside an estate the module stops through the imported tasks.project_root, whose message carries the 'tasks:' prefix; kept for plumbline-coding rule 6 (import, never copy).

i10 (noticed, s02-module, noticed) — ADMINISTRATION.md layout list (the executables line) and the probe line ('Converge runs each executable once...') do not name bin/issues and 'issues --help', which converge now writes and probes; stage s09 owns the file.

i11 (noticed, s02-module, noticed) — The family CLAUDE.md Layout block lists scripts/tasks and scripts/review but not scripts/issues (materialized to .ok-planner/bin/issues); stage s08 owns the file.

i12 (call, s05-plan-sprint, open) — plan-sprint Frame leaves alone a live record whose 'sprint' is set: it is already promoted into an earlier sprint and waits for that sprint's archive step (the old text treated promoted files as closed wherever they sat; 'rule' and 'comment' refuse such a record).

i13 (call, s05-plan-sprint, open) — plan-sprint: a recommendation accepted by silence gets no 'ruling' written; Terminal promotes it with 'issues promote' alone, since unmarked ruling text is the owner's alone (decision:audit-audience-split).

i14 (call, s05-plan-sprint, open) — plan-sprint Frame's hold-back test is 'ruling' null and 'unseen' above 0 (from 'issues list --json'): an owner comment at seen null holds back a recommendation; a record with an owner ruling stays ruled whatever its unseen messages, since the hold-back governs the marked ruling only.

i15 (call, s05-plan-sprint, open) — plan-sprint Layout: the mkdir drops .ok-planner/history/issues beside .ok-planner/issues (nothing the session does writes there now; the module creates history/ for its archive); the stop runs 'issues list' and stops on its refusal, or says /ok materializes .ok-planner/bin/issues where it is missing.

i16 (call, s05-plan-sprint, open) — SPRINT-BUILD-PROMPT: dedup reads 'issues list' (every open issue) and 'issues show <id>'; where the module refuses (an unconverted intake), the builder names the harm and the refusal in its close result instead of filing; the staged path is .ok-planner/issues.jsonl.

i17 (call, s06-filers, open) — The documentation walk's unsettled-type issue (audit-composed and /document's own) and the surface extractor's residual-ambiguity issue are filed kind audit; the old walk text named no kind, and the module requires one of audit|discover|sprint|human.

i18 (call, s06-filers, open) — Dedup per filer: the extractor and the walk run 'issues list --category unclear' and file nothing where an open issue already asks about that element or type; the judge lists by '--artifact <kind>:<slug>' (by '--category' where the issue names no artifact; '--category upstream' for an upstream issue) and reads hits with 'issues show'; practice violations use '--artifact practice:<slug> --category defect'; discover-design runs 'issues list' and files only ids not already open.

i19 (call, s06-filers, open) — The audit's Layout mkdir and discover-design's step-1 mkdir drop .ok-planner/history/issues as well as .ok-planner/issues: neither run writes the markdown archive any more, and the module writes .ok-planner/history/issues.jsonl itself.

i20 (call, s06-filers, open) — unlisted behavior change: F/skills/document/SKILL.md::Close-out; before: committed the records and the revised documents only, leaving a walk-filed issue file uncommitted; after: the commit includes .ok-planner/issues.jsonl where this run's walk filed into it; users: /document runs that reuse a current audit and leave a document type unsettled.

i21 (call, s06-filers, open) — F/skills/audit/SKILL.md Requires names the intake module .ok-planner/bin/issues among the vendored prerequisites whose absence stops the run, since every filing path now writes through it.

i22 (call, s06-filers, open) — The judge prompt (F/skills/_shared/implementation-auditor.md) gains a '### Filing' section that every outcome cites ('per Filing above'), and names the record fields problem, options, and upstream (the module's field names) in place of the old Problem, Candidates, and '## Upstream issue' section; discover-design's reviewer checks a record (id, kind discover, title, category, problem, options; no route, recommendation, ruling, or messages) in place of frontmatter and filename. The {{ISSUE-FILE-FORMAT}} body itself is stage s08's.

i23 (call, s07-triage, open) — Triage scope: the upstream re-check takes records with route upstream and no ruling (triage never closes a ruled record, so a ruled upstream record has nothing to re-check); a record with sprint set (promoted) is out of every part of the scope, phase 3 included, since the sprint is its source of truth and the module refuses owner messages on it.

i24 (call, s07-triage, open) — triage.md: before closing a record answered or retired, a triage agent that finds an owner message at seen:null answers it with one 'issues respond' (reply naming the route and reason, seen marks), then closes; otherwise the owner's message would sit unseen in the archive, out of phase 3's reach (respond refuses a closed record). Two module writes, each idempotent: a crash between them leaves the record unrouted for the next run.

i25 (call, s07-triage, open) — respond.md: a respond agent closes nothing; where an owner message shows an issue settled, it replies with what settles it and, on an unruled record, revises the recommendation to a generated ruling that closes it, for /plan-sprint to carry. It may change route among upstream/defect/corpus/question through the update (category follows for upstream and defect).

i26 (call, s07-triage, open) — Phase 3's items are listed from the store after phase 2 (issues list --json, unseen > 0, no sprint), so it answers messages on records phases 1-2 routed and skips records phase 1 closed; every batch passes --files .ok-planner/issues.jsonl .ok-planner/history/issues.jsonl since items carry id, not file.

i27 (call, s07-triage, open) — unlisted behavior change: F/skills/triage-issues/SKILL.md report veto list; before: the owner restored a retired/answered issue by moving the file back and deleting its triage: stamp; after: the owner restores one by filing it again with 'issues file' from the archived record 'issues show <id>' prints (the module has no reopen verb); users: the owner reading the triage report.

i28 (call, s07-triage, open) — author.md: the recommendation's text carries no 'Recommended ruling (/triage-issues):' label and no owner HTML note, since the record's form field marks it and the dashboard's 'a' key adopts the text as the ruling word for word; the rationale and flip case stay in the text under 'Rationale:'. The upstream note's rule (silence accepts no upstream recommendation) stays in the prompt as guidance, carried to the owner by /plan-sprint.

i29 (call, s03-service, open) — F/scripts/dashboard loads the sibling issues module with its own load_sibling, the same shape issues uses for tasks: the bootstrap loader cannot be imported from the module it loads. Root comes from issues.tasks.project_root(), so outside an estate the service exits 2 with the 'tasks: no project estate' line, as issues does (i9).

i30 (call, s03-service, open) — Refusal reasons map to statuses: missing 404; closed, promoted, conflict 409; empty 400; and, beyond the notes' list, legacy (retired markdown intake or pre-v9 event log) and invalid (a bad store line) 409, each answering the module's message, which names the /ok offer or the bad line.

i31 (call, s03-service, open) — POST bodies: beyond the notes' 400/415, a body over 1 MiB answers 413 and a non-numeric Content-Length 400; an empty body reads as {} (read takes none). rule and comment answer {"message": <the message written>}, read answers {"marked": <count>}; the page refetches the record. The Host/Origin 403 check runs on every request, GET and static included.

i32 (call, s03-service, open) — GET /api/meta answers service_version (null for the unstamped carried copy), estate_version (.ok-planner/CLAUDE.md stamp), build (bool), build_version (index.html meta ok-planner-version, null when unstamped), version_agrees, build_agrees, root. At start the service prints one 'dashboard: <note>' line per version disagreement or missing build before the serving line, the restored estate-version check.

i33 (call, s03-service, open) — GET /api/issues also takes state=closed (the module's select serves the archive); waiting and unread take 1/true or 0/false, and an unknown state, category, or flag value answers 400. Summaries carry id, title, kind, category, artifacts, route, state, waiting, unseen, unread, opened, updated, and sprint/closed/closed_as/reason/fixed_by where present; GET /api/closed answers the same summaries.

i34 (call, s03-service, open) — Static serving resolves containment on realpath (separator-bounded), so a symlink out of .ok-planner/dashboard/ answers 403; a path naming no file falls back to index.html, as the corpus view did. A --port the OS refuses with EACCES prints a message and exits 1, as a port in use does. The process main is an owner frame: an unexpected raise prints one DASHBOARD.SERVICE.FAILED line with its traceback and exits 1.

i35 (noticed, s03-service, noticed) — ADMINISTRATION.md layout list (the executables line) and the probe line ('Converge runs each executable once...') do not name bin/dashboard and 'dashboard --help', which converge now writes and probes; stage s09 owns the file.

i36 (noticed, s03-service, noticed) — The family CLAUDE.md Layout block does not list scripts/dashboard (materialized to .ok-planner/bin/dashboard); stages s08, s11, and s12 own the file.

i37 (call, s04-converge-readers, open) — review loads its sibling issues module at import with the same load_sibling shape issues uses for tasks (a loader cannot import itself; no other load-by-path idiom exists in the tree), and main catches issues.Refusal beside ReviewError, printing 'review: <message>' and exiting 1, so the module's refusal (unconverted markdown intake, pre-v9 log, a bad line) reaches the owner as its message. surface-corpus loads <root>/.ok-planner/bin/issues with the same shape and answers a Refusal with 'surface-corpus: <message>', exit 2; no argument or more than one prints usage, exit 2.

i38 (call, s04-converge-readers, open) — I1: review backlog builds every report before adding any; every 'settled' entry carries {issue: <id>, files: [], left_alone: {path: kind}}; a record whose problem names no file of the tree outside the exclude list is settled with left_alone {}. The converge SKILL's rule: a left-alone entry adds its report with site=<its first left-alone file>; a no-file entry adds its report with no site and files=[], and merge.md tells the merge agent to find the site the problem describes or reject it gone.

i39 (call, s04-converge-readers, open) — unlisted behavior change: plugins/ok/families/ok-planner/skills/converge/SKILL.md::Preconditions; before: a run read the markdown intake whatever its state; after: the run first runs '.ok-planner/bin/issues list' and stops with the module's message (naming the /ok offer) when the markdown intake or the pre-v9 log stands, since the owner list could not write the intake either; owner-list.md closes blocked on the same refusal. users: /converge runs in a converged project whose owner declined the markdown-intake offer (B19's population).

i40 (call, s04-converge-readers, open) — owner-list.md: a record has no sections, so the stuck and left-alone turns append '## Stuck in <run>' / '## Left alone in <run>' to problem (as issues show --json gives it) and a proposal issue ends its problem with '## Proposed entry', keeping the section names triage.md keys on; the '## Upstream issue' draft goes in the record's upstream field; Candidates become options; closes are 'issues close <id> --as fixed --fixed-by <run>' and '--as answered --reason <...>'; ledger notes name issue ids.

i41 (noticed, s04-converge-readers, noticed) — triage.md:11 runs 'surface-corpus <the issue file>'; after B2 surface-corpus takes a record id (argv[1]) and refuses a path as an unknown id. Stage s07 owns the file; its brief does not name the surface-corpus call. plan-sprint/SKILL.md:121 has the same call, which stage s05's brief covers ('surface-corpus takes a record id').

i42 (call, s08-docs, open) — {{ISSUE-FILE-FORMAT}} shows the filed JSON object for 'issues file --from -', the stored record as a field table (not JSON with union placeholders an agent could copy literally), the archive-only fields, the computed state, the discussion's message types, and a writer-to-verb table; the upstream draft lives in the record's 'upstream' field in the shape the old '## Upstream issue' section had, with no heading of its own.

i43 (call, s08-docs, open) — The estate CLAUDE template's intake section names the /dashboard skill (work item 9) and the terminal form 'python3 .ok-planner/bin/dashboard', and describes dashboard/ as suite-owned, placed at the estate's stamped version, ignored by git through its own ignore file; the history/ list names history/issues.jsonl and keeps history/issues/ for earlier markdown records; the .cache/ list names the intake's lock.

i44 (call, s08-docs, open) — README's intake bullet names the store, bin/issues, and the local dashboard page, and its sprint-loop paragraph says /triage-issues answers the owner's comments; the integration contract's conformance list names the store and archive, bin/issues and bin/dashboard, and adds the markdown intake's and pre-v9 event log's conversion into records to the retired-layout migrations. The /dashboard verb listings stay for stage s12.

i45 (call, s08-docs, open) — practice-definitions.md and review/CLAUDE.md carry no wording that names markdown issue files or the issues/ folder (only 'the intake' and 'an upstream issue'), so both stand unchanged.

i46 (noticed, s08-docs, noticed) — Consumers of {{ISSUE-FILE-FORMAT}} still say it gives a '## Upstream issue' section's shape: triage-issues/prompts/author.md:10, converge/prompts/owner-list.md:31, _sprint/shared.md {{SPRINT-BUILD-PROMPT}}, admin/ADMINISTRATION.md legacy-intake/intake/tensions drafts. The block now gives the record's 'upstream' field draft; each owning stage (s04, s05, s07, s09) should name the field.

i47 (call, s10-page, open) — browser/package.json carries only the build script, and vite.config.js has no dev-server proxy: the service binds an OS-assigned port and refuses a foreign Host or Origin, so a fixed proxy target (the old 7777) cannot reach it and a proxied page's POSTs would be refused; the page is exercised by building and placing dist under .ok-planner/dashboard/.

i48 (call, s10-page, open) — Verified defect records sit in no nav tab; the header's 'N verified defects waiting on /converge' count links to a hidden #/verified view listing them, so a verified record stays reachable. The unread and waiting-on-triage tabs also exclude state verified.

i49 (call, s10-page, open) — Each tab's list is a snapshot taken when the tab loads: ruling, commenting, or marking an issue read updates its row in place instead of dropping it from the tab, so j/k keep their place while the owner works down the queue; the nav counts re-read the intake after every action, and reopening a tab re-filters.

i50 (call, s10-page, open) — The tab predicates (tabs) live in src/lib/api.js beside isUnread, isNew, and readOnly, since the task's files hold no other non-view module; the @story: see-new-analysis lines sit on markRead, isNew, and isUnread, @story: rule-on-the-whole-intake on rule, tabs, and keys.js onKeys, @story: discuss-an-issue on comment.

i51 (call, s10-page, open) — Every catch in the page emits one console.error event with a kind literal and structured fields (error, message, stack, and id/tab/kind where present): DASHBOARD.META.FAILED, DASHBOARD.LIST.FAILED, DASHBOARD.COUNTS.FAILED, DASHBOARD.ISSUE.FAILED, DASHBOARD.READ.FAILED, DASHBOARD.POST.FAILED; each then shows the service's message to the owner. The browser has no other event helper (project.md names none).

i52 (call, s10-page, open) — 'a' posts the recommendation's text as the ruling at once, with no confirmation, and replaces an existing ruling the same way 'r' does (the module overwrites ruling on every rule); the text box is the owner's only confirmation step for r and c. An empty text is sent and the service's refusal ('the ruling's text is empty') is shown.

i53 (call, s10-page, open) — Problem, options, recommendation, ruling, upstream draft, and message texts render as plain pre-wrapped text, not markdown, so the page carries no markdown library.

i54 (call, s10-page, open) — Opening an issue marks its triage messages read once (live records only, and only when the summary's unread count is above zero), but the open view keeps showing those messages as new until the issue is reopened, so the owner sees what changed on the visit that cleared it. Rapid j/k presses queue their targets so each press moves one row.

i55 (call, s10-page, open) — Pinned versions: svelte ^5.57.1, vite ^8.3.2, @sveltejs/vite-plugin-svelte ^7.3.1 (whose peer range is vite ^8), locked in package-lock.json; node_modules/ stays on disk ignored by F/.gitignore for stage s11's build. Verified by npm run build (no warnings) and a headless Chrome drive of every tab, j/k, a, r, c, Esc, Ctrl/Cmd+Enter, mark-read, and the closed and promoted read-only views through F/scripts/dashboard against a scratch project; dist and scratch removed.

i56 (call, s09-migration, open) — legacy-intake fold edge cases (F/admin/converge::folded_log, logged_open, logged_close): a kind or category outside the module's lists becomes human/other and a citation that is not kind:slug is dropped, each named in problem; a promote row's resolution (and a legacy resolve row's) becomes the archived record's ruling; a promote row naming no sprint folds as retired, since closed_as promoted requires sprint; a second open row for an open id is ignored and a terminal row closing nothing folds to nothing; at values are normalized (date alone, missing Z, fractions, +00:00) to ISO 8601 UTC Z.

i57 (call, s09-migration, open) — markdown-intake resolve (F/admin/converge resolve branch): besides the notes' refusals, it refuses a drafted record whose id differs from the id the offer lists, a drafted record carrying closed/closed_as, and a run while history/issues/ already holds a file of the same name; with no open or verified file the offer carries no draft and resolve only moves the files. Import runs before the moves; a crash between them leaves the files, and a re-run with the same draft skips the byte-identical records.

i58 (call, s09-migration, open) — F/admin/converge loads the carried F/scripts/issues in-process (carried_intake, exec by path as issues loads tasks) for KINDS, CATEGORIES, SLUG, ARTIFACT, parse_lines, is_event, markdown_files, and read_records, replacing the copied ISSUE_KINDS (plumbline-coding rule 6); every write still goes through the module CLI via subprocess.run import with OK_PLANNER_PROJECT_ROOT set.

i59 (call, s09-migration, open) — F/admin/ADMINISTRATION.md: the materialized-executables list and the run-check list now name bin/issues and bin/dashboard (issues --help, dashboard --help), which the EXECUTABLE_FILES table already carried; the layout list drops the issues/ intake.

i60 (call, s09-migration, open) — unlisted behavior change: F/admin/converge::offers ordering; before: intake: and intake-closed: blocks printed last, after script-path offers; after: legacy-intake and markdown-intake print where legacy-intake printed, before tensions; users: /ok, which presents every block in one question.

i61 (call, s11-pinned, open) — expected() keys the placed build as os.path.join(BUILD_DEST, rel_), with BUILD_DEST = os.path.join(ok_dir, "dashboard") one constant shared with the sweep, instead of repeating the literal os.path.join(ok_dir, "dashboard", rel_); checks/owned-paths EXPECTED_KEYS names that key and reads the placement destination from the BUILD_DEST line

i62 (call, s11-pinned, open) — checks/owned-paths' retired-estate check also covers EXECUTABLE_FILES destinations under .ok-planner/, and flags a RETIRED_ESTATE entry that sits under a placed destination as well as a destination at or under an entry; table rows are parsed through one helper, table_destinations, shared with check_destinations

i63 (call, s11-pinned, open) — converge prints 'placed: the dashboard build at .ok-planner/dashboard/ (vX), ignored by git through its own .gitignore' on every run, and a 'removed: N file(s) under .ok-planner/dashboard/ not part of the carried vX build: <paths>' line when the sweep removes any; the sweep prunes the folders it empties, bounded by dashboard/

i64 (call, s11-pinned, open) — a symlinked .ok-planner/dashboard/ skips only the extra-file sweep and its diagnose finding, as the notes say; converge still writes the carried files through the link, the same as every other materialized path

i65 (call, s11-pinned, open) — the non-UTF-8 refusal is an assertion that the bytes round-trip through a replace-decode unchanged, with no catch; placement then reads the file through read_source, so newline handling matches every other materialized file and diagnose's comparison

i66 (call, s11-pinned, open) — /release: preflight now requires node and npm on PATH, the frontmatter description and the opening paragraph name the build, and the Notes line on what the release edits names the rebuilt bundle; step 5a also prints git status of dist/

i67 (call, s11-pinned, open) — unlisted behavior change: F/admin/converge::expected (via carried_build); before: diagnose, resolve, report, and converge ran from any payload; after: a payload with no browser/dist/index.html, or with a non-UTF-8 file in dist/, stops diagnose, resolve, report, and converge (after migrate) with an AssertionError naming the path, since all four compute expected(); users: /ok run from an unbuilt development checkout of this repo, never a released payload

i68 (call, s12-skill, open) — The /dashboard skill passes --port <port> when the owner names one (no port otherwise), relays every 'dashboard:' version or build note printed before the serving line, reports the existing address instead of starting a second copy when this session already runs one, and reports a non-starting service's output verbatim. Enumerated verb listings: F/admin/converge SKILLS and UNPREFIXED, F/CLAUDE.md (verb count, layout, cadence line), README.md, docs/integration-contract.md conformance list; checks/ceremony-surfaces PHASES covers only audit/document spines and checks/vendored-layer derives payload skills from the folder, so neither needs dashboard; no listing outside the task's files names the vendored verbs.


# Sprint certification

Ledger: `.ok-planner/review/runs/converge-2026-10-05T045158.jsonl` (run folder beside it).

- **mode**: sprint, `.ok-planner/sprints/2026-10-05-issue-dashboard.md`, base `3617c7b0bb532abf98ed6f6a7c05740b32a3c820`. The find loop ran once: one review (root plus seven passes: three completion, three regression, one alignment), six build-noticed reports, the checks, and a drive of three stories.
- **hunt**: drive: `rule-on-the-whole-intake` achieved (page, JSON routes, issues CLI, `/dashboard`, `/plan-sprint` Frame); `discuss-an-issue` achieved (issues CLI, JSON routes, `/triage-issues` respond phase, `/dashboard`); `see-new-analysis` failed on the page and the CLI (2 failures, both sorted `defect`, merged as one defect i23; their second divergence became question i25). Reports: 15 merged or rejected (7 merged; 6 build-noticed reports rejected as already fixed by a later stage), 0 backlog, 0 judgment, 0 upstream.
- **sprint**:
  - WI1 intake module (`.ok-planner/bin/issues` = `scripts/issues::main`): works end to end.
  - WI2 filers and readers through the module, with I1 (`review backlog` = `scripts/review::cmd_backlog`, owner list, judge, extractor, `/document` walk, `/discover-design`, `/plan-sprint`, sprint archive step, build prompt): works after fixes i24 and i27.
  - WI3 `/triage-issues` on the store, with the respond phase (`skills/triage-issues/SKILL.md`): works.
  - WI4 rules and documents, with I2 (artifact definitions, cheatsheet, estate CLAUDE template and the rest): works.
  - WI5 `/ok` intake migration (`admin/converge` diagnose and resolve `legacy-intake`, `markdown-intake`, `tensions`): works after fix i29; the import-then-move atomicity defect i30 is stuck and backed out (see intake).
  - WI6 service (`python3 .ok-planner/bin/dashboard` = `scripts/dashboard::main`): works.
  - WI7 tracker page (`browser/src/main.js`): works after fixes i23 and i28.
  - WI8 pinned build (`/release` build step, `admin/converge` placement and diagnose): works.
  - WI9 `/dashboard` skill (`skills/dashboard/SKILL.md`): works.
  - Behavior changes judged: 22 listed (14 rewrite, 6 migrate, 2 preserve); none became a defect. Two unlisted changes (promoted defect issues entering the backlog) became defect i24. Seven unlisted changes that meet every user's goal are recorded below.
  - Stories driven: 3 (page, JSON routes, issues CLI, and skill surfaces).
  - Checks: `node .ok-planner/bin/plumbline` passed on every changed file before and after the fix loop; `checks/run` passes.
  - Reports sent to the intake as outside the sprint's scope: none.
- **fixed**: 6 verified (A3: i23, i28, i29; R4: i24; R2: i27), 0 declined, 2 duplicate (i31, i32 of i24), 1 stuck (A1: i30). Fix rounds: 2. Send-backs: i30 twice (verifier t22 sent back round 1; round-2 fixer t24 closed partial needing `admin/ADMINISTRATION.md`).
- **ledger**: `.ok-planner/review/runs/converge-2026-10-05T045158.jsonl`.
- **intake** (owner list t27, then `/triage-issues` run `.ok-planner/tasks/triage-issues-2026-10-05T052511.jsonl`):
  - `2026-10-05-122352-markdown-intake-import-then-move-half-change` (design): stuck defect i30. Last note: the round-1 fix was sent back by its verifier; the round-2 fix needed `admin/ADMINISTRATION.md` outside its files. Backout t25 closed `done`. Triage: question; recommended: keep the import first and make the offers finish the move for a source whose record already stands.
  - `2026-10-05-122352-review-project-facts-omit-opened-key` (tooling, a declaration left alone): triage question with a generated ruling to add the `--opened`/`?opened=` forms to `.ok-planner/review/project.md`.
  - `2026-10-05-122352-revise-writes-no-update-message` (product-intent, question i25): triage recommended amending `story:see-new-analysis` so any revision of a routed or ruled issue reaches the owner as new analysis.
  - `2026-10-05-122352-unread-view-lists-closed-issues` (product-intent, question from i39): triage recommended amending `story:see-new-analysis` so an unread answer on a closed issue stays new, shown marked closed.
  - No `environment` failures; nothing set to `judgment` or `upstream` by the merge; 6 build-noticed reports rejected as already fixed. Noticed i41 (owned-paths at the backed-out i30 site) not filed: `checks/run` passes after the backout.
  - Unlisted calls, recorded: `scripts/review::OWNER_PATHS`/`main` (dashboard classed suite; module refusals caught); `skills/document/SKILL.md` close-out commits the store; `skills/triage-issues/SKILL.md` veto restores by filing again; `skills/converge/SKILL.md` preconditions stop on the module's refusal; `admin/converge::offers` ordering; `admin/converge::expected` requires a built `browser/dist/` (two calls).
- **cost**: converge run 2,215,528 tokens over 27 tasks; triage run 213,597 tokens over 2 tasks; build run 2,112,903 tokens over 12 tasks.
