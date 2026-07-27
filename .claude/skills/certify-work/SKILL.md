---
name: certify-work
description: "ONLY activated by explicit /certify-work slash command, or as the terminal step named in the sprint document's execution boilerplate. Never auto-triggered by conversation content. Change-scoped certification: certifies the work just done — the uncommitted tree by default, a commit range on request — running prove and the corpus checks over only what the change touched, the code review over the diff, a no-discretion review-fix loop (fixer, then an architect on kickbacks), and the presentation with archival/commit offered as owner acts. Whole-corpus certification is /certify-all."
---

# Certify the Work (the change-scoped gate)

The "am I done?" gate for an implementation goal, **scoped to the change**. Where `/certify-all` pays for the whole corpus on every run, certify-work's cost is proportional to the work being certified: it proves only the stories and decisions the change touched, checks only the artifacts and annotations the change reached, and reviews only the diff. This is the everyday close — the one the sprint boilerplate names — and it discharges the sprint's completion contract, which is itself stated in touched-scope terms. Corpus-wide drift that predates the change is `/certify-all`'s business (run it on a cadence), not every close's.

Everything that is not scope is shared verbatim with `/certify-all` and defined once in `../_shared/certification-core.md`: the review-fix loop and its veto test, the fixer and architect subagents, the code-review prompt, the presentation. The two gates differ only in what they look at.

## Scope

**Default — the uncommitted working tree.** `git status` and `git diff` (and `--staged`): new, modified, and deleted files, staged or not.

**On request — a commit range.** If the invocation carries an argument that parses as a git range or ref (`main..HEAD`, `v8.0.0..`, `abc123..def456`), the subject is that range's diff (`git diff <range>` + `git log <range>` for the story of the work) **plus** the uncommitted tree, so nothing in flight is skipped. Use this to certify work that was committed along the way.

**The touched set**, derived once and used by every stage below:

- **Changed files** — from the diff.
- **Touched artifacts** — design files changed directly, plus every `@concept:` / `@story:` / `@decision:` slug annotated in a changed file, plus every artifact a sprint-in-scope's deltas and work items name.
- **Touched stories and decisions** — the story/decision subset of the touched artifacts. This is the prove scope.

## Process

1. **True up.** Invoke `true-up` so the layout and issue intake exist.

2. **Resolve scope** per the Scope section: subject (tree or range+tree), then the touched set. If a sprint is named as an argument, that is the alignment target; else if exactly one sprint is in flight under `.ok-planner/sprints/`, use it; else there is no sprint and the alignment producer is skipped.

