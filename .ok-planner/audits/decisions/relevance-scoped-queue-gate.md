---
audit: relevance-scoped-queue-gate
artifact: decision:relevance-scoped-queue-gate
determination: satisfied
audited: 2026-07-27T13:15:00Z
artifact-hash: sha256:3a4799b8ddc2
---

# Does the planning ceremony draft first, split the unruled open issues by relevance, walk only the bearing ones one at a time with corpus surfaced first, treat the count as information, tiebreak toward bearing, and invert for intake-drain sessions?

## Claims

**Title — "The intake gates planning by relevance, not at the door."** The
ceremony's ordering is the check: the intake is read at §1 only to split ruled
from unruled and pull the ruled in; the unruled remainder is explicitly not
presented there, and the relevance treatment happens at §4 after the §3 draft
exists. Nothing in the ceremony blocks on the intake before drafting. Honored.

**Choice clause 1 — "A feature-work planning session drafts the sprint
first."** The session-shape fork sends a feature-work sprint to §2 → §3 and
says the intake is *not* the agenda beyond the ruled sweep; the §4 branch for
feature work names the relevance pass as running "over the §3 draft", so the
draft is an input the pass cannot run without. Honored.

**Choice clause 2 — "a dedicated relevance reviewer then splits the unruled
open issues into bearing and independent."** §4 dispatches a separate agent
whose stated job is deciding bearing-vs-independent and never resolving
anything; its Inputs block names the draft sprint and, as the issue population,
"files under `.ok-planner/issues/` with status open or verified and an empty
Ruling section" — i.e. the unruled set, matching the artifact's repaired
wording. Its output format is a per-issue `BEARS | INDEPENDENT` line behind a
`Status: N bearing | M independent` line. Honored.

**Choice clause 3 — "and only the bearing ones are walked with the owner — one
at a time, with the corpus artifacts relevant to each surfaced first."** The
feature-work branch says to walk only the issues the pass returns as bearing.
The walk section opens with the mandatory surfacing step — run the corpus
surfacer on the issue file and read each surfaced artifact in full — and only
then walks the in-scope issues with the owner "one at a time (never as a
wall)", presenting a one-sentence note on what the surfaced corpus says. Order
and granularity both match. Honored.

**Choice clause 4 — "The open count is information, not a gate."** §1 directs
telling the owner the counts and states in the same breath that the count is
information, not a gate, and that the owner may always widen scope. Nothing
downstream conditions proceeding on the count; an empty intake or an empty
bearing set passes silently. Honored.

**Choice clause 5 — "the reviewer's tiebreak is fixed: when it cannot tell, it
answers that the issue bears."** The dispatch carries the instruction verbatim
("When you cannot tell, answer BEARS") together with the artifact's own
justification for it. The suite check `text-presence` asserts this exact
sentence, the reviewer-dispatch sentence, and the feature-work relevance-pass
sentence stand verbatim in the ceremony — the block carrying this decision's
`@decision:` annotation. Honored.

**Choice clause 6 — "Intake-drain sessions invert this: there the intake is the
agenda."** Both forks say so: the session-shape section states an intake-drain
sprint's purpose *is* the intake and runs §4 before §2 and §3, and §4's own
scoping states an intake-drain sprint's scope is every unruled open issue (or
the named batch) with no relevance pass. Honored.

**Rationale capability claim — "building over a bearing issue decides it
silently, while an independent issue costs the sprint nothing by staying
open."** §4's opening states the first half as the single reason unruled issues
matter to a sprint, and states the second half as the rule for leaving
independent issues untouched in the intake; issues left out of scope get no
stamps and no prose. Honored.

## Determination

**Satisfied.** The ceremony implements the gate exactly as the Choice states
it: draft first, dedicated reviewer over the unruled set only, walk restricted
to the bearing return, corpus surfaced before each issue is put to the owner,
one issue at a time, the count reported as information, the tiebreak fixed at
BEARS, and the intake-drain inversion spelled out on both forks. Three of the
governing sentences are additionally held in place by a maintenance check that
fails on their deletion or rewording.

This stops holding if: the relevance pass moves ahead of the §3 draft or is
made to read the ruled set as well as the unruled; the reviewer is given
resolution authority or merged into the walk; the surfacing step is dropped or
demoted below the presentation; the walk stops being one-at-a-time; the count
becomes a precondition for proceeding; the BEARS tiebreak is removed or
inverted; or the intake-drain branch stops taking the intake as its agenda. The
`cite-span` on the checked block breaks if the three asserted sentences change,
which forces this audit to be re-derived.

## Citations

- cite: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md :: "run the relevance pass below over the §3 draft"
- cite-span: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md :: "Dispatch a dedicated reviewer. It decides bearing-vs-independent" +3 sha256:2e568270f1c7
- cite: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md :: "Unruled open issues (files under"
- cite: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md :: "When you cannot tell, answer BEARS."
- cite: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md :: "The count is information, not a gate"
- cite: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md :: "Intake-drain sprint** — scope is every unruled open issue"
- cite: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md :: "Before presenting each issue, surface the design corpus that likely bears on it"
- cite: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md :: "Only then walk the in-scope issues with the owner"
- cite-span: checks/text-presence :: "# @decision: relevance-scoped-queue-gate" +16 sha256:4f40e97b72b0
- cite-file: checks/text-presence @ sha256:1223b216280a
