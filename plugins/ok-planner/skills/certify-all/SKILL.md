---
name: certify-all
description: "ONLY activated by explicit /certify-all slash command. The whole-corpus certification gate: runs /prove and /audit over the entire corpus plus the review cycles, drives every fixable finding to clean through a no-discretion fix loop, presents outcomes and divergences to the user, then offers archival and commit as owner acts. Cost scales with the corpus, not the change — the everyday, change-scoped close is /certify-work."
---

# Certify Everything (the full gate)

The **whole-corpus** certification gate. Its cost scales with the size of the corpus, not the size of the change: `/prove` executes and falsifier-exhibits every live proof, `/audit` sweeps every artifact and every annotation. Run it periodically — after a run of sprints, before a release, whenever corpus-wide drift is suspected — not as the everyday close; the sprint boilerplate's terminal step is `/certify-work`, the change-scoped gate. Everything else about certification is identical between the two gates and defined once in `skills/_shared/certification-core.md`.

`certify-all` takes the just-completed work and certifies it: it brings the work into alignment with the sprint it was meant to realize, discharges the completion contract (`/prove` clean, `/audit` last), runs the code and design-doc review cycles, drives every fixable finding to zero through a fix loop that removes the orchestrator's discretion to defer, and presents the outcomes — and any divergences — to the user. If a sprint was in flight, certify closes the presentation by offering to archive it and to commit the work — both owner acts, taken only on the owner's word. The sprint file stays at its `sprints/` path through the presentation, so a stop condition keyed to that path (a `/goal` on the sprint) can verify the finished work against it before anything moves: the goal is to finish the work; archival and commit come after.

certify-all is the realization of the completion contract plus review and presentation, at maximum scope. It is invoked by hand as `/certify-all`; sprints close through `/certify-work`.

## What certify orchestrates

Five workstreams feed one fix loop and one presentation:

1. **Sprint alignment** — did the work realize the sprint? (only when a sprint is in scope)
2. **`/prove`** — does every live story and decision have a passing, non-vacuous proof (falsifier exhibited)?
3. **`/audit`** — compliance, coverage-and-cardinality, intent-drift, cross-artifact consistency.
4. **Code review** — correctness, safety, state integrity, completeness-against-stories, undershoot.
5. **Design-doc compliance review** — the corpus artifacts touched, against the canonical rules.

Findings from all five drain through the **fix loop** (below) — fixing is the overwhelming default. The rare finding that is really, truly unclear is **filed to the issue intake**, never put to the owner as a live question; before presenting, certify runs `/verify-issues` so everything filed this run is ruling-ready. Both kinds are reported in the **presentation**, which is the run's only owner touchpoint.

## Process

1. **True up.** Invoke `ok-planner:true-up` so the layout and issue intake exist.

2. **Resolve scope.** The subject is the uncommitted working tree: run `git status` and `git diff` (and `--staged`) — new, modified, and deleted files are all in scope. If a sprint is named as an argument, that is the alignment target; else if exactly one sprint is in flight under `.ok-planner/sprints/`, use it; else there is no sprint and step 3 is skipped (a bare implementation goal certifies on prove + audit + review alone).

3. **Sprint alignment** (only with a sprint in scope). Read the sprint whole. Check two things, mechanically where possible:
   - **Every corpus delta is applied verbatim.** For each delta, the artifact under `design/` matches the delta's final-form body (or is deleted, for a retirement). A mismatch is a finding.
   - **Every work item's outcome is realized, not undershot.** For each work item, the story or decision it names is actually delivered — no stub, no-op, `TODO`, deferred handler, declared-but-unemitted error, or accepted-but-ignored flag standing in for the promised outcome. An undershoot is a **blocking** finding, routed to the fix loop; the corpus claiming more than the code delivers is exactly what `/prove` and `/audit` below will also catch, and all three must agree before certification.

