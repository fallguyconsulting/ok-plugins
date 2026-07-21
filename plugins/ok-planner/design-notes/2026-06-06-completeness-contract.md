# Completeness contract — spec as a total user-outcome contract

**Date:** 2026-06-06
**Status:** design, pre-implementation (consolidates a working-session design before editing the skills)
**Scope:** `brainstorm`, `write-plan`, `execute-plan`, the `ok-conduct` output style, and aligning touches to `verify`, `review-work`, `review-plan`, `coverage`, `refine-design`, `sketch`, and the `affirm` CLAUDE.md template.

This note locks the contract so the multi-file edit lands coherently. It is the source for the change-set in §7.

---

## 1. The problem

A downstream project ran an intent-vs-reality audit of every completed spec/plan and found **42 user-facing features that were spec'd, marked done, and never actually shipped** — handlers registered but unimplemented, error classes declared but never emitted, flags accepted then ignored, capabilities demoted to "out of scope / V2" mid-spec or dropped during execution and recorded only in divergence files and code comments. Of those, ~30 were deferrals the author never approved.

The diagnosis was not "the engine is weak." The flip-gated engine (`design-notes/2026-06-05-flip-gated-execution.md`) is strong: it proves each gate is coupled to its work. The diagnosis is that **the pipeline never enforces completeness against the spec's full promised surface.** Two specific holes:

1. **The acceptance scenario is singular and optional.** `brainstorm` asks for "at least one acceptance scenario"; `write-plan` turns *the* scenario into *one* acceptance pass. A spec that promises ten user outcomes satisfies the gate with one — the other nine have no gate, so a half-wired or absent capability passes as done. Every "registered but unimplemented" gap lives in this hole.
2. **Deferral is a legal outcome.** Nothing forbids "out of scope / V2 / future / later" in a spec, and the divergence audit *records* an undershoot and the run still completes. So when an implementer hits friction, it can vent through whichever hatch is handy — a spec section, a divergence note, a code comment — and the work still reports done.

The deeper root cause under both: **specs capture mechanism (DSL, protos, config, invariants) but not the business need the mechanism exists to serve.** With no written statement of "a user must be able to get outcome X," dropping the piece that delivers X violates nothing visible. The mechanism can be 100% present while the user value is 0% delivered, and every check passes. ("registered but unimplemented" is exactly that signature.)

---

## 2. The principle: the spec is a total user-outcome contract

A spec's originating content is a **complete, enumerated set of user-outcome stories** — the business need, stated as outcomes a user can observe — and **every downstream artifact derives from and is checked against that set.**

A story:

> **S-<slug>** — As `<role>`, I can `<capability>`, so that `<business value>`.
> **Acceptance:** «real input» reaches the running system → «real observable user-outcome» appears at «real surface».

Two non-negotiables:

- **User-outcome level, not implementation level.** Acceptance is "the downstream node fires," never "the handler is registered." "Returns 200," "the class is declared," "the handler is mounted" are the technical half-truths that let *registered-but-unimplemented* and *declared-but-never-emitted* pass. The acceptance reads value the way a user experiences it: *did the thing the spec promised actually happen?*
- **The story set is the whole contract — floor and ceiling.**
  - **Floor:** every story must demonstrably happen end-to-end before the work is done. A missing story is a red gate, not a divergence note.
  - **Ceiling:** nothing gets built that no story requires. The stories *are* the "that's why we have the spec" boundary, written down.

## 3. The necessity test (required-by-intent vs adjacent)

Completeness means the spec's **intent**, not its literal token list — there are pieces *required* to meet a story's outcome that the spec never spelled out (e.g. the proto wiring an error-subscription needs). The line between "required, build it even though unstated" and "adjacent, don't build it" is decided by **necessity, not similarity.** For any candidate piece of work W, trace it to a story and ask:

> *If W is omitted, does that story's acceptance still hold for a user?*

