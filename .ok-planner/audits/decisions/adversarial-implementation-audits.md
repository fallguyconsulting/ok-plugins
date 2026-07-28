---
audit: adversarial-implementation-audits
artifact: decision:adversarial-implementation-audits
determination: satisfied
audited: 2026-07-28T00:09:44Z
artifact-hash: sha256:2f811bcc65f9
---

# Whether implementation claims are verified by durable adversarial audits with mechanical staleness, and whether the checker still masks every release-mutable stamp materialization writes

## Claims

**Title — "Implementation claims are verified by adversarial audits, not test
mandates."** Both halves hold. The auditor prompt exists as a canonical shared
block dispatched by both certification gates and is written as a refutation
exercise. No skill requires a registered test per claim; the only runtime
obligation is the story proof.

**"a durable, per-artifact determination (`satisfied` or `violated`) recorded in
a fourth corpus collection."** Honored. The checker hard-codes the two
determination values and refuses anything else as `audit-malformed`; the
collection is `.ok-planner/audits/{stories,decisions}/`, the live population is
derived from `.ok-planner/design/{stories,decisions}/`, and `audit-missing` /
`audit-orphaned` cover both directions. Path placement is itself checked: an
audit whose `artifact:` ref does not match its directory and basename is
malformed.

**"written only by a certification producer that did not implement the work
under audit, and never hand-edited."** Enforced at the only layer that can
enforce it in a prompt-executed system. The auditor file states author
separation as load-bearing; the certification core forbids the fixer from
editing audit files. Nothing mechanical prevents a hand-write — a recognised
limit of a prompt-enforced regime, stated at every point that could violate it.

**"Audits cite code by content anchors and pin quantified claims' population
sources by file hash."** Honored, three tiers implemented and machine-read:
`cite:` (existence), `cite-span:` (anchor plus N lines, content-hashed, with
`anchor-ambiguous` when the anchor is not unique), `cite-file:` (whole-file
pin). No citation form records a line number. The `cite` / `cite-file`
subcommands emit ready-made lines, and they apply the identical mask the checker
applies, so an emitted line and a checked line cannot disagree.

**"a deterministic checker flags any audit whose design artifact, cited code, or
population source has changed, and the stale set — not human memory — is what
gets re-audited."** Honored, and exercised on this cycle rather than asserted:
the eleven re-audits this file belongs to were selected by `--list-stale`, which
named them for three distinct reasons — four design artifacts were repaired
(`audit-stale-artifact`), the edit hook and the plumbline harness changed under
files audits pinned whole or by span (`audit-stale-citation` on a population
source and on a mechanism), and two verb files lost the exact anchor lines two
audits cited (`audit-stale-citation` on a vanished anchor). All three triggers
live in `check_audit`. `certify-work` defines its re-audit set as the union of
touched artifacts and every ref the checker lists, and `certify-all` re-derives
every determination fresh. Worth naming as evidence the tripwire is not
cosmetic: the anchors that vanished are precisely the two bootstrap-verb comments
the fix cycle had to delete in order to fix `decision:vendored-skills`, so the
fix could not be made without forcing a fresh adversarial read of the audits that
cited them.

**"The checker masks release-mutable metadata — the suite-version stamp lines
materialization writes and the plugin manifests' version fields — before hashing
anything a citation or pin covers, so a release that changes only versions voids
no audit."** Honored. The population is "the suite-version stamp lines
materialization writes", re-enumerated from reality for this audit — every
version substitution site in all three carried families' converge cores, whose
whole files are pinned below — not from the decision's wording. The enumeration
is exhaustive over four mechanisms: the planner core's six
`sed "s/{{OK_PLANNER_VERSION}}/…/g"` passes plus its python vendor layer's
`STAMP` constant; the plumbline core's cheatsheet and post-edit substitutions,
its `const VERSION = '0.0.0-unvendored'` rewrite, and its binary's vendored-skill
stamp; the workspaces `converge.js` `stamp()` helper over src-tag and port-block
plus its three generated stamp strings (the worktree `.gitignore` header, the
cheatsheet header, and the per-skill trailer in `vendored-skills.js`); and the
two `.claude-plugin/plugin.json` manifests.

None of the three converge cores changed in this fix cycle — all three whole-file
pins still match — so the stamp population is unchanged. The cycle's edits were
to the edit hook, three verb files and the family harness, and I checked each for
a new stamp site: the hook's guard sits below its existing stamp banner and adds
none, the verb files carry stamps only when materialized (appended by the
renderer, an already-enumerated mechanism), and the harness stamps nothing.

The claim was then exercised end to end rather than member by member, on the tree
as it stands. A scratch copy of this repo had both manifests bumped
`11.0.0` → `11.0.1` and the planner converge core re-run, which is precisely the
release act's step 5c. Twenty-two files changed. Every one of the twenty-two
hashes identically under the checker's own `masked_file_hash` before and after —
zero divergences — and `audit-check` over the released tree returns a finding set
byte-identical to the baseline: the same eleven stale refs and the same
`violated-unlinked`, not one finding more and not one fewer. "A release that
changes only versions voids no audit" is true as stated, exhibited rather than
asserted, and the two members that escaped an earlier mask — the estate
session-start hook's injected banner and the workspaces src-tag header comment —
were among the twenty-two and came back identical.

