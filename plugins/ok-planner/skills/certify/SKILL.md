---
name: certify
description: "ONLY activated by explicit /certify slash command, or as the terminal step of a goal-driven implementation (e.g. fired by execute-sprint). Certifies a completed implementation: aligns it to its sprint, runs /prove and /audit and the review cycles, drives every fixable finding to clean through a no-discretion fix loop, presents outcomes and divergences to the user, and archives the sprint."
---

# Certify the Implementation

The "am I done?" gate for any user-initiated implementation goal. `certify` takes the just-completed work and certifies it: it brings the work into alignment with the sprint it was meant to realize, discharges the completion contract (`/prove` clean, `/audit` last), runs the code and design-doc review cycles, drives every fixable finding to zero through a fix loop that removes the orchestrator's discretion to defer, and presents the outcomes — and any divergences — to the user. If a sprint was in flight, certify archives it once the work certifies clean.

certify is the realization of the completion contract plus review and presentation. It is run at the end of every implementation goal — invoked by hand as `/certify`, or named as the terminal step of a goal-driven run (see `execute-sprint`).

## What certify orchestrates

Five workstreams feed one fix loop and one presentation:

1. **Sprint alignment** — did the work realize the sprint? (only when a sprint is in scope)
2. **`/prove`** — does every live story and decision have a passing, non-vacuous proof (falsifier exhibited)?
3. **`/audit`** — compliance, coverage-and-cardinality, intent-drift, cross-artifact consistency.
4. **Code review** — correctness, safety, state integrity, completeness-against-stories, undershoot.
5. **Design-doc compliance review** — the corpus artifacts touched, against the canonical rules.

Mechanical / auto-fixable findings from all five drain through the **fix loop** (below). Judgment findings are split out for the **presentation**, never auto-fixed.

## Process

1. **True up.** Invoke `ok-planner:true-up` so the layout and issue queue exist.

2. **Resolve scope.** The subject is the uncommitted working tree: run `git status` and `git diff` (and `--staged`) — new, modified, and deleted files are all in scope. If a sprint is named as an argument, that is the alignment target; else if exactly one sprint is in flight under `.ok-planner/sprints/`, use it; else there is no sprint and step 3 is skipped (a bare implementation goal certifies on prove + audit + review alone).

3. **Sprint alignment** (only with a sprint in scope). Read the sprint whole. Check two things, mechanically where possible:
   - **Every corpus delta is applied verbatim.** For each delta, the artifact under `design/` matches the delta's final-form body (or is deleted, for a retirement). A mismatch is a finding.
   - **Every work item's outcome is realized, not undershot.** For each work item, the story or decision it names is actually delivered — no stub, no-op, `TODO`, deferred handler, declared-but-unemitted error, or accepted-but-ignored flag standing in for the promised outcome. An undershoot is a **blocking** finding, routed to the fix loop; the corpus claiming more than the code delivers is exactly what `/prove` and `/audit` below will also catch, and all three must agree before certification.

4. **Run the completion-contract verbs.** Invoke `ok-planner:prove` then `ok-planner:audit`, whole-corpus.
   - `/prove` returns its structured report in-context. `missing` / `failing` / `vacuous` / `unrunnable` are findings for the fix loop; `uncertain` is surfaced in the presentation.
   - `/audit` fixes its own mechanical findings expectation onto the caller: its mechanical findings go to the fix loop, and it files its judgment findings to `issues.jsonl` itself. Re-run `/audit` after the fix loop until its mechanical section is empty.

5. **Run the two review cycles.** They are independent — findings do not mix, each drains through its own fix-loop pass, each loops to clean on its own.
   - **Code review** — dispatch the reviewer subagent (prompt below).
   - **Design-doc compliance** — dispatch the shared compliance reviewer from `skills/_shared/design-doc-compliance-reviewer.md` (`{{DESIGN-DOC-COMPLIANCE-REVIEWER-PROMPT}}`, `model: sonnet-5`), scoped to the artifacts the change touched (directly modified design files, plus artifacts whose slug is annotated in changed code). Skip this cycle silently if `.ok-planner/design/concepts/` does not exist.

6. **Drive the fix loop to clean** over all mechanical findings (alignment, prove, audit-mechanical, code-review, compliance). See **The fix loop** below. Judgment findings are never entered into it.

7. **Present** (see **The presentation**). Outcomes delivered, divergences, findings fixed, judgment issues filed, anything stuck at the cap.

8. **Archive.** If a sprint was in scope and everything certified clean, move the sprint to `.ok-planner/history/sprints/`. If findings remain at the cap, do NOT archive — report and stop; an uncertified sprint stays in flight.

## The fix loop

Ported from the discipline that a reviewer's findings must be driven to zero by a fixer, not triaged by the orchestrator. **The orchestrator has no discretion here.** It does not summarize, filter, reorder, or defer findings; it hands the raw finding list to a fixer subagent and loops.

1. Dispatch the **fixer subagent** (prompt below) with the producing check's full, verbatim finding list.
2. When the fixer reports done, **re-run the producing check** (the same reviewer prompt, or `/prove` / `/audit` for those sources) to verify.
3. Zero findings → that source is clean. New or remaining findings → back to step 1.
4. **Cap: 3 fix-review cycles per source.** If findings persist after three, stop looping that source and carry the remainder into the presentation for the user to direct — never silently accept or editorialize them away.

Judgment findings — anything needing the owner's calibration (audit's judgment class, a reviewer's "question/plausibly-intentional" finding, a `/prove` `uncertain`) — are **never** handed to the fixer. They go to the presentation (and, for audit, to `issues.jsonl`).

