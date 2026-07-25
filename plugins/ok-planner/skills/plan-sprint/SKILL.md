---
name: plan-sprint
description: "ONLY activated by explicit /plan-sprint slash command. Never auto-triggered by conversation content."
---

# Sprint Planning

The planning ceremony. An interactive session with the project owner that produces a **sprint**: a change-order against the design corpus, expressed as final-form artifact deltas plus the work items that realize them, terminated by a fixed completion contract.

**The artifact is a sprint, not a theme.** It is the sprint in the scrum sense: a collection of potentially disparate changes — a concept clarified here, a new story there, an unrelated decision retired — with no required unifying focus. Do not manufacture a narrative to hold unrelated items together, and do not batch, stage, or phase the work items. Grouping the sprint into sensible stages and ordering them is planning that belongs to **execution**, done by whoever executes the spec at the time they execute it. This session's job is to get the right items into the sprint, each stated well enough to be picked up cold.

The implementation itself happens elsewhere — inline in an ordinary working session, or by an orchestrator that consumes the sprint. Either way this skill never hands off to a planning or execution pipeline.

Two things in this workflow must not be confused: the **issue intake** (`.ok-planner/issues/`, one markdown file per issue) is where questions accumulate; the **sprint** is what this session commits to. Issues move from the first to the second by promotion, and that is a one-way trip.

Read `skills/_shared/artifact-definitions.md` before authoring anything. Every delta this skill drafts must already comply with the canonical artifact rules — the sign-off review below checks exactly that.

## Process

### 0. True up

Invoke `ok-planner:true-up` so the layout and the issue intake exist. If it reports a legacy `issues.jsonl`, invoke `ok-planner:verify-issues` before framing anything — it converts the log into issue files and verifies whatever is unverified.

### 1. Frame the session

Read the intake: every file under `.ok-planner/issues/` with `status: open` or `status: verified` is an open issue (`promoted` and `retired` files are closed, whatever directory they sit in). Split the open set by the `## Ruling` section: **ruled** (non-empty Ruling text) vs **unruled**. Do **not** present the unruled ones yet.

**Pull in the ruled issues first.** A ruling is the owner's decision, already made — this session does not re-open it. For each ruled issue, read the file and carry the ruling's substance into the sprint being drafted (§3) in final form: corpus delta, work item, or both, exactly as if the owner had just decided it live. Do not discuss a ruled issue with the owner **unless the ruling genuinely cannot be understood** — then ask about that one ruling, in prose, and transcribe the clarification. A ruling that amounts to "drop it" is a retirement: record the reason under its Ruling, set `status: retired`, and move the file to `history/issues/` now.

**Generated and recommended rulings ride in the same sweep, named once.** A ruling marked `> Generated ruling (/verify-issues): …` was written because the corpus and its authoring rules determine the resolution; one marked `> Recommended ruling (…): …` (attributed to `/verify-issues`, or to the retired `/recommend-rulings` in older files) is the verifier's judgment call the owner accepted by silence. Carry both like any ruling, but at sign-off name each batch in one line ("3 pulled rulings are generated: <slugs>; 5 are accepted recommendations: <slugs> — say the word to drop any") so nothing unread by the owner is silently absorbed. Never re-discuss them individually unless the owner asks.

Then establish what kind of sprint this is, from the owner's opening ask. If it is not clear, ask, in one prose question:

- **Intake-drain sprint** — the owner's purpose *is* working the issue intake: all of it, or a batch they name. The intake is the agenda. Run **§4 the issue walk** now over that scope, then §2 (thin — the resolutions largely are the intake) and §3, drafting the sprint from what the resolutions imply.
- **Feature-work sprint** — the default. The owner brings work they want taken on. The intake is **not** the agenda beyond the ruled sweep above: go to §2 → §3, and consult the unruled issues at §4 against the drafted work.

Tell the owner the counts either way ("3 ruled issues pulled into this sprint; 7 unruled open — I'll check which of those bear on this work once we've drafted it"). The count is information, not a gate — the owner may always widen scope to the whole intake.

### 2. Intake dialogue

