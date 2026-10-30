# Completion report: Fifth intake drain

Sprint: `.ok-planner/sprints/2026-10-23-fifth-intake-drain.md`

## Stages

- t1 — closed-stamp. closed-stamp-frontmatter-parse-copied — done
- t2 — docs-window-unmatched. docs-window-skips-class-with-no-declaring-line; story:reference-names-the-public-surface — done
- t3 — tracker-drop. task-tracker-cannot-drop-an-item; decision:dropped-items-stay-in-the-record; concept:task-tracker — done
- t4 — revision-fixes. plan-tests-fixes-a-finding-by-rebuilding-the-planner; plan-tests-rejects-a-malformed-scenario-id-only-at-assembly; decision:scenario-list-decided-once — done
- t5 — call-kinds. plan-tests-approval-shows-the-whole-plan-unsorted; decision:legacy-suites-sorted-automatically — done
- t6 — ok-version. ok-version-reports-installed-not-loaded-version; story:see-governing-versions — done
- t7 — fences. delta-body-inner-fence-breaks-certification; story:certify-completion — done
- t8 — retired-docspec. retired-docspec-leaves-documentation-behind; decision:docspec-stamp-opens-the-window; decision:documentation-claim-ledger; story:keep-documentation-current — done
- t9 — issues-marks-ledger. issues-show-hides-edited-and-withdrawn-marks; first-comment-does-not-seed-read-ledger; story:see-new-analysis; decision:read-marks-kept-per-person — done
- t10 — back-out. ok-outcome-after-declined-second-plan; decision:true-up-asks-once-before-destructive-steps — done
- t11 — tests-folders. tests-window-ignores-declared-folders; story:project-spans-folders; decision:project-declares-its-folders — done
- t12 — dom-picker. dom-picker-reference-carries-prose-comments — done
- t13 — scope-programs. plan-tests-asks-the-owner-after-the-planners-run; decision:scenario-list-decided-once; decision:tests-check-scenarios — done
- t14 — close-commit. sprint-close-commit-omits-discovery-move; story:plan-a-sprint — done
- t15 — build-prompt. sprint-build-prompt-has-no-assembly-command; decision:single-source-transclusion — done
- t16 — support-first. test-write-tasks-chain-on-shared-support-files; decision:test-support-written-before-tests; decision:team-execution-cold-gate; decision:test-loop-fixes-code-never-tests — done
- t17 — edit-hook. edit-hook-skips-bash-and-notebook-edits; story:edit-time-lint-enforcement; decision:edit-hook-blocks-in-turn — done
- t18 — runtime-ids-retire. plan-tests-rejects-a-malformed-scenario-id-only-at-assembly; plan-tests-offers-retire-on-a-first-plan — done
- t19 — discovery-both-answers. discovery-question-on-proposed-artifact-drafts-nothing; decision:corpus-audit-hands-a-discovery-to-planning; story:bootstrap-design-corpus — done
- t20 — fixing-loop. fix-task-closed-done-leaves-defect-fixing; story:catch-broken-promises; decision:converge-finds-then-fixes — done
- t21 — fixture-sort. test-sort-decides-fixtures-before-adoptions; story:retire-a-legacy-suite; decision:legacy-suites-sorted-automatically — done
- t22 — dashboard-place. dashboard-skill-places-no-missing-build; decision:pinned-build-placed-at-true-up — done
- t23 — runner-limit. plan-tests-declares-the-runner-before-planning; decision:scenario-list-decided-once; decision:test-loop-fixes-code-never-tests — done
- t24 — scenario-definition. plan-tests-caps-each-story-way-at-one-scenario-per-program; decision:tests-check-scenarios — done
- t25 — docs-complete-claims. docs-complete-passes-with-no-claim-checked; decision:documentation-claim-ledger — done
- t26 — vetoes. test-sprint-veto-of-deletion-has-no-effect; test-sprint-veto-filed-without-ruling; doc-sprint-veto-filed-without-ruling; story:veto-calls-made-in-my-absence; decision:converge-close-takes-vetoes — done
- t27 — sign-off-settled. sign-off-review-raises-settled-findings-again; story:plan-a-sprint — done
- t28 — drain. drain-loop-wakes-the-session-on-every-agent-return; decision:drain-runs-as-a-workflow-script; decision:no-execution-engine; decision:task-tools-mirror-the-report; decision:team-execution-cold-gate — done
- t29 — docstring-lint. lint-passes-python-docstrings-anywhere; decision:comments-forbidden-by-default; story:declare-project-documentation — done
- t30 — review-stories. review-stories-refuses-missing-stories-folder; story:find-and-fix-defects — done
- t31 — doc-reader-rule. doc-edit-rules-ignore-reader-and-covers; doc-planner-output-names-wrong-reshape-step; decision:documentation-edits-only-where-a-rule-fires; story:keep-documentation-current — done
- t32 — drive-start. failed-drive-start-tears-down-another-runs-stack; story:concurrent-stacks-without-port-collisions; story:fresh-artifacts-per-run; decision:run-artifacts-removed-with-the-run; story:find-and-fix-defects — done
- t33 — confirm-note. confirm-drive-per-defect-or-per-story; decision:drive-tries-each-story-as-a-user — done
- t34 — whole-file-runner. file-level-runner-sorts-legacy-files-whole; story:retire-a-legacy-suite; decision:legacy-suites-sorted-automatically — done
- t35 — docker-timeouts. port-lease-hangs-on-hung-docker; story:concurrent-stacks-without-port-collisions — done
- t36 — surface-corpus. surface-corpus-skips-subjects-and-practices; story:record-coding-practices — done
- t37 — groups. plan-tests-files-one-planner-per-story; decision:scenario-list-decided-once — done
- t38 — planner-reviews. plan-tests-reviews-a-whole-plan-with-one-agent; decision:tests-check-scenarios — done
- t39 — widen. plan-tests-cannot-widen-an-approved-plan; decision:scenario-list-decided-once; decision:tests-check-scenarios; decision:records-stay-out-of-context — done
- t40 — docspec-conversion. true-up-moves-document-types-without-converting; decision:whole-file-ownership — done
- t41 — issue-shape. issue-shape-gives-judgment-issues-a-bug-lead; decision:issues-read-cold-before-the-owner — done

