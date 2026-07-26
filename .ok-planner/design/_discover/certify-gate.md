---
topic: certify-gate
kind: concept
---

# The certification gate (/certify) and the fix loop

## Description

`/certify` is "the 'am I done?' gate for any user-initiated implementation goal": it aligns the work to its sprint, discharges the completion contract, runs two review cycles, "drives every fixable finding to zero through a fix loop that removes the orchestrator's discretion to defer, and presents the outcomes — and any divergences — to the user," then archives the sprint once clean. Five workstreams feed one fix loop and one presentation: (1) **sprint alignment** — every corpus delta applied verbatim; every work item's outcome "realized, not undershot" (undershoot is a *blocking* finding: "no stub, no-op, `TODO`, deferred handler, declared-but-unemitted error, or accepted-but-ignored flag standing in for the promised outcome"); (2) `/prove`; (3) `/audit`; (4) **code review** (dispatched reviewer over the uncommitted working tree, judging "against the sprint, not against the design corpus as an oracle"); (5) **design-doc compliance review** (the shared reviewer, scoped to touched artifacts; skipped silently if no corpus exists). Scope resolution: sprint named as argument → that; else exactly one in-flight sprint → it; else no sprint, and "a bare implementation goal certifies on prove + audit + review alone."

**The fix loop** is the ported discipline "that a reviewer's findings must be driven to zero by a fixer, not triaged by the orchestrator. **The orchestrator has no discretion here.** It does not summarize, filter, reorder, or defer findings; it hands the raw finding list to a fixer subagent and loops." Loop: dispatch fixer with the verbatim finding list → re-run the producing check → zero findings = clean, else loop — **cap 3 cycles per source**; leftovers "carry ... into the presentation for the user to direct — never silently accept or editorialize them away." The fixer prompt forbids every deferral: "Do not skip any. Do not assess priority. ... If a finding is in code you didn't write, fix it anyway. If it predates the current work, fix it anyway. ... If fixing it requires an architecture change, make it." Where intent is open, the fixer resolves from sprint + corpus, else makes "the best engineering call and record[s] it — do not stop to ask."

**The judgment bar is high, and the owner is never asked live.** Fixable is "the overwhelming default"; a finding is judgment "only when it is really, truly unclear: the sprint and corpus are silent AND reasonable resolutions materially diverge on product intent." Judgment findings are "never handed to the fixer and never put to the owner as a mid-run question — file each to `issues.jsonl` ... and list the ids in the presentation. ... Certification never stalls on a question: by the time the presentation renders, every finding is fixed, filed, or stuck at the cap."

**The presentation** is the run's only owner touchpoint, "delivered whole, not paced": Status (certified clean | certified with issues filed | NOT certified), Outcomes delivered, Divergences (overshoots, forced shape-changes, "every call the fix loop made where the sprint and corpus were silent ... so the owner can veto it after the fact"; "An undershoot must never appear here — it was fixed, not reported"), Findings fixed, Issues filed, Not certified. NOT-do list: no triage bucket, no mid-run questions, no archiving uncertified sprints, **does not commit** ("Certification ends at a clean, presented working tree; committing is the user's call"), no net-new scope.

## Code surface

- `plugins/ok-planner/skills/certify/SKILL.md` (212 lines; fixer prompt; code-review prompt; presentation template).
- The same produce→review→fix loop shape (cap 3) in `discover-design` phases and plan-sprint §5 re-dispatch-until-clean.

## Prose surface

- Sprint boilerplate step 8; estate CLAUDE.md "`/certify` closes"; index skill certify row.

## Adjacent topics

- `completion-contract`, `sprint`, `prove-verb`, `audit-verb`, `issue-queue`, `ok-conduct` (completeness floor, presentation pacing carve-out), `execution-model`.

## Observations

- The newest commit (a01a3de "certify: fix by default, file only the truly unclear, never ask live") hardened the judgment bar; the index-skill row still says "Judgment findings are presented, never auto-fixed" — close but pre-hardening phrasing (presented vs filed-and-listed).
- Certify's code-review prompt instructs reviewers to report "pre-existing issues in any file you read — ... follow the trail out of the initial scope" while its fixer must fix them ("If it predates the current work, fix it anyway") — deliberate scope expansion inside a gate otherwise forbidden to add scope ("Does not plan or build new scope"). The boundary between "fixing found defects" and "net-new work" is carried by prose only.
- The compliance-reviewer dispatch names `model: sonnet-5` — one of two places a specific model is pinned in skill text (the other is audit's passes) despite the index skill's "Always use the most capable model available."