Discuss what this sprint should take on. The owner brings goals; you bring the corpus (read `design/` freely — it is source of truth). Ask questions in prose; surface every tradeoff explicitly — never resolve one silently on the owner's behalf. When spec content implies a story- or decision-intent change, run the proof dialogue gate from `{{PROOF-PROTECTION-RULE}}`: preserve the intent / shift the intent / remove the artifact — the owner picks, never you.

### 3. Draft the sprint

Write to `.ok-planner/sprints/YYYY-MM-DD-<slug>.md`:

```markdown
# Sprint: <title>

## Intent

<What this sprint is for, in a few sentences. A sprint with no single
theme says so plainly — do not invent one. List the ids of the issues
promoted into this sprint, if any.>

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

## How to execute this sprint

This sprint is self-sufficient. Whoever executes it — an inline
working session, an agent this file is handed to via the native
`goal` mechanism, or an orchestrator that does its own planning —
proceeds the same way.

1. Read the sprint whole first — intent, deltas, work items,
   completion contract — before touching anything. Do not go looking
   for context behind it (not in the issue intake under
   `.ok-planner/issues/`, not in `history/`). The sprint is
   self-sufficient by construction; a genuine gap is raised with the
   owner, never filled by inference.

2. Stage the work. The items above are a flat, unordered list; group
   them by theme, file surface, or dependency and order the groups so
   nothing is built on something not yet there. Staging lives in the
   executor's working state — a task list, an orchestrator's graph.
   It is never rewritten into a plan document: this sprint is the
   whole brief.

3. Apply each corpus delta as part of the work that realizes it —
   copy the final-form body into `.ok-planner/design/` verbatim, or
   delete the file for a retirement. A delta no work item implements
   (a clarification, a retirement) is applied on its own.

4. Build stage by stage. Every new or amended story and decision gets
   its proof: present, carrying its `@story:` / `@decision:`
   annotation, and able to actually fail under a producible falsifier.
   Write the proof with the work, not at the end.

5. Completeness is the floor. Never stub, defer, narrow, no-op, or
   leave a `TODO` in place of a promised outcome. A capability the
   deltas or work items promise is delivered in full, or the blocker
   that prevents it is surfaced — never silently dropped.

6. Never destroy uncommitted work. Stage progress as each stage
   finishes (`git add -A`) so a stray revert cannot reach it. Do not
   run `git checkout`/`restore`/`reset`/`stash`/`clean` on your own
   initiative; fix a bad edit forward by editing again.

7. Work unsupervised to a defensible done — no pausing for approval,
   confirmation, or progress checks. Stop only on a genuine blocker:
   a credential or access that cannot be obtained, a step literally
   impossible in the current state, or a destructive/irreversible
   action not clearly authorized. Ambiguity is not a blocker — pick
   the most plausible reading and continue, surfacing the choice at
   the end. (An orchestrator that supervises its own executors folds
   this into its own control.)

8. Close by running `/certify`. It brings the work into alignment
   with this sprint, discharges the completion contract below via
   `/prove` and `/audit`, runs the code-review and
   design-doc-compliance cycles, drives every fixable finding to
   clean through a no-discretion fix loop, and presents outcomes and
   divergences to the owner. The goal is to finish the work: this
   file stays in `sprints/` through the presentation (so a stop
   condition keyed to its path can verify completion against it),
   and `/certify` ends by offering the close-out — archiving this
   sprint and the issue files it resolved to `history/`, and
   committing the work — performed only on the owner's word.

## Completion contract

The work is not done until all of the following hold:

1. The design corpus matches every delta above (applied verbatim).
2. `/prove` returns clean over all new and touched stories and
   decisions: every proof present, passing, and non-vacuous.
3. `/audit` has been run last: mechanical findings fixed in-cycle;
   judgment findings filed to `.ok-planner/issues/` and verified
   ruling-ready for the next sprint.
```

