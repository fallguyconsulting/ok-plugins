# Completion report: Fourth intake drain

Sprint: `.ok-planner/sprints/2026-10-22-fourth-intake-drain.md`

## Stages

- t1 — corpus-catch-up. item-1; story:rule-the-public-surface; story:bootstrap-design-corpus; decision:discovery-notes-archived-on-consent; decision:corpus-audit-hands-a-discovery-to-planning; decision:intake-writers-are-gated; decision:final-form-deltas; decision:records-stay-out-of-context; decision:whole-file-ownership; decision:code-cites-design; concept:design-corpus — done
- t2 — upstream-filing-not-asked-again. item-3; story:rule-on-the-whole-intake; decision:foreign-harms-become-upstream-issues — done
- t3 — certification-checklist-marked. item-4; story:watch-execution-progress; decision:task-tools-mirror-the-report — done
- t4 — ok-version-installed. item-9; story:see-governing-versions; decision:per-project-pinning — done
- t5 — sketch-no-overwrite. item-12; story:sketch-an-idea — done
- t6 — wait-not-send-back. item-6; story:find-and-fix-defects; decision:converge-finds-then-fixes — done
- t7 — payload-citations-stripped. item-17; story:veto-calls-made-in-my-absence; decision:payload-citations-stripped-at-true-up — done
- t8 — surface-and-readme-docspec. item-2; decision:every-public-class-has-a-reference — done
- t9 — docspec-concept. item-16; concept:docspec; story:reference-names-the-public-surface — done
- t10 — true-up-keeps-uncommitted. item-19; story:true-up-project-estate; decision:true-up-asks-once-before-destructive-steps; decision:whole-file-ownership — partial
- t11 — audit-no-open-finding. item-8; story:bootstrap-design-corpus; decision:corpus-audit-hands-a-discovery-to-planning — done
- t12 — verified-decline-closes. item-10; story:find-and-fix-defects — done
- t13 — undriven-sprint-not-done. item-5; story:certify-completion; decision:drive-tries-each-story-as-a-user — done
- t14 — dropped-folders-reported. item-7; story:project-spans-folders — done
- t15 — backlog-extensionless. item-11; story:find-and-fix-defects — done
- t16 — certification-deltas-line. item-13; story:certify-completion — done
- t17 — confirm-drivers. item-14; decision:drive-tries-each-story-as-a-user — done
- t18 — approval-mark. item-15; story:plan-a-sprint; decision:sprints-carry-an-approval-mark — done
- t19 — plain-converge-vetoes. item-18; story:veto-calls-made-in-my-absence; decision:converge-close-takes-vetoes; decision:converge-finds-then-fixes — done
- t20 — true-up-keeps-uncommitted. item-19; story:true-up-project-estate; decision:true-up-asks-once-before-destructive-steps; decision:whole-file-ownership — done

## Calls

