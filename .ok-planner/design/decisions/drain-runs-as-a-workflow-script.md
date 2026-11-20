---
decision: drain-runs-as-a-workflow-script
---

# The drain runs as a Workflow script where the harness offers one

## Choice

Where the harness offers a workflow tool, the drain runs as a Workflow
script the session starts once per drain. The harness runs a Workflow
script only on the owner's opt-in, so the goal line planning hands
over carries that opt-in in words the owner types. The script starts each task agent through the harness, under its profile and the one fixed message, and
returns when the tracker holds nothing more it can run, when a task agent
returns without closing a task the tracker still lists, or as it nears
the harness's lifetime cap on agents, when the session starts it
again. The harness gives a Workflow script no shell, so the script
runs each tracker command through an agent it starts for that one
command. A task agent's last act is `tasks close`, which prints the
work the tracker then holds, as `tasks next` would print it, and the
agent's final text is that output. The script reads the next work
from each task agent's return and starts the agents it names. It runs
`tasks next` through an agent only for a drain's first fill and after
a return that carries no `closed` line. The session wakes once per drain and acts on what the script
returns. Where the harness offers none, or the owner has not opted
in, the session runs the drain itself, wakes on each agent's return,
and reads the same lines from it. The script starts an agent
for each task the tracker issues, and leaves each outcome for the
session to read.

## Rationale

A session that starts each agent itself wakes on every return, and
each wake rereads its whole context, so a run of hundreds of tasks
fills and compacts the session though agents do the work. On one
project the session's context reached 967,000 tokens and compacted
three times within its first 370 tasks. A Workflow script removes those
wakes and keeps dispatch inside the harness, so the profiles, the one
cached prefix per profile, and the model hook on the Workflow call
still apply (see also: subagent-model-follows-job). The script starts
an agent for each task the tracker issues, and leaves each outcome for
the session to read, so it stays a drain, not an engine (see also: no-execution-engine).

The opt-in rides the goal line because the harness takes it only from
the owner's own words, and a run under a goal has no owner to ask. On
one project, the session read no opt-in in a goal line that named only
the sprint, and drained every task by hand. Every command the script
runs costs an agent, and each agent counts against the harness's
lifetime cap and adds a request. A close that prints the next work
spends no agent on reading it, so a drain runs one agent per task,
save its first fill and a return the script cannot read.

## Alternatives

- A background process that starts agents outside the harness and wakes the session only for a judgment or the end — no wakes, and the profiles, the shared prefix, and the model hook stop applying.
- One coordinating agent per stage that drains it and returns a summary — an agent that starts agents, which the model rule forbids.
- The session runs every drain itself on every harness — one wake per agent return, each rereading the session's whole context.
- A goal line that names only the sprint — the owner types less, and a session that reads no opt-in in it drains by hand.
- Ask the owner for the opt-in when the first drain starts — the run stops on a question while the owner may be away.
- An agent that runs `tasks next` after every return — the script reads the tracker afresh each time, and each task costs a second agent against the lifetime cap.