## Calls

| id | kind | stage or role | site | choice |
|---|---|---|---|---|
| i1 | improvement | surface-corpus | plugins/ok/families/ok-planner/scripts/surface-corpus::__main__ | I402: __main__ owner frame emits SURFACE.CORPUS.FAILED and exits 1 |
| i2 | call | surface-corpus | plugins/ok/families/ok-planner/scripts/surface-corpus::load_discover | load_issues renamed load_discover; discover loads in __main__ before main's usage check |
| i3 | call | surface-corpus | plugins/ok/families/ok-planner/scripts/surface-corpus::gather | @story: record-coding-practices annotation placed on gather |
| i4 | call | issues-marks-ledger | plugins/ok/families/ok-planner/scripts/issues::set_flag | set_flag seeds by calling reading_ledger, not a copy of its try/except |
| i5 | call | issues-marks-ledger | plugins/ok/families/ok-planner/scripts/issues::message_line | earlier texts print as one 8-space indented block each under '    earlier:', with no separator |
| i6 | call | close-commit | plugins/ok/families/ok-planner/skills/plan-sprint/sprint-document.md::The archive and the commit ste | git status adds --untracked-files=all and says old paths list as deleted, new paths under history/ |
| i7 | call | close-commit | plugins/ok/families/ok-planner/admin/retired-boilerplate.json | seven replaced v28.0.0 lines joined the history, sorted; checks/sprint-boilerplate passes |
| i8 | noticed | close-commit | plugins/ok/families/ok-planner/skills/_sprint/shared.md:434 | left as written |
| i9 | improvement | closed-stamp | plugins/ok/families/ok-planner/scripts/review::sprints_closed_since | I501: one sprints_closed_since and one is_ancestor in review; docs and tests call them |
| i10 | improvement | closed-stamp | plugins/ok/families/ok-planner/scripts/review::with_closed_stamp | I502: the writer drops every closed: key line before writing the stamp |
| i11 | call | closed-stamp | plugins/ok/families/ok-planner/scripts/review::frontmatter_values | one parse: frontmatter_end and frontmatter_values; frontmatter_value takes the first value, closed_s |
| i12 | call | closed-stamp | checks/oscillation::load_family_script | the check loads the family's review as a module via load_family_script and reads the archive path fr |
| i13 | call | docs-window-unmatched | plugins/ok/families/ok-planner/scripts/docs::window_entry | declaring-file reasons read each declaring path once |
| i14 | call | fences | plugins/ok/families/ok-planner/scripts/review::body_opening | a body opener reads its info string trimmed, so an indented or spaced opener such as three backticks |
| i15 | call | fences | plugins/ok/families/ok-planner/scripts/review::sprint_deltas | a sidecar delta's broken flag is False, not a missing field |
| i16 | call | fences | plugins/ok/families/ok-planner/scripts/review::delta_failure | the broken-body reason returns before any read, the Retire branch included |
| i17 | call | fences | plugins/ok/families/ok-planner/scripts/review::opens_with_run | an inner line indented four or more spaces does not break the body |
| i18 | call | fences | plugins/ok/families/ok-planner/scripts/review::inline_body | checked every sprint under sprints/ and history/sprints/: all 584 deltas read the same body and fail |
| i19 | call | revision-fixes | plugins/ok/families/ok-planner/scripts/tests::assembled_plan | origins also maps ("story", slug) to that story's latest planner task, so the stamp-recorded-but-unp |
| i20 | call | revision-fixes | plugins/ok/families/ok-planner/scripts/tests::rested | each failure that rests on an item starts with '<item id> (task <task id>): ' |
| i21 | call | revision-fixes | plugins/ok/families/ok-planner/skills/plan-tests/SKILL.md::5. Plan | the 'Fixing a planner's items' paragraph closes step 5 (Plan), just before the owner's-answers step; |
| i22 | call | revision-fixes | plugins/ok/families/ok-planner/skills/plan-tests/SKILL.md::Fixing a planner's items | a rename also sets the new id in a legacy support item's scenarios list |
| i23 | call | revision-fixes | plugins/ok/families/ok-planner/skills/plan-tests/core.md::{{TEST-REVISION-RULE}} | the block tells a revising agent to refile each earlier question at state open, and to raise no new  |
| i24 | improvement | call-kinds | plugins/ok/families/ok-planner/scripts/tests::main | I2: tests plan refuses --json unless --show or --questions is given |
| i25 | call | call-kinds | plugins/ok/families/ok-planner/scripts/tests::print_plan | the 'Planned against commit' line stays above the summary as the output's header |
| i26 | call | call-kinds | plugins/ok/families/ok-planner/scripts/tests::print_summary | kind and setup pairs read the scenario's kind and setup fields, which the runner-limit stage copies  |
| i27 | call | call-kinds | plugins/ok/families/ok-planner/scripts/tests::plan_failures | a call refusal names the call's site and its item and task through origins keyed by the call's index |
| i28 | call | call-kinds | plugins/ok/families/ok-planner/scripts/tests::USAGE | the help text for tests plan --show names the summary and what --json prints |
| i29 | improvement | retired-docspec | plugins/ok/families/ok-planner/scripts/docs::cmd_stamp | I202: cmd_stamp keeps only prior claims under the docspec's current Where |
| i30 | call | retired-docspec | plugins/ok/families/ok-planner/scripts/docs::window_entry | window_entry takes the parsed spec, the tree's file set, and covered_now; cmd_window lists the tree  |
| i31 | call | retired-docspec | plugins/ok/families/ok-planner/scripts/docs::window_entry | left and taken are computed only where the Where at the stamp differs from the current Where |
| i32 | call | retired-docspec | plugins/ok/families/ok-planner/scripts/docs::blob_held | the probe and git show read <commit>:./<path>, relative to the project root |
| i33 | call | retired-docspec | plugins/ok/families/ok-planner/scripts/docs::last_holding_commit | no HEAD, no commit touching the path, or a deleting commit with no parent reads as no holding commit |
| i34 | noticed | retired-docspec | plugins/ok/families/ok-planner/scripts/docs::cmd_example | left as written |
| i35 | call | tests-folders | plugins/ok/families/ok-planner/scripts/review::project_folders | project_folders and declared_folders take the tool and reader names, defaulting to the review's |
| i36 | call | tests-folders | plugins/ok/families/ok-planner/scripts/tests::window_entry | window_entry takes the folders as a parameter; tests window reads the config, plan_failures passes t |
| i37 | call | tests-folders | plugins/ok/families/ok-planner/scripts/tests::plan_folders | a plan with no folders list is refused with an InputError naming tests plan |
| i38 | call | tests-folders | plugins/ok/families/ok-planner/scripts/tests::changed_since | both lists come back in the root-relative form, normpath'd at tree_files and changed_since |
| i39 | call | tests-folders | plugins/ok/families/ok-planner/scripts/plumbline::testPathsCmd | confirmed: plumbline test-paths classifies ../<folder>/ paths as the lint's no-tests check does |
| i40 | noticed | tests-folders | plugins/ok/families/ok-planner/scripts/tests::test_paths | left as it stands: node missing from PATH ends tests in an internal error |
| i41 | improvement | docs-complete-claims | plugins/ok/families/ok-planner/scripts/docs::complete_failures | I201: a check item's existing file needs a non-generator claim of any scope |
| i42 | noticed | docs-complete-claims | plugins/ok/families/ok-planner/skills/plan-docs/core.md::{{DOC-CHECK-PROMPT}} | left as it stands; outside this stage's files |
| i43 | call | build-prompt | plugins/ok/families/ok-planner/scripts/review::assembled_lines | a missing block named inside a block is refused naming the block that names it |
| i44 | call | build-prompt | plugins/ok/families/ok-planner/scripts/review::headless | the header drop reads the block's first stored line; the dedent is textwrap.dedent over the remainin |
| i45 | call | build-prompt | plugins/ok/families/ok-planner/scripts/review::cmd_prompt | confirmed all ten converge prompts come out byte for byte the same, with and without --sprint/--base |
| i46 | call | scope-programs | plugins/ok/families/ok-planner/skills/plan-tests/SKILL.md::5. The owner's inputs | registers story, runtime, sort, programs, review and declares scope; plan-review and the stories poo |
| i47 | call | scope-programs | plugins/ok/families/ok-planner/scripts/tests::print_plan | the Scope line prints first, above the 'Planned against commit' header |
| i48 | call | scope-programs | plugins/ok/families/ok-planner/scripts/tests::print_plan | the scenario listing shows each scenario's entry beside its reach |
| i49 | call | scope-programs | plugins/ok/families/ok-planner/scripts/tests::plan_failures | the no-entry refusal covers every final new and rewrite; the scope and unguarded refusals cover only |
| i50 | call | scope-programs | plugins/ok/families/ok-planner/scripts/tests::planning_scope | said is optional; a scope item with no said reads as empty words |
| i51 | call | scope-programs | plugins/ok/families/ok-planner/skills/plan-tests/core.md::{{TEST-RUNTIME-PLANNER-PROMPT}} | the runtime planner keeps a recorded scenario whose rewrite would leave the scope, with a scope call |
| i52 | call | scope-programs | plugins/ok/families/ok-planner/skills/plan-tests/SKILL.md::6. Plan | step 6 names the planner inputs once as <the inputs> and splices them into each story, runtime, and  |
| i53 | call | back-out | plugins/ok/families/ok-planner/admin/true-up::json_text | write_json became json_text, the one JSON serializer the citation-tags answer and the answer record  |
| i54 | call | back-out | plugins/ok/families/ok-planner/admin/true-up::write_record | .cache/.gitignore is written through write_owner, not open() as scripts/tasks writes it |
| i55 | call | back-out | plugins/ok/families/ok-planner/admin/true-up::back-out | stands: lines print after the backed-out lines and after the backed-out: nothing line alike |
| i56 | call | back-out | plugins/ok/families/ok-planner/admin/true-up::trial_plan | a child diagnose that prints no PLAN: line ends back-out with exit 1, the tried answer written back |
| i57 | call | back-out | plugins/ok/families/ok-planner/admin/true-up::back-out | the record is rewritten after each kept restore; once no destructive step remains, older answers go  |
| i58 | call | back-out | plugins/ok/families/ok-planner/admin/true-up::back-out | the stray-path refusal applies only to restorable entries |
| i59 | call | back-out | plugins/ok/families/ok-planner/admin/true-up::prior_state | prior bytes and digests are read and hashed as raw bytes, not through read_owner or read_text |
| i60 | call | fixing-loop | plugins/ok/families/ok-planner/scripts/tasks::cmd_batch | batch_mark records the --mark value, which defaults to batched, so every batched task carries one |
| i61 | call | fixing-loop | plugins/ok/families/ok-planner/scripts/tasks::check_sweep | the refusal counts --item settlements on the same close and skips dropped items |
| i62 | call | fixing-loop | plugins/ok/families/ok-planner/scripts/review::cmd_verifies | the fixing list is a flat list of defect ids, in first-seen order |
| i63 | improvement | support-first | plugins/ok/families/ok-planner/scripts/tests::HOLDING_ROLES | I101: one HOLDING_ROLES constant serves complete_failures twice and stage_write's holders_of, which  |
| i64 | call | support-first | plugins/ok/families/ok-planner/scripts/tests::stage_support | a support task cites helpers:<item id> for each helpers item its brief names |
| i65 | call | support-first | plugins/ok/families/ok-planner/scripts/tests::write_refusals | --stage write also refuses where a support task closed done and left a helpers item its brief named  |
| i66 | call | support-first | plugins/ok/families/ok-planner/scripts/tests::stage_support | one support task per path per call carries both the scenarios no support task served and the fresh h |
| i67 | call | support-first | plugins/ok/families/ok-planner/scripts/tests::stage_write | a blocked test task is refiled only once every open helpers item it filed is in a support task's bri |
| i68 | call | support-first | plugins/ok/families/ok-planner/skills/plan-tests/core.md::TEST-WRITE-PROMPT | the test task's helpers item add carries --task <task> |
| i69 | call | support-first | plugins/ok/families/ok-planner/skills/plan-tests/core.md::TEST-SWEEP-PROMPT | the sweep prompt names support files and retired tests among the strays it settles |
| i70 | improvement | vetoes | plugins/ok/families/ok-planner/skills/_sprint/shared.md::{{CEREMONY-VETO}} | I102: one CEREMONY-VETO block holds the veto filing and the ruling once, with <rows> and <problem> |
| i71 | improvement | vetoes | plugins/ok/families/ok-planner/skills/_sprint/shared.md::{{CEREMONY-VETO}} | I203: landed as the one CEREMONY-VETO block, not a second CEREMONY-VETOES name |
| i72 | noticed | vetoes | plugins/ok/families/ok-planner/CLAUDE.md::Layout skills/_sprint/shared.md | left as is; outside this stage's files |
| i73 | improvement | runtime-ids-retire | plugins/ok/families/ok-planner/scripts/tests::plan_failures | I1: tests plan refuses rewrite of a scenario the stamp did not record |
| i74 | improvement | edit-hook | plugins/ok/families/ok-planner/scripts/hooks/post-edit.js::main | I303: main runs lintStage inside a catch-all that exits 0 |
| i75 | call | edit-hook | plugins/ok/families/ok-planner/scripts/plumbline::cellSource | map each source line to the file line of the source element it starts in, not element k for line k |
| i76 | call | edit-hook | plugins/ok/families/ok-planner/scripts/plumbline::readNotebook | validate with JSON.parse, then read positions with a scanner that assumes valid JSON |
| i77 | call | edit-hook | plugins/ok/families/ok-planner/scripts/plumbline::runLint | runLint keeps its read catch around lintSources; checkCitationResolution reads through lintSources u |
| i78 | call | edit-hook | plugins/ok/families/ok-planner/scripts/hooks/post-edit.js::editedFile | cite story:edit-time-lint-enforcement and decision:edit-hook-blocks-in-turn at editedFile |
| i79 | call | fixture-sort | plugins/ok/families/ok-planner/scripts/tests::assembled_plan | support is derived after the owner's answers apply |
| i80 | call | fixture-sort | plugins/ok/families/ok-planner/scripts/tests::reads | a <path>::<name> user also matches a kept test at that path with no name |
| i81 | call | fixture-sort | plugins/ok/families/ok-planner/scripts/tests::sorted_support | a support entry with no users stays support and is refused, not deleted |
| i82 | call | fixture-sort | plugins/ok/families/ok-planner/scripts/tests::plan_failures | the delete/port refusal covers only an entry that names its file whole |
| i83 | call | fixture-sort | plugins/ok/families/ok-planner/scripts/tests::print_plan | users print on any legacy entry that holds them |
| i84 | call | fixture-sort | plugins/ok/families/ok-planner/scripts/tests::USAGE | tests plan's help names the fixture sort and its two refusals |
| i85 | call | discovery-both-answers | plugins/ok/families/ok-planner/scripts/discover::question_section | the stale answer's line reads 'creates' for a new op instead of the malformed 'news' |
| i86 | call | discovery-both-answers | plugins/ok/families/ok-planner/scripts/discover::answer_body_failures | the stale and wrong body checks share one helper; the stale failure texts read as before |
| i87 | improvement | sign-off-settled | plugins/ok/families/ok-planner/skills/_shared/design-doc-compliance-reviewer.md::{{DESIGN-DOC-COMPLI | I503: delete the Your job sentence about filing judgment findings to the intake |
| i88 | call | runner-limit | plugins/ok/families/ok-planner/skills/plan-tests/SKILL.md::9. The runner check | the no-change re-plan is a revision refile of the scenario's latest planner task under 'Fixing a pla |
| i89 | call | runner-limit | plugins/ok/families/ok-planner/skills/plan-tests/SKILL.md::Fixing a planner's items | every reassembly after a fix also reruns the runner check, so the check follows the last assembly af |
| i90 | call | runner-limit | plugins/ok/families/ok-planner/skills/plan-tests/core.md::{{TEST-STORY-PLANNER-PROMPT}} | an outcome no form the command runs within the limit reaches gets no test and one untested call; the |
| i91 | call | runner-limit | plugins/ok/families/ok-planner/scripts/tests::scenario_of | kind and setup join the part, class, harm loop: copied only where the item holds them; entry stays a |
| i92 | call | runner-limit | plugins/ok/families/ok-planner/scripts/tests::USAGE | declare's help names testing.timeout and its 600-second default; plan's help names the kind and setu |
| i93 | improvement | review-stories | plugins/ok/families/ok-planner/scripts/tests::story_slugs | I504: tests deletes its story_slugs copy and calls review.story_slugs |
| i94 | improvement | review-stories | plugins/ok/families/ok-planner/scripts/review::certification_failures | I505: certification_failures reads if story_slugs(root): |
| i95 | call | review-stories | plugins/ok/families/ok-planner/scripts/tests::main | B511's unlistable-folder message prints as 'tests: cannot list ...', not 'tests: internal error: can |
| i96 | call | dashboard-place | plugins/ok/families/ok-planner/scripts/dashboard::placed_build | B306: the routine's Unplaceable message names the missing index.html or ignore file, or the non-UTF- |
| i97 | improvement | dashboard-place | checks/owned-paths::check_dashboard | I301: owned-paths reads scripts/dashboard and checks every write of the placement routine |
| i98 | call | dashboard-place | plugins/ok/families/ok-planner/skills/dashboard/SKILL.md::2. Place the page build | no @decision citation in the vendored skill: checks/materialized-standalone refuses it |
| i99 | call | dashboard-place | plugins/ok/families/ok-planner/scripts/dashboard::unplaced | unplaced returns and write_build takes extras as paths relative to dest |
| i100 | call | dashboard-place | plugins/ok/families/ok-planner/scripts/dashboard::place | place also refuses a symlinked or non-folder .ok-planner/dashboard, and words the unstamped refusals |
| i101 | call | dashboard-place | plugins/ok/families/ok-planner/admin/true-up::materialize | the build's files are written after the other non-executables, through write_build; lines and count  |
| i102 | improvement | drive-start | plugins/ok/families/ok-planner/skills/converge/prompts/drive.md::Confirm, where your brief says so | I601: a confirm driver blocked by the stack leaves the defect verified and unconfirmed, with a note |
| i103 | call | drive-start | plugins/ok/families/ok-planner/skills/converge/prompts/drive.md::Confirm, where your brief says so | the blocked-by-the-stack bullet applies only where every other story the brief names was achieved or |
| i104 | call | drive-start | plugins/ok/families/ok-planner/skills/converge/SKILL.md::In drive mode step 1 | 'skip steps 2 to 5' becomes 'skip steps 2 to 6', so a project with no story still skips the merge, n |
| i105 | call | drive-start | plugins/ok/families/ok-planner/skills/converge/SKILL.md::In drive mode step 4 | the stop is filed where review drive-stack printed stack and step 2's start passed |
| i106 | call | drive-start | plugins/ok/families/ok-planner/skills/converge/SKILL.md::In drive mode step 2 | the session's own environment failure line, after a drive-start task closes unfinished twice, is spe |
| i107 | call | whole-file-runner | plugins/ok/families/ok-planner/scripts/tests::assembled_plan | under a whole-file runner, tests of one file adopted into one scenario stand together; only a second |
| i108 | call | whole-file-runner | plugins/ok/families/ok-planner/scripts/tests::assembled_plan | under a whole-file runner, every adopt scenario's test loses its name, a sort-recorded adopt scenari |
| i109 | call | whole-file-runner | plugins/ok/families/ok-planner/scripts/tests::stage_write | a legacy brief for a file a live scenario holds whole tells the task to keep every test the brief do |
| i110 | call | whole-file-runner | plugins/ok/families/ok-planner/skills/plan-tests/core.md::TEST-SORT-PROMPT | a claimed file sorts each test no scenario names under a {name} runner, and each test checking none  |
| i111 | improvement | drain | plugins/ok/families/ok-planner/skills/_tasks/drain.md::The loop | I401: the hand form waits while an agent it started runs |
| i112 | call | drain | plugins/ok/families/ok-planner/skills/_tasks/drain.md::The Workflow form | no @decision annotation in drain.md: checks/materialized-standalone refuses it |
| i113 | call | drain | plugins/ok/families/ok-planner/skills/_tasks/drain.md::script drain | script returns failed on a nonzero tracker command or unreadable next output |
| i114 | call | drain | plugins/ok/families/ok-planner/skills/_tasks/drain.md::script settle | script waits for every agent still in flight before it returns |
| i115 | call | drain | plugins/ok/families/ok-planner/skills/_tasks/drain.md::script stuck | stuck compares next's count with the count next listed when the returning agent started |
| i116 | call | drain | plugins/ok/families/ok-planner/skills/_tasks/drain.md::script fill | exec steps share the window and the one-start-per-return rule, first printed line first |
| i117 | call | drain | plugins/ok/families/ok-planner/skills/_tasks/drain.md::When it returns | Workflow form marks only done closes on the checklist; in-progress stays the caller's at drain start |
| i118 | call | drain | plugins/ok/families/ok-planner/scripts/tasks::USAGE | the opening paragraph's count sentence stays; the next usage lines carry the new format |
| i119 | call | docstring-lint | plugins/ok/families/ok-planner/scripts/plumbline::PYTHON_STRING_PREFIX_RE | string prefixes are Python's valid set: r, u, b, f alone, or r paired with b or f in either order an |
| i120 | call | docstring-lint | plugins/ok/families/ok-planner/scripts/plumbline::commentRefusal | a new allow-docstrings marker and a citation line keep their own messages inside a docstring; every  |
| i121 | call | docstring-lint | checks/owned-paths::unquote | deleted all 15 docstrings the fixed lint refuses, re-enumerated after earlier stages moved lines |
| i122 | call | groups | plugins/ok/families/ok-planner/scripts/tests::cmd_groups | tests groups refuses a run whose programs task raised a question the owner has not answered |
| i123 | call | groups | plugins/ok/families/ok-planner/scripts/tests::cmd_groups | the groups file and the verb's output carry the inputs line and the last-run path, and print 'runtim |
| i124 | call | groups | plugins/ok/families/ok-planner/scripts/tests::assembled_plan | the untouched keep covers a recorded scenario whose story no group lists and no planner planned, and |
| i125 | call | groups | plugins/ok/families/ok-planner/scripts/tests::assembled_plan | a sort adoption into any auto-kept recorded gap turns it into adopt, the runtime keep where no runti |
| i126 | call | groups | plugins/ok/families/ok-planner/scripts/tests::plan_failures | plan_failures takes runtime_ran as a parameter; the plan records stories but no runtime flag |
| i127 | call | groups | plugins/ok/families/ok-planner/scripts/tests::planning_items | a story task's question belongs to the story of the scenario it names among that task's own scenario |
| i128 | call | groups | plugins/ok/families/ok-planner/scripts/tests::cmd_groups | tests groups takes no --widen; the widen stage adds it with touched_stories' widen reason |
| i129 | call | groups | plugins/ok/families/ok-planner/skills/plan-tests/SKILL.md::Fixing a planner's items | a judgment fix to a story files story:<slug> (or refiles the standing story:<slug> task) with the gr |
| i130 | call | groups | plugins/ok/families/ok-planner/scripts/tests::story_citations | the citation scan skips a file that does not decode as UTF-8 and every path under .ok-planner/ |
| i131 | call | planner-reviews | plugins/ok/families/ok-planner/skills/plan-tests/SKILL.md::11. Review | review task key is review:<the planner task's key>, the task id goes in the brief |
| i132 | call | planner-reviews | plugins/ok/families/ok-planner/skills/plan-tests/core.md::{{TEST-PLANNER-REVIEW-PROMPT}} | planner review also transcludes {{TEST-RUNTIME-CLASSES}} |
| i133 | call | planner-reviews | plugins/ok/families/ok-planner/skills/plan-tests/core.md::{{TEST-PLAN-WIDE-REVIEW-PROMPT}} | plan-wide finding names refile=<the scenario item's latest done planner task> or none; none re-plans |
| i134 | call | planner-reviews | plugins/ok/families/ok-planner/skills/plan-tests/SKILL.md::11. Review | step 11 lists the planner tasks with tasks report |
| i135 | call | planner-reviews | plugins/ok/families/ok-planner/skills/plan-tests/SKILL.md::11. Review | B18 migrate: same /plan-tests arguments, one approval; no stored state to migrate |
| i136 | improvement | docspec-conversion | docs/integration-contract.md::The ownership rule | I302: the contract lists all three filings true-up makes |
| i137 | call | docspec-conversion | plugins/ok/families/ok-planner/admin/true-up::unwritten_sections | the issue also names ## Covers where the document type held no Purpose or Covers text |
| i138 | call | docspec-conversion | plugins/ok/families/ok-planner/admin/true-up::docspec_sections | non-mapped front-matter lines move verbatim under ## Notes, after the moved sections |
| i139 | call | docspec-conversion | plugins/ok/families/ok-planner/admin/true-up::document_type_body | a ## line inside a fenced block stays text when the body splits into sections |
| i140 | call | docspec-conversion | plugins/ok/families/ok-planner/admin/true-up::rewrite_plan | a moved document type's other pending rewrites fold into its conversion at the docspec path |
| i141 | call | widen | plugins/ok/families/ok-planner/scripts/tests::earlier_calls | archived plans order newest first by stamp ancestry where both stamps are held, else by the test spr |
| i142 | call | widen | plugins/ok/families/ok-planner/scripts/tests::cmd_groups | tests groups prints 'widen: <slugs>' and, on a current window with no story touched, 'nothing to pla |
| i143 | call | widen | plugins/ok/families/ok-planner/scripts/tests::assembled_plan | the widen-only keep is a branch of the standing loop; the assembly does not refuse a keep, rewrite,  |
| i144 | call | widen | plugins/ok/families/ok-planner/skills/plan-tests/SKILL.md::1. Layout | step 1 reads the argument and refuses anything but none or widen [slugs] with the usage line; an unk |
| i145 | call | widen | plugins/ok/families/ok-planner/skills/plan-tests/core.md::{{TEST-STORY-PLANNER-PROMPT}} | the story planner reads tests calls <slug> --json as a new Read step 7, run per widen story |
| i146 | call | widen | plugins/ok/families/ok-planner/scripts/tests::touched_stories | the window's touches moved into window_touches; touched_stories adds a widen reason per widened slug |
| cert:i1 | rejected | session | plugins/ok/families/ok-planner/skills/_sprint/shared.md | shared.md archive step keeps its commit-path wording: it moves with git mv alone, so no harm |
| cert:i3 | rejected | session | plugins/ok/families/ok-planner/scripts/tests | node missing is not a correctly deployed system; the error already names node |
| cert:i8 | unlisted | pass | plugins/ok/families/ok-planner/scripts/issues::person_message | Every person write verb (rule, comment, edit, remove, unrule, flag, unflag, and the dashboard's POST |
| cert:i9 | rejected | pass | plugins/ok/families/ok-planner/skills/_tasks/drain.md | drain.md is a markdown payload; the decision forbids a citation there |
| cert:i14 | rejected | pass | plugins/ok/families/ok-planner/scripts/tests::plan_folders (B114, with B105/B106/B107/B112) | two readings of the Trued-up projects boundary; read it as leaving out an approved test sprint; aske |
| cert:i16 | rejected | pass | plugins/ok/families/ok-planner/scripts/tests::plan_folders (B114, with B105/B106/B107/B112) | two readings of the Trued-up projects boundary; read it as leaving out an approved test sprint; aske |
| cert:i21 | unlisted | pass | plugins/ok/families/ok-planner/scripts/tests::print_plan | tests plan --show's scenario listing also prints each scenario's entry after its reach; the listing' |
| cert:i22 | unlisted | pass | plugins/ok/families/ok-planner/scripts/tests::USAGE | tests --help's plan entry now names the fixture sort and its two refusals; help text only, read by p |
| cert:i23 | unlisted | pass | plugins/ok/families/ok-planner/scripts/discover::question_section | a proposed-artifact question's stale-answer line reads 'creates <artifact>' in place of the malforme |
| cert:i24 | not-owed | drive | plugins/ok/families/ok-planner/skills/converge/prompts/owner-list.md | two readings; asked the owner |
| cert:i30 | not-owed | drive | plugins/ok/families/ok-planner/skills/plan-tests/core.md | two readings; asked the owner |
| cert:i32 | not-owed | drive | plugins/ok/families/ok-planner/skills/_tasks/drain.md | two readings; asked the owner |
| cert:i44 | duplicate | merge | plugins/ok/families/ok-planner/skills/ok-version/SKILL.md:12 | duplicate of i36 |


# Sprint certification

Ledger: `.ok-planner/review/runs/converge-2026-10-24T010839.jsonl` (run folder beside it).

- **mode**: `sprint`, `.ok-planner/sprints/2026-10-23-fifth-intake-drain.md`, base `63de1624fdc141859b18739e9d04575d563c0dba`. The build run file exists; `review noticed` added 5 reports from it.
- **hunt**: the review root (t1) filed 20 passes (11 completion, 8 regression, 1 alignment); 19 closed `done` as forks, and the orphaned alignment pass (t22) was retried once and closed `done`. The drive took all 27 stories, one driver each (t23-t49), every driver closed `done`. Failures sorted: 3 `defect`, 3 `not-owed`, 8 `backlog`, 0 `environment`, 0 `judgment`, 0 `upstream`, 0 `rejected`. Reports sorted: 10 `merged`, 5 `rejected`, 1 `backlog`. The project declares no stack and no `resource-stop` line, so no stop task ran. No merge closed unfinished.
- **sprint**:
  - Work items and taken improvements: every work item and improvement the review root named reached end to end on its entry point (completion passes t3-t13, each `CHECKED`): the plan-tests scenario, runner, scope, groups, widen, reviews, call kinds, fix-in-place, runtime ids, retire, support-first, fixture and whole-file sorts (I1, I2, I101); the tracker drop, fixing loop, and Workflow drain (I401); closed stamp, declared test folders, missing stories folder (I501-I505); documentation reader/coverage, retired and moved docspecs, claim checks, reshape step, unmatched classes (I201, I202); back-out, dashboard placement, docspec conversion, ok-version annotation (I301, I302); failed drive start, confirm send-back, docker timeouts, build prompt, CommonMark fences (I601); edit hook, Python docstrings, DOM picker header, issue marks and read ledger (I303); judgment issue shape, discovery wrong body, sign-off settled, close commit, surface-corpus (I402, I503); test and documentation sprint vetoes (I102, I203). Defects found against them were fixed and verified (below).
  - Behavior changes: the 8 regression passes (t14-t21) judged the changed definitions against their users under the notes' rulings; 2 reports (i14, i16) split on a ruling's reading and went to the intake as `approved-test-sprint-across-true-up-boundary`.
  - Corpus deltas: all 20 (2 story amends, 15 decision amends, 3 new decisions) landed verbatim; `review deltas` lists every one as landed at build (alignment pass t22).
  - Stories driven: 27, each on every surface it names. Achieved whole: bootstrap-design-corpus, concurrent-stacks-without-port-collisions, declare-project-documentation, discuss-an-issue, edit-time-lint-enforcement, fresh-artifacts-per-run, project-spans-folders, record-coding-practices, rule-on-the-whole-intake, rule-the-public-surface, see-governing-versions, see-new-analysis, session-awareness, sketch-an-idea, true-up-project-estate, turn-down-a-destructive-true-up, write-time-prose-steering. Failed on a variant: catch-broken-promises (fix), certify-completion (whole), find-and-fix-defects (whole), keep-documentation-current (whole, plan-docs), plan-a-sprint (unreconciled-work), reference-names-the-public-surface (no-internal, plan-docs), retire-a-legacy-suite (drop, plan-tests), verification-leaves-no-artifacts-behind (whole, converge), veto-calls-made-in-my-absence (whole, plan-sprint), watch-execution-progress (whole, plan-sprint). The three in-scope drive defects (i38, i39, i40) were fixed, verified, and confirmed `achieved` by confirm drivers t73-t75; the rest are outside the sprint's scope and went to the intake.
  - Checks: `node .ok-planner/bin/plumbline` over the 54 changed files passed before the fix loop (t2) and after it (t78).
  - Sent to the intake as outside the sprint's scope: 11 defect issues and 5 judgment issues (listed under intake).
- **fixed**: 13 defects: 12 `verified` (A8: i36, i40, i41, i42, i45, i52; A3: i38, i39, i51; C1: i43, i46, i47), 1 `duplicate` (i44 of i36, verified), 0 `declined`, 0 `stuck`. Fix rounds: 2. Send-backs: i43 once (round 1), verified in round 2.
- **ledger**: `.ok-planner/review/runs/converge-2026-10-24T010839.jsonl`.
- **intake**: the owner list (t79) wrote 16 issues, closed none, turned none; no stuck defect and no `environment` failure. `/triage-issues` (ledger `.ok-planner/tasks/triage-issues-2026-10-24T030834.jsonl`) took 17 records (the 16 plus one a person filed during the build), answered 0, retired 0, routed 11 `defect` and 6 `question`, rewrote all 17 for clarity, and linked all 17.
  - To `/converge` (defect, generated ruling): `certified-accepts-another-sprints-ledger` (A9), `certified-base-refusal-names-a-refused-flag` (A3), `converge-return-omits-stuck-defect-id` (A8), `doc-prompts-miss-dangling-stamp-as-new` (A8), `docs-example-probes-path-from-repository-root` (A3), `merge-prompt-reads-none-as-a-sprint` (A8), `plan-sprint-drafts-rulings-before-reconcile` (A8), `ported-check-may-start-a-test-runner` (A3), `review-facts-give-no-resource-stop-line` (A5), `sprint-close-commit-omits-git-rm-removals` (A1), `sprint-close-skips-veto-when-not-complete` (A8).
  - To `/plan-sprint` (question, recommended ruling): `tests-tool-owns-the-per-test-run-loop` (the person's issue: the project owns its suite run through one generic contract), `approved-test-sprint-across-true-up-boundary` (an approved sprint runs on the release that planned it), `drive-prompt-forbids-undoing-scratch-probe-edits` (keep the git ban and name how a driver undoes a scratch edit), `legacy-sort-deletes-unwritten-rule-tests` (amend the legacy-sort decision), `owner-list-refiles-closed-judgments` (every intake writer checks the archive too), `workflow-drain-marks-stages-only-on-return` (mark each entry when the drain returns).
- **cost**: certification usage 7,929,990 tokens over 80 tasks (`tasks status`, `tasks report`); triage usage 1,398,727 tokens over 13 tasks.
