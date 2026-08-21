---
decision: administration-is-a-user-act
---

# Administration runs only when a user asks, never from a hook

## Choice

The front door's administration runs only when a user invokes it, or
when an agent the user directed does. Nothing in the suite runs it
from a hook, and no ceremony calls it. Invoking it is itself the
authorization to converge the suite-owned layer and to migrate the
suite's own retired layouts; consent inside the run is reserved for
genuine collisions, for content the suite does not own, and for
transcription into owner-declared configuration.

## Rationale

Administration writes files across the project and changes what every
later session runs, so it belongs at a moment the owner is watching. A
hook fires it at session start or on an edit, which is exactly when
nobody is watching. It also turns a deliberate upgrade into an ambush
in the middle of someone else's task. Tying the migration
authorization to the invocation is what lets the run converge its own
territory in silence without ever acting unasked.

## Alternatives

- Converge from a session-start hook — every session runs a current
  suite layer, and that layer changes underneath work in progress with
  no owner present.
- Have each ceremony converge what it needs before running — the estate
  is never stale for the verb about to use it, and a planning session
  becomes an upgrade the owner did not ask for.
- Fire administration on a schedule or on plugin update — updates
  arrive without prompting, and land in whatever checkout happens to be
  open.
