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
never the source or the database. A driver changes nothing in the
project's tree: a command that may write runs against a scratch copy or
a scratch project, never at the project root. A surface that is a
skill, a prompt the product ships for an agent session to run, is the
one exception to the source rule: a driver cannot run a session's
skill, so it reviews the skill's text and the scripts and tools the
skill calls against the story's intent, and files each divergence as a
failure. A project whose product has no stack declares so in its review
facts, and its drivers run with no stack to start. Nothing about a
drive is written down between runs. A merge agent sorts each failure as
a defect the story or a decision owes, as something the corpus does not
promise, or as a failure of the environment.

## Rationale

A written drive plan breaks whenever the product changes, and keeping
one current is work that grows with the product. A driver that works
from the story derives its path again on every run, so a change that
keeps the story met keeps the drive passing. Driving as a user finds
what a reader of the code misses: a path that works in the code and
that no user can find, or a message that does not say what went wrong.
The cost is that every run pays to drive every story; drive mode is
where a run spends its tokens. Reviewing a skill surface keeps the
drive's frame, the story's promise, for a product whose surface no
driver can operate, so a product of skills is certified by the same
loop as a product of code. A driver that writes at the project root
rewrites the tree the run certifies; a scratch copy gives it the same
product to use with nothing of the run's at stake.

## Alternatives

- A maintained drive script per story, replayed each run — cheap per
  run and repeatable, and each script breaks on any change that keeps
  the story met, so the run fixes scripts instead of the product.
- A separate execution path for products made of skill text, where
  the session builds and reviews in rounds with no drive — a second
  shape to keep, and a project that gains a code surface would have to
  leave it.
- Drivers run their commands at the project root — no copy to make, and
  a writing command rewrites the tree the run certifies.
- Reuse the audit's experiments as the drive — one instrument for two
  jobs, and an experiment is the audit's measurement of a named commit,
  kept by the audit; a fix loop that runs or edits it mixes the
  measurement with the fix.
