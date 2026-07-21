---
name: refine-design
description: "ONLY activated by explicit /refine-design slash command. Never auto-triggered by conversation content."
---

# Refine Design

Specialization of `brainstorm` for resolving design tensions. The user
picks tensions to address, picks a resolution shape per tension, and
the skill hands off to `brainstorm` to produce a spec that covers both
the concept-doc mutations and the code reconciliation. From the spec
forward, the standard `brainstorm` → `write-plan` → `execute-plan`
pipeline applies.

<HARD-GATE>
Do NOT mutate `concepts/`, move tension files, change tension
status, write to `review-notes.md`, or write code during the
intake. The design docs are a source of truth with the same
weight as code: they change only through plan execution. The
intake's only job is to set up the brief for `brainstorm`, which
will turn the decisions into a `## Design changes` section in the
spec. `execute-plan` applies the mutations when it carries out the
plan.
</HARD-GATE>

<DIALOGUE-REQUIRED>
The intake (tension selection, resolution-shape picking, review-notes
walk) is a dialogue with the user. The user is the design oracle —
they make the calls. Do not pick resolution shapes on their behalf,
do not "interpret" a hesitant answer as a yes, do not skip review-notes
entries on the user's behalf. Auto-mode does not authorize design
decisions; it only silences mechanical permission prompts.
</DIALOGUE-REQUIRED>

## Why this exists

The design docs under `.ok-planner/design/` are the project's
canonical noun catalog. Code references the design at points of
enforcement (`@concept: <slug>` annotations, or equivalent); the
design owns the definition. When a concept's boundary drifts from
the code, that's a defect to fix — but the fix is rarely *just*
the code or *just* the concept doc. Usually it's both: the concept
gets sharpened, the code gets brought into line, the alias gets
retired across both surfaces.

`brainstorm` is the project's tool for "I have a change in mind,
help me design it." `refine-design` is brainstorm pointed at the
tensions catalog: the change in mind is "resolve these tensions,"
and the resulting spec covers both the design-doc work (under a
`## Design changes` section) and the code work as one coherent
piece. `execute-plan` then applies all of it.

This isn't a separate pipeline. It's brainstorm with a specialized
intake.

## Relationship to brainstorm

`refine-design` owns:
- Loading the tensions catalog + relevant concept files + review-notes
- Walking `review-notes.md` with the user (read-only — entries are
  captured in the brief, not written back to the file)
- Letting the user pick which tensions to address this session
- Letting the user pick a resolution shape per selected tension
- Constructing a brief for `brainstorm` that captures every
  decision (tensions to resolve, picked shapes, tensions to reject,
  affected concept files, code paths to reconcile, review-notes
  outcomes)

`brainstorm` owns everything from there:
- Clarifying questions
- Design proposal
- Spec writing (with the `## Design changes` section capturing
  all the tension-file moves, rejection moves, concept-file
  mutations, and `review-notes.md` rotation)
- Spec review loop
- User approval
- Transition to `write-plan`

`execute-plan` later applies the `## Design changes` mutations as
part of carrying out the plan, alongside the code changes that
conform to them.

`refine-design` does NOT duplicate brainstorm's machinery. It sets
up context and invokes `ok-planner:brainstorm`.

## Inputs

- `.ok-planner/design/tensions/` — open tensions to choose from.
- `.ok-planner/design/concepts/` — read for context; mutations happen
  during `execute-plan`, not now.
- `.ok-planner/design/review-notes.md` — agent-confessed uncertainty
  from the last `discover-design` run.
- `.ok-planner/design/_discover/` — referenced for evidence during the
  walk.

## When to invoke

- After `discover-design` has produced `concepts/` and `tensions/`,
  and the user is ready to start resolving.
- When new tensions are added (by a later `discover-design` re-run or
  by a `brainstorm` spec that surfaced an unresolved concept question)
  and the user wants to address some.

## Process

1. Run `ok-planner:affirm` so the layout exists.
2. Verify `.ok-planner/design/concepts/` and
   `.ok-planner/design/tensions/` exist. If either is empty, tell the
   user to run `/discover-design` first and stop.
3. **Walk `review-notes.md` if present.** Read-only — surface
   entries section by section. Per entry, capture the user's
   verdict in the brief:
   - Confirm the extractor's call (no action needed).
   - Promote to this session's tension queue (which tension(s) it
     implies — a new tension to create, or attach to an existing
     one).
   - Defer (note in the brief that the review-note should remain
     in the file for a future session).
   - Reject (note in the brief that the review-note should be
     struck through with a one-line reason).

   Do **not** modify `review-notes.md` during this walk. The brief
   will record the outcomes, and `execute-plan` will apply them
   (struck-through entries, file rotation, etc.) when it carries
   out the spec.

4. **Tension selection.** Show the user the open tensions catalog
   grouped by category. Ask which they want to address this
   session. Defaults: smallest-first, by-affected-concept,
   by-category, or freeform pick. The user names tensions; the
   skill records them as the session queue.

