# The public surface as a release boundary — Design Sketch

**Date:** 2026-10-18
**Status:** Sketch (not a sprint; not authorization to build)

## Idea

Make every element the surface intent classes as public a release
boundary, with no separate declaration, the way stored state is one
today. Then sprint planning finds every change that would break a
public contract, such as an endpoint's request shape or a CLI verb's
output. The owner decides each break. Reconcile flags the same breaks
in out-of-band work.

Today the two lists do not meet. The surface intent says what is
public, and it feeds documentation and the analysis hunt. The release
boundaries say who breaks when the code changes, and they feed code
planning. The release boundaries block says outright: "A boundary need
not be part of the declared public surface." The reverse holds too. A
public CLI verb is no boundary unless someone declared one for its
callers. A planner that finds no boundary rules the change `rewrite`,
fixes the callers inside the tree, and never names the callers outside
it. So a contract change reaches the owner only by luck of what the
project declared.

## Shape

### One rule, and the machinery that already exists

The change is small, because the boundary machinery already does the
rest once the public surface counts as a boundary:

- The code planner lists each behavior change and finds its users
  across each boundary (`{{CODE-PLANNER-PROMPT}}`, steps 3 to 5, in
  `skills/plan-sprint/core.md`).
- It rules each one with `{{BEHAVIOR-RULINGS}}`: `rewrite`,
  `preserve`, `migrate: <how>`, or, on the owner's word alone,
  `rewrite across <boundary>: <reason>`.
- `{{OWNER-QUESTION-TEST}}` item 2 sends a change to the owner when it
  "breaks compatibility across a release boundary" and "no compatible
  form of the change reaches the outcome."
- Sprint certification catches a missed break. R1 covers a preserve
  ruling that changed behavior, R4 covers an unlisted change that
  breaks a user, and R5 covers a boundary user no ruling covers. Its
  fixers then restore the contract.
- `/converge` fixers already keep "every user across a boundary
  working unless a ruling of the sprint in scope allows the change."

None of these needs a new step. Each one reads the boundaries, so each
one picks up the public surface once the boundaries include it.

### What a contract is, and what breaks it

A public element's contract is its behavior as
`{{BEHAVIOR-CHANGE-DEFINITION}}` lists it: the inputs it accepts or
refuses, what it returns, what it raises, what it writes, the order of
its effects, the state it leaves, and the format of its output.

- **A break**: the element narrows what it accepts, changes what it
  returns, raises, writes, or prints, or goes away.
- **No break**: an addition old callers never reach, such as a new
  optional flag, a new route, or a new field a reader may ignore. The
  planner rules it `preserve` as a call.
- **A compatible form**: the planner finds a form that keeps old
  callers working, such as accepting both shapes or keeping an alias.
  It rules `migrate: <how>` as a call, and the owner may veto it at
  approval.
- **A real break**: no compatible form reaches the outcome. The change
  goes to the owner, who rules `rewrite across the public surface:
  <reason>`, or changes the outcome.

So the owner rules on every real break, and the planner settles the
rest as calls the owner can veto.

### When the question comes up

The question can come up at three points in `/plan-sprint`, and it
must never come up during execution, because a sprint never stops:

1. **The dialogue and the draft.** The owner proposes work, or a
   drafted delta asks for something, that plainly changes a public
   contract: "rename the `list` verb", "drop the `v1` route". Raise
   the break then, while the work is still being shaped, so the owner
   chooses the outcome with the cost in view.
2. **The owner's judgments, after code planning.** A planner's notes
   carry a behavior change to a public element with no compatible
   form, ruled `owner (public surface)`. This is step 10's walk.
3. **The implementation notes review.** The reviewer finds a break the
   planner missed. It walks with the owner like any other judgment
   finding.

During execution, a build agent that breaks a public contract the plan
did not list leaves a defect. Sprint certification finds it under R4
or R5, and its fixers restore the contract.

### Reconcile

