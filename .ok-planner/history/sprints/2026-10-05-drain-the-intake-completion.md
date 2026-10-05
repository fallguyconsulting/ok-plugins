# Completion report: Drain the intake

Sprint: `.ok-planner/sprints/2026-10-05-drain-the-intake.md`

## Stages

- t1 — s01-catalog-toc. work item: Generate every catalog's table of contents with one script; decision:generated-catalog-tocs — done
- t2 — s02-fix-line-code. work item: Draw the run's fix line at ownership; decision:runs-fix-what-the-project-owns — done
- t3 — s03-fix-line-prompts. work item: Draw the run's fix line at ownership; decision:runs-fix-what-the-project-owns; decision:skill-text-is-reviewed-as-code; decision:defects-outside-scope-become-defect-issues — done
- t4 — s04-upstream. work item: Route harms in parts the project does not own to the intake as upstream issues; decision:foreign-harms-become-upstream-issues; decision:accept-list-decides-defects; concept:issue; decision:team-execution-cold-gate; decision:audit-audience-split — done
- t5 — s05-drivers. work item: Keep drivers off the project root; decision:drive-tries-each-story-as-a-user — done
- t6 — s06-state-files. work item: Remove a retired family's state files on converge; decision:whole-file-ownership — done
- t7 — s07-admin-doc. work item: Bring the administration document and the /ok report template up to the converge core — done
- t8 — s08-suite-texts. work item: Settle five contradicting suite texts; story:see-governing-versions — done
- t9 — s09-claim-once. work item: Tell every agent to claim once — done
- t10 — s10-session-start. work item: Delete the prose comment in the conduct's session-start hook — done
- t11 — s11-lint-per-line. work item: Judge each comment line at its own line in the lint — done
- t12 — s12-lint-patterns. work item: Label a comment by its own lines in plumbline patterns — done
- t13 — s13-tasks-item. work item: Refuse an item filed against a task the run lacks — done

## Divergences

i1 (call, s09-claim-once, open) — In ok-opus.md and ok-haiku.md the claim-once sentences go after the sentence that says what the claim prints (ending 'the items you consume.'), not between the command sentence and its 'It takes' continuation, so the pronoun 'It' keeps its referent.

i2 (call, s11-lint-per-line, open) — lint count change from per-line judging (node plugins/ok/families/ok-planner/scripts/plumbline): plugins/ 1 -> 11 (plugins/ok-web/skills/setup-dom-picker/reference/dom-picker.ts:1 header run now reports lines 1,3-9,11-13); checks/ 3 -> 18 (checks/oscillation header run 2-17 now reports each prose line, trailing comments at 49 and 50 no longer join and report separately, run 104-105 reports both). Every new report sits inside a comment that already failed; no new failing comment site, as B108 predicts.

i3 (call, s11-lint-per-line, open) — A trailing comment is detected by codePrecedes(content, pos): any non-whitespace between the line start and the comment opener, so a comment after a closing block comment or string on the same line also counts as trailing. A line-1 shebang is recognised by MACHINE_DIRECTIVE_PATTERNS.shebang on a line comment at line 1; JS-family files never extract '#!' as a comment, so the rule only bites in '#' grammars. 'Run opened by a citation line' reads as: the comment's first significant line starts with a configured citation tag (matchingCitation).

i4 (call, s12-lint-patterns, open) — plugins/ok/families/ok-planner/scripts/plumbline::commentHygieneShape: the file read moved inside the doc-residue branch (.go/.ts/.tsx/.js/.jsx only) and keeps its existing fallback to 'disallowed-prose' when the file cannot be read; the old out-of-range line guard is dropped because the lookahead loop already yields nothing past the end

i5 (call, s01-catalog-toc, open) — This repository's TOCs were regenerated with the source script (python3 plugins/ok/families/ok-planner/scripts/catalog-toc .), which also rewrites the subjects.md and practices.md headers to the shared template; the old materialized .ok-planner/bin/catalog-toc --check calls subjects.md and practices.md stale until the owner's /ok rematerializes it.

i6 (call, s01-catalog-toc, open) — unlisted behavior change: plugins/ok/families/ok-planner/admin/converge (converge mode, catalog-toc run); before: catalog-toc ran right after vendor_layer converge, and strip_story_sections hand-removed the falsifier line from design/concepts.md, reporting 'concepts.md TOC line' on its Retired story sections eliminated line; after: the hand edit is gone and catalog-toc runs after vendor_layer corpus, so the regenerated concept TOC drops the falsifier line in the same converge and the report line no longer names a TOC line; users: /ok's administration report (ADMINISTRATION.md falsifier paragraph updated to match). Verified on a scratch project.

