---
closed: 0b1b2bb2fe4f50d077eae8be5f37a1efb9a838a7
---
# Sprint: Mechanical releases, release-mutable audit masking, one-writer intake

## Intent

Three related corrections and two carried rulings, no manufactured theme. The release act becomes mechanical: it changes only release-mutable metadata plus the commit and tag, verifies itself with deterministic assertions alone, and never runs or re-derives implementation audits — the sole judgment in a release is the semver level, and release notes remain not a thing. To make that true at the mechanism, the audit checker masks release-mutable metadata (the suite-version stamp lines, the manifest version fields) before hashing anything a citation or pin covers, so a version bump voids no audit. The two accepted recommended rulings from the intake land as corpus rewrites: the corpus-checking verbs are both pure in-context reporters and certification's architect is the intake's one gated agent writer (`audit-verb-intake-channel`), and the shared canonical text layer is committed to as a directory of canonical files with per-block uniqueness (`shared-canonical-text-file-count`).

Issues promoted into this sprint: `audit-verb-intake-channel`, `shared-canonical-text-file-count`.

## Corpus deltas

### Amend decision: adversarial-implementation-audits

```markdown
---
decision: adversarial-implementation-audits
---

# Implementation claims are verified by adversarial audits, not test mandates

## Choice

Whether the project implements what a story or decision claims is determined by an adversarial implementation audit: a durable, per-artifact determination (`satisfied` or `violated`) recorded in a fourth corpus collection, written only by a certification producer that did not implement the work under audit, and never hand-edited. Audits cite code by content anchors and pin quantified claims' population sources by file hash; a deterministic checker flags any audit whose design artifact, cited code, or population source has changed, and the stale set — not human memory — is what gets re-audited. The checker masks release-mutable metadata — the suite-version stamp lines materialization writes and the plugin manifests' version fields — before hashing anything a citation or pin covers, so a release that changes only versions voids no audit. Stories additionally carry deterministic integration-test proofs; decisions carry no test obligation. A negative determination stands in place until a re-audit flips it, and blocks certification unless linked to an intake issue awaiting the owner's ruling.

## Rationale

The claims that go wrong in practice are disproportionately structural, negative, or quantified — a transport a decision's text never reached, a rationale selling a property nothing delivers, an "every" enforced on the members someone remembered — and for those the honest verification is an adversarial reading against reality, with the population enumerated from the compose file or route table rather than from the artifact's own examples. Mandating a test per claim buys determinism at the cost of test-side machinery per claim and still misses the claims that are not runtime-observable; an audit covers every normative sentence at the cost of trusting a reader, and that trust is bounded three ways: the reader is never the author of the work, the determination is a signed, citation-carrying record that can be re-derived and compared, and staleness is mechanical — the fixer cannot satisfy an audit by any means except changing the code it cites, which breaks its anchors and forces a fresh adversarial read. Content anchors rather than line numbers make the tripwire survive unrelated edits; whole-file pins on population sources make a new member re-open the exact audits whose quantifiers it threatens. Version stamps sit inside otherwise-cited bytes and must change on every release, so masking them is what keeps the tripwire meaningful: staleness signals substantive change, never the release act, while any edit beyond the masked patterns still breaks its anchor.

## Alternatives

- Test mandates with registered falsifier exhibits per claim — deterministic and unfoolable where it applies, but a per-claim authoring and maintenance layer, and structurally blind to claims that live in rationale text, titles, and concept invariants.
- Read-and-judge review without durable records — catches the same class once, but leaves nothing to go stale, so nothing triggers the re-read when the code moves.
- Diff-scoped review as the only reader — reviews the change, so a claim whose code was never written produces nothing to review; absence has no diff.
- Hashing stamped bytes as-is and re-auditing at release time — every release voids whichever audits cite stamped files and buys an agentic re-read that can only confirm version strings changed.
```

### Amend decision: lockstep-suite-version

