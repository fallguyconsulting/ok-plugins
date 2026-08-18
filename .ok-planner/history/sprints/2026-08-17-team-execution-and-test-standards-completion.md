# Completion report: Team execution and test standards

Sprint: `2026-08-17-team-execution-and-test-standards.md`

## Stages

1. done — Reconcile deltas: apply the amended concepts `document-type` and `experiment` and the amended decisions `audit-audience-split`, `document-composes-audit`, `owner-guided-surface-partition`, `steering-over-prose-lint` from the sidecar.
2. done — Testing standard: author the canonical document, materialize it from the plumbline converge core, rewrite the cheatsheet's Testing section; apply `test-quality-by-review` and `review-tests-against-the-standard`.
3. done — Events standard: author the canonical document, materialize it, add the cheatsheet section; apply `event-kinds-as-conventioned-strings`.
4. done — `/events` skill: new read-only ok-plumbline skill, vendored by the family's converge; apply `inventory-event-kinds`.
5. done — Certification core: standing reviewer brief, "Standing producers" headings in the family contributions, integration-contract entry, the gate reads the report, Tests and Events review foci; apply `team-execution-cold-gate`.
6. done — Dispatch discipline for builders; apply `subagent-model-follows-job`.
7. done — Sprint execution boilerplate; apply `task-tools-mirror-the-report`, `watch-execution-progress`, and the amended concepts `sprint` and `completion-report`.
8. done — `/ok` offers the task tools: converge core consent block and ADMINISTRATION.md.
9. done — Restate the execution shape in the `.ok-planner/CLAUDE.md` template, the ok-planner cheatsheet, the ok cheatsheet, `plugins/ok/CLAUDE.md`, and the ok-planner family CLAUDE.md.
10. done — Regenerate the design catalog TOCs; run the project's checks and family test suites.
11. done — Finish this completion report.
12. done — Run `/certify-work` with this sprint's path as its argument.
13. done — Walk the presentation with the owner; offer archive-and-commit.

## Work done