i7 (call, s01-catalog-toc, open) — catalog-toc summary rule: where the named section (What it is / Story / Choice) is absent or empty the summary falls back to the first paragraph, and concepts and decisions still take its first sentence; aliases are read from a block list or an inline [a, b] list. Verified the new script reproduces all 35 concept, 23 story, and 51 decision rows of the prior TOCs byte for byte (only headers differ).

i8 (call, s01-catalog-toc, open) — checks/owned-paths: removed the falsifier-elimination needle for the dropped concepts.md hand edit and its now-dead 'toc' write_owner site entry (rule 1.4); plan-sprint SKILL.md's TOC sentence moved from the subjects-and-practices paragraph to the delta paragraph so it covers every delta; catalog-toc's body_after_frontmatter docstring deleted under the comment rule while the file was rewritten.

i9 (noticed, s01-catalog-toc, noticed) — plugins/ok/families/ok-planner/skills/_shared/design-doc-compliance-reviewer.md:172-197: the TOC consistency check classes 'a stale TOC line' as a mechanical fix to write, which invites a hand edit of a generated TOC; under decision:generated-catalog-tocs the fix is running python3 .ok-planner/bin/catalog-toc.

i10 (call, s02-fix-line-code, open) — review::left_alone's stamp test requires a rendered version (Materialized by ok-<name> v<digit>) on the last non-blank line or one of the first five, so this repository's product templates, which carry 'v{{OK_PLANNER_VERSION}}', classify as project, not suite; the cheatsheet's wording names only 'a Materialized by ok- stamp'.

i11 (call, s02-fix-line-code, open) — review::left_alone checks the path kinds (corpus, declaration, record, then the suite paths review/catalog/, package.json, .claude/rules/ok-concepts.md) before the stamp test, so a stamped generated TOC such as .ok-planner/subjects.md reads corpus and a record quoting a stamp stays a record. The record rotation path is the fixed .ok-planner/review/rotation.json, not config hunt.rotation.

i12 (call, s02-fix-line-code, open) — review backlog now prints {"reports": [...], "settled": [{"issue": <path>, "left_alone": {<path>: <suite|corpus|declaration|record>}}]}: an issue naming only left-alone files adds no report and lands in settled with each file's kind, for the converge skill and owner list (stage s03/s04) to route (suite to upstream, corpus or declaration to judgment, record answered). An issue naming no file outside exclude still aborts the step, as before; its message now reads 'names no file of this tree outside .ok-planner/review/config.json's exclude list' since prose paths count.

i13 (call, s02-fix-line-code, open) — review owner [--base <commit>] <path>... prints '<kind><TAB><path>' per path, kind one of project, suite, corpus, declaration, record; paths are relative to the project root (an absolute path is made relative); --base classifies a path the working tree no longer holds by its blob at that commit, and a --base naming no commit is refused. changed_files passes its own base to left_alone for deleted paths; scoped_files and backlog classify the working tree alone.

i14 (call, s02-fix-line-code, open) — admin/converge: removing REVIEW_ESTATE_PROBE left review_excludes and the fnmatch import unused; all three are deleted. The review-exclude offer matches the exact entries '.claude/' and '.ok-planner/' (ESTATE_EXCLUDES) and its resolve branch rewrites the owner's config through write_text(target_path, ...) inside the resolve region, which checks/owned-paths already allows, so checks/owned-paths is unchanged. The offer stands beside review-standards, only when the config parses with every required key.

i15 (call, s03-fix-line-prompts, open) — converge SKILL.md backlog step: for each issue review backlog lists under 'settled' (names only left-alone files), the session adds an open area=backlog report carrying the issue file, so the merge agent routes it by the one ownership test (judgment / upstream / rejected 'left alone') rather than the skill restating the kind-to-state mapping.

i16 (call, s03-fix-line-prompts, open) — owner-list.md interim upstream route: a report or failure at 'upstream' (suite-owned file) files as category: tooling naming the file as it sits in the project, and /triage-issues routes it upstream as today; stage s04 replaces this with category: upstream filing.

i17 (call, s03-fix-line-prompts, open) — merge.md ownership test: defined once as its own section; the general Judge list gains step 3a pointing to it, the sprint list's 3a and the drive paragraph apply it in every mode before the scope test. Where a fix spans several files the first holding outcome wins (corpus/declaration -> judgment, suite -> upstream, all records/release documents -> rejected with note 'left alone: <record or release document>; <file>'); a record or release document named beside project files is dropped from the fix's files.

i18 (call, s03-fix-line-prompts, open) — fix.md: a fixer whose defect's fix lies only in a left-alone file declines it naming the file and its review owner kind, and records it once as noticed with that file; verify.md accepts that decline reason; owner-list classifies every noticed call's file through review owner (record or release document: nothing filed, call settled promoted with note 'left alone ...; nothing filed', since the calls pool holds only open/promoted).

