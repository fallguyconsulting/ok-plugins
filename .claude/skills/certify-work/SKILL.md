---
name: certify-work
description: "ONLY activated by explicit /certify-work slash command, or as the terminal step named in the sprint document's execution boilerplate. Never auto-triggered by conversation content. The suite's change-scoped certification gate, covering every estate this project has: certifies the work just done — the uncommitted tree by default, a commit range on request — running each family's producers, the project's test suites, and code review over the diff into a no-discretion review-fix loop (fixer, then an architect on kickbacks, refutations, and reversals), then the presentation, with archival and commit offered as owner acts."
---

# Certify the Work (the change-scoped gate)

The done gate for an implementation goal, **scoped to the change**. It discharges the sprint's completion contract. The sprint boilerplate names it as its closing step.

This is a **suite verb**, not any one family's. One canonical body covers whichever families the project integrates, read from the filesystem when the verb runs.

**This gate does not audit.** Whether a corpus's claims still hold is `/audit`'s question, asked over the whole corpus on the owner's cadence, never per close. The machinery this gate runs — the review-fix loop and its veto test, the review root and its forks, the fixer and architect tasks, the presentation, the close-out — is defined once in `../_shared/certification-core.md`. Every reviewer, judge, fixer, and architect is a task in the task tracker at `.ok-planner/bin/tasks`, drained by the `execute-tasks` loop under a vendored profile, or a fork of the review root; the gate dispatches no agent directly.

## Resolve the estates

Every family's presence is a filesystem check at the project root — the nearest ancestor of the working directory (itself included) holding an estate directory, never derived from `.git`:

| estate | family |
|---|---|
| `.ok-planner/` | ok-planner |
| `.ok-plumbline/` | ok-plumbline |
| `.ok-workspaces/` | ok-workspaces |

For each estate present, read `<estate>/ceremony/certify-work.md` — the family's **ceremony contribution**. That file, not this one, says what the family contributes as producers, where its findings route, and what it offers at close-out; this body never carries family-specific instructions and never improvises them. A contribution missing where its estate exists is a conformance defect: report it and carry on.

**`.ok-planner/` is required for this verb.** The shared machinery this body transcludes — the review-fix loop, the fixer and architect prompts, the presentation, the issue-file format — is vendored by the planner estate's converge into `../_shared/`, and so are the task tracker at `.ok-planner/bin/tasks` and the profiles `ok-opus`, `ok-sonnet`, and `ok-review` under `.claude/agents/`. Without any of them, say so and stop.

Tell the owner which estates are in scope, in one line, before the run starts.

## Scope

**Default — the uncommitted working tree.** `git status` and `git diff` (and `--staged`): new, modified, and deleted files, staged or not.

**On request — a commit range.** Where the invocation carries an argument that parses as a git range or ref (`main..HEAD`, `v8.0.0..`, `abc123..def456`), the subject is that range's diff (`git diff <range>` plus `git log <range>`) **and** the uncommitted tree.

**The changed-file set** is derived once from that diff and used by every stage below. Each contribution adds whatever else its own producers need in scope, and removes what its estate rules out of a change's review; a removed file is read by no producer and edited by no fixer.

## The spine

