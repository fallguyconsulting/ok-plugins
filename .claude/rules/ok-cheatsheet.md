# ok Cheatsheet

Materialized by ok v19.0.0. Suite-owned: overwritten wholesale by the front door's administration (`/ok`); project-specific rules belong in your own files under `.claude/rules/`.

## Subagent models

Every subagent dispatch names its model: `opus`, `sonnet`, or `haiku`. The session model is never a subagent model. An omitted `model` inherits the session model, and a `fork` always does, so both are refused. Investigation, relevance, and compliance-reading jobs ride `sonnet`; coding, fixing, writing, and review jobs ride `opus`; `haiku` is for mechanical single-shot lookups. This holds for the `Agent` tool and for every `agent()` call in a `Workflow` script. The rule binds whether or not the `PreToolUse` hook at `.claude/hooks/ok-agent-model` is wired; the hook enforces it where the owner has consented to the wiring.

## Executing a sprint

A sprint's "How to execute this sprint" section is the brief, and every executor runs one shape: the session relays a team, opens the completion report with the staged list before the build, marks the closing stages after the team retires, and edits no file a worker owns during the build. One builder (`opus`), fed a stage per message, writes the code, applies the deltas, tests what it built, keeps the completion report, and fixes the standing reviewer's findings. One standing reviewer (`opus`), fed each landed stage's paths, reads the increment under the certification gate's own code-review brief plus each family's **Standing producers**, and keeps a ledger. Workers retire only at a stage boundary, inside a band of roughly 300k to 500k tokens of measured context on a 1M-token window, and hand off through the report and the ledger file beside it. The harness task tools, where available, mirror the report's stages as a live checklist. Code complete means the built work works and the reviewer's ledger is empty; `/certify-work` runs immediately after, cold, as the regression.
