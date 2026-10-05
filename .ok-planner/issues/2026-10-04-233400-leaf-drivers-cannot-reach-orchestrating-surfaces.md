---
issue: leaf-drivers-cannot-reach-orchestrating-surfaces
kind: audit
category: tooling
artifacts:
  - story:find-and-fix-defects
  - story:certify-completion
  - story:corpus-audit
  - story:practice-coverage-report
  - story:lint-rules-compliance-report
  - story:converge-project-estate
status: verified
triage: question
opened: 2026-10-04T23:34:00Z
---

# Story drivers cannot reach a story offered only through a slash command that dispatches agents

The converge drive gives each story to one driver, an agent that tries to get the story's benefit as a user would. Each driver runs under the `ok-opus` profile, which has no Agent tool, so it cannot start any agent of its own. Several of this product's stories are offered only through slash commands that dispatch agents: `/converge`, `/converge sprint`, and `/audit`. One more is offered only through `/ok`, which the project's review facts file, `.ok-planner/review/project.md`, forbids every agent of the loop to run.

The drive prompt tells a driver to try the primary surface first, and project.md names the slash commands as this product's primary surface. A driver of such a story runs every step up to the first dispatch, stops, and reports that it has no Agent tool. The merge agent then sorts the failure as a failure of the environment, which is accurate. The result is a spent driver and no verdict on the story's primary surface.

In sprint certification run converge-2026-10-04T060800, six drives ended this way: story:find-and-fix-defects and story:certify-completion through `/converge`; story:corpus-audit, story:practice-coverage-report, and story:lint-rules-compliance-report through `/audit`; and story:converge-project-estate through `/ok`, where the driver drove the converge core instead.

Nothing lets a run leave such a story out. project.md has two story lists, "Stories that drive alone" and "Stories that drive on an instance of their own", and both only order or isolate drivers. The review tool's `drives` verb takes a list of stories, so a session could file a subset, but nothing tells it which stories to omit. decision:drive-tries-each-story-as-a-user says a driver works out how to get the benefit "on every surface the story is offered through", and it is silent on a surface a driver cannot reach. The project's model rule puts this out of reach by design: a vendored profile spawns nothing but forks, and only the audit and review profiles fork (decision:subagent-model-follows-job).

## Options

- The converge skill decides for itself which stories reach only an orchestrating or forbidden surface, skips them, and lists them in the return for the owner. Cost: the skill needs a way to judge a story's surfaces before driving it, which is the written plan decision:drive-tries-each-story-as-a-user rejects.
- project.md gains a third list, stories that need a full session. `review drives` files drivers for the rest, and the return names each listed story as undriven on its primary surface, for the owner to drive from a full session. Cost: a seeded section, a review tool change, owner upkeep of the list, and an amendment to the drive decision.
- project.md lets a driver run `/ok` on a scratch copy. Cost: it covers only story:converge-project-estate, and `/ok` also updates the operator's installed plugins, which project.md forbids.
- The session drives such stories itself, since it holds the Agent tool. Cost: a nested ceremony runs inside the converge session's own context, at the scale of a full `/converge` or `/audit` per story.

The ruling decides how the loop handles a story whose only surface it cannot reach.

## Ruling

No story list in project.md, and no rule for which stories can be driven. The task-tracker execution shape and its drive are the wrong shape for a project whose product is skill text, so give such a project an escape hatch instead.

- Add an opt-in flag (for example in `.ok-planner/config.json`) that selects an alternate sprint execution path: the session builds the sprint inline, then runs several rounds of review and fix, with no build tasks in the task tracker and no story drive.
- When the flag is set, sprints get the alternate path's boilerplate (or a boilerplate that branches on the flag). When it is absent, everything behaves as today.
- It is not the default and it is an escape hatch, set up by hand: `/ok` never proposes it, offers it, or sets it, and no skill recommends it.
- This repository sets the flag. With it set, this issue's gap does not arise here; the drive and its limits stay as they are for projects on the default path.