```markdown
---
decision: lockstep-suite-version
---

# One suite version across all plugin manifests

## Choice

Every plugin manifest carries the same semantic version at every release, bumped together at the highest level any change in the suite warrants, with one annotated repo-wide tag per release cut by the repo-local release skill; the carried family payload is stamped with that same suite version wherever it materializes. The release act itself is mechanical: it changes only release-mutable metadata — the manifest version fields and the stamps a re-converge rewrites — plus the release commit and tag, verifies itself with deterministic assertions alone (manifest equality, remote installability), and neither runs nor re-derives implementation audits; the sole judgment a release holds is the semver level. A release is done only when the release commit is reachable from the remote default branch and the tag points at it. Between releases manifests may drift while work is in flight; the release converges them. The conduct's version is the one carve-out: hand-managed and untouched by a release.

## Rationale

The plugins and the families they carry are designed as a set — one integration contract, one administrator, and a change in one family routinely implies a change in another. A shared number is what makes "which versions work together" answerable; re-fetching identical files for an unchanged plugin costs nothing because the version is the harness's update key, and equality at release time is the property consumers actually depend on. Correctness is established where it belongs, at certification: by release time the tree is already certified, so any verification beyond deterministic assertions would re-buy what the gates already paid for, at the moment of least new information.

## Alternatives

- Independent semver per plugin or per family — drifting numbers make compatibility a question nobody can answer.
- Rejecting mid-cycle drift outright — turns a benign pre-release hand-bump into a release blocker for no consumer-visible gain.
- Per-plugin release tags — gives tag-based tooling an ambiguous answer for the repo.
- A release gate that re-audits or re-certifies — duplicates certification's work inside an act whose whole value is being cheap, repeatable, and mechanical.
```

### Amend decision: prove-audit-audience-split

```markdown
---
decision: prove-audit-audience-split
---

# Both corpus-checking verbs report in-context; the architect is the intake's one gated writer

## Choice

The two corpus-checking verbs are pure in-context reporters distinguished by audience: the proof run reports to the executing agent at machine tempo, and the audit reports to its caller — the human who invoked it, or the certification gate consuming it as a producer — with every finding classified mechanical or judgment. Neither verb writes the issue intake. The intake has exactly one gated agent writer: certification's architect, filing only findings that survived the fixer's veto test and its own adversarial check; humans file directly whenever they choose. The owner's durable, deduplicated agenda is a property of that promotion gate — deduplication against the slugs already present, adversarial confirmation before anything costs owner attention — never of either reporting verb.

## Rationale

The split keeps execution unblocked and the owner uninterrupted: an executing agent needs findings now, in context, at machine tempo, while the owner's queue must stay an owner-calibrated worklist. Routing every agent write through one adversarial gate is what keeps the intake meaning "requires owner calibration" — a reporting verb that also files would be a second, ungated writer whose every run can grow the queue without anything checking that a reasonable owner would want to read it. A standalone audit's judgment findings still reach the owner: the human who ran it is holding the report, and reading it is the calibration act — what they judge fork-worthy, they file.

## Alternatives

- One verb doing both — every execution-time finding becomes intake noise, and owner questions get buried in agent triage.
- Both verbs writing the intake — the intake stops meaning "requires owner calibration" by construction.
- The audit filing its own judgment class — preserves a durable agenda from standalone runs, but reintroduces ungated agent writes and duplicates the promotion gate's dedup and confirmation outside it.
```

### Amend story: corpus-audit

