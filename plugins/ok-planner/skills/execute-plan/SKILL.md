---
name: execute-plan
description: "ONLY activated by explicit /execute-plan slash command or ok-planner pipeline. Never auto-triggered. Drives a plan to completion pass by pass as a Workflow with an implementer + single smart validator: dispatch the implementer; if DONE, dispatch one judgment-driven validator that reads the spec, the pass's Falsifier brief, and the diff, and decides 'was the work done?' The validator triages every issue it finds into BLOCKING (work materially fails the pass — missing/broken/falsifier-violating; pass cannot advance) or DEFERRED (nits, polish, cross-pass-consistency, doc-rule violations, anything not pass-falsifying; pass advances, the entry joins a queue drained at end-of-run). Blocking findings dispatch the implementer-as-fixer; the validator re-runs; loop until verdict=delivers. The validator itself appends every deferred entry (as JSONL) to `<plan>-deferred.jsonl` adjacent to the plan via Bash before returning its structured output, so the queue is durable across aborts — the skill seeds the queue from that file before launching the workflow. Loops never escalate on a cycle cap — every wall event (validator persistently surfacing the same blocking findings, fixer reporting blocked, fixer coverage gap, gate fixer-loop not converging) routes through the strategist, who either re-frames the next dispatch or confirms a genuine impasse. After all passes clear, the deferred-cleanup phase drains the accumulated queue with its own fixer ↔ reviewer loop, then the final verification gate runs the project's build + test + lint suite until clean, the no-deferral audit gate runs until clean, and the completion auditor writes the four-section report. Human-facing intake, escalation, final review, and the closing walk stay in the skill — and the orchestrator owns completion: a workflow `escalate` is the starting point for an autonomous-repair attempt, not a user-handoff, unless the failure is literally impossible to advance."
---

# Executing a Plan (Workflow engine)

Drive a plan to completion pass by pass with an opposing implementer
↔ validator pair, then audit and review. The control flow is code,
not prose: dispatch → validate → loop or advance is a `Workflow`
whose branches are real conditions on structured agent output, so a
pass cannot advance on a verdict the orchestrator "decided" was
close enough.

