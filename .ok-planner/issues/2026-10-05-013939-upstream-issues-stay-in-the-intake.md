---
issue: upstream-issues-stay-in-the-intake
kind: human
category: tooling
artifacts: []
status: open
opened: 2026-10-05T01:39:39Z
---

# Triage closes an upstream issue out of the consumer's intake, and the run's return hands it to the owner as a step

## Problem

`/triage-issues` closes every issue whose change falls in a suite-owned file. It sets `status: answered`, writes a ready-to-file `## Upstream issue` section, and moves the file to `.ok-planner/history/issues/`. The run's report then lists the file under `to upstream` for the owner to file, and sprint certification copies that list into its return.

The owner of the consumer project linescout wants every issue that needs the owner's attention in the project's intake at the end of a sprint, whatever it is about and wherever its fix lands. The owner reviews the intake later. No issue should reach the owner as an ad hoc step at the end of the work. In linescout's run `converge-2026-10-04T024708`, an issue about the task tracker left the intake this way, and the session's closing summary asked the owner to file it. The owner's words: "at the end of the sprint, all issues that need our attention, whatever they are about, upstream or not, need to be in this project's intake for later review. we don't want any ad hoc discussion at the end of the work. so the triage rule needs to be changed."

The owner also wants no issue, report, or prompt to name the suite by a filesystem path to its checkout: "we also do not want any link to ok-plugins in the form of a path. it just so happens to be local; that won't always be the case."

The rule appears in:

- `plugins/ok/families/ok-planner/skills/triage-issues/SKILL.md`: the description; the routes paragraph ("so it goes upstream"); the `answered` row of the route table, which covers "every issue whose change falls in a suite-owned file", closes it, and moves it to `history/issues/`; and the report's `to upstream` bullet, which lists "the path of its closed file" for the owner to file upstream.
- `plugins/ok/families/ok-planner/skills/triage-issues/prompts/triage.md`: the proposed-entry paragraph and step 2, which route a suite-owned change `answered`, upstream; and the "`answered`, upstream" paragraph, which sets `status: answered` and a Ruling saying "which the owner files there".
- `plugins/ok/families/ok-planner/scripts/ok-planner-cheatsheet.md`: the Verifying section's "`answered`, upstream" bullet, which "hands it to the owner to file upstream".
- `plugins/ok/families/ok-planner/skills/converge/SKILL.md`: the "intent is to fix" paragraph, the paragraph that runs `/triage-issues` before the return, and the `proposal` and `session-note` rows of the item table, which send such a change upstream "for the owner to file there".

## Candidate

An issue whose change falls in a suite-owned file stays in the intake: `status: verified`, `triage: upstream`, a `## Upstream issue` section ready to file, and a recommended ruling to file it with the suite. The next `/plan-sprint` walks it with the other judgment issues, and the owner's ruling closes it once it is filed. Triage reports it under `to /plan-sprint`, not as a step for the owner, and sprint certification's return carries no upstream list. Every issue, report, and prompt names the suite as "the ok suite" and its files by their materialized paths in the consumer project, never by a path to the suite's checkout.

## Ruling