4. **Run the completion-contract verbs.** Invoke `ok-planner:prove` then `ok-planner:audit`, whole-corpus.
   - `/prove` returns its structured report in-context. `missing` / `failing` / `vacuous` / `unrunnable` are findings for the fix loop; `uncertain` is filed to the issue intake (Candidates from the report) and listed in the presentation.
   - `/audit` fixes its own mechanical findings expectation onto the caller: its mechanical findings go to the fix loop, and it files its judgment findings to `.ok-planner/issues/` itself. Re-run `/audit` after the fix loop until its mechanical section is empty.

5. **Run the two review cycles.** They are independent — findings do not mix, each drains through its own fix-loop pass, each loops to clean on its own.
   - **Code review** — dispatch the reviewer subagent (prompt below).
   - **Design-doc compliance** — dispatch the shared compliance reviewer from `skills/_shared/design-doc-compliance-reviewer.md` (`{{DESIGN-DOC-COMPLIANCE-REVIEWER-PROMPT}}`, `model: sonnet-5`), scoped to the artifacts the change touched (directly modified design files, plus artifacts whose slug is annotated in changed code). Skip this cycle silently if `.ok-planner/design/concepts/` does not exist.

6. **Drive the fix loop to clean** over all fixable findings (alignment, prove, audit-mechanical, code-review, compliance). See **The fix loop** below — including its judgment bar: truly-unclear findings are filed to the issue intake, never entered into the loop and never asked live.

7. **Verify the filed issues** — only if this run filed any. Invoke `ok-planner:verify-issues`; it makes everything filed ruling-ready per its own process (closing what the corpus answers, narrating the rest to a ruling the owner accepts or overrides). Zero issues filed → skip, silently.

8. **Present** (see **The presentation**). Outcomes delivered, divergences (including any call the fix loop made where the sprint and corpus were silent), findings fixed, issues filed (with their verification outcomes), anything stuck at the cap.

9. **Offer the close-out.** If a sprint was in scope and everything certified clean, end the presentation with the standing offer: archive the sprint (move it to `.ok-planner/history/sprints/`, and with it every issue file under `.ok-planner/issues/` whose frontmatter `sprint:` names this sprint — `status: promoted` receipts that move to `.ok-planner/history/issues/` when the implementation closes) and commit the work. Perform either only when the owner says so; never move the sprint or commit uninvited. Leaving the sprint at its `sprints/` path until the owner accepts is what lets a `/goal` keyed to that path verify completion. If findings remain at the cap, make no offer — report and stop; an uncertified sprint stays in flight and its promoted issues stay put.

## The fix loop

Run `{{CERTIFY-FIX-LOOP}}` from `skills/_shared/certification-core.md`, dispatching `{{CERTIFY-FIXER-PROMPT}}` from the same file. In this gate, "re-run the producing check" means the whole-corpus check exactly as first run (`/prove` and `/audit` whole-corpus, the reviewers at their full scope).

## Cycle 1 — Code review

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

Compose and deliver `{{CERTIFY-PRESENTATION}}` from `skills/_shared/certification-core.md`. The per-source "Findings fixed" lines for this gate are: alignment, prove, audit, code review, compliance.

## What this skill does NOT do

- Does not triage or defer findings. Fixable findings go to the fixer loop; the orchestrator holds no "acceptable" bucket.
- Does not ask the owner questions mid-run. A really-truly-unclear finding is filed to the issue intake, made ruling-ready by `/verify-issues`, and listed in the presentation; every other finding is fixed. The presentation is the run's only owner touchpoint.
- Does not archive or commit on its own initiative. Certification ends at a clean, presented working tree with the sprint still at its `sprints/` path; the presentation closes by offering both, and only the owner's word triggers either. An uncertified sprint gets no offer at all.
- Does not plan or build new scope. It certifies what the goal produced; a gap it cannot fix by driving findings to clean is surfaced, not filled with net-new work the sprint never promised.
