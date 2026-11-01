# Completion report: Sixth intake drain: fast, deterministic test sprints

Sprint: `.ok-planner/sprints/2026-10-30-sixth-intake-drain.md`

## Stages

- t1 — deltas. decision:settings-have-no-code-defaults; decision:every-timer-has-a-time-control; decision:gated-elements-stay-internal; decision:test-sprints-build-approved-time-controls; decision:tests-spend-time-only-on-their-outcome; decision:tests-isolated-unless-declared; decision:scenario-list-decided-once; decision:test-loop-fixes-code-never-tests; decision:legacy-suites-sorted-automatically; decision:intake-writers-are-gated; decision:live-sprints-brought-current-on-true-up; decision:surface-intent-changed-by-sprints; decision:project-declares-its-folders; decision:accept-list-decides-defects; story:watch-execution-progress; concept:sprint — done
- t2 — w15-drive. W15; issue:drive-prompt-forbids-undoing-scratch-probe-edits — done
- t3 — w27-marker. W27; issue:lint-committed-marker-check-misses-subfolder-roots; decision:filesystem-discovery-markers — done
- t4 — w16-w17-certified. W16; W17; story:certify-completion; issue:certified-accepts-another-sprints-ledger; issue:certified-base-refusal-names-a-refused-flag — done
- t5 — w18-w21-converge. W18; W21; decision:sprint-goal-read-from-the-repository; story:catch-broken-promises; issue:converge-return-omits-stuck-defect-id; issue:merge-prompt-reads-none-as-a-sprint — done
- t6 — w25-w26-close. W25; W26; story:plan-a-sprint; decision:converge-close-takes-vetoes; decision:live-sprints-brought-current-on-true-up; issue:sprint-close-commit-omits-git-rm-removals; issue:sprint-close-skips-veto-when-not-complete — done
- t7 — w19-w20-docs. W19; W20; decision:docspec-stamp-opens-the-window; decision:documentation-claim-ledger; story:keep-documentation-current; issue:doc-prompts-miss-dangling-stamp-as-new; issue:docs-example-probes-path-from-repository-root — done
- t8 — w22-reconcile. W22; story:plan-a-sprint; issue:plan-sprint-drafts-rulings-before-reconcile — done
- t9 — w9-reader. W9; W10; decision:settings-have-no-code-defaults; decision:every-timer-has-a-time-control; decision:project-declares-its-folders — done
- t10 — w24-facts. W24; decision:run-artifacts-removed-with-the-run; issue:review-facts-give-no-resource-stop-line — done
- t11 — w9-lint-review. W9; decision:settings-have-no-code-defaults; decision:project-declares-its-folders; decision:accept-list-decides-defects — done
- t12 — w9-true-up. W9; decision:settings-have-no-code-defaults; decision:project-declares-its-folders — done
- t13 — w13-archive. W13; decision:intake-writers-are-gated; issue:owner-list-refiles-closed-judgments — done
- t14 — w7-w8-rules. W7; W8; decision:settings-have-no-code-defaults; decision:every-timer-has-a-time-control — done
- t15 — w11-gated. W11; decision:gated-elements-stay-internal; decision:surface-intent-changed-by-sprints — done
- t16 — w2-suite. W2; decision:scenario-list-decided-once; decision:test-loop-fixes-code-never-tests; decision:settings-have-no-code-defaults; issue:tests-tool-owns-the-per-test-run-loop — done
- t17 — w3-w5-loop. W3; W5; decision:test-loop-fixes-code-never-tests; decision:tests-isolated-unless-declared; decision:scenario-list-decided-once — done
- t18 — w4-w6-controls. W4; W6; decision:test-sprints-build-approved-time-controls; decision:every-timer-has-a-time-control; concept:sprint; decision:tests-spend-time-only-on-their-outcome; issue:test-sprints-write-tests-that-wait-on-the-wall-clock — done
- t19 — w1-standard. W1; W6; decision:tests-spend-time-only-on-their-outcome; decision:test-loop-fixes-code-never-tests; issue:test-sprints-write-tests-that-wait-on-the-wall-clock — done
- t20 — w12-w23-legacy. W12; W23; decision:legacy-suites-sorted-automatically; decision:intake-writers-are-gated; issue:legacy-sort-deletes-unwritten-rule-tests; issue:ported-check-may-start-a-test-runner — done
- t21 — w14-boundary. W14; decision:live-sprints-brought-current-on-true-up; issue:approved-test-sprint-across-true-up-boundary — done

