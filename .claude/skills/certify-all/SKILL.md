---
name: certify-all
description: "ONLY activated by explicit /certify-all slash command. Never auto-triggered by conversation content. The whole-corpus certification gate: runs /prove and /ok-planner-audit over the entire corpus plus the review cycles, drives every finding to fixed-or-promoted through the no-discretion review-fix loop (fixer, then an architect on kickbacks), presents outcomes and divergences to the user, then offers archival and commit as owner acts. Cost scales with the corpus, not the change — the everyday, change-scoped close is /certify-work."
---

# Certify Everything (the full gate)

The **whole-corpus** certification gate. Its cost scales with the size of the corpus, not the size of the change: `/prove` executes every live story proof, the implementation auditor re-derives every determination, `/ok-planner-audit` sweeps every artifact and every annotation. Run it periodically — after a run of sprints, before a release, whenever corpus-wide drift is suspected — not as the everyday close; the sprint boilerplate's terminal step is `/certify-work`, the change-scoped gate. Everything else about certification is identical between the two gates and defined once in `../_shared/certification-core.md`.

`certify-all` takes the just-completed work and certifies it: it brings the work into alignment with the sprint it was meant to realize, discharges the completion contract (`/prove` clean, `/ok-planner-audit` last), runs the code and design-doc reviewers as producers, drives every finding to fixed-or-promoted through a review-fix loop that removes the orchestrator's discretion to defer, and presents the outcomes — and any divergences — to the user. If a sprint was in flight, certify closes the presentation by offering to archive it and to commit the work — both owner acts, taken only on the owner's word. The sprint file stays at its `sprints/` path through the presentation, so a stop condition keyed to that path (a `/goal` on the sprint) can verify the finished work against it before anything moves: the goal is to finish the work; archival and commit come after.

certify-all is the realization of the completion contract plus review and presentation, at maximum scope. It is invoked by hand as `/certify-all`; sprints close through `/certify-work`.

## What certify orchestrates

Six workstreams feed one review-fix loop and one presentation:

1. **Sprint alignment** — did the work realize the sprint? (only when a sprint is in scope)
2. **`/prove`** — does every live story have a passing proof?
3. **`/ok-planner-audit`** — compliance, coverage, intent-drift, audit-corpus health, cross-artifact consistency, surface inventory.
4. **Implementation audit** — every live story and decision re-determined adversarially, the audit corpus rewritten fresh.
5. **Code review** — correctness, safety, state integrity, completeness-against-stories, undershoot.
6. **Design-doc compliance review** — the corpus artifacts touched, against the canonical rules.

All five are **producers** feeding the shared **review-fix loop** (`{{CERTIFY-REVIEW-FIX-LOOP}}` in `../_shared/certification-core.md`) — fixing is the overwhelming default; a fixer kickback that survives the architect's adversarial check is **promoted to the issue intake**, never put to the owner as a live question; before presenting, certify runs `/verify-issues` so everything promoted this run is ruling-ready. Both kinds are reported in the **presentation**, which is the run's only owner touchpoint (plus, on an interactive run only, the cap choice the loop defines).

## Process

1. **True up.** Invoke `true-up` so the layout and issue intake exist.

2. **Resolve scope.** The subject is the uncommitted working tree: run `git status` and `git diff` (and `--staged`) — new, modified, and deleted files are all in scope. If a sprint is named as an argument, that is the alignment target; else if exactly one sprint is in flight under `.ok-planner/sprints/`, use it; else there is no sprint and the alignment producer is skipped (a bare implementation goal certifies on prove + audit + review alone).

