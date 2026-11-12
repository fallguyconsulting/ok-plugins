# Completion report: Eighth intake drain

Sprint: `.ok-planner/sprints/2026-11-11-eighth-intake-drain.md`

## Stages

- t1 — s01-deltas. sprint:deltas — done
- t2 — s11-refile-waiters. work-item:Refile holds its waiters until the refile closes; concept:task-tracker — done
- t3 — s19-doc-style. work-item:Documentation sprints give every fixed file a style read; decision:documentation-sprints-write-the-documentation; decision:documentation-style-read-once; story:keep-documentation-current — done
- t4 — s20-doc-reference. work-item:Documentation sprints check every reference file against the public surface; decision:every-public-class-has-a-reference; decision:surface-members-listed-at-need; story:reference-names-the-public-surface — done
- t5 — s02-test-support. work-item:Every test task of a pass waits on every test support task, under one name; decision:fixes-rerun-the-tests-they-reach; decision:scenario-list-decided-once; decision:seed-recommended-never-required; decision:speed-acceptance-outlives-support-changes; decision:team-execution-cold-gate; decision:test-loop-fixes-code-never-tests; decision:test-support-written-before-tests — partial
- t6 — s03-chunk. work-item:A test task takes a story's scenarios, up to `testing.chunk`; decision:settings-have-no-code-defaults; decision:test-tasks-take-a-story-at-a-time; decision:testing-set-up-by-its-own-verb — partial
- t7 — s04-refile-map. work-item:The write stage refiles a blocked test task that waits on another blocked test task; decision:stopped-run-resumes; decision:test-support-written-before-tests — done
- t8 — s05-test-planning. work-item:Detailed test planning runs in sprint execution, ahead of the build; decision:every-timer-has-a-time-control; decision:legacy-suites-sorted-automatically; decision:planned-tests-name-their-waits; decision:team-execution-cold-gate; decision:test-tasks-own-the-tests; decision:testing-runs-inside-the-sprint; decision:tests-planned-in-execution; story:plan-a-sprint — partial
- t9 — s06-runtime. work-item:Runtime parts are planned with no offer; decision:runtime-parts-planned-without-an-offer; decision:testing-runs-inside-the-sprint — done
- t10 — s07-kept-legacy. work-item:The test plan keeps test support that kept legacy tests read; decision:legacy-suites-sorted-automatically; story:retire-a-legacy-suite — done
- t11 — s08-nothing-to-plan. work-item:A sprint that plans no tests leaves untaken legacy tests alone; decision:legacy-suites-sorted-automatically; story:retire-a-legacy-suite — partial
- t12 — s09-clocks. work-item:Result lines carry the command's clock, and the suite's contracts are checked before a round; decision:project-owns-its-suite-command; decision:suite-contracts-checked-before-a-round; decision:tests-isolated-unless-declared — done
- t13 — s10-suite-faults. work-item:Suite faults file no speed step, and product-slow fixes ride a round that runs anyway; decision:product-slow-fixes-ride-a-round-that-runs-anyway; decision:speed-read-at-three-points; decision:test-loop-fixes-code-never-tests — done
- t14 — s12-drain-fill. work-item:The drain fills every free slot on each return; decision:drain-fills-every-free-slot; decision:drain-runs-as-a-workflow-script; decision:team-execution-cold-gate — done
- t15 — s13-drive. work-item:`/drive` drives stories and fixes nothing; `/converge` and sprint certification run its drive; decision:certification-drives-what-the-sprint-changes; decision:converge-close-takes-vetoes; decision:defects-outside-scope-become-defect-issues; decision:drive-tries-each-story-as-a-user; decision:intake-writers-are-gated; decision:one-drive-procedure-fixes-nothing; story:catch-broken-promises; story:veto-calls-made-in-my-absence — done
- t16 — s14-confirm. work-item:Confirm drives cover drive defects a verifier folded into another defect; decision:drive-tries-each-story-as-a-user; story:catch-broken-promises; story:certify-completion — done
- t17 — s15-certified-counts. work-item:Certification counts only drives that ran and reviews that forked; concept:completion-contract; decision:certification-drives-what-the-sprint-changes; decision:drive-tries-each-story-as-a-user; story:certify-completion — done
- t18 — s16-start-checks. work-item:The sprint's start checks check the review script; decision:every-stop-ends-the-goal — done
- t19 — s17-stop. work-item:A stop meets the goal's condition, and says it is no success; decision:every-stop-ends-the-goal; decision:sprint-goal-read-from-the-repository; decision:stopped-run-resumes — done
- t20 — s18-goal-line. work-item:Planning hands the owner the whole goal line; decision:drain-runs-as-a-workflow-script; decision:every-stop-ends-the-goal; decision:planned-commit-moves-only-over-read-work; decision:sprint-goal-read-from-the-repository — done
- t21 — s21-profiles. work-item:Every vendored profile names its tools, and drivers run on a drive profile; decision:drive-tries-each-story-as-a-user; decision:profiles-name-their-tools; decision:subagent-model-follows-job — done
- t22 — s22-lean-profile. work-item:A lean test profile runs the test stages' test-support, test, verify, and speed tasks, with the suite's rules for its role in its body; decision:lean-body-copied-word-for-word; decision:lean-profiles-carry-their-rules; decision:profiles-name-their-tools; decision:stale-lean-body-stops-test-work; decision:steering-over-prose-lint; decision:team-execution-cold-gate; story:write-time-prose-steering — done
- t23 — s23-speed-ledgers. work-item:Certification reads speed verdicts from both of a sprint's ledgers; decision:speed-acceptance-outlives-support-changes; decision:speed-read-at-three-points; story:suite-gets-faster-over-time — done
- t24 — s24-ranking. work-item:The speed ranking carries every whole-suite round at the current blob; decision:speed-ranked-by-median-seconds; story:suite-gets-faster-over-time — done
- t25 — s25-sha256. work-item:Scripts accept SHA-256 commit names; decision:closing-commit-baseline; decision:corpus-audit-hands-a-discovery-to-planning — done
- t26 — s26-descriptions. work-item:Every suite skill's description is its guard and one sentence; decision:skill-descriptions-hold-the-guard-and-one-sentence; decision:slash-only-activation — done
- t27 — s27-ancestor-claude-md. work-item:The administration names an ancestor CLAUDE.md for exclusion; decision:ancestor-claude-md-left-to-the-owner — done
- t28 — s28-untracked-edits. work-item:True-up asks before it rewrites an edited untracked suite file; decision:true-up-asks-once-before-destructive-steps; story:turn-down-a-destructive-true-up — partial
- t29 — s29-annotations. work-item:Each annotation cites the decision that holds its choice; decision:product-slow-verdict-fixes-the-product; decision:project-owns-its-suite-command; decision:scenario-list-decided-once; decision:second-whole-suite-round-refuses; decision:speed-acceptance-outlives-support-changes; decision:speed-ranked-by-median-seconds; decision:speed-read-at-three-points; decision:sprint-runs-recorded-whole; decision:sprints-plan-what-their-work-reaches; decision:tests-spend-time-only-on-their-outcome — done
- t30 — s02-test-support. work-item:Every test task of a pass waits on every test support task, under one name; decision:fixes-rerun-the-tests-they-reach; decision:scenario-list-decided-once; decision:seed-recommended-never-required; decision:speed-acceptance-outlives-support-changes; decision:team-execution-cold-gate; decision:test-loop-fixes-code-never-tests; decision:test-support-written-before-tests — done
- t31 — s03-chunk. work-item:A test task takes a story's scenarios, up to `testing.chunk`; decision:settings-have-no-code-defaults; decision:test-tasks-take-a-story-at-a-time; decision:testing-set-up-by-its-own-verb — done
- t32 — s05-test-planning. work-item:Detailed test planning runs in sprint execution, ahead of the build; decision:every-timer-has-a-time-control; decision:legacy-suites-sorted-automatically; decision:planned-tests-name-their-waits; decision:team-execution-cold-gate; decision:test-tasks-own-the-tests; decision:testing-runs-inside-the-sprint; decision:tests-planned-in-execution; story:plan-a-sprint — done
- t33 — s08-nothing-to-plan. work-item:A sprint that plans no tests leaves untaken legacy tests alone; decision:legacy-suites-sorted-automatically; story:retire-a-legacy-suite — done
- t34 — s28-untracked-edits. work-item:True-up asks before it rewrites an edited untracked suite file; decision:true-up-asks-once-before-destructive-steps; story:turn-down-a-destructive-true-up — done