i19 (call, s03-fix-line-prompts, open) — {{FIX-LINE-RULE}} stands at each prompt's head beside {{PROSE-SCOPE-RULE}} (backout after {{LEAF-AGENT-RULE}}) rather than in the Rules section, so every 'the fix line rule above' reference reads forward. The owner-list prompt does not transclude it (its job writes the intake, a record) and restates the five kinds in its Read list.

i20 (call, s03-fix-line-prompts, open) — unlisted behavior change: converge/prompts/sprint-pass.md reading list; before: 'review changed --base [BASE]' with no --sprint; after: adds '--sprint [SPRINT PATH]', matching sprint-review and the skill's rule that every sprint-mode review changed call adds --sprint; users: a reissued sprint pass agent.

i21 (call, s03-fix-line-prompts, open) — The prompts call review owner through the vendored .ok-planner/bin/review and assemble {{FIX-LINE-RULE}} from the vendored .claude/skills/_converge/coding-rules.md (block_sources); in this repository both resolve only after the owner's /ok rematerializes them. Verified by assembling all seven prompts from the source blocks in a scratch project.

i22 (call, s04-upstream, open) — An issue written from proposal calls carries both ## Proposed entry (the defect claim triage judges against the accept list as it stands) and the ## Upstream issue draft; when triage routes it upstream, the author's rewrite replaces the body, so the entry wording then lives in the Upstream issue section alone.

i23 (call, s04-upstream, open) — triage.md step 2 now asks 'Where does the fix lie?' for every issue, defect claims included: a fix in a part the project does not own routes upstream ahead of the accept-list test, since no /converge agent may edit that part.

i24 (call, s04-upstream, open) — plan-sprint walks every upstream issue Frame set apart in both session kinds (not filtered by the relevance pass in a feature-work sprint), and the owner may leave one open for a later session; an upstream issue whose Ruling holds the owner's own words is ruled and rides the Frame sweep.

i25 (call, s04-upstream, open) — owner-list.md: a session-note is upstream where review owner classes its file suite, tooling otherwise; a drive failure at environment whose cause lies in a dependency library or an outside tool or service files as upstream; every upstream filer (owner list, judge, build) searches the intake for an open issue on the same harm first.

i26 (call, s04-upstream, open) — AUDIT-JUDGE-PROMPT: the upstream route covers a confirmed gap, contradiction, observation, or blocker whose fix lies in a foreign part; a practice violation never routes upstream, the practice being the project's own. B11's closed answered-upstream records under history/issues/ are left untouched (preserve).

