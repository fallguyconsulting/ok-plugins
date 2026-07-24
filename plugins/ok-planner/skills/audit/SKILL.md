---
name: audit
description: "ONLY activated by explicit /audit slash command or by whoever is executing a sprint's completion contract — an inline session or an orchestrator. Never auto-triggered by conversation content."
---

# Audit the Design Corpus

Whole-corpus audit of the project's durable design docs under `.ok-planner/design/`, producing work items for a **human**: its judgment findings are appended to `.ok-planner/issues.jsonl`, the intake queue the next `/plan-sprint` draws from. Mechanical findings are reported to the caller for in-cycle fixing.

This is ok-planner's `audit` verb in the ok-plugins integration contract: read-only against the corpus and the code — its only write is appending `open` rows to the intake queue, which is its output channel. It is invoked by whoever executes a sprint — an inline session or an orchestrated worker; every sprint's completion contract ends with it — and by humans ad hoc.

## Process

1. Run `ok-planner:true-up` so the layout and intake queue exist.
2. Verify `.ok-planner/design/concepts/` exists. If not, tell the caller to run `/discover-design` first and stop.

3. **Pass 1 — compliance.** Read `skills/_shared/design-doc-compliance-reviewer.md` and dispatch the `{{DESIGN-DOC-COMPLIANCE-REVIEWER-PROMPT}}` block as a subagent in whole-corpus mode (the scope block is given verbatim in that file). The reviewer classifies each finding `mechanical` or `judgment`.

4. **Pass 2 — coverage + intent-drift + annotation integrity.** Dispatch a second subagent:

   ```
   Agent (general-purpose, model: sonnet-5):
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

     Coverage is presence *and cardinality* — one annotation is not
     proof the whole claim is realized. If the artifact's `Proof:`
     or `Falsifier` names a population it ranges over ("every
     implementation", "all handlers", an enumerated set `{A, B}`),
     each named member must itself resolve to an annotated artifact
     in code. A member the corpus names but the code lacks is a
     **coverage gap** — class `judgment`, category `proof`: `/prove`
     passes vacuously over only the members that exist, so a decision
     asserting two implementations goes green against one. Record the
     missing member and the artifact's claim. This is the check that
     catches a corpus claim that outran the code.

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

     Also flag, class `judgment`, category `proof`, a proof that
     cannot be mechanically distinguished from vacuous — because
     `/audit` reads and cannot exhibit, this is where a foolable
     `Proof:` field is caught structurally rather than by opinion:
     a `Proof:` field that quantifies over a population ("every /
     all / each …") without the artifact enumerating that population
     (so "every" collapses silently to "one"), or a proof for which
     no falsifying mutation can be named (nothing you could change
     would redden it). Candidate: enumerate the population (or state
     a minimum cardinality) / state an exhibitable falsifier in the
     artifact, so `/prove` can exhibit it rather than read it.

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

5. **Pass 3 — cross-artifact consistency.** Dispatch a third subagent. This is the pass no per-artifact check can perform: a contradiction between two artifacts is invisible to a check that reads each one alone, so a decision that mandates a mechanism another decision forbids passes coverage, drift, and compliance while the corpus quietly disagrees with itself.

   ```
   Agent (general-purpose, model: sonnet-5):
     ## Cross-artifact consistency audit

     ### Your job

     Find pairs (or small groups) of live design artifacts under
     `.ok-planner/design/` that contradict each other. Each artifact
     may be internally valid; the finding is the *conflict between*
     them. You resolve nothing — you surface the contradiction for
     the owner.

     ### What counts as a conflict

     - Two decisions that mandate incompatible mechanisms for the
       same concern — e.g. one decision requires a component the
       deployment another decision mandates cannot run.
     - A decision whose Choice negates another decision's Choice.
     - An invariant one concept states that another artifact's body
       contradicts.
     - A decision or concept that forecloses a user-outcome a story's
       Acceptance or Falsifier promises.
     - A `Proof:` field whose stated check would fail against another
       live artifact's mandated state.

     ### How to work

     Read every live concept, story, and decision (skip `_retired/`).
     For each, note what it *requires* and what it *forbids*. Then
     look for a second artifact whose requirement collides with the
     first's — the collision is the finding. Read the code where
     deciding whether two claims actually collide depends on what the
     code does.

     ### Output format

     Status line first: `Status: Consistent | Conflicts Found`.
     Then one entry per conflicting pair/group: the artifact slugs,
     the specific claim in each that collides, and why they cannot
     both hold. Class every finding `judgment`, category
     `conflicting` — only the owner resolves a contradiction.

     ### Anti-padding

     - A conflict is a genuine contradiction, not a tension or a
       neighbor-boundary blur (that is `muddy-boundary`, and only
       when real). Two artifacts on the same topic conflict only if
       both cannot hold.
     - Don't grade severity. Don't propose the resolution.
     - Report only contradictions between live artifacts.
   ```

6. **File judgment findings.** Fold `.ok-planner/issues.jsonl` first (collect open ids — an `open` row with no later `promote` / `retire` / legacy `resolve` row). For each `judgment` finding from any pass whose fingerprint id is not already open, append an `open` row per `{{ISSUE-QUEUE-FORMAT}}` — `kind: "audit"`, category from the finding's nature (`proof` for pass-2 proof findings, `conflicting` for pass-3 consistency findings), `candidates` from the finding, timestamp via `date -u +%Y-%m-%dT%H:%M:%SZ`. Append with `>>` via Bash so the write is durable even if the session dies after. Never edit or remove existing rows.

7. **Report to the caller** — machine-readable, in-context:

   ```
   Status: clean | mechanical-findings | filed-issues | both

   ## Mechanical findings (fix in-cycle, then re-run /audit)
   <the full mechanical finding entries, verbatim>

   ## Issues filed
   <id — summary, one line each; or "none">
   ```

   The caller (worker or human) fixes the mechanical findings and re-runs `/audit` until the mechanical section is empty. Filed issues are not the caller's to fix — they wait for `/plan-sprint`.

## What this skill does NOT do

- Does not audit code quality. It audits the corpus and the code↔corpus links only.
- Does not read `.ok-planner/sprints/` or `.ok-planner/history/` — project records are out of context; consult them only when the human explicitly directs it.
- Does not fix anything — not even mechanical findings. The caller fixes; the audit re-verifies. (Its issue-queue append is reporting, not fixing.)
- Does not execute proofs — that's `/prove`. The intent-drift check reads; it never runs.
- Does not close, edit, or dedup-rewrite issue rows. Append-only, `open` events only.
