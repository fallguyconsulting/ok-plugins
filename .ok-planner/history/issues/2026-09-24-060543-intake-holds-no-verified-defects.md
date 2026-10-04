---
issue: intake-holds-no-verified-defects
kind: human
category: unspecified
artifacts:
  - concept:issue
  - story:plan-a-sprint
status: retired
opened: 2026-09-24T06:05:43Z
---

# The intake takes only questions, so a clear defect found outside a run's scope has nowhere to go

## Problem

The suite's issue definition admits only judgment items to the
intake. `{{ISSUE-DEFINITION}}` in
`plugins/ok/families/ok-planner/skills/_shared/artifact-definitions.md`
says "Only judgment items become issues. Fix mechanical findings
in-cycle and file none," and "The intake is a queue of questions, not
a work tracker." A review loop that stays bounded needs a third
option: a defect the accept list already decides, found outside the
scope of the run that found it. Fixing it in that run widens the run's
scope, and widening scope is what drove an unbounded certification
loop to its 11- and 14-round caps in one consumer project. Filing it as
a question asks the owner to judge something no one needs to judge.

The consumer project (linescout `platform/`) now trials this as a
project rule, `.claude/rules/defect-issues.md`:

- An issue with `category: defect` is a harm the accept list covers,
  at a named site, found outside a run's scope. Its one Candidate is
  to fix the site.
- `/verify-issues` closes it `answered` where the code no longer shows
  it, and otherwise writes a generated ruling to fix it.
- `/plan-sprint` pulls in no defect issue and walks none. The
  project's `/converge`, in its whole-project modes, reads every open
  or verified defect issue as a report, fixes it, and closes the
  issue `fixed` (a new terminal status) with the run's name, or
  `answered` where the code no longer shows it.
- Its sprint-certification mode files defects outside the sprint's
  scope as defect issues instead of fixing them, so a sprint's scope
  stays fixed.

The trial also needs a status the suite does not define: `fixed`.

## Candidates

- Amend the issue definition to admit `category: defect` issues as the
  review loop's backlog, routed to the whole-project review loop
  rather than to `/plan-sprint`, with `fixed` as a terminal status the
  review loop writes, and teach `/plan-sprint` and `/verify-issues` the
  routing.
- Keep the intake for questions only, and give the review family a
  backlog of its own under its estate, with the same routing.
- Keep both as they are, and have a run either fix every defect it
  meets or drop the ones outside its scope.

## Ruling

Retired (owner, 2026-10-03): settled out of band. The intake now admits `category: defect` issues, as the Defect issues section of the ok-planner cheatsheet defines: a harm the accept list covers, at a named site, found outside the scope of the run that found it. `/converge`'s owner list files them and closes them `fixed` with `fixed-by: <run>`, `/triage-issues` verifies them, and `/plan-sprint` offers them for the owner to pick.
