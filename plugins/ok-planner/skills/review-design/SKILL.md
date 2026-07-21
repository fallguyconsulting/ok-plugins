---
name: review-design
description: "ONLY activated by explicit /review-design slash command. Never auto-triggered by conversation content."
---

# Review the design corpus

Whole-corpus audit of the project's durable design docs under `.ok-planner/design/`, in two passes:

1. **Compliance pass** — every live concept, story, decision, and tension is checked against the canonical artifact rules (self-containment, tension surface, current-state-only — canonically stated in `skills/_shared/artifact-definitions.md`).
2. **Coverage + intent-drift pass** — every live story is checked for proof coverage (at least one `@story:<slug>`-annotated file in the codebase) and intent drift (proof artifacts no longer satisfying their story's `Proof:` field). Dangling and kind-mismatched annotations (`@concept:<slug>` / `@story:<slug>` / `@decision:<slug>` pointing at retired, missing, or wrong-kinded artifacts) are also surfaced.

Findings from both passes drive a `review-cleanup` fix loop to clean.

For other review types, see: `/review-work` (uncommitted changes — also runs a focused cycle 2 against design docs at change points), `/review-plan`, `/review-commits`, `/review-files`, `/review-feature`, `/review-holistic`.

## Why this exists, vs. `review-work` cycle 2

`review-work` cycle 2 audits the design corpus at change points only — artifacts directly modified by the current uncommitted change, plus artifacts referenced by slug from changed code or an in-flight spec/plan. That's cheap on every run and catches the drift that change events introduce.

It does not catch **accumulated drift in untouched files** — violations that crept in through earlier runs that were less strict, or rule tightenings that have since landed in the canonical text. That category needs an explicit whole-corpus sweep.

`review-design` is that sweep. Invoke it when:
- A rule tightening has just landed in `skills/_shared/artifact-definitions.md` and the corpus needs re-checking against the new wording.
- A `/discover-design` re-run has updated the artifact catalog and you want to confirm the whole tree complies with current rules.
- The project has been quiet for a while and you want to confirm nothing has decayed.
- A `review-work` cycle 2 result is suspect and you want the broader signal.
- The user simply wants to know.

## Process

1. Run `ok-planner:affirm` so the layout exists.
2. Verify `.ok-planner/design/concepts/` exists. If not, tell the user to run `/discover-design` first and stop.

3. **Pass 1 — compliance.** Dispatch the compliance reviewer with whole-corpus scope. Read `skills/_shared/design-doc-compliance-reviewer.md` and dispatch the `{{DESIGN-DOC-COMPLIANCE-REVIEWER-PROMPT}}` block as a subagent. Substitute `[AUDIT SCOPE]` with:

   ```
   Audit every live artifact file in the project's design corpus:

   - All `.md` files directly under `.ok-planner/design/concepts/` (skip `_retired/`)
   - All `.md` files directly under `.ok-planner/design/stories/`
   - All `.md` files directly under `.ok-planner/design/decisions/`
   - All `.md` files directly under `.ok-planner/design/tensions/` (skip `_resolved/` and `_rejected/`)
   - `.ok-planner/design/concepts.md`, `stories.md`, and `decisions.md` (the auto-generated TOCs)
   ```

   The reviewer prompt body is invariant between this skill and `review-work` cycle 2; only the scope above differs.

4. **Pass 2 — coverage + intent-drift.** Dispatch a separate reviewer for the proof-coverage audit:

   ```
   Agent (general-purpose):
     ## Proof coverage + intent-drift audit

     ### Your job

     Audit the project for proof coverage of every live story
     and for intent drift in existing proofs, per the canonical
     `{{PROOF-PROTECTION-RULE}}` in
     `skills/_shared/artifact-definitions.md` (read it before
     starting). Findings will go to a fix cycle.

     ### Coverage check (cheap, mechanical)

     For every `.md` file directly under
     `.ok-planner/design/stories/` (live stories only), read
     the story's slug. Run `rg -n '@story:\s*<slug>'` across
     the codebase (excluding `.ok-planner/`, `.git/`, build
     outputs, vendored dependencies).

     - If zero matches: **coverage gap**. The story has no
       proof artifact. Either the proof was removed, never
       created, or its annotation drifted. Record the story
       slug, the story's `Proof:` field text (so the fixer
       knows what to restore), and the recommendation:
       restore a proof artifact, or open a brainstorm to
       deprecate the story.
     - If one or more matches: list the matching files. The
       intent-drift pass below judges whether each one still
       satisfies the story's Proof field.

     ### Intent-drift check (judgment)

     For every `@story:<slug>`-annotated file found in the
     coverage check: read the file in full, then read the
     matching story's `Proof:` field (and Acceptance /
     Falsifier for context). Judge whether the proof file
     still satisfies the story's Proof field.

     - **satisfies** — the proof, as currently written, exhibits
       what the Proof field describes. No finding.
     - **does not satisfy** — the proof has drifted; it no longer
       exhibits what the Proof field describes (different
       outcome, weaker assertion, stubbed value-delivering
       component, etc.). Record the proof file path, what the
       Proof field requires, what the proof actually exhibits,
       and the recommendation: update the proof (if intent is
       still valid) or open a brainstorm to mutate the story's
       Proof field (if the intent has genuinely shifted).
     - **uncertain** — the judgment is not clear from reading
       both. Record as a finding for human adjudication.

     ### Annotation integrity (mechanical)

     `rg -n '@(concept|story|decision):\s*\S+'` across the
     codebase. For each match, parse (kind, slug) and confirm
     `.ok-planner/design/<kind>s/<slug>.md` exists (skipping
     `_retired/`). The rule (symmetric across the three kinds)
     lives in `skills/_shared/artifact-definitions.md` under
     {{ANNOTATION-INTEGRITY-RULE}}.

     - **Dangling annotation (slug-dangling)** — slug does not
       resolve under any of the three design directories. Record
       the annotation site (file:line), the unresolved (kind,
       slug) pair, and the recommendation: repoint to the live
       canonical slug if the artifact was renamed, or remove the
       annotation if the artifact was retired.
     - **Dangling annotation (kind-mismatch)** — slug exists, but
       at a different kind than the annotation claims (e.g.
       `@concept:foo` but only `stories/foo.md` exists). Record
       the annotation site, the offending (kind, slug) pair, and
       the correct kind. Recommendation: rename the annotation
       prefix to match the artifact's actual kind.

     ### Output format

     ```
     Status: Approved | Issues Found

     ## Findings

     (if Issues Found, one entry per finding:)

     ### Coverage gap: STORY-<slug>
     Story Proof field: <quoted>
     Recommendation: <restore | deprecate>

     ### Intent drift: <proof file path>
     Story: STORY-<slug>
     Proof field requires: <quoted>
     Proof actually exhibits: <one or two lines>
     Recommendation: <update proof | mutate story>

     ### Dangling annotation: <file>:<line>
     Unresolved slug: <slug>
     Recommendation: <repoint to <successor> | remove>
     ```

     ### Anti-padding

     - Do not flag proofs that satisfy their story's Proof
       field. Only surface drift / gaps / dangling.
     - Do not grade severity; every finding is in scope.
     - Do not propose new stories or new TDs; this audit is
       coverage-only, not discovery.
   ```

5. **If either pass found issues**, invoke `ok-planner:review-cleanup` with the combined output (compliance findings + coverage findings, grouped by source). Pass through verbatim — do NOT process, filter, or triage. Let cleanup drive the fix cycle.

6. **Once `review-cleanup` reports clean (or hits its cap)**, report the audit clean (or surface remaining issues — the user decides what to do).

## What this skill does NOT do

- Does not audit code. Use `review-work` / `review-commits` / `review-files` for code review.
- Does not audit specs, plans, or sketches. Those are not under `.ok-planner/design/`. The artifact rules apply only to durable design docs.
- Does not modify the design corpus directly. The reviewer dispatches findings; `review-cleanup` drives the fixer. Same separation as the cycles in `review-work`.
- Does not re-run discovery. If the corpus has gaps (concepts missing, stories undocumented), run `/discover-design` or `/refine-design`. This skill audits what's there; it doesn't add what isn't.