### Fixer subagent prompt

```
Agent (general-purpose):
  ## Fix Every Finding

  A review found the following findings. Fix ALL of them. Do not skip any.
  Do not assess priority. Do not defer. Do not mark any finding
  "acceptable", "cosmetic", "pre-existing", "out of scope", or "not
  blocking".

  If a finding is in code you didn't write, fix it anyway.
  If it predates the current work, fix it anyway.
  If it seems minor, fix it anyway.
  If fixing it requires reading more files, read them.
  If fixing it requires an architecture change, make it.

  ### Findings to fix

  [PASTE THE PRODUCING CHECK'S FULL OUTPUT — do not summarize or filter]

  ### Rules
  - Read files before editing.
  - Run the project's type checks and tests for whatever packages you
    modified; a fix that breaks the build is not done.
  - Never destroy uncommitted work: fix bad edits forward, never with
    git checkout/restore/reset/stash/clean. Do NOT commit.
  - "Low priority" is never a valid reason to skip. If genuinely
    blocked (a credential you lack), say so specifically — that is the
    only acceptable non-fix.

  ### Completion check
  Re-read the finding list and confirm every one has a corresponding
  fix and none were skipped or deferred. Report DONE with a numbered
  finding→fix map, or BLOCKED with the specific blocker and which
  findings it stops.
```

## Cycle 1 — Code review

Dispatch a reviewer subagent. The working tree is the subject.

```
Agent (general-purpose):
  ## Code Review

  ### Scope
  The uncommitted working-tree change. Run `git status` and `git diff`
  (and `--staged`) before forming findings; new and modified files are
  in scope, and code deleted in the working tree is gone — do not form
  findings about it. Read modified and new source files in full for
  context. If a submodule is modified, include its diff.

  ### Source of truth
  The sprint this work realizes (if one is in scope) — its
  deltas and work items — is what the work was meant to accomplish.
  Judge against it, not against the design corpus as an oracle. If the
  sprint has corpus deltas, open the affected files under
  `.ok-planner/design/` and verify each landed correctly — that is
  verifying directed work, not consulting the corpus as oracle.

  ### Review focus
  - Correctness: bugs, edge cases, off-by-one.
  - Safety: data loss, security, resource leaks, irreversible actions.
  - State integrity: stuck states, double-execution, skipped steps.
  - Load-bearing properties upheld: name the properties the sprint
    depends on — durability, completeness, atomicity, ordering,
    idempotency, no-data-loss, "this record is authoritative" — and
    verify the code still guarantees each, not only on the happy path.
    A property silently traded away for a local optimization is a
    finding even when nothing looks broken.
  - Completeness against the sprint's promised outcomes: every story
    or decision the sprint realizes must actually be delivered — its
    outcome observable, not merely its mechanism present. Flag any
    undershoot: a handler/route/class registered but doing nothing, an
    error class declared but never emitted, a flag accepted but
    ignored, a stub or no-op standing in for a promised outcome, a
    `TODO`/"out of scope"/"deferred" on a promised path. A promised
    outcome not really delivered is a blocking finding even when every
    test is green — that is how spec'd work ships unbuilt.
  - Test coverage: do tests verify real behavior? Gaps?
  - Dead code, unused imports, stale comments.
  - Pre-existing issues in any file you read — report them too, and
    follow the trail out of the initial scope if it leads somewhere.

  ### Output
  Every finding with: file:line, what's wrong, why it matters, how to
  fix. Do not grade by severity — every finding needs fixing. Split
  out separately any finding that is a genuine question for the owner
  (plausibly-intentional, a judgment call) under a `## Questions`
  heading — those are NOT auto-fixed.
```

The reviewer's fixable findings drain through the fix loop; its `## Questions` findings go to the presentation.

## The presentation

The strong closing step: the outcomes, and any divergences, put in front of the user. Compose it in full (it is a report, so it is delivered whole, not paced). Sections:

```
# Certification — <sprint name, or "implementation goal">

Status: certified clean | certified with open questions | NOT certified (findings at cap)

## Outcomes delivered
<Each story/decision the work realized, and the user-observable
outcome now true. For a bare goal with no sprint: what the goal
asked and what now holds.>

## Divergences
<Where the built work departed from the sprint, if anywhere: an
overshoot (unstated-but-necessary work built to make an outcome
hold), a forced shape-change, a delta applied differently than
written. "None" if the work matched the sprint. An undershoot must
never appear here — it was fixed, not reported.>

## Findings fixed
<Count and one-line summaries per source: alignment, prove, audit,
code review, compliance. "Clean on first pass" where nothing was
found.>

## Open questions filed
<Judgment findings surfaced for owner calibration: audit's judgment
class (filed to issues.jsonl — list ids), reviewer questions, prove
`uncertain`. These are the next sprint's business, not this run's.>

## Not certified
<Only if findings remained at the fix-loop cap: what remains, per
source, without editorializing. The sprint was NOT archived.>
```

## What this skill does NOT do

- Does not triage or defer findings. Fixable findings go to the fixer loop; the orchestrator holds no "acceptable" bucket.
- Does not auto-fix judgment findings. Owner-calibration findings are presented, never handed to the fixer.
- Does not archive an uncertified sprint. Findings at the cap leave the sprint in flight.
- Does not commit. Certification ends at a clean, presented working tree; committing is the user's call.
- Does not plan or build new scope. It certifies what the goal produced; a gap it cannot fix by driving findings to clean is surfaced, not filled with net-new work the sprint never promised.
