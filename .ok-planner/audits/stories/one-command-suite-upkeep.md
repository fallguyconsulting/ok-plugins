---
audit: one-command-suite-upkeep
artifact: story:one-command-suite-upkeep
determination: satisfied
audited: 2026-07-28T00:00:00Z
artifact-hash: sha256:b04f97d8332c
---

# Does one front-door command bring the whole suite presence current, and does a proof exhibit it?

The design artifact's hash is unchanged since the prior audit, so that audit's
reasoning binds absent moved reality, and it carried no `## Notes` ledger, so no
adjudication is open. What moved is one file this audit pins as a population
source: `checks/vendored-layer` was rewritten so that its first conjunct is a
`git status --porcelain` cleanliness gate over this repo's pinned suite-owned
paths, replacing a conjunct that ran the planner family's diagnose against the
working tree. The conjunct this audit actually leans on — the per-family
assertion that both conventional administration surfaces are present — survived
the rewrite intact, and its `FAMILIES` tuple is unchanged. Separately, this
repo's vendored planner layer was restored to its pinned HEAD state and now
legitimately lags the family source (`decision:per-project-pinning`); nothing
this story claims is about that layer. Citation re-pinned, every claim re-run
against the tree.

Refreshed again this cycle, for two further reasons, both outside this
story's territory. First, `plugins/ok/test/administration.sh` gained the
same per-story timing instrumentation as the family's other harnesses — a
`section`/`emit_timing` helper pair plus one `section
one-command-suite-upkeep` marker line dropped in immediately after this
story's section header; the cited span's other 39 lines and the assertions
that follow are byte-identical. Second, `checks/vendored-layer` gained one
more entry in its `PINNED` tuple (`.ok-planner/.gitignore`) — the `FAMILIES`
tuple and the per-family administration-surface conjunct this audit relies
on are unchanged. Separately, and not a citation this audit holds: the
ok-planner family's own `admin/converge` gained real new materialization
steps this cycle (a `browse` skill entry, a corpus-view build placement, an
estate `.gitignore`) — I read that diff to check whether it bears on this
story's Acceptance clause 4 ("converge from the carried payload") or clause
6's closing table, and it does not. This story claims only that the front
door runs *the family's own* `admin/converge diagnose`/converge without
reinterpreting what comes back — it makes no claim about what any family's
converge materializes internally. What converge now places is that family's
own concern (covered by its own stories/decisions), not a front-door
process fact. Citations re-pinned; every claim re-run against the tree.

## Claims

**Title / Story — "my project's whole suite presence brought current in one
consolidated act … so that suite upkeep requires no per-family knowledge from
me."** Honored. One skill is the whole administration process; the families
travel as its payload and are resolved from one place (`${CLAUDE_PLUGIN_ROOT:-
plugins/ok}/families/<family>`), so the owner names no family and runs no
per-family verb. The front door's body states the payload-resolution rule once
and then runs six ordered steps, and it forbids improvising family knowledge:
everything family-specific comes from the family's own two surfaces, with the
explicit escape hatch that a family needing a special case is non-conformant and
gets reported rather than accommodated. The population of families was
enumerated from reality: three directories under the front door's `families/`,
named identically in the front-door body and in the maintenance check that
asserts, per family, that `admin/converge` exists and is executable and that
`admin/ADMINISTRATION.md` exists — pinned by `cite-file` on both, so adding or
removing a family trips this audit.

**Acceptance clause 1 — "the installed user-scoped plugins are updated to the
marketplace's current versions."** Step 1 lists what is installed and updates
each installed ok-plugin, explicitly never installing an absent one, and notes
that updates take effect only after a reload. Honored as stated procedure; this
is the one clause no fixture can exercise (running `claude plugin update` would
mutate the machine the harness runs on), and the Proof field does not name it
among its observables.

**Acceptance clause 2 — "integrated families are discovered by filesystem
markers alone."** Step 2 resolves the project root as the nearest git ancestor
and declares integration a marker check, never an inference, deferring to the
integration contract as the authority on which markers count — including the
documented pre-migration markers, so a project on an older layout is still
found and offered its migration. The proof harness exercises this
deterministically: on a fixture project it splits the three carried families
into integrated vs. candidate purely by testing for `.<family>/` at the root,
and asserts the split is exactly `ok-planner` integrated and
`ok-plumbline ok-workspaces` as candidates. Honored.

**Acceptance clause 3 — "carried-but-unintegrated families are offered
bootstrap in exactly one consent question, with decline recorded as a valid
state."** Step 3 says the offer is made "once, in one question," names the
candidates, allows all/subset/none, and records a decline as
`not integrated (declined)` — "a valid state, not drift." Both phrases are
asserted verbatim by the harness against the front door's own body, and the
harness exercises the disk-side consequence: the consented family is
administered in the same fixture while the declined one is left with no estate
at all. Honored.