## Calls

| id | kind | stage or role | site | choice |
|---|---|---|---|---|
| i1 | call | s01-deltas | .ok-planner/sprints/2026-11-11-eighth-intake-drain.md | every delta lands in one stage ahead of the work items |
| i2 | call | s02-test-support | plugins/ok/families/ok-planner/scripts/tests::cmd_convert_state | --clear drops named story stamps in a support-only conversion too |
| i3 | call | s02-test-support | plugins/ok/families/ok-planner/scripts/tests::stage_write | test filings keep their per-file test support waits and add every test support task of the pass |
| i4 | call | s02-test-support | plugins/ok/families/ok-planner/scripts/tests::live_tests | internal live-entry and run-target key support renamed test_support |
| i5 | call | s02-test-support | plugins/ok/families/ok-planner/scripts/tests::written_plan | the earlier legacy sort support reads as test-support in written_plan |
| i6 | call | s02-test-support | plugins/ok/families/ok-planner/admin/ADMINISTRATION.md | ADMINISTRATION.md's scenario-list conversion text left for a refile with the path |
| i7 | call | s03-chunk | plugins/ok/families/ok-planner/scripts/tests::rewrite_files | a rewrite's files take the scenario's own test paths, plan and state, not the last task's files |
| i8 | call | s03-chunk | plugins/ok/families/ok-planner/scripts/tests::refiled_tests | a sent-back scenario's brief comes from the plan or the scenario list, else its line in its last tes |
| i9 | call | s03-chunk | plugins/ok/families/ok-planner/scripts/tests::stage_verify | a tests item with no recording task keys its verify task verify:<item id> |
| i10 | call | s03-chunk | plugins/ok/families/ok-planner/skills/converge/prompts/test-write.md | where any scenario of a test task needs test support, the task writes no test for any and closes blo |
| i11 | call | s03-chunk | .ok-planner/config.json | this project's config gets no chunk key: its testing declares no run |
| i12 | noticed | s03-chunk | plugins/ok/families/ok-planner/skills/converge/prompts/verify.md:55 | verify.md still says the write stage files a test task for each test sent back |
| i13 | improvement | s11-refile-waiters | plugins/ok/families/ok-planner/scripts/tasks::cmd_claim | I201: claim skips and refuses a task whose waits are open |
| i14 | call | s11-refile-waiters | plugins/ok/families/ok-planner/scripts/tasks::USAGE | claim's usage entry also states the open-wait refusal |
| i15 | call | s04-refile-map | plugins/ok/families/ok-planner/scripts/tests::loop_refusals | loop_refusals reads each filing's mapped after alone, since the mapping folds the copied list in |
| i16 | call | s04-refile-map | plugins/ok/families/ok-planner/scripts/tests::stage_write | the write stage's printed filed list follows the wait order, not the planned order |
| i17 | call | s04-refile-map | plugins/ok/families/ok-planner/scripts/tests::after_refusals | a reopened task's copied waits are checked too, as part of its mapped after |
| i18 | improvement | s05-test-planning | plugins/ok/families/ok-planner/scripts/tests::testing_config | I1: testing.group_size is a required setting with no code default |
| i19 | call | s05-test-planning | plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md::10 | section 10 passes no --parts; the runtime-parts stage adds the flag and its use |
| i20 | call | s05-test-planning | plugins/ok/families/ok-planner/skills/plan-sprint/tests.md::TEST-PLAN-WIDE-REVIEW-PROMPT | both reviews say they run before the plan's last assembly, not before any assembly |
| i21 | call | s05-test-planning | plugins/ok/families/ok-planner/skills/plan-sprint/tests-story.md::TEST-STORY-PLANNER-PROMPT | a rewrite to a changed outcome and a retire as a gap each record a call of kind scope |
| i22 | call | s05-test-planning | plugins/ok/families/ok-planner/skills/plan-sprint/tests.md::The test planning procedure | the planning run declares scenarios.gap boolean, and the plan refuses a gap that is not true |
| i23 | call | s05-test-planning | plugins/ok/families/ok-planner/scripts/tests::assembled_plan | a scenario question refuses the assembly, naming its task, rather than being dropped |
| i24 | call | s05-test-planning | plugins/ok/families/ok-planner/scripts/tests::written_plan | B2 migrate: every plan read sets questions to [] where an earlier release wrote none |
| i25 | call | s05-test-planning | plugins/ok/families/ok-planner/skills/plan-sprint/sprint-document.md::3a | B5 migrate: the replaced boilerplate lines join retired-boilerplate.json, and a sprint whose plan st |
| i26 | call | s05-test-planning | plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md::2 | Frame's test offer requires only .ok-planner/bin/tests, since planning opens no tracker run |
| i27 | call | s05-test-planning | plugins/ok/families/ok-planner/scripts/tests::declared_values | the count refusal names the flag with hyphens |
| i28 | call | s05-test-planning | plugins/ok/families/ok-planner/scripts/tasks::latest_done_tasks | latest orders a role and key's tasks by task number, reusing task_number |
| i29 | call | s05-test-planning | .ok-planner/config.json | this project's config gets no group_size: its testing declares no run |
| i30 | call | s05-test-planning | plugins/ok/families/ok-planner/skills/plan-sprint/tests.md::Fixing a planner's items | a drop records --by test-planning in place of --by plan-sprint |
| i31 | noticed | s05-test-planning | plugins/ok/families/ok-planner/skills/_sprint/shared.md::TEST-CALL-RULE | the departure call kind still names an owner answer |
| i32 | noticed | s05-test-planning | plugins/ok/families/ok-planner/skills/converge/SKILL.md:143 | converge's summary of the owner list omits the program questions it now files |
| i33 | call | s06-runtime | plugins/ok/families/ok-planner/skills/plan-sprint/tests-runtime.md::TEST-RUNTIME-PLANNER-PROMPT | the runtime planner reads parts, runtime_brief, and frozen from the groups file |
| i34 | call | s06-runtime | plugins/ok/families/ok-planner/scripts/tests::plan_failures | under frozen, plan refuses a rewrite, retire, or gap of a runtime scenario whose part --parts does n |
| i35 | call | s06-runtime | plugins/ok/families/ok-planner/scripts/tests::declared_values | declare --offers runtime gets its own refusal naming that runtime parts are planned with no offer |
| i36 | call | s06-runtime | plugins/ok/families/ok-planner/scripts/tests::cmd_groups | groups prints a runtime brief line and records runtime_brief; under on the runtime planner always ru |
| i37 | call | s06-runtime | plugins/ok/families/ok-planner/skills/ok-setup/SKILL.md::3.6 | B13 preserve: same arguments, three offers proposed, and a sentence says runtime parts are planned w |
| i38 | noticed | s06-runtime | plugins/ok/families/ok-planner/admin/ADMINISTRATION.md::testing settings | left as it stands; outside this stage's files |
| i39 | noticed | s06-runtime | plugins/ok/families/ok-planner/skills/plan-sprint/sprint-document.md::SPRINT-DOCUMENT-TEMPLATE ## Te | left as it stands; outside this stage's files |
| i40 | noticed | s06-runtime | plugins/ok/families/ok-planner/skills/plan-sprint/tests.md::The test planning procedure step 2 | left as it stands; outside this stage's files |
| i41 | call | s07-kept-legacy | plugins/ok/families/ok-planner/scripts/tests::kept_files | plan kept paths are normalized with os.path.normpath, claimed paths too, before the claimed filter |
| i42 | call | s07-kept-legacy | plugins/ok/families/ok-planner/scripts/tests::print_plan | kept listing names the kept test files a kept test support file serves, instead of the not-taken-fol |
| i43 | improvement | s08-nothing-to-plan | plugins/ok/families/ok-planner/scripts/tests::stray_paths | I2: normalize claimed, recorded, and legacy test support paths before the stray comparison |
| i44 | call | s08-nothing-to-plan | plugins/ok/families/ok-planner/scripts/tests::stray_paths | A sprint with no -plan.json returns no stray path, read before any other state |
| i45 | call | s08-nothing-to-plan | plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md::10.2 | Nothing-to-plan line reads 'Plan: none: nothing to plan; kept: <n> test files, left as they stand' |
| i46 | call | s09-clocks | plugins/ok/families/ok-planner/scripts/tests::results_rounds | a record holding scenario reads as a result before a record holding ended reads as a round's close |
| i47 | call | s09-clocks | plugins/ok/families/ok-planner/skills/_sprint/shared.md::T4 | T4's fields read each test's start and end and the clock that gave them |
| i48 | call | s09-clocks | plugins/ok/families/ok-planner/skills/ok-setup/SKILL.md::3.2 | the runner proposal writes started and ended wherever the runner reports them |
| i49 | call | s09-clocks | plugins/ok/families/ok-planner/skills/ok-setup/SKILL.md::3.7 | each failed suite-run check is one owner question: change the command, change the setup, or neither |
| i50 | call | s09-clocks | plugins/ok/families/ok-planner/skills/converge/prompts/test-preflight.md::Check | the suite-run checks run as steps 5 to 7 on the stack step 2 started, scratch resource named preflig |
| i51 | call | s10-suite-faults | plugins/ok/families/ok-planner/scripts/tests::cmd_settled | SETTLED's first line names the deferred count; deferred lines follow it |
| i52 | call | s10-suite-faults | plugins/ok/families/ok-planner/scripts/tests::suite_reports | with no closed whole round, T3 reports still file, matching tests failures |
| i53 | call | s10-suite-faults | plugins/ok/families/ok-planner/skills/converge/SKILL.md::3a.2 | the suite-fault test ignores perf: entries, as speed_refusal's round_failures does |
| i54 | call | s10-suite-faults | plugins/ok/families/ok-planner/skills/converge/prompts/owner-list.md::Read | owner list reads deferred only in sprint mode under on or frozen, via tests enabled |
| i55 | call | s10-suite-faults | plugins/ok/families/ok-planner/skills/_sprint/shared.md::speed-review-product-slow | the speed reviewer's product-slow paragraph also says a lone verdict goes to the intake |
| i56 | noticed | s10-suite-faults | plugins/ok/families/ok-planner/docs/testing.md::A slow product | testing standard still says the fix loop always files a perf: fixer |
| i57 | call | s13-drive | plugins/ok/families/ok-planner/skills/drive/SKILL.md::Setting up the run | /drive registers ok-opus alone; the profile stage t21 adds ok-drive with cmd_drives |
| i58 | call | s13-drive | plugins/ok/families/ok-planner/skills/_converge/drive.md::The merge rule | the shared drive text states the merge rule for its own merges |
| i59 | call | s13-drive | plugins/ok/families/ok-planner/scripts/review::certification_failures | one failure line per undriven story; where no story was driven, each line carries the drive-did-not- |
| i60 | call | s13-drive | plugins/ok/families/ok-planner/skills/drive/SKILL.md::Preconditions | the sprint form runs review stories --sprint as its precondition and stops on its refusal |
| i61 | call | s13-drive | plugins/ok/families/ok-planner/skills/converge/prompts/owner-list.md::A drive-only run | a drive-only run settles each filed open defect with --note on its open state |
| i62 | call | s13-drive | plugins/ok/families/ok-planner/skills/plan-sprint/sprint-document.md::Completion contract | contract item 3 drops the repeated .ok-planner/config.json path from its suite sentence after the re |
| i63 | call | s19-doc-style | plugins/ok/families/ok-planner/scripts/docs::style_rechecks | filing order is the task id's number via the tasks module review already loads; a file's latest styl |
| i64 | call | s19-doc-style | plugins/ok/families/ok-planner/skills/plan-docs/doc-sprint-document.md::step7 | a fact-loop style task goes to each check file the fixers changed as step 6 lists changed files, wit |
| i65 | call | s19-doc-style | plugins/ok/families/ok-planner/skills/plan-docs/core.md::DOC-CHECK-PROMPT | on a whole-file recheck the checker records each rewrite with scope file, not the old claim's scope |
| i66 | call | s19-doc-style | plugins/ok/families/ok-planner/admin/retired-doc-sprint-boilerplate.json | B120 migrate: the seven released step-7 and contract lines the template replaced join the retired li |
| i67 | call | s19-doc-style | plugins/ok/families/ok-planner/scripts/docs::complete_failures | B121 preserve: the recheck requirement fires only where a check file's latest style item is reviewed |
| i68 | call | s14-confirm | plugins/ok/families/ok-planner/scripts/review::confirm_briefs | folded brief joins its duplicates' bodies with ' / ' under CONFIRM_EVIDENCE_CHARS and puts 'confirm  |
| i69 | call | session | .ok-planner/bin/tasks | take back an early issue with the canonical tracker's fixed task set |
| i70 | improvement | s05-test-planning | plugins/ok/families/ok-planner/admin/true-up::FORMER_SUITE_SETTINGS | I1: true-up writes testing.group_size 8 where testing declares run; /ok-setup 3.2 asks for it |
| i71 | call | s15-certified-counts | plugins/ok/families/ok-planner/scripts/review::story_drivers | A story's latest driver is its highest-numbered driver task |
| i72 | call | s16-start-checks | plugins/ok/families/ok-planner/skills/plan-sprint/sprint-document.md::step 2 | the missing-tool ls line says 'ends the goal', the file's current goal wording; s17-stop rephrases i |
| i73 | improvement | s17-stop | plugins/ok/families/ok-planner/scripts/review::stopped_lines | I101: one stop-verdict helper serves review and docs |
| i74 | call | s17-stop | plugins/ok/families/ok-planner/scripts/ok-planner-CLAUDE.md::native goal mechanism | '/goal <path-to-sprint>' becomes '/goal with the goal line planning hands over' |
| i75 | call | s17-stop | plugins/ok/families/ok-planner/skills/plan-sprint/sprint-document.md::step 1 | step 1 says the owner's goal line carries the whole condition, so no message restates it |
| i76 | call | s18-goal-line | plugins/ok/families/ok-planner/skills/plan-docs/SKILL.md::1. Open documentation sprint | The open-sprint offer names the documentation sprint goal line from {{PLANNING-HANDOFF}} in place of |
| i77 | call | s18-goal-line | plugins/ok/families/ok-planner/skills/_sprint/shared.md::{{PLANNING-HANDOFF}} | Both goal lines stamp <goal path> twice, in the Run clause and the certified/complete command |
| i78 | call | s21-profiles | plugins/ok/families/ok-planner/admin/true-up::expected | B219: no true-up code change; the existing collision rule covers ok-drive.md |
| i79 | call | s21-profiles | plugins/ok/families/ok-planner/skills/plan-docs/core.md::DOC-CHECK-PROMPT | B203: no documentation check or fix prompt needs an MCP tool; plan-docs/core.md unchanged |
| i80 | call | s21-profiles | plugins/ok/families/ok-planner/scripts/hooks/subagent-batching::CONTEXT | One LSP instruction worded 'load the LSP tool once with ToolSearch("select:LSP"), then call it' at e |
| i81 | noticed | s21-profiles | docs/integration-contract.md:491 | profile list omits ok-drive |
| i82 | call | s21-profiles | plugins/ok/families/ok-planner/skills/converge/SKILL.md::Register the profiles | ok-drive registered in drive and sprint mode with a clause naming why; drive/SKILL.md registers it b |
| i83 | call | s22-lean-profile | plugins/ok/families/ok-planner/agents/ok-test.md::body | twelve section lines, as the notes' list names them |
| i84 | call | s22-lean-profile | plugins/ok/families/ok-planner/agents/ok-test.md::body | one line before the sections: Follow every rule below on each file you write and each test you judge |
| i85 | call | s22-lean-profile | checks/vendored-layer::PINNED | pin .ok-planner/lean-profiles.json now; the check fails until the owner's /ok writes it |
| i86 | call | s22-lean-profile | plugins/ok/families/ok-planner/admin/retired-boilerplate.json | no line added: the replaced step 2 and 3 lines were never in a released template |
| i87 | call | s22-lean-profile | plugins/ok/families/ok-planner/scripts/tests::cmd_tasks | the lean check runs first for write, verify, and speed; sweep files ok-opus tasks and skips it |
| i88 | call | s22-lean-profile | plugins/ok/families/ok-planner/admin/true-up::lean_body | a section a lint choice empties is dropped with its following blank line |
| i89 | noticed | s22-lean-profile | docs/integration-contract.md:491 | left: the contract's profile list names ok-haiku, ok-opus, ok-review only |
| i90 | call | s23-speed-ledgers | plugins/ok/families/ok-planner/scripts/tests::unsettled_send_backs | tests settled reads merged ledgers through ledger_items, like speed_rows |
| i91 | call | s23-speed-ledgers | plugins/ok/families/ok-planner/scripts/tests::ledger_fixes | an accepted fixes item settles a product-slow verdict only within its own ledger |
| i92 | call | s23-speed-ledgers | plugins/ok/families/ok-planner/scripts/tests::recorded_tests | split latest_tests(items) out of recorded_tests so the speed readers take positioned items |
| i93 | call | s23-speed-ledgers | plugins/ok/families/ok-planner/scripts/tests::USAGE | tests slowest help names both ledgers as the verdicts' source |
| i94 | call | s26-descriptions | plugins/ok/families/ok-planner/skills/drive/SKILL.md::description | drive description cut to the guard and one sentence; sprint form and fresh ledger left to the body |
| i95 | call | s26-descriptions | plugins/ok/families/ok-planner/skills/plan-docs/SKILL.md::Documentation planning | body gains the dropped sentence on the unattended /goal run |
| i96 | call | s26-descriptions | plugins/ok/families/ok-planner/skills/triage-issues/SKILL.md::Setting up the run | body gains the dropped sentence on one cached prefix per profile |
| i97 | call | s24-ranking | plugins/ok/families/ok-planner/scripts/tests::speed_ranking | B216 migrate: ranked_held already accepts a seconds list of any length, so earlier short rows read a |
| i98 | call | s27-ancestor-claude-md | plugins/ok/families/ok-planner/CLAUDE.md::Layout | left the family CLAUDE.md unchanged |
| i99 | improvement | s25-sha256 | plugins/ok/families/ok-planner/scripts/review::COMMIT_NAME | I102: one COMMIT_HEX/COMMIT_NAME in review replaces CLOSED_STAMP, tests::SHA, docs::SHA, and discove |
| i100 | call | s28-untracked-edits | plugins/ok/families/ok-planner/admin/true-up::untracked_edits | compare the file's digest with the record's entry only; the version check folds into it |
| i101 | call | s28-untracked-edits | plugins/ok/families/ok-planner/admin/true-up::materialize | record every carried file whose bytes match the carried rendering after the writes, not only the fil |
| i102 | call | s28-untracked-edits | plugins/ok/families/ok-planner/admin/true-up::untracked_edits | a project with no git repository counts its stamped files as untracked, so the record decides them t |
| i103 | call | s29-annotations | plugins/ok/families/ok-planner/scripts/tests::speed_ranking | dropped its tests-spend-time-only-on-their-outcome line instead of repointing it |
| cert:i1 | rejected | session | plugins/ok/families/ok-planner/skills/converge/prompts/verify.md | verify.md's sent-back sentence stands: no action depends on one task per test or per chunk |
| cert:i2 | rejected | session | plugins/ok/families/ok-planner/skills/_sprint/shared.md | the departure call kind stands: an unused kind breaks nothing |
| cert:i3 | rejected | session | plugins/ok/families/ok-planner/skills/converge/SKILL.md | converge SKILL.md's owner-list summary stands: owner-list.md files the program questions |
| cert:i6 | rejected | session | plugins/ok/families/ok-planner/skills/plan-sprint/tests.md | tests.md's runtime brief stands: the runtime prompt reads the parts from the groups file |
| cert:i22 | unlisted | pass | plugins/ok/families/ok-planner/scripts/tests::cmd_convert_state | convert-state --clear now drops per-story stamps when it converts a support-only scenario list; true |
| cert:i29 | unlisted | pass | plugins/ok/families/ok-planner/scripts/tests::unsettled_send_backs | tests settled now reads speed verdicts and tests records merged across the build run and the certifi |
| cert:i33 | unlisted | pass | plugins/ok/families/ok-planner/scripts/tests::stage_write | build call i16: tests tasks --stage write prints its filings in wait order, not planned order; its o |
| cert:i34 | unlisted | pass | plugins/ok/families/ok-planner/scripts/tests::after_refusals | build call i17: a reopened test task's copied waits, mapped to their refiles, are checked, so one th |
| cert:i35 | unlisted | pass | plugins/ok/families/ok-planner/scripts/tests::declared_values | build call i27: the count refusal names the flag as the parser spells it (--setup-silence, --group-s |
| cert:i36 | unlisted | pass | plugins/ok/families/ok-planner/scripts/tests::unsettled_send_backs | build call i90: tests settled reads a send-back's latest verdict and tests item across the sprint ru |
| cert:i51 | duplicate | merge | plugins/ok/families/ok-planner/skills/plan-sprint/sprint-document.md:How to execute step 2 | duplicate of i43 |
| cert:i62 | declined | merge | plugins/ok/families/ok-planner/scripts/tasks:open_waits | readiness on any closed outcome is what the release's fix chains and drive relays rely on; changing  |
| cert:i63 | duplicate | merge | plugins/ok/families/ok-planner/scripts/tasks:step | duplicate of i46 |
| cert:i65 | duplicate | merge | plugins/ok/families/ok-planner/admin/ADMINISTRATION.md:Declare the lint config | duplicate of i59 |
| cert:i66 | duplicate | merge | plugins/ok/families/ok-planner/skills/plan-sprint/sprint-document.md:## Tests template | duplicate of i60 |


# Sprint certification

Ledger: `.ok-planner/review/runs/converge-2026-11-12T012208.jsonl`; the run's folder `.ok-planner/review/runs/converge-2026-11-12T012208/` stands beside it.

- **mode**: `sprint` `.ok-planner/sprints/2026-11-11-eighth-intake-drain.md`, base `46aeb753baaad3cdcc58231303073af40dd66f49`. 67 changed files; no paths outside the project root; build run file present; testing `off`.
- **hunt**: the drive took all 29 stories; the project declares no stack (`none`), so no stack started or stopped and no stop task ran. One driver per story, each closed `done`; none was driven again one at a time.
  - Achieved on every surface and variant: bootstrap-design-corpus, catch-broken-promises, concurrent-stacks-without-port-collisions, declare-project-documentation, discuss-an-issue, edit-time-lint-enforcement, fresh-artifacts-per-run, grow-test-coverage-a-part-at-a-time, keep-documentation-current, project-spans-folders, record-coding-practices, retire-a-legacy-suite, rule-on-the-whole-intake, rule-the-public-surface, see-governing-versions, see-new-analysis, session-awareness, sketch-an-idea, suite-gets-faster-over-time, true-up-project-estate, turn-down-a-destructive-true-up, verification-leaves-no-artifacts-behind, veto-calls-made-in-my-absence, write-time-prose-steering.
  - certify-completion: `review certified` whole failed, skill:converge whole failed (certification_failures read only the defects pool); both achieved on the confirm drive t70.
  - reference-names-the-public-surface: skill:plan-sprint and script docs achieved; skill:plan-docs every-public and no-internal failed (checker listing compare skipped files outside the planner's items); both achieved on the confirm drive t71.
  - find-and-fix-defects: skill:converge whole failed (verify.md's decline check omits the boundary-question decline); outside the sprint's scope.
  - plan-a-sprint: goals and open-questions achieved; unreconciled-work failed (out-of-band work edited after Reconcile or committed before the base escapes every window); outside the sprint's scope.
  - watch-execution-progress: true-up command line achieved; skill:plan-sprint failed (step 4's test-stage drain precedes step 6's checklist); outside the sprint's scope.
  - Failures sorted: 4 `defect` (i10, i11, i14, i15), 3 `backlog` (i12, i13, i16), 0 `not-owed`, `environment`, `redrive`, `judgment`, `upstream`, or `rejected`. Every merge closed `done` on its first filing.
- **sprint**: the review root t1 closed `done` and filed 13 passes (6 completion, 6 regression, 1 alignment), each closed `done`.
  - Completion, with entry points: test planning in execution (`/plan-sprint` §10 -> `tests groups`, step 3a -> `tests plan`), runtime parts (`tests declare`/`groups --parts`), kept legacy support (`tests plan`), nothing-to-plan and I2 (`tests stray`), I1 group_size (t32: works end to end after fixes i59, i60, i61); test-support rename and pass waits, chunk, refile mapping, lean ok-test profile, annotations (`tests tasks --stage write`, `stage_verify`, true-up `expected`/`materialize`, `tests profiles`) (t33: works after fixes i42, i43); result-line clocks and preflight, suite faults and deferred product-slow, speed verdicts from both ledgers, ranking carry (`tests run`/`failures`/`settled`/`reports`, `--stage speed --round`, `tests stamp`) (t34: works after fixes i40, i41, i64); /drive, confirm of folded duplicates, certified counts, profile tools and ok-drive, skill descriptions (`skills/drive/SKILL.md`, `review drives --confirm`, `review certified`, `agents/*.md`) (t35: CLEAN); stop meets the goal condition and I101, goal line, start checks, drain fills free slots, refile holds waiters and I201 (`review certified`/`docs complete`, `PLANNING-HANDOFF`, sprint-document step 2, `tasks next`/`drain.md`, `tasks refile`/`task set`/`claim`) (t36: works after fix i46; i62 declined, i63 duplicate); doc style read, doc reference listing, ancestor CLAUDE.md, untracked edits, SHA-256 and I102 (`docs complete`, `DOC-CHECK-PROMPT`, true-up `diagnose`/`materialize_steps`, `review COMMIT_NAME`) (t37: CLEAN).
  - Behavior changes: the regression passes t38 to t43 judged every listed B-id against its users (scripts/tests, scripts/review, scripts/docs, scripts/discover, scripts/tasks, admin/true-up, checks, plumbline, hooks, profiles, skill text and boilerplate); 6 became defects (i45 R3, i46 R5, i47 A9, i48 A9, i49 A8, i51 R4 duplicate of i43). Unlisted behavior changes recorded as calls: i22, i29, i33, i34, i35, i36.
  - Alignment (t44): all 46 deltas match `.ok-planner/design/` byte for byte, the decisions TOC lists every new slug; 103 build divergences read. CLEAN.
  - Checks: `node .ok-planner/bin/plumbline` over the changed files passed at the start (t2) and at the end (t72). `checks/vendored-layer` (outside `review/config.json` `checks`) stands failing on the missing `.ok-planner/lean-profiles.json` until the owner's `/ok` writes it; recorded as calls i75 and i77.
  - Reports outside the sprint's scope sent to the intake: the 3 `backlog` failures (i12, i13, i16). Reports rejected: i1, i2, i3, i6 (build-noticed items).
- **deltas**: 46 compared, 46 landed at build, 0 landed by this run, 0 stuck; none unsettled, none unmatched.
- **suite**: skipped under `off`.
- **fixed**: one fix round; 0 send-backs; 0 waits.
  - `verified` 17: A3 i40; A8 i44, i49, i61, i68; A9 i39, i41, i47, i48; C1 i42, i43, i60; C4 i59, i64, i67; R3 i45; R5 i46.
  - `duplicate` 4: A9 i63, C1 i66, C4 i65, R4 i51. `declined` 1: C1 i62. `stuck` 0. `promised`, `promise`, `at-fault`, `rewrite`: none.
  - Drive defects confirmed: i39 (t70), i44 (t71); none left unconfirmed.
- **ledger**: `.ok-planner/review/runs/converge-2026-11-12T012208.jsonl`.
- **intake**: the owner list (t73) wrote 9 issues and turned or closed none:
  - `category: defect`: plan-sprint-skips-out-of-band-work-after-reconcile, review-facts-omit-deferred-verdict-check, speed-prompts-file-perf-fixer-unconditionally, test-stage-drain-precedes-progress-checklist, vendored-layer-check-pins-missing-lean-profiles, verify-refuses-boundary-question-declines.
  - `category: product-intent`: deferred-verdict-check-counts-only-open-issues, preflight-setup-checks-with-no-recorded-test, short-close-frees-waiting-tasks.
  - No stuck defect, no `environment` failure, no item set to `judgment` or `upstream`, no record rejected.
  - `/triage-issues` (ledger `.ok-planner/tasks/triage-issues-2026-11-12T022032.jsonl`) took 12 unrouted issues: retired review-facts-omit-deferred-verdict-check (no accept-list entry covers an incomplete line in the review facts) and vendored-layer-check-pins-missing-lean-profiles (the check reports a true state until the owner's `/ok`); routed `defect` plan-sprint-skips-out-of-band-work-after-reconcile, speed-prompts-file-perf-fixer-unconditionally, test-stage-drain-precedes-progress-checklist, verify-refuses-boundary-question-declines; `corpus` decisions-bundling-several-choices-await-a-split; `question` plan-sprint-sign-off-rereads-whole-scope-every-round, setup-web-headless-server, deferred-verdict-check-counts-only-open-issues, preflight-setup-checks-with-no-recorded-test, short-close-frees-waiting-tasks. Clarity rewrote 10, settled none; links wrote 20 links on 10 issues. No message awaited an answer.
  - Session note: the review root reported that it held no Agent tool under the Workflow drain, so it filed its 13 pass tasks and forked none; the drain retried each pass task and fresh `ok-review` agents claimed them.
- **cost**: 11,023,454 tokens over 73 tasks (certification); 947,663 tokens over 9 tasks (triage).
