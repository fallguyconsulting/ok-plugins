---
issue: repeated-list-flags-on-tasks-keep-only-the-last-value
kind: human
category: conflicting
artifacts: []
status: answered
opened: 2026-09-04T11:15:00Z
---

# A repeated list flag on the task tracker keeps only its last value, so a build that closes with `--staged` once per path records one path

## Problem

`plugins/ok/families/ok-planner/scripts/tasks` declares every list flag with `nargs="*"` and the default store action: `--files`, `--after`, `--cites` on `file` (lines 1112-1114), `--staged` on `close` (line 1140), `--after` on `refile` and `task set`. With that declaration, argparse replaces the list on each repetition, so `close t3 --staged a --staged b --staged c` records `c` alone and reports success. Nothing warns.

Observed on 2026-09-04 in `linescout/platform` executing `2026-09-04-remove-line-topology` on v20.0.0: the stage 2 build agent (profile `ok-opus`) closed its task with `--staged` repeated six times, one path each. The tracker recorded one `staged` item, `src/gridiq/cli/test_formationdoc.py`, and the close event reported `staged: 1`. The review task for that stage consumes `staged:unread` for its key, so it would have read one of the six files the build changed. The session found the gap by comparing the staged pool against `git diff --cached` and added the five missing items by hand with `tasks item add`.

The same shape bit the session earlier in the run: under zsh, `tasks file --files $PATHS` stored every path as one string, because zsh does not word-split an unquoted variable. Both failures are the tracker accepting a list in a form the caller did not intend and saying nothing.

## Candidates

- Declare every list flag with `action="extend"` and `nargs="+"`, so a repeated flag accumulates and a repeated-flag call and a single-flag call record the same list. Reject an empty list.
- Keep the declaration and have `close` refuse a `--staged` list whose paths are not all in the git index, and `file` refuse a `--files` entry that is not a path in the tree, so a wrong form fails loudly instead of recording a wrong list.
- State the accepted form in the build task prompt and in the profile's claim output: one `--staged` followed by every path, space-separated.

## Ruling

Answered on 2026-09-05: the filed gap no longer exists. every list flag on the tracker accumulates across repetitions and refuses an empty list; see decision team-execution-cold-gate, Choice, and the tracker's own usage text.
