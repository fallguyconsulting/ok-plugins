---
name: certify-work
description: "ONLY activated by explicit /certify-work slash command, or as the terminal step named in the sprint document's execution boilerplate. Never auto-triggered by conversation content. Change-scoped certification: certifies the work just done — the uncommitted tree by default, a commit range on request — running the sprint-alignment judge, the project's test suites, the implementation audits (the re-audit set from citation staleness plus adjudicated change-inspection nominations, coverage included), and the code review over the diff, a no-discretion review-fix loop (fixer, then an architect on kickbacks), and the presentation — reconciliation ledger included — with archival/commit offered as owner acts. Whole-corpus certification is /certify-all."
---

# Certify the Work (the change-scoped gate)

The "am I done?" gate for an implementation goal, **scoped to the change**. This is the everyday close — the one the sprint boilerplate names — and it discharges the sprint's completion contract, which is itself stated in touched-scope terms. Corpus-wide drift that predates the change is `/certify-all`'s business (run it on a cadence), not every close's.

Everything that is not scope is shared verbatim with `/certify-all` and defined once in `../_shared/certification-core.md`: the review-fix loop and its veto test, the fixer and architect subagents, the code-review prompt, the presentation. The two gates differ only in what they look at.

## Scope

**Default — the uncommitted working tree.** `git status` and `git diff` (and `--staged`): new, modified, and deleted files, staged or not.

**On request — a commit range.** If the invocation carries an argument that parses as a git range or ref (`main..HEAD`, `v8.0.0..`, `abc123..def456`), the subject is that range's diff (`git diff <range>` + `git log <range>` for the story of the work) **plus** the uncommitted tree, so nothing in flight is skipped. Use this to certify work that was committed along the way.

**The touched set**, derived once and used by every stage below:

- **Changed files** — from the diff.
- **Touched artifacts** — design files changed directly, plus every artifact a sprint-in-scope's deltas and work items name. Code annotations play no part in this derivation or in any invalidation below — navigation is their only job.
- **Touched stories and decisions** — the story/decision subset of the touched artifacts. Both kinds seed the implementation-audit producer's re-audit set.

## Process

1. **Ensure the layout.** Run `mkdir -p .ok-planner/issues .ok-planner/history/issues` — and, where `.ok-planner/design/` exists, `mkdir -p .ok-planner/audits/stories .ok-planner/audits/decisions .ok-planner/history/audits` — so the intake and the audit corpus buckets exist. Estate convergence is the front door's administration (`/ok`), not this gate's.

2. **Resolve scope** per the Scope section: subject (tree or range+tree), then the touched set. If a sprint is named as an argument — the invocation the sprint's own closing step makes — that is the alignment target; otherwise there is no sprint and the alignment producer is skipped. A bare invocation never adopts a sprint from `.ok-planner/sprints/`, however many are in flight, and raises no advisory about them.

