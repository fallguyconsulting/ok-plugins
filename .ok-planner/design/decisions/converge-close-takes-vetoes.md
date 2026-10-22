---
decision: converge-close-takes-vetoes
---

# Every `/converge` close asks which of the run's calls the owner vetoes

## Choice

Every `/converge` run closes the same way, whatever its mode. Its
close presents the table of the calls its agents made without the
owner, beside its offer to archive and commit, and asks which rows the
owner vetoes. It files one issue per vetoed row, with the owner's
words as its ruling, so the next planning session pulls each veto in
as the owner's decision. A run whose agents made no call asks nothing
beyond the offer. In sprint certification, the sprint's execution
steps make this close, over the build's calls and the certification's
together.

## Rationale

The owner is promised a way to see and overturn every call an agent
made in their absence (see also: veto-calls-made-in-my-absence). A
table the owner can read but not act on gives half of that. The close
already waits for the owner's word on the archive and the commit, so
asking about vetoes in the same exchange adds no wait the run does not
have, and the run still never waits on the owner while it finds and
fixes (see also: converge-finds-then-fixes). One close for every mode
keeps one way to overturn a call.

## Alternatives

- Present the calls table with no veto, and leave the owner to file an
  issue by hand: nothing ties the issue to the call's row, and the
  owner overturns a call only by rewriting it.
- Take vetoes in the same answer as the archive-and-commit offer, with
  no question of their own: one reply carries two acts, and the plain
  run's close differs from sprint certification's.