3. **The review-fix loop.** Run `{{CERTIFY-REVIEW-FIX-LOOP}}` from `../_shared/certification-core.md` — initial review by every producer, then fixer → architect → re-review cycles to clean or the cap. This gate's producers, each at full scope:

   - **Sprint alignment** (only with a sprint in scope). Read the sprint whole and check two things, mechanically where possible: every corpus delta applied verbatim (the artifact under `design/` matches the delta's final-form body, or is deleted for a retirement — a mismatch is a finding), and every work item's outcome realized, not undershot — no stub, no-op, `TODO`, deferred handler, declared-but-unemitted error, or accepted-but-ignored flag standing in for a promised outcome. An undershoot is a **blocking** finding; the corpus claiming more than the code delivers is exactly what `/prove` and `/ok-planner-audit` below also catch, and all three must agree before certification.
   - **Prove, whole-corpus.** Invoke `prove`. Its structured report returns in-context; every non-pass verdict — `missing` / `failing` / `unrunnable` — is a finding for the loop.
   - **Implementation audit, whole-corpus.** Dispatch `{{IMPLEMENTATION-AUDITOR-PROMPT}}` from `../_shared/implementation-auditor.md` over every live story and decision — the full gate re-derives every determination fresh, not just the stale ones. Every `violated` line is a finding for the loop, as is every `audit-check` finding. Clean bar: `.ok-planner/bin/ok-planner-audit-check` exits 0 and no determination is `violated` without an issue link.
   - **Audit, whole-corpus.** Invoke `ok-planner-audit`. It is a pure reporter: its findings — compliance, coverage-and-cardinality, intent-drift, annotation integrity, cross-artifact consistency, with `mechanical`/`judgment` classes as advisory context — all enter the loop; it files nothing.
   - **Code review, full scope** — dispatch the reviewer subagent (prompt below).
   - **Design-doc compliance** — dispatch the shared compliance reviewer from `../_shared/design-doc-compliance-reviewer.md` (`{{DESIGN-DOC-COMPLIANCE-REVIEWER-PROMPT}}`, `model: sonnet-5`), scoped to the artifacts the change touched (directly modified design files, plus artifacts whose slug is annotated in changed code). Skip this producer silently if `.ok-planner/design/concepts/` does not exist.

4. **Verify the promoted issues** — only if the architect promoted any. Invoke `verify-issues`; it makes everything promoted this run ruling-ready per its own process (closing what the corpus answers, narrating the rest to a ruling the owner accepts or overrides). Zero promotions → skip, silently.

5. **Present** (see **The presentation**). Outcomes delivered, divergences (fixer calls, corpus repairs, architect refutations), findings fixed, issues promoted (with their verification outcomes), anything stuck at the cap.

6. **Offer the close-out.** If a sprint was in scope and everything certified clean, end the presentation with the standing offer: archive the sprint (move it to `.ok-planner/history/sprints/`, and with it every issue file under `.ok-planner/issues/` whose frontmatter `sprint:` names this sprint — `status: promoted` receipts that move to `.ok-planner/history/issues/` when the implementation closes) and commit the work. Perform either only when the owner says so; never move the sprint or commit uninvited. On the owner's yes, after the archive commit lands, stamp the archived sprint with the closing commit — a YAML frontmatter block prepended at the very top of the file (`---`, `closed: <sha of the archive commit>`, `---`), or a `closed:` line added to its existing frontmatter — and make one small follow-on commit for the stamp. That stamp is the baseline `/plan-sprint`'s out-of-band reconciliation phase reads; a close without it leaves the next ceremony blind to what landed after this one. Leaving the sprint at its `sprints/` path until the owner accepts is what lets a `/goal` keyed to that path verify completion. If findings remain at the cap, make no offer — report and stop; an uncertified sprint stays in flight and its promoted issues stay put.

## The review-fix loop

Run `{{CERTIFY-REVIEW-FIX-LOOP}}` from `../_shared/certification-core.md`, dispatching `{{CERTIFY-FIXER-PROMPT}}` and `{{CERTIFY-ARCHITECT-PROMPT}}` from the same file. In this gate, the re-review step re-runs the whole-corpus producer exactly as first run (`/prove` and `/ok-planner-audit` whole-corpus, the reviewers at their full scope) — except the implementation audit, whose re-review scope is `audit-check --list-stale`: the initial pass re-derived everything, so only audits the fixes made stale need re-deriving.

## The code-review producer

Dispatch `{{CERTIFY-CODE-REVIEW-PROMPT}}` from `../_shared/certification-core.md` with `[REVIEW SCOPE]` filled as:

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

Compose and deliver `{{CERTIFY-PRESENTATION}}` from `../_shared/certification-core.md`. The per-producer "Findings fixed" lines for this gate are: alignment, prove, implementation audit, audit, code review, compliance.

## What this skill does NOT do

- Does not triage or defer findings. Every finding enters the review-fix loop; the orchestrator holds no "acceptable" bucket, and only the architect's confirmed forks reach the intake.
- Does not ask the owner questions mid-cycle. A genuine fork is promoted by the architect, made ruling-ready by `/verify-issues`, and listed in the presentation; every other finding is fixed. The one sanctioned mid-run touchpoint is the cap on an interactive run — more cycles, or proceed — and an unattended run never pauses even for that.
- Does not archive or commit on its own initiative. Certification ends at a clean, presented working tree with the sprint still at its `sprints/` path; the presentation closes by offering both, and only the owner's word triggers either. An uncertified sprint gets no offer at all.
- Does not plan or build new scope. It certifies what the goal produced; a gap it cannot fix by driving findings to clean is surfaced, not filled with net-new work the sprint never promised.

<!-- Materialized by ok-planner v10.0.0 — plugin-owned; overwritten by the true-up verb; do not hand-edit. -->
