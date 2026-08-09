# Completion report: Write-time prose steering

Execution record for `2026-08-08-write-time-prose-steering.md`.

## Work done

- Corpus deltas applied verbatim: new story
  `write-time-prose-steering` and new decision
  `steering-over-prose-lint` copied into `.ok-planner/design/`, with
  sorted TOC lines added to `stories.md` and `decisions.md` in the
  generator's format.
- The writing standard ships in the family payload at
  `plugins/ok/families/ok-plumbline/docs/technical-writing.md` (the
  drafted document, authorized by this sprint). `admin/converge`
  stamps it into the consumer estate at
  `.ok-plumbline/docs/technical-writing.md`, and the estate LICENSE
  preamble now names the docs it covers.
- Diagnose fidelity: the standard joined `estateCorpusPayload()` in
  `bin/plumbline`, so `plumbline diagnose` verifies the materialized
  copy against the carried rendering (and checks presence when run
  outside the plugin copy), per the materialized-artifact concept's
  fidelity invariant.
- The plumbline cheatsheet gained a Technical Writing section: the
  standard's dispatch rule verbatim, a pointer to the materialized
  guide, and a note that the PreToolUse hook injects the same rule at
  write time. The Tooling list now names both hooks.
- The steering hook `scripts/hooks/pre-write.js`: on a Write/Edit
  whose target path ends `.md` and lies inside the project root, it
  reads the dispatch rule from the materialized standard and returns
  `hookSpecificOutput` with `permissionDecision: "allow"` and the
  rule as `additionalContext` — steering, never blocking. Fail-open
  everywhere: non-md paths, outside-root paths, missing standard,
  unparseable input all exit 0 in silence. Converge materializes it
  to `.ok-plumbline/hooks/pre-write.js`.
- Wiring: `bin/plumbline` now carries both canonical entries
  (PostToolUse lint, PreToolUse steering, both matcher `Edit|Write`);
  `wire-hooks` transcribes both on the one consent, `diagnose`
  reports both (wiring findings, hook fidelity against the carried
  rendering, WIRING NEEDED block shows both entries). Both hook
  scripts joined `estateCorpusPayload()`, so the old presence-only
  check for `post-edit.js` was dropped in favor of the corpus's
  fidelity check (presence-only outside the plugin copy).
  `admin/ADMINISTRATION.md`'s wiring section
  covers both hooks under the same consent-then-transcription path.
- Tests: `test/run.sh` gained a `write-time-prose-steering` section
  (annotated `@story:` / `@decision:`) proving end-to-end: converge
  materializes the standard; one consent wires both entries; a
  converged, wired estate diagnoses clean; a markdown write receives
  the dispatch rule as context (`permissionDecision: "allow"`); a
  subagent-shaped event receives the same injection; non-markdown
  and outside-root writes pass in silence; a missing standard
  degrades to silence. The estate-diagnose case also proves a
  hand-edited `post-edit.js` or `pre-write.js` is caught from the
  payload.
- `checks/materialized-standalone` enumerates the two new payloads:
  `pre-write.js` linted standalone in a bare consumer, and
  `technical-writing.md` checked for monorepo-only citations.

## Divergences

- None from the sprint's promised outcomes. Four adjacent surfaces
  were updated because their claims would otherwise have gone false:
  the estate LICENSE preamble's enumeration of covered files, the
  administration document's descriptions of diagnose and wiring, the
  materialized-standalone check's payload list, and the family
  `README.md`'s Install paragraph — which now names the writing
  standard and the steering hook among what converge vendors, and the
  two settings entries wired on one consent.

## Calls made where the sprint was silent

- The PreToolUse injection mechanism: confirmed against the Claude
  Code hooks reference (code.claude.com/docs/en/hooks) that a
  PreToolUse hook returns
  `hookSpecificOutput: { hookEventName: "PreToolUse",
  permissionDecision: "allow", additionalContext: "<text>" }` to feed
  context to the model while letting the write proceed. The hook is
  built on that mechanism.
