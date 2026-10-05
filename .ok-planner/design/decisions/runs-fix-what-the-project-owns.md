---
decision: runs-fix-what-the-project-owns
---

# A run leaves five kinds of file alone and fixes every other file the project owns

## Choice

A `/converge` run's agents fix a clear defect in every file the project
owns, wherever the file sits: its code, and its own scripts, skills,
rules, and other tooling, with prose other than skill text in review
only as the skill-text rule allows (see also:
skill-text-is-reviewed-as-code). They leave five kinds of file alone:
the design corpus and the coding standards, which change only through a
sprint's deltas; a file the suite owns; the owner's declarations
(configuration, harness settings, review facts, release boundaries,
surface intent, and document types); a record, such as a sprint, an issue, an audit, an
experiment, or anything archived, which keeps what it said when it was
written and changes only by the act that owns it; and a document the
release regenerates. A defect whose fix lies in the
corpus, the coding standards, or an owner's declaration goes to the
intake as a judgment issue. A harm in a file the suite owns goes to the
intake as an upstream issue (see also:
foreign-harms-become-upstream-issues). A record changes only through
the act that owns it, and a run files nothing about it. A document the release
regenerates is left to the documentation run (see also:
placed-documents-are-records).

## Rationale

The line follows ownership, not location. A file the suite owns is
maintained upstream, and the next converge overwrites a local edit. A
project's own tooling has no maintainer but the project, so a run that
skips it leaves its defects with nobody. The corpus and the coding
standards move only through an approved sprint, and an owner's
declaration says what the project commits to, so changing either is
the owner's act. A record is worth keeping only as it was written.

## Alternatives

- Leave every file in the suite's estates alone — a simple line, and a
  project's own skills and rules kept there get no fixer.
- Fix a suite-owned file in place — fixes the harm soonest, and the
  next converge overwrites the fix.
- Send every defect outside code to the owner — keeps a run narrow, and
  spends the owner's attention on fixes the rules already decide.