- **No** (the story is broken/partial without W) → W is **required by intent**: build it, even though the spec never named it. This is the mandatory "overshoot."
- **Yes** (every story's acceptance already holds without W) → W is **adjacent**: don't build it; it's a different spec.

The bias toward completeness lives *inside* the boundary (when unsure whether a story truly holds, assume it doesn't and finish it); the wall against creep is the edge of the same test (nothing is built unless a story needs it). "Err toward more" and "don't invent features" are the floor and ceiling of one closure.

**This is self-enforcing once acceptance is per-story and total:** a story cannot pass its acceptance gate without its necessity closure, so the gate forces the unstated-but-required pieces to exist; and nothing adjacent ever appears, because no story's acceptance depends on it.

## 4. Asymmetric divergence: overshoot is legal, undershoot is not

The divergence report flips meaning:

- **Legal:** overshoot (built unstated-but-required work to satisfy a story) and forced shape-changes (the existing flip-gated `gateCorrections`, plan-shape adaptations).
- **Illegal:** undershoot — a promised story not delivered, a stub/no-op standing in for the value, a "deferred / out of scope / TODO / unimplemented" marker. An undershoot is a **non-completion**, never a recorded-and-accepted divergence.

Nothing bounces to the user as a scope decision. The only thing that surfaces is a **physical** blocker — a story whose acceptance needs a credential or external system the agent cannot obtain — handled by the existing escalation taxonomy (`blocked`, `work-stuck`), at the end, as a loud non-completion, never a silent drop.

## 5. Why this is mostly wiring, not new machinery

The engine already proves a gate is coupled to its work (the flip), already has an acceptance pass that boots the real assembled product with the value-delivering component real (not stubbed), already runs every `working` gate, already biases toward the recoverable error, and already refuses to complete with a red gate. **The single change that closes the 42-gap hole is making the acceptance surface plural and total** — one acceptance gate per story instead of one per spec — plus removing the deferral hatch at authoring and naming the necessity/overshoot discipline for the implementer. The flip gate then enforces completeness for free.

---

## 6. The contract per skill

- **`brainstorm`** — the spec *opens* with `## User outcomes`: the complete enumerated story set, each with a user-outcome-level acceptance scenario. Feature-deferral vocabulary ("out of scope / non-goals / V2 / future / later / deferred" for a *capability*) is forbidden in the spec; bounding scope means omitting the story (or routing it to a sketch via the existing source-sketch defer path), never marking it deferred. (The existing "delivery process is out of scope — no PRs/commits" exclusion stays; that bounds *process*, not a feature.) The reviewer checks: the spec leads with a complete story set; every user-observable capability the spec describes has a story; every acceptance is user-outcome level (reject implementation-level); no feature-deferral vocabulary anywhere.
- **`write-plan`** — the acceptance pass gates **every** story, not one: the final pass(es) carry one end-to-end acceptance gate per story (each proof-first, real product, real value-delivering component), and the plan covers each story's **necessity closure** (the unstated-but-required pieces). The reviewer's acceptance check becomes per-story: a promised story with no acceptance gate is a blocking gap.
- **`execute-plan`** — the implementer is given the necessity test + asymmetric-completeness discipline (build required-by-intent work even if unstated; never defer/narrow/stub; the only non-delivery is a genuine physical blocker). The divergence auditor additionally scans the diff for undershoot signals (deferral language, stubs/no-ops standing in for a promised outcome, `TODO`/`unimplemented` on a story path) and reports them as **completion failures**, not neutral divergences. The per-story acceptance gates (from `write-plan`) ride the existing flip loop — the run cannot complete with any story's acceptance red.
- **`ok-conduct`** (output style) — a new rule, "Completeness is the floor — overshoot, never undershoot," stating the necessity test and the asymmetric-divergence rule as standing agent behavior, consistent with the existing "Run unsupervised" blocker list.
- **`verify` / `review-work` / `review-plan`** — check every story's acceptance is met / gated, not a generic "acceptance scenario."
- **`coverage`** — reframed: acceptance is now front-loaded as the spec's story set, so coverage is the **standing regression/diagnostic** over story acceptance (and the recovery path for pre-contract specs), not the place acceptance is first invented.
- **`refine-design` / `sketch`** — inherit the contract; `refine-design` flows into `brainstorm` (its produced spec carries stories); `sketch` notes that the eventual spec will enumerate user-outcome stories.
- **`affirm`** — the embedded `.ok-planner/CLAUDE.md` template notes that specs lead with a complete user-outcome story set.

---

## 7. Change-set (file by file)

1. **`skills/brainstorm/SKILL.md`** — promote "The acceptance scenario" to "User outcomes" as the spec's leading, plural, total contract; add the no-feature-deferral rule and the necessity framing; extend the reviewer block (completeness, user-outcome level, no-deferral vocabulary).
2. **`skills/write-plan/SKILL.md`** — generalize the acceptance pass from one scenario to one gate per story; add necessity-closure coverage; per-story acceptance reviewer check.
3. **`skills/execute-plan/SKILL.md`** — add necessity/overshoot discipline to `implementerPrompt`; add undershoot scanning to `auditPrompt`; note in the prose that acceptance gates are per-story.
4. **`output-styles/ok-conduct.md`** — add the "Completeness is the floor" rule.
5. **`skills/verify/SKILL.md`, `skills/review-work/SKILL.md`, `skills/review-plan/SKILL.md`** — per-story acceptance checks.
6. **`skills/coverage/SKILL.md`** — reframe as the standing check over front-loaded story acceptance.
7. **`skills/review-plan/SKILL.md`** — add the same undershoot/floor-vs-ceiling check the final review got, since it is the other review surface with a spec to check against.
8. **`skills/refine-design/SKILL.md`, `skills/sketch/SKILL.md`, `skills/affirm/SKILL.md`** — assessed, **not edited** (deliberate non-edit, recorded rather than silent). `refine-design` hands spec-writing off to `brainstorm`, so it inherits the story contract with no change of its own; `sketch` is deliberately pre-spec and informal (forcing story structure there would contradict its purpose); `affirm`'s embedded `CLAUDE.md` governs how agents *treat* the `.ok-planner/` folder, not how specs are structured. By the contract's own necessity test none is required for the contract to hold, so editing them would be padding, not overshoot.

---

## 8. Open risks / things to watch

- **Acceptance-gate cost scales with story count.** N stories → N end-to-end gates, each booting the real product. Mitigant: stories share one assembled-product bring-up where possible (one acceptance pass, N assertions against the same running stack); the flip pre-flight for the acceptance pass is the red gate, so no extra cost there (as the flip-gated note already observed).
- **Story granularity is a judgment call.** Too coarse and a story hides sub-outcomes that can each undershoot; too fine and the set is noise. The bar: one story per *distinct user-observable outcome* the spec promises — the same bar the audit used to find the 42.
- **"User-outcome level" acceptance must be enforced, not aspirational.** The reviewer rejecting implementation-level acceptance is load-bearing; without it the contract degrades back into mechanism checks. The `coverage` skill's existing "nominal-not-real" discipline (rejecting stub-driven / shape-only / tautological tests) is the same standard and should be cited.
- **Pre-contract specs.** Specs already in `history/` have no story set. They are not retrofitted; `coverage` remains the recovery path for them.
