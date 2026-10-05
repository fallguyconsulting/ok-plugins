---
decision: defects-outside-scope-become-defect-issues
---

# A defect outside a run's scope becomes a defect issue for the next run

## Choice

A real defect a `/converge` run meets outside its scope goes to the
intake as a `category: defect` issue: a defect sprint certification
finds in code the sprint neither changed nor reaches, a defect a fixer
notices outside its brief, and a defect the run did not finish. The
issue names the site, the accept-list entry, the trigger, the harm, and
the evidence, and its one candidate is to fix the site. It asks the
owner for no judgment. `/triage-issues` checks it against the accept
list, and the next `/converge` in drive, analysis, or defects mode
takes it up as a report; defects mode takes up nothing else. A defect
whose fix lies in a file no agent of a run edits goes where the rule
on what a run fixes sends it (see also: runs-fix-what-the-project-owns),
never to this route.

## Rationale

A defect outside the run's scope is still decided by the rules. Sending
it to the owner as a question would ask them to rule on something
nobody needs to judge, and the judgment queue would stop meaning what
it means. Dropping it loses a defect a merge agent confirmed. Widening
the run to fix it breaks the scope that keeps sprint certification
about the sprint's change and keeps a run's diff readable. A defect
issue keeps the defect, keeps the run's scope, and keeps the owner out.

## Alternatives

- File it as a judgment issue for the next `/plan-sprint` — durable,
  and it spends owner attention on a fix the rules already decide.
- Drop it — keeps the run's output small, and loses a confirmed
  defect.
- Widen the run to fix it — fixes it soonest, and makes sprint
  certification's change reach code the sprint never touched.