5. **Resolution-shape walkthrough.** For each tension in the
   session queue:
   - Display the tension entry (What is muddy / Why it matters /
     Resolution candidates).
   - Quote the relevant concept file(s) and `_discover/` material.
   - Present resolution shapes — the extractor's candidates, or
     new ones if the user wants. Each shape should be stated as a
     concrete change to one or more concept docs AND the code
     path(s) that need reconciling. State the concept-doc change
     at the concept level — which Definition / Boundaries /
     Invariants text would change, and what the new text says —
     following the concept self-containment rule from
     `skills/_shared/artifact-definitions.md`. The new body text
     is path-free; the code-paths-needing-reconciling portion of
     the brief is a separate item (the code work), not part of
     the proposed concept body.
   - The user picks. Capture the verdict in the brief:
     - **pick shape X** — record the pick.
     - **reject the tension** — record that the tension should be
       moved to `tensions/_rejected/` with `status: rejected` and
       a `rejection-reason`. Drop from the session queue.
     - **defer this one** — drop from the session queue and leave
       the tension as `status: open` in the brief. (No action will
       be taken on this tension; it stays open for a future
       session.)

   Do **not** mutate any tension file during this walkthrough.
   File moves and status changes are part of the spec's `## Design
   changes` section, applied by `execute-plan`.

6. **Construct the brief.** Build a brief in the conversation that
   names:
   - The session's tension queue (which tensions are being
     resolved, with the picked resolution shape for each).
   - Tensions rejected during intake (slug + rejection reason for
     each — these will move to `tensions/_rejected/` via
     `## Design changes`).
   - Affected concept files and the code paths needing reconciling.
   - Aliases being retired (if any).
   - Review-notes outcomes (promote / defer / reject / confirm).
   - A proposed spec slug (date + short summary, e.g.,
     `2026-05-10-vocabulary-cleanup`) so brainstorm can name the
     spec consistently.

7. **Hand off to brainstorm.** Invoke `ok-planner:brainstorm`. The
   brief is the seed context — brainstorm recognizes the goal is
   already established and proceeds directly to clarifying
   questions / design / spec writing.

   The spec brainstorm writes will include a `## Design changes`
   section listing every concept-file mutation, tension-file move
   (resolved or rejected), new concept/tension file, and
   review-notes outcome from the brief. The rest of the spec
   (architecture, components, testing strategy) covers the code
   work as brainstorm normally handles it.

8. **brainstorm's downstream flow.** From step 7 onward, the user
   is in brainstorm's flow: spec review subagent, user spec
   review, transition to `write-plan`.

9. **What happens during execute-plan.** When the plan eventually
   executes, it applies the code changes AND every entry in the
   spec's `## Design changes` section. Tension files move to
   `tensions/_resolved/` or `tensions/_rejected/` as the spec
   directs; concept files get their mutations; `review-notes.md`
   gets its strikethroughs and is rotated to
   `review-notes-<date>.md`.

## Tension lifecycle

Tension files do not change state during the refine-design intake.
All state transitions happen during `execute-plan` as it applies
the spec's `## Design changes` section.

```
open                           ← state after discover-design
  ↓ execute-plan applies a spec from refine-design
resolved                       ← moved to tensions/_resolved/
  or
rejected                       ← moved to tensions/_rejected/

(alternative paths)
open → open                    ← user deferred; tension untouched
```

Between the refine-design intake and the execute-plan run, the
file stays `status: open`. The decision about its fate lives in
the spec, not in the file itself, until execute-plan applies the
mutation.

## Session shape

A refine-design session produces **one spec**, just like brainstorm.
If the session queue is broader than one spec can cover well, surface
that to the user — they can either drop tensions from the queue or
defer the broader scope to a follow-up session. Do not unilaterally
split into multiple specs.

A session can resolve a single tension (small fix) or a cluster of
related tensions (the three `Store` / `ClaimProducer` aliases are one
cleanup; the three `frame_resolution` / `mode` vocabulary tensions
are one cleanup; etc.).

## Mutability discipline (for execute-plan to follow)

When `execute-plan` applies the spec produced by this skill, the
`## Design changes` section is its instruction set:
- Concept files in `concepts/`, story files in `stories/`, and
  decision files in `decisions/` are mutated in place per each
  bullet (depending on which the tension resolution affects).
  The affected body section is rewritten to reflect the new
  state — no audit-trail entry is added to the artifact. The
  git commit carries the lineage; the artifact body is
  current-state only.
- Resolved tensions move to `tensions/_resolved/<slug>.md` with
  `status: resolved` and a `resolution:` block.
- Rejected tensions move to `tensions/_rejected/<slug>.md` with
  `status: rejected` and a `rejection-reason:` field.
- New tensions surfaced during brainstorm's dialogue (and captured
  in `## Design changes`) are written to `tensions/` as
  `status: open`.
- `review-notes.md` outcomes apply: strikethroughs added per the
  spec, file rotated to `review-notes-<date>.md` if the spec
  directs.

## What this skill does NOT do

- Doesn't mutate `concepts/`, `stories/`, `decisions/`,
  `tensions/`, or `review-notes.md` directly. All design-doc
  changes happen in `execute-plan` after spec + plan approval, so
  the design changes ride alongside the code changes and stay
  reversible until then.
- Doesn't write code. Brainstorm produces the spec; write-plan
  sequences the work; execute-plan does the writing.
- Doesn't re-do discovery. If the user finds that a tension can't be
  resolved because discovery was thin in some area, they exit and run
  `/discover-design` to back-fill, then return.
- Doesn't auto-pick resolution shapes. Every shape requires a user
  verdict, full stop.
- Doesn't introduce code annotations. If the project adopts a
  `@concept:` convention, that's a separate brainstorm in its own
  right.
