---
decision: deferred-verdict-handed-off-through-the-intake
---

# A deferred verdict's handoff is the issue id the run records beside it

## Choice

When the owner list files the issue for a deferred product-slow
verdict, or finds one already standing for the verdict's site, it
records that issue's id in the sprint certification's run beside the
verdict. Sprint certification counts a deferred verdict as handed off
where the run records an issue id beside it. The check reads neither
the intake nor any issue's text, so a later close of the issue, in any
state, changes nothing (see also:
product-slow-fixes-ride-a-round-that-runs-anyway).

## Rationale

The handoff happens once, when the owner list files or finds the
verdict's issue, so the run's own record of that act is its evidence.
A check of the live intake changes its answer whenever a later run or
sprint closes the issue, and a match of issue text against the site
depends on how the issue's author worded it. A recorded id keeps a
certified verdict stable, so done means the same on every check.

## Alternatives

- Count an open issue that names the site: a later sprint that
  promotes and closes the issue turns a certified sprint not complete
  though nothing in it changed.
- Count an open issue, or one closed as promoted into a sprint, that
  names the site: a run that fixes the issue and closes it `fixed`
  turns a certified sprint not complete.
- Count an open, promoted, or fixed issue that names the site: one
  more close state to track, and the check still reads the live intake
  and matches issue text against the site.
- Count any issue that names the site, in any close state: an issue
  retired or answered without a fix passes a verdict no sprint took
  up, and the check still matches issue text against the site.
