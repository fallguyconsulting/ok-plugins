---
audit: slash-only-activation
artifact: decision:slash-only-activation
determination: satisfied
audited: 2026-07-30T00:31:21Z
artifact-hash: sha256:baeae13d8ac4
---

# Does every user-facing skill declare slash-only activation, with the plumbing class governed by the documented-machine-driver rule?

## Confirmation

Satisfied. The population is every skill the repository carries — the
nine `ok-planner` verbs, the eight `ok-plumbline` verbs, the four
`ok-workspaces` verbs, the front door's `/ok`, and this repo's own
`/release`: twenty-three, each pinned below. Every one of them opens its
`description` with `ONLY activated by ... slash command` and carries
`Never auto-triggered by conversation content.`

- The membership of the three family populations is re-derived from the
  filesystem on every maintenance run, so a twenty-fourth skill cannot
  arrive unnoticed: `checks/hub-rows` globs each family's `skills/` tree
  and fails when a sibling has no index row, and `checks/vendored-layer`
  pins this repo's materialized `.claude/skills/` set in both directions —
  a pinned path that vanished and an unaccounted skill directory are both
  findings. Both run under `checks/run`.
- The additional non-human activators the choice allows are named
  in-description and nowhere else: `audit` names the `/certify-all` gate,
  `certify-work` names the sprint document's execution boilerplate,
  `verify-issues` names the certify gate and `plan-sprint`, and
  `open`/`close` name an orchestrator. Each keeps the guard, which is
  exactly the rule for a consequential verb machinery also invokes.
- No skill in the repo drops the restriction, and none needs to: the
  membership rule makes a skill plumbing only while another suite surface
  is documented to drive it through the skill-invocation tool, and no such
  surface exists — the front door states that no family verb is ever
  invoked through the Skill tool anywhere in its flow, and the two index
  skills document Skill-tool invocation as an alternative for their human
  caller. Absence of a documented machine driver settles it, so the guard
  belongs on all twenty-three, which is what the corpus shows.
- The materialized session banner is held to the same line: it tells each
  session that user-facing verbs activate only on their explicit slash
  command, some naming one non-human caller, and that plumbing verbs say
  so in their own descriptions — and `stories.sh` fails the run if that
  payload ever claims the guard uniformly over the plumbing class.

## Citations

- cite-node: plugins/ok/families/ok-planner/skills/audit/SKILL.md @ sha256:bac8306ab6d5
- cite-node: plugins/ok/families/ok-planner/skills/certify-all/SKILL.md @ sha256:4e15063c229f
- cite-node: plugins/ok/families/ok-planner/skills/certify-work/SKILL.md @ sha256:3e9e3fd98624
- cite-node: plugins/ok/families/ok-planner/skills/discover-design/SKILL.md @ sha256:c803f8b9f4e6
- cite-node: plugins/ok/families/ok-planner/skills/ok-planner/SKILL.md @ sha256:2e5c077dfc8f
- cite-node: plugins/ok/families/ok-planner/skills/ok-version/SKILL.md @ sha256:163265bfea1d
- cite-node: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md @ sha256:f5882e778005
- cite-node: plugins/ok/families/ok-planner/skills/sketch/SKILL.md @ sha256:94e0b079094b
- cite-node: plugins/ok/families/ok-planner/skills/verify-issues/SKILL.md @ sha256:e08c536483bf
- cite-node: plugins/ok/families/ok-plumbline/skills/audit/SKILL.md @ sha256:e98581de78d4
- cite-node: plugins/ok/families/ok-plumbline/skills/budget/SKILL.md @ sha256:d2aed31c6a21
- cite-node: plugins/ok/families/ok-plumbline/skills/explain/SKILL.md @ sha256:f9e79b468b08
- cite-node: plugins/ok/families/ok-plumbline/skills/patterns/SKILL.md @ sha256:ee1faa428163
- cite-node: plugins/ok/families/ok-plumbline/skills/port/SKILL.md @ sha256:7c9200c158c0
- cite-node: plugins/ok/families/ok-plumbline/skills/starter/SKILL.md @ sha256:f11cec8e1871
- cite-node: plugins/ok/families/ok-plumbline/skills/suggest/SKILL.md @ sha256:2a7d6db6de34
- cite-node: plugins/ok/families/ok-plumbline/skills/version/SKILL.md @ sha256:9c66146b4532
- cite-node: plugins/ok/families/ok-workspaces/skills/audit/SKILL.md @ sha256:2429e6e6f72d
- cite-node: plugins/ok/families/ok-workspaces/skills/close/SKILL.md @ sha256:81ff352d2b1d
- cite-node: plugins/ok/families/ok-workspaces/skills/ok-workspaces/SKILL.md @ sha256:a37d85a6687f
- cite-node: plugins/ok/families/ok-workspaces/skills/open/SKILL.md @ sha256:36650ee9c762
- cite-node: plugins/ok/skills/ok/SKILL.md @ sha256:c2b1f0e2e951
- cite-file: .claude/skills/release/SKILL.md @ sha256:ac354a0affa8
- cite-node: checks/hub-rows @ sha256:b910eb329053
- cite-node: checks/vendored-layer @ sha256:3c48f248e796
- cite-node: checks/run @ sha256:e827e4abcc44
- cite: plugins/ok/skills/ok/SKILL.md :: "no family verb is ever invoked through the Skill tool anywhere in this flow"
- cite-node: plugins/ok/families/ok-planner/scripts/hooks/session-start @ sha256:36c37d8090fb
- cite-node: plugins/ok/families/ok-planner/test/stories.sh @ sha256:f8717649820e
- cite: plugins/ok/families/ok-planner/test/stories.sh :: "session-awareness: the payload does not overclaim the activation guard over the plumbing class"
