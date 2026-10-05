---
issue: triage-skill-tooling-definition-omits-ownership
kind: audit
category: defect
artifacts:
  - concept:issue
  - decision:foreign-harms-become-upstream-issues
status: retired
triage: retired
opened: 2026-10-05T10:03:49Z
---

# The triage skill defines a tooling question without the "the project owns" bound the issue format carries

## Problem

The site is `plugins/ok/families/ok-planner/skills/triage-issues/SKILL.md:Every issue leaves triage on one of six routes`. Entry A8 covers it: the text contradicts the decision foreign-harms-become-upstream-issues. Sprint class C1 names the same harm.

The skill defines a judgment issue as one that asks "how the project's own tooling works (its skills, prompts, and rules)". The issue format in `skills/_shared/artifact-definitions.md` bounds the same category: "the skills, prompts, and rules the project owns under `.claude/` and `.ok-planner/`". The decision sends a change to a suite-owned file upstream, not to the next `/plan-sprint` as a tooling question.

Trigger: a triage agent reads the route definition for an issue about a vendored skill. Harm: the agent can route a suite-owned change as a tooling question, where the decision requires an upstream issue.

A fixer in run converge-2026-10-05T024119 noticed this outside its brief (call i47, task t25), as the same class as defect i35. No merge agent confirmed it.

## Candidates

- Fix `plugins/ok/families/ok-planner/skills/triage-issues/SKILL.md:Every issue leaves triage on one of six routes` so its tooling definition no longer admits a suite-owned file.

## Ruling

Retired (/triage-issues): no accept-list entry covers this defect claim. The decision foreign-harms-become-upstream-issues requires triage to mark a suite-owned change as upstream, and `plugins/ok/families/ok-planner/skills/triage-issues/SKILL.md` does so today: the sentence after the tooling parenthetical says "A harm whose fix lies in a part the project does not own is an upstream issue: a suite-owned file", and the `upstream` route row says "A `tooling` issue whose change falls in a suite-owned file routes here", so the looser parenthetical is a wording difference with no harm A8 or another entry names, and the "leaves standing" rule for a rule spelled in more than one place keeps it off the list.
