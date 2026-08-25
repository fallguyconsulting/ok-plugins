# ok-planner — planning ceremony contribution

What the suite's planning ceremony does about this family's estate. The ceremony owns the spine and the order; this file owns everything ok-planner contributes to it. Materialized into consumer projects at `.ok-planner/ceremony/plan-sprint.md`; the ceremony reads it there when `.ok-planner/` exists.

## Requires

`.ok-planner/` at the project root. This family owns the ceremony's terminal artifact — the **sprint** — so a project without this estate has nowhere to write one: say so and stop.

`.ok-planner/design/` must exist before a sprint can carry corpus deltas. If it does not, say so and point at `/discover-design`; the session may still proceed to work items alone.

## Vocabulary

Read `.claude/skills/_shared/artifact-definitions.md` before authoring anything. Every delta drafted here must already comply with the artifact rules — the sign-off review checks exactly that. `{{CORPUS-DELTA-FORM}}` there is the authority on a delta's parts; this contribution never restates it.

Two things must not blur: the **intake** (`.ok-planner/issues/`, one markdown file per issue) holds questions; the **sprint** holds what the session commits to. Issues move from the first to the second by promotion, one-way.

## Layout

`mkdir -p .ok-planner/sprints .ok-planner/issues .ok-planner/history/sprints .ok-planner/history/issues`; estate convergence is the front door's administration (`/ok`), never a ceremony's. If a legacy `.ok-planner/issues.jsonl` is present, invoke `verify-issues` before framing anything: it converts the log and verifies whatever is unverified.

## Frame

Read the intake: every file under `.ok-planner/issues/` with `status: open` or `status: verified` is an open issue (`promoted` and `retired` files are closed, whatever directory they sit in). Split the open set by the `## Ruling` section: **ruled** (non-empty Ruling text) and **unruled**. Do not present the unruled ones yet.

**Pull in the ruled issues first.** A ruling is the owner's decision, already made; this session does not re-open it. For each ruled issue, carry the ruling's substance into the draft in final form — corpus delta, work item, or both — exactly as if the owner had just decided it live. Discuss a ruled issue with the owner only when the ruling genuinely cannot be understood; then ask about that one ruling, in prose, and transcribe the clarification. A ruling that amounts to "drop it" is a retirement: record the reason under Ruling, set `status: retired`, and move the file to `history/issues/` now.

**Generated and recommended rulings ride in the same sweep, named once.** A `> Generated ruling (/verify-issues): …` was written because the rules determine the resolution; a `> Recommended ruling (…): …` (attributed to `/verify-issues`, or to the retired `/recommend-rulings` in older files) is the verifier's judgment call the owner accepted by silence. Carry both like any ruling, and at sign-off name each batch in one line ("3 pulled rulings are generated: <slugs>; 5 are accepted recommendations: <slugs> — say the word to drop any") so nothing unread by the owner is silently absorbed. Never re-discuss them individually unless the owner asks.

Then establish the session kind from the owner's opening ask; if unclear, ask in one prose question:

- **Intake-drain sprint** — the owner's purpose is working the intake: all of it, or a batch they name. Run the issue walk (under **Resolve**) over that scope now, then the dialogue (thin — the resolutions largely are the intake) and the draft.
- **Feature-work sprint** — the default. The owner brings work. The intake is not the agenda beyond the ruled sweep: go to the dialogue and the draft, then consult the unruled issues at **Resolve** against the drafted work.

Tell the owner the counts either way ("3 ruled issues pulled into this sprint; 7 unruled open — I'll check which bear on this work once we've drafted it"). The count is information, not a gate; the owner may widen scope to the whole intake.

## Reconcile

Work sometimes lands outside any sprint — a hotfix, an experiment that stuck, a redesign in a session that never ran the ceremony. The corpus catches up with such work here, before anything is drafted on top of it: this ceremony is the one place the corpus legally moves. (Certification cannot do it — its fixers hold the corpus fixed and would bend new code back toward stale docs.)

1. **Resolve the baseline.** Every sprint a certify gate closed carries `closed: <sha>` in its frontmatter, stamped at archival. The baseline is the `closed:` stamp of the newest file under `.ok-planner/history/sprints/` that has one. If none has one, say so and ask the owner, once, in prose, whether to name a baseline ref or skip the walk; never guess one.

