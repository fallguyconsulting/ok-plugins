---
audit: vendored-skills
artifact: decision:vendored-skills
determination: satisfied
audited: 2026-07-29T18:40:00Z
artifact-hash: sha256:042d89fc84f6
---

# Is project-scoped behavior vendored into the project as committed, version-stamped files, under the contract's collision rule?

## Confirmation

Satisfied. Every project-scoped surface reaches a consumer as committed,
version-stamped files written by a family's converge from the front
door's carried payload, the harness is pointed at them project-side, and
the collision rule, the consented hook wiring and the self-containment
claim are each exercised end to end.

- **Materialization and the stamp.** `ok-planner`'s converge renders its
  skills plus the shared files into `.claude/skills/` and the estate
  guide, cheatsheet, hook implementation, checkers and view build into
  `.ok-planner/`; `ok-plumbline`'s renders cheatsheet, binary, edit hook,
  module marker and vendored skills; `ok-workspaces`' renders cheatsheet,
  `src-tag`, `port-block` and vendored skills. `administration.sh`
  asserts the planner's estate, stamp, cheatsheet, executable hook and
  skill set on a real bootstrap and then requires diagnose — which
  compares each target against the version-stamped rendering — to be
  clean; the plumbline and workspaces harnesses do the same for the other
  two families, plumbline additionally driving a retired root-layout
  config and budget baseline through converge and requiring them moved
  into the estate, contents intact and still governing.
- **The collision rule, read off the disk in both places it applies.**
  `administration.sh` builds a two-family project and, for `ok-planner`
  and `ok-workspaces` alike, requires `.claude/skills/<family>-audit/` to
  exist with `name: <family>-audit` in its frontmatter and a
  `/<family>-audit` self-reference, requires no bare `/audit` reference
  to survive inside the rendered body, and requires no bare
  `.claude/skills/audit/` anywhere. The expectation is built from the
  rule (family, hyphen, verb), never from a family's vendoring map, so a
  map that dropped the prefix fails. `ok-plumbline`'s harness does the
  third family and goes further: `claiming_families` re-reads the rule's
  premise from reality by globbing the carried families' own `skills/`
  trees (`audit` claimed by two or more, `explain` by one), the unclaimed
  verb is required to keep its bare name, sibling references inside the
  body are required rewritten, and the prefixed skill's own run block is
  then executed to show what landed is a working verb.
- **Hooks: project-side settings, consented transcription, the fixed
  matcher.** The one `SessionStart` entry the suite declares carries the
  `startup|clear|compact` matcher — no `resume` — asserted in
  `administration.sh` by parsing `.claude/settings.json` after
  `wire-hooks`, with converge alone leaving that file absent. No family
  and no plugin ships family-root or plugin-root hooks;
  `checks/vendored-layer` enumerates the three families and fails on
  either, and pins this repo's own vendored layer in both directions —
  every pinned path must exist, and every skill directory present must be
  accounted for as vendored or repo-authored.
- **Self-containment.** A converged `ok-plumbline` clone runs its
  vendored `version`, `starter` and `port` verbs with
  `CLAUDE_PLUGIN_ROOT` unset, failing if any reaches for the payload; the
  prefixed audit verb is run the same way; and the planner's corpus view
  is served out of a project's own `.ok-planner/bin/` copy with the
  variable unset and reports that copy as its resolver.
- **User-scoped delivery only.** The marketplace catalog carries exactly
  the front door and the conduct, and `administration.sh` asserts the
  conduct is never vendored into an administered project.

## Citations

- cite-node: plugins/ok/families/ok-planner/admin/converge#vendor_layer @ sha256:3f018eafeb2a
- cite-node: plugins/ok/families/ok-plumbline/bin/plumbline @ sha256:e38de2cc2e2a
- cite-node: plugins/ok/families/ok-workspaces/scripts/vendored-skills.js @ sha256:fb2484ade4e1
- cite-node: checks/vendored-layer @ sha256:32ecd23819c3
- cite-node: checks/run @ sha256:e827e4abcc44
- cite-node: plugins/ok/test/administration.sh @ sha256:65b93a0be43c
- cite: plugins/ok/test/administration.sh :: "    ok "$f materializes the colliding audit verb family-prefixed ($materialized)""
- cite: plugins/ok/test/administration.sh :: "  && ok "no bare .claude/skills/audit/ — the colliding verb never materializes unprefixed" \"
- cite: plugins/ok/test/administration.sh :: "  && ok "wire-hooks transcribes the exact consented entry (startup|clear|compact)" \"
- cite: plugins/ok/test/administration.sh :: "  && ok "converge alone never touches .claude/settings.json" \"
- cite-node: plugins/ok/families/ok-plumbline/test/run.sh @ sha256:d594fba0f807
- cite-node: plugins/ok/families/ok-plumbline/test/run.sh#run_vendored_name_collision_case @ sha256:a7cafc5777cd
- cite-node: plugins/ok/families/ok-plumbline/test/run.sh#run_clone_self_containment_case @ sha256:5f472a2d5f08
- cite-node: plugins/ok/families/ok-planner/test/stories.sh @ sha256:16ddb66851bc
- cite-node: docs/integration-contract.md#the-ok-suite-integration-contract.the-layers @ sha256:3a4fac20616c
- cite-node: docs/integration-contract.md#the-ok-suite-integration-contract.the-administration-surfaces @ sha256:bdc1c5438957
- cite-node: docs/integration-contract.md#the-ok-suite-integration-contract.hooks-materialized-implementations-consented-wiring @ sha256:8326321cdf69
- cite-node: docs/integration-contract.md#the-ok-suite-integration-contract.the-front-door @ sha256:2c99591a32b3
- cite-file: .claude-plugin/marketplace.json @ sha256:0bec1dfab936
- cite-file: .claude/settings.json @ sha256:3df3f9c21e63
