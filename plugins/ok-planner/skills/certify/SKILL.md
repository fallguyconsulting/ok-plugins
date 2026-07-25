---
name: certify
description: "ONLY activated by explicit /certify slash command, or as the terminal step named in the sprint document's execution boilerplate. Certifies a completed implementation: aligns it to its sprint, runs /prove and /audit and the review cycles, drives every fixable finding to clean through a no-discretion fix loop, presents outcomes and divergences to the user, and archives the sprint."
---

# Certify the Implementation

The "am I done?" gate for any user-initiated implementation goal. `certify` takes the just-completed work and certifies it: it brings the work into alignment with the sprint it was meant to realize, discharges the completion contract (`/prove` clean, `/audit` last), runs the code and design-doc review cycles, drives every fixable finding to zero through a fix loop that removes the orchestrator's discretion to defer, and presents the outcomes — and any divergences — to the user. If a sprint was in flight, certify archives it once the work certifies clean.

certify is the realization of the completion contract plus review and presentation. It is run at the end of every implementation goal — invoked by hand as `/certify`, or named as the terminal step by the sprint document's own execution boilerplate (whether that sprint was picked up inline, handed to `/goal`, or run by an orchestrator).

## What certify orchestrates

Five workstreams feed one fix loop and one presentation:

1. **Sprint alignment** — did the work realize the sprint? (only when a sprint is in scope)
2. **`/prove`** — does every live story and decision have a passing, non-vacuous proof (falsifier exhibited)?
3. **`/audit`** — compliance, coverage-and-cardinality, intent-drift, cross-artifact consistency.
4. **Code review** — correctness, safety, state integrity, completeness-against-stories, undershoot.
5. **Design-doc compliance review** — the corpus artifacts touched, against the canonical rules.

Findings from all five drain through the **fix loop** (below) — fixing is the overwhelming default. The rare finding that is really, truly unclear is **filed to the issue queue**, never put to the owner as a live question; both kinds are reported in the **presentation**, which is the run's only owner touchpoint.

## Process

1. **True up.** Invoke `ok-planner:true-up` so the layout and issue queue exist.

2. **Resolve scope.** The subject is the uncommitted working tree: run `git status` and `git diff` (and `--staged`) — new, modified, and deleted files are all in scope. If a sprint is named as an argument, that is the alignment target; else if exactly one sprint is in flight under `.ok-planner/sprints/`, use it; else there is no sprint and step 3 is skipped (a bare implementation goal certifies on prove + audit + review alone).

3. **Sprint alignment** (only with a sprint in scope). Read the sprint whole. Check two things, mechanically where possible:
   - **Every corpus delta is applied verbatim.** For each delta, the artifact under `design/` matches the delta's final-form body (or is deleted, for a retirement). A mismatch is a finding.
   - **Every work item's outcome is realized, not undershot.** For each work item, the story or decision it names is actually delivered — no stub, no-op, `TODO`, deferred handler, declared-but-unemitted error, or accepted-but-ignored flag standing in for the promised outcome. An undershoot is a **blocking** finding, routed to the fix loop; the corpus claiming more than the code delivers is exactly what `/prove` and `/audit` below will also catch, and all three must agree before certification.

4. **Run the completion-contract verbs.** Invoke `ok-planner:prove` then `ok-planner:audit`, whole-corpus.
   - `/prove` returns its structured report in-context. `missing` / `failing` / `vacuous` / `unrunnable` are findings for the fix loop; `uncertain` is filed to `issues.jsonl` (candidates from the report) and listed in the presentation.
   - `/audit` fixes its own mechanical findings expectation onto the caller: its mechanical findings go to the fix loop, and it files its judgment findings to `issues.jsonl` itself. Re-run `/audit` after the fix loop until its mechanical section is empty.

5. **Run the two review cycles.** They are independent — findings do not mix, each drains through its own fix-loop pass, each loops to clean on its own.
   - **Code review** — dispatch the reviewer subagent (prompt below).
   - **Design-doc compliance** — dispatch the shared compliance reviewer from `skills/_shared/design-doc-compliance-reviewer.md` (`{{DESIGN-DOC-COMPLIANCE-REVIEWER-PROMPT}}`, `model: sonnet-5`), scoped to the artifacts the change touched (directly modified design files, plus artifacts whose slug is annotated in changed code). Skip this cycle silently if `.ok-planner/design/concepts/` does not exist.

6. **Drive the fix loop to clean** over all fixable findings (alignment, prove, audit-mechanical, code-review, compliance). See **The fix loop** below — including its judgment bar: truly-unclear findings are filed to `issues.jsonl`, never entered into the loop and never asked live.

7. **Present** (see **The presentation**). Outcomes delivered, divergences (including any call the fix loop made where the sprint and corpus were silent), findings fixed, issues filed, anything stuck at the cap.

8. **Archive.** If a sprint was in scope and everything certified clean, move the sprint to `.ok-planner/history/sprints/`. If findings remain at the cap, do NOT archive — report and stop; an uncertified sprint stays in flight.

