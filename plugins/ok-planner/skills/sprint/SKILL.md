---
name: sprint
description: "ONLY activated by explicit /sprint slash command. Never auto-triggered by conversation content."
---

# Sprint Planning

The planning ceremony. An interactive session with the project owner that produces a **sprint backlog**: a change-order against the design corpus, expressed as final-form artifact deltas plus the work items that realize them, terminated by a fixed completion contract.

**The artifact is a backlog, not a theme.** It is the sprint backlog in the scrum sense: a collection of potentially disparate changes — a concept clarified here, a new story there, an unrelated decision retired — with no required unifying focus. Do not manufacture a narrative to hold unrelated items together, and do not batch, stage, or phase the work items. Grouping the backlog into sensible stages and ordering them is planning that belongs to **execution**, done by whoever executes the spec at the time they execute it. This session's job is to get the right items into the backlog, each stated well enough to be picked up cold.

The implementation itself happens elsewhere — inline in an ordinary working session, or by an orchestrator that consumes the backlog. Either way this skill never hands off to a planning or execution pipeline.

Two things share the word "backlog" in scrum and must not be confused here: the **intake queue** (`issues.jsonl`) is where questions accumulate; the **sprint backlog** is what this session commits to. Issues move from the first to the second by promotion, and that is a one-way trip.

Read `skills/_shared/artifact-definitions.md` before authoring anything. Every delta this skill drafts must already comply with the canonical artifact rules — the sign-off review below checks exactly that.

## Process

### 0. True up

Invoke `ok-planner:true-up` so the layout and the issue queue exist.

### 1. Frame the session

Fold `.ok-planner/issues.jsonl` by `id` (an `open` row with no later terminal row — `promote`, `retire`, or a legacy `resolve` — for the same id is open) and note how many issues are open — do **not** present them yet.

Then establish what kind of sprint this is, from the owner's opening ask. If it is not clear, ask, in one prose question:

- **Queue-drain sprint** — the owner's purpose *is* working the intake queue: all of it, or a batch they name. The queue is the agenda. Run **§4 the issue walk** now over that scope, then §2 (thin — the resolutions largely are the intake) and §3, drafting the backlog from what the resolutions imply.
- **Feature-work sprint** — the default. The owner brings work they want taken on. The queue is **not** the agenda and is not opened here: go to §2 → §3, and consult the queue at §4 against the drafted work.

Tell the owner the open-issue count either way ("7 open issues; I'll check which of them bear on this work once we've drafted it"). The count is information, not a gate — the owner may always widen scope to the whole queue.

### 2. Intake dialogue

Discuss what this sprint should take on. The owner brings goals; you bring the corpus (read `design/` freely — it is source of truth). Ask questions in prose; surface every tradeoff explicitly — never resolve one silently on the owner's behalf. When spec content implies a story- or decision-intent change, run the proof dialogue gate from `{{PROOF-PROTECTION-RULE}}`: preserve the intent / shift the intent / remove the artifact — the owner picks, never you.

### 3. Draft the sprint backlog

Write to `.ok-planner/backlogs/YYYY-MM-DD-<slug>.md`:

```markdown
# Sprint backlog: <title>

## Intent

<What this sprint is for, in a few sentences. A sprint with no single
theme says so plainly — do not invent one. List the ids of the issues
promoted into this backlog, if any.>

## Corpus deltas

<The substantive body. Each delta is a FINAL-FORM artifact body — a
complete concept / story / decision file content per the templates in
`skills/_shared/artifact-definitions.md` — under a heading naming the
operation and target:>

### New story: <slug>
### Amend concept: <slug>
### Retire decision: <slug>

<Applying a delta IS updating the corpus: the implementer copies the
final form into place (or deletes, for retirements). No summarized or
partial deltas — if the artifact changes, its full new body appears here.>

## Work items

<The implementation units that realize the deltas — a flat, unordered
list. Each names the stories/decisions it makes true (by slug) and
describes the outcome, not the method. Real dependencies between items
are stated as such; do NOT group items into stages, phases, or themes,
and do not impose an order that is merely tidy. Sequencing is the
executor's job.>

## Completion contract

The work is not done until all of the following hold:

1. The design corpus matches every delta above (applied verbatim).
2. `/prove` returns clean over all new and touched stories and
   decisions: every proof present, passing, and non-vacuous.
3. `/audit` has been run last: mechanical findings fixed in-cycle;
   judgment findings filed to `.ok-planner/issues.jsonl` for the next
   sprint.
```