The harness proves the same property from the other side: `masked-version-bump`
carries all five stamp shapes two releases ahead of the audit citing them and
must exit 0, while its twin `masked-edit-trips` carries a non-version edit on
each of those same five surfaces and must trip. All nineteen cases pass on this
tree.

**"before hashing anything a citation or pin covers."** Honored including the
non-text case, which is where masking could have quietly weakened a pin:
`masked_file_hash` decodes strictly and, on `UnicodeDecodeError`, hashes the raw
bytes rather than decoding lossily. That matters because a lossy decode is not
injective — the `binary-pin-changed` fixture's two blobs differ only in the
invalid-UTF-8 bytes `ff fe` versus `fe ff`, which `errors="replace"` would
collapse to identical replacement characters and an identical hash. The fixture
asserts the pin still trips, and the `clean` fixture carries a binary pin that
must not trip, so both directions are held.

**Rationale — "Version stamps sit inside otherwise-cited bytes and must change
on every release, so masking them is what keeps the tripwire meaningful:
staleness signals substantive change, never the release act, while any edit
beyond the masked patterns still breaks its anchor."** Honored, both halves. The
release half is the twenty-two-file demonstration above. The second half is
exercised by four harness cases and, this cycle, by the live corpus: eleven
audits went stale on substantive edits and none on a version change.

Adversarial note, recorded and not charged, because no sentence of the artifact
claims the mask is minimal. The family-scoped rule masks a strict superset of the
stamp population: any `v<semver>` on any line naming an `ok-*` family, wherever it
appears. Re-derived by running `mask_release_metadata` directly —
`ok-planner v9.0.0-behind` inside the `see-governing-versions` proof fixture, and
an illustrative table row `| ok-planner | v10.2.3 |`, both normalize to `v0.0.0`
despite being ordinary literals rather than materialized stamps. The tripwire is
therefore blind to version literals on family-naming lines generally, which is
wider than "the suite-version stamp lines materialization writes". If the Choice
is ever tightened to say the mask covers *only* release-mutable metadata, this
becomes a violation.

**"Stories additionally carry deterministic integration-test proofs; decisions
carry no test obligation."** Honored as the obligation each kind bears.
Population re-enumerated from reality — the sixteen live stories under
`.ok-planner/design/stories/` (catalog pinned below): all sixteen carry a
`## Proof` section, and none of the twenty live decisions carries one. The story
catalog changed this cycle (one summary line repaired), which is why this audit
went stale; the membership it enumerates is unchanged at sixteen, and the
asymmetry holds over both populations. The shared definitions file states
"Decisions are audited, not proof-mandated", and `/prove` says the same.

**"A negative determination stands in place until a re-audit flips it, and
blocks certification unless linked to an intake issue awaiting the owner's
ruling."** Honored mechanically: `violated` with no `issue:` produces
`violated-unlinked`; `violated` with an `issue:` naming no file under `issues/`
or `history/issues/` produces `issue-link-dangling`. Nothing deletes a negative
audit — the auditor overwrites whole and the fixer is barred from touching the
file. This cycle exhibits the "stands until a re-audit flips it" half directly:
`decision:vendored-skills` carried a standing `violated` with a
`violated-unlinked` finding blocking the gate, the code was changed rather than
the record, and only a fresh adversarial read against a converged clone flipped
it.

**Rationale — "the fixer cannot satisfy an audit by any means except changing
the code it cites."** Holds, and this cycle is the demonstration. Editing the
audit is prohibited by both the auditor file and the certification core; leaving
the code alone leaves a standing `violated-unlinked` finding; editing the design
artifact instead trips `audit-stale-artifact`. The one route that worked was
changing the cited code — which broke the cited anchors and forced this re-read.

**Alternatives — "Hashing stamped bytes as-is and re-auditing at release time."**
A genuine road not taken, and negated in the code: the release skill states that
the checker's masking is why the release dispatches no agent and re-audits
nothing.

## Determination

**satisfied.** The whole regime is implemented in one deterministic checker both
gates consume as their clean bar — determination vocabulary, three citation
tiers, four staleness triggers, missing/orphaned/malformed findings, the
`violated-unlinked` block, the `--list-stale` re-audit set, and the asymmetric
proof obligation. The masking clause was re-derived against the tree as it now
stands: no converge core changed this cycle, so the stamp population is the same
four mechanisms, and a full simulated release of this repo — both manifests
bumped, the planner core re-converged, twenty-two files rewritten — produces zero
masked-hash divergences and a finding set byte-identical to the pre-release
baseline. The binary-pin case, where masking could have quietly weakened a
population pin, is handled by a strict decode with a raw-bytes fallback and held
by fixtures in both directions. The staleness machinery is itself exhibited by
this cycle end to end: the re-audit set was named by `--list-stale` rather than
by memory; the anchors that vanished were the exact lines the fix had to delete;
and a standing `violated` was flipped only by changing the code it cited.