i27 (call, s04-upstream, open) — The materialized copies (.claude/skills/*, .claude/rules/ok-planner-cheatsheet.md, .ok-planner/CLAUDE.md, .ok-planner/review/CLAUDE.md) and this run's registered build prompt keep the old route until the owner's /ok rematerializes them; this stage edits only the product source under plugins/.

i28 (call, s06-state-files, open) — admin/converge::state_file_removable is the one predicate for both retired state files (budget baseline, workspaces profile): git tracks it, no uncommitted change, no symbolic link above it, and the file itself is not a symbolic link. A state file that is itself a link is read as 'symlinked' under decision:whole-file-ownership and gets estate-edits; the notes named only 'behind a link'.

i29 (call, s06-state-files, open) — unlisted behavior change: admin/converge::estate_edits_offer; before: a path that is itself a symbolic link (and not uncommitted or behind a link) read 'carries no suite stamp, so it may hold the project's edits'; after: it reads 'is a symbolic link' with Show: cat; users: /ok's offer presentation for a linked suite file in the retired plumbline or workspaces estate. The function gained a state_file noun for the two state-file wordings (untracked: 'is not tracked by git, so version history cannot recover it'); suite-file wording is unchanged.

i30 (call, s06-state-files, open) — The budget offer's old aside 'A project turns a lint check off with lint_checks in .ok-planner/config.json' is dropped with the retired-file offer; the retired-verb table in ADMINISTRATION.md and /ok's report still name lint_checks as budget's replacement. The workspaces diagnose line is unchanged: it already names every file it removes, the profile included. ADMINISTRATION.md line 32 ('the retired estate payloads itself, with no offer and no commit check') was left as is; stage t7 owns the document's alignment with the core.

i31 (call, s08-suite-texts, open) — No @story: see-governing-versions annotation in plugins/ok/families/ok-planner/skills/ok-version/SKILL.md: the project's citation convention, enforced by checks/materialized-standalone, refuses a live-corpus citation in vendored family markdown (it does not stand alone in a consumer). The story stays unannotated in code; no other site in this stage's files realizes it.

i32 (call, s08-suite-texts, open) — checks/ceremony-surfaces checks the explicit-activation sentence only for audit and document, not ok-version; the /ok-version description keeps the slash-only sentence anyway (the family CLAUDE.md calls it load-bearing on every skill), and checks/ceremony-surfaces is left unchanged.

i33 (call, s08-suite-texts, open) — /ok-version installed-plugin step reads the claude plugin list --json entry whose id begins 'ok@' (ids carry the marketplace suffix, e.g. ok@<marketplace>); a failed command or missing entry reports unknown. The skill also names /ok among the follow-ups in its investigate sentence.


# Sprint certification

Ledger: `.ok-planner/review/runs/converge-2026-10-05T024119.jsonl` (run folder beside it).

- **mode**: sprint, `.ok-planner/sprints/2026-10-05-drain-the-intake.md`, base `e32d4523520633f24cfc9659cf791d4450d7c514`.
- **hunt**: one review root (t1) and 13 passes (5 completion, 7 regression, 1 alignment), every pass closed `done`. 14 reports: 13 merged, 1 rejected (i9, `catalog-toc::frontmatter_lines` not real). Drive: `story:see-governing-versions`, one driver over the `/ok-version` skill surface (no stack: the project declares none), outcome `failed` with 3 failures: 2 `defect`, 1 `backlog`, 0 `not-owed`, 0 `environment`, 0 `judgment`.
- **sprint**:
  - Draw the run's fix line at ownership, with I1 and I2: works end to end (entry `P/skills/converge/SKILL.md::Scope` → `P/scripts/review::cmd_files/cmd_changed/cmd_owner/cmd_backlog` → `merge.md` ownership test).
  - Route harms to upstream issues, with I3: works (entry `owner-list.md`, triage routes, `AUDIT-JUDGE-PROMPT`, `SPRINT-BUILD-PROMPT`, plan-sprint Frame and Resolve), after fixes i32, i34, i35, i36.
  - Keep drivers off the project root: works (entry `drive.md::Rules`).
  - Remove a retired family's state files: works (entry `admin/converge::plumbline_plan`, `::workspaces_plan`), after fix i31 in `review::left_alone`.
  - Generate every catalog's table of contents with one script: works (entry `scripts/catalog-toc::main`), after fix i26 in the compliance reviewer.
  - Bring the administration document and `/ok` report up to the converge core: works.
  - Settle five contradicting suite texts: works; `/ok-version` after fixes i22 and i23, confirmed by two confirm drives (`achieved`).
  - Tell every agent to claim once: works.
  - Delete the session-start prose comment: works.
  - Label a comment by its own lines: works, after fix i38.
  - Judge each comment line at its own line: works, after fix i37.
  - Refuse an item filed against a task the run lacks: works.
  - Behavior changes judged: B1–B28 and B100–B112 by the regression passes; 7 became defects (i29/i30 B3, i31 B1, i33 B7, i34 B14, i37 B109, i38 B107). Deltas: all 11 applied byte for byte; design tables of contents regenerated.
  - Checks: `node .ok-planner/bin/plumbline` over the 42 changed files, passed before and after the fix loop.
  - Sent to the intake as outside the sprint's scope: failure i4 (`/ok-version` absent outside integrated projects).
- **fixed**: 12 `verified` (i22, i23, i26, i29, i31, i32, i33, i34, i35, i36, i37, i38), 0 `declined`, 3 `duplicate` (i27, i28 of i26; i30 of i29), 0 `stuck`. One fix round, 9 fix tasks, 9 verify tasks, 0 send-backs. Final checks passed.
- **intake**: the owner list wrote 7 issues: 3 `category: defect` and 4 `product-intent` (i4's backlog failure folded into `version-surface-absent-outside-integrated-projects`). No stuck defect, no `environment` failure, no `judgment` report. Unlisted calls, as a record: i5/i8 `admin/converge::estate_edits_offer` wording for a linked file; i6 `admin/converge::strip_story_sections` removal and run order; i7 `sprint-pass.md` adds `--sprint` to `review changed`.
  - `/triage-issues` (ledger `.ok-planner/tasks/triage-issues-2026-10-05T030602.jsonl`) took 9 open files: 1 retired (`triage-skill-tooling-definition-omits-ownership`: no accept-list entry covers a wording difference the skill's upstream route already settles), 2 `defect` for the next `/converge` (`cheatsheet-says-silence-accepts-every-ruling`, A8; `review-backlog-aborts-after-partial-writes`, A1), 6 `question` for `/plan-sprint`: `backout-exception-to-left-alone-files` (correct the converge skill's exception list), `installed-version-entry-selection` (amend the story: installed means what a new session would load), `version-surface-absent-outside-integrated-projects` (amend the story's actor to an integrated project's owner), `lint-patterns-divider-bound` (drop the divider length bound), `retired-run-tag-callers-never-repointed` (extend the lint's script-path repoint offer to run-tag), `migration-leaves-project-configs-stale` (migrate configs and offer `folders`).
- **cost**: 2,278,047 tokens over 40 tasks (certification), plus 412,427 tokens over 4 tasks (triage).