## Calls

| id | kind | stage or role | site | choice |
|---|---|---|---|---|
| i1 | call | deltas | .ok-planner/design/ | Apply all 16 corpus deltas in one stage of their own |
| i2 | call | w18-w21-converge | plugins/ok/families/ok-planner/skills/converge/prompts/merge.md::The ownership test | C3 bullet reads 'This run certifies a sprint, and the report's entry is C3.' |
| i3 | call | w22-reconcile | plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md::3. Reconcile | Opening sentence now reads 'before the dialogue builds on it' and names the rebuild of a Frame delta |
| i4 | noticed | w19-w20-docs | plugins/ok/families/ok-planner/skills/plan-tests/SKILL.md::2. Window | left as written: outside this stage's files |
| i5 | improvement | w25-w26-close | plugins/ok/families/ok-planner/skills/plan-sprint/sprint-document.md::{{SPRINT-DOCUMENT-TEMPLATE}} | I300: step 13's veto paragraph cites {{CEREMONY-VETO}} instead of restating it |
| i6 | call | w25-w26-close | plugins/ok/families/ok-planner/skills/plan-sprint/sprint-document.md::{{SPRINT-DOCUMENT-TEMPLATE}} a | the listing names both a ' D <old>' and a 'D  <old>' line as a removed path |
| i7 | call | w25-w26-close | plugins/ok/families/ok-planner/skills/plan-sprint/sprint-document.md::{{SPRINT-DOCUMENT-TEMPLATE}} s | vetoes are asked before the NOT COMPLETE failures are named and the session stops |
| i8 | call | w25-w26-close | plugins/ok/families/ok-planner/skills/_sprint/shared.md::{{CEREMONY-VETO}} | description now reads 'at the close of a sprint, a documentation sprint, or a test sprint' |
| i9 | improvement | w16-w17-certified | plugins/ok/families/ok-planner/scripts/review::declared_checks | I200: one checks validator for cmd_checks and check_failures |
| i10 | call | w16-w17-certified | plugins/ok/families/ok-planner/scripts/review::certified_sprint | return (path, reason) like approval_refusal; latest sprint-review record wins |
| i11 | call | w16-w17-certified | .ok-planner/review/project.md | no project.md entry update: certified's inputs are unchanged |
| i12 | call | w9-reader | plugins/ok/families/ok-planner/scripts/tasks::setting | setting takes an optional predicate and shape; seconds and count wrap it; every config refusal raise |
| i13 | call | w9-reader | plugins/ok/families/ok-planner/scripts/ports::declared_names | a missing ports key refuses, per the W9 table (ports, former default []) |
| i14 | call | w9-reader | plugins/ok/families/ok-planner/scripts/ports::read_config | read_config removed; ports.lease and stack.up call tasks.project_config directly |
| i15 | call | w9-reader | plugins/ok/families/ok-planner/scripts/stack::main | the owner frame catches tasks.Unset, group.tasks.Unset, and sweep.tasks.Unset |
| i16 | call | w9-reader | plugins/ok/families/ok-planner/scripts/stack::helper_timing | one timing mapping read per verb and threaded through up, down, cleanup, and their steps |
| i17 | call | w9-reader | plugins/ok/families/ok-planner/scripts/docker-sweep::main | every verb, probe and running included, reads both docker keys |
| i18 | call | w9-reader | plugins/ok/families/ok-planner/scripts/surface-corpus::main | a missing or malformed rare_share exits 2 with the reason, as an intake refusal does |
| i19 | call | w9-reader | plugins/ok/families/ok-planner/scripts/dashboard::service_settings | title and both byte limits read once before bind, kept on the server as settings |
| i20 | call | w9-reader | plugins/ok/families/ok-planner/scripts/stack::cleanup | the drive of stack cleanup in this repo took down one stale run |
| i21 | improvement | w9-reader | plugins/ok/families/ok-planner/scripts/ports::read_config | I100: ports and dashboard read config through tasks.project_config/setting |
| i22 | improvement | w9-reader | plugins/ok/families/ok-planner/scripts/dashboard::page_title | I101: a config parse error refuses at start, naming the error |
| i23 | call | w9-true-up | plugins/ok/families/ok-planner/admin/true-up::amend | amend refuses a draft missing a key of its file's table, the review config's FORMER_REVIEW_SETTINGS  |
| i24 | call | w9-true-up | plugins/ok/families/ok-planner/admin/true-up::config_questions | with no config and none to create (blocked retired estate, or a non-file at the path), config_questi |
| i25 | call | w9-true-up | plugins/ok/families/ok-planner/admin/true-up::resolve_question | citation-tags resolve with no config file writes the former-defaults table plus the citations |
| i26 | call | w9-true-up | plugins/ok/families/ok-planner/admin/true-up::config_created | create the config where none stands, no retired config moves, and no retired config is held |
| i27 | call | w9-true-up | plugins/ok/families/ok-planner/admin/true-up::seed_project_config | the creation writer sits in the review seeds region as seed_project_config(config_path) |
| i28 | call | w9-true-up | plugins/ok/families/ok-planner/admin/true-up::lint_config_transforms | the fill's detail lists missing keys dotted and is computed from the config as the earlier transform |
| i29 | call | w9-true-up | plugins/ok/families/ok-planner/admin/ADMINISTRATION.md::The core's modes | the review-estate bullet documents both review-config writes: the former-value fill and the existing |
| i30 | call | w9-true-up | plugins/ok/families/ok-planner/docs/plumbline-cheatsheet.md::Tests | the no-tests line's 'replaces the defaults' clause now says tests in config.json lists the paths, as |
| i31 | call | w13-archive | plugins/ok/families/ok-planner/admin/ADMINISTRATION.md::Callers of retired suite scripts | Also drop 'or archived' from the three other true-up filing restatements (review-facts-undecodable,  |
| i32 | call | w13-archive | plugins/ok/families/ok-planner/admin/true-up::unfiled | Read open_issue_ids() once before the comprehension rather than per issue |
| i33 | call | w7-w8-rules | plugins/ok/families/ok-planner/skills/plan-sprint/core.md::{{CODE-PLANNER-PROMPT}} | New time-control step is step 3; old steps 3-9 renumbered 4-10, with in-prompt refs updated |
| i34 | call | w7-w8-rules | plugins/ok/families/ok-planner/skills/plan-sprint/core.md::{{IMPLEMENTATION-NOTES-FORM}} | **Time controls** placed last in the form and after **New surface** in the planner output; line form |
| i35 | call | w7-w8-rules | plugins/ok/families/ok-planner/docs/plumbline-coding.md::rule 10, rule 11 | Rule 10 titled 'Read every setting from configuration, with no default', rule 11 'Give every timer a |
| i36 | improvement | w9-lint-review | plugins/ok/families/ok-planner/scripts/review::declared_folders | I100: declared_folders and project_runners read config through tasks.project_config/setting |
| i37 | improvement | w9-lint-review | plugins/ok/families/ok-planner/scripts/review::load_config | I102: load_config refuses a review config without prompts_dir, naming it |
| i38 | improvement | w9-lint-review | plugins/ok/families/ok-planner/scripts/review::project_runners | I103: a non-object or unparseable project config refuses through the shared reader |
| i39 | call | w9-lint-review | plugins/ok/families/ok-planner/scripts/plumbline::CONFIG_KEY_DEFECTS | ignore gets a validator (array of non-empty strings), and a non-array citations is a defect |
| i40 | call | w9-lint-review | plugins/ok/families/ok-planner/scripts/plumbline::unsetLintKeys | missing keys refuse at use as 'sets no <key>; run /ok, which writes it', in tasks.Unset's wording; a |
| i41 | call | w9-lint-review | plugins/ok/families/ok-planner/scripts/plumbline::folderPaths | compare entries to the root by real path, so '.', 'sub/..', or a link to the root all drop |
| i42 | call | w9-lint-review | plugins/ok/families/ok-planner/scripts/plumbline::declaredFolders | declaredFolders (inProject, the edit hook's root discovery) stays lenient: no config or no folders m |
| i43 | call | w9-lint-review | plugins/ok/families/ok-planner/scripts/review::declared_folders | an unparseable project config now refuses through tasks.project_config instead of reading the root a |
| i44 | call | w9-lint-review | plugins/ok/families/ok-planner/scripts/review::project_runners | a present testing must set runners, each a non-empty string, else refuse; testing absent adds no run |
| i45 | call | w9-lint-review | .ok-planner/review/project.md | the review tool's entry also names its new refusals (review config keys; folders, lint_checks.no-tes |
| i46 | noticed | w9-lint-review | plugins/ok/families/ok-planner/scripts/docs::main | docs, discover, and tests owner frames do not catch tasks.Unset, which review.scoped_files/project_f |
| i47 | noticed | w9-lint-review | plugins/ok/families/ok-planner/admin/true-up::config_named_keys | config_named_keys matches defects by prefix, so a stack_helpers defect also names stack |
| i48 | call | w11-gated | plugins/ok/families/ok-planner/skills/plan-sprint/core.md::{{CODE-PLANNER-PROMPT}} | gated sentence lands on the new-surface step, now step 10 after W8 inserted the time-control step |
| i49 | call | w11-gated | plugins/ok/families/ok-planner/skills/_shared/artifact-definitions.md::## Lists | 'and no gated element but one an exception makes public' |
| i50 | improvement | w2-suite | plugins/ok/families/ok-planner/scripts/tests::results_rounds | I1: a torn last line is dropped and its round reads unclosed |
| i51 | call | w2-suite | plugins/ok/families/ok-planner/scripts/tests::cmd_run | header leftovers_before and closing leftovers_after/grew written as null and []; W5 runs testing.lef |
| i52 | call | w2-suite | plugins/ok/families/ok-planner/scripts/tests::read_stream | silence restarts on each first matched result; after stdout closes, the tool waits for exit for the  |
| i53 | call | w2-suite | plugins/ok/families/ok-planner/scripts/tests::suite_outcome | a test with no recorded path, or no name under testing.named, fails before the run with seconds null |
| i54 | call | w2-suite | plugins/ok/families/ok-planner/scripts/tests::RESULT_LINE_BYTES | the result-line limit is 512 bytes, POSIX's least PIPE_BUF, stated in the usage text; unmatched line |
| i55 | call | w2-suite | plugins/ok/families/ok-planner/scripts/tests::cmd_declare | declare refuses a call naming no key and prints the keys still unset; it reads the config through ta |
| i56 | call | w2-suite | plugins/ok/families/ok-planner/admin/true-up::draft_config_defects | a config or amend draft that keeps the earlier testing exactly as the file holds it is not refused f |
| i57 | call | w2-suite | plugins/ok/families/ok-planner/admin/true-up::testing_question | the testing question is asked only once the config holds no other defect, after the other questions |
| i58 | call | w2-suite | plugins/ok/families/ok-planner/scripts/tests::main | the owner frame catches tasks.Unset beside InputError and ReviewError |
| i59 | call | w2-suite | plugins/ok/families/ok-planner/scripts/tests::review_config | B109: ports and complete refuse a review config with no checks key; a checks that is not a list is l |
| i60 | improvement | w3-w5-loop | plugins/ok/families/ok-planner/scripts/tests::main | I2: main's catch-all emits TESTS.RUN.FAILED |
| i61 | call | w3-w5-loop | plugins/ok/families/ok-planner/scripts/tests::stage_preflight | the write stage files the preflight alone and files support, test, and legacy tasks only once it clo |
| i62 | call | w3-w5-loop | plugins/ok/families/ok-planner/skills/plan-tests/test-sprint-document.md::step 4 | the tests pool declares sent-back now, for the leftovers verifier's send-back; W1 adds accepted and  |
| i63 | call | w3-w5-loop | plugins/ok/families/ok-planner/scripts/tests::leftover_counts | a failing or malformed testing.leftovers refuses with InputError; after a round it leaves the round  |
| i64 | call | w3-w5-loop | plugins/ok/families/ok-planner/skills/plan-tests/core.md::{{TEST-BUDGET-PROMPT}} | budget item fields workers, stack, sizing, files, body; limits item fields limit, how, detail, body |
| i65 | call | w3-w5-loop | plugins/ok/families/ok-planner/skills/plan-tests/core.md::{{TEST-RESOURCES-RULE}} | the resources rule is one shared block the story and runtime planners transclude |
| i66 | call | w3-w5-loop | plugins/ok/families/ok-planner/scripts/tests::unsettled_failures | a grown leftover count is never settled by a held promise or an owner issue |
| i67 | call | w3-w5-loop | plugins/ok/families/ok-planner/scripts/tests::unrewritten_tests | an accepted leftovers fix's named test counts as rewritten when a test task with its key closed done |
| i68 | call | w3-w5-loop | plugins/ok/families/ok-planner/scripts/tests::complete_failures | with a rerun round latest, complete names the rerun and skips the per-scenario did-not-run lines |
| i69 | call | w3-w5-loop | plugins/ok/families/ok-planner/scripts/tests::cmd_run | --only counts leftovers around its run with or without --sprint; --from and the planning run count n |
| i70 | noticed | w3-w5-loop | plugins/ok/families/ok-planner/CLAUDE.md::Layout | the skills/plan-tests/ layout line lists core.md's prompts without the budget and preflight prompts |
| i71 | call | w4-w6-controls | plugins/ok/families/ok-planner/scripts/tests::stage_controls | the write stage files the control tasks alone until each closed done, refiles one closed short of do |
| i72 | call | w4-w6-controls | plugins/ok/families/ok-planner/skills/plan-tests/core.md::{{TEST-STORY-PLANNER-PROMPT}} | a story planner records one controls item per story whose scenarios wait on it, with --field story=< |
| i73 | call | w4-w6-controls | plugins/ok/families/ok-planner/scripts/tests::planned_controls | items with one id merge where form, site, files, and gate are equal; the first item's body stands; u |
| i74 | call | w4-w6-controls | plugins/ok/families/ok-planner/scripts/tests::unbuilt_controls | completion needs, per plan control, a control task and a controls item recording what it built; a co |
| i75 | call | w4-w6-controls | plugins/ok/families/ok-planner/skills/plan-tests/core.md::{{TEST-WASTE-RULE}} | the named wastes live in one shared block the planners and both reviews transclude, worded from the  |
| i76 | call | w4-w6-controls | plugins/ok/families/ok-planner/skills/plan-tests/core.md::{{TEST-PLANNER-REVIEW-PROMPT}} | the planner review checks waits and time control items; the plan-wide review sends back two items th |
| i77 | call | w4-w6-controls | plugins/ok/families/ok-planner/scripts/tests::window_touches | slow touches come from the reached window, beside failed touches; a suite with no more timed tests t |
| i78 | call | w4-w6-controls | plugins/ok/families/ok-planner/scripts/tests::assembled_plan | a story whose every reason is widen or slow keeps each recorded scenario its planner names nowhere,  |
| i79 | call | w4-w6-controls | .ok-planner/review/project.md | no update to the scripts/tests entry |
| i80 | call | w4-w6-controls | plugins/ok/families/ok-planner/scripts/tests::cmd_stamp | the stamp keeps each scenario's waits, and drops it from a gap with its test |
| i81 | call | w1-standard | plugins/ok/families/ok-planner/scripts/tests::stage_verify | test verifies and the completion check read each scenario's latest tests item only |
| i82 | call | w1-standard | plugins/ok/families/ok-planner/scripts/tests::refiled_tests | a sent-back test with no test task in the run gets a fresh test task keyed by its scenario |
| i83 | call | w1-standard | plugins/ok/families/ok-planner/scripts/tests::stage_verify | the fix and promise verify chain skips test verify tasks |
| i84 | call | w1-standard | plugins/ok/families/ok-planner/skills/plan-tests/core.md::TEST-WASTE-RULE | the waste rule block cites the testing standard and keeps its wording |
| i85 | call | w1-standard | plugins/ok/families/ok-planner/scripts/ok-planner-CLAUDE.md::The tests | the test sprint summaries in the estate CLAUDE.md, the planner cheatsheet, and the family CLAUDE.md  |
| i86 | call | w1-standard | plugins/ok/families/ok-planner/docs/plumbline-cheatsheet.md::Tests | five condensed bullets after the no-tests close marker, pointing to the Time controls section for ti |
| i87 | call | w1-standard | plugins/ok/families/ok-planner/docs/testing.md | the standard says no lint checks it and points to coding rule 11 by number and title |
| i88 | improvement | w12-w23-legacy | plugins/ok/families/ok-planner/scripts/tests::cmd_ports | I3: refuse a checks that is not a list of commands, writing nothing |
| i89 | call | w12-w23-legacy | plugins/ok/families/ok-planner/scripts/tests::ported_items | only the latest legacy task of each file counts for ports, complete, report, and stamp |
| i90 | call | w12-w23-legacy | plugins/ok/families/ok-planner/scripts/review::suite_lead | suite lead: words before the first {placeholder} word, trailing flags dropped, none when a bare inte |
| i91 | call | w12-w23-legacy | plugins/ok/families/ok-planner/scripts/review::project_runners | a testing object with no run is refused, as one with no runners already is |
| i92 | call | w12-w23-legacy | plugins/ok/families/ok-planner/scripts/review::listed_checks | split the checks shape check out of declared_checks; tests rules reads the shape alone |
| i93 | call | w12-w23-legacy | plugins/ok/families/ok-planner/scripts/tests::stamped_rules | stamp keys inferred rules by check; a fresh entry replaces an older one for the same check, settled  |
| i94 | call | w12-w23-legacy | plugins/ok/families/ok-planner/scripts/tests::take_rule | rules take matches the check path and writes settled=practice:<slug> or retired on the entry |
| i95 | call | w12-w23-legacy | plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md::Resolve | inferred rules are walked in both session kinds, outside the relevance pass; postpone records nothin |
| i96 | noticed | w12-w23-legacy | README.md:160 | README still says only a test enforcing a written rule becomes a project check |
| i97 | call | w14-boundary | plugins/ok/families/ok-planner/admin/true-up::carried_boilerplate | one reader per job, parameterized by kind, serves sprints, test sprints, and doc sprints |
| i98 | call | w14-boundary | plugins/ok/families/ok-planner/admin/true-up::live_sprints | live_sprints takes its folder; rewrite_plan and LIVE_SPRINT_KINDS root sprints/, test-sprints/, doc- |
| i99 | call | w14-boundary | plugins/ok/families/ok-planner/admin/true-up::planned_folders | no folders fill while the planned config is malformed; the next true-up after the corrected config f |
| i100 | call | w14-boundary | plugins/ok/families/ok-planner/admin/true-up::plan_folders_filled | fill only a plan with no folders key; write it through dumped, keeping the plan's indent |
| i101 | call | w14-boundary | checks/sprint-boilerplate::template_homes | each kind's homes are git log --follow of the carried path plus the sprint template's listed earlier |
| i102 | noticed | w14-boundary | docs/integration-contract.md::live-sprint rewrite bullet | left as written; outside this stage's files |
| i103 | noticed | w14-boundary | .ok-planner/design/decisions/whole-file-ownership.md::Records | left as written; corpus outside this stage |
| cert:i1 | rejected | session | plugins/ok/families/ok-planner/skills/plan-tests/SKILL.md | rejected: the sentence's one instruction, plan every story from the start, is the right action for a |
| cert:i4 | rejected | session | plugins/ok/families/ok-planner/CLAUDE.md | rejected: gone; family CLAUDE.md line 23 already lists the resources rule, budget planner, and prefl |
| cert:i5 | rejected | session | README.md | rejected: README.md is documentation under docspec readme, never in review |
| cert:i6 | rejected | session | docs/integration-contract.md | rejected: docs/integration-contract.md is prose the sprint did not change, out of review |
| cert:i17 | unlisted | pass | plugins/ok/families/ok-planner/scripts/tests::cmd_report | Legacy tests ported, tests ports, and complete read only the ports items of each file's latest legac |
| cert:i19 | unlisted | pass | plugins/ok/families/ok-planner/scripts/dashboard::meta | The page title is read once at service start, not per /api/meta request; an edited title shows after |
| cert:i20 | unlisted | pass | plugins/ok/families/ok-planner/scripts/review::declared_folders | An unparseable .ok-planner/config.json now refuses (naming the parse error) instead of printing the  |
| cert:i22 | unlisted | pass | plugins/ok/families/ok-planner/scripts/review::declared_folders | An unparseable or non-object .ok-planner/config.json now refuses (tasks.Unset, exit 1) where it read |
| cert:i23 | unlisted | pass | plugins/ok/families/ok-planner/scripts/discover::main | discover is a B108 user the notes do not list: a missing folders key or config now ends discover are |
| cert:i24 | unlisted | pass | plugins/ok/families/ok-planner/scripts/plumbline::CONFIG_KEY_DEFECTS | config-check now reports a non-array citations (and validates ignore); a value the lint used to drop |
| cert:i25 | unlisted | pass | plugins/ok/families/ok-planner/scripts/review::declared_folders | Where node is not on PATH, every review verb now prints the 'declares folders, and node is not on PA |
| cert:i26 | unlisted | pass | plugins/ok/families/ok-planner/scripts/plumbline::CONFIG_KEY_DEFECTS | config-check now reports a malformed citations or ignore that was read as [] before; the lint refuse |
| cert:i27 | unlisted | pass | plugins/ok/families/ok-planner/scripts/review::declared_folders | an unparseable .ok-planner/config.json now refuses review's file-listing verbs instead of reading th |
| cert:i28 | unlisted | pass | plugins/ok/families/ok-planner/scripts/review::project_runners | malformed testing.runners entries now refuse instead of being dropped, and a testing object with no  |
| cert:i29 | unlisted | pass | plugins/ok/families/ok-planner/scripts/tests::cmd_declare | tests declare refuses an absent or unparseable config instead of writing a file holding only testing |
| cert:i30 | unlisted | pass | plugins/ok/families/ok-planner/scripts/tests::ported_items | only the latest legacy task per legacy:<file> key counts its ports items, so a refiled legacy task's |
| cert:i32 | unlisted | pass | plugins/ok/families/ok-planner/admin/true-up::config_named_keys | CONFIG_CHECK_KEYS gains title, ignore, dashboard, stack_helpers, surface_corpus, so a config: questi |
| cert:i39 | duplicate | merge | plugins/ok/families/ok-planner/scripts/discover:main | duplicate of i49 |
| cert:i51 | duplicate | merge | plugins/ok/families/ok-planner/scripts/discover:main | duplicate of i49 |
| cert:i56 | duplicate | merge | plugins/ok/families/ok-planner/scripts/discover:cmd_areas | duplicate of i40 |
| cert:i59 | duplicate | merge | plugins/ok/families/ok-planner/scripts/tests:read_stream | duplicate of i50 |


# Sprint certification

- mode: sprint `.ok-planner/sprints/2026-10-30-sixth-intake-drain.md`, base `df287cf04ef1e4207f754df5bc55cb89b3e8d662`.
- hunt: 27 stories driven, one driver each; no stack (the project declares none), no instance stories, no story driven again one at a time. 22 stories achieved on every surface and variant. 5 failed on one skill surface: declare-project-documentation (skill:plan-docs, two failures), certify-completion (skill:converge), find-and-fix-defects (skill:converge), keep-documentation-current (skill:plan-docs). Failures sorted: 2 defect (certify-completion, keep-documentation-current), 3 backlog (the two declare-project-documentation failures, find-and-fix-defects), 0 not-owed, 0 environment, 0 redrive, 0 judgment, 0 upstream, 0 rejected. All 29 resource-stop tasks closed done. No merge closed unfinished. The flagged `tasks retry t4` drain agent ran only that command and released t4; its structured result echoed unrelated text.
- sprint: the review root (t1) and its 13 pass tasks closed done. Completion passes reached every work item and taken improvement end to end: W1 (tests tasks --stage verify -> stage_verify; true-up ESTATE_FILES), W2 (tests run -> cmd_run), W3 (tests run --failing / tests complete), W4 (/plan-tests waits and controls -> assembled_plan; stage_controls), W5 (/plan-tests budget task -> assembled_plan; stage_preflight), W6 (tests groups -> window_touches), W7 (coding rule 10 and coding-rules block), W8 (coding rule 11; CODE-PLANNER-PROMPT step 3), W9 (every tool's owner frame -> tasks.project_config/setting; true-up former-default writes; plumbline loadConfig), W10 (stack helper settings), W11 (SURFACE-INTENT-DEFINITION and member-list readers), W12 (TEST-SORT-PROMPT port inferred -> assembled_plan; tests rules), W13 (/ok -> true-up::unfiled; surface-corpus main; owner-list stuck filing), W14 (/ok diagnose -> rewrite_plan LIVE_SPRINT_KINDS), W15 (drive.md rules), W16 (review certified -> certified_sprint), W17 (review certified -> recorded_base), W18 (converge return), W19 (/plan-docs window, doc-sprint steps 6-7), W20 (docs example -> blob_held), W21 (merge.md none sentence), W22 (plan-sprint Reconcile/Draft/Resolve), W23 (tests ports -> cmd_ports), W24 (review drive-command resource-stop), W25 (sprint-document archive step 3), W26 (sprint-document step 13), W27 (plumbline/post-edit.js -> committedLegacyMarker), I1, I2, I3, I100-I103, I200, I300. Regression passes read about 70 changed definitions and 35 users; their reports merged into the defect list below, with 14 unlisted behavior changes recorded as calls. The checks (`node .ok-planner/bin/plumbline` over the changed files) passed at the start and again after the fix loop. Reports sent to the intake as outside the sprint's scope: the three backlog failures.
- deltas: 16 compared, 16 landed at build, 0 landed by this run, 0 stuck; none unsettled, no unmatched C3 defect.
- fixed: 17 defects in one fix round. Verified 13: A1 i38 (tests:cmd_run), A2 i52 (true-up:config_named_keys), A3 i50 (tests:read_stream), A3 i54 (tests:control_failures), A8 i53 (ok-planner-CLAUDE.md Executing a sprint), A9 i46 (converge SKILL.md sprint-mode final checks), C1 i40 (discover:cmd_areas), C1 i49 (discover:main), C1 i55 (tests:unrewritten_tests), C1 i57 (plumbline:declaredFolders), C4 i41 (owner-list.md stuck defect), C4 i47 (plan-docs core.md gated-element definition), R3 i58 (review:declared_folders). Duplicate 4, each accepted by its verifier: i39 and i51 of i49, i56 of i40, i59 of i50. Declined 0, stuck 0. Send-backs 0. Waits 0. Both drive defects (i46, i47) confirmed by a confirm driver (t89, t90); none left unconfirmed.
- ledger: `.ok-planner/review/runs/converge-2026-10-31T032803.jsonl`; the run's folder stands beside it.
- intake: the owner list (t94) wrote 6 issues: 4 defect, 1 product, 1 design (from report i7, set to judgment). No stuck defect, no environment failure, no upstream item; reports i1, i4, i5, i6 were rejected (i4 as gone, i5 and i6 as prose out of review, i1 as right as written). `/triage-issues` (ledger `.ok-planner/tasks/triage-issues-2026-10-31T043302.jsonl`) then routed all 6: retired `review-hunt-area-lines-unchecked` (no accept-list entry covers it); defect `doc-style-pass-may-undo-docspec-notes` and `owner-list-leaves-rejected-backlog-issues-open`, for the next /converge; corpus `whole-file-ownership-records-omit-doc-and-test-sprints`, generated ruling to amend the Records paragraph of decision:whole-file-ownership; question `doc-edit-rules-ignore-docspec-notes` (recommended: the writer rewrites a passage that departs from its docspec's Notes) and `second-recorded-test-run-refuses-or-waits` (recommended: a second recorded run refuses while another runs). Clarity rewrote 5; links wrote 3 and repaired 1.
- cost: 9449043 tokens across 94 tasks on the certification ledger; 506288 on the triage ledger.
