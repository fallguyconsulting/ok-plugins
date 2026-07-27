---
audit: adversarial-implementation-audits
artifact: decision:adversarial-implementation-audits
determination: satisfied
audited: 2026-07-27T00:00:00Z
artifact-hash: sha256:2f811bcc65f9
---

# Whether claims are verified by durable adversarial audits with mechanical staleness — and whether the checker now masks every release-mutable stamp materialization writes

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
gets re-audited."** Honored. All three trip staleness in `check_audit`:
`artifact-hash` mismatch → `audit-stale-artifact`; a vanished `cite:` anchor, a
mismatched span hash, or a mismatched `cite-file:` hash → `audit-stale-citation`.
`--list-stale` emits the machine-readable re-audit set; `certify-work` defines
its re-audit set as the union of touched artifacts and every ref the checker
lists, and `certify-all` re-derives every determination fresh.

**"The checker masks release-mutable metadata — the suite-version stamp lines
materialization writes and the plugin manifests' version fields — before hashing
anything a citation or pin covers, so a release that changes only versions voids
no audit."** Honored, and this is the clause a prior audit refuted; the ground it
stood on is closed. The population is "the suite-version stamp lines
materialization writes", re-enumerated from reality — every version substitution
site in all three carried families' converge cores, whose whole files are pinned
below — not from the decision's wording. The enumeration is exhaustive over four
mechanisms: the planner core's six `sed "s/{{OK_PLANNER_VERSION}}/…/g"` passes
plus its python vendor layer's `STAMP` constant; the plumbline core's cheatsheet
and post-edit substitutions, its `const VERSION = '0.0.0-unvendored'` rewrite,
and its binary's vendored-skill stamp; the workspaces `converge.js` `stamp()`
helper over src-tag and port-block plus its three generated stamp strings (the
worktree `.gitignore` header, the cheatsheet header, and the per-skill trailer
in `vendored-skills.js`); and the two `.claude-plugin/plugin.json` manifests.

Each member was checked by the audit's own method — materialize the file at
`11.0.0` and again at `11.0.1`, then compare the hash the checker itself
computes through `masked_file_hash` / `mask_release_metadata`. Every member came
back identical, including the two that escaped last time:
`.ok-planner/hooks/session-start`'s injected banner and
`.ok-workspaces/bin/src-tag`'s header comment. Both are now caught by the new
family-scoped rule — on a line naming an `ok-*` family, every `v<semver>` token
is masked — which is exactly the shape both escaping lines have.

The claim was then exercised end to end rather than member by member: a scratch
copy of this repo had both manifests bumped `11.0.0` → `11.0.1` and the planner
converge core re-run, which is precisely what the release act's step 5c does.
Twenty-two files changed. Every one of them hashes identically under the
checker's mask, and `audit-check` over the released tree returns a finding set
byte-identical to the baseline — not one new `audit-stale-citation`. "A release
that changes only versions voids no audit" is true as stated, exhibited rather
than asserted.

The harness now proves the same property from the other side: `masked-version-bump`
carries all five stamp shapes two releases ahead of the audit citing them and
must exit 0, while its twin `masked-edit-trips` carries a non-version edit on
each of those same five surfaces and must trip — with three of the five asserted
by their own distinctive substring, so a mask that swallowed a whole line could
not pass unnoticed. All nineteen cases pass.

**"before hashing anything a citation or pin covers."** Honored including the
non-text case, which is where masking could have quietly weakened a pin:
`masked_file_hash` decodes strictly and, on `UnicodeDecodeError`, hashes the raw
bytes rather than decoding lossily. That matters because a lossy decode is not
injective — the `binary-pin-changed` fixture's two blobs differ only in the
invalid-UTF-8 bytes `ff fe` versus `fe ff`, which `errors="replace"` would
collapse to identical replacement characters and an identical hash. The fixture
asserts the pin still trips, and the `clean` fixture now carries a binary pin
that must not trip, so both directions are held.

**Rationale — "Version stamps sit inside otherwise-cited bytes and must change
on every release, so masking them is what keeps the tripwire meaningful:
staleness signals substantive change, never the release act, while any edit
beyond the masked patterns still breaks its anchor."** Honored, both halves. The
release half is the twenty-two-file demonstration above. The second half is
exercised by four harness cases, and the wording is precise where it could have
overclaimed: it says "the masked patterns", not "version stamps", which is the
honest description of a regex-based mask.

