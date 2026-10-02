---
issue: run-tag-can-print-an-empty-tag
kind: human
category: defect
artifacts: []
status: open
opened: 2026-09-26T00:25:46Z
---

# `run-tag` prints a bare `run-` and exits 0 when it cannot read random bytes

## Problem

`plugins/ok/families/ok-workspaces/scripts/run-tag` runs:

```sh
set -eu
printf 'run-%s\n' "$(od -An -N6 -tx1 /dev/urandom | tr -d ' \n')"
```

`set -e` does not stop a script when a command substitution used as an argument fails. When `od` cannot read `/dev/urandom`, `printf` gets an empty string, prints `run-`, and the script exits 0. The same line shipped in the retired `src-tag`, and consumer projects still hold that copy until their next `/ok`.

The ok-workspaces cheatsheet makes the tag the only key a verification run resolves its artifacts by, and requires it to be unique to the run. A bare `run-` is shared by every run that hits the failure. In the consumer project linescout `platform/`, `infra/env.sh` sets `SRC_TAG` from the script's output with no check, and `infra/deploy` pushes `registry.fly.io/<app>:$SRC_TAG`. A second deploy in the same state would overwrite the first deploy's images, and every step reports success.

The only trigger is a machine that cannot read `/dev/urandom`, so the consumer project's defect catalog leaves it standing there. The flaw is in the suite's tool, and only the suite can fix it.

## Candidate

Read the random bytes into a variable first, so `set -e` stops the script on the failed read, and refuse any value that is not 12 hex digits:

```sh
set -eu
hex=$(od -An -N6 -tx1 /dev/urandom | tr -d ' \n')
case $hex in
  [0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]) ;;
  *) echo "run-tag: could not read 6 random bytes" >&2; exit 1 ;;
esac
printf 'run-%s\n' "$hex"
```

A plain assignment's exit status is the substitution's, but a pipeline's status is its last command's, so the `case` check is what catches an `od` failure that `tr` hides.

## Ruling
