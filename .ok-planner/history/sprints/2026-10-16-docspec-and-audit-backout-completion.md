# Completion report: Back out the audit, add docspecs, and true up the whole estate

Sprint: `.ok-planner/sprints/2026-10-16-docspec-and-audit-backout.md`

## Stages

- t1 — s-backout. work items 1 and 8: back /audit and /document out of the payload — done
- t2 — s-sprint-text. work items 1, 2, 3, 4, 9, 19: planning and sprint-execution text — done
- t3 — s-review. work items 4, 7, 18, 19: the review tool — done
- t4 — s-issues. work items 3, 12, 19: the intake module and page — done
- t5 — s-plumbline. work items 1, 19: the lint and ports — done
- t6 — s-catalog-toc. work item 3, I2: the docspec index — done
- t7 — s-tasks. work items 9, 16: the calls table and refile — done
- t8 — s-rules. work items 1, 2, 5, 9, 12: the rules layer and README — done
- t9 — s-corpus. every corpus delta — done
- t10 — s-run-group. work items 2, 10: run-group lends no terminal — done
- t11 — s-discover. work items 1, 17, 19, I102: discover-design and triage text — done
- t12 — s-conduct. work item 15: the conduct's writing standard — done
- t13 — s-oscillation. work items 8, 13, I1: the oscillation check — done
- t14 — s-mcp. work item 11: a browser tool for drivers — done
- t15 — s-definitions. work items 3, 5, 6, 12, 14, I101: shared definitions — done
- t16 — s-converge-text. work items 4, 7, 9, 16, 18, 19: the /converge text — done
- t17 — s-trueup-plan. work items 5, 19: true-up's one-consent plan — done
- t18 — s-trueup-backout. work items 1, 5, 6: true-up's back-out steps — done
- t19 — s-admin-text. work items 1, 5, 6: the administration text — done
- t20 — s-facts. work items 1, 3, 5, 7, 9, 10, 12, 18, 19: the project's review facts — done

## Divergences

i1 (call, session, open) — Every corpus delta lands in the one stage s-corpus rather than with each work item's code: the deltas are verbatim copies, and one stage avoids chaining every delta-bearing stage on the catalog TOCs. No new code citation names a slug s-corpus adds before the stages that cite it run after it or cite slugs that already exist.

i2 (call, session, open) — Every change the notes name to .ok-planner/review/project.md (work items 1, 3, 5, 7, 9, 10, 12, 18, 19) lands in one stage, s-facts, after the code stages, rather than in each script's stage: nine stages edit the file, and one late stage avoids chaining all of them.

i3 (call, session, open) — Parts of work items 8 and 4 move to the stage whose change would otherwise break a repo check: checks/ceremony-surfaces, checks/run, and checks/vendored-layer land in s-backout with the skill removal; the {{RELEASE-DOCUMENTS-RULE}} line leaves the converge prompts in s-sprint-text with its definition; owned-paths' catalog-toc needle lands in s-catalog-toc; owned-paths' true-up pins land in the two true-up stages.

i4 (call, s-catalog-toc, open) — The docspec entry is ("docspec", "Docspec index", "Docspecs", "docspec", None, None, False); row_of renders its row and preamble_of its header, both dispatching on kind like label_of; the empty index reads '(none yet — this project has authored no docspecs)'.

i5 (call, s-catalog-toc, open) — docspec_where takes the first non-blank line of the ## Where section as written (backticks kept); a section that is absent or holds only blank lines gives 'not declared'.

i6 (call, s-catalog-toc, open) — docspec_references keeps each bullet's first line as written (backticks kept, continuation lines dropped), joins them with ', ', and gives 'none' where the section is absent or has no bullets.

i7 (call, s-catalog-toc, open) — I2: write_replacing writes <target>.<pid>.tmp with open(...,'w') (so the TOC keeps umask permissions, unlike mkstemp's 0600), os.replace moves it onto the target, and a finally removes the staging file where the write or the replace failed (exercised: a replace onto a directory exits 1 and leaves no .tmp). checks/owned-paths now requires the open(...,'w') write site to be staging and the needles for the staging path and os.replace(staging, target).

i8 (call, s-plumbline, open) — The notes remove RETIRED_LINT_CHECK_NAMES, but lintChecksDefects must still recognize compose-ports and compose-labels to report them as retired checks with 'run /ok, which removes it'. The list's job changed from acceptance to refusal, so it stays under the name RETIRED_COMPOSE_CHECK_NAMES (true-up's own list is RETIRED_COMPOSE_CHECKS). An unknown name still gets the unknown-check defect.

i9 (call, s-plumbline, open) — CONFIG_PATHS becomes CONFIG_REL (.ok-planner/config.json) and configPathFor returns it under the root with no existence probe; ROOT_MARKERS becomes ROOT_MARKER (.ok-planner). Per the brief, the .claude/rules/plumbline-cheatsheet.md marker goes with .ok-plumbline, .ok-workspaces, and .plumbline.json, so a project with only the rules file no longer roots the lint there (B30).

i10 (call, s-plumbline, open) — WI 19 says a script that meets an earlier layout refuses naming /ok. The notes make the lint read .ok-planner/config.json alone and root at .ok-planner alone, and name no refusal for the retired config files, so the lint never looks at them: in a project still on the plumbline layout it lints with defaults and does not read the old config (exercised: a .plumbline.json naming a bogus check is not refused). True-up moves the old config in its plan (B30, migrate).

i11 (noticed, s-plumbline, noticed) — bash checks/run fails two checks outside this stage: ceremony-surfaces (checks/run still runs checks/ceremony-surfaces, which s-backout removed; WI 8) and materialized-standalone on plugins/ok/families/ok-planner/scripts/tasks:1297, a prose comment (s-tasks is running). Every other check passes, and materialized-standalone reports nothing for plumbline or ports.

