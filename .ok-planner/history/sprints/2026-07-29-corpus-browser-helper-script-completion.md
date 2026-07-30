# Completion report: Corpus-browser helper script, browse-skill retirement, and migration ratification

Execution record for `2026-07-29-corpus-browser-helper-script.md`.
Written as the work lands; finished by `/certify-work`'s presentation.

## Work done

### Helper script

`plugins/ok/families/ok-planner/scripts/browse` (python, stdlib-only,
version-stamped via `{{OK_PLANNER_VERSION}}`): `up` starts the sibling
`corpus-view` with `--port 0` (the OS picks any free loopback port),
detached in its own session, waits for the serving line, probes the
URL until it answers, records `<pid> <port>` in
`.ok-planner/run/corpus-view`, prints the view's own version
announcement, and opens the system browser (`webbrowser`, honoring
`BROWSER`); `down` confirms the recorded pid is a corpus-view process
before signalling it (TERM, then KILL after a grace window) and
removes the run state. Both verbs idempotent and stale-record
tolerant: `up` against a live view reuses it, a dead or reused pid is
cleaned up and reported, `down` with nothing recorded is a no-op.
Smoke-tested standalone in a scratch estate: fresh up, idempotent up,
down, down-again, and stale-record up all behaved.

### Converge materialization

`admin/converge` materializes `bin/browse` beside the other pinned
tools (sed-stamped, `chmod 755`) and diagnoses it with the same
`check_rendered` the others use. The estate gitignore template gains
the `run/` directory. Fixture-verified: converge places an executable
stamped `bin/browse`, `git check-ignore` covers
`.ok-planner/run/corpus-view`.

### Browse-skill retirement

- `skills/browse/` removed from the family payload.
- `admin/converge`: `browse` removed from the vendoring map and the
  unprefixed-rename list; added to `RETIRED_VENDORED`, so consumer
  converges sweep the stale vendored copy (fixture-verified).
- `checks/vendored-layer`: `.claude/skills/browse` unpinned, and this
  repo's vendored copy deleted in the same change (the unpinned-skill
  check would otherwise flag it).
- Router `skills/ok-planner/SKILL.md`: the `/browse` row removed.
- `admin/ADMINISTRATION.md`: `bin/browse` added to the materialized
  list and the owned-set list; the gitignore description now names the
  run state.
- Family `CLAUDE.md`: purpose paragraph reworded (view started/stopped
  by the estate's own script, not a skill), `scripts/browse` layout
  row added, gitignore row updated.
- `README.md`: the browsable paragraph now names
  `.ok-planner/bin/browse up` / `down`.
- Estate template `scripts/ok-planner-CLAUDE.md`: a short paragraph in
  the audit/graph section makes the script discoverable in consumer
  projects.
- `scripts/corpus-view`: one docstring naming the retired `/browse`
  verb reworded to name the script.

### Corpus deltas

All three applied and verified byte-identical to the sprint's
final-form bodies: `concepts/true-up.md` (migration invariant
rewritten to compliance-bringing), `concepts/design-corpus.md`
(writers invariant aligned), `decisions/local-web-surface.md`
("nothing left behind" excised). No catalog-TOC refresh needed — no
artifact's opening sentence changed.

### Tests

`plugins/ok/test/administration.sh` gains converge-materialization
coverage for `bin/browse` and the `run/` gitignore entry, exercised
on the same fixture estates the harness already builds.
`plugins/ok/families/ok-planner/test/stories.sh`: the retired
browse-skill run-block section (which executed the skill's fenced
bash and asserted the payload-fallback note) is replaced by an
estate-pinned up/down cycle against the existing pinned fixture —
server answers on the recorded port, the run file exists and is
git-ignored, idempotent `up` reuses the live view, `down` kills the
process and removes the file, repeated `down` is a no-op, and every
way a record can be wrong is tolerated and reported: a dead pid, a
live view wedged behind a port that no longer answers (terminated and
replaced), a pid the OS has recycled for an unrelated process (left
running, reported as such), and an unreadable record (announced and
dropped by both verbs). The existing corpus-view serving tests stand
unchanged.

Suites at execution's close: `checks/run`, `stories.sh`, `run.sh`
(planner), the plumbline and workspaces harnesses all exit 0. The
mid-execution reading of `administration.sh` as "exit 0" was a
misread — the exit code was piped through `tail` — and the gate's
own test producer later caught the real failure it masked (the
vendored-set count floor; see Certification below). At the final
tree, all seven suites exit 0: `checks/run`,
`plugins/ok/test/administration.sh`,
`plugins/ok/families/ok-planner/test/stories.sh` (73 ok),
`plugins/ok/families/ok-planner/test/run.sh`,
`plugins/ok/families/ok-plumbline/test/run.sh`, and
`plugins/ok/families/ok-workspaces/test/{tags,demo}.sh`.

## Divergences and calls made where the sprint was silent

- **Run-state location**: `.ok-planner/run/` with one record file
  `corpus-view` (`<pid> <port>`) plus `corpus-view.log`; `down`
  removes both. The sprint named "the estate's gitignored run-state
  directory" without naming it.
- **No payload fallback in the script**: `browse` starts the sibling
  `corpus-view` beside itself — the estate's pinned copy when
  materialized, the payload's copy when run from the carried family —
  and errors clearly when no sibling exists. The retired skill's
  payload-fallback announcement had no equivalent to preserve here;
  the sprint's test item calls this "the script's estate-pinned
  reality".
- **Pid-reuse safety**: `down` (and stale detection in `up`) confirms
  the recorded pid is a corpus-view process via `ps` before
  signalling, so a recycled pid's record is dropped without the
  process ever being signalled — never killed on the record's say-so.
  The two non-corpus-view cases are reported apart, since they are
  different system states: a dead pid is "gone", a live-but-recycled
  one is "running something else now — record cleaned up, nothing
  signalled".
- **This repo's estate is not re-converged mid-sprint**: the vendored
  layer is pinned to HEAD by `checks/vendored-layer` and legitimately
  lags family source until the next release's converge (the same
  pattern the corpus-view sprint followed). The one estate-side edit
  made now is the deletion of `.claude/skills/browse` alongside its
  unpinning, which that check itself forces. The repo's own
  `.ok-planner/bin/browse` and updated `.gitignore` arrive with the
  next release's re-converge.
