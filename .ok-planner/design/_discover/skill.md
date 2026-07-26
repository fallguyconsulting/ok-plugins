---
topic: skill
kind: concept
---

# Skill (SKILL.md prompt files) and the slash-command-only activation convention

## Description

A **skill** is one directory `skills/<name>/SKILL.md` inside a plugin: YAML frontmatter (`name`, `description`) followed by a markdown prompt body that is the executable substance of the plugin. Skills are invoked via the Skill tool with the plugin-namespace prefix (`ok-planner:true-up`, `ok-plumbline:audit`) or by the user typing the slash command. The prompt text is treated as code by this project: it carries process steps, embedded subagent prompts, embedded bash blocks to run verbatim, output formats, and — a house convention — a closing "What this skill does NOT do" section enumerating negative behavior (present in nearly every ok-planner and ok-workspaces skill).

The load-bearing activation convention: user-facing skills carry the frontmatter phrase **"ONLY activated by explicit /X slash command. Never auto-triggered by conversation content."** ok-planner's CLAUDE.md marks this as deliberate: "the 'ONLY activated by explicit slash command' phrasing in `description` is load-bearing — it prevents Claude from invoking skills inferentially. Preserve it on new skills." The per-plugin index skills restate it in body text ("Do NOT invoke skills based on inference about what the user might want. Wait for the slash command."). Some skills widen the activator to a named non-human caller: `/audit` and `/prove` add "or by whoever is executing a sprint's completion contract — an inline session or an orchestrator"; `/certify` adds "or as the terminal step named in the sprint document's execution boilerplate"; ok-workspaces `/open`/`/close` add "(or by an orchestrator starting/finishing a defined job)".

A distinct second class — **plumbing skills** — deliberately drop the ONLY-phrase so other machinery can drive them: every `true-up` skill (all three integrable plugins) has a descriptive frontmatter ("Plumbing — normally driven by /ok; also user-invokable as /true-up") because `/ok` invokes them via the Skill tool, and other ok-planner skills invoke `ok-planner:true-up` as their first step. All of ok-plumbline's non-true-up skills (audit, budget, ci, explain, patterns, port, slug, starter, suggest, version) also lack the ONLY-phrase and are written as descriptive wrappers around `plumbline` subcommands.

Skills do not chain into pipelines: "Skills do not chain into a pipeline. `/plan-sprint` is terminal at the approved sprint" (ok-planner CLAUDE.md); `/sketch` ends its turn without chaining; `/ok` invokes only true-up verbs.

## Code surface

- `plugins/*/skills/*/SKILL.md` — 26 skill files total (ok: 1, ok-planner: 9, ok-plumbline: 11, ok-workspaces: 5).
- Frontmatter ONLY-phrase: `plugins/ok/skills/ok/SKILL.md`, ok-planner's plan-sprint / certify / sketch / audit / prove / discover-design / ok-version / ok-planner, ok-workspaces' open / close / audit / ok-workspaces.
- Plumbing descriptions without the phrase: `plugins/*/skills/true-up/SKILL.md` (all three), all ok-plumbline verb wrappers.
- Repo-root (non-distributed) skill with the phrase: `.claude/skills/release/SKILL.md`.

## Prose surface

- `plugins/ok-planner/CLAUDE.md` "How skills are wired" — the load-bearing-phrase rule and the no-pipeline rule.
- Index skills' "When Skills Activate" sections (`plugins/ok-planner/skills/ok-planner/SKILL.md`, `plugins/ok-workspaces/skills/ok-workspaces/SKILL.md`).

## Adjacent topics

- `session-context-injection` — how index skills get into context at session start.
- `true-up-verb` — the plumbing class's main member.
- `transclusion-tokens` — how skill prompts share canonical rule text.

## Observations

- The ONLY-phrase convention is enforced by prose in ok-planner's CLAUDE.md only; no mechanical check exists anywhere in the repo that a new user-facing skill carries it.
- The split between "ONLY-phrase" skills and descriptive plumbing skills is real and consistent, but nothing in the contract or any CLAUDE.md states the rule for *which* class a new skill belongs to; it is inferable only from examples.
- ok-plumbline's `audit` is a compliance verb per the integration contract yet lacks the ONLY-phrase that ok-workspaces' `audit` carries — the two audit verbs are in different activation classes for no stated reason.
