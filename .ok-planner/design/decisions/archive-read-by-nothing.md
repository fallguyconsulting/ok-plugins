---
decision: archive-read-by-nothing
---

# Nothing reads the archive on its own, and the tools' bookkeeping lives in live files

## Choice

Each archive step moves a closed record into the archive, and true-up
also moves there the content it retires. No skill, script, hook, or
agent reads the archive on its own. An
agent reads an archived record only when the owner directs it, and a
skill and its script read one only at a path the owner names, as an
agent does on the owner's word. Neither reads one to learn the
project's current state (see also: records-stay-out-of-context). Each fact a tool needs about closed work
lives in a live bookkeeping file outside the archive:

- The closed-record ledger names each closed sprint, each closed
  documentation sprint, and each test sprint an earlier release
  closed, with its closing commit, the name of each archived sketch,
  and each name true-up moved into the archive (see also:
  closing-commit-baseline).
- The closed-issue file holds the record of each closed issue (see
  also: closed-issues-leave-the-live-file).
- The test-plan folder holds the test plan of each closed sprint,
  which a later sprint's planning reads for the calls an earlier plan
  made (see also: sprints-plan-what-their-work-reaches).

Each archive step writes the bookkeeping before it moves a file into
the archive, and picks the name it moves a file to from the
closed-record ledger and the other live records, never by looking at
what the archive holds. True-up treats bookkeeping an earlier release
kept in the archive as an earlier layout. It writes each bookkeeping
file from what the archive holds, once, and moves the closed-issue
file, and the test plan of each sprint the closed-record ledger lists
with a commit, out of the archive (see also:
skills-read-only-the-current-layout). That migration is the one read
of the archive a tool makes on its own. True-up infers nothing about
the owner's intent from the archive. How the archive lays out what it
keeps is a decision of its own (see also: whole-file-ownership).

## Rationale

An archived record says what a past run did. It does not say what the
project is now. A tool that reads it to decide the present carries a
past state into the present. On one project, the true-up check read
the folders an archived sprint once changed, drafted them into the
owner's folder list against the owner's own rule, and drafted them
again on every true-up after the owner declined. Writing the
bookkeeping before the move gives each tool one small live file to
read, so no agent and no tool opens the archive to learn the project's
state. A name drawn from a live record keeps each archive step from
reading the archive to find a free name. The migration may read the
archive once because the facts there are the suite's own records in
an earlier place: copying them out changes no commitment and guesses
at nothing the owner meant. The records are the owner's, so an agent
the owner directs, or a skill given a path the owner names, may read
one, as to recover work the archive keeps; what the project is now
still comes from the corpus and the code.

## Alternatives

- Tools read the archive where they need a fact about closed work: no
  bookkeeping file to keep, and every such tool depends on the
  archive's layout and draws present decisions from past records.
- Keep each fact both in the archived record and in a live file: each
  fact has two homes, and the two can disagree.
- Leave an earlier release's bookkeeping in the archive and start the
  live files empty: a project loses its baseline, its closed issues,
  and its earlier plans' calls at its first true-up.
- Pick each archive name by probing the archive for a free one: every
  archive step reads the archive.
- Forbid every read of the archive, the owner's direction included:
  the owner reaches an archived record only by hand.