**Why an opposing pair, not mechanical gates.** Agents are smart and
effective when given the right context; what they fail at is being
their own check on whether they delivered. Splitting the work
across an implementer (which wants the pass to advance) and a
validator (whose job is to argue it didn't) gets the adversarial
discipline without the flip-coupled gate command the planner used
to have to author. The validator reads the spec, the pass's
Falsifier brief, and the diff, and argues from intent. There is no
shell command coupling required; the validator is the judge.

**Why one smart validator, not a fixed lens fan-out.** An earlier
shape ran 4–5 narrow-concern validator lenses (wiring,
regression-sweep, acceptance-proof, design-doc-rules,
falsifier-direct) in parallel every cycle and merged their
findings. In practice the fan-out paid 4–5× the implementer's
context cost on every pass — and on a clean pass, every lens
returned empty, making the entire pay-out pure tax. Worse, fixed
lenses can't be talked out of a bad framing: when a lens insisted
that an acceptance proof must be executed against a live AWS
stack — explicitly the user's manual check per the plan — the
strategist twice ruled the finding out of scope, and the
orchestrator re-dispatched the lens anyway. The current shape
trusts one validator with broad context and judgment: it reads
the pass, judges "did this work get done?", and triages every
issue it surfaces (blocking vs. deferred) instead of treating
every defect as pass-blocking. The narrow-lens concerns that
genuinely matter (cross-pass consistency, doc-rule polish, dead
code) get caught either by the validator's deferred queue or by
the final `review-work` cycle, which already converges well on
code quality and was always going to run anyway.

## The opposing pair, per pass

Three agent roles per pass:

- **Implementer** — given the spec, the pass goal, the tasks, and
  the pass's `Falsifier:` brief, builds the work and reports
  `DONE` / `BLOCKED` / `INVALID_PLAN`. Schema-enforced: `DONE`
  requires every task's `done` flag to be true; partial-DONE is
  illegal. The only role that wants the pass to advance.
- **Smart validator** — one judgment-driven validator per pass.
  Reads the spec, the pass's `Falsifier:` brief, the diff, and
  (for acceptance passes) the story's Acceptance + Falsifier +
  Proof fields. Forms its own read of "was this work done?", and
  triages every issue it surfaces:
  - **Blocking** — work that materially fails the pass: the
    Falsifier holds against the diff, a downstream pass depends on
    something missing or broken, a behavior the spec promises
    fails for the user, an acceptance proof that doesn't
    structurally exhibit its story. These dispatch the fixer; the
    pass does NOT advance until they clear.
  - **Deferred** — everything else: nits, polish, doc-rule leaks,
    cross-pass consistency, dead code, design-doc audit-trail
    phrasing, missing-but-non-critical dependencies. These join
    the deferred queue and the pass advances; the queue drains at
    end-of-run with its own focused fixer ↔ reviewer loop.

  The validator returns structured output: `verdict` (delivers /
  does_not_deliver), `blocking: [{location, problem, why}]`,
  `deferred: [{location, problem, why, category}]`. The
  delivers/does_not_deliver determination is computed from
  blocking: empty blocking → delivers; non-empty blocking →
  does_not_deliver. The validator's contract bounds itself:
  things the plan's `## Manual checks after completion` section
  documents as manual (deploying to a live environment, hitting a
  production endpoint, running a CLI that needs cloud credentials)
  are NOT the validator's concern — neither blocking nor deferred.

- **Implementer-as-fixer** — dispatched against ONLY the blocking
  findings via the per-finding coverage protocol the verification
  and no-deferral gates use. Schema-enforced: every input blocking
  finding appears in the resolution exactly once, and `status:
  DONE` requires every disposition to be `fixed` or
  `already-clean`. The fixer prompt also includes the prior
  implementer's task-completion summaries — that primes the fixer
  to start from "I'm continuing the prior implementer's work" rather
  than "I'm a fresh hire reading from scratch."

The per-pass loop runs **until the validator reports verdict =
delivers**: implementer DONE → validator → if blocking is empty,
pass cleared (deferred items captured in the queue); otherwise,
fixer on blocking → re-dispatch validator → loop. There are no
cycle caps. The only exits are validator-approval (pass cleared)
or strategist-confirmed impasse (escalate). Same-blocking-findings
detection (the validator surfacing the same blocking entries twice
in a row) routes the impasse to the strategist, which can either
re-frame the fixer's approach for the next cycle or confirm
escalation.

A **`BLOCKED` or `INVALID_PLAN` report from the implementer**
triggers the specialized strategist for the implementer's narrow
halt-lanes. The strategist either confirms the halt is genuine
(escalate with the appropriate kind, carrying the implementer's
report and the strategist's analysis for the user) or supplies a
root-cause read and a different approach. There is **no cap on
strategist invocations** — every halt-claim is judged, every time.

**Every other wall event also routes through the strategist** via
the generalized `consultStrategist` gateway: a validator that
returns the same blocking findings on two consecutive dispatches;
a fixer reporting `status: BLOCKED`; a fixer that can't produce a
coverage-compliant report; a gate (verification, no-deferral,
deferred-cleanup) that can't converge. The strategist either
re-frames the next dispatch (loop continues with the strategist's
approach as input) or confirms genuine impasse with `escalateKind`
set to `blocked` / `invalid-plan` / `architectural-call` (engine
escalates). The strategist is the single escalation gateway;
nothing else terminates a loop early.

The implementer's halt lanes are deliberately narrow and parallel:
BLOCKED is *the world is blocking me* (credentials/access only the
user can provide, or an unauthorized destructive action); INVALID_PLAN
is *the plan itself is broken* (literally impossible to implement, or
unintelligible to the implementer). Neither lane accepts "I'd prefer
a different shape," "needs discussion," or "the validator's critique
was unfair" — those are not halts. Schema-enforced: BLOCKED requires
`blockedBullet` + `blockedDetail`, INVALID_PLAN requires
`invalidPlanReason` + `invalidPlanDetail`, both with non-trivial
detail strings.

Every role in the engine except the implementer (and the
implementer-as-fixer when it's working) is **disinterested** — none
has a stake in advancing the pass.

## Pass model

Every pass leaves the tree in a working state — there is no
`broken-intentional` end-state and no restorer model. A pass's
contract is its **Falsifier brief**, written by `write-plan`.
Acceptance passes additionally annotate every story slug they serve
in their header (`acceptance pass — STORY-<slug>`, or a
comma-separated list for a shared pass); the validator uses the
spec's story (Acceptance + Falsifier + Proof) as its deeper context
for those passes.

## What runs where (the seam)

| In the workflow (code, headless) | In the skill (prose, human-facing) |
|---|---|
| dispatch implementer → smart validator → implementer-as-fixer on blocking; loop until validator approves | parse the plan → structured passes |
| accumulate the deferred queue across passes | autonomous repair on `escalate` results whose lastFailure is concrete and fixable (see step 5) |
| strategist as the single escalation gateway: every wall event consults it before the engine returns `escalate` | escalation conversation only when the escalation is genuinely beyond reach |
| deferred-cleanup phase (fixer ↔ reviewer loop on the queue) before verification | the closing walk (proofs working + decisions kept + decisions diverged + coverage divergences) |
| final verification gate (build + test + lint per project docs) loops until clean | final review (`review-work` → `review-cleanup`) |
| no-deferral audit as gate; loops until clean | archive |
| completion auditor (writes the four-section report, runs coverage + intent-drift audit) | |

The **final review** stays skill-side (`review-work` /
`review-cleanup`, unchanged — known to converge well). **Resume
across an escalation** stays skill-side (a fixed `blocked` is
resumed by re-invoking the workflow on the remaining passes).

## Opt-in

Invoking the `Workflow` tool from this skill is authorized: the user
ran `/execute-plan` (or the ok-planner pipeline reached it), and this
skill's instructions tell you to call it. That is a valid Workflow
opt-in. Pass the structured passes as `args`; do not paste the plan
text into the script. (For a plan too large for the inline `args`
channel — it can drop or stringify a big payload — embed the passes
in the script instead, as the engine's input guard notes.)

## Process

1. **Select the plan.** If the user named a plan, use it. Otherwise
   list `.ok-planner/plans/*.md` (newest first, filename + title line)
   and ask which to run. Read it in full. Read the `**Spec:**` header.

2. **Parse the plan into structured passes.** For each pass capture:
   ```
   { number,
     name,
     goal,
     falsifier,           // the Falsifier brief — the validator's contract
     isAcceptancePass,    // true if the pass header annotates an acceptance pass
     storySlug,           // the story slug if isAcceptancePass, else "";
                          // a shared acceptance pass lists every slug it
                          // serves, comma-separated ("a, b")
     tasks: [ { number, text } ] }   // task text VERBATIM from the plan
   ```
   If any pass has no falsifier, **stop and surface to the user** —
   that is a planner defect (`write-plan`'s reviewer should have
   caught it). The engine cannot run without a falsifier; the
   validator has nothing to argue against. Same for acceptance
   passes missing their story slug annotation.

3. **Affirm the layout.** Invoke `ok-planner:affirm`.

4. **Run the engine as a workflow.** Call `Workflow` with the script
   in "The workflow engine" below — copy the entire fenced JS block
   **verbatim** into the `script` parameter; do not paraphrase,
   abbreviate, omit sections, or pre-Write it to a file (the
   Workflow tool persists the script itself; you do not author the
   file separately).

   **Before launching, check for a deferred-queue file from a prior
   aborted run.** The workflow persists every validator-found
   deferred finding to `<plan-path-without-.md>-deferred.jsonl`
   adjacent to the plan (e.g. `.ok-planner/plans/<slug>.md` →
   `.ok-planner/plans/<slug>-deferred.jsonl`). If this file exists,
   read it, parse each non-empty line as JSON (skip malformed lines
   with a warning — do not abort on parse error), and include the
   resulting entries as `args.priorDeferred`. Tell the user in one
   line: "found N deferred entries from a prior run; including them
   in this launch." This is what makes the queue durable across an
   abort.

   Then call Workflow with:
   ```
   args = { passes: <the parsed pass array>,
            planPath: "<plan path>",
            specPath: "<spec path from the **Spec:** header, or 'none'>",
            priorCleared: 0,                  // raised on resume across an escalation
            priorDeferred: [<entries...>] }   // [] if no prior queue file exists
   ```

   **Self-heal launch errors. This is the most important discipline
   of this skill.** The user runs `/execute-plan` and walks away
   trusting the run to finish in their absence. If `Workflow`
   returns an error **before the run starts** (script parse error,
   meta validation error, args validation error), DO NOT stop, DO
   NOT ask the user, and DO NOT abandon the invocation — they are
   not at the keyboard. Diagnose the error, fix it, and re-invoke.
   The common failure modes and their fixes:
   - **`SyntaxError` / `ReferenceError` / `Unexpected token` in the
     script** → you paraphrased, truncated, or otherwise altered the
     canonical block when copying. Re-read this skill's "The workflow
     engine" section in full and re-invoke Workflow with the entire
     block pasted **verbatim** (resist the urge to "improve" it).
   - **`meta must be a pure literal`** → the `export const meta`
     block was altered (an interpolation, a spread, a computed
     value). Re-paste it from the canonical block.
   - **`args ... unparseable string` / `no passes to run`** → `args`
     was passed as a string, or with a missing key. Reconstruct the
     args object from your step-2 parse output (the array of
     structured pass objects, plus `planPath`, `specPath`,
     `priorCleared`).
   Retry the launch up to **3 times**. Only after a 3rd consecutive
   failure — at which point the issue is likely beyond the launch
   path (a latent bug in the canonical block itself, or a
   Workflow-tool issue) — surface every error verbatim to the user.
   The escalations in step 5 are the only legitimate user-facing
   pauses of this run; a launch error is not one of them.

   **Wait for the workflow.** Once it launches, the runtime notifies
   you when it returns — that notification arrives as a separate
   message on a later turn, possibly hours later. Do NOT poll. Do
   NOT call `Workflow` again "to check on it" — a second call
   spawns a parallel run. Do NOT assume completion without the
   notification. Sit quiet; the notification IS the wakeup. When it
   arrives, the return value is a result object — act on its
   `status` per step 5.

5. **Handle the result.**

   **You own completion.** The user ran `/execute-plan` to come back
   to a working product, not to a half-finished diff with a
   "couldn't get past this last bit" note. The walk-away contract
   binds *you*, the orchestrator, not just the workflow engine —
   the engine is one tool you drive toward completion, and what it
   returns is the *starting point* of your next decision, not the
   end of your responsibility. An escalation is the engine telling
   you "I stopped, here's where," not telling you "your turn to
   give up." Only when the work is *literally* impossible to
   advance (credentials only the user can provide; the plan itself
   is structurally broken; an architectural call only the user can
   make) does the run pause for the user. Mechanical defects, even
   ones the engine couldn't repair autonomously, are yours to fix
   and resume.

   - `status: "complete"` → the workflow cleared every pass, drained
     the deferred queue, the final verification gate passed, the
     no-deferral audit ran to clean, and the completion report was
     produced. Surface the report path and a one-line summary, then
     go to step 6.

   - `status: "escalate"` → the workflow stopped, but escalation is
     NOT the same as user-handoff. Read `lastFailure` and decide,
     in this order:

     **a. Can you repair this autonomously?** A concrete, fixable
     defect in the working tree — a build setting, a missing
     Info.plist entry, a project.yml omission, a missing module
     link, a single-line lint allowlist gap, a typo, a one-line
     plan-task gap whose fix is mechanical — IS your job to fix
     directly and resume the run with `resumeFromRunId`. You have
     the same tools the engine's fixer agents have; if the engine
     couldn't repair it in its capped cycles (the verifier fixer
     loops 3 times, the no-deferral fixer 3 times), that doesn't
     mean the repair is impossible — sometimes one more pair of
     eyes on the failure is what it needed. Diagnose, fix, resume.
     Repeat for as many turns as it takes; the resume primitive
     replays cached agents instantly, so iteration is cheap. This
     is the **primary** escalation-handling path, not the
     fallback.

     **b. Only if (a) is genuinely beyond reach, relay to the
     user.** Beyond reach means: the failure requires a decision
     they alone can make (architectural rework, choosing between
     incompatible approaches that the spec doesn't disambiguate),
     a resource you can't obtain (credentials, access), or
     authorization for a destructive action the plan doesn't
     cover. "I'd have to think hard about this" is not beyond
     reach. "The fix isn't obvious from the lastFailure alone" is
     not beyond reach — read the failing files, read the spec,
     read the diff, and *figure it out*. The bar for relaying is
     high: the work must be impossible for *you* to push through,
     not just inconvenient.

     When you do need to relay, the three kinds carry different
     framings:

     - `kind: "blocked"` — the strategist confirmed credentials /
       authorized destruction. Give the user the bullet, the
       detail, the strategist's `humanAsk` if any, and the passes
       already cleared. This kind almost always reaches the user;
       you cannot provide credentials autonomously.

     - `kind: "architectural-call"` — the strategist confirmed a
       genuine impasse with `escalateKind: 'architectural-call'`:
       the spec / plan / codebase admit multiple irreconcilable
       readings and the user must pick one. `strategistReport`
       carries the disinterested write-up (`concurringAnalysis`):
       what choice the user must make and the tradeoffs of each
       option. The escalation surfaces the strategist's analysis
       and asks the user to direct.

     - `kind: "invalid-plan"` — either (a) the engine's defensive
       validation found a pass missing its Falsifier brief or an
       acceptance pass missing its story slug annotation (`detail`
       carries the structural issue), or (b) the implementer
       declared the plan impossible to implement or unintelligible
       and the strategist concurred — `implementerReport` and
       `strategistReport` carry the full reasoning, or (c) the
       strategist concluded that a persistent failure (validator
       cannot be satisfied, verification cannot be cleared,
       no-deferral cannot be cleared) traces back to a structural
       plan defect — `strategistReport.concurringAnalysis`
       carries the diagnosis. This kind almost always reaches the
       user; structural plan defects need to go back to
       `write-plan` to rewrite. Before relaying, still attempt (a)
       if `lastFailure` names a concrete fix — sometimes the
       strategist over-reaches and a tweak you can make autonomously
       resolves it.

     **Resuming.** When you've applied a fix (autonomous or
     user-supplied), resume the workflow by re-invoking it with
     `resumeFromRunId: "<the original run ID>"` and the same
     `scriptPath`. The runtime replays the cached prefix of agents
     instantly and resumes live from the failing point. If you
     resume across an escalation that required restructuring (a
     plan rewrite, a removed pass), instead re-invoke with
     `args.passes` set to the remaining passes and
     `args.priorCleared` raised by this escalation's `cleared`
     count. In **either** resume mode, re-read
     `<plan>-deferred.jsonl` (per step 4) and pass its contents as
     `args.priorDeferred` — the deferred queue is durable across
     aborts and restarts, and the workflow seeds its in-memory queue
     from this argument every time.

6. **Final review (skill-side).** Invoke `ok-planner:review-work` for
   the full implementation; let `review-cleanup` drive the fix cycle
   to clean. The workflow's no-deferral audit already enforced
   completion; this is the holistic code-quality pass.

6a. **Regenerate design TOCs** if any pass touched
    `.ok-planner/design/concepts/`, `.ok-planner/design/stories/`, or
    `.ok-planner/design/decisions/`. For each touched directory,
    refresh its TOC (`concepts.md`, `stories.md`, or `decisions.md`)
    using the same format `discover-design`'s "Regenerate the design
    catalog summaries" step produces — read every file in the
    directory, extract slug + one-line summary, write the sorted
    alphabetical list under the standard header.

7. **Walk the completion report with the user** — four sections, in
   order, every entry:
   - **Proof walkthrough** — every story's proof artifact, exhibited
     working. Surface each demo/example/proof and walk it with the
     user. Gaps here go back to the implementer (the no-deferral
     audit should have caught them; flag a defect if any made it
     through).
   - **Technical decisions kept** — every spec TD the implementation
     honored as decided. Explicit enumeration; the user signs off.
   - **Technical decisions diverged** — every choice that changed,
     with flavor (improved / selected / necessitated) and reason.
     The user decides what (if anything) to rework.
   - **Coverage divergences** — findings from the closing coverage
     + intent-drift audit: coverage gaps (stories with no
     `@story:<slug>` annotation in the codebase), intent drifts
     (proof files no longer satisfying their story's Proof field),
     and dangling annotations (`@concept:<slug>` / `@story:<slug>`
     / `@decision:<slug>` annotations pointing at retired, missing,
     or kind-mismatched artifacts). For each finding, the user
     adjudicates: accept as informational, course-correct now (open
     a brainstorm to address), or bounce back to the implementer
     (process defect). Ideally this section is empty — the
     brainstorm dialogue gate and the validator's per-pass checks
     should have caught everything at change points. When it isn't
     empty, the entries are the safety net catching drift the
     earlier gates missed.

   The four sections together cover 100% of the spec manifest's
   stories + TDs, plus any coverage drift the closing audit
   surfaced. The report is the durable record; what the user
   walks IS what goes to history.

8. **Archive** the plan, its `<plan>-completion-report.md`, the
   linked spec, and the deferred-queue file into
   `.ok-planner/history/`:
   - `<plan>.md` and `<plan>-completion-report.md` →
     `.ok-planner/history/plans/`
   - spec from the plan's `**Spec:**` header →
     `.ok-planner/history/specs/`
   - `<plan>-deferred.jsonl` (if it exists at this point — it should
     not if the run completed cleanly, but archive it anyway as the
     durable record of what got triaged and cleaned up) →
     `.ok-planner/history/plans/`

   Use `git mv` if the project tracks `.ok-planner/` in git, otherwise
   plain `mv`. Skip the spec move if `**Spec:**` is `none`, missing,
   or points to a file that doesn't exist. Skip the deferred-queue
   move if the file does not exist. Tell the user what was moved in
   one short line.

## The workflow engine

Pass this as the `Workflow` `script`. It is plan-agnostic — it reads
everything from `args`. Each pass runs the implementer ↔ smart-validator
loop; the validator is the judge of whether the pass delivered, and
triages every issue into blocking (must fix to advance) or deferred
(captured for end-of-run cleanup).

```javascript
export const meta = {
  name: 'execute-plan-engine',
  description: 'Implementer + one smart validator per pass: validator reads the spec, the Falsifier brief, and the diff, and triages every issue into blocking (work materially fails the pass) or deferred (nits/polish/cross-pass-consistency captured for end-of-run cleanup). Blocking dispatches the implementer-as-fixer; the validator re-runs; loop until verdict=delivers. After all passes clear, the deferred-cleanup phase drains the accumulated queue with its own fixer ↔ reviewer loop; then the final verification gate (build/test/lint discovered from project docs) and the no-deferral audit run as fixer-loops until clean; finally the completion auditor writes the four-section report. Strategist is the single escalation gateway: every wall event (validator persistent-blocking, fixer BLOCKED, fixer coverage-gap, gate non-convergence, implementer BLOCKED/INVALID_PLAN) consults the strategist before the engine returns escalate. No cycle caps anywhere — the strategist\'s genuine verdict is the only thing that terminates a loop early. Prompts forbid silent giveup; schemas type the structured exits but cannot enforce conditional rules (top-level allOf is rejected by the Anthropic tool validator), so the orchestrator\'s coverage check and strategist gate are the behavioral enforcement.',
  phases: [
    { title: 'Execute', detail: 'implementer → smart validator → implementer-as-fixer per pass; deferred items captured into queue' },
    { title: 'Deferred', detail: 'drain the accumulated deferred queue with a fixer ↔ reviewer loop until clean' },
    { title: 'Verify', detail: 'final build + test + lint gate against the staged tree, looping until clean' },
    { title: 'Audit', detail: 'no-deferral gate looping until clean + completion auditor' },
  ],
}

// Input guard. Normalize a string payload (the args channel may stringify a
// large payload) and fail loud if `passes` is missing.
let input = args
if (typeof input === 'string') {
  try { input = JSON.parse(input) }
  catch (e) {
    throw new Error(`execute-plan-engine: args arrived as unparseable string (${e.message}); expected { passes:[…], planPath, specPath }.`)
  }
}
if (!input || typeof input !== 'object' || !Array.isArray(input.passes) || input.passes.length === 0) {
  const shape = input && typeof input === 'object'
    ? `an object with keys [${Object.keys(input).join(', ')}]`
    : `a ${typeof args} value`
  throw new Error(`execute-plan-engine: no passes to run — args resolved to ${shape}. Hand in { passes:[…], planPath, specPath }; if a large payload was dropped or stringified at the args seam, embed the passes in the script instead.`)
}

const passes = input.passes
const planPath = input.planPath
const specPath = input.specPath
const priorCleared = input.priorCleared || 0
const priorDeferred = Array.isArray(input.priorDeferred) ? input.priorDeferred : []

// Deferred queue is persisted to a JSONL file adjacent to the plan so an
// aborted run does NOT lose the validator's deferred findings. The skill
// reads this file before resuming and passes its contents in as
// `args.priorDeferred`. The workflow seeds `deferredQueue` from
// priorDeferred. Each validator agent appends its deferred findings to
// `deferredPath` directly (via Bash) before returning its structured
// output — instructed in validatorPrompt — so an abort between dispatches
// does not lose entries.
const deferredPath = (planPath || '').replace(/\.md$/, '-deferred.jsonl')

// Schemas

// REPORT_SCHEMA — structural validation of the implementer's three legal
// exits (DONE / BLOCKED / INVALID_PLAN). The conditional constraints that
// gate "partial-DONE is illegal" / "BLOCKED requires bullet+detail" / etc.
// cannot live in the schema: the Anthropic tool-input-schema validator
// rejects top-level oneOf/allOf/anyOf, so the if/then/else pattern that
// would mechanize those rules is unavailable. The implementer prompt below
// states them in prose and the orchestrator's per-pass loop is the
// behavioral enforcement; this schema's role is just typing.
const REPORT_SCHEMA = {
  type: 'object',
  required: ['status', 'tasks'],
  properties: {
    status: { enum: ['DONE', 'BLOCKED', 'INVALID_PLAN'] },
    tasks: {
      type: 'array',
      items: {
        type: 'object',
        required: ['number', 'done'],
        properties: {
          number: { type: 'integer' },
          done: { type: 'boolean' },
          summary: { type: 'string' },
        },
      },
    },
    // BLOCKED: external block (credentials/destruction). Bullet 1 or 2 + detail.
    blockedBullet: { enum: [1, 2] },
    blockedDetail: { type: 'string' },
    // INVALID_PLAN: plan-side break. Reason + concrete detail citing the
    // offending passage and the specific contradiction or ambiguity.
    invalidPlanReason: { enum: ['plan-impossible', 'plan-unintelligible'] },
    invalidPlanDetail: { type: 'string' },
  },
}

// VALIDATOR_SCHEMA — the smart validator's structured output. Triages every
// issue it finds into blocking (work materially fails the pass — pass cannot
// advance) or deferred (nits/polish/cross-pass-consistency — pass advances,
// queue drains at end-of-run). The verdict is determined by whether blocking
// is empty:
//   - verdict: 'delivers'        → blocking must be []
//   - verdict: 'does_not_deliver' → blocking must be non-empty
// That conditional rule cannot live in the schema (top-level allOf is
// rejected by the Anthropic tool validator). The validator prompt states the
// rule and the orchestrator behaviorally enforces it: a 'delivers' verdict
// with non-empty blocking is treated as 'does_not_deliver' (the blocking
// findings dispatch the fixer); a 'does_not_deliver' verdict with empty
// blocking is treated as 'delivers' (defensive — nothing to fix).
const VALIDATOR_SCHEMA = {
  type: 'object',
  required: ['verdict'],
  properties: {
    verdict: { enum: ['delivers', 'does_not_deliver'] },
    blocking: {
      type: 'array',
      items: {
        type: 'object',
        required: ['location', 'problem'],
        properties: {
          location: { type: 'string' },  // file:line
          problem: { type: 'string' },    // sharp, specific, fixer-actionable
          why: { type: 'string' },        // why it blocks the pass (cites falsifier / downstream dep / spec story)
        },
      },
    },
    deferred: {
      type: 'array',
      items: {
        type: 'object',
        required: ['location', 'problem'],
        properties: {
          location: { type: 'string' },   // file:line
          problem: { type: 'string' },     // sharp, specific, fixer-actionable
          why: { type: 'string' },         // why it matters (but doesn't block)
          category: { type: 'string' },    // e.g. 'polish' / 'doc-rule' / 'cross-pass-consistency' / 'dead-code' / 'wiring-nit'
        },
      },
    },
    rationale: { type: 'string' },         // brief explanation of the verdict
  },
}

// The strategist is the single escalation gateway. Every "we hit a wall"
// event in the engine — implementer-raised BLOCKED, implementer-raised
// INVALID_PLAN, fixer reporting BLOCKED, validator persistently surfacing
// the same blocking findings, a gate fixer-loop not converging, a coverage-
// retry loop failing — consults the strategist before the engine returns
// `escalate` to the orchestrator. The strategist either confirms the wall
// is real (genuine: true → engine escalates with the named escalateKind)
// or supplies a different approach the next dispatch tries (genuine: false
// → engine continues the loop with the strategist's framing as input).
// The "literally no way to proceed" gate is this agent's "genuine" verdict;
// nothing else terminates a loop early.
const STRATEGIST_SCHEMA = {
  type: 'object',
  required: ['genuine'],
  properties: {
    genuine: { type: 'boolean' },
    // What kind of escalation this is, when genuine. The orchestrator routes
    // the user-facing message based on this. Mirrors the engine's return kinds.
    //   - blocked: credentials / access / authorized destruction only the user
    //     can provide (strategist's bullet 1).
    //   - invalid-plan: the plan or spec is structurally broken and needs
    //     write-plan to rewrite (the validator-persistent / verification-stuck
    //     paths often surface this — what's failing is something the plan
    //     asked for that the codebase cannot deliver, or two parts of the
    //     plan that contradict).
    //   - architectural-call: the spec / plan / codebase admit multiple
    //     irreconcilable readings and the user must pick one (strategist's
    //     bullet 2; the user adjudicates via concurringAnalysis).
    escalateKind: { enum: ['blocked', 'invalid-plan', 'architectural-call'] },
    rootCause: { type: 'string' },
    approach: { type: 'string' },
    humanAsk: { type: 'string' },
    concurringAnalysis: { type: 'string' },
  },
  // "genuine: true → escalateKind required" cannot be enforced in the schema
  // (top-level if/then is via allOf, which the Anthropic tool validator
  // rejects). The strategist prompt states the rule, and the orchestrator
  // defaults escalateKind to 'invalid-plan' when missing on a genuine verdict.
}

// No-deferral audit: scans the diff for un-built work (stubs, TODOs,
// no-ops, etc). Each finding is a blocker until cleared.
const NO_DEFERRAL_SCHEMA = {
  type: 'object',
  required: ['findings'],
  properties: {
    findings: {
      type: 'array',
      items: {
        type: 'object',
        required: ['location', 'kind'],
        properties: {
          location: { type: 'string' },  // file:line
          kind: { type: 'string' },      // stub / no-op / TODO / deferred / etc.
          excerpt: { type: 'string' },
          why: { type: 'string' },       // why this is a deferral, not a legitimate WIP
        },
      },
    },
  },
}

// Deferred-cleanup reviewer: re-reads the queue entries against the current
// working tree and reports which are still present (residual). The fixer
// dispatches first against the queue; the reviewer is the independent check
// on which entries the fixer's "fixed" disposition actually landed for.
const DEFERRED_REVIEW_SCHEMA = {
  type: 'object',
  required: ['residual'],
  properties: {
    residual: {
      type: 'array',
      items: {
        type: 'object',
        required: ['location', 'problem'],
        properties: {
          location: { type: 'string' },
          problem: { type: 'string' },
          why: { type: 'string' },
          category: { type: 'string' },
        },
      },
    },
  },
}

// Structured fixer output: per-input-finding resolution by 1-based index.
// Used by the validator-rejection, deferred-cleanup, no-deferral, and
// verification fixers. Forces the fixer to acknowledge every finding
// individually rather than reporting "I fixed all N" prose that can silently
// drop items. Coverage is checked at the call site via `checkFixerCoverage`
// — every input index 1..N must appear exactly once. status=DONE iff every
// disposition is "fixed" or "already-clean"; BLOCKED iff any disposition is
// "blocked".
// FIXER_REPORT_SCHEMA — structural validation of the fixer's resolution
// shape. The "DONE forbids any disposition=blocked" / "BLOCKED requires
// blockedDetail + at least one blocked resolution" rules that mirror
// REPORT_SCHEMA's exits cannot live in the schema (top-level allOf is
// rejected by the Anthropic tool validator). The fixer prompt states them
// in prose, and the per-input-finding coverage check at the call site
// (`checkFixerCoverage`) plus the strategist gate on a fixer that returns
// BLOCKED-but-no-blocked-resolution catch the residual cases.
const FIXER_REPORT_SCHEMA = {
  type: 'object',
  required: ['status', 'resolutions'],
  properties: {
    status: { enum: ['DONE', 'BLOCKED'] },
    resolutions: {
      type: 'array',
      items: {
        type: 'object',
        required: ['index', 'disposition'],
        properties: {
          index: { type: 'integer' },          // 1-based index into the input findings list
          disposition: { enum: ['fixed', 'already-clean', 'blocked'] },
          summary: { type: 'string' },          // what changed (fixed) / why no fix was needed (already-clean) / what blocks (blocked)
          fileLines: { type: 'array', items: { type: 'string' } },  // file:line(s) of the change(s) when disposition=fixed
        },
      },
    },
    blockedDetail: { type: 'string' },  // populated when any resolution is "blocked": names what the user needs to provide
  },
}

// Completion auditor: produces the four-section report (proofs walked /
// decisions kept / decisions diverged / coverage divergences).
const COMPLETION_AUDIT_SCHEMA = {
  type: 'object',
  required: ['path'],
  properties: {
    path: { type: 'string' },
    proofsExhibited: { type: 'integer' },
    decisionsKept: { type: 'integer' },
    decisionsDiverged: { type: 'integer' },
    coverageGaps: { type: 'integer' },
    intentDrifts: { type: 'integer' },
    danglingAnnotations: { type: 'integer' },
  },
}

// Final verification gate. The verifier reads the project's own docs to
// discover the verification command set (no hardcoded commands — keeps the
// skill project-agnostic) and runs every command. A failure dispatches the
// verification fixer; the loop runs until the verifier reports passed=true
// OR the strategist confirms a genuine impasse. No fixed cycle cap.
const VERIFY_SCHEMA = {
  type: 'object',
  required: ['passed'],
  properties: {
    passed: { type: 'boolean' },
    commandsRun: { type: 'array', items: { type: 'string' } },
    failureSummary: { type: 'string' },
    failures: { type: 'array', items: { type: 'string' } },
  },
}

// Validates a fixer report's resolutions cover every input finding by
// 1-based index exactly once. Returns null on success, or a string
// critique the orchestrator passes back to the fixer on re-dispatch.
function checkFixerCoverage(report, expectedCount) {
  if (!report || !Array.isArray(report.resolutions)) {
    return `Fixer report missing the resolutions array; expected ${expectedCount} resolutions, one per input finding by 1-based index.`
  }
  const seen = new Map()
  for (const r of report.resolutions) {
    if (typeof r.index !== 'number' || r.index < 1 || r.index > expectedCount) {
      return `Resolution index ${r.index} is out of range; expected 1..${expectedCount}.`
    }
    if (seen.has(r.index)) {
      return `Resolution for index ${r.index} appeared more than once; each input finding must appear exactly once.`
    }
    seen.set(r.index, r)
  }
  const missing = []
  for (let i = 1; i <= expectedCount; i++) {
    if (!seen.has(i)) missing.push(i)
  }
  if (missing.length) {
    return `Resolutions missing for input finding(s): ${missing.join(', ')}. Every finding must have a disposition (fixed / already-clean / blocked).`
  }
  return null
}

// Stable fingerprint of a findings/failures array — used by the loop-until-
// converged logic to detect "same problem reported twice in a row," which
// indicates the fixer can't make progress and the strategist should weigh
// in. Order-independent (sort the entries) so a fixer that returns findings
// in a different order doesn't read as "different."
function fingerprintFindings(findings) {
  if (!Array.isArray(findings) || findings.length === 0) return ''
  return findings.map(f => {
    const loc = f.location || ''
    const prob = f.problem || f.kind || f.why || f || ''
    return `${loc}::${String(prob).slice(0, 200)}`
  }).sort().join('|')
}

// Dispatches a fixer to produce a coverage-clean report. Loops until the
// fixer returns a structured report whose per-input coverage is complete —
// no fixed cap on attempts. If the same coverage gap appears twice in a
// row (the fixer can't comply with the schema even when told what's wrong),
// returns null to signal the caller it should consult the strategist. A
// null return is the only non-convergent outcome; otherwise the loop
// continues until the fixer complies.
async function dispatchFixerWithCoverage(promptFn, findings, baseLabel, phase) {
  let critique = null
  let report = null
  let priorGap = null
  let sameGapCount = 0
  let attempt = 0
  while (true) {
    attempt++
    report = await agent(promptFn(findings, critique), {
      label: `${baseLabel}.${attempt}`, phase, schema: FIXER_REPORT_SCHEMA,
    })
    if (!report) {
      log(`${baseLabel} fixer returned no result on attempt ${attempt}; signaling caller to consult strategist`)
      return null
    }
    const gap = checkFixerCoverage(report, findings.length)
    if (!gap) return report
    log(`${baseLabel} fixer coverage gap on attempt ${attempt}: ${gap}`)
    if (gap === priorGap) {
      sameGapCount++
      if (sameGapCount >= 2) {
        log(`${baseLabel} fixer hit the same coverage gap ${sameGapCount + 1} times in a row; returning null for strategist routing`)
        return null
      }
    } else {
      sameGapCount = 0
    }
    priorGap = gap
    critique = `Your prior attempt was rejected: ${gap}\n\nReturn the resolution covering every input finding by 1-based index, exactly once. Every finding (1..${findings.length}) gets a disposition: fixed / already-clean / blocked.`
  }
}

function storyRefs(p) {
  return String(p.storySlug || '').split(',').map(s => s.trim()).filter(Boolean)
    .map(s => `STORY-${s}`).join(', ')
}

function implementerPrompt(p, idx, total, priorFailure) {
  const hasSpec = specPath && specPath !== 'none'
  const acceptanceNote = p.isAcceptancePass
    ? `\nThis is an **acceptance pass** for ${storyRefs(p)}. Each story carries Acceptance, Falsifier, and Proof fields — read them in the spec. A story names what the user does and observes, in user terms; the delivery surface (CLI verb / HTTP route / wire message / job) is in the spec's relevant TD, not in the story. Your job is BOTH the integrating wiring AND, per story, the proof artifact (demo / example / executable proof) that story's Proof field specifies — a shared pass never merges artifacts away. Each artifact boots the real assembled product through the delivery surface the TDs prescribe, drives its story's Acceptance, exhibits the observable outcome, and uses the real value-delivering component — no stubs.\n\n**You MUST run each proof artifact yourself before reporting DONE, not just produce it** — unless the plan's \`## Manual checks after completion\` section explicitly documents that running it requires a deployed environment / credentials / external resource you don't have. In that case, the plan has set the boundary: producing the structurally-correct artifact is your job; executing it against the live environment is the user's manual check. Otherwise: boot the project's real stack (\`docker compose up\`, \`make compose-run\`, the project's all-in-one image, whatever it provides — you have a shell, you can boot it) and execute the demo / example / proof against it. Confirm its assertions actually pass. A proof artifact that *would* prove the story if executed, but that you never executed (and the plan didn't document as a manual check), is not a delivered proof — it is a *hopeful* one, and the bug surfaces only when someone else tries it. If the project has no obvious mechanism to boot the assembled stack, treat that as part of the pass: add the make target, the script, the docker-compose snippet — whatever runs your demos — and run them through it. Genuine BLOCKED on running a proof — boot infrastructure that requires credentials only the user can provide — is the only acceptable non-execution outside the plan's documented manual-check boundary.`
    : ''
  const retry = priorFailure
    ? `\n## Note from the orchestrator (prior dispatch did not clear)\n${priorFailure}\nThe working tree already holds the staged work from the prior dispatch(es) on this pass. Inspect the current state first and fix forward — repair or re-run what failed, but do NOT blindly redo a task that already landed (a non-idempotent edit applied twice corrupts the tree).\n`
    : ''
  return `You are the implementer for one pass of a plan, in a fresh context. The user designed this plan and trusts you to deliver this pass; the spec is the record of intent and the plan is the route — when wording is imperfect, build what the spec wants.

## Plan
Path: ${planPath}
## Spec (source of intent)
${hasSpec ? 'Path: ' + specPath : 'No separate spec file — the plan is the record of intent.'}

## This pass: Pass ${p.number} — ${p.name}
Goal: ${p.goal}
Falsifier (the observation that would mean this pass quietly failed to deliver): ${p.falsifier}
Position: pass ${idx + 1} of ${total}.
${acceptanceNote}${retry}
## Tasks in this pass (verbatim)
${(p.tasks || []).map(t => `### Task ${t.number}\n${t.text}`).join('\n\n')}

## Discipline
- The user is taking your DONE at face value. They designed this plan, but they will not re-read your diff line by line, and a subtle gap — a handler that exists but isn't wired, a test that passes without exercising the story — is exactly what they can't catch. You are the last set of eyes on this work. Before returning DONE, re-read your own diff against the pass goal and the Falsifier above, the way you'd check work for someone who depends on it being right.
- Read files before editing — the tree may already hold work from earlier tasks or a prior dispatch of this pass.
- Deliver THIS pass only; do not do work that belongs to other passes.
- Default to rigor on any tradeoff the plan/spec leaves open (correctness, completeness, durability, atomicity, no-data-loss over the cheaper shape); leave a code comment naming the property you protected.
- **Completeness is the floor; the only divergence is overshoot.** Deliver the full intent of this pass's tasks and the spec stories they serve. When something is ambiguous or under-specified, resolve it by the necessity test: build whatever is *necessary* for the relevant user-outcome to actually hold — including pieces the spec never spelled out (the proto wiring, the emit site, the registration that does real work) — and nothing *adjacent* the stories do not require. NEVER defer, narrow, stub, no-op, or leave a "TODO / out of scope / later pass" in place of real work; a deferral is not a legal outcome — it ships a gap the user will only discover when the feature silently doesn't work for them. If you genuinely cannot finish a piece, that is a BLOCKED (below), not a silent drop.
- The pass leaves the tree in a working state — never broken.
- Checkpoint after every task with \`git add -A\` (staging, not committing). NEVER revert/reset/stash/clean the tree, even one file — fix forward by editing. Do NOT commit.

## Design-doc mutations (if any task here touches them)
If a task mutates a file under \`.ok-planner/design/concepts/\`, \`design/stories/\`, \`design/decisions/\`, or \`design/tensions/\`, keep the body self-contained AND current-state only: no file paths, no \`code:\`/\`pkg:\` citations, no external-doc references (\`docs/...\`, READMEs, sibling-repo paths), no quoted code or lint allowlists, no "Owns / Does NOT own" sections naming code paths, no \`## Notes\` / \`## History\` / \`## Changelog\` section, no dated audit-trail entries, no "previously called X" / "used to be Y" / "changed per spec Z" lines, no forward-looking "TODO" / "deferred" / "will be replaced" content. Allowed citations: other artifact slugs (concept / story / decision) and invariant IDs under whatever numbering convention the codebase uses. Rewrite each affected section to describe the artifact as it now stands; git carries the lineage. If a task's wording leaks a path, an audit-trail line, or any backward/forward-looking framing, rewrite it as you implement — that counts as a divergence the completion auditor will record.

## The only two halt lanes — both narrow, both go to a skeptical strategist

The default is **deliver**. Halt only if one of these two situations literally and concretely applies. The strategist sees every halt-claim first and defaults to rejecting it; a halt-claim that doesn't survive the strategist costs you an implementer attempt and gets a different approach you must then deliver.

### BLOCKED — the world is blocking you
Only these two reasons:
1. Credentials, secrets, or access only the user can provide, with no workaround.
2. An unauthorized destructive or irreversible action the plan does not authorize.

Cite the specific resource or action. Anything else ("needs discussion", "I'd like approval", "a validator critique I disagree with") is NOT BLOCKED — deliver.

### INVALID_PLAN — the plan itself is broken
Only these two reasons:
1. \`plan-impossible\` — the plan as written is **literally impossible** to implement: a contradiction with the spec, with the codebase as it actually exists, or within the plan itself. Cite the exact passage and the specific contradiction.
2. \`plan-unintelligible\` — a passage of the plan admits **multiple incompatible readings** and you cannot pick one from spec intent. Cite the exact passage, name the readings, and show why spec intent does not disambiguate.

NEITHER reason qualifies on: "I'd prefer a different shape", "the tasks feel awkward", "more coupled than I expected", "I don't know how I'd do this" (without having tried), "the validator's critique was unfair." Those are not halts — make the call from spec intent and deliver.

The strategist will read the passage you cite, read the spec, and try to find a workable reading the necessity rule supports. If they find one, you get a different approach to try; declaring INVALID_PLAN without a concrete citation is the surest way to burn the attempt.

## Your return value (structured)
Return the report object. Status is one of:
- **DONE** — every task is done and the work fully satisfies the pass's Falsifier brief. The schema enforces this: \`status: DONE\` requires every task entry to carry \`done: true\`. A partial-DONE (some tasks marked done=false while claiming status=DONE) is a schema violation — the runtime rejects it and you re-run. If you can't finish a task, your only legal alternative is BLOCKED with a concrete per-task reason.
- **BLOCKED** — set \`blockedBullet\` (1 or 2) and \`blockedDetail\` (concrete: which resource, which action, which task) per the BLOCKED lane above. The schema requires both fields with a non-trivial detail.
- **INVALID_PLAN** — set \`invalidPlanReason\` (\`plan-impossible\` or \`plan-unintelligible\`) and \`invalidPlanDetail\` (cite the exact passage and explain the contradiction or ambiguity) per the INVALID_PLAN lane above. The schema requires both.

You may not end your cycle except by one of these three statuses with the required fields filled in. There is no "I got tired" exit; there is no partial-DONE. Either deliver every task, or raise a structured BLOCKED/INVALID_PLAN with a stated reason.

Always list each task's number and done-state.`
}

function validatorPrompt(p) {
  const hasSpec = specPath && specPath !== 'none'
  const storyContext = p.isAcceptancePass
    ? `

This is an **acceptance pass** for ${storyRefs(p)}. Each story carries Acceptance, Falsifier, and Proof fields — read them in the spec in full before judging. The validator's contract for acceptance passes: the proof artifact at the story's Proof-named path (a) exists, (b) carries an \`@story:<slug>\` annotation at the top, (c) boots the real assembled product through the delivery surface the spec's relevant TD prescribes (NOT in-process construction calling handlers directly), (d) uses the real value-delivering component (NOT a canned stub), (e) drives the story's Acceptance and exhibits/asserts the observable outcome. **Bound your scope at execution.** If the plan's \`## Manual checks after completion\` section explicitly documents that running the proof requires a deployed environment, credentials, or external resources the autonomous run does not have, then the plan has set the boundary: structural correctness is your concern; execution is the user's manual check. Do NOT raise "the proof wasn't executed against a live stack" as either a blocking or deferred finding in that case. If the plan does NOT document execution as manual, the implementer was supposed to execute it as part of producing it — verify they did (look for output evidence, a captured log, a test run) and raise a blocking finding if they didn't.`
    : ''
  return `You are the **smart validator** for one pass of a plan. Your job is adversarial: read the pass, the spec, and the diff, and judge — was the work done? Default to **does_not_deliver** until you've affirmatively convinced yourself the diff satisfies the pass's Falsifier.

## Plan
Path: ${planPath}
## Spec (source of intent)
${hasSpec ? 'Path: ' + specPath : 'No separate spec file — the plan is the record of intent.'}

## This pass: Pass ${p.number} — ${p.name}
Goal: ${p.goal}
Falsifier (the observation that would mean this pass quietly failed to deliver): ${p.falsifier}${storyContext}

## What you do

1. **Read the spec and the pass** (and, for acceptance passes, the story in detail). Understand the intent.
2. **Read the diff** — \`git diff\`, \`git diff --staged\`, \`git status\` for untracked. Read modified and new files for context. The implementer's staged work is in the tree.
3. **Walk the Falsifier against the diff first.** This is your primary contract. For each absence the Falsifier names, find the corresponding code. If the absence holds — the code does NOT do what the Falsifier requires — that's a blocking finding.
4. **Sweep for everything else.** Investigate as broadly as your judgment says is needed: trace wiring (handler registered? subscriber consuming? entry-point importing?), check shared-surface changes for un-updated callers, audit acceptance-proof artifacts for structural correctness, audit design-doc edits against the self-containment + current-state-only rules if the diff touches \`.ok-planner/design/\`, scan for stubs/TODOs/no-ops the no-deferral gate would catch later. Use Bash, Read, Grep liberally — you have full tool access.
5. **Triage every issue you find.** For each one, decide: is this BLOCKING or DEFERRED?

## Triage — the rule

The triage rule is the load-bearing judgment. Apply it sharply:

**BLOCKING** — the pass cannot advance. Symptoms:
- The pass's Falsifier holds against the diff (the named absence is present).
- A downstream pass depends on something missing, broken, or wired-wrong here, and the downstream's own implementer would discover the gap and stall.
- A user-observable behavior the spec promises fails — wrong result, missing result, broken response.
- An acceptance proof that doesn't structurally exhibit its story (wrong delivery surface, stubbed value-delivering component, asserts \`true\`, missing \`@story:\` annotation, missing entirely).
- A bug that would cause production misbehavior — race condition on a write path, missing auth check, leaked secret, idempotency violation, transaction-boundary error.
- A handler exists but isn't registered with the router; an event type emits but no subscriber consumes; a config flag is accepted but never read.

**DEFERRED** — the pass advances; the issue goes to the cleanup queue:
- Polish, nits, formatting.
- Doc-rule leaks in design-doc edits (audit-trail phrasing, file-path citations, "previously was X" lines).
- Cross-pass consistency issues that don't affect functionality (naming inconsistencies, helper duplication, magic-string repetition).
- Dead code (unused imports, unreachable branches, stale comments).
- Missing-but-non-critical pieces (an exported symbol nothing yet imports, a defensive check for an impossible case).
- Code-quality issues review-work would otherwise catch later.

When in doubt between blocking and deferred, ask: *if I let this through, will the user discover it before I do?* If yes (the next pass's implementer will hit it, the verify gate will hit it, the user running the proof will hit it) → BLOCKING. If no (it sits in the code as a paper cut review-work or the cleanup phase will catch) → DEFERRED.

## Bound your scope

- **Manual-check items are not your concern.** If the plan documents something as a manual check (\`## Manual checks after completion\`, "deploy and run X," "manually invoke against staging"), that is explicitly outside the autonomous run's contract. Do NOT raise it as either blocking or deferred. The acceptance-proof rule above is the special case; the general rule is the same.
- **The validator's job is to argue against the pass's delivery, not to redesign it.** If the implementer chose a workable shape that differs from a shape you'd prefer, that is not a finding. Spec-divergent choices that the user might want to know about end up in the completion auditor's section 3 (decisions diverged); they are not validator findings.
- **Stay inside what's in the diff and what's necessary for the spec stories.** Do not raise findings on pre-existing code the diff didn't touch (regression sweeps on touched callers ARE in scope; ambient cleanup of nearby files is NOT).

## Adversarial defaults

- Default to **does_not_deliver**. Confirm "delivers" only when you've actively walked the Falsifier and traced the work end-to-end.
- Cite specific file:line evidence in every finding.
- A sharp, fixer-actionable problem statement beats a fuzzy critique. "src/handler.js:42 — the route registers as POST but the spec's TD prescribes PUT" beats "the routing seems wrong."
- Do NOT pad. A finding outside the triage rules dilutes the signal; a real defect not surfaced means the next gate has to catch it instead.

## Convergence contract

If you report \`verdict: does_not_deliver\` with blocking findings, the orchestrator dispatches the implementer-as-fixer against those findings (only), then re-runs you against the fixed tree. The loop runs until you report \`verdict: delivers\` OR the strategist confirms a genuine impasse (you returning the same blocking findings twice in a row triggers strategist consultation). Deferred findings accumulate across passes and drain in a dedicated cleanup phase after all passes clear.

## Persist deferred findings BEFORE returning your structured output

The deferred queue must survive an abort. The workflow may be killed at any moment; your in-memory \`deferred\` array is lost the instant your process ends. The durable record is a JSONL file adjacent to the plan, and writing to it is YOUR job, not the orchestrator's. **You must append every deferred finding to the queue file BEFORE you call your final structured-output tool.**

### File to append to
\`${deferredPath}\`

### What to write
For EACH deferred finding you are about to return, one JSON object per line, with these keys (in this exact shape — the cleanup phase reads them):
- \`location\`: the file:line string (verbatim from your \`location\` field)
- \`problem\`: the problem string (verbatim from your \`problem\` field)
- \`why\`: the why string (verbatim from your \`why\` field; empty string if you have nothing to add)
- \`category\`: the category tag (verbatim from your \`category\` field)
- \`_pass\`: the integer ${p.number} (this pass's number — write it literally)

### How to write
Use Bash, with a heredoc to avoid shell-quoting issues. The heredoc delimiter \`VAL_EOF\` is fixed; do NOT put that string on its own line anywhere in your finding text.

\`\`\`bash
mkdir -p "$(dirname "${deferredPath}")"
cat >> "${deferredPath}" <<'VAL_EOF'
{"location":"src/foo.js:42","problem":"unused import of bar","why":"dead code","category":"dead-code","_pass":${p.number}}
{"location":"src/baz.ts:117","problem":"...","why":"...","category":"polish","_pass":${p.number}}
VAL_EOF
\`\`\`

Then verify the lines landed: \`tail -n <count> "${deferredPath}"\`. If the tail does not show what you wrote, **retry** before returning your structured output — do not return a deferred array whose entries didn't make it to disk.

### Skip the write only when there are no deferred findings
If your \`deferred\` array will be empty, do nothing — do not touch the file. The orchestrator handles empty.

### Why this matters
The cleanup phase at end-of-run reads from your in-memory queue if the workflow completes normally, but reads from this file (via the skill's \`args.priorDeferred\` seed) if the workflow is aborted and restarted. The file is the only thing the next run can find. A deferred finding you returned but did not write is a paper cut that will silently disappear if anyone kills the workflow before the cleanup phase runs.

## Your return value (structured)

- **verdict**: \`delivers\` or \`does_not_deliver\`.
  - \`delivers\` requires the blocking array to be empty.
  - \`does_not_deliver\` requires the blocking array to be non-empty.
  - These conditional rules cannot live in the schema; the orchestrator behaviorally enforces them — a 'delivers' verdict with non-empty blocking is treated as 'does_not_deliver' (the blocking findings dispatch the fixer); a 'does_not_deliver' verdict with empty blocking is treated as 'delivers' (defensive — nothing to fix).
- **blocking**: array of \`{ location, problem, why }\`. Each entry must be a real pass-blocker per the triage rule. \`why\` cites the falsifier, the downstream dependency, or the spec story that makes this pass-blocking.
- **deferred**: array of \`{ location, problem, why, category }\`. Each entry is a real issue but not pass-blocking. \`category\` is a short tag (e.g. 'polish', 'doc-rule', 'cross-pass-consistency', 'dead-code', 'wiring-nit') so the cleanup phase can group them for the fixer. **Every entry returned here must also have been appended to the queue file per the persistence rule above.**
- **rationale**: one short paragraph on the verdict — what you checked, why you concluded delivers vs. does_not_deliver. Especially useful when you raise zero findings of either kind (delivers, clean) to document what you actually checked.
`
}

function strategistContext(p) {
  const hasSpec = specPath && specPath !== 'none'
  return `## Plan
Path: ${planPath}
## Spec
${hasSpec ? 'Path: ' + specPath : 'No separate spec file.'}

## This pass
Goal: ${p.goal}
Falsifier: ${p.falsifier}`
}

function strategistBlockedPrompt(p, report) {
  return `An implementer reported BLOCKED on Pass ${p.number} — ${p.name}. You are the strategist: decide, skeptically, whether the BLOCKED is genuine, and — if not — supply a different approach the next implementer should try. Default to NOT genuine.

## The two valid BLOCKED conditions
1. Credentials or access only the user can provide (a secret, an API key, a remote resource) with no workaround.
2. An unauthorized destructive or irreversible action the plan does not authorize.

Anything else — "needs discussion," "the plan was wrong about X," "more coupled than expected," "I'd like approval," "a validator critique I disagree with" — does NOT qualify. Default to genuine: false.

## The implementer's report
Bullet cited: ${report.blockedBullet || '(none given)'}
Detail: "${report.blockedDetail || ''}"

${strategistContext(p)}

## What you do
Read the pass, the spec, and the CURRENT working tree (the prior implementer's staged work is there).

- If the situation plainly fits bullet 1 or 2 above, set genuine: true and state exactly what the user needs to provide as humanAsk.
- Otherwise, set genuine: false. Diagnose the **root cause** the prior implementer hit — the underlying reason it stalled, not the surface symptom. Then prescribe a concrete, DIFFERENT approach: specifically what to do differently this time, not "try harder" and not a restatement of the plan.

## Your return value
- genuine: bool (default false unless bullet 1 or 2 plainly applies)
- rootCause: one-line read of why the prior attempt stalled (when not genuine)
- approach: the different approach to try (when not genuine)
- humanAsk: the specific user input needed (when genuine)
`
}

// Generalized strategist prompt for any wall event other than the
// implementer's halt-lane (BLOCKED / INVALID_PLAN). Called when: a fixer
// reports status=BLOCKED, the validator persistently surfaces the same
// blocking findings, a coverage-retry loop returns null, a gate (verify /
// no-deferral / deferred-cleanup) can't converge. The strategist either
// confirms the wall is real (genuine: true → engine escalates) or supplies
// a different approach the next dispatch tries (genuine: false → engine
// loops with the new framing). There is no cap on strategist invocations —
// every wall event passes through this gate before the engine escalates.
function strategistStuckPrompt(p, situationKind, situationDetail) {
  return `You are the strategist for Pass ${p.number} — ${p.name}. The workflow engine has hit a wall and is consulting you before escalating to the user. Decide, skeptically, whether the situation is genuinely impossible to advance autonomously — or whether a different approach can break the impasse. Default to NOT genuine. The wall is usually a sign the prior agent missed something the next agent (with different framing) can catch.

## The situation
Kind: ${situationKind}

${situationDetail}

${strategistContext(p)}

## The escalate kinds and when they apply

Set \`genuine: true\` ONLY when one of these plainly fits. Default is \`genuine: false\`.

- **\`blocked\`** — credentials, secrets, or access only the user can provide, with no workaround; OR an unauthorized destructive / irreversible action the plan does not cover. Populate \`humanAsk\` with the specific resource or authorization needed.
- **\`invalid-plan\`** — the plan or spec is structurally broken: it asks for something the codebase cannot deliver (e.g. validator-persistent findings whose fix is forbidden by another part of the spec), it contradicts itself, or it omits a piece the necessity rule demands but no agent can synthesize. The fix is at write-plan / brainstorm time, not at execute-plan time. Populate \`concurringAnalysis\` with the structural defect — what specifically breaks, what alternative readings/workarounds you considered, why each fails — enough for the user to take it back to brainstorm.
- **\`architectural-call\`** — the spec / plan / codebase admit multiple irreconcilable readings and the user must pick one. The agents are not stuck on a mechanical issue; they are stuck on a judgment call that requires the user's intent. Populate \`concurringAnalysis\` with the choice the user must make and the tradeoffs of each option.

## What you do
Read the working tree state, the spec, the plan, and the situation detail above. Actively try to find a workable approach — a different framing for the next dispatch, a re-scoping that avoids the impasse, a re-reading of the findings that exposes a path forward. Implementers and fixers under load are prone to circling around the surface of a problem; your job is to read carefully and propose a different angle.

- If, after that search, the situation plainly fits one of the three escalate kinds above: set genuine: true, set escalateKind, and populate the appropriate field (humanAsk for blocked, concurringAnalysis for invalid-plan / architectural-call).
- Otherwise, set genuine: false. Diagnose the rootCause — the underlying reason the prior agents stalled, not the surface symptom. Prescribe a concrete, DIFFERENT approach: specifically what to do differently this time, not "try harder" and not a restatement of what was already attempted. The next dispatch reads your approach and works against it.

## Your return value
- genuine: bool (default false unless one of the three escalate kinds plainly applies)
- escalateKind: one of "blocked" / "invalid-plan" / "architectural-call" (required when genuine; pick the kind that best fits)
- rootCause: one-line read of why the prior agents stalled (when not genuine)
- approach: the different approach to try (when not genuine)
- humanAsk: the specific user input needed (when genuine with kind=blocked)
- concurringAnalysis: the disinterested write-up the user reads (when genuine with kind=invalid-plan or architectural-call)
`
}

function strategistInvalidPlanPrompt(p, report) {
  return `An implementer reported INVALID_PLAN on Pass ${p.number} — ${p.name}. You are the strategist: decide, skeptically, whether the plan as written is **genuinely** impossible to implement or unintelligible — or whether a different reading or approach makes it workable. Default to NOT genuine. Implementers under load are tempted to find ambiguity where careful reading would resolve it; your job is to read carefully.

## The two valid INVALID_PLAN conditions
1. \`plan-impossible\` — the plan, as written, is **literally impossible** to implement: a contradiction with the spec, with the codebase as it exists, or within the plan itself.
2. \`plan-unintelligible\` — a passage of the plan admits **multiple incompatible readings** and spec intent does not disambiguate among them.

Anything else — "I'd prefer a different shape," "the tasks are awkward," "more coupled than expected," "I don't know how I'd do this," "a validator critique I disagree with" — does NOT qualify.

## The implementer's report
Reason cited: ${report.invalidPlanReason || '(none given)'}
Detail: "${report.invalidPlanDetail || ''}"

${strategistContext(p)}

## What you do
Read the passage of the plan the implementer cited, in its full context. Read the spec sections it depends on. Inspect the codebase where the implementer points (the prior implementer's staged work is in the tree if any landed). Actively try to find a workable reading — the necessity rule, the spec's intent, an interpretation the implementer missed, a sequencing or scoping fix that resolves the contradiction.

- If, after that search, the contradiction or ambiguity genuinely holds: set genuine: true. Write \`concurringAnalysis\` as a thorough, disinterested write-up — name the specific contradiction or ambiguity from outside the implementer's head, list every alternative reading or workaround you considered, and explain why each fails. **This is the report the user reads when adjudicating the escalation**; it must give them enough to decide whether to rewrite the pass, rework the plan, or change the spec.
- Otherwise, set genuine: false. Diagnose the \`rootCause\` — what the implementer read into the plan that isn't there, or what they missed. Prescribe a concrete, DIFFERENT \`approach\` — the reading you found that makes the plan workable, specific enough that the next implementer can execute it.

## Your return value
- genuine: bool (default false unless one of the two conditions plainly holds against your reading)
- rootCause: one-line read of why the prior attempt declared invalid (when not genuine)
- approach: the different reading / approach to try (when not genuine)
- concurringAnalysis: the thorough disinterested write-up (when genuine) — the user reads this
`
}

// Implementer-as-fixer prompt for the validator-rejection path. Once the
// pass's tasks are claimed done (status=DONE per the schema), a validator
// rejection means specific BLOCKING findings need addressing — not a re-run
// of the whole pass, and not the deferred findings (those go to the
// end-of-run cleanup phase). The fixer dispatches against the validator's
// blocking findings via dispatchFixerWithCoverage, producing per-input
// coverage.
//
// Takes priorImplementerReport so the fixer's prompt includes the prior
// implementer's task-completion summaries — that primes the fixer to start
// from "I'm continuing the prior implementer's work" rather than "I'm a
// fresh hire reading the codebase from scratch." Reduces context-rebuild
// cost on every fixer dispatch.
function validatorRejectionFixerPrompt(findings, priorCritique, p, priorStrategistApproach, priorImplementerReport) {
  const list = findings.map((f, i) => `${i + 1}. ${f.location} — ${f.problem}${f.why ? `\n   Why blocking: ${f.why}` : ''}`).join('\n')
  const retryNote = priorCritique ? `\n## Note from the orchestrator (prior attempt rejected)\n${priorCritique}\n` : ''
  const strategistNote = priorStrategistApproach ? `\n## Strategist's framing for this attempt\nPrior attempts hit a wall. The strategist diagnosed the underlying issue and proposes:\n\n${priorStrategistApproach}\n\nUse this framing.\n` : ''
  const priorTasks = (priorImplementerReport && Array.isArray(priorImplementerReport.tasks))
    ? priorImplementerReport.tasks.filter(t => t.done && t.summary)
        .map(t => `- Task ${t.number}: ${t.summary}`).join('\n')
    : ''
  const priorWorkBlock = priorTasks
    ? `\n## Where you came in — what the prior implementer just finished\nThe pass's implementer reported these task completions before the validator ran:\n\n${priorTasks}\n\nThe staged tree carries that work. **Run \`git status\` and \`git diff --stat\` first** to orient yourself against the diff shape — you are continuing this work, not starting fresh. Read the cited files in the findings before editing.\n`
    : `\n## Where you came in\nThe pass's implementer dispatched before you and the staged tree carries their work. **Run \`git status\` and \`git diff --stat\` first** to orient yourself, then read the cited files in the findings before editing.\n`
  return `You are the implementer-as-fixer for Pass ${p.number} — ${p.name}. The pass's tasks were claimed done in a prior dispatch and the smart validator rejected the work with ${findings.length} structured BLOCKING finding(s) — each one is a real pass-blocker per the validator's triage rule (falsifier holds, downstream dep broken, user-observable behavior failing, acceptance proof structurally wrong, etc.). Your job is to address EVERY one. The validator may also have surfaced deferred findings; those are NOT in your scope here — they go to a separate end-of-run cleanup phase. Focus only on the blocking list below.
${retryNote}${strategistNote}${priorWorkBlock}
## Pass context
Goal: ${p.goal}
Falsifier: ${p.falsifier}

## Blocking findings to address (each numbered 1..${findings.length}; the structured return below indexes back into these)
${list}

## What to do
For each finding, address the underlying problem in the working tree. The tree already holds prior dispatches' staged work — read the cited files first and fix forward. Some findings may require re-doing a task that was claimed done; some may require new work the original tasks did not literally name but the spec's intent requires (the necessity rule). The work is not delivered until every blocking finding resolves and the Falsifier above no longer holds.

## Discipline
- Read each cited file before editing.
- Address the underlying problem, not the symptom the validator quoted.
- NEVER revert/reset/stash/clean. Fix forward by editing.
- Checkpoint with \`git add -A\` after each fix.
- Default to rigor on any tradeoff (correctness, completeness, durability over the cheaper shape).
- Do NOT introduce stubs, TODOs, no-ops, or "for now" markers.

## Your return value (structured — per-input-finding accounting)

Return the resolution object covering ALL ${findings.length} input findings:

- **status**: DONE iff every resolution disposition is "fixed" or "already-clean" (schema-enforced). BLOCKED iff any resolution is "blocked" — but a "blocked" disposition routes to the strategist before escalating, so use it only when a finding genuinely cannot be addressed without user input.
- **resolutions**: exactly ${findings.length} entries, one per input finding, indexed by 1-based input position. Every index 1..${findings.length} must appear exactly once.
- Per resolution:
  - **index**: the 1-based input finding this resolution covers.
  - **disposition**:
    - "fixed" — you made a change that addresses the finding. \`summary\` names what changed; \`fileLines\` lists file:line of the edit(s).
    - "already-clean" — the finding mis-identified the issue, OR another fix in this dispatch upstream-resolved it. \`summary\` cites concrete evidence (a re-grep, a file inspection); without evidence this reads as a silent drop.
    - "blocked" — you cannot address this finding (credentials/access/architectural-call only the user can provide). \`summary\` names the specific block; \`blockedDetail\` summarizes the user-ask.

The orchestrator validates coverage at the call site. A report missing findings, duplicating indices, or going out of range is rejected and re-dispatched with the coverage critique — no fixed cap, the loop continues until coverage is clean or the strategist confirms the fixer cannot comply.

The validator will independently re-run after your fix; a "fixed" disposition that the validator still rejects on the next dispatch is evidence the fix did not address the underlying issue — the next dispatch sees the residual finding.
`
}

// Deferred-cleanup fixer prompt. Takes the accumulated deferred queue (every
// non-blocking finding the validators surfaced across all passes, tagged
// with originating pass and category) and dispatches the fixer against the
// whole batch. The fixer reports per-input via the coverage protocol —
// fixed (with summary + fileLines) / already-clean (with cited evidence) /
// blocked (with user-ask).
function deferredCleanupFixerPrompt(findings, priorCritique, priorStrategistApproach) {
  const list = findings.map((f, i) => `${i + 1}. [pass ${f._pass || '?'} | ${f.category || 'uncategorized'}] ${f.location} — ${f.problem}${f.why ? `\n   Why: ${f.why}` : ''}`).join('\n')
  const retryNote = priorCritique ? `\n## Note from the orchestrator (prior attempt rejected)\n${priorCritique}\n` : ''
  const strategistNote = priorStrategistApproach ? `\n## Strategist's framing for this attempt\nPrior attempts hit a wall. The strategist diagnosed the underlying issue and proposes:\n\n${priorStrategistApproach}\n\nUse this framing.\n` : ''
  return `You are the **deferred-cleanup fixer**. Every pass of the plan has cleared its per-pass validator, but during each pass the validator surfaced ${findings.length} DEFERRED finding(s) — issues the validator triaged as not pass-blocking but still needing fixing before close. The accumulated queue is below; your job is to address every one of them.

The findings span all the categories the validators triaged into deferred: polish, doc-rule leaks in design-doc edits, cross-pass consistency, dead code, missing-but-non-critical wiring. Each finding's prefix (\`[pass N | category]\`) tells you which pass originated it and what kind of cleanup it is.

**Run \`git status\` and \`git diff --stat\` first** to orient yourself; the staged tree carries work from every pass. Read the cited files in the findings before editing.
${retryNote}${strategistNote}
${specPath && specPath !== 'none' ? `Use the spec at ${specPath} as the source of intent.` : `Use the plan at ${planPath} as the source of intent.`}

## Findings to fix (each numbered 1..${findings.length}; the structured return below indexes back into these)
${list}

## Discipline
- Read each cited file before editing.
- Fix the underlying problem, not the symptom the validator quoted.
- Stay inside the work the passes already delivered — do NOT build net-new functionality.
- Do NOT introduce stubs, TODOs, or deferrals while fixing these (a fix that introduces a TODO is a no-op).
- Leave the tree in a working state.
- Checkpoint with \`git add -A\` after each fix. NEVER revert/reset/stash/clean; do NOT commit.

## Your return value (structured — per-input-finding accounting)

Return the resolution object covering ALL ${findings.length} input findings:

- **status**: DONE iff every resolution disposition is "fixed" or "already-clean". BLOCKED iff any resolution is "blocked".
- **resolutions**: exactly ${findings.length} entries, one per input finding, indexed by 1-based input position. Every index 1..${findings.length} must appear exactly once. No index outside that range; no duplicates; no omissions.
- Per resolution:
  - **index**: the 1-based input finding this resolution covers.
  - **disposition**: one of:
    - "fixed" — you made a change that resolves the finding. \`summary\` names what changed in one short sentence; \`fileLines\` lists the file:line of the edit(s).
    - "already-clean" — the input mis-identified the issue, or it was resolved upstream by another fix. \`summary\` explains why no edit was needed (and cite evidence: a re-grep, a file inspection, etc. — "already-clean" without justification reads as a silent drop).
    - "blocked" — you cannot fix this finding (credentials/access/architectural-call only the user can provide). \`summary\` names the specific block; the top-level \`blockedDetail\` summarizes the user-ask.

The orchestrator validates coverage at the call site. A report missing findings, repeating indices, or going out of range is rejected and you are re-dispatched with the coverage critique. There is no fixed cycle cap on this retry — the loop runs until coverage is clean OR the strategist confirms you cannot produce a compliant report.

After this report, an independent reviewer re-checks the queue entries against the current tree and reports any that are still present (the residual). If any residual surfaces, the cleanup loop dispatches you again with just those — so a "fixed" disposition that the reviewer still sees gives you another shot.
`
}

function deferredCleanupReviewerPrompt(findings) {
  const list = findings.map((f, i) => `${i + 1}. [pass ${f._pass || '?'} | ${f.category || 'uncategorized'}] ${f.location} — ${f.problem}${f.why ? `\n   Why: ${f.why}` : ''}`).join('\n')
  return `You are the **deferred-cleanup reviewer**. A fixer just dispatched against ${findings.length} deferred finding(s) the per-pass validators surfaced. Your job is independent: re-check each entry against the CURRENT working tree and report which ones are still present (the residual). You are not a re-validator surveying the whole codebase — your scope is exactly the entries below.

**Run \`git status\` and \`git diff --stat\` first** to see the post-fix state of the tree. For each numbered entry, go look at the cited location and judge: is the problem the validator named still present, or has the fixer addressed it?

## Entries to re-check (the deferred queue, numbered 1..${findings.length})
${list}

## Adversarial defaults

- Default to **still-present** unless the cited location clearly shows the problem is gone. A fixer's "fixed" claim is not evidence — the file is.
- An entry that the fixer marked "already-clean" still needs your verification — if it was a misread, the location should show no issue; if the fixer dodged it, the issue is still there.
- An entry that the fixer marked "blocked" stays in the residual (the cleanup loop dispatches the fixer against the residual with the strategist's framing; if it's truly user-only, the strategist will escalate).

## Your return value

- **residual**: array of entries that are still present after the fixer's pass. Each entry carries the same shape as the input findings (\`location\`, \`problem\`, \`why\`, \`category\`) — so the next fixer dispatch can act on it. Include the entry's original location/problem text verbatim; do not re-word.

Return an empty residual array when every queue entry is genuinely resolved against the current tree.
`
}

function noDeferralAuditPrompt() {
  const specRead = specPath && specPath !== 'none' ? `spec ${specPath}; ` : ''
  return `You are the **no-deferral auditor**. The implementer just finished the plan and the deferred-cleanup phase drained the per-pass validators' queue. Your job is to find any place where promised work was deferred, stubbed, or otherwise not actually delivered — and surface it as a blocker, not a divergence.

Read: plan ${planPath}; ${specRead}the diff (\`git diff\`, \`git diff --staged\`, \`git status\` for untracked); and modified/new files where the diff lacks context.

## What counts as a deferral (a blocker)
Each of these is a finding the run does NOT advance past until cleared:

- A \`TODO\` / \`FIXME\` / \`XXX\` marker on a code path the spec depends on.
- A "later," "for now," "out of scope," "deferred," "not implemented," "stub," or "placeholder" comment in a function/handler/method the spec depends on.
- A handler / endpoint / class registered or declared but doing nothing (\`return nil\`, \`pass\`, \`{ /* TODO */ }\`).
- An error class declared but never emitted, an event type declared but never published.
- A config flag or field accepted but ignored.
- A function whose body is a hard-coded canned return when the spec asks for it to do real work.
- An acceptance pass's proof artifact missing, empty, trivially passing (asserts \`true\`, returns \`200\` without exercising the story), OR never actually executed against a running stack when the plan does NOT document execution as a manual check. If the plan's \`## Manual checks after completion\` section explicitly documents execution as a manual check (deployed environment / credentials / external resource), the artifact's structural correctness is enough — do NOT flag non-execution in that case.
- Any \`raise NotImplementedError\` / \`panic("unimplemented")\` / \`throw new Error("not yet")\` on a spec-dependent path.

## What does NOT count (do not flag)
- Tests / examples that the spec did not require (these are normal absences, not deferrals).
- Test helpers or fixtures that intentionally short-circuit (a fixture's job is to be canned).
- Comments noting historical decisions or alternatives considered.
- Code paths that are intentionally NOT part of the spec.

## Your return value
List every finding. For each:
- location: file:line
- kind: stub / no-op / TODO / placeholder / canned / hollow-proof / etc.
- excerpt: the literal text from the code
- why: why this is a deferral and what the spec requires there

Return an empty findings array only when the diff is genuinely deferral-free.
`
}

function noDeferralFixerPrompt(findings, priorCritique) {
  const list = findings.map((f, i) => `${i + 1}. ${f.location} — ${f.kind}: ${f.why || '(no rationale)'}\n   Excerpt: ${f.excerpt || ''}`).join('\n')
  const retryNote = priorCritique ? `\n## Note from the orchestrator (prior attempt rejected)\n${priorCritique}\n` : ''
  return `The no-deferral auditor found ${findings.length} deferral(s) in the just-completed plan. Each is a completion failure that must be cleared before the run advances. Fix every one of them.
${retryNote}
## Findings to clear (each numbered 1..${findings.length}; the structured return below indexes back into these)
${list}

## What to do
For each finding, finish the work the deferral was avoiding. ${specPath && specPath !== 'none' ? `Use the spec at ${specPath} as the source of intent.` : 'Use the plan as the source of intent (no separate spec file).'} Build whatever is *necessary* for the spec's stories to actually hold — including pieces the spec did not literally name (the necessity rule).

## Discipline
- Read each cited file before editing.
- Do NOT change the structure of the deferral marker itself ("change the TODO to DONE"); fix the underlying work the marker stood in for.
- Default to rigor on any tradeoff (correctness, completeness, durability).
- Checkpoint with \`git add -A\` after each fix.
- Do NOT introduce new deferrals while fixing these.

## Your return value (structured — per-input-finding accounting)

Return the resolution object covering ALL ${findings.length} input findings:

- **status**: DONE iff every resolution disposition is "fixed" or "already-clean". BLOCKED iff any resolution is "blocked".
- **resolutions**: exactly ${findings.length} entries, one per input finding, indexed by 1-based input position. Every index 1..${findings.length} must appear exactly once.
- Per resolution:
  - **index**: the 1-based input finding this resolution covers.
  - **disposition**:
    - "fixed" — you wrote the deferred work. \`summary\` names what was implemented; \`fileLines\` lists the file:line of the change(s).
    - "already-clean" — the auditor mis-identified (e.g. flagged a fixture's intentional short-circuit). \`summary\` cites evidence (a re-read, a file context) and why no deferral exists. Use sparingly — the auditor is biased toward thoroughness, not false-positives.
    - "blocked" — finishing the deferred work requires user-only input. \`summary\` names the specific block; \`blockedDetail\` summarizes the user-ask.

The orchestrator validates coverage. A report with missing / duplicated / out-of-range indices is rejected and re-dispatched with the coverage critique. There is no fixed cycle cap — the loop runs until coverage is clean OR the strategist confirms you cannot comply.

The audit will independently re-run after your fix; a deferral that re-surfaces despite your "fixed" disposition is evidence the fix didn't land — the next cycle dispatches you again with the residual list. The loop runs until the auditor reports zero deferrals or the strategist confirms a genuine impasse.
`
}

function verifierPrompt() {
  const specRead = specPath && specPath !== 'none' ? `spec ${specPath}; ` : ''
  return `You are the **final verifier**. Every pass has cleared its implementer ↔ validator loop, and the deferred-cleanup phase has drained the queue. Your job is to run the project's full verification suite against the staged tree and confirm nothing is broken.

## What you do

1. **Identify the project's verification command set.** The skill is project-agnostic — it does not hardcode commands. Discover them by reading, in order, until you have a complete set:
   - The plan at ${planPath} — its plan-wide notes / "Verification commands" / "After each pass" section.
   - ${specRead}any verification section it carries.
   - The project's CLAUDE.md (look for "After Code Changes", "Verification", or analogous sections).
   - The project's Makefile / package.json / scripts directory for canonical aggregate targets (e.g. \`make verify\`, \`make test-all\`, \`npm test\`, \`go test ./...\`, \`pytest\`, \`cargo test\`).

   A typical set includes: build / type-check; unit tests; lint; race / concurrency-sensitive tests where the project's docs name them; integration / scenario / e2e tests if the plan touched code under their scope; **acceptance proof artifacts the plan produced under \`examples/\` (or wherever the project keeps them) if a runner exists** — a \`make demos\` / \`make examples\` target, a CI shell-runner step, or an equivalent. Acceptance proofs are part of the test corpus by intent; if the project has a way to execute them, the verification gate executes them. If the project has NO runner for its proof artifacts, note that in the failure summary as a project-level gap and recommend it as follow-up — but do not invent one inline; treat it as a coverage gap the user should address in the project's own docs/Makefile.

2. **Run every command in the set.** Use Bash. Capture output. Long-running commands are fine — set generous timeouts; this is the final gate.

3. **Read each command's output.** Distinguish *real failures* (build errors, test failures, lint errors, race detections) from *expected output* (test summaries, "X tests passed", warnings the project's docs say to ignore, intentionally skipped tests).

4. **If any command fails:** gather the failure context (failing file:line, error message, the relevant diff context that introduced it where you can identify it). Return passed=false with a one-line failureSummary plus a per-failure list.

5. **If everything passes:** return passed=true with the list of commands you ran.

## What NOT to do
- Do NOT fix failures. Your job is to detect, not repair. A failure dispatches a dedicated fixer agent that addresses the failure list; the verifier then re-runs against the fixed tree. Only after persistent same-failure cycles does the workflow escalate via the strategist gate.
- Do NOT skip a command because you think it's "already covered" by another.
- Do NOT substitute a faster command for one named in the project's docs.
- Do NOT commit or modify the tree.

## Your return value
- passed: boolean — true iff every command in the set returned success
- commandsRun: array of strings — the commands you actually ran, in order
- failureSummary: one-line summary of what failed (omit when passed=true)
- failures: array of strings, one per failing check, with file:line where available (omit when passed=true)
`
}

function verifyFixerPrompt(failures, priorCritique) {
  const failList = (failures || []).length
    ? (failures || []).map((f, i) => `${i + 1}. ${f}`).join('\n')
    : '(no per-failure detail returned by the verifier)'
  const retryNote = priorCritique ? `\n## Note from the orchestrator (prior attempt rejected)\n${priorCritique}\n` : ''
  return `You are the **verification fixer**. The final verification gate just failed. Your job is to fix every failure so the project's build / test / lint suite passes against the staged tree — no triage, no deferral, no skipping.
${retryNote}
## Failures to fix (each numbered 1..${(failures || []).length}; the structured return below indexes back into these)
${failList}

## What's in scope to fix
Anything the project's verification command set actually covers. The failures are real signals against the work just delivered — most are mechanical: build-config omissions (missing Info.plist setting, missing module link, wrong deployment target), test-target wiring, lint suppressions or allowlists the plan should have included, type errors in code the plan touched, missing dependency entries, project-yml gaps. Fix the underlying cause, not the symptom.

## What's NOT in scope
- Net-new spec capability — only fixes for what's already there.
- "Skip this test" / \`xfail\` / \`@Ignore\` / commenting-out a failing assertion to make red turn green. That's a deferral disguised as a fix.
- Removing a check from the verifier's command set. The command set is the project's contract; the fix is in the code, not the contract.
- Reverting prior pass work to dodge a failure. Fix forward.

## Discipline
- Read each failing command's output and trace the failure to the file(s) responsible.
- Default to rigor on any tradeoff the fix raises (correctness over the cheaper shape).
- Do NOT introduce stubs, TODOs, no-ops, or "for now" markers.
- Leave the tree in a working state.
- Checkpoint with \`git add -A\` after each fix. NEVER revert/reset/stash/clean; do NOT commit.

## Your return value (structured — per-failure accounting)

Return the resolution object covering ALL ${(failures || []).length} input failures:

- **status**: DONE iff every resolution disposition is "fixed" or "already-clean". BLOCKED iff any resolution is "blocked".
- **resolutions**: exactly ${(failures || []).length} entries, one per failure, indexed by 1-based input position. Every index 1..${(failures || []).length} must appear exactly once.
- Per resolution:
  - **index**: the 1-based input failure this resolution covers.
  - **disposition**:
    - "fixed" — you traced the failure and made a change that resolves it. \`summary\` names the root cause + the fix; \`fileLines\` lists the file:line of the edit(s).
    - "already-clean" — the failure is a pre-existing infrastructure flake unrelated to the plan's work (a transient network error, a Docker pool exhaustion the project should fix separately, etc.). \`summary\` cites the evidence: which command, which output, why it's not a real failure-against-the-work. Use sparingly — verifier failures default to "real."
    - "blocked" — fixing requires user-only input (credentials for an external service, a destructive action, an architectural call). \`summary\` names the specific block; \`blockedDetail\` summarizes the user-ask.

The orchestrator validates coverage. A report missing failures, duplicating indices, or going out of range is rejected and re-dispatched with the coverage critique. There is no fixed cycle cap — the loop runs until coverage is clean OR the strategist confirms you cannot comply.

The verifier will independently re-run after your fix; a failure that re-surfaces despite your "fixed" disposition is evidence the fix didn't land — the next cycle dispatches you again with the residual list. The loop runs until the verifier reports passed=true or the strategist confirms a genuine impasse.
`
}

function completionAuditPrompt() {
  const specRead = specPath && specPath !== 'none' ? `spec ${specPath}; ` : ''
  return `You are the **completion auditor**. The plan is complete, the deferred-cleanup phase has drained, the verification gate passed, and the no-deferral gate is clean. Your job is to produce a four-section report covering 100% of the spec PLUS coverage divergences surfaced by the closing audit: every story's proof exhibited working, every technical decision in the spec accounted for as kept or diverged, every proof-coverage divergence surfaced.

Read: plan ${planPath}; ${specRead}the spec's \`## Manifest\` section (the contract you walk); the diff; and any proof artifacts the implementer produced (demo scripts, example files, executable proofs).

Before writing the report, run the **closing coverage + intent-drift audit**:

**Coverage check (whole-corpus, cheap).** For every live story in \`.ok-planner/design/stories/<slug>.md\`, grep the codebase for \`@story:<slug>\` annotations (\`rg -n '@story:\\s*<slug>'\`). Record every story with **zero** matches — that story has no proof artifact (or its proof was removed, or its annotation drifted).

**Intent-drift check (spec-scoped, judgment).** For every story the spec touched (mutated under \`## Design changes\` or named in \`## Proof changes\`) AND every \`@story:<slug>\`-annotated file modified in the diff: read the proof file and read the story's current \`Proof:\` field. Judge whether the proof still satisfies the story's Proof field. Verdict per artifact: **satisfies** / **does not satisfy** / **uncertain**. Cite file:line for any "does not satisfy" or "uncertain" verdict — name what the Proof field requires that the artifact does not exhibit.

**Annotation integrity (cheap).** \`rg -n '@(concept|story|decision):\\s*\\S+'\` across the codebase. For each match, parse out (kind, slug) and confirm \`.ok-planner/design/<kind>s/<slug>.md\` exists. Two failure modes per {{ANNOTATION-INTEGRITY-RULE}} in \`skills/_shared/artifact-definitions.md\`:

- **Dangling** — the slug does not exist under any of the three design directories.
- **Kind-mismatch** — the slug exists, but at a different kind than the annotation claims (e.g. \`@concept:foo\` but only \`stories/foo.md\` exists). Record the correct kind in the finding.

The integrity rule is symmetric across the three kinds: paraphrased slugs are dangling, wrong-prefix tags are kind-mismatched. Record every failure.

Findings from these three checks land in section 4 of the report.

Write the report to ${planPath.replace(/\.md$/, '')}-completion-report.md with these four sections in order:

## 1. Proof walkthrough
For every story in the spec's manifest:
- Story slug + one-line restatement.
- The proof artifact's path (the file the implementer produced).
- A summary of what the artifact exhibits (what running or reading it shows).
- The artifact's invocation (the command to run it, or the path to read it).
- Whether the artifact carries the \`@story:<slug>\` annotation (it must — flag absence as a process defect).
- Status: EXHIBITS WORKING (the artifact runs / reads as proving the story) or GAP (the artifact is missing, hollow, or exhibits something other than the story). A GAP here is unexpected — the no-deferral audit should have caught it; flag it as a process defect if present.

## 2. Technical decisions kept
For every TD in the spec's manifest **that the implementation honored as the spec specified**:
- TD slug + one-line restatement of the Choice.
- File:line citation showing the decision is embodied in the code (the persistence call, the registration mechanism, the chosen cadence).

**Explicit enumeration — every spec TD lands either here or in section 3.** No silent attestation. The audit's value is forcing a full walk.

## 3. Technical decisions diverged
For every TD in the spec where the implementation took a different shape than the spec said, AND every implementation choice the spec did not anticipate (necessitated by the necessity rule). For each:
- TD slug + one-line restatement.
- What the spec said vs. what was implemented (file:line where useful).
- Flavor: **improved** (implementer found a better shape), **selected** (spec left a choice open and the implementer picked), or **necessitated** (work the spec did not name but the necessity rule required for a story to hold).
- Reason: one or two sentences.

## 4. Coverage divergences
For every finding from the closing coverage + intent-drift audit. Each entry is one of three kinds:

- **Coverage gap** — a live story with zero \`@story:<slug>\` annotations in the codebase. Name the story slug; note whether the spec touched the story (if so, the validator should have caught this — process defect); name what's needed to resolve (restore a proof artifact, or open a brainstorm to deprecate the story).
- **Intent drift** — a \`@story:<slug>\`-annotated proof file whose content no longer satisfies the story's \`Proof:\` field. Quote the relevant excerpt from the story's Proof field; quote what the proof actually exhibits; name file:line. Note whether the spec had a \`## Proof changes\` entry for this story (if so and the entry was "A. Preserve" but the proof drifted, that's a process defect — the validator should have caught it).
- **Dangling annotation** — an \`@concept:<slug>\` / \`@story:<slug>\` / \`@decision:<slug>\` annotation whose slug doesn't resolve to a live artifact at the corresponding path. Name the annotation site and the unresolved (kind, slug) pair. Note whether the spec removed the artifact (if so, the implementer should have removed all annotations too — process defect). Sub-flavors: **slug-dangling** (no artifact at any kind — author paraphrased or cited a missing artifact) and **kind-mismatch** (an artifact at the slug exists but at a different kind; name the correct kind — author used the wrong tag prefix).

Each entry includes a brief recommendation: **accept as informational** (the divergence is known and intentional, just record it), **course-correct now** (open a brainstorm to address — e.g., restore the proof, deprecate the story, rewrite the annotation), or **bounce back to the implementer** (a process defect the implementer should fix before close).

A section with no findings should still be present in the report, with the text "No coverage divergences." — explicit zero is a stronger signal than absence.

## Coverage check (at the bottom of the report)
A short summary: stories exhibited / total in manifest; TDs kept + TDs diverged should equal total TDs in manifest; coverage divergences by kind (gaps / drifts / dangling). Flag any mismatch as a process defect.

## Your return value
Return { path: <the report path you wrote>, proofsExhibited, decisionsKept, decisionsDiverged, coverageGaps, intentDrifts, danglingAnnotations }.
`
}

// Consults the strategist on a non-halt-lane wall event. Centralizes the
// dispatch + null-handling for every "we hit a wall" path: fixer reports
// BLOCKED, validator persistently surfaces the same blocking findings, a
// fixer coverage retry loop returns null, a gate fixer-loop can't converge.
// Callers act on the returned decision:
//   - genuine: true → call escalateFromStrategist(strat, p, cleared, detail)
//     to build the escalate return value.
//   - genuine: false → use strat.approach as the next dispatch's framing
//     (priorFailure prose) and loop.
// A null strategist result is treated as genuine — we cannot proceed without
// the strategist's verdict, and looping on a non-responsive strategist would
// spin forever.
async function consultStrategist(p, situationKind, situationDetail, phaseLabel) {
  const strat = await agent(strategistStuckPrompt(p, situationKind, situationDetail), {
    label: p ? `pass-${p.number}:strategist:${situationKind}` : `gate-strategist:${situationKind}`,
    phase: phaseLabel,
    schema: STRATEGIST_SCHEMA,
  })
  if (!strat) {
    return {
      genuine: true,
      escalateKind: 'invalid-plan',
      rootCause: 'Strategist returned no result',
      concurringAnalysis: `Strategist agent failed to return a verdict on situation: ${situationKind}.\n\nSituation detail: ${situationDetail}\n\nTreat as genuine impasse — manual diagnosis required.`,
    }
  }
  return strat
}

// Build the escalate-return value from a strategist's genuine verdict.
function escalateFromStrategist(strat, p, cleared, situationDetail) {
  return {
    status: 'escalate',
    kind: strat.escalateKind || 'invalid-plan',
    pass: p ? p.number : -1,
    lastFailure: situationDetail,
    strategistReport: {
      escalateKind: strat.escalateKind || 'invalid-plan',
      rootCause: strat.rootCause || '',
      humanAsk: strat.humanAsk || '',
      concurringAnalysis: strat.concurringAnalysis || '',
    },
    cleared,
  }
}

// ----------------------------------------------------------------------------
// Main loop
// ----------------------------------------------------------------------------

phase('Execute')

// Defensive validation: every pass must have a falsifier (the validator's
// contract). The skill is supposed to catch this in step 2; the engine
// re-checks to fail loud rather than dispatch a validator with no contract.
for (let i = 0; i < passes.length; i++) {
  const p = passes[i]
  if (!p.falsifier || String(p.falsifier).trim() === '') {
    return { status: 'escalate', kind: 'invalid-plan', pass: p.number,
             detail: `Pass ${p.number} has no Falsifier brief — the validator has nothing to argue against. Take this back to write-plan.` }
  }
  if (p.isAcceptancePass && (!p.storySlug || String(p.storySlug).trim() === '')) {
    return { status: 'escalate', kind: 'invalid-plan', pass: p.number,
             detail: `Pass ${p.number} is an acceptance pass but has no story slug. Take this back to write-plan.` }
  }
}

const cleared = []
// Deferred queue seeded from priorDeferred (entries the skill loaded from
// the JSONL queue file before launching the workflow). The validator itself
// appends each new entry to the queue file (via its prompt's persistence
// instructions, executed before its structured-output call) so an abort at
// any point leaves the queue file as the durable record.
const deferredQueue = priorDeferred.slice()
if (deferredQueue.length > 0) {
  log(`Seeded deferred queue with ${deferredQueue.length} entry(ies) from prior aborted run (via args.priorDeferred)`)
}

for (let i = 0; i < passes.length; i++) {
  const p = passes[i]

  // Per-pass loop. Two stages cycled to convergence:
  //   1. Implementer dispatch (status DONE / BLOCKED / INVALID_PLAN per
  //      REPORT_SCHEMA; partial-DONE is schema-illegal).
  //   2. Smart validator dispatch (verdict + blocking[] + deferred[] per
  //      VALIDATOR_SCHEMA). If verdict=delivers (blocking empty), pass
  //      cleared; otherwise dispatch implementer-as-fixer against the
  //      blocking findings, then re-run the validator. Deferred findings
  //      go to deferredQueue regardless of verdict.
  // No fixed cycle caps; every wall event routes through the strategist via
  // consultStrategist().
  let priorFailure = null
  let nullReportCount = 0
  let implDispatch = 0
  let validatorDispatch = 0
  let lastImplReport = null
  let priorBlockingFp = null
  let sameBlockingCount = 0
  let priorStrategistApproach = null
  let passCleared = false

  while (!passCleared) {
    // Step 1: dispatch the implementer.
    implDispatch++
    const report = await agent(implementerPrompt(p, i, passes.length, priorFailure), {
      label: `pass-${p.number}:impl#${implDispatch}`, phase: 'Execute', schema: REPORT_SCHEMA,
    })

    if (!report) {
      nullReportCount++
      log(`pass ${p.number}: implementer dispatch ${implDispatch} returned no result (null-count ${nullReportCount})`)
      if (nullReportCount >= 2) {
        const strat = await consultStrategist(p, 'implementer-null',
          `The implementer agent returned no result on ${nullReportCount} consecutive dispatches. The runtime cannot get a schema-compliant REPORT from the agent. Prior framing:\n\n${priorFailure || '(initial dispatch, no prior framing)'}`,
          'Execute')
        if (strat.genuine) {
          return escalateFromStrategist(strat, p, cleared,
            `Implementer returned no result on ${nullReportCount} consecutive dispatches; strategist confirmed impasse.`)
        }
        priorFailure = `Prior dispatches returned no result. Strategist's diagnosis and different approach:\n\nRoot cause: ${strat.rootCause || '(unstated)'}\n\nDifferent approach: ${strat.approach || '(unstated)'}\n\nDeliver the pass.`
        nullReportCount = 0
      } else {
        priorFailure = 'Prior dispatch was skipped before returning a report; re-dispatching with the same task list.'
      }
      continue
    }
    nullReportCount = 0

    if (report.status === 'BLOCKED' || report.status === 'INVALID_PLAN') {
      const isBlocked = report.status === 'BLOCKED'
      const strat = await agent(
        isBlocked ? strategistBlockedPrompt(p, report) : strategistInvalidPlanPrompt(p, report),
        { label: `pass-${p.number}:strategist:impl-halt#${implDispatch}`, phase: 'Execute', schema: STRATEGIST_SCHEMA },
      )
      if (!strat || strat.genuine) {
        if (isBlocked) {
          return { status: 'escalate', kind: 'blocked', pass: p.number,
                   bullet: report.blockedBullet, detail: report.blockedDetail || '',
                   humanAsk: (strat && strat.humanAsk) || '',
                   strategistReport: strat ? { escalateKind: 'blocked', rootCause: strat.rootCause || '', humanAsk: strat.humanAsk || '' } : null,
                   cleared }
        }
        return { status: 'escalate', kind: 'invalid-plan', pass: p.number,
                 implementerReport: {
                   reason: report.invalidPlanReason || '(none given)',
                   detail: report.invalidPlanDetail || '',
                 },
                 strategistReport: {
                   escalateKind: 'invalid-plan',
                   rootCause: (strat && strat.rootCause) || '',
                   concurringAnalysis: (strat && strat.concurringAnalysis) || '',
                 },
                 cleared }
      }
      priorFailure = isBlocked
        ? `You reported BLOCKED, but the strategist judged it not genuine. Root cause the prior attempt missed: ${strat.rootCause || '(unstated)'}\n\nTake this DIFFERENT approach: ${strat.approach || '(unstated)'}\n\nDeliver the pass.`
        : `You reported INVALID_PLAN, but the strategist judged the plan workable. Root cause the prior attempt missed: ${strat.rootCause || '(unstated)'}\n\nTake this DIFFERENT reading / approach: ${strat.approach || '(unstated)'}\n\nDeliver the pass.`
      log(`pass ${p.number}: ${report.status} → strategist intervened with different approach`)
      continue
    }

    // status === 'DONE' (schema guarantees every task.done === true).
    lastImplReport = report

    // Step 2: inner loop — validator ↔ fixer cycle. The implementer dispatches
    // once per pass in the normal flow; the fixer dispatches against the
    // validator's blocking findings and the validator re-checks the fixed
    // tree. The outer loop only re-runs the implementer for null/halt-lane
    // retries (handled above). Once we enter this inner loop, the only exits
    // are passCleared=true (validator approves) or a `return escalate` from
    // a strategist-confirmed wall event.
    while (true) {
      validatorDispatch++
      log(`pass ${p.number}: dispatching smart validator (cycle ${validatorDispatch})`)
      const validation = await agent(validatorPrompt(p), {
        label: `pass-${p.number}:val#${validatorDispatch}`, phase: 'Execute', schema: VALIDATOR_SCHEMA,
      })
      if (!validation) {
        const strat = await consultStrategist(p, 'validator-null',
          `The smart validator returned no result on cycle ${validatorDispatch}. The runtime could not produce a schema-compliant VALIDATOR response.`,
          'Execute')
        if (strat.genuine) {
          return escalateFromStrategist(strat, p, cleared,
            `Validator returned no result on cycle ${validatorDispatch}; strategist confirmed impasse.`)
        }
        // Re-dispatch the validator with strategist framing recorded for any
        // downstream fixer (the validator itself has no priorStrategistApproach
        // input, but the framing applies to the next fixer if this re-run
        // produces blocking).
        priorStrategistApproach = `Validator returned no result. Strategist's diagnosis:\n\nRoot cause: ${strat.rootCause || '(unstated)'}\nDifferent approach: ${strat.approach || '(unstated)'}`
        continue
      }

      // Capture deferred findings to the queue. The validator was instructed
      // to persist each one to the JSONL queue file (via Bash, before
      // returning its structured output) so an abort between dispatches does
      // not lose them; the in-memory push here is the workflow's own copy
      // for the cleanup phase.
      const deferred = validation.deferred || []
      if (deferred.length > 0) {
        deferred.forEach(d => deferredQueue.push({ ...d, _pass: p.number }))
        log(`pass ${p.number}: validator cycle ${validatorDispatch} captured ${deferred.length} deferred finding(s); queue size now ${deferredQueue.length}`)
      }

      // Compute the effective verdict from blocking (the schema can't enforce
      // the verdict/blocking conditional). If blocking is empty, treat as
      // delivers regardless of declared verdict; if blocking is non-empty,
      // treat as does_not_deliver regardless of declared verdict.
      const blocking = validation.blocking || []
      if (blocking.length === 0) {
        log(`pass ${p.number}: validator cycle ${validatorDispatch} approves (rationale: ${validation.rationale || '(none)'})`)
        passCleared = true
        break
      }

      log(`pass ${p.number}: validator cycle ${validatorDispatch} surfaced ${blocking.length} blocking finding(s); dispatching fixer`)

      // Same-blocking-findings detection: if the validator returns the same
      // blocking entries twice in a row, the fixer can't address them and the
      // strategist needs to re-frame or escalate.
      const fp = fingerprintFindings(blocking)
      if (fp === priorBlockingFp) {
        sameBlockingCount++
      } else {
        sameBlockingCount = 1
      }
      priorBlockingFp = fp

      if (sameBlockingCount >= 2) {
        const findingsBlock = blocking.map((f, idx) => `${idx + 1}. ${f.location} — ${f.problem}`).join('\n')
        const strat = await consultStrategist(p, 'validator-persistent-blocking',
          `The smart validator surfaced the same ${blocking.length} blocking finding(s) on ${sameBlockingCount} consecutive cycles. The fixer cannot address them.\n\nBlocking findings:\n${findingsBlock}`,
          'Execute')
        if (strat.genuine) {
          return escalateFromStrategist(strat, p, cleared,
            `Pass ${p.number} validator couldn't be cleared after ${validatorDispatch} cycles with the same blocking findings persisting; strategist confirmed impasse.\n\nBlocking findings:\n${findingsBlock}`)
        }
        priorStrategistApproach = `Validator surfaced the same ${blocking.length} blocking finding(s) ${sameBlockingCount} times in a row. Strategist's diagnosis:\n\nRoot cause: ${strat.rootCause || '(unstated)'}\nDifferent approach: ${strat.approach || '(unstated)'}`
        sameBlockingCount = 0
      }

      // Dispatch the fixer against the blocking findings (only).
      const fixerReport = await dispatchFixerWithCoverage(
        (f, c) => validatorRejectionFixerPrompt(f, c, p, priorStrategistApproach, lastImplReport),
        blocking,
        `pass-${p.number}:fix#${validatorDispatch}`,
        'Execute',
      )

      if (!fixerReport) {
        const strat = await consultStrategist(p, `pass-${p.number}-fixer-coverage-gap`,
          `Fixer at cycle ${validatorDispatch} could not produce a coverage-compliant report against the validator's blocking findings.`,
          'Execute')
        if (strat.genuine) {
          return escalateFromStrategist(strat, p, cleared,
            `Pass ${p.number} fixer could not comply with the coverage schema; strategist confirmed impasse.`)
        }
        priorStrategistApproach = `Prior fixer attempts could not produce a coverage-compliant report. Strategist's diagnosis:\n\nRoot cause: ${strat.rootCause || '(unstated)'}\nDifferent approach: ${strat.approach || '(unstated)'}`
        continue
      }

      if (fixerReport.status === 'BLOCKED') {
        const blockedItems = (fixerReport.resolutions || []).filter(r => r.disposition === 'blocked')
        const blockedDetail = `Fixer at cycle ${validatorDispatch} reported BLOCKED on ${blockedItems.length} finding(s): ${fixerReport.blockedDetail || '(no detail)'}\n\nBlocked items:\n${blockedItems.map(r => `- finding ${r.index}: ${r.summary || '(no summary)'}`).join('\n') || '(none specified)'}`
        const strat = await consultStrategist(p, `pass-${p.number}-fixer-blocked`, blockedDetail, 'Execute')
        if (strat.genuine) {
          return escalateFromStrategist(strat, p, cleared, blockedDetail)
        }
        priorStrategistApproach = `Fixer reported BLOCKED. Strategist's diagnosis:\n\nRoot cause: ${strat.rootCause || '(unstated)'}\nDifferent approach: ${strat.approach || '(unstated)'}`
        continue
      }

      // Fixer cleared; inner loop re-runs the validator against the fixed tree.
      priorStrategistApproach = null
    }
  }

  cleared.push(p.number)
  log(`pass ${p.number} cleared (${cleared.length}/${passes.length}); deferred queue size: ${deferredQueue.length}`)
}

phase('Deferred')

// Drain the accumulated deferred queue with a fixer ↔ reviewer loop. The
// fixer addresses every queue entry via the coverage protocol; the reviewer
// independently re-checks the entries against the current tree and reports
// any residual (entries the fixer claimed-fixed but the reviewer can still
// see). The loop runs until the residual is empty OR the strategist confirms
// a genuine impasse. Same-residual detection on consecutive cycles triggers
// strategist consultation.
let pendingDeferred = deferredQueue.slice()
let deferredCycle = 0
let priorDeferredResidualFp = null
let sameDeferredResidualCount = 0
while (pendingDeferred.length > 0) {
  deferredCycle++
  log(`deferred cleanup cycle ${deferredCycle}: ${pendingDeferred.length} entry(ies) to process`)

  const fixerReport = await dispatchFixerWithCoverage(
    (f, c) => deferredCleanupFixerPrompt(f, c, null),
    pendingDeferred,
    `deferred-fixer#${deferredCycle}`,
    'Deferred',
  )

  if (!fixerReport) {
    const strat = await consultStrategist(null, 'deferred-fixer-coverage-gap',
      `Deferred-cleanup fixer at cycle ${deferredCycle} could not produce a coverage-compliant report.`,
      'Deferred')
    if (strat.genuine) {
      return escalateFromStrategist(strat, null, cleared,
        `Deferred-cleanup fixer could not comply with the coverage schema; strategist confirmed impasse.`)
    }
    continue
  }

  if (fixerReport.status === 'BLOCKED') {
    const blockedItems = (fixerReport.resolutions || []).filter(r => r.disposition === 'blocked')
    const blockedDetail = `Deferred-cleanup fixer at cycle ${deferredCycle} reported BLOCKED on ${blockedItems.length} entry(ies): ${fixerReport.blockedDetail || '(no detail)'}\n\nBlocked items:\n${blockedItems.map(r => `- entry ${r.index}: ${r.summary || '(no summary)'}`).join('\n') || '(none specified)'}`
    const strat = await consultStrategist(null, 'deferred-fixer-blocked', blockedDetail, 'Deferred')
    if (strat.genuine) {
      return escalateFromStrategist(strat, null, cleared, blockedDetail)
    }
    continue
  }

  // Reviewer independently re-checks the queue entries against the tree.
  const review = await agent(deferredCleanupReviewerPrompt(pendingDeferred), {
    label: `deferred-review#${deferredCycle}`, phase: 'Deferred', schema: DEFERRED_REVIEW_SCHEMA,
  })
  if (!review) {
    const strat = await consultStrategist(null, 'deferred-reviewer-null',
      `Deferred-cleanup reviewer returned no result on cycle ${deferredCycle}.`,
      'Deferred')
    if (strat.genuine) {
      return escalateFromStrategist(strat, null, cleared,
        `Deferred-cleanup reviewer returned no result; strategist confirmed impasse.`)
    }
    continue
  }

  const residual = review.residual || []
  if (residual.length === 0) {
    log(`deferred cleanup: drained after ${deferredCycle} cycle(s)`)
    break
  }

  log(`deferred cleanup cycle ${deferredCycle}: reviewer found ${residual.length} residual entry(ies)`)

  const fp = fingerprintFindings(residual)
  if (fp === priorDeferredResidualFp) {
    sameDeferredResidualCount++
    if (sameDeferredResidualCount >= 2) {
      const residualBlock = residual.map((f, idx) => `${idx + 1}. ${f.location} — ${f.problem}`).join('\n')
      const strat = await consultStrategist(null, 'deferred-residual-persistent',
        `Deferred-cleanup reviewer reported the same ${residual.length} residual entry(ies) on ${sameDeferredResidualCount} consecutive cycles. The fixer cannot clear them.\n\nResidual:\n${residualBlock}`,
        'Deferred')
      if (strat.genuine) {
        return escalateFromStrategist(strat, null, cleared,
          `Deferred-cleanup could not be drained after ${deferredCycle} cycles with the same residual persisting; strategist confirmed impasse.\n\nResidual:\n${residualBlock}`)
      }
      sameDeferredResidualCount = 0
    }
  } else {
    sameDeferredResidualCount = 1
  }
  priorDeferredResidualFp = fp

  // Reduce the queue to the residual and loop.
  pendingDeferred = residual.map(r => ({ ...r, _pass: r._pass || '?' }))
}

phase('Verify')

// Final verification gate as a verifier ↔ fixer loop. No fixed cap on cycles
// — the loop runs until the verifier reports passed=true OR the strategist
// confirms a genuine impasse. Same-failure detection on consecutive cycles
// triggers strategist consultation (the fixer can't address the failing
// commands; user input or plan rework needed). The verifier reads the
// project's own docs to discover its command set (the skill is
// project-agnostic).
let verifyCycle = 0
let priorVerifyFp = null
let sameVerifyCount = 0
let verifyDone = false
while (!verifyDone) {
  verifyCycle++
  const lastVerify = await agent(verifierPrompt(), {
    label: `verify#${verifyCycle}`, phase: 'Verify', schema: VERIFY_SCHEMA,
  })
  if (!lastVerify) {
    const strat = await consultStrategist(null, 'verifier-null',
      `The verifier agent returned no result on cycle ${verifyCycle}. The runtime could not produce a schema-compliant VERIFY response.`,
      'Verify')
    if (strat.genuine) {
      return escalateFromStrategist(strat, null, cleared,
        `Verifier returned no result; strategist confirmed impasse.`)
    }
    continue
  }
  if (lastVerify.passed) {
    log(`verification gate passed on cycle ${verifyCycle}: ${(lastVerify.commandsRun || []).length} command(s)`)
    verifyDone = true
    break
  }

  const failures = lastVerify.failures || []
  const failuresAsFindings = failures.map(f => ({ location: f, problem: f }))
  const fp = fingerprintFindings(failuresAsFindings)
  if (fp === priorVerifyFp) {
    sameVerifyCount++
  } else {
    sameVerifyCount = 1
  }
  priorVerifyFp = fp

  const summary = lastVerify.failureSummary || '(no summary)'
  log(`verification cycle ${verifyCycle}: failed — ${summary} (${failures.length} failure(s), same-failure-count ${sameVerifyCount}); dispatching fixer`)

  if (sameVerifyCount >= 2) {
    const failuresBlock = failures.map((f, idx) => `${idx + 1}. ${f}`).join('\n')
    const strat = await consultStrategist(null, 'verifier-persistent-failure',
      `The verifier reported the same ${failures.length} failure(s) on ${sameVerifyCount} consecutive cycles. The fixer cannot address them.\n\nFailures:\n${failuresBlock}\n\nCommands run: ${(lastVerify.commandsRun || []).join(', ')}`,
      'Verify')
    if (strat.genuine) {
      return escalateFromStrategist(strat, null, cleared,
        `Verification gate could not be cleared after ${verifyCycle} cycles with the same failures persisting; strategist confirmed impasse.\n\nFailures:\n${failuresBlock}`)
    }
    log(`verification cycle ${verifyCycle}: strategist re-framed; continuing fixer cycle`)
    sameVerifyCount = 0
  }

  const fixerReport = await dispatchFixerWithCoverage(
    (f, c) => verifyFixerPrompt(f, c),
    failures,
    `verify-fixer#${verifyCycle}`,
    'Verify',
  )
  if (!fixerReport) {
    const strat = await consultStrategist(null, 'verify-fixer-coverage-gap',
      `Verification fixer at cycle ${verifyCycle} could not produce a coverage-compliant report.`,
      'Verify')
    if (strat.genuine) {
      return escalateFromStrategist(strat, null, cleared,
        `Verification fixer could not comply with the coverage schema; strategist confirmed impasse.`)
    }
    continue
  }
  if (fixerReport.status === 'BLOCKED') {
    const blockedItems = (fixerReport.resolutions || []).filter(r => r.disposition === 'blocked')
    const blockedDetail = `Verification fixer at cycle ${verifyCycle} reported BLOCKED on ${blockedItems.length} failure(s): ${fixerReport.blockedDetail || '(no detail)'}\n\nBlocked items:\n${blockedItems.map(r => `- failure ${r.index}: ${r.summary || '(no summary)'}`).join('\n') || '(none specified)'}`
    const strat = await consultStrategist(null, 'verify-fixer-blocked', blockedDetail, 'Verify')
    if (strat.genuine) {
      return escalateFromStrategist(strat, null, cleared, blockedDetail)
    }
    continue
  }
  // Fixer cleared; loop re-runs the verifier.
}

phase('Audit')

// No-deferral audit as auditor ↔ fixer gate. Loops until the auditor finds
// zero deferrals OR the strategist confirms a genuine impasse (same-finding
// detection on consecutive cycles triggers strategist consultation). No
// fixed cap on cycles.
let auditCycle = 0
let priorAuditFp = null
let sameAuditCount = 0
let auditDone = false
while (!auditDone) {
  auditCycle++
  const audit = await agent(noDeferralAuditPrompt(), {
    label: `no-deferral-audit#${auditCycle}`, phase: 'Audit', schema: NO_DEFERRAL_SCHEMA,
  })
  if (!audit) {
    const strat = await consultStrategist(null, 'auditor-null',
      `The no-deferral auditor returned no result on cycle ${auditCycle}.`,
      'Audit')
    if (strat.genuine) {
      return escalateFromStrategist(strat, null, cleared,
        `No-deferral auditor returned no result; strategist confirmed impasse.`)
    }
    continue
  }
  if (!audit.findings || audit.findings.length === 0) {
    log(`no-deferral audit cycle ${auditCycle}: clean`)
    auditDone = true
    break
  }

  const fp = fingerprintFindings(audit.findings)
  if (fp === priorAuditFp) {
    sameAuditCount++
  } else {
    sameAuditCount = 1
  }
  priorAuditFp = fp

  log(`no-deferral audit cycle ${auditCycle}: ${audit.findings.length} deferral(s) found; dispatching fixer (same-finding-count ${sameAuditCount})`)

  if (sameAuditCount >= 2) {
    const findingsBlock = audit.findings.map((f, idx) => `${idx + 1}. ${f.location} (${f.kind}): ${f.why || ''}`).join('\n')
    const strat = await consultStrategist(null, 'auditor-persistent-deferrals',
      `The no-deferral auditor surfaced the same ${audit.findings.length} deferral(s) on ${sameAuditCount} consecutive cycles. The fixer cannot address them.\n\nDeferrals:\n${findingsBlock}`,
      'Audit')
    if (strat.genuine) {
      return escalateFromStrategist(strat, null, cleared,
        `No-deferral audit could not be cleared after ${auditCycle} cycles with the same deferrals persisting; strategist confirmed impasse.\n\nDeferrals:\n${findingsBlock}`)
    }
    log(`no-deferral audit cycle ${auditCycle}: strategist re-framed; continuing fixer cycle`)
    sameAuditCount = 0
  }

  const fixerReport = await dispatchFixerWithCoverage(
    (f, c) => noDeferralFixerPrompt(f, c),
    audit.findings,
    `no-deferral-fixer#${auditCycle}`,
    'Audit',
  )
  if (!fixerReport) {
    const strat = await consultStrategist(null, 'no-deferral-fixer-coverage-gap',
      `No-deferral fixer at cycle ${auditCycle} could not produce a coverage-compliant report.`,
      'Audit')
    if (strat.genuine) {
      return escalateFromStrategist(strat, null, cleared,
        `No-deferral fixer could not comply with the coverage schema; strategist confirmed impasse.`)
    }
    continue
  }
  if (fixerReport.status === 'BLOCKED') {
    const blockedItems = (fixerReport.resolutions || []).filter(r => r.disposition === 'blocked')
    const blockedDetail = `No-deferral fixer at cycle ${auditCycle} reported BLOCKED on ${blockedItems.length} deferral(s): ${fixerReport.blockedDetail || '(no detail)'}\n\nBlocked items:\n${blockedItems.map(r => `- finding ${r.index}: ${r.summary || '(no summary)'}`).join('\n') || '(none specified)'}`
    const strat = await consultStrategist(null, 'no-deferral-fixer-blocked', blockedDetail, 'Audit')
    if (strat.genuine) {
      return escalateFromStrategist(strat, null, cleared, blockedDetail)
    }
    continue
  }
  // Fixer cleared; loop re-runs the auditor.
}

// Completion auditor produces the four-section report.
const completion = await agent(completionAuditPrompt(), {
  label: 'completion-audit', phase: 'Audit', schema: COMPLETION_AUDIT_SCHEMA,
})

return { status: 'complete',
         passesCleared: priorCleared + cleared.length,
         clearedThisRun: cleared.length,
         deferredProcessed: deferredQueue.length,
         completionReport: completion || { path: 'none' } }
```

## Rules

- One implementer at a time per pass (passes depend on prior passes).
  The workflow never runs passes in parallel.
- **The validator is one smart agent, not a lens fan-out.** It reads
  the spec, the pass's Falsifier brief, and the diff, and forms its
  own judgment of "was the work done?" It has broad tool access
  (Bash, Read, Grep) and is expected to investigate as widely as its
  own judgment says is needed — trace wiring, check shared-surface
  callers, audit acceptance-proof artifacts, scan for design-doc
  rule violations, etc. The validator is **disinterested and
  adversarial** — defaults to `does_not_deliver`, confirms only with
  concrete citation against the diff. Hollow proofs (shape checks,
  registration assertions, canned stubs at the value-delivering
  component) are the canonical failure mode the validator catches.
- **Every validator finding triages into blocking or deferred.** The
  triage rule:
  - **Blocking** — work materially fails the pass: the Falsifier
    holds, a downstream pass would break, a user-observable behavior
    fails, an acceptance proof is structurally wrong, a real bug
    (race, missing auth, etc.). Dispatches the implementer-as-fixer;
    pass does not advance.
  - **Deferred** — nits, polish, cross-pass consistency, doc-rule
    leaks, dead code, missing-but-non-critical pieces. Joins the
    deferred queue; pass advances.
  The validator's "if in doubt → blocking" tie-breaker: if a
  downstream pass / verify gate / user would discover the issue
  before the cleanup phase does, it's blocking; otherwise deferred.
- **The validator bounds itself at the plan's manual-check
  boundary.** Items the plan documents under `## Manual checks
  after completion` (deployment, hitting a production endpoint,
  running against credentialed external services) are NOT validator
  findings — neither blocking nor deferred. For acceptance proofs
  specifically, if the plan documents execution as a manual check,
  the validator's contract is structural correctness only (the
  artifact exists, carries the `@story:` annotation, uses the
  prescribed delivery surface and real value-delivering component).
  Execution-against-live-stack is the user's manual check.
- **The strategist is the single escalation gateway, with no cap on
  invocations.** Every wall event in the engine — implementer
  BLOCKED, implementer INVALID_PLAN, validator persistently
  surfacing the same blocking findings, fixer reporting BLOCKED,
  fixer coverage-gap not closing, gate (verify / no-deferral /
  deferred-cleanup) not converging — consults the strategist before
  the engine returns `escalate`. The strategist either re-frames
  the next dispatch (loop continues with the strategist's approach
  as input) or confirms genuine impasse with `escalateKind` set to
  one of `blocked` / `invalid-plan` / `architectural-call` (engine
  escalates). The implementer halt-lanes (BLOCKED, INVALID_PLAN)
  use the specialized strategist prompts that carry the
  implementer's structured report; every other wall event uses the
  generalized `strategistStuckPrompt`. The strategist's "genuine:
  true" verdict is the only thing that terminates a loop early.
- **Per-pass loop runs until validator approves; no cycle caps.**
  Implementer DONE → validator → if blocking is empty, pass cleared
  (deferred captured in queue); if non-empty, implementer-as-fixer
  dispatches against the blocking findings via
  `dispatchFixerWithCoverage`; on fixer DONE, the validator re-runs;
  loop. Schema constraints prevent silent giveup: partial-DONE is
  illegal (REPORT_SCHEMA — every task.done=true required), fixer
  DONE-with-buried-blocked is illegal (FIXER_REPORT_SCHEMA — every
  disposition fixed or already-clean required). Same-blocking-
  findings detection (same fingerprint twice from the validator)
  consults the strategist; null reports from any agent consult the
  strategist. The loop has no fixed cycle cap — only validator-
  approval (pass cleared) or strategist-confirmed impasse terminates
  it.
- **No bare repeats.** A re-dispatch always carries new input — the
  validator's blocking findings on a rejection, the strategist's
  different approach on a halt-claim retry, the remaining-task list
  on a partial-DONE retry. Looping without adding perspective is
  not a fix.
- **Per-issue accounting at every fixer dispatch.** The
  per-pass-rejection, deferred-cleanup, no-deferral, and
  verification fixers all return a structured resolution covering
  every input finding by 1-based index exactly once — `fixed` (with
  `summary` + `fileLines` of the edit), or `already-clean` (with
  cited evidence for why no fix was needed), or `blocked` (with the
  specific user-ask). The orchestrator validates coverage at the
  call site via `checkFixerCoverage`; reports missing findings,
  duplicating indices, or going out of range are rejected, and the
  fixer is re-dispatched once with the coverage critique. This
  catches the silent-drop failure mode (a fixer told "fix all 30"
  reporting "DONE" while having silently left a few unaddressed) —
  the prose "DONE" is replaced by an index-by-index acknowledgement.
  A "fixed" disposition that the next independent re-check sees as
  still present is evidence of self-deception, surfaced by the
  cycle's residual findings; a "blocked" disposition escalates the
  corresponding gate immediately (the strategist gate decides).
- **Deferred-cleanup phase drains the accumulated queue after all
  passes clear.** A fixer ↔ reviewer loop: the fixer dispatches
  against the full queue with per-input coverage; an independent
  reviewer re-checks each entry against the current tree and
  reports any residual; the loop runs until the residual is empty
  OR the strategist confirms a genuine impasse. Same-residual
  detection on consecutive cycles triggers strategist consultation.
  No fixed cycle cap. This is where the nits the per-pass
  validators set aside actually get fixed — a single concentrated
  loop on a known list, instead of inflating every per-pass cycle.
- **The deferred queue is durable across aborts.** Every
  validator-found deferred entry gets appended (as a JSONL line) to
  `<plan>-deferred.jsonl` adjacent to the plan **by the validator
  itself** — its prompt instructs it to Bash-append every entry
  before calling its final structured-output tool, so the on-disk
  record lands in the same turn the in-memory queue gains the
  entry. The skill reads this file before launching the workflow
  and passes its contents as `args.priorDeferred`; the workflow
  seeds its in-memory queue from that argument every time it
  starts. So: kill the workflow mid-run, restart it, the deferred
  entries are still there. The skill archives the file alongside
  the plan + completion report at close.
- **Prompts forbid "I'm stopping" without a stated reason; schemas
  type the exits but cannot enforce the conditional rules.** The
  Anthropic tool-input-schema validator rejects top-level
  `oneOf`/`allOf`/`anyOf`, so conditional rules like "DONE requires
  every task.done=true" / "fixer DONE forbids blocked dispositions"
  / "validator verdict=delivers requires empty blocking" / "strategist
  genuine=true requires escalateKind" cannot ride in the schema. The
  schemas still type the shape (status enum, required fields, item
  shapes); the implementer / fixer / validator / strategist prompts
  carry the conditional rules in prose. Behavioral enforcement comes
  from the orchestrator: the per-pass loop re-dispatches on a
  partial-DONE, the validator's verdict is computed from blocking
  emptiness regardless of declared verdict, `checkFixerCoverage`
  re-dispatches on a coverage gap, and the strategist gate routes
  BLOCKED-but-no-blocked-resolution fixers to a re-frame. The
  legitimate "I hit a wall" channels for the implementer remain
  two: BLOCKED with `blockedBullet` + `blockedDetail`, and
  INVALID_PLAN with `invalidPlanReason` + `invalidPlanDetail`. Both
  are stated, structured, and route to the strategist.
- **Final verification gate runs every project-prescribed check,
  and loops with a fixer until clean.** The verifier discovers the
  command set from the project's own docs (plan / spec / CLAUDE.md
  / Makefile) rather than the skill hardcoding commands. Build,
  lint, unit tests, race tests on named race-sensitive packages,
  integration / scenario tests where the plan's scope touches
  them. On failure, a dedicated verification fixer agent reads the
  failure list and repairs the working tree; the verifier re-runs;
  the loop runs until passed=true OR the strategist confirms a
  genuine impasse (same-failure detection on consecutive cycles
  triggers strategist consultation). The verifier itself stays a
  pure detector; the loop delegates repair to the fixer. The
  implementer's per-pass tests catch local breakage; this gate
  catches cross-pass interactions and surfaces a foundational
  regression that escaped a Falsifier's named scope. No fixed
  cycle cap.
- **No-deferral audit is a gate, not a report.** It loops with a
  fixer dispatch until the auditor finds zero deferrals OR the
  strategist confirms a genuine impasse (same-finding detection on
  consecutive cycles triggers strategist consultation). No fixed
  cycle cap. The closing walk never surfaces a "what was deferred
  and fixed" section — by the time the user sees anything, the
  contract has been met.
- **Completion auditor produces the closing-walk artifact** — the
  four-section report (proofs working, decisions kept, decisions
  diverged, coverage divergences) that the skill walks with the
  user and archives.
- **Every pass leaves the tree working.** No `broken-intentional`
  end-state, no restorer model. A plan that implies multi-pass
  teardown-then-rebuild must express it as one pass with both.
- **Never commit; never revert/reset/stash/clean** (binds the skill
  and every agent). Implementers checkpoint with `git add -A`
  (non-destructive); recovery is fix-forward.
- **The walk-away contract. The orchestrator owns completion.** A
  user who runs `/execute-plan` expects to return — possibly hours
  later — to a working product or feature. They are not at the
  keyboard while the run executes. The orchestrator (you, the
  skill agent) is responsible for delivering completion no matter
  what the workflow engine returns. The engine is a tool whose
  cycles you drive toward completion, not a contract that bounds
  your responsibility. An `escalate` result is "here's where I
  stopped," not "your turn to hand off to the user." The
  orchestrator self-heals every failure that is not literally
  impossible to advance — including, but not limited to:
  - **`Workflow` launch errors** (script parse error, meta
    validation, args validation) — diagnose, fix, re-invoke, per
    step 4's launch-retry cap. NEVER a stopping condition.
  - **Any `escalate` result whose `lastFailure` names a concrete,
    fixable defect** — a build setting, a missing Info.plist, a
    project-yml omission, a single-line gap a plan task forgot, a
    paragraph in a design doc that needs rewriting. Read the
    failure, fix the working tree, resume the workflow with
    `resumeFromRunId`. The strategist confirming a wall does NOT
    mean the repair is beyond reach; the strategist is
    intentionally skeptical, but sometimes one more pair of eyes
    on the working tree closes the gap they thought was a wall.
    Diagnose, fix, resume. The engine now routes every wall event
    through the strategist before escalating, so the escalations
    you see are already vetted as "no agent path forward without
    external input" — but you, the orchestrator, are external
    input. Apply your judgment.
  Stalling silently on a fixable failure breaks the contract.
- **Escalations relay to the user only when the work is literally
  impossible to advance autonomously.** The bar is high:
  - `blocked` — credentials or authorized destructive actions
    only the user can provide. You cannot supply these.
    `strategistReport.humanAsk` names the specific resource or
    authorization.
  - `invalid-plan` — the plan is structurally broken and needs
    `write-plan` to rewrite. You cannot rewrite the spec/plan
    autonomously. `strategistReport.concurringAnalysis` carries
    the diagnosis the user takes back to brainstorm.
  - `architectural-call` — the spec / plan / codebase admit
    multiple irreconcilable readings and the user must pick one.
    `strategistReport.concurringAnalysis` names the choice and
    the tradeoffs of each option. Relay with the analysis and
    surface options for the user to direct.
  Before relaying any of these, still attempt autonomous repair
  if `lastFailure` names a concrete fix — the strategist over-
  reaches sometimes. "I'm not sure what the right fix is" is not
  grounds to relay — read the failing files, the spec, the diff,
  and figure it out.
