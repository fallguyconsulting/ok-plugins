---
audit: session-awareness
artifact: story:session-awareness
determination: satisfied
audited: 2026-07-29T13:57:39Z
artifact-hash: sha256:a50c2aad3ba1
---

# Does every session in the project start briefed on the governing versions and the project's concept vocabulary?

## Confirmation

Satisfied. The briefing arrives without the owner pasting anything, from
two always-present surfaces.

- **The hook.** `.ok-planner/hooks/session-start` is materialized into
  the estate, executable, and reached through the consented
  `.claude/settings.json` entry whose matcher is `startup|clear|compact`
  — so it fires on every session start and never on resume. Run for
  real in `stories.sh`, it exits clean, emits a `SessionStart` payload,
  names the governing version in its banner, injects this project's own
  `design/concepts.md` under the read-before-you-define framing, and
  does not overclaim the activation guard. The same suite asserts the
  unintegrated case: no estate means no hook and no wiring, so nothing
  is injected. `administration.sh` asserts the wired entry's matcher is
  exactly `startup|clear|compact` and that converge alone never writes
  it.
- **The other families' versions.** `ok-plumbline` and `ok-workspaces`
  ship no session hook; their governing versions reach every session
  through the always-in-context cheatsheet each converge materializes
  under `.claude/rules/`, stamped `Materialized by ok-<family> v<X>`.
  `administration.sh` reads the `ok-workspaces` stamp back out of its
  materialized cheatsheet and requires it to equal the carried suite
  version.
- **Discovering the verbs.** The banner points at the vendored skills
  under `.claude/skills/` as the project's verbs and describes how they
  activate; the harness surfaces their descriptions, so no separate
  skills briefing is injected.

## Referrals

- referral: agents use the project's terms correctly, having read the concept files rather than paraphrasing
  clause: "so that agents use my terms correctly and discover my verbs without me pasting context or repeating rules"
  delivered: the concept catalog is injected verbatim from `.ok-planner/design/concepts.md` with the instruction to open `concepts/<slug>.md` before defining or invoking a term and not to paraphrase from prior context — asserted present, and asserted to be this project's own catalog, in `stories.sh`
  discipline: human-review

## Citations

- cite-node: plugins/ok/families/ok-planner/scripts/hooks/session-start @ sha256:36c37d8090fb
- cite-node: plugins/ok/families/ok-planner/test/stories.sh @ sha256:f8717649820e
- cite-node: plugins/ok/test/administration.sh @ sha256:d184587f1c50
- cite-node: plugins/ok/families/ok-planner/admin/converge#vendor_layer @ sha256:5bf5d865a18f
- cite-node: plugins/ok/families/ok-planner/scripts/ok-planner-cheatsheet.md @ sha256:4e51c9b6429e
- cite-node: plugins/ok/families/ok-plumbline/docs/plumbline-cheatsheet.md @ sha256:a4dcceec5a7a
- cite-node: plugins/ok/families/ok-workspaces/scripts/converge.js @ sha256:86092f273c39
- cite-node: docs/integration-contract.md#the-ok-suite-integration-contract.hooks-materialized-implementations-consented-wiring @ sha256:8326321cdf69
- cite-file: .claude/settings.json @ sha256:3df3f9c21e63
