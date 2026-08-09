# Suite administration — the ceremony layer

The judgment `admin/converge` cannot encode, for the one layer that
belongs to no family: the suite's four ceremony verbs. `/ok` drives
this document the same way it drives each family's.

The core is deliberately thin because the layer is: four canonical
skill bodies, vendored into every project the suite touches, resolving
which estates are present when they run rather than when they were
written. There is no estate to lay out, no config to declare, and no
hooks to wire.

## When this layer converges

Always, and before the families. A project that carries any estate is
entitled to the ceremonies, and a project that carries none still gets
them — they resolve to "no estate in scope, nothing to do" and say so,
which is a better answer than a missing verb. Converging first also
means that if a family's converge fails, the owner still has the verbs
to see what state the project is in.

## The collision rule, after the hoist

Read the integration contract's collision rule with this in mind: it
governs verbs **more than one family claims**, and the four ceremony
verbs are claimed by none. They vendor under their bare names —
`plan-sprint`, `certify-work`, `audit`, `document` — in every project,
and no family may introduce a verb by any of those names. A family that does
has conformed wrong; report that rather than accommodating it with a
prefix.

## Retired vendored verbs

The hoist replaced four vendored verbs, and converge removes each on
sight — all suite-owned, so removal is converge's own act and never a
consent question:

| retired | replaced by |
|---|---|
| `ok-planner-audit` | `audit` |
| `ok-plumbline-audit` | `audit` |
| `ok-workspaces-audit` | `audit` |
| `verify-corpus` | `audit` |

The first three were the same verb name claimed by three families and
materialized family-prefixed under the collision rule; the fourth was
the separate periodic run. All four are now one body that resolves
estates at invocation and records both the compliance and the support
axis.

A project whose owner had a habit of typing one of the retired names
will find it gone after a converge. Say so in the run's report — it is
the one user-visible break the hoist causes, and it costs one sentence
to name.

## When a family's ceremony surface is missing

Each family exposes `ceremony/plan-sprint.md`,
`ceremony/certify-work.md`, `ceremony/audit.md`, and
`ceremony/document.md`, materialized into its estate at
`.ok-<name>/ceremony/`. A ceremony that finds an estate present but its
surface absent reports a conformance defect and carries on with the
rest — it never improvises what the family would have said.

That report is an administration question, not a ceremony one: the
remedy is a converge. If an owner brings you one, run `/ok` — the
family's own converge materializes the surface — and re-run the
ceremony. A surface still missing after a clean converge means the
family's payload is wrong, which is a defect in the suite rather than
in the project.

## What this layer never does

- Never writes `.claude/settings.json`. The ceremony layer declares no
  hooks, so it has no consent path and needs none.
- Never creates or repairs an estate. Which families a project
  integrates is the families' own converge cores' business, driven from
  the same `/ok` run.
- Never decides which estates a ceremony covers. That is read from the
  filesystem when the verb runs, which is what keeps a project correct
  after it adopts a family without converging in between.