| id | kind | stage or role | site | choice |
|---|---|---|---|---|
| i1 | improvement | sketch-no-overwrite | plugins/ok/families/ok-planner/skills/sketch/SKILL.md::Process-step-4 | I102: a sketch name is free only where neither sketches/ nor history/sketches/ holds it |
| i2 | noticed | corpus-catch-up | plugins/ok-web/skills/setup-dom-picker/reference/dom-picker.ts | left as it stands; outside this stage's files |
| i3 | call | upstream-filing-not-asked-again | plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md::Resolve | Walk's File upstream and Both answers left as written |
| i4 | call | certification-checklist-marked | plugins/ok/families/ok-planner/scripts/ok-planner-cheatsheet.md::Lifecycle | left the per-stage checklist restatements in ok-planner-cheatsheet.md:118 and ok-planner-CLAUDE.md:5 |
| i5 | call | verified-decline-closes | plugins/ok/families/ok-planner/skills/converge/prompts/owner-list.md::Close the issues the run resol | a boundary-question decline turns its issue into a product-intent judgment issue with a '## Declined |
| i6 | call | verified-decline-closes | plugins/ok/families/ok-planner/skills/converge/prompts/owner-list.md::Close the issues the run resol | a noticed or question call on a verified decline with an issue field goes to that issue alone |
| i7 | call | verified-decline-closes | plugins/ok/families/ok-planner/skills/converge/prompts/owner-list.md::Close | '<n> declined' counts verified declines and duplicates closed answered; turned issues count under th |
| i8 | improvement | payload-citations-stripped | checks/materialized-standalone::PAYLOADS | I101: the PAYLOADS table is gone; the check lints every file true-up writes under the four script fo |
| i9 | call | payload-citations-stripped | plugins/ok/families/ok-planner/admin/true-up::suite_renderings | left the function's docstring as it stands, though it names three forms and the set now holds four |
| i10 | call | payload-citations-stripped | plugins/ok/families/ok-planner/admin/true-up::CITATION_LINE | the pattern takes optional spaces or tabs between the tag and the slug, and a CRLF or a final line w |
| i11 | call | payload-citations-stripped | .ok-planner/review/project.md::checks | left project.md's checks entry unchanged: the check still takes no inputs |
| i12 | call | payload-citations-stripped | docs/integration-contract.md::layer-1 | layer 1 names the executable support scripts and the hook implementations as written with citation c |
| i13 | call | audit-no-open-finding | plugins/ok/families/ok-planner/skills/discover-design/SKILL.md::7. Review | the merge refile's brief lists each finding with its site, decided, and fix, then the fix-or-ask ins |
| i14 | call | undriven-sprint-not-done | plugins/ok/families/ok-planner/scripts/review::cmd_certified | n counts the distinct stories the ledger's story drive tasks name |
| i15 | call | undriven-sprint-not-done | plugins/ok/families/ok-planner/scripts/review::undriven_reason | a caught ReviewError becomes the failure reason with no event |
| i16 | call | undriven-sprint-not-done | plugins/ok/families/ok-planner/scripts/review::certification_failures | cites story:certify-completion and decision:drive-tries-each-story-as-a-user |
| i17 | call | undriven-sprint-not-done | plugins/ok/families/ok-planner/scripts/review::STORY_BRIEF | one constant for the 'story ' brief prefix, shared by cmd_drives and driven_stories |
| i18 | call | true-up-keeps-uncommitted | docs/integration-contract.md::The plan and the one consent | also amended the guarantee sentence of the plan-and-consent bullet |
| i19 | call | true-up-keeps-uncommitted | plugins/ok/families/ok-planner/admin/true-up::materialize_steps | the destructive stale step's Show comes from archive_show([path]) |
| i20 | call | true-up-keeps-uncommitted | checks/owned-paths::copy_step region | left the check's region marker for the caller to repoint |
| i21 | improvement | dropped-folders-reported | plugins/ok/families/ok-planner/scripts/review::cmd_certified | I1: item 2's line names the root-alone fallback |
| i22 | call | dropped-folders-reported | plugins/ok/families/ok-planner/scripts/review::cmd_certified | the note rides item 2's line whether it holds or fails |
| i23 | noticed | dropped-folders-reported | plugins/ok/families/ok-planner/admin/true-up::copy_step | owned-paths check fails on true-up, outside this stage |
| i24 | improvement | backlog-extensionless | plugins/ok/families/ok-planner/scripts/review::backlog_entry | I2: the site is the first path:function whose path is among files, else files[0] |
| i25 | call | backlog-extensionless | plugins/ok/families/ok-planner/scripts/review::backlog_entry | trailing dots are stripped from the site's function name as well as its path |
| i26 | call | true-up-keeps-uncommitted | plugins/ok/skills/ok/SKILL.md::step 5.4 | Left /ok step 5.4 text as it stands |
| i27 | call | certification-deltas-line | plugins/ok/families/ok-planner/scripts/review::cmd_deltas | landed_by_run also needs the comparison to hold; a delta with no live C3 defect that still differs g |
| i28 | call | certification-deltas-line | plugins/ok/families/ok-planner/scripts/review::cmd_deltas | compared is a count; unsettled entries are {delta, why}; unmatched entries are {defect, state, files |
| i29 | call | certification-deltas-line | plugins/ok/families/ok-planner/scripts/review::delta_failures | split the per-delta comparison into delta_failure and delta_name, shared by delta_failures and cmd_d |
| i30 | call | certification-deltas-line | plugins/ok/families/ok-planner/skills/converge/SKILL.md::The return | the deltas bullet also lists each unsettled delta with why and each unmatched C3 defect |
| i31 | call | confirm-drivers | plugins/ok/families/ok-planner/scripts/review::unconfirmed_drive_defects | selection split out of confirm_briefs so the dry run and the filing share one selector |
| i32 | call | confirm-drivers | plugins/ok/families/ok-planner/scripts/review::cmd_drives | refuse --dry-run without --confirm before reading project.md; dry run reads no story lists |
| i33 | call | confirm-drivers | plugins/ok/families/ok-planner/scripts/review::confirm_briefs | added # @decision: drive-tries-each-story-as-a-user at confirm_briefs |
| i34 | call | confirm-drivers | plugins/ok/families/ok-planner/skills/converge/SKILL.md::Loop 2 | final confirm runs once per run from step 2, in its own round, then back to step 1 |
| i35 | call | approval-mark | plugins/ok/families/ok-planner/scripts/review::frontmatter_value | a frontmatter value is everything after the key, trimmed, so a multi-word approved: value counts |
| i36 | call | approval-mark | plugins/ok/families/ok-planner/scripts/review::base_file | one helper names a sprint's -base.txt path for sprint_base and approval_refusal |
| i37 | call | approval-mark | plugins/ok/families/ok-planner/scripts/review::cmd_approved | the refusal raises ReviewError, so main prints 'review: <message>' on stderr and exits 1 |
| i38 | call | approval-mark | plugins/ok/families/ok-planner/skills/plan-sprint/sprint-document.md::How to execute this sprint ste | step 2 runs review approved first and its refusal text names a draft or a missing review config |
| i39 | noticed | approval-mark | plugins/ok/families/ok-planner/scripts/docs::closed_stamp | left as is: outside this stage's files |
| i40 | call | plain-converge-vetoes | plugins/ok/families/ok-planner/skills/converge/SKILL.md::The run leaves the owner nothing to settle | Retitled the paragraph "The run never waits on the owner while it finds and fixes", the amended deci |
| cert:i2 | rejected | session | plugins/ok/families/ok-planner/admin/true-up | gone: checks/owned-paths now names def copy_step(plan, path, reason): and passes |
| cert:i5 | not-owed | drive | story:edit-time-lint-enforcement hook:post-edit/whole | two readings; asked the owner |
| cert:i17 | rejected | pass | plugins/ok/families/ok-planner/skills/ok-version/SKILL.md:Procedure | two readings; asked the owner |
| cert:i21 | not-owed | drive | plugins/ok/families/ok-planner/scripts/docs | two readings; asked the owner |
| cert:i27 | not-owed | drive | story:project-spans-folders .ok-planner/bin/tests/whole | two readings; asked the owner |
| cert:i36 | not-owed | drive | plugins/ok/families/ok-planner/skills/plan-docs/doc-sprint-document.md | a no-item verdict comes from the planner, whose step 1 already fires on a public element the file la |
| cert:i40 | not-owed | drive | plugins/ok/families/ok-planner/skills/ok-version/SKILL.md | two readings; asked the owner |
| cert:i55 | duplicate | merge | plugins/ok/families/ok-planner/admin/true-up:materialize_steps | duplicate of i52 |
| cert:i56 | duplicate | merge | plugins/ok/skills/ok/SKILL.md:Process step 5.4 | duplicate of i53 |


# Sprint certification

Ledger: `.ok-planner/review/runs/converge-2026-10-22T030501.jsonl` (run folder `.ok-planner/review/runs/converge-2026-10-22T030501/`).

- **mode**: `sprint` — `.ok-planner/sprints/2026-10-22-fourth-intake-drain.md`, base `e9949f9361837088e8911b7bbae265b8f976418d`. The build run file existed. No paths outside the project root.
- **hunt**: the review root (t1) and its nine pass tasks (t30–t38: four completion, four regression, one alignment) closed `done`; the find loop ran once. Reports: 11 (3 from the build's noticed items, 8 from the passes) — 7 merged, 2 set to `backlog`, 2 rejected. The drive took all 27 stories with no stack (`- No stack:`); every driver closed `done`. Failures: 36 — 9 `defect`, 5 `not-owed`, 22 `backlog`; none `environment`, `judgment`, `upstream`, or `rejected`. The project declares no `stack-stop`, `instance-destroy`, or `resource-stop` line, so no teardown task was filed and none failed. Every merge closed `done` once.
- **sprint**:
  - Work items 1–19 and improvements I1, I2, I101, I102 each reached their entry point, per the root's close: items 5, 7+I1, 13, 14, 15 through `scripts/review` (`cmd_certified`, `project_folders`/`declared_folders`, `cmd_deltas`, `cmd_drives --confirm --dry-run`, `cmd_approved`); items 3, 6, 10, 11+I2, 18 through the plan-sprint and converge skill text and `scripts/review::backlog_entry`; items 1, 2, 16, 17+I101, 19 through the corpus, the surface intent, `admin/true-up` and `checks/materialized-standalone`; items 4, 8, 9, 12+I102 through the sprint template, `scripts/discover::assembled`, `/ok-version`, and `/sketch`. Each works end to end, save item 15's corpus-delta reader (defect i68, stuck, below).
  - Deltas: 18 compared (2 stories, 1 retirement, 4 new decisions, 7 amended decisions, 2 concepts, the surface intent, the README docspec); all 18 landed at build, byte for byte; none landed by this run; none stuck.
  - Behavior changes judged: 31 (23 `rewrite`, 5 `migrate`, 1 `preserve`, 2 `rewrite across trued-up projects`); one, B114 (`migrate`), became defects: i53, with i56 its duplicate.
  - Stories driven: 27. Failures came from 16 stories; the merged defects came from `certify-completion`, `bootstrap-design-corpus`, `plan-a-sprint`, `find-and-fix-defects`, and `veto-calls-made-in-my-absence`; the 11 other stories' drivers recorded no failure.
  - Checks: `node .ok-planner/bin/plumbline` over the changed files passed at the start (t2) and after the fix loop (t66), over 27 changed files; `bash checks/run` also passes.
  - Sent to the intake as outside the sprint's scope: 24 items (2 reports, 22 failures).
- **fixed**: 13 defects — 10 `verified` (A9 ×4: i48, i50, i65, i67; A8 ×2: i51, i69; A3 ×2: i52, i66; R2: i53; C1: i54), 2 `duplicate` (i55 of i52, i56 of i53), 1 `stuck` (i68, A9). Fix rounds: 2. Send-backs: i66 ×1, i67 ×1, i68 ×2 (the second by its confirm driver). Confirm drivers ran for all 6 verified drive defects; 5 confirmed, i68 sent back.
- **ledger**: `.ok-planner/review/runs/converge-2026-10-22T030501.jsonl`.
- **intake**: the owner list (t67) wrote 30 issues — 22 `category: defect`, 6 `product-intent`, 1 `tooling`, and turned stuck defect i68 into the `design` issue `delta-body-inner-fence-breaks-certification` (its last verifier's note: the fix handles the reported trigger, but a bare inner code block holding lines that read as sprint headings still closes the outer fence early, so `sprint_deltas` and `inline_body` misread the deltas; a four-backtick outer fence reads correctly). The backout (t65) closed `done`. No `environment` failure; no item set to `judgment` or `upstream`; no item rejected as a record. `/triage-issues` (ledger `.ok-planner/tasks/triage-issues-2026-10-22T051147.jsonl`) took 37 unrouted issues: it answered `drive-leaves-pycache-in-family-scripts` (the session removed the folder) and retired `discovery-answer-line-reads-news` (no accept-list entry covers it); it routed 21 `defect` for the next `/converge`, 13 `question` and 1 `corpus` (`doc-edit-rules-ignore-reader-and-covers`) for the next `/plan-sprint`, each with a generated or recommended ruling; the clarity pass read all 35 routed issues and the link pass linked all 35; no person's message waited.
- **cost**: 7,509,055 tokens over 67 tasks in the certification ledger; triage 2,788,320 tokens over 26 tasks.
