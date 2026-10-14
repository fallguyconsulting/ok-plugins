# Queue-Driven Execution — Design Sketch

**Date:** 2026-09-02
**Status:** Sketch (not a sprint; not authorization to build)

## Idea

Replace the standing-agent team that executes a sprint with a queue of
small work items and a series of fresh agents that drain it one at a
time. The queue is an append-only JSONL issue tracker kept as a sprint
sidecar. The planner seeds it. Builders, reviewers, and fixers each
take the head item, do it inside one bounded context, file what they
find, and stop. Certification is one more set of items the orchestrator
files when the build items are gone. The run ends when the queue is
empty, and the completion report and certification presentation are
rendered from the queue.

The current shape stands agents across a sprint and relays work to them
by message. Measurement of one sprint execution on a consumer project
showed why that costs more than it returns:

- Every relay to a standing subagent or teammate rewrote that agent's
  whole context. A resumed subagent rebuilds its history from the
  transcript, drops the system reminders attached to earlier tool
  results, and changes its tool list; a teammate moves its transient
  reminders from the first message to the newest. Either way the cache
  prefix diverges at the first message and the whole conversation is
  re-written. Full rewrites were 17% of the run's weighted cost.
- Builders were never restarted after review. Findings reached the next
  stage's builder mid-turn, so each builder ran until its stage was
  done, finishing between 300k and 400k of context. About half of every
  builder's growth was its own thinking. Cache reads at that size were
  66% of the run's cost.
- Project startup context was under 1% of the cost. Cold starts are
  cheap; long contexts and relays are not.

An agent cannot see its own context size, so a per-agent cap needs an
outside enforcer. Compaction is session-wide and its prompt is fixed, so
it cannot be tuned per role. The lever left is the size of the work
item. This sketch makes every item fit under about 160k of context and
makes handoff a file, not a message.

## Shape

**1. The queue is a sprint sidecar.** The record is
`.ok-planner/sprints/<sprint>-queue.jsonl`: one JSON object per line,
each line the full state of one item, the latest line per id winning.
It is appended only, committed with the sprint, and archived with it to
`history/sprints/`. A derived SQLite file at
`.ok-planner/.cache/<sprint>.sqlite` is rebuilt whenever the JSONL is
newer and is git-ignored. One script, `.ok-planner/bin/queue`,
materialized by `/ok`, owns both files and exposes five verbs:

| verb | who calls it | what it does |
|---|---|---|
| `next` | orchestrator | prints the head item's id, kind, model, and effort; or `empty`; or `blocked` |
| `claim` | agent | marks the head item `running`, records the caller, prints the item |
| `close <id> --outcome <done\|partial\|blocked>` | agent, orchestrator | appends the closing line with a one-line result and the staged paths |
| `file` | agent, orchestrator | appends a new open item with `origin` set to the filer |
| `report` | orchestrator | renders the completion report and the certification presentation from closed items |

The head is the lowest-`seq` open item whose `after` list is all
closed. `blocked` means the head's dependency closed `blocked` and
nothing can file past it.

**2. The item is one brief a fresh agent finishes under 160k.**

| field | holds |
|---|---|
| `id`, `seq` | stable id; drain order |
| `kind` | `plan`, `build`, `review`, `fix`, `suite`, `lint`, `gate-review`, `judge`, `fork`, `architect` |
| `model`, `effort` | what the orchestrator spawns: sonnet for reads, opus for edits |
| `title`, `brief` | the task, including what done means |
| `files` | the paths the agent may read and edit, and the test modules it runs |
| `cites` | the sprint work item and the corpus slugs the brief realizes |
| `after` | item ids that must close first |
| `origin` | the planner, or the agent and item that filed it |
| `state`, `outcome` | `open`/`running`/`closed`; `done`/`partial`/`blocked` |
| `result` | one line of what changed, staged paths, ids of items filed |
| `usage` | context peak and request count, stamped by the orchestrator from the completion notification |
| `round` | on gate producers: the certification round that filed them |

