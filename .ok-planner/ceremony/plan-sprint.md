# ok-planner — planning ceremony surface

What the suite's planning ceremony does about this family's estate.
The ceremony owns the spine and the order; this file owns everything
ok-planner contributes to it. Materialized into consumer projects at
`.ok-planner/ceremony/plan-sprint.md`; the ceremony reads it there when
`.ok-planner/` exists.

## Requires

`.ok-planner/` at the project root. This family owns the planning
ceremony's terminal artifact — the **sprint** — so a project without
this estate has nowhere to write one: the ceremony says so and stops
rather than inventing a location.

`.ok-planner/design/` must exist before a sprint can carry corpus
deltas. If it does not, say so and point at `/discover-design`; the
session may still proceed to work items alone.

## Vocabulary

Read `.claude/skills/_shared/artifact-definitions.md` before authoring
anything. Every delta drafted here must already comply with the
canonical artifact rules — the sign-off review checks exactly that.
`{{CORPUS-DELTA-FORM}}` there is the authority on a delta's parts;
this surface never restates it.

Two things in this workflow must not be confused: the **issue intake**
(`.ok-planner/issues/`, one markdown file per issue) is where questions
accumulate; the **sprint** is what the session commits to. Issues move
from the first to the second by promotion, and that is a one-way trip.

## Layout

`mkdir -p .ok-planner/sprints .ok-planner/issues .ok-planner/history/sprints .ok-planner/history/issues`
so the layout and the issue intake exist — estate convergence is the
front door's administration (`/ok`), never a ceremony's. If a legacy
`.ok-planner/issues.jsonl` is present, invoke `verify-issues` before
framing anything: it converts the log into issue files and verifies
whatever is unverified.

## Frame

Read the intake: every file under `.ok-planner/issues/` with
`status: open` or `status: verified` is an open issue (`promoted` and
`retired` files are closed, whatever directory they sit in). Split the
open set by the `## Ruling` section: **ruled** (non-empty Ruling text)
vs **unruled**. Do **not** present the unruled ones yet.

**Pull in the ruled issues first.** A ruling is the owner's decision,
already made — this session does not re-open it. For each ruled issue,
read the file and carry the ruling's substance into the sprint being
drafted in final form: corpus delta, work item, or both, exactly as if
the owner had just decided it live. Do not discuss a ruled issue with
the owner **unless the ruling genuinely cannot be understood** — then
ask about that one ruling, in prose, and transcribe the clarification.
A ruling that amounts to "drop it" is a retirement: record the reason
under its Ruling, set `status: retired`, and move the file to
`history/issues/` now.