**Acceptance clause 4 — "each integrated or consented family is administered
in one pass — diagnose, any consent the ownership rule requires, converge from
the carried payload."** Step 4 is exactly that four-part sequence per family
(diagnose, consult the administration document, converge, hold the wiring),
driven from the payload paths, with a standing prohibition on reinterpreting,
filtering, or re-deriving a family's findings. Honored — and re-checked this
cycle against the maintenance check's rewrite, which touched nothing in this
sequence: the family diagnose the pass drives is the family's own
`admin/converge diagnose`, reached through the payload path, and it is the
administration act that runs it. Moving this repo's own maintenance posture from
"run diagnose over the working tree" to "git says the pinned layer matches HEAD"
changed what this *repo* checks about itself, not what `/ok` does to a project.

**Acceptance clause 5 — "every hook-wiring consent presented once, together,
and written only on the owner's yes."** Step 4 collects `WIRING NEEDED` blocks
without acting; step 5 presents them together, once, and writes only by
running the consent command each block names, with no widening of any entry or
matcher. The harness proves the write side for the one family that declares
hooks: the bootstrap pass surfaces a `WIRING NEEDED` block rather than writing,
converge alone leaves no `.claude/settings.json` at all, and only the
`wire-hooks` invocation produces the entry, with the exact
`startup|clear|compact` matcher. Honored.

**Acceptance clause 6 — "a fixed summary table closes the run, naming per
family the carried and project-stamped versions and the outcome."** Step 6
gives the table verbatim with those three columns beside the family name and
defines what each column means, including that the carried-versus-vendored gap
is signal rather than error. The harness asserts the header row stands in the
front door's body and, independently, reconstructs the table's cells off the
filesystem the run left behind — reading each administered family's stamp out
of its materialized artifact and comparing it to the carried suite version read
from the front-door manifest (both v11.0.0 on this tree). Honored, and this
cycle gives the "gap is signal" column its first live illustration: this repo's
own vendored planner layer now sits behind the family source by design, which
is precisely the state that column exists to report rather than to flag.

**Acceptance clause 7 — "Migration and repair judgment comes from the family's
own administration document, never improvised."** Stated twice in the front
door (step 4's consult instruction and the negative section's first bullet),
and the contract makes the same demand of the administrator. The maintenance
check requires every family to carry both surfaces — the converge core present
and executable, the administration document present. Honored.

**Acceptance clause 8 / Falsifier limb — "The personal conduct plugin is never
vendored or offered by the front door."** The front door carries a dedicated
paragraph and a negative bullet saying it never installs, vendors, offers, or
treats the conduct's absence as a finding. The harness checks both sides: the
prohibition stands verbatim in the front door's body, and the fixture project
the run leaves behind carries no conduct estate, no conduct skill directory,
and no conduct rules file. Honored.

