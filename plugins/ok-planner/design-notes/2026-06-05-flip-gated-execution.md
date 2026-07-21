# Flip-gated execution — design note

**Date:** 2026-06-05
**Status:** design, pre-implementation (consolidates a working-session design before editing the skills)
**Scope:** `write-plan`, the workflow execution engine (reclaiming the name `execute-plan`), `execute-plan-in-worktree`, and the `ok-planner` skill table. Retires the prose `execute-plan`.

This note locks the contract and resolves the open edges so the multi-file
edit lands coherently. It is the source for the change-set in §7.

---

## 1. The problem

A plan's verification gate is a shell command authored as prose and **never run
until execution**. When a gate is *defective* — it can never pass regardless of
whether the work is correct — the execution engine has no way to tell that apart
from "the implementer's work is wrong." It blames the implementer, re-dispatches
to the retry cap (3), and escalates to a human for what is a trivially fixable
error in the gate itself.

This actually happened. A migration pass's gate was:

```
docker compose run --rm postgres psql -U zoning -d zoning -c "\d data_source_endpoints" -c "\d ordinances"
```

`docker compose run <service> <cmd>` spins up a *fresh* container and overrides
the service's server-start command with `psql` (the client) — so psql connects
to a socket where no server is running and exits 2, every time, no matter what
the migration did. The migration was correct (both tables existed in the running
DB); the gate could not observe that. Three implementer dispatches, then a
human escalation, for a one-word `run`→`exec` defect.

There are **two** defect directions, and a good methodology must catch both:

- **False-negative gate** — can never pass (the migration case). Burns the cap,
  escalates needlessly.
- **False-positive gate** — passes while proving nothing (a green-from-birth
  test, a `\d` that exits 0 whether or not the table exists, a blanket
  `npm test`). Certifies broken/half-wired work as done. This is the more
  dangerous direction.

The hard constraint: we **cannot** simply let the executing agent fix its own
gate. The agent wants the pass to advance, and an agent told "make the gate
pass" will *weaken* the gate until it goes green — reintroducing exactly the
"close enough" failure the workflow engine exists to prevent.

So the rule cannot be "agents may fix gates" or "agents may never fix gates." It
must be: **gates may be repaired, but only in a way that cannot lose intent — and
the test for "didn't lose intent" must be something no eager agent can fake.**

---

## 2. The principle: observe the flip

Stop asking anyone to *judge* whether a gate is good. Make the engine *observe*
the flip.

A valid gate has exactly one property:

> **RED when the work is absent, GREEN when the work is present.**

That is an *observation*, not a judgment — you run the command in both states and
watch. An eager agent can rubber-stamp "looks fine"; it cannot make a command
flip that doesn't flip.

This one property discriminates the three reasons a gate is red — the
classification we actually need — without ever classifying the red up front:

| red because… | behavior across the flip | resolution |
|---|---|---|
| not built yet | red now → green once work lands | normal (implementer does the work) |
| the work is wrong | stays red until work is right, then flips | the gate doing its job (fix the work) |
| the command is defective | stays red no matter what the implementer does; never flips | **repair the gate** |

The engine never classifies the red in advance. It watches whether completing
the work flipped the gate. If the work is credibly done **and** the gate is
*still* red, the gate is the suspect — not the implementer.

Two locks make autonomous repair safe:

1. **Who-fixes ≠ who-benefits.** The implementer never edits its own gate. A
   separate, disinterested role proposes the corrected command — the same
   separation the engine already draws between the implementer and the
   gate-reporter, extended to repair.
2. **The repaired gate must itself pass the flip test.** A correction is adopted
   only if, run against a work-absent state it goes red, and against the
   work-present state it goes green. A rubber stamp is green in *both* states, so
   it fails the flip test and is rejected. The agent is structurally unable to
   weaken the gate; the only corrections that survive keep their discriminating
   power. (This catches the false-positive direction for free — a
   green-from-birth gate also fails the flip test. It is the revert-check that
   `skills/review-plan/SKILL.md:48–53` already applies to *tests*, generalized to
   *every* gate and moved from author-declared to engine-observed.)

---

## 3. The authoring contract (`write-plan`)