3. **The review-fix loop.** Run `{{CERTIFY-REVIEW-FIX-LOOP}}` from `../_shared/certification-core.md` — initial review by every producer, then fixer → architect → re-review cycles to clean or the cap. This gate's producers, each at change scope:

   - **Sprint alignment** (only with a sprint in scope). Read the sprint whole and check two things, mechanically where possible: every corpus delta applied verbatim (the artifact under `design/` matches the delta's final-form body, or is deleted for a retirement — a mismatch is a finding), and every work item's outcome realized, not undershot — no stub, no-op, `TODO`, deferred handler, declared-but-unemitted error, or accepted-but-ignored flag standing in for a promised outcome. An undershoot is a **blocking** finding.
   - **Prove, touched scope.** Invoke `prove` scoped to the touched stories and decisions (its caller-scoping is built in). Falsifier exhibition included — scoping changes which proofs run, never how honestly they run. Every non-pass verdict — `missing` / `failing` / `vacuous` / `unrunnable` / `uncertain` — is a finding for the loop (an `uncertain` proof's fix is restructuring it so its falsifier is safely exhibitable). If the touched set has no stories or decisions, this producer passes empty.
   - **Corpus checks** (this gate's replacement for whole-corpus `/ok-planner-audit`): **compliance** — the shared reviewer from `../_shared/design-doc-compliance-reviewer.md`, scoped to the touched artifacts (the same scoped mode `plan-sprint` uses at sign-off; skip silently if `.ok-planner/design/concepts/` does not exist or no artifact was touched); **annotation integrity** — `rg -n '@(concept|story|decision):\s*\S+'` over the changed files, every (kind, slug) pair resolving to a live artifact (inline, no subagent); **coverage** — each touched story/decision has at least one annotated proof artifact in code, and any population its `Proof:` field enumerates has every named member present; **scoped consistency** — one subagent (sonnet, carrying `{{LEAF-AGENT-RULE}}` from `../_shared/dispatch-discipline.md` and `{{MECHANICAL-VS-JUDGMENT-RULE}}` from `../_shared/artifact-definitions.md`) reading the touched artifacts in full plus the three catalog TOCs, flagging any contradiction between a touched artifact and another live artifact (reading the counterparty in full only when the catalogs suggest a collision), with the transcluded rule as advisory classification. All-pairs consistency across the untouched corpus is `/certify-all`'s job.
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

4. **Verify the promoted issues** — only if the architect promoted any. Invoke `verify-issues`; it makes everything promoted this run ruling-ready (and skips the already-verified intake). Zero promotions → skip, silently.

5. **Present.** Compose and deliver `{{CERTIFY-PRESENTATION}}` from `../_shared/certification-core.md`. The per-producer "Findings fixed" lines for this gate: alignment, prove (touched), corpus checks (change-scoped), code review.

6. **Offer the close-out.** If a sprint was in scope and everything certified clean, end the presentation with the standing offer: archive the sprint (move it to `.ok-planner/history/sprints/`, and with it every issue file under `.ok-planner/issues/` whose frontmatter `sprint:` names this sprint — `status: promoted` receipts that move to `.ok-planner/history/issues/` when the implementation closes) and commit the work. Perform either only when the owner says so; never move the sprint or commit uninvited. Leaving the sprint at its `sprints/` path until the owner accepts is what lets a `/goal` keyed to that path verify completion. If findings remain at the cap, make no offer — report and stop; an uncertified sprint stays in flight and its promoted issues stay put.

## When to reach for /certify-all instead

- Before a release, or after several sprints have closed through this gate.
- When the change touches the canonical rules the corpus checks enforce (e.g. `../_shared/artifact-definitions.md` in this repo's case) — a change-scoped check cannot see the corpus-wide fallout of a rule change.
- Whenever drift is suspected that no recent change explains.

## What this skill does NOT do

- Does not run whole-corpus `/prove` or `/ok-planner-audit` — that is `/certify-all`, on the owner's cadence, and this gate's presentation may recommend one when the corpus checks keep finding drift the change didn't cause.
- Does not widen scope mid-run. A finding outside the change's footprint that isn't caused or depended on by the change is not this gate's finding; if it matters, a human files it to the intake — it is not a fix to chase.
- Does not triage or defer findings. Every finding enters the review-fix loop; the orchestrator holds no "acceptable" bucket, and only the architect's confirmed forks reach the intake.
- Does not ask the owner questions mid-cycle. A genuine fork is promoted by the architect, made ruling-ready by `/verify-issues`, and listed in the presentation; every other finding is fixed. The one sanctioned mid-run touchpoint is the cap on an interactive run — more cycles, or proceed — and an unattended run never pauses even for that.
- Does not archive or commit on its own initiative. Certification ends at a clean, presented working tree with the sprint still at its `sprints/` path; the presentation closes by offering both, and only the owner's word triggers either. An uncertified sprint gets no offer at all.
- Does not plan or build new scope. It certifies what the goal produced; a gap it cannot fix by driving findings to clean is surfaced, not filled with net-new work the sprint never promised.

<!-- Materialized by ok-planner v10.0.0 — plugin-owned; overwritten by the true-up verb; do not hand-edit. -->
