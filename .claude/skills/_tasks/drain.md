# Drain the tracker

The drain loop over the task tracker at `.ok-planner/bin/tasks`. The tracker is the record of one run: tasks an orchestrator filed, items agents filed into keyed pools, and the events between them. This loop runs what the tracker holds and files nothing into it. Whoever filed the tasks decides what runs; this loop decides nothing. Until a ceremony files runs of its own, a run is built by hand with the tracker's verbs: `init`, `agent register`, `prompt register`, `file`, and `item add`.

**The reason this loop exists is the prompt cache.** Every agent this loop dispatches is one of the vendored profiles under `.claude/agents/`. A profile's frontmatter pins the model and the effort, and its body is the claim protocol: the agent runs `tasks claim --agent <profile>`, which takes the oldest issued task filed for its profile under the run's lock and hands it that task's id, its registered prompt, its brief, and the pool items it consumes, and refuses a task filed for another profile. Every agent of one profile receives one identical first message that names no task, so the whole first request, the system prompt and the message together, is one cached prefix per profile per run: the first agent writes it and every later agent of the profile reads it. A message that differed by a task id would sit before the cache checkpoint and make every agent rewrite the prefix. The id reaches the agent through the claim's output instead, after the prefix. The claim is atomic, so two agents started together never take one task.

**The concurrency cap** is the number of agents this loop runs at once, across every profile: **8** unless the caller names another when it invokes the loop. Every dispatch and every tool call an agent makes is a permission request the harness classifies one at a time, and a larger batch overloads it.

## Preconditions

- `.ok-planner/bin/tasks` exists, and so do the profiles under `.claude/agents/`. Without either, say so and stop; materialization is the front door's administration (`/ok`).
- A run is selected. `tasks status` prints the run's name and file; if it fails with "no run selected", the caller names the file with `tasks use <path>` before invoking this loop. This loop never runs `tasks init`.

## Two forms

The loop has two forms, and both run the same steps on the same lines `next` prints. Where the harness offers the Workflow tool, the session runs the drain as the Workflow script below: it starts the script once per drain and wakes when the script returns. Where the harness offers no Workflow tool, the session runs the loop by hand, as "The loop" says, and wakes on each agent's return.

## The Workflow form

**Starting it.** On the session's first drain, call `Workflow` with the script below as `script`, copied from the fenced block whole. The tool result names the `scriptPath` of the copy it persisted and the run's `runId`. On every later drain of the session, call `Workflow` with that `scriptPath` and no `script`. Every call passes `args` as a JSON object, never as a string: `{"root": "<the project root, absolute>", "cap": <the caller's cap, or 8>}`. Never pass `resumeFromRunId`: a resumed run replays cached `next` outputs that no longer match the tracker.

**The script.** It runs each tracker command through a step agent, since a Workflow script has no shell. It starts each task agent under the profile and the model its `run` line names, with the fixed message as its whole prompt and a label unique within the drain. The first `next` fills the window up to the cap; after that, each return leads to one `next`, and the script starts at most one fresh agent for it. It returns `done` on `done`; `waiting` on a `waiting` line with nothing in flight and no `fork-of` task listed; `stuck` where a task agent returned without a `closed` line, `next` still lists the count it listed when that agent started, and no agent of that profile runs; `paused` once it has started 950 agents, a margin of 50 below the Workflow tool's lifetime cap of 1000; and `failed` where a tracker command exits nonzero or prints no line the script reads. It waits for every agent still in flight before it returns.