The **How to execute this sprint** and **Completion contract** sections are fixed boilerplate — include both verbatim in every sprint. Together they make the sprint self-driving: the how frames the executor's approach, the contract is the stop condition; `/certify` discharges the contract. This is what lets a sprint be handed directly to `/goal`, to an orchestrator, or picked up inline — every executor works from the same brief.

**The sprint is self-sufficient.** Once written, it is the source of truth for execution: everything the work needs is in it, in final form. An executing agent never reads an issue file to find out what a promoted issue "really meant" — if a resolution's substance is not in the deltas or the work items, it is not in the sprint. Write accordingly.

### 4. The issue intake

`.ok-planner/issues/` is **intake**: a holding area for questions waiting to reach a sprint. This session is the only place issues close, and they close in one of two ways — **promoted** into this sprint, or **retired** at the owner's word. The ruled ones were already pulled in at §1; this section is about the **unruled** remainder.

Unruled open issues matter to this sprint for exactly one reason: **building over an open issue decides it silently.** An issue whose answer the drafted work would encode by default must be resolved by the owner first. An issue the work neither touches nor presumes an answer to is not this sprint's business and stays in the intake — and an issue the owner already answered by ruling never re-enters discussion.

So the walk is scoped:

- **Intake-drain sprint** — scope is every unruled open issue (or the batch the owner named). No relevance pass; go straight to the walk.
- **Feature-work sprint** — run the relevance pass below over the §3 draft and the unruled open issues only, then walk only the issues it returns as bearing. This raises exactly what a full walk would have raised anyway — nothing is added to the owner's plate just because the intake is being looked at.

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

  Draft sprint: [path]
  Unruled open issues (files under `.ok-planner/issues/` with
  status open or verified and an empty Ruling section):
  [one line per issue: the file path, then its frontmatter slug
  and the title line]

  Read each listed issue file in full — the Problem, Candidates,
  and any Discussion are your evidence for bearing.

  The design corpus at `.ok-planner/design/` is source of truth —
  read it freely. Read the code where an issue's bearing depends on
  what the code actually does.

  ### The test

  An issue BEARS on this sprint if any of these hold:

  - It concerns an artifact the sprint creates, amends, or retires.
  - Building a work item would encode an answer to the open question
    by default — the implementer would have to pick, and the pick
    would stand as the project's answer. (This is the central case.)
  - A plausible resolution of the issue would contradict, invalidate,
    or materially reshape a drafted delta or work item.
  - It concerns a neighbor artifact whose boundary a work item leans
    on — the work is only correct if the boundary falls one way.

  An issue is INDEPENDENT if the drafted work can be built and proved
  without answering it, AND answering it later cannot invalidate
  anything the sprint commits to.

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
  - Do not critique the sprint — that is a different review.
  - Do not report on issues not in the list you were given.
```

Report the split to the owner in one line (`4 of 7 open issues bear on this work; walking those now`). The owner may pull an independent one into scope; they never have to.

#### The issue walk

**Before presenting each issue, surface the design corpus that likely bears on it.** An issue can be silently decided against a corpus invariant the walker never consulted — the exact class of failure this step exists to prevent. Run the surfacer on the issue file:

```bash
OK_PLANNER_PROJECT_ROOT="$(pwd)" \
  python3 "${CLAUDE_PLUGIN_ROOT%/}/scripts/surface-corpus" .ok-planner/issues/<file>.md
```

The script prints, one per line, the concept / story / decision files that either (a) are explicitly cited in the issue's frontmatter `artifacts:` list, or (b) match distinctive rare tokens from the issue's slug and body. Read each surfaced artifact in full — its Invariants and Boundaries may already resolve the question, retire the issue, or reshape the framing entirely. If the script prints nothing, that itself is a signal — an issue with no bearing artifact is either about pure code with no corpus commitment or about a concept the file failed to name; flag it to the owner rather than proceeding blind.

Only then walk the in-scope issues with the owner **one at a time** (never as a wall): present the issue's title, Problem, and Candidates — leaning on its verifier-written `## Discussion`, which is the from-the-top treatment built for exactly this moment — plus a one-sentence note on what the surfaced corpus says (`concept:X invariant N says the answer is Y — likely a retire`; `concept:X owns this vocabulary but the invariant is silent on the question`; etc.); the owner picks one of two outcomes.