The out-of-band reviewer (`{{OUT-OF-BAND-REVIEWER-PROMPT}}`) gets one
more bearing test: "It breaks the contract of an element the surface
intent classes as public." That test holds even when no corpus
artifact mentions the element. The owner then walks the break with the
three reconcile outcomes:

- **Corpus catches up**: the break stands, with a delta where a
  commitment changed. A surface intent delta goes in where the element
  moved, and a migration work item where old callers need one.
- **Code catches up**: a work item restores the contract.
- **Record and defer**: an issue for a later sprint.

### The edits

| Site | Change |
|---|---|
| `{{RELEASE-BOUNDARIES}}` in `skills/_sprint/shared.md` | Adds a second boundary every project has without declaring it: the public surface, meaning each element the surface intent classes as public, with its callers outside the project as the users across it. |
| `{{OWNER-QUESTION-TEST}}` item 2 | Names the public surface beside "an older or newer part within the same major version, or stored data." |
| `{{CODE-PLANNER-PROMPT}}` step 4 | Finds the users of a public element as "callers outside the project," read from the surface intent and the declaring files it names. |
| `{{IMPLEMENTATION-NOTES-REVIEWER-PROMPT}}` | Checks each changed public element for a missing ruling. |
| `{{OUT-OF-BAND-REVIEWER-PROMPT}}` | The bearing test above. |
| `skills/plan-sprint/SKILL.md`, Dialogue | Raise a plain contract break while drafting. |
| `concept:release-boundary` | Boundaries: the public surface is always a boundary, and a boundary may also lie off it. |
| `decision:release-boundaries-bind-changes` | Choice: "stored state is a boundary every project has without declaring it" names the public surface too. |
| The sprint catalog, R5 | Its text already covers any boundary. Check that it reads correctly with the public surface in it. |

The test sprints sketch (`2026-10-18-test-sprints-sketch.md`) reads
the same rule: its "surface moved" and "surface removed" sorts use the
surface intent to tell a public contract from an internal one.

## Open questions

- **A project with no surface intent.** This project has none:
  `.ok-planner/surface/surface.md` does not exist. With no intent, no
  element is public, and the rule protects nothing. That is by design:
  nothing is public until the owner declares it, and no feature makes
  an element public by itself. The documentation sketch carries how a
  surface gets declared.
- **Who sits across the boundary in this project.** The suite's
  public surface is its slash commands, the true-up core's modes, and
  the materialized scripts' verbs, such as `issues` and `tasks`. The
  callers are other projects' sessions and owners, who update when
  they true up. The vendored skills call the same verbs from inside
  the release. The planner needs to tell those two caller groups
  apart.
- **Version policy.** `{{OWNER-QUESTION-TEST}}` lets "a decision under
  `.ok-planner/design/`" state the rule for major releases. A project
  might want a decision that a public break always means a major
  version. `/release` here already bumps major on a removed or renamed
  command.
- **Elements the intent classes as internal but outside code calls
  anyway.** The rule follows the intent. A caller of an internal
  element gets no protection, which is the point of classing it
  internal.

## Risks / unknowns

- **Planner cost.** Finding outside callers means reading the surface
  intent and its declaring files for every changed element. That adds
  reads to code planning in a project with a wide surface.
- **Noise.** If the intent classes too much as public, every internal
  refactor that touches a public module raises a ruling. The fix is a
  tighter intent, which is the owner's job.
- **Contracts that types don't show.** An output format or an order
  of effects is part of the contract, but nothing checks it
  mechanically. The planner and the reviewer judge it from the code,
  and they can miss it. Certification's drive and, later, test
  sprints are the backstop.

## What this is not

- Not a change to execution. Sprints still run to completion
  unattended, and a missed break is a certification defect.
- Not a new artifact. No list of public members is stored. The
  planner lists them at need from the declaring files, as
  `decision:surface-members-listed-at-need` says.
- Not versioning. The boundary says who breaks, and the release
  decides how the break is announced.
