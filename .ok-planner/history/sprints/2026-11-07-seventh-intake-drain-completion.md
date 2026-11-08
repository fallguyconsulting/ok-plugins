# Completion report: Sprint: Seventh intake drain

Sprint: `.ok-planner/sprints/2026-11-07-seventh-intake-drain.md`

## Stages

- t1 — deltas. corpus deltas — done
- t2 — true-up-mark. work item 2; earlier-release-windows-closed-without-a-verdict — done
- t3 — seed. work item 1; seed-recommended-never-required; tests-spend-time-only-on-their-outcome; test-support-written-before-tests — done
- t4 — review-tool. work item 4; work item 5 — done
- t5 — refile-files. work item 3 — done
- t6 — retry-all. work item 7; stopped-run-resumes; test-support-written-before-tests — done
- t7 — stop-record-review. work item 7; every-stop-ends-the-goal; sprint-goal-read-from-the-repository — done
- t8 — docs-tool. work item 6; work item 7; every-stop-ends-the-goal; sprint-goal-read-from-the-repository — done
- t9 — sprint-template-stop. work item 7; every-stop-ends-the-goal; stopped-run-resumes — done
- t10 — doc-template-stop. work item 6; work item 7; every-stop-ends-the-goal; stopped-run-resumes — done
- t11 — rules-text. work item 7; every-stop-ends-the-goal; stopped-run-resumes — done

## Calls

