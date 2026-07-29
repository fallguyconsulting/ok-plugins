---
audit: certify-completion
artifact: story:certify-completion
determination: satisfied
audited: 2026-07-28T18:00:00Z
artifact-hash: sha256:06cfab3570ba
---

# Does one terminal gate align work to its sprint, drive findings to zero unattended, and present outcomes and divergences whole?

The design artifact's hash is unchanged since the prior audit; the prior
audit carried no `## Notes` ledger, so there is no adjudication binding
this pass and none is opened. Two things beneath it moved this cycle,
neither inside this claim's territory — `test/proofs.sh` gained per-proof
timing instrumentation around its existing assertions plus a new story's
block (this story's own cited span, the close-record section, is
byte-identical past the instrumentation's insertion point being re-pinned
at its new offset), and `admin/converge`'s `SKILLS` map gained an
unrelated `browse` entry while still carrying `certify-work` and
`certify-all` — so this pass is a citation refresh: the gate files and the
shared core are byte-identical (their whole-file pins still verify), and
the proof half was re-checked against the harness's current bytes rather
than carried.

## Claims

**Title / Story — "one terminal gate that aligns finished work to its
sprint, drives every fixable finding to zero without my mid-run
involvement, and presents outcomes and divergences to me whole, so that
'done' means the same thing for every piece of work and I keep an
after-the-fact veto over every call made in my absence."** Honored in the
sense the story means, with the population enumerated rather than assumed:
the converge core's `SKILLS` map vendors two certification verbs,
`certify-work` and `certify-all`, and both were read in full. They are one
gate in the load-bearing sense — everything except scope is shared
verbatim from `skills/_shared/certification-core.md`, both were checked
clause by clause below, and the sprint boilerplate names exactly one of
them as the terminal step. This audit records, as the prior one did, that
"one terminal gate" is not a cardinality claim about how many
certification verbs exist.

