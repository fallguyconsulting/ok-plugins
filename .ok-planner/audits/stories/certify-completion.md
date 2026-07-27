---
audit: certify-completion
artifact: story:certify-completion
determination: satisfied
audited: 2026-07-27T12:26:54Z
artifact-hash: sha256:06cfab3570ba
---

# Does one terminal gate align work to its sprint, drive findings to zero unattended, and present outcomes and divergences whole?

## Claims

**Title / Story — "one terminal gate that aligns finished work to its sprint,
drives every fixable finding to zero without my mid-run involvement, and
presents outcomes and divergences to me whole, so that 'done' means the same
thing for every piece of work."** Honored in the sense the story means. The
population of certification verbs was enumerated from the converge core's
`SKILLS` map and is two — `certify-work` and `certify-all` — but they are one
gate in the load-bearing sense: everything except scope is shared verbatim from
`skills/_shared/certification-core.md`, and the sprint boilerplate names
exactly one of them as the terminal step. "One meaning of done" is what the
shared core makes true.

**Acceptance 1 — "The owner (or the sprint's own boilerplate) invokes
certification over completed work."** Honored: the gate's own description names
both entry points, and the sprint boilerplate's step 8 names `/certify-work`.

**Acceptance 2 — "sprint alignment is verified with undershoot treated as
blocking."** Honored, in exactly those terms: the alignment producer checks
every corpus delta applied verbatim and every work item's outcome realized,
enumerating the undershoot shapes (stub, no-op, `TODO`, deferred handler,
declared-but-unemitted error, accepted-but-ignored flag) and closing with "An
undershoot is a **blocking** finding."

**Acceptance 3 — "the completion-contract verbs run."** Honored. The producers
are prove at the touched scope, the implementation audit over a computed
re-audit set, the corpus checks, and code review over the diff — the same four
the sprint's own completion contract enumerates.

**Acceptance 4 — "implementation audits are written or refreshed by an auditor
that did not implement the work — covering the touched artifacts and everything
the change made stale."** Honored on both halves. Author separation is stated
as load-bearing in the auditor prompt itself; the re-audit set is computed, not
judged — the union of the touched stories and decisions with everything
`audit-check --list-stale` names, explicitly including audits outside the
delta whose cited code the change happened to touch — and the loop recomputes
it after each fix cycle for the same reason.

**Acceptance 5 — "code and design-doc reviews dispatch."** Honored: the diff-
scoped code review from the shared core, and the shared compliance reviewer
scoped to the touched artifacts.

**Acceptance 6 — "a no-discretion fix loop drives findings to zero within a
bounded number of cycles."** Honored, and the no-discretion property is stated
as a constraint on the orchestrator rather than left implicit: it "does not
summarize, filter, reorder, or defer findings; it moves verbatim lists between
the producers, the fixer, and the architect, and it counts cycles." The bound
is three fixer passes, with a defined behaviour on both the interactive and the
unattended branch.

**Acceptance 7 — "truly unclear findings are filed to the intake queue, never
asked live."** Honored: promotion is the architect's act after a kickback
survives an adversarial check, and the core states "Promotion is the loop's
only path to the intake, and the owner is never asked live."

**Acceptance 8 — "the owner then receives one whole presentation — status,
outcomes, divergences including every call made where sprint and corpus were
silent, findings fixed, issues filed."** Honored: the presentation block fixes
those five sections, and Divergences is specified to carry every fixer call
made where the sprint and corpus were silent, every corpus repair, and every
architect refutation — with the counter-rule that a fixed undershoot "must
never appear here — it was fixed, not reported."

**Acceptance 9 — "the sprint archives only when clean, with committing left to
the owner and the close-out recording the close so the next planning ceremony
can detect what lands after it."** Honored across three points: the close-out
offer is conditioned on "everything certified clean", both archive and commit
are performed "only when the owner says so", the close-out stamps the archived
sprint with `closed: <sha>`, and the ceremony's baseline resolution reads
exactly that stamp.

**Falsifier.** Each condition has its counterpart prohibition: undershoot
blocking rather than reported; author separation; the orchestrator's no-
discretion rule; the never-ask-live rule; the clean-status gate on archival;
the close record; and Divergences as the after-the-fact veto channel.

