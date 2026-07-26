---
issue: workspaces-audit-story-home
kind: discover
category: other
artifacts:
  - story:isolated-parallel-workspaces
  - story:rules-compliance-report
status: verified
opened: 2026-07-25T02:26:48Z
---

# Decide which story owns the workspace-discipline audit outcome

## Problem

story:isolated-parallel-workspaces carries an acceptance clause for the read-only discipline audit (naming nonconformance, identity-pinning runtime files, mutable tags in verification paths) that its own falsifier never covers, while story:rules-compliance-report claims the read-only drift report for every rules-bearing plugin — one user-observable outcome claimed from two stories.

## Candidates

- Move the audit clause wholly into story:rules-compliance-report and drop it from the isolation story
- Keep the clause in the isolation story and scope rules-compliance-report explicitly to the plugins not otherwise covered

## Discussion

**The question.** ok-workspaces' read-only discipline audit is claimed by two stories' Acceptance sections at once, but only one of them (`corpus-audit`'s sibling, `rules-compliance-report`) has a Falsifier that actually covers it. Which story should own this user-observable outcome?

**Re-verified, both claims as currently written.** `story:isolated-parallel-workspaces`'s Acceptance ends: "A read-only audit verb separately reports discipline residue — naming nonconformance, identity-pinning runtime files, mutable tags in verification paths — for the owner to direct." Its Falsifier, however, only covers workspace *opening* mechanics: "Two concurrent jobs share a tree, container namespace, or port; an existing workspace is clobbered or reused; job work lands on the main checkout; or a second workspace cannot start without editing the first." Nothing there would fire if the audit clause silently regressed — an audit that stopped reporting mutable-tag findings, for instance, would not falsify this story by its own stated test. Separately, `story:rules-compliance-report`'s Story and Acceptance are written at full generality: "a read-only report of where my project drifts from a plugin's declared rules... Each rules-bearing plugin delivers this over its own rulebook with its real checking machinery" — which already, by its own wording, covers ok-workspaces' audit as one instance among all rules-bearing plugins' compliance verbs, and its Falsifier ("real drift goes unreported") does cover a regression.

**What the actual `/audit` implementation does, checked against both claims.** `plugins/ok-workspaces/skills/audit/SKILL.md` runs exactly four checks — mutable tags in verification paths, runtime isolation parameterization, worktree naming, src-tag consumption — read-only, reporting file:line findings, fixing nothing. This is a faithful instance of the `rules-compliance-report` shape (grouped report, mechanical-vs-judgment split implied by "the fix is..." language, nothing modified) delivered by the workspaces plugin specifically, exactly as `rules-compliance-report`'s Acceptance anticipates ("each rules-bearing plugin delivers this over its own rulebook").

**What each story's Boundaries/kind say about ownership.** `concept:story-artifact`'s Invariants state: "Two stories describing the same user outcome through different surfaces are one story" — directly on point, since both claims describe the *same* observable outcome (a read-only compliance report over workspace discipline) with no differing surface between them; there is no version of this audit reachable a second, distinct way. That invariant argues for consolidation into one story rather than two overlapping claims, but doesn't say *which* of the two should be the survivor. `concept:workspace`'s Boundaries name `safe-workspace-teardown` and `isolated-parallel-workspaces` as owning "a job's checkout, branch, and runtime namespace for the job's lifetime, from gated open to safety-gated close" — a lifecycle framing that is naturally about *doing* workspace things, not about a separate, periodic compliance sweep, which leans toward the audit clause being an awkward fit inside the isolation story to begin with. `story:corpus-audit` is a structurally close cousin (compliance findings, mechanical-vs-judgment split, read-only) but is scoped to the *design corpus* specifically ("the whole design corpus periodically checked for compliance, proof coverage, intent drift"), not to a plugin's own operational rules — it's evidence of the pattern's shape elsewhere in the suite, not a third claimant on this specific outcome.

**Candidates and their tradeoffs, undecided:**
- *Move the audit clause wholly into `rules-compliance-report`, drop it from the isolation story.* Matches `story-artifact`'s "same outcome, one story" invariant cleanly, and `rules-compliance-report` already generalizes correctly over every rules-bearing plugin including this one — no new claim needed, just deleting the redundant sentence from `isolated-parallel-workspaces`'s Acceptance. Slightly loses locality: a reader of the isolation story who wants to know "how do I find out if my workspace discipline has rotted" now has to know to look at a differently-named story.
- *Keep the clause in the isolation story, scope `rules-compliance-report` explicitly to the plugins not otherwise covered.* Preserves the isolation story's current completeness (open, isolate, teardown, *and* verify discipline, all in one place) but requires `isolated-parallel-workspaces`'s Falsifier to actually grow a clause covering audit regression (it currently doesn't), and requires `rules-compliance-report` to carry an explicit carve-out naming ok-workspaces as already covered elsewhere — an unusual shape for a story whose whole point is generalizing over "each rules-bearing plugin."

**What the ruling must decide.** Whether the workspace-discipline audit outcome belongs entirely to `story:rules-compliance-report` (with `isolated-parallel-workspaces`'s Acceptance trimmed and no Falsifier gap to fix), or stays split with `isolated-parallel-workspaces` keeping the clause and gaining a matching Falsifier while `rules-compliance-report` is scoped around it.

## Ruling

<!-- Owner: write your decision here in your own words.
The next /plan-sprint picks it up. Leave empty to discuss
it live in a planning session instead. -->