**Acceptance 1 — "The owner (or the sprint's own boilerplate) invokes
certification over completed work."** Honored: `certify-work`'s
frontmatter names both entry points ("ONLY activated by explicit
/certify-work slash command, or as the terminal step named in the sprint
document's execution boilerplate"), and the ceremony's baked completion
contract names `/certify-work` in return — the two ends of the same
handshake.

**Acceptance 2 — "sprint alignment is verified with undershoot treated as
blocking."** Honored in both gates in exactly those terms: the alignment
producer checks every corpus delta applied verbatim and every work item's
outcome realized, enumerates the undershoot shapes (stub, no-op, `TODO`,
deferred handler, declared-but-unemitted error, accepted-but-ignored
flag), and closes "An undershoot is a **blocking** finding." The shared
code-review prompt carries the same rule from the reviewer's side ("A
promised outcome not really delivered is a blocking finding even when
every test is green").

**Acceptance 3 — "the completion-contract verbs run."** Honored, checked
against the contract's own text rather than against the gate's. The
ceremony bakes a four-item contract — deltas applied verbatim, `/prove`
clean over new and touched stories, the implementation-audit corpus
current for everything the change touched or made stale with any standing
violation linked, and `/certify-work`'s review-fix loop run last and
clean. `certify-work`'s producers are exactly that set: alignment over the
deltas and work items, prove at touched scope, the implementation audit
over the two-layer re-audit set, the change-scoped corpus checks, and code
review over the diff. `certify-all` runs the same set at full scope plus
the whole-corpus `/audit`.

**Acceptance 4 — "implementation audits are written or refreshed by an
auditor that did not implement the work — covering the touched artifacts
and everything the change made stale."** Honored on both halves, and the
second half is now wider than the story's minimum rather than narrower.
Author separation is stated as load-bearing in the auditor prompt's
consumer notes and reinforced by the core's bar on the fixer editing an
audit file. The coverage half is computed rather than remembered: the
re-audit set is the union of the touched stories and decisions, every ref
`audit-check --list-stale` names (explicitly including audits outside the
delta whose cited code or population sources the change happened to
touch), and every audit the change inspector nominated. The loop
recomputes that union after each fix cycle, regenerating the graph first,
because the fixer's edits move the hashes of whatever they touch. This
cycle is again the mechanism working rather than an assertion, and at a
finer grain than last time: a fix that touched two lines of one story's
harness fixture and the comment above them made seven story audits stale
by their `cite-file` pins — this one among them — and `audit-check
--list-stale` named exactly that set, no more and no fewer.

**Acceptance 5 — "code and design-doc reviews dispatch."** Honored: the
diff-scoped code review from the shared core, and the shared compliance
reviewer scoped to the touched artifacts (skipped silently only where
there is no corpus or nothing was touched).

**Acceptance 6 — "a no-discretion fix loop drives findings to zero within
a bounded number of cycles."** Honored, with the no-discretion property
stated as a constraint on the orchestrator rather than left implicit: it
"does not summarize, filter, reorder, or defer findings; it moves verbatim
lists between the producers, the fixer, and the architect, and it counts
cycles." The bound is three fixer passes with defined behaviour on both
branches — the interactive run puts the choice to the owner, the
unattended run proceeds and reports the remainder as NOT certified with no
close-out offered.

**Acceptance 7 — "truly unclear findings are filed to the intake queue,
never asked live."** Honored: promotion is the architect's act after a
kickback survives an adversarial owner-roleplay check, and the core states
"Promotion is the loop's only path to the intake, and the owner is never
asked live." Both gates' NOT-do lists repeat it, and the fixer and
architect prompts each carry the veto test that gates the transition.

**Acceptance 8 — "the owner then receives one whole presentation —
status, outcomes, divergences including every call made where sprint and
corpus were silent, findings fixed, issues filed."** Honored. The
presentation block fixes the sections and is composed in full rather than
paced; Divergences is specified to carry every fixer call made where the
sprint and corpus were silent, every corpus repair, and every architect
refutation, with the counter-rule that a fixed undershoot "must never
appear here — it was fixed, not reported." The block has since gained a
Reconciliation ledger section (dispositions, adjudication outcomes,
residue enumerated), which is a superset of what the story asks and
extends the after-the-fact veto to change no claim accounted for.

**Acceptance 9 — "the sprint archives only when clean, with committing
left to the owner and the close-out recording the close so the next
planning ceremony can detect what lands after it."** Honored across three
points in both gates: the close-out offer is conditioned on "everything
certified clean"; both archive and commit are performed "only when the
owner says so", with "Does not archive or commit on its own initiative" in
the NOT-do list; and the close-out stamps the archived sprint with
`closed: <sha>` in one follow-on commit. The consuming end is real — the
ceremony's baseline resolution reads exactly that stamp and refuses to
guess when none exists.

**Falsifier.** Each of the seven conditions has a counterpart
prohibition: undershoot blocking rather than reported; author separation
in the auditor prompt; the orchestrator's no-discretion rule; the
never-ask-live rule; the clean-status gate on archival; the `closed:`
stamp; and Divergences as the after-the-fact veto channel.

**Proof — "a certification over work seeded with an undershot work item
and a silent-intent gap, after which a third party sees the undershoot
fixed (absent from the presentation), the gap either fixed-and-reported as
a divergence or filed as an issue, the sprint archived only on clean
status, and the archived sprint carrying its close record."** The story is
annotated in `test/proofs.sh`. Its one deterministically exhibitable
conjunct — the close record — is exercised against reality rather than
modelled: the newest archived sprint carrying a `closed:` stamp is
resolved as a commit through `git cat-file`, so a stamp naming nothing
fails. The seeded run itself is prompt-realized (the gate is a prompt; a
shell harness cannot drive five producers and a fixer loop), and the block
says so at that assertion, then pins the governing sentences verbatim in
the gate a project runs and its shared core: the blocking-undershoot rule,
the bar on a fixed undershoot appearing in Divergences, the silent-intent
call's Divergences channel, and the clean-status condition on archival.
Re-run this cycle: all five assertions pass, and the block itself was
untouched by the cycle's edit (its pinned span hash is unchanged; only
the file's whole-file pin moved, from the sharpened heredoc fixture inside
the `deterministic-source-graph` block elsewhere in the file).

The proof's span against the Acceptance is therefore partial by
construction and honestly labelled: one conjunct exhibited against a real
archived sprint and a real commit, four pinned as the text that produces
them. That is not a green proof exercising less than it claims — the
harness states at the assertion what is prompt-realized and names the file
and step carrying it — but it does mean a regression in the gate's
*behaviour* that leaves those four sentences intact would not turn the
harness red.

## Determination