- **Vendored router lag**: the repo's vendored
  `.claude/skills/ok-planner/SKILL.md` still carries the `/browse` row
  until the release converge rewrites it — the legal lag window the
  vendored-layer check documents.

# Certification — Corpus-browser helper script, browse-skill retirement, and migration ratification

Status: certified clean

## Outcomes delivered

- **decision:local-web-surface** — the corpus view is a process the
  owner starts and closes: `.ok-planner/bin/browse up` serves it on
  any free loopback port, opens the system browser, and records the
  process in the estate's gitignored `run/`; `down` stops exactly
  what the record names. Every way a record can be wrong (dead pid,
  wedged live view, OS-recycled pid, malformed record) is tolerated,
  reported accurately, and exercised end-to-end in `stories.sh`.
- **story:trace-corpus-to-code** — the reader's way to reach the
  corpus-to-code view is the estate's own script now that the
  `/browse` skill is retired; the serving tests stand and the audit
  cites the script as the access path.
- **decision:per-project-pinning** — `browse` is materialized into
  `bin/` beside the other pinned tools, version-stamped, diagnosed by
  the same `check_rendered`, and starts its sibling `corpus-view` —
  the estate's own pinned copy.
- **decision:vendored-skills / decision:slash-only-activation** —
  both populations shrank by one: the skill is gone from the payload,
  the vendoring map, the pinned list, the router table, and every
  document that named it; consumer converges sweep the stale vendored
  copy via `RETIRED_VENDORED`.
