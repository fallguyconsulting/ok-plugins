---
decision: drive-tries-each-story-as-a-user
---

# A drive tries each story as a user, with no written plan

## Choice

`/converge` in drive mode gives every story its own driver once per
run, and sprint certification does the same for the stories a sprint
adds or amends. The driver reads the story's role, capability, and
benefit, and works out from the running product how to get the benefit
on every surface the story is offered through. It uses only what a user
in that role has: the public surface and what the product tells a user,
never the source or the database. Nothing about a drive is written down
between runs. A merge agent sorts each failure as a defect the story or
a decision owes, as something the corpus does not promise, or as a
failure of the environment.

## Rationale

A written drive plan breaks whenever the product changes, and keeping
one current is work that grows with the product. A driver that works
from the story derives its path again on every run, so a change that
keeps the story met keeps the drive passing. Driving as a user finds
what a reader of the code misses: a path that works in the code and
that no user can find, or a message that does not say what went wrong.
The cost is that every run pays to drive every story; drive mode is
where a run spends its tokens.

## Alternatives

- A maintained drive script per story, replayed each run — cheap per
  run and repeatable, and each script breaks on any change that keeps
  the story met, so the run fixes scripts instead of the product.
- Reuse the audit's experiments as the drive — one instrument for two
  jobs, and an experiment is the audit's measurement of a named commit,
  kept by the audit; a fix loop that runs or edits it mixes the
  measurement with the fix.
