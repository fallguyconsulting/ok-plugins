# Completion report: Reconcile marker-based root resolution into the corpus

Execution record for `2026-08-08-reconcile-root-resolution.md`, run as a
goal-driven session on 2026-08-08.

## Work done

- **Promoted issue stamped.** The planning ceremony's terminal act was
  still owed when execution began (the owner signed off by handing the
  sprint to the goal mechanism), so this session stamped
  `issues/2026-08-09-051435-root-resolution-markers-not-git.md` with
  `status: promoted` and the sprint filename before starting the work.
- **Corpus deltas applied verbatim.** Both final-form bodies copied
  over the live artifacts: `design/concepts/estate.md` and
  `design/decisions/filesystem-discovery-markers.md`. The `concepts.md`
  TOC line for `estate` was refreshed to the new first sentence (same
  truncation length as the generator's); the `decisions.md` TOC line
  was left alone because its truncated text precedes everything the
  delta changed.
- **Three ok-plumbline sites brought to the marker rule.**
  - `scripts/hooks/post-edit.js` and `scripts/hooks/pre-write.js`:
    the `.git`-walk `resolveProjectRoot` replaced with the marker walk
    (all three estates plus the two documented pre-migration markers,
    else the starting directory), and both hooks now gate on ok-plumbline
    presence at the resolved root (`.ok-plumbline`, `.plumbline.json`,
    or the pre-migration cheatsheet) — they no-op exactly when that
    presence is absent. `.git` is consulted nowhere for root
    resolution; `post-edit.js` still shells out to git only to compute
    changed-line ranges, and outside a repository that path degrades
    to whole-file linting as before.
  - `bin/plumbline`: `findRepoRoot` renamed to `findProjectRoot`
    (four call sites), `.git` removed from the scan, and the marker
    set widened from `.ok-plumbline/config.json` / `.plumbline.json`
    to the full estate marker list, falling back to the start
    directory.
  - The `@decision: filesystem-discovery-markers` annotation lives at
    the payload-side sites (`admin/converge`, `test/run.sh`); the
    materialized payloads carry none, per the standalone check (see
    Certification below).
- **Verification.** ok-plumbline `test/run.sh`, ok-planner
  `test/run.sh` and `test/stories.sh`, ok-workspaces `test/tags.sh`
  and `test/demo.sh`, and the repo `checks/run` suite all pass.

## Divergences and calls made where the sprint was silent

- **Harness case updated to the new commitment.** The plumbline hook
  harness asserted the retired behavior ("fail-open: no repository"
  expected the hook silent outside a git repo). Under the sprint's
  outcome an estate-carrying root is linted regardless of git, so the
  case now expects the block (exit 2) and is named "no repository:
  estate presence still lints, whole file"; a new case asserts silence
  when the resolved root carries no plumbline presence. The sprint
  mandated no tests (its deltas amend a concept and a decision, no
  story), but the harness had to describe the behavior the work item
  commits to.
- **Pre-existing red fixed in scope.** The plumbline self-lint test
  ("the family's own tree is clean under its own lint") was already
  failing at HEAD: the out-of-band work had left a five-line prose
  comment above `admin/converge`'s `resolve_root`, which
  plumbline/comment-hygiene forbids. Replaced with a single
  `# @decision: filesystem-discovery-markers` citation line, which the
  lint permits and which points at the artifact carrying the rule.
- **Accidental plumbline bootstrap, reversed.** This session ran
  `ok-plumbline/admin/converge` expecting to re-materialize dogfood
  hook copies, but this repository integrates only ok-planner — the
  converge core does not gate on an existing estate, so the run
  bootstrapped one: `.ok-plumbline/`, the plumbline cheatsheet under
  `.claude/rules/`, and seven vendored skill folders, all untracked.
  All nine created paths were moved out of the repository into the
  session scratchpad, restoring the tree to the intended change set.
  Consumer distribution needs nothing from this repo, exactly as the
  work item states: the canonical payload carries the fix, and each
  consumer's own converge re-materializes its hook copies.
- **`findRepoRoot` renamed.** The sprint states outcomes, not
  methods; the name said "repo" while the function now resolves the
  project root with git playing no part, so it was renamed
  `findProjectRoot` rather than left misdescribing itself.

## Certification

# Certification — Reconcile marker-based root resolution into the corpus

Status: certified clean

## Outcomes delivered

- `concept:estate` now commits to the definitional flip: the project
  root is defined by the estate (nearest ancestor of the working
  directory, itself included, carrying an estate or documented
  pre-migration marker, else the working directory itself), the
  repository layout plays no part, and all of a project's estates
  share one root. Applied verbatim from the sprint's delta.
- `decision:filesystem-discovery-markers` now records the same
  resolution rule in its Choice, the subproject justification in its
  Rationale, and nearest-`.git`-ancestor as a rejected alternative.
  Applied verbatim.
- The one work item is realized: `post-edit.js`, `pre-write.js`, and
  `bin/plumbline` all resolve the project root by the marker rule,
  the hooks no-op exactly when the resolved root carries no
  ok-plumbline presence, and `.git` is consulted nowhere for root
  resolution — so the concept's universal claim ("every
  implementation of root resolution across the suite conforms") is
  now true, confirmed by repo-wide sweep.

## Divergences

- Harness case updated to the new commitment: "fail-open: no
  repository" (silence outside a git repo) became "no repository:
  estate presence still lints, whole file" (exit 2), plus a new
  no-presence silence case — the old case asserted the exact behavior
  the sprint retires.
- Pre-existing red fixed in scope: the plumbline self-lint test was
  already failing at HEAD over a five-line prose comment in
  `admin/converge` left by the out-of-band work; replaced with a
  single `# @decision: filesystem-discovery-markers` citation line.
- Accidental plumbline bootstrap, reversed: this session ran
  `ok-plumbline/admin/converge` expecting a dogfood estate; the repo
  integrates only ok-planner, so the converge created `.ok-plumbline/`,
  the plumbline cheatsheet, and seven vendored skill folders — all
  untracked, all moved out of the repository into the session
  scratchpad. No tracked content was touched.
- `findRepoRoot` renamed `findProjectRoot` (four call sites): the old
  name misdescribed a function that no longer consults the repository.
- Fixer's calls (cycle 1): built the new pre-write test fixtures by
  copying the materialized hook and standard out of the converged
  test repo (exercising the bytes converge ships); noted that a
  presence-free root and a standard-free root are observationally
  identical for `pre-write.js`, so the floater case pins the
  delivered behavior (exit 0, empty output).
- No corpus edits were made by the fixer or architect; no kickbacks,
  no dissolutions, no architect dispatch needed.

## Findings fixed

- **Test suites** (ok-plumbline, ok-planner, ok-workspaces, repo
  `checks/run`): two defects surfaced and fixed during execution
  (the retired-behavior harness case; the pre-existing comment-
  hygiene red) — final state all green, verified with direct exit
  codes.
- **Sprint alignment** (corpus-change judge): clean on first pass —
  deltas byte-for-byte, work item realized with no undershoot,
  changed corpus coherent with the live corpus.
- **Mechanical floor** (annotation integrity): clean — every
  `@kind:slug` pair in the changed files resolves to a live artifact.
- **Code review** (diff-scoped): 2 findings across 2 cycles, both
  fixed. Cycle 1: `pre-write.js`'s new root resolution and presence
  gate had no end-to-end test — fixer added mirrored bare/floater
  cases to `run_steering_proof`. Cycle 2: the three
  `@decision:` annotation comments in materialized payloads failed
  `checks/materialized-standalone` (a citation cannot resolve in a
  consumer with no citation config; the earlier "checks green"
  reading was a piped-exit-code misread) — fixer removed exactly
  those three comment lines. Re-review after each cycle: clean.

## Issues promoted

None. The intake was reached by neither path: no architect-confirmed
forks (the architect was never dispatched), no cap escalation (the
loop closed in two cycles).

