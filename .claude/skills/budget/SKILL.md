---
name: budget
description: "ONLY activated by explicit /budget slash command. Never auto-triggered by conversation content. One-way violation ratchet for projects whose Plumbline backlog is too large to clear at once. Records a baseline violation count in .ok-plumbline/budget.json; CI fails any change that increases the count, accepts any that holds or decreases it."
---

# /budget

Manage the Plumbline violation budget — the ratchet mechanism for incrementally cleaning up a backlog too large to sweep at once.

The budget file (`.ok-plumbline/budget.json`; a root `.plumbline-budget.json` from an earlier layout is still read until the front door's administration (`/ok`) migrates it) records the current violation count and per-check breakdown. CI invokes `plumbline budget check`; the lint exits 2 only if the count went UP, so PRs that hold or reduce the count pass.

## Usage

Without args, the skill checks current usage against the saved baseline. Pass `save` to record a lower baseline: the ratchet is one-way in code, so `save` refuses (exit 2) when the current count is above the recorded one — raising a baseline is not something this verb can do.

```
/budget          # report current vs baseline (CI-suitable)
/budget save     # record current count as the new baseline
```

## Run

```bash
# Prefer the project's vendored binary — a baseline is only comparable against
# the version that produced it.
bin=".ok-plumbline/bin/plumbline"
if [ ! -x "$bin" ]; then
  bin="${CLAUDE_PLUGIN_ROOT:-plugins/ok}/families/ok-plumbline/bin/plumbline"
  echo "note: no vendored binary — using the payload's copy; /ok pins one to this project" >&2
fi

action="${1:-check}"
case "$action" in
  save)
    node "$bin" budget save .
    ;;
  check)
    node "$bin" budget check .
    ;;
  *)
    echo "usage: /budget [save|check]" >&2
    exit 1
    ;;
esac
```

## After the script runs

- **Below baseline:** propose committing the new lower baseline with `/budget save`. The ratchet is one-way; once committed, future increases fail CI.
- **At baseline:** no action needed.
- **Above baseline:** the lint has already exited 2; the change introduced new violations. Investigate which (the script breaks down by check code), propose fixes, or surface the design decision. Do not offer `save` as a way out — it refuses, by design.

<!-- Materialized by ok-plumbline v18.4.1 — suite-owned; overwritten on converge; do not hand-edit. -->
