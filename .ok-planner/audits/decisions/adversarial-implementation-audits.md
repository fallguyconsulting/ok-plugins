---
audit: adversarial-implementation-audits
artifact: decision:adversarial-implementation-audits
determination: satisfied
audited: 2026-07-27T11:28:54Z
artifact-hash: sha256:f39a73d043b0
---

# Whether story and decision claims are verified by durable adversarial audits with mechanical staleness, rather than per-claim test mandates

## Claims

**Title — "Implementation claims are verified by adversarial audits, not test
mandates."** Both halves hold. The auditor prompt exists as a canonical shared
block dispatched by both certification gates, and it is written as a refutation
exercise, not a confirmation one. No skill anywhere requires a registered test
per claim; the only runtime obligation in the corpus is the story proof, which
is separate and narrower (`/prove` explicitly disclaims adequacy judgment).

**"a durable, per-artifact determination (`satisfied` or `violated`) recorded in
a fourth corpus collection."** Honored. The checker hard-codes the two
determination values and refuses anything else as `audit-malformed`; the
collection is `.ok-planner/audits/{stories,decisions}/`, and the checker derives
the live population from `.ok-planner/design/{stories,decisions}/` and reports
`audit-missing` for any live artifact with no audit file, `audit-orphaned` for
the reverse. Path placement is itself checked: an audit whose `artifact:` ref
does not match its directory and basename is malformed.

**"written only by a certification producer that did not implement the work
under audit, and never hand-edited."** Enforced at the only layer that can
enforce it here — prompt text, which is this project's executable substance.
The auditor file states author separation as load-bearing and forbids the fixer
from editing audit files; the shared review-fix loop repeats the same rule from
the orchestrator's side, and adds the one exception (the architect stamps the
`issue:` link on promotion). Adversarial note: nothing mechanical prevents a
human or an implementing session from writing an audit file. That is a
recognised limit of a prompt-enforced regime, not a gap between the Choice and
the code — the Choice describes the discipline, and the discipline is stated at
every point that could violate it.

**"Audits cite code by content anchors and pin quantified claims' population
sources by file hash."** Honored, with three tiers implemented and machine-read:
existence (`cite:`), mechanism (`cite-span:` — anchor plus N lines, content
hashed, with an `anchor-ambiguous` finding when the anchor is not unique), and
population (`cite-file:` — whole-file pin). Line numbers appear in no citation
form. The auditor's helper subcommands compute the hashes so no auditor
hand-computes one.

**"a deterministic checker flags any audit whose design artifact, cited code, or
population source has changed."** All three trip staleness in one function:
`artifact-hash` mismatch → `audit-stale-artifact`; a missing `cite:` anchor, a
mismatched span hash, or a mismatched `cite-file:` hash → `audit-stale-citation`.
The checker is a self-contained python script with no judgment path — exit 0
clean, 2 findings, 1 internal error.

**"the stale set — not human memory — is what gets re-audited."** Honored and
computed, not judged. `--list-stale` emits the machine-readable re-audit set;
`certify-work` defines its re-audit set as the union of touched artifacts and
every ref the checker lists, explicitly including audits outside the change's
delta; the shared loop's re-review step names `audit-check --list-stale` as the
definition of "whose subject a fix touched"; `certify-all` re-derives everything
on the initial pass and narrows re-review to the stale list.

**"Stories additionally carry deterministic integration-test proofs; decisions
carry no test obligation."** Honored as the obligation the regime imposes.
Population enumerated from reality — the sixteen live stories in
`.ok-planner/design/stories.md` (pinned below): all sixteen carry a `## Proof`
section, and `/prove` collects proof artifacts by `@story:` annotation and
reports `missing` where there is none. Decisions carry no `## Proof` section and
`/prove` states it does not audit them. Recorded gap, adversarially: eight of
the sixteen live stories currently have no annotated proof artifact anywhere in
the tree (`bootstrap-design-corpus`, `content-addressed-artifacts`,
`corpus-audit`, `edit-time-lint-enforcement`, `incremental-lint-adoption`,
`rules-compliance-report`, `see-governing-versions`, `sketch-an-idea`). That is
a live coverage defect, but it is a defect `/prove` is built to report as
`missing` and the certify gates' coverage check is built to raise — it does not
refute this decision's claim, which is about which obligation each artifact kind
bears, not about the current corpus's coverage. The obligation exists, is
machine-run, and is asymmetric exactly as claimed.

