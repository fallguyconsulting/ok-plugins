# ok-workspaces administration

The judgment side of this family's administration — everything the
deterministic core beside this document (`admin/converge`) cannot
encode. The suite's front door (`/ok`) reads this document when it
administers the family; nothing here is improvised by the
administrator, and nothing here is a user-facing verb.

The realized estate follows the declared profile at
`.ok-workspaces/config.json`. Materialized artifacts are suite-owned
and converge without prompting; the profile is owner-*declared* — the
administration writes `config.json` only as transcription of the
owner's explicit in-conversation answers, never a field they didn't
confirm, never silently.

## The core's modes

```
bash admin/converge            # converge: materialize the suite-owned layer from the profile
bash admin/converge diagnose   # read-only drift report; exit 2 on drift
```

The family declares no hooks, so there is no wire-hooks mode. Converge
requires a declared profile; with none it exits non-zero and the
declaration walkthrough below is the procedure.

## Declare a profile, in conversation

Be **opinionated about what needs asking**: a clear detection signal is
not a judgment call — compose files present means docker-compose
isolation, the repo's compose project name is the prefix, stock
worktree naming is the answer unless something in the repo says
otherwise. Run detection and hold the proposal in conversation — never
park it in a file and leave:

```bash
node "<family>/scripts/detect.js"
```

- **Detection confident** (the normal case — every field has exactly
  one natural answer, whether a stock default or a strong repo signal:
  compose files present → docker-compose runtime with the detected
  project prefix; no competing harness; no preexisting tag script):
  present the whole profile compactly and ask **one yes/no** —
  "declare this profile?" Detected stacks, a runtime to isolate, and
  derived naming are not judgment calls; they are what detection is
  for. Consent → write it to `.ok-workspaces/config.json` and run the
  core's converge in the same pass.
- **Genuinely ambiguous fields** (the repo supports more than one
  answer: two plausible runtimes detected — e.g. compose files AND a
  bare dev-server harness both in live use; an existing
  content-addressed tag script whose path could be kept for its current
  consumers; a compose project name that collides with a sibling
  project; detection contradicting something the owner said
  in-session): ask about **those fields only**, with the recommended
  answer stated, and take the confident remainder as part of the same
  declaration. Never expand ambiguity in one field into a
  field-by-field walkthrough of the others.

Detection proposes with conviction; the owner's consent decides; the
committed file records. If the owner prefers to hand-edit instead,
write the proposal to `.ok-workspaces/config.proposed.json` and stop —
and if a stale `config.proposed.json` exists once `config.json` is
declared, remove it: it is detection scratch, superseded by the
declaration.

## Resolve profile drift

When diagnose reports stacks or runtime drifted (fresh detection
disagrees with the declared profile — e.g. Docker was introduced after
the project materialized as dev-server): same opinionated shape.
Present the disagreement **with a recommended resolution** (a newly
live runtime is almost always detected reality to accept, not noise),
ask one question, transcribe the owner's resolution into
`.ok-workspaces/config.json`, and run the core's converge in the same
pass.

## What the administration does NOT do here

- Does not write the profile without consent, and never manufactures
  questions out of fields detection already answered.
- Does not touch the project's root `.gitignore`, compose files,
  Makefiles, or any project-owned file — wiring the src-tag script into
  builds and harnesses is the project's own change, guided by the
  cheatsheet. The ignore files the core writes are its own —
  `.ok-workspaces/.gitignore` inside the dot-directory the suite owns
  outright, plus a suite-owned `.gitignore` at the profile-declared
  `worktrees.dirPrefix` when that prefix is an in-repo path outside the
  dot-directory (a `.gitignore` covers only its own directory, and a
  checkout inside the repo must never become content of the repo).
  Both are materialized, version-stamped files the owner commits like
  any other; the root `.gitignore` stays untouched.
- Does not create worktrees or stacks — that is `/open` — and never
  drives workspace work: compliance sweeps are the suite's `/audit` ceremony, driven from this family's `.ok-workspaces/ceremony/audit.md`,
  workspace lifecycle is `/open`/`/close`.