- The injected context is the dispatch rule read at run time from the
  materialized standard (the blockquote under "The dispatch rule"),
  prefixed with one sentence naming its source — one source of truth,
  no duplicated rule text in the hook.
- `.md` path matching is exact (`endsWith('.md')`), reading the
  decision's "any target path ending `.md`" literally.
- No citation annotations inside materialized payloads
  (`bin/plumbline`, `pre-write.js`): the materialized-standalone
  check forbids monorepo-only citations in files consumers receive.
  The `@story:` / `@decision:` navigation annotations live in
  `admin/converge` and `test/run.sh`, which stay in the monorepo.
- This repository itself is not a plumbline consumer (no
  `.ok-plumbline/` estate at the root), so no wiring was added to
  this repo's `.claude/settings.json`; the consent path is exercised
  by the tests.

## Suites run

- `plugins/ok/families/ok-plumbline/test/run.sh` — all tests passed.
- `bash checks/run` — all seven checks ok (after adding the new
  payloads to materialized-standalone).
- `plugins/ok/test/administration.sh` — 69 ok, 0 failures.
- `plugins/ok/families/ok-planner/test/run.sh` and `test/stories.sh`
  — passed (exit 0).
- `plugins/ok/families/ok-workspaces/test/demo.sh` and `test/tags.sh`
  — passed (exit 0).

# Certification — Write-time prose steering

Status: certified clean

## Outcomes delivered

- `write-time-prose-steering` (story): a converged consumer estate
  now carries the writing standard at
  `.ok-plumbline/docs/technical-writing.md`; the cheatsheet delivers
  the dispatch rule ambiently to every agent; and on the owner's one
  wiring consent, any agent's Write or Edit of a `.md` path inside
  the project — main session or dispatched subagent — receives the
  dispatch rule as injected context at the moment of the write,
  proven end-to-end by the plumbline suite.
- `steering-over-prose-lint` (decision): recorded in the corpus.
  No prose lint exists; the lint's charter stays comments and
  citations; steering is the enforcement, with the ambient
  cheatsheet copy pointing at the materialized standard.

## Divergences

- Four adjacent surfaces were updated so their claims would not go
  false: the estate LICENSE preamble's file enumeration
  (`admin/converge`), the administration document's diagnose and
  wiring descriptions (`admin/ADMINISTRATION.md`), the
  materialized-standalone check's payload list, and the family
  README's Install paragraph.
- Fixer calls, each open to veto: (cycle 2) the administration
  doc's fidelity claim was made true in code rather than weakened in
  prose — both hook scripts joined the fidelity-checked payload in
  `estateCorpusPayload()`, the subsumed presence-only diagnose
  checks were dropped, and a hand-edited-hook test case was added;
  (cycle 3) the "no vendored binary … the edit hook uses it"
  diagnose line was deliberately left singular because only the
  edit hook invokes the vendored binary.
- Execution calls where the sprint was silent are recorded in
  "Calls made" above (documented `additionalContext` mechanism;
  rule read at run time from the materialized standard; literal
  `.md` matching; no citations inside materialized payloads).
- No fixer or architect edits under `.ok-planner/design/`; no
  architect refutations — the architect never ran, since no cycle
  produced a kickback or dissolution.

## Findings fixed

- Sprint alignment: clean on the first pass and on every re-run
  (deltas byte-verified, no undershoot, corpus coherent).
- Test suites: clean throughout — plumbline `run.sh`, `checks/run`,
  `administration.sh`, planner `run.sh` + `stories.sh`, workspaces
  `demo.sh` + `tags.sh`.
- Mechanical floor: clean each round (37 annotation lines in
  changed files, all resolving).
- Code review: four findings across three fix cycles, all fixed —
  a stale diagnose success message enumerating a subset of the
  fidelity-checked payload; the administration doc overclaiming
  hook fidelity (resolved by making diagnose actually
  fidelity-check both hooks); the README's stale Install paragraph;
  a stale module-marker message plus completion-report omissions.

## Issues promoted

None. Zero kickbacks, zero dissolutions, zero cap escalations; the
intake is untouched by this run.
