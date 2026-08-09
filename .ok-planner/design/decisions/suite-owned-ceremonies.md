---
decision: suite-owned-ceremonies
---

# Planning, certification, audit, and documentation are suite verbs scoped by estate

## Choice

Planning, certification, audit, and documentation are suite-owned verbs
rather than any family's: one canonical body each, vendored into
consumer projects like every other skill, covering whichever estates
the project has. Which estates those are is read at invocation from the
filesystem markers, never fixed at vendoring time. Each family contributes its
ceremony-specific instructions from inside its own directory, as a
conventional surface the ceremony drives — the counterpart, on the
ceremony axis, of the administration surfaces the front door drives.

## Rationale

The suite had already hoisted one axis this way: families expose no
administration verbs of their own, because administration is what the
front door does by driving conventional surfaces. Ceremonies were the
axis that had not been hoisted, and the cost showed in the collision
rule — three families each claiming `audit`, materializing
family-prefixed, leaving the owner to know which family owns which
verb and to run the same ceremony once per family.

Reading estate presence at invocation rather than at vendoring keeps a
project correct after it adopts a family later, without a converge in
between. Keeping the ceremony body thin and delegating to per-family
surfaces is what stops every project from vendoring every family's
instructions: a skill body is context an agent pays for on every read,
which is why the contract already keeps unrelated content out of one.

## Alternatives

- Ceremonies stay family-owned and each family implements its own —
  no new contract surface, and the owner runs every ceremony once per
  family and reconciles the results.
- Ceremonies live in the front-door plugin rather than being vendored
  — simplest to maintain, and it breaks self-containment: a clone with
  nothing installed loses its ceremonies.
- One hoisted body carrying every family's instructions inline —
  no per-family surface to design, paid for in context on every read
  in every project, whether or not the family is present.
