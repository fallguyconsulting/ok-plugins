---
story: trace-corpus-to-code
---

# See which code each story and decision actually claims

## Story

As someone working on a project the planner governs, I want to see which code each live story and decision claims, and which sources nothing claims at all, so that I can judge what the project's durable model actually covers without re-deriving it from audit prose.

## Acceptance

The reader opens the project's corpus view → every live story and decision is listed with its audit determination, and opening one shows the code that audit cites, excerpted in place; from any source file the reader sees which stories and decisions claim which of its regions, and which regions nothing claims; and the sources carrying no claim at all are reachable as a view of their own rather than left implicit. A claim over a whole file is shown as the file-level claim it is, never as a claim over each of its lines. The determinations, citations, and code are the project's real ones, resolved by the project's own materialized audit checker, so the view never contradicts what that project's certification gate reports.

## Falsifier

The view shows an artifact claiming code its audit does not cite, or marks code as claimed that no citation reaches; a whole-file claim is rendered as if every line served the artifact; sources nothing claims are invisible, so the corpus reads as fully covered; or the view reports a citation current that the project's own checker reports stale.

## Proof

Demo — on a project with a live corpus: a third party opens a story, sees the code its audit cites excerpted, follows it into that file, sees the same story claiming that region alongside a region nothing claims, reaches the uncited sources as their own view, and observes the view's verdict for a deliberately broken citation agreeing with the checker's.
