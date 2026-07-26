---
issue: goal-mechanism-external
kind: discover
category: other
artifacts:
  - decision:no-execution-engine
  - concept:sprint
status: retired
opened: 2026-07-25T02:17:33Z
---

# Suite prose names `/goal`, a harness feature the suite doesn't ship

The execution story ok-planner tells — a sprint is self-driving and can be "handed straight to the native `goal` mechanism" — names `/goal` concretely in at least five live sites across the plugin's CLAUDE.md, the materialized estate template, the hub skill, and the planning ceremony. `/goal` is a Claude Code harness feature, not something this suite ships or controls; if the harness renamed or retired it, five prose sites would go stale at once.

Re-verification found the corpus itself is already clean: `decision:no-execution-engine` says "a goal-driving harness mechanism," and `concept:sprint` describes executors generically ("an inline session, a fan-out of subagents, or an external orchestrator") — no `/goal` anywhere in `design/`. The concrete naming lives entirely in code-side prose and templates, and no corpus rule forbids code from naming a concrete example of a generic capability. The suite's actual host *is* Claude Code; telling users the real command is honest convenience, the same way the docs name `rg` or `git` rather than "a search tool."

## Options

- **Leave as-is** — corpus abstract, host-facing docs concrete. Matches current practice; the staleness risk is confined to prose that a rename would force updating anyway.
- **Generalize the prose sites** — describe the capability generically with `/goal` as a parenthetical example across the four files. Editing work that trades clarity for insulation against a harness change that may never come.

The ruling decides: is concrete `/goal` naming in host-facing prose acceptable, or should it generalize?

## Ruling

> Recommended ruling (/verify-issues): retire — the corpus is already at the right altitude, and concrete `/goal` mentions in host-facing docs and templates are acceptable convenience; no change is warranted.
>
> Rationale: the separation the issue worries about already exists exactly where it matters — durable artifacts are generic, host-facing prose is concrete. Generalizing the prose would make real documentation vaguer today to hedge a hypothetical harness change whose fix would be a mechanical find-and-replace anyway.

<!-- Owner: this is a recommendation, not your decision. Leave it
as-is to accept — the next /plan-sprint carries it, naming the
generated/recommended batches at sign-off. Edit the text to
redirect, empty the section to discuss live, or delete this note
to adopt the ruling as your own. -->

Retired (plan-sprint 2026-07-25, sprint 2026-07-25-ruled-intake-drain): owner accepted the recommended retirement — the corpus is already at the right altitude and concrete host naming in docs is acceptable; nothing to carry into a sprint.
