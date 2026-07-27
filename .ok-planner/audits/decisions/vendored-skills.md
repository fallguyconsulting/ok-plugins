---
audit: vendored-skills
artifact: decision:vendored-skills
determination: satisfied
audited: 2026-07-27T13:25:00Z
artifact-hash: sha256:042d89fc84f6
---

# Does everything project-scoped reach a consumer as committed, version-stamped vendored files with the harness pointed at them project-side, while the plugin system delivers only the two user-scoped plugins?

## Claims

**Title + Choice clause 1 — "Everything project-scoped the suite delivers —
skill files, hook implementations, support scripts, context payloads,
cheatsheets — reaches a consumer project as committed, version-stamped files
materialized from the front-door plugin's carried family payload by its
administration."** The population is every project-scoped artifact the three
families deliver, enumerated by reading each converge core's write set: skill
files under `.claude/skills/`, the cheatsheets under `.claude/rules/`, the
estate guide, the session-start hook and the plumbline edit hook inside their
dot-directories, and the support scripts (`surface-corpus`, `audit-check`,
`plumbline`, `src-tag`, `port-block`). Each is written by the core from a
canonical payload copy with the suite version substituted or appended. The
separate context payload earlier versions materialized is retired by the same
core, so nothing project-scoped now reaches a consumer outside this
materialization path. Honored.

**Choice clause 2 — "and the harness is pointed at them project-side: skills
live in the project's committed skills directory under the contract's collision
rule."** The planner core's vendoring pass declares its destination as
`.claude/skills` and renders each source skill under its materialized name,
with the `audit` verb prefixed `ok-planner-audit` because more than one family
claims that name; ok-workspaces' shared renderer does the same with
`ok-workspaces-audit`, and ok-plumbline's binary with `ok-plumbline-audit`.
Sibling slash-command references are rewritten to the materialized names with a
hyphen guard so support-script paths such as `bin/audit-check` survive — a
property the administration harness asserts directly. Honored.

**Choice clause 3 — "and hooks are declared in the project's committed harness
settings by consented transcription, every session-start entry carrying the
startup-clear-compact matcher and never firing on resume."** The planner core's
`ENTRY` constant is a `SessionStart` entry with matcher `startup|clear|compact`
whose command points at `$CLAUDE_PROJECT_DIR/.ok-planner/hooks/session-start`;
diagnose reports a missing or widened matcher as a finding and prints the
`WIRING NEEDED` block, and only the `wire-hooks` mode writes the settings file.
ok-plumbline's is a `PostToolUse` entry (matcher `Edit|Write`) — not a
session-start entry, so the matcher clause does not reach it — wired through
the same consent path; ok-workspaces declares no hooks. The administration
harness converges a fresh project and asserts both that converge alone never
touches `.claude/settings.json` and that `wire-hooks` transcribes exactly
`startup|clear|compact`. Honored.

**Choice clause 4 — "The plugin system delivers only the user-scoped plugins —
the front door carrying the families, and the conduct."** The marketplace
catalog is pinned below and lists exactly two entries, `ok-conduct` and `ok`;
`plugins/` holds exactly those two directories, and the families sit inside the
front door's payload with no manifests of their own. The contract states the
same rule normatively. Honored.

**Choice clause 5 — "A converged project is self-contained for running the
suite: cloning it yields the working skills with nothing installed; converging
needs only the front door."** All four layers the contract enumerates are
committed project files, and every runtime path resolves to one of them (the
hook via `$CLAUDE_PROJECT_DIR`, the skills from `.claude/skills/`, the scripts
from the dot-directory). The only thing the payload is needed for is
converging. The maintenance check `vendored-layer` runs this repo's own
planner diagnose — the same gate a consumer gets — and additionally asserts no
family ships family-root hooks and the front door ships none either, which is
what keeps hook execution project-side. Honored.

**Rationale capability claim — "the harness scopes plugin enablement per
project but plugin content per machine … Committing the behavioral surface to
the project makes the version a property of the repo."** Follows from clauses
1–3 plus the version stamps: each project's copies carry the version that wrote
them, and updating the payload changes no project until its owner converges.
Honored.

## Determination

**Satisfied.** Every project-scoped artifact is materialized as a committed,
version-stamped file by a family converge core; skills land in the project's
skills directory under the collision rule with slash-command references
rewritten and support-script paths preserved; hooks execute from the project's
estate through a consented settings entry whose session-start matcher is
`startup|clear|compact`; and the marketplace distributes exactly the two
user-scoped plugins. A maintenance check independently enforces the no-family-
root-hooks property and runs the family's own diagnose over this repo's
vendored layer.

This stops holding if: a family ships a root `hooks/` directory or the front
door declares hooks; a marketplace entry is added for something that is not a
user-scoped plugin (the `cite-file` pin breaks on any catalog change); the
vendoring destination moves off `.claude/skills` or the collision prefixing is
dropped; a `SessionStart` entry is written with a widened matcher or without
consent; or any project-scoped artifact begins executing from the payload
rather than a materialized copy.

## Citations

- cite-file: .claude-plugin/marketplace.json @ sha256:0bec1dfab936
- cite: plugins/ok/families/ok-planner/admin/converge :: "dest = os.path.join(root, ".claude", "skills")"
- cite-span: plugins/ok/families/ok-planner/admin/converge :: "SKILLS = {" +12 sha256:e48536a36db6
- cite: plugins/ok/families/ok-planner/admin/converge :: "MARKER = "
- cite-span: plugins/ok/families/ok-planner/admin/converge :: "if mode == "wire-hooks":" +26 sha256:4fffaff9b3de
- cite: plugins/ok/families/ok-workspaces/scripts/vendored-skills.js :: "// @decision: vendored-skills"
- cite: plugins/ok/families/ok-plumbline/bin/plumbline :: "// @decision: vendored-skills"
- cite: checks/vendored-layer :: "# @decision: vendored-skills"
- cite-span: checks/vendored-layer :: "hooks_dir = os.path.join(FAMILIES_DIR, family, " +6 sha256:44c1fa8fc506
- cite: docs/integration-contract.md :: "The plugin system carries exactly"
- cite: docs/integration-contract.md :: "Families ship **no family-root hooks**"
- cite: docs/integration-contract.md :: "project is self-contained: cloning it yields the working suite with"
