---
decision: foreign-harms-become-upstream-issues
---

# A harm in a part the project does not own becomes an upstream issue in the intake

## Choice

A harm whose fix lies in a part the project does not own becomes a
judgment issue in the intake marked as upstream, filed by whichever run
meets it: `/converge`, `/audit`, or a sprint's build. `/triage-issues`
marks an issue already in the intake as upstream and leaves it open.
A part the project does not own is a file the suite owns, a library the
project depends on, an outside tool or service, or the suite's accept
list itself, for a harm the list does not name. The issue names the
foreign part as the project sees it (the package and its version, the
tool, or the file as it sits in the project), the site, the harm, and
the evidence, and carries a draft ready to file with the part's
maintainers. No run closes it on its own authority while the project
still shows the harm, and no run hands it to the owner as a step at the
end of its work;
`/triage-issues` closes it as answered once the project no longer
shows the harm, as after an update of the foreign part. The planning session walks it with the
owner, who resolves it one of three ways: a workaround in the project,
which becomes sprint work; a filing upstream, after which the planning
session closes the issue on the owner's resolution, naming where it was
filed; or both.

## Rationale

A harm the project cannot fix in place still costs the project until
someone acts on it. Closing it at triage and handing the owner a step
at the end of a run depends on the owner acting in that moment, and an
issue the owner passes over then is lost. The intake is where the owner
keeps what needs later attention, and planning is where the owner
decides; a workaround is project work, so it belongs in a sprint.
Naming the foreign part as the project sees it keeps the issue true on
any machine, where a path to one person's checkout is not.

## Alternatives

- Triage closes the issue with a ready-to-file draft and the run's
  return asks the owner to file it — no intake entry to keep, and an
  issue the owner does not file at that moment is gone.
- Fix the foreign part in place — fixes the project soonest, and the
  next update of the part overwrites the fix or forks the project from
  its upstream.
- Drop the harm — keeps the intake small, and the harm stays in the
  project unrecorded.
