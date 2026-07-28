---
audit: relevance-scoped-queue-gate
artifact: decision:relevance-scoped-queue-gate
determination: satisfied
audited: 2026-07-28T00:35:18Z
artifact-hash: sha256:3a4799b8ddc2
---

# Does the planning ceremony draft first, split the unruled open issues by relevance, walk only the bearing ones one at a time with corpus surfaced first, treat the count as information, tiebreak toward bearing, and invert for intake-drain sessions?

## Claims

**Why this is a re-audit.** The design artifact is unchanged (hash identical to
last cycle) and `plan-sprint/SKILL.md` was not touched; the staleness came
solely from the whole-file pin on `checks/text-presence`, which this cycle's
repair edited in a block belonging to a different decision. The
`cite-span` on this decision's own block in that check is intact and
re-derives to the same hash. Every claim below was nevertheless re-read from
the ceremony rather than carried over.

**Title — "The intake gates planning by relevance, not at the door."** The
ceremony's ordering is the check. §1 reads the intake only to split ruled from
unruled and pull the ruled in, and says in the same paragraph "Do **not**
present the unruled ones yet"; the relevance treatment is §4, after the §3
draft exists. Nothing between §0 and §3 blocks on the intake. Honored.

**Choice clause 1 — "A feature-work planning session drafts the sprint
first."** The session-shape fork sends a feature-work sprint to §2 → §3 and
states the intake is *not* the agenda beyond the ruled sweep; §4's feature-work
branch names the pass as running "over the §3 draft and the unruled open issues
only", and the dispatch's Inputs block requires a draft-sprint path. The draft
is an input the pass cannot run without. Adversarial check: §1b's out-of-band
reconciliation *does* run before §2/§3 and can file a new issue, but that is a
git-window walk over changes, not the intake relevance pass, and an issue it
files simply joins the unruled population §4 later reads. No inversion of the
clause. Honored.

**Choice clause 2 — "a dedicated relevance reviewer then splits the unruled
open issues into bearing and independent."** §4 dispatches a separate agent
whose stated job is deciding bearing-vs-independent, with "it never resolves
anything" in the same sentence and an Anti-padding block that forbids proposing
resolutions, candidates, or corpus deltas. Its Inputs name the population
exactly as the artifact's wording does — "files under `.ok-planner/issues/`
with status open or verified and an empty Ruling section" — i.e. the unruled
set, ruled issues already having been carried in at §1 and explicitly never
re-entering discussion. Output is a per-issue `BEARS | INDEPENDENT` line behind
a `Status: N bearing | M independent` line. (A different reviewer, §1b's
out-of-band one, uses a similar-looking status line over a git window; it is
not this pass and does not read the intake.) Honored.

**Choice clause 3 — "and only the bearing ones are walked with the owner — one
at a time, with the corpus artifacts relevant to each surfaced first."** The
feature-work branch says to "walk only the issues it returns as bearing". The
walk section opens with the mandatory surfacing step — run the surfacer on the
issue file and read each surfaced artifact in full, with an explicit
instruction to flag rather than proceed blind when it prints nothing — and only
then walks the in-scope issues "**one at a time** (never as a wall)". Order and
granularity both match; issues left out of scope get no stamps and no prose.
Adversarial check: the ceremony adds "The owner may pull an independent one
into scope; they never have to." That is not the ceremony walking an
independent issue on its own initiative — it is owner authority, and it is the
same authority clause 4 grants explicitly ("the owner may always widen scope").
It does not weaken the default. Honored.

**Choice clause 4 — "The open count is information, not a gate."** §1 directs
telling the owner the counts and states in the same sentence that the count is
information, not a gate, and that the owner may always widen scope to the whole
intake. Nothing downstream conditions proceeding on the count; §4 closes with
"An empty intake, or a relevance pass that returns nothing bearing, passes
silently." Honored.

