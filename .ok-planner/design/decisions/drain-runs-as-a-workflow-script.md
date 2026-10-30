---
decision: drain-runs-as-a-workflow-script
---

# The drain runs as a Workflow script where the harness offers one

## Choice

Where the harness offers a workflow tool, the drain runs as a Workflow
script the session starts once per drain. The script starts each task agent through the harness, under its profile and the one fixed message, and
returns when the tracker holds nothing more it can run, when a task agent
returns without closing a task the tracker still lists, or as it nears
the harness's lifetime cap on agents, when the session starts it
again. The session wakes once per drain and acts on what the script
returns. Where the harness offers none, the session runs the drain
itself and wakes on each agent's return. The script runs what the
tracker holds and plans and judges nothing.

## Rationale

A session that starts each agent itself wakes on every return, and
each wake rereads its whole context, so a run of hundreds of tasks
fills and compacts the session though agents do the work. On one
project the session's context reached 967,000 tokens and compacted
three times within its first 370 tasks. A Workflow script removes those
wakes and keeps dispatch inside the harness, so the profiles, the one
cached prefix per profile, and the model hook on the Workflow call
still apply (see also: subagent-model-follows-job). The script runs
what the tracker holds and plans and judges nothing, so it stays a
drain, not an engine (see also: no-execution-engine).

## Alternatives

- A background process that starts agents outside the harness and wakes the session only for a judgment or the end — no wakes, and the profiles, the shared prefix, and the model hook stop applying.
- One coordinating agent per stage that drains it and returns a summary — an agent that starts agents, which the model rule forbids.
- The session runs every drain itself on every harness — one wake per agent return, each rereading the session's whole context.
