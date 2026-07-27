---
audit: filesystem-discovery-markers
artifact: decision:filesystem-discovery-markers
determination: satisfied
audited: 2026-07-27T12:30:00Z
artifact-hash: sha256:72b9c42f6459
---

# Is family integration answered solely by a filesystem marker check, with absence a meaningful state?

## Claims

**Title — "Integration is discovered by filesystem markers, never
inference."** The front door's discovery step says exactly that, verbatim — "a
filesystem check, never an inference" — and the integration contract carries
the same sentence about the dot-directory. Both lines are asserted verbatim
(whitespace-normalized) by the maintenance check under a
`@decision: filesystem-discovery-markers` annotation, which is the decision's
enforcement point: deleting or rewording either line turns the check red.
Honored.

**Choice clause 1 — "'Which suite families does this project use' is answered
solely by checking for each family's committed dot-directory estate at the
project root."** The front door's step 2 is the only place the question is
answered, and it answers it by testing for the marker at the root — nothing in
the step reads project content, conversation, or any registry. The proof
harness exercises the rule deterministically over the whole carried set: after
one family's core has materialized its estate, it partitions the three
families into integrated and candidate purely by `[ -d "$two/.$f" ]` and
asserts the partition is exactly `ok-planner` versus
`ok-plumbline ok-workspaces`. Population of families enumerated from reality
(three directories under the front door's `families/`) and pinned by
`cite-file` on the contract, which documents a marker line per family, and on
the harness that iterates them. Honored.

**Choice clause 2 — "(resolved as the nearest git ancestor)."** The front door
resolves the project root as the nearest `.git` ancestor, and each converge
core does the same independently — the bash cores walk parents until a `.git`
entry is found and fall back to the working directory, the node cores ask
`git rev-parse --show-toplevel` with the same fallback. Honored.

**Choice clause 3 — "plus documented pre-migration marker locations so
un-migrated projects are still discovered and offered migration."** The
contract's discovery-markers section is the enumeration: one bullet per
family, with plumbline's two pre-migration markers (a root config file from
the pre-dot-directory layout, or a materialized cheatsheet from an integration
whose config was never migrated) named there and nowhere else authoritative.
The front door repeats them and names the contract's current-conformance
section as the authority, so the convention lives in the contract rather than
in the administrator's prompt — which is what makes "documented" true rather
than folklore. The migration those markers exist to make offerable is real:
the plumbline core relocates the root config mechanically on converge.
`cite-file` on the contract pins the enumeration, so adding a marker forces
this audit to be re-derived. Honored.

**Choice clause 4 — "Hooks use the same rule to decide whether to no-op."**
Population of hooks the suite wires into a project: two — the planner's
session-start and plumbline's post-edit; workspaces declares none. Both are
materialized *inside* the family's estate and reached through a settings entry
pointing at that path, so the marker's absence means the file is absent and
nothing fires; the contract states this consequence explicitly. Plumbline's
hook additionally makes the check in its own body, resolving the vendored
binary relative to itself inside the estate and exiting 0 when it is not
present. Honored.

**Choice clause 5 — "absence is a meaningful state — bootstrap candidate or
recorded decline — not an error."** The front door's step 3 names a family
with no markers a bootstrap candidate, asks once before administering
anything, and records a decline as `not integrated (declined)` — "declining is
a valid state, not drift." The contract says the same in its markers section.
The harness asserts both the candidate partition and, verbatim against the
front door's body, that a decline is recorded as a valid state. Honored.

**Rationale capability claims — "A filesystem check is deterministic,
per-project, and independent of anyone's memory"; "the administrator reads it
rather than deciding it."** Both follow from the mechanism above: the check is
a directory test at a root derived from git, performed identically by the
administrator and by every core, with no state held anywhere else. Honored.

## Determination

**satisfied.** Integration state is a committed property of the project,
answered by one filesystem test and nothing else. The rule is stated in the
front door and in the contract in identical words, mechanically pinned by a
text-presence assertion carrying this decision's annotation, exercised
deterministically by the administration harness over the full carried family
set, and used by the same root-resolution logic in all three converge cores.
Pre-migration markers are documented in the contract — the single authority —
and the migration they exist to offer is implemented. Both wired hooks live
inside their family's estate, so absence of the marker is absence of the hook,
and one of them re-checks in its own body; absence is treated everywhere as
bootstrap candidate or recorded decline, never as an error.

For this to stop being true: discovery widened to consult project content,
conversation, or a registry; the root resolved by anything other than the
nearest git ancestor; a pre-migration marker honored by the administrator but
not documented in the contract (or documented but no longer honored); a hook
moved to a family-root or plugin-root location where it would fire regardless
of integration; or absence treated as a finding rather than a candidate or a
decline.

## Citations

- cite: plugins/ok/skills/ok/SKILL.md :: "Resolve the project root (nearest `.git` ancestor). A family is integrated iff its discovery markers exist at the root — its current marker (`.ok-<name>/`) **or any pre-migration marker documented in the integration contract** — a filesystem check, never an inference. Pre-migration markers matter here: a project carrying only an earlier layout must still be discovered, or its migration is never offered."
- cite-span: plugins/ok/skills/ok/SKILL.md :: "### 3. Offer to bootstrap the rest" +6 sha256:b9d264b7a8e1
- cite: docs/integration-contract.md :: "   this project use?" is a filesystem check, never an inference."
- cite-file: docs/integration-contract.md @ sha256:e298eb43c24c
- cite-span: checks/text-presence :: "# @decision: filesystem-discovery-markers" +11 sha256:bca1726b9add
- cite-span: plugins/ok/families/ok-planner/admin/converge :: "resolve_root() {" +12 sha256:27c5162b6222
- cite: plugins/ok/families/ok-plumbline/scripts/hooks/post-edit.js :: "  if (!fs.existsSync(binary)) process.exit(0);"
- cite-span: plugins/ok/test/administration.sh :: "  if [ -d "$two/.$f" ]; then integrated="$integrated $f"; else candidates="$candidates $f"; fi" +9 sha256:6d0d4497a1b7
- cite-file: plugins/ok/test/administration.sh @ sha256:4c4248c184f9
