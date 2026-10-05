---
issue: review-backlog-aborts-after-partial-writes
kind: audit
category: defect
artifacts: []
status: verified
triage: defect
opened: 2026-10-05T10:03:49Z
---

# `review backlog` adds the reports of earlier issues to the ledger, then aborts on an issue whose Problem names no file

## Problem

The site is `plugins/ok/families/ok-planner/scripts/review:cmd_backlog`. Entry A1 covers it: stored state can end half-changed. An error between two steps of one change leaves stored state that no complete run would produce.

Trigger: the intake holds two open or verified `category: defect` issues. The first, in sorted file order, names a file of the tree in its Problem. The second names no file of the tree outside the exclude list.

Harm: the loop adds the first issue's report to the run's ledger, then raises on the second issue. The ledger keeps the first report, and the verb never prints the JSON that tells the session which reports landed. A rerun of the verb in the same ledger, after the owner repairs the second issue, adds the first report a second time.

Evidence, from the code as it stands:

- `plugins/ok/families/ok-planner/scripts/review:949-955`: each iteration writes to the ledger as it goes, `item = tasks_run(root, "item", "add", "--pool", "reports", ...)`.
- `plugins/ok/families/ok-planner/scripts/review:942-944`: a later iteration raises inside the same loop, `if not files and not alone: raise ReviewError("%s names no file of this tree outside %s's exclude list in its Problem" ...)`.
- `plugins/ok/families/ok-planner/scripts/review:956`: the result prints only after the loop ends, `print(json.dumps({"reports": added, "settled": settled}, indent=1))`.

## Ruling

> Generated ruling (/triage-issues): fix `plugins/ok/families/ok-planner/scripts/review:cmd_backlog` so an issue whose Problem names no file no longer leaves earlier reports in the ledger with no result printed.