```js
export const meta = {
  name: 'ok-drain',
  description: 'Drain the task tracker: one fresh agent per issued task under its profile, up to the cap, until the tracker holds nothing more to run',
}

const ROOT = args.root
const CAP = args.cap || 8
const LIFETIME = 950
const MESSAGE = 'Claim your task and finish it.'
const STEP_SCHEMA = {
  type: 'object',
  properties: {output: {type: 'string'}, exit: {type: 'integer'}},
  required: ['output', 'exit'],
}
const CLOSED_LINE = /closed\s+(\S+)\s+(done|partial|blocked|disputed)/

const inFlight = new Map()
const closed = []
let started = 0
let taskAgents = 0
let unclosed = 0
let serial = 0
let lastNext = ''

function track(entry, promise) {
  const key = serial
  serial += 1
  const settled = promise.then(result => ({key, result}), () => ({key, result: null}))
  inFlight.set(key, Object.assign({key, promise: settled}, entry))
}

async function step(command, timeout) {
  started += 1
  const wait = timeout ? ' Give that Bash call a timeout of ' + timeout + ' ms.' : ''
  const result = await agent(
    'Run exactly this one command with the Bash tool, and nothing else: cd "' + ROOT + '" && .ok-planner/bin/tasks ' + command + '.' + wait +
    ' Return its whole output, stdout then stderr, verbatim as output, and its exit code as exit. Add no comment.',
    {model: 'haiku', effort: 'low', schema: STEP_SCHEMA, label: 'tasks ' + command.split(' ')[0]})
  return result || {output: '', exit: -1}
}

function parse(text) {
  const parsed = {runs: [], execs: [], waiting: null, done: false}
  for (const line of text.split('\n')) {
    const words = line.trim().split(/\s+/)
    if (words[0] === 'run') {
      const fields = Object.fromEntries(words.slice(2).map(word => word.split('=')))
      parsed.runs.push({profile: words[1], model: fields.model, count: Number(fields.count)})
    }
    if (words[0] === 'exec') parsed.execs.push(words[1])
    if (words[0] === 'waiting') {
      const at = words.indexOf('fork-of')
      parsed.waiting = {forks: at < 0 ? [] : words.slice(at + 1).map(word => word.split('=')[0])}
    }
    if (words[0] === 'done') parsed.done = true
  }
  const read = parsed.runs.length || parsed.execs.length || parsed.waiting || parsed.done
  return read ? parsed : null
}

async function next() {
  const result = await step('next')
  lastNext = result.output.trim()
  return result.exit === 0 ? parse(lastNext) : null
}

async function retry(tasks) {
  for (const task of tasks) {
    const result = await step('retry ' + task)
    if (result.exit !== 0) {
      lastNext = result.output.trim()
      return false
    }
  }
  return true
}

function countFor(parsed, profile) {
  const line = parsed.runs.find(run => run.profile === profile)
  return line ? line.count : 0
}

function running(kind, name) {
  return [...inFlight.values()].some(entry => entry.kind === kind && entry.name === name)
}

function startTask(run, parsed) {
  started += 1
  taskAgents += 1
  const label = run.profile + '-' + taskAgents
  const entry = {kind: 'task', name: run.profile, label, seen: countFor(parsed, run.profile)}
  track(entry, agent(MESSAGE, {agentType: run.profile, model: run.model, label}))
}

function startExec(task) {
  track({kind: 'exec', name: task}, step('exec ' + task, 600000))
}

function fill(parsed, slots) {
  let left = slots
  for (const task of parsed.execs) {
    if (left > 0 && !running('exec', task)) {
      startExec(task)
      left -= 1
    }
  }
  for (const run of parsed.runs) {
    for (let n = 0; n < run.count && left > 0; n += 1) {
      startTask(run, parsed)
      left -= 1
    }
  }
}

function record(entry, result) {
  if (entry.kind !== 'task') return false
  const match = typeof result === 'string' ? result.match(CLOSED_LINE) : null
  if (!match) {
    unclosed += 1
    return false
  }
  closed.push({label: entry.label, task: match[1], outcome: match[2]})
  return true
}

async function collect() {
  const {key, result} = await Promise.race([...inFlight.values()].map(entry => entry.promise))
  const entry = inFlight.get(key)
  inFlight.delete(key)
  return {entry, closed: record(entry, result)}
}

function stuck(parsed, returned) {
  if (!returned || returned.closed || returned.entry.kind !== 'task') return false
  const count = countFor(parsed, returned.entry.name)
  return count > 0 && count === returned.entry.seen && !running('task', returned.entry.name)
}

async function drain() {
  let parsed = await next()
  let returned = null
  while (parsed) {
    if (parsed.done) return 'done'
    if (stuck(parsed, returned)) return 'stuck'
    if (started >= LIFETIME) return 'paused'
    if (parsed.waiting && inFlight.size === 0) {
      if (!parsed.waiting.forks.length) return 'waiting'
      if (!(await retry(parsed.waiting.forks))) return 'failed'
      parsed = await next()
      returned = null
      continue
    }
    if (!parsed.waiting) fill(parsed, returned ? Math.min(1, CAP - inFlight.size) : CAP - inFlight.size)
    returned = await collect()
    parsed = await next()
  }
  return 'failed'
}

const outcome = await drain()
while (inFlight.size) await collect()
return {outcome, next: lastNext, closed, unclosed}
```

**When it returns.** The return is one object: `outcome`; `next`, the last output a tracker command printed; `closed`, one `{label, task, outcome}` per task agent that returned a `closed` line; and `unclosed`, the count of task agents that returned without one. The session then acts on it:

1. Stamp usage, in one Bash call. The Workflow tool writes a run record for the run, `<the session's folder>/workflows/<runId>.json`. Its `workflowProgress` list holds one entry of `type: workflow_agent` per agent, naming its `label` and its `tokens`. For each `closed` entry, read the `tokens` of the record's entry with the same `label`, and run `.ok-planner/bin/tasks task set <task> --usage <tokens>`. A task whose agent the record gives no token count stays unstamped; name it in the drain's report.
2. Act on `outcome` as the hand form acts on the same line. `done`: the drain is over. `waiting`: nothing the tracker holds is this loop's to run; stop and report the open tasks, reading their ids from `tasks status`; the caller decides. `stuck`: an agent claimed nothing while its task still waits; stop and report it, reading the task ids from `tasks status`; the only move is `tasks retry <task>` on a task left running, then this loop again. `paused`: start the drain again with the `scriptPath`. `failed`: report `next`, the tracker's own output, and stop; a missing profile file names its path there.
3. Where the caller keeps a progress checklist in the harness task tools, mark the entry for each task in `closed` whose outcome is `done` as done, reading each task's key from the `key` column of its row in `tasks report`'s `## Tasks` table. `tasks status` lists only open and retryable tasks, so it never names a task that closed `done`.

