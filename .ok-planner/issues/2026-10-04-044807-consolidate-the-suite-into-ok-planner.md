---
issue: consolidate-the-suite-into-ok-planner
kind: human
category: design
artifacts:
  - concept:skill-family
  - concept:estate
  - concept:cheatsheet
  - concept:true-up
  - decision:filesystem-discovery-markers
  - decision:vendored-skills
  - decision:suite-owned-ceremonies
  - decision:lockstep-suite-version
  - story:one-ceremony-per-project
  - story:one-command-suite-upkeep
  - story:incremental-lint-adoption
  - story:explain-lint-rules
  - decision:ratchet-over-soft-start
status: promoted
sprint: 2026-10-04-consolidate-into-ok-planner.md
opened: 2026-10-04T04:48:07Z
---

# The suite splits what it vendors into a project across several families and estates

## Problem

The `ok` plugin vendors into a project from three families and from its own front door:

- ok-planner, with its estate `.ok-planner/` and the skills `/sketch`, `/discover-design`, `/plan-sprint`, `/execute-tasks`, `/converge`, `/triage-issues`, `/ok-planner`, and `/ok-version`;
- ok-plumbline, with its estate `.ok-plumbline/`, the `plumbline` lint binary, its edit hook, and the skills `/budget`, `/events`, `/explain`, `/patterns`, `/port`, `/starter`, `/suggest`, and `/version`;
- ok-workspaces, with its estate `.ok-workspaces/`, the utilities `run-tag` and `port-block`, and the skills `/open`, `/close`, and `/ok-workspaces`;
- the front door's ceremonies `/audit` and `/document`, which read each family's ceremony contribution under its estate.

Each family has its own estate, discovery marker, administration file, converge script, and cheatsheet. The front door discovers families by their markers and administers each one. Every family ships at one suite version, so the split buys the owner no separate releases.

## Candidates

- Move every vendored skill, utility, and estate into ok-planner, so a project carries one family and one estate.
- Keep the families, and retire only ok-workspaces.
- Keep the suite as it stands.

## Ruling

Move every skill, utility, and estate the suite vendors into a project into ok-planner, so a project carries one family. `run-tag` and the reworked `port-block` from `issue:retire-the-worktrees-keep-run-tag-and-port-block` live there too. ok-plumbline folds into ok-planner: its estate joins the planner's estate, and what remains of it is the means by which ok-planner defines and maintains a project's coding standards. The `plumbline` lint survives as ok-planner's lint. Each project chooses which of its checks run, today the comment rule, citation resolution, and the no-tests rule, because a project may allow comments or tests where this suite forbids them. Turning a check off also drops the matching rule from the text the project's agents read, so the written rule and the lint never disagree. The lint's edit hook moves with it. Every ok-plumbline skill retires: `/budget`, `/explain`, `/patterns`, `/port`, `/starter`, `/suggest`, and `/version`, with `/events` retired under `issue:events-are-a-logging-discipline-enforced-by-review`. None of them defines or maintains a coding standard, and the owner never used them. The stories and decisions only these skills realize retire with them; `/ok-version` still reports the versions that govern a session. The owner has not yet settled one part, and `/plan-sprint` takes it up with the owner: whether `/audit` and `/document` stay front-door ceremonies or become ok-planner skills.
