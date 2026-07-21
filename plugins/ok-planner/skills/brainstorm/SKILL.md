---
name: brainstorm
description: "ONLY activated by explicit /brainstorm slash command. Never auto-triggered by conversation content."
---

# Brainstorming Ideas Into Designs

Turn ideas into specs through collaborative dialogue. Understand context, ask questions, present design, get approval.

<HARD-GATE>
Do NOT write code, scaffold, or take implementation action until the user approves a design. The design can be short for simple projects, but it must exist and be approved.
</HARD-GATE>

<DIALOGUE-REQUIRED>
This skill is a dialogue with the user. The clarifying questions, section-by-section approvals, spec review, and handoff to write-plan are not optional. Specifically, do not:

- Collapse the intake into assumptions and proceed
- Bundle multiple questions into one message — one question per message, wait for the answer
- Pick between options you have offered the user on their behalf — present the options, then wait
- Move past a question without a user answer in hand
- Chain into `write-plan` before the user has approved the written spec

The product of this skill is a user-approved spec — that requires the user. General "run unsupervised" guidance does not apply here; this skill *is* the dialogue.
</DIALOGUE-REQUIRED>

## Process

1. **Affirm layout** -- invoke `ok-planner:affirm` so `.ok-planner/specs/` exists before any writing starts.
2. **Establish the goal** -- if context from the conversation makes it clear what to brainstorm, proceed. Otherwise ask the user what they want to design. If invoked from `ok-planner:refine-design`, the goal has already been established in the conversation (a brief naming: the session's tension queue with picked resolution shapes, any tensions rejected during intake, affected concept files, code paths needing reconciliation, review-notes outcomes, and a proposed spec slug) — recognize that brief as the goal and proceed. Every item in the brief that touches the design docs must end up under `## Design changes` in the spec. If the brainstorm is initiated from one or more existing sketches under `.ok-planner/sketches/` — the user names one, or adopts one surfaced during context exploration — note them as the brainstorm's **source sketches**: the spec supersedes them, and they get archived once it is approved (see "Source sketches").
3. **Explore project context** -- check files, docs, recent commits, and (if it exists) the design docs under `.ok-planner/design/` to understand "how the project is now"
4. **Ask clarifying questions** -- one at a time, prefer multiple choice
5. **Lock the user outcomes first** -- before proposing approaches or any mechanism, draft the user-outcome stories — each with Acceptance, Falsifier, and Proof — and get the user's explicit approval on them. The mechanism discussion (approaches, architecture, components, technical decisions) follows once the stories are agreed. This keeps "what the feature is and how we'll know it works" a separate, settled conversation from "how we'll build it." See "User outcomes" below for the shape.
6. **Propose 2-3 approaches** -- with trade-offs and your recommendation
7. **Present design** -- scaled to complexity, get user approval section by section. Surface any design-doc impacts (concept additions/mutations, tension resolutions or new tensions) as part of the discussion; they go into the spec, not into the design docs directly.
8. **Write spec** -- save to `.ok-planner/specs/YYYY-MM-DD-<topic>-design.md`. If the work touches the design docs, include a `## Design changes` section enumerating the mutations execute-plan will apply. If the work affects any existing story's proof exhibition (see step 8a), include a `## Proof changes` section.
8a. **Surface proof implications** -- after the spec is drafted, scan it for changes that affect existing stories' proof exhibition. For each affected story, dialogue with the user (see "Proof implications" below) and capture the verdict in `## Proof changes`. This step happens before spec review; the reviewer checks that all proof-affecting changes are accounted for.
9. **Spec review** -- dispatch reviewer subagent, fix issues, re-review until clean
10. **User reviews spec** -- ask user to review before proceeding
11. **Archive source sketches** -- if the brainstorm had source sketches: capture any deferred content in a new sketch, then move each source sketch to `.ok-planner/history/sketches/` (see "Source sketches"). Skip if there were none.
12. **Transition** -- invoke ok-planner:write-plan

## What a spec is

A brainstorm produces **one spec**, and a spec is simply a **unit of
work**: the set of things the user wants done. It carries no requirement
of topic cohesion — the items need not belong to one feature, one
subsystem, or one theme. "Get all of these done" is a complete, valid
scope. Treat whatever the user hands over as that single unit and design
it as one spec.

Do **not** split it into multiple specs, and do **not** open the "these
seem unrelated, should we break this into smaller scopes?" discussion —
that decomposition is the user's to raise, not yours. If the user asks to
narrow or split, follow them; otherwise design the whole set as given.

A spec describes **what to build**, and it **opens with its user
outcomes** — the complete, enumerated set of business needs it serves,
each a story with a user-outcome-level acceptance (see "User outcomes"
below). The mechanism that follows — architecture, components, data
flow, behavior, error handling, testing strategy — exists to serve those
outcomes. It does not describe **how to ship it**. No PRs, commits, branches, merge strategies, deployment steps,
release plans, or rollout phases. Delivery process is out of scope — the
user owns that.

## User outcomes — the spec's originating contract

A spec **opens** with its user outcomes: the complete, enumerated set of
business needs it serves, each stated as a **story** a user can observe.
This is the spec's originating content — written first, before any
mechanism (architecture, components, protos, config). The mechanism
exists to serve the stories; the stories are not derived from it.

**The canonical definition of a story lives in
`skills/_shared/artifact-definitions.md`.** Read it before writing
stories in a spec. It covers: what a story is (a durable user
expectation, not a build record or development task), the
durable-user-expectation exclusion (if it reads as "we added X" or
"we migrated A to B," it's not a story — those are TDs, refactors, or
implementation events), the delivery-surface-is-not-part-of-the-story
rule (whether the user reaches the capability through CLI / HTTP /
wire / job / UI is a TD, not story content), and the canonical shape
(As «role», I can «capability», so that «business value» + Acceptance
+ Falsifier + Proof).

The rest of this section covers the spec-authoring application of
that canonical definition.

### Spec-inline story format

In a spec, each story takes this compact form (the same canonical
shape as `design/stories/<slug>.md`, condensed for spec inlining):

> **STORY-«slug»** — As «role», I can «capability», so that «business value».
> **Acceptance:** «what the user does, in their terms» → «what the user
> observes happening».
> **Falsifier:** «the user-observable absence that would prove this story
> NOT delivered».
> **Proof:** «demo | example | proof | all-of-the-above» — «what the
> proof must exhibit to a third party».

### Acceptance is user-observable

The acceptance is stated at the **user-outcome level**, in language a
user of the product would recognize. It names what the user does
(the action in the user's terms — "submit a claim," "publish a
digest," "acquire a hold") and what they observe (a persisted state
they can see, a returned result they can read, a downstream effect
they can verify — *not* "the function returns the right struct,"
*not* "the handler is registered," *not* "returns 200"). The
component that *delivers the value* is real: if the story's whole
point is that some worker, executor, sensor, or subscriber does real
work, the acceptance names the real effect that component produces,
and a canned stub standing in for it is not an acceptance.

Concretely: a story acceptance reads "the co-holder submits a claim
and sees it persisted," not "POST /claims/{id} returns 201 with the
claim body." The route is in the relevant TD; the user-observable
outcome is in the story.

### Falsifier shape

The **Falsifier** is the same outcome viewed from the opposite side —
the concrete observation that would make a reviewer say "this story
has not been delivered." Phrase it as a **user-observable absence**:
the user takes the action and the promised result never appears; the
result appears but is unrelated to their input; the result looks real
but the underlying state is synthetic (a stub or canned response
standing in for the value-delivering component's real work). Write it
sharply enough that a reviewer reading the diff can point at a
specific absence — not a generic "the feature doesn't work" and not
the acceptance rephrased in the negative.

### Proof shape

The **Proof** is the artifact that exhibits the story working to a
third party — a demo, an example, an executable proof, or all of the
above. Its purpose is *delivery* (showing the work was done, at the
moment of completion) — not regression protection, which is a
separate concern handled elsewhere. A demo is a runnable artifact
that walks through the feature; an example is a worked illustration
showing how the feature is used and what it produces; a proof is an
executable verification that asserts the outcome. The form is the
user's call per story — pick what would actually convince a third
party that the work was done. The proof's anti-hollow property is
built into its purpose: it must *exhibit* the feature, not just
check it, so it cannot easily collapse to a shape assertion, a
registration check, or a green-from-birth filter. Same artifact in
many cases, very different gravity on the writing.

**The story set is the whole contract — floor and ceiling.**
- *Floor:* every story must demonstrably happen end-to-end before the
  work is done. `write-plan` turns each into an executable acceptance
  gate; the run cannot complete with any story's acceptance red.
- *Ceiling:* nothing gets built that no story requires. The stories are
  the boundary — that is what the spec is *for*.

**No forward-looking content.** A spec describes only what will be
built; there is no syntax for bounding scope other than omission. The
spec contains no "out of scope," "non-goals," "future work," "V2,"
"later," "deferred," "deliberately not addressing," or "open
questions" — none of these describe work that will happen, so none
of them are valid spec content. The pipeline treats such language as
un-sanctioned deferral, not boundary — it is exactly how spec'd
features historically ended up unbuilt.

To bound scope: **omit the story** (or, if it came from a source
sketch the user wants to keep for later, route it back to a sketch —
see "Source sketches"); never write it into the spec as deferred.
The boundary is decided once, at authoring, by which stories the
spec contains — never re-decided during execution.

The same rule applies to technical decisions: a decision is either
made and recorded in the spec, or it is not in the spec. There is
no "we'll decide this later" or "leaving this open for now." If a
choice needs to remain open because the user has not decided, it
is a tension that should be resolved via `/refine-design` before
brainstorm proceeds — not a spec entry.

**The agent does not propose omissions.** Scope is the user's call,
surfaced by the user. The agent does not ask "should we leave X for
later?" or "what if we deferred Y?" because doing so introduces
the very framing this rule forbids. The agent writes only the stories
the user actually wants and the technical decisions the user actually
makes.

(The "delivery process is out of scope — no PRs/commits/branches"
exclusion above is unaffected: it bounds *process*, not a feature
or a decision.)

**Intent over literal text (the necessity rule).** The contract is each
story's *intent*. Implementation must build whatever is **necessary** for
a story's acceptance to hold — including pieces this spec never spelled
out — and **nothing adjacent** the stories don't require. The test is
necessity, not similarity: a piece is in scope iff some story's
acceptance fails without it. `write-plan` and `execute-plan` enforce this;
the spec's job is to state the outcomes precisely enough that "does this
story's acceptance hold?" has a clear answer.

These are design artifacts, not tests yet — brainstorm writes them in
prose; `write-plan` turns each into an executable end-to-end gate (its
"acceptance pass"). Writing them now forces the design to state its own
success conditions before any code exists, in words a green unit test
against a fake cannot satisfy.

**When a spec needs none.** A spec with no user-observable behavior
change — a pure refactor, docs- or concept-doc-only work, an internal
mechanism no user reaches — has no user-outcome stories, and that is
correct. The bar: does the running product do something observably
different for a user? If yes, every such outcome is a story; if no,
skip the section. When unsure, write the story. (A story-less spec
still carries its technical decisions and manifest — see below — so
the closing audit still has something to walk.)

## Technical decisions — atomic, enumerable

The spec's mechanism (architecture, components, data flow, behavior,
error handling, testing strategy) is captured as a list of **technical
decisions** alongside any prose context. Each technical decision is
a discrete item the closing auditor can pair with implementation —
kept as decided, or diverged with reason — so every choice the spec
made gets accounted for at the end of execute-plan.

**The canonical definition of a decision lives in
`skills/_shared/artifact-definitions.md`.** Read it before writing
TDs in a spec. It covers: what a decision is (a real
architectural/technical choice with non-trivial tradeoffs, where a
plausible different choice existed), what TDs may include (technical
detail; the Choice section may name the specific artifact picked
because the artifact identity is what carries the tradeoff), and what
TDs are not (specs that enumerate implementation steps; designs that
describe how the chosen thing works in detail).

The rest of this section covers the spec-authoring application.

### Spec-inline TD format

In a spec, each technical decision takes this compact form:

> **TD-«slug»** — «the decision named in plain words».
> **Choice:** «the option the spec adopts».
> **Rationale:** «one or two sentences on why».
> **Alternatives:** «the options considered and rejected — only when
> the spec wants to record them; omit when the choice is uncontested».

### Atomicity

Make each decision **atomic**: one decision per item. "Use X for
persistence, Y for messaging, and Z for caching" is three decisions,
not one. The closing audit pairs each TD with the implementation;
lumping them together defeats the audit because "kept" and "diverged"
cease to be well-defined.

Prose context — architecture diagrams, data-flow narratives,
behavior descriptions — is still welcome and useful. It illuminates
decisions and provides connective tissue between them. The atomic
TD list is what makes the audit possible; the prose is what makes
the spec readable. Both belong.

A spec without technical decisions is rare but legitimate — a
docs-only spec, for example, may have stories with no architectural
choices to record. When unsure, write the decision down: an atomic
TD costs little and pays back at audit time.

## Spec manifest — the contract the audit walks

A spec closes with a **manifest** — a tight, single-place enumeration
of everything the spec commits to. This is the literal index the
completion auditor walks at the end of execute-plan: every story
gets paired with its proof artifact, every technical decision gets
paired with the implementation that honored or diverged from it.
The three sections of the closing report (proof walkthrough,
decisions kept, decisions diverged) are mutually exhaustive against
this manifest — together they cover 100% of it.

The manifest is short by design: one bullet per item, slug and a
one-line summary. The full content of each item lives in its
relevant section above; the manifest is the index, not a restatement.

```
## Manifest

### Stories
- **STORY-claim-co-holder** — co-holder can complete a claim end-to-end (Proof: demo)
- **STORY-stale-claim-recovery** — stale claims auto-recover within 60s (Proof: executable test)

### Technical decisions
- **TD-persistence** — Postgres with `pgx` driver
- **TD-claim-recovery-cadence** — 30s tick interval
- **TD-handler-registration** — explicit registration, no auto-discovery
```

If the spec touches durable design docs (see "Capturing design changes
in the spec" below), the manifest also enumerates which docs change —
new or mutated stories landing in `design/stories/`, new or mutated
decisions landing in `design/decisions/`, concept mutations, tension
moves. Same shape: slug + one-line summary, with the full delta
captured in `## Design changes`.

The manifest is what makes deferrals structurally impossible: there
is no syntax for "in the manifest but not built." Every item in the
manifest must be built, exhibited (for stories), or honored/recorded
(for decisions). The closing audit checks exactly this; a missing
pair is a blocker, not a divergence.

## Asking Questions

- One question per message
- Prefer multiple choice when possible — presented as plain text (A, B, C…) with a recommendation. Free-form replies are always fine.
- Do **not** use tools that constrain the user's reply to a predetermined structure (e.g. `AskUserQuestion`, poll-style pickers, forced single-select widgets). Ask in prose so the user can answer in prose, pick a letter, push back, reframe the question, or go off-script.
- Focus on purpose, constraints, success criteria
- Scope is the user's call. A sprawling or many-item scope is fine — it is one unit of work, not a problem to fix. Don't ask whether to narrow it, and don't unilaterally decompose it into sub-projects or separate specs. Genuine clarifying questions about purpose, constraints, or a specific item are still welcome; "should we split this up?" is not.
- Sequencing and task ordering are `write-plan`'s concern — defer if it comes up, unless the ordering choice is load-bearing for the design (it enables an invariant, rules out a footgun, picks between materially different futures), in which case it's a design decision and stays in the spec.

## Presenting the Design

- Scale each section to its complexity
- Ask after each section whether it looks right
- Cover: the user outcomes first (the complete set of stories that define what "working" looks like when the product runs), then architecture, components, data flow, error handling, testing
- YAGNI ruthlessly

## Surface every tradeoff — never resolve one silently

Many design decisions trade one desirable property against
another: correctness vs. speed, completeness vs. latency,
durability vs. cost, robustness vs. simplicity, atomicity vs.
throughput. When a decision has this shape, **name the tradeoff
and let the user decide it.** Do not pick a side on their behalf,
and do not let a default feel so obvious that you skip surfacing
it — "obviously we'd make this async so it doesn't add latency" is
exactly the call that silently spends a load-bearing property (a
complete, durable record) to buy a local one (request latency).

The failure mode this guards against is not "the agent chose
wrong." It is "the agent traded away a load-bearing property to
optimize a local concern, never recognized it as a tradeoff, and
so never surfaced it." The standard is: default to rigor, and
surface anything that strays from it.

In practice:
- When a choice pits two good properties against each other, stop
  and put both sides to the user — in prose, with your
  recommendation — one question at a time, like any other
  clarifying question.
- A resolved tradeoff is a design decision: record it in the spec
  (and under `## Design changes` if it changes a concept's
  invariants or boundaries).
- A tradeoff the user chooses to leave open is a tension: capture
  it as a `## Design changes` tension entry (see "Tension
  impacts") — not a silent default.
- The dangerous tradeoff is the one you don't see. When a choice
  protects a local metric (latency, code size, throughput), ask
  what global property it might be spending — completeness,
  durability, ordering, atomicity — and surface the exchange.

## Design docs awareness (read-only)

If `.ok-planner/design/` exists, it is the project's canonical
durable model and a source of truth equal in weight to the code.
The model has four kinds of artifact, each self-contained (no file
paths, no `code:`/`pkg:` citations, no external-doc references):

- `concepts/` — load-bearing nouns with definitions, boundaries,
  invariants
- `tensions/` — open ambiguities and tradeoffs awaiting resolution
- `stories/` — durable user-outcome stories (those that have been
  shipped and now describe what the product does)
- `decisions/` — durable technical decisions (architectural and
  mechanism choices the project has made)

**Brainstorm is read-only against the design docs.** Mutations
happen later, via `execute-plan` carrying out a spec-directed
plan. Read the docs now; capture changes in the spec; let the
pipeline apply them.

During step 3 (Explore project context):

1. Read `.ok-planner/design/concepts.md` — the auto-generated TOC,
   always small, always one-shot-readable. Now you know what
   concepts exist.
2. Grep for `@concept:`, `@story:`, and `@decision:` annotations
   in the area you're exploring (`rg '@(concept|story|decision):' <path>`).
   Each marks a load-bearing site for the named artifact.
3. Read `concepts/<slug>.md`, `stories/<slug>.md`, and
   `decisions/<slug>.md` in full for any artifact surfaced by
   step 1 or 2 that the brainstorm's subject area touches.
4. Check `.ok-planner/design/tensions/` for open tensions in the
   same area — they may already describe the muddiness the
   brainstorm wants to address, in which case the user might want
   to run `/refine-design` for those tensions instead of (or
   alongside) this brainstorm.

Use the model's terms in the design and respect its stated
boundaries, invariants, story acceptances, and recorded decisions.
If the design would change a concept's shape, add a new concept,
retire one, resolve or raise a tension, introduce or mutate a
story, or introduce or mutate a decision, capture that as a
`## Design changes` entry in the spec (see "Capturing design
changes in the spec" below). Do not mutate `concepts/`,
`tensions/`, `stories/`, `decisions/`, or any other file under
`.ok-planner/design/` during brainstorm — those are execute-plan's
to touch.

If `.ok-planner/design/` doesn't exist, this skill operates
without the durable-model context. Do not create it as a side
effect; do not suggest `/discover-design` unless the user asks.

## Working in Existing Codebases

- Explore current structure before proposing changes. Follow existing patterns.
- When the spec introduces shape-bearing entities (new persistence tables, new HTTP routes, new wire formats, new event kinds, new error envelopes), check the conventions in place for similar entities and match them in the spec — column naming, route plurality, payload shapes, prefix discipline. Downstream readers assume convention; surprise mismatches end up baked into the plan and the code.
- Where existing code has problems that affect the work, include targeted improvements
- Don't propose unrelated refactoring

## Capturing design changes in the spec

If the work touches the design docs, the spec must say so
explicitly under a `## Design changes` section. Brainstorm does
**not** mutate `.ok-planner/design/` directly — the design docs
are a source of truth with the same weight as code, and like
code they change only through plan execution. Capturing changes
in the spec lets `write-plan` turn them into first-class plan
tasks and `execute-plan` apply them alongside the code.

If `.ok-planner/design/concepts/` does not exist, skip this
section entirely — the project has not bootstrapped design docs
and this brainstorm is not the place to do it. Do not mention
the absence; do not suggest `/discover-design` unless the user
asks.

While presenting the design (step 6), identify four kinds of
impact:

**Concept impacts** — the spec sharpens, splits, merges,
introduces, or retires a concept. Candidate if ANY of these:
- It introduces a new load-bearing noun the project did not have.
- It changes the boundary of an existing concept (what's in vs.
  what's now in a neighbor).
- It retires a concept, or retires an alias that should no longer
  be used.
- It mutates Definition / Purpose / Boundaries / Invariants of
  an existing concept.

**Story impacts** — the spec creates, mutates, or retires a
durable user-outcome story in `design/stories/`. Candidate if ANY
of these:
- It introduces a new user-outcome the project did not have (every
  story in the spec's User outcomes section is a new story landing
  in `design/stories/` once execute-plan finishes).
- It mutates the Acceptance, Falsifier, or Proof of an existing
  story (the story's contract has changed).
- It retires a story (a capability the project no longer offers).

**Decision impacts** — the spec creates, mutates, or retires a
durable technical decision in `design/decisions/`. Candidate if
ANY of these:
- It introduces a new technical decision (every TD in the spec's
  Technical decisions section is a new decision landing in
  `design/decisions/` once execute-plan finishes).
- It mutates the Choice, Rationale, or Alternatives of an existing
  decision (the project has reconsidered).
- It retires a decision (the choice is no longer relevant —
  typically because a concept around it was retired).

**Tension impacts** — the spec touches the tensions catalog.
Candidate if ANY of these:
- It resolves an open tension (record which one and how).
- It surfaces a new tension the project should catalog — but only
  if the tension is *adjacent* to this spec, not load-bearing for
  it. A tension load-bearing for the current work must be resolved
  via `/refine-design` before brainstorm proceeds; the spec
  cannot itself depend on an unresolved choice (per "No
  forward-looking content" above).

A candidate does NOT belong if it's a purely local implementation
detail. The bar: would a reviewer benefit from knowing this when
forming findings?

Walk each candidate with the user — confirm-as-is / edit /
reject. For accepted candidates, write a `## Design changes`
section in the spec with one bullet per change, each precise
enough that execute-plan can apply it mechanically. Example:

```
## Design changes

- Concept: mutate `concepts/store.md` in place. Replace the
  Boundaries section with: ... (full new text, describing the
  new boundary as it stands — no "was X" or "changed from Y").
- Concept: create `concepts/claim-producer.md` from the template
  in `skills/_shared/artifact-definitions.md`, with Definition: ...,
  Purpose: ..., Boundaries: ..., Invariants: ....
- Story: create `stories/claim-co-holder.md` capturing this spec's
  STORY-claim-co-holder verbatim — role, capability, business
  value, Acceptance, Falsifier, Proof.
- Story: mutate `stories/stale-claim-recovery.md` in place. Replace
  the Acceptance section with: ... (full new text).
- Decision: create `decisions/persistence.md` from the template
  in `skills/_shared/artifact-definitions.md`, capturing this
  spec's TD-persistence: Choice: Postgres with `pgx`. Rationale:
  ... Alternatives considered: ...
- Decision: mutate `decisions/claim-recovery-cadence.md` in place.
  Replace the Choice section with `30s tick interval` (state it
  as the current choice — no parenthetical "(was 60s)" or
  reference to the prior cadence).
- Tension: resolve `tensions/store-vs-claim-producer.md`. Move
  the file to `tensions/_resolved/store-vs-claim-producer.md`
  with `status: resolved` and a `resolution:` block summarizing
  the outcome (the resolution shape is: ...).
- Tension: create `tensions/cache-invalidation.md` from the
  template in `skills/_shared/artifact-definitions.md`, with
  status: open and the muddiness described as: ....
```

Each bullet rewrites the affected section to reflect the new
state. Do **not** add a `## Notes`, `## History`, or dated
audit-trail entry to any artifact — the design docs are
current-state only (see the "Current-state-only rule" in
`skills/_shared/artifact-definitions.md`). The git commit
carries the lineage. Do not write "previously called X",
"used to be Y", "changed per spec Z", or similar
backward-looking language into the artifact body.

If the spec produced no design-doc impacts (small specs often
won't), don't add a `## Design changes` section.

**Self-containment in spec-driven mutations.** When a
`## Design changes` bullet creates or mutates the body of a
concept, story, or decision — new or rewritten Definition /
Purpose / Boundaries / Invariants (concepts), Acceptance /
Falsifier / Proof (stories), Choice / Rationale / Alternatives
(decisions) — the new body must follow the self-containment rule
from `skills/_shared/artifact-definitions.md`. TL;DR: the body has
no file paths, no `code:`/`pkg:` citations, no external-doc
references (`docs/...`, READMEs, sibling-repo paths), no quoted
code or lint-config allowlists, no "Owns / Does NOT own" sections
that name code paths. Allowed citations are other artifact slugs
(concept / story / decision) and annotation IDs.

State the new section text directly in the bullet; do not phrase
the mutation as "see `foo.go`" or "matches `docs/...`" or "the
canonical impl lives at `pkg:...`". If a story's Acceptance or
a decision's Rationale can't be stated path-free, the artifact
isn't ready to land in the durable model — sharpen it before
writing the spec.

The same rule applies to tension files the spec creates or
modifies: `## Resolution candidates` sections in tensions are
path-free; `## What is muddy` and `## Evidence` can cite code
as evidence. See the "Tension surface rule" in
`skills/_shared/artifact-definitions.md`.

## Proof implications

After the spec is drafted but before the reviewer runs, scan
the spec for changes that affect existing stories' proof
exhibition. Capture the user's verdict in a `## Proof changes`
section.

**What triggers the scan.** Proof implications arise when the
spec's content itself implies a story-intent change. The signals
are visible in what the spec is doing, not in a diff (which
doesn't exist yet):

- The spec mutates an existing story (a `## Design changes`
  entry on the story's Acceptance, Falsifier, or Proof field).
- The spec proposes a TD that retires, replaces, or materially
  changes a delivery surface that an existing story's `Proof:`
  field references. (Example: a TD switches the CLI verb the
  product exposes; any story whose proof drives the product
  through that verb will need its proof artifact updated.)
- The spec deprecates a story entirely.

If none of these signals are present, the spec has no proof
implications and the `## Proof changes` section is omitted
entirely. Most specs will not need one.

**Finding affected stories.** For each in-flight story
mutation, identify the story slug from the `## Design changes`
entry. For each TD that changes a delivery surface, grep the
codebase for `@story:<slug>` annotations and read the matching
`stories/<slug>.md` files to see whose `Proof:` field
references the affected surface. Collect the affected story
slugs.

**Dialogue with the user, per affected story.** For each
affected story, surface to the user:

> "This spec affects the proof exhibition of STORY-«slug».
> The story's current Proof field says: «text from
> stories/«slug».md».
>
> Three options:
> A. **Preserve the intent** — the spec's mechanism changes,
>    but the proof artifact will be updated to keep satisfying
>    the same Proof field. No story mutation; the proof file
>    just gets refactored.
> B. **Shift the intent** — the spec is changing what this
>    story exhibits. The story's Proof field (and possibly
>    Acceptance/Falsifier) will be rewritten. We'll draft the
>    new wording together and add a `## Design changes` entry
>    mutating the story.
> C. **Remove the story** — the story is being retired. Its
>    proof artifact(s) go away with it. This requires you to
>    confirm; the agent does not propose removal."

Three options, not two. The user picks per story. The agent
never picks; defaults are not applied.

**Recording the verdict in `## Proof changes`.** For each
affected story, write one bullet:

```
## Proof changes

- **STORY-claim-co-holder** — A. Preserve the intent. The
  proof artifact at `examples/claim-flow/co-holder.go` will
  be updated to use the new CLI verb introduced by
  TD-cli-grammar-revision; the story's Proof field is
  unchanged.
- **STORY-stale-claim-recovery** — B. Shift the intent. The
  story's Proof field is being rewritten under
  `## Design changes` to exhibit the new event-driven
  recovery path; the previous tick-based proof exhibition no
  longer applies. The proof artifact at
  `test/scenarios/stale_recovery_test.go` will be rewritten
  to drive the new mechanism.
- **STORY-bulk-export** — C. Remove the story. The user
  confirmed this story is being retired; see
  `## Design changes` for the story removal. The proof
  artifact at `examples/bulk_export.go` will be deleted in
  the same plan.
```

A spec with no proof implications omits this section. A spec
with implications must enumerate every affected story; the
reviewer rejects unenumerated proof-touching changes.

**What is NOT a proof implication.** Routine refactors,
internal-API renames, library swaps, test-harness changes,
and any other modification that touches a `@story:<slug>`-
annotated file without changing what the file exhibits to a
third party are NOT proof implications. They are ordinary
code changes that happen to touch protected files. The cycle
1 code review catches genuine surprises (e.g., a refactor that
quietly stubs the value-delivering component); brainstorm
does not gate every touch. The discipline keys on the story's
`Proof:` field, not on whether bytes in a proof file changed.

See `{{PROOF-PROTECTION-RULE}}` in
`skills/_shared/artifact-definitions.md` for the full
canonical text.

## Writing the spec and reviewing it

**Before writing the spec, ground its citations against the actual source.** For every code surface the spec is going to name — files, functions, structs, tables, columns, proto messages, line numbers — read the underlying file first and copy the names verbatim. Do not write a citation from inference or from conversation context. Hallucinated citations cluster: a single wrong file path or function name in the first draft tends to spawn a wrong path or name in each round of fixes (cluster bias on the fix side, mirroring the reviewer's). Specs that touch many code surfaces and rely on guessed citations need many review rounds to converge; specs that ground every citation up-front converge in one or two. The cost of the up-front grounding pass is much smaller than the cost of the fix-review loop it prevents.

Write the spec to `.ok-planner/specs/YYYY-MM-DD-<topic>-design.md` (user preferences override this path). Dispatch a spec reviewer subagent:

```
Agent (general-purpose):
  Read the spec at [path].

  ## Ground every claim in source code

  Before checking the spec internally, verify it against the codebase.
  Hallucinated current-state is the most expensive failure
  downstream — a spec that confidently references things that do
  not exist sends an implementer chasing ghosts. Catch it here.

  - Read every file path the spec names. If a path does not exist
    and the spec does not mark it as new, flag it with the path.
  - For every function, class, module, type, table, endpoint, or
    other named entity the spec references as existing, find it
    (`rg`, `grep`, or direct read). If it does not exist, or its
    actual shape differs materially from what the spec assumes,
    flag it with file:line.
  - For every "currently X" / "today the code does Y" /
    "the existing Z" assertion, verify against the actual code.
    Flag any that do not match, citing the file and what is
    actually there.
  - For every NEW shape-bearing entity the spec introduces (new
    persistence table, new HTTP route surface, new wire format,
    new event kind, new error envelope), find its closest cousin
    in the codebase and check that the spec's proposed shape
    matches the prevailing convention — column naming, route
    plurality, payload structure, prefix discipline. The planner
    downstream will codify the proposed shape as written; a spec
    that names a new table inconsistently with its siblings, or
    proposes a route shape that contradicts the rest of the API,
    sends the cluster downstream into the plan and the code. If
    the deviation is intentional and the spec justifies it, fine;
    if the spec is silent, flag the mismatch.

  If you find one such issue, keep looking — they cluster.
  Exhaustively check every file path and every named entity; do
  not sample.

  ## Check against the design docs (if present)

  If `.ok-planner/design/` exists, consult it. Brainstorm is where
  specs are written against the durable model, so this review is
  the natural place to catch mismatches before the spec is
  approved. Downstream skills do not re-check the spec against
  the design docs.

  1. Read `.ok-planner/design/concepts.md` (the TOC).
  2. For concepts the spec touches by name or by area, read
     `concepts/<slug>.md` in full.
  3. For stories the spec touches (creates, mutates, or relies on
     as already-shipped behavior), read `stories/<slug>.md` in
     full.
  4. For decisions the spec touches (creates, mutates, or relies
     on as already-made), read `decisions/<slug>.md` in full.
  5. Check `.ok-planner/design/tensions/` for open tensions in
     the same area.

  Flag:
  - The spec uses a load-bearing noun differently than its concept
    file defines it (or aliases over a documented term without
    saying so).
  - The spec proposes work that would violate a stated invariant
    or cross a stated boundary, without addressing the change in
    a `## Design changes` section.
  - The spec contradicts an existing story's Acceptance or Proof
    without a `## Design changes` entry that mutates the story.
  - The spec contradicts an existing decision's Choice without a
    `## Design changes` entry that mutates the decision.
  - The spec resolves or contradicts an open tension without a
    `## Design changes` entry that records the resolution and
    moves the tension file appropriately.
  - The spec introduces a new load-bearing noun without a
    `## Design changes` entry creating the concept file.
  - The spec's User outcomes contain a story but `## Design
    changes` has no entry creating the corresponding
    `stories/<slug>.md` (every new story in the spec is a new
    durable story landing in `design/stories/`).
  - The spec's Technical decisions contain a TD but `## Design
    changes` has no entry creating the corresponding
    `decisions/<slug>.md` (every new TD in the spec is a new
    durable decision landing in `design/decisions/`).
  - A `## Design changes` section exists but is incomplete (e.g.,
    references a mutation without saying which file or what
    changes) — execute-plan needs precise instructions.
  - A `## Design changes` bullet mutates concept, story, or
    decision body text but the new text violates the
    self-containment rule (see `ok-planner:discover-design`'s
    SKILL.md): cites a file path, names an external doc, quotes
    code or a lint-config allowlist, or introduces an "Owns /
    Does NOT own" section that cites paths. Flag the offending
    bullet and the offending citation; the fix is to rewrite the
    new body as path-free prose.
  - A `## Design changes` bullet violates the current-state-only
    rule (see `skills/_shared/artifact-definitions.md`). Flag any
    of: directs adding a `## Notes` / `## History` / `## Changelog`
    section; directs appending a dated audit-trail entry
    (`YYYY-MM-DD — <what changed>`, "Append a Notes entry: ...",
    "add a Notes line citing spec X"); writes backward-looking
    phrasing into the artifact body ("previously called X",
    "used to be Y", "(was 60s)", "changed per spec Z"); writes
    forward-looking phrasing ("TODO", "we plan to", "will be
    replaced", "deferred to V2", "open question for later"). The
    fix is to rewrite the bullet so the new body section describes
    the artifact as it now stands; git carries the lineage.
  - A `## Design changes` bullet creates or modifies a tension
    whose `## Resolution candidates` section cites a file path,
    symbol, or external doc. Resolutions become spec instructions
    and live forward in time — they must be path-free (see the
    "Tension surface rule"). Code-citation evidence is fine in
    `## What is muddy` / `## Evidence`, not in `## Resolution
    candidates`.

  If `.ok-planner/design/` does not exist, skip this section.

  ## Spec quality checks

  After grounding, check the spec for:
  - Completeness (TODOs, placeholders, incomplete sections)
  - Internal consistency (contradictions, conflicting requirements)
  - Clarity (ambiguity that could cause wrong implementation)
  - **No forward-looking content.** Flag ANY of: "out of scope,"
    "non-goals," "future work," "V2," "later," "deferred,"
    "deliberately not addressing," "open questions," "to be
    determined," "TBD," "we'll decide later," "leaving this open."
    None of these describe work that will happen, so none of them
    are valid spec content. Scope is bounded by omission — by
    which stories and decisions the spec contains — never by
    forward-looking language. (The "delivery process is out of
    scope — no PRs/commits/branches" exclusion is the only
    permitted scope-bounding statement; it bounds process, not
    a feature or a decision.)
  - User outcomes (the spec's originating contract). If the spec
    introduces user-observable behavior, it must OPEN with a
    complete, enumerated set of user-outcome stories — one per
    distinct user-observable outcome it promises — each with an
    acceptance stated at the user-outcome level: a user action
    described in user terms producing a real observable outcome,
    with the value-delivering component (executor, worker, sensor,
    subscriber, …) real — not a stub. The delivery surface is a
    technical decision (a `TD-` entry), never part of a story.
    Check all of:
    - **Completeness.** Every user-observable capability the spec
      describes (in any section, including any mechanism it details)
      has a corresponding story. A capability the mechanism delivers
      but no story names is the exact hole that ships unbuilt — flag
      it.
    - **Durable user expectation, not a dev task.** Each story
      describes what the product owes its users on an ongoing basis,
      not a one-time change or implementation event. Apply the test
      from `skills/_shared/artifact-definitions.md`: would a
      regression of this capability be a defect a reasonable user
      would notice and complain about, years from now? If no, it's
      not a story — flag stories shaped as "added support for X,"
      "migrated from A to B," "introduced a new field on Y,"
      "renamed the foo endpoint." Those are TDs, refactors, or
      implementation events, not stories.
    - **User-outcome level, non-prescriptive.** Reject acceptance
      phrased in implementation terms — "the handler is registered,"
      "the class is declared," "returns 200," "calls helper X,"
      "asserts the struct shape." Also reject acceptance that pins a
      specific **delivery surface** — names a particular HTTP route,
      CLI verb, wire format, job schedule, or UI element — instead
      of the user-observable action. Surface choices are technical
      decisions and belong in `TD-` entries; the story names the
      capability and the observable outcome in the user's terms. And
      reject any story that stubs the very component it exists to
      exercise.
    - **Falsifier present, concrete, user-observable.** Every story
      has a Falsifier line stating what observation would prove the
      story not delivered. Reject Falsifiers that mirror the
      acceptance verbatim in the negative ("the effect does not
      appear"), restate the story's goal vaguely ("the feature
      doesn't work"), or are too abstract to point at in code. A
      good Falsifier names a specific **user-observable absence** a
      reviewer could point at — the user takes the action and the
      promised result never appears, the result appears but is
      unrelated to their input, or the result looks real but the
      value-delivering component is stubbed or canned so the
      underlying state is synthetic.
    - **Proof form named and concrete.** Every story has a Proof
      line naming the form (demo / example / proof / all-of-the-above)
      and what the proof must exhibit to a third party. Reject Proofs
      that don't name a form, name a form without saying what it
      exhibits, or describe a form that could not actually convince
      a third party — a "demo" that just calls the handler in process,
      an "example" that asserts a struct shape, a "proof" whose
      value-delivering component is canned. The proof's job is
      *exhibition*, not internal assertion; it must show the feature
      working end-to-end through whatever delivery surface the spec's
      TDs prescribe.
    A pure refactor / docs-only / no-user-surface spec correctly has
    no stories — do not flag their absence there.
  - **Technical decisions (atomic, enumerable).** If the spec
    contains mechanism content (architecture, components, data
    flow, behavior), it must include a `## Technical decisions`
    section enumerating each decision as `TD-«slug»` with Choice
    and Rationale (and Alternatives when the spec wants to record
    them). Check all of:
    - **Atomic.** One decision per item. Lumped items like "use
      X for persistence, Y for messaging, and Z for caching" are
      not atomic — flag and request splitting.
    - **Choice stated explicitly.** Every TD names the option the
      spec adopts. A TD that just describes a tradeoff without
      naming the chosen side is incomplete. The Choice section MAY
      name the specific artifact picked (library, protocol, format,
      value) — the artifact identity is what carries the tradeoff
      and is the honest form.
    - **Real tradeoff with non-trivial alternatives.** Each TD
      represents a choice where a plausible different choice
      existed. If there was no real alternative (the choice is a
      default with no contender), it isn't a decision — drop it or
      reshape it. The Alternatives field, when present, should name
      genuinely-considered options, not strawmen.
    - **Rationale present.** Every TD has at least a one-line
      reason. "Because we said so" is not a rationale. The
      rationale states the tradeoff, not just the choice.
    - **TDs are not specs or designs.** A TD records the choice and
      the reasoning; it does not enumerate implementation steps,
      file structure, schema details, or call sequences. Flag a TD
      that has slid into spec or design content — that material
      belongs in the spec's mechanism prose or in the code, not in
      the TD itself.
    - **No deferred decisions.** A TD whose Choice is "to be
      determined," "we'll decide later," or names multiple options
      without picking one is forward-looking content — flag it.
      If the user has not decided, the choice is a tension that
      should be resolved via `/refine-design` first.
    A docs-only spec with no mechanism content correctly has no
    technical decisions — do not flag their absence there.
  - **Spec manifest present and complete.** The spec ends with a
    `## Manifest` section enumerating every story (slug + Proof
    form) and every technical decision (slug). The manifest is
    the contract the closing audit walks. Flag if:
    - The manifest is missing.
    - The manifest's Stories subsection does not match the stories
      in the User outcomes section (count mismatch, slug mismatch,
      missing Proof form annotation).
    - The manifest's Technical decisions subsection does not match
      the TDs in the Technical decisions section.
    - The manifest mentions an item the spec body does not define,
      or the spec body defines an item missing from the manifest.
    A spec with no stories and no decisions (rare — e.g., a pure
    cleanup spec with only design-doc mutations) may have an
    empty manifest or none; don't flag absence in that case.
  - **Proof changes section** (if proof implications exist). If
    the spec mutates an existing story, retires a story, or
    proposes a TD that changes a delivery surface referenced by
    an existing story's `Proof:` field, the spec must include a
    `## Proof changes` section. The section enumerates every
    affected story with one of three verdicts: **A. Preserve the
    intent** (proof artifact updated, no story Proof-field
    mutation), **B. Shift the intent** (story's Proof field
    rewritten under `## Design changes`), or **C. Remove the
    story** (explicit user-directed removal, recorded under
    `## Design changes`). Flag if:
    - The spec has a `## Design changes` entry mutating a
      story but no corresponding `## Proof changes` entry for
      that story.
    - The spec proposes a TD that changes a delivery surface
      referenced by an existing story's `Proof:` field, but
      `## Proof changes` does not address the affected stories.
    - A `## Proof changes` entry chose verdict B (shift the
      intent) but `## Design changes` has no story Proof-field
      mutation for that story.
    - A `## Proof changes` entry chose verdict C (remove) but
      `## Design changes` has no story removal entry for that
      story.
    - A `## Proof changes` entry exists without a clear verdict
      (A / B / C). Reject vague phrasing like "the proof will
      need updating" without naming which of the three options.
    A spec with no proof implications correctly omits the
    section; do not flag its absence in that case. (Specs that
    only add new stories — no mutations, no retirements, no
    delivery-surface changes affecting existing stories — have
    no proof implications.)

  Flag any PR, commit, branch, deployment, release, or rollout
  instructions — specs cover what to build, not how to ship it.
  Flag any indication that the work has been split across multiple
  specs.

  Report: Approved | Issues Found (with specifics)
```

Fix issues, re-review until clean. Each re-review runs the full grounding pass — do not assume the previous round was exhaustive. Cluster bias means missed grounding issues hide behind the ones the previous reviewer found. Then ask user to review the written spec.

## Source sketches

A brainstorm is often initiated from an existing sketch under
`.ok-planner/sketches/` — the user points at one and says "design
this," or one surfaces during context exploration (step 3) and the
user adopts it as the thing to brainstorm. There can be more than
one. Those are the brainstorm's **source sketches**: the spec it
produces supersedes them.

A sketch read only as adjacent background — context the brainstorm
does not consume — is **not** a source sketch and stays where it
is. The test: a sketch is a source sketch only if this brainstorm
dispositions its content (below). When it's unclear whether a
sketch the user mentioned is a source or just background, ask.

There is no other mechanism that moves sketches out of
`.ok-planner/sketches/`. Brainstorm is where a sketch is consumed
into a spec, so brainstorm is where its source sketches are
archived.

### Dispositioning sketch content

By the time the spec is approved, every piece of a source sketch
has landed in exactly one of three places:

- **In scope** — captured in the spec. The normal case.
- **Declined or reframed** — dropped. The user decided not to do
  it, or the brainstorm folded it into something else already in
  the spec. Nothing carries forward.
- **Deferred** — the user explicitly chose to do it later: not
  declined, not reframed, *deferred*. Deferred work must not
  vanish when the source sketch is archived, so it is captured in
  a new sketch (below).

Defer-vs-decline is the user's call, made during the dialogue — do
not unilaterally defer. When sketch content falls out of the
brainstorm's scope, surface it and let the user say decline /
reframe / defer.

### Archiving (after the spec is approved)

Once the user has approved the spec (step 9), before transitioning
to write-plan:

1. **Capture deferred work.** If any source-sketch content was
   deferred, write a new sketch to
   `.ok-planner/sketches/YYYY-MM-DD-<topic>-sketch.md` capturing
   the remaining work, using the sketch template from
   `ok-planner:sketch`'s SKILL.md. Give it a topic slug that
   reflects the deferred work, not the original sketch. (Split
   into more than one sketch only if the deferred work spans
   clearly separate topics.)
2. **Archive the originals.** Move each source sketch to
   `.ok-planner/history/sketches/`, preserving the filename
   (`git mv` if tracked, else `mv`).
3. **Report** what was archived and the path of any deferred-work
   sketch you wrote.

Do not ask permission to archive: it is non-destructive (the
sketch stays readable under `history/`) and is the documented
completion behavior, the same way `execute-plan` archives a plan
when it finishes. Just do it and report.

## Transition

Once the spec is approved, invoke ok-planner:write-plan.
