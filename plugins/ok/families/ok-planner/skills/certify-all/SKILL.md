---
name: certify-all
description: "ONLY activated by explicit /certify-all slash command. Never auto-triggered by conversation content. The whole-corpus certification gate: runs the project's test suites and /audit over the entire corpus plus the review cycles, drives every finding to fixed-or-promoted through the no-discretion review-fix loop (fixer, then an architect on kickbacks), presents outcomes and divergences to the user, then offers archival and commit as owner acts. Cost scales with the corpus, not the change — the everyday, change-scoped close is /certify-work."
---

# Certify Everything (the full gate)

The **whole-corpus** certification gate: the project's test suites in full, the implementation auditor revisiting every determination, `/audit` sweeping every artifact — cost scales with the corpus, not the change. Run it on the owner's cadence — after a run of sprints, before a release, when corpus-wide drift is suspected — never as the everyday close; sprints close through `/certify-work`, the change-scoped gate. Everything that is not scope is shared with that gate and defined once in `skills/_shared/certification-core.md`.

## Process

1. **Ensure the layout.** Run `mkdir -p .ok-planner/issues .ok-planner/history/issues` — and, where `.ok-planner/design/` exists, `mkdir -p .ok-planner/audits/stories .ok-planner/audits/decisions .ok-planner/history/audits` — so the intake and the audit corpus buckets exist. Estate convergence is the front door's administration (`/ok`), not this gate's.

2. **Resolve scope.** The subject is the uncommitted working tree: run `git status` and `git diff` (and `--staged`) — new, modified, and deleted files are all in scope. If a sprint is named as an argument, that is the alignment target; else if exactly one sprint is in flight under `.ok-planner/sprints/`, use it; else there is no sprint and the alignment producer is skipped (a bare implementation goal certifies on tests + audit + review alone).

3. **The review-fix loop.** Run `{{CERTIFY-REVIEW-FIX-LOOP}}` from `skills/_shared/certification-core.md` — initial review by every producer, then fixer → architect → re-review cycles to clean or the cap. This gate's producers, each at full scope:

   - **Sprint alignment** (only with a sprint in scope) — the corpus-change judge. Dispatch `{{SPRINT-ALIGNMENT-PROMPT}}` from `skills/_shared/certification-core.md` with `[SPRINT PATH]` filled: deltas applied verbatim, every work item's outcome realized (an undershoot is a **blocking** finding), and the changed corpus coherent with the live corpus. The corpus claiming more than the code delivers is exactly what the test run and `/audit` below also catch, and all three must agree before certification.
   - **Test suites, in full.** Discover the run commands from the project's own docs (CLAUDE.md, README, Makefile, package manifest) — never invent an invocation — and run every suite. Every failure is a finding for the loop.
   - **Implementation audit, whole-corpus.** Where the project carries a committed source graph, regenerate it first (`.ok-planner/bin/source-graph build`) so citations are judged against the tree as it stands, then run `.ok-planner/bin/audit-check repoint` so pure moves — a vanished identity whose recorded hash matches exactly one node in the fresh graph — are re-pointed in place rather than entering the stale set. Dispatch `{{CHANGE-INSPECTOR-PROMPT}}` from `skills/_shared/certification-core.md` with `[CHANGE SCOPE]` filled with this gate's subject (the uncommitted working tree): even at full scope the inspector's job stands — its nominations land as provisional registry entries for the auditors to adjudicate, and its reconciliation ledger dispositions every hunk of the change in flight. Then dispatch `{{IMPLEMENTATION-AUDITOR-PROMPT}}` from `skills/_shared/implementation-auditor.md` over every live story and decision — the full gate's scope is coverage: every determination is revisited, not just the stale ones, but each ref still takes the triage's cheapest honest outcome (a standing audit whose artifact hash holds, whose claims nothing touched, and which carries no nomination is refreshed, never rewritten by reflex) — with every open registry entry adjudicated along the way. Split the dispatches by triage class per the auditor file's consumer rules: full-pass batches only where precedent lapsed, a nomination landed, or no audit exists; everything else rides in refresh batches, escalations re-dispatched. Every `violated` line is a finding for the loop, as is every `audit-check` finding (graph-missing and graph-stale included). Clean bar: `.ok-planner/bin/audit-check --inspection` exits 0 (citations current AND every changed node dispositioned — the mechanical evidence the judgment pass ran against the tree as it stands), `source-graph check` exits 0 where a graph exists, no determination is `violated` without an issue link, no registry entry is left `open`, and no ledger hunk is without a disposition.
   - **Audit, whole-corpus.** Invoke `ok-planner:audit`. It is a pure reporter: its findings — compliance, coverage-and-cardinality, intent-drift, annotation integrity, cross-artifact consistency, with `mechanical`/`judgment` classes as advisory context — all enter the loop; it files nothing.
   - **Code review, full scope** — dispatch the reviewer subagent (prompt below). It defends the code — quality, bugs, conventions; completeness against the sprint is alignment's charter, and corpus compliance rides `/audit` above at this gate's whole-corpus scope (no separate compliance dispatch).

