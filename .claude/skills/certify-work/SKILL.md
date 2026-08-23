---
name: certify-work
description: "ONLY activated by explicit /certify-work slash command, or as the terminal step named in the sprint document's execution boilerplate. Never auto-triggered by conversation content. The suite's change-scoped certification gate, covering every estate this project has: certifies the work just done — the uncommitted tree by default, a commit range on request — running each family's producers, the project's test suites, and code review over the diff into a no-discretion review-fix loop (fixer, then an architect on kickbacks, refutations, and reversals), then the presentation, with archival and commit offered as owner acts."
---

# Certify the Work (the change-scoped gate)

The done gate for an implementation goal, **scoped to the change**. It discharges the sprint's completion contract. The sprint boilerplate names it as its closing step.

This is a **suite verb**, not any one family's. One canonical body covers whichever families the project integrates, read from the filesystem when the verb runs.

**This gate does not audit.** Whether a corpus's claims still hold is `/audit`'s question, asked over the whole corpus on the owner's cadence, never per close. The machinery this gate runs — the review-fix loop and its veto test, the fixer and architect subagents, the code-review prompt, the presentation, the close-out — is defined once in `../_shared/certification-core.md`.

## Resolve the estates

Every family's presence is a filesystem check at the project root — the nearest ancestor of the working directory (itself included) holding an estate directory, never derived from `.git`:

| estate | family |
|---|---|
| `.ok-planner/` | ok-planner |
| `.ok-plumbline/` | ok-plumbline |
| `.ok-workspaces/` | ok-workspaces |

For each estate present, read `<estate>/ceremony/certify-work.md` — the family's **ceremony contribution**. That file, not this one, says what the family contributes as producers, where its findings route, and what it offers at close-out; this body never carries family-specific instructions and never improvises them. A contribution missing where its estate exists is a conformance defect: report it and carry on.

**`.ok-planner/` is required for this verb.** The shared machinery this body transcludes — the review-fix loop, the fixer and architect prompts, the presentation, the issue-file format — is vendored by the planner estate's converge into `../_shared/`. Without it, say so and stop.

Tell the owner which estates are in scope, in one line, before the run starts.

## Scope

**Default — the uncommitted working tree.** `git status` and `git diff` (and `--staged`): new, modified, and deleted files, staged or not.

**On request — a commit range.** Where the invocation carries an argument that parses as a git range or ref (`main..HEAD`, `v8.0.0..`, `abc123..def456`), the subject is that range's diff (`git diff <range>` plus `git log <range>`) **and** the uncommitted tree.

**The changed-file set** is derived once from that diff and used by every stage below. Each contribution adds whatever else its own producers need in scope.

## The spine

1. **Layout** — each family ensures its own directories exist. Estate convergence is the front door's administration (`/ok`), not this gate's.
2. **Scope** — per the section above, plus each contribution's additions. A sprint named as an argument is the alignment target.
3. **Producers** — assemble the run's producers: the two this body always runs, plus every producer each present contribution declares under its `Producers` phase. The gate takes nothing from a contribution's `Standing producers` section. That section belongs to the build's standing reviewer. Producers are stateless reporters: they never file issues and never fix. The gate is cold: no producer reads the standing reviewer's ledger from the build, and among the producers only the sprint-alignment judge reads the completion report.
   - **Test suites.** Discover the run commands from the project's own docs (CLAUDE.md, README, Makefile, package manifest) — never invent an invocation — and run the suites that cover the change, or the full suites where scoping is unclear. Every failure is a finding for the loop.
   - **Code review, scoped to the diff.** Dispatch `{{CERTIFY-CODE-REVIEW-PROMPT}}` from `../_shared/certification-core.md` with `[REVIEW SCOPE]` filled as:

     ```
     The change under certification: [the uncommitted working-tree
     change | the diff of <range> plus the uncommitted tree]. Enumerate
     it with git status/diff before forming findings; code deleted in
     the change is gone — do not form findings about it. Read changed
     files in full for context.

     Findings are confined to the change and what it directly breaks:
     a defect in changed code, a caller the change breaks, a
     load-bearing property the change trades away. A pre-existing
     defect is in scope only where the change touches or depends on
     it — do not sweep unrelated files, and do not follow trails out
     of the change's footprint. Corpus-wide and repo-wide sweeps
     belong to the whole-corpus verbs.
     ```
4. **The review-fix loop.** Run `{{CERTIFY-REVIEW-FIX-LOOP}}` from `../_shared/certification-core.md`. The code reviewer, the alignment judge, the fixer, and the architect stand across the run and take their work by message. The orchestrator keeps a finding ledger. Rounds continue until the first round in which neither the fixer nor the architect edited any file (code, corpus, or the report's `## Divergences`), or until the cap stops the run as a thrash guard. The mechanical producers and the suites re-run at their original scope each round. The code reviewer and the alignment judge re-examine what the round's message names. One scope rule for the fixer and architect: a fix may edit any file the correct fix requires, and findings stay change-scoped.
5. **Routing** — where a confirmed fork or a cap remainder goes is whatever the contributions declare. The planner contribution declares the issue intake, reached only through the architect's confirmation or the cap escalation.
6. **Verify** — each contribution's own post-filing step.
7. **Present.** Compose and deliver `{{CERTIFY-PRESENTATION}}` from `../_shared/certification-core.md`, folding in each contribution's per-producer lines.
8. **Close-out.** Run `{{CERTIFY-CLOSE-OUT}}` from the same file, offering whatever each present contribution declares. Both archival and commit are owner acts, performed only on the owner's word.

## When to reach for the whole-corpus verb instead

**`/audit`** — before a release, after a run of sprints, whenever the owner wants to know whether a corpus's claims still hold, or when the change touched the canonical authoring rules. This gate's presentation may recommend an audit; it never runs one.

## What this skill does NOT do

`{{CERTIFY-GATE-BOUNDARIES}}` from `../_shared/certification-core.md`, plus:

- Does not carry family knowledge. Everything family-specific comes from the ceremony contributions in the estates present.
- Does not audit. It writes no determination, reads none, touches nothing an audit maintains, and forms no finding about whether an artifact is still supported.
- Does not widen scope mid-run. A finding outside the change's footprint that the change neither caused nor depends on is not this gate's finding.
- Does not converge an estate, materialize a file, or repair a family's presence. That is `/ok`, always a user action.

<!-- Materialized by ok v19.0.0 — suite-owned; overwritten on converge; do not hand-edit. -->