**satisfied.** Every mechanism claim in the Acceptance and the Falsifier
has a specific, citable enforcement point across `certify-work`,
`certify-all`, `certification-core.md` and `implementation-auditor.md`,
and the properties the story stakes itself on — a blocking undershoot, an
auditor that did not implement, a computed rather than remembered
staleness set, a bounded no-discretion loop, an architect-only path to the
intake, a whole presentation, and a close that leaves a resolvable
baseline — are all real and consistent between the two gates. The
re-audit-set clause is now delivered by two layers rather than one, which
widens coverage without weakening any clause the story makes. The
annotated proof exercises the one conjunct a shell harness can exhibit
against a real archived sprint and a real commit, and pins the
prompt-realized conjuncts at their assertions.

Two non-determinative notes for a later reader. "One terminal gate" reads
against a two-verb implementation — accurate in the sense the story means,
not a cardinality claim. And the archival-gate assertion matches on the
phrase "certified clean", which occurs once in the gate; it is a precise
pin today and would weaken if that phrase appeared elsewhere in the file.

This stops holding if: the blocking-undershoot sentence, the "must never
appear here" bar, the silent-intent Divergences sentence, or the
clean-status condition is reworded (the harness's four greps break first);
author separation is dropped from the auditor prompt, or the auditor is
allowed to be the implementing session; the re-audit set stops being
computed from `audit-check --list-stale` plus the inspector's nominations;
the three-pass cap or the unattended branch is removed; promotion stops
being the loop's only path to the intake; the close-out stops stamping
`closed:`, or the ceremony stops reading it as its baseline; the two gates
stop sharing the core, so "one meaning of done" becomes false; or
`test/proofs.sh` loses its `certify-completion` block or its `@story:`
annotation — in particular the git-resolvable check on the stamp, without
which the close record is asserted only as text.

## Citations

- cite: plugins/ok/families/ok-planner/skills/certify-work/SKILL.md :: "An undershoot is a **blocking** finding."
- cite: plugins/ok/families/ok-planner/skills/certify-work/SKILL.md :: "**Prove, touched scope.** Invoke `ok-planner:prove` scoped to the touched stories"
- cite-span: plugins/ok/families/ok-planner/skills/certify-work/SKILL.md :: "   - **Implementation audit, two layers.**" +1 sha256:780fc092f43a
- cite: plugins/ok/families/ok-planner/skills/certify-work/SKILL.md :: "   - **Code review, scoped to the diff.**"
- cite-span: plugins/ok/families/ok-planner/skills/certify-work/SKILL.md :: "6. **Offer the close-out.**" +1 sha256:0f5c8a98a0fa
- cite: plugins/ok/families/ok-planner/skills/certify-work/SKILL.md :: "Does not archive or commit on its own initiative."
- cite: plugins/ok/families/ok-planner/skills/certify-all/SKILL.md :: "1. **Sprint alignment** — did the work realize the sprint?"
- cite-span: plugins/ok/families/ok-planner/skills/certify-all/SKILL.md :: "   - **Implementation audit, whole-corpus.**" +1 sha256:f827ec257b51
- cite: plugins/ok/families/ok-planner/skills/_shared/implementation-auditor.md :: "**Author separation is load-bearing:**"
- cite-span: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "**Phase B — the cycle: fixer → architect → re-review.**" +12 sha256:f6aabce54b78
- cite: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "After **3 fixer passes** without a clean review"
- cite: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "Promotion is the loop's only path to the intake"
- cite-span: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "### {{CERTIFY-PRESENTATION}}" +25 sha256:23d53461f0bd
- cite: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "An undershoot must never appear here"
- cite-span: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "## Reconciliation ledger" +8 sha256:b33ce3b03c6f
- cite: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md :: "1. **Resolve the baseline.** Every sprint closed by a certify gate carries the closing commit"
- cite-span: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md :: "3. The implementation-audit corpus is current for everything the" +3 sha256:7906ab742c3d
- cite-span: plugins/ok/families/ok-planner/admin/converge :: "SKILLS = {" +13 sha256:19e4a08de7f5
- cite-span: plugins/ok/families/ok-planner/test/proofs.sh :: "# --- certify-completion: the close leaves its record --------------------------" +36 sha256:0275dfba61af
- cite-node: plugins/ok/families/ok-planner/skills/certify-work/SKILL.md @ sha256:d774d6480349
- cite-node: plugins/ok/families/ok-planner/skills/certify-all/SKILL.md @ sha256:2c584566d01a
- cite-node: plugins/ok/families/ok-planner/skills/_shared/certification-core.md @ sha256:f96e5bcb96d6
- cite-node: plugins/ok/families/ok-planner/test/proofs.sh @ sha256:560784191d5a