- Stage 1: copied the six amended bodies from the sidecar into `.ok-planner/design/` verbatim.
- Stage 2: authored `plugins/ok/families/ok-plumbline/docs/testing.md`; the plumbline converge core materializes it to `.ok-plumbline/docs/testing.md` (with a proof in the family's `test/run.sh`); rewrote the cheatsheet's Testing section as the ambient copy and dropped the co-location line from File Organization; the family README and ADMINISTRATION.md name the new standards; applied `test-quality-by-review` and `review-tests-against-the-standard`.
- Stage 3: authored `docs/events.md`, materialized beside the testing standard; added the cheatsheet's Events section and a `/events` Tooling line; applied `event-kinds-as-conventioned-strings`.
- Stage 4: added the `events` subcommand to the plumbline binary (config key `tests` for the test-path convention, defaults for common test paths, format check, orphans, pruning list; exit 2 on format violations, 0 otherwise); wrote `skills/events/SKILL.md` in the shape of `/patterns`; registered it in `VENDORED_SKILLS`; proofs in `test/run.sh` under `@story: inventory-event-kinds`; the README, integration contract, and cheatsheet list the verb; applied `inventory-event-kinds`.

- Stage 5: `certification-core.md` gains `{{STANDING-REVIEWER-PROMPT}}` (dispatch-once brief wrapping the code-review prompt with the per-stage scope stanza, the ledger, and the concatenated Standing producers); the review-fix loop's Phase A has the alignment judge read the report's Divergences and tag claimed forks `CLAIMED FORK`, which skip the fixer and go to the architect; the alignment prompt gains item 4 (each recorded call under the veto test, each claimed fork reported); the architect prompt takes claimed forks beside kickbacks and resolves them REFUTE/CONFIRM; the code-review prompt is blind to the report and gains the Tests focus (substance first, then the standing) and the Events focus; the presentation's Divergences merges the executor's recorded calls with the fixer's. Each family's `ceremony/certify-work.md` gains `## Standing producers` (planner: annotation integrity; plumbline: practice citation reading; workspaces: none); `checks/ceremony-surfaces` admits the heading as conventional; `docs/integration-contract.md` documents it; the certify-work ceremony body states the gate is cold. Applied `team-execution-cold-gate`.
- Stage 6: `{{WORKER-POOL-RULE}}` retires only at an item boundary, holds the threshold below the compaction window, names the hand-off records (sprint plus report for a builder, the ledger for a reviewer), and states the session relays and never edits; the model rule names the builder and standing reviewer as opus jobs. Applied `subagent-model-follows-job`.
- Stage 7: rewrote "How to execute this sprint" in `sprint-document.md` around the team (session as relay, builder fed a stage per message, standing reviewer fed each landed stage's paths, retirement at a stage boundary below the compaction window, the no-messaging fallback in bounded batches, the builder recording determined calls and claimed forks and never filing an issue, code complete as "the built work works", `/certify-work` immediately after as the cold regression, "use the task tools, if available" mirroring the report). Applied `task-tools-mirror-the-report`, `watch-execution-progress`, and the amended `sprint` and `completion-report` concepts.
- Stage 8: the front door's converge core gains `env_findings()`, a `WIRING NEEDED` block for `env.CLAUDE_CODE_ENABLE_TODO_TOOLS`, and the consented `wire-env` mode; `checks/owned-paths` sanctions the second consent region; `plugins/ok/admin/ADMINISTRATION.md` names the entry as the second consented settings entry; the `/ok` skill presents each block as its own consent; `plugins/ok/test/administration.sh` proves the block, the no-write default, the transcription, and that the hook entry beside it is untouched; the integration contract and `plugins/ok/CLAUDE.md` name `wire-env`.
- Stage 9: the `.ok-planner/CLAUDE.md` template, the ok-planner cheatsheet template, the ok cheatsheet, and the ok-planner family CLAUDE.md describe execution as the team and certification as the cold gate that follows. The stage left `plugins/ok/CLAUDE.md` unchanged. Certification added the same restatement there.
- Stage 10: regenerated the three catalog TOCs; `bash checks/run` passes all seven checks; the plumbline, planner, front-door, and workspaces suites pass.

## Certification run

`/certify-work` ran the producers over the staged change: the four suites and `checks/run`, the plumbline lint over the changed files, the annotation floor, the sprint-alignment judge, and one code review of the whole diff. Cycle 1: alignment 2, code review 18, lint 50; fixer pass 1 fixed all 70, no kickbacks. Cycle 2: alignment clean, code review 8; fixer pass 2 fixed all 8. Cycle 3: code review 6; fixer pass 3 fixed all 6, one corpus repair (`team-execution-cold-gate`, expression only, mirrored in the sidecar). Cycle 4 re-review: alignment clean, suites, checks, lint, and floor clean, code review 6 findings remaining. Three fixer passes had run without a clean review, so the loop reached its cap.

The owner reset the cap. Fixer pass 4 fixed the six. Cycle 5 review: every other producer reported clean, code review 8 findings. Fixer pass 5 fixed all 8:

1. The session's report writes — every site now reads the same: the session opens the completion report with the staged list before the build and marks the closing stages after the team retires; during the build it edits nothing (`sprint-document.md`, `dispatch-discipline.md`, `team-execution-cold-gate` with its sidecar, the ok and ok-planner cheatsheets, `plugins/ok/CLAUDE.md`, the `.ok-planner/CLAUDE.md` template).
2. The last stage's ledger — after the final stage the session relays the ledger to the builder as a fix-only message and repeats the round until the reviewer reports an empty ledger; an empty ledger is a condition of code complete. Applied to the messaging shape, the no-messaging fallback, and the standing-reviewer brief's per-stage paragraph.
3. The claimed-fork lane — the standing-reviewer brief reports a producer's claimed fork once, under `Claimed forks`, outside the ledger, for the builder to record in the report; the plumbline standing producer names the same lane.
4. `plugins/ok/admin/converge` — `marked_entry()` guards a `PreToolUse` entry that is not an object and a hook inside one that is not an object, in both `settings_findings` and `wire-hooks`. Two guard seeds prove it in `plugins/ok/test/administration.sh`.
5. `plugins/ok/admin/converge` — `env_findings` and `wire-env` compare the env value against the string `"1"`, so a numeric `1` reports as drift and `wire-env` overwrites it. A seed proves the report and the repair.
6. `test-quality-by-review` — the reviewer reports a test that duplicates a proof or proves nothing, and the fix removes or merges it; mirrored in the sidecar.
7. This section — rewritten to the run's current state.
8. `README.md` — dropped the clause nominating the audit's experiments through the intake, which the `experiment` concept delta contradicts.

Cycle 6 review: every other producer reported clean, code review 5 findings. Fixer pass 6 fixed all 5:

1. "Code complete" — the ledger clause now stands at all five restatement sites: `team-execution-cold-gate` with its sidecar, the ok cheatsheet, `plugins/ok/CLAUDE.md`, and the ok-planner cheatsheet and `CLAUDE.md` templates.
2. The fix-only round's exit — the standing reviewer closes a ledger line the builder answers with a recorded fork: once the completion report carries the fork with its options and the reading the builder built, the line moves to `Claimed forks` and closes. The standing-reviewer brief's ledger paragraph and the execution boilerplate's relay carry the rule.
3. The report's record shape — the builder records every claimed fork, its own and the reviewer's, with its options and, where it built one, the reading it built. The architect's REFUTE clause names how it resolves a claimed fork carrying no built reading.
4. `plugins/ok/families/ok-plumbline/test/run.sh` — the converge proof drops two sentence greps over the materialized standards and keeps the presence and stamp checks.
5. Two ragged wraps — the execution boilerplate's step 10 and the ok-planner `CLAUDE.md` template's execution paragraph now wrap to the surrounding width.

The producers re-run over the staged change after this pass. The gate writes the presentation once the review comes back clean.

Cycle 7 re-review: alignment clean, suites, checks, lint, and floor clean, code review 6 findings. Three fixer passes since the owner's reset ran without a clean review, so the cap was reached a second time.

The owner reset the cap again. Fixer pass 7 fixed all 6:

1. The blindness clause is the gate's — the code-review brief no longer forbids reading the completion report, and the gate's code-review prompt forbids it in its wrapper. The gate's cold reviewer stays blind; the standing reviewer reads the report to close a builder-recorded fork. No other site claims the standing reviewer is blind.
2. The sprint-alignment prompt's item 4 — an entry that names an issue file, or that states the resolution the architect made, is settled, and the judge reports nothing for it.
3. The fix-only round is bounded — after 3 rounds without an empty ledger the session stops and puts two steps to the owner: another round, or the builder records each still-open line in the report as a claimed fork, which closes the line and hands it to the gate's architect. The execution boilerplate's relay states it, its no-messaging fallback names the same bound, and the standing-reviewer brief's per-stage paragraph states it. "Code complete" stands unchanged: both steps end with an empty ledger.
4. `plugins/ok/skills/ok/SKILL.md` — the consent-command parenthetical names the front door's own two commands and the family hook command.
5. `plugins/ok/families/ok-plumbline/test/run.sh` — the converge proof greps the stamp in both materialized standards, and its failure message names an unstamped file.
6. The standing-reviewer brief — its dispatch paragraph names the review-scope fill beside the sprint path and the standing producers, and the narrating sentence above the transclusion is gone.

Cycle 8 re-review: every other producer reported clean, code review 3 findings. Fixer pass 8 fixed all 3:

1. `plugins/ok/families/ok-plumbline/bin/plumbline` — a trailing-slash `tests` pattern containing `*` or `?` now matches as a glob: `isTestPath` strips the slash and tests the pattern against every leading directory run of the path. A literal pattern keeps the prefix rule. The event-inventory proof declares `packages/*/test/` over the seeded `packages/api/test/queue.js` and checks the split.
2. `plugins/ok/families/ok-plumbline/test/run.sh` — the prose-review proof drops its `sleep 1`. It asserts that the pre-write hook stamped the start marker, then sets the heredoc file's mtime with `touch -t` to a fixed stamp after the marker. The verdict no longer depends on elapsed time.
3. `plugins/ok/skills/ok/SKILL.md` — step 5's title reads "Wire the consented settings entries — by transcription only, once". The step transcribes the task-tools env entry beside the hook entries.

Cycle 9 re-review: every other producer reported clean, code review 3 findings. Fixer pass 9 fixed all 3:

1. `plugins/ok/families/ok-plumbline/bin/plumbline` — a glob `tests` directory pattern now matches at any depth, like a literal one. `isTestPath` tests the pattern against every contiguous run of directory segments, not the leading runs alone. A new event-inventory proof declares `*/test/` over a seeded `x/packages/api/test/q.js` and checks the split. `docs/events.md` states the matching rule in its inventory section.
2. `plugins/ok/ceremonies/certify-work/SKILL.md` — step 3 states that the gate assembles producers from each contribution's `Producers` phase and takes nothing from its `Standing producers` section.
3. `plugins/ok/families/ok-plumbline/skills/events/SKILL.md` — the format-violation bullet names the convention first, in `docs/events.md`'s words, then states what the scan treats as kind-shaped.

Cycle 10 re-review: suites, checks, lint, and floor clean, code review 4 findings. Three fixer passes since the owner's second reset ran without a clean review, so the cap was reached a third time.

The owner reset the cap a third time. Fixer pass 10 fixed all 4:

1. `plugins/ok/families/ok-plumbline/test/run.sh` — the depth-two glob proof asserts the per-kind `tests:` line for the nested kind and pins `Orphans (1)`. The proof fails when `isTestPath`'s glob branch breaks.
2. `certification-core.md` — the loop's step 3 states item 4's rule: the re-run alignment judge reads the rewritten entry as settled and reports nothing for it, so a resolved fork reaches the architect once.
3. `plugins/ok/ceremonies/certify-work/SKILL.md` — the coldness clause names the producers, so the architect's report rewrite and the presentation's read stand.
4. `certification-core.md` and `dispatch-discipline.md` — the shared brief reads actor-neutral: the fix is a test, and execution belongs to whoever dispatched you.

Cycle 11 re-review: every other producer reported clean, code review 3 findings. Fixer pass 11 fixed all 3:

1. `plugins/ok/families/ok-plumbline/bin/plumbline` — the event inventory now reads every file under the path it scans. `walkFiles` takes an accept predicate, and the lint keeps its own file set as the default. The events scan passes a predicate that drops the prose extensions, and the scan skips a file carrying a NUL byte. The inventory now lists a kind emitted from Elixir, Lua, Dart, or a YAML manifest, so the orphan and pruning lists cover the whole tree. `docs/events.md` and the `/events` skill state the population. A new proof seeds an Elixir emit site and a markdown mention, then checks that the scan finds the emit site and skips the mention.
2. `certification-core.md` — the four headings inside `{{CODE-REVIEW-BRIEF}}` demote to `####`, so the block ends at the `---` and matches every other token block in `skills/_shared/`.
3. `certification-core.md` — the architect prompt's Rules name where the completion report sits: beside the sprint, same filename with `-completion` before the extension. The architect can now find the entry it must rewrite, so a resolved fork reaches it once.

Cycle 12 re-review: code review 3 findings, the lint 3 comment-hygiene violations. Fixer pass 12 fixed all 6:

1. `certification-core.md` — the code-review brief's Events focus stays inside the read-only surface: the reviewer `rg`s the tree for the convention instead of running `/events`.
2. `certification-core.md` — the alignment judge's item 4 describes a claimed fork as the report holds it: a fork with its options and, where the executor built one, the reading it built. The loop's step 3 and the architect prompt's opening carry the same description, so a fork the standing reviewer raised reaches the architect.
3. `plugins/ok/families/ok-plumbline/docs/events.md` and `skills/events/SKILL.md` — the naming rule states what `EVENT_KIND_RE` enforces: each segment starts with an upper-case letter and continues with upper-case letters and digits.
4. `plugins/ok-conduct/hooks/user-prompt-submit:2` — the hook opens at its shebang. `plugins/ok-conduct/CLAUDE.md` records why it runs machine-global, and `REMINDER_EVERY` names the cadence.
5. `plugins/ok-conduct/hooks/user-prompt-submit:23` — the `jq` guard stands on its own; the code says what the comment said.
6. `plugins/ok-conduct/hooks/user-prompt-submit:37` — the name `count_typed_top_level_user_prompts` carries the filter's meaning: the count excludes tool results and sidechain prompts.

Cycle 13 re-review: suites, checks, lint, and floor clean, code review 2 findings. Three fixer passes since the owner's third reset ran without a clean review, so the cap was reached a fourth time. The two findings stand unfixed pending the owner's choice:

1. `steering-over-prose-lint` (design artifact and sidecar) — the Choice reads "a consented PreToolUse hook on Write and Edit"; the shipped wiring, the binary's diagnose text, the README, and the cheatsheet all say every tool. Expression repair: "on every tool call" at both sites.
2. `plumbline events` and `skills/events/SKILL.md` — `isEventKindShaped` reports foreign dotted constants (`android.intent.action.MAIN`, `java.util.UUID`) as format violations and exits 2, and the skill tells the author to rename them. Fix the guidance or narrow the population.

The owner reset the cap a fourth time. Fixer pass 13 runs over the two findings.

Fixer pass 13 fixed both:

1. `steering-over-prose-lint` (design artifact and sidecar) — the Choice reads "a consented PreToolUse hook on every tool call". The two copies stay byte-identical.
2. `plugins/ok/families/ok-plumbline/docs/events.md` and `skills/events/SKILL.md` — the guidance splits the format-violation list by owner. The standard states that the regex matches on shape alone. It names a flagged constant another system owns a scan false positive. The skill tells the reader to rename only the kinds this project emits and to leave the rest alone. The scan's population and its exit code stay as they are.

Cycle 14 re-review: alignment clean, suites, checks, lint, and floor clean, code review 4 findings, none seen in an earlier cycle. Fixer pass 14 runs over them.

Fixer pass 14 fixed all 4:

1. `plugins/ok/families/ok-plumbline/bin/plumbline` — `isEventScanFile` sniffs before the read: it stats the file, drops a file over a megabyte, reads the first 8 KB, and drops a file whose first 8 KB hold a NUL byte. No binary or oversized asset reaches `readFileSync` whole. `docs/events.md` and the `/events` skill state the skipped population, and a new proof seeds a NUL-carrying file and a file over a megabyte and checks that neither kind lists.
2. `certification-core.md` — the whole-sprint delta check sits in `{{CERTIFY-CODE-REVIEW-PROMPT}}`, which reviews the finished work, so every delta a sprint in scope carries is due there. The standing reviewer's dispatch carries its own per-stage rule: only the deltas the stage landed are due, read from the design files among the stage's paths, and a delta no stage has landed yet belongs to the later stage that carries it. The shared brief's Source of truth points at the dispatch above it. The ok-planner certify-work contribution names the gate's check as the whole-sprint one.
3. `plugins/ok/admin/ADMINISTRATION.md` — a new section names the six unusable-settings states, what each leaves unwritten, and the owner's repair. `plugins/ok/skills/ok/SKILL.md` step 3b tells the front door to include what diagnose reports, and names the line that reaches the owner no other way.
4. `plugins/ok/families/ok-plumbline/test/run.sh` — the default-patterns assertion seeds `src/queue_test.js` waiting on a kind, so the basename branch of `isTestPath` decides the split. A new run declares `src/*_test.js` and exercises the branch for a pattern that carries a slash without a trailing one.

Cycle 15 re-review: alignment clean, suites, checks, lint, and floor clean, code review 4 findings, none seen in an earlier cycle. Fixer pass 15 runs over them.

Fixer pass 15 fixed three of the four and refuted the fourth:

1. `plugins/ok/families/ok-plumbline/bin/plumbline` — the events scan reports every file it could not read. The scan filter records the path when the stat or the open throws, and the read loop records it when `readFileSync` throws. The header prints the count, marks the inventory partial above zero, and names each path. `docs/events.md` states the count, and the `/events` skill tells the reader to report it before offering the pruning list. A new proof seeds a file with no read permission and checks the count, the path, and the absent kind. The NUL-and-oversized proof now pins `unreadable: 0 file(s)`, so a deliberately skipped file never counts as unreadable.
2. `plugins/ok/families/ok-plumbline/skills/events/SKILL.md` and `plugins/ok/families/ok-plumbline/docs/events.md` — a declared `tests` array replaces the default test paths. Both say so where the reader declares the entry. The code and its proof stand as they are.
3. `plugins/ok/families/ok-planner/skills/_shared/sprint-document.md` — the relay protocol and its three-round bound stand once, in `certification-core.md`. The execution boilerplate's relay bullet names the protocol instead of restating it. The bullet above it already cites the certification core, so the sprint stays self-sufficient. The no-messaging fallback names the same bound.
4. `plugins/ok/families/ok-plumbline/bin/plumbline` — refuted, no change. `checks/materialized-standalone` copies the binary into a consumer holding no corpus and runs the lint over the copy: the two annotation lines report `comment is not permitted` and the check exits 1. The fixer ran that reproduction and reverted it. The annotations stay where the check allows them, on `admin/converge` and `test/run.sh`.

Cycle 16 re-review: alignment clean, suites, checks, lint, and floor clean, code review 6 findings. Three fixer passes since the owner's fourth reset ran without a clean review, so the cap was reached a fifth time. The six findings stand unfixed pending the owner's choice:

1. `sprint-document.md` step 2 — the task-tool sentence names no actor; a builder can take the task list as its own. `task-tools-mirror-the-report` says the session keeps it.
2. `certification-core.md` — a standing producer's claimed fork is reported once and nothing carries it; the session holds only the ledger, so a fork the builder never records is lost.
3. `sprint-document.md` step 9 — three gate roles read a completion-report `Divergences` section the boilerplate never tells the builder to write, and the presentation writes a second section of the same name.
4. `plumbline` events scan — the over-1MB skip and the past-8KB NUL skip drop files silently while the unreadable skip reports partiality.
5. `plumbline` events scan — sites sort lexicographically, so line 10 prints before line 2.
6. `plumbline` `walkFiles` — an unreadable directory throws out of the generator and the inventory dies instead of reporting it.

The owner reset the cap a fifth time. Fixer pass 16 fixed all 6:

1. `plugins/ok/families/ok-planner/skills/_shared/sprint-document.md` — step 2 names the session as the task list's owner: the session keeps one task per stage and marks each task done as its stage lands. The task list is the session's, so the checklist stands in the owner's session.
2. `plugins/ok/families/ok-planner/skills/_shared/certification-core.md` — the standing reviewer repeats each claimed fork under its `Claimed forks` heading in every reply until the report's `## Divergences` section carries it, and the session holds the open claimed forks beside the ledger for a replacement reviewer. `sprint-document.md` and the ok-plumbline certify-work contribution state the same rule.
3. `plugins/ok/families/ok-planner/skills/_shared/sprint-document.md` — step 9 mandates one `## Divergences` section, one entry per divergence and per claimed fork, each opening with a stable identifier (`D<n>`, `F<n>`). The architect rewrites a resolved entry in place under its identifier. The alignment judge names the identifier on each `CLAIMED FORK` finding, and reports a report with no `## Divergences` section as a finding. The presentation's Divergences replaces the build-time section, so the report ends with one.
4. `plugins/ok/families/ok-plumbline/bin/plumbline` — the events scan reports every file it did not read under three counts: `unreadable`, `binary`, and `oversized`, each naming its paths and marking the inventory partial. A NUL byte past the sniffed prefix counts as binary instead of dropping the file silently. `docs/events.md` and the `/events` skill state the three counts, and two proofs pin them.
5. `plugins/ok/families/ok-plumbline/bin/plumbline` — `compareSites` sorts a kind's emit and test sites by path, then by line number as an integer, so line 2 precedes line 10. The format-violation list sorts the same way. A proof seeds one kind at lines 2 and 10 and pins the order.
6. `plugins/ok/families/ok-plumbline/bin/plumbline` — `walkFiles` takes an `onError` callback. The events scan passes one that records the path under `unreadable`, so a directory the process cannot list leaves a partial inventory instead of a stack trace. The lint passes none and still throws. A proof seeds an unlistable directory and checks the count, the path, and the surviving inventory.

The owner cleared the goal and directed an experiment. The gate's producers and fixer run as standing agents. Each is spawned once, keeps its context, and receives later work by message. The code reviewer reads every changed file and keeps a ledger of what it has read. After each fix batch it verifies the fixes and reads on. The loop ends when a full sweep yields nothing new. Fixer pass 16 was the first batch. Sweep 1: the reviewer read all 66 authored files, verified the six batch-1 fixes, and reported 4 new findings. Fixer pass 17 runs over them.

Fixer pass 17 fixed all 4:

1. `plugins/ok/families/ok-plumbline/docs/events.md` — the standard states all three `tests` pattern forms. An entry ending in `/` names a directory run. An entry carrying a `/` without a trailing one matches the whole repo-relative path. An entry carrying no `/` matches the file name at any depth. The paragraph names the defaults that take the file-name form.
2. `plugins/ok/families/ok-plumbline/docs/events.md` and `skills/events/SKILL.md` — the standard states the scan's shape limit: it reads a dotted literal as kind-shaped only when one segment is an upper-case word, so `queue.job.retried` and `Queue.Job.Retried` pass in silence. The standard tells the reader that an empty inventory says no literal matched the scan's shape test, and says nothing about conformance. The skill says the same where it presents the run. A new proof seeds both near-miss shapes and checks that neither lists. The shape test itself stands: the run already narrowed it so an ordinary filename literal stops reporting, and widening it would report every `foo.min.js` and `index.test.js` as a violation at exit 2.
3. `plugins/ok/families/ok-plumbline/test/run.sh` — the two proofs that drive the `unreadable` branch with `chmod 000` run under a user the mode bits bind. Under root the suite prints one skip line naming why. Root ignores the mode bits, so those proofs failed there for a reason unrelated to the behavior.
4. `plugins/ok/test/administration.sh` — a fourth `unusable_guard_holds` case seeds a `PreToolUse` entry whose `hooks` value is an empty string, the third shape `marked_entry` rejects and `ADMINISTRATION.md` names. The empty string is the fixture that fails when the `isinstance(hooks, list)` guard goes: without the guard the loop iterates nothing, the scan reaches the real entry, and diagnose reports clean.

Fixer pass 18 fixed all 1:

1. This report — the section reads `## Divergences`, the name the execution boilerplate's step 9 mandates and the alignment judge reads. Each entry opens with its identifier, `D1` through `D13`, in the order the entries stood. The six calls certification's fixer made keep their lead-in line and take identifiers of their own, so the architect can rewrite any one in place. No entry's content changed. The run recorded no claimed fork, so no `F<n>` stands.

Fixer pass 19 fixed all 1:

1. `plugins/ok/families/ok-plumbline/skills/events/SKILL.md` — the empty-inventory line reads "no literal in the tree matched the scan's shape test". The earlier wording claimed the tree carries no dotted literal with an upper-case segment. `Q.j.r` refutes that claim: it carries an upper-case segment and lists nowhere, because the scan's test also requires two upper-case letters in a row. `docs/events.md` carried the same claim in its closing sentence and now states the shape test. The payload says one thing about one test.

Fixer pass 19 closed the last finding. Sweep 2: the reviewer verified the five batch-2 and batch-4 fixes, reswept the files they touched, and reported DRY. The standing alignment judge reported clean after every batch. Every producer is clean.

# Certification — Team execution and test standards

Status: certified clean

## Outcomes delivered

- `watch-execution-progress` — a sprint's execution runs as a builder and a standing reviewer fed by message. The session keeps one harness task per stage, mirroring the completion report's staged list. It marks each task done as its stage lands. `/ok` offers the project-scoped `CLAUDE_CODE_ENABLE_TODO_TOOLS` setting as a consented entry beside the hook entry (`wire-env`).
- `review-tests-against-the-standard` — the suite carries a testing standard at `.ok-plumbline/docs/testing.md`. The cheatsheet's Testing section is its ambient copy. The certification code-review brief carries the Tests focus: substance first, then the standard's rules. The standing reviewer applies the brief per stage. The gate's cold reviewer applies it over the whole diff.
- `inventory-event-kinds` — the suite carries an events standard at `.ok-plumbline/docs/events.md`. `plumbline events` (the `/events` skill) lists every kind in the tree with its sites, split by the project's `tests` convention. It checks the format, names orphans, hands over the pruning list, and reports every file it did not read. The code-review brief carries the Events focus.
- `team-execution-cold-gate` — execution is a team. `/certify-work` runs afterward as the cold gate, its code reviewer blind to the completion report. Each family's ceremony contribution declares `Standing producers` for the standing reviewer. The sprint-alignment judge reads the report's `## Divergences` and routes claimed forks to the architect.
- `test-quality-by-review`, `event-kinds-as-conventioned-strings`, `subagent-model-follows-job`, `task-tools-mirror-the-report` — landed as written. The reconcile deltas to `document-type`, `experiment`, `audit-audience-split`, `document-composes-audit`, `owner-guided-surface-partition`, and `steering-over-prose-lint` applied verbatim.
- The `.ok-planner/CLAUDE.md` template, the ok-planner cheatsheet, the ok cheatsheet, `plugins/ok/CLAUDE.md`, and the ok-planner family CLAUDE.md restate the execution shape. The three catalog TOCs carry the new slugs.

## Divergences

- D1 — Materialized copies (`.claude/rules/*`, `.claude/skills/*`, `.ok-planner/CLAUDE.md`, `.ok-plumbline/docs/*`) are refreshed by the front door's converge, an owner action; this run edits the canonical payloads only. Certification rewrote `checks/vendored-layer` to derive the sanctioned skill set from the payload instead of a hand-written `PINNED` list. The check passes before and after the converge that vendors `events`. No pin needs editing at the converge.
- D2 — The format check treats a dotted literal as kind-shaped only when it carries three or more segments and at least one segment is fully upper case. Certification added the segment floor so an ordinary filename literal (`SKILL.md`) stops reporting. A mixed-case literal with no upper-case segment (`Queue.job.failed`) is indistinguishable from an ordinary dotted string and passes unflagged. The reviewer with the code open catches that shape.
- D3 — The pruning list is defined as the kinds no test file references — the symmetric counterpart of an orphan (a kind only a test file references).
- D4 — The vendored binary carries no `@story:`/`@decision:` annotations for the events subcommand: `checks/materialized-standalone` forbids citations in payloads that must stand alone in a consumer. The annotations live on the family's converge core and its test suite instead.
- D5 — The `/events` verb runs as a `plumbline events` subcommand of the vendored binary, the one idiom the family's other verbs use, rather than as a script inside the skill body.
- D6 — Claimed forks reach the architect through the sprint-alignment judge (tagged `CLAIMED FORK`, skipping the fixer) rather than through a separate reader; the sprint named the routing, not the carrier.
- D7 — The standing reviewer's Standing producers omit the lint on purpose: the edit hook runs it in the turn that writes and the gate runs it cold; the plumbline contribution says so.

Certification's fixer made these calls beyond the sprint and corpus:

- D8 — It settled the pruning list as "the kinds no test waits on" in the events standard, the cheatsheet, and the `event-kinds-as-conventioned-strings` decision. A literal scan cannot produce the population "referenced nowhere in the tree" that those three named.
- D9 — It named the session as the harness task list's owner in `task-tools-mirror-the-report`. The execution boilerplate puts the list in the session's staging step, and `watch-execution-progress` requires the checklist in the owner's session.
- D10 — It split the code-review brief out of `{{CERTIFY-CODE-REVIEW-PROMPT}}` into `{{CODE-REVIEW-BRIEF}}`, so the standing reviewer transcludes a brief rather than a dispatch header.
- D11 — It had the architect rewrite a claimed fork's entry in this report as it resolves it, so a refuted fork leaves the loop.
- D12 — It counted a cycle against the review-fix loop's cap when that cycle dispatched the fixer or the architect. Counting only fixer dispatches left the loop unbounded when every remaining finding was a claimed fork. The alternative, a separate total-cycle bound, adds a number no sprint named.
- D13 — It gave the session the closing stages' marks in the execution boilerplate's step 2. The builder marks each build stage; the session marks the stages that run after the team retires. The builder retires before those stages run, so it cannot mark them.

- D14 — For a format violation over a foreign dotted constant (`java.util.UUID`), the fixer chose guidance over a config key. The standard and the `/events` skill split the format-violation list by owner: rename a kind this project emits; report a constant another system owns as a scan false positive. The sprint authorized one config key (`tests`). A namespaces key was net-new scope.
- D15 — The standing reviewer's per-stage delta check reads the design files among the stage's paths. The session's per-stage message shape is unchanged. The events scan's size cap (1 MB) and NUL sniff (8 KB) match `post-edit.js`'s constants.
- D16 — The events scan prints its unread-file counts in the header even at zero, so a proof can pin either value. An oversized or binary skip marks the inventory partial under its own label, as an unreadable one does. The format-violation list sorts with the same site comparator as emits and tests.
- D17 — The shape-test fork stands as (a): the scan treats a dotted literal as kind-shaped only when it carries a segment of two or more upper-case letters. The standard and the skill record the blind spot (`queue.job.retried` and `Queue.Job.Retried` list nowhere). A proof pins it. Widening would report every `foo.min.js` at exit 2 and reverse D2.
- D18 — A declared `tests` array replaces the default test paths. The standard and the skill say so where the reader declares it. The `hooks`-not-a-list proof seeds an empty string, the one fixture that fails when the guard goes.
- D19 — `Claimed forks` in the standing reviewer's reply holds only forks the report does not yet carry. A ledger line the builder answered with a recorded fork closes. The report's section is `## Divergences`: one entry per divergence and per claimed fork, each opening with `D<n>` or `F<n>`.
- Corpus repairs under `.ok-planner/design/`, each mirrored in the sidecar, expression only: `team-execution-cold-gate` (the session's report writes), `test-quality-by-review` (the reviewer reports a duplicate or empty test; the fix removes or merges it), `event-kinds-as-conventioned-strings` (the pruning list is the kinds no test waits on), `task-tools-mirror-the-report` (the session keeps the task list), `steering-over-prose-lint` (the PreToolUse hook is on every tool call).
- Refuted by a repo check, no change: cycle 15's finding that `eventsCmd` should carry `@story:` / `@decision:` annotations. `checks/materialized-standalone` lints the binary in a consumer holding no corpus and fails on any annotation. The fixer reproduced the failure and reverted. The annotations stay on the family's converge core and test suite (D4).

No fork was claimed. No architect ran.

## Findings fixed

- Code review: 94 — 89 across sixteen cold cycles (18, 8, 6, 6, 8, 5, 6, 3, 3, 4, 3, 3, 2, 4, 4, 6) and 5 from the standing reviewer's exhaustive sweep (4, then 1). One further finding refuted (above).
- Sprint alignment: 3 — 2 in cycle 1; 1 from the standing judge (the report's `## Divergences` heading and `D<n>` identifiers).
- Plumbline lint: 53 — 50 in cycle 1, 3 comment-hygiene violations in cycle 12.
- Test suites, `checks/run`, annotation floor, sidecar identity: clean on first pass and every re-run.

## Dissolved

None.

## Issues promoted

None.