**Proof — "a certification over work seeded with an undershot work item and a
silent-intent gap, after which a third party sees the undershoot fixed (absent
from the presentation), the gap either fixed-and-reported as a divergence or
filed as an issue, the sprint archived only on clean status, and the archived
sprint carrying its close record."** The story is annotated in
`test/proofs.sh`. Its deterministic conjunct — the close record — is exercised
against reality: the newest archived sprint carrying a `closed:` stamp is
resolved as a commit through `git cat-file`, so a stamp naming nothing fails.
The seeded run itself is prompt-realized (the gate is a prompt; a shell harness
cannot drive it), and the harness says so at that assertion, then asserts the
three governing sentences stand verbatim in the gate and its shared core: the
blocking-undershoot rule, the bar on a fixed undershoot appearing in
Divergences, the silent-intent call's Divergences channel, and the clean-status
condition on archival. All assertions pass on the current tree.

## Determination

**satisfied.** Every mechanism claim in the Acceptance and the Falsifier has a
specific, citable enforcement point across `certify-work`, `certify-all`,
`certification-core.md`, and `implementation-auditor.md`, and the properties the
story stakes itself on — a blocking undershoot, an auditor that did not
implement, a computed staleness set, a bounded no-discretion loop, an
architect-only path to the intake, a whole presentation, and a close that
leaves a resolvable baseline — are all real and consistent between the two
gates. The story now carries an annotated proof: its one deterministically
exhibitable conjunct is exercised against a real archived sprint and a real
commit, and its three prompt-realized conjuncts are pinned to the governing
sentences in the gate a project runs, each named at its assertion.

Two non-determinative notes for a later reader. "One terminal gate" reads
against a two-verb implementation; it is accurate in the sense the story means
(one shared machinery, one meaning of done, one gate named by the boilerplate)
and a reader should not take it as a claim that only one certification verb
exists. And the archival-gate assertion matches on the phrase "certified
clean", which occurs exactly once in the gate — in the gating sentence — so it
is currently a precise pin, but it would weaken if that phrase appeared
elsewhere in the file.

This determination stops holding if: the blocking-undershoot sentence, the
"must never appear here" bar, the silent-intent Divergences sentence, or the
clean-status condition is reworded (the harness's four greps break first);
author separation is dropped from the auditor prompt, or the auditor is allowed
to be the implementing session; the re-audit set stops being computed from
`audit-check --list-stale`; the three-pass cap or the unattended branch is
removed; promotion stops being the loop's only path to the intake; the close-out
stops stamping `closed:`, or the ceremony stops reading it as its baseline; or
`test/proofs.sh` loses its `certify-completion` block or its `@story:`
annotation — including the git-resolvable check on the stamp, without which the
close record is asserted only as text.

## Citations

- cite: plugins/ok/families/ok-planner/skills/certify-work/SKILL.md :: "An undershoot is a **blocking** finding."
- cite: plugins/ok/families/ok-planner/skills/certify-work/SKILL.md :: "**Prove, touched scope.** Invoke `ok-planner:prove` scoped to the touched stories"
- cite: plugins/ok/families/ok-planner/skills/certify-work/SKILL.md :: "The **re-audit set** is the union of: the touched stories and decisions"
- cite: plugins/ok/families/ok-planner/skills/certify-work/SKILL.md :: "**Code review, scoped to the diff.**"
- cite-span: plugins/ok/families/ok-planner/skills/certify-work/SKILL.md :: "6. **Offer the close-out.**" +1 sha256:0f5c8a98a0fa
- cite: plugins/ok/families/ok-planner/skills/certify-work/SKILL.md :: "Does not archive or commit on its own initiative."
- cite: plugins/ok/families/ok-planner/skills/_shared/implementation-auditor.md :: "**Author separation is load-bearing:**"
- cite-span: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "**Phase B — the cycle: fixer → architect → re-review.**" +12 sha256:8a1655f822bf
- cite: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "After **3 fixer passes** without a clean review"
- cite: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "**Promotion is the loop's only path to the intake, and the owner is never asked live.**"
- cite-span: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "### {{CERTIFY-PRESENTATION}}" +25 sha256:23d53461f0bd
- cite: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "An undershoot must never appear here"
- cite: plugins/ok/families/ok-planner/skills/plan-sprint/SKILL.md :: "1. **Resolve the baseline.** Every sprint closed by a certify gate carries the closing commit"
- cite-span: plugins/ok/families/ok-planner/test/proofs.sh :: "# --- certify-completion: the close leaves its record" +36 sha256:0dadf383ab79
- cite-file: plugins/ok/families/ok-planner/skills/certify-work/SKILL.md @ sha256:4ea1d1df8db9
- cite-file: plugins/ok/families/ok-planner/skills/certify-all/SKILL.md @ sha256:7ef808fef465
- cite-file: plugins/ok/families/ok-planner/test/proofs.sh @ sha256:f96535bcf843