Adversarial note, recorded and not charged, because no sentence of the artifact
claims the mask is minimal. The family-scoped rule masks a strict superset of
the stamp population: any `v<semver>` on any line naming an `ok-*` family,
wherever it appears. Collateral members exist in this tree — the illustrative
version table in the front door's skill, and archived-sprint prose reading
"retired in suite v9.0.0" on a line that happens to name `.ok-planner`. Exhibited
by construction: rewriting `ok-planner v9.0.0-behind` to `ok-planner v1.2.3`
inside the `see-governing-versions` proof fixture leaves that story's `cite-span`
hash at `sha256:6dd48908c28e`, unchanged. The exposure is bounded — that
particular edit still breaks the assertion two lines below, which carries the
literal without a `v` prefix and is hashed as written — but the tripwire is now
blind to version literals on family-naming lines generally, which is wider than
"the suite-version stamp lines materialization writes". It is also what made
`decision:no-execution-engine`'s archived-sprint pin go stale in this cycle with
nothing in that file changed. If the Choice is ever tightened to say the mask
covers *only* release-mutable metadata, this becomes a violation.

**"Stories additionally carry deterministic integration-test proofs; decisions
carry no test obligation."** Honored as the obligation each kind bears.
Population re-enumerated from reality — the sixteen live stories under
`.ok-planner/design/stories/` (catalog pinned below): all sixteen carry a
`## Proof` section, and no live decision carries one. The shared definitions file
states "Decisions are audited, not proof-mandated", `/prove` says the same, and
the converge core treats a decision `## Proof` section as retired layout.

**"A negative determination stands in place until a re-audit flips it, and
blocks certification unless linked to an intake issue awaiting the owner's
ruling."** Honored mechanically: `violated` with no `issue:` produces
`violated-unlinked`; `violated` with an `issue:` naming no file under `issues/`
or `history/issues/` produces `issue-link-dangling`. Nothing deletes a negative
audit — the auditor overwrites whole and the fixer is barred from touching the
file.

**Rationale — "the fixer cannot satisfy an audit by any means except changing
the code it cites."** Holds. Editing the audit is prohibited by both the auditor
file and the certification core; leaving the code alone leaves a standing
`violated-unlinked` finding; editing the design artifact instead trips
`audit-stale-artifact`.

**Alternatives — "Hashing stamped bytes as-is and re-auditing at release time."**
A genuine road not taken, and negated in the code: the release skill states that
the checker's masking is why the release dispatches no agent and re-audits
nothing.

## Determination

**satisfied.** The whole regime is implemented in one deterministic checker both
gates consume as their clean bar — determination vocabulary, three citation
tiers, four staleness triggers, missing/orphaned/malformed findings, the
`violated-unlinked` block, the `--list-stale` re-audit set, and the asymmetric
proof obligation. The clause a prior audit refuted now holds: the stamp
population was re-enumerated across all three families' converge cores and every
member masks identically at two versions, including the session hook's banner and
the workspaces src-tag header that previously escaped; and a full simulated
release of this repo — both manifests bumped, the planner core re-converged,
twenty-two files rewritten — produces exactly zero new staleness. The binary-pin
case, where masking could have quietly weakened a population pin, is handled by a
strict decode with a raw-bytes fallback and held by fixtures in both directions.

This stops holding if: a new materialization site writes a stamp in a shape none
of the four masks covers (the whole-file pins on all three converge cores break
when any of them gains a substitution site, and the pinned spans over the four
mask definitions break if the masks move); the harness's masked or binary
fixtures are deleted or their assertions weakened (the whole-file pin on `run.sh`
and the anchors on the five `run_case` lines break); `masked_file_hash` stops
decoding strictly, so a binary pin becomes forgeable; the fixer's bar on editing
audit files is removed; or `--list-stale` stops being the re-audit set the gates
consume. It would flip to violated if the Choice or Rationale were tightened to
claim the mask covers *only* release-mutable metadata, since the family-scoped
rule demonstrably masks more.

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
- cite-file: .ok-planner/design/stories.md @ sha256:25682d5ab708
- cite-file: plugins/ok/families/ok-planner/test/run.sh @ sha256:4244cb838cca
- cite-file: plugins/ok/families/ok-planner/admin/converge @ sha256:75db5f704edb
- cite-file: plugins/ok/families/ok-plumbline/admin/converge @ sha256:39b416a79268
- cite-file: plugins/ok/families/ok-workspaces/scripts/converge.js @ sha256:86092f273c39
- cite-file: plugins/ok/.claude-plugin/plugin.json @ sha256:6ec970155f6e
