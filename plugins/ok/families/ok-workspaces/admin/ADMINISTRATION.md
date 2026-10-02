# ok-workspaces administration

The judgment side of this family's administration — everything the
deterministic core beside this document (`admin/converge`) cannot
encode. The suite's front door (`/ok`) reads this document when it
administers the family; nothing here is improvised by the
administrator, and nothing here is a user-facing verb.

The realized estate follows the declared profile at
`.ok-workspaces/config.json`. Materialized artifacts are suite-owned
and converge without prompting; the profile is owner-*declared* — the
core's `resolve` mode writes `config.json` only from a draft the owner
approved in conversation, never a field they didn't confirm, never
silently.

## The core's modes

```
bash admin/converge            # converge: materialize the suite-owned layer from the profile
bash admin/converge diagnose   # read-only drift report; exit 0 clean, 1 on drift, 3 when only cleanup offers await the owner
bash admin/converge resolve <id> [--from <draft>]  # one consented cleanup — see below
```

The family declares no hooks, so there is no wire-hooks mode. Converge
requires a declared profile; with none, or with one it cannot read,
it exits 2 and offers one, and the declaration walkthrough below is how to draft it.

## Cleanup offers — consent, then resolve

Diagnose and converge print one `CLEANUP OFFERED (ok-workspaces): <id>`
block for each item converge leaves for the owner: what is there, what
the fix does, the recommended answer, and the exact consent command.
The front door (`/ok`) presents every block in one question and runs
the command for each item the owner accepts. `resolve` re-reads the
offers, refuses an id diagnose would not report now, and applies that
one fix. A block whose paths carry uncommitted or staged-only changes
prints an `Uncommitted:` line, and a block whose paths sit behind a
symbolic link prints a `Symbolic link:` line. `resolve` refuses such
an item, changing nothing, until the owner commits those changes or
removes the link and runs `/ok` again. No offer has a choice that
discards changes. Converge itself removes the suite-stamped files of a
retired skill, with no offer. The consent
command quotes the id, so a path with a space stays one argument.
Converge again after it. `/ok` records an offer the owner declines as
declined, and the next run offers it again.

| id | what is there | the fix |
|---|---|---|
| `profile:.ok-workspaces/config.json` | no profile, one that does not parse, or one with problems listed in the block: a `srcTag` field, a `worktrees.dirPrefix` at the repository root, an unknown runtime, or stacks or runtime that detection contradicts | write the drafted profile |
| `stale-proposal:.ok-workspaces/config.proposed.json` | detection scratch beside a declared profile | delete it, with `git rm` where git tracks it |
| `collision:.claude/skills/<folder>` | the project's own unstamped files at paths this family vendors, listed in the block | delete the listed files and nothing beside them; converge writes the suite's copy, and the folder's other files stay |
| `retired-verb:.claude/skills/<name>` | files the project wrote in a skill folder at a retired name, listed in the block | delete the listed files |

The front door writes the `profile` draft to a scratch path outside the
project, shows it, and on the owner's yes passes it as
`--from <draft>`. Where a profile exists, the draft settles each
listed problem and keeps every key the problems do not name as it is;
`resolve` refuses a draft that adds, drops, or changes any other key. `resolve` refuses a draft that does not parse,
declares `srcTag`, names an unknown runtime, or puts worktrees at the
repository root.

## Declare a profile, in conversation

Be **opinionated about what needs asking**: a clear detection signal is
not a judgment call — compose files present means docker-compose
isolation, the repo's compose project name is the prefix, stock
worktree naming is the answer unless something in the repo says
otherwise. Run detection and draft the `profile` offer from its
proposal:

```bash
node "<family>/scripts/detect.js"
```

- **Detection confident** (the normal case — every field has exactly
  one natural answer, whether a stock default or a strong repo signal:
  compose files present → docker-compose runtime with the detected
  project prefix; no competing harness; no preexisting tag script):
  the draft is detection's proposal, and the offer is **one yes/no** —
  "declare this profile?" Detected stacks, a runtime to isolate, and
  derived naming are not judgment calls; they are what detection is
  for.
- **Genuinely ambiguous fields** (the repo supports more than one
  answer: two plausible runtimes detected — e.g. compose files AND a
  bare dev-server harness both in live use; an existing tag script
  whose path could be kept for its current consumers; a compose
  project name that collides with a sibling
  project; detection contradicting something the owner said
  in-session): ask about **those fields only**, with the recommended
  answer stated, and take the confident remainder as part of the same
  declaration. Never expand ambiguity in one field into a
  field-by-field walkthrough of the others.

Detection proposes with conviction; the owner's consent decides; the
committed file records. A `config.proposed.json` an earlier release
left beside a declared profile is offered as `stale-proposal`.

## Resolve profile drift

When diagnose reports stacks or runtime drifted (fresh detection
disagrees with the declared profile — e.g. Docker was introduced after
the project materialized as dev-server): same opinionated shape.
Draft the profile **with a recommended resolution** (a newly live
runtime is almost always detected reality to accept, not noise), and
present it with the `profile` offer.

The `profile` offer names one problem by field: **the profile declares
`srcTag`**, the field ok-workspaces carried when artifact tags were
content-addressed. The field is `runTag` now, and its value is the path
the run-tag script materializes to. Draft the rename with the
recommended value: `runTag.path` keeps whatever path `srcTag.path`
held, so wiring the project already has keeps resolving. Tell the
owner what changes: the script now prints a fresh `run-<12 hex>` on
every invocation instead of a tree hash, so one build and the
verification run over it share one invocation's tag.

## What the administration does NOT do here

- Does not write the profile without consent — only `resolve`, from
  an approved draft — and never manufactures questions out of fields
  detection already answered.
- Does not touch the project's root `.gitignore`, compose files,
  Makefiles, or any project-owned file — wiring the run-tag script into
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