2. **Compute the window.** `git log --oneline <closed>..HEAD` plus the uncommitted tree. Empty window → the phase passes silently.

3. **Filter for bearing changes.** Most of the window is ambient change touching no corpus commitment — "changed since baseline" is a window, not an accusation. Dispatch the out-of-band reviewer below; walk only what it returns as BEARING.

4. **Walk the bearing set with the owner, one change at a time**, before the dialogue builds on it. Per change the owner picks one of three outcomes, and the pick lands in this sprint:
   - **Corpus catches up** — the out-of-band work is intended reality; draft the deltas that bring the affected artifacts into agreement with it. The approved delta is the work's missing authorization, granted retroactively.
   - **Code catches up** — the corpus's commitment stands; add a work item restoring it.
   - **Record and defer** — the owner wants to think; file an issue per `{{ISSUE-FILE-FORMAT}}` (kind `human`, the divergence as the Problem). The sprint must not otherwise touch the artifacts that divergence bears on.

An empty window or an all-ambient review passes in one line ("no out-of-band work since <sprint>").

### Out-of-band reviewer

```
Agent (general-purpose, model: sonnet):
  ## Out-of-band change review

  {{LEAF-AGENT-RULE}}

  {{READ-ONLY-REVIEWER-RULE}}

  ### Your job

  Decide which changes in a git window bear on the design corpus's
  commitments. You are not judging whether the changes are good and
  not proposing resolutions — the owner does that. Decide, per
  change, whether the corpus and the code still tell the same
  story.

  ### Inputs

  Window: [<closed-sha>..HEAD, plus the uncommitted tree]
  Enumerate it yourself: `git log --oneline <window>`,
  `git diff <closed-sha>`, and `git status --short` for anything
  uncommitted. Read changed files in full where the diff alone is
  ambiguous.

  The design corpus at `.ok-planner/design/` is the comparison
  pole: read the three catalog TOCs first, then the full body of
  every artifact a change plausibly touches.

  ### The test

  A change (or a coherent group — group by mechanism, not by
  commit) is BEARING if any of these hold:

  - It contradicts something a live artifact commits to — a
    boundary, a Choice, a promised outcome.
  - It retires, replaces, or bypasses a mechanism a live artifact
    names as how a commitment is delivered.
  - It adds capability or structure significant enough that the
    corpus is silent about something load-bearing.
  - It edits a file under `.ok-planner/design/` directly — a
    corpus mutation outside any sprint is always BEARING.

  A change is AMBIENT if every live artifact reads the same with
  or without it. When you cannot tell, answer BEARING.

  ### Output format

  Status line first: `Status: N bearing | ambient remainder`.

  Then one entry per bearing group: the commits/files involved,
  one sentence on what changed, and the artifact slugs it bears
  on with one sentence each on the collision.

  ### Anti-padding

  - Do not grade, rank, or recommend resolutions.
  - Do not list ambient changes.
  - Do not audit the corpus itself — only the window against it.
```

## Dialogue

Discuss what this sprint takes on. The owner brings goals; you bring the corpus (read `design/` freely — it is source of truth). Ask questions in prose. Surface every tradeoff explicitly; never resolve one silently on the owner's behalf. When work implies a story- or decision-intent change, put the three options to the owner — preserve the intent, shift the intent, remove the artifact — and the owner picks. Draft stories concretely: a capability a reader can settle by looking, a benefit stated as something observable. Reaching for correct, clear, or helpful means the need is not yet named — say what the user can now do instead, per `{{STORY-DEFINITION}}`; where a promise rests on a human discipline's judgment, `{{DECIDABILITY-BOUNDARY}}` makes it a referral in the story's audit.

## Draft

Write to `.ok-planner/sprints/YYYY-MM-DD-<slug>.md`, using the sprint document template in `.claude/skills/_shared/sprint-document.md`.

The corpus deltas are the substantive body, each authored per `{{CORPUS-DELTA-FORM}}`: a complete final-form body, resolved in this session's dialogue — edit the artifact surgically with the owner and carry the whole result. A retirement carries only its heading. Where bodies run long, put them in the sidecar folder beside the sprint (`<sprint-name>-deltas/<kind>s/<slug>.md`) and point each heading there. Applying a delta IS updating the corpus.