The completion contract section is fixed boilerplate — include it verbatim in every sprint backlog. It is the stop condition for whoever executes the backlog (an inline session or an orchestrator), not advice.

**The backlog is self-sufficient.** Once written, it is the source of truth for execution: everything the work needs is in it, in final form. An executing agent never reads the issue queue to find out what a promoted issue "really meant" — if a resolution's substance is not in the deltas or the work items, it is not in the sprint. Write accordingly.

### 4. The intake queue

`issues.jsonl` is **intake**: a holding area for questions waiting to reach a backlog. This session is the only place issues leave it, and they leave in one of two ways — **promoted** into this sprint's backlog, or **retired** at the owner's word. Nothing else happens to an issue here; the queue is not a work tracker and holds no status beyond open / gone.

Open issues matter to this sprint for exactly one reason: **building over an open issue decides it silently.** An issue whose answer the drafted work would encode by default must be resolved by the owner first. An issue the work neither touches nor presumes an answer to is not this sprint's business and stays queued.

So the walk is scoped:

- **Queue-drain sprint** — scope is the whole queue (or the batch the owner named). No relevance pass; go straight to the walk.
- **Feature-work sprint** — run the relevance pass below over the §3 draft, then walk only the issues it returns as bearing.

#### Relevance pass (feature-work sprints)

Dispatch a dedicated reviewer. It decides bearing-vs-independent; it never resolves anything.

```
Agent (general-purpose):
  ## Issue relevance pass

  ### Your job

  Decide which open design issues bear on a drafted sprint's work.
  You are not resolving them and not proposing resolutions — the
  project owner does that. You are deciding, per issue, whether the
  owner must resolve it BEFORE this work is built.

  ### Inputs

  Draft sprint backlog: [path]
  Open issues (folded from `.ok-planner/issues.jsonl`):
  [the open rows, verbatim JSON, one per line]

  The design corpus at `.ok-planner/design/` is source of truth —
  read it freely. Read the code where an issue's bearing depends on
  what the code actually does.

  ### The test

  An issue BEARS on this sprint if any of these hold:

  - It concerns an artifact the backlog creates, amends, or retires.
  - Building a work item would encode an answer to the open question
    by default — the implementer would have to pick, and the pick
    would stand as the project's answer. (This is the central case.)
  - A plausible resolution of the issue would contradict, invalidate,
    or materially reshape a drafted delta or work item.
  - It concerns a neighbor artifact whose boundary a work item leans
    on — the work is only correct if the boundary falls one way.

  An issue is INDEPENDENT if the drafted work can be built and proved
  without answering it, AND answering it later cannot invalidate
  anything the backlog commits to.

  When you cannot tell, answer BEARS. A needless owner conversation
  costs a minute; a silently decided design question costs a rewrite.

  ### Output format

  Status line first: `Status: N bearing | M independent`.

  Then one line per issue, bearing ones first:

  `<id> — BEARS | INDEPENDENT — <one sentence: which delta or work
  item it touches, or why the work is indifferent to it>`

  ### Anti-padding

  - Do not grade severity or rank issues.
  - Do not propose resolutions, candidates, or corpus deltas.
  - Do not critique the backlog — that is a different review.
  - Do not report on issues not in the list you were given.
```

Report the split to the owner in one line (`4 of 7 open issues bear on this work; walking those now`). The owner may pull an independent one into scope; they never have to.

#### The issue walk

**Before presenting each issue, surface the design corpus that likely bears on it.** An issue can be silently decided against a corpus invariant the walker never consulted — the exact class of failure this step exists to prevent. Run the surfacer on the issue row:

```bash
OK_PLANNER_PROJECT_ROOT="$(pwd)" \
  python3 "${CLAUDE_PLUGIN_ROOT%/}/scripts/surface-corpus" <<'ROW'
<the issue row's JSON verbatim, exactly one line>
ROW
```

