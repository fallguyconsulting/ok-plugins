---
name: audit
description: "ONLY activated by explicit /audit slash command or by whoever is executing a sprint backlog's completion contract — an inline session or an orchestrator. Never auto-triggered by conversation content."
---

# Audit the Design Corpus

Whole-corpus audit of the project's durable design docs under `.ok-planner/design/`, producing work items for a **human**: its judgment findings are appended to `.ok-planner/issues.jsonl`, the intake queue the next `/sprint` draws from. Mechanical findings are reported to the caller for in-cycle fixing.

This is ok-planner's `audit` verb in the ok-plugins integration contract: read-only against the corpus and the code — its only write is appending `open` rows to the intake queue, which is its output channel. It is invoked by whoever executes a sprint backlog — an inline session or an orchestrated worker; every backlog's completion contract ends with it — and by humans ad hoc.

## Process

1. Run `ok-planner:true-up` so the layout and intake queue exist.
2. Verify `.ok-planner/design/concepts/` exists. If not, tell the caller to run `/discover-design` first and stop.

3. **Pass 1 — compliance.** Read `skills/_shared/design-doc-compliance-reviewer.md` and dispatch the `{{DESIGN-DOC-COMPLIANCE-REVIEWER-PROMPT}}` block as a subagent in whole-corpus mode (the scope block is given verbatim in that file). The reviewer classifies each finding `mechanical` or `judgment`.

4. **Pass 2 — coverage + intent-drift + annotation integrity.** Dispatch a second subagent:

   ```
   Agent (general-purpose):
     ## Proof coverage + intent-drift audit

     ### Your job

     Audit the project for proof coverage of every live story AND
     every live decision, and for intent drift in existing proofs,
     per the canonical {{PROOF-PROTECTION-RULE}} and
     {{ANNOTATION-INTEGRITY-RULE}} in
     `skills/_shared/artifact-definitions.md` (transcluded below).
     Classify each finding `mechanical` or `judgment`.

     {{PROOF-PROTECTION-RULE}}

     {{ANNOTATION-INTEGRITY-RULE}}

     ### Coverage check (cheap, mechanical to detect; judgment to resolve)

     For every `.md` file directly under `.ok-planner/design/stories/`
     and `.ok-planner/design/decisions/` (live artifacts only), read
     the slug. Run `rg -n '@story:\s*<slug>'` (or `@decision:`) across
     the codebase (excluding `.ok-planner/`, `.git/`, build outputs,
     vendored dependencies).

     - Zero matches: **coverage gap** — class `judgment` (only the
       owner can decide restore-vs-deprecate). Record the slug, the
       artifact's `Proof:` field text, and both candidates.
     - One or more matches: list the files for the drift check.

     ### Intent-drift check (judgment)

     For every annotated proof file found: read it in full, then read
     the matching artifact's `Proof:` field (and Acceptance /
     Falsifier or Choice for context). Verdict:

     - **satisfies** — no finding.
     - **does not satisfy** — class `judgment`: record the proof path,
       what the Proof field requires, what the proof actually
       exhibits, and the candidates (update the proof to restore
       intent | mutate the artifact's Proof field at next sprint).
     - **uncertain** — class `judgment`, for human adjudication.

     ### Annotation integrity (mechanical)

     `rg -n '@(concept|story|decision):\s*\S+'` across the codebase.
     Every (kind, slug) pair must resolve to
     `.ok-planner/design/<kind>s/<slug>.md` (skipping `_retired/`).
     Dangling and kind-mismatched annotations are class `mechanical`
     when the fix is evident (repoint to the renamed slug / correct
     the kind prefix / remove for a retired artifact); `judgment`
     only if which artifact was meant is genuinely undecidable.

     ### Output format

     One entry per finding: heading, class, evidence, and for
     judgment findings the candidates. Status line first:
     `Status: Approved | Issues Found`.

     ### Anti-padding

     - Don't flag proofs that satisfy their Proof field.
     - Don't grade severity.
     - Don't propose new stories or decisions; this audit is
       coverage-only, not discovery.
   ```

5. **File judgment findings.** Fold `.ok-planner/issues.jsonl` first (collect open ids — an `open` row with no later `promote` / `retire` / legacy `resolve` row). For each `judgment` finding from either pass whose fingerprint id is not already open, append an `open` row per `{{ISSUE-QUEUE-FORMAT}}` — `kind: "audit"`, category from the finding's nature (`proof` for pass-2 findings), `candidates` from the finding, timestamp via `date -u +%Y-%m-%dT%H:%M:%SZ`. Append with `>>` via Bash so the write is durable even if the session dies after. Never edit or remove existing rows.

6. **Report to the caller** — machine-readable, in-context:

   ```
   Status: clean | mechanical-findings | filed-issues | both

   ## Mechanical findings (fix in-cycle, then re-run /audit)
   <the full mechanical finding entries, verbatim>

   ## Issues filed
   <id — summary, one line each; or "none">
   ```

   The caller (worker or human) fixes the mechanical findings and re-runs `/audit` until the mechanical section is empty. Filed issues are not the caller's to fix — they wait for `/sprint`.

## What this skill does NOT do

- Does not audit code quality. It audits the corpus and the code↔corpus links only.
- Does not read `.ok-planner/backlogs/` or `.ok-planner/history/` — project records are out of context; consult them only when the human explicitly directs it.
- Does not fix anything — not even mechanical findings. The caller fixes; the audit re-verifies. (Its issue-queue append is reporting, not fixing.)
- Does not execute proofs — that's `/prove`. The intent-drift check reads; it never runs.
- Does not close, edit, or dedup-rewrite issue rows. Append-only, `open` events only.