Sizing rule, from the measured run: thinking matched tool traffic
about one to one, so a 160k cap minus a 25k start leaves about 65k of
tool traffic. That is roughly 40k of file reads, eight to ten source
files of ordinary length, and 25k of test and lint output. The planner
enforces it through `files`: a `build` item names at most that many
files and one or two test modules. A work item that needs more becomes
several `build` items in sequence. The stamped `usage` on closed items
checks the sizing after every run.

**3. Kinds and who files them.**

- The planner turns each sprint work item into one `plan` item. A
  `plan` agent (sonnet) reads the work item and the corpus, searches
  the code, and closes by filing `build` items with briefs and file
  lists, a `suite` item after them, and a `review` item after that.
- A `build` agent (opus) edits within its files, runs its targeted
  tests and lint, stages its paths by name, and closes.
- A `suite` item is run by the orchestrator, never an agent; it closes
  with the failure list and files a `fix` per failure.
- A `review` agent (opus) reads the staged paths of the builds it
  follows and closes by filing one `fix` per finding, each `after` the
  build it faults, with the finding as the brief. It applies the
  gate's own code-review brief and each family's standing producers.
- A `fix` agent is a build whose brief is a finding.

**Report, never fix.** Any agent that meets a defect outside its files
files a `fix` and keeps going. Any agent that meets a question the
corpus does not answer files an intake issue and keeps going. This
replaces "fix every bug" in the current builder brief. A builder that
reaches its cap closes `partial` and files the remainder as a new
`build` with the same files and a brief that says where it stopped.
That is the whole handoff.

**4. One prompt, role from the head.** Every agent in a run receives
the same first message, byte for byte:

```
Run `.ok-planner/bin/queue claim`. It prints the item you own.
Read `.ok-planner/roles/<kind>.md` for the item's kind and follow it.
Work only within the item's files. File an item for anything else.
Run `.ok-planner/bin/queue close <id> --outcome <done|partial|blocked>`
with a one-line result before you stop.
```

The subagent's first user message is the hook context, the skills
listing, the project context, and the prompt, with the cache breakpoint
on the prompt block only. An identical prompt makes that message one
cache entry per model for the whole run. Role bodies live under
`.ok-planner/roles/<kind>.md`, materialized by `/ok`; the
`gate-review`, `fix`, and `architect` bodies are the prompts now
embedded in `_shared/certification-core.md`, moved to files.

The orchestrator's loop:

1. `queue next`.
2. `suite` or `lint`: run it, close it, file the fixes.
3. Any other kind: `Agent(model, effort, prompt)`; wait for the
   completion notification; stamp `usage` on the item.
4. `empty` after the build items: file a certification round (5).
   `empty` after a round that filed nothing: `queue report`, stop.
   `blocked`: stop and surface to the owner.

Drain is serial. One agent runs at a time, so `claim` and `next` name
the same item, and the gap between one agent's last request and the
next agent's first is one orchestrator turn, under the five-minute
subagent cache lifetime. The orchestrator never sends a message to a
running agent.

The cap lives in a hook. A `PostToolUse` hook, wired on consent beside
the model hook, reads the subagent's transcript at
`<dirname(transcript_path)>/<session_id>/subagents/agent-<agent_id>.jsonl`,
takes the last request's cache read plus cache creation plus input,
and when that passes 160k blocks the call with one instruction: close
`partial` now and file the remainder.

**5. Certification is a round of items.** When `next` first prints
`empty`, the orchestrator files:

| item | runs as | closes by |
|---|---|---|
| `suite` at full scope | orchestrator | a `fix` per failure |
| `lint` and each family's declared producers | orchestrator | a `fix` per violation |
| `gate-review` over the whole diff | fresh opus agent, cold | a `fix` per finding |
| `judge` against the completion contract | fresh opus agent | a `fix` per divergence, or a `fork` where code and sprint disagree on intent |
| `architect`, one per `fork`, `after` it | fresh opus agent | a `fix`, or an intake issue and `blocked` |