The engine can only classify a red as right-reason vs. infrastructure if the plan
*states what right-reason red looks like*. So every `working` gate is authored as
a provable flip, not a bare command. The gate block grows from one line to three:

```
**Verification:**     <command>          # unchanged — the gate; its exit code decides
**Proves:**           <one line>         # what a green exit actually establishes (the deliverable)
**Red-when-absent:**  <signature>        # how it fails on the work-absent tree, and the
                                         # right-reason marker that means "valid red"
```

**Field semantics:**

- `Verification` — unchanged. The command; exit code is the gate.
- `Proves` — one line naming the *deliverable* a green exit establishes ("both
  new tables and the `profile` column exist and are queryable"). The artifact
  probe (§4) is anchored to this.
- `Red-when-absent` — what the command does on the work-absent tree, and the
  **failure signature** that distinguishes *right-reason red* (an assertion /
  relation / test failure — the thing under test is genuinely absent) from
  *infrastructure red* (connection refused, command not found, no such service,
  parse error — the command can't even run its check). This is the discriminator
  the engine's pre-flight compares against.

**Worked examples:**

A behavior test (this is just *naming* what proof-first already does —
`skills/write-plan/SKILL.md:145–153`):

```
**Verification:**     go test -run TestHoldsOnlyAutoTerminal ./lib/runtime/...
**Proves:**           the co-holder of a holds:-only template reaches `committed`
**Red-when-absent:**  the test runs and FAILS its assertion (claim handle never
                        reaches committed) — a test assertion failure, NOT a
                        compile/import error or a missing-binary error
```

The migration gate that broke, authored correctly:

```
**Verification:**     docker compose up -d postgres && docker compose exec -T postgres \
                        psql -U zoning -d zoning -v ON_ERROR_STOP=1 \
                        -c "SELECT FROM data_source_endpoints LIMIT 0; \
                            SELECT FROM ordinances LIMIT 0; \
                            SELECT profile FROM data_sources LIMIT 0;"
**Proves:**           both new tables and the profile column exist and are queryable
**Red-when-absent:**  before the migration, psql exits non-zero with
                        `relation "data_source_endpoints" does not exist` — a missing
                        relation (right-reason red), NOT a connection/command error
```

Authoring `Red-when-absent` is what forces the defect into the light at planning
time: the original `docker compose run …` command's *only* failure mode is the
infrastructure kind (connection refused), so a human author literally cannot
write a right-reason `Red-when-absent` for it. The field's absence-of-a-valid-red
is the tell.

**Change to the exemption.** `skills/write-plan/SKILL.md:195–199` currently
exempts "mechanical config changes" from proof-first — they "don't need a red
test but still carry their normal verification." That phrase (*normal
verification, unproven*) is the exact hole the migration fell into. **Shrink the
exemption to nothing:** every `working` gate authors its flip (`Proves` +
`Red-when-absent`). The exemption now means only "you don't need a separate red
*test file*" — the gate must still be flip-provable. A migration's flip is
"relation does not exist → exists"; it just isn't a test in a test file.

**Reviewer change** (the plan-review block, `skills/write-plan/SKILL.md:430–494`).
The reviewer still can't *run* the command (no code exists at review time —
`:26`), so this is static, but it adds three checks alongside the existing
proof-first compliance check (`:450–465`):

- every `working` gate states `Proves` and `Red-when-absent` (presence);
- `Red-when-absent` describes a *right-reason* failure, not an infrastructure one
  — if the only red the author can describe is "it won't connect," the gate is
  mis-environed → flag;
- the command is not a known anti-pattern: `docker compose run <service>
  <client-cmd>` (overrides server start), a `\d`/describe that exits 0 regardless
  of existence, a blanket `npm test` / `go test ./...` (already forbidden for
  tests at `:181–185`; generalize it).

This is not the safety net — static review still can't catch a novel
mis-invocation that *looks* runnable. Its job is to make the gate **declare its
flip** so the engine has an anchored intent to validate a repair against. The
engine observing the actual flip (§4) is the net.

**Backward compatibility.** Plans authored before this change have bare
`Verification` lines and no `Red-when-absent`. The engine must degrade
gracefully (§4, "Degradation"): without an authored signature it falls back to
generic infrastructure-error detection and is best-effort; with the signature it
is precise. No existing plan breaks.

