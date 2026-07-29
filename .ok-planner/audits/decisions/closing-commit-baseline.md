---
audit: closing-commit-baseline
artifact: decision:closing-commit-baseline
determination: satisfied
audited: 2026-07-28T00:00:00Z
artifact-hash: sha256:244d58f57a2a
---

# Whether the close is actually recorded as a `closed:` commit stamp on the archived sprint, and read back as the planning ceremony's baseline

Refreshed again. The design artifact's hash is unchanged. Both stale
citations are the same "6. **Offer the close-out.**" +1 span, on
`certify-work/SKILL.md` and `certify-all/SKILL.md`, moved by the Release
v11.2.0 commit's insertion of "together with its completion report and"
into the archive-move clause of that same numbered paragraph (both files
still carry the step as one long line, confirmed by re-reading each). The
load-bearing sentence this decision cites — "On the owner's yes, after the
archive commit lands, stamp the archived sprint with the closing commit …
and make one small follow-on commit for the stamp" — is byte-identical in
both files, untouched by the edit; only the phrase describing what else
travels with the archived sprint changed. Both files' spans still hash
identically to each other post-edit, so the symmetry claim this audit
rests on (both gates carry the same instruction) still holds by direct
re-comparison, not by assumption. Citations regenerated; nothing else
touched.

Refreshed, not rewritten. The design artifact's hash is unchanged. The one
stale citation — the `certify-completion` span in `test/proofs.sh` — moved
because this cycle added per-proof timing instrumentation across all six
test harnesses: a `section certify-completion` marker line was inserted
immediately before the block this citation pins, so the harness can attribute
elapsed time to the story it is proving. Read directly: the block's own
assertion logic (locate the newest archived sprint carrying `closed:`,
extract the sha, require `git cat-file -e <sha>^{commit}` to resolve it, fail
explicitly on either absence) is byte-identical apart from that one inserted
line — outside this decision's territory entirely, which is about what the
close-out stamps and what the planning ceremony reads back, not about how the
proof harness times itself. The determination and reasoning below stand by
recorded precedent.

Refreshed again. The design artifact's hash is unchanged. Both stale
citations are the same "6. **Offer the close-out.**" +1 span, on
`certify-work/SKILL.md` and `certify-all/SKILL.md`, moved by the
owner-ratified cap rewording: the trailing cap sentence in that same
paragraph changed from "remainders the owner escalated (or an unattended
run escalated by default) are verified issues like any others" to
"remainders the owner chose to escalate — the choice is always theirs —
are verified issues like any others" (both files identical, re-confirmed by
direct re-comparison). The load-bearing sentence this decision cites — "On
the owner's yes, after the archive commit lands, stamp the archived sprint
with the closing commit … and make one small follow-on commit for the
stamp" — is byte-identical in both files, untouched by the edit; only the
cap-choice clause at the paragraph's end changed, and this decision makes no
claim about the cap. Citations regenerated; nothing else touched.

## Claims

**Title — "The close is recorded as a commit stamp on the archived sprint."**
Holds. The record lives in the archived sprint file's own frontmatter and nowhere
else. Adversarially checked for a competing record: a sweep of the estate's
top-level directories finds `audits/ bin/ CLAUDE.md design/ history/ hooks/
issues/ scripts/ sketches/ sprints/` and no ledger, index, or state file of any
kind; the only prose in the corpus naming a baseline is this decision and the
stories/decisions that reference the mechanism by slug.

**"When a certification close-out archives a sprint and commits the work, it
stamps the archived sprint file's frontmatter with the closing commit —
`closed: <sha of the archive commit>`."** Population enumerated from reality:
the certification close-outs are the two certify gates, `certify-work` and
`certify-all`. There is no third — `/prove` and `/audit` are pure reporters that
write nothing, and `/plan-sprint` is terminal at the approved sprint. Both gates
carry the stamping instruction, both in the same numbered close-out step, and the
two spans hash identically (`sha256:0f5c8a98a0fa`), so the rule cannot have been
enforced on the everyday gate and forgotten on the periodic one — the failure
this quantifier most plausibly admits. The shared certification core states it a
third time, so the offer text itself names the stamp.

**"written after that commit lands and carried in one small follow-on commit."**
Honored explicitly and in that order: "On the owner's yes, after the archive
commit lands, stamp the archived sprint with the closing commit … and make one
small follow-on commit for the stamp." Both gates spell out the two accepted
shapes (a prepended frontmatter block, or a `closed:` line added to existing
frontmatter), so the instruction is executable rather than aspirational.

