---
name: true-up
description: "True up the ok-workspaces estate: diagnose drift (fresh detection vs the declared profile, artifact fidelity, version stamps), then converge — with no committed profile, run detection and declare it with the owner (one yes/no when detection is confident; field questions only for genuinely ambiguous signals), then materialize; with a profile, materialize the src-tag script, cheatsheet, and worktree .gitignore from it (version-stamped, plugin-owned, overwritten wholesale). Idempotent. Plumbing — normally driven by /ok; also user-invokable as /true-up."
---

# True up the ok-workspaces estate

Bring the realized estate into agreement with the declared profile. Diagnose first (read-only), then converge what the plugin owns. Anything requiring the owner's declaration is asked **in conversation**, and the skill is **opinionated about what needs asking**: a clear detection signal is not a judgment call — compose files present means docker-compose isolation, the repo's compose project name is the prefix, stock worktree naming is the answer unless something in the repo says otherwise. Detection's confident answers are presented for consent as one declaration, not interrogated field by field. A question is spent only where the repo genuinely supports more than one answer. The owner still consents before anything is written — never silently — and is never sent away to hand-edit a JSON file unless they ask to.

## 1. Diagnose

```bash
node "${CLAUDE_PLUGIN_ROOT}/scripts/diagnose.js"
```

The script checks: the profile exists and parses; detected stacks and runtime match the declared ones; the src-tag script at the profile-declared path is byte-identical to the canonical version for the installed plugin; the cheatsheet exists and its version stamp matches; `.ok-workspaces/.gitignore` exists and covers the profile's worktree location. Exit 0 clean, 2 drift. Include the report in your response.

Clean and a profile exists → nothing to do; report and stop.

## 2. Converge — by what the diagnosis found

**No committed profile at `.ok-workspaces/config.json`** — detect, then walk the owner through declaring one:

```bash
node "${CLAUDE_PLUGIN_ROOT}/scripts/detect.js"
```

Hold the detected proposal and put it to the owner in conversation — never park it in a file and leave:

- **Detection confident** (the normal case — every field has exactly one natural answer, whether a stock default or a strong repo signal: compose files present → docker-compose runtime with the detected project prefix; no competing harness; no preexisting tag script): present the whole profile compactly and ask **one yes/no** — "declare this profile?" Detected stacks, a runtime to isolate, and derived naming are not judgment calls; they are what detection is for. Consent → write it to `.ok-workspaces/config.json` and continue to materialization below, same pass.
- **Genuinely ambiguous fields** (the repo supports more than one answer: two plausible runtimes detected — e.g. compose files AND a bare dev-server harness both in live use; an existing content-addressed tag script whose path could be kept for its current consumers; a compose project name that collides with a sibling project; detection contradicting something the owner said in-session): ask about **those fields only**, with the skill's recommended answer stated, and take the confident remainder as part of the same declaration. Never expand ambiguity in one field into a field-by-field walkthrough of the others.

Detection proposes with conviction; the owner's consent decides; the committed file records. Writing `config.json` here transcribes the declaration the owner consented to — the one-yes/no profile, plus their answers on any genuinely ambiguous fields. If the owner prefers to hand-edit instead, write the proposal to `.ok-workspaces/config.proposed.json` and stop as before; and if a stale `config.proposed.json` exists once `config.json` is declared, remove it — it is detection scratch, superseded by the declaration.

**Stacks or runtime drifted** (fresh detection disagrees with the declared profile — e.g. Docker was introduced after the project materialized as dev-server): same opinionated shape. Present the disagreement **with a recommended resolution** (a newly live runtime is almost always detected reality to accept, not noise), ask one question, transcribe the owner's resolution into `.ok-workspaces/config.json`, and continue to materialization in the same pass.

**Profile present (or just declared above), materialized artifacts stale or missing** (version drift, script divergence, absent cheatsheet):

```bash
node "${CLAUDE_PLUGIN_ROOT}/scripts/true-up.js"
```

The script materializes, from the profile:

- The canonical src-tag script at `srcTag.path` (default `.ok-workspaces/bin/src-tag`), executable, version-stamped.
- `.claude/rules/ok-workspaces-cheatsheet.md` — the three rules with the profile's concrete mechanics substituted (compose project prefix, port scheme, script path), version-stamped.
- `.ok-workspaces/.gitignore` — covering wherever the profile puts worktrees (default `.ok-workspaces/worktrees/`). Worktrees default to living inside the project root so a job's checkout never escapes it; this file is what keeps a checkout from becoming repo content.

All three are plugin-owned whole files, overwritten wholesale — never merged, never hand-edited. Pass the script's one-line summary back as part of your response.

## What this skill does NOT do

- Does not write the profile without consent. Detection proposes with conviction and the owner declares — one yes/no when detection is confident, targeted questions only where the repo genuinely supports more than one answer. The skill never writes `config.json` silently, and never manufactures questions out of fields detection already answered.
- Does not touch the project's root `.gitignore`, compose files, Makefiles, or any project-owned file — wiring the src-tag script into builds/harnesses is the project's own change, guided by the cheatsheet. The one ignore file it writes is `.ok-workspaces/.gitignore`, inside the dot-directory the plugin owns outright.
- Does not create worktrees or stacks — that's `/open` — and never drives workspace work: compliance sweeps are `/audit`, workspace lifecycle is `/open`/`/close`.
