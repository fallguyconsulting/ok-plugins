---
issue: review-changed-ignores-the-sprint-base
kind: audit
category: product-intent
artifacts:
  - story:certify-completion
status: retired
triage: question
opened: 2026-10-04T23:34:00Z
---

# `review changed --sprint` diffs from HEAD, so a person who runs it on a committed sprint sees no changes

The review tool (`plugins/ok/families/ok-planner/scripts/review`) does the mechanical steps of `/converge`. Its `changed` subcommand lists the files a sprint changed. Given `--sprint <path>` and no `--base`, it diffs from HEAD, not from the base commit the sprint recorded. Once the sprint's work is committed, it prints nothing and exits 0, with no warning. The owner's facts for the review loop (`.ok-planner/review/project.md`) list the review tool among the scripts for developers and operators. The accept list counts a wrong result from such a script as a defect (A3). So the answer turns on whether the review tool is a script people run, or `/converge`'s internal mechanics.

## How it happens

- `changed` declares `--base` with the default `HEAD`, plus `--sprint`, and no help text. `review changed --help` prints only `usage: review changed [-h] [--base BASE] [--sprint SPRINT]`.
- `--sprint` does one thing: it adds the folders the sprint lists under `## Paths outside the project root`. Nothing in the review tool reads the sprint's base file.
- `/converge sprint` reads the base file itself (the sprint's path with `-base.txt` in place of `.md`), asks the owner once when it is missing, and passes `--base` on every `review changed`, `review checks`, and `review snapshot` call.

So the owner gets a verdict computed from the recorded base through `/converge sprint`, and a person who runs `review changed --sprint S` by hand gets a diff from HEAD.

Evidence, from drive failure i19 in sprint certification run converge-2026-10-04T060800: after a scratch sprint's work was committed, `review changed --sprint S` printed nothing and exited 0. A base file beside the sprint changed nothing. `review changed --base HEAD~1 --sprint S` printed `added src/app.py`.

## What the corpus says

The story certify-completion promises that the owner knows, when a sprint closes, whether what they approved was delivered. `/converge sprint` meets it, and the story names no surface. The project has no surface intent, so nothing classes the review tool as public or internal. The corpus does not settle whether a hand user of the review tool is owed the recorded base.

## Options

- **Narrow the story.** certify-completion states that the owner reaches the delivery verdict through `/converge sprint` alone, and that the review tool is that ceremony's mechanics. Cost: the story grows a surface clause, and project.md must also drop the review tool from its script list, or A3 still reaches it.
- **Widen the story.** certify-completion states that the review tool, given a sprint, diffs from the recorded base and warns when none is recorded. Cost: a story about a ceremony's outcome starts naming a script's flags.
- **Drop the listing.** Change no corpus. The owner removes the review tool from project.md's script list, so A3 no longer covers it. Cost: the trap stays for anyone who runs the tool by hand.
- **Fix the tool.** Change no corpus. `--sprint` without `--base` reads the sprint's recorded base, refuses with a message naming `--base` when none is recorded, and each subcommand gains help text; `checks` and `snapshot` take the same rule. Cost: a code change no promise asks for.

The ruling decides whether the corpus changes, and whether the review tool stays a script people may run.

## Ruling

Retired by the owner on 2026-10-04: fixed inline. Nobody runs the review tool by hand, but the fix costs nothing. In plugins/ok/families/ok-planner/scripts/review, `changed` and `checks` now take the sprint's recorded base (the `-base.txt` file beside the sprint) wherever `--sprint` is given without `--base`, and refuse with "<sprint> records no base commit (no <path>); pass --base" when none is recorded. `changed` with neither flag still diffs from HEAD; `checks` with neither refuses with "checks needs --base or --sprint". `snapshot` keeps diffing from HEAD, because a fix round snapshots the files changed since HEAD by design. Every subcommand now carries help text. No corpus artifact changes.
