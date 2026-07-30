---
name: certify-work
description: "ONLY activated by explicit /certify-work slash command, or as the terminal step named in the sprint document's execution boilerplate. Never auto-triggered by conversation content. Change-scoped certification: certifies the work just done — the uncommitted tree by default, a commit range on request — running the sprint-alignment judge, the project's test suites, and the code review over the diff, a no-discretion review-fix loop (fixer, then an architect on kickbacks), and the presentation, with archival/commit offered as owner acts. Whether the corpus's claims still hold is the periodic /verify-corpus run, never this gate."
---

# Certify the Work (the change-scoped gate)

The "am I done?" gate for an implementation goal, **scoped to the change**. This is the everyday close — the one the sprint boilerplate names — and it discharges the sprint's completion contract, which is itself stated in touched-scope terms.

This gate does not audit. Whether the corpus's stories and decisions are still supported by the codebase is a question about the whole corpus, asked on the owner's cadence by `/verify-corpus` — never per close. What this gate defends is the change: the sprint realized, the suites green, the diff sound. The machinery it runs — the review-fix loop and its veto test, the fixer and architect subagents, the code-review prompt, the presentation — is defined once in `../_shared/certification-core.md`.

## Scope

**Default — the uncommitted working tree.** `git status` and `git diff` (and `--staged`): new, modified, and deleted files, staged or not.

**On request — a commit range.** If the invocation carries an argument that parses as a git range or ref (`main..HEAD`, `v8.0.0..`, `abc123..def456`), the subject is that range's diff (`git diff <range>` + `git log <range>` for the story of the work) **plus** the uncommitted tree, so nothing in flight is skipped. Use this to certify work that was committed along the way.

**The touched set**, derived once and used by every stage below:

- **Changed files** — from the diff.
- **Touched artifacts** — design files changed directly, plus every artifact a sprint-in-scope's deltas and work items name. Code annotations play no part in this derivation — navigation is their only job.

## Process

1. **Ensure the layout.** Run `mkdir -p .ok-planner/issues .ok-planner/history/issues` so the intake exists. Estate convergence is the front door's administration (`/ok`), not this gate's.

2. **Resolve scope** per the Scope section: subject (tree or range+tree), then the touched set. If a sprint is named as an argument — the invocation the sprint's own closing step makes — that is the alignment target; otherwise there is no sprint and the alignment producer is skipped. A bare invocation never adopts a sprint from `.ok-planner/sprints/`, however many are in flight, and raises no advisory about them.

3. **The review-fix loop.** Run `{{CERTIFY-REVIEW-FIX-LOOP}}` from `../_shared/certification-core.md` — initial review by every producer, then fixer → architect → re-review cycles to clean or the cap. Each producer re-runs at its original scope. This gate's producers, each at change scope:

   - **Sprint alignment** (only with a sprint in scope) — the corpus-change judge. Dispatch `{{SPRINT-ALIGNMENT-PROMPT}}` from `../_shared/certification-core.md` with `[SPRINT PATH]` filled: deltas applied verbatim, every work item's outcome realized (an undershoot is a **blocking** finding), and the changed corpus coherent with the live corpus — mid-cycle corpus edits by the fixer or architect are checked here too.
   - **Test suites.** Discover the run commands from the project's own docs (CLAUDE.md, README, Makefile, package manifest) — never invent an invocation — and run the suites that cover the change (the full suites when scoping is unclear). Every failure is a finding for the loop.
   - **The mechanical floor** (inline, no subagent): **annotation integrity** — `rg -n '@(concept|story|decision):\s*\S+'` over the changed files, every (kind, slug) pair resolving to a live artifact. Consistency of the changed corpus rides the alignment producer above; delta compliance was paid at `/plan-sprint` sign-off; whole-corpus compliance and whether the corpus's claims still hold belong to `/ok-planner-audit` and `/verify-corpus`.
   - **Code review, scoped to the diff.** Dispatch `{{CERTIFY-CODE-REVIEW-PROMPT}}` from `../_shared/certification-core.md` with `[REVIEW SCOPE]` filled as:

   ```
   The change under certification: [the uncommitted working-tree
   change | the diff of <range> plus the uncommitted tree]. Enumerate
   it with git status/diff before forming findings; code deleted in
   the change is gone — do not form findings about it. Read changed
   files in full for context.

   Findings are confined to the change and what it directly breaks:
   a defect in changed code, a caller the change breaks, a
   load-bearing property the change trades away. A pre-existing
   defect is in scope only where the change touches or depends on
   it — do not sweep unrelated files, and do not follow trails out
   of the change's footprint. Corpus-wide and repo-wide sweeps
   belong to the whole-corpus verbs.
   ```

   One scope rule for the fixer and architect: a fix may of course edit any file the correct fix requires, but findings stay change-scoped — the loop is not a license to re-audit the repository.

4. **Verify the promoted issues** — if the architect promoted any or the cap escalation filed any. Invoke `verify-issues`; it makes everything filed this run ruling-ready (and skips the already-verified intake). Zero filings → skip, silently.

5. **Present.** Compose and deliver `{{CERTIFY-PRESENTATION}}` from `../_shared/certification-core.md`. The per-producer "Findings fixed" lines for this gate: alignment (the corpus-change judge), the test suites, the mechanical floor, code review.

6. **Offer the close-out.** Run `{{CERTIFY-CLOSE-OUT}}` from `../_shared/certification-core.md`.

## When to reach for the whole-corpus verbs instead

- **`/verify-corpus`** — before a release, after a run of sprints, or whenever you want to know whether the corpus's claims still hold. A change-scoped gate never asks that question.
- **`/ok-planner-audit`** — when the change touches the canonical authoring rules (e.g. `../_shared/artifact-definitions.md` in this repo's case), since a change-scoped check cannot see the corpus-wide fallout of a rule change.

## What this skill does NOT do

`{{CERTIFY-GATE-BOUNDARIES}}` from `../_shared/certification-core.md`, plus:

- Does not audit. It writes nothing under `.ok-planner/audits/`, reads no determination, and forms no finding about whether an artifact is still supported — that is `/verify-corpus`, on the owner's cadence.
- Does not run `/ok-planner-audit` whole-corpus, and its presentation may recommend one when the change touched the authoring rules.
- Does not widen scope mid-run. A finding outside the change's footprint that isn't caused or depended on by the change is not this gate's finding; if it matters, a human files it to the intake.

<!-- Materialized by ok-planner v14.1.0 — suite-owned; overwritten on converge; do not hand-edit. -->