i12 (call, s-backout, open) — checks/vendored-layer parses the two retired tuples out of the payload's admin/true-up source (regex on the assignment, ast.literal_eval on the tuple) and fails naming the list when either assignment is missing. A .claude/skills/<name> folder outside the payload passes with the note 'retired by the payload; the owner's next /ok removes it' only when it is in either list, git tracks it, and its SKILL.md's last non-blank line starts with the true-up's stamp prefix '<!-- Materialized by ok' (true-up's stamped()).

i13 (call, s-backout, open) — WI 1 says no prompt in the family names an experiment; {{READ-ONLY-REVIEWER-RULE}} listed 'experiments' among what a reviewer never runs. The notes do not list this site. Dropped the word; the remaining list (tests, builds, deployments, the project's stack) still covers every execution a reviewer must not do.

i14 (call, s-backout, open) — Lines 145-148 now read: 'Qualitative language — correct, clear, helpful, canonical — is not a form violation: the drafter writes the concrete version per {{DECIDABILITY-BOUNDARY}}. Do not ask for a story to be rewritten in mechanical phrasing.' The 'audits attach ... referrals' clause is gone. The substitution note's 'blocks to audit' also became 'blocks to review' with the slot rename.

i15 (call, s-backout, open) — Line 13 reads 'The sign-off review flags them in a delta.' In {{DECIDABILITY-BOUNDARY}} the first rule drops 'the process records it and does not rule on it' with the referral rule, since nothing records it any more; it ends 'What survives is residue a human discipline owns.' The 'Classifying a decidable claim as qualitative to escape work is itself a finding' sentence stays.

i16 (call, s-tasks, open) — The stage-or-role column reads the recording task's role in either ledger: a row recorded by a build task shows the item's key (the stage), a row recorded by any other task shows that task's role, and a row with no recording task shows session. So `tasks calls` on a plain /converge ledger shows roles, not the shared key gate, and a builder's item filed without --task shows session.

i17 (call, s-tasks, open) — `tasks config set calls` refuses a value that is not a list of {pool, states?, kinds?} selectors (pool a string, states and kinds lists of strings, no other key), and call_rows applies the same check to a value a registry loaded, so a malformed selector fails with a message instead of a traceback.

i18 (call, s-tasks, open) — cmd_render reads the build tasks and the run's call rows, closes the run's store, and only then opens the --certification ledger's Store (closed in a finally), so the two ledgers' locks are never held together and a --certification naming the run's own file does not deadlock on its flock. The pointer is never written.

i19 (call, s-tasks, open) — The site fallback for a failure reads the failures pool only, and needs a story field; a missing surface or variant prints as -. A skill-surface failure carries file, which comes first.

i20 (fork, s-tasks, fork) — WI 9's calls and the brief put `# @story: veto-calls-made-in-my-absence` on calls_table in scripts/tasks, and the build prompt annotates every story site. checks/materialized-standalone lints every payload script as it stands in a consumer, where no @story: citation is declared, and fails on the line (decision whole-file-ownership, concept integration-contract); no payload script carries a citation today. Built: no annotation. Options: (1) no annotation in the payload script (built); (2) annotate and teach materialized-standalone to accept citations in scripts that resolve in this repo's corpus; (3) cite the story from a repo-only site, such as checks/ or admin/true-up, that does not realize it.

i21 (call, s-corpus, open) — The brief counts 23 retirements and 75 headings; the sprint's Corpus deltas section holds 25 Retire headings (7 concepts, 6 stories, 12 decisions) and 52 New/Amend headings, 77 in all, each resolving to a file, and the sidecar holds exactly the 52 files those headings name. Applied every heading as the sprint states it.

i22 (noticed, s-corpus, noticed) — plugins/ok/families/ok-planner/scripts/issues:398 and :1207 carry comments the lint rejects (comment-hygiene), so bash checks/run fails materialized-standalone; the file is modified in the working tree outside s-corpus's files.

i23 (call, s-review, open) — A flow area is named flow:<class>@<path> with each whitespace run in the class replaced by '-', so a class such as 'CLI verbs' gives flow:CLI-verbs@cli/main.py; merge briefs, tally --areas, and the round file carry area names as space-separated tokens. The brief and the area's 'class' field keep the class as written.

i24 (call, s-review, open) — WI 7 names a stderr note for a literal path the tree lacks; a declared glob that matches no listed file prints the same note and is skipped, so an owner sees every declaration that cut no area. Globs match with fnmatch over git ls-files paths, so * crosses '/'.

i25 (call, s-review, open) — The section runs from '## Where each class is declared' to the next line starting '#'. Blank lines are skipped silently; any other line not of the form '- <class>: `<path or glob>`[, `<path or glob>`]' prints 'areas: <intent> line N ... skipped' on stderr.

i26 (call, s-review, open) — areas.json 'surface' is .ok-planner/surface/surface.md when that file exists, null otherwise. The note 'areas: no surface intent at ... (or it names no declaring file); the run hunts files alone' prints whenever the run cuts no flow area, which covers an intent whose every declaring path is missing or left alone.

i27 (call, s-review, open) — With no stored entry list, the areas file's 'entries' field went from both shapes (its only readers were the flow rotation key and the flow brief). area_keys now yields (key, path) pairs, so area_priority and cmd_rotate hash a flow area's declaring file the same way they hash a file area's files.

i28 (call, s-review, open) — One verify per refile chain within the snapshot's round. The brief reads 'fix tasks <chain ids in filing order>; defects <fixed, declined, or duplicate batch items>; before: <every staged path across the chain>', matching backouts' 'fix tasks' wording. Batch items and staged paths are deduplicated in first-seen order, so a refile that copies batch_items (stage s-tasks) files no second verify.

i29 (call, s-rules, open) — Filing names /converge's owner list as the one writer of defect issues, drops the audit judge, and adds that true-up files under kind audit too (one issue per retired suite script caller it cannot repoint, one for an undecodable review facts file), per WI 2's build note.

i30 (call, s-rules, open) — The configuration section named a per-item /ok offer as a writer of config.json; the offer model is retired (WI 5), so the sentence now names /ok's plan rewrite of retired keys and its transcription of the owner's input answers, per whole-file-ownership.

i31 (call, s-rules, open) — Beyond WI 2's listed README changes, the Install paragraph's migration sentence now says the earlier layout is brought current with the owner's work kept in place or in the archive, and that /ok shows the whole plan and asks once (go ahead or abort, which writes nothing) where a step is destructive, per true-up-asks-once-before-destructive-steps. Left, the paragraph would describe the retired per-item model by omission.

i32 (call, s-rules, open) — Project records adds that a project trued up past the retired /audit and /document holds history/audits/, history/experiments/, history/documentation/, and that true-up archives what the current skills no longer use in a folder under history/ named as the content was (whole-file-ownership).

i33 (call, s-rules, open) — The retired rule made placed documents records out of agent context. The cheatsheet's Documentation section and the template's docspec section now say, from the docspec concept's Boundaries, that an agent working with the source reads the design corpus, the code, and the rules rather than the documentation; documentation is no longer a record, since sprints write it.

i34 (call, s-rules, open) — WI 9's rules-layer text: the cheatsheet's Lifecycle adds one sentence that the close presents the completion report's calls table, one row per judgment an agent made without the owner, for the owner's veto; the estate template's Executing a sprint carries the full rule (vetoed rows filed as issues).

i35 (call, s-issues, open) — The notes-review call's additive record field is named issued: an optional field in both shapes (live and archive), a whole number above 0, the highest message number the record ever issued. retract writes it when it removes an untouched message; next_number numbers a new message above both the messages' numbers and issued. A record with no removal never carries it. The issue format text ({{ISSUE-FILE-FORMAT}}, stage s-definitions) should name the field.

i36 (call, s-issues, open) — issues::load(root, converting=False) gains the keyword converting; true-up's in-process reads (unfiled, and any other load over an unconverted intake) pass converting=True. read_store, transaction, and import_records take the same keyword; cmd_import passes converting=True, and every other verb refuses an earlier layout with a Refusal of reason layout.

i37 (call, s-issues, open) — unlisted behavior change: scripts/issues::read_ledger; before: a ledger file was valid with any top-level fields so long as records held valid entries; after: it also needs a one-line name (view now reads the reader's name from it) and, where marks is present, the value every-message, else it refuses as invalid with the delete-to-start-fresh step; users: every ledger fresh_ledger ever wrote carries the name, so no written ledger refuses.

i38 (call, s-issues, open) — stray_notes counts only lines that are not issue records and not event rows with an id; those rows now raise the layout refusal instead. An id-less event line stays a stray line. Under --over-event-log / --over-archived-event-log the converter still drops every event row, id-less ones too, as before.

i39 (noticed, s-issues, noticed) — The run's brief says new annotations may go in the family's scripts, but checks/materialized-standalone refuses any @decision:/@story: comment in a payload script (scripts/issues among them), since the consumer's lint has no such citation declared. This stage adds none to scripts/issues; later stages that touch payload scripts meet the same check.

i40 (call, s-sprint-text, open) — The build prompt transcludes {{DOCUMENTATION-RULE}} under a new '### Documentation' section placed before '### The coding rules', since a transclusion must stand alone on its line and the rule is not one bullet of 'The stage'.

i41 (call, s-sprint-text, open) — Where a docspec's ## Lists names a class the surface intent names no declaring file for, the builder finds its members by the intent's rule for that class and records that as a call; the sprint is silent on this case.

i42 (call, s-sprint-text, open) — Reconcile step 4 walks a direct out-of-band edit under .ok-planner/docspec/ or to .ok-planner/surface/surface.md like a direct edit under .ok-planner/design/, with corpus catches up / code catches up / record and defer, matching the out-of-band reviewer's always-BEARING rule for those paths.

i43 (call, s-sprint-text, open) — Per WI 3's call (the session adds any missing documentation work item as a call at step 10), the session adds 'Update the documentation per docspec:<slug>' and writes its notes naming the docspec, its Where, and the references the sprint changes, rather than re-running code planning.

i44 (call, s-sprint-text, open) — Draft matches every docspec index row by corpus artifacts a work item or delta names and code paths the owner names; the work item is titled 'Update the documentation per docspec:<slug>'; rows showing 'where: not declared' or 'references: none' are named to the owner as needing a reshape.

i45 (call, s-sprint-text, open) — Step 13 re-renders with --file and --certification, writes the return block, presents the ## Calls table and asks which rows the owner vetoes, files one issue per vetoed row (kind human, category product-intent), then offers the archive and commit; it walks nothing else.

i46 (call, s-sprint-text, open) — Every divergences item add carries --field site= and --field choice=, the noticed item included; it keeps --field file= because review noticed reads it.

i47 (call, s-sprint-text, open) — The list is the sorted set of released template lines the carried template no longer holds, computed with the check's own section_lines and released_lines; 19 lines from steps 4, 8, 10, 13 and contract item 1 joined it.

i48 (call, s-conduct, open) — The injected context opens with the heading '### The Writing Standard for Everything You Write and Say ###', in the '### ... ###' form user-prompt-submit.md already uses, then the style's section 1 '- ' lines, a blank line, and user-prompt-submit.md whole. The section's 'Rewrite before you send' paragraph is not a '- ' line and stays out, per the notes' extraction rule.

i49 (call, s-conduct, open) — With the ok-plumbline hand-off sentence deleted, 'It is repeated here' lost its antecedent, so the reason line now reads 'A rule binds only where it is loaded, and this style loads the standard for every session it governs.' The 'Rewrite before you send' paragraph and the Conduct version stamp are unchanged.

i50 (call, s-conduct, open) — user-prompt-submit.md is left unchanged: it already carries no copy of the writing standard and keeps 'When Responding to the User'.

i51 (call, s-discover, open) — The Phase 2 reviewer's ### This pass slot is written as the per-run value [Cycle <N> of 3 | Back-edge pass], the skill's [...] convention, with the final-pass rule beside it. In place of the removed 'Findings unresolved at the cycle cap' bullet, the reviewer's filing section says to file none of its findings, since step 5d files the ones open at the cap (I102). Refusal text in step 1 and triage's scope copies plan-sprint section 1's wording.

i52 (call, s-run-group, open) — The brief asks for '# @decision: stack-helpers-serve-project-commands' at start where none stands. checks/materialized-standalone fails on any citation in a payload script (the lint over a bare consumer copy reports it as a stray comment), and no payload script carries one. The citation is left out; the decision stands cited at admin/true-up:255 (the stack entry) and admin/true-up:3730.

i53 (call, s-run-group, open) — The interrupt's exit is mapped in the process owner frame: an except KeyboardInterrupt beside the Refusal and Exception arms emits GROUP.RUN.INTERRUPTED (signal, registry) and exits 128+SIGINT=130, for every verb. subprocess.run has already killed the direct child; the rest of the run's group lives until stop, as USAGE and the reference say.

i54 (call, s-run-group, open) — start's preexec is a new join_group_without_terminal(pgid), which sets SIGTTIN and SIGTTOU to SIG_IGN and then calls join_group(pgid)'s function; join_group is unchanged, so scripts/stack's start command keeps its behavior.

i55 (call, s-run-group, open) — The line 'ok-planner's process calls no helper' is false beside the amended decision and the code (admin/true-up calls ports suggest-range and check-range). The opening now says the helpers are for scripts to call, not for an owner to run by hand; then 'The helpers serve a project's stack scripts and the suite's own process. True-up calls ports to suggest and check a port range. The drive starts, reaches, and stops a stack only through the commands ... names'. Lines 9 and 23 drop 'and the audit'.

i56 (call, s-run-group, open) — unlisted behavior change: plugins/ok/families/ok-planner/scripts/run-group::__main__; before: Ctrl-C on any verb ended run-group with an uncaught KeyboardInterrupt traceback on stderr and death by SIGINT; after: one GROUP.RUN.INTERRUPTED event line on stderr and exit 130; users: a project's stack script that calls run-group, and scripts/stack only through its own process (it loads the module and never reaches __main__).

i57 (call, s-definitions, open) — The brief says the rule applies to corpus artifacts alone and states its reach over subjects and practices. A subject's How to find them must name declarations, folders, and searches to meet practice-definitions' enumeration bar, so that section alone is exempt; practices stay bound (code cites them, so a moved file must not invalidate one). Frontmatter and allowed slug forms gain subject: and practice:.

i58 (call, s-definitions, open) — The rule forbade any ## Notes section, which the docspec template (WI 3) makes optional. The rule now names its reach (concepts, stories, decisions, subjects, practices, docspecs, surface intent) and allows a docspec's Notes as standing instructions to the writer, still bound by no-history and no-roadmap.

i59 (call, s-definitions, open) — WI 3's call names prose sections for the user-facing parts and the class rules with named exceptions, then the declaring section; the section names are mine. No frontmatter, since the project holds one surface intent and review::declared_classes reads only the declaring heading.

i60 (call, s-definitions, open) — catalog-toc's docspec_where shows the first non-blank line of ## Where, so the template puts the path alone there; Lists uses bullets for one-class-per-line; code paths and globs are relative to the project root, as review's declaring-file globs are.

i61 (call, s-definitions, open) — WI 12 and WI 3 changed scripts/issues (OPTIONAL gains issued; ARTIFACT_KINDS gains docspec); the format is the schema's description, so rule 1 makes the field table, the discussion numbering sentence, the artifacts sentence, and the Links rule follow it.

i62 (call, s-definitions, open) — WI 14's calls class the other subject and practice findings; a policy sentence is not among them. Stripping it is mechanical only where a practice already carries it, so no owner text is lost.

i63 (call, s-definitions, open) — practice-definitions states the collision rule, and WI 14 says the reviewer enforces each rule the file states.

i64 (call, s-definitions, open) — A dangling path would cut no flow area and match no work; the check sits under each form as claim grounding, mechanical where the tree holds an obvious successor. A surface intent with no declaring section is a judgment finding, so an audit-written intent a sprint amends gets its declaring files named (B22's migration).

i65 (call, s-definitions, open) — unlisted behavior change: plugins/ok/families/ok-planner/skills/_shared/design-doc-compliance-reviewer.md::Cross-reference integrity; before: a reference to a live artifact that a delta of the same sprint retires passes; after: it is a violation, as is any reference that resolves to neither a live file nor one a delta in scope adds (I101); users: /plan-sprint step 7 sign-off

i66 (call, s-converge-text, open) — WI 16's build note says a decline no verifier checked is filed once and is not also a calls-table row. tasks calls selects defects at declined or duplicate, so the owner list settles such a defect with --state open --note <issue id>: its issue is its one record, and the return's fixed counts leave it out.

i67 (call, s-converge-text, open) — The merge rule sits at the top of Loop 1 and every merge step says it drains under it. The session's count item mirrors the zero count review merges writes (new, matched, rejected all 0) and adds unmerged; it looks for an existing count in the merges pool first and adds one only where none stands.

i68 (call, s-converge-text, open) — WI 16 says each count is taken over every report of the area and hunt whatever attempt settled it. Several drive or sprint merges share the area drive and hunt 1, so the count runs over the ids the brief names rather than the whole area, and an earlier attempt's item is the one whose task is the task this one's previous chain names. A merge that closes partial records no count.

i69 (call, s-converge-text, open) — WI 16 files each open report and failure as an unconfirmed defect issue after the review owner check. A backlog report already has its defect issue, still open, so filing again would double it. A record file gets no filing, as for a noticed call; reports and failures have no promoted state, so it is set rejected with the left-alone note.

i70 (call, s-converge-text, open) — WI 4 cuts one documentation pass per docspec a work item names and is silent on its files. The pass needs the docspec, the documentation as it stands and as the change left it, and, for a Lists section, the surface intent and each declaring file of a listed class. Its brief names the slug, the Where, the work items that name it, and the references the change reached.

i71 (call, s-converge-text, open) — WI 9 names the rejected and not-owed settlements; the merge prompt states it once beside the settle line and in each settle command, so the calls table never falls back to a note's first line.

i72 (call, s-converge-text, open) — Rule 1: the Code-and-skill-text paragraph and the sprint-mode bullet restate the prose scope rule and the review's reach, so they follow PROSE-SCOPE-RULE's new docspec clause and the documentation pass. merge.md also adds C5 to its sprint classes.

i73 (noticed, s-converge-text, noticed) — owner-list.md 'Close the issues the run resolved' closes an issue only for a defect at verified or a report rejected gone or left alone. A backlog defect a fixer declined and a verifier accepted (now declined with verified) closes nothing and is filed nowhere, so its issue stays open and the next run takes it up and declines it again; A9, the intake keeps reporting a defect the run judged not real. Stood the same before this stage (declines were never verified).

i74 (call, s-trueup-plan, open) — The call's definition names deletions, archive moves, and rewrites. A port that moves a file to its current live path (the .ok-review/ estate into .ok-planner/review/, the plumbline config and corpus into .ok-planner/, specs/ and backlogs/ into sprints/) deletes nothing and rewrites nothing, so it prints as DRIFT; a move whose destination is under .ok-planner/history/ (plans/, coverage/, review notes) prints as DESTRUCTIVE.

i75 (call, s-trueup-plan, open) — .DS_Store files and anything under a __pycache__ folder hold no work of the project's, so removal() drops them with the machine-local carve-outs (.ok-planner/.cache/, .ok-planner/dashboard/) in a DRIFT step; otherwise an emptied retired folder holding only a .DS_Store would make a plan destructive.

i76 (call, s-trueup-plan, open) — unlisted behavior change: admin/true-up::estate_collided; before: an expected file under .ok-planner/ (bin/, hooks/, docs/, CLAUDE.md, LICENSE) that differed from the carried copy was overwritten whatever it held; after: where it carries no suite mark (stamp, suite LICENSE head, package.json fixed content, review/catalog/, dashboard build), the plan archives it under .ok-planner/history/ and then writes the suite's copy, a destructive step, per the call's definition of destructive; users: owners whose estate holds an unstamped copy, and /ok, which shows the step.

i77 (call, s-trueup-plan, open) — Each file the plan rewrites gets all its transforms (compose-name removal, port-form conversion, the checks key, templates, ignore, review settings, standards, excludes, stack lines, reword, script repoints, boilerplate, retired sections) folded at plan time into one after-text, printed as one 'rewrites <path>: <detail>' line per transform and written once with write_owner; apply refuses where the file no longer reads as planned. 'true-up show <path>' prints the unified diff of that rewrite, and is the Show: command of a rewrite step; an archive step's Show: is 'git -C <root> diff HEAD -- <paths>' where a path carries uncommitted changes, else 'cat -- <paths>'.

i78 (call, s-trueup-plan, open) — unlisted behavior change: admin/true-up (diagnose output); before: wiring findings printed as 'DRIFT: wiring: ...'; after: they print as 'wiring: ...' lines, because wiring is no plan step and the plan id covers steps alone; the exit code stays 1 while wiring is pending. The PLAN line prints last, after the INPUT NEEDED and WIRING NEEDED blocks, and prints with 0 steps too. INPUT NEEDED blocks end 'On the owner's answer run: <command>' and carry no Recommended: line. users: /ok (s-admin-text rewrites its text).

i79 (call, s-trueup-plan, open) — unlisted behavior change: admin/true-up (bare and --go-ahead output); before: 'Retired binary removed:', 'Retired surface apparatus swept:', 'Retired payloads removed:', 'Review estate seeded:', 'repointed:', 'stripped:', 'Live sprint boilerplate brought current:', and a closing 'Trued up ... (created: ...; CLAUDE.md written from template, v...)'; after: 'removed:', 'archived: <src> -> <dst>', 'moved:', 'created: .ok-planner/<sub>/', 'seeded: <path> from the carried skeleton', 'rewrote: <path>: <detail>', 'filed:', and a closing 'Trued up ok-planner at <root> (v<version>).'; 'materialized: N files' counts the files written this run; the 'placed:' line is byte for byte unchanged. users: /ok's report; the dashboard drive steps parse only the placed: line.

i80 (call, s-trueup-plan, open) — The notes name the go-ahead; a bare true-up writes the new lint too, so the refusal (no .ok-planner/config.json while a blocked .ok-plumbline/ estate holds the lint config) is a precheck of every apply, and diagnose prints it as a blocked: line.

i81 (call, s-trueup-plan, open) — The go-ahead reads the markdown-intake draft from <drafts>/markdown-intake.jsonl and the tension draft from <drafts>/tensions.jsonl; the step's Draft: line names the file and what it holds. A missing, unreadable, closed-record, or defective draft refuses the go-ahead before any write.

i82 (call, s-trueup-plan, open) — A review facts line naming a retired estate path with no current counterpart (after the mechanical rewrite of .ok-review, .ok-review/bin/review, and moved .ok-plumbline/ paths) becomes INPUT NEEDED reword:.ok-planner/review/project.md, answered with resolve --from <draft>; review-wording, review-standards, review-exclude, and config-key are plan rewrite steps, and resolve refuses each of their old ids with 'ok-planner offers nothing as <id>'.

i83 (call, s-trueup-plan, open) — A clean, unlocked worktree under the retired worktree directory and a merged branch checked out nowhere else become plan steps (git worktree remove, git branch -d) even while another entry is held; a held entry prints as a blocked: line and holds back only the .ok-workspaces/ estate. With none held, the estate's files go in the same plan as the worktrees. Leftover files in the worktree directory archive either way.

i84 (call, s-trueup-plan, open) — unlisted behavior change: admin/true-up::workspaces_plan and planner_scripts_plan; before: an untracked retired script (ok-workspaces run-tag/src-tag/port-block, .ok-planner/bin/port-block) waited as an estate-edits offer and kept the workspaces profile; after: the removal rule removes it where it carries its suite stamp and archives it where it does not, and only a held script keeps the profile; users: owners with untracked retired scripts.

i85 (call, s-trueup-plan, open) — unlisted behavior change: admin/true-up::plumbline_plan; before: with .ok-planner/config.json absent and both .ok-plumbline/config.json and .plumbline.json present, the first moved and the second stayed with no offer; after: the second is archived as a config conflict; users: owners holding both old configs.

i86 (call, s-trueup-plan, open) — unlisted behavior change: admin/true-up::toc_steps; before: diagnose ran catalog-toc --check with its errors discarded; after: an exit other than 0 or 2 prints 'left: the catalog TOCs cannot be checked: <message>'; a stale TOC whose first line carries no '(auto-generated)' heading is archived before bash regenerates it, a destructive step; users: /ok.

i87 (call, s-trueup-plan, open) — event_log_rows uses the intake module's is_earlier_row, so the legacy conversions fold only the rows the module refuses as an earlier layout; an id-less event line stays a stray line the module reads past (intake-reads-past-stray-lines).

i88 (call, s-trueup-plan, open) — parsed_config runs 'plumbline config-check --config /dev/stdin' with the text as input (named CONFIG_FROM_STDIN, pinned in checks/owned-paths), so the plan checks the config as its compose-name removal and port-form conversion leave it without writing a temp file; config_defects(path) reads the file and goes through the same call.

i89 (call, s-trueup-plan, open) — unlisted behavior change: admin/true-up rewrites of live sprints and configs; before: read with universal newlines and written back, turning CRLF into LF; after: read and written byte for byte (newline=''), so a CRLF sprint's boilerplate lines do not match the template and stay; users: projects with CRLF sprint files.

i90 (call, s-trueup-plan, open) — Per the brief the audit-corpus-reset heredoc and its owned-paths region stay for s-trueup-backout, which removes them. Until then it runs after the plan applies, outside the plan, and deletes retired-shape audit files with no consent; the 'No surface intent document' advisory stays in bash for the same stage.

i91 (call, s-trueup-backout, open) — The archive of .ok-planner/audits/, experiments/, and documentation/ is one destructive step per folder: it archives every file through archive_pairs and archive(), merging into what already stands under .ok-planner/history/<folder>/ entry by entry with a -2 suffix on a taken name, then prunes the emptied tree. Its line names the folder, the archive folder, the file count, and only the pairs whose name took a suffix, where archive_step lists every pair, so an audit corpus of hundreds of files does not print one line of hundreds of pairs. Its Show: is ls -lR of the folder, or archive_show's git diff where a file carries uncommitted changes. A folder holding no file, or only files another step takes (audits/inspection.md, which RETIRED_ESTATE owns), is an empty-folder DRIFT step; OS and interpreter caches in it are dropped.

i92 (call, s-trueup-backout, open) — hunt.extraction, hunt.flow_kinds, and hunt.flow_area_size drop through their own transform (retired_hunt_keys, without_hunt_keys via pruned_text) in review_config_transforms rather than inside stale_review_settings, so the detail reads 'hunt names hunt.extraction, hunt.flow_kinds, hunt.flow_area_size; removed' and the apply line is 'rewrote: .ok-planner/review/config.json: hunt names ...; removed', as the brief prints it; folded into stale_review_settings the detail would end '; true-up rewrites them'. pruned_text keeps the file's other bytes where it can and falls back to the file's own indent otherwise, as every config rewrite does. The drop runs whether or not the config otherwise has defects.

i93 (call, s-trueup-backout, open) — provenance_stamped lists files with git grep -l -I -F --untracked (tracked and untracked-not-ignored), keeps those whose first non-blank text opens '<!-- Revised by /document at', and classifies each with caller_kind, so records, suite files, the archived folders, the retired estates, and the family's own payload are skipped. A 'rewrite' file gets one rewrite step (destructive, Show: true-up show <path>, no archive copy) whose transform deletes through the first '-->', the rest of that line, and one following blank line; an unterminated comment is left as it stands. A file caller_kind marks encoding, link, rules, or memory prints 'left: <path> opens with the provenance stamp the retired /document wrote, and true-up deletes none of it: it is <CALLER_LEFT reason>'. The review facts and both configs are skipped, since their own rewrites own them.

i94 (call, s-trueup-backout, open) — docspec_steps moves each entry of .ok-planner/surface/documents/ (a file or a folder, .md or not) to .ok-planner/docspec/<name> through move_step and move_path (git mv where tracked), a non-destructive move to a live path per i74; a taken target archives the entry under .ok-planner/history/surface/documents/ through conflict_archives; OS caches are dropped; the emptied documents/ folder is pruned, and an empty one is an empty-folder DRIFT step. .ok-planner/surface/ and surface.md stay.

i95 (call, s-trueup-backout, open) — file_caller_issues becomes file_issues and prints 'filed: <id> — <summary>'; each caller issue's summary is '<file> names <names>', so its filed: line is byte for byte as before. facts_issues builds review-facts-undecodable (kind audit, category tooling, artifacts [], title '.ok-planner/review/project.md does not decode as UTF-8' with no backticks, as the caller issues' titles carry none) where the facts file, or the .ok-review/ copy the plan moves there, does not decode; filing_steps prints it as one DRIFT step after the caller filings and files it in the same action, after every intake conversion, skipped when the id is open or archived through unfiled(). stack_plan returns None on an undecodable file, so no stack-lines question cites it.

i96 (call, s-trueup-backout, open) — unlisted behavior change: admin/true-up::backout_steps; before: no true-up line named a /document provenance stamp; after: a file opening with the stamp that is a memory file (CLAUDE.md), one of the project's rules files, or behind a symbolic link prints a left: line each diagnose and keeps its stamp, as an undecodable one does (the notes name only the undecodable case); users: /ok's report, owners whose memory or rules file opens with the stamp.

i97 (call, s-facts, open) — The admin/true-up entry also names the show <path> mode s-trueup-plan landed (prints a planned rewrite's diff, writes nothing), beside the modes the brief lists, and says what bare and --go-ahead do with a destructive plan.

i98 (call, s-facts, open) — WI 19: the issues, plumbline, ports, and review drive-command entries now say the script refuses the earlier layout (pre-v9 event rows and markdown intake; retired lint_checks names and ports object form; the {tag} placeholder) and names /ok. Only drive-command described a fallback before; the others gain the refusal so a driver knows it.

i99 (call, s-facts, open) — WI 18: the review tool's entry describes drive-stack and drive-command only, not verifies, so its wording stays unchanged.

i100 (call, s-facts, open) — The run-group entry adds the Ctrl-C behavior run-group's USAGE states (kills only the command, exits 130, the rest of the group lives until stop), beside WI 10's input-from-/dev/null wording.

i101 (call, s-admin-text, open) — The notes say 'true up again where any applied'. Where an input answer unblocks a step that is destructive (a config draft that lets the stack migration rewrite the review facts), a bare true-up refuses. /ok runs diagnose again, runs bare true-up where the new plan holds no destructive step, and otherwise settles that plan as step 4 does, with the same one go-ahead-or-abort question over it.

i102 (call, s-admin-text, open) — The notes give the core's refusals but not /ok's response. On 'the plan changed since diagnose', /ok runs diagnose again, shows the new plan, and asks the same one question. On any other 'nothing written' refusal (precheck causes, refused draft, blocked lint config), /ok relays the causes and the project stays on its stamped version until the next /ok.

i103 (call, s-admin-text, open) — The /ok skill realizes the new story turn-down-a-destructive-true-up at its ask-once step; the build prompt annotates every story site, and the /ok SKILL.md is not payload markdown, so it carries <!-- @story: turn-down-a-destructive-true-up --> and <!-- @decision: true-up-asks-once-before-destructive-steps --> beside the existing two annotations. The lint resolves both.

i104 (call, s-admin-text, open) — 'The audit model changed shape' becomes 'The audit corpus retires'; 'The ceremony verbs are this family's own' and 'The ceremony goal files' become one section 'The retired ceremony layer' (the goal files went with the skills; ceremony/ files removed by name, plan-sprint.md and certify-work.md named too since RETIRED_ESTATE holds them); 'The documentation run runs no validator...' becomes 'The retired shape checkers' covering audit-check, document-check, and surface-reconcile; 'The surface apparatus changed shape' becomes 'The retired surface apparatus', the extraction named as retired and archived with audits/.

i105 (call, s-admin-text, open) — The plan now drops three hunt keys from the owner's review config, deletes the /document provenance stamp line from project documents, and removes the docs/CLAUDE.md /document wrote. The contract's ownership rule lists every exception that edits an owner file and says nothing in the suite touches CLAUDE.md, so leaving them would state a false normative rule. Added one bullet naming the back-out's edits, a closing 'Each runs as a step of the plan, under the one consent', and narrowed the CLAUDE.md clause to one the project wrote.

i106 (call, s-admin-text, open) — The section said the lint falls back to .ok-plumbline/config.json and .plumbline.json and accepts compose names until true-up removes them; s-plumbline changed both (B29, B30, B31). The section now says the lint reads .ok-planner/config.json alone, that config-check, the port registry, and the stack tool refuse the retired forms naming /ok, and that the plan rewrites them; the config and port-range drafting guidance drops the object-form carry-over.

i107 (call, s-admin-text, open) — The notes relabel scripts/surface-corpus in the family CLAUDE.md as the corpus surfacer /plan-sprint's issue walk and /triage-issues run. The contract and ADMINISTRATION called it the surface helper; the same term now names it in all three.

i108 (call, s-admin-text, open) — The notes ask for archived: and filed: lines and the declined outcome. The core now prints rewrote: in place of repointed: and stripped:, so the template carries a rewrote: form too, relays blocked: and left: lines verbatim, and drops the repointed: form, which the core no longer prints.


# Sprint certification

Run: `/converge sprint .ok-planner/sprints/2026-10-16-docspec-and-audit-backout.md`, ledger `.ok-planner/review/runs/converge-2026-10-17T021110.jsonl` (run folder beside it). The find loop ran once.

- **mode**: `sprint`, `.ok-planner/sprints/2026-10-16-docspec-and-audit-backout.md`, base `89b51cf0e6d7a570fe9368a0728bf8cee9178354`. 60 changed files; 25 stories driven; no paths outside the project root; the build run file exists.
- **hunt**:
  - Reports: 11 in (4 from the build's noticed items, 7 from the review passes; the checks filed none). 4 merged, 6 rejected, 1 set to `backlog` (outside scope).
  - Drive failures: 32. 15 `defect`, 6 `not-owed`, 0 `environment`, 10 `backlog` (outside scope), 1 `judgment`, 0 `upstream`, 0 `rejected`.
- **sprint**:
  - Work items, each traced end to end from its entry point by the five completion passes; each works, save where a defect below names it (fixed and verified, or stuck):
    - WI1 (payload tree, `true-up::SKILLS`, `plumbline::RETIRED_SUBCOMMANDS`) works.
    - WI2 (materialized rules text, `README.md`, `accept.md` A3) works.
    - WI3 + I2 (plan-sprint documentation match, `catalog-toc::main`/`write_replacing`) works after fixes i70, i76.
    - WI4 (`{{SPRINT-BUILD-PROMPT}}`/`{{DOCUMENTATION-RULE}}`, `sprint-review.md`, `review::OWNER_PATHS`) works after fixes i71, i72, i75; i73 stuck.
    - WI5 (`/ok` step 4 → `true-up diagnose`/`--go-ahead` → `build_plan`/`apply_plan`) works after fix i61.
    - WI6 (`true-up::filing_steps` → `facts_issues`) works.
    - WI7 (`review::cmd_areas` → `flow_areas`) works.
    - WI8 + I1 (`checks/run`, oscillation git guard) works.
    - WI9 (`tasks::cmd_render --certification`, `cmd_calls`, converge setup step 5) works after fix i81.
    - WI10 (`run-group start` → `join_group_without_terminal`) works.
    - WI11 (`.mcp.json`) works.
    - WI12 (`issues::mark_read`/`unread_message`, dashboard, `IssueDetail.svelte`) works.
    - WI13 (lint over `checks/oscillation`) works.
    - WI14 + I101 (plan-sprint §7 → compliance reviewer) works.
    - WI15 (ok-conduct `user-prompt-submit`) works.
    - WI16 (converge merge rule, sprint step 1, Loop 2 step 4 → `tasks::COPIED_ON_REFILE`) works after fix i58.
    - WI17 + I102 (discover-design steps 5b/5c/6c, Phase 2 `### This pass`) works after fix i59 (i60 duplicate).
    - WI18 (converge Loop 2 step 5 → `review::cmd_verifies`, `verify.md`) works after fix i58.
    - WI19 (`issues::read_store`, `plumbline::configPathFor`, `ports::declared_names`, `review::project_folders`, `true-up::unfiled`) works.
  - Behavior changes judged: 54 (36 `rewrite`, 14 `migrate`, 4 `preserve`), across five regression passes; 1 became a defect (i61, R2). 11 `unlisted` calls recorded (below).
  - Deltas: the alignment pass checked all 77 headings (52 new or amended bodies byte-identical to the sidecar, 25 retirements gone with their TOC rows; `catalog-toc --check` exit 0). No C3 defect.
  - Docspecs named by work items: 0, so no documentation pass ran.
  - Stories driven (outcome per surface and variant, from the drivers' close results):
    - achieved: concurrent-stacks-without-port-collisions, discuss-an-issue, edit-time-lint-enforcement, fresh-artifacts-per-run, project-spans-folders, record-coding-practices, rule-on-the-whole-intake, see-new-analysis, session-awareness, turn-down-a-destructive-true-up, verification-leaves-no-artifacts-behind, write-time-prose-steering.
    - failed on at least one surface or variant: bootstrap-design-corpus (judgment-questions), certify-completion (converge whole; plan-sprint whole), declare-project-documentation (kind, reader), find-and-fix-defects, keep-documentation-current (converge whole), plan-a-sprint (goals, open-questions), reference-names-the-public-surface (every-public, no-internal), rule-the-public-surface, see-governing-versions, sketch-an-idea, true-up-project-estate (whole-presence), veto-calls-made-in-my-absence, watch-execution-progress. Each in-scope failure merged into a defect below; each outside-scope one went to the intake.
    - Confirm drives, one per drive-sourced verified defect (11 of 11 now driven):
      - Round 2 (t62 to t64): declare-project-documentation for i70 achieved; keep-documentation-current for i72 achieved; keep-documentation-current for i73 failed (sent back; stuck).
      - Round 1's confirms, skipped by the session and run late at the owner's word (round-5, t68 to t75, filed through `review::cmd_drives` against round 1's verifiers): i71, i75, i77, i78, i79, i80, i81 achieved; i76 failed (the docspec index shows no `## Lists`, so a reader matching against it cannot find a reference docspec) and went back to `open`.
      - Fix round 3 (t76, verify t77, confirm t78): i76 fixed so each `## Lists` reader opens every docspec under `.ok-planner/docspec/`; verified; confirm achieved.
      - Noted by confirm drivers, not filed (a confirm driver records no new failure): `/plan-sprint`'s description (SKILL.md line 3) still says the owner is asked "only" in three cases and omits the unclaimed-surface case; the Approval re-run of code planning (SKILL.md:198, 200) does not say its questions go through the owner's judgments again. The out-of-band reviewer's miss of declaring-file changes is already `out-of-band-review-misses-declaring-files`.
  - Checks: `node .ok-planner/bin/plumbline` over the changed files passed at the find loop, after fix round 2, and after fix round 3 (exit 0 each). `bash checks/run` passes all six checks.
  - Reports sent to the intake as outside the sprint's scope: 11 (10 drive failures and 1 build-noticed report), filed as the issues listed under intake.
- **cleanup**: `stack cleanup` after the drive printed nothing to take down (exit 0); the project declares no stack (`review drive-stack` prints `none`), so no `stack up` or `stack down` ran; no instance or resource commands are declared. No confirm drive started a stack.
- **fixed**:
  - `verified` 13: C1 2 (i58, i59), R2 1 (i61), A3 3 (i70, i71, i72), C4 3 (i75, i79, i81), A8 4 (i76, i77, i78, i80).
  - `declined` 0.
  - `duplicate` 2: i60 (of i59, C1), i74 (of i75, A3).
  - `stuck` 1: i73 (A3), listed for the owner below.
  - Fix rounds: 3. Send-backs: i70 1 (outside files), i72 1 (outside files), i76 1 (late confirm driver t70), i73 2 (round-1 verifier, then the round-2 confirm driver).
- **stuck, for the owner**: **i73** (A3, `plugins/ok/families/ok-planner/skills/converge/prompts/fix.md:Fix`). A certification fix that changes behavior leaves the documentation under a docspec describing the old behavior. Last send-back (confirm driver t64): "fix/verify step 4 and the prose scope rule match docspecs by code-path references only, missing the ## Lists declaring-file reach, and edit only sentences made false, missing omissions." Its backout (t65) closed `done`: i73's hunks left the tree, and the other defects' fixes in the same files stand. Filed as judgment issue `certification-fix-leaves-documentation`.
- **ledger**: `.ok-planner/review/runs/converge-2026-10-17T021110.jsonl`.
- **intake**: the owner list (t67) wrote 24 issues: 13 `defect`, 7 `product-intent`, 2 `tooling`, 1 `design` for a left-alone file, and 1 `design` for the stuck defect. It closed none.
  - Stuck: `certification-fix-leaves-documentation` (design), from i73; backout `done`.
  - `judgment`: drive failure i19 → `converge-commits-leave-documentation-behind` (design).
  - `upstream`: none. `environment`: none.
  - Rejected as a record: report i3, `.ok-planner/sprints/2026-10-16-docspec-and-audit-backout-build.md` (filed nothing).
  - Outside scope (`backlog`) → defect issues: `owner-list-verified-decline-leaves-issue-open`, `discover-design-phase-one-findings-filed-as-questions`, `discover-design-read-more-code-filed-as-questions`, `certification-closes-done-with-no-story-driven`, `converge-file-wait-charged-as-kickback`, `review-backlog-misses-extensionless-files`, `converge-silent-on-dropped-folders`, `ok-version-reports-no-plugin-version`, `sketch-overwrites-same-day-sketch`, `accepted-upstream-recommendation-asked-again`, `certification-checklist-entry-never-marked`.
  - Questions and notes → issues: `certification-return-names-no-deltas`, `draft-sprint-indistinguishable-from-approved`, `listed-class-change-reach`, `lists-section-internal-class-exceptions`, `out-of-band-review-misses-declaring-files`, `plain-converge-return-offers-no-veto`, `plan-sprint-late-work-skips-relevance`, `true-up-rewrites-uncommitted-suite-edit`, `payload-script-story-citation` (tooling), `issue-writers-table-misses-veto-transcription`, `converge-skipped-confirm-drivers` (tooling; session note i93: the session skipped Loop 2 step 6 after fix round 1. The eight missed confirms have since run, above, so the issue's part A is done; its part B, the review tool choosing which defects get confirm drivers, stands. The same skip happened once before, in `converge-2026-10-04T060800`, which verified drive-sourced i71 and filed no confirm driver).
  - `unlisted` calls, as a record (11): i32 `issues::read_ledger`; i33 `run-group::__main__`; i34 compliance reviewer cross-reference integrity; i35 `true-up::estate_collided`; i36 `true-up` diagnose output; i37 `true-up::apply_plan` output; i38 `true-up::workspaces_plan`; i39 `true-up::plumbline_plan`; i40 `true-up::toc_steps`; i41 `true-up::rewrite_plan`; i42 `true-up::backout_steps`.
  - `/triage-issues` (ledger `.ok-planner/tasks/triage-issues-2026-10-17T030236.jsonl`):
    - Scope: 24 unrouted, 0 upstream re-checks, 1 record with a person's unseen message (`readme-docspec-and-surface-intent-unwritten`, answered), 21 pending links.
    - Routes: 11 `defect` (with generated rulings), 11 `question` (with recommended rulings), 1 `retired` (`issue-writers-table-misses-veto-transcription`: no accept-list entry covers it), 1 `answered` (`plan-sprint-late-work-skips-relevance`: the code already re-checks late work). 0 unrouted and 0 unseen left.
    - `links --broken` still lists three links, all on issues this sprint promoted (`surface-extraction-completeness-unrecorded`, `unread-counts-only-agent-messages`), out of triage's scope.
- **cost**: 8,333,952 tokens over 79 tasks in the certification ledger (`tasks status` total).
