# ok Cheatsheet

Materialized by ok v18.6.1. Suite-owned: overwritten wholesale by the front door's administration (`/ok`); project-specific rules belong in your own files under `.claude/rules/`.

## Subagent models

Every subagent dispatch names its model: `opus`, `sonnet`, or `haiku`. The session model is never a subagent model. An omitted `model` inherits the session model, and a `fork` always does, so both are refused. Investigation, relevance, and compliance-reading jobs ride `sonnet`; coding, fixing, writing, and review jobs ride `opus`; `haiku` is for mechanical single-shot lookups. This holds for the `Agent` tool and for every `agent()` call in a `Workflow` script. The rule binds whether or not the `PreToolUse` hook at `.claude/hooks/ok-agent-model` is wired; the hook enforces it where the owner has consented to the wiring.
