---
name: write-plan
description: "ONLY activated by explicit /write-plan slash command or ok-planner pipeline. Never auto-triggered."
---

# Writing Plans

Write implementation plans assuming the implementer has zero codebase context. Document: which files to touch, exact code, tests, verification commands. Bite-sized tasks.

**Save plans to:** `.ok-planner/plans/YYYY-MM-DD-<feature-name>.md` (user preferences override)

**Before writing:** invoke `ok-planner:affirm` to ensure `.ok-planner/plans/` exists.

<USER-DECISIONS>
When this skill calls for surfacing a question to the user (e.g., the spec is unworkable, the scope is unclear), surface it and wait for the response. Specifically, do not:

- Silently narrow scope when the spec is contradictory or incomplete — surface and wait
- Fabricate a missing spec or guess at intent rather than asking
- Invoke `execute-plan` when this skill terminates — plan execution starts in a fresh session (see "Execution Handoff")

General "run unsupervised" guidance does not apply to the user-facing decisions this skill calls for; follow this skill.
</USER-DECISIONS>

## Write for a clean context

The plan will almost always be executed in a **fresh Claude Code session** with no memory of the brainstorm or this plan-writing turn. The user starts a new session, opens the plan file, and runs the implementer against it. That session has no access to:

- The conversation that produced the spec or the plan
- Decisions, tradeoffs, or rejected alternatives discussed during brainstorming
- File excerpts, command output, or codebase exploration done earlier in this session
- Any "as we discussed" / "per the spec" shorthand that lives only in chat history

Treat the plan as a **self-contained executable artifact**. Anything the implementer needs to make a decision must be on the page. That means:

- Spell out file paths in full — never "the file we looked at"
- Reproduce relevant code snippets, schemas, or interface definitions inside the plan rather than referencing them
- State the rationale for non-obvious choices (why this library, why this data shape) so the implementer does not re-litigate them
- Link to the spec by path; if a section of the plan depends on a section of the spec, name it
- Do not assume the implementer has read the brainstorm transcript. They have not.

A good test: if you handed this plan to a competent engineer who joined the project this morning, could they execute it without asking questions? If not, the plan is not done.

## Ground the plan in the live codebase

Before defining tasks, read the live code the spec implies will be touched. The spec describes *what* to build; the plan describes *how it lands in this codebase*. The second question only has an answer if you know what the codebase actually looks like right now.

For every area the spec touches:

- Read the files the spec names or implies will be modified. Skim sibling files too — the ones that solve nearby problems are the ones whose shape the new code should match.
- For every new file, type, interface, handler, route, or table the spec proposes, find its closest cousin. New CLI verb? Look at where existing CLI verbs live and how they wire to the dispatcher. New persistence table? Look at neighboring tables' interface conventions (transaction handling, accessor patterns, error shapes). New scheduler sweep? Look at where existing sweeps register. New audit event? Look at how other events are emitted.
- Note the prevailing pattern. If the spec implies a location or shape that contradicts the prevailing pattern, the plan should match the pattern unless the spec explicitly justifies the deviation. The implementer will obey the plan literally; if the plan says "put it in directory X" and that contradicts the codebase's convention, the resulting code will be structurally out-of-place.

Specs are usually written from a clean-room reading of the design and don't track every codebase-shape detail that's accumulated since the last spec. The plan is the layer where those details get reconciled. A plan written without grounding sends the implementer to build the wrong shape in the wrong place, faithfully.

If grounding reveals that the spec assumed a shape or location that no longer exists, surface it to the user before writing tasks. Either the spec needs revision or the plan needs to bridge the gap explicitly — but the planner does not silently reshape spec intent.

## The plan captures the spec, in full

The spec is the unit of work. The plan's job is to translate it into executable
tasks — not to revise its scope. Whatever the spec covers, the plan covers, end
to end, in a single run.

If the spec has a `## Design changes` section, treat every bullet there as a
first-class plan task alongside the code work. Concept file mutations get
explicit edit instructions (which file, which sections, what the new text
is — written as the artifact's current state, with no dated audit-trail
or "previously was X" lines; design docs are current-state only, see
the "Current-state-only rule" in
`skills/_shared/artifact-definitions.md`). Tension file moves
get explicit `mv` / `git mv` tasks with the destination path, status update,
and resolution block. New concept or tension files get full-content task
instructions. These design-doc edits are not optional follow-up — they
ship in the same plan as the code that conforms to them, because the
design docs and the code change as one unit.

If the spec has a `## Proof changes` section, treat every entry as a
first-class plan task on the proof artifact files. The verdict letter
in the spec entry determines the task shape:

- **A. Preserve the intent** — the proof artifact at the named path
  is updated to keep satisfying the story's `Proof:` field. The plan
  task names the artifact file and gives the implementer concrete
  guidance on the update needed (e.g., "update the CLI invocation
  from `foo` to `bar` to match TD-cli-grammar-revision; the assertion
  set and the value-delivering component are unchanged"). The story
  file is NOT mutated.
- **B. Shift the intent** — the story's Proof field (and possibly
  Acceptance/Falsifier) is being rewritten under `## Design changes`;
  the proof artifact is being rewritten to exhibit the new outcome.
  The plan generates TWO tasks: one mutating the story file per the
  `## Design changes` entry, and one rewriting the proof artifact to
  exhibit what the new Proof field describes. Both ride in the same
  pass.
