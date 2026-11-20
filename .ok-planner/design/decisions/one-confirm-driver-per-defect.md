---
decision: one-confirm-driver-per-defect
---

# A verified drive defect gets one confirm driver and one verdict

## Choice

A fix to a drive-found defect that its verifier accepts gets one
confirm driver per defect, not one per story. The confirm driver
drives every story the defect names, on the surface and by each
variant the defect names, and gives one verdict: the defect is
confirmed only where every story it names succeeds, and is sent back
otherwise, with a note that names each story that failed. A
drive-found defect a verifier accepts as a duplicate of another defect
is confirmed once that other defect's fix is verified, by one confirm
driver per story and surface the duplicates name: the verified defect
is confirmed only once every such driver gets its story, and a driver
that fails sends the verified defect back with a note naming its
story.

## Rationale

One confirm verdict per defect matches the unit the fix loop counts:
the loop counts send-backs per drive defect, and restores a change
when one drive defect reaches its limit, as for every defect but one
the suite found. A merge may fold failures with one cause on several
stories into one defect, and a confirm driver per story would then
need a mark per story and a rule that clears every mark on a
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

- One confirm driver per story, a defect confirmed only when every
  story's driver confirms it — a verdict per story, and the confirmed
  mark becomes a set of marks that every send-back must clear.
- A folded duplicate is confirmed by the verified defect's own confirm
  driver alone — one driver, and the break the folded defect saw on
  another story or surface goes untried.