**Choice clause 5 — "the reviewer's tiebreak is fixed: when it cannot tell, it
answers that the issue bears."** The dispatch carries "When you cannot tell,
answer BEARS." verbatim, followed by the artifact's own justification for it (a
needless conversation costs a minute; a silently decided question costs a
rewrite). The suite check asserts this exact sentence, the reviewer-dispatch
sentence, and the feature-work relevance-pass sentence stand verbatim in the
ceremony — three assertions in the block carrying this decision's `@decision:`
annotation, which I re-read this cycle and re-derived the span hash for
unchanged. The check exits 0 on this tree. Honored.

**Choice clause 6 — "Intake-drain sessions invert this: there the intake is the
agenda."** Both forks say so: §1's session-shape entry states an intake-drain
sprint's purpose *is* working the issue intake, that the intake is the agenda,
and that §4 runs *now*, before §2 and §3, with the sprint drafted from what the
resolutions imply; §4's own scoping states an intake-drain sprint's scope is
every unruled open issue (or the named batch) with no relevance pass, going
straight to the walk. Honored.

**Rationale capability claim — "building over a bearing issue decides it
silently, while an independent issue costs the sprint nothing by staying
open."** §4's opening states the first half as the single reason unruled issues
matter to a sprint ("building over an open issue decides it silently") and the
second half as the rule for leaving independent issues untouched in the intake;
the closing paragraph enforces it — issues left out of scope are left strictly
alone, no stamps, no editorializing, no summary prose. The reviewer's BEARS
test is written from the same premise, with "the implementer would have to
pick, and the pick would stand as the project's answer" marked as the central
case. Honored.

## Determination

**satisfied.** The ceremony implements the gate as the Choice states it: draft
first, a dedicated reviewer over the unruled set only with no resolution
authority, the walk restricted to the bearing return, corpus surfaced before
each issue is put to the owner, one issue at a time, the count reported as
information, the tiebreak fixed at BEARS, and the intake-drain inversion
spelled out on both forks. Three of the governing sentences are additionally
held in place by a maintenance check that fails on their deletion or rewording,
and that check is green. The two places the ceremony goes beyond the Choice —
§1b's out-of-band walk ahead of the draft, and the owner's option to pull an
independent issue into scope — were tested against the clause text and neither
contradicts it.

This stops holding if: the relevance pass moves ahead of the §3 draft or is
made to read the ruled set as well as the unruled; the reviewer is given
resolution authority or merged into the walk; the surfacing step is dropped or
demoted below the presentation; the walk stops being one-at-a-time; the count
becomes a precondition for proceeding; the BEARS tiebreak is removed or
inverted; or the intake-drain branch stops taking the intake as its agenda. The
`cite-span` on the checked block breaks if any of the three asserted sentences
changes, which forces this audit to be re-derived.

## Citations

- cite: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md :: "Read the intake: every file under"
- cite: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md :: "the owner's purpose *is* working the issue intake"
- cite: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md :: "The count is information, not a gate"
- cite: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md :: "Unruled open issues matter to this sprint for exactly one reason"
- cite: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md :: "Intake-drain sprint** — scope is every unruled open issue"
- cite: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md :: "run the relevance pass below over the §3 draft"
- cite-span: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md :: "Dispatch a dedicated reviewer. It decides bearing-vs-independent" +3 sha256:2e568270f1c7
- cite: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md :: "Unruled open issues (files under"
- cite: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md :: "When you cannot tell, answer BEARS."
- cite: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md :: "Status line first: `Status: N bearing | M independent`."
- cite: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md :: "Report the split to the owner in one line"
- cite: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md :: "Before presenting each issue, surface the design corpus that likely bears on it"
- cite: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md :: "Only then walk the in-scope issues with the owner"
- cite: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md :: "Issues left out of scope are left strictly alone"
- cite: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md :: "An empty intake, or a relevance pass that returns nothing bearing, passes silently."
- cite-span: checks/text-presence :: "# @decision: relevance-scoped-queue-gate" +16 sha256:4f40e97b72b0
- cite-node: checks/text-presence @ sha256:1473f590fc7e