**Generated and recommended rulings ride in the same sweep, named
once.** A ruling marked `> Generated ruling (/verify-issues): …` was
written because the corpus and its authoring rules determine the
resolution; one marked `> Recommended ruling (…): …` (attributed to
`/verify-issues`, or to the retired `/recommend-rulings` in older
files) is the verifier's judgment call the owner accepted by silence.
Carry both like any ruling, but at sign-off name each batch in one line
("3 pulled rulings are generated: <slugs>; 5 are accepted
recommendations: <slugs> — say the word to drop any") so nothing unread
by the owner is silently absorbed. Never re-discuss them individually
unless the owner asks.

Then establish what kind of session this is, from the owner's opening
ask. If it is not clear, ask, in one prose question:

- **Intake-drain sprint** — the owner's purpose *is* working the issue
  intake: all of it, or a batch they name. The intake is the agenda.
  Run the issue walk (under **Resolve** below) now over that scope,
  then the dialogue (thin — the resolutions largely are the intake) and
  the draft, drafting the sprint from what the resolutions imply.
- **Feature-work sprint** — the default. The owner brings work they
  want taken on. The intake is **not** the agenda beyond the ruled
  sweep above: go to the dialogue and the draft, and consult the
  unruled issues at **Resolve** against the drafted work.

Tell the owner the counts either way ("3 ruled issues pulled into this
sprint; 7 unruled open — I'll check which of those bear on this work
once we've drafted it"). The count is information, not a gate — the
owner may always widen scope to the whole intake.

## Reconcile

Work sometimes lands outside any sprint — a hotfix, an experiment that
stuck, a redesign done in a session that never ran the ceremony. The
corpus catches up with such work **here**, not through certification:
certification's fixers treat the corpus as the fixed pole and would
either bend the new code back toward stale docs or file issues asking a
question the owner already answered by doing the work. This ceremony is
the one place the corpus itself legally moves, so it is also where
reality and the corpus get reconciled — up front, before anything else
is drafted on top of them.

1. **Resolve the baseline.** Every sprint closed by a certify gate
   carries the closing commit in its frontmatter: `closed: <sha>`,
   stamped at archival. The baseline is the `closed:` stamp of the
   newest file under `.ok-planner/history/sprints/` that has one. If no
   archived sprint carries a stamp (archives predating the mechanism),
   say so and ask the owner, once, in prose, whether to name a baseline
   ref or skip the walk this time — never guess one.

2. **Compute the window.** `git log --oneline <closed>..HEAD` plus the
   uncommitted tree. Empty window → the phase passes silently.

3. **Filter for bearing changes.** The window will mostly be legitimate
   ambient change that touches no corpus commitment — "changed since
   baseline" is a window, not an accusation. Dispatch the out-of-band
   reviewer below; only what it returns as BEARING is walked.

4. **Walk the bearing set with the owner, one change at a time**,
   before the intake dialogue builds on it. For each, the owner picks
   one of three outcomes, and the pick lands in this sprint:
   - **Corpus catches up** — the out-of-band work is intended reality;
     draft the delta(s) that bring the affected artifacts into
     agreement with it. This is also how the work's missing
     authorization is granted: the approved delta *is* the approval,
     retroactively.
   - **Code catches up** — the corpus's commitment stands; add a work
     item restoring it.
   - **Record and defer** — the owner wants to think; file an issue per
     `{{ISSUE-FILE-FORMAT}}` (kind `human`, the divergence as the
     Problem) so the question is held by the intake, not by memory. The
     sprint must not otherwise touch the artifacts that divergence
     bears on.

An empty window or an all-ambient review passes silently — say one line
("no out-of-band work since <sprint>") and move on.

### Out-of-band reviewer

```
Agent (general-purpose, model: sonnet-5):
  ## Out-of-band change review

  {{LEAF-AGENT-RULE}}

  {{READ-ONLY-REVIEWER-RULE}}

  ### Your job

  Decide which changes in a git window bear on the design corpus's
  commitments. You are not judging whether the changes are good and
  not proposing resolutions — the project owner does that. You are
  deciding, per change, whether the corpus and the code still tell
  the same story.

  ### Inputs

  Window: [<closed-sha>..HEAD, plus the uncommitted tree]
  Enumerate it yourself: `git log --oneline <window>`,
  `git diff <closed-sha>` (and `git status --short` for anything
  uncommitted). Read changed files in full where the diff alone
  is ambiguous.

  The design corpus at `.ok-planner/design/` is the comparison
  pole — read the three catalog TOCs first, then the full body of
  every artifact a change plausibly touches.

  ### The test

  A change (or a coherent group of changes — group by mechanism,
  not by commit) is BEARING if any of these hold:

  - It contradicts something a live artifact commits to — an
    invariant, a boundary, a Choice, a promised outcome.
  - It retires, replaces, or bypasses a mechanism a live artifact
    names as how a commitment is delivered.
  - It adds capability or structure significant enough that the
    corpus's claims are silent about something load-bearing.
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

Discuss what this sprint should take on. The owner brings goals; you
bring the corpus (read `design/` freely — it is source of truth). Ask
questions in prose; surface every tradeoff explicitly — never resolve
one silently on the owner's behalf. When work implies a story- or
decision-intent change, surface the three options to the owner:
preserve the intent / shift the intent / remove the artifact — the
owner picks, never you. Draft stories concretely: a capability a reader
can settle by looking, and a benefit stated as something observable.
Reaching for correct, clear, or helpful usually means the need is not
yet named — say what the user can now do instead, per
`{{STORY-DEFINITION}}`. Where a promise genuinely rests on a human
discipline's judgment, `{{DECIDABILITY-BOUNDARY}}` makes it a referral
in the story's audit rather than a clause the story leans on.

## Draft

Write to `.ok-planner/sprints/YYYY-MM-DD-<slug>.md`, using the sprint
document template in `.claude/skills/_shared/sprint-document.md`.

The corpus deltas are the substantive body, and each is authored per
`{{CORPUS-DELTA-FORM}}`: a complete final-form body, resolved fully in
this session's dialogue — edit the artifact surgically with the owner
and carry the whole result. A retirement carries nothing beyond its
heading. Where the bodies run long, put them in the sidecar folder
beside the sprint (`<sprint-name>-deltas/<kind>s/<slug>.md`) and point
each heading there. Applying a delta IS updating the corpus.

**The sprint is self-sufficient.** Once written, it is the source of
truth for execution: everything the work needs is in it, in final form.
An executing agent never reads an issue file to find out what a
promoted issue "really meant" — if a resolution's substance is not in
the deltas or the work items, it is not in the sprint. Write
accordingly.

### The predictive classification test

Where the project keeps a surface partition
(`.ok-planner/surface/guidance.md` exists), drafting includes one
predictive check per `decision:owner-guided-surface-partition`: for
work that would introduce new user-facing surface — a new command, a
new route, a new exported module — read the guidance and ask whether
it already claims the new surface. **Claimed passes silently.**
Unclaimed is raised with the owner as one prose question — public or
private, and under what rule — and the answer rides the sprint as a
work item editing the guidance document, so the audit's next opening
finds it settled and ratified. Stories carry the public-by-construction
prior — a story's promised capability is something a user reaches, so
its surface is public unless the owner says otherwise — which means
only genuine ambiguity reaches the owner. This is planning moving the
audit's one interactive question earlier, to when the owner is already
deciding the work; it never writes the guidance itself mid-session.

## Resolve

`.ok-planner/issues/` is **intake**: a holding area for questions
waiting to reach a sprint. This session is the only place issues close,
and they close in one of two ways — **promoted** into this sprint, or
**retired** at the owner's word. The ruled ones were already pulled in
at **Frame**; this phase is about the **unruled** remainder.

Unruled open issues matter to this sprint for exactly one reason:
**building over an open issue decides it silently.** An issue whose
answer the drafted work would encode by default must be resolved by the
owner first. An issue the work neither touches nor presumes an answer
to is not this sprint's business and stays in the intake — and an issue
the owner already answered by ruling never re-enters discussion.

So the walk is scoped:

- **Intake-drain sprint** — scope is every unruled open issue (or the
  batch the owner named). No relevance pass; go straight to the walk.
- **Feature-work sprint** — run the relevance pass below over the draft
  and the unruled open issues only, then walk only the issues it
  returns as bearing. This raises exactly what a full walk would have
  raised anyway — nothing is added to the owner's plate just because
  the intake is being looked at.

### Relevance pass (feature-work sprints)

Dispatch a dedicated reviewer. It decides bearing-vs-independent; it
never resolves anything.

```
Agent (general-purpose, model: sonnet-5):
  ## Issue relevance pass

  {{LEAF-AGENT-RULE}}

  {{READ-ONLY-REVIEWER-RULE}}

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

  An issue is INDEPENDENT if the drafted work can be built and
  certified without answering it, AND answering it later cannot
  invalidate anything the sprint commits to.

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

Report the split to the owner in one line (`4 of 7 open issues bear on
this work; walking those now`). The owner may pull an independent one
into scope; they never have to.

### The issue walk

**Before presenting each issue, surface the design corpus that likely
bears on it.** An issue can be silently decided against a corpus
invariant the walker never consulted — the exact class of failure this
step exists to prevent. Run the surfacer on the issue file:

```bash
OK_PLANNER_PROJECT_ROOT="$(pwd)" \
  python3 .ok-planner/scripts/surface-corpus .ok-planner/issues/<file>.md
```

The script prints, one per line, the concept / story / decision files
that either (a) are explicitly cited in the issue's frontmatter
`artifacts:` list, or (b) match distinctive rare tokens from the issue's
slug and body. Read each surfaced artifact in full — its Invariants and
Boundaries may already resolve the question, retire the issue, or
reshape the framing entirely. If the script prints nothing, that itself
is a signal — an issue with no bearing artifact is either about pure
code with no corpus commitment or about a concept the file failed to
name; flag it to the owner rather than proceeding blind.

Only then walk the in-scope issues with the owner **one at a time**
(never as a wall): present the issue's title, Problem, and Candidates —
leaning on its verifier-written narrative, which is the from-the-top
treatment built for exactly this moment — plus a one-sentence note on
what the surfaced corpus says (`concept:X invariant N says the answer is
Y — likely a retire`; `concept:X owns this vocabulary but the invariant
is silent on the question`; etc.); the owner picks one of two outcomes.

**Promote** — the owner decides the answer (one of the candidates, or a
shape of their own). Transcribe the decision verbatim into the file's
`## Ruling` (it is the owner's ruling, given live), and carry the
substance into the sprint *now*, in final form: as a corpus delta, a
work item, or both. On a feature-work sprint that means amending the
draft, including where the resolution collides with a delta already
drafted; on an intake-drain sprint these resolutions are the material
the draft is built from. What lands in the sprint is the whole of the
resolution — the issue file is a receipt, not a companion document.

**Retire** — the owner drops the question ("won't fix", "not real
anymore", "already answered"). Nothing is carried into the sprint.
Record it immediately: the owner's reason under `## Ruling`,
`status: retired` in the frontmatter, and move the file to
`.ok-planner/history/issues/`.

All file mutations follow `{{ISSUE-FILE-FORMAT}}`. Only this session
writes `promoted` and `retired` stamps.

**Timing: retirements happen during the walk; `promoted` stamps go in
at the terminal phase, after sign-off.** A promotion is a handoff to a
sprint, so it is only true once that sprint exists in approved final
form — stamping files mid-walk would empty the intake into a document
the owner might still reject or reshape. A retirement is unconditional
and is recorded on the spot. If the session dies before sign-off, the
promoted-in-spirit issues are still open (their rulings preserved in
their files), which is the correct state.

Issues left out of scope are left strictly alone: no stamps, no
editorializing, no summary prose about them in the sprint. They stay in
the intake for a later sprint.

An empty intake, or a relevance pass that returns nothing bearing,
passes silently.

## Sign-off

Dispatch the compliance reviewer from
`.claude/skills/_shared/design-doc-compliance-reviewer.md` in **draft
mode**, scoped to the sprint's corpus deltas plus any live artifacts
they amend. Fix mechanical findings in the draft directly. Walk
judgment findings with the owner now — this is the first of the two
review opportunities, and a judgment finding resolved here never
becomes an issue file. Re-dispatch until clean.

This review is also the **only** point at which a delta's claims are
checked for truth, and it is why the reviewer runs here rather than
only at whole-corpus cadence. From the moment a sprint is approved it
becomes the instrument every certification producer measures the
repository against: the alignment judge compares the corpus to the
delta, so a delta that matches itself reads clean no matter what it
asserts. A rationale invented at drafting is invisible from then on. Do
not wave through a grounding finding because the artifact is otherwise
well-formed — an unfounded claim in a Rationale or an Alternatives
bullet is the finding, and the fix is to verify it, restate it as what
the repository supports, or delete it.

Then present the sprint to the owner for sign-off. It is not final
until they approve.

## Terminal

1. **Record the promotions.** For every issue this sprint resolved —
   the ruled issues pulled in at **Frame** and the issues promoted
   during the walk — stamp the file: `status: promoted`,
   `sprint: <this sprint's filename>`. The file stays in
   `.ok-planner/issues/` until the sprint's implementation closes (it
   moves to `history/issues/` when the owner accepts the certify gate's
   archival offer). Every promoted slug should also appear in the
   sprint's `## Intent` list — that is the same fact from the other
   side.
2. The approved sprint at `.ok-planner/sprints/YYYY-MM-DD-<slug>.md` is
   this family's terminal artifact for the ceremony.

## Boundaries

- Does not implement work items or mutate code.
- Does not mutate `design/` directly — corpus changes ride the sprint's
  deltas and are applied by the implementer.
- Does not stage, phase, or theme the work items — sequencing is
  execution's job, decided at execution time.
- Does not march the owner through the whole issue intake on a
  feature-work sprint; only issues that bear on the drafted work are
  walked.
- Does not re-litigate a ruled issue — a written ruling is the owner's
  decision, discussed only when it genuinely cannot be understood.
- Does not close issues without the owner (every promotion and
  retirement is an owner decision — a ruling written in the file, or a
  call made in-session).
- Does not re-open, revisit, or report on issues already promoted by an
  earlier sprint. They are settled; their sprint owns them. A problem
  with what a past sprint decided is a new issue with a new file.
- Does not leave a promoted issue's substance only in the intake — the
  sprint carries the whole resolution, and the issue file is only a
  receipt.
- Does not defer its own open questions silently — a question the owner
  explicitly postpones is filed to `.ok-planner/issues/` per
  `{{ISSUE-FILE-FORMAT}}` with `kind: "sprint"`.

<!-- Materialized by ok-planner v15.2.0 — suite-owned; overwritten on converge; do not hand-edit. -->
