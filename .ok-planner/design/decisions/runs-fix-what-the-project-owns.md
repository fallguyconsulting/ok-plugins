---
decision: runs-fix-what-the-project-owns
---

# A run leaves five kinds of file alone and fixes every other file the project owns

## Choice

A `/converge` run's agents fix a clear defect in every file the project
owns, wherever the file sits: its code, its own scripts, skills,
rules, and other tooling, its configuration, its review facts, its
release boundaries, its surface intent, and its document types, with
prose other than skill text in review only as the skill-text rule
allows (see also: skill-text-is-reviewed-as-code). A probable defect or
a judgment call goes to the intake. They leave five kinds of file
alone: the design corpus and the coding standards, which change only
through a sprint's deltas; a file the suite owns; the harness
settings, which decide what runs in every session and change only by
the owner's hand or the owner's consent; a record, such as a
sprint, an issue, an audit, an experiment, or anything archived, which
keeps what it said when it was written and changes only by the act
that owns it; and a document the release regenerates. A defect whose
fix lies in the corpus, the coding standards, or the harness settings
goes to the intake as a judgment issue. A harm in a file the suite owns goes to the intake as
an upstream issue (see also: foreign-harms-become-upstream-issues). A
record changes only through the act that owns it, and a run files
nothing about it. A document the release regenerates is left to the
documentation run (see also: placed-documents-are-records).

## Rationale

The line follows ownership, not location. A file the suite owns is
maintained upstream, and the next converge overwrites a local edit. A
project's own tooling and configuration have no maintainer but the
project, so a run that skips them leaves their defects with nobody,
and filing a clear defect spends the owner's attention on a fix the
rules already decide. The corpus and the coding standards move only
through an approved sprint, and the harness settings govern the
owner's own sessions, so changing any of them is the owner's act. A
record is worth keeping only as it was written, and it causes no harm
as it stands.

## Alternatives

- Leave every file in the suite's estates alone — a simple line, and a
  project's own skills and rules kept there get no fixer.
- Fix a suite-owned file in place — fixes the harm soonest, and the
  next converge overwrites the fix.
- Send every defect outside code to the owner — keeps a run narrow, and
  spends the owner's attention on fixes the rules already decide.
- Leave the owner's configuration and review facts alone — each stale
  entry waits for the owner, who never edits them.
