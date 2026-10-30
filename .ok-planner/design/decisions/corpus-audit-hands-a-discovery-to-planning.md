---
decision: corpus-audit-hands-a-discovery-to-planning
---

# The corpus audit asks nothing and hands one discovery to the planning session

## Choice

`/discover-design` audits a project's code against its design corpus,
whether the corpus is empty or out of date, in one run on the task
tracker that asks the owner nothing. It drafts each corpus delta the
code and the rules settle, and each question only the owner can
answer, with both answers: the code is right and the corpus changes,
or the corpus is right and the code changes. Where a question asks
about an artifact the corpus lacks, each answer drafts the artifact's
body: as the code has it under the first answer, and as the text at
issue has it once the code matches under the second, so either answer
adds the artifact to the corpus. A review of the drafts
fixes each finding the rules decide and turns any other finding into
a question, so the discovery carries no open finding.

The run hands over one discovery, a document among the estate's
records: the commit the audit read, each question with
both answers, each change that changes a promise, each change that
changes only form, and each call an agent made. The run writes no
file of the corpus, the coding standards, the docspecs, or the
surface intent, files no issue, and changes no code. One discovery
stands at a time: a second run refuses until the owner takes the
standing one up or drops it.

The owner takes a discovery up by naming its file to `/plan-sprint`.
That session walks each question with the owner, carries each
form-only change without discussion, drafts each promise change into
the sprint, and lists each promise change for the owner's veto at
approval. The corpus changes only when that sprint is applied. The
notes an earlier release's discovery run left are archived by true-up
(see also: whole-file-ownership).

## Rationale

The corpus changes only through an approved sprint (see also:
final-form-deltas), so an audit that drafts into a document the
planning session takes up keeps one path for corpus change and one
sign-off. A run that asks nothing can work through a large codebase on
the task tracker with the owner away, and the owner's whole discussion
happens once, in planning, where every other change to the corpus is
discussed. Drafting a missing artifact under both answers puts every
body the owner may carry under the audit's review, and leaves no
answer that fixes the code while the corpus still lacks the artifact,
which the next audit would propose again. The same run serves an empty
corpus and a stale one, because both are a gap between the code and
what the corpus says. Fixing the findings the rules decide before the
discovery is assembled keeps the owner's attention on questions that
need a judgment. One discovery at a time keeps the hand-off whole: a
second audit over a corpus a standing discovery has not yet changed
would draft the same changes again, and two discoveries would ask the
owner the same questions twice.

## Alternatives

- Write the corpus directly and file the open questions to the
  intake: the owner reviews generated catalogs after the fact, the
  corpus changes outside a sprint, and the questions reach the intake
  outside its gates.
- Ask the owner during the run: the run stalls on each question, and
  the owner answers each one without the whole audit in view.
- Let several discoveries stand at once, or let a new run supersede
  the standing one: the owner meets the same question in two
  documents, or loses the answers a planning session has not yet
  taken up.
- Refuse to run over a populated corpus: a stale corpus has no way to
  catch up with its code but the reconcile of one sprint at a time.
- Draft a missing artifact only under the answer that the code is
  right: the other answer fixes the code alone, the corpus still lacks
  the artifact, and the next audit asks the same question again.
- Let the planning session draft a missing artifact from a sentence
  under the answer that the code is wrong: the owner reviews a body no
  review read.