---

## 4. The execution contract (the engine)

Replaces the current gate step — today `run gate → if (exitZero) advance else
re-dispatch implementer`, cap 3 — with a flip-aware loop. Per `working` pass:

**0. Capture a baseline snapshot `S0` (pass start, before the implementer runs).**
A tiny disinterested agent records the current tree non-destructively —
`git add -A && git write-tree` (returns a tree SHA without mutating the working
tree or index), or `git stash create`. `S0` is the *work-absent* state for this
pass: it contains every prior pass's work but not this pass's. Used **only** to
construct sandbox work-absent environments for flip-validation; it never reverts
the live tree (binds the never-destroy-work rule, `skills/execute-plan/SKILL.md:300`).

**1. Pre-flight.** Run the gate against the current (work-absent) tree. Classify
the result against `Red-when-absent`:

- **green** → the gate proves nothing (false-positive / too weak) → *defective* →
  go to repair (5), skip the implementer.
- **infra-red** (non-zero, failure does *not* match the right-reason signature —
  connection refused / command-not-found / no-such-service / 127 / 126 / parse
  error) → the command can't express its check → *defective* → go to repair (5),
  skip the implementer. **← the migration case dies here, before a single
  implementer dispatch.**
- **right-reason red** (non-zero, matches `Red-when-absent`) → valid gate,
  correctly red because the work isn't done → proceed to (2).

**2. Implement.** Dispatch the implementer (unchanged); judge the report; confirm
every task in the pass is marked done. (Same as today.)

**3. Post-work gate + flip check.** Run the gate.

- **green**, and pre-flight was right-reason-red → **it flipped** → advance. The
  flip *is* the proof the gate is coupled to the work — no judgment call.
- **still red** → run the **artifact probe** (4a).

**4a. Artifact probe.** A disinterested agent checks that the *deliverable named
by `Proves`* exists in the tree — a narrow existence question (file present,
table present via a direct query, route registered via grep), deliberately a
*different* check than the gate so the two don't share a failure mode. It judges
**existence, not correctness**.

- **absent** → the work genuinely isn't done → re-dispatch the implementer
  (this is the only path that spends an implementer attempt against the cap).
- **present** → the deliverable is there but the gate is red → the gate is the
  suspect → go to diagnosis (4b).
- **Bias:** when uncertain, treat the deliverable as **present**. A false
  "present" routes to diagnosis, which has a strong prior toward "work wrong" and
  recovers; a false "absent" re-blames the implementer and reproduces the very
  failure (Pass 1) we are removing.