## The fix loop

Ported from the discipline that a reviewer's findings must be driven to zero by a fixer, not triaged by the orchestrator. **The orchestrator has no discretion here.** It does not summarize, filter, reorder, or defer findings; it hands the raw finding list to a fixer subagent and loops.

1. Dispatch the **fixer subagent** (prompt below) with the producing check's full, verbatim finding list.
2. When the fixer reports done, **re-run the producing check** (the same reviewer prompt, or `/prove` / `/audit` for those sources) to verify.
3. Zero findings → that source is clean. New or remaining findings → back to step 1.
4. **Cap: 3 fix-review cycles per source.** If findings persist after three, stop looping that source and carry the remainder into the presentation for the user to direct — never silently accept or editorialize them away.

**The judgment bar is high, and the owner is never asked live.** A finding is *fixable* — the overwhelming default — when its correct end state is determined by the sprint, the corpus, or ordinary engineering judgment grounded in them. The fixer fixes it; any call it made beyond what those sources spell out is recorded and surfaced in the presentation's Divergences for after-the-fact veto. A finding is *judgment* only when it is really, truly unclear: the sprint and corpus are silent AND reasonable resolutions materially diverge on product intent. Judgment findings are never handed to the fixer and never put to the owner as a mid-run question — file each to `issues.jsonl` per `{{ISSUE-QUEUE-FORMAT}}` in `skills/_shared/artifact-definitions.md` (kind `audit`, category from the finding's nature, candidates from the finding) and list the ids in the presentation. `/audit` files its own; this skill files the truly-unclear remainder from alignment, prove (`uncertain`), code review, and compliance. Certification never stalls on a question: by the time the presentation renders, every finding is fixed, filed, or stuck at the cap.

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
  If the right fix depends on intent the finding leaves open, resolve
  it from the sprint and the design corpus under `.ok-planner/design/`;
  where they are silent, make the best engineering call and record it —
  do not stop to ask. Only a finding that is really, truly unclear —
  sprint and corpus silent AND reasonable fixes materially diverging on
  product intent — may come back unfixed: mark it UNCLEAR with the
  diverging options stated.

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
  finding→fix map, a CALLS MADE list (every call you made beyond what
  the sprint/corpus spell out, one line each — empty if none), and any
  UNCLEAR items with their diverging options; or BLOCKED with the
  specific blocker and which findings it stops.
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
  fix. Do not grade by severity — every finding needs fixing.
  Reserve a `## Unclear` heading for the rare finding that is really,
  truly unclear: the sprint and design corpus do not determine the
  fix AND reasonable resolutions materially diverge on product
  intent. State each with its diverging resolution candidates.
  "Plausibly intentional" is not the bar — if one resolution is
  clearly better engineering, it is an ordinary finding to fix.
```

The reviewer's findings drain through the fix loop. Its `## Unclear` entries are filed to `issues.jsonl` by this skill (candidates from the entry) and listed in the presentation — never put to the owner as live questions.

## The presentation

The strong closing step: the outcomes, and any divergences, put in front of the user. Compose it in full (it is a report, so it is delivered whole, not paced). Sections:

```
# Certification — <sprint name, or "implementation goal">

Status: certified clean | certified with issues filed | NOT certified (findings at cap)

## Outcomes delivered
<Each story/decision the work realized, and the user-observable
outcome now true. For a bare goal with no sprint: what the goal
asked and what now holds.>

## Divergences
<Where the built work departed from the sprint, if anywhere: an
overshoot (unstated-but-necessary work built to make an outcome
hold), a forced shape-change, a delta applied differently than
written — plus every call the fix loop made where the sprint and
corpus were silent, each named so the owner can veto it after the
fact. "None" if the work matched the sprint and no calls were made.
An undershoot must never appear here — it was fixed, not reported.>

## Findings fixed
<Count and one-line summaries per source: alignment, prove, audit,
code review, compliance. "Clean on first pass" where nothing was
found.>

## Issues filed
<Every judgment finding filed to issues.jsonl this run — audit's own
filings plus the truly-unclear findings this skill filed from
alignment, prove (`uncertain`), code review, and compliance — listed
by id. These are the next sprint's business, not this run's. Nothing
in this section was asked live; nothing exists only in this report.>

## Not certified
<Only if findings remained at the fix-loop cap: what remains, per
source, without editorializing. The sprint was NOT archived.>
```

## What this skill does NOT do

- Does not triage or defer findings. Fixable findings go to the fixer loop; the orchestrator holds no "acceptable" bucket.
- Does not ask the owner questions mid-run. A really-truly-unclear finding is filed to `issues.jsonl` and listed in the presentation; every other finding is fixed. The presentation is the run's only owner touchpoint.
- Does not archive an uncertified sprint. Findings at the cap leave the sprint in flight.
- Does not commit. Certification ends at a clean, presented working tree; committing is the user's call.
- Does not plan or build new scope. It certifies what the goal produced; a gap it cannot fix by driving findings to clean is surfaced, not filled with net-new work the sprint never promised.
