---
topic: stack-profile
kind: discipline
---

# Stack tailoring: detect → declare → materialize

## Description

The contract's shape for plugins whose discipline varies by project stack: "a detection scan *proposes* a stack profile from repo signals ...; the committed profile in the dot-directory is what's *authoritative*; true-up materializes rules and scripts *from the profile*. Detection never silently decides — a scan/declaration mismatch is diagnosed project drift, and reconciling the profile is the owner's act; true-up stops and asks." Asking means a **conversational walkthrough**: "true-up puts each judgment call to the owner in dialogue (a single yes/no when detection is unambiguous) and transcribes the answers into the committed profile verbatim — declaring is deciding, not typing." Transcription is the ownership-rule carve-out: "Writing the profile as transcription of explicit answers does not breach the ownership rule; writing any field the owner didn't confirm does." A proposal file remains the hand-editing fallback.

ok-workspaces is the named exemplar. `scripts/detect.js` scans for `go.mod`/`package.json`/`Cargo.toml`/pyproject signals, compose files and Dockerfiles, and dev-server scripts, and prints a proposed profile JSON: `{version, stacks[], runtime: docker-compose|dev-server|none, worktrees:{dirPrefix:".ok-workspaces/worktrees/", branchPrefix:"wt/"}, srcTag:{path}, compose:{projectPrefix,files}|devServer:{portEnvVars,basePort,portsPerWorkspace}}`. The committed `.ok-workspaces/config.json` decides; `diagnose.js` re-runs detection and flags stacks/runtime disagreement as drift; `true-up.js` refuses to run without a committed profile. The true-up skill is "opinionated about what needs asking": confident detection is presented as **one yes/no** for the whole profile ("detected stacks, a runtime to isolate, and derived naming are not judgment calls; they are what detection is for"); questions are spent only on genuinely ambiguous fields (two plausible runtimes, an existing tag script whose path has consumers, a colliding compose prefix); a stale `config.proposed.json` is removed once `config.json` exists.

ok-plumbline follows the same shape with different names: `plumbline starter` is the detector (Go/Node generated dirs to ignore, ok-planner sibling → citation entries), `.ok-plumbline/config.json` is the declaration, and true-up §5 does the conversational declaration ("plumbline is strict by default; there is no soft start"). A declared-but-elsewhere value is *not* drift: a project pointing `worktrees.dirPrefix` outside the dot-directory "is a declaration, not drift, and diagnose reports it as such."

## Code surface

- `plugins/ok-workspaces/scripts/detect.js`, `scripts/diagnose.js` (stacks/runtime comparison), `scripts/true-up.js` (profile-driven materialization), `skills/true-up/SKILL.md`.
- `plugins/ok-plumbline/bin/plumbline` `starter` subcommand; `skills/starter/SKILL.md`; `skills/true-up/SKILL.md` §5.

## Prose surface

- `docs/integration-contract.md` "Stack tailoring (detect → declare → materialize)".
- `plugins/ok-workspaces/CLAUDE.md` (detect/declare/materialize summary; "the committed profile is owner-*decided*").

## Adjacent topics

- `ownership-and-consent`, `true-up-verb`, `workspace-discipline`, `plumbline-config`, `src-tag`.

## Observations

- The contract says a scan/declaration mismatch means "true-up stops and asks"; the workspaces skill sharpens this to *ask with a recommendation* ("a newly live runtime is almost always detected reality to accept, not noise") — a deliberate anti-interrogation stance layered on the contract, repeated in three places (contract, CLAUDE.md, skill) with slightly different emphasis.
- detect.js's dev-server port scheme (`basePort + N × portsPerWorkspace`, N from counting existing worktrees) is encoded in `/open`'s prose rather than in any script — the allocation algorithm lives in a prompt.
- Profile `version: 1` field exists in detect.js output but nothing anywhere reads or validates it.