The script prints, one per line, the concept / story / decision files that either (a) are explicitly cited in the row's `artifacts[]`, or (b) match distinctive rare tokens from the row's `id` / `summary` / `detail` / `candidates`. Read each surfaced artifact in full — its Invariants, Owns, and Adjacent sections may already resolve the question, retire the row, or reshape the framing entirely. If the script prints nothing, that itself is a signal — an issue with no bearing artifact is either about pure code with no corpus commitment or about a concept the row failed to name; flag it to the owner rather than proceeding blind.

Only then walk the in-scope issues with the owner **one at a time** (never as a wall): present the issue's summary, detail, and candidates, plus a one-sentence note on what the surfaced corpus says (`concept:X invariant N says the answer is Y — likely a retire`; `concept:X owns this vocabulary but the invariant is silent on the question`; etc.); the owner picks one of two outcomes.

**Promote** — the owner decides the answer (one of the candidates, or a shape of their own). Carry the substance into the backlog *now*, in final form: as a corpus delta, a work item, or both. On a feature-work sprint that means amending the §3 draft, including where the resolution collides with a delta already drafted; on a queue-drain sprint these resolutions are the material §3 drafts from. What lands in the backlog is the whole of the resolution — the issue row is a receipt, not a companion document.

**Retire** — the owner drops the question ("won't fix", "not real anymore", "already answered"). Nothing is carried into the backlog. Append the `retire` row immediately, with the owner's reason.

Write the queue rows per `{{ISSUE-QUEUE-FORMAT}}` in the shared definitions, appending with `>>` via Bash, timestamping with `date -u +%Y-%m-%dT%H:%M:%SZ`. Only this session writes terminal rows.

**Timing: `retire` rows go in during the walk; `promote` rows go in at §6, after sign-off.** A promotion is a handoff to a backlog, so it is only true once that backlog exists in approved final form — writing promote rows mid-walk would empty the queue into a document the owner might still reject or reshape. A retirement is unconditional and is recorded on the spot. If the session dies before sign-off, the promoted-in-spirit issues are still open, which is the correct state.

Issues left out of scope are left strictly alone: no rows, no editorializing, no summary prose about them in the backlog. They stay in the queue for a later sprint.

An empty queue, or a relevance pass that returns nothing bearing, passes silently.

### 5. Sign-off review

Before the owner signs off, dispatch the compliance reviewer from `skills/_shared/design-doc-compliance-reviewer.md` in **draft mode**, scoped to the backlog's corpus deltas plus any live artifacts they amend. Fix mechanical findings in the draft directly. Walk judgment findings with the owner now — this is the first of the two review opportunities, and a judgment finding resolved here never becomes an issue row. Re-dispatch until clean.

Then present the backlog to the owner for sign-off. It is not final until they approve.

### 6. Terminal

Once the owner approves:

1. **Record the promotions.** For each issue promoted during §4, append a `promote` row naming the resolution and this backlog's filename in the `backlog` field. One Bash append for all of them, `>>`, so the queue is durable even if the session ends here. Every promoted id should also appear in the backlog's `## Intent` list — that is the same fact from the other side.
2. **Stop.** The approved backlog at `.ok-planner/backlogs/YYYY-MM-DD-<slug>.md` is this skill's terminal artifact. Executing it is a separate act, and this skill does not begin it: do not implement, do not invoke further skills, do not write plans. How execution works — inline in a working session or via an orchestrator, with sequencing decided then — is described in `.ok-planner/CLAUDE.md`.

## What this skill does NOT do

- Does not implement work items or mutate code.
- Does not mutate `design/` directly — corpus changes ride the backlog's deltas and are applied by the implementer.
- Does not stage, phase, or theme the work items — sequencing is execution's job, decided at execution time.
- Does not march the owner through the whole intake queue on a feature-work sprint; only issues that bear on the drafted work are walked.
- Does not terminate issues without the owner (every `promote` and `retire` is an owner decision made in-session).
- Does not re-open, revisit, or report on issues already promoted by an earlier sprint. They are settled; their backlog owns them. A problem with what a past backlog decided is a new issue with a new id.
- Does not leave a promoted issue's substance in the queue — the backlog carries the whole resolution, and the row is only a receipt.
- Does not defer its own open questions silently — a question the owner explicitly postpones is appended to `issues.jsonl` as an `open` row with `kind: "sprint"`.
