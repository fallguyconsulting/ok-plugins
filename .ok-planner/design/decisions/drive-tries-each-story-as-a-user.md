---
decision: drive-tries-each-story-as-a-user
---

# A drive tries each story as a user, with no written plan

## Choice

Every drive gives each story it takes its own driver, once per run.
Which runs drive, and which stories each takes, are decisions of their
own (see also: one-drive-procedure-fixes-nothing,
certification-drives-what-the-sprint-changes). The driver reads the story's
role, capability, and benefit, and works out from the running product
how to get the benefit on every surface the story is offered through.
On each surface it drives every variant the story's own text names,
such as each way a story says its results can be narrowed, and judges
each variant on its own, as it judges each surface. It acts in the
order a first-time user would. It reports each variant it drove, so
the merge sees what a pass covers. It uses only what a user in that
role has: the public surface and what the product tells a user, never
the source or the database. In place of a party outside the product
that a story's benefit passes through, the driver uses the local
stand-in the review facts name for that party (see also:
work-items-change-the-product). No step of a drive waits on a person.
A driver changes nothing in the project's tree: a command that may
write runs against a scratch copy or a scratch project, never at the
project root. A surface that is a skill, a prompt the product ships
for an agent session to run, is the one exception to the source rule:
a driver cannot run a session's skill, so it reviews the skill's text
and the scripts and tools the skill calls against the story's intent,
and files each divergence as a failure. A project whose product has no
stack declares so in its review facts, and its drivers run with no
stack to start. Nothing about a drive is written down between runs. A
merge agent sorts each failure as a defect the story or a decision
owes, as something the corpus does not promise, or as a failure of the
environment. In sprint certification, a failure the sprint's change
caused is fixed before the sprint closes, and a failure in code the
change did not reach goes to the intake (see also:
defects-outside-scope-become-defect-issues). A fix to a drive-found
defect that its verifier accepts gets one confirm driver per defect,
not one per story. The confirm driver drives every story the defect
names, on the surface and by each variant the defect names, and gives
one verdict: the defect is confirmed only where every story it names
succeeds, and is sent back otherwise, with a note that names each
story that failed. A drive-found defect a verifier accepts as a
duplicate of another defect is confirmed once that other defect's fix
is verified, by one confirm driver per story and surface the
duplicates name: the verified defect is confirmed only once every
such driver gets its story, and a driver that fails sends the verified
defect back with a note naming its story.

## Rationale

A written drive plan breaks whenever the product changes, and keeping
one current is work that grows with the product. A driver that works
from the story derives its path again on every run, so a change that
keeps the story met keeps the drive passing. Driving as a user finds
what a reader of the code misses: a path that works in the code and
that no user can find, or a message that does not say what went wrong.
The cost is that every run that drives pays to drive each story it
takes; the drive is where a run spends its tokens. The
story bounds a drive because the story is the promise certification
judges: driving each variant its text names widens the drive exactly
as far as the owner's own words go, and needs nothing written down.
Acting in a first-time user's order finds a failure that waits on a
fresh start, such as the first control a new user presses. Reviewing a
skill surface keeps the drive's frame, the story's promise, for a
product whose surface no driver can operate, so a product of skills is
certified by the same loop as a product of code. A driver that writes
at the project root rewrites the tree the run certifies; a scratch
copy gives it the same product to use with nothing of the run's at
stake. One confirm verdict per defect matches the unit the fix loop
counts: the loop counts send-backs per drive defect, and restores a
change when one drive defect reaches its limit, as for every defect
but one the suite found. A merge may fold failures with one cause on
several stories into one defect, and a confirm driver per story would
then need a mark per story and a rule that clears every mark on a
send-back, to gain only a record of which story failed, which the
confirm driver's note carries. A verifier may fold a drive failure
into a defect another finder reported, and the story is met only when
a driver gets what it promises, so the fold still earns the story a
confirm drive. The fold is the one place a confirm takes a driver per
story and surface. Each folded defect came from another story's or
another surface's drive, so a driver of the verified defect's own
story would not try again the break the folded defect saw, and that
cost buys the only check of it. The mark stays one: the verified
defect is confirmed once every such driver gets its story, and a
driver that fails sends that one defect back with a note naming its
story, so no story holds a mark of its own and a send-back clears
nothing else.

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
- A driver stops at the first path that delivers the benefit —
  cheapest, and a pass can hide a failing variant the story names.
- A driver lists every path on each surface, each flag, control, and
  order of actions, and drives each — bounded only by the product's
  size, and the merge must judge a list's completeness with nothing to
  judge it against.
- A person completes a third party's step, such as a consent screen,
  while the driver waits — the drive tries the real service, and the
  run stops until a person is present.
- Two independent drivers per story — twice the cost, with no
  assurance the second driver takes another path.
- One confirm driver per story, a defect confirmed only when every
  story's driver confirms it — a verdict per story, and the confirmed
  mark becomes a set of marks that every send-back must clear.
