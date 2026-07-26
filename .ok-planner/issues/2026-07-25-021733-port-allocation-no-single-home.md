---
issue: port-allocation-no-single-home
kind: discover
category: inconsistent
artifacts:
  - concept:workspace
  - story:isolated-parallel-workspaces
status: verified
opened: 2026-07-25T02:17:33Z
---

# The port-block algorithm lives in three places, and only one states it fully

ok-workspaces gives each workspace a reserved port block so parallel jobs never collide. The allocation is stated in three places: the detector's defaults (`basePort: 3000, portsPerWorkspace: 10`), the cheatsheet generator (which reads the same profile fields to write prose), and `open/SKILL.md` — which is the *only* site stating how the workspace index N is derived (one plus the count of existing worktrees). An agent following only the generated cheatsheet cannot compute a correct block, because the N-derivation step never reaches it. The profile carries the *data* but the *algorithm* has no single home.

The corpus states the outcome, not the location: `concept:workspace` says naming and location "come from the profile," but N is computed from live worktree state at open time, outside the profile entirely; the story's acceptance requires namespaced ports but is silent on where the computation lives. The transclusion pattern ok-planner uses for exactly this problem is scoped to ok-planner's skills — ok-workspaces has no transclusion mechanism, so "state it once and transclude" would be new machinery here, not precedent-following.

## Options

- **Materialize an allocation script** — a small script (materialized like src-tag) computes the block from the profile plus live worktree state; `open` invokes it and the cheatsheet references it. Three prose statements collapse into one computed source; the cost is introducing script machinery where `open` is currently pure prompt.
- **State the algorithm canonically in `concept:workspace`** — adds a fourth prose site; nothing transcludes corpus text into workspaces skills, so the three existing statements stay and keep drifting.
- **Leave it** — the cheatsheet remains unable to yield a correct allocation.

The ruling decides: computed single source, or another prose statement, or status quo.

## Ruling

> Recommended ruling (/verify-issues): materialize the allocation script — a sprint work item adds a small profile-driven port-block script to ok-workspaces' materialized set (alongside src-tag), with `open/SKILL.md` invoking it and the generated cheatsheet pointing at it.
>
> Rationale: the suite's consistent grain is deterministic scripts over prose arithmetic wherever an agent must compute something exactly — src-tag exists for precisely this reason. A fourth prose site would add a drift surface; a computed source removes two.

<!-- Owner: this is a recommendation, not your decision. Leave it
as-is to accept — the next /plan-sprint carries it, naming the
generated/recommended batches at sign-off. Edit the text to
redirect, empty the section to discuss live, or delete this note
to adopt the ruling as your own. -->