**"The planning ceremony resolves its out-of-band baseline as the newest archived
sprint's stamp."** Honored. `/plan-sprint`'s reconciliation phase resolves the
baseline as the `closed:` stamp of the newest file under
`.ok-planner/history/sprints/` that has one. "Newest *stamped*" rather than
"newest, then give up" is the reading the Choice's own next clause requires, so
the ceremony realizes the Choice rather than narrowing it.

**"and computes the reconciliation window from that commit to the current
tree."** Honored. The window is `git log --oneline <closed>..HEAD` plus the
uncommitted tree, and an empty window passes the phase silently — the current
tree is explicitly inside the window, not merely the committed history.

**"an archive with no stamped sprint yields no baseline, and the ceremony asks
the owner for one rather than guessing."** Honored, with the prohibition
explicit: "If no archived sprint carries a stamp (archives predating the
mechanism), say so and ask the owner, once, in prose, whether to name a baseline
ref or skip the walk this time — never guess one." The live archive is exactly
the mixed case that exercises both rules: of its two files,
`2026-07-25-ruled-intake-drain.md` carries no stamp and
`2026-07-26-vendored-suite-conduct-split.md` does, so "newest *stamped*" and the
no-stamp fallback are both live conditions rather than hypotheticals.

**Rationale — "makes 'what landed outside any sprint' a mechanical git question
instead of a memory question."** Holds: the baseline is a sha, the window is a
git command over that sha, the bearing/ambient split is a dispatched review over
that window, and guessing is forbidden. No step of the chain depends on anyone
remembering when the last close happened.

**Rationale — "it lives on the artifact that defines the boundary — the closed
sprint — so the record travels with the archive and needs no second ledger."**
Holds, and is verified against git rather than taken on the file's word: the
stamp reads `closed: e28227cdd096511307ad00ed3cf6e77c2ccdd138`, and that commit's
name-status shows `A .ok-planner/history/sprints/2026-07-26-vendored-suite-conduct-split.md`
— it is the commit that created the file under the archive, i.e. the archive
commit, exactly as the Choice specifies rather than merely a nearby sha.

**Rationale — "Stamping after the archive commit is what lets the stamp name that
commit exactly; the follow-on commit is the small price of an exact pointer."**
Holds; the ordering and the separate commit are both written into the two gates'
close-out steps as required acts, not as suggestions.

**Proof-side check (the mechanism's own exhibit).** The planner's proof harness
asserts the record end-to-end and was executed for this audit: it locates the
newest archived sprint carrying a `closed:` line, extracts the sha, requires
`git cat-file -e <sha>^{commit}` to resolve it, and fails explicitly both when no
archived sprint carries a stamp and when the stamp does not resolve. It reports
`ok: certify-completion: archived sprint carries a closed: stamp resolving to a
real commit (2026-07-26-vendored-suite-conduct-split.md)`.

## Determination

**satisfied.** Every clause of the Choice has a citable enforcement point, and
the enforcement is symmetric across the population that could break it: the stamp
is written by both certification close-outs, in one follow-on commit, after the
archive commit lands; the planning ceremony reads it back as its baseline,
computes the window from it including the uncommitted tree, and is forbidden in
so many words from guessing when no stamp exists; the live archive demonstrates
the stamp naming the actual archive commit; and a deterministic harness exhibits
the round trip. No competing baseline record exists anywhere in the estate.

This stops being true if: either gate's close-out step drops the stamping
sentence or reorders it before the archive commit (leaving the stamp unable to
name that commit); `/plan-sprint`'s reconciliation phase stops reading the
`closed:` stamp, starts inferring the close from git history, or starts guessing
a baseline instead of asking the owner; a separate baseline ledger file appears
in the estate; or the proof harness's `certify-completion` block stops requiring
the stamp to resolve to a real commit.

## Citations

- cite-span: plugins/ok/families/ok-planner/skills/certify-work/SKILL.md :: "6. **Offer the close-out.**" +1 sha256:9c603e82dc32
- cite-span: plugins/ok/families/ok-planner/skills/certify-all/SKILL.md :: "6. **Offer the close-out.**" +1 sha256:9c603e82dc32
- cite: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "closing commit (`closed: <sha>` frontmatter, one follow-on commit) —"
- cite-span: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md :: "1. **Resolve the baseline.**" +1 sha256:80d8a44de286
- cite-span: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md :: "2. **Compute the window.**" +1 sha256:fd6aad44e379
- cite-span: plugins/ok/families/ok-planner/test/proofs.sh :: "# --- certify-completion: the close leaves its record" +17 sha256:ea06f7295753
- cite: .ok-planner/history/sprints/2026-07-26-vendored-suite-conduct-split.md :: "closed: e28227cdd096511307ad00ed3cf6e77c2ccdd138"
