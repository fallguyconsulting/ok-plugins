---
topic: plan-sprint-ceremony
kind: concept
---

# The planning ceremony (/plan-sprint)

## Description

`/plan-sprint` is "the planning ceremony. An interactive session with the project owner that produces a sprint." Its flow: **§0 true up** → **§1 frame the session** — fold the queue, note the open count without presenting it, and classify the sprint as **queue-drain** ("the owner's purpose *is* working the intake queue ... The queue is the agenda") or **feature-work** (the default; "The queue is **not** the agenda and is not opened here"); "The count is information, not a gate" → **§2 intake dialogue** ("The owner brings goals; you bring the corpus ... surface every tradeoff explicitly — never resolve one silently on the owner's behalf"; the proof dialogue gate fires when spec content implies intent change) → **§3 draft the sprint** (the full template with fixed boilerplate) → **§4 the intake queue** → **§5 sign-off review** → **§6 terminal**.

The **queue gate is relevance-scoped, not an entry gate** — a rule ok-planner's CLAUDE.md orders preserved through any rewording: "a feature-work `/plan-sprint` drafts first, then a dedicated relevance reviewer splits the open issues into bearing vs. independent and only the bearing ones are walked with the owner. The justification is narrow ...: building over a bearing issue *decides it silently*; an independent issue costs the sprint nothing by staying open." The relevance reviewer subagent decides bearing/independent only ("it never resolves anything"), with a stated tiebreak: "When you cannot tell, answer BEARS. A needless owner conversation costs a minute; a silently decided design question costs a rewrite."

**The issue walk** goes one issue at a time ("never as a wall"). Before presenting each issue, the session runs `scripts/surface-corpus` (stdin: the row JSON; env `OK_PLANNER_PROJECT_ROOT`) which surfaces corpus artifacts bearing on the row — tier 1: artifacts cited in `artifacts[]`; tier 2: rare-token matches weighted by inverse document frequency (tokens in >30% of docs discarded as noise), ranked, capped at 10. "Read each surfaced artifact in full ... If the script prints nothing, that itself is a signal ... flag it to the owner rather than proceeding blind." The owner picks one of two outcomes per issue: **promote** (resolution carried into the sprint *now*, in final form — "the issue row is a receipt, not a companion document") or **retire** (dropped with a reason). **Timing rule**: "retire rows go in during the walk; promote rows go in at §6, after sign-off. A promotion is a handoff to a sprint, so it is only true once that sprint exists in approved final form ... If the session dies before sign-off, the promoted-in-spirit issues are still open, which is the correct state."

**§5** dispatches the shared compliance reviewer in draft mode over the deltas plus amended live artifacts; mechanical findings fixed in the draft, judgment findings walked with the owner ("a judgment finding resolved here never becomes an issue row"), re-dispatched until clean. **§6**: write all promote rows in one append, then **stop** — "The approved sprint ... is this skill's terminal artifact. Executing it is a separate act, and this skill does not begin it." The NOT-do list adds: never mutate design/ directly, never stage/phase/theme, never terminate issues without the owner, never re-open promoted issues, never defer its own questions silently (they become kind `sprint` open rows).

## Code surface

- `plugins/ok-planner/skills/plan-sprint/SKILL.md` (273 lines; embedded relevance-reviewer prompt; surfacer invocation; template).
- `plugins/ok-planner/scripts/surface-corpus` (Python, 145 lines; STOP list, MAX_DOC_FRACTION=0.30, MIN_TOKEN_LEN=4, TOP_N=10).
- `skills/_shared/design-doc-compliance-reviewer.md` (draft mode).

## Prose surface

- `plugins/ok-planner/CLAUDE.md` (the queue-gate rationale marked "worth preserving in any rewording"); index skill row; estate CLAUDE.md lifecycle section.

## Adjacent topics

- `sprint`, `issue-queue`, `completion-contract`, `proof-and-falsifier` (dialogue gate), `transclusion-tokens` (reviewer sharing), `script-materialization` (surface-corpus runs from plugin root).

## Observations

- The corpus-surfacing step is the newest addition (commit ede391d "surface bearing corpus before each issue walk") and is the only Python in the suite.
- §4's opening line "promoted into this sprint's sprint" is another "sprint's sprint" doubling (rename residue).
- The relevance reviewer receives open rows "verbatim JSON, one per line" — the queue's fold semantics are re-implemented by the calling session, not by any shared tool; every consumer folds by hand.