This stops holding if: a new materialization site writes a stamp in a shape none
of the four masks covers (the whole-file pins on all three converge cores break
when any of them gains a substitution site, and the pinned spans over the four
mask definitions break if the masks move); the harness's masked or binary
fixtures are deleted or their assertions weakened (the whole-file pin on the
planner harness and the anchors on the five `run_case` lines break);
`masked_file_hash` stops decoding strictly, so a binary pin becomes forgeable;
the fixer's bar on editing audit files is removed; or `--list-stale` stops being
the re-audit set the gates consume. It would flip to violated if the Choice or
Rationale were tightened to claim the mask covers *only* release-mutable
metadata, since the family-scoped rule demonstrably masks more.

## Citations

- cite-span: plugins/ok/families/ok-planner/scripts/audit-check :: "def mask_release_metadata(text, target):" +13 sha256:b4095fb6d43a
- cite: plugins/ok/families/ok-planner/scripts/audit-check :: "STAMP_MASK = re.compile"
- cite-span: plugins/ok/families/ok-planner/scripts/audit-check :: "VERSION_STAMP_MASK = re.compile(" +3 sha256:e7583c1083de
- cite-span: plugins/ok/families/ok-planner/scripts/audit-check :: "MANIFEST_VERSION_MASK = re.compile(" +3 sha256:66a1433a7a09
- cite-span: plugins/ok/families/ok-planner/scripts/audit-check :: "SUITE_FAMILY = re.compile" +2 sha256:efafd5a34a7e
- cite: plugins/ok/families/ok-planner/scripts/audit-check :: "# A materialized stamp line names the family it was materialized by —"
- cite-span: plugins/ok/families/ok-planner/scripts/audit-check :: "def masked_file_hash(full, target):" +12 sha256:f379c0418422
- cite: plugins/ok/families/ok-planner/scripts/audit-check :: "        # A non-UTF-8 (binary) pin target carries no stamp to mask, and a"
- cite-span: plugins/ok/families/ok-planner/scripts/audit-check :: "def check_audit(root, path, live, findings, stale_refs):" +55 sha256:f5f073d2a484
- cite-span: plugins/ok/families/ok-planner/scripts/audit-check :: "        m = CITE_FILE_LINE.match(raw)" +19 sha256:db919afaef0b
- cite-span: plugins/ok/families/ok-planner/scripts/audit-check :: "    if determination == "violated":" +10 sha256:a2c6f92e3048
- cite: plugins/ok/families/ok-planner/scripts/audit-check :: "--list-stale prints only the artifact refs (kind:slug) needing"
- cite: plugins/ok/families/ok-planner/scripts/hooks/session-start :: "context="ok-planner v{{OK_PLANNER_VERSION}} is materialized in this project."
- cite: plugins/ok/families/ok-workspaces/scripts/src-tag :: "# ok-workspaces canonical src-tag script v{{OK_WORKSPACES_VERSION}}."
- cite: plugins/ok/families/ok-planner/test/run.sh :: "run_case "version bump masked""
- cite: plugins/ok/families/ok-planner/test/run.sh :: "run_case "edit beside stamp trips""
- cite: plugins/ok/families/ok-planner/test/run.sh :: "run_case "edit in hook banner trips""
- cite: plugins/ok/families/ok-planner/test/run.sh :: "run_case "edit in script header trips""
- cite: plugins/ok/families/ok-planner/test/run.sh :: "run_case "binary pin change trips""
- cite: .claude/skills/release/SKILL.md :: "No implementation audit goes stale — the vendored checker masks exactly these stamps"
- cite: plugins/ok/families/ok-planner/skills/_shared/implementation-auditor.md :: "the auditor is always a fresh dispatch, never the session that implemented the work under audit"
- cite: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "The fixer never edits an audit file"
- cite: plugins/ok/families/ok-planner/skills/certify-work/SKILL.md :: "The **re-audit set** is the union of"
- cite: plugins/ok/families/ok-planner/skills/certify-all/SKILL.md :: "the full gate re-derives every determination fresh"
- cite: plugins/ok/families/ok-planner/skills/_shared/artifact-definitions.md :: "**Decisions are audited, not proof-mandated.**"
- cite: plugins/ok/families/ok-planner/skills/prove/SKILL.md :: "Decisions carry no proofs; their verification is the implementation audit."
- cite-file: .ok-planner/design/stories.md @ sha256:a2bf08454f3a
- cite-file: plugins/ok/families/ok-planner/test/run.sh @ sha256:4244cb838cca
- cite-file: plugins/ok/families/ok-planner/admin/converge @ sha256:75db5f704edb
- cite-file: plugins/ok/families/ok-plumbline/admin/converge @ sha256:77508ce089a1
- cite-file: plugins/ok/families/ok-workspaces/scripts/converge.js @ sha256:86092f273c39
- cite-file: plugins/ok/.claude-plugin/plugin.json @ sha256:6ec970155f6e
