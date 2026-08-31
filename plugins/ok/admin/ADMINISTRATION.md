# Suite administration — the ceremony layer

The judgment `admin/converge` cannot encode, for the one layer that
belongs to no family: the suite's four ceremony verbs. `/ok` drives
this document the same way it drives each family's.

The core is thin because the layer is: four canonical skill bodies,
vendored into every project the suite touches, resolving which estates
are present when they run; one rules file,
`.claude/rules/ok-cheatsheet.md`; and two hooks,
`.claude/hooks/ok-agent-model` and
`.claude/hooks/ok-subagent-batching`. There is no estate to lay out
and no config to declare — beside the hook entries, one env entry the
owner consents to.

## The subagent-model rule and its hook

`.claude/rules/ok-cheatsheet.md` carries one rule: every subagent
dispatch names its model — `opus`, `sonnet`, or `haiku` — and the
session model is never a subagent model, so an omitted `model` and a
`fork` are both refused. The rule binds on its own; the hook enforces
it. `.claude/hooks/ok-agent-model` is a `PreToolUse` hook on the
`Agent` and `Workflow` tools that denies a dispatch with no model, a
model outside the three, a fork, or a Workflow script whose `agent()`
calls name no model or a refused one. Converge materializes both;
the hook executes only through a `PreToolUse` entry in
`.claude/settings.json` (matcher `Agent|Workflow`), written **only** as
transcription of the owner's explicit yes by the core's `wire-hooks`
mode. Diagnose and converge report a missing or drifted entry as a
`WIRING NEEDED` block carrying the exact entry and the exact consent
command; present the block, ask, and on yes run the command. Declined
means declined — record it and write nothing.

## The batching rule and its hook

`.claude/rules/ok-cheatsheet.md` carries a second rule: issue every
independent tool call together in one message, and sequence only a
call whose input depends on a prior call's result. The rule binds the
session on its own; the hook carries it to subagents.
`.claude/hooks/ok-subagent-batching` is a `SubagentStart` hook
(matcher `*`) that injects the rule into every subagent's context at
start as `additionalContext` — it blocks nothing and modifies nothing.
Converge materializes it beside the subagent-model hook; it executes
only through a `SubagentStart` entry in `.claude/settings.json`. The
core's `wire-hooks` mode transcribes both hook entries under one
consent, and both appear in one `WIRING NEEDED` block.

## The task-tools env entry

The second consented settings entry. The Claude 5 model family loads
the harness task-tracking tools only when the project's
`.claude/settings.json` sets `env.CLAUDE_CODE_ENABLE_TODO_TOOLS` to
`"1"`; a sprint's execution shape uses those tools as a live checklist
mirroring the completion report's stages, and without them the owner
watches a long run by opening the report. Diagnose and converge report
a missing or wrong entry as a `WIRING NEEDED` block beside the hook's,
carrying the exact entry and the exact consent command
(`converge wire-env`); present it, ask, and on yes run the command.
Declined means declined — record it and write nothing. The entry is
project-scoped by design: the suite converges projects, not machines.
Env changes take effect in the next session.

## When `.claude/settings.json` is unusable

The core writes no settings entry into a file it cannot read. It
offers no `WIRING NEEDED` block for one. Diagnose reports the state as
a `DRIFT: unusable:` or `DRIFT: unparseable:` line. `wire-hooks` and
`wire-env` refuse with the same line. Six states report this way:

| what the core found | what it leaves unwritten |
|---|---|
| the file holds invalid JSON | every entry |
| the file's top level is not an object | every entry |
| `hooks` is not an object | the hook entries |
| `hooks.PreToolUse` or `hooks.SubagentStart` is not an array | the hook entries |
| a `hooks.PreToolUse` or `hooks.SubagentStart` entry is not an object, its `hooks` is not an array, or one of its hooks is not an object | the hook entries |
| `env` is not an object | the task-tools entry |

Report the line to the owner and name the repair. The owner edits
`.claude/settings.json` so each named key holds the shape the harness
reads: an object for the file, for `hooks`, for each hook entry, and
for `env`; an array for `hooks.PreToolUse` and `hooks.SubagentStart`.
The owner then runs `/ok` again. The core leaves the file alone: it is the owner's,
it carries entries no suite wrote, and a rewrite would risk dropping
them.

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

## When a family's ceremony contribution is missing

Each family exposes `ceremony/plan-sprint.md`,
`ceremony/certify-work.md`, `ceremony/audit.md`, and
`ceremony/document.md`, materialized into its estate at
`.ok-<name>/ceremony/`. A ceremony that finds an estate present but its
contribution absent reports a conformance defect and carries on with
the rest — it never improvises what the family would have said.

That report is an administration question, not a ceremony one: the
remedy is a converge. If an owner brings you one, run `/ok` — the
family's own converge materializes the contribution — and re-run the
ceremony. A contribution still missing after a clean converge means the
family's payload is wrong, which is a defect in the suite rather than
in the project.

## What this layer never does

- Never writes `.claude/settings.json` except through the consented
  `wire-hooks` and `wire-env` paths, and only the two hook entries
  and the one env entry above.
- Never creates or repairs an estate. Which families a project
  integrates is the families' own converge cores' business, driven from
  the same `/ok` run.
- Never decides which estates a ceremony covers. That is read from the
  filesystem when the verb runs, which is what keeps a project correct
  after it adopts a family without converging in between.