**4b. Diagnosis** (disinterested; strong prior toward "the work is wrong, not the
gate"). Input: `Proves`, `Red-when-absent`, the gate's output, the probe result.
Output: `work-wrong` (→ re-dispatch implementer, against the cap) **or**
`gate-defective` with a **concrete mechanism** (connection-refused /
command-not-found / wrong-subcommand / references-nonexistent-path /
exits-0-regardless). Default `work-wrong` unless the mechanism is concrete — this
is what stops an agent crying "broken gate" to escape a hard task.

**5. Repair** (disinterested; reached from pre-flight defect or 4b
`gate-defective`). Told to **preserve or strengthen** `Proves`, never weaken.
Input: the defective command, `Proves`, `Red-when-absent`, the mechanism. Output:
a corrected command.

**6. Flip-validation** (the anti-gaming lock). Validate the proposed command:

- run against a **work-absent** state → must be right-reason red (per
  `Red-when-absent`);
- run against the **work-present** state → must be green.

Both hold → **adopt** the corrected gate, advance, and **log the correction as a
divergence** (the human reviews it post-run, not as a blocker). Either fails →
the proposal is rejected; try one more repair, then escalate `gate-undecidable`.

**Constructing the work-absent state without destroying work.** The work-absent
environment is "the environment built from the `S0` tree":

- **Code / test gates** → a throwaway `git worktree` checked out at `S0`; run the
  gate there; discard the worktree. The live tree is never touched.
  (`execute-plan-in-worktree` already has this machinery, which is a bonus once
  it wraps the engine.)
- **DB / migration gates** → build a scratch database from `S0`'s setup
  (apply the migrations present in `S0` — i.e., everything *except* this pass's
  migration) and run the gate against it; or, where the gate is a single
  read, a `BEGIN … <drop this pass's objects> … <run> … ROLLBACK` transaction.
  The work-present run goes against the live, migrated DB.

**Cap accounting.** Two separate budgets: implementer attempts (`work-wrong`
re-dispatches) keep the cap of 3; gate-repair attempts are bounded separately
(≤2 proposals validated by flip). A `gate-defective` verdict short-circuits the
"blame the implementer 3×" loop — so the migration case never burns three
implementer dispatches.

**No bare repeats — the implementer ladder escalates perspective.** A retry only
helps if it carries new input; a third dispatch with the same framing reproduces
the first two. So the cap is not three identical tries — it is a ladder: attempt
1 is the implementer; attempt 2 adds the specific failure (new input — the prior
attempt didn't have it); before attempt 3 a **fresh-perspective strategist**
(disinterested, not the prior implementer) reads the tree + failure history and
prescribes a *different approach* (or rules that genuinely-new external input is
required). The right move was never to *raise* the cap — more identical tries buy
nothing — but to make each rung add a perspective and to escalate `work-stuck`
exactly when the ladder is exhausted, i.e. when a human is the only remaining
source of new input. The `work-stuck` escalation is then **decision-ready**: it
carries the strategist's root-cause read, the different approach already tried,
and (if surfaced) the precise `humanAsk` — so the human's return round-trip is
short. This directly attacks the two human-cost dimensions: being pulled in with
nothing to add, and returning to a run that stalled making no progress.

**Degradation (backward compat).** If a gate has no `Red-when-absent`: pre-flight
still runs and still flags **green** (proves nothing) and **infra-red** via
generic infra-error patterns (connection-refused / command-not-found / 127 /
126 / no-such-file); it cannot positively confirm a *right-reason* red, so it
treats a non-matching non-zero as right-reason and proceeds. Post-work
probe → diagnosis → repair → flip-validation still apply (flip-validation needs
no authored signature — it observes the actual red/green transition). So old
plans get best-effort defect detection; new plans get precise detection.

**Agent roles (all disinterested — none has a stake in advancing the pass):**

| role | input | output |
|---|---|---|
| prepare (snapshot + pre-flight gate run, folded) | command | `S0` tree SHA + pre-flight exit code + tail |
| classifier | pre-flight output, `Red-when-absent` | green / infra-red / right-reason-red |
| gate-runner (post-work) | command | exit code + output tail |
| artifact probe | `Proves`, the tree | present / absent (bias: present) |
| diagnosis | `Proves`, `Red-when-absent`, gate output, probe | work-wrong / gate-defective{mechanism} |
| repair | defective command, `Proves`, `Red-when-absent`, mechanism | corrected command |
| flip-validation | corrected command, `S0`, live state | flips? yes/no |
| strategist (fresh perspective, before the final implementer attempt) | pass, gate, failure history, tree | root-cause + a different approach, or needsHuman + the ask |

(The pass-start **snapshot** and **pre-flight gate run** are folded into one
`prepare` agent — both are mechanical run-and-report steps, so folding them
saves one agent per gated pass without eroding the separation that matters:
the implementer never judges its own gate, and the post-work judgment roles
below stay distinct. This takes the happy path from ~5 to ~4 agents/pass.)

The implementer is the *only* role with a stake in advancement, and it touches
none of the gate machinery.

---

## 5. Escalation taxonomy

The engine returns to the human only for things that genuinely need one:

| kind | meaning | human? |
|---|---|---|
| `blocked` | credentials/access or unauthorized destruction (skeptic-confirmed) | yes — real |
| `work-stuck` | a *proven-valid, flipping* gate the work can't satisfy after the escalating-perspective ladder (implementer → +symptom → strategist-directed different approach) is exhausted | yes — real (decision-ready) |
| `gate-undecidable` | gate defective **and** no disinterested repair produces a flipping command — the intent can't be expressed as a runnable flip | yes — real design defect |
| `invalid-plan` | structural (final pass not `working`, missing restorer) | yes — real |
| ~~gate-command-defective~~ | **removed** — self-repairs (§4.5–6), logged as a divergence | **no** |

The point of the whole exercise: "trivially fixable error in the deterministic
gate" is no longer an escalation class. `work-stuck` now means something precise
(a *valid* gate the work can't pass), distinct from "the gate was broken."

---

## 6. Naming & topology (decision: reclaim `/execute-plan`)

`execute-plan` is the ecosystem's *name* for the plan-execution concept (~60
references across `affirm`'s embedded `.ok-planner/CLAUDE.md` template,
`refine-design`, `brainstorm`, `discover-design`, `merge`, `sketch`,
`review-work`, `review-plan`). Reclaiming the name keeps all of them correct:

- **Rename** `skills/execute-plan-via-workflow/` → `skills/execute-plan/`. The
  workflow engine *becomes* the canonical `/execute-plan`.
- **Delete** the prose `skills/execute-plan/SKILL.md` (its dispatch/judge/gate/
  cap/escalation logic is superseded by the engine).
- **Rewire** `skills/execute-plan-in-worktree/SKILL.md` to hand off to the engine
  (the text "hands off to `execute-plan`" at `:8–14` now correctly names the
  engine).
- All conceptual references to `execute-plan` elsewhere **stand unchanged** —
  they now point at the engine.

---

## 7. Change-set (file by file)

1. **`skills/execute-plan/SKILL.md` (prose)** — delete.
2. **`skills/execute-plan-via-workflow/` → rename to `skills/execute-plan/`** —
   the canonical engine. Edit the embedded engine + skill prose to add §4 (the
   flip-aware loop: snapshot, pre-flight+classify, artifact probe, diagnosis,
   repair, flip-validation) and §5 (the new escalation taxonomy + divergence log
   for autonomous repairs). Drop "experimental" framing.
3. **`skills/execute-plan-in-worktree/SKILL.md`** — rewire handoff target to the
   engine; reconcile its ~14 `execute-plan` references with the rename.
4. **`skills/write-plan/SKILL.md`** — §3: kill the unproven-verification
   exemption (`:195–199`); add `Proves`/`Red-when-absent` to the gate block
   (`:307`, examples `:345–381`); add the reviewer gate-shape check (`:430–494`);
   drop variant-agnostic hedging now that the engine is a given.
5. **`skills/ok-planner/SKILL.md`** — collapse the two execute-plan rows in the
   skill table into one; drop "experimental"; fix the `-in-worktree` description.

No edits needed to the ~60 conceptual `execute-plan` references (reclaimed name).

---

## 8. Open risks / things to watch

- **Pre-flight cost.** Pre-flight runs the gate one extra time per `working`
  pass. Cheap for typecheck/unit/file-scoped gates; expensive for full-stack
  acceptance gates. Mitigant: the acceptance pass is already proof-first
  red-gated (`! <acceptance>`, `skills/write-plan/SKILL.md:239–245`), so its
  pre-flight *is* the red gate — no extra cost there. For other heavy gates the
  extra run is the price of gate-validity; revisit if it bites.
- **Probe / classifier / diagnosis are LLM judgments.** They are narrower than
  the gate (existence; signature-match; concrete-mechanism), disinterested, and
  biased toward the recoverable error. But they are not mechanical. The *only*
  mechanical guarantee is the flip-validation (§4.6); the judgments decide *when*
  to invoke repair, not whether a repaired gate is valid. Acceptable: a wrong
  judgment costs an extra cycle, not a weakened gate.
- **Work-absent reconstruction for DB/stateful gates** is the most complex
  mechanic and the most likely to need iteration. The scratch-DB-from-`S0` path
  is correct but heavy; the `BEGIN…ROLLBACK` path is cheap but only fits
  read-only single-statement gates. Implement code/test gates (worktree@`S0`)
  first; treat stateful-gate flip-validation as the hard follow-on.
- **`S0` snapshot via `git write-tree`** requires `git add -A` of the pre-pass
  tree — consistent with the implementer's per-task `git add -A` checkpointing.
  Confirm it captures untracked files (it does, after `add -A`).
- **Multi-session durability** (resume across a human-cleared escalation) is
  unchanged from the engine's current model and out of scope here.
