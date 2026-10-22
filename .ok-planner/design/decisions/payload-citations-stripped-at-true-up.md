---
decision: payload-citations-stripped-at-true-up
---

# A payload script carries its design citations, and true-up strips them from the copy it writes

## Choice

In the suite's own source, a script the front door carries for true-up
to copy into consumer projects carries a design citation at each site
that realizes a concept, story, or decision of the suite's corpus,
like any other code. When true-up copies such a script into a
project, it removes each line that is a citation comment in the
citation grammar, so a consumer's copy carries none. The check that a
payload script stands alone in a bare project reads the copy true-up
would write, not the source. A markdown payload, such as a skill,
carries no citation that resolves in the suite's own corpus, because
its text may show a consumer the annotation's form.

## Rationale

The annotation grep is the index of where each artifact is
load-bearing (see also: code-cites-design), and in the suite's own
source most load-bearing code is payload. A rule that kept citations
out of payload scripts would leave the grep blind where the suite's
behavior lives, and no builder could meet the build rule there. A
consumer's lint resolves only the tags and slugs that consumer
declares (see also: citation-tag), so a citation copied as written
would fail there. True-up already renders every file it copies, so
removing the citation lines is one more rewrite in a step that exists.

## Alternatives

- Copy a payload script's citations as written: a consumer's lint
  flags a tag the consumer never declared, or a slug its corpus lacks.
- Keep every annotation out of payload scripts, and cite a story only
  a payload script realizes from a check or not at all: the annotation
  grep misses the code that realizes the story.