**Promote** — the owner decides the answer (one of the candidates, or a shape of their own). Transcribe the decision verbatim into the file's `## Ruling` (it is the owner's ruling, given live), and carry the substance into the sprint *now*, in final form: as a corpus delta, a work item, or both. On a feature-work sprint that means amending the §3 draft, including where the resolution collides with a delta already drafted; on an intake-drain sprint these resolutions are the material §3 drafts from. What lands in the sprint is the whole of the resolution — the issue file is a receipt, not a companion document.

**Retire** — the owner drops the question ("won't fix", "not real anymore", "already answered"). Nothing is carried into the sprint. Record it immediately: the owner's reason under `## Ruling`, `status: retired` in the frontmatter, and move the file to `.ok-planner/history/issues/`.

All file mutations follow `{{ISSUE-FILE-FORMAT}}` in the shared definitions. Only this session writes `promoted` and `retired` stamps.

**Timing: retirements happen during the walk; `promoted` stamps go in at §6, after sign-off.** A promotion is a handoff to a sprint, so it is only true once that sprint exists in approved final form — stamping files mid-walk would empty the intake into a document the owner might still reject or reshape. A retirement is unconditional and is recorded on the spot. If the session dies before sign-off, the promoted-in-spirit issues are still open (their rulings preserved in their files), which is the correct state.

Issues left out of scope are left strictly alone: no stamps, no editorializing, no summary prose about them in the sprint. They stay in the intake for a later sprint.

An empty intake, or a relevance pass that returns nothing bearing, passes silently.

### 5. Sign-off review

Before the owner signs off, dispatch the compliance reviewer from `skills/_shared/design-doc-compliance-reviewer.md` in **draft mode**, scoped to the sprint's corpus deltas plus any live artifacts they amend. Fix mechanical findings in the draft directly. Walk judgment findings with the owner now — this is the first of the two review opportunities, and a judgment finding resolved here never becomes an issue file. Re-dispatch until clean.

Then present the sprint to the owner for sign-off. It is not final until they approve.

### 6. Terminal

Once the owner approves:

1. **Record the promotions.** For every issue this sprint resolved — the ruled issues pulled in at §1 and the issues promoted during the §4 walk — stamp the file: `status: promoted`, `sprint: <this sprint's filename>`. The file stays in `.ok-planner/issues/` until the sprint's implementation closes (it moves to `history/issues/` when the owner accepts `/certify`'s archival offer). Every promoted slug should also appear in the sprint's `## Intent` list — that is the same fact from the other side.
2. **Stop.** The approved sprint at `.ok-planner/sprints/YYYY-MM-DD-<slug>.md` is this skill's terminal artifact. Executing it is a separate act, and this skill does not begin it: do not implement, do not invoke further skills, do not write plans. How execution works — inline in a working session or via an orchestrator, with sequencing decided then — is described in `.ok-planner/CLAUDE.md`.

## What this skill does NOT do

- Does not implement work items or mutate code.
- Does not mutate `design/` directly — corpus changes ride the sprint's deltas and are applied by the implementer.
- Does not stage, phase, or theme the work items — sequencing is execution's job, decided at execution time.
- Does not march the owner through the whole issue intake on a feature-work sprint; only issues that bear on the drafted work are walked.
- Does not re-litigate a ruled issue — a written ruling is the owner's decision, discussed only when it genuinely cannot be understood.
- Does not close issues without the owner (every promotion and retirement is an owner decision — a ruling written in the file, or a call made in-session).
- Does not re-open, revisit, or report on issues already promoted by an earlier sprint. They are settled; their sprint owns them. A problem with what a past sprint decided is a new issue with a new file.
- Does not leave a promoted issue's substance only in the intake — the sprint carries the whole resolution, and the issue file is only a receipt.
- Does not defer its own open questions silently — a question the owner explicitly postpones is filed to `.ok-planner/issues/` per `{{ISSUE-FILE-FORMAT}}` with `kind: "sprint"`.