- **Owner rulings recorded** — the `7c0c631..5e97ec4` corpus state is
  ratified (receipt in the sprint's Intent; no delta needed), and
  `true-up`'s migration invariant now states the owner's actual
  intent (compliance-bringing migration), with `design-corpus`'s
  writers invariant aligned and `local-web-surface`'s
  "nothing left behind" clause excised — all three deltas applied
  byte-verbatim.

## Divergences

All from the execution record and the fix cycles; no kickbacks were
raised, no dissolutions claimed, and the architect was never needed.

- Run state lives at `.ok-planner/run/corpus-view` (`<pid> <port>`)
  plus `corpus-view.log`; the sprint named the directory's purpose
  but not its name.
- The script has no payload fallback: it runs the sibling
  `corpus-view` and errors clearly when none exists — the
  estate-pinned reality the sprint's test item names.
- A recycled pid and a dead pid are reported as the distinct system
  states they are (`reused_or_gone`), and neither is ever signalled
  on the record's say-so; `up` announces a malformed record before
  starting fresh (fixer cycle 1, from code-review findings).
- `administration.sh`'s vendored-set check now derives its expected
  set from converge's own `SKILLS` map and requires exact two-way
  equality, replacing the hand-maintained `-ge 10` floor that failed
  once the roster shrank to nine (fixer cycle 2; discrimination-
  probed in both directions).
- This repo's estate was not re-converged mid-sprint: the vendored
  layer legitimately lags family source until the next release's
  converge; `.claude/skills/browse` was deleted now because its
  unpinning from `checks/vendored-layer` requires it, and the
  vendored router still lists `/browse` until the release converge
  rewrites it.
- No corpus repairs were made by the fixer or architect; the only
  design-file edits in the change are the sprint's three deltas.

## Findings fixed

- **Sprint alignment**: clean on the initial pass; the re-review
  flagged two mechanical in-flight gaps (undispositioned nodes, and
  the two escalated audits' dangling citations) that this same
  cycle's inspection and audit work closed.
- **Test suites**: 1 finding — `administration.sh` exit 1 on the
  stale vendored-set floor (masked in the executor's mid-run reading
  by a piped exit code; caught by the gate). Fixed as above. All
  seven suites exit 0 at the final tree.
- **Implementation audit**: re-audit set of 27 refs (26
  checker-stale — the browse retirement and the fix cycles touched
  heavily-cited files — plus `whole-file-ownership` by nomination).
  Outcomes: 11 rewritten in place, the rest refreshed on recorded
  precedent; 2 refresh escalations (`slash-only-activation`,
  `code-cites-design` — enumerated populations shrank) resolved by
  full-pass re-derivation (23 skills; 147 annotation lines over 47
  pairs). 0 violated; 44/44 satisfied. Adjudications this run: 13
  promoted, 1 dismissed; no entry left open.
- **Mechanical floor** (annotation integrity): clean — the two
  candidates were prose mentions of the annotation syntax, not
  annotations.
- **Code review**: 3 findings (pid-reuse message accuracy, two
  untested safety branches, malformed-record inconsistency), all
  fixed in cycle 1; re-review clean, no new defects in the fixes.

The loop closed in 2 fixer passes (cap 3), zero kickbacks, zero
dissolutions, zero promotions.

## Reconciliation ledger

Every hunk of the change is dispositioned; `audit-check --inspection`
exits 0.

- **Mechanical**: the deleted skill copies (payload and vendored),
  `scripts/browse`, `test/stories.sh`, the router `SKILL.md`, and
  every other hunk whose citation staleness forced a re-read.
- **Adjudicated**: 13 promoted this run — the new script (3 audits),
  `checks/vendored-layer`, `admin/converge`, `admin/ADMINISTRATION.md`
  (whole-file-ownership), `scripts/corpus-view` and the gitignore
  template (local-web-surface), `plugins/ok/test/administration.sh`
  (per-project-pinning), the family `CLAUDE.md` purpose section
  (no-execution-engine), and three floor-closing entries for nodes
  whose covering staleness the re-pinning consumed; 1 dismissed
  (`README.md`'s top node — every changed byte inside the child
  section the audit already pins).
- **Residue**: one standing entry — the estate template
  `ok-planner-CLAUDE.md` section (internal onboarding prose no audit
  claims); the two amended concept files sit outside the audit floor
  by design (concepts carry no audits). Nothing new for the intake.

## Referrals

Eleven, from the in-scope audits — each a promise verified to exist
in form, suitability owned by the named discipline:

- local-web-surface: excerpts "held open inline beside the list"
  (ux); "cheapest surface that carries both halves" (human-review).
- per-project-pinning: the audit verb's fallback announcement lives
  in prompt form (human-review).
- trace-corpus-to-code: the rendered page's layout and navigation
  (ux).
- adversarial-implementation-audits: audits read terse and
  current-state for a time-poor engineer (editorial).
- audit-audience-split: the intake stays owner-calibrated
  (human-review).
- certify-completion: the presentation reads as "whole"
  (human-review).
- one-command-suite-upkeep: the consolidated-act dialogue reads as
  one act (ux).
- session-awareness: agents use the project's terms correctly
  (human-review).
- relevance-scoped-queue-gate: the bearing/independent split's
  rightness (human-review).
- plan-a-sprint: whether a drafted sprint suffices for an arbitrary
  executor (human-review).

## Issues promoted

None — no architect promotions, no cap escalation; `/verify-issues`
was skipped (zero filings) and the intake remains empty.

The work is certified clean; archiving this sprint with this report
to `history/` and committing the work are offered as owner acts
below.