**The sprint is self-sufficient.** Once written, it is the source of truth for execution. An executing agent never reads an issue file to learn what a promoted issue meant: a resolution whose substance is not in the deltas or work items is not in the sprint. Write accordingly.

### The predictive classification test

Where `.ok-planner/surface/surface.md` exists, drafting includes one predictive check: for work introducing new user-facing surface — a new command, route, exported module, env var — read the surface intent and ask whether it already classifies the new surface, by rule or exception. Claimed passes silently. Unclaimed is one prose question to the owner — public or internal, and under what rule — and on the answer the drafter adds a work item to edit the intent as part of the sprint's deltas. The sprint's execution edits the intent; this session never edits it mid-run; the audit's next run reads the amended intent. Stories carry the public-by-construction prior — a story's capability is something a user reaches, so its surface is public unless the owner says otherwise — so only genuine ambiguity reaches the owner. Planning takes the classification early, while the owner is already deciding the work, so the audit's extractor finds the intent settled.

## Resolve

This session is the only place issues close: **promoted** into this sprint, or **retired** at the owner's word. The ruled ones were pulled in at **Frame**; this phase is the **unruled** remainder.

Unruled open issues matter to this sprint for one reason: **building over an open issue decides it silently.** An issue whose answer the drafted work would encode by default must be resolved by the owner first. An issue the work neither touches nor presumes stays in the intake, and an issue the owner already ruled never re-enters discussion.

The walk is scoped:

- **Intake-drain sprint** — every unruled open issue (or the named batch). No relevance pass; go straight to the walk.
- **Feature-work sprint** — run the relevance pass below over the draft and the unruled open issues, then walk only the issues it returns as bearing. This raises exactly what a full walk would have raised.

### Relevance pass (feature-work sprints)

Dispatch a dedicated reviewer. It decides bearing-vs-independent; it resolves nothing.

```
Agent (general-purpose, model: sonnet):
  ## Issue relevance pass

  {{LEAF-AGENT-RULE}}

  {{READ-ONLY-REVIEWER-RULE}}

  ### Your job

  Decide which open design issues bear on a drafted sprint's work.
  You are not resolving them and not proposing resolutions — the
  owner does that. Decide, per issue, whether the owner must
  resolve it BEFORE this work is built.

  ### Inputs

  Draft sprint: [path]
  Unruled open issues (files under `.ok-planner/issues/` with
  status open or verified and an empty Ruling section):
  [one line per issue: the file path, then its frontmatter slug
  and the title line]

  Read each listed issue file in full — the Problem, Candidates,
  and any Discussion are your evidence for bearing.

  The design corpus at `.ok-planner/design/` is source of truth —
  read it freely. Read the code where an issue's bearing depends
  on what the code does.

  ### The test

  An issue BEARS on this sprint if any of these hold:

  - It concerns an artifact the sprint creates, amends, or
    retires.
  - Building a work item would encode an answer to the open
    question by default — the implementer would have to pick, and
    the pick would stand as the project's answer. (The central
    case.)
  - A plausible resolution of the issue would contradict,
    invalidate, or materially reshape a drafted delta or work
    item.
  - It concerns a neighbor artifact whose boundary a work item
    leans on — the work is only correct if the boundary falls one
    way.

  An issue is INDEPENDENT if the drafted work can be built and
  certified without answering it, AND answering it later cannot
  invalidate anything the sprint commits to.

  When you cannot tell, answer BEARS. A needless owner
  conversation costs a minute; a silently decided design question
  costs a rewrite.

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

### The issue walk

**Before presenting each issue, surface the corpus that bears on it** — an issue can be silently decided against a boundary, a Choice, or a story's statement the walker never consulted. Run the surfacer on the issue file:

```bash
OK_PLANNER_PROJECT_ROOT="$(pwd)" \
  python3 .ok-planner/scripts/surface-corpus .ok-planner/issues/<file>.md
