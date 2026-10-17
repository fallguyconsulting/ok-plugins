---
decision: issues-read-cold-before-the-owner
---

# Every issue gets a cold clarity read before the owner rules on it

## Choice

Every `/triage-issues` run gives each routed or ruled open issue a
clarity pass where no pass has read its current text. An agent that
did not write the text reads it as an engineer who does not know the
project, rewrites its title and problem in one shape, and checks each
fact it states against the project as it stands. The title names the
cause. The problem leads with the cause and then the harm, gives the
context from the top with each project term defined where it first
appears, says what happened, and ends with what the ruling decides.
A stale fact is rewritten, and where it changes the options or the
recommendation, they are revised with it. Each rewrite of a routed or
ruled issue records an update message. The pass stamps the issue with
a digest of the text it read, so an issue is read again only once its
text changes.

## Rationale

The owner rules from the issue's text, and issues reach the intake
from many writers: `/converge`'s owner list, the audit's judge, a
build task, a person. One pass at the end holds them all to the same
shape. A writer cannot see what a cold reader lacks, and reads past
its own ambiguous sentences, so the pass is a different agent. A
style pass alone would make a false sentence read better, so the pass
checks facts too (see also: issue-citations-are-links, see-new-analysis
under stories).

## Alternatives

- Hold each writer to the shape and add no pass — every writer's
  prompt carries the rule, and nothing catches an issue a person or a
  new writer files.
- Let the author reread its own text — one agent fewer, and it reads
  past what it already knows.
- Check style and leave facts alone — a cheaper pass, and a stale
  fact then reads as clearly as a true one.