- **C. Remove the story** — the story file is being deleted per a
  `## Design changes` entry. The plan generates tasks to delete the
  story file AND every `@story:<slug>`-annotated proof artifact for
  that story (locate them via grep, list them all explicitly — do
  not direct the implementer to "delete the proofs").

Any plan task touching a `@story:<slug>`-annotated file MUST trace
back to either an A/B/C entry in `## Proof changes` or an explicit
ambient modification (e.g., a refactor task that incidentally touches
a proof file's call site without changing what's exhibited). The plan
reviewer flags off-spec touches.

- A plan executes start to finish in one `execute-plan` run. No user-facing
  phases, stages, milestones, deliverables, or "phase 1 of N" framing. Passes
  (see below) are internal chunks for the executor, not phases visible to the
  user — there are no checkpoints, approvals, or partial deliveries between
  them.
- No partial-spec plans. If the spec describes ten unrelated changes, the plan
  contains tasks for all ten. Cohesion, independence, and "is this really one
  feature" are not the planner's concerns — those decisions were made when the
  spec was written.
- No commit, push, branch, or PR steps. The user owns git. Plans produce
  working-tree edits and runnable artifacts (tests, demos, examples);
  nothing else.

The spec is the source of truth for the plan. Brainstorm reviewed
the spec against the design docs already; the plan does not re-check
it. Translate the spec faithfully into executable tasks and trust
the spec. Don't restate the spec's rationale; the plan's voice is
operational (which file, what edit, what verification), and tasks
that need design context link to the spec section by name. If the
spec is genuinely unworkable (contradictory, missing required
context, references things that do not exist), surface that to the
user before writing the plan. Do not silently narrow the scope.

## Make load-bearing properties explicit and checkable

