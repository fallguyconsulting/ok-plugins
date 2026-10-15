---
decision: drive-tries-each-story-as-a-user
---

# A drive tries each story as a user, with no written plan

## Choice

`/converge` in drive mode and sprint certification each give every
story its own driver once per run. The driver reads the story's role,
capability, and benefit, and works out from the running product how to
get the benefit on every surface the story is offered through. On each
surface it drives every variant the story's own text names, such as
each way a story says its results can be narrowed, and judges each
variant on its own, as it judges each surface. It acts in the order a
first-time user would. It reports each variant it drove, so the merge
sees what a pass covers. It uses only what a user
in that role has: the public surface and what the product tells a user,
never the source or the database. A driver changes nothing in the
project's tree: a command that may write runs against a scratch copy or
a scratch project, never at the project root. A surface that is a
skill, a prompt the product ships for an agent session to run, is the
one exception to the source rule: a driver cannot run a session's
skill, so it reviews the skill's text and the scripts and tools the
skill calls against the story's intent, and files each divergence as a
failure. A project whose product has no stack declares so in its ok-planner
configuration, and its drivers run with no stack to start. Nothing about a
drive is written down between runs. A merge agent sorts each failure as
a defect the story or a decision owes, as something the corpus does not
promise, or as a failure of the environment. In sprint certification, a
failure the sprint's change caused is fixed before the sprint closes,
and a failure in code the change did not reach goes to the intake
(see also: defects-outside-scope-become-defect-issues).

## Rationale

A written drive plan breaks whenever the product changes, and keeping
one current is work that grows with the product. A driver that works
from the story derives its path again on every run, so a change that
keeps the story met keeps the drive passing. Driving as a user finds
what a reader of the code misses: a path that works in the code and
that no user can find, or a message that does not say what went wrong.
The cost is that every run that drives pays to drive every story; the
drive is where a run spends its tokens. Sprint certification drives
every story, not only the stories its sprint adds or amends, because a
sprint can break a story it does not name, and its own certification
is where that fix is in scope. A failure in older code then reaches the
intake at the close that meets it, so a later sprint never meets it as
a surprise. The cost is a full drive at every certification. The story
bounds a drive because the story is the promise certification judges:
driving each variant its text names widens the drive exactly as far as
the owner's own words go, and needs nothing written down. Acting in a
first-time user's order finds a failure that waits on a fresh start,
such as the first control a new user presses. Reviewing a skill surface keeps the
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
- Certification drives only the stories its sprint adds or amends —
  a cheaper close, and a story broken by earlier work, or by a sprint
  that does not name it, stays undriven until the owner starts a full
  drive.
- Certification drives the sprint's stories and every story whose
  citing code the change touched — cheaper, and its reach ends where
  the annotations end.
- A full drive gates each planning session — the same cost per sprint,
  and a sprint's own regression surfaces only after the sprint closed.
- A driver stops at the first path that delivers the benefit —
  cheapest, and a pass can hide a failing variant the story names.
- A driver lists every path on each surface, each flag, control, and
  order of actions, and drives each — bounded only by the product's
  size, and the merge must judge a list's completeness with nothing to
  judge it against.
- Two independent drivers per story — twice the cost, with no
  assurance the second driver takes another path.