The fixes drain serially. When they are gone, the orchestrator files
the next round if any item closed `done` with staged paths since the
round was filed; the next `gate-review` brief lists those paths, which
is the scoped re-examination the current gate delivers by message. A
round that files no fixes ends the gate. `round` on each producer gives
the thrash cap: at the cap the orchestrator closes every open `fix` as
`blocked` and files each as an intake issue. The judge reads the
sprint's completion contract and the closed items' results, not a
completion report, since the report does not exist until close-out.

**6. Close-out is a render.** `queue report` writes the completion
report (per work item: its plan item, its builds with outcomes and
staged paths, the fixes filed against it; `partial` and `blocked`
closes as the divergences section; architect-filed issues as the
claimed forks) and the certification presentation (per round: the
producers, the fixes, what they changed; the round that filed nothing
is the pass). It adds one section the current report lacks: usage per
item. The queue file archives with the sprint; the SQLite cache is
discarded; commit stays on the owner's word.

**7. Placement.** One new skill in ok-planner, `/drain`, beside
`/certify-work` and the sprint boilerplate, which stay as they are. The
owner picks the executor at kick-off: the sprint's own execution
section runs the current team, `/goal /drain <sprint>` runs the queue.
The skill brings `bin/queue`, `roles/`, the cap hook, and one paragraph
in the planner's `CLAUDE.md` naming the queue as a sprint sidecar. It
replaces the current shape when one sprint drains end to end with every
item's stamped usage under the cap and the run's weighted cost under
the measured baseline of 64.1M weighted tokens.

## Open questions

- Whether the planner ceremony writes `plan` items directly, or the
  orchestrator seeds one `plan` item per sprint work item at kick-off.
  The sketch assumes the orchestrator seeds, so the sprint document
  does not change.
- Whether `review` items run per build or per group of builds. The
  sketch assumes the `plan` agent decides, filing one `review` after a
  `suite`.
- The cap number. 160k is taken from the measured run; the stamped
  `usage` column is meant to tune it.
- Whether `claim` should take an id from the orchestrator instead of
  the head. The sketch keeps the prompt id-free so it stays identical.
- How the `judge` reads the completion contract without the report:
  the sketch assumes the closed items' `result` lines are enough.
- Where a `plan` agent's own thinking budget lands: a sonnet read of
  the corpus plus a search may itself approach the cap on a large work
  item.
- Whether `lint` at full scope belongs in every round or only the
  first.

## Risks / unknowns

- A `partial` close that files a bad remainder brief loses work the
  same way a bad handoff document does. The staged paths are the only
  durable record; the remainder brief must say what is staged and
  what is not.
- Serial drain forgoes the parallelism the current gate uses for its
  producers. On the measured run the producers were not where the cost
  was, but wall clock will grow.
- The cap hook reads a transcript path the harness provides in hook
  input today; that is an observed field, not a documented contract.
- A fix agent that cannot reproduce a finding has no way to dispute it
  except closing `blocked`, which reaches the owner. The current
  architect step judged forks in-loop; here a disputed finding costs a
  round.
- The five-minute subagent cache lifetime holds only while the
  orchestrator turn between agents is short. A `suite` item that runs
  longer than five minutes cools the cache for the next agent.
- Two models mean two cache prefixes. Alternating sonnet and opus
  items lets both go cold; ordering same-model items together is a
  planner concern the sketch does not settle.

## What this is not

- Not a change to `/plan-sprint`, the sprint document, or the
  completion contract. The queue is derived from the sprint.
- Not compaction. No agent is compacted; it closes and another starts.
- Not a parallel executor. Serial drain is the design, not a first
  version.
- Not a replacement for `/audit`. The gate round is change-scoped, as
  `/certify-work` is today.
- Not the retirement of the current team shape. Both stand until one
  sprint proves the queue.