**Falsifier.** Each limb has its counterpart: bootstrap without consent (step
3's never-bootstrap-silently rule plus the declined-family assertion); a plugin
installed by the front door (step 1's never-install rule and the NOT-do
bullet); an integrated family undiscovered (the marker rule and the harness's
split); improvised family knowledge (the two consult rules and the maintenance
check); wiring written without a yes (the converge-writes-nothing assertion);
the conduct vendored or offered (both sides asserted).

**Proof — "a run on a project with one integrated family and one
carried-but-unintegrated family, producing exactly one bootstrap question, a
per-family administration pass a third party can reconcile against the
project's filesystem markers and stamps, and a closing table."** One annotated
artifact carries this story: `rg -l '@story: one-command-suite-upkeep'` over the
tree yields `plugins/ok/test/administration.sh` and the front door's own body,
where the annotation is the enforcement site rather than a proof. Re-run this
cycle: 25 assertions, exit 0. The harness's final section builds precisely the
fixture the field names — a project with `ok-planner` integrated and the other
two carried but unintegrated — and exhibits all three named observables: the
single bootstrap question and the recorded decline (prompt-realized, with the
harness's own header saying so and naming
`plugins/ok/skills/ok/SKILL.md` before asserting them verbatim), the
administration pass reconcilable against markers and stamps (marker-only
discovery, the consented family administered, the declined family untouched),
and the closing table (its cells rebuilt from the run's own filesystem output,
its header asserted in the skill body).

Two limits recorded rather than waved through. The consent itself is
*simulated*: the harness writes the workspaces profile and runs that family's
converge core directly, because the front door is a prompt and no shell can
drive it — so "administered in the same pass" is exhibited as the disk outcome
a pass would leave, not as a pass. And the prompt-realized conjuncts are named
at the section header rather than on each assertion line, which is the weaker
end of the harness convention the sibling blocks follow.

## Determination

**satisfied.** Every Acceptance clause is honored by the front door's own body,
which is the executable substance of a skill-realized process: the six steps
deliver the plugin update, marker-only discovery, the single bootstrap
question with decline as a valid state, the per-family diagnose → judgment →
converge pass, the once-and-together wiring consent, and the fixed closing
table; the conduct carve-out and the never-improvise rule are stated as
prohibitions in the skill's own negative section and enforced by the
maintenance checks, all seven of which pass on this tree.

The proof spans the `Proof:` field. The harness's closing section drives a
fixture project carrying one integrated family and two carried-but-
unintegrated ones (a superset of the field's "one"), consents to one and
declines the other, and reads the closing table's three cell kinds — carried
version, project-stamped version, outcome — back off the filesystem the run
leaves behind. The conjuncts only a prompt can realize (the wording of the
single consent question, the decline record, the table's shape, the conduct
carve-out) are asserted verbatim against the named skill file, and the harness
states in its own header that it is doing exactly that and why.

The determination does not move on the changed reality. This re-audit was
forced by the rewrite of `checks/vendored-layer`, which this audit pins whole
as one of two population sources for the carried family set — not by any change
to the front door, whose `cite-file` pin verifies unchanged. The rewrite
replaced this repo's own diagnose-against-the-working-tree conjunct with a
pinned-layer cleanliness gate; the per-family administration-surface conjunct
this audit relies on, and the `FAMILIES` tuple that is its enumeration, both
survived verbatim and are cited below. The earlier-recorded consequence of the
release-metadata masking still stands and is worth carrying: the example rows
in the step 6 table name families beside `vX.Y.Z`, so those version literals are
masked out of the front door's pin; the pin still covers the table's shape and
every other line of the file.

For this to stop being true, any of the following would suffice: a step
dropped or reordered out of the front door's process; the bootstrap offer
split into per-family questions or made silent; the conduct added to anything
the front door installs, vendors, or offers; family knowledge moved from a
family's `admin/` surfaces into the administrator; the marker rule replaced by
an inference; the closing table's columns changed without the harness
following; a family added to or removed from the carried set without the
maintenance check and this audit's population pins following; the maintenance
check dropping its per-family administration-surface conjunct, which is the
only mechanical guard that every carried family exposes what step 4 drives; or
the harness's two-family section weakened so that the bootstrap question, the
marker-only split, or the table is no longer exhibited.

## Citations

- cite-node: plugins/ok/skills/ok/SKILL.md @ sha256:c2b1f0e2e951
- cite-span: plugins/ok/skills/ok/SKILL.md :: "### 1. Update the installed user-scoped plugins" +10 sha256:425dee644a0e
- cite-span: plugins/ok/skills/ok/SKILL.md :: "### 2. Discover" +4 sha256:0becafb42551
- cite-span: plugins/ok/skills/ok/SKILL.md :: "### 3. Offer to bootstrap the rest" +6 sha256:b9d264b7a8e1
- cite-span: plugins/ok/skills/ok/SKILL.md :: "### 4. Administer each family, one pass" +10 sha256:64a3e20386c3
- cite-span: plugins/ok/skills/ok/SKILL.md :: "### 5. Wire the hooks — by consented transcription only, once" +4 sha256:389567d6b9cb
- cite: plugins/ok/skills/ok/SKILL.md :: "| family | carried | vendored in project | outcome |"
- cite: plugins/ok/skills/ok/SKILL.md :: "- Does not install, vendor, or offer the conduct. `ok-conduct` is personal and user-scoped; the only thing `/ok` ever does with it is update an already-installed copy in step 1."
- cite: plugins/ok/skills/ok/SKILL.md :: "- Does not improvise family knowledge."
- cite: plugins/ok/test/administration.sh :: "# @story: one-command-suite-upkeep"
- cite-span: plugins/ok/test/administration.sh :: "# --- one-command-suite-upkeep: the consolidated act over two families -------" +40 sha256:4cee679292bb
- cite-span: plugins/ok/test/administration.sh :: "# The closing table: per family, carried version, project-stamped" +20 sha256:509eba828686
- cite-node: plugins/ok/test/administration.sh @ sha256:215e1489d4ce
- cite: checks/vendored-layer :: "FAMILIES = ("ok-planner", "ok-plumbline", "ok-workspaces")"
- cite: checks/vendored-layer :: "    core = os.path.join(FAMILIES_DIR, family, "admin", "converge")"
- cite-node: checks/vendored-layer @ sha256:cd521ec90604