4. **Verify the promoted issues** — if the architect promoted any or the cap escalation filed any. Invoke `ok-planner:verify-issues`; it makes everything filed this run ruling-ready per its own process (closing what the corpus answers, narrating the rest to a ruling the owner accepts or overrides). Zero filings → skip, silently.

5. **Present** (see **The presentation**). Outcomes delivered, divergences (fixer calls, corpus repairs, architect refutations), findings fixed, issues promoted (with their verification outcomes), including any remainders escalated at the cap.

6. **Offer the close-out.** Run `{{CERTIFY-CLOSE-OUT}}` from `skills/_shared/certification-core.md`.

## The review-fix loop

Run `{{CERTIFY-REVIEW-FIX-LOOP}}` from `skills/_shared/certification-core.md`, dispatching `{{CERTIFY-FIXER-PROMPT}}` and `{{CERTIFY-ARCHITECT-PROMPT}}` from the same file. In this gate, the re-review step re-runs the whole-corpus producer exactly as first run (the test suites and `/audit` whole-corpus, the reviewers at their full scope) — except the implementation audit, whose re-review scope is the two-layer union: regenerate the graph, run `audit-check repoint`, take `audit-check --list-stale` (the initial pass re-derived everything, so only audits the fixes made stale need re-deriving mechanically), and re-run the change inspector over the then-current diff for the nominations citations cannot see. Re-review dispatches split by triage class per the auditor file's consumer rules — full passes where precedent lapsed or a nomination landed, sonnet refresh batches for citation-only staleness, escalations re-dispatched — so a fix cycle pays full adversarial reads only where the fixes touched what a claim rests on.

## The code-review producer

Dispatch `{{CERTIFY-CODE-REVIEW-PROMPT}}` from `skills/_shared/certification-core.md` with `[REVIEW SCOPE]` filled as:

```
The uncommitted working-tree change. Run `git status` and `git diff`
(and `--staged`) before forming findings; new and modified files are
in scope, and code deleted in the working tree is gone — do not form
findings about it. Read modified and new source files in full for
context. If a submodule is modified, include its diff.

This is the full gate: pre-existing issues in any file you read are
in scope too — report them, and follow the trail out of the initial
scope if it leads somewhere.
```

## The presentation

Compose and deliver `{{CERTIFY-PRESENTATION}}` from `skills/_shared/certification-core.md`. The per-producer "Findings fixed" lines for this gate are: alignment, test suites, implementation audit (with adjudication outcomes counted), audit, code review, compliance. The Reconciliation ledger section reports the final inspection's dispositions and enumerates the residue.

## What this skill does NOT do

`{{CERTIFY-GATE-BOUNDARIES}}` from `skills/_shared/certification-core.md`.
