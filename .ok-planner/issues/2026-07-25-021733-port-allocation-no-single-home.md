---
issue: port-allocation-no-single-home
kind: discover
category: inconsistent
artifacts:
  - concept:workspace
  - story:isolated-parallel-workspaces
status: verified
opened: 2026-07-25T02:17:33Z
---

# The port-block allocation algorithm has no single home

## Problem

The per-workspace port formula appears in three places (detection defaults, generated cheatsheet text, the open verb's allocation step) with the workspace-index derivation stated only in the open verb — the algorithm lives in a prompt with partial copies elsewhere.

## Candidates

- Amend concept:workspace Invariants to state the allocation algorithm canonically
- Move the allocation into a materialized script via a sprint and reference it from the profile

## Discussion

**The question.** The port-block allocation formula (`basePort + N × portsPerWorkspace`) and its workspace-index derivation (`N = 1 + count of existing worktrees matching the profile's dir prefix`) appear scattered across prompt text and generated output rather than living in one place. Should the corpus state the algorithm canonically, should it move into a materialized script, or is scattering it across three prose sites acceptable given none of them are meant to be the source of truth?

**Evidence, re-verified — confirmed, three sites.** `plugins/ok-workspaces/scripts/detect.js:58` sets the defaults: `profile.devServer = { portEnvVars: ['PORT'], basePort: 3000, portsPerWorkspace: 10 }` — these are proposed defaults an owner confirms into the committed profile, not the algorithm itself. `plugins/ok-workspaces/scripts/true-up.js:81` generates cheatsheet prose describing the formula: "port block: workspace N uses ports ${base} + N×${span} through..." — this is templated text materialized into the consumer's `.claude/rules/ok-workspaces-cheatsheet.md`, restating the formula for the always-in-context rules layer. `plugins/ok-workspaces/skills/open/SKILL.md:27` states the formula a third time as an executable instruction: "allocate this workspace's port block per the profile (`basePort + N × portsPerWorkspace`, where N = 1 + the count of existing `<dirPrefix>*` worktrees)" — and this is the *only* site that states how N is derived; neither `detect.js` nor the cheatsheet template says how N is computed, only what the formula does once N is known. So the open verb's prompt text is, today, the sole location the actual derivation exists — an agent following `true-up`'s generated cheatsheet alone could not compute a correct port block without also reading `open/SKILL.md`.

**What the corpus says.** `concept:workspace`'s Invariants list three rules about workspace identity and safety (never reused/clobbered, worktree is the only record of uncommitted work, only untracked files carry over) but say nothing about how runtime namespace values — ports or container names — are computed; its Boundaries state "the naming and location come from the profile" and cross-reference `stack-profile`, treating allocation as the profile's territory without saying where the profile's *algorithm* should live (the profile is data — `basePort`, `portsPerWorkspace` — not the formula that consumes it). `concept:stack-profile`'s Boundaries state "what gets materialized from it belongs to materialized-artifact and cheatsheet," which is consistent with the cheatsheet's port-block prose being a legitimate materialization — but the profile concept doesn't address the N-derivation step at all, since N is computed at *open* time from live worktree state, not from anything in the committed profile. `story:isolated-parallel-workspaces`'s Acceptance requires "the runtime is namespaced per the profile — a per-job container project name or a reserved port block" as an observable outcome, but is silent on implementation location. `decision:single-source-transclusion` (bearing from the sibling `ok-planner` plugin, cited by the batch) establishes the *pattern* this issue's second candidate would apply — canonical rule text living once and transcluded by token — but it's ok-planner's own decision about ok-planner's skills; `ok-workspaces` has no equivalent transclusion mechanism today, so invoking the pattern here would mean introducing it fresh for this plugin, not merely following precedent.

**What the code does today.** Three independent prose statements of the same formula (detect.js's defaults comment-equivalent, true-up.js's generated string, open/SKILL.md's instruction) with no single function or file computing it programmatically — the "computation" happens inside whichever agent reads `open/SKILL.md`'s natural-language instruction and counts worktrees itself at open time. There's no script the three sites could import from or the profile could reference by name.

**Candidates, and what each means.** Candidate 1 (state the algorithm canonically in `concept:workspace` Invariants) adds a fourth prose site rather than reducing the existing three — corpus text isn't transcluded into skill prompts today the way `ok-planner`'s shared definitions are, so this would document the intended behavior without actually deduplicating the code sites; drift between the concept and the three code sites remains possible unless something else enforces agreement. Candidate 2 (move allocation into a materialized script, reference it from the profile) would mean writing an actual port-allocation function (likely alongside `detect.js`/`true-up.js`'s existing script surface), having `open/SKILL.md` invoke it instead of restating the formula, and having the cheatsheet-generation step call the same function to produce its prose — this collapses three independent statements into one computed source, closing the drift vector for real, at the cost of introducing script machinery `open/SKILL.md` currently does inline as an agent instruction (the open verb is presently pure prompt text with no invoked allocation helper).

**What the ruling must decide.** Whether the port-allocation formula and its N-derivation should be consolidated into one computed, referenced source (a materialized script the profile points to), or whether stating it canonically in `concept:workspace` is sufficient given the corpus and the executing skills aren't mechanically kept in sync today.

## Ruling

<!-- Owner: write your decision here in your own words.
The next /plan-sprint picks it up. Leave empty to discuss
it live in a planning session instead. -->