3. **The review-fix loop.** Run `{{CERTIFY-REVIEW-FIX-LOOP}}` from `../_shared/certification-core.md` — initial review by every producer, then fixer → architect → re-review cycles to clean or the cap. On each re-review, the implementation-audit producer's scope is recomputed in both layers: the graph is regenerated, `audit-check repoint` re-points pure moves, `audit-check --list-stale` names every audit the fixer's edits disturbed — in or out of the original delta — and the change inspector re-runs over the then-current diff to nominate what citations cannot see. This gate's producers, each at change scope:

   - **Sprint alignment** (only with a sprint in scope) — the corpus-change judge. Dispatch `{{SPRINT-ALIGNMENT-PROMPT}}` from `../_shared/certification-core.md` with `[SPRINT PATH]` filled: deltas applied verbatim, every work item's outcome realized (an undershoot is a **blocking** finding), and the changed corpus coherent with the live corpus — mid-cycle corpus edits by the fixer or architect are checked here too.
   - **Test suites.** Discover the run commands from the project's own docs (CLAUDE.md, README, Makefile, package manifest) — never invent an invocation — and run the suites that cover the change (the full suites when scoping is unclear). Every failure is a finding for the loop.
   - **Implementation audit, two layers.** Where the project carries a committed source graph, regenerate it first — `.ok-planner/bin/source-graph build` — so citations are judged against the tree as it stands; a non-zero `source-graph check` before the rebuild is expected when the change touched sources. **Mechanical layer:** run `.ok-planner/bin/audit-check repoint` (pure moves — a vanished identity whose recorded hash matches exactly one node in the fresh graph — are re-pointed in place, never re-audited), then `.ok-planner/bin/audit-check --list-stale` repo-wide (both are cheap and deterministic). **Judgment layer:** dispatch `{{CHANGE-INSPECTOR-PROMPT}}` from `../_shared/certification-core.md` with `[CHANGE SCOPE]` filled with this gate's subject; it records nominations as provisional entries in the inspection registry and dispositions every hunk into the reconciliation ledger. The **re-audit set** is the union of: the touched stories and decisions, every ref the checker lists (stale, missing — including audits *outside* the delta whose cited code or population sources this change happened to touch), and every audit the inspector nominated — and nothing else. Dispatch `{{IMPLEMENTATION-AUDITOR-PROMPT}}` from `../_shared/implementation-auditor.md` over that set, split by triage class per its own consumer rules — full-pass batches for refs whose artifact hash moved, which carry nominations, or which have no audit yet; sonnet refresh batches for citation-only staleness, with every `escalate:` line re-dispatched into a full-pass batch; the auditor adjudicates every open registry entry naming the refs it touches and reports per-artifact determinations with each ref's outcome (refreshed / rewritten). Every `violated` line is a finding for the loop, and `audit-check`'s own findings (malformed, orphaned, dangling links, graph-missing, graph-stale) are findings too. This producer's clean bar: `audit-check --inspection` exits 0 (citations current AND every changed node dispositioned — the mechanical evidence the judgment pass ran against the change as it stands), invoked as `--inspection=<base>` with the range's base ref where this run's subject is a commit range, so the floor judges the committed half of its own subject too; `source-graph check` exits 0 where a graph exists, no in-scope determination is `violated` without an issue link, no registry entry is left `open` for an audited ref, and no ledger hunk is without a disposition.
   - **The mechanical floor** (inline, no subagent): **annotation integrity** — `rg -n '@(concept|story|decision):\s*\S+'` over the changed files, every (kind, slug) pair resolving to a live artifact. Whether each touched story implemented in code is exercised end-to-end by tests is the auditor's coverage charter. Consistency of the changed corpus rides the alignment producer above; delta compliance was paid at `/plan-sprint` sign-off; all-pairs consistency and whole-corpus compliance are `/certify-all`'s job.
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
   belong to /certify-all.
   ```

   One scope rule for the fixer and architect: a fix may of course edit any file the correct fix requires, but findings stay change-scoped — the loop is not a license to re-audit the repository.

4. **Verify the promoted issues** — if the architect promoted any or the cap escalation filed any. Invoke `verify-issues`; it makes everything filed this run ruling-ready (and skips the already-verified intake). Zero filings → skip, silently.

5. **Present.** Compose and deliver `{{CERTIFY-PRESENTATION}}` from `../_shared/certification-core.md`. The per-producer "Findings fixed" lines for this gate: alignment (the corpus-change judge), the test suites, implementation audit (re-audit set, with flipped determinations, adjudication outcomes, and coverage findings counted), the mechanical floor, code review. The Reconciliation ledger section reports the final inspection's dispositions and enumerates the residue.

6. **Offer the close-out.** Run `{{CERTIFY-CLOSE-OUT}}` from `../_shared/certification-core.md`.

## When to reach for /certify-all instead

- Before a release, or after several sprints have closed through this gate.
- When the change touches the canonical rules the corpus checks enforce (e.g. `../_shared/artifact-definitions.md` in this repo's case) — a change-scoped check cannot see the corpus-wide fallout of a rule change.
- Whenever drift is suspected that no recent change explains.

## What this skill does NOT do

`{{CERTIFY-GATE-BOUNDARIES}}` from `../_shared/certification-core.md`, plus:

- Does not run `/ok-planner-audit` whole-corpus — that is `/certify-all`, on the owner's cadence, and this gate's presentation may recommend one when the corpus checks keep finding drift the change didn't cause.
- Does not widen scope mid-run. A finding outside the change's footprint that isn't caused or depended on by the change is not this gate's finding; if it matters, a human files it to the intake.

<!-- Materialized by ok-planner v13.0.0 — suite-owned; overwritten on converge; do not hand-edit. -->
