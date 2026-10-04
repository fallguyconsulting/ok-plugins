---
issue: practice-violations-are-a8-defects
kind: human
category: design
artifacts:
  - concept:practice
  - concept:subject
  - decision:violations-are-remediation-not-issues
status: promoted
sprint: 2026-10-04-consolidate-into-ok-planner.md
opened: 2026-10-04T05:25:00Z
---

# Review prompts carry the project's practices, but no accept-list entry makes a breach of a practice a defect

## Problem

`/converge` pastes the project's subjects and practices into every hunt, fix, and verify prompt through `standards` in `.ok-planner/review/config.json` (`.ok-plumbline/subjects` and `.ok-plumbline/practices`). The accept list's entry A8 counts a breach of a rule as a defect only when the rule comes from `.claude/rules/plumbline-coding.md`, a code-rule file listed under `## Code rules` in `.ok-planner/review/project.md`, or the live design corpus. Practices are none of the three. A hunter reads a practice and cannot file a site that departs from it.

The plumbline cheatsheet says "Violations of a ruled practice are **work**, not questions: they become remediation in a future sprint, never issues." `decision:violations-are-remediation-not-issues` says the same: "A site that departs from the practice governing it is remediation work carried by ordinary planning, never an entry in the issue intake." That decision predates `category: defect` issues, which are work and not questions: `/converge` fixes them and no owner judges them.

`issue:events-are-a-logging-discipline-enforced-by-review` closes the same gap for the events standard.

## Candidates

- Name the project's ruled practices as a source in A8, and rewrite the cheatsheet line and the decision so a practice violation is a defect `/converge` fixes, or files as a `category: defect` issue when it lies outside the run's scope.
- Leave practices out of A8, so violations wait for a sprint's remediation.

## Ruling

Name the project's ruled practices as one of A8's sources. A site a practice governs and departs from is a defect `/converge` fixes in the run, or files as a `category: defect` issue when it lies outside the run's scope. This keeps the decision's point: a practice violation needs a worker, not the owner's judgment, and a defect issue asks for no judgment. Rewrite the cheatsheet line and the decision to say so. A gap, a collision, and a site whose governing practice could be found only by tracing beyond the point of use still go to the intake as judgment issues, as the decision says today.