```

The script prints, one per line, the concept / story / decision files that are cited in the issue's frontmatter `artifacts:` list or match distinctive rare tokens from its slug and body. Read each surfaced artifact in full — its Boundaries, a Choice, or a story's statement may already resolve the question, retire the issue, or reshape the framing. If the script prints nothing, that is a signal: the issue is either about pure code with no corpus commitment or about a concept the file failed to name — flag it to the owner rather than proceeding blind.

Then walk the in-scope issues with the owner **one at a time**, never as a wall: present the issue's title, Problem, and Candidates — leaning on its verifier-written narrative, built for exactly this moment — plus a one-sentence note on what the surfaced corpus says (`concept:X draws its boundary so the answer is Y — likely a retire`). The owner picks one of two outcomes.

**Promote** — the owner decides the answer (a candidate, or a shape of their own). Transcribe the decision verbatim into the file's `## Ruling` (the owner's ruling, given live), and carry the substance into the sprint now, in final form: corpus delta, work item, or both. On a feature-work sprint that means amending the draft, including where the resolution collides with a delta already drafted; on an intake-drain sprint these resolutions are the material the draft is built from. The sprint carries the whole resolution; the issue file is a receipt, not a companion document.

**Retire** — the owner drops the question ("won't fix", "not real anymore", "already answered"). Record it immediately: the reason under `## Ruling`, `status: retired`, and move the file to `.ok-planner/history/issues/`.

All file mutations follow `{{ISSUE-FILE-FORMAT}}`. Only this session writes `promoted` and `retired` stamps.

**Timing: retirements happen during the walk; `promoted` stamps go in at the terminal phase, after sign-off.** A promotion is a handoff to a sprint, so it is true only once that sprint exists in approved final form; stamping mid-walk would empty the intake into a document the owner might still reject. A retirement is unconditional and recorded on the spot. If the session dies before sign-off, the promoted-in-spirit issues are still open, their rulings preserved in their files — the correct state.

Issues left out of scope are left strictly alone: no stamps, no editorializing, no summary prose about them in the sprint.

An empty intake, or a relevance pass returning nothing bearing, passes silently.

## Sign-off

Dispatch the compliance reviewer from `.claude/skills/_shared/design-doc-compliance-reviewer.md` in draft mode, scoped to the sprint's corpus deltas plus any live artifacts they amend. Fix mechanical findings in the draft directly. Walk judgment findings with the owner now — the first of the two review opportunities; a judgment finding resolved here never becomes an issue file. Re-dispatch until clean.

This review is the **only** point at which a delta's claims are checked for truth; every later gate measures the repository against the approved sprint. Do not wave through a grounding finding because the artifact is otherwise well-formed: a claim the repository contradicts is the finding, and the fix is to correct it. Rationale and Alternatives reasoning is the owner's a priori record — verified where it asserts repository facts, accepted otherwise, never flagged for being unverifiable.

Then present the sprint to the owner for sign-off. It is not final until they approve.

## Terminal

1. **Record the promotions.** For every issue this sprint resolved — the ruled issues pulled in at **Frame** and the issues promoted during the walk — stamp the file: `status: promoted`, `sprint: <this sprint's filename>`. The file stays in `.ok-planner/issues/` until the sprint's implementation closes (the certify gate's archival offer moves it to `history/issues/`). Every promoted slug also appears in the sprint's `## Intent` list — the same fact from the other side.
2. The approved sprint at `.ok-planner/sprints/YYYY-MM-DD-<slug>.md` is this family's terminal artifact for the ceremony.

## Boundaries

- Does not implement work items or mutate code.
- Does not mutate `design/` directly — corpus changes ride the sprint's deltas, applied by the implementer.
- Does not stage, phase, or theme the work items — sequencing is execution's job.
- Does not march the owner through the whole intake on a feature-work sprint; only bearing issues are walked.
- Does not re-litigate a ruled issue — a written ruling is discussed only when it genuinely cannot be understood.
- Does not close issues without the owner: every promotion and retirement is an owner decision, in the file or live.
- Does not re-open, revisit, or report on issues an earlier sprint promoted. A problem with a past sprint's decision is a new issue with a new file.
- Does not leave a promoted issue's substance only in the intake — the sprint carries the whole resolution.
- Does not defer its own open questions silently — a question the owner postpones is filed per `{{ISSUE-FILE-FORMAT}}` with `kind: "sprint"`.

<!-- Materialized by ok-planner v19.4.4 — suite-owned; overwritten on converge; do not hand-edit. -->