| id | kind | stage or role | site | choice |
|---|---|---|---|---|
| i1 | call | seed | plugins/ok/families/ok-planner/scripts/tests::stage_write | stage_write reads testing with testing_config(root, sprint), as stage_speed does |
| i2 | noticed | seed | .ok-planner/review/project.md::plugins/ok/families/ok-planner/scripts/tests entry | entry should name tasks --stage write among the verbs that refuse under testing.enabled off |
| i3 | call | seed | plugins/ok/families/ok-planner/skills/converge/prompts/test-support.md::Write (seed bullets) | a seed item briefed as a fixture lands as fixture data in the support file and is marked made by the |
| i4 | call | review-tool | plugins/ok/families/ok-planner/scripts/review::head_commit | one head_commit helper serves default_base and cmd_rotate |
| i5 | call | review-tool | plugins/ok/families/ok-planner/scripts/review::declared_folders | root-only short-circuit requires non-empty string entries |
| i6 | call | review-tool | plugins/ok/families/ok-planner/scripts/review::cmd_certified | certified reads the folders only through check_failures |
| i7 | call | refile-files | plugins/ok/families/ok-planner/scripts/tests::set_files | kept set_files: the files-op branch of filed_tasks still calls it |
| i8 | call | refile-files | .claude/skills/plan-sprint/sprint-document.md::step 7 | left the vendored copy for true-up to refresh |
| i9 | improvement | retry-all | plugins/ok/families/ok-planner/scripts/tasks::cmd_retry | I1: a retry un-issues the reopened task's issued waiters in the same write |
| i10 | improvement | retry-all | plugins/ok/families/ok-planner/scripts/tasks::cmd_retry | I2: retry <task> refuses a closed task a refile replaced, naming the refile |
| i11 | call | retry-all | plugins/ok/families/ok-planner/scripts/tasks::retry_records | each RELEASED/RETRIED event carries an unissued list of the waiters it set back |
| i12 | call | retry-all | plugins/ok/families/ok-planner/scripts/tasks::cmd_retry | refile refusal names the direct refile, not the end of a refile chain |
| i13 | call | retry-all | plugins/ok/families/ok-planner/scripts/tests::stage_write | a reopened test task gets its support wait through a new 'after' filing op (task set after=...) afte |
| i14 | call | stop-record-review | plugins/ok/families/ok-planner/scripts/review::stop_reason | reason lines are the record's non-blank lines, stripped; a record of only blank lines prints no reas |
| i15 | call | docs-tool | plugins/ok/families/ok-planner/scripts/docs::later_commits_bearing | stamp guard runs wherever the planned commit differs from the parent of --commit, not only where the |
| i16 | call | docs-tool | plugins/ok/families/ok-planner/scripts/docs::bearing_docspecs | a docspec bears on the diff when its reading at either commit or in the tree gives a window reason |
| i17 | call | docs-tool | plugins/ok/families/ok-planner/scripts/docs::main | main maps review.ReviewError to 'docs: <message>' exit 1 |
| i18 | call | docs-tool | plugins/ok/families/ok-planner/scripts/docs::cmd_stamp | a docspec stamped at the planned commit keeps the run's ledger and its example at --commit |
| i19 | call | sprint-template-stop | plugins/ok/families/ok-planner/skills/plan-sprint/sprint-document.md::step 2 | step 2 requires bin/tests where -plan.json stands or testing.enabled in config is on, before running |
| i20 | call | sprint-template-stop | plugins/ok/families/ok-planner/skills/plan-sprint/sprint-document.md::step 11 | step 11 defines the stop once (wait, write record, review certified, stop); steps 2 and 13 stop 'as  |
| i21 | call | doc-template-stop | plugins/ok/families/ok-planner/skills/plan-docs/doc-sprint-document.md::step 3 | a docs start stop writes the record with first line 'docs start: the plan must be made again', which |
| i22 | call | doc-template-stop | plugins/ok/families/ok-planner/skills/plan-docs/SKILL.md::1. Layout | setting a stale plan aside moves every file sharing its filename, not only the sprint and its stop r |
| i23 | call | doc-template-stop | plugins/ok/families/ok-planner/skills/plan-docs/doc-sprint-document.md::steps 5-7 | a resumed run reads the roles and keys it already holds from tasks status |
| i24 | call | doc-template-stop | plugins/ok/families/ok-planner/skills/plan-docs/doc-sprint-document.md::step 3 | a missing bin/docs stops the run, but docs complete cannot then print DOCS STOPPED |
| i25 | call | doc-template-stop | plugins/ok/families/ok-planner/skills/_sprint/shared.md::{{PLANNING-HANDOFF}} | the Window line rewrite runs for a documentation sprint once the handoff's commits are made |
| i26 | call | rules-text | plugins/ok/families/ok-planner/scripts/ok-planner-CLAUDE.md::Executing a sprint | the /plan-docs paragraph in Executing a sprint stays; it defers to The docspecs, which now names DOC |
| cert:i2 | unlisted | pass | plugins/ok/families/ok-planner/scripts/tests::stage_write | tests tasks --stage write now reads testing_config(root, sprint), so it refuses under testing.enable |
| cert:i5 | unlisted | pass | plugins/ok/families/ok-planner/scripts/tasks::retry_records | TASKS.TASK.RELEASED/RETRIED events gain an unissued list; additive, no reader in the tree, run-log u |
| cert:i6 | unlisted | pass | plugins/ok/families/ok-planner/scripts/tasks::cmd_retry | retry <task> on any non-retryable task a refile replaced (closed done, or open) now refuses naming t |
| cert:i7 | unlisted | pass | plugins/ok/families/ok-planner/scripts/discover::cmd_areas | discover areas now refuses a malformed folders list (or one beyond the root with node off) through r |
| cert:i11 | unlisted | pass | plugins/ok/families/ok-planner/scripts/tests::stage_write | --stage write now refuses through testing_config (testing.enabled off with a sprint, a missing or ma |
| cert:i47 | duplicate | merge | plugins/ok/families/ok-planner/scripts/review:main | duplicate of i52 |
| cert:i56 | duplicate | merge | plugins/ok/families/ok-planner/scripts/tests:stage_write | duplicate of i55 |
| cert:i60 | duplicate | merge | plugins/ok/families/ok-planner/skills/_sprint/shared.md:{{PLANNING-HANDOFF}} | duplicate of i42 |


# Sprint certification

Ledger: `.ok-planner/review/runs/converge-2026-11-08T015306.jsonl` (run folder beside it).

- **mode**: sprint, `.ok-planner/sprints/2026-11-07-seventh-intake-drain.md`, base `8ada3ba4c0c3d1c873b8c85c9396401ffd3e2fb8`. 21 changed files; no paths outside the project root; build run file present.
- **hunt**: the review root (t1) closed `done` and forked 11 passes (5 completion, 5 regression, 1 alignment), all `done`. Drive: no stack (`review drive-stack` printed `none`); 29 stories driven, 29 drivers closed `done`, none driven again one at a time. Achieved on every surface and variant: 23 stories. Failed: certify-completion, keep-documentation-current, reference-names-the-public-surface, retire-a-legacy-suite, suite-gets-faster-over-time, turn-down-a-destructive-true-up. Failures sorted: 1 `defect` (i29, keep-documentation-current, merged as i70), 14 `backlog` (outside the sprint's scope: i27, i28, i30–i41). No stack, instance, or resource stop ran or failed. Every merge closed `done` on its first try.
- **sprint**:
  - Work item 1 (no seed where none exists): `tests tasks --stage write` → `tests::support_brief`, the test-write, test-speed, and test-support prompts, `{{TEST-WASTE-RULE}}`, the testing standard: works end to end.
  - Work item 2 (earlier-release mark claims no verdict): true-up plan → `true-up::certified_mark_steps`: works end to end.
  - Work item 3 (refile changes files in one write): `tasks refile --files` → `tasks::cmd_refile`: works end to end.
  - Work item 4 (review tool before the first commit): `review changed`/`snapshot`/`rotate` → `review::default_base`, `head_commit`: works end to end.
  - Work item 5 (bad folder list refuses): review and tests folder verbs → `review::declared_folders`: works end to end after the fixes to the review facts (i51, i53).
  - Work item 6 (doc sprint never stamps over a later commit): `docs start` → `docs::cmd_start`; `docs stamp` → `docs::cmd_stamp`: works end to end after fixes i42, i43, i45, i59, i60, i61.
  - Work item 7 (every stop ends its goal, resume): `review certified` → `review::cmd_certified` → `stopped_verdict`; `docs complete` → `docs::cmd_complete`; `tasks retry --all` → `tasks::cmd_retry` → `retry_records`; `tests::stage_write` → `blocked_on_support`; sprint and doc-sprint template steps, shared blocks, rules text: works end to end after fixes i52, i54, i55, i57, i62, i63, i70.
  - Improvement I1 (retry un-issues waiters in one write) and I2 (retry refuses a refiled-away task): `tasks retry <task>` → `cmd_retry`: work end to end; I2's refusal message fixed (i58).
  - Behavior changes: 32 changed definitions with users judged across 22 users; 2 became defects under R2/R3 (i44, i46), both verified.
  - Checks: `node .ok-planner/bin/plumbline` over the added and changed files passed before the fix loop and again after it. No note that the review read the project root alone.
  - Sent to the intake as outside the sprint's scope: 14 drive failures and 1 review report (i14, `tasks:cmd_refile`, waiters of a refiled task stay issued).
- **deltas**: 13 compared, 13 landed at build, 0 landed by this run, 0 stuck. None unsettled; no C3 defect unmatched.
- **fixed**: 17 `verified` (C1 ×6: i42, i52, i53, i59, i62, i63; A9 ×4: i51, i58, i61, i70; A3 ×2: i45, i54; A8 ×2: i43, i55; A1: i57; R2: i44; R3: i46), 3 `duplicate` (C1: i56, i60; C4: i47), 0 `declined`, 0 `stuck`. Fix rounds: 2. Send-backs: i43 ×1, i57 ×1, i59 ×1. Waits: none. Drive defect i70 confirmed by its confirm driver (t62); none left unconfirmed.
- **intake**: the owner list wrote 13 issues: 12 `category: defect` and 1 `product-intent`. `/triage-issues` (ledger `.ok-planner/tasks/triage-issues-2026-11-08T030418.jsonl`) routed 15 records: 11 `defect` for the next `/converge` (refile-leaves-waiters-issued, certified-counts-unrun-drives, doc-sprint-fixed-check-file-has-no-style-task, doc-sprint-lists-classes-in-one-checker-task, certification-speed-ignores-build-stage-verdicts, speed-ranking-keeps-batch-size-seconds, support-of-kept-legacy-test-deleted, nothing-to-plan-sweeps-untaken-legacy-tests, true-up-rewrites-untracked-edited-stamped-file, commit-patterns-refuse-sha256-names, sprint-stop-unreachable-without-review-script), 3 `question` for the next `/plan-sprint` (doc-handoff-commit-rewrite-reading, and the two planning-session issues scenario-list-decision-bundles-several-choices and test-speed-decision-bundles-several-choices), 1 `retired` (review-facts-describe-retry-and-refile-short: no accept-list entry covers prose in the review facts that describes the tracker's refusals less fully than the code). Clarity: 13 rewritten, 1 unchanged, 0 settled. Links: 16 written, 7 repaired, 0 unlinked. No stuck defect, no `environment` failure, no `judgment` or `upstream` item, no record rejected.
- **cost**: 9,106,116 tokens over 69 tasks in the certification ledger; triage 835,945 tokens over 11 tasks.
