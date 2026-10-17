---
decision: administration-is-a-user-act
---

# Administration runs only when a user asks, never from a hook

## Choice

The front door's administration runs only when a user invokes it, or
when an agent the user directed does. Nothing in the suite runs it
from a hook, and no ceremony calls it. Invoking it is itself the
authorization for every true-up step that destroys nothing. A plan
that holds a destructive step waits for the owner's one answer before
any write, and the questions that ask the owner for input come after
the plan runs (see also: true-up-asks-once-before-destructive-steps).

## Rationale

Administration writes files across the project and changes what every
later session runs, so it belongs at a moment the owner is watching. A
hook fires it at session start or on an edit, which is exactly when
nobody is watching. It also turns a deliberate upgrade into an ambush
in the middle of someone else's task. Tying the authorization to the
invocation lets the run true up its own territory in silence where it
destroys nothing, and puts the owner's one question in front of an
owner who is there to answer it.

## Alternatives

- True up from a session-start hook — every session runs a current
  suite layer, and that layer changes underneath work in progress with
  no owner present.
- Have each ceremony true up what it needs before running — the estate
  is never stale for the verb about to use it, and a planning session
  becomes an upgrade the owner did not ask for.
- Fire administration on a schedule or on plugin update — updates
  arrive without prompting, and land in whatever checkout happens to be
  open.
