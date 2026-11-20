---
decision: drain-fills-every-free-slot
---

# The drain fills every free slot on each return

## Choice

After each agent returns, the drain starts one fresh agent per task
the lines it reads list as waiting, up to its concurrency cap less
the agents in flight. It counts each agent it started that has not
yet claimed a task against the waiting tasks of that agent's profile,
so no task gets two agents. The tracker's line for each profile names
how many of that profile's tasks agents hold, and the agents of the
profile in flight beyond that count have not yet claimed. The
Workflow script and the hand loop both fill this way (see also:
drain-runs-as-a-workflow-script).

## Rationale

A sprint's build tasks wait on the stages they build on, so a drain's
first call often finds one ready task. A drain that starts one agent
per return after its first fill never runs more agents than that
first fill, and stages that become ready later with disjoint files
wait in line, though the suite promises they run together (see also:
build-task-per-stage). On one project a sprint's first call found
one ready stage, and a later stage with disjoint files waited 32
minutes behind the one running agent.

The tracker counts a task that is issued and not yet claimed on every
line it prints, until an agent claims it. A drain that started one
agent per listed task would start a second agent for a task whose
first agent had not yet claimed it. The second agent claims nothing,
returns, and counts against the Workflow tool's lifetime cap on
agents. Counting the agents in flight that hold no task stops that.
Counting every agent in flight against its profile's listing would
count an agent that holds its task twice, since the listing leaves
out a task an agent holds, and the window would narrow.

## Alternatives

- One agent in for one agent out after the first fill — the count running never exceeds the first fill.
- One agent per listed task, with no count of unclaimed agents — a task issued and not yet claimed gets a second agent, which claims nothing.
- Every agent in flight counted against its profile's listing — an agent that holds its task is counted twice, and the window narrows.
- A `tasks next` call before every fill — the Workflow script spends a second agent per return against the lifetime cap.
