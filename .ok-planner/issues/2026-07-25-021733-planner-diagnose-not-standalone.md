---
issue: planner-diagnose-not-standalone
kind: discover
category: inconsistent
artifacts:
  - concept:true-up
  - concept:integration-contract
status: verified
opened: 2026-07-25T02:17:33Z
---

# The planner lacks the standalone diagnose layer the contract promises

## Problem

The contract says the diagnose phase 'stays available standalone' with a drift exit code for CI, realized for two plugins, but the planner's script mixes diagnose and converge in one pass — it writes unconditionally and only reports retired layout.

## Candidates

- Amend concept:true-up Invariants to make the standalone-diagnose property per-plugin-optional
- Bring the planner's script up to the contract via a sprint work item

## Discussion

**The question.** Should every integrable plugin's `true-up` expose a standalone, read-only diagnose mode with a CI-usable exit code (as `concept:true-up` describes), or is that property optional per plugin — with the planner's own combined diagnose-and-converge script being an accepted exception rather than a gap?

**Evidence, re-verified — confirmed live.** `plugins/ok-planner/scripts/true-up` (the planner's deterministic layout script) has no read-only mode: it unconditionally `mkdir -p`s the subdirectory tree, unconditionally overwrites `.ok-planner/CLAUDE.md` and the cheatsheet from templates (lines 86, 91), unconditionally materializes the hooks (lines 108–115), and only *after* writing everything does it report retired-layout presence on its last line (lines 117–134) — there's no invocation that observes-without-writing, and no non-zero exit code signaling drift. By contrast, two sibling plugins do realize a standalone diagnose: `plugins/ok-workspaces/scripts/diagnose.js` is a dedicated read-only script ("read-only drift report... Writes nothing," per its own header) checking both project drift and version drift; `plugins/ok-plumbline/bin/plumbline diagnose <target>` is a dedicated subcommand (`bin/plumbline:1066`, wired into the CLI dispatch table at `bin/plumbline:1199`) that `ok-plumbline/skills/true-up/SKILL.md:8,17` explicitly runs *before* any converge step, and which the same file documents as usable to "surface preexisting project guidance" ahead of writing anything. The three-way comparison is exact and reproduces today.

**What the corpus says.** `concept:true-up`'s What-it-is section states the three phases explicitly: "diagnose (read-only comparison of reality against declaration, on project drift and version drift), consent (only when something not plugin-owned needs migrating or resolving), and converge (deterministic materialization...)" — phrased as the verb's general shape, not qualified per-plugin. Its Boundaries and Invariants don't state a CI exit-code requirement explicitly (that specific claim — "drift exit code for CI" — is the filer's characterization of the diagnose phase's evident purpose, borne out by `ok-workspaces/scripts/diagnose.js` and `ok-plumbline/bin/plumbline diagnose`'s actual exit behavior, not text quoted verbatim from the concept). `concept:integration-contract`'s Invariants state "every integrable plugin exposes the lifecycle verb; plugins with rules to check also expose a read-only compliance verb" — this is about a *separate* compliance verb (like `/audit` for the planner, or plumbline's lint), not about `true-up` itself having an internal read-only diagnose sub-mode. Neither bearing artifact says whether standalone-diagnose is a hard invariant of `true-up` specifically or an implementation detail two plugins happened to converge on.

**What the code does today.** The planner is the outlier of the three integrable plugins surveyed: it has diagnose logic (the retired-layout detection loop) but it runs *after* every write has already happened, so there is no way to invoke "just diagnose" — an owner or CI process cannot learn whether a project has drifted without also converging it. `ok-workspaces` and `ok-plumbline` both let diagnose run standalone ahead of, and independent of, converge.

**Candidates, and what each means.** Candidate 1 (amend `concept:true-up` Invariants to make standalone-diagnose explicitly per-plugin-optional) accepts the planner's current combined script as compliant-by-declaration — cheap, but it's a corpus change motivated entirely by the planner's implementation gap rather than a considered reason standalone diagnose is inappropriate for `true-up` specifically (no such reason is evident in the code or corpus). Candidate 2 (bring the planner's script up to the contract via a sprint) means splitting `scripts/true-up` into a read-only diagnose pass (reality vs. declaration: does `.ok-planner/CLAUDE.md`'s version stamp match the installed plugin, are the subdirectories present, is retired layout present) that exits non-zero on drift, with converge as a separate invocation or a flag — real script work, but brings the planner in line with its two siblings and lets CI lint version drift the same way `ok-workspaces` and `ok-plumbline` already support.

**What the ruling must decide.** Whether `true-up`'s standalone, CI-usable diagnose phase is a suite-wide invariant every integrable plugin must realize (making the planner's combined script a defect to fix), or whether it's legitimately optional per plugin (in which case `concept:true-up` should say so, since its current wording reads as universal).

## Ruling

<!-- Owner: write your decision here in your own words.
The next /plan-sprint picks it up. Leave empty to discuss
it live in a planning session instead. -->
