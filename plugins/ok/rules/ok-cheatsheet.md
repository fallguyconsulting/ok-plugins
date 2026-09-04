# ok Cheatsheet

Materialized by ok v{{OK_VERSION}}. Suite-owned: overwritten wholesale by the front door's administration (`/ok`); project-specific rules belong in your own files under `.claude/rules/`.

## Subagent models

Every subagent dispatch names its model: `opus`, `sonnet`, or `haiku`. The session model is never a subagent model. An omitted `model` inherits the session model, so it is refused. A `fork` inherits its caller's model. The session never forks. A subagent whose profile under `.claude/agents/` pins one of the three may fork itself; the audit profile forks so a group of items shares one reading. A vendored profile spawns nothing but such forks. The hook cannot tell a fork from the profile agent that spawned it, so the rule that a fork never forks binds by the profile's text alone. Investigation, relevance, and compliance-reading jobs ride `sonnet`; coding, fixing, writing, and review jobs ride `opus`; `haiku` is for mechanical single-shot lookups. This holds for the `Agent` tool and for every `agent()` call in a `Workflow` script. The rule binds whether or not the `PreToolUse` hook at `.claude/hooks/ok-agent-model` is wired; the hook enforces it where the owner has consented to the wiring.

## Batch independent tool calls

Issue every independent tool call together in one message — several reads, searches, edits, or dispatches in one turn — and sequence only a call whose input depends on a prior call's result. One message is one model request that re-reads the session's whole context, so a long session's cost follows its request count, not its call count. This binds the session and every subagent it dispatches. The rule binds whether or not the `SubagentStart` hook at `.claude/hooks/ok-subagent-batching` is wired; where the owner has consented to the wiring, the hook injects the rule into every subagent's context at start.

## Prefer the LSP for symbol navigation

For a symbol question — a definition, a symbol's references, a file's symbol list, a hover type — call the `LSP` tool instead of grep. The tool is deferred: load it once with `ToolSearch("select:LSP")`, then call it. One `LSP` call answers what several greps and file reads approximate, at one request. Grep remains right for text that is not a symbol. This binds the session and every subagent it dispatches. The rule binds whether or not the `SubagentStart` hook at `.claude/hooks/ok-subagent-batching` is wired; where the owner has consented to the wiring, the hook injects the rule into every subagent's context at start.

## Executing a sprint

A sprint's "How to execute this sprint" section is the brief, and every executor runs one shape on the task tracker at `.ok-planner/bin/tasks`. The session plans: it reads the sprint and the code, cuts the work into stages — each the smallest change that makes progress toward the completion contract and leaves the tree runnable — and files one build task and one review task per stage under the vendored profiles, with the files each may touch and the stages it builds on. The `execute-tasks` loop drains them: a fresh agent per task, one cached prefix per profile. A review's findings become fix tasks and a re-review, under a bound of three rounds per stage. The session builds nothing itself and renders the completion report from the run file before every dispatch. Code complete means every stage's findings pool is empty; `/certify-work` runs immediately after, cold, as the regression, on the same run.