**"A negative determination stands in place until a re-audit flips it, and
blocks certification unless linked to an intake issue awaiting the owner's
ruling."** Honored mechanically. `violated` with no `issue:` produces
`violated-unlinked`; `violated` with an `issue:` that names no file under
`issues/` or `history/issues/` produces `issue-link-dangling`. Both gates state
their clean bar as "audit-check exits 0 and no in-scope determination is
`violated` without an issue link". Nothing deletes a negative audit: the auditor
overwrites whole on re-audit, and the fixer is barred from touching the file.

**Rationale — "the fixer cannot satisfy an audit by any means except changing
the code it cites, which breaks its anchors and forces a fresh adversarial
read."** Holds. The two escape routes are closed: editing the audit is
prohibited by both the auditor file and the loop; leaving the code alone leaves
the audit `violated` and unlinked, which is itself a standing finding the loop
re-collects. Editing the design artifact instead changes `artifact-hash` and
trips `audit-stale-artifact`, which also forces the re-audit.

**Rationale — "Content anchors rather than line numbers make the tripwire
survive unrelated edits; whole-file pins on population sources make a new member
re-open the exact audits whose quantifiers it threatens."** Holds. Anchors are
located by normalized substring search over the file's lines, so unrelated
additions that move code do not break them, while an edit inside a pinned span
changes the span hash. A `cite-file:` pin trips on any byte change to the
enumeration source, which is precisely the "new member appears" signal.

## Determination

**satisfied.** Every normative clause of the Choice has a citable enforcement
point, and the mechanical half of the regime — the determination vocabulary, the
three citation tiers, the four staleness triggers, the missing/orphaned/malformed
findings, the violated-unlinked block, and the `--list-stale` re-audit set — is
implemented in one deterministic checker that both gates consume as their clean
bar. The prompt half — author separation, no hand-editing, adversarial bias,
overwrite-whole re-audits — is stated at each point where it could be violated,
which is the enforceable layer for prompt-executed machinery.

This stops being true if any of the following change: the checker loses one of
its four staleness triggers or the `violated-unlinked` finding; either gate stops
deriving its re-audit set from `--list-stale` and reverts to a judged scope; the
auditor file drops the author-separation rule or the loop drops the fixer's
prohibition on editing audit files; a `## Proof` section is added to the decision
template or a test obligation is attached to decisions; or the story catalog
grows a story kind with no proof obligation. The eight unproven stories noted
above do not affect this determination, but if the `Proof` section were dropped
from story artifacts rather than merely unrealized in code, the asymmetry clause
would fail.

## Citations

- cite-span: plugins/ok/families/ok-planner/scripts/audit-check :: "def check_audit(root, path, live, findings, stale_refs):" +55 sha256:f5f073d2a484
- cite-span: plugins/ok/families/ok-planner/scripts/audit-check :: "    if determination == "violated":" +10 sha256:a2c6f92e3048
- cite-span: plugins/ok/families/ok-planner/scripts/audit-check :: "        m = CITE_FILE_LINE.match(raw)" +19 sha256:d2f7e2b43dd4
- cite: plugins/ok/families/ok-planner/scripts/audit-check :: "--list-stale prints only the artifact refs (kind:slug) needing"
- cite: plugins/ok/families/ok-planner/skills/_shared/implementation-auditor.md :: "the auditor is always a fresh dispatch, never the session that implemented the work under audit"
- cite: plugins/ok/families/ok-planner/skills/_shared/certification-core.md :: "The fixer never edits an audit file; it changes code until the re-audit flips the determination"
- cite: plugins/ok/families/ok-planner/skills/certify-work/SKILL.md :: "The **re-audit set** is the union of: the touched stories and decisions, every ref the checker lists"
- cite: plugins/ok/families/ok-planner/skills/certify-all/SKILL.md :: "the full gate re-derives every determination fresh, not just the stale ones"
- cite: plugins/ok/families/ok-planner/skills/_shared/artifact-definitions.md :: "**Decisions are audited, not proof-mandated.**"
- cite: plugins/ok/families/ok-planner/skills/prove/SKILL.md :: "Decisions carry no proofs; their verification is the implementation audit."
- cite-file: .ok-planner/design/stories.md @ sha256:25682d5ab708