```markdown
---
story: corpus-audit
---

# Audit the corpus and report the judgment calls

## Story

As a project owner, I want the whole design corpus periodically checked for compliance, proof coverage, intent drift, and cross-artifact conflict, with every finding returned to me classified as mechanical or judgment, so that design rot surfaces the moment I ask instead of accumulating silently.

## Acceptance

The audit runs over a project with a corpus → the caller receives one in-context report: mechanical findings to fix in-cycle, judgment findings classified for the owner's calibration; nothing anywhere is written — the verb is read-only against corpus, code, and intake alike, and it never executes proofs. What the caller does with the report is the caller's: a human files what they judge fork-worthy, and the certification gate drains it through its review-fix loop. The four-pass audit (compliance, coverage-and-drift, cross-artifact consistency, surface inventory) is real.

## Falsifier

Corpus muddiness or a claim that outran the code passes without a finding; the audit fixes artifacts itself; the run writes anything — the intake included; or the mechanical/judgment classification is missing, so the owner cannot tell calibration questions from mechanical debris.

## Proof

Demo — an audit over a corpus seeded with a known compliance violation, an uncovered claim, and a cross-artifact contradiction, after which a third party finds all three in the caller's report with the judgment items classified as such, and the working tree — intake included — unchanged.
```

### Amend decision: single-source-transclusion

```markdown
---
decision: single-source-transclusion
---

# Canonical rule text lives once and is transcluded into prompts

## Choice

Every canonical definition, template, and rule the planner's skills share is defined exactly once, in one shared directory of canonical files — the artifact definitions, the shared reviewer prompt, the certification core, the dispatch discipline, the implementation-auditor prompt — and skill prompts pull each block in by named double-braced token, replaced at dispatch-assembly time by the running model; skills running in the main loop reference the shared files directly instead of restating them. Definitions are never restated inline in a skill, and no block is defined in more than one place.

## Rationale

The writer, the checker, and the mutator of the same artifact kind each see only their own dispatched prompt; defining the rules once and transcluding keeps the wording from drifting between the agent that writes and the agent that checks. Editorially, one place per block is what keeps canonical wording canonical — and it is the property the maintenance check enforces: every token used under the planner's skills must resolve to exactly one heading in the shared directory, so silent duplication fails the build.

## Alternatives

- Restate rules per skill — guaranteeing drift between authoring and reviewing prompts.
- Build-time template assembly — requires a build step in a plugin family that deliberately ships none.
- One monolithic definitions file — makes the file-count claim trivially checkable at the cost of folding a certification prompt library into the definitions file, buying nothing the per-block uniqueness check does not already guarantee.
```

## Work items

Flat and unordered; each names the artifacts it makes true. Dependencies are stated where real.

- **Release-mutable masking in the audit checker** (`decision:adversarial-implementation-audits`): the checker normalizes release-mutable metadata before hashing anything a `cite:`, `cite-span:`, or `cite-file:` covers — the `Materialized by <name> vX.Y.Z` stamp lines, `VERSION` stamp assignments in materialized executables, and the plugin manifests' `"version"` fields — so a version-only change leaves the stale set empty while any other edit still trips the anchor. The checker's test harness gains a fixture case proving a version bump alone reports nothing stale and a substantive edit beside a masked stamp still does. The materialized copy re-converges.
- **Mechanical release skill** (`decision:lockstep-suite-version`): the release skill's procedure runs no audit and re-derives nothing agentic — its verification is exactly the deterministic assertions (manifest equality, remote installability); the dogfood re-converge that re-stamps materialized artifacts is documented as a mechanical release step; the semver judgment is named as the release's only judgment; release notes remain not produced.
- **One-writer channel rewrite** (`decision:prove-audit-audience-split`, `story:corpus-audit`): the two deltas applied; the audit skill's report format carries the mechanical/judgment classification the story promises; a proof artifact for `story:corpus-audit` is written against the restated Proof field (seeded corpus, three findings in the report, judgment items classified, tree unchanged) and annotated `@story: corpus-audit`.
- **Shared-layer redescription** (`decision:single-source-transclusion`): the delta applied; no code change — the token-resolution check already enforces per-block uniqueness across the shared directory.
- **Catalog refresh** (all deltas): the decision and story TOC lines regenerate for the amended artifacts.

## How to execute this sprint