## The loop

This is the hand form. Repeat until `next` prints `done`, or prints `waiting` while no agent this loop started still runs and no task is listed under `fork-of`:

1. Run `.ok-planner/bin/tasks next`. It issues every task whose dependencies are closed and prints one line per profile that has issued tasks waiting for an agent, plus one line per ready exec task. A task already issued and not yet claimed is counted again with no second issue; it waits for a free slot, and an agent already started may be about to claim it. A running task is never counted on a `run` line; the tracker leaves it to the agent that claimed it.
2. Act on the lines printed:
   - `run <profile> model=… effort=… count=N` — start `N` fresh agents of the profile, or fewer where the cap leaves fewer slots: `subagent_type` set to the profile's name, `model` set to the `model=` value, and the fixed message below as the whole prompt of every one, no task id anywhere in it. The profile's frontmatter carries the effort. Fill the slots across profiles in the order the lines were printed. Where the cap is smaller than the sum of the counts, the tasks left over wait; the next call counts them again. When an agent returns, its final message is one line, `closed <task> <outcome>`; read the task id from it and run `tasks task set <task> --usage <subagent_tokens>` with the token count the harness reported for that agent.
   - `exec <task> <command>` — run `.ok-planner/bin/tasks exec <task>`. It runs the command from the project root with the tracker unlocked, then closes the task with the exit code and the output tail, and prints both. No usage is stamped; no agent ran.
   - `waiting running=<n> blocked=<n> [fork-of <task>=<root> …]` — every open task is running under an agent or waiting on a dependency: `running` counts the tasks agents hold, and `blocked` counts the rest. A task listed under `fork-of` is a pass task a running root filed for a fork of itself; `next` never issues one and `claim --agent` never takes one, since the fork claims it by id. While an agent this loop started still runs, wait for its return, and go on as step 3 says. When none runs, every task listed under `fork-of` is an orphan its fork never closed: run `tasks retry <task>` on each, which clears the mark, and call `next` again; it issues the task to a fresh agent of the profile, which claims it like any other. Where none runs and no task is listed under `fork-of`, nothing here is this loop's to run: stop and report the open tasks, reading their ids from `tasks status`; the caller decides. A task whose agent died while running is released with `tasks retry <task>`.
   - `done` — no open task remains. Stop.
3. Dispatch every agent of one call in one message so they run concurrently; the caller filed the tasks so that no two ready at once hold one file, and readers run beside anything. The first call fills the slots, up to the cap. After that the window slides, one in for one out: when an agent returns, stamp its task's usage, call `next`, and where it lists a task waiting, start exactly one fresh agent of that task's profile, never more than one per return. The listing never decides how many to start; the return does, so the count running never exceeds the first fill, and a task an in-flight agent is about to claim is counted but not over-dispatched. Where `next` lists nothing waiting, start nothing; the window drains. An agent that returned without a `closed` line claimed nothing or died. Where `next` lists nothing waiting, its claim lost the queue's last task to another agent, which the atomic claim allows: stamp nothing and continue. Where `next` still lists the same count for a profile that as many agents were started for and none of them claimed, stop and report it, reading the task ids from `tasks status`; the only move is `tasks retry <task>` on a task left running, then this loop again. Where the caller keeps a progress checklist in the harness task tools, mark the entry for a task's key in progress when its agent claims it and done when it closes `done`.
4. `tasks item count --pool <pool> [--key K] [--state S]` prints the count and exits 1 when it is zero. A caller's shell loop tests a pool with it; this loop never calls it.

**Every dispatch names its model and its profile.** The model comes from the `model=` field on the line, never from the session, and it equals the profile's own frontmatter, so the harness's precedence rule changes nothing. The profile's claim names the same profile, so an agent can take only a task filed for it. A missing profile file makes `next` fail with the file's path; report that and stop rather than guess.

## The fixed message

Dispatch every agent with exactly this message and nothing else. Do not add the task id, the role, the brief, or any context; the profile's system prompt carries the claim protocol, and the claim prints the rest. One character of difference between two agents' messages is a second cached prefix.

```
Claim your task and finish it.
```

## What this loop does NOT do

These hold for both forms.

- Does not file tasks or items, start rounds, batch, or triage. Those are the caller's calls, made with the tracker's own verbs before or between drains.
- Does not read a task's brief, prompt, or items. The agent that claims the task reads them.
- Does not choose which task an agent takes. The claim takes the oldest issued task for the profile; the caller orders the run by filing order and `--after`.
- Does not judge an outcome. A `partial`, `blocked`, or `disputed` close is recorded for the caller to read from `tasks status` and `tasks report`; the loop moves to the next task.
- Does not retry a task on its own, except an orphaned `fork-of` task per the `waiting` line above. Otherwise it stops and reports.
- Does not initialize, snapshot, or archive a run. The run file belongs to the ceremony that created it.
- Does not true up an estate or materialize the tracker. That is `/ok`, always a user action.

<!-- Materialized by ok-planner v30.0.0 — suite-owned; overwritten on true-up; do not hand-edit. -->