A spec usually depends on properties that are easy to state and
easy to lose: durability ("the audit record is canonical"),
completeness ("every event is recorded"), atomicity ("the write
and its index update commit together"), ordering, idempotency,
no-data-loss, "this path must never block the request." These are
the properties that get silently traded away during
implementation — the implementer reaches for an expedient shape
(async, best-effort, sampled, partial) and the plan never told
them the property was load-bearing.

The plan is where a decided property stops being silent. For each
load-bearing property the spec relies on:

- **State it in the implementing task** — name the property and
  the cheaper shape that must NOT be used ("the audit insert is
  synchronous and shares the request's transaction; do not make it
  async or droppable"). The implementer obeys the plan literally,
  so the constraint has to be on the page.
- **Give it a verification command that actually exercises it**,
  not a happy-path check. A property with no real verification can
  regress silently between passes and slip past review. If the
  property is "no row is dropped under load," the verification
  drives load and asserts completeness — not "write one row, read
  it back." If a property genuinely can't be checked by a command,
  state that in the task and add a line to `## Manual checks after
  completion`.

Make these calls **autonomously**, defaulting to the rigorous side
whenever the spec leaves a how-question open — correctness over
speed, durability over latency, completeness over convenience —
exactly as the implementer is told to. Do not stop to ask;
write-plan runs to completion uninterrupted. If you settled a
tradeoff the spec didn't, or promoted an implicit property to an
explicit constraint, note it for the end-of-run handoff. The model
is: make the call, let the reviewer check it, surface it to the
user at the end — not pause mid-plan to ask.

## Per-pass falsifier brief

Every pass — acceptance or intermediate — carries a **Falsifier**
brief stating what observation would prove the pass did NOT deliver
its goal. The validator (in `execute-plan`) argues from this brief
against the diff: if the validator can point at the diff and show
the falsifier holds, the pass has not been delivered and the loop
returns to the implementer. There is no shell-runnable gate command,
no flip-validation machinery, no `Proves:` / `Red-when-absent:`
metadata — those existed to compensate for the planner having to
author a coupling-via-exit-code, which the validator-as-judge model
no longer needs.

The falsifier is short — one or two lines — and concrete:

- For an **acceptance pass**, the falsifier comes from the story's
  Falsifier field in the spec — a user-observable absence (the user
  takes the action and the promised result never appears, appears
  unrelated to their input, or appears but the underlying state is
  synthetic because the value-delivering component is stubbed or
  canned).
- For an **intermediate pass**, the planner writes a pass-scoped
  falsifier from the pass's goal. Example: "the new persistence
  table is not present in the migration, OR the migration was added
  but its FK references a table that doesn't exist."

A pass without a falsifier is a pass the validator can't judge —
plan review flags it.

## Acceptance: every user-outcome story ships with a demo, example, or proof

The spec's user-outcome stories are the contract. Each story
carries `Acceptance:`, `Falsifier:`, and `Proof:` (the canonical
story shape lives in `skills/_shared/artifact-definitions.md`;
`brainstorm` applies it in spec-authoring context). The plan
turns each story into an
**acceptance pass** that delivers two things together: the
integrating wiring that makes the story actually work, and a
**proof artifact** that exhibits the story to a third party.

**The proof artifact is a deliverable, not a gate.** The
implementer writes both the wiring and the artifact in the same
pass. `execute-plan`'s validator reads the spec, the diff, and the
artifact, and argues from intent whether the diff actually
delivers the story. The artifact's purpose is *exhibition* — to
show the feature working through the real surface — and that
purpose is what the validator judges. There is no flip-coupled
gate; the artifact and the validator together are the contract.

**Story → acceptance pass mapping.**

- Every story is served by an acceptance pass, but **stories share
  acceptance passes by default**. Stories that share an
  assembled-product bring-up (the same booted stack, the same
  harness), touch adjacent surfaces, or exercise the same subsystem
  belong in one pass — the bring-up and the context acquisition are
  paid once for all of them. Give a story its own pass only when
  batching would force the pass past its token budget (see
  "Estimate implementation tokens") or pull genuinely unrelated
  areas of the tree into one dispatch.
- Within a shared pass, **every story still gets its own proof
  task, its own artifact, and its own observable assertion** — and
  the pass header lists every slug it serves
  (`acceptance pass — STORY-a, STORY-b`). Batching is a delivery
  optimization, never a coverage reduction.
- The acceptance pass is the **last pass for its stories**. Earlier
  passes do the mechanism work; the acceptance pass does the
  integrating wiring and the artifact authoring.
- Dropping a story's artifact, or merging stories so an outcome
  goes unexhibited, is the exact hole that ships capabilities
  unbuilt. The completion auditor catches this; the planner
  prevents it.

**Cover each story's necessity closure.** A story's artifact
holds only if everything *necessary* for the user-outcome exists —
including pieces the spec never spelled out (proto wiring, the
emit site, the registration that does real work). Plan the
closure up front; trace each story to the full set of changes
without which its proof would be hollow.

**Authoring each acceptance pass.** Per spec story, the
acceptance pass contains:

- **Implementing tasks** — the wiring tasks that make the story
  actually deliverable end-to-end (entry-point registration,
  the value-delivering component's real implementation, the data
  flow that connects them).
- **A proof task** — an explicit task naming the artifact the
  implementer must produce. Use the form the story's `Proof:`
  field specifies (demo / example / executable proof / all-of-
  the-above) and what it must exhibit. The artifact:
  - boots or invokes the **real assembled product** through the
    **delivery surface the spec's TDs prescribe** (the CLI verb,
    HTTP route, wire message, scheduled job named in the
    relevant `TD-` entry) — never an in-process construction of
    components. The story names what the user does and observes;
    the TDs name how the product exposes it; the proof task
    combines the two.
  - drives the story's Acceptance trigger
  - exhibits or asserts the story's observable outcome
  - uses the **real value-delivering component** doing real work
    — a canned stub standing in for the thing the story exists
    to exercise defeats the entire pass
  - is committed alongside the wiring in the same pass
  - **carries an `@story:<slug>` annotation** in a top-of-file
    comment, in the structured-tag form the project uses (a
    GoDoc-style comment line for Go, a JSDoc-style block for
    TypeScript, a comment for other languages). The annotation
    is the durable link from the proof artifact back to the
    story it exhibits — `/review-design` and `/verify` audit
    coverage by greppping for these annotations. A proof file
    without the annotation is, for coverage purposes, not a
    proof of any story. See `{{PROOF-PROTECTION-RULE}}` in
    `skills/_shared/artifact-definitions.md`.

The proof task's description quotes the story's `Proof:` line
verbatim; its `Files:` names the artifact file(s) the implementer
creates; it references the story by slug (`STORY-<slug>`); and
it explicitly directs the implementer to include the
`@story:<slug>` annotation in each artifact file.

**Form-of-proof guidance.** The artifact form is chosen by the
spec story, not the planner — write what the story asked for:

- **Demo** — a runnable script, command sequence, or driver
  program that walks through the feature working. Saved to the
  project's demos directory (or `examples/`, project-dependent).
- **Example** — a worked illustration, often code + commentary,
  that someone reading later could follow to use the feature.
  Often saved to docs or to `examples/`.
- **Executable proof** — a committed test that drives the real
  assembled product end-to-end (testcontainers, subprocess
  harness, integration test). Saved to the project's test
  directory.
- **All of the above** — when the story calls for multiple
  forms, the planner authors a proof task for each, distinct
  files, all under the same acceptance pass.

In every form, the artifact lives in the codebase as a real
file. As acceptance passes accumulate over many specs, the
collected artifacts become the project's demo corpus / regression
suite as a byproduct — not because the planner authored them as
regression coverage, but because each acceptance pass leaves a
real, runnable proof behind.

**When a plan needs no acceptance pass.** Only when the spec
states no user-outcome stories (a pure refactor, docs- or
concept-doc-only work, an internal mechanism with no
user-reachable surface). If the spec states any story, the plan
must carry an acceptance pass for **each one**; the planner does
not get to drop a story, merge its artifact away, or downgrade
it to a unit test.

## Autonomous Execution Required

Plans are executed by `ok-planner:execute-plan`, which runs unsupervised. Every step must be something an agent can perform on its own — no human in the loop until the plan is fully implemented and reviewed.

Do **not** include steps that require:

- Manual UI or browser verification ("check that the page renders", "click through the flow and confirm it looks right")
- Human judgment calls ("does this look correct?", "approve the approach before continuing", "confirm with the user")
- External environments the implementer cannot reach ("deploy to staging and test", "run against the production database")
- Credentials, secrets, or access the plan does not explicitly provide
- "Checkpoint" pauses for user review between tasks
- Commits, pushes, or any git write beyond local working-tree edits (the user commits when they are ready)

All verification must be expressible as a command the implementer can run and read the output of — typically a test, a type check, a lint, or a targeted script. "The test passes" is a verification. "It looks right" is not.

If a feature genuinely requires manual verification that cannot be automated (e.g., visual review of a rendered UI, a human-in-the-loop ML evaluation), **do not** put it inside a task. Collect those items in a final `## Manual checks after completion` section at the end of the plan. That section is for the user to run through after the implementation and code review are done — it is not part of the automated run. **"Does the feature actually work when the product runs" is not one of these items** — that is the acceptance pass (see "Acceptance" above), which produces a demo / example / proof artifact the validator confirms exhibits the story working. Reserve this section for verifications that genuinely cannot be expressed in a runnable artifact (true visual judgment of a rendered UI, human-in-the-loop evaluation); never use it to defer end-to-end validation that could be exhibited.

## File Structure

Map out files before defining tasks. Design units with clear boundaries. Each file should have one clear responsibility.

## Passes — chunking for execution

`execute-plan` dispatches one pass at a time, not the whole plan at once. A pass is a coherent chunk of work that one subagent completes in a single dispatch. The plan declares its passes up front; the executor processes them in order.

**Why passes:** A flat plan of 50 tasks either exhausts one subagent's context or forces the executor to chunk on the fly (which it does poorly). A flat plan of 4 tasks doesn't need chunking — it's one pass. Passes are *not phases*: there are no user checkpoints between them, no partial deliveries, no "phase 1 of N" framing visible to the user. They all run inside one `execute-plan` invocation. The user-facing unit is still "the plan."

**A plan has no fixed scope. A large scope means more passes — never more plans.** The spec sets the scope and the plan covers it in full (see "The plan captures the spec, in full"); a plan can be a few tasks or it can run for hours. The right response to a big spec is *more passes*, not splitting it into several plans or pushing the spec back to be split. This is safe because `execute-plan` dispatches one pass at a time, each to a fresh subagent with its own full context window — the orchestrator never holds the whole plan's work in one context, so it can drive a dozen, two dozen, or more passes without context exhaustion. Context is not what bounds plan size. So do not react to a large spec with "this is too much for one plan"; a high pass count is exactly what a large plan looks like.

**Pass count guidance:**

- **Target ~100–150k tokens of implementer work per pass.** Implementers nominally have a 1M-token context, but observed effectiveness degrades after roughly 150k — the subagent gets lazy, skims, drops tasks, writes thinner code, and increasingly fails the validator. 150k is the *working* ceiling, not 1M. Bias toward smaller, well-scoped passes; ~60–100k is a healthy size, ~150k is a "this pass is getting full" warning, ~200k+ is "this pass should split."
- Pass count scales with the spec's *estimated token cost* (see "Estimate implementation tokens"), not with its story or task count. There is no upper cap on pass count, and a high count is never a signal to split the spec or write multiple plans. A spec that needs 20 passes gets 20 passes.
- Within the budget, **batch coherently**. Every pass boundary costs a full context re-acquisition by a fresh implementer plus a fresh validator dispatch; two passes that read the same files, the same spec sections, or boot the same test stack are paying that overhead twice for no independence gain. But "batching to reduce overhead" stops at the budget ceiling — merging two 90k passes into one 180k pass is a regression, not an optimization, because the merged pass crosses the laziness threshold.
- Don't pad the count: size passes by token budget and coherence, never toward a target number. A 30k pass that's a coherent unit is fine.

**Pass sizing:** Size each pass by its **estimated implementation tokens**, not its task count. Target ~100–150k per pass; split when the estimate crosses ~150k. Merge passes that touch the same files, read the same context, or share a test-stack bring-up — shared context acquisition is the strongest merge signal — but only when the merged pass stays under the ~150k working ceiling.

## Estimate implementation tokens (per pass)

Pass boundaries are token decisions, so the planner must run the numbers. The estimates are a **planning artifact only**: use them to draw pass boundaries, then keep them out of the plan document — implementers and reviewers never see them. For each pass, estimate what the implementer will actually spend, in three buckets:

- **Context acquisition** — the spec sections, plan section, concept docs, and source files the implementer must read before editing. Estimate from the real files (you read them while grounding the plan): file sizes, how much of the subsystem must be understood, whether the area is self-contained or tentacled.
- **Verification output** — the dominant cost in test-heavy projects. A unit-test run is cheap; a testcontainers/integration suite that boots real infrastructure produces thousands of tokens per invocation, and a pass typically runs its suite 2–3 times (fail, fix, confirm). Count the runs the pass's steps prescribe.
- **Edit volume** — usually the smallest bucket; estimate from the diff the tasks imply.

The target is ~100–150k per pass. A pass estimated above ~150k crosses the implementer-laziness threshold and should split; a pass estimated below ~60k that shares context with a neighbor wants merging (subject to the 150k ceiling on the merged result).

Do **not** write the estimates into the plan — no `Est. tokens` line in pass headers, no total in the plan header. An implementer who sees a number anchors on it ("I've spent my budget, wrap up"), and a reviewer can't verify it anyway; the plan carries the *result* of the estimation (the pass boundaries), not the arithmetic. Estimates are coarse — order-of-magnitude honesty, not precision — but they force the batching question at planning time. Verification commands also follow the budget: per-pass verification covers the touched packages; the full repo-wide suite runs once at `execute-plan`'s final verification gate, not per pass — don't prescribe whole-tree runs inside every pass.

**Every pass leaves the tree working.** Each pass must end with the
codebase in a working state — the implementer of the next pass should
not be handed a broken tree. If a unit of work conceptually requires
"tear down old, then build new," express it as one pass with both the
teardown and the rebuild tasks, ending working. Multi-pass migrations
where intermediate passes leave the tree broken are not supported —
they confuse implementers and add machinery for no gain.

**Falsifier brief per pass.** Every pass carries a `Falsifier:` line
stating what observation would prove the pass did not deliver its
goal — what the validator argues against (see "Per-pass falsifier
brief" above). For acceptance passes the falsifier comes from the
story's `Falsifier:` field; for intermediate passes the planner
writes a pass-scoped falsifier from the pass's goal.

## Task granularity (within a pass)

Each step inside a task is one discrete, verifiable action: one thing the implementer does, followed by something concrete to check. Small steps exist to create checkpoints — they isolate failures, keep each step's output inspectable, and make recovery cheap when something goes wrong. They are not a concession to limited agent capacity.

- "Write the code" — step
- "Run the test" — step
- "Confirm the output matches expectation" — step

Do not bundle independent edits into one step. Frame steps by the action they perform and the check that follows — never by how long they would take, how easy they are, or how much effort they require.

## Plan Header

```markdown
# [Feature Name] Implementation Plan

**Spec:** [Path to the spec this plan implements, e.g., .ok-planner/specs/2026-05-05-foo-design.md]
**Goal:** [One sentence]
**Architecture:** [2-3 sentences]
**Tech Stack:** [Key technologies]

---
```

The `**Spec:**` field is required. The execute-* skills read it to archive
the spec alongside the plan when the work completes. If a plan was
authored without going through `brainstorm` (i.e., no spec exists), write
`**Spec:** none` so the field is still present and explicit.

## Pass and Task Structure

Tasks live under passes. Each pass has a header with goal / scope /
falsifier; each task under it has its own files list and numbered
steps. Tasks are numbered globally across the plan, not reset per
pass — so the completion auditor, plan reviewer, and user can
reference "Task 7" unambiguously.

```markdown
## Pass 1: Add session-based auth module

**Goal:** Introduce the new session module with its unit tests.
**Scope:** Tasks 1–3
**Falsifier:** the new session module is not present in `internal/auth/session*.go`, OR it has no tests, OR the tests don't exercise the session lifecycle (create / refresh / revoke).

### Task 1: Add `internal/auth/session.go`

**Files:** `internal/auth/session.go` (new)

**Steps:**
1. Create the file with the session struct and constructor.
2. Implement create / refresh / revoke methods.
3. Run `go build ./internal/auth/...` and confirm it compiles.

### Task 2: ...

---

## Pass 2: Wire the session module to the HTTP entry point (acceptance pass — STORY-session-login)

**Goal:** Connect the session module to `POST /login` and deliver STORY-session-login end-to-end.
**Scope:** Tasks 4–6
**Falsifier:** `POST /login` does not return a session token, OR the session it returns is not retrievable on subsequent authenticated requests, OR the session-creation code path is not reached when `POST /login` is hit (handler unwired, route not registered, value-delivering component stubbed).

### Task 4: Register `POST /login` and wire to session.Create

**Files:** `internal/server/routes.go`, `internal/server/login.go` (new)

**Steps:**
1. Add route registration in `routes.go`.
2. Create `login.go` with the handler that calls `session.Create`.
3. ...

### Task 5: Add acceptance demo for STORY-session-login

**Files:** `examples/session-login-demo.sh` (new)

**Story:** STORY-session-login
**Proof form (from spec):** demo — exhibits a successful login flow against the running server, showing the returned session token is usable for an authenticated request.

**Steps:**
1. Create a shell script that:
   - Starts the server (or assumes a running instance).
   - POSTs to `/login` with sample credentials.
   - Extracts the session token from the response.
   - Issues an authenticated request using the token.
   - Prints both responses so a reader can see the full flow.
2. Run the script against a local server and confirm both responses look right.
3. Commit the script as the story's proof artifact.
```

Notes on the shape:
- The `Falsifier:` is the validator's contract. It names a concrete
  observation a reviewer could point at in the diff — not a generic
  "the feature doesn't work."
- Acceptance passes annotate their header with every story slug they
  serve (`acceptance pass — STORY-<slug>`, or
  `acceptance pass — STORY-a, STORY-b` for a shared pass) so the
  completion auditor can pair stories to passes.
- The proof task quotes the story's `Proof:` field from the spec and
  names the artifact file(s) it produces.
- Do not include commit steps, "ask the user" steps, or manual-check
  steps — the user commits when they are ready and manual checks go
  in the final section (see Autonomous Execution Required above).

## Plan Review

After writing, dispatch a reviewer:

```
Agent (general-purpose):
  Review the plan at [path] against the spec at [path].

  ## Ground every claim in source code

  Before checking the plan against the spec, verify the plan
  against the codebase. A plan that references files, functions,
  or APIs that do not exist (or have a different shape than the
  plan assumes) sends the implementer chasing ghosts. Catch it
  here.

  - Read every file path the plan names. If a path does not exist
    and the plan does not mark it as new (a "create this file"
    task), flag it.
  - For every function, class, module, type, table, endpoint, or
    other named entity the plan references as existing, find it
    (`rg`, `grep`, or direct read). If it does not exist, or its
    actual shape differs materially from the plan's assumption,
    flag it with file:line and what is actually there.
  - For every "modify X" / "the existing Y" instruction, verify
    the target exists and is shaped as the plan assumes.
  - For every NEW file, type, interface, handler, route, or table
    the plan introduces, find its closest cousin in the codebase
    (sibling files in the same directory, neighboring tables,
    prevailing patterns for similar work) and check that the
    plan's proposed shape and location match. A plan that puts
    new CLI verbs under `cmd/foo/` when every other verb lives in
    `internal/cli/` — or that defines a new persistence table
    with a different transaction-handling convention than its
    neighbors — sends the implementer to build something
    structurally out-of-place. The grounding rule covers
    new-but-conventionally-shaped code, not just references to
    existing entities. If the plan's deviation is intentional
    and the spec justifies it, the plan should say so; if the
    plan is silent, flag it as a grounding miss.

  If you find one such issue, keep looking — they cluster.
  Exhaustively check every file path and every named entity; do
  not sample. The cost of a missed grounding issue is multiplied
  by the cost of the implementer chasing the ghost or building
  the wrong shape.

  ## Plan quality checks

  After grounding, check:
  - Completeness and spec alignment. If the spec has a
    `## Design changes` section, verify the plan contains explicit
    tasks for each bullet (concept file mutations, tension file
    moves to `_resolved/` or `_rejected/`, new concept or tension
    files). Design-doc edits ride alongside code edits in the
    same plan; missing tasks here are blocking.
  - Design-doc tasks respect the current-state-only rule (see
    `skills/_shared/artifact-definitions.md`). Flag any task
    that directs adding a `## Notes` / `## History` /
    `## Changelog` section to a concept, story, or decision; any
    task that directs appending a dated audit-trail entry
    (`<date> — <what changed per spec X>`); any task that
    writes backward-looking phrasing into the artifact body
    ("previously called X", "(was 60s)", "changed per spec Z");
    any task that writes forward-looking phrasing ("TODO", "we
    plan to", "will be replaced", "deferred"). The fix is to
    rewrite the task so the artifact body describes the new
    state directly — git carries the lineage.
  - Load-bearing properties are explicit and checked. Identify the
    properties the spec relies on (durability, completeness,
    atomicity, ordering, idempotency, no-data-loss,
    canonical-record, "must not block the request," and the like).
    For each, verify the plan (a) states the constraint in the
    implementing task — naming the cheaper shape that must not be
    used — and (b) gives it a verification command that actually
    exercises the property, not just a happy-path check. A
    load-bearing property with no real verification is a blocking
    gap: it can regress silently during execution and slip past
    review.
  - Falsifier brief per pass (blocking). Every pass — acceptance or
    intermediate — carries a `Falsifier:` line stating what
    observation would prove the pass did not deliver its goal.
    Check (a) presence: every pass has one; (b) concreteness: the
    falsifier names a specific observable absence a reviewer could
    point at in code (a missing file, a stubbed component, an
    unwired registration, a missing column) — not a generic "the
    feature doesn't work" or the goal restated in the negative;
    (c) for acceptance passes, the falsifier matches or extends the
    story's `Falsifier:` field from the spec — never weaker; (d) the
    falsifier is short (one or two lines). A pass without a
    falsifier, or with a falsifier the validator could not argue
    against, is blocking — `execute-plan`'s validator has nothing to
    judge against.
  - Acceptance pass authoring (blocking). If the spec states
    user-outcome stories, every story must be served by an
    acceptance pass delivering both the integrating wiring AND a
    proof artifact (demo / example / executable proof / all-of-the-
    above) per the story's `Proof:` field. Stories share acceptance
    passes by default (batching is correct, not a flag) — but check
    (1) coverage: every story has its own proof task and its own
    observable assertion within whatever pass serves it; a story
    with no serving pass, or whose artifact is merged away so its
    outcome is never exhibited, is blocking — that is
    how a promised capability ships unbuilt. Then, for each
    acceptance pass: (a) the pass header annotates every story slug
    it serves; (b) the proof task names the artifact file(s) the
    implementer creates and quotes the story's `Proof:` field; (c)
    the artifact's described form drives the **real assembled
    product** through the delivery surface the spec's TDs prescribe
    (the CLI verb / HTTP route / wire message named in the relevant
    `TD-` entry), not an in-process construction; (d) the artifact
    exhibits or asserts the story's real observable outcome; (e) the
    value-delivering component is real, not stubbed — a story whose
    proof task uses a canned stub is a blocking gap. Also check
    **necessity closure**: for each story, the plan contains the
    wiring tasks without which the artifact could not exhibit the
    outcome — including pieces the spec did not literally name
    (proto wiring, emit sites, registrations that do real work). A
    story whose closure is under-planned will fail the validator at
    execution time. Also check **`@story:<slug>` annotation
    directive**: every proof task directs the implementer to include
    an `@story:<slug>` annotation in a top-of-file comment in each
    artifact file. A proof task missing this directive is blocking
    — the artifact ships without the link, the coverage audit can't
    find it. A spec with no user-outcome stories (pure refactor /
    docs-only / no user-observable change) correctly has no
    acceptance pass; do not flag its absence there.
  - **Proof changes section handled (blocking).** If the spec has a
    `## Proof changes` section, every entry must map to plan tasks:
    - **A. Preserve** entries → a plan task updating the named
      artifact file with concrete guidance (what changes, why the
      intent is unchanged). Flag entries with no corresponding task.
    - **B. Shift** entries → TWO plan tasks: one mutating the story
      file per `## Design changes`, one rewriting the proof artifact.
      Flag if either is missing.
    - **C. Remove** entries → tasks deleting the story file AND every
      `@story:<slug>`-annotated proof artifact for that story (the
      plan must list each artifact file explicitly, located by grep
      at plan time — not a directive like "delete the proofs"). Flag
      if the proofs aren't enumerated.
    Also flag **off-spec proof touches**: any plan task that modifies
    a `@story:<slug>`-annotated file without either (i) a
    corresponding A/B/C entry in `## Proof changes`, or (ii) an
    explicit "ambient modification" note in the task explaining why
    the touch does not change what's exhibited. Off-spec proof touches
    are how proofs decay silently — the planner should have caught
    them and pushed back to brainstorm, not threaded them into the
    plan.
  - Task decomposition (one discrete action plus verification per
    step)
  - Buildability (the implementer can act on each task from the
    information given)
  - Autonomous executability — every step must be runnable by an
    agent without human intervention. Flag any step that requires
    manual verification, user approval, external environments, or
    credentials the plan does not provide. Manual checks belong
    in a final "Manual checks after completion" section, never
    inside a task.

  ## Plan-internal mechanical coherence (blocking)

  Grounding above checks the plan against the codebase. This
  check is different: walk the plan's tasks in order as if you
  were the implementer executing them verbatim, and verify the
  plan does not self-sabotage. The recurring failure mode is a
  contradiction between adjacent tasks of the same plan — both
  passages individually look fine, but their composition leaves
  the tree broken or the falsifier unsatisfiable. The validator
  catches these at execution time and burns a re-dispatch; the
  reviewer catches them at plan time for free.

  Concretely flag:

  - **Scripts referencing not-yet-installed tools.** A task that
    creates a `package.json` / `Makefile` / `pyproject.toml` /
    similar with scripts invoking binaries (e.g. `vite build`,
    `pytest`, `cargo run`) when the plan does not install those
    binaries until a later task or pass — combined with any
    earlier-defined aggregate / cascade / `--workspaces` invocation
    that would fan into the new script — exits non-zero from day
    one of the pass. Walk every script the plan creates; for each
    binary it invokes, find the install step. If the install step
    is in a later pass, the script must be a no-op or absent until
    that pass. Same hazard for shared lint / typecheck / test
    aggregators that auto-discover workspace members.
  - **Falsifier-vs-tasks consistency per pass.** For each pass's
    `Falsifier:`, read every task in the pass and check that the
    tasks supply every artifact, configuration, and observable
    state the falsifier checks. A pass falsifier of "all three
    services report healthy within 60s" with task content that
    defines healthchecks for only two of the three services is a
    self-defeating pass — the implementer follows the tasks
    literally and lands on a red falsifier. Same shape: a
    falsifier naming an endpoint the pass's tasks don't register,
    a falsifier naming a file the pass's tasks don't create, a
    falsifier naming a metric the pass's tasks don't emit.
  - **Project-rule awareness surfaced to the implementer.** Read
    every file under `.claude/rules/` and any project-root
    CLAUDE.md. Identify constraints that will mechanically reject
    or block the implementer's work — comment-hygiene lints with
    PostToolUse hooks, mandatory typecheck-before-done sequences,
    forbidden patterns (no `--no-verify`, no destructive git), no-
    backwards-compat windows, naming conventions enforced by lint.
    For each binding constraint: verify the plan either (a) names
    it in a plan-wide preamble / pass header so the implementer
    plans around it, or (b) prescribes the explicit opt-in / config
    file the rule's exemption mechanism requires. A plan silent on
    a project rule the implementer is about to violate is blocking
    — the implementer will burn cycles fighting hooks the planner
    knew about.
  - **Cross-task ordering hazards.** Within a pass and across
    adjacent passes, flag a task whose successful completion
    depends on state an earlier task removes, renames, or replaces
    without the dependent task being updated. Same for tests: a
    test added in Task N that exercises behavior Task N+1
    refactors away.
  - **"Every pass leaves the tree working" satisfied per pass.**
    Walk the tasks of each pass; if the pass's final task leaves
    the tree in a state where the project's standard build /
    typecheck / test command would exit non-zero (excluding test
    failures the next pass is intended to fix, which are not a
    supported pattern — see the "every pass leaves the tree
    working" rule), flag it.

  The simulation does not need to be exhaustive — read each task,
  ask "if the implementer ran the prior tasks and then this one,
  what's the state?" One pass through the plan with that frame
  catches the cluster.

  ## Pass decomposition checks

  Passes are how `execute-plan` chunks the plan for dispatch.
  Bad decomposition either exhausts a subagent's context or
  fragments the work into too many serial dispatches. Check:

  - Every task lives under a numbered pass (no orphan tasks
    outside any pass).
  - Pass count is appropriate to the plan: There is NO upper cap
    on pass count — it scales with the spec's estimated token cost,
    and a high count is never grounds to flag the plan as needing to
    split into multiple plans or to push the spec back to be
    narrowed. But **under-batching is a real flag**: every pass
    boundary costs a fresh implementer's full context
    re-acquisition plus a validator dispatch. Flag adjacent passes
    that read the same files or spec sections, boot the same test
    stack, or whose evident workload (files to read, edits to
    make, verification runs) sits far below the 1M-token
    context ceiling — they want merging. Also flag the opposite: a
    pass whose evident workload approaches the implementer's ~1M
    context ceiling wants splitting. Judge this from the pass's
    content — the planner's token estimates are a planning
    artifact and are deliberately not written into the plan, so
    do NOT flag their absence.
  - Each pass header declares **Goal**, **Scope** (task range),
    and **Falsifier**. Acceptance passes additionally annotate
    every story slug they serve in the header
    (`acceptance pass — STORY-<slug>` or
    `acceptance pass — STORY-a, STORY-b`).
  - Every pass leaves the tree in a working state — there is no
    `broken-intentional` end-state, and no "restored by Pass N"
    framing. Multi-pass work that conceptually requires teardown
    before rebuild is expressed as one pass containing both. Flag
    any pass that says or implies "this leaves the tree non-working"
    or names a restorer pass — it is a blocking authoring error,
    not a supported pattern.
  - Adjacent passes that touch the same handful of files in
    continuous order with no meaningful boundary — merge them.
    Passes that scatter across genuinely unrelated areas of the
    tree — consider splitting. A high task count alone is not a
    split signal when the tasks are mechanically related and the
    pass's evident workload fits the budget.

  Flag any phase/stage/milestone framing aimed at the user (passes
  are internal chunks; "phase 1 of N" framing implies user
  checkpoints and is not allowed). Flag any plan that implements
  only part of the spec — the plan must cover the spec in full
  and execute end-to-end in a single `execute-plan` run. Flag any
  commit, push, branch, PR, deployment, release, or rollout steps —
  plans produce working-tree edits and runnable artifacts;
  delivery process is the user's concern.

  Only flag issues that would cause implementation failure or
  force the executing agent to stall for human input.

  Report: Approved | Issues Found (with specifics)
```

Fix issues, re-review until clean. Each re-review runs the full grounding pass — do not assume the previous round was exhaustive. Cluster bias means missed grounding issues hide behind the ones the previous reviewer found; a second-round reviewer that only verifies the cycle-1 fixes will leave the cluster's tail un-caught.

## Execution Handoff

When the plan is written and the reviewer reports clean, **stop**. Do not invoke any execution skill. Do not start implementing. Do not offer to start implementing in this session.

Tell the user:

- The plan path
- That they should start a **fresh Claude Code session** (clear context) and run `/execute-plan` against the plan there, so the implementer works from a clean context with the plan as its single source of truth
- Any autonomous calls worth knowing about: load-bearing properties the plan made explicit and checkable, and any tradeoff the spec left open that the plan defaulted to the rigorous side of. Keep this to a short list — these are calls already made, surfaced for awareness, not questions to answer. If there were none, omit this entirely.

Then end the turn. Plan execution is the user's call, in a session of their choosing.