This sprint is self-sufficient. Whoever executes it — an inline
working session, an agent this file is handed to via the native
`goal` mechanism, or an orchestrator that does its own planning —
proceeds the same way.

1. Read the sprint whole first — intent, deltas, work items,
   completion contract — before touching anything. Do not go looking
   for context behind it (not in the issue intake under
   `.ok-planner/issues/`, not in `history/`). The sprint is
   self-sufficient by construction; a genuine gap is raised with the
   owner, never filled by inference.

2. Stage the work. The items above are a flat, unordered list; group
   them by theme, file surface, or dependency and order the groups so
   nothing is built on something not yet there. Staging lives in the
   executor's working state — a task list, an orchestrator's graph.
   It is never rewritten into a plan document: this sprint is the
   whole brief.

3. Apply each corpus delta as part of the work that realizes it —
   copy the final-form body into `.ok-planner/design/` verbatim, or
   delete the file for a retirement. A delta no work item implements
   (a clarification, a retirement) is applied on its own.

4. Build stage by stage. Every new or amended story gets its proof: a
   deterministic integration test (or demo) present, carrying its
   `@story:` annotation, and able to actually fail under the story's
   falsifier. Write the proof with the work, not at the end. Decisions
   carry no proofs — a decision's verification is the implementation
   audit certification writes.

5. Completeness is the floor. Never stub, defer, narrow, no-op, or
   leave a `TODO` in place of a promised outcome. A capability the
   deltas or work items promise is delivered in full, or the blocker
   that prevents it is surfaced — never silently dropped.

6. Never destroy uncommitted work. Stage progress as each stage
   finishes (`git add -A`) so a stray revert cannot reach it. Do not
   run `git checkout`/`restore`/`reset`/`stash`/`clean` on your own
   initiative; fix a bad edit forward by editing again.

7. Work unsupervised to a defensible done — no pausing for approval,
   confirmation, or progress checks. Stop only on a genuine blocker:
   a credential or access that cannot be obtained, a step literally
   impossible in the current state, or a destructive/irreversible
   action not clearly authorized. Ambiguity is not a blocker — pick
   the most plausible reading and continue, surfacing the choice at
   the end. (An orchestrator that supervises its own executors folds
   this into its own control.)

8. Close by running `/certify-work`. It brings the work into
   alignment with this sprint and discharges the completion contract
   below at the change's own scope: `/prove` over the touched
   stories and decisions, change-scoped corpus checks over the
   touched artifacts and annotations, code review over the diff —
   all producers feeding a no-discretion review-fix loop (a fixer
   fixes everything a reasonable owner would wave through; an
   architect adversarially checks its kickbacks, fixing the refuted
   and promoting only genuine intent forks to the issue intake),
   and the outcomes and divergences are presented to the owner.
   (Whole-corpus certification is `/certify-all`, run on the owner's
   cadence, not per close.) The goal is to finish the work: this
   file stays in `sprints/` through the presentation (so a stop
   condition keyed to its path can verify completion against it),
   and `/certify-work` ends by offering the close-out — archiving
   this sprint and the issue files it resolved to `history/`, and
   committing the work — performed only on the owner's word. The
   close-out then stamps the archived sprint's frontmatter with
   the closing commit (`closed: <sha>`, one small follow-on
   commit): the baseline the next planning ceremony uses to
   detect work done out of band.

## Completion contract

The work is not done until all of the following hold:

1. The design corpus matches every delta above (applied verbatim).
2. `/prove` returns clean over all new and touched stories: every
   registered proof present, passing, and runnable.
3. The implementation-audit corpus is current for everything the
   change touched or made stale, with any standing violation linked
   to an intake issue.
4. `/certify-work`'s review-fix loop has been run last and come
   back clean: every finding fixed, with only architect-confirmed
   intent forks promoted to `.ok-planner/issues/` and verified
   ruling-ready for the next sprint.
