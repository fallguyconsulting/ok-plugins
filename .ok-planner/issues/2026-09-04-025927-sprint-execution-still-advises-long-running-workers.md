---
issue: sprint-execution-still-advises-long-running-workers
kind: human
category: conflicting
artifacts: []
status: open
opened: 2026-09-04T09:59:27Z
---

# The sprint execution boilerplate still advises two long-running workers fed by message, while the suite has moved execution onto the task tracker

## Problem

`plugins/ok/families/ok-planner/skills/_shared/sprint-document.md` fixes the "How to execute this sprint" section every sprint carries, and that section still prescribes the pre-tracker execution shape: "a team of two workers the session relays", a builder "dispatched once ... fed one stage per message", a standing reviewer "dispatched once ... fed each landed stage's paths", a retirement band of "roughly 300k to 500k tokens of measured context", and a session that "relays messages between the two workers". `plugins/ok/families/ok-planner/scripts/ok-planner-CLAUDE.md` says the same under "Executing a sprint", and `plugins/ok/rules/ok-cheatsheet.md` repeats it under its own "Executing a sprint" heading. `{{STANDING-REVIEWER-PROMPT}}` and `{{WORKER-POOL-RULE}}` carry the supporting protocol.

The same estate now describes the task tracker (`bin/tasks`, the `ok-opus` / `ok-sonnet` / `ok-haiku` profiles, `/execute-tasks`) as the way an orchestrating session drives agents, and the staged work in this tree moves the audit onto it (`ok-audit`, "auditors, filed as tasks"). Nothing in the sprint boilerplate, the "Executing a sprint" prose, or the certification core names the tracker, its profiles, or `/execute-tasks`. The boilerplate's only task reference is to the harness task tools, and it limits them to display: "The task list is display; the report remains the record." An executor that reads the sprint as written dispatches long-running workers.

Observed on 2026-09-04 in `linescout/platform` executing `2026-09-04-remove-line-topology` under `/goal`: the session dispatched one `opus` builder and one `opus` standing reviewer per the boilerplate; the builder crossed 305k tokens of context inside its first stage, where the boilerplate allows no hand-off; the owner stopped the run and asked why the sprint still advised long-running agents.

## Candidates

- Rewrite the sprint boilerplate, the "Executing a sprint" prose in both CLAUDE files and the cheatsheet, and `{{STANDING-REVIEWER-PROMPT}}` so a sprint executes as a tracker run: the session files one task per stage plus review and fix tasks, `/execute-tasks` drains them with the vendored profiles, and each agent starts fresh from the sprint, the report, and the ledger file. Retire `{{WORKER-POOL-RULE}}`'s retirement band from the sprint path.
- Keep the message-fed team as the sprint's shape and state in the boilerplate that the tracker is the audit's instrument only, so the two coexist by declaration.