1. **Layout** — each family ensures its own directories exist. Estate convergence is the front door's administration (`/ok`), not this gate's.
2. **Scope** — per the section above, plus each contribution's additions. A sprint named as an argument is the alignment target.
3. **The run** — select the sprint's run file where the sprint has one (`.ok-planner/sprints/<sprint-name>-run.jsonl`, `tasks use <path>`); open one at that path where a sprint is in scope and has none; open one at `.ok-planner/tasks/certify-<date>.jsonl` where no sprint is in scope per the certification core's **How consumers use this file**. Write and register the gate's prompt files — `review`, `suite`, `fixer`, `architect` — with `[REVIEW SCOPE]` and `[SPRINT PATH]` filled, and declare the pools' state vocabulary with the `tasks config set item_states` line the core's run-opening step gives. Every gate task carries key `gate`.
4. **Producers** — assemble the run's producers: the two this body always runs, plus every producer each present contribution declares under its `Producers` phase. Producers are stateless reporters: they never file issues and never fix. The gate is cold and is the only review the work gets: the build files no review task, no producer reads the build's findings, and only the review root's alignment fork reads the completion report, after it forks. A command producer is an `exec` task; an agent producer is a task under its profile.
   - **Test suites.** Read the project's documented full-suite command from its own docs (CLAUDE.md, README, Makefile, package manifest) — never invent an invocation, never narrow it to the change — record it once with `tasks config set suite_command "<command>"`, and file the suite runner as a task under `ok-sonnet` with `{{SUITE-RUNNER-PROMPT}}` from `../_shared/certification-core.md`: it runs the command and files one finding per failure itself. The gate reads no suite output. A failure is fixed in the loop; none is recorded as pre-existing and passed.
   - **Code review, scoped to the diff, one root per round, in forked passes.** The `review` prompt is `{{CERTIFY-REVIEW-ROOT-PROMPT}}` from `../_shared/certification-core.md`, carrying the code-review brief and the alignment fork's body. Every round the gate files one review root under `ok-review`: it reads the change once, cuts the files its judgment forks cover into areas it files into the tracker, and forks the passes in its table — the two enumeration forks over the whole change, the two judgment forks per area, and the alignment fork with a sprint in scope. The prompt takes `[REVIEW SCOPE]`, all three paragraphs below. Filled as:

     ```
     The change under certification: [the uncommitted working-tree
     change | the diff of <range> plus the uncommitted tree]. Enumerate
     it with git status/diff; code deleted in the change is gone.

     Out of scope: [every file each present contribution removes from
     the review, by path or rule]. Read none of them, edit none of
     them, and file nothing on them.

     Your reading is confined to the change and what it directly
     reaches: changed code, the callers the change breaks, the
     load-bearing properties the change trades away. Read changed
     files in full for context, and form no finding about deleted
     code. Every defect you meet there is a finding, and the loop
     fixes every finding. A
     defect the change did not introduce is filed with `--field
     origin=pre-existing` and fixed like any other; the mark only
     tells the presentation where the run reached beyond the change.
     Do not sweep unrelated files, and do not follow trails out of
     the change's footprint to hunt for more: corpus-wide and
     repo-wide sweeps belong to the whole-corpus verbs.
     ```
5. **The review-fix loop.** Run `{{CERTIFY-REVIEW-FIX-LOOP}}` from `../_shared/certification-core.md`. Each round files its tasks and drains them with the `execute-tasks` loop; the run's `findings` pool is the ledger, and the gate writes `tasks render`'s output into the report before every dispatch. Rounds continue until the first round in which neither the fixer nor the architect edited any file (code, corpus, or the report's `## Divergences`) and no finding stands open, or until the cap stops the run as a thrash guard. One scope rule for the fixer and architect: a fix may edit any file the correct fix requires, and findings stay change-scoped.
6. **Routing** — where a confirmed fork or a cap remainder goes is whatever the contributions declare. The planner contribution declares the issue intake, reached only through the architect's confirmation or the cap escalation. A defect is never routed: the loop fixes it.
7. **Verify** — each contribution's own post-filing step.
8. **Present.** Compose and deliver `{{CERTIFY-PRESENTATION}}` from `../_shared/certification-core.md`, folding in each contribution's per-producer lines.
9. **Close-out.** Run `{{CERTIFY-CLOSE-OUT}}` from the same file, offering whatever each present contribution declares. Both archival and commit are owner acts, performed only on the owner's word.

## When to reach for the whole-corpus verb instead

**`/audit`** — before a release, after a run of sprints, whenever the owner wants to know whether a corpus's claims still hold, or when the change touched the canonical authoring rules. This gate's presentation may recommend an audit; it never runs one.

## What this skill does NOT do

`{{CERTIFY-GATE-BOUNDARIES}}` from `../_shared/certification-core.md`, plus:

- Does not carry family knowledge. Everything family-specific comes from the ceremony contributions in the estates present.
- Does not audit. It writes no determination, reads none, touches nothing an audit maintains, and forms no finding about whether an artifact is still supported.
- Does not widen its reading mid-run. The reviewers read the change and what it reaches, never the whole tree; every defect they meet there is fixed here, the ones the change did not introduce included.
- Does not converge an estate, materialize a file, or repair a family's presence. That is `/ok`, always a user action.

<!-- Materialized by ok v21.0.0 — suite-owned; overwritten on converge; do not hand-edit. -->
